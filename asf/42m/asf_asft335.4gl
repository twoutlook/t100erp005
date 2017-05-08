#該程式未解開Section, 採用最新樣板產出!
{<section id="asft335.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0039(2016-12-07 09:46:57), PR版次:0039(2017-03-23 12:16:29)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000595
#+ Filename...: asft335
#+ Description: 報工單維護作業-單筆式
#+ Creator....: 00537(2013-11-21 14:26:29)
#+ Modifier...: 05426 -SD/PR- TOPSTD
 
{</section>}
 
{<section id="asft335.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#151110-00002#2...: 2015/11/17 BY fionchen 於AFTER FIELD sffb017增加控管報工時若該工單+Rucnard+作業編號+製程序需PQC,則需控管良品數量不可大於PQC合格數量-已報工良品量
#160318-00025#34..: 2016/04/14 BY pengxin  將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#160523-00043.....: 2016/07/28 By whitney  add asft330_03
#160818-00017#36..: 2016/08/28 By lixh     单据类作业修改，删除时需重新检查状态
#161014-00030#1...: 2016/10/14 By Mandy    輸入時工單單號開窗查詢-加上製程否='Y'的條件q_sfaadocno_18
#161013-00051#1...: 2016/10/18 By shiun    整批調整據點組織開窗
#161014-00030#1...: 2016/10/20 By Whitney  還原161014-00030#1的調整
#161028-00053#1...: 2016/10/28 By Sarah    sffb030的i段開窗需要傳參arg1
#161029-00007#1...: 2016/10/29 By Mandy    作業人員不可為0,有控卡上的漏洞修正
#161103-00007#1...: 2016/11/03 By shiun    调整PQC与报工的顺序，目前系统是先PQC再报工，要调整为先报工再PQC
#                                          1、目前有勾选PQC的制程站，asft335报工时会检查该站PQC合格量，合格多少才可报工多少，这个逻辑拿掉
#                                          2、asft335报工类别为3.报工时，单据审核回写asft301的逻辑要增加（类似checkout、moveout的写法）
#                                            a.如果asft301对应制程站PQC有勾选，应将本次报工数量追加到待PQC数量；取消审核时恢复待PQC数量
#                                            b.单据取消审核时需先检查此报工单是否有对应的PQC检验单（aqct300），若有则不可取消审核
#160826-00025#1...: 2016/11/18 By dorislai 1.新增action「產生完工入庫單」
#                                          2.確認時，若是最後一個製程站、最後一個報工點，自動產生完工入庫單(asft340) [報工點順序:報工→Check out→Move out]
#                                            (備註：完工入庫單的產生，應不影響確認的結果)
#161123-00033#1...: 2016/12/06 By dorislai 修正當工時，沒有上一站，取出的數值為0，不需覆蓋掉原本輸入的值，以及錯誤訊息(asf-00749)的提示數量
#160824-00007#216.: 2016/11/30 By sakura   新舊值備份處理
#161202-00018#1     2016/12/07 By liuym    调整逻辑：管控工时、机时栏位值不小于0；报工完成日期不可小于工单单据日期；删除报工单时，一并删除作业明细资料；完成时间管控在00:00~23:59
#161208-00044#1...: 2016/12/09 By Whitney  單別參數判斷是否自動產生完工入庫單
#161130-00008#1     2016/12/12 By liuym    新增状态下，不允许维护作业人员明细资料，报工单号尚未编码，维护人员明细会出现直插入单据别的资料，导致无法关联
#161212-00048#1...: 2016/12/09 By Whitney  单号160826-00025增加的功能进行调整
#161214-00011#1     2016/12/15 By liuym    asft335作废单据时，将asft337对应单据删除；取消审核时，如果asft337不是未审核状态，需要先取消asft337审核
#161215-00055#1...: 2016/12/19 By Whitney  狀態碼變更使用彙總訊息
#170117-00038#1...: 2017/01/18 By Whitney  調整s_asft335_chk_qty()傳入參數
#170120-00043#1...: 2017/01/23 By Whitney  s_asft335_chk_qty()增加傳入參數報工類別
#170209-00018#1...: 2017/02/09 By Whitney  修正#170120-00043#1
#170213-00031#1...: 2017/02/15 By shiun    若為重工則不產生完工入庫
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
PRIVATE type type_g_sffb_m        RECORD
       sffbdocno LIKE sffb_t.sffbdocno, 
   sffbseq LIKE sffb_t.sffbseq, 
   sffb001 LIKE sffb_t.sffb001, 
   sffb002 LIKE sffb_t.sffb002, 
   sffb002_desc LIKE type_t.chr80, 
   sffbdocno_desc LIKE type_t.chr80, 
   sffbdocdt LIKE sffb_t.sffbdocdt, 
   sffb003 LIKE sffb_t.sffb003, 
   sffb003_desc LIKE type_t.chr80, 
   sffbsite LIKE sffb_t.sffbsite, 
   sffbstus LIKE sffb_t.sffbstus, 
   sffb005 LIKE sffb_t.sffb005, 
   sffb006 LIKE sffb_t.sffb006, 
   sffb007 LIKE sffb_t.sffb007, 
   sffb007_desc LIKE type_t.chr80, 
   sffb008 LIKE sffb_t.sffb008, 
   sffb029 LIKE sffb_t.sffb029, 
   sffb029_desc LIKE type_t.chr80, 
   sffb029_desc_1 LIKE type_t.chr80, 
   sffb009 LIKE sffb_t.sffb009, 
   sffb009_desc LIKE type_t.chr80, 
   sffb030 LIKE sffb_t.sffb030, 
   sffb030_desc LIKE type_t.chr80, 
   sffb004 LIKE sffb_t.sffb004, 
   sffb004_desc LIKE type_t.chr80, 
   sffb010 LIKE sffb_t.sffb010, 
   sffb010_desc LIKE type_t.chr80, 
   sffb024 LIKE sffb_t.sffb024, 
   sffb024_desc LIKE type_t.chr80, 
   sffb011 LIKE sffb_t.sffb011, 
   sffb012 LIKE sffb_t.sffb012, 
   sffb013 LIKE sffb_t.sffb013, 
   sffb014 LIKE sffb_t.sffb014, 
   sffb015 LIKE sffb_t.sffb015, 
   qty LIKE type_t.num20_6, 
   sffb016 LIKE sffb_t.sffb016, 
   sffb017 LIKE sffb_t.sffb017, 
   sffb018 LIKE sffb_t.sffb018, 
   sffb019 LIKE sffb_t.sffb019, 
   sffb020 LIKE sffb_t.sffb020, 
   sffbownid LIKE sffb_t.sffbownid, 
   sffbownid_desc LIKE type_t.chr80, 
   sffbowndp LIKE sffb_t.sffbowndp, 
   sffbowndp_desc LIKE type_t.chr80, 
   sffbcrtid LIKE sffb_t.sffbcrtid, 
   sffbcrtid_desc LIKE type_t.chr80, 
   sffbcrtdp LIKE sffb_t.sffbcrtdp, 
   sffbcrtdp_desc LIKE type_t.chr80, 
   sffbcrtdt LIKE sffb_t.sffbcrtdt, 
   sffbmodid LIKE sffb_t.sffbmodid, 
   sffbmodid_desc LIKE type_t.chr80, 
   sffbmoddt LIKE sffb_t.sffbmoddt, 
   sffbcnfid LIKE sffb_t.sffbcnfid, 
   sffbcnfid_desc LIKE type_t.chr80, 
   sffbcnfdt LIKE sffb_t.sffbcnfdt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_sffd_d        RECORD
       sffdseq1 LIKE sffd_t.sffdseq1, 
   sffd001 LIKE sffd_t.sffd001, 
   sffd001_desc LIKE type_t.chr500, 
   sffd002 LIKE sffd_t.sffd002, 
   sffd003 LIKE sffd_t.sffd003
       END RECORD
PRIVATE TYPE type_g_sffd2_d RECORD
       sffc001 LIKE sffc_t.sffc001, 
   sffc001_desc LIKE type_t.chr500, 
   sffc002 LIKE sffc_t.sffc002, 
   sffc003 LIKE sffc_t.sffc003, 
   sffc004 LIKE sffc_t.sffc004, 
   sffc005 LIKE sffc_t.sffc005, 
   sffc006 LIKE sffc_t.sffc006
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_sffbdocno LIKE sffb_t.sffbdocno,
   b_sffbdocno_desc LIKE type_t.chr80,
      b_sffbseq LIKE sffb_t.sffbseq,
      b_sffb001 LIKE sffb_t.sffb001,
      b_sffbdocdt LIKE sffb_t.sffbdocdt,
      b_sffb002 LIKE sffb_t.sffb002,
   b_sffb002_desc LIKE type_t.chr80,
      b_sffb003 LIKE sffb_t.sffb003,
   b_sffb003_desc LIKE type_t.chr80
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_doc_slip            LIKE sffb_t.sffbdocno
#end add-point
       
#模組變數(Module Variables)
DEFINE g_sffb_m          type_g_sffb_m
DEFINE g_sffb_m_t        type_g_sffb_m
DEFINE g_sffb_m_o        type_g_sffb_m
DEFINE g_sffb_m_mask_o   type_g_sffb_m #轉換遮罩前資料
DEFINE g_sffb_m_mask_n   type_g_sffb_m #轉換遮罩後資料
 
   DEFINE g_sffbdocno_t LIKE sffb_t.sffbdocno
DEFINE g_sffbseq_t LIKE sffb_t.sffbseq
 
 
DEFINE g_sffd_d          DYNAMIC ARRAY OF type_g_sffd_d
DEFINE g_sffd_d_t        type_g_sffd_d
DEFINE g_sffd_d_o        type_g_sffd_d
DEFINE g_sffd_d_mask_o   DYNAMIC ARRAY OF type_g_sffd_d #轉換遮罩前資料
DEFINE g_sffd_d_mask_n   DYNAMIC ARRAY OF type_g_sffd_d #轉換遮罩後資料
DEFINE g_sffd2_d          DYNAMIC ARRAY OF type_g_sffd2_d
DEFINE g_sffd2_d_t        type_g_sffd2_d
DEFINE g_sffd2_d_o        type_g_sffd2_d
DEFINE g_sffd2_d_mask_o   DYNAMIC ARRAY OF type_g_sffd2_d #轉換遮罩前資料
DEFINE g_sffd2_d_mask_n   DYNAMIC ARRAY OF type_g_sffd2_d #轉換遮罩後資料
 
 
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
 
{<section id="asft335.main" >}
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
   CALL cl_ap_init("asf","")
 
   #add-point:作業初始化 name="main.init"
         
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
         
   #end add-point
   LET g_forupd_sql = " SELECT sffbdocno,sffbseq,sffb001,sffb002,'','',sffbdocdt,sffb003,'',sffbsite, 
       sffbstus,sffb005,sffb006,sffb007,'',sffb008,sffb029,'','',sffb009,'',sffb030,'',sffb004,'',sffb010, 
       '',sffb024,'',sffb011,sffb012,sffb013,sffb014,sffb015,'',sffb016,sffb017,sffb018,sffb019,sffb020, 
       sffbownid,'',sffbowndp,'',sffbcrtid,'',sffbcrtdp,'',sffbcrtdt,sffbmodid,'',sffbmoddt,sffbcnfid, 
       '',sffbcnfdt", 
                      " FROM sffb_t",
                      " WHERE sffbent= ? AND sffbdocno=? AND sffbseq=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
         
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE asft335_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.sffbdocno,t0.sffbseq,t0.sffb001,t0.sffb002,t0.sffbdocdt,t0.sffb003, 
       t0.sffbsite,t0.sffbstus,t0.sffb005,t0.sffb006,t0.sffb007,t0.sffb008,t0.sffb029,t0.sffb009,t0.sffb030, 
       t0.sffb004,t0.sffb010,t0.sffb024,t0.sffb011,t0.sffb012,t0.sffb013,t0.sffb014,t0.sffb015,t0.sffb016, 
       t0.sffb017,t0.sffb018,t0.sffb019,t0.sffb020,t0.sffbownid,t0.sffbowndp,t0.sffbcrtid,t0.sffbcrtdp, 
       t0.sffbcrtdt,t0.sffbmodid,t0.sffbmoddt,t0.sffbcnfid,t0.sffbcnfdt,t1.ooag011 ,t2.ooefl003 ,t3.oocql004 , 
       t5.ecaa002 ,t6.ooefl003 ,t7.oogd002 ,t8.mrba004 ,t9.ooge002 ,t10.ooag011 ,t11.ooefl003 ,t12.ooag011 , 
       t13.ooefl003 ,t14.ooag011 ,t15.ooag011",
               " FROM sffb_t t0",
                              " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.sffb002  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.sffb003 AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oocql_t t3 ON t3.oocqlent="||g_enterprise||" AND t3.oocql001='221' AND t3.oocql002=t0.sffb007 AND t3.oocql003='"||g_dlang||"' ",
               " LEFT JOIN ecaa_t t5 ON t5.ecaaent="||g_enterprise||" AND t5.ecaasite=t0.sffbsite AND t5.ecaa001=t0.sffb009  ",
               " LEFT JOIN ooefl_t t6 ON t6.ooeflent="||g_enterprise||" AND t6.ooefl001=t0.sffb030 AND t6.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oogd_t t7 ON t7.oogdent="||g_enterprise||" AND t7.oogdsite=t0.sffbsite AND t7.oogd001=t0.sffb004  ",
               " LEFT JOIN mrba_t t8 ON t8.mrbaent="||g_enterprise||" AND t8.mrbasite=t0.sffbsite AND t8.mrba001=t0.sffb010  ",
               " LEFT JOIN ooge_t t9 ON t9.oogeent="||g_enterprise||" AND t9.oogesite=t0.sffbsite AND t9.ooge001=t0.sffb024  ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.sffbownid  ",
               " LEFT JOIN ooefl_t t11 ON t11.ooeflent="||g_enterprise||" AND t11.ooefl001=t0.sffbowndp AND t11.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t12 ON t12.ooagent="||g_enterprise||" AND t12.ooag001=t0.sffbcrtid  ",
               " LEFT JOIN ooefl_t t13 ON t13.ooeflent="||g_enterprise||" AND t13.ooefl001=t0.sffbcrtdp AND t13.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t14 ON t14.ooagent="||g_enterprise||" AND t14.ooag001=t0.sffbmodid  ",
               " LEFT JOIN ooag_t t15 ON t15.ooagent="||g_enterprise||" AND t15.ooag001=t0.sffbcnfid  ",
 
               " WHERE t0.sffbent = " ||g_enterprise|| " AND t0.sffbdocno = ? AND t0.sffbseq = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE asft335_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
                  
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_asft335 WITH FORM cl_ap_formpath("asf",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL asft335_init()   
 
      #進入選單 Menu (="N")
      CALL asft335_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
                  
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_asft335
      
   END IF 
   
   CLOSE asft335_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_asft335_drop_tmp_table()  #161212-00048#1
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="asft335.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION asft335_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
DEFINE l_success    LIKE type_t.num5  #161212-00048#1
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
      CALL cl_set_combo_scc_part('sffbstus','13','N,Y,A,D,R,W,X')
 
      CALL cl_set_combo_scc('sffb001','4021') 
   CALL cl_set_combo_scc('sffc002','1201') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_scc('sffb001','4020')
   CALL asft335_set_sffb013_format()
   CALL cl_set_combo_scc('b_sffb001','4020')
   CALL s_asft335_cre_tmp_table() RETURNING l_success  #161212-00048#1
   #end add-point
   
   #初始化搜尋條件
   CALL asft335_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="asft335.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION asft335_ui_dialog()
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
   DEFINE l_wc       STRING
   #160523-00043 by whitney add start
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_sffb011             LIKE sffb_t.sffb011
   DEFINE  l_sffb014             LIKE sffb_t.sffb014
   DEFINE  l_sffb017             LIKE sffb_t.sffb017
   #160523-00043 by whitney add end
#161212-00048#1-s mark
#   #160826-00025#1-s-add
#   DEFINE  l_oobn003    LIKE  oobn_t.oobn003   
#   DEFINE  l_sfeadocno  LIKE  sfea_t.sfeadocno 
#   DEFINE l_err_code    LIKE  type_t.chr20
#   #160826-00025#1-e-add
#161212-00048#1-e mark

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
            CALL asft335_insert()
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
         INITIALIZE g_sffb_m.* TO NULL
         CALL g_sffd_d.clear()
         CALL g_sffd2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL asft335_init()
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
               
               CALL asft335_fetch('') # reload data
               LET l_ac = 1
               CALL asft335_ui_detailshow() #Setting the current row 
         
               CALL asft335_idx_chk()
               #NEXT FIELD sffdseq1
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_sffd_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL asft335_idx_chk()
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
               CALL asft335_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
                                             
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
                                    
            #end add-point
               
         END DISPLAY
        
         #第一階單身段落
         DISPLAY ARRAY g_sffd2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL asft335_idx_chk()
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
               CALL asft335_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
                                             
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
                                    
            #end add-point
         
         END DISPLAY
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
                           
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL asft335_browser_fill("")
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
               CALL asft335_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL asft335_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL asft335_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
                                    
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL asft335_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL asft335_set_act_visible()   
            CALL asft335_set_act_no_visible()
            IF NOT (g_sffb_m.sffbdocno IS NULL
              OR g_sffb_m.sffbseq IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " sffbent = " ||g_enterprise|| " AND",
                                  " sffbdocno = '", g_sffb_m.sffbdocno, "' "
                                  ," AND sffbseq = '", g_sffb_m.sffbseq, "' "
 
               #填到對應位置
               CALL asft335_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "sffb_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "sffd_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "sffc_t" 
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
               CALL asft335_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "sffb_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "sffd_t" 
                        LET g_wc2_table1 = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "sffc_t" 
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
                  CALL asft335_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL asft335_fetch("F")
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
               CALL asft335_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL asft335_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL asft335_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL asft335_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL asft335_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL asft335_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL asft335_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL asft335_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL asft335_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL asft335_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL asft335_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_sffd_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_sffd2_d)
                  LET g_export_id[2]   = "s_detail2"
 
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
               NEXT FIELD sffdseq1
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
               CALL asft335_modify()
               #add-point:ON ACTION modify name="menu.modify"
                                             
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL asft335_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
                                             
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION gen_sfea
            LET g_action_choice="gen_sfea"
            IF cl_auth_chk_act("gen_sfea") THEN
               
               #add-point:ON ACTION gen_sfea name="menu.gen_sfea"
               CALL asft335_gen_sfea('Y')  #161212-00048#1
#161212-00048#1-s mark
#               #160826-00025#1-s-add
#               CALL asft335_asft301_chk() RETURNING l_success,l_err_code
#               IF l_success THEN
#                  CALL s_aooi210_get_doc(g_site,'','6',g_sffb_m.sffb005,'asft340','') RETURNING l_success,l_oobn003
#                  IF l_success THEN
#                     CALL s_transaction_begin()
#                     CALL cl_err_collect_init()
#                     CALL s_asft335_gen_sfea(l_oobn003,g_sffb_m.sffb005,g_sffb_m.sffb006) RETURNING l_success,l_sfeadocno
#                     IF l_success THEN
#                        CALL s_transaction_end('Y','0')
#                        #產生成功，是否開啟完工入庫單：%1？
#                        IF cl_ask_confirm_parm('asf-00810',l_sfeadocno) THEN
#                           LET la_param.prog = 'asft340'
#                           LET la_param.param[1] = l_sfeadocno
#                           LET ls_js = util.JSON.stringify(la_param )
#                           CALL cl_cmdrun(ls_js)
#                        END IF
#                     ELSE
#                        CALL s_transaction_end('N','0')
#                     END IF
#                     CALL cl_err_collect_show() 
#                  END IF
#               ELSE
#                  INITIALIZE g_errparam TO NULL 
#                  LET g_errparam.extend = ""
#                  LET g_errparam.code   = l_err_code
#                  LET g_errparam.popup  = TRUE 
#                  CALL cl_err()
#               END IF
#               #160826-00025#1-e-add
#161212-00048#1-e mark
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL asft335_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL asft335_insert()
               #add-point:ON ACTION insert name="menu.insert"
                                             
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               #CALL asfr336_g01("sffbent ="|| g_enterprise ||" AND sffbdocno ='"|| g_sffb_m.sffbdocno||"'",'','','','','')
               LET l_wc = " sffbdocno = '",g_sffb_m.sffbdocno,"'"
               CALL asfr335_g01(l_wc)
               #END add-point
               &include "erp/asf/asft335_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               #CALL asfr336_g01("sffbent ="|| g_enterprise ||" AND sffbdocno ='"|| g_sffb_m.sffbdocno||"'",'','','','','')
               LET l_wc = " sffbdocno = '",g_sffb_m.sffbdocno,"'"
               CALL asfr335_g01(l_wc)
               #END add-point
               &include "erp/asf/asft335_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL asft335_reproduce()
               #add-point:ON ACTION reproduce name="menu.reproduce"
                                             
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION asft330_03
            LET g_action_choice="asft330_03"
            IF cl_auth_chk_act("asft330_03") THEN
               
               #add-point:ON ACTION asft330_03 name="menu.asft330_03"
               #160523-00043 by whitney add start
               CALL s_transaction_begin()
               CALL asft330_03(g_sffb_m.sffbdocno,g_sffb_m.sffbseq,g_sffb_m.sffb011,g_sffb_m.sffb014,g_sffb_m.sffb017)
                    RETURNING l_success,l_sffb011,l_sffb014,l_sffb017
               IF l_success THEN
                  UPDATE sffb_t
                     SET sffb011 = l_sffb011,
                         sffb014 = l_sffb014,
                         sffb017 = l_sffb017
                   WHERE sffbent = g_enterprise
                     AND sffbdocno = g_sffb_m.sffbdocno
                     AND sffbseq = g_sffb_m.sffbseq
                  CASE
                     WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "sffb_t" 
                        LET g_errparam.code   = "std-00009" 
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                     WHEN SQLCA.sqlcode #其他錯誤
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.extend = "sffb_t:",SQLERRMESSAGE 
                        LET g_errparam.code   = SQLCA.sqlcode 
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                     OTHERWISE
                  END CASE
                  LET g_sffb_m.sffb011 = l_sffb011
                  LET g_sffb_m.sffb014 = l_sffb014
                  LET g_sffb_m.sffb017 = l_sffb017
                  DISPLAY BY NAME g_sffb_m.sffb011,g_sffb_m.sffb014,g_sffb_m.sffb017
                  CALL s_transaction_end('Y','0')
               ELSE
                  CALL s_transaction_end('N','0')
               END IF
               #160523-00043 by whitney add end
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL asft335_query()
               #add-point:ON ACTION query name="menu.query"
                        
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION call_asft337
            LET g_action_choice="call_asft337"
            IF cl_auth_chk_act("call_asft337") THEN
               
               #add-point:ON ACTION call_asft337 name="menu.call_asft337"
               CALL asft335_call_asft337()
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL asft335_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL asft335_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL asft335_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_sffb_m.sffbdocdt)
 
 
 
         
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
 
{<section id="asft335.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION asft335_browser_fill(ps_page_action)
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
   IF cl_null(g_wc) THEN
      LET g_wc = " sffbsite = '",g_site,"' AND sffb005 IS NOT NULL AND sffb025 IS NULL "
   ELSE
      LET g_wc = g_wc," AND sffbsite = '",g_site,"' AND sffb005 IS NOT NULL AND sffb025 IS NULL "
   END IF 
   LET l_wc  = g_wc.trim() 
   LET l_wc2 = g_wc2.trim()
   #end add-point
   
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件                      
      LET l_sub_sql = " SELECT DISTINCT sffbdocno,sffbseq ",
                      " FROM sffb_t ",
                      " ",
                      " LEFT JOIN sffd_t ON sffdent = sffbent AND sffbdocno = sffddocno AND sffbseq = sffdseq ", "  ",
                      #add-point:browser_fill段sql(sffd_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
                      " LEFT JOIN sffc_t ON sffcent = sffbent AND sffbdocno = sffcdocno AND sffbseq = sffcseq", "  ",
                      #add-point:browser_fill段sql(sffc_t1) name="browser_fill.cnt.join.sffc_t1"
                      
                      #end add-point
 
 
 
                      " ", 
                      " ", 
                      " ",                      
 
 
 
                      " WHERE sffbent = " ||g_enterprise|| " AND sffdent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("sffb_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT sffbdocno,sffbseq ",
                      " FROM sffb_t ", 
                      "  ",
                      "  ",
                      " WHERE sffbent = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("sffb_t")
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
      INITIALIZE g_sffb_m.* TO NULL
      CALL g_sffd_d.clear()        
      CALL g_sffd2_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.sffbdocno,t0.sffbseq,t0.sffb001,t0.sffbdocdt,t0.sffb002,t0.sffb003 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.sffbstus,t0.sffbdocno,t0.sffbseq,t0.sffb001,t0.sffbdocdt,t0.sffb002, 
          t0.sffb003,t1.ooag011 ,t2.ooefl003 ",
                  " FROM sffb_t t0",
                  "  ",
                  "  LEFT JOIN sffd_t ON sffdent = sffbent AND sffbdocno = sffddocno AND sffbseq = sffdseq ", "  ", 
                  #add-point:browser_fill段sql(sffd_t1) name="browser_fill.join.sffd_t1"
                  
                  #end add-point
                  "  LEFT JOIN sffc_t ON sffcent = sffbent AND sffbdocno = sffcdocno AND sffbseq = sffcseq", "  ", 
                  #add-point:browser_fill段sql(sffc_t1) name="browser_fill.join.sffc_t1"
                  
                  #end add-point
 
 
 
                  " ", 
                  " ",                      
 
 
 
                                 " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.sffb002  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.sffb003 AND t2.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.sffbent = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("sffb_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.sffbstus,t0.sffbdocno,t0.sffbseq,t0.sffb001,t0.sffbdocdt,t0.sffb002, 
          t0.sffb003,t1.ooag011 ,t2.ooefl003 ",
                  " FROM sffb_t t0",
                  "  ",
                                 " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=t0.sffb002  ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.sffb003 AND t2.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.sffbent = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("sffb_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   
   #end add-point
   LET g_sql = g_sql, " ORDER BY sffbdocno,sffbseq ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
         
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"sffb_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
         
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_sffbdocno,g_browser[g_cnt].b_sffbseq, 
          g_browser[g_cnt].b_sffb001,g_browser[g_cnt].b_sffbdocdt,g_browser[g_cnt].b_sffb002,g_browser[g_cnt].b_sffb003, 
          g_browser[g_cnt].b_sffb002_desc,g_browser[g_cnt].b_sffb003_desc
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
      
         #add-point:browser_fill段reference name="browser_fill.reference"
      LET g_browser[g_cnt].b_sffbdocno_desc = s_aooi200_get_slip_desc(g_browser[g_cnt].b_sffbdocno)
      DISPLAY BY NAME g_browser[g_cnt].b_sffbdocno_desc 
      LET g_browser[g_cnt].b_sffb002_desc = s_desc_get_person_desc(g_browser[g_cnt].b_sffb002)
      DISPLAY BY NAME g_browser[g_cnt].b_sffb002_desc
      LET g_browser[g_cnt].b_sffb003_desc = s_desc_get_department_desc(g_browser[g_cnt].b_sffb003)
      DISPLAY BY NAME g_browser[g_cnt].b_sffb003_desc

         #end add-point
      
         #遮罩相關處理
         CALL asft335_browser_mask()
      
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
   
   IF cl_null(g_browser[g_cnt].b_sffbdocno) THEN
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
 
{<section id="asft335.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION asft335_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
         
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_sffb_m.sffbdocno = g_browser[g_current_idx].b_sffbdocno   
   LET g_sffb_m.sffbseq = g_browser[g_current_idx].b_sffbseq   
 
   EXECUTE asft335_master_referesh USING g_sffb_m.sffbdocno,g_sffb_m.sffbseq INTO g_sffb_m.sffbdocno, 
       g_sffb_m.sffbseq,g_sffb_m.sffb001,g_sffb_m.sffb002,g_sffb_m.sffbdocdt,g_sffb_m.sffb003,g_sffb_m.sffbsite, 
       g_sffb_m.sffbstus,g_sffb_m.sffb005,g_sffb_m.sffb006,g_sffb_m.sffb007,g_sffb_m.sffb008,g_sffb_m.sffb029, 
       g_sffb_m.sffb009,g_sffb_m.sffb030,g_sffb_m.sffb004,g_sffb_m.sffb010,g_sffb_m.sffb024,g_sffb_m.sffb011, 
       g_sffb_m.sffb012,g_sffb_m.sffb013,g_sffb_m.sffb014,g_sffb_m.sffb015,g_sffb_m.sffb016,g_sffb_m.sffb017, 
       g_sffb_m.sffb018,g_sffb_m.sffb019,g_sffb_m.sffb020,g_sffb_m.sffbownid,g_sffb_m.sffbowndp,g_sffb_m.sffbcrtid, 
       g_sffb_m.sffbcrtdp,g_sffb_m.sffbcrtdt,g_sffb_m.sffbmodid,g_sffb_m.sffbmoddt,g_sffb_m.sffbcnfid, 
       g_sffb_m.sffbcnfdt,g_sffb_m.sffb002_desc,g_sffb_m.sffb003_desc,g_sffb_m.sffb007_desc,g_sffb_m.sffb009_desc, 
       g_sffb_m.sffb030_desc,g_sffb_m.sffb004_desc,g_sffb_m.sffb010_desc,g_sffb_m.sffb024_desc,g_sffb_m.sffbownid_desc, 
       g_sffb_m.sffbowndp_desc,g_sffb_m.sffbcrtid_desc,g_sffb_m.sffbcrtdp_desc,g_sffb_m.sffbmodid_desc, 
       g_sffb_m.sffbcnfid_desc
   
   CALL asft335_sffb_t_mask()
   CALL asft335_show()
      
END FUNCTION
 
{</section>}
 
{<section id="asft335.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION asft335_ui_detailshow()
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
 
{<section id="asft335.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION asft335_ui_browser_refresh()
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
      IF g_browser[l_i].b_sffbdocno = g_sffb_m.sffbdocno 
         AND g_browser[l_i].b_sffbseq = g_sffb_m.sffbseq 
 
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
 
{<section id="asft335.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION asft335_construct()
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
   INITIALIZE g_sffb_m.* TO NULL
   CALL g_sffd_d.clear()        
   CALL g_sffd2_d.clear() 
 
   
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
      CONSTRUCT BY NAME g_wc ON sffbdocno,sffb001,sffb002,sffbdocno_desc,sffbdocdt,sffb003,sffbsite, 
          sffbstus,sffb005,sffb006,sffb007,sffb008,sffb029,sffb009,sffb030,sffb004,sffb010,sffb024,sffb011, 
          sffb012,sffb013,sffb014,sffb015,qty,sffb016,sffb017,sffb018,sffb019,sffb020,sffbownid,sffbowndp, 
          sffbcrtid,sffbcrtdp,sffbcrtdt,sffbmodid,sffbmoddt,sffbcnfid,sffbcnfdt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
                                   
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<sffbcrtdt>>----
         AFTER FIELD sffbcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<sffbmoddt>>----
         AFTER FIELD sffbmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<sffbcnfdt>>----
         AFTER FIELD sffbcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<sffbpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.sffbdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffbdocno
            #add-point:ON ACTION controlp INFIELD sffbdocno name="construct.c.sffbdocno"
                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
			   LET g_qryparam.where = " sffb001 BETWEEN '1' AND '5' "
            CALL q_sffbdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sffbdocno  #顯示到畫面上

            NEXT FIELD sffbdocno                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffbdocno
            #add-point:BEFORE FIELD sffbdocno name="construct.b.sffbdocno"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffbdocno
            
            #add-point:AFTER FIELD sffbdocno name="construct.a.sffbdocno"
                                    
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffb001
            #add-point:BEFORE FIELD sffb001 name="construct.b.sffb001"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffb001
            
            #add-point:AFTER FIELD sffb001 name="construct.a.sffb001"
                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.sffb001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffb001
            #add-point:ON ACTION controlp INFIELD sffb001 name="construct.c.sffb001"
                                    
            #END add-point
 
 
         #Ctrlp:construct.c.sffb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffb002
            #add-point:ON ACTION controlp INFIELD sffb002 name="construct.c.sffb002"
                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sffb002  #顯示到畫面上

            NEXT FIELD sffb002                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffb002
            #add-point:BEFORE FIELD sffb002 name="construct.b.sffb002"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffb002
            
            #add-point:AFTER FIELD sffb002 name="construct.a.sffb002"
                                    
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffbdocno_desc
            #add-point:BEFORE FIELD sffbdocno_desc name="construct.b.sffbdocno_desc"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffbdocno_desc
            
            #add-point:AFTER FIELD sffbdocno_desc name="construct.a.sffbdocno_desc"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.sffbdocno_desc
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffbdocno_desc
            #add-point:ON ACTION controlp INFIELD sffbdocno_desc name="construct.c.sffbdocno_desc"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffbdocdt
            #add-point:BEFORE FIELD sffbdocdt name="construct.b.sffbdocdt"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffbdocdt
            
            #add-point:AFTER FIELD sffbdocdt name="construct.a.sffbdocdt"
                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.sffbdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffbdocdt
            #add-point:ON ACTION controlp INFIELD sffbdocdt name="construct.c.sffbdocdt"
                                    
            #END add-point
 
 
         #Ctrlp:construct.c.sffb003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffb003
            #add-point:ON ACTION controlp INFIELD sffb003 name="construct.c.sffb003"
                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sffb003  #顯示到畫面上

            NEXT FIELD sffb003                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffb003
            #add-point:BEFORE FIELD sffb003 name="construct.b.sffb003"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffb003
            
            #add-point:AFTER FIELD sffb003 name="construct.a.sffb003"
                                    
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffbsite
            #add-point:BEFORE FIELD sffbsite name="construct.b.sffbsite"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffbsite
            
            #add-point:AFTER FIELD sffbsite name="construct.a.sffbsite"
                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.sffbsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffbsite
            #add-point:ON ACTION controlp INFIELD sffbsite name="construct.c.sffbsite"
                                    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffbstus
            #add-point:BEFORE FIELD sffbstus name="construct.b.sffbstus"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffbstus
            
            #add-point:AFTER FIELD sffbstus name="construct.a.sffbstus"
                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.sffbstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffbstus
            #add-point:ON ACTION controlp INFIELD sffbstus name="construct.c.sffbstus"
                                    
            #END add-point
 
 
         #Ctrlp:construct.c.sffb005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffb005
            #add-point:ON ACTION controlp INFIELD sffb005 name="construct.c.sffb005"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_sfaadocno_17()                  #呼叫開窗
            DISPLAY g_qryparam.return1 TO sffb005  #顯示到畫面上
            NEXT FIELD sffb005                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffb005
            #add-point:BEFORE FIELD sffb005 name="construct.b.sffb005"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffb005
            
            #add-point:AFTER FIELD sffb005 name="construct.a.sffb005"
                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.sffb006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffb006
            #add-point:ON ACTION controlp INFIELD sffb006 name="construct.c.sffb006"
                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_sfca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sffb006  #顯示到畫面上

            NEXT FIELD sffb006                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffb006
            #add-point:BEFORE FIELD sffb006 name="construct.b.sffb006"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffb006
            
            #add-point:AFTER FIELD sffb006 name="construct.a.sffb006"
                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.sffb007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffb007
            #add-point:ON ACTION controlp INFIELD sffb007 name="construct.c.sffb007"
                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = "221" #

            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sffb007  #顯示到畫面上
               #DISPLAY g_qryparam.return2 TO sfcb004 #製程序 

            NEXT FIELD sffb007                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffb007
            #add-point:BEFORE FIELD sffb007 name="construct.b.sffb007"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffb007
            
            #add-point:AFTER FIELD sffb007 name="construct.a.sffb007"
                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.sffb008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffb008
            #add-point:ON ACTION controlp INFIELD sffb008 name="construct.c.sffb008"
                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_sfcb004()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sffb008  #顯示到畫面上

            NEXT FIELD sffb008                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffb008
            #add-point:BEFORE FIELD sffb008 name="construct.b.sffb008"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffb008
            
            #add-point:AFTER FIELD sffb008 name="construct.a.sffb008"
                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.sffb029
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffb029
            #add-point:ON ACTION controlp INFIELD sffb029 name="construct.c.sffb029"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = g_site
            CALL q_imaa001_13()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sffb029  #顯示到畫面上
            NEXT FIELD sffb029                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffb029
            #add-point:BEFORE FIELD sffb029 name="construct.b.sffb029"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffb029
            
            #add-point:AFTER FIELD sffb029 name="construct.a.sffb029"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.sffb009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffb009
            #add-point:ON ACTION controlp INFIELD sffb009 name="construct.c.sffb009"
                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ecaa001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sffb009  #顯示到畫面上

            NEXT FIELD sffb009                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffb009
            #add-point:BEFORE FIELD sffb009 name="construct.b.sffb009"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffb009
            
            #add-point:AFTER FIELD sffb009 name="construct.a.sffb009"
                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.sffb030
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffb030
            #add-point:ON ACTION controlp INFIELD sffb030 name="construct.c.sffb030"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            #add--161013-00051#1 By shiun--(S)
#            CALL q_ooef001()                           #呼叫開窗
            CALL q_ooeg001_8()
            #add--161013-00051#1 By shiun--(E)
            DISPLAY g_qryparam.return1 TO sffb030  #顯示到畫面上
            NEXT FIELD sffb030                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffb030
            #add-point:BEFORE FIELD sffb030 name="construct.b.sffb030"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffb030
            
            #add-point:AFTER FIELD sffb030 name="construct.a.sffb030"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.sffb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffb004
            #add-point:ON ACTION controlp INFIELD sffb004 name="construct.c.sffb004"
                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_oogd001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sffb004  #顯示到畫面上

            NEXT FIELD sffb004                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffb004
            #add-point:BEFORE FIELD sffb004 name="construct.b.sffb004"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffb004
            
            #add-point:AFTER FIELD sffb004 name="construct.a.sffb004"
                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.sffb010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffb010
            #add-point:ON ACTION controlp INFIELD sffb010 name="construct.c.sffb010"
                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_mrba001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sffb010  #顯示到畫面上

            NEXT FIELD sffb010                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffb010
            #add-point:BEFORE FIELD sffb010 name="construct.b.sffb010"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffb010
            
            #add-point:AFTER FIELD sffb010 name="construct.a.sffb010"
                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.sffb024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffb024
            #add-point:ON ACTION controlp INFIELD sffb024 name="construct.c.sffb024"
                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooge001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sffb024  #顯示到畫面上

            NEXT FIELD sffb024                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffb024
            #add-point:BEFORE FIELD sffb024 name="construct.b.sffb024"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffb024
            
            #add-point:AFTER FIELD sffb024 name="construct.a.sffb024"
                                    
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffb011
            #add-point:BEFORE FIELD sffb011 name="construct.b.sffb011"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffb011
            
            #add-point:AFTER FIELD sffb011 name="construct.a.sffb011"
                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.sffb011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffb011
            #add-point:ON ACTION controlp INFIELD sffb011 name="construct.c.sffb011"
                                    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffb012
            #add-point:BEFORE FIELD sffb012 name="construct.b.sffb012"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffb012
            
            #add-point:AFTER FIELD sffb012 name="construct.a.sffb012"
                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.sffb012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffb012
            #add-point:ON ACTION controlp INFIELD sffb012 name="construct.c.sffb012"
                                    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffb013
            #add-point:BEFORE FIELD sffb013 name="construct.b.sffb013"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffb013
            
            #add-point:AFTER FIELD sffb013 name="construct.a.sffb013"
                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.sffb013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffb013
            #add-point:ON ACTION controlp INFIELD sffb013 name="construct.c.sffb013"
                                    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffb014
            #add-point:BEFORE FIELD sffb014 name="construct.b.sffb014"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffb014
            
            #add-point:AFTER FIELD sffb014 name="construct.a.sffb014"
                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.sffb014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffb014
            #add-point:ON ACTION controlp INFIELD sffb014 name="construct.c.sffb014"
                                    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffb015
            #add-point:BEFORE FIELD sffb015 name="construct.b.sffb015"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffb015
            
            #add-point:AFTER FIELD sffb015 name="construct.a.sffb015"
                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.sffb015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffb015
            #add-point:ON ACTION controlp INFIELD sffb015 name="construct.c.sffb015"
                                    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qty
            #add-point:BEFORE FIELD qty name="construct.b.qty"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qty
            
            #add-point:AFTER FIELD qty name="construct.a.qty"
                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.qty
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qty
            #add-point:ON ACTION controlp INFIELD qty name="construct.c.qty"
                                    
            #END add-point
 
 
         #Ctrlp:construct.c.sffb016
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffb016
            #add-point:ON ACTION controlp INFIELD sffb016 name="construct.c.sffb016"
                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooca001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sffb016  #顯示到畫面上

            NEXT FIELD sffb016                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffb016
            #add-point:BEFORE FIELD sffb016 name="construct.b.sffb016"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffb016
            
            #add-point:AFTER FIELD sffb016 name="construct.a.sffb016"
                                    
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffb017
            #add-point:BEFORE FIELD sffb017 name="construct.b.sffb017"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffb017
            
            #add-point:AFTER FIELD sffb017 name="construct.a.sffb017"
                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.sffb017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffb017
            #add-point:ON ACTION controlp INFIELD sffb017 name="construct.c.sffb017"
                                    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffb018
            #add-point:BEFORE FIELD sffb018 name="construct.b.sffb018"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffb018
            
            #add-point:AFTER FIELD sffb018 name="construct.a.sffb018"
                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.sffb018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffb018
            #add-point:ON ACTION controlp INFIELD sffb018 name="construct.c.sffb018"
                                    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffb019
            #add-point:BEFORE FIELD sffb019 name="construct.b.sffb019"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffb019
            
            #add-point:AFTER FIELD sffb019 name="construct.a.sffb019"
                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.sffb019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffb019
            #add-point:ON ACTION controlp INFIELD sffb019 name="construct.c.sffb019"
                                    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffb020
            #add-point:BEFORE FIELD sffb020 name="construct.b.sffb020"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffb020
            
            #add-point:AFTER FIELD sffb020 name="construct.a.sffb020"
                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.sffb020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffb020
            #add-point:ON ACTION controlp INFIELD sffb020 name="construct.c.sffb020"
                                    
            #END add-point
 
 
         #Ctrlp:construct.c.sffbownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffbownid
            #add-point:ON ACTION controlp INFIELD sffbownid name="construct.c.sffbownid"
                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sffbownid  #顯示到畫面上

            NEXT FIELD sffbownid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffbownid
            #add-point:BEFORE FIELD sffbownid name="construct.b.sffbownid"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffbownid
            
            #add-point:AFTER FIELD sffbownid name="construct.a.sffbownid"
                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.sffbowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffbowndp
            #add-point:ON ACTION controlp INFIELD sffbowndp name="construct.c.sffbowndp"
                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sffbowndp  #顯示到畫面上

            NEXT FIELD sffbowndp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffbowndp
            #add-point:BEFORE FIELD sffbowndp name="construct.b.sffbowndp"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffbowndp
            
            #add-point:AFTER FIELD sffbowndp name="construct.a.sffbowndp"
                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.sffbcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffbcrtid
            #add-point:ON ACTION controlp INFIELD sffbcrtid name="construct.c.sffbcrtid"
                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sffbcrtid  #顯示到畫面上

            NEXT FIELD sffbcrtid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffbcrtid
            #add-point:BEFORE FIELD sffbcrtid name="construct.b.sffbcrtid"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffbcrtid
            
            #add-point:AFTER FIELD sffbcrtid name="construct.a.sffbcrtid"
                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.sffbcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffbcrtdp
            #add-point:ON ACTION controlp INFIELD sffbcrtdp name="construct.c.sffbcrtdp"
                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sffbcrtdp  #顯示到畫面上

            NEXT FIELD sffbcrtdp                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffbcrtdp
            #add-point:BEFORE FIELD sffbcrtdp name="construct.b.sffbcrtdp"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffbcrtdp
            
            #add-point:AFTER FIELD sffbcrtdp name="construct.a.sffbcrtdp"
                                    
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffbcrtdt
            #add-point:BEFORE FIELD sffbcrtdt name="construct.b.sffbcrtdt"
                                    
            #END add-point
 
 
         #Ctrlp:construct.c.sffbmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffbmodid
            #add-point:ON ACTION controlp INFIELD sffbmodid name="construct.c.sffbmodid"
                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sffbmodid  #顯示到畫面上

            NEXT FIELD sffbmodid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffbmodid
            #add-point:BEFORE FIELD sffbmodid name="construct.b.sffbmodid"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffbmodid
            
            #add-point:AFTER FIELD sffbmodid name="construct.a.sffbmodid"
                                    
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffbmoddt
            #add-point:BEFORE FIELD sffbmoddt name="construct.b.sffbmoddt"
                                    
            #END add-point
 
 
         #Ctrlp:construct.c.sffbcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffbcnfid
            #add-point:ON ACTION controlp INFIELD sffbcnfid name="construct.c.sffbcnfid"
                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sffbcnfid  #顯示到畫面上

            NEXT FIELD sffbcnfid                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffbcnfid
            #add-point:BEFORE FIELD sffbcnfid name="construct.b.sffbcnfid"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffbcnfid
            
            #add-point:AFTER FIELD sffbcnfid name="construct.a.sffbcnfid"
                                    
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffbcnfdt
            #add-point:BEFORE FIELD sffbcnfdt name="construct.b.sffbcnfdt"
                                    
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON sffdseq1,sffd001,sffd002,sffd003
           FROM s_detail1[1].sffdseq1,s_detail1[1].sffd001,s_detail1[1].sffd002,s_detail1[1].sffd003
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
                                    
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffdseq1
            #add-point:BEFORE FIELD sffdseq1 name="construct.b.page1.sffdseq1"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffdseq1
            
            #add-point:AFTER FIELD sffdseq1 name="construct.a.page1.sffdseq1"
                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.sffdseq1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffdseq1
            #add-point:ON ACTION controlp INFIELD sffdseq1 name="construct.c.page1.sffdseq1"
                                    
            #END add-point
 
 
         #Ctrlp:construct.c.page1.sffd001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffd001
            #add-point:ON ACTION controlp INFIELD sffd001 name="construct.c.page1.sffd001"
                                                #此段落由子樣板a08產生
            #開窗c段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
			LET g_qryparam.arg1 = "1053" 
            CALL q_oocq002()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO sffd001  #顯示到畫面上

            NEXT FIELD sffd001                     #返回原欄位


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffd001
            #add-point:BEFORE FIELD sffd001 name="construct.b.page1.sffd001"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffd001
            
            #add-point:AFTER FIELD sffd001 name="construct.a.page1.sffd001"
                                    
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffd002
            #add-point:BEFORE FIELD sffd002 name="construct.b.page1.sffd002"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffd002
            
            #add-point:AFTER FIELD sffd002 name="construct.a.page1.sffd002"
                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.sffd002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffd002
            #add-point:ON ACTION controlp INFIELD sffd002 name="construct.c.page1.sffd002"
                                    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffd003
            #add-point:BEFORE FIELD sffd003 name="construct.b.page1.sffd003"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffd003
            
            #add-point:AFTER FIELD sffd003 name="construct.a.page1.sffd003"
                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.sffd003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffd003
            #add-point:ON ACTION controlp INFIELD sffd003 name="construct.c.page1.sffd003"
                                    
            #END add-point
 
 
   
       
      END CONSTRUCT
      
      CONSTRUCT g_wc2_table2 ON sffc001,sffc002,sffc003,sffc004,sffc005,sffc006
           FROM s_detail2[1].sffc001,s_detail2[1].sffc002,s_detail2[1].sffc003,s_detail2[1].sffc004, 
               s_detail2[1].sffc005,s_detail2[1].sffc006
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
                                    
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffc001
            #add-point:BEFORE FIELD sffc001 name="construct.b.page2.sffc001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffc001
            
            #add-point:AFTER FIELD sffc001 name="construct.a.page2.sffc001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.sffc001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffc001
            #add-point:ON ACTION controlp INFIELD sffc001 name="construct.c.page2.sffc001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffc002
            #add-point:BEFORE FIELD sffc002 name="construct.b.page2.sffc002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffc002
            
            #add-point:AFTER FIELD sffc002 name="construct.a.page2.sffc002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.sffc002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffc002
            #add-point:ON ACTION controlp INFIELD sffc002 name="construct.c.page2.sffc002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffc003
            #add-point:BEFORE FIELD sffc003 name="construct.b.page2.sffc003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffc003
            
            #add-point:AFTER FIELD sffc003 name="construct.a.page2.sffc003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.sffc003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffc003
            #add-point:ON ACTION controlp INFIELD sffc003 name="construct.c.page2.sffc003"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffc004
            #add-point:BEFORE FIELD sffc004 name="construct.b.page2.sffc004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffc004
            
            #add-point:AFTER FIELD sffc004 name="construct.a.page2.sffc004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.sffc004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffc004
            #add-point:ON ACTION controlp INFIELD sffc004 name="construct.c.page2.sffc004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffc005
            #add-point:BEFORE FIELD sffc005 name="construct.b.page2.sffc005"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffc005
            
            #add-point:AFTER FIELD sffc005 name="construct.a.page2.sffc005"
                                    
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.sffc005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffc005
            #add-point:ON ACTION controlp INFIELD sffc005 name="construct.c.page2.sffc005"
                                    
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffc006
            #add-point:BEFORE FIELD sffc006 name="construct.b.page2.sffc006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffc006
            
            #add-point:AFTER FIELD sffc006 name="construct.a.page2.sffc006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.sffc006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffc006
            #add-point:ON ACTION controlp INFIELD sffc006 name="construct.c.page2.sffc006"
            
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
                  WHEN la_wc[li_idx].tableid = "sffb_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "sffd_t" 
                     LET g_wc2_table1 = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "sffc_t" 
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
 
{<section id="asft335.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION asft335_filter()
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
      CONSTRUCT g_wc_filter ON sffbdocno,sffbseq,sffb001,sffbdocdt,sffb002,sffb003
                          FROM s_browse[1].b_sffbdocno,s_browse[1].b_sffbseq,s_browse[1].b_sffb001,s_browse[1].b_sffbdocdt, 
                              s_browse[1].b_sffb002,s_browse[1].b_sffb003
 
         BEFORE CONSTRUCT
               DISPLAY asft335_filter_parser('sffbdocno') TO s_browse[1].b_sffbdocno
            DISPLAY asft335_filter_parser('sffbseq') TO s_browse[1].b_sffbseq
            DISPLAY asft335_filter_parser('sffb001') TO s_browse[1].b_sffb001
            DISPLAY asft335_filter_parser('sffbdocdt') TO s_browse[1].b_sffbdocdt
            DISPLAY asft335_filter_parser('sffb002') TO s_browse[1].b_sffb002
            DISPLAY asft335_filter_parser('sffb003') TO s_browse[1].b_sffb003
      
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
 
      CALL asft335_filter_show('sffbdocno')
   CALL asft335_filter_show('sffbseq')
   CALL asft335_filter_show('sffb001')
   CALL asft335_filter_show('sffbdocdt')
   CALL asft335_filter_show('sffb002')
   CALL asft335_filter_show('sffb003')
 
END FUNCTION
 
{</section>}
 
{<section id="asft335.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION asft335_filter_parser(ps_field)
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
 
{<section id="asft335.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION asft335_filter_show(ps_field)
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
   LET ls_condition = asft335_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="asft335.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION asft335_query()
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
   CALL g_sffd_d.clear()
   CALL g_sffd2_d.clear()
 
   
   #add-point:query段other name="query.other"
         
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL asft335_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL asft335_browser_fill("")
      CALL asft335_fetch("")
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
      CALL asft335_filter_show('sffbdocno')
   CALL asft335_filter_show('sffbseq')
   CALL asft335_filter_show('sffb001')
   CALL asft335_filter_show('sffbdocdt')
   CALL asft335_filter_show('sffb002')
   CALL asft335_filter_show('sffb003')
   CALL asft335_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL asft335_fetch("F") 
      #顯示單身筆數
      CALL asft335_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="asft335.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION asft335_fetch(p_flag)
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
   
   LET g_sffb_m.sffbdocno = g_browser[g_current_idx].b_sffbdocno
   LET g_sffb_m.sffbseq = g_browser[g_current_idx].b_sffbseq
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE asft335_master_referesh USING g_sffb_m.sffbdocno,g_sffb_m.sffbseq INTO g_sffb_m.sffbdocno, 
       g_sffb_m.sffbseq,g_sffb_m.sffb001,g_sffb_m.sffb002,g_sffb_m.sffbdocdt,g_sffb_m.sffb003,g_sffb_m.sffbsite, 
       g_sffb_m.sffbstus,g_sffb_m.sffb005,g_sffb_m.sffb006,g_sffb_m.sffb007,g_sffb_m.sffb008,g_sffb_m.sffb029, 
       g_sffb_m.sffb009,g_sffb_m.sffb030,g_sffb_m.sffb004,g_sffb_m.sffb010,g_sffb_m.sffb024,g_sffb_m.sffb011, 
       g_sffb_m.sffb012,g_sffb_m.sffb013,g_sffb_m.sffb014,g_sffb_m.sffb015,g_sffb_m.sffb016,g_sffb_m.sffb017, 
       g_sffb_m.sffb018,g_sffb_m.sffb019,g_sffb_m.sffb020,g_sffb_m.sffbownid,g_sffb_m.sffbowndp,g_sffb_m.sffbcrtid, 
       g_sffb_m.sffbcrtdp,g_sffb_m.sffbcrtdt,g_sffb_m.sffbmodid,g_sffb_m.sffbmoddt,g_sffb_m.sffbcnfid, 
       g_sffb_m.sffbcnfdt,g_sffb_m.sffb002_desc,g_sffb_m.sffb003_desc,g_sffb_m.sffb007_desc,g_sffb_m.sffb009_desc, 
       g_sffb_m.sffb030_desc,g_sffb_m.sffb004_desc,g_sffb_m.sffb010_desc,g_sffb_m.sffb024_desc,g_sffb_m.sffbownid_desc, 
       g_sffb_m.sffbowndp_desc,g_sffb_m.sffbcrtid_desc,g_sffb_m.sffbcrtdp_desc,g_sffb_m.sffbmodid_desc, 
       g_sffb_m.sffbcnfid_desc
   
   #遮罩相關處理
   LET g_sffb_m_mask_o.* =  g_sffb_m.*
   CALL asft335_sffb_t_mask()
   LET g_sffb_m_mask_n.* =  g_sffb_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL asft335_set_act_visible()   
   CALL asft335_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
         
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
         
   #end add-point
   
   #保存單頭舊值
   LET g_sffb_m_t.* = g_sffb_m.*
   LET g_sffb_m_o.* = g_sffb_m.*
   
   LET g_data_owner = g_sffb_m.sffbownid      
   LET g_data_dept  = g_sffb_m.sffbowndp
   
   #重新顯示   
   CALL asft335_show()
 
   #應用 a56 樣板自動產生(Version:3)
   #檢查此單據是否需顯示BPM簽核狀況按鈕 
   IF cl_bpm_chk() THEN
      CALL cl_set_act_visible("bpm_status",TRUE)
   ELSE
      CALL cl_set_act_visible("bpm_status",FALSE)
   END IF
 
 
 
 
 
END FUNCTION
 
{</section>}
 
{<section id="asft335.insert" >}
#+ 資料新增
PRIVATE FUNCTION asft335_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   LET g_sffb_m.sffbdocno = cl_get_para(g_enterprise,g_site,'S-MFG-0035')
   IF cl_get_doc_para(g_enterprise,g_site,g_sffb_m.sffbdocno,'D-MFG-0062') ='Y' THEN
      CALL asft335_01() RETURNING g_sffb_m.sffbdocno
      LET g_wc = "sffbdocno = '",g_sffb_m.sffbdocno,"'"
      CALL asft335_browser_fill("")
      CALL asft335_fetch("F")
      CALL asft335_modify()
      RETURN
   END IF
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_sffd_d.clear()   
   CALL g_sffd2_d.clear()  
 
 
   INITIALIZE g_sffb_m.* TO NULL             #DEFAULT 設定
   
   LET g_sffbdocno_t = NULL
   LET g_sffbseq_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_sffb_m.sffbownid = g_user
      LET g_sffb_m.sffbowndp = g_dept
      LET g_sffb_m.sffbcrtid = g_user
      LET g_sffb_m.sffbcrtdp = g_dept 
      LET g_sffb_m.sffbcrtdt = cl_get_current()
      LET g_sffb_m.sffbmodid = g_user
      LET g_sffb_m.sffbmoddt = cl_get_current()
      LET g_sffb_m.sffbstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_sffb_m.sffb001 = "3"
      LET g_sffb_m.sffb014 = "0"
      LET g_sffb_m.sffb015 = "0"
      LET g_sffb_m.sffb017 = "0"
      LET g_sffb_m.sffb018 = "0"
      LET g_sffb_m.sffb019 = "0"
      LET g_sffb_m.sffb020 = "0"
 
  
      #add-point:單頭預設值 name="insert.default"
      LET g_sffb_m.sffbdocno = cl_get_para(g_enterprise,g_site,'S-MFG-0035')
      LET g_sffb_m.sffbdocno_desc = s_aooi200_get_slip_desc(g_sffb_m.sffbdocno)
      DISPLAY BY NAME g_sffb_m.sffbdocno_desc
      LET g_sffb_m.qty = 0
      LET g_sffb_m.sffbdocdt = cl_get_today()
      LET g_sffb_m.sffb011   = 1
      LET g_sffb_m.sffb012   = cl_get_today()
      LET g_sffb_m.sffb013   = cl_get_time()
      LET g_sffb_m.sffb013   = g_sffb_m.sffb013[1,5]
      LET g_sffb_m.sffbseq   = 0 
      LET g_sffb_m.sffb002 = g_user
      LET g_sffb_m.sffb002_desc = s_desc_get_person_desc(g_sffb_m.sffb002)
      DISPLAY BY NAME g_sffb_m.sffb002_desc
      LET g_sffb_m.sffb003 = g_dept
      LET g_sffb_m.sffb003_desc = s_desc_get_department_desc(g_sffb_m.sffb003)
      DISPLAY BY NAME g_sffb_m.sffb003_desc
      LET g_sffb_m.sffbstus = 'N'
      INITIALIZE g_sffb_m_t.* TO NULL
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_sffb_m_t.* = g_sffb_m.*
      LET g_sffb_m_o.* = g_sffb_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_sffb_m.sffbstus 
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
 
 
 
    
      CALL asft335_input("a")
      
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
         INITIALIZE g_sffb_m.* TO NULL
         INITIALIZE g_sffd_d TO NULL
         INITIALIZE g_sffd2_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL asft335_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_sffd_d.clear()
      #CALL g_sffd2_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL asft335_set_act_visible()   
   CALL asft335_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_sffbdocno_t = g_sffb_m.sffbdocno
   LET g_sffbseq_t = g_sffb_m.sffbseq
 
   
   #組合新增資料的條件
   LET g_add_browse = " sffbent = " ||g_enterprise|| " AND",
                      " sffbdocno = '", g_sffb_m.sffbdocno, "' "
                      ," AND sffbseq = '", g_sffb_m.sffbseq, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL asft335_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE asft335_cl
   
   CALL asft335_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE asft335_master_referesh USING g_sffb_m.sffbdocno,g_sffb_m.sffbseq INTO g_sffb_m.sffbdocno, 
       g_sffb_m.sffbseq,g_sffb_m.sffb001,g_sffb_m.sffb002,g_sffb_m.sffbdocdt,g_sffb_m.sffb003,g_sffb_m.sffbsite, 
       g_sffb_m.sffbstus,g_sffb_m.sffb005,g_sffb_m.sffb006,g_sffb_m.sffb007,g_sffb_m.sffb008,g_sffb_m.sffb029, 
       g_sffb_m.sffb009,g_sffb_m.sffb030,g_sffb_m.sffb004,g_sffb_m.sffb010,g_sffb_m.sffb024,g_sffb_m.sffb011, 
       g_sffb_m.sffb012,g_sffb_m.sffb013,g_sffb_m.sffb014,g_sffb_m.sffb015,g_sffb_m.sffb016,g_sffb_m.sffb017, 
       g_sffb_m.sffb018,g_sffb_m.sffb019,g_sffb_m.sffb020,g_sffb_m.sffbownid,g_sffb_m.sffbowndp,g_sffb_m.sffbcrtid, 
       g_sffb_m.sffbcrtdp,g_sffb_m.sffbcrtdt,g_sffb_m.sffbmodid,g_sffb_m.sffbmoddt,g_sffb_m.sffbcnfid, 
       g_sffb_m.sffbcnfdt,g_sffb_m.sffb002_desc,g_sffb_m.sffb003_desc,g_sffb_m.sffb007_desc,g_sffb_m.sffb009_desc, 
       g_sffb_m.sffb030_desc,g_sffb_m.sffb004_desc,g_sffb_m.sffb010_desc,g_sffb_m.sffb024_desc,g_sffb_m.sffbownid_desc, 
       g_sffb_m.sffbowndp_desc,g_sffb_m.sffbcrtid_desc,g_sffb_m.sffbcrtdp_desc,g_sffb_m.sffbmodid_desc, 
       g_sffb_m.sffbcnfid_desc
   
   
   #遮罩相關處理
   LET g_sffb_m_mask_o.* =  g_sffb_m.*
   CALL asft335_sffb_t_mask()
   LET g_sffb_m_mask_n.* =  g_sffb_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_sffb_m.sffbdocno,g_sffb_m.sffbseq,g_sffb_m.sffb001,g_sffb_m.sffb002,g_sffb_m.sffb002_desc, 
       g_sffb_m.sffbdocno_desc,g_sffb_m.sffbdocdt,g_sffb_m.sffb003,g_sffb_m.sffb003_desc,g_sffb_m.sffbsite, 
       g_sffb_m.sffbstus,g_sffb_m.sffb005,g_sffb_m.sffb006,g_sffb_m.sffb007,g_sffb_m.sffb007_desc,g_sffb_m.sffb008, 
       g_sffb_m.sffb029,g_sffb_m.sffb029_desc,g_sffb_m.sffb029_desc_1,g_sffb_m.sffb009,g_sffb_m.sffb009_desc, 
       g_sffb_m.sffb030,g_sffb_m.sffb030_desc,g_sffb_m.sffb004,g_sffb_m.sffb004_desc,g_sffb_m.sffb010, 
       g_sffb_m.sffb010_desc,g_sffb_m.sffb024,g_sffb_m.sffb024_desc,g_sffb_m.sffb011,g_sffb_m.sffb012, 
       g_sffb_m.sffb013,g_sffb_m.sffb014,g_sffb_m.sffb015,g_sffb_m.qty,g_sffb_m.sffb016,g_sffb_m.sffb017, 
       g_sffb_m.sffb018,g_sffb_m.sffb019,g_sffb_m.sffb020,g_sffb_m.sffbownid,g_sffb_m.sffbownid_desc, 
       g_sffb_m.sffbowndp,g_sffb_m.sffbowndp_desc,g_sffb_m.sffbcrtid,g_sffb_m.sffbcrtid_desc,g_sffb_m.sffbcrtdp, 
       g_sffb_m.sffbcrtdp_desc,g_sffb_m.sffbcrtdt,g_sffb_m.sffbmodid,g_sffb_m.sffbmodid_desc,g_sffb_m.sffbmoddt, 
       g_sffb_m.sffbcnfid,g_sffb_m.sffbcnfid_desc,g_sffb_m.sffbcnfdt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_sffb_m.sffbownid      
   LET g_data_dept  = g_sffb_m.sffbowndp
   
   #功能已完成,通報訊息中心
   CALL asft335_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="asft335.modify" >}
#+ 資料修改
PRIVATE FUNCTION asft335_modify()
   #add-point:modify段define(客製用) name="modify.define_customerization"
   
   #end add-point    
   DEFINE l_new_key    DYNAMIC ARRAY OF STRING
   DEFINE l_old_key    DYNAMIC ARRAY OF STRING
   DEFINE l_field_key  DYNAMIC ARRAY OF STRING
   DEFINE l_wc2_table1          STRING
   DEFINE l_wc2_table2   STRING
 
 
 
   #add-point:modify段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   IF g_sffb_m.sffbstus <> 'N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apm-00035'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
#对于在asrt330里产生的资料，这边只能看不能动
   IF g_sffb_m.sffbseq > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00325'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF         
   #end add-point    
   
   #add-point:Function前置處理  name="modify.pre_function"
   
   #end add-point
   
   #保存單頭舊值
   LET g_sffb_m_t.* = g_sffb_m.*
   LET g_sffb_m_o.* = g_sffb_m.*
   
   IF g_sffb_m.sffbdocno IS NULL
   OR g_sffb_m.sffbseq IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_sffbdocno_t = g_sffb_m.sffbdocno
   LET g_sffbseq_t = g_sffb_m.sffbseq
 
   CALL s_transaction_begin()
   
   OPEN asft335_cl USING g_enterprise,g_sffb_m.sffbdocno,g_sffb_m.sffbseq
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN asft335_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE asft335_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE asft335_master_referesh USING g_sffb_m.sffbdocno,g_sffb_m.sffbseq INTO g_sffb_m.sffbdocno, 
       g_sffb_m.sffbseq,g_sffb_m.sffb001,g_sffb_m.sffb002,g_sffb_m.sffbdocdt,g_sffb_m.sffb003,g_sffb_m.sffbsite, 
       g_sffb_m.sffbstus,g_sffb_m.sffb005,g_sffb_m.sffb006,g_sffb_m.sffb007,g_sffb_m.sffb008,g_sffb_m.sffb029, 
       g_sffb_m.sffb009,g_sffb_m.sffb030,g_sffb_m.sffb004,g_sffb_m.sffb010,g_sffb_m.sffb024,g_sffb_m.sffb011, 
       g_sffb_m.sffb012,g_sffb_m.sffb013,g_sffb_m.sffb014,g_sffb_m.sffb015,g_sffb_m.sffb016,g_sffb_m.sffb017, 
       g_sffb_m.sffb018,g_sffb_m.sffb019,g_sffb_m.sffb020,g_sffb_m.sffbownid,g_sffb_m.sffbowndp,g_sffb_m.sffbcrtid, 
       g_sffb_m.sffbcrtdp,g_sffb_m.sffbcrtdt,g_sffb_m.sffbmodid,g_sffb_m.sffbmoddt,g_sffb_m.sffbcnfid, 
       g_sffb_m.sffbcnfdt,g_sffb_m.sffb002_desc,g_sffb_m.sffb003_desc,g_sffb_m.sffb007_desc,g_sffb_m.sffb009_desc, 
       g_sffb_m.sffb030_desc,g_sffb_m.sffb004_desc,g_sffb_m.sffb010_desc,g_sffb_m.sffb024_desc,g_sffb_m.sffbownid_desc, 
       g_sffb_m.sffbowndp_desc,g_sffb_m.sffbcrtid_desc,g_sffb_m.sffbcrtdp_desc,g_sffb_m.sffbmodid_desc, 
       g_sffb_m.sffbcnfid_desc
   
   #檢查是否允許此動作
   IF NOT asft335_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_sffb_m_mask_o.* =  g_sffb_m.*
   CALL asft335_sffb_t_mask()
   LET g_sffb_m_mask_n.* =  g_sffb_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
 
 
   
   CALL asft335_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
   #LET  g_wc2_table2 = l_wc2_table2 
 
 
 
    
   WHILE TRUE
      LET g_sffbdocno_t = g_sffb_m.sffbdocno
      LET g_sffbseq_t = g_sffb_m.sffbseq
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_sffb_m.sffbmodid = g_user 
LET g_sffb_m.sffbmoddt = cl_get_current()
LET g_sffb_m.sffbmodid_desc = cl_get_username(g_sffb_m.sffbmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
                  
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL asft335_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
                  
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE sffb_t SET (sffbmodid,sffbmoddt) = (g_sffb_m.sffbmodid,g_sffb_m.sffbmoddt)
          WHERE sffbent = g_enterprise AND sffbdocno = g_sffbdocno_t
            AND sffbseq = g_sffbseq_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_sffb_m.* = g_sffb_m_t.*
            CALL asft335_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_sffb_m.sffbdocno != g_sffb_m_t.sffbdocno
      OR g_sffb_m.sffbseq != g_sffb_m_t.sffbseq
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         IF NOT s_asft335_upd_sffc(g_sffbdocno_t,g_sffbseq_t,g_sffbseq_t) THEN  CALL s_transaction_end('N','0') RETURN END IF                
         #end add-point
         
         #更新單身key值
         UPDATE sffd_t SET sffddocno = g_sffb_m.sffbdocno
                                       ,sffdseq = g_sffb_m.sffbseq
 
          WHERE sffdent = g_enterprise AND sffddocno = g_sffb_m_t.sffbdocno
            AND sffdseq = g_sffb_m_t.sffbseq
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
                           
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "sffd_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "sffd_t:",SQLERRMESSAGE 
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
         
         UPDATE sffc_t
            SET sffcdocno = g_sffb_m.sffbdocno
               ,sffcseq = g_sffb_m.sffbseq
 
          WHERE sffcent = g_enterprise AND
                sffcdocno = g_sffbdocno_t
            AND sffcseq = g_sffbseq_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
                           
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "sffc_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "sffc_t:",SQLERRMESSAGE 
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
   CALL asft335_set_act_visible()   
   CALL asft335_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " sffbent = " ||g_enterprise|| " AND",
                      " sffbdocno = '", g_sffb_m.sffbdocno, "' "
                      ," AND sffbseq = '", g_sffb_m.sffbseq, "' "
 
   #填到對應位置
   CALL asft335_browser_fill("")
 
   CLOSE asft335_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL asft335_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="asft335.input" >}
#+ 資料輸入
PRIVATE FUNCTION asft335_input(p_cmd)
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
   DEFINE  l_ooef004             LIKE ooef_t.ooef004
   DEFINE  l_sfcb003             LIKE sfcb_t.sfcb003 
   DEFINE  l_sfcb004             LIKE sfcb_t.sfcb004
   DEFINE  l_sfca001             LIKE sfca_t.sfca001
   DEFINE  l_item_desc           LIKE imaal_t.imaal004
   DEFINE  l_item_name           LIKE imaal_t.imaal003
   DEFINE  l_sfaa061             LIKE sfaa_t.sfaa061
   DEFINE  l_cnt1                LIKE type_t.num5
   DEFINE  l_success             LIKE type_t.num5
   DEFINE  l_sffb029             LIKE sffb_t.sffb029
   DEFINE  l_where               STRING              #160204-00004#4 Add By Ken 160222
   #160523-00043 by whitney add start
   DEFINE  l_sffb011             LIKE sffb_t.sffb011
   DEFINE  l_sffb014             LIKE sffb_t.sffb014
   DEFINE  l_sffb017             LIKE sffb_t.sffb017
   #160523-00043 by whitney add end
   DEFINE  l_sffb015             LIKE sffb_t.sffb015  #161123-00033#1-add
   #161202-00018 add---s------
   DEFINE l_sfaadocdt            LIKE sfaa_t.sfaadocdt   
   DEFINE l_time_h               STRING                  
   DEFINE l_time_m               STRING    
   #161202-00018 add-----e-------
   #170117-00038#1-s
   DEFINE ls_js        STRING
   DEFINE lc_param     RECORD
       sffbdocno  LIKE sffb_t.sffbdocno,  #報工單號
       sffbseq    LIKE sffb_t.sffbseq,    #項次
       sffb001    LIKE sffb_t.sffb001,    #報工類別  #170120-00043#1
       sffb005    LIKE sffb_t.sffb005,    #工單單號
       sffb006    LIKE sffb_t.sffb006,    #Run Card
       sffb007    LIKE sffb_t.sffb007,    #作業編號
       sffb008    LIKE sffb_t.sffb008,    #製程式
       sffb017    LIKE sffb_t.sffb017,    #良品數量
       sffb018    LIKE sffb_t.sffb018,    #報廢數量
       sffb019    LIKE sffb_t.sffb019,    #當站下線數量
       sffb020    LIKE sffb_t.sffb020     #回收數量
                   END RECORD
   #170117-00038#1-e
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
   DISPLAY BY NAME g_sffb_m.sffbdocno,g_sffb_m.sffbseq,g_sffb_m.sffb001,g_sffb_m.sffb002,g_sffb_m.sffb002_desc, 
       g_sffb_m.sffbdocno_desc,g_sffb_m.sffbdocdt,g_sffb_m.sffb003,g_sffb_m.sffb003_desc,g_sffb_m.sffbsite, 
       g_sffb_m.sffbstus,g_sffb_m.sffb005,g_sffb_m.sffb006,g_sffb_m.sffb007,g_sffb_m.sffb007_desc,g_sffb_m.sffb008, 
       g_sffb_m.sffb029,g_sffb_m.sffb029_desc,g_sffb_m.sffb029_desc_1,g_sffb_m.sffb009,g_sffb_m.sffb009_desc, 
       g_sffb_m.sffb030,g_sffb_m.sffb030_desc,g_sffb_m.sffb004,g_sffb_m.sffb004_desc,g_sffb_m.sffb010, 
       g_sffb_m.sffb010_desc,g_sffb_m.sffb024,g_sffb_m.sffb024_desc,g_sffb_m.sffb011,g_sffb_m.sffb012, 
       g_sffb_m.sffb013,g_sffb_m.sffb014,g_sffb_m.sffb015,g_sffb_m.qty,g_sffb_m.sffb016,g_sffb_m.sffb017, 
       g_sffb_m.sffb018,g_sffb_m.sffb019,g_sffb_m.sffb020,g_sffb_m.sffbownid,g_sffb_m.sffbownid_desc, 
       g_sffb_m.sffbowndp,g_sffb_m.sffbowndp_desc,g_sffb_m.sffbcrtid,g_sffb_m.sffbcrtid_desc,g_sffb_m.sffbcrtdp, 
       g_sffb_m.sffbcrtdp_desc,g_sffb_m.sffbcrtdt,g_sffb_m.sffbmodid,g_sffb_m.sffbmodid_desc,g_sffb_m.sffbmoddt, 
       g_sffb_m.sffbcnfid,g_sffb_m.sffbcnfid_desc,g_sffb_m.sffbcnfdt
   
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
   LET g_forupd_sql = "SELECT sffdseq1,sffd001,sffd002,sffd003 FROM sffd_t WHERE sffdent=? AND sffddocno=?  
       AND sffdseq=? AND sffdseq1=? AND sffd001=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
         
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE asft335_bcl CURSOR FROM g_forupd_sql
   
   #add-point:input段define_sql name="input.define_sql2"
         
   #end add-point    
   LET g_forupd_sql = "SELECT sffc001,sffc002,sffc003,sffc004,sffc005,sffc006 FROM sffc_t WHERE sffcent=?  
       AND sffcdocno=? AND sffcseq=? AND sffc001=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
         
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE asft335_bcl2 CURSOR FROM g_forupd_sql
 
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
         
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL asft335_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
         
   #end add-point
   CALL asft335_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_sffb_m.sffbdocno,g_sffb_m.sffb001,g_sffb_m.sffb002,g_sffb_m.sffbdocdt,g_sffb_m.sffb003, 
       g_sffb_m.sffbsite,g_sffb_m.sffbstus,g_sffb_m.sffb005,g_sffb_m.sffb006,g_sffb_m.sffb007,g_sffb_m.sffb008, 
       g_sffb_m.sffb029,g_sffb_m.sffb009,g_sffb_m.sffb030,g_sffb_m.sffb004,g_sffb_m.sffb010,g_sffb_m.sffb024, 
       g_sffb_m.sffb011,g_sffb_m.sffb012,g_sffb_m.sffb013,g_sffb_m.sffb014,g_sffb_m.sffb015,g_sffb_m.qty, 
       g_sffb_m.sffb017,g_sffb_m.sffb018,g_sffb_m.sffb019,g_sffb_m.sffb020
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
         
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="asft335.input.head" >}
      #單頭段
      INPUT BY NAME g_sffb_m.sffbdocno,g_sffb_m.sffb001,g_sffb_m.sffb002,g_sffb_m.sffbdocdt,g_sffb_m.sffb003, 
          g_sffb_m.sffbsite,g_sffb_m.sffbstus,g_sffb_m.sffb005,g_sffb_m.sffb006,g_sffb_m.sffb007,g_sffb_m.sffb008, 
          g_sffb_m.sffb029,g_sffb_m.sffb009,g_sffb_m.sffb030,g_sffb_m.sffb004,g_sffb_m.sffb010,g_sffb_m.sffb024, 
          g_sffb_m.sffb011,g_sffb_m.sffb012,g_sffb_m.sffb013,g_sffb_m.sffb014,g_sffb_m.sffb015,g_sffb_m.qty, 
          g_sffb_m.sffb017,g_sffb_m.sffb018,g_sffb_m.sffb019,g_sffb_m.sffb020 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN asft335_cl USING g_enterprise,g_sffb_m.sffbdocno,g_sffb_m.sffbseq
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN asft335_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE asft335_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL asft335_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            CALL asft335_set_sffb013_format()
            LET g_sffb_m.sffbsite = g_site
            CALL asft335_set_no_required()
            CALL asft335_set_required()
            #end add-point
            CALL asft335_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffbdocno
            
            #add-point:AFTER FIELD sffbdocno name="input.a.sffbdocno"
                                                #此段落由子樣板a05產生
            IF  NOT cl_null(g_sffb_m.sffbdocno) AND NOT cl_null(g_sffb_m.sffbseq) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_sffb_m.sffbdocno != g_sffbdocno_t  OR g_sffb_m.sffbseq != g_sffbseq_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM sffb_t WHERE "||"sffbent = '" ||g_enterprise|| "' AND "||"sffbdocno = '"||g_sffb_m.sffbdocno ||"' AND "|| "sffbseq = '"||g_sffb_m.sffbseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            IF NOT cl_null(g_sffb_m.sffbdocno) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_sffb_m_t.sffbdocno IS NULL OR g_sffb_m.sffbdocno <> g_sffb_m_t.sffbdocno)) THEN  
#有单别检查单别，是完整单号检查完整单号，传入完整单号的话，会截取单别做单别合法性检查               
                  IF NOT s_aooi200_chk_docno(g_site,g_sffb_m.sffbdocno,g_sffb_m.sffbdocdt,g_prog) THEN
                     LET g_sffb_m.sffbdocno = g_sffbdocno_t
                     NEXT FIELD CURRENT
                  END IF
                  
               END IF
               #160204-00004#4 Add By Ken 160222(S)
               IF (g_sffb_m.sffbdocno <> g_sffb_m_o.sffbdocno) OR cl_null(g_sffb_m_o.sffbdocno) THEN
                  LET g_sffb_m.sffb005 = ''
                  DISPLAY BY NAME g_sffb_m.sffb005
               END IF
               #160204-00004#4 Add By Ken 160222(E)
            END IF 
            LET g_sffb_m_o.sffbdocno = g_sffb_m.sffbdocno  #160204-00004#4 Add By Ken 160222
            CALL asft335_set_required()
            LET g_sffb_m.sffbdocno_desc = s_aooi200_get_slip_desc(g_sffb_m.sffbdocno)
            DISPLAY BY NAME g_sffb_m.sffbdocno_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffbdocno
            #add-point:BEFORE FIELD sffbdocno name="input.b.sffbdocno"
            CALL asft335_set_no_required()                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sffbdocno
            #add-point:ON CHANGE sffbdocno name="input.g.sffbdocno"
                                    
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffb001
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_sffb_m.sffb001,"1.000","1","5.000","1","azz-00087",1) THEN
               NEXT FIELD sffb001
            END IF 
 
 
 
            #add-point:AFTER FIELD sffb001 name="input.a.sffb001"
            IF NOT cl_null(g_sffb_m.sffb001) THEN 
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_sffb_m_t.sffb001 IS NULL OR g_sffb_m.sffb001 <> g_sffb_m_t.sffb001)) THEN
                  IF NOT s_asft335_chk_sffb0078(g_sffb_m.sffb001,g_sffb_m.sffb005,g_sffb_m.sffb006,g_sffb_m.sffb007,g_sffb_m.sffb008) THEN
                     LET g_sffb_m.sffb001 = g_sffb_m_t.sffb001
                     NEXT FIELD CURRENT
                  END IF                  
               END IF
               
            END IF 
            CALL asft335_set_no_entry(p_cmd)
#动态隐藏调用当站下线的action
            IF g_sffb_m.sffb001 = '3' THEN
               CALL cl_set_act_visible_toolbaritem("call_asft337", TRUE)
            ELSE
               CALL cl_set_act_visible_toolbaritem("call_asft337", FALSE)
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffb001
            #add-point:BEFORE FIELD sffb001 name="input.b.sffb001"
            CALL asft335_set_entry(p_cmd)
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sffb001
            #add-point:ON CHANGE sffb001 name="input.g.sffb001"
                                    
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffb002
            
            #add-point:AFTER FIELD sffb002 name="input.a.sffb002"
            IF NOT cl_null(g_sffb_m.sffb002) THEN 
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_sffb_m_t.sffb002 IS NULL OR g_sffb_m.sffb002 <> g_sffb_m_t.sffb002)) THEN
               #IF g_sffb_m_o.sffb002 IS NULL OR g_sffb_m.sffb002 <> g_sffb_m_o.sffb002 THEN   #160824-00007#216 by sakura add
#此段落由子樣板a19產生
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_errshow = TRUE #是否開窗 #160318-00025#34  add
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_sffb_m.sffb002
                  LET g_chkparam.err_str[1] = "aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"  #160318-00025#34  add
                     
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooag001") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 
   
                  ELSE
                     #檢查失敗時後續處理
                     LET g_sffb_m.sffb002 = g_sffb_m_t.sffb002   
                    #LET g_sffb_m.sffb002 = g_sffb_m_o.sffb002   #160824-00007#216 by sakura add
                     NEXT FIELD CURRENT
                  END IF
               END IF
            

            END IF
           #LET g_sffb_m_o.* = g_sffb_m.*   #160824-00007#216 by sakura add
            LET g_sffb_m.sffb002_desc = s_desc_get_person_desc(g_sffb_m.sffb002)
            DISPLAY BY NAME g_sffb_m.sffb002_desc
            CALL s_aooi200_get_slip(g_sffb_m.sffbdocno) RETURNING l_success,g_doc_slip
            IF cl_get_doc_para(g_enterprise,g_site,g_doc_slip,'D-MFG-0068') ='Y' THEN 
               IF p_cmd ='a' OR (p_cmd = 'u' AND (g_sffb_m_t.sffb002 IS NULL OR g_sffb_m.sffb002 != g_sffb_m_t.sffb002)) THEN
               #IF g_sffb_m_o.sffb002 IS NULL OR g_sffb_m.sffb002 != g_sffb_m_o.sffb002 THEN   #160824-00007#216 by sakura add
                  SELECT oogf001 INTO g_sffb_m.sffb024
                    FROM oogf_t 
                   WHERE oogfent  = g_enterprise
                     AND oogfsite = g_site
                     AND oogf002  = g_sffb_m.sffb002
                     AND oogfstus = 'Y'
                     AND oogf003 <= g_sffb_m.sffbdocdt
                     AND ROWNUM <=1
                   ORDER BY oogf001
 
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_site
                  LET g_ref_fields[2] = g_sffb_m.sffb024
                  CALL ap_ref_array2(g_ref_fields,"SELECT ooge002 FROM ooge_t WHERE oogeent='"||g_enterprise||"' AND oogesite=? AND ooge001=? ","") RETURNING g_rtn_fields
                  LET g_sffb_m.sffb024_desc = '', g_rtn_fields[1] , ''
                  DISPLAY BY NAME g_sffb_m.sffb024_desc 
               END IF
               CALL asft335_set_no_entry(p_cmd)
            END IF
            #LET g_sffb_m_o.* = g_sffb_m.*   #160824-00007#216 by sakura add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffb002
            #add-point:BEFORE FIELD sffb002 name="input.b.sffb002"
                                    
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sffb002
            #add-point:ON CHANGE sffb002 name="input.g.sffb002"
                                    
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffbdocdt
            #add-point:BEFORE FIELD sffbdocdt name="input.b.sffbdocdt"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffbdocdt
            
            #add-point:AFTER FIELD sffbdocdt name="input.a.sffbdocdt"
            IF  NOT cl_null(g_sffb_m.sffbdocdt) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_sffb_m_t.sffbdocdt IS NULL OR g_sffb_m.sffbdocdt != g_sffb_m_t.sffbdocdt)) THEN 
                  IF NOT s_date_chk_close(g_sffb_m.sffbdocdt,'1') THEN

                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sffbdocdt
            #add-point:ON CHANGE sffbdocdt name="input.g.sffbdocdt"
                                    
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffb003
            
            #add-point:AFTER FIELD sffb003 name="input.a.sffb003"
            IF NOT cl_null(g_sffb_m.sffb003) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_sffb_m_t.sffb003 IS NULL OR g_sffb_m.sffb003 != g_sffb_m_t.sffb003)) THEN 
#此段落由子樣板a19產生
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_errshow = TRUE #是否開窗 #160318-00025#34  add
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_sffb_m.sffb003
                  LET g_chkparam.arg2 = g_sffb_m.sffbdocdt
			         LET g_chkparam.err_str[1] = "aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"  #160318-00025#34  add
                     
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooeg001_3") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 
			      
                  ELSE
                     #檢查失敗時後續處理
                     LET g_sffb_m.sffb003 = g_sffb_m_t.sffb003
                     NEXT FIELD CURRENT
                  END IF
               END IF
            

            END IF 
            LET g_sffb_m.sffb003_desc = s_desc_get_department_desc(g_sffb_m.sffb003)
            DISPLAY BY NAME g_sffb_m.sffb003_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffb003
            #add-point:BEFORE FIELD sffb003 name="input.b.sffb003"
                                    
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sffb003
            #add-point:ON CHANGE sffb003 name="input.g.sffb003"
                                    
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffbsite
            #add-point:BEFORE FIELD sffbsite name="input.b.sffbsite"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffbsite
            
            #add-point:AFTER FIELD sffbsite name="input.a.sffbsite"
                                    
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sffbsite
            #add-point:ON CHANGE sffbsite name="input.g.sffbsite"
                                    
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffbstus
            #add-point:BEFORE FIELD sffbstus name="input.b.sffbstus"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffbstus
            
            #add-point:AFTER FIELD sffbstus name="input.a.sffbstus"
                                    
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sffbstus
            #add-point:ON CHANGE sffbstus name="input.g.sffbstus"
                                    
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffb005
            
            #add-point:AFTER FIELD sffb005 name="input.a.sffb005"
            #160906-00040#1-s
            IF NOT cl_null(g_sffb_m.sffb005) THEN
               IF cl_null(g_sffb_m_o.sffb005) OR g_sffb_m.sffb005 != g_sffb_m_o.sffb005 THEN
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_chkparam.arg1 = g_sffb_m.sffb005
                  IF NOT cl_chk_exist("v_sfaadocno_7") THEN
                     LET g_sffb_m.sffb005 = g_sffb_m_o.sffb005
                     DISPLAY BY NAME g_sffb_m.sffb005
                     NEXT FIELD CURRENT
                  END IF
                  #160204-00004#4 Add By Ken 160222(S)
                  IF NOT cl_null(g_sffb_m.sffbdocno) THEN
                     IF NOT s_aooi210_check_doc(g_site,'',g_sffb_m.sffb005,g_sffb_m.sffbdocno,'4','') THEN
                        LET g_sffb_m.sffb005 = g_sffb_m_o.sffb005
                        DISPLAY BY NAME g_sffb_m.sffb005
                        NEXT FIELD CURRENT
                     END IF
                  END IF
                  #160204-00004#4 Add By Ken 160222(E)
                  IF NOT s_asft335_chk_sffb0078(g_sffb_m.sffb001,g_sffb_m.sffb005,g_sffb_m.sffb006,g_sffb_m.sffb007,g_sffb_m.sffb008) THEN
                     LET g_sffb_m.sffb005 = g_sffb_m_o.sffb005
                     DISPLAY BY NAME g_sffb_m.sffb005
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_asft335_default_sffb056(g_sffb_m.sffb001,g_sffb_m.sffb005,g_sffb_m.sffb006,g_sffb_m.sffb007,g_sffb_m.sffb008)
                       RETURNING g_sffb_m.sffb029,g_sffb_m.sffb006,g_sffb_m.sffb007,g_sffb_m.sffb008,g_sffb_m.sffb009,g_sffb_m.sffb030
                  LET g_sffb_m.sffb030_desc = s_desc_get_department_desc(g_sffb_m.sffb030)
                  LET g_sffb_m.sffb007_desc = s_desc_get_acc_desc('221',g_sffb_m.sffb007)
                  CALL s_desc_get_item_desc(g_sffb_m.sffb029)
                       RETURNING g_sffb_m.sffb029_desc,g_sffb_m.sffb029_desc_1
                  CALL s_asft335_set_qty(g_sffb_m.sffbdocno,g_sffb_m.sffbseq,g_sffb_m.sffb001,g_sffb_m.sffb005,g_sffb_m.sffb006,g_sffb_m.sffb007,g_sffb_m.sffb008)
                       RETURNING g_sffb_m.qty,g_sffb_m.sffb016
                  LET g_sffb_m.sffb017 = g_sffb_m.qty 
                  DISPLAY BY NAME g_sffb_m.sffb029,g_sffb_m.sffb006,g_sffb_m.sffb007,g_sffb_m.sffb008,g_sffb_m.sffb009,g_sffb_m.sffb030,
                                  g_sffb_m.sffb030_desc,g_sffb_m.sffb007_desc,g_sffb_m.sffb029_desc,g_sffb_m.sffb029_desc_1,
                                  g_sffb_m.qty,g_sffb_m.sffb016,g_sffb_m.sffb017
               END IF
            END IF
            LET g_sffb_m_o.sffb005 = g_sffb_m.sffb005
           #LET g_sffb_m_o.* = g_sffb_m.*               #160824-00007#216 by sakura add
           #161202-00018 add------s---------
           #工单单据日期
           SELECT sfaadocdt INTO l_sfaadocdt FROM　sfaa_t WHERE sfaaent=g_enterprise AND sfaasite=g_site AND sfaadocno=g_sffb_m.sffb005 
           #161202-00018 add------e---------
            CALL asft335_set_no_entry(p_cmd)
            CALL asft335_set_required() 
            #160906-00040#1-e
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffb005
            #add-point:BEFORE FIELD sffb005 name="input.b.sffb005"
#根据工单制程否决定作业编号和制程序栏位的动态开启关闭，这里无条件的开启
            CALL asft335_set_entry(p_cmd)
            CALL asft335_set_no_required()
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sffb005
            #add-point:ON CHANGE sffb005 name="input.g.sffb005"
                                    
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffb006
            
            #add-point:AFTER FIELD sffb006 name="input.a.sffb006"
            IF NOT cl_null(g_sffb_m.sffb006) THEN 
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_sffb_m_t.sffb006 IS NULL OR g_sffb_m.sffb006 != g_sffb_m_t.sffb006)) THEN
              #IF g_sffb_m_o.sffb006 IS NULL OR g_sffb_m.sffb006 != g_sffb_m_o.sffb006 THEN   #160824-00007#216 by sakura add
                  IF NOT s_asft335_chk_sffb0078(g_sffb_m.sffb001,g_sffb_m.sffb005,g_sffb_m.sffb006,g_sffb_m.sffb007,g_sffb_m.sffb008) THEN
                     LET g_sffb_m.sffb006 = g_sffb_m_t.sffb006
                    #LET g_sffb_m.sffb006 = g_sffb_m_o.sffb006   #160824-00007#216 by sakura add
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_asft335_default_sffb056(g_sffb_m.sffb001,g_sffb_m.sffb005,g_sffb_m.sffb006,g_sffb_m.sffb007,g_sffb_m.sffb008)
                  RETURNING g_sffb_m.sffb029,g_sffb_m.sffb006,g_sffb_m.sffb007,g_sffb_m.sffb008,g_sffb_m.sffb009,g_sffb_m.sffb030 #fengmy151013 add sffb030
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_sffb_m.sffb007
                  CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_sffb_m.sffb007_desc = '', g_rtn_fields[1] , ''
                  DISPLAY BY NAME g_sffb_m.sffb007_desc 
               END IF
#预设待处理数量
               CALL s_asft335_set_qty(g_sffb_m.sffbdocno,g_sffb_m.sffbseq,g_sffb_m.sffb001,g_sffb_m.sffb005,g_sffb_m.sffb006,g_sffb_m.sffb007,g_sffb_m.sffb008) RETURNING g_sffb_m.qty,g_sffb_m.sffb016
               DISPLAY BY NAME g_sffb_m.qty,g_sffb_m.sffb016
               #mark--161103-00007#1 By shiun--(S)
#               LET g_sffb_m.sffb017 = g_sffb_m.qty       #151110-00002#2 add               
               #mark--161103-00007#1 By shiun--(E)
            END IF
            #LET g_sffb_m_o.* = g_sffb_m.*   #160824-00007#216 by sakura add         
            CALL asft335_set_no_entry(p_cmd)
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffb006
            #add-point:BEFORE FIELD sffb006 name="input.b.sffb006"
#根据工单制程否决定作业编号和制程序栏位的动态开启关闭，这里无条件的开启
            CALL asft335_set_entry(p_cmd)                                  
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sffb006
            #add-point:ON CHANGE sffb006 name="input.g.sffb006"
                                    
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffb007
            
            #add-point:AFTER FIELD sffb007 name="input.a.sffb007"
            #sffb007，sffb008的联动检查和预设待处理数量
            IF NOT cl_null(g_sffb_m.sffb007) THEN 
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_sffb_m_t.sffb007 IS NULL OR g_sffb_m.sffb007 != g_sffb_m_t.sffb007)) THEN
               #IF g_sffb_m_o.sffb007 IS NULL OR g_sffb_m.sffb007 != g_sffb_m_o.sffb007 THEN   #160824-00007#216 by sakura add
#共用检查逻辑搬到同一个function内
                  IF NOT s_asft335_chk_sffb0078(g_sffb_m.sffb001,g_sffb_m.sffb005,g_sffb_m.sffb006,g_sffb_m.sffb007,g_sffb_m.sffb008) THEN
                     LET g_sffb_m.sffb007 = g_sffb_m_t.sffb007
                    #LET g_sffb_m.sffb007 = g_sffb_m_o.sffb007   #160824-00007#216 by sakura add
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_asft335_default_sffb056(g_sffb_m.sffb001,g_sffb_m.sffb005,g_sffb_m.sffb006,g_sffb_m.sffb007,g_sffb_m.sffb008)
                  RETURNING l_sffb029,g_sffb_m.sffb006,g_sffb_m.sffb007,g_sffb_m.sffb008,g_sffb_m.sffb009,g_sffb_m.sffb030 #fengmy151013 add sffb030
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_sffb_m.sffb007
                  CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_sffb_m.sffb007_desc = '', g_rtn_fields[1] , ''
                  DISPLAY BY NAME g_sffb_m.sffb007_desc 
               END IF
 #预设待处理数量
               CALL s_asft335_set_qty(g_sffb_m.sffbdocno,g_sffb_m.sffbseq,g_sffb_m.sffb001,g_sffb_m.sffb005,g_sffb_m.sffb006,g_sffb_m.sffb007,g_sffb_m.sffb008) RETURNING g_sffb_m.qty,g_sffb_m.sffb016
               DISPLAY BY NAME g_sffb_m.qty,g_sffb_m.sffb016
               #mark--161103-00007#1 By shiun--(S)
#               LET g_sffb_m.sffb017 = g_sffb_m.qty       #151110-00002#2 add
               #mark--161103-00007#1 By shiun--(E)
            END IF
            #LET g_sffb_m_o.* = g_sffb_m.*   #160824-00007#216 by sakura add           
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_sffb_m.sffb007
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='221' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_sffb_m.sffb007_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_sffb_m.sffb007_desc           

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffb007
            #add-point:BEFORE FIELD sffb007 name="input.b.sffb007"
                                 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sffb007
            #add-point:ON CHANGE sffb007 name="input.g.sffb007"
                                    
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffb008
            
            #add-point:AFTER FIELD sffb008 name="input.a.sffb008"
            #这里有漏洞，必须加一层判断新增或者更改成不等于旧值时，且作业编号与制程序的检查是联动一起的
            IF NOT cl_null(g_sffb_m.sffb008) THEN 
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_sffb_m_t.sffb008 IS NULL OR g_sffb_m.sffb008 != g_sffb_m_t.sffb008)) THEN
              #IF g_sffb_m_o.sffb008 IS NULL OR g_sffb_m.sffb008 != g_sffb_m_o.sffb008 THEN   #160824-00007#216 by sakura add
#共用检查逻辑搬到同一个function内
                  IF NOT s_asft335_chk_sffb0078(g_sffb_m.sffb001,g_sffb_m.sffb005,g_sffb_m.sffb006,g_sffb_m.sffb007,g_sffb_m.sffb008) THEN
                     LET g_sffb_m.sffb008 = g_sffb_m_t.sffb008
                    #LET g_sffb_m.sffb008 = g_sffb_m_o.sffb008   #160824-00007#216 by sakura add
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_asft335_default_sffb056(g_sffb_m.sffb001,g_sffb_m.sffb005,g_sffb_m.sffb006,g_sffb_m.sffb007,g_sffb_m.sffb008)
                  RETURNING l_sffb029,g_sffb_m.sffb006,g_sffb_m.sffb007,g_sffb_m.sffb008,g_sffb_m.sffb009,g_sffb_m.sffb030 #fengmy151013 add sffb030
               END IF
 #预设待处理数量
               CALL s_asft335_set_qty(g_sffb_m.sffbdocno,g_sffb_m.sffbseq,g_sffb_m.sffb001,g_sffb_m.sffb005,g_sffb_m.sffb006,g_sffb_m.sffb007,g_sffb_m.sffb008) RETURNING g_sffb_m.qty,g_sffb_m.sffb016
               DISPLAY BY NAME g_sffb_m.qty,g_sffb_m.sffb016 
               #mark--161103-00007#1 By shiun--(S)
#               LET g_sffb_m.sffb017 = g_sffb_m.qty       #151110-00002#2 add               
               #mark--161103-00007#1 By shiun--(E)
            END IF
            #LET g_sffb_m_o.* = g_sffb_m.*   #160824-00007#216 by sakura add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffb008
            #add-point:BEFORE FIELD sffb008 name="input.b.sffb008"
                                  
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sffb008
            #add-point:ON CHANGE sffb008 name="input.g.sffb008"
                                    
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffb029
            
            #add-point:AFTER FIELD sffb029 name="input.a.sffb029"
            IF NOT cl_null(g_sffb_m.sffb029) THEN 
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_sffb_m_t.sffb029 IS NULL OR g_sffb_m.sffb029 != g_sffb_m_t.sffb029)) THEN
#應用 a19 樣板自動產生(Version:2)
                  #校驗代值
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_sffb_m.sffb005
                  LET g_chkparam.arg2 = g_sffb_m.sffb029
                     
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_sfac001") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 
                  ELSE
                     #檢查失敗時後續處理
                     LET g_sffb_m.sffb029 = g_sffb_m_t.sffb029
                     NEXT FIELD CURRENT
                  END IF
               END IF
            

            END IF 
            CALL s_desc_get_item_desc(g_sffb_m.sffb029)
            RETURNING g_sffb_m.sffb029_desc,g_sffb_m.sffb029_desc_1 
            DISPLAY BY NAME g_sffb_m.sffb029_desc,g_sffb_m.sffb029_desc_1


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffb029
            #add-point:BEFORE FIELD sffb029 name="input.b.sffb029"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sffb029
            #add-point:ON CHANGE sffb029 name="input.g.sffb029"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffb009
            
            #add-point:AFTER FIELD sffb009 name="input.a.sffb009"
            IF NOT cl_null(g_sffb_m.sffb009) THEN 
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_sffb_m_t.sffb009 IS NULL OR g_sffb_m.sffb009 != g_sffb_m_t.sffb009)) THEN
              #IF g_sffb_m_o.sffb009 IS NULL OR g_sffb_m.sffb009 != g_sffb_m_o.sffb009 THEN   #160824-00007#216 by sakura add
#此段落由子樣板a19產生
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_site
                  LET g_chkparam.arg2 = g_sffb_m.sffb009
                  
                     
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ecaa001") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 
                  
                  ELSE
                     #檢查失敗時後續處理
                     LET g_sffb_m.sffb009 = g_sffb_m_t.sffb009
                    #LET g_sffb_m.sffb009 = g_sffb_m_o.sffb009   #160824-00007#216 by sakura add
                     NEXT FIELD CURRENT
                  END IF
                  CALL s_asft335_default_sffb030(g_sffb_m.sffb009) RETURNING g_sffb_m.sffb030   #fengmy151016 add
               END IF
            END IF
            #LET g_sffb_m_o.* = g_sffb_m.*   #160824-00007#216 by sakura add           
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_site
            LET g_ref_fields[2] = g_sffb_m.sffb009
            CALL ap_ref_array2(g_ref_fields,"SELECT ecaa002 FROM ecaa_t WHERE ecaaent='"||g_enterprise||"' AND ecaasite=? AND ecaa001=? ","") RETURNING g_rtn_fields
            LET g_sffb_m.sffb009_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_sffb_m.sffb009_desc
            #fengmy151013---begin
            CALL s_desc_get_department_desc(g_sffb_m.sffb030) RETURNING g_sffb_m.sffb030_desc
            DISPLAY BY NAME g_sffb_m.sffb030_desc   
            #fengmy151013---end             
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffb009
            #add-point:BEFORE FIELD sffb009 name="input.b.sffb009"
                                    
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sffb009
            #add-point:ON CHANGE sffb009 name="input.g.sffb009"
                                    
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffb030
            
            #add-point:AFTER FIELD sffb030 name="input.a.sffb030"
            #fengmy151016---begin
            DISPLAY "" TO g_sffb_m.sffb030_desc
#            IF NOT cl_null(g_sffb_m.sffb030) THEN 
##應用 a17 樣板自動產生(Version:2)
#               #欄位存在檢查
#               #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
#               INITIALIZE g_chkparam.* TO NULL
#
#               #設定g_chkparam.*的參數
#               LET g_chkparam.arg1 = g_sffb_m.sffb030
#
#                  
#               #呼叫檢查存在並帶值的library
#               IF cl_chk_exist("v_ooef001") THEN
#                  #檢查成功時後續處理
#               ELSE
#                  #檢查失敗時後續處理
#                  NEXT FIELD CURRENT
#               END IF
#
#            ELSE
#               LET g_sffb_m.sffb030 = ''  
#            END IF
            CALL s_asft335_sffb030_chk(g_sffb_m.sffb030) RETURNING l_success,g_sffb_m.sffb030
            IF NOT l_success THEN
               NEXT FIELD CURRENT
            END IF            
            CALL s_desc_get_department_desc(g_sffb_m.sffb030) RETURNING g_sffb_m.sffb030_desc
            DISPLAY BY NAME g_sffb_m.sffb030_desc
            #fengmy151016---end

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffb030
            #add-point:BEFORE FIELD sffb030 name="input.b.sffb030"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sffb030
            #add-point:ON CHANGE sffb030 name="input.g.sffb030"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffb004
            
            #add-point:AFTER FIELD sffb004 name="input.a.sffb004"
            IF NOT cl_null(g_sffb_m.sffb004) THEN 
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_sffb_m_t.sffb004 IS NULL OR g_sffb_m.sffb004 <> g_sffb_m_t.sffb004)) THEN
#此段落由子樣板a19產生
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_site
                  LET g_chkparam.arg2 = g_sffb_m.sffb004
                  
                     
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_oogd001") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 
                  
                  ELSE
                     #檢查失敗時後續處理
                     LET g_sffb_m.sffb004 = g_sffb_m_t.sffb004
                     NEXT FIELD CURRENT
                  END IF
               END IF

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_site
            LET g_ref_fields[2] = g_sffb_m.sffb004
            CALL ap_ref_array2(g_ref_fields,"SELECT oogd002 FROM oogd_t WHERE oogdent='"||g_enterprise||"' AND oogdsite=? AND oogd001=? ","") RETURNING g_rtn_fields
            LET g_sffb_m.sffb004_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_sffb_m.sffb004_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffb004
            #add-point:BEFORE FIELD sffb004 name="input.b.sffb004"
                                    
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sffb004
            #add-point:ON CHANGE sffb004 name="input.g.sffb004"
                                    
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffb010
            
            #add-point:AFTER FIELD sffb010 name="input.a.sffb010"
            IF NOT cl_null(g_sffb_m.sffb010) THEN 
               IF p_cmd ='a' OR (p_cmd = 'u' AND (g_sffb_m_t.sffb010 IS NULL OR g_sffb_m.sffb010 <> g_sffb_m_t.sffb010)) THEN
#此段落由子樣板a19產生
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_sffb_m.sffb010
			      
                     
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_mrba001") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 
			      
                  ELSE
                     #檢查失敗時後續處理
                     LET g_sffb_m.sffb010 = g_sffb_m_t.sffb010
                     NEXT FIELD CURRENT
                  END IF
               END IF
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_sffb_m.sffb010
            CALL ap_ref_array2(g_ref_fields,"SELECT mrba004 FROM mrba_t WHERE mrbaent='"||g_enterprise||"' AND mrbasite = '"||g_site||"' AND mrba001=? ","") RETURNING g_rtn_fields
            LET g_sffb_m.sffb010_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_sffb_m.sffb010_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffb010
            #add-point:BEFORE FIELD sffb010 name="input.b.sffb010"
                                    
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sffb010
            #add-point:ON CHANGE sffb010 name="input.g.sffb010"
                                    
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffb024
            
            #add-point:AFTER FIELD sffb024 name="input.a.sffb024"
            IF NOT cl_null(g_sffb_m.sffb024) THEN 
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_sffb_m_t.sffb024 IS NULL OR g_sffb_m.sffb024 != g_sffb_m_t.sffb024)) THEN
               #IF g_sffb_m_o.sffb024 IS NULL OR g_sffb_m.sffb024 != g_sffb_m_o.sffb024 THEN   #160824-00007#216 by sakura add
#此段落由子樣板a19產生
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_errshow = TRUE #是否開窗 #160318-00025#34  add
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_site
                  LET g_chkparam.arg2 = g_sffb_m.sffb024
                  LET g_chkparam.err_str[1] = "aoo-00068:sub-01302|aooi427|",cl_get_progname("aooi427",g_lang,"2"),"|:EXEPROGaooi427"  #160318-00025#34  add
                     
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_ooge001") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 
                  
                  ELSE
                     #檢查失敗時後續處理
                     LET g_sffb_m.sffb024 = g_sffb_m_t.sffb024
                    #LET g_sffb_m.sffb024 = g_sffb_m_o.sffb024   #160824-00007#216 by sakura add
                     NEXT FIELD CURRENT
                  END IF
#预设人数，这个组别在aooi428里，日期有效的条件下的人数

                  SELECT COUNT(oogf002) INTO l_cnt
                    FROM oogf_t
                   WHERE oogfent  = g_enterprise
                     AND oogfsite = g_site
                     AND oogf001  = g_sffb_m.sffb024
                     AND oogfstus = 'Y'
                     AND oogf003 <= g_sffb_m.sffbdocdt
                   IF l_cnt IS NULL THEN LET l_cnt = 0 END IF
#因为失效日期可能输可能没输，所以前面只统计大于等于生效日期的人数是不准的，还要减掉大于等于失效日期的人数
                  SELECT COUNT(oogf002) INTO l_cnt1
                    FROM oogf_t
                   WHERE oogfent  = g_enterprise
                     AND oogfsite = g_site
                     AND oogf001  = g_sffb_m.sffb024
                     AND oogfstus = 'Y'
                     AND oogf004 <= g_sffb_m.sffbdocdt
                  IF l_cnt1 IS NULL THEN LET l_cnt1 = 0 END IF
                  LET g_sffb_m.sffb011 = l_cnt - l_cnt1
                  DISPLAY BY NAME g_sffb_m.sffb011
                 #161029-00007#1---add----str--
                  IF g_sffb_m.sffb011 IS NULL OR g_sffb_m.sffb011 = 0 THEN
                      NEXT FIELD sffb011 #跳至作業人數欄位,由該欄位做控卡
                  END IF
                 #161029-00007#1---add----end--
               END IF
            ELSE
               CALL s_aooi200_get_slip(g_sffb_m.sffbdocno) RETURNING l_success,g_doc_slip
               IF cl_get_doc_para(g_enterprise,g_site,g_doc_slip,'D-MFG-0068') ='Y' THEN
                  
                  NEXT FIELD CURRENT
               ELSE
#组别为空的时候，预设人数为1 
                  IF g_sffb_m.sffb011 IS NULL OR g_sffb_m.sffb011 = 0 THEN
                     LET g_sffb_m.sffb011 = 1
                     DISPLAY BY NAME g_sffb_m.sffb011
                  END IF
               END IF
            END IF
            #LET g_sffb_m_o.* = g_sffb_m.*   #160824-00007#216 by sakura add           
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_site
            LET g_ref_fields[2] = g_sffb_m.sffb024
            CALL ap_ref_array2(g_ref_fields,"SELECT ooge002 FROM ooge_t WHERE oogeent='"||g_enterprise||"' AND oogesite=? AND ooge001=? ","") RETURNING g_rtn_fields
            LET g_sffb_m.sffb024_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_sffb_m.sffb024_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffb024
            #add-point:BEFORE FIELD sffb024 name="input.b.sffb024"
                                    
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sffb024
            #add-point:ON CHANGE sffb024 name="input.g.sffb024"
                                    
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffb011
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_sffb_m.sffb011,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD sffb011
            END IF 
 
 
 
            #add-point:AFTER FIELD sffb011 name="input.a.sffb011"
            #160523-00043 by whitney modify start
            IF NOT cl_null(g_sffb_m.sffb011) THEN
               IF g_sffb_m.sffb011 != g_sffb_m_o.sffb011 OR cl_null(g_sffb_m_o.sffb011) THEN
                  #LET g_sffb_m.sffb014 = s_asft335_get_working_time(g_sffb_m.sffb001,g_sffb_m.sffb005,g_sffb_m.sffb006,g_sffb_m.sffb007,g_sffb_m.sffb008,g_sffb_m.sffb012,g_sffb_m.sffb013) * g_sffb_m.sffb011  #161123-00033#1-mark
                  IF g_sffb_m.sffb011 > 0 THEN
                     IF p_cmd='u' THEN    #161130-00008#1 add                   
                        CALL asft330_03(g_sffb_m.sffbdocno,g_sffb_m.sffbseq,g_sffb_m.sffb011,g_sffb_m.sffb014,g_sffb_m.sffb017)
                             RETURNING l_success,l_sffb011,l_sffb014,l_sffb017
                        IF l_success THEN
                           LET g_sffb_m.sffb011 = l_sffb011
                           LET g_sffb_m.sffb014 = l_sffb014
                           LET g_sffb_m.sffb017 = l_sffb017
                           DISPLAY BY NAME g_sffb_m.sffb011,g_sffb_m.sffb014,g_sffb_m.sffb017
                        END IF
                     END IF               #161130-00008#1 add
                  ELSE
                     LET l_cnt = 0
                     SELECT COUNT(1) INTO l_cnt
                       FROM sffe_t
                      WHERE sffeent = g_enterprise
                        AND sffedocno = g_sffb_m.sffbdocno
                        AND sffeseq = g_sffb_m.sffbseq
                     IF l_cnt > 0 THEN
                        IF  cl_ask_confirm("asf-00756") THEN
                           DELETE FROM sffe_t
                            WHERE sffeent = g_enterprise
                              AND sffedocno = g_sffb_m.sffbdocno
                              AND sffeseq = g_sffb_m.sffbseq
                        ELSE
                           LET g_sffb_m.sffb011 = g_sffb_m_o.sffb011
                           DISPLAY BY NAME g_sffb_m.sffb011
                        END IF
                     END IF
                  END IF
                  LET g_sffb_m_o.sffb011 = g_sffb_m.sffb011
               END IF
            END IF
            #160523-00043 by whitney modify end
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffb011
            #add-point:BEFORE FIELD sffb011 name="input.b.sffb011"
                                    
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sffb011
            #add-point:ON CHANGE sffb011 name="input.g.sffb011"
                                    
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffb012
            #add-point:BEFORE FIELD sffb012 name="input.b.sffb012"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffb012
            
            #add-point:AFTER FIELD sffb012 name="input.a.sffb012"
            IF g_sffb_m.sffb012 IS NOT NULL THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_sffb_m_t.sffb012 IS NULL OR g_sffb_m.sffb012 != g_sffb_m_t.sffb012)) THEN
              #IF g_sffb_m_o.sffb012 IS NULL OR g_sffb_m.sffb012 != g_sffb_m_o.sffb012 THEN   #160824-00007#216 by sakura add
                  IF NOT s_asft335_check_time(g_sffb_m.sffb012,g_sffb_m.sffb013,g_sffb_m.sffb001,g_sffb_m.sffb005,g_sffb_m.sffb006,g_sffb_m.sffb007,g_sffb_m.sffb008) THEN
                     LET g_sffb_m.sffb012 = g_sffb_m_t.sffb012
                    #LET g_sffb_m.sffb012 = g_sffb_m_o.sffb012   #160824-00007#216 by sakura add
                     NEXT FIELD CURRENT 
                  ELSE
                     #161123-00033#1-s-mod
                     #LET g_sffb_m.sffb014 = s_asft335_get_working_time(g_sffb_m.sffb001,g_sffb_m.sffb005,g_sffb_m.sffb006,g_sffb_m.sffb007,g_sffb_m.sffb008,g_sffb_m.sffb012,g_sffb_m.sffb013) * g_sffb_m.sffb011
                     LET l_sffb014 = s_asft335_get_working_time(g_sffb_m.sffb001,g_sffb_m.sffb005,g_sffb_m.sffb006,g_sffb_m.sffb007,g_sffb_m.sffb008,g_sffb_m.sffb012,g_sffb_m.sffb013) * g_sffb_m.sffb011
                     IF l_sffb014 <> 0 THEN
                        LET g_sffb_m.sffb014 = l_sffb014
                     END IF
                     #161123-00033#1-e-mod
                     LET g_sffb_m.sffb015 = s_asft335_get_working_time(g_sffb_m.sffb001,g_sffb_m.sffb005,g_sffb_m.sffb006,g_sffb_m.sffb007,g_sffb_m.sffb008,g_sffb_m.sffb012,g_sffb_m.sffb013)
                  END IF
               END IF
            END IF
            #LET g_sffb_m_o.* = g_sffb_m.*   #160824-00007#216 by sakura add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sffb012
            #add-point:ON CHANGE sffb012 name="input.g.sffb012"
                                    
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffb013
            #add-point:BEFORE FIELD sffb013 name="input.b.sffb013"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffb013
            
            #add-point:AFTER FIELD sffb013 name="input.a.sffb013"
            IF g_sffb_m.sffb013 IS NOT NULL THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_sffb_m_t.sffb013 IS NULL OR g_sffb_m.sffb013 != g_sffb_m_t.sffb013)) THEN
              #IF g_sffb_m_o.sffb013 IS NULL OR g_sffb_m.sffb013 != g_sffb_m_o.sffb013 THEN   #160824-00007#216 by sakura add
                  #161202-00018 add-------s--------
                  #检查输入时间格式合理性，冒号前的数字大于0小于等于23，冒号后面的数字大于0小于等于59
                  LET l_time_h=g_sffb_m.sffb013
                  LET l_time_m=g_sffb_m.sffb013
                  LET l_time_h=l_time_h.subString(1,2)
                  LET l_time_m=l_time_m.subString(4,5)
                  IF l_time_h<0 OR l_time_h>23 OR l_time_m<0 OR l_time_m>59 THEN 
                     LET g_sffb_m.sffb013=g_sffb_m_t.sffb013
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.code   = "amr-00073"
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF

                  #161202-00018 add-------e--------
                  IF NOT s_asft335_check_time(g_sffb_m.sffb012,g_sffb_m.sffb013,g_sffb_m.sffb001,g_sffb_m.sffb005,g_sffb_m.sffb006,g_sffb_m.sffb007,g_sffb_m.sffb008) THEN
                     LET g_sffb_m.sffb013 = g_sffb_m_t.sffb013
                     #LET g_sffb_m.sffb013 = g_sffb_m_o.sffb013   #160824-00007#216 by sakura add
                     NEXT FIELD CURRENT 
                  ELSE
                     LET g_sffb_m.sffb014 = s_asft335_get_working_time(g_sffb_m.sffb001,g_sffb_m.sffb005,g_sffb_m.sffb006,g_sffb_m.sffb007,g_sffb_m.sffb008,g_sffb_m.sffb012,g_sffb_m.sffb013) * g_sffb_m.sffb011
                     LET g_sffb_m.sffb015 = s_asft335_get_working_time(g_sffb_m.sffb001,g_sffb_m.sffb005,g_sffb_m.sffb006,g_sffb_m.sffb007,g_sffb_m.sffb008,g_sffb_m.sffb012,g_sffb_m.sffb013)
                  END IF
               END IF
            END IF
           #LET g_sffb_m_o.* = g_sffb_m.*   #160824-00007#216 by sakura add
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sffb013
            #add-point:ON CHANGE sffb013 name="input.g.sffb013"
                                    
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffb014
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_sffb_m.sffb014,"0","0","","","azz-00079",1) THEN
               NEXT FIELD sffb014
            END IF 
 
 
 
            #add-point:AFTER FIELD sffb014 name="input.a.sffb014"
            #160523-00043 by whitney add start
            IF NOT cl_null(g_sffb_m.sffb014) THEN
               IF g_sffb_m.sffb014 != g_sffb_m_o.sffb014 OR cl_null(g_sffb_m_o.sffb014) THEN
                  LET l_cnt = 0
                  SELECT COUNT(*) INTO l_cnt
                    FROM sffe_t
                   WHERE sffeent = g_enterprise
                     AND sffedocno = g_sffb_m.sffbdocno
                     AND sffeseq = g_sffb_m.sffbseq
                  IF l_cnt > 0 THEN
                     LET l_sffb014 = 0
                     SELECT SUM(sffe002) INTO l_sffb014
                       FROM sffe_t
                      WHERE sffeent = g_enterprise
                        AND sffedocno = g_sffb_m.sffbdocno
                        AND sffeseq = g_sffb_m.sffbseq
                     IF cl_null(l_sffb014) THEN LET l_sffb014 = 0 END IF
                     IF l_sffb014 <> g_sffb_m.sffb014 THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.code   = "asf-00751"
                        LET g_errparam.replace[1] = g_sffb_m.sffb014
                        LET g_errparam.replace[2] = l_sffb014
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        IF p_cmd='u' THEN    #161130-00008#1 add
                           CALL asft330_03(g_sffb_m.sffbdocno,g_sffb_m.sffbseq,g_sffb_m.sffb011,g_sffb_m.sffb014,g_sffb_m.sffb017)
                                RETURNING l_success,l_sffb011,l_sffb014,l_sffb017
                           IF l_success THEN
                              LET g_sffb_m.sffb011 = l_sffb011
                              LET g_sffb_m.sffb014 = l_sffb014
                              LET g_sffb_m.sffb017 = l_sffb017
                              DISPLAY BY NAME g_sffb_m.sffb011,g_sffb_m.sffb014,g_sffb_m.sffb017
                           END IF
                        END IF   #161130-00008#1 add
                     END IF
                  END IF
                  LET g_sffb_m_o.sffb014 = g_sffb_m.sffb014
               END IF
            END IF
            #160523-00043 by whitney add end
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffb014
            #add-point:BEFORE FIELD sffb014 name="input.b.sffb014"
                                    
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sffb014
            #add-point:ON CHANGE sffb014 name="input.g.sffb014"
                                    
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffb015
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_sffb_m.sffb015,"0","0","","","azz-00079",1) THEN
               NEXT FIELD sffb015
            END IF 
 
 
 
            #add-point:AFTER FIELD sffb015 name="input.a.sffb015"
                                    
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffb015
            #add-point:BEFORE FIELD sffb015 name="input.b.sffb015"
                                    
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sffb015
            #add-point:ON CHANGE sffb015 name="input.g.sffb015"
                                    
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD qty
            #add-point:BEFORE FIELD qty name="input.b.qty"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD qty
            
            #add-point:AFTER FIELD qty name="input.a.qty"
                                    
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE qty
            #add-point:ON CHANGE qty name="input.g.qty"
                                    
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffb017
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_sffb_m.sffb017,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD sffb017
            END IF 
 
 
 
            #add-point:AFTER FIELD sffb017 name="input.a.sffb017"
            
            IF NOT cl_null(g_sffb_m.sffb017) THEN 
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_sffb_m_t.sffb017 IS NULL OR g_sffb_m.sffb017 != g_sffb_m_t.sffb017)) THEN
               END IF
            END IF 
            


            #160523-00043 by whitney modify start
            IF NOT cl_null(g_sffb_m.sffb017) THEN
               IF g_sffb_m.sffb017 != g_sffb_m_o.sffb017 OR cl_null(g_sffb_m_o.sffb017) THEN
                  IF g_sffb_m.sffb001 MATCHES '[1245]' THEN
                     IF g_sffb_m.sffb017 > g_sffb_m.qty THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = 'asf-00187'
                        LET g_errparam.extend = g_sffb_m.qty
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                        LET g_sffb_m.sffb017 = g_sffb_m_o.sffb017
                        NEXT FIELD sffb017
                     END IF
                  END IF
                  IF g_sffb_m.sffb001 = '3' THEN
                     #170117-00038#1-s
                     #IF NOT s_asft335_chk_qty(g_sffb_m.sffb005,g_sffb_m.sffb006,g_sffb_m.sffb007,g_sffb_m.sffb008,g_sffb_m.sffb017,g_sffb_m.sffb018,g_sffb_m.sffb019,g_sffb_m.sffb020,g_sffb_m.qty) THEN
                     LET lc_param.sffbdocno = g_sffb_m.sffbdocno  #報工單號
                     LET lc_param.sffbseq   = g_sffb_m_t.sffbseq  #項次      #170120-00043#1  #170209-00018#1
                     LET lc_param.sffb001   = g_sffb_m.sffb001    #報工類別  #170120-00043#1
                     LET lc_param.sffb005   = g_sffb_m.sffb005    #工單單號
                     LET lc_param.sffb006   = g_sffb_m.sffb006    #Run Card
                     LET lc_param.sffb007   = g_sffb_m.sffb007    #作業編號
                     LET lc_param.sffb008   = g_sffb_m.sffb008    #製程式
                     LET lc_param.sffb017   = g_sffb_m.sffb017    #良品數量
                     LET lc_param.sffb018   = g_sffb_m.sffb018    #報廢數量
                     LET lc_param.sffb019   = g_sffb_m.sffb019    #當站下線數量
                     LET lc_param.sffb020   = g_sffb_m.sffb020    #回收數量
                     LET ls_js = util.JSON.stringify(lc_param)
                     IF NOT s_asft335_chk_qty(ls_js) THEN
                     #170117-00038#1-e
                        LET g_sffb_m.sffb017 = g_sffb_m_o.sffb017
                        NEXT FIELD sffb017
                     END IF
                     #mark--161103-00007#1 By shiun--(S)
                     #151110-00002#2 add start -----------
#                     IF NOT s_asft335_chk_sffb017(g_sffb_m.sffbdocno,g_sffb_m.sffb001,g_sffb_m.sffb005,g_sffb_m.sffb006,g_sffb_m.sffb007,g_sffb_m.sffb008,g_sffb_m.sffb017) THEN
#                        LET g_sffb_m.sffb017 = g_sffb_m_o.sffb017
#                        NEXT FIELD sffb017
#                     END IF
#                     #151110-00002#2 add end   -----------
                     #mark--161103-00007#1 By shiun--(E)
                  END IF
                  
                  LET l_cnt = 0
                  SELECT COUNT(*) INTO l_cnt
                    FROM sffe_t
                   WHERE sffeent = g_enterprise
                     AND sffedocno = g_sffb_m.sffbdocno
                     AND sffeseq = g_sffb_m.sffbseq
                  IF l_cnt > 0 THEN
                     LET l_sffb017 = 0
                     SELECT SUM(sffe003) INTO l_sffb017
                       FROM sffe_t
                      WHERE sffeent = g_enterprise
                        AND sffedocno = g_sffb_m.sffbdocno
                        AND sffeseq = g_sffb_m.sffbseq
                     IF cl_null(l_sffb017) THEN LET l_sffb017 = 0 END IF
                     IF l_sffb017 <> g_sffb_m.sffb017 THEN
                        INITIALIZE g_errparam TO NULL 
                        LET g_errparam.code   = "asf-00752"
                        LET g_errparam.replace[1] = g_sffb_m.sffb017
                        LET g_errparam.replace[2] = l_sffb017
                        LET g_errparam.popup  = TRUE 
                        CALL cl_err()
                        IF p_cmd='u' THEN    #161130-00008#1 add
                           CALL asft330_03(g_sffb_m.sffbdocno,g_sffb_m.sffbseq,g_sffb_m.sffb011,g_sffb_m.sffb014,g_sffb_m.sffb017)
                                RETURNING l_success,l_sffb011,l_sffb014,l_sffb017
                           IF l_success THEN
                              LET g_sffb_m.sffb011 = l_sffb011
                              LET g_sffb_m.sffb014 = l_sffb014
                              LET g_sffb_m.sffb017 = l_sffb017
                              DISPLAY BY NAME g_sffb_m.sffb011,g_sffb_m.sffb014,g_sffb_m.sffb017
                           END IF
                        END IF    #161130-00008#1 add
                     END IF
                  END IF
                  LET g_sffb_m_o.sffb017 = g_sffb_m.sffb017
               END IF
            END IF
            #160523-00043 by whitney modify end
            #LET g_sffb_m_o.* = g_sffb_m.*   #160824-00007#216 by sakura add
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffb017
            #add-point:BEFORE FIELD sffb017 name="input.b.sffb017"
                                    
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sffb017
            #add-point:ON CHANGE sffb017 name="input.g.sffb017"
                                    
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffb018
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_sffb_m.sffb018,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD sffb018
            END IF 
 
 
 
            #add-point:AFTER FIELD sffb018 name="input.a.sffb018"
            IF NOT cl_null(g_sffb_m.sffb018) THEN 
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_sffb_m_t.sffb018 IS NULL OR g_sffb_m.sffb018 != g_sffb_m_t.sffb018)) THEN
                  #170117-00038#1-s
                  #IF NOT s_asft335_chk_qty(g_sffb_m.sffb005,g_sffb_m.sffb006,g_sffb_m.sffb007,g_sffb_m.sffb008,g_sffb_m.sffb017,g_sffb_m.sffb018,g_sffb_m.sffb019,g_sffb_m.sffb020,g_sffb_m.qty) THEN
                  LET lc_param.sffbdocno = g_sffb_m.sffbdocno  #報工單號
                  LET lc_param.sffbseq   = g_sffb_m_t.sffbseq  #項次      #170120-00043#1  #170209-00018#1
                  LET lc_param.sffb001   = g_sffb_m.sffb001    #報工類別  #170120-00043#1
                  LET lc_param.sffb005   = g_sffb_m.sffb005    #工單單號
                  LET lc_param.sffb006   = g_sffb_m.sffb006    #Run Card
                  LET lc_param.sffb007   = g_sffb_m.sffb007    #作業編號
                  LET lc_param.sffb008   = g_sffb_m.sffb008    #製程式
                  LET lc_param.sffb017   = g_sffb_m.sffb017    #良品數量
                  LET lc_param.sffb018   = g_sffb_m.sffb018    #報廢數量
                  LET lc_param.sffb019   = g_sffb_m.sffb019    #當站下線數量
                  LET lc_param.sffb020   = g_sffb_m.sffb020    #回收數量
                  LET ls_js = util.JSON.stringify(lc_param)
                  IF NOT s_asft335_chk_qty(ls_js) THEN
                  #170117-00038#1-e
                     LET g_sffb_m.sffb018 = g_sffb_m_t.sffb018
                     NEXT FIELD sffb018
                  END IF
               END IF
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffb018
            #add-point:BEFORE FIELD sffb018 name="input.b.sffb018"
                                    
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sffb018
            #add-point:ON CHANGE sffb018 name="input.g.sffb018"
                                    
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffb019
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_sffb_m.sffb019,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD sffb019
            END IF 
 
 
 
            #add-point:AFTER FIELD sffb019 name="input.a.sffb019"
            IF NOT cl_null(g_sffb_m.sffb019) THEN
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_sffb_m_t.sffb019 IS NULL OR g_sffb_m.sffb019 != g_sffb_m_t.sffb019)) THEN
                  #170117-00038#1-s
                  #IF NOT s_asft335_chk_qty(g_sffb_m.sffb005,g_sffb_m.sffb006,g_sffb_m.sffb007,g_sffb_m.sffb008,g_sffb_m.sffb017,g_sffb_m.sffb018,g_sffb_m.sffb019,g_sffb_m.sffb020,g_sffb_m.qty) THEN
                  LET lc_param.sffbdocno = g_sffb_m.sffbdocno  #報工單號
                  LET lc_param.sffbseq   = g_sffb_m_t.sffbseq  #項次      #170120-00043#1  #170209-00018#1
                  LET lc_param.sffb001   = g_sffb_m.sffb001    #報工類別  #170120-00043#1
                  LET lc_param.sffb005   = g_sffb_m.sffb005    #工單單號
                  LET lc_param.sffb006   = g_sffb_m.sffb006    #Run Card
                  LET lc_param.sffb007   = g_sffb_m.sffb007    #作業編號
                  LET lc_param.sffb008   = g_sffb_m.sffb008    #製程式
                  LET lc_param.sffb017   = g_sffb_m.sffb017    #良品數量
                  LET lc_param.sffb018   = g_sffb_m.sffb018    #報廢數量
                  LET lc_param.sffb019   = g_sffb_m.sffb019    #當站下線數量
                  LET lc_param.sffb020   = g_sffb_m.sffb020    #回收數量
                  LET ls_js = util.JSON.stringify(lc_param)
                  IF NOT s_asft335_chk_qty(ls_js) THEN
                  #170117-00038#1-e
                     LET g_sffb_m.sffb019 = g_sffb_m_t.sffb019
                     NEXT FIELD sffb019
                  END IF
                  IF p_cmd = 'u' AND (g_sffb_m_t.sffb019 IS NULL OR g_sffb_m.sffb019 != g_sffb_m_t.sffb019) THEN
                     IF NOT s_asft335_upd_sfha(g_sffb_m.sffbdocno,'0','0',g_sffb_m.sffb019) THEN
                        LET g_sffb_m.sffb019 = g_sffb_m_t.sffb019
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF            
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffb019
            #add-point:BEFORE FIELD sffb019 name="input.b.sffb019"
                                    
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sffb019
            #add-point:ON CHANGE sffb019 name="input.g.sffb019"
                                    
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffb020
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_sffb_m.sffb020,"0.000","1","","","azz-00079",1) THEN
               NEXT FIELD sffb020
            END IF 
 
 
 
            #add-point:AFTER FIELD sffb020 name="input.a.sffb020"
            IF NOT cl_null(g_sffb_m.sffb020) THEN 
               IF p_cmd = 'a' OR (p_cmd = 'u' AND (g_sffb_m_t.sffb020 IS NULL OR g_sffb_m.sffb020 != g_sffb_m_t.sffb020)) THEN
                  #170117-00038#1-s
                  #IF NOT s_asft335_chk_qty(g_sffb_m.sffb005,g_sffb_m.sffb006,g_sffb_m.sffb007,g_sffb_m.sffb008,g_sffb_m.sffb017,g_sffb_m.sffb018,g_sffb_m.sffb019,g_sffb_m.sffb020,g_sffb_m.qty) THEN
                  LET lc_param.sffbdocno = g_sffb_m.sffbdocno  #報工單號
                  LET lc_param.sffbseq   = g_sffb_m_t.sffbseq  #項次      #170120-00043#1  #170209-00018#1
                  LET lc_param.sffb001   = g_sffb_m.sffb001    #報工類別  #170120-00043#1
                  LET lc_param.sffb005   = g_sffb_m.sffb005    #工單單號
                  LET lc_param.sffb006   = g_sffb_m.sffb006    #Run Card
                  LET lc_param.sffb007   = g_sffb_m.sffb007    #作業編號
                  LET lc_param.sffb008   = g_sffb_m.sffb008    #製程式
                  LET lc_param.sffb017   = g_sffb_m.sffb017    #良品數量
                  LET lc_param.sffb018   = g_sffb_m.sffb018    #報廢數量
                  LET lc_param.sffb019   = g_sffb_m.sffb019    #當站下線數量
                  LET lc_param.sffb020   = g_sffb_m.sffb020    #回收數量
                  LET ls_js = util.JSON.stringify(lc_param)
                  IF NOT s_asft335_chk_qty(ls_js) THEN
                  #170117-00038#1-e
                     LET g_sffb_m.sffb020 = g_sffb_m_t.sffb020
                     NEXT FIELD sffb020
                  END IF
               END IF
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffb020
            #add-point:BEFORE FIELD sffb020 name="input.b.sffb020"
            CALL asft335_set_no_entry(p_cmd)                       
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sffb020
            #add-point:ON CHANGE sffb020 name="input.g.sffb020"
                                    
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.sffbdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffbdocno
            #add-point:ON ACTION controlp INFIELD sffbdocno name="input.c.sffbdocno"
                                    #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_sffb_m.sffbdocno             #給予default值

            #給予arg
            SELECT ooef004 INTO l_ooef004 
              FROM ooef_t
             WHERE ooefent = g_enterprise
               AND ooef001 = g_site
               
            LET g_qryparam.arg1 = l_ooef004          #
            LET g_qryparam.arg2 = g_prog      #

            CALL q_ooba002_1()                                #呼叫開窗

            LET g_sffb_m.sffbdocno = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_sffb_m.sffbdocno TO sffbdocno              #顯示到畫面上

            NEXT FIELD sffbdocno                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.sffb001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffb001
            #add-point:ON ACTION controlp INFIELD sffb001 name="input.c.sffb001"
                                    
            #END add-point
 
 
         #Ctrlp:input.c.sffb002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffb002
            #add-point:ON ACTION controlp INFIELD sffb002 name="input.c.sffb002"
                                    #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_sffb_m.sffb002             #給予default值

            #給予arg

            CALL q_ooag001_4()                                #呼叫開窗

            LET g_sffb_m.sffb002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_sffb_m.sffb002 TO sffb002              #顯示到畫面上

            NEXT FIELD sffb002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.sffbdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffbdocdt
            #add-point:ON ACTION controlp INFIELD sffbdocdt name="input.c.sffbdocdt"
                                    
            #END add-point
 
 
         #Ctrlp:input.c.sffb003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffb003
            #add-point:ON ACTION controlp INFIELD sffb003 name="input.c.sffb003"
                                    #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_sffb_m.sffb003             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_sffb_m.sffbdocdt

            CALL q_ooeg001()                                #呼叫開窗

            LET g_sffb_m.sffb003 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_sffb_m.sffb003 TO sffb003              #顯示到畫面上

            NEXT FIELD sffb003                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.sffbsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffbsite
            #add-point:ON ACTION controlp INFIELD sffbsite name="input.c.sffbsite"
                                    
            #END add-point
 
 
         #Ctrlp:input.c.sffbstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffbstus
            #add-point:ON ACTION controlp INFIELD sffbstus name="input.c.sffbstus"
                                    
            #END add-point
 
 
         #Ctrlp:input.c.sffb005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffb005
            #add-point:ON ACTION controlp INFIELD sffb005 name="input.c.sffb005"
            #160906-00040#1-s
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_sffb_m.sffb005  #給予default值
            LET g_qryparam.arg1 = 'F'                   #給予arg
            LET g_qryparam.arg2 = '1'
            #160204-00004#4 Add By Ken 160222(S)
            #組合過濾前後置單據資料SQL
            IF NOT cl_null(g_sffb_m.sffbdocno) THEN
               CALL s_aooi210_get_check_sql(g_site,'',g_sffb_m.sffbdocno,'4','','sfaadocno') RETURNING l_success,l_where
               IF l_success THEN
                  LET g_qryparam.where = l_where
                  #CALL q_sfaadocno_1()
               END IF
            END IF
            #160204-00004#4 Add By Ken 160222(E)
            CALL q_sfaadocno_17() #161014-00030#1 mark
            LET g_sffb_m.sffb005 = g_qryparam.return1   #將開窗取得的值回傳到變數
            DISPLAY g_sffb_m.sffb005 TO sffb005         #顯示到畫面上
            NEXT FIELD sffb005                          #返回原欄位
            #160906-00040#1-e
            #END add-point
 
 
         #Ctrlp:input.c.sffb006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffb006
            #add-point:ON ACTION controlp INFIELD sffb006 name="input.c.sffb006"
                                    #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_sffb_m.sffb006             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_site
            LET g_qryparam.arg2 = g_sffb_m.sffb005

            CALL q_sfca001()                                #呼叫開窗

            LET g_sffb_m.sffb006 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_sffb_m.sffb006 TO sffb006              #顯示到畫面上

            NEXT FIELD sffb006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.sffb007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffb007
            #add-point:ON ACTION controlp INFIELD sffb007 name="input.c.sffb007"
                                    #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_sffb_m.sffb007             #給予default值
            LET g_qryparam.default2 = g_sffb_m.sffb008             #製程序

            #給予arg
            LET g_qryparam.arg1 = g_site
            LET g_qryparam.arg2 = g_sffb_m.sffb005
            LET g_qryparam.arg3 = g_sffb_m.sffb006

            CALL q_sfcb003()                                #呼叫開窗

            LET g_sffb_m.sffb007 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_sffb_m.sffb008 = g_qryparam.return2 #製程序

            DISPLAY g_sffb_m.sffb007 TO sffb007              #顯示到畫面上
            DISPLAY g_sffb_m.sffb008 TO sffb008 #製程序

            NEXT FIELD sffb007                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.sffb008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffb008
            #add-point:ON ACTION controlp INFIELD sffb008 name="input.c.sffb008"
                                    #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_sffb_m.sffb007             #給予default值
            LET g_qryparam.default2 = g_sffb_m.sffb008             #製程序

            #給予arg
            LET g_qryparam.arg1 = g_site
            LET g_qryparam.arg2 = g_sffb_m.sffb005
            LET g_qryparam.arg3 = g_sffb_m.sffb006

            CALL q_sfcb003()                                #呼叫開窗

            LET g_sffb_m.sffb007 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_sffb_m.sffb008 = g_qryparam.return2 #製程序

            DISPLAY g_sffb_m.sffb007 TO sffb007              #顯示到畫面上
            DISPLAY g_sffb_m.sffb008 TO sffb008 #製程序

            NEXT FIELD sffb008                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.sffb029
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffb029
            #add-point:ON ACTION controlp INFIELD sffb029 name="input.c.sffb029"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_sffb_m.sffb029             #給予default值
            #給予arg
            LET g_qryparam.arg1 = g_sffb_m.sffb005


            CALL q_sfac001_1()                                #呼叫開窗

            LET g_sffb_m.sffb029 = g_qryparam.return1              
            DISPLAY g_sffb_m.sffb029 TO sffb029              #
            #DISPLAY g_sffb_m.sfac006 TO sfac006 #產品特徵
            NEXT FIELD sffb029                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.sffb009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffb009
            #add-point:ON ACTION controlp INFIELD sffb009 name="input.c.sffb009"
                                    #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_sffb_m.sffb009             #給予default值

            #給予arg

            CALL q_ecaa001_1()                                #呼叫開窗

            LET g_sffb_m.sffb009 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_sffb_m.sffb009 TO sffb009              #顯示到畫面上

            NEXT FIELD sffb009                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.sffb030
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffb030
            #add-point:ON ACTION controlp INFIELD sffb030 name="input.c.sffb030"
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_sffb_m.sffb030             #給予default值
            LET g_qryparam.default2 = "" #g_sffb_m.ooef001 #组织编号
            #給予arg
            #add--161013-00051#1 By shiun--(S)
            LET g_qryparam.arg1 = cl_get_today()   #161028-00053#1 本行mark還原
#            CALL q_ooef001()                                  #呼叫開窗
            CALL q_ooeg001_8()
            #add--161013-00051#1 By shiun--(E)

            LET g_sffb_m.sffb030 = g_qryparam.return1              
            #LET g_sffb_m.ooef001 = g_qryparam.return2 
            DISPLAY g_sffb_m.sffb030 TO sffb030              #
            #DISPLAY g_sffb_m.ooef001 TO ooef001 #组织编号
            NEXT FIELD sffb030                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.sffb004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffb004
            #add-point:ON ACTION controlp INFIELD sffb004 name="input.c.sffb004"
                                    #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_sffb_m.sffb004             #給予default值

            #給予arg

            CALL q_oogd001_01()                                #呼叫開窗

            LET g_sffb_m.sffb004 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_sffb_m.sffb004 TO sffb004              #顯示到畫面上

            NEXT FIELD sffb004                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.sffb010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffb010
            #add-point:ON ACTION controlp INFIELD sffb010 name="input.c.sffb010"
                                    #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_sffb_m.sffb010             #給予default值
            LET g_qryparam.where = " mrbasite ='",g_site,"' "
            #給予arg

            CALL q_mrba001()                                #呼叫開窗

            LET g_sffb_m.sffb010 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_sffb_m.sffb010 TO sffb010              #顯示到畫面上

            NEXT FIELD sffb010                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.sffb024
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffb024
            #add-point:ON ACTION controlp INFIELD sffb024 name="input.c.sffb024"
                                    #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_sffb_m.sffb024             #給予default值

            #給予arg

            CALL q_ooge001()                                #呼叫開窗

            LET g_sffb_m.sffb024 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_sffb_m.sffb024 TO sffb024              #顯示到畫面上

            NEXT FIELD sffb024                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.sffb011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffb011
            #add-point:ON ACTION controlp INFIELD sffb011 name="input.c.sffb011"
                                    
            #END add-point
 
 
         #Ctrlp:input.c.sffb012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffb012
            #add-point:ON ACTION controlp INFIELD sffb012 name="input.c.sffb012"
                                    
            #END add-point
 
 
         #Ctrlp:input.c.sffb013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffb013
            #add-point:ON ACTION controlp INFIELD sffb013 name="input.c.sffb013"
                                    
            #END add-point
 
 
         #Ctrlp:input.c.sffb014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffb014
            #add-point:ON ACTION controlp INFIELD sffb014 name="input.c.sffb014"
                                    
            #END add-point
 
 
         #Ctrlp:input.c.sffb015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffb015
            #add-point:ON ACTION controlp INFIELD sffb015 name="input.c.sffb015"
                                    
            #END add-point
 
 
         #Ctrlp:input.c.qty
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD qty
            #add-point:ON ACTION controlp INFIELD qty name="input.c.qty"
                                    
            #END add-point
 
 
         #Ctrlp:input.c.sffb017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffb017
            #add-point:ON ACTION controlp INFIELD sffb017 name="input.c.sffb017"
                                    
            #END add-point
 
 
         #Ctrlp:input.c.sffb018
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffb018
            #add-point:ON ACTION controlp INFIELD sffb018 name="input.c.sffb018"
                                    
            #END add-point
 
 
         #Ctrlp:input.c.sffb019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffb019
            #add-point:ON ACTION controlp INFIELD sffb019 name="input.c.sffb019"
                                    
            #END add-point
 
 
         #Ctrlp:input.c.sffb020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffb020
            #add-point:ON ACTION controlp INFIELD sffb020 name="input.c.sffb020"
                                    
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_sffb_m.sffbdocno,g_sffb_m.sffbseq
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               CALL s_aooi200_gen_docno(g_site,g_sffb_m.sffbdocno,g_sffb_m.sffbdocdt,g_prog) RETURNING l_success,g_sffb_m.sffbdocno
               IF NOT l_success THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'apm-00003'
                  LET g_errparam.extend = g_sffb_m.sffbdocno
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  NEXT FIELD sffbdocno
               END IF
               IF g_sffb_m.sffb007 IS NULL THEN LET g_sffb_m.sffb007 = ' ' END IF
               IF g_sffb_m.sffb008 IS NULL THEN LET g_sffb_m.sffb008 = ' ' END IF
               #161202-00018 add----s-----------
               IF g_sffb_m.sffb012 < l_sfaadocdt THEN 
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'asf-00815'
                  LET g_errparam.extend = '工单单据日期：',l_sfaadocdt
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  NEXT FIELD sffb012               
               END IF
               #161202-00018 add----e--------------
               #end add-point
               
               INSERT INTO sffb_t (sffbent,sffbdocno,sffbseq,sffb001,sffb002,sffbdocdt,sffb003,sffbsite, 
                   sffbstus,sffb005,sffb006,sffb007,sffb008,sffb029,sffb009,sffb030,sffb004,sffb010, 
                   sffb024,sffb011,sffb012,sffb013,sffb014,sffb015,sffb016,sffb017,sffb018,sffb019,sffb020, 
                   sffbownid,sffbowndp,sffbcrtid,sffbcrtdp,sffbcrtdt,sffbmodid,sffbmoddt,sffbcnfid,sffbcnfdt) 
 
               VALUES (g_enterprise,g_sffb_m.sffbdocno,g_sffb_m.sffbseq,g_sffb_m.sffb001,g_sffb_m.sffb002, 
                   g_sffb_m.sffbdocdt,g_sffb_m.sffb003,g_sffb_m.sffbsite,g_sffb_m.sffbstus,g_sffb_m.sffb005, 
                   g_sffb_m.sffb006,g_sffb_m.sffb007,g_sffb_m.sffb008,g_sffb_m.sffb029,g_sffb_m.sffb009, 
                   g_sffb_m.sffb030,g_sffb_m.sffb004,g_sffb_m.sffb010,g_sffb_m.sffb024,g_sffb_m.sffb011, 
                   g_sffb_m.sffb012,g_sffb_m.sffb013,g_sffb_m.sffb014,g_sffb_m.sffb015,g_sffb_m.sffb016, 
                   g_sffb_m.sffb017,g_sffb_m.sffb018,g_sffb_m.sffb019,g_sffb_m.sffb020,g_sffb_m.sffbownid, 
                   g_sffb_m.sffbowndp,g_sffb_m.sffbcrtid,g_sffb_m.sffbcrtdp,g_sffb_m.sffbcrtdt,g_sffb_m.sffbmodid, 
                   g_sffb_m.sffbmoddt,g_sffb_m.sffbcnfid,g_sffb_m.sffbcnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_sffb_m:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭新增中 name="input.head.m_insert"
                                             
               #end add-point
               
               
               
               
               #add-point:單頭新增後 name="input.head.a_insert"
               #新增时联动产生check单身资料
               IF NOT s_asft335_ins_sffc(g_sffb_m.sffbdocno,g_sffb_m.sffbseq) THEN
                  CALL s_transaction_end('N','0')
                  EXIT DIALOG
               END IF
               IF NOT s_asft335_ins_sfha(g_sffb_m.sffbdocno,g_sffb_m.sffbseq,g_sffb_m.sffb019) THEN
                  CALL s_transaction_end('N','0')
                  EXIT DIALOG
               END IF 
               #end add-point
               CALL s_transaction_end('Y','0') 
               
               IF l_cmd_t = 'r' AND p_cmd = 'a' THEN
                  CALL asft335_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL asft335_b_fill()
                  CALL asft335_b_fill2('0')
               END IF
               
               #add-point:單頭新增後 name="input.head.a_insert2"
               
               #end add-point
               
               LET g_master_insert = TRUE
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前 name="input.head.b_update"
               IF g_sffb_m.sffb007 IS NULL THEN LET g_sffb_m.sffb007 = ' ' END IF
               IF g_sffb_m.sffb008 IS NULL THEN LET g_sffb_m.sffb008 = ' ' END IF                                             
               #end add-point
               
               #將遮罩欄位還原
               CALL asft335_sffb_t_mask_restore('restore_mask_o')
               
               UPDATE sffb_t SET (sffbdocno,sffbseq,sffb001,sffb002,sffbdocdt,sffb003,sffbsite,sffbstus, 
                   sffb005,sffb006,sffb007,sffb008,sffb029,sffb009,sffb030,sffb004,sffb010,sffb024,sffb011, 
                   sffb012,sffb013,sffb014,sffb015,sffb016,sffb017,sffb018,sffb019,sffb020,sffbownid, 
                   sffbowndp,sffbcrtid,sffbcrtdp,sffbcrtdt,sffbmodid,sffbmoddt,sffbcnfid,sffbcnfdt) = (g_sffb_m.sffbdocno, 
                   g_sffb_m.sffbseq,g_sffb_m.sffb001,g_sffb_m.sffb002,g_sffb_m.sffbdocdt,g_sffb_m.sffb003, 
                   g_sffb_m.sffbsite,g_sffb_m.sffbstus,g_sffb_m.sffb005,g_sffb_m.sffb006,g_sffb_m.sffb007, 
                   g_sffb_m.sffb008,g_sffb_m.sffb029,g_sffb_m.sffb009,g_sffb_m.sffb030,g_sffb_m.sffb004, 
                   g_sffb_m.sffb010,g_sffb_m.sffb024,g_sffb_m.sffb011,g_sffb_m.sffb012,g_sffb_m.sffb013, 
                   g_sffb_m.sffb014,g_sffb_m.sffb015,g_sffb_m.sffb016,g_sffb_m.sffb017,g_sffb_m.sffb018, 
                   g_sffb_m.sffb019,g_sffb_m.sffb020,g_sffb_m.sffbownid,g_sffb_m.sffbowndp,g_sffb_m.sffbcrtid, 
                   g_sffb_m.sffbcrtdp,g_sffb_m.sffbcrtdt,g_sffb_m.sffbmodid,g_sffb_m.sffbmoddt,g_sffb_m.sffbcnfid, 
                   g_sffb_m.sffbcnfdt)
                WHERE sffbent = g_enterprise AND sffbdocno = g_sffbdocno_t
                  AND sffbseq = g_sffbseq_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "sffb_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
                                             
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL asft335_sffb_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_sffb_m_t)
               LET g_log2 = util.JSON.stringify(g_sffb_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
                                             
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_sffbdocno_t = g_sffb_m.sffbdocno
            LET g_sffbseq_t = g_sffb_m.sffbseq
 
            
      END INPUT
   
 
{</section>}
 
{<section id="asft335.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_sffd_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_sffd_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL asft335_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_sffd_d.getLength()
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
            OPEN asft335_cl USING g_enterprise,g_sffb_m.sffbdocno,g_sffb_m.sffbseq
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN asft335_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE asft335_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_sffd_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_sffd_d[l_ac].sffdseq1 IS NOT NULL
               AND g_sffd_d[l_ac].sffd001 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_sffd_d_t.* = g_sffd_d[l_ac].*  #BACKUP
               LET g_sffd_d_o.* = g_sffd_d[l_ac].*  #BACKUP
               CALL asft335_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
                                             
               #end add-point  
               CALL asft335_set_no_entry_b(l_cmd)
               IF NOT asft335_lock_b("sffd_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH asft335_bcl INTO g_sffd_d[l_ac].sffdseq1,g_sffd_d[l_ac].sffd001,g_sffd_d[l_ac].sffd002, 
                      g_sffd_d[l_ac].sffd003
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_sffd_d_t.sffdseq1,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_sffd_d_mask_o[l_ac].* =  g_sffd_d[l_ac].*
                  CALL asft335_sffd_t_mask()
                  LET g_sffd_d_mask_n[l_ac].* =  g_sffd_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL asft335_show()
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
            INITIALIZE g_sffd_d[l_ac].* TO NULL 
            INITIALIZE g_sffd_d_t.* TO NULL 
            INITIALIZE g_sffd_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
            
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_sffd_d_t.* = g_sffd_d[l_ac].*     #新輸入資料
            LET g_sffd_d_o.* = g_sffd_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL asft335_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
                                    
            #end add-point
            CALL asft335_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_sffd_d[li_reproduce_target].* = g_sffd_d[li_reproduce].*
 
               LET g_sffd_d[li_reproduce_target].sffdseq1 = NULL
               LET g_sffd_d[li_reproduce_target].sffd001 = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            IF g_sffd_d[l_ac].sffdseq1 IS NULL OR g_sffd_d[l_ac].sffdseq1 = 0 THEN
               SELECT MAX(sffdseq1)+1 INTO g_sffd_d[l_ac].sffdseq1
                 FROM sffd_t
                WHERE sffdent   = g_enterprise 
                  AND sffddocno = g_sffb_m.sffbdocno 
                  AND sffdseq   = g_sffb_m.sffbseq 
            END IF
            IF g_sffd_d[l_ac].sffdseq1 IS NULL THEN
               LET g_sffd_d[l_ac].sffdseq1 = 1
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
            SELECT COUNT(1) INTO l_count FROM sffd_t 
             WHERE sffdent = g_enterprise AND sffddocno = g_sffb_m.sffbdocno
               AND sffdseq = g_sffb_m.sffbseq
 
               AND sffdseq1 = g_sffd_d[l_ac].sffdseq1
               AND sffd001 = g_sffd_d[l_ac].sffd001
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
                                             
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_sffb_m.sffbdocno
               LET gs_keys[2] = g_sffb_m.sffbseq
               LET gs_keys[3] = g_sffd_d[g_detail_idx].sffdseq1
               LET gs_keys[4] = g_sffd_d[g_detail_idx].sffd001
               CALL asft335_insert_b('sffd_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
                                             
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_sffd_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "sffd_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL asft335_b_fill()
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
               LET gs_keys[01] = g_sffb_m.sffbdocno
               LET gs_keys[gs_keys.getLength()+1] = g_sffb_m.sffbseq
 
               LET gs_keys[gs_keys.getLength()+1] = g_sffd_d_t.sffdseq1
               LET gs_keys[gs_keys.getLength()+1] = g_sffd_d_t.sffd001
 
            
               #刪除同層單身
               IF NOT asft335_delete_b('sffd_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE asft335_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT asft335_key_delete_b(gs_keys,'sffd_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE asft335_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
                                             
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE asft335_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
                                                      
               #end add-point
               LET l_count = g_sffd_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
                                    
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_sffd_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffdseq1
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_sffd_d[l_ac].sffdseq1,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD sffdseq1
            END IF 
 
 
 
            #add-point:AFTER FIELD sffdseq1 name="input.a.page1.sffdseq1"
            IF NOT cl_null(g_sffd_d[l_ac].sffdseq1) THEN 
            #此段落由子樣板a05產生
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_sffd_d_t.sffdseq1 IS NULL OR g_sffd_d[l_ac].sffdseq1 <>g_sffd_d_t.sffdseq1 )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM sffd_t WHERE "||"sffdent = '" ||g_enterprise|| "' AND "||"sffddocno = '"||g_sffb_m.sffbdocno ||"' AND "|| "sffdseq = '"||g_sffb_m.sffbseq ||"' AND "|| "sffdseq1 = '"||g_sffd_d[g_detail_idx].sffdseq1||"'",'std-00004',0) THEN 
                     LET g_sffd_d[l_ac].sffdseq1 = g_sffd_d_t.sffdseq1
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffdseq1
            #add-point:BEFORE FIELD sffdseq1 name="input.b.page1.sffdseq1"
            IF g_sffd_d[l_ac].sffdseq1 IS NULL OR g_sffd_d[l_ac].sffdseq1 = 0 THEN
               SELECT MAX(sffdseq1)+1 INTO g_sffd_d[l_ac].sffdseq1
                 FROM sffd_t
                WHERE sffdent   = g_enterprise 
                  AND sffddocno = g_sffb_m.sffbdocno 
                  AND sffdseq   = g_sffb_m.sffbseq 
            END IF
            IF g_sffd_d[l_ac].sffdseq1 IS NULL THEN
               LET g_sffd_d[l_ac].sffdseq1 = 1
            END IF 
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sffdseq1
            #add-point:ON CHANGE sffdseq1 name="input.g.page1.sffdseq1"
                                    
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffd001
            
            #add-point:AFTER FIELD sffd001 name="input.a.page1.sffd001"
            IF NOT cl_null(g_sffd_d[l_ac].sffd001) THEN 
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_sffd_d_t.sffd001 IS NULL OR g_sffd_d[l_ac].sffd001 <> g_sffd_d_t.sffd001)) THEN
#此段落由子樣板a19產生
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  LET g_errshow = TRUE #是否開窗 #160318-00025#34  add
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_sffd_d[l_ac].sffd001
			         LET g_chkparam.err_str[1] = "aqc-00032:sub-01302|aqci030|",cl_get_progname("aqci030",g_lang,"2"),"|:EXEPROGaooi130"  #160318-00025#34  add      #liuym170323 modify aooi130-->aqci030
                  LET g_chkparam.err_str[2] = "aqc-00031:sub-01303|aqci030|",cl_get_progname("aqci030",g_lang,"2"),"|:EXEPROGaooi130"  #160318-00025#34  add      #liuym170323 modify aooi130-->aqci030
                  #呼叫檢查存在並帶值的library
                  IF cl_chk_exist("v_oocq002_1053") THEN
                     #檢查成功時後續處理
                     #LET  = g_chkparam.return1
                     #DISPLAY BY NAME 
			      
                  ELSE
                     #檢查失敗時後續處理
                     NEXT FIELD CURRENT
                  END IF
               END IF 
            

            END IF 
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_sffd_d[l_ac].sffd001
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='1053' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_sffd_d[l_ac].sffd001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_sffd_d[l_ac].sffd001_desc

            #此段落由子樣板a05產生
            IF  NOT cl_null(g_sffb_m.sffbdocno) AND NOT cl_null(g_sffb_m.sffbseq) AND NOT cl_null(g_sffd_d[g_detail_idx].sffdseq1) AND NOT cl_null(g_sffd_d[g_detail_idx].sffd001) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_sffb_m.sffbdocno != g_sffbdocno_t OR g_sffb_m.sffbseq != g_sffbseq_t OR g_sffd_d[g_detail_idx].sffdseq1 != g_sffd_d_t.sffdseq1 OR g_sffd_d[g_detail_idx].sffd001 != g_sffd_d_t.sffd001)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM sffd_t WHERE "||"sffdent = '" ||g_enterprise|| "' AND "||"sffddocno = '"||g_sffb_m.sffbdocno ||"' AND "|| "sffdseq = '"||g_sffb_m.sffbseq ||"' AND "|| "sffdseq1 = '"||g_sffd_d[g_detail_idx].sffdseq1 ||"' AND "|| "sffd001 = '"||g_sffd_d[g_detail_idx].sffd001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffd001
            #add-point:BEFORE FIELD sffd001 name="input.b.page1.sffd001"
                                    
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sffd001
            #add-point:ON CHANGE sffd001 name="input.g.page1.sffd001"
                                    
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffd002
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_sffd_d[l_ac].sffd002,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD sffd002
            END IF 
 
 
 
            #add-point:AFTER FIELD sffd002 name="input.a.page1.sffd002"
                                                IF NOT cl_null(g_sffd_d[l_ac].sffd002) THEN 
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffd002
            #add-point:BEFORE FIELD sffd002 name="input.b.page1.sffd002"
                                    
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sffd002
            #add-point:ON CHANGE sffd002 name="input.g.page1.sffd002"
                                    
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffd003
            #add-point:BEFORE FIELD sffd003 name="input.b.page1.sffd003"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffd003
            
            #add-point:AFTER FIELD sffd003 name="input.a.page1.sffd003"
                                    
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sffd003
            #add-point:ON CHANGE sffd003 name="input.g.page1.sffd003"
                                    
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.sffdseq1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffdseq1
            #add-point:ON ACTION controlp INFIELD sffdseq1 name="input.c.page1.sffdseq1"
                                    
            #END add-point
 
 
         #Ctrlp:input.c.page1.sffd001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffd001
            #add-point:ON ACTION controlp INFIELD sffd001 name="input.c.page1.sffd001"
                                    #此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_sffd_d[l_ac].sffd001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "1053" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_sffd_d[l_ac].sffd001 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_sffd_d[l_ac].sffd001 TO sffd001              #顯示到畫面上

            NEXT FIELD sffd001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.sffd002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffd002
            #add-point:ON ACTION controlp INFIELD sffd002 name="input.c.page1.sffd002"
                                    
            #END add-point
 
 
         #Ctrlp:input.c.page1.sffd003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffd003
            #add-point:ON ACTION controlp INFIELD sffd003 name="input.c.page1.sffd003"
                                    
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_sffd_d[l_ac].* = g_sffd_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE asft335_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_sffd_d[l_ac].sffdseq1 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_sffd_d[l_ac].* = g_sffd_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
                                             
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL asft335_sffd_t_mask_restore('restore_mask_o')
      
               UPDATE sffd_t SET (sffddocno,sffdseq,sffdseq1,sffd001,sffd002,sffd003) = (g_sffb_m.sffbdocno, 
                   g_sffb_m.sffbseq,g_sffd_d[l_ac].sffdseq1,g_sffd_d[l_ac].sffd001,g_sffd_d[l_ac].sffd002, 
                   g_sffd_d[l_ac].sffd003)
                WHERE sffdent = g_enterprise AND sffddocno = g_sffb_m.sffbdocno 
                  AND sffdseq = g_sffb_m.sffbseq 
 
                  AND sffdseq1 = g_sffd_d_t.sffdseq1 #項次   
                  AND sffd001 = g_sffd_d_t.sffd001  
 
                  
               #add-point:單身修改中 name="input.body.m_update"
                                             
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_sffd_d[l_ac].* = g_sffd_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "sffd_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_sffd_d[l_ac].* = g_sffd_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "sffd_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_sffb_m.sffbdocno
               LET gs_keys_bak[1] = g_sffbdocno_t
               LET gs_keys[2] = g_sffb_m.sffbseq
               LET gs_keys_bak[2] = g_sffbseq_t
               LET gs_keys[3] = g_sffd_d[g_detail_idx].sffdseq1
               LET gs_keys_bak[3] = g_sffd_d_t.sffdseq1
               LET gs_keys[4] = g_sffd_d[g_detail_idx].sffd001
               LET gs_keys_bak[4] = g_sffd_d_t.sffd001
               CALL asft335_update_b('sffd_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL asft335_sffd_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_sffd_d[g_detail_idx].sffdseq1 = g_sffd_d_t.sffdseq1 
                  AND g_sffd_d[g_detail_idx].sffd001 = g_sffd_d_t.sffd001 
 
                  ) THEN
                  LET gs_keys[01] = g_sffb_m.sffbdocno
                  LET gs_keys[gs_keys.getLength()+1] = g_sffb_m.sffbseq
 
                  LET gs_keys[gs_keys.getLength()+1] = g_sffd_d_t.sffdseq1
                  LET gs_keys[gs_keys.getLength()+1] = g_sffd_d_t.sffd001
 
                  CALL asft335_key_update_b(gs_keys,'sffd_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_sffb_m),util.JSON.stringify(g_sffd_d_t)
               LET g_log2 = util.JSON.stringify(g_sffb_m),util.JSON.stringify(g_sffd_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
                                             
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
                                    
            #end add-point
            CALL asft335_unlock_b("sffd_t","'1'")
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
               LET g_sffd_d[li_reproduce_target].* = g_sffd_d[li_reproduce].*
 
               LET g_sffd_d[li_reproduce_target].sffdseq1 = NULL
               LET g_sffd_d[li_reproduce_target].sffd001 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_sffd_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_sffd_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
      INPUT ARRAY g_sffd2_d FROM s_detail2.*
         ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                 INSERT ROW = FALSE, #此頁面insert功能由產生器控制, 手動之設定無效! 
 
                 DELETE ROW = FALSE,
                 APPEND ROW = FALSE)
                 
         #自訂ACTION(detail_input,page_2)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body2.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_sffd2_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL asft335_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'd' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'2',"))
            END IF
            LET g_loc = 'd'
            LET g_rec_b = g_sffd2_d.getLength()
            #add-point:資料輸入前 name="input.body2.before_input"
                                    
            #end add-point
            
         BEFORE INSERT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_sffd2_d[l_ac].* TO NULL 
            INITIALIZE g_sffd2_d_t.* TO NULL 
            INITIALIZE g_sffd2_d_o.* TO NULL 
            #公用欄位給值(單身2)
            
            #自定義預設值(單身2)
            
            #add-point:modify段before備份 name="input.body2.insert.before_bak"
            
            #end add-point
            LET g_sffd2_d_t.* = g_sffd2_d[l_ac].*     #新輸入資料
            LET g_sffd2_d_o.* = g_sffd2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL asft335_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body2.insert.after_set_entry_b"
                                    
            #end add-point
            CALL asft335_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_sffd2_d[li_reproduce_target].* = g_sffd2_d[li_reproduce].*
 
               LET g_sffd2_d[li_reproduce_target].sffc001 = NULL
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
            OPEN asft335_cl USING g_enterprise,g_sffb_m.sffbdocno,g_sffb_m.sffbseq
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN asft335_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE asft335_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_sffd2_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_sffd2_d[l_ac].sffc001 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_sffd2_d_t.* = g_sffd2_d[l_ac].*  #BACKUP
               LET g_sffd2_d_o.* = g_sffd2_d[l_ac].*  #BACKUP
               CALL asft335_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body2.after_set_entry_b"
                                             
               #end add-point  
               CALL asft335_set_no_entry_b(l_cmd)
               IF NOT asft335_lock_b("sffc_t","'2'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH asft335_bcl2 INTO g_sffd2_d[l_ac].sffc001,g_sffd2_d[l_ac].sffc002,g_sffd2_d[l_ac].sffc003, 
                      g_sffd2_d[l_ac].sffc004,g_sffd2_d[l_ac].sffc005,g_sffd2_d[l_ac].sffc006
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = SQLERRMESSAGE  
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_sffd2_d_mask_o[l_ac].* =  g_sffd2_d[l_ac].*
                  CALL asft335_sffc_t_mask()
                  LET g_sffd2_d_mask_n[l_ac].* =  g_sffd2_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL asft335_show()
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
               LET gs_keys[01] = g_sffb_m.sffbdocno
               LET gs_keys[gs_keys.getLength()+1] = g_sffb_m.sffbseq
               LET gs_keys[gs_keys.getLength()+1] = g_sffd2_d_t.sffc001
            
               #刪除同層單身
               IF NOT asft335_delete_b('sffc_t',gs_keys,"'2'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE asft335_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT asft335_key_delete_b(gs_keys,'sffc_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE asft335_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身2刪除中 name="input.body2.m_delete"
                                             
               #end add-point    
               
               CALL s_transaction_end('Y','0')
               CLOSE asft335_bcl
 
               LET g_rec_b = g_rec_b-1
               #add-point:單身2刪除後 name="input.body2.a_delete"
                                                      
               #end add-point
               LET l_count = g_sffd_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body2.after_delete"
                                    
               #end add-point
            END IF 
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_sffd2_d.getLength() + 1) THEN
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
            SELECT COUNT(1) INTO l_count FROM sffc_t 
             WHERE sffcent = g_enterprise AND sffcdocno = g_sffb_m.sffbdocno
               AND sffcseq = g_sffb_m.sffbseq
               AND sffc001 = g_sffd2_d[l_ac].sffc001
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身2新增前 name="input.body2.b_insert"
                                             
               #end add-point
            
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_sffb_m.sffbdocno
               LET gs_keys[2] = g_sffb_m.sffbseq
               LET gs_keys[3] = g_sffd2_d[g_detail_idx].sffc001
               CALL asft335_insert_b('sffc_t',gs_keys,"'2'")
                           
               #add-point:單身新增後2 name="input.body2.a_insert"
                                             
               #end add-point
            ELSE    
               INITIALIZE g_sffd_d[l_ac].* TO NULL
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
               LET g_errparam.extend = "sffc_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL asft335_b_fill()
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
               LET g_sffd2_d[l_ac].* = g_sffd2_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE asft335_bcl2
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
               LET g_sffd2_d[l_ac].* = g_sffd2_d_t.*
            ELSE
               #add-point:單身page2修改前 name="input.body2.b_update"
                                             
               #end add-point
               
               #寫入修改者/修改日期資訊(單身2)
               
               
               #將遮罩欄位還原
               CALL asft335_sffc_t_mask_restore('restore_mask_o')
                              
               UPDATE sffc_t SET (sffcdocno,sffcseq,sffc001,sffc002,sffc003,sffc004,sffc005,sffc006) = (g_sffb_m.sffbdocno, 
                   g_sffb_m.sffbseq,g_sffd2_d[l_ac].sffc001,g_sffd2_d[l_ac].sffc002,g_sffd2_d[l_ac].sffc003, 
                   g_sffd2_d[l_ac].sffc004,g_sffd2_d[l_ac].sffc005,g_sffd2_d[l_ac].sffc006) #自訂欄位頁簽 
 
                WHERE sffcent = g_enterprise AND sffcdocno = g_sffb_m.sffbdocno
                  AND sffcseq = g_sffb_m.sffbseq
                  AND sffc001 = g_sffd2_d_t.sffc001 #項次 
                  
               #add-point:單身page2修改中 name="input.body2.m_update"
                                             
               #end add-point
                  
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_sffd2_d[l_ac].* = g_sffd2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "sffc_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_sffd2_d[l_ac].* = g_sffd2_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "sffc_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_sffb_m.sffbdocno
               LET gs_keys_bak[1] = g_sffbdocno_t
               LET gs_keys[2] = g_sffb_m.sffbseq
               LET gs_keys_bak[2] = g_sffbseq_t
               LET gs_keys[3] = g_sffd2_d[g_detail_idx].sffc001
               LET gs_keys_bak[3] = g_sffd2_d_t.sffc001
               CALL asft335_update_b('sffc_t',gs_keys,gs_keys_bak,"'2'")
               END CASE
               
               #將遮罩欄位進行遮蔽
               CALL asft335_sffc_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT (g_sffd2_d[g_detail_idx].sffc001 = g_sffd2_d_t.sffc001 
                  ) THEN
                  LET gs_keys[01] = g_sffb_m.sffbdocno
                  LET gs_keys[gs_keys.getLength()+1] = g_sffb_m.sffbseq
                  LET gs_keys[gs_keys.getLength()+1] = g_sffd2_d_t.sffc001
                  CALL asft335_key_update_b(gs_keys,'sffc_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_sffb_m),util.JSON.stringify(g_sffd2_d_t)
               LET g_log2 = util.JSON.stringify(g_sffb_m),util.JSON.stringify(g_sffd2_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身page2修改後 name="input.body2.a_update"
                                             
               #end add-point
            END IF
         
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sffc005
            #add-point:BEFORE FIELD sffc005 name="input.b.page2.sffc005"
                                    
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sffc005
            
            #add-point:AFTER FIELD sffc005 name="input.a.page2.sffc005"
            IF g_sffd2_d[l_ac].sffc005 IS NULL AND g_sffd2_d[l_ac].sffc006 = 'Y' THEN
               NEXT FIELD sffc005
            END IF
            IF g_sffd2_d[l_ac].sffc002 = '1' AND NOT cl_null(g_sffd2_d[l_ac].sffc003) THEN
               IF NOT s_chr_alphanumeric(g_sffd2_d[l_ac].sffc005,1) THEN
                  LET g_sffd2_d[l_ac].sffc005 = g_sffd2_d_t.sffc005
                  NEXT FIELD sffc005
               END IF
               IF NOT cl_null(g_sffd2_d[l_ac].sffc003) THEN
                  IF g_sffd2_d[l_ac].sffc005 < g_sffd2_d[l_ac].sffc003 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'asf-00195'
                     LET g_errparam.extend = g_sffd2_d[l_ac].sffc005
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_sffd2_d[l_ac].sffc005 = g_sffd2_d_t.sffc005
                     NEXT FIELD sffc005
                  END IF
               END IF
               IF NOT cl_null(g_sffd2_d[l_ac].sffc004) THEN
                  IF g_sffd2_d[l_ac].sffc005 > g_sffd2_d[l_ac].sffc004 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'asf-00195'
                     LET g_errparam.extend = g_sffd2_d[l_ac].sffc005
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_sffd2_d[l_ac].sffc005 = g_sffd2_d_t.sffc005
                     NEXT FIELD sffc005
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sffc005
            #add-point:ON CHANGE sffc005 name="input.g.page2.sffc005"
                                    
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page2.sffc005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sffc005
            #add-point:ON ACTION controlp INFIELD sffc005 name="input.c.page2.sffc005"
                                    
            #END add-point
 
 
 
 
         AFTER ROW
            #add-point:單身page2 after_row name="input.body2.after_row"
                                    
            #end add-point
            LET l_ac = ARR_CURR()
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               IF l_cmd = 'u' THEN
                  LET g_sffd2_d[l_ac].* = g_sffd2_d_t.*
               END IF
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE asft335_bcl2
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
            
            #其他table進行unlock
            
            CALL asft335_unlock_b("sffc_t","'2'")
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
               LET g_sffd2_d[li_reproduce_target].* = g_sffd2_d[li_reproduce].*
 
               LET g_sffd2_d[li_reproduce_target].sffc001 = NULL
            ELSE
               CALL FGL_SET_ARR_CURR(g_sffd2_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_sffd2_d.getLength()+1
            END IF
            
      END INPUT
 
      
 
 
 
 
{</section>}
 
{<section id="asft335.input.other" >}
      
      #add-point:自定義input name="input.more_input"
                  
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
                           
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
         CALL DIALOG.setCurrentRow("s_detail2",g_idx_group.getValue("'2',"))
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD sffbdocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD sffdseq1
               WHEN "s_detail2"
                  NEXT FIELD sffc001
 
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
         
   #end add-point    
 
END FUNCTION
 
{</section>}
 
{<section id="asft335.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION asft335_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   DEFINE l_sffb006 LIKE sffb_t.sffb006
   DEFINE l_sffb007 LIKE sffb_t.sffb007
   DEFINE l_sffb008 LIKE sffb_t.sffb008
   DEFINE l_sffb009 LIKE sffb_t.sffb009
   DEFINE l_sffb029 LIKE sffb_t.sffb029
   DEFINE l_sffb030 LIKE sffb_t.sffb030   #fengmy151013 
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
         
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL asft335_b_fill() #單身填充
      CALL asft335_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL asft335_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
#动态隐藏调用当站下线的action
            IF g_sffb_m.sffb001 = '3' THEN
               CALL cl_set_act_visible_toolbaritem("call_asft337", TRUE)
            ELSE
               CALL cl_set_act_visible_toolbaritem("call_asft337", FALSE)
            END IF
#手工增加料号，品名规格，待处理数量的显示
            CALL s_asft335_default_sffb056(g_sffb_m.sffb001,g_sffb_m.sffb005,g_sffb_m.sffb006,g_sffb_m.sffb007,g_sffb_m.sffb008)
            RETURNING l_sffb029,l_sffb006,l_sffb007,l_sffb008,l_sffb009,l_sffb030 #fengmy151013 add sffb030  

            LET g_sffb_m.sffbdocno_desc = s_aooi200_get_slip_desc(g_sffb_m.sffbdocno)

            CALL s_desc_get_item_desc(g_sffb_m.sffb029)
            RETURNING g_sffb_m.sffb029_desc,g_sffb_m.sffb029_desc_1            
   #end add-point
   
   #遮罩相關處理
   LET g_sffb_m_mask_o.* =  g_sffb_m.*
   CALL asft335_sffb_t_mask()
   LET g_sffb_m_mask_n.* =  g_sffb_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_sffb_m.sffbdocno,g_sffb_m.sffbseq,g_sffb_m.sffb001,g_sffb_m.sffb002,g_sffb_m.sffb002_desc, 
       g_sffb_m.sffbdocno_desc,g_sffb_m.sffbdocdt,g_sffb_m.sffb003,g_sffb_m.sffb003_desc,g_sffb_m.sffbsite, 
       g_sffb_m.sffbstus,g_sffb_m.sffb005,g_sffb_m.sffb006,g_sffb_m.sffb007,g_sffb_m.sffb007_desc,g_sffb_m.sffb008, 
       g_sffb_m.sffb029,g_sffb_m.sffb029_desc,g_sffb_m.sffb029_desc_1,g_sffb_m.sffb009,g_sffb_m.sffb009_desc, 
       g_sffb_m.sffb030,g_sffb_m.sffb030_desc,g_sffb_m.sffb004,g_sffb_m.sffb004_desc,g_sffb_m.sffb010, 
       g_sffb_m.sffb010_desc,g_sffb_m.sffb024,g_sffb_m.sffb024_desc,g_sffb_m.sffb011,g_sffb_m.sffb012, 
       g_sffb_m.sffb013,g_sffb_m.sffb014,g_sffb_m.sffb015,g_sffb_m.qty,g_sffb_m.sffb016,g_sffb_m.sffb017, 
       g_sffb_m.sffb018,g_sffb_m.sffb019,g_sffb_m.sffb020,g_sffb_m.sffbownid,g_sffb_m.sffbownid_desc, 
       g_sffb_m.sffbowndp,g_sffb_m.sffbowndp_desc,g_sffb_m.sffbcrtid,g_sffb_m.sffbcrtid_desc,g_sffb_m.sffbcrtdp, 
       g_sffb_m.sffbcrtdp_desc,g_sffb_m.sffbcrtdt,g_sffb_m.sffbmodid,g_sffb_m.sffbmodid_desc,g_sffb_m.sffbmoddt, 
       g_sffb_m.sffbcnfid,g_sffb_m.sffbcnfid_desc,g_sffb_m.sffbcnfdt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_sffb_m.sffbstus 
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
   FOR l_ac = 1 TO g_sffd_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
 
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_sffd2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
 
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
         
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL asft335_detail_show()
 
   #add-point:show段之後 name="show.after"
          #显示待处理数量
   CALL s_asft335_set_qty(g_sffb_m.sffbdocno,g_sffb_m.sffbseq,g_sffb_m.sffb001,g_sffb_m.sffb005,g_sffb_m.sffb006,g_sffb_m.sffb007,g_sffb_m.sffb008) RETURNING g_sffb_m.qty,g_sffb_m.sffb016
   DISPLAY BY NAME g_sffb_m.qty,g_sffb_m.sffb016
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="asft335.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION asft335_detail_show()
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
 
{<section id="asft335.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION asft335_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE sffb_t.sffbdocno 
   DEFINE l_oldno     LIKE sffb_t.sffbdocno 
   DEFINE l_newno02     LIKE sffb_t.sffbseq 
   DEFINE l_oldno02     LIKE sffb_t.sffbseq 
 
   DEFINE l_master    RECORD LIKE sffb_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE sffd_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE sffc_t.* #此變數樣板目前無使用
 
 
 
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
#对于在asrt330里产生的资料，这边只能看不能动  这里少add point啊～
   IF g_sffb_m.sffbseq > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00325'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF         
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
   
   IF g_sffb_m.sffbdocno IS NULL
   OR g_sffb_m.sffbseq IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_sffbdocno_t = g_sffb_m.sffbdocno
   LET g_sffbseq_t = g_sffb_m.sffbseq
 
    
   LET g_sffb_m.sffbdocno = ""
   LET g_sffb_m.sffbseq = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_sffb_m.sffbownid = g_user
      LET g_sffb_m.sffbowndp = g_dept
      LET g_sffb_m.sffbcrtid = g_user
      LET g_sffb_m.sffbcrtdp = g_dept 
      LET g_sffb_m.sffbcrtdt = cl_get_current()
      LET g_sffb_m.sffbmodid = g_user
      LET g_sffb_m.sffbmoddt = cl_get_current()
      LET g_sffb_m.sffbstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   LET g_sffb_m.sffbcnfid = ""
   LET g_sffb_m.sffbcnfdt = ""
   LET g_sffb_m.sffbseq = "0"         
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_sffb_m.sffbstus 
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
      LET g_sffb_m.sffbdocno_desc = ''
   DISPLAY BY NAME g_sffb_m.sffbdocno_desc
 
   
   CALL asft335_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_sffb_m.* TO NULL
      INITIALIZE g_sffd_d TO NULL
      INITIALIZE g_sffd2_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL asft335_show()
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
   CALL asft335_set_act_visible()   
   CALL asft335_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_sffbdocno_t = g_sffb_m.sffbdocno
   LET g_sffbseq_t = g_sffb_m.sffbseq
 
   
   #組合新增資料的條件
   LET g_add_browse = " sffbent = " ||g_enterprise|| " AND",
                      " sffbdocno = '", g_sffb_m.sffbdocno, "' "
                      ," AND sffbseq = '", g_sffb_m.sffbseq, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL asft335_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
         
   #end add-point
   
   CALL asft335_idx_chk()
   
   LET g_data_owner = g_sffb_m.sffbownid      
   LET g_data_dept  = g_sffb_m.sffbowndp
   
   #功能已完成,通報訊息中心
   CALL asft335_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="asft335.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION asft335_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE sffd_t.* #此變數樣板目前無使用
   DEFINE l_detail2    RECORD LIKE sffc_t.* #此變數樣板目前無使用
 
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
         
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE asft335_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
         
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM sffd_t
    WHERE sffdent = g_enterprise AND sffddocno = g_sffbdocno_t
     AND sffdseq = g_sffbseq_t
 
    INTO TEMP asft335_detail
 
   #將key修正為調整後   
   UPDATE asft335_detail 
      #更新key欄位
      SET sffddocno = g_sffb_m.sffbdocno
          , sffdseq = g_sffb_m.sffbseq
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO sffd_t SELECT * FROM asft335_detail
   
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
   DROP TABLE asft335_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
         
   #end add-point
 
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
         
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM sffc_t 
    WHERE sffcent = g_enterprise AND sffcdocno = g_sffbdocno_t
      AND sffcseq = g_sffbseq_t   
 
    INTO TEMP asft335_detail
 
   #將key修正為調整後   
   UPDATE asft335_detail SET sffcdocno = g_sffb_m.sffbdocno
                                       , sffcseq = g_sffb_m.sffbseq
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
 
   #將資料塞回原table   
   INSERT INTO sffc_t SELECT * FROM asft335_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
         
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE asft335_detail
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
         
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_sffbdocno_t = g_sffb_m.sffbdocno
   LET g_sffbseq_t = g_sffb_m.sffbseq
 
   
END FUNCTION
 
{</section>}
 
{<section id="asft335.delete" >}
#+ 資料刪除
PRIVATE FUNCTION asft335_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   IF g_sffb_m.sffbstus <> 'N' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'apm-00034'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF  
#对于在asrt330里产生的资料，这边只能看不能动
   IF g_sffb_m.sffbseq > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00325'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_sffb_m.sffbdocno IS NULL
   OR g_sffb_m.sffbseq IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN asft335_cl USING g_enterprise,g_sffb_m.sffbdocno,g_sffb_m.sffbseq
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN asft335_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE asft335_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE asft335_master_referesh USING g_sffb_m.sffbdocno,g_sffb_m.sffbseq INTO g_sffb_m.sffbdocno, 
       g_sffb_m.sffbseq,g_sffb_m.sffb001,g_sffb_m.sffb002,g_sffb_m.sffbdocdt,g_sffb_m.sffb003,g_sffb_m.sffbsite, 
       g_sffb_m.sffbstus,g_sffb_m.sffb005,g_sffb_m.sffb006,g_sffb_m.sffb007,g_sffb_m.sffb008,g_sffb_m.sffb029, 
       g_sffb_m.sffb009,g_sffb_m.sffb030,g_sffb_m.sffb004,g_sffb_m.sffb010,g_sffb_m.sffb024,g_sffb_m.sffb011, 
       g_sffb_m.sffb012,g_sffb_m.sffb013,g_sffb_m.sffb014,g_sffb_m.sffb015,g_sffb_m.sffb016,g_sffb_m.sffb017, 
       g_sffb_m.sffb018,g_sffb_m.sffb019,g_sffb_m.sffb020,g_sffb_m.sffbownid,g_sffb_m.sffbowndp,g_sffb_m.sffbcrtid, 
       g_sffb_m.sffbcrtdp,g_sffb_m.sffbcrtdt,g_sffb_m.sffbmodid,g_sffb_m.sffbmoddt,g_sffb_m.sffbcnfid, 
       g_sffb_m.sffbcnfdt,g_sffb_m.sffb002_desc,g_sffb_m.sffb003_desc,g_sffb_m.sffb007_desc,g_sffb_m.sffb009_desc, 
       g_sffb_m.sffb030_desc,g_sffb_m.sffb004_desc,g_sffb_m.sffb010_desc,g_sffb_m.sffb024_desc,g_sffb_m.sffbownid_desc, 
       g_sffb_m.sffbowndp_desc,g_sffb_m.sffbcrtid_desc,g_sffb_m.sffbcrtdp_desc,g_sffb_m.sffbmodid_desc, 
       g_sffb_m.sffbcnfid_desc
   
   
   #檢查是否允許此動作
   IF NOT asft335_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_sffb_m_mask_o.* =  g_sffb_m.*
   CALL asft335_sffb_t_mask()
   LET g_sffb_m_mask_n.* =  g_sffb_m.*
   
   CALL asft335_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      IF NOT s_asft335_del_sffc(g_sffb_m.sffbdocno,g_sffb_m.sffbseq) THEN 
         CALL s_transaction_end('N','0') 
         RETURN 
      END IF   
      IF NOT s_asft335_del_sfha(g_sffb_m.sffbdocno,g_sffb_m.sffbseq) THEN
         CALL s_transaction_end('N','0')
         RETURN
      END IF      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL asft335_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_sffbdocno_t = g_sffb_m.sffbdocno
      LET g_sffbseq_t = g_sffb_m.sffbseq
 
 
      DELETE FROM sffb_t
       WHERE sffbent = g_enterprise AND sffbdocno = g_sffb_m.sffbdocno
         AND sffbseq = g_sffb_m.sffbseq
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      #161202-00018 add--------s---------   
      DELETE FROM sffe_t
       WHERE sffeent = g_enterprise AND sffedocno = g_sffb_m.sffbdocno
         AND sffeseq = g_sffb_m.sffbseq
      #161202-00018 add--------e---------
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_sffb_m.sffbdocno,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      IF NOT s_aooi200_del_docno(g_sffb_m.sffbdocno,g_sffb_m.sffbdocdt) THEN CALL s_transaction_end('N','0') RETURN END IF 
              
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
                  
      #end add-point
      
      DELETE FROM sffd_t
       WHERE sffdent = g_enterprise AND sffddocno = g_sffb_m.sffbdocno
         AND sffdseq = g_sffb_m.sffbseq
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
                  
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "sffd_t:",SQLERRMESSAGE 
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
      DELETE FROM sffc_t
       WHERE sffcent = g_enterprise AND
             sffcdocno = g_sffb_m.sffbdocno AND sffcseq = g_sffb_m.sffbseq
      #add-point:單身刪除中 name="delete.body.m_delete2"
                  
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "sffc_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete2"
                  
      #end add-point
 
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_sffb_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE asft335_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_sffd_d.clear() 
      CALL g_sffd2_d.clear()       
 
     
      CALL asft335_ui_browser_refresh()  
      #CALL asft335_ui_headershow()  
      #CALL asft335_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL asft335_browser_fill("")
         CALL asft335_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE asft335_cl
 
   #功能已完成,通報訊息中心
   CALL asft335_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="asft335.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION asft335_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
         
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_sffd_d.clear()
   CALL g_sffd2_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
         
   #end add-point
   
   #判斷是否填充
   IF asft335_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT sffdseq1,sffd001,sffd002,sffd003 ,t1.oocql004 FROM sffd_t",   
              
                     " INNER JOIN sffb_t ON sffbent = " ||g_enterprise|| " AND sffbdocno = sffddocno ",
                     " AND sffbseq = sffdseq ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN oocql_t t1 ON t1.oocqlent="||g_enterprise||" AND t1.oocql001='1053' AND t1.oocql002=sffd001 AND t1.oocql003='"||g_dlang||"' ",
 
                     " WHERE sffdent=? AND sffddocno=? AND sffdseq=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
                  
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY sffd_t.sffdseq1,sffd_t.sffd001"
         
         #add-point:單身填充控制 name="b_fill.sql"
                  
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE asft335_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR asft335_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_sffb_m.sffbdocno,g_sffb_m.sffbseq   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_sffb_m.sffbdocno,g_sffb_m.sffbseq INTO g_sffd_d[l_ac].sffdseq1, 
          g_sffd_d[l_ac].sffd001,g_sffd_d[l_ac].sffd002,g_sffd_d[l_ac].sffd003,g_sffd_d[l_ac].sffd001_desc  
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
         INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_sffd_d[l_ac].sffd001
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='1053' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_sffd_d[l_ac].sffd001_desc = '', g_rtn_fields[1] , ''
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
   IF asft335_fill_chk(2) THEN
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
         #add-point:b_fill段long_sql_if name="b_fill.body2.long_sql_if"
         
         #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT sffc001,sffc002,sffc003,sffc004,sffc005,sffc006 ,t2.oocql004 FROM sffc_t", 
                
                     " INNER JOIN  sffb_t ON sffbent = " ||g_enterprise|| " AND sffbdocno = sffcdocno ",
                     " AND sffbseq = sffcseq ",
 
                     "",
                     
                                    " LEFT JOIN oocql_t t2 ON t2.oocqlent="||g_enterprise||" AND t2.oocql001='223' AND t2.oocql002=sffc001 AND t2.oocql003='"||g_dlang||"' ",
 
                     " WHERE sffcent=? AND sffcdocno=? AND sffcseq=?"   
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段fill_sql name="b_fill.body2.fill_sql"
                  
         #end add-point
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY sffc_t.sffc001"
         
         #add-point:單身填充控制 name="b_fill.sql2"
                  
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE asft335_pb2 FROM g_sql
         DECLARE b_fill_cs2 CURSOR FOR asft335_pb2
      END IF
    
      LET l_ac = 1
      
   #  OPEN b_fill_cs2 USING g_enterprise,g_sffb_m.sffbdocno,g_sffb_m.sffbseq   #(ver:78)
                                               
      FOREACH b_fill_cs2 USING g_enterprise,g_sffb_m.sffbdocno,g_sffb_m.sffbseq INTO g_sffd2_d[l_ac].sffc001, 
          g_sffd2_d[l_ac].sffc002,g_sffd2_d[l_ac].sffc003,g_sffd2_d[l_ac].sffc004,g_sffd2_d[l_ac].sffc005, 
          g_sffd2_d[l_ac].sffc006,g_sffd2_d[l_ac].sffc001_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill2.fill"
                                    INITIALIZE g_ref_fields TO NULL
         LET g_ref_fields[1] = g_sffd2_d[l_ac].sffc001
         CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='223' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
         LET g_sffd2_d[l_ac].sffc001_desc = '', g_rtn_fields[1] , ''
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
   
   CALL g_sffd_d.deleteElement(g_sffd_d.getLength())
   CALL g_sffd2_d.deleteElement(g_sffd2_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE asft335_pb
   FREE asft335_pb2
 
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_sffd_d.getLength()
      LET g_sffd_d_mask_o[l_ac].* =  g_sffd_d[l_ac].*
      CALL asft335_sffd_t_mask()
      LET g_sffd_d_mask_n[l_ac].* =  g_sffd_d[l_ac].*
   END FOR
   
   LET g_sffd2_d_mask_o.* =  g_sffd2_d.*
   FOR l_ac = 1 TO g_sffd2_d.getLength()
      LET g_sffd2_d_mask_o[l_ac].* =  g_sffd2_d[l_ac].*
      CALL asft335_sffc_t_mask()
      LET g_sffd2_d_mask_n[l_ac].* =  g_sffd2_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="asft335.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION asft335_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM sffd_t
       WHERE sffdent = g_enterprise AND
         sffddocno = ps_keys_bak[1] AND sffdseq = ps_keys_bak[2] AND sffdseq1 = ps_keys_bak[3] AND sffd001 = ps_keys_bak[4]
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
         CALL g_sffd_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
                  
      #end add-point    
      DELETE FROM sffc_t
       WHERE sffcent = g_enterprise AND
             sffcdocno = ps_keys_bak[1] AND sffcseq = ps_keys_bak[2] AND sffc001 = ps_keys_bak[3]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
                  
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "sffc_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_sffd2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
                  
      #end add-point    
   END IF
 
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
         
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="asft335.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION asft335_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO sffd_t
                  (sffdent,
                   sffddocno,sffdseq,
                   sffdseq1,sffd001
                   ,sffd002,sffd003) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
                   ,g_sffd_d[g_detail_idx].sffd002,g_sffd_d[g_detail_idx].sffd003)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
                  
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "sffd_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_sffd_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
                  
      #end add-point 
   END IF
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
                  
      #end add-point 
      INSERT INTO sffc_t
                  (sffcent,
                   sffcdocno,sffcseq,
                   sffc001
                   ,sffc002,sffc003,sffc004,sffc005,sffc006) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_sffd2_d[g_detail_idx].sffc002,g_sffd2_d[g_detail_idx].sffc003,g_sffd2_d[g_detail_idx].sffc004, 
                       g_sffd2_d[g_detail_idx].sffc005,g_sffd2_d[g_detail_idx].sffc006)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
                  
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "sffc_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'2'" THEN 
         CALL g_sffd2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
                  
      #end add-point
   END IF
 
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
         
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="asft335.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION asft335_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "sffd_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
                  
      #end add-point 
      
      #將遮罩欄位還原
      CALL asft335_sffd_t_mask_restore('restore_mask_o')
               
      UPDATE sffd_t 
         SET (sffddocno,sffdseq,
              sffdseq1,sffd001
              ,sffd002,sffd003) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3],ps_keys[4]
              ,g_sffd_d[g_detail_idx].sffd002,g_sffd_d[g_detail_idx].sffd003) 
         WHERE sffdent = g_enterprise AND sffddocno = ps_keys_bak[1] AND sffdseq = ps_keys_bak[2] AND sffdseq1 = ps_keys_bak[3] AND sffd001 = ps_keys_bak[4]
      #add-point:update_b段修改中 name="update_b.m_update"
                  
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "sffd_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "sffd_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL asft335_sffd_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
                  
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "sffc_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
                  
      #end add-point  
      
      #將遮罩欄位還原
      CALL asft335_sffc_t_mask_restore('restore_mask_o')
               
      UPDATE sffc_t 
         SET (sffcdocno,sffcseq,
              sffc001
              ,sffc002,sffc003,sffc004,sffc005,sffc006) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_sffd2_d[g_detail_idx].sffc002,g_sffd2_d[g_detail_idx].sffc003,g_sffd2_d[g_detail_idx].sffc004, 
                  g_sffd2_d[g_detail_idx].sffc005,g_sffd2_d[g_detail_idx].sffc006) 
         WHERE sffcent = g_enterprise AND sffcdocno = ps_keys_bak[1] AND sffcseq = ps_keys_bak[2] AND sffc001 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update2"
                  
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "sffc_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "sffc_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
          
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL asft335_sffc_t_mask_restore('restore_mask_n')
 
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
 
{<section id="asft335.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION asft335_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="asft335.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION asft335_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="asft335.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION asft335_lock_b(ps_table,ps_page)
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
   #CALL asft335_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "sffd_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN asft335_bcl USING g_enterprise,
                                       g_sffb_m.sffbdocno,g_sffb_m.sffbseq,g_sffd_d[g_detail_idx].sffdseq1, 
                                           g_sffd_d[g_detail_idx].sffd001     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "asft335_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "sffc_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN asft335_bcl2 USING g_enterprise,
                                             g_sffb_m.sffbdocno,g_sffb_m.sffbseq,g_sffd2_d[g_detail_idx].sffc001 
 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "asft335_bcl2:",SQLERRMESSAGE 
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
 
{<section id="asft335.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION asft335_unlock_b(ps_table,ps_page)
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
      CLOSE asft335_bcl
   END IF
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE asft335_bcl2
   END IF
 
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
         
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="asft335.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION asft335_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
         
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("sffbdocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("sffbdocno,sffbseq",TRUE)
      CALL cl_set_comp_entry("sffbdocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
                  
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("sffb007,sffb008",TRUE)
   CALL cl_set_comp_entry("sffb018,sffb019,sffb020",TRUE)
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="asft335.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION asft335_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   DEFINE l_cnt      LIKE type_t.num5
   DEFINE l_sfaa061  LIKE sfaa_t.sfaa061
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("sffbdocno,sffbseq",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
                  
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("sffbdocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("sffbdocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
#根据工单制程否决定作业编号和制程序栏位的动态开启关闭，这里是有条件的关闭
   SELECT sfaa061 INTO l_sfaa061 FROM sfaa_t
    WHERE sfaaent   = g_enterprise
      AND sfaasite  = g_site
      AND sfaadocno = g_sffb_m.sffb005
      
   
   IF l_sfaa061 = 'N' THEN
      CALL cl_set_comp_entry("sffb007,sffb008",FALSE)
      LET g_sffb_m.sffb007 = ' '  
      LET g_sffb_m.sffb007_desc = NULL
      LET g_sffb_m.sffb008 = ' ' 
      DISPLAY BY NAME g_sffb_m.sffb007_desc                     
   END IF   
      
   IF g_sffb_m.sffb001 MATCHES '[1245]' THEN
      LET g_sffb_m.sffb018 = 0
      LET g_sffb_m.sffb019 = 0
      LET g_sffb_m.sffb020 = 0
      CALL cl_set_comp_entry("sffb018,sffb019,sffb020",FALSE)
   END IF
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM sfcb_t WHERE sfcbent = g_enterprise AND sfcbdocno = g_sffb_m.sffb005 AND sfcb001 = g_sffb_m.sffb006 AND sfcb055 ='Y'
   IF l_cnt = 0 THEN     #制程里没有设回收站，报工不可填回收数量
      LET g_sffb_m.sffb020 = 0
      CALL cl_set_comp_entry("sffb020",FALSE)
   END IF
#当站报废使用申请流程时，不可在报工单上输入报废数量
   IF cl_get_para(g_enterprise,g_site,'S-MFG-0033') = 'Y' THEN 
      LET g_sffb_m.sffb018 = 0   
      CALL cl_set_comp_entry("sffb018,",FALSE)
   END IF
   CALL cl_set_comp_entry("sffbseq",FALSE)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="asft335.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION asft335_set_entry_b(p_cmd)
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
 
{<section id="asft335.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION asft335_set_no_entry_b(p_cmd)
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
 
{<section id="asft335.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION asft335_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   CALL cl_set_act_visible("gen_sfea",TRUE)   #160826-00025#1-add
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="asft335.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION asft335_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   DEFINE l_sfaa061    LIKE sfaa_t.sfaa061  #製程否  #161212-00048#1

   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #應用 a63 樣板自動產生(Version:1)
   IF g_sffb_m.sffbstus NOT MATCHES "[NDR]" THEN   # N未確認/D抽單/R已拒絕允許修改
      CALL cl_set_act_visible("modify,delete,modify_detail", FALSE)
   END IF
   #161212-00048#1-s add
   LET l_sfaa061 = ''
   SELECT sfaa061 INTO l_sfaa061
     FROM sfaa_t
    WHERE sfaaent = g_enterprise
      AND sfaasite = g_site
      AND sfaadocno = g_sffb_m.sffb005
   IF g_sffb_m.sffbstus <> 'Y' OR l_sfaa061 <> 'Y' THEN
   #161212-00048#1-e add
   #160826-00025#1-s-add
   #IF g_sffb_m.sffbstus <> 'Y' THEN #161212-00048#1 mark
      CALL cl_set_act_visible("gen_sfea",FALSE)
   END IF
   #160826-00025#1-e-add
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="asft335.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION asft335_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="asft335.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION asft335_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="asft335.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION asft335_default_search()
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
      LET ls_wc = ls_wc, " sffbdocno = '", g_argv[01], "' AND "
   END IF
   
   IF NOT cl_null(g_argv[02]) THEN
      LET ls_wc = ls_wc, " sffbseq = '", g_argv[02], "' AND "
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
               WHEN la_wc[li_idx].tableid = "sffb_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "sffd_t" 
                  LET g_wc2_table1 = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "sffc_t" 
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
 
{<section id="asft335.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION asft335_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
#161212-00048#1-s mark
#   #160826-00025#1-s-add
#   DEFINE la_param   RECORD
#         prog       STRING,
#         actionid   STRING,
#         background LIKE type_t.chr1,
#         param      DYNAMIC ARRAY OF STRING
#         END RECORD
#   DEFINE ls_js      STRING
#   DEFINE la_output  DYNAMIC ARRAY OF STRING           #報表元件鬆耦合使用
#   DEFINE l_cmd_token           base.StringTokenizer   #報表作業cmdrun使用 
#   DEFINE l_cmd_next            STRING                 #報表作業cmdrun使用
#   DEFINE l_cmd_cnt             LIKE type_t.num5       #報表作業cmdrun使用
#   DEFINE l_cmd_prog_arg        STRING                 #報表作業cmdrun使用
#   DEFINE l_cmd_arg             STRING                 #報表作業cmdrun使用
#   DEFINE l_oobn003    LIKE  oobn_t.oobn003  
   DEFINE l_success    LIKE  type_t.num5     
#   DEFINE l_sfeadocno  LIKE  sfea_t.sfeadocno 
#   DEFINE l_err_code   LIKE  type_t.chr20
#   #160826-00025#1-e-add
#161212-00048#1-e mark
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
#对于在asrt330里产生的资料，这边只能看不能动
   IF g_sffb_m.sffbseq > 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00325'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
#161212-00048#1-s mark
#   IF NOT s_asft335_cre_tmp_table() THEN
#      RETURN
#   END IF
#161212-00048#1-e mark
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_sffb_m.sffbdocno IS NULL
      OR g_sffb_m.sffbseq IS NULL
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN asft335_cl USING g_enterprise,g_sffb_m.sffbdocno,g_sffb_m.sffbseq
   IF STATUS THEN
      CLOSE asft335_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN asft335_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE asft335_master_referesh USING g_sffb_m.sffbdocno,g_sffb_m.sffbseq INTO g_sffb_m.sffbdocno, 
       g_sffb_m.sffbseq,g_sffb_m.sffb001,g_sffb_m.sffb002,g_sffb_m.sffbdocdt,g_sffb_m.sffb003,g_sffb_m.sffbsite, 
       g_sffb_m.sffbstus,g_sffb_m.sffb005,g_sffb_m.sffb006,g_sffb_m.sffb007,g_sffb_m.sffb008,g_sffb_m.sffb029, 
       g_sffb_m.sffb009,g_sffb_m.sffb030,g_sffb_m.sffb004,g_sffb_m.sffb010,g_sffb_m.sffb024,g_sffb_m.sffb011, 
       g_sffb_m.sffb012,g_sffb_m.sffb013,g_sffb_m.sffb014,g_sffb_m.sffb015,g_sffb_m.sffb016,g_sffb_m.sffb017, 
       g_sffb_m.sffb018,g_sffb_m.sffb019,g_sffb_m.sffb020,g_sffb_m.sffbownid,g_sffb_m.sffbowndp,g_sffb_m.sffbcrtid, 
       g_sffb_m.sffbcrtdp,g_sffb_m.sffbcrtdt,g_sffb_m.sffbmodid,g_sffb_m.sffbmoddt,g_sffb_m.sffbcnfid, 
       g_sffb_m.sffbcnfdt,g_sffb_m.sffb002_desc,g_sffb_m.sffb003_desc,g_sffb_m.sffb007_desc,g_sffb_m.sffb009_desc, 
       g_sffb_m.sffb030_desc,g_sffb_m.sffb004_desc,g_sffb_m.sffb010_desc,g_sffb_m.sffb024_desc,g_sffb_m.sffbownid_desc, 
       g_sffb_m.sffbowndp_desc,g_sffb_m.sffbcrtid_desc,g_sffb_m.sffbcrtdp_desc,g_sffb_m.sffbmodid_desc, 
       g_sffb_m.sffbcnfid_desc
   
 
   #檢查是否允許此動作
   IF NOT asft335_action_chk() THEN
      CLOSE asft335_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_sffb_m.sffbdocno,g_sffb_m.sffbseq,g_sffb_m.sffb001,g_sffb_m.sffb002,g_sffb_m.sffb002_desc, 
       g_sffb_m.sffbdocno_desc,g_sffb_m.sffbdocdt,g_sffb_m.sffb003,g_sffb_m.sffb003_desc,g_sffb_m.sffbsite, 
       g_sffb_m.sffbstus,g_sffb_m.sffb005,g_sffb_m.sffb006,g_sffb_m.sffb007,g_sffb_m.sffb007_desc,g_sffb_m.sffb008, 
       g_sffb_m.sffb029,g_sffb_m.sffb029_desc,g_sffb_m.sffb029_desc_1,g_sffb_m.sffb009,g_sffb_m.sffb009_desc, 
       g_sffb_m.sffb030,g_sffb_m.sffb030_desc,g_sffb_m.sffb004,g_sffb_m.sffb004_desc,g_sffb_m.sffb010, 
       g_sffb_m.sffb010_desc,g_sffb_m.sffb024,g_sffb_m.sffb024_desc,g_sffb_m.sffb011,g_sffb_m.sffb012, 
       g_sffb_m.sffb013,g_sffb_m.sffb014,g_sffb_m.sffb015,g_sffb_m.qty,g_sffb_m.sffb016,g_sffb_m.sffb017, 
       g_sffb_m.sffb018,g_sffb_m.sffb019,g_sffb_m.sffb020,g_sffb_m.sffbownid,g_sffb_m.sffbownid_desc, 
       g_sffb_m.sffbowndp,g_sffb_m.sffbowndp_desc,g_sffb_m.sffbcrtid,g_sffb_m.sffbcrtid_desc,g_sffb_m.sffbcrtdp, 
       g_sffb_m.sffbcrtdp_desc,g_sffb_m.sffbcrtdt,g_sffb_m.sffbmodid,g_sffb_m.sffbmodid_desc,g_sffb_m.sffbmoddt, 
       g_sffb_m.sffbcnfid,g_sffb_m.sffbcnfid_desc,g_sffb_m.sffbcnfdt
 
   CASE g_sffb_m.sffbstus
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
         CASE g_sffb_m.sffbstus
            
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
#将一些不能切换的状态给隐藏掉，比如post时只能切confimed，不可切unconfirmed和invalid 
         IF g_sffb_m.sffbstus = 'X' THEN
            CLOSE asft335_cl
            CALL s_transaction_end('N','0')
            RETURN
         END IF
         
         HIDE OPTION "signing"
         HIDE OPTION "withdraw"
         HIDE OPTION "closed"
         HIDE OPTION "hold"
         
         CASE g_sffb_m.sffbstus
            WHEN "N"
               HIDE OPTION "unconfirmed"
               HIDE OPTION "posted"
               HIDE OPTION "unposted"
            #需提交至BPM時，則顯示「提交」功能並隱藏「確認」功能
               IF cl_bpm_chk() THEN
                  SHOW OPTION "signing"
                  HIDE OPTION "confirmed"
               END IF
            WHEN "X"
               HIDE OPTION "invalid"
               HIDE OPTION "confirmed"
               HIDE OPTION "posted"
               HIDE OPTION "unposted"               
               HIDE OPTION "hold"
            WHEN "Y"
               HIDE OPTION "confirmed"
               HIDE OPTION "invalid"
               HIDE OPTION "hold"
               HIDE OPTION "unposted"
            WHEN "S"
               HIDE OPTION "posted"
               HIDE OPTION "unconfirmed"
               HIDE OPTION "invalid" 
               HIDE OPTION "confirmed"
            WHEN "R"
            #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
               HIDE OPTION "confirmed"
               HIDE OPTION "unconfirmed"
               HIDE OPTION "hold" 
            WHEN "D"
            #保留修改的功能(如作廢)，隱藏其他應用功能(如: 確認、未確認、留置、過帳…)
               HIDE OPTION "confirmed"
               HIDE OPTION "unconfirmed"
               HIDE OPTION "hold" 
            WHEN "W"    #只能顯示抽單;其餘應用功能皆隱藏
                SHOW OPTION "withdraw"  
                HIDE OPTION "unconfirmed"
                HIDE OPTION "invalid"
                HIDE OPTION "confirmed"
                HIDE OPTION "hold"
            
            WHEN "A"     #只能顯示確認; 其餘應用功能皆隱藏
                SHOW OPTION "confirmed" 
                HIDE OPTION "unconfirmed"
                HIDE OPTION "invalid"
                HIDE OPTION "hold"        
         END CASE                   
      #end add-point
      
      #應用 a36 樣板自動產生(Version:5)
      #提交
      ON ACTION signing
         IF cl_auth_chk_act("signing") THEN
            IF NOT asft335_send() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE asft335_cl
            RETURN
         END IF
    
      #抽單
      ON ACTION withdraw
         IF cl_auth_chk_act("withdraw") THEN
            IF NOT asft335_draw_out() THEN
               CALL s_transaction_end('N','0')
            ELSE
               CALL s_transaction_end('Y','0')
            END IF
            #因應簽核行為, 該動作完成後不再進行後續處理
            #於此處直接返回
            CLOSE asft335_cl
            RETURN
         END IF
 
 
 
	  
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
            IF NOT cl_ask_confirm('aim-00110') THEN
               CLOSE asft335_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            IF g_sffb_m.sffbstus = 'Y' THEN   #判断从审核到未审核的，这才是取消审核，从无效到有效（未审核）的，不该走取消审核逻辑
               #161215-00055#1-s mark
               #IF s_asft335_unconf(g_sffb_m.sffbdocno) THEN
               #   CALL s_transaction_end('Y',0)
               #   LET g_sffb_m.sffbstus = lc_state
               #   DISPLAY BY NAME g_sffb_m.sffbstus
               #ELSE
               #   LET lc_state = "Y"
               #   CALL s_transaction_end('N',0)
               #END IF 
               #CLOSE asft335_cl
               ##CALL s_asft335_drop_tmp_table()  #161212-00048#1 mark
               #CALL asft335_refresh_stus()
               #RETURN            
               #161215-00055#1-e mark
               #161215-00055#1-s add
               CALL cl_err_collect_init()  #汇总错误讯息初始化
               LET g_coll_title[1] = cl_getmsg('lib-00153',g_lang)  #項次
               IF NOT s_asft335_unconf(g_sffb_m.sffbdocno) THEN
                  CLOSE asft335_cl
                  CALL s_transaction_end('N','0')
                  CALL cl_err_collect_show()
                  RETURN
               END IF
               CALL cl_err_collect_show()
               #161215-00055#1-e add
            END IF
            #end add-point
         END IF
         EXIT MENU
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.confirmed"
            IF NOT cl_ask_confirm('aim-00108') THEN
               CLOSE asft335_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF
            #161215-00055#1-s add
            CALL cl_err_collect_init()  #汇总错误讯息初始化
            LET g_coll_title[1] = cl_getmsg('lib-00153',g_lang)  #項次
            IF NOT s_asft335_conf(g_sffb_m.sffbdocno) THEN
               CLOSE asft335_cl
               CALL s_transaction_end('N','0')
               CALL cl_err_collect_show()
               RETURN
            END IF
            CALL cl_err_collect_show()
            CALL s_transaction_end('Y',0)
            CALL s_aooi200_get_slip(g_sffb_m.sffbdocno) RETURNING l_success,g_doc_slip
            #170213-00031#1-s-mod
#            IF cl_get_doc_para(g_enterprise,g_site,g_doc_slip,'D-MFG-0068') ='Y' THEN
            IF cl_get_doc_para(g_enterprise,g_site,g_doc_slip,'D-MFG-0086') ='Y' THEN
            #170213-00031#1-e-mod
               CALL asft335_gen_sfea('N')
            END IF
            #161215-00055#1-e add
#161215-00055#1-s mark
#            IF s_asft335_conf(g_sffb_m.sffbdocno) THEN
#               LET lc_state = "Y"
#               CALL s_transaction_end('Y',0)
#               LET g_sffb_m.sffbstus = lc_state
#               DISPLAY BY NAME g_sffb_m.sffbstus
#               #161208-00044#1-s
#               CALL s_aooi200_get_slip(g_sffb_m.sffbdocno) RETURNING l_success,g_doc_slip
#               IF cl_get_doc_para(g_enterprise,g_site,g_doc_slip,'D-MFG-0068') ='Y' THEN
#               #161208-00044#1-e
#                  CALL asft335_gen_sfea('N')  #161212-00048#1
##161212-00048#1-s mark
##               #160826-00025#1-s-add
##               #自動產生完工入庫
##               CALL asft335_asft301_chk() RETURNING l_success,l_err_code
##               IF l_success THEN
##                  CALL s_aooi210_get_doc(g_site,'','6',g_sffb_m.sffb005,'asft340','') RETURNING l_success,l_oobn003
##                  IF l_success THEN
##                     CALL s_transaction_begin()
##                     CALL cl_err_collect_init()
##                     CALL s_asft335_gen_sfea(l_oobn003,g_sffb_m.sffb005,g_sffb_m.sffb006) RETURNING l_success,l_sfeadocno
##                     IF l_success THEN
##                        CALL s_transaction_end('Y','0')
##                        #產生成功，是否開啟完工入庫單：%1？
##                        IF cl_ask_confirm_parm('asf-00810',l_sfeadocno) THEN
##                           LET la_param.prog = 'asft340'
##                           LET la_param.param[1] = l_sfeadocno
##                           LET ls_js = util.JSON.stringify(la_param )
##                           CALL cl_cmdrun(ls_js)
##                        END IF
##                     ELSE
##                        CALL s_transaction_end('N','0')
##                     END IF
##                     CALL cl_err_collect_show()
##                  END IF
##               END IF
##               #160826-00025#1-e-add
##161212-00048#1-e mark
#               END IF  #161208-00044#1
#            ELSE
#               LET lc_state = "N"
#               CALL s_transaction_end('N',0)
#            END IF 
#            CLOSE asft335_cl
#            #CALL s_asft335_drop_tmp_table()  #161212-00048#1 mark
#            CALL asft335_refresh_stus()
#            RETURN         
#161215-00055#1-e mark
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
            IF NOT cl_ask_confirm('aim-00109') THEN
               CLOSE asft335_cl
               CALL s_transaction_end('N','0')
               RETURN
            END IF   
            #161214-00011#1 add----s------
            IF NOT s_asft335_del_sfha(g_sffb_m.sffbdocno,g_sffb_m.sffbseq) THEN
               CLOSE asft335_cl  #161215-00055#1
               CALL s_transaction_end('N','0')
               RETURN
            END IF 
            #161214-00011#1 add-----e------
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
      g_sffb_m.sffbstus = lc_state OR cl_null(lc_state) THEN
      CLOSE asft335_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
         
   #end add-point
   
   LET g_sffb_m.sffbmodid = g_user
   LET g_sffb_m.sffbmoddt = cl_get_current()
   LET g_sffb_m.sffbstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE sffb_t 
      SET (sffbstus,sffbmodid,sffbmoddt) 
        = (g_sffb_m.sffbstus,g_sffb_m.sffbmodid,g_sffb_m.sffbmoddt)     
    WHERE sffbent = g_enterprise AND sffbdocno = g_sffb_m.sffbdocno
      AND sffbseq = g_sffb_m.sffbseq
    
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
      EXECUTE asft335_master_referesh USING g_sffb_m.sffbdocno,g_sffb_m.sffbseq INTO g_sffb_m.sffbdocno, 
          g_sffb_m.sffbseq,g_sffb_m.sffb001,g_sffb_m.sffb002,g_sffb_m.sffbdocdt,g_sffb_m.sffb003,g_sffb_m.sffbsite, 
          g_sffb_m.sffbstus,g_sffb_m.sffb005,g_sffb_m.sffb006,g_sffb_m.sffb007,g_sffb_m.sffb008,g_sffb_m.sffb029, 
          g_sffb_m.sffb009,g_sffb_m.sffb030,g_sffb_m.sffb004,g_sffb_m.sffb010,g_sffb_m.sffb024,g_sffb_m.sffb011, 
          g_sffb_m.sffb012,g_sffb_m.sffb013,g_sffb_m.sffb014,g_sffb_m.sffb015,g_sffb_m.sffb016,g_sffb_m.sffb017, 
          g_sffb_m.sffb018,g_sffb_m.sffb019,g_sffb_m.sffb020,g_sffb_m.sffbownid,g_sffb_m.sffbowndp,g_sffb_m.sffbcrtid, 
          g_sffb_m.sffbcrtdp,g_sffb_m.sffbcrtdt,g_sffb_m.sffbmodid,g_sffb_m.sffbmoddt,g_sffb_m.sffbcnfid, 
          g_sffb_m.sffbcnfdt,g_sffb_m.sffb002_desc,g_sffb_m.sffb003_desc,g_sffb_m.sffb007_desc,g_sffb_m.sffb009_desc, 
          g_sffb_m.sffb030_desc,g_sffb_m.sffb004_desc,g_sffb_m.sffb010_desc,g_sffb_m.sffb024_desc,g_sffb_m.sffbownid_desc, 
          g_sffb_m.sffbowndp_desc,g_sffb_m.sffbcrtid_desc,g_sffb_m.sffbcrtdp_desc,g_sffb_m.sffbmodid_desc, 
          g_sffb_m.sffbcnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_sffb_m.sffbdocno,g_sffb_m.sffbseq,g_sffb_m.sffb001,g_sffb_m.sffb002,g_sffb_m.sffb002_desc, 
          g_sffb_m.sffbdocno_desc,g_sffb_m.sffbdocdt,g_sffb_m.sffb003,g_sffb_m.sffb003_desc,g_sffb_m.sffbsite, 
          g_sffb_m.sffbstus,g_sffb_m.sffb005,g_sffb_m.sffb006,g_sffb_m.sffb007,g_sffb_m.sffb007_desc, 
          g_sffb_m.sffb008,g_sffb_m.sffb029,g_sffb_m.sffb029_desc,g_sffb_m.sffb029_desc_1,g_sffb_m.sffb009, 
          g_sffb_m.sffb009_desc,g_sffb_m.sffb030,g_sffb_m.sffb030_desc,g_sffb_m.sffb004,g_sffb_m.sffb004_desc, 
          g_sffb_m.sffb010,g_sffb_m.sffb010_desc,g_sffb_m.sffb024,g_sffb_m.sffb024_desc,g_sffb_m.sffb011, 
          g_sffb_m.sffb012,g_sffb_m.sffb013,g_sffb_m.sffb014,g_sffb_m.sffb015,g_sffb_m.qty,g_sffb_m.sffb016, 
          g_sffb_m.sffb017,g_sffb_m.sffb018,g_sffb_m.sffb019,g_sffb_m.sffb020,g_sffb_m.sffbownid,g_sffb_m.sffbownid_desc, 
          g_sffb_m.sffbowndp,g_sffb_m.sffbowndp_desc,g_sffb_m.sffbcrtid,g_sffb_m.sffbcrtid_desc,g_sffb_m.sffbcrtdp, 
          g_sffb_m.sffbcrtdp_desc,g_sffb_m.sffbcrtdt,g_sffb_m.sffbmodid,g_sffb_m.sffbmodid_desc,g_sffb_m.sffbmoddt, 
          g_sffb_m.sffbcnfid,g_sffb_m.sffbcnfid_desc,g_sffb_m.sffbcnfdt
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
         
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
         
   #end add-point  
 
   CLOSE asft335_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL asft335_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="asft335.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION asft335_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
         
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_sffd_d.getLength() THEN
         LET g_detail_idx = g_sffd_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_sffd_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_sffd_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx > g_sffd2_d.getLength() THEN
         LET g_detail_idx = g_sffd2_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_sffd2_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_sffd2_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
         
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="asft335.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION asft335_b_fill2(pi_idx)
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
   
   CALL asft335_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="asft335.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION asft335_fill_chk(ps_idx)
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
 
{<section id="asft335.status_show" >}
PRIVATE FUNCTION asft335_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="asft335.mask_functions" >}
&include "erp/asf/asft335_mask.4gl"
 
{</section>}
 
{<section id="asft335.signature" >}
   #應用 a39 樣板自動產生(Version:10)
#+ BPM提交
PRIVATE FUNCTION asft335_send()
   #add-point:send段define(客製用) name="send.define_customerization"
   
   #end add-point 
   #add-point:send段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="send.define"
   
   #end add-point 
   
   #add-point:Function前置處理  name="send.pre_function"
   
   #end add-point
   
   #依據單據個數，需要指定所有單身條件為" 1=1"  (單身有幾個就要設幾個)
   LET g_wc2_table1 = " 1=1"
   LET g_wc2_table2 = " 1=1"
 
 
   CALL asft335_show()
   CALL asft335_set_pk_array()
   
   #add-point: 初始化的ADP name="send.before_send"
   
   #end add-point
   
   #公用變數初始化
   CALL cl_bpm_data_init()
                  
   #依照主檔/單身個數產生 CALL cl_bpm_set_master_data() / cl_bpm_set_detail_data() 
   #單頭固定為 CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(xxxx)) 傳入參數: (1)單頭陣列  ; 回傳值: 無
   CALL cl_bpm_set_master_data(util.JSONObject.fromFGL(g_sffb_m))
                              
   #單身固定為 CALL cl_bpm_set_detail_data(s_detailX, util.JSONArray.fromFGL(xxxx)) 傳入參數: (1)單身SR名稱  (2)單身陣列  ; 回傳值: 無
   CALL cl_bpm_set_detail_data("s_detail1", util.JSONArray.fromFGL(g_sffd_d))
   CALL cl_bpm_set_detail_data("s_detail2", util.JSONArray.fromFGL(g_sffd2_d))
 
 
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
   #CALL asft335_ui_browser_refresh()
 
   #重新指定此筆單據資料狀態圖片=>送簽中
   LET g_browser[g_current_idx].b_statepic = "stus/16/signing.png"
 
   #重新取得單頭/單身資料,DISPLAY在畫面上
   CALL asft335_ui_headershow()
   CALL asft335_ui_detailshow()
 
   RETURN TRUE
   
END FUNCTION
 
 
 
#應用 a40 樣板自動產生(Version:9)
#+ BPM抽單
PRIVATE FUNCTION asft335_draw_out()
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
   CALL asft335_ui_headershow()  
   CALL asft335_ui_detailshow()
 
   #add-point:Function後置處理  name="draw.after_function"
   
   #end add-point
 
   RETURN TRUE
   
END FUNCTION
 
 
 
 
 
{</section>}
 
{<section id="asft335.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION asft335_set_pk_array()
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
   LET g_pk_array[1].values = g_sffb_m.sffbdocno
   LET g_pk_array[1].column = 'sffbdocno'
   LET g_pk_array[2].values = g_sffb_m.sffbseq
   LET g_pk_array[2].column = 'sffbseq'
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="asft335.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="asft335.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION asft335_msgcentre_notify(lc_state)
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
   CALL asft335_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_sffb_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="asft335.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION asft335_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   #160818-00017#36-s
   SELECT sffbstus INTO g_sffb_m.sffbstus FROM sffb_t
    WHERE sffbent = g_enterprise
      AND sffbsite = g_site
      AND sffbdocno = g_sffb_m.sffbdocno
      AND sffbseq = g_sffb_m.sffbseq
   IF (g_action_choice="modify" OR g_action_choice="delete" OR g_action_choice="modify_detail")  THEN
     LET g_errno = NULL
     CASE g_sffb_m.sffbstus
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
        LET g_errparam.extend = g_sffb_m.sffbdocno
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET g_errno = NULL
        CALL asft335_set_act_visible()
        CALL asft335_set_act_no_visible()
        CALL asft335_show()
        RETURN FALSE
     END IF
   END IF      
   #160818-00017#36-e
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="asft335.other_function" readonly="Y" >}
################################################################################
# Descriptions...: 開啟asft337，並帶出由目前畫面產生的單據
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
PRIVATE FUNCTION asft335_call_asft337()
   DEFINE la_param  RECORD
                    prog   STRING,
                    param  DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING


   IF g_sffb_m.sffbstus = 'X' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00197'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      RETURN
   END IF
          
   
   IF g_sffb_m.sffbdocno IS NULL OR g_sffb_m.sffbseq IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "std-00003"
      LET g_errparam.extend = ""
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN
   END IF
   
   LET la_param.prog     = "asft337"
   LET la_param.param[1] = g_sffb_m.sffbdocno
   LET la_param.param[2] = g_sffb_m.sffbseq
   LET ls_js = util.JSON.stringify( la_param )
   CALL cl_cmdrun(ls_js)

END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL asft335_set_required()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION asft335_set_required()
   DEFINE l_sfaa061     LIKE sfaa_t.sfaa061
   DEFINE l_success     LIKE type_t.num5
   
   SELECT sfaa061 INTO l_sfaa061 FROM sfaa_t
    WHERE sfaaent   = g_enterprise
      AND sfaasite  = g_site
      AND sfaadocno = g_sffb_m.sffb005
      
   
   IF l_sfaa061 = 'Y' THEN
      CALL cl_set_comp_required("sffb007,sffb008",TRUE)              
   END IF 
   IF NOT cl_null(g_sffb_m.sffbdocno) THEN
      CALL s_aooi200_get_slip(g_sffb_m.sffbdocno) RETURNING l_success,g_doc_slip
      IF cl_get_doc_para(g_enterprise,g_site,g_doc_slip,'D-MFG-0068') ='Y' THEN 
         CALL cl_set_comp_required("sffb024",TRUE) 
      END IF  
   END IF   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL asft335_set_no_required()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION asft335_set_no_required()
   CALL cl_set_comp_required("sffb007,sffb008,sffb024",FALSE)
END FUNCTION
################################################################################
# Descriptions...: 将sffb013设置成HH:MM的输入格式
# Memo...........:
# Usage..........: CALL asft335_set_sffb013_format()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION asft335_set_sffb013_format()
   DEFINE   ls_field     STRING
   DEFINE   lwin_curr    ui.Window
   DEFINE   lfrm_curr    ui.Form
   DEFINE   lnode_item   om.DomNode
   DEFINE   lnode_child  om.DomNode
   DEFINE   ls_picture   STRING              # 單據編號格式設定
   DEFINE   li_i         LIKE type_t.num10    
   DEFINE   ls_tabname   STRING             
   DEFINE   ls_sql       STRING

 
 
   LET lwin_curr = ui.Window.getCurrent()
   LET lfrm_curr = lwin_curr.getForm()
   IF lfrm_curr IS NULL THEN
      RETURN
   END IF
 
   LET ls_tabname = 'sffb_t'
   LET ls_field   = 'sffb013'
   LET lnode_item = lfrm_curr.findNode("FormField",ls_tabname||"."||ls_field) 
   IF lnode_item IS NULL THEN
      LET lnode_item = lfrm_curr.findNode("TableColumn",ls_tabname||"."||ls_field)  
      IF lnode_item IS NULL THEN
         LET lnode_item = lfrm_curr.findNode("Matrix",ls_tabname||"."||ls_field)
         IF lnode_item IS NULL THEN
            RETURN
         END IF
      END IF
   END IF
 
   LET lnode_child = lnode_item.getFirstChild()

   FOR li_i = 1 TO 2
       LET ls_picture = ls_picture,"#"
   END FOR
 
   LET ls_picture = ls_picture,":"
 
   FOR li_i = 1 TO 2
       LET ls_picture = ls_picture,"#"
   END FOR
 
   CALL lnode_child.setAttribute("picture",ls_picture)
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
PRIVATE FUNCTION asft335_refresh_stus()

       
       SELECT DISTINCT sffbstus,sffbownid,sffbowndp,sffbcrtid,sffbcrtdp,
                       sffbcrtdt,sffbmodid,sffbmoddt,sffbcnfid,sffbcnfdt
         INTO g_sffb_m.sffbstus,g_sffb_m.sffbownid,g_sffb_m.sffbowndp,g_sffb_m.sffbcrtid,g_sffb_m.sffbcrtdp,
              g_sffb_m.sffbcrtdt,g_sffb_m.sffbmodid,g_sffb_m.sffbmoddt,g_sffb_m.sffbcnfid,g_sffb_m.sffbcnfdt
         
         FROM sffb_t
        WHERE sffbent   = g_enterprise
          AND sffbdocno = g_sffb_m.sffbdocno
          AND sffbseq   = g_sffb_m.sffbseq
       
       LET g_sffb_m.sffbownid_desc = s_desc_get_person_desc(g_sffb_m.sffbownid)
       LET g_sffb_m.sffbcrtid_desc = s_desc_get_person_desc(g_sffb_m.sffbcrtid)
       LET g_sffb_m.sffbmodid_desc = s_desc_get_person_desc(g_sffb_m.sffbmodid)
       LET g_sffb_m.sffbcnfid_desc = s_desc_get_person_desc(g_sffb_m.sffbcnfid)
       
       LET g_sffb_m.sffbowndp_desc = s_desc_get_department_desc(g_sffb_m.sffbowndp)
       LET g_sffb_m.sffbcrtdp_desc = s_desc_get_department_desc(g_sffb_m.sffbcrtdp)
 
       CASE g_sffb_m.sffbstus
          WHEN "N"
             CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
          WHEN "X"
             CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
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
          
       END CASE 
       
       DISPLAY BY NAME
       g_sffb_m.sffbstus,g_sffb_m.sffbownid,
       g_sffb_m.sffbownid_desc,g_sffb_m.sffbowndp,g_sffb_m.sffbowndp_desc,g_sffb_m.sffbcrtid,g_sffb_m.sffbcrtid_desc, 
       g_sffb_m.sffbcrtdp,g_sffb_m.sffbcrtdp_desc,g_sffb_m.sffbcrtdt,g_sffb_m.sffbmodid,g_sffb_m.sffbmodid_desc, 
       g_sffb_m.sffbmoddt,g_sffb_m.sffbcnfid,g_sffb_m.sffbcnfid_desc,g_sffb_m.sffbcnfdt
END FUNCTION

################################################################################
# Descriptions...: 確認是否為最後一個製程站的最後一個報工點
# Memo...........:
# Usage..........: CALL asft335_asft301_chk()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success   TRUE/FALSE
#                : r_err_code  錯誤代碼
# Date & Author..: 2016/11/17 By dorislai (#160826-00025#1)
# Modify.........:
################################################################################
PRIVATE FUNCTION asft335_asft301_chk()
   DEFINE   r_success      LIKE  type_t.num5
   DEFINE   r_err_code     STRING
#161212-00048#1-s  mark
#   DEFINE   l_sfaa061      LIKE  sfaa_t.sfaa061  #製程否
#   DEFINE   l_cnt          LIKE  type_t.num5
#   DEFINE   l_final_point  LIKE  type_t.num5     #最後一站的最後一個報工點
#   
#   LET l_sfaa061 = ''
#   LET r_success = TRUE
#   #抓取製程否
#   SELECT sfaa061 INTO l_sfaa061
#     FROM sfaa_t
#    WHERE sfaaent = g_enterprise
#      AND sfaasite = g_site
#      AND sfaadocno = g_sffb_m.sffb005
#   IF l_sfaa061 = 'Y' THEN
#      LET l_cnt = 0
#      #查看是否是最後一個報工站
#      SELECT COUNT(1) INTO l_cnt
#        FROM sfcb_t
#       WHERE sfcbent = g_enterprise
#         AND sfcbsite = g_site
#         AND sfcbdocno = g_sffb_m.sffb005
#         AND sfcb001 = g_sffb_m.sffb006
#         AND sfcb003 = g_sffb_m.sffb007
#         AND sfcb004 = g_sffb_m.sffb008
#         AND sfcb009 = 'END'
#      IF l_cnt = 0 THEN
#         LET r_success = FALSE
#         LET r_err_code = 'asf-00813'  #非為最後一站，不可產生完工入庫單！
#      ELSE
#         IF g_sffb_m.sffb001 MATCHES '[345]' THEN
#            #取得最後一站，最後一個報工點(1.Move in 2.Check in 3.報工 4.Check out 5.Move out 6.PQC)
#            CALL s_asft335_get_final_point(g_sffb_m.sffb005,g_sffb_m.sffb006) RETURNING l_final_point
#            #比對是否為最後一個報工點
#            IF g_sffb_m.sffb001 <> l_final_point THEN
#               LET r_success = FALSE
#               LET r_err_code = 'asf-00812'  #此張報工單，非為最後一個報工點，不可產生完工入庫單！
#            END IF
#         END IF
#      END IF
#   ELSE
#      LET r_success = FALSE
#   END IF
#161212-00048#1-e  mark
   RETURN r_success,r_err_code
END FUNCTION

################################################################################
# Descriptions...: 自動產生完工入庫
# Memo...........:
# Usage..........: CALL asft335_gen_sfea(p_flag)
# Input parameter: p_flag      是否提示訊息
# Return code....: 
# Date & Author..: #161212-00048#1 By Whitney
# Modify.........:
################################################################################
PRIVATE FUNCTION asft335_gen_sfea(p_flag)
DEFINE p_flag       LIKE type_t.chr1
DEFINE l_n          LIKE type_t.num5
DEFINE l_success    LIKE type_t.num5
DEFINE l_oobn003    LIKE oobn_t.oobn003
DEFINE l_sfeadocno  LIKE sfea_t.sfeadocno
DEFINE l_sfca005    LIKE sfca_t.sfca005   #170213-00027#1
DEFINE ls_js        STRING
DEFINE la_param  RECORD
    prog         STRING,
    param        DYNAMIC ARRAY OF STRING
             END RECORD

   #170213-00031#1-s-add
   LET l_sfca005 = ''
   SELECT sfca005 INTO l_sfca005
     FROM sfca_t
    WHERE sfcaent = g_enterprise
      AND sfcadocno = g_sffb_m.sffb005
      AND sfca001 = g_sffb_m.sffb006
   IF l_sfca005 = '2' THEN
      IF p_flag = 'Y' THEN
         #此張報工單，為重工報工單，不可產生完工入庫單！
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code   = 'asf-00832'
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
      END IF
      RETURN
   END IF
   #170213-00031#1-e-add
   DELETE FROM s_asft335_tmp01
   CALL s_asft335_get_next_station(g_sffb_m.sffb001,g_sffb_m.sffb005,g_sffb_m.sffb006,g_sffb_m.sffb007,g_sffb_m.sffb008) RETURNING l_success
   LET l_n = 0
   SELECT COUNT(1) INTO l_n FROM s_asft335_tmp01
   IF l_n > 0 THEN
      IF p_flag = 'Y' THEN
         #此張報工單，非為最後一個報工點，不可產生完工入庫單！
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code   = 'asf-00812'
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
      END IF
      RETURN
   END IF
   
   CALL s_aooi210_get_doc(g_site,'','6',g_sffb_m.sffb005,'asft340','') RETURNING l_success,l_oobn003
   IF NOT l_success THEN
      RETURN
   END IF
   
   CALL cl_err_collect_init()
   CALL s_transaction_begin()
   CALL s_asft335_gen_sfea(l_oobn003,g_sffb_m.sffb005,g_sffb_m.sffb006) RETURNING l_success,l_sfeadocno
   IF l_success THEN
      CALL s_transaction_end('Y','0')
      #產生成功，是否開啟完工入庫單：%1？
      IF cl_ask_confirm_parm('asf-00810',l_sfeadocno) THEN
         LET la_param.prog = 'asft340'
         LET la_param.param[1] = l_sfeadocno
         LET ls_js = util.JSON.stringify(la_param )
         CALL cl_cmdrun(ls_js)
      END IF
   ELSE
      CALL s_transaction_end('N','0')
   END IF
   CALL cl_err_collect_show()

END FUNCTION

 
{</section>}
 
