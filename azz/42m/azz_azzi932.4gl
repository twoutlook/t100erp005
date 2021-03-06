#該程式未解開Section, 採用最新樣板產出!
{<section id="azzi932.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0014(2017-02-06 13:55:21), PR版次:0014(2017-02-06 13:40:02)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000142
#+ Filename...: azzi932
#+ Description: 問題管制表
#+ Creator....: 01101(2014-07-14 18:08:55)
#+ Modifier...: 01101 -SD/PR- 01101
 
{</section>}
 
{<section id="azzi932.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#+ Modifier...: 2014/09/22 By tsai_yen 此程式欄位增減時,都要檢查 "#手動維護" 的部分
#+ Modifier...: No.160111-00009#5 2016/02/24 By tsai_yen 有案件代號就不可刪除,建議改有效碼,避免產生相同單號無法反映產中
#+ Modifier...: No.160509-00001#1 2016/05/09 By tsai_yen 內部串接型管簡易需求單,固定網址
#+ Modifier...: No.160524-00016#1 2016/05/27 By tsai_yen azzi932反映人員：人員通訊聯絡下拉選單串aooi130員工資料維護作業
#+ Modifier...: No.160606-00027#1 2016/06/06 By tsai_yen 1.減少Mail寄件時機，時機點為：(1)新增問題反映單、(2)修改處理狀態、(3)修改更新摘要。
#                                                        2.非第一次寄的mail，主旨加上"RE: "。
#                                                        3.在 TOPMENU 提供用戶服務平台網址
#                                                        4.型管結案重啟
#                                                        5.g_argv[02]提供Q類程式以勾選的問題編號串查
#+ Creator....: No.160726-00017#2 2016/07/29 By frank0521 共用函式改呼叫library
#+ Modifier...: No.160805-00001#1 2016/08/23 By frank0521 更新案件
#+ Modifier...: No.161018-00059#1 2016/10/18 By tsai_yen 產中結案重啟和批次反映流程拆開,並重新顯示案件代號
#+ Modifier...: No.161027-00047#1 2016/10/02 By tsai_yen 1.案件代號成立後仍可以新增附件。
#                                                        2.Mail寄件時機：修改問題描述。負責單位是MIS時,開放修改問題描述並寄送Mail,以利於正確反映鼎新。
#                                                        3.開放修改更新摘要,供MIS管理或回覆使用者。
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
PRIVATE type type_g_gzwi_m        RECORD
       gzwi001 LIKE gzwi_t.gzwi001, 
   gzwi002 LIKE gzwi_t.gzwi002, 
   gzwi003 LIKE gzwi_t.gzwi003, 
   gzwi008 LIKE gzwi_t.gzwi008, 
   gzwi008_desc LIKE type_t.chr80, 
   gzwi010 LIKE gzwi_t.gzwi010, 
   gzwi017 LIKE gzwi_t.gzwi017, 
   gzwi017_desc LIKE type_t.chr80, 
   gzwi004 LIKE gzwi_t.gzwi004, 
   gzwi005 LIKE gzwi_t.gzwi005, 
   gzwi005_desc LIKE type_t.chr80, 
   gzwi013 LIKE gzwi_t.gzwi013, 
   gzwi006 LIKE gzwi_t.gzwi006, 
   gzwi006_desc LIKE type_t.chr80, 
   gzwi015 LIKE gzwi_t.gzwi015, 
   gzwi016 LIKE gzwi_t.gzwi016, 
   gzwi018 LIKE gzwi_t.gzwi018, 
   gzwi007_desc LIKE type_t.chr80, 
   gzwi007 LIKE gzwi_t.gzwi007, 
   gzwi011 LIKE gzwi_t.gzwi011, 
   gzwi012 LIKE gzwi_t.gzwi012, 
   gzwi027 LIKE gzwi_t.gzwi027, 
   gzwi014 LIKE gzwi_t.gzwi014, 
   gzwi009 LIKE gzwi_t.gzwi009, 
   gzwi026 LIKE gzwi_t.gzwi026, 
   gzwi019 LIKE gzwi_t.gzwi019, 
   gzwi020 LIKE gzwi_t.gzwi020, 
   gzwi021 LIKE gzwi_t.gzwi021, 
   gzwi022 LIKE gzwi_t.gzwi022, 
   gzwi023 LIKE gzwi_t.gzwi023, 
   gzwi024 LIKE gzwi_t.gzwi024, 
   gzwi025 LIKE gzwi_t.gzwi025, 
   gzwi028 LIKE gzwi_t.gzwi028, 
   gzwi028_desc LIKE type_t.chr80, 
   gzwistus LIKE gzwi_t.gzwistus, 
   gzwiownid LIKE gzwi_t.gzwiownid, 
   gzwiownid_desc LIKE type_t.chr80, 
   gzwiowndp LIKE gzwi_t.gzwiowndp, 
   gzwiowndp_desc LIKE type_t.chr80, 
   gzwicrtid LIKE gzwi_t.gzwicrtid, 
   gzwicrtid_desc LIKE type_t.chr80, 
   gzwicrtdp LIKE gzwi_t.gzwicrtdp, 
   gzwicrtdp_desc LIKE type_t.chr80, 
   gzwicrtdt LIKE gzwi_t.gzwicrtdt, 
   gzwimodid LIKE gzwi_t.gzwimodid, 
   gzwimodid_desc LIKE type_t.chr80, 
   gzwimoddt LIKE gzwi_t.gzwimoddt
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_gzwj_d        RECORD
       gzwj008 LIKE gzwj_t.gzwj008, 
   gzwj002 LIKE gzwj_t.gzwj002, 
   gzwj004 LIKE gzwj_t.gzwj004, 
   gzwj005 LIKE gzwj_t.gzwj005, 
   fileimg LIKE type_t.chr500, 
   gzwj007 LIKE gzwj_t.gzwj007, 
   gzwjcrtid LIKE gzwj_t.gzwjcrtid, 
   gzwjcrtid_desc LIKE type_t.chr500, 
   gzwjmodid LIKE gzwj_t.gzwjmodid, 
   gzwjmodid_desc LIKE type_t.chr500, 
   gzwjcrtdp LIKE gzwj_t.gzwjcrtdp, 
   gzwjcrtdp_desc LIKE type_t.chr500, 
   gzwjmoddt DATETIME YEAR TO SECOND, 
   gzwjcrtdt DATETIME YEAR TO SECOND
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_gzwi028 LIKE gzwi_t.gzwi028,
   b_gzwi028_desc LIKE type_t.chr80,
      b_gzwi011 LIKE gzwi_t.gzwi011,
      b_gzwi001 LIKE gzwi_t.gzwi001,
      b_gzwi017 LIKE gzwi_t.gzwi017,
      b_gzwi002 LIKE gzwi_t.gzwi002,
      b_gzwi003 LIKE gzwi_t.gzwi003,
      b_gzwi008 LIKE gzwi_t.gzwi008,
   b_gzwi008_desc LIKE type_t.chr80,
      b_gzwi010 LIKE gzwi_t.gzwi010,
      b_gzwi004 LIKE gzwi_t.gzwi004,
      b_gzwi012 LIKE gzwi_t.gzwi012,
      b_gzwi005 LIKE gzwi_t.gzwi005,
   b_gzwi005_desc LIKE type_t.chr80,
      b_gzwi013 LIKE gzwi_t.gzwi013,
      b_gzwi006 LIKE gzwi_t.gzwi006,
   b_gzwi006_desc LIKE type_t.chr80,
      b_gzwi015 LIKE gzwi_t.gzwi015,
      b_gzwi018 LIKE gzwi_t.gzwi018,
   b_gzwi007_desc LIKE type_t.chr80,
      b_gzwi009 LIKE gzwi_t.gzwi009,
      b_gzwi025 LIKE gzwi_t.gzwi025
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
TYPE type_g_gzwi_inc        RECORD   #問題反映記錄檔for mail與azzi931主檔,共用:cl_helps932,azzi931,azzi932,azzp931,azzq932
     gzwi001 LIKE gzwi_t.gzwi001,             #問題編號  
     gzwi002 LIKE gzwi_t.gzwi002,             #類別
     gzwi003 LIKE gzwi_t.gzwi003,             #模組
     gzwi004 LIKE gzwi_t.gzwi004,             #問題描述
     gzwi005 LIKE gzwi_t.gzwi005,             #反映人員
     gzwi006 LIKE gzwi_t.gzwi006,             #反映人員營運據點
     gzwi007 LIKE gzwi_t.gzwi007,             #處理人員
     gzwi008 LIKE gzwi_t.gzwi008,             #作業編號
     gzwi009 LIKE gzwi_t.gzwi009,             #案件代號
     gzwi010 LIKE gzwi_t.gzwi010,             #緊急案件
     gzwi011 LIKE gzwi_t.gzwi011,             #處理狀態
     gzwi012 LIKE gzwi_t.gzwi012,             #更新摘要
     gzwi013 DATETIME YEAR TO SECOND,         #反應日期
     gzwi014 LIKE gzwi_t.gzwi014,             #負責單位:SCC '153': 0.產中;1.MIS;2.鼎新
     gzwi015 LIKE gzwi_t.gzwi015,             #處理人員類型,聯絡對象類型oofa002
     gzwi016 LIKE gzwi_t.gzwi016,             #流水號
     gzwi017 LIKE gzwi_t.gzwi017,             #反映企業代碼
     gzwi018 LIKE gzwi_t.gzwi018,             #處理人員,聯絡對象代碼一oofa003
     gzwistus LIKE gzwi_t.gzwistus,           #狀態碼
     gzwiownid LIKE gzwi_t.gzwiownid,         #資料所有者
     gzwiownid_desc LIKE type_t.chr80,        ##
     gzwiowndp LIKE gzwi_t.gzwiowndp,         #資料所屬部門
     gzwiowndp_desc LIKE type_t.chr80,        ##
     gzwicrtid LIKE gzwi_t.gzwicrtid,         #資料建立者
     gzwicrtid_desc LIKE type_t.chr80,        ##
     gzwicrtdp LIKE gzwi_t.gzwicrtdp,         #資料建立部門
     gzwicrtdp_desc LIKE type_t.chr80,        ##
     gzwicrtdt DATETIME YEAR TO SECOND,       #資料創建日
     gzwimodid LIKE gzwi_t.gzwimodid,         #資料修改者
     gzwimodid_desc LIKE type_t.chr80,        ##
     gzwimoddt DATETIME YEAR TO SECOND,       #最近修改日
     gzwi005_desc LIKE type_t.chr80,          #反映人員名稱
     gzwi005dp_desc LIKE type_t.chr80,        #反映人員部門名稱
     gzwi005op_desc LIKE type_t.chr80,        #反映人員營運據點名稱
     gzwi008_desc LIKE gzzal_t.gzzal003,      #作業程式名稱
     gzwi025 LIKE gzwi_t.gzwi025,             #確認書編號
     gzwi026 LIKE gzwi_t.gzwi026,             #最近同步時間
     gzwi027 LIKE gzwi_t.gzwi027,             #案件歷程
     gzwi028 LIKE gzwi_t.gzwi028,             #客戶代號
     gzwi028_desc LIKE type_t.chr80 
     END RECORD
TYPE type_g_gzwo_inc RECORD              #問題反映記錄異動檔,共用:cl_helps932,azzi931,azzi932,azzp931,azzq932
     gzwoownid    LIKE gzwo_t.gzwoownid,   #資料所有者
     gzwoowndp    LIKE gzwo_t.gzwoowndp,   #資料所屬部門
     gzwocrtid    LIKE gzwo_t.gzwocrtid,   #資料建立者
     gzwocrtdp    LIKE gzwo_t.gzwocrtdp,   #資料建立部門
     gzwocrtdt    LIKE gzwo_t.gzwocrtdt,   #資料創建日
     gzwomodid    LIKE gzwo_t.gzwomodid,   #資料修改者
     gzwomoddt    LIKE gzwo_t.gzwomoddt,   #最近修改日
     gzwostus     LIKE gzwo_t.gzwostus,    #狀態碼
     gzwo001      LIKE gzwo_t.gzwo001,     #問題編號
     gzwo002      LIKE gzwo_t.gzwo002,     #類別
     gzwo003      LIKE gzwo_t.gzwo003,     #模組
     gzwo004      LIKE gzwo_t.gzwo004,     #問題描述
     gzwo005      LIKE gzwo_t.gzwo005,     #反映人員
     gzwo006      LIKE gzwo_t.gzwo006,     #反映營運據點
     gzwo007      LIKE gzwo_t.gzwo007,     #處理人員
     gzwo008      LIKE gzwo_t.gzwo008,     #作業編號
     gzwo009      LIKE gzwo_t.gzwo009,     #案件代號
     gzwo010      LIKE gzwo_t.gzwo010,     #緊急案件
     gzwo011      LIKE gzwo_t.gzwo011,     #處理狀態
     gzwo012      LIKE gzwo_t.gzwo012,     #更新摘要
     gzwo013      LIKE gzwo_t.gzwo013,     #反映日期
     gzwo014      LIKE gzwo_t.gzwo014,     #負責單位
     gzwo015      LIKE gzwo_t.gzwo015,     #處理人員類型
     gzwo016      LIKE gzwo_t.gzwo016,     #流水號
     gzwo017      LIKE gzwo_t.gzwo017,     #企業編號
     gzwo018      LIKE gzwo_t.gzwo018,     #處理人員
     gzwo019      LIKE gzwo_t.gzwo019,     #規格預計完成日
     gzwo020      LIKE gzwo_t.gzwo020,     #規格實際完成日
     gzwo021      LIKE gzwo_t.gzwo021,     #預計完成日
     gzwo022      LIKE gzwo_t.gzwo022,     #實際完成日
     gzwo023      LIKE gzwo_t.gzwo023,     #預估時數
     gzwo024      LIKE gzwo_t.gzwo024,     #實際時數
     gzwo025      LIKE gzwo_t.gzwo025,     #確認書編號
     gzwoseq      LIKE gzwo_t.gzwoseq,     #項次
     gzwo901      LIKE gzwo_t.gzwo901,     #執行指令
     gzwo902      LIKE gzwo_t.gzwo902,     #異動欄位
     gzwo026      LIKE gzwo_t.gzwo026,     #最近同步時間
     gzwo027      LIKE gzwo_t.gzwo027,     #案件歷程
     gzwo028      LIKE gzwo_t.gzwo028      #客戶代號
     END RECORD

DEFINE g_gzwi_inc  type_g_gzwi_inc

DEFINE g_oofa_sel DYNAMIC ARRAY OF RECORD    #聯絡對象檔資料,與cl_helps932,azzi932,azzi931,azzq932共用
       oofa001       LIKE oofa_t.oofa001,    #聯絡對象識別碼
       oofa002       LIKE oofa_t.oofa002,    #聯絡對象類型
       oofa003       LIKE oofa_t.oofa003,    #聯絡對象代碼一
       oofa011       LIKE oofa_t.oofa011,    #全名
       ooag003       LIKE ooag_t.ooag003,    #歸屬部門
       ooefl003_dp   LIKE ooefl_t.ooefl003,  #部門名稱
       ooag004       LIKE ooag_t.ooag004,    #歸屬營運據點
       ooefl003_op   LIKE ooefl_t.ooefl003,  #歸屬營運據點名稱
       ooefl003_site LIKE ooefl_t.ooefl003   #預設營運據點名稱
       END RECORD
DEFINE g_target_dir  STRING
DEFINE g_patch RECORD
       gzwi001 LIKE gzwi_t.gzwi001,
       gzwi006 LIKE gzwi_t.gzwi006,
       gzwi007 LIKE gzwi_t.gzwi007,
       gzwi015 LIKE gzwi_t.gzwi015,
       gzwi017 LIKE gzwi_t.gzwi017,
       gzwi018 LIKE gzwi_t.gzwi018,
       oofa001 LIKE oofa_t.oofa001,    #聯絡對象識別碼
       oofa002 LIKE oofa_t.oofa002,    #聯絡對象類型
       oofa003 LIKE oofa_t.oofa003     #聯絡對象代碼一
       END RECORD
DEFINE g_syncway            STRING                 #與服務平台同步方式 alm,almhelp,eservice
DEFINE g_gzwi028_show       BOOLEAN                #是否顯示客戶代號
#end add-point
       
#模組變數(Module Variables)
DEFINE g_gzwi_m          type_g_gzwi_m
DEFINE g_gzwi_m_t        type_g_gzwi_m
DEFINE g_gzwi_m_o        type_g_gzwi_m
DEFINE g_gzwi_m_mask_o   type_g_gzwi_m #轉換遮罩前資料
DEFINE g_gzwi_m_mask_n   type_g_gzwi_m #轉換遮罩後資料
 
   DEFINE g_gzwi001_t LIKE gzwi_t.gzwi001
 
 
DEFINE g_gzwj_d          DYNAMIC ARRAY OF type_g_gzwj_d
DEFINE g_gzwj_d_t        type_g_gzwj_d
DEFINE g_gzwj_d_o        type_g_gzwj_d
DEFINE g_gzwj_d_mask_o   DYNAMIC ARRAY OF type_g_gzwj_d #轉換遮罩前資料
DEFINE g_gzwj_d_mask_n   DYNAMIC ARRAY OF type_g_gzwj_d #轉換遮罩後資料
 
 
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
#g_argv[1]: 企業編號(作業參數指定)
#end add-point
 
{</section>}
 
{<section id="azzi932.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_cnt      LIKE type_t.num10
   DEFINE l_gzwc_t   STRING
   DEFINE l_sql      STRING                #161027-00047#1
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("azz","")
 
   #add-point:作業初始化 name="main.init"
#以後patch拿掉 ########################## START
#gzwi009 : 問題類型 no use -> 案件代號
UPDATE gzwi_t
SET gzwi009 = NULL
WHERE gzwi009 IN ('1','2')
#以後patch拿掉 ########################## END
   LET l_gzwc_t = "gzwc_t"
   CALL cl_helps932_syncway() RETURNING g_syncway
   #是否顯示客戶代號
   LET g_gzwi028_show = FALSE
   IF g_syncway = "alm" THEN
      LET l_cnt = 0
      LET g_sql = "SELECT COUNT(gzwc001) FROM ",l_gzwc_t CLIPPED
      PREPARE azzi932_gzwi028_show_pre FROM g_sql
      EXECUTE azzi932_gzwi028_show_pre INTO l_cnt
      IF l_cnt > 0 THEN
         LET g_gzwi028_show = TRUE
      END IF
   END IF
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   ###161027-00047#1 START ###
   #取未同步的附件數量
   LET l_sql = "SELECT COUNT(gzwj002) FROM gzwj_t",
               " WHERE gzwj001=? AND gzwj008 = 'N'"
   PREPARE azzi932_casefile_cnt_pre FROM l_sql
   DECLARE azzi932_casefile_cnt_curs CURSOR FOR azzi932_casefile_cnt_pre
   ###161027-00047#1 END ###
   #end add-point
   LET g_forupd_sql = " SELECT gzwi001,gzwi002,gzwi003,gzwi008,'',gzwi010,gzwi017,'',gzwi004,gzwi005, 
       '',gzwi013,gzwi006,'',gzwi015,gzwi016,gzwi018,'',gzwi007,gzwi011,gzwi012,gzwi027,gzwi014,gzwi009, 
       gzwi026,gzwi019,gzwi020,gzwi021,gzwi022,gzwi023,gzwi024,gzwi025,gzwi028,'',gzwistus,gzwiownid, 
       '',gzwiowndp,'',gzwicrtid,'',gzwicrtdp,'',gzwicrtdt,gzwimodid,'',gzwimoddt", 
                      " FROM gzwi_t",
                      " WHERE gzwi001=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE azzi932_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.gzwi001,t0.gzwi002,t0.gzwi003,t0.gzwi008,t0.gzwi010,t0.gzwi017,t0.gzwi004, 
       t0.gzwi005,t0.gzwi013,t0.gzwi006,t0.gzwi015,t0.gzwi016,t0.gzwi018,t0.gzwi007,t0.gzwi011,t0.gzwi012, 
       t0.gzwi027,t0.gzwi014,t0.gzwi009,t0.gzwi026,t0.gzwi019,t0.gzwi020,t0.gzwi021,t0.gzwi022,t0.gzwi023, 
       t0.gzwi024,t0.gzwi025,t0.gzwi028,t0.gzwistus,t0.gzwiownid,t0.gzwiowndp,t0.gzwicrtid,t0.gzwicrtdp, 
       t0.gzwicrtdt,t0.gzwimodid,t0.gzwimoddt,t1.gzzal003 ,t2.gzoul003 ,t3.ooag011 ,t4.ooefl003 ,t5.oofa011 , 
       t6.oofa011 ,t7.ooag011 ,t8.ooefl003 ,t9.ooag011 ,t10.ooefl003 ,t11.ooag011",
               " FROM gzwi_t t0",
                              " LEFT JOIN gzzal_t t1 ON t1.gzzal001=t0.gzwi008 AND t1.gzzal002='"||g_lang||"' ",
               " LEFT JOIN gzoul_t t2 ON t2.gzoul001=t0.gzwi017 AND t2.gzoul002='"||g_lang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.gzwi005  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.gzwi006 AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oofa_t t5 ON t5.oofaent="||g_enterprise||" AND t5.oofa001=t0.gzwi007  ",
               " LEFT JOIN oofa_t t6 ON t6.oofaent="||g_enterprise||" AND t6.oofa001=t0.gzwi028  ",
               " LEFT JOIN ooag_t t7 ON t7.ooagent="||g_enterprise||" AND t7.ooag001=t0.gzwiownid  ",
               " LEFT JOIN ooefl_t t8 ON t8.ooeflent="||g_enterprise||" AND t8.ooefl001=t0.gzwiowndp AND t8.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t9 ON t9.ooagent="||g_enterprise||" AND t9.ooag001=t0.gzwicrtid  ",
               " LEFT JOIN ooefl_t t10 ON t10.ooeflent="||g_enterprise||" AND t10.ooefl001=t0.gzwicrtdp AND t10.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t11 ON t11.ooagent="||g_enterprise||" AND t11.ooag001=t0.gzwimodid  ",
 
               " WHERE  t0.gzwi001 = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   IF g_gzwi028_show THEN   #手動維護
      LET g_sql = " SELECT UNIQUE t0.gzwi001,t0.gzwi002,t0.gzwi003,t0.gzwi008,t0.gzwi010,t0.gzwi017,t0.gzwi004,",
          " t0.gzwi005,t0.gzwi013,t0.gzwi006,t0.gzwi015,t0.gzwi016,t0.gzwi018,t0.gzwi007,t0.gzwi011,t0.gzwi012,",
          " t0.gzwi027,t0.gzwi014,t0.gzwi009,t0.gzwi026,t0.gzwi019,t0.gzwi020,t0.gzwi021,t0.gzwi022,t0.gzwi023,", 
          " t0.gzwi024,t0.gzwi025,t0.gzwi028,t0.gzwistus,t0.gzwiownid,t0.gzwiowndp,t0.gzwicrtid,t0.gzwicrtdp,", 
          " t0.gzwicrtdt,t0.gzwimodid,t0.gzwimoddt,t1.gzzal003 ,t2.gzoul003 ,t3.ooag011 ,t4.ooefl003 ,t5.oofa011,", 
          #" t6.oofa011 ,t7.ooag011 ,t8.ooefl003 ,t9.ooag011 ,t10.ooefl003 ,t11.ooag011",
          " t6.gzwc002 ,t7.ooag011 ,t8.ooefl003 ,t9.ooag011 ,t10.ooefl003 ,t11.ooag011",
                  " FROM gzwi_t t0",
                                 " LEFT JOIN gzzal_t t1 ON t1.gzzal001=t0.gzwi008 AND t1.gzzal002='"||g_lang||"' ",
                  " LEFT JOIN gzoul_t t2 ON t2.gzoul001=t0.gzwi017 AND t2.gzoul002='"||g_lang||"' ",
                  " LEFT JOIN ooag_t t3 ON t3.ooagent='"||g_enterprise||"' AND t3.ooag001=t0.gzwi005  ",
                  " LEFT JOIN ooefl_t t4 ON t4.ooeflent='"||g_enterprise||"' AND t4.ooefl001=t0.gzwi006 AND t4.ooefl002='"||g_dlang||"' ",
                  " LEFT JOIN oofa_t t5 ON t5.oofaent='"||g_enterprise||"' AND t5.oofa001=t0.gzwi007  ",
                  #" LEFT JOIN oofa_t t6 ON t6.oofaent='"||g_enterprise||"' AND t6.oofa001=t0.gzwi028  ",
                  " LEFT JOIN ",l_gzwc_t CLIPPED," t6 ON t6.gzwc001=t0.gzwi028",
                  " LEFT JOIN ooag_t t7 ON t7.ooagent='"||g_enterprise||"' AND t7.ooag001=t0.gzwiownid  ",
                  " LEFT JOIN ooefl_t t8 ON t8.ooeflent='"||g_enterprise||"' AND t8.ooefl001=t0.gzwiowndp AND t8.ooefl002='"||g_dlang||"' ",
                  " LEFT JOIN ooag_t t9 ON t9.ooagent='"||g_enterprise||"' AND t9.ooag001=t0.gzwicrtid  ",
                  " LEFT JOIN ooefl_t t10 ON t10.ooeflent='"||g_enterprise||"' AND t10.ooefl001=t0.gzwicrtdp AND t10.ooefl002='"||g_dlang||"' ",
                  " LEFT JOIN ooag_t t11 ON t11.ooagent='"||g_enterprise||"' AND t11.ooag001=t0.gzwimodid  ",
                  " WHERE  t0.gzwi001 = ?"
      LET g_sql = cl_sql_add_mask(g_sql)
   END IF
   #end add-point
   PREPARE azzi932_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_azzi932 WITH FORM cl_ap_formpath("azz",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL azzi932_init()   
 
      #進入選單 Menu (="N")
      CALL azzi932_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_azzi932
      
   END IF 
   
   CLOSE azzi932_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="azzi932.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION azzi932_init()
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
 
   LET g_error_show  = 1
   LET l_ac = 1 #單身指標
      CALL cl_set_combo_scc_part('gzwistus','17','N,Y')
 
      CALL cl_set_combo_scc('gzwi002','140') 
   CALL cl_set_combo_scc('gzwi015','1') 
   CALL cl_set_combo_scc('gzwi011','147') 
   CALL cl_set_combo_scc('gzwi014','153') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_module("gzwi003",1)   #模組
   CALL cl_set_combo_scc_part('gzwi015','1','0,2')    #聯絡對象類型

   #browse
   CALL cl_set_combo_scc('b_gzwi002','140')           #問題反映類別
   CALL cl_set_combo_scc('b_gzwi011','147')           #問題反映處理狀態
   CALL cl_set_combo_scc_part('b_gzwi015','1','0,2') 
   CALL cl_set_combo_module("b_gzwi003",1)            #模組

   LET g_target_dir = FGL_GETENV("TEMPDIR")

   IF g_syncway = "alm" THEN
      IF g_gzwi028_show THEN   #是否顯示客戶代號
         CALL gfrm_curr.setElementHidden("formonly.b_gzwi028",0)        #客戶代號
         CALL gfrm_curr.setElementHidden("formonly.b_gzwi028_desc",0)
         CALL gfrm_curr.setElementHidden("lbl_gzwi028",0)
         CALL gfrm_curr.setElementHidden("gzwi_t.gzwi028",0)
         CALL gfrm_curr.setElementHidden("formonly.gzwi028_desc",0)
      END IF
   ELSE
      CALL cl_set_combo_scc_part('gzwi014','153','1,2')   #SCC '153': 0.產中;1.MIS;2.鼎新
   END IF
   #end add-point
   
   #初始化搜尋條件
   CALL azzi932_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="azzi932.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION azzi932_ui_dialog()
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
   DEFINE li_stat                LIKE type_t.num5
   DEFINE l_i                    LIKE type_t.num10
   DEFINE l_j                    LIKE type_t.num10      #161027-00047#1
   DEFINE l_cnt                  LIKE type_t.num10
   DEFINE l_actnode              om.DomNode
   DEFINE l_chk                  BOOLEAN
   DEFINE l_newfile              BOOLEAN                #是否新增
   DEFINE l_browser              DYNAMIC ARRAY OF type_browser
   DEFINE l_gzwi009              LIKE gzwi_t.gzwi009    #案件代號
   DEFINE l_diffold              type_g_gzwo_inc        #原始資料
   DEFINE l_diffnew              type_g_gzwo_inc        #異動後
   DEFINE l_change_mail          BOOLEAN                #是否因資料改變而需要寄送mail
   DEFINE l_tarfile              STRING
   DEFINE l_colname, l_comment   STRING
   #DEFINE l_server_uri           STRING                 #azzs010設定:Help 接口網址 (產中:型管/客戶:服管)   #161027-00047#1 mark
   DEFINE l_gzwipk          DYNAMIC ARRAY OF RECORD
          gzwi001  LIKE gzwi_t.gzwi001
          END RECORD
   DEFINE l_almurl               STRING                 #型管需求單程式網址       #160509-00001#1
   DEFINE l_eservice_webcfg      STRING                 #鼎新用戶服務平台網址設定 #160606-00027#1
   DEFINE l_eservice_weburl      LIKE gzzd_t.gzzd005    #鼎新用戶服務平台網址     #160606-00027#1
   DEFINE l_sql                  STRING                 #160606-00027#1
   DEFINE l_caseidlist      DYNAMIC ARRAY OF RECORD  #案件清單    #160805-00001#1
          gzwi001  LIKE gzwi_t.gzwi001,
          gzwi011  LIKE gzwi_t.gzwi011,
          caseid   LIKE gzwi_t.gzwi009
          END RECORD
   DEFINE l_syncold         DYNAMIC ARRAY OF type_g_gzwo_inc  #160805-00001#1
   DEFINE l_mail_chk        BOOLEAN                           #160805-00001#1
   DEFINE l_gzwo_m DYNAMIC ARRAY OF RECORD                    #接收反映鼎新後的資料  #160805-00001#1
          l_chk      BOOLEAN,
          gzwo001    LIKE gzwo_t.gzwo001,
          gzwo009    LIKE gzwo_t.gzwo009,
          gzwo014    LIKE gzwo_t.gzwo014,
          gzwomodid  LIKE gzwo_t.gzwomodid ,
          gzwomoddt  LIKE gzwo_t.gzwomoddt
          END RECORD
   DEFINE l_temp DYNAMIC ARRAY OF STRING                #160805-00001#1
   DEFINE l_errcode          STRING                     #err錯誤訊息編碼             #161027-00047#1
   DEFINE l_errextend        STRING                     #err出現在開頭的延伸訊息字串  #161027-00047#1
   DEFINE l_gzwj_d      DYNAMIC ARRAY OF RECORD         #161027-00047#1
          gzwj002       LIKE gzwj_t.gzwj002,
          gzwj004       LIKE gzwj_t.gzwj004,
          gzwj005       LIKE gzwj_t.gzwj005,
          fileimg       LIKE type_t.chr500,
          gzwj007       LIKE gzwj_t.gzwj007,
          fileids       STRING,                         #服務平台附件代號
          errcode       STRING,                         #錯誤訊息代碼
          errextend     STRING,
          errreplace1   STRING
          END RECORD
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
   
   
   LET lb_first = TRUE
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
   
   WHILE TRUE 
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_gzwi_m.* TO NULL
         CALL g_gzwj_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL azzi932_init()
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
               
               CALL azzi932_fetch('') # reload data
               LET l_ac = 1
               CALL azzi932_ui_detailshow() #Setting the current row 
         
               CALL azzi932_idx_chk()
               #NEXT FIELD gzwj002
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_gzwj_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL azzi932_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1',",l_ac)
               
               #add-point:page1, before row動作 name="ui_dialog.page1.before_row"
               CALL azzi932_set_act_visible_b()     #161027-00047#1
               CALL azzi932_set_act_no_visible_b()  #161027-00047#1
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
               CALL azzi932_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               CALL azzi932_set_act_visible_b()     #161027-00047#1
               CALL azzi932_set_act_no_visible_b()  #161027-00047#1
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
 
            #end add-point
               
         END DISPLAY
        
 
         
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL azzi932_browser_fill("")
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
               CALL azzi932_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL azzi932_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL azzi932_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            #LET l_server_uri = cl_get_para(g_enterprise,"",'A-SYS-0039')   #Help 接口網址   #161027-00047#1 mark
            ###161027-00047#1 START ###
            #只隱藏一次,不依資料決定是否隱藏 ex.TopMenu
            IF g_syncway = " " THEN
               CALL cl_set_act_visible("helptoalm", FALSE)
               CALL gfrm_curr.setElementHidden("helptoalm",TRUE)
            END IF
            IF g_syncway != "eservice" THEN
               CALL cl_set_act_visible("helpcase", FALSE)            #批次更新案件
               CALL gfrm_curr.setElementHidden("helpcase",TRUE)
               CALL cl_set_act_visible("helpcase_1", FALSE)          #更新案件
               CALL gfrm_curr.setElementHidden("helpcase_1",TRUE)
               CALL cl_set_act_visible("btn_casefile1", FALSE)       #同步附件
               CALL gfrm_curr.setElementHidden("btn_casefile1",TRUE)
            END IF
            IF g_syncway = "alm" THEN
               #改按鈕文字
               CALL s_azzi902_get_gzzd("azzi931","lbl_is_helptoalm_digiwin") RETURNING l_colname, l_comment
               CALL gfrm_curr.setElementText("helptoalm", l_colname)
            ELSE
               CALL cl_set_act_visible("qry_case", FALSE)         #160509-00001#1
               CALL gfrm_curr.setElementHidden("qry_case",TRUE)   #160509-00001#1
            END IF

            #依資料決定是否隱藏
            CALL azzi932_set_act_visible() 
            CALL azzi932_set_act_no_visible()
            CALL azzi932_set_act_visible_b()     #161027-00047#1
            CALL azzi932_set_act_no_visible_b()  #161027-00047#1
            ###161027-00047#1 END ###
            DISPLAY "g_syncway=",g_syncway
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL azzi932_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL azzi932_set_act_visible()   
            CALL azzi932_set_act_no_visible()
            IF NOT (g_gzwi_m.gzwi001 IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " ",
                                  " gzwi001 = '", g_gzwi_m.gzwi001, "' "
 
               #填到對應位置
               CALL azzi932_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "gzwi_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "gzwj_t" 
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
               CALL azzi932_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "gzwi_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "gzwj_t" 
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
                  CALL azzi932_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL azzi932_fetch("F")
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
               CALL azzi932_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL azzi932_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL azzi932_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL azzi932_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL azzi932_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL azzi932_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL azzi932_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL azzi932_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL azzi932_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL azzi932_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL azzi932_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_gzwj_d)
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
               NEXT FIELD gzwj002
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
         ON ACTION export_helplist
            LET g_action_choice="export_helplist"
            IF cl_auth_chk_act("export_helplist") THEN
               
               #add-point:ON ACTION export_helplist name="menu.export_helplist"
               #匯出清單與附件
               #主頁摺疊
               IF g_main_hidden = 0 THEN
                  CALL gfrm_curr.setElementHidden("mainlayout",1)
                  CALL gfrm_curr.setElementHidden("worksheet",0)
                  LET g_main_hidden = 1
               END IF
            
               #browser
               CALL g_export_node.clear()
               IF g_main_hidden = 1 THEN
                  LET g_export_node[1] = base.typeInfo.create(g_browser)
                  LET g_export_id[1]   = "s_browse"
                  #CALL cl_helps932_export_helplist("export_helplist",g_target_dir,g_browser) RETURNING l_chk,l_tarfile
                  LET l_cnt = g_browser.getLength()
                  CALL l_gzwipk.clear()
                  FOR l_i = 1 TO l_cnt
                     LET l_gzwipk[l_i].gzwi001 = g_browser[l_i].b_gzwi001   #問題編號
                  END FOR
                  CALL cl_helps932_export_helplist("export_helplist",g_target_dir,l_gzwipk) RETURNING l_chk,l_tarfile
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL azzi932_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL azzi932_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
 
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION btn_showfileimg
            LET g_action_choice="btn_showfileimg"
            IF cl_auth_chk_act("btn_showfileimg") THEN
               
               #add-point:ON ACTION btn_showfileimg name="menu.btn_showfileimg"
               #開啟附件
               LET l_i = g_gzwj_d.getLength()
               IF l_i > 0 AND l_ac > 0 AND l_i >= l_ac THEN
                  CALL cl_helps932_open_url("TEMPDIR",g_gzwj_d[l_ac].fileimg) RETURNING li_stat
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL azzi932_delete()
               #add-point:ON ACTION delete name="menu.delete"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION helpcase_1
            LET g_action_choice="helpcase_1"
            IF cl_auth_chk_act("helpcase_1") THEN
               
               #add-point:ON ACTION helpcase_1 name="menu.helpcase_1"
               ####160805-00001#1  START  ###
               IF NOT cl_null(g_gzwi_m.gzwi009) THEN
                  CALL l_caseidlist.clear()               
                  LET l_caseidlist[1].caseid = g_gzwi_m.gzwi009      
                  LET l_caseidlist[1].gzwi001 = g_gzwi_m.gzwi001     
                  LET l_caseidlist[1].gzwi011 = g_gzwi_m.gzwi011     
                  CALL cl_helps932_helpcase(l_caseidlist,TRUE)   #更新案件 
                  CALL azzi932_browser_fill("")
                  CALL azzi932_fetch(g_current_idx)
               END IF
               ####160805-00001#1  END    ###
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION showlog
            LET g_action_choice="showlog"
            IF cl_auth_chk_act("showlog") THEN
               
               #add-point:ON ACTION showlog name="menu.showlog"
               #異動記錄
               IF cl_null(g_gzwi_m.gzwi001) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code   = "-6372"   #查無此筆資料
                  LET g_errparam.popup  = TRUE
                  CALL cl_err()
               ELSE
                  LET g_sql = "SELECT COUNT(gzwo001) FROM gzwo_t WHERE gzwo001 = ?"
                  PREPARE azzi932_gzwo_cnt_pre FROM g_sql
                  EXECUTE azzi932_gzwo_cnt_pre USING g_gzwi_m.gzwi001 INTO l_cnt
                  IF l_cnt > 0 THEN
                     ####160805-00001#1  START ###
                     LET l_temp[1] = g_argv[1]  #備份
                     LET l_temp[2] = g_argv[2]  #備份
                     
                     CALL g_argv.clear()                 #清空，否則會影響函式的參數傳遞  
                     CALL azzi932_01(g_gzwi_m.gzwi001)   #歷程記錄
                     
                     LET g_argv[1] = l_temp[1]  #還原
                     LET g_argv[2] = l_temp[2]  #還原
                     ####160805-00001#1  END   ###
                  ELSE
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code   = "-6372"   #查無此筆資料
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                  END IF
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION btn_casefile1
            LET g_action_choice="btn_casefile1"
            IF cl_auth_chk_act("btn_casefile1") THEN
               
               #add-point:ON ACTION btn_casefile1 name="menu.btn_casefile1"
               #同步附件
               ###161027-00047#1 START ###
               #有案件代號才能做同步
               IF NOT cl_null(g_gzwi_m.gzwi009) THEN
                  CALL cl_helps932_casefile(g_gzwi_m.gzwi001,g_gzwi_m.gzwi009) RETURNING l_gzwj_d
                  LET l_j = l_gzwj_d.getLength()
                  FOR l_i = 1 TO l_j
                     #IF NOT cl_null(l_gzwj_d[l_i].fileids) THEN
                     #   LET l_casefinish.fileids[l_casefinish.fileids.getLength() + 1] = l_gzwj_d[l_i].fileids CLIPPED
                     #END IF
                     IF NOT cl_null(l_gzwj_d[l_i].errcode) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = l_gzwj_d[l_i].errcode
                        LET g_errparam.extend = l_gzwj_d[l_i].errextend
                        LET g_errparam.replace[1] = l_gzwj_d[l_i].errreplace1
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                     END IF
                  END FOR
                  CALL azzi932_b_fill() #單身填充
                  CALL azzi932_b_fill2('0') #單身填充   #161027-00047#1
               END IF
               ###161027-00047#1 END ###
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION btn_newfileimg
            LET g_action_choice="btn_newfileimg"
            IF cl_auth_chk_act("btn_newfileimg") THEN
               
               #add-point:ON ACTION btn_newfileimg name="menu.btn_newfileimg"
               #新增附件
               ###161027-00047#1 START ###
               CALL s_transaction_begin()
               OPEN azzi932_cl USING g_gzwi_m.gzwi001   #避免附件編號重複搶號,所以要鎖主檔
               IF STATUS THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = "OPEN azzi932_cl:newfileimg"
                  LET g_errparam.code   = STATUS
                  LET g_errparam.popup  = TRUE
                  CLOSE azzi932_cl
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
               ELSE
                  CALL cl_helps932_newfile(g_gzwi_m.gzwi001,"r",TRUE) RETURNING l_newfile,l_errcode,l_errextend
                  CALL s_transaction_end('Y','0')
                  #有案件代號需要做同步
                  IF l_newfile AND (NOT cl_null(g_gzwi_m.gzwi009)) THEN
                     CALL cl_helps932_casefile(g_gzwi_m.gzwi001,g_gzwi_m.gzwi009) RETURNING l_gzwj_d
                     LET l_j = l_gzwj_d.getLength()
                     FOR l_i = 1 TO l_j
                        #IF NOT cl_null(l_gzwj_d[l_i].fileids) THEN
                        #   LET l_casefinish.fileids[l_casefinish.fileids.getLength() + 1] = l_gzwj_d[l_i].fileids CLIPPED
                        #END IF
                        IF NOT cl_null(l_gzwj_d[l_i].errcode) THEN
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = l_gzwj_d[l_i].errcode
                           LET g_errparam.extend = l_gzwj_d[l_i].errextend
                           LET g_errparam.replace[1] = l_gzwj_d[l_i].errreplace1
                           LET g_errparam.popup = TRUE
                           CALL cl_err()
                        END IF
                     END FOR
                  END IF

                  IF l_newfile THEN
                     CALL azzi932_b_fill() #單身填充
                     CALL azzi932_b_fill2('0') #單身填充   #161027-00047#1
                  END IF
               END IF
               ###161027-00047#1 END ###
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION eservice_website
            LET g_action_choice="eservice_website"
            IF cl_auth_chk_act("eservice_website") THEN
               
               #add-point:ON ACTION eservice_website name="menu.eservice_website"
               #在 TOPMENU 提供鼎新用戶服務平台網址   #160606-00027#1 2016/6/27 炯華:網址寫在程式中
               #鼎捷用戶服務平台 http://eservice.digiwin.com.cn, 鼎新用戶服務平台 http://service.digiwin.biz
               LET l_sql = "SELECT gzzd005 FROM gzzd_t",
                           " WHERE gzzd001='azzi932' AND gzzd003='A-SYS-0056' AND gzzdstus='Y'",
                           " AND gzzd002=?"
               PREPARE azzi932_eservice_website_pre FROM l_sql

               LET l_eservice_webcfg = cl_get_para(g_enterprise,"",'A-SYS-0056')
               LET l_eservice_weburl = ""
               CASE
                  WHEN l_eservice_webcfg = "C"   #鼎捷用戶服務平台
                     EXECUTE azzi932_eservice_website_pre USING "zh_CN" INTO l_eservice_weburl
                  WHEN l_eservice_webcfg = "T"   #鼎新用戶服務平台l_eservice_weburl
                     EXECUTE azzi932_eservice_website_pre USING "zh_TW" INTO l_eservice_weburl
                  OTHERWISE
                     CASE g_lang
                        WHEN "zh_CN"
                           EXECUTE azzi932_eservice_website_pre USING "zh_CN" INTO l_eservice_weburl
                        WHEN "zh_TW"
                           EXECUTE azzi932_eservice_website_pre USING "zh_TW" INTO l_eservice_weburl
                        OTHERWISE
                           EXECUTE azzi932_eservice_website_pre USING "zh_CN" INTO l_eservice_weburl
                     END CASE
               END CASE

               IF cl_null(l_eservice_weburl) THEN
                  LET l_eservice_weburl = "http://eservice.digiwin.com.cn/"
               END IF
               CALL ui.interface.frontCall("standard","launchurl",[l_eservice_weburl],[])
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL azzi932_query()
               #add-point:ON ACTION query name="menu.query"
               CALL azzi932_set_act_visible()   
               CALL azzi932_set_act_no_visible()
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION qry_case
            LET g_action_choice="qry_case"
            IF cl_auth_chk_act("qry_case") THEN
               
               #add-point:ON ACTION qry_case name="menu.qry_case"
               #內部串接型管簡易需求單
               IF g_syncway = "alm" AND (NOT cl_null(g_gzwi_m.gzwi009)) THEN
                  LET l_almurl = "http://10.40.40.35/scmprd/wa/r/scmprd-app/appq012?",
                                 "Arg=",g_account CLIPPED,"&",              #Arg1=帳號 
                                 "Arg=",g_lang CLIPPED,"&",                 #Arg2=語系
                                 "Arg=",g_gzwi_m.gzwi009 CLIPPED,"&",       #Arg3=需求單號
                                 "Arg=",FGL_GETENV("ERPID") CLIPPED,"&",    #Arg4=產品代號 $ERPID
                                 "Arg=",FGL_GETENV("ERPVER") CLIPPED        #Arg5=產品版本 $ERPVER
                  #DISPLAY "l_almurl=",l_almurl
                  CALL ui.Interface.frontCall( "standard", "launchurl", l_almurl, [li_stat] )
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION helptoalm
            LET g_action_choice="helptoalm"
            IF cl_auth_chk_act("helptoalm") THEN
               
               #add-point:ON ACTION helptoalm name="menu.helptoalm"
               #反映鼎新
               IF g_browser.getLength() = 0 THEN
                  LET l_chk = FALSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "-100"   #指定的資料無法查詢到，請再確認條件是否正確
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               ELSE
                  LET l_chk = TRUE
               END IF

               IF (g_syncway != " ") AND l_chk THEN
                  CALL l_gzwo_m.clear()
                  CALL l_syncold.clear()
                  #案件代號存在表示已轉單
                  SELECT COUNT(gzwi001) INTO l_cnt FROM gzwi_t
                     WHERE gzwi001 = g_browser[g_current_idx].b_gzwi001 AND gzwi009 IS NOT NULL
                  IF l_cnt > 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "azz-00764"   #問題編號%1已曾轉單,不需重複轉單
                     LET g_errparam.replace[1] = g_browser[g_current_idx].b_gzwi001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  ELSE
                     LET l_syncold[1].gzwoownid = g_gzwi_m.gzwiownid  #資料所有者
                     LET l_syncold[1].gzwoowndp = g_gzwi_m.gzwiowndp  #資料所屬部門
                     LET l_syncold[1].gzwocrtid = g_gzwi_m.gzwicrtid  #資料建立者
                     LET l_syncold[1].gzwocrtdp = g_gzwi_m.gzwicrtdp  #資料建立部門
                     LET l_syncold[1].gzwocrtdt = g_gzwi_m.gzwicrtdt  #資料創建日
                     LET l_syncold[1].gzwomodid = g_gzwi_m.gzwimodid  #資料修改者
                     LET l_syncold[1].gzwomoddt = g_gzwi_m.gzwimoddt  #最近修改日
                     LET l_syncold[1].gzwostus  = g_gzwi_m.gzwistus   #狀態碼
                     LET l_syncold[1].gzwo001   = g_gzwi_m.gzwi001    #問題編號
                     LET l_syncold[1].gzwo002   = g_gzwi_m.gzwi002    #類別
                     LET l_syncold[1].gzwo003   = g_gzwi_m.gzwi003    #模組
                     LET l_syncold[1].gzwo004   = g_gzwi_m.gzwi004    #問題描述
                     LET l_syncold[1].gzwo005   = g_gzwi_m.gzwi005    #反映人員
                     LET l_syncold[1].gzwo006   = g_gzwi_m.gzwi006    #反映營運據點
                     LET l_syncold[1].gzwo007   = g_gzwi_m.gzwi007    #處理人員
                     LET l_syncold[1].gzwo008   = g_gzwi_m.gzwi008    #作業編號
                     LET l_syncold[1].gzwo009   = g_gzwi_m.gzwi009    #案件代號
                     LET l_syncold[1].gzwo010   = g_gzwi_m.gzwi010    #緊急案件
                     LET l_syncold[1].gzwo011   = g_gzwi_m.gzwi011    #處理狀態
                     LET l_syncold[1].gzwo012   = g_gzwi_m.gzwi012    #更新摘要
                     LET l_syncold[1].gzwo013   = g_gzwi_m.gzwi013    #反映日期
                     LET l_syncold[1].gzwo014   = g_gzwi_m.gzwi014    #負責單位
                     LET l_syncold[1].gzwo015   = g_gzwi_m.gzwi015    #處理人員類型
                     LET l_syncold[1].gzwo016   = g_gzwi_m.gzwi016    #流水號
                     LET l_syncold[1].gzwo017   = g_gzwi_m.gzwi017    #企業編號
                     LET l_syncold[1].gzwo018   = g_gzwi_m.gzwi018    #處理人員
                     LET l_syncold[1].gzwo019   = g_gzwi_m.gzwi019    #規格預計完成日
                     LET l_syncold[1].gzwo020   = g_gzwi_m.gzwi020    #規格實際完成日
                     LET l_syncold[1].gzwo021   = g_gzwi_m.gzwi021    #預計完成日
                     LET l_syncold[1].gzwo022   = g_gzwi_m.gzwi022    #實際完成日
                     LET l_syncold[1].gzwo023   = g_gzwi_m.gzwi023    #預估時數
                     LET l_syncold[1].gzwo024   = g_gzwi_m.gzwi024    #實際時數
                     LET l_syncold[1].gzwo025   = g_gzwi_m.gzwi025    #確認書編號
                     LET l_syncold[1].gzwo026   = g_gzwi_m.gzwi026    #最近同步時間
                     LET l_syncold[1].gzwo027   = g_gzwi_m.gzwi027    #案件歷程
                     LET l_syncold[1].gzwo028   = g_gzwi_m.gzwi028    #客戶代號
#
#                     LET l_tarfile = ""
#                     IF (g_syncway = "alm" OR g_syncway = "almhelp") THEN
#                        CALL l_gzwipk.clear()
#                        LET l_gzwipk[1].gzwi001 = g_browser[g_current_idx].b_gzwi001   #問題編號
#                        CALL cl_helps932_export_helplist("helptoalm",g_target_dir,l_gzwipk) RETURNING l_chk,l_tarfile
#                     END IF
#
#                     IF l_chk THEN
#                        CALL cl_helps932_sync("RE",l_tarfile,l_diffold.*) RETURNING l_chk,l_change_mail,
#                                                                       g_gzwi_m.gzwi009,g_gzwi_m.gzwi014,
#                                                                       g_gzwi_m.gzwimodid,g_gzwi_m.gzwimoddt
#                        IF l_chk THEN
#                           LET g_gzwi_m.gzwimodid_desc = cl_get_username(g_gzwi_m.gzwimodid)
#                           CALL azzi932_set_act_no_visible()
#
#                           INITIALIZE g_errparam TO NULL
#                           LET g_errparam.code = "adz-00077"   #資料已為您送出
#                           LET g_errparam.extend = "(" || g_gzwi_m.gzwi009 CLIPPED || ")"
#                           LET g_errparam.extend = g_gzwi_m.gzwi001 CLIPPED,g_errparam.extend CLIPPED
#                           LET g_errparam.popup = TRUE
#                           CALL cl_err()
#                        ELSE
#                           #還原舊值
#                           LET g_gzwi_m.gzwi009 = l_diffold.gzwo009
#                           LET g_gzwi_m.gzwi014 = l_diffold.gzwo014
#                           LET g_gzwi_m.gzwimodid = l_diffold.gzwomodid
#                           LET g_gzwi_m.gzwimoddt = l_diffold.gzwomoddt
#                        END IF
#
#                        DISPLAY BY NAME g_gzwi_m.gzwi009,g_gzwi_m.gzwi014,
#                                        g_gzwi_m.gzwimodid,g_gzwi_m.gzwimodid_desc,g_gzwi_m.gzwimoddt
#                     END IF
                     
                      CALL cl_helps932_sync_batch(TRUE,TRUE,l_syncold) RETURNING l_gzwo_m   #反映鼎新 #160606-00027#1
                      IF l_gzwo_m[1].l_chk THEN
                         CALL azzi932_browser_fill("")
                         CALL azzi932_fetch(g_current_idx)
                      END IF
                  END IF
               END IF

               IF g_syncway = "alm" THEN
                 IF (NOT cl_null(g_gzwi_m.gzwi009)) AND g_gzwi_m.gzwi014 = '0' THEN
                    CALL cl_set_act_visible("qry_case", TRUE)     #160509-00001#1
                 ELSE
                    CALL cl_set_act_visible("qry_case", FALSE)    #160509-00001#1
                 END IF
               END IF
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION helpcase
            LET g_action_choice="helpcase"
            IF cl_auth_chk_act("helpcase") THEN
               
               #add-point:ON ACTION helpcase name="menu.helpcase"
               #批次更新案件
               ####160805-00001#1  START  ###
               CALL l_caseidlist.clear()                           
               FOR l_cnt = 1 TO g_browser.getLength()   
                  LET l_caseidlist[l_cnt].caseid = g_browser[l_cnt].b_gzwi009      
                  LET l_caseidlist[l_cnt].gzwi001 = g_browser[l_cnt].b_gzwi001     
                  LET l_caseidlist[l_cnt].gzwi011 = g_browser[l_cnt].b_gzwi011
               END FOR
               IF l_caseidlist.getLength() > 0 THEN
                  IF cl_ask_confirm("azz-01156") THEN   
                     LET l_mail_chk = TRUE              
                  ELSE                                  
                     LET l_mail_chk = FALSE             
                  END IF                                
                  CALL cl_helps932_helpcase(l_caseidlist,l_mail_chk)   #批次更新案件
                  CALL azzi932_browser_fill("")
                  CALL azzi932_fetch(g_current_idx)
               ELSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "azz-01128"   
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               END IF
               ####160805-00001#1  END    ###
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION prog_gzwi005
            LET g_action_choice="prog_gzwi005"
            IF cl_auth_chk_act("prog_gzwi005") THEN
               
               #add-point:ON ACTION prog_gzwi005 name="menu.prog_gzwi005"
               #應用 a45 樣板自動產生(Version:3)
               #反映人員：人員通訊聯絡下拉選單串aooi130員工資料維護作業
               CALL cl_user_contact("aooi130", "ooag_t", "ooag002", "ooag001", g_gzwi_m.gzwi005)   #160524-00016#1
               #END add-point
               
            END IF
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL azzi932_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL azzi932_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL azzi932_set_pk_array()
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
 
{<section id="azzi932.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION azzi932_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   DEFINE l_gzwc_t          STRING
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
      LET l_sub_sql = " SELECT DISTINCT gzwi001 ",
                      " FROM gzwi_t ",
                      " ",
                      " LEFT JOIN gzwj_t ON gzwi001 = gzwj001 ", "  ",
                      #add-point:browser_fill段sql(gzwj_t1) name="browser_fill.cnt.join.}"
                      
                      #end add-point
 
 
                      " ", 
                      " ", 
 
 
                      " WHERE   ",l_wc, " AND ", l_wc2, cl_sql_add_filter("gzwi_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT gzwi001 ",
                      " FROM gzwi_t ", 
                      "  ",
                      "  ",
                      " WHERE  ",l_wc CLIPPED, cl_sql_add_filter("gzwi_t")
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
      INITIALIZE g_gzwi_m.* TO NULL
      CALL g_gzwj_d.clear()        
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.gzwi028,t0.gzwi011,t0.gzwi001,t0.gzwi017,t0.gzwi002,t0.gzwi003,t0.gzwi008,t0.gzwi010,t0.gzwi004,t0.gzwi012,t0.gzwi005,t0.gzwi013,t0.gzwi006,t0.gzwi015,t0.gzwi018,t0.gzwi009,t0.gzwi025 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.gzwistus,t0.gzwi028,t0.gzwi011,t0.gzwi001,t0.gzwi017,t0.gzwi002, 
          t0.gzwi003,t0.gzwi008,t0.gzwi010,t0.gzwi004,t0.gzwi012,t0.gzwi005,t0.gzwi013,t0.gzwi006,t0.gzwi015, 
          t0.gzwi018,t0.gzwi009,t0.gzwi025,t1.oofa011 ,t2.gzzal003 ,t3.ooag011 ,t4.ooefl003 ,t5.oofa011 ", 
 
                  " FROM gzwi_t t0",
                  "  ",
                  "  LEFT JOIN gzwj_t ON gzwi001 = gzwj001 ", "  ", 
                  #add-point:browser_fill段sql(gzwj_t1) name="browser_fill.join.gzwj_t1"
                  
                  #end add-point
 
 
                  " ", 
 
 
                                 " LEFT JOIN oofa_t t1 ON t1.oofaent="||g_enterprise||" AND t1.oofa001=t0.gzwi028  ",
               " LEFT JOIN gzzal_t t2 ON t2.gzzal001=t0.gzwi008 AND t2.gzzal002='"||g_lang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.gzwi005  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.gzwi006 AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oofa_t t5 ON t5.oofaent="||g_enterprise||" AND t5.oofa001=t0.gzwi007  ",
 
                  " WHERE  ",l_wc," AND ",l_wc2, cl_sql_add_filter("gzwi_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.gzwistus,t0.gzwi028,t0.gzwi011,t0.gzwi001,t0.gzwi017,t0.gzwi002, 
          t0.gzwi003,t0.gzwi008,t0.gzwi010,t0.gzwi004,t0.gzwi012,t0.gzwi005,t0.gzwi013,t0.gzwi006,t0.gzwi015, 
          t0.gzwi018,t0.gzwi009,t0.gzwi025,t1.oofa011 ,t2.gzzal003 ,t3.ooag011 ,t4.ooefl003 ,t5.oofa011 ", 
 
                  " FROM gzwi_t t0",
                  "  ",
                                 " LEFT JOIN oofa_t t1 ON t1.oofaent="||g_enterprise||" AND t1.oofa001=t0.gzwi028  ",
               " LEFT JOIN gzzal_t t2 ON t2.gzzal001=t0.gzwi008 AND t2.gzzal002='"||g_lang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.gzwi005  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.gzwi006 AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN oofa_t t5 ON t5.oofaent="||g_enterprise||" AND t5.oofa001=t0.gzwi007  ",
 
                  " WHERE  ",l_wc, cl_sql_add_filter("gzwi_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   IF g_gzwi028_show THEN   #手動維護
      LET l_gzwc_t ="gzwc_t"
      LET g_sql = " SELECT DISTINCT t0.gzwistus,t0.gzwi028,t0.gzwi011,t0.gzwi001,t0.gzwi017,t0.gzwi002, ",
          " t0.gzwi003,t0.gzwi008,t0.gzwi010,t0.gzwi004,t0.gzwi012,t0.gzwi005,t0.gzwi013,t0.gzwi006,t0.gzwi015, ",
          #" t0.gzwi018,t0.gzwi009,t0.gzwi025,t1.oofa011 ,t2.gzzal003 ,t3.ooag011 ,t4.ooefl003 ,t5.oofa011 ", 
          " t0.gzwi018,t0.gzwi009,t0.gzwi025,t1.gzwc002 ,t2.gzzal003 ,t3.ooag011 ,t4.ooefl003 ,t5.oofa011 ", 
                  " FROM gzwi_t t0",
                  " LEFT JOIN gzwj_t ON gzwi001 = gzwj001",
                  #" LEFT JOIN oofa_t t1 ON t1.oofaent='"||g_enterprise||"' AND t1.oofa001=t0.gzwi028  ",
                  " LEFT JOIN ",l_gzwc_t CLIPPED," t1 ON t1.gzwc001=t0.gzwi028",
                  " LEFT JOIN gzzal_t t2 ON t2.gzzal001=t0.gzwi008 AND t2.gzzal002='"||g_lang||"' ",
                  " LEFT JOIN ooag_t t3 ON t3.ooagent='"||g_enterprise||"' AND t3.ooag001=t0.gzwi005  ",
                  " LEFT JOIN ooefl_t t4 ON t4.ooeflent='"||g_enterprise||"' AND t4.ooefl001=t0.gzwi006 AND t4.ooefl002='"||g_dlang||"' ",
                  " LEFT JOIN oofa_t t5 ON t5.oofaent='"||g_enterprise||"' AND t5.oofa001=t0.gzwi007  ",
    
                  " WHERE  ",l_wc," AND ",l_wc2, cl_sql_add_filter("gzwi_t")
   END IF
   #end add-point
   LET g_sql = g_sql, " ORDER BY gzwi001 ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"gzwi_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_gzwi028,g_browser[g_cnt].b_gzwi011, 
          g_browser[g_cnt].b_gzwi001,g_browser[g_cnt].b_gzwi017,g_browser[g_cnt].b_gzwi002,g_browser[g_cnt].b_gzwi003, 
          g_browser[g_cnt].b_gzwi008,g_browser[g_cnt].b_gzwi010,g_browser[g_cnt].b_gzwi004,g_browser[g_cnt].b_gzwi012, 
          g_browser[g_cnt].b_gzwi005,g_browser[g_cnt].b_gzwi013,g_browser[g_cnt].b_gzwi006,g_browser[g_cnt].b_gzwi015, 
          g_browser[g_cnt].b_gzwi018,g_browser[g_cnt].b_gzwi009,g_browser[g_cnt].b_gzwi025,g_browser[g_cnt].b_gzwi028_desc, 
          g_browser[g_cnt].b_gzwi008_desc,g_browser[g_cnt].b_gzwi005_desc,g_browser[g_cnt].b_gzwi006_desc, 
          g_browser[g_cnt].b_gzwi007_desc
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
         CALL azzi932_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/inactive.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/active.png"
         
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
   
   IF cl_null(g_browser[g_cnt].b_gzwi001) THEN
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
 
{<section id="azzi932.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION azzi932_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
   
   #end add-point
   
   LET g_gzwi_m.gzwi001 = g_browser[g_current_idx].b_gzwi001   
 
   EXECUTE azzi932_master_referesh USING g_gzwi_m.gzwi001 INTO g_gzwi_m.gzwi001,g_gzwi_m.gzwi002,g_gzwi_m.gzwi003, 
       g_gzwi_m.gzwi008,g_gzwi_m.gzwi010,g_gzwi_m.gzwi017,g_gzwi_m.gzwi004,g_gzwi_m.gzwi005,g_gzwi_m.gzwi013, 
       g_gzwi_m.gzwi006,g_gzwi_m.gzwi015,g_gzwi_m.gzwi016,g_gzwi_m.gzwi018,g_gzwi_m.gzwi007,g_gzwi_m.gzwi011, 
       g_gzwi_m.gzwi012,g_gzwi_m.gzwi027,g_gzwi_m.gzwi014,g_gzwi_m.gzwi009,g_gzwi_m.gzwi026,g_gzwi_m.gzwi019, 
       g_gzwi_m.gzwi020,g_gzwi_m.gzwi021,g_gzwi_m.gzwi022,g_gzwi_m.gzwi023,g_gzwi_m.gzwi024,g_gzwi_m.gzwi025, 
       g_gzwi_m.gzwi028,g_gzwi_m.gzwistus,g_gzwi_m.gzwiownid,g_gzwi_m.gzwiowndp,g_gzwi_m.gzwicrtid,g_gzwi_m.gzwicrtdp, 
       g_gzwi_m.gzwicrtdt,g_gzwi_m.gzwimodid,g_gzwi_m.gzwimoddt,g_gzwi_m.gzwi008_desc,g_gzwi_m.gzwi017_desc, 
       g_gzwi_m.gzwi005_desc,g_gzwi_m.gzwi006_desc,g_gzwi_m.gzwi007_desc,g_gzwi_m.gzwi028_desc,g_gzwi_m.gzwiownid_desc, 
       g_gzwi_m.gzwiowndp_desc,g_gzwi_m.gzwicrtid_desc,g_gzwi_m.gzwicrtdp_desc,g_gzwi_m.gzwimodid_desc 
 
   
   CALL azzi932_gzwi_t_mask()
   CALL azzi932_show()
      
END FUNCTION
 
{</section>}
 
{<section id="azzi932.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION azzi932_ui_detailshow()
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
 
{<section id="azzi932.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION azzi932_ui_browser_refresh()
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
      IF g_browser[l_i].b_gzwi001 = g_gzwi_m.gzwi001 
 
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
 
{<section id="azzi932.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION azzi932_construct()
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
   INITIALIZE g_gzwi_m.* TO NULL
   CALL g_gzwj_d.clear()        
 
   
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
      CONSTRUCT BY NAME g_wc ON gzwi001,gzwi002,gzwi003,gzwi008,gzwi010,gzwi017,gzwi004,gzwi005,gzwi013, 
          gzwi006,gzwi015,gzwi018,gzwi011,gzwi012,gzwi027,gzwi014,gzwi009,gzwi026,gzwi019,gzwi020,gzwi021, 
          gzwi022,gzwi023,gzwi024,gzwi025,gzwi028,gzwistus,gzwiownid,gzwiowndp,gzwicrtid,gzwicrtdp,gzwicrtdt, 
          gzwimodid,gzwimoddt
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<gzwicrtdt>>----
         AFTER FIELD gzwicrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<gzwimoddt>>----
         AFTER FIELD gzwimoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<gzwicnfdt>>----
         
         #----<<gzwipstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwi001
            #add-point:BEFORE FIELD gzwi001 name="construct.b.gzwi001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwi001
            
            #add-point:AFTER FIELD gzwi001 name="construct.a.gzwi001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gzwi001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwi001
            #add-point:ON ACTION controlp INFIELD gzwi001 name="construct.c.gzwi001"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwi002
            #add-point:BEFORE FIELD gzwi002 name="construct.b.gzwi002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwi002
            
            #add-point:AFTER FIELD gzwi002 name="construct.a.gzwi002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gzwi002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwi002
            #add-point:ON ACTION controlp INFIELD gzwi002 name="construct.c.gzwi002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwi003
            #add-point:BEFORE FIELD gzwi003 name="construct.b.gzwi003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwi003
            
            #add-point:AFTER FIELD gzwi003 name="construct.a.gzwi003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gzwi003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwi003
            #add-point:ON ACTION controlp INFIELD gzwi003 name="construct.c.gzwi003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.gzwi008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwi008
            #add-point:ON ACTION controlp INFIELD gzwi008 name="construct.c.gzwi008"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_gzzz001_1()                           #呼叫開窗
            CALL cl_get_progname(g_gzwi_m.gzwi008,g_lang,"1") RETURNING g_gzwi_inc.gzwi008_desc   #作業程式名稱
            DISPLAY g_qryparam.return1 TO gzwi008  #顯示到畫面上
            NEXT FIELD gzwi008                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwi008
            #add-point:BEFORE FIELD gzwi008 name="construct.b.gzwi008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwi008
            
            #add-point:AFTER FIELD gzwi008 name="construct.a.gzwi008"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwi010
            #add-point:BEFORE FIELD gzwi010 name="construct.b.gzwi010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwi010
            
            #add-point:AFTER FIELD gzwi010 name="construct.a.gzwi010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gzwi010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwi010
            #add-point:ON ACTION controlp INFIELD gzwi010 name="construct.c.gzwi010"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwi017
            #add-point:BEFORE FIELD gzwi017 name="construct.b.gzwi017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwi017
            
            #add-point:AFTER FIELD gzwi017 name="construct.a.gzwi017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gzwi017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwi017
            #add-point:ON ACTION controlp INFIELD gzwi017 name="construct.c.gzwi017"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwi004
            #add-point:BEFORE FIELD gzwi004 name="construct.b.gzwi004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwi004
            
            #add-point:AFTER FIELD gzwi004 name="construct.a.gzwi004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gzwi004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwi004
            #add-point:ON ACTION controlp INFIELD gzwi004 name="construct.c.gzwi004"
            
            #END add-point
 
 
         #Ctrlp:construct.c.gzwi005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwi005
            #add-point:ON ACTION controlp INFIELD gzwi005 name="construct.c.gzwi005"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗

            DISPLAY g_qryparam.return1 TO gzwi005  #顯示到畫面上
            NEXT FIELD gzwi005                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwi005
            #add-point:BEFORE FIELD gzwi005 name="construct.b.gzwi005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwi005
            
            #add-point:AFTER FIELD gzwi005 name="construct.a.gzwi005"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwi013
            #add-point:BEFORE FIELD gzwi013 name="construct.b.gzwi013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwi013
            
            #add-point:AFTER FIELD gzwi013 name="construct.a.gzwi013"
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
            #END add-point
            
 
 
         #Ctrlp:construct.c.gzwi013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwi013
            #add-point:ON ACTION controlp INFIELD gzwi013 name="construct.c.gzwi013"
            
            #END add-point
 
 
         #Ctrlp:construct.c.gzwi006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwi006
            #add-point:ON ACTION controlp INFIELD gzwi006 name="construct.c.gzwi006"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001()                           #呼叫開窗

            DISPLAY g_qryparam.return1 TO gzwi006  #顯示到畫面上
            NEXT FIELD gzwi006                     #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwi006
            #add-point:BEFORE FIELD gzwi006 name="construct.b.gzwi006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwi006
            
            #add-point:AFTER FIELD gzwi006 name="construct.a.gzwi006"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwi015
            #add-point:BEFORE FIELD gzwi015 name="construct.b.gzwi015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwi015
            
            #add-point:AFTER FIELD gzwi015 name="construct.a.gzwi015"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gzwi015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwi015
            #add-point:ON ACTION controlp INFIELD gzwi015 name="construct.c.gzwi015"
            
            #END add-point
 
 
         #Ctrlp:construct.c.gzwi018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwi018
            #add-point:ON ACTION controlp INFIELD gzwi018 name="construct.c.gzwi018"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_gzwi_m.gzwi015 = DIALOG.getFieldBuffer("gzwi015")
            LET g_qryparam.arg1 = g_gzwi_m.gzwi015   #處理人員類型
            CALL q_oofa001_4()                       #呼叫開窗
            
            DISPLAY g_qryparam.return1 TO gzwi018    #顯示到畫面上
            NEXT FIELD gzwi018                       #返回原欄位
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwi018
            #add-point:BEFORE FIELD gzwi018 name="construct.b.gzwi018"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwi018
            
            #add-point:AFTER FIELD gzwi018 name="construct.a.gzwi018"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwi011
            #add-point:BEFORE FIELD gzwi011 name="construct.b.gzwi011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwi011
            
            #add-point:AFTER FIELD gzwi011 name="construct.a.gzwi011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gzwi011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwi011
            #add-point:ON ACTION controlp INFIELD gzwi011 name="construct.c.gzwi011"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwi012
            #add-point:BEFORE FIELD gzwi012 name="construct.b.gzwi012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwi012
            
            #add-point:AFTER FIELD gzwi012 name="construct.a.gzwi012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gzwi012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwi012
            #add-point:ON ACTION controlp INFIELD gzwi012 name="construct.c.gzwi012"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwi027
            #add-point:BEFORE FIELD gzwi027 name="construct.b.gzwi027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwi027
            
            #add-point:AFTER FIELD gzwi027 name="construct.a.gzwi027"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gzwi027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwi027
            #add-point:ON ACTION controlp INFIELD gzwi027 name="construct.c.gzwi027"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwi014
            #add-point:BEFORE FIELD gzwi014 name="construct.b.gzwi014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwi014
            
            #add-point:AFTER FIELD gzwi014 name="construct.a.gzwi014"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gzwi014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwi014
            #add-point:ON ACTION controlp INFIELD gzwi014 name="construct.c.gzwi014"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwi009
            #add-point:BEFORE FIELD gzwi009 name="construct.b.gzwi009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwi009
            
            #add-point:AFTER FIELD gzwi009 name="construct.a.gzwi009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gzwi009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwi009
            #add-point:ON ACTION controlp INFIELD gzwi009 name="construct.c.gzwi009"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwi026
            #add-point:BEFORE FIELD gzwi026 name="construct.b.gzwi026"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwi026
            
            #add-point:AFTER FIELD gzwi026 name="construct.a.gzwi026"
            #最近同步時間
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
            #END add-point
            
 
 
         #Ctrlp:construct.c.gzwi026
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwi026
            #add-point:ON ACTION controlp INFIELD gzwi026 name="construct.c.gzwi026"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwi019
            #add-point:BEFORE FIELD gzwi019 name="construct.b.gzwi019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwi019
            
            #add-point:AFTER FIELD gzwi019 name="construct.a.gzwi019"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gzwi019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwi019
            #add-point:ON ACTION controlp INFIELD gzwi019 name="construct.c.gzwi019"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwi020
            #add-point:BEFORE FIELD gzwi020 name="construct.b.gzwi020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwi020
            
            #add-point:AFTER FIELD gzwi020 name="construct.a.gzwi020"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gzwi020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwi020
            #add-point:ON ACTION controlp INFIELD gzwi020 name="construct.c.gzwi020"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwi021
            #add-point:BEFORE FIELD gzwi021 name="construct.b.gzwi021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwi021
            
            #add-point:AFTER FIELD gzwi021 name="construct.a.gzwi021"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gzwi021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwi021
            #add-point:ON ACTION controlp INFIELD gzwi021 name="construct.c.gzwi021"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwi022
            #add-point:BEFORE FIELD gzwi022 name="construct.b.gzwi022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwi022
            
            #add-point:AFTER FIELD gzwi022 name="construct.a.gzwi022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gzwi022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwi022
            #add-point:ON ACTION controlp INFIELD gzwi022 name="construct.c.gzwi022"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwi023
            #add-point:BEFORE FIELD gzwi023 name="construct.b.gzwi023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwi023
            
            #add-point:AFTER FIELD gzwi023 name="construct.a.gzwi023"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gzwi023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwi023
            #add-point:ON ACTION controlp INFIELD gzwi023 name="construct.c.gzwi023"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwi024
            #add-point:BEFORE FIELD gzwi024 name="construct.b.gzwi024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwi024
            
            #add-point:AFTER FIELD gzwi024 name="construct.a.gzwi024"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gzwi024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwi024
            #add-point:ON ACTION controlp INFIELD gzwi024 name="construct.c.gzwi024"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwi025
            #add-point:BEFORE FIELD gzwi025 name="construct.b.gzwi025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwi025
            
            #add-point:AFTER FIELD gzwi025 name="construct.a.gzwi025"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gzwi025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwi025
            #add-point:ON ACTION controlp INFIELD gzwi025 name="construct.c.gzwi025"
            
            #END add-point
 
 
         #Ctrlp:construct.c.gzwi028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwi028
            #add-point:ON ACTION controlp INFIELD gzwi028 name="construct.c.gzwi028"
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL cl_helps932_q_gzwi028()           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzwi028  #顯示到畫面上
            NEXT FIELD gzwi028                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwi028
            #add-point:BEFORE FIELD gzwi028 name="construct.b.gzwi028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwi028
            
            #add-point:AFTER FIELD gzwi028 name="construct.a.gzwi028"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwistus
            #add-point:BEFORE FIELD gzwistus name="construct.b.gzwistus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwistus
            
            #add-point:AFTER FIELD gzwistus name="construct.a.gzwistus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gzwistus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwistus
            #add-point:ON ACTION controlp INFIELD gzwistus name="construct.c.gzwistus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.gzwiownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwiownid
            #add-point:ON ACTION controlp INFIELD gzwiownid name="construct.c.gzwiownid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            
            DISPLAY g_qryparam.return1 TO gzwiownid  #顯示到畫面上
            NEXT FIELD gzwiownid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwiownid
            #add-point:BEFORE FIELD gzwiownid name="construct.b.gzwiownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwiownid
            
            #add-point:AFTER FIELD gzwiownid name="construct.a.gzwiownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gzwiowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwiowndp
            #add-point:ON ACTION controlp INFIELD gzwiowndp name="construct.c.gzwiowndp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                                #呼叫開窗

            DISPLAY g_qryparam.return1 TO gzwiowndp  #顯示到畫面上
            NEXT FIELD gzwiowndp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwiowndp
            #add-point:BEFORE FIELD gzwiowndp name="construct.b.gzwiowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwiowndp
            
            #add-point:AFTER FIELD gzwiowndp name="construct.a.gzwiowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gzwicrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwicrtid
            #add-point:ON ACTION controlp INFIELD gzwicrtid name="construct.c.gzwicrtid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗

            DISPLAY g_qryparam.return1 TO gzwicrtid  #顯示到畫面上
            NEXT FIELD gzwicrtid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwicrtid
            #add-point:BEFORE FIELD gzwicrtid name="construct.b.gzwicrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwicrtid
            
            #add-point:AFTER FIELD gzwicrtid name="construct.a.gzwicrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.gzwicrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwicrtdp
            #add-point:ON ACTION controlp INFIELD gzwicrtdp name="construct.c.gzwicrtdp"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                                #呼叫開窗

            DISPLAY g_qryparam.return1 TO gzwicrtdp  #顯示到畫面上
            NEXT FIELD gzwicrtdp                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwicrtdp
            #add-point:BEFORE FIELD gzwicrtdp name="construct.b.gzwicrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwicrtdp
            
            #add-point:AFTER FIELD gzwicrtdp name="construct.a.gzwicrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwicrtdt
            #add-point:BEFORE FIELD gzwicrtdt name="construct.b.gzwicrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.gzwimodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwimodid
            #add-point:ON ACTION controlp INFIELD gzwimodid name="construct.c.gzwimodid"
            #此段落由子樣板a08產生
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗

            DISPLAY g_qryparam.return1 TO gzwimodid  #顯示到畫面上
            NEXT FIELD gzwimodid                     #返回原欄位
    


            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwimodid
            #add-point:BEFORE FIELD gzwimodid name="construct.b.gzwimodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwimodid
            
            #add-point:AFTER FIELD gzwimodid name="construct.a.gzwimodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwimoddt
            #add-point:BEFORE FIELD gzwimoddt name="construct.b.gzwimoddt"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON gzwj008,gzwj002,gzwj004,gzwj005,fileimg,gzwjcrtid,gzwjmodid,gzwjcrtdp, 
          gzwjmoddt,gzwjcrtdt
           FROM s_detail1[1].gzwj008,s_detail1[1].gzwj002,s_detail1[1].gzwj004,s_detail1[1].gzwj005, 
               s_detail1[1].fileimg,s_detail1[1].gzwjcrtid,s_detail1[1].gzwjmodid,s_detail1[1].gzwjcrtdp, 
               s_detail1[1].gzwjmoddt,s_detail1[1].gzwjcrtdt
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<gzwjcrtdt>>----
         AFTER FIELD gzwjcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<gzwjmoddt>>----
         AFTER FIELD gzwjmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<gzwjcnfdt>>----
         
         #----<<gzwjpstdt>>----
 
 
 
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwj008
            #add-point:BEFORE FIELD gzwj008 name="construct.b.page1.gzwj008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwj008
            
            #add-point:AFTER FIELD gzwj008 name="construct.a.page1.gzwj008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzwj008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwj008
            #add-point:ON ACTION controlp INFIELD gzwj008 name="construct.c.page1.gzwj008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwj002
            #add-point:BEFORE FIELD gzwj002 name="construct.b.page1.gzwj002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwj002
            
            #add-point:AFTER FIELD gzwj002 name="construct.a.page1.gzwj002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzwj002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwj002
            #add-point:ON ACTION controlp INFIELD gzwj002 name="construct.c.page1.gzwj002"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwj004
            #add-point:BEFORE FIELD gzwj004 name="construct.b.page1.gzwj004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwj004
            
            #add-point:AFTER FIELD gzwj004 name="construct.a.page1.gzwj004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzwj004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwj004
            #add-point:ON ACTION controlp INFIELD gzwj004 name="construct.c.page1.gzwj004"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwj005
            #add-point:BEFORE FIELD gzwj005 name="construct.b.page1.gzwj005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwj005
            
            #add-point:AFTER FIELD gzwj005 name="construct.a.page1.gzwj005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzwj005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwj005
            #add-point:ON ACTION controlp INFIELD gzwj005 name="construct.c.page1.gzwj005"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fileimg
            #add-point:BEFORE FIELD fileimg name="construct.b.page1.fileimg"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fileimg
            
            #add-point:AFTER FIELD fileimg name="construct.a.page1.fileimg"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.fileimg
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fileimg
            #add-point:ON ACTION controlp INFIELD fileimg name="construct.c.page1.fileimg"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.gzwjcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwjcrtid
            #add-point:ON ACTION controlp INFIELD gzwjcrtid name="construct.c.page1.gzwjcrtid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzwjcrtid  #顯示到畫面上
            NEXT FIELD gzwjcrtid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwjcrtid
            #add-point:BEFORE FIELD gzwjcrtid name="construct.b.page1.gzwjcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwjcrtid
            
            #add-point:AFTER FIELD gzwjcrtid name="construct.a.page1.gzwjcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzwjmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwjmodid
            #add-point:ON ACTION controlp INFIELD gzwjmodid name="construct.c.page1.gzwjmodid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzwjmodid  #顯示到畫面上
            NEXT FIELD gzwjmodid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwjmodid
            #add-point:BEFORE FIELD gzwjmodid name="construct.b.page1.gzwjmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwjmodid
            
            #add-point:AFTER FIELD gzwjmodid name="construct.a.page1.gzwjmodid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.gzwjcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwjcrtdp
            #add-point:ON ACTION controlp INFIELD gzwjcrtdp name="construct.c.page1.gzwjcrtdp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzwjcrtdp  #顯示到畫面上
            NEXT FIELD gzwjcrtdp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwjcrtdp
            #add-point:BEFORE FIELD gzwjcrtdp name="construct.b.page1.gzwjcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwjcrtdp
            
            #add-point:AFTER FIELD gzwjcrtdp name="construct.a.page1.gzwjcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwjmoddt
            #add-point:BEFORE FIELD gzwjmoddt name="construct.b.page1.gzwjmoddt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwjcrtdt
            #add-point:BEFORE FIELD gzwjcrtdt name="construct.b.page1.gzwjcrtdt"
            
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
                  WHEN la_wc[li_idx].tableid = "gzwi_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "gzwj_t" 
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
 
{<section id="azzi932.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION azzi932_filter()
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
      CONSTRUCT g_wc_filter ON gzwi028,gzwi011,gzwi001,gzwi017,gzwi002,gzwi003,gzwi008,gzwi010,gzwi004, 
          gzwi012,gzwi005,gzwi013,gzwi006,gzwi015,gzwi018,gzwi009,gzwi025
                          FROM s_browse[1].b_gzwi028,s_browse[1].b_gzwi011,s_browse[1].b_gzwi001,s_browse[1].b_gzwi017, 
                              s_browse[1].b_gzwi002,s_browse[1].b_gzwi003,s_browse[1].b_gzwi008,s_browse[1].b_gzwi010, 
                              s_browse[1].b_gzwi004,s_browse[1].b_gzwi012,s_browse[1].b_gzwi005,s_browse[1].b_gzwi013, 
                              s_browse[1].b_gzwi006,s_browse[1].b_gzwi015,s_browse[1].b_gzwi018,s_browse[1].b_gzwi009, 
                              s_browse[1].b_gzwi025
 
         BEFORE CONSTRUCT
               DISPLAY azzi932_filter_parser('gzwi028') TO s_browse[1].b_gzwi028
            DISPLAY azzi932_filter_parser('gzwi011') TO s_browse[1].b_gzwi011
            DISPLAY azzi932_filter_parser('gzwi001') TO s_browse[1].b_gzwi001
            DISPLAY azzi932_filter_parser('gzwi017') TO s_browse[1].b_gzwi017
            DISPLAY azzi932_filter_parser('gzwi002') TO s_browse[1].b_gzwi002
            DISPLAY azzi932_filter_parser('gzwi003') TO s_browse[1].b_gzwi003
            DISPLAY azzi932_filter_parser('gzwi008') TO s_browse[1].b_gzwi008
            DISPLAY azzi932_filter_parser('gzwi010') TO s_browse[1].b_gzwi010
            DISPLAY azzi932_filter_parser('gzwi004') TO s_browse[1].b_gzwi004
            DISPLAY azzi932_filter_parser('gzwi012') TO s_browse[1].b_gzwi012
            DISPLAY azzi932_filter_parser('gzwi005') TO s_browse[1].b_gzwi005
            DISPLAY azzi932_filter_parser('gzwi013') TO s_browse[1].b_gzwi013
            DISPLAY azzi932_filter_parser('gzwi006') TO s_browse[1].b_gzwi006
            DISPLAY azzi932_filter_parser('gzwi015') TO s_browse[1].b_gzwi015
            DISPLAY azzi932_filter_parser('gzwi018') TO s_browse[1].b_gzwi018
            DISPLAY azzi932_filter_parser('gzwi009') TO s_browse[1].b_gzwi009
            DISPLAY azzi932_filter_parser('gzwi025') TO s_browse[1].b_gzwi025
      
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
 
      CALL azzi932_filter_show('gzwi028')
   CALL azzi932_filter_show('gzwi011')
   CALL azzi932_filter_show('gzwi001')
   CALL azzi932_filter_show('gzwi017')
   CALL azzi932_filter_show('gzwi002')
   CALL azzi932_filter_show('gzwi003')
   CALL azzi932_filter_show('gzwi008')
   CALL azzi932_filter_show('gzwi010')
   CALL azzi932_filter_show('gzwi004')
   CALL azzi932_filter_show('gzwi012')
   CALL azzi932_filter_show('gzwi005')
   CALL azzi932_filter_show('gzwi013')
   CALL azzi932_filter_show('gzwi006')
   CALL azzi932_filter_show('gzwi015')
   CALL azzi932_filter_show('gzwi018')
   CALL azzi932_filter_show('gzwi009')
   CALL azzi932_filter_show('gzwi025')
 
END FUNCTION
 
{</section>}
 
{<section id="azzi932.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION azzi932_filter_parser(ps_field)
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
 
{<section id="azzi932.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION azzi932_filter_show(ps_field)
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
   LET ls_condition = azzi932_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="azzi932.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION azzi932_query()
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
   CALL g_gzwj_d.clear()
 
   
   #add-point:query段other name="query.other"
   
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL azzi932_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL azzi932_browser_fill("")
      CALL azzi932_fetch("")
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
      CALL azzi932_filter_show('gzwi028')
   CALL azzi932_filter_show('gzwi011')
   CALL azzi932_filter_show('gzwi001')
   CALL azzi932_filter_show('gzwi017')
   CALL azzi932_filter_show('gzwi002')
   CALL azzi932_filter_show('gzwi003')
   CALL azzi932_filter_show('gzwi008')
   CALL azzi932_filter_show('gzwi010')
   CALL azzi932_filter_show('gzwi004')
   CALL azzi932_filter_show('gzwi012')
   CALL azzi932_filter_show('gzwi005')
   CALL azzi932_filter_show('gzwi013')
   CALL azzi932_filter_show('gzwi006')
   CALL azzi932_filter_show('gzwi015')
   CALL azzi932_filter_show('gzwi018')
   CALL azzi932_filter_show('gzwi009')
   CALL azzi932_filter_show('gzwi025')
   CALL azzi932_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL azzi932_fetch("F") 
      #顯示單身筆數
      CALL azzi932_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="azzi932.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION azzi932_fetch(p_flag)
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point    
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="fetch.pre_function"
   IF g_browser_cnt = 0 THEN
      RETURN
   END IF
   
   IF (p_flag <> 'F') AND (p_flag <> 'L') AND (p_flag <> 'P') AND (p_flag <> 'N') AND (p_flag <> '/') THEN
       LET g_jump = p_flag
       IF g_jump > 0 AND g_jump <= g_browser.getLength() THEN
          LET g_current_idx = g_jump
       END IF
   END IF
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
   
   LET g_gzwi_m.gzwi001 = g_browser[g_current_idx].b_gzwi001
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE azzi932_master_referesh USING g_gzwi_m.gzwi001 INTO g_gzwi_m.gzwi001,g_gzwi_m.gzwi002,g_gzwi_m.gzwi003, 
       g_gzwi_m.gzwi008,g_gzwi_m.gzwi010,g_gzwi_m.gzwi017,g_gzwi_m.gzwi004,g_gzwi_m.gzwi005,g_gzwi_m.gzwi013, 
       g_gzwi_m.gzwi006,g_gzwi_m.gzwi015,g_gzwi_m.gzwi016,g_gzwi_m.gzwi018,g_gzwi_m.gzwi007,g_gzwi_m.gzwi011, 
       g_gzwi_m.gzwi012,g_gzwi_m.gzwi027,g_gzwi_m.gzwi014,g_gzwi_m.gzwi009,g_gzwi_m.gzwi026,g_gzwi_m.gzwi019, 
       g_gzwi_m.gzwi020,g_gzwi_m.gzwi021,g_gzwi_m.gzwi022,g_gzwi_m.gzwi023,g_gzwi_m.gzwi024,g_gzwi_m.gzwi025, 
       g_gzwi_m.gzwi028,g_gzwi_m.gzwistus,g_gzwi_m.gzwiownid,g_gzwi_m.gzwiowndp,g_gzwi_m.gzwicrtid,g_gzwi_m.gzwicrtdp, 
       g_gzwi_m.gzwicrtdt,g_gzwi_m.gzwimodid,g_gzwi_m.gzwimoddt,g_gzwi_m.gzwi008_desc,g_gzwi_m.gzwi017_desc, 
       g_gzwi_m.gzwi005_desc,g_gzwi_m.gzwi006_desc,g_gzwi_m.gzwi007_desc,g_gzwi_m.gzwi028_desc,g_gzwi_m.gzwiownid_desc, 
       g_gzwi_m.gzwiowndp_desc,g_gzwi_m.gzwicrtid_desc,g_gzwi_m.gzwicrtdp_desc,g_gzwi_m.gzwimodid_desc 
 
   
   #遮罩相關處理
   LET g_gzwi_m_mask_o.* =  g_gzwi_m.*
   CALL azzi932_gzwi_t_mask()
   LET g_gzwi_m_mask_n.* =  g_gzwi_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL azzi932_set_act_visible()   
   CALL azzi932_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
 
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   
   #end add-point
   
   #保存單頭舊值
   LET g_gzwi_m_t.* = g_gzwi_m.*
   LET g_gzwi_m_o.* = g_gzwi_m.*
   
   LET g_data_owner = g_gzwi_m.gzwiownid      
   LET g_data_dept  = g_gzwi_m.gzwiowndp
   
   #重新顯示   
   CALL azzi932_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="azzi932.insert" >}
#+ 資料新增
PRIVATE FUNCTION azzi932_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_gzwj_d.clear()   
 
 
   INITIALIZE g_gzwi_m.* TO NULL             #DEFAULT 設定
   
   LET g_gzwi001_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_gzwi_m.gzwiownid = g_user
      LET g_gzwi_m.gzwiowndp = g_dept
      LET g_gzwi_m.gzwicrtid = g_user
      LET g_gzwi_m.gzwicrtdp = g_dept 
      LET g_gzwi_m.gzwicrtdt = cl_get_current()
      LET g_gzwi_m.gzwimodid = g_user
      LET g_gzwi_m.gzwimoddt = cl_get_current()
      LET g_gzwi_m.gzwistus = 'Y'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_gzwi_m.gzwi010 = "N"
      LET g_gzwi_m.gzwi011 = "1"
 
  
      #add-point:單頭預設值 name="insert.default"
      
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_gzwi_m_t.* = g_gzwi_m.*
      LET g_gzwi_m_o.* = g_gzwi_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_gzwi_m.gzwistus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
    
      CALL azzi932_input("a")
      
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
         INITIALIZE g_gzwi_m.* TO NULL
         INITIALIZE g_gzwj_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL azzi932_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_gzwj_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL azzi932_set_act_visible()   
   CALL azzi932_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_gzwi001_t = g_gzwi_m.gzwi001
 
   
   #組合新增資料的條件
   LET g_add_browse = " ",
                      " gzwi001 = '", g_gzwi_m.gzwi001, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL azzi932_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE azzi932_cl
   
   CALL azzi932_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE azzi932_master_referesh USING g_gzwi_m.gzwi001 INTO g_gzwi_m.gzwi001,g_gzwi_m.gzwi002,g_gzwi_m.gzwi003, 
       g_gzwi_m.gzwi008,g_gzwi_m.gzwi010,g_gzwi_m.gzwi017,g_gzwi_m.gzwi004,g_gzwi_m.gzwi005,g_gzwi_m.gzwi013, 
       g_gzwi_m.gzwi006,g_gzwi_m.gzwi015,g_gzwi_m.gzwi016,g_gzwi_m.gzwi018,g_gzwi_m.gzwi007,g_gzwi_m.gzwi011, 
       g_gzwi_m.gzwi012,g_gzwi_m.gzwi027,g_gzwi_m.gzwi014,g_gzwi_m.gzwi009,g_gzwi_m.gzwi026,g_gzwi_m.gzwi019, 
       g_gzwi_m.gzwi020,g_gzwi_m.gzwi021,g_gzwi_m.gzwi022,g_gzwi_m.gzwi023,g_gzwi_m.gzwi024,g_gzwi_m.gzwi025, 
       g_gzwi_m.gzwi028,g_gzwi_m.gzwistus,g_gzwi_m.gzwiownid,g_gzwi_m.gzwiowndp,g_gzwi_m.gzwicrtid,g_gzwi_m.gzwicrtdp, 
       g_gzwi_m.gzwicrtdt,g_gzwi_m.gzwimodid,g_gzwi_m.gzwimoddt,g_gzwi_m.gzwi008_desc,g_gzwi_m.gzwi017_desc, 
       g_gzwi_m.gzwi005_desc,g_gzwi_m.gzwi006_desc,g_gzwi_m.gzwi007_desc,g_gzwi_m.gzwi028_desc,g_gzwi_m.gzwiownid_desc, 
       g_gzwi_m.gzwiowndp_desc,g_gzwi_m.gzwicrtid_desc,g_gzwi_m.gzwicrtdp_desc,g_gzwi_m.gzwimodid_desc 
 
   
   
   #遮罩相關處理
   LET g_gzwi_m_mask_o.* =  g_gzwi_m.*
   CALL azzi932_gzwi_t_mask()
   LET g_gzwi_m_mask_n.* =  g_gzwi_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_gzwi_m.gzwi001,g_gzwi_m.gzwi002,g_gzwi_m.gzwi003,g_gzwi_m.gzwi008,g_gzwi_m.gzwi008_desc, 
       g_gzwi_m.gzwi010,g_gzwi_m.gzwi017,g_gzwi_m.gzwi017_desc,g_gzwi_m.gzwi004,g_gzwi_m.gzwi005,g_gzwi_m.gzwi005_desc, 
       g_gzwi_m.gzwi013,g_gzwi_m.gzwi006,g_gzwi_m.gzwi006_desc,g_gzwi_m.gzwi015,g_gzwi_m.gzwi016,g_gzwi_m.gzwi018, 
       g_gzwi_m.gzwi007_desc,g_gzwi_m.gzwi007,g_gzwi_m.gzwi011,g_gzwi_m.gzwi012,g_gzwi_m.gzwi027,g_gzwi_m.gzwi014, 
       g_gzwi_m.gzwi009,g_gzwi_m.gzwi026,g_gzwi_m.gzwi019,g_gzwi_m.gzwi020,g_gzwi_m.gzwi021,g_gzwi_m.gzwi022, 
       g_gzwi_m.gzwi023,g_gzwi_m.gzwi024,g_gzwi_m.gzwi025,g_gzwi_m.gzwi028,g_gzwi_m.gzwi028_desc,g_gzwi_m.gzwistus, 
       g_gzwi_m.gzwiownid,g_gzwi_m.gzwiownid_desc,g_gzwi_m.gzwiowndp,g_gzwi_m.gzwiowndp_desc,g_gzwi_m.gzwicrtid, 
       g_gzwi_m.gzwicrtid_desc,g_gzwi_m.gzwicrtdp,g_gzwi_m.gzwicrtdp_desc,g_gzwi_m.gzwicrtdt,g_gzwi_m.gzwimodid, 
       g_gzwi_m.gzwimodid_desc,g_gzwi_m.gzwimoddt
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_gzwi_m.gzwiownid      
   LET g_data_dept  = g_gzwi_m.gzwiowndp
   
   #功能已完成,通報訊息中心
   CALL azzi932_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="azzi932.modify" >}
#+ 資料修改
PRIVATE FUNCTION azzi932_modify()
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
   LET g_gzwi_m_t.* = g_gzwi_m.*
   LET g_gzwi_m_o.* = g_gzwi_m.*
   
   IF g_gzwi_m.gzwi001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_gzwi001_t = g_gzwi_m.gzwi001
 
   CALL s_transaction_begin()
   
   OPEN azzi932_cl USING g_gzwi_m.gzwi001
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN azzi932_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE azzi932_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE azzi932_master_referesh USING g_gzwi_m.gzwi001 INTO g_gzwi_m.gzwi001,g_gzwi_m.gzwi002,g_gzwi_m.gzwi003, 
       g_gzwi_m.gzwi008,g_gzwi_m.gzwi010,g_gzwi_m.gzwi017,g_gzwi_m.gzwi004,g_gzwi_m.gzwi005,g_gzwi_m.gzwi013, 
       g_gzwi_m.gzwi006,g_gzwi_m.gzwi015,g_gzwi_m.gzwi016,g_gzwi_m.gzwi018,g_gzwi_m.gzwi007,g_gzwi_m.gzwi011, 
       g_gzwi_m.gzwi012,g_gzwi_m.gzwi027,g_gzwi_m.gzwi014,g_gzwi_m.gzwi009,g_gzwi_m.gzwi026,g_gzwi_m.gzwi019, 
       g_gzwi_m.gzwi020,g_gzwi_m.gzwi021,g_gzwi_m.gzwi022,g_gzwi_m.gzwi023,g_gzwi_m.gzwi024,g_gzwi_m.gzwi025, 
       g_gzwi_m.gzwi028,g_gzwi_m.gzwistus,g_gzwi_m.gzwiownid,g_gzwi_m.gzwiowndp,g_gzwi_m.gzwicrtid,g_gzwi_m.gzwicrtdp, 
       g_gzwi_m.gzwicrtdt,g_gzwi_m.gzwimodid,g_gzwi_m.gzwimoddt,g_gzwi_m.gzwi008_desc,g_gzwi_m.gzwi017_desc, 
       g_gzwi_m.gzwi005_desc,g_gzwi_m.gzwi006_desc,g_gzwi_m.gzwi007_desc,g_gzwi_m.gzwi028_desc,g_gzwi_m.gzwiownid_desc, 
       g_gzwi_m.gzwiowndp_desc,g_gzwi_m.gzwicrtid_desc,g_gzwi_m.gzwicrtdp_desc,g_gzwi_m.gzwimodid_desc 
 
   
   #檢查是否允許此動作
   IF NOT azzi932_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_gzwi_m_mask_o.* =  g_gzwi_m.*
   CALL azzi932_gzwi_t_mask()
   LET g_gzwi_m_mask_n.* =  g_gzwi_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
 
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
 
   
   CALL azzi932_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
 
    
   WHILE TRUE
      LET g_gzwi001_t = g_gzwi_m.gzwi001
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_gzwi_m.gzwimodid = g_user 
LET g_gzwi_m.gzwimoddt = cl_get_current()
LET g_gzwi_m.gzwimodid_desc = cl_get_username(g_gzwi_m.gzwimodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL azzi932_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      CALL azzi932_showcourse(g_gzwi_m.gzwi012,g_gzwi_m.gzwi027)   #161027-00047#1
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE gzwi_t SET (gzwimodid,gzwimoddt) = (g_gzwi_m.gzwimodid,g_gzwi_m.gzwimoddt)
          WHERE  gzwi001 = g_gzwi001_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_gzwi_m.* = g_gzwi_m_t.*
            CALL azzi932_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_gzwi_m.gzwi001 != g_gzwi_m_t.gzwi001
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE gzwj_t SET gzwj001 = g_gzwi_m.gzwi001
 
          WHERE  gzwj001 = g_gzwi_m_t.gzwi001
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "gzwj_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "gzwj_t:",SQLERRMESSAGE 
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
   CALL azzi932_set_act_visible()   
   CALL azzi932_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " ",
                      " gzwi001 = '", g_gzwi_m.gzwi001, "' "
 
   #填到對應位置
   CALL azzi932_browser_fill("")
 
   CLOSE azzi932_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL azzi932_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="azzi932.input" >}
#+ 資料輸入
PRIVATE FUNCTION azzi932_input(p_cmd)
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
   DEFINE li_stat                LIKE type_t.num5
   DEFINE l_change_mail          BOOLEAN           #是否因資料改變而需要寄送mail
   DEFINE l_str                  STRING
   DEFINE l_chk                  BOOLEAN
   DEFINE l_diffold              type_g_gzwo_inc   #原始資料
   DEFINE l_diffnew              type_g_gzwo_inc   #異動後
   DEFINE l_reopen               BOOLEAN           #是否結案重啟後重新開立案件   #160606-00027#1
   DEFINE l_syncold              DYNAMIC ARRAY OF type_g_gzwo_inc              #160805-00001#1
   DEFINE l_gzwo_m DYNAMIC ARRAY OF RECORD         #接收反映鼎新後的資料         #160805-00001#1   
          l_chk      BOOLEAN,
          gzwo001    LIKE gzwo_t.gzwo001,
          gzwo009    LIKE gzwo_t.gzwo009,
          gzwo014    LIKE gzwo_t.gzwo014,
          gzwomodid  LIKE gzwo_t.gzwomodid,
          gzwomoddt  LIKE gzwo_t.gzwomoddt
      END RECORD
   DEFINE l_err_chk      BOOLEAN                    #161006-00007#1
   DEFINE l_err_rtn      STRING                     #161006-00007#1
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
   DISPLAY BY NAME g_gzwi_m.gzwi001,g_gzwi_m.gzwi002,g_gzwi_m.gzwi003,g_gzwi_m.gzwi008,g_gzwi_m.gzwi008_desc, 
       g_gzwi_m.gzwi010,g_gzwi_m.gzwi017,g_gzwi_m.gzwi017_desc,g_gzwi_m.gzwi004,g_gzwi_m.gzwi005,g_gzwi_m.gzwi005_desc, 
       g_gzwi_m.gzwi013,g_gzwi_m.gzwi006,g_gzwi_m.gzwi006_desc,g_gzwi_m.gzwi015,g_gzwi_m.gzwi016,g_gzwi_m.gzwi018, 
       g_gzwi_m.gzwi007_desc,g_gzwi_m.gzwi007,g_gzwi_m.gzwi011,g_gzwi_m.gzwi012,g_gzwi_m.gzwi027,g_gzwi_m.gzwi014, 
       g_gzwi_m.gzwi009,g_gzwi_m.gzwi026,g_gzwi_m.gzwi019,g_gzwi_m.gzwi020,g_gzwi_m.gzwi021,g_gzwi_m.gzwi022, 
       g_gzwi_m.gzwi023,g_gzwi_m.gzwi024,g_gzwi_m.gzwi025,g_gzwi_m.gzwi028,g_gzwi_m.gzwi028_desc,g_gzwi_m.gzwistus, 
       g_gzwi_m.gzwiownid,g_gzwi_m.gzwiownid_desc,g_gzwi_m.gzwiowndp,g_gzwi_m.gzwiowndp_desc,g_gzwi_m.gzwicrtid, 
       g_gzwi_m.gzwicrtid_desc,g_gzwi_m.gzwicrtdp,g_gzwi_m.gzwicrtdp_desc,g_gzwi_m.gzwicrtdt,g_gzwi_m.gzwimodid, 
       g_gzwi_m.gzwimodid_desc,g_gzwi_m.gzwimoddt
   
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
   LET g_forupd_sql = "SELECT gzwj008,gzwj002,gzwj004,gzwj005,gzwj007,gzwjcrtid,gzwjmodid,gzwjcrtdp, 
       gzwjmoddt,gzwjcrtdt FROM gzwj_t WHERE gzwj001=? AND gzwj002=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE azzi932_bcl CURSOR FROM g_forupd_sql
   
 
   
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL azzi932_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL azzi932_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_gzwi_m.gzwi001,g_gzwi_m.gzwi002,g_gzwi_m.gzwi003,g_gzwi_m.gzwi008,g_gzwi_m.gzwi010, 
       g_gzwi_m.gzwi004,g_gzwi_m.gzwi005,g_gzwi_m.gzwi013,g_gzwi_m.gzwi006,g_gzwi_m.gzwi015,g_gzwi_m.gzwi018, 
       g_gzwi_m.gzwi011,g_gzwi_m.gzwi012,g_gzwi_m.gzwi027,g_gzwi_m.gzwi019,g_gzwi_m.gzwi020,g_gzwi_m.gzwi021, 
       g_gzwi_m.gzwi022,g_gzwi_m.gzwi023,g_gzwi_m.gzwi024,g_gzwi_m.gzwi025,g_gzwi_m.gzwi028,g_gzwi_m.gzwistus 
 
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="azzi932.input.head" >}
      #單頭段
      INPUT BY NAME g_gzwi_m.gzwi001,g_gzwi_m.gzwi002,g_gzwi_m.gzwi003,g_gzwi_m.gzwi008,g_gzwi_m.gzwi010, 
          g_gzwi_m.gzwi004,g_gzwi_m.gzwi005,g_gzwi_m.gzwi013,g_gzwi_m.gzwi006,g_gzwi_m.gzwi015,g_gzwi_m.gzwi018, 
          g_gzwi_m.gzwi011,g_gzwi_m.gzwi012,g_gzwi_m.gzwi027,g_gzwi_m.gzwi019,g_gzwi_m.gzwi020,g_gzwi_m.gzwi021, 
          g_gzwi_m.gzwi022,g_gzwi_m.gzwi023,g_gzwi_m.gzwi024,g_gzwi_m.gzwi025,g_gzwi_m.gzwi028,g_gzwi_m.gzwistus  
 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN azzi932_cl USING g_gzwi_m.gzwi001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN azzi932_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE azzi932_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL azzi932_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            LET l_change_mail = FALSE
            NEXT FIELD gzwi012   #更新摘要
            #end add-point
            CALL azzi932_set_no_entry(p_cmd)
    
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwi001
            #add-point:BEFORE FIELD gzwi001 name="input.b.gzwi001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwi001
            
            #add-point:AFTER FIELD gzwi001 name="input.a.gzwi001"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  NOT cl_null(g_gzwi_m.gzwi001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_gzwi_m.gzwi001 != g_gzwi001_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(gzwi001) FROM gzwi_t WHERE "||"gzwi001 = '"|| g_gzwi_m.gzwi001 CLIPPED ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzwi001
            #add-point:ON CHANGE gzwi001 name="input.g.gzwi001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwi002
            #add-point:BEFORE FIELD gzwi002 name="input.b.gzwi002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwi002
            
            #add-point:AFTER FIELD gzwi002 name="input.a.gzwi002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzwi002
            #add-point:ON CHANGE gzwi002 name="input.g.gzwi002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwi003
            #add-point:BEFORE FIELD gzwi003 name="input.b.gzwi003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwi003
            
            #add-point:AFTER FIELD gzwi003 name="input.a.gzwi003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzwi003
            #add-point:ON CHANGE gzwi003 name="input.g.gzwi003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwi008
            
            #add-point:AFTER FIELD gzwi008 name="input.a.gzwi008"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwi008
            #add-point:BEFORE FIELD gzwi008 name="input.b.gzwi008"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzwi008
            #add-point:ON CHANGE gzwi008 name="input.g.gzwi008"
            CALL cl_get_progname(g_gzwi_m.gzwi008,g_lang,"1") RETURNING g_gzwi_inc.gzwi008_desc   #作業程式名稱
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwi010
            #add-point:BEFORE FIELD gzwi010 name="input.b.gzwi010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwi010
            
            #add-point:AFTER FIELD gzwi010 name="input.a.gzwi010"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzwi010
            #add-point:ON CHANGE gzwi010 name="input.g.gzwi010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwi004
            #add-point:BEFORE FIELD gzwi004 name="input.b.gzwi004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwi004
            
            #add-point:AFTER FIELD gzwi004 name="input.a.gzwi004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzwi004
            #add-point:ON CHANGE gzwi004 name="input.g.gzwi004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwi005
            
            #add-point:AFTER FIELD gzwi005 name="input.a.gzwi005"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_gzwi_m.gzwi005           
            CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
            LET g_gzwi_m.gzwi005_desc = g_rtn_fields[1] CLIPPED
            DISPLAY BY NAME g_gzwi_m.gzwi005_desc
            
            IF (NOT cl_null(g_gzwi_m.gzwi005)) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u') THEN 
                  ####161006-00007#1   start###
                  #檢查人員基本資料是否存在
                  CALL cl_helps932_chk_isExist_gzwg004(g_enterprise,"2",g_gzwi_m.gzwi005,TRUE) RETURNING l_err_chk,l_err_rtn
                  IF NOT l_err_chk THEN
                     NEXT FIELD gzwi005
                  END IF
                  ####161006-00007#1     end###
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwi005
            #add-point:BEFORE FIELD gzwi005 name="input.b.gzwi005"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzwi005
            #add-point:ON CHANGE gzwi005 name="input.g.gzwi005"
 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwi013
            #add-point:BEFORE FIELD gzwi013 name="input.b.gzwi013"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwi013
            
            #add-point:AFTER FIELD gzwi013 name="input.a.gzwi013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzwi013
            #add-point:ON CHANGE gzwi013 name="input.g.gzwi013"
 
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwi006
            
            #add-point:AFTER FIELD gzwi006 name="input.a.gzwi006"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_gzwi_m.gzwi006
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_gzwi_m.gzwi006_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_gzwi_m.gzwi006_desc

            IF  NOT cl_null(g_gzwi_m.gzwi006) THEN  #營運據點
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_gzwi_m.gzwi006 != g_gzwi_m_t.gzwi006 )) THEN 
                     IF g_gzwi_m.gzwi006 <> "ALL" THEN
                        #檢查營運據點基本資料是否存在
                        IF NOT cl_helps932_chk_isExist_ooef001(g_enterprise,g_gzwi_m.gzwi006) THEN
                           NEXT FIELD CURRENT
                        END IF
                     END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwi006
            #add-point:BEFORE FIELD gzwi006 name="input.b.gzwi006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzwi006
            #add-point:ON CHANGE gzwi006 name="input.g.gzwi006"
 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwi015
            #add-point:BEFORE FIELD gzwi015 name="input.b.gzwi015"
 
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwi015
            
            #add-point:AFTER FIELD gzwi015 name="input.a.gzwi015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzwi015
            #add-point:ON CHANGE gzwi015 name="input.g.gzwi015"
            NEXT FIELD gzwi018
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwi018
            #add-point:BEFORE FIELD gzwi018 name="input.b.gzwi018"
            IF cl_null(g_gzwi_m.gzwi015) THEN
               NEXT FIELD gzwi015
            END IF
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwi018
            
            #add-point:AFTER FIELD gzwi018 name="input.a.gzwi018"
            CALL cl_helps932_oofa_sel_2(g_enterprise,g_gzwi_m.gzwi015,g_gzwi_m.gzwi018) RETURNING g_oofa_sel[1].*
            LET g_gzwi_m.gzwi007 = g_oofa_sel[1].oofa001
            LET g_gzwi_m.gzwi007_desc = g_oofa_sel[1].oofa011
            DISPLAY BY NAME g_gzwi_m.gzwi007,g_gzwi_m.gzwi007_desc
            
            IF p_cmd = 'a' OR ( p_cmd = 'u') THEN 
               IF NOT cl_null(g_gzwi_m.gzwi018) THEN
                  ####161006-00007#1   start###
                  #檢查人員基本資料是否存在
                  CALL cl_helps932_chk_isExist_gzwg004(g_enterprise,g_gzwi_m.gzwi015,g_oofa_sel[1].oofa003,TRUE) RETURNING l_err_chk,l_err_rtn
                  IF NOT l_err_chk THEN
                     NEXT FIELD gzwi018
                  END IF
                  ####161006-00007#1     end###
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzwi018
            #add-point:ON CHANGE gzwi018 name="input.g.gzwi018"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwi011
            #add-point:BEFORE FIELD gzwi011 name="input.b.gzwi011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwi011
            
            #add-point:AFTER FIELD gzwi011 name="input.a.gzwi011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzwi011
            #add-point:ON CHANGE gzwi011 name="input.g.gzwi011"
 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwi012
            #add-point:BEFORE FIELD gzwi012 name="input.b.gzwi012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwi012
            
            #add-point:AFTER FIELD gzwi012 name="input.a.gzwi012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzwi012
            #add-point:ON CHANGE gzwi012 name="input.g.gzwi012"
 
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwi027
            #add-point:BEFORE FIELD gzwi027 name="input.b.gzwi027"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwi027
            
            #add-point:AFTER FIELD gzwi027 name="input.a.gzwi027"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzwi027
            #add-point:ON CHANGE gzwi027 name="input.g.gzwi027"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwi019
            #add-point:BEFORE FIELD gzwi019 name="input.b.gzwi019"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwi019
            
            #add-point:AFTER FIELD gzwi019 name="input.a.gzwi019"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzwi019
            #add-point:ON CHANGE gzwi019 name="input.g.gzwi019"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwi020
            #add-point:BEFORE FIELD gzwi020 name="input.b.gzwi020"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwi020
            
            #add-point:AFTER FIELD gzwi020 name="input.a.gzwi020"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzwi020
            #add-point:ON CHANGE gzwi020 name="input.g.gzwi020"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwi021
            #add-point:BEFORE FIELD gzwi021 name="input.b.gzwi021"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwi021
            
            #add-point:AFTER FIELD gzwi021 name="input.a.gzwi021"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzwi021
            #add-point:ON CHANGE gzwi021 name="input.g.gzwi021"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwi022
            #add-point:BEFORE FIELD gzwi022 name="input.b.gzwi022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwi022
            
            #add-point:AFTER FIELD gzwi022 name="input.a.gzwi022"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzwi022
            #add-point:ON CHANGE gzwi022 name="input.g.gzwi022"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwi023
            #add-point:BEFORE FIELD gzwi023 name="input.b.gzwi023"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwi023
            
            #add-point:AFTER FIELD gzwi023 name="input.a.gzwi023"
            #預估時數
            IF NOT cl_null(g_gzwi_m.gzwi023) THEN
               #和畫面顯示一致,四捨五入取到小數第一位
               CALL s_num_round("1",g_gzwi_m.gzwi023,1) RETURNING g_gzwi_m.gzwi023
               #不可為負數
               IF g_gzwi_m.gzwi023 < 0 THEN
                  LET g_gzwi_m.gzwi023 = 0
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzwi023
            #add-point:ON CHANGE gzwi023 name="input.g.gzwi023"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwi024
            #add-point:BEFORE FIELD gzwi024 name="input.b.gzwi024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwi024
            
            #add-point:AFTER FIELD gzwi024 name="input.a.gzwi024"
            #實際時數,和畫面顯示一致,四捨五入取到小數第一位
               #和畫面顯示一致,四捨五入取到小數第一位
               CALL s_num_round("1",g_gzwi_m.gzwi024,1) RETURNING g_gzwi_m.gzwi024
               #不可為負數
               IF g_gzwi_m.gzwi024 < 0 THEN
                  LET g_gzwi_m.gzwi024 = 0
               END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzwi024
            #add-point:ON CHANGE gzwi024 name="input.g.gzwi024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwi025
            #add-point:BEFORE FIELD gzwi025 name="input.b.gzwi025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwi025
            
            #add-point:AFTER FIELD gzwi025 name="input.a.gzwi025"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzwi025
            #add-point:ON CHANGE gzwi025 name="input.g.gzwi025"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwi028
            
            #add-point:AFTER FIELD gzwi028 name="input.a.gzwi028"
            CALL cl_helps932_gzwi028_desc(g_syncway,g_gzwi_m.gzwi028) RETURNING g_gzwi_m.gzwi028_desc
            DISPLAY BY NAME g_gzwi_m.gzwi028_desc

            ####161006-00007#1   start###
            IF NOT cl_null(g_gzwi_m.gzwi028) THEN
               CALL cl_helps932_cust_exist(g_gzwi_m.gzwi028,TRUE) RETURNING l_err_chk,l_err_rtn
               IF NOT l_err_chk THEN   #檢查資料是否存在
                  NEXT FIELD CURRENT
               END IF
            END IF
            ####161006-00007#1   start###
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwi028
            #add-point:BEFORE FIELD gzwi028 name="input.b.gzwi028"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzwi028
            #add-point:ON CHANGE gzwi028 name="input.g.gzwi028"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwistus
            #add-point:BEFORE FIELD gzwistus name="input.b.gzwistus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwistus
            
            #add-point:AFTER FIELD gzwistus name="input.a.gzwistus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzwistus
            #add-point:ON CHANGE gzwistus name="input.g.gzwistus"
 
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.gzwi001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwi001
            #add-point:ON ACTION controlp INFIELD gzwi001 name="input.c.gzwi001"
            
            #END add-point
 
 
         #Ctrlp:input.c.gzwi002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwi002
            #add-point:ON ACTION controlp INFIELD gzwi002 name="input.c.gzwi002"
            
            #END add-point
 
 
         #Ctrlp:input.c.gzwi003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwi003
            #add-point:ON ACTION controlp INFIELD gzwi003 name="input.c.gzwi003"
            
            #END add-point
 
 
         #Ctrlp:input.c.gzwi008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwi008
            #add-point:ON ACTION controlp INFIELD gzwi008 name="input.c.gzwi008"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_gzwi_m.gzwi008             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_gzzz001_1()                                #呼叫開窗

            LET g_gzwi_m.gzwi008 = g_qryparam.return1              
            CALL cl_get_progname(g_gzwi_m.gzwi008,g_lang,"1") RETURNING g_gzwi_inc.gzwi008_desc   #作業程式名稱
            DISPLAY g_gzwi_m.gzwi008 TO gzwi008              #

            NEXT FIELD gzwi008                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.gzwi010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwi010
            #add-point:ON ACTION controlp INFIELD gzwi010 name="input.c.gzwi010"
            
            #END add-point
 
 
         #Ctrlp:input.c.gzwi004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwi004
            #add-point:ON ACTION controlp INFIELD gzwi004 name="input.c.gzwi004"
            
            #END add-point
 
 
         #Ctrlp:input.c.gzwi005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwi005
            #add-point:ON ACTION controlp INFIELD gzwi005 name="input.c.gzwi005"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_gzwi_m.gzwi005             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" 
            CALL q_ooag001()                                #呼叫開窗

            LET g_gzwi_m.gzwi005 = g_qryparam.return1              

            DISPLAY g_gzwi_m.gzwi005 TO gzwi005              #

            NEXT FIELD gzwi005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.gzwi013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwi013
            #add-point:ON ACTION controlp INFIELD gzwi013 name="input.c.gzwi013"
            
            #END add-point
 
 
         #Ctrlp:input.c.gzwi006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwi006
            #add-point:ON ACTION controlp INFIELD gzwi006 name="input.c.gzwi006"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_gzwi_m.gzwi006             #給予default值
            LET g_qryparam.default2 = "" #g_gzwi_m.ooefl003 #說明(簡稱)
            #給予arg
            LET g_qryparam.arg1 = "" 
            CALL q_ooef001()                                #呼叫開窗

            LET g_gzwi_m.gzwi006 = g_qryparam.return1              
            #LET g_gzwi_m.ooefl003 = g_qryparam.return2 
            DISPLAY g_gzwi_m.gzwi006 TO gzwi006              #
            #DISPLAY g_gzwi_m.ooefl003 TO ooefl003 #說明(簡稱)
            NEXT FIELD gzwi006                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.gzwi015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwi015
            #add-point:ON ACTION controlp INFIELD gzwi015 name="input.c.gzwi015"
            
            #END add-point
 
 
         #Ctrlp:input.c.gzwi018
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwi018
            #add-point:ON ACTION controlp INFIELD gzwi018 name="input.c.gzwi018"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_gzwi_m.gzwi018             #給予default值

            #給予arg
            LET g_qryparam.arg1 = g_gzwi_m.gzwi015   #處理人員類型
            CALL q_oofa001_4()                                #呼叫開窗
            
            LET g_gzwi_m.gzwi018 = g_qryparam.return1
            CALL cl_helps932_oofa001_sel_by1(g_enterprise,g_gzwi_m.gzwi015,g_gzwi_m.gzwi018) RETURNING g_gzwi_m.gzwi007
            DISPLAY g_gzwi_m.gzwi007 TO gzwi007
            DISPLAY g_gzwi_m.gzwi018 TO gzwi018
            NEXT FIELD gzwi018                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.gzwi011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwi011
            #add-point:ON ACTION controlp INFIELD gzwi011 name="input.c.gzwi011"
            
            #END add-point
 
 
         #Ctrlp:input.c.gzwi012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwi012
            #add-point:ON ACTION controlp INFIELD gzwi012 name="input.c.gzwi012"
            
            #END add-point
 
 
         #Ctrlp:input.c.gzwi027
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwi027
            #add-point:ON ACTION controlp INFIELD gzwi027 name="input.c.gzwi027"
            
            #END add-point
 
 
         #Ctrlp:input.c.gzwi019
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwi019
            #add-point:ON ACTION controlp INFIELD gzwi019 name="input.c.gzwi019"
            
            #END add-point
 
 
         #Ctrlp:input.c.gzwi020
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwi020
            #add-point:ON ACTION controlp INFIELD gzwi020 name="input.c.gzwi020"
            
            #END add-point
 
 
         #Ctrlp:input.c.gzwi021
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwi021
            #add-point:ON ACTION controlp INFIELD gzwi021 name="input.c.gzwi021"
            
            #END add-point
 
 
         #Ctrlp:input.c.gzwi022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwi022
            #add-point:ON ACTION controlp INFIELD gzwi022 name="input.c.gzwi022"
            
            #END add-point
 
 
         #Ctrlp:input.c.gzwi023
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwi023
            #add-point:ON ACTION controlp INFIELD gzwi023 name="input.c.gzwi023"
            
            #END add-point
 
 
         #Ctrlp:input.c.gzwi024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwi024
            #add-point:ON ACTION controlp INFIELD gzwi024 name="input.c.gzwi024"
            
            #END add-point
 
 
         #Ctrlp:input.c.gzwi025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwi025
            #add-point:ON ACTION controlp INFIELD gzwi025 name="input.c.gzwi025"
            
            #END add-point
 
 
         #Ctrlp:input.c.gzwi028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwi028
            #add-point:ON ACTION controlp INFIELD gzwi028 name="input.c.gzwi028"
            #應用 a07 樣板自動產生(Version:2)
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_gzwi_m.gzwi028             #給予default值
            #給予arg
            LET g_qryparam.arg1 = "" #s
            CALL cl_helps932_q_gzwi028()                  #呼叫開窗
            LET g_gzwi_m.gzwi028 = g_qryparam.return1
            DISPLAY g_gzwi_m.gzwi028 TO gzwi028

            CALL cl_helps932_gzwi028_desc(g_syncway,g_gzwi_m.gzwi028) RETURNING g_gzwi_m.gzwi028_desc
            DISPLAY BY NAME g_gzwi_m.gzwi028_desc

            NEXT FIELD gzwi028                          #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.gzwistus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwistus
            #add-point:ON ACTION controlp INFIELD gzwistus name="input.c.gzwistus"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_gzwi_m.gzwi001
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               
               #end add-point
               
               INSERT INTO gzwi_t (gzwi001,gzwi002,gzwi003,gzwi008,gzwi010,gzwi017,gzwi004,gzwi005,gzwi013, 
                   gzwi006,gzwi015,gzwi016,gzwi018,gzwi007,gzwi011,gzwi012,gzwi027,gzwi014,gzwi009,gzwi026, 
                   gzwi019,gzwi020,gzwi021,gzwi022,gzwi023,gzwi024,gzwi025,gzwi028,gzwistus,gzwiownid, 
                   gzwiowndp,gzwicrtid,gzwicrtdp,gzwicrtdt,gzwimodid,gzwimoddt)
               VALUES (g_gzwi_m.gzwi001,g_gzwi_m.gzwi002,g_gzwi_m.gzwi003,g_gzwi_m.gzwi008,g_gzwi_m.gzwi010, 
                   g_gzwi_m.gzwi017,g_gzwi_m.gzwi004,g_gzwi_m.gzwi005,g_gzwi_m.gzwi013,g_gzwi_m.gzwi006, 
                   g_gzwi_m.gzwi015,g_gzwi_m.gzwi016,g_gzwi_m.gzwi018,g_gzwi_m.gzwi007,g_gzwi_m.gzwi011, 
                   g_gzwi_m.gzwi012,g_gzwi_m.gzwi027,g_gzwi_m.gzwi014,g_gzwi_m.gzwi009,g_gzwi_m.gzwi026, 
                   g_gzwi_m.gzwi019,g_gzwi_m.gzwi020,g_gzwi_m.gzwi021,g_gzwi_m.gzwi022,g_gzwi_m.gzwi023, 
                   g_gzwi_m.gzwi024,g_gzwi_m.gzwi025,g_gzwi_m.gzwi028,g_gzwi_m.gzwistus,g_gzwi_m.gzwiownid, 
                   g_gzwi_m.gzwiowndp,g_gzwi_m.gzwicrtid,g_gzwi_m.gzwicrtdp,g_gzwi_m.gzwicrtdt,g_gzwi_m.gzwimodid, 
                   g_gzwi_m.gzwimoddt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_gzwi_m:",SQLERRMESSAGE 
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
                  CALL azzi932_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL azzi932_b_fill()
                  CALL azzi932_b_fill2('0')
               END IF
               
               #add-point:單頭新增後 name="input.head.a_insert2"
               
               #end add-point
               
               LET g_master_insert = TRUE
               
               LET p_cmd = 'u'
            ELSE
               CALL s_transaction_begin()
            
               #add-point:單頭修改前 name="input.head.b_update"
               #型管結案重啟
               ###160606-00027#1 START ###
               #狀態6.測試 或 7.結案 改成8.結案重啟，重新新增型管需求單，並把案件代號改成新的型管需求單
               IF g_syncway = "alm" AND  g_gzwi_m.gzwi011 = "8" THEN
                  IF g_gzwi_m_t.gzwi011 = "6" OR g_gzwi_m_t.gzwi011 = "7" THEN
                     LET l_reopen = TRUE
                  ELSE
                     LET l_reopen = FALSE
                     LET g_gzwi_m.gzwi011 = g_gzwi_m_t.gzwi011   #狀態還原
                  END IF
               ELSE
                  LET l_reopen = FALSE
               END IF

               IF l_reopen THEN   #可以案件重啟
                  CALL l_syncold.clear()   #161018-00059#1
                  LET l_syncold[1].gzwoownid = g_gzwi_m.gzwiownid  #資料所有者
                  LET l_syncold[1].gzwoowndp = g_gzwi_m.gzwiowndp  #資料所屬部門
                  LET l_syncold[1].gzwocrtid = g_gzwi_m.gzwicrtid  #資料建立者
                  LET l_syncold[1].gzwocrtdp = g_gzwi_m.gzwicrtdp  #資料建立部門
                  LET l_syncold[1].gzwocrtdt = g_gzwi_m.gzwicrtdt  #資料創建日
                  LET l_syncold[1].gzwomodid = g_gzwi_m.gzwimodid  #資料修改者
                  LET l_syncold[1].gzwomoddt = g_gzwi_m.gzwimoddt  #最近修改日
                  LET l_syncold[1].gzwostus  = g_gzwi_m.gzwistus   #狀態碼
                  LET l_syncold[1].gzwo001   = g_gzwi_m.gzwi001    #問題編號
                  LET l_syncold[1].gzwo002   = g_gzwi_m.gzwi002    #類別
                  LET l_syncold[1].gzwo003   = g_gzwi_m.gzwi003    #模組
                  LET l_syncold[1].gzwo004   = g_gzwi_m.gzwi004    #問題描述
                  LET l_syncold[1].gzwo005   = g_gzwi_m.gzwi005    #反映人員
                  LET l_syncold[1].gzwo006   = g_gzwi_m.gzwi006    #反映營運據點
                  LET l_syncold[1].gzwo007   = g_gzwi_m.gzwi007    #處理人員
                  LET l_syncold[1].gzwo008   = g_gzwi_m.gzwi008    #作業編號
                  LET l_syncold[1].gzwo009   = g_gzwi_m.gzwi009    #案件代號
                  LET l_syncold[1].gzwo010   = g_gzwi_m.gzwi010    #緊急案件
                  LET l_syncold[1].gzwo011   = g_gzwi_m.gzwi011    #處理狀態
                  LET l_syncold[1].gzwo012   = g_gzwi_m.gzwi012    #更新摘要
                  LET l_syncold[1].gzwo013   = g_gzwi_m.gzwi013    #反映日期
                  LET l_syncold[1].gzwo014   = g_gzwi_m.gzwi014    #負責單位
                  LET l_syncold[1].gzwo015   = g_gzwi_m.gzwi015    #處理人員類型
                  LET l_syncold[1].gzwo016   = g_gzwi_m.gzwi016    #流水號
                  LET l_syncold[1].gzwo017   = g_gzwi_m.gzwi017    #企業編號
                  LET l_syncold[1].gzwo018   = g_gzwi_m.gzwi018    #處理人員
                  LET l_syncold[1].gzwo019   = g_gzwi_m.gzwi019    #規格預計完成日
                  LET l_syncold[1].gzwo020   = g_gzwi_m.gzwi020    #規格實際完成日
                  LET l_syncold[1].gzwo021   = g_gzwi_m.gzwi021    #預計完成日
                  LET l_syncold[1].gzwo022   = g_gzwi_m.gzwi022    #實際完成日
                  LET l_syncold[1].gzwo023   = g_gzwi_m.gzwi023    #預估時數
                  LET l_syncold[1].gzwo024   = g_gzwi_m.gzwi024    #實際時數
                  LET l_syncold[1].gzwo025   = g_gzwi_m.gzwi025    #確認書編號
                  LET l_syncold[1].gzwo026   = g_gzwi_m.gzwi026    #最近同步時間
                  LET l_syncold[1].gzwo027   = g_gzwi_m.gzwi027    #案件歷程
                  LET l_syncold[1].gzwo028   = g_gzwi_m.gzwi028    #客戶代號

                  #CALL cl_helps932_sync_batch(FALSE,FALSE,l_syncold) RETURNING l_gzwo_m   #161018-00059#1 mark
                  ###161018-00059#1 START ###
                  CALL cl_helps932_sync("RE",l_syncold[1].*,FALSE,FALSE) RETURNING l_chk,l_change_mail,l_syncold[1].gzwo001, #160804-00001#1
                                                                                   l_syncold[1].gzwo009,l_syncold[1].gzwo014,
                                                                                   l_syncold[1].gzwomodid,l_syncold[1].gzwomoddt
                  IF NOT l_chk THEN
                     LET g_gzwi_m.gzwi011 = g_gzwi_m_t.gzwi011   #狀態還原
                  ELSE  
                     LET g_gzwi_m.gzwi009   = l_syncold[1].gzwo009  
                     LET g_gzwi_m.gzwi014   = l_syncold[1].gzwo014  
                     LET g_gzwi_m.gzwimodid = l_syncold[1].gzwomodid
                     LET g_gzwi_m.gzwimoddt = l_syncold[1].gzwomoddt
                  END IF
                  ###161018-00059#1 END ###
               END IF
               ###160606-00027#1 END ###
               #end add-point
               
               #將遮罩欄位還原
               CALL azzi932_gzwi_t_mask_restore('restore_mask_o')
               
               UPDATE gzwi_t SET (gzwi001,gzwi002,gzwi003,gzwi008,gzwi010,gzwi017,gzwi004,gzwi005,gzwi013, 
                   gzwi006,gzwi015,gzwi016,gzwi018,gzwi007,gzwi011,gzwi012,gzwi027,gzwi014,gzwi009,gzwi026, 
                   gzwi019,gzwi020,gzwi021,gzwi022,gzwi023,gzwi024,gzwi025,gzwi028,gzwistus,gzwiownid, 
                   gzwiowndp,gzwicrtid,gzwicrtdp,gzwicrtdt,gzwimodid,gzwimoddt) = (g_gzwi_m.gzwi001, 
                   g_gzwi_m.gzwi002,g_gzwi_m.gzwi003,g_gzwi_m.gzwi008,g_gzwi_m.gzwi010,g_gzwi_m.gzwi017, 
                   g_gzwi_m.gzwi004,g_gzwi_m.gzwi005,g_gzwi_m.gzwi013,g_gzwi_m.gzwi006,g_gzwi_m.gzwi015, 
                   g_gzwi_m.gzwi016,g_gzwi_m.gzwi018,g_gzwi_m.gzwi007,g_gzwi_m.gzwi011,g_gzwi_m.gzwi012, 
                   g_gzwi_m.gzwi027,g_gzwi_m.gzwi014,g_gzwi_m.gzwi009,g_gzwi_m.gzwi026,g_gzwi_m.gzwi019, 
                   g_gzwi_m.gzwi020,g_gzwi_m.gzwi021,g_gzwi_m.gzwi022,g_gzwi_m.gzwi023,g_gzwi_m.gzwi024, 
                   g_gzwi_m.gzwi025,g_gzwi_m.gzwi028,g_gzwi_m.gzwistus,g_gzwi_m.gzwiownid,g_gzwi_m.gzwiowndp, 
                   g_gzwi_m.gzwicrtid,g_gzwi_m.gzwicrtdp,g_gzwi_m.gzwicrtdt,g_gzwi_m.gzwimodid,g_gzwi_m.gzwimoddt) 
 
                WHERE  gzwi001 = g_gzwi001_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "gzwi_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               LET l_diffold.gzwoownid = g_gzwi_m_t.gzwiownid  #資料所有者
               LET l_diffold.gzwoowndp = g_gzwi_m_t.gzwiowndp  #資料所屬部門
               LET l_diffold.gzwocrtid = g_gzwi_m_t.gzwicrtid  #資料建立者
               LET l_diffold.gzwocrtdp = g_gzwi_m_t.gzwicrtdp  #資料建立部門
               LET l_diffold.gzwocrtdt = g_gzwi_m_t.gzwicrtdt  #資料創建日
               LET l_diffold.gzwomodid = g_gzwi_m_t.gzwimodid  #資料修改者
               LET l_diffold.gzwomoddt = g_gzwi_m_t.gzwimoddt  #最近修改日
               LET l_diffold.gzwostus  = g_gzwi_m_t.gzwistus   #狀態碼
               LET l_diffold.gzwo001   = g_gzwi_m_t.gzwi001    #問題編號
               LET l_diffold.gzwo002   = g_gzwi_m_t.gzwi002    #類別
               LET l_diffold.gzwo003   = g_gzwi_m_t.gzwi003    #模組
               LET l_diffold.gzwo004   = g_gzwi_m_t.gzwi004    #問題描述
               LET l_diffold.gzwo005   = g_gzwi_m_t.gzwi005    #反映人員
               LET l_diffold.gzwo006   = g_gzwi_m_t.gzwi006    #反映營運據點
               LET l_diffold.gzwo007   = g_gzwi_m_t.gzwi007    #處理人員
               LET l_diffold.gzwo008   = g_gzwi_m_t.gzwi008    #作業編號
               LET l_diffold.gzwo009   = g_gzwi_m_t.gzwi009    #案件代號
               LET l_diffold.gzwo010   = g_gzwi_m_t.gzwi010    #緊急案件
               LET l_diffold.gzwo011   = g_gzwi_m_t.gzwi011    #處理狀態
               LET l_diffold.gzwo012   = g_gzwi_m_t.gzwi012    #更新摘要
               LET l_diffold.gzwo013   = g_gzwi_m_t.gzwi013    #反映日期
               LET l_diffold.gzwo014   = g_gzwi_m_t.gzwi014    #負責單位
               LET l_diffold.gzwo015   = g_gzwi_m_t.gzwi015    #處理人員類型
               LET l_diffold.gzwo016   = g_gzwi_m_t.gzwi016    #流水號
               LET l_diffold.gzwo017   = g_gzwi_m_t.gzwi017    #企業編號
               LET l_diffold.gzwo018   = g_gzwi_m_t.gzwi018    #處理人員
               LET l_diffold.gzwo019   = g_gzwi_m_t.gzwi019    #規格預計完成日
               LET l_diffold.gzwo020   = g_gzwi_m_t.gzwi020    #規格實際完成日
               LET l_diffold.gzwo021   = g_gzwi_m_t.gzwi021    #預計完成日
               LET l_diffold.gzwo022   = g_gzwi_m_t.gzwi022    #實際完成日
               LET l_diffold.gzwo023   = g_gzwi_m_t.gzwi023    #預估時數
               LET l_diffold.gzwo024   = g_gzwi_m_t.gzwi024    #實際時數
               LET l_diffold.gzwo025   = g_gzwi_m_t.gzwi025    #確認書編號
               LET l_diffold.gzwo026   = g_gzwi_m_t.gzwi026    #最近同步時間
               LET l_diffold.gzwo027   = g_gzwi_m_t.gzwi027    #案件歷程
               LET l_diffold.gzwo028   = g_gzwi_m_t.gzwi028    #客戶代號

               LET l_diffnew.gzwoownid = g_gzwi_m.gzwiownid    #資料所有者
               LET l_diffnew.gzwoowndp = g_gzwi_m.gzwiowndp    #資料所屬部門
               LET l_diffnew.gzwocrtid = g_gzwi_m.gzwicrtid    #資料建立者
               LET l_diffnew.gzwocrtdp = g_gzwi_m.gzwicrtdp    #資料建立部門
               LET l_diffnew.gzwocrtdt = g_gzwi_m.gzwicrtdt    #資料創建日
               LET l_diffnew.gzwomodid = g_gzwi_m.gzwimodid    #資料修改者
               LET l_diffnew.gzwomoddt = g_gzwi_m.gzwimoddt    #最近修改日
               LET l_diffnew.gzwostus  = g_gzwi_m.gzwistus     #狀態碼
               LET l_diffnew.gzwo001   = g_gzwi_m.gzwi001      #問題編號
               LET l_diffnew.gzwo002   = g_gzwi_m.gzwi002      #類別
               LET l_diffnew.gzwo003   = g_gzwi_m.gzwi003      #模組
               LET l_diffnew.gzwo004   = g_gzwi_m.gzwi004      #問題描述
               LET l_diffnew.gzwo005   = g_gzwi_m.gzwi005      #反映人員
               LET l_diffnew.gzwo006   = g_gzwi_m.gzwi006      #反映營運據點
               LET l_diffnew.gzwo007   = g_gzwi_m.gzwi007      #處理人員
               LET l_diffnew.gzwo008   = g_gzwi_m.gzwi008      #作業編號
               LET l_diffnew.gzwo009   = g_gzwi_m.gzwi009      #案件代號
               LET l_diffnew.gzwo010   = g_gzwi_m.gzwi010      #緊急案件
               LET l_diffnew.gzwo011   = g_gzwi_m.gzwi011      #處理狀態
               LET l_diffnew.gzwo012   = g_gzwi_m.gzwi012      #更新摘要
               LET l_diffnew.gzwo013   = g_gzwi_m.gzwi013      #反映日期
               LET l_diffnew.gzwo014   = g_gzwi_m.gzwi014      #負責單位
               LET l_diffnew.gzwo015   = g_gzwi_m.gzwi015      #處理人員類型
               LET l_diffnew.gzwo016   = g_gzwi_m.gzwi016      #流水號
               LET l_diffnew.gzwo017   = g_gzwi_m.gzwi017      #企業編號
               LET l_diffnew.gzwo018   = g_gzwi_m.gzwi018      #處理人員
               LET l_diffnew.gzwo019   = g_gzwi_m.gzwi019      #規格預計完成日
               LET l_diffnew.gzwo020   = g_gzwi_m.gzwi020      #規格實際完成日
               LET l_diffnew.gzwo021   = g_gzwi_m.gzwi021      #預計完成日
               LET l_diffnew.gzwo022   = g_gzwi_m.gzwi022      #實際完成日
               LET l_diffnew.gzwo023   = g_gzwi_m.gzwi023      #預估時數
               LET l_diffnew.gzwo024   = g_gzwi_m.gzwi024      #實際時數
               LET l_diffnew.gzwo025   = g_gzwi_m.gzwi025      #確認書編號
               LET l_diffnew.gzwo026   = g_gzwi_m.gzwi026      #最近同步時間
               LET l_diffnew.gzwo027   = g_gzwi_m.gzwi027      #案件歷程
               LET l_diffnew.gzwo028   = g_gzwi_m.gzwi028      #客戶代號

               LET l_change_mail = FALSE
               CALL cl_helps932_gzwo_ins("U",l_diffold.*,l_diffnew.*) RETURNING l_chk,l_diffnew.gzwo902   #新增問題反映記錄異動檔
               IF NOT cl_null(l_diffnew.gzwo902) THEN
                  IF l_chk THEN
                     #Mail寄件時機：(1)新增問題反映單、(2)修改問題描述、(3)修改處理狀態、(4)修改更新摘要
                     CALL cl_helps932_change_mail(l_change_mail,l_diffold.gzwo004,l_diffnew.gzwo004,l_diffold.gzwo011,l_diffnew.gzwo011,l_diffold.gzwo012,l_diffnew.gzwo012,l_diffold.gzwo027,l_diffnew.gzwo027) RETURNING l_change_mail   #160606-00027#1
                  ELSE
                     LET l_change_mail = FALSE
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = "azz-00766"   #問題編號%1異動記錄失敗
                     LET g_errparam.replace[1] = g_gzwi_m.gzwi001
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     NEXT FIELD CURRENT
                  END IF
               END IF
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL azzi932_gzwi_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_gzwi_m_t)
               LET g_log2 = util.JSON.stringify(g_gzwi_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               #CALL azzi932_showcourse(g_gzwi_m.gzwi012,g_gzwi_m.gzwi027)   #161027-00047#1 mark

               IF l_change_mail THEN   #是否因資料改變而需要寄送mail
                  CALL azzi932_send_mail()
               END IF
               
               IF NOT cl_null(l_diffnew.gzwo902) THEN   #161018-00059#1
                  CALL azzi932_browser_fill("")
                  CALL azzi932_fetch(g_current_idx)
               END IF
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_gzwi001_t = g_gzwi_m.gzwi001
 
            
      END INPUT
   
 
{</section>}
 
{<section id="azzi932.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_gzwj_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = FALSE, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = FALSE)
 
         #自訂ACTION(detail_input,page_1)
         
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_gzwj_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL azzi932_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_gzwj_d.getLength()
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
            OPEN azzi932_cl USING g_gzwi_m.gzwi001
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN azzi932_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE azzi932_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_gzwj_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_gzwj_d[l_ac].gzwj002 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_gzwj_d_t.* = g_gzwj_d[l_ac].*  #BACKUP
               LET g_gzwj_d_o.* = g_gzwj_d[l_ac].*  #BACKUP
               CALL azzi932_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
               
               #end add-point  
               CALL azzi932_set_no_entry_b(l_cmd)
               IF NOT azzi932_lock_b("gzwj_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH azzi932_bcl INTO g_gzwj_d[l_ac].gzwj008,g_gzwj_d[l_ac].gzwj002,g_gzwj_d[l_ac].gzwj004, 
                      g_gzwj_d[l_ac].gzwj005,g_gzwj_d[l_ac].gzwj007,g_gzwj_d[l_ac].gzwjcrtid,g_gzwj_d[l_ac].gzwjmodid, 
                      g_gzwj_d[l_ac].gzwjcrtdp,g_gzwj_d[l_ac].gzwjmoddt,g_gzwj_d[l_ac].gzwjcrtdt
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_gzwj_d_t.gzwj002,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_gzwj_d_mask_o[l_ac].* =  g_gzwj_d[l_ac].*
                  CALL azzi932_gzwj_t_mask()
                  LET g_gzwj_d_mask_n[l_ac].* =  g_gzwj_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL azzi932_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            ###161027-00047#1 START ###
            #舊資料NULL且有案件代號則視為"Y":同步
            IF cl_null(g_gzwj_d[l_ac].gzwj008) THEN
               IF cl_null(g_gzwi_m.gzwi009) THEN
                  LET g_gzwj_d[l_ac].gzwj008 = "N"
               ELSE
                  LET g_gzwj_d[l_ac].gzwj008 = "Y"
               END IF
            END IF
            
            #同步至服務平台的附件不可以刪除
            IF g_gzwj_d[l_ac].gzwj008 = "N" THEN   #未同步
               CALL cl_set_act_visible("delete", TRUE)
            ELSE
               CALL cl_set_act_visible("delete", FALSE)
            END IF
            ###161027-00047#1 END ###
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
            INITIALIZE g_gzwj_d[l_ac].* TO NULL 
            INITIALIZE g_gzwj_d_t.* TO NULL 
            INITIALIZE g_gzwj_d_o.* TO NULL 
            #公用欄位給值(單身)
            #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_gzwj_d[l_ac].gzwjcrtid = g_user
      LET g_gzwj_d[l_ac].gzwjcrtdp = g_dept 
      LET g_gzwj_d[l_ac].gzwjcrtdt = cl_get_current()
      LET g_gzwj_d[l_ac].gzwjmodid = g_user
      LET g_gzwj_d[l_ac].gzwjmoddt = cl_get_current()
 
 
 
            #自定義預設值
            
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            
            #end add-point
            LET g_gzwj_d_t.* = g_gzwj_d[l_ac].*     #新輸入資料
            LET g_gzwj_d_o.* = g_gzwj_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL azzi932_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL azzi932_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_gzwj_d[li_reproduce_target].* = g_gzwj_d[li_reproduce].*
 
               LET g_gzwj_d[li_reproduce_target].gzwj002 = NULL
 
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
            SELECT COUNT(1) INTO l_count FROM gzwj_t 
             WHERE  gzwj001 = g_gzwi_m.gzwi001
 
               AND gzwj002 = g_gzwj_d[l_ac].gzwj002
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gzwi_m.gzwi001
               LET gs_keys[2] = g_gzwj_d[g_detail_idx].gzwj002
               CALL azzi932_insert_b('gzwj_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_gzwj_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "gzwj_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL azzi932_b_fill()
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
               ###161027-00047#1 START ###
               #同步至服務平台的附件不可以刪除
               IF g_gzwj_d[l_ac].gzwj008 = "N" THEN   #未同步
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
               ELSE
                  CANCEL DELETE
               END IF
               ###161027-00047#1 END ###
               #end add-point 
               
               #取得該筆資料key值
               INITIALIZE gs_keys TO NULL
               LET gs_keys[01] = g_gzwi_m.gzwi001
 
               LET gs_keys[gs_keys.getLength()+1] = g_gzwj_d_t.gzwj002
 
            
               #刪除同層單身
               IF NOT azzi932_delete_b('gzwj_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE azzi932_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT azzi932_key_delete_b(gs_keys,'gzwj_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE azzi932_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE azzi932_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_gzwj_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_gzwj_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwj002
            #add-point:BEFORE FIELD gzwj002 name="input.b.page1.gzwj002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwj002
            
            #add-point:AFTER FIELD gzwj002 name="input.a.page1.gzwj002"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_gzwi_m.gzwi001 IS NOT NULL AND g_gzwj_d[g_detail_idx].gzwj002 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_gzwi_m.gzwi001 != g_gzwi001_t OR g_gzwj_d[g_detail_idx].gzwj002 != g_gzwj_d_t.gzwj002)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(gzwj001) FROM gzwj_t WHERE "||"gzwj001 = '"||g_gzwi_m.gzwi001 ||"' AND "|| "gzwj002 = '"||g_gzwj_d[g_detail_idx].gzwj002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzwj002
            #add-point:ON CHANGE gzwj002 name="input.g.page1.gzwj002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwj004
            #add-point:BEFORE FIELD gzwj004 name="input.b.page1.gzwj004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwj004
            
            #add-point:AFTER FIELD gzwj004 name="input.a.page1.gzwj004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzwj004
            #add-point:ON CHANGE gzwj004 name="input.g.page1.gzwj004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzwj005
            #add-point:BEFORE FIELD gzwj005 name="input.b.page1.gzwj005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzwj005
            
            #add-point:AFTER FIELD gzwj005 name="input.a.page1.gzwj005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzwj005
            #add-point:ON CHANGE gzwj005 name="input.g.page1.gzwj005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fileimg
            #add-point:BEFORE FIELD fileimg name="input.b.page1.fileimg"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fileimg
            
            #add-point:AFTER FIELD fileimg name="input.a.page1.fileimg"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fileimg
            #add-point:ON CHANGE fileimg name="input.g.page1.fileimg"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.gzwj002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwj002
            #add-point:ON ACTION controlp INFIELD gzwj002 name="input.c.page1.gzwj002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzwj004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwj004
            #add-point:ON ACTION controlp INFIELD gzwj004 name="input.c.page1.gzwj004"
            #/u1/t10dev/tmp/99201407272121202.jpg
            CALL cl_helps932_open_url("TEMPDIR",g_gzwj_d[l_ac].fileimg) RETURNING li_stat
            #END add-point
 
 
         #Ctrlp:input.c.page1.gzwj005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzwj005
            #add-point:ON ACTION controlp INFIELD gzwj005 name="input.c.page1.gzwj005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.fileimg
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fileimg
            #add-point:ON ACTION controlp INFIELD fileimg name="input.c.page1.fileimg"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_gzwj_d[l_ac].* = g_gzwj_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE azzi932_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_gzwj_d[l_ac].gzwj002 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_gzwj_d[l_ac].* = g_gzwj_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               LET g_gzwj_d[l_ac].gzwjmodid = g_user 
LET g_gzwj_d[l_ac].gzwjmoddt = cl_get_current()
LET g_gzwj_d[l_ac].gzwjmodid_desc = cl_get_username(g_gzwj_d[l_ac].gzwjmodid)
      
               #將遮罩欄位還原
               CALL azzi932_gzwj_t_mask_restore('restore_mask_o')
      
               UPDATE gzwj_t SET (gzwj001,gzwj008,gzwj002,gzwj004,gzwj005,gzwj007,gzwjcrtid,gzwjmodid, 
                   gzwjcrtdp,gzwjmoddt,gzwjcrtdt) = (g_gzwi_m.gzwi001,g_gzwj_d[l_ac].gzwj008,g_gzwj_d[l_ac].gzwj002, 
                   g_gzwj_d[l_ac].gzwj004,g_gzwj_d[l_ac].gzwj005,g_gzwj_d[l_ac].gzwj007,g_gzwj_d[l_ac].gzwjcrtid, 
                   g_gzwj_d[l_ac].gzwjmodid,g_gzwj_d[l_ac].gzwjcrtdp,g_gzwj_d[l_ac].gzwjmoddt,g_gzwj_d[l_ac].gzwjcrtdt) 
 
                WHERE  gzwj001 = g_gzwi_m.gzwi001 
 
                  AND gzwj002 = g_gzwj_d_t.gzwj002 #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_gzwj_d[l_ac].* = g_gzwj_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzwj_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_gzwj_d[l_ac].* = g_gzwj_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzwj_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_gzwi_m.gzwi001
               LET gs_keys_bak[1] = g_gzwi001_t
               LET gs_keys[2] = g_gzwj_d[g_detail_idx].gzwj002
               LET gs_keys_bak[2] = g_gzwj_d_t.gzwj002
               CALL azzi932_update_b('gzwj_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL azzi932_gzwj_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_gzwj_d[g_detail_idx].gzwj002 = g_gzwj_d_t.gzwj002 
 
                  ) THEN
                  LET gs_keys[01] = g_gzwi_m.gzwi001
 
                  LET gs_keys[gs_keys.getLength()+1] = g_gzwj_d_t.gzwj002
 
                  CALL azzi932_key_update_b(gs_keys,'gzwj_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_gzwi_m),util.JSON.stringify(g_gzwj_d_t)
               LET g_log2 = util.JSON.stringify(g_gzwi_m),util.JSON.stringify(g_gzwj_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
               
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            
            #end add-point
            CALL azzi932_unlock_b("gzwj_t","'1'")
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
               LET g_gzwj_d[li_reproduce_target].* = g_gzwj_d[li_reproduce].*
 
               LET g_gzwj_d[li_reproduce_target].gzwj002 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_gzwj_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_gzwj_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
 
 
{</section>}
 
{<section id="azzi932.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      BEFORE DIALOG 
         #CALL cl_err_collect_init()    
         #add-point:input段before dialog name="input.before_dialog"
         
         #end add-point    
         #重新導回資料到正確位置上
         CALL DIALOG.setCurrentRow("s_detail1",g_idx_group.getValue("'1',"))      
 
         #新增時強制從單頭開始填
         IF p_cmd = 'a' THEN
            #add-point:input段next_field name="input.next_field"
            
            #end add-point  
            NEXT FIELD gzwi001
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD gzwj008
 
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
 
{<section id="azzi932.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION azzi932_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
 
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
 
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL azzi932_b_fill() #單身填充
      CALL azzi932_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL azzi932_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   
   #end add-point
   
   #遮罩相關處理
   LET g_gzwi_m_mask_o.* =  g_gzwi_m.*
   CALL azzi932_gzwi_t_mask()
   LET g_gzwi_m_mask_n.* =  g_gzwi_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_gzwi_m.gzwi001,g_gzwi_m.gzwi002,g_gzwi_m.gzwi003,g_gzwi_m.gzwi008,g_gzwi_m.gzwi008_desc, 
       g_gzwi_m.gzwi010,g_gzwi_m.gzwi017,g_gzwi_m.gzwi017_desc,g_gzwi_m.gzwi004,g_gzwi_m.gzwi005,g_gzwi_m.gzwi005_desc, 
       g_gzwi_m.gzwi013,g_gzwi_m.gzwi006,g_gzwi_m.gzwi006_desc,g_gzwi_m.gzwi015,g_gzwi_m.gzwi016,g_gzwi_m.gzwi018, 
       g_gzwi_m.gzwi007_desc,g_gzwi_m.gzwi007,g_gzwi_m.gzwi011,g_gzwi_m.gzwi012,g_gzwi_m.gzwi027,g_gzwi_m.gzwi014, 
       g_gzwi_m.gzwi009,g_gzwi_m.gzwi026,g_gzwi_m.gzwi019,g_gzwi_m.gzwi020,g_gzwi_m.gzwi021,g_gzwi_m.gzwi022, 
       g_gzwi_m.gzwi023,g_gzwi_m.gzwi024,g_gzwi_m.gzwi025,g_gzwi_m.gzwi028,g_gzwi_m.gzwi028_desc,g_gzwi_m.gzwistus, 
       g_gzwi_m.gzwiownid,g_gzwi_m.gzwiownid_desc,g_gzwi_m.gzwiowndp,g_gzwi_m.gzwiowndp_desc,g_gzwi_m.gzwicrtid, 
       g_gzwi_m.gzwicrtid_desc,g_gzwi_m.gzwicrtdp,g_gzwi_m.gzwicrtdp_desc,g_gzwi_m.gzwicrtdt,g_gzwi_m.gzwimodid, 
       g_gzwi_m.gzwimodid_desc,g_gzwi_m.gzwimoddt
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_gzwi_m.gzwistus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_gzwj_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
 
   
    
   
   #add-point:show段other name="show.other"
   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL azzi932_detail_show()
 
   #add-point:show段之後 name="show.after"
   CALL azzi932_showcourse(g_gzwi_m.gzwi012,g_gzwi_m.gzwi027)
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="azzi932.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION azzi932_detail_show()
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
 
{<section id="azzi932.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION azzi932_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE gzwi_t.gzwi001 
   DEFINE l_oldno     LIKE gzwi_t.gzwi001 
 
   DEFINE l_master    RECORD LIKE gzwi_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE gzwj_t.* #此變數樣板目前無使用
 
 
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
   
   IF g_gzwi_m.gzwi001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_gzwi001_t = g_gzwi_m.gzwi001
 
    
   LET g_gzwi_m.gzwi001 = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_gzwi_m.gzwiownid = g_user
      LET g_gzwi_m.gzwiowndp = g_dept
      LET g_gzwi_m.gzwicrtid = g_user
      LET g_gzwi_m.gzwicrtdp = g_dept 
      LET g_gzwi_m.gzwicrtdt = cl_get_current()
      LET g_gzwi_m.gzwimodid = g_user
      LET g_gzwi_m.gzwimoddt = cl_get_current()
      LET g_gzwi_m.gzwistus = 'Y'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_gzwi_m.gzwistus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
   
   
   CALL azzi932_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_gzwi_m.* TO NULL
      INITIALIZE g_gzwj_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL azzi932_show()
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
   CALL azzi932_set_act_visible()   
   CALL azzi932_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_gzwi001_t = g_gzwi_m.gzwi001
 
   
   #組合新增資料的條件
   LET g_add_browse = " ",
                      " gzwi001 = '", g_gzwi_m.gzwi001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL azzi932_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   CALL azzi932_showcourse(g_gzwi_m.gzwi012,g_gzwi_m.gzwi027)   #161027-00047#1
   #end add-point
   
   CALL azzi932_idx_chk()
   
   LET g_data_owner = g_gzwi_m.gzwiownid      
   LET g_data_dept  = g_gzwi_m.gzwiowndp
   
   #功能已完成,通報訊息中心
   CALL azzi932_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="azzi932.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION azzi932_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE gzwj_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE azzi932_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM gzwj_t
    WHERE  gzwj001 = g_gzwi001_t
 
    INTO TEMP azzi932_detail
 
   #將key修正為調整後   
   UPDATE azzi932_detail 
      #更新key欄位
      SET gzwj001 = g_gzwi_m.gzwi001
 
      #更新共用欄位
      #應用 a13 樣板自動產生(Version:4)
       , gzwjcrtid = g_user
       , gzwjcrtdp = g_dept 
       , gzwjcrtdt = ld_date
       , gzwjmodid = g_user
       , gzwjmoddt = ld_date
 
 
 
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO gzwj_t SELECT * FROM azzi932_detail
   
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
   DROP TABLE azzi932_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_gzwi001_t = g_gzwi_m.gzwi001
 
   
END FUNCTION
 
{</section>}
 
{<section id="azzi932.delete" >}
#+ 資料刪除
PRIVATE FUNCTION azzi932_delete()
   #add-point:delete段define(客製用) name="delete.define_customerization"
   
   #end add-point     
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   DEFINE l_chk            BOOLEAN
   DEFINE l_diffold          type_g_gzwo_inc   #原始資料
   DEFINE l_diffnew          type_g_gzwo_inc   #異動後
   #end add-point     
   
   #add-point:Function前置處理  name="delete.pre_function"
   
   #end add-point
   
   IF g_gzwi_m.gzwi001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN azzi932_cl USING g_gzwi_m.gzwi001
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN azzi932_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE azzi932_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE azzi932_master_referesh USING g_gzwi_m.gzwi001 INTO g_gzwi_m.gzwi001,g_gzwi_m.gzwi002,g_gzwi_m.gzwi003, 
       g_gzwi_m.gzwi008,g_gzwi_m.gzwi010,g_gzwi_m.gzwi017,g_gzwi_m.gzwi004,g_gzwi_m.gzwi005,g_gzwi_m.gzwi013, 
       g_gzwi_m.gzwi006,g_gzwi_m.gzwi015,g_gzwi_m.gzwi016,g_gzwi_m.gzwi018,g_gzwi_m.gzwi007,g_gzwi_m.gzwi011, 
       g_gzwi_m.gzwi012,g_gzwi_m.gzwi027,g_gzwi_m.gzwi014,g_gzwi_m.gzwi009,g_gzwi_m.gzwi026,g_gzwi_m.gzwi019, 
       g_gzwi_m.gzwi020,g_gzwi_m.gzwi021,g_gzwi_m.gzwi022,g_gzwi_m.gzwi023,g_gzwi_m.gzwi024,g_gzwi_m.gzwi025, 
       g_gzwi_m.gzwi028,g_gzwi_m.gzwistus,g_gzwi_m.gzwiownid,g_gzwi_m.gzwiowndp,g_gzwi_m.gzwicrtid,g_gzwi_m.gzwicrtdp, 
       g_gzwi_m.gzwicrtdt,g_gzwi_m.gzwimodid,g_gzwi_m.gzwimoddt,g_gzwi_m.gzwi008_desc,g_gzwi_m.gzwi017_desc, 
       g_gzwi_m.gzwi005_desc,g_gzwi_m.gzwi006_desc,g_gzwi_m.gzwi007_desc,g_gzwi_m.gzwi028_desc,g_gzwi_m.gzwiownid_desc, 
       g_gzwi_m.gzwiowndp_desc,g_gzwi_m.gzwicrtid_desc,g_gzwi_m.gzwicrtdp_desc,g_gzwi_m.gzwimodid_desc 
 
   
   
   #檢查是否允許此動作
   IF NOT azzi932_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_gzwi_m_mask_o.* =  g_gzwi_m.*
   CALL azzi932_gzwi_t_mask()
   LET g_gzwi_m_mask_n.* =  g_gzwi_m.*
   
   CALL azzi932_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL azzi932_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_gzwi001_t = g_gzwi_m.gzwi001
 
 
      DELETE FROM gzwi_t
       WHERE  gzwi001 = g_gzwi_m.gzwi001
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
 
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_gzwi_m.gzwi001,":",SQLERRMESSAGE  
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
      
      #add-point:單頭刪除後 name="delete.head.a_delete"
      #異動欄位
      LET l_diffold.gzwoownid = g_gzwi_m.gzwiownid  #資料所有者
      LET l_diffold.gzwoowndp = g_gzwi_m.gzwiowndp  #資料所屬部門
      LET l_diffold.gzwocrtid = g_gzwi_m.gzwicrtid  #資料建立者
      LET l_diffold.gzwocrtdp = g_gzwi_m.gzwicrtdp  #資料建立部門
      LET l_diffold.gzwocrtdt = g_gzwi_m.gzwicrtdt  #資料創建日
      LET l_diffold.gzwomodid = g_gzwi_m.gzwimodid  #資料修改者
      LET l_diffold.gzwomoddt = g_gzwi_m.gzwimoddt  #最近修改日
      LET l_diffold.gzwostus  = g_gzwi_m.gzwistus   #狀態碼
      LET l_diffold.gzwo001   = g_gzwi_m.gzwi001    #問題編號
      LET l_diffold.gzwo002   = g_gzwi_m.gzwi002    #類別
      LET l_diffold.gzwo003   = g_gzwi_m.gzwi003    #模組
      LET l_diffold.gzwo004   = g_gzwi_m.gzwi004    #問題描述
      LET l_diffold.gzwo005   = g_gzwi_m.gzwi005    #反映人員
      LET l_diffold.gzwo006   = g_gzwi_m.gzwi006    #反映營運據點
      LET l_diffold.gzwo007   = g_gzwi_m.gzwi007    #處理人員
      LET l_diffold.gzwo008   = g_gzwi_m.gzwi008    #作業編號
      LET l_diffold.gzwo009   = g_gzwi_m.gzwi009    #案件代號
      LET l_diffold.gzwo010   = g_gzwi_m.gzwi010    #緊急案件
      LET l_diffold.gzwo011   = g_gzwi_m.gzwi011    #處理狀態
      LET l_diffold.gzwo012   = g_gzwi_m.gzwi012    #更新摘要
      LET l_diffold.gzwo013   = g_gzwi_m.gzwi013    #反映日期
      LET l_diffold.gzwo014   = g_gzwi_m.gzwi014    #負責單位
      LET l_diffold.gzwo015   = g_gzwi_m.gzwi015    #處理人員類型
      LET l_diffold.gzwo016   = g_gzwi_m.gzwi016    #流水號
      LET l_diffold.gzwo017   = g_gzwi_m.gzwi017    #企業編號
      LET l_diffold.gzwo018   = g_gzwi_m.gzwi018    #處理人員
      LET l_diffold.gzwo019   = g_gzwi_m.gzwi019    #規格預計完成日
      LET l_diffold.gzwo020   = g_gzwi_m.gzwi020    #規格實際完成日
      LET l_diffold.gzwo021   = g_gzwi_m.gzwi021    #預計完成日
      LET l_diffold.gzwo022   = g_gzwi_m.gzwi022    #實際完成日
      LET l_diffold.gzwo023   = g_gzwi_m.gzwi023    #預估時數
      LET l_diffold.gzwo024   = g_gzwi_m.gzwi024    #實際時數
      LET l_diffold.gzwo025   = g_gzwi_m.gzwi025    #確認書編號
      LET l_diffold.gzwo026   = g_gzwi_m.gzwi026    #最近同步時間
      LET l_diffold.gzwo027   = g_gzwi_m.gzwi027    #案件歷程
      LET l_diffold.gzwo028   = g_gzwi_m.gzwi028    #客戶代號
      
      INITIALIZE l_diffnew TO NULL
      LET l_diffnew.gzwomodid = g_user              #資料修改者
      LET l_diffnew.gzwomoddt = cl_get_current()    #最近修改日
      LET l_diffnew.gzwo001   = g_gzwi_m.gzwi001    #問題編號

      CALL cl_helps932_gzwo_ins("D",l_diffold.*,l_diffnew.*) RETURNING l_chk,l_diffnew.gzwo902   #新增問題反映記錄異動檔
      IF NOT cl_null(l_diffnew.gzwo902) THEN
         IF l_chk THEN
            #LET l_change_mail = TRUE
         ELSE
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "" 
            LET g_errparam.code   = "azz-00766"   #問題編號%1異動記錄失敗
            LET g_errparam.replace[1] = g_gzwi_m.gzwi001
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            CALL s_transaction_end('N','0')
            RETURN
         END IF
      END IF
      #end add-point
  
      #add-point:單身刪除前 name="delete.body.b_delete"
      
      #end add-point
      
      DELETE FROM gzwj_t
       WHERE  gzwj001 = g_gzwi_m.gzwi001
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gzwj_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF    
 
      #add-point:單身刪除後 name="delete.body.a_delete"
      
      #end add-point
      
            
                                                               
 
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_gzwi_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE azzi932_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_gzwj_d.clear() 
 
     
      CALL azzi932_ui_browser_refresh()  
      #CALL azzi932_ui_headershow()  
      #CALL azzi932_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL azzi932_browser_fill("")
         CALL azzi932_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE azzi932_cl
 
   #功能已完成,通報訊息中心
   CALL azzi932_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="azzi932.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION azzi932_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_target      STRING
   DEFINE lb_fileimg    LIKE gzwj_t.gzwj003
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_gzwj_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   LOCATE lb_fileimg IN FILE
   #程式產生器不支援單身有blob,需要另外在迴圈中再次取值
   LET g_sql = "SELECT gzwj003 FROM gzwj_t WHERE gzwj001=? AND gzwj002=?"
   PREPARE azzi932_gzwj003_pre FROM g_sql
   #end add-point
   
   #判斷是否填充
   IF azzi932_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT gzwj008,gzwj002,gzwj004,gzwj005,gzwj007,gzwjcrtid,gzwjmodid,gzwjcrtdp, 
             gzwjmoddt,gzwjcrtdt ,t1.ooag011 ,t2.ooag011 ,t3.ooefl003 FROM gzwj_t",   
                     " INNER JOIN gzwi_t ON  gzwi001 = gzwj001 ",
 
                     #"",
                     
                     "",
                     #下層單身所需的join條件
 
                                    " LEFT JOIN ooag_t t1 ON t1.ooagent="||g_enterprise||" AND t1.ooag001=gzwjcrtid  ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=gzwjmodid  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=gzwjcrtdp AND t3.ooefl002='"||g_dlang||"' ",
 
                     " WHERE gzwj001=?"
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
         
         #end add-point
         IF NOT cl_null(g_wc2_table1) THEN
            LET g_sql = g_sql CLIPPED, " AND ", g_wc2_table1 CLIPPED
         END IF
         
         #子單身的WC
         
         
         LET g_sql = g_sql, " ORDER BY gzwj_t.gzwj002"
         
         #add-point:單身填充控制 name="b_fill.sql"
 
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE azzi932_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR azzi932_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_gzwi_m.gzwi001   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_gzwi_m.gzwi001 INTO g_gzwj_d[l_ac].gzwj008,g_gzwj_d[l_ac].gzwj002,g_gzwj_d[l_ac].gzwj004, 
          g_gzwj_d[l_ac].gzwj005,g_gzwj_d[l_ac].gzwj007,g_gzwj_d[l_ac].gzwjcrtid,g_gzwj_d[l_ac].gzwjmodid, 
          g_gzwj_d[l_ac].gzwjcrtdp,g_gzwj_d[l_ac].gzwjmoddt,g_gzwj_d[l_ac].gzwjcrtdt,g_gzwj_d[l_ac].gzwjcrtid_desc, 
          g_gzwj_d[l_ac].gzwjmodid_desc,g_gzwj_d[l_ac].gzwjcrtdp_desc   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         ###161027-00047#1 START ###
         #舊資料NULL且有案件代號則視為"Y":同步
         IF cl_null(g_gzwj_d[l_ac].gzwj008) THEN
            IF cl_null(g_gzwi_m.gzwi009) THEN
               LET g_gzwj_d[l_ac].gzwj008 = "N"
            ELSE
               LET g_gzwj_d[l_ac].gzwj008 = "Y"
            END IF
         END IF
         ###161027-00047#1 END ###

         #fileimg         
         EXECUTE azzi932_gzwj003_pre USING g_gzwi_m.gzwi001,g_gzwj_d[l_ac].gzwj002 INTO lb_fileimg
         IF SQLCA.sqlcode THEN
            CONTINUE FOREACH
         ELSE
            LET l_target = os.Path.join(g_target_dir, g_enterprise || g_gzwi_m.gzwi001 || g_gzwj_d[l_ac].gzwj002 || "." || g_gzwj_d[l_ac].gzwj005)
            CALL lb_fileimg.writeFile(l_target)
            LET g_gzwj_d[l_ac].fileimg = l_target
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
    
 
   
   #add-point:browser_fill段其他table處理 name="browser_fill.other_fill"
   FREE lb_fileimg
   #end add-point
   
   CALL g_gzwj_d.deleteElement(g_gzwj_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE azzi932_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_gzwj_d.getLength()
      LET g_gzwj_d_mask_o[l_ac].* =  g_gzwj_d[l_ac].*
      CALL azzi932_gzwj_t_mask()
      LET g_gzwj_d_mask_n[l_ac].* =  g_gzwj_d[l_ac].*
   END FOR
   
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="azzi932.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION azzi932_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM gzwj_t
       WHERE 
         gzwj001 = ps_keys_bak[1] AND gzwj002 = ps_keys_bak[2]
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
         CALL g_gzwj_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
 
   
   #add-point:delete_b段other name="delete_b.other"
   
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="azzi932.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION azzi932_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO gzwj_t
                  (
                   gzwj001,
                   gzwj002
                   ,gzwj008,gzwj004,gzwj005,gzwj007,gzwjcrtid,gzwjmodid,gzwjcrtdp,gzwjmoddt,gzwjcrtdt) 
            VALUES(
                   ps_keys[1],ps_keys[2]
                   ,g_gzwj_d[g_detail_idx].gzwj008,g_gzwj_d[g_detail_idx].gzwj004,g_gzwj_d[g_detail_idx].gzwj005, 
                       g_gzwj_d[g_detail_idx].gzwj007,g_gzwj_d[g_detail_idx].gzwjcrtid,g_gzwj_d[g_detail_idx].gzwjmodid, 
                       g_gzwj_d[g_detail_idx].gzwjcrtdp,g_gzwj_d[g_detail_idx].gzwjmoddt,g_gzwj_d[g_detail_idx].gzwjcrtdt) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gzwj_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_gzwj_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="azzi932.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION azzi932_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "gzwj_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL azzi932_gzwj_t_mask_restore('restore_mask_o')
               
      UPDATE gzwj_t 
         SET (gzwj001,
              gzwj002
              ,gzwj008,gzwj004,gzwj005,gzwj007,gzwjcrtid,gzwjmodid,gzwjcrtdp,gzwjmoddt,gzwjcrtdt) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_gzwj_d[g_detail_idx].gzwj008,g_gzwj_d[g_detail_idx].gzwj004,g_gzwj_d[g_detail_idx].gzwj005, 
                  g_gzwj_d[g_detail_idx].gzwj007,g_gzwj_d[g_detail_idx].gzwjcrtid,g_gzwj_d[g_detail_idx].gzwjmodid, 
                  g_gzwj_d[g_detail_idx].gzwjcrtdp,g_gzwj_d[g_detail_idx].gzwjmoddt,g_gzwj_d[g_detail_idx].gzwjcrtdt)  
 
         WHERE  gzwj001 = ps_keys_bak[1] AND gzwj002 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gzwj_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "gzwj_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL azzi932_gzwj_t_mask_restore('restore_mask_n')
               
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
 
{<section id="azzi932.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION azzi932_key_update_b(ps_keys_bak,ps_table)
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
 
{<section id="azzi932.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION azzi932_key_delete_b(ps_keys_bak,ps_table)
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
 
{<section id="azzi932.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION azzi932_lock_b(ps_table,ps_page)
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
   #CALL azzi932_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "gzwj_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN azzi932_bcl USING 
                                       g_gzwi_m.gzwi001,g_gzwj_d[g_detail_idx].gzwj002     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "azzi932_bcl:",SQLERRMESSAGE 
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
 
{<section id="azzi932.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION azzi932_unlock_b(ps_table,ps_page)
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
      CLOSE azzi932_bcl
   END IF
   
 
   
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="azzi932.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION azzi932_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("gzwi001",TRUE)
      CALL cl_set_comp_entry("",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      #CALL cl_set_comp_entry("gzwi004,gzwi014",TRUE)   #161027-00047#1 mark
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="azzi932.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION azzi932_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("gzwi001",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      #CALL cl_set_comp_entry("gzwi004,gzwi014",FALSE)   #161027-00047#1 mark
      ###161027-00047#1 START ###
      #eservice需要從鼎新同步資料回來,禁止在此修改資料
      IF g_gzwi_m.gzwi014 = "2" THEN   #有反映鼎新
         CALL cl_set_comp_entry("gzwi002,gzwi003,gzwi004,gzwi005,gzwi006,gzwi007,gzwi008,gzwi010,gzwi011,gzwi015,gzwi018,gzwi019,gzwi020,gzwi021,gzwi022,gzwi023,gzwi024,gzwi025",FALSE)
      ELSE
         CALL cl_set_comp_entry("gzwi002,gzwi003,gzwi004,gzwi005,gzwi006,gzwi007,gzwi008,gzwi010,gzwi011,gzwi015,gzwi018,gzwi019,gzwi020,gzwi021,gzwi022,gzwi023,gzwi024,gzwi025",TRUE)
      END IF
      ###161027-00047#1 END ###
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
 
{<section id="azzi932.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION azzi932_set_entry_b(p_cmd)
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
 
{<section id="azzi932.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION azzi932_set_no_entry_b(p_cmd)
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
 
{<section id="azzi932.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION azzi932_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="azzi932.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION azzi932_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
 
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   ###161027-00047#1 START ###
   IF cl_null(g_gzwi_m.gzwi001) THEN   #沒有問題編號,關閉功能
      CALL cl_set_act_visible("helptoalm,helpcase_1,qry_case", FALSE)
   ELSE
      #刪除
      IF cl_null(g_gzwi_m.gzwi009) THEN
         CALL cl_set_act_visible("delete", TRUE)
      ELSE
         CALL cl_set_act_visible("delete", FALSE)
      END IF
      #反映鼎新
      IF cl_null(g_gzwi_m.gzwi009) AND g_syncway <> " " THEN
         CALL cl_set_act_visible("helptoalm", TRUE)
      ELSE
         CALL cl_set_act_visible("helptoalm", FALSE)
      END IF
      #更新案件
      IF (NOT cl_null(g_gzwi_m.gzwi009)) AND g_syncway = "eservice" AND (g_gzwi_m.gzwi011 <> "7") THEN
         CALL cl_set_act_visible("helpcase_1", TRUE)
      ELSE
         CALL cl_set_act_visible("helpcase_1", FALSE)
      END IF
      #型管需求單
      IF g_gzwi_m.gzwi014 = "0" AND g_syncway = "alm" THEN
         CALL cl_set_act_visible("qry_case", TRUE)
      ELSE
         CALL cl_set_act_visible("qry_case", FALSE)
      END IF
      #改變狀態,修改,修改單身,複製
      #eservice需要從鼎新同步資料回來,禁止在此修改資料
      #IF g_gzwi_m.gzwi014 = "2" THEN   #有反映鼎新
      #   CALL cl_set_act_visible("statechange,modify,modify_detail,reproduce", FALSE)
      #ELSE
      #   CALL cl_set_act_visible("statechange,modify,modify_detail,reproduce", TRUE)
      #END IF
   END IF
   ###161027-00047#1 END ###
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="azzi932.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION azzi932_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="azzi932.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION azzi932_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   DEFINE l_i    LIKE type_t.num10
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   ###161027-00047#1 STATR ###
   IF cl_null(g_gzwi_m.gzwi001) THEN   #沒有問題編號,關閉功能
      CALL cl_set_act_visible("btn_showfileimg,btn_newfileimg,btn_casefile1", FALSE)
   ELSE
      #開啟附件
      LET l_i = g_gzwj_d.getLength()
      IF l_ac > 0 AND l_i >= l_ac THEN
         CALL cl_set_act_visible("btn_showfileimg", TRUE)
      ELSE
         CALL cl_set_act_visible("btn_showfileimg", FALSE)
      END IF
      #新增附件
      IF g_gzwi_m.gzwi011 <> "7"                          #未結案
         AND g_gzwi_m.gzwi014 <> "0" THEN                 #未反映產中
         CALL cl_set_act_visible("btn_newfileimg", TRUE)
      ELSE
         CALL cl_set_act_visible("btn_newfileimg", FALSE)
      END IF
      #同步附件
      EXECUTE azzi932_casefile_cnt_curs USING g_gzwi_m.gzwi001 INTO l_i   #取未同步的附件數量
      IF (NOT cl_null(g_gzwi_m.gzwi009)) AND l_i > 0 AND g_syncway <> " "
         AND g_syncway <> "alm" THEN                      #非產中
         CALL cl_set_act_visible("btn_casefile1", TRUE)
      ELSE
         CALL cl_set_act_visible("btn_casefile1", FALSE)
      END IF
   END IF
   ###161027-00047#1 END ###
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="azzi932.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION azzi932_default_search()
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
   DEFINE l_i        LIKE type_t.num10      #160606-00027#1
   DEFINE l_tok       base.StringTokenizer  #160606-00027#1
   DEFINE l_str       STRING                #160606-00027#1
   DEFINE l_wc        STRING                #160606-00027#1
   #end add-point  
   
   #add-point:Function前置處理 name="default_search.before"
 
   #end add-point  
   
   LET g_pagestart = 1
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " gzwi001 = '", g_argv[01], "' AND "
   END IF
   
 
   
   #add-point:default_search段after sql name="default_search.after_sql"
   #提供Q類程式以勾選的問題編號串查   #160606-00027#1
   LET l_str = g_argv[2]
   IF NOT cl_null(l_str) THEN
      LET l_tok = base.StringTokenizer.createExt(l_str CLIPPED,",","",TRUE)	#指定分隔符號
      LET l_i = 0
      WHILE l_tok.hasMoreTokens()	#依序取得子字串
         LET l_i = l_i + 1
         LET l_str = l_tok.nextToken()
         IF l_i = 1 THEN
            LET l_wc = " gzwi001 IN ('",l_str CLIPPED, "'"
         ELSE
            LET l_wc = l_wc CLIPPED,",'",l_str CLIPPED, "'"
         END IF
      END WHILE
      IF NOT cl_null(l_wc) THEN
         LET ls_wc = ls_wc CLIPPED,l_wc CLIPPED,") AND "
      END IF
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
               WHEN la_wc[li_idx].tableid = "gzwi_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "gzwj_t" 
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
 
{<section id="azzi932.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION azzi932_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_gzwi_m.gzwi001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN azzi932_cl USING g_gzwi_m.gzwi001
   IF STATUS THEN
      CLOSE azzi932_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN azzi932_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE azzi932_master_referesh USING g_gzwi_m.gzwi001 INTO g_gzwi_m.gzwi001,g_gzwi_m.gzwi002,g_gzwi_m.gzwi003, 
       g_gzwi_m.gzwi008,g_gzwi_m.gzwi010,g_gzwi_m.gzwi017,g_gzwi_m.gzwi004,g_gzwi_m.gzwi005,g_gzwi_m.gzwi013, 
       g_gzwi_m.gzwi006,g_gzwi_m.gzwi015,g_gzwi_m.gzwi016,g_gzwi_m.gzwi018,g_gzwi_m.gzwi007,g_gzwi_m.gzwi011, 
       g_gzwi_m.gzwi012,g_gzwi_m.gzwi027,g_gzwi_m.gzwi014,g_gzwi_m.gzwi009,g_gzwi_m.gzwi026,g_gzwi_m.gzwi019, 
       g_gzwi_m.gzwi020,g_gzwi_m.gzwi021,g_gzwi_m.gzwi022,g_gzwi_m.gzwi023,g_gzwi_m.gzwi024,g_gzwi_m.gzwi025, 
       g_gzwi_m.gzwi028,g_gzwi_m.gzwistus,g_gzwi_m.gzwiownid,g_gzwi_m.gzwiowndp,g_gzwi_m.gzwicrtid,g_gzwi_m.gzwicrtdp, 
       g_gzwi_m.gzwicrtdt,g_gzwi_m.gzwimodid,g_gzwi_m.gzwimoddt,g_gzwi_m.gzwi008_desc,g_gzwi_m.gzwi017_desc, 
       g_gzwi_m.gzwi005_desc,g_gzwi_m.gzwi006_desc,g_gzwi_m.gzwi007_desc,g_gzwi_m.gzwi028_desc,g_gzwi_m.gzwiownid_desc, 
       g_gzwi_m.gzwiowndp_desc,g_gzwi_m.gzwicrtid_desc,g_gzwi_m.gzwicrtdp_desc,g_gzwi_m.gzwimodid_desc 
 
   
 
   #檢查是否允許此動作
   IF NOT azzi932_action_chk() THEN
      CLOSE azzi932_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_gzwi_m.gzwi001,g_gzwi_m.gzwi002,g_gzwi_m.gzwi003,g_gzwi_m.gzwi008,g_gzwi_m.gzwi008_desc, 
       g_gzwi_m.gzwi010,g_gzwi_m.gzwi017,g_gzwi_m.gzwi017_desc,g_gzwi_m.gzwi004,g_gzwi_m.gzwi005,g_gzwi_m.gzwi005_desc, 
       g_gzwi_m.gzwi013,g_gzwi_m.gzwi006,g_gzwi_m.gzwi006_desc,g_gzwi_m.gzwi015,g_gzwi_m.gzwi016,g_gzwi_m.gzwi018, 
       g_gzwi_m.gzwi007_desc,g_gzwi_m.gzwi007,g_gzwi_m.gzwi011,g_gzwi_m.gzwi012,g_gzwi_m.gzwi027,g_gzwi_m.gzwi014, 
       g_gzwi_m.gzwi009,g_gzwi_m.gzwi026,g_gzwi_m.gzwi019,g_gzwi_m.gzwi020,g_gzwi_m.gzwi021,g_gzwi_m.gzwi022, 
       g_gzwi_m.gzwi023,g_gzwi_m.gzwi024,g_gzwi_m.gzwi025,g_gzwi_m.gzwi028,g_gzwi_m.gzwi028_desc,g_gzwi_m.gzwistus, 
       g_gzwi_m.gzwiownid,g_gzwi_m.gzwiownid_desc,g_gzwi_m.gzwiowndp,g_gzwi_m.gzwiowndp_desc,g_gzwi_m.gzwicrtid, 
       g_gzwi_m.gzwicrtid_desc,g_gzwi_m.gzwicrtdp,g_gzwi_m.gzwicrtdp_desc,g_gzwi_m.gzwicrtdt,g_gzwi_m.gzwimodid, 
       g_gzwi_m.gzwimodid_desc,g_gzwi_m.gzwimoddt
 
   CASE g_gzwi_m.gzwistus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_gzwi_m.gzwistus
            
            WHEN "N"
               HIDE OPTION "inactive"
            WHEN "Y"
               HIDE OPTION "active"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      
      #end add-point
      
      
	  
      ON ACTION inactive
         IF cl_auth_chk_act("inactive") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.inactive"
            
            #end add-point
         END IF
         EXIT MENU
      ON ACTION active
         IF cl_auth_chk_act("active") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.active"
            
            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"
      
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "N" 
      AND lc_state <> "Y"
      ) OR 
      g_gzwi_m.gzwistus = lc_state OR cl_null(lc_state) THEN
      CLOSE azzi932_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   
   #end add-point
   
   LET g_gzwi_m.gzwimodid = g_user
   LET g_gzwi_m.gzwimoddt = cl_get_current()
   LET g_gzwi_m.gzwistus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE gzwi_t 
      SET (gzwistus,gzwimodid,gzwimoddt) 
        = (g_gzwi_m.gzwistus,g_gzwi_m.gzwimodid,g_gzwi_m.gzwimoddt)     
    WHERE  gzwi001 = g_gzwi_m.gzwi001
 
    
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
   ELSE
      CASE lc_state
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/inactive.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/active.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE azzi932_master_referesh USING g_gzwi_m.gzwi001 INTO g_gzwi_m.gzwi001,g_gzwi_m.gzwi002, 
          g_gzwi_m.gzwi003,g_gzwi_m.gzwi008,g_gzwi_m.gzwi010,g_gzwi_m.gzwi017,g_gzwi_m.gzwi004,g_gzwi_m.gzwi005, 
          g_gzwi_m.gzwi013,g_gzwi_m.gzwi006,g_gzwi_m.gzwi015,g_gzwi_m.gzwi016,g_gzwi_m.gzwi018,g_gzwi_m.gzwi007, 
          g_gzwi_m.gzwi011,g_gzwi_m.gzwi012,g_gzwi_m.gzwi027,g_gzwi_m.gzwi014,g_gzwi_m.gzwi009,g_gzwi_m.gzwi026, 
          g_gzwi_m.gzwi019,g_gzwi_m.gzwi020,g_gzwi_m.gzwi021,g_gzwi_m.gzwi022,g_gzwi_m.gzwi023,g_gzwi_m.gzwi024, 
          g_gzwi_m.gzwi025,g_gzwi_m.gzwi028,g_gzwi_m.gzwistus,g_gzwi_m.gzwiownid,g_gzwi_m.gzwiowndp, 
          g_gzwi_m.gzwicrtid,g_gzwi_m.gzwicrtdp,g_gzwi_m.gzwicrtdt,g_gzwi_m.gzwimodid,g_gzwi_m.gzwimoddt, 
          g_gzwi_m.gzwi008_desc,g_gzwi_m.gzwi017_desc,g_gzwi_m.gzwi005_desc,g_gzwi_m.gzwi006_desc,g_gzwi_m.gzwi007_desc, 
          g_gzwi_m.gzwi028_desc,g_gzwi_m.gzwiownid_desc,g_gzwi_m.gzwiowndp_desc,g_gzwi_m.gzwicrtid_desc, 
          g_gzwi_m.gzwicrtdp_desc,g_gzwi_m.gzwimodid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_gzwi_m.gzwi001,g_gzwi_m.gzwi002,g_gzwi_m.gzwi003,g_gzwi_m.gzwi008,g_gzwi_m.gzwi008_desc, 
          g_gzwi_m.gzwi010,g_gzwi_m.gzwi017,g_gzwi_m.gzwi017_desc,g_gzwi_m.gzwi004,g_gzwi_m.gzwi005, 
          g_gzwi_m.gzwi005_desc,g_gzwi_m.gzwi013,g_gzwi_m.gzwi006,g_gzwi_m.gzwi006_desc,g_gzwi_m.gzwi015, 
          g_gzwi_m.gzwi016,g_gzwi_m.gzwi018,g_gzwi_m.gzwi007_desc,g_gzwi_m.gzwi007,g_gzwi_m.gzwi011, 
          g_gzwi_m.gzwi012,g_gzwi_m.gzwi027,g_gzwi_m.gzwi014,g_gzwi_m.gzwi009,g_gzwi_m.gzwi026,g_gzwi_m.gzwi019, 
          g_gzwi_m.gzwi020,g_gzwi_m.gzwi021,g_gzwi_m.gzwi022,g_gzwi_m.gzwi023,g_gzwi_m.gzwi024,g_gzwi_m.gzwi025, 
          g_gzwi_m.gzwi028,g_gzwi_m.gzwi028_desc,g_gzwi_m.gzwistus,g_gzwi_m.gzwiownid,g_gzwi_m.gzwiownid_desc, 
          g_gzwi_m.gzwiowndp,g_gzwi_m.gzwiowndp_desc,g_gzwi_m.gzwicrtid,g_gzwi_m.gzwicrtid_desc,g_gzwi_m.gzwicrtdp, 
          g_gzwi_m.gzwicrtdp_desc,g_gzwi_m.gzwicrtdt,g_gzwi_m.gzwimodid,g_gzwi_m.gzwimodid_desc,g_gzwi_m.gzwimoddt 
 
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE azzi932_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL azzi932_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="azzi932.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION azzi932_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_gzwj_d.getLength() THEN
         LET g_detail_idx = g_gzwj_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_gzwj_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_gzwj_d.getLength() TO FORMONLY.cnt
   END IF
   
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   #換頁時就讓單身指標正確,不要等到點單身才取正確的指標
   LET l_ac = g_detail_idx              #161027-00047#1
   CALL azzi932_set_act_visible_b()     #161027-00047#1
   CALL azzi932_set_act_no_visible_b()  #161027-00047#1
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="azzi932.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION azzi932_b_fill2(pi_idx)
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
   
   CALL azzi932_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="azzi932.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION azzi932_fill_chk(ps_idx)
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
 
{<section id="azzi932.status_show" >}
PRIVATE FUNCTION azzi932_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="azzi932.mask_functions" >}
&include "erp/azz/azzi932_mask.4gl"
 
{</section>}
 
{<section id="azzi932.signature" >}
   
 
{</section>}
 
{<section id="azzi932.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION azzi932_set_pk_array()
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
   LET g_pk_array[1].values = g_gzwi_m.gzwi001
   LET g_pk_array[1].column = 'gzwi001'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="azzi932.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="azzi932.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION azzi932_msgcentre_notify(lc_state)
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
   CALL azzi932_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_gzwi_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="azzi932.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION azzi932_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="azzi932.other_function" readonly="Y" >}

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
# Modify.........: No.160606-00027#1  2016/06/06 By tsai_yen 非第一次寄的mail，主旨加上"RE: "
################################################################################
PRIVATE FUNCTION azzi932_send_mail()
   DEFINE l_chk          BOOLEAN

   LET g_gzwi_inc.gzwi001        = g_gzwi_m.gzwi001          #問題編號
   LET g_gzwi_inc.gzwi002        = g_gzwi_m.gzwi002          #類別
   LET g_gzwi_inc.gzwi003        = g_gzwi_m.gzwi003          #模組
   LET g_gzwi_inc.gzwi004        = g_gzwi_m.gzwi004          #問題描述
   LET g_gzwi_inc.gzwi005        = g_gzwi_m.gzwi005          #反映人員
   LET g_gzwi_inc.gzwi006        = g_gzwi_m.gzwi006          #反映人員營運據點
   LET g_gzwi_inc.gzwi007        = g_gzwi_m.gzwi007          #處理人員
   LET g_gzwi_inc.gzwi008        = g_gzwi_m.gzwi008          #作業編號
   LET g_gzwi_inc.gzwi009        = g_gzwi_m.gzwi009          #案件代號
   LET g_gzwi_inc.gzwi010        = g_gzwi_m.gzwi010          #緊急案件
   LET g_gzwi_inc.gzwi011        = g_gzwi_m.gzwi011          #處理狀態
   LET g_gzwi_inc.gzwi012        = g_gzwi_m.gzwi012          #更新摘要
   LET g_gzwi_inc.gzwi013        = g_gzwi_m.gzwi013          #反應日期
   LET g_gzwi_inc.gzwi014        = g_gzwi_m.gzwi014          #負責單位:1.MIS 2.E-Service
   LET g_gzwi_inc.gzwi015        = g_gzwi_m.gzwi015          #處理人員類型,聯絡對象類型oofa002
   LET g_gzwi_inc.gzwi016        = g_gzwi_m.gzwi016          #流水號
   LET g_gzwi_inc.gzwi017        = g_gzwi_m.gzwi017          #反映企業代碼
   LET g_gzwi_inc.gzwi018        = g_gzwi_m.gzwi018          #處理人員,聯絡對象代碼一oofa003
   LET g_gzwi_inc.gzwi025        = g_gzwi_m.gzwi025          #確認書編號
   LET g_gzwi_inc.gzwi026        = g_gzwi_m.gzwi026          #最近同步時間
   LET g_gzwi_inc.gzwi027        = g_gzwi_m.gzwi027          #案件歷程
   LET g_gzwi_inc.gzwi028        = g_gzwi_m.gzwi028          #客戶代號
   LET g_gzwi_inc.gzwistus       = g_gzwi_m.gzwistus         #狀態碼
   LET g_gzwi_inc.gzwiownid      = g_gzwi_m.gzwiownid        #資料所有者
   LET g_gzwi_inc.gzwiowndp      = g_gzwi_m.gzwiowndp        #資料所屬部門
   LET g_gzwi_inc.gzwicrtid      = g_gzwi_m.gzwicrtid        #資料建立者
   LET g_gzwi_inc.gzwicrtdp      = g_gzwi_m.gzwicrtdp        #資料建立部門
   LET g_gzwi_inc.gzwicrtdt      = g_gzwi_m.gzwicrtdt        #資料創建日
   LET g_gzwi_inc.gzwimodid      = g_gzwi_m.gzwimodid        #資料修改者
   LET g_gzwi_inc.gzwimoddt      = g_gzwi_m.gzwimoddt        #最近修改日

   CALL cl_helps932_send_mailpre("RE",g_enterprise,g_gzwi_inc.*) RETURNING l_chk   #160606-00027#1
END FUNCTION

################################################################################
# Descriptions...: 合併顯示更新摘要和案件歷程
# Memo...........:
# Usage..........: CALL azzi932_showcourse(p_gzwi012,p_gzwi027)
#                  RETURNING void
# Input parameter: p_gzwi012     更新摘要
#                : p_gzwi027     案件歷程
# Return code....: 
#                : 
# Date & Author..: 2015/06/05 By tsai_yen
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi932_showcourse(p_gzwi012,p_gzwi027)
   DEFINE p_gzwi012   LIKE gzwi_t.gzwi012   #更新摘要
   DEFINE p_gzwi027   LIKE gzwi_t.gzwi027   #案件歷程
   DEFINE l_gzwi012   LIKE gzwi_t.gzwi012   #更新摘要+案件歷程
   
   CALL cl_helps932_course(p_gzwi012,p_gzwi027) RETURNING l_gzwi012
   DISPLAY l_gzwi012 TO gzwi012
END FUNCTION

 
{</section>}
 
