#該程式未解開Section, 採用最新樣板產出!
{<section id="azzq932.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:5(2016-10-03 09:45:04), PR版次:0005(2017-02-06 13:41:41)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000022
#+ Filename...: azzq932
#+ Description: 問題管制表查詢作業
#+ Creator....: 08146(2016-07-22 16:57:37)
#+ Modifier...: 08146 -SD/PR- 01101
 
{</section>}
 
{<section id="azzq932.global" >}
#應用 q02 樣板自動產生(Version:42)
#add-point:填寫註解說明 name="global.memo"
#               此程式欄位增減時,都要檢查 "#手動維護" 的部分
#+ Creator....: 2016/07/25 By frank0521 No.160721-00022#1 問題管制表查詢作業.
#+ Modifier...: No.160822-00010#1 2016/08/25 By frank0521 批次更新案件,批次反映鼎新
#+ Modifier...: No.161012-00007#1 2016/10/12 By tsai_yen 限制反映人員不可使用特殊員工編號
#+ Modifier...: No.161027-00047#1 2016/10/02 By tsai_yen 新增時,修改者和修改日為空
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
#add-point:增加匯入項目 name="global.import"
IMPORT JAVA java.io.InputStream                             #160822-00010#1
IMPORT JAVA java.io.FileInputStream                         #160822-00010#1
IMPORT JAVA java.io.FileOutputStream                        #160822-00010#1
IMPORT JAVA org.apache.poi.hssf.usermodel.HSSFWorkbook      #160822-00010#1
IMPORT JAVA org.apache.poi.hssf.usermodel.HSSFSheet         #160822-00010#1
IMPORT JAVA org.apache.poi.hssf.usermodel.HSSFRow           #160822-00010#1
IMPORT JAVA org.apache.poi.hssf.usermodel.HSSFCell          #160822-00010#1
IMPORT JAVA org.apache.poi.hssf.usermodel.HSSFCellStyle     #160822-00010#1
IMPORT JAVA org.apache.poi.hssf.usermodel.HSSFFont          #160822-00010#1
IMPORT JAVA org.apache.poi.hssf.usermodel.HSSFDataFormat    #160822-00010#1
IMPORT JAVA org.apache.poi.ss.usermodel.IndexedColors       #160822-00010#1
IMPORT JAVA org.apache.poi.ss.usermodel.Workbook            #160822-00010#1
IMPORT JAVA org.apache.poi.ss.usermodel.Cell                #160822-00010#1
IMPORT JAVA org.apache.poi.ss.usermodel.Row                 #160822-00010#1
IMPORT JAVA org.apache.poi.ss.usermodel.Sheet               #160822-00010#1
IMPORT JAVA org.apache.poi.ss.usermodel.Workbook            #160822-00010#1
IMPORT JAVA org.apache.poi.xssf.usermodel.XSSFWorkbook      #160822-00010#1
IMPORT JAVA org.apache.poi.xssf.usermodel.XSSFSheet         #160822-00010#1
IMPORT JAVA org.apache.poi.xssf.usermodel.XSSFRow           #160822-00010#1
IMPORT JAVA org.apache.poi.xssf.usermodel.XSSFCell          #160822-00010#1
IMPORT JAVA org.apache.poi.xssf.usermodel.XSSFCellStyle     #160822-00010#1
IMPORT JAVA org.apache.poi.xssf.usermodel.XSSFFont          #160822-00010#1
IMPORT JAVA org.apache.poi.xssf.usermodel.XSSFDataFormat    #160822-00010#1
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_gzwi_d RECORD
       #statepic       LIKE type_t.chr1,
       
       sel LIKE type_t.chr1, 
   gzwi001 LIKE gzwi_t.gzwi001, 
   gzwi004 LIKE gzwi_t.gzwi004, 
   gzwi012 LIKE gzwi_t.gzwi012, 
   gzwi013 LIKE gzwi_t.gzwi013, 
   gzwi005 LIKE gzwi_t.gzwi005, 
   gzwi005_desc LIKE type_t.chr500, 
   gzwi008 LIKE gzwi_t.gzwi008, 
   gzwi008_desc LIKE type_t.chr500, 
   gzwi003 LIKE gzwi_t.gzwi003, 
   gzwi011 LIKE gzwi_t.gzwi011, 
   gzwi009 LIKE gzwi_t.gzwi009, 
   gzwi002 LIKE gzwi_t.gzwi002, 
   gzwi010 LIKE gzwi_t.gzwi010, 
   gzwi022 LIKE gzwi_t.gzwi022, 
   gzwi017 LIKE gzwi_t.gzwi017, 
   gzwi006 LIKE gzwi_t.gzwi006, 
   gzwistus LIKE gzwi_t.gzwistus 
       END RECORD
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
###160822-00010#1 START###
TYPE type_g_gzwi_excel        RECORD        #問題反映 excel匯入
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
   gzwi019 LIKE gzwi_t.gzwi019,             #規格預計完成日
   gzwi020 LIKE gzwi_t.gzwi020,             #規格實際完成日
   gzwi021 LIKE gzwi_t.gzwi021,             #預計完成日
   gzwi022 LIKE gzwi_t.gzwi022,             #實際完成日
   gzwi023 LIKE gzwi_t.gzwi023,             #預估實數
   gzwi024 LIKE gzwi_t.gzwi024,             #實際實數
   gzwi025 LIKE gzwi_t.gzwi025,             #確認書編號
   gzwi026 LIKE gzwi_t.gzwi026,             #最近同步時間
   gzwi027 LIKE gzwi_t.gzwi027,             #案件歷程
   gzwi028 LIKE gzwi_t.gzwi028,             #客戶代號
   gzwistus LIKE gzwi_t.gzwistus,           #狀態碼
   gzwiownid LIKE gzwi_t.gzwiownid,         #資料所有者
   gzwiowndp LIKE gzwi_t.gzwiowndp,         #資料所屬部門
   gzwicrtid LIKE gzwi_t.gzwicrtid,         #資料建立者
   gzwicrtdp LIKE gzwi_t.gzwicrtdp,         #資料建立部門
   gzwicrtdt DATETIME YEAR TO SECOND,       #資料創建日
   gzwimodid LIKE gzwi_t.gzwimodid,         #資料修改者
   gzwimoddt DATETIME YEAR TO SECOND,       #最近修改日
   gzwi005_desc LIKE type_t.chr80,          #反映人員名稱
   gzwi005dp_desc LIKE type_t.chr80,        #反映人員部門名稱
   gzwi005op_desc LIKE type_t.chr80        #反映人員營運據點名稱
   END RECORD

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
   
DEFINE g_oofa_sel DYNAMIC ARRAY OF RECORD     #聯絡對象檔資料,與cl_helps932,cl_helps932,azzi932,azzi931,azzq932共用
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


DEFINE g_syncway             STRING           #與服務平台同步方式 alm,almhelp,eservice
###160822-00010#1 END###
#end add-point
 
#模組變數(Module Variables)
DEFINE g_master                     type_g_gzwi_d
DEFINE g_master_t                   type_g_gzwi_d
DEFINE g_gzwi_d          DYNAMIC ARRAY OF type_g_gzwi_d
DEFINE g_gzwi_d_t        type_g_gzwi_d
 
      
DEFINE g_wc                 STRING
DEFINE g_wc_t               STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                STRING
DEFINE g_wc_filter          STRING
DEFINE g_wc_filter_t        STRING
DEFINE g_sql                STRING
DEFINE g_forupd_sql         STRING                        #SELECT ... FOR UPDATE SQL
DEFINE g_before_input_done  LIKE type_t.num5
DEFINE g_cnt                LIKE type_t.num10    
DEFINE l_ac                 LIKE type_t.num10              
DEFINE l_ac_d               LIKE type_t.num10              #單身idx 
DEFINE g_curr_diag          ui.Dialog                     #Current Dialog
DEFINE gwin_curr            ui.Window                     #Current Window
DEFINE gfrm_curr            ui.Form                       #Current Form
DEFINE g_current_page       LIKE type_t.num5              #目前所在頁數
DEFINE g_detail_cnt         LIKE type_t.num10             #單身 總筆數(所有資料)
DEFINE g_detail_cnt2        LIKE type_t.num10             #單身 總筆數(所有資料)
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars           DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys              DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak          DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE g_insert             LIKE type_t.chr5              #是否導到其他page
DEFINE g_error_show         LIKE type_t.num5
DEFINE g_master_idx         LIKE type_t.num10
DEFINE g_detail_idx         LIKE type_t.num10
DEFINE g_detail_idx2        LIKE type_t.num10
DEFINE g_hyper_url          STRING                        #hyperlink的主要網址
DEFINE g_tot_cnt            LIKE type_t.num10             #計算總筆數
DEFINE g_num_in_page        LIKE type_t.num10             #每頁筆數
DEFINE g_current_row_tot    LIKE type_t.num10             #目前所在總筆數
DEFINE g_page_act_list      STRING                        #分頁ACTION清單
DEFINE g_page_start_num     LIKE type_t.num10             #目前頁面起始筆數
DEFINE g_page_end_num       LIKE type_t.num10             #目前頁面結束筆數
 
#多table用wc
DEFINE g_wc_table           STRING
DEFINE g_wc_filter_table    STRING
DEFINE g_detail_page_action STRING
DEFINE g_pagestart          LIKE type_t.num10
 
 
 
#add-point:自定義模組變數-客製(Module Variable) name="global.variable_customerization"

##end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="azzq932.main" >}
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
   CALL cl_ap_init("azz","")
 
   #add-point:作業初始化 name="main.init"
   CALL cl_helps932_syncway() RETURNING g_syncway
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " ", 
                      " FROM ",
                      " "
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE azzq932_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE azzq932_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE azzq932_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_azzq932 WITH FORM cl_ap_formpath("azz",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL azzq932_init()   
 
      #進入選單 Menu (="N")
      CALL azzq932_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_azzq932
      
   END IF 
   
   CLOSE azzq932_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="azzq932.init" >}
#+ 畫面資料初始化
PRIVATE FUNCTION azzq932_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
 
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="init.before_function"
 
   #end add-point
 
   LET g_error_show  = 1
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1"
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   
      CALL cl_set_combo_scc('b_gzwi011','147') 
   CALL cl_set_combo_scc('b_gzwi002','140') 
 
   
   #add-point:畫面資料初始化 name="init.init"
   CALL cl_set_combo_module("b_gzwi003",1)
   CALL cl_show_fld_cont()
   CALL cl_set_comp_entry("b_gzwi005_desc",TRUE)
   #end add-point
 
   CALL azzq932_default_search()  
END FUNCTION
 
{</section>}
 
{<section id="azzq932.default_search" >}
PRIVATE FUNCTION azzq932_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " gzwi001 = '", g_argv[01], "' AND "
   END IF
 
 
 
 
 
 
 
   IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc.subString(1,g_wc.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc = " 1=2"
   END IF
 
   #add-point:default_search段開始後 name="default_search.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="azzq932.ui_dialog" >}
#+ 功能選單 
PRIVATE FUNCTION azzq932_ui_dialog()
   #add-point:ui_dialog段define-客製 name="ui_dialog.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      STRING
   DEFINE li_idx     LIKE type_t.num10
   DEFINE lc_action_choice_old     STRING
   DEFINE lc_current_row           LIKE type_t.num10
   DEFINE ls_js      STRING
   DEFINE la_param   RECORD
                     prog       STRING,
                     actionid   STRING,
                     background LIKE type_t.chr1,
                     param      DYNAMIC ARRAY OF STRING
                     END RECORD
   #add-point:ui_dialog段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   DEFINE l_new_path        STRING                                              #160822-00010#1
   DEFINE l_i               LIKE type_t.num10
   DEFINE l_chk             BOOLEAN                                             #是否成功
   DEFINE l_colname         STRING
   DEFINE l_comment         STRING
   DEFINE l_caseidlist      DYNAMIC ARRAY OF RECORD  #案件清單                   #160822-00010#1 
          gzwi001  LIKE gzwi_t.gzwi001,
          gzwi011  LIKE gzwi_t.gzwi011,
          caseid   LIKE gzwi_t.gzwi009
          END RECORD
   DEFINE l_syncold         DYNAMIC ARRAY OF type_g_gzwo_inc                     #160822-00010#1 
   DEFINE l_mail_chk        BOOLEAN
   DEFINE l_gzwo_m DYNAMIC ARRAY OF RECORD                                      #接收反映鼎新後的資料
      l_chk      BOOLEAN,
      gzwo001    LIKE gzwo_t.gzwo001,
      gzwo009    LIKE gzwo_t.gzwo009,
      gzwo014    LIKE gzwo_t.gzwo014,
      gzwomodid  LIKE gzwo_t.gzwomodid ,
      gzwomoddt  LIKE gzwo_t.gzwomoddt
      END RECORD
   DEFINE l_sample_file_path STRING                                              #EXCEL範本路徑
   DEFINE l_sample_file      STRING
   DEFINE l_target           STRING
   DEFINE l_url              STRING
   DEFINE li_stat            LIKE type_t.num5
   DEFINE l_server_uri       STRING                                              #azzs010設定:Help 接口網址 (產中:型管/客戶:服管)
   #end add-point 
 
   #add-point:FUNCTION前置處理 name="ui_dialog.before_function"
   
   #end add-point
 
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   LET g_action_choice = " "
   LET lc_action_choice_old = ""
   CALL cl_set_act_visible("accept,cancel", FALSE)
   CALL cl_get_num_in_page() RETURNING g_num_in_page
         
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
 
   LET g_detail_page_action = "detail_first"
   LET g_pagestart = 1
   LET g_current_row_tot = 1
   LET g_page_start_num = 1
   LET g_page_end_num = g_num_in_page
   IF NOT cl_null(g_wc) AND g_wc != " 1=2" THEN
      LET g_detail_idx = 1
      LET g_detail_idx2 = 1
      CALL azzq932_b_fill()
   ELSE
      CALL azzq932_query()
   END IF
   
   WHILE TRUE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_gzwi_d.clear()
 
         LET g_wc  = " 1=2"
         LET g_wc2 = " 1=1"
         LET g_action_choice = ""
         LET g_detail_page_action = "detail_first"
         LET g_pagestart = 1
         LET g_current_row_tot = 1
         LET g_page_start_num = 1
         LET g_page_end_num = g_num_in_page
         LET g_detail_idx = 1
         LET g_detail_idx2 = 1
 
         CALL azzq932_init()
      END IF
   
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         DISPLAY ARRAY g_gzwi_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
 
               #為避免按上下筆影響執行效能，所以有作一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL azzq932_fetch()
               LET g_action_choice = lc_action_choice_old
               LET g_master_idx = l_ac
               CALL azzq932_detail_action_trans()
               #add-point:input段before row name="input.body.before_row"
               CALL azzq932_show_fld_cont()
               #end add-point  
            
            #自訂ACTION(detail_show,page_1)
            
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
      
 
         
 
      
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
         
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL azzq932_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL azzq932_show_fld_cont()
            
            CASE #與服務平台同步方式 alm,almhelp,eservice
               WHEN g_syncway = "alm" 
                  #改按鈕文字
                  CALL s_azzi902_get_gzzd("azzq932","lbl_batch_helptoalm") RETURNING l_colname, l_comment
                  CALL gfrm_curr.setElementText("batch_helptoalm", l_colname)
                  #隱藏按鈕
                  CALL cl_set_act_visible("helpcase", FALSE)        
                  CALL gfrm_curr.setElementHidden("helpcase",TRUE)  
            END CASE

            ###160822-00010#1  strat ###
            #/u1/t10dev/www/doc/erp/模組/語言別/作業編號/file/azzq932_s_語言別_excel_sample.xlsx
            LET l_sample_file = g_prog CLIPPED,"_s_",g_lang CLIPPED,"_excel_sample.xlsx"
            LET l_sample_file_path = FGL_GETENV("TOP")
            LET l_sample_file_path = os.Path.join(l_sample_file_path, "www")
            LET l_sample_file_path = os.Path.join(l_sample_file_path, "doc")
            LET l_sample_file_path = os.Path.join(l_sample_file_path, "erp")
            LET l_sample_file_path = os.Path.join(l_sample_file_path, "azz")
            LET l_sample_file_path = os.Path.join(l_sample_file_path, g_lang)
            LET l_sample_file_path = os.Path.join(l_sample_file_path, g_prog)
            LET l_sample_file_path = os.Path.join(l_sample_file_path, "file")
            LET l_sample_file_path = os.Path.join(l_sample_file_path, l_sample_file)
            IF (NOT os.Path.exists(l_sample_file_path)) AND g_lang <> "en_US" THEN
               LET l_sample_file = g_prog CLIPPED,"_s_","en_US","_excel_sample.xlsx"
               LET l_sample_file_path = FGL_GETENV("TOP")
               LET l_sample_file_path = os.Path.join(l_sample_file_path, "www")
               LET l_sample_file_path = os.Path.join(l_sample_file_path, "doc")
               LET l_sample_file_path = os.Path.join(l_sample_file_path, "erp")
               LET l_sample_file_path = os.Path.join(l_sample_file_path, "azz")
               LET l_sample_file_path = os.Path.join(l_sample_file_path, "en_US")
               LET l_sample_file_path = os.Path.join(l_sample_file_path, g_prog)
               LET l_sample_file_path = os.Path.join(l_sample_file_path, "file")
               LET l_sample_file_path = os.Path.join(l_sample_file_path, l_sample_file)
            END IF
            
            IF os.Path.exists(l_sample_file_path) THEN
               CALL cl_set_act_visible("import_excel", TRUE)        
               CALL gfrm_curr.setElementHidden("import_excel",FALSE)
               CALL cl_set_act_visible("excel_sample", TRUE)        
               CALL gfrm_curr.setElementHidden("excel_sample",FALSE)               
            ELSE
               CALL cl_set_act_visible("import_excel", FALSE)        
               CALL gfrm_curr.setElementHidden("import_excel",TRUE)
               CALL cl_set_act_visible("excel_sample", FALSE)        
               CALL gfrm_curr.setElementHidden("excel_sample",TRUE)
            END IF
            
            LET l_server_uri = cl_get_para(g_enterprise,"",'A-SYS-0039')   #Help 接口網址
            IF cl_null(l_server_uri) THEN
               CALL cl_set_act_visible("batch_helptoalm", FALSE)
               CALL gfrm_curr.setElementHidden("batch_helptoalm",1)
               CALL cl_set_act_visible("helpcase", FALSE)   
               CALL gfrm_curr.setElementHidden("helpcase",1)
            END IF
            ###160822-00010#1  end   ###
            #end add-point
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION import_excel
            LET g_action_choice="import_excel"
            IF cl_auth_chk_act("import_excel") THEN
               
               #add-point:ON ACTION import_excel name="menu.import_excel"
               CALL azzq932_import_file() RETURNING l_chk, l_new_path
               
               IF l_chk THEN
                  IF azzq932_imp_excel(l_new_path) THEN
                     #將匯入的資料顯示出來
                     CALL azzq932_b_fill()
                  END IF
               END IF
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION excel_sample
            LET g_action_choice="excel_sample"
            IF cl_auth_chk_act("excel_sample") THEN
               
               #add-point:ON ACTION excel_sample name="menu.excel_sample"
               CALL cl_helps932_gen_url("www",l_sample_file_path) RETURNING l_url
               IF NOT cl_null(l_url) THEN
                  CALL ui.Interface.frontCall( "standard", "launchurl", [l_url], [li_stat] )
               END IF
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL azzq932_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN
               
               #add-point:ON ACTION datainfo name="menu.datainfo"
               #詳細資料,以勾選的問題編號串查
               INITIALIZE la_param.* TO NULL
               LET la_param.prog = "azzi932"       #要執行的程式
               LET la_param.param[1] = ""          #問題編號
               LET la_param.param[2] = ""
               
               FOR li_idx = 1 TO g_gzwi_d.getLength()
                  IF g_gzwi_d[li_idx].sel == 'Y' THEN
                     LET la_param.param[2] = la_param.param[2] CLIPPED,",",g_gzwi_d[li_idx].gzwi001  CLIPPED   #勾選的多筆問題編號
                     
                  END IF
               END FOR
               #檢查是否有勾選資料
               IF cl_null(la_param.param[2]) THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "azz-01128" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
               ELSE
                  LET ls_js = util.JSON.stringify( la_param )
                  CALL cl_cmdrun(ls_js)
               END IF
               
               
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION batch_helptoalm
            LET g_action_choice="batch_helptoalm"
            IF cl_auth_chk_act("batch_helptoalm") THEN
               
               #add-point:ON ACTION batch_helptoalm name="menu.batch_helptoalm"
               IF g_gzwi_d.getLength() > 0 THEN  
                  LET l_i = 0               
                  LET g_sql = 'SELECT gzwiownid,gzwiowndp,gzwicrtid,gzwicrtdp,gzwicrtdt,gzwimodid,gzwimoddt,gzwistus,',
                              '       gzwi001,gzwi002,gzwi003,gzwi004,gzwi005,gzwi006,gzwi007,gzwi008,gzwi009,gzwi010,',
                              '       gzwi011,gzwi012,gzwi013,gzwi014,gzwi015,gzwi016,gzwi017,gzwi018,gzwi019,gzwi020,',
                              '       gzwi021,gzwi022,gzwi023,gzwi024,gzwi025,gzwi026,gzwi027,gzwi028',
                              '  FROM gzwi_t',
                              ' WHERE gzwi001 = ?'
                  PREPARE azzq932_batch_helptoalm_pre FROM g_sql
                  CALL l_syncold.clear()

                  FOR lc_current_row = 1 TO g_gzwi_d.getLength()
                     IF  (g_gzwi_d[lc_current_row].sel = 'Y') THEN
                        LET l_i = l_i + 1
                        
                        EXECUTE azzq932_batch_helptoalm_pre USING g_gzwi_d[lc_current_row].gzwi001
                           INTO l_syncold[l_i].gzwoownid,l_syncold[l_i].gzwoowndp,l_syncold[l_i].gzwocrtid,l_syncold[l_i].gzwocrtdp,
                                l_syncold[l_i].gzwocrtdt,l_syncold[l_i].gzwomodid,l_syncold[l_i].gzwomoddt,l_syncold[l_i].gzwostus,
                                l_syncold[l_i].gzwo001,l_syncold[l_i].gzwo002,l_syncold[l_i].gzwo003,l_syncold[l_i].gzwo004,l_syncold[l_i].gzwo005,
                                l_syncold[l_i].gzwo006,l_syncold[l_i].gzwo007,l_syncold[l_i].gzwo008,l_syncold[l_i].gzwo009,l_syncold[l_i].gzwo010,
                                l_syncold[l_i].gzwo011,l_syncold[l_i].gzwo012,l_syncold[l_i].gzwo013,l_syncold[l_i].gzwo014,l_syncold[l_i].gzwo015,
                                l_syncold[l_i].gzwo016,l_syncold[l_i].gzwo017,l_syncold[l_i].gzwo018,l_syncold[l_i].gzwo019,l_syncold[l_i].gzwo020,
                                l_syncold[l_i].gzwo021,l_syncold[l_i].gzwo022,l_syncold[l_i].gzwo023,l_syncold[l_i].gzwo024,l_syncold[l_i].gzwo025,
                                l_syncold[l_i].gzwo026,l_syncold[l_i].gzwo027,l_syncold[l_i].gzwo028
                     END IF
                  END FOR

                  IF l_i > 0 THEN
#                     #詢問是否寄送mail
#                     IF cl_ask_confirm("azz-01156") THEN
#                        LET l_mail_chk = TRUE
#                     ELSE
#                        LET l_mail_chk = FALSE
#                     END IF
                     CALL cl_helps932_sync_batch(TRUE,TRUE,l_syncold) RETURNING l_gzwo_m
                     #先設定重Q
                     CALL azzq932_b_fill()
                     
                  ELSE
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "azz-01128"   
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  END IF
               ELSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "azz-01128"   
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               END IF
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query_detail
            LET g_action_choice="query_detail"
            IF cl_auth_chk_act("query_detail") THEN
               
               #add-point:ON ACTION query_detail name="menu.query_detail"
               INITIALIZE la_param.* TO NULL
               LET la_param.prog = "azzi932"       #要執行的程式
               LET la_param.param[1] = ""          #問題編號
               LET la_param.param[2] = g_gzwi_d[l_ac].gzwi001
               
               #檢查是否有勾選資料
               IF cl_null(la_param.param[2]) THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "" 
                  LET g_errparam.code   = "azz-01128" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
               ELSE
                  LET ls_js = util.JSON.stringify( la_param )
                  CALL cl_cmdrun(ls_js)
               END IF
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION helpcase
            LET g_action_choice="helpcase"
            IF cl_auth_chk_act("helpcase") THEN
               
               #add-point:ON ACTION helpcase name="menu.helpcase"
               ###160822-00010#1  START###
               CALL l_caseidlist.clear()
               LET l_i = 0
               IF g_gzwi_d.getLength() > 0 THEN
                  FOR lc_current_row = 1 TO g_gzwi_d.getLength()
                     IF  (g_gzwi_d[lc_current_row].sel = 'Y') THEN
                        LET l_i = l_i + 1
                        LET l_caseidlist[l_i].caseid = g_gzwi_d[lc_current_row].gzwi009
                        LET l_caseidlist[l_i].gzwi001 = g_gzwi_d[lc_current_row].gzwi001
                        LET l_caseidlist[l_i].gzwi011 = g_gzwi_d[lc_current_row].gzwi011
                     END IF
                  END FOR
                  IF l_i > 0 THEN
                     IF cl_ask_confirm("azz-01156") THEN   #160804-00001#1 
                        LET l_mail_chk = TRUE              #160804-00001#1 
                     ELSE                                  #160804-00001#1 
                        LET l_mail_chk = FALSE             #160804-00001#1 
                     END IF                                #160804-00001#1 
                     CALL cl_helps932_helpcase(l_caseidlist,l_mail_chk)   #批次更新案件
                     CALL azzq932_b_fill()
                  ELSE
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "azz-01128"   
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  END IF
               ELSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "azz-01128"   
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               END IF
               ###160822-00010#1  END###
               #END add-point
               
               
            END IF
 
 
 
 
      
         ON ACTION filter
            LET g_action_choice="filter"
            CALL azzq932_filter()
            #add-point:ON ACTION filter name="menu.filter"
            
            #END add-point
 
         ON ACTION close
            LET INT_FLAG=FALSE         
            LET g_action_choice = "exit"
            EXIT DIALOG
 
         ON ACTION exit
            LET g_action_choice="exit"
            EXIT DIALOG
 
         ON ACTION datarefresh   # 重新整理
            LET g_error_show = 1
            CALL azzq932_b_fill()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_gzwi_d)
               LET g_export_id[1]   = "s_detail1"
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
 
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum name="ui_dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
 
         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            CALL azzq932_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL azzq932_b_fill()
 
         ON ACTION detail_next                #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL azzq932_b_fill()
 
         ON ACTION detail_last                #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL azzq932_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_gzwi_d.getLength()
               LET g_gzwi_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_gzwi_d.getLength()
               LET g_gzwi_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_gzwi_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_gzwi_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_gzwi_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_gzwi_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         
 
         #add-point:ui_dialog段自定義action name="ui_dialog.more_action"
         
         #end add-point
      
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
            CONTINUE DIALOG
 
         #add-point:查詢方案相關ACTION設定前 name="ui_dialog.set_qbe_action_before"
         
         #end add-point
 
         #add-point:查詢方案相關ACTION設定後 name="ui_dialog.set_qbe_action_after"
         
         #end add-point
      END DIALOG
      
      IF g_action_choice = "exit" AND NOT cl_null(g_action_choice) THEN
         EXIT WHILE
      END IF
      
   END WHILE
 
   CALL cl_set_act_visible("accept,cancel", TRUE)
 
END FUNCTION
 
{</section>}
 
{<section id="azzq932.query" >}
#+ QBE資料查詢
PRIVATE FUNCTION azzq932_query()
   #add-point:query段define-客製 name="query.define_customerization"
   
   #end add-point 
   DEFINE ls_wc      LIKE type_t.chr500
   DEFINE ls_wc2     LIKE type_t.chr500
   DEFINE ls_return  STRING
   DEFINE ls_result  STRING 
   #add-point:query段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   DEFINE l_colname         STRING
   DEFINE l_comment         STRING
   #end add-point 
   
   #add-point:FUNCTION前置處理 name="query.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
   CLEAR FORM
   CALL g_gzwi_d.clear()
 
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
   
   LET g_qryparam.state = "c"
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   LET g_wc_filter = " 1=1"
   LET g_detail_page_action = ""
   LET g_pagestart = 1
   
   #wc備份
   LET ls_wc = g_wc
   LET ls_wc2 = g_wc2
   LET g_master_idx = l_ac
 
   
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單身根據table分拆construct
      CONSTRUCT g_wc_table ON gzwi001,gzwi004,gzwi012,gzwi013,gzwi005,gzwi008,gzwi003,gzwi011,gzwi009, 
          gzwi002,gzwi010,gzwi022,gzwi017,gzwi006,gzwistus
           FROM s_detail1[1].b_gzwi001,s_detail1[1].b_gzwi004,s_detail1[1].b_gzwi012,s_detail1[1].b_gzwi013, 
               s_detail1[1].b_gzwi005,s_detail1[1].b_gzwi008,s_detail1[1].b_gzwi003,s_detail1[1].b_gzwi011, 
               s_detail1[1].b_gzwi009,s_detail1[1].b_gzwi002,s_detail1[1].b_gzwi010,s_detail1[1].b_gzwi022, 
               s_detail1[1].b_gzwi017,s_detail1[1].b_gzwi006,s_detail1[1].b_gzwistus
                      
         BEFORE CONSTRUCT
            #add-point:cs段more_construct name="cs.head.before_construct"
            CASE #與服務平台同步方式 alm,almhelp,eservice
               WHEN g_syncway = "alm" 
                  #改按鈕文字
                  CALL s_azzi902_get_gzzd("azzq932","lbl_batch_helptoalm") RETURNING l_colname, l_comment
                  CALL gfrm_curr.setElementText("batch_helptoalm", l_colname)
                  #隱藏按鈕
                  CALL cl_set_act_visible("helpcase", FALSE)        
                  CALL gfrm_curr.setElementHidden("helpcase",TRUE)  
            END CASE
            #end add-point 
            
       #單身公用欄位開窗相關處理
       #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<gzwicrtdt>>----
         #AFTER FIELD gzwicrtdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<gzwimoddt>>----
         #AFTER FIELD gzwimoddt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<gzwicnfdt>>----
         #AFTER FIELD gzwicnfdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<gzwipstdt>>----
         #AFTER FIELD gzwipstdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
         
       #單身一般欄位開窗相關處理
                #----<<sel>>----
         #----<<b_gzwi001>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_gzwi001
            #add-point:BEFORE FIELD b_gzwi001 name="construct.b.page1.b_gzwi001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_gzwi001
            
            #add-point:AFTER FIELD b_gzwi001 name="construct.a.page1.b_gzwi001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_gzwi001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gzwi001
            #add-point:ON ACTION controlp INFIELD b_gzwi001 name="construct.c.page1.b_gzwi001"
            
            #END add-point
 
 
         #----<<b_gzwi004>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_gzwi004
            #add-point:BEFORE FIELD b_gzwi004 name="construct.b.page1.b_gzwi004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_gzwi004
            
            #add-point:AFTER FIELD b_gzwi004 name="construct.a.page1.b_gzwi004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_gzwi004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gzwi004
            #add-point:ON ACTION controlp INFIELD b_gzwi004 name="construct.c.page1.b_gzwi004"
            
            #END add-point
 
 
         #----<<b_gzwi012>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_gzwi012
            #add-point:BEFORE FIELD b_gzwi012 name="construct.b.page1.b_gzwi012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_gzwi012
            
            #add-point:AFTER FIELD b_gzwi012 name="construct.a.page1.b_gzwi012"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_gzwi012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gzwi012
            #add-point:ON ACTION controlp INFIELD b_gzwi012 name="construct.c.page1.b_gzwi012"
            
            #END add-point
 
 
         #----<<b_gzwi013>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_gzwi013
            #add-point:BEFORE FIELD b_gzwi013 name="construct.b.page1.b_gzwi013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_gzwi013
            
            #add-point:AFTER FIELD b_gzwi013 name="construct.a.page1.b_gzwi013"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_gzwi013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gzwi013
            #add-point:ON ACTION controlp INFIELD b_gzwi013 name="construct.c.page1.b_gzwi013"
            
            #END add-point
 
 
         #----<<b_gzwi005>>----
         #Ctrlp:construct.c.page1.b_gzwi005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gzwi005
            #add-point:ON ACTION controlp INFIELD b_gzwi005 name="construct.c.page1.b_gzwi005"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_gzwi005  #顯示到畫面上
            LET g_gzwi_d[g_detail_idx].gzwi005 = g_qryparam.return1
            CALL s_desc_get_person_desc(g_gzwi_d[g_detail_idx].gzwi005) RETURNING g_gzwi_d[g_detail_idx].gzwi005_desc
            DISPLAY g_gzwi_d[g_detail_idx].gzwi005_desc TO b_gzwi005_desc
            NEXT FIELD b_gzwi005                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_gzwi005
            #add-point:BEFORE FIELD b_gzwi005 name="construct.b.page1.b_gzwi005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_gzwi005
            
            #add-point:AFTER FIELD b_gzwi005 name="construct.a.page1.b_gzwi005"
            CALL s_desc_get_person_desc(g_gzwi_d[g_detail_idx].gzwi005) RETURNING g_gzwi_d[g_detail_idx].gzwi005_desc
            DISPLAY g_gzwi_d[g_detail_idx].gzwi005_desc TO b_gzwi005_desc
            #END add-point
            
 
 
         #----<<b_gzwi005_desc>>----
         #----<<b_gzwi008>>----
         #Ctrlp:construct.c.page1.b_gzwi008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gzwi008
            #add-point:ON ACTION controlp INFIELD b_gzwi008 name="construct.c.page1.b_gzwi008"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_gzzz001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_gzwi008  #顯示到畫面上
            LET g_gzwi_d[g_detail_idx].gzwi008 = g_qryparam.return1
            CALL cl_get_progname(g_gzwi_d[g_detail_idx].gzwi008,g_lang,"1") RETURNING g_gzwi_d[g_detail_idx].gzwi008_desc 
            DISPLAY g_gzwi_d[g_detail_idx].gzwi008_desc TO b_gzwi008_desc
            NEXT FIELD b_gzwi008                     #返回原欄位

            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_gzwi008
            #add-point:BEFORE FIELD b_gzwi008 name="construct.b.page1.b_gzwi008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_gzwi008
            
            #add-point:AFTER FIELD b_gzwi008 name="construct.a.page1.b_gzwi008"
            CALL cl_get_progname(g_gzwi_d[g_detail_idx].gzwi008,g_lang,"1") RETURNING g_gzwi_d[g_detail_idx].gzwi008_desc 
            DISPLAY g_gzwi_d[g_detail_idx].gzwi008_desc TO b_gzwi008_desc
            #END add-point
            
 
 
         #----<<b_gzwi008_desc>>----
         #----<<b_gzwi003>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_gzwi003
            #add-point:BEFORE FIELD b_gzwi003 name="construct.b.page1.b_gzwi003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_gzwi003
            
            #add-point:AFTER FIELD b_gzwi003 name="construct.a.page1.b_gzwi003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_gzwi003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gzwi003
            #add-point:ON ACTION controlp INFIELD b_gzwi003 name="construct.c.page1.b_gzwi003"
            
            #END add-point
 
 
         #----<<b_gzwi011>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_gzwi011
            #add-point:BEFORE FIELD b_gzwi011 name="construct.b.page1.b_gzwi011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_gzwi011
            
            #add-point:AFTER FIELD b_gzwi011 name="construct.a.page1.b_gzwi011"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_gzwi011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gzwi011
            #add-point:ON ACTION controlp INFIELD b_gzwi011 name="construct.c.page1.b_gzwi011"
            
            #END add-point
 
 
         #----<<b_gzwi009>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_gzwi009
            #add-point:BEFORE FIELD b_gzwi009 name="construct.b.page1.b_gzwi009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_gzwi009
            
            #add-point:AFTER FIELD b_gzwi009 name="construct.a.page1.b_gzwi009"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_gzwi009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gzwi009
            #add-point:ON ACTION controlp INFIELD b_gzwi009 name="construct.c.page1.b_gzwi009"
            
            #END add-point
 
 
         #----<<b_gzwi002>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_gzwi002
            #add-point:BEFORE FIELD b_gzwi002 name="construct.b.page1.b_gzwi002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_gzwi002
            
            #add-point:AFTER FIELD b_gzwi002 name="construct.a.page1.b_gzwi002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_gzwi002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gzwi002
            #add-point:ON ACTION controlp INFIELD b_gzwi002 name="construct.c.page1.b_gzwi002"
            
            #END add-point
 
 
         #----<<b_gzwi010>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_gzwi010
            #add-point:BEFORE FIELD b_gzwi010 name="construct.b.page1.b_gzwi010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_gzwi010
            
            #add-point:AFTER FIELD b_gzwi010 name="construct.a.page1.b_gzwi010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_gzwi010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gzwi010
            #add-point:ON ACTION controlp INFIELD b_gzwi010 name="construct.c.page1.b_gzwi010"
            
            #END add-point
 
 
         #----<<b_gzwi022>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_gzwi022
            #add-point:BEFORE FIELD b_gzwi022 name="construct.b.page1.b_gzwi022"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_gzwi022
            
            #add-point:AFTER FIELD b_gzwi022 name="construct.a.page1.b_gzwi022"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_gzwi022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gzwi022
            #add-point:ON ACTION controlp INFIELD b_gzwi022 name="construct.c.page1.b_gzwi022"
            
            #END add-point
 
 
         #----<<b_gzwi017>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_gzwi017
            #add-point:BEFORE FIELD b_gzwi017 name="construct.b.page1.b_gzwi017"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_gzwi017
            
            #add-point:AFTER FIELD b_gzwi017 name="construct.a.page1.b_gzwi017"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_gzwi017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gzwi017
            #add-point:ON ACTION controlp INFIELD b_gzwi017 name="construct.c.page1.b_gzwi017"
            
            #END add-point
 
 
         #----<<b_gzwi006>>----
         #Ctrlp:construct.c.page1.b_gzwi006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gzwi006
            #add-point:ON ACTION controlp INFIELD b_gzwi006 name="construct.c.page1.b_gzwi006"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_gzwi006  #顯示到畫面上
            NEXT FIELD b_gzwi006                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_gzwi006
            #add-point:BEFORE FIELD b_gzwi006 name="construct.b.page1.b_gzwi006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_gzwi006
            
            #add-point:AFTER FIELD b_gzwi006 name="construct.a.page1.b_gzwi006"
            
            #END add-point
            
 
 
         #----<<b_gzwistus>>----
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD b_gzwistus
            #add-point:BEFORE FIELD b_gzwistus name="construct.b.page1.b_gzwistus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD b_gzwistus
            
            #add-point:AFTER FIELD b_gzwistus name="construct.a.page1.b_gzwistus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.b_gzwistus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gzwistus
            #add-point:ON ACTION controlp INFIELD b_gzwistus name="construct.c.page1.b_gzwistus"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
 
  
      #add-point:query段more_construct name="query.more_construct"
      
      #end add-point 
 
      ON ACTION accept
         #add-point:ON ACTION accept name="query.accept"
         
         #end add-point
 
         ACCEPT DIALOG
         
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
      
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG 
 
      #add-point:query段查詢方案相關ACTION設定前 name="query.set_qbe_action_before"
      
      #end add-point 
 
      ON ACTION qbeclear   # 條件清除
         CLEAR FORM
         #add-point:條件清除後 name="query.qbeclear"
         
         #end add-point 
 
      #add-point:query段查詢方案相關ACTION設定後 name="query.set_qbe_action_after"
      
      #end add-point 
 
   END DIALOG
 
   
 
   LET g_wc = g_wc_table 
 
 
   
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
 
 
 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
      #還原
      LET g_wc = " 1=2"
      LET g_wc2 = " 1=1"
      LET g_wc_filter = g_wc_filter_t
      RETURN
   ELSE
      LET g_master_idx = 1
   END IF
        
   #add-point:cs段after_construct name="cs.after_construct"
   
   #end add-point
        
   LET g_error_show = 1
   CALL azzq932_b_fill()
   LET l_ac = g_master_idx
   IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = -100 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   END IF
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
   
END FUNCTION
 
{</section>}
 
{<section id="azzq932.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION azzq932_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE ls_wc2          STRING
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   
   #end add-point
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   
   #end add-point
 
   IF cl_null(g_wc_filter) THEN
      LET g_wc_filter = " 1=1"
   END IF
   IF cl_null(g_wc) THEN
      LET g_wc = " 1=1"
   END IF
   IF cl_null(g_wc2) THEN
      LET g_wc2 = " 1=1"
   END IF
   
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter, cl_sql_auth_filter()   #(ver:40) add cl_sql_auth_filter()
 
   LET ls_sql_rank = "SELECT  UNIQUE '',gzwi001,gzwi004,gzwi012,gzwi013,gzwi005,'',gzwi008,'',gzwi003, 
       gzwi011,gzwi009,gzwi002,gzwi010,gzwi022,gzwi017,gzwi006,gzwistus  ,DENSE_RANK() OVER( ORDER BY gzwi_t.gzwi001) AS RANK FROM gzwi_t", 
 
 
 
                     "",
                     " WHERE 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("gzwi_t"),
                     " ORDER BY gzwi_t.gzwi001"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   #手動維護
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter, " AND gzwistus = 'Y'"
   
   LET ls_sql_rank = "SELECT  UNIQUE '',gzwi001,gzwi004,gzwi012,gzwi013,gzwi005,'',gzwi008,'',gzwi003, 
       gzwi011,gzwi009,gzwi002,gzwi010,gzwi022,gzwi017,gzwi006,gzwistus  ,DENSE_RANK() OVER( ORDER BY gzwi_t.gzwi001) AS RANK FROM gzwi_t", 

 
 
                     "",
                     " WHERE 1=1 AND ", ls_wc
    
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("gzwi_t"),
                     " ORDER BY gzwi_t.gzwi001"
   #end add-point
 
   LET g_sql = "SELECT COUNT(1) FROM (",ls_sql_rank,")"
 
   PREPARE b_fill_cnt_pre FROM g_sql
   EXECUTE b_fill_cnt_pre INTO g_tot_cnt
   FREE b_fill_cnt_pre
 
   #add-point:b_fill段rank_sql_after_count name="b_fill.rank_sql_after_count"
   
   #end add-point
 
   CASE g_detail_page_action
      WHEN "detail_first"
          LET g_pagestart = 1
 
      WHEN "detail_previous"
          LET g_pagestart = g_pagestart - g_num_in_page
          IF g_pagestart < 1 THEN
              LET g_pagestart = 1
          END IF
 
      WHEN "detail_next"
         LET g_pagestart = g_pagestart + g_num_in_page
         IF g_pagestart > g_tot_cnt THEN
            LET g_pagestart = g_tot_cnt - (g_tot_cnt mod g_num_in_page) + 1
            WHILE g_pagestart > g_tot_cnt
               LET g_pagestart = g_pagestart - g_num_in_page
            END WHILE
         END IF
 
      WHEN "detail_last"
         LET g_pagestart = g_tot_cnt - (g_tot_cnt mod g_num_in_page) + 1
         WHILE g_pagestart > g_tot_cnt
            LET g_pagestart = g_pagestart - g_num_in_page
         END WHILE
 
      OTHERWISE
         LET g_pagestart = 1
 
   END CASE
 
   LET g_sql = "SELECT '',gzwi001,gzwi004,gzwi012,gzwi013,gzwi005,'',gzwi008,'',gzwi003,gzwi011,gzwi009, 
       gzwi002,gzwi010,gzwi022,gzwi017,gzwi006,gzwistus",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE azzq932_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR azzq932_pb
   
   OPEN b_fill_curs
 
   CALL g_gzwi_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1   
 
   FOREACH b_fill_curs INTO g_gzwi_d[l_ac].sel,g_gzwi_d[l_ac].gzwi001,g_gzwi_d[l_ac].gzwi004,g_gzwi_d[l_ac].gzwi012, 
       g_gzwi_d[l_ac].gzwi013,g_gzwi_d[l_ac].gzwi005,g_gzwi_d[l_ac].gzwi005_desc,g_gzwi_d[l_ac].gzwi008, 
       g_gzwi_d[l_ac].gzwi008_desc,g_gzwi_d[l_ac].gzwi003,g_gzwi_d[l_ac].gzwi011,g_gzwi_d[l_ac].gzwi009, 
       g_gzwi_d[l_ac].gzwi002,g_gzwi_d[l_ac].gzwi010,g_gzwi_d[l_ac].gzwi022,g_gzwi_d[l_ac].gzwi017,g_gzwi_d[l_ac].gzwi006, 
       g_gzwi_d[l_ac].gzwistus
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      #LET g_gzwi_d[l_ac].statepic = cl_get_actipic(g_gzwi_d[l_ac].statepic)
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      LET g_gzwi_d[l_ac].sel = "N"   #預設不勾選
      #end add-point
 
      CALL azzq932_detail_show("'1'")      
 
      CALL azzq932_gzwi_t_mask()
 
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "" 
            LET g_errparam.code = 9035 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
         END IF
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
      
   END FOREACH
   LET g_error_show = 0
   
 
   
   CALL g_gzwi_d.deleteElement(g_gzwi_d.getLength())   
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   
   #end add-point
   
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   LET g_detail_cnt = g_gzwi_d.getLength()
#  DISPLAY g_detail_cnt TO FORMONLY.h_count
   LET l_ac = g_cnt
   LET g_cnt = 0
   
   CLOSE b_fill_curs
   FREE azzq932_pb
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL azzq932_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL azzq932_detail_action_trans()
 
   IF g_gzwi_d.getLength() > 0 THEN
      LET l_ac = 1
      CALL azzq932_fetch()
   END IF
   
      CALL azzq932_filter_show('gzwi001','b_gzwi001')
   CALL azzq932_filter_show('gzwi004','b_gzwi004')
   CALL azzq932_filter_show('gzwi012','b_gzwi012')
   CALL azzq932_filter_show('gzwi013','b_gzwi013')
   CALL azzq932_filter_show('gzwi005','b_gzwi005')
   CALL azzq932_filter_show('gzwi008','b_gzwi008')
   CALL azzq932_filter_show('gzwi003','b_gzwi003')
   CALL azzq932_filter_show('gzwi011','b_gzwi011')
   CALL azzq932_filter_show('gzwi009','b_gzwi009')
   CALL azzq932_filter_show('gzwi002','b_gzwi002')
   CALL azzq932_filter_show('gzwi010','b_gzwi010')
   CALL azzq932_filter_show('gzwi022','b_gzwi022')
   CALL azzq932_filter_show('gzwi017','b_gzwi017')
   CALL azzq932_filter_show('gzwi006','b_gzwi006')
   CALL azzq932_filter_show('gzwistus','b_gzwistus')
 
 
   #add-point:b_fill段結束前 name="b_fill.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="azzq932.fetch" >}
#+ 單身陣列填充2
PRIVATE FUNCTION azzq932_fetch()
   #add-point:fetch段define-客製 name="fetch.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:fetch段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point
   
   #add-point:FUNCTION前置處理 name="fetch.before_function"
   
   #end add-point
 
 
   #add-point:陣列清空 name="fetch.array_clear"
   
   #end add-point
   
   LET li_ac = l_ac 
   
 
   
   #add-point:單身填充後 name="fetch.after_fill"
   
   #end add-point 
   
 
   #add-point:陣列筆數調整 name="fetch.array_deleteElement"
   
   #end add-point
 
   LET l_ac = li_ac
   
END FUNCTION
 
{</section>}
 
{<section id="azzq932.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION azzq932_detail_show(ps_page)
   #add-point:show段define-客製 name="detail_show.define_customerization"
   
   #end add-point
   DEFINE ps_page    STRING
   DEFINE ls_sql     STRING
   #add-point:show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_show.define"
   
   #end add-point
 
   #add-point:detail_show段之前 name="detail_show.before"
   
   #end add-point
   
   
 
   #讀入ref值
   IF ps_page.getIndexOf("'1'",1) > 0 THEN
      #帶出公用欄位reference值page1
      #應用 a12 樣板自動產生(Version:4)
 
 
 
 
      #add-point:show段單身reference name="detail_show.body.reference"

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_gzwi_d[l_ac].gzwi005
            LET ls_sql = "SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? "
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_gzwi_d[l_ac].gzwi005_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_gzwi_d[l_ac].gzwi005_desc

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_gzwi_d[l_ac].gzwi008
            LET ls_sql = "SELECT gzzal003 FROM gzzal_t WHERE gzzal001=? AND gzzal002='"||g_lang||"'"
            LET ls_sql = cl_sql_add_mask(ls_sql)              #遮蔽特定資料
            CALL ap_ref_array2(g_ref_fields,ls_sql,"") RETURNING g_rtn_fields
            LET g_gzwi_d[l_ac].gzwi008_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_gzwi_d[l_ac].gzwi008_desc

      #end add-point
   END IF
   
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="azzq932.filter" >}
#+ filter過濾功能
PRIVATE FUNCTION azzq932_filter()
   #add-point:filter段define-客製 name="filter.define_customerization"
   
   #end add-point
   DEFINE  ls_result   STRING
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
   
   #end add-point
   
   #add-point:FUNCTION前置處理 name="filter.before_function"
   
   #end add-point
 
   LET l_ac = 1
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", TRUE)
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON gzwi001,gzwi004,gzwi012,gzwi013,gzwi005,gzwi008,gzwi003,gzwi011,gzwi009, 
          gzwi002,gzwi010,gzwi022,gzwi017,gzwi006,gzwistus
                          FROM s_detail1[1].b_gzwi001,s_detail1[1].b_gzwi004,s_detail1[1].b_gzwi012, 
                              s_detail1[1].b_gzwi013,s_detail1[1].b_gzwi005,s_detail1[1].b_gzwi008,s_detail1[1].b_gzwi003, 
                              s_detail1[1].b_gzwi011,s_detail1[1].b_gzwi009,s_detail1[1].b_gzwi002,s_detail1[1].b_gzwi010, 
                              s_detail1[1].b_gzwi022,s_detail1[1].b_gzwi017,s_detail1[1].b_gzwi006,s_detail1[1].b_gzwistus 
 
 
         BEFORE CONSTRUCT
                     DISPLAY azzq932_filter_parser('gzwi001') TO s_detail1[1].b_gzwi001
            DISPLAY azzq932_filter_parser('gzwi004') TO s_detail1[1].b_gzwi004
            DISPLAY azzq932_filter_parser('gzwi012') TO s_detail1[1].b_gzwi012
            DISPLAY azzq932_filter_parser('gzwi013') TO s_detail1[1].b_gzwi013
            DISPLAY azzq932_filter_parser('gzwi005') TO s_detail1[1].b_gzwi005
            DISPLAY azzq932_filter_parser('gzwi008') TO s_detail1[1].b_gzwi008
            DISPLAY azzq932_filter_parser('gzwi003') TO s_detail1[1].b_gzwi003
            DISPLAY azzq932_filter_parser('gzwi011') TO s_detail1[1].b_gzwi011
            DISPLAY azzq932_filter_parser('gzwi009') TO s_detail1[1].b_gzwi009
            DISPLAY azzq932_filter_parser('gzwi002') TO s_detail1[1].b_gzwi002
            DISPLAY azzq932_filter_parser('gzwi010') TO s_detail1[1].b_gzwi010
            DISPLAY azzq932_filter_parser('gzwi022') TO s_detail1[1].b_gzwi022
            DISPLAY azzq932_filter_parser('gzwi017') TO s_detail1[1].b_gzwi017
            DISPLAY azzq932_filter_parser('gzwi006') TO s_detail1[1].b_gzwi006
            DISPLAY azzq932_filter_parser('gzwistus') TO s_detail1[1].b_gzwistus
 
 
         #單身公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<gzwicrtdt>>----
         #AFTER FIELD gzwicrtdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<gzwimoddt>>----
         #AFTER FIELD gzwimoddt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<gzwicnfdt>>----
         #AFTER FIELD gzwicnfdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<gzwipstdt>>----
         #AFTER FIELD gzwipstdt
         #   CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
         #   IF NOT cl_null(ls_result) THEN
         #      IF NOT cl_chk_date_symbol(ls_result) THEN
         #         LET ls_result = cl_add_date_extra_cond(ls_result)
         #      END IF
         #   END IF
         #   CALL FGL_DIALOG_SETBUFFER(ls_result)
 
 
 
           
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_gzwi001>>----
         #Ctrlp:construct.c.filter.page1.b_gzwi001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gzwi001
            #add-point:ON ACTION controlp INFIELD b_gzwi001 name="construct.c.filter.page1.b_gzwi001"
            
            #END add-point
 
 
         #----<<b_gzwi004>>----
         #Ctrlp:construct.c.filter.page1.b_gzwi004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gzwi004
            #add-point:ON ACTION controlp INFIELD b_gzwi004 name="construct.c.filter.page1.b_gzwi004"
            
            #END add-point
 
 
         #----<<b_gzwi012>>----
         #Ctrlp:construct.c.filter.page1.b_gzwi012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gzwi012
            #add-point:ON ACTION controlp INFIELD b_gzwi012 name="construct.c.filter.page1.b_gzwi012"
            
            #END add-point
 
 
         #----<<b_gzwi013>>----
         #Ctrlp:construct.c.filter.page1.b_gzwi013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gzwi013
            #add-point:ON ACTION controlp INFIELD b_gzwi013 name="construct.c.filter.page1.b_gzwi013"
            
            #END add-point
 
 
         #----<<b_gzwi005>>----
         #Ctrlp:construct.c.page1.b_gzwi005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gzwi005
            #add-point:ON ACTION controlp INFIELD b_gzwi005 name="construct.c.filter.page1.b_gzwi005"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_gzwi005  #顯示到畫面上
            NEXT FIELD b_gzwi005                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_gzwi005_desc>>----
         #----<<b_gzwi008>>----
         #Ctrlp:construct.c.page1.b_gzwi008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gzwi008
            #add-point:ON ACTION controlp INFIELD b_gzwi008 name="construct.c.filter.page1.b_gzwi008"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_gzzz001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_gzwi008  #顯示到畫面上
            NEXT FIELD b_gzwi008                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_gzwi008_desc>>----
         #----<<b_gzwi003>>----
         #Ctrlp:construct.c.filter.page1.b_gzwi003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gzwi003
            #add-point:ON ACTION controlp INFIELD b_gzwi003 name="construct.c.filter.page1.b_gzwi003"
            
            #END add-point
 
 
         #----<<b_gzwi011>>----
         #Ctrlp:construct.c.filter.page1.b_gzwi011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gzwi011
            #add-point:ON ACTION controlp INFIELD b_gzwi011 name="construct.c.filter.page1.b_gzwi011"
            
            #END add-point
 
 
         #----<<b_gzwi009>>----
         #Ctrlp:construct.c.filter.page1.b_gzwi009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gzwi009
            #add-point:ON ACTION controlp INFIELD b_gzwi009 name="construct.c.filter.page1.b_gzwi009"
            
            #END add-point
 
 
         #----<<b_gzwi002>>----
         #Ctrlp:construct.c.filter.page1.b_gzwi002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gzwi002
            #add-point:ON ACTION controlp INFIELD b_gzwi002 name="construct.c.filter.page1.b_gzwi002"
            
            #END add-point
 
 
         #----<<b_gzwi010>>----
         #Ctrlp:construct.c.filter.page1.b_gzwi010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gzwi010
            #add-point:ON ACTION controlp INFIELD b_gzwi010 name="construct.c.filter.page1.b_gzwi010"
            
            #END add-point
 
 
         #----<<b_gzwi022>>----
         #Ctrlp:construct.c.filter.page1.b_gzwi022
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gzwi022
            #add-point:ON ACTION controlp INFIELD b_gzwi022 name="construct.c.filter.page1.b_gzwi022"
            
            #END add-point
 
 
         #----<<b_gzwi017>>----
         #Ctrlp:construct.c.filter.page1.b_gzwi017
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gzwi017
            #add-point:ON ACTION controlp INFIELD b_gzwi017 name="construct.c.filter.page1.b_gzwi017"
            
            #END add-point
 
 
         #----<<b_gzwi006>>----
         #Ctrlp:construct.c.page1.b_gzwi006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gzwi006
            #add-point:ON ACTION controlp INFIELD b_gzwi006 name="construct.c.filter.page1.b_gzwi006"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooef001_5()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO b_gzwi006  #顯示到畫面上
            NEXT FIELD b_gzwi006                     #返回原欄位
    



            #END add-point
 
 
         #----<<b_gzwistus>>----
         #Ctrlp:construct.c.filter.page1.b_gzwistus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_gzwistus
            #add-point:ON ACTION controlp INFIELD b_gzwistus name="construct.c.filter.page1.b_gzwistus"
            
            #END add-point
 
 
   
 
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
      LET g_wc_filter = g_wc_filter, " "
      LET g_wc_filter_t = g_wc_filter
   ELSE
      LET g_wc_filter = g_wc_filter_t
   END IF
   
      CALL azzq932_filter_show('gzwi001','b_gzwi001')
   CALL azzq932_filter_show('gzwi004','b_gzwi004')
   CALL azzq932_filter_show('gzwi012','b_gzwi012')
   CALL azzq932_filter_show('gzwi013','b_gzwi013')
   CALL azzq932_filter_show('gzwi005','b_gzwi005')
   CALL azzq932_filter_show('gzwi008','b_gzwi008')
   CALL azzq932_filter_show('gzwi003','b_gzwi003')
   CALL azzq932_filter_show('gzwi011','b_gzwi011')
   CALL azzq932_filter_show('gzwi009','b_gzwi009')
   CALL azzq932_filter_show('gzwi002','b_gzwi002')
   CALL azzq932_filter_show('gzwi010','b_gzwi010')
   CALL azzq932_filter_show('gzwi022','b_gzwi022')
   CALL azzq932_filter_show('gzwi017','b_gzwi017')
   CALL azzq932_filter_show('gzwi006','b_gzwi006')
   CALL azzq932_filter_show('gzwistus','b_gzwistus')
 
    
   CALL azzq932_b_fill()
   
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="azzq932.filter_parser" >}
#+ filter欄位解析
PRIVATE FUNCTION azzq932_filter_parser(ps_field)
   #add-point:filter段define-客製 name="filter_parser.define_customerization"
   
   #end add-point
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter_parser.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="filter_parser.before_function"
   
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
 
{<section id="azzq932.filter_show" >}
#+ Browser標題欄位顯示搜尋條件
PRIVATE FUNCTION azzq932_filter_show(ps_field,ps_object)
   #add-point:filter_show段define-客製 name="filter_show.define_customerization"
   
   #end add-point
   DEFINE ps_field         STRING
   DEFINE ps_object        STRING
   DEFINE lnode_item       om.DomNode
   DEFINE ls_title         STRING
   DEFINE ls_name          STRING
   DEFINE ls_condition     STRING
   #add-point:filter_show段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter_show.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="filter_show.before_function"
   
   #end add-point
 
   LET ls_name = "formonly.", ps_object
 
   LET lnode_item = gfrm_curr.findNode("TableColumn", ls_name)
   LET ls_title = lnode_item.getAttribute("text")
   IF ls_title.getIndexOf('※',1) > 0 THEN
      LEt ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = azzq932_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="azzq932.insert" >}
#+ insert
PRIVATE FUNCTION azzq932_insert()
   #add-point:insert段define-客製 name="insert.define_customerization"
   
   #end add-point
   #add-point:insert段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point
 
   #add-point:insert段control name="insert.control"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="azzq932.modify" >}
#+ modify
PRIVATE FUNCTION azzq932_modify()
   #add-point:modify段define-客製 name="modify.define_customerization"
   
   #end add-point
   #add-point:modify段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="modify.define"
   
   #end add-point
 
   #add-point:modify段control name="modify.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="azzq932.reproduce" >}
#+ reproduce
PRIVATE FUNCTION azzq932_reproduce()
   #add-point:reproduce段define-客製 name="reproduce.define_customerization"
   
   #end add-point
   #add-point:reproduce段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="reproduce.define"
   
   #end add-point
 
   #add-point:reproduce段control name="reproduce.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="azzq932.delete" >}
#+ delete
PRIVATE FUNCTION azzq932_delete()
   #add-point:delete段define-客製 name="delete.define_customerization"
   
   #end add-point
   #add-point:delete段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="delete.define"
   
   #end add-point
 
   #add-point:delete段control name="delete.control"
   
   #end add-point 
END FUNCTION
 
{</section>}
 
{<section id="azzq932.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION azzq932_detail_action_trans()
   #add-point:detail_action_trans段define-客製 name="detail_action_trans.define_customerization"
   
   #end add-point
   #add-point:detail_action_trans段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_action_trans.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="detail_action_trans.before_function"
   
   #end add-point
 
   #因應單身切頁功能，筆數計算方式調整
   LET g_current_row_tot = g_pagestart + g_detail_idx - 1
   DISPLAY g_current_row_tot TO FORMONLY.h_index
   DISPLAY g_tot_cnt TO FORMONLY.h_count
 
   #顯示單身頁面的起始與結束筆數
   LET g_page_start_num = g_pagestart
   LET g_page_end_num = g_pagestart + g_num_in_page - 1
   DISPLAY g_page_start_num TO FORMONLY.p_start
   DISPLAY g_page_end_num TO FORMONLY.p_end
 
   #目前不支援跳頁功能
   LET g_page_act_list = "detail_first,detail_previous,'',detail_next,detail_last"
   CALL cl_navigator_detail_page_setting(g_page_act_list,g_current_row_tot,g_pagestart,g_num_in_page,g_tot_cnt)
 
END FUNCTION
 
{</section>}
 
{<section id="azzq932.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION azzq932_detail_index_setting()
   #add-point:detail_index_setting段define-客製 name="deatil_index_setting.define_customerization"
   
   #end add-point
   DEFINE li_redirect     BOOLEAN
   DEFINE ldig_curr       ui.Dialog
   #add-point:detail_index_setting段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_index_setting.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="detail_index_setting.before_function"
   
   #end add-point
 
   IF g_curr_diag IS NOT NULL THEN
      CASE
         WHEN g_curr_diag.getCurrentRow("s_detail1") <= "0"
            LET g_detail_idx = 1
            IF g_gzwi_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_gzwi_d.getLength() AND g_gzwi_d.getLength() > 0
            LET g_detail_idx = g_gzwi_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_gzwi_d.getLength() THEN
               LET g_detail_idx = g_gzwi_d.getLength()
            END IF
            LET li_redirect = TRUE
      END CASE
   END IF
 
   IF li_redirect THEN
      LET ldig_curr = ui.Dialog.getCurrent()
      CALL ldig_curr.setCurrentRow("s_detail1", g_detail_idx)
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="azzq932.mask_functions" >}
 &include "erp/azz/azzq932_mask.4gl"
 
{</section>}
 
{<section id="azzq932.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 動態設定Table欄位的comment
# Memo...........:
# Usage..........: CALL aitq203_show_fld_cont()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzq932_show_fld_cont()
   DEFINE gwin_curr          ui.Window                     #Current Window
   DEFINE gfrm_curr          ui.Form                       #Current Form
   DEFINE l_node_1           om.DomNode
   DEFINE l_node_2           om.DomNode
   DEFINE l_node_3           om.DomNode
   DEFINE l_nodelist         om.NodeList
   DEFINE l_i                LIKE type_t.num5
   DEFINE l_j                LIKE type_t.num5
   DEFINE l_cnt              LIKE type_t.num5
   DEFINE l_value            STRING
   DEFINE l_node_1_name      STRING
   DEFINE l_node_1_tagname   STRING
   DEFINE l_comment          STRING
   DEFINE l_guimode          STRING
   DEFINE l_ispwd            STRING               #isPassword

   LET l_guimode = FGL_GETENV("GUIMODE")
   IF g_bgjob = "Y" OR l_guimode = "GWC" THEN
      RETURN
   END IF

   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件

   LET l_node_1 = gfrm_curr.getNode()
   LET l_nodelist = l_node_1.selectByPath("//Form//*")

   FOR l_i=1 TO l_nodelist.getLength()
      LET l_node_1 = l_nodelist.item(l_i)
      LET l_node_1_name = l_node_1.getAttribute("name")
      LET l_node_1_tagname = l_node_1.getTagName()
      LET l_ispwd = l_node_1.getAttribute("isPassword")

      IF cl_null(l_ispwd) THEN
         LET l_ispwd = "0"
      END IF

      #動態設定comment
      LET l_comment = NULL
      CASE
         #TableColumn
         WHEN (l_ispwd = "0") AND (l_node_1_tagname = "TableColumn")
            LET l_node_2 = l_node_1.getFirstChild()
            IF l_node_2 IS NOT NULL THEN
               CASE l_node_2.getTagName()
                  WHEN "TextEdit"
                     LET l_comment = l_node_1.getAttribute("text")
                     CALL l_node_2.setAttribute("comment",l_comment)
                     CALL cl_show_textEdit_comment(l_node_1)
               END CASE
            END IF
      END CASE
   END FOR
END FUNCTION

################################################################################
# Descriptions...: 匯入問題管制表的excel
# Memo...........:
# Usage..........: CALL azzq932_imp_excel(p_path)
#                  RETURNING 回传参数
# Input parameter: p_path   excel路徑
# Return code....: 
# Date & Author..: No.160822-00010#1 2016/08/08 By frank0521
# Modify.........:
################################################################################
PRIVATE FUNCTION azzq932_imp_excel(p_path)
   DEFINE l_workbook                XSSFWorkbook              #160822-00010#1 參數
   DEFINE l_workbook_xls            HSSFWorkbook              #160822-00010#1 參數
   DEFINE l_sheet                   XSSFSheet                 #160822-00010#1 參數
   DEFINE l_sheet_xls               HSSFSheet                 #160822-00010#1 參數
   DEFINE l_row                     XSSFRow                   #160822-00010#1 參數
   DEFINE l_row_xls                 HSSFRow                   #160822-00010#1 參數
   DEFINE l_cell                    XSSFCell                  #160822-00010#1 參數
   DEFINE l_cell_xls                HSSFCell                  #160822-00010#1 參數
   DEFINE l_xls_type              STRING                    #160822-00010#1 參數
   DEFINE l_gzwi_excel            DYNAMIC ARRAY OF type_g_gzwi_excel 
   DEFINE p_path                  LIKE gzwi_t.gzwi012                         #檔案路徑
   DEFINE l_circle_sheet          LIKE type_t.num10
   DEFINE l_circle_row            LIKE type_t.num10
   DEFINE l_circle_cell           LIKE type_t.num10
   DEFINE l_circle_con            LIKE type_t.num10
   DEFINE l_count_sheet           LIKE type_t.num10
   DEFINE l_count_row             LIKE type_t.num10
   DEFINE l_count_cell            LIKE type_t.num10
   DEFINE l_diffold               DYNAMIC ARRAY OF type_g_gzwo_inc            #原始資料
   DEFINE l_diffnew               DYNAMIC ARRAY OF type_g_gzwo_inc            #異動後
   DEFINE l_gzwi_m                DYNAMIC ARRAY OF type_g_gzwi_inc            #信件資訊
   DEFINE l_colname               STRING
   DEFINE l_comment               STRING
   DEFINE l_process_bar_msg       STRING
   DEFINE l_chk                   BOOLEAN                                     #是否成功
   DEFINE l_chk_help              BOOLEAN                                     #匯入後反映是否成功
   DEFINE l_attach                STRING                                      #mail附件路徑字串
   DEFINE l_count                 LIKE type_t.num10
   DEFINE l_uppercase_temp        STRING
   DEFINE l_mail_chk              BOOLEAN                                     #是否寄送MAIL
   DEFINE l_gzwi_email            DYNAMIC ARRAY OF type_g_gzwi_inc            #160822-00010#1
   DEFINE l_server_uri            STRING                                      #azzs010設定:Help 接口網址 (產中:型管/客戶:服管)
   DEFINE l_gzwo_m DYNAMIC ARRAY OF RECORD                                    #接收反映鼎新後的資料
      l_chk      BOOLEAN,
      gzwo001    LIKE gzwo_t.gzwo001,
      gzwo009    LIKE gzwo_t.gzwo009,
      gzwo014    LIKE gzwo_t.gzwo014,
      gzwomodid  LIKE gzwo_t.gzwomodid ,
      gzwomoddt  LIKE gzwo_t.gzwomoddt
      END RECORD
   
   WHENEVER ERROR CONTINUE
   CALL l_gzwi_excel.clear()
   LET l_mail_chk = FALSE
   
   LET g_sql = "INSERT INTO gzwi_t (gzwi001,gzwi002,gzwi003,gzwi004,gzwi005,",
                                     " gzwi006,gzwi007,gzwi008,gzwi010,",
                                     " gzwi011,gzwi013,gzwi014,gzwi015,",
                                     " gzwi016,gzwi017,gzwi018,",
                                     " gzwi028,",
                                     " gzwistus,gzwiownid,gzwiowndp,gzwicrtid,gzwicrtdp,gzwicrtdt)",
                  " VALUES (?,?,?,?,? ,?,?,?,?,? ,?,?,?,?,? ,?,?,?,?,? ,?,?,?)"
   PREPARE azzq932_issue_ins_pre FROM g_sql
   
   
   #開檔
   CALL azzq932_openfile_excel(p_path) RETURNING l_chk, l_workbook, l_workbook_xls, l_xls_type

   IF l_chk THEN
      #檢查EXCEL規格是否符合 
      CALL azzq932_check_excel(l_workbook, l_workbook_xls, l_xls_type) RETURNING l_chk, l_gzwi_excel
   END IF
   
   IF l_chk THEN
      CALL cl_err_collect_init()
      
      CALL s_transaction_begin()
      
      LET l_count_row = l_gzwi_excel.getLength()
      CALL cl_progress_bar(l_count_row)               #progress bar開啟
      
      FOR l_circle_sheet = 1 TO 1  #之後有多個sheet的話，改這
         FOR l_circle_row = 1 TO l_count_row
        
            LET l_process_bar_msg = cl_getmsg_parm("azz-01130",g_lang,l_circle_row)
            CALL cl_progress_ing(l_process_bar_msg)
            
            #DEFAULT值
            LET l_gzwi_excel[l_circle_row].gzwi017 = g_enterprise   #反映企業代碼
            LET l_gzwi_excel[l_circle_row].gzwiownid = g_user
            LET l_gzwi_excel[l_circle_row].gzwiowndp = g_dept
            LET l_gzwi_excel[l_circle_row].gzwicrtid = g_user
            LET l_gzwi_excel[l_circle_row].gzwicrtdp = g_dept
            LET l_gzwi_excel[l_circle_row].gzwimodid = NULL         #161027-00047#1
            LET l_gzwi_excel[l_circle_row].gzwimoddt = NULL         #161027-00047#1
            LET l_gzwi_excel[l_circle_row].gzwistus = "Y" 
            LET l_gzwi_excel[l_circle_row].gzwi011 = "1"                 
            LET l_gzwi_excel[l_circle_row].gzwi014 = "1"                                   #負責單位:1.MIS 2.E-Service
            LET l_gzwi_excel[l_circle_row].gzwi026 = NULL                                  #日期要設NULL否則會是預設日期
            LET l_gzwi_excel[l_circle_row].gzwicrtdt = cl_get_current()                    #2014-09-11 10:49:13
            LET l_gzwi_excel[l_circle_row].gzwi013 = l_gzwi_excel[l_circle_row].gzwicrtdt  #反映日期
            
            #取得聯絡對象檔與單位資料-反映人員,處理人員
            CALL cl_helps932_oofa_sel_2(g_enterprise,"2",l_gzwi_excel[l_circle_row].gzwi005) RETURNING g_oofa_sel[1].*
            LET l_gzwi_excel[l_circle_row].gzwi005_desc = g_oofa_sel[1].oofa011
            LET l_gzwi_excel[l_circle_row].gzwi005dp_desc = g_oofa_sel[1].ooefl003_dp
            LET l_gzwi_excel[l_circle_row].gzwi006 = g_site    #g_oofa_sel[1].ooag004
            LET l_gzwi_excel[l_circle_row].gzwi005op_desc = g_oofa_sel[1].ooefl003_site    
            LET l_gzwi_excel[l_circle_row].gzwi015 = '2'  #預設'2.員工'                     #處理人員類型 g_oofa_sel[1].oofa002 CLIPPED
            LET l_gzwi_excel[l_circle_row].gzwi007 = g_oofa_sel[1].oofa001                 #處理人員聯絡對象識別碼
            
#            #處理人員
#            CALL cl_helps932_oofa_sel_3(g_enterprise,l_gzwi_excel[l_circle_row].gzwi006,l_gzwi_excel[l_circle_row].gzwi003,"gzwh004 = 'Y'") RETURNING g_oofa_sel
#            IF g_oofa_sel.getLength() > 0 THEN
#               LET l_gzwi_excel[l_circle_row].gzwi007 = g_oofa_sel[1].oofa001 CLIPPED   #處理人員-聯絡對象識別碼
#               LET l_gzwi_excel[l_circle_row].gzwi015 = g_oofa_sel[1].oofa002 CLIPPED   #處理人員類型
#               LET l_gzwi_excel[l_circle_row].gzwi018 = g_oofa_sel[1].oofa003 CLIPPED   #處理人員,聯絡對象代碼一oofa003
#            ELSE
#               CALL cl_helps932_oofa_sel_3(g_enterprise,l_gzwi_excel[l_circle_row].gzwi006,l_gzwi_excel[l_circle_row].gzwi003,"gzwh004 IS NULL") RETURNING g_oofa_sel
#               IF g_oofa_sel.getLength() > 0 THEN
#                  LET l_gzwi_excel[l_circle_row].gzwi007 = g_oofa_sel[1].oofa001 CLIPPED   #處理人員-聯絡對象識別碼
#                  LET l_gzwi_excel[l_circle_row].gzwi015 = g_oofa_sel[1].oofa002 CLIPPED   #處理人員類型
#                  LET l_gzwi_excel[l_circle_row].gzwi018 = g_oofa_sel[1].oofa003 CLIPPED   #處理人員,聯絡對象代碼一oofa003
#               ELSE
#                  CALL cl_helps932_oofa_sel_3(g_enterprise,l_gzwi_excel[l_circle_row].gzwi006,l_gzwi_excel[l_circle_row].gzwi003,"gzwh004 = 'N'") RETURNING g_oofa_sel
#                  IF g_oofa_sel.getLength() > 0 THEN
#                     LET l_gzwi_excel[l_circle_row].gzwi007 = g_oofa_sel[1].oofa001 CLIPPED   #處理人員-聯絡對象識別碼
#                     LET l_gzwi_excel[l_circle_row].gzwi015 = g_oofa_sel[1].oofa002 CLIPPED   #處理人員類型
#                     LET l_gzwi_excel[l_circle_row].gzwi018 = g_oofa_sel[1].oofa003 CLIPPED   #處理人員,聯絡對象代碼一oofa003
#                  END IF
#               END IF
#            END IF
            
            #問題編號: 年月日+4碼流水號
            CALL cl_helps932_gen_gzwi001(l_gzwi_excel[l_circle_row].gzwicrtdt) RETURNING l_gzwi_excel[l_circle_row].gzwi001,l_gzwi_excel[l_circle_row].gzwi016
            EXECUTE azzq932_issue_ins_pre USING l_gzwi_excel[l_circle_row].gzwi001,l_gzwi_excel[l_circle_row].gzwi002,l_gzwi_excel[l_circle_row].gzwi003,l_gzwi_excel[l_circle_row].gzwi004,l_gzwi_excel[l_circle_row].gzwi005,
                                                l_gzwi_excel[l_circle_row].gzwi006,l_gzwi_excel[l_circle_row].gzwi007,l_gzwi_excel[l_circle_row].gzwi008,l_gzwi_excel[l_circle_row].gzwi010,
                                                l_gzwi_excel[l_circle_row].gzwi011,l_gzwi_excel[l_circle_row].gzwi013,l_gzwi_excel[l_circle_row].gzwi014,l_gzwi_excel[l_circle_row].gzwi015,
                                                l_gzwi_excel[l_circle_row].gzwi016,l_gzwi_excel[l_circle_row].gzwi017,l_gzwi_excel[l_circle_row].gzwi018,
                                                l_gzwi_excel[l_circle_row].gzwi028,
                                                l_gzwi_excel[l_circle_row].gzwistus,l_gzwi_excel[l_circle_row].gzwiownid,l_gzwi_excel[l_circle_row].gzwiowndp,l_gzwi_excel[l_circle_row].gzwicrtid,l_gzwi_excel[l_circle_row].gzwicrtdp,l_gzwi_excel[l_circle_row].gzwicrtdt
            IF SQLCA.sqlcode THEN
               #同時有人新增,問題編號可能重複,再取一次編號
               CALL cl_helps932_gen_gzwi001(l_gzwi_excel[l_circle_row].gzwicrtdt) RETURNING l_gzwi_excel[l_circle_row].gzwi001,l_gzwi_excel[l_circle_row].gzwi016
               EXECUTE azzq932_issue_ins_pre USING l_gzwi_excel[l_circle_row].gzwi001,l_gzwi_excel[l_circle_row].gzwi002,l_gzwi_excel[l_circle_row].gzwi003,l_gzwi_excel[l_circle_row].gzwi004,l_gzwi_excel[l_circle_row].gzwi005,
                                                   l_gzwi_excel[l_circle_row].gzwi006,l_gzwi_excel[l_circle_row].gzwi007,l_gzwi_excel[l_circle_row].gzwi008,l_gzwi_excel[l_circle_row].gzwi010,
                                                   l_gzwi_excel[l_circle_row].gzwi011,l_gzwi_excel[l_circle_row].gzwi013,l_gzwi_excel[l_circle_row].gzwi014,l_gzwi_excel[l_circle_row].gzwi015,
                                                   l_gzwi_excel[l_circle_row].gzwi016,l_gzwi_excel[l_circle_row].gzwi017,l_gzwi_excel[l_circle_row].gzwi018,
                                                   l_gzwi_excel[l_circle_row].gzwi028,
                                                   l_gzwi_excel[l_circle_row].gzwistus,l_gzwi_excel[l_circle_row].gzwiownid,l_gzwi_excel[l_circle_row].gzwiowndp,l_gzwi_excel[l_circle_row].gzwicrtid,l_gzwi_excel[l_circle_row].gzwicrtdp,l_gzwi_excel[l_circle_row].gzwicrtdt
               IF SQLCA.sqlcode THEN
                  LET l_chk = FALSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
             
                  CALL s_transaction_end('N','0')
                  LET l_chk = FALSE
               ELSE
                  LET l_chk = TRUE
               END IF
            ELSE
               LET l_chk = TRUE
            END IF
           
            IF l_chk THEN
               LET l_diffold[l_circle_row].gzwoownid = l_gzwi_excel[l_circle_row].gzwiownid  #資料所有者
               LET l_diffold[l_circle_row].gzwoowndp = l_gzwi_excel[l_circle_row].gzwiowndp  #資料所屬部門
               LET l_diffold[l_circle_row].gzwocrtid = l_gzwi_excel[l_circle_row].gzwicrtid  #資料建立者
               LET l_diffold[l_circle_row].gzwocrtdp = l_gzwi_excel[l_circle_row].gzwicrtdp  #資料建立部門
               LET l_diffold[l_circle_row].gzwocrtdt = l_gzwi_excel[l_circle_row].gzwicrtdt  #資料創建日
               LET l_diffold[l_circle_row].gzwomodid = l_gzwi_excel[l_circle_row].gzwimodid  #資料修改者
               LET l_diffold[l_circle_row].gzwomoddt = l_gzwi_excel[l_circle_row].gzwimoddt  #最近修改日
               LET l_diffold[l_circle_row].gzwostus  = l_gzwi_excel[l_circle_row].gzwistus   #狀態碼
               LET l_diffold[l_circle_row].gzwo001   = l_gzwi_excel[l_circle_row].gzwi001    #問題編號
               LET l_diffold[l_circle_row].gzwo002   = l_gzwi_excel[l_circle_row].gzwi002    #類別
               LET l_diffold[l_circle_row].gzwo003   = l_gzwi_excel[l_circle_row].gzwi003    #模組
               LET l_diffold[l_circle_row].gzwo004   = l_gzwi_excel[l_circle_row].gzwi004    #問題描述
               LET l_diffold[l_circle_row].gzwo005   = l_gzwi_excel[l_circle_row].gzwi005    #反映人員
               LET l_diffold[l_circle_row].gzwo006   = l_gzwi_excel[l_circle_row].gzwi006    #反映營運據點
               LET l_diffold[l_circle_row].gzwo007   = l_gzwi_excel[l_circle_row].gzwi007    #處理人員
               LET l_diffold[l_circle_row].gzwo008   = l_gzwi_excel[l_circle_row].gzwi008    #作業編號
               LET l_diffold[l_circle_row].gzwo009   = l_gzwi_excel[l_circle_row].gzwi009    #案件代號
               LET l_diffold[l_circle_row].gzwo010   = l_gzwi_excel[l_circle_row].gzwi010    #緊急案件
               LET l_diffold[l_circle_row].gzwo011   = l_gzwi_excel[l_circle_row].gzwi011    #處理狀態
               LET l_diffold[l_circle_row].gzwo012   = l_gzwi_excel[l_circle_row].gzwi012    #更新摘要
               LET l_diffold[l_circle_row].gzwo013   = l_gzwi_excel[l_circle_row].gzwi013    #反映日期
               LET l_diffold[l_circle_row].gzwo014   = l_gzwi_excel[l_circle_row].gzwi014    #負責單位
               LET l_diffold[l_circle_row].gzwo015   = l_gzwi_excel[l_circle_row].gzwi015    #處理人員類型
               LET l_diffold[l_circle_row].gzwo016   = l_gzwi_excel[l_circle_row].gzwi016    #流水號
               LET l_diffold[l_circle_row].gzwo017   = l_gzwi_excel[l_circle_row].gzwi017    #企業編號
               LET l_diffold[l_circle_row].gzwo018   = l_gzwi_excel[l_circle_row].gzwi018    #處理人員
               LET l_diffold[l_circle_row].gzwo019   = NULL                                  #規格預計完成日
               LET l_diffold[l_circle_row].gzwo020   = NULL                                  #規格實際完成日
               LET l_diffold[l_circle_row].gzwo021   = NULL                                  #預計完成日
               LET l_diffold[l_circle_row].gzwo022   = NULL                                  #實際完成日
               LET l_diffold[l_circle_row].gzwo026   = NULL                                  #最近同步時間
               LET l_diffold[l_circle_row].gzwo027   = NULL                                  #案件歷程
               LET l_diffold[l_circle_row].gzwo028   = l_gzwi_excel[l_circle_row].gzwi028    #客戶代號
                                          
               LET l_diffnew[l_circle_row].* = l_diffold[l_circle_row].*
               
               CALL cl_helps932_gzwo_ins("I",l_diffold[l_circle_row].*,l_diffnew[l_circle_row].*) RETURNING l_chk,l_diffnew[l_circle_row].gzwo902   #新增問題反映記錄異動檔
               IF NOT cl_null(l_diffnew[l_circle_row].gzwo902) THEN
                  IF NOT l_chk THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.extend = ""
                     LET g_errparam.code   = "azz-00766"   #問題編號%1異動記錄失敗
                     LET g_errparam.replace[1] = l_gzwi_excel[l_circle_row].gzwi001
                     LET g_errparam.popup  = TRUE
                     CALL cl_err()
                     CALL s_transaction_end('N','0')
                     LET l_chk = FALSE
                  END IF
               END IF
            END IF
           
            IF l_chk THEN
               LET l_gzwi_email[l_circle_row].gzwi001 = l_gzwi_excel[l_circle_row].gzwi001
               LET l_gzwi_email[l_circle_row].gzwi002 = l_gzwi_excel[l_circle_row].gzwi002
               LET l_gzwi_email[l_circle_row].gzwi003 = l_gzwi_excel[l_circle_row].gzwi003
               LET l_gzwi_email[l_circle_row].gzwi004 = l_gzwi_excel[l_circle_row].gzwi004
               LET l_gzwi_email[l_circle_row].gzwi005 = l_gzwi_excel[l_circle_row].gzwi005
               LET l_gzwi_email[l_circle_row].gzwi006 = l_gzwi_excel[l_circle_row].gzwi006
               LET l_gzwi_email[l_circle_row].gzwi007 = l_gzwi_excel[l_circle_row].gzwi007
               LET l_gzwi_email[l_circle_row].gzwi008 = l_gzwi_excel[l_circle_row].gzwi008
               LET l_gzwi_email[l_circle_row].gzwi009 = l_gzwi_excel[l_circle_row].gzwi009
               LET l_gzwi_email[l_circle_row].gzwi010 = l_gzwi_excel[l_circle_row].gzwi010
               LET l_gzwi_email[l_circle_row].gzwi011 = l_gzwi_excel[l_circle_row].gzwi011
               LET l_gzwi_email[l_circle_row].gzwi012 = l_gzwi_excel[l_circle_row].gzwi012
               LET l_gzwi_email[l_circle_row].gzwi013 = l_gzwi_excel[l_circle_row].gzwi013
               LET l_gzwi_email[l_circle_row].gzwi014 = l_gzwi_excel[l_circle_row].gzwi014
               LET l_gzwi_email[l_circle_row].gzwi015 = l_gzwi_excel[l_circle_row].gzwi015
               LET l_gzwi_email[l_circle_row].gzwi016 = l_gzwi_excel[l_circle_row].gzwi016
               LET l_gzwi_email[l_circle_row].gzwi017 = l_gzwi_excel[l_circle_row].gzwi017
               LET l_gzwi_email[l_circle_row].gzwi018 = l_gzwi_excel[l_circle_row].gzwi018
               LET l_gzwi_email[l_circle_row].gzwi025 = l_gzwi_excel[l_circle_row].gzwi025
               LET l_gzwi_email[l_circle_row].gzwi026 = l_gzwi_excel[l_circle_row].gzwi026
               LET l_gzwi_email[l_circle_row].gzwi027 = l_gzwi_excel[l_circle_row].gzwi027
               LET l_gzwi_email[l_circle_row].gzwi028 = l_gzwi_excel[l_circle_row].gzwi028
               LET l_gzwi_email[l_circle_row].gzwistus  = l_gzwi_excel[l_circle_row].gzwistus  
               LET l_gzwi_email[l_circle_row].gzwiownid = l_gzwi_excel[l_circle_row].gzwiownid 
               LET l_gzwi_email[l_circle_row].gzwiowndp = l_gzwi_excel[l_circle_row].gzwiowndp 
               LET l_gzwi_email[l_circle_row].gzwicrtid = l_gzwi_excel[l_circle_row].gzwicrtid 
               LET l_gzwi_email[l_circle_row].gzwicrtdp = l_gzwi_excel[l_circle_row].gzwicrtdp 
               LET l_gzwi_email[l_circle_row].gzwicrtdt = l_gzwi_excel[l_circle_row].gzwicrtdt 
               LET l_gzwi_email[l_circle_row].gzwimodid = l_gzwi_excel[l_circle_row].gzwimodid 
               LET l_gzwi_email[l_circle_row].gzwimoddt = l_gzwi_excel[l_circle_row].gzwimoddt 
               LET l_gzwi_email[l_circle_row].gzwi005_desc   = l_gzwi_excel[l_circle_row].gzwi005_desc  
               LET l_gzwi_email[l_circle_row].gzwi005dp_desc = l_gzwi_excel[l_circle_row].gzwi005dp_desc
               LET l_gzwi_email[l_circle_row].gzwi005op_desc = l_gzwi_excel[l_circle_row].gzwi005op_desc
            END IF
         END FOR
#         IF l_chk THEN
#            INITIALIZE g_errparam TO NULL
#            LET g_errparam.extend = ""
#            LET g_errparam.code = "azz-01130"
#            LET g_errparam.replace[1] = l_count_row
#            LET g_errparam.popup = TRUE
#            CALL cl_err()
#         END IF
      END FOR
      CALL s_transaction_end('Y','0')
      CALL cl_err_collect_show()
   END IF

   IF l_chk THEN
      LET l_server_uri = cl_get_para(g_enterprise,"",'A-SYS-0039')   #Help 接口網址
      IF NOT cl_null(l_server_uri) THEN
         IF (g_syncway = "eservice") THEN  #目前先都用eservice
            #詢問是否批次反映鼎新
            IF cl_ask_confirm("azz-01134") THEN
               CALL cl_helps932_sync_batch(TRUE,FALSE,l_diffnew) RETURNING l_gzwo_m
            END IF
         ELSE
            #詢問是否批次反映產中
            IF cl_ask_confirm("azz-01155") THEN
               CALL cl_helps932_sync_batch(TRUE,FALSE,l_diffnew) RETURNING l_gzwo_m
            END IF
         END IF
      END IF
      
      #詢問是否寄送mail
      IF cl_ask_confirm("azz-01156") THEN
         LET l_mail_chk = TRUE
      END IF
      
      IF l_mail_chk THEN
         FOR l_count = 1 TO l_gzwi_excel.getLength()
            IF l_gzwo_m[l_count].l_chk THEN  #反映成功
               LET l_gzwi_email[l_count].gzwi009   = l_gzwo_m[l_count].gzwo009  
               LET l_gzwi_email[l_count].gzwi014   = l_gzwo_m[l_count].gzwo014  
               LET l_gzwi_email[l_count].gzwimodid = l_gzwo_m[l_count].gzwomodid
               LET l_gzwi_email[l_count].gzwimoddt = l_gzwo_m[l_count].gzwomoddt
            END IF
            
            #新增成功,寄mail
            CALL cl_helps932_send_mail("1",g_enterprise,l_gzwi_email[l_count].*,l_attach) RETURNING l_chk
         END FOR
      END IF
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = ""
      LET g_errparam.code = "azz-01130"
      LET g_errparam.replace[1] = l_gzwi_excel.getLength()
      LET g_errparam.popup = TRUE
      CALL cl_err()
      
      LET g_wc = "gzwi001 >='", l_gzwi_excel[1].gzwi001 CLIPPED,"'",
             " AND gzwi001 <='",l_gzwi_excel[l_count_row].gzwi001 CLIPPED,"'",
             " AND gzwicrtid ='",l_gzwi_excel[1].gzwicrtid CLIPPED,"'"
   END IF
   
   #只要匯入成功，就要把匯入資料撈出來
   RETURN l_chk
END FUNCTION

################################################################################
# Descriptions...: 開啟excel檔
# Memo...........:
# Usage..........: CALL azzq932_openfile_excel(p_file_path)
#                  RETURNING lb_return
# Input parameter: p_file_path    檔案路徑
# Return code....: lb_return      開檔狀態
#                  workbook       
#                  workbook_xls
#                  g_xls_type     EXCEL格式  
# Date & Author..: No.160822-00010#1 2016/08/08 By frank0521
# Modify.........:
################################################################################
PRIVATE FUNCTION azzq932_openfile_excel(p_file_path)
   DEFINE l_import_excel_file     InputStream               #160822-00010#1
   DEFINE l_out_excel_file        FileOutputStream          #160822-00010#1
   DEFINE l_workbook              XSSFWorkbook              #160822-00010#1
   DEFINE l_workbook_xls          HSSFWorkbook              #160822-00010#1
   DEFINE l_xls_type              STRING                    #160822-00010#1 
   DEFINE ls_file_ext             STRING                    #160822-00010#1
   DEFINE p_file_path             STRING
   DEFINE lb_return               BOOLEAN
                                  
   LET ls_file_ext = os.Path.extension(p_file_path)
   IF ls_file_ext = 'xlsx' THEN
      LET l_xls_type = '1'
   ELSE
      LET l_xls_type = '2'
   END IF
   
   IF cl_null(ls_file_ext) THEN
      LET lb_return = FALSE
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "-16314" 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   ELSE
      LET lb_return = TRUE
      
      LET l_import_excel_file = NULL
      LET l_import_excel_file = FileInputStream.create(p_file_path)
       
      IF l_xls_type = '1' THEN
         LET l_workbook = NULL
         LET l_workbook = XSSFWorkbook.create(l_import_excel_file)
       
         CALL l_import_excel_file.close()
      ELSE
         LET l_workbook_xls = NULL
         LET l_workbook_xls = HSSFWorkbook.create(l_import_excel_file)
       
         CALL l_import_excel_file.close()
      END IF
   
   END IF
    
   RETURN lb_return, l_workbook, l_workbook_xls, l_xls_type
END FUNCTION

################################################################################
# Descriptions...: 檢查Excel
# Memo...........:
# Usage..........: CALL azzq932_check_excel(p_workbook,p_workbook_xls,p_xls_type)
#                  RETURNING TRUE or FALSE
# Input parameter: p_workbook
#                  p_workbook_xls
#                  p_xls_type     EXCEL格式
# Return code....: TRUE           檢查成功
#                  FALSE          檢查失敗
# Date & Author..: No.160822-00010#1 2016/08/08 By frank0521
# Modify.........:
################################################################################
PRIVATE FUNCTION azzq932_check_excel(p_workbook,p_workbook_xls,p_xls_type)
   DEFINE p_workbook                XSSFWorkbook       #160822-00010#1 參數
   DEFINE p_workbook_xls            HSSFWorkbook       #160822-00010#1 參數
   DEFINE p_xls_type                STRING             #160822-00010#1 參數
   DEFINE l_sheet                   XSSFSheet          #160822-00010#1
   DEFINE l_sheet_xls               HSSFSheet          #160822-00010#1
   DEFINE l_row                     XSSFRow            #160822-00010#1
   DEFINE l_row_xls                 HSSFRow            #160822-00010#1
   DEFINE l_cell                    XSSFCell           #160822-00010#1
   DEFINE l_cell_xls                HSSFCell           #160822-00010#1
   DEFINE l_gzwi_excel            DYNAMIC ARRAY OF type_g_gzwi_excel
   DEFINE l_circle_sheet          LIKE type_t.num10
   DEFINE l_circle_row            LIKE type_t.num10
   DEFINE l_circle_cell           LIKE type_t.num10
   DEFINE l_circle_con            LIKE type_t.num10
   DEFINE l_count_sheet           LIKE type_t.num10
   DEFINE l_count_row             LIKE type_t.num10
   DEFINE l_count_cell            LIKE type_t.num10
   DEFINE l_check_Success         LIKE type_t.num10
   DEFINE l_comment               STRING
   DEFINE l_colname_title_chk     STRING
   DEFINE l_colname_title_col     STRING
   DEFINE l_colname_gzwi002       STRING
   DEFINE l_colname_gzwi003       STRING
   DEFINE l_colname_gzwi004       STRING
   DEFINE l_colname_gzwi005       STRING
   DEFINE l_colname_gzwi008       STRING
   DEFINE l_colname_gzwi010       STRING
   DEFINE l_colname_gzwi028       STRING
   DEFINE l_uppercase_temp        STRING
   DEFINE l_process_bar_msg       STRING
   DEFINE l_chk_spec              LIKE type_t.num10
   DEFINE l_str                   STRING                ##161012-00007#1
   DEFINE l_ooag011               LIKE ooag_t.ooag011   #員工全名   #161012-00007#1
   DEFINE l_file_null             BOOLEAN 
   DEFINE lb_return               BOOLEAN 
   DEFINE l_err_chk               BOOLEAN               #161006-00007#1


   WHENEVER ERROR CONTINUE

   CALL s_azzi902_get_gzzd("azzq932","lbl_imptitle_chk") RETURNING l_colname_title_chk, l_comment
   LET g_coll_title[1] = l_colname_title_chk
   CALL s_azzi902_get_gzzd("azzq932","lbl_imptitle_col") RETURNING l_colname_title_col, l_comment
   LET g_coll_title[2] = l_colname_title_col

   CALL s_azzi902_get_gzzd("azzq932","lbl_gzwi002") RETURNING l_colname_gzwi002, l_comment
   CALL s_azzi902_get_gzzd("azzq932","lbl_gzwi003") RETURNING l_colname_gzwi003, l_comment
   CALL s_azzi902_get_gzzd("azzq932","lbl_gzwi004") RETURNING l_colname_gzwi004, l_comment
   CALL s_azzi902_get_gzzd("azzq932","lbl_gzwi005") RETURNING l_colname_gzwi005, l_comment
   CALL s_azzi902_get_gzzd("azzq932","lbl_gzwi008") RETURNING l_colname_gzwi008, l_comment
   CALL s_azzi902_get_gzzd("azzq932","lbl_gzwi010") RETURNING l_colname_gzwi010, l_comment
   CALL s_azzi902_get_gzzd("azzq932","lbl_gzwi028") RETURNING l_colname_gzwi028, l_comment

   ###161012-00007#1 START ###
   LET g_sql = "SELECT ooag011",
               " FROM ooag_t",
               " WHERE ooagent = ? AND ooag001 = ?"
   PREPARE azzq932_gzwi005_chk_pre FROM g_sql
   DECLARE azzq932_gzwi005_chk_cur CURSOR FOR azzq932_gzwi005_chk_pre
   ###161012-00007#1 END ###

   LET l_check_Success = 0
   LET l_file_null = TRUE

   #獲取 Excel文件的"Sheet"個數
   #LET l_count_sheet = azzq932_get_sheet_count(p_xls_type)

   #經過檢查後，將每個cell放入暫存temp array
   #(1)遍歷 Excel文件裡所有"Sheet"
   FOR l_circle_sheet = 1 TO 1   #l_count_sheet

      LET l_circle_con = l_circle_sheet - 1

      #當前"Sheet"
      CALL azzq932_get_sheet_at(l_circle_con, p_workbook, p_workbook_xls, p_xls_type) RETURNING l_sheet, l_sheet_xls

      #獲取當前"Sheet"行數
      LET l_count_row = 0
      LET l_count_row = azzq932_get_last_rownum(l_sheet, l_sheet_xls, p_xls_type)

      IF l_count_row < 1 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = ""
         LET g_errparam.code = "azz-00781"
         LET g_errparam.replace[1] = "Excel"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET l_check_Success = l_check_Success + 1       #確認是否有錯誤
      ELSE

         CALL cl_err_collect_init()
         CALL cl_progress_bar(l_count_row)               #progress bar開啟

         #(2)遍歷"Sheet"內所有"Row"
         FOR l_circle_row = 1 TO l_count_row

            LET l_process_bar_msg = cl_getmsg_parm("azz-01131",g_lang,l_circle_row)
            CALL cl_progress_ing(l_process_bar_msg)

            LET l_circle_con = l_circle_row

            #獲取當前"Row"
            CALL azzq932_get_row(l_circle_con,l_sheet,l_sheet_xls,p_xls_type) RETURNING l_row, l_row_xls

            #獲取當前 "Sheet"列數  固定為7欄資料
            LET l_count_cell = 7

            #(3)遍歷"Row"內所有"Cell"
            FOR l_circle_cell = 1 TO l_count_cell

               LET l_circle_con = 0
               LET l_circle_con = l_circle_cell - 1

               #獲取當前"Cell"
               CALL azzq932_get_cell(l_circle_con,l_row,l_row_xls,p_xls_type) RETURNING l_cell, l_cell_xls

               CASE l_circle_cell
                  WHEN 1   #反映人員  gzwi005
                     IF cl_null(l_cell) THEN
                        LET l_gzwi_excel[l_circle_row].gzwi005 = g_user #預設匯入資料者
                     ELSE
                        LET l_file_null = FALSE
                        LET l_gzwi_excel[l_circle_row].gzwi005 = azzq932_get_cell_value(l_cell,l_cell_xls,p_xls_type)
                        LET l_gzwi_excel[l_circle_row].gzwi005 = azzq932_num_to_str(l_gzwi_excel[l_circle_row].gzwi005)

                        #檢查反映人員基本資料是否存在
                        INITIALIZE g_errparam TO NULL
                        CALL cl_helps932_chk_isExist_gzwg004(g_enterprise,"2", l_gzwi_excel[l_circle_row].gzwi005,FALSE) RETURNING l_err_chk,g_errparam.code
                        IF NOT l_err_chk THEN   #檢查資料是否存在
                           LET g_errparam.extend = l_colname_gzwi005
                           LET g_errparam.popup = TRUE
                           LET g_errparam.coll_vals[1] = l_circle_row+1    #第幾筆資料
                           LET g_errparam.coll_vals[2] = l_colname_gzwi005 #哪個欄位
                           CALL cl_err()
                           LET l_check_Success = l_check_Success + 1       #確認是否有錯誤
                        ELSE
                           ###161012-00007#1 START ###
                           #限制反映人員不可使用特殊員工編號.員工全名不可有"top",例如tiptop、topprd、toptst、tiptoper
                           IF g_syncway = "alm" THEN
                              LET l_ooag011 = ""
                              FOREACH azzq932_gzwi005_chk_cur USING g_enterprise,l_gzwi_excel[l_circle_row].gzwi005 INTO l_ooag011
                                 LET l_str = l_ooag011
                                 LET l_str = l_str.toLowerCase()
                                 IF l_str.getIndexOf("top",1) > 0 THEN
                                    LET l_check_Success = l_check_Success + 1       #確認是否有錯誤
                                    LET g_errparam.extend = l_colname_gzwi005
                                    LET g_errparam.code = "azz-01157"  #%1帐号不能使用此功能
                                    LET g_errparam.replace[1] = l_gzwi_excel[l_circle_row].gzwi005,"(",l_ooag011,")"
                                    LET g_errparam.popup = TRUE
                                    LET g_errparam.coll_vals[1] = l_circle_row+1    #第幾筆資料
                                    LET g_errparam.coll_vals[2] = l_colname_gzwi005 #哪個欄位
                                    CALL cl_err()
                                    EXIT FOREACH
                                 END IF
                              END FOREACH
                           END IF
                           ###161012-00007#1 END ###
                        END IF
                     END IF

                     LET l_gzwi_excel[l_circle_row].gzwi018 = l_gzwi_excel[l_circle_row].gzwi005  #處理人員 等於 反映人員

                  WHEN 2   #模組  gzwi003
                     IF cl_null(l_cell) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = "adz-00255"
                        LET g_errparam.extend = l_colname_gzwi003
                        LET g_errparam.popup = TRUE
                        LET g_errparam.coll_vals[1] = l_circle_row + 1  #第幾筆資料
                        LET g_errparam.coll_vals[2] = l_colname_gzwi003 #哪個欄位
                        CALL cl_err()
                        LET l_check_Success = l_check_Success + 1       #確認是否有錯誤
                     ELSE
                        LET l_file_null = FALSE
                        LET l_gzwi_excel[l_circle_row].gzwi003 = azzq932_get_cell_value(l_cell,l_cell_xls,p_xls_type)
#                        LET l_file_null = FALSE
#
#                        LET g_sql = "SELECT COUNT(1)",
#                                    "  FROM gzzj_t",
#                                    " WHERE gzzj001 = ?"
#                        LET l_chk_spec = 0
#                        LET l_uppercase_temp = azzq932_get_cell_value(l_cell,l_cell_xls,p_xls_type)
#                        LET l_gzwi_excel[l_circle_row].gzwi003 = l_uppercase_temp.toUpperCase()  #先轉大寫
#
#                        PREPARE azzq932_check_excel_2 FROM g_sql
#                        EXECUTE azzq932_check_excel_2 USING l_gzwi_excel[l_circle_row].gzwi003 INTO l_chk_spec
#
#                        IF l_chk_spec <= 0 THEN
#                           INITIALIZE g_errparam TO NULL
#                           LET g_errparam.code = "azz-01129"
#                           LET g_errparam.extend = l_colname_gzwi003
#                           LET g_errparam.popup = TRUE
#                           LET g_errparam.coll_vals[1] = l_circle_row + 1  #第幾個資料
#                           LET g_errparam.coll_vals[2] = l_colname_gzwi003 #哪個欄位
#                           CALL cl_err()
#                           LET l_check_Success = l_check_Success + 1       #確認是否有錯誤
#                        END IF
                     END IF

                  WHEN 3   #作業編號  gzwi008
                     IF NOT cl_null(l_cell) THEN
                        LET l_file_null = FALSE
                        LET l_gzwi_excel[l_circle_row].gzwi008 = azzq932_get_cell_value(l_cell,l_cell_xls,p_xls_type)
                     END IF
#                     IF cl_null(l_cell) THEN
#                        IF cl_null(l_gzwi_excel[l_circle_row].gzwi003) THEN
#                           #模組編號為空時，檢查作業編號是否也為空
#                           INITIALIZE g_errparam TO NULL
#                           LET g_errparam.code = "adz-00255"
#                           LET g_errparam.extend = l_colname_gzwi003
#                           LET g_errparam.popup = TRUE
#                           LET g_errparam.coll_vals[1] = l_circle_row + 1  #第幾筆資料
#                           LET g_errparam.coll_vals[2] = l_colname_gzwi003 #哪個欄位
#                           CALL cl_err()
#                           LET l_check_Success = l_check_Success + 1       #確認是否有錯誤
#                        END IF
#                     ELSE
#                        LET l_file_null = FALSE
#
#                        LET g_sql = "SELECT COUNT(1)",
#                                    "  FROM gzzz_t",
#                                    " WHERE gzzz001 = ?"
#                        LET l_chk_spec = 0
#                        LET l_gzwi_excel[l_circle_row].gzwi008 = azzq932_get_cell_value(l_cell,l_cell_xls,p_xls_type)
#
#                        PREPARE azzq932_check_excel_3 FROM g_sql
#                        EXECUTE azzq932_check_excel_3 USING l_gzwi_excel[l_circle_row].gzwi008 INTO l_chk_spec
#
#                        IF l_chk_spec <= 0 THEN
#                           INITIALIZE g_errparam TO NULL
#                           LET g_errparam.code = "azz-01129"
#                           LET g_errparam.extend = l_colname_gzwi008
#                           LET g_errparam.popup = TRUE
#                           LET g_errparam.coll_vals[1] = l_circle_row + 1  #第幾個資料
#                           LET g_errparam.coll_vals[2] = l_colname_gzwi008 #哪個欄位
#                           CALL cl_err()
#                           LET l_check_Success = l_check_Success + 1       #確認是否有錯誤
#                        ELSE
#                          IF cl_null(l_gzwi_excel[l_circle_row].gzwi003) THEN
#                             LET l_uppercase_temp = l_gzwi_excel[l_circle_row].gzwi008
#                             LET l_uppercase_temp = l_uppercase_temp.subString(1,3)
#                             LET l_gzwi_excel[l_circle_row].gzwi003 = l_uppercase_temp.toUpperCase()  #先轉大寫
#                          ELSE
#                             LET g_sql = "SELECT COUNT(1)",
#                                         "  FROM gzzz_t",
#                                         " WHERE gzzz001 = ?",
#                                         "   AND gzzz005 = ?"
#                             LET l_chk_spec = 0
#
#                             PREPARE azzq932_check_excel_4 FROM g_sql
#                             EXECUTE azzq932_check_excel_4 USING l_gzwi_excel[l_circle_row].gzwi008, l_gzwi_excel[l_circle_row].gzwi003 INTO l_chk_spec
#
#                              IF l_chk_spec <= 0 THEN
#                                 INITIALIZE g_errparam TO NULL
#                                 LET g_errparam.code = "azz-00171"
#                                 LET g_errparam.extend = l_colname_gzwi008
#                                 LET g_errparam.popup = TRUE
#                                 LET g_errparam.replace[1] = l_gzwi_excel[l_circle_row].gzwi008
#                                 LET g_errparam.coll_vals[1] = l_circle_row + 1  #第幾個資料
#                                 LET g_errparam.coll_vals[2] = l_colname_gzwi008 #哪個欄位
#                                 CALL cl_err()
#                                 LET l_check_Success = l_check_Success + 1       #確認是否有錯誤
#                              END IF
#                          END IF
#                        END IF
#                     END IF

#                  WHEN 4   #企業編號  gzwi017
#                     IF cl_null(l_cell) THEN
#                        LET l_gzwi_excel[l_circle_row].gzwi017 = g_enterprise
#                     ELSE
#                        LET l_file_null = FALSE
#                        LET l_gzwi_excel[l_circle_row].gzwi017 = azzq932_get_cell_value(l_cell,l_cell_xls,p_xls_type)
#                     END IF
#
#                  WHEN 5   #營運據點   gzwi006
#                     IF cl_null(l_cell) THEN
#                        LET l_gzwi_excel[l_circle_row].gzwi006 = g_site
#                     ELSE
#                        LET l_file_null = FALSE
#                        LET l_gzwi_excel[l_circle_row].gzwi006 = azzq932_get_cell_value(l_cell,l_cell_xls,p_xls_type)
#                     END IF

                  WHEN 4  #問題描述  gzwi004
                     IF cl_null(l_cell) THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = "adz-00255"
                        LET g_errparam.extend = l_colname_gzwi004
                        LET g_errparam.popup = TRUE
                        LET g_errparam.coll_vals[1] = l_circle_row+1    #第幾筆資料
                        LET g_errparam.coll_vals[2] = l_colname_gzwi004 #哪個欄位
                        CALL cl_err()
                        LET l_check_Success = l_check_Success + 1       #確認是否有錯誤
                     ELSE
                        LET l_file_null = FALSE

                        LET l_gzwi_excel[l_circle_row].gzwi004 = azzq932_get_cell_value(l_cell,l_cell_xls,p_xls_type)
                     END IF

                  WHEN 5   #緊急案件  gzwi010
                     LET l_gzwi_excel[l_circle_row].gzwi010 = azzq932_get_cell_value(l_cell,l_cell_xls,p_xls_type)
                     LET l_uppercase_temp = azzq932_num_to_str(l_gzwi_excel[l_circle_row].gzwi010)
                     LET l_gzwi_excel[l_circle_row].gzwi010 = l_uppercase_temp.toUpperCase()  #先轉大寫
                     IF cl_null(l_cell) THEN
                        LET l_gzwi_excel[l_circle_row].gzwi010 = 'N'
                     ELSE
                        LET l_file_null = FALSE

                        IF (l_gzwi_excel[l_circle_row].gzwi010='Y') OR (l_gzwi_excel[l_circle_row].gzwi010='N') THEN
                        ELSE
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = "azz-01129"
                           LET g_errparam.extend = l_colname_gzwi010
                           LET g_errparam.popup = TRUE
                           LET g_errparam.coll_vals[1] = l_circle_row+1    #第幾筆資料
                           LET g_errparam.coll_vals[2] = l_colname_gzwi010 #哪個欄位
                           CALL cl_err()
                           LET l_check_Success = l_check_Success + 1       #確認是否有錯誤
                        END IF
                     END IF

                  WHEN 6  #問題分類  gzwi002
                     IF cl_null(l_cell) THEN
                        LET l_gzwi_excel[l_circle_row].gzwi002 = '4'  #預設'4'
                     ELSE
                        LET l_file_null = FALSE

                        LET g_sql = "SELECT COUNT(1)",
                                    "  FROM gzcb_t",
                                    " WHERE gzcb001 = 140",
                                    "   AND gzcb002 = ?"
                        LET l_chk_spec = 0
                        LET l_gzwi_excel[l_circle_row].gzwi002 = azzq932_get_cell_value(l_cell,l_cell_xls,p_xls_type)
                        LET l_gzwi_excel[l_circle_row].gzwi002 = azzq932_num_to_str(l_gzwi_excel[l_circle_row].gzwi002)

                        PREPARE azzq932_check_excel_1 FROM g_sql
                        EXECUTE azzq932_check_excel_1 USING l_gzwi_excel[l_circle_row].gzwi002 INTO l_chk_spec

                        IF l_chk_spec <= 0 THEN
                            INITIALIZE g_errparam TO NULL
                            LET g_errparam.code = "azz-01129"
                            LET g_errparam.extend = l_colname_gzwi002
                            LET g_errparam.popup = TRUE
                            LET g_errparam.coll_vals[1] = l_circle_row+1    #第幾筆資料
                            LET g_errparam.coll_vals[2] = l_colname_gzwi002 #哪個欄位
                            CALL cl_err()
                            LET l_check_Success = l_check_Success + 1       #確認是否有錯誤
                        END IF
                     END IF
                  WHEN 7  #客戶代號  gzwi028
                     IF g_syncway = "alm" THEN
                        IF NOT cl_null(l_cell) THEN
                           INITIALIZE g_errparam TO NULL
                           LET l_gzwi_excel[l_circle_row].gzwi028 = azzq932_get_cell_value(l_cell,l_cell_xls,p_xls_type)
                           LET l_gzwi_excel[l_circle_row].gzwi028 = azzq932_num_to_str(l_gzwi_excel[l_circle_row].gzwi028)
                           CALL cl_helps932_cust_exist(l_gzwi_excel[l_circle_row].gzwi028,FALSE) RETURNING l_err_chk,g_errparam.code
                           IF NOT l_err_chk THEN   #檢查資料是否存在
                              LET g_errparam.extend = l_colname_gzwi028
                              LET g_errparam.popup = TRUE
                              LET g_errparam.coll_vals[1] = l_circle_row+1    #第幾筆資料
                              LET g_errparam.coll_vals[2] = l_colname_gzwi028 #哪個欄位
                              CALL cl_err()
                              LET l_check_Success = l_check_Success + 1       #確認是否有錯誤
                           END IF
                        END IF
                     END IF
               END CASE
            END FOR
         END FOR

         IF l_file_null THEN
            CALL cl_err_collect_init()
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = ""
            LET g_errparam.code = "azz-00781"  #%1不可空白
            LET g_errparam.replace[1] = "Excel"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_check_Success = l_check_Success + 1       #確認是否有錯誤
            CALL cl_err_collect_show()
         ELSE
            CALL cl_err_collect_show()
         END IF
      END IF
   END FOR

   IF l_check_Success > 0 THEN
      LET lb_return = FALSE
   ELSE
      LET lb_return = TRUE
   END IF

   RETURN lb_return, l_gzwi_excel
END FUNCTION

################################################################################
# Descriptions...: 取得excel文件中sheet個數
# Memo...........:
# Usage..........: CALL azzq932_get_sheet_count(p_xls_type)
#                  RETURNING l_count_sheet
# Input parameter: p_xls_type     EXCEL格式
# Return code....: l_count_sheet  Sheet個數
# Date & Author..: No.160822-00010#1 2016/08/08 By frank0521
# Modify.........:
################################################################################
PRIVATE FUNCTION azzq932_get_sheet_count(p_xls_type)
   DEFINE l_workbook              XSSFWorkbook              #160822-00010#1
   DEFINE l_workbook_xls          HSSFWorkbook              #160822-00010#1
   DEFINE p_xls_type              STRING                    #160822-00010#1
   DEFINE l_count_sheet           INTEGER

   IF p_xls_type = '1' THEN
      #獲取"MS Excel文件"的"Sheet"个数
      LET l_count_sheet = 0
      LET l_count_sheet = l_workbook.getNumberOfSheets()
   ELSE
      LET l_count_sheet = 0
      LET l_count_sheet = l_workbook_xls.getNumberOfSheets()    
   END IF
   RETURN l_count_sheet
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzq932_get_sheet_at(p_sheet,p_workbook,p_workbook_xls,p_xls_type)
#                  RETURNING 
# Input parameter: p_sheet          指定sheet
#                  p_workbook
#                  p_workbook_xls
#                  p_xls_type       EXCEL格式
# Return code....: l_sheet          當前sheet
#                  l_sheet_xls      當前sheet
# Date & Author..: No.160822-00010#1 2016/08/08 By frank0521
# Modify.........:
################################################################################
PRIVATE FUNCTION azzq932_get_sheet_at(p_sheet,p_workbook,p_workbook_xls,p_xls_type)
   DEFINE p_workbook            XSSFWorkbook              #160822-00010#1
   DEFINE p_workbook_xls        HSSFWorkbook              #160822-00010#1
   DEFINE p_xls_type            STRING                    #160822-00010#1
   DEFINE p_sheet               INTEGER
   
   DEFINE l_sheet               XSSFSheet                 #160822-00010#1
   DEFINE l_sheet_xls           HSSFSheet                 #160822-00010#1
   
   #DEFINE lb_return  BOOLEAN

   IF p_xls_type = '1' THEN
      LET l_sheet = NULL
      LET l_sheet = p_workbook.getSheetAt(p_sheet)
   ELSE
      LET l_sheet_xls = NULL
      LET l_sheet_xls = p_workbook_xls.getSheetAt(p_sheet)       
   END IF
   #LET lb_return = TRUE
   RETURN l_sheet, l_sheet_xls
END FUNCTION

################################################################################
# Descriptions...: 取得資料行數
# Memo...........:
# Usage..........: CALL azzq932_get_last_rownum(p_sheet,p_sheet_xls,p_xls_type)
#                  RETURNING l_rownum
# Input parameter: p_sheet          當前sheet
#                  p_shett_xls      當前sheet
#                  p_xls_type       excel格式
# Return code....: l_rownum       資料行數
# Date & Author..: No.160822-00010#1 2016/08/08 By frank0521
# Modify.........:
################################################################################
PRIVATE FUNCTION azzq932_get_last_rownum(p_sheet,p_sheet_xls,p_xls_type)
   DEFINE p_sheet                 XSSFSheet                 #160822-00010#1
   DEFINE p_sheet_xls             HSSFSheet                 #160822-00010#1
   DEFINE p_xls_type              STRING                    #160822-00010#1
   DEFINE l_rownum                INTEGER

   #當前"Sheet"行數
   LET l_rownum = 0
   IF p_xls_type = '1' THEN
      LET l_rownum = p_sheet.getLastRowNum()
   ELSE
      LET l_rownum = p_sheet_xls.getLastRowNum()
   END IF
    
   RETURN l_rownum
END FUNCTION

################################################################################
# Descriptions...: 設定row
# Memo...........:
# Usage..........: CALL azzq932_get_row(p_row,p_sheet,p_sheet_xls,p_xls_type)
#                  RETURNING lb_return
# Input parameter: p_row            指定row
#                  p_sheet          當前sheet
#                  p_sheet_xls      當前sheet
#                  p_xls_type       EXCEL格式
# Return code....: l_row            當前row
#                  l_row_xls        當前row
# Date & Author..: No.160822-00010#1 2016/08/08 By frank0521
# Modify.........:
################################################################################
PRIVATE FUNCTION azzq932_get_row(p_row,p_sheet,p_sheet_xls,p_xls_type)
   DEFINE p_sheet                 XSSFSheet                 #160822-00010#1
   DEFINE p_sheet_xls             HSSFSheet                 #160822-00010#1
   DEFINE p_xls_type              STRING                    #160822-00010#1   
   DEFINE p_row                   INTEGER
   
   DEFINE l_row                   XSSFRow                   #160822-00010#1
   DEFINE l_row_xls               HSSFRow                   #160822-00010#1
   DEFINE lb_return               BOOLEAN

   IF p_xls_type = '1' THEN
      LET l_row = NULL
      LET l_row = p_sheet.getRow(p_row)
      IF l_row IS NULL THEN
         LET lb_return = FALSE          
      ELSE
         LET lb_return = TRUE
      END IF       
   ELSE
      LET l_row_xls = NULL
      LET l_row_xls = p_sheet_xls.getRow(p_row) 
      IF l_row_xls IS NULL THEN
         LET lb_return = FALSE          
      ELSE
         LET lb_return = TRUE
      END IF   
   END IF
   
   RETURN l_row, l_row_xls
END FUNCTION

################################################################################
# Descriptions...: 取得資料列數
# Memo...........:
# Usage..........: CALL azzq932_get_last_cell_num(p_row)
#                  RETURNING l_cellnum
# Input parameter: p_row          當前row
#                  p_row_xls      當前row
#                  p_xls_type     EXCEL格式
# Return code....: l_cellnum      資料列數
# Date & Author..: No.160822-00010#1 2016/08/08 By frank0521
# Modify.........:
################################################################################
PRIVATE FUNCTION azzq932_get_last_cell_num(p_row,p_row_xls,p_xls_type)
   DEFINE p_row                   XSSFRow                   #160822-00010#1
   DEFINE p_row_xls               HSSFRow                   #160822-00010#1
   DEFINE p_xls_type              STRING                    #160822-00010#1
   DEFINE l_cellnum               INTEGER

    #当前"Sheet"列数
   LET l_cellnum = 0
   IF p_xls_type = '1' THEN
       LET l_cellnum = p_row.getLastCellNum()
   ELSE
       LET l_cellnum = p_row_xls.getLastCellNum()    
   END IF
    
   RETURN l_cellnum
END FUNCTION

################################################################################
# Descriptions...: 設定cell
# Memo...........:
# Usage..........: CALL azzq932_get_cell(p_cell,p_row,p_row_xls,p_xls_type)
#                  RETURNING lb_return
# Input parameter: p_cell           指定cell
#                  p_row            當前row
#                  p_row_xls        當前row
#                  p_xls_type       EXCEL格式
# Return code....: l_cell           當前cell
#                  l_cell_xls       當前cell
# Date & Author..: No.160822-00010#1 2016/08/08 By frank0521
# Modify.........:
################################################################################
PRIVATE FUNCTION azzq932_get_cell(p_cell,p_row,p_row_xls,p_xls_type)
   DEFINE p_row                   XSSFRow                   #160822-00010#1
   DEFINE p_row_xls               HSSFRow                   #160822-00010#1
   DEFINE p_xls_type              STRING                    #160822-00010#1
   DEFINE p_cell                  INTEGER                   #指定cell
   
   DEFINE l_cell                  XSSFCell                  #160822-00010#1
   DEFINE l_cell_xls              HSSFCell                  #160822-00010#1
   DEFINE lb_return             BOOLEAN

   IF p_xls_type = '1' THEN
      LET l_cell = NULL
      LET l_cell = p_row.getCell(p_cell)
      IF l_cell IS NULL THEN
         LET lb_return = FALSE
      ELSE
         LET lb_return = TRUE
      END IF   
   ELSE
      LET l_cell_xls = NULL
      LET l_cell_xls = p_row_xls.getCell(p_cell)
      IF l_cell_xls IS NULL THEN
         LET lb_return = FALSE
      ELSE
         LET lb_return = TRUE
      END IF      
   END IF
    
   RETURN l_cell, l_cell_xls
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzq932_get_cell_type(p_cell,p_cell_xls,p_xls_type)
#                  RETURNING li_type
# Input parameter: p_cell           當前cell
#                  p_cell_xls       當前cell
#                  p_xls_type       EXCEL格式
# Return code....: li_type          欄位型態
# Date & Author..: No.160822-00010#1 2016/08/08 By frank0521
# Modify.........:
################################################################################
PRIVATE FUNCTION azzq932_get_cell_type(p_cell,p_cell_xls,p_xls_type)
   DEFINE p_cell                  XSSFCell                  #160822-00010#1
   DEFINE p_cell_xls              HSSFCell                  #160822-00010#1
   DEFINE p_xls_type              STRING                    #160822-00010#1
   DEFINE li_type                 INTEGER
                                 
   IF p_xls_type = '1' THEN
      LET li_type = p_cell.getCellType()
   ELSE
      LET li_type = p_cell_xls.getCellType()    
   END IF
    
   RETURN li_type
END FUNCTION

################################################################################
# Descriptions...: 取得欄位資料
# Memo...........:
# Usage..........: CALL azzq932_get_cell_value(p_cell,p_cell_xls,p_xls_type)
#                  RETURNING l_value_num or l_value_chr
# Input parameter: p_cell         當前cell
#                  p_cell_xls     當前cell
#                  p_xls_type     EXCEL格式
# Return code....: l_value_num or l_value_chr   欄位資料
# Date & Author..: No.160822-00010#1 2016/08/08 By frank0521
# Modify.........:
################################################################################
PRIVATE FUNCTION azzq932_get_cell_value(p_cell,p_cell_xls,p_xls_type)
   DEFINE p_cell                  XSSFCell                  #160822-00010#1
   DEFINE p_cell_xls              HSSFCell                  #160822-00010#1
   DEFINE p_xls_type              STRING                    #160822-00010#1
   DEFINE li_type                 INTEGER                   #160822-00010#1
   DEFINE l_value_chr             LIKE type_t.chr1000
   DEFINE l_value_num             LIKE type_t.num15_3
    
   LET li_type = azzq932_get_cell_type(p_cell,p_cell_xls,p_xls_type)
    
   #此处为数据处理部分
   CASE li_type
   #-------------------------------------------------
   #CELL_TYPE_NUMERIC Numeric Cell type (0)
   #CELL_TYPE_STRING String Cell type (1)
   #CELL_TYPE_FORMULA Formula Cell type (2)
   #CELL_TYPE_BLANK Blank Cell type (3)
   #CELL_TYPE_BOOLEAN Boolean Cell type (4)
   #CELL_TYPE_ERROR Error Cell type (5)
   #字符类型
       WHEN 0
          IF p_xls_type = '1' THEN 
             LET l_value_num = p_cell.getNumericCellValue()
          ELSE
             LET l_value_num = p_cell_xls.getNumericCellValue()
          END IF
          RETURN l_value_num
       WHEN 1
          IF p_xls_type = '1' THEN
             LET l_value_chr = p_cell.getStringCellValue()
          ELSE
             LET l_value_chr = p_cell_xls.getStringCellValue()
          END IF
          RETURN l_value_chr
       OTHERWISE
          RETURN ''
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 將讀入數字字串去掉小數點與位數
# Memo...........:
# Usage..........: CALL azzq932_num_to_str(p_num)
#                  RETURNING r_str
# Input parameter: p_num   欲修改的數字
# Return code....: r_str   修改後的數字
# Date & Author..: No.160822-00010#1 2016/08/08 By frank0521
# Modify.........:
################################################################################
PRIVATE FUNCTION azzq932_num_to_str(p_num)
   DEFINE p_num          STRING
   DEFINE r_str          STRING
   DEFINE l_index        INTEGER

   LET l_index = p_num.getIndexOf(".",1)
   IF l_index = 0 THEN
      RETURN p_num
   ELSE
      LET r_str = p_num.subString(1,l_index-1)
      RETURN r_str
   END IF
END FUNCTION

################################################################################
# Descriptions...: 將檔案傳至暫存temp
# Memo...........:
# Usage..........: CALL azzq932_import_file()
#                  RETURNING TURE or FALSE
# Input parameter: 
# Return code....: TRUE    開檔成功
#                  FALSE   開檔失敗
# Date & Author..: No.160822-00010#1 2016/09/01 By frank0521
# Modify.........:
################################################################################
PRIVATE FUNCTION azzq932_import_file()
   DEFINE l_str              STRING                                             #160822-00010#1
   DEFINE ls_upload          STRING                                             #160822-00010#1
   DEFINE l_file_basename    STRING                     #檔名                   #160822-00010#1
   DEFINE l_file_extension   STRING                     #副檔名                 #160822-00010#1
   DEFINE ls_pid             STRING                                             #160822-00010#1
   DEFINE l_new_path         STRING                                             #160822-00010#1
   DEFINE l_size             LIKE type_t.num10          #檔案大小                #160822-00010#1
   DEFINE l_size_sum         LIKE type_t.num10          #檔案大小總和            #160822-00010#1
   DEFINE l_file_num         LIKE type_t.num5           #上傳檔案的暫存檔名序號   #160822-00010#1
   
   DEFINE l_i                LIKE type_t.num10                                  #160822-00010#1 


   
   CALL cl_client_browse_file() RETURNING ls_upload
                  
   IF NOT cl_null(ls_upload) THEN   #C:/Users/P12345/Desktop/xxxxxx.xls
      LET l_file_extension = os.Path.extension(ls_upload)        #副檔名
      LET l_file_basename = os.Path.basename(ls_upload)          #原始檔名
      IF NOT cl_null(l_file_extension) THEN    #拿掉副檔名
         LET l_str = ".",l_file_extension
         LET l_file_basename = cl_replace_str(l_file_basename, l_str, "")
      END IF
      
      #放在暫存目錄要改名,避免檔名重複
      LET ls_pid = FGL_GETPID()
      LET l_file_num = l_file_num + 1
      LET l_str = l_file_num
      LET l_new_path = g_prog CLIPPED,"_",ls_pid CLIPPED,"_",g_user CLIPPED,"_",l_str CLIPPED,".",l_file_extension
      LET l_new_path = os.Path.join(FGL_GETENV("TEMPDIR"),l_new_path CLIPPED)
      CALL FGL_GETFILE(ls_upload,l_new_path)   #Transfers a file from the front end workstation to the application server machine.
      IF os.Path.exists(l_new_path) THEN
         RETURN TRUE, l_new_path
      ELSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "azz-00101"
         LET g_errparam.extend = ""
         LET g_errparam.popup = TRUE
         CALL cl_err()
      
         RETURN FALSE, l_new_path
      END IF
   ELSE
      RETURN FALSE, l_new_path
   END IF
END FUNCTION

 
{</section>}
 
