#該程式已解開Section, 不再透過樣板產出!
{<section id="azzi310_01.description" >}
#應用 a00 樣板自動產生(Version:1)
#+ Version..: T100-ERP-1.00.00(SD版次:1,PR版次:1) Build-000028
#+ 
#+ Filename...: azzi310_01
#+ Description: 
#+ Creator....: 02286(2015-06-10 10:16:39)
#+ Modifier...: 02286(2015-07-16 10:08:41) -SD/PR- 02286
 
{</section>}
 
{<section id="azzi310_01.global" >}
#應用 i01 樣板自動產生(Version:25)

 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目
IMPORT com
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔
GLOBALS
   DEFINE g_tab DYNAMIC ARRAY OF RECORD
       tabname       LIKE dzea_t.dzea001,
       tabnamec      LIKE dzea_t.dzea002,
       tabalias      LIKE dzgc_t.dzgc007
        END RECORD
  DEFINE g_tab_cnt   LIKE type_t.num5
  #160830-00018#1 add(s)
   DEFINE g_export_title     DYNAMIC ARRAY OF STRING  
   DEFINE g_azzi310_report    RECORD
            company      STRING,
            head_title   STRING,
            cdate        STRING,
            creator      STRING,
            corder       STRING,
            footer_title STRING,
            footer       STRING
          END RECORD
   #160830-00018#1 add(e)
END GLOBALS
#end add-point
 
#單頭 type 宣告
PRIVATE TYPE type_g_gzia_m RECORD
       gzia001 LIKE gzia_t.gzia001, 
   curr LIKE type_t.chr80, 
   total LIKE type_t.chr80
       END RECORD
 
#模組變數(Module Variables)
DEFINE g_gzia_m        type_g_gzia_m  #單頭變數宣告
DEFINE g_gzia_m_t      type_g_gzia_m  #單頭舊值宣告(系統還原用)
DEFINE g_gzia_m_o      type_g_gzia_m  #單頭舊值宣告(其他用途)
DEFINE g_gzia_m_mask_o type_g_gzia_m  #轉換遮罩前資料
DEFINE g_gzia_m_mask_n type_g_gzia_m  #轉換遮罩後資料
 
   DEFINE g_gzia001_t LIKE gzia_t.gzia001
 
 
DEFINE g_browser    DYNAMIC ARRAY OF RECORD  #查詢方案用陣列 
         b_statepic     LIKE type_t.chr50,
            b_gzia001 LIKE gzia_t.gzia001
      END RECORD 
   
 
   
 
DEFINE g_wc                  STRING                        #儲存查詢條件
DEFINE g_wc_t                STRING                        #備份查詢條件
DEFINE g_wc_filter           STRING                        #儲存過濾查詢條件
DEFINE g_wc_filter_t         STRING                        #備份過濾查詢條件
DEFINE g_sql                 STRING                        #資料撈取用SQL(含reference)
DEFINE g_forupd_sql          STRING                        #資料鎖定用SQL
DEFINE g_cnt                 LIKE type_t.num10             #指標/統計用變數
DEFINE g_jump                LIKE type_t.num10             #查詢指定的筆數 
DEFINE g_no_ask              LIKE type_t.num5              #是否開啟指定筆視窗 
DEFINE g_rec_b               LIKE type_t.num10             #單身筆數                         
DEFINE l_ac                  LIKE type_t.num10             #目前處理的ARRAY CNT 
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog     
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_pagestart           LIKE type_t.num10             #page起始筆數
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
DEFINE g_ch                  base.Channel                  #外串程式用
DEFINE g_state               STRING                        #確認前一個動作是否為新增/複製
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #reference用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #reference用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #reference用陣列
DEFINE g_error_show          LIKE type_t.num5              #是否顯示資料過多的錯誤訊息
DEFINE g_aw                  STRING                        #確定當下點擊的單身(modify_detail用)
DEFINE g_chk                 BOOLEAN                       #助記碼判斷用
DEFINE g_default             BOOLEAN                       #是否有外部參數查詢
DEFINE g_log1                STRING                        #cl_log_modified_record用(舊值)
DEFINE g_log2                STRING                        #cl_log_modified_record用(新值)
 
#快速搜尋用
DEFINE g_searchcol           STRING                        #查詢欄位代碼
DEFINE g_searchstr           STRING                        #查詢欄位字串
DEFINE g_order               STRING                        #查詢排序模式
 
#Browser用
DEFINE g_current_idx         LIKE type_t.num10             #Browser 所在筆數(當下page)
DEFINE g_current_row         LIKE type_t.num10             #Browser 所在筆數(暫存用)
DEFINE g_current_cnt         LIKE type_t.num10             #Browser 總筆數(當下page)
DEFINE g_browser_idx         LIKE type_t.num10             #Browser 所在筆數(所有資料)
DEFINE g_browser_cnt         LIKE type_t.num10             #Browser 總筆數(所有資料)
DEFINE g_row_index           LIKE type_t.num10             #階層樹狀用指標
DEFINE g_add_browse          STRING                        #新增填充用WC
 
#add-point:自定義模組變數(Module Variable)
 type type_field     RECORD
     field000,  #160523-00002#2 add
     field001, field002, field003, field004, field005, field006, field007,
     field008, field009, field010, field011, field012, field013, field014,
     field015, field016, field017, field018, field019, field020, field021,
     field022, field023, field024, field025, field026, field027, field028,
     field029, field030, field031, field032, field033, field034, field035,
     field036, field037, field038, field039, field040, field041, field042,
     field043, field044, field045, field046, field047, field048, field049,
     field050, field051, field052, field053, field054, field055, field056,
     field057, field058, field059, field060, field061, field062, field063,
     field064, field065, field066, field067, field068, field069, field070,
     field071, field072, field073, field074, field075, field076, field077,
     field078, field079, field080, field081, field082, field083, field084,
     field085, field086, field087, field088, field089, field090, field091,
     field092, field093, field094, field095, field096, field097, field098,
     field099, field100, field101, field102, field103, field104, field105, 
     field106, field107, field108, field109, field110, field111, field112,
     field113, field114, field115, field116, field117, field118, field119,
     field120, field121, field122, field123, field124, field125, field126,
     field127, field128, field129, field130, field131, field132, field133,
     field134, field135, field136, field137, field138, field139, field140,
     field141, field142, field143, field144, field145, field146, field147,
     field148, field149, field150 STRING 
    END RECORD 

 type type_field1     RECORD
     field001, field002, field003, field004, field005, field006, field007,
     field008, field009, field010, field011, field012, field013, field014,
     field015, field016, field017, field018, field019, field020, field021,
     field022, field023, field024, field025, field026, field027, field028,
     field029, field030, field031, field032, field033, field034, field035,
     field036, field037, field038, field039, field040, field041, field042,
     field043, field044, field045, field046, field047, field048, field049,
     field050, field051, field052, field053, field054, field055, field056,
     field057, field058, field059, field060, field061, field062, field063,
     field064, field065, field066, field067, field068, field069, field070,
     field071, field072, field073, field074, field075, field076, field077,
     field078, field079, field080, field081, field082, field083, field084,
     field085, field086, field087, field088, field089, field090, field091,
     field092, field093, field094, field095, field096, field097, field098,
     field099, field100, field101, field102, field103, field104, field105, 
     field106, field107, field108, field109, field110, field111, field112,
     field113, field114, field115, field116, field117, field118, field119,
     field120, field121, field122, field123, field124, field125, field126,
     field127, field128, field129, field130, field131, field132, field133,
     field134, field135, field136, field137, field138, field139, field140,
     field141, field142, field143, field144, field145, field146, field147,
     field148, field149, field150  LIKE type_t.chr1000
    END RECORD 
    
   GLOBALS
   
   DEFINE g_qryparam_form LIKE type_t.chr20
   DEFINE g_len        LIKE type_t.num5   #Report length
   DEFINE g_line       LIKE type_t.num10  #Report pagelength
   DEFINE g_page_line  LIKE type_t.num5   #Report lines for each page
   DEFINE g_xml_rep    VARCHAR(24) 
  #DEFINE ms_codeset    STRING
  #DEFINE ms_locale     STRING
  DEFINE g_query_prog    LIKE gzia_t.gzia001                  
  DEFINE g_query_cust    LIKE gzia_t.gzia003               
  #DEFINE g_gzid_err       LIKE type_t.num5                   
  DEFINE ga_table_data DYNAMIC ARRAY OF type_field
  #DEFINE g_mail_flag     LIKE type_t.num5   
  #DEFINE g_mail_tname LIKE type_t.chr100 
  #DEFINE g_out           STRING         
  DEFINE g_ze767     LIKE gzze_t.gzze003
  DEFINE g_ze768     LIKE gzze_t.gzze003
  DEFINE g_gzze00    LIKE gzze_t.gzze003
  DEFINE g_gzze01    LIKE gzze_t.gzze003
  DEFINE g_gzze02    LIKE gzze_t.gzze003
  DEFINE g_gzze03    LIKE gzze_t.gzze003
  DEFINE g_gzze04    LIKE gzze_t.gzze003
  DEFINE g_gzze06    LIKE gzze_t.gzze003
  DEFINE g_gzze07    LIKE gzze_t.gzze003

END GLOBALS 

DEFINE g_qry_feld_cnt  LIKE type_t.num5                   #字段数
DEFINE g_qry_feld      DYNAMIC ARRAY OF LIKE dzeb_t.dzeb003               #域名
DEFINE g_qry_feld_t    DYNAMIC ARRAY OF LIKE gzid_t.gzid004               #字段ID #160901-00030#1 mod dzeb002->gzid004
DEFINE g_qry_table     DYNAMIC ARRAY OF LIKE dzea_t.dzea001               #资料表代号
#DEFINE g_qry_feldshow  DYNAMIC ARRAY OF LIKE type_t.chr1
DEFINE g_qry_tran      DYNAMIC ARRAY OF LIKE type_t.chr1  #资料转换
DEFINE g_qry_scale     DYNAMIC ARRAY OF LIKE type_t.num10 #字段小数点
DEFINE g_qry_feld_type DYNAMIC ARRAY OF LIKE type_t.chr30 
DEFINE g_qry_seq       DYNAMIC ARRAY OF LIKE type_t.num5
DEFINE g_qry_length    DYNAMIC ARRAY OF LIKE type_t.num5    #字段长度
DEFINE g_qry_show      DYNAMIC ARRAY OF LIKE gzid_t.gzid005  #字段显示字段
DEFINE g_qry_qbe       DYNAMIC ARRAY OF LIKE gzid_t.gzid009  #字段开窗
DEFINE g_qry_flag      DYNAMIC ARRAY OF LIKE gzid_t.gzid014  #串查标志   #160523-00002#2 add
DEFINE g_qry_prog      DYNAMIC ARRAY OF LIKE gzid_t.gzid015  #串查程序   #160523-00002#2 add
DEFINE g_qry_jsarg     DYNAMIC ARRAY OF LIKE gzid_t.gzid017  #串查参数组 #160901-00030#1 add
DEFINE g_qry_attr      DYNAMIC ARRAY OF LIKE gzid_t.gzid010  #属性       #161213-00049 add
DEFINE g_qry_fmt       DYNAMIC ARRAY OF LIKE gztd_t.gztd014  #格式       #161213-00049 add

#DEFINE g_qry_feld_tmp  LIKE type_t.chr100                 
#DEFINE g_qry_feld_name LIKE type_t.chr100                 
#DEFINE g_qry_feldname  LIKE type_t.chr100 

#DEFINE g_scale_curr    DYNAMIC ARRAY OF RECORD
#                       curr_col     LIKE type_t.num5,     #小数位字段的币别字段
#                       scale_type   LIKE type_t.num5,     #小数字字段型态
#                       aza17        LIKE type_t.chr1      #是否为aza17
#                       END RECORD

DEFINE g_show_cnt      LIKE type_t.num5                   #示字段数 
 
DEFINE g_feld_group    DYNAMIC ARRAY OF STRING               #依群组显示 
DEFINE g_feld_sum      DYNAMIC ARRAY WITH DIMENSION 2 OF LIKE gzic_t.gzic003
DEFINE g_sum_name      DYNAMIC ARRAY OF STRING
#DEFINE g_sum_rec       DYNAMIC ARRAY OF RECORD              #记录计算的小计
#                         group_item LIKE type_t.num10,      #group sum 个数
#                         group_sum  LIKE type_t.num26_10,   #group sum 小计
#                         total_item LIKE type_t.num10,      #total sum 个数
#                         total_sum  LIKE type_t.num26_10,    #total sum 小计
#                         group_max  LIKE type_t.num26_10,
#                         group_min  LIKE type_t.num26_10,
#                         total_max  LIKE type_t.num26_10,
#                         total_min  LIKE type_t.num26_10
#                       END RECORD

DEFINE g_gzia001         LIKE gzia_t.gzia001
DEFINE g_gzial003         LIKE gzial_t.gzial003
DEFINE g_gzia002         LIKE gzia_t.gzia002
DEFINE g_gzia004         LIKE gzia_t.gzia004               
DEFINE g_gzia005         LIKE gzia_t.gzia005  
DEFINE g_gziastus         LIKE gzia_t.gziastus
DEFINE g_gzic_d_cnt       LIKE type_t.num5
DEFINE g_gzic_sum_cnt       LIKE type_t.num5
DEFINE g_gzib_d           DYNAMIC ARRAY OF RECORD
                             gzib002  LIKE gzib_t.gzib002,
                             gzib004  LIKE gzib_t.gzib004,
                             gzib005  LIKE gzib_t.gzib005,
                             gzib006  LIKE gzib_t.gzib006,
                             gzib007  LIKE gzib_t.gzib007 #151214-00004#2 add #增加资料表别名的信息，解决一表多用问题
                       END RECORD
DEFINE g_out_type      LIKE type_t.chr1 
DEFINE g_execmd        STRING                              #SQL指令
DEFINE g_gzic_d           DYNAMIC ARRAY OF RECORD
                             gzid004  LIKE gzid_t.gzid004,   #字段代号
                             gzid003  LIKE gzid_t.gzid003,   #表别名
                             gzic002  LIKE gzic_t.gzic002,   #序号
                             gzic003  LIKE gzic_t.gzic003,   #计算式
                             gzic004  LIKE gzic_t.gzic004,   #依group字段
                             gzic005  LIKE gzic_t.gzic005,   #group 字段序号
                             gzic006  LIKE gzic_t.gzic006,   #
                             ggzid004 LIKE gzid_t.gzid004,   #group 字段代号
                             gzib007  LIKE gzib_t.gzib007,   #group 字段表别名
                             gzic007  LIKE gzic_t.gzic007,    #显示方式 
                             gzid016  LIKE gzid_t.gzid016     #增加栏位别名 #160721-00005#1
                       END RECORD

DEFINE g_field_seq     DYNAMIC ARRAY OF RECORD             #记录查询字段顺序
                         id   STRING,                      #字段代码
                         name STRING,                      #域名 
                         len  LIKE type_t.num5,         #字段宽度 
                         type LIKE type_t.chr30,        #字段型态 
                         qbe  LIKE gzid_t.gzid009          #开窗(QBE) 
                       END RECORD
DEFINE g_page_max_rec    LIKE type_t.num10
DEFINE g_data_end        LIKE type_t.num10                #读取数据是否结束
DEFINE g_data_end_total  LIKE type_t.num10                #读取数据是否结束
DEFINE ga_table_data_t   DYNAMIC ARRAY OF type_field
DEFINE g_query_rec_b     LIKE type_t.num10

DEFINE ga_page_data DYNAMIC ARRAY OF type_field
DEFINE ga_page_data_t type_field
     
DEFINE ga_page_data_o type_field
DEFINE ga_sum_data DYNAMIC ARRAY WITH DIMENSION 2 OF type_field
DEFINE ga_sum_rec DYNAMIC ARRAY WITH DIMENSION 3 OF type_field
#DEFINE ga_sum_row  DYNAMIC ARRAY WITH DIMENSION 2 OF LIKE gzic_t.gzic002
DEFINE ga_sum_row  DYNAMIC ARRAY WITH DIMENSION 2 OF LIKE type_t.num10   #160310-00006#1 mod
 
DEFINE g_gzia006         LIKE gzia_t.gzia006
DEFINE g_header_str    STRING,    # Header Content
       g_trailer_str   STRING,    # Trailer Content
       g_curr_page     LIKE type_t.num10,   # Current Page Number
       g_total_page    LIKE type_t.num10,   # Total Pages 
       g_total_page_t  LIKE type_t.num10    # Total Pages-备用
DEFINE g_max_tag       LIKE type_t.num5
DEFINE g_next_tag      LIKE type_t.chr1
DEFINE g_curr_table    LIKE type_t.num10
DEFINE g_curr_page_t   LIKE type_t.num10
DEFINE g_col_value     STRING 
DEFINE g_col_text      STRING
DEFINE g_wc2           STRING                  #过滤条件
DEFINE g_wc_name       STRING                  #查询条件 -打印条件
DEFINE g_wc2_name      STRING                  #过滤条件 -打印条件
DEFINE g_sql_wc        STRING
DEFINE g_rec_b_t       LIKE type_t.num10     #單身筆數-備份c 
DEFINE lch_cmd          base.Channel
DEFINE tsconv_cmd       STRING
DEFINE os_type          STRING
DEFINE ms_codeset    STRING
DEFINE ms_locale     STRING
DEFINE g_bufstr                base.StringBuffer 
DEFINE g_w          DYNAMIC ARRAY OF LIKE type_t.num5 
DEFINE g_mail_flag     LIKE type_t.num5   
DEFINE g_mail_tname LIKE type_t.chr100 
#进阶查询变量
DEFINE g_dis_gzid       DYNAMIC ARRAY OF RECORD         #设定显示/隐藏数据  
                      gzid002   LIKE gzid_t.gzid002,
                       gzid005  LIKE  gzid_t.gzid005, 
                       gzid004   LIKE gzid_t.gzid004,       
                       gzidl004   LIKE gzidl_t.gzidl004       
                       END RECORD
DEFINE g_more          RECORD                          #排序/跳页/计算方式
                       s1   LIKE gzidl_t.gzidl004,    
                       s2   LIKE gzidl_t.gzidl004,      
                       s3   LIKE gzidl_t.gzidl004,     
                       t1   LIKE type_t.chr1,     
                       t2   LIKE type_t.chr1,     
                       t3   LIKE type_t.chr1,     
                       u1   LIKE type_t.chr1,     
                       u2   LIKE type_t.chr1,     
                       u3   LIKE type_t.chr1     
                       END RECORD
DEFINE g_gzic_d1          DYNAMIC ARRAY OF RECORD         #计算1(SUM)     
                       ngzid002_1   LIKE gzid_t.gzid002,    
                       ngzid004_1   LIKE gzid_t.gzid004,    
                       ngzidl004_1   LIKE gzidl_t.gzidl004,       
                       gzic003_1    LIKE gzic_t.gzic003,       
                       gzic007_1    LIKE gzic_t.gzic007       
                       END RECORD
DEFINE g_gzic_d2          DYNAMIC ARRAY OF RECORD         #计算2(SUM)     
                       ngzid002_2   LIKE gzid_t.gzid002,    
                       ngzid004_2   LIKE gzid_t.gzid004,    
                       ngzidl004_2   LIKE gzidl_t.gzidl004,       
                       gzic003_2    LIKE gzic_t.gzic003,       
                       gzic007_2    LIKE gzic_t.gzic007       
                       END RECORD
DEFINE g_gzic_d3          DYNAMIC ARRAY OF RECORD         #计算3(SUM)     
                       ngzid002_3   LIKE gzid_t.gzid002,    
                       ngzid004_3   LIKE gzid_t.gzid004,    
                       ngzidl004_3   LIKE gzidl_t.gzidl004,       
                       gzic003_3    LIKE gzic_t.gzic003,       
                       gzic007_3    LIKE gzic_t.gzic007       
                       END RECORD
DEFINE g_gzic_d1_rec_b    LIKE type_t.num10            #计算式1单身笔数
DEFINE g_gzic_d2_rec_b    LIKE type_t.num10            #计算式2单身笔数
DEFINE g_gzic_d3_rec_b    LIKE type_t.num10            #计算式3单身笔数
DEFINE g_db_tag        LIKE type_t.chr1             
DEFINE g_flag          LIKE type_t.num10
 
CONSTANT GI_MAX_COLUMN_COUNT INTEGER = 150,   
         GI_COLUMN_WIDTH     INTEGER = 10
         
DEFINE obj       util.JSONObject #160523-00002#2 add --回传json
DEFINE g_json_wc STRING          #160523-00002#2 add --回传json
#161215-00017#1 add (s)
DEFINE g_next_flag     LIKE type_t.chr1 
DEFINE g_next_pos      INTEGER
#161215-00017#1 add (e)
  DEFINE g_gzie           DYNAMIC ARRAY OF RECORD  #160523-00002#2 add --回传json
         gzie002          LIKE gzie_t.gzie002,
         gzie003          LIKE gzie_t.gzie003,
         gzie005          LIKE gzie_t.gzie005
         END RECORD
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable)

#end add-point
 
#add-point:傳入參數說明(global.argv)

#end add-point
 
{</section>}
 
{<section id="azzi310_01.main" >}
#應用 a27 樣板自動產生(Version:4)
#+ 作業開始(子程式類型)
PUBLIC FUNCTION azzi310_01(--)
   #add-point:main段變數傳入
   #p_prog,p_cust,p_sql,p_cmd,p_json_wc #160523-00002#2 add p_cmd,p_wc --传人json参数
   p_prog,p_cmd,p_json  #160523-00002#2 mod #传人json参数
   #end add-point
   )
   #add-point:main段define
  DEFINE p_prog      LIKE gzia_t.gzia001   
  DEFINE p_cust      LIKE gzia_t.gzia003                          
  DEFINE p_sql       LIKE gzia_t.gzia006
  DEFINE p_cmd       LIKE type_t.chr1  #160523-00002#2 add p_cmd --传人json参数
  DEFINE p_json  STRING            #160523-00002#2 add p_cmd --传人json参数
  DEFINE ls_cfg_path STRING,
         ls_4st_path STRING
         
    DEFINE lwin_curr       ui.Window
    DEFINE lfrm_curr         ui.Form
    DEFINE ln_win       om.DomNode,
    ls_path             STRING
    #160523-00002#2 add(s)  --传人json参数
    DEFINE l_str,l_json_wc,l_arg_value       STRING  
    DEFINE l_arg         LIKE gzie_t.gzie003    
    DEFINE l_i           INTEGER
    DEFINE l_gzia006_sb   base.StringBuffer        #替换SQL语句用
    #160523-00002#2 add(e)  --传人json参数
   #end add-point   
   #add-point:main段define(客製用)
   
   #end add-point   
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #add-point:作業初始化
    LET g_query_prog = p_prog CLIPPED
#    LET g_query_cust = p_cust CLIPPED    #160523-00002#2 mark                       
#    LET g_gzia006 = p_sql                #160523-00002#2 mark
   # IF cl_null(g_query_prog) OR cl_null(g_gzia006) 
   IF cl_null(g_query_prog)  #160523-00002#2 mod #传人json参数
    THEN
          RETURN
    END IF
 
    SELECT gzia001,gzial003,gzia002,gzia004,gzia005,gzia003,gzia006,gziastus #160523-00002#2 add g_gzia003,g_gzia006,g_gziastus #传入json
      INTO g_gzia001,g_gzial003,g_gzia002,g_gzia004,g_gzia005,g_query_cust,g_gzia006,g_gziastus
      FROM gzia_t LEFT OUTER JOIN gzial_t ON gzial001=gzia001 AND gzial002=g_dlang 
     WHERE gzia001=g_query_prog  #AND gzia003=g_query_cust   #160523-00002#2 mark 
     
     #160523-00002#2 add(s)
    IF g_gziastus ='N' THEN
       RETURN
    END IF
  
    IF g_gzia006 IS NULL THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_browser_cnt
         LET g_errparam.code   = "azz-00790" 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
        RETURN
    END IF
  
     #160523-00002#2 add(e)
     
    IF cl_null(g_gzia002) THEN
       LET g_gzia002 = 'N'
    END IF 
  
    LET g_out_type='V'  
    LET g_flag=0
    LET g_rec_b=50 
    CALL g_tab.clear()
    LET g_tab_cnt=0
  
    # LET p_json_wc="1=1"  #测试
    #CALL azzi310_parse_sqltable(g_gzia006)  #160523-00002#2 mark 传人json
     #160523-00002#2 add(s) 传人json
      LET g_tab_cnt=1
      DECLARE azzi310_01_gzig_curs CURSOR FOR SELECT gzig002,gzig003 FROM gzig_t WHERE gzig001=g_query_prog
      FOREACH azzi310_01_gzig_curs INTO g_tab[g_tab_cnt].tabname,g_tab[g_tab_cnt].tabalias 
         IF cl_null(g_tab[g_tab_cnt].tabalias ) THEN
         　　LET g_tab[g_tab_cnt].tabalias=g_tab[g_tab_cnt].tabname
         END IF
         LET g_tab_cnt=g_tab_cnt+1
      END FOREACH
      IF SQLCA.SQLCODE THEN
         LET g_errparam.code = sqlca.sqlcode 
         LET g_errparam.extend ='FOREACH azzi310_01_gzig_curs'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET INT_FLAG = 0
        RETURN
     END IF
      CALL g_tab.deleteElement(g_tab_cnt)
      LET g_tab_cnt=g_tab_cnt-1
     #160523-00002#2 add(e) 
    
    #160523-00002#2 mod (s) #传人json
    IF cl_null(p_json) THEN
       LET g_gzia006=azzi310_01_arg_replace(g_gzia006)
    ELSE
       LET obj = util.JSONObject.parse(p_json)
       LET l_i=1
        LET l_gzia006_sb = base.StringBuffer.create()
       CALL l_gzia006_sb.append(g_gzia006)
       DECLARE azzi310_01_gzie003_cur CURSOR FOR SELECT gzie003 FROM gzie_t WHERE gzie001=g_query_prog ORDER BY gzie002 
       FOREACH azzi310_01_gzie003_cur INTO l_arg
          LET l_arg_value=obj.get(l_arg)
          CALL l_gzia006_sb.replace(l_arg,l_arg_value,0)
       END FOREACH
      # LET l_json_wc=obj.get("wc")
        LET l_json_wc=azzi310_01_arg_replace(obj.get("wc"))   #161220-00028#1 mod
       LET g_gzia006=azzi310_01_arg_replace(l_gzia006_sb.toString())
       LET g_gzia002="N"
    END IF
      LET l_str = g_gzia006
      IF l_str.getIndexOf('arg',1) > 0 THEN
       INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = ''
         LET g_errparam.code   = "azz-00791" 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
       RETURN 
    END IF
    
    #160523-00002#2 mod (e)
    
    WHILE TRUE  
       LET g_max_tag = 0 
       #LET g_db_type=cl_db_get_database_type()    
       LET g_curr_table = 1
       LET g_execmd = ""
       LET g_next_tag = 'N'
      # LET g_wc = ""
       LET g_wc = l_json_wc   #160523-00002#2 add --传入json
       LET g_wc2 = ""
       LET g_wc_name = ""
       LET g_wc2_name = ""
       LET g_sql_wc = ""
 
       #CALL azzi310_01_sel('V')    
       CALL azzi310_01_sel(p_cmd)  #160523-00002#2 mod--传人json参数       
       IF INT_FLAG THEN                              
          LET INT_FLAG = 0
          RETURN
       END IF
       CALL ui.Interface.refresh()
      
       IF g_query_rec_b < 1 THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = 'lib-00073'
          LET g_errparam.extend =''
          LET g_errparam.popup = TRUE
          CALL cl_err()
          
          #IF g_gzia002 = "N" THEN
           IF g_gzia002 = "N" OR (g_gzia002 = "Y" AND g_field_seq.getLength()<1) THEN #161128-00023#1 mod 
             RETURN
          ELSE
             CONTINUE WHILE    
          END IF
          
       END IF
      
       LET g_curr_page = 1                            #目前頁數
       #算总页数,根据总笔数除每页笔数
          LET g_total_page = (ga_table_data.getLength()/g_rec_b)    #總頁數
          IF ga_table_data.getLength() MOD g_rec_b <> 0 THEN
             LET g_total_page = g_total_page + 1
          END IF
    
        #畫面開啟 (identifier)
        OPEN WINDOW w_azzi310_01 WITH FORM cl_ap_formpath("azz","azzi310_01")
                               
        #瀏覽頁簽資料初始化
         CALL cl_ui_init()
         #test
         #LET ls_cfg_path = os.Path.join(FGL_GETENV("ERP"), "cfg")
         #LET ls_4st_path = os.Path.join(os.Path.join(os.Path.join(ls_cfg_path, "4st"), g_lang), "designer.4st")
         #LET ls_4st_path = os.Path.join(os.Path.join(ls_cfg_path, "4st"), "azzi310_01.4st")
         #CALL ui.Interface.loadStyles(ls_4st_path)
         #test
       #CALL cl_load_4ad_interface(NULL)
    
       CALL azzi310_01_init()
    
       CALL azzi310_01_buildForm()
       
       #CALL azzi310_01_showPage()
       CALL azzi310_01_showPage_cont()
       
       CLOSE WINDOW w_azzi310_01

       IF INT_FLAG THEN
          LET INT_FLAG = 0         
          #IF g_gzia002 = "N" THEN 
          IF g_gzia002 ="N" OR g_field_seq.getLength()=0 THEN #161121-00024#1 mod
             EXIT WHILE
          END IF
       END IF
    END WHILE
     CALL cl_set_toolbaritem_visible("accept,cancel,home,logistics,personalwork,agendum,insert,modify,delete,reproduce,output,quickprint,query,filter,qbe_select,qbe_save,help,related_document",true)
    RETURN
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = "SELECT gzia001,'','' FROM gzia_t WHERE gzia001=? FOR UPDATE"
   #add-point:SQL_define
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)   #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE azzi310_01_cl CURSOR FROM g_forupd_sql     # LOCK CURSOR
 
   LET g_sql = " SELECT t0.gzia001",
               " FROM gzia_t t0",
               " WHERE  t0.gzia001 = ?"
   #add-point:SQL_define
   
   #end add-point
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE azzi310_01_master_referesh FROM g_sql
   
 
 
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_azzi310_01 WITH FORM cl_ap_formpath("azz","azzi310_01")
   
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   #程式初始化
   CALL azzi310_01_init()   
 
   #進入選單 Menu (="N")
   CALL azzi310_01_ui_dialog() 
 
   #畫面關閉
   CLOSE WINDOW w_azzi310_01
 
   CLOSE azzi310_01_cl
   
   
 
   #add-point:離開前
   
   #end add-point
END FUNCTION
 
 
 
{</section>}
 
{<section id="azzi310_01.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION azzi310_01_init()
   #add-point:init段define

   #end add-point
   #add-point:init段define(客製用)

   #end add-point
   #定義combobox狀態
   
   
   LET g_error_show = 1
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   
   #add-point:畫面資料初始化
  CALL cl_set_toolbaritem_visible("accept,cancel,home,logistics,personalwork,agendum,insert,modify,delete,reproduce,output,quickprint,query,filter,qbe_select,qbe_save,help,related_document",false)
  
   #end add-point
   
   #根據外部參數進行搜尋
#   CALL azzi310_01_default_search()  #修改程序框架
 
END FUNCTION
 
{</section>}
 
{<section id="azzi310_01.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION azzi310_01_ui_dialog() 
   DEFINE li_exit   LIKE type_t.num10       #判別是否為離開作業
   DEFINE li_idx    LIKE type_t.num10       #指標變數
   DEFINE ls_wc     STRING                  #wc用
   DEFINE la_param  RECORD                  #程式串查用變數
          prog       STRING,
          actionid   STRING,
          background LIKE type_t.chr1,
          param      DYNAMIC ARRAY OF STRING
                    END RECORD
   DEFINE ls_js     STRING                  #轉換後的json字串
   #add-point:ui_dialog段define

   #end add-point
   #add-point:ui_dialog段define(客製用)

   #end add-point
   LET li_exit = FALSE
   LET g_current_row = 0
   LET g_current_idx = 0
 
   
   #action default動作
   #應用 a42 樣板自動產生(Version:2)
   #進入程式時預設執行的動作
   CASE g_actdefault
      WHEN "insert"
         LET g_action_choice="insert"
         LET g_actdefault = ""
         IF cl_auth_chk_act("insert") THEN
            CALL azzi310_01_insert()
            #add-point:ON ACTION insert

            #END add-point
         END IF
 
      #add-point:action default自訂

      #end add-point
      OTHERWISE
   END CASE
 
 
   
   #add-point:ui_dialog段before dialog 

   #end add-point
 
   WHILE li_exit = FALSE
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_gzia_m.* TO NULL
         LET g_wc  = ' 1=2'
         LET g_action_choice = ""
         CALL azzi310_01_init()
      END IF
      
    
      #確保g_current_idx位於正常區間內
      #小於,等於0則指到第1筆
      IF g_current_idx <= 0 THEN
         LET g_current_idx = 1
      END IF
               
      IF g_main_hidden = 0 THEN
         MENU
            BEFORE MENU 
               #先填充browser資料
               CALL azzi310_01_browser_fill(g_wc,"")
               CALL cl_navigator_setting(g_current_idx, g_current_cnt)
               
               #還原為原本指定筆數
               IF g_current_row > 0 THEN
                  LET g_current_idx = g_current_row
               END IF
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL azzi310_01_fetch("")   
               END IF               
               #add-point:ui_dialog段 before menu

               #end add-point
            
 
 
               
            #第一筆資料
#            ON ACTION first
#               CALL azzi310_01_fetch("F") 
#               LET g_current_row = g_current_idx
            
            #下一筆資料
#            ON ACTION next
#               CALL azzi310_01_fetch("N")
#               LET g_current_row = g_current_idx
            
            #指定筆資料
#            ON ACTION jump
#               CALL azzi310_01_fetch("/")
#               LET g_current_row = g_current_idx
            
            #上一筆資料
#            ON ACTION previous
#               CALL azzi310_01_fetch("P")
#               LET g_current_row = g_current_idx
            
            #最後筆資料
#            ON ACTION last 
#               CALL azzi310_01_fetch("L")  
#               LET g_current_row = g_current_idx
            
            #離開程式
            ON ACTION exit
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT MENU 
            
            #離開程式
            ON ACTION close
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT MENU
            
            #主頁摺疊
            ON ACTION mainhidden   
               LET g_action_choice = "mainhidden"            
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
               EXIT MENU
               
            ON ACTION worksheethidden   #瀏覽頁折疊
            
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
          
            #查詢方案用
            ON ACTION queryplansel
               CALL cl_dlg_qryplan_select() RETURNING ls_wc
               #不是空條件才寫入g_wc跟重新找資料
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  CALL azzi310_01_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL azzi310_01_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL azzi310_01_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
            
            
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION first_page
            LET g_action_choice="first_page"
            IF cl_auth_chk_act("first_page") THEN
               
               #add-point:ON ACTION first_page

               #END add-point
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL azzi310_01_modify()
               #add-point:ON ACTION modify

               #END add-point
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL azzi310_01_delete()
               #add-point:ON ACTION delete

               #END add-point
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL azzi310_01_insert()
               #add-point:ON ACTION insert

               #END add-point
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION other_output
            LET g_action_choice="other_output"
            IF cl_auth_chk_act("other_output") THEN
               
               #add-point:ON ACTION other_output

               #END add-point
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output

               #END add-point
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL azzi310_01_reproduce()
               #add-point:ON ACTION reproduce

               #END add-point
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION last_page
            LET g_action_choice="last_page"
            IF cl_auth_chk_act("last_page") THEN
               
               #add-point:ON ACTION last_page

               #END add-point
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL azzi310_01_query()
               #add-point:ON ACTION query

               #END add-point
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION next_page
            LET g_action_choice="next_page"
            IF cl_auth_chk_act("next_page") THEN
               
               #add-point:ON ACTION next_page

               #END add-point
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION prev_page
            LET g_action_choice="prev_page"
            IF cl_auth_chk_act("prev_page") THEN
               
               #add-point:ON ACTION prev_page

               #END add-point
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION exit1
            LET g_action_choice="exit1"
            IF cl_auth_chk_act("exit1") THEN
               
               #add-point:ON ACTION exit1

               #END add-point
               
            END IF
 
 
 
            
            
            
            #應用 a46 樣板自動產生(Version:2)
         #新增相關文件
         ON ACTION related_document
            CALL azzi310_01_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document

               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL azzi310_01_set_pk_array()
            #add-point:ON ACTION agendum

            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL azzi310_01_set_pk_array()
            #add-point:ON ACTION followup

            #END add-point
            CALL cl_user_overview_follow('')
 
 
            
            #主選單用ACTION
            &include "main_menu_exit_menu.4gl"
            &include "relating_action.4gl"
            #交談指令共用ACTION
            &include "common_action.4gl"
            
         END MENU
      
      ELSE
      
         DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
           
      
            #左側瀏覽頁簽
            DISPLAY ARRAY g_browser TO s_browse.* ATTRIBUTE(COUNT=g_rec_b)
            
               BEFORE ROW
                  #回歸舊筆數位置 (回到當時異動的筆數)
                  LET g_current_idx = DIALOG.getCurrentRow("s_browse")
                  IF g_current_idx = 0 THEN
                     LET g_current_idx = 1
                  END IF
                  LET g_current_row = g_current_idx  #目前指標
                  LET g_current_sw = TRUE
                  CALL cl_show_fld_cont()     
                  
                  #當每次點任一筆資料都會需要用到               
                  CALL azzi310_01_fetch("")
 
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
    
               
            
            END DISPLAY
 
            #add-point:ui_dialog段自定義display array

            #end add-point
 
         
            BEFORE DIALOG
               #先填充browser資料
               IF g_action_choice <> "mainhidden" THEN
                  CALL azzi310_01_browser_fill(g_wc,"")
               END IF
 
               #當每次點任一筆資料都會需要用到  
               IF g_browser_cnt > 0 THEN
                  CALL azzi310_01_fetch("")   
               END IF          
               CALL cl_notice()
               
               #add-point:ui_dialog段before

               #end add-point  
            
            AFTER DIALOG
               #add-point:ui_dialog段 after dialog

               #end add-point
            
 
 
         
            
            
            #第一筆資料
#            ON ACTION first
#               CALL azzi310_01_fetch("F") 
#               LET g_current_row = g_current_idx
            
            #下一筆資料
#            ON ACTION next
#               CALL azzi310_01_fetch("N")
#               LET g_current_row = g_current_idx
         
            #指定筆資料
#            ON ACTION jump
#               CALL azzi310_01_fetch("/")
#               LET g_current_row = g_current_idx
         
            #上一筆資料
#            ON ACTION previous
#               CALL azzi310_01_fetch("P")
#               LET g_current_row = g_current_idx
          
            #最後筆資料
#            ON ACTION last 
#               CALL azzi310_01_fetch("L")  
#               LET g_current_row = g_current_idx
         
            #離開程式
            ON ACTION exit
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT DIALOG 
         
            #離開程式
            ON ACTION close
               LET g_action_choice="exit"
               LET INT_FLAG = FALSE
               LET li_exit = TRUE
               EXIT DIALOG 
    
            #主頁摺疊
            ON ACTION mainhidden 
               LET g_action_choice = "mainhidden"                
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
               #EXIT DIALOG
               
         
            ON ACTION exporttoexcel
               LET g_action_choice="exporttoexcel"
               IF cl_auth_chk_act("exporttoexcel") THEN
                  #browser
                  CALL g_export_node.clear()
                  LET g_export_node[1] = base.typeInfo.create(g_browser)
                  LET g_export_id[1]   = "s_browse"
                  CALL cl_export_to_excel()
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
 
            
            #查詢方案用
            ON ACTION queryplansel
               CALL cl_dlg_qryplan_select() RETURNING ls_wc
               #不是空條件才寫入g_wc跟重新找資料
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  CALL azzi310_01_browser_fill(g_wc,"F")   #browser_fill()會將notice區塊清空
                  CALL cl_notice()   #重新顯示,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               END IF
            
            #查詢方案用
            ON ACTION qbe_select
               CALL cl_qbe_list("m") RETURNING ls_wc
               IF NOT cl_null(ls_wc) THEN
                  LET g_wc = ls_wc
                  #取得條件後需要重查、跳到結果第一筆資料的功能程式段
                  CALL azzi310_01_browser_fill(g_wc,"F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code   = "-100" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL azzi310_01_fetch("F")
                  END IF
               END IF
               #重新搜尋會將notice區塊清空,此處不可用EXIT DIALOG, SUBDIALOG重讀會導致部分變數消失
               CALL cl_notice()
               
            
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION first_page
            LET g_action_choice="first_page"
            IF cl_auth_chk_act("first_page") THEN
               
               #add-point:ON ACTION first_page

               #END add-point
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION modify
            LET g_action_choice="modify"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = ''
               CALL azzi310_01_modify()
               #add-point:ON ACTION modify

               #END add-point
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION delete
            LET g_action_choice="delete"
            IF cl_auth_chk_act("delete") THEN
               CALL azzi310_01_delete()
               #add-point:ON ACTION delete

               #END add-point
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               CALL azzi310_01_insert()
               #add-point:ON ACTION insert

               #END add-point
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION other_output
            LET g_action_choice="other_output"
            IF cl_auth_chk_act("other_output") THEN
               
               #add-point:ON ACTION other_output

               #END add-point
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output

               #END add-point
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION reproduce
            LET g_action_choice="reproduce"
            IF cl_auth_chk_act("reproduce") THEN
               CALL azzi310_01_reproduce()
               #add-point:ON ACTION reproduce

               #END add-point
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION last_page
            LET g_action_choice="last_page"
            IF cl_auth_chk_act("last_page") THEN
               
               #add-point:ON ACTION last_page

               #END add-point
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL azzi310_01_query()
               #add-point:ON ACTION query

               #END add-point
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION next_page
            LET g_action_choice="next_page"
            IF cl_auth_chk_act("next_page") THEN
               
               #add-point:ON ACTION next_page

               #END add-point
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION prev_page
            LET g_action_choice="prev_page"
            IF cl_auth_chk_act("prev_page") THEN
               
               #add-point:ON ACTION prev_page

               #END add-point
               
            END IF
 
 
 
         #應用 a43 樣板自動產生(Version:2)
         ON ACTION exit1
            LET g_action_choice="exit1"
            IF cl_auth_chk_act("exit1") THEN
               
               #add-point:ON ACTION exit1

               #END add-point
               
            END IF
 
 
 
            
            
 
            #應用 a46 樣板自動產生(Version:2)
         #新增相關文件
         ON ACTION related_document
            CALL azzi310_01_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document

               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL azzi310_01_set_pk_array()
            #add-point:ON ACTION agendum

            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL azzi310_01_set_pk_array()
            #add-point:ON ACTION followup

            #END add-point
            CALL cl_user_overview_follow('')
 
 
 
            #主選單用ACTION
            &include "main_menu_exit_dialog.4gl"
            &include "relating_action.4gl"
            #交談指令共用ACTION
            &include "common_action.4gl"
            
         END DIALOG 
      
      END IF
      
      #add-point:ui_dialog段 after dialog

      #end add-point
      
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="azzi310_01.browser_fill" >}
#應用 a29 樣板自動產生(Version:7)
#+ 瀏覽頁簽資料填充(一般單檔)
PRIVATE FUNCTION azzi310_01_browser_fill(p_wc,ps_page_action) 
   DEFINE p_wc              STRING
   DEFINE ls_wc             STRING
   DEFINE ps_page_action    STRING
   DEFINE l_searchcol       STRING
   DEFINE l_sql             STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define
   
   #end add-point
   #add-point:browser_fill段define
   
   #end add-point
   
   LET l_searchcol = "gzia001"
 
   LET p_wc = p_wc.trim() #當查詢按下Q時 按下放棄 g_wc = "  " 所以要清掉空白
   IF cl_null(p_wc) THEN  #p_wc 查詢條件
      LET p_wc = " 1=1 " 
   END IF
   #add-point:browser_fill段wc控制
   
   #end add-point
 
   LET g_sql = " SELECT COUNT(*) FROM gzia_t ",
               "  ",
               "  ",
               " WHERE  ", 
               p_wc CLIPPED, cl_sql_add_filter("gzia_t")
                
   #add-point:browser_fill段cnt_sql
   
   #end add-point
                
   PREPARE header_cnt_pre FROM g_sql
   EXECUTE header_cnt_pre INTO g_browser_cnt
   FREE header_cnt_pre 
   
   #若超過最大顯示筆數
   IF g_browser_cnt > g_max_browse THEN
      IF g_error_show = 1 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_browser_cnt 
         LET g_errparam.code   = 9035
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
      END IF
   END IF
   
   
   IF ps_page_action = "F" OR
      ps_page_action = "P"  OR
      ps_page_action = "N"  OR
      ps_page_action = "L"  THEN
      LET g_page_action = ps_page_action
   END IF
   
   IF cl_null(g_add_browse) THEN
      #清除畫面
      CLEAR FORM
      INITIALIZE g_gzia_m.* TO NULL
      CALL g_browser.clear()
      LET g_cnt = 1
      LET ls_wc = p_wc
   ELSE
      LET ls_wc = g_add_browse
      LET g_cnt = g_current_idx
   END IF
   
   LET g_sql = " SELECT t0.gziastus,t0.gzia001",
               " FROM gzia_t t0 ",
               "  ",
               
               " WHERE  ", ls_wc, cl_sql_add_filter("gzia_t")
   #add-point:browser_fill段fill_wc
   
   #end add-point 
   LET g_sql = g_sql, " ORDER BY ",l_searchcol," ",g_order
   #add-point:browser_fill段before_pre
   
   #end add-point                    
 
   #LET g_sql = cl_sql_add_tabid(g_sql,"gzia_t")             #WC重組
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE browse_pre FROM g_sql
   DECLARE browse_cur CURSOR FOR browse_pre
 
   #CALL g_browser.clear()
   #LET g_cnt = 1
   FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_gzia001
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "foreach:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      
      
      
      #add-point:browser_fill段reference
      
      #end add-point
      
      
      
      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         EXIT FOREACH
      END IF
   END FOREACH
 
   #清空g_add_browse, 並指定指標位置
   IF NOT cl_null(g_add_browse) THEN
      LET g_add_browse = ""
      CALL g_curr_diag.setCurrentRow("s_browse",g_current_idx)
   END IF
   
   IF cl_null(g_browser[g_cnt].b_gzia001) THEN
      CALL g_browser.deleteElement(g_cnt)
   END IF
   
   LET g_header_cnt = g_browser.getLength()
   LET g_current_cnt = g_browser.getLength()
   LET g_browser_cnt = g_browser.getLength()
   LET g_rec_b = g_browser.getLength()
   LET g_cnt = 0
   DISPLAY g_browser_cnt TO FORMONLY.b_count
   DISPLAY g_browser_cnt TO FORMONLY.h_count
   
   
   FREE browse_pre
   
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
   
   #add-point:browser_fill段結束前
   
   #end add-point   
   
END FUNCTION
 
 
 
{</section>}
 
{<section id="azzi310_01.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION azzi310_01_construct()
   DEFINE ls_return      STRING
   DEFINE ls_result      STRING 
   DEFINE ls_wc          STRING 
   #add-point:cs段define
   
   #end add-point
   #add-point:cs段define(客製用)
   
   #end add-point
   
   #清空畫面&資料初始化
   CLEAR FORM
   INITIALIZE g_gzia_m.* TO NULL
   INITIALIZE g_wc TO NULL
   LET g_current_row = 1
 
   LET g_qryparam.state = "c"
 
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #螢幕上取條件
      CONSTRUCT BY NAME g_wc ON gzia001,curr,total
      
         BEFORE CONSTRUCT                                    
            #add-point:cs段more_construct
            
            #end add-point             
      
         #公用欄位開窗相關處理
         
      
         #一般欄位
                  #Ctrlp:construct.c.gzia001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzia001
            #add-point:ON ACTION controlp INFIELD gzia001
            #應用 a08 樣板自動產生(Version:2)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_gzia001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO gzia001  #顯示到畫面上
            NEXT FIELD gzia001                     #返回原欄位
    


            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzia001
            #add-point:BEFORE FIELD gzia001
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzia001
            
            #add-point:AFTER FIELD gzia001
            
            #END add-point
            
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD curr
            #add-point:BEFORE FIELD curr
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD curr
            
            #add-point:AFTER FIELD curr
            
            #END add-point
            
 
         #Ctrlp:construct.c.curr
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD curr
            #add-point:ON ACTION controlp INFIELD curr
            
            #END add-point
 
         #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD total
            #add-point:BEFORE FIELD total
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD total
            
            #add-point:AFTER FIELD total
            
            #END add-point
            
 
         #Ctrlp:construct.c.total
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD total
            #add-point:ON ACTION controlp INFIELD total
            
            #END add-point
 
 
           
      END CONSTRUCT
      
      #add-point:cs段more_construct
      
      #end add-point   
      
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog
         
         #end add-point  
      
      ON ACTION accept
         ACCEPT DIALOG
 
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
 
      #查詢方案列表
      ON ACTION qbe_select
         LET ls_wc = ""
         CALL cl_qbe_list("c") RETURNING ls_wc
    
      #條件儲存為方案
      ON ACTION qbe_save
         CALL cl_qbe_save()
 
      #交談指令共用ACTION
      &include "common_action.4gl"
         CONTINUE DIALOG
   END DIALOG
  
   #add-point:cs段after_construct
   
   #end add-point
  
END FUNCTION
 
{</section>}
 
{<section id="azzi310_01.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION azzi310_01_query()
   DEFINE ls_wc STRING
   #add-point:query段define
   
   #end add-point
   #add-point:query段define(客製用)
   
   #end add-point
   
   LET INT_FLAG = 0
   LET ls_wc = g_wc
   
   #切換畫面
 
   CALL g_browser.clear() 
 
   #browser panel折疊
   IF g_worksheet_hidden THEN
      CALL gfrm_curr.setElementHidden("worksheet_vbox",0)
      CALL gfrm_curr.setElementImage("worksheethidden","worksheethidden-24.png")
      LET g_worksheet_hidden = 0
   END IF
   
   #單頭折疊
   IF g_header_hidden THEN
      CALL gfrm_curr.setElementHidden("vb_master",0)
      CALL gfrm_curr.setElementImage("controls","headerhidden-24")
      LET g_header_hidden = 0
   END IF
 
   INITIALIZE g_gzia_m.* TO NULL
   ERROR ""
 
   DISPLAY " " TO FORMONLY.b_count
   DISPLAY " " TO FORMONLY.h_count
   CALL azzi310_01_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      LET g_wc = ls_wc
      CALL azzi310_01_browser_fill(g_wc,"F")
      CALL azzi310_01_fetch("")
      RETURN
   ELSE
      LET g_current_row = 1
      LET g_current_cnt = 0
   END IF
   
   #根據條件從新抓取資料
   LET g_error_show = 1
   CALL azzi310_01_browser_fill(g_wc,"F")   # 移到第一頁
   
   #儲存WC資訊
   CALL cl_dlg_save_user_latestqry("("||g_wc||")")
   
   #備份搜尋條件
   LET ls_wc = g_wc
   
   IF g_browser.getLength() = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "-100" 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
   ELSE
      CALL azzi310_01_fetch("F") 
   END IF
   
   LET g_wc_filter = ""
   
END FUNCTION
 
{</section>}
 
{<section id="azzi310_01.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION azzi310_01_fetch(p_fl)
   DEFINE p_fl       LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define
   
   #end add-point  
   #add-point:fetch段define(客製用)
   
   #end add-point
   
   #根據傳入的條件決定抓取的資料
   CASE p_fl
      WHEN "F" 
         LET g_current_idx = 1
      WHEN "P"
         IF g_current_idx > 1 THEN               
            LET g_current_idx = g_current_idx - 1
         END IF 
      WHEN "N"
         IF g_current_idx < g_header_cnt THEN
            LET g_current_idx =  g_current_idx + 1
         END IF        
      WHEN "L" 
         #LET g_current_idx = g_header_cnt        
         LET g_current_idx = g_browser.getLength()    
      WHEN "/"
         #詢問要指定的筆數
         IF (NOT g_no_ask) THEN      
            CALL cl_getmsg("fetch", g_lang) RETURNING ls_msg
            LET INT_FLAG = 0
 
            PROMPT ls_msg CLIPPED,": " FOR g_jump
               #交談指令共用ACTION
               &include "common_action.4gl"
            END PROMPT
            
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               EXIT CASE  
            END IF           
         END IF
         IF g_jump > 0 THEN
            LET g_current_idx = g_jump
         END IF
         LET g_no_ask = FALSE     
   END CASE
 
   #筆數顯示
   LET g_browser_idx = g_current_idx 
   IF g_browser_cnt > 0 THEN
      DISPLAY g_browser_idx TO FORMONLY.b_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.b_count #總筆數
      DISPLAY g_browser_idx TO FORMONLY.h_index #當下筆數
      DISPLAY g_browser_cnt TO FORMONLY.h_count #總筆數
   ELSE
      DISPLAY '' TO FORMONLY.b_index #當下筆數
      DISPLAY '' TO FORMONLY.b_count #總筆數
      DISPLAY '' TO FORMONLY.h_index #當下筆數
      DISPLAY '' TO FORMONLY.h_count #總筆數
   END IF
   
   
   CALL azzi310_01_browser_fill(g_wc,p_fl)
   
   #避免超出browser資料筆數上限
   IF g_current_idx > g_browser.getLength() THEN
      LET g_current_idx = g_browser.getLength()
   END IF
   
   # 設定browse索引
   CALL cl_navigator_setting(g_browser_idx, g_browser_cnt) 
 
   #代表沒有資料, 無需做後續資料撈取之動作
   IF g_current_idx = 0 THEN
      RETURN
   END IF
 
   #根據選定的筆數給予key欄位值
   LET g_gzia_m.gzia001 = g_browser[g_current_idx].b_gzia001
 
                       
   #讀取單頭所有欄位資料
   EXECUTE azzi310_01_master_referesh USING g_gzia_m.gzia001 INTO g_gzia_m.gzia001
   
   #遮罩相關處理
   LET g_gzia_m_mask_o.* =  g_gzia_m.*
   CALL azzi310_01_gzia_t_mask()
   LET g_gzia_m_mask_n.* =  g_gzia_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL azzi310_01_set_act_visible()
   CALL azzi310_01_set_act_no_visible()
 
   #add-point:fetch段action控制
   
   #end add-point  
   
   
   
   #保存單頭舊值
   LET g_gzia_m_t.* = g_gzia_m.*
   LET g_gzia_m_o.* = g_gzia_m.*
   
   
   #重新顯示
   CALL azzi310_01_show()
   
 
END FUNCTION
 
{</section>}
 
{<section id="azzi310_01.insert" >}
#+ 資料新增
PRIVATE FUNCTION azzi310_01_insert()
   #add-point:insert段define
   
   #end add-point    
   #add-point:insert段define(客製用)
   
   #end add-point
   
   CLEAR FORM #清畫面欄位內容
   INITIALIZE g_gzia_m.* LIKE gzia_t.*             #DEFAULT 設定
   LET g_gzia001_t = NULL
 
   
   #add-point:insert段before
   
   #end add-point    
   
   CALL s_transaction_begin()
   
   WHILE TRUE
      
      #公用欄位給值
      
 
      #append欄位給值
      
     
      #一般欄位給值
      
 
      #add-point:單頭預設值
      
      #end add-point   
     
      #顯示狀態(stus)圖片
      
     
      #資料輸入
      CALL azzi310_01_input("a")
      
      #add-point:單頭輸入後
      
      #end add-point
      
      IF INT_FLAG THEN
         #取消
         LET INT_FLAG = 0
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         DISPLAY g_current_cnt TO FORMONLY.h_count     #總筆數
         DISPLAY g_current_idx TO FORMONLY.h_index     #當下筆數
         INITIALIZE g_gzia_m.* TO NULL
         CALL azzi310_01_show()
         RETURN
      END IF
 
      LET g_rec_b = 0
      EXIT WHILE
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL azzi310_01_set_act_visible()
   CALL azzi310_01_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_gzia001_t = g_gzia_m.gzia001
 
   
   #組合新增資料的條件
   LET g_add_browse = " ",
                      " gzia001 = '", g_gzia_m.gzia001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL azzi310_01_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
 
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE azzi310_01_master_referesh USING g_gzia_m.gzia001 INTO g_gzia_m.gzia001
   
   #遮罩相關處理
   LET g_gzia_m_mask_o.* =  g_gzia_m.*
   CALL azzi310_01_gzia_t_mask()
   LET g_gzia_m_mask_n.* =  g_gzia_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_gzia_m.gzia001,g_gzia_m.curr,g_gzia_m.total
 
   #add-point:新增結束後
   
   #end add-point 
 
   #功能已完成,通報訊息中心
   CALL azzi310_01_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="azzi310_01.modify" >}
#+ 資料修改
PRIVATE FUNCTION azzi310_01_modify()
   #add-point:modify段define
   
   #end add-point
   #add-point:modify段define(客製用)
   
   #end add-point
   
   #先確定key值無遺漏
   IF g_gzia_m.gzia001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF 
 
   ERROR ""
  
   #備份key值
   LET g_gzia001_t = g_gzia_m.gzia001
 
   
   CALL s_transaction_begin()
   
   #先lock資料
   OPEN azzi310_01_cl USING g_gzia_m.gzia001
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN azzi310_01_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CLOSE azzi310_01_cl
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE azzi310_01_master_referesh USING g_gzia_m.gzia001 INTO g_gzia_m.gzia001
 
   #檢查是否允許此動作
   IF NOT azzi310_01_action_chk() THEN
      RETURN
   END IF
 
   #遮罩相關處理
   LET g_gzia_m_mask_o.* =  g_gzia_m.*
   CALL azzi310_01_gzia_t_mask()
   LET g_gzia_m_mask_n.* =  g_gzia_m.*
   
   
 
   #顯示資料
   CALL azzi310_01_show()
   
   WHILE TRUE
      LET g_gzia_m.gzia001 = g_gzia001_t
 
      
      #寫入修改者/修改日期資訊
      
      
      #add-point:modify段修改前
      
      #end add-point
 
      #資料輸入
      CALL azzi310_01_input("u")     
 
      #add-point:modify段修改後
      
      #end add-point
      
      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_gzia_m.* = g_gzia_m_t.*
         CALL azzi310_01_show()
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "" 
         LET g_errparam.code   = 9001 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         EXIT WHILE
      END IF
 
      #若有modid跟moddt則進行update
 
 
      EXIT WHILE
      
   END WHILE
 
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL azzi310_01_set_act_visible()
   CALL azzi310_01_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " ",
                      " gzia001 = '", g_gzia_m.gzia001, "' "
 
   #填到對應位置
   CALL azzi310_01_browser_fill(g_wc,"")
 
   CLOSE azzi310_01_cl
 
   #功能已完成,通報訊息中心
   CALL azzi310_01_msgcentre_notify('modify')
   
   LET g_worksheet_hidden = 0
   
END FUNCTION   
 
{</section>}
 
{<section id="azzi310_01.input" >}
#+ 資料輸入
PRIVATE FUNCTION azzi310_01_input(p_cmd)
   DEFINE p_cmd           LIKE type_t.chr1
   DEFINE l_ac_t          LIKE type_t.num10       #未取消的ARRAY CNT 
   DEFINE l_n             LIKE type_t.num10       #檢查重複用  
   DEFINE l_cnt           LIKE type_t.num10       #檢查重複用  
   DEFINE l_lock_sw       LIKE type_t.chr1        #單身鎖住否  
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num10
   DEFINE l_i             LIKE type_t.num10
   DEFINE l_insert        LIKE type_t.num10
   DEFINE ls_return       STRING
   DEFINE l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak  DYNAMIC ARRAY OF STRING
   DEFINE l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE l_vars          DYNAMIC ARRAY OF STRING
   DEFINE l_fields        DYNAMIC ARRAY OF STRING
   #add-point:input段define
   
   #end add-point
   #add-point:input段define(客製用)
   
   #end add-point
   
   #切換至輸入畫面
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_gzia_m.gzia001,g_gzia_m.curr,g_gzia_m.total
   
   CALL cl_set_head_visible("","YES")  
   
   #a-新增,r-複製,u-修改
   IF p_cmd = 'r' THEN
      #此段落的r動作等同於a
      LET p_cmd = 'a'
   END IF
 
   LET l_insert = FALSE
   LET g_action_choice = ""
 
   LET g_qryparam.state = "i"
   
   #控制key欄位可否輸入
   CALL azzi310_01_set_entry(p_cmd)
   #add-point:set_entry後
   
   #end add-point
   CALL azzi310_01_set_no_entry(p_cmd)
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   #add-point:資料輸入前
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #單頭段
      INPUT BY NAME g_gzia_m.gzia001 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #其他table資料備份(確定是否更改用)
            
            #add-point:input開始前
            
            #end add-point
   
                  #應用 a01 樣板自動產生(Version:1)
         BEFORE FIELD gzia001
            #add-point:BEFORE FIELD gzia001
            
            #END add-point
 
         #應用 a02 樣板自動產生(Version:1)
         AFTER FIELD gzia001
            
            #add-point:AFTER FIELD gzia001
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_gzia_m.gzia001) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_gzia_m.gzia001 != g_gzia001_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gzia_t WHERE "||"gzia001 = '"||g_gzia_m.gzia001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
         #應用 a04 樣板自動產生(Version:2)
         ON CHANGE gzia001
            #add-point:ON CHANGE gzia001
            
            #END add-point 
 
 #欄位檢查
                  #Ctrlp:input.c.gzia001
         #應用 a03 樣板自動產生(Version:2)
         ON ACTION controlp INFIELD gzia001
            #add-point:ON ACTION controlp INFIELD gzia001
            #應用 a07 樣板自動產生(Version:2)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_gzia_m.gzia001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #


            CALL q_gzza001_5()                                #呼叫開窗

            LET g_gzia_m.gzia001 = g_qryparam.return1              

            DISPLAY g_gzia_m.gzia001 TO gzia001              #

            NEXT FIELD gzia001                          #返回原欄位


            #END add-point
 
 #欄位開窗
 
         AFTER INPUT
            #若點選cancel則離開dialog
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
            
            #錯誤訊息統整顯示
            #CALL cl_err_collect_show()
            #CALL cl_showmsg()
  
            IF p_cmd <> "u" THEN
               #當p_cmd不為u代表為新增/複製
               LET l_count = 1  
 
               #確定新增的資料不存在(不重複)
               SELECT COUNT(*) INTO l_count FROM gzia_t
                WHERE  gzia001 = g_gzia_m.gzia001
 
               IF l_count = 0 THEN
               
                  #add-point:單頭新增前
                  
                  #end add-point
               
                  #將新增的單頭資料寫入資料庫
                  INSERT INTO gzia_t (gzia001)
                  VALUES (g_gzia_m.gzia001) 
                  
                  #add-point:單頭新增中
                  
                  #end add-point
                  
                  #若寫入錯誤則提示錯誤訊息並返回輸入頁面
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzia_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
                  
                  
                  
                  #資料多語言用-增/改
                  
                  
                  #add-point:單頭新增後
                  
                  #end add-point
                  
               ELSE
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend =  "g_gzia_m.gzia001" 
                  LET g_errparam.code   = "std-00006" 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
               END IF 
            ELSE
               #add-point:單頭修改前
               
               #end add-point
               
               #將遮罩欄位還原
               CALL azzi310_01_gzia_t_mask_restore('restore_mask_o')
               
               UPDATE gzia_t SET (gzia001) = (g_gzia_m.gzia001)
                WHERE  gzia001 = g_gzia001_t #
 
               #add-point:單頭修改中
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzia_t" 
                     LET g_errparam.code   = "std-00009" 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "gzia_t" 
                     LET g_errparam.code   = SQLCA.sqlcode 
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  OTHERWISE
                     
                     #資料多語言用-增/改
                     
                     
                     #將遮罩欄位進行遮蔽
                     CALL azzi310_01_gzia_t_mask_restore('restore_mask_n')
                     
                     #add-point:單頭修改後
                     
                     #end add-point
                     #修改歷程記錄(單頭修改)
                     LET g_log1 = util.JSON.stringify(g_gzia_m_t)
                     LET g_log2 = util.JSON.stringify(g_gzia_m)
                     IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                     ELSE
                     END IF
               END CASE
               
            END IF
           #controlp
      END INPUT
      
      #add-point:input段more input 
      
      #end add-point
    
      BEFORE DIALOG
         #CALL cl_err_collect_init()
         #add-point:input段before_dialog 
         
         #end add-point
          
      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name, g_fld_name, g_lang)
 
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
         ACCEPT DIALOG
         
      #放棄輸入
      ON ACTION cancel
         LET g_action_choice=""
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      #在dialog 右上角 (X)
      ON ACTION close 
         LET INT_FLAG = TRUE 
         EXIT DIALOG
    
      #toolbar 離開
      ON ACTION exit
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
 
{<section id="azzi310_01.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION azzi310_01_reproduce()
   DEFINE l_newno     LIKE gzia_t.gzia001 
   DEFINE l_oldno     LIKE gzia_t.gzia001 
 
   DEFINE l_master    RECORD LIKE gzia_t.*
   DEFINE l_cnt       LIKE type_t.num10
   #add-point:reproduce段define
   
   #end add-point   
   #add-point:reproduce段define(客製用)
   
   #end add-point
   
   #切換畫面
   
   #先確定key值無遺漏
   IF g_gzia_m.gzia001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   #備份key值
   LET g_gzia001_t = g_gzia_m.gzia001
 
   
   #清空key值
   LET g_gzia_m.gzia001 = ""
 
    
   CALL azzi310_01_set_entry("a")
   CALL azzi310_01_set_no_entry("a")
   
   #公用欄位給予預設值
   
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前
   
   #end add-point
   
   #顯示狀態(stus)圖片
   
   
   #清空key欄位的desc
   
   
   #資料輸入
   CALL azzi310_01_input("r")
   
   IF INT_FLAG THEN
      #取消
      LET INT_FLAG = 0
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = 9001 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      INITIALIZE g_gzia_m.* TO NULL
      CALL azzi310_01_show()
      RETURN
   END IF
   
   CALL s_transaction_begin()
   
   #add-point:單頭複製前
   
   #end add-point
   
   #add-point:單頭複製中
   
   #end add-point
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "gzia_t" 
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #add-point:單頭複製後
   
   #end add-point
   
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,delete,reproduce", TRUE)
   CALL azzi310_01_set_act_visible()
   CALL azzi310_01_set_act_no_visible()
 
   #將新增的資料併入搜尋條件中
   LET g_state = "insert"
   
   LET g_gzia001_t = g_gzia_m.gzia001
 
   
   #組合新增資料的條件
   LET g_add_browse = " ",
                      " gzia001 = '", g_gzia_m.gzia001, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL azzi310_01_browser_fill("","")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後
   
   #end add-point
                 
   #功能已完成,通報訊息中心
   CALL azzi310_01_msgcentre_notify('reproduce')
                 
END FUNCTION
 
{</section>}
 
{<section id="azzi310_01.show" >}
#+ 資料顯示 
PRIVATE FUNCTION azzi310_01_show()
   #add-point:show段define
   
   #end add-point  
   #add-point:show段define(客製用)
   
   #end add-point
   
   #add-point:show段之前
   
   #end add-point
   
   
   
   #帶出公用欄位reference值
   
    
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:2)
   CALL azzi310_01_set_pk_array()
   #add-point:ON ACTION agendum
   
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
   
   #讀入ref值(單頭)
   #add-point:show段reference
   
   #end add-point
 
   #將資料輸出到畫面上
   DISPLAY BY NAME g_gzia_m.gzia001,g_gzia_m.curr,g_gzia_m.total
   
   #儲存PK
   LET l_ac = g_current_idx
   CALL azzi310_01_set_pk_array()
   
   #顯示狀態(stus)圖片
   
 
   #顯示有特殊格式設定的欄位或說明
   CALL cl_show_fld_cont()
 
   #add-point:show段之後
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="azzi310_01.delete" >}
#+ 資料刪除 
PRIVATE FUNCTION azzi310_01_delete()
   DEFINE  l_var_keys      DYNAMIC ARRAY OF STRING
   DEFINE  l_field_keys    DYNAMIC ARRAY OF STRING
   DEFINE  l_vars          DYNAMIC ARRAY OF STRING
   DEFINE  l_fields        DYNAMIC ARRAY OF STRING
   DEFINE  l_var_keys_bak  DYNAMIC ARRAY OF STRING
   #add-point:delete段define
   
   #end add-point  
   #add-point:delete段define(客製用)
   
   #end add-point
   
   #先確定key值無遺漏
   IF g_gzia_m.gzia001 IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
    
   LET g_gzia001_t = g_gzia_m.gzia001
 
   
   
 
   OPEN azzi310_01_cl USING g_gzia_m.gzia001
 
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN azzi310_01_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CLOSE azzi310_01_cl
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE azzi310_01_master_referesh USING g_gzia_m.gzia001 INTO g_gzia_m.gzia001
   
   #檢查是否允許此動作
   IF NOT azzi310_01_action_chk() THEN
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_gzia_m_mask_o.* =  g_gzia_m.*
   CALL azzi310_01_gzia_t_mask()
   LET g_gzia_m_mask_n.* =  g_gzia_m.*
   
   #將最新資料顯示到畫面上
   CALL azzi310_01_show()
   
   IF cl_ask_delete() THEN
 
      #add-point:單頭刪除前
      
      #end add-point
 
      #應用 a47 樣板自動產生(Version:2)
      #刪除相關文件
      CALL azzi310_01_set_pk_array()
      #add-point:相關文件刪除前
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
 
      DELETE FROM gzia_t 
       WHERE  gzia001 = g_gzia_m.gzia001 
 
 
      #add-point:單頭刪除中
      
      #end add-point
         
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "gzia_t" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
      END IF
  
      
      
      #add-point:單頭刪除後
      
      #end add-point
      
       
 
      #修改歷程記錄(刪除)
      IF NOT cl_log_modified_record('','') THEN 
         CLOSE azzi310_01_cl
         RETURN
      END IF
      
      CLEAR FORM
      CALL azzi310_01_ui_browser_refresh()
      
      #確保畫面上保有資料
      IF g_browser_cnt > 0 THEN
         #CALL azzi310_01_browser_fill(g_wc,"")
         CALL azzi310_01_fetch("P")
      ELSE
         CLEAR FORM
      END IF
   ELSE    
   END IF
 
   CLOSE azzi310_01_cl
 
   #功能已完成,通報訊息中心
   CALL azzi310_01_msgcentre_notify('delete')
 
END FUNCTION
 
{</section>}
 
{<section id="azzi310_01.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION azzi310_01_ui_browser_refresh()
   DEFINE l_i  LIKE type_t.num10
   #add-point:ui_browser_refresh段define
   
   #end add-point    
   #add-point:ui_browser_refresh段define(客製用)
   
   #end add-point
   
   LET g_browser_cnt = g_browser.getLength()
   LET g_header_cnt  = g_browser.getLength()
   FOR l_i =1 TO g_browser.getLength()
      IF g_browser[l_i].b_gzia001 = g_gzia_m.gzia001
 
         THEN
         CALL g_browser.deleteElement(l_i)
       END IF
   END FOR
   LET g_browser_cnt = g_browser_cnt - 1
   LET g_header_cnt = g_header_cnt - 1
   
   DISPLAY g_browser_cnt TO FORMONLY.b_count     #page count
   DISPLAY g_header_cnt  TO FORMONLY.h_count     #page count
  
   #若無資料則關閉相關功能
   IF g_browser_cnt = 0 THEN
      CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce,mainhidden", FALSE)
      CALL cl_navigator_setting(0,0)
      CLEAR FORM
   ELSE
      CALL cl_set_act_visible("mainhidden", TRUE)
   END IF
  
END FUNCTION
 
{</section>}
 
{<section id="azzi310_01.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION azzi310_01_set_entry(p_cmd)
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_entry段define
   
   #end add-point     
   #add-point:set_entry段define(客製用)
   
   #end add-point
   
   IF p_cmd = "a" THEN
      CALL cl_set_comp_entry("gzia001",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制
      
      #end add-point 
   END IF
   
   #add-point:set_entry段欄位控制後
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="azzi310_01.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION azzi310_01_set_no_entry(p_cmd)
   DEFINE p_cmd LIKE type_t.chr1
   #add-point:set_no_entry段define
   
   #end add-point     
   #add-point:set_no_entry段define(客製用)
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("gzia001",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制
      
      #end add-point 
   END IF
   
   #add-point:set_no_entry段欄位控制後
   
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="azzi310_01.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION azzi310_01_set_act_visible()
   #add-point:set_act_visible段define
   
   #end add-point
   #add-point:set_act_visible段define(客製用)
   
   #end add-point  
   #add-point:set_act_visible段
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="azzi310_01.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION azzi310_01_set_act_no_visible()
   #add-point:set_act_no_visible段define
   
   #end add-point
   #add-point:set_act_no_visible段define(客製用)
   
   #end add-point
   #add-point:set_act_no_visible段
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="azzi310_01.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION azzi310_01_default_search()
   DEFINE li_idx  LIKE type_t.num10
   DEFINE li_cnt  LIKE type_t.num10
   DEFINE ls_wc   STRING
   #add-point:default_search段define
   
   #end add-point  
   #add-point:default_search段define(客製用)
   
   #end add-point
   
   IF cl_null(g_order) THEN
      LET g_order = "ASC"
   END IF
   
   #add-point:default_search段開始前
   
   #end add-point  
   
   #根據外部參數(g_argv)組合wc
   IF NOT cl_null(g_argv[01]) THEN
      LET ls_wc = ls_wc, " gzia001 = '", g_argv[01], "' AND "
   END IF
   
 
   
   #add-point:default_search段after sql
   
   #end add-point  
   
   IF NOT cl_null(ls_wc) THEN
      #若有外部參數則根據該參數組合
      LET g_wc = ls_wc.subString(1,ls_wc.getLength()-5)
      LET g_default = TRUE
   ELSE
      #若無外部參數則預設為1=2
      LET g_default = FALSE
      #預設查詢條件
      LET g_wc = cl_qbe_get_default_qryplan()
      IF cl_null(g_wc) THEN
         LET g_wc = " 1=2"
      END IF
   END IF
   
   #add-point:default_search段結束前
   
   #end add-point  
 
   IF g_wc.getIndexOf(" 1=2", 1) THEN
      LET g_default = TRUE
   END IF
 
 
END FUNCTION
 
{</section>}
 
{<section id="azzi310_01.mask_functions" >}
&include "erp/azz/azzi310_01_mask.4gl"
 
{</section>}
 
{<section id="azzi310_01.state_change" >}
   
 
{</section>}
 
{<section id="azzi310_01.signature" >}
   
 
{</section>}
 
{<section id="azzi310_01.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:5)
#+ 給予pk_array內容
PRIVATE FUNCTION azzi310_01_set_pk_array()
   #add-point:set_pk_array段define
   
   #end add-point
   #add-point:set_pk_array段define
   
   #end add-point
   
   #add-point:set_pk_array段之前
   
   #end add-point  
   
   #若l_ac<=0代表沒有資料
   IF l_ac <= 0 THEN
      RETURN
   END IF
   
   CALL g_pk_array.clear()
   LET g_pk_array[1].values = g_gzia_m.gzia001
   LET g_pk_array[1].column = 'gzia001'
 
   
   #add-point:set_pk_array段之後
   
   #end add-point  
   
END FUNCTION
 
 
 
{</section>}
 
{<section id="azzi310_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="azzi310_01.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:3)
PRIVATE FUNCTION azzi310_01_msgcentre_notify(lc_state)
   DEFINE lc_state LIKE type_t.chr80
   #add-point:msgcentre_notify段define
   
   #end add-point
   #add-point:msgcentre_notify段define
   
   #end add-point   
   
   INITIALIZE g_msgparam TO NULL
 
   #action-id與狀態填寫
   LET g_msgparam.state = lc_state
 
   #PK資料填寫
   CALL azzi310_01_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_gzia_m)
 
   #add-point:msgcentre其他通知
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
{</section>}
 
{<section id="azzi310_01.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION azzi310_01_action_chk()
   #add-point:action_chk段define
   
   #end add-point
   #add-point:action_chk段define(客製用)
   
   #end add-point
   
   #add-point:action_chk段action_chk
   
   #end add-point
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="azzi310_01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 依照 azzi310 设定产生报表数据
# Memo...........:
# Usage..........: CALL azzi310_01_sel(p_cmd)
# Input parameter: p_cmd      V:预览模式 O:其他模式     
#                :  
# Return code....:  
#                :  
# Date & Author..: 2015/07/16 by chenjpa
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_01_sel(p_cmd)
    DEFINE p_cmd       LIKE type_t.chr1           #V:预览模式 O:其他模式  C:获取条件 F:过滤模式
    DEFINE l_text      STRING
    DEFINE l_str       STRING
    DEFINE l_str_bak   STRING
    DEFINE l_sql       STRING
    DEFINE l_order     STRING
    DEFINE l_tmp       STRING
    DEFINE l_tok       base.StringTokenizer
    DEFINE l_start     LIKE type_t.num10         
    DEFINE l_end       LIKE type_t.num10        
    #DEFINE l_tab       DYNAMIC ARRAY OF STRING
    DEFINE l_i         LIKE type_t.num10         
    DEFINE l_j         LIKE type_t.num10        
    DEFINE l_k         LIKE type_t.num10       
    DEFINE l_cnt       LIKE type_t.num10      
    DEFINE lw_w        ui.window
    #DEFINE l_tabname    STRING
    #DEFINE l_table_name LIKE dzea_t.dzea001 
    #DEFINE l_tab_cnt   LIKE type_t.num5          
    DEFINE l_sel       LIKE type_t.chr1      
    DEFINE l_gzib002     LIKE gzib_t.gzib002
    DEFINE l_gzib003     LIKE gzib_t.gzib003
    DEFINE l_gzib004     LIKE gzib_t.gzib004
    DEFINE l_gzib005     LIKE gzib_t.gzib005
    DEFINE l_gzib006     LIKE gzib_t.gzib006
    DEFINE l_gzib007     LIKE gzib_t.gzib007 #151214-00004#2 add #增加资料表别名的信息，解决一表多用问题
    DEFINE l_gzzd005     LIKE gzzd_t.gzzd005
    DEFINE l_tag       LIKE type_t.num5
    DEFINE l_next_tag  LIKE type_t.chr1
    DEFINE l_next_cnt  LIKE type_t.num10
    DEFINE l_bar       LIKE type_t.num5
    DEFINE l_gzid       RECORD
                      #161121-00024#1 mod(s)
                      # gzid002    LIKE gzid_t.gzid002,#160711-00011#1 add                    
                      gzid004    LIKE gzid_t.gzid004,
                      gzidl004   LIKE gzidl_t.gzidl004 
#                       gzid005    LIKE gzid_t.gzid005,
#                       gzid007    LIKE gzid_t.gzid007,
#                       gzid008    LIKE gzid_t.gzid008,
#                       gzid009    LIKE gzid_t.gzid009,
#                       gzid010    LIKE gzid_t.gzid010,
#                       gzid011    LIKE gzid_t.gzid011,
#                       gzid006    LIKE gzid_t.gzid006  
                       #161121-00024#1 mod(e)
                       END RECORD
    DEFINE l_gzic      RECORD
                       gzid004    LIKE gzid_t.gzid004,
                       gzid003    LIKE gzid_t.gzid003,   #151214-00004#2 add #增加资料表别名的信息，解决一表多用问题
                       gzic002    LIKE gzic_t.gzic002,
                       gzic003    LIKE gzic_t.gzic003,
                       gzic004    LIKE gzic_t.gzic004,
                       gzic005    LIKE gzic_t.gzic005,
                       gzic006    LIKE gzic_t.gzic006,
                       ggzid004   LIKE gzid_t.gzid004,
                       gzib007    LIKE gzib_t.gzib007,   #151214-00004#2  add #增加资料表别名的信息，解决一表多用问题
                       gzic007    LIKE gzic_t.gzic007,
                       gzid016    LIKE gzid_t.gzid016    #160721-00005#1 增加gzid016
                     END RECORD
    DEFINE l_table_data type_field1
    DEFINE l_sys           STRING                                       
    DEFINE l_qry_feld      STRING                                       
    DEFINE l_gzid010       DYNAMIC ARRAY OF LIKE gzid_t.gzid010         
    DEFINE l_sql1          STRING                                                                
    DEFINE l_field_name    STRING                                       
    DEFINE lt_i            LIKE type_t.num10
    
    DEFINE l_hyper_url     STRING  #160523-00002#2
    DEFINE l_prog          LIKE gzia_t.gzia001     #161205-00020#1 add
    #161215-00017#1 add(s)
    DEFINE pos             INTEGER  
    DEFINE l_child_cnt     INTEGER
    #161215-00017#1 add(e)
    
     CALL ga_table_data.clear()
 
     IF p_cmd = "V" OR p_cmd = "C" THEN         #160523-00002#2 add p_cmd="C"--回传json              
        CALL g_qry_seq.clear()
        CALL g_qry_table.clear()
        CALL g_qry_feld.clear()
        CALL g_qry_feld_t.clear()
        CALL g_qry_length.clear()
        CALL g_qry_scale.clear()
        CALL g_qry_feld_type.clear()
        CALL g_qry_tran.clear()
        CALL g_qry_show.clear()
        CALL g_qry_qbe.clear()
        CALL g_qry_flag.clear() #160523-00002#2 add
        CALL g_qry_prog.clear()  #160523-00002#2 add
        CALL g_qry_jsarg.clear() #160901-00030#1 add
        CALL g_qry_attr.clear()  #161213-00049 add
        CALL g_qry_fmt.clear()    #161213-00049 add
        CALL g_feld_group.clear()
        CALL g_feld_sum.clear()
        CALL g_sum_name.clear()
        CALL g_gzic_d.clear()
        CALL g_gzib_d.clear()
        CALL g_field_seq.clear()
        CALL ga_sum_row.clear()
        CALL ga_sum_rec.clear()
        CALL ga_table_data.clear()
        
        #160523-00002#2 add(s) #回传json
        IF p_cmd="C" THEN
          LET g_gzia002='Y'
          LET g_out_type=p_cmd
        END IF
        #160523-00002#2 add(e)
     END IF
 
     LET l_sel = 'N'
     LET l_next_tag = 'N'
 
     LET l_str = g_gzia006 CLIPPED                               
 
     LET l_end = l_str.getIndexOf(';',1)
     IF l_end != 0 THEN
        LET l_str=l_str.subString(1,l_end-1)
     END IF
     LET l_tok = base.StringTokenizer.createExt(l_str CLIPPED,"\n","",TRUE)
     WHILE l_tok.hasMoreTokens()
           LET l_tmp=l_tok.nextToken()
           IF l_text is null THEN
              LET l_text = l_tmp.trim()
           ELSE
              LET l_text = l_text CLIPPED,' ',l_tmp.trim()
           END IF
     END WHILE
     LET l_tmp=l_text
     LET g_execmd=l_tmp
 
     IF p_cmd = "V"  OR p_cmd = "C" THEN  #160523-00002#2 add p_cmd="C"--回传json     
          
        #抓群组信息                   
        #LET l_sql = "SELECT unique gzib002,gzib003,gzib004,gzib006,gzib005 FROM gzib_t ",
        #151214-00004#2 mod #增加资料表别名的信息，解决一表多用问题
        LET l_sql = "SELECT unique gzib002,gzib003,gzib004,gzib006,gzib005,gzib007 FROM gzib_t ",
                    " WHERE gzib001='",g_query_prog CLIPPED,"'",                  
                    " ORDER BY gzib003 "
        DECLARE group_cur CURSOR FROM l_sql
    
        #FOREACH group_cur INTO l_gzib002,l_gzib003,l_gzib004,l_gzib006,l_gzib005
        #151214-00004#2 mod #增加资料表别名的信息，解决一表多用问题
        FOREACH group_cur INTO l_gzib002,l_gzib003,l_gzib004,l_gzib006,l_gzib005,l_gzib007
            LET g_gzib_d[l_gzib003].gzib002 = l_gzib002 CLIPPED
            LET g_gzib_d[l_gzib003].gzib004 = l_gzib004 CLIPPED    #跳页
            LET g_gzib_d[l_gzib003].gzib006 = l_gzib006 CLIPPED    #群组
            LET g_gzib_d[l_gzib003].gzib005 = l_gzib005 CLIPPED    #排序
            LET g_gzib_d[l_gzib003].gzib007 = l_gzib007 CLIPPED #151214-00004#2 add #增加资料表别名的信息，解决一表多用问题
            IF l_gzib004='Y'  THEN
                LET l_next_tag='Y'
            END IF
        END FOREACH
    
       # CALL azzi310_parse_sql('')  #解析sql
          
       # DECLARE azzi310_01_d1 CURSOR FOR
       #          SELECT xabd002,xabd003,xabd009,xabd004,xabd005,xabd006 FROM azzi310_xabd ORDER BY xabd001
       #抓取每个栏位的显示信息
         DECLARE azzi310_01_d1 CURSOR FOR
                  SELECT gzid002,gzid003,gzid004,gzidl004,gzid006,gzid011,gzid005,gzid012,gztd003,gzid009 
                  ,gzid014,gzid015 #160523-00002#2 add 
                  ,gzid017         #160901-00030#1 add gzid017
                  ,gzid010,(SELECT gztd014 FROM gztd_t WHERE gztd001=gzid010) gztd014 #161213-00049 add 
                   FROM gzid_t LEFT OUTER JOIN gzidl_t ON gzidl001=gzid001 and gzidl002=gzid002 and gzidl003=g_dlang
            LEFT OUTER JOIN (select gztd003,dzeb002,dzeb001 from gztd_t,dzeb_t where dzeb006=gztd001) 
                        ON dzeb001=gzid003 AND dzeb002=gzid004
                   WHERE gzid001=g_gzia001 ORDER BY gzid002
                   
        LET l_i=1
        #FOREACH azzi310_01_d1 INTO g_qry_table[l_i],g_qry_feld_t[l_i],g_qry_feld[l_i],g_qry_length[l_i],g_qry_scale[l_i],g_qry_feld_type[l_i]
        FOREACH azzi310_01_d1 INTO g_qry_seq[l_i],g_qry_table[l_i],g_qry_feld_t[l_i],g_qry_feld[l_i],g_qry_length[l_i],
                                      g_qry_scale[l_i],g_qry_show[l_i],g_qry_tran[l_i],g_qry_feld_type[l_i],g_qry_qbe[l_i]
                                      ,g_qry_flag[l_i],g_qry_prog[l_i] #160523-00002#2 add
                                      ,g_qry_jsarg[l_i] #160901-00030#1 add 
                                      ,g_qry_attr[l_i],g_qry_fmt[l_i] #161213-00049 add
          LET l_qry_feld = g_qry_feld[l_i]
          IF g_qry_length[l_i]<l_qry_feld.getLength() THEN
            LET g_qry_length[l_i]=l_qry_feld.getLength()
          END IF
          IF cl_null(g_qry_show[l_i]) THEN
              LET g_qry_show[l_i]='N'
          END IF
          
          IF cl_null(g_qry_feld[l_i]) THEN
              SELECT dzebl003 INTO g_qry_feld[l_i] FROM dzebl_t 
              #WHERE dzebl000=g_qry_table[l_i] AND dzebl001=g_qry_feld_t[l_i] AND dzebl002=g_dlang
              WHERE dzebl001=g_qry_feld_t[l_i] AND dzebl002=g_dlang #151214-00004#2 mod #增加资料表别名的信息，解决一表多用问题
          END IF
          #161213-00049 add(s)
          IF cl_null(g_qry_scale[l_i]) AND cl_null(g_qry_fmt[l_i]) AND NOT cl_null(g_qry_attr[l_i]) THEN
             LET g_qry_scale[l_i]=0
          END IF
          #161213-00049 add(e)   
          LET l_i=l_i+1
        END FOREACH
        CALL g_qry_table.deleteElement(l_i)   
        CALL g_qry_feld_t.deleteElement(l_i)   
        CALL g_qry_feld.deleteElement(l_i)   
        CALL g_qry_scale.deleteElement(l_i)   
        CALL g_qry_length.deleteElement(l_i)   
        CALL g_qry_feld_type.deleteElement(l_i)   
        CALL g_qry_show.deleteElement(l_i)
        CALL g_qry_seq.deleteElement(l_i)
        CALL g_qry_flag.deleteElement(l_i)  #160523-00002#2 add
        CALL g_qry_prog.deleteElement(l_i)  #160523-00002#2 add
        CALL g_qry_jsarg.deleteElement(l_i) #160901-00030#1 add
        CALL g_qry_attr.deleteElement(l_i)  #161213-00049 add 
        CALL g_qry_fmt.deleteElement(l_i)   #161213-00049 add 
        #CALL g_sum_rec.deleteElement(l_i)
        LET l_i=l_i-1
        LET g_qry_feld_cnt=l_i
           
        IF g_qry_feld_cnt > GI_MAX_COLUMN_COUNT THEN   
           INITIALIZE g_errparam TO NULL
          LET g_errparam.code = 'azz-00793' 
          LET g_errparam.extend = g_qry_feld_cnt
          LET g_errparam.popup = TRUE
          CALL cl_err()
          LET INT_FLAG = 1 
           RETURN
        END IF

        
         LET g_sum_name[1]=g_gzze00
         LET g_sum_name[2]=g_gzze01
         LET g_sum_name[3]=g_gzze02
         LET g_sum_name[4]=g_gzze03
         LET g_sum_name[5]=g_gzze04
         LET g_sum_name[7]=g_gzze07
       
       #计算sum笔数
       LET g_gzic_sum_cnt=0                                      #不根据群组，计算所有资料汇总
           SELECT COUNT(*) INTO g_gzic_sum_cnt FROM gzic_t 
           WHERE gzic001=g_query_prog AND gzic003!='6' AND gzic004 !='Y'
       LET g_gzic_d_cnt = 0
       SELECT COUNT(*) INTO g_gzic_d_cnt FROM gzic_t 
        WHERE gzic001=g_query_prog AND gzic003!='6' AND gzic004 ='Y'
       IF g_gzic_d_cnt > 0 THEN
           LET l_i = 1
          #151214-00004#2 mod(s) #增加资料表别名的信息，解决一表多用问题
#          LET l_sql="SELECT unique gzid004,gzic002,gzic003,gzic004,gzic005,gzic006,gzib002 ggzid004,gzic007 FROM gzic_t,gzid_t,gzib_t ",
#                " WHERE gzic001=gzid001 AND gzic002=gzid002 AND gzic001=gzib001 AND gzic005=gzib003 ",
#                    "   AND gzic001='",g_gzia001,"' AND gzic003 !='6' AND gzic004 = 'Y'",
#                    " ORDER BY gzic005,gzic002"
          LET l_sql="SELECT unique gzid004,(SELECT gzig003 FROM gzig_t ",  
                                           " WHERE DECODE(gzig003,' ',gzig002,'',gzig002,gzig003)=gzid003" ,
                                           "     AND gzig001='",g_gzia001,"') gzid003,",
                    "       gzic002,gzic003,gzic004,gzic005,gzic006,",
                    "       gzib002 ggzid004,gzib007,gzic007,gzid016 ", #160721-00005#1 增加gzid016
                    " FROM gzic_t,gzid_t,gzib_t ",
                    " WHERE gzic001=gzid001 AND gzic002=gzid002 AND gzic001=gzib001 AND gzic005=gzib003 ",
                    "   AND gzic001='",g_gzia001,"' AND gzic003 !='6' AND gzic004 = 'Y'",
                    " ORDER BY gzic005,gzic002"
          #151214-00004#2 mod(e) 
                     
           DECLARE sum_cur 
           CURSOR FROM l_sql
           FOREACH sum_cur INTO l_gzic.*           
                   LET g_feld_sum[l_gzic.gzic002][l_gzic.gzic005]=l_gzic.gzic003
                   LET g_gzic_d[l_i].*=l_gzic.*
             LET l_i = l_i + 1
           END FOREACH
       END IF
       CALL g_gzic_d.deleteElement(l_i) 
        #捞取qbe
        #161121-00024#1 mod(s)
        LET l_i = 1
                 DECLARE azzi310_01_qbe CURSOR FOR
                  SELECT gzid004,gzidl004,gzid006,gzid009,gzid013
                   FROM gzid_t LEFT OUTER JOIN gzidl_t ON gzidl001=gzid001 and gzidl002=gzid002 and gzidl003=g_dlang
                   WHERE gzid001=g_gzia001 
                     AND gzid018 is not null 
                     ORDER BY gzid018,gzid002
        FOREACH azzi310_01_qbe INTO l_gzid.gzid004,l_gzid.gzidl004,g_field_seq[l_i].len,
                                    g_field_seq[l_i].qbe,g_field_seq[l_i].type
           #161124-00042#1 add(s) 补161121-00024#1遗留问题
           IF cl_null(l_gzid.gzidl004) THEN
              SELECT dzebl003 INTO l_gzid.gzidl004 FROM dzebl_t              
              WHERE dzebl001=l_gzid.gzid004 AND dzebl002=g_dlang 
           END IF
           #161124-00042#1 add(e)
           LET g_field_seq[l_i].id = l_gzid.gzid004 CLIPPED 
           LET g_field_seq[l_i].name=l_gzid.gzidl004                   
           LET l_i=l_i+1
        END FOREACH
        CALL g_field_seq.deleteElement(l_i)
        LET l_i=l_i-1
        
        #161209-00047 add(s)  补充161121-00024#1功能
         #gzid018未设置，从gzid007抓资料
         IF g_field_seq.getLength()<1 THEN
            LET l_i=1
            DECLARE azzi310_01_qbe2 CURSOR FOR
                  SELECT gzid004,gzidl004,gzid006,gzid009,gzid013
                   FROM gzid_t LEFT OUTER JOIN gzidl_t ON gzidl001=gzid001 and gzidl002=gzid002 and gzidl003=g_dlang
                   WHERE gzid001=g_gzia001 
                    AND (gzid005 ='Y' OR gzid005 is null)
                     ORDER BY gzid007,gzid002
               FOREACH azzi310_01_qbe2 INTO l_gzid.gzid004,l_gzid.gzidl004,g_field_seq[l_i].len,
                                    g_field_seq[l_i].qbe,g_field_seq[l_i].type          
                   IF cl_null(l_gzid.gzidl004) THEN
                     SELECT dzebl003 INTO l_gzid.gzidl004 FROM dzebl_t              
                     WHERE dzebl001=l_gzid.gzid004 AND dzebl002=g_dlang 
                   END IF
           
                   LET g_field_seq[l_i].id = l_gzid.gzid004 CLIPPED 
                   LET g_field_seq[l_i].name=l_gzid.gzidl004                   
                   LET l_i=l_i+1
               END FOREACH
            CALL g_field_seq.deleteElement(l_i)
            LET l_i=l_i-1
         END IF
        #161209-00047 add(e)
        
       # LET l_sql="SELECT unique gzid004,gzid005,gzid007,gzid009,zat07,gzid010,gzid011,gzid006 ", 
#        LET l_sql="SELECT unique gzid002,gzid004,gzid005,gzid007,gzid008,gzid009,gzid010,gzid011,gzid006 ", #160711-00011#1 add gzid002 
#                  "  FROM gzid_t ",
#                  "   WHERE gzid001='",g_query_prog CLIPPED,"'",
#                  "     AND (gzid005 ='Y' OR gzid005 is null)",
#                  " ORDER BY gzid007" 
#        PREPARE azzi310_01_qbe_pre FROM l_sql          
#        DECLARE azzi310_01_qbe_curs CURSOR FOR azzi310_01_qbe_pre 
#        FOREACH azzi310_01_qbe_curs INTO l_gzid.*
#                      LET l_i = l_i + 1
#                      LET g_field_seq[l_i].id = l_gzid.gzid004 CLIPPED
#                      FOR l_k =1 TO g_qry_feld_t.getLength()
#                          # IF l_gzid.gzid004=g_qry_feld_t[l_k] THEN
#                          IF l_gzid.gzid002=g_qry_seq[l_k] THEN #160711-00011#1 mod
#                               LET g_field_seq[l_i].name = g_qry_feld[l_k] CLIPPED
#                               LET g_field_seq[l_i].type = g_qry_feld_type[l_k]
#                           END IF
#                      END FOR 
#                      #IF cl_null(l_gzid.gzid006) THEN
#                      #   LET l_gzid.gzid006 = g_qry_length[l_j] CLIPPED
#                      #END IF
#                      LET g_field_seq[l_i].len = l_gzid.gzid006          
#                      LET g_field_seq[l_i].qbe = l_gzid.gzid009 CLIPPED
##                      LET g_field_seq[l_i].show = l_gzid.gzid007 CLIPPED
##                      LET g_field_seq[l_i].qbeopen=l_gzid.gzid008
#
#        END FOREACH
 #161121-00024#1 mod(e)       
     END IF       #p_cmd='V'                                  
    
     #查询报表时是否输入查询条件
     #161121-00024#1 mod 增加g_field_seq.length()长度判断    
     IF ((g_gzia002 = 'Y' AND g_out_type = 'V' AND cl_null(g_wc))  OR g_out_type = 'C')
         AND g_field_seq.getLength()>0        
      THEN #160523-00002#2 add 回传json
        #LET g_wc = azzi310_01_curs('V')
        LET g_wc = azzi310_01_curs(g_out_type) #160523-00002#2 mod --回传json
        IF INT_FLAG THEN                              #使用者不玩了
           RETURN
        END IF
        #160523-00002#2 add(s) --回传json
        IF p_cmd = "C" THEN
           RETURN
        END IF
        #160523-00002#2 add(e) --回传json
     END IF
     
     #161205-00020#1 mod(s)
     LET g_sql_wc = ""
     IF NOT cl_null(g_wc) AND g_wc <> " 1=1" THEN
        LET g_sql_wc = g_wc
        #过滤的条件(g_wc2)
        IF NOT cl_null(g_wc2) AND g_wc2 <> " 1=1" THEN
           LET g_sql_wc = g_sql_wc ," AND ",g_wc2 
        END IF
     ELSE
        IF NOT cl_null(g_wc2) AND g_wc2 <> " 1=1" THEN
           LET g_sql_wc = g_wc2 
        END IF
     END IF
     #161205-00020#1 mod(e)
     
     #计算报表长度
     #LET g_len = 0 #160825-00014#1 mark
     LET g_show_cnt = 0
     FOR l_i = 1 TO g_qry_feld_cnt 
         IF g_qry_show[l_i] = 'Y' THEN
            LET g_len=g_len + g_qry_length[l_i] + 1 #160825-00014#1 mark(s) #恢复2016/09/07
            LET g_show_cnt = g_show_cnt + 1
         END IF
     END FOR
     #160825-00014#1 mod(s) #恢复2016/09/07
     LET g_show_cnt=g_show_cnt-1
     LET g_len = g_len -1
     IF g_len < 80 THEN
        LET g_len = 80
     END IF
    #160825-00014#1 mod(e)
    
     #组 sql 字符串排序条件(Order By) 
     IF g_gzib_d.getLength()>0 THEN
      LET l_next_tag =  azzi310_01_order()             
     END IF
      #161215-00017#1 add(s)
      #判断群主栏位分页且分组小计
      LET l_child_cnt=0
      IF l_next_tag = 'Y' AND g_gzic_d_cnt >0 THEN
         select count(1) INTO l_child_cnt from gzic_t where  gzic005=g_next_pos and gzic006='c' and gzic004='Y' and gzic001=g_query_prog       
      END IF
      #161215-00017#1 add(e)
     #将 sql 字符串字段换成 DECODE & CASE
     #CALL azzi310_01_replace()   #161208-00013#1 mark

     #161205-00020#1 add(s)
     IF g_prog=g_code THEN
        LET l_prog=g_prog
        LET g_prog=g_query_prog
     END IF
     DISPLAY "INFO:",g_prog,"(",g_code,")"
     LET l_str=cl_sql_auth_filter()
     DISPLAY "过滤INFO:",l_str
     LET l_text=l_str.toLowerCase()
     LET l_tmp=l_text.trim()
     IF NOT cl_null(l_str) THEN  #161206-00041#1
       IF l_tmp.subString(1,3) = 'and' THEN
         LET l_i=l_text.getIndexOf("and",1)+3
         LET l_str=l_str.subString(l_i,l_str.getLength())        
       END IF
       IF cl_null(g_sql_wc) THEN        
          LET g_sql_wc = l_str
       ELSE
          LET g_sql_wc = g_sql_wc," AND ",l_str
       END IF
     END IF 
     IF NOT cl_null(l_prog) THEN
        LET g_prog=l_prog
     END IF     
     #161205-00020#1 add(e)
     
     IF NOT cl_null(g_sql_wc) THEN
        LET l_str_bak = g_execmd.toLowerCase()
        LET l_end   = l_str_bak.getIndexOf('where',1)
        IF l_end=0 THEN
           LET l_end   = l_str_bak.getIndexOf('group',1)
           IF l_end=0 THEN
              LET l_end   = l_str_bak.getIndexOf('order',1)
              IF l_end=0 THEN
                 LET g_execmd = g_execmd," WHERE ",g_sql_wc
              ELSE
                 LET g_execmd = g_execmd.subString(1,l_end-1),
                             " WHERE ",g_sql_wc," ",
                             g_execmd.subString(l_end,g_execmd.getLength())
              END IF
           ELSE
              LET g_execmd = g_execmd.subString(1,l_end-1),
                             " WHERE ",g_sql_wc," ",
                             g_execmd.subString(l_end,g_execmd.getLength())
           END IF
        ELSE
           LET g_execmd = g_execmd.subString(1,l_end+5),
                          g_sql_wc," AND ",
                          g_execmd.subString(l_end+6,g_execmd.getLength())
        END IF
     END IF 
     CALL ga_sum_data.clear()
     CALL ga_sum_row.clear()
     DISPLAY g_execmd
     #160523-00002#2 add(e) #传人json，获取总笔数 
     IF p_cmd="N" THEN
     LET INT_FLAG = 1
        RETURN
     END IF
     #160523-00002#2 add(e)
     IF g_gzic_d_cnt >0 OR g_gzic_sum_cnt >0 THEN
        CALL azzi310_01_group()
     END IF
     #IF g_gzia005 >=1 THEN
     #   #where 条件增加最大笔数的限制
     #END IF 
     
      
      #将 sql 字符串字段换成 DECODE & CASE
      CALL azzi310_01_replace()   #161208-00013#1 add
     
     DISPLAY g_execmd
     
     PREPARE table_pre FROM g_execmd
     IF SQLCA.SQLCODE THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = sqlca.sqlcode 
          LET g_errparam.extend ='PREPARE table_pre'
          LET g_errparam.popup = TRUE
          CALL cl_err()
        LET INT_FLAG = 1
        RETURN
     END IF
     DECLARE table_cur CURSOR FOR table_pre
     IF SQLCA.SQLCODE THEN
          LET g_errparam.code = sqlca.sqlcode 
        LET g_errparam.extend ='DECLARE table_pre'
        LET g_errparam.popup = TRUE
        CALL cl_err()
        LET INT_FLAG = 1
        RETURN
     END IF
 
     CALL cl_progress_bar(10)
     LET l_bar = 1
 
     LET l_i = 1
     CALL ga_table_data.clear()
     INITIALIZE ga_page_data_t.* TO NULL
     INITIALIZE l_table_data.*   TO NULL
     LET g_data_end = 0
     LET l_cnt = 1
     LET lt_i=0
     FOREACH table_cur INTO l_table_data.*
         IF SQLCA.SQLCODE THEN
             LET g_errparam.code = sqlca.sqlcode 
             LET g_errparam.extend =''
             LET g_errparam.popup = TRUE
             CALL cl_err()
            CALL cl_progress_bar_close()
            RETURN
         END IF
#        LET ga_table_data[l_i].* = l_table_data.*
         LET ga_table_data[l_i].field001 = l_table_data.field001
         LET ga_table_data[l_i].field002 = l_table_data.field002
         LET ga_table_data[l_i].field003 = l_table_data.field003
         LET ga_table_data[l_i].field004 = l_table_data.field004
         LET ga_table_data[l_i].field005 = l_table_data.field005
         LET ga_table_data[l_i].field006 = l_table_data.field006
         LET ga_table_data[l_i].field007 = l_table_data.field007
         LET ga_table_data[l_i].field008 = l_table_data.field008
         LET ga_table_data[l_i].field009 = l_table_data.field009
         LET ga_table_data[l_i].field010 = l_table_data.field010
         LET ga_table_data[l_i].field011 = l_table_data.field011
         LET ga_table_data[l_i].field012 = l_table_data.field012
         LET ga_table_data[l_i].field013 = l_table_data.field013
         LET ga_table_data[l_i].field014 = l_table_data.field014
         LET ga_table_data[l_i].field015 = l_table_data.field015
         LET ga_table_data[l_i].field016 = l_table_data.field016
         LET ga_table_data[l_i].field017 = l_table_data.field017
         LET ga_table_data[l_i].field018 = l_table_data.field018
         LET ga_table_data[l_i].field019 = l_table_data.field019
         LET ga_table_data[l_i].field020 = l_table_data.field020
         LET ga_table_data[l_i].field021 = l_table_data.field021
         LET ga_table_data[l_i].field022 = l_table_data.field022
         LET ga_table_data[l_i].field023 = l_table_data.field023
         LET ga_table_data[l_i].field024 = l_table_data.field024
         LET ga_table_data[l_i].field025 = l_table_data.field025
         LET ga_table_data[l_i].field026 = l_table_data.field026
         LET ga_table_data[l_i].field027 = l_table_data.field027
         LET ga_table_data[l_i].field028 = l_table_data.field028
         LET ga_table_data[l_i].field029 = l_table_data.field029
         LET ga_table_data[l_i].field030 = l_table_data.field030
         LET ga_table_data[l_i].field031 = l_table_data.field031
         LET ga_table_data[l_i].field032 = l_table_data.field032
         LET ga_table_data[l_i].field033 = l_table_data.field033
         LET ga_table_data[l_i].field034 = l_table_data.field034
         LET ga_table_data[l_i].field035 = l_table_data.field035
         LET ga_table_data[l_i].field036 = l_table_data.field036
         LET ga_table_data[l_i].field037 = l_table_data.field037
         LET ga_table_data[l_i].field038 = l_table_data.field038
         LET ga_table_data[l_i].field039 = l_table_data.field039
         LET ga_table_data[l_i].field040 = l_table_data.field040
         LET ga_table_data[l_i].field041 = l_table_data.field041
         LET ga_table_data[l_i].field042 = l_table_data.field042
         LET ga_table_data[l_i].field043 = l_table_data.field043
         LET ga_table_data[l_i].field044 = l_table_data.field044
         LET ga_table_data[l_i].field045 = l_table_data.field045
         LET ga_table_data[l_i].field046 = l_table_data.field046
         LET ga_table_data[l_i].field047 = l_table_data.field047
         LET ga_table_data[l_i].field048 = l_table_data.field048
         LET ga_table_data[l_i].field049 = l_table_data.field049
         LET ga_table_data[l_i].field050 = l_table_data.field050
         LET ga_table_data[l_i].field051 = l_table_data.field051
         LET ga_table_data[l_i].field052 = l_table_data.field052
         LET ga_table_data[l_i].field053 = l_table_data.field053
         LET ga_table_data[l_i].field054 = l_table_data.field054
         LET ga_table_data[l_i].field055 = l_table_data.field055
         LET ga_table_data[l_i].field056 = l_table_data.field056
         LET ga_table_data[l_i].field057 = l_table_data.field057
         LET ga_table_data[l_i].field058 = l_table_data.field058
         LET ga_table_data[l_i].field059 = l_table_data.field059
         LET ga_table_data[l_i].field060 = l_table_data.field060
         LET ga_table_data[l_i].field061 = l_table_data.field061
         LET ga_table_data[l_i].field062 = l_table_data.field062
         LET ga_table_data[l_i].field063 = l_table_data.field063
         LET ga_table_data[l_i].field064 = l_table_data.field064
         LET ga_table_data[l_i].field065 = l_table_data.field065
         LET ga_table_data[l_i].field066 = l_table_data.field066
         LET ga_table_data[l_i].field067 = l_table_data.field067
         LET ga_table_data[l_i].field068 = l_table_data.field068
         LET ga_table_data[l_i].field069 = l_table_data.field069
         LET ga_table_data[l_i].field070 = l_table_data.field070
         LET ga_table_data[l_i].field071 = l_table_data.field071
         LET ga_table_data[l_i].field072 = l_table_data.field072
         LET ga_table_data[l_i].field073 = l_table_data.field073
         LET ga_table_data[l_i].field074 = l_table_data.field074
         LET ga_table_data[l_i].field075 = l_table_data.field075
         LET ga_table_data[l_i].field076 = l_table_data.field076
         LET ga_table_data[l_i].field077 = l_table_data.field077
         LET ga_table_data[l_i].field078 = l_table_data.field078
         LET ga_table_data[l_i].field079 = l_table_data.field079
         LET ga_table_data[l_i].field080 = l_table_data.field080
         LET ga_table_data[l_i].field081 = l_table_data.field081
         LET ga_table_data[l_i].field082 = l_table_data.field082
         LET ga_table_data[l_i].field083 = l_table_data.field083
         LET ga_table_data[l_i].field084 = l_table_data.field084
         LET ga_table_data[l_i].field085 = l_table_data.field085
         LET ga_table_data[l_i].field086 = l_table_data.field086
         LET ga_table_data[l_i].field087 = l_table_data.field087
         LET ga_table_data[l_i].field088 = l_table_data.field088
         LET ga_table_data[l_i].field089 = l_table_data.field089
         LET ga_table_data[l_i].field090 = l_table_data.field090
         LET ga_table_data[l_i].field091 = l_table_data.field091
         LET ga_table_data[l_i].field092 = l_table_data.field092
         LET ga_table_data[l_i].field093 = l_table_data.field093
         LET ga_table_data[l_i].field094 = l_table_data.field094
         LET ga_table_data[l_i].field095 = l_table_data.field095
         LET ga_table_data[l_i].field096 = l_table_data.field096
         LET ga_table_data[l_i].field097 = l_table_data.field097
         LET ga_table_data[l_i].field098 = l_table_data.field098
         LET ga_table_data[l_i].field099 = l_table_data.field099
         LET ga_table_data[l_i].field100 = l_table_data.field100
         LET ga_table_data[l_i].field101 = l_table_data.field101
         LET ga_table_data[l_i].field102 = l_table_data.field102
         LET ga_table_data[l_i].field103 = l_table_data.field103
         LET ga_table_data[l_i].field104 = l_table_data.field104
         LET ga_table_data[l_i].field105 = l_table_data.field105
         LET ga_table_data[l_i].field106 = l_table_data.field106
         LET ga_table_data[l_i].field107 = l_table_data.field107
         LET ga_table_data[l_i].field108 = l_table_data.field108
         LET ga_table_data[l_i].field109 = l_table_data.field109
         LET ga_table_data[l_i].field110 = l_table_data.field110
         LET ga_table_data[l_i].field111 = l_table_data.field111
         LET ga_table_data[l_i].field112 = l_table_data.field112
         LET ga_table_data[l_i].field113 = l_table_data.field113
         LET ga_table_data[l_i].field114 = l_table_data.field114
         LET ga_table_data[l_i].field115 = l_table_data.field115
         LET ga_table_data[l_i].field116 = l_table_data.field116
         LET ga_table_data[l_i].field117 = l_table_data.field117
         LET ga_table_data[l_i].field118 = l_table_data.field118
         LET ga_table_data[l_i].field119 = l_table_data.field119
         LET ga_table_data[l_i].field120 = l_table_data.field120
         LET ga_table_data[l_i].field121 = l_table_data.field121
         LET ga_table_data[l_i].field122 = l_table_data.field122
         LET ga_table_data[l_i].field123 = l_table_data.field123
         LET ga_table_data[l_i].field124 = l_table_data.field124
         LET ga_table_data[l_i].field125 = l_table_data.field125
         LET ga_table_data[l_i].field126 = l_table_data.field126
         LET ga_table_data[l_i].field127 = l_table_data.field127
         LET ga_table_data[l_i].field128 = l_table_data.field128
         LET ga_table_data[l_i].field129 = l_table_data.field129
         LET ga_table_data[l_i].field130 = l_table_data.field130
         LET ga_table_data[l_i].field131 = l_table_data.field131
         LET ga_table_data[l_i].field132 = l_table_data.field132
         LET ga_table_data[l_i].field133 = l_table_data.field133
         LET ga_table_data[l_i].field134 = l_table_data.field134
         LET ga_table_data[l_i].field135 = l_table_data.field135
         LET ga_table_data[l_i].field136 = l_table_data.field136
         LET ga_table_data[l_i].field137 = l_table_data.field137
         LET ga_table_data[l_i].field138 = l_table_data.field138
         LET ga_table_data[l_i].field139 = l_table_data.field139
         LET ga_table_data[l_i].field140 = l_table_data.field140
         LET ga_table_data[l_i].field141 = l_table_data.field141
         LET ga_table_data[l_i].field142 = l_table_data.field142
         LET ga_table_data[l_i].field143 = l_table_data.field143
         LET ga_table_data[l_i].field144 = l_table_data.field144
         LET ga_table_data[l_i].field145 = l_table_data.field145
         LET ga_table_data[l_i].field146 = l_table_data.field146
         LET ga_table_data[l_i].field147 = l_table_data.field147
         LET ga_table_data[l_i].field148 = l_table_data.field148
         LET ga_table_data[l_i].field149 = l_table_data.field149
         LET ga_table_data[l_i].field150 = l_table_data.field150         
       
         FOR l_k = 1 TO g_qry_feld.getLength()
             IF g_qry_feld_type[l_k] = 'date' OR g_qry_feld_type[l_k] = 'DATE' THEN
                CALL azzi310_01_value(l_k,l_i)
             END IF
                #CALL azzi310_01_scale(l_k,l_i)
                CALL azzi310_01_format(l_k,l_i) #161213-00049 mod
         END FOR
         
         IF g_gzic_d_cnt > 0 THEN
         #161215-00017#1 add(s)
             LET pos=l_i
                  IF g_next_flag='Y' AND l_child_cnt=0 THEN				     
                           FOR l_k =1 TO g_qry_feld.getLength()
                                 IF g_gzib_d[g_next_pos].gzib002=g_qry_feld_t[l_k] THEN
                                       CALL azzi310_01_group_check(l_k,l_i) RETURNING l_tag
                                       IF l_tag=1 AND l_i MOD g_rec_b>0 THEN
                                            LET l_next_cnt = l_i + (g_rec_b - (l_i MOD g_rec_b)) + 1
                                            LET ga_table_data[l_next_cnt].*=ga_table_data[l_i].*
                                            LET ga_page_data_t.* = ga_table_data[pos].* 
                                            LET pos=0
                                            INITIALIZE ga_table_data[l_i] to NULL
                                            LET lt_i =l_i
                                            LET l_i=l_next_cnt
                                       END IF
                                 END IF
                           END FOR                                                               
				  END IF 
				  #161215-00017#1 add(e)
          #FOR l_j = 1 TO ga_sum_row.getLength() #150924-00005#1 mark
           LET l_next_tag='N'                    #150924-00005#1 add 
           FOR l_j = ga_sum_row.getLength() to 1 STEP -1  #150924-00005#1 add
             IF ga_sum_row[l_j].getLength() >0 THEN
                IF l_cnt=ga_sum_row[l_j][l_cnt] THEN

                  FOR l_k = 1 TO 2 
                     LET l_i=l_i+1
                     INITIALIZE ga_table_data[l_i].* TO NULL
                     LET ga_sum_rec[l_j,l_cnt,l_k].field001='{*}'
                     LET ga_table_data[l_i].* = ga_sum_rec[l_j,l_cnt,l_k].*
                  END FOR
                  #150924-00005#1 mark(s)
#                  IF g_gzib_d[l_j].gzib004='Y' AND l_i MOD g_rec_b > 0 THEN
##                       LET l_next_cnt = l_i + (g_rec_b - (l_i MOD g_rec_b)) + 1
#                         LET lt_i =l_i
#                         LET l_next_cnt = l_i + (g_rec_b - (l_i MOD g_rec_b)) 
#                         LET l_i=l_next_cnt
# 
#                  END IF
                 #150924-00005#1 mark(s)
                 #150924-00005#1 add(s)
                  IF  g_gzib_d[l_j].gzib004='Y' THEN
                      LET l_next_tag='Y'
                  END IF
                  #150924-00005#1 add(s)
               END IF
                                  
           END IF 
           
         END FOR
         CALL ga_sum_row.deleteElement(l_j)
         #150924-00005#1 add(s)
         IF l_next_tag='Y' AND l_i MOD g_rec_b >0 THEN
             LET lt_i =l_i
             LET l_next_cnt = l_i + (g_rec_b - (l_i MOD g_rec_b)) 
             LET l_i=l_next_cnt
         END IF
         #150924-00005#1 add(s)
         LET l_j=l_j-1
         LET l_i=l_i+1
         #161215-00017#1 add(s)
         IF pos>0 THEN
            LET ga_page_data_t.* = ga_table_data[pos].* 
         END IF
          #161215-00017#1 add(e)
      ELSE
            IF l_next_tag = 'Y' THEN
                FOR l_j =1 TO g_gzib_d.getLength()
                      IF g_gzib_d[l_j].gzib004='Y' THEN
                           FOR l_k =1 TO g_qry_feld.getLength()
                                 IF g_gzib_d[l_j].gzib002=g_qry_feld_t[l_k] THEN
                                       CALL azzi310_01_group_check(l_k,l_i) RETURNING l_tag
                                       IF l_tag=1 AND l_i MOD g_rec_b>0 THEN
                                            LET l_next_cnt = l_i + (g_rec_b - (l_i MOD g_rec_b)) + 1
                                            LET ga_table_data[l_next_cnt].*=ga_table_data[l_i].*
                                            INITIALIZE ga_table_data[l_i] to NULL
                                            LET lt_i =l_i
                                            LET l_i=l_next_cnt
                                       END IF
                                 END IF
                           END FOR 
                              
                      END IF
                END FOR   
                LET ga_page_data_t.* = ga_table_data[l_i].*
                LET l_i=l_i+1
            ELSE
               LET l_i=l_i+1
            END IF
         END IF
         IF l_bar < 10 THEN 
            CALL cl_progress_ing("process: Query")
            LET l_bar = l_bar + 1
         END IF
         LET l_cnt = l_cnt + 1
          IF (g_gzia005 is not null and l_cnt > g_gzia005) THEN
            LET g_max_tag = 1 
            EXIT FOREACH
         END IF
         
     END FOREACH
     CALL ga_table_data.deleteElement(l_i)
     CALL cl_progress_bar_close()
 
     IF SQLCA.SQLCODE THEN
        LET g_errparam.code = sqlca.sqlcode 
        LET g_errparam.extend =''
        LET g_errparam.popup = FALSE
        CALL cl_err()
     ELSE
          IF g_gzic_sum_cnt >0 AND l_i>1 THEN
             IF lt_i>0 THEN
                 #LET l_i=lt_i+1
                 LET l_i=ga_table_data.getLength()+1 #161215-00017#1 mod
             END IF
             FOR l_k = 1 TO 2 
               LET l_i=l_i+1
               INITIALIZE ga_table_data[l_i].* TO NULL
                LET ga_sum_rec[ga_sum_row.getLength(),l_cnt,l_k].field001='{*}'
                LET ga_table_data[l_i-1].* = ga_sum_rec[ga_sum_row.getLength(),l_cnt,l_k].*
           END FOR
          END IF
          
     END IF
     CALL ga_table_data.deleteElement(l_i)
     LET g_query_rec_b = l_i - 1

     #取得各字段的字段属性格式(gzid010)设定
     LET l_sql1 = "SELECT gzid010 FROM gzid_t ", 
                  "   WHERE gzid001 = '", g_query_prog,"'",
                  "   ORDER BY gzid002"
     PREPARE azzi310_01_sel_gzid010_pre FROM l_sql1           #预备一下
     DECLARE azzi310_01_gzid010_sel_curs CURSOR FOR azzi310_01_sel_gzid010_pre
     LET l_i = 1
     FOREACH azzi310_01_gzid010_sel_curs INTO l_gzid010[l_i]
          LET l_i = l_i + 1
     END FOREACH
     CALL l_gzid010.deleteElement(l_i)
     LET l_i = 1
     
     #检查各字段属性如果属于'N203'(汇率)格式,则将千方位字符不显示
     FOR l_i = 1 TO ga_table_data.getlength()
        FOR l_k = 1 TO g_qry_feld.getLength()
           IF l_gzid010[l_k] ="N203" THEN   #汇率
              CALL azzi310_01_replace_str(l_k, l_i)   #将汇率格式千方位取消('目前check字段','目前笔数')
           END IF
        END FOR
     END FOR
  
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzi310_01_buildForm()  
# Input parameter: none
# Return code....: none
# Date & Author..: 2015/07/16 by chenjpa
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_01_buildForm()
    DEFINE lwin_curr        ui.Window
    DEFINE lfrm_curr       ui.Form
    DEFINE ln_win        om.DomNode
    DEFINE ln_tmp        om.DomNode
    DEFINE ln_child      om.DomNode
    DEFINE ls_tmp        om.NodeList
    
 
    LET lwin_curr = ui.Window.getCurrent()
 
    #建立連查畫面
    LET lfrm_curr = lwin_curr.getForm()
    LET ln_tmp = lfrm_curr.findNode("Group","group_1")
    LET ln_child = ln_tmp.createChild("VBox")
    CALL azzi310_01_query_buildTable(ln_child)
END FUNCTION

################################################################################
# Descriptions...: View 窗口显示所查询数据,及过滤数据
# Memo...........:
# Usage..........: CALLazzi310_01_showPage()
# Input parameter: none
# Return code....: none
# Date & Author..: 2015/07/16 by chenjpa
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_01_showPage()

#    DEFINE l_page                LIKE type_t.num10
#    DEFINE l_i                   LIKE type_t.num10
#    DEFINE l_curr                LIKE type_t.num5  
#    DEFINE l_rec_b               LIKE type_t.num10,   #单身笔数
#           l_curr_page           LIKE type_t.num10,   # Current Page Number
#           l_total_page          LIKE type_t.num10    # Total Pages
#    DEFINE l_action              STRING
#    DEFINE l_table_data_t DYNAMIC ARRAY OF type_field
#    DEFINE  ls_msg                STRING
# 
#    CALL ga_table_data_t.clear()
#    FOR l_i = 1 TO ga_table_data.getLength()
#        LET ga_page_data_t.* = ga_table_data[l_i].*
#        LET ga_table_data_t[l_i].* = ga_page_data_t.*
#    END FOR
#    LET g_rec_b_t      = g_rec_b     
#    LET g_total_page_t = g_total_page
#    LET l_action = ""
#    LET l_ac = 1
#    
#    WHILE TRUE
# 
#        IF INT_FLAG THEN
#           IF g_gzia002 != "N" OR cl_null(g_gzia002) THEN 
#              LET INT_FLAG = 0                      
#           END IF
#           EXIT WHILE
#        END IF
#        #过滤条件
##        IF l_action = 'filter' THEN
##           CALL azzi310_01_filter()
##           IF INT_FLAG THEN
##              LET INT_FLAG = 0
##           END IF
##           LET l_action = ""
##        END IF
# 
#        CALL azzi310_01_loadPage()
# 
#        LET l_page = g_curr_page
# 
#        #重新设定连查数据及画面
#        CALL azzi310_01_settab()
#        
#        DISPLAY g_header_str TO text1
#        DISPLAY g_trailer_str TO text2
##        DISPLAY l_page TO curr
##        DISPLAY g_total_page TO FORMONLY.total
#        DISPLAY l_page TO FORMONLY.h_index
#        DISPLAY g_total_page TO FORMONLY.h_count
#        
#        
#     DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
#        DISPLAY ARRAY ga_page_data TO s_table_data.* 
#          ATTRIBUTE(COUNT=g_rec_b )
# 
#            BEFORE DISPLAY 
# 
#               CALL azzi310_01_disableAction(DIALOG)
#               IF g_rec_b != 0 THEN
#                  CALL fgl_set_arr_curr(l_ac)
#               END IF
##               IF cl_null(g_wc2) THEN
##                  CALL cl_set_act_visible("unfilter", FALSE)
##               END IF
# 
#            BEFORE ROW
#               LET l_ac = ARR_CURR()
#        END DISPLAY
#          
#           BEFORE DIALOG
#           CALL cl_navigator_setting(l_page, g_total_page )
##           
##            ON ACTION other_output #多格式输出
##                LET l_rec_b      = g_rec_b     
##                LET l_curr_page  = g_curr_page 
##                LET l_total_page = g_total_page
##                CALL l_table_data_t.clear()
##                FOR l_i = 1 TO ga_table_data.getLength()
##                    LET ga_page_data_t.* = ga_table_data[l_i].*
##                    LET l_table_data_t[l_i].* = ga_page_data_t.*
##                END FOR
##                CALL azzi310_01_output()
##                CALL ga_table_data.clear()
##                FOR l_i = 1 TO l_table_data_t.getLength()
##                    LET ga_page_data_t.* = l_table_data_t[l_i].*
##                    LET ga_table_data[l_i].* = ga_page_data_t.*
##                END FOR
##                LET g_out_type = 'V'
##                IF g_len > 150 THEN
##                   LET g_len = 150
##                END IF
## 
##                LET g_rec_b      = l_rec_b     
##                LET g_curr_page  = l_curr_page 
##                LET g_total_page = l_total_page
#              #  EXIT DISPLAY  
##                EXIT DIALOG
#             
#             on action exporttoexcel
#                LET l_rec_b      = g_rec_b     
#                LET l_curr_page  = g_curr_page 
#                LET l_total_page = g_total_page
#                CALL l_table_data_t.clear()
#                FOR l_i = 1 TO ga_table_data.getLength()
#                    LET ga_page_data_t.* = ga_table_data[l_i].*
#                    LET l_table_data_t[l_i].* = ga_page_data_t.*
#                END FOR
#                 CALL azzi310_01_o('E')
#                CALL ga_table_data.clear()
#                FOR l_i = 1 TO l_table_data_t.getLength()
#                    LET ga_page_data_t.* = l_table_data_t[l_i].*
#                    LET ga_table_data[l_i].* = ga_page_data_t.*
#                END FOR
#                LET g_out_type = 'V'
#                IF g_len > 150 THEN
#                   LET g_len = 150
#                END IF
# 
#                LET g_rec_b      = l_rec_b     
#                LET g_curr_page  = l_curr_page 
#                LET g_total_page = l_total_page
##                EXIT DIALOG
#
##            ON ACTION local_print                 #Local Printer List
##                LET l_rec_b      = g_rec_b     
##                LET l_curr_page  = g_curr_page 
##                LET l_total_page = g_total_page
##                CALL l_table_data_t.clear()
##                FOR l_i = 1 TO ga_table_data.getLength()
##                    LET ga_page_data_t.* = ga_table_data[l_i].*
##                    LET l_table_data_t[l_i].* = ga_page_data_t.*
##                END FOR
## 
##                CALL azzi310_01_o('V')
## 
##                CALL ga_table_data.clear()
##                FOR l_i = 1 TO l_table_data_t.getLength()
##                    LET ga_page_data_t.* = l_table_data_t[l_i].*
##                    LET ga_table_data[l_i].* = ga_page_data_t.*
##                END FOR
##                LET g_out_type = 'V'
## 
##                IF g_len > 150 THEN
##                   LET g_len = 150
##                END IF
## 
##                LET g_rec_b      = l_rec_b     
##                LET g_curr_page  = l_curr_page 
##                LET g_total_page = l_total_page
##                EXIT DISPLAY  
# 
## 
##            ON ACTION filter
##               CALL cl_set_act_visible("unfilter", TRUE)
##               LET l_action = 'filter'
##               EXIT DISPLAY
##               
##            ON ACTION unfilter
##                CALL ga_table_data.clear()
##                FOR l_i = 1 TO ga_table_data_t.getLength()
##                    LET ga_page_data_t.* = ga_table_data_t[l_i].*
##                    LET ga_table_data[l_i].* = ga_page_data_t.*
##                END FOR
##                LET g_rec_b      = g_rec_b_t     
##                LET g_curr_page  = 1 
##                LET g_total_page = g_total_page_t
##                LET g_wc2 = NULL
##                LET g_wc2_name = NULL
##                EXIT DISPLAY  
#               
#            ON ACTION first   # Jump to First Page
##             ON ACTION first_page
#                LET g_curr_page = 1
##                EXIT DISPLAY
#                EXIT DIALOG
# 
#            ON ACTION next    # Jump to Next Page    
##            ON ACTION next_page            
#                LET g_curr_page = g_curr_page + 1
##                EXIT DISPLAY
#                  EXIT DIALOG
# 
#            ON ACTION previous    # Jump to Previous Page     
##            ON ACTION prev_page            
#                LET g_curr_page = g_curr_page - 1
##                EXIT DISPLAY
#               EXIT DIALOG
#   
##            ON ACTION last_page    # Jump to Last Page  
#            ON ACTION last            
#                LET g_curr_page = g_total_page
##                EXIT DISPLAY
#                EXIT DIALOG
#                
#            ON ACTION jump
#         IF (NOT g_no_ask) THEN    
#            CALL cl_set_act_visible("accept,cancel", TRUE)    
#            #CALL cl_getmsg('fetch',g_lang) RETURNING ls_msg
#            CALL cl_getmsg('fetch',g_dlang) RETURNING ls_msg
#            LET INT_FLAG = 0
# 
#            PROMPT ls_msg CLIPPED,':' FOR g_jump
#               #交談指令共用ACTION
#               &include "common_action.4gl" 
#            END PROMPT
# 
#            CALL cl_set_act_visible("accept,cancel", FALSE)             
#         END IF
#         
#         IF g_jump > 0 AND g_jump <= g_total_page THEN
#             LET g_curr_page = g_jump
#         END IF
#         LET g_no_ask = FALSE
#         EXIT DIALOG
##            ON IDLE g_idle_seconds
##               CALL cl_on_idle()
##               CONTINUE DISPLAY
# 
#            ON ACTION controlg
#               CALL cl_cmdask()
## 
##            ON ACTION about
##               CALL cl_about()
#               
#       ON ACTION exit
#         LET INT_FLAG = TRUE 
##         EXIT DISPLAY
#               EXIT DIALOG
#            
#       END DIALOG
# 
#
# 
#    END WHILE

END FUNCTION

################################################################################
# Descriptions...: 取得所选择页次的查询数据
# Memo...........:
# Usage..........: CALL azzi310_01_loadPage()
# Input parameter: none
# Return code....: none
# Date & Author..: 2015/07/16 by chenjpa
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_01_loadPage()
DEFINE l_i            LIKE type_t.num10
    DEFINE l_j            LIKE type_t.num10
    DEFINE l_k            LIKE type_t.num10
    DEFINE l_str          STRING
    DEFINE l_line_str     STRING
    DEFINE l_column       LIKE type_t.num10
    DEFINE l_gzzd005        LIKE gzzd_t.gzzd005
    DEFINE l_gzze003         LIKE gzze_t.gzze003
    DEFINE l_rec_b        LIKE type_t.num10              #单身笔数
    DEFINE l_curr_b       LIKE type_t.num10              #单身笔数
    DEFINE l_gzid004        LIKE gzid_t.gzid004
    DEFINE l_gzidl004        LIKE gzidl_t.gzidl004
    DEFINE l_sql          STRING
    DEFINE l_wc           STRING
    DEFINE l_dash         STRING                            
    DEFINE lc_ooefl003       LIKE ooefl_t.ooefl003,
           lc_ooag011        LIKE ooag_t.ooag011,
           l_company_len  SMALLINT,
           l_plant_len    SMALLINT,
           l_ooefl003_len    SMALLINT
    DEFINE lc_plant       STRING                            
    
    DEFINE l_abs1,l_abs2  DECIMAL(4,1)
    DEFINE l_quote                         STRING   #160830-00018#1 add
    
    CALL ga_page_data.clear()
    LET g_header_str = NULL   
    LET g_trailer_str = NULL  
    LET l_rec_b = g_rec_b * g_curr_page
    LET l_curr_b = 1 + (g_rec_b*(g_curr_page-1))
 
    LET l_i = 0
    #单身资料
     FOR l_j = l_curr_b TO l_rec_b   
         LET l_i = l_i + 1
         LET ga_page_data[l_i].* = ga_table_data[l_j].*
         IF ga_page_data[l_i].field001 CLIPPED = '{*}' THEN
             LET ga_page_data[l_i].field001 = ''
         END IF
     END FOR
    
    #公司名称  
   SELECT gzoul003 INTO g_company FROM gzoul_t
    WHERE gzoul001 = g_enterprise AND gzoul002 = g_lang
    IF cl_null(g_company) THEN
       LET g_company = cl_getmsg("sui-00004",g_lang)
    END IF
    LET lc_ooefl003 = cl_get_deptname(g_site)

    LET l_company_len = FGL_WIDTH(g_company CLIPPED)
    LET l_plant_len = FGL_WIDTH(g_site CLIPPED)
    LET l_ooefl003_len = FGL_WIDTH(lc_ooefl003 CLIPPED)
                                
    LET lc_plant="[", g_site CLIPPED,":",lc_ooefl003 CLIPPED, "]"
    LET l_column=(g_len-l_company_len-FGL_WIDTH(lc_plant))/2+1 #160825-00014#1 add
    LET l_str = azzi310_01_space(l_column) 
    LET g_header_str = g_header_str,l_str,g_company CLIPPED,lc_plant CLIPPED,l_str,"\n"  
    LET g_header_str = g_header_str,"\n"
    
    #报表名称
    LET l_column=(g_len-FGL_WIDTH(g_gzial003 CLIPPED))/2+1     #160825-00014#1 mod
    LET l_str = azzi310_01_space(l_column)                 
    LET g_header_str = g_header_str,l_str,g_gzial003 CLIPPED,"\n"
 
    #制表日期
    LET l_line_str = ""
    LET l_gzzd005=""
    SELECT gzze003 INTO l_gzzd005 FROM gzze_t
     WHERE gzze001='azz-00902' AND gzze002=g_dlang AND gzze007='2' AND gzzestus='Y'
              
     #160408-00017#1 mod(s)     
     LET l_line_str = l_gzzd005 CLIPPED,":",cl_get_current()
     LET g_header_str = g_header_str,l_line_str       
     #160408-00017#1 mod(e)
     
     #160830-00018#1 add(s)
     LET l_quote=""""
     LET g_azzi310_report.cdate="    <Cell ss:MergeAcross=",l_quote||g_show_cnt||l_quote," ss:StyleID=",l_quote,"s62",l_quote,"><Data ss:Type=",l_quote,"String",l_quote,">",l_line_str,"</Data></Cell>"
     #160830-00018#1 add(e)
     
    #制表人
       LET l_column = FGL_WIDTH(l_line_str)    #160825-00014#1 add
       LET l_gzzd005=""
        SELECT gzze003 INTO l_gzzd005 FROM gzze_t
        WHERE gzze001='azz-00901' AND gzze002=g_dlang AND gzze007='2' AND gzzestus='Y'

        LET lc_ooag011= cl_get_username(g_user)

       LET l_column = g_len-FGL_WIDTH(g_account CLIPPED)-FGL_WIDTH(lc_ooag011 CLIPPED)-FGL_WIDTH(l_gzzd005 CLIPPED)-20
                      - l_column-3 #160825-00014#1 mod
       LET l_str = azzi310_01_space(l_column) 
 
       LET l_line_str = l_line_str,l_str,l_gzzd005 CLIPPED,g_account
       LET g_header_str = g_header_str,l_str,l_gzzd005 CLIPPED,":",lc_ooag011,"(",g_account,")" 
       
       LET g_azzi310_report.creator="    <Cell ss:MergeAcross=",l_quote||g_show_cnt||l_quote," ss:StyleID=",l_quote,"s62",l_quote,"><Data ss:Type=",l_quote,"String",l_quote,">",l_gzzd005 CLIPPED,":",lc_ooag011,"(",g_account,")</Data></Cell>"
    
    #页次
       #LET l_column = l_line_str.getLength()      #160825-00014#1 mark
       LET l_gzzd005=""
       SELECT gzze003 INTO l_gzzd005 FROM gzze_t
        WHERE gzze001='azz-00903' AND gzze002=g_dlang AND gzze007='2' AND gzzestus='Y'
        LET l_column=20-FGL_WIDTH(l_gzzd005)-FGL_WIDTH(g_curr_page)-FGL_WIDTH(g_total_page)-2
       #LET l_column=20-l_column-(l_column-19)#160825-00014#1 add
       LET l_str = azzi310_01_space(l_column)
       LET g_header_str = g_header_str,l_str,l_gzzd005 CLIPPED,":",
                          g_curr_page USING '<<<<<<<<<<','/',
                          g_total_page USING '<<<<<<<<<<'
 
    LET g_header_str = g_header_str,"\n"
 
    #排列顺序   
    LET l_gzzd005=""
    SELECT gzzd005 INTO l_gzzd005 FROM gzzd_t
       WHERE gzzd001='azzi310' and gzzd003='gzib003' and gzzd002=g_dlang
    LET l_line_str=""
    FOR l_i = 1 TO g_gzib_d.getLength()
        SELECT unique(gzidl004) INTO l_gzidl004 FROM gzid_t,gzidl_t
         WHERE gzidl001=gzid001 AND gzidl002=gzid002 
           AND gzid004 = g_gzib_d[l_i].gzib002 AND gzidl003 = g_dlang 
           AND gzidl001 = g_query_prog 
       IF cl_null(l_gzidl004) THEN
       	  SELECT unique(dzebl003) INTO l_gzidl004 FROM dzebl_t
       	   WHERE dzebl001=g_gzib_d[l_i].gzib002 AND dzebl002=g_dlang
       	   #  AND dzebl000=g_gzib_d[l_i].gzib003
        END IF
        
        #160830-00018#1 mod(s)
        IF l_i = 1 THEN
           #LET g_header_str = g_header_str,l_gzzd005 CLIPPED,":",l_gzidl004 CLIPPED,"(",g_gzib_d[l_i].gzib002 CLIPPED,")"
           LET l_line_str = l_gzzd005 CLIPPED,":",l_gzidl004 CLIPPED,"(",g_gzib_d[l_i].gzib002 CLIPPED,")"
        ELSE
           #LET g_header_str = g_header_str,"-",l_gzidl004 CLIPPED,"(",g_gzib_d[l_i].gzib002 CLIPPED,")"
           LET l_line_str = l_line_str,"-",l_gzidl004 CLIPPED,"(",g_gzib_d[l_i].gzib002 CLIPPED,")"
        END IF 
         #160830-00018#1 mod(e)
    END FOR
    
    #160830-00018#1 add(s)
    LET g_header_str=g_header_str,l_line_str 
    LET g_azzi310_report.corder="    <Cell ss:MergeAcross=",l_quote||g_show_cnt||l_quote," ss:StyleID=",l_quote,"s62",l_quote,"><Data ss:Type=",l_quote,"String",l_quote,">",l_line_str,"</Data></Cell>"       
    #160830-00018#1 add(e) 
    
    #表尾资料
    IF g_curr_page = g_total_page THEN  #结束
      SELECT gzze003 INTO l_gzze003 FROM gzze_t   
          WHERE gzze001='azz-00798' AND gzze002=g_dlang
    ELSE
       SELECT gzze003 INTO l_gzze003 FROM gzze_t  #接下页
          WHERE gzze001='azz-00797' AND gzze002=g_dlang
    END IF
   #LET l_line_str = "(",g_gzia001 CLIPPED,")"
   #LET g_trailer_str = g_trailer_str,"(",g_gzia001 CLIPPED,")"
    LET l_line_str = "(",g_query_prog CLIPPED,")"                   
    LET g_trailer_str = l_line_str                
    LET l_column=g_len-FGL_WIDTH(l_gzze003 CLIPPED)-FGL_WIDTH(l_line_str CLIPPED)  #160825-00014#1 add
    LET l_str = azzi310_01_space(l_column)
    LET g_trailer_str = g_trailer_str,l_str,l_gzze003 CLIPPED
    IF g_curr_page != g_total_page THEN
      LET g_trailer_str = g_trailer_str,l_str,"\n\n" #160825-00014#1 mark 恢复
      #LET g_trailer_str = g_trailer_str,"\n\n"          #160825-00014#1 add
    END IF
    
   #160830-00018#1 add(s)
    LET g_azzi310_report.company="    <Cell ss:MergeAcross=",l_quote||g_show_cnt||l_quote," ss:StyleID=",l_quote,"s69",l_quote,"><Data ss:Type=",l_quote,"String",l_quote,">",g_company CLIPPED,lc_plant CLIPPED,"</Data></Cell>"
    LET g_azzi310_report.head_title="    <Cell ss:MergeAcross=",l_quote||g_show_cnt||l_quote," ss:StyleID=",l_quote,"s69",l_quote,"><Data ss:Type=",l_quote,"String",l_quote,">",g_gzial003,"</Data></Cell>"
    SELECT gzze003 INTO l_gzze003 FROM gzze_t   
          WHERE gzze001='azz-00798' AND gzze002=g_dlang
    LET g_azzi310_report.footer_title="    <Cell ss:MergeAcross=",l_quote||g_show_cnt||l_quote," ss:StyleID=",l_quote,"s62",l_quote,"><Data ss:Type=",l_quote,"String",l_quote,">","(",g_query_prog CLIPPED,")","</Data></Cell>"
    LET g_azzi310_report.footer="    <Cell ss:MergeAcross=",l_quote||g_show_cnt||l_quote," ss:StyleID=",l_quote,"s62",l_quote,"><Data ss:Type=",l_quote,"String",l_quote,">",l_gzze003,"</Data></Cell>"
   #160830-00018#1 add(e)
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzi310_01_advance()
# Input parameter: none
# Return code....: none
# Date & Author..: 2015/07/16 by chenjpa
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_01_advance()
    DEFINE lwin_curr       ui.Window
    DEFINE lfrm_curr         ui.Form
    DEFINE ln_win       om.DomNode,
    ls_path             STRING

 #画面开启 (identifier)
   OPEN WINDOW w_azzi310_01_advance WITH FORM cl_ap_formpath("azz","azzi310_01_s03") ATTRIBUTE(STYLE="openwin")
   #OPEN WINDOW w_azzi310_01_advance WITH FORM cl_ap_formpath("azz","azzi310_01") ATTRIBUTE(STYLE="openwin")

   #浏览页签数据初始化
    CALL cl_ui_init()
    CALL cl_load_style_list(NULL)

    LET lwin_curr = ui.Window.getCurrent()
    LET ln_win = lwin_curr.getNode()

    LET lfrm_curr = lwin_curr.getForm()
    LET ls_path = os.Path.join(os.Path.join(FGL_GETENV("ERP"),"cfg"),"4tb")
    LET ls_path = os.Path.join(ls_path,"toolbar_azzi310_01.4tb")
    CALL lfrm_curr.loadToolBar(ls_path)
 
    CALL cl_set_combo_scc('gzic003_1','142') 
    CALL cl_set_combo_scc('gzic003_2','142') 
    CALL cl_set_combo_scc('gzic003_3','142') 
    CALL cl_set_combo_scc('gzic007_1','196') 
    CALL cl_set_combo_scc('gzic007_2','196') 
    CALL cl_set_combo_scc('gzic007_3','196') 

    CALL azzi310_01_advance_show()
 
    LET g_action_choice = "page_display"
 
    CALL azzi310_01_advance_menu()
 
    #依照进阶查询选项设定，产生报表数据
    CALL azzi310_01_advance_finish()         
 
    CLOSE WINDOW w_azzi310_01_advance

END FUNCTION

################################################################################
# Descriptions...: 进阶查询条件的默认值
# Memo...........:
# Usage..........: azzi310_01_advance_show()
# Input parameter: none
# Return code....: none 
# Date & Author..: 2015/07/16 by chenjpa
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_01_advance_show()
DEFINE l_values       STRING
DEFINE l_id_items     STRING
DEFINE l_name_items   STRING
DEFINE l_i            LIKE type_t.num5
DEFINE l_j            LIKE type_t.num5
DEFINE l_n            LIKE type_t.num5
DEFINE l_k            LIKE type_t.num5
 
  INITIALIZE g_more.*   TO NULL
  CALL g_dis_gzid.clear()
  CALL g_gzic_d1.clear()
  CALL g_gzic_d2.clear()
  CALL g_gzic_d3.clear()
  LET g_gzic_d1_rec_b = 0 
  LET g_gzic_d2_rec_b = 0 
  LET g_gzic_d3_rec_b = 0 
 
  #隐藏域资料
  FOR l_i = 1 TO g_qry_feld_cnt 
      LET g_dis_gzid[l_i].gzid002=g_qry_seq[l_i]
      LET g_dis_gzid[l_i].gzid005 = g_qry_show[l_i]
      LET g_dis_gzid[l_i].gzid004 = g_qry_feld_t[l_i]
      LET g_dis_gzid[l_i].gzidl004 = g_qry_feld[l_i]
      IF l_i = 1 THEN
         LET l_values = l_i USING '<<<<<'
         LET l_name_items = g_qry_feld[l_i] CLIPPED
      ELSE
         LET l_values = l_values ,",",l_i USING '<<<<<'
         LET l_name_items = l_name_items,",",g_qry_feld[l_i] CLIPPED
      END IF
  END FOR
 
  LET l_id_items = ""
  FOR l_i = 1 TO g_qry_feld_cnt
      IF (NOT (g_qry_feld_type[l_i] = "varchar2" OR 
              g_qry_feld_type[l_i] = "char" OR g_qry_feld_type[l_i] = "date"))
         OR cl_null(g_qry_feld_type[l_i])
      THEN 
         IF cl_null(l_id_items) THEN
            LET l_id_items = g_qry_feld_t[l_i] CLIPPED
         ELSE
            LET l_id_items = l_id_items,",",g_qry_feld_t[l_i] CLIPPED
         END IF
      END IF
  END FOR
 
  #建立Combobox排序数据
  CALL cl_set_combo_items("s1",l_values,l_name_items)
  CALL cl_set_combo_items("s2",l_values,l_name_items)
  CALL cl_set_combo_items("s3",l_values,l_name_items)
  CALL cl_set_combo_items("ngzid004_1",l_id_items,l_id_items)
  CALL cl_set_combo_items("ngzid004_2",l_id_items,l_id_items)
  CALL cl_set_combo_items("ngzid004_3",l_id_items,l_id_items)
 
  
  LET g_more.u1 = "N"
  LET g_more.t1 = "N"
  LET g_more.u2 = "N"
  LET g_more.t2 = "N"
  LET g_more.u3 = "N"
  LET g_more.t3 = "N"
 
  #排序/跳页/计算否数据
  FOR l_i = 1 TO g_gzib_d.getLength()
      CASE l_i
         WHEN 1
             LET g_more.s1 =l_i
             LET g_more.t1 = g_gzib_d[l_i].gzib004
             FOR l_j = 1 TO g_gzic_d.getLength()
                 IF g_gzib_d[l_i].gzib002 = g_gzic_d[l_j].ggzid004 THEN
                    LET g_more.u1 = "Y"
                    EXIT FOR
                 END IF
             END FOR
         WHEN 2
             LET g_more.s2 = l_i
             LET g_more.t2 = g_gzib_d[l_i].gzib004
             FOR l_j = 1 TO g_gzic_d.getLength()
                 IF g_gzib_d[l_i].gzib002 = g_gzic_d[l_j].ggzid004 THEN
                    LET g_more.u2 = "Y"
                    EXIT FOR
                 END IF
             END FOR
         WHEN 3           
              LET g_more.s3 = l_i
              LET g_more.t3 = g_gzib_d[l_i].gzib004
             FOR l_j = 1 TO g_gzic_d.getLength()
                 IF g_gzib_d[l_i].gzib002 = g_gzic_d[l_j].ggzid004 THEN
                    LET g_more.u3 = "Y"
                    EXIT FOR
                 END IF
             END FOR
         OTHERWISE
            EXIT FOR
      END CASE
  END FOR
 
  #计算式数据
  #CALL cl_set_comp_visible("page3,page4,page5", FALSE)           
  CALL cl_set_comp_visible("page_sum1,page_sum2,page_sum3", FALSE)           
 
  IF g_more.u1 = "Y" THEN
     LET l_j = g_more.s1
     FOR l_i = 1 TO g_gzic_d.getLength()
        #IF g_gzic_d[l_i].ggzid004 = g_qry_feld_t[l_j] THEN
        IF g_gzic_d[l_i].ggzid004 = g_gzib_d[l_j].gzib002 THEN
           LET l_n = g_gzic_d1.getLength() + 1
           LET g_gzic_d1[l_n].ngzid004_1 = g_gzic_d[l_i].gzid004
           LET g_gzic_d1[l_n].gzic003_1 = g_gzic_d[l_i].gzic003 
           LET g_gzic_d1[l_n].gzic007_1 = g_gzic_d[l_i].gzic007 
           FOR l_k = 1 TO g_qry_feld_cnt 
               IF g_gzic_d1[l_n].ngzid004_1 = g_qry_feld_t[l_k] THEN
                  LET g_gzic_d1[l_n].ngzidl004_1 = g_qry_feld[l_k]
                  LET g_gzic_d1[l_n].ngzid002_1 = g_qry_seq[l_k]
                  EXIT FOR
               END IF
           END FOR
        END IF
     END FOR 
     #CALL cl_set_comp_visible("page3", TRUE)           
     CALL cl_set_comp_visible("page_sum1", TRUE)           
  END IF               
 
  IF g_more.u2 = "Y" THEN
     LET l_j = g_more.s2
     FOR l_i = 1 TO g_gzic_d.getLength()
        #IF g_gzic_d[l_i].ggzid004 = g_qry_feld_t[l_j] THEN
        IF g_gzic_d[l_i].ggzid004 = g_gzib_d[l_j].gzib002 THEN
           LET l_n = g_gzic_d2.getLength() + 1
           LET g_gzic_d2[l_n].ngzid004_2 = g_gzic_d[l_i].gzid004
           LET g_gzic_d2[l_n].gzic003_2 = g_gzic_d[l_i].gzic003 
           LET g_gzic_d2[l_n].gzic007_2 = g_gzic_d[l_i].gzic007 
           FOR l_k = 1 TO g_qry_feld_cnt 
               IF g_gzic_d2[l_n].ngzid004_2 = g_qry_feld_t[l_k] THEN
                  LET g_gzic_d2[l_n].ngzidl004_2 = g_qry_feld[l_k]
                  LET g_gzic_d2[l_n].ngzid002_2 = g_qry_seq[l_k]
                  EXIT FOR
               END IF
           END FOR
        END IF
     END FOR
     #CALL cl_set_comp_visible("page4", TRUE)           
     CALL cl_set_comp_visible("page_sum2", TRUE)           
  END IF
 
  IF g_more.u3 = "Y" THEN
     LET l_j = g_more.s3
     FOR l_i = 1 TO g_gzic_d.getLength()
        #IF g_gzic_d[l_i].ggzid004 = g_qry_feld_t[l_j] THEN
        IF g_gzic_d[l_i].ggzid004 = g_gzib_d[l_j].gzib002 THEN
           LET l_n = g_gzic_d3.getLength() + 1
           LET g_gzic_d3[l_n].ngzid004_3 = g_gzic_d[l_i].gzid004
           LET g_gzic_d3[l_n].gzic003_3 = g_gzic_d[l_i].gzic003 
           LET g_gzic_d3[l_n].gzic007_3 = g_gzic_d[l_i].gzic007 
           FOR l_k = 1 TO g_qry_feld_cnt 
               IF g_gzic_d3[l_n].ngzid004_3 = g_qry_feld_t[l_k] THEN
                  LET g_gzic_d3[l_n].ngzidl004_3 = g_qry_feld[l_k]
                  LET g_gzic_d3[l_n].ngzid002_3 = g_qry_seq[l_k]
                  EXIT FOR
               END IF
           END FOR
        END IF
     END FOR
     #CALL cl_set_comp_visible("page5", TRUE)           
     CALL cl_set_comp_visible("page_sum3", TRUE)           
  END IF
 
  DISPLAY BY NAME g_more.s1,g_more.s2,g_more.s3,
                  g_more.t1,g_more.t2,g_more.t3,
                  g_more.u1,g_more.u2,g_more.u3
 
  DISPLAY ARRAY g_dis_gzid TO s_detail1.* ATTRIBUTE(COUNT=g_qry_feld_cnt,UNBUFFERED)
     BEFORE DISPLAY
        EXIT DISPLAY
  END DISPLAY
   
  LET g_gzic_d1_rec_b = g_gzic_d1.getLength()
  DISPLAY ARRAY g_gzic_d1 TO s_detail2.* ATTRIBUTE(COUNT=g_gzic_d1_rec_b,UNBUFFERED)
     BEFORE DISPLAY
        EXIT DISPLAY
  END DISPLAY
 
  LET g_gzic_d2_rec_b = g_gzic_d2.getLength()
  DISPLAY ARRAY g_gzic_d2 TO s_detail3.* ATTRIBUTE(COUNT=g_gzic_d2_rec_b,UNBUFFERED)
     BEFORE DISPLAY
        EXIT DISPLAY
  END DISPLAY
 
  LET g_gzic_d3_rec_b = g_gzic_d3.getLength()
  DISPLAY ARRAY g_gzic_d3 TO s_detail4.* ATTRIBUTE(COUNT=g_gzic_d3_rec_b,UNBUFFERED)
     BEFORE DISPLAY
        EXIT DISPLAY
  END DISPLAY

  
END FUNCTION

################################################################################
# Descriptions...: 进阶查询条件功能 menu
# Memo...........:
# Usage..........: CALL azzi310_01_advance_menu()
# Input parameter: none
# Return code....: none
# Date & Author..: 2015/07/16 by chenjpa
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_01_advance_menu()

   WHILE TRUE
      CASE g_action_choice
         WHEN "page_display"               #显示/隐藏 page
              CALL azzi310_01_dis()
         WHEN "page_option"                #条件选择 page
              CALL azzi310_01_option()
         WHEN "page_sum1"                  #计算1 page
              CALL azzi310_01_sum1()
         WHEN "page_sum2"                  #计算2 page
              CALL azzi310_01_sum2()
         WHEN "page_sum3"                  #计算3 page
              CALL azzi310_01_sum3()
         WHEN "exit"
              EXIT WHILE
      END CASE
    END WHILE

END FUNCTION

################################################################################
# Descriptions...: 依照进阶查询选项设定，产生报表数据
# Memo...........:
# Usage..........: CALL azzi310_01_advance_finish()
# Input parameter: none
# Return code....: none
# Date & Author..: 2015/07/16 by chenjpa
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_01_advance_finish()
DEFINE l_i            LIKE type_t.num5
DEFINE l_j            LIKE type_t.num5
DEFINE l_k            LIKE type_t.num5
DEFINE l_cnt          LIKE type_t.num5
 
    #显示/隐藏设定
     CALL g_qry_show.clear()
     FOR l_i = 1 TO g_qry_feld_cnt 
            LET g_qry_show[l_i] = g_dis_gzid[l_i].gzid005
     END FOR
 
    #排列顺序,跳页
     CALL g_gzib_d.clear()
     CALL g_gzic_d.clear()
 
     IF NOT cl_null(g_more.s1) THEN
        LET l_i = g_more.s1
        LET l_cnt = g_gzib_d.getLength() + 1
        LET g_gzib_d[l_cnt].gzib002 = g_qry_feld_t[l_i]
        LET g_gzib_d[l_cnt].gzib004 = g_more.t1
        LET g_gzib_d[l_cnt].gzib006 = "1"
        IF g_more.u1 = "Y" THEN
           FOR l_j = 1 TO g_gzic_d1_rec_b
             IF not cl_null(g_gzic_d1[l_j].ngzid004_1) THEN
               LET l_cnt = g_gzic_d.getLength() + 1
               LET g_gzic_d[l_cnt].gzid004 = g_gzic_d1[l_j].ngzid004_1
               LET g_gzic_d[l_cnt].gzic003 = g_gzic_d1[l_j].gzic003_1
               LET g_gzic_d[l_cnt].gzic004 = "Y"
               LET g_gzic_d[l_cnt].gzic007 = g_gzic_d1[l_j].gzic007_1
               LET g_gzic_d[l_cnt].ggzid004 = g_qry_feld_t[l_i]
               LET g_gzic_d[l_cnt].gzic005 =l_i   #或者=l_i 
               LET g_gzic_d[l_cnt].gzic002 = g_gzic_d1[l_j].ngzid002_1
            END IF
           END FOR
        END IF
     END IF
     IF NOT cl_null(g_more.s2) THEN
        LET l_i = g_more.s2
        LET l_cnt = g_gzib_d.getLength() + 1
        LET g_gzib_d[l_cnt].gzib002 = g_qry_feld_t[l_i]
        LET g_gzib_d[l_cnt].gzib004 = g_more.t2
        LET g_gzib_d[l_cnt].gzib006 = "1"
        IF g_more.u2 = "Y" THEN
           FOR l_j = 1 TO g_gzic_d2_rec_b
             IF not cl_null(g_gzic_d2[l_j].ngzid004_2) THEN
               LET l_cnt = g_gzic_d.getLength() + 1
               LET g_gzic_d[l_cnt].gzid004 = g_gzic_d2[l_j].ngzid004_2
               LET g_gzic_d[l_cnt].gzic003 = g_gzic_d2[l_j].gzic003_2
               LET g_gzic_d[l_cnt].gzic004 = "Y"
               LET g_gzic_d[l_cnt].gzic007 = g_gzic_d2[l_j].gzic007_2
               LET g_gzic_d[l_cnt].ggzid004 = g_qry_feld_t[l_i]
               LET g_gzic_d[l_cnt].gzic005 =l_i   #或者=l_i 
               LET g_gzic_d[l_cnt].gzic002 = g_gzic_d2[l_j].ngzid002_2
             END IF
           END FOR
        END IF
     END IF
     IF NOT cl_null(g_more.s3) THEN
        LET l_i = g_more.s3
        LET l_cnt = g_gzib_d.getLength() + 1
        LET g_gzib_d[l_cnt].gzib002 = g_qry_feld_t[l_i]
        LET g_gzib_d[l_cnt].gzib004 = g_more.t3
        LET g_gzib_d[l_cnt].gzib006 = "1"
        IF g_more.u3 = "Y" THEN
           FOR l_j = 1 TO g_gzic_d3_rec_b
             IF not cl_null(g_gzic_d3[l_j].ngzid004_3) THEN
               LET l_cnt = g_gzic_d.getLength() + 1
               LET g_gzic_d[l_cnt].gzid004 = g_gzic_d3[l_j].ngzid004_3
               LET g_gzic_d[l_cnt].gzic003 = g_gzic_d3[l_j].gzic003_3
               LET g_gzic_d[l_cnt].gzic004 = "Y"
               LET g_gzic_d[l_cnt].gzic007 = g_gzic_d3[l_j].gzic007_3
               LET g_gzic_d[l_cnt].ggzid004 = g_qry_feld_t[l_i]
               LET g_gzic_d[l_cnt].gzic005 =l_i   #或者=l_i 
               LET g_gzic_d[l_cnt].gzic002 = g_gzic_d3[l_j].ngzid002_3
             END IF
           END FOR
        END IF
     END IF
 
     LET g_gzic_d_cnt =  g_gzic_d.getLength()

END FUNCTION

################################################################################
# Descriptions...: 动态建立进阶查询选项
# Memo...........:
# Usage..........: azzi310_01_advance_buildField(p_cmd,pn_vbox)
# Input parameter: p_cmd    V:浏览模式 o:其他模式
#                : pn_vbox  界面vbox节点
# Return code....: none
# Date & Author..: 2015/07/16 by chenjpa
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_01_advance_buildField(p_cmd,pn_vbox)
DEFINE p_cmd            LIKE type_t.chr1
    DEFINE pn_vbox          om.DomNode
    DEFINE ln_grid          om.DomNode,
           ln_formfield     om.DomNode,
           ln_checkbox      om.DomNode
    DEFINE l_str            STRING
 
    LET ln_grid = pn_vbox.createChild("Grid")
    LET ln_formfield = ln_grid.createChild("FormField")
    CALL ln_formfield.setAttribute("colName","more")
    CALL ln_formfield.setAttribute("name","formonly.more")
    CALL ln_formfield.setAttribute("tabIndex", GI_MAX_COLUMN_COUNT+1)
    CALL ln_formfield.setAttribute("notNull", 1)
    CALL ln_formfield.setAttribute("required", 1)
    LET ln_checkbox = ln_formfield.createChild("CheckBox")
    CALL ln_checkbox.setAttribute("valueChecked","Y")
    CALL ln_checkbox.setAttribute("valueUnchecked","N")
    LET l_str = cl_getmsg('azz-00915',g_lang)
    CALL ln_checkbox.setAttribute("text",l_str.trim())
    CALL ln_checkbox.setAttribute("comment",l_str.trim())
 
    IF (p_cmd="V" AND g_gzia004 <> 'Y') OR p_cmd = "F" THEN
       CALL ln_grid.setAttribute("hidden", 1)
    END IF
    CALL ui.Interface.refresh()
END FUNCTION

################################################################################
# Descriptions...: 建立连查画面-表头、单身、表尾
# Memo...........:
# Usage..........: azzi310_01_query_buildTable(pn_child)
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/07/16 by chenjpa
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_01_query_buildTable(pn_child)
 DEFINE pn_child              om.DomNode
    DEFINE ln_table              om.DomNode,
           ln_table_column       om.DomNode,
           ln_edit               om.DomNode
    DEFINE ln_grid               om.DomNode,
           ln_textedit           om.DomNode,
           ln_formfield          om.DomNode
    DEFINE li_i                  LIKE type_t.num10
    DEFINE ls_colname            STRING
    DEFINE l_rec_b               LIKE type_t.num10
    DEFINE ln_len                LIKE type_t.num5
    DEFINE l_height              LIKE type_t.num5
 
    #160825-00014#1 mod(s) #2016.09.07 恢复
    IF g_len > 150 THEN
       LET g_len = 150
    END IF
    LET ln_len = g_len+ (g_qry_feld_cnt*2)
   # LET g_len=149 #183 #2016.09.07 mark
    #LET ln_len=g_len   #2016.09.07 mark
    #160825-00014#1 mod(e)
    #建立表頭-TextEdit
    LET ln_grid = pn_child.createChild("Grid")
    LET ln_formfield = ln_grid.createChild("FormField")
    CALL ln_formfield.setAttribute("colName","text1")
    CALL ln_formfield.setAttribute("name","formonly.text1")
    CALL ln_formfield.setAttribute("tabIndex", 1)

    LET ln_textedit = ln_formfield.createChild("TextEdit")
    LET l_height = 5 
    CALL ln_textedit.setAttribute("gridHeight",l_height)
    CALL ln_textedit.setAttribute("width",ln_len)
    CALL ln_textedit.setAttribute("style","fixedFont")
    CALL ln_textedit.setAttribute("stretch","x")
    CALL ln_textedit.setAttribute("scrollBars","none")  #160825-00014#1 add
 
    LET ln_table = pn_child.createChild("Table")
    CALL ln_table.setAttribute("tabName", "s_table_data")
    CALL ln_table.setAttribute("name", "s_table_data") #160830-00018#1 add
    CALL ln_table.setAttribute("pageSize", l_rec_b)
    CALL ln_table.setAttribute("style", "fixedFont")
    CALL ln_table.setAttribute("unsortableColumns", 1)
 
    #160523-00002#2 mod(s)
   # FOR li_i = 1 TO g_qry_feld_cnt
   FOR li_i = 0 TO g_qry_feld_cnt
        LET ln_table_column = ln_table.createChild("TableColumn")
        LET ls_colname = "field", li_i USING "&&&"
        CALL ln_table_column.setAttribute("colName", ls_colname)
        CALL ln_table_column.setAttribute("name", "formonly." || ls_colname)
        CALL ln_table_column.setAttribute("text", ls_colname)
        CALL ln_table_column.setAttribute("noEntry", 1)
        CALL ln_table_column.setAttribute("hidden", 1)
        CALL ln_table_column.setAttribute("tabIndex", li_i+1)
#        IF g_qry_flag[li_i]='Y' THEN
#           LET ln_edit = ln_table_column.createChild("Label")
#           CALL ln_edit.setAttribute("style","textFormat_html")
#        ELSE
           LET ln_edit = ln_table_column.createChild("Edit")
        #END IF
        CALL ln_edit.setAttribute("width", GI_COLUMN_WIDTH)
    END FOR 
    FOR li_i=g_qry_feld_cnt+1 TO GI_MAX_COLUMN_COUNT
   # FOR li_i = 1 TO GI_MAX_COLUMN_COUNT
        LET ln_table_column = ln_table.createChild("TableColumn")
        LET ls_colname = "field", li_i USING "&&&"
        CALL ln_table_column.setAttribute("colName", ls_colname)
        CALL ln_table_column.setAttribute("name", "formonly." || ls_colname)
        CALL ln_table_column.setAttribute("text", ls_colname)
        CALL ln_table_column.setAttribute("noEntry", 1)
        CALL ln_table_column.setAttribute("hidden", 1)
        CALL ln_table_column.setAttribute("tabIndex", li_i+1)
        LET ln_edit = ln_table_column.createChild("Edit")
        CALL ln_edit.setAttribute("width",1)#160825-00014#1 mod GI_COLUMN_WIDTH->1
    END FOR
 #160523-00002#2 (e)
    #建立表尾-TextEdit
    LET ln_grid = pn_child.createChild("Grid")
    LET ln_formfield = ln_grid.createChild("FormField")
    CALL ln_formfield.setAttribute("colName","text2")
    CALL ln_formfield.setAttribute("name","formonly.text2")
    CALL ln_formfield.setAttribute("tabIndex", GI_MAX_COLUMN_COUNT+1)

    LET ln_textedit = ln_formfield.createChild("TextEdit")
    CALL ln_textedit.setAttribute("gridHeight",3)
    CALL ln_textedit.setAttribute("width",ln_len)
    CALL ln_textedit.setAttribute("style","fixedFont")
    CALL ln_textedit.setAttribute("stretch","x")
    CALL ln_textedit.setAttribute("scrollBars","none")  #160825-00014#1 add
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: azzi310_01_arg_replace(p_sql)
#                  RETURNING p_sql
# Input parameter: p_sql      待替换的sql语句
# Return code....: p_sql           已经替换好的sql
# Date & Author..: 2015/07/16 by chenjpa
# Modify.........: 
################################################################################
PUBLIC FUNCTION azzi310_01_arg_replace(p_gzia006)
  DEFINE p_gzia006      LIKE gzia_t.gzia006      #数据库内储存的SQL语句
   DEFINE l_gzia006_sb   base.StringBuffer        #替换SQL语句用
   DEFINE l_tmp_str   STRING
   DEFINE l_arg_value,l_arg STRING
   DEFINE l_i          SMALLINT

   LET l_gzia006_sb = base.StringBuffer.create()
   CALL l_gzia006_sb.append(p_gzia006)

   #另外怕使用者输入";"会影响SQL执行,因此也先行剔除
   CALL l_gzia006_sb.replace(";", "", 1)

   ### 将外部参数值 替换到 SQL语句 ###
  # FOR l_i=1 TO NUM_ARGS()-1  #从第二个参数开始算
    FOR l_i=1 TO 9
      # LET l_arg_value = ARG_VAL(l_i+1)
       LET l_arg_value = g_argv[l_i+1]
       LET l_arg = "arg",l_i USING '<<<<<'
       CALL l_gzia006_sb.replace(l_arg,l_arg_value,0)
   END FOR

   ### 将公用变数值 替换到 SQL语句 ###  
   #160901-00030#1 add(s)
   CALL l_gzia006_sb.replace("$:DEPT",g_dept, 0) 
   CALL l_gzia006_sb.replace("$:DLANG",g_dlang, 0) 
   CALL l_gzia006_sb.replace("$:ENT",g_enterprise, 0)  
   CALL l_gzia006_sb.replace("$:LEGAL",g_legal, 0) 
   CALL l_gzia006_sb.replace("$:SITE",g_site, 0) 
   CALL l_gzia006_sb.replace("$:USER",g_user, 0) 
   CALL l_gzia006_sb.replace("$:LANG",g_lang, 0) 
   #160901-00030#1 add(e)
   LET l_tmp_str = "'",g_dept,"'"  
   CALL l_gzia006_sb.replace(":DEPT",l_tmp_str, 0)

   LET l_tmp_str = "'",g_dlang,"'"
   CALL l_gzia006_sb.replace(":DLANG",l_tmp_str, 0)

   LET l_tmp_str = g_enterprise  
   CALL l_gzia006_sb.replace(":ENT",l_tmp_str, 0)

   LET l_tmp_str = "'",g_legal,"'"   
   CALL l_gzia006_sb.replace(":LEGAL",l_tmp_str, 0)

   LET l_tmp_str = "'",g_site,"'"   
   CALL l_gzia006_sb.replace(":SITE",l_tmp_str, 0)

   LET l_tmp_str =  "'",g_user,"'"    
   CALL l_gzia006_sb.replace(":USER",l_tmp_str, 0)

   LET l_tmp_str = "'",g_lang,"'"   
   CALL l_gzia006_sb.replace(":LANG",l_tmp_str, 0)

#LET l_tmp_str = "TO_DATE('",g_today,"','yyyy/mm/dd') "

   LET l_tmp_str = "'",g_today,"'"
   #161220-00028#1 add(s)
   CALL l_gzia006_sb.replace("'$:TODAY'",l_tmp_str, 0) #160901-00030#1 add
   CALL l_gzia006_sb.replace("':TODAY'",l_tmp_str, 0)
   #161220-00028#1 add(e)
    CALL l_gzia006_sb.replace("$:TODAY",l_tmp_str, 0) #160901-00030#1 add
   CALL l_gzia006_sb.replace(":TODAY",l_tmp_str, 0)
   
   RETURN l_gzia006_sb.toString()  

END FUNCTION

################################################################################
# Descriptions...: 文件转码
# Memo...........:
# Usage..........: azzi310_01_convert(p_name)
# Input parameter: p_name   文件名
# Return code....: none
# Date & Author..: 2015/07/16 
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_01_convert(p_name)
DEFINE p_name     STRING,    
          l_cmd      STRING

   
   IF os.Path.delete(p_name CLIPPED||".ts") THEN
   END IF


   LET tsconv_cmd = NULL
   IF ms_codeset.getIndexOf("BIG5", 1) OR
      ( ms_codeset.getIndexOf("GB2312", 1) OR ms_codeset.getIndexOf("GBK", 1) OR ms_codeset.getIndexOf("GB18030", 1) ) THEN
      IF ms_locale = "ZH_TW" AND g_lang = 'zh_CN' THEN
         LET tsconv_cmd = "big5_to_gb2312"
      END IF
      IF ms_locale = "ZH_CN" AND g_lang = 'zh_TW' THEN
         LET tsconv_cmd = "gb2312_to_big5"
      END IF

      LET lch_cmd = base.Channel.create()
      CALL lch_cmd.openPipe("uname -s", "r")
      WHILE lch_cmd.read(os_type)
      END WHILE
      CALL lch_cmd.close()
      LET os_type = os_type.toUpperCase()

      LET lch_cmd = base.Channel.create()
      CALL lch_cmd.openPipe("uname -s", "r")
      WHILE lch_cmd.read(os_type)
      END WHILE
      CALL lch_cmd.close()
      LET os_type = os_type.toUpperCase()
 
      IF cl_getenv_dvm_version() >= "2.02.06" THEN
         LET os_type = "DVM_BUILT_IN"
      END IF
  

      IF tsconv_cmd IS NOT NULL THEN
         CASE
             WHEN os_type MATCHES "AIX*"
                  LET tsconv_cmd=tsconv_cmd, ".ibm"
             WHEN os_type MATCHES "LINUX*"
                  LET tsconv_cmd=tsconv_cmd, ".lux"
             WHEN os_type MATCHES "HP-UX*"
                  LET tsconv_cmd=tsconv_cmd, ".hp"
             WHEN os_type MATCHES "SUNOS*"
                  LET tsconv_cmd=tsconv_cmd, ".sun"
         END CASE

         LET l_cmd = "cat ", p_name CLIPPED, "|", tsconv_cmd, ">", p_name CLIPPED, ".ts2 ", p_name CLIPPED," ",p_name CLIPPED, ".ts;mv ", p_name CLIPPED, ".ts2 ", p_name CLIPPED
         RUN l_cmd
         IF os.Path.separator() = "/" THEN        #Unix 环境
            LET l_cmd = "chmod 666 ",p_name CLIPPED,".ts 2>/dev/null"
         ELSE
            LET l_cmd = "attrib -r ",p_name CLIPPED,".ts  >nul 2>nul"  
         END IF
          
         RUN l_cmd                                                  
      END IF
   END IF  

END FUNCTION

################################################################################
# Descriptions...: 进行查询(QBE)、过滤条件输入
# Memo...........:
# Usage..........: azzi310_01_curs(p_cmd)
# Input parameter: p_cmd    F:过泸功能, V:查询画面(per),C:获取条件
# Return code....: none
# Date & Author..: 2015/07/16
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_01_curs(p_cmd)
DEFINE p_cmd            LIKE type_t.chr1   #F:过泸功能, V:查询画面(per),C:获取条件 
DEFINE buf              base.StringBuffer
DEFINE buf2             base.StringBuffer
DEFINE l_tok            base.StringTokenizer
DEFINE lw_w             ui.Window
DEFINE lnode_item       om.DomNode
DEFINE nl_date          om.NodeList
DEFINE l_i              LIKE type_t.num10
DEFINE cnt_date         LIKE type_t.num5
DEFINE l_status         LIKE type_t.num5
DEFINE l_p              LIKE type_t.num5
DEFINE l_cnt            LIKE type_t.num5
DEFINE l_date           LIKE type_t.dat
DEFINE l_date2          LIKE type_t.dat
DEFINE ls_colname       STRING
DEFINE l_name           STRING
DEFINE l_value          STRING
DEFINE l_more           STRING                
DEFINE l_symbol         STRING
DEFINE l_wc             STRING
DEFINE l_wc2            STRING                
DEFINE l_str            STRING               
DEFINE l_str2           STRING               
DEFINE l_arg_value      STRING
DEFINE l_arg            STRING
DEFINE l_start          LIKE type_t.num10        
DEFINE l_end            LIKE type_t.num10        

DEFINE l_argv          RECORD  #160523-00002#2 add 回传json
       argv1           STRING,
       argv2           STRING,
       argv3           STRING,
       argv4           STRING,
       argv5           STRING,
       argv6           STRING,
       argv7           STRING,
       argv8           STRING,
       argv9           STRING      
       END RECORD

DEFINE l_prog          LIKE gzia_t.gzia001  #170116-00004#1 add

    IF NOT (g_gzia002 = 'N' AND p_cmd = "V")THEN 
       IF g_flag=0 THEN
          CALL azzi310_01_curs_buildForm(p_cmd)
          LET g_flag=g_flag+1
       END IF
       CURRENT WINDOW IS w_azzi310_01_curs #160523-00002#2 add --回传json
       LET lw_w=ui.window.getcurrent()
       clear FORM 
   
       #CALL FGL_DIALOG_SETFIELDORDER(FALSE)
       DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         
       CONSTRUCT by name l_wc ON
       # CONSTRUCT l_wc ON
            field001, field002, field003, field004, field005, field006, field007,
             field008, field009, field010, field011, field012, field013, field014,
             field015, field016, field017, field018, field019, field020, field021,
             field022, field023, field024, field025, field026, field027, field028,
             field029, field030, field031, field032, field033, field034, field035,
             field036, field037, field038, field039, field040, field041, field042,
             field043, field044, field045, field046, field047, field048, field049,
             field050, field051, field052, field053, field054, field055, field056,
             field057, field058, field059, field060, field061, field062, field063,
             field064, field065, field066, field067, field068, field069, field070,
             field071, field072, field073, field074, field075, field076, field077,
             field078, field079, field080, field081, field082, field083, field084,
             field085, field086, field087, field088, field089, field090, field091,
             field092, field093, field094, field095, field096, field097, field098,           
             field099, field100, field101, field102, field103, field104, field105, 
             field106, field107, field108, field109, field110, field111, field112,
             field113, field114, field115, field116, field117, field118, field119,
             field120, field121, field122, field123, field124, field125, field126,
             field127, field128, field129, field130, field131, field132, field133,
             field134, field135, field136, field137, field138, field139, field140,
             field141, field142, field143, field144, field145, field146, field147,
             field148, field149, field150, more 
#        FROM
#             #field001, field002, field003, field004, field005, field006, field007,
#             field001, field002, pmdldocdt, pmdlcnfdt,field005, field006, field007,
#             field008, field009, field010, field011, field012, field013, field014,
#             field015, field016, field017, field018, field019, field020, field021,
#             field022, field023, field024, field025, field026, field027, field028,
#             field029, field030, field031, field032, field033, field034, field035,
#             field036, field037, field038, field039, field040, field041, field042,
#             field043, field044, field045, field046, field047, field048, field049,
#             field050, field051, field052, field053, field054, field055, field056,
#             field057, field058, field059, field060, field061, field062, field063,
#             field064, field065, field066, field067, field068, field069, field070,
#             field071, field072, field073, field074, field075, field076, field077,
#             field078, field079, field080, field081, field082, field083, field084,
#             field085, field086, field087, field088, field089, field090, field091,
#             field092, field093, field094, field095, field096, field097, field098,
#             field099, field100, field101, field102, field103, field104, field105, 
#             field106, field107, field108, field109, field110, field111, field112,
#             field113, field114, field115, field116, field117, field118, field119,
#             field120, field121, field122, field123, field124, field125, field126,
#             field127, field128, field129, field130, field131, field132, field133,
#             field134, field135, field136, field137, field138, field139, field140,
#             field141, field142, field143, field144, field145, field146, field147,
#             field148, field149, field150, more
           
            BEFORE CONSTRUCT
                CALL cl_show_fld_cont()
                CALL cl_set_act_visible("controlp",FALSE) 
                SELECT COUNT(*) INTO l_cnt  FROM gzid_t
                 WHERE gzid001 = g_query_prog 
                   AND gzid005 != 'N'            AND gzid008 = "Y"
   
                IF l_cnt > 0 THEN
                   CALL cl_set_act_visible("controlp",TRUE) 
                END IF
   
            AFTER FIELD 
             field001, field002, field003, field004, field005, field006, field007,
             field008, field009, field010, field011, field012, field013, field014,
             field015, field016, field017, field018, field019, field020, field021,
             field022, field023, field024, field025, field026, field027, field028,
             field029, field030, field031, field032, field033, field034, field035,
             field036, field037, field038, field039, field040, field041, field042,
             field043, field044, field045, field046, field047, field048, field049,
             field050, field051, field052, field053, field054, field055, field056,
             field057, field058, field059, field060, field061, field062, field063,
             field064, field065, field066, field067, field068, field069, field070,
             field071, field072, field073, field074, field075, field076, field077,
             field078, field079, field080, field081, field082, field083, field084,
             field085, field086, field087, field088, field089, field090, field091,
             field092, field093, field094, field095, field096, field097, field098,
             field099, field100, field101, field102, field103, field104, field105, 
             field106, field107, field108, field109, field110, field111, field112,
             field113, field114, field115, field116, field117, field118, field119,
             field120, field121, field122, field123, field124, field125, field126,
             field127, field128, field129, field130, field131, field132, field133,
             field134, field135, field136, field137, field138, field139, field140,
             field141, field142, field143, field144, field145, field146, field147,
             field148, field149, field150
            
             LET l_value = FGL_DIALOG_GETBUFFER()
             IF NOT cl_null(l_value) THEN
                LET l_name = FGL_DIALOG_GETFIELDNAME()
                LET lnode_item = lw_w.findNode("FormField",l_name)          
                LET nl_date = lnode_item.selectByTagName("DateEdit")
                LET cnt_date = nl_date.getLength()
                IF cnt_date > 0 THEN
                   #test add
#                  LET l_i=l_name.subString(6,l_name.getLength())
#                   IF g_field_seq[l_i].type="timestamp" THEN
#                      IF NOT cl_chk_date_symbol(l_value) THEN
#                         LET l_value = cl_add_date_extra_cond(l_value)
#                      END IF
#                      CALL FGL_DIALOG_SETBUFFER(l_value)
#                   ELSE
                  #test add                   
                      LET l_status = 0 
                      #LET l_value = azzi310_01_cut_spaces(l_value)
                      LET l_value = l_value.trim()                       
   
                      LET buf = base.StringBuffer.create()
                      CALL buf.append(l_value)
                      CALL buf.replace(" ","", 0)
                      LET l_value = buf.toString()
                      #判断日期格式是否正确
                     CASE 
                         WHEN l_value.getIndexOf(">=",1) > 0  
                              LET l_p = l_value.getIndexOf(">=",1)
                              LET l_symbol = ">="
                         WHEN l_value.getIndexOf("<=",1) > 0
                              LET l_p = l_value.getIndexOf("<=",1)
                              LET l_symbol = "<="
                         WHEN l_value.getIndexOf("<>",1) > 0
                              LET l_p = l_value.getIndexOf("<>",1)
                              LET l_symbol = "<>"
                         WHEN l_value.getIndexOf("!=",1) > 0
                              LET l_p = l_value.getIndexOf("!=",1)
                              LET l_symbol = "!="
                         WHEN l_value.getIndexOf(">",1) > 0
                              LET l_p = l_value.getIndexOf(">",1)
                              LET l_symbol = ">" 
                         WHEN l_value.getIndexOf("<",1) > 0
                              LET l_p = l_value.getIndexOf("<",1)
                              LET l_symbol = "<"
                         WHEN l_value.getIndexOf("=",1) > 0
                              LET l_p = l_value.getIndexOf("=",1)
                              LET l_symbol = "="
                         WHEN l_value.getIndexOf(":",1) > 0
                              LET l_p = l_value.getIndexOf(":",1)
                              LET l_symbol = ":"
                         WHEN l_value.getIndexOf("|",1) > 0
                              LET l_p = l_value.getIndexOf("|",1)
                              LET l_symbol = "|"
                         WHEN l_value.getIndexOf("..",1) > 0
                              LET l_p = l_value.getIndexOf("..",1)
                              LET l_symbol = ".."
                         OTHERWISE
                         #LET l_p = 0
                              LET l_p = 1                    
                              LET l_symbol = ""
                      END CASE
  
                      IF l_symbol = ":" OR l_symbol = "|" OR l_symbol = ".." THEN    
                         LET l_date = l_value.subString(1,l_p-1)
                         IF cl_null(l_date) THEN
                            LET l_status = 1
                         ELSE 
                             LET l_date2 = l_value.subString(l_p + l_symbol.getLength(),l_value.getLength())   
                             IF cl_null(l_date2) THEN
                                LET l_status = 1
                             ELSE
                                LET l_value = l_date,l_symbol ,l_date2
                             END IF
                         END IF
                      ELSE
                         LET l_date = l_value.subString(l_p+l_symbol.getLength(),l_value.getLength())   
                          IF cl_null(l_date) THEN
                             #当使用者输入单一个'='时代表要将所以日期字段 = NULL当成条件带入
                             IF l_value.trim() = "=" THEN
                                LET l_status = 0
                             ELSE
                                LET l_status = 1
                             END IF   
                          ELSE
                             LET l_value = l_symbol,l_date
                          END IF
                      END IF
                      IF l_status THEN 
                       	 LET g_errparam.code = '-1106'
                         LET g_errparam.extend =''
                         LET g_errparam.popup = FALSE
                         CALL cl_err()
                         NEXT FIELD CURRENT
                      ELSE
                         DISPLAY l_value
                         CALL FGL_DIALOG_SETBUFFER(l_value)
                      END IF
                      
                 # END IF #test add
                END IF
             END IF
   
            AFTER FIELD more
               LET l_more = FGL_DIALOG_GETBUFFER()
               IF l_more IS NULL THEN
                  LET l_more='N'
               END IF
                
            ON ACTION CONTROLP
              LET l_name = FGL_DIALOG_GETFIELDNAME()
              LET l_value = FGL_DIALOG_GETBUFFER()
              LET l_i = l_name.subString(6,l_name.getLength())
              IF (p_cmd = "V" AND (NOT cl_null(g_field_seq[l_i].qbe))) OR
                 (p_cmd = "F" AND (NOT cl_null(g_qry_qbe[l_i])))
                 OR (p_cmd = "C" AND (NOT cl_null(g_field_seq[l_i].qbe))) #160523-00002#2 add #回传json
              THEN
                 INITIALIZE g_qryparam.* TO NULL
                 LET g_qryparam.state = 'c'
                 LET g_qryparam.reqry = FALSE
                 LET g_frm_name = g_query_prog
                 IF p_cmd = "F" THEN
#                     LET g_qryparam_form =  g_qry_qbe[l_i]
                     LET g_qryparam.ordercons= g_qry_qbe[l_i]
                     LET g_fld_name = g_qry_feld_t[l_i]
                 ELSE
#                     LET g_qryparam_form =  g_field_seq[l_i].qbe
                     LET g_fld_name = g_field_seq[l_i].id
                     LET g_qryparam.ordercons= g_field_seq[l_i].qbe
                 END IF
                 &include "erp/azz/azzi310_qry.4gl"
                 CALL FGL_DIALOG_SETBUFFER(g_qryparam.return1)
                 NEXT FIELD CURRENT
              END IF

   
#            ON ACTION controlg       
#               CALL cl_cmdask()      
# 
#            ON ACTION refresh 
#             CLEAR FORM
#
#            ON ACTION exit 
#               LET INT_FLAG=1  
               
       END CONSTRUCT
       
       INPUT l_argv.* FROM arg001,arg002,arg003,arg004,arg005,arg006,arg007,arg008,arg009 ATTRIBUTE(WITHOUT DEFAULTS)
             
       END INPUT
               BEFORE DIALOG
         CALL cl_qbe_init()
          ON ACTION controlg       
               CALL cl_cmdask() 
               
            ON ACTION refresh 
             CLEAR FORM
             
            ON ACTION accept
              ACCEPT DIALOG
    #170116-00004#1  add(s)       
    ON ACTION personalwork   #職能作業 (我的最愛)(在toolbar button)
      LET g_chkparam.arg1 = g_query_prog
      IF cl_chk_exist("v_gzzz001") THEN
          LET l_prog=g_prog
          LET g_prog=g_query_prog
          CALL cl_user_favorite()
          LET g_prog=l_prog
      END IF
      
      
    #170116-00004#1  add(e)
        
      #放棄輸入
      ON ACTION cancel
         LET g_action_choice=""
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      #在dialog 右上角 (X)
      ON ACTION close 
         LET INT_FLAG = TRUE 
         EXIT DIALOG
    
      #toolbar 離開
      ON ACTION exit
         LET INT_FLAG = TRUE 
         EXIT DIALOG 
               
       END DIALOG
       
       CALL cl_set_act_visible("controlp",TRUE) 
       
       IF INT_FLAG THEN                              
          CLOSE WINDOW w_azzi310_01_curs        
          RETURN ''
       END IF
    END IF
    #160523-00002#2 mark(s)
#    IF p_cmd="V" THEN
#       #将传入的参数条件加入打印条件
#      LET l_str=azzi310_01_arg_replace(g_gzia006,1)     #160523-00002#2 add 第二个参数
#    END IF  
    #160523-00002#2 mark(e)
      IF cl_null(l_wc) THEN
         LET l_wc = " 1=1"
      END IF
    #DISPLAY "qbe wc:",l_wc  #test
    #将 field000 取代为 Field_ID
    IF l_wc <> " 1=1" THEN
      LET buf = base.StringBuffer.create()
      CALL buf.append(l_wc)
    
    #160523-00002#2  mark(s)
#      IF p_cmd = "F" OR g_gzia002 = "N" THEN         
#          LET l_cnt = g_qry_feld_cnt
#      ELSE
#          LET l_cnt = g_field_seq.getLength()
#      END IF
    #160523-00002#2  mark(e)
        #LET l_cnt = g_qry_feld_cnt  #160523-00002#2 add #161123-00013#1 mark
         LET l_cnt=g_field_seq.getLength() #161123-00013#1 add
         FOR l_i = 1 TO l_cnt
             LET ls_colname = "field", l_i USING "&&&"
           
             #mark test(s)
             #IF p_cmd = "F" THEN
             #   CALL buf.replace( ls_colname,g_qry_feld_t[l_i], 0)
             #ELSE
             #161123-00013#1 add(s)
             IF g_field_seq[l_i].type="timestamp" THEN
                LET l_name="to_char("||g_field_seq[l_i].id||",'yyyy/mm/dd')"
             ELSE 
                LET l_name=g_field_seq[l_i].id
             END IF
             CALL buf.replace( ls_colname,l_name, 0)
             #161123-00013#1 add(e)  
             #CALL buf.replace( ls_colname,g_field_seq[l_i].id, 0) #161123-00013#1 mark
            # END IF
            #mark test(e)
         END FOR
    
      CASE l_more 
        WHEN 'Y' 
           CALL buf.replace("more='Y'","1=1", 0)
        WHEN 'N' 
           CALL buf.replace("more='N'","1=1", 0)
      END CASE
    LET l_wc = buf.toString()
    LET g_wc_name=l_wc
    
       IF l_more = 'Y' THEN
          CALL azzi310_01_advance()                       
          IF INT_FLAG THEN                               
             CLOSE WINDOW azzi310_01_curs_w             
             RETURN ''
          END IF
       END IF
 
    ELSE 
   
          IF p_cmd <> "F" THEN
             LET g_wc_name = " 1=1"
          END IF
 
    END IF
 #160523-00002#2 add(s) --回传json
    IF p_cmd = "C" THEN
       LET obj = util.JSONObject.create()
       #IF l_wc <> " 1=1" THEN
          CALL obj.put("wc", l_wc)
       #END IF
       IF NOT cl_null(l_argv.argv1) THEN
          CALL obj.put(g_gzie[1].gzie003,l_argv.argv1) 
       END IF
       
       IF NOT cl_null(l_argv.argv2) THEN
          CALL obj.put(g_gzie[2].gzie003,l_argv.argv2) 
       END IF
       
       IF NOT cl_null(l_argv.argv3) THEN
          CALL obj.put(g_gzie[3].gzie003,l_argv.argv3) 
       END IF
       
       IF NOT cl_null(l_argv.argv4) THEN
          CALL obj.put(g_gzie[4].gzie003,l_argv.argv4) 
       END IF
       
       IF NOT cl_null(l_argv.argv5) THEN
          CALL obj.put(g_gzie[5].gzie003,l_argv.argv5) 
       END IF
       
       IF NOT cl_null(l_argv.argv6) THEN
          CALL obj.put(g_gzie[6].gzie003,l_argv.argv6) 
       END IF
       
       IF NOT cl_null(l_argv.argv7) THEN
          CALL obj.put(g_gzie[7].gzie003,l_argv.argv7) 
       END IF
       
       IF NOT cl_null(l_argv.argv8) THEN
          CALL obj.put(g_gzie[8].gzie003,l_argv.argv8) 
       END IF
       
       IF NOT cl_null(l_argv.argv9) THEN
          CALL obj.put(g_gzie[9].gzie003,l_argv.argv9) 
       END IF
            
       LET g_json_wc=obj.toString()
    END IF
    #160523-00002#2 add(e)
    
    #160523-00002#2 mark(s)
#    IF NOT (g_gzia002 = 'N' AND p_cmd = "V") THEN         
#      # CLOSE WINDOW azzi310_01_curs_w   
#      # CLOSE WINDOW w_azzi310_01_curs       
#    END IF
    #160523-00002#2 mark (e)
    RETURN l_wc

END FUNCTION

################################################################################
# Descriptions...: 动态建立查询(QBE)、过滤窗口画面
# Memo...........:
# Usage..........: azzi310_01_curs_buildForm(p_cmd)
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/07/16
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_01_curs_buildForm(p_cmd)
DEFINE p_cmd        LIKE type_t.chr1
    DEFINE lwin_curr       ui.Window
    DEFINE lfrm_curr         ui.Form
    DEFINE ln_win       om.DomNode,  
           ln_form         om.DomNode, 
           ln_group        om.DomNode,
           ln_vbox         om.DomNode,
           ln_hbox         om.DomNode
    DEFINE l_gzze003       LIKE gzze_t.gzze003
    DEFINE l_gzzd005      LIKE gzzd_t.gzzd005
    DEFINE ls_msg       STRING                            
    DEFINE ls_tmp       STRING                            
    DEFINE ls_wintitle      STRING
    DEFINE ls_path      STRING
    DEFINE li_pos          LIKE type_t.num5
    DEFINE ls_gzze0031     LIKE gzze_t.gzze003
    DEFINE ls_gzze0032     LIKE gzze_t.gzze003
    DEFINE lc_gzxe003      LIKE gzxe_t.gzxe003
    DEFINE lc_ooefl003     LIKE ooefl_t.ooefl003 
    DEFINE lc_ooef018       LIKE ooef_t.ooef018 
    DEFINE ls_gzoul003      LIKE gzoul_t.gzoul003  #企业编号说明
 
    OPEN WINDOW w_azzi310_01_curs WITH FORM cl_ap_formpath("azz","azzi310_01_s02") 
    CALL cl_load_style_list(NULL)

   #浏览页签数据初始化
     #CALL cl_ui_init()
    LET lwin_curr = ui.Window.getCurrent()
    LET ln_win = lwin_curr.getNode()
 
    LET lfrm_curr = lwin_curr.getForm()
    LET ls_path = os.Path.join(os.Path.join(FGL_GETENV("ERP"),"cfg"),"4tb")
    LET ls_path = os.Path.join(ls_path,"toolbar_azzi310_01.4tb")
    CALL lfrm_curr.loadToolBar(ls_path)
    IF p_cmd = 'F' THEN
        SELECT gzze003 INTO l_gzze003 FROM gzze_t   
           WHERE gzze001='azz-00794' AND gzze002=g_lang
 
       LET l_gzze003 = l_gzze003 CLIPPED," ",g_gzial003 CLIPPED
       LET ls_wintitle = l_gzze003 CLIPPED
    ELSE
   #客制标示
       SELECT COUNT(*) INTO li_pos FROM gzia_t
        WHERE gzia001 = g_code
          AND gzia003 = "c"
       IF li_pos > 0 THEN
          LET ls_wintitle = g_gzial003 CLIPPED,"(",g_query_prog CLIPPED,")*",5 SPACE
       ELSE
          LET ls_wintitle = g_gzial003 CLIPPED,"(",g_query_prog CLIPPED,")",6 SPACE
       END IF
    
       #显示作业区域:企业编号
       SELECT gzoul003 INTO ls_gzoul003 FROM gzoul_t
        WHERE gzoul001 = g_enterprise AND gzoul002 = g_lang
       IF cl_null(ls_gzoul003) THEN
          LET ls_gzoul003 = cl_getmsg("sui-00004",g_lang)
       END IF
       LET ls_wintitle = ls_wintitle,"[",ls_gzoul003,":",
                         FGL_GETENV("ZONE"),",",g_enterprise USING "<<<<<","]"
    
    
       #选择 营业据点名称(lc_ooefl003)
       LET lc_ooefl003 = cl_get_deptname(g_site)
    
       #显示 营运据点
       LET ls_wintitle = ls_wintitle,cl_getmsg("sui-00001",g_lang),":",lc_ooefl003 CLIPPED,"(",g_site CLIPPED,")"


                  
    END IF
    CALL lwin_curr.setText(ls_wintitle)  
   # CALL ln_win.setAttribute("text", ls_msg CLIPPED)        #窗体标题
    CALL ui.Interface.setText(ls_msg CLIPPED)          
 
    LET ln_form = lfrm_curr.getNode()
    #CALL ln_form.setAttribute("name", "azzi310_01_s02")
    LET ln_vbox  = ln_form.createChild("VBox")
    LET ln_group = ln_vbox.createChild("Group")

    SELECT gzzd005 INTO l_gzzd005 FROM gzzd_t 
       WHERE gzzd001='azzi310_01_s02' AND gzzd003 = 'lbl_wc' AND gzzd002 = g_lang
 
    LET l_gzzd005 = "QBE",l_gzzd005 CLIPPED
    CALL ln_group.setAttribute("text", l_gzzd005 CLIPPED)
    LET ln_hbox  = ln_group.createChild("HBox")
 
    #动态建立字段
    CALL azzi310_01_query_buildField(p_cmd,ln_hbox) 
    #160523-00002#2 add(s)回传json    
    #动态建立参数字段
     CALL azzi310_01_arg_buildField(p_cmd,ln_vbox) 
    #160523-00002#2 add(e)回传json
    #建立进阶查询选项
    CALL azzi310_01_advance_buildField(p_cmd,ln_vbox)

END FUNCTION

################################################################################
# Descriptions...: 动态建立查询(QBE)、过滤画面字段
# Memo...........:
# Usage..........: azzi310_01_query_buildField(p_cmd,pn_hbox)
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/07/16 
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_01_query_buildField(p_cmd,pn_hbox)
DEFINE p_cmd            LIKE type_t.chr1
    DEFINE pn_hbox          om.DomNode
    DEFINE lw_w             ui.Window
    DEFINE ln_w             om.DomNode  
    DEFINE ln_grid          om.DomNode,
           ln_FormField     om.DomNode,
           ln_Field_Edit    om.DomNode,
           ln_label         om.DomNode
    DEFINE ls_grid_items    om.NodeList,
           ls_label_items   om.NodeList,
           ls_field_items   om.NodeList
    DEFINE l_i              LIKE type_t.num10   
    DEFINE l_j              LIKE type_t.num10  
    DEFINE l_k              LIKE type_t.num10     
    DEFINE l_posx           LIKE type_t.num10
    DEFINE l_posx2          LIKE type_t.num10
    DEFINE l_posy           LIKE type_t.num10
    DEFINE l_seq_cnt        LIKE type_t.num10
    DEFINE ls_colname       STRING
    DEFINE l_sql            STRING
    DEFINE l_gzid004          LIKE gzid_t.gzid004
    DEFINE l_gzid003          LIKE gzid_t.gzid003
    DEFINE l_gzid007          LIKE gzid_t.gzid007
    DEFINE l_gzid009          LIKE gzid_t.gzid009
    DEFINE l_per_field_len  DYNAMIC ARRAY OF LIKE gzid_t.gzid006  
# test mod(s)
#    IF p_cmd = 'F' THEN
#      LET l_seq_cnt = g_qry_feld_cnt
#       FOR l_i = 1 TO l_seq_cnt
#           
#           LET l_gzid004 = g_qry_feld_t[l_i] CLIPPED
#           LET l_gzid003 = g_qry_table[l_i] CLIPPED
#           SELECT unique gzid009,gzid006 INTO g_qry_qbe[l_i],g_qry_length[l_i]   
#             FROM gzid_t 
#            WHERE gzid001 = g_query_prog AND gzid003=l_gzid003 AND gzid004 = l_gzid004 
#       END FOR
#   ELSE
       LET l_seq_cnt = g_field_seq.getLength()
#    END IF
# test mod(e)

  FOR l_i = 1 TO GI_MAX_COLUMN_COUNT  
#  FOR l_i=1 TO l_seq_cnt
        IF l_i MOD 15 = 1 THEN
           LET l_posx = 1
           LET l_posx2 = 0
           LET ln_grid = pn_hbox.createChild("Grid")
           CALL ln_grid.setAttribute("hidden", 1)
           IF l_i > l_seq_cnt THEN
               LET l_posx2 = l_posx + 10
           ELSE
               FOR l_j = l_i TO l_i+14
# test mod(s)               
#                   IF p_cmd = "F" THEN
#                      LET l_posx = FGL_WIDTH(g_qry_feld[l_j] CLIPPED) + 2
#                   ELSE
                      LET l_posx = FGL_WIDTH(g_field_seq[l_j].name CLIPPED) + 2
#                   END IF
# test mod(e)
                   IF l_posx2 < l_posx THEN
                      LET l_posx2 = l_posx 
                   END IF
               END FOR
           END IF
        END IF
        LET l_posx = 1
        LET ls_colname = "field", l_i USING "&&&"
        LET ln_label = ln_grid.createChild("Label")
        # test mod(s)
#        IF p_cmd = "F" THEN
#           CALL ln_label.setAttribute("text",g_qry_feld[l_i] CLIPPED)
#           CALL ln_label.setAttribute("gridWidth", FGL_WIDTH(g_qry_feld[l_i] CLIPPED))
#        ELSE
           CALL ln_label.setAttribute("text",g_field_seq[l_i].name CLIPPED)
           CALL ln_label.setAttribute("gridWidth", FGL_WIDTH(g_field_seq[l_i].name CLIPPED))
#        END IF
        # test mod(e)
        CALL ln_label.setAttribute("hidden", 1)
        CALL ln_label.setAttribute("posX", l_posx)
        LET l_posy = l_i MOD 15 - 1
        IF l_posy = -1 THEN LET l_posy = 14 END IF
        CALL ln_label.setAttribute("posY", l_posy)
       #CALL ln_label.setAttribute("sizePolicy", "dynamic")
        LET ln_formfield = ln_grid.createChild("FormField")
        CALL ln_formfield.setAttribute("colName",ls_colname)
        CALL ln_formfield.setAttribute("name",ls_colname)
       CALL ln_formfield.setAttribute("hidden", 1)
        CALL ln_formfield.setAttribute("tabIndex", l_i)
        IF (NOT cl_null(g_field_seq[l_i].qbe) AND (p_cmd="V" OR p_cmd="C")) #160523-00002#2 add --回传json
          # OR (NOT cl_null(g_qry_qbe[l_i]) AND p_cmd="F")  #mark test
        THEN
             LET ln_field_edit = ln_formfield.createChild("ButtonEdit")
             CALL ln_field_edit.setAttribute("image", "16/openwindow.png")
             CALL ln_field_edit.setAttribute("action", "controlp")
        ELSE
             #161123-00013#1 mod add timestamp判断
             IF ((g_field_seq[l_i].type = "date" OR g_field_seq[l_i].type = "timestamp") AND (p_cmd="V" OR p_cmd="C")) #160523-00002#2 add --回传json
             # OR (g_qry_feld_type[l_i] = "date" AND p_cmd="F") #mark test
             #   OR 
             THEN
                 LET ln_field_edit = ln_formfield.createChild("DateEdit")
                 #test(s)
#                 LET ls_colname="pmdl_t."||g_field_seq[l_i].id
#                 CALL ln_formfield.setAttribute("name",ls_colname)
#                 CALL ln_formfield.setAttribute("colName",g_field_seq[l_i].id)
                 #test(e)
             ELSE
                 LET ln_field_edit = ln_formfield.createChild("Edit")
             END IF
        END IF
        IF p_cmd ="F" THEN
     
          #CALL ln_field_edit.setAttribute("gridWidth", g_qry_length[l_i])
          #CALL ln_field_edit.setAttribute("width",g_qry_length[l_i])
#           IF cl_null(l_per_field_len[l_i]) THEN
#              LET l_per_field_len[l_i] = g_qry_length[l_i]
#           END IF
#           CALL ln_field_edit.setAttribute("gridWidth", l_per_field_len[l_i])
#           CALL ln_field_edit.setAttribute("width",l_per_field_len[l_i])
             CALL ln_field_edit.setAttribute("gridWidth", g_qry_length[l_i])
           CALL ln_field_edit.setAttribute("width",g_qry_length[l_i])
       
        ELSE
           CALL ln_field_edit.setAttribute("gridWidth", g_field_seq[l_i].len)
           CALL ln_field_edit.setAttribute("width",g_field_seq[l_i].len)
        END IF
        CALL ln_field_edit.setAttribute("posX", l_posx2)
        CALL ln_field_edit.setAttribute("posY", l_posy)
    END FOR
 
    CALL ui.Interface.refresh()
 
    LET lw_w=ui.window.getcurrent()
    LET ln_w = lw_w.getNode()
    LET ls_grid_items =ln_w.selectByTagName("Grid")
    LET ls_label_items=ln_w.selectByTagName("Label")
    LET ls_field_items=ln_w.selectByTagName("FormField")
 
    FOR l_i = 1 TO l_seq_cnt
        IF l_i MOD 15 = 1 THEN
           LET l_j = l_i / 15
           LET ln_grid = ls_grid_items.item(l_j+3)
           CALL ln_grid.setAttribute("hidden", 0)
        END IF
#161121-00024#1 mod(s)
#         IF (g_qry_show[l_i]='N' AND p_cmd="F" ) OR
#            (p_cmd="V" OR p_cmd="C")                #160523-00002#2 mod    
#        THEN
           LET l_k=l_i+6
           LET ln_label = ls_label_items.item(l_k)
           CALL ln_label.setAttribute("hidden", 0)
           LET l_k=l_i+2
           LET ln_formfield = ls_field_items.item(l_k)
           CALL ln_formfield.setAttribute("hidden", 0)
#        END IF 
#161121-00024#1 mod(e)
    END FOR
    CALL ui.Interface.refresh()
    
END FUNCTION

################################################################################
# Descriptions...: 进阶画面之字段显示否设定 page
# Memo...........:
# Usage..........: azzi310_01_dis()
# Input parameter: none
# Return code....: none
# Date & Author..: 2015/07/16 by 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_01_dis()
DEFINE  l_allow_insert  LIKE type_t.num5    
DEFINE  l_allow_delete  LIKE type_t.num5    
DEFINE  l_w_ac          LIKE type_t.num5
DEFINE  l_dis_gzid_t     RECORD         #设定显示/隐藏数据(备份)  
                          gzid002   LIKE gzid_t.gzid002,
                          gzid005   LIKE gzid_t.gzid005, 
                          gzid004   LIKE gzid_t.gzid004,       
                          gzidl004   LIKE gzidl_t.gzidl004       
                        END RECORD
 
    LET l_allow_insert = FALSE   #cl_detail_input_auth("insert")
    LET l_allow_delete = FALSE   #cl_detail_input_auth("delete")
 
    LET l_w_ac = 1
    INPUT ARRAY g_dis_gzid WITHOUT DEFAULTS FROM s_detail1.*
              ATTRIBUTE(COUNT= g_qry_feld_cnt,MAXCOUNT=g_max_rec,UNBUFFERED,
                        INSERT ROW=l_allow_insert,DELETE ROW=l_allow_delete,APPEND ROW=l_allow_insert)
      BEFORE ROW
         LET l_w_ac = ARR_CURR() 
         LET l_dis_gzid_t.* = g_dis_gzid[l_w_ac].*  
 
      AFTER ROW
         LET l_w_ac = ARR_CURR()
         IF INT_FLAG THEN
            LET INT_FLAG = 0
            LET g_dis_gzid[l_w_ac].* = l_dis_gzid_t.*
            LET g_action_choice="exit"
            EXIT INPUT
         END IF
 
      ON ACTION page_option 
         LET g_action_choice = "page_option"
         ACCEPT INPUT
 
      ON ACTION page_sum1
         LET g_action_choice = "page_sum1"
         ACCEPT INPUT
        
      ON ACTION page_sum2
         LET g_action_choice = "page_sum2"
         ACCEPT INPUT
        
      ON ACTION page_sum3
         LET g_action_choice = "page_sum3"
         ACCEPT INPUT
        
      ON ACTION CONTROLR
         CALL cl_show_req_fields()
 
      ON ACTION CONTROLF
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang)  
 
      ON ACTION accept                        
         LET g_action_choice="exit"
         ACCEPT INPUT
 
      ON ACTION exit                              
         LET g_action_choice="exit"
         EXIT INPUT
 
      ON ACTION cancel
         LET INT_FLAG=FALSE         
         LET g_action_choice="exit"
         EXIT INPUT
 
      ON IDLE g_idle_seconds
        CALL cl_on_idle()
        CONTINUE INPUT
 
      ON ACTION controlg
         CALL cl_cmdask()
  
   END INPUT   

END FUNCTION

################################################################################
# Descriptions...: 控制页次按钮是否关闭
# Memo...........:
# Usage..........: azzi310_01_disableAction(pd_dialog)
#                   
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/07/16 by 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_01_disableAction(pd_dialog)
   DEFINE pd_dialog ui.Dialog
 
    IF g_curr_page = 1 THEN
       CALL pd_dialog.setActionActive("first_page", FALSE)
       CALL pd_dialog.setActionActive("prev_page", FALSE)
    END IF
 
    IF g_curr_page = g_total_page THEN
       CALL pd_dialog.setActionActive("last_page", FALSE)
       CALL pd_dialog.setActionActive("next_page", FALSE)
    END IF 

END FUNCTION

################################################################################
# Descriptions...: 产生 Excel 檔
# Memo...........:
# Usage..........: azzi310_01_excel(p_name,p_i)
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/07/16 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_01_excel(p_name,p_i)
DEFINE p_name          STRING
DEFINE p_i             LIKE type_t.num5
#DEFINE l_str           STRING
#DEFINE l_contents      STRING          
#DEFINE l_value         STRING
#DEFINE l_dash          STRING
#DEFINE l_channel       base.Channel
#DEFINE l_i             LIKE type_t.num5
#DEFINE l_j             LIKE type_t.num10     
#DEFINE l_k             LIKE type_t.num5
#DEFINE l_cnt           LIKE type_t.num5
#DEFINE l_tok           base.StringTokenizer
#DEFINE l_value_len     LIKE type_t.num5,
#       l_dec           LIKE type_t.num5,
#       l_dec_point     LIKE type_t.num5
#DEFINE l_gzid010         DYNAMIC ARRAY OF LIKE gzid_t.gzid010         
#DEFINE l_sql           STRING    
#
#   LET l_channel = base.Channel.create()
#   CALL l_channel.openFile(p_name,"a" )
#   CALL l_channel.setDelimiter("")
# 
#   IF p_i = 1 THEN
#      LET l_str = ""
#      CALL azzi310_01_excel_column() RETURNING l_str    
#   ELSE
#      LET l_str ="<body><div align=center>",         
#                #"<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0 STYLE=\"font-size: 12pt\" >"
#                 "<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0 >"
#   END IF
#   CALL l_channel.write(l_str)
# 
#   #PageHeader
#   LET l_tok = base.StringTokenizer.createExt(g_header_str,"\n","",TRUE)
#   WHILE l_tok.hasMoreTokens()
#         LET l_value=l_tok.nextToken()
#         LET l_str = "<TR height=22><TD colspan=",g_show_cnt," >",azzi310_01_add_span(l_value),"</TD></TR>"   
#         CALL l_channel.write(l_str)
#   END WHILE
#  
#   #Body
#   LET l_str = "<TR height=22>"        
#   FOR l_i = 1 TO g_qry_feld_cnt
#       IF g_qry_show[l_i] = "Y" THEN
#          LET l_contents = g_qry_feld[l_i] CLIPPED       
#          LET l_cnt = FGL_WIDTH(g_qry_feld[l_i]) - g_qry_length[l_i]
#          LET l_cnt = g_qry_length[l_i] - FGL_WIDTH(g_qry_feld[l_i]) + 1
#          FOR l_k = 1 TO l_cnt
#              LET l_contents = l_contents,"&nbsp;"       
#          END FOR
#          LET l_str = l_str,"<TD>",azzi310_01_add_span(l_contents),"</TD>"      
#       END IF
#   END FOR
#   LET l_str = l_str CLIPPED,"</TR>"
#   CALL l_channel.write(l_str)
# 
# 
#   LET l_sql = "SELECT gzid010 FROM gzid_t ", 
#               "   WHERE gzid001 = '", g_query_prog, "' ORDER BY gzid002"
#   PREPARE azzi310_01_excel_gzid010_pre FROM l_sql           #预备一下
#   DECLARE azzi310_01_excel_gzid010_curs CURSOR FOR azzi310_01_excel_gzid010_pre
#   LET l_i = 1
#   FOREACH azzi310_01_excel_gzid010_curs INTO l_gzid010[l_i]
#        LET l_i = l_i + 1
#   END FOREACH
#   CALL l_gzid010.deleteElement(l_i)
#  
# 
#   FOR l_j = 1 TO ga_page_data.getLength()
#       LET ga_page_data_t.* = ga_page_data[l_j].*
#       LET l_str = "<TR height=22>"                       
#       FOR l_i = 1 TO g_qry_feld_cnt
#           IF g_qry_show[l_i] = "Y" THEN
#               LET l_value = azzi310_01_getvalue(l_i)
#               IF g_qry_feld_type[l_i] = "varchar2" OR g_qry_feld_type[l_i] = "char" 
#               OR g_qry_feld_type[l_i] = "date" 
#               THEN
#                  LET l_str = l_str,"<TD class=xl24>",azzi310_01_add_span(l_value)
#               ELSE
#                  LET l_dec_point = l_value.getIndexOf(".",1)
#                  IF l_dec_point > 0 THEN
#                     LET l_dec = l_value.getLength() - l_dec_point
#                  
#                     IF l_dec >= 10 THEN
#                      
#                         IF l_gzid010[l_i]='N201' OR l_gzid010[l_i]='N202' OR l_gzid010[l_i]='N204' OR l_gzid010[l_i]='N205' THEN
#                           LET l_str = l_str,"<TD class=xl40>",l_value
#                        ELSE
#                           LET l_str = l_str,"<TD class=xl60>",l_value
#                        END IF
#                     ELSE
#                        
#                        IF l_gzid010[l_i]='N201' OR l_gzid010[l_i]='N202' OR l_gzid010[l_i]='N204' OR l_gzid010[l_i]='N205' THEN 
#                           LET l_str = l_str,"<TD class=xl3",l_dec USING '<<<<<<<<<<',">",l_value
#                        ELSE
#                           LET l_str = l_str,"<TD class=xl5",l_dec USING '<<<<<<<<<<',">",l_value
#                        END IF
#                     END IF
#                   
#                  ELSE 
#            
#                     IF l_gzid010[l_i]='N201' OR l_gzid010[l_i]='N202' OR l_gzid010[l_i]='N204' OR l_gzid010[l_i]='N205' THEN 
#                        LET l_str = l_str,"<TD class=xl30>",l_value
#                     ELSE
#                        LET l_str = l_str,"<TD class=xl50>",l_value
#                     END IF                     
#              
#                  END IF
#               END IF
#               LET l_cnt = g_qry_length[l_i] - FGL_WIDTH(l_value) + 1
#    
#               LET l_str = l_str, l_cnt SPACES
#         
#               LET l_str = l_str.trimRight(),"</TD>"      
#           END IF
#       END FOR
#        LET l_str = l_str ,"</TR>"
#       CALL l_channel.write(l_str)
#   END FOR
#
# 
#   LET l_str="</TABLE></div></body>"
#   IF p_i = g_total_page THEN
#       LET l_str = l_str, "</html>"
#   END IF
#  
#
#   CALL l_channel.write(l_str)
#   CALL l_channel.close()
 

END FUNCTION

################################################################################
# Descriptions...: 取得显示的字段 value
# Memo...........:
# Usage..........: azzi310_01_getvalue(p_n)
#                  RETURNING l_str
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/07/16 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_01_getvalue(p_n)
DEFINE p_n       LIKE type_t.num5
#DEFINE l_str     LIKE dzeb_t.dzeb003  #151214-00004#3 mod
DEFINE l_str     String                #151214-00004#3 add  汇出excel字符串被截断
 
      CASE p_n 
       WHEN   1  LET l_str=ga_page_data_t.field001
       WHEN   2  LET l_str=ga_page_data_t.field002
       WHEN   3  LET l_str=ga_page_data_t.field003
       WHEN   4  LET l_str=ga_page_data_t.field004
       WHEN   5  LET l_str=ga_page_data_t.field005
       WHEN   6  LET l_str=ga_page_data_t.field006
       WHEN   7  LET l_str=ga_page_data_t.field007
       WHEN   8  LET l_str=ga_page_data_t.field008
       WHEN   9  LET l_str=ga_page_data_t.field009
       WHEN  10  LET l_str=ga_page_data_t.field010
       WHEN  11  LET l_str=ga_page_data_t.field011
       WHEN  12  LET l_str=ga_page_data_t.field012
       WHEN  13  LET l_str=ga_page_data_t.field013
       WHEN  14  LET l_str=ga_page_data_t.field014
       WHEN  15  LET l_str=ga_page_data_t.field015
       WHEN  16  LET l_str=ga_page_data_t.field016
       WHEN  17  LET l_str=ga_page_data_t.field017
       WHEN  18  LET l_str=ga_page_data_t.field018
       WHEN  19  LET l_str=ga_page_data_t.field019
       WHEN  20  LET l_str=ga_page_data_t.field020
       WHEN  21  LET l_str=ga_page_data_t.field021
       WHEN  22  LET l_str=ga_page_data_t.field022
       WHEN  23  LET l_str=ga_page_data_t.field023
       WHEN  24  LET l_str=ga_page_data_t.field024
       WHEN  25  LET l_str=ga_page_data_t.field025
       WHEN  26  LET l_str=ga_page_data_t.field026
       WHEN  27  LET l_str=ga_page_data_t.field027
       WHEN  28  LET l_str=ga_page_data_t.field028
       WHEN  29  LET l_str=ga_page_data_t.field029
       WHEN  30  LET l_str=ga_page_data_t.field030
       WHEN  31  LET l_str=ga_page_data_t.field031
       WHEN  32  LET l_str=ga_page_data_t.field032
       WHEN  33  LET l_str=ga_page_data_t.field033
       WHEN  34  LET l_str=ga_page_data_t.field034
       WHEN  35  LET l_str=ga_page_data_t.field035
       WHEN  36  LET l_str=ga_page_data_t.field036
       WHEN  37  LET l_str=ga_page_data_t.field037
       WHEN  38  LET l_str=ga_page_data_t.field038
       WHEN  39  LET l_str=ga_page_data_t.field039
       WHEN  40  LET l_str=ga_page_data_t.field040
       WHEN  41  LET l_str=ga_page_data_t.field041
       WHEN  42  LET l_str=ga_page_data_t.field042
       WHEN  43  LET l_str=ga_page_data_t.field043
       WHEN  44  LET l_str=ga_page_data_t.field044
       WHEN  45  LET l_str=ga_page_data_t.field045
       WHEN  46  LET l_str=ga_page_data_t.field046
       WHEN  47  LET l_str=ga_page_data_t.field047
       WHEN  48  LET l_str=ga_page_data_t.field048
       WHEN  49  LET l_str=ga_page_data_t.field049
       WHEN  50  LET l_str=ga_page_data_t.field050
       WHEN  51  LET l_str=ga_page_data_t.field051
       WHEN  52  LET l_str=ga_page_data_t.field052
       WHEN  53  LET l_str=ga_page_data_t.field053
       WHEN  54  LET l_str=ga_page_data_t.field054
       WHEN  55  LET l_str=ga_page_data_t.field055
       WHEN  56  LET l_str=ga_page_data_t.field056
       WHEN  57  LET l_str=ga_page_data_t.field057
       WHEN  58  LET l_str=ga_page_data_t.field058
       WHEN  59  LET l_str=ga_page_data_t.field059
       WHEN  60  LET l_str=ga_page_data_t.field060
       WHEN  61  LET l_str=ga_page_data_t.field061
       WHEN  62  LET l_str=ga_page_data_t.field062
       WHEN  63  LET l_str=ga_page_data_t.field063
       WHEN  64  LET l_str=ga_page_data_t.field064
       WHEN  65  LET l_str=ga_page_data_t.field065
       WHEN  66  LET l_str=ga_page_data_t.field066
       WHEN  67  LET l_str=ga_page_data_t.field067
       WHEN  68  LET l_str=ga_page_data_t.field068
       WHEN  69  LET l_str=ga_page_data_t.field069
       WHEN  70  LET l_str=ga_page_data_t.field070
       WHEN  71  LET l_str=ga_page_data_t.field071
       WHEN  72  LET l_str=ga_page_data_t.field072
       WHEN  73  LET l_str=ga_page_data_t.field073
       WHEN  74  LET l_str=ga_page_data_t.field074
       WHEN  75  LET l_str=ga_page_data_t.field075
       WHEN  76  LET l_str=ga_page_data_t.field076
       WHEN  77  LET l_str=ga_page_data_t.field077
       WHEN  78  LET l_str=ga_page_data_t.field078
       WHEN  79  LET l_str=ga_page_data_t.field079
       WHEN  80  LET l_str=ga_page_data_t.field080
       WHEN  81  LET l_str=ga_page_data_t.field081
       WHEN  82  LET l_str=ga_page_data_t.field082
       WHEN  83  LET l_str=ga_page_data_t.field083
       WHEN  84  LET l_str=ga_page_data_t.field084
       WHEN  85  LET l_str=ga_page_data_t.field085
       WHEN  86  LET l_str=ga_page_data_t.field086
       WHEN  87  LET l_str=ga_page_data_t.field087
       WHEN  88  LET l_str=ga_page_data_t.field088
       WHEN  89  LET l_str=ga_page_data_t.field089
       WHEN  90  LET l_str=ga_page_data_t.field090
       WHEN  91  LET l_str=ga_page_data_t.field091
       WHEN  92  LET l_str=ga_page_data_t.field092
       WHEN  93  LET l_str=ga_page_data_t.field093
       WHEN  94  LET l_str=ga_page_data_t.field094
       WHEN  95  LET l_str=ga_page_data_t.field095
       WHEN  96  LET l_str=ga_page_data_t.field096
       WHEN  97  LET l_str=ga_page_data_t.field097
       WHEN  98  LET l_str=ga_page_data_t.field098
       WHEN  99  LET l_str=ga_page_data_t.field099
       WHEN 100  LET l_str=ga_page_data_t.field100
       WHEN 101  LET l_str=ga_page_data_t.field101
       WHEN 102  LET l_str=ga_page_data_t.field102
       WHEN 103  LET l_str=ga_page_data_t.field103
       WHEN 104  LET l_str=ga_page_data_t.field104
       WHEN 105  LET l_str=ga_page_data_t.field105
       WHEN 106  LET l_str=ga_page_data_t.field106
       WHEN 107  LET l_str=ga_page_data_t.field107
       WHEN 108  LET l_str=ga_page_data_t.field108
       WHEN 109  LET l_str=ga_page_data_t.field109
       WHEN 110  LET l_str=ga_page_data_t.field110
       WHEN 111  LET l_str=ga_page_data_t.field111
       WHEN 112  LET l_str=ga_page_data_t.field112
       WHEN 113  LET l_str=ga_page_data_t.field113
       WHEN 114  LET l_str=ga_page_data_t.field114
       WHEN 115  LET l_str=ga_page_data_t.field115
       WHEN 116  LET l_str=ga_page_data_t.field116
       WHEN 117  LET l_str=ga_page_data_t.field117
       WHEN 118  LET l_str=ga_page_data_t.field118
       WHEN 119  LET l_str=ga_page_data_t.field119
       WHEN 120  LET l_str=ga_page_data_t.field120
       WHEN 121  LET l_str=ga_page_data_t.field121
       WHEN 122  LET l_str=ga_page_data_t.field122
       WHEN 123  LET l_str=ga_page_data_t.field123
       WHEN 124  LET l_str=ga_page_data_t.field124
       WHEN 125  LET l_str=ga_page_data_t.field125
       WHEN 126  LET l_str=ga_page_data_t.field126
       WHEN 127  LET l_str=ga_page_data_t.field127
       WHEN 128  LET l_str=ga_page_data_t.field128
       WHEN 129  LET l_str=ga_page_data_t.field129
       WHEN 130  LET l_str=ga_page_data_t.field130
       WHEN 131  LET l_str=ga_page_data_t.field131
       WHEN 132  LET l_str=ga_page_data_t.field132
       WHEN 133  LET l_str=ga_page_data_t.field133
       WHEN 134  LET l_str=ga_page_data_t.field134
       WHEN 135  LET l_str=ga_page_data_t.field135
       WHEN 136  LET l_str=ga_page_data_t.field136
       WHEN 137  LET l_str=ga_page_data_t.field137
       WHEN 138  LET l_str=ga_page_data_t.field138
       WHEN 139  LET l_str=ga_page_data_t.field139
       WHEN 140  LET l_str=ga_page_data_t.field140
       WHEN 141  LET l_str=ga_page_data_t.field141
       WHEN 142  LET l_str=ga_page_data_t.field142
       WHEN 143  LET l_str=ga_page_data_t.field143
       WHEN 144  LET l_str=ga_page_data_t.field144
       WHEN 145  LET l_str=ga_page_data_t.field145
       WHEN 146  LET l_str=ga_page_data_t.field146
       WHEN 147  LET l_str=ga_page_data_t.field147
       WHEN 148  LET l_str=ga_page_data_t.field148
       WHEN 149  LET l_str=ga_page_data_t.field149
       WHEN 150  LET l_str=ga_page_data_t.field150
     END CASE
 
 RETURN l_str CLIPPED
 
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
# Date & Author..: 2015/07/19 
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_01_group()
 DEFINE  l_gzic005      LIKE gzic_t.gzic005
  DEFINE  l_gzic003      LIKE type_t.num5
  #DEFINE  l_i             LIKE type_t.num5
  DEFINE  l_i             LIKE type_t.num10 # 160310-00006#1 mod
  DEFINE  l_n            LIKE type_t.num5
  DEFINE  l_end          LIKE type_t.num5
  DEFINE  l_end1         LIKE type_t.num5
  DEFINE  l_end2         LIKE type_t.num5
  DEFINE  l_end3         LIKE type_t.num5
  DEFINE  l_stpos        LIKE type_t.num5
  # 160310-00006#1 mod(s)
#  DEFINE  l_row          LIKE type_t.num5
#  DEFINE  l_row_t        LIKE type_t.num5
#  DEFINE  l_cnt          LIKE type_t.num5
   DEFINE  l_row          LIKE type_t.num10
  DEFINE  l_row_t        LIKE type_t.num10
  DEFINE  l_cnt          LIKE type_t.num10
  # 160310-00006#1 mod(e)
  DEFINE  l_sumvalue     LIKE type_t.num26_10
  DEFINE  l_value        LIKE type_t.num26_10
  DEFINE  l_value_n      LIKE type_t.num26_10
  DEFINE  l_value_p      LIKE gzid_t.gzid004 #160901-00030#1 mod dzeb002->gzid004
  DEFINE  l_value_pt     LIKE gzid_t.gzid004 #160901-00030#1 mod dzeb002->gzid004
  DEFINE  l_str          STRING
  DEFINE  l_from         STRING
  DEFINE  l_where        STRING
  DEFINE  l_order        STRING
  DEFINE  l_order1       STRING
  DEFINE  l_sel          STRING
  DEFINE  l_group        STRING
  DEFINE  l_page         DYNAMIC ARRAY OF LIKE type_t.chr1
  DEFINE  l_sql          STRING
  DEFINE  l_sql1         STRING
  DEFINE  l_gzic_d       DYNAMIC ARRAY OF RECORD
                             gzid004  LIKE gzid_t.gzid004,   #欄位代號
                             gzid003  LIKE gzid_t.gzid003,   #表别名         #151214-00004#2 add #增加资料表别名的信息，解决一表多用问题
                             gzic002  LIKE gzic_t.gzic002,   #序号
                             gzic003  LIKE gzic_t.gzic003,   #計算式
                             gzic004  LIKE gzic_t.gzic004,   #依group欄位
                             gzic005  LIKE gzic_t.gzic005,   #group 欄位序號
                             gzic006  LIKE gzic_t.gzic006,   #
                             ggzid004 LIKE gzid_t.gzid004,   #group 欄位代號                      
                             gzic007  LIKE gzic_t.gzic007,    #顯示方式
                             gzid016  LIKE gzid_t.gzid016     #栏位别名 160721-00005#1 增加栏位别名 
                       END RECORD
  DEFINE l_col,l_pcol       LIKE type_t.chr100    #151214-00004#2 add #增加资料表别名的信息，解决一表多用问题
  DEFINE l_flag             LIKE type_t.chr1      #151214-00004#1 add
  #160721-00005#1 add(s)
  DEFINE ls_serial                 STRING
  DEFINE ls_tmptbl                 STRING
  DEFINE l_alias_cnt               INTEGER
  DEFINE l_from1                   STRING
  #160721-00005#1 add(e)
  DEFINE li_serial LIKE type_t.num10 #160728-00027#1 add
  
  #161202-00026#1 add(s)
  DEFINE l_lowsql  STRING   
  DEFINE l_lowcol  STRING
  #161202-00026#1 add(e)
  
  #截取原sql的from where order by内容
  LET l_str=g_execmd.toLowerCase()
  LET l_stpos=l_str.getIndexOf('from',1)
  LET l_end=l_str.getLength()
  LET l_from=g_execmd.subString(l_stpos,l_end)
  #160721-00005#1 add(s)
 
  SELECT count(gzid016) INTO l_alias_cnt FROM gzid_t WHERE gzid001=g_query_prog
  IF l_alias_cnt >0 THEN
  IF g_gzic_d_cnt >0 THEN
    LET l_sql=g_execmd.subString(1,l_stpos-1)
    LET l_lowsql=l_str.subString(1,l_stpos-1) #161202-00026#1 add
    FOR l_i=1 TO g_gzib_d.getLength()
         #161202-00026#1 add(s)      
         IF not cl_null(g_gzib_d[l_i].gzib007) THEN
           LET l_lowcol = g_gzib_d[l_i].gzib007||"."||g_gzib_d[l_i].gzib002
           LET l_lowcol=l_lowcol.toLowerCase()
           IF l_lowsql.getIndexOf(l_lowcol,1) > 0 THEN
              CONTINUE FOR           
           END IF
         END IF
         
         LET l_lowcol=g_gzib_d[l_i].gzib002 
         LET l_lowcol=l_lowcol.toLowerCase()
         IF l_lowsql.getIndexOf(l_lowcol,1) > 0 THEN
            CONTINUE FOR
         END IF
         #161202-00026#1 add(e)
        
        IF not cl_null(g_gzib_d[l_i].gzib007) AND g_gzib_d[l_i].gzib007 != "user-def" THEN       
           LET l_sql=l_sql,","||g_gzib_d[l_i].gzib007||"."||g_gzib_d[l_i].gzib002  
           LET l_sql1=l_sql1,g_gzib_d[l_i].gzib007||"."||g_gzib_d[l_i].gzib002||","             
        ELSE
           LET l_sql=l_sql,","||g_gzib_d[l_i].gzib002 
           LET l_sql1=l_sql1,g_gzib_d[l_i].gzib002||","
        END IF
 
    END FOR
    LET l_from1=l_from.toLowerCase()
    LET l_end1=l_from1.getIndexOf('group by',1)
    LET l_from1=l_from
    IF l_end1 >0 THEN
        LET l_from1=l_from.subString(1,l_end1+8),l_sql1,l_from.subString(l_end1+9,l_from.getLength())
    END IF
    LET l_sql=l_sql," ",l_from1
  ELSE
     LET l_sql=g_execmd
  END IF
   
   #LET ls_serial = azzi310_get_tmptbl_id() #160728-00027#1mark
   #160728-00027#1 add(s)
   SELECT USERENV('SESSIONID') INTO li_serial FROM DUAL #160728-00027#1 add
   LET ls_serial=li_serial
   #160728-00027#1 add(e)
   LET ls_tmptbl = "azzi310_",ls_serial,"_tmp2"

   LET l_sql1 = "DROP TABLE ",ls_tmptbl
   PREPARE drop_cols2_crt FROM l_sql1
   EXECUTE drop_cols2_crt
   
   LET l_sql1 = " CREATE TABLE ",ls_tmptbl,
               " TABLESPACE temptabs ",
               " AS ",
               "    (SELECT * ",
               "       FROM (",l_sql,") ",
               "      WHERE rownum<= "||g_gzia005,")"
   PREPARE get_cols_crt FROM l_sql1
   EXECUTE get_cols_crt

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "group create table :",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF
 
   #计算依群组计算
   FOR l_n=1 to g_gzic_d_cnt
       CASE g_gzic_d[l_n].gzic003
  	 	      WHEN '0'
              LET l_str="SUM("||g_gzic_d[l_n].gzid016||")" 
              LET l_gzic003=7             
            WHEN '1'
              LET l_str="MIN("||g_gzic_d[l_n].gzid016||")"  
              LET l_gzic003=2               
            WHEN '2'
              LET l_str="MAX("||g_gzic_d[l_n].gzid016||")" 
              LET l_gzic003=3
            WHEN '3'
              LET l_str="COUNT("||g_gzic_d[l_n].gzid016||")"
              LET l_gzic003=4
            WHEN '4'
              LET l_str="AVG("||g_gzic_d[l_n].gzid016||")" 
              LET l_gzic003=5
  	 	  END CASE  	 	  
  	 	  LET l_sql="select gzic005 from (select gzic005,gzic002 from gzic_t where gzic001='",g_query_prog,
  	 	            "' and gzic006='p'  and gzic005 >=1 and gzic002>1) ",
  	 	            " start with gzic002=",g_gzic_d[l_n].gzic005," connect by  nocycle  prior gzic005=gzic002 ",
  	 	            " order by gzic005"
  	 	  PREPARE azzi310_01_get_gzic_cs_pre FROM l_sql
        DECLARE azzi310_01_get_gzic_cs  CURSOR FOR azzi310_01_get_gzic_cs_pre
        #161215-00017#1 add(s)
        LET l_i=0
        LET l_group=""
        LET l_order=""
        #161215-00017#1 add(e)
        FOREACH azzi310_01_get_gzic_cs INTO l_i          
           LET l_group=l_group,",",g_gzib_d[l_i].gzib002  

         #161206-00041 add(s)          
        LET l_order=l_order,",",g_gzib_d[l_i].gzib002    
        IF g_gzib_d[l_i].gzib006 = '2' THEN
           LET l_order = l_order ," DESC"
        END IF 
        #161206-00041 add(e)           
         
        END FOREACH 
        LET l_group=l_group,",",g_gzic_d[l_n].ggzid004
         LET l_order=l_order,",",g_gzic_d[l_n].ggzid004    #161215-00017#1 add
        LET l_order=l_order.subString(2,l_order.getLength())#161206-00041 add 
        LET l_group=l_group.subString(2,l_group.getLength())
        #161206-00041 mod，增加l_order
  	 	  LET l_sql1="SELECT count(*),",l_str," FROM ",ls_tmptbl," GROUP BY ",l_group," ORDER BY ",l_order
  	 	  
  	 	  PREPARE azzi310_01_group_pre FROM l_sql1
  	 	  DECLARE azzi310_01_group_cs CURSOR FOR azzi310_01_group_pre
  	 	  LET l_row=0
  	 	  LET l_cnt=0
  	 	  LET l_value=0
  	 	  FOREACH azzi310_01_group_cs INTO l_cnt,l_value
  	 	      LET l_row=l_row+l_cnt
  	 	      CALL azzi310_01_group_sum(g_gzic_d[l_n].gzic002,l_row,l_value,g_gzic_d[l_n].gzic005,g_gzic_d[l_n].gzic007,l_gzic003)
  	 	  END FOREACH
   END FOR
   
    #不按分组计算汇总
    IF g_gzic_sum_cnt >0 THEN
      # LET l_gzic005=l_gzic005+1  #161202-00026#1 mark
       LET l_gzic005=ga_sum_row.getLength()+1 #161202-00026#1 add
       LET l_sql="SELECT unique gzid004,(SELECT gzig003 FROM gzig_t ",
                                         "WHERE DECODE(gzig003,' ',gzig002,'',gzig002,gzig003)=gzid003 ",
                                         "  AND gzig001='",g_gzia001,"') gzid003,",
                 "       gzic002,gzic003,gzic004,",l_gzic005," gzic005,",
                 "       gzic006,'0' ggzid004,gzic007,gzid016 FROM gzic_t,gzid_t  ",
                 " WHERE gzic001=gzid001 AND gzic002=gzid002 ",
                 "   AND gzic001='",g_gzia001,"' AND gzic003 !='6' AND gzic004 !='Y' ",
                 " ORDER BY gzic005,gzic002"
    PREPARE azzi310_01_sumy_pre3 FROM l_sql
  	 DECLARE azzi310_01_sumy_curs3 CURSOR FOR azzi310_01_sumy_pre3
  	 LET l_i=1
  	 FOREACH azzi310_01_sumy_curs3 INTO l_gzic_d[l_i].*
  	 	  LET l_i=l_i+1
  	 END FOREACH
 	 	
  	 FOR l_n=1 TO g_gzic_sum_cnt
  	 	  CASE l_gzic_d[l_n].gzic003
  	 	      WHEN '0'
              LET l_str="SUM("||l_gzic_d[l_n].gzid016||")" 
              LET l_gzic003=1     #161202-00026#1 mod         
            WHEN '1'
              LET l_str="MIN("||l_gzic_d[l_n].gzid016||")"  
              LET l_gzic003=2               
            WHEN '2'
              LET l_str="MAX("||l_gzic_d[l_n].gzid016||")" 
              LET l_gzic003=3
            WHEN '3'
              LET l_str="COUNT("||l_gzic_d[l_n].gzid016||")"
              LET l_gzic003=4
            WHEN '4'
              LET l_str="AVG("||l_gzic_d[l_n].gzid016||")" 
              LET l_gzic003=5
  	 	  END CASE
        LET l_sql1="SELECT count(*),",l_str," FROM ",ls_tmptbl
  	 	  PREPARE azzi310_01_group_pre4 FROM l_sql1
  	 	  DECLARE  azzi310_01_group_cs4 CURSOR FOR azzi310_01_group_pre4
  	 	  LET l_row=1
  	 	  LET l_cnt=0
  	 	  LET l_value=0
  	 	  FOREACH azzi310_01_group_cs4 INTO l_cnt,l_value
  	 	      LET l_row=l_row+l_cnt
  	 	      CALL azzi310_01_group_sum(l_gzic_d[l_n].gzic002,l_row,l_value,l_gzic_d[l_n].gzic005,l_gzic_d[l_n].gzic007,l_gzic003)
  	 	  END FOREACH
  	 END FOR
  END IF
  
  ELSE
  #160721-00005#1 add(e)
  
#  LET l_end=l_str.getIndexOf('where',1)
#  LET l_end1=l_str.getIndexOf('group by',1)
#  LET l_end2=l_str.getIndexOf('order by',1)
#  LET l_end3=l_str.getLength()
#  IF l_end=0 THEN
#  	 LET l_where=" 1=1 "
#  	 IF l_end1=0 THEN
#  	 	  IF l_end2=0 THEN
#  	 	  	 LET l_from=l_str.subString(l_stpos,l_end3)
#  	 	  ELSE
#  	 	  	 LET l_from=l_str.subString(l_stpos,l_end2-1)
#  	 	  END IF
#  	 ELSE
#  	 	  LET l_from=l_str.subString(l_stpos,l_end1-1)
#  	 END IF
#  ELSE
#  	 LET l_from=l_str.subString(l_stpos,l_end-1)
#  	 LET l_stpos=l_end
#  	 IF l_end1=0 THEN
#  	 	  IF l_end2=0 THEN 	 	  	 
#  	 	  	  LET l_where=l_str.subString(l_stpos,l_end3)
#  	 	  ELSE
#  	 	  	 LET l_where=l_str.subString(l_stpos,l_end2-1)
#  	 	  END IF
#  	 ELSE
#  	 	  LET l_where=l_str.subString(l_stpos,l_end1-1)
#  	 END IF 
#  END IF
#  
#  LET l_stpos=l_str.getIndexOF('order by',1)
#  IF l_end2=0 THEN
#  	 LET l_order=""
#  ELSE
#  	  LET l_order=l_str.subString(l_end2,l_end3)
#  END IF
  	
  
  LET l_i=0
  LET l_n=0  
 # LET l_sql="SELECT unique gzic005 FROM gzic_t WHERE gzic001='",g_gzia001,"' ORDER BY gzic005 "
 # PREPARE azzi310_01_group_pre FROM l_sql
 # DECLARE azzi310_01_group_curs CURSOR FOR azzi310_01_group_pre
  	
  
  LET l_cnt=0
  LET l_gzic005=0
  IF g_gzic_d_cnt > 0 THEN
     #FOREACH azzi310_01_group_curs INTO l_gzic005
  	 FOR l_n =1 TO g_gzic_d_cnt
  	     LET l_sel=""
  	     LET l_row=0 
  	     LET l_row_t=0 
  	 	   #  LET l_group=" GROUP BY ",g_gzic_d[l_n].ggzid004
  	 	     CASE g_gzic_d[l_n].gzic003
  	 	        WHEN '0'
  	 	   #       LET l_sel="SELECT count(*),sum(",g_gzic_d[l_n].gzid004,")"
  	 	          LET l_gzic003=7
  	 	        WHEN '1'
  	 	   #       LET l_sel="SELECT count(*),min(",g_gzic_d[l_n].gzid004,")"
  	 	           LET l_gzic003=2
  	 	        WHEN '2'
  	 	   #       LET l_sel="SELECT count(*),max(",g_gzic_d[l_n].gzid004,")"
  	 	           LET l_gzic003=3
  	 	        WHEN '3'
  	 	   #       LET l_sel="SELECT count(*),count(",g_gzic_d[l_n].gzid004,")"
  	 	           LET l_gzic003=4
  	 	        WHEN '4'
  	 	   #       LET l_sel="SELECT count(*),avg(",g_gzic_d[l_n].gzid004,")"
  	 	           LET l_gzic003=5
  	 	     END CASE
  	 	     	 	     
  	 	     #LET l_sql1="SELECT ",g_gzic_d[l_n].gzid004,",",g_gzic_d[l_n].ggzid004," ",l_from," ",l_where," ",l_order 
  	 	     #151214-00004#2 mark #增加资料表别名的信息，解决一表多用问题
            #LET l_sql1="SELECT ",g_gzic_d[l_n].gzid004,",",g_gzic_d[l_n].ggzid004,"  ",l_from
  	 	     
           #151214-00004#2 add(s) #增加资料表别名的信息，解决一表多用问题
           LET l_col=g_gzic_d[l_n].gzid004
           LET l_pcol=g_gzic_d[l_n].ggzid004
           IF not cl_null(g_gzic_d[l_n].gzid003) AND g_gzic_d[l_n].gzid003 != "user-def" THEN
              LET l_col=g_gzic_d[l_n].gzid003,".",g_gzic_d[l_n].gzid004
           END IF
           IF not cl_null(g_gzic_d[l_n].gzib007) AND g_gzic_d[l_n].gzib007 != "user-def" THEN
              LET l_pcol=g_gzic_d[l_n].gzib007,".",g_gzic_d[l_n].ggzid004
           END IF
           LET l_sql1="SELECT ",l_col,",",l_pcol," ",l_from
           #151214-00004#2 add(e) 
           
  	 	     PREPARE azzi310_01_sel_pre FROM l_sql1
  	 	     DECLARE azzi310_01_sel_curs CURSOR FOR azzi310_01_sel_pre
                     LET l_i=0
                     LET l_value=0
                     LET l_cnt=0
                     LET l_value_p=""
                     LET l_value_pt=""
                     LET l_sumvalue=0
  	 	     FOREACH azzi310_01_sel_curs INTO l_value_n,l_value_p
  	 	           #150924-00005#1 add(s)
  	 	            IF cl_null(l_value_n) THEN
  	 	                LET l_value_n=0
  	 	            END IF
  	 	            #150924-00005#1 add(e)
                         LET l_i=l_i+1
                         LET l_cnt=l_cnt+1
                         IF l_value_p !=l_value_pt OR (g_gzia005 is not null and l_i>g_gzia005) THEN
                             LET l_row=l_i-1
                             CALL azzi310_01_group_sum(g_gzic_d[l_n].gzic002,l_row,l_value,g_gzic_d[l_n].gzic005,g_gzic_d[l_n].gzic007,l_gzic003)
                             LET l_cnt=1
                             LET l_value=0
                             LET l_sumvalue=0
                             LET l_flag='Y'
                         END IF   
                         IF l_i > g_gzia005 THEN
                            EXIT FOREACH
                         END IF 
                         LET l_flag='N'                         
  	 	        CASE g_gzic_d[l_n].gzic003
  	 	           WHEN '0'
                             LET l_value=l_value+l_value_n
 
  	 	           WHEN '1'
                              IF l_cnt=1 THEN
                                 LET l_value=l_value_n
                              ELSE
                                 IF l_value > l_value_n THEN
                                     LET l_value=l_value_n
                                 END IF 
                              END IF
 
  	 	           WHEN '2'
                              IF l_cnt=1 THEN
                                 LET l_value=l_value_n
                              ELSE
                                 IF l_value < l_value_n THEN
                                     LET l_value=l_value_n
                                 END IF 
                              END IF
 
  	 	           WHEN '4'
                              LET l_sumvalue=l_sumvalue+l_value_n
                              LET l_value=l_sumvalue/l_cnt
 
  	 	           WHEN '3'
                              LET l_value=l_cnt
 
  	 	        END CASE
                        LET l_value_pt=l_value_p
                  
                     END FOREACH 
          #IF l_value !=0 AND l_i < g_gzia005 THEN      #Foreach 结束退出
          IF l_flag='N' AND l_i < g_gzia005 THEN        #151214-00004#1 mod
            LET l_row=l_i
            CALL azzi310_01_group_sum(g_gzic_d[l_n].gzic002,l_row,l_value,g_gzic_d[l_n].gzic005,g_gzic_d[l_n].gzic007,l_gzic003)
         END IF
  	 	     
  	 END FOR 
         
    LET l_gzic005=g_gzic_d[l_n-1].gzic005
  END IF
  

  
  IF g_gzic_sum_cnt >0 THEN
       LET l_gzic005=l_gzic005+1
       #151214-00004#2 mod #增加资料表别名的信息，解决一表多用问题
       #LET l_sql="SELECT unique gzid004,gzic002,gzic003,gzic004,",l_gzic005," gzic005,gzic006,'0' ggzid004,gzic007 FROM gzic_t,gzid_t  ",
       LET l_sql="SELECT unique gzid004,(SELECT gzig003 FROM gzig_t ",
                                         "WHERE DECODE(gzig003,' ',gzig002,'',gzig002,gzig003)=gzid003 ",
                                         "  AND gzig001='",g_gzia001,"') gzid003,",
                 "       gzic002,gzic003,gzic004,",l_gzic005," gzic005,",
                 "       gzic006,'0' ggzid004,gzic007,gzid016 FROM gzic_t,gzid_t  ", #160721-00005 mod 增加gzid016
                 " WHERE gzic001=gzid001 AND gzic002=gzid002 ",
                 "   AND gzic001='",g_gzia001,"' AND gzic003 !='6' AND gzic004 !='Y' ",
                 " ORDER BY gzic005,gzic002"
     PREPARE azzi310_01_sumy_pre1 FROM l_sql
  	 DECLARE azzi310_01_sumy_curs1 CURSOR FOR azzi310_01_sumy_pre1
  	 LET l_i=1
  	 FOREACH azzi310_01_sumy_curs1 INTO l_gzic_d[l_i].*
  	 	  LET l_i=l_i+1
  	 END FOREACH
 	 	
  	 FOR l_n=1 TO g_gzic_sum_cnt
  	 	  LET l_row=1
  	 	  CASE l_gzic_d[l_n].gzic003
  	 	        WHEN '0'
#  	 	          LET l_sel="SELECT count(*),sum(",l_gzic_d[l_n].gzid004,")"
  	 	          LET l_gzic003=1
  	 	        WHEN '1'
#  	 	          LET l_sel="SELECT count(*),min(",l_gzic_d[l_n].gzid004,")"
  	 	           LET l_gzic003=2
  	 	        WHEN '2'
#  	 	          LET l_sel="SELECT count(*),max(",l_gzic_d[l_n].gzid004,")"
  	 	           LET l_gzic003=3
  	 	        WHEN '3'
#  	 	          LET l_sel="SELECT count(*),count(",l_gzic_d[l_n].gzid004,")"
  	 	           LET l_gzic003=4
  	 	        WHEN '4'
#  	 	          LET l_sel="SELECT count(*),avg(",l_gzic_d[l_n].gzid004,")"
  	 	           LET l_gzic003=5
  	 	     END CASE
#  	 	     LET l_sql=l_sel," ",l_from," ",l_where," ",l_order


         #  LET l_sql="SELECT ",l_gzic_d[l_n].gzid004,",",l_gzic_d[l_n].ggzid004," ",l_from," ",l_where," ",l_order
         #151214-00004#2 mark #增加资料表别名的信息，解决一表多用问题
            #LET l_sql="SELECT ",l_gzic_d[l_n].gzid004,",",l_gzic_d[l_n].ggzid004,"  ",l_from
            
           #151214-00004#2 add(s) #增加资料表别名的信息，解决一表多用问题
           LET l_col=l_gzic_d[l_n].gzid004
           LET l_pcol=l_gzic_d[l_n].ggzid004
           IF not cl_null(l_gzic_d[l_n].gzid003) AND l_gzic_d[l_n].gzid003 != "user-def" THEN
              LET l_col=l_gzic_d[l_n].gzid003,".",l_gzic_d[l_n].gzid004
           END IF
           LET l_sql="SELECT ",l_col,",",l_pcol," ",l_from
           #151214-00004#2 add(e) 
  	 	     PREPARE azzi310_01_sumy_pre FROM l_sql
  	 	     DECLARE azzi310_01_sumy_cs CURSOR FOR azzi310_01_sumy_pre
                     LET l_i=0
                     LET l_value=0
                     LET l_cnt=0
                     LET l_value_p=""
                     LET l_value_pt=""
                     LET l_sumvalue=0
  	 	     FOREACH azzi310_01_sumy_cs INTO l_value_n,l_value_p
  	 	            #150924-00005#1 add(s)
  	 	            IF cl_null(l_value_n) THEN
  	 	                LET l_value_n=0
  	 	            END IF
  	 	            #150924-00005#1 add(e)
                         LET l_i=l_i+1
                         LET l_cnt=l_cnt+1
#                         IF l_value_p !=l_value_pt OR l_i>100 THEN
#                             LET l_row=l_i-1
#                             CALL azzi310_01_group_sum(g_gzic_d[l_n].gzic002,l_row,l_value,g_gzic_d[l_n].gzic005,g_gzic_d[l_n].gzic007,l_gzic003)
#                             LET l_cnt=1
#                             LET l_value=0
#                             LET l_sumvalue=0
#                         END IF  
                        IF g_gzia005 is not null AND l_i> g_gzia005 THEN
                            LET l_cnt=l_cnt-1    #151214-00004#1 add
                            EXIT FOREACH
                        END IF
  	 	        CASE l_gzic_d[l_n].gzic003
  	 	           WHEN '0'
                             LET l_value=l_value+l_value_n
 
  	 	           WHEN '1'
                              IF l_cnt=1 THEN
                                 LET l_value=l_value_n
                              ELSE
                                 IF l_value > l_value_n THEN
                                     LET l_value=l_value_n
                                 END IF 
                              END IF
 
  	 	           WHEN '2'
                              IF l_cnt=1 THEN
                                 LET l_value=l_value_n
                              ELSE
                                 IF l_value < l_value_n THEN
                                     LET l_value=l_value_n
                                 END IF 
                              END IF
 
  	 	           WHEN '4'
                              LET l_sumvalue=l_sumvalue+l_value_n
                              LET l_value=l_sumvalue/l_cnt
 
  	 	           WHEN '3'
                              LET l_value=l_cnt
 
  	 	        END CASE
                        LET l_value_pt=l_value_p
                        

                     END FOREACH 




           IF l_cnt=0 THEN
              EXIT FOR
           END IF


#  	 	     PREPARE azzi310_01_sumy_cs FROM l_sql
#  	 	     EXECUTE azzi310_01_sumy_cs INTO l_cnt,l_value
  	 	     LET l_row=l_row+l_cnt
  	 	     CALL azzi310_01_group_sum(l_gzic_d[l_n].gzic002,l_row,l_value,l_gzic_d[l_n].gzic005,l_gzic_d[l_n].gzic007,l_gzic003)
  	 	     LET l_row=l_row-l_cnt   #还原原来的行数
  	 END FOR
  END IF

END IF #160721-00005#1 add 
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzi310_01_group_check(p_n,p_i)
#                  RETURNING l_tag
# Input parameter: p_n   check栏位序号    
#                : p_i   行数
# Return code....: l_tag  true/false
# Date & Author..: 2015/07/19 by chenjpa
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_01_group_check(p_n,p_i)
DEFINE p_i       LIKE type_t.num10        #目前check的欄位
#DEFINE p_n       LIKE type_t.num5        #行数
DEFINE p_n       LIKE type_t.num10        #行数 #160310-00006#1 mod 
DEFINE l_str     LIKE dzeb_t.dzeb003
DEFINE l_tag     LIKE type_t.num5
 
 LET l_tag = 0
     
      #判斷需計算sum
      #161215-00017#1 add(s)
      CASE p_n 
       WHEN   1 IF (ga_table_data[p_i].field001 <> ga_page_data_t.field001 AND ((ga_table_data[p_i].field001 IS NOT NULL AND ga_page_data_t.field001 IS NOT NULL) OR (ga_table_data[p_i].field001 IS NOT NULL AND ga_page_data_t.field001 IS NULL) OR (ga_table_data[p_i].field001 IS NULL AND ga_page_data_t.field001 IS NOT NULL))) 
                OR (ga_table_data[p_i].field001 IS NULL AND ga_page_data_t.field001 IS NOT NULL)
                OR (ga_table_data[p_i].field001 IS NOT NULL AND ga_page_data_t.field001 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field001 END IF
       WHEN   2 IF (ga_table_data[p_i].field002 <> ga_page_data_t.field002 AND ((ga_table_data[p_i].field002 IS NOT NULL AND ga_page_data_t.field002 IS NOT NULL) OR(ga_table_data[p_i].field002 IS NULL AND ga_page_data_t.field002 IS NOT NULL) OR (ga_table_data[p_i].field002 IS NOT NULL AND ga_page_data_t.field002 IS NULL))) 
                OR (ga_table_data[p_i].field002 IS NULL AND ga_page_data_t.field002 IS NOT NULL)
                OR (ga_table_data[p_i].field002 IS NOT NULL AND ga_page_data_t.field002 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field002 END IF  
       WHEN   3 IF (ga_table_data[p_i].field003 <> ga_page_data_t.field003 AND ((ga_table_data[p_i].field003 IS NOT NULL AND ga_page_data_t.field003 IS NOT NULL) OR (ga_table_data[p_i].field003 IS NULL AND ga_page_data_t.field003 IS NOT NULL) OR (ga_table_data[p_i].field003 IS NOT NULL AND ga_page_data_t.field003 IS NULL))) 
                OR (ga_table_data[p_i].field003 IS NULL AND ga_page_data_t.field003 IS NOT NULL)
                OR (ga_table_data[p_i].field003 IS NOT NULL AND ga_page_data_t.field003 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field003 END IF 
       WHEN   4 IF (ga_table_data[p_i].field004 <> ga_page_data_t.field004 AND ((ga_table_data[p_i].field004 IS NOT NULL AND ga_page_data_t.field004 IS NOT NULL) OR(ga_table_data[p_i].field004 IS NULL AND ga_page_data_t.field004 IS NOT NULL) OR (ga_table_data[p_i].field004 IS NOT NULL AND ga_page_data_t.field004 IS NULL))) 
                OR (ga_table_data[p_i].field004 IS NULL AND ga_page_data_t.field004 IS NOT NULL)
                OR (ga_table_data[p_i].field004 IS NOT NULL AND ga_page_data_t.field004 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field004 END IF 
       WHEN   5 IF (ga_table_data[p_i].field005 <> ga_page_data_t.field005 AND ((ga_table_data[p_i].field005 IS NOT NULL AND ga_page_data_t.field005 IS NOT NULL) OR (ga_table_data[p_i].field005 IS NULL AND ga_page_data_t.field005 IS NOT NULL) OR (ga_table_data[p_i].field005 IS NOT NULL AND ga_page_data_t.field005 IS NULL))) 
                OR (ga_table_data[p_i].field005 IS NULL AND ga_page_data_t.field005 IS NOT NULL)
                OR (ga_table_data[p_i].field005 IS NOT NULL AND ga_page_data_t.field005 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field005 END IF 
       WHEN   6 IF (ga_table_data[p_i].field006 <> ga_page_data_t.field006 AND ((ga_table_data[p_i].field006 IS NOT NULL AND ga_page_data_t.field006 IS NOT NULL) OR(ga_table_data[p_i].field006 IS NULL AND ga_page_data_t.field006 IS NOT NULL) OR (ga_table_data[p_i].field006 IS NOT NULL AND ga_page_data_t.field006 IS NULL))) 
                OR (ga_table_data[p_i].field006 IS NULL AND ga_page_data_t.field006 IS NOT NULL)
                OR (ga_table_data[p_i].field006 IS NOT NULL AND ga_page_data_t.field006 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field006 END IF 
       WHEN   7 IF (ga_table_data[p_i].field007 <> ga_page_data_t.field007 AND ((ga_table_data[p_i].field007 IS NOT NULL AND ga_page_data_t.field007 IS NOT NULL) OR (ga_table_data[p_i].field007 IS NULL AND ga_page_data_t.field007 IS NOT NULL) OR (ga_table_data[p_i].field007 IS NOT NULL AND ga_page_data_t.field007 IS NULL))) 
                OR (ga_table_data[p_i].field007 IS NULL AND ga_page_data_t.field007 IS NOT NULL)
                OR (ga_table_data[p_i].field007 IS NOT NULL AND ga_page_data_t.field007 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field007 END IF 
       WHEN   8 IF (ga_table_data[p_i].field008 <> ga_page_data_t.field008 AND ((ga_table_data[p_i].field008 IS NOT NULL AND ga_page_data_t.field008 IS NOT NULL) OR(ga_table_data[p_i].field008 IS NULL AND ga_page_data_t.field008 IS NOT NULL) OR (ga_table_data[p_i].field008 IS NOT NULL AND ga_page_data_t.field008 IS NULL))) 
                OR (ga_table_data[p_i].field008 IS NULL AND ga_page_data_t.field008 IS NOT NULL)
                OR (ga_table_data[p_i].field008 IS NOT NULL AND ga_page_data_t.field008 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field008 END IF 
       WHEN   9 IF (ga_table_data[p_i].field009 <> ga_page_data_t.field009 AND ((ga_table_data[p_i].field009 IS NOT NULL AND ga_page_data_t.field009 IS NOT NULL) OR (ga_table_data[p_i].field009 IS NULL AND ga_page_data_t.field009 IS NOT NULL) OR (ga_table_data[p_i].field009 IS NOT NULL AND ga_page_data_t.field009 IS NULL))) 
                OR (ga_table_data[p_i].field009 IS NULL AND ga_page_data_t.field009 IS NOT NULL)
                OR (ga_table_data[p_i].field009 IS NOT NULL AND ga_page_data_t.field009 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field009 END IF 
              
       WHEN  10 IF (ga_table_data[p_i].field010 <> ga_page_data_t.field010 AND ((ga_table_data[p_i].field010 IS NOT NULL AND ga_page_data_t.field010 IS NOT NULL) OR (ga_table_data[p_i].field010 IS NULL AND ga_page_data_t.field010 IS NOT NULL) OR (ga_table_data[p_i].field010 IS NOT NULL AND ga_page_data_t.field010 IS NULL))) 
                OR (ga_table_data[p_i].field010 IS NULL AND ga_page_data_t.field010 IS NOT NULL)
                OR (ga_table_data[p_i].field010 IS NOT NULL AND ga_page_data_t.field010 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field010 END IF  
       WHEN  11 IF (ga_table_data[p_i].field011 <> ga_page_data_t.field011 AND ((ga_table_data[p_i].field011 IS NOT NULL AND ga_page_data_t.field011 IS NOT NULL) OR (ga_table_data[p_i].field011 IS NULL AND ga_page_data_t.field011 IS NOT NULL) OR (ga_table_data[p_i].field011 IS NOT NULL AND ga_page_data_t.field011 IS NULL))) 
                OR (ga_table_data[p_i].field011 IS NULL AND ga_page_data_t.field011 IS NOT NULL)
                OR (ga_table_data[p_i].field011 IS NOT NULL AND ga_page_data_t.field011 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field011 END IF
       WHEN  12 IF (ga_table_data[p_i].field012 <> ga_page_data_t.field012 AND ((ga_table_data[p_i].field012 IS NOT NULL AND ga_page_data_t.field012 IS NOT NULL) OR (ga_table_data[p_i].field012 IS NULL AND ga_page_data_t.field012 IS NOT NULL) OR (ga_table_data[p_i].field012 IS NOT NULL AND ga_page_data_t.field012 IS NULL))) 
                OR (ga_table_data[p_i].field012 IS NULL AND ga_page_data_t.field012 IS NOT NULL)
                OR (ga_table_data[p_i].field012 IS NOT NULL AND ga_page_data_t.field012 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field012 END IF  
       WHEN  13 IF (ga_table_data[p_i].field013 <> ga_page_data_t.field013 AND ((ga_table_data[p_i].field013 IS NOT NULL AND ga_page_data_t.field013 IS NOT NULL) OR (ga_table_data[p_i].field013 IS NULL AND ga_page_data_t.field013 IS NOT NULL) OR (ga_table_data[p_i].field013 IS NOT NULL AND ga_page_data_t.field013 IS NULL))) 
                OR (ga_table_data[p_i].field013 IS NULL AND ga_page_data_t.field013 IS NOT NULL)
                OR (ga_table_data[p_i].field013 IS NOT NULL AND ga_page_data_t.field013 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field013 END IF 
       WHEN  14 IF (ga_table_data[p_i].field014 <> ga_page_data_t.field014 AND ((ga_table_data[p_i].field014 IS NOT NULL AND ga_page_data_t.field014 IS NOT NULL) OR (ga_table_data[p_i].field014 IS NULL AND ga_page_data_t.field014 IS NOT NULL) OR (ga_table_data[p_i].field014 IS NOT NULL AND ga_page_data_t.field014 IS NULL))) 
                OR (ga_table_data[p_i].field014 IS NULL AND ga_page_data_t.field014 IS NOT NULL)
                OR (ga_table_data[p_i].field014 IS NOT NULL AND ga_page_data_t.field014 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field014 END IF 
       WHEN  15 IF (ga_table_data[p_i].field015 <> ga_page_data_t.field015 AND ((ga_table_data[p_i].field015 IS NOT NULL AND ga_page_data_t.field015 IS NOT NULL) OR (ga_table_data[p_i].field015 IS NULL AND ga_page_data_t.field015 IS NOT NULL) OR (ga_table_data[p_i].field015 IS NOT NULL AND ga_page_data_t.field015 IS NULL))) 
                OR (ga_table_data[p_i].field015 IS NULL AND ga_page_data_t.field015 IS NOT NULL)
                OR (ga_table_data[p_i].field015 IS NOT NULL AND ga_page_data_t.field015 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field015 END IF 
       WHEN  16 IF (ga_table_data[p_i].field016 <> ga_page_data_t.field016 AND ((ga_table_data[p_i].field016 IS NOT NULL AND ga_page_data_t.field016 IS NOT NULL) OR (ga_table_data[p_i].field016 IS NULL AND ga_page_data_t.field016 IS NOT NULL) OR (ga_table_data[p_i].field016 IS NOT NULL AND ga_page_data_t.field016 IS NULL))) 
                OR (ga_table_data[p_i].field016 IS NULL AND ga_page_data_t.field016 IS NOT NULL)
                OR (ga_table_data[p_i].field016 IS NOT NULL AND ga_page_data_t.field016 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field016 END IF 
       WHEN  17 IF (ga_table_data[p_i].field017 <> ga_page_data_t.field017 AND ((ga_table_data[p_i].field017 IS NOT NULL AND ga_page_data_t.field017 IS NOT NULL) OR (ga_table_data[p_i].field017 IS NULL AND ga_page_data_t.field017 IS NOT NULL) OR (ga_table_data[p_i].field017 IS NOT NULL AND ga_page_data_t.field017 IS NULL))) 
                OR (ga_table_data[p_i].field017 IS NULL AND ga_page_data_t.field017 IS NOT NULL)
                OR (ga_table_data[p_i].field017 IS NOT NULL AND ga_page_data_t.field017 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field017 END IF 
       WHEN  18 IF (ga_table_data[p_i].field018 <> ga_page_data_t.field018 AND ((ga_table_data[p_i].field018 IS NOT NULL AND ga_page_data_t.field018 IS NOT NULL) OR (ga_table_data[p_i].field018 IS NULL AND ga_page_data_t.field018 IS NOT NULL) OR (ga_table_data[p_i].field018 IS NOT NULL AND ga_page_data_t.field018 IS NULL))) 
                OR (ga_table_data[p_i].field018 IS NULL AND ga_page_data_t.field018 IS NOT NULL)
                OR (ga_table_data[p_i].field018 IS NOT NULL AND ga_page_data_t.field018 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field018 END IF 
       WHEN  19 IF (ga_table_data[p_i].field019 <> ga_page_data_t.field019 AND ((ga_table_data[p_i].field019 IS NOT NULL AND ga_page_data_t.field019 IS NOT NULL) OR (ga_table_data[p_i].field019 IS NULL AND ga_page_data_t.field019 IS NOT NULL) OR (ga_table_data[p_i].field019 IS NOT NULL AND ga_page_data_t.field019 IS NULL))) 
                OR (ga_table_data[p_i].field019 IS NULL AND ga_page_data_t.field019 IS NOT NULL)
                OR (ga_table_data[p_i].field019 IS NOT NULL AND ga_page_data_t.field019 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field019 END IF 
     
     WHEN  20 IF (ga_table_data[p_i].field020 <> ga_page_data_t.field020 AND ((ga_table_data[p_i].field020 IS NOT NULL AND ga_page_data_t.field020 IS NOT NULL) OR (ga_table_data[p_i].field020 IS NULL AND ga_page_data_t.field020 IS NOT NULL) OR (ga_table_data[p_i].field020 IS NOT NULL AND ga_page_data_t.field020 IS NULL))) 
                OR (ga_table_data[p_i].field020 IS NULL AND ga_page_data_t.field020 IS NOT NULL)
                OR (ga_table_data[p_i].field020 IS NOT NULL AND ga_page_data_t.field020 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field020 END IF  
       WHEN  21 IF (ga_table_data[p_i].field021 <> ga_page_data_t.field021 AND ((ga_table_data[p_i].field021 IS NOT NULL AND ga_page_data_t.field021 IS NOT NULL) OR (ga_table_data[p_i].field021 IS NULL AND ga_page_data_t.field021 IS NOT NULL) OR (ga_table_data[p_i].field021 IS NOT NULL AND ga_page_data_t.field021 IS NULL))) 
                OR (ga_table_data[p_i].field021 IS NULL AND ga_page_data_t.field021 IS NOT NULL)
                OR (ga_table_data[p_i].field021 IS NOT NULL AND ga_page_data_t.field021 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field021 END IF
       WHEN  22 IF (ga_table_data[p_i].field022 <> ga_page_data_t.field022 AND ((ga_table_data[p_i].field022 IS NOT NULL AND ga_page_data_t.field022 IS NOT NULL) OR (ga_table_data[p_i].field022 IS NULL AND ga_page_data_t.field022 IS NOT NULL) OR (ga_table_data[p_i].field022 IS NOT NULL AND ga_page_data_t.field022 IS NULL))) 
                OR (ga_table_data[p_i].field022 IS NULL AND ga_page_data_t.field022 IS NOT NULL)
                OR (ga_table_data[p_i].field022 IS NOT NULL AND ga_page_data_t.field022 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field022 END IF  
       WHEN  23 IF (ga_table_data[p_i].field023 <> ga_page_data_t.field023 AND ((ga_table_data[p_i].field023 IS NOT NULL AND ga_page_data_t.field023 IS NOT NULL) OR (ga_table_data[p_i].field023 IS NULL AND ga_page_data_t.field023 IS NOT NULL) OR (ga_table_data[p_i].field023 IS NOT NULL AND ga_page_data_t.field023 IS NULL))) 
                OR (ga_table_data[p_i].field023 IS NULL AND ga_page_data_t.field023 IS NOT NULL)
                OR (ga_table_data[p_i].field023 IS NOT NULL AND ga_page_data_t.field023 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field023 END IF 
       WHEN  24 IF (ga_table_data[p_i].field024 <> ga_page_data_t.field024 AND ((ga_table_data[p_i].field024 IS NOT NULL AND ga_page_data_t.field024 IS NOT NULL) OR (ga_table_data[p_i].field024 IS NULL AND ga_page_data_t.field024 IS NOT NULL) OR (ga_table_data[p_i].field024 IS NOT NULL AND ga_page_data_t.field024 IS NULL))) 
                OR (ga_table_data[p_i].field024 IS NULL AND ga_page_data_t.field024 IS NOT NULL)
                OR (ga_table_data[p_i].field024 IS NOT NULL AND ga_page_data_t.field024 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field024 END IF 
       WHEN  25 IF (ga_table_data[p_i].field025 <> ga_page_data_t.field025 AND ((ga_table_data[p_i].field025 IS NOT NULL AND ga_page_data_t.field025 IS NOT NULL) OR (ga_table_data[p_i].field025 IS NULL AND ga_page_data_t.field025 IS NOT NULL) OR (ga_table_data[p_i].field025 IS NOT NULL AND ga_page_data_t.field025 IS NULL))) 
                OR (ga_table_data[p_i].field025 IS NULL AND ga_page_data_t.field025 IS NOT NULL)
                OR (ga_table_data[p_i].field025 IS NOT NULL AND ga_page_data_t.field025 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field025 END IF 
       WHEN  26 IF (ga_table_data[p_i].field026 <> ga_page_data_t.field026 AND ((ga_table_data[p_i].field026 IS NOT NULL AND ga_page_data_t.field026 IS NOT NULL) OR (ga_table_data[p_i].field026 IS NULL AND ga_page_data_t.field026 IS NOT NULL) OR (ga_table_data[p_i].field026 IS NOT NULL AND ga_page_data_t.field026 IS NULL))) 
                OR (ga_table_data[p_i].field026 IS NULL AND ga_page_data_t.field026 IS NOT NULL)
                OR (ga_table_data[p_i].field026 IS NOT NULL AND ga_page_data_t.field026 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field026 END IF 
       WHEN  27 IF (ga_table_data[p_i].field027 <> ga_page_data_t.field027 AND ((ga_table_data[p_i].field027 IS NOT NULL AND ga_page_data_t.field027 IS NOT NULL) OR (ga_table_data[p_i].field027 IS NULL AND ga_page_data_t.field027 IS NOT NULL) OR (ga_table_data[p_i].field027 IS NOT NULL AND ga_page_data_t.field027 IS NULL))) 
                OR (ga_table_data[p_i].field027 IS NULL AND ga_page_data_t.field027 IS NOT NULL)
                OR (ga_table_data[p_i].field027 IS NOT NULL AND ga_page_data_t.field027 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field027 END IF 
       WHEN  28 IF (ga_table_data[p_i].field028 <> ga_page_data_t.field028 AND ((ga_table_data[p_i].field028 IS NOT NULL AND ga_page_data_t.field028 IS NOT NULL) OR (ga_table_data[p_i].field028 IS NULL AND ga_page_data_t.field028 IS NOT NULL) OR (ga_table_data[p_i].field028 IS NOT NULL AND ga_page_data_t.field028 IS NULL))) 
                OR (ga_table_data[p_i].field028 IS NULL AND ga_page_data_t.field028 IS NOT NULL)
                OR (ga_table_data[p_i].field028 IS NOT NULL AND ga_page_data_t.field028 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field028 END IF 
       WHEN  29 IF (ga_table_data[p_i].field029 <> ga_page_data_t.field029 AND ((ga_table_data[p_i].field029 IS NOT NULL AND ga_page_data_t.field029 IS NOT NULL) OR(ga_table_data[p_i].field029 IS NULL AND ga_page_data_t.field029 IS NOT NULL) OR (ga_table_data[p_i].field029 IS NOT NULL AND ga_page_data_t.field029 IS NULL))) 
                OR (ga_table_data[p_i].field029 IS NULL AND ga_page_data_t.field029 IS NOT NULL)
                OR (ga_table_data[p_i].field029 IS NOT NULL AND ga_page_data_t.field029 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field029 END IF 

       WHEN   30 IF (ga_table_data[p_i].field030 <> ga_page_data_t.field030 AND ((ga_table_data[p_i].field030 IS NOT NULL AND ga_page_data_t.field030 IS NOT NULL) OR (ga_table_data[p_i].field030 IS NULL AND ga_page_data_t.field030 IS NOT NULL) OR (ga_table_data[p_i].field030 IS NOT NULL AND ga_page_data_t.field030 IS NULL))) 
                OR (ga_table_data[p_i].field030 IS NULL AND ga_page_data_t.field030 IS NOT NULL)
                OR (ga_table_data[p_i].field030 IS NOT NULL AND ga_page_data_t.field030 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field030 END IF  
       WHEN   31 IF (ga_table_data[p_i].field031 <> ga_page_data_t.field031 AND ((ga_table_data[p_i].field031 IS NOT NULL AND ga_page_data_t.field031 IS NOT NULL) OR (ga_table_data[p_i].field031 IS NULL AND ga_page_data_t.field031 IS NOT NULL) OR (ga_table_data[p_i].field031 IS NOT NULL AND ga_page_data_t.field031 IS NULL))) 
                OR (ga_table_data[p_i].field031 IS NULL AND ga_page_data_t.field031 IS NOT NULL)
                OR (ga_table_data[p_i].field031 IS NOT NULL AND ga_page_data_t.field031 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field031 END IF
       WHEN   32 IF (ga_table_data[p_i].field032 <> ga_page_data_t.field032 AND ((ga_table_data[p_i].field032 IS NOT NULL AND ga_page_data_t.field032 IS NOT NULL) OR(ga_table_data[p_i].field032 IS NULL AND ga_page_data_t.field032 IS NOT NULL) OR (ga_table_data[p_i].field032 IS NOT NULL AND ga_page_data_t.field032 IS NULL))) 
                OR (ga_table_data[p_i].field032 IS NULL AND ga_page_data_t.field032 IS NOT NULL)
                OR (ga_table_data[p_i].field032 IS NOT NULL AND ga_page_data_t.field032 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field032 END IF  
       WHEN   33 IF (ga_table_data[p_i].field033 <> ga_page_data_t.field033 AND ((ga_table_data[p_i].field033 IS NOT NULL AND ga_page_data_t.field033 IS NOT NULL) OR(ga_table_data[p_i].field033 IS NULL AND ga_page_data_t.field033 IS NOT NULL) OR (ga_table_data[p_i].field033 IS NOT NULL AND ga_page_data_t.field033 IS NULL))) 
                OR (ga_table_data[p_i].field033 IS NULL AND ga_page_data_t.field033 IS NOT NULL)
                OR (ga_table_data[p_i].field033 IS NOT NULL AND ga_page_data_t.field033 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field033 END IF 
       WHEN   34 IF (ga_table_data[p_i].field034 <> ga_page_data_t.field034 AND ((ga_table_data[p_i].field034 IS NOT NULL AND ga_page_data_t.field034 IS NOT NULL) OR (ga_table_data[p_i].field034 IS NULL AND ga_page_data_t.field034 IS NOT NULL) OR (ga_table_data[p_i].field034 IS NOT NULL AND ga_page_data_t.field034 IS NULL))) 
                OR (ga_table_data[p_i].field034 IS NULL AND ga_page_data_t.field034 IS NOT NULL)
                OR (ga_table_data[p_i].field034 IS NOT NULL AND ga_page_data_t.field034 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field034 END IF 
       WHEN   35 IF (ga_table_data[p_i].field035 <> ga_page_data_t.field035 AND ((ga_table_data[p_i].field035 IS NOT NULL AND ga_page_data_t.field035 IS NOT NULL) OR (ga_table_data[p_i].field035 IS NULL AND ga_page_data_t.field035 IS NOT NULL) OR (ga_table_data[p_i].field035 IS NOT NULL AND ga_page_data_t.field035 IS NULL))) 
                OR (ga_table_data[p_i].field035 IS NULL AND ga_page_data_t.field035 IS NOT NULL)
                OR (ga_table_data[p_i].field035 IS NOT NULL AND ga_page_data_t.field035 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field035 END IF 
       WHEN   36 IF (ga_table_data[p_i].field036 <> ga_page_data_t.field036 AND ((ga_table_data[p_i].field036 IS NOT NULL AND ga_page_data_t.field036 IS NOT NULL) OR (ga_table_data[p_i].field036 IS NULL AND ga_page_data_t.field036 IS NOT NULL) OR (ga_table_data[p_i].field036 IS NOT NULL AND ga_page_data_t.field036 IS NULL))) 
                OR (ga_table_data[p_i].field036 IS NULL AND ga_page_data_t.field036 IS NOT NULL)
                OR (ga_table_data[p_i].field036 IS NOT NULL AND ga_page_data_t.field036 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field036 END IF 
       WHEN   37 IF (ga_table_data[p_i].field037 <> ga_page_data_t.field037 AND ((ga_table_data[p_i].field037 IS NOT NULL AND ga_page_data_t.field037 IS NOT NULL) OR (ga_table_data[p_i].field037 IS NULL AND ga_page_data_t.field037 IS NOT NULL) OR (ga_table_data[p_i].field037 IS NOT NULL AND ga_page_data_t.field037 IS NULL))) 
                OR (ga_table_data[p_i].field037 IS NULL AND ga_page_data_t.field037 IS NOT NULL)
                OR (ga_table_data[p_i].field037 IS NOT NULL AND ga_page_data_t.field037 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field037 END IF 
       WHEN   38 IF (ga_table_data[p_i].field038 <> ga_page_data_t.field038 AND ((ga_table_data[p_i].field038 IS NOT NULL AND ga_page_data_t.field038 IS NOT NULL) OR (ga_table_data[p_i].field038 IS NULL AND ga_page_data_t.field038 IS NOT NULL) OR (ga_table_data[p_i].field038 IS NOT NULL AND ga_page_data_t.field038 IS NULL))) 
                OR (ga_table_data[p_i].field038 IS NULL AND ga_page_data_t.field038 IS NOT NULL)
                OR (ga_table_data[p_i].field038 IS NOT NULL AND ga_page_data_t.field038 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field038 END IF 
       WHEN   39 IF (ga_table_data[p_i].field039 <> ga_page_data_t.field039 AND ((ga_table_data[p_i].field039 IS NOT NULL AND ga_page_data_t.field039 IS NOT NULL) OR (ga_table_data[p_i].field039 IS NULL AND ga_page_data_t.field039 IS NOT NULL) OR (ga_table_data[p_i].field039 IS NOT NULL AND ga_page_data_t.field039 IS NULL))) 
                OR (ga_table_data[p_i].field039 IS NULL AND ga_page_data_t.field039 IS NOT NULL)
                OR (ga_table_data[p_i].field039 IS NOT NULL AND ga_page_data_t.field039 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field039 END IF 
     
     WHEN   40 IF (ga_table_data[p_i].field040 <> ga_page_data_t.field040 AND ((ga_table_data[p_i].field040 IS NOT NULL AND ga_page_data_t.field040 IS NOT NULL) OR (ga_table_data[p_i].field040 IS NULL AND ga_page_data_t.field040 IS NOT NULL) OR (ga_table_data[p_i].field040 IS NOT NULL AND ga_page_data_t.field040 IS NULL))) 
                OR (ga_table_data[p_i].field040 IS NULL AND ga_page_data_t.field040 IS NOT NULL)
                OR (ga_table_data[p_i].field040 IS NOT NULL AND ga_page_data_t.field040 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field040 END IF  
       WHEN   41 IF (ga_table_data[p_i].field041 <> ga_page_data_t.field041 AND ((ga_table_data[p_i].field041 IS NOT NULL AND ga_page_data_t.field041 IS NOT NULL) OR (ga_table_data[p_i].field041 IS NULL AND ga_page_data_t.field041 IS NOT NULL) OR (ga_table_data[p_i].field041 IS NOT NULL AND ga_page_data_t.field041 IS NULL))) 
                OR (ga_table_data[p_i].field041 IS NULL AND ga_page_data_t.field041 IS NOT NULL)
                OR (ga_table_data[p_i].field041 IS NOT NULL AND ga_page_data_t.field041 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field041 END IF
       WHEN   42 IF (ga_table_data[p_i].field042 <> ga_page_data_t.field042 AND ((ga_table_data[p_i].field042 IS NOT NULL AND ga_page_data_t.field042 IS NOT NULL) OR (ga_table_data[p_i].field042 IS NULL AND ga_page_data_t.field042 IS NOT NULL) OR (ga_table_data[p_i].field042 IS NOT NULL AND ga_page_data_t.field042 IS NULL))) 
                OR (ga_table_data[p_i].field042 IS NULL AND ga_page_data_t.field042 IS NOT NULL)
                OR (ga_table_data[p_i].field042 IS NOT NULL AND ga_page_data_t.field042 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field042 END IF  
       WHEN   43 IF (ga_table_data[p_i].field043 <> ga_page_data_t.field043 AND ((ga_table_data[p_i].field043 IS NOT NULL AND ga_page_data_t.field043 IS NOT NULL) OR (ga_table_data[p_i].field043 IS NULL AND ga_page_data_t.field043 IS NOT NULL) OR (ga_table_data[p_i].field043 IS NOT NULL AND ga_page_data_t.field043 IS NULL))) 
                OR (ga_table_data[p_i].field043 IS NULL AND ga_page_data_t.field043 IS NOT NULL)
                OR (ga_table_data[p_i].field043 IS NOT NULL AND ga_page_data_t.field043 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field043 END IF 
       WHEN   44 IF (ga_table_data[p_i].field044 <> ga_page_data_t.field044 AND ((ga_table_data[p_i].field044 IS NOT NULL AND ga_page_data_t.field044 IS NOT NULL) OR (ga_table_data[p_i].field044 IS NULL AND ga_page_data_t.field044 IS NOT NULL) OR (ga_table_data[p_i].field044 IS NOT NULL AND ga_page_data_t.field044 IS NULL))) 
                OR (ga_table_data[p_i].field044 IS NULL AND ga_page_data_t.field044 IS NOT NULL)
                OR (ga_table_data[p_i].field044 IS NOT NULL AND ga_page_data_t.field044 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field044 END IF 
       WHEN   45 IF (ga_table_data[p_i].field045 <> ga_page_data_t.field045 AND ((ga_table_data[p_i].field045 IS NOT NULL AND ga_page_data_t.field045 IS NOT NULL) OR(ga_table_data[p_i].field045 IS NULL AND ga_page_data_t.field045 IS NOT NULL) OR (ga_table_data[p_i].field045 IS NOT NULL AND ga_page_data_t.field045 IS NULL))) 
                OR (ga_table_data[p_i].field045 IS NULL AND ga_page_data_t.field045 IS NOT NULL)
                OR (ga_table_data[p_i].field045 IS NOT NULL AND ga_page_data_t.field045 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field045 END IF 
       WHEN   46 IF (ga_table_data[p_i].field046 <> ga_page_data_t.field046 AND ((ga_table_data[p_i].field046 IS NOT NULL AND ga_page_data_t.field046 IS NOT NULL) OR (ga_table_data[p_i].field046 IS NULL AND ga_page_data_t.field046 IS NOT NULL) OR (ga_table_data[p_i].field046 IS NOT NULL AND ga_page_data_t.field046 IS NULL))) 
                OR (ga_table_data[p_i].field046 IS NULL AND ga_page_data_t.field046 IS NOT NULL)
                OR (ga_table_data[p_i].field046 IS NOT NULL AND ga_page_data_t.field046 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field046 END IF 
       WHEN   47 IF (ga_table_data[p_i].field047 <> ga_page_data_t.field047 AND ((ga_table_data[p_i].field047 IS NOT NULL AND ga_page_data_t.field047 IS NOT NULL) OR(ga_table_data[p_i].field047 IS NULL AND ga_page_data_t.field047 IS NOT NULL) OR (ga_table_data[p_i].field047 IS NOT NULL AND ga_page_data_t.field047 IS NULL))) 
                OR (ga_table_data[p_i].field047 IS NULL AND ga_page_data_t.field047 IS NOT NULL)
                OR (ga_table_data[p_i].field047 IS NOT NULL AND ga_page_data_t.field047 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field047 END IF 
       WHEN   48 IF (ga_table_data[p_i].field048 <> ga_page_data_t.field048 AND ((ga_table_data[p_i].field048 IS NOT NULL AND ga_page_data_t.field048 IS NOT NULL) OR (ga_table_data[p_i].field048 IS NULL AND ga_page_data_t.field048 IS NOT NULL) OR (ga_table_data[p_i].field048 IS NOT NULL AND ga_page_data_t.field048 IS NULL))) 
                OR (ga_table_data[p_i].field048 IS NULL AND ga_page_data_t.field048 IS NOT NULL)
                OR (ga_table_data[p_i].field048 IS NOT NULL AND ga_page_data_t.field048 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field048 END IF 
       WHEN   49 IF (ga_table_data[p_i].field049 <> ga_page_data_t.field049 AND ((ga_table_data[p_i].field049 IS NOT NULL AND ga_page_data_t.field049 IS NOT NULL) OR (ga_table_data[p_i].field049 IS NULL AND ga_page_data_t.field049 IS NOT NULL) OR (ga_table_data[p_i].field049 IS NOT NULL AND ga_page_data_t.field049 IS NULL))) 
                OR (ga_table_data[p_i].field049 IS NULL AND ga_page_data_t.field049 IS NOT NULL)
                OR (ga_table_data[p_i].field049 IS NOT NULL AND ga_page_data_t.field049 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field049 END IF 
              
       WHEN  50 IF (ga_table_data[p_i].field050 <> ga_page_data_t.field050 AND ((ga_table_data[p_i].field050 IS NOT NULL AND ga_page_data_t.field050 IS NOT NULL) OR (ga_table_data[p_i].field050 IS NULL AND ga_page_data_t.field050 IS NOT NULL) OR (ga_table_data[p_i].field050 IS NOT NULL AND ga_page_data_t.field050 IS NULL))) 
                OR (ga_table_data[p_i].field050 IS NULL AND ga_page_data_t.field050 IS NOT NULL)
                OR (ga_table_data[p_i].field050 IS NOT NULL AND ga_page_data_t.field050 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field050 END IF  
       WHEN  51 IF (ga_table_data[p_i].field051 <> ga_page_data_t.field051 AND ((ga_table_data[p_i].field051 IS NOT NULL AND ga_page_data_t.field051 IS NOT NULL) OR (ga_table_data[p_i].field051 IS NULL AND ga_page_data_t.field051 IS NOT NULL) OR (ga_table_data[p_i].field051 IS NOT NULL AND ga_page_data_t.field051 IS NULL))) 
                OR (ga_table_data[p_i].field051 IS NULL AND ga_page_data_t.field051 IS NOT NULL)
                OR (ga_table_data[p_i].field051 IS NOT NULL AND ga_page_data_t.field051 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field051 END IF
       WHEN  52 IF (ga_table_data[p_i].field052 <> ga_page_data_t.field052 AND ((ga_table_data[p_i].field052 IS NOT NULL AND ga_page_data_t.field052 IS NOT NULL) OR(ga_table_data[p_i].field052 IS NULL AND ga_page_data_t.field052 IS NOT NULL) OR (ga_table_data[p_i].field052 IS NOT NULL AND ga_page_data_t.field052 IS NULL))) 
                OR (ga_table_data[p_i].field052 IS NULL AND ga_page_data_t.field052 IS NOT NULL)
                OR (ga_table_data[p_i].field052 IS NOT NULL AND ga_page_data_t.field052 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field052 END IF  
       WHEN  53 IF (ga_table_data[p_i].field053 <> ga_page_data_t.field053 AND ((ga_table_data[p_i].field053 IS NOT NULL AND ga_page_data_t.field053 IS NOT NULL) OR(ga_table_data[p_i].field053 IS NULL AND ga_page_data_t.field053 IS NOT NULL) OR (ga_table_data[p_i].field053 IS NOT NULL AND ga_page_data_t.field053 IS NULL))) 
                OR (ga_table_data[p_i].field053 IS NULL AND ga_page_data_t.field053 IS NOT NULL)
                OR (ga_table_data[p_i].field053 IS NOT NULL AND ga_page_data_t.field053 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field053 END IF 
       WHEN  54 IF (ga_table_data[p_i].field054 <> ga_page_data_t.field054 AND ((ga_table_data[p_i].field054 IS NOT NULL AND ga_page_data_t.field054 IS NOT NULL) OR (ga_table_data[p_i].field054 IS NULL AND ga_page_data_t.field054 IS NOT NULL) OR (ga_table_data[p_i].field054 IS NOT NULL AND ga_page_data_t.field054 IS NULL))) 
                OR (ga_table_data[p_i].field054 IS NULL AND ga_page_data_t.field054 IS NOT NULL)
                OR (ga_table_data[p_i].field054 IS NOT NULL AND ga_page_data_t.field054 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field054 END IF 
       WHEN  55 IF (ga_table_data[p_i].field055 <> ga_page_data_t.field055 AND ((ga_table_data[p_i].field055 IS NOT NULL AND ga_page_data_t.field055 IS NOT NULL) OR (ga_table_data[p_i].field055 IS NULL AND ga_page_data_t.field055 IS NOT NULL) OR (ga_table_data[p_i].field055 IS NOT NULL AND ga_page_data_t.field055 IS NULL))) 
                OR (ga_table_data[p_i].field055 IS NULL AND ga_page_data_t.field055 IS NOT NULL)
                OR (ga_table_data[p_i].field055 IS NOT NULL AND ga_page_data_t.field055 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field055 END IF 
       WHEN  56 IF (ga_table_data[p_i].field056 <> ga_page_data_t.field056 AND ((ga_table_data[p_i].field056 IS NOT NULL AND ga_page_data_t.field056 IS NOT NULL) OR (ga_table_data[p_i].field056 IS NULL AND ga_page_data_t.field056 IS NOT NULL) OR (ga_table_data[p_i].field056 IS NOT NULL AND ga_page_data_t.field056 IS NULL))) 
                OR (ga_table_data[p_i].field056 IS NULL AND ga_page_data_t.field056 IS NOT NULL)
                OR (ga_table_data[p_i].field056 IS NOT NULL AND ga_page_data_t.field056 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field056 END IF 
       WHEN  57 IF (ga_table_data[p_i].field057 <> ga_page_data_t.field057 AND ((ga_table_data[p_i].field057 IS NOT NULL AND ga_page_data_t.field057 IS NOT NULL) OR (ga_table_data[p_i].field057 IS NULL AND ga_page_data_t.field057 IS NOT NULL) OR (ga_table_data[p_i].field057 IS NOT NULL AND ga_page_data_t.field057 IS NULL))) 
                OR (ga_table_data[p_i].field057 IS NULL AND ga_page_data_t.field057 IS NOT NULL)
                OR (ga_table_data[p_i].field057 IS NOT NULL AND ga_page_data_t.field057 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field057 END IF 
       WHEN  58 IF (ga_table_data[p_i].field058 <> ga_page_data_t.field058 AND ((ga_table_data[p_i].field058 IS NOT NULL AND ga_page_data_t.field058 IS NOT NULL) OR (ga_table_data[p_i].field058 IS NULL AND ga_page_data_t.field058 IS NOT NULL) OR (ga_table_data[p_i].field058 IS NOT NULL AND ga_page_data_t.field058 IS NULL))) 
                OR (ga_table_data[p_i].field058 IS NULL AND ga_page_data_t.field058 IS NOT NULL)
                OR (ga_table_data[p_i].field058 IS NOT NULL AND ga_page_data_t.field058 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field058 END IF 
       WHEN  59 IF (ga_table_data[p_i].field059 <> ga_page_data_t.field059 AND ((ga_table_data[p_i].field059 IS NOT NULL AND ga_page_data_t.field059 IS NOT NULL) OR (ga_table_data[p_i].field059 IS NULL AND ga_page_data_t.field059 IS NOT NULL) OR (ga_table_data[p_i].field059 IS NOT NULL AND ga_page_data_t.field059 IS NULL))) 
                OR (ga_table_data[p_i].field059 IS NULL AND ga_page_data_t.field059 IS NOT NULL)
                OR (ga_table_data[p_i].field059 IS NOT NULL AND ga_page_data_t.field059 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field059 END IF 
              
      WHEN  60 IF (ga_table_data[p_i].field060 <> ga_page_data_t.field060 AND ((ga_table_data[p_i].field060 IS NOT NULL AND ga_page_data_t.field060 IS NOT NULL) OR(ga_table_data[p_i].field060 IS NULL AND ga_page_data_t.field060 IS NOT NULL) OR (ga_table_data[p_i].field060 IS NOT NULL AND ga_page_data_t.field060 IS NULL))) 
                OR (ga_table_data[p_i].field060 IS NULL AND ga_page_data_t.field060 IS NOT NULL)
                OR (ga_table_data[p_i].field060 IS NOT NULL AND ga_page_data_t.field060 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field060 END IF  
       WHEN  61 IF (ga_table_data[p_i].field061 <> ga_page_data_t.field061 AND ((ga_table_data[p_i].field061 IS NOT NULL AND ga_page_data_t.field061 IS NOT NULL) OR(ga_table_data[p_i].field061 IS NULL AND ga_page_data_t.field061 IS NOT NULL) OR (ga_table_data[p_i].field061 IS NOT NULL AND ga_page_data_t.field061 IS NULL))) 
                OR (ga_table_data[p_i].field061 IS NULL AND ga_page_data_t.field061 IS NOT NULL)
                OR (ga_table_data[p_i].field061 IS NOT NULL AND ga_page_data_t.field061 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field061 END IF
       WHEN  62 IF (ga_table_data[p_i].field062 <> ga_page_data_t.field062 AND ((ga_table_data[p_i].field062 IS NOT NULL AND ga_page_data_t.field062 IS NOT NULL) OR(ga_table_data[p_i].field062 IS NULL AND ga_page_data_t.field062 IS NOT NULL) OR (ga_table_data[p_i].field062 IS NOT NULL AND ga_page_data_t.field062 IS NULL))) 
                OR (ga_table_data[p_i].field062 IS NULL AND ga_page_data_t.field062 IS NOT NULL)
                OR (ga_table_data[p_i].field062 IS NOT NULL AND ga_page_data_t.field062 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field062 END IF  
       WHEN  63 IF (ga_table_data[p_i].field063 <> ga_page_data_t.field063 AND ((ga_table_data[p_i].field063 IS NOT NULL AND ga_page_data_t.field063 IS NOT NULL) OR (ga_table_data[p_i].field063 IS NULL AND ga_page_data_t.field063 IS NOT NULL) OR (ga_table_data[p_i].field063 IS NOT NULL AND ga_page_data_t.field063 IS NULL))) 
                OR (ga_table_data[p_i].field063 IS NULL AND ga_page_data_t.field063 IS NOT NULL)
                OR (ga_table_data[p_i].field063 IS NOT NULL AND ga_page_data_t.field063 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field063 END IF 
       WHEN  64 IF (ga_table_data[p_i].field064 <> ga_page_data_t.field064 AND ((ga_table_data[p_i].field064 IS NOT NULL AND ga_page_data_t.field064 IS NOT NULL) OR (ga_table_data[p_i].field064 IS NULL AND ga_page_data_t.field064 IS NOT NULL) OR (ga_table_data[p_i].field064 IS NOT NULL AND ga_page_data_t.field064 IS NULL))) 
                OR (ga_table_data[p_i].field064 IS NULL AND ga_page_data_t.field064 IS NOT NULL)
                OR (ga_table_data[p_i].field064 IS NOT NULL AND ga_page_data_t.field064 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field064 END IF 
       WHEN  65 IF (ga_table_data[p_i].field065 <> ga_page_data_t.field065 AND ((ga_table_data[p_i].field065 IS NOT NULL AND ga_page_data_t.field065 IS NOT NULL) OR (ga_table_data[p_i].field065 IS NULL AND ga_page_data_t.field065 IS NOT NULL) OR (ga_table_data[p_i].field065 IS NOT NULL AND ga_page_data_t.field065 IS NULL))) 
                OR (ga_table_data[p_i].field065 IS NULL AND ga_page_data_t.field065 IS NOT NULL)
                OR (ga_table_data[p_i].field065 IS NOT NULL AND ga_page_data_t.field065 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field065 END IF 
       WHEN  66 IF (ga_table_data[p_i].field066 <> ga_page_data_t.field066 AND ((ga_table_data[p_i].field066 IS NOT NULL AND ga_page_data_t.field066 IS NOT NULL) OR (ga_table_data[p_i].field066 IS NULL AND ga_page_data_t.field066 IS NOT NULL) OR (ga_table_data[p_i].field066 IS NOT NULL AND ga_page_data_t.field066 IS NULL))) 
                OR (ga_table_data[p_i].field066 IS NULL AND ga_page_data_t.field066 IS NOT NULL)
                OR (ga_table_data[p_i].field066 IS NOT NULL AND ga_page_data_t.field066 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field066 END IF 
       WHEN  67 IF (ga_table_data[p_i].field067 <> ga_page_data_t.field067 AND ((ga_table_data[p_i].field067 IS NOT NULL AND ga_page_data_t.field067 IS NOT NULL) OR (ga_table_data[p_i].field067 IS NULL AND ga_page_data_t.field067 IS NOT NULL) OR (ga_table_data[p_i].field067 IS NOT NULL AND ga_page_data_t.field067 IS NULL))) 
                OR (ga_table_data[p_i].field067 IS NULL AND ga_page_data_t.field067 IS NOT NULL)
                OR (ga_table_data[p_i].field067 IS NOT NULL AND ga_page_data_t.field067 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field067 END IF 
       WHEN  68 IF (ga_table_data[p_i].field068 <> ga_page_data_t.field068 AND ((ga_table_data[p_i].field068 IS NOT NULL AND ga_page_data_t.field068 IS NOT NULL) OR (ga_table_data[p_i].field068 IS NULL AND ga_page_data_t.field068 IS NOT NULL) OR (ga_table_data[p_i].field068 IS NOT NULL AND ga_page_data_t.field068 IS NULL))) 
                OR (ga_table_data[p_i].field068 IS NULL AND ga_page_data_t.field068 IS NOT NULL)
                OR (ga_table_data[p_i].field068 IS NOT NULL AND ga_page_data_t.field068 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field068 END IF 
       WHEN  69 IF (ga_table_data[p_i].field069 <> ga_page_data_t.field069 AND ((ga_table_data[p_i].field069 IS NOT NULL AND ga_page_data_t.field069 IS NOT NULL) OR (ga_table_data[p_i].field069 IS NULL AND ga_page_data_t.field069 IS NOT NULL) OR (ga_table_data[p_i].field069 IS NOT NULL AND ga_page_data_t.field069 IS NULL))) 
                OR (ga_table_data[p_i].field069 IS NULL AND ga_page_data_t.field069 IS NOT NULL)
                OR (ga_table_data[p_i].field069 IS NOT NULL AND ga_page_data_t.field069 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field069 END IF 
   
      WHEN  70 IF (ga_table_data[p_i].field070 <> ga_page_data_t.field070 AND ((ga_table_data[p_i].field070 IS NOT NULL AND ga_page_data_t.field070 IS NOT NULL) OR(ga_table_data[p_i].field070 IS NULL AND ga_page_data_t.field070 IS NOT NULL) OR (ga_table_data[p_i].field070 IS NOT NULL AND ga_page_data_t.field070 IS NULL))) 
                OR (ga_table_data[p_i].field070 IS NULL AND ga_page_data_t.field070 IS NOT NULL)
                OR (ga_table_data[p_i].field070 IS NOT NULL AND ga_page_data_t.field070 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field070 END IF  
       WHEN  71 IF (ga_table_data[p_i].field071 <> ga_page_data_t.field071 AND ((ga_table_data[p_i].field071 IS NOT NULL AND ga_page_data_t.field071 IS NOT NULL) OR (ga_table_data[p_i].field071 IS NULL AND ga_page_data_t.field071 IS NOT NULL) OR (ga_table_data[p_i].field071 IS NOT NULL AND ga_page_data_t.field071 IS NULL))) 
                OR (ga_table_data[p_i].field071 IS NULL AND ga_page_data_t.field071 IS NOT NULL)
                OR (ga_table_data[p_i].field071 IS NOT NULL AND ga_page_data_t.field071 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field071 END IF
       WHEN  72 IF (ga_table_data[p_i].field072 <> ga_page_data_t.field072 AND ((ga_table_data[p_i].field072 IS NOT NULL AND ga_page_data_t.field072 IS NOT NULL) OR (ga_table_data[p_i].field072 IS NULL AND ga_page_data_t.field072 IS NOT NULL) OR (ga_table_data[p_i].field072 IS NOT NULL AND ga_page_data_t.field072 IS NULL))) 
                OR (ga_table_data[p_i].field072 IS NULL AND ga_page_data_t.field072 IS NOT NULL)
                OR (ga_table_data[p_i].field072 IS NOT NULL AND ga_page_data_t.field072 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field072 END IF  
       WHEN  73 IF (ga_table_data[p_i].field073 <> ga_page_data_t.field073 AND ((ga_table_data[p_i].field073 IS NOT NULL AND ga_page_data_t.field073 IS NOT NULL) OR (ga_table_data[p_i].field073 IS NULL AND ga_page_data_t.field073 IS NOT NULL) OR (ga_table_data[p_i].field073 IS NOT NULL AND ga_page_data_t.field073 IS NULL))) 
                OR (ga_table_data[p_i].field073 IS NULL AND ga_page_data_t.field073 IS NOT NULL)
                OR (ga_table_data[p_i].field073 IS NOT NULL AND ga_page_data_t.field073 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field073 END IF 
       WHEN  74 IF (ga_table_data[p_i].field074 <> ga_page_data_t.field074 AND ((ga_table_data[p_i].field074 IS NOT NULL AND ga_page_data_t.field074 IS NOT NULL) OR (ga_table_data[p_i].field074 IS NULL AND ga_page_data_t.field074 IS NOT NULL) OR (ga_table_data[p_i].field074 IS NOT NULL AND ga_page_data_t.field074 IS NULL))) 
                OR (ga_table_data[p_i].field074 IS NULL AND ga_page_data_t.field074 IS NOT NULL)
                OR (ga_table_data[p_i].field074 IS NOT NULL AND ga_page_data_t.field074 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field074 END IF 
       WHEN  75 IF (ga_table_data[p_i].field075 <> ga_page_data_t.field075 AND ((ga_table_data[p_i].field075 IS NOT NULL AND ga_page_data_t.field075 IS NOT NULL) OR (ga_table_data[p_i].field075 IS NULL AND ga_page_data_t.field075 IS NOT NULL) OR (ga_table_data[p_i].field075 IS NOT NULL AND ga_page_data_t.field075 IS NULL))) 
                OR (ga_table_data[p_i].field075 IS NULL AND ga_page_data_t.field075 IS NOT NULL)
                OR (ga_table_data[p_i].field075 IS NOT NULL AND ga_page_data_t.field075 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field075 END IF 
       WHEN  76 IF (ga_table_data[p_i].field076 <> ga_page_data_t.field076 AND ((ga_table_data[p_i].field076 IS NOT NULL AND ga_page_data_t.field076 IS NOT NULL) OR(ga_table_data[p_i].field076 IS NULL AND ga_page_data_t.field076 IS NOT NULL) OR (ga_table_data[p_i].field076 IS NOT NULL AND ga_page_data_t.field076 IS NULL))) 
                OR (ga_table_data[p_i].field076 IS NULL AND ga_page_data_t.field076 IS NOT NULL)
                OR (ga_table_data[p_i].field076 IS NOT NULL AND ga_page_data_t.field076 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field076 END IF 
       WHEN  77 IF (ga_table_data[p_i].field077 <> ga_page_data_t.field077 AND ((ga_table_data[p_i].field077 IS NOT NULL AND ga_page_data_t.field077 IS NOT NULL) OR(ga_table_data[p_i].field077 IS NULL AND ga_page_data_t.field077 IS NOT NULL) OR (ga_table_data[p_i].field077 IS NOT NULL AND ga_page_data_t.field077 IS NULL))) 
                OR (ga_table_data[p_i].field077 IS NULL AND ga_page_data_t.field077 IS NOT NULL)
                OR (ga_table_data[p_i].field077 IS NOT NULL AND ga_page_data_t.field077 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field077 END IF 
       WHEN  78 IF (ga_table_data[p_i].field078 <> ga_page_data_t.field078 AND ((ga_table_data[p_i].field078 IS NOT NULL AND ga_page_data_t.field078 IS NOT NULL) OR (ga_table_data[p_i].field078 IS NULL AND ga_page_data_t.field078 IS NOT NULL) OR (ga_table_data[p_i].field078 IS NOT NULL AND ga_page_data_t.field078 IS NULL))) 
                OR (ga_table_data[p_i].field078 IS NULL AND ga_page_data_t.field078 IS NOT NULL)
                OR (ga_table_data[p_i].field078 IS NOT NULL AND ga_page_data_t.field078 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field078 END IF 
       WHEN  79 IF (ga_table_data[p_i].field079 <> ga_page_data_t.field079 AND ((ga_table_data[p_i].field079 IS NOT NULL AND ga_page_data_t.field079 IS NOT NULL) OR (ga_table_data[p_i].field079 IS NULL AND ga_page_data_t.field079 IS NOT NULL) OR (ga_table_data[p_i].field079 IS NOT NULL AND ga_page_data_t.field079 IS NULL))) 
                OR (ga_table_data[p_i].field079 IS NULL AND ga_page_data_t.field079 IS NOT NULL)
                OR (ga_table_data[p_i].field079 IS NOT NULL AND ga_page_data_t.field079 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field079 END IF 
      
      WHEN  80 IF (ga_table_data[p_i].field080 <> ga_page_data_t.field080 AND ((ga_table_data[p_i].field080 IS NOT NULL AND ga_page_data_t.field080 IS NOT NULL) OR (ga_table_data[p_i].field080 IS NULL AND ga_page_data_t.field080 IS NOT NULL) OR (ga_table_data[p_i].field080 IS NOT NULL AND ga_page_data_t.field080 IS NULL))) 
                OR (ga_table_data[p_i].field080 IS NULL AND ga_page_data_t.field080 IS NOT NULL)
                OR (ga_table_data[p_i].field080 IS NOT NULL AND ga_page_data_t.field080 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field080 END IF  
       WHEN  81 IF (ga_table_data[p_i].field081 <> ga_page_data_t.field081 AND ((ga_table_data[p_i].field081 IS NOT NULL AND ga_page_data_t.field081 IS NOT NULL) OR (ga_table_data[p_i].field081 IS NULL AND ga_page_data_t.field081 IS NOT NULL) OR (ga_table_data[p_i].field081 IS NOT NULL AND ga_page_data_t.field081 IS NULL))) 
                OR (ga_table_data[p_i].field081 IS NULL AND ga_page_data_t.field081 IS NOT NULL)
                OR (ga_table_data[p_i].field081 IS NOT NULL AND ga_page_data_t.field081 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field081 END IF
       WHEN  82 IF (ga_table_data[p_i].field082 <> ga_page_data_t.field082 AND ((ga_table_data[p_i].field082 IS NOT NULL AND ga_page_data_t.field082 IS NOT NULL) OR (ga_table_data[p_i].field082 IS NULL AND ga_page_data_t.field082 IS NOT NULL) OR (ga_table_data[p_i].field082 IS NOT NULL AND ga_page_data_t.field082 IS NULL))) 
                OR (ga_table_data[p_i].field082 IS NULL AND ga_page_data_t.field082 IS NOT NULL)
                OR (ga_table_data[p_i].field082 IS NOT NULL AND ga_page_data_t.field082 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field082 END IF  
       WHEN  83 IF (ga_table_data[p_i].field083 <> ga_page_data_t.field083 AND ((ga_table_data[p_i].field083 IS NOT NULL AND ga_page_data_t.field083 IS NOT NULL) OR (ga_table_data[p_i].field083 IS NULL AND ga_page_data_t.field083 IS NOT NULL) OR (ga_table_data[p_i].field083 IS NOT NULL AND ga_page_data_t.field083 IS NULL))) 
                OR (ga_table_data[p_i].field083 IS NULL AND ga_page_data_t.field083 IS NOT NULL)
                OR (ga_table_data[p_i].field083 IS NOT NULL AND ga_page_data_t.field083 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field083 END IF 
       WHEN  84 IF (ga_table_data[p_i].field084 <> ga_page_data_t.field084 AND ((ga_table_data[p_i].field084 IS NOT NULL AND ga_page_data_t.field084 IS NOT NULL) OR(ga_table_data[p_i].field084 IS NULL AND ga_page_data_t.field084 IS NOT NULL) OR (ga_table_data[p_i].field084 IS NOT NULL AND ga_page_data_t.field084 IS NULL))) 
                OR (ga_table_data[p_i].field084 IS NULL AND ga_page_data_t.field084 IS NOT NULL)
                OR (ga_table_data[p_i].field084 IS NOT NULL AND ga_page_data_t.field084 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field084 END IF 
       WHEN  85 IF (ga_table_data[p_i].field085 <> ga_page_data_t.field085 AND ((ga_table_data[p_i].field085 IS NOT NULL AND ga_page_data_t.field085 IS NOT NULL) OR (ga_table_data[p_i].field085 IS NULL AND ga_page_data_t.field085 IS NOT NULL) OR (ga_table_data[p_i].field085 IS NOT NULL AND ga_page_data_t.field085 IS NULL))) 
                OR (ga_table_data[p_i].field085 IS NULL AND ga_page_data_t.field085 IS NOT NULL)
                OR (ga_table_data[p_i].field085 IS NOT NULL AND ga_page_data_t.field085 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field085 END IF 
       WHEN  86 IF (ga_table_data[p_i].field086 <> ga_page_data_t.field086 AND ((ga_table_data[p_i].field086 IS NOT NULL AND ga_page_data_t.field086 IS NOT NULL) OR (ga_table_data[p_i].field086 IS NULL AND ga_page_data_t.field086 IS NOT NULL) OR (ga_table_data[p_i].field086 IS NOT NULL AND ga_page_data_t.field086 IS NULL))) 
                OR (ga_table_data[p_i].field086 IS NULL AND ga_page_data_t.field086 IS NOT NULL)
                OR (ga_table_data[p_i].field086 IS NOT NULL AND ga_page_data_t.field086 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field086 END IF 
       WHEN  87 IF (ga_table_data[p_i].field087 <> ga_page_data_t.field087 AND ((ga_table_data[p_i].field087 IS NOT NULL AND ga_page_data_t.field087 IS NOT NULL) OR (ga_table_data[p_i].field087 IS NULL AND ga_page_data_t.field087 IS NOT NULL) OR (ga_table_data[p_i].field087 IS NOT NULL AND ga_page_data_t.field087 IS NULL))) 
                OR (ga_table_data[p_i].field087 IS NULL AND ga_page_data_t.field087 IS NOT NULL)
                OR (ga_table_data[p_i].field087 IS NOT NULL AND ga_page_data_t.field087 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field087 END IF 
       WHEN  88 IF (ga_table_data[p_i].field088 <> ga_page_data_t.field088 AND ((ga_table_data[p_i].field088 IS NOT NULL AND ga_page_data_t.field088 IS NOT NULL) OR (ga_table_data[p_i].field088 IS NULL AND ga_page_data_t.field088 IS NOT NULL) OR (ga_table_data[p_i].field088 IS NOT NULL AND ga_page_data_t.field088 IS NULL))) 
                OR (ga_table_data[p_i].field088 IS NULL AND ga_page_data_t.field088 IS NOT NULL)
                OR (ga_table_data[p_i].field088 IS NOT NULL AND ga_page_data_t.field088 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field088 END IF 
       WHEN  89 IF (ga_table_data[p_i].field089 <> ga_page_data_t.field089 AND ((ga_table_data[p_i].field089 IS NOT NULL AND ga_page_data_t.field089 IS NOT NULL) OR (ga_table_data[p_i].field089 IS NULL AND ga_page_data_t.field089 IS NOT NULL) OR (ga_table_data[p_i].field089 IS NOT NULL AND ga_page_data_t.field089 IS NULL))) 
                OR (ga_table_data[p_i].field089 IS NULL AND ga_page_data_t.field089 IS NOT NULL)
                OR (ga_table_data[p_i].field089 IS NOT NULL AND ga_page_data_t.field089 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field089 END IF 
     
      WHEN  90 IF (ga_table_data[p_i].field090 <> ga_page_data_t.field090 AND ((ga_table_data[p_i].field090 IS NOT NULL AND ga_page_data_t.field090 IS NOT NULL) OR (ga_table_data[p_i].field090 IS NULL AND ga_page_data_t.field090 IS NOT NULL) OR (ga_table_data[p_i].field090 IS NOT NULL AND ga_page_data_t.field090 IS NULL))) 
                OR (ga_table_data[p_i].field090 IS NULL AND ga_page_data_t.field090 IS NOT NULL)
                OR (ga_table_data[p_i].field090 IS NOT NULL AND ga_page_data_t.field090 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field090 END IF  
       WHEN  91 IF (ga_table_data[p_i].field091 <> ga_page_data_t.field091 AND ((ga_table_data[p_i].field091 IS NOT NULL AND ga_page_data_t.field091 IS NOT NULL) OR (ga_table_data[p_i].field091 IS NULL AND ga_page_data_t.field091 IS NOT NULL) OR (ga_table_data[p_i].field091 IS NOT NULL AND ga_page_data_t.field091 IS NULL))) 
                OR (ga_table_data[p_i].field091 IS NULL AND ga_page_data_t.field091 IS NOT NULL)
                OR (ga_table_data[p_i].field091 IS NOT NULL AND ga_page_data_t.field091 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field091 END IF
       WHEN  92 IF (ga_table_data[p_i].field092 <> ga_page_data_t.field092 AND ((ga_table_data[p_i].field092 IS NOT NULL AND ga_page_data_t.field092 IS NOT NULL) OR (ga_table_data[p_i].field092 IS NULL AND ga_page_data_t.field092 IS NOT NULL) OR (ga_table_data[p_i].field092 IS NOT NULL AND ga_page_data_t.field092 IS NULL))) 
                OR (ga_table_data[p_i].field092 IS NULL AND ga_page_data_t.field092 IS NOT NULL)
                OR (ga_table_data[p_i].field092 IS NOT NULL AND ga_page_data_t.field092 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field092 END IF  
       WHEN  93 IF (ga_table_data[p_i].field093 <> ga_page_data_t.field093 AND ((ga_table_data[p_i].field093 IS NOT NULL AND ga_page_data_t.field093 IS NOT NULL) OR (ga_table_data[p_i].field093 IS NULL AND ga_page_data_t.field093 IS NOT NULL) OR (ga_table_data[p_i].field093 IS NOT NULL AND ga_page_data_t.field093 IS NULL))) 
                OR (ga_table_data[p_i].field093 IS NULL AND ga_page_data_t.field093 IS NOT NULL)
                OR (ga_table_data[p_i].field093 IS NOT NULL AND ga_page_data_t.field093 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field093 END IF 
       WHEN  94 IF (ga_table_data[p_i].field094 <> ga_page_data_t.field094 AND ((ga_table_data[p_i].field094 IS NOT NULL AND ga_page_data_t.field094 IS NOT NULL) OR (ga_table_data[p_i].field094 IS NULL AND ga_page_data_t.field094 IS NOT NULL) OR (ga_table_data[p_i].field094 IS NOT NULL AND ga_page_data_t.field094 IS NULL))) 
                OR (ga_table_data[p_i].field094 IS NULL AND ga_page_data_t.field094 IS NOT NULL)
                OR (ga_table_data[p_i].field094 IS NOT NULL AND ga_page_data_t.field094 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field094 END IF 
       WHEN  95 IF (ga_table_data[p_i].field095 <> ga_page_data_t.field095 AND ((ga_table_data[p_i].field095 IS NOT NULL AND ga_page_data_t.field095 IS NOT NULL) OR (ga_table_data[p_i].field095 IS NULL AND ga_page_data_t.field095 IS NOT NULL) OR (ga_table_data[p_i].field095 IS NOT NULL AND ga_page_data_t.field095 IS NULL))) 
                OR (ga_table_data[p_i].field095 IS NULL AND ga_page_data_t.field095 IS NOT NULL)
                OR (ga_table_data[p_i].field095 IS NOT NULL AND ga_page_data_t.field095 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field095 END IF 
       WHEN  96 IF (ga_table_data[p_i].field096 <> ga_page_data_t.field096 AND ((ga_table_data[p_i].field096 IS NOT NULL AND ga_page_data_t.field096 IS NOT NULL) OR (ga_table_data[p_i].field096 IS NULL AND ga_page_data_t.field096 IS NOT NULL) OR (ga_table_data[p_i].field096 IS NOT NULL AND ga_page_data_t.field096 IS NULL))) 
                OR (ga_table_data[p_i].field096 IS NULL AND ga_page_data_t.field096 IS NOT NULL)
                OR (ga_table_data[p_i].field096 IS NOT NULL AND ga_page_data_t.field096 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field096 END IF 
       WHEN  97 IF (ga_table_data[p_i].field097 <> ga_page_data_t.field097 AND ((ga_table_data[p_i].field097 IS NOT NULL AND ga_page_data_t.field097 IS NOT NULL) OR (ga_table_data[p_i].field097 IS NULL AND ga_page_data_t.field097 IS NOT NULL) OR (ga_table_data[p_i].field097 IS NOT NULL AND ga_page_data_t.field097 IS NULL))) 
                OR (ga_table_data[p_i].field097 IS NULL AND ga_page_data_t.field097 IS NOT NULL)
                OR (ga_table_data[p_i].field097 IS NOT NULL AND ga_page_data_t.field097 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field097 END IF 
       WHEN  98 IF (ga_table_data[p_i].field098 <> ga_page_data_t.field098 AND ((ga_table_data[p_i].field098 IS NOT NULL AND ga_page_data_t.field098 IS NOT NULL) OR (ga_table_data[p_i].field098 IS NULL AND ga_page_data_t.field098 IS NOT NULL) OR (ga_table_data[p_i].field098 IS NOT NULL AND ga_page_data_t.field098 IS NULL))) 
                OR (ga_table_data[p_i].field098 IS NULL AND ga_page_data_t.field098 IS NOT NULL)
                OR (ga_table_data[p_i].field098 IS NOT NULL AND ga_page_data_t.field098 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field098 END IF 
       WHEN  99 IF (ga_table_data[p_i].field099 <> ga_page_data_t.field099 AND ((ga_table_data[p_i].field099 IS NOT NULL AND ga_page_data_t.field099 IS NOT NULL) OR (ga_table_data[p_i].field099 IS NULL AND ga_page_data_t.field099 IS NOT NULL) OR (ga_table_data[p_i].field099 IS NOT NULL AND ga_page_data_t.field099 IS NULL))) 
                OR (ga_table_data[p_i].field099 IS NULL AND ga_page_data_t.field099 IS NOT NULL)
                OR (ga_table_data[p_i].field099 IS NOT NULL AND ga_page_data_t.field099 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field099 END IF 
     
      WHEN 100 IF (ga_table_data[p_i].field100 <> ga_page_data_t.field100 AND ((ga_table_data[p_i].field100 IS NOT NULL AND ga_page_data_t.field100 IS NOT NULL) OR (ga_table_data[p_i].field100 IS NULL AND ga_page_data_t.field100 IS NOT NULL) OR (ga_table_data[p_i].field100 IS NOT NULL AND ga_page_data_t.field100 IS NULL))) 
                OR (ga_table_data[p_i].field100 IS NULL AND ga_page_data_t.field100 IS NOT NULL)
                OR (ga_table_data[p_i].field100 IS NOT NULL AND ga_page_data_t.field100 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field100 END IF  
 
      WHEN 101 IF (ga_table_data[p_i].field101 <> ga_page_data_t.field101 AND ((ga_table_data[p_i].field101 IS NOT NULL AND ga_page_data_t.field101 IS NOT NULL) OR (ga_table_data[p_i].field101 IS NULL AND ga_page_data_t.field101 IS NOT NULL) OR (ga_table_data[p_i].field101 IS NOT NULL AND ga_page_data_t.field101 IS NULL))) 
                OR (ga_table_data[p_i].field101 IS NULL AND ga_page_data_t.field101 IS NOT NULL)
                OR (ga_table_data[p_i].field101 IS NOT NULL AND ga_page_data_t.field101 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field101 END IF
       WHEN 102 IF (ga_table_data[p_i].field102 <> ga_page_data_t.field102 AND ((ga_table_data[p_i].field102 IS NOT NULL AND ga_page_data_t.field102 IS NOT NULL) OR (ga_table_data[p_i].field102 IS NULL AND ga_page_data_t.field102 IS NOT NULL) OR (ga_table_data[p_i].field102 IS NOT NULL AND ga_page_data_t.field102 IS NULL))) 
                OR (ga_table_data[p_i].field102 IS NULL AND ga_page_data_t.field102 IS NOT NULL)
                OR (ga_table_data[p_i].field102 IS NOT NULL AND ga_page_data_t.field102 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field102 END IF  
       WHEN 103 IF (ga_table_data[p_i].field103 <> ga_page_data_t.field103 AND ((ga_table_data[p_i].field103 IS NOT NULL AND ga_page_data_t.field103 IS NOT NULL) OR (ga_table_data[p_i].field103 IS NULL AND ga_page_data_t.field103 IS NOT NULL) OR (ga_table_data[p_i].field103 IS NOT NULL AND ga_page_data_t.field103 IS NULL))) 
                OR (ga_table_data[p_i].field103 IS NULL AND ga_page_data_t.field103 IS NOT NULL)
                OR (ga_table_data[p_i].field103 IS NOT NULL AND ga_page_data_t.field103 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field103 END IF 
       WHEN 104 IF (ga_table_data[p_i].field104 <> ga_page_data_t.field104 AND ((ga_table_data[p_i].field104 IS NOT NULL AND ga_page_data_t.field104 IS NOT NULL) OR (ga_table_data[p_i].field104 IS NULL AND ga_page_data_t.field104 IS NOT NULL) OR (ga_table_data[p_i].field104 IS NOT NULL AND ga_page_data_t.field104 IS NULL))) 
                OR (ga_table_data[p_i].field104 IS NULL AND ga_page_data_t.field104 IS NOT NULL)
                OR (ga_table_data[p_i].field104 IS NOT NULL AND ga_page_data_t.field104 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field104 END IF 
       WHEN 105 IF (ga_table_data[p_i].field105 <> ga_page_data_t.field105 AND ((ga_table_data[p_i].field105 IS NOT NULL AND ga_page_data_t.field105 IS NOT NULL) OR (ga_table_data[p_i].field105 IS NULL AND ga_page_data_t.field105 IS NOT NULL) OR (ga_table_data[p_i].field105 IS NOT NULL AND ga_page_data_t.field105 IS NULL))) 
                OR (ga_table_data[p_i].field105 IS NULL AND ga_page_data_t.field105 IS NOT NULL)
                OR (ga_table_data[p_i].field105 IS NOT NULL AND ga_page_data_t.field105 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field105 END IF 
       WHEN 106 IF (ga_table_data[p_i].field106 <> ga_page_data_t.field106 AND ((ga_table_data[p_i].field106 IS NOT NULL AND ga_page_data_t.field106 IS NOT NULL) OR (ga_table_data[p_i].field106 IS NULL AND ga_page_data_t.field106 IS NOT NULL) OR (ga_table_data[p_i].field106 IS NOT NULL AND ga_page_data_t.field106 IS NULL))) 
                OR (ga_table_data[p_i].field106 IS NULL AND ga_page_data_t.field106 IS NOT NULL)
                OR (ga_table_data[p_i].field106 IS NOT NULL AND ga_page_data_t.field106 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field106 END IF 
       WHEN 107 IF (ga_table_data[p_i].field107 <> ga_page_data_t.field107 AND ((ga_table_data[p_i].field107 IS NOT NULL AND ga_page_data_t.field107 IS NOT NULL) OR(ga_table_data[p_i].field107 IS NULL AND ga_page_data_t.field107 IS NOT NULL) OR (ga_table_data[p_i].field107 IS NOT NULL AND ga_page_data_t.field107 IS NULL))) 
                OR (ga_table_data[p_i].field107 IS NULL AND ga_page_data_t.field107 IS NOT NULL)
                OR (ga_table_data[p_i].field107 IS NOT NULL AND ga_page_data_t.field107 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field107 END IF 
       WHEN 108 IF (ga_table_data[p_i].field108 <> ga_page_data_t.field108 AND ((ga_table_data[p_i].field108 IS NOT NULL AND ga_page_data_t.field108 IS NOT NULL) OR (ga_table_data[p_i].field108 IS NULL AND ga_page_data_t.field108 IS NOT NULL) OR (ga_table_data[p_i].field108 IS NOT NULL AND ga_page_data_t.field108 IS NULL))) 
                OR (ga_table_data[p_i].field108 IS NULL AND ga_page_data_t.field108 IS NOT NULL)
                OR (ga_table_data[p_i].field108 IS NOT NULL AND ga_page_data_t.field108 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field108 END IF 
       WHEN 109 IF (ga_table_data[p_i].field109 <> ga_page_data_t.field109 AND ((ga_table_data[p_i].field109 IS NOT NULL AND ga_page_data_t.field109 IS NOT NULL) OR (ga_table_data[p_i].field109 IS NULL AND ga_page_data_t.field109 IS NOT NULL) OR (ga_table_data[p_i].field109 IS NOT NULL AND ga_page_data_t.field109 IS NULL))) 
                OR (ga_table_data[p_i].field109 IS NULL AND ga_page_data_t.field109 IS NOT NULL)
                OR (ga_table_data[p_i].field109 IS NOT NULL AND ga_page_data_t.field109 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field109 END IF 
              
       WHEN 110 IF (ga_table_data[p_i].field110 <> ga_page_data_t.field110 AND ((ga_table_data[p_i].field110 IS NOT NULL AND ga_page_data_t.field110 IS NOT NULL) OR (ga_table_data[p_i].field110 IS NULL AND ga_page_data_t.field110 IS NOT NULL) OR (ga_table_data[p_i].field110 IS NOT NULL AND ga_page_data_t.field110 IS NULL))) 
                OR (ga_table_data[p_i].field110 IS NULL AND ga_page_data_t.field110 IS NOT NULL)
                OR (ga_table_data[p_i].field110 IS NOT NULL AND ga_page_data_t.field110 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field110 END IF  
       WHEN 111 IF (ga_table_data[p_i].field111 <> ga_page_data_t.field111 AND ((ga_table_data[p_i].field111 IS NOT NULL AND ga_page_data_t.field111 IS NOT NULL) OR (ga_table_data[p_i].field111 IS NULL AND ga_page_data_t.field111 IS NOT NULL) OR (ga_table_data[p_i].field111 IS NOT NULL AND ga_page_data_t.field111 IS NULL))) 
                OR (ga_table_data[p_i].field111 IS NULL AND ga_page_data_t.field111 IS NOT NULL)
                OR (ga_table_data[p_i].field111 IS NOT NULL AND ga_page_data_t.field111 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field111 END IF
       WHEN 112 IF (ga_table_data[p_i].field112 <> ga_page_data_t.field112 AND ((ga_table_data[p_i].field112 IS NOT NULL AND ga_page_data_t.field112 IS NOT NULL) OR (ga_table_data[p_i].field112 IS NULL AND ga_page_data_t.field112 IS NOT NULL) OR (ga_table_data[p_i].field112 IS NOT NULL AND ga_page_data_t.field112 IS NULL))) 
                OR (ga_table_data[p_i].field112 IS NULL AND ga_page_data_t.field112 IS NOT NULL)
                OR (ga_table_data[p_i].field112 IS NOT NULL AND ga_page_data_t.field112 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field112 END IF  
       WHEN 113 IF (ga_table_data[p_i].field113 <> ga_page_data_t.field113 AND ((ga_table_data[p_i].field113 IS NOT NULL AND ga_page_data_t.field113 IS NOT NULL) OR (ga_table_data[p_i].field113 IS NULL AND ga_page_data_t.field113 IS NOT NULL) OR (ga_table_data[p_i].field113 IS NOT NULL AND ga_page_data_t.field113 IS NULL))) 
                OR (ga_table_data[p_i].field113 IS NULL AND ga_page_data_t.field113 IS NOT NULL)
                OR (ga_table_data[p_i].field113 IS NOT NULL AND ga_page_data_t.field113 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field113 END IF 
       WHEN 114 IF (ga_table_data[p_i].field114 <> ga_page_data_t.field114 AND ((ga_table_data[p_i].field114 IS NOT NULL AND ga_page_data_t.field114 IS NOT NULL) OR (ga_table_data[p_i].field114 IS NULL AND ga_page_data_t.field114 IS NOT NULL) OR (ga_table_data[p_i].field114 IS NOT NULL AND ga_page_data_t.field114 IS NULL))) 
                OR (ga_table_data[p_i].field114 IS NULL AND ga_page_data_t.field114 IS NOT NULL)
                OR (ga_table_data[p_i].field114 IS NOT NULL AND ga_page_data_t.field114 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field114 END IF 
       WHEN 115 IF (ga_table_data[p_i].field115 <> ga_page_data_t.field115 AND ((ga_table_data[p_i].field115 IS NOT NULL AND ga_page_data_t.field115 IS NOT NULL) OR(ga_table_data[p_i].field115 IS NULL AND ga_page_data_t.field115 IS NOT NULL) OR (ga_table_data[p_i].field115 IS NOT NULL AND ga_page_data_t.field115 IS NULL))) 
                OR (ga_table_data[p_i].field115 IS NULL AND ga_page_data_t.field115 IS NOT NULL)
                OR (ga_table_data[p_i].field115 IS NOT NULL AND ga_page_data_t.field115 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field115 END IF 
       WHEN 116 IF (ga_table_data[p_i].field116 <> ga_page_data_t.field116 AND ((ga_table_data[p_i].field116 IS NOT NULL AND ga_page_data_t.field116 IS NOT NULL) OR (ga_table_data[p_i].field116 IS NULL AND ga_page_data_t.field116 IS NOT NULL) OR (ga_table_data[p_i].field116 IS NOT NULL AND ga_page_data_t.field116 IS NULL))) 
                OR (ga_table_data[p_i].field116 IS NULL AND ga_page_data_t.field116 IS NOT NULL)
                OR (ga_table_data[p_i].field116 IS NOT NULL AND ga_page_data_t.field116 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field116 END IF 
       WHEN 117 IF (ga_table_data[p_i].field117 <> ga_page_data_t.field117 AND ((ga_table_data[p_i].field117 IS NOT NULL AND ga_page_data_t.field117 IS NOT NULL) OR (ga_table_data[p_i].field117 IS NULL AND ga_page_data_t.field117 IS NOT NULL) OR (ga_table_data[p_i].field117 IS NOT NULL AND ga_page_data_t.field117 IS NULL))) 
                OR (ga_table_data[p_i].field117 IS NULL AND ga_page_data_t.field117 IS NOT NULL)
                OR (ga_table_data[p_i].field117 IS NOT NULL AND ga_page_data_t.field117 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field117 END IF 
       WHEN 118 IF (ga_table_data[p_i].field118 <> ga_page_data_t.field118 AND ((ga_table_data[p_i].field118 IS NOT NULL AND ga_page_data_t.field118 IS NOT NULL) OR (ga_table_data[p_i].field118 IS NULL AND ga_page_data_t.field118 IS NOT NULL) OR (ga_table_data[p_i].field118 IS NOT NULL AND ga_page_data_t.field118 IS NULL))) 
                OR (ga_table_data[p_i].field118 IS NULL AND ga_page_data_t.field118 IS NOT NULL)
                OR (ga_table_data[p_i].field118 IS NOT NULL AND ga_page_data_t.field118 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field118 END IF 
       WHEN 119 IF (ga_table_data[p_i].field119 <> ga_page_data_t.field119 AND ((ga_table_data[p_i].field119 IS NOT NULL AND ga_page_data_t.field119 IS NOT NULL) OR (ga_table_data[p_i].field119 IS NULL AND ga_page_data_t.field119 IS NOT NULL) OR (ga_table_data[p_i].field119 IS NOT NULL AND ga_page_data_t.field119 IS NULL))) 
                OR (ga_table_data[p_i].field119 IS NULL AND ga_page_data_t.field119 IS NOT NULL)
                OR (ga_table_data[p_i].field119 IS NOT NULL AND ga_page_data_t.field119 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field119 END IF 
     
      WHEN 120 IF (ga_table_data[p_i].field120 <> ga_page_data_t.field120 AND ((ga_table_data[p_i].field120 IS NOT NULL AND ga_page_data_t.field120 IS NOT NULL) OR(ga_table_data[p_i].field120 IS NULL AND ga_page_data_t.field120 IS NOT NULL) OR (ga_table_data[p_i].field120 IS NOT NULL AND ga_page_data_t.field120 IS NULL))) 
                OR (ga_table_data[p_i].field120 IS NULL AND ga_page_data_t.field120 IS NOT NULL)
                OR (ga_table_data[p_i].field120 IS NOT NULL AND ga_page_data_t.field120 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field120 END IF  
       WHEN 121 IF (ga_table_data[p_i].field121 <> ga_page_data_t.field121 AND ((ga_table_data[p_i].field121 IS NOT NULL AND ga_page_data_t.field121 IS NOT NULL) OR(ga_table_data[p_i].field121 IS NULL AND ga_page_data_t.field121 IS NOT NULL) OR (ga_table_data[p_i].field121 IS NOT NULL AND ga_page_data_t.field121 IS NULL))) 
                OR (ga_table_data[p_i].field121 IS NULL AND ga_page_data_t.field121 IS NOT NULL)
                OR (ga_table_data[p_i].field121 IS NOT NULL AND ga_page_data_t.field121 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field121 END IF
       WHEN 122 IF (ga_table_data[p_i].field122 <> ga_page_data_t.field122 AND ((ga_table_data[p_i].field122 IS NOT NULL AND ga_page_data_t.field122 IS NOT NULL) OR(ga_table_data[p_i].field122 IS NULL AND ga_page_data_t.field122 IS NOT NULL) OR (ga_table_data[p_i].field122 IS NOT NULL AND ga_page_data_t.field122 IS NULL))) 
                OR (ga_table_data[p_i].field122 IS NULL AND ga_page_data_t.field122 IS NOT NULL)
                OR (ga_table_data[p_i].field122 IS NOT NULL AND ga_page_data_t.field122 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field122 END IF  
       WHEN 123 IF (ga_table_data[p_i].field123 <> ga_page_data_t.field123 AND ((ga_table_data[p_i].field123 IS NOT NULL AND ga_page_data_t.field123 IS NOT NULL) OR (ga_table_data[p_i].field123 IS NULL AND ga_page_data_t.field123 IS NOT NULL) OR (ga_table_data[p_i].field123 IS NOT NULL AND ga_page_data_t.field123 IS NULL))) 
                OR (ga_table_data[p_i].field123 IS NULL AND ga_page_data_t.field123 IS NOT NULL)
                OR (ga_table_data[p_i].field123 IS NOT NULL AND ga_page_data_t.field123 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field123 END IF 
       WHEN 124 IF (ga_table_data[p_i].field124 <> ga_page_data_t.field124 AND ((ga_table_data[p_i].field124 IS NOT NULL AND ga_page_data_t.field124 IS NOT NULL) OR (ga_table_data[p_i].field124 IS NULL AND ga_page_data_t.field124 IS NOT NULL) OR (ga_table_data[p_i].field124 IS NOT NULL AND ga_page_data_t.field124 IS NULL))) 
                OR (ga_table_data[p_i].field124 IS NULL AND ga_page_data_t.field124 IS NOT NULL)
                OR (ga_table_data[p_i].field124 IS NOT NULL AND ga_page_data_t.field124 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field124 END IF 
       WHEN 125 IF (ga_table_data[p_i].field125 <> ga_page_data_t.field125 AND ((ga_table_data[p_i].field125 IS NOT NULL AND ga_page_data_t.field125 IS NOT NULL) OR (ga_table_data[p_i].field125 IS NULL AND ga_page_data_t.field125 IS NOT NULL) OR (ga_table_data[p_i].field125 IS NOT NULL AND ga_page_data_t.field125 IS NULL))) 
                OR (ga_table_data[p_i].field125 IS NULL AND ga_page_data_t.field125 IS NOT NULL)
                OR (ga_table_data[p_i].field125 IS NOT NULL AND ga_page_data_t.field125 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field125 END IF 
       WHEN 126 IF (ga_table_data[p_i].field126 <> ga_page_data_t.field126 AND ((ga_table_data[p_i].field126 IS NOT NULL AND ga_page_data_t.field126 IS NOT NULL) OR (ga_table_data[p_i].field126 IS NULL AND ga_page_data_t.field126 IS NOT NULL) OR (ga_table_data[p_i].field126 IS NOT NULL AND ga_page_data_t.field126 IS NULL))) 
                OR (ga_table_data[p_i].field126 IS NULL AND ga_page_data_t.field126 IS NOT NULL)
                OR (ga_table_data[p_i].field126 IS NOT NULL AND ga_page_data_t.field126 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field126 END IF 
       WHEN 127 IF (ga_table_data[p_i].field127 <> ga_page_data_t.field127 AND ((ga_table_data[p_i].field127 IS NOT NULL AND ga_page_data_t.field127 IS NOT NULL) OR (ga_table_data[p_i].field127 IS NULL AND ga_page_data_t.field127 IS NOT NULL) OR (ga_table_data[p_i].field127 IS NOT NULL AND ga_page_data_t.field127 IS NULL))) 
                OR (ga_table_data[p_i].field127 IS NULL AND ga_page_data_t.field127 IS NOT NULL)
                OR (ga_table_data[p_i].field127 IS NOT NULL AND ga_page_data_t.field127 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field127 END IF 
       WHEN 128 IF (ga_table_data[p_i].field128 <> ga_page_data_t.field128 AND ((ga_table_data[p_i].field128 IS NOT NULL AND ga_page_data_t.field128 IS NOT NULL) OR(ga_table_data[p_i].field128 IS NULL AND ga_page_data_t.field128 IS NOT NULL) OR (ga_table_data[p_i].field128 IS NOT NULL AND ga_page_data_t.field128 IS NULL))) 
                OR (ga_table_data[p_i].field128 IS NULL AND ga_page_data_t.field128 IS NOT NULL)
                OR (ga_table_data[p_i].field128 IS NOT NULL AND ga_page_data_t.field128 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field128 END IF 
       WHEN 129 IF (ga_table_data[p_i].field129 <> ga_page_data_t.field129 AND ((ga_table_data[p_i].field129 IS NOT NULL AND ga_page_data_t.field129 IS NOT NULL) OR(ga_table_data[p_i].field129 IS NULL AND ga_page_data_t.field129 IS NOT NULL) OR (ga_table_data[p_i].field129 IS NOT NULL AND ga_page_data_t.field129 IS NULL))) 
                OR (ga_table_data[p_i].field129 IS NULL AND ga_page_data_t.field129 IS NOT NULL)
                OR (ga_table_data[p_i].field129 IS NOT NULL AND ga_page_data_t.field129 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field129 END IF 

       WHEN 130 IF (ga_table_data[p_i].field130 <> ga_page_data_t.field130 AND ((ga_table_data[p_i].field130 IS NOT NULL AND ga_page_data_t.field130 IS NOT NULL) OR (ga_table_data[p_i].field130 IS NULL AND ga_page_data_t.field130 IS NOT NULL) OR (ga_table_data[p_i].field130 IS NOT NULL AND ga_page_data_t.field130 IS NULL))) 
                OR (ga_table_data[p_i].field130 IS NULL AND ga_page_data_t.field130 IS NOT NULL)
                OR (ga_table_data[p_i].field130 IS NOT NULL AND ga_page_data_t.field130 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field130 END IF  
       WHEN 131 IF (ga_table_data[p_i].field131 <> ga_page_data_t.field131 AND ((ga_table_data[p_i].field131 IS NOT NULL AND ga_page_data_t.field131 IS NOT NULL) OR (ga_table_data[p_i].field131 IS NULL AND ga_page_data_t.field131 IS NOT NULL) OR (ga_table_data[p_i].field131 IS NOT NULL AND ga_page_data_t.field131 IS NULL))) 
                OR (ga_table_data[p_i].field131 IS NULL AND ga_page_data_t.field131 IS NOT NULL)
                OR (ga_table_data[p_i].field131 IS NOT NULL AND ga_page_data_t.field131 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field131 END IF
       WHEN 132 IF (ga_table_data[p_i].field132 <> ga_page_data_t.field132 AND ((ga_table_data[p_i].field132 IS NOT NULL AND ga_page_data_t.field132 IS NOT NULL) OR (ga_table_data[p_i].field132 IS NULL AND ga_page_data_t.field132 IS NOT NULL) OR (ga_table_data[p_i].field132 IS NOT NULL AND ga_page_data_t.field132 IS NULL))) 
                OR (ga_table_data[p_i].field132 IS NULL AND ga_page_data_t.field132 IS NOT NULL)
                OR (ga_table_data[p_i].field132 IS NOT NULL AND ga_page_data_t.field132 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field132 END IF  
       WHEN 133 IF (ga_table_data[p_i].field133 <> ga_page_data_t.field133 AND ((ga_table_data[p_i].field133 IS NOT NULL AND ga_page_data_t.field133 IS NOT NULL) OR (ga_table_data[p_i].field133 IS NULL AND ga_page_data_t.field133 IS NOT NULL) OR (ga_table_data[p_i].field133 IS NOT NULL AND ga_page_data_t.field133 IS NULL))) 
                OR (ga_table_data[p_i].field133 IS NULL AND ga_page_data_t.field133 IS NOT NULL)
                OR (ga_table_data[p_i].field133 IS NOT NULL AND ga_page_data_t.field133 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field133 END IF 
       WHEN 134 IF (ga_table_data[p_i].field134 <> ga_page_data_t.field134 AND ((ga_table_data[p_i].field134 IS NOT NULL AND ga_page_data_t.field134 IS NOT NULL) OR (ga_table_data[p_i].field134 IS NULL AND ga_page_data_t.field134 IS NOT NULL) OR (ga_table_data[p_i].field134 IS NOT NULL AND ga_page_data_t.field134 IS NULL))) 
                OR (ga_table_data[p_i].field134 IS NULL AND ga_page_data_t.field134 IS NOT NULL)
                OR (ga_table_data[p_i].field134 IS NOT NULL AND ga_page_data_t.field134 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field134 END IF 
       WHEN 135 IF (ga_table_data[p_i].field135 <> ga_page_data_t.field135 AND ((ga_table_data[p_i].field135 IS NOT NULL AND ga_page_data_t.field135 IS NOT NULL) OR (ga_table_data[p_i].field135 IS NULL AND ga_page_data_t.field135 IS NOT NULL) OR (ga_table_data[p_i].field135 IS NOT NULL AND ga_page_data_t.field135 IS NULL))) 
                OR (ga_table_data[p_i].field135 IS NULL AND ga_page_data_t.field135 IS NOT NULL)
                OR (ga_table_data[p_i].field135 IS NOT NULL AND ga_page_data_t.field135 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field135 END IF 
       WHEN 136 IF (ga_table_data[p_i].field136 <> ga_page_data_t.field136 AND ((ga_table_data[p_i].field136 IS NOT NULL AND ga_page_data_t.field136 IS NOT NULL) OR (ga_table_data[p_i].field136 IS NULL AND ga_page_data_t.field136 IS NOT NULL) OR (ga_table_data[p_i].field136 IS NOT NULL AND ga_page_data_t.field136 IS NULL))) 
                OR (ga_table_data[p_i].field136 IS NULL AND ga_page_data_t.field136 IS NOT NULL)
                OR (ga_table_data[p_i].field136 IS NOT NULL AND ga_page_data_t.field136 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field136 END IF 
       WHEN 137 IF (ga_table_data[p_i].field137 <> ga_page_data_t.field137 AND ((ga_table_data[p_i].field137 IS NOT NULL AND ga_page_data_t.field137 IS NOT NULL) OR (ga_table_data[p_i].field137 IS NULL AND ga_page_data_t.field137 IS NOT NULL) OR (ga_table_data[p_i].field137 IS NOT NULL AND ga_page_data_t.field137 IS NULL))) 
                OR (ga_table_data[p_i].field137 IS NULL AND ga_page_data_t.field137 IS NOT NULL)
                OR (ga_table_data[p_i].field137 IS NOT NULL AND ga_page_data_t.field137 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field137 END IF 
       WHEN 138 IF (ga_table_data[p_i].field138 <> ga_page_data_t.field138 AND ((ga_table_data[p_i].field138 IS NOT NULL AND ga_page_data_t.field138 IS NOT NULL) OR (ga_table_data[p_i].field138 IS NULL AND ga_page_data_t.field138 IS NOT NULL) OR (ga_table_data[p_i].field138 IS NOT NULL AND ga_page_data_t.field138 IS NULL))) 
                OR (ga_table_data[p_i].field138 IS NULL AND ga_page_data_t.field138 IS NOT NULL)
                OR (ga_table_data[p_i].field138 IS NOT NULL AND ga_page_data_t.field138 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field138 END IF 
       WHEN 139 IF (ga_table_data[p_i].field139 <> ga_page_data_t.field139 AND ((ga_table_data[p_i].field139 IS NOT NULL AND ga_page_data_t.field139 IS NOT NULL) OR (ga_table_data[p_i].field139 IS NULL AND ga_page_data_t.field139 IS NOT NULL) OR (ga_table_data[p_i].field139 IS NOT NULL AND ga_page_data_t.field139 IS NULL))) 
                OR (ga_table_data[p_i].field139 IS NULL AND ga_page_data_t.field139 IS NOT NULL)
                OR (ga_table_data[p_i].field139 IS NOT NULL AND ga_page_data_t.field139 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field139 END IF 
     
     WHEN 140 IF (ga_table_data[p_i].field140 <> ga_page_data_t.field140 AND ((ga_table_data[p_i].field140 IS NOT NULL AND ga_page_data_t.field140 IS NOT NULL) OR (ga_table_data[p_i].field140 IS NULL AND ga_page_data_t.field140 IS NOT NULL) OR (ga_table_data[p_i].field140 IS NOT NULL AND ga_page_data_t.field140 IS NULL))) 
                OR (ga_table_data[p_i].field140 IS NULL AND ga_page_data_t.field140 IS NOT NULL)
                OR (ga_table_data[p_i].field140 IS NOT NULL AND ga_page_data_t.field140 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field140 END IF  
       WHEN 141 IF (ga_table_data[p_i].field141 <> ga_page_data_t.field141 AND ((ga_table_data[p_i].field141 IS NOT NULL AND ga_page_data_t.field141 IS NOT NULL) OR (ga_table_data[p_i].field141 IS NULL AND ga_page_data_t.field141 IS NOT NULL) OR (ga_table_data[p_i].field141 IS NOT NULL AND ga_page_data_t.field141 IS NULL))) 
                OR (ga_table_data[p_i].field141 IS NULL AND ga_page_data_t.field141 IS NOT NULL)
                OR (ga_table_data[p_i].field141 IS NOT NULL AND ga_page_data_t.field141 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field141 END IF
       WHEN 142 IF (ga_table_data[p_i].field142 <> ga_page_data_t.field142 AND ((ga_table_data[p_i].field142 IS NOT NULL AND ga_page_data_t.field142 IS NOT NULL) OR (ga_table_data[p_i].field142 IS NULL AND ga_page_data_t.field142 IS NOT NULL) OR (ga_table_data[p_i].field142 IS NOT NULL AND ga_page_data_t.field142 IS NULL))) 
                OR (ga_table_data[p_i].field142 IS NULL AND ga_page_data_t.field142 IS NOT NULL)
                OR (ga_table_data[p_i].field142 IS NOT NULL AND ga_page_data_t.field142 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field142 END IF  
       WHEN 143 IF (ga_table_data[p_i].field143 <> ga_page_data_t.field143 AND ((ga_table_data[p_i].field143 IS NOT NULL AND ga_page_data_t.field143 IS NOT NULL) OR (ga_table_data[p_i].field143 IS NULL AND ga_page_data_t.field143 IS NOT NULL) OR (ga_table_data[p_i].field143 IS NOT NULL AND ga_page_data_t.field143 IS NULL))) 
                OR (ga_table_data[p_i].field143 IS NULL AND ga_page_data_t.field143 IS NOT NULL)
                OR (ga_table_data[p_i].field143 IS NOT NULL AND ga_page_data_t.field143 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field143 END IF 
       WHEN 144 IF (ga_table_data[p_i].field144 <> ga_page_data_t.field144 AND ((ga_table_data[p_i].field144 IS NOT NULL AND ga_page_data_t.field144 IS NOT NULL) OR (ga_table_data[p_i].field144 IS NULL AND ga_page_data_t.field144 IS NOT NULL) OR (ga_table_data[p_i].field144 IS NOT NULL AND ga_page_data_t.field144 IS NULL))) 
                OR (ga_table_data[p_i].field144 IS NULL AND ga_page_data_t.field144 IS NOT NULL)
                OR (ga_table_data[p_i].field144 IS NOT NULL AND ga_page_data_t.field144 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field144 END IF 
       WHEN 145 IF (ga_table_data[p_i].field145 <> ga_page_data_t.field145 AND ((ga_table_data[p_i].field145 IS NOT NULL AND ga_page_data_t.field145 IS NOT NULL) OR (ga_table_data[p_i].field145 IS NULL AND ga_page_data_t.field145 IS NOT NULL) OR (ga_table_data[p_i].field145 IS NOT NULL AND ga_page_data_t.field145 IS NULL))) 
                OR (ga_table_data[p_i].field145 IS NULL AND ga_page_data_t.field145 IS NOT NULL)
                OR (ga_table_data[p_i].field145 IS NOT NULL AND ga_page_data_t.field145 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field145 END IF 
       WHEN 146 IF (ga_table_data[p_i].field146 <> ga_page_data_t.field146 AND ((ga_table_data[p_i].field146 IS NOT NULL AND ga_page_data_t.field146 IS NOT NULL) OR (ga_table_data[p_i].field146 IS NULL AND ga_page_data_t.field146 IS NOT NULL) OR (ga_table_data[p_i].field146 IS NOT NULL AND ga_page_data_t.field146 IS NULL))) 
                OR (ga_table_data[p_i].field146 IS NULL AND ga_page_data_t.field146 IS NOT NULL)
                OR (ga_table_data[p_i].field146 IS NOT NULL AND ga_page_data_t.field146 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field146 END IF 
       WHEN 147 IF (ga_table_data[p_i].field147 <> ga_page_data_t.field147 AND ((ga_table_data[p_i].field147 IS NOT NULL AND ga_page_data_t.field147 IS NOT NULL) OR (ga_table_data[p_i].field147 IS NULL AND ga_page_data_t.field147 IS NOT NULL) OR (ga_table_data[p_i].field147 IS NOT NULL AND ga_page_data_t.field147 IS NULL))) 
                OR (ga_table_data[p_i].field147 IS NULL AND ga_page_data_t.field147 IS NOT NULL)
                OR (ga_table_data[p_i].field147 IS NOT NULL AND ga_page_data_t.field147 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field147 END IF 
       WHEN 148 IF (ga_table_data[p_i].field148 <> ga_page_data_t.field148 AND ((ga_table_data[p_i].field148 IS NOT NULL AND ga_page_data_t.field148 IS NOT NULL) OR (ga_table_data[p_i].field148 IS NULL AND ga_page_data_t.field148 IS NOT NULL) OR (ga_table_data[p_i].field148 IS NOT NULL AND ga_page_data_t.field148 IS NULL))) 
                OR (ga_table_data[p_i].field148 IS NULL AND ga_page_data_t.field148 IS NOT NULL)
                OR (ga_table_data[p_i].field148 IS NOT NULL AND ga_page_data_t.field148 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field148 END IF 
       WHEN 149 IF (ga_table_data[p_i].field149 <> ga_page_data_t.field149 AND ((ga_table_data[p_i].field149 IS NOT NULL AND ga_page_data_t.field149 IS NOT NULL) OR (ga_table_data[p_i].field149 IS NULL AND ga_page_data_t.field149 IS NOT NULL) OR (ga_table_data[p_i].field149 IS NOT NULL AND ga_page_data_t.field149 IS NULL))) 
                OR (ga_table_data[p_i].field149 IS NULL AND ga_page_data_t.field149 IS NOT NULL)
                OR (ga_table_data[p_i].field149 IS NOT NULL AND ga_page_data_t.field149 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field149 END IF               
       WHEN 150 IF (ga_table_data[p_i].field150 <> ga_page_data_t.field150 AND ((ga_table_data[p_i].field150 IS NOT NULL AND ga_page_data_t.field150 IS NOT NULL) OR (ga_table_data[p_i].field150 IS NULL AND ga_page_data_t.field150 IS NOT NULL) OR (ga_table_data[p_i].field150 IS NOT NULL AND ga_page_data_t.field150 IS NULL))) 
                OR (ga_table_data[p_i].field150 IS NULL AND ga_page_data_t.field150 IS NOT NULL)
                OR (ga_table_data[p_i].field150 IS NOT NULL AND ga_page_data_t.field150 IS NULL AND p_i<>1 )
              THEN LET l_tag = 1 LET l_str=ga_page_data_t.field150 END IF   
  END CASE
   #161215-00017#1 add(e)
   #161215-00017#1 mark(s)
#    CASE p_n 
#       WHEN   1 IF ga_table_data[p_i].field001 <> ga_page_data_t.field001 OR ga_table_data[p_i].field001 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field001 END IF            
#       WHEN   3 IF ga_table_data[p_i].field003 <> ga_page_data_t.field003 OR ga_table_data[p_i].field003 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field003 END IF
#       WHEN   4 IF ga_table_data[p_i].field004 <> ga_page_data_t.field004 OR ga_table_data[p_i].field004 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field004 END IF
#       WHEN   5 IF ga_table_data[p_i].field005 <> ga_page_data_t.field005 OR ga_table_data[p_i].field005 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field005 END IF
#       WHEN   6 IF ga_table_data[p_i].field006 <> ga_page_data_t.field006 OR ga_table_data[p_i].field006 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field006 END IF
#       WHEN   7 IF ga_table_data[p_i].field007 <> ga_page_data_t.field007 OR ga_table_data[p_i].field007 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field007 END IF
#       WHEN   8 IF ga_table_data[p_i].field008 <> ga_page_data_t.field008 OR ga_table_data[p_i].field008 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field008 END IF
#       WHEN   9 IF ga_table_data[p_i].field009 <> ga_page_data_t.field009 OR ga_table_data[p_i].field009 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field009 END IF
#       WHEN  10 IF ga_table_data[p_i].field010 <> ga_page_data_t.field010 OR ga_table_data[p_i].field010 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field010 END IF
#       WHEN  11 IF ga_table_data[p_i].field011 <> ga_page_data_t.field011 OR ga_table_data[p_i].field011 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field011 END IF
#       WHEN  12 IF ga_table_data[p_i].field012 <> ga_page_data_t.field012 OR ga_table_data[p_i].field012 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field012 END IF
#       WHEN  13 IF ga_table_data[p_i].field013 <> ga_page_data_t.field013 OR ga_table_data[p_i].field013 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field013 END IF
#       WHEN  14 IF ga_table_data[p_i].field014 <> ga_page_data_t.field014 OR ga_table_data[p_i].field014 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field014 END IF
#       WHEN  15 IF ga_table_data[p_i].field015 <> ga_page_data_t.field015 OR ga_table_data[p_i].field015 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field015 END IF
#       WHEN  16 IF ga_table_data[p_i].field016 <> ga_page_data_t.field016 OR ga_table_data[p_i].field016 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field016 END IF
#       WHEN  17 IF ga_table_data[p_i].field017 <> ga_page_data_t.field017 OR ga_table_data[p_i].field017 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field017 END IF
#       WHEN  18 IF ga_table_data[p_i].field018 <> ga_page_data_t.field018 OR ga_table_data[p_i].field018 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field018 END IF
#       WHEN  19 IF ga_table_data[p_i].field019 <> ga_page_data_t.field019 OR ga_table_data[p_i].field019 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field019 END IF
#       WHEN  20 IF ga_table_data[p_i].field020 <> ga_page_data_t.field020 OR ga_table_data[p_i].field020 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field020 END IF
#       WHEN  21 IF ga_table_data[p_i].field021 <> ga_page_data_t.field021 OR ga_table_data[p_i].field021 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field021 END IF
#       WHEN  22 IF ga_table_data[p_i].field022 <> ga_page_data_t.field022 OR ga_table_data[p_i].field022 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field022 END IF
#       WHEN  23 IF ga_table_data[p_i].field023 <> ga_page_data_t.field023 OR ga_table_data[p_i].field023 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field023 END IF
#       WHEN  24 IF ga_table_data[p_i].field024 <> ga_page_data_t.field024 OR ga_table_data[p_i].field024 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field024 END IF
#       WHEN  25 IF ga_table_data[p_i].field025 <> ga_page_data_t.field025 OR ga_table_data[p_i].field025 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field025 END IF
#       WHEN  26 IF ga_table_data[p_i].field026 <> ga_page_data_t.field026 OR ga_table_data[p_i].field026 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field026 END IF
#       WHEN  27 IF ga_table_data[p_i].field027 <> ga_page_data_t.field027 OR ga_table_data[p_i].field027 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field027 END IF
#       WHEN  28 IF ga_table_data[p_i].field028 <> ga_page_data_t.field028 OR ga_table_data[p_i].field028 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field028 END IF
#       WHEN  29 IF ga_table_data[p_i].field029 <> ga_page_data_t.field029 OR ga_table_data[p_i].field029 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field029 END IF
#       WHEN  30 IF ga_table_data[p_i].field030 <> ga_page_data_t.field030 OR ga_table_data[p_i].field030 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field030 END IF
#       WHEN  31 IF ga_table_data[p_i].field031 <> ga_page_data_t.field031 OR ga_table_data[p_i].field031 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field031 END IF
#       WHEN  32 IF ga_table_data[p_i].field032 <> ga_page_data_t.field032 OR ga_table_data[p_i].field032 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field032 END IF
#       WHEN  33 IF ga_table_data[p_i].field033 <> ga_page_data_t.field033 OR ga_table_data[p_i].field033 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field033 END IF
#       WHEN  34 IF ga_table_data[p_i].field034 <> ga_page_data_t.field034 OR ga_table_data[p_i].field034 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field034 END IF
#       WHEN  35 IF ga_table_data[p_i].field035 <> ga_page_data_t.field035 OR ga_table_data[p_i].field035 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field035 END IF
#       WHEN  36 IF ga_table_data[p_i].field036 <> ga_page_data_t.field036 OR ga_table_data[p_i].field036 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field036 END IF
#       WHEN  37 IF ga_table_data[p_i].field037 <> ga_page_data_t.field037 OR ga_table_data[p_i].field037 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field037 END IF
#       WHEN  38 IF ga_table_data[p_i].field038 <> ga_page_data_t.field038 OR ga_table_data[p_i].field038 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field038 END IF
#       WHEN  39 IF ga_table_data[p_i].field039 <> ga_page_data_t.field039 OR ga_table_data[p_i].field039 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field039 END IF
#       WHEN  40 IF ga_table_data[p_i].field040 <> ga_page_data_t.field040 OR ga_table_data[p_i].field040 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field040 END IF
#       WHEN  41 IF ga_table_data[p_i].field041 <> ga_page_data_t.field041 OR ga_table_data[p_i].field041 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field041 END IF
#       WHEN  42 IF ga_table_data[p_i].field042 <> ga_page_data_t.field042 OR ga_table_data[p_i].field042 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field042 END IF
#       WHEN  43 IF ga_table_data[p_i].field043 <> ga_page_data_t.field043 OR ga_table_data[p_i].field043 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field043 END IF
#       WHEN  44 IF ga_table_data[p_i].field044 <> ga_page_data_t.field044 OR ga_table_data[p_i].field044 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field044 END IF
#       WHEN  45 IF ga_table_data[p_i].field045 <> ga_page_data_t.field045 OR ga_table_data[p_i].field045 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field045 END IF
#       WHEN  46 IF ga_table_data[p_i].field046 <> ga_page_data_t.field046 OR ga_table_data[p_i].field046 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field046 END IF
#       WHEN  47 IF ga_table_data[p_i].field047 <> ga_page_data_t.field047 OR ga_table_data[p_i].field047 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field047 END IF
#       WHEN  48 IF ga_table_data[p_i].field048 <> ga_page_data_t.field048 OR ga_table_data[p_i].field048 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field048 END IF
#       WHEN  49 IF ga_table_data[p_i].field049 <> ga_page_data_t.field049 OR ga_table_data[p_i].field049 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field049 END IF
#       WHEN  50 IF ga_table_data[p_i].field050 <> ga_page_data_t.field050 OR ga_table_data[p_i].field050 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field050 END IF
#       WHEN  51 IF ga_table_data[p_i].field051 <> ga_page_data_t.field051 OR ga_table_data[p_i].field051 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field051 END IF
#       WHEN  52 IF ga_table_data[p_i].field052 <> ga_page_data_t.field052 OR ga_table_data[p_i].field052 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field052 END IF
#       WHEN  53 IF ga_table_data[p_i].field053 <> ga_page_data_t.field053 OR ga_table_data[p_i].field053 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field053 END IF
#       WHEN  54 IF ga_table_data[p_i].field054 <> ga_page_data_t.field054 OR ga_table_data[p_i].field054 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field054 END IF
#       WHEN  55 IF ga_table_data[p_i].field055 <> ga_page_data_t.field055 OR ga_table_data[p_i].field055 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field055 END IF
#       WHEN  56 IF ga_table_data[p_i].field056 <> ga_page_data_t.field056 OR ga_table_data[p_i].field056 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field056 END IF
#       WHEN  57 IF ga_table_data[p_i].field057 <> ga_page_data_t.field057 OR ga_table_data[p_i].field057 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field057 END IF
#       WHEN  58 IF ga_table_data[p_i].field058 <> ga_page_data_t.field058 OR ga_table_data[p_i].field058 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field058 END IF
#       WHEN  59 IF ga_table_data[p_i].field059 <> ga_page_data_t.field059 OR ga_table_data[p_i].field059 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field059 END IF
#       WHEN  60 IF ga_table_data[p_i].field060 <> ga_page_data_t.field060 OR ga_table_data[p_i].field060 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field060 END IF
#       WHEN  61 IF ga_table_data[p_i].field061 <> ga_page_data_t.field061 OR ga_table_data[p_i].field061 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field061 END IF
#       WHEN  62 IF ga_table_data[p_i].field062 <> ga_page_data_t.field062 OR ga_table_data[p_i].field062 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field062 END IF
#       WHEN  63 IF ga_table_data[p_i].field063 <> ga_page_data_t.field063 OR ga_table_data[p_i].field063 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field063 END IF
#       WHEN  64 IF ga_table_data[p_i].field064 <> ga_page_data_t.field064 OR ga_table_data[p_i].field064 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field064 END IF
#       WHEN  65 IF ga_table_data[p_i].field065 <> ga_page_data_t.field065 OR ga_table_data[p_i].field065 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field065 END IF
#       WHEN  66 IF ga_table_data[p_i].field066 <> ga_page_data_t.field066 OR ga_table_data[p_i].field066 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field066 END IF
#       WHEN  67 IF ga_table_data[p_i].field067 <> ga_page_data_t.field067 OR ga_table_data[p_i].field067 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field067 END IF
#       WHEN  68 IF ga_table_data[p_i].field068 <> ga_page_data_t.field068 OR ga_table_data[p_i].field068 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field068 END IF
#       WHEN  69 IF ga_table_data[p_i].field069 <> ga_page_data_t.field069 OR ga_table_data[p_i].field069 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field069 END IF
#       WHEN  70 IF ga_table_data[p_i].field070 <> ga_page_data_t.field070 OR ga_table_data[p_i].field070 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field070 END IF
#       WHEN  71 IF ga_table_data[p_i].field071 <> ga_page_data_t.field071 OR ga_table_data[p_i].field071 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field071 END IF
#       WHEN  72 IF ga_table_data[p_i].field072 <> ga_page_data_t.field072 OR ga_table_data[p_i].field072 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field072 END IF
#       WHEN  73 IF ga_table_data[p_i].field073 <> ga_page_data_t.field073 OR ga_table_data[p_i].field073 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field073 END IF
#       WHEN  74 IF ga_table_data[p_i].field074 <> ga_page_data_t.field074 OR ga_table_data[p_i].field074 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field074 END IF
#       WHEN  75 IF ga_table_data[p_i].field075 <> ga_page_data_t.field075 OR ga_table_data[p_i].field075 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field075 END IF
#       WHEN  76 IF ga_table_data[p_i].field076 <> ga_page_data_t.field076 OR ga_table_data[p_i].field076 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field076 END IF
#       WHEN  77 IF ga_table_data[p_i].field077 <> ga_page_data_t.field077 OR ga_table_data[p_i].field077 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field077 END IF
#       WHEN  78 IF ga_table_data[p_i].field078 <> ga_page_data_t.field078 OR ga_table_data[p_i].field078 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field078 END IF
#       WHEN  79 IF ga_table_data[p_i].field079 <> ga_page_data_t.field079 OR ga_table_data[p_i].field079 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field079 END IF
#       WHEN  80 IF ga_table_data[p_i].field080 <> ga_page_data_t.field080 OR ga_table_data[p_i].field080 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field080 END IF
#       WHEN  81 IF ga_table_data[p_i].field081 <> ga_page_data_t.field081 OR ga_table_data[p_i].field081 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field081 END IF
#       WHEN  82 IF ga_table_data[p_i].field082 <> ga_page_data_t.field082 OR ga_table_data[p_i].field082 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field082 END IF
#       WHEN  83 IF ga_table_data[p_i].field083 <> ga_page_data_t.field083 OR ga_table_data[p_i].field083 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field083 END IF
#       WHEN  84 IF ga_table_data[p_i].field084 <> ga_page_data_t.field084 OR ga_table_data[p_i].field084 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field084 END IF
#       WHEN  85 IF ga_table_data[p_i].field085 <> ga_page_data_t.field085 OR ga_table_data[p_i].field085 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field085 END IF
#       WHEN  86 IF ga_table_data[p_i].field086 <> ga_page_data_t.field086 OR ga_table_data[p_i].field086 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field086 END IF
#       WHEN  87 IF ga_table_data[p_i].field087 <> ga_page_data_t.field087 OR ga_table_data[p_i].field087 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field087 END IF
#       WHEN  88 IF ga_table_data[p_i].field088 <> ga_page_data_t.field088 OR ga_table_data[p_i].field088 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field088 END IF
#       WHEN  89 IF ga_table_data[p_i].field089 <> ga_page_data_t.field089 OR ga_table_data[p_i].field089 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field089 END IF
#       WHEN  90 IF ga_table_data[p_i].field090 <> ga_page_data_t.field090 OR ga_table_data[p_i].field090 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field090 END IF
#       WHEN  91 IF ga_table_data[p_i].field091 <> ga_page_data_t.field091 OR ga_table_data[p_i].field091 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field091 END IF
#       WHEN  92 IF ga_table_data[p_i].field092 <> ga_page_data_t.field092 OR ga_table_data[p_i].field092 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field092 END IF
#       WHEN  93 IF ga_table_data[p_i].field093 <> ga_page_data_t.field093 OR ga_table_data[p_i].field093 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field093 END IF
#       WHEN  94 IF ga_table_data[p_i].field094 <> ga_page_data_t.field094 OR ga_table_data[p_i].field094 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field094 END IF
#       WHEN  95 IF ga_table_data[p_i].field095 <> ga_page_data_t.field095 OR ga_table_data[p_i].field095 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field095 END IF
#       WHEN  96 IF ga_table_data[p_i].field096 <> ga_page_data_t.field096 OR ga_table_data[p_i].field096 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field096 END IF
#       WHEN  97 IF ga_table_data[p_i].field097 <> ga_page_data_t.field097 OR ga_table_data[p_i].field097 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field097 END IF
#       WHEN  98 IF ga_table_data[p_i].field098 <> ga_page_data_t.field098 OR ga_table_data[p_i].field098 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field098 END IF
#       WHEN  99 IF ga_table_data[p_i].field099 <> ga_page_data_t.field099 OR ga_table_data[p_i].field099 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field099 END IF
#       WHEN 100 IF ga_table_data[p_i].field100 <> ga_page_data_t.field100 OR ga_table_data[p_i].field100 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field100 END IF
#       WHEN 101 IF ga_table_data[p_i].field101 <> ga_page_data_t.field101 OR ga_table_data[p_i].field101 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field101 END IF
#       WHEN 102 IF ga_table_data[p_i].field102 <> ga_page_data_t.field102 OR ga_table_data[p_i].field102 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field102 END IF
#       WHEN 103 IF ga_table_data[p_i].field103 <> ga_page_data_t.field103 OR ga_table_data[p_i].field103 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field103 END IF
#       WHEN 104 IF ga_table_data[p_i].field104 <> ga_page_data_t.field104 OR ga_table_data[p_i].field104 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field104 END IF
#       WHEN 105 IF ga_table_data[p_i].field105 <> ga_page_data_t.field105 OR ga_table_data[p_i].field105 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field105 END IF
#       WHEN 106 IF ga_table_data[p_i].field106 <> ga_page_data_t.field106 OR ga_table_data[p_i].field106 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field106 END IF
#       WHEN 107 IF ga_table_data[p_i].field107 <> ga_page_data_t.field107 OR ga_table_data[p_i].field107 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field107 END IF
#       WHEN 108 IF ga_table_data[p_i].field108 <> ga_page_data_t.field108 OR ga_table_data[p_i].field108 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field108 END IF
#       WHEN 109 IF ga_table_data[p_i].field109 <> ga_page_data_t.field109 OR ga_table_data[p_i].field109 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field109 END IF
#       WHEN 110 IF ga_table_data[p_i].field110 <> ga_page_data_t.field110 OR ga_table_data[p_i].field110 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field110 END IF
#       WHEN 111 IF ga_table_data[p_i].field111 <> ga_page_data_t.field111 OR ga_table_data[p_i].field111 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field111 END IF
#       WHEN 112 IF ga_table_data[p_i].field112 <> ga_page_data_t.field112 OR ga_table_data[p_i].field112 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field112 END IF
#       WHEN 113 IF ga_table_data[p_i].field113 <> ga_page_data_t.field113 OR ga_table_data[p_i].field113 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field113 END IF
#       WHEN 114 IF ga_table_data[p_i].field114 <> ga_page_data_t.field114 OR ga_table_data[p_i].field114 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field114 END IF
#       WHEN 115 IF ga_table_data[p_i].field115 <> ga_page_data_t.field115 OR ga_table_data[p_i].field115 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field115 END IF
#       WHEN 116 IF ga_table_data[p_i].field116 <> ga_page_data_t.field116 OR ga_table_data[p_i].field116 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field116 END IF
#       WHEN 117 IF ga_table_data[p_i].field117 <> ga_page_data_t.field117 OR ga_table_data[p_i].field117 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field117 END IF
#       WHEN 118 IF ga_table_data[p_i].field118 <> ga_page_data_t.field118 OR ga_table_data[p_i].field118 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field118 END IF
#       WHEN 119 IF ga_table_data[p_i].field119 <> ga_page_data_t.field119 OR ga_table_data[p_i].field119 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field119 END IF
#       WHEN 120 IF ga_table_data[p_i].field120 <> ga_page_data_t.field120 OR ga_table_data[p_i].field120 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field120 END IF
#       WHEN 121 IF ga_table_data[p_i].field121 <> ga_page_data_t.field121 OR ga_table_data[p_i].field121 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field121 END IF
#       WHEN 122 IF ga_table_data[p_i].field122 <> ga_page_data_t.field122 OR ga_table_data[p_i].field122 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field122 END IF
#       WHEN 123 IF ga_table_data[p_i].field123 <> ga_page_data_t.field123 OR ga_table_data[p_i].field123 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field123 END IF
#       WHEN 124 IF ga_table_data[p_i].field124 <> ga_page_data_t.field124 OR ga_table_data[p_i].field124 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field124 END IF
#       WHEN 125 IF ga_table_data[p_i].field125 <> ga_page_data_t.field125 OR ga_table_data[p_i].field125 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field125 END IF
#       WHEN 126 IF ga_table_data[p_i].field126 <> ga_page_data_t.field126 OR ga_table_data[p_i].field126 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field126 END IF
#       WHEN 127 IF ga_table_data[p_i].field127 <> ga_page_data_t.field127 OR ga_table_data[p_i].field127 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field127 END IF
#       WHEN 128 IF ga_table_data[p_i].field128 <> ga_page_data_t.field128 OR ga_table_data[p_i].field128 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field128 END IF
#       WHEN 129 IF ga_table_data[p_i].field129 <> ga_page_data_t.field129 OR ga_table_data[p_i].field129 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field129 END IF
#       WHEN 130 IF ga_table_data[p_i].field130 <> ga_page_data_t.field130 OR ga_table_data[p_i].field130 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field130 END IF
#       WHEN 131 IF ga_table_data[p_i].field131 <> ga_page_data_t.field131 OR ga_table_data[p_i].field131 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field131 END IF
#       WHEN 132 IF ga_table_data[p_i].field132 <> ga_page_data_t.field132 OR ga_table_data[p_i].field132 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field132 END IF
#       WHEN 133 IF ga_table_data[p_i].field133 <> ga_page_data_t.field133 OR ga_table_data[p_i].field133 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field133 END IF
#       WHEN 134 IF ga_table_data[p_i].field134 <> ga_page_data_t.field134 OR ga_table_data[p_i].field134 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field134 END IF
#       WHEN 135 IF ga_table_data[p_i].field135 <> ga_page_data_t.field135 OR ga_table_data[p_i].field135 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field135 END IF
#       WHEN 136 IF ga_table_data[p_i].field136 <> ga_page_data_t.field136 OR ga_table_data[p_i].field136 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field136 END IF
#       WHEN 137 IF ga_table_data[p_i].field137 <> ga_page_data_t.field137 OR ga_table_data[p_i].field137 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field137 END IF
#       WHEN 138 IF ga_table_data[p_i].field138 <> ga_page_data_t.field138 OR ga_table_data[p_i].field138 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field138 END IF
#       WHEN 139 IF ga_table_data[p_i].field139 <> ga_page_data_t.field139 OR ga_table_data[p_i].field139 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field139 END IF
#       WHEN 140 IF ga_table_data[p_i].field140 <> ga_page_data_t.field140 OR ga_table_data[p_i].field140 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field140 END IF
#       WHEN 141 IF ga_table_data[p_i].field141 <> ga_page_data_t.field141 OR ga_table_data[p_i].field141 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field141 END IF
#       WHEN 142 IF ga_table_data[p_i].field142 <> ga_page_data_t.field142 OR ga_table_data[p_i].field142 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field142 END IF
#       WHEN 143 IF ga_table_data[p_i].field143 <> ga_page_data_t.field143 OR ga_table_data[p_i].field143 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field143 END IF
#       WHEN 144 IF ga_table_data[p_i].field144 <> ga_page_data_t.field144 OR ga_table_data[p_i].field144 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field144 END IF
#       WHEN 145 IF ga_table_data[p_i].field145 <> ga_page_data_t.field145 OR ga_table_data[p_i].field145 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field145 END IF
#       WHEN 146 IF ga_table_data[p_i].field146 <> ga_page_data_t.field146 OR ga_table_data[p_i].field146 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field146 END IF
#       WHEN 147 IF ga_table_data[p_i].field147 <> ga_page_data_t.field147 OR ga_table_data[p_i].field147 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field147 END IF
#       WHEN 148 IF ga_table_data[p_i].field148 <> ga_page_data_t.field148 OR ga_table_data[p_i].field148 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field148 END IF
#       WHEN 149 IF ga_table_data[p_i].field149 <> ga_page_data_t.field149 OR ga_table_data[p_i].field149 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field149 END IF
#       WHEN 150 IF ga_table_data[p_i].field150 <> ga_page_data_t.field150 OR ga_table_data[p_i].field150 IS NULL THEN LET l_tag = 1 LET l_str=ga_page_data_t.field150 END IF
#         
#  END CASE
  #161215-00017#1 mark(e)
    RETURN l_tag
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003)
#                  RETURNING l_flag,l_total,l_sum_name
# Input parameter: p_k         栏位序号
#                : p_value     待汇总的值  
#                : p_gzic007   显示方式
#                : p_gzic003   group栏位序号
# Return code....: l_flag      true/flag
#                : l_total     汇总后值
#                : l_sum_name  显示名称
# Date & Author..: 2015/07/19 By chenjpa
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003)
DEFINE p_k          LIKE type_t.num5          #栏位位置
 DEFINE p_value      LIKE type_t.num26_10
 DEFINE p_gzic007    LIKE gzic_t.gzic007
 DEFINE p_gzic003    LIKE gzic_t.gzic002
DEFINE l_number     LIKE type_t.num20_6
DEFINE l_total      LIKE dzeb_t.dzeb003
DEFINE l_sum_name   STRING

#DEFINE l_scale      LIKE type_t.num5
DEFINE l_scale      LIKE type_t.num10   #160310-00006#1 mod 
DEFINE l_len        LIKE type_t.num10 
DEFINE l_space      LIKE type_t.num10
DEFINE l_i      LIKE type_t.num10   
 
 LET l_scale=g_qry_scale[p_k]

 IF g_qry_length[p_k] > 37 THEN
    LET l_len = 37
    LET l_space = g_qry_length[p_k] - 37
 ELSE
    LET l_len = g_qry_length[p_k]   
 END IF

LET l_total = l_space SPACES, azzi310_01_numfor(p_value,l_len-1,l_scale) 
#161213-00049 add(s)
IF g_qry_attr[p_k]='N301' OR g_qry_attr[p_k]='N302' OR g_qry_attr[p_k]='N305' THEN
   LET l_total = l_total,"%"
END IF
#161213-00049 add(e)
 CASE p_gzic007
     WHEN '1'
        LET l_sum_name = g_qry_feld[p_k] CLIPPED," ",             
                         g_sum_name[p_gzic003] CLIPPED,":"
     WHEN '2'
        LET l_sum_name = g_sum_name[p_gzic003] CLIPPED,":"
     OTHERWISE 
        LET l_sum_name = ""
        FOR l_i = 1 TO g_qry_length[p_k]
            LET l_sum_name = l_sum_name,"-" 
        END FOR
 END CASE

 RETURN 1,l_total,l_sum_name
 
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzi310_01_group_sum(p_k,p_i,p_value,p_gzic005,p_gzic007,p_gzic003))
#                
# Input parameter: p_k   栏位位置
#                : p_i   行数
#                : p_value  值
#                : p_gzic005 group栏位位置
#                : p_gzic007 显示方式
#                : p_gzic003 group顺序
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/07/19 by chenjpa
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_01_group_sum(p_k,p_i,p_value,p_gzic005,p_gzic007,p_gzic003)
 DEFINE p_k          LIKE type_t.num5          #栏位位置
  # 160310-00006#1 mod(s)
# DEFINE p_i          LIKE type_t.num5          ##目前所在的行數
# DEFINE p_gzic005    LIKE type_t.num5          #group 栏位位置
# DEFINE p_gzic003    LIKE type_t.num5
 DEFINE p_i          LIKE type_t.num10          ##目前所在的行數
 DEFINE p_gzic005    LIKE type_t.num10          #group 栏位位置
 DEFINE p_gzic003    LIKE type_t.num10
  # 160310-00006#1 mod(e)
 DEFINE l_status   LIKE type_t.num5
 DEFINE l_str      LIKE dzeb_t.dzeb003
  DEFINE p_value      LIKE type_t.num26_10
 DEFINE p_gzic007    LIKE gzic_t.gzic007
 DEFINE l_sum_name   STRING
 DEFINE p_gzic003_type LIKE gzic_t.gzic003
 DEFINE l_gzic003      LIKE gzic_t.gzic002
 
       LET ga_sum_row[p_gzic005,p_i]=p_i
  
      CASE p_k 
       WHEN   1  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field001=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field001=l_str END IF
       WHEN   2  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field002=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field002=l_str END IF
       WHEN   3  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field003=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field003=l_str END IF
       WHEN   4  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field004=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field004=l_str END IF
       WHEN   5  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field005=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field005=l_str END IF
       WHEN   6  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field006=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field006=l_str END IF
       WHEN   7  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field007=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field007=l_str END IF
       WHEN   8  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field008=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field008=l_str END IF
       WHEN   9  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field009=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field009=l_str END IF
       WHEN  10  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field010=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field010=l_str END IF
       WHEN  11  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field011=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field011=l_str END IF
       WHEN  12  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field012=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field012=l_str END IF
       WHEN  13  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field013=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field013=l_str END IF
       WHEN  14  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field014=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field014=l_str END IF
       WHEN  15  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field015=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field015=l_str END IF
       WHEN  16  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field016=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field016=l_str END IF
       WHEN  17  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field017=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field017=l_str END IF
       WHEN  18  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field018=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field018=l_str END IF
       WHEN  19  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field019=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field019=l_str END IF
       WHEN  20  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field020=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field020=l_str END IF
       WHEN  21  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field021=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field021=l_str END IF
       WHEN  22  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field022=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field022=l_str END IF
       WHEN  23  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field023=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field023=l_str END IF
       WHEN  24  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field024=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field024=l_str END IF
       WHEN  25  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field025=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field025=l_str END IF
       WHEN  26  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field026=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field026=l_str END IF
       WHEN  27  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field027=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field027=l_str END IF
       WHEN  28  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field028=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field028=l_str END IF
       WHEN  29  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field029=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field029=l_str END IF
       WHEN  30  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field030=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field030=l_str END IF
       WHEN  31  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field031=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field031=l_str END IF
       WHEN  32  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field032=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field032=l_str END IF
       WHEN  33  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field033=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field033=l_str END IF
       WHEN  34  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field034=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field034=l_str END IF
       WHEN  35  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field035=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field035=l_str END IF
       WHEN  36  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field036=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field036=l_str END IF
       WHEN  37  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field037=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field037=l_str END IF
       WHEN  38  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field038=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field038=l_str END IF
       WHEN  39  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field039=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field039=l_str END IF
       WHEN  40  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field040=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field040=l_str END IF
       WHEN  41  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field041=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field041=l_str END IF
       WHEN  42  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field042=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field042=l_str END IF
       WHEN  43  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field043=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field043=l_str END IF
       WHEN  44  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field044=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field044=l_str END IF
       WHEN  45  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field045=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field045=l_str END IF
       WHEN  46  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field046=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field046=l_str END IF
       WHEN  47  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field047=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field047=l_str END IF
       WHEN  48  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field048=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field048=l_str END IF
       WHEN  49  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field049=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field049=l_str END IF
       WHEN  50  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field050=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field050=l_str END IF
       WHEN  51  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field051=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field051=l_str END IF
       WHEN  52  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field052=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field052=l_str END IF
       WHEN  53  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field053=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field053=l_str END IF
       WHEN  54  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field054=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field054=l_str END IF
       WHEN  55  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field055=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field055=l_str END IF
       WHEN  56  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field056=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field056=l_str END IF
       WHEN  57  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field057=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field057=l_str END IF
       WHEN  58  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field058=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field058=l_str END IF
       WHEN  59  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field059=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field059=l_str END IF
       WHEN  60  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field060=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field060=l_str END IF
       WHEN  61  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field061=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field061=l_str END IF
       WHEN  62  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field062=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field062=l_str END IF
       WHEN  63  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field063=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field063=l_str END IF
       WHEN  64  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field064=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field064=l_str END IF
       WHEN  65  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field065=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field065=l_str END IF
       WHEN  66  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field066=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field066=l_str END IF
       WHEN  67  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field067=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field067=l_str END IF
       WHEN  68  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field068=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field068=l_str END IF
       WHEN  69  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field069=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field069=l_str END IF
       WHEN  70  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field070=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field070=l_str END IF
       WHEN  71  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field071=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field071=l_str END IF
       WHEN  72  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field072=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field072=l_str END IF
       WHEN  73  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field073=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field073=l_str END IF
       WHEN  74  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field074=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field074=l_str END IF
       WHEN  75  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field075=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field075=l_str END IF
       WHEN  76  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field076=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field076=l_str END IF
       WHEN  77  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field077=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field077=l_str END IF
       WHEN  78  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field078=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field078=l_str END IF
       WHEN  79  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field079=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field079=l_str END IF
       WHEN  80  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field080=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field080=l_str END IF
       WHEN  81  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field081=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field081=l_str END IF
       WHEN  82  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field082=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field082=l_str END IF
       WHEN  83  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field083=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field083=l_str END IF
       WHEN  84  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field084=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field084=l_str END IF
       WHEN  85  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field085=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field085=l_str END IF
       WHEN  86  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field086=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field086=l_str END IF
       WHEN  87  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field087=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field087=l_str END IF
       WHEN  88  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field088=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field088=l_str END IF
       WHEN  89  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field089=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field089=l_str END IF
       WHEN  90  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field090=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field090=l_str END IF
       WHEN  91  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field091=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field091=l_str END IF
       WHEN  92  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field092=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field092=l_str END IF
       WHEN  93  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field093=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field093=l_str END IF
       WHEN  94  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field094=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field094=l_str END IF
       WHEN  95  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field095=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field095=l_str END IF
       WHEN  96  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field096=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field096=l_str END IF
       WHEN  97  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field097=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field097=l_str END IF
       WHEN  98  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field098=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field098=l_str END IF
       WHEN  99  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field099=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field099=l_str END IF
       WHEN 100  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field100=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field100=l_str END IF    
       WHEN 101  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field101=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field101=l_str END IF
       WHEN 102  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field102=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field102=l_str END IF
       WHEN 103  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field103=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field103=l_str END IF
       WHEN 104  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field104=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field104=l_str END IF
       WHEN 105  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field105=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field105=l_str END IF
       WHEN 106  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field106=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field106=l_str END IF
       WHEN 107  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field107=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field107=l_str END IF
       WHEN 108  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field108=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field108=l_str END IF
       WHEN 109  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field109=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field109=l_str END IF
       WHEN 110  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field110=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field110=l_str END IF
       WHEN 111  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field111=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field111=l_str END IF
       WHEN 112  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field112=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field112=l_str END IF
       WHEN 113  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field113=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field113=l_str END IF
       WHEN 114  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field114=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field114=l_str END IF
       WHEN 115  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field115=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field115=l_str END IF
       WHEN 116  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field116=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field116=l_str END IF
       WHEN 117  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field117=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field117=l_str END IF
       WHEN 118  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field118=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field118=l_str END IF
       WHEN 119  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field119=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field119=l_str END IF
       WHEN 120  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field120=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field120=l_str END IF
       WHEN 121  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field121=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field121=l_str END IF
       WHEN 122  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field122=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field122=l_str END IF
       WHEN 123  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field123=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field123=l_str END IF
       WHEN 124  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field124=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field124=l_str END IF
       WHEN 125  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field125=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field125=l_str END IF
       WHEN 126  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field126=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field126=l_str END IF
       WHEN 127  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field127=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field127=l_str END IF
       WHEN 128  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field128=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field128=l_str END IF
       WHEN 129  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field129=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field129=l_str END IF
       WHEN 130  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field130=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field130=l_str END IF
       WHEN 131  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field131=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field131=l_str END IF
       WHEN 132  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field132=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field132=l_str END IF
       WHEN 133  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field133=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field133=l_str END IF
       WHEN 134  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field134=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field134=l_str END IF
       WHEN 135  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field135=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field135=l_str END IF
       WHEN 136  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field136=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field136=l_str END IF
       WHEN 137  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field137=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field137=l_str END IF
       WHEN 138  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field138=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field138=l_str END IF
       WHEN 139  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field139=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field139=l_str END IF
       WHEN 140  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field140=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field140=l_str END IF
       WHEN 141  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field141=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field141=l_str END IF
       WHEN 142  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field142=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field142=l_str END IF
       WHEN 143  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field143=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field143=l_str END IF
       WHEN 144  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field144=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field144=l_str END IF
       WHEN 145  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field145=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field145=l_str END IF
       WHEN 146  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field146=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field146=l_str END IF
       WHEN 147  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field147=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field147=l_str END IF
       WHEN 148  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field148=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field148=l_str END IF
       WHEN 149  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field149=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field149=l_str END IF
       WHEN 150  CALL azzi310_01_group_rec(p_k,p_value,p_gzic007,p_gzic003) RETURNING l_status,l_str,l_sum_name IF l_status THEN LET ga_sum_rec[p_gzic005,p_i,1].field150=l_sum_name  LET ga_sum_rec[p_gzic005,p_i,2].field150=l_str END IF       
     END CASE
     
END FUNCTION

################################################################################
# Descriptions...: 将数值依指定的打印长度及小数字数做FORMAT, 以便打
# Memo...........: 若值为 0 , 将传回 0.00, 并非空白.
# Usage..........: CALL azzi310_01_numfor(p_value,p_len,p_n)
#                  RETURNING  l_st
# Input parameter: p_value    數值
#                  p_len      最大可列印長度
#                             (voucher:輸入長度,非憑證:輸入p_zaa項目編號)
#                  p_n        指定小數位數
# Return code....: l_str      FORMAT後的數值, 以 CHAR 型態 RETURN
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/07/19
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_01_numfor(p_value,p_len,p_n)
DEFINE p_value      LIKE type_t.num26_10,         
          p_len,p_n     LIKE type_t.num5,            
          l_len         LIKE type_t.num5,           
          l_str         LIKE type_t.chr37,         
          l_length      LIKE type_t.num5,         
          i,j,k         LIKE type_t.num5         

   IF not cl_null(g_xml_rep) THEN
       LET l_len = g_w[p_len]              
   END IF
   IF l_len > 0 THEN LET p_len = l_len END IF 
   IF p_n IS NULL THEN LET p_n=0 END IF 
   LET p_value = azzi310_01_digcut(p_value,p_n)
   CASE WHEN p_n = 0  LET l_str = p_value USING '-,---,---,---,---,---,---,---,---,--&'
        WHEN p_n = 10 LET l_str = p_value USING '--,---,---,---,---,---,--&.&&&&&&&&&&'
        WHEN p_n = 9  LET l_str = p_value USING '---,---,---,---,---,---,--&.&&&&&&&&&'
        WHEN p_n = 8  LET l_str = p_value USING '----,---,---,---,---,---,--&.&&&&&&&&'
        WHEN p_n = 7  LET l_str = p_value USING '-,---,---,---,---,---,---,--&.&&&&&&&'
        WHEN p_n = 6  LET l_str = p_value USING '--,---,---,---,---,---,---,--&.&&&&&&'
        WHEN p_n = 5  LET l_str = p_value USING '---,---,---,---,---,---,---,--&.&&&&&'
        WHEN p_n = 4  LET l_str = p_value USING '----,---,---,---,---,---,---,--&.&&&&'
        WHEN p_n = 3  LET l_str = p_value USING '-,---,---,---,---,---,---,---,--&.&&&'
        WHEN p_n = 2  LET l_str = p_value USING '--,---,---,---,---,---,---,---,--&.&&'
        WHEN p_n = 1  LET l_str = p_value USING '---,---,---,---,---,---,---,---,--&.&'
   END CASE

   LET j=37                   
   LET i = j - p_len
   IF i <= 0 THEN            
        IF not cl_null(g_xml_rep) THEN
          LET i = 0
        ELSE
          LET i = 1
        END IF
   END IF

   LET l_length = 0

   #当传进的金额位数实际上大于所要求回传的位数时，该字段应show"*****" NO:0508
   #FOR k = 29 TO 1 STEP -1                     
   FOR k = 37 TO 1 STEP -1                      
       IF cl_null(l_str[k,k]) THEN EXIT FOR END IF
       LET l_length = l_length + 1
   END FOR
   IF l_length > p_len THEN
      #LET l_str = '*************************'
      LET i = j - l_length
      IF i < 0 THEN
            RETURN l_str
      END IF
      
   END IF


   IF not cl_null(g_xml_rep) THEN
     RETURN l_str[i+1,j]
   ELSE
     RETURN l_str[i,j]
   END IF

END FUNCTION

################################################################################
# Descriptions...: 依照输出选择,产生报表文件 
# Memo...........:
# Usage..........: CALL azzi310_01_o(p_type)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/07/19
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_01_o(p_type)
DEFINE p_type       LIKE type_t.chr1 
#DEFINE l_status     LIKE type_t.num10
#DEFINE l_url        STRING
#DEFINE output_name  STRING
#DEFINE l_sw         LIKE type_t.chr1 #CHI-DB0006
#DEFINE l_n          LIKE type_t.num5 #CHI-DB0006
#DEFINE l_waitsec    LIKE type_t.num5 #CHI-DB0006
#DEFINE l_buf        LIKE type_t.chr6 #CHI-DB0006
#DEFINE l_n2         LIKE type_t.num5 #CHI-DB0006
#DEFINE l_now_str    STRING              #CHI-DB0006
# 
#  LET g_mail_flag = FALSE 
#   LET g_out_type = p_type
#
#            LET l_now_str = YEAR(CURRENT) USING "####",MONTH(CURRENT) USING "&&",DAY(CURRENT) USING "&&","-",TIME(CURRENT)
#            LET l_now_str = cl_replace_str(l_now_str,":","")
#           LET output_name = g_query_prog CLIPPED,'_',g_user CLIPPED,'_',l_now_str
#
#
#   CASE g_out_type
#        WHEN 'T'
#               
#             LET output_name = output_name,'.txt'        
#             CALL azzi310_01_print(output_name)
#        WHEN 'E'
#             LET g_out_type = 'E'      
#             LET output_name = output_name,'.xls'         
#             CALL azzi310_01_print(output_name)
#             
#        WHEN 'P'
#             LET output_name = output_name,'.out'          
#             CALL azzi310_01_print(output_name)
#       
#        WHEN 'V'         
#             LET output_name = output_name,'.out'        
#             CALL azzi310_01_print(output_name)
#      
#   END CASE
#
# 
#   IF g_out_type NOT MATCHES "[PV]" THEN      
#      CALL azzi310_01_convert(output_name)
#   ELSE
#    
#      IF ms_codeset.getIndexOf("BIG5", 1) OR ( ms_codeset.getIndexOf("GB2312", 1) 
#       OR ms_codeset.getIndexOf("GBK", 1) OR ms_codeset.getIndexOf("GB18030", 1) )
#      THEN
#        IF ms_locale = "ZH_TW" AND g_lang = 'zh_CN' THEN
#           LET ms_codeset = "GB2312"
#        END IF
#        IF ms_locale = "ZH_CN" AND g_lang = 'zh_TW' THEN
#           LET ms_codeset = "BIG5"
#        END IF
#      END IF
#
#   END IF
# 
#     LET g_page_line = 0
#
#   IF g_out_type = 'V' THEN
##      IF cl_null(fgl_getenv("DBPRINT")) THEN
##         CALL cl_err_msg(NULL,"9064",NULL,-1)
##         RETURN
##      END IF
##      CALL azzi310_01_prt_lv(output_name,"1")
#   ELSE
#      IF g_out_type = 'P' THEN  #pdf输出
#            LET g_rlang = ''
#         RETURN
#      END IF
#      
#
#      IF g_mail_flag THEN
#         LET g_mail_tname = output_name
#      ELSE
#
#         LET l_url = FGL_GETENV("FGLASIP") CLIPPED, "/out/", output_name
#         CALL ui.Interface.frontCall("standard",
#                                     "shellexec",
#                                     ["EXPLORER \"" || l_url || "\""],
#                                     [l_status])
#         IF STATUS THEN
#         	  LET g_errparam.code = STATUS
#           LET g_errparam.extend ='Front End Call failed'
#            LET g_errparam.popup = TRUE
#            CALL cl_err()
#            RETURN
#         END IF
#         IF NOT l_status THEN
#           	LET g_errparam.code = '!'
#           LET g_errparam.extend ='Application execution failed'
#            LET g_errparam.popup = TRUE
#            CALL cl_err()
#            RETURN
#         END IF
#      END IF  
#   END IF
END FUNCTION

################################################################################
# Descriptions...: 进阶画面之条件选择 page
# Memo...........:
# Usage..........: CALL azzi310_01_option()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/07/19
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_01_option()
DEFINE   l_sql           STRING
DEFINE   l_n             LIKE type_t.num5
 
   INPUT BY NAME g_more.s1,g_more.s2,g_more.s3,g_more.t1,g_more.t2,g_more.t3,
         g_more.u1,g_more.u2,g_more.u3  WITHOUT DEFAULTS 
 
     ON CHANGE s1
        IF g_more.s1 IS NOT NULL THEN
           IF (g_more.s1 = g_more.s2) OR (g_more.s1 = g_more.s3) THEN
           		LET g_errparam.code = '-239'
              LET g_errparam.extend =g_more.s1
              LET g_errparam.popup = FALSE
              CALL cl_err()             
              NEXT FIELD s1
           END IF
        END IF
 
     ON CHANGE s2
        IF g_more.s2 IS NOT NULL THEN
           IF (g_more.s2 = g_more.s1) OR (g_more.s2 = g_more.s3) THEN
              LET g_errparam.code = '-239'
              LET g_errparam.extend =g_more.s2
              LET g_errparam.popup = FALSE
              CALL cl_err()
              NEXT FIELD s2
           END IF
        END IF
 
     ON CHANGE s3
        IF g_more.s3 IS NOT NULL THEN
           IF (g_more.s3 = g_more.s1) OR (g_more.s3 = g_more.s2) THEN
              LET g_errparam.code = '-239'
              LET g_errparam.extend =g_more.s3
              LET g_errparam.popup = FALSE
              CALL cl_err()
              NEXT FIELD s3
           END IF
        END IF
 
     ON CHANGE u1
        IF g_more.u1 = 'Y' THEN       
           CALL cl_set_comp_visible("page_sum1", TRUE)           
        ELSE
           CALL cl_set_comp_visible("page_sum1", FALSE) 
           CALL g_gzic_d1.clear()
        END IF
 
     ON CHANGE u2
        IF g_more.u2 = 'Y' THEN
           CALL cl_set_comp_visible("page_sum2", TRUE)                 
        ELSE
           CALL cl_set_comp_visible("page_sum2", FALSE) 
           CALL g_gzic_d2.clear()
        END IF
 
     ON CHANGE u3
        IF g_more.u3 = 'Y' THEN          
           CALL cl_set_comp_visible("page_sum3", TRUE)           
        ELSE
           CALL cl_set_comp_visible("page_sum3", FALSE) 
           CALL g_gzic_d3.clear()
        END IF
 
     ON ACTION page_display
        LET g_action_choice = "page_display"
        ACCEPT INPUT
 
     ON ACTION page_sum1 
        LET g_action_choice = "page_sum1"
        ACCEPT INPUT
 
     ON ACTION page_sum2
        LET g_action_choice = "page_sum2"
        ACCEPT INPUT
       
     ON ACTION page_sum3
        LET g_action_choice = "page_sum3"
        ACCEPT INPUT
 
     ON ACTION accept                        
        LET g_action_choice="exit"
        ACCEPT INPUT
 
     ON ACTION exit1                             
        LET g_action_choice="exit"
        EXIT INPUT
 
     ON ACTION cancel
        LET INT_FLAG=FALSE             
        LET g_action_choice="exit"
        EXIT INPUT
 
      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE INPUT
 

      ON ACTION controlg
         CALL cl_cmdask()
 
   END INPUT 
END FUNCTION

################################################################################
# Descriptions...: 组合 SQL 语法排序条件(Order By)
# Memo...........:
# Usage..........: CALL azzi310_01_order()
#                  RETURNING l_next_tag
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/07/19 by chenjpa
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_01_order()
DEFINE l_next_tag      LIKE type_t.chr1
DEFINE l_str           STRING
DEFINE l_exe_str       STRING
DEFINE l_text          STRING
DEFINE l_order         STRING
DEFINE l_sql           STRING
DEFINE l_i             LIKE type_t.num5
DEFINE l_end           LIKE type_t.num10          
DEFINE l_tabname       STRING
DEFINE l_table_name    LIKE dzea_t.dzea001 
DEFINE l_j             LIKE type_t.num5


   LET l_next_tag = 'N'
   LET l_str = g_execmd.toLowerCase()
   LET l_exe_str = g_execmd
  
  #151214-00004#2 mark(s) #增加资料表别名的信息，解决一表多用问题
   #LET l_sql="select dzeb001 FROM dzeb_t where dzeb002 = ? "
   #DECLARE table2_cur CURSOR FROM l_sql
   #151214-00004#2 mark(e) 
 
   LET l_order = NULL
   FOR l_i = 1 TO g_gzib_d.getLength() 
#151214-00004#2 mark(s) #增加资料表别名的信息，解决一表多用问题
#      LET l_text = ""
#       FOREACH table2_cur USING g_gzib_d[l_i].gzib002 INTO l_table_name
#          LET l_tabname = l_table_name CLIPPED
#          LET l_tabname = l_tabname.toLowerCase()
#          LET l_end = l_str.getIndexOf(l_tabname,1)
#          IF l_end != 0 THEN
#              FOR l_j=1 to g_tab_cnt
#                 IF g_tab[l_j].tabname=l_tabname THEN
#                    IF g_tab[l_j].tabalias is not null THEN
#                       LET l_tabname=g_tab[l_j].tabalias
#                    END IF
#                    LET l_text = l_tabname,"."
#                    EXIT FOREACH
#                 END IF
#              END FOR
#          END IF
#       END FOREACH
#       IF cl_null(l_order) THEN 
#          LET l_order = l_text,g_gzib_d[l_i].gzib002 CLIPPED
#       ELSE
#            LET l_order = l_order,",",l_text,g_gzib_d[l_i].gzib002 CLIPPED
#       END IF
#151214-00004#2 mark(e) 
       #151214-00004#2 add(s) #增加资料表别名的信息，解决一表多用问题
       LET l_tabname=""
       IF not cl_null(g_gzib_d[l_i].gzib007) AND g_gzib_d[l_i].gzib007 !='user-def' THEN
          LET l_tabname=g_gzib_d[l_i].gzib007,"."
       END IF
       IF cl_null(l_order) THEN 
          LET l_order = l_tabname,g_gzib_d[l_i].gzib002 CLIPPED
       ELSE
            LET l_order = l_order,",",l_tabname,g_gzib_d[l_i].gzib002 CLIPPED
       END IF 
       #151214-00004#2 add(e) 
       IF g_gzib_d[l_i].gzib006 = '2' THEN
          LET l_order = l_order ," DESC"
       END IF
       IF g_gzib_d[l_i].gzib004 = 'Y' AND l_next_tag ='N' THEN
           LET l_next_tag = 'Y'
           #161215-00017#1 add(s)
           LET g_next_flag = 'Y'
           LET g_next_pos = l_i
           #161215-00017#1 add(e)
       END IF
   END FOR
   IF NOT cl_null(l_order) THEN
      LET l_end = l_str.getIndexOf('order by',1)
      IF l_end = 0 THEN
         LET l_exe_str = l_exe_str," order by ",l_order
      ELSE
         LET l_exe_str = l_exe_str.subString(1,l_end-1),"order by ",l_order ,
                     l_exe_str.subString(l_end+8,l_str.getLength())
      END IF
   END IF
   LET g_execmd = l_exe_str
 
   RETURN l_next_tag 
   
END FUNCTION

################################################################################
# Descriptions...: 多格式输出选择:
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/07/19 
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_01_output()
#DEFINE l_choice         LIKE type_t.chr1
#
#   LET g_mail_flag = FALSE 
# 
#   MENU "output" ATTRIBUTE(STYLE="popup")
#        # ON ACTION output_t
#            # CALL azzi310_01_o('T')
#            # EXIT MENU
# 
#         ON ACTION output_x
#             CALL azzi310_01_o('E')
#             EXIT MENU
# 
#         #ON ACTION output_p
#           #  CALL azzi310_01_o('P')
#           #  EXIT MENU
#
#         #ON ACTION output_m
#           #  LET g_mail_flag = TRUE
#           #  CALL azzi310_01_mail()
# 
#         ON IDLE g_idle_seconds
#             CALL cl_on_idle()
#             CONTINUE MENU
# 
#   END MENU
#   IF INT_FLAG THEN
#      LET INT_FLAG = 0
#   END IF
END FUNCTION

################################################################################
# Descriptions...: 依照 azzi310 输出格式设定产生报表
# Memo...........:
# Usage..........: CALLazzi310_01_print(p_name)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..:  2015/07/19 
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_01_print(p_name)
DEFINE p_name          STRING
#DEFINE l_cmd           STRING
#DEFINE l_i             LIKE type_t.num5
#DEFINE l_str           STRING
# 
#   LET l_cmd = 'rm -f ',p_name CLIPPED
#   RUN l_cmd
# 
#  LET g_next_tag = 'N'
#   LET g_max_tag = 0 
# 
#   CALL azzi310_01_sel('O')                      
#   CALL ui.Interface.refresh()
# 
#   IF g_query_rec_b < 1 THEN
#   	  LET g_errparam.code = 'lib-00073'
#     LET g_errparam.extend ='!'
#      LET g_errparam.popup = TRUE
#      RETURN
#   END IF
# 
#   LET g_curr_page = 1                            #目前頁數
# 
#      LET g_rec_b = ga_table_data.getLength()
#      LET g_total_page = 1
# 
#   CALL cl_progress_bar(g_total_page)
# 
#   CALL ui.Interface.refresh()        
# 
#   CASE g_out_type 
#      WHEN 'T'
#               LET l_str = "process: Text File"
#      WHEN 'P'
#               LET l_str = "process: Adobe Acrobat PDF "
#      WHEN 'E'
#               LET l_str = "process: Microsoft Office Excel"
#      WHEN 'V'                                                 
#               LET l_str = "process: Text File"              
#   END CASE
# 
#   FOR l_i = 1 TO g_total_page 
#       LET g_curr_page = l_i
#       CALL azzi310_01_loadPage()
#       IF g_out_type = 'E' THEN
#           CALl azzi310_01_excel(p_name,l_i)     
#       ELSE
##           CALL azzi310_01_txt(p_name)
#       END IF
#       CALL cl_progress_ing(l_str)
#   END FOR
END FUNCTION

################################################################################
# Descriptions...: 若字段有设定转换值，则将 SQL 字符串字段换成 DECODE & CASE 
# Memo...........:
# Usage..........: CALL azzi310_01_replace()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/07/19 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_01_replace()
DEFINE l_gzif            RECORD
                        gzif003    LIKE gzif_t.gzif003,
                        gzif004    LIKE gzif_t.gzif004,
                        gzif005    LIKE gzif_t.gzif005,
                        gzif006    LIKE gzif_t.gzif006
                        END RECORD
DEFINE buf              base.StringBuffer
DEFINE l_gzid002          LIKE gzid_t.gzid002
DEFINE l_gzid004          LIKE gzid_t.gzid004
DEFINE l_cnt            LIKE type_t.num10
DEFINE l_i              LIKE type_t.num10
DEFINE l_start          LIKE type_t.num10
DEFINE l_end            LIKE type_t.num10
DEFINE l_gzid004_o      STRING
DEFINE l_other          STRING
DEFINE l_sql            STRING
DEFINE l_decode_str     STRING
DEFINE l_str            STRING
DEFINE l_execmd         STRING                               
DEFINE l_p              LIKE type_t.num10                  
DEFINE l_field_lst      STRING                                


     SELECT COUNT(*) INTO l_cnt FROM gzif_t
      WHERE gzif001 = g_query_prog  
     IF l_cnt = 0 THEN
        RETURN
     END IF
 
     #若欄位為 select * from 時，需要將改為資料庫欄位,否則無法取代
     LET l_str = g_execmd.toLowerCase()
     LET l_start = l_str.getIndexOf('select',1)
     LET l_start = l_start + 7
     LET l_end = l_str.getIndexOf('from',1)
     LET l_execmd = g_execmd.subString(l_start,l_end-1)
     IF l_execmd.trim() = '*' THEN
        FOR l_i = 1 TO g_qry_feld_t.getlength() 
            IF cl_null(l_field_lst) THEN
               LET l_field_lst = g_qry_feld_t[l_i]
            ELSE 
               LET l_field_lst = l_field_lst ,',' ,g_qry_feld_t[l_i]
            END IF
        END FOR
        LET g_execmd = g_execmd.subString(1,7),l_field_lst,' ',g_execmd.subString(l_end,g_execmd.getLength())
     END IF 
    
     #------------------------------------------------------------------------  
     #DECODE 語法範例:
     #  SELECT DECODE (value,<if this value>,<return this value>,
     #                 <if this value>,<return this value>,
     #                 ....
     #                 <otherwise this value>)
     #CASE 語法範例:
     #  SELECT CASE WHEN (<column_value>= <value>) THEN
     #         WHEN (<column_value> = <value>) THEN
     #         ELSE <value>
     #    FROM <table_name>;
     #------------------------------------------------------------------------  
     LET l_sql="SELECT unique gzid002,gzid004 ",
               "  FROM gzid_t",
               "   WHERE gzid001='",g_query_prog CLIPPED,"' ",
               "     AND gzid012 ='Y' ",
               " ORDER BY gzid002" 
     DECLARE rep_item_cs CURSOR FROM l_sql
     FOREACH rep_item_cs INTO l_gzid002,l_gzid004

        LET l_decode_str = "CASE"
        LET l_other = ""
 
        LET l_str = g_execmd.toLowerCase()
        LET l_start = l_str.getIndexOf('select',1)
        LET l_start = l_start + 7
        LET l_end = l_str.getIndexOf('from',1)
        LET l_execmd = g_execmd.subString(l_start,l_end-1)
       
        LET l_p = l_str.getIndexOf(l_gzid004 CLIPPED,1)

        IF l_p < l_start THEN
            CONTINUE FOREACH
        END IF
        LET l_p = l_p + FGL_WIDTH(l_gzid004 CLIPPED) - 1
        FOR l_i = l_p TO  l_start STEP -1
            IF l_str.subString(l_i,l_i) = ',' THEN
               LET l_gzid004_o = g_execmd.subString(l_i+1,l_p)
               EXIT FOR
            ELSE
               IF l_i = l_start THEN
                  LET l_gzid004_o = g_execmd.subString(l_i,l_p)
               END IF
            END IF   
        END FOR
    
 
        LET l_sql="SELECT gzif003,gzif004,gzif005,gzif006 ",
                  "  FROM gzif_t",
                  " WHERE gzif001='",g_query_prog CLIPPED,"' ",
                  "   AND gzif002='",l_gzid002,"' ",     
                  " ORDER BY gzif003" 
        DECLARE rep_cs CURSOR FROM l_sql
        FOREACH rep_cs INTO l_gzif.*
           IF l_gzif.gzif005 = '2' THEN  
              SELECT gzze003 INTO l_gzif.gzif006 FROM gzze_t
                 WHERE gzze001= l_gzif.gzif006 AND gzze002 = g_lang  
           END IF
           IF l_gzif.gzif003 = '1' THEN
              LET l_decode_str = l_decode_str ,
                                 " WHEN (",l_gzid004_o ,"='",l_gzif.gzif004 CLIPPED,"')",
                                 " THEN '",l_gzif.gzif006 CLIPPED,"'"
           ELSE
              #otherwise this value
              LET l_other = " ELSE '",l_gzif.gzif006 CLIPPED,"'"
              IF l_decode_str = "CASE" THEN
                  LET l_other=" WHEN (1=2) THEN '1' ",l_other
              END IF
           END IF
        END FOREACH
        IF NOT cl_null(l_other) THEN
           LET l_decode_str = l_decode_str ,l_other
        ELSE
           LET l_decode_str = l_decode_str , " ELSE ", l_gzid004_o   
        END IF
   
        LET l_decode_str = l_decode_str, " END"
 
        LET l_execmd = l_execmd.trim(),','          
        LET l_gzid004_o = l_gzid004_o,','
        LET l_decode_str = l_decode_str,','

        LET buf = base.StringBuffer.create()
        CALL buf.append(l_execmd)
        CALL buf.replace(l_gzid004_o,l_decode_str, 0)
        LET l_execmd = buf.toString()

        LET l_execmd = l_execmd.subString(1,l_execmd.getLength()-1)
          
        LET g_execmd = g_execmd.subString(1,7),l_execmd,' ',g_execmd.subString(l_end,g_execmd.getLength())
 
     END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 将汇率格式千方位(逗号)拿掉
# Memo...........:
# Usage..........: CALLazzi310_01_replace_str(p_num, p_i)
# Input parameter: p_num  目前check的字段
#                  p_i    目前check的笔数
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/07/19
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_01_replace_str(p_num,p_i)
    DEFINE p_num          LIKE type_t.num10      #目前check的欄位
    DEFINE p_i            LIKE type_t.num10    #目前check的筆數
    
    CASE p_num
       WHEN   1  LET ga_table_data[p_i].field001 = cl_replace_str(ga_table_data[p_i].field001, ',', '') 
       WHEN   2  LET ga_table_data[p_i].field002 = cl_replace_str(ga_table_data[p_i].field002, ',', '') 
       WHEN   3  LET ga_table_data[p_i].field003 = cl_replace_str(ga_table_data[p_i].field003, ',', '') 
       WHEN   4  LET ga_table_data[p_i].field004 = cl_replace_str(ga_table_data[p_i].field004, ',', '') 
       WHEN   5  LET ga_table_data[p_i].field005 = cl_replace_str(ga_table_data[p_i].field005, ',', '') 
       WHEN   6  LET ga_table_data[p_i].field006 = cl_replace_str(ga_table_data[p_i].field006, ',', '') 
       WHEN   7  LET ga_table_data[p_i].field007 = cl_replace_str(ga_table_data[p_i].field007, ',', '') 
       WHEN   8  LET ga_table_data[p_i].field008 = cl_replace_str(ga_table_data[p_i].field008, ',', '') 
       WHEN   9  LET ga_table_data[p_i].field009 = cl_replace_str(ga_table_data[p_i].field009, ',', '') 
       WHEN  10  LET ga_table_data[p_i].field010 = cl_replace_str(ga_table_data[p_i].field010, ',', '') 
       WHEN  11  LET ga_table_data[p_i].field011 = cl_replace_str(ga_table_data[p_i].field011, ',', '') 
       WHEN  12  LET ga_table_data[p_i].field012 = cl_replace_str(ga_table_data[p_i].field012, ',', '') 
       WHEN  13  LET ga_table_data[p_i].field013 = cl_replace_str(ga_table_data[p_i].field013, ',', '') 
       WHEN  14  LET ga_table_data[p_i].field014 = cl_replace_str(ga_table_data[p_i].field014, ',', '') 
       WHEN  15  LET ga_table_data[p_i].field015 = cl_replace_str(ga_table_data[p_i].field015, ',', '') 
       WHEN  16  LET ga_table_data[p_i].field016 = cl_replace_str(ga_table_data[p_i].field016, ',', '') 
       WHEN  17  LET ga_table_data[p_i].field017 = cl_replace_str(ga_table_data[p_i].field017, ',', '') 
       WHEN  18  LET ga_table_data[p_i].field018 = cl_replace_str(ga_table_data[p_i].field018, ',', '') 
       WHEN  19  LET ga_table_data[p_i].field019 = cl_replace_str(ga_table_data[p_i].field019, ',', '') 
       WHEN  20  LET ga_table_data[p_i].field020 = cl_replace_str(ga_table_data[p_i].field020, ',', '') 
       WHEN  21  LET ga_table_data[p_i].field021 = cl_replace_str(ga_table_data[p_i].field021, ',', '') 
       WHEN  22  LET ga_table_data[p_i].field022 = cl_replace_str(ga_table_data[p_i].field022, ',', '') 
       WHEN  23  LET ga_table_data[p_i].field023 = cl_replace_str(ga_table_data[p_i].field023, ',', '') 
       WHEN  24  LET ga_table_data[p_i].field024 = cl_replace_str(ga_table_data[p_i].field024, ',', '') 
       WHEN  25  LET ga_table_data[p_i].field025 = cl_replace_str(ga_table_data[p_i].field025, ',', '') 
       WHEN  26  LET ga_table_data[p_i].field026 = cl_replace_str(ga_table_data[p_i].field026, ',', '') 
       WHEN  27  LET ga_table_data[p_i].field027 = cl_replace_str(ga_table_data[p_i].field027, ',', '') 
       WHEN  28  LET ga_table_data[p_i].field028 = cl_replace_str(ga_table_data[p_i].field028, ',', '') 
       WHEN  29  LET ga_table_data[p_i].field029 = cl_replace_str(ga_table_data[p_i].field029, ',', '') 
       WHEN  30  LET ga_table_data[p_i].field030 = cl_replace_str(ga_table_data[p_i].field030, ',', '') 
       WHEN  31  LET ga_table_data[p_i].field031 = cl_replace_str(ga_table_data[p_i].field031, ',', '') 
       WHEN  32  LET ga_table_data[p_i].field032 = cl_replace_str(ga_table_data[p_i].field032, ',', '') 
       WHEN  33  LET ga_table_data[p_i].field033 = cl_replace_str(ga_table_data[p_i].field033, ',', '') 
       WHEN  34  LET ga_table_data[p_i].field034 = cl_replace_str(ga_table_data[p_i].field034, ',', '') 
       WHEN  35  LET ga_table_data[p_i].field035 = cl_replace_str(ga_table_data[p_i].field035, ',', '') 
       WHEN  36  LET ga_table_data[p_i].field036 = cl_replace_str(ga_table_data[p_i].field036, ',', '') 
       WHEN  37  LET ga_table_data[p_i].field037 = cl_replace_str(ga_table_data[p_i].field037, ',', '') 
       WHEN  38  LET ga_table_data[p_i].field038 = cl_replace_str(ga_table_data[p_i].field038, ',', '') 
       WHEN  39  LET ga_table_data[p_i].field039 = cl_replace_str(ga_table_data[p_i].field039, ',', '') 
       WHEN  40  LET ga_table_data[p_i].field040 = cl_replace_str(ga_table_data[p_i].field040, ',', '') 
       WHEN  41  LET ga_table_data[p_i].field041 = cl_replace_str(ga_table_data[p_i].field041, ',', '') 
       WHEN  42  LET ga_table_data[p_i].field042 = cl_replace_str(ga_table_data[p_i].field042, ',', '') 
       WHEN  43  LET ga_table_data[p_i].field043 = cl_replace_str(ga_table_data[p_i].field043, ',', '') 
       WHEN  44  LET ga_table_data[p_i].field044 = cl_replace_str(ga_table_data[p_i].field044, ',', '') 
       WHEN  45  LET ga_table_data[p_i].field045 = cl_replace_str(ga_table_data[p_i].field045, ',', '') 
       WHEN  46  LET ga_table_data[p_i].field046 = cl_replace_str(ga_table_data[p_i].field046, ',', '') 
       WHEN  47  LET ga_table_data[p_i].field047 = cl_replace_str(ga_table_data[p_i].field047, ',', '') 
       WHEN  48  LET ga_table_data[p_i].field048 = cl_replace_str(ga_table_data[p_i].field048, ',', '') 
       WHEN  49  LET ga_table_data[p_i].field049 = cl_replace_str(ga_table_data[p_i].field049, ',', '') 
       WHEN  50  LET ga_table_data[p_i].field050 = cl_replace_str(ga_table_data[p_i].field050, ',', '') 
       WHEN  51  LET ga_table_data[p_i].field051 = cl_replace_str(ga_table_data[p_i].field051, ',', '') 
       WHEN  52  LET ga_table_data[p_i].field052 = cl_replace_str(ga_table_data[p_i].field052, ',', '') 
       WHEN  53  LET ga_table_data[p_i].field053 = cl_replace_str(ga_table_data[p_i].field053, ',', '') 
       WHEN  54  LET ga_table_data[p_i].field054 = cl_replace_str(ga_table_data[p_i].field054, ',', '') 
       WHEN  55  LET ga_table_data[p_i].field055 = cl_replace_str(ga_table_data[p_i].field055, ',', '') 
       WHEN  56  LET ga_table_data[p_i].field056 = cl_replace_str(ga_table_data[p_i].field056, ',', '') 
       WHEN  57  LET ga_table_data[p_i].field057 = cl_replace_str(ga_table_data[p_i].field057, ',', '') 
       WHEN  58  LET ga_table_data[p_i].field058 = cl_replace_str(ga_table_data[p_i].field058, ',', '') 
       WHEN  59  LET ga_table_data[p_i].field059 = cl_replace_str(ga_table_data[p_i].field059, ',', '') 
       WHEN  60  LET ga_table_data[p_i].field060 = cl_replace_str(ga_table_data[p_i].field060, ',', '') 
       WHEN  61  LET ga_table_data[p_i].field061 = cl_replace_str(ga_table_data[p_i].field061, ',', '') 
       WHEN  62  LET ga_table_data[p_i].field062 = cl_replace_str(ga_table_data[p_i].field062, ',', '') 
       WHEN  63  LET ga_table_data[p_i].field063 = cl_replace_str(ga_table_data[p_i].field063, ',', '') 
       WHEN  64  LET ga_table_data[p_i].field064 = cl_replace_str(ga_table_data[p_i].field064, ',', '') 
       WHEN  65  LET ga_table_data[p_i].field065 = cl_replace_str(ga_table_data[p_i].field065, ',', '') 
       WHEN  66  LET ga_table_data[p_i].field066 = cl_replace_str(ga_table_data[p_i].field066, ',', '') 
       WHEN  67  LET ga_table_data[p_i].field067 = cl_replace_str(ga_table_data[p_i].field067, ',', '') 
       WHEN  68  LET ga_table_data[p_i].field068 = cl_replace_str(ga_table_data[p_i].field068, ',', '') 
       WHEN  69  LET ga_table_data[p_i].field069 = cl_replace_str(ga_table_data[p_i].field069, ',', '') 
       WHEN  70  LET ga_table_data[p_i].field070 = cl_replace_str(ga_table_data[p_i].field070, ',', '') 
       WHEN  71  LET ga_table_data[p_i].field071 = cl_replace_str(ga_table_data[p_i].field071, ',', '') 
       WHEN  72  LET ga_table_data[p_i].field072 = cl_replace_str(ga_table_data[p_i].field072, ',', '') 
       WHEN  73  LET ga_table_data[p_i].field073 = cl_replace_str(ga_table_data[p_i].field073, ',', '') 
       WHEN  74  LET ga_table_data[p_i].field074 = cl_replace_str(ga_table_data[p_i].field074, ',', '') 
       WHEN  75  LET ga_table_data[p_i].field075 = cl_replace_str(ga_table_data[p_i].field075, ',', '') 
       WHEN  76  LET ga_table_data[p_i].field076 = cl_replace_str(ga_table_data[p_i].field076, ',', '') 
       WHEN  77  LET ga_table_data[p_i].field077 = cl_replace_str(ga_table_data[p_i].field077, ',', '') 
       WHEN  78  LET ga_table_data[p_i].field078 = cl_replace_str(ga_table_data[p_i].field078, ',', '') 
       WHEN  79  LET ga_table_data[p_i].field079 = cl_replace_str(ga_table_data[p_i].field079, ',', '') 
       WHEN  80  LET ga_table_data[p_i].field080 = cl_replace_str(ga_table_data[p_i].field080, ',', '') 
       WHEN  81  LET ga_table_data[p_i].field081 = cl_replace_str(ga_table_data[p_i].field081, ',', '') 
       WHEN  82  LET ga_table_data[p_i].field082 = cl_replace_str(ga_table_data[p_i].field082, ',', '') 
       WHEN  83  LET ga_table_data[p_i].field083 = cl_replace_str(ga_table_data[p_i].field083, ',', '') 
       WHEN  84  LET ga_table_data[p_i].field084 = cl_replace_str(ga_table_data[p_i].field084, ',', '') 
       WHEN  85  LET ga_table_data[p_i].field085 = cl_replace_str(ga_table_data[p_i].field085, ',', '') 
       WHEN  86  LET ga_table_data[p_i].field086 = cl_replace_str(ga_table_data[p_i].field086, ',', '') 
       WHEN  87  LET ga_table_data[p_i].field087 = cl_replace_str(ga_table_data[p_i].field087, ',', '') 
       WHEN  88  LET ga_table_data[p_i].field088 = cl_replace_str(ga_table_data[p_i].field088, ',', '') 
       WHEN  89  LET ga_table_data[p_i].field089 = cl_replace_str(ga_table_data[p_i].field089, ',', '') 
       WHEN  90  LET ga_table_data[p_i].field090 = cl_replace_str(ga_table_data[p_i].field090, ',', '') 
       WHEN  91  LET ga_table_data[p_i].field091 = cl_replace_str(ga_table_data[p_i].field091, ',', '') 
       WHEN  92  LET ga_table_data[p_i].field092 = cl_replace_str(ga_table_data[p_i].field092, ',', '') 
       WHEN  93  LET ga_table_data[p_i].field093 = cl_replace_str(ga_table_data[p_i].field093, ',', '') 
       WHEN  94  LET ga_table_data[p_i].field094 = cl_replace_str(ga_table_data[p_i].field094, ',', '') 
       WHEN  95  LET ga_table_data[p_i].field095 = cl_replace_str(ga_table_data[p_i].field095, ',', '') 
       WHEN  96  LET ga_table_data[p_i].field096 = cl_replace_str(ga_table_data[p_i].field096, ',', '') 
       WHEN  97  LET ga_table_data[p_i].field097 = cl_replace_str(ga_table_data[p_i].field097, ',', '') 
       WHEN  98  LET ga_table_data[p_i].field098 = cl_replace_str(ga_table_data[p_i].field098, ',', '') 
       WHEN  99  LET ga_table_data[p_i].field099 = cl_replace_str(ga_table_data[p_i].field099, ',', '') 
       WHEN 100  LET ga_table_data[p_i].field100 = cl_replace_str(ga_table_data[p_i].field100, ',', '')
       WHEN 101  LET ga_table_data[p_i].field100 = cl_replace_str(ga_table_data[p_i].field100, ',', '')
       WHEN 102  LET ga_table_data[p_i].field100 = cl_replace_str(ga_table_data[p_i].field100, ',', '')
       WHEN 103  LET ga_table_data[p_i].field100 = cl_replace_str(ga_table_data[p_i].field100, ',', '')
       WHEN 104  LET ga_table_data[p_i].field100 = cl_replace_str(ga_table_data[p_i].field100, ',', '')
       WHEN 105  LET ga_table_data[p_i].field100 = cl_replace_str(ga_table_data[p_i].field100, ',', '')
       WHEN 106  LET ga_table_data[p_i].field100 = cl_replace_str(ga_table_data[p_i].field100, ',', '')
       WHEN 107  LET ga_table_data[p_i].field100 = cl_replace_str(ga_table_data[p_i].field100, ',', '')
       WHEN 108  LET ga_table_data[p_i].field100 = cl_replace_str(ga_table_data[p_i].field100, ',', '')
       WHEN 109  LET ga_table_data[p_i].field100 = cl_replace_str(ga_table_data[p_i].field100, ',', '')
       WHEN 110  LET ga_table_data[p_i].field100 = cl_replace_str(ga_table_data[p_i].field100, ',', '')
       WHEN 111  LET ga_table_data[p_i].field100 = cl_replace_str(ga_table_data[p_i].field100, ',', '')
       WHEN 112  LET ga_table_data[p_i].field100 = cl_replace_str(ga_table_data[p_i].field100, ',', '')
       WHEN 113  LET ga_table_data[p_i].field100 = cl_replace_str(ga_table_data[p_i].field100, ',', '')
       WHEN 114  LET ga_table_data[p_i].field100 = cl_replace_str(ga_table_data[p_i].field100, ',', '')
       WHEN 115  LET ga_table_data[p_i].field100 = cl_replace_str(ga_table_data[p_i].field100, ',', '')
       WHEN 116  LET ga_table_data[p_i].field100 = cl_replace_str(ga_table_data[p_i].field100, ',', '')
       WHEN 117  LET ga_table_data[p_i].field100 = cl_replace_str(ga_table_data[p_i].field100, ',', '')
       WHEN 118  LET ga_table_data[p_i].field100 = cl_replace_str(ga_table_data[p_i].field100, ',', '')
       WHEN 119  LET ga_table_data[p_i].field100 = cl_replace_str(ga_table_data[p_i].field100, ',', '')
       WHEN 120  LET ga_table_data[p_i].field100 = cl_replace_str(ga_table_data[p_i].field100, ',', '')
       WHEN 121  LET ga_table_data[p_i].field100 = cl_replace_str(ga_table_data[p_i].field100, ',', '')
       WHEN 122  LET ga_table_data[p_i].field100 = cl_replace_str(ga_table_data[p_i].field100, ',', '')
       WHEN 123  LET ga_table_data[p_i].field100 = cl_replace_str(ga_table_data[p_i].field100, ',', '')
       WHEN 124  LET ga_table_data[p_i].field100 = cl_replace_str(ga_table_data[p_i].field100, ',', '')
       WHEN 125  LET ga_table_data[p_i].field100 = cl_replace_str(ga_table_data[p_i].field100, ',', '')
       WHEN 126  LET ga_table_data[p_i].field100 = cl_replace_str(ga_table_data[p_i].field100, ',', '')
       WHEN 127  LET ga_table_data[p_i].field100 = cl_replace_str(ga_table_data[p_i].field100, ',', '')
       WHEN 128  LET ga_table_data[p_i].field100 = cl_replace_str(ga_table_data[p_i].field100, ',', '')
       WHEN 129  LET ga_table_data[p_i].field100 = cl_replace_str(ga_table_data[p_i].field100, ',', '')
       WHEN 130  LET ga_table_data[p_i].field100 = cl_replace_str(ga_table_data[p_i].field100, ',', '')
       WHEN 131  LET ga_table_data[p_i].field100 = cl_replace_str(ga_table_data[p_i].field100, ',', '')
       WHEN 132  LET ga_table_data[p_i].field100 = cl_replace_str(ga_table_data[p_i].field100, ',', '')
       WHEN 133  LET ga_table_data[p_i].field100 = cl_replace_str(ga_table_data[p_i].field100, ',', '')
       WHEN 134  LET ga_table_data[p_i].field100 = cl_replace_str(ga_table_data[p_i].field100, ',', '')
       WHEN 135  LET ga_table_data[p_i].field100 = cl_replace_str(ga_table_data[p_i].field100, ',', '')
       WHEN 136  LET ga_table_data[p_i].field100 = cl_replace_str(ga_table_data[p_i].field100, ',', '')
       WHEN 137  LET ga_table_data[p_i].field100 = cl_replace_str(ga_table_data[p_i].field100, ',', '')
       WHEN 138  LET ga_table_data[p_i].field100 = cl_replace_str(ga_table_data[p_i].field100, ',', '')
       WHEN 139  LET ga_table_data[p_i].field100 = cl_replace_str(ga_table_data[p_i].field100, ',', '')
       WHEN 140  LET ga_table_data[p_i].field100 = cl_replace_str(ga_table_data[p_i].field100, ',', '')
       WHEN 141  LET ga_table_data[p_i].field100 = cl_replace_str(ga_table_data[p_i].field100, ',', '')
       WHEN 142  LET ga_table_data[p_i].field100 = cl_replace_str(ga_table_data[p_i].field100, ',', '')
       WHEN 143  LET ga_table_data[p_i].field100 = cl_replace_str(ga_table_data[p_i].field100, ',', '')
       WHEN 144  LET ga_table_data[p_i].field100 = cl_replace_str(ga_table_data[p_i].field100, ',', '')
       WHEN 145  LET ga_table_data[p_i].field100 = cl_replace_str(ga_table_data[p_i].field100, ',', '')
       WHEN 146  LET ga_table_data[p_i].field100 = cl_replace_str(ga_table_data[p_i].field100, ',', '')
       WHEN 147  LET ga_table_data[p_i].field100 = cl_replace_str(ga_table_data[p_i].field100, ',', '')
       WHEN 148  LET ga_table_data[p_i].field100 = cl_replace_str(ga_table_data[p_i].field100, ',', '')
       WHEN 149  LET ga_table_data[p_i].field100 = cl_replace_str(ga_table_data[p_i].field100, ',', '')
       WHEN 150  LET ga_table_data[p_i].field100 = cl_replace_str(ga_table_data[p_i].field100, ',', '')
    
    END CASE
END FUNCTION

################################################################################
# Descriptions...: 处理型态为日期的字段格式
# Memo...........:
# Usage..........: CALL azzi310_01_value((p_k,p_i))
#                  RETURNING 回传参数
# Input parameter: p_k   check的栏位
#                : p_i   check的笔数
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/07/19 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_01_value(p_k,p_i)
DEFINE p_k       LIKE type_t.num10       #目前check的欄位
DEFINE p_i       LIKE type_t.num10       #目前check的筆數
DEFINE l_date    STRING 

IF g_qry_feld_type[p_k] = 'date' THEN
      
      CASE p_k 
       WHEN   1 LET l_date = ga_table_data[p_i].field001  LET ga_table_data[p_i].field001 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN   2 LET l_date = ga_table_data[p_i].field002  LET ga_table_data[p_i].field002 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN   3 LET l_date = ga_table_data[p_i].field003  LET ga_table_data[p_i].field003 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN   4 LET l_date = ga_table_data[p_i].field004  LET ga_table_data[p_i].field004 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN   5 LET l_date = ga_table_data[p_i].field005  LET ga_table_data[p_i].field005 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN   6 LET l_date = ga_table_data[p_i].field006  LET ga_table_data[p_i].field006 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN   7 LET l_date = ga_table_data[p_i].field007  LET ga_table_data[p_i].field007 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN   8 LET l_date = ga_table_data[p_i].field008  LET ga_table_data[p_i].field008 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN   9 LET l_date = ga_table_data[p_i].field009  LET ga_table_data[p_i].field009 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  10 LET l_date = ga_table_data[p_i].field010  LET ga_table_data[p_i].field010 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  11 LET l_date = ga_table_data[p_i].field011  LET ga_table_data[p_i].field011 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  12 LET l_date = ga_table_data[p_i].field012  LET ga_table_data[p_i].field012 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  13 LET l_date = ga_table_data[p_i].field013  LET ga_table_data[p_i].field013 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  14 LET l_date = ga_table_data[p_i].field014  LET ga_table_data[p_i].field014 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  15 LET l_date = ga_table_data[p_i].field015  LET ga_table_data[p_i].field015 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  16 LET l_date = ga_table_data[p_i].field016  LET ga_table_data[p_i].field016 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  17 LET l_date = ga_table_data[p_i].field017  LET ga_table_data[p_i].field017 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  18 LET l_date = ga_table_data[p_i].field018  LET ga_table_data[p_i].field018 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  19 LET l_date = ga_table_data[p_i].field019  LET ga_table_data[p_i].field019 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  20 LET l_date = ga_table_data[p_i].field020  LET ga_table_data[p_i].field020 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  21 LET l_date = ga_table_data[p_i].field021  LET ga_table_data[p_i].field021 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  22 LET l_date = ga_table_data[p_i].field022  LET ga_table_data[p_i].field022 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  23 LET l_date = ga_table_data[p_i].field023  LET ga_table_data[p_i].field023 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  24 LET l_date = ga_table_data[p_i].field024  LET ga_table_data[p_i].field024 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  25 LET l_date = ga_table_data[p_i].field025  LET ga_table_data[p_i].field025 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  26 LET l_date = ga_table_data[p_i].field026  LET ga_table_data[p_i].field026 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  27 LET l_date = ga_table_data[p_i].field027  LET ga_table_data[p_i].field027 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  28 LET l_date = ga_table_data[p_i].field028  LET ga_table_data[p_i].field028 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  29 LET l_date = ga_table_data[p_i].field029  LET ga_table_data[p_i].field029 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  30 LET l_date = ga_table_data[p_i].field030  LET ga_table_data[p_i].field030 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  31 LET l_date = ga_table_data[p_i].field031  LET ga_table_data[p_i].field031 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  32 LET l_date = ga_table_data[p_i].field032  LET ga_table_data[p_i].field032 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  33 LET l_date = ga_table_data[p_i].field033  LET ga_table_data[p_i].field033 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  34 LET l_date = ga_table_data[p_i].field034  LET ga_table_data[p_i].field034 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  35 LET l_date = ga_table_data[p_i].field035  LET ga_table_data[p_i].field035 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  36 LET l_date = ga_table_data[p_i].field036  LET ga_table_data[p_i].field036 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  37 LET l_date = ga_table_data[p_i].field037  LET ga_table_data[p_i].field037 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  38 LET l_date = ga_table_data[p_i].field038  LET ga_table_data[p_i].field038 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  39 LET l_date = ga_table_data[p_i].field039  LET ga_table_data[p_i].field039 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  40 LET l_date = ga_table_data[p_i].field040  LET ga_table_data[p_i].field040 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  41 LET l_date = ga_table_data[p_i].field041  LET ga_table_data[p_i].field041 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  42 LET l_date = ga_table_data[p_i].field042  LET ga_table_data[p_i].field042 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  43 LET l_date = ga_table_data[p_i].field043  LET ga_table_data[p_i].field043 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  44 LET l_date = ga_table_data[p_i].field044  LET ga_table_data[p_i].field044 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  45 LET l_date = ga_table_data[p_i].field045  LET ga_table_data[p_i].field045 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  46 LET l_date = ga_table_data[p_i].field046  LET ga_table_data[p_i].field046 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  47 LET l_date = ga_table_data[p_i].field047  LET ga_table_data[p_i].field047 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  48 LET l_date = ga_table_data[p_i].field048  LET ga_table_data[p_i].field048 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  49 LET l_date = ga_table_data[p_i].field049  LET ga_table_data[p_i].field049 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  50 LET l_date = ga_table_data[p_i].field050  LET ga_table_data[p_i].field050 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  51 LET l_date = ga_table_data[p_i].field051  LET ga_table_data[p_i].field051 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  52 LET l_date = ga_table_data[p_i].field052  LET ga_table_data[p_i].field052 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  53 LET l_date = ga_table_data[p_i].field053  LET ga_table_data[p_i].field053 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  54 LET l_date = ga_table_data[p_i].field054  LET ga_table_data[p_i].field054 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  55 LET l_date = ga_table_data[p_i].field055  LET ga_table_data[p_i].field055 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  56 LET l_date = ga_table_data[p_i].field056  LET ga_table_data[p_i].field056 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  57 LET l_date = ga_table_data[p_i].field057  LET ga_table_data[p_i].field057 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  58 LET l_date = ga_table_data[p_i].field058  LET ga_table_data[p_i].field058 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  59 LET l_date = ga_table_data[p_i].field059  LET ga_table_data[p_i].field059 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  60 LET l_date = ga_table_data[p_i].field060  LET ga_table_data[p_i].field060 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  61 LET l_date = ga_table_data[p_i].field061  LET ga_table_data[p_i].field061 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  62 LET l_date = ga_table_data[p_i].field062  LET ga_table_data[p_i].field062 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  63 LET l_date = ga_table_data[p_i].field063  LET ga_table_data[p_i].field063 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  64 LET l_date = ga_table_data[p_i].field064  LET ga_table_data[p_i].field064 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  65 LET l_date = ga_table_data[p_i].field065  LET ga_table_data[p_i].field065 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  66 LET l_date = ga_table_data[p_i].field066  LET ga_table_data[p_i].field066 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  67 LET l_date = ga_table_data[p_i].field067  LET ga_table_data[p_i].field067 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  68 LET l_date = ga_table_data[p_i].field068  LET ga_table_data[p_i].field068 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  69 LET l_date = ga_table_data[p_i].field069  LET ga_table_data[p_i].field069 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  70 LET l_date = ga_table_data[p_i].field070  LET ga_table_data[p_i].field070 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  71 LET l_date = ga_table_data[p_i].field071  LET ga_table_data[p_i].field071 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  72 LET l_date = ga_table_data[p_i].field072  LET ga_table_data[p_i].field072 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  73 LET l_date = ga_table_data[p_i].field073  LET ga_table_data[p_i].field073 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  74 LET l_date = ga_table_data[p_i].field074  LET ga_table_data[p_i].field074 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  75 LET l_date = ga_table_data[p_i].field075  LET ga_table_data[p_i].field075 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  76 LET l_date = ga_table_data[p_i].field076  LET ga_table_data[p_i].field076 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  77 LET l_date = ga_table_data[p_i].field077  LET ga_table_data[p_i].field077 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  78 LET l_date = ga_table_data[p_i].field078  LET ga_table_data[p_i].field078 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  79 LET l_date = ga_table_data[p_i].field079  LET ga_table_data[p_i].field079 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  80 LET l_date = ga_table_data[p_i].field080  LET ga_table_data[p_i].field080 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  81 LET l_date = ga_table_data[p_i].field081  LET ga_table_data[p_i].field081 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  82 LET l_date = ga_table_data[p_i].field082  LET ga_table_data[p_i].field082 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  83 LET l_date = ga_table_data[p_i].field083  LET ga_table_data[p_i].field083 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  84 LET l_date = ga_table_data[p_i].field084  LET ga_table_data[p_i].field084 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  85 LET l_date = ga_table_data[p_i].field085  LET ga_table_data[p_i].field085 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  86 LET l_date = ga_table_data[p_i].field086  LET ga_table_data[p_i].field086 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  87 LET l_date = ga_table_data[p_i].field087  LET ga_table_data[p_i].field087 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  88 LET l_date = ga_table_data[p_i].field088  LET ga_table_data[p_i].field088 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  89 LET l_date = ga_table_data[p_i].field089  LET ga_table_data[p_i].field089 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  90 LET l_date = ga_table_data[p_i].field090  LET ga_table_data[p_i].field090 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  91 LET l_date = ga_table_data[p_i].field091  LET ga_table_data[p_i].field091 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  92 LET l_date = ga_table_data[p_i].field092  LET ga_table_data[p_i].field092 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  93 LET l_date = ga_table_data[p_i].field093  LET ga_table_data[p_i].field093 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  94 LET l_date = ga_table_data[p_i].field094  LET ga_table_data[p_i].field094 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  95 LET l_date = ga_table_data[p_i].field095  LET ga_table_data[p_i].field095 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  96 LET l_date = ga_table_data[p_i].field096  LET ga_table_data[p_i].field096 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  97 LET l_date = ga_table_data[p_i].field097  LET ga_table_data[p_i].field097 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  98 LET l_date = ga_table_data[p_i].field098  LET ga_table_data[p_i].field098 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN  99 LET l_date = ga_table_data[p_i].field099  LET ga_table_data[p_i].field099 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN 100 LET l_date = ga_table_data[p_i].field100  LET ga_table_data[p_i].field100 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN 101 LET l_date = ga_table_data[p_i].field101  LET ga_table_data[p_i].field101 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN 102 LET l_date = ga_table_data[p_i].field102  LET ga_table_data[p_i].field102 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN 103 LET l_date = ga_table_data[p_i].field103  LET ga_table_data[p_i].field103 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN 104 LET l_date = ga_table_data[p_i].field104  LET ga_table_data[p_i].field104 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN 105 LET l_date = ga_table_data[p_i].field105  LET ga_table_data[p_i].field105 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN 106 LET l_date = ga_table_data[p_i].field106  LET ga_table_data[p_i].field106 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN 107 LET l_date = ga_table_data[p_i].field107  LET ga_table_data[p_i].field107 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN 108 LET l_date = ga_table_data[p_i].field108  LET ga_table_data[p_i].field108 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN 109 LET l_date = ga_table_data[p_i].field109  LET ga_table_data[p_i].field109 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN 110 LET l_date = ga_table_data[p_i].field110  LET ga_table_data[p_i].field110 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN 111 LET l_date = ga_table_data[p_i].field111  LET ga_table_data[p_i].field111 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN 112 LET l_date = ga_table_data[p_i].field112  LET ga_table_data[p_i].field112 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN 113 LET l_date = ga_table_data[p_i].field113  LET ga_table_data[p_i].field113 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN 114 LET l_date = ga_table_data[p_i].field114  LET ga_table_data[p_i].field114 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN 115 LET l_date = ga_table_data[p_i].field115  LET ga_table_data[p_i].field115 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN 116 LET l_date = ga_table_data[p_i].field116  LET ga_table_data[p_i].field116 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN 117 LET l_date = ga_table_data[p_i].field117  LET ga_table_data[p_i].field117 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN 118 LET l_date = ga_table_data[p_i].field118  LET ga_table_data[p_i].field118 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN 119 LET l_date = ga_table_data[p_i].field119  LET ga_table_data[p_i].field119 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN 120 LET l_date = ga_table_data[p_i].field120  LET ga_table_data[p_i].field120 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN 121 LET l_date = ga_table_data[p_i].field121  LET ga_table_data[p_i].field121 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN 122 LET l_date = ga_table_data[p_i].field122  LET ga_table_data[p_i].field122 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN 123 LET l_date = ga_table_data[p_i].field123  LET ga_table_data[p_i].field123 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN 124 LET l_date = ga_table_data[p_i].field124  LET ga_table_data[p_i].field124 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN 125 LET l_date = ga_table_data[p_i].field125  LET ga_table_data[p_i].field125 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN 126 LET l_date = ga_table_data[p_i].field126  LET ga_table_data[p_i].field126 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN 127 LET l_date = ga_table_data[p_i].field127  LET ga_table_data[p_i].field127 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN 128 LET l_date = ga_table_data[p_i].field128  LET ga_table_data[p_i].field128 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN 129 LET l_date = ga_table_data[p_i].field129  LET ga_table_data[p_i].field129 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN 130 LET l_date = ga_table_data[p_i].field130  LET ga_table_data[p_i].field130 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN 131 LET l_date = ga_table_data[p_i].field131  LET ga_table_data[p_i].field131 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN 132 LET l_date = ga_table_data[p_i].field132  LET ga_table_data[p_i].field132 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN 133 LET l_date = ga_table_data[p_i].field133  LET ga_table_data[p_i].field133 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN 134 LET l_date = ga_table_data[p_i].field134  LET ga_table_data[p_i].field134 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN 135 LET l_date = ga_table_data[p_i].field135  LET ga_table_data[p_i].field135 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN 136 LET l_date = ga_table_data[p_i].field136  LET ga_table_data[p_i].field136 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN 137 LET l_date = ga_table_data[p_i].field137  LET ga_table_data[p_i].field137 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN 138 LET l_date = ga_table_data[p_i].field138  LET ga_table_data[p_i].field138 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN 139 LET l_date = ga_table_data[p_i].field139  LET ga_table_data[p_i].field139 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN 140 LET l_date = ga_table_data[p_i].field140  LET ga_table_data[p_i].field140 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN 141 LET l_date = ga_table_data[p_i].field141  LET ga_table_data[p_i].field141 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN 142 LET l_date = ga_table_data[p_i].field142  LET ga_table_data[p_i].field142 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN 143 LET l_date = ga_table_data[p_i].field143  LET ga_table_data[p_i].field143 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN 144 LET l_date = ga_table_data[p_i].field144  LET ga_table_data[p_i].field144 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN 145 LET l_date = ga_table_data[p_i].field145  LET ga_table_data[p_i].field145 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN 146 LET l_date = ga_table_data[p_i].field146  LET ga_table_data[p_i].field146 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN 147 LET l_date = ga_table_data[p_i].field147  LET ga_table_data[p_i].field147 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN 148 LET l_date = ga_table_data[p_i].field148  LET ga_table_data[p_i].field148 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN 149 LET l_date = ga_table_data[p_i].field149  LET ga_table_data[p_i].field149 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
       WHEN 150 LET l_date = ga_table_data[p_i].field150  LET ga_table_data[p_i].field150 = MDY(l_date.subString(6,7),l_date.subString(9,10),l_date.subString(1,4))
    
     END CASE
   END IF
 
   #將日期依指定的列印長度做 FORMAT
   CASE p_k 
    WHEN   1 IF FGL_WIDTH(ga_table_data[p_i].field001 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field001 = ga_table_data[p_i].field001.subString(1,g_qry_length[p_k]) END IF 
    WHEN   2 IF FGL_WIDTH(ga_table_data[p_i].field002 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field002 = ga_table_data[p_i].field002.subString(1,g_qry_length[p_k]) END IF 
    WHEN   3 IF FGL_WIDTH(ga_table_data[p_i].field003 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field003 = ga_table_data[p_i].field003.subString(1,g_qry_length[p_k]) END IF 
    WHEN   4 IF FGL_WIDTH(ga_table_data[p_i].field004 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field004 = ga_table_data[p_i].field004.subString(1,g_qry_length[p_k]) END IF 
    WHEN   5 IF FGL_WIDTH(ga_table_data[p_i].field005 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field005 = ga_table_data[p_i].field005.subString(1,g_qry_length[p_k]) END IF 
    WHEN   6 IF FGL_WIDTH(ga_table_data[p_i].field006 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field006 = ga_table_data[p_i].field006.subString(1,g_qry_length[p_k]) END IF 
    WHEN   7 IF FGL_WIDTH(ga_table_data[p_i].field007 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field007 = ga_table_data[p_i].field007.subString(1,g_qry_length[p_k]) END IF 
    WHEN   8 IF FGL_WIDTH(ga_table_data[p_i].field008 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field008 = ga_table_data[p_i].field008.subString(1,g_qry_length[p_k]) END IF 
    WHEN   9 IF FGL_WIDTH(ga_table_data[p_i].field009 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field009 = ga_table_data[p_i].field009.subString(1,g_qry_length[p_k]) END IF 
    WHEN  10 IF FGL_WIDTH(ga_table_data[p_i].field010 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field010 = ga_table_data[p_i].field010.subString(1,g_qry_length[p_k]) END IF 
    WHEN  11 IF FGL_WIDTH(ga_table_data[p_i].field011 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field011 = ga_table_data[p_i].field011.subString(1,g_qry_length[p_k]) END IF 
    WHEN  12 IF FGL_WIDTH(ga_table_data[p_i].field012 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field012 = ga_table_data[p_i].field012.subString(1,g_qry_length[p_k]) END IF 
    WHEN  13 IF FGL_WIDTH(ga_table_data[p_i].field013 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field013 = ga_table_data[p_i].field013.subString(1,g_qry_length[p_k]) END IF 
    WHEN  14 IF FGL_WIDTH(ga_table_data[p_i].field014 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field014 = ga_table_data[p_i].field014.subString(1,g_qry_length[p_k]) END IF 
    WHEN  15 IF FGL_WIDTH(ga_table_data[p_i].field015 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field015 = ga_table_data[p_i].field015.subString(1,g_qry_length[p_k]) END IF 
    WHEN  16 IF FGL_WIDTH(ga_table_data[p_i].field016 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field016 = ga_table_data[p_i].field016.subString(1,g_qry_length[p_k]) END IF 
    WHEN  17 IF FGL_WIDTH(ga_table_data[p_i].field017 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field017 = ga_table_data[p_i].field017.subString(1,g_qry_length[p_k]) END IF 
    WHEN  18 IF FGL_WIDTH(ga_table_data[p_i].field018 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field018 = ga_table_data[p_i].field018.subString(1,g_qry_length[p_k]) END IF 
    WHEN  19 IF FGL_WIDTH(ga_table_data[p_i].field019 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field019 = ga_table_data[p_i].field019.subString(1,g_qry_length[p_k]) END IF 
    WHEN  20 IF FGL_WIDTH(ga_table_data[p_i].field020 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field020 = ga_table_data[p_i].field020.subString(1,g_qry_length[p_k]) END IF 
    WHEN  21 IF FGL_WIDTH(ga_table_data[p_i].field021 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field021 = ga_table_data[p_i].field021.subString(1,g_qry_length[p_k]) END IF 
    WHEN  22 IF FGL_WIDTH(ga_table_data[p_i].field022 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field022 = ga_table_data[p_i].field022.subString(1,g_qry_length[p_k]) END IF 
    WHEN  23 IF FGL_WIDTH(ga_table_data[p_i].field023 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field023 = ga_table_data[p_i].field023.subString(1,g_qry_length[p_k]) END IF 
    WHEN  24 IF FGL_WIDTH(ga_table_data[p_i].field024 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field024 = ga_table_data[p_i].field024.subString(1,g_qry_length[p_k]) END IF 
    WHEN  25 IF FGL_WIDTH(ga_table_data[p_i].field025 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field025 = ga_table_data[p_i].field025.subString(1,g_qry_length[p_k]) END IF 
    WHEN  26 IF FGL_WIDTH(ga_table_data[p_i].field026 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field026 = ga_table_data[p_i].field026.subString(1,g_qry_length[p_k]) END IF 
    WHEN  27 IF FGL_WIDTH(ga_table_data[p_i].field027 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field027 = ga_table_data[p_i].field027.subString(1,g_qry_length[p_k]) END IF 
    WHEN  28 IF FGL_WIDTH(ga_table_data[p_i].field028 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field028 = ga_table_data[p_i].field028.subString(1,g_qry_length[p_k]) END IF 
    WHEN  29 IF FGL_WIDTH(ga_table_data[p_i].field029 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field029 = ga_table_data[p_i].field029.subString(1,g_qry_length[p_k]) END IF 
    WHEN  30 IF FGL_WIDTH(ga_table_data[p_i].field030 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field030 = ga_table_data[p_i].field030.subString(1,g_qry_length[p_k]) END IF 
    WHEN  31 IF FGL_WIDTH(ga_table_data[p_i].field031 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field031 = ga_table_data[p_i].field031.subString(1,g_qry_length[p_k]) END IF 
    WHEN  32 IF FGL_WIDTH(ga_table_data[p_i].field032 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field032 = ga_table_data[p_i].field032.subString(1,g_qry_length[p_k]) END IF 
    WHEN  33 IF FGL_WIDTH(ga_table_data[p_i].field033 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field033 = ga_table_data[p_i].field033.subString(1,g_qry_length[p_k]) END IF 
    WHEN  34 IF FGL_WIDTH(ga_table_data[p_i].field034 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field034 = ga_table_data[p_i].field034.subString(1,g_qry_length[p_k]) END IF 
    WHEN  35 IF FGL_WIDTH(ga_table_data[p_i].field035 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field035 = ga_table_data[p_i].field035.subString(1,g_qry_length[p_k]) END IF 
    WHEN  36 IF FGL_WIDTH(ga_table_data[p_i].field036 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field036 = ga_table_data[p_i].field036.subString(1,g_qry_length[p_k]) END IF 
    WHEN  37 IF FGL_WIDTH(ga_table_data[p_i].field037 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field037 = ga_table_data[p_i].field037.subString(1,g_qry_length[p_k]) END IF 
    WHEN  38 IF FGL_WIDTH(ga_table_data[p_i].field038 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field038 = ga_table_data[p_i].field038.subString(1,g_qry_length[p_k]) END IF 
    WHEN  39 IF FGL_WIDTH(ga_table_data[p_i].field039 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field039 = ga_table_data[p_i].field039.subString(1,g_qry_length[p_k]) END IF 
    WHEN  40 IF FGL_WIDTH(ga_table_data[p_i].field040 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field040 = ga_table_data[p_i].field040.subString(1,g_qry_length[p_k]) END IF 
    WHEN  41 IF FGL_WIDTH(ga_table_data[p_i].field041 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field041 = ga_table_data[p_i].field041.subString(1,g_qry_length[p_k]) END IF 
    WHEN  42 IF FGL_WIDTH(ga_table_data[p_i].field042 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field042 = ga_table_data[p_i].field042.subString(1,g_qry_length[p_k]) END IF 
    WHEN  43 IF FGL_WIDTH(ga_table_data[p_i].field043 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field043 = ga_table_data[p_i].field043.subString(1,g_qry_length[p_k]) END IF 
    WHEN  44 IF FGL_WIDTH(ga_table_data[p_i].field044 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field044 = ga_table_data[p_i].field044.subString(1,g_qry_length[p_k]) END IF 
    WHEN  45 IF FGL_WIDTH(ga_table_data[p_i].field045 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field045 = ga_table_data[p_i].field045.subString(1,g_qry_length[p_k]) END IF 
    WHEN  46 IF FGL_WIDTH(ga_table_data[p_i].field046 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field046 = ga_table_data[p_i].field046.subString(1,g_qry_length[p_k]) END IF 
    WHEN  47 IF FGL_WIDTH(ga_table_data[p_i].field047 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field047 = ga_table_data[p_i].field047.subString(1,g_qry_length[p_k]) END IF 
    WHEN  48 IF FGL_WIDTH(ga_table_data[p_i].field048 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field048 = ga_table_data[p_i].field048.subString(1,g_qry_length[p_k]) END IF 
    WHEN  49 IF FGL_WIDTH(ga_table_data[p_i].field049 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field049 = ga_table_data[p_i].field049.subString(1,g_qry_length[p_k]) END IF 
    WHEN  50 IF FGL_WIDTH(ga_table_data[p_i].field050 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field050 = ga_table_data[p_i].field050.subString(1,g_qry_length[p_k]) END IF 
    WHEN  51 IF FGL_WIDTH(ga_table_data[p_i].field051 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field051 = ga_table_data[p_i].field051.subString(1,g_qry_length[p_k]) END IF 
    WHEN  52 IF FGL_WIDTH(ga_table_data[p_i].field052 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field052 = ga_table_data[p_i].field052.subString(1,g_qry_length[p_k]) END IF 
    WHEN  53 IF FGL_WIDTH(ga_table_data[p_i].field053 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field053 = ga_table_data[p_i].field053.subString(1,g_qry_length[p_k]) END IF 
    WHEN  54 IF FGL_WIDTH(ga_table_data[p_i].field054 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field054 = ga_table_data[p_i].field054.subString(1,g_qry_length[p_k]) END IF 
    WHEN  55 IF FGL_WIDTH(ga_table_data[p_i].field055 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field055 = ga_table_data[p_i].field055.subString(1,g_qry_length[p_k]) END IF 
    WHEN  56 IF FGL_WIDTH(ga_table_data[p_i].field056 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field056 = ga_table_data[p_i].field056.subString(1,g_qry_length[p_k]) END IF 
    WHEN  57 IF FGL_WIDTH(ga_table_data[p_i].field057 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field057 = ga_table_data[p_i].field057.subString(1,g_qry_length[p_k]) END IF 
    WHEN  58 IF FGL_WIDTH(ga_table_data[p_i].field058 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field058 = ga_table_data[p_i].field058.subString(1,g_qry_length[p_k]) END IF 
    WHEN  59 IF FGL_WIDTH(ga_table_data[p_i].field059 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field059 = ga_table_data[p_i].field059.subString(1,g_qry_length[p_k]) END IF 
    WHEN  60 IF FGL_WIDTH(ga_table_data[p_i].field060 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field060 = ga_table_data[p_i].field060.subString(1,g_qry_length[p_k]) END IF 
    WHEN  61 IF FGL_WIDTH(ga_table_data[p_i].field061 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field061 = ga_table_data[p_i].field061.subString(1,g_qry_length[p_k]) END IF 
    WHEN  62 IF FGL_WIDTH(ga_table_data[p_i].field062 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field062 = ga_table_data[p_i].field062.subString(1,g_qry_length[p_k]) END IF 
    WHEN  63 IF FGL_WIDTH(ga_table_data[p_i].field063 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field063 = ga_table_data[p_i].field063.subString(1,g_qry_length[p_k]) END IF 
    WHEN  64 IF FGL_WIDTH(ga_table_data[p_i].field064 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field064 = ga_table_data[p_i].field064.subString(1,g_qry_length[p_k]) END IF 
    WHEN  65 IF FGL_WIDTH(ga_table_data[p_i].field065 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field065 = ga_table_data[p_i].field065.subString(1,g_qry_length[p_k]) END IF 
    WHEN  66 IF FGL_WIDTH(ga_table_data[p_i].field066 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field066 = ga_table_data[p_i].field066.subString(1,g_qry_length[p_k]) END IF 
    WHEN  67 IF FGL_WIDTH(ga_table_data[p_i].field067 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field067 = ga_table_data[p_i].field067.subString(1,g_qry_length[p_k]) END IF 
    WHEN  68 IF FGL_WIDTH(ga_table_data[p_i].field068 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field068 = ga_table_data[p_i].field068.subString(1,g_qry_length[p_k]) END IF 
    WHEN  69 IF FGL_WIDTH(ga_table_data[p_i].field069 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field069 = ga_table_data[p_i].field069.subString(1,g_qry_length[p_k]) END IF 
    WHEN  70 IF FGL_WIDTH(ga_table_data[p_i].field070 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field070 = ga_table_data[p_i].field070.subString(1,g_qry_length[p_k]) END IF 
    WHEN  71 IF FGL_WIDTH(ga_table_data[p_i].field071 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field071 = ga_table_data[p_i].field071.subString(1,g_qry_length[p_k]) END IF 
    WHEN  72 IF FGL_WIDTH(ga_table_data[p_i].field072 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field072 = ga_table_data[p_i].field072.subString(1,g_qry_length[p_k]) END IF 
    WHEN  73 IF FGL_WIDTH(ga_table_data[p_i].field073 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field073 = ga_table_data[p_i].field073.subString(1,g_qry_length[p_k]) END IF 
    WHEN  74 IF FGL_WIDTH(ga_table_data[p_i].field074 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field074 = ga_table_data[p_i].field074.subString(1,g_qry_length[p_k]) END IF 
    WHEN  75 IF FGL_WIDTH(ga_table_data[p_i].field075 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field075 = ga_table_data[p_i].field075.subString(1,g_qry_length[p_k]) END IF 
    WHEN  76 IF FGL_WIDTH(ga_table_data[p_i].field076 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field076 = ga_table_data[p_i].field076.subString(1,g_qry_length[p_k]) END IF 
    WHEN  77 IF FGL_WIDTH(ga_table_data[p_i].field077 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field077 = ga_table_data[p_i].field077.subString(1,g_qry_length[p_k]) END IF 
    WHEN  78 IF FGL_WIDTH(ga_table_data[p_i].field078 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field078 = ga_table_data[p_i].field078.subString(1,g_qry_length[p_k]) END IF 
    WHEN  79 IF FGL_WIDTH(ga_table_data[p_i].field079 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field079 = ga_table_data[p_i].field079.subString(1,g_qry_length[p_k]) END IF 
    WHEN  80 IF FGL_WIDTH(ga_table_data[p_i].field080 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field080 = ga_table_data[p_i].field080.subString(1,g_qry_length[p_k]) END IF 
    WHEN  81 IF FGL_WIDTH(ga_table_data[p_i].field081 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field081 = ga_table_data[p_i].field081.subString(1,g_qry_length[p_k]) END IF 
    WHEN  82 IF FGL_WIDTH(ga_table_data[p_i].field082 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field082 = ga_table_data[p_i].field082.subString(1,g_qry_length[p_k]) END IF 
    WHEN  83 IF FGL_WIDTH(ga_table_data[p_i].field083 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field083 = ga_table_data[p_i].field083.subString(1,g_qry_length[p_k]) END IF 
    WHEN  84 IF FGL_WIDTH(ga_table_data[p_i].field084 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field084 = ga_table_data[p_i].field084.subString(1,g_qry_length[p_k]) END IF 
    WHEN  85 IF FGL_WIDTH(ga_table_data[p_i].field085 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field085 = ga_table_data[p_i].field085.subString(1,g_qry_length[p_k]) END IF 
    WHEN  86 IF FGL_WIDTH(ga_table_data[p_i].field086 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field086 = ga_table_data[p_i].field086.subString(1,g_qry_length[p_k]) END IF 
    WHEN  87 IF FGL_WIDTH(ga_table_data[p_i].field087 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field087 = ga_table_data[p_i].field087.subString(1,g_qry_length[p_k]) END IF 
    WHEN  88 IF FGL_WIDTH(ga_table_data[p_i].field088 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field088 = ga_table_data[p_i].field088.subString(1,g_qry_length[p_k]) END IF 
    WHEN  89 IF FGL_WIDTH(ga_table_data[p_i].field089 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field089 = ga_table_data[p_i].field089.subString(1,g_qry_length[p_k]) END IF 
    WHEN  90 IF FGL_WIDTH(ga_table_data[p_i].field090 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field090 = ga_table_data[p_i].field090.subString(1,g_qry_length[p_k]) END IF 
    WHEN  91 IF FGL_WIDTH(ga_table_data[p_i].field091 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field091 = ga_table_data[p_i].field091.subString(1,g_qry_length[p_k]) END IF 
    WHEN  92 IF FGL_WIDTH(ga_table_data[p_i].field092 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field092 = ga_table_data[p_i].field092.subString(1,g_qry_length[p_k]) END IF 
    WHEN  93 IF FGL_WIDTH(ga_table_data[p_i].field093 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field093 = ga_table_data[p_i].field093.subString(1,g_qry_length[p_k]) END IF 
    WHEN  94 IF FGL_WIDTH(ga_table_data[p_i].field094 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field094 = ga_table_data[p_i].field094.subString(1,g_qry_length[p_k]) END IF 
    WHEN  95 IF FGL_WIDTH(ga_table_data[p_i].field095 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field095 = ga_table_data[p_i].field095.subString(1,g_qry_length[p_k]) END IF 
    WHEN  96 IF FGL_WIDTH(ga_table_data[p_i].field096 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field096 = ga_table_data[p_i].field096.subString(1,g_qry_length[p_k]) END IF 
    WHEN  97 IF FGL_WIDTH(ga_table_data[p_i].field097 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field097 = ga_table_data[p_i].field097.subString(1,g_qry_length[p_k]) END IF 
    WHEN  98 IF FGL_WIDTH(ga_table_data[p_i].field098 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field098 = ga_table_data[p_i].field098.subString(1,g_qry_length[p_k]) END IF 
    WHEN  99 IF FGL_WIDTH(ga_table_data[p_i].field099 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field099 = ga_table_data[p_i].field099.subString(1,g_qry_length[p_k]) END IF 
    WHEN 100 IF FGL_WIDTH(ga_table_data[p_i].field100 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field100 = ga_table_data[p_i].field100.subString(1,g_qry_length[p_k]) END IF 
    WHEN 101 IF FGL_WIDTH(ga_table_data[p_i].field101 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field101 = ga_table_data[p_i].field101.subString(1,g_qry_length[p_k]) END IF 
    WHEN 102 IF FGL_WIDTH(ga_table_data[p_i].field102 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field102 = ga_table_data[p_i].field102.subString(1,g_qry_length[p_k]) END IF 
    WHEN 103 IF FGL_WIDTH(ga_table_data[p_i].field103 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field103 = ga_table_data[p_i].field103.subString(1,g_qry_length[p_k]) END IF 
    WHEN 104 IF FGL_WIDTH(ga_table_data[p_i].field104 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field104 = ga_table_data[p_i].field104.subString(1,g_qry_length[p_k]) END IF 
    WHEN 105 IF FGL_WIDTH(ga_table_data[p_i].field105 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field105 = ga_table_data[p_i].field105.subString(1,g_qry_length[p_k]) END IF 
    WHEN 106 IF FGL_WIDTH(ga_table_data[p_i].field106 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field106 = ga_table_data[p_i].field106.subString(1,g_qry_length[p_k]) END IF 
    WHEN 107 IF FGL_WIDTH(ga_table_data[p_i].field107 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field107 = ga_table_data[p_i].field107.subString(1,g_qry_length[p_k]) END IF 
    WHEN 108 IF FGL_WIDTH(ga_table_data[p_i].field108 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field108 = ga_table_data[p_i].field108.subString(1,g_qry_length[p_k]) END IF 
    WHEN 109 IF FGL_WIDTH(ga_table_data[p_i].field109 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field109 = ga_table_data[p_i].field109.subString(1,g_qry_length[p_k]) END IF 
    WHEN 110 IF FGL_WIDTH(ga_table_data[p_i].field110 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field110 = ga_table_data[p_i].field110.subString(1,g_qry_length[p_k]) END IF 
    WHEN 111 IF FGL_WIDTH(ga_table_data[p_i].field111 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field111 = ga_table_data[p_i].field111.subString(1,g_qry_length[p_k]) END IF 
    WHEN 112 IF FGL_WIDTH(ga_table_data[p_i].field112 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field112 = ga_table_data[p_i].field112.subString(1,g_qry_length[p_k]) END IF 
    WHEN 113 IF FGL_WIDTH(ga_table_data[p_i].field113 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field113 = ga_table_data[p_i].field113.subString(1,g_qry_length[p_k]) END IF 
    WHEN 114 IF FGL_WIDTH(ga_table_data[p_i].field114 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field114 = ga_table_data[p_i].field114.subString(1,g_qry_length[p_k]) END IF 
    WHEN 115 IF FGL_WIDTH(ga_table_data[p_i].field115 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field115 = ga_table_data[p_i].field115.subString(1,g_qry_length[p_k]) END IF 
    WHEN 116 IF FGL_WIDTH(ga_table_data[p_i].field116 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field116 = ga_table_data[p_i].field116.subString(1,g_qry_length[p_k]) END IF 
    WHEN 117 IF FGL_WIDTH(ga_table_data[p_i].field117 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field117 = ga_table_data[p_i].field117.subString(1,g_qry_length[p_k]) END IF 
    WHEN 118 IF FGL_WIDTH(ga_table_data[p_i].field118 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field118 = ga_table_data[p_i].field118.subString(1,g_qry_length[p_k]) END IF 
    WHEN 119 IF FGL_WIDTH(ga_table_data[p_i].field119 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field119 = ga_table_data[p_i].field119.subString(1,g_qry_length[p_k]) END IF 
    WHEN 120 IF FGL_WIDTH(ga_table_data[p_i].field120 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field120 = ga_table_data[p_i].field120.subString(1,g_qry_length[p_k]) END IF 
    WHEN 121 IF FGL_WIDTH(ga_table_data[p_i].field121 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field121 = ga_table_data[p_i].field121.subString(1,g_qry_length[p_k]) END IF 
    WHEN 122 IF FGL_WIDTH(ga_table_data[p_i].field122 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field122 = ga_table_data[p_i].field122.subString(1,g_qry_length[p_k]) END IF 
    WHEN 123 IF FGL_WIDTH(ga_table_data[p_i].field123 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field123 = ga_table_data[p_i].field123.subString(1,g_qry_length[p_k]) END IF 
    WHEN 124 IF FGL_WIDTH(ga_table_data[p_i].field124 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field124 = ga_table_data[p_i].field124.subString(1,g_qry_length[p_k]) END IF 
    WHEN 125 IF FGL_WIDTH(ga_table_data[p_i].field125 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field125 = ga_table_data[p_i].field125.subString(1,g_qry_length[p_k]) END IF 
    WHEN 126 IF FGL_WIDTH(ga_table_data[p_i].field126 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field126 = ga_table_data[p_i].field126.subString(1,g_qry_length[p_k]) END IF 
    WHEN 127 IF FGL_WIDTH(ga_table_data[p_i].field127 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field127 = ga_table_data[p_i].field127.subString(1,g_qry_length[p_k]) END IF 
    WHEN 128 IF FGL_WIDTH(ga_table_data[p_i].field128 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field128 = ga_table_data[p_i].field128.subString(1,g_qry_length[p_k]) END IF 
    WHEN 129 IF FGL_WIDTH(ga_table_data[p_i].field129 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field129 = ga_table_data[p_i].field129.subString(1,g_qry_length[p_k]) END IF 
    WHEN 130 IF FGL_WIDTH(ga_table_data[p_i].field130 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field130 = ga_table_data[p_i].field130.subString(1,g_qry_length[p_k]) END IF 
    WHEN 131 IF FGL_WIDTH(ga_table_data[p_i].field131 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field131 = ga_table_data[p_i].field131.subString(1,g_qry_length[p_k]) END IF 
    WHEN 132 IF FGL_WIDTH(ga_table_data[p_i].field132 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field132 = ga_table_data[p_i].field132.subString(1,g_qry_length[p_k]) END IF 
    WHEN 133 IF FGL_WIDTH(ga_table_data[p_i].field133 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field133 = ga_table_data[p_i].field133.subString(1,g_qry_length[p_k]) END IF 
    WHEN 134 IF FGL_WIDTH(ga_table_data[p_i].field134 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field134 = ga_table_data[p_i].field134.subString(1,g_qry_length[p_k]) END IF 
    WHEN 135 IF FGL_WIDTH(ga_table_data[p_i].field135 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field135 = ga_table_data[p_i].field135.subString(1,g_qry_length[p_k]) END IF 
    WHEN 136 IF FGL_WIDTH(ga_table_data[p_i].field136 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field136 = ga_table_data[p_i].field136.subString(1,g_qry_length[p_k]) END IF 
    WHEN 137 IF FGL_WIDTH(ga_table_data[p_i].field137 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field137 = ga_table_data[p_i].field137.subString(1,g_qry_length[p_k]) END IF 
    WHEN 138 IF FGL_WIDTH(ga_table_data[p_i].field138 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field138 = ga_table_data[p_i].field138.subString(1,g_qry_length[p_k]) END IF 
    WHEN 139 IF FGL_WIDTH(ga_table_data[p_i].field139 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field139 = ga_table_data[p_i].field139.subString(1,g_qry_length[p_k]) END IF 
    WHEN 140 IF FGL_WIDTH(ga_table_data[p_i].field140 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field140 = ga_table_data[p_i].field140.subString(1,g_qry_length[p_k]) END IF 
    WHEN 141 IF FGL_WIDTH(ga_table_data[p_i].field141 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field141 = ga_table_data[p_i].field141.subString(1,g_qry_length[p_k]) END IF 
    WHEN 142 IF FGL_WIDTH(ga_table_data[p_i].field142 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field142 = ga_table_data[p_i].field142.subString(1,g_qry_length[p_k]) END IF 
    WHEN 143 IF FGL_WIDTH(ga_table_data[p_i].field143 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field143 = ga_table_data[p_i].field143.subString(1,g_qry_length[p_k]) END IF 
    WHEN 144 IF FGL_WIDTH(ga_table_data[p_i].field144 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field144 = ga_table_data[p_i].field144.subString(1,g_qry_length[p_k]) END IF 
    WHEN 145 IF FGL_WIDTH(ga_table_data[p_i].field145 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field145 = ga_table_data[p_i].field145.subString(1,g_qry_length[p_k]) END IF 
    WHEN 146 IF FGL_WIDTH(ga_table_data[p_i].field146 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field146 = ga_table_data[p_i].field146.subString(1,g_qry_length[p_k]) END IF 
    WHEN 147 IF FGL_WIDTH(ga_table_data[p_i].field147 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field147 = ga_table_data[p_i].field147.subString(1,g_qry_length[p_k]) END IF 
    WHEN 148 IF FGL_WIDTH(ga_table_data[p_i].field148 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field148 = ga_table_data[p_i].field148.subString(1,g_qry_length[p_k]) END IF 
    WHEN 149 IF FGL_WIDTH(ga_table_data[p_i].field149 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field149 = ga_table_data[p_i].field149.subString(1,g_qry_length[p_k]) END IF 
    WHEN 150 IF FGL_WIDTH(ga_table_data[p_i].field150 ) > g_qry_length[p_k] THEN LET ga_table_data[p_i].field150 = ga_table_data[p_i].field150.subString(1,g_qry_length[p_k]) END IF 
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
# Date & Author..: 2015/07/22  
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_01_digcut(p_value,p_digit)
   DEFINE p_value       LIKE type_t.num26_10, 
          p_digit       LIKE type_t.num5     

   WHENEVER ERROR CALL cl_err_msg_log
   IF p_digit IS NULL THEN LET p_digit=0 END IF 

   CASE
        WHEN p_digit = 10 LET p_value = p_value USING '--,---,---,---,---,---.----------'
        WHEN p_digit = 9 LET p_value = p_value USING '--,---,---,---,---,---.---------'
        WHEN p_digit = 8 LET p_value = p_value USING '--,---,---,---,---,---.--------'
        WHEN p_digit = 7 LET p_value = p_value USING '--,---,---,---,---,---.-------'
        WHEN p_digit = 6 LET p_value = p_value USING '--,---,---,---,---,---.------'
        WHEN p_digit = 5 LET p_value = p_value USING '--,---,---,---,---,---.-----'
        WHEN p_digit = 4 LET p_value = p_value USING '--,---,---,---,---,---.----'
        WHEN p_digit = 3 LET p_value = p_value USING '--,---,---,---,---,---.---'
        WHEN p_digit = 2 LET p_value = p_value USING '--,---,---,---,---,---.--'
        WHEN p_digit = 1 LET p_value = p_value USING '--,---,---,---,---,---.-'
        WHEN p_digit = 0 LET p_value = p_value USING '--,---,---,---,---,--&'
   END CASE
   RETURN p_value
   
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
# Date & Author..: 2015/07/22
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_01_settab()
DEFINE lw_w                  ui.window
DEFINE lfrm_curr               ui.Form
DEFINE ln_table_column       om.DomNode
DEFINE ln_edit,ln_w          om.DomNode
DEFINE ln_child              om.DomNode
DEFINE ln_table              om.DomNode
DEFINE ln_page               om.DomNode
DEFINE ln_group              om.DomNode
DEFINE ln_vbox               om.DomNode
DEFINE ls_items              om.NodeList
DEFINE ls_tables             om.NodeList
DEFINE ls_pages              om.NodeList
DEFINE l_i,l_k               LIKE type_t.num10
DEFINE l_title_cnt           LIKE type_t.num10
DEFINE l_width               LIKE type_t.num5
DEFINE ls_colname            STRING
DEFINE l_action              STRING
DEFINE l_items               STRING
DEFINE l_columns             STRING
 
        LET lw_w=ui.window.getcurrent()
        LET ln_w = lw_w.getNode()
        LET ls_items=ln_w.selectByTagName("TableColumn")
        #160523-00002#2 mod(s)
        FOR l_i = 0 TO g_qry_feld_cnt
       # FOR l_i = 1 TO g_qry_feld_cnt  
            #LET ln_table_column = ls_items.item(l_i)
            LET ln_table_column = ls_items.item(l_i+1)
            LET ln_edit = ln_table_column.getChildByIndex(1)
#            LET ls_colname = "field", l_i USING "&&&"
#            CALL ln_table_column.setAttribute("colName", ls_colname)
#            CALL ln_table_column.setAttribute("name", "formonly." || ls_colname)
           IF (l_i = 0) THEN
               CALL ln_table_column.setAttribute("text", " ")
               CALL ln_table_column.setAttribute("hidden", 0)
               CALL ln_table_column.setAttribute("noEntry", 0)
               CALL ln_edit.setAttribute("width", 1)
           ELSE
              CALL ln_table_column.setAttribute("text", g_qry_feld[l_i])
              IF g_qry_show[l_i] = 'Y' THEN
                 CALL ln_table_column.setAttribute("hidden", 0)
              ELSE
                CALL ln_table_column.setAttribute("hidden", 1)
              END IF
            
              CALL ln_edit.setAttribute("width", g_qry_length[l_i]+1)
         #   IF g_qry_feld_type[l_i]='number' OR  g_qry_feld_type[l_i]='NUMBER' THEN
             #150924-00005#1 add(s)
              IF g_qry_scale[l_i]>=0 OR NOT cl_null(g_qry_attr[l_i]) THEN     #161213-00049 mod
                 #CALL ln_table_column.setAttribute("sqlType", "NUMBER") #161213-00049 mark
                 CALL ln_edit.setAttribute("justify", "right")
#                 DISPLAY "fmt:",g_qry_fmt[l_i]
#                CALL ln_edit.setAttribute("format", g_qry_fmt[l_i])   
              END IF
            #150924-00005#1 add(e)
            #160523-00002#2 add(s)
              IF g_qry_flag[l_i]='Y' THEN
　　　　　　　　 CALL ln_table_column.setAttribute("noEntry",0)
               CALL ln_edit.setAttribute("color","blue")
               CALL ln_edit.setAttribute("underline",1)
             END IF
         END IF
            #160523-00002#2 add(e)
        END FOR
        #160523-00002#2 mark(s)
#        FOR l_i = g_qry_feld_cnt+1 TO GI_MAX_COLUMN_COUNT
#            LET ln_table_column = ls_items.item(l_i)
#            LET ls_colname = "field", l_i USING "&&&"
#            CALL ln_table_column.setAttribute("colName", ls_colname)
#            CALL ln_table_column.setAttribute("name", "formonly." || ls_colname)
#            CALL ln_table_column.setAttribute("text", ls_colname)
#            CALL ln_table_column.setAttribute("noEntry", 1)
#            CALL ln_table_column.setAttribute("hidden", 1)
#        END FOR
 #160523-00002#2 mark(e)
END FUNCTION

################################################################################
# Descriptions...: 產生空白字串
# Memo...........:
# Usage..........: azzi310_01_space(p_cnt)
#                  RETURNING l_str
# Input Parameter: p_cnt  字長長度 - 數值
# Return code....: l_str  字白字串
# Date & Author..: 2015/07/22
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_01_space(p_cnt)
DEFINE p_cnt     LIKE type_t.num10
DEFINE i         LIKE type_t.num10
DEFINE l_str     STRING
 
    LET l_str = ''
    FOR i = 1 TO p_cnt
        #LET l_str = l_str,' '
        LET l_str = l_str,' ' #160825-00014#1 add
    END FOR
 
    RETURN l_str
END FUNCTION

################################################################################
# Descriptions...: 進階畫面之計算式1設定 page
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/07/22
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_01_sum1()
DEFINE  p_cmd           LIKE type_t.chr1   
DEFINE  l_allow_insert  LIKE type_t.num5    
DEFINE  l_allow_delete  LIKE type_t.num5    
DEFINE  l_w_ac          LIKE type_t.num5
DEFINE  l_gzic1_t        RECORD                            #計算1(SUM)     
                       ngzid002_1   LIKE gzid_t.gzid002,    
                        ngzid004_1   LIKE gzid_t.gzid004,    
                        ngzidl004_1   LIKE gzidl_t.gzidl004,       
                        gzic003_1    LIKE gzic_t.gzic003,       
                        gzic007_1    LIKE gzic_t.gzic007       
                        END RECORD
DEFINE  l_i             LIKE type_t.num10
 
    LET l_allow_insert = cl_detail_input_auth("insert")
    LET l_allow_delete = cl_detail_input_auth("delete")
 
    LET l_w_ac = 1
    INPUT ARRAY g_gzic_d1 WITHOUT DEFAULTS FROM s_detail2.*
              ATTRIBUTE(COUNT= g_gzic_d1_rec_b,MAXCOUNT=g_max_rec,UNBUFFERED,
                        INSERT ROW=l_allow_insert,DELETE ROW=l_allow_delete,APPEND ROW=l_allow_insert)
      BEFORE ROW
         LET l_w_ac = ARR_CURR() 
         LET l_gzic1_t.* = g_gzic_d1[l_w_ac].*  
         LET p_cmd=''
         IF g_gzic_d1_rec_b >= l_w_ac THEN
            LET p_cmd='u'
         END IF
 
      BEFORE INSERT 
         LET p_cmd='a'
         LET g_gzic_d1[l_w_ac].gzic003_1 = "A"
         LET g_gzic_d1[l_w_ac].gzic007_1 = "1"
 
      AFTER FIELD ngzid004_1
         IF g_gzic_d1[l_w_ac].ngzid004_1 IS NOT NULL THEN
            IF p_cmd = "a" OR                    # 若輸入或更改且改KEY
              (p_cmd = "u" AND g_gzic_d1[l_w_ac].ngzid004_1 != l_gzic1_t.ngzid004_1) 
            THEN
               FOR l_i = 1 TO g_gzic_d1_rec_b
                   IF (g_gzic_d1[l_w_ac].ngzid004_1 = g_gzic_d1[l_i].ngzid004_1) AND
                      (l_i <> l_w_ac)  
                   THEN
                   	   LET g_errparam.code = '-239'
                       LET g_errparam.extend =g_gzic_d1[l_w_ac].ngzid004_1
                       LET g_errparam.popup = FALSE
                       CALL cl_err()
                       NEXT FIELD ngzid004_1
                   END IF
               END FOR
            END IF
         END IF 
 
      ON CHANGE ngzid004_1
         IF g_gzic_d1[l_w_ac].ngzid004_1 IS NOT NULL THEN
            LET g_gzic_d1[l_w_ac].ngzidl004_1=""       #151116-00008#1 mod
            
            SELECT unique(gzidl004) INTO g_gzic_d1[l_w_ac].ngzidl004_1   #151116-00008#1 mod
              FROM gzidl_t,gzid_t
             WHERE gzidl001=gzid001
               AND gzidl002=gzid002
               AND gzid004 = g_gzic_d1[l_w_ac].ngzid004_1 
               AND gzidl003 = g_lang 
               AND gzidl001 = g_query_prog

           IF cl_null(g_gzic_d1[l_w_ac].ngzidl004_1) THEN
              SELECT unique(dzebl003) INTO g_gzic_d1[l_w_ac].ngzidl004_1
                FROM dzebl_t
                WHERE dzebl001=g_gzic_d1[l_w_ac].ngzid004_1 
                  AND dzebl002=g_lang
           END IF
                                            
                                
            DISPLAY BY NAME g_gzic_d1[l_w_ac].ngzidl004_1
         END IF
 
      AFTER ROW
         LET l_w_ac = ARR_CURR()
         IF INT_FLAG THEN
            LET INT_FLAG = 0
            LET g_gzic_d1[l_w_ac].* = l_gzic1_t.*
            LET g_action_choice="exit"
            EXIT INPUT
         END IF
 
      AFTER INSERT
        IF INT_FLAG THEN
           LET g_errparam.code = '9001'
           LET g_errparam.extend =''
           LET g_errparam.popup = FALSE
           CALL cl_err()
           LET INT_FLAG = 0
           LET g_action_choice="exit"
           CANCEL INSERT
           EXIT INPUT
        END IF
        LET g_gzic_d1_rec_b = g_gzic_d1_rec_b +1
 
      BEFORE DELETE
        IF NOT cl_ask_delete() THEN
           CANCEL DELETE
        END IF
        LET g_gzic_d1_rec_b = g_gzic_d1_rec_b - 1
 
      ON ACTION page_display
         LET g_action_choice = "page_display"
         ACCEPT INPUT
 
      ON ACTION page_option 
         LET g_action_choice = "page_option"
         ACCEPT INPUT
 
      ON ACTION page_sum2
         LET g_action_choice = "page_sum2"
         ACCEPT INPUT
        
      ON ACTION page_sum3
         LET g_action_choice = "page_sum3"
         ACCEPT INPUT
        
 
 
 
      ON ACTION CONTROLF
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang)  
 
      ON ACTION accept                        
         LET g_action_choice="exit"
         ACCEPT INPUT
 
      ON ACTION exit                             
         LET g_action_choice="exit"
         EXIT INPUT
 
      ON ACTION cancel
         LET INT_FLAG=FALSE          
         LET g_action_choice="exit"
         EXIT INPUT
 
      ON IDLE g_idle_seconds
        CALL cl_on_idle()
        CONTINUE INPUT
  
      ON ACTION controlg
         CALL cl_cmdask()
 
   END INPUT
END FUNCTION

################################################################################
# Descriptions...: 進階畫面之計算式2設定 page
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/07/22
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_01_sum2()
DEFINE  p_cmd           LIKE type_t.chr1   
DEFINE  l_allow_insert  LIKE type_t.num5    
DEFINE  l_allow_delete  LIKE type_t.num5    
DEFINE  l_w_ac          LIKE type_t.num5
DEFINE  l_gzic2_t        RECORD                                 #計算2(SUM)     
                       ngzid002_2   LIKE gzid_t.gzid002,    
                        ngzid004_2   LIKE gzid_t.gzid004,    
                        ngzidl004_2   LIKE gzidl_t.gzidl004,       
                        gzic003_2    LIKE gzic_t.gzic003,       
                        gzic007_2    LIKE gzic_t.gzic007       
                        END RECORD
DEFINE  l_i             LIKE type_t.num10
 
    LET l_allow_insert = cl_detail_input_auth("insert")
    LET l_allow_delete = cl_detail_input_auth("delete")
 
    LET l_w_ac = 1
    INPUT ARRAY g_gzic_d2 WITHOUT DEFAULTS FROM s_detail3.*
              ATTRIBUTE(COUNT=g_gzic_d2_rec_b,MAXCOUNT=g_max_rec,UNBUFFERED,
                        INSERT ROW=l_allow_insert,DELETE ROW=l_allow_delete,APPEND ROW=l_allow_insert)
      BEFORE ROW
         LET l_w_ac = ARR_CURR() 
         LET l_gzic2_t.* = g_gzic_d2[l_w_ac].*  
         LET p_cmd=''
         IF g_gzic_d2_rec_b >= l_w_ac THEN
            LET p_cmd='u'
         END IF
 
      BEFORE INSERT 
         LET p_cmd='a'
         LET g_gzic_d2[l_w_ac].gzic003_2 = "A"
         LET g_gzic_d2[l_w_ac].gzic007_2 = "1"
 
      AFTER FIELD ngzid004_2
         IF g_gzic_d2[l_w_ac].ngzid004_2 IS NOT NULL THEN
            IF p_cmd = "a" OR                    # 若輸入或更改且改KEY
             (p_cmd = "u" AND g_gzic_d2[l_w_ac].ngzid004_2 != l_gzic2_t.ngzid004_2) THEN
               FOR l_i = 1 TO g_gzic_d2_rec_b
                   IF (g_gzic_d2[l_w_ac].ngzid004_2 = g_gzic_d2[l_i].ngzid004_2) AND
                      (l_i <> l_w_ac)  
                   THEN
                   	   LET g_errparam.code = '-239'
                      LET g_errparam.extend =g_gzic_d2[l_w_ac].ngzid004_2
                       LET g_errparam.popup = FALSE
                       CALL cl_err()
                       NEXT FIELD ngzid004_2
                   END IF
               END FOR
            END IF
         END IF 
 
      ON CHANGE ngzid004_2
         IF g_gzic_d2[l_w_ac].ngzid004_2 IS NOT NULL THEN
            LET g_gzic_d2[l_w_ac].ngzidl004_2=""          #151116-00008#1 mod
            
            SELECT unique(gzidl004) INTO g_gzic_d2[l_w_ac].ngzidl004_2
               FROM gzidl_t,gzid_t
             WHERE gzidl001=gzid001
               AND gzidl002=gzid002
               AND gzid004 = g_gzic_d2[l_w_ac].ngzid004_2 
               AND gzidl003 = g_lang 
               AND gzidl001 = g_query_prog

           IF cl_null(g_gzic_d2[l_w_ac].ngzidl004_2) THEN
              SELECT unique(dzebl003) INTO g_gzic_d2[l_w_ac].ngzidl004_2
                FROM dzebl_t
                WHERE dzebl001=g_gzic_d2[l_w_ac].ngzid004_2 
                  AND dzebl002=g_lang
           END IF                         
            DISPLAY BY NAME g_gzic_d2[l_w_ac].ngzidl004_2
         END IF
 
      AFTER ROW
         LET l_w_ac = ARR_CURR()
         IF INT_FLAG THEN
            LET INT_FLAG = 0
            LET g_gzic_d2[l_w_ac].* = l_gzic2_t.*
            LET g_action_choice="exit"
            EXIT INPUT
         END IF
 
      AFTER INSERT
        IF INT_FLAG THEN
           LET g_errparam.code = '9001'
          LET g_errparam.extend =''
           LET g_errparam.popup = FALSE
            CALL cl_err()        	
           LET INT_FLAG = 0
           LET g_action_choice="exit"
           CANCEL INSERT
           EXIT INPUT
        END IF
        LET g_gzic_d2_rec_b = g_gzic_d2_rec_b +1
 
      BEFORE DELETE
        IF NOT cl_ask_delete() THEN
           CANCEL DELETE
        END IF
        LET g_gzic_d2_rec_b = g_gzic_d2_rec_b - 1
 
      ON ACTION page_display
         LET g_action_choice = "page_display"
         ACCEPT INPUT
 
      ON ACTION page_option 
         LET g_action_choice = "page_option"
         ACCEPT INPUT
 
      ON ACTION page_sum1
         LET g_action_choice = "page_sum1"
         ACCEPT INPUT
        
      ON ACTION page_sum3
         LET g_action_choice = "page_sum3"
         ACCEPT INPUT
 
      ON ACTION CONTROLF
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang)  
 
      ON ACTION accept                        
         LET g_action_choice="exit"
         ACCEPT INPUT
 
      ON ACTION exit                             # Esc.結束
         LET g_action_choice="exit"
         EXIT INPUT
 
      ON ACTION cancel
         LET INT_FLAG=FALSE          
         LET g_action_choice="exit"
         EXIT INPUT
 
      ON IDLE g_idle_seconds
        CALL cl_on_idle()
        CONTINUE INPUT
 

      ON ACTION controlg
         CALL cl_cmdask()
 
   END INPUT
END FUNCTION

################################################################################
# Descriptions...: 進階畫面之計算式3設定 page
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/07/22
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_01_sum3()
DEFINE  p_cmd           LIKE type_t.chr1   
DEFINE  l_allow_insert  LIKE type_t.num5    
DEFINE  l_allow_delete  LIKE type_t.num5    
DEFINE  l_w_ac          LIKE type_t.num5
DEFINE  l_gzic3_t        RECORD                           #計算3(SUM)     
                       ngzid002_3   LIKE gzid_t.gzid002,    
                        ngzid004_3   LIKE gzid_t.gzid004,    
                        ngzidl004_3   LIKE gzidl_t.gzidl004,       
                        gzic003_3    LIKE gzic_t.gzic003,       
                        gzic007_3    LIKE gzic_t.gzic007       
                        END RECORD
DEFINE  l_i             LIKE type_t.num10
 
    LET l_allow_insert = cl_detail_input_auth("insert")
    LET l_allow_delete = cl_detail_input_auth("delete")
 
    LET l_w_ac = 1
    INPUT ARRAY g_gzic_d3 WITHOUT DEFAULTS FROM s_detail4.*
              ATTRIBUTE(COUNT=g_gzic_d3_rec_b ,MAXCOUNT=g_max_rec,UNBUFFERED,
                        INSERT ROW=l_allow_insert,DELETE ROW=l_allow_delete,APPEND ROW=l_allow_insert)
      BEFORE ROW
         LET l_w_ac = ARR_CURR() 
         LET l_gzic3_t.* = g_gzic_d3[l_w_ac].*  
         LET p_cmd=''
         IF g_gzic_d3_rec_b >= l_w_ac THEN
            LET p_cmd='u'
         END IF
 
      BEFORE INSERT 
         LET p_cmd='a'
         LET g_gzic_d3[l_w_ac].gzic003_3 = "A"
         LET g_gzic_d3[l_w_ac].gzic007_3 = "1"
 
      AFTER FIELD ngzid004_3
         IF g_gzic_d3[l_w_ac].ngzid004_3 IS NOT NULL THEN
            IF p_cmd = "a" OR                    # 若輸入或更改且改KEY
             (p_cmd = "u" AND g_gzic_d3[l_w_ac].ngzid004_3 != l_gzic3_t.ngzid004_3) THEN
               FOR l_i = 1 TO g_gzic_d3_rec_b
                   IF (g_gzic_d3[l_w_ac].ngzid004_3 = g_gzic_d3[l_i].ngzid004_3) AND
                      (l_i <> l_w_ac)  
                   THEN
                   	   LET g_errparam.code = '-239'
                      LET g_errparam.extend =g_gzic_d3[l_w_ac].ngzid004_3
                       LET g_errparam.popup = FALSE
                       CALL cl_err()                    
                       NEXT FIELD ngzid004_3
                   END IF
               END FOR
            END IF
         END IF 
      
      ON CHANGE ngzid004_3
         IF g_gzic_d3[l_w_ac].ngzid004_3 IS NOT NULL THEN      #151116-00008#1 mod
         
            LET g_gzic_d3[l_w_ac].ngzidl004_3=""
            SELECT unique(gzidl004) INTO g_gzic_d3[l_w_ac].ngzidl004_3
              FROM gzidl_t,gzid_t
             WHERE gzidl001=gzid001
               AND gzidl002=gzid002
               AND gzid004 = g_gzic_d3[l_w_ac].ngzid004_3 
               AND gzidl003 = g_lang 
               AND gzidl001 = g_query_prog

           IF cl_null(g_gzic_d3[l_w_ac].ngzidl004_3) THEN
              SELECT unique(dzebl003) INTO g_gzic_d3[l_w_ac].ngzidl004_3
                FROM dzebl_t
                WHERE dzebl001=g_gzic_d3[l_w_ac].ngzid004_3 
                  AND dzebl002=g_lang
           END IF                          
            DISPLAY BY NAME g_gzic_d3[l_w_ac].ngzidl004_3
         END IF
 
      AFTER ROW
         LET l_w_ac = ARR_CURR()
         IF INT_FLAG THEN
            LET INT_FLAG = 0
            LET g_gzic_d3[l_w_ac].* = l_gzic3_t.*
            LET g_action_choice="exit"
            EXIT INPUT
         END IF
 
      AFTER INSERT
        IF INT_FLAG THEN
           LET g_errparam.code = '9001'
           LET g_errparam.extend =''
           LET g_errparam.popup = FALSE
           CALL cl_err()
           LET INT_FLAG = 0
           LET g_action_choice="exit"
           CANCEL INSERT
           EXIT INPUT
        END IF
        LET g_gzic_d3_rec_b = g_gzic_d3_rec_b +1
 
      BEFORE DELETE
        IF NOT cl_ask_delete() THEN
           CANCEL DELETE
        END IF
        LET g_gzic_d3_rec_b = g_gzic_d3_rec_b - 1
 
 
      ON ACTION page_display
         LET g_action_choice = "page_display"
         ACCEPT INPUT
 
      ON ACTION page_option 
         LET g_action_choice = "page_option"
         ACCEPT INPUT
 
      ON ACTION page_sum1
         LET g_action_choice = "page_sum1"
         ACCEPT INPUT
        
      ON ACTION page_sum2
         LET g_action_choice = "page_sum2"
         ACCEPT INPUT
        
      ON ACTION CONTROLR
         CALL cl_show_req_fields()
 
      ON ACTION CONTROLF
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang) #Add on 040913
 
      ON ACTION accept                        
         LET g_action_choice="exit"
         ACCEPT INPUT
 
      ON ACTION exit                             # Esc.結束
         LET g_action_choice="exit"
         EXIT INPUT
 
      ON ACTION cancel
         LET INT_FLAG=FALSE          
         LET g_action_choice="exit"
         EXIT INPUT
 
      ON IDLE g_idle_seconds
        CALL cl_on_idle()
        CONTINUE INPUT
 
      ON ACTION controlg
         CALL cl_cmdask()
 
   END INPUT
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
# Date & Author..: 2015/07/22
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_01_excel_column()
# DEFINE l_str            STRING
#   DEFINE l_codeset        STRING
#   DEFINE l_cnt            LIKE type_t.num10               
# 
#   IF ms_codeset.getIndexOf("BIG5", 1) OR ( ms_codeset.getIndexOf("GB2312", 1) 
#    OR ms_codeset.getIndexOf("GBK", 1) OR ms_codeset.getIndexOf("GB18030", 1) )
#   THEN
#     IF ms_locale = "ZH_TW" AND g_lang = '2' THEN
#        LET ms_codeset = "GB2312"
#     END IF
#     IF ms_locale = "ZH_CN" AND g_lang = '0' THEN
#        LET ms_codeset = "BIG5"
#     END IF
#   END IF
# 
#   IF not ms_codeset.getIndexOf("UTF-8", 1) THEN
#      IF g_lang = "0" THEN
#         LET l_codeset = "big5"
#      ELSE
#         IF g_lang = "2" THEN 
#            IF ms_codeset.getIndexOf("GB2312", 1) THEN
#               LET l_codeset = "GB2312"
#            ELSE
#               IF ms_codeset.getIndexOf("GBK", 1) THEN
#                  LET l_codeset = "GBK"
#               ELSE
#                  IF ms_codeset.getIndexOf("GB18030", 1) THEN
#                     LET l_codeset = "GB18030"
#                  END IF
#               END IF
#            END IF
#         ELSE
#              LET l_codeset = "utf-8"
#         END IF
#      END IF
#   ELSE
#      LET l_codeset = "utf-8"
#   END IF
# 
# 
#   LET l_str ="<html xmlns:o=\"urn:schemas-microsoft-com:office:office\"",
#              "xmlns:x=\"urn:schemas-microsoft-com:office:excel\"",
#              "xmlns=\"http://www.w3.org/TR/REC-html40\">",
#              "<head>",
#              "<meta http-equiv=Content-Type content=\"text/html; charset=",l_codeset,"\">"
# 
#   LET l_str = l_str,"<style><!--"
#   IF not ms_codeset.getIndexOf("UTF-8", 1) THEN    
#       CASE g_lang
#          WHEN "0"
#              LET l_str = l_str,"td  {font-family:細明體, serif;}",
#                         " pre ",
#                     "{margin:0cm; ",
#                      " margin-bottom:.0001pt; ",
#                         " font-family:細明體;    ",
#                         " mso-bidi-font-family:\"Courier New\";} "
#          WHEN "2"
#              LET l_str = l_str,"td  {font-family:新宋体, serif;}",
#                         " pre ",
#                     "{margin:0cm; ",
#                      " margin-bottom:.0001pt; ",
#                         " font-family:新宋体;    ",
#                         " mso-bidi-font-family:\"Courier New\";} "
#          OTHERWISE
#              LET l_str = l_str,"td  {font-family:細明體, serif;}",
#                         " pre ",
#                     "{margin:0cm; ",
#                      " margin-bottom:.0001pt; ",              
#                         " font-family:細明體;    ",
#                         " mso-bidi-font-family:\"Courier New\";} "
#       END CASE
#   ELSE
#         LET l_str = l_str,"td  {font-family:細明體, serif;}",
#                     " pre ",
#                 "{margin:0cm; ",
#                  " margin-bottom:.0001pt; ",
#                     " font-family:細明體;    ",
#                     " mso-bidi-font-family:\"Courier New\";} "
#   END IF
# 
# 
#   LET l_str = l_str,
#       ".xl30 {mso-style-parent:style0; mso-number-format:\"\#\,\#\#0_ \";} ",
#       ".xl31 {mso-style-parent:style0; mso-number-format:\"\#\,\#\#0\.0_ \";} ",
#       ".xl32 {mso-style-parent:style0; mso-number-format:\"\#\,\#\#0\.00_ \";} ",
#       ".xl33 {mso-style-parent:style0; mso-number-format:\"\#\,\#\#0\.000_ \";} ",
#       ".xl34 {mso-style-parent:style0; mso-number-format:\"\#\,\#\#0\.0000_ \";} ",
#       ".xl35 {mso-style-parent:style0; mso-number-format:\"\#\,\#\#0\.00000_ \";} ",
#       ".xl36 {mso-style-parent:style0; mso-number-format:\"\#\,\#\#0\.000000_ \";} ",
#       ".xl37 {mso-style-parent:style0; mso-number-format:\"\#\,\#\#0\.0000000_ \";} ",
#       ".xl38 {mso-style-parent:style0; mso-number-format:\"\#\,\#\#0\.00000000_ \";} ",
#       ".xl39 {mso-style-parent:style0; mso-number-format:\"\#\,\#\#0\.000000000_ \";} ",
#       ".xl40 {mso-style-parent:style0; mso-number-format:\"\#\,\#\#0\.0000000000_ \";} ",
#       ".xl50 {mso-style-parent:style0; mso-number-format:\"0_ \";} ",
#       ".xl51 {mso-style-parent:style0; mso-number-format:\"0\.0_ \";} ",
#       ".xl52 {mso-style-parent:style0; mso-number-format:\"0\.00_ \";} ",
#       ".xl53 {mso-style-parent:style0; mso-number-format:\"0\.000_ \";} ",
#       ".xl54 {mso-style-parent:style0; mso-number-format:\"0\.0000_ \";} ",
#       ".xl55 {mso-style-parent:style0; mso-number-format:\"0\.00000_ \";} ",
#       ".xl56 {mso-style-parent:style0; mso-number-format:\"0\.000000_ \";} ",
#       ".xl57 {mso-style-parent:style0; mso-number-format:\"0\.0000000_ \";} ",
#       ".xl58 {mso-style-parent:style0; mso-number-format:\"0\.00000000_ \";} ",
#       ".xl59 {mso-style-parent:style0; mso-number-format:\"0\.000000000_ \";} ",
#       ".xl60 {mso-style-parent:style0; mso-number-format:\"0\.0000000000_ \";} "
# 
# 
#   LET l_str = l_str,".xl24  { mso-number-format:\"@\";}",
#              "--></style>",
#              "<!--[if gte mso 9]><xml>",
#              "<x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet>",
#              "<x:Name>Sheet1</x:Name><x:WorksheetOptions>",    
#              "<x:DefaultRowHeight>330</x:DefaultRowHeight>",
#              "<x:Selected/><x:DoDisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorkbook>", 
#              "</xml><![endif]--></head>"
# 
#   LET l_str = l_str,
#              "<body>",                     
#              "<div align=center>",
#              "<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0 >"
#       RETURN l_str
 
END FUNCTION

################################################################################
# Descriptions...: 針對 Excel 格式報表的效能改善及保持字串空格原狀，欄位內容有空白就必須轉換為 &nbsp; 並加上 <span> 屬性。
# Memo...........:
# Usage..........: azzi310_01_add_span(p_str)
#                  RETURNING STRING
# Input Parameter: p_str    欲格式化的文字
# Return code....: STRING   格式化後的文字
# Date & Author..: 2015/07/22
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_01_add_span(p_str)
DEFINE p_str    STRING
#DEFINE l_str    STRING
#
#
#   LET p_str = p_str.trimRight()
#
#   #若字串有空白就必須加上 <span> 屬性，並將空白轉換為 &nbsp;
#   IF p_str.getIndexOf(" ",1) > 0 THEN
#      LET g_bufstr = base.StringBuffer.create()              
#      CALL g_bufstr.clear()
#      CALL g_bufstr.append(p_str)
#      CALL g_bufstr.replace(" ","&nbsp;",0)
#      CALL g_bufstr.replace("<","&lt;",0)   
#      LET l_str = g_bufstr.tostring()
#      LET l_str = "<span style='mso-spacerun:yes'>", l_str, "</span>"
#   ELSE
#       
#      LET g_bufstr = base.StringBuffer.create()
#      CALL g_bufstr.clear()
#      CALL g_bufstr.append(p_str)
#      CALL g_bufstr.replace("<","&lt;",0)
#      LET l_str = g_bufstr.tostring()
#      
#   END IF
#
#   RETURN l_str
   
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
# Date & Author..: 2015/07/22
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_01_prt_lv(p_name,p_copies)
DEFINE p_name         STRING,               
          p_copies       LIKE type_t.chr1,   
          l_channel      base.Channel,
          l_str          string
#
#   START REPORT azzi310_prt_lv_rep TO PRINTER
#   LET l_channel = base.Channel.create()
#   CALL l_channel.openFile(p_name CLIPPED, "r")
#   WHILE l_channel.read(l_str)
#      OUTPUT TO REPORT azzi310_prt_lv_rep(l_str)
#   END WHILE
#   CALL l_channel.close()
#   FINISH REPORT azzi310_prt_lv_rep
#   LET INT_FLAG = 0
   
END FUNCTION

################################################################################
# Descriptions...: 處理型態為數值的欄位格式
#                  將數值依指定的列印長度及小數位數做FORMAT
# Memo...........:
# Usage..........: CALL azzi310_01_scale(p_k,p_i)
 
# Input parameter: p_k   目前check的欄位
#                : p_i   目前check的筆數
# Return code....:  
#                :  
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_01_scale(p_k,p_i)
DEFINE p_k             LIKE type_t.num10       #目前check的欄位
DEFINE p_i             LIKE type_t.num10       #目前check的筆數
DEFINE l_i             LIKE type_t.num10       
DEFINE l_num           LIKE type_t.num26_10   
DEFINE l_len           LIKE type_t.num10     
DEFINE l_space         LIKE type_t.num10    
   
   
   IF g_qry_length[p_k] > 37 THEN
      LET l_len = 37
      LET l_space = g_qry_length[p_k] - 37
   ELSE
      LET l_len = g_qry_length[p_k]
   END IF
   LET l_space=0 #20151213 add
 
   #將數值依指定的列印長度及小數位數做FORMAT
 
   CASE p_k 
   
    WHEN   1  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field001 LET l_num = ga_table_data[p_i].field001 IF l_i = 0 AND ORD(ga_table_data[p_i].field001) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field001 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field001,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field001 ,g_qry_scale[p_k])) END IF
    WHEN   2  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field002 LET l_num = ga_table_data[p_i].field002 IF l_i = 0 AND ORD(ga_table_data[p_i].field002) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field002 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field002,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field002 ,g_qry_scale[p_k])) END IF
    WHEN   3  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field003 LET l_num = ga_table_data[p_i].field003 IF l_i = 0 AND ORD(ga_table_data[p_i].field003) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field003 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field003,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field003 ,g_qry_scale[p_k])) END IF
    WHEN   4  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field004 LET l_num = ga_table_data[p_i].field004 
                  IF l_i = 0 AND ORD(ga_table_data[p_i].field004) <> 48 AND cl_null(l_num) THEN 
                      EXIT CASE 
                  END IF    
                  LET ga_table_data[p_i].field004 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field004,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field004 ,g_qry_scale[p_k])) END IF
    WHEN   5  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field005 LET l_num = ga_table_data[p_i].field005 IF l_i = 0 AND ORD(ga_table_data[p_i].field005) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field005 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field005,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field005 ,g_qry_scale[p_k])) END IF
    WHEN   6  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field006 LET l_num = ga_table_data[p_i].field006 IF l_i = 0 AND ORD(ga_table_data[p_i].field006) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field006 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field006,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field006 ,g_qry_scale[p_k])) END IF
    WHEN   7  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field007 LET l_num = ga_table_data[p_i].field007 IF l_i = 0 AND ORD(ga_table_data[p_i].field007) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field007 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field007,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field007 ,g_qry_scale[p_k])) END IF
    WHEN   8  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field008 LET l_num = ga_table_data[p_i].field008 IF l_i = 0 AND ORD(ga_table_data[p_i].field008) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field008 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field008,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field008 ,g_qry_scale[p_k])) END IF
    WHEN   9  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field009 LET l_num = ga_table_data[p_i].field009 IF l_i = 0 AND ORD(ga_table_data[p_i].field009) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field009 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field009,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field009 ,g_qry_scale[p_k])) END IF
    WHEN  10  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field010 LET l_num = ga_table_data[p_i].field010 IF l_i = 0 AND ORD(ga_table_data[p_i].field010) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field010 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field010,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field010 ,g_qry_scale[p_k])) END IF
    WHEN  11  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field011 LET l_num = ga_table_data[p_i].field011 IF l_i = 0 AND ORD(ga_table_data[p_i].field011) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field011 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field011,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field011 ,g_qry_scale[p_k])) END IF
    WHEN  12  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field012 LET l_num = ga_table_data[p_i].field012 IF l_i = 0 AND ORD(ga_table_data[p_i].field012) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field012 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field012,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field012 ,g_qry_scale[p_k])) END IF
    WHEN  13  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field013 LET l_num = ga_table_data[p_i].field013 IF l_i = 0 AND ORD(ga_table_data[p_i].field013) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field013 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field013,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field013 ,g_qry_scale[p_k])) END IF
    WHEN  14  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field014 LET l_num = ga_table_data[p_i].field014 IF l_i = 0 AND ORD(ga_table_data[p_i].field014) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field014 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field014,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field014 ,g_qry_scale[p_k])) END IF
    WHEN  15  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field015 LET l_num = ga_table_data[p_i].field015 IF l_i = 0 AND ORD(ga_table_data[p_i].field015) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field015 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field015,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field015 ,g_qry_scale[p_k])) END IF
    WHEN  16  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field016 LET l_num = ga_table_data[p_i].field016 IF l_i = 0 AND ORD(ga_table_data[p_i].field016) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field016 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field016,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field016 ,g_qry_scale[p_k])) END IF
    WHEN  17  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field017 LET l_num = ga_table_data[p_i].field017 IF l_i = 0 AND ORD(ga_table_data[p_i].field017) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field017 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field017,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field017 ,g_qry_scale[p_k])) END IF
    WHEN  18  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field018 LET l_num = ga_table_data[p_i].field018 IF l_i = 0 AND ORD(ga_table_data[p_i].field018) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field018 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field018,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field018 ,g_qry_scale[p_k])) END IF
    WHEN  19  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field019 LET l_num = ga_table_data[p_i].field019 IF l_i = 0 AND ORD(ga_table_data[p_i].field019) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field019 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field019,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field019 ,g_qry_scale[p_k])) END IF
    WHEN  20  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field020 LET l_num = ga_table_data[p_i].field020 IF l_i = 0 AND ORD(ga_table_data[p_i].field020) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field020 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field020,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field020 ,g_qry_scale[p_k])) END IF
    WHEN  21  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field021 LET l_num = ga_table_data[p_i].field021 IF l_i = 0 AND ORD(ga_table_data[p_i].field021) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field021 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field021,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field021 ,g_qry_scale[p_k])) END IF
    WHEN  22  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field022 LET l_num = ga_table_data[p_i].field022 IF l_i = 0 AND ORD(ga_table_data[p_i].field022) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field022 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field022,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field022 ,g_qry_scale[p_k])) END IF
    WHEN  23  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field023 LET l_num = ga_table_data[p_i].field023 IF l_i = 0 AND ORD(ga_table_data[p_i].field023) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field023 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field023,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field023 ,g_qry_scale[p_k])) END IF
    WHEN  24  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field024 LET l_num = ga_table_data[p_i].field024 IF l_i = 0 AND ORD(ga_table_data[p_i].field024) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field024 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field024,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field024 ,g_qry_scale[p_k])) END IF
    WHEN  25  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field025 LET l_num = ga_table_data[p_i].field025 IF l_i = 0 AND ORD(ga_table_data[p_i].field025) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field025 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field025,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field025 ,g_qry_scale[p_k])) END IF
    WHEN  26  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field026 LET l_num = ga_table_data[p_i].field026 IF l_i = 0 AND ORD(ga_table_data[p_i].field026) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field026 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field026,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field026 ,g_qry_scale[p_k])) END IF
    WHEN  27  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field027 LET l_num = ga_table_data[p_i].field027 IF l_i = 0 AND ORD(ga_table_data[p_i].field027) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field027 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field027,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field027 ,g_qry_scale[p_k])) END IF
    WHEN  28  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field028 LET l_num = ga_table_data[p_i].field028 IF l_i = 0 AND ORD(ga_table_data[p_i].field028) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field028 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field028,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field028 ,g_qry_scale[p_k])) END IF
    WHEN  29  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field029 LET l_num = ga_table_data[p_i].field029 IF l_i = 0 AND ORD(ga_table_data[p_i].field029) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field029 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field029,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field029 ,g_qry_scale[p_k])) END IF
    WHEN  30  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field030 LET l_num = ga_table_data[p_i].field030 IF l_i = 0 AND ORD(ga_table_data[p_i].field030) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field030 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field030,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field030 ,g_qry_scale[p_k])) END IF
    WHEN  31  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field031 LET l_num = ga_table_data[p_i].field031 IF l_i = 0 AND ORD(ga_table_data[p_i].field031) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field031 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field031,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field031 ,g_qry_scale[p_k])) END IF
    WHEN  32  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field032 LET l_num = ga_table_data[p_i].field032 IF l_i = 0 AND ORD(ga_table_data[p_i].field032) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field032 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field032,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field032 ,g_qry_scale[p_k])) END IF
    WHEN  33  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field033 LET l_num = ga_table_data[p_i].field033 IF l_i = 0 AND ORD(ga_table_data[p_i].field033) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field033 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field033,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field033 ,g_qry_scale[p_k])) END IF
    WHEN  34  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field034 LET l_num = ga_table_data[p_i].field034 IF l_i = 0 AND ORD(ga_table_data[p_i].field034) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field034 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field034,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field034 ,g_qry_scale[p_k])) END IF
    WHEN  35  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field035 LET l_num = ga_table_data[p_i].field035 IF l_i = 0 AND ORD(ga_table_data[p_i].field035) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field035 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field035,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field035 ,g_qry_scale[p_k])) END IF
    WHEN  36  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field036 LET l_num = ga_table_data[p_i].field036 IF l_i = 0 AND ORD(ga_table_data[p_i].field036) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field036 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field036,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field036 ,g_qry_scale[p_k])) END IF
    WHEN  37  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field037 LET l_num = ga_table_data[p_i].field037 IF l_i = 0 AND ORD(ga_table_data[p_i].field037) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field037 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field037,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field037 ,g_qry_scale[p_k])) END IF
    WHEN  38  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field038 LET l_num = ga_table_data[p_i].field038 IF l_i = 0 AND ORD(ga_table_data[p_i].field038) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field038 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field038,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field038 ,g_qry_scale[p_k])) END IF
    WHEN  39  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field039 LET l_num = ga_table_data[p_i].field039 IF l_i = 0 AND ORD(ga_table_data[p_i].field039) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field039 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field039,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field039 ,g_qry_scale[p_k])) END IF
    WHEN  40  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field040 LET l_num = ga_table_data[p_i].field040 IF l_i = 0 AND ORD(ga_table_data[p_i].field040) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field040 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field040,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field040 ,g_qry_scale[p_k])) END IF
    WHEN  41  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field041 LET l_num = ga_table_data[p_i].field041 IF l_i = 0 AND ORD(ga_table_data[p_i].field041) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field041 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field041,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field041 ,g_qry_scale[p_k])) END IF
    WHEN  42  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field042 LET l_num = ga_table_data[p_i].field042 IF l_i = 0 AND ORD(ga_table_data[p_i].field042) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field042 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field042,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field042 ,g_qry_scale[p_k])) END IF
    WHEN  43  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field043 LET l_num = ga_table_data[p_i].field043 IF l_i = 0 AND ORD(ga_table_data[p_i].field043) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field043 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field043,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field043 ,g_qry_scale[p_k])) END IF
    WHEN  44  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field044 LET l_num = ga_table_data[p_i].field044 IF l_i = 0 AND ORD(ga_table_data[p_i].field044) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field044 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field044,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field044 ,g_qry_scale[p_k])) END IF
    WHEN  45  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field045 LET l_num = ga_table_data[p_i].field045 IF l_i = 0 AND ORD(ga_table_data[p_i].field045) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field045 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field045,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field045 ,g_qry_scale[p_k])) END IF
    WHEN  46  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field046 LET l_num = ga_table_data[p_i].field046 IF l_i = 0 AND ORD(ga_table_data[p_i].field046) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field046 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field046,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field046 ,g_qry_scale[p_k])) END IF
    WHEN  47  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field047 LET l_num = ga_table_data[p_i].field047 IF l_i = 0 AND ORD(ga_table_data[p_i].field047) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field047 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field047,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field047 ,g_qry_scale[p_k])) END IF
    WHEN  48  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field048 LET l_num = ga_table_data[p_i].field048 IF l_i = 0 AND ORD(ga_table_data[p_i].field048) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field048 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field048,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field048 ,g_qry_scale[p_k])) END IF
    WHEN  49  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field049 LET l_num = ga_table_data[p_i].field049 IF l_i = 0 AND ORD(ga_table_data[p_i].field049) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field049 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field049,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field049 ,g_qry_scale[p_k])) END IF
    WHEN  50  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field050 LET l_num = ga_table_data[p_i].field050 IF l_i = 0 AND ORD(ga_table_data[p_i].field050) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field050 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field050,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field050 ,g_qry_scale[p_k])) END IF
    WHEN  51  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field051 LET l_num = ga_table_data[p_i].field051 IF l_i = 0 AND ORD(ga_table_data[p_i].field051) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field051 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field051,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field051 ,g_qry_scale[p_k])) END IF
    WHEN  52  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field052 LET l_num = ga_table_data[p_i].field052 IF l_i = 0 AND ORD(ga_table_data[p_i].field052) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field052 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field052,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field052 ,g_qry_scale[p_k])) END IF
    WHEN  53  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field053 LET l_num = ga_table_data[p_i].field053 IF l_i = 0 AND ORD(ga_table_data[p_i].field053) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field053 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field053,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field053 ,g_qry_scale[p_k])) END IF
    WHEN  54  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field054 LET l_num = ga_table_data[p_i].field054 IF l_i = 0 AND ORD(ga_table_data[p_i].field054) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field054 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field054,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field054 ,g_qry_scale[p_k])) END IF
    WHEN  55  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field055 LET l_num = ga_table_data[p_i].field055 IF l_i = 0 AND ORD(ga_table_data[p_i].field055) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field055 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field055,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field055 ,g_qry_scale[p_k])) END IF
    WHEN  56  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field056 LET l_num = ga_table_data[p_i].field056 IF l_i = 0 AND ORD(ga_table_data[p_i].field056) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field056 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field056,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field056 ,g_qry_scale[p_k])) END IF
    WHEN  57  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field057 LET l_num = ga_table_data[p_i].field057 IF l_i = 0 AND ORD(ga_table_data[p_i].field057) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field057 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field057,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field057 ,g_qry_scale[p_k])) END IF
    WHEN  58  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field058 LET l_num = ga_table_data[p_i].field058 IF l_i = 0 AND ORD(ga_table_data[p_i].field058) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field058 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field058,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field058 ,g_qry_scale[p_k])) END IF
    WHEN  59  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field059 LET l_num = ga_table_data[p_i].field059 IF l_i = 0 AND ORD(ga_table_data[p_i].field059) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field059 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field059,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field059 ,g_qry_scale[p_k])) END IF
    WHEN  60  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field060 LET l_num = ga_table_data[p_i].field060 IF l_i = 0 AND ORD(ga_table_data[p_i].field060) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field060 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field060,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field060 ,g_qry_scale[p_k])) END IF
    WHEN  61  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field061 LET l_num = ga_table_data[p_i].field061 IF l_i = 0 AND ORD(ga_table_data[p_i].field061) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field061 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field061,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field061 ,g_qry_scale[p_k])) END IF
    WHEN  62  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field062 LET l_num = ga_table_data[p_i].field062 IF l_i = 0 AND ORD(ga_table_data[p_i].field062) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field062 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field062,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field062 ,g_qry_scale[p_k])) END IF
    WHEN  63  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field063 LET l_num = ga_table_data[p_i].field063 IF l_i = 0 AND ORD(ga_table_data[p_i].field063) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field063 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field063,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field063 ,g_qry_scale[p_k])) END IF
    WHEN  64  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field064 LET l_num = ga_table_data[p_i].field064 IF l_i = 0 AND ORD(ga_table_data[p_i].field064) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field064 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field064,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field064 ,g_qry_scale[p_k])) END IF
    WHEN  65  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field065 LET l_num = ga_table_data[p_i].field065 IF l_i = 0 AND ORD(ga_table_data[p_i].field065) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field065 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field065,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field065 ,g_qry_scale[p_k])) END IF
    WHEN  66  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field066 LET l_num = ga_table_data[p_i].field066 IF l_i = 0 AND ORD(ga_table_data[p_i].field066) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field066 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field066,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field066 ,g_qry_scale[p_k])) END IF
    WHEN  67  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field067 LET l_num = ga_table_data[p_i].field067 IF l_i = 0 AND ORD(ga_table_data[p_i].field067) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field067 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field067,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field067 ,g_qry_scale[p_k])) END IF
    WHEN  68  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field068 LET l_num = ga_table_data[p_i].field068 IF l_i = 0 AND ORD(ga_table_data[p_i].field068) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field068 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field068,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field068 ,g_qry_scale[p_k])) END IF
    WHEN  69  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field069 LET l_num = ga_table_data[p_i].field069 IF l_i = 0 AND ORD(ga_table_data[p_i].field069) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field069 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field069,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field069 ,g_qry_scale[p_k])) END IF
    WHEN  70  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field070 LET l_num = ga_table_data[p_i].field070 IF l_i = 0 AND ORD(ga_table_data[p_i].field070) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field070 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field070,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field070 ,g_qry_scale[p_k])) END IF
    WHEN  71  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field071 LET l_num = ga_table_data[p_i].field071 IF l_i = 0 AND ORD(ga_table_data[p_i].field071) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field071 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field071,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field071 ,g_qry_scale[p_k])) END IF
    WHEN  72  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field072 LET l_num = ga_table_data[p_i].field072 IF l_i = 0 AND ORD(ga_table_data[p_i].field072) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field072 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field072,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field072 ,g_qry_scale[p_k])) END IF
    WHEN  73  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field073 LET l_num = ga_table_data[p_i].field073 IF l_i = 0 AND ORD(ga_table_data[p_i].field073) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field073 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field073,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field073 ,g_qry_scale[p_k])) END IF
    WHEN  74  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field074 LET l_num = ga_table_data[p_i].field074 IF l_i = 0 AND ORD(ga_table_data[p_i].field074) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field074 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field074,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field074 ,g_qry_scale[p_k])) END IF
    WHEN  75  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field075 LET l_num = ga_table_data[p_i].field075 IF l_i = 0 AND ORD(ga_table_data[p_i].field075) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field075 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field075,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field075 ,g_qry_scale[p_k])) END IF
    WHEN  76  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field076 LET l_num = ga_table_data[p_i].field076 IF l_i = 0 AND ORD(ga_table_data[p_i].field076) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field076 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field076,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field076 ,g_qry_scale[p_k])) END IF
    WHEN  77  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field077 LET l_num = ga_table_data[p_i].field077 IF l_i = 0 AND ORD(ga_table_data[p_i].field077) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field077 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field077,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field077 ,g_qry_scale[p_k])) END IF
    WHEN  78  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field078 LET l_num = ga_table_data[p_i].field078 IF l_i = 0 AND ORD(ga_table_data[p_i].field078) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field078 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field078,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field078 ,g_qry_scale[p_k])) END IF
    WHEN  79  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field079 LET l_num = ga_table_data[p_i].field079 IF l_i = 0 AND ORD(ga_table_data[p_i].field079) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field079 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field079,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field079 ,g_qry_scale[p_k])) END IF
    WHEN  80  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field080 LET l_num = ga_table_data[p_i].field080 IF l_i = 0 AND ORD(ga_table_data[p_i].field080) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field080 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field080,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field080 ,g_qry_scale[p_k])) END IF
    WHEN  81  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field081 LET l_num = ga_table_data[p_i].field081 IF l_i = 0 AND ORD(ga_table_data[p_i].field081) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field081 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field081,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field081 ,g_qry_scale[p_k])) END IF
    WHEN  82  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field082 LET l_num = ga_table_data[p_i].field082 IF l_i = 0 AND ORD(ga_table_data[p_i].field082) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field082 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field082,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field082 ,g_qry_scale[p_k])) END IF
    WHEN  83  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field083 LET l_num = ga_table_data[p_i].field083 IF l_i = 0 AND ORD(ga_table_data[p_i].field083) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field083 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field083,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field083 ,g_qry_scale[p_k])) END IF
    WHEN  84  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field084 LET l_num = ga_table_data[p_i].field084 IF l_i = 0 AND ORD(ga_table_data[p_i].field084) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field084 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field084,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field084 ,g_qry_scale[p_k])) END IF
    WHEN  85  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field085 LET l_num = ga_table_data[p_i].field085 IF l_i = 0 AND ORD(ga_table_data[p_i].field085) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field085 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field085,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field085 ,g_qry_scale[p_k])) END IF
    WHEN  86  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field086 LET l_num = ga_table_data[p_i].field086 IF l_i = 0 AND ORD(ga_table_data[p_i].field086) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field086 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field086,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field086 ,g_qry_scale[p_k])) END IF
    WHEN  87  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field087 LET l_num = ga_table_data[p_i].field087 IF l_i = 0 AND ORD(ga_table_data[p_i].field087) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field087 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field087,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field087 ,g_qry_scale[p_k])) END IF
    WHEN  88  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field088 LET l_num = ga_table_data[p_i].field088 IF l_i = 0 AND ORD(ga_table_data[p_i].field088) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field088 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field088,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field088 ,g_qry_scale[p_k])) END IF
    WHEN  89  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field089 LET l_num = ga_table_data[p_i].field089 IF l_i = 0 AND ORD(ga_table_data[p_i].field089) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field089 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field089,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field089 ,g_qry_scale[p_k])) END IF
    WHEN  90  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field090 LET l_num = ga_table_data[p_i].field090 IF l_i = 0 AND ORD(ga_table_data[p_i].field090) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field090 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field090,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field090 ,g_qry_scale[p_k])) END IF
    WHEN  91  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field091 LET l_num = ga_table_data[p_i].field091 IF l_i = 0 AND ORD(ga_table_data[p_i].field091) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field091 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field091,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field091 ,g_qry_scale[p_k])) END IF
    WHEN  92  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field092 LET l_num = ga_table_data[p_i].field092 IF l_i = 0 AND ORD(ga_table_data[p_i].field092) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field092 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field092,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field092 ,g_qry_scale[p_k])) END IF
    WHEN  93  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field093 LET l_num = ga_table_data[p_i].field093 IF l_i = 0 AND ORD(ga_table_data[p_i].field093) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field093 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field093,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field093 ,g_qry_scale[p_k])) END IF
    WHEN  94  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field094 LET l_num = ga_table_data[p_i].field094 IF l_i = 0 AND ORD(ga_table_data[p_i].field094) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field094 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field094,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field094 ,g_qry_scale[p_k])) END IF
    WHEN  95  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field095 LET l_num = ga_table_data[p_i].field095 IF l_i = 0 AND ORD(ga_table_data[p_i].field095) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field095 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field095,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field095 ,g_qry_scale[p_k])) END IF
    WHEN  96  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field096 LET l_num = ga_table_data[p_i].field096 IF l_i = 0 AND ORD(ga_table_data[p_i].field096) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field096 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field096,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field096 ,g_qry_scale[p_k])) END IF
    WHEN  97  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field097 LET l_num = ga_table_data[p_i].field097 IF l_i = 0 AND ORD(ga_table_data[p_i].field097) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field097 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field097,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field097 ,g_qry_scale[p_k])) END IF
    WHEN  98  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field098 LET l_num = ga_table_data[p_i].field098 IF l_i = 0 AND ORD(ga_table_data[p_i].field098) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field098 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field098,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field098 ,g_qry_scale[p_k])) END IF
    WHEN  99  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field099 LET l_num = ga_table_data[p_i].field099 IF l_i = 0 AND ORD(ga_table_data[p_i].field099) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field099 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field099,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field099 ,g_qry_scale[p_k])) END IF
    WHEN 100  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field100 LET l_num = ga_table_data[p_i].field100 IF l_i = 0 AND ORD(ga_table_data[p_i].field100) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field100 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field100,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field100 ,g_qry_scale[p_k])) END IF
    WHEN 101  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field100 LET l_num = ga_table_data[p_i].field100 IF l_i = 0 AND ORD(ga_table_data[p_i].field100) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field100 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field100,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field100 ,g_qry_scale[p_k])) END IF
    WHEN 102  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field100 LET l_num = ga_table_data[p_i].field100 IF l_i = 0 AND ORD(ga_table_data[p_i].field100) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field100 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field100,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field100 ,g_qry_scale[p_k])) END IF
    WHEN 103  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field100 LET l_num = ga_table_data[p_i].field100 IF l_i = 0 AND ORD(ga_table_data[p_i].field100) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field100 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field100,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field100 ,g_qry_scale[p_k])) END IF
    WHEN 104  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field100 LET l_num = ga_table_data[p_i].field100 IF l_i = 0 AND ORD(ga_table_data[p_i].field100) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field100 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field100,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field100 ,g_qry_scale[p_k])) END IF
    WHEN 105  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field100 LET l_num = ga_table_data[p_i].field100 IF l_i = 0 AND ORD(ga_table_data[p_i].field100) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field100 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field100,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field100 ,g_qry_scale[p_k])) END IF
    WHEN 106  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field100 LET l_num = ga_table_data[p_i].field100 IF l_i = 0 AND ORD(ga_table_data[p_i].field100) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field100 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field100,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field100 ,g_qry_scale[p_k])) END IF
    WHEN 107  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field100 LET l_num = ga_table_data[p_i].field100 IF l_i = 0 AND ORD(ga_table_data[p_i].field100) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field100 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field100,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field100 ,g_qry_scale[p_k])) END IF
    WHEN 108  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field100 LET l_num = ga_table_data[p_i].field100 IF l_i = 0 AND ORD(ga_table_data[p_i].field100) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field100 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field100,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field100 ,g_qry_scale[p_k])) END IF
    WHEN 109  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field100 LET l_num = ga_table_data[p_i].field100 IF l_i = 0 AND ORD(ga_table_data[p_i].field100) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field100 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field100,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field100 ,g_qry_scale[p_k])) END IF
    WHEN 110  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field100 LET l_num = ga_table_data[p_i].field100 IF l_i = 0 AND ORD(ga_table_data[p_i].field100) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field100 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field100,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field100 ,g_qry_scale[p_k])) END IF
    WHEN 111  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field100 LET l_num = ga_table_data[p_i].field100 IF l_i = 0 AND ORD(ga_table_data[p_i].field100) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field100 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field100,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field100 ,g_qry_scale[p_k])) END IF
    WHEN 112  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field100 LET l_num = ga_table_data[p_i].field100 IF l_i = 0 AND ORD(ga_table_data[p_i].field100) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field100 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field100,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field100 ,g_qry_scale[p_k])) END IF
    WHEN 113  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field100 LET l_num = ga_table_data[p_i].field100 IF l_i = 0 AND ORD(ga_table_data[p_i].field100) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field100 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field100,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field100 ,g_qry_scale[p_k])) END IF
    WHEN 114  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field100 LET l_num = ga_table_data[p_i].field100 IF l_i = 0 AND ORD(ga_table_data[p_i].field100) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field100 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field100,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field100 ,g_qry_scale[p_k])) END IF
    WHEN 115  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field100 LET l_num = ga_table_data[p_i].field100 IF l_i = 0 AND ORD(ga_table_data[p_i].field100) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field100 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field100,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field100 ,g_qry_scale[p_k])) END IF
    WHEN 116  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field100 LET l_num = ga_table_data[p_i].field100 IF l_i = 0 AND ORD(ga_table_data[p_i].field100) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field100 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field100,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field100 ,g_qry_scale[p_k])) END IF
    WHEN 117  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field100 LET l_num = ga_table_data[p_i].field100 IF l_i = 0 AND ORD(ga_table_data[p_i].field100) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field100 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field100,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field100 ,g_qry_scale[p_k])) END IF
    WHEN 118  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field100 LET l_num = ga_table_data[p_i].field100 IF l_i = 0 AND ORD(ga_table_data[p_i].field100) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field100 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field100,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field100 ,g_qry_scale[p_k])) END IF
    WHEN 119  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field100 LET l_num = ga_table_data[p_i].field100 IF l_i = 0 AND ORD(ga_table_data[p_i].field100) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field100 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field100,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field100 ,g_qry_scale[p_k])) END IF
    WHEN 120  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field100 LET l_num = ga_table_data[p_i].field100 IF l_i = 0 AND ORD(ga_table_data[p_i].field100) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field100 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field100,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field100 ,g_qry_scale[p_k])) END IF
    WHEN 121  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field100 LET l_num = ga_table_data[p_i].field100 IF l_i = 0 AND ORD(ga_table_data[p_i].field100) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field100 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field100,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field100 ,g_qry_scale[p_k])) END IF
    WHEN 122  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field100 LET l_num = ga_table_data[p_i].field100 IF l_i = 0 AND ORD(ga_table_data[p_i].field100) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field100 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field100,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field100 ,g_qry_scale[p_k])) END IF
    WHEN 123  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field100 LET l_num = ga_table_data[p_i].field100 IF l_i = 0 AND ORD(ga_table_data[p_i].field100) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field100 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field100,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field100 ,g_qry_scale[p_k])) END IF
    WHEN 124  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field100 LET l_num = ga_table_data[p_i].field100 IF l_i = 0 AND ORD(ga_table_data[p_i].field100) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field100 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field100,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field100 ,g_qry_scale[p_k])) END IF
    WHEN 125  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field100 LET l_num = ga_table_data[p_i].field100 IF l_i = 0 AND ORD(ga_table_data[p_i].field100) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field100 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field100,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field100 ,g_qry_scale[p_k])) END IF
    WHEN 126  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field100 LET l_num = ga_table_data[p_i].field100 IF l_i = 0 AND ORD(ga_table_data[p_i].field100) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field100 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field100,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field100 ,g_qry_scale[p_k])) END IF
    WHEN 127  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field100 LET l_num = ga_table_data[p_i].field100 IF l_i = 0 AND ORD(ga_table_data[p_i].field100) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field100 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field100,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field100 ,g_qry_scale[p_k])) END IF
    WHEN 128  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field100 LET l_num = ga_table_data[p_i].field100 IF l_i = 0 AND ORD(ga_table_data[p_i].field100) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field100 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field100,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field100 ,g_qry_scale[p_k])) END IF
    WHEN 129  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field100 LET l_num = ga_table_data[p_i].field100 IF l_i = 0 AND ORD(ga_table_data[p_i].field100) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field100 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field100,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field100 ,g_qry_scale[p_k])) END IF
    WHEN 130  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field100 LET l_num = ga_table_data[p_i].field100 IF l_i = 0 AND ORD(ga_table_data[p_i].field100) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field100 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field100,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field100 ,g_qry_scale[p_k])) END IF
    WHEN 131  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field100 LET l_num = ga_table_data[p_i].field100 IF l_i = 0 AND ORD(ga_table_data[p_i].field100) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field100 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field100,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field100 ,g_qry_scale[p_k])) END IF
    WHEN 132  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field100 LET l_num = ga_table_data[p_i].field100 IF l_i = 0 AND ORD(ga_table_data[p_i].field100) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field100 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field100,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field100 ,g_qry_scale[p_k])) END IF
    WHEN 133  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field100 LET l_num = ga_table_data[p_i].field100 IF l_i = 0 AND ORD(ga_table_data[p_i].field100) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field100 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field100,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field100 ,g_qry_scale[p_k])) END IF
    WHEN 134  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field100 LET l_num = ga_table_data[p_i].field100 IF l_i = 0 AND ORD(ga_table_data[p_i].field100) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field100 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field100,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field100 ,g_qry_scale[p_k])) END IF
    WHEN 135  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field100 LET l_num = ga_table_data[p_i].field100 IF l_i = 0 AND ORD(ga_table_data[p_i].field100) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field100 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field100,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field100 ,g_qry_scale[p_k])) END IF
    WHEN 136  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field100 LET l_num = ga_table_data[p_i].field100 IF l_i = 0 AND ORD(ga_table_data[p_i].field100) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field100 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field100,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field100 ,g_qry_scale[p_k])) END IF
    WHEN 137  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field100 LET l_num = ga_table_data[p_i].field100 IF l_i = 0 AND ORD(ga_table_data[p_i].field100) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field100 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field100,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field100 ,g_qry_scale[p_k])) END IF
    WHEN 138  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field100 LET l_num = ga_table_data[p_i].field100 IF l_i = 0 AND ORD(ga_table_data[p_i].field100) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field100 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field100,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field100 ,g_qry_scale[p_k])) END IF
    WHEN 139  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field100 LET l_num = ga_table_data[p_i].field100 IF l_i = 0 AND ORD(ga_table_data[p_i].field100) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field100 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field100,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field100 ,g_qry_scale[p_k])) END IF
    WHEN 140  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field100 LET l_num = ga_table_data[p_i].field100 IF l_i = 0 AND ORD(ga_table_data[p_i].field100) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field100 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field100,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field100 ,g_qry_scale[p_k])) END IF
    WHEN 141  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field100 LET l_num = ga_table_data[p_i].field100 IF l_i = 0 AND ORD(ga_table_data[p_i].field100) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field100 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field100,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field100 ,g_qry_scale[p_k])) END IF
    WHEN 142  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field100 LET l_num = ga_table_data[p_i].field100 IF l_i = 0 AND ORD(ga_table_data[p_i].field100) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field100 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field100,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field100 ,g_qry_scale[p_k])) END IF
    WHEN 143  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field100 LET l_num = ga_table_data[p_i].field100 IF l_i = 0 AND ORD(ga_table_data[p_i].field100) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field100 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field100,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field100 ,g_qry_scale[p_k])) END IF
    WHEN 144  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field100 LET l_num = ga_table_data[p_i].field100 IF l_i = 0 AND ORD(ga_table_data[p_i].field100) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field100 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field100,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field100 ,g_qry_scale[p_k])) END IF
    WHEN 145  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field100 LET l_num = ga_table_data[p_i].field100 IF l_i = 0 AND ORD(ga_table_data[p_i].field100) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field100 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field100,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field100 ,g_qry_scale[p_k])) END IF
    WHEN 146  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field100 LET l_num = ga_table_data[p_i].field100 IF l_i = 0 AND ORD(ga_table_data[p_i].field100) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field100 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field100,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field100 ,g_qry_scale[p_k])) END IF
    WHEN 147  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field100 LET l_num = ga_table_data[p_i].field100 IF l_i = 0 AND ORD(ga_table_data[p_i].field100) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field100 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field100,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field100 ,g_qry_scale[p_k])) END IF
    WHEN 148  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field100 LET l_num = ga_table_data[p_i].field100 IF l_i = 0 AND ORD(ga_table_data[p_i].field100) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field100 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field100,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field100 ,g_qry_scale[p_k])) END IF
    WHEN 149  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field100 LET l_num = ga_table_data[p_i].field100 IF l_i = 0 AND ORD(ga_table_data[p_i].field100) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field100 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field100,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field100 ,g_qry_scale[p_k])) END IF
    WHEN 150  IF (g_qry_scale[p_k]>= 0 ) THEN LET l_i = ga_table_data[p_i].field100 LET l_num = ga_table_data[p_i].field100 IF l_i = 0 AND ORD(ga_table_data[p_i].field100) <> 48 AND cl_null(l_num) THEN EXIT CASE END IF LET ga_table_data[p_i].field100 = l_space SPACES, azzi310_01_numfor(ga_table_data[p_i].field100,l_len-1,azzi310_01_scale_chk(ga_table_data[p_i].field100 ,g_qry_scale[p_k])) END IF
   
   END CASE
 
END FUNCTION

################################################################################
# Descriptions...:  判斷輸出資料的顯示方式
# Memo...........:
# Usage..........: CALL azzi310_01_scale_chk(l_value, l_scale)
#                  RETURNING l_scale
# Input parameter: l_value   要輸出的資料
#                : l_scale   顯示的小數位長度
# Return code....: l_scale   顯示的小數位長度
#                :  
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_01_scale_chk(l_value,l_scale)
 
 DEFINE l_value   STRING
 DEFINE l_scale   INTEGER 
   IF l_scale = 11 THEN  #0表示該值為數字,賦予初始值11, 若為null代表該值為文字
      LET l_scale = l_value.getLength() - l_value.getIndexOf(".",1) 
   END IF
RETURN l_scale

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
# Date & Author..: 日期 By 作者 #160523-00002#2 add --回传json
# Modify.........:
################################################################################
PUBLIC FUNCTION azzi310_01_get_JsonCondition(p_prog)
DEFINE p_prog     STRING
DEFINE l_p      INTEGER
         
       #160805-00010#1 add(s)
       IF cl_null(g_gzia001) OR p_prog <> g_gzia001 THEN
       　　CLOSE WINDOW w_azzi310_01_curs
           LET g_flag=0
       END IF
       #160805-00010#1 add(e)
      LET g_gzia001=p_prog
      LET g_query_prog=p_prog
      
       SELECT COUNT(*) INTO l_p FROM gzia_t
         WHERE gzia001 = g_gzia001 
         
       IF l_p = 0 THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.extend =g_gzia_m.gzia001 
           LET g_errparam.code   = "azz-00913"
           LET g_errparam.popup  = TRUE
           CALL cl_err()
           RETURN
       END IF
      
      
      #LET g_flag=0
      LET g_wc=""
      LET g_json_wc=""
      CALL azzi310_01_sel("C")
      IF INT_FLAG THEN
          LET INT_FLAG=0
          LET g_flag=0
      END IF
      RETURN g_json_wc
END FUNCTION

################################################################################
# Descriptions...: 报表结果笔数
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者#160523-00002#2 add 
# Modify.........:
################################################################################
PUBLIC FUNCTION azzi310_01_get_record_number(p_prog,p_json)
  DEFINE   p_prog,p_json  STRING
  DEFINE   l_sql          STRING
  DEFINE   l_json_wc      STRING                  
  DEFINE   obj            util.JSONObject          
  DEFINE   l_cnt,l_p      INTEGER
       
       LET g_gzia001=p_prog
       SELECT COUNT(*) INTO l_p FROM gzia_t
         WHERE gzia001 = g_gzia001 
         
       IF l_p = 0 THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.extend =g_gzia_m.gzia001 
           LET g_errparam.code   = "azz-00913"
           LET g_errparam.popup  = TRUE
           CALL cl_err()
           RETURN
       END IF
       
        IF NOT CL_NULL(p_json) THEN
           LET obj = util.JSONObject.parse(p_json)
           #161220-00028#1 add(s)
           IF STATUS=-8109 THEN
   　　       INITIALIZE g_errparam TO NULL 
              LET g_errparam.extend =""
              LET g_errparam.code   = "azz-01148" 
              LET g_errparam.popup  = TRUE
              CALL cl_err()
              RETURN 
           END IF
            #161220-00028#1 add(e)
           LET l_json_wc=obj.get("wc")
          # DISPLAY "json wc:", l_json_wc
       END IF
       
       IF NOT CL_NULL(l_json_wc) THEN
          CALL azzi310_01(p_prog,"N",p_json)
          LET l_sql="SELECT count(*) FROM(",g_execmd,") tt"
          PREPARE azzi310_01_num FROM l_sql
          EXECUTE azzi310_01_num INTO l_cnt
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'EXECUTE azzi310_01_num:'
          LET g_errparam.popup = FALSE
          CALL cl_err()
       END IF
     RETURN l_cnt
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
# Date & Author..: 日期 By 作者 #160523-00002#2 add 
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_01_arg_buildField(p_cmd,pn_vbox)
 DEFINE p_cmd            LIKE type_t.chr1
 DEFINE pn_vbox          om.DomNode
 DEFINE ln_group         om.DomNode
 DEFINE ln_grid          om.DomNode,
        ln_formfield     om.DomNode,
        ln_Field_Edit    om.DomNode,
        ln_label         om.DomNode
   DEFINE l_str            STRING
   DEFINE l_cnt,l_i       LIKE type_t.num5
   DEFINE l_posx           LIKE type_t.num10
   DEFINE l_posx2          LIKE type_t.num10
   DEFINE l_posy           LIKE type_t.num10
   DEFINE ls_colname       STRING
   
    LET l_cnt=1
    LET l_posx2=1
    LET l_posy=0
    CALL g_gzie.clear()
    IF p_cmd='C' THEN
    
      DECLARE azzi310_01_gzie_cur CURSOR FOR SELECT gzie002,gzie003,gzie005 FROM gzie_t WHERE gzie001=g_query_prog ORDER BY gzie002 
      LET l_str = cl_getmsg('azz-01121',g_lang)     
      FOREACH azzi310_01_gzie_cur INTO g_gzie[l_cnt].*
         IF CL_NULL(g_gzie[l_cnt].gzie005) THEN
            LET ls_colname = l_str, l_cnt USING "&&&"
            LET g_gzie[l_cnt].gzie005=ls_colname
         END IF
         
         LET l_posx=FGL_WIDTH(g_gzie[l_cnt].gzie005 CLIPPED) + 2
         IF l_posx>l_posx2 THEN
             LET l_posx2=l_posx
         END IF
        LET l_cnt=l_cnt+1
      END FOREACH
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = 'foreach azzi310_01_gzie_cur:' 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN
      END IF
      CALL g_gzie.deleteElement(l_cnt)
      
    END IF
    
       LET l_cnt=l_cnt-1
       LET ln_group = pn_vbox.createChild("Group")    
       LET l_str = cl_getmsg('azz-01120',g_lang)
       CALL ln_group.setAttribute("text", l_str CLIPPED)   
       LET ln_grid = ln_group.createChild("Grid")
       LET l_posx=1
       
       IF l_cnt>0 THEN
           CALL ln_group.setAttribute("hidden", 0)
       ELSE
           CALL ln_group.setAttribute("hidden", 1)
       END IF
       
      FOR l_i=1 TO 9 
       
           LET ln_label = ln_grid.createChild("Label")
           CALL ln_label.setAttribute("text",g_gzie[l_i].gzie005 CLIPPED)
           CALL ln_label.setAttribute("gridWidth", FGL_WIDTH(g_gzie[l_i].gzie005 CLIPPED))          
           CALL ln_label.setAttribute("posX", l_posx)
           CALL ln_label.setAttribute("posY", l_i-1) 
           
           LET ls_colname = "arg", l_i USING "&&&"
           LET ln_formfield = ln_grid.createChild("FormField")
           CALL ln_formfield.setAttribute("colName",ls_colname)
           CALL ln_formfield.setAttribute("name",ls_colname)          
           CALL ln_formfield.setAttribute("tabIndex", l_i)
           
           LET ln_field_edit = ln_formfield.createChild("Edit")
           CALL ln_field_edit.setAttribute("gridWidth", 15)
           CALL ln_field_edit.setAttribute("width",15)
           CALL ln_field_edit.setAttribute("posX", l_posx2)
           CALL ln_field_edit.setAttribute("posY", l_posy)
           
           IF l_i<=l_cnt AND p_cmd='C' THEN
               CALL ln_formfield.setAttribute("hidden", 0)
               CALL ln_formfield.setAttribute("notNull", 1)
               CALL ln_formfield.setAttribute("required", 1)
               CALL ln_label.setAttribute("hidden", 0)
           ELSE
               CALL ln_formfield.setAttribute("hidden", 1)
               CALL ln_label.setAttribute("hidden", 1)
           END IF
           
      END FOR

       CALL ui.Interface.refresh()
 
END FUNCTION

################################################################################
# Descriptions...: 增加串查显示
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者#160523-00002#2 add
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi310_01_showPage_cont()
DEFINE l_page                LIKE type_t.num10
    DEFINE l_i                   LIKE type_t.num10
    DEFINE l_curr                LIKE type_t.num5  
    DEFINE l_rec_b               LIKE type_t.num10,   #单身笔数
           l_curr_page           LIKE type_t.num10,   # Current Page Number
           l_total_page          LIKE type_t.num10    # Total Pages
    DEFINE l_action              STRING
    DEFINE l_table_data_t DYNAMIC ARRAY OF type_field
    DEFINE  ls_msg                STRING
 
    DEFINE ln_table_column       om.DomNode
    DEFINE ln_edit,ln_w          om.DomNode
    DEFINE ln_page               om.DomNode
    DEFINE ln_table,ln_value     om.DomNode
    DEFINE ls_table              om.NodeList
    DEFINE ls_pages              om.NodeList
    DEFINE ls_items,ls_values    om.NodeList
    DEFINE ls_colname            STRING
    DEFINE lw_w                  ui.window
    DEFINE l_feld_cnt            LIKE type_t.num5     #SMALLINT
    DEFINE l_feld                DYNAMIC ARRAY OF STRING
    DEFINE l_length              DYNAMIC ARRAY OF LIKE type_t.num5    #SMALLINT
    DEFINE l_cmd                 LIKE type_t.chr1000  #CHAR(200)
    DEFINE l_title_cnt           STRING,
           l_allow_insert        LIKE type_t.num5,    #SMALLINT,              #可新增否
           l_allow_delete        LIKE type_t.num5     #SMALLINT               #可刪除否
    DEFINE l_width               LIKE type_t.num5     #SMALLINT
    DEFINE l_column              LIKE type_t.num5     #SMALLINT
    DEFINE l_offset              LIKE type_t.num5     #SMALLINT
    DEFINE l_column_name         STRING
    DEFINE l_value_item          LIKE type_t.num5     #SMALLINT
    DEFINE l_col_value     STRING 
    DEFINE l_col_text      STRING
    DEFINE la_cmdrun   RECORD
             prog       STRING,
             param      DYNAMIC ARRAY OF STRING
                  END RECORD
    DEFINE ls_js       STRING
    #160901-00030#1 add(s)
    DEFINE l_gzid002    LIKE gzid_t.gzid002
    DEFINE l_gzid004    LIKE gzid_t.gzid004
    DEFINE l_sql        STRING
    DEFINE jsarr      util.JSONArray
    #160901-00030#1 add(e)
    
    CALL ga_table_data_t.clear()
    FOR l_i = 1 TO ga_table_data.getLength()
        LET ga_page_data_t.* = ga_table_data[l_i].*
        LET ga_table_data_t[l_i].* = ga_page_data_t.*
    END FOR
    LET g_rec_b_t      = g_rec_b     
    LET g_total_page_t = g_total_page
    LET l_action = ""
    LET l_ac = 1
    
   WHILE TRUE
 
        IF INT_FLAG THEN
           IF (g_gzia002 != "N" OR cl_null(g_gzia002))
           AND g_field_seq.getLength()>0 #161121-00024#1 add
           THEN 
              LET INT_FLAG = 0                      
           END IF
           EXIT WHILE
        END IF
        #过滤条件
#        IF l_action = 'filter' THEN
#           CALL azzi310_01_filter()
#           IF INT_FLAG THEN
#              LET INT_FLAG = 0
#           END IF
#           LET l_action = ""
#        END IF
 
        CALL azzi310_01_loadPage()
 
        LET l_page = g_curr_page
 
        #重新设定连查数据及画面
        CALL azzi310_01_settab()
        
        DISPLAY g_header_str TO text1
        DISPLAY g_trailer_str TO text2
        DISPLAY l_page TO FORMONLY.h_index
        DISPLAY g_total_page TO FORMONLY.h_count
        
      CALL FGL_DIALOG_SETFIELDORDER(FALSE)  
     DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
#        DISPLAY ARRAY ga_page_data TO s_table_data.* 
#          ATTRIBUTE(COUNT=g_rec_b )
# 
#            BEFORE DISPLAY 
# 
#               CALL azzi310_01_disableAction(DIALOG)
#               IF g_rec_b != 0 THEN
#                  CALL fgl_set_arr_curr(l_ac)
#               END IF
# 
#            BEFORE ROW
#               LET l_ac = ARR_CURR()
#        END DISPLAY
                
          INPUT ARRAY ga_page_data  FROM s_table_data.* 
          ATTRIBUTE(COUNT=g_rec_b,
          INSERT ROW=FALSE,DELETE ROW=FALSE,APPEND ROW=FALSE)
 
            BEFORE INPUT
               CALL ui.interface.refresh() 
               CALL azzi310_01_disableAction(DIALOG)
               IF g_rec_b != 0 THEN
                  CALL fgl_set_arr_curr(l_ac)
               END IF
 
            BEFORE ROW
               LET l_ac = ARR_CURR()
#               LET ga_page_data[l_ac].field000 = '>'
#               IF ga_page_data[l_ac].field000 IS NULL THEN
#                   CALL fgl_set_arr_curr(l_ac-1)
#               END IF
      
           BEFORE FIELD
               field001,field002,field003,field004,field005,
               field006,field007,field008,field009,field010,
               field011,field012,field013,field014,field015,
               field016,field017,field018,field019,field020,
               field021,field022,field023,field024,field025,
               field026,field027,field028,field029,field030,
               field031,field032,field033,field034,field035,
               field036,field037,field038,field039,field040,
               field041,field042,field043,field044,field045,
               field046,field047,field048,field049,field050,
               field051,field052,field053,field054,field055,
               field056,field057,field058,field059,field060,
               field061,field062,field063,field064,field065,
               field066,field067,field068,field069,field070,
               field071,field072,field073,field074,field075,
               field076,field077,field078,field079,field080,
               field081,field082,field083,field084,field085,
               field086,field087,field088,field089,field090,
               field091,field092,field093,field094,field095,
               field096,field097,field098,field099,field100, 
               field101,field102,field103,field104,field105,
               field106,field107,field108,field109,field110,
               field111,field112,field113,field114,field115,
               field116,field117,field118,field119,field120,
               field121,field122,field123,field124,field125,
               field126,field127,field128,field129,field130,
               field131,field132,field133,field134,field135,
               field136,field137,field138,field139,field140,
               field141,field142,field143,field144,field145,
               field146,field147,field148,field149,field150
               
             #讀取欄位資料及目前欄位
             LET lw_w=ui.window.getcurrent()
             LET ln_w = lw_w.getNode()
             LET ls_table=ln_w.selectByTagName("Table")
             LET ln_table = ls_table.item(1)
             
             LET l_curr = ln_table.getAttribute("currentRow")
             LET l_offset = ln_table.getAttribute("offset")
             LET l_value_item = l_curr - l_offset+1
 
             LET l_column_name =  FGL_DIALOG_GETFIELDNAME()
             LET l_column = l_column_name.subString(6,8)
 
             LET ls_items = ln_table.selectByTagName("TableColumn")
             LET ln_table_column = ls_items.item(l_column+1)
             #LET l_col_text = ln_table_column.getAttribute("text")
             #LET l_col_text = l_col_text.subString(2,l_col_text.getLength())
 
             LET ls_values = ln_table_column.selectByTagName("Value")
             LET ln_value = ls_values.item(l_value_item)
             LET l_col_value = ln_value.getAttribute("value")
             
             #160901-00030#1 mod(s)
             IF g_qry_flag[l_column]='Y' THEN
                 #參數:欄位資料，及目前欄位
                 IF NOT cl_null(l_col_value) AND cl_null(g_qry_jsarg[l_column]) THEN
                    LET la_cmdrun.prog = g_qry_prog[l_column]
                    LET la_cmdrun.param[1] = l_col_value
                    LET ls_js = util.JSON.stringify(la_cmdrun) #轉成string 格式的json
                    CALL cl_cmdrun_wait(ls_js)
                 END IF
                 
                 IF NOT cl_null(g_qry_jsarg[l_column]) THEN
                   
                   # DECLARE gzid_jsarg_cur CURSOR FOR        
                    LET l_sql= "SELECT gzid002,UPPER(gzid004) FROM gzid_t ",
                            "WHERE instr('",g_qry_jsarg[l_column],"','$'||UPPER(gzid004))>0",
                            "  AND gzid001='",g_gzia001,"'",
                            "  AND gzid004<>'",g_qry_feld_t[l_column],"'"
                            PREPARE gzid_jsarg_pre FROM l_sql
                            DECLARE gzid_jsarg_cur CURSOR FOR gzid_jsarg_pre 
                     LET ls_js=azzi310_01_arg_replace(g_qry_jsarg[l_column]) #替换公用变数
                     LET ls_js=cl_str_replace(ls_js,"$CURRENT",l_col_value) #替换当前值
                     FOREACH gzid_jsarg_cur INTO l_gzid002,l_gzid004
                        LET ln_table_column = ls_items.item(l_gzid002+1) 
                        LET ls_values = ln_table_column.selectByTagName("Value")
                        LET ln_value = ls_values.item(l_value_item)
                        LET l_col_value = ln_value.getAttribute("value")
                        LET l_column_name="$"||l_gzid004 CLIPPED
                        LET ls_js=cl_str_replace(ls_js,l_column_name,l_col_value) #替换其他参数的值                       
                    END FOREACH
                        LET la_cmdrun.prog = g_qry_prog[l_column]
                        #LET la_cmdrun.param[1] = ls_js
                        LET jsarr = util.JSONArray.parse(ls_js)
                        FOR l_i=1 TO jsarr.getLength()
                            LET la_cmdrun.param[l_i]=jsarr.get(l_i)
                        END FOR
                        LET ls_js = util.JSON.stringify( la_cmdrun )
                        DISPLAY ls_js
                        CALL cl_cmdrun(ls_js)
                 END IF
                EXIT DIALOG
             END IF
            #160901-00030#1 mod(e)
            AFTER ROW 
               LET ga_page_data[l_ac].field000 = ''
          END INPUT
          
           BEFORE DIALOG
           CALL cl_navigator_setting(l_page, g_total_page )
             
             on action exporttoexcel
                LET l_rec_b      = g_rec_b     
                LET l_curr_page  = g_curr_page 
                LET l_total_page = g_total_page
                CALL l_table_data_t.clear()
                FOR l_i = 1 TO ga_table_data.getLength()
                    LET ga_page_data_t.* = ga_table_data[l_i].*
                    LET l_table_data_t[l_i].* = ga_page_data_t.*
                END FOR
                # CALL azzi310_01_o('E') #cjp
             #160830-00018#1 add(s)
             LET g_export_node[1] = base.typeInfo.create(ga_table_data)
             LET g_export_id[1]   = "s_table_data"
             LET g_export_title[1]=g_gzial003
             IF cl_null(g_export_title[1]) THEN
                LET g_export_title[1]=g_query_prog
             END IF
             LET g_main_hidden=310
             CALL cl_export_to_excel()
             #160830-00018#1 add(e)
            
           

                CALL ga_table_data.clear()
                FOR l_i = 1 TO l_table_data_t.getLength()
                    LET ga_page_data_t.* = l_table_data_t[l_i].*
                    LET ga_table_data[l_i].* = ga_page_data_t.*
                END FOR
                LET g_out_type = 'V'
                #160825-00014#1 mark(s)
#                IF g_len > 150 THEN
#                   LET g_len = 150
#                END IF
                #160825-00014#1 mark(e)
                LET g_rec_b      = l_rec_b     
                LET g_curr_page  = l_curr_page 
                LET g_total_page = l_total_page
               
            ON ACTION first   # Jump to First Page
                LET g_curr_page = 1
                EXIT DIALOG
 
            ON ACTION next    # Jump to Next Page              
                LET g_curr_page = g_curr_page + 1
                  EXIT DIALOG
 
            ON ACTION previous    # Jump to Previous Page              
                LET g_curr_page = g_curr_page - 1
               EXIT DIALOG
   

            ON ACTION last            
                LET g_curr_page = g_total_page
                EXIT DIALOG
                
            ON ACTION jump
         IF (NOT g_no_ask) THEN    
            CALL cl_set_act_visible("accept,cancel", TRUE)    
            CALL cl_getmsg('fetch',g_dlang) RETURNING ls_msg
            LET INT_FLAG = 0
 
            PROMPT ls_msg CLIPPED,':' FOR g_jump
               #交談指令共用ACTION
               &include "common_action.4gl" 
            END PROMPT
 
            CALL cl_set_act_visible("accept,cancel", FALSE)             
         END IF
         
         IF g_jump > 0 AND g_jump <= g_total_page THEN
             LET g_curr_page = g_jump
         END IF
         LET g_no_ask = FALSE
         EXIT DIALOG
         #160926-00005#1 .4 add(s)
         ON ACTION close
            LET INT_FLAG = TRUE            
            EXIT DIALOG
         #160926-00005#1 .4 add(e) 
         
       ON ACTION controlg
           CALL cl_cmdask()
               
       ON ACTION exit
         LET INT_FLAG = TRUE 
             EXIT DIALOG
            
       END DIALOG

    END WHILE
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
PRIVATE FUNCTION azzi310_01_format(p_k,p_i)
DEFINE p_k             LIKE type_t.num10       #目前check的欄位
DEFINE p_i             LIKE type_t.num10       #目前check的筆數
DEFINE l_i             LIKE type_t.num10  

 CASE p_k
   WHEN 1 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field001 = ga_table_data[p_i].field001 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 2 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field002 = ga_table_data[p_i].field002 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 3 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field003 = ga_table_data[p_i].field003 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 4 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field004 = ga_table_data[p_i].field004 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 5 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field005 = ga_table_data[p_i].field005 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 6 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field006 = ga_table_data[p_i].field006 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 7 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field007 = ga_table_data[p_i].field007 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF  
   WHEN 8 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field008 = ga_table_data[p_i].field008 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF  
   WHEN 9 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field009 = ga_table_data[p_i].field009 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF 
   WHEN 10 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field010 = ga_table_data[p_i].field010 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF    
   WHEN 11 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field011 = ga_table_data[p_i].field011 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF 
   WHEN 12 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field012 = ga_table_data[p_i].field012 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 13 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field013 = ga_table_data[p_i].field013 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 14 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field014 = ga_table_data[p_i].field014 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 15 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field015 = ga_table_data[p_i].field015 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 16 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field016 = ga_table_data[p_i].field016 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 17 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field017 = ga_table_data[p_i].field017 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 18 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field018 = ga_table_data[p_i].field018 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 19 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field019 = ga_table_data[p_i].field019 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 20 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field020 = ga_table_data[p_i].field020 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 21 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field021 = ga_table_data[p_i].field021 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF 
   WHEN 22 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field022 = ga_table_data[p_i].field022 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 23 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field023 = ga_table_data[p_i].field023 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 24 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field024 = ga_table_data[p_i].field024 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 25 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field025 = ga_table_data[p_i].field025 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 26 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field026 = ga_table_data[p_i].field026 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 27 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field027 = ga_table_data[p_i].field027 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 28 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field028 = ga_table_data[p_i].field028 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 29 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field029 = ga_table_data[p_i].field029 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 30 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field030 = ga_table_data[p_i].field030 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 31 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field031 = ga_table_data[p_i].field031 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF 
   WHEN 32 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field032 = ga_table_data[p_i].field032 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 33 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field033 = ga_table_data[p_i].field033 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 34 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field034 = ga_table_data[p_i].field034 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 35 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field035 = ga_table_data[p_i].field035 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 36 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field036 = ga_table_data[p_i].field036 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 37 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field037 = ga_table_data[p_i].field037 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 38 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field038 = ga_table_data[p_i].field038 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 39 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field039 = ga_table_data[p_i].field039 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 40 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field040 = ga_table_data[p_i].field040 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 41 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field041 = ga_table_data[p_i].field041 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF 
   WHEN 42 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field042 = ga_table_data[p_i].field042 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 43 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field043 = ga_table_data[p_i].field043 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 44 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field044 = ga_table_data[p_i].field044 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 45 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field045 = ga_table_data[p_i].field045 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 46 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field046 = ga_table_data[p_i].field046 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 47 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field047 = ga_table_data[p_i].field047 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 48 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field048 = ga_table_data[p_i].field048 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 49 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field049 = ga_table_data[p_i].field049 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 50 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field050 = ga_table_data[p_i].field050 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 51 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field051 = ga_table_data[p_i].field051 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF 
   WHEN 52 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field052 = ga_table_data[p_i].field052 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 53 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field053 = ga_table_data[p_i].field053 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 54 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field054 = ga_table_data[p_i].field054 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 55 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field055 = ga_table_data[p_i].field055 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 56 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field056 = ga_table_data[p_i].field056 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 57 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field057 = ga_table_data[p_i].field057 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 58 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field058 = ga_table_data[p_i].field058 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 59 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field059 = ga_table_data[p_i].field059 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 60 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field060 = ga_table_data[p_i].field060 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 61 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field061 = ga_table_data[p_i].field061 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF 
   WHEN 62 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field062 = ga_table_data[p_i].field062 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 63 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field063 = ga_table_data[p_i].field063 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 64 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field064 = ga_table_data[p_i].field064 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 65 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field065 = ga_table_data[p_i].field065 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 66 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field066 = ga_table_data[p_i].field066 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 67 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field067 = ga_table_data[p_i].field067 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 68 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field068 = ga_table_data[p_i].field068 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 69 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field069 = ga_table_data[p_i].field069 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 70 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field070 = ga_table_data[p_i].field070 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 71 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field071 = ga_table_data[p_i].field071 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF 
   WHEN 72 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field072 = ga_table_data[p_i].field072 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 73 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field073 = ga_table_data[p_i].field073 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 74 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field074 = ga_table_data[p_i].field074 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 75 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field075 = ga_table_data[p_i].field075 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 76 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field076 = ga_table_data[p_i].field076 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 77 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field077 = ga_table_data[p_i].field077 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 78 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field078 = ga_table_data[p_i].field078 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 79 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field079 = ga_table_data[p_i].field079 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 80 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field080 = ga_table_data[p_i].field080 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 81 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field081 = ga_table_data[p_i].field081 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF 
   WHEN 82 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field082 = ga_table_data[p_i].field082 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 83 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field083 = ga_table_data[p_i].field083 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 84 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field084 = ga_table_data[p_i].field084 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 85 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field085 = ga_table_data[p_i].field085 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 86 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field086 = ga_table_data[p_i].field086 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 87 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field087 = ga_table_data[p_i].field087 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 88 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field088 = ga_table_data[p_i].field088 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 89 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field089 = ga_table_data[p_i].field089 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 90 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field090 = ga_table_data[p_i].field090 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 91 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field091 = ga_table_data[p_i].field091 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF 
   WHEN 92 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field092 = ga_table_data[p_i].field092 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 93 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field093 = ga_table_data[p_i].field093 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 94 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field094 = ga_table_data[p_i].field094 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 95 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field095 = ga_table_data[p_i].field095 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 96 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field096 = ga_table_data[p_i].field096 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 97 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field097 = ga_table_data[p_i].field097 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 98 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field098 = ga_table_data[p_i].field098 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 99 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field099 = ga_table_data[p_i].field099 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 100 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field100 = ga_table_data[p_i].field100 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF

   WHEN 101 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field101 = ga_table_data[p_i].field101 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 102 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field102 = ga_table_data[p_i].field102 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 103 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field103 = ga_table_data[p_i].field103 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 104 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field104 = ga_table_data[p_i].field104 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 105 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field105 = ga_table_data[p_i].field105 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 106 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field106 = ga_table_data[p_i].field106 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 107 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field107 = ga_table_data[p_i].field107 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF  
   WHEN 108 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field108 = ga_table_data[p_i].field108 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF  
   WHEN 109 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field109 = ga_table_data[p_i].field109 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF 
   WHEN 110 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field110 = ga_table_data[p_i].field110 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF    
   WHEN 111 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field111 = ga_table_data[p_i].field111 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF 
   WHEN 112 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field112 = ga_table_data[p_i].field112 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 113 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field113 = ga_table_data[p_i].field113 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 114 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field114 = ga_table_data[p_i].field114 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 115 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field115 = ga_table_data[p_i].field115 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 116 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field116 = ga_table_data[p_i].field116 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 117 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field117 = ga_table_data[p_i].field117 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 118 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field118 = ga_table_data[p_i].field118 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 119 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field119 = ga_table_data[p_i].field119 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 120 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field120 = ga_table_data[p_i].field120 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 121 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field121 = ga_table_data[p_i].field121 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF 
   WHEN 122 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field122 = ga_table_data[p_i].field122 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 123 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field123 = ga_table_data[p_i].field123 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 124 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field124 = ga_table_data[p_i].field124 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 125 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field125 = ga_table_data[p_i].field125 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 126 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field126 = ga_table_data[p_i].field126 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 127 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field127 = ga_table_data[p_i].field127 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 128 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field128 = ga_table_data[p_i].field128 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 129 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field129 = ga_table_data[p_i].field129 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 130 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field130 = ga_table_data[p_i].field130 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 131 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field131 = ga_table_data[p_i].field131 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF 
   WHEN 132 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field132 = ga_table_data[p_i].field132 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 133 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field133 = ga_table_data[p_i].field133 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 134 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field134 = ga_table_data[p_i].field134 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 135 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field135 = ga_table_data[p_i].field135 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 136 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field136 = ga_table_data[p_i].field136 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 137 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field137 = ga_table_data[p_i].field137 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 138 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field138 = ga_table_data[p_i].field138 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 139 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field139 = ga_table_data[p_i].field139 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 140 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field140 = ga_table_data[p_i].field140 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 141 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field141 = ga_table_data[p_i].field141 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF 
   WHEN 142 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field142 = ga_table_data[p_i].field142 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 143 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field143 = ga_table_data[p_i].field143 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 144 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field144 = ga_table_data[p_i].field144 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 145 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field145 = ga_table_data[p_i].field145 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 146 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field146 = ga_table_data[p_i].field146 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 147 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field147 = ga_table_data[p_i].field147 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 148 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field148 = ga_table_data[p_i].field148 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 149 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field149 = ga_table_data[p_i].field149 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
   WHEN 150 IF NOT cl_null(g_qry_fmt[p_k]) THEN LET ga_table_data[p_i].field150 = ga_table_data[p_i].field150 USING g_qry_fmt[p_k] ELSE CALL azzi310_01_scale(p_k,p_i) END IF
  
  END CASE
END FUNCTION

 
{</section>}
 
