#該程式未解開Section, 採用最新樣板產出!
{<section id="axcq603.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:22(2017-03-21 18:18:20), PR版次:0022(2017-04-06 19:48:36)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000036
#+ Filename...: axcq603
#+ Description: 成本勾稽查詢作業
#+ Creator....: 02294(2016-03-21 13:53:53)
#+ Modifier...: 05423 -SD/PR- 02111
 
{</section>}
 
{<section id="axcq603.global" >}
#應用 q01 樣板自動產生(Version:34)
#add-point:填寫註解說明 name="global.memo"
#160531-00032#1   2016/05/31  By lixiang   调整部分成本明细抓取的的异动类型
#160707-00034#1   2016/07/11  By lixiang   调整库存开帐和在制转出总表的数据抓取来源
#160719-00012#1   2016/07/19  By lixiang   1.在制部分的数量和金额的抓取需加上控制条件是非拆件式工单
#                                          2.核对项目编号放到单身最后一个栏位显示出来
#160727-00004#1   2016/08/05  By lixiang   年度期別栏位不做检核
#160802-00020#8   2016/08/16  By dorislai  增加帳套權限管控、法人權限管控
#161109-00085#26  2016/11/17  By 08993     整批調整系統星號寫法
#161031-00037#1   2016/12/26  By lixiang   1.「自動勾稽」產生xckk_t&xckl_t方式，重新整理
#                                          2.增加頁籤「庫存差異明細」、「在製差異明細」
#161031-00037#1   2016/01/24  By lixh      自動勾稽」產生&xckl_t,在制差异明细页签，算出的明细数量/明细金额后再乘以（-1）(xcce_t領料當存的是正的)
#170112-00033#1   2017/02/10  By lixh      成本勾稽時，跳出一視窗，顯示進度條
#170210-00001#1   2017/02/14  By catmoon   抓取明細資料的SQL修正
#                                          判斷非先進先出成本，明細就直接給0
#170214-00031#1   2017/02/17  By lixiang   #程序相关结构调整
#170215-00060#1   2017/02/17  By zhujing   1.在制转出这行，总表为负数，明细为正数。明細表乘上-1，統一顯示。
#                                          2.仅在自动勾稽时需要显示进度条。
#170220-00001#1   2017/02/20  By lixiang   效能优化(成本報表核對，明细有差異的金額會新增進xckl_t)
#170216-00080#1   2017/02/20  By charles4m 1.調整 FUNCTION axcq603_gen_xckk() 若  l_xckk.xckk104 NULL 則預設 0。
#                                          2.勾稽表不平 
#                                          3.檢核在製人工費時，抓取立帳資料，依「本幣位順序」設定抓取金額
#170306-00029#1   2017/03/07  By 02295     人工制費排除插件式工单
#170309-00065#1   2017/03/10  By 02295     明细页签改用汇总的资料做foreach检查
#170313-00012#1   2017/03/14  By 02295     明细数据中在制人工费缺少仓退的数据
#170306-00041#1   2017/03/21  By zhujing   第二個總帳報表核對頁箋取消，因改在aglq510去核對了
#170406-00027#1   2017/04/06  By 02111     1. PREPARE axcq603_ins_xckl_pb21 FROM l_sql UNION 的兩句 SQL 欄位順序要一致。
#                                          2. FUNCTION axcq603_insert_xckl() 判斷 l_xckl.xckl005 = '217' 時，明細資料必須乘上 -1，避免負值變成累加。
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT util
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_xckk_d RECORD
       
       sel LIKE type_t.chr1, 
   gzcb012 LIKE type_t.chr500, 
   xckk005_desc LIKE type_t.chr500, 
   xckk101 LIKE xckk_t.xckk101, 
   xckk102 LIKE xckk_t.xckk102, 
   xckk103 LIKE xckk_t.xckk103, 
   xckk104 LIKE xckk_t.xckk104, 
   xckk105 LIKE xckk_t.xckk105, 
   xckk106 LIKE xckk_t.xckk106, 
   xckk090 LIKE xckk_t.xckk090, 
   xckk102a LIKE xckk_t.xckk102a, 
   xckk104a LIKE xckk_t.xckk104a, 
   xckk106a LIKE xckk_t.xckk106a, 
   xckk102b LIKE xckk_t.xckk102b, 
   xckk104b LIKE xckk_t.xckk104b, 
   xckk106b LIKE xckk_t.xckk106b, 
   xckk102c LIKE xckk_t.xckk102c, 
   xckk104c LIKE xckk_t.xckk104c, 
   xckk106c LIKE xckk_t.xckk106c, 
   xckk102d LIKE xckk_t.xckk102d, 
   xckk104d LIKE xckk_t.xckk104d, 
   xckk106d LIKE xckk_t.xckk106d, 
   xckk102e LIKE xckk_t.xckk102e, 
   xckk104e LIKE xckk_t.xckk104e, 
   xckk106e LIKE xckk_t.xckk106e, 
   xckk102f LIKE xckk_t.xckk102f, 
   xckk104f LIKE xckk_t.xckk104f, 
   xckk106f LIKE xckk_t.xckk106f, 
   xckk102g LIKE xckk_t.xckk102g, 
   xckk104g LIKE xckk_t.xckk104g, 
   xckk106g LIKE xckk_t.xckk106g, 
   xckk102h LIKE xckk_t.xckk102h, 
   xckk104h LIKE xckk_t.xckk104h, 
   xckk106h LIKE xckk_t.xckk106h, 
   xckk005 LIKE xckk_t.xckk005
       END RECORD
PRIVATE TYPE type_g_xckk3_d RECORD
       gzcb012 LIKE gzcb_t.gzcb012, 
   xckl005_desc LIKE type_t.chr500, 
   xckl007 LIKE type_t.chr500, 
   xckl007_desc LIKE type_t.chr500, 
   xckl007_desc_1 LIKE type_t.chr500, 
   xckl008 LIKE type_t.chr500, 
   xckl008_desc LIKE type_t.chr500, 
   xckl009 LIKE type_t.chr30, 
   xckl101 LIKE type_t.num20_6, 
   xckl102 LIKE type_t.num20_6, 
   xckl103 LIKE type_t.num20_6, 
   xckl104 LIKE type_t.num20_6, 
   xckl105 LIKE type_t.num20_6, 
   xckl106 LIKE type_t.num20_6, 
   xckl102a LIKE type_t.num20_6, 
   xckl104a LIKE type_t.num20_6, 
   xckl106a LIKE type_t.num20_6, 
   xckl102b LIKE type_t.num20_6, 
   xckl104b LIKE type_t.num20_6, 
   xckl106b LIKE type_t.num20_6, 
   xckl102c LIKE type_t.num20_6, 
   xckl104c LIKE type_t.num20_6, 
   xckl106c LIKE type_t.num20_6, 
   xckl102d LIKE type_t.num20_6, 
   xckl104d LIKE type_t.num20_6, 
   xckl106d LIKE type_t.num20_6, 
   xckl102e LIKE type_t.num20_6, 
   xckl104e LIKE type_t.num20_6, 
   xckl106e LIKE type_t.num20_6, 
   xckl102f LIKE type_t.num20_6, 
   xckl104f LIKE type_t.num20_6, 
   xckl106f LIKE type_t.num20_6, 
   xckl102g LIKE type_t.num20_6, 
   xckl104g LIKE type_t.num20_6, 
   xckl106g LIKE type_t.num20_6, 
   xckl102h LIKE type_t.num20_6, 
   xckl104h LIKE type_t.num20_6, 
   xckl106h LIKE type_t.num20_6, 
   xckl005 LIKE type_t.chr10
       END RECORD
 
PRIVATE TYPE type_g_xckk4_d RECORD
       gzcb012 LIKE gzcb_t.gzcb012, 
   xckl005_1_desc LIKE type_t.chr500, 
   xckl006 LIKE xckl_t.xckl006, 
   xckl007 LIKE xckl_t.xckl007, 
   xckl007_1_desc LIKE type_t.chr500, 
   xckl007_1_desc_1 LIKE type_t.chr500, 
   xckl008 LIKE xckl_t.xckl008, 
   xckl008_1_desc LIKE type_t.chr500, 
   xckl009 LIKE xckl_t.xckl009, 
   xckl101 LIKE xckl_t.xckl101, 
   xckl102 LIKE xckl_t.xckl102, 
   xckl103 LIKE xckl_t.xckl103, 
   xckl104 LIKE xckl_t.xckl104, 
   xckl105 LIKE xckl_t.xckl105, 
   xckl106 LIKE xckl_t.xckl106, 
   xckl102a LIKE xckl_t.xckl102a, 
   xckl104a LIKE xckl_t.xckl104a, 
   xckl106a LIKE xckl_t.xckl106a, 
   xckl102b LIKE xckl_t.xckl102b, 
   xckl104b LIKE xckl_t.xckl104b, 
   xckl106b LIKE xckl_t.xckl106b, 
   xckl102c LIKE xckl_t.xckl102c, 
   xckl104c LIKE xckl_t.xckl104c, 
   xckl106c LIKE xckl_t.xckl106c, 
   xckl102d LIKE xckl_t.xckl102d, 
   xckl104d LIKE xckl_t.xckl104d, 
   xckl106d LIKE xckl_t.xckl106d, 
   xckl102e LIKE xckl_t.xckl102e, 
   xckl104e LIKE xckl_t.xckl104e, 
   xckl106e LIKE xckl_t.xckl106e, 
   xckl102f LIKE xckl_t.xckl102f, 
   xckl104f LIKE xckl_t.xckl104f, 
   xckl106f LIKE xckl_t.xckl106f, 
   xckl102g LIKE xckl_t.xckl102g, 
   xckl104g LIKE xckl_t.xckl104g, 
   xckl106g LIKE xckl_t.xckl106g, 
   xckl102h LIKE xckl_t.xckl102h, 
   xckl104h LIKE xckl_t.xckl104h, 
   xckl106h LIKE xckl_t.xckl106h, 
   xckl005 LIKE xckl_t.xckl005
       END RECORD
 
 
 
#add-point:自定義模組變數-標準(Module Variable)  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_master  RECORD 
       xckkcomp         LIKE xckk_t.xckkcomp,
       xckkcomp_desc    LIKE ooefl_t.ooefl003,
       xckkld           LIKE xckk_t.xckkld,
       xckkld_desc      LIKE glaal_t.glaal003,
       xckk003          LIKE xckk_t.xckk003,
       xckk004          LIKE xckk_t.xckk004,
       xckk001          LIKE xckk_t.xckk001,
       xckk001_desc     LIKE ooail_t.ooail003,
       xckk002          LIKE xckk_t.xckk002,
       xckk002_desc     LIKE xcatl_t.xcatl002
       END RECORD
       
DEFINE g_previous_xckk003  LIKE xckk_t.xckk003
DEFINE g_previous_xckk004  LIKE xckk_t.xckk004
DEFINE g_source            LIKE type_t.chr20      #標記明細表的來源
DEFINE g_source1           LIKE type_t.chr20      #標記明細表的來源

DEFINE g_xckk_d_color   DYNAMIC ARRAY OF RECORD
             sel STRING, 
             gzcb012 STRING, 
             #xckk005 STRING,   #161031-00037#1
             xckk005_desc STRING, 
             xckk101 STRING, 
             xckk102 STRING, 
             xckk103 STRING, 
             xckk104 STRING, 
             xckk105 STRING, 
             xckk106 STRING, 
             xckk090 STRING, 
             xckk102a STRING, 
             xckk104a STRING, 
             xckk106a STRING, 
             xckk102b STRING, 
             xckk104b STRING, 
             xckk106b STRING, 
             xckk102c STRING, 
             xckk104c STRING, 
             xckk106c STRING, 
             xckk102d STRING, 
             xckk104d STRING, 
             xckk106d STRING, 
             xckk102e STRING, 
             xckk104e STRING, 
             xckk106e STRING, 
             xckk102f STRING, 
             xckk104f STRING, 
             xckk106f STRING, 
             xckk102g STRING, 
             xckk104g STRING, 
             xckk106g STRING, 
             xckk102h STRING, 
             xckk104h STRING, 
             xckk106h STRING,
             xckk005  STRING    #161031-00037#1
                     END RECORD
DEFINE g_wc_cs_ld            STRING          #160802-00020#8-add
DEFINE g_wc_cs_comp          STRING          #160802-00020#8-add

DEFINE g_bdate      LIKE glav_t.glav004 #起始年度+期別對應的起始截止日期  #161031-00037#1
DEFINE g_edate      LIKE glav_t.glav004 #161031-00037#1
DEFINE g_glaa003    LIKE glaa_t.glaa003 #161031-00037#1
DEFINE g_curr       LIKE pmds_t.pmds037 #161031-00037#1
DEFINE g_cost_type  LIKE xcat_t.xcat005 #161031-00037#1 
DEFINE g_progress_show      LIKE type_t.num5     #170215-00060#1 add
#end add-point
 
#模組變數(Module Variables)
DEFINE g_xckk_d            DYNAMIC ARRAY OF type_g_xckk_d
DEFINE g_xckk_d_t          type_g_xckk_d
DEFINE g_xckk3_d     DYNAMIC ARRAY OF type_g_xckk3_d
DEFINE g_xckk3_d_t   type_g_xckk3_d
 
DEFINE g_xckk4_d     DYNAMIC ARRAY OF type_g_xckk4_d
DEFINE g_xckk4_d_t   type_g_xckk4_d
 
 
 
 
 
DEFINE g_wc                  STRING                        #儲存 user 的查詢條件
DEFINE g_wc_t                STRING                        #儲存 user 的查詢條件
DEFINE g_wc2                 STRING
DEFINE g_wc_filter           STRING
DEFINE g_wc_filter_t         STRING
DEFINE g_sql                 STRING                        #組 sql 用 
DEFINE g_forupd_sql          STRING                        #SELECT ... FOR UPDATE  SQL    
DEFINE g_cnt                 LIKE type_t.num10              
DEFINE l_ac                  LIKE type_t.num10             #目前處理的ARRAY CNT 
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog     
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_current_page        LIKE type_t.num5              #目前所在頁數
DEFINE g_current_row         LIKE type_t.num10             #目前所在筆數
DEFINE g_current_idx         LIKE type_t.num10
DEFINE g_detail_cnt          LIKE type_t.num10             #單身 總筆數(所有資料)
DEFINE g_page                STRING                        #第幾頁
DEFINE g_ch                  base.Channel                  #外串程式用
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_error_show          LIKE type_t.num5
DEFINE g_row_index           LIKE type_t.num10
DEFINE g_master_idx          LIKE type_t.num10
DEFINE g_detail_idx          LIKE type_t.num10             #單身 所在筆數(所有資料)
DEFINE g_detail_idx2         LIKE type_t.num10
DEFINE g_hyper_url           STRING                        #hyperlink的主要網址
DEFINE g_qbe_hidden          LIKE type_t.num5              #qbe頁籤折疊
DEFINE g_tot_cnt             LIKE type_t.num10             #計算總筆數
DEFINE g_num_in_page         LIKE type_t.num10             #每頁筆數
DEFINE g_page_act_list       STRING                        #分頁ACTION清單
DEFINE g_current_row_tot     LIKE type_t.num10             #目前所在總筆數
DEFINE g_page_start_num      LIKE type_t.num10             #目前頁面起始筆數
DEFINE g_page_end_num        LIKE type_t.num10             #目前頁面結束筆數
 
#多table用wc
DEFINE g_wc_table           STRING
DEFINE g_detail_page_action STRING
DEFINE g_pagestart          LIKE type_t.num10
 
DEFINE g_wc2_table2   STRING
DEFINE g_detail2_page_action2 STRING
 
 
 
DEFINE g_wc_filter_table           STRING
 
DEFINE g_wc2_filter_table2   STRING
 
 
 
#add-point:自定義模組變數-客製(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明 name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axcq603.main" >}
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
   CALL cl_ap_init("axc","")
 
   #add-point:作業初始化 name="main.init"
   #160802-00020#8-add-(S)
   CALL s_fin_create_account_center_tmp()                      #展組織下階成員所需之暫存檔 
   CALL s_fin_azzi800_sons_query(g_today)
   CALL s_fin_account_center_ld_str() RETURNING g_wc_cs_ld
   CALL s_fin_get_wc_str(g_wc_cs_ld)  RETURNING g_wc_cs_ld
   CALL s_axc_get_authcomp() RETURNING g_wc_cs_comp            #抓取使用者有拜訪權限據點的對應法人  
   #160802-00020#8-add-(E)
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
   DECLARE axcq603_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT  ",
               " FROM  t0",
               
               " WHERE  "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   
   #end add-point
   PREPARE axcq603_master_referesh FROM g_sql
 
   #add-point:main段define_sql name="main.body.define_sql"
   
   #end add-point 
   LET g_forupd_sql = ""
   #add-point:main段define_sql name="main.body.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE axcq603_bcl CURSOR FROM g_forupd_sql
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      LET g_master.xckkcomp = g_argv[1]   #法人
      LET g_master.xckkld   = g_argv[2]   #账套
      LET g_master.xckk003  = g_argv[3]   #年度
      LET g_master.xckk004  = g_argv[4]   #期别
      LET g_master.xckk001  = g_argv[5]   #本位币顺序
      LET g_master.xckk002  = g_argv[6]   #成本计算类型
      CALL axcq603_b_fill()
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_axcq603 WITH FORM cl_ap_formpath("axc",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL axcq603_init()   
 
      #進入選單 Menu (="N")
      CALL axcq603_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_axcq603
      
   END IF 
   
   CLOSE axcq603_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="axcq603.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION axcq603_init()
   #add-point:init段define-客製 name="init.define_customerization"
   
   #end add-point
   #add-point:init段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="init.before_function"
   
   #end add-point
 
   LET g_wc_filter   = " 1=1"
   LET g_wc_filter_t = " 1=1" 
   LET g_error_show  = 1
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   
     
 
   #add-point:畫面資料初始化 name="init.init"
   #CALL cl_set_combo_scc_part('xckk005','8922','103,101,102,117,105,115,104,118,112,106,114,107,108,110,111,109,119,113,116,215,201,216,217,200,210,211,212,214,301,302,306,303,304,305') #160719-00012#1
   CALL cl_set_combo_scc_part('b_xckk005','8922','103,101,102,117,105,115,104,118,112,106,114,107,108,110,111,109,119,113,116,215,201,216,217,200,210,211,212,214,301,302,306,303,304,305') #160719-00012#1
   CALL cl_set_combo_scc('xckk001','8914')
   LET g_progress_show = FALSE   #170215-00060#1 add   
   #end add-point
 
   CALL axcq603_default_search()
END FUNCTION
 
{</section>}
 
{<section id="axcq603.default_search" >}
PRIVATE FUNCTION axcq603_default_search()
   #add-point:default_search段define-客製 name="default_search.define_customerization"
   
   #end add-point
   #add-point:default_search段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="default_search.define"
   
   #end add-point
 
 
   #add-point:default_search段開始前 name="default_search.before"
   
   #end add-point
 
   #應用 qs27 樣板自動產生(Version:3)
   #+ 組承接外部參數時資料庫欄位對應條件(單身)
   IF NOT cl_null(g_argv[01]) THEN
      LET g_wc = g_wc, " xckkld = '", g_argv[01], "' AND "
   END IF
 
   IF NOT cl_null(g_argv[02]) THEN
      LET g_wc = g_wc, " xckk001 = '", g_argv[02], "' AND "
   END IF
   IF NOT cl_null(g_argv[03]) THEN
      LET g_wc = g_wc, " xckk002 = '", g_argv[03], "' AND "
   END IF
   IF NOT cl_null(g_argv[04]) THEN
      LET g_wc = g_wc, " xckk003 = '", g_argv[04], "' AND "
   END IF
   IF NOT cl_null(g_argv[05]) THEN
      LET g_wc = g_wc, " xckk004 = '", g_argv[05], "' AND "
   END IF
   IF NOT cl_null(g_argv[06]) THEN
      LET g_wc = g_wc, " xckk005 = '", g_argv[06], "' AND "
   END IF
 
 
 
 
 
 
   IF NOT cl_null(g_wc) THEN
      LET g_wc = g_wc.subString(1,g_wc.getLength()-5)
   ELSE
      #預設查詢條件
      LET g_wc = " 1=2"
   END IF
 
   #add-point:default_search段結束前 name="default_search.after"
 
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axcq603.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axcq603_ui_dialog() 
   #add-point:ui_dialog段define-客製 name="ui_dialog.define_customerization"
   
   #end add-point
   DEFINE li_exit   LIKE type_t.num5    #判別是否為離開作業
   DEFINE li_idx    LIKE type_t.num10
   DEFINE ls_result STRING
   DEFINE ls_wc     STRING
   DEFINE lc_action_choice_old   STRING
   DEFINE ls_js     STRING
   DEFINE la_param  RECORD
                    prog       STRING,
                    actionid   STRING,
                    background LIKE type_t.chr1,
                    param      DYNAMIC ARRAY OF STRING
                    END RECORD
   #add-point:ui_dialog段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_dialog.define"
   DEFINE l_glaa001 LIKE glaa_t.glaa001
   DEFINE l_glaa016 LIKE glaa_t.glaa016
   DEFINE l_glaa020 LIKE glaa_t.glaa020
   DEFINE l_n       LIKE type_t.num5
   #end add-point
   
 
   #add-point:FUNCTION前置處理 name="ui_dialog.before_function"
   
   #end add-point
 
   CALL cl_set_act_visible("accept,cancel", FALSE)
   CALL cl_get_num_in_page() RETURNING g_num_in_page
 
   LET li_exit = FALSE
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()   
   LET g_current_idx = 1
   LET g_action_choice = " "
   LET lc_action_choice_old = ""
   LET g_current_row_tot = 0
   LET g_page_start_num = 1
   LET g_page_end_num = g_num_in_page
   LET g_detail_idx = 1
   LET g_detail_idx2 = 1
   LET l_ac = 1
 
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
 
   
   CALL axcq603_b_fill()
  
   WHILE li_exit = FALSE
 
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_xckk_d.clear()
         CALL g_xckk3_d.clear()
 
         CALL g_xckk4_d.clear()
 
 
         LET g_wc  = " 1=2"
         LET g_wc2 = " 1=1"
         LET g_action_choice = ""
         LET g_detail_page_action = "detail_first"
         LET g_pagestart = 1
         LET g_current_row_tot = 0
         LET g_page_start_num = 1
         LET g_page_end_num = g_num_in_page
         LET g_detail_idx = 1
         LET g_detail_idx2 = 1
 
         CALL axcq603_init()
      END IF
 
      DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
         #add-point:input段落 name="ui_dialog.input"
         INPUT BY NAME g_master.xckkcomp,g_master.xckkld,g_master.xckk003,g_master.xckk004,g_master.xckk001,g_master.xckk002
         
            BEFORE INPUT
               #预设当前site的法人，主账套，年度期别，成本计算类型
               IF cl_null(g_master.xckkcomp) AND cl_null(g_master.xckkld) AND cl_null(g_master.xckk003) AND cl_null(g_master.xckk004) 
                  AND cl_null(g_master.xckk001) AND cl_null(g_master.xckk002) THEN
                  CALL s_axc_set_site_default() RETURNING g_master.xckkcomp,g_master.xckkld,g_master.xckk003,g_master.xckk004,g_master.xckk002  
               END IF
               CALL s_desc_get_department_desc(g_master.xckkcomp) RETURNING g_master.xckkcomp_desc
               DISPLAY BY NAME g_master.xckkcomp_desc 
               
               CALL s_desc_get_ld_desc(g_master.xckkld) RETURNING g_master.xckkld_desc
               DISPLAY BY NAME g_master.xckkld_desc 

               CALL axcq603_xckk002_desc(g_master.xckk002) RETURNING g_master.xckk002_desc
               DISPLAY BY NAME g_master.xckk002_desc
                  
               LET g_master.xckk001 = '1'
               SELECT glaa001,glaa016,glaa020 INTO l_glaa001,l_glaa016,l_glaa020
                 FROM glaa_t
                WHERE glaaent = g_enterprise
                  AND glaald  = g_master.xckkld
                  
                  
               CASE g_master.xckk001
                  WHEN '1' 
                    CALL s_desc_get_currency_desc(l_glaa001) RETURNING g_master.xckk001_desc 
                    DISPLAY BY NAME g_master.xckk001_desc                   
                  WHEN '2'
                    CALL s_desc_get_currency_desc(l_glaa016) RETURNING g_master.xckk001_desc 
                    DISPLAY BY NAME g_master.xckk001_desc  
                  WHEN '3'
                    CALL s_desc_get_currency_desc(l_glaa020) RETURNING g_master.xckk001_desc 
                    DISPLAY BY NAME g_master.xckk001_desc  
               END CASE
               LET g_wc = " 1=1"
 
               
            AFTER FIELD xckkcomp
               CALL s_desc_get_department_desc(g_master.xckkcomp) RETURNING g_master.xckkcomp_desc
               DISPLAY BY NAME g_master.xckkcomp_desc 
               IF NOT cl_null(g_master.xckkcomp) THEN
                  IF NOT s_axc_chk_ld_comp(g_master.xckkcomp,g_master.xckkld) THEN
                     LET g_master.xckkcomp = NULL
                     LET g_master.xckkcomp_desc = NULL
                     NEXT FIELD CURRENT
                  END IF
               END IF
               
            AFTER FIELD xckkld
               CALL s_desc_get_ld_desc(g_master.xckkld) RETURNING g_master.xckkld_desc
               DISPLAY BY NAME g_master.xckkld_desc   
               IF NOT cl_null(g_master.xckkld) THEN
                  IF NOT s_axc_chk_ld_comp(g_master.xckkcomp,g_master.xckkld) THEN
                     LET g_master.xckkld = NULL
                     LET g_master.xckkld_desc = NULL
                     NEXT FIELD CURRENT
                  END IF
               END IF
                     
            
            
            AFTER FIELD xckk001
               SELECT glaa001,glaa016,glaa020 INTO l_glaa001,l_glaa016,l_glaa020
                FROM glaa_t
                WHERE glaaent = g_enterprise
                  AND glaald  = g_master.xckkld
                  
                  
               CASE g_master.xckk001
                  WHEN '1' 
                    CALL s_desc_get_currency_desc(l_glaa001) RETURNING g_master.xckk001_desc 
                    DISPLAY BY NAME g_master.xckk001_desc                   
                  WHEN '2'
                    CALL s_desc_get_currency_desc(l_glaa016) RETURNING g_master.xckk001_desc 
                    DISPLAY BY NAME g_master.xckk001_desc  
                  WHEN '3'
                    CALL s_desc_get_currency_desc(l_glaa020) RETURNING g_master.xckk001_desc 
                    DISPLAY BY NAME g_master.xckk001_desc 
               END CASE                                             
            
            AFTER FIELD xckk002
               CALL axcq603_xckk002_desc(g_master.xckk002) RETURNING g_master.xckk002_desc
               DISPLAY BY NAME g_master.xckk002_desc
               IF NOT cl_null(g_master.xckk002) THEN 
                  #設定g_chkparam.*的參數前，先將其初始化，避免之前設定遺留的參數值造成影響。
                  INITIALIZE g_chkparam.* TO NULL
                  
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_master.xckk002 
                  #呼叫檢查存在並帶值的library
                  IF NOT  cl_chk_exist("v_xcat001") THEN
                     LET g_master.xckk002 = NULL
                     LET g_master.xckk002_desc = NULL
                     NEXT FIELD CURRENT
                  END IF
               END IF 
               
            
            AFTER FIELD xckk003
               #160727-00004#1---s
               #IF NOT cl_null(g_master.xckk003) THEN
               #   IF NOT s_axc_chk_year_period(g_master.xckkld,g_master.xckk003,g_master.xckk004) THEN
               #      LET g_master.xckk003 = NULL
               #      NEXT FIELD CURRENT
               #   END IF
               #END IF
               #160727-00004#1---e
               
            AFTER FIELD xckk004
               #160727-00004#1---s
               #IF NOT cl_null(g_master.xckk004) THEN
               #   IF NOT s_axc_chk_year_period(g_master.xckkld,g_master.xckk003,g_master.xckk004) THEN
               #      LET g_master.xckk004 = NULL
               #      NEXT FIELD CURRENT
               #   END IF
               #END IF
               #160727-00004#1---e

            ON ACTION controlp INFIELD xckkcomp
               #此段落由子樣板a07產生            
               #開窗i段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.xckkcomp             #給予default值
               #160802-00020#8-add-(S)
      		   #增加法人過濾條件
               IF NOT cl_null(g_wc_cs_comp) THEN
                  LET g_qryparam.where = " ooef001 IN ",g_wc_cs_comp
               END IF
               #160802-00020#8-add-(E)
               #給予arg
               CALL q_ooef001_2()                                      #呼叫開窗
               LET g_master.xckkcomp = g_qryparam.return1              #將開窗取得的值回傳到變數
               DISPLAY g_master.xckkcomp TO xckkcomp                   #顯示到畫面上
               CALL s_desc_get_department_desc(g_master.xckkcomp) RETURNING g_master.xckkcomp_desc
               DISPLAY BY NAME g_master.xckkcomp_desc 
               
               NEXT FIELD xckkcomp                                     #返回原欄位            
            
            ON ACTION controlp INFIELD xckkld
            #此段落由子樣板a07產生            
            #開窗i段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               LET g_qryparam.default1 = g_master.xckkld             #給予default值
               #給予arg
               LET g_qryparam.arg1 = g_user
               LET g_qryparam.arg2 = g_dept 
               IF g_master.xckkcomp IS NOT NULL THEN
                  LET g_qryparam.where = " glaacomp = '",g_master.xckkcomp,"'"
               END IF
               #160802-00020#8-add-(S)
               #增加帳套權限控制
               IF NOT cl_null(g_wc_cs_ld) THEN
                  IF g_master.xckkcomp IS NOT NULL THEN
                     LET g_qryparam.where = g_qryparam.where CLIPPED," AND glaald IN ",g_wc_cs_ld
                  ELSE
                     LET g_qryparam.where = " glaald IN ",g_wc_cs_ld
                  END IF
               END IF
               #160802-00020#8-add-(E)
               CALL q_authorised_ld()                                #呼叫開窗
               LET g_master.xckkld = g_qryparam.return1              
               DISPLAY g_master.xckkld TO xckkld              
               CALL s_desc_get_ld_desc(g_master.xckkld) RETURNING g_master.xckkld_desc
               DISPLAY BY NAME g_master.xckkld_desc 

               NEXT FIELD xckkld                          #返回原欄位
              
            
            ON ACTION controlp INFIELD xckk002
               #此段落由子樣板a07產生            
               #開窗i段
               INITIALIZE g_qryparam.* TO NULL
               LET g_qryparam.state = 'i'
               LET g_qryparam.reqry = FALSE
               
               LET g_qryparam.default1 = g_master.xckk002             #給予default值
               
               #給予arg
               CALL q_xcat001()                                #呼叫開窗
               
               LET g_master.xckk002 = g_qryparam.return1              
               
               DISPLAY g_master.xckk002 TO xckk002              #
               
               CALL axcq603_xckk002_desc(g_master.xckk002) RETURNING g_master.xckk002_desc
               DISPLAY BY NAME g_master.xckk002_desc
               
               NEXT FIELD xckk002                          #返回原欄位
               
               
            AFTER INPUT              
               CALL axcq603_b_fill()
               
               
         END INPUT
         #end add-point
 
         #add-point:construct段落 name="ui_dialog.construct"
         
         #end add-point
     
         DISPLAY ARRAY g_xckk_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 1
 
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac = g_detail_idx
               CALL axcq603_detail_action_trans()
 
               LET g_master_idx = l_ac
               #為避免按上下筆時影響執行效能，所以做一些處理
               LET lc_action_choice_old = g_action_choice
               LET g_action_choice = "fetch"
               CALL axcq603_b_fill2()
               LET g_action_choice = lc_action_choice_old
 
               #add-point:input段before row name="input.body.before_row"

               CALL DIALOG.setArrayAttributes("s_detail1",g_xckk_d_color)
               #end add-point
 
            
 
            #自訂ACTION(detail_show,page_1)
            
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_axcq604
            LET g_action_choice="open_axcq604"
            IF cl_auth_chk_act("open_axcq604") THEN
               
               #add-point:ON ACTION open_axcq604 name="menu.detail_show.page1.open_axcq604"
               IF g_detail_idx > 0 THEN
                  IF g_xckk_d[g_detail_idx].xckk105 <> 0 OR g_xckk_d[g_detail_idx].xckk106 <> 0 THEN
                     INITIALIZE la_param.* TO NULL
                     LET la_param.prog     = "axcq604"
                     LET la_param.param[1] = g_master.xckkcomp    #法人
                     LET la_param.param[2] = g_master.xckkld      #账套
                     LET la_param.param[3] = g_master.xckk001     #本位币顺序
                     LET la_param.param[4] = g_master.xckk002     #成本计算类型
                     LET la_param.param[5] = g_master.xckk003     #年度
                     LET la_param.param[6] = g_master.xckk004     #期别
                     LET la_param.param[7] = g_xckk_d[g_detail_idx].xckk005 #核对项目
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun(ls_js)
                  ELSE
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_xckk_d[g_detail_idx].xckk005_desc
                     LET g_errparam.code   = "axc-00761"
                     LET g_errparam.popup  = TRUE 
                     CALL cl_err()
                  END IF
               END IF
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION open_xckk090
            LET g_action_choice="open_xckk090"
            IF cl_auth_chk_act("open_xckk090") THEN
               
               #add-point:ON ACTION open_xckk090 name="menu.detail_show.page1.open_xckk090"
               IF l_ac > 0 THEN
                  IF NOT cl_null(g_xckk_d[g_detail_idx].xckk090) THEN
                     INITIALIZE la_param.* TO NULL
                     LET la_param.prog     = g_xckk_d[g_detail_idx].xckk090
                     LET la_param.param[1] = g_master.xckkcomp    #法人
                     LET la_param.param[2] = g_master.xckkld      #账套
                     LET la_param.param[3] = g_master.xckk001     #本位币顺序
                     LET la_param.param[4] = g_master.xckk002     #成本计算类型
                     #LET la_param.param[5] = g_master.xckk003     #年度
                     #LET la_param.param[6] = g_master.xckk004     #期别
                     
                     LET ls_js = util.JSON.stringify(la_param)
                     CALL cl_cmdrun(ls_js)
                  END IF
               END IF
               #END add-point
               
               
            END IF
 
 
 
 
 
            #add-point:page1自定義行為 name="ui_dialog.body.page1.action"
            
            #end add-point
 
         END DISPLAY
 
         #add-point:第一頁籤程式段mark結束用 name="ui_dialog.page1.mark.end"
         
         #end add-point
 
         DISPLAY ARRAY g_xckk3_d TO s_detail3.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 2
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail3")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
               #add-point:input段before row name="input.body3.before_row"
               
               #end add-point
 
            #自訂ACTION(detail_show,page_2)
            
 
            #add-point:page2自定義行為 name="ui_dialog.body3.action"
            
            #end add-point
 
         END DISPLAY
 
         DISPLAY ARRAY g_xckk4_d TO s_detail4.*
            ATTRIBUTES(COUNT=g_detail_cnt)
 
            BEFORE DISPLAY
               LET g_current_page = 3
 
            BEFORE ROW
               LET g_detail_idx2 = DIALOG.getCurrentRow("s_detail4")
               LET l_ac = g_detail_idx2
               LET g_detail_idx2 = l_ac
               DISPLAY g_detail_idx2 TO FORMONLY.idx
 
               #add-point:input段before row name="input.body4.before_row"
               
               #end add-point
 
            #自訂ACTION(detail_show,page_3)
            
 
            #add-point:page3自定義行為 name="ui_dialog.body4.action"
            
            #end add-point
 
         END DISPLAY
 
 
 
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         
         #end add-point
 
         BEFORE DIALOG
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL DIALOG.setSelectionMode("s_detail1", 1)
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            CALL axcq603_detail_action_trans()
 
            #add-point:ui_dialog段before dialog name="ui_dialog.bef_dialog"
            CALL DIALOG.setArrayAttributes("s_detail1",g_xckk_d_color)
            #end add-point
            NEXT FIELD xckkcomp
 
         AFTER DIALOG
            #add-point:ui_dialog段 after dialog name="ui_dialog.after_dialog"
            
            #end add-point
            
         ON ACTION exit
            LET g_action_choice="exit"
            LET INT_FLAG = FALSE
            LET li_exit = TRUE
            EXIT DIALOG 
      
         ON ACTION close
            LET INT_FLAG=FALSE
            LET li_exit = TRUE
            EXIT DIALOG
 
         ON ACTION accept
            INITIALIZE g_wc_filter TO NULL
            IF cl_null(g_wc) THEN
               LET g_wc = " 1=1"
            END IF
 
            IF NOT cl_null(g_wc2_table2) AND g_wc2_table2 <> " 1=1" THEN
               LET g_wc = g_wc, " AND ", g_wc2_table2
            END IF
 
 
         
            IF cl_null(g_wc2) THEN
               LET g_wc2 = " 1=1"
            END IF
 
            IF NOT cl_null(g_wc2_table2) AND g_wc2_table2 <> " 1=1" THEN
               LET g_wc2 = g_wc2, " AND ", g_wc2_table2
            END IF
 
 
 
            #add-point:ON ACTION accept name="ui_dialog.accept"
            
            #end add-point
 
            LET g_detail_idx = 1
            LET g_detail_idx2 = 1
            CALL axcq603_b_fill()
 
            IF g_detail_cnt = 0 AND NOT INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = ""
               LET g_errparam.code   = -100
               LET g_errparam.popup  = TRUE
               CALL cl_err()
            END IF
 
 
         ON ACTION agendum   # 待辦事項
            #add-point:ON ACTION agendum name="ui_dialog.agendum"
            
            #end add-point
            CALL cl_user_overview()
 
         ON ACTION exporttoexcel   #匯出excel
            LET g_action_choice="exporttoexcel"
            IF cl_auth_chk_act("exporttoexcel") THEN
               CALL g_export_node.clear()
               LET g_export_node[1] = base.typeInfo.create(g_xckk_d)
               LET g_export_id[1]   = "s_detail1"
               LET g_export_node[2] = base.typeInfo.create(g_xckk3_d)
               LET g_export_id[2]   = "s_detail3"
 
               LET g_export_node[3] = base.typeInfo.create(g_xckk4_d)
               LET g_export_id[3]   = "s_detail4"
 
 
               #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
               
               #END add-point
               CALL cl_export_to_excel_getpage()
               CALL cl_export_to_excel()
            END IF
 
         ON ACTION datarefresh   # 重新整理
            CALL axcq603_b_fill()
 
         ON ACTION qbehidden     #qbe頁籤折疊
            IF g_qbe_hidden THEN
               CALL gfrm_curr.setElementHidden("qbe",0)
               CALL gfrm_curr.setElementImage("qbehidden","16/mainhidden.png")
               LET g_qbe_hidden = 0     #visible
            ELSE
               CALL gfrm_curr.setElementHidden("qbe",1)
               CALL gfrm_curr.setElementImage("qbehidden","16/worksheethidden.png")
               LET g_qbe_hidden = 1     #hidden
            END IF
 
         ON ACTION detail_first               #page first
            LET g_action_choice = "detail_first"
            LET g_detail_page_action = "detail_first"
            CALL axcq603_b_fill()
 
         ON ACTION detail_previous                #page previous
            LET g_action_choice = "detail_previous"
            LET g_detail_page_action = "detail_previous"
            CALL axcq603_b_fill()
 
         ON ACTION detail_next               #page next
            LET g_action_choice = "detail_next"
            LET g_detail_page_action = "detail_next"
            CALL axcq603_b_fill()
 
         ON ACTION detail_last               #page last
            LET g_action_choice = "detail_last"
            LET g_detail_page_action = "detail_last"
            CALL axcq603_b_fill()
 
         #應用 qs19 樣板自動產生(Version:3)
         #有關於sel欄位選取的action段落
         #選擇全部
         ON ACTION selall
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 1)
            FOR li_idx = 1 TO g_xckk_d.getLength()
               LET g_xckk_d[li_idx].sel = "Y"
            END FOR
 
            #add-point:ui_dialog段on action selall name="ui_dialog.onaction_selall"
            
            #end add-point
 
         #取消全部
         ON ACTION selnone
            CALL DIALOG.setSelectionRange("s_detail1", 1, -1, 0)
            FOR li_idx = 1 TO g_xckk_d.getLength()
               LET g_xckk_d[li_idx].sel = "N"
            END FOR
 
            #add-point:ui_dialog段on action selnone name="ui_dialog.onaction_selnone"
            
            #end add-point
 
         #勾選所選資料
         ON ACTION sel
            FOR li_idx = 1 TO g_xckk_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_xckk_d[li_idx].sel = "Y"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action sel name="ui_dialog.onaction_sel"
            
            #end add-point
 
         #取消所選資料
         ON ACTION unsel
            FOR li_idx = 1 TO g_xckk_d.getLength()
               IF DIALOG.isRowSelected("s_detail1", li_idx) THEN
                  LET g_xckk_d[li_idx].sel = "N"
               END IF
            END FOR
 
            #add-point:ui_dialog段on action unsel name="ui_dialog.onaction_unsel"
            
            #end add-point
 
 
 
 
 
         #應用 qs16 樣板自動產生(Version:3)
         ON ACTION filter
            LET g_action_choice="filter"
            CALL axcq603_filter()
            #add-point:ON ACTION filter name="menu.filter"
            
            #END add-point
            EXIT DIALOG
 
 
 
 
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION insert
            LET g_action_choice="insert"
            IF cl_auth_chk_act("insert") THEN
               
               #add-point:ON ACTION insert name="menu.insert"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION datainfo
            LET g_action_choice="datainfo"
            IF cl_auth_chk_act("datainfo") THEN
               
               #add-point:ON ACTION datainfo name="menu.datainfo"
               
               #END add-point
               
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION gen_xckk_xckl
            LET g_action_choice="gen_xckk_xckl"
            IF cl_auth_chk_act("gen_xckk_xckl") THEN
               
               #add-point:ON ACTION gen_xckk_xckl name="menu.gen_xckk_xckl"
               IF axcq603_gen_xckk() THEN
                  LET g_progress_show = TRUE    #170215-00060#1 add
                  CALL axcq603_b_fill()
                  LET g_progress_show = FALSE   #170215-00060#1 add
               END IF
               #END add-point
               
               
            END IF
 
 
 
 
      
         #主選單用ACTION
         &include "main_menu_exit_dialog.4gl"
         &include "relating_action.4gl"
         #交談指令共用ACTION
         &include "common_action.4gl"
 
         #add-point:查詢方案相關ACTION設定前 name="ui_dialog.set_qbe_action_before"
         
         #end add-point
 
         ON ACTION qbeclear   # 條件清除
            CLEAR FORM
            #add-point:條件清除後 name="ui_dialog.qbeclear"
            
            #end add-point
 
         #add-point:查詢方案相關ACTION設定後 name="ui_dialog.set_qbe_action_after"
         
         #end add-point
 
      END DIALOG 
   
   END WHILE
 
END FUNCTION
 
{</section>}
 
{<section id="axcq603.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION axcq603_b_fill()
   #add-point:b_fill段define-客製 name="b_fill.define_customerization"
   
   #end add-point
   DEFINE ls_wc           STRING
   DEFINE l_pid           LIKE type_t.chr50
   DEFINE ls_sql_rank     STRING
   #add-point:b_fill段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_n             LIKE type_t.num5
   DEFINE l_sub_sql       STRING
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
 
   LET ls_wc = g_wc, " AND ", g_wc2, " AND ", g_wc_filter, cl_sql_auth_filter()   #(ver:34) add cl_sql_auth_filter()
 
   CALL g_xckk_d.clear()
 
   #add-point:陣列清空 name="b_fill.array_clear"
   IF cl_null(ls_wc) THEN
      LET ls_wc = " 1=1"
   END IF
   CALL g_xckk_d_color.clear()
   LET l_n = 0
   LET l_sub_sql = " 1=1"
   #end add-point
 
   LET g_cnt = l_ac
   IF g_cnt = 0 THEN
      LET g_cnt = 1
   END IF
   LET l_ac = 1
 
   # b_fill段sql組成及FOREACH撰寫
   #應用 qs04 樣板自動產生(Version:9)
   #+ b_fill段資料取得(包含sql組成及FOREACH段撰寫)
   LET ls_sql_rank = "SELECT  UNIQUE '','','',xckk101,xckk102,xckk103,xckk104,xckk105,xckk106,xckk090, 
       xckk102a,xckk104a,xckk106a,xckk102b,xckk104b,xckk106b,xckk102c,xckk104c,xckk106c,xckk102d,xckk104d, 
       xckk106d,xckk102e,xckk104e,xckk106e,xckk102f,xckk104f,xckk106f,xckk102g,xckk104g,xckk106g,xckk102h, 
       xckk104h,xckk106h,xckk005  ,DENSE_RANK() OVER( ORDER BY xckk_t.xckkld,xckk_t.xckk001,xckk_t.xckk002, 
       xckk_t.xckk003,xckk_t.xckk004,xckk_t.xckk005) AS RANK FROM xckk_t",
 
#table2
                     " LEFT JOIN gzcb_t ON xckkld = gzcb001 AND xckk001 = gzcb002",
 
                     "",
                     " WHERE xckkent= ? AND 1=1 AND ", ls_wc
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("xckk_t"),
                     " ORDER BY xckk_t.xckkld,xckk_t.xckk001,xckk_t.xckk002,xckk_t.xckk003,xckk_t.xckk004,xckk_t.xckk005"
 
   #add-point:b_fill段rank_sql_after name="b_fill.rank_sql_after"
   #判斷axci601中是否有維護選擇否為N的資料，如果有，則相應的核算項目不顯示出來
   SELECT COUNT(1) INTO l_n FROM xcbm_t WHERE xcbment = g_enterprise AND xcbmld = g_master.xckkld AND xcbm006 = g_master.xckk002 AND xcbm004 = 'N'
   IF l_n > 0 THEN
      LET l_sub_sql = " gzcb002 NOT IN ( SELECT xcbm001 FROM xcbm_t WHERE xcbment = '",g_enterprise,"' ",
                      "                        AND xcbmld = '",g_master.xckkld,"' AND xcbm006 = '",g_master.xckk002,"' AND xcbm004 = 'N' ) "
   END IF  
   #160802-00020#8-mod-(S)  多加法人、帳套的段落進去
   #LET ls_sql_rank =  " SELECT  UNIQUE '',gzcb012,gzcb002,gzcbl004,",
   #             "                xckk101,xckk102,xckk103,xckk104,xckk105,xckk106,xckk090, ",
   #             "                xckk102a,xckk104a,xckk106a,xckk102b,xckk104b,xckk106b, ",
   #             "                xckk102c,xckk104c,xckk106c,xckk102d,xckk104d,xckk106d, ",
   #             "                xckk102e,xckk104e,xckk106e,xckk102f,xckk104f,xckk106f, ",
   #             "                xckk102g,xckk104g,xckk106g,xckk102h,xckk104h,xckk106h, ", 
   #             "                DENSE_RANK() OVER( ORDER BY gzcb_t.gzcb012) AS RANK    ",
   #             "     FROM gzcb_t LEFT JOIN xckk_t ON gzcb002 = xckk005 AND xckkent  = ? ",
   #             "                                  AND xckkcomp = '",g_master.xckkcomp,"'",    #法人
   #             "                                  AND xckkld   = '",g_master.xckkld,"'",      #账套
   #             "                                  AND xckk001  = '",g_master.xckk001,"'",     #本位币顺序
   #             "                                  AND xckk002  = '",g_master.xckk002,"'",     #成本计算类型
   #             "                                  AND xckk003  = '",g_master.xckk003,"'",     #年度  
   #             "                                  AND xckk004  = '",g_master.xckk004,"'",     #期别
   #             "                 LEFT JOIN gzcbl_t ON gzcbl001 = gzcb001 AND gzcbl002 = gzcb002 AND gzcbl003 = '"||g_dlang||"'" ,               
   #             "     WHERE gzcb001 = '8922' AND gzcb002 NOT LIKE '9%' " ,
   #             "       AND ", ls_wc,
   #             "       AND ", l_sub_sql
   LET ls_sql_rank =  " SELECT  UNIQUE '',gzcb012,gzcb002,gzcbl004,",
                "                xckk101,xckk102,xckk103,xckk104,xckk105,xckk106,xckk090, ",
                "                xckk102a,xckk104a,xckk106a,xckk102b,xckk104b,xckk106b, ",
                "                xckk102c,xckk104c,xckk106c,xckk102d,xckk104d,xckk106d, ",
                "                xckk102e,xckk104e,xckk106e,xckk102f,xckk104f,xckk106f, ",
                "                xckk102g,xckk104g,xckk106g,xckk102h,xckk104h,xckk106h, ", 
                "                DENSE_RANK() OVER( ORDER BY gzcb_t.gzcb012) AS RANK    ",
                "     FROM gzcb_t LEFT JOIN xckk_t ON gzcb002 = xckk005 AND xckkent  = ? ",
                "                                  AND xckkcomp = '",g_master.xckkcomp,"'",    #法人
                "                                  AND xckkld   = '",g_master.xckkld,"'",      #账套
                "                                  AND xckk001  = '",g_master.xckk001,"'",     #本位币顺序
                "                                  AND xckk002  = '",g_master.xckk002,"'",     #成本计算类型
                "                                  AND xckk003  = '",g_master.xckk003,"'",     #年度  
                "                                  AND xckk004  = '",g_master.xckk004,"'"     #期别
   #---增加帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET ls_sql_rank = ls_sql_rank ," AND xckkld IN ",g_wc_cs_ld
    END IF
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET ls_sql_rank = ls_sql_rank ," AND xckkcomp IN ",g_wc_cs_comp
   END IF             
   LET ls_sql_rank =  ls_sql_rank, "      LEFT JOIN gzcbl_t ON gzcbl001 = gzcb001 AND gzcbl002 = gzcb002 AND gzcbl003 = '"||g_dlang||"'" ,               
                      "     WHERE gzcb001 = '8922' AND gzcb002 NOT LIKE '9%' " ,
                      "       AND ", ls_wc,
                      "       AND ", l_sub_sql
   
   #160802-00020#8-mod-(E)
   LET ls_sql_rank = ls_sql_rank, cl_sql_add_filter("xckk_t"),
                     " ORDER BY gzcb_t.gzcb012 "
   #end add-point
 
   LET g_sql = "SELECT COUNT(1) FROM (",ls_sql_rank,")"
 
   PREPARE b_fill_cnt_pre FROM g_sql  #總筆數
   EXECUTE b_fill_cnt_pre USING g_enterprise INTO g_tot_cnt
   FREE b_fill_cnt_pre
 
   #add-point:b_fill段rank_sql_after_count name="b_fill.rank_sql_after_count"
   #170112-00033#1-S
   #170215-00060#1 mod-S
#   IF g_tot_cnt > 0 THEN
   IF g_tot_cnt > 0 AND g_progress_show = TRUE THEN
   #170215-00060#1 mod-E
      CALL cl_progress_bar(g_tot_cnt)   
   END IF 
   #170112-00033#1-E
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
 
   LET g_sql = "SELECT '','','',xckk101,xckk102,xckk103,xckk104,xckk105,xckk106,xckk090,xckk102a,xckk104a, 
       xckk106a,xckk102b,xckk104b,xckk106b,xckk102c,xckk104c,xckk106c,xckk102d,xckk104d,xckk106d,xckk102e, 
       xckk104e,xckk106e,xckk102f,xckk104f,xckk106f,xckk102g,xckk104g,xckk106g,xckk102h,xckk104h,xckk106h, 
       xckk005",
               " FROM (",ls_sql_rank,")",
              " WHERE RANK >= ",g_pagestart,
                " AND RANK < ",g_pagestart + g_num_in_page
 
   #add-point:b_fill段sql_after name="b_fill.sql_after"
   #LET g_sql =  " SELECT  '', gzcb012,gzcb002,gzcbl004,",  #160719-00012#1
   LET g_sql =  " SELECT  '', gzcb012,gzcbl004,",  #160719-00012#1
                #170215-00060#1 mod-S
#                "                xckk101,xckk102,xckk103,xckk104,xckk105,xckk106,xckk090, ",
                "                xckk101,xckk102,DECODE(gzcb002,'211',xckk103*-1,xckk103) xckk103,DECODE(gzcb002,'211',xckk104*-1,xckk104) xckk104,xckk105,xckk106,xckk090, ",
                #170215-00060#1 mod-E
                "                xckk102a,xckk104a,xckk106a,xckk102b,xckk104b,xckk106b, ",
                "                xckk102c,xckk104c,xckk106c,xckk102d,xckk104d,xckk106d, ",
                "                xckk102e,xckk104e,xckk106e,xckk102f,xckk104f,xckk106f, ",
                "                xckk102g,xckk104g,xckk106g,xckk102h,xckk104h,xckk106h , ", 
                "                gzcb002 ",  #160719-00012#1
                "     FROM (",ls_sql_rank,")",
                " WHERE RANK >= ",g_pagestart,
                "   AND RANK < ",g_pagestart + g_num_in_page
   
   #end add-point
 
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axcq603_pb FROM g_sql
   DECLARE b_fill_curs CURSOR FOR axcq603_pb
 
   OPEN b_fill_curs USING g_enterprise
 
   FOREACH b_fill_curs INTO g_xckk_d[l_ac].sel,g_xckk_d[l_ac].gzcb012,g_xckk_d[l_ac].xckk005_desc,g_xckk_d[l_ac].xckk101, 
       g_xckk_d[l_ac].xckk102,g_xckk_d[l_ac].xckk103,g_xckk_d[l_ac].xckk104,g_xckk_d[l_ac].xckk105,g_xckk_d[l_ac].xckk106, 
       g_xckk_d[l_ac].xckk090,g_xckk_d[l_ac].xckk102a,g_xckk_d[l_ac].xckk104a,g_xckk_d[l_ac].xckk106a, 
       g_xckk_d[l_ac].xckk102b,g_xckk_d[l_ac].xckk104b,g_xckk_d[l_ac].xckk106b,g_xckk_d[l_ac].xckk102c, 
       g_xckk_d[l_ac].xckk104c,g_xckk_d[l_ac].xckk106c,g_xckk_d[l_ac].xckk102d,g_xckk_d[l_ac].xckk104d, 
       g_xckk_d[l_ac].xckk106d,g_xckk_d[l_ac].xckk102e,g_xckk_d[l_ac].xckk104e,g_xckk_d[l_ac].xckk106e, 
       g_xckk_d[l_ac].xckk102f,g_xckk_d[l_ac].xckk104f,g_xckk_d[l_ac].xckk106f,g_xckk_d[l_ac].xckk102g, 
       g_xckk_d[l_ac].xckk104g,g_xckk_d[l_ac].xckk106g,g_xckk_d[l_ac].xckk102h,g_xckk_d[l_ac].xckk104h, 
       g_xckk_d[l_ac].xckk106h,g_xckk_d[l_ac].xckk005
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill段資料填充 name="b_fill.fill"
      #170112-00033#1-S      
      IF g_progress_show = TRUE THEN #170215-00060#1 add
         CALL cl_progress_ing(g_xckk_d[l_ac].xckk005_desc)
      END IF #170215-00060#1 add
      #170112-00033#1-E
      #end add-point
 
      CALL axcq603_detail_show("'1'")
 
      CALL axcq603_xckk_t_mask()
 
      IF l_ac > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend =  "" 
            LET g_errparam.code   =  9035 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
 
         END IF
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
 
   END FOREACH
 
 
 
 
 
   #應用 qs05 樣板自動產生(Version:4)
   #+ b_fill段其他table資料取得(包含sql組成及資料填充)
 
 
 
 
 
 
   #add-point:b_fill段資料填充(其他單身) name="b_fill.others.fill"
   
   #end add-point
 
   CALL g_xckk_d.deleteElement(g_xckk_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill.array_deleteElement"
   #差异数量栏位=“成本总表-数量”-“成本明细表-数量”，若差异<>0，栏位需黄底标识
   #差异金额栏位=“成本总表-金额”-“成本明细表-金额”，若差异<>0，栏位需黄底标识
   FOR l_n = 1 TO g_xckk_d.getLength()
      IF g_xckk_d[l_n].xckk105 <> 0 THEN
         LET g_xckk_d_color[l_n].xckk105 = "yellow reverse"
      END IF
      IF g_xckk_d[l_n].xckk106 <> 0 THEN
         LET g_xckk_d_color[l_n].xckk106 = "yellow reverse"
      END IF
      #IF g_xckk_d[l_n].xckk106a <> 0 THEN
      #   LET g_xckk_d_color[l_n].xckk106a = "yellow reverse"
      #END IF
      #IF g_xckk_d[l_n].xckk106b <> 0 THEN
      #   LET g_xckk_d_color[l_n].xckk106b = "yellow reverse"
      #END IF
      #IF g_xckk_d[l_n].xckk106c <> 0 THEN
      #   LET g_xckk_d_color[l_n].xckk106c = "yellow reverse"
      #END IF
      #IF g_xckk_d[l_n].xckk106d <> 0 THEN
      #   LET g_xckk_d_color[l_n].xckk106d = "yellow reverse"
      #END IF
      #IF g_xckk_d[l_n].xckk106e <> 0 THEN
      #   LET g_xckk_d_color[l_n].xckk106e = "yellow reverse"
      #END IF
      #IF g_xckk_d[l_n].xckk106f <> 0 THEN
      #   LET g_xckk_d_color[l_n].xckk106f = "yellow reverse"
      #END IF
      #IF g_xckk_d[l_n].xckk106g <> 0 THEN
      #   LET g_xckk_d_color[l_n].xckk106g = "yellow reverse"
      #END IF
      #IF g_xckk_d[l_n].xckk106h <> 0 THEN
      #   LET g_xckk_d_color[l_n].xckk106h = "yellow reverse"
      #END IF
   END FOR
   #CALL cl_progress_bar_close() 
   #end add-point
 
   LET g_error_show = 0
 
   LET g_detail_cnt = g_xckk_d.getLength()
   LET l_ac = g_cnt
   LET g_cnt = 0
 
   #應用 qs06 樣板自動產生(Version:3)
   #+ b_fill段CURSOR釋放
   CLOSE b_fill_curs
   FREE axcq603_pb
 
 
 
 
 
 
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL axcq603_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL axcq603_detail_action_trans()
 
   LET l_ac = 1
   IF g_xckk_d.getLength() > 0 THEN
      CALL axcq603_b_fill2()
   END IF
 
      CALL axcq603_filter_show('xckk101','b_xckk101')
   CALL axcq603_filter_show('xckk102','b_xckk102')
   CALL axcq603_filter_show('xckk103','b_xckk103')
   CALL axcq603_filter_show('xckk104','b_xckk104')
   CALL axcq603_filter_show('xckk105','b_xckk105')
   CALL axcq603_filter_show('xckk106','b_xckk106')
   CALL axcq603_filter_show('xckk090','b_xckk090')
   CALL axcq603_filter_show('xckk102a','b_xckk102a')
   CALL axcq603_filter_show('xckk104a','b_xckk104a')
   CALL axcq603_filter_show('xckk106a','b_xckk106a')
   CALL axcq603_filter_show('xckk102b','b_xckk102b')
   CALL axcq603_filter_show('xckk104b','b_xckk104b')
   CALL axcq603_filter_show('xckk106b','b_xckk106b')
   CALL axcq603_filter_show('xckk102c','b_xckk102c')
   CALL axcq603_filter_show('xckk104c','b_xckk104c')
   CALL axcq603_filter_show('xckk106c','b_xckk106c')
   CALL axcq603_filter_show('xckk102d','b_xckk102d')
   CALL axcq603_filter_show('xckk104d','b_xckk104d')
   CALL axcq603_filter_show('xckk106d','b_xckk106d')
   CALL axcq603_filter_show('xckk102e','b_xckk102e')
   CALL axcq603_filter_show('xckk104e','b_xckk104e')
   CALL axcq603_filter_show('xckk106e','b_xckk106e')
   CALL axcq603_filter_show('xckk102f','b_xckk102f')
   CALL axcq603_filter_show('xckk104f','b_xckk104f')
   CALL axcq603_filter_show('xckk106f','b_xckk106f')
   CALL axcq603_filter_show('xckk102g','b_xckk102g')
   CALL axcq603_filter_show('xckk104g','b_xckk104g')
   CALL axcq603_filter_show('xckk106g','b_xckk106g')
   CALL axcq603_filter_show('xckk102h','b_xckk102h')
   CALL axcq603_filter_show('xckk104h','b_xckk104h')
   CALL axcq603_filter_show('xckk106h','b_xckk106h')
   CALL axcq603_filter_show('xckk005','b_xckk005')
 
 
END FUNCTION
 
{</section>}
 
{<section id="axcq603.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION axcq603_b_fill2()
   #add-point:b_fill2段define-客製 name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE li_ac           LIKE type_t.num10
   #add-point:b_fill2段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   DEFINE l_i             LIKE type_t.num10
   #end add-point
 
   #add-point:FUNCTION前置處理 name="b_fill2.before_function"
   
   #end add-point
 
   LET li_ac = l_ac
 
   #單身組成
   #應用 qs07 樣板自動產生(Version:7)
   #+ b_fill2段table資料取得(包含sql組成及資料填充)
#Page2
   CALL g_xckk3_d.clear()
#Page3
   CALL g_xckk4_d.clear()
 
   #add-point:陣列清空 name="b_fill2.array_clear"
   #170306-00041#1 marked-S
#   LET g_sql = "SELECT  UNIQUE gzcb012,gzcb002,gzcbl004,'','','' FROM gzcb_t",
#            "                 LEFT JOIN gzcbl_t ON gzcbl001 = gzcb001 AND gzcbl002 = gzcb002 AND gzcbl003 = '"||g_dlang||"'" ,               
#            " WHERE gzcb001 = '8929' " ,
#            " ORDER BY gzcb012 "
#   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
#   PREPARE axcq603_pb3 FROM g_sql
#   DECLARE b_fill_curs3 CURSOR FOR axcq603_pb3
#
#   LET l_ac = 1
#   FOREACH b_fill_curs3 INTO g_xckk2_d[l_ac].gzcb012,g_xckk2_d[l_ac].gzcb002,g_xckk2_d[l_ac].gzcb002_desc, 
#       g_xckk2_d[l_ac].glar005,g_xckk2_d[l_ac].xccc202,g_xckk2_d[l_ac].xccc202a
#      IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL 
#         LET g_errparam.extend = "FOREACH:" 
#         LET g_errparam.code   = SQLCA.sqlcode 
#         LET g_errparam.popup  = TRUE 
#         CALL cl_err()
# 
#         EXIT FOREACH
#      END IF 
#      
#      IF l_ac > g_max_rec THEN
#         INITIALIZE g_errparam TO NULL 
#         LET g_errparam.extend =  "" 
#         LET g_errparam.code   =  9035 
#         LET g_errparam.popup  = TRUE 
#         CALL cl_err()
# 
#         EXIT FOREACH
#      END IF
#      LET l_ac = l_ac + 1
# 
#   END FOREACH 
#   
#   CALL g_xckk2_d.deleteElement(g_xckk2_d.getLength())
   
#   #总账报表核对单身资料固定填充
#   #1	當月採購發生額	1.取agli161的【存貨科目+委外加工費】glcc002+glcc005所設定科目的集合。 2.SUM(取科目當期餘額)	 #子报表取 axcq004.【一般採購+委外入庫】 (xccc202)      
#   SELECT SUM((CASE WHEN glar005 IS NULL THEN 0  ELSE glar005 END) - (CASE WHEN glar006 IS NULL THEN 0  ELSE glar006 END)) 
#     INTO g_xckk2_d[1].glar005 FROM glar_t , glcc_t
#     WHERE glarent = g_enterprise AND glarld = g_master.xckkld AND glarcomp = g_master.xckkcomp
#       AND glar002 = g_master.xckk003 AND glar003 = g_master.xckk004
#       AND glarent = glccent AND glarld = glccld AND glcc001 = '1' #存货类科目设置
#       AND (glar001 = glcc002 OR glar001 = glcc005) 
#   
#   SELECT SUM((CASE WHEN xccc202 IS NULL THEN 0  ELSE xccc202 END) + (CASE WHEN xccc204 IS NULL THEN 0  ELSE xccc204 END)) 
#     INTO g_xckk2_d[1].xccc202 FROM xccc_t 
#     WHERE xcccent = g_enterprise AND xcccld = g_master.xckkld AND xccccomp = g_master.xckkcomp
#       AND xccc001 = g_master.xckk001 AND xccc003 = g_master.xckk002 
#       AND xccc004 = g_master.xckk003 AND xccc005 = g_master.xckk004
#   IF cl_null(g_xckk2_d[1].glar005) THEN 
#      LET g_xckk2_d[1].glar005 = 0 
#   END IF
#   IF cl_null(g_xckk2_d[1].xccc202) THEN 
#      LET g_xckk2_d[1].xccc202 = 0 
#   END IF
#   #差异金额 
#   LET g_xckk2_d[1].xccc202a = g_xckk2_d[1].glar005 - g_xckk2_d[1].xccc202
#   
#   #2 在製期初餘額    1.取agli161的【在製材料+人工+加工+製費(1~5)】glcc002+...+glcc019所設定科目的集合。 2.SUM(取科目上一期餘額) axcq004.【在製期初】 (xccc202)
#   SELECT SUM((CASE WHEN glar005 IS NULL THEN 0  ELSE glar005 END) - (CASE WHEN glar006 IS NULL THEN 0  ELSE glar006 END)) 
#     INTO g_xckk2_d[2].glar005 FROM glar_t , glcc_t
#     WHERE glarent = g_enterprise AND glarld = g_master.xckkld AND glarcomp = g_master.xckkcomp
#       AND glar002 = g_master.xckk003 AND glar003 < g_master.xckk004 #期初
#       AND glarent = glccent AND glarld = glccld AND glcc001 = '3' #在制科目设置
#       AND (glar001 = glcc002 OR glar001 = glcc003 OR glar001 = glcc004 OR glar001 = glcc005 OR glar001 = glcc006 OR glar001 = glcc017 OR glar001 = glcc018 OR glar001 = glcc019)
#  
#   SELECT SUM((CASE WHEN xcce102 IS NULL THEN 0 ELSE xcce102 END)) INTO g_xckk2_d[2].xccc202
#     FROM xcce_t 
#     WHERE xcceent = g_enterprise AND xcceld = g_master.xckkld AND xccecomp = g_master.xckkcomp
#       AND xcce001 = g_master.xckk001 AND xcce003 = g_master.xckk002 
#       AND xcce004 = g_master.xckk003 AND xcce005 = g_master.xckk004   
#   IF cl_null(g_xckk2_d[2].glar005) THEN 
#      LET g_xckk2_d[2].glar005 = 0 
#   END IF
#   IF cl_null(g_xckk2_d[2].xccc202) THEN 
#      LET g_xckk2_d[2].xccc202 = 0 
#   END IF
#   #差异金额 
#   LET g_xckk2_d[2].xccc202a = g_xckk2_d[2].glar005 - g_xckk2_d[2].xccc202     
#   
#   #3 在製本期借方    1.取agli161的【在製材料+人工+加工+製費(1~5)】glcc002+...+glcc019所設定科目的集合。 2.SUM(取科目本期借方發生額) axcq004.【原料投入+半成品投入】 (xccc202)
#   SELECT SUM((CASE WHEN glar005 IS NULL THEN 0  ELSE glar005 END)) INTO g_xckk2_d[3].glar005 FROM glar_t , glcc_t
#     WHERE glarent = g_enterprise AND glarld = g_master.xckkld AND glarcomp = g_master.xckkcomp
#       AND glar002 = g_master.xckk003 AND glar003 = g_master.xckk004  #本期
#       AND glarent = glccent AND glarld = glccld AND glcc001 = '3' #在制科目设置
#       AND (glar001 = glcc002 OR glar001 = glcc003 OR glar001 = glcc004 OR glar001 = glcc005 OR glar001 = glcc006 OR glar001 = glcc017 OR glar001 = glcc018 OR glar001 = glcc019)
#   
#   SELECT SUM((CASE imaa004 WHEN 'M' THEN xcce202+xcce206+xcce208+xcce210 ELSE 0 END) + (CASE imaa004 WHEN 'A' THEN xcce202+xcce206+xcce208+xcce210 ELSE 0 END))
#      INTO g_xckk2_d[3].xccc202
#      FROM xcce_t,imaa_t 
#      WHERE xcceent = g_enterprise AND xcceld = g_master.xckkld AND xccecomp = g_master.xckkcomp
#        AND xcce001 = g_master.xckk001 AND xcce003 = g_master.xckk002 
#        AND xcce004 = g_master.xckk003 AND xcce005 = g_master.xckk004
#        AND xcceent = imaaent AND xcce007  = imaa001 AND xcce007 <> 'DL+OH+SUB'
#   IF cl_null(g_xckk2_d[3].glar005) THEN 
#      LET g_xckk2_d[3].glar005 = 0 
#   END IF
#   IF cl_null(g_xckk2_d[3].xccc202) THEN 
#      LET g_xckk2_d[3].xccc202 = 0 
#   END IF
#   #差异金额 
#   LET g_xckk2_d[3].xccc202a = g_xckk2_d[3].glar005 - g_xckk2_d[3].xccc202  
#
#   #4 在製本期貸方    1.取agli161的【在製材料+人工+加工+製費(1~5)】glcc002+...+glcc019所設定科目的集合。 2.SUM(取科目本期貸方發生額) axcq004.【在製轉出】 (xccc202)
#   SELECT SUM((CASE WHEN glar006 IS NULL THEN 0  ELSE glar006 END)) INTO g_xckk2_d[4].glar005 FROM glar_t , glcc_t
#     WHERE glarent = g_enterprise AND glarld = g_master.xckkld AND glarcomp = g_master.xckkcomp
#       AND glar002 = g_master.xckk003 AND glar003 = g_master.xckk004  #本期
#       AND glarent = glccent AND glarld = glccld AND glcc001 = '3' #在制科目设置
#       AND (glar001 = glcc002 OR glar001 = glcc003 OR glar001 = glcc004 OR glar001 = glcc005 OR glar001 = glcc006 OR glar001 = glcc017 OR glar001 = glcc018 OR glar001 = glcc019)
#   
#   SELECT SUM((CASE WHEN xcce302 IS NULL THEN 0 ELSE xcce302 END)) INTO g_xckk2_d[4].xccc202
#     FROM xcce_t
#     WHERE xcceent = g_enterprise AND xcceld = g_master.xckkld AND xccecomp = g_master.xckkcomp
#       AND xcce001 = g_master.xckk001 AND xcce003 = g_master.xckk002 
#       AND xcce004 = g_master.xckk003 AND xcce005 = g_master.xckk004 
#   IF cl_null(g_xckk2_d[4].glar005) THEN 
#      LET g_xckk2_d[4].glar005 = 0 
#   END IF
#   IF cl_null(g_xckk2_d[4].xccc202) THEN 
#      LET g_xckk2_d[4].xccc202 = 0 
#   END IF
#   #差异金额 
#   LET g_xckk2_d[4].xccc202a = g_xckk2_d[4].glar005 - g_xckk2_d[4].xccc202
#
#   #5 在製期末餘額    1.取agli161的【在製材料+人工+加工+製費(1~5)】glcc002+...+glcc019所設定科目的集合。 2.SUM(取科目本期累計餘額)    axcq004.【在製期末】
#   SELECT SUM((CASE WHEN glar005 IS NULL THEN 0  ELSE glar005 END) - (CASE WHEN glar006 IS NULL THEN 0  ELSE glar006 END)) 
#     INTO g_xckk2_d[5].glar005 FROM glar_t , glcc_t
#     WHERE glarent = g_enterprise AND glarld = g_master.xckkld AND glarcomp = g_master.xckkcomp
#       AND glar002 = g_master.xckk003 AND glar003 = g_master.xckk004  #本期
#       AND glarent = glccent AND glarld = glccld AND glcc001 = '3' #在制科目设置
#       AND (glar001 = glcc002 OR glar001 = glcc003 OR glar001 = glcc004 OR glar001 = glcc005 OR glar001 = glcc006 OR glar001 = glcc017 OR glar001 = glcc018 OR glar001 = glcc019)
#
#   SELECT SUM((CASE WHEN xcce902 IS NULL THEN 0 ELSE xcce902 END)) INTO g_xckk2_d[5].xccc202
#     FROM xcce_t
#     WHERE xcceent = g_enterprise AND xcceld = g_master.xckkld AND xccecomp = g_master.xckkcomp
#       AND xcce001 = g_master.xckk001 AND xcce003 = g_master.xckk002 
#       AND xcce004 = g_master.xckk003 AND xcce005 = g_master.xckk004
#   IF cl_null(g_xckk2_d[5].glar005) THEN 
#      LET g_xckk2_d[5].glar005 = 0 
#   END IF
#   IF cl_null(g_xckk2_d[5].xccc202) THEN 
#      LET g_xckk2_d[5].xccc202 = 0 
#   END IF
#   #差异金额 
#   LET g_xckk2_d[5].xccc202a = g_xckk2_d[5].glar005 - g_xckk2_d[5].xccc202 
#   
#   #6 存貨期初餘額    1.取agli161的【存貨科目】glcc002所設定科目的集合。 2.SUM(取科目前一期餘額)    axcq004.【庫存期初】
#   SELECT SUM((CASE WHEN glar005 IS NULL THEN 0  ELSE glar005 END) - (CASE WHEN glar006 IS NULL THEN 0  ELSE glar006 END)) 
#     INTO g_xckk2_d[6].glar005 FROM glar_t , glcc_t
#     WHERE glarent = g_enterprise AND glarld = g_master.xckkld AND glarcomp = g_master.xckkcomp
#       AND glar002 = g_master.xckk003 AND glar003 < g_master.xckk004 
#       AND glarent = glccent AND glarld = glccld AND glcc001 = '1' #存货类科目设置
#       AND glar001 = glcc002  
#   
#   SELECT SUM((CASE WHEN xccc102 IS NULL THEN 0 ELSE xccc102 END)) INTO g_xckk2_d[6].xccc202
#     FROM xccc_t 
#     WHERE xcccent = g_enterprise AND xcccld = g_master.xckkld AND xccccomp = g_master.xckkcomp
#       AND xccc001 = g_master.xckk001 AND xccc003 = g_master.xckk002 
#       AND xccc004 = g_master.xckk003 AND xccc005 = g_master.xckk004
#   IF cl_null(g_xckk2_d[6].glar005) THEN 
#      LET g_xckk2_d[6].glar005 = 0 
#   END IF
#   IF cl_null(g_xckk2_d[6].xccc202) THEN 
#      LET g_xckk2_d[6].xccc202 = 0 
#   END IF
#   #差异金额 
#   LET g_xckk2_d[6].xccc202a = g_xckk2_d[6].glar005 - g_xckk2_d[6].xccc202       
#       
#   #7 存貨本期借方    1.取agli161的【存貨科目】glcc002所設定科目的集合。 2.SUM(取科目當期借方發生餘額) axcq530 庫存成本多筆查詢作業.【本期入庫金額】
#   SELECT SUM((CASE WHEN glar005 IS NULL THEN 0  ELSE glar005 END)) INTO g_xckk2_d[7].glar005 FROM glar_t , glcc_t
#     WHERE glarent = g_enterprise AND glarld = g_master.xckkld AND glarcomp = g_master.xckkcomp
#       AND glar002 = g_master.xckk003 AND glar003 = g_master.xckk004 
#       AND glarent = glccent AND glarld = glccld AND glcc001 = '1' #存货类科目设置
#       AND glar001 = glcc002      
#   SELECT SUM(xccc202+xccc204+xccc206+xccc208+xccc210+xccc212+xccc214+xccc216+xccc218) INTO g_xckk2_d[7].xccc202
#     FROM xccc_t 
#     WHERE xcccent = g_enterprise AND xcccld = g_master.xckkld AND xccccomp = g_master.xckkcomp
#       AND xccc001 = g_master.xckk001 AND xccc003 = g_master.xckk002 
#       AND xccc004 = g_master.xckk003 AND xccc005 = g_master.xckk004     
#   IF cl_null(g_xckk2_d[7].glar005) THEN 
#      LET g_xckk2_d[7].glar005 = 0 
#   END IF
#   IF cl_null(g_xckk2_d[7].xccc202) THEN 
#      LET g_xckk2_d[7].xccc202 = 0 
#   END IF
#   #差异金额 
#   LET g_xckk2_d[7].xccc202a = g_xckk2_d[7].glar005 - g_xckk2_d[7].xccc202     
#   
#   #8 存貨本期貸方    1.取agli161的【存貨科目】glcc002所設定科目的集合。 2.SUM(取科目當期貸方發生餘額) axcq530 庫存成本多筆查詢作業.【本期出庫金額】
#   SELECT SUM((CASE WHEN glar006 IS NULL THEN 0  ELSE glar006 END)) INTO g_xckk2_d[8].glar005 FROM glar_t , glcc_t
#     WHERE glarent = g_enterprise AND glarld = g_master.xckkld AND glarcomp = g_master.xckkcomp
#       AND glar002 = g_master.xckk003 AND glar003 = g_master.xckk004 
#       AND glarent = glccent AND glarld = glccld AND glcc001 = '1' #存货类科目设置
#       AND glar001 = glcc002      
#   SELECT SUM(xccc302+xccc304+xccc306+xccc308+xccc310+xccc312+xccc314) INTO g_xckk2_d[8].xccc202
#     FROM xccc_t 
#     WHERE xcccent = g_enterprise AND xcccld = g_master.xckkld AND xccccomp = g_master.xckkcomp
#       AND xccc001 = g_master.xckk001 AND xccc003 = g_master.xckk002 
#       AND xccc004 = g_master.xckk003 AND xccc005 = g_master.xckk004     
#   IF cl_null(g_xckk2_d[8].glar005) THEN 
#      LET g_xckk2_d[8].glar005 = 0 
#   END IF
#   IF cl_null(g_xckk2_d[8].xccc202) THEN 
#      LET g_xckk2_d[8].xccc202 = 0 
#   END IF
#   #差异金额 
#   LET g_xckk2_d[8].xccc202a = g_xckk2_d[8].glar005 - g_xckk2_d[8].xccc202
#   
#   #9 存貨期末餘額    1.取agli161的【存貨科目】glcc002所設定科目的集合。 2.SUM(取科目累餘額) axcq004.【庫存期末】 (xccc202)
#   SELECT SUM((CASE WHEN glar005 IS NULL THEN 0  ELSE glar005 END) - (CASE WHEN glar006 IS NULL THEN 0  ELSE glar006 END)) 
#     INTO g_xckk2_d[9].glar005 FROM glar_t , glcc_t
#     WHERE glarent = g_enterprise AND glarld = g_master.xckkld AND glarcomp = g_master.xckkcomp
#       AND glar002 = g_master.xckk003 AND glar003 = g_master.xckk004 
#       AND glarent = glccent AND glarld = glccld AND glcc001 = '1' #存货类科目设置
#       AND glar001 = glcc002      
#   SELECT SUM((CASE WHEN xccc902 IS NULL THEN 0  ELSE xccc902 END)) INTO g_xckk2_d[9].xccc202
#     FROM xccc_t 
#     WHERE xcccent = g_enterprise AND xcccld = g_master.xckkld AND xccccomp = g_master.xckkcomp
#       AND xccc001 = g_master.xckk001 AND xccc003 = g_master.xckk002 
#       AND xccc004 = g_master.xckk003 AND xccc005 = g_master.xckk004 
#   IF cl_null(g_xckk2_d[9].glar005) THEN 
#      LET g_xckk2_d[9].glar005 = 0 
#   END IF
#   IF cl_null(g_xckk2_d[9].xccc202) THEN 
#      LET g_xckk2_d[9].xccc202 = 0 
#   END IF
#   #差异金额 
#   LET g_xckk2_d[9].xccc202a = g_xckk2_d[9].glar005 - g_xckk2_d[9].xccc202
#   
   #170306-00041#1 marked-E   
   CALL axcq603_b_fill_xckl()  #161031-00037#1 add

   #170214-00031#1---s
   #Page2
#   LET li_ac = g_xckk2_d.getLength()    #170306-00041#1 marked
   #Page3
   LET li_ac = g_xckk3_d.getLength()
   #Page4
   LET li_ac = g_xckk4_d.getLength()
 
   DISPLAY li_ac TO FORMONLY.cnt
   LET g_detail_idx2 = 1
   DISPLAY g_detail_idx2 TO FORMONLY.idx

   #add-point:單身填充後 name="b_fill2.after_fill"
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL axcq603_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL axcq603_detail_action_trans()
   #end add-point
 
   LET l_ac = li_ac
   
   RETURN   
   #170214-00031#1---e
#pattern产生的段落有问题，先mark ,自行重新撰写
#因单身的foreach产生条件是错误关联，使用的变量其实是并不存在的，导致上传报错，先mark,关于ent的问题，gzcb_t本身就是没有ent的
#{          #170214-00031#1
   #end add-point
 
#table2
   #為避免影響執行效能，若是按上下筆就不重組SQL
   IF g_action_choice <> "fetch" OR cl_null(g_action_choice) THEN
      LET g_sql = "SELECT  UNIQUE '','','','','','','','','','','','','','','','','','','','','','', 
          '','','','','','','','','','','','','','','','','','','','','','','','','','','','','','', 
          '','','','','','','','','','','','','','','','','','','','','','','','','','','' FROM gzcb_t", 
 
                  "",
                  " WHERE"
  
      IF NOT cl_null(g_wc2_table2) THEN
         LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
      END IF
  
      LET g_sql = g_sql, " ORDER BY gzcb_t.gzcb001,gzcb_t.gzcb002"
  
      #add-point:單身填充前 name="b_fill2.before_fill2"
   END IF   #170214-00031#1
{          #170214-00031#1
      #end add-point
 
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
      PREPARE axcq603_pb2 FROM g_sql
      DECLARE b_fill_curs2 CURSOR FOR axcq603_pb2
   END IF
 
   #(ver:7) ---mark start---
#  OPEN b_fill_curs2 USING g_enterprise,g_xckk_d[g_detail_idx].xckkld
#                                 ,g_xckk_d[g_detail_idx].xckk001
 
#                                 ,g_xckk_d[g_detail_idx].xckk002
 
#                                 ,g_xckk_d[g_detail_idx].xckk003
 
#                                 ,g_xckk_d[g_detail_idx].xckk004
 
#                                 ,g_xckk_d[g_detail_idx].xckk005
 
 
   LET l_ac = 1
   FOREACH b_fill_curs2
      USING g_enterprise,g_xckk_d[g_detail_idx].xckkld
            ,g_xckk_d[g_detail_idx].xckk001
 
            ,g_xckk_d[g_detail_idx].xckk002
 
            ,g_xckk_d[g_detail_idx].xckk003
 
            ,g_xckk_d[g_detail_idx].xckk004
 
            ,g_xckk_d[g_detail_idx].xckk005
 
 
      INTO g_xckk3_d[l_ac].gzcb012,g_xckk3_d[l_ac].xckl005_desc,g_xckk3_d[l_ac].xckl007,g_xckk3_d[l_ac].xckl007_desc, 
          g_xckk3_d[l_ac].xckl007_desc_1,g_xckk3_d[l_ac].xckl008,g_xckk3_d[l_ac].xckl008_desc,g_xckk3_d[l_ac].xckl009, 
          g_xckk3_d[l_ac].xckl101,g_xckk3_d[l_ac].xckl102,g_xckk3_d[l_ac].xckl103,g_xckk3_d[l_ac].xckl104, 
          g_xckk3_d[l_ac].xckl105,g_xckk3_d[l_ac].xckl106,g_xckk3_d[l_ac].xckl102a,g_xckk3_d[l_ac].xckl104a, 
          g_xckk3_d[l_ac].xckl106a,g_xckk3_d[l_ac].xckl102b,g_xckk3_d[l_ac].xckl104b,g_xckk3_d[l_ac].xckl106b, 
          g_xckk3_d[l_ac].xckl102c,g_xckk3_d[l_ac].xckl104c,g_xckk3_d[l_ac].xckl106c,g_xckk3_d[l_ac].xckl102d, 
          g_xckk3_d[l_ac].xckl104d,g_xckk3_d[l_ac].xckl106d,g_xckk3_d[l_ac].xckl102e,g_xckk3_d[l_ac].xckl104e, 
          g_xckk3_d[l_ac].xckl106e,g_xckk3_d[l_ac].xckl102f,g_xckk3_d[l_ac].xckl104f,g_xckk3_d[l_ac].xckl106f, 
          g_xckk3_d[l_ac].xckl102g,g_xckk3_d[l_ac].xckl104g,g_xckk3_d[l_ac].xckl106g,g_xckk3_d[l_ac].xckl102h, 
          g_xckk3_d[l_ac].xckl104h,g_xckk3_d[l_ac].xckl106h,g_xckk3_d[l_ac].xckl005,g_xckk4_d[l_ac].gzcb012, 
          g_xckk4_d[l_ac].xckl005_1_desc,g_xckk4_d[l_ac].xckl006,g_xckk4_d[l_ac].xckl007,g_xckk4_d[l_ac].xckl007_1_desc, 
          g_xckk4_d[l_ac].xckl007_1_desc_1,g_xckk4_d[l_ac].xckl008,g_xckk4_d[l_ac].xckl008_1_desc,g_xckk4_d[l_ac].xckl009, 
          g_xckk4_d[l_ac].xckl101,g_xckk4_d[l_ac].xckl102,g_xckk4_d[l_ac].xckl103,g_xckk4_d[l_ac].xckl104, 
          g_xckk4_d[l_ac].xckl105,g_xckk4_d[l_ac].xckl106,g_xckk4_d[l_ac].xckl102a,g_xckk4_d[l_ac].xckl104a, 
          g_xckk4_d[l_ac].xckl106a,g_xckk4_d[l_ac].xckl102b,g_xckk4_d[l_ac].xckl104b,g_xckk4_d[l_ac].xckl106b, 
          g_xckk4_d[l_ac].xckl102c,g_xckk4_d[l_ac].xckl104c,g_xckk4_d[l_ac].xckl106c,g_xckk4_d[l_ac].xckl102d, 
          g_xckk4_d[l_ac].xckl104d,g_xckk4_d[l_ac].xckl106d,g_xckk4_d[l_ac].xckl102e,g_xckk4_d[l_ac].xckl104e, 
          g_xckk4_d[l_ac].xckl106e,g_xckk4_d[l_ac].xckl102f,g_xckk4_d[l_ac].xckl104f,g_xckk4_d[l_ac].xckl106f, 
          g_xckk4_d[l_ac].xckl102g,g_xckk4_d[l_ac].xckl104g,g_xckk4_d[l_ac].xckl106g,g_xckk4_d[l_ac].xckl102h, 
          g_xckk4_d[l_ac].xckl104h,g_xckk4_d[l_ac].xckl106h,g_xckk4_d[l_ac].xckl005
   #(ver:7) --- end ---
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
 
      
 
      #add-point:b_fill2段資料填充 name="b_fill2.fill2"
      
      #end add-point
 
      CALL axcq603_detail_show("'2'")
 
      CALL axcq603_gzcb_t_mask()
 
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend =  "" 
         LET g_errparam.code   =  9035 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
 
   END FOREACH
 
 
#Page2
   CALL g_xckk3_d.deleteElement(g_xckk3_d.getLength())
#Page3
   CALL g_xckk4_d.deleteElement(g_xckk4_d.getLength())
 
   #add-point:陣列長度調整 name="b_fill2.array_deleteElement"
}  #170214-00031#1    
   #end add-point
 
#Page2
   LET li_ac = g_xckk3_d.getLength()
#Page3
   LET li_ac = g_xckk4_d.getLength()
 
   DISPLAY li_ac TO FORMONLY.cnt
   LET g_detail_idx2 = 1
   DISPLAY g_detail_idx2 TO FORMONLY.idx
 
 
 
 
 
   #add-point:單身填充後 name="b_fill2.after_fill"
   #調整單身index指標，避免翻頁後指到空白筆數
   CALL axcq603_detail_index_setting()
 
   #重新計算單身筆數並呈現
   CALL axcq603_detail_action_trans()
   #end add-point
 
   LET l_ac = li_ac
 
END FUNCTION
 
{</section>}
 
{<section id="axcq603.detail_show" >}
#+ 顯示相關資料
PRIVATE FUNCTION axcq603_detail_show(ps_page)
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
      
 
      #add-point:show段單身reference name="detail_show.body.reference"
 
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'2'",1) > 0 THEN
      #帶出公用欄位reference值page2
      
 
      #add-point:show段單身reference name="detail_show.body3.reference"
      
      #end add-point
   END IF
 
   IF ps_page.getIndexOf("'3'",1) > 0 THEN
      #帶出公用欄位reference值page3
      
 
      #add-point:show段單身reference name="detail_show.body4.reference"
      
      #end add-point
   END IF
 
 
 
   #add-point:detail_show段之後 name="detail_show.after"
   
   #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axcq603.filter" >}
#應用 qs13 樣板自動產生(Version:8)
#+ filter段相關程式段
#+ filter過濾功能
PRIVATE FUNCTION axcq603_filter()
   #add-point:filter段define-客製 name="filter.define_customerization"
   
   #end add-point
   DEFINE  ls_result   STRING
   #add-point:filter段define-標準  (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="filter.define"
   
   #end add-point
 
   #add-point:FUNCTION前置處理 name="filter.before_function"
   
   #end add-point
 
   LET INT_FLAG = 0
 
   LET g_qryparam.state = 'c'
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
 
   LET g_wc_filter_t = g_wc_filter
   LET g_wc_t = g_wc
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", TRUE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", TRUE)
 
   
 
   LET g_wc = cl_replace_str(g_wc, g_wc_filter, '')
 
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   #應用 qs08 樣板自動產生(Version:5)
   #+ filter段DIALOG段的組成
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
      #單頭
      CONSTRUCT g_wc_filter ON xckk101,xckk102,xckk103,xckk104,xckk105,xckk106,xckk090,xckk102a,xckk104a, 
          xckk106a,xckk102b,xckk104b,xckk106b,xckk102c,xckk104c,xckk106c,xckk102d,xckk104d,xckk106d, 
          xckk102e,xckk104e,xckk106e,xckk102f,xckk104f,xckk106f,xckk102g,xckk104g,xckk106g,xckk102h, 
          xckk104h,xckk106h,xckk005
                          FROM s_detail1[1].b_xckk101,s_detail1[1].b_xckk102,s_detail1[1].b_xckk103, 
                              s_detail1[1].b_xckk104,s_detail1[1].b_xckk105,s_detail1[1].b_xckk106,s_detail1[1].b_xckk090, 
                              s_detail1[1].b_xckk102a,s_detail1[1].b_xckk104a,s_detail1[1].b_xckk106a, 
                              s_detail1[1].b_xckk102b,s_detail1[1].b_xckk104b,s_detail1[1].b_xckk106b, 
                              s_detail1[1].b_xckk102c,s_detail1[1].b_xckk104c,s_detail1[1].b_xckk106c, 
                              s_detail1[1].b_xckk102d,s_detail1[1].b_xckk104d,s_detail1[1].b_xckk106d, 
                              s_detail1[1].b_xckk102e,s_detail1[1].b_xckk104e,s_detail1[1].b_xckk106e, 
                              s_detail1[1].b_xckk102f,s_detail1[1].b_xckk104f,s_detail1[1].b_xckk106f, 
                              s_detail1[1].b_xckk102g,s_detail1[1].b_xckk104g,s_detail1[1].b_xckk106g, 
                              s_detail1[1].b_xckk102h,s_detail1[1].b_xckk104h,s_detail1[1].b_xckk106h, 
                              s_detail1[1].b_xckk005
 
         BEFORE CONSTRUCT
                     DISPLAY axcq603_filter_parser('xckk101') TO s_detail1[1].b_xckk101
            DISPLAY axcq603_filter_parser('xckk102') TO s_detail1[1].b_xckk102
            DISPLAY axcq603_filter_parser('xckk103') TO s_detail1[1].b_xckk103
            DISPLAY axcq603_filter_parser('xckk104') TO s_detail1[1].b_xckk104
            DISPLAY axcq603_filter_parser('xckk105') TO s_detail1[1].b_xckk105
            DISPLAY axcq603_filter_parser('xckk106') TO s_detail1[1].b_xckk106
            DISPLAY axcq603_filter_parser('xckk090') TO s_detail1[1].b_xckk090
            DISPLAY axcq603_filter_parser('xckk102a') TO s_detail1[1].b_xckk102a
            DISPLAY axcq603_filter_parser('xckk104a') TO s_detail1[1].b_xckk104a
            DISPLAY axcq603_filter_parser('xckk106a') TO s_detail1[1].b_xckk106a
            DISPLAY axcq603_filter_parser('xckk102b') TO s_detail1[1].b_xckk102b
            DISPLAY axcq603_filter_parser('xckk104b') TO s_detail1[1].b_xckk104b
            DISPLAY axcq603_filter_parser('xckk106b') TO s_detail1[1].b_xckk106b
            DISPLAY axcq603_filter_parser('xckk102c') TO s_detail1[1].b_xckk102c
            DISPLAY axcq603_filter_parser('xckk104c') TO s_detail1[1].b_xckk104c
            DISPLAY axcq603_filter_parser('xckk106c') TO s_detail1[1].b_xckk106c
            DISPLAY axcq603_filter_parser('xckk102d') TO s_detail1[1].b_xckk102d
            DISPLAY axcq603_filter_parser('xckk104d') TO s_detail1[1].b_xckk104d
            DISPLAY axcq603_filter_parser('xckk106d') TO s_detail1[1].b_xckk106d
            DISPLAY axcq603_filter_parser('xckk102e') TO s_detail1[1].b_xckk102e
            DISPLAY axcq603_filter_parser('xckk104e') TO s_detail1[1].b_xckk104e
            DISPLAY axcq603_filter_parser('xckk106e') TO s_detail1[1].b_xckk106e
            DISPLAY axcq603_filter_parser('xckk102f') TO s_detail1[1].b_xckk102f
            DISPLAY axcq603_filter_parser('xckk104f') TO s_detail1[1].b_xckk104f
            DISPLAY axcq603_filter_parser('xckk106f') TO s_detail1[1].b_xckk106f
            DISPLAY axcq603_filter_parser('xckk102g') TO s_detail1[1].b_xckk102g
            DISPLAY axcq603_filter_parser('xckk104g') TO s_detail1[1].b_xckk104g
            DISPLAY axcq603_filter_parser('xckk106g') TO s_detail1[1].b_xckk106g
            DISPLAY axcq603_filter_parser('xckk102h') TO s_detail1[1].b_xckk102h
            DISPLAY axcq603_filter_parser('xckk104h') TO s_detail1[1].b_xckk104h
            DISPLAY axcq603_filter_parser('xckk106h') TO s_detail1[1].b_xckk106h
            DISPLAY axcq603_filter_parser('xckk005') TO s_detail1[1].b_xckk005
 
 
         #單身公用欄位開窗相關處理
         
 
         #單身一般欄位開窗相關處理
                  #----<<sel>>----
         #----<<b_gzcb012>>----
         #----<<b_xckk005_desc>>----
         #----<<b_xckk101>>----
         #Ctrlp:construct.c.filter.page1.b_xckk101
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xckk101
            #add-point:ON ACTION controlp INFIELD b_xckk101 name="construct.c.filter.page1.b_xckk101"
            
            #END add-point
 
 
         #----<<b_xckk102>>----
         #Ctrlp:construct.c.filter.page1.b_xckk102
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xckk102
            #add-point:ON ACTION controlp INFIELD b_xckk102 name="construct.c.filter.page1.b_xckk102"
            
            #END add-point
 
 
         #----<<b_xckk103>>----
         #Ctrlp:construct.c.filter.page1.b_xckk103
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xckk103
            #add-point:ON ACTION controlp INFIELD b_xckk103 name="construct.c.filter.page1.b_xckk103"
            
            #END add-point
 
 
         #----<<b_xckk104>>----
         #Ctrlp:construct.c.filter.page1.b_xckk104
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xckk104
            #add-point:ON ACTION controlp INFIELD b_xckk104 name="construct.c.filter.page1.b_xckk104"
            
            #END add-point
 
 
         #----<<b_xckk105>>----
         #Ctrlp:construct.c.filter.page1.b_xckk105
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xckk105
            #add-point:ON ACTION controlp INFIELD b_xckk105 name="construct.c.filter.page1.b_xckk105"
            
            #END add-point
 
 
         #----<<b_xckk106>>----
         #Ctrlp:construct.c.filter.page1.b_xckk106
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xckk106
            #add-point:ON ACTION controlp INFIELD b_xckk106 name="construct.c.filter.page1.b_xckk106"
            
            #END add-point
 
 
         #----<<b_xckk090>>----
         #Ctrlp:construct.c.filter.page1.b_xckk090
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xckk090
            #add-point:ON ACTION controlp INFIELD b_xckk090 name="construct.c.filter.page1.b_xckk090"
            
            #END add-point
 
 
         #----<<b_xckk102a>>----
         #Ctrlp:construct.c.filter.page1.b_xckk102a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xckk102a
            #add-point:ON ACTION controlp INFIELD b_xckk102a name="construct.c.filter.page1.b_xckk102a"
            
            #END add-point
 
 
         #----<<b_xckk104a>>----
         #Ctrlp:construct.c.filter.page1.b_xckk104a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xckk104a
            #add-point:ON ACTION controlp INFIELD b_xckk104a name="construct.c.filter.page1.b_xckk104a"
            
            #END add-point
 
 
         #----<<b_xckk106a>>----
         #Ctrlp:construct.c.filter.page1.b_xckk106a
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xckk106a
            #add-point:ON ACTION controlp INFIELD b_xckk106a name="construct.c.filter.page1.b_xckk106a"
            
            #END add-point
 
 
         #----<<b_xckk102b>>----
         #Ctrlp:construct.c.filter.page1.b_xckk102b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xckk102b
            #add-point:ON ACTION controlp INFIELD b_xckk102b name="construct.c.filter.page1.b_xckk102b"
            
            #END add-point
 
 
         #----<<b_xckk104b>>----
         #Ctrlp:construct.c.filter.page1.b_xckk104b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xckk104b
            #add-point:ON ACTION controlp INFIELD b_xckk104b name="construct.c.filter.page1.b_xckk104b"
            
            #END add-point
 
 
         #----<<b_xckk106b>>----
         #Ctrlp:construct.c.filter.page1.b_xckk106b
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xckk106b
            #add-point:ON ACTION controlp INFIELD b_xckk106b name="construct.c.filter.page1.b_xckk106b"
            
            #END add-point
 
 
         #----<<b_xckk102c>>----
         #Ctrlp:construct.c.filter.page1.b_xckk102c
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xckk102c
            #add-point:ON ACTION controlp INFIELD b_xckk102c name="construct.c.filter.page1.b_xckk102c"
            
            #END add-point
 
 
         #----<<b_xckk104c>>----
         #Ctrlp:construct.c.filter.page1.b_xckk104c
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xckk104c
            #add-point:ON ACTION controlp INFIELD b_xckk104c name="construct.c.filter.page1.b_xckk104c"
            
            #END add-point
 
 
         #----<<b_xckk106c>>----
         #Ctrlp:construct.c.filter.page1.b_xckk106c
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xckk106c
            #add-point:ON ACTION controlp INFIELD b_xckk106c name="construct.c.filter.page1.b_xckk106c"
            
            #END add-point
 
 
         #----<<b_xckk102d>>----
         #Ctrlp:construct.c.filter.page1.b_xckk102d
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xckk102d
            #add-point:ON ACTION controlp INFIELD b_xckk102d name="construct.c.filter.page1.b_xckk102d"
            
            #END add-point
 
 
         #----<<b_xckk104d>>----
         #Ctrlp:construct.c.filter.page1.b_xckk104d
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xckk104d
            #add-point:ON ACTION controlp INFIELD b_xckk104d name="construct.c.filter.page1.b_xckk104d"
            
            #END add-point
 
 
         #----<<b_xckk106d>>----
         #Ctrlp:construct.c.filter.page1.b_xckk106d
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xckk106d
            #add-point:ON ACTION controlp INFIELD b_xckk106d name="construct.c.filter.page1.b_xckk106d"
            
            #END add-point
 
 
         #----<<b_xckk102e>>----
         #Ctrlp:construct.c.filter.page1.b_xckk102e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xckk102e
            #add-point:ON ACTION controlp INFIELD b_xckk102e name="construct.c.filter.page1.b_xckk102e"
            
            #END add-point
 
 
         #----<<b_xckk104e>>----
         #Ctrlp:construct.c.filter.page1.b_xckk104e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xckk104e
            #add-point:ON ACTION controlp INFIELD b_xckk104e name="construct.c.filter.page1.b_xckk104e"
            
            #END add-point
 
 
         #----<<b_xckk106e>>----
         #Ctrlp:construct.c.filter.page1.b_xckk106e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xckk106e
            #add-point:ON ACTION controlp INFIELD b_xckk106e name="construct.c.filter.page1.b_xckk106e"
            
            #END add-point
 
 
         #----<<b_xckk102f>>----
         #Ctrlp:construct.c.filter.page1.b_xckk102f
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xckk102f
            #add-point:ON ACTION controlp INFIELD b_xckk102f name="construct.c.filter.page1.b_xckk102f"
            
            #END add-point
 
 
         #----<<b_xckk104f>>----
         #Ctrlp:construct.c.filter.page1.b_xckk104f
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xckk104f
            #add-point:ON ACTION controlp INFIELD b_xckk104f name="construct.c.filter.page1.b_xckk104f"
            
            #END add-point
 
 
         #----<<b_xckk106f>>----
         #Ctrlp:construct.c.filter.page1.b_xckk106f
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xckk106f
            #add-point:ON ACTION controlp INFIELD b_xckk106f name="construct.c.filter.page1.b_xckk106f"
            
            #END add-point
 
 
         #----<<b_xckk102g>>----
         #Ctrlp:construct.c.filter.page1.b_xckk102g
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xckk102g
            #add-point:ON ACTION controlp INFIELD b_xckk102g name="construct.c.filter.page1.b_xckk102g"
            
            #END add-point
 
 
         #----<<b_xckk104g>>----
         #Ctrlp:construct.c.filter.page1.b_xckk104g
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xckk104g
            #add-point:ON ACTION controlp INFIELD b_xckk104g name="construct.c.filter.page1.b_xckk104g"
            
            #END add-point
 
 
         #----<<b_xckk106g>>----
         #Ctrlp:construct.c.filter.page1.b_xckk106g
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xckk106g
            #add-point:ON ACTION controlp INFIELD b_xckk106g name="construct.c.filter.page1.b_xckk106g"
            
            #END add-point
 
 
         #----<<b_xckk102h>>----
         #Ctrlp:construct.c.filter.page1.b_xckk102h
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xckk102h
            #add-point:ON ACTION controlp INFIELD b_xckk102h name="construct.c.filter.page1.b_xckk102h"
            
            #END add-point
 
 
         #----<<b_xckk104h>>----
         #Ctrlp:construct.c.filter.page1.b_xckk104h
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xckk104h
            #add-point:ON ACTION controlp INFIELD b_xckk104h name="construct.c.filter.page1.b_xckk104h"
            
            #END add-point
 
 
         #----<<b_xckk106h>>----
         #Ctrlp:construct.c.filter.page1.b_xckk106h
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xckk106h
            #add-point:ON ACTION controlp INFIELD b_xckk106h name="construct.c.filter.page1.b_xckk106h"
            
            #END add-point
 
 
         #----<<b_xckk005>>----
         #Ctrlp:construct.c.filter.page1.b_xckk005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD b_xckk005
            #add-point:ON ACTION controlp INFIELD b_xckk005 name="construct.c.filter.page1.b_xckk005"
            
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
 
 
 
 
 
   
 
   #add-point:離開DIALOG後相關處理 name="filter.after_dialog"
   
   #end add-point
 
   IF NOT INT_FLAG THEN
      LET g_wc_filter = g_wc_filter, " "
   ELSE
      LET g_wc_filter = g_wc_filter_t
   END IF
 
      CALL axcq603_filter_show('xckk101','b_xckk101')
   CALL axcq603_filter_show('xckk102','b_xckk102')
   CALL axcq603_filter_show('xckk103','b_xckk103')
   CALL axcq603_filter_show('xckk104','b_xckk104')
   CALL axcq603_filter_show('xckk105','b_xckk105')
   CALL axcq603_filter_show('xckk106','b_xckk106')
   CALL axcq603_filter_show('xckk090','b_xckk090')
   CALL axcq603_filter_show('xckk102a','b_xckk102a')
   CALL axcq603_filter_show('xckk104a','b_xckk104a')
   CALL axcq603_filter_show('xckk106a','b_xckk106a')
   CALL axcq603_filter_show('xckk102b','b_xckk102b')
   CALL axcq603_filter_show('xckk104b','b_xckk104b')
   CALL axcq603_filter_show('xckk106b','b_xckk106b')
   CALL axcq603_filter_show('xckk102c','b_xckk102c')
   CALL axcq603_filter_show('xckk104c','b_xckk104c')
   CALL axcq603_filter_show('xckk106c','b_xckk106c')
   CALL axcq603_filter_show('xckk102d','b_xckk102d')
   CALL axcq603_filter_show('xckk104d','b_xckk104d')
   CALL axcq603_filter_show('xckk106d','b_xckk106d')
   CALL axcq603_filter_show('xckk102e','b_xckk102e')
   CALL axcq603_filter_show('xckk104e','b_xckk104e')
   CALL axcq603_filter_show('xckk106e','b_xckk106e')
   CALL axcq603_filter_show('xckk102f','b_xckk102f')
   CALL axcq603_filter_show('xckk104f','b_xckk104f')
   CALL axcq603_filter_show('xckk106f','b_xckk106f')
   CALL axcq603_filter_show('xckk102g','b_xckk102g')
   CALL axcq603_filter_show('xckk104g','b_xckk104g')
   CALL axcq603_filter_show('xckk106g','b_xckk106g')
   CALL axcq603_filter_show('xckk102h','b_xckk102h')
   CALL axcq603_filter_show('xckk104h','b_xckk104h')
   CALL axcq603_filter_show('xckk106h','b_xckk106h')
   CALL axcq603_filter_show('xckk005','b_xckk005')
 
 
   CALL axcq603_b_fill()
 
   CALL gfrm_curr.setFieldHidden("formonly.sel", FALSE)
   CALL gfrm_curr.setFieldHidden("formonly.b_statepic", FALSE)
 
END FUNCTION
 
{</section>}
 
{<section id="axcq603.filter_parser" >}
#應用 qs14 樣板自動產生(Version:6)
#+ filter pasara段
#+ filter欄位解析
PRIVATE FUNCTION axcq603_filter_parser(ps_field)
   #add-point:filter段define-客製 name="filter_parser.define_customerization"
   
   #end add-point
   {<Local define>}
   DEFINE ps_field   STRING
   DEFINE ls_tmp     STRING
   DEFINE li_tmp     LIKE type_t.num5
   DEFINE li_tmp2    LIKE type_t.num5
   DEFINE ls_var     STRING
   {</Local define>}
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
 
{<section id="axcq603.filter_show" >}
#應用 qs15 樣板自動產生(Version:6)
#+ filter標題欄位顯示搜尋條件
PRIVATE FUNCTION axcq603_filter_show(ps_field,ps_object)
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
      LET ls_title = ls_title.subString(1,ls_title.getIndexOf('※',1)-1)
   END IF
 
   #顯示資料組合
   LET ls_condition = axcq603_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
 
{</section>}
 
{<section id="axcq603.detail_action_trans" >}
#+ 單身分頁筆數顯示及action圖片顯示切換功能
PRIVATE FUNCTION axcq603_detail_action_trans()
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
 
{<section id="axcq603.detail_index_setting" >}
#+ 單身切頁後，index重新調整，避免翻頁後指到空白筆數
PRIVATE FUNCTION axcq603_detail_index_setting()
   #add-point:detail_index_setting段define-客製 name="detail_index_setting.define_customerization"
   
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
            IF g_xckk_d.getLength() > 0 THEN
               LET li_redirect = TRUE
            END IF
         WHEN g_curr_diag.getCurrentRow("s_detail1") > g_xckk_d.getLength() AND g_xckk_d.getLength() > 0
            LET g_detail_idx = g_xckk_d.getLength()
            LET li_redirect = TRUE
         WHEN g_curr_diag.getCurrentRow("s_detail1") != g_detail_idx
            IF g_detail_idx > g_xckk_d.getLength() THEN
               LET g_detail_idx = g_xckk_d.getLength()
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
 
{<section id="axcq603.mask_functions" >}
 &include "erp/axc/axcq603_mask.4gl"
 
{</section>}
 
{<section id="axcq603.other_function" readonly="Y" >}

#帶出成本計算類型的說明
PRIVATE FUNCTION axcq603_xckk002_desc(p_xckk002)
DEFINE p_xckk002   LIKE xckk_t.xckk002
DEFINE r_xcatl003  LIKE xcatl_t.xcatl003

     INITIALIZE g_ref_fields TO NULL
     LET g_ref_fields[1] = p_xckk002
     CALL ap_ref_array2(g_ref_fields,"SELECT xcatl003 FROM xcatl_t WHERE xcatlent='"||g_enterprise||"' AND xcatl001=? AND xcatl002='"||g_dlang||"'","") RETURNING g_rtn_fields
     LET r_xcatl003 = '', g_rtn_fields[1] , ''
     RETURN r_xcatl003
     
END FUNCTION

################################################################################
# Descriptions...: 1.自动进行库存成本数据和明细数据的钩稽核对，并把核对数据更新到xckk_t中。
#                  2.自动进行在制成本数据和明细数据的钩稽核对，并把核对数据更新到xckk_t中。
#                  3.自动把"1"和"2"的核对差异数据的明细差异更新到xckl_t中。
# Memo...........:
# Usage..........: CALL axcq603_gen_xckk() (传入参数)
#                  RETURNING r_success
# Input parameter: 
#                : 
# Return code....: r_success    TRUE/FALSE
# Date & Author..: 2016/03/28 By lixiang
# Modify.........:
################################################################################
PRIVATE FUNCTION axcq603_gen_xckk()
DEFINE r_success       LIKE type_t.num5
#161109-00085#26-s mod
#DEFINE l_xckk          RECORD LIKE xckk_t.*   #161109-00085#26-s mark
DEFINE l_xckk          RECORD  #成本勾稽表
       xckkent LIKE xckk_t.xckkent, #企業編號
       xckkcomp LIKE xckk_t.xckkcomp, #法人組織
       xckkld LIKE xckk_t.xckkld, #帳套
       xckk001 LIKE xckk_t.xckk001, #本位幣順序
       xckk002 LIKE xckk_t.xckk002, #成本計算類型
       xckk003 LIKE xckk_t.xckk003, #年度
       xckk004 LIKE xckk_t.xckk004, #期別
       xckk005 LIKE xckk_t.xckk005, #
       xckk090 LIKE xckk_t.xckk090, #明細程式編號
       xckk101 LIKE xckk_t.xckk101, #總報表數量
       xckk102 LIKE xckk_t.xckk102, #總報表金額
       xckk102a LIKE xckk_t.xckk102a, #材料
       xckk102b LIKE xckk_t.xckk102b, #人工
       xckk102c LIKE xckk_t.xckk102c, #加工
       xckk102d LIKE xckk_t.xckk102d, #制費一
       xckk102e LIKE xckk_t.xckk102e, #制費二
       xckk102f LIKE xckk_t.xckk102f, #制費三
       xckk102g LIKE xckk_t.xckk102g, #製費四
       xckk102h LIKE xckk_t.xckk102h, #制費五
       xckk103 LIKE xckk_t.xckk103, #分報表數量
       xckk104 LIKE xckk_t.xckk104, #分報表金額
       xckk104a LIKE xckk_t.xckk104a, #分報表材料
       xckk104b LIKE xckk_t.xckk104b, #分報表人工
       xckk104c LIKE xckk_t.xckk104c, #分報表加工
       xckk104d LIKE xckk_t.xckk104d, #分報表制費一
       xckk104e LIKE xckk_t.xckk104e, #分報表制費二
       xckk104f LIKE xckk_t.xckk104f, #分報表制費三
       xckk104g LIKE xckk_t.xckk104g, #分報表制費四
       xckk104h LIKE xckk_t.xckk104h, #分報表制費五
       xckk105 LIKE xckk_t.xckk105, #差異數量
       xckk106 LIKE xckk_t.xckk106, #差異金額
       xckk106a LIKE xckk_t.xckk106a, #差異金額-材料
       xckk106b LIKE xckk_t.xckk106b, #差異金額-人工
       xckk106c LIKE xckk_t.xckk106c, #差異金額-加工
       xckk106d LIKE xckk_t.xckk106d, #差異金額-制費一
       xckk106e LIKE xckk_t.xckk106e, #差異金額-制費二
       xckk106f LIKE xckk_t.xckk106f, #差異金額-制費三
       xckk106g LIKE xckk_t.xckk106g, #差異金額-制費四
       xckk106h LIKE xckk_t.xckk106h  #差異金額-制費五
                END RECORD
#161109-00085#26-e mod
DEFINE l_sql           STRING
DEFINE l_xcck055       LIKE type_t.chr80
DEFINE l_xcck020       LIKE type_t.chr80
DEFINE l_xckk103       LIKE xckk_t.xckk103
DEFINE l_xckk104       LIKE xckk_t.xckk104
DEFINE l_xckk104a      LIKE xckk_t.xckk104a
DEFINE l_xckk104b      LIKE xckk_t.xckk104b
DEFINE l_xckk104c      LIKE xckk_t.xckk104c
DEFINE l_xckk104d      LIKE xckk_t.xckk104d
DEFINE l_xckk104e      LIKE xckk_t.xckk104e
DEFINE l_xckk104f      LIKE xckk_t.xckk104f
DEFINE l_xckk104g      LIKE xckk_t.xckk104g
DEFINE l_xckk104h      LIKE xckk_t.xckk104h
DEFINE l_sql1          STRING
DEFINE l_sql2          STRING
DEFINE l_xcbk005       LIKE xcbk_t.xcbk005
DEFINE l_success       LIKE type_t.num5      #161031-00037#1

   LET  r_success = TRUE
   
   CALL s_transaction_begin()
   
   #先将原先资料删除
   DELETE FROM xckk_t WHERE xckkent = g_enterprise AND xckkld = g_master.xckkld AND xckkcomp = g_master.xckkcomp
                        AND xckk001 = g_master.xckk001 AND xckk002 = g_master.xckk002 
                        AND xckk003 = g_master.xckk003 AND xckk004 = g_master.xckk004
                        
   DELETE FROM xckl_t WHERE xcklent = g_enterprise AND xcklld = g_master.xckkld AND xcklcomp = g_master.xckkcomp
                        AND xckl001 = g_master.xckk001 AND xckl002 = g_master.xckk002 
                        AND xckl003 = g_master.xckk003 AND xckl004 = g_master.xckk004
                        
   LET g_source = ''  
   
   #計算當前期別的上一期別
   IF g_master.xckk004 = 1 THEN
      LET g_previous_xckk003 = g_master.xckk003 - 1
      LET g_previous_xckk004 = 12
   ELSE
      LET g_previous_xckk003 = g_master.xckk003
      LET g_previous_xckk004 = g_master.xckk004 - 1
   END IF
   
   #161031-00037#1--s
   SELECT glaa003 INTO g_glaa003 FROM glaa_t
       WHERE glaaent = g_enterprise AND glaa014 = 'Y'
         AND glaacomp = g_master.xckkcomp                
   CALL s_fin_date_get_period_range(g_glaa003, g_master.xckk003,g_master.xckk004)
       RETURNING g_bdate,g_edate  

   #按单头账套+本位币顺序抓币种
   CASE g_master.xckk001 
     WHEN '1'   #glaa001
       CALL s_ld_sel_glaa(g_master.xckkld,'glaa001') RETURNING l_success,g_curr
     WHEN '2'   #glaa016
       CALL s_ld_sel_glaa(g_master.xckkld,'glaa016') RETURNING l_success,g_curr
     WHEN '3'   #glaa020
       CALL s_ld_sel_glaa(g_master.xckkld,'glaa020') RETURNING l_success,g_curr
   END CASE
   
   #取成本计算方式
   SELECT xcat005 INTO g_cost_type FROM xcat_t 
      WHERE xcatent = g_enterprise AND xcat001 = g_master.xckk002 
   #161031-00037#1--e
   
   ##因为单身类型是固定的(根据scc 8922的选项加载，除去小计、合计的选项)，所以根据不同的类型填充单身资料，需要指定填充到哪一行
   #
   ##对所有第一列“核对项目”赋值，确切文字内容见scc-8922，注释仅为参考文字，描述不一定完全一致
   #总表抓xccc的本期期初数量和金额，明细表抓上期的xcca的数量和金额，并写入xckk；有差异的按料号+特性+批号+成本域找出差异并写入xckl
   INITIALIZE l_xckk.* TO NULL
   LET l_xckk.xckk005 = '103'          #库存开账调整
   #160707-00034#1---s
   ##总表抓xccc的本期期初数量和金额
   #SELECT SUM((CASE WHEN xccc101 IS NULL THEN 0 ELSE xccc101 END)),  SUM((CASE WHEN xccc102 IS NULL THEN 0 ELSE xccc102 END)), 
   #       SUM((CASE WHEN xccc102a IS NULL THEN 0 ELSE xccc102a END)),SUM((CASE WHEN xccc102b IS NULL THEN 0 ELSE xccc102b END)),
   #       SUM((CASE WHEN xccc102c IS NULL THEN 0 ELSE xccc102c END)),SUM((CASE WHEN xccc102d IS NULL THEN 0 ELSE xccc102d END)),
   #       SUM((CASE WHEN xccc102e IS NULL THEN 0 ELSE xccc102e END)),SUM((CASE WHEN xccc102f IS NULL THEN 0 ELSE xccc102f END)),
   #       SUM((CASE WHEN xccc102g IS NULL THEN 0 ELSE xccc102g END)),SUM((CASE WHEN xccc102h IS NULL THEN 0 ELSE xccc102h END))
   #   INTO l_xckk.xckk101, l_xckk.xckk102, l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,
   #        l_xckk.xckk102d,l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h
   #FROM xccc_t 
   #WHERE xcccent = g_enterprise AND xcccld = g_master.xckkld AND xccccomp = g_master.xckkcomp
   #  AND xccc001 = g_master.xckk001 AND xccc003 = g_master.xckk002 
   #  AND xccc004 = g_master.xckk003 AND xccc005 = g_master.xckk004
   #总表抓xccj
   SELECT SUM(xccj101*xccj009),SUM(xccj102*xccj009),SUM(xccj102a*xccj009),SUM(xccj102b*xccj009),SUM(xccj102c*xccj009),
          SUM(xccj102d*xccj009),SUM(xccj102e*xccj009),SUM(xccj102f*xccj009),SUM(xccj102g*xccj009),SUM(xccj102h*xccj009)
       INTO l_xckk.xckk101, l_xckk.xckk102, l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,
            l_xckk.xckk102d,l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h  
    FROM xccj_t 
   WHERE xccjent  = g_enterprise
     AND xccjcomp = g_master.xckkcomp    #法人
     AND xccjld   = g_master.xckkld      #账套
     AND xccj001  = g_master.xckk001     #本位币顺序
     AND xccj003  = g_master.xckk002     #成本计算类型
     AND xccj004  = g_master.xckk003     #年度  
     AND xccj005  = g_master.xckk004
   #160707-00034#1----e
   
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xccc_t:1"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
         
   #明细表抓上期的xcca的数量和金额
   IF g_cost_type = '2' THEN  #170210-00001#1 add
      SELECT SUM((CASE WHEN xcca101 IS NULL THEN 0 ELSE xcca101 END)),  SUM((CASE WHEN xcca102 IS NULL THEN 0 ELSE xcca102 END)), 
             SUM((CASE WHEN xcca102a IS NULL THEN 0 ELSE xcca102a END)),SUM((CASE WHEN xcca102b IS NULL THEN 0 ELSE xcca102b END)),
             SUM((CASE WHEN xcca102c IS NULL THEN 0 ELSE xcca102c END)),SUM((CASE WHEN xcca102d IS NULL THEN 0 ELSE xcca102d END)),
             SUM((CASE WHEN xcca102e IS NULL THEN 0 ELSE xcca102e END)),SUM((CASE WHEN xcca102f IS NULL THEN 0 ELSE xcca102f END)),
             SUM((CASE WHEN xcca102g IS NULL THEN 0 ELSE xcca102g END)),SUM((CASE WHEN xcca102h IS NULL THEN 0 ELSE xcca102h END))
         INTO l_xckk.xckk103, l_xckk.xckk104, l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,
              l_xckk.xckk104d,l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h
      FROM xcca_t 
      WHERE xccaent = g_enterprise AND xccald = g_master.xckkld AND xccacomp = g_master.xckkcomp
        AND xcca001 = g_master.xckk001 AND xcca003 = g_master.xckk002 
        AND xcca004 = g_previous_xckk003 AND xcca005 = g_previous_xckk004
      IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xcca_t:1"
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
   #170210-00001#1--add--start--
   #判斷非先進先出成本，明細就直接給0
   ELSE
      LET l_xckk.xckk103  = 0
      LET l_xckk.xckk104  = 0 
      LET l_xckk.xckk104a = 0
      LET l_xckk.xckk104b = 0
      LET l_xckk.xckk104c = 0
      LET l_xckk.xckk104d = 0
      LET l_xckk.xckk104e = 0
      LET l_xckk.xckk104f = 0
      LET l_xckk.xckk104g = 0
      LET l_xckk.xckk104h = 0
   END IF
   #170210-00001#1--add--end----
   LET g_source = 'xcca'      #標記明細表的來源
   
   #161109-00085#26-s mod
#   IF NOT axcq603_ins_xckk(l_xckk.*) THEN   #161109-00085#26-s mark
   IF NOT axcq603_ins_xckk(l_xckk.xckkent,l_xckk.xckkcomp,l_xckk.xckkld,l_xckk.xckk001,l_xckk.xckk002,
                           l_xckk.xckk003,l_xckk.xckk004,l_xckk.xckk005,l_xckk.xckk090,l_xckk.xckk101,
                           l_xckk.xckk102,l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,l_xckk.xckk102d,
                           l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h,l_xckk.xckk103,
                           l_xckk.xckk104,l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,l_xckk.xckk104d,
                           l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h,l_xckk.xckk105,
                           l_xckk.xckk106,l_xckk.xckk106a,l_xckk.xckk106b,l_xckk.xckk106c,l_xckk.xckk106d,
                           l_xckk.xckk106e,l_xckk.xckk106f,l_xckk.xckk106g,l_xckk.xckk106h) THEN
   #161109-00085#26-e mod
      LET r_success = FALSE
      RETURN r_success
   END IF
   LET g_source = ''
   
   #总表抓xccc的本期期初数量和金额，明细表抓xccc的上期期末数量和金额，抓不到抓上期的xcca的数据和金额，并写入xckk；有差异的按料号+特性+批号+成本域找出差异并写入xckl
   INITIALIZE l_xckk.* TO NULL
   LET l_xckk.xckk005 = '101'          #库存期初
   #总表抓xccc的本期期初数量和金额
   SELECT SUM((CASE WHEN xccc101 IS NULL THEN 0 ELSE xccc101 END)),  SUM((CASE WHEN xccc102 IS NULL THEN 0 ELSE xccc102 END)), 
          SUM((CASE WHEN xccc102a IS NULL THEN 0 ELSE xccc102a END)),SUM((CASE WHEN xccc102b IS NULL THEN 0 ELSE xccc102b END)),
          SUM((CASE WHEN xccc102c IS NULL THEN 0 ELSE xccc102c END)),SUM((CASE WHEN xccc102d IS NULL THEN 0 ELSE xccc102d END)),
          SUM((CASE WHEN xccc102e IS NULL THEN 0 ELSE xccc102e END)),SUM((CASE WHEN xccc102f IS NULL THEN 0 ELSE xccc102f END)),
          SUM((CASE WHEN xccc102g IS NULL THEN 0 ELSE xccc102g END)),SUM((CASE WHEN xccc102h IS NULL THEN 0 ELSE xccc102h END))
      INTO l_xckk.xckk101, l_xckk.xckk102, l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,
           l_xckk.xckk102d,l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h
   FROM xccc_t 
   WHERE xcccent = g_enterprise AND xcccld = g_master.xckkld AND xccccomp = g_master.xckkcomp
     AND xccc001 = g_master.xckk001 AND xccc003 = g_master.xckk002 
     AND xccc004 = g_master.xckk003 AND xccc005 = g_master.xckk004
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xccc_t:2"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #161031-00037#1---s
   ##抓xccc的上期期末数量和金额
   #SELECT SUM((CASE WHEN xccc901 IS NULL THEN 0 ELSE xccc901 END)),  SUM((CASE WHEN xccc902 IS NULL THEN 0 ELSE xccc902 END)), 
   #       SUM((CASE WHEN xccc902a IS NULL THEN 0 ELSE xccc902a END)),SUM((CASE WHEN xccc902b IS NULL THEN 0 ELSE xccc902b END)),
   #       SUM((CASE WHEN xccc902c IS NULL THEN 0 ELSE xccc902c END)),SUM((CASE WHEN xccc902d IS NULL THEN 0 ELSE xccc902d END)),
   #       SUM((CASE WHEN xccc902e IS NULL THEN 0 ELSE xccc902e END)),SUM((CASE WHEN xccc902f IS NULL THEN 0 ELSE xccc902f END)),
   #       SUM((CASE WHEN xccc902g IS NULL THEN 0 ELSE xccc902g END)),SUM((CASE WHEN xccc902h IS NULL THEN 0 ELSE xccc902h END))
   #161031-00037#1--e
   #明细表抓上期的xcca的数量和金额
   SELECT SUM((CASE WHEN xcca101 IS NULL THEN 0 ELSE xcca101 END)),  SUM((CASE WHEN xcca102 IS NULL THEN 0 ELSE xcca102 END)), 
          SUM((CASE WHEN xcca102a IS NULL THEN 0 ELSE xcca102a END)),SUM((CASE WHEN xcca102b IS NULL THEN 0 ELSE xcca102b END)),
          SUM((CASE WHEN xcca102c IS NULL THEN 0 ELSE xcca102c END)),SUM((CASE WHEN xcca102d IS NULL THEN 0 ELSE xcca102d END)),
          SUM((CASE WHEN xcca102e IS NULL THEN 0 ELSE xcca102e END)),SUM((CASE WHEN xcca102f IS NULL THEN 0 ELSE xcca102f END)),
          SUM((CASE WHEN xcca102g IS NULL THEN 0 ELSE xcca102g END)),SUM((CASE WHEN xcca102h IS NULL THEN 0 ELSE xcca102h END))       
      INTO l_xckk.xckk103, l_xckk.xckk104, l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,
           l_xckk.xckk104d,l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h
   #161031-00037#1---s
   #FROM xccc_t 
   #WHERE xcccent = g_enterprise AND xcccld = g_master.xckkld AND xccccomp = g_master.xckkcomp
   #  AND xccc001 = g_master.xckk001 AND xccc003 = g_master.xckk002 
   #  AND xccc004 = g_previous_xckk003 AND xccc005 = g_previous_xckk004
   FROM xcca_t 
   WHERE xccaent = g_enterprise AND xccald = g_master.xckkld AND xccacomp = g_master.xckkcomp
     AND xcca001 = g_master.xckk001 AND xcca003 = g_master.xckk002 
     AND xcca004 = g_previous_xckk003 AND xcca005 = g_previous_xckk004
   #161031-00037#1---e
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xccc_t:3"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #抓不到抓上期的xcca的数据和金额
   IF (cl_null(l_xckk.xckk103)  OR l_xckk.xckk103 = 0) AND
      (cl_null(l_xckk.xckk104)  OR l_xckk.xckk104 = 0) AND
      (cl_null(l_xckk.xckk104a) OR l_xckk.xckk104a = 0) AND
      (cl_null(l_xckk.xckk104b) OR l_xckk.xckk104b = 0) AND
      (cl_null(l_xckk.xckk104c) OR l_xckk.xckk104c = 0) AND
      (cl_null(l_xckk.xckk104d) OR l_xckk.xckk104d = 0) AND
      (cl_null(l_xckk.xckk104e) OR l_xckk.xckk104e = 0) AND
      (cl_null(l_xckk.xckk104f) OR l_xckk.xckk104f = 0) AND
      (cl_null(l_xckk.xckk104g) OR l_xckk.xckk104g = 0) AND
      (cl_null(l_xckk.xckk104h) OR l_xckk.xckk104h = 0) THEN
      #161031-00037#1--s
      ##明细表抓上期的xcca的数量和金额
      #SELECT SUM((CASE WHEN xcca101 IS NULL THEN 0 ELSE xcca101 END)),  SUM((CASE WHEN xcca102 IS NULL THEN 0 ELSE xcca102 END)), 
      #       SUM((CASE WHEN xcca102a IS NULL THEN 0 ELSE xcca102a END)),SUM((CASE WHEN xcca102b IS NULL THEN 0 ELSE xcca102b END)),
      #       SUM((CASE WHEN xcca102c IS NULL THEN 0 ELSE xcca102c END)),SUM((CASE WHEN xcca102d IS NULL THEN 0 ELSE xcca102d END)),
      #       SUM((CASE WHEN xcca102e IS NULL THEN 0 ELSE xcca102e END)),SUM((CASE WHEN xcca102f IS NULL THEN 0 ELSE xcca102f END)),
      #       SUM((CASE WHEN xcca102g IS NULL THEN 0 ELSE xcca102g END)),SUM((CASE WHEN xcca102h IS NULL THEN 0 ELSE xcca102h END))
      #161031-00037#1---e
      SELECT SUM((CASE WHEN xccc901 IS NULL THEN 0 ELSE xccc901 END)),  SUM((CASE WHEN xccc902 IS NULL THEN 0 ELSE xccc902 END)), 
             SUM((CASE WHEN xccc902a IS NULL THEN 0 ELSE xccc902a END)),SUM((CASE WHEN xccc902b IS NULL THEN 0 ELSE xccc902b END)),
             SUM((CASE WHEN xccc902c IS NULL THEN 0 ELSE xccc902c END)),SUM((CASE WHEN xccc902d IS NULL THEN 0 ELSE xccc902d END)),
             SUM((CASE WHEN xccc902e IS NULL THEN 0 ELSE xccc902e END)),SUM((CASE WHEN xccc902f IS NULL THEN 0 ELSE xccc902f END)),
             SUM((CASE WHEN xccc902g IS NULL THEN 0 ELSE xccc902g END)),SUM((CASE WHEN xccc902h IS NULL THEN 0 ELSE xccc902h END))
         INTO l_xckk.xckk103, l_xckk.xckk104, l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,
              l_xckk.xckk104d,l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h
      #161031-00037#1--s
      #FROM xcca_t 
      #WHERE xccaent = g_enterprise AND xccald = g_master.xckkld AND xccacomp = g_master.xckkcomp
      #  AND xcca001 = g_master.xckk001 AND xcca003 = g_master.xckk002 
      #  AND xcca004 = g_previous_xckk003 AND xcca005 = g_previous_xckk004
      FROM xccc_t 
      WHERE xcccent = g_enterprise AND xcccld = g_master.xckkld AND xccccomp = g_master.xckkcomp
        AND xccc001 = g_master.xckk001 AND xccc003 = g_master.xckk002 
        AND xccc004 = g_previous_xckk003 AND xccc005 = g_previous_xckk004
      #161031-00037#1--e
      IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xcca_t:2"
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
   ELSE      #161031-00037#1
      LET g_source = 'xcca'      #標記明細表的來源   
   END IF
   
   #161109-00085#26-s mod
#   IF NOT axcq603_ins_xckk(l_xckk.*) THEN   #161109-00085#26-s mark
   IF NOT axcq603_ins_xckk(l_xckk.xckkent,l_xckk.xckkcomp,l_xckk.xckkld,l_xckk.xckk001,l_xckk.xckk002,
                           l_xckk.xckk003,l_xckk.xckk004,l_xckk.xckk005,l_xckk.xckk090,l_xckk.xckk101,
                           l_xckk.xckk102,l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,l_xckk.xckk102d,
                           l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h,l_xckk.xckk103,
                           l_xckk.xckk104,l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,l_xckk.xckk104d,
                           l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h,l_xckk.xckk105,
                           l_xckk.xckk106,l_xckk.xckk106a,l_xckk.xckk106b,l_xckk.xckk106c,l_xckk.xckk106d,
                           l_xckk.xckk106e,l_xckk.xckk106f,l_xckk.xckk106g,l_xckk.xckk106h) THEN
   #161109-00085#26-e mod
      LET r_success = FALSE
      RETURN r_success
   END IF
   LET g_source = ''  
   
   #l_sql 与l_sql1的区别是，xcck055的条件是否直接写入sql中
   #因为有些核对项目还需限定相关联的xcck020，所以l_sql1供比较特殊的核对项目，自行限定条件
   LET l_sql1= "SELECT SUM((CASE WHEN xcck201  IS NULL THEN 0 ELSE xcck201  END)* xcck009),SUM((CASE WHEN xcck202  IS NULL THEN 0 ELSE xcck202  END)*xcck009),", 
               "       SUM((CASE WHEN xcck202a IS NULL THEN 0 ELSE xcck202a END)* xcck009),SUM((CASE WHEN xcck202b IS NULL THEN 0 ELSE xcck202b END)*xcck009),",
               "       SUM((CASE WHEN xcck202c IS NULL THEN 0 ELSE xcck202c END)* xcck009),SUM((CASE WHEN xcck202d IS NULL THEN 0 ELSE xcck202d END)*xcck009),",
               "       SUM((CASE WHEN xcck202e IS NULL THEN 0 ELSE xcck202e END)* xcck009),SUM((CASE WHEN xcck202f IS NULL THEN 0 ELSE xcck202f END)*xcck009),",
               "       SUM((CASE WHEN xcck202g IS NULL THEN 0 ELSE xcck202g END)* xcck009),SUM((CASE WHEN xcck202h IS NULL THEN 0 ELSE xcck202h END)*xcck009) ",
               " FROM xcck_t ",
               " WHERE xcckent = '",g_enterprise,"' AND xcckld = '",g_master.xckkld,"' AND xcckcomp = '",g_master.xckkcomp,"' ",
               "   AND xcck001 = '",g_master.xckk001,"' AND xcck003 = '",g_master.xckk002,"' ",
               "   AND xcck004 = '",g_master.xckk003,"' AND xcck005 = '",g_master.xckk004,"' "
   
   LET l_sql2 = ''
   
   #明细表抓xcck的本期相关类型的数量和金额(只关联到xcck055)
   LET l_sql = "SELECT SUM((CASE WHEN xcck201  IS NULL THEN 0 ELSE xcck201  END)* xcck009),SUM((CASE WHEN xcck202  IS NULL THEN 0 ELSE xcck202  END)*xcck009),", 
               "       SUM((CASE WHEN xcck202a IS NULL THEN 0 ELSE xcck202a END)* xcck009),SUM((CASE WHEN xcck202b IS NULL THEN 0 ELSE xcck202b END)*xcck009),",
               "       SUM((CASE WHEN xcck202c IS NULL THEN 0 ELSE xcck202c END)* xcck009),SUM((CASE WHEN xcck202d IS NULL THEN 0 ELSE xcck202d END)*xcck009),",
               "       SUM((CASE WHEN xcck202e IS NULL THEN 0 ELSE xcck202e END)* xcck009),SUM((CASE WHEN xcck202f IS NULL THEN 0 ELSE xcck202f END)*xcck009),",
               "       SUM((CASE WHEN xcck202g IS NULL THEN 0 ELSE xcck202g END)* xcck009),SUM((CASE WHEN xcck202h IS NULL THEN 0 ELSE xcck202h END)*xcck009) ",
               " FROM xcck_t ",
               " WHERE xcckent = '",g_enterprise,"' AND xcckld = '",g_master.xckkld,"' AND xcckcomp = '",g_master.xckkcomp,"' ",
               "   AND xcck001 = '",g_master.xckk001,"' AND xcck003 = '",g_master.xckk002,"' ",
               "   AND xcck004 = '",g_master.xckk003,"' AND xcck005 = '",g_master.xckk004,"' ",
               "   AND xcck055 = ? "
   
   PREPARE axcq603_sel_pb1 FROM l_sql
   
   #明细表抓xcck的本期相关类型的数量和金额(关联到xcck055 和 xcck020 )
   LET l_sql = "SELECT SUM((CASE WHEN xcck201  IS NULL THEN 0 ELSE xcck201  END)* xcck009),SUM((CASE WHEN xcck202  IS NULL THEN 0 ELSE xcck202  END)*xcck009),", 
               "       SUM((CASE WHEN xcck202a IS NULL THEN 0 ELSE xcck202a END)* xcck009),SUM((CASE WHEN xcck202b IS NULL THEN 0 ELSE xcck202b END)*xcck009),",
               "       SUM((CASE WHEN xcck202c IS NULL THEN 0 ELSE xcck202c END)* xcck009),SUM((CASE WHEN xcck202d IS NULL THEN 0 ELSE xcck202d END)*xcck009),",
               "       SUM((CASE WHEN xcck202e IS NULL THEN 0 ELSE xcck202e END)* xcck009),SUM((CASE WHEN xcck202f IS NULL THEN 0 ELSE xcck202f END)*xcck009),",
               "       SUM((CASE WHEN xcck202g IS NULL THEN 0 ELSE xcck202g END)* xcck009),SUM((CASE WHEN xcck202h IS NULL THEN 0 ELSE xcck202h END)*xcck009) ",
               " FROM xcck_t ",
               " WHERE xcckent = '",g_enterprise,"' AND xcckld = '",g_master.xckkld,"' AND xcckcomp = '",g_master.xckkcomp,"' ",
               "   AND xcck001 = '",g_master.xckk001,"' AND xcck003 = '",g_master.xckk002,"' ",
               "   AND xcck004 = '",g_master.xckk003,"' AND xcck005 = '",g_master.xckk004,"' ",
               "   AND xcck055 = ? AND xcck020 = ? "
   
   PREPARE axcq603_sel_pb2 FROM l_sql
   
   #总表抓xccc的本期采购入库数量和金额，明细表抓xcck的本期采购入库和仓退的数量和金额，并写入xckk；有差异的按料号+特性+批号+成本域找出差异并写入xckl
   INITIALIZE l_xckk.* TO NULL
   LET l_xckk.xckk005 = '102'          #一般采购
   #总表抓xccc的本期采购入库数量和金额
   SELECT SUM((CASE WHEN xccc201 IS NULL THEN 0  ELSE xccc201 END)), SUM((CASE WHEN xccc202 IS NULL THEN 0  ELSE xccc202 END)), 
          SUM((CASE WHEN xccc202a IS NULL THEN 0 ELSE xccc202a END)),SUM((CASE WHEN xccc202b IS NULL THEN 0 ELSE xccc202b END)),
          SUM((CASE WHEN xccc202c IS NULL THEN 0 ELSE xccc202c END)),SUM((CASE WHEN xccc202d IS NULL THEN 0 ELSE xccc202d END)),
          SUM((CASE WHEN xccc202e IS NULL THEN 0 ELSE xccc202e END)),SUM((CASE WHEN xccc202f IS NULL THEN 0 ELSE xccc202f END)),
          SUM((CASE WHEN xccc202g IS NULL THEN 0 ELSE xccc202g END)),SUM((CASE WHEN xccc202h IS NULL THEN 0 ELSE xccc202h END))
      INTO l_xckk.xckk101, l_xckk.xckk102, l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,
           l_xckk.xckk102d,l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h
   FROM xccc_t 
   WHERE xcccent = g_enterprise AND xcccld = g_master.xckkld AND xccccomp = g_master.xckkcomp
     AND xccc001 = g_master.xckk001 AND xccc003 = g_master.xckk002 
     AND xccc004 = g_master.xckk003 AND xccc005 = g_master.xckk004
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xccc_t:4"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #明细表抓xcck的本期采购入库和仓退的数量和金额
   #160531-00032#1-----s
   #LET l_xcck055 =  '201'   #采购入库(采购入库、采购仓退)  
   #
   #EXECUTE axcq603_sel_pb1 USING l_xcck055
   LET l_sql2 = ''
   LET l_sql2 = l_sql1 , " AND xcck055 LIKE '201%' "  ##采购入库(采购入库、采购仓退) 
   PREPARE axcq603_sel_pb12 FROM l_sql2
   #EXECUTE axcq603_sel_pb12   #161031-00037#1
   #160531-00032#1-----e

   #EXECUTE axcq603_sel_pb1 USING l_xcck055  #161031-00037#1
   EXECUTE axcq603_sel_pb12  #161031-00037#1
      INTO l_xckk.xckk103, l_xckk.xckk104, l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,
           l_xckk.xckk104d,l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcck_t:1"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #161109-00085#26-s mod
#   IF NOT axcq603_ins_xckk(l_xckk.*) THEN   #161109-00085#26-s mark
   IF NOT axcq603_ins_xckk(l_xckk.xckkent,l_xckk.xckkcomp,l_xckk.xckkld,l_xckk.xckk001,l_xckk.xckk002,
                           l_xckk.xckk003,l_xckk.xckk004,l_xckk.xckk005,l_xckk.xckk090,l_xckk.xckk101,
                           l_xckk.xckk102,l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,l_xckk.xckk102d,
                           l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h,l_xckk.xckk103,
                           l_xckk.xckk104,l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,l_xckk.xckk104d,
                           l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h,l_xckk.xckk105,
                           l_xckk.xckk106,l_xckk.xckk106a,l_xckk.xckk106b,l_xckk.xckk106c,l_xckk.xckk106d,
                           l_xckk.xckk106e,l_xckk.xckk106f,l_xckk.xckk106g,l_xckk.xckk106h) THEN
   #161109-00085#26-e mod
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #总表抓xccc的本期委外入库数量和金额，明细表抓xcck的本期委外入库的数量和金额，并写入xckk；有差异的按料号+特性+批号+成本域找出差异并写入xckl
   INITIALIZE l_xckk.* TO NULL
   LET l_xckk.xckk005 = '117'          #委外入库
   #总表抓xccc的本期委外入库数量和金额
   SELECT SUM((CASE WHEN xccc203 IS NULL THEN 0  ELSE xccc203 END)), SUM((CASE WHEN xccc204 IS NULL THEN 0  ELSE xccc204 END)), 
          SUM((CASE WHEN xccc204a IS NULL THEN 0 ELSE xccc204a END)),SUM((CASE WHEN xccc204b IS NULL THEN 0 ELSE xccc204b END)),
          SUM((CASE WHEN xccc204c IS NULL THEN 0 ELSE xccc204c END)),SUM((CASE WHEN xccc204d IS NULL THEN 0 ELSE xccc204d END)),
          SUM((CASE WHEN xccc204e IS NULL THEN 0 ELSE xccc204e END)),SUM((CASE WHEN xccc204f IS NULL THEN 0 ELSE xccc204f END)),
          SUM((CASE WHEN xccc204g IS NULL THEN 0 ELSE xccc204g END)),SUM((CASE WHEN xccc204h IS NULL THEN 0 ELSE xccc204h END))
      INTO l_xckk.xckk101, l_xckk.xckk102, l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,
           l_xckk.xckk102d,l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h
   FROM xccc_t 
   WHERE xcccent = g_enterprise AND xcccld = g_master.xckkld AND xccccomp = g_master.xckkcomp
     AND xccc001 = g_master.xckk001 AND xccc003 = g_master.xckk002 
     AND xccc004 = g_master.xckk003 AND xccc005 = g_master.xckk004
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xccc_t:5"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF  
   
   #明细表抓xcck的本期委外入库和仓退的数量和金额
   #161031-00037#1---s
   #LET l_xcck055 =  '203'   #委外入庫(委外入庫、委外聯產品入庫、委外多產出入庫、委外拆件入庫、委外倉退)  
   #EXECUTE axcq603_sel_pb1 USING l_xcck055
   #   INTO l_xckk.xckk103, l_xckk.xckk104, l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,
   #        l_xckk.xckk104d,l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h
   LET l_sql2 = ''
   LET l_sql2 = l_sql1 , " AND xcck055 IN ('203','2030') "  ##采购入库(采购入库、采购仓退) 
   PREPARE axcq603_sel_pb13 FROM l_sql2
   EXECUTE axcq603_sel_pb13
      INTO l_xckk.xckk103, l_xckk.xckk104, l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,
           l_xckk.xckk104d,l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h
   #161031-00037#1---e
   
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcck_t:2"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #161109-00085#26-s mod
#   IF NOT axcq603_ins_xckk(l_xckk.*) THEN   #161109-00085#26-s mark
   IF NOT axcq603_ins_xckk(l_xckk.xckkent,l_xckk.xckkcomp,l_xckk.xckkld,l_xckk.xckk001,l_xckk.xckk002,
                           l_xckk.xckk003,l_xckk.xckk004,l_xckk.xckk005,l_xckk.xckk090,l_xckk.xckk101,
                           l_xckk.xckk102,l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,l_xckk.xckk102d,
                           l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h,l_xckk.xckk103,
                           l_xckk.xckk104,l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,l_xckk.xckk104d,
                           l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h,l_xckk.xckk105,
                           l_xckk.xckk106,l_xckk.xckk106a,l_xckk.xckk106b,l_xckk.xckk106c,l_xckk.xckk106d,
                           l_xckk.xckk106e,l_xckk.xckk106f,l_xckk.xckk106g,l_xckk.xckk106h) THEN
   #161109-00085#26-e mod
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #总表抓xccc的本期一般工单入库数量和金额，明细表抓xcck的本期一般工单入库的数量和金额，并写入xckk；有差异的按料号+特性+批号+成本域找出差异并写入xckl
   INITIALIZE l_xckk.* TO NULL
   LET l_xckk.xckk005 = '105'          #工单入库
   #总表抓xccc的本期一般工单入库数量和金额
   SELECT SUM((CASE WHEN xccc205 IS NULL THEN 0  ELSE xccc205 END)), SUM((CASE WHEN xccc206 IS NULL THEN 0  ELSE xccc206 END)), 
          SUM((CASE WHEN xccc206a IS NULL THEN 0 ELSE xccc206a END)),SUM((CASE WHEN xccc206b IS NULL THEN 0 ELSE xccc206b END)),
          SUM((CASE WHEN xccc206c IS NULL THEN 0 ELSE xccc206c END)),SUM((CASE WHEN xccc206d IS NULL THEN 0 ELSE xccc206d END)),
          SUM((CASE WHEN xccc206e IS NULL THEN 0 ELSE xccc206e END)),SUM((CASE WHEN xccc206f IS NULL THEN 0 ELSE xccc206f END)),
          SUM((CASE WHEN xccc206g IS NULL THEN 0 ELSE xccc206g END)),SUM((CASE WHEN xccc206h IS NULL THEN 0 ELSE xccc206h END))
      INTO l_xckk.xckk101, l_xckk.xckk102, l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,
           l_xckk.xckk102d,l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h
   FROM xccc_t 
   WHERE xcccent = g_enterprise AND xcccld = g_master.xckkld AND xccccomp = g_master.xckkcomp
     AND xccc001 = g_master.xckk001 AND xccc003 = g_master.xckk002 
     AND xccc004 = g_master.xckk003 AND xccc005 = g_master.xckk004
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xccc_t:6"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF  
   
   #明细表抓xcck的本期一般工单入库的数量和金额
   #161031-00037#1---s
   #LET l_xcck055 =  '205'   #工单入库(生產入庫、聯產品入庫、多主件產出入庫)    
   #
   #EXECUTE axcq603_sel_pb1 USING l_xcck055
   LET l_sql2 = ''
   LET l_sql2 = l_sql1 , " AND xcck055 IN ('205','2050') "  
   PREPARE axcq603_sel_pb14 FROM l_sql2
   EXECUTE axcq603_sel_pb14
   #161031-00037#1---e
      INTO l_xckk.xckk103, l_xckk.xckk104, l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,
           l_xckk.xckk104d,l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcck_t:3"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF  
   
   #161109-00085#26-s mod
#   IF NOT axcq603_ins_xckk(l_xckk.*) THEN   #161109-00085#26-s mark
   IF NOT axcq603_ins_xckk(l_xckk.xckkent,l_xckk.xckkcomp,l_xckk.xckkld,l_xckk.xckk001,l_xckk.xckk002,
                           l_xckk.xckk003,l_xckk.xckk004,l_xckk.xckk005,l_xckk.xckk090,l_xckk.xckk101,
                           l_xckk.xckk102,l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,l_xckk.xckk102d,
                           l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h,l_xckk.xckk103,
                           l_xckk.xckk104,l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,l_xckk.xckk104d,
                           l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h,l_xckk.xckk105,
                           l_xckk.xckk106,l_xckk.xckk106a,l_xckk.xckk106b,l_xckk.xckk106c,l_xckk.xckk106d,
                           l_xckk.xckk106e,l_xckk.xckk106f,l_xckk.xckk106g,l_xckk.xckk106h) THEN
   #161109-00085#26-e mod
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #总表抓xccc的本期返工工单入库数量和金额，明细表抓xcck的本期返工工单入库的数量和金额，并写入xckk；有差异的按料号+特性+批号+成本域找出差异并写入xckl
   INITIALIZE l_xckk.* TO NULL
   LET l_xckk.xckk005 = '115'          #返工入库
   #总表抓xccc的本期返工工单入库数量和金额
   SELECT SUM((CASE WHEN xccc209 IS NULL THEN 0  ELSE xccc209 END)), SUM((CASE WHEN xccc210 IS NULL THEN 0  ELSE xccc210 END)), 
          SUM((CASE WHEN xccc210a IS NULL THEN 0 ELSE xccc210a END)),SUM((CASE WHEN xccc210b IS NULL THEN 0 ELSE xccc210b END)),
          SUM((CASE WHEN xccc210c IS NULL THEN 0 ELSE xccc210c END)),SUM((CASE WHEN xccc210d IS NULL THEN 0 ELSE xccc210d END)),
          SUM((CASE WHEN xccc210e IS NULL THEN 0 ELSE xccc210e END)),SUM((CASE WHEN xccc210f IS NULL THEN 0 ELSE xccc210f END)),
          SUM((CASE WHEN xccc210g IS NULL THEN 0 ELSE xccc210g END)),SUM((CASE WHEN xccc210h IS NULL THEN 0 ELSE xccc210h END))
      INTO l_xckk.xckk101, l_xckk.xckk102, l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,
           l_xckk.xckk102d,l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h
   FROM xccc_t 
   WHERE xcccent = g_enterprise AND xcccld = g_master.xckkld AND xccccomp = g_master.xckkcomp
     AND xccc001 = g_master.xckk001 AND xccc003 = g_master.xckk002 
     AND xccc004 = g_master.xckk003 AND xccc005 = g_master.xckk004
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xccc_t:7"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF    
   #明细表抓xcck的本期返工工单入库的数量和金额
   #161031-00037#1---s
   #LET l_xcck055 =  '209'   #重工入库(生產入庫、聯產品入庫、多主件產出入庫)      
   #
   #EXECUTE axcq603_sel_pb1 USING l_xcck055
   LET l_sql2 = ''
   LET l_sql2 = l_sql1 , " AND xcck055 IN ('209','2090') "  
   PREPARE axcq603_sel_pb15 FROM l_sql2
   EXECUTE axcq603_sel_pb15
   #161031-00037#1---e
      INTO l_xckk.xckk103, l_xckk.xckk104, l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,
           l_xckk.xckk104d,l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcck_t:4"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF  
   #161109-00085#26-s mod
#   IF NOT axcq603_ins_xckk(l_xckk.*) THEN   #161109-00085#26-s mark
   IF NOT axcq603_ins_xckk(l_xckk.xckkent,l_xckk.xckkcomp,l_xckk.xckkld,l_xckk.xckk001,l_xckk.xckk002,
                           l_xckk.xckk003,l_xckk.xckk004,l_xckk.xckk005,l_xckk.xckk090,l_xckk.xckk101,
                           l_xckk.xckk102,l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,l_xckk.xckk102d,
                           l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h,l_xckk.xckk103,
                           l_xckk.xckk104,l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,l_xckk.xckk104d,
                           l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h,l_xckk.xckk105,
                           l_xckk.xckk106,l_xckk.xckk106a,l_xckk.xckk106b,l_xckk.xckk106c,l_xckk.xckk106d,
                           l_xckk.xckk106e,l_xckk.xckk106f,l_xckk.xckk106g,l_xckk.xckk106h) THEN
   #161109-00085#26-e mod
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #总表抓xccc的本期杂项入库数量和金额，明细表抓xcck的本期杂项入库和仓退的数量和金额，并写入xckk；有差异的按料号+特性+批号+成本域找出差异并写入xckl
   INITIALIZE l_xckk.* TO NULL
   LET l_xckk.xckk005 = '104'          #杂项入库
   #总表抓xccc的本期杂项入库数量和金额
   SELECT SUM((CASE WHEN xccc211 IS NULL THEN 0  ELSE xccc211 END)), SUM((CASE WHEN xccc212 IS NULL THEN 0  ELSE xccc212 END)), 
          SUM((CASE WHEN xccc212a IS NULL THEN 0 ELSE xccc212a END)),SUM((CASE WHEN xccc212b IS NULL THEN 0 ELSE xccc212b END)),
          SUM((CASE WHEN xccc212c IS NULL THEN 0 ELSE xccc212c END)),SUM((CASE WHEN xccc212d IS NULL THEN 0 ELSE xccc212d END)),
          SUM((CASE WHEN xccc212e IS NULL THEN 0 ELSE xccc212e END)),SUM((CASE WHEN xccc212f IS NULL THEN 0 ELSE xccc212f END)),
          SUM((CASE WHEN xccc212g IS NULL THEN 0 ELSE xccc212g END)),SUM((CASE WHEN xccc212h IS NULL THEN 0 ELSE xccc212h END))
      INTO l_xckk.xckk101, l_xckk.xckk102, l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,
           l_xckk.xckk102d,l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h
   FROM xccc_t 
   WHERE xcccent = g_enterprise AND xcccld = g_master.xckkld AND xccccomp = g_master.xckkcomp
     AND xccc001 = g_master.xckk001 AND xccc003 = g_master.xckk002 
     AND xccc004 = g_master.xckk003 AND xccc005 = g_master.xckk004
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xccc_t:8"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF  
   
   #明细表抓xcck的本期杂项入库和仓退的数量和金额
   LET l_xcck055 =  '211'   #杂项入库(雜收入庫)      

   EXECUTE axcq603_sel_pb1 USING l_xcck055
      INTO l_xckk.xckk103, l_xckk.xckk104, l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,
           l_xckk.xckk104d,l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcck_t:5"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF  
   #161109-00085#26-s mod
#   IF NOT axcq603_ins_xckk(l_xckk.*) THEN   #161109-00085#26-s mark
   IF NOT axcq603_ins_xckk(l_xckk.xckkent,l_xckk.xckkcomp,l_xckk.xckkld,l_xckk.xckk001,l_xckk.xckk002,
                           l_xckk.xckk003,l_xckk.xckk004,l_xckk.xckk005,l_xckk.xckk090,l_xckk.xckk101,
                           l_xckk.xckk102,l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,l_xckk.xckk102d,
                           l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h,l_xckk.xckk103,
                           l_xckk.xckk104,l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,l_xckk.xckk104d,
                           l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h,l_xckk.xckk105,
                           l_xckk.xckk106,l_xckk.xckk106a,l_xckk.xckk106b,l_xckk.xckk106c,l_xckk.xckk106d,
                           l_xckk.xckk106e,l_xckk.xckk106f,l_xckk.xckk106g,l_xckk.xckk106h) THEN
   #161109-00085#26-e mod
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #总表抓xccc的本期调拨入库数量和金额，明细表抓xcck的本期调拨入库的数量和金额，并写入xckk；有差异的按料号+特性+批号+成本域找出差异并写入xckl
   INITIALIZE l_xckk.* TO NULL
   LET l_xckk.xckk005 = '118'          #调拨入库
   #总表抓xccc的本期调拨入库数量和金额
   SELECT SUM((CASE WHEN xccc217 IS NULL THEN 0  ELSE xccc217 END)), SUM((CASE WHEN xccc218 IS NULL THEN 0  ELSE xccc218 END)), 
          SUM((CASE WHEN xccc218a IS NULL THEN 0 ELSE xccc218a END)),SUM((CASE WHEN xccc218b IS NULL THEN 0 ELSE xccc218b END)),
          SUM((CASE WHEN xccc218c IS NULL THEN 0 ELSE xccc218c END)),SUM((CASE WHEN xccc218d IS NULL THEN 0 ELSE xccc218d END)),
          SUM((CASE WHEN xccc218e IS NULL THEN 0 ELSE xccc218e END)),SUM((CASE WHEN xccc218f IS NULL THEN 0 ELSE xccc218f END)),
          SUM((CASE WHEN xccc218g IS NULL THEN 0 ELSE xccc218g END)),SUM((CASE WHEN xccc218h IS NULL THEN 0 ELSE xccc218h END))
      INTO l_xckk.xckk101, l_xckk.xckk102, l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,
           l_xckk.xckk102d,l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h
   FROM xccc_t 
   WHERE xcccent = g_enterprise AND xcccld = g_master.xckkld AND xccccomp = g_master.xckkcomp
     AND xccc001 = g_master.xckk001 AND xccc003 = g_master.xckk002 
     AND xccc004 = g_master.xckk003 AND xccc005 = g_master.xckk004
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xccc_t:9"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF  
   
   #明细表抓xcck的本期调拨入库的数量和金额
   #161031-00037#1---s
   #LET l_xcck055 =  '217'   #其他入库  
   #LET l_xcck020 =  '401'   #401.調撥 & inaj004 = '1(入项）'
   #EXECUTE axcq603_sel_pb2 USING l_xcck055,l_xcck020
   LET l_sql2 = ''
   LET l_sql2 = l_sql1 , " AND xcck055 IN ('217','3131') AND xcck020 = '401' "  
   PREPARE axcq603_sel_pb16 FROM l_sql2
   EXECUTE axcq603_sel_pb16
   #161031-00037#1---e
      INTO l_xckk.xckk103, l_xckk.xckk104, l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,
           l_xckk.xckk104d,l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcck_t:6"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF  
   #161109-00085#26-s mod
#   IF NOT axcq603_ins_xckk(l_xckk.*) THEN   #161109-00085#26-s mark
   IF NOT axcq603_ins_xckk(l_xckk.xckkent,l_xckk.xckkcomp,l_xckk.xckkld,l_xckk.xckk001,l_xckk.xckk002,
                           l_xckk.xckk003,l_xckk.xckk004,l_xckk.xckk005,l_xckk.xckk090,l_xckk.xckk101,
                           l_xckk.xckk102,l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,l_xckk.xckk102d,
                           l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h,l_xckk.xckk103,
                           l_xckk.xckk104,l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,l_xckk.xckk104d,
                           l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h,l_xckk.xckk105,
                           l_xckk.xckk106,l_xckk.xckk106a,l_xckk.xckk106b,l_xckk.xckk106c,l_xckk.xckk106d,
                           l_xckk.xckk106e,l_xckk.xckk106f,l_xckk.xckk106g,l_xckk.xckk106h) THEN
   #161109-00085#26-e mod
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #总表抓xccc的本期销退成本的数量和金额，明细表根据aoos020中销退成本参数设定，抓xcck的本期销售退货的数量和金额，并写入xckk；有差异的按料号+特性+批号+成本域找出差异并写入xckl   
   INITIALIZE l_xckk.* TO NULL
   LET l_xckk.xckk005 = '112'          #销退成本
   #总表抓xccc的本期销退成本的数量和金额
   #161031-00037#1---s
   #SELECT SUM((CASE WHEN xccc305 IS NULL THEN 0  ELSE xccc305 END)), SUM((CASE WHEN xccc306 IS NULL THEN 0  ELSE xccc306 END)), 
   #       SUM((CASE WHEN xccc306a IS NULL THEN 0 ELSE xccc306a END)),SUM((CASE WHEN xccc306b IS NULL THEN 0 ELSE xccc306b END)),
   #       SUM((CASE WHEN xccc306c IS NULL THEN 0 ELSE xccc306c END)),SUM((CASE WHEN xccc306d IS NULL THEN 0 ELSE xccc306d END)),
   #       SUM((CASE WHEN xccc306e IS NULL THEN 0 ELSE xccc306e END)),SUM((CASE WHEN xccc306f IS NULL THEN 0 ELSE xccc306f END)),
   #       SUM((CASE WHEN xccc306g IS NULL THEN 0 ELSE xccc306g END)),SUM((CASE WHEN xccc306h IS NULL THEN 0 ELSE xccc306h END))
   SELECT SUM((CASE WHEN xccc215 IS NULL THEN 0  ELSE xccc215 END)), SUM((CASE WHEN xccc216 IS NULL THEN 0  ELSE xccc216 END)), 
          SUM((CASE WHEN xccc216a IS NULL THEN 0 ELSE xccc216a END)),SUM((CASE WHEN xccc216b IS NULL THEN 0 ELSE xccc216b END)),
          SUM((CASE WHEN xccc216c IS NULL THEN 0 ELSE xccc216c END)),SUM((CASE WHEN xccc216d IS NULL THEN 0 ELSE xccc216d END)),
          SUM((CASE WHEN xccc216e IS NULL THEN 0 ELSE xccc216e END)),SUM((CASE WHEN xccc216f IS NULL THEN 0 ELSE xccc216f END)),
          SUM((CASE WHEN xccc216g IS NULL THEN 0 ELSE xccc216g END)),SUM((CASE WHEN xccc216h IS NULL THEN 0 ELSE xccc216h END))
   #161031-00037#1---e
       INTO l_xckk.xckk101, l_xckk.xckk102, l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,
           l_xckk.xckk102d,l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h
   FROM xccc_t 
   WHERE xcccent = g_enterprise AND xcccld = g_master.xckkld AND xccccomp = g_master.xckkcomp
     AND xccc001 = g_master.xckk001 AND xccc003 = g_master.xckk002 
     AND xccc004 = g_master.xckk003 AND xccc005 = g_master.xckk004
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xccc_t:9"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF  
   
   #161031-00037#1---s
   ##明细表根据aoos020中销退成本参数设定，抓xcck的本期销售退货的数量和金额
   ##3的话表示xccc中的销售成本是含了销退的，所以xcck明细中要抓出货＋销退；如果是选1的话，表示xccc中的销售成本只有出货，销退成本是做为入项的
   ##所以只有为1，才将销退成本计算到当前核对项目(销退)中，其他则放在销售成本中
   #IF cl_get_para(g_enterprise,g_site,'S-FIN-6006') = 1 THEN
   #   LET l_xcck055 =  '305'   #销退(xcck020 = 202.銷售退貨 & S-FIN-6006 = 1)
   #   EXECUTE axcq603_sel_pb1 USING l_xcck055
   #      INTO l_xckk.xckk103, l_xckk.xckk104, l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,
   #           l_xckk.xckk104d,l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h
   #   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
   #      INITIALIZE g_errparam TO NULL 
   #      LET g_errparam.extend = "xcck_t:6"
   #      LET g_errparam.code   = SQLCA.sqlcode 
   #      LET g_errparam.popup  = TRUE 
   #      CALL cl_err()
   #      LET r_success = FALSE
   #      RETURN r_success
   #   END IF 
   #ELSE
   #   LET l_xckk.xckk103 = 0   LET l_xckk.xckk101 = 0
   #   LET l_xckk.xckk104 = 0   LET l_xckk.xckk102 = 0
   #   LET l_xckk.xckk104a= 0   LET l_xckk.xckk102a= 0
   #   LET l_xckk.xckk104b= 0   LET l_xckk.xckk102b= 0
   #   LET l_xckk.xckk104c= 0   LET l_xckk.xckk102c= 0
   #   LET l_xckk.xckk104d= 0   LET l_xckk.xckk102d= 0
   #   LET l_xckk.xckk104e= 0   LET l_xckk.xckk102e= 0
   #   LET l_xckk.xckk104f= 0   LET l_xckk.xckk102f= 0
   #   LET l_xckk.xckk104g= 0   LET l_xckk.xckk102g= 0
   #   LET l_xckk.xckk104h= 0   LET l_xckk.xckk102h= 0
   #END IF
   LET l_xcck055 =  '215'   
   EXECUTE axcq603_sel_pb1 USING l_xcck055
      INTO l_xckk.xckk103, l_xckk.xckk104, l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,
           l_xckk.xckk104d,l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcck_t:6"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF 
   #161031-00037#1---e
   
   #161109-00085#26-s mod
#   IF NOT axcq603_ins_xckk(l_xckk.*) THEN   #161109-00085#26-s mark
   IF NOT axcq603_ins_xckk(l_xckk.xckkent,l_xckk.xckkcomp,l_xckk.xckkld,l_xckk.xckk001,l_xckk.xckk002,
                           l_xckk.xckk003,l_xckk.xckk004,l_xckk.xckk005,l_xckk.xckk090,l_xckk.xckk101,
                           l_xckk.xckk102,l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,l_xckk.xckk102d,
                           l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h,l_xckk.xckk103,
                           l_xckk.xckk104,l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,l_xckk.xckk104d,
                           l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h,l_xckk.xckk105,
                           l_xckk.xckk106,l_xckk.xckk106a,l_xckk.xckk106b,l_xckk.xckk106c,l_xckk.xckk106d,
                           l_xckk.xckk106e,l_xckk.xckk106f,l_xckk.xckk106g,l_xckk.xckk106h) THEN
   #161109-00085#26-e mod
      LET r_success = FALSE
      RETURN r_success
   END IF    
   
  
   #总表抓xccc的本期入库调整的金额，明细表抓xcco的本期入库调整金额，并写入xckk；有差异的按料号+特性+批号+成本域找出差异并写入xckl
   INITIALIZE l_xckk.* TO NULL
   LET l_xckk.xckk005 = '106'         #当站下线和入库调整 
   #总表抓xccc的本期入库调整的金额
   SELECT SUM((CASE WHEN xccc213 IS NULL THEN 0  ELSE xccc213 END)), SUM((CASE WHEN xccc214 IS NULL THEN 0  ELSE xccc214 END)), 
          SUM((CASE WHEN xccc214a IS NULL THEN 0 ELSE xccc214a END)),SUM((CASE WHEN xccc214b IS NULL THEN 0 ELSE xccc214b END)),
          SUM((CASE WHEN xccc214c IS NULL THEN 0 ELSE xccc214c END)),SUM((CASE WHEN xccc214d IS NULL THEN 0 ELSE xccc214d END)),
          SUM((CASE WHEN xccc214e IS NULL THEN 0 ELSE xccc214e END)),SUM((CASE WHEN xccc214f IS NULL THEN 0 ELSE xccc214f END)),
          SUM((CASE WHEN xccc214g IS NULL THEN 0 ELSE xccc214g END)),SUM((CASE WHEN xccc214h IS NULL THEN 0 ELSE xccc214h END))
      INTO l_xckk.xckk101, l_xckk.xckk102, l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,
           l_xckk.xckk102d,l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h
   FROM xccc_t 
   WHERE xcccent = g_enterprise AND xcccld = g_master.xckkld AND xccccomp = g_master.xckkcomp
     AND xccc001 = g_master.xckk001 AND xccc003 = g_master.xckk002 
     AND xccc004 = g_master.xckk003 AND xccc005 = g_master.xckk004
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xccc_t:10"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF  
   #170210-00001# remark ----- (S)
   #161031-00037#1---s
   #明细表抓xcco的本期入库调整金额
   SELECT 0 , SUM((CASE WHEN xcco102 IS NULL THEN 0  ELSE xcco102 END)), 
          SUM((CASE WHEN xcco102a IS NULL THEN 0 ELSE xcco102a END)),SUM((CASE WHEN xcco102b IS NULL THEN 0 ELSE xcco102b END)),
          SUM((CASE WHEN xcco102c IS NULL THEN 0 ELSE xcco102c END)),SUM((CASE WHEN xcco102d IS NULL THEN 0 ELSE xcco102d END)),
          SUM((CASE WHEN xcco102e IS NULL THEN 0 ELSE xcco102e END)),SUM((CASE WHEN xcco102f IS NULL THEN 0 ELSE xcco102f END)),
          SUM((CASE WHEN xcco102g IS NULL THEN 0 ELSE xcco102g END)),SUM((CASE WHEN xcco102h IS NULL THEN 0 ELSE xcco102h END))
      INTO l_xckk.xckk103, l_xckk.xckk104, l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,
           l_xckk.xckk104d,l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h
   FROM xcco_t
   WHERE xccoent = g_enterprise AND xccold = g_master.xckkld AND xccocomp = g_master.xckkcomp
     AND xcco001 = g_master.xckk001 AND xcco003 = g_master.xckk002 
     AND xcco004 = g_master.xckk003 AND xcco005 = g_master.xckk004
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcco_t:1"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #当站下线是否影响成本，为Y时，加上当站下线的成本
   IF cl_get_para(g_enterprise,g_site,'S-FIN-6006') = 'Y' THEN
      #明细表抓xcck的当站下线的数量和金额
      LET l_xcck055 =  '213'  #115.當站下線 & S-FIN-6016 = 'Y'
      LET l_xcck020 =  '115'  #115.當站下線 & S-FIN-6016 = 'Y'
      EXECUTE axcq603_sel_pb2 USING l_xcck055,l_xcck020
         INTO l_xckk103, l_xckk104, l_xckk104a,l_xckk104b,l_xckk104c,
              l_xckk104d,l_xckk104e,l_xckk104f,l_xckk104g,l_xckk104h
      IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xcck_t:6"
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      LET l_xckk.xckk103 = l_xckk.xckk103 + l_xckk103
      LET l_xckk.xckk104 = l_xckk.xckk104 + l_xckk104
      LET l_xckk.xckk104a= l_xckk.xckk104a + l_xckk104a
      LET l_xckk.xckk104b= l_xckk.xckk104b + l_xckk104b
      LET l_xckk.xckk104c= l_xckk.xckk104c + l_xckk104c
      LET l_xckk.xckk104d= l_xckk.xckk104d + l_xckk104d
      LET l_xckk.xckk104e= l_xckk.xckk104e + l_xckk104e
      LET l_xckk.xckk104f= l_xckk.xckk104f + l_xckk104f
      LET l_xckk.xckk104g= l_xckk.xckk104g + l_xckk104g
      LET l_xckk.xckk104h= l_xckk.xckk104h + l_xckk104h       
   END IF
   #170210-00001#1 remark ----- (E)
   #170210-00001#1 mark-------- (S)
   ##明细表抓xcck的当站下线的数量和金额
   #LET l_xcck055 =  '213'  #115.當站下線 & S-FIN-6016 = 'Y'
   #LET l_xcck020 =  '115'  #115.當站下線 & S-FIN-6016 = 'Y'
   #EXECUTE axcq603_sel_pb2 USING l_xcck055,l_xcck020
   #   INTO l_xckk103, l_xckk104, l_xckk104a,l_xckk104b,l_xckk104c,
   #        l_xckk104d,l_xckk104e,l_xckk104f,l_xckk104g,l_xckk104h
   #IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
   #   INITIALIZE g_errparam TO NULL 
   #   LET g_errparam.extend = "xcck_t:6"
   #   LET g_errparam.code   = SQLCA.sqlcode 
   #   LET g_errparam.popup  = TRUE 
   #   CALL cl_err()
   #   LET r_success = FALSE
   #   RETURN r_success
   #END IF
   #161031-00037#1---e
   
   #161109-00085#26-s mod
#   IF NOT axcq603_ins_xckk(l_xckk.*) THEN   #161109-00085#26-s mark
   IF NOT axcq603_ins_xckk(l_xckk.xckkent,l_xckk.xckkcomp,l_xckk.xckkld,l_xckk.xckk001,l_xckk.xckk002,
                           l_xckk.xckk003,l_xckk.xckk004,l_xckk.xckk005,l_xckk.xckk090,l_xckk.xckk101,
                           l_xckk.xckk102,l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,l_xckk.xckk102d,
                           l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h,l_xckk.xckk103,
                           l_xckk.xckk104,l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,l_xckk.xckk104d,
                           l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h,l_xckk.xckk105,
                           l_xckk.xckk106,l_xckk.xckk106a,l_xckk.xckk106b,l_xckk.xckk106c,l_xckk.xckk106d,
                           l_xckk.xckk106e,l_xckk.xckk106f,l_xckk.xckk106g,l_xckk.xckk106h) THEN
   #161109-00085#26-e mod
      LET r_success = FALSE
      RETURN r_success
   END IF  
   
   #总表抓xccc的本期返工发料的数量和金额，明细表抓xcck的本期返工工单领用和退料的数量和金额，并写入xckk；有差异的按料号+特性+批号+成本域找出差异并写入xckl   
   INITIALIZE l_xckk.* TO NULL
   LET l_xckk.xckk005 = '114'         #返工领出
   #总表抓xccc的本期返工发料的数量和金额
   SELECT SUM((CASE WHEN xccc207 IS NULL THEN 0  ELSE xccc207 END)), SUM((CASE WHEN xccc208 IS NULL THEN 0  ELSE xccc208 END)), 
          SUM((CASE WHEN xccc208a IS NULL THEN 0 ELSE xccc208a END)),SUM((CASE WHEN xccc208b IS NULL THEN 0 ELSE xccc208b END)),
          SUM((CASE WHEN xccc208c IS NULL THEN 0 ELSE xccc208c END)),SUM((CASE WHEN xccc208d IS NULL THEN 0 ELSE xccc208d END)),
          SUM((CASE WHEN xccc208e IS NULL THEN 0 ELSE xccc208e END)),SUM((CASE WHEN xccc208f IS NULL THEN 0 ELSE xccc208f END)),
          SUM((CASE WHEN xccc208g IS NULL THEN 0 ELSE xccc208g END)),SUM((CASE WHEN xccc208h IS NULL THEN 0 ELSE xccc208h END))
      INTO l_xckk.xckk101, l_xckk.xckk102, l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,
           l_xckk.xckk102d,l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h
   FROM xccc_t 
   WHERE xcccent = g_enterprise AND xcccld = g_master.xckkld AND xccccomp = g_master.xckkcomp
     AND xccc001 = g_master.xckk001 AND xccc003 = g_master.xckk002 
     AND xccc004 = g_master.xckk003 AND xccc005 = g_master.xckk004
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xccc_t:11"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF  
   
   #明细表抓xcck的本期返工工单领用和退料的数量和金额
   LET l_xcck055 =  '207'   #重工领出(302.生產發料 & sfaa042 = 'Y' & 发料料号的成本阶 <= sfaa010的成本阶、303.生產退料 & sfaa042 = 'Y' & 发料料号的成本阶 <= sfaa010的成本阶)      

   EXECUTE axcq603_sel_pb1 USING l_xcck055
      INTO l_xckk.xckk103, l_xckk.xckk104, l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,
           l_xckk.xckk104d,l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcck_t:7"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF  
   #161109-00085#26-s mod
#   IF NOT axcq603_ins_xckk(l_xckk.*) THEN   #161109-00085#26-s mark
   IF NOT axcq603_ins_xckk(l_xckk.xckkent,l_xckk.xckkcomp,l_xckk.xckkld,l_xckk.xckk001,l_xckk.xckk002,
                           l_xckk.xckk003,l_xckk.xckk004,l_xckk.xckk005,l_xckk.xckk090,l_xckk.xckk101,
                           l_xckk.xckk102,l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,l_xckk.xckk102d,
                           l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h,l_xckk.xckk103,
                           l_xckk.xckk104,l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,l_xckk.xckk104d,
                           l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h,l_xckk.xckk105,
                           l_xckk.xckk106,l_xckk.xckk106a,l_xckk.xckk106b,l_xckk.xckk106c,l_xckk.xckk106d,
                           l_xckk.xckk106e,l_xckk.xckk106f,l_xckk.xckk106g,l_xckk.xckk106h) THEN
   #161109-00085#26-e mod
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #总表抓xccc的本期一般工单发料的数量和金额，明细表抓xcck的本期一般工单领用和退料的数量和金额，并写入xckk；有差异的按料号+特性+批号+成本域找出差异并写入xckl
   INITIALIZE l_xckk.* TO NULL
   LET l_xckk.xckk005 = '107'         #工单发料
   #总表抓xccc的本期一般工单发料的数量和金额
   SELECT SUM((CASE WHEN xccc301 IS NULL THEN 0  ELSE xccc301 END)), SUM((CASE WHEN xccc302 IS NULL THEN 0  ELSE xccc302 END)), 
          SUM((CASE WHEN xccc302a IS NULL THEN 0 ELSE xccc302a END)),SUM((CASE WHEN xccc302b IS NULL THEN 0 ELSE xccc302b END)),
          SUM((CASE WHEN xccc302c IS NULL THEN 0 ELSE xccc302c END)),SUM((CASE WHEN xccc302d IS NULL THEN 0 ELSE xccc302d END)),
          SUM((CASE WHEN xccc302e IS NULL THEN 0 ELSE xccc302e END)),SUM((CASE WHEN xccc302f IS NULL THEN 0 ELSE xccc302f END)),
          SUM((CASE WHEN xccc302g IS NULL THEN 0 ELSE xccc302g END)),SUM((CASE WHEN xccc302h IS NULL THEN 0 ELSE xccc302h END))
      INTO l_xckk.xckk101, l_xckk.xckk102, l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,
           l_xckk.xckk102d,l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h
   FROM xccc_t 
   WHERE xcccent = g_enterprise AND xcccld = g_master.xckkld AND xccccomp = g_master.xckkcomp
     AND xccc001 = g_master.xckk001 AND xccc003 = g_master.xckk002 
     AND xccc004 = g_master.xckk003 AND xccc005 = g_master.xckk004
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xccc_t:12"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF  
   
   #明细表抓xcck的本期一般工单领用和退料的数量和金额
   #160531-00032#1---s
   #LET l_xcck055 =  '301'  #工单领用（非月加权）
   #161031-00037#1---s
   #LET l_xcck055  ='3012'   #工单领用
   #EXECUTE axcq603_sel_pb1 USING l_xcck055
   #160531-00032#1---e
   LET l_sql2 = ''
   LET l_sql2 = l_sql1 , " AND xcck055 IN ('301','3011','3012') "  
   PREPARE axcq603_sel_pb17 FROM l_sql2
   EXECUTE axcq603_sel_pb17
   #161031-00037#1---e
      INTO l_xckk.xckk103, l_xckk.xckk104, l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,
           l_xckk.xckk104d,l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcck_t:8"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF  
   #161109-00085#26-s mod
#   IF NOT axcq603_ins_xckk(l_xckk.*) THEN   #161109-00085#26-s mark
   IF NOT axcq603_ins_xckk(l_xckk.xckkent,l_xckk.xckkcomp,l_xckk.xckkld,l_xckk.xckk001,l_xckk.xckk002,
                           l_xckk.xckk003,l_xckk.xckk004,l_xckk.xckk005,l_xckk.xckk090,l_xckk.xckk101,
                           l_xckk.xckk102,l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,l_xckk.xckk102d,
                           l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h,l_xckk.xckk103,
                           l_xckk.xckk104,l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,l_xckk.xckk104d,
                           l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h,l_xckk.xckk105,
                           l_xckk.xckk106,l_xckk.xckk106a,l_xckk.xckk106b,l_xckk.xckk106c,l_xckk.xckk106d,
                           l_xckk.xckk106e,l_xckk.xckk106f,l_xckk.xckk106g,l_xckk.xckk106h) THEN
   #161109-00085#26-e mod
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #总表抓xccc的本期杂项发料的数量和金额，明细表抓xcck的本期杂项发料的数量和金额，并写入xckk；有差异的按料号+特性+批号+成本域找出差异并写入xckl      
   INITIALIZE l_xckk.* TO NULL
   LET l_xckk.xckk005 = '108'         #杂项发料
   #总表抓xccc的本期杂项发料的数量和金额
   SELECT SUM((CASE WHEN xccc309 IS NULL THEN 0  ELSE xccc309 END)), SUM((CASE WHEN xccc310 IS NULL THEN 0  ELSE xccc310 END)), 
          SUM((CASE WHEN xccc310a IS NULL THEN 0 ELSE xccc310a END)),SUM((CASE WHEN xccc310b IS NULL THEN 0 ELSE xccc310b END)),
          SUM((CASE WHEN xccc310c IS NULL THEN 0 ELSE xccc310c END)),SUM((CASE WHEN xccc310d IS NULL THEN 0 ELSE xccc310d END)),
          SUM((CASE WHEN xccc310e IS NULL THEN 0 ELSE xccc310e END)),SUM((CASE WHEN xccc310f IS NULL THEN 0 ELSE xccc310f END)),
          SUM((CASE WHEN xccc310g IS NULL THEN 0 ELSE xccc310g END)),SUM((CASE WHEN xccc310h IS NULL THEN 0 ELSE xccc310h END))
      INTO l_xckk.xckk101, l_xckk.xckk102, l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,
           l_xckk.xckk102d,l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h
   FROM xccc_t 
   WHERE xcccent = g_enterprise AND xcccld = g_master.xckkld AND xccccomp = g_master.xckkcomp
     AND xccc001 = g_master.xckk001 AND xccc003 = g_master.xckk002 
     AND xccc004 = g_master.xckk003 AND xccc005 = g_master.xckk004
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xccc_t:13"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF  
   
   #明细表抓xcck的本期杂项发料的数量和金额
   LET l_sql2 = ''
   LET l_sql2 = l_sql1 , " AND xcck055 IN  ('309','3091','3092') "  #杂发（非月加权）
   #LET l_sql2 = l_sql2 , " AND xcck020 =  '301' "   #雜發出庫  #161031-00037#1
   PREPARE axcq603_sel_pb5 FROM l_sql2
   EXECUTE axcq603_sel_pb5
      INTO l_xckk.xckk103, l_xckk.xckk104, l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,
           l_xckk.xckk104d,l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcck_t:9"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF  
   #161109-00085#26-s mod
#   IF NOT axcq603_ins_xckk(l_xckk.*) THEN   #161109-00085#26-s mark
   IF NOT axcq603_ins_xckk(l_xckk.xckkent,l_xckk.xckkcomp,l_xckk.xckkld,l_xckk.xckk001,l_xckk.xckk002,
                           l_xckk.xckk003,l_xckk.xckk004,l_xckk.xckk005,l_xckk.xckk090,l_xckk.xckk101,
                           l_xckk.xckk102,l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,l_xckk.xckk102d,
                           l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h,l_xckk.xckk103,
                           l_xckk.xckk104,l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,l_xckk.xckk104d,
                           l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h,l_xckk.xckk105,
                           l_xckk.xckk106,l_xckk.xckk106a,l_xckk.xckk106b,l_xckk.xckk106c,l_xckk.xckk106d,
                           l_xckk.xckk106e,l_xckk.xckk106f,l_xckk.xckk106g,l_xckk.xckk106h) THEN
   #161109-00085#26-e mod
      LET r_success = FALSE
      RETURN r_success
   END IF
   LET l_sql2 = ''
   
   #总表抓xccc的本期销售出货的数量和金额，明细表根据aoos020中销退成本参数设定，抓xcck的本期销售出货或退货或样品的数量和金额，并写入xckk；有差异的按料号+特性+批号+成本域找出差异并写入xckl  
   INITIALIZE l_xckk.* TO NULL
   LET l_xckk.xckk005 = '110'         #销售出货
   #161031-00037#1---s
   #总表抓xccc的本期销售出货的数量和金额
   #SELECT SUM((CASE WHEN xccc303 IS NULL THEN 0  ELSE xccc303 END)), SUM((CASE WHEN xccc304 IS NULL THEN 0  ELSE xccc304 END)), 
   #       SUM((CASE WHEN xccc304a IS NULL THEN 0 ELSE xccc304a END)),SUM((CASE WHEN xccc304b IS NULL THEN 0 ELSE xccc304b END)),
   #       SUM((CASE WHEN xccc304c IS NULL THEN 0 ELSE xccc304c END)),SUM((CASE WHEN xccc304d IS NULL THEN 0 ELSE xccc304d END)),
   #       SUM((CASE WHEN xccc304e IS NULL THEN 0 ELSE xccc304e END)),SUM((CASE WHEN xccc304f IS NULL THEN 0 ELSE xccc304f END)),
   #       SUM((CASE WHEN xccc304g IS NULL THEN 0 ELSE xccc304g END)),SUM((CASE WHEN xccc304h IS NULL THEN 0 ELSE xccc304h END))
   SELECT SUM((CASE WHEN xccc303 IS NULL THEN 0  ELSE xccc303 END) + (CASE WHEN xccc305 IS NULL THEN 0  ELSE xccc305 END) ), 
          SUM((CASE WHEN xccc304 IS NULL THEN 0  ELSE xccc304 END) + (CASE WHEN xccc306 IS NULL THEN 0  ELSE xccc306 END)), 
          SUM((CASE WHEN xccc304a IS NULL THEN 0 ELSE xccc304a END)+ (CASE WHEN xccc306a IS NULL THEN 0 ELSE xccc306a END)),
          SUM((CASE WHEN xccc304b IS NULL THEN 0 ELSE xccc304b END)+ (CASE WHEN xccc306b IS NULL THEN 0 ELSE xccc306b END)),
          SUM((CASE WHEN xccc304c IS NULL THEN 0 ELSE xccc304c END)+ (CASE WHEN xccc306c IS NULL THEN 0 ELSE xccc306c END)),
          SUM((CASE WHEN xccc304d IS NULL THEN 0 ELSE xccc304d END)+ (CASE WHEN xccc306d IS NULL THEN 0 ELSE xccc306d END)),
          SUM((CASE WHEN xccc304e IS NULL THEN 0 ELSE xccc304e END)+ (CASE WHEN xccc306e IS NULL THEN 0 ELSE xccc306e END)),
          SUM((CASE WHEN xccc304f IS NULL THEN 0 ELSE xccc304f END)+ (CASE WHEN xccc306f IS NULL THEN 0 ELSE xccc306f END)),
          SUM((CASE WHEN xccc304g IS NULL THEN 0 ELSE xccc304g END)+ (CASE WHEN xccc306g IS NULL THEN 0 ELSE xccc306g END)),
          SUM((CASE WHEN xccc304h IS NULL THEN 0 ELSE xccc304h END)+ (CASE WHEN xccc306h IS NULL THEN 0 ELSE xccc306h END))
   #161031-00037#1--e   
      INTO l_xckk.xckk101, l_xckk.xckk102, l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,
           l_xckk.xckk102d,l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h
   FROM xccc_t 
   WHERE xcccent = g_enterprise AND xcccld = g_master.xckkld AND xccccomp = g_master.xckkcomp
     AND xccc001 = g_master.xckk001 AND xccc003 = g_master.xckk002 
     AND xccc004 = g_master.xckk003 AND xccc005 = g_master.xckk004
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xccc_t:14"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF  
   
   #明细表根据aoos020中销退成本参数设定，抓xcck的本期销售出货或退货或样品的数量和金额
   #3的话表示xccc中的销售成本是含了销退的，所以xcck明细中要抓出货＋销退；如果是选1的话，表示xccc中的销售成本只有出货，销退成本是做为入项的
   #所以为2、3，需将销退成本计算到当前核对项目(销货)中
   #'303'    #销货(201.銷售出庫) '215' #销退入库(202.銷售退貨 & S-FIN-6006 = 2/3)  307    #销售费用(样品的，记为销售费用)
   # S-FIN-6006 3的话表示xccc中的销售成本是含了销退的，所以xcck明细中要抓出货＋销退；如果是选1的话，表示xccc中的销售成本只有出货，销退成本是做为入项的
   #              所以为2、3，需将销退成本计算到当前核对项目(销货)中
   # S-FIN-6019 勾选的话是xccc中的销售出货就不含样品，还需要抓取样品的xcck明细
   LET l_sql2 = ''
   #161031-00037#1---s
   #IF cl_get_para(g_enterprise,g_site,'S-FIN-6019') THEN
   #   IF cl_get_para(g_enterprise,g_site,'S-FIN-6006') MATCHES '[23]' THEN
   #      LET l_sql2 = l_sql1 , " AND (xcck055 = '303' OR xcck055 = '215' OR (xcck055 = '307' AND xcck020 ='201')) "   #201.銷售出庫
   #   ELSE
   #      LET l_sql2 = l_sql1 , " AND (xcck055 = '303' OR (xcck055 = '307' AND xcck020 ='201')) "   #201.銷售出庫
   #   END IF
   #ELSE
   #   IF cl_get_para(g_enterprise,g_site,'S-FIN-6006') MATCHES '[23]' THEN
   #      LET l_sql2 = l_sql1 , " AND (xcck055 = '303' OR xcck055 = '215') "   #201.銷售出庫
   #   ELSE
   #      LET l_sql2 = l_sql1 , " AND xcck055 = '303' "   #201.銷售出庫
   #   END IF
   #END IF
   LET l_sql2 = l_sql1 , " AND xcck055 IN ('303','305') "  
   #161031-00037#1---e
   PREPARE axcq603_sel_pb3 FROM l_sql2
   EXECUTE axcq603_sel_pb3 
      INTO l_xckk.xckk103, l_xckk.xckk104, l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,
           l_xckk.xckk104d,l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcck_t:10"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF  
   #161109-00085#26-s mod
#   IF NOT axcq603_ins_xckk(l_xckk.*) THEN   #161109-00085#26-s mark
   IF NOT axcq603_ins_xckk(l_xckk.xckkent,l_xckk.xckkcomp,l_xckk.xckkld,l_xckk.xckk001,l_xckk.xckk002,
                           l_xckk.xckk003,l_xckk.xckk004,l_xckk.xckk005,l_xckk.xckk090,l_xckk.xckk101,
                           l_xckk.xckk102,l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,l_xckk.xckk102d,
                           l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h,l_xckk.xckk103,
                           l_xckk.xckk104,l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,l_xckk.xckk104d,
                           l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h,l_xckk.xckk105,
                           l_xckk.xckk106,l_xckk.xckk106a,l_xckk.xckk106b,l_xckk.xckk106c,l_xckk.xckk106d,
                           l_xckk.xckk106e,l_xckk.xckk106f,l_xckk.xckk106g,l_xckk.xckk106h) THEN
   #161109-00085#26-e mod
      LET r_success = FALSE
      RETURN r_success
   END IF     
   
   
   #总表抓xccc的本期销售费用的数量和金额
   INITIALIZE l_xckk.* TO NULL
   LET l_xckk.xckk005 = '111'         #销售费用
   SELECT SUM((CASE WHEN xccc307 IS NULL THEN 0  ELSE xccc307 END)), SUM((CASE WHEN xccc308 IS NULL THEN 0  ELSE xccc308 END)), 
          SUM((CASE WHEN xccc308a IS NULL THEN 0 ELSE xccc308a END)),SUM((CASE WHEN xccc308b IS NULL THEN 0 ELSE xccc308b END)),
          SUM((CASE WHEN xccc308c IS NULL THEN 0 ELSE xccc308c END)),SUM((CASE WHEN xccc308d IS NULL THEN 0 ELSE xccc308d END)),
          SUM((CASE WHEN xccc308e IS NULL THEN 0 ELSE xccc308e END)),SUM((CASE WHEN xccc308f IS NULL THEN 0 ELSE xccc308f END)),
          SUM((CASE WHEN xccc308g IS NULL THEN 0 ELSE xccc308g END)),SUM((CASE WHEN xccc308h IS NULL THEN 0 ELSE xccc308h END))
      INTO l_xckk.xckk101, l_xckk.xckk102, l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,
           l_xckk.xckk102d,l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h
   FROM xccc_t 
   WHERE xcccent = g_enterprise AND xcccld = g_master.xckkld AND xccccomp = g_master.xckkcomp
     AND xccc001 = g_master.xckk001 AND xccc003 = g_master.xckk002 
     AND xccc004 = g_master.xckk003 AND xccc005 = g_master.xckk004
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xccc_t:15"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF  

   #S-FIN-6019 勾选的话是xccc中的销售出货就不含样品，样品的部分已经算到销售出货里面了，算销售费用时，需除去样品的费用
   LET l_sql2 = ''
   IF cl_get_para(g_enterprise,g_site,'S-FIN-6019') THEN
      LET l_sql2 = l_sql1 , " AND (xcck055 = '307' AND xcck020 <> '201') "   #201.銷售出庫
   ELSE
      LET l_sql2 = l_sql1 , " AND xcck055 = '307'"   #201.銷售出庫 
   END IF
   PREPARE axcq603_sel_pb4 FROM l_sql2
   EXECUTE axcq603_sel_pb4 
      INTO l_xckk.xckk103, l_xckk.xckk104, l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,
           l_xckk.xckk104d,l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcck_t:11"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF  
   #161109-00085#26-s mod
#   IF NOT axcq603_ins_xckk(l_xckk.*) THEN   #161109-00085#26-s mark
   IF NOT axcq603_ins_xckk(l_xckk.xckkent,l_xckk.xckkcomp,l_xckk.xckkld,l_xckk.xckk001,l_xckk.xckk002,
                           l_xckk.xckk003,l_xckk.xckk004,l_xckk.xckk005,l_xckk.xckk090,l_xckk.xckk101,
                           l_xckk.xckk102,l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,l_xckk.xckk102d,
                           l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h,l_xckk.xckk103,
                           l_xckk.xckk104,l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,l_xckk.xckk104d,
                           l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h,l_xckk.xckk105,
                           l_xckk.xckk106,l_xckk.xckk106a,l_xckk.xckk106b,l_xckk.xckk106c,l_xckk.xckk106d,
                           l_xckk.xckk106e,l_xckk.xckk106f,l_xckk.xckk106g,l_xckk.xckk106h) THEN
   #161109-00085#26-e mod
      LET r_success = FALSE
      RETURN r_success
   END IF     
   
   #总表抓xccc的本期盘盈亏的数量和金额，明细表抓xcck的本期盘盈亏的数量和金额，并写入xckk；有差异的按料号+特性+批号+成本域找出差异并写入xckl
   INITIALIZE l_xckk.* TO NULL
   LET l_xckk.xckk005 = '109'         #盘盈亏
   #总表抓xccc的本期盘盈亏的数量和金额
   SELECT SUM((CASE WHEN xccc311 IS NULL THEN 0  ELSE xccc311 END)), SUM((CASE WHEN xccc312 IS NULL THEN 0  ELSE xccc312 END)), 
          SUM((CASE WHEN xccc312a IS NULL THEN 0 ELSE xccc312a END)),SUM((CASE WHEN xccc312b IS NULL THEN 0 ELSE xccc312b END)),
          SUM((CASE WHEN xccc312c IS NULL THEN 0 ELSE xccc312c END)),SUM((CASE WHEN xccc312d IS NULL THEN 0 ELSE xccc312d END)),
          SUM((CASE WHEN xccc312e IS NULL THEN 0 ELSE xccc312e END)),SUM((CASE WHEN xccc312f IS NULL THEN 0 ELSE xccc312f END)),
          SUM((CASE WHEN xccc312g IS NULL THEN 0 ELSE xccc312g END)),SUM((CASE WHEN xccc312h IS NULL THEN 0 ELSE xccc312h END))
      INTO l_xckk.xckk101, l_xckk.xckk102, l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,
           l_xckk.xckk102d,l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h
   FROM xccc_t 
   WHERE xcccent = g_enterprise AND xcccld = g_master.xckkld AND xccccomp = g_master.xckkcomp
     AND xccc001 = g_master.xckk001 AND xccc003 = g_master.xckk002 
     AND xccc004 = g_master.xckk003 AND xccc005 = g_master.xckk004
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xccc_t:16"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF  
   #明细表抓xcck的本期盘盈亏的数量和金额
   LET l_xcck055 =  '311'   #盘盈亏
   EXECUTE axcq603_sel_pb1 USING l_xcck055
      INTO l_xckk.xckk103, l_xckk.xckk104, l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,
           l_xckk.xckk104d,l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcck_t:12"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF  
   #161109-00085#26-s mod
#   IF NOT axcq603_ins_xckk(l_xckk.*) THEN   #161109-00085#26-s mark
   IF NOT axcq603_ins_xckk(l_xckk.xckkent,l_xckk.xckkcomp,l_xckk.xckkld,l_xckk.xckk001,l_xckk.xckk002,
                           l_xckk.xckk003,l_xckk.xckk004,l_xckk.xckk005,l_xckk.xckk090,l_xckk.xckk101,
                           l_xckk.xckk102,l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,l_xckk.xckk102d,
                           l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h,l_xckk.xckk103,
                           l_xckk.xckk104,l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,l_xckk.xckk104d,
                           l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h,l_xckk.xckk105,
                           l_xckk.xckk106,l_xckk.xckk106a,l_xckk.xckk106b,l_xckk.xckk106c,l_xckk.xckk106d,
                           l_xckk.xckk106e,l_xckk.xckk106f,l_xckk.xckk106g,l_xckk.xckk106h) THEN
   #161109-00085#26-e mod
      LET r_success = FALSE
      RETURN r_success
   END IF     

   #总表抓xccc的本期调拨出库数量和金额，明细表抓xcck的本期调拨出库的数量和金额，并写入xckk；有差异的按料号+特性+批号+成本域找出差异并写入xckl
   INITIALIZE l_xckk.* TO NULL
   LET l_xckk.xckk005 = '119'         #调拨出库
   #总表抓xccc的本期调拨出库的数量和金额
   SELECT SUM((CASE WHEN xccc313 IS NULL THEN 0  ELSE xccc313 END)), SUM((CASE WHEN xccc314 IS NULL THEN 0  ELSE xccc314 END)), 
          SUM((CASE WHEN xccc314a IS NULL THEN 0 ELSE xccc314a END)),SUM((CASE WHEN xccc314b IS NULL THEN 0 ELSE xccc314b END)),
          SUM((CASE WHEN xccc314c IS NULL THEN 0 ELSE xccc314c END)),SUM((CASE WHEN xccc314d IS NULL THEN 0 ELSE xccc314d END)),
          SUM((CASE WHEN xccc314e IS NULL THEN 0 ELSE xccc314e END)),SUM((CASE WHEN xccc314f IS NULL THEN 0 ELSE xccc314f END)),
          SUM((CASE WHEN xccc314g IS NULL THEN 0 ELSE xccc314g END)),SUM((CASE WHEN xccc314h IS NULL THEN 0 ELSE xccc314h END))
      INTO l_xckk.xckk101, l_xckk.xckk102, l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,
           l_xckk.xckk102d,l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h
   FROM xccc_t 
   WHERE xcccent = g_enterprise AND xcccld = g_master.xckkld AND xccccomp = g_master.xckkcomp
     AND xccc001 = g_master.xckk001 AND xccc003 = g_master.xckk002 
     AND xccc004 = g_master.xckk003 AND xccc005 = g_master.xckk004
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xccc_t:17"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF  
   #明细表抓xcck的本期调拨出库的数量和金额
   # ('313','3131')   #其他出库（非月加权）、调拨出库(仅月加权）
   LET l_sql2 = ''
   #LET l_sql2 = l_sql1 , " AND xcck055 IN ('313','3131') "                             #170210-00001#1 mark
   #LET l_sql2 = l_sql2 , " AND xcck020 =   '401' "   #401.調撥 & inaj004 = '2(出项）'   #170210-00001#1 mark
   LET l_sql2 = l_sql1 , " AND xcck055 IN ('3132') "                                    #170210-00001#1 add
   PREPARE axcq603_sel_pb6 FROM l_sql2
   EXECUTE axcq603_sel_pb6
      INTO l_xckk.xckk103, l_xckk.xckk104, l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,
           l_xckk.xckk104d,l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcck_t:13"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF  
   #161109-00085#26-s mod
#   IF NOT axcq603_ins_xckk(l_xckk.*) THEN   #161109-00085#26-s mark
   IF NOT axcq603_ins_xckk(l_xckk.xckkent,l_xckk.xckkcomp,l_xckk.xckkld,l_xckk.xckk001,l_xckk.xckk002,
                           l_xckk.xckk003,l_xckk.xckk004,l_xckk.xckk005,l_xckk.xckk090,l_xckk.xckk101,
                           l_xckk.xckk102,l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,l_xckk.xckk102d,
                           l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h,l_xckk.xckk103,
                           l_xckk.xckk104,l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,l_xckk.xckk104d,
                           l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h,l_xckk.xckk105,
                           l_xckk.xckk106,l_xckk.xckk106a,l_xckk.xckk106b,l_xckk.xckk106c,l_xckk.xckk106d,
                           l_xckk.xckk106e,l_xckk.xckk106f,l_xckk.xckk106g,l_xckk.xckk106h) THEN
   #161109-00085#26-e mod
      LET r_success = FALSE
      RETURN r_success
   END IF
   LET l_sql2 = ''
   
   #总表和明细表都从xccc中抓金额并写入xckk中，无差异需处理。
   INITIALIZE l_xckk.* TO NULL
   LET l_xckk.xckk005 = '113'         #结存调整
   SELECT 0 , SUM((CASE WHEN xccc903 IS NULL THEN 0  ELSE xccc903 END)), 
          SUM((CASE WHEN xccc903a IS NULL THEN 0 ELSE xccc903a END)),SUM((CASE WHEN xccc903b IS NULL THEN 0 ELSE xccc903b END)),
          SUM((CASE WHEN xccc903c IS NULL THEN 0 ELSE xccc903c END)),SUM((CASE WHEN xccc903d IS NULL THEN 0 ELSE xccc903d END)),
          SUM((CASE WHEN xccc903e IS NULL THEN 0 ELSE xccc903e END)),SUM((CASE WHEN xccc903f IS NULL THEN 0 ELSE xccc903f END)),
          SUM((CASE WHEN xccc903g IS NULL THEN 0 ELSE xccc903g END)),SUM((CASE WHEN xccc903h IS NULL THEN 0 ELSE xccc903h END))
      INTO l_xckk.xckk101, l_xckk.xckk102, l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,
           l_xckk.xckk102d,l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h
   FROM xccc_t 
   WHERE xcccent = g_enterprise AND xcccld = g_master.xckkld AND xccccomp = g_master.xckkcomp
     AND xccc001 = g_master.xckk001 AND xccc003 = g_master.xckk002 
     AND xccc004 = g_master.xckk003 AND xccc005 = g_master.xckk004
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xccc_t:18"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF  
   LET l_xckk.xckk103 = l_xckk.xckk101
   LET l_xckk.xckk104 = l_xckk.xckk102
   LET l_xckk.xckk104a= l_xckk.xckk102a
   LET l_xckk.xckk104b= l_xckk.xckk102b
   LET l_xckk.xckk104c= l_xckk.xckk102c
   LET l_xckk.xckk104d= l_xckk.xckk102d
   LET l_xckk.xckk104e= l_xckk.xckk102e
   LET l_xckk.xckk104f= l_xckk.xckk102f
   LET l_xckk.xckk104g= l_xckk.xckk102g
   LET l_xckk.xckk104h= l_xckk.xckk102h
  
   #161109-00085#26-s mod
#   IF NOT axcq603_ins_xckk(l_xckk.*) THEN   #161109-00085#26-s mark
   IF NOT axcq603_ins_xckk(l_xckk.xckkent,l_xckk.xckkcomp,l_xckk.xckkld,l_xckk.xckk001,l_xckk.xckk002,
                           l_xckk.xckk003,l_xckk.xckk004,l_xckk.xckk005,l_xckk.xckk090,l_xckk.xckk101,
                           l_xckk.xckk102,l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,l_xckk.xckk102d,
                           l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h,l_xckk.xckk103,
                           l_xckk.xckk104,l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,l_xckk.xckk104d,
                           l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h,l_xckk.xckk105,
                           l_xckk.xckk106,l_xckk.xckk106a,l_xckk.xckk106b,l_xckk.xckk106c,l_xckk.xckk106d,
                           l_xckk.xckk106e,l_xckk.xckk106f,l_xckk.xckk106g,l_xckk.xckk106h) THEN
   #161109-00085#26-e mod
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #总表和明细表都从xccc中抓金额并写入xckk中，无差异需处理。   
   INITIALIZE l_xckk.* TO NULL
   LET l_xckk.xckk005 = '116'         #库存期末
   SELECT SUM((CASE WHEN xccc901 IS NULL THEN 0  ELSE xccc901 END)), SUM((CASE WHEN xccc902 IS NULL THEN 0  ELSE xccc902 END)), 
          SUM((CASE WHEN xccc902a IS NULL THEN 0 ELSE xccc902a END)),SUM((CASE WHEN xccc902b IS NULL THEN 0 ELSE xccc902b END)),
          SUM((CASE WHEN xccc902c IS NULL THEN 0 ELSE xccc902c END)),SUM((CASE WHEN xccc902d IS NULL THEN 0 ELSE xccc902d END)),
          SUM((CASE WHEN xccc902e IS NULL THEN 0 ELSE xccc902e END)),SUM((CASE WHEN xccc902f IS NULL THEN 0 ELSE xccc902f END)),
          SUM((CASE WHEN xccc902g IS NULL THEN 0 ELSE xccc902g END)),SUM((CASE WHEN xccc902h IS NULL THEN 0 ELSE xccc902h END))
      INTO l_xckk.xckk101, l_xckk.xckk102, l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,
           l_xckk.xckk102d,l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h
   FROM xccc_t 
   WHERE xcccent = g_enterprise AND xcccld = g_master.xckkld AND xccccomp = g_master.xckkcomp
     AND xccc001 = g_master.xckk001 AND xccc003 = g_master.xckk002 
     AND xccc004 = g_master.xckk003 AND xccc005 = g_master.xckk004
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xccc_t:19"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF  
   LET l_xckk.xckk103 = l_xckk.xckk101
   LET l_xckk.xckk104 = l_xckk.xckk102
   LET l_xckk.xckk104a= l_xckk.xckk102a
   LET l_xckk.xckk104b= l_xckk.xckk102b
   LET l_xckk.xckk104c= l_xckk.xckk102c
   LET l_xckk.xckk104d= l_xckk.xckk102d
   LET l_xckk.xckk104e= l_xckk.xckk102e
   LET l_xckk.xckk104f= l_xckk.xckk102f
   LET l_xckk.xckk104g= l_xckk.xckk102g
   LET l_xckk.xckk104h= l_xckk.xckk102h
  
   #161109-00085#26-s mod
#   IF NOT axcq603_ins_xckk(l_xckk.*) THEN   #161109-00085#26-s mark
   IF NOT axcq603_ins_xckk(l_xckk.xckkent,l_xckk.xckkcomp,l_xckk.xckkld,l_xckk.xckk001,l_xckk.xckk002,
                           l_xckk.xckk003,l_xckk.xckk004,l_xckk.xckk005,l_xckk.xckk090,l_xckk.xckk101,
                           l_xckk.xckk102,l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,l_xckk.xckk102d,
                           l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h,l_xckk.xckk103,
                           l_xckk.xckk104,l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,l_xckk.xckk104d,
                           l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h,l_xckk.xckk105,
                           l_xckk.xckk106,l_xckk.xckk106a,l_xckk.xckk106b,l_xckk.xckk106c,l_xckk.xckk106d,
                           l_xckk.xckk106e,l_xckk.xckk106f,l_xckk.xckk106g,l_xckk.xckk106h) THEN
   #161109-00085#26-e mod
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #总表抓xcce的非拆件工单的本期期初数量和金额，明细表抓上期的非拆件工单的xccb的数量和金额，并写入xckk；有差异的按在制单号(工单)找出差异并写入xckl
   INITIALIZE l_xckk.* TO NULL
   LET l_xckk.xckk005 = '215'         #在制开账调整
   #总表抓xcce的本期期初数量和金额
   SELECT SUM((CASE WHEN xcce101 IS NULL THEN 0 ELSE xcce101 END)),  SUM((CASE WHEN xcce102 IS NULL THEN 0 ELSE xcce102 END)), 
          SUM((CASE WHEN xcce102a IS NULL THEN 0 ELSE xcce102a END)),SUM((CASE WHEN xcce102b IS NULL THEN 0 ELSE xcce102b END)),
          SUM((CASE WHEN xcce102c IS NULL THEN 0 ELSE xcce102c END)),SUM((CASE WHEN xcce102d IS NULL THEN 0 ELSE xcce102d END)),
          SUM((CASE WHEN xcce102e IS NULL THEN 0 ELSE xcce102e END)),SUM((CASE WHEN xcce102f IS NULL THEN 0 ELSE xcce102f END)),
          SUM((CASE WHEN xcce102g IS NULL THEN 0 ELSE xcce102g END)),SUM((CASE WHEN xcce102h IS NULL THEN 0 ELSE xcce102h END))
      INTO l_xckk.xckk101, l_xckk.xckk102, l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,
           l_xckk.xckk102d,l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h
   FROM xcce_t 
   WHERE xcceent = g_enterprise AND xcceld = g_master.xckkld AND xccecomp = g_master.xckkcomp
     AND xcce001 = g_master.xckk001 AND xcce003 = g_master.xckk002 
     AND xcce004 = g_master.xckk003 AND xcce005 = g_master.xckk004
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcce_t:1"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
         
   #明细表抓上期的xccb的数量和金额
   SELECT SUM((CASE WHEN xccb101 IS NULL THEN 0 ELSE xccb101 END)),  SUM((CASE WHEN xccb102 IS NULL THEN 0 ELSE xccb102 END)), 
          SUM((CASE WHEN xccb102a IS NULL THEN 0 ELSE xccb102a END)),SUM((CASE WHEN xccb102b IS NULL THEN 0 ELSE xccb102b END)),
          SUM((CASE WHEN xccb102c IS NULL THEN 0 ELSE xccb102c END)),SUM((CASE WHEN xccb102d IS NULL THEN 0 ELSE xccb102d END)),
          SUM((CASE WHEN xccb102e IS NULL THEN 0 ELSE xccb102e END)),SUM((CASE WHEN xccb102f IS NULL THEN 0 ELSE xccb102f END)),
          SUM((CASE WHEN xccb102g IS NULL THEN 0 ELSE xccb102g END)),SUM((CASE WHEN xccb102h IS NULL THEN 0 ELSE xccb102h END))
      INTO l_xckk.xckk103, l_xckk.xckk104, l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,
           l_xckk.xckk104d,l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h
   FROM xccb_t , sfaa_t    #160719-00012#1  
   WHERE xccbent = g_enterprise AND xccbld = g_master.xckkld AND xccbcomp = g_master.xckkcomp
     AND xccb001 = g_master.xckk001 AND xccb003 = g_master.xckk002 
     AND xccb004 = g_previous_xckk003 AND xccb005 = g_previous_xckk004
     AND xccbent = sfaaent AND xccb006 = sfaadocno AND sfaa003 <> '3'  #非拆件工单  #160719-00012#1  
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xccb_t:1"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #161031-00037#1----s
   #抓不到抓上期的xcce的数据和金额
   IF (cl_null(l_xckk.xckk103)  OR l_xckk.xckk103 = 0) AND
      (cl_null(l_xckk.xckk104)  OR l_xckk.xckk104 = 0) AND
      (cl_null(l_xckk.xckk104a) OR l_xckk.xckk104a = 0) AND
      (cl_null(l_xckk.xckk104b) OR l_xckk.xckk104b = 0) AND
      (cl_null(l_xckk.xckk104c) OR l_xckk.xckk104c = 0) AND
      (cl_null(l_xckk.xckk104d) OR l_xckk.xckk104d = 0) AND
      (cl_null(l_xckk.xckk104e) OR l_xckk.xckk104e = 0) AND
      (cl_null(l_xckk.xckk104f) OR l_xckk.xckk104f = 0) AND
      (cl_null(l_xckk.xckk104g) OR l_xckk.xckk104g = 0) AND
      (cl_null(l_xckk.xckk104h) OR l_xckk.xckk104h = 0) THEN

      SELECT SUM((CASE WHEN xcce901 IS NULL THEN 0  ELSE xcce901 END)), SUM((CASE WHEN xcce902 IS NULL  THEN 0 ELSE xcce902 END)), 
             SUM((CASE WHEN xcce902a IS NULL THEN 0 ELSE xcce902a END)),SUM((CASE WHEN xcce902b IS NULL THEN 0 ELSE xcce902b END)),
             SUM((CASE WHEN xcce902c IS NULL THEN 0 ELSE xcce902c END)),SUM((CASE WHEN xcce902d IS NULL THEN 0 ELSE xcce902d END)),
             SUM((CASE WHEN xcce902e IS NULL THEN 0 ELSE xcce902e END)),SUM((CASE WHEN xcce902f IS NULL THEN 0 ELSE xcce902f END)),
             SUM((CASE WHEN xcce902g IS NULL THEN 0 ELSE xcce902g END)),SUM((CASE WHEN xcce902h IS NULL THEN 0 ELSE xcce902h END))
         INTO l_xckk.xckk103, l_xckk.xckk104, l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,
              l_xckk.xckk104d,l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h
      FROM xcce_t 
      WHERE xcceent = g_enterprise AND xcceld = g_master.xckkld AND xccecomp = g_master.xckkcomp
        AND xcce001 = g_master.xckk001 AND xcce003 = g_master.xckk002 
        AND xcce004 = g_previous_xckk003 AND xcce005 = g_previous_xckk004
      
      IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xcce_t:2"
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
   ELSE      
   #161031-00037#1---e
      LET g_source = 'xccb'      #標記明細表的來源   
   END IF  #161031-00037#1 add
   
   
   #161109-00085#26-s mod
#   IF NOT axcq603_ins_xckk(l_xckk.*) THEN   #161109-00085#26-s mark
   IF NOT axcq603_ins_xckk(l_xckk.xckkent,l_xckk.xckkcomp,l_xckk.xckkld,l_xckk.xckk001,l_xckk.xckk002,
                           l_xckk.xckk003,l_xckk.xckk004,l_xckk.xckk005,l_xckk.xckk090,l_xckk.xckk101,
                           l_xckk.xckk102,l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,l_xckk.xckk102d,
                           l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h,l_xckk.xckk103,
                           l_xckk.xckk104,l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,l_xckk.xckk104d,
                           l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h,l_xckk.xckk105,
                           l_xckk.xckk106,l_xckk.xckk106a,l_xckk.xckk106b,l_xckk.xckk106c,l_xckk.xckk106d,
                           l_xckk.xckk106e,l_xckk.xckk106f,l_xckk.xckk106g,l_xckk.xckk106h) THEN
   #161109-00085#26-e mod
      LET r_success = FALSE
      RETURN r_success
   END IF
   LET g_source = ''      #標記明細表的來源
   
   #总表抓xcce的非拆件工单的本期期初数量和金额，明细表抓xcce的上期非拆件工单的期末数量和金额，抓不到抓上期的非拆件工单的xccb的数据和金额，并写入xckk；有差异的按在制单号(工单)找出差异并写入xckl
   INITIALIZE l_xckk.* TO NULL
   LET l_xckk.xckk005 = '201'         #在制期初
   #总表抓xcce的本期期初数量和金额
   SELECT SUM((CASE WHEN xcce101 IS NULL THEN 0 ELSE xcce101 END)),  SUM((CASE WHEN xcce102 IS NULL THEN 0 ELSE xcce102 END)), 
          SUM((CASE WHEN xcce102a IS NULL THEN 0 ELSE xcce102a END)),SUM((CASE WHEN xcce102b IS NULL THEN 0 ELSE xcce102b END)),
          SUM((CASE WHEN xcce102c IS NULL THEN 0 ELSE xcce102c END)),SUM((CASE WHEN xcce102d IS NULL THEN 0 ELSE xcce102d END)),
          SUM((CASE WHEN xcce102e IS NULL THEN 0 ELSE xcce102e END)),SUM((CASE WHEN xcce102f IS NULL THEN 0 ELSE xcce102f END)),
          SUM((CASE WHEN xcce102g IS NULL THEN 0 ELSE xcce102g END)),SUM((CASE WHEN xcce102h IS NULL THEN 0 ELSE xcce102h END))
      INTO l_xckk.xckk101, l_xckk.xckk102, l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,
           l_xckk.xckk102d,l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h
   FROM xcce_t 
   WHERE xcceent = g_enterprise AND xcceld = g_master.xckkld AND xccecomp = g_master.xckkcomp
     AND xcce001 = g_master.xckk001 AND xcce003 = g_master.xckk002 
     AND xcce004 = g_master.xckk003 AND xcce005 = g_master.xckk004 
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcce_t:2"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #161031-00037#1---s
   ##抓xcce的上期期末数量和金额
   #SELECT SUM((CASE WHEN xcce901 IS NULL THEN 0 ELSE xcce901 END)),  SUM((CASE WHEN xcce902 IS NULL THEN 0 ELSE xcce902 END)), 
   #       SUM((CASE WHEN xcce902a IS NULL THEN 0 ELSE xcce902a END)),SUM((CASE WHEN xcce902b IS NULL THEN 0 ELSE xcce902b END)),
   #       SUM((CASE WHEN xcce902c IS NULL THEN 0 ELSE xcce902c END)),SUM((CASE WHEN xcce902d IS NULL THEN 0 ELSE xcce902d END)),
   #       SUM((CASE WHEN xcce902e IS NULL THEN 0 ELSE xcce902e END)),SUM((CASE WHEN xcce902f IS NULL THEN 0 ELSE xcce902f END)),
   #       SUM((CASE WHEN xcce902g IS NULL THEN 0 ELSE xcce902g END)),SUM((CASE WHEN xcce902h IS NULL THEN 0 ELSE xcce902h END))
   SELECT SUM((CASE WHEN xccb101 IS NULL THEN 0 ELSE xccb101 END)),  SUM((CASE WHEN xccb102 IS NULL THEN 0 ELSE xccb102 END)), 
          SUM((CASE WHEN xccb102a IS NULL THEN 0 ELSE xccb102a END)),SUM((CASE WHEN xccb102b IS NULL THEN 0 ELSE xccb102b END)),
          SUM((CASE WHEN xccb102c IS NULL THEN 0 ELSE xccb102c END)),SUM((CASE WHEN xccb102d IS NULL THEN 0 ELSE xccb102d END)),
          SUM((CASE WHEN xccb102e IS NULL THEN 0 ELSE xccb102e END)),SUM((CASE WHEN xccb102f IS NULL THEN 0 ELSE xccb102f END)),
          SUM((CASE WHEN xccb102g IS NULL THEN 0 ELSE xccb102g END)),SUM((CASE WHEN xccb102h IS NULL THEN 0 ELSE xccb102h END))       
   #161031-00037#1---e   
      INTO l_xckk.xckk103, l_xckk.xckk104, l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,
           l_xckk.xckk104d,l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h
   #161031-00037#1---s
   #FROM xcce_t 
   #WHERE xcceent = g_enterprise AND xcceld = g_master.xckkld AND xccecomp = g_master.xckkcomp
   #  AND xcce001 = g_master.xckk001 AND xcce003 = g_master.xckk002 
   #  AND xcce004 = g_previous_xckk003 AND xcce005 = g_previous_xckk004
   FROM xccb_t , sfaa_t 
   WHERE xccbent = g_enterprise AND xccbld = g_master.xckkld AND xccbcomp = g_master.xckkcomp
     AND xccb001 = g_master.xckk001 AND xccb003 = g_master.xckk002 
     AND xccb004 = g_previous_xckk003 AND xccb005 = g_previous_xckk004
     AND xccbent = sfaaent AND xccb006 = sfaadocno AND sfaa003 <> '3'  #非拆件工单
   #161031-00037#1---e   
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcce_t:3"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #抓不到抓上期的xccb的数据和金额
   IF (cl_null(l_xckk.xckk103)  OR l_xckk.xckk103 = 0) AND
      (cl_null(l_xckk.xckk104)  OR l_xckk.xckk104 = 0) AND
      (cl_null(l_xckk.xckk104a) OR l_xckk.xckk104a = 0) AND
      (cl_null(l_xckk.xckk104b) OR l_xckk.xckk104b = 0) AND
      (cl_null(l_xckk.xckk104c) OR l_xckk.xckk104c = 0) AND
      (cl_null(l_xckk.xckk104d) OR l_xckk.xckk104d = 0) AND
      (cl_null(l_xckk.xckk104e) OR l_xckk.xckk104e = 0) AND
      (cl_null(l_xckk.xckk104f) OR l_xckk.xckk104f = 0) AND
      (cl_null(l_xckk.xckk104g) OR l_xckk.xckk104g = 0) AND
      (cl_null(l_xckk.xckk104h) OR l_xckk.xckk104h = 0) THEN
      #161031-00037#1---S
      #明细表抓上期的xccb的数量和金额
      #SELECT SUM((CASE WHEN xccb101 IS NULL THEN 0 ELSE xccb101 END)),  SUM((CASE WHEN xccb102 IS NULL THEN 0 ELSE xccb102 END)), 
      #       SUM((CASE WHEN xccb102a IS NULL THEN 0 ELSE xccb102a END)),SUM((CASE WHEN xccb102b IS NULL THEN 0 ELSE xccb102b END)),
      #       SUM((CASE WHEN xccb102c IS NULL THEN 0 ELSE xccb102c END)),SUM((CASE WHEN xccb102d IS NULL THEN 0 ELSE xccb102d END)),
      #       SUM((CASE WHEN xccb102e IS NULL THEN 0 ELSE xccb102e END)),SUM((CASE WHEN xccb102f IS NULL THEN 0 ELSE xccb102f END)),
      #       SUM((CASE WHEN xccb102g IS NULL THEN 0 ELSE xccb102g END)),SUM((CASE WHEN xccb102h IS NULL THEN 0 ELSE xccb102h END))
      SELECT SUM((CASE WHEN xcce901 IS NULL THEN 0 ELSE xcce901 END)),  SUM((CASE WHEN xcce902 IS NULL THEN 0 ELSE xcce902 END)), 
             SUM((CASE WHEN xcce902a IS NULL THEN 0 ELSE xcce902a END)),SUM((CASE WHEN xcce902b IS NULL THEN 0 ELSE xcce902b END)),
             SUM((CASE WHEN xcce902c IS NULL THEN 0 ELSE xcce902c END)),SUM((CASE WHEN xcce902d IS NULL THEN 0 ELSE xcce902d END)),
             SUM((CASE WHEN xcce902e IS NULL THEN 0 ELSE xcce902e END)),SUM((CASE WHEN xcce902f IS NULL THEN 0 ELSE xcce902f END)),
             SUM((CASE WHEN xcce902g IS NULL THEN 0 ELSE xcce902g END)),SUM((CASE WHEN xcce902h IS NULL THEN 0 ELSE xcce902h END))   
      #161031-00037#1---e   
         INTO l_xckk.xckk103, l_xckk.xckk104, l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,
              l_xckk.xckk104d,l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h
      #161031-00037#1---s
      #FROM xccb_t , sfaa_t 
      #WHERE xccbent = g_enterprise AND xccbld = g_master.xckkld AND xccbcomp = g_master.xckkcomp
      #  AND xccb001 = g_master.xckk001 AND xccb003 = g_master.xckk002 
      #  AND xccb004 = g_previous_xckk003 AND xccb005 = g_previous_xckk004
      #  AND xccbent = sfaaent AND xccb006 = sfaadocno AND sfaa003 <> '3'  #非拆件工单
      FROM xcce_t 
       WHERE xcceent = g_enterprise AND xcceld = g_master.xckkld AND xccecomp = g_master.xckkcomp
         AND xcce001 = g_master.xckk001 AND xcce003 = g_master.xckk002 
         AND xcce004 = g_previous_xckk003 AND xcce005 = g_previous_xckk004
      #161031-00037#1---e
      IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xccb_t:2"
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
   ELSE   #161031-00037#1
      LET g_source = 'xccb'      #標記明細表的來源
   END IF
   
   #161109-00085#26-s mod
#   IF NOT axcq603_ins_xckk(l_xckk.*) THEN   #161109-00085#26-s mark
   IF NOT axcq603_ins_xckk(l_xckk.xckkent,l_xckk.xckkcomp,l_xckk.xckkld,l_xckk.xckk001,l_xckk.xckk002,
                           l_xckk.xckk003,l_xckk.xckk004,l_xckk.xckk005,l_xckk.xckk090,l_xckk.xckk101,
                           l_xckk.xckk102,l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,l_xckk.xckk102d,
                           l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h,l_xckk.xckk103,
                           l_xckk.xckk104,l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,l_xckk.xckk104d,
                           l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h,l_xckk.xckk105,
                           l_xckk.xckk106,l_xckk.xckk106a,l_xckk.xckk106b,l_xckk.xckk106c,l_xckk.xckk106d,
                           l_xckk.xckk106e,l_xckk.xckk106f,l_xckk.xckk106g,l_xckk.xckk106h) THEN
   #161109-00085#26-e mod
      LET r_success = FALSE
      RETURN r_success
   END IF
   LET g_source = ''  
   
   #总表抓xcce的非拆件工单的本期投入数量和金额（元件排除DL+OH+SUB，料件类别是原料），明细表抓xcck的非拆件工单工单发料数量和金额，并写入xckk（排除拆件且元件排除DL+OH+SUB，料件类别是原料）；
   #有差异的按在制单号(工单)找出差异并写入xckl
   INITIALIZE l_xckk.* TO NULL
   LET l_xckk.xckk005 = '216'         #原料投入
   #161031-00037#1---s
   #SELECT SUM(CASE imaa004 WHEN 'M' THEN xcce201+xcce205+xcce207+xcce209 ELSE 0 END),    SUM(CASE imaa004 WHEN 'M' THEN xcce202+xcce206+xcce208+xcce210 ELSE 0 END),
   #       SUM(CASE imaa004 WHEN 'M' THEN xcce202a+xcce206a+xcce208a+xcce210a ELSE 0 END),SUM(CASE imaa004 WHEN 'M' THEN xcce202b+xcce206b+xcce208b+xcce210b ELSE 0 END),
	#       SUM(CASE imaa004 WHEN 'M' THEN xcce202c+xcce206c+xcce208c+xcce210c ELSE 0 END),SUM(CASE imaa004 WHEN 'M' THEN xcce202d+xcce206d+xcce208d+xcce210d ELSE 0 END),
   #       SUM(CASE imaa004 WHEN 'M' THEN xcce202e+xcce206e+xcce208e+xcce210e ELSE 0 END),SUM(CASE imaa004 WHEN 'M' THEN xcce202f+xcce206f+xcce208f+xcce210f ELSE 0 END),
	#       SUM(CASE imaa004 WHEN 'M' THEN xcce202g+xcce206g+xcce208g+xcce210g ELSE 0 END),SUM(CASE imaa004 WHEN 'M' THEN xcce202h+xcce206h+xcce208h+xcce210h ELSE 0 END)
	SELECT SUM(xcce201+xcce205+xcce207+xcce209),    SUM(xcce202+xcce206+xcce208+xcce210),
          SUM(xcce202a+xcce206a+xcce208a+xcce210a),SUM(xcce202b+xcce206b+xcce208b+xcce210b),
	       SUM(xcce202c+xcce206c+xcce208c+xcce210c),SUM(xcce202d+xcce206d+xcce208d+xcce210d),
          SUM(xcce202e+xcce206e+xcce208e+xcce210e),SUM(xcce202f+xcce206f+xcce208f+xcce210f),
	       SUM(xcce202g+xcce206g+xcce208g+xcce210g),SUM(xcce202h+xcce206h+xcce208h+xcce210h)       
   #161031-00037#1---e   
      INTO l_xckk.xckk101, l_xckk.xckk102, l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,
           l_xckk.xckk102d,l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h
   FROM xcce_t,imaa_t  
   WHERE xcceent = g_enterprise AND xcceld = g_master.xckkld AND xccecomp = g_master.xckkcomp
     AND xcce001 = g_master.xckk001 AND xcce003 = g_master.xckk002 
     AND xcce004 = g_master.xckk003 AND xcce005 = g_master.xckk004
     AND xcceent = imaaent AND xcce007  = imaa001 AND xcce007 <> 'DL+OH+SUB'
     AND imaa004 <> 'A'  #161031-00037#1
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcce_t:4"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #明细表抓xcck的本期投入的数量和金额
   LET l_sql2 = ''
   #LET l_sql2 = l_sql1 , " AND xcck055 = '301' AND xcck020 <> '113'"  #xcck里的工单发料，排除拆件  #160531-00032#1
  #LET l_sql2 = l_sql1 , " AND xcck055 = '3012' AND xcck020 <> '113'"  #xcck里的工单发料，排除拆件  #160531-00032#1 #170216-00080#1 mark 
   LET l_sql2 = l_sql1 , " AND xcck055 IN ('3012','207') AND xcck020 <> '113'"  #xcck里的工单发料，排除拆件 #170216-00080#1 add
   #元件排除DL+OH+SUB，料件类别是原料
   #LET l_sql2 = l_sql2 , " AND xcck010 IN (SELECT imaa001 FROM imaa_t WHERE imaaent = '",g_enterprise,"' AND imaa004  = 'M') AND xcck010 <> 'DL+OH+SUB' "    #161031-00037#1
   LET l_sql2 = l_sql2 , " AND xcck010 IN (SELECT imaa001 FROM imaa_t WHERE imaaent = '",g_enterprise,"' AND imaa004  <> 'A') AND xcck010 <> 'DL+OH+SUB' "    #161031-00037#1

   PREPARE axcq603_sel_pb7 FROM l_sql2
   EXECUTE axcq603_sel_pb7
      INTO l_xckk.xckk103, l_xckk.xckk104, l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,
           l_xckk.xckk104d,l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcck_t:14"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF  
   #161109-00085#26-s mod
#   IF NOT axcq603_ins_xckk(l_xckk.*) THEN   #161109-00085#26-s mark
   IF NOT axcq603_ins_xckk(l_xckk.xckkent,l_xckk.xckkcomp,l_xckk.xckkld,l_xckk.xckk001,l_xckk.xckk002,
                           l_xckk.xckk003,l_xckk.xckk004,l_xckk.xckk005,l_xckk.xckk090,l_xckk.xckk101,
                           l_xckk.xckk102,l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,l_xckk.xckk102d,
                           l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h,l_xckk.xckk103,
                           l_xckk.xckk104,l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,l_xckk.xckk104d,
                           l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h,l_xckk.xckk105,
                           l_xckk.xckk106,l_xckk.xckk106a,l_xckk.xckk106b,l_xckk.xckk106c,l_xckk.xckk106d,
                           l_xckk.xckk106e,l_xckk.xckk106f,l_xckk.xckk106g,l_xckk.xckk106h) THEN
   #161109-00085#26-e mod
      LET r_success = FALSE
      RETURN r_success
   END IF
   LET l_sql2 = ''
   
   #总表抓xcce的非拆件工单的本期投入数量和金额（元件排除DL+OH+SUB，料件类别是半成品），明细表抓xcck的非拆件工单工单发料数量和金额，并写入xckk（排除拆件且元件排除DL+OH+SUB，料件类别是半成品）；
   #有差异的按在制单号(工单)找出差异并写入xckl
   INITIALIZE l_xckk.* TO NULL
   LET l_xckk.xckk005 = '217'         #半成品投入
   SELECT SUM(CASE imaa004 WHEN 'A' THEN xcce201+xcce205+xcce207+xcce209 ELSE 0 END),    SUM(CASE imaa004 WHEN 'A' THEN xcce202+xcce206+xcce208+xcce210 ELSE 0 END),
          SUM(CASE imaa004 WHEN 'A' THEN xcce202a+xcce206a+xcce208a+xcce210a ELSE 0 END),SUM(CASE imaa004 WHEN 'A' THEN xcce202b+xcce206b+xcce208b+xcce210b ELSE 0 END),
	       SUM(CASE imaa004 WHEN 'A' THEN xcce202c+xcce206c+xcce208c+xcce210c ELSE 0 END),SUM(CASE imaa004 WHEN 'A' THEN xcce202d+xcce206d+xcce208d+xcce210d ELSE 0 END),
          SUM(CASE imaa004 WHEN 'A' THEN xcce202e+xcce206e+xcce208e+xcce210e ELSE 0 END),SUM(CASE imaa004 WHEN 'A' THEN xcce202f+xcce206f+xcce208f+xcce210f ELSE 0 END),
	       SUM(CASE imaa004 WHEN 'A' THEN xcce202g+xcce206g+xcce208g+xcce210g ELSE 0 END),SUM(CASE imaa004 WHEN 'A' THEN xcce202h+xcce206h+xcce208h+xcce210h ELSE 0 END)
      INTO l_xckk.xckk101, l_xckk.xckk102, l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,
           l_xckk.xckk102d,l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h
   FROM xcce_t,imaa_t  
   WHERE xcceent = g_enterprise AND xcceld = g_master.xckkld AND xccecomp = g_master.xckkcomp
     AND xcce001 = g_master.xckk001 AND xcce003 = g_master.xckk002 
     AND xcce004 = g_master.xckk003 AND xcce005 = g_master.xckk004
     AND xcceent = imaaent AND xcce007  = imaa001 AND xcce007 <> 'DL+OH+SUB'
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcce_t:5"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #明细表抓xcck的本期投入的数量和金额
   LET l_sql2 = ''
   #LET l_sql2 = l_sql1 , " AND xcck055 = '301' AND xcck020 <> '113'"  #xcck里的工单发料，排除拆件   #160531-00032#1
   #LET l_sql2 = l_sql1 , " AND xcck055 = '3012' AND xcck020 <> '113'"  #xcck里的工单发料，排除拆件   #160531-00032#1  #161031-00037#1
   LET l_sql2 = l_sql1 , " AND xcck055 IN ('207','3012') AND xcck020 <> '113'"  #xcck里的工单发料，排除拆件   #160531-00032#1  #161031-00037#1
   #元件排除DL+OH+SUB，料件类别是半成品
   LET l_sql2 = l_sql2 , " AND xcck010 IN (SELECT imaa001 FROM imaa_t WHERE imaaent = '",g_enterprise,"' AND imaa004  = 'A') AND xcck010 <> 'DL+OH+SUB' " 
   PREPARE axcq603_sel_pb8 FROM l_sql2
   EXECUTE axcq603_sel_pb8
      INTO l_xckk.xckk103, l_xckk.xckk104, l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,
           l_xckk.xckk104d,l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcck_t:15"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF  
   #161109-00085#26-s mod
#   IF NOT axcq603_ins_xckk(l_xckk.*) THEN   #161109-00085#26-s mark
   IF NOT axcq603_ins_xckk(l_xckk.xckkent,l_xckk.xckkcomp,l_xckk.xckkld,l_xckk.xckk001,l_xckk.xckk002,
                           l_xckk.xckk003,l_xckk.xckk004,l_xckk.xckk005,l_xckk.xckk090,l_xckk.xckk101,
                           l_xckk.xckk102,l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,l_xckk.xckk102d,
                           l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h,l_xckk.xckk103,
                           l_xckk.xckk104,l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,l_xckk.xckk104d,
                           l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h,l_xckk.xckk105,
                           l_xckk.xckk106,l_xckk.xckk106a,l_xckk.xckk106b,l_xckk.xckk106c,l_xckk.xckk106d,
                           l_xckk.xckk106e,l_xckk.xckk106f,l_xckk.xckk106g,l_xckk.xckk106h) THEN
   #161109-00085#26-e mod
      LET r_success = FALSE
      RETURN r_success
   END IF
   LET l_sql2 = ''
   
   #总表抓xcce的非拆件工单的本期元件=DL+OH+SUB投入的金额，明细表抓xcbk的非拆件工单人工金额，并写入xckk；有差异的按在制单号(工单)找出差异并写入xckl
   INITIALIZE l_xckk.* TO NULL
   LET l_xckk.xckk005 = '200'         #在制人工费
   SELECT 0,  #数量
          SUM(CASE xcce007 WHEN 'DL+OH+SUB' THEN xcce202 - xcce202a ELSE 0 END), #在製總投入 - 材料投入
          0, #材料投入
          SUM(CASE xcce007 WHEN 'DL+OH+SUB' THEN xcce202b ELSE 0 END),SUM(CASE xcce007 WHEN 'DL+OH+SUB' THEN xcce202c ELSE 0 END),
          SUM(CASE xcce007 WHEN 'DL+OH+SUB' THEN xcce202d ELSE 0 END),SUM(CASE xcce007 WHEN 'DL+OH+SUB' THEN xcce202e ELSE 0 END),
          SUM(CASE xcce007 WHEN 'DL+OH+SUB' THEN xcce202f ELSE 0 END),SUM(CASE xcce007 WHEN 'DL+OH+SUB' THEN xcce202g ELSE 0 END),
          SUM(CASE xcce007 WHEN 'DL+OH+SUB' THEN xcce202h ELSE 0 END)
      INTO l_xckk.xckk101, l_xckk.xckk102, l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,
           l_xckk.xckk102d,l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h
   FROM xcce_t
   WHERE xcceent = g_enterprise AND xcceld = g_master.xckkld AND xccecomp = g_master.xckkcomp
     AND xcce001 = g_master.xckk001 AND xcce003 = g_master.xckk002 
     AND xcce004 = g_master.xckk003 AND xcce005 = g_master.xckk004
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcce_t:6"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #明细表抓xcbk的非拆件工单人工金额
   LET l_xckk.xckk103 = 0
   CASE g_master.xckk001 
      WHEN '1'  #本位币一
         LET l_sql = " SELECT SUM(xcbk202) "
      WHEN '2'  #本位币二
         LET l_sql = " SELECT SUM(xcbk212) "
      WHEN '3'  #本位币三
         LET l_sql = " SELECT SUM(xcbk222) "
      OTHERWISE
         LET l_sql = " SELECT SUM(xcbk202) "
   END CASE
   LET l_sql = l_sql, " FROM xcbk_t,sfaa_t ",  
               "   WHERE xcbkent = '",g_enterprise,"' AND xcbkld = '",g_master.xckkld,"' ",
               "     AND xcbkcomp = '",g_master.xckkcomp,"' AND xcbk001 = '",g_master.xckk002,"' ",
               "     AND xcbk002 = ",g_master.xckk003," AND xcbk003 = ",g_master.xckk004,
               "     AND xcbkent = sfaaent AND xcbk006 = sfaadocno AND sfaa003 <> '3' ", #非拆件工单  
               "     AND xcbk005 = ? "
   PREPARE axcq603_sel_xcbk FROM l_sql
   LET l_xckk.xckk104a = 0  #材料投入
   LET l_xcbk005 = '1'  #人工
   EXECUTE axcq603_sel_xcbk USING l_xcbk005 INTO l_xckk.xckk104b
   #明细表抓xcck的非拆件委外工单的委外加工金额
   #加工
   LET l_xckk.xckk104c = 0
   #161031-00037#1--s
   #参照axcq528抓取
   #xcck055先选择工单领用，再通过xcck006参考单号去关联工单类型(关联制程档里)有个委外否
   #SELECT SUM((CASE WHEN xcck202c  IS NULL THEN 0 ELSE xcck202c  END)* xcck009) INTO l_xckk.xckk104c
   #  #FROM xcck_t , sfcb_t  #160531-00032#1
   #  FROM xcck_t , sfcb_t ,sfec_t #160531-00032#1
   #  WHERE xcckent = g_enterprise AND xcckld = g_master.xckkld AND xcckcomp = g_master.xckkcomp
   #    AND xcck001 = g_master.xckk001 AND xcck003 = g_master.xckk002
   #    AND xcck004 = g_master.xckk003 AND xcck005 = g_master.xckk004
   #    #AND xcck055 = '301' AND xcck020 <> '113'  #xcck里的工单发料，排除拆件  #160531-00032#1
   #    AND xcck055 = '3012' AND xcck020 <> '113'  #xcck里的工单发料，排除拆件  #160531-00032#1
   #    #AND xcckent = sfcbent AND xcck006 = sfcbdocno AND sfcb012 = 'Y' #委外否 #160531-00032#1
   #    AND xcckent = sfecent  AND xcck006 = sfecdocno AND sfecent = sfcbent AND sfec001 = sfcbdocno AND sfcb012 = 'Y' #委外否 #160531-00032#1
  #170216-00080#1 ---mark (s)---  
  #SELECT SUM(CASE apcb001 WHEN '21' THEN apcb113*(-1) ELSE apcb113 END) INTO l_xckk.xckk104c FROM apca_t,apcb_t,pmds_t,pmdt_t
  #     WHERE apcaent = apcbent AND apcald = apcbld AND apcadocno = apcbdocno 
  #       AND pmdsent = pmdtent AND pmdsdocno = pmdtdocno AND pmdsstus = 'S'
  #       AND pmds011 = '2' AND pmds000 IN ('12','14','20')
  #      #AND pmdsdocdt BETWEEN g_bdate AND g_edate  #170210-00001#1 mark
  #       AND pmds001 BETWEEN g_bdate AND g_edate    #170210-00001#1 add
  #       AND pmds037 = g_curr AND pmdtsite = pmdssite 
  #       AND apcaent = g_enterprise AND pmdsent = apcaent
  #       AND apcald = g_master.xckkld
  #       AND apcastus = 'Y' AND apcb001 IN ('11','21')
  #       AND apcb023 = 'N'
  #       AND apcb002 = pmdtdocno AND apcb003=pmdtseq
  #       AND pmdt001 IS NOT NULL                    #170210-00001#1 add
  #161031-00037#1---e
  #170216-00080#1 ---mark (e)---
  #170216-00080#1 ---add (s)---
   CASE g_master.xckk001
      WHEN '1'  #本位币一
         LET l_sql = " SELECT SUM(CASE apcb001 WHEN '21' THEN apcb113*(-1) ELSE apcb113 END) "
      WHEN '2'  #本位币二
         LET l_sql = " SELECT SUM(CASE apcb001 WHEN '21' THEN apcb123*(-1) ELSE apcb123 END) "
      WHEN '3'  #本位币三
         LET l_sql = " SELECT SUM(CASE apcb001 WHEN '21' THEN apcb133*(-1) ELSE apcb133 END) "
      OTHERWISE
         LET l_sql = " SELECT SUM(CASE apcb001 WHEN '21' THEN apcb113*(-1) ELSE apcb113 END) "
   END CASE
   #LET l_sql = l_sql, " FROM apca_t,apcb_t,pmds_t,pmdt_t ",  #170306-00029#1  mark
   #170313-00012#1---mark---s                   
   #LET l_sql = l_sql, " FROM apca_t,apcb_t,pmds_t,pmdt_t,pmdv_t,sfaa_t ",  #170306-00029#1 add
   #                   " WHERE apcaent = apcbent AND apcald = apcbld AND apcadocno = apcbdocno ",
   #                        "   AND pmdsent = pmdtent AND pmdsdocno = pmdtdocno AND pmdssite = pmdtsite  ",
   #                        "   AND apcbent = pmdtent AND apcb002 = pmdtdocno AND apcb003 = pmdtseq ",
   #                        "   AND pmdtent = pmdvent AND pmdtdocno = pmdvdocno AND pmdtseq = pmdvseq ",  #170306-00029#1 add
	#                        "   AND pmdvent = sfaaent AND pmdv014 = sfaadocno ",                          #170306-00029#1 add     
   #                        "   AND pmds000 IN ('12','14','20') AND pmds011 = '2'  AND pmdsstus = 'S' ",
   #                        "   AND pmds001 BETWEEN '",g_bdate,"' AND '",g_edate,"' ",
   #                        "   AND apcaent = ",g_enterprise,
   #                   "   AND apcald = '",g_master.xckkld,"'",
   #                   "   AND apcastus = 'Y' AND apcb001 IN ('11','21') ",
   #                   "   AND apcb023 = 'N'AND pmdt001 IS NOT NULL ",
   #                   "   AND sfaa003 <> '3' "    #170306-00029#1 add  
   #170313-00012#1---mark---e                   
   #170313-00012#1---add---s
   LET l_sql = l_sql, " FROM apca_t,apcb_t,pmds_t,pmdt_t,pmdp_t,sfaa_t ", 
                      " WHERE apcaent = apcbent AND apcald = apcbld AND apcadocno = apcbdocno ",
                      "   AND pmdsent = pmdtent AND pmdsdocno = pmdtdocno AND pmdssite = pmdtsite  ",
                      "   AND apcbent = pmdtent AND apcb002 = pmdtdocno AND apcb003 = pmdtseq ",
                      "   AND pmdtent = pmdpent AND pmdt001 = pmdpdocno AND pmdt002 = pmdpseq AND pmdt003 = pmdpseq1 ",  
	                   "   AND pmdpent = sfaaent AND pmdp003 = sfaadocno ",                             
                      "   AND pmds000 IN ('12','14','20') AND pmds011 = '2'  AND pmdsstus = 'S' ",
                      "   AND pmds001 BETWEEN '",g_bdate,"' AND '",g_edate,"' ",
                      "   AND pmds037 = '",g_curr,"'",   
                      "   AND apcaent = ",g_enterprise,
                      "   AND apcald = '",g_master.xckkld,"'",
                      "   AND apcastus = 'Y' AND apcb001 IN ('11','21') ",
                      "   AND apcb023 = 'N'AND pmdt001 IS NOT NULL ",
                      "   AND sfaa003 <> '3' "     
   #170313-00012#1---add---e                   
   PREPARE axcq603_sel_apcb FROM l_sql
   EXECUTE axcq603_sel_apcb INTO l_xckk.xckk104c
   #170216-00080#1 ---add (e)---
   
   LET l_xcbk005 = '2'  #製費一
   EXECUTE axcq603_sel_xcbk USING l_xcbk005 INTO l_xckk.xckk104d
   LET l_xcbk005 = '3'  #製費二
   EXECUTE axcq603_sel_xcbk USING l_xcbk005 INTO l_xckk.xckk104e
   LET l_xcbk005 = '4'  #製費三
   EXECUTE axcq603_sel_xcbk USING l_xcbk005 INTO l_xckk.xckk104f
   LET l_xcbk005 = '5'  #製費四
   EXECUTE axcq603_sel_xcbk USING l_xcbk005 INTO l_xckk.xckk104g
   LET l_xcbk005 = '6'  #製費五
   EXECUTE axcq603_sel_xcbk USING l_xcbk005 INTO l_xckk.xckk104h
   #160531-00032#1----s
   IF cl_null(l_xckk.xckk104b) THEN
      LET l_xckk.xckk104b = 0
   END IF
   #170216-00080 ---add (s)---
   IF cl_null(l_xckk.xckk104c) THEN
      LET l_xckk.xckk104c = 0
   END IF
   #170216-00080 ---add (e)---
   IF cl_null(l_xckk.xckk104d) THEN
      LET l_xckk.xckk104d = 0
   END IF
   IF cl_null(l_xckk.xckk104e) THEN
      LET l_xckk.xckk104e = 0
   END IF
   IF cl_null(l_xckk.xckk104f) THEN
      LET l_xckk.xckk104f = 0
   END IF
   IF cl_null(l_xckk.xckk104g) THEN
      LET l_xckk.xckk104g = 0
   END IF
   IF cl_null(l_xckk.xckk104h) THEN
      LET l_xckk.xckk104h = 0
   END IF
   #160531-00032#1----e
   LET l_xckk.xckk104 = l_xckk.xckk104b+l_xckk.xckk104d+l_xckk.xckk104e+l_xckk.xckk104f+l_xckk.xckk104g+l_xckk.xckk104h+l_xckk.xckk104c  #161031-00037#1
   
   #161109-00085#26-s mod
#   IF NOT axcq603_ins_xckk(l_xckk.*) THEN   #161109-00085#26-s mark
   IF NOT axcq603_ins_xckk(l_xckk.xckkent,l_xckk.xckkcomp,l_xckk.xckkld,l_xckk.xckk001,l_xckk.xckk002,
                           l_xckk.xckk003,l_xckk.xckk004,l_xckk.xckk005,l_xckk.xckk090,l_xckk.xckk101,
                           l_xckk.xckk102,l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,l_xckk.xckk102d,
                           l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h,l_xckk.xckk103,
                           l_xckk.xckk104,l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,l_xckk.xckk104d,
                           l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h,l_xckk.xckk105,
                           l_xckk.xckk106,l_xckk.xckk106a,l_xckk.xckk106b,l_xckk.xckk106c,l_xckk.xckk106d,
                           l_xckk.xckk106e,l_xckk.xckk106f,l_xckk.xckk106g,l_xckk.xckk106h) THEN
   #161109-00085#26-e mod
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #总表抓xcce的非拆件工单的本期元件=ADJUST投入的金额，明细表抓xccp的非拆件工单的金额，并写入xckk；有差异的按在制单号(工单)找出差异并写入xckl
   INITIALIZE l_xckk.* TO NULL
   LET l_xckk.xckk005 = '210'         #在制调整
   SELECT SUM(CASE xcce007 WHEN 'ADJUST' THEN xcce201 ELSE 0 END),SUM(CASE xcce007 WHEN 'ADJUST' THEN xcce202 ELSE 0 END),
          SUM(CASE xcce007 WHEN 'ADJUST' THEN xcce202a ELSE 0 END),SUM(CASE xcce007 WHEN 'ADJUST' THEN xcce202b ELSE 0 END),
          SUM(CASE xcce007 WHEN 'ADJUST' THEN xcce202c ELSE 0 END),SUM(CASE xcce007 WHEN 'ADJUST' THEN xcce202d ELSE 0 END),
          SUM(CASE xcce007 WHEN 'ADJUST' THEN xcce202e ELSE 0 END),SUM(CASE xcce007 WHEN 'ADJUST' THEN xcce202f ELSE 0 END),
          SUM(CASE xcce007 WHEN 'ADJUST' THEN xcce202g ELSE 0 END),SUM(CASE xcce007 WHEN 'ADJUST' THEN xcce202h ELSE 0 END) 
      INTO l_xckk.xckk101, l_xckk.xckk102, l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,
           l_xckk.xckk102d,l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h
   FROM xcce_t
   WHERE xcceent = g_enterprise AND xcceld = g_master.xckkld AND xccecomp = g_master.xckkcomp
     AND xcce001 = g_master.xckk001 AND xcce003 = g_master.xckk002 
     AND xcce004 = g_master.xckk003 AND xcce005 = g_master.xckk004
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcce_t:7"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF 
   #明细表抓xccp的非拆件工单的金额   
   SELECT SUM((CASE WHEN xccp101 IS NULL THEN 0 ELSE xccp101 END)),  SUM((CASE WHEN xccp102 IS NULL THEN 0 ELSE xccp102 END)), 
          SUM((CASE WHEN xccp102a IS NULL THEN 0 ELSE xccp102a END)),SUM((CASE WHEN xccp102b IS NULL THEN 0 ELSE xccp102b END)),
          SUM((CASE WHEN xccp102c IS NULL THEN 0 ELSE xccp102c END)),SUM((CASE WHEN xccp102d IS NULL THEN 0 ELSE xccp102d END)),
          SUM((CASE WHEN xccp102e IS NULL THEN 0 ELSE xccp102e END)),SUM((CASE WHEN xccp102f IS NULL THEN 0 ELSE xccp102f END)),
          SUM((CASE WHEN xccp102g IS NULL THEN 0 ELSE xccp102g END)),SUM((CASE WHEN xccp102h IS NULL THEN 0 ELSE xccp102h END))
      INTO l_xckk.xckk103, l_xckk.xckk104, l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,
           l_xckk.xckk104d,l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h
   FROM xccp_t,sfaa_t
   WHERE xccpent = g_enterprise AND xccpld = g_master.xckkld AND xccpcomp = g_master.xckkcomp
     AND xccp001 = g_master.xckk001 AND xccp003 = g_master.xckk002 
     AND xccp004 = g_master.xckk003 AND xccp005 = g_master.xckk004
     AND xccpent = sfaaent AND xccp007 = sfaadocno AND sfaa003 <> '3'  #非拆件工单
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xccp_t:1"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #161109-00085#26-s mod
#   IF NOT axcq603_ins_xckk(l_xckk.*) THEN   #161109-00085#26-s mark
   IF NOT axcq603_ins_xckk(l_xckk.xckkent,l_xckk.xckkcomp,l_xckk.xckkld,l_xckk.xckk001,l_xckk.xckk002,
                           l_xckk.xckk003,l_xckk.xckk004,l_xckk.xckk005,l_xckk.xckk090,l_xckk.xckk101,
                           l_xckk.xckk102,l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,l_xckk.xckk102d,
                           l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h,l_xckk.xckk103,
                           l_xckk.xckk104,l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,l_xckk.xckk104d,
                           l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h,l_xckk.xckk105,
                           l_xckk.xckk106,l_xckk.xckk106a,l_xckk.xckk106b,l_xckk.xckk106c,l_xckk.xckk106d,
                           l_xckk.xckk106e,l_xckk.xckk106f,l_xckk.xckk106g,l_xckk.xckk106h) THEN
   #161109-00085#26-e mod
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #总表抓xcce的非拆件工单的本期转出数量和金额，明细表抓xcck的非拆件工单入库的数量和金额，并写入xckk；有差异的按在制单号(工单)找出差异并写入xckl
   INITIALIZE l_xckk.* TO NULL
   LET l_xckk.xckk005 = '211'         #在制转出
   #161031-00037#1---remark--s
   ##160707-00034#1---s
   SELECT SUM((CASE WHEN xcce301 IS NULL THEN 0 ELSE xcce301 END)),  SUM((CASE WHEN xcce302 IS NULL THEN 0 ELSE xcce302 END)), 
          SUM((CASE WHEN xcce302a IS NULL THEN 0 ELSE xcce302a END)),SUM((CASE WHEN xcce302b IS NULL THEN 0 ELSE xcce302b END)),
          SUM((CASE WHEN xcce302c IS NULL THEN 0 ELSE xcce302c END)),SUM((CASE WHEN xcce302d IS NULL THEN 0 ELSE xcce302d END)),
          SUM((CASE WHEN xcce302e IS NULL THEN 0 ELSE xcce302e END)),SUM((CASE WHEN xcce302f IS NULL THEN 0 ELSE xcce302f END)),
          SUM((CASE WHEN xcce302g IS NULL THEN 0 ELSE xcce302g END)),SUM((CASE WHEN xcce302h IS NULL THEN 0 ELSE xcce302h END))
      INTO l_xckk.xckk101, l_xckk.xckk102, l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,
           l_xckk.xckk102d,l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h
   FROM xcce_t
   WHERE xcceent = g_enterprise AND xcceld = g_master.xckkld AND xccecomp = g_master.xckkcomp
     AND xcce001 = g_master.xckk001 AND xcce003 = g_master.xckk002 
     AND xcce004 = g_master.xckk003 AND xcce005 = g_master.xckk004
   ##总表改抓xccd，抓主件的数量
   #SELECT SUM((CASE WHEN xccd301 IS NULL THEN 0  ELSE xccd301 END)), SUM((CASE WHEN xccd302 IS NULL THEN 0  ELSE xccd302 END)), 
   #       SUM((CASE WHEN xccd302a IS NULL THEN 0 ELSE xccd302a END)),SUM((CASE WHEN xccd302b IS NULL THEN 0 ELSE xccd302b END)),
   #       SUM((CASE WHEN xccd302c IS NULL THEN 0 ELSE xccd302c END)),SUM((CASE WHEN xccd302d IS NULL THEN 0 ELSE xccd302d END)),
   #       SUM((CASE WHEN xccd302e IS NULL THEN 0 ELSE xccd302e END)),SUM((CASE WHEN xccd302f IS NULL THEN 0 ELSE xccd302f END)),
   #       SUM((CASE WHEN xccd302g IS NULL THEN 0 ELSE xccd302g END)),SUM((CASE WHEN xccd302h IS NULL THEN 0 ELSE xccd302h END))
   #   INTO l_xckk.xckk101, l_xckk.xckk102, l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,
   #        l_xckk.xckk102d,l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h
   #FROM xccd_t
   #WHERE xccdent = g_enterprise AND xccdld = g_master.xckkld AND xccdcomp = g_master.xckkcomp
   #  AND xccd001 = g_master.xckk001 AND xccd003 = g_master.xckk002 
   #  AND xccd004 = g_master.xckk003 AND xccd005 = g_master.xckk004
   ##160707-00034#1---e
   #161031-00037#1---remark--e
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcce_t:8"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF 
   #明细表抓xcck的非拆件工单入库的数量和金额
   LET l_sql2 = ''
   #LET l_sql2 = l_sql1 , " AND xcck006 IN (SELECT sfaadocno FROM sfaa_t WHERE sfaaent = '",g_enterprise,"' AND sfaa003 <> '3' )"  #xcck里的工单入库，排除拆件  #160531-00032#1
   #LET l_sql2 = l_sql1 , " AND xcck006 IN (SELECT DISTINCT sfecdocno FROM sfaa_t,sfec_t WHERE sfaaent = sfecent AND sfec001 = sfaadocno AND sfaaent = '",g_enterprise,"' AND sfaa003 <> '3' )"  #xcck里的工单入库，排除拆件  #160531-00032#1 #161031-00037#1
   LET l_sql2 = l_sql1 , " AND xcck047 IN (SELECT DISTINCT sfaadocno FROM sfaa_t WHERE sfaaent = '",g_enterprise,"' AND sfaa003 <> '3' )"  #xcck里的工单入库，排除拆件  #160531-00032#1 #161031-00037#1
   #LET l_sql2 = l_sql2 , " AND xcck055 = '205' "  #入库  #161031-00037#1
   LET l_sql2 = l_sql2 , " AND xcck055 IN ('203','2030','205','2050','209','2090') "  #入库  #161031-00037#1
   PREPARE axcq603_sel_pb9 FROM l_sql2
   EXECUTE axcq603_sel_pb9
      INTO l_xckk.xckk103, l_xckk.xckk104, l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,
           l_xckk.xckk104d,l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcck_t:16"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF  
   
   LET l_xckk.xckk103 = l_xckk.xckk101 * (-1) #在製轉出，明細的數量，直接給總表的數量*(-1),因为明细表抓出来的值是负数  #161031-00037#1
   
   #161109-00085#26-s mod
#   IF NOT axcq603_ins_xckk(l_xckk.*) THEN   #161109-00085#26-s mark
   IF NOT axcq603_ins_xckk(l_xckk.xckkent,l_xckk.xckkcomp,l_xckk.xckkld,l_xckk.xckk001,l_xckk.xckk002,
                           l_xckk.xckk003,l_xckk.xckk004,l_xckk.xckk005,l_xckk.xckk090,l_xckk.xckk101,
                           l_xckk.xckk102,l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,l_xckk.xckk102d,
                           l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h,l_xckk.xckk103,
                           l_xckk.xckk104,l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,l_xckk.xckk104d,
                           l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h,l_xckk.xckk105,
                           l_xckk.xckk106,l_xckk.xckk106a,l_xckk.xckk106b,l_xckk.xckk106c,l_xckk.xckk106d,
                           l_xckk.xckk106e,l_xckk.xckk106f,l_xckk.xckk106g,l_xckk.xckk106h) THEN
   #161109-00085#26-e mod
      LET r_success = FALSE
      RETURN r_success
   END IF
   LET l_sql2 = ''
   
   #总表抓和明细表xcce的非拆件工单的本期差异转出数量和金额，并写入xckk；无差异
   INITIALIZE l_xckk.* TO NULL 
   LET l_xckk.xckk005 = '212'         #差异转出
   SELECT SUM((CASE WHEN xcce303 IS NULL THEN 0 ELSE xcce303 END)),  SUM((CASE WHEN xcce304 IS NULL THEN 0 ELSE xcce304 END)), 
          SUM((CASE WHEN xcce304a IS NULL THEN 0 ELSE xcce304a END)),SUM((CASE WHEN xcce304b IS NULL THEN 0 ELSE xcce304b END)),
          SUM((CASE WHEN xcce304c IS NULL THEN 0 ELSE xcce304c END)),SUM((CASE WHEN xcce304d IS NULL THEN 0 ELSE xcce304d END)),
          SUM((CASE WHEN xcce304e IS NULL THEN 0 ELSE xcce304e END)),SUM((CASE WHEN xcce304f IS NULL THEN 0 ELSE xcce304f END)),
          SUM((CASE WHEN xcce304g IS NULL THEN 0 ELSE xcce304g END)),SUM((CASE WHEN xcce302h IS NULL THEN 0 ELSE xcce304h END))
      INTO l_xckk.xckk101, l_xckk.xckk102, l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,
           l_xckk.xckk102d,l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h
   FROM xcce_t
   WHERE xcceent = g_enterprise AND xcceld = g_master.xckkld AND xccecomp = g_master.xckkcomp
     AND xcce001 = g_master.xckk001 AND xcce003 = g_master.xckk002 
     AND xcce004 = g_master.xckk003 AND xcce005 = g_master.xckk004
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcce_t:9"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   LET l_xckk.xckk103 = l_xckk.xckk101
   LET l_xckk.xckk104 = l_xckk.xckk102
   LET l_xckk.xckk104a= l_xckk.xckk102a
   LET l_xckk.xckk104b= l_xckk.xckk102b
   LET l_xckk.xckk104c= l_xckk.xckk102c
   LET l_xckk.xckk104d= l_xckk.xckk102d
   LET l_xckk.xckk104e= l_xckk.xckk102e
   LET l_xckk.xckk104f= l_xckk.xckk102f
   LET l_xckk.xckk104g= l_xckk.xckk102g
   LET l_xckk.xckk104h= l_xckk.xckk102h
  
   #161109-00085#26-s mod
#   IF NOT axcq603_ins_xckk(l_xckk.*) THEN   #161109-00085#26-s mark
   IF NOT axcq603_ins_xckk(l_xckk.xckkent,l_xckk.xckkcomp,l_xckk.xckkld,l_xckk.xckk001,l_xckk.xckk002,
                           l_xckk.xckk003,l_xckk.xckk004,l_xckk.xckk005,l_xckk.xckk090,l_xckk.xckk101,
                           l_xckk.xckk102,l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,l_xckk.xckk102d,
                           l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h,l_xckk.xckk103,
                           l_xckk.xckk104,l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,l_xckk.xckk104d,
                           l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h,l_xckk.xckk105,
                           l_xckk.xckk106,l_xckk.xckk106a,l_xckk.xckk106b,l_xckk.xckk106c,l_xckk.xckk106d,
                           l_xckk.xckk106e,l_xckk.xckk106f,l_xckk.xckk106g,l_xckk.xckk106h) THEN
   #161109-00085#26-e mod
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #总表抓和明细表xcce的非拆件工单的本期期末数量和金额，并写入xckk；无差异
   INITIALIZE l_xckk.* TO NULL 
   LET l_xckk.xckk005 = '214'         #在制期末
   SELECT SUM((CASE WHEN xcce901 IS NULL THEN 0 ELSE xcce901 END)),  SUM((CASE WHEN xcce902 IS NULL THEN 0 ELSE xcce902 END)), 
          SUM((CASE WHEN xcce902a IS NULL THEN 0 ELSE xcce902a END)),SUM((CASE WHEN xcce902b IS NULL THEN 0 ELSE xcce902b END)),
          SUM((CASE WHEN xcce902c IS NULL THEN 0 ELSE xcce902c END)),SUM((CASE WHEN xcce902d IS NULL THEN 0 ELSE xcce902d END)),
          SUM((CASE WHEN xcce902e IS NULL THEN 0 ELSE xcce902e END)),SUM((CASE WHEN xcce902f IS NULL THEN 0 ELSE xcce902f END)),
          SUM((CASE WHEN xcce902g IS NULL THEN 0 ELSE xcce902g END)),SUM((CASE WHEN xcce902h IS NULL THEN 0 ELSE xcce902h END))
      INTO l_xckk.xckk101, l_xckk.xckk102, l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,
           l_xckk.xckk102d,l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h
   FROM xcce_t
   WHERE xcceent = g_enterprise AND xcceld = g_master.xckkld AND xccecomp = g_master.xckkcomp
     AND xcce001 = g_master.xckk001 AND xcce003 = g_master.xckk002 
     AND xcce004 = g_master.xckk003 AND xcce005 = g_master.xckk004
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcce_t:10"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   LET l_xckk.xckk103 = l_xckk.xckk101
   LET l_xckk.xckk104 = l_xckk.xckk102
   LET l_xckk.xckk104a= l_xckk.xckk102a
   LET l_xckk.xckk104b= l_xckk.xckk102b
   LET l_xckk.xckk104c= l_xckk.xckk102c
   LET l_xckk.xckk104d= l_xckk.xckk102d
   LET l_xckk.xckk104e= l_xckk.xckk102e
   LET l_xckk.xckk104f= l_xckk.xckk102f
   LET l_xckk.xckk104g= l_xckk.xckk102g
   LET l_xckk.xckk104h= l_xckk.xckk102h
   #161109-00085#26-s mod
#   IF NOT axcq603_ins_xckk(l_xckk.*) THEN   #161109-00085#26-s mark
   IF NOT axcq603_ins_xckk(l_xckk.xckkent,l_xckk.xckkcomp,l_xckk.xckkld,l_xckk.xckk001,l_xckk.xckk002,
                           l_xckk.xckk003,l_xckk.xckk004,l_xckk.xckk005,l_xckk.xckk090,l_xckk.xckk101,
                           l_xckk.xckk102,l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,l_xckk.xckk102d,
                           l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h,l_xckk.xckk103,
                           l_xckk.xckk104,l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,l_xckk.xckk104d,
                           l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h,l_xckk.xckk105,
                           l_xckk.xckk106,l_xckk.xckk106a,l_xckk.xckk106b,l_xckk.xckk106c,l_xckk.xckk106d,
                           l_xckk.xckk106e,l_xckk.xckk106f,l_xckk.xckk106g,l_xckk.xckk106h) THEN
   #161109-00085#26-e mod
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #总表抓xcci的拆件工单的本期期初数量和金额，明细表抓xcci的上期拆件工单的期末数量和金额，抓不到抓上期的拆件工单的xccb的数据和金额，并写入xckk；有差异的按在制单号(工单)找出差异并写入xckl
   INITIALIZE l_xckk.* TO NULL
   LET l_xckk.xckk005 = '301'         #拆件期初
   #总表抓xcci的本期期初数量和金额
   SELECT SUM((CASE WHEN xcci101 IS NULL THEN 0 ELSE xcci101 END)),  SUM((CASE WHEN xcci102 IS NULL THEN 0 ELSE xcci102 END)), 
          SUM((CASE WHEN xcci102a IS NULL THEN 0 ELSE xcci102a END)),SUM((CASE WHEN xcci102b IS NULL THEN 0 ELSE xcci102b END)),
          SUM((CASE WHEN xcci102c IS NULL THEN 0 ELSE xcci102c END)),SUM((CASE WHEN xcci102d IS NULL THEN 0 ELSE xcci102d END)),
          SUM((CASE WHEN xcci102e IS NULL THEN 0 ELSE xcci102e END)),SUM((CASE WHEN xcci102f IS NULL THEN 0 ELSE xcci102f END)),
          SUM((CASE WHEN xcci102g IS NULL THEN 0 ELSE xcci102g END)),SUM((CASE WHEN xcci102h IS NULL THEN 0 ELSE xcci102h END))
      INTO l_xckk.xckk101, l_xckk.xckk102, l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,
           l_xckk.xckk102d,l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h
   FROM xcci_t 
   WHERE xccient = g_enterprise AND xccild = g_master.xckkld AND xccicomp = g_master.xckkcomp
     AND xcci001 = g_master.xckk001 AND xcci003 = g_master.xckk002 
     AND xcci004 = g_master.xckk003 AND xcci005 = g_master.xckk004
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcci_t:6"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #抓xcci的上期期末数量和金额
   SELECT SUM((CASE WHEN xcci901 IS NULL THEN 0 ELSE xcci901 END)),  SUM((CASE WHEN xcci902 IS NULL THEN 0 ELSE xcci902 END)), 
          SUM((CASE WHEN xcci902a IS NULL THEN 0 ELSE xcci902a END)),SUM((CASE WHEN xcci902b IS NULL THEN 0 ELSE xcci902b END)),
          SUM((CASE WHEN xcci902c IS NULL THEN 0 ELSE xcci902c END)),SUM((CASE WHEN xcci902d IS NULL THEN 0 ELSE xcci902d END)),
          SUM((CASE WHEN xcci902e IS NULL THEN 0 ELSE xcci902e END)),SUM((CASE WHEN xcci902f IS NULL THEN 0 ELSE xcci902f END)),
          SUM((CASE WHEN xcci902g IS NULL THEN 0 ELSE xcci902g END)),SUM((CASE WHEN xcci902h IS NULL THEN 0 ELSE xcci902h END))
      INTO l_xckk.xckk103, l_xckk.xckk104, l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,
           l_xckk.xckk104d,l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h
   FROM xcci_t 
   WHERE xccient = g_enterprise AND xccild = g_master.xckkld AND xccicomp = g_master.xckkcomp
     AND xcci001 = g_master.xckk001 AND xcci003 = g_master.xckk002 
     AND xcci004 = g_previous_xckk003 AND xcci005 = g_previous_xckk004
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcci_t:7"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #抓不到抓上期的xccb的数据和金额
   IF (cl_null(l_xckk.xckk103)  OR l_xckk.xckk103 = 0) AND
      (cl_null(l_xckk.xckk104)  OR l_xckk.xckk104 = 0) AND
      (cl_null(l_xckk.xckk104a) OR l_xckk.xckk104a = 0) AND
      (cl_null(l_xckk.xckk104b) OR l_xckk.xckk104b = 0) AND
      (cl_null(l_xckk.xckk104c) OR l_xckk.xckk104c = 0) AND
      (cl_null(l_xckk.xckk104d) OR l_xckk.xckk104d = 0) AND
      (cl_null(l_xckk.xckk104e) OR l_xckk.xckk104e = 0) AND
      (cl_null(l_xckk.xckk104f) OR l_xckk.xckk104f = 0) AND
      (cl_null(l_xckk.xckk104g) OR l_xckk.xckk104g = 0) AND
      (cl_null(l_xckk.xckk104h) OR l_xckk.xckk104h = 0) THEN
      #明细表抓上期的xccb的数量和金额
      SELECT SUM((CASE WHEN xccb101 IS NULL THEN 0 ELSE xccb101 END)),  SUM((CASE WHEN xccb102 IS NULL THEN 0 ELSE xccb102 END)), 
             SUM((CASE WHEN xccb102a IS NULL THEN 0 ELSE xccb102a END)),SUM((CASE WHEN xccb102b IS NULL THEN 0 ELSE xccb102b END)),
             SUM((CASE WHEN xccb102c IS NULL THEN 0 ELSE xccb102c END)),SUM((CASE WHEN xccb102d IS NULL THEN 0 ELSE xccb102d END)),
             SUM((CASE WHEN xccb102e IS NULL THEN 0 ELSE xccb102e END)),SUM((CASE WHEN xccb102f IS NULL THEN 0 ELSE xccb102f END)),
             SUM((CASE WHEN xccb102g IS NULL THEN 0 ELSE xccb102g END)),SUM((CASE WHEN xccb102h IS NULL THEN 0 ELSE xccb102h END))
         INTO l_xckk.xckk103, l_xckk.xckk104, l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,
              l_xckk.xckk104d,l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h
      FROM xccb_t,sfaa_t 
      WHERE xccbent = g_enterprise AND xccbld = g_master.xckkld AND xccbcomp = g_master.xckkcomp
        AND xccb001 = g_master.xckk001 AND xccb003 = g_master.xckk002 
        AND xccb004 = g_previous_xckk003 AND xccb005 = g_previous_xckk004
        AND xccbent = sfaaent AND xccb006 = sfaadocno AND sfaa003 = '3'  #拆件
      IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xccb_t:3"
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
   
      LET g_source = 'xccb'      #標記明細表的來源
   END IF
   
   #161109-00085#26-s mod
#   IF NOT axcq603_ins_xckk(l_xckk.*) THEN   #161109-00085#26-s mark
   IF NOT axcq603_ins_xckk(l_xckk.xckkent,l_xckk.xckkcomp,l_xckk.xckkld,l_xckk.xckk001,l_xckk.xckk002,
                           l_xckk.xckk003,l_xckk.xckk004,l_xckk.xckk005,l_xckk.xckk090,l_xckk.xckk101,
                           l_xckk.xckk102,l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,l_xckk.xckk102d,
                           l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h,l_xckk.xckk103,
                           l_xckk.xckk104,l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,l_xckk.xckk104d,
                           l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h,l_xckk.xckk105,
                           l_xckk.xckk106,l_xckk.xckk106a,l_xckk.xckk106b,l_xckk.xckk106c,l_xckk.xckk106d,
                           l_xckk.xckk106e,l_xckk.xckk106f,l_xckk.xckk106g,l_xckk.xckk106h) THEN
   #161109-00085#26-e mod
      LET r_success = FALSE
      RETURN r_success
   END IF
   LET g_source = ''  
   
   #总表抓xcci的拆件工单的本期投入数量和金额（元件排除DL+OH+SUB），明细表抓xcck的拆件工单工单发料数量和金额，并写入xckk；有差异的按在制单号(工单)找出差异并写入xckl
   INITIALIZE l_xckk.* TO NULL
   LET l_xckk.xckk005 = '302'         #拆件投入
   SELECT SUM((CASE WHEN xcci201 IS NULL THEN 0 ELSE xcci201 END)),  SUM((CASE WHEN xcci202 IS NULL THEN 0 ELSE xcci202 END)), 
          SUM((CASE WHEN xcci202a IS NULL THEN 0 ELSE xcci202a END)),SUM((CASE WHEN xcci202b IS NULL THEN 0 ELSE xcci202b END)),
          SUM((CASE WHEN xcci202c IS NULL THEN 0 ELSE xcci202c END)),SUM((CASE WHEN xcci202d IS NULL THEN 0 ELSE xcci202d END)),
          SUM((CASE WHEN xcci202e IS NULL THEN 0 ELSE xcci202e END)),SUM((CASE WHEN xcci202f IS NULL THEN 0 ELSE xcci202f END)),
          SUM((CASE WHEN xcci202g IS NULL THEN 0 ELSE xcci202g END)),SUM((CASE WHEN xcci202h IS NULL THEN 0 ELSE xcci202h END))
      INTO l_xckk.xckk101, l_xckk.xckk102, l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,
           l_xckk.xckk102d,l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h
   FROM xcci_t
   WHERE xccient = g_enterprise AND xccild = g_master.xckkld AND xccicomp = g_master.xckkcomp
     AND xcci001 = g_master.xckk001 AND xcci003 = g_master.xckk002 
     AND xcci004 = g_master.xckk003 AND xcci005 = g_master.xckk004 AND xcci007 <> 'DL+OH+SUB'
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcci_t:5"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF  
   #明细表抓xcck的本期投入的数量和金额
   LET l_sql2 = ''
   #LET l_sql2 = l_sql1 , " AND xcck055 = '301' AND xcck020 = '113'"  #xcck里的工单发料，拆件  #160531-00032#1
   #LET l_sql2 = l_sql1 , " AND xcck055 = '3012' AND xcck020 = '113'"  #xcck里的工单发料，拆件  #160531-00032#1 #170210-00001#1 mark
   #170210-00001#1--add--start--
   LET l_sql2 = l_sql1 , " AND xcck055 = '207' AND xcck020 = '302' ",
                         " AND EXISTS (SELECT xcch006 FROM xcch_t ",
                         "              WHERE xcchent = xcckent and xcchcomp = xcckcomp and xcch001 = xcck001 ",
                         "                and xcch003 = xcck003 and xcch004 = xcck004 and xcch005 = xcck005 ",
                         "                and xcch006 = xcck047 )"
   #170210-00001#1--add--end----
   #元件排除DL+OH+SUB，料件类别是半成品
   LET l_sql2 = l_sql2 , " AND xcck010 <> 'DL+OH+SUB' "  
   PREPARE axcq603_sel_pb11 FROM l_sql2
   EXECUTE axcq603_sel_pb11
      INTO l_xckk.xckk103, l_xckk.xckk104, l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,
           l_xckk.xckk104d,l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcck_t:18"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF  
   #161109-00085#26-s mod
#   IF NOT axcq603_ins_xckk(l_xckk.*) THEN   #161109-00085#26-s mark
   IF NOT axcq603_ins_xckk(l_xckk.xckkent,l_xckk.xckkcomp,l_xckk.xckkld,l_xckk.xckk001,l_xckk.xckk002,
                           l_xckk.xckk003,l_xckk.xckk004,l_xckk.xckk005,l_xckk.xckk090,l_xckk.xckk101,
                           l_xckk.xckk102,l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,l_xckk.xckk102d,
                           l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h,l_xckk.xckk103,
                           l_xckk.xckk104,l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,l_xckk.xckk104d,
                           l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h,l_xckk.xckk105,
                           l_xckk.xckk106,l_xckk.xckk106a,l_xckk.xckk106b,l_xckk.xckk106c,l_xckk.xckk106d,
                           l_xckk.xckk106e,l_xckk.xckk106f,l_xckk.xckk106g,l_xckk.xckk106h) THEN
   #161109-00085#26-e mod
      LET r_success = FALSE
      RETURN r_success
   END IF
   LET l_sql2 = ''
    
   #总表抓xcci的拆件工单的本期元件=DL+OH+SUB投入人工金额，明细表抓xcbk的拆件工单人工金额，并写入xckk；有差异的按在制单号(工单)找出差异并写入xckl 
   INITIALIZE l_xckk.* TO NULL 
   LET l_xckk.xckk005 = '306'         #拆件人工费
   SELECT 0 ,  #数量
          SUM(CASE xcci007 WHEN 'DL+OH+SUB' THEN xcci202 - xcci202a ELSE 0 END), #在製總投入 - 材料投入
          0,  #材料投入
          SUM(CASE xcci007 WHEN 'DL+OH+SUB' THEN xcci202b ELSE 0 END),SUM(CASE xcci007 WHEN 'DL+OH+SUB' THEN xcci202c ELSE 0 END),
          SUM(CASE xcci007 WHEN 'DL+OH+SUB' THEN xcci202d ELSE 0 END),SUM(CASE xcci007 WHEN 'DL+OH+SUB' THEN xcci202e ELSE 0 END),
          SUM(CASE xcci007 WHEN 'DL+OH+SUB' THEN xcci202f ELSE 0 END),SUM(CASE xcci007 WHEN 'DL+OH+SUB' THEN xcci202g ELSE 0 END),
          SUM(CASE xcci007 WHEN 'DL+OH+SUB' THEN xcci202h ELSE 0 END)
      INTO l_xckk.xckk101, l_xckk.xckk102, l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,
           l_xckk.xckk102d,l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h
   FROM xcci_t
   WHERE xccient = g_enterprise AND xccild = g_master.xckkld AND xccicomp = g_master.xckkcomp
     AND xcci001 = g_master.xckk001 AND xcci003 = g_master.xckk002 
     AND xcci004 = g_master.xckk003 AND xcci005 = g_master.xckk004
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcci_t:4"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   #明细表抓xcbk的拆件工单人工金额
   LET l_xckk.xckk103 = 0
   CASE g_master.xckk001 
      WHEN '1'  #本位币一
         LET l_sql = " SELECT SUM(xcbk202) "
      WHEN '2'  #本位币二
         LET l_sql = " SELECT SUM(xcbk212) "
      WHEN '3'  #本位币三
         LET l_sql = " SELECT SUM(xcbk222) "
      OTHERWISE
         LET l_sql = " SELECT SUM(xcbk202) "
   END CASE
   LET l_sql = l_sql, " FROM xcbk_t,sfaa_t ",
               "   WHERE xcbkent = '",g_enterprise,"' AND xcbkld = '",g_master.xckkld,"' ",
               "     AND xcbkcomp = '",g_master.xckkcomp,"' AND xcbk001 = '",g_master.xckk002,"' ",
               "     AND xcbk002 = ",g_master.xckk003," AND xcbk003 = ",g_master.xckk004,
               "     AND xcbkent = sfaaent AND xcbk006 = sfaadocno AND sfaa003 = '3' ", #拆件工单
               "     AND xcbk005 = ? "
   PREPARE axcq603_sel_xcbk2 FROM l_sql
   LET l_xckk.xckk104a = 0  #材料投入
   LET l_xcbk005 = '1'  #人工
   EXECUTE axcq603_sel_xcbk2 USING l_xcbk005 INTO l_xckk.xckk104b
   #明细表抓xcck的拆件委外工单的委外加工金额
   #加工
   LET l_xckk.xckk104c = 0
   #xcck055先选择工单领用，再通过xcck006参考单号去关联工单类型(关联制程档里)有个委外否
   SELECT SUM((CASE WHEN xcck202c  IS NULL THEN 0 ELSE xcck202c  END)* xcck009) INTO l_xckk.xckk104c
     #FROM xcck_t , sfcb_t ,sfec_t  #160531-00032#1  #161031-00037#1 mark
      FROM xcck_t , sfcb_t  #161031-00037#1 
     WHERE xcckent = g_enterprise AND xcckld = g_master.xckkld AND xcckcomp = g_master.xckkcomp
       AND xcck001 = g_master.xckk001 AND xcck003 = g_master.xckk002
       AND xcck004 = g_master.xckk003 AND xcck005 = g_master.xckk004
       #AND xcck055 = '301' AND xcck020 = '113'  #xcck里的工单发料，拆件  #160531-00032#1
       AND xcck055 = '3012' AND xcck020 = '113'  #xcck里的工单发料，拆件  #160531-00032#1
       #AND xcckent = sfcbent AND xcck006 = sfcbdocno AND sfcb012 = 'Y' #委外否  #160531-00032#1
       #AND xcckent = sfecent  AND xcck006 = sfecdocno AND sfecent = sfcbent AND sfec001 = sfcbdocno AND sfcb012 = 'Y' #委外否 #160531-00032#1 #161031-00037#1 mark
       AND xcckent = sfcbent AND xcck047 = sfcbdocno AND sfcb012 = 'Y' #委外否  #161031-00037#1 
       
   LET l_xcbk005 = '2'  #製費一
   #EXECUTE axcq603_sel_xcbk USING l_xcbk005 INTO l_xckk.xckk104d   #161031-00037#1
   EXECUTE axcq603_sel_xcbk2 USING l_xcbk005 INTO l_xckk.xckk104d   #161031-00037#1
   LET l_xcbk005 = '3'  #製費二
   #EXECUTE axcq603_sel_xcbk USING l_xcbk005 INTO l_xckk.xckk104e   #161031-00037#1
   EXECUTE axcq603_sel_xcbk2 USING l_xcbk005 INTO l_xckk.xckk104e   #161031-00037#1
   LET l_xcbk005 = '4'  #製費三
   #EXECUTE axcq603_sel_xcbk USING l_xcbk005 INTO l_xckk.xckk104f   #161031-00037#1
   EXECUTE axcq603_sel_xcbk2 USING l_xcbk005 INTO l_xckk.xckk104f   #161031-00037#1
   LET l_xcbk005 = '5'  #製費四
   #EXECUTE axcq603_sel_xcbk USING l_xcbk005 INTO l_xckk.xckk104g   #161031-00037#1
   EXECUTE axcq603_sel_xcbk2 USING l_xcbk005 INTO l_xckk.xckk104g   #161031-00037#1
   LET l_xcbk005 = '6'  #製費五
   #EXECUTE axcq603_sel_xcbk USING l_xcbk005 INTO l_xckk.xckk104h   #161031-00037#1
   EXECUTE axcq603_sel_xcbk2 USING l_xcbk005 INTO l_xckk.xckk104h   #161031-00037#1
   #160531-00032#1----s
   IF cl_null(l_xckk.xckk104b) THEN
      LET l_xckk.xckk104b = 0
   END IF
   #170216-00080 ---add (s)---
   IF cl_null(l_xckk.xckk104c) THEN
      LET l_xckk.xckk104c = 0
   END IF
   #170216-00080 ---add (e)---
   IF cl_null(l_xckk.xckk104d) THEN
      LET l_xckk.xckk104d = 0
   END IF
   IF cl_null(l_xckk.xckk104e) THEN
      LET l_xckk.xckk104e = 0
   END IF
   IF cl_null(l_xckk.xckk104f) THEN
      LET l_xckk.xckk104f = 0
   END IF
   IF cl_null(l_xckk.xckk104g) THEN
      LET l_xckk.xckk104g = 0
   END IF
   IF cl_null(l_xckk.xckk104h) THEN
      LET l_xckk.xckk104h = 0
   END IF
   #160531-00032#1----e
   
   LET l_xckk.xckk104 = l_xckk.xckk104b+l_xckk.xckk104d+l_xckk.xckk104e+l_xckk.xckk104f+l_xckk.xckk104g+l_xckk.xckk104h
   
   #161109-00085#26-s mod
#   IF NOT axcq603_ins_xckk(l_xckk.*) THEN   #161109-00085#26-s mark
   IF NOT axcq603_ins_xckk(l_xckk.xckkent,l_xckk.xckkcomp,l_xckk.xckkld,l_xckk.xckk001,l_xckk.xckk002,
                           l_xckk.xckk003,l_xckk.xckk004,l_xckk.xckk005,l_xckk.xckk090,l_xckk.xckk101,
                           l_xckk.xckk102,l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,l_xckk.xckk102d,
                           l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h,l_xckk.xckk103,
                           l_xckk.xckk104,l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,l_xckk.xckk104d,
                           l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h,l_xckk.xckk105,
                           l_xckk.xckk106,l_xckk.xckk106a,l_xckk.xckk106b,l_xckk.xckk106c,l_xckk.xckk106d,
                           l_xckk.xckk106e,l_xckk.xckk106f,l_xckk.xckk106g,l_xckk.xckk106h) THEN
   #161109-00085#26-e mod
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #总表抓xcci的拆件工单的本期转出数量和金额，明细表抓xcck的拆件工单入库的数量和金额，并写入xckk；有差异的按在制单号(工单)找出差异并写入xckl
   INITIALIZE l_xckk.* TO NULL
   LET l_xckk.xckk005 = '303'         #拆件拆出
   SELECT SUM((CASE WHEN xcci301 IS NULL THEN 0 ELSE xcci301 END)),  SUM((CASE WHEN xcci302 IS NULL THEN 0 ELSE xcci302 END)), 
          SUM((CASE WHEN xcci302a IS NULL THEN 0 ELSE xcci302a END)),SUM((CASE WHEN xcci302b IS NULL THEN 0 ELSE xcci302b END)),
          SUM((CASE WHEN xcci302c IS NULL THEN 0 ELSE xcci302c END)),SUM((CASE WHEN xcci302d IS NULL THEN 0 ELSE xcci302d END)),
          SUM((CASE WHEN xcci302e IS NULL THEN 0 ELSE xcci302e END)),SUM((CASE WHEN xcci302f IS NULL THEN 0 ELSE xcci302f END)),
          SUM((CASE WHEN xcci302g IS NULL THEN 0 ELSE xcci302g END)),SUM((CASE WHEN xcci302h IS NULL THEN 0 ELSE xcci302h END))
      INTO l_xckk.xckk101, l_xckk.xckk102, l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,
           l_xckk.xckk102d,l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h
   FROM xcci_t
   WHERE xccient = g_enterprise AND xccild = g_master.xckkld AND xccicomp = g_master.xckkcomp
     AND xcci001 = g_master.xckk001 AND xcci003 = g_master.xckk002 
     AND xcci004 = g_master.xckk003 AND xcci005 = g_master.xckk004
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcci_t:3"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF 
   #明细表抓xcck的拆件工单入库的数量和金额
   LET l_sql2 = ''
   #LET l_sql2 = l_sql1 , " AND xcck006 IN (SELECT sfaadocno FROM sfaa_t WHERE sfaaent = '",g_enterprise,"' AND sfaa003 ='3' )"  #xcck里的工单入库，拆件  #160531-00032#1
   #LET l_sql2 = l_sql1 , " AND xcck006 IN (SELECT sfecdocno FROM sfaa_t,sfec_t WHERE sfaaent = sfecent AND sfec001 = sfaadocno AND sfaaent = '",g_enterprise,"' AND sfaa003 = '3' )"  #xcck里的工单入库，拆件  #160531-00032#1  #161031-00037#1 
   LET l_sql2 = l_sql1 , " AND xcck047 IN (SELECT sfaadocno FROM sfaa_t WHERE sfaaent = '",g_enterprise,"' AND sfaa003 ='3' )"  #161031-00037#1 
   #LET l_sql2 = l_sql2 , " AND xcck055 = '205' "  #入库  #161031-00037#1
   LET l_sql2 = l_sql2 , " AND xcck055 = '3012' AND xcck020 = '113' "  #入库  #161031-00037#1
   
   PREPARE axcq603_sel_pb10 FROM l_sql2
   EXECUTE axcq603_sel_pb10
      INTO l_xckk.xckk103, l_xckk.xckk104, l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,
           l_xckk.xckk104d,l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcck_t:17"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF  
   #161109-00085#26-s mod
#   IF NOT axcq603_ins_xckk(l_xckk.*) THEN   #161109-00085#26-s mark
   IF NOT axcq603_ins_xckk(l_xckk.xckkent,l_xckk.xckkcomp,l_xckk.xckkld,l_xckk.xckk001,l_xckk.xckk002,
                           l_xckk.xckk003,l_xckk.xckk004,l_xckk.xckk005,l_xckk.xckk090,l_xckk.xckk101,
                           l_xckk.xckk102,l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,l_xckk.xckk102d,
                           l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h,l_xckk.xckk103,
                           l_xckk.xckk104,l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,l_xckk.xckk104d,
                           l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h,l_xckk.xckk105,
                           l_xckk.xckk106,l_xckk.xckk106a,l_xckk.xckk106b,l_xckk.xckk106c,l_xckk.xckk106d,
                           l_xckk.xckk106e,l_xckk.xckk106f,l_xckk.xckk106g,l_xckk.xckk106h) THEN
   #161109-00085#26-e mod
      LET r_success = FALSE
      RETURN r_success
   END IF
   LET l_sql2 = ''
   
   #总表抓和明细表xcci的拆件工单的本期差异转出数量和金额，并写入xckk；无差异
   INITIALIZE l_xckk.* TO NULL
   LET l_xckk.xckk005 = '304'         #拆件差异
   SELECT SUM((CASE WHEN xcci303 IS NULL THEN 0 ELSE xcci303 END)),  SUM((CASE WHEN xcci304 IS NULL THEN 0 ELSE xcci304 END)), 
          SUM((CASE WHEN xcci304a IS NULL THEN 0 ELSE xcci304a END)),SUM((CASE WHEN xcci304b IS NULL THEN 0 ELSE xcci304b END)),
          SUM((CASE WHEN xcci304c IS NULL THEN 0 ELSE xcci304c END)),SUM((CASE WHEN xcci304d IS NULL THEN 0 ELSE xcci304d END)),
          SUM((CASE WHEN xcci304e IS NULL THEN 0 ELSE xcci304e END)),SUM((CASE WHEN xcci304f IS NULL THEN 0 ELSE xcci304f END)),
          SUM((CASE WHEN xcci304g IS NULL THEN 0 ELSE xcci304g END)),SUM((CASE WHEN xcci302h IS NULL THEN 0 ELSE xcci304h END))
      INTO l_xckk.xckk101, l_xckk.xckk102, l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,
           l_xckk.xckk102d,l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h
   FROM xcci_t
   WHERE xccient = g_enterprise AND xccild = g_master.xckkld AND xccicomp = g_master.xckkcomp
     AND xcci001 = g_master.xckk001 AND xcci003 = g_master.xckk002 
     AND xcci004 = g_master.xckk003 AND xcci005 = g_master.xckk004
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcci_t:2"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   LET l_xckk.xckk103 = l_xckk.xckk101
   LET l_xckk.xckk104 = l_xckk.xckk102
   LET l_xckk.xckk104a= l_xckk.xckk102a
   LET l_xckk.xckk104b= l_xckk.xckk102b
   LET l_xckk.xckk104c= l_xckk.xckk102c
   LET l_xckk.xckk104d= l_xckk.xckk102d
   LET l_xckk.xckk104e= l_xckk.xckk102e
   LET l_xckk.xckk104f= l_xckk.xckk102f
   LET l_xckk.xckk104g= l_xckk.xckk102g
   LET l_xckk.xckk104h= l_xckk.xckk102h
  
   #161109-00085#26-s mod
#   IF NOT axcq603_ins_xckk(l_xckk.*) THEN   #161109-00085#26-s mark
   IF NOT axcq603_ins_xckk(l_xckk.xckkent,l_xckk.xckkcomp,l_xckk.xckkld,l_xckk.xckk001,l_xckk.xckk002,
                           l_xckk.xckk003,l_xckk.xckk004,l_xckk.xckk005,l_xckk.xckk090,l_xckk.xckk101,
                           l_xckk.xckk102,l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,l_xckk.xckk102d,
                           l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h,l_xckk.xckk103,
                           l_xckk.xckk104,l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,l_xckk.xckk104d,
                           l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h,l_xckk.xckk105,
                           l_xckk.xckk106,l_xckk.xckk106a,l_xckk.xckk106b,l_xckk.xckk106c,l_xckk.xckk106d,
                           l_xckk.xckk106e,l_xckk.xckk106f,l_xckk.xckk106g,l_xckk.xckk106h) THEN
   #161109-00085#26-e mod
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #总表抓和明细表xcci的拆件工单的本期期末数量和金额，并写入xckk；无差异 
   INITIALIZE l_xckk.* TO NULL 
   LET l_xckk.xckk005 = '305'         #拆件结存
   SELECT SUM((CASE WHEN xcci901 IS NULL THEN 0 ELSE xcci901 END)),  SUM((CASE WHEN xcci902 IS NULL THEN 0 ELSE xcci902 END)), 
          SUM((CASE WHEN xcci902a IS NULL THEN 0 ELSE xcci902a END)),SUM((CASE WHEN xcci902b IS NULL THEN 0 ELSE xcci902b END)),
          SUM((CASE WHEN xcci902c IS NULL THEN 0 ELSE xcci902c END)),SUM((CASE WHEN xcci902d IS NULL THEN 0 ELSE xcci902d END)),
          SUM((CASE WHEN xcci902e IS NULL THEN 0 ELSE xcci902e END)),SUM((CASE WHEN xcci902f IS NULL THEN 0 ELSE xcci902f END)),
          SUM((CASE WHEN xcci902g IS NULL THEN 0 ELSE xcci902g END)),SUM((CASE WHEN xcci902h IS NULL THEN 0 ELSE xcci902h END))
      INTO l_xckk.xckk101, l_xckk.xckk102, l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,
           l_xckk.xckk102d,l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h
   FROM xcci_t
   WHERE xccient = g_enterprise AND xccild = g_master.xckkld AND xccicomp = g_master.xckkcomp
     AND xcci001 = g_master.xckk001 AND xcci003 = g_master.xckk002 
     AND xcci004 = g_master.xckk003 AND xcci005 = g_master.xckk004
   IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xcci_t:1"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   LET l_xckk.xckk103 = l_xckk.xckk101
   LET l_xckk.xckk104 = l_xckk.xckk102
   LET l_xckk.xckk104a= l_xckk.xckk102a
   LET l_xckk.xckk104b= l_xckk.xckk102b
   LET l_xckk.xckk104c= l_xckk.xckk102c
   LET l_xckk.xckk104d= l_xckk.xckk102d
   LET l_xckk.xckk104e= l_xckk.xckk102e
   LET l_xckk.xckk104f= l_xckk.xckk102f
   LET l_xckk.xckk104g= l_xckk.xckk102g
   LET l_xckk.xckk104h= l_xckk.xckk102h
   #161109-00085#26-s mod
#   IF NOT axcq603_ins_xckk(l_xckk.*) THEN   #161109-00085#26-s mark
   IF NOT axcq603_ins_xckk(l_xckk.xckkent,l_xckk.xckkcomp,l_xckk.xckkld,l_xckk.xckk001,l_xckk.xckk002,
                           l_xckk.xckk003,l_xckk.xckk004,l_xckk.xckk005,l_xckk.xckk090,l_xckk.xckk101,
                           l_xckk.xckk102,l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,l_xckk.xckk102d,
                           l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h,l_xckk.xckk103,
                           l_xckk.xckk104,l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,l_xckk.xckk104d,
                           l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h,l_xckk.xckk105,
                           l_xckk.xckk106,l_xckk.xckk106a,l_xckk.xckk106b,l_xckk.xckk106c,l_xckk.xckk106d,
                           l_xckk.xckk106e,l_xckk.xckk106f,l_xckk.xckk106g,l_xckk.xckk106h) THEN
   #161109-00085#26-e mod
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
   
END FUNCTION

#插入xckk_t表
PRIVATE FUNCTION axcq603_ins_xckk(p_xckk)
#161109-00085#26-s mod
#DEFINE p_xckk          RECORD LIKE xckk_t.*   #161109-00085#26-s mark
DEFINE p_xckk          RECORD  #成本勾稽表
       xckkent LIKE xckk_t.xckkent, #企業編號
       xckkcomp LIKE xckk_t.xckkcomp, #法人組織
       xckkld LIKE xckk_t.xckkld, #帳套
       xckk001 LIKE xckk_t.xckk001, #本位幣順序
       xckk002 LIKE xckk_t.xckk002, #成本計算類型
       xckk003 LIKE xckk_t.xckk003, #年度
       xckk004 LIKE xckk_t.xckk004, #期別
       xckk005 LIKE xckk_t.xckk005, #
       xckk090 LIKE xckk_t.xckk090, #明細程式編號
       xckk101 LIKE xckk_t.xckk101, #總報表數量
       xckk102 LIKE xckk_t.xckk102, #總報表金額
       xckk102a LIKE xckk_t.xckk102a, #材料
       xckk102b LIKE xckk_t.xckk102b, #人工
       xckk102c LIKE xckk_t.xckk102c, #加工
       xckk102d LIKE xckk_t.xckk102d, #制費一
       xckk102e LIKE xckk_t.xckk102e, #制費二
       xckk102f LIKE xckk_t.xckk102f, #制費三
       xckk102g LIKE xckk_t.xckk102g, #製費四
       xckk102h LIKE xckk_t.xckk102h, #制費五
       xckk103 LIKE xckk_t.xckk103, #分報表數量
       xckk104 LIKE xckk_t.xckk104, #分報表金額
       xckk104a LIKE xckk_t.xckk104a, #分報表材料
       xckk104b LIKE xckk_t.xckk104b, #分報表人工
       xckk104c LIKE xckk_t.xckk104c, #分報表加工
       xckk104d LIKE xckk_t.xckk104d, #分報表制費一
       xckk104e LIKE xckk_t.xckk104e, #分報表制費二
       xckk104f LIKE xckk_t.xckk104f, #分報表制費三
       xckk104g LIKE xckk_t.xckk104g, #分報表制費四
       xckk104h LIKE xckk_t.xckk104h, #分報表制費五
       xckk105 LIKE xckk_t.xckk105, #差異數量
       xckk106 LIKE xckk_t.xckk106, #差異金額
       xckk106a LIKE xckk_t.xckk106a, #差異金額-材料
       xckk106b LIKE xckk_t.xckk106b, #差異金額-人工
       xckk106c LIKE xckk_t.xckk106c, #差異金額-加工
       xckk106d LIKE xckk_t.xckk106d, #差異金額-制費一
       xckk106e LIKE xckk_t.xckk106e, #差異金額-制費二
       xckk106f LIKE xckk_t.xckk106f, #差異金額-制費三
       xckk106g LIKE xckk_t.xckk106g, #差異金額-制費四
       xckk106h LIKE xckk_t.xckk106h  #差異金額-制費五
                END RECORD
#161109-00085#26-e mod
DEFINE r_success   LIKE type_t.num5
#161109-00085#26-s mod
#DEFINE l_xckk          RECORD LIKE xckk_t.*   #161109-00085#26-s mark
DEFINE l_xckk          RECORD  #成本勾稽表
       xckkent LIKE xckk_t.xckkent, #企業編號
       xckkcomp LIKE xckk_t.xckkcomp, #法人組織
       xckkld LIKE xckk_t.xckkld, #帳套
       xckk001 LIKE xckk_t.xckk001, #本位幣順序
       xckk002 LIKE xckk_t.xckk002, #成本計算類型
       xckk003 LIKE xckk_t.xckk003, #年度
       xckk004 LIKE xckk_t.xckk004, #期別
       xckk005 LIKE xckk_t.xckk005, #
       xckk090 LIKE xckk_t.xckk090, #明細程式編號
       xckk101 LIKE xckk_t.xckk101, #總報表數量
       xckk102 LIKE xckk_t.xckk102, #總報表金額
       xckk102a LIKE xckk_t.xckk102a, #材料
       xckk102b LIKE xckk_t.xckk102b, #人工
       xckk102c LIKE xckk_t.xckk102c, #加工
       xckk102d LIKE xckk_t.xckk102d, #制費一
       xckk102e LIKE xckk_t.xckk102e, #制費二
       xckk102f LIKE xckk_t.xckk102f, #制費三
       xckk102g LIKE xckk_t.xckk102g, #製費四
       xckk102h LIKE xckk_t.xckk102h, #制費五
       xckk103 LIKE xckk_t.xckk103, #分報表數量
       xckk104 LIKE xckk_t.xckk104, #分報表金額
       xckk104a LIKE xckk_t.xckk104a, #分報表材料
       xckk104b LIKE xckk_t.xckk104b, #分報表人工
       xckk104c LIKE xckk_t.xckk104c, #分報表加工
       xckk104d LIKE xckk_t.xckk104d, #分報表制費一
       xckk104e LIKE xckk_t.xckk104e, #分報表制費二
       xckk104f LIKE xckk_t.xckk104f, #分報表制費三
       xckk104g LIKE xckk_t.xckk104g, #分報表制費四
       xckk104h LIKE xckk_t.xckk104h, #分報表制費五
       xckk105 LIKE xckk_t.xckk105, #差異數量
       xckk106 LIKE xckk_t.xckk106, #差異金額
       xckk106a LIKE xckk_t.xckk106a, #差異金額-材料
       xckk106b LIKE xckk_t.xckk106b, #差異金額-人工
       xckk106c LIKE xckk_t.xckk106c, #差異金額-加工
       xckk106d LIKE xckk_t.xckk106d, #差異金額-制費一
       xckk106e LIKE xckk_t.xckk106e, #差異金額-制費二
       xckk106f LIKE xckk_t.xckk106f, #差異金額-制費三
       xckk106g LIKE xckk_t.xckk106g, #差異金額-制費四
       xckk106h LIKE xckk_t.xckk106h  #差異金額-制費五
                END RECORD
#161109-00085#26-e mod

   LET r_success = TRUE
   
   INITIALIZE l_xckk.* TO NULL
   
   LET l_xckk.* = p_xckk.*   
   
   LET l_xckk.xckkent = g_enterprise
   LET l_xckk.xckkcomp = g_master.xckkcomp
   LET l_xckk.xckkld = g_master.xckkld
   LET l_xckk.xckk001 = g_master.xckk001
   LET l_xckk.xckk002 = g_master.xckk002
   LET l_xckk.xckk003 = g_master.xckk003
   LET l_xckk.xckk004 = g_master.xckk004 
   
   IF cl_null(l_xckk.xckk101) THEN
      LET l_xckk.xckk101 = 0
   END IF
   IF cl_null(l_xckk.xckk102) THEN
      LET l_xckk.xckk102 = 0
   END IF
   IF cl_null(l_xckk.xckk102a) THEN
      LET l_xckk.xckk102a = 0
   END IF
   IF cl_null(l_xckk.xckk102b) THEN
      LET l_xckk.xckk102b = 0
   END IF
   IF cl_null(l_xckk.xckk102c) THEN
      LET l_xckk.xckk102c = 0
   END IF
   IF cl_null(l_xckk.xckk102d) THEN
      LET l_xckk.xckk102d = 0
   END IF
   IF cl_null(l_xckk.xckk102e) THEN
      LET l_xckk.xckk102e = 0
   END IF
   IF cl_null(l_xckk.xckk102f) THEN
      LET l_xckk.xckk102f = 0
   END IF
   IF cl_null(l_xckk.xckk102g) THEN
      LET l_xckk.xckk102g = 0
   END IF
   IF cl_null(l_xckk.xckk102h) THEN
      LET l_xckk.xckk102h = 0
   END IF
   
   IF cl_null(l_xckk.xckk103) THEN
      LET l_xckk.xckk103 = 0
   END IF
   IF cl_null(l_xckk.xckk104) THEN
      LET l_xckk.xckk104 = 0
   END IF
   IF cl_null(l_xckk.xckk104a) THEN
      LET l_xckk.xckk104a = 0
   END IF
   IF cl_null(l_xckk.xckk104b) THEN
      LET l_xckk.xckk104b = 0
   END IF
   IF cl_null(l_xckk.xckk104c) THEN
      LET l_xckk.xckk104c = 0
   END IF
   IF cl_null(l_xckk.xckk104d) THEN
      LET l_xckk.xckk104d = 0
   END IF
   IF cl_null(l_xckk.xckk104e) THEN
      LET l_xckk.xckk104e = 0
   END IF
   IF cl_null(l_xckk.xckk104f) THEN
      LET l_xckk.xckk104f = 0
   END IF
   IF cl_null(l_xckk.xckk104g) THEN
      LET l_xckk.xckk104g = 0
   END IF
   IF cl_null(l_xckk.xckk104h) THEN
      LET l_xckk.xckk104h = 0
   END IF
   
   #160531-00032#1---s
   #若明细中抓取的值是负数，则*(-1)计算，相当于总+明细的=差异的
   IF ((l_xckk.xckk103 < 0  AND l_xckk.xckk101 > 0) OR (l_xckk.xckk103 > 0  AND l_xckk.xckk101 < 0)) OR
      ((l_xckk.xckk104 < 0  AND l_xckk.xckk102 > 0) OR (l_xckk.xckk104 > 0  AND l_xckk.xckk102 < 0))  THEN
      LET l_xckk.xckk105 = l_xckk.xckk101 + l_xckk.xckk103
      LET l_xckk.xckk106 = l_xckk.xckk102 + l_xckk.xckk104
      LET l_xckk.xckk106a = l_xckk.xckk102a + l_xckk.xckk104a
      LET l_xckk.xckk106b = l_xckk.xckk102b + l_xckk.xckk104b
      LET l_xckk.xckk106c = l_xckk.xckk102c + l_xckk.xckk104c
      LET l_xckk.xckk106d = l_xckk.xckk102d + l_xckk.xckk104d
      LET l_xckk.xckk106e = l_xckk.xckk102e + l_xckk.xckk104e
      LET l_xckk.xckk106f = l_xckk.xckk102f + l_xckk.xckk104f
      LET l_xckk.xckk106g = l_xckk.xckk102g + l_xckk.xckk104g
      LET l_xckk.xckk106h = l_xckk.xckk102h + l_xckk.xckk104h
   ELSE
   #160531-00032#1---e
      LET l_xckk.xckk105 = l_xckk.xckk101 - l_xckk.xckk103
      LET l_xckk.xckk106 = l_xckk.xckk102 - l_xckk.xckk104
      LET l_xckk.xckk106a = l_xckk.xckk102a - l_xckk.xckk104a
      LET l_xckk.xckk106b = l_xckk.xckk102b - l_xckk.xckk104b
      LET l_xckk.xckk106c = l_xckk.xckk102c - l_xckk.xckk104c
      LET l_xckk.xckk106d = l_xckk.xckk102d - l_xckk.xckk104d
      LET l_xckk.xckk106e = l_xckk.xckk102e - l_xckk.xckk104e
      LET l_xckk.xckk106f = l_xckk.xckk102f - l_xckk.xckk104f
      LET l_xckk.xckk106g = l_xckk.xckk102g - l_xckk.xckk104g
      LET l_xckk.xckk106h = l_xckk.xckk102h - l_xckk.xckk104h
   END IF #160531-00032#1
   
   SELECT gzcb003 INTO l_xckk.xckk090 FROM gzcb_t WHERE gzcb001 = '8922' AND gzcb002 = l_xckk.xckk005
   
   INSERT INTO xckk_t (xckkent,xckkcomp,xckkld,xckk001,xckk002,xckk003,xckk004,xckk005,xckk090,
                       xckk101,xckk102,xckk102a,xckk102b,xckk102c,xckk102d,xckk102e,xckk102f,xckk102g,xckk102h,
                       xckk103,xckk104,xckk104a,xckk104b,xckk104c,xckk104d,xckk104e,xckk104f,xckk104g,xckk104h,
                       xckk105,xckk106,xckk106a,xckk106b,xckk106c,xckk106d,xckk106e,xckk106f,xckk106g,xckk106h)
       VALUES (l_xckk.xckkent, l_xckk.xckkcomp,l_xckk.xckkld,  l_xckk.xckk001, l_xckk.xckk002,
               l_xckk.xckk003, l_xckk.xckk004, l_xckk.xckk005, l_xckk.xckk090,
               l_xckk.xckk101, l_xckk.xckk102, l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,
               l_xckk.xckk102d,l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h,
               l_xckk.xckk103, l_xckk.xckk104, l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,
               l_xckk.xckk104d,l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h,
               l_xckk.xckk105, l_xckk.xckk106, l_xckk.xckk106a,l_xckk.xckk106b,l_xckk.xckk106c,
               l_xckk.xckk106d,l_xckk.xckk106e,l_xckk.xckk106f,l_xckk.xckk106g,l_xckk.xckk106h)
   
   IF SQLCA.sqlcode  THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xckk_t:"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      CALL s_transaction_end('N','0')                    
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   #金額或數量存在差異的部分，則按料号+特性+批号+成本域找出差异并写入xckl
   IF l_xckk.xckk105 <> 0 OR l_xckk.xckk106 <> 0 THEN
      #161109-00085#26-s mod
      #IF NOT axcq603_gen_xckl(l_xckk.*) THEN   #161109-00085#26-s mark
      #170220-00001#1----s
      #IF NOT axcq603_gen_xckl(l_xckk.xckkent,l_xckk.xckkcomp,l_xckk.xckkld,l_xckk.xckk001,l_xckk.xckk002,
      #                        l_xckk.xckk003,l_xckk.xckk004,l_xckk.xckk005,l_xckk.xckk090,l_xckk.xckk101,
      #                        l_xckk.xckk102,l_xckk.xckk102a,l_xckk.xckk102b,l_xckk.xckk102c,l_xckk.xckk102d,
      #                        l_xckk.xckk102e,l_xckk.xckk102f,l_xckk.xckk102g,l_xckk.xckk102h,l_xckk.xckk103,
      #                        l_xckk.xckk104,l_xckk.xckk104a,l_xckk.xckk104b,l_xckk.xckk104c,l_xckk.xckk104d,
      #                        l_xckk.xckk104e,l_xckk.xckk104f,l_xckk.xckk104g,l_xckk.xckk104h,l_xckk.xckk105,
      #                        l_xckk.xckk106,l_xckk.xckk106a,l_xckk.xckk106b,l_xckk.xckk106c,l_xckk.xckk106d,
      #                        l_xckk.xckk106e,l_xckk.xckk106f,l_xckk.xckk106g,l_xckk.xckk106h) THEN
      IF NOT axcq603_insert_xckl(l_xckk.xckk005,l_xckk.xckk090) THEN
      #170220-00001#1----e
      #161109-00085#26-e mod
         CALL s_transaction_end('N','0')   
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF 
   
   CALL s_transaction_end('Y','0')      

   RETURN r_success
   
END FUNCTION

#插入成本勾稽明細表xckl_t
PRIVATE FUNCTION axcq603_gen_xckl(p_xckk)
#161109-00085#26-s mod
#DEFINE p_xckk          RECORD LIKE xckk_t.*   #161109-00085#26-s mark
DEFINE p_xckk          RECORD  #成本勾稽表
       xckkent LIKE xckk_t.xckkent, #企業編號
       xckkcomp LIKE xckk_t.xckkcomp, #法人組織
       xckkld LIKE xckk_t.xckkld, #帳套
       xckk001 LIKE xckk_t.xckk001, #本位幣順序
       xckk002 LIKE xckk_t.xckk002, #成本計算類型
       xckk003 LIKE xckk_t.xckk003, #年度
       xckk004 LIKE xckk_t.xckk004, #期別
       xckk005 LIKE xckk_t.xckk005, #
       xckk090 LIKE xckk_t.xckk090, #明細程式編號
       xckk101 LIKE xckk_t.xckk101, #總報表數量
       xckk102 LIKE xckk_t.xckk102, #總報表金額
       xckk102a LIKE xckk_t.xckk102a, #材料
       xckk102b LIKE xckk_t.xckk102b, #人工
       xckk102c LIKE xckk_t.xckk102c, #加工
       xckk102d LIKE xckk_t.xckk102d, #制費一
       xckk102e LIKE xckk_t.xckk102e, #制費二
       xckk102f LIKE xckk_t.xckk102f, #制費三
       xckk102g LIKE xckk_t.xckk102g, #製費四
       xckk102h LIKE xckk_t.xckk102h, #制費五
       xckk103 LIKE xckk_t.xckk103, #分報表數量
       xckk104 LIKE xckk_t.xckk104, #分報表金額
       xckk104a LIKE xckk_t.xckk104a, #分報表材料
       xckk104b LIKE xckk_t.xckk104b, #分報表人工
       xckk104c LIKE xckk_t.xckk104c, #分報表加工
       xckk104d LIKE xckk_t.xckk104d, #分報表制費一
       xckk104e LIKE xckk_t.xckk104e, #分報表制費二
       xckk104f LIKE xckk_t.xckk104f, #分報表制費三
       xckk104g LIKE xckk_t.xckk104g, #分報表制費四
       xckk104h LIKE xckk_t.xckk104h, #分報表制費五
       xckk105 LIKE xckk_t.xckk105, #差異數量
       xckk106 LIKE xckk_t.xckk106, #差異金額
       xckk106a LIKE xckk_t.xckk106a, #差異金額-材料
       xckk106b LIKE xckk_t.xckk106b, #差異金額-人工
       xckk106c LIKE xckk_t.xckk106c, #差異金額-加工
       xckk106d LIKE xckk_t.xckk106d, #差異金額-制費一
       xckk106e LIKE xckk_t.xckk106e, #差異金額-制費二
       xckk106f LIKE xckk_t.xckk106f, #差異金額-制費三
       xckk106g LIKE xckk_t.xckk106g, #差異金額-制費四
       xckk106h LIKE xckk_t.xckk106h  #差異金額-制費五
                END RECORD
#161109-00085#26-e mod
DEFINE r_success    LIKE type_t.num5

   LET r_success = TRUE

#161109-00085#26-s mod
#161109-00085#26-s mark
#   CASE p_xckk.xckk005            
#      WHEN '103'   #库存开账调整
#         IF NOT axcq603_gen_xckl_1(p_xckk.*) THEN
#            LET r_success = FALSE
#            RETURN r_success
#         END IF
#      WHEN '101'   #库存期初
#         IF NOT axcq603_gen_xckl_1(p_xckk.*) THEN
#            LET r_success = FALSE
#            RETURN r_success
#         END IF
#      WHEN '102'   #一般采购
#         IF NOT axcq603_gen_xckl_2(p_xckk.*) THEN
#            LET r_success = FALSE
#            RETURN r_success
#         END IF
#      WHEN '117'   #委外入库
#         IF NOT axcq603_gen_xckl_2(p_xckk.*) THEN
#            LET r_success = FALSE
#            RETURN r_success
#         END IF
#      WHEN '105'   #工单入库
#         IF NOT axcq603_gen_xckl_2(p_xckk.*) THEN
#            LET r_success = FALSE
#            RETURN r_success
#         END IF
#      WHEN '115'   #返工入库
#         IF NOT axcq603_gen_xckl_2(p_xckk.*) THEN
#            LET r_success = FALSE
#            RETURN r_success
#         END IF
#      WHEN '104'   #杂项入库
#         IF NOT axcq603_gen_xckl_2(p_xckk.*) THEN
#            LET r_success = FALSE
#            RETURN r_success
#         END IF
#      WHEN '118'   #调拨入库
#         IF NOT axcq603_gen_xckl_2(p_xckk.*) THEN
#            LET r_success = FALSE
#            RETURN r_success
#         END IF
#      WHEN '112'   #销退成本
#         IF NOT axcq603_gen_xckl_2(p_xckk.*) THEN
#            LET r_success = FALSE
#            RETURN r_success
#         END IF
#      WHEN '106'   #当站下线和入库调整
#         IF NOT axcq603_gen_xckl_3(p_xckk.*) THEN
#            LET r_success = FALSE
#            RETURN r_success
#         END IF
#      WHEN '114'   #返工领出
#         IF NOT axcq603_gen_xckl_2(p_xckk.*) THEN
#            LET r_success = FALSE
#            RETURN r_success
#         END IF
#      WHEN '107'   #工单发料
#         IF NOT axcq603_gen_xckl_2(p_xckk.*) THEN
#            LET r_success = FALSE
#            RETURN r_success
#         END IF
#      WHEN '108'   #杂项发料
#         IF NOT axcq603_gen_xckl_2(p_xckk.*) THEN
#            LET r_success = FALSE
#            RETURN r_success
#         END IF
#      WHEN '110'   #销售出货
#         IF NOT axcq603_gen_xckl_2(p_xckk.*) THEN
#            LET r_success = FALSE
#            RETURN r_success
#         END IF
#      WHEN '111'   #销售费用
#         IF NOT axcq603_gen_xckl_2(p_xckk.*) THEN
#            LET r_success = FALSE
#            RETURN r_success
#         END IF
#      WHEN '109'   #盘盈亏
#         IF NOT axcq603_gen_xckl_2(p_xckk.*) THEN
#            LET r_success = FALSE
#            RETURN r_success
#         END IF
#      WHEN '119'   #调拨出库
#         IF NOT axcq603_gen_xckl_2(p_xckk.*) THEN
#            LET r_success = FALSE
#            RETURN r_success
#         END IF
#      WHEN '215'   #在制开账调整 
#         IF NOT axcq603_gen_xckl_4(p_xckk.*) THEN
#            LET r_success = FALSE
#            RETURN r_success
#         END IF
#      WHEN '201'   #在制期初 
#         IF NOT axcq603_gen_xckl_4(p_xckk.*) THEN
#            LET r_success = FALSE
#            RETURN r_success
#         END IF
#      WHEN '216'   #原料投入
#         IF NOT axcq603_gen_xckl_5(p_xckk.*) THEN
#            LET r_success = FALSE
#            RETURN r_success
#         END IF
#      WHEN '217'   #半成品投入
#         IF NOT axcq603_gen_xckl_5(p_xckk.*) THEN
#            LET r_success = FALSE
#            RETURN r_success
#         END IF
#      WHEN '200'   #在制人工费
#         IF NOT axcq603_gen_xckl_8(p_xckk.*) THEN
#            LET r_success = FALSE
#            RETURN r_success
#         END IF
#      WHEN '210'   #在制调整
#         IF NOT axcq603_gen_xckl_6(p_xckk.*) THEN
#            LET r_success = FALSE
#            RETURN r_success
#         END IF
#      WHEN '211'   #在制转出
#         IF NOT axcq603_gen_xckl_7(p_xckk.*) THEN
#            LET r_success = FALSE
#            RETURN r_success
#         END IF
#      WHEN '301'   #拆件期初
#         IF NOT axcq603_gen_xckl_4(p_xckk.*) THEN
#            LET r_success = FALSE
#            RETURN r_success
#         END IF
#      WHEN '302'   #拆件投入
#         IF NOT axcq603_gen_xckl_5(p_xckk.*) THEN
#            LET r_success = FALSE
#            RETURN r_success
#         END IF
#      WHEN '306'   #拆件人工费
#         IF NOT axcq603_gen_xckl_8(p_xckk.*) THEN
#            LET r_success = FALSE
#            RETURN r_success
#         END IF
#      WHEN '303'   #拆件拆出
#         IF NOT axcq603_gen_xckl_7(p_xckk.*) THEN
#            LET r_success = FALSE
#            RETURN r_success
#         END IF
#   END CASE
#161109-00085#26-e mark
CASE p_xckk.xckk005 
      WHEN '103'   #库存开账调整
         IF NOT axcq603_gen_xckl_1(p_xckk.xckkent,p_xckk.xckkcomp,p_xckk.xckkld,p_xckk.xckk001,p_xckk.xckk002,
                                   p_xckk.xckk003,p_xckk.xckk004,p_xckk.xckk005,p_xckk.xckk090,p_xckk.xckk101,
                                   p_xckk.xckk102,p_xckk.xckk102a,p_xckk.xckk102b,p_xckk.xckk102c,p_xckk.xckk102d,
                                   p_xckk.xckk102e,p_xckk.xckk102f,p_xckk.xckk102g,p_xckk.xckk102h,p_xckk.xckk103,
                                   p_xckk.xckk104,p_xckk.xckk104a,p_xckk.xckk104b,p_xckk.xckk104c,p_xckk.xckk104d,
                                   p_xckk.xckk104e,p_xckk.xckk104f,p_xckk.xckk104g,p_xckk.xckk104h,p_xckk.xckk105,
                                   p_xckk.xckk106,p_xckk.xckk106a,p_xckk.xckk106b,p_xckk.xckk106c,p_xckk.xckk106d,
                                   p_xckk.xckk106e,p_xckk.xckk106f,p_xckk.xckk106g,p_xckk.xckk106h) THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
      WHEN '101'   #库存期初
         IF NOT axcq603_gen_xckl_1(p_xckk.xckkent,p_xckk.xckkcomp,p_xckk.xckkld,p_xckk.xckk001,p_xckk.xckk002,
                                   p_xckk.xckk003,p_xckk.xckk004,p_xckk.xckk005,p_xckk.xckk090,p_xckk.xckk101,
                                   p_xckk.xckk102,p_xckk.xckk102a,p_xckk.xckk102b,p_xckk.xckk102c,p_xckk.xckk102d,
                                   p_xckk.xckk102e,p_xckk.xckk102f,p_xckk.xckk102g,p_xckk.xckk102h,p_xckk.xckk103,
                                   p_xckk.xckk104,p_xckk.xckk104a,p_xckk.xckk104b,p_xckk.xckk104c,p_xckk.xckk104d,
                                   p_xckk.xckk104e,p_xckk.xckk104f,p_xckk.xckk104g,p_xckk.xckk104h,p_xckk.xckk105,
                                   p_xckk.xckk106,p_xckk.xckk106a,p_xckk.xckk106b,p_xckk.xckk106c,p_xckk.xckk106d,
                                   p_xckk.xckk106e,p_xckk.xckk106f,p_xckk.xckk106g,p_xckk.xckk106h) THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
      WHEN '102'   #一般采购
         IF NOT axcq603_gen_xckl_2(p_xckk.xckkent,p_xckk.xckkcomp,p_xckk.xckkld,p_xckk.xckk001,p_xckk.xckk002,
                                   p_xckk.xckk003,p_xckk.xckk004,p_xckk.xckk005,p_xckk.xckk090,p_xckk.xckk101,
                                   p_xckk.xckk102,p_xckk.xckk102a,p_xckk.xckk102b,p_xckk.xckk102c,p_xckk.xckk102d,
                                   p_xckk.xckk102e,p_xckk.xckk102f,p_xckk.xckk102g,p_xckk.xckk102h,p_xckk.xckk103,
                                   p_xckk.xckk104,p_xckk.xckk104a,p_xckk.xckk104b,p_xckk.xckk104c,p_xckk.xckk104d,
                                   p_xckk.xckk104e,p_xckk.xckk104f,p_xckk.xckk104g,p_xckk.xckk104h,p_xckk.xckk105,
                                   p_xckk.xckk106,p_xckk.xckk106a,p_xckk.xckk106b,p_xckk.xckk106c,p_xckk.xckk106d,
                                   p_xckk.xckk106e,p_xckk.xckk106f,p_xckk.xckk106g,p_xckk.xckk106h) THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
      WHEN '117'   #委外入库
         IF NOT axcq603_gen_xckl_2(p_xckk.xckkent,p_xckk.xckkcomp,p_xckk.xckkld,p_xckk.xckk001,p_xckk.xckk002,
                                   p_xckk.xckk003,p_xckk.xckk004,p_xckk.xckk005,p_xckk.xckk090,p_xckk.xckk101,
                                   p_xckk.xckk102,p_xckk.xckk102a,p_xckk.xckk102b,p_xckk.xckk102c,p_xckk.xckk102d,
                                   p_xckk.xckk102e,p_xckk.xckk102f,p_xckk.xckk102g,p_xckk.xckk102h,p_xckk.xckk103,
                                   p_xckk.xckk104,p_xckk.xckk104a,p_xckk.xckk104b,p_xckk.xckk104c,p_xckk.xckk104d,
                                   p_xckk.xckk104e,p_xckk.xckk104f,p_xckk.xckk104g,p_xckk.xckk104h,p_xckk.xckk105,
                                   p_xckk.xckk106,p_xckk.xckk106a,p_xckk.xckk106b,p_xckk.xckk106c,p_xckk.xckk106d,
                                   p_xckk.xckk106e,p_xckk.xckk106f,p_xckk.xckk106g,p_xckk.xckk106h) THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
      WHEN '105'   #工单入库
         IF NOT axcq603_gen_xckl_2(p_xckk.xckkent,p_xckk.xckkcomp,p_xckk.xckkld,p_xckk.xckk001,p_xckk.xckk002,
                                   p_xckk.xckk003,p_xckk.xckk004,p_xckk.xckk005,p_xckk.xckk090,p_xckk.xckk101,
                                   p_xckk.xckk102,p_xckk.xckk102a,p_xckk.xckk102b,p_xckk.xckk102c,p_xckk.xckk102d,
                                   p_xckk.xckk102e,p_xckk.xckk102f,p_xckk.xckk102g,p_xckk.xckk102h,p_xckk.xckk103,
                                   p_xckk.xckk104,p_xckk.xckk104a,p_xckk.xckk104b,p_xckk.xckk104c,p_xckk.xckk104d,
                                   p_xckk.xckk104e,p_xckk.xckk104f,p_xckk.xckk104g,p_xckk.xckk104h,p_xckk.xckk105,
                                   p_xckk.xckk106,p_xckk.xckk106a,p_xckk.xckk106b,p_xckk.xckk106c,p_xckk.xckk106d,
                                   p_xckk.xckk106e,p_xckk.xckk106f,p_xckk.xckk106g,p_xckk.xckk106h) THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
      WHEN '115'   #返工入库
         IF NOT axcq603_gen_xckl_2(p_xckk.xckkent,p_xckk.xckkcomp,p_xckk.xckkld,p_xckk.xckk001,p_xckk.xckk002,
                                   p_xckk.xckk003,p_xckk.xckk004,p_xckk.xckk005,p_xckk.xckk090,p_xckk.xckk101,
                                   p_xckk.xckk102,p_xckk.xckk102a,p_xckk.xckk102b,p_xckk.xckk102c,p_xckk.xckk102d,
                                   p_xckk.xckk102e,p_xckk.xckk102f,p_xckk.xckk102g,p_xckk.xckk102h,p_xckk.xckk103,
                                   p_xckk.xckk104,p_xckk.xckk104a,p_xckk.xckk104b,p_xckk.xckk104c,p_xckk.xckk104d,
                                   p_xckk.xckk104e,p_xckk.xckk104f,p_xckk.xckk104g,p_xckk.xckk104h,p_xckk.xckk105,
                                   p_xckk.xckk106,p_xckk.xckk106a,p_xckk.xckk106b,p_xckk.xckk106c,p_xckk.xckk106d,
                                   p_xckk.xckk106e,p_xckk.xckk106f,p_xckk.xckk106g,p_xckk.xckk106h) THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
      WHEN '104'   #杂项入库
         IF NOT axcq603_gen_xckl_2(p_xckk.xckkent,p_xckk.xckkcomp,p_xckk.xckkld,p_xckk.xckk001,p_xckk.xckk002,
                                   p_xckk.xckk003,p_xckk.xckk004,p_xckk.xckk005,p_xckk.xckk090,p_xckk.xckk101,
                                   p_xckk.xckk102,p_xckk.xckk102a,p_xckk.xckk102b,p_xckk.xckk102c,p_xckk.xckk102d,
                                   p_xckk.xckk102e,p_xckk.xckk102f,p_xckk.xckk102g,p_xckk.xckk102h,p_xckk.xckk103,
                                   p_xckk.xckk104,p_xckk.xckk104a,p_xckk.xckk104b,p_xckk.xckk104c,p_xckk.xckk104d,
                                   p_xckk.xckk104e,p_xckk.xckk104f,p_xckk.xckk104g,p_xckk.xckk104h,p_xckk.xckk105,
                                   p_xckk.xckk106,p_xckk.xckk106a,p_xckk.xckk106b,p_xckk.xckk106c,p_xckk.xckk106d,
                                   p_xckk.xckk106e,p_xckk.xckk106f,p_xckk.xckk106g,p_xckk.xckk106h) THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
      WHEN '118'   #调拨入库
         IF NOT axcq603_gen_xckl_2(p_xckk.xckkent,p_xckk.xckkcomp,p_xckk.xckkld,p_xckk.xckk001,p_xckk.xckk002,
                                   p_xckk.xckk003,p_xckk.xckk004,p_xckk.xckk005,p_xckk.xckk090,p_xckk.xckk101,
                                   p_xckk.xckk102,p_xckk.xckk102a,p_xckk.xckk102b,p_xckk.xckk102c,p_xckk.xckk102d,
                                   p_xckk.xckk102e,p_xckk.xckk102f,p_xckk.xckk102g,p_xckk.xckk102h,p_xckk.xckk103,
                                   p_xckk.xckk104,p_xckk.xckk104a,p_xckk.xckk104b,p_xckk.xckk104c,p_xckk.xckk104d,
                                   p_xckk.xckk104e,p_xckk.xckk104f,p_xckk.xckk104g,p_xckk.xckk104h,p_xckk.xckk105,
                                   p_xckk.xckk106,p_xckk.xckk106a,p_xckk.xckk106b,p_xckk.xckk106c,p_xckk.xckk106d,
                                   p_xckk.xckk106e,p_xckk.xckk106f,p_xckk.xckk106g,p_xckk.xckk106h) THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
      WHEN '112'   #销退成本
         IF NOT axcq603_gen_xckl_2(p_xckk.xckkent,p_xckk.xckkcomp,p_xckk.xckkld,p_xckk.xckk001,p_xckk.xckk002,
                                   p_xckk.xckk003,p_xckk.xckk004,p_xckk.xckk005,p_xckk.xckk090,p_xckk.xckk101,
                                   p_xckk.xckk102,p_xckk.xckk102a,p_xckk.xckk102b,p_xckk.xckk102c,p_xckk.xckk102d,
                                   p_xckk.xckk102e,p_xckk.xckk102f,p_xckk.xckk102g,p_xckk.xckk102h,p_xckk.xckk103,
                                   p_xckk.xckk104,p_xckk.xckk104a,p_xckk.xckk104b,p_xckk.xckk104c,p_xckk.xckk104d,
                                   p_xckk.xckk104e,p_xckk.xckk104f,p_xckk.xckk104g,p_xckk.xckk104h,p_xckk.xckk105,
                                   p_xckk.xckk106,p_xckk.xckk106a,p_xckk.xckk106b,p_xckk.xckk106c,p_xckk.xckk106d,
                                   p_xckk.xckk106e,p_xckk.xckk106f,p_xckk.xckk106g,p_xckk.xckk106h) THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
      WHEN '106'   #当站下线和入库调整
         IF NOT axcq603_gen_xckl_3(p_xckk.xckkent,p_xckk.xckkcomp,p_xckk.xckkld,p_xckk.xckk001,p_xckk.xckk002,
                                   p_xckk.xckk003,p_xckk.xckk004,p_xckk.xckk005,p_xckk.xckk090,p_xckk.xckk101,
                                   p_xckk.xckk102,p_xckk.xckk102a,p_xckk.xckk102b,p_xckk.xckk102c,p_xckk.xckk102d,
                                   p_xckk.xckk102e,p_xckk.xckk102f,p_xckk.xckk102g,p_xckk.xckk102h,p_xckk.xckk103,
                                   p_xckk.xckk104,p_xckk.xckk104a,p_xckk.xckk104b,p_xckk.xckk104c,p_xckk.xckk104d,
                                   p_xckk.xckk104e,p_xckk.xckk104f,p_xckk.xckk104g,p_xckk.xckk104h,p_xckk.xckk105,
                                   p_xckk.xckk106,p_xckk.xckk106a,p_xckk.xckk106b,p_xckk.xckk106c,p_xckk.xckk106d,
                                   p_xckk.xckk106e,p_xckk.xckk106f,p_xckk.xckk106g,p_xckk.xckk106h) THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
      WHEN '114'   #返工领出
         IF NOT axcq603_gen_xckl_2(p_xckk.xckkent,p_xckk.xckkcomp,p_xckk.xckkld,p_xckk.xckk001,p_xckk.xckk002,
                                   p_xckk.xckk003,p_xckk.xckk004,p_xckk.xckk005,p_xckk.xckk090,p_xckk.xckk101,
                                   p_xckk.xckk102,p_xckk.xckk102a,p_xckk.xckk102b,p_xckk.xckk102c,p_xckk.xckk102d,
                                   p_xckk.xckk102e,p_xckk.xckk102f,p_xckk.xckk102g,p_xckk.xckk102h,p_xckk.xckk103,
                                   p_xckk.xckk104,p_xckk.xckk104a,p_xckk.xckk104b,p_xckk.xckk104c,p_xckk.xckk104d,
                                   p_xckk.xckk104e,p_xckk.xckk104f,p_xckk.xckk104g,p_xckk.xckk104h,p_xckk.xckk105,
                                   p_xckk.xckk106,p_xckk.xckk106a,p_xckk.xckk106b,p_xckk.xckk106c,p_xckk.xckk106d,
                                   p_xckk.xckk106e,p_xckk.xckk106f,p_xckk.xckk106g,p_xckk.xckk106h) THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
      WHEN '107'   #工单发料
         IF NOT axcq603_gen_xckl_2(p_xckk.xckkent,p_xckk.xckkcomp,p_xckk.xckkld,p_xckk.xckk001,p_xckk.xckk002,
                                   p_xckk.xckk003,p_xckk.xckk004,p_xckk.xckk005,p_xckk.xckk090,p_xckk.xckk101,
                                   p_xckk.xckk102,p_xckk.xckk102a,p_xckk.xckk102b,p_xckk.xckk102c,p_xckk.xckk102d,
                                   p_xckk.xckk102e,p_xckk.xckk102f,p_xckk.xckk102g,p_xckk.xckk102h,p_xckk.xckk103,
                                   p_xckk.xckk104,p_xckk.xckk104a,p_xckk.xckk104b,p_xckk.xckk104c,p_xckk.xckk104d,
                                   p_xckk.xckk104e,p_xckk.xckk104f,p_xckk.xckk104g,p_xckk.xckk104h,p_xckk.xckk105,
                                   p_xckk.xckk106,p_xckk.xckk106a,p_xckk.xckk106b,p_xckk.xckk106c,p_xckk.xckk106d,
                                   p_xckk.xckk106e,p_xckk.xckk106f,p_xckk.xckk106g,p_xckk.xckk106h) THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
      WHEN '108'   #杂项发料
         IF NOT axcq603_gen_xckl_2(p_xckk.xckkent,p_xckk.xckkcomp,p_xckk.xckkld,p_xckk.xckk001,p_xckk.xckk002,
                                   p_xckk.xckk003,p_xckk.xckk004,p_xckk.xckk005,p_xckk.xckk090,p_xckk.xckk101,
                                   p_xckk.xckk102,p_xckk.xckk102a,p_xckk.xckk102b,p_xckk.xckk102c,p_xckk.xckk102d,
                                   p_xckk.xckk102e,p_xckk.xckk102f,p_xckk.xckk102g,p_xckk.xckk102h,p_xckk.xckk103,
                                   p_xckk.xckk104,p_xckk.xckk104a,p_xckk.xckk104b,p_xckk.xckk104c,p_xckk.xckk104d,
                                   p_xckk.xckk104e,p_xckk.xckk104f,p_xckk.xckk104g,p_xckk.xckk104h,p_xckk.xckk105,
                                   p_xckk.xckk106,p_xckk.xckk106a,p_xckk.xckk106b,p_xckk.xckk106c,p_xckk.xckk106d,
                                   p_xckk.xckk106e,p_xckk.xckk106f,p_xckk.xckk106g,p_xckk.xckk106h) THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
      WHEN '110'   #销售出货
         IF NOT axcq603_gen_xckl_2(p_xckk.xckkent,p_xckk.xckkcomp,p_xckk.xckkld,p_xckk.xckk001,p_xckk.xckk002,
                                   p_xckk.xckk003,p_xckk.xckk004,p_xckk.xckk005,p_xckk.xckk090,p_xckk.xckk101,
                                   p_xckk.xckk102,p_xckk.xckk102a,p_xckk.xckk102b,p_xckk.xckk102c,p_xckk.xckk102d,
                                   p_xckk.xckk102e,p_xckk.xckk102f,p_xckk.xckk102g,p_xckk.xckk102h,p_xckk.xckk103,
                                   p_xckk.xckk104,p_xckk.xckk104a,p_xckk.xckk104b,p_xckk.xckk104c,p_xckk.xckk104d,
                                   p_xckk.xckk104e,p_xckk.xckk104f,p_xckk.xckk104g,p_xckk.xckk104h,p_xckk.xckk105,
                                   p_xckk.xckk106,p_xckk.xckk106a,p_xckk.xckk106b,p_xckk.xckk106c,p_xckk.xckk106d,
                                   p_xckk.xckk106e,p_xckk.xckk106f,p_xckk.xckk106g,p_xckk.xckk106h) THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
      WHEN '111'   #销售费用
         IF NOT axcq603_gen_xckl_2(p_xckk.xckkent,p_xckk.xckkcomp,p_xckk.xckkld,p_xckk.xckk001,p_xckk.xckk002,
                                   p_xckk.xckk003,p_xckk.xckk004,p_xckk.xckk005,p_xckk.xckk090,p_xckk.xckk101,
                                   p_xckk.xckk102,p_xckk.xckk102a,p_xckk.xckk102b,p_xckk.xckk102c,p_xckk.xckk102d,
                                   p_xckk.xckk102e,p_xckk.xckk102f,p_xckk.xckk102g,p_xckk.xckk102h,p_xckk.xckk103,
                                   p_xckk.xckk104,p_xckk.xckk104a,p_xckk.xckk104b,p_xckk.xckk104c,p_xckk.xckk104d,
                                   p_xckk.xckk104e,p_xckk.xckk104f,p_xckk.xckk104g,p_xckk.xckk104h,p_xckk.xckk105,
                                   p_xckk.xckk106,p_xckk.xckk106a,p_xckk.xckk106b,p_xckk.xckk106c,p_xckk.xckk106d,
                                   p_xckk.xckk106e,p_xckk.xckk106f,p_xckk.xckk106g,p_xckk.xckk106h) THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
      WHEN '109'   #盘盈亏
         IF NOT axcq603_gen_xckl_2(p_xckk.xckkent,p_xckk.xckkcomp,p_xckk.xckkld,p_xckk.xckk001,p_xckk.xckk002,
                                   p_xckk.xckk003,p_xckk.xckk004,p_xckk.xckk005,p_xckk.xckk090,p_xckk.xckk101,
                                   p_xckk.xckk102,p_xckk.xckk102a,p_xckk.xckk102b,p_xckk.xckk102c,p_xckk.xckk102d,
                                   p_xckk.xckk102e,p_xckk.xckk102f,p_xckk.xckk102g,p_xckk.xckk102h,p_xckk.xckk103,
                                   p_xckk.xckk104,p_xckk.xckk104a,p_xckk.xckk104b,p_xckk.xckk104c,p_xckk.xckk104d,
                                   p_xckk.xckk104e,p_xckk.xckk104f,p_xckk.xckk104g,p_xckk.xckk104h,p_xckk.xckk105,
                                   p_xckk.xckk106,p_xckk.xckk106a,p_xckk.xckk106b,p_xckk.xckk106c,p_xckk.xckk106d,
                                   p_xckk.xckk106e,p_xckk.xckk106f,p_xckk.xckk106g,p_xckk.xckk106h) THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
      WHEN '119'   #调拨出库
         IF NOT axcq603_gen_xckl_2(p_xckk.xckkent,p_xckk.xckkcomp,p_xckk.xckkld,p_xckk.xckk001,p_xckk.xckk002,
                                   p_xckk.xckk003,p_xckk.xckk004,p_xckk.xckk005,p_xckk.xckk090,p_xckk.xckk101,
                                   p_xckk.xckk102,p_xckk.xckk102a,p_xckk.xckk102b,p_xckk.xckk102c,p_xckk.xckk102d,
                                   p_xckk.xckk102e,p_xckk.xckk102f,p_xckk.xckk102g,p_xckk.xckk102h,p_xckk.xckk103,
                                   p_xckk.xckk104,p_xckk.xckk104a,p_xckk.xckk104b,p_xckk.xckk104c,p_xckk.xckk104d,
                                   p_xckk.xckk104e,p_xckk.xckk104f,p_xckk.xckk104g,p_xckk.xckk104h,p_xckk.xckk105,
                                   p_xckk.xckk106,p_xckk.xckk106a,p_xckk.xckk106b,p_xckk.xckk106c,p_xckk.xckk106d,
                                   p_xckk.xckk106e,p_xckk.xckk106f,p_xckk.xckk106g,p_xckk.xckk106h) THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
      WHEN '215'   #在制开账调整 
         IF NOT axcq603_gen_xckl_4(p_xckk.xckkent,p_xckk.xckkcomp,p_xckk.xckkld,p_xckk.xckk001,p_xckk.xckk002,
                                   p_xckk.xckk003,p_xckk.xckk004,p_xckk.xckk005,p_xckk.xckk090,p_xckk.xckk101,
                                   p_xckk.xckk102,p_xckk.xckk102a,p_xckk.xckk102b,p_xckk.xckk102c,p_xckk.xckk102d,
                                   p_xckk.xckk102e,p_xckk.xckk102f,p_xckk.xckk102g,p_xckk.xckk102h,p_xckk.xckk103,
                                   p_xckk.xckk104,p_xckk.xckk104a,p_xckk.xckk104b,p_xckk.xckk104c,p_xckk.xckk104d,
                                   p_xckk.xckk104e,p_xckk.xckk104f,p_xckk.xckk104g,p_xckk.xckk104h,p_xckk.xckk105,
                                   p_xckk.xckk106,p_xckk.xckk106a,p_xckk.xckk106b,p_xckk.xckk106c,p_xckk.xckk106d,
                                   p_xckk.xckk106e,p_xckk.xckk106f,p_xckk.xckk106g,p_xckk.xckk106h) THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
      WHEN '201'   #在制期初 
         IF NOT axcq603_gen_xckl_4(p_xckk.xckkent,p_xckk.xckkcomp,p_xckk.xckkld,p_xckk.xckk001,p_xckk.xckk002,
                                   p_xckk.xckk003,p_xckk.xckk004,p_xckk.xckk005,p_xckk.xckk090,p_xckk.xckk101,
                                   p_xckk.xckk102,p_xckk.xckk102a,p_xckk.xckk102b,p_xckk.xckk102c,p_xckk.xckk102d,
                                   p_xckk.xckk102e,p_xckk.xckk102f,p_xckk.xckk102g,p_xckk.xckk102h,p_xckk.xckk103,
                                   p_xckk.xckk104,p_xckk.xckk104a,p_xckk.xckk104b,p_xckk.xckk104c,p_xckk.xckk104d,
                                   p_xckk.xckk104e,p_xckk.xckk104f,p_xckk.xckk104g,p_xckk.xckk104h,p_xckk.xckk105,
                                   p_xckk.xckk106,p_xckk.xckk106a,p_xckk.xckk106b,p_xckk.xckk106c,p_xckk.xckk106d,
                                   p_xckk.xckk106e,p_xckk.xckk106f,p_xckk.xckk106g,p_xckk.xckk106h) THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
      WHEN '216'   #原料投入
         IF NOT axcq603_gen_xckl_5(p_xckk.xckkent,p_xckk.xckkcomp,p_xckk.xckkld,p_xckk.xckk001,p_xckk.xckk002,
                                   p_xckk.xckk003,p_xckk.xckk004,p_xckk.xckk005,p_xckk.xckk090,p_xckk.xckk101,
                                   p_xckk.xckk102,p_xckk.xckk102a,p_xckk.xckk102b,p_xckk.xckk102c,p_xckk.xckk102d,
                                   p_xckk.xckk102e,p_xckk.xckk102f,p_xckk.xckk102g,p_xckk.xckk102h,p_xckk.xckk103,
                                   p_xckk.xckk104,p_xckk.xckk104a,p_xckk.xckk104b,p_xckk.xckk104c,p_xckk.xckk104d,
                                   p_xckk.xckk104e,p_xckk.xckk104f,p_xckk.xckk104g,p_xckk.xckk104h,p_xckk.xckk105,
                                   p_xckk.xckk106,p_xckk.xckk106a,p_xckk.xckk106b,p_xckk.xckk106c,p_xckk.xckk106d,
                                   p_xckk.xckk106e,p_xckk.xckk106f,p_xckk.xckk106g,p_xckk.xckk106h) THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
      WHEN '217'   #半成品投入
         IF NOT axcq603_gen_xckl_5(p_xckk.xckkent,p_xckk.xckkcomp,p_xckk.xckkld,p_xckk.xckk001,p_xckk.xckk002,
                                   p_xckk.xckk003,p_xckk.xckk004,p_xckk.xckk005,p_xckk.xckk090,p_xckk.xckk101,
                                   p_xckk.xckk102,p_xckk.xckk102a,p_xckk.xckk102b,p_xckk.xckk102c,p_xckk.xckk102d,
                                   p_xckk.xckk102e,p_xckk.xckk102f,p_xckk.xckk102g,p_xckk.xckk102h,p_xckk.xckk103,
                                   p_xckk.xckk104,p_xckk.xckk104a,p_xckk.xckk104b,p_xckk.xckk104c,p_xckk.xckk104d,
                                   p_xckk.xckk104e,p_xckk.xckk104f,p_xckk.xckk104g,p_xckk.xckk104h,p_xckk.xckk105,
                                   p_xckk.xckk106,p_xckk.xckk106a,p_xckk.xckk106b,p_xckk.xckk106c,p_xckk.xckk106d,
                                   p_xckk.xckk106e,p_xckk.xckk106f,p_xckk.xckk106g,p_xckk.xckk106h) THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
      WHEN '200'   #在制人工费
         IF NOT axcq603_gen_xckl_8(p_xckk.xckkent,p_xckk.xckkcomp,p_xckk.xckkld,p_xckk.xckk001,p_xckk.xckk002,
                                   p_xckk.xckk003,p_xckk.xckk004,p_xckk.xckk005,p_xckk.xckk090,p_xckk.xckk101,
                                   p_xckk.xckk102,p_xckk.xckk102a,p_xckk.xckk102b,p_xckk.xckk102c,p_xckk.xckk102d,
                                   p_xckk.xckk102e,p_xckk.xckk102f,p_xckk.xckk102g,p_xckk.xckk102h,p_xckk.xckk103,
                                   p_xckk.xckk104,p_xckk.xckk104a,p_xckk.xckk104b,p_xckk.xckk104c,p_xckk.xckk104d,
                                   p_xckk.xckk104e,p_xckk.xckk104f,p_xckk.xckk104g,p_xckk.xckk104h,p_xckk.xckk105,
                                   p_xckk.xckk106,p_xckk.xckk106a,p_xckk.xckk106b,p_xckk.xckk106c,p_xckk.xckk106d,
                                   p_xckk.xckk106e,p_xckk.xckk106f,p_xckk.xckk106g,p_xckk.xckk106h) THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
      WHEN '210'   #在制调整
         IF NOT axcq603_gen_xckl_6(p_xckk.xckkent,p_xckk.xckkcomp,p_xckk.xckkld,p_xckk.xckk001,p_xckk.xckk002,
                                   p_xckk.xckk003,p_xckk.xckk004,p_xckk.xckk005,p_xckk.xckk090,p_xckk.xckk101,
                                   p_xckk.xckk102,p_xckk.xckk102a,p_xckk.xckk102b,p_xckk.xckk102c,p_xckk.xckk102d,
                                   p_xckk.xckk102e,p_xckk.xckk102f,p_xckk.xckk102g,p_xckk.xckk102h,p_xckk.xckk103,
                                   p_xckk.xckk104,p_xckk.xckk104a,p_xckk.xckk104b,p_xckk.xckk104c,p_xckk.xckk104d,
                                   p_xckk.xckk104e,p_xckk.xckk104f,p_xckk.xckk104g,p_xckk.xckk104h,p_xckk.xckk105,
                                   p_xckk.xckk106,p_xckk.xckk106a,p_xckk.xckk106b,p_xckk.xckk106c,p_xckk.xckk106d,
                                   p_xckk.xckk106e,p_xckk.xckk106f,p_xckk.xckk106g,p_xckk.xckk106h) THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
      WHEN '211'   #在制转出
         IF NOT axcq603_gen_xckl_7(p_xckk.xckkent,p_xckk.xckkcomp,p_xckk.xckkld,p_xckk.xckk001,p_xckk.xckk002,
                                   p_xckk.xckk003,p_xckk.xckk004,p_xckk.xckk005,p_xckk.xckk090,p_xckk.xckk101,
                                   p_xckk.xckk102,p_xckk.xckk102a,p_xckk.xckk102b,p_xckk.xckk102c,p_xckk.xckk102d,
                                   p_xckk.xckk102e,p_xckk.xckk102f,p_xckk.xckk102g,p_xckk.xckk102h,p_xckk.xckk103,
                                   p_xckk.xckk104,p_xckk.xckk104a,p_xckk.xckk104b,p_xckk.xckk104c,p_xckk.xckk104d,
                                   p_xckk.xckk104e,p_xckk.xckk104f,p_xckk.xckk104g,p_xckk.xckk104h,p_xckk.xckk105,
                                   p_xckk.xckk106,p_xckk.xckk106a,p_xckk.xckk106b,p_xckk.xckk106c,p_xckk.xckk106d,
                                   p_xckk.xckk106e,p_xckk.xckk106f,p_xckk.xckk106g,p_xckk.xckk106h) THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
      WHEN '301'   #拆件期初
         IF NOT axcq603_gen_xckl_4(p_xckk.xckkent,p_xckk.xckkcomp,p_xckk.xckkld,p_xckk.xckk001,p_xckk.xckk002,
                                   p_xckk.xckk003,p_xckk.xckk004,p_xckk.xckk005,p_xckk.xckk090,p_xckk.xckk101,
                                   p_xckk.xckk102,p_xckk.xckk102a,p_xckk.xckk102b,p_xckk.xckk102c,p_xckk.xckk102d,
                                   p_xckk.xckk102e,p_xckk.xckk102f,p_xckk.xckk102g,p_xckk.xckk102h,p_xckk.xckk103,
                                   p_xckk.xckk104,p_xckk.xckk104a,p_xckk.xckk104b,p_xckk.xckk104c,p_xckk.xckk104d,
                                   p_xckk.xckk104e,p_xckk.xckk104f,p_xckk.xckk104g,p_xckk.xckk104h,p_xckk.xckk105,
                                   p_xckk.xckk106,p_xckk.xckk106a,p_xckk.xckk106b,p_xckk.xckk106c,p_xckk.xckk106d,
                                   p_xckk.xckk106e,p_xckk.xckk106f,p_xckk.xckk106g,p_xckk.xckk106h) THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
      WHEN '302'   #拆件投入
         IF NOT axcq603_gen_xckl_5(p_xckk.xckkent,p_xckk.xckkcomp,p_xckk.xckkld,p_xckk.xckk001,p_xckk.xckk002,
                                   p_xckk.xckk003,p_xckk.xckk004,p_xckk.xckk005,p_xckk.xckk090,p_xckk.xckk101,
                                   p_xckk.xckk102,p_xckk.xckk102a,p_xckk.xckk102b,p_xckk.xckk102c,p_xckk.xckk102d,
                                   p_xckk.xckk102e,p_xckk.xckk102f,p_xckk.xckk102g,p_xckk.xckk102h,p_xckk.xckk103,
                                   p_xckk.xckk104,p_xckk.xckk104a,p_xckk.xckk104b,p_xckk.xckk104c,p_xckk.xckk104d,
                                   p_xckk.xckk104e,p_xckk.xckk104f,p_xckk.xckk104g,p_xckk.xckk104h,p_xckk.xckk105,
                                   p_xckk.xckk106,p_xckk.xckk106a,p_xckk.xckk106b,p_xckk.xckk106c,p_xckk.xckk106d,
                                   p_xckk.xckk106e,p_xckk.xckk106f,p_xckk.xckk106g,p_xckk.xckk106h) THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
      WHEN '306'   #拆件人工费
         IF NOT axcq603_gen_xckl_8(p_xckk.xckkent,p_xckk.xckkcomp,p_xckk.xckkld,p_xckk.xckk001,p_xckk.xckk002,
                                   p_xckk.xckk003,p_xckk.xckk004,p_xckk.xckk005,p_xckk.xckk090,p_xckk.xckk101,
                                   p_xckk.xckk102,p_xckk.xckk102a,p_xckk.xckk102b,p_xckk.xckk102c,p_xckk.xckk102d,
                                   p_xckk.xckk102e,p_xckk.xckk102f,p_xckk.xckk102g,p_xckk.xckk102h,p_xckk.xckk103,
                                   p_xckk.xckk104,p_xckk.xckk104a,p_xckk.xckk104b,p_xckk.xckk104c,p_xckk.xckk104d,
                                   p_xckk.xckk104e,p_xckk.xckk104f,p_xckk.xckk104g,p_xckk.xckk104h,p_xckk.xckk105,
                                   p_xckk.xckk106,p_xckk.xckk106a,p_xckk.xckk106b,p_xckk.xckk106c,p_xckk.xckk106d,
                                   p_xckk.xckk106e,p_xckk.xckk106f,p_xckk.xckk106g,p_xckk.xckk106h) THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
      WHEN '303'   #拆件拆出
         IF NOT axcq603_gen_xckl_7(p_xckk.xckkent,p_xckk.xckkcomp,p_xckk.xckkld,p_xckk.xckk001,p_xckk.xckk002,
                                   p_xckk.xckk003,p_xckk.xckk004,p_xckk.xckk005,p_xckk.xckk090,p_xckk.xckk101,
                                   p_xckk.xckk102,p_xckk.xckk102a,p_xckk.xckk102b,p_xckk.xckk102c,p_xckk.xckk102d,
                                   p_xckk.xckk102e,p_xckk.xckk102f,p_xckk.xckk102g,p_xckk.xckk102h,p_xckk.xckk103,
                                   p_xckk.xckk104,p_xckk.xckk104a,p_xckk.xckk104b,p_xckk.xckk104c,p_xckk.xckk104d,
                                   p_xckk.xckk104e,p_xckk.xckk104f,p_xckk.xckk104g,p_xckk.xckk104h,p_xckk.xckk105,
                                   p_xckk.xckk106,p_xckk.xckk106a,p_xckk.xckk106b,p_xckk.xckk106c,p_xckk.xckk106d,
                                   p_xckk.xckk106e,p_xckk.xckk106f,p_xckk.xckk106g,p_xckk.xckk106h) THEN
            LET r_success = FALSE
            RETURN r_success
         END IF
   END CASE
#161109-00085#26-e mod  
   RETURN r_success
   
END FUNCTION

#1.明细表抓上期的xcca的数据和金额
#2.明细表抓xccc的上期期末数量和金额，抓不到抓上期的xcca的数据和金额
PRIVATE FUNCTION axcq603_gen_xckl_1(p_xckk)
#161109-00085#26-s mod
#DEFINE p_xckk          RECORD LIKE xckk_t.*   #161109-00085#26-s mark
DEFINE p_xckk          RECORD  #成本勾稽表
       xckkent LIKE xckk_t.xckkent, #企業編號
       xckkcomp LIKE xckk_t.xckkcomp, #法人組織
       xckkld LIKE xckk_t.xckkld, #帳套
       xckk001 LIKE xckk_t.xckk001, #本位幣順序
       xckk002 LIKE xckk_t.xckk002, #成本計算類型
       xckk003 LIKE xckk_t.xckk003, #年度
       xckk004 LIKE xckk_t.xckk004, #期別
       xckk005 LIKE xckk_t.xckk005, #
       xckk090 LIKE xckk_t.xckk090, #明細程式編號
       xckk101 LIKE xckk_t.xckk101, #總報表數量
       xckk102 LIKE xckk_t.xckk102, #總報表金額
       xckk102a LIKE xckk_t.xckk102a, #材料
       xckk102b LIKE xckk_t.xckk102b, #人工
       xckk102c LIKE xckk_t.xckk102c, #加工
       xckk102d LIKE xckk_t.xckk102d, #制費一
       xckk102e LIKE xckk_t.xckk102e, #制費二
       xckk102f LIKE xckk_t.xckk102f, #制費三
       xckk102g LIKE xckk_t.xckk102g, #製費四
       xckk102h LIKE xckk_t.xckk102h, #制費五
       xckk103 LIKE xckk_t.xckk103, #分報表數量
       xckk104 LIKE xckk_t.xckk104, #分報表金額
       xckk104a LIKE xckk_t.xckk104a, #分報表材料
       xckk104b LIKE xckk_t.xckk104b, #分報表人工
       xckk104c LIKE xckk_t.xckk104c, #分報表加工
       xckk104d LIKE xckk_t.xckk104d, #分報表制費一
       xckk104e LIKE xckk_t.xckk104e, #分報表制費二
       xckk104f LIKE xckk_t.xckk104f, #分報表制費三
       xckk104g LIKE xckk_t.xckk104g, #分報表制費四
       xckk104h LIKE xckk_t.xckk104h, #分報表制費五
       xckk105 LIKE xckk_t.xckk105, #差異數量
       xckk106 LIKE xckk_t.xckk106, #差異金額
       xckk106a LIKE xckk_t.xckk106a, #差異金額-材料
       xckk106b LIKE xckk_t.xckk106b, #差異金額-人工
       xckk106c LIKE xckk_t.xckk106c, #差異金額-加工
       xckk106d LIKE xckk_t.xckk106d, #差異金額-制費一
       xckk106e LIKE xckk_t.xckk106e, #差異金額-制費二
       xckk106f LIKE xckk_t.xckk106f, #差異金額-制費三
       xckk106g LIKE xckk_t.xckk106g, #差異金額-制費四
       xckk106h LIKE xckk_t.xckk106h  #差異金額-制費五
                END RECORD
#161109-00085#26-e mod
DEFINE r_success    LIKE type_t.num5
#161109-00085#26-s mod
#DEFINE l_xckl       RECORD LIKE xckl_t.*   #161109-00085#26-s mark
DEFINE l_xckl       RECORD  #成本勾稽明細表
       xcklent LIKE xckl_t.xcklent, #企業編號
       xcklcomp LIKE xckl_t.xcklcomp, #法人組織
       xcklld LIKE xckl_t.xcklld, #帳套
       xckl001 LIKE xckl_t.xckl001, #本位幣順序
       xckl002 LIKE xckl_t.xckl002, #成本計算類型
       xckl003 LIKE xckl_t.xckl003, #年度
       xckl004 LIKE xckl_t.xckl004, #期別
       xckl005 LIKE xckl_t.xckl005, #
       xckl006 LIKE xckl_t.xckl006, #在製單據編號
       xckl007 LIKE xckl_t.xckl007, #料號
       xckl008 LIKE xckl_t.xckl008, #特徵
       xckl009 LIKE xckl_t.xckl009, #批號
       xckl010 LIKE xckl_t.xckl010, #成本域
       xckl090 LIKE xckl_t.xckl090, #明細程式編號
       xckl101 LIKE xckl_t.xckl101, #總報表數量
       xckl102 LIKE xckl_t.xckl102, #總報表金額
       xckl102a LIKE xckl_t.xckl102a, #材料
       xckl102b LIKE xckl_t.xckl102b, #人工
       xckl102c LIKE xckl_t.xckl102c, #加工
       xckl102d LIKE xckl_t.xckl102d, #制費一
       xckl102e LIKE xckl_t.xckl102e, #制費二
       xckl102f LIKE xckl_t.xckl102f, #制費三
       xckl102g LIKE xckl_t.xckl102g, #製費四
       xckl102h LIKE xckl_t.xckl102h, #制費五
       xckl103 LIKE xckl_t.xckl103, #分報表數量
       xckl104 LIKE xckl_t.xckl104, #分報表金額
       xckl104a LIKE xckl_t.xckl104a, #分報表材料
       xckl104b LIKE xckl_t.xckl104b, #分報表人工
       xckl104c LIKE xckl_t.xckl104c, #分報表加工
       xckl104d LIKE xckl_t.xckl104d, #分報表制費一
       xckl104e LIKE xckl_t.xckl104e, #分報表制費二
       xckl104f LIKE xckl_t.xckl104f, #分報表制費三
       xckl104g LIKE xckl_t.xckl104g, #分報表制費四
       xckl104h LIKE xckl_t.xckl104h, #分報表制費五
       xckl105 LIKE xckl_t.xckl105, #差異數量
       xckl106 LIKE xckl_t.xckl106, #差異金額
       xckl106a LIKE xckl_t.xckl106a, #差異金額-材料
       xckl106b LIKE xckl_t.xckl106b, #差異金額-人工
       xckl106c LIKE xckl_t.xckl106c, #差異金額-加工
       xckl106d LIKE xckl_t.xckl106d, #差異金額-制費一
       xckl106e LIKE xckl_t.xckl106e, #差異金額-制費二
       xckl106f LIKE xckl_t.xckl106f, #差異金額-制費三
       xckl106g LIKE xckl_t.xckl106g, #差異金額-制費四
       xckl106h LIKE xckl_t.xckl106h  #差異金額-制費五
          END RECORD
#161109-00085#26-e mod
DEFINE l_sql        STRING
DEFINE l_xckk003    LIKE xckk_t.xckk003
DEFINE l_xckk004    LIKE xckk_t.xckk004

   LET r_success = TRUE
   
   INITIALIZE l_xckl.* TO NULL
   
   LET l_xckl.xcklent = g_enterprise
   LET l_xckl.xcklcomp = g_master.xckkcomp
   LET l_xckl.xcklld = g_master.xckkld
   LET l_xckl.xckl001 = g_master.xckk001
   LET l_xckl.xckl002 = g_master.xckk002
   LET l_xckl.xckl003 = g_master.xckk003
   LET l_xckl.xckl004 = g_master.xckk004  
   LET l_xckl.xckl005 = p_xckk.xckk005
   LET l_xckl.xckl006 = ' ' #在制单据编号
   
   LET l_xckl.xckl090 = p_xckk.xckk090
   
   #从明细表xcca抓资料
   IF g_source = 'xcca' THEN
      #xcca 明細數量、金額
      LET l_sql = "SELECT (CASE WHEN xcca002 IS NULL THEN ' ' ELSE xcca002 END),",
                  "       (CASE WHEN xcca006 IS NULL THEN ' ' ELSE xcca006 END),",
                  "       (CASE WHEN xcca007 IS NULL THEN ' ' ELSE xcca007 END),",
                  "       (CASE WHEN xcca008 IS NULL THEN ' ' ELSE xcca008 END),",
                  "       SUM((CASE WHEN xcca101 IS NULL THEN 0 ELSE xcca101 END)),  SUM((CASE WHEN xcca102 IS NULL THEN 0 ELSE xcca102 END)),  ",
                  "       SUM((CASE WHEN xcca102a IS NULL THEN 0 ELSE xcca102a END)),SUM((CASE WHEN xcca102b IS NULL THEN 0 ELSE xcca102b END)),",
                  "       SUM((CASE WHEN xcca102c IS NULL THEN 0 ELSE xcca102c END)),SUM((CASE WHEN xcca102d IS NULL THEN 0 ELSE xcca102d END)),",
                  "       SUM((CASE WHEN xcca102e IS NULL THEN 0 ELSE xcca102e END)),SUM((CASE WHEN xcca102f IS NULL THEN 0 ELSE xcca102f END)),",
                  "       SUM((CASE WHEN xcca102g IS NULL THEN 0 ELSE xcca102g END)),SUM((CASE WHEN xcca102h IS NULL THEN 0 ELSE xcca102h END)) ",
                  "  FROM xcca_t ",
                  " WHERE xccaent = '",g_enterprise,"' AND xccald = '",g_master.xckkld,"' AND xccacomp = '",g_master.xckkcomp,"' ",
                  "   AND xcca001 = '",g_master.xckk001,"' AND xcca003 = '",g_master.xckk002,"' ",
                  "   AND xcca004 = ? AND xcca005 = ? ",
                  " GROUP BY (CASE WHEN xcca002 IS NULL THEN ' ' ELSE xcca002 END),",
                  "          (CASE WHEN xcca006 IS NULL THEN ' ' ELSE xcca006 END),",
                  "          (CASE WHEN xcca007 IS NULL THEN ' ' ELSE xcca007 END),",
                  "          (CASE WHEN xcca008 IS NULL THEN ' ' ELSE xcca008 END) "
   ELSE
      #抓xccc的上期期末数量和金额
      LET l_sql = "SELECT (CASE WHEN xccc002 IS NULL THEN ' ' ELSE xccc002 END),",
                  "       (CASE WHEN xccc006 IS NULL THEN ' ' ELSE xccc006 END),",
                  "       (CASE WHEN xccc007 IS NULL THEN ' ' ELSE xccc007 END),",
                  "       (CASE WHEN xccc008 IS NULL THEN ' ' ELSE xccc008 END),",
                  "       SUM((CASE WHEN xccc901 IS NULL THEN 0 ELSE xccc901 END)),  SUM((CASE WHEN xccc902 IS NULL THEN 0 ELSE xccc902 END)),  ",
                  "       SUM((CASE WHEN xccc902a IS NULL THEN 0 ELSE xccc902a END)),SUM((CASE WHEN xccc902b IS NULL THEN 0 ELSE xccc902b END)),",
                  "       SUM((CASE WHEN xccc902c IS NULL THEN 0 ELSE xccc902c END)),SUM((CASE WHEN xccc902d IS NULL THEN 0 ELSE xccc902d END)),",
                  "       SUM((CASE WHEN xccc902e IS NULL THEN 0 ELSE xccc902e END)),SUM((CASE WHEN xccc902f IS NULL THEN 0 ELSE xccc902f END)),",
                  "       SUM((CASE WHEN xccc902g IS NULL THEN 0 ELSE xccc902g END)),SUM((CASE WHEN xccc902h IS NULL THEN 0 ELSE xccc902h END)) ",
                  " FROM xccc_t ",
                  " WHERE xcccent = '",g_enterprise,"' AND xcccld = '",g_master.xckkld,"' AND xccccomp = '",g_master.xckkcomp,"' ",
                  "   AND xccc001 = '",g_master.xckk001,"' AND xccc003 = '",g_master.xckk002,"' ",
                  "   AND xccc004 = ? AND xccc005 = ? ",
                  " GROUP BY (CASE WHEN xccc002 IS NULL THEN ' ' ELSE xccc002 END),",
                  "          (CASE WHEN xccc006 IS NULL THEN ' ' ELSE xccc006 END),",
                  "          (CASE WHEN xccc007 IS NULL THEN ' ' ELSE xccc007 END),",
                  "          (CASE WHEN xccc008 IS NULL THEN ' ' ELSE xccc008 END) "
                  
   END IF      
   PREPARE axcq603_sel_xcca_pb1 FROM l_sql
   DECLARE axcq603_sel_xcca_cs1 CURSOR FOR axcq603_sel_xcca_pb1
    
   #根據料件+特性+批號等抓取總表xccc中對應的數量、金額欄位
   LET l_sql = "SELECT SUM((CASE WHEN xccc101 IS NULL THEN 0 ELSE xccc101 END)),  SUM((CASE WHEN xccc102 IS NULL THEN 0 ELSE xccc102 END)),  ",
               "       SUM((CASE WHEN xccc102a IS NULL THEN 0 ELSE xccc102a END)),SUM((CASE WHEN xccc102b IS NULL THEN 0 ELSE xccc102b END)),",
               "       SUM((CASE WHEN xccc102c IS NULL THEN 0 ELSE xccc102c END)),SUM((CASE WHEN xccc102d IS NULL THEN 0 ELSE xccc102d END)),",
               "       SUM((CASE WHEN xccc102e IS NULL THEN 0 ELSE xccc102e END)),SUM((CASE WHEN xccc102f IS NULL THEN 0 ELSE xccc102f END)),",
               "       SUM((CASE WHEN xccc102g IS NULL THEN 0 ELSE xccc102g END)),SUM((CASE WHEN xccc102h IS NULL THEN 0 ELSE xccc102h END)) ",
               "  FROM xccc_t  ",
               " WHERE xcccent = '",g_enterprise,"' AND xcccld = '",g_master.xckkld,"' AND xccccomp = '",g_master.xckkcomp,"' ",
               "   AND xccc001 = '",g_master.xckk001,"' AND xccc003 = '",g_master.xckk002,"' ", 
               "   AND xccc004 = '",g_master.xckk003,"' AND xccc005 = '",g_master.xckk004,"' ",
               "   AND (CASE WHEN xccc002 IS NULL THEN ' ' ELSE xccc002 END) = ? ",
               "   AND (CASE WHEN xccc006 IS NULL THEN ' ' ELSE xccc006 END) = ? ",
               "   AND (CASE WHEN xccc007 IS NULL THEN ' ' ELSE xccc007 END) = ? ",
               "   AND (CASE WHEN xccc008 IS NULL THEN ' ' ELSE xccc008 END) = ? "

   PREPARE axcq603_sel_xccc_pb1 FROM l_sql
   DECLARE axcq603_sel_xccc_cs1 CURSOR FOR axcq603_sel_xccc_pb1
   
   LET l_xckk003 = g_master.xckk003
   LET l_xckk004 = g_master.xckk004
   
   #160707-00034#1---s
   #库存开账调整总表抓xccj
   LET l_sql = " SELECT SUM(xccj101*xccj009),SUM(xccj102*xccj009),SUM(xccj102a*xccj009),SUM(xccj102b*xccj009),SUM(xccj102c*xccj009), ",
               "        SUM(xccj102d*xccj009),SUM(xccj102e*xccj009),SUM(xccj102f*xccj009),SUM(xccj102g*xccj009),SUM(xccj102h*xccj009) ",
               "  FROM xccj_t ",
               " WHERE xccjent  = '",g_enterprise,"' AND xccjcomp = '",g_master.xckkcomp,"' ",    #法人
               "   AND xccjld   = '",g_master.xckkld ,"' AND xccj001  = '",g_master.xckk001,"' ",     #本位币顺序
               "   AND xccj003  = '",g_master.xckk002,"' ",     #成本计算类型
               "   AND xccj004  = '",g_master.xckk003,"' AND xccj005  = '",g_master.xckk004,"' ",
               "   AND (CASE WHEN xccj002 IS NULL THEN ' ' ELSE xccj002 END) = ? ",
               "   AND (CASE WHEN xccj010 IS NULL THEN ' ' ELSE xccj010 END) = ? ",
               "   AND (CASE WHEN xccj011 IS NULL THEN ' ' ELSE xccj011 END) = ? ",
               "   AND (CASE WHEN xccj017 IS NULL THEN ' ' ELSE xccj017 END) = ? "
   PREPARE axcq603_sel_xccj_pb1 FROM l_sql
   DECLARE axcq603_sel_xccj_cs1 CURSOR FOR axcq603_sel_xccj_pb1            
   #160707-00034#1---e
   
   # 库存开账、抓上一期別的明细资料
   CASE p_xckk.xckk005   
      WHEN '103'  #库存开账
         #160707-00034#1---s
         #LET l_xckk003 = g_previous_xckk003
         #LET l_xckk004 = g_previous_xckk004
         IF g_cost_type = '2' THEN   #170210-00001#1 add
            FOREACH axcq603_sel_xcca_cs1 USING l_xckk003,l_xckk004
                                         INTO l_xckl.xckl010, l_xckl.xckl007, l_xckl.xckl008, l_xckl.xckl009,
                                              l_xckl.xckl103, l_xckl.xckl104, l_xckl.xckl104a,l_xckl.xckl104b,l_xckl.xckl104c,
                                              l_xckl.xckl104d,l_xckl.xckl104e,l_xckl.xckl104f,l_xckl.xckl104g,l_xckl.xckl104h   
                                  
               EXECUTE axcq603_sel_xccj_cs1 USING l_xckl.xckl010, l_xckl.xckl007, l_xckl.xckl008, l_xckl.xckl009
                                            INTO l_xckl.xckl101, l_xckl.xckl102, l_xckl.xckl102a,l_xckl.xckl102b,l_xckl.xckl102c,
                                                 l_xckl.xckl102d,l_xckl.xckl102e,l_xckl.xckl102f,l_xckl.xckl102g,l_xckl.xckl102h 
               
               #161109-00085#26-s mod            
#               IF NOT axcq603_ins_xckl(l_xckl.*) THEN   #161109-00085#26-s mark
               IF NOT axcq603_ins_xckl(l_xckl.xcklent,l_xckl.xcklcomp,l_xckl.xcklld,l_xckl.xckl001,l_xckl.xckl002,
                                       l_xckl.xckl003,l_xckl.xckl004,l_xckl.xckl005,l_xckl.xckl006,l_xckl.xckl007,
                                       l_xckl.xckl008,l_xckl.xckl009,l_xckl.xckl010,l_xckl.xckl090,l_xckl.xckl101,
                                       l_xckl.xckl102,l_xckl.xckl102a,l_xckl.xckl102b,l_xckl.xckl102c,l_xckl.xckl102d,
                                       l_xckl.xckl102e,l_xckl.xckl102f,l_xckl.xckl102g,l_xckl.xckl102h,l_xckl.xckl103,
                                       l_xckl.xckl104,l_xckl.xckl104a,l_xckl.xckl104b,l_xckl.xckl104c,l_xckl.xckl104d,
                                       l_xckl.xckl104e,l_xckl.xckl104f,l_xckl.xckl104g,l_xckl.xckl104h,l_xckl.xckl105,
                                       l_xckl.xckl106,l_xckl.xckl106a,l_xckl.xckl106b,l_xckl.xckl106c,l_xckl.xckl106d,
                                       l_xckl.xckl106e,l_xckl.xckl106f,l_xckl.xckl106g,l_xckl.xckl106h) THEN
               #161109-00085#26-e mod
                  LET r_success = FALSE
                  RETURN r_success
               END IF
               
            END FOREACH     
         #170210-00001#1--add--start--
         #判斷非先進先出成本，明細就直接給0
         ELSE
            LET l_xckl.xckl101  = 0
            LET l_xckl.xckl102  = 0
            LET l_xckl.xckl102a = 0
            LET l_xckl.xckl102b = 0
            LET l_xckl.xckl102c = 0
            LET l_xckl.xckl102d = 0
            LET l_xckl.xckl102e = 0
            LET l_xckl.xckl102f = 0
            LET l_xckl.xckl102g = 0
            LET l_xckl.xckl102h = 0
            IF NOT axcq603_ins_xckl(l_xckl.xcklent,l_xckl.xcklcomp,l_xckl.xcklld,l_xckl.xckl001,l_xckl.xckl002,
                                    l_xckl.xckl003,l_xckl.xckl004,l_xckl.xckl005,l_xckl.xckl006,l_xckl.xckl007,
                                    l_xckl.xckl008,l_xckl.xckl009,l_xckl.xckl010,l_xckl.xckl090,l_xckl.xckl101,
                                    l_xckl.xckl102,l_xckl.xckl102a,l_xckl.xckl102b,l_xckl.xckl102c,l_xckl.xckl102d,
                                    l_xckl.xckl102e,l_xckl.xckl102f,l_xckl.xckl102g,l_xckl.xckl102h,l_xckl.xckl103,
                                    l_xckl.xckl104,l_xckl.xckl104a,l_xckl.xckl104b,l_xckl.xckl104c,l_xckl.xckl104d,
                                    l_xckl.xckl104e,l_xckl.xckl104f,l_xckl.xckl104g,l_xckl.xckl104h,l_xckl.xckl105,
                                    l_xckl.xckl106,l_xckl.xckl106a,l_xckl.xckl106b,l_xckl.xckl106c,l_xckl.xckl106d,
                                    l_xckl.xckl106e,l_xckl.xckl106f,l_xckl.xckl106g,l_xckl.xckl106h) THEN
               LET r_success = FALSE
               RETURN r_success  
            END IF
         END IF
         #170210-00001#1--add--end----
         #160707-00034#1---e
      WHEN '101'  #库存期初
         LET l_xckk003 = g_previous_xckk003
         LET l_xckk004 = g_previous_xckk004
         #160707-00034#1---s
         FOREACH axcq603_sel_xcca_cs1 USING l_xckk003,l_xckk004
                                      INTO l_xckl.xckl010, l_xckl.xckl007, l_xckl.xckl008, l_xckl.xckl009,
                                           l_xckl.xckl103, l_xckl.xckl104, l_xckl.xckl104a,l_xckl.xckl104b,l_xckl.xckl104c,
                                           l_xckl.xckl104d,l_xckl.xckl104e,l_xckl.xckl104f,l_xckl.xckl104g,l_xckl.xckl104h   
                               
            EXECUTE axcq603_sel_xccc_cs1 USING l_xckl.xckl010, l_xckl.xckl007, l_xckl.xckl008, l_xckl.xckl009
                                         INTO l_xckl.xckl101, l_xckl.xckl102, l_xckl.xckl102a,l_xckl.xckl102b,l_xckl.xckl102c,
                                              l_xckl.xckl102d,l_xckl.xckl102e,l_xckl.xckl102f,l_xckl.xckl102g,l_xckl.xckl102h 
                                               
            #161109-00085#26-s mod            
#            IF NOT axcq603_ins_xckl(l_xckl.*) THEN   #161109-00085#26-s mark
            IF NOT axcq603_ins_xckl(l_xckl.xcklent,l_xckl.xcklcomp,l_xckl.xcklld,l_xckl.xckl001,l_xckl.xckl002,
                                    l_xckl.xckl003,l_xckl.xckl004,l_xckl.xckl005,l_xckl.xckl006,l_xckl.xckl007,
                                    l_xckl.xckl008,l_xckl.xckl009,l_xckl.xckl010,l_xckl.xckl090,l_xckl.xckl101,
                                    l_xckl.xckl102,l_xckl.xckl102a,l_xckl.xckl102b,l_xckl.xckl102c,l_xckl.xckl102d,
                                    l_xckl.xckl102e,l_xckl.xckl102f,l_xckl.xckl102g,l_xckl.xckl102h,l_xckl.xckl103,
                                    l_xckl.xckl104,l_xckl.xckl104a,l_xckl.xckl104b,l_xckl.xckl104c,l_xckl.xckl104d,
                                    l_xckl.xckl104e,l_xckl.xckl104f,l_xckl.xckl104g,l_xckl.xckl104h,l_xckl.xckl105,
                                    l_xckl.xckl106,l_xckl.xckl106a,l_xckl.xckl106b,l_xckl.xckl106c,l_xckl.xckl106d,
                                    l_xckl.xckl106e,l_xckl.xckl106f,l_xckl.xckl106g,l_xckl.xckl106h) THEN
            #161109-00085#26-e mod            
               LET r_success = FALSE
               RETURN r_success
            END IF
            
         END FOREACH      
         #160707-00034#1---e
   END CASE
   
   #160707-00034#1---s
   #FOREACH axcq603_sel_xcca_cs1 USING l_xckk003,l_xckk004
   #                             INTO l_xckl.xckl010, l_xckl.xckl007, l_xckl.xckl008, l_xckl.xckl009,
   #                                  l_xckl.xckl103, l_xckl.xckl104, l_xckl.xckl104a,l_xckl.xckl104b,l_xckl.xckl104c,
   #                                  l_xckl.xckl104d,l_xckl.xckl104e,l_xckl.xckl104f,l_xckl.xckl104g,l_xckl.xckl104h   
   #                      
   #   EXECUTE axcq603_sel_xccc_cs1 USING l_xckl.xckl010, l_xckl.xckl007, l_xckl.xckl008, l_xckl.xckl009
   #                                INTO l_xckl.xckl101, l_xckl.xckl102, l_xckl.xckl102a,l_xckl.xckl102b,l_xckl.xckl102c,
   #                                     l_xckl.xckl102d,l_xckl.xckl102e,l_xckl.xckl102f,l_xckl.xckl102g,l_xckl.xckl102h 
   #                                     
   #   IF NOT axcq603_ins_xckl(l_xckl.*) THEN               
   #      LET r_success = FALSE
   #      RETURN r_success
   #   END IF
   #   
   #END FOREACH                                          
   #160707-00034#1---e
   RETURN r_success
   
END FUNCTION

#写入xckl成本勾稽明细表
PRIVATE FUNCTION axcq603_ins_xckl(p_xckl)
#161109-00085#26-s mod
#DEFINE p_xckl       RECORD LIKE xckl_t.*   #161109-00085#26-s mark
DEFINE p_xckl       RECORD  #成本勾稽明細表
       xcklent LIKE xckl_t.xcklent, #企業編號
       xcklcomp LIKE xckl_t.xcklcomp, #法人組織
       xcklld LIKE xckl_t.xcklld, #帳套
       xckl001 LIKE xckl_t.xckl001, #本位幣順序
       xckl002 LIKE xckl_t.xckl002, #成本計算類型
       xckl003 LIKE xckl_t.xckl003, #年度
       xckl004 LIKE xckl_t.xckl004, #期別
       xckl005 LIKE xckl_t.xckl005, #
       xckl006 LIKE xckl_t.xckl006, #在製單據編號
       xckl007 LIKE xckl_t.xckl007, #料號
       xckl008 LIKE xckl_t.xckl008, #特徵
       xckl009 LIKE xckl_t.xckl009, #批號
       xckl010 LIKE xckl_t.xckl010, #成本域
       xckl090 LIKE xckl_t.xckl090, #明細程式編號
       xckl101 LIKE xckl_t.xckl101, #總報表數量
       xckl102 LIKE xckl_t.xckl102, #總報表金額
       xckl102a LIKE xckl_t.xckl102a, #材料
       xckl102b LIKE xckl_t.xckl102b, #人工
       xckl102c LIKE xckl_t.xckl102c, #加工
       xckl102d LIKE xckl_t.xckl102d, #制費一
       xckl102e LIKE xckl_t.xckl102e, #制費二
       xckl102f LIKE xckl_t.xckl102f, #制費三
       xckl102g LIKE xckl_t.xckl102g, #製費四
       xckl102h LIKE xckl_t.xckl102h, #制費五
       xckl103 LIKE xckl_t.xckl103, #分報表數量
       xckl104 LIKE xckl_t.xckl104, #分報表金額
       xckl104a LIKE xckl_t.xckl104a, #分報表材料
       xckl104b LIKE xckl_t.xckl104b, #分報表人工
       xckl104c LIKE xckl_t.xckl104c, #分報表加工
       xckl104d LIKE xckl_t.xckl104d, #分報表制費一
       xckl104e LIKE xckl_t.xckl104e, #分報表制費二
       xckl104f LIKE xckl_t.xckl104f, #分報表制費三
       xckl104g LIKE xckl_t.xckl104g, #分報表制費四
       xckl104h LIKE xckl_t.xckl104h, #分報表制費五
       xckl105 LIKE xckl_t.xckl105, #差異數量
       xckl106 LIKE xckl_t.xckl106, #差異金額
       xckl106a LIKE xckl_t.xckl106a, #差異金額-材料
       xckl106b LIKE xckl_t.xckl106b, #差異金額-人工
       xckl106c LIKE xckl_t.xckl106c, #差異金額-加工
       xckl106d LIKE xckl_t.xckl106d, #差異金額-制費一
       xckl106e LIKE xckl_t.xckl106e, #差異金額-制費二
       xckl106f LIKE xckl_t.xckl106f, #差異金額-制費三
       xckl106g LIKE xckl_t.xckl106g, #差異金額-制費四
       xckl106h LIKE xckl_t.xckl106h  #差異金額-制費五
          END RECORD
#161109-00085#26-e mod
DEFINE r_success    LIKE type_t.num5
#161109-00085#26-s mod
#DEFINE l_xckl       RECORD LIKE xckl_t.*   #161109-00085#26-s mark
DEFINE l_xckl       RECORD  #成本勾稽明細表
       xcklent LIKE xckl_t.xcklent, #企業編號
       xcklcomp LIKE xckl_t.xcklcomp, #法人組織
       xcklld LIKE xckl_t.xcklld, #帳套
       xckl001 LIKE xckl_t.xckl001, #本位幣順序
       xckl002 LIKE xckl_t.xckl002, #成本計算類型
       xckl003 LIKE xckl_t.xckl003, #年度
       xckl004 LIKE xckl_t.xckl004, #期別
       xckl005 LIKE xckl_t.xckl005, #
       xckl006 LIKE xckl_t.xckl006, #在製單據編號
       xckl007 LIKE xckl_t.xckl007, #料號
       xckl008 LIKE xckl_t.xckl008, #特徵
       xckl009 LIKE xckl_t.xckl009, #批號
       xckl010 LIKE xckl_t.xckl010, #成本域
       xckl090 LIKE xckl_t.xckl090, #明細程式編號
       xckl101 LIKE xckl_t.xckl101, #總報表數量
       xckl102 LIKE xckl_t.xckl102, #總報表金額
       xckl102a LIKE xckl_t.xckl102a, #材料
       xckl102b LIKE xckl_t.xckl102b, #人工
       xckl102c LIKE xckl_t.xckl102c, #加工
       xckl102d LIKE xckl_t.xckl102d, #制費一
       xckl102e LIKE xckl_t.xckl102e, #制費二
       xckl102f LIKE xckl_t.xckl102f, #制費三
       xckl102g LIKE xckl_t.xckl102g, #製費四
       xckl102h LIKE xckl_t.xckl102h, #制費五
       xckl103 LIKE xckl_t.xckl103, #分報表數量
       xckl104 LIKE xckl_t.xckl104, #分報表金額
       xckl104a LIKE xckl_t.xckl104a, #分報表材料
       xckl104b LIKE xckl_t.xckl104b, #分報表人工
       xckl104c LIKE xckl_t.xckl104c, #分報表加工
       xckl104d LIKE xckl_t.xckl104d, #分報表制費一
       xckl104e LIKE xckl_t.xckl104e, #分報表制費二
       xckl104f LIKE xckl_t.xckl104f, #分報表制費三
       xckl104g LIKE xckl_t.xckl104g, #分報表制費四
       xckl104h LIKE xckl_t.xckl104h, #分報表制費五
       xckl105 LIKE xckl_t.xckl105, #差異數量
       xckl106 LIKE xckl_t.xckl106, #差異金額
       xckl106a LIKE xckl_t.xckl106a, #差異金額-材料
       xckl106b LIKE xckl_t.xckl106b, #差異金額-人工
       xckl106c LIKE xckl_t.xckl106c, #差異金額-加工
       xckl106d LIKE xckl_t.xckl106d, #差異金額-制費一
       xckl106e LIKE xckl_t.xckl106e, #差異金額-制費二
       xckl106f LIKE xckl_t.xckl106f, #差異金額-制費三
       xckl106g LIKE xckl_t.xckl106g, #差異金額-制費四
       xckl106h LIKE xckl_t.xckl106h  #差異金額-制費五
          END RECORD
#161109-00085#26-e mod
DEFINE l_n          LIKE type_t.num5

   LET r_success = TRUE
   
   #161031-00037#1----s
   #寫xckl_t時，總表和明細有資料的才寫入，避免資料量過多，要找出哪一筆有問題會比較麻煩
   IF (cl_null(p_xckl.xckl101)  OR p_xckl.xckl101  = 0) AND (cl_null(p_xckl.xckl102)  OR p_xckl.xckl102  = 0) AND 
      (cl_null(p_xckl.xckl102a) OR p_xckl.xckl102a = 0) AND (cl_null(p_xckl.xckl102b) OR p_xckl.xckl102b = 0) AND 
      (cl_null(p_xckl.xckl102c) OR p_xckl.xckl102c = 0) AND (cl_null(p_xckl.xckl102d) OR p_xckl.xckl102d = 0) AND 
      (cl_null(p_xckl.xckl102e) OR p_xckl.xckl102e = 0) AND (cl_null(p_xckl.xckl102f) OR p_xckl.xckl102f = 0) AND 
      (cl_null(p_xckl.xckl102g) OR p_xckl.xckl102g = 0) AND (cl_null(p_xckl.xckl102h) OR p_xckl.xckl102h = 0) AND 
	   (cl_null(p_xckl.xckl103)  OR p_xckl.xckl103  = 0) AND (cl_null(p_xckl.xckl104)  OR p_xckl.xckl104  = 0) AND 
	   (cl_null(p_xckl.xckl104a) OR p_xckl.xckl104a = 0) AND (cl_null(p_xckl.xckl104b) OR p_xckl.xckl104b = 0) AND 
	   (cl_null(p_xckl.xckl104c) OR p_xckl.xckl104c = 0) AND (cl_null(p_xckl.xckl104d) OR p_xckl.xckl104d = 0) AND 
	   (cl_null(p_xckl.xckl104e) OR p_xckl.xckl104e = 0) AND (cl_null(p_xckl.xckl104f) OR p_xckl.xckl104f = 0) AND 
	   (cl_null(p_xckl.xckl104g) OR p_xckl.xckl104g = 0) AND (cl_null(p_xckl.xckl104h) OR p_xckl.xckl104h = 0) THEN
	   
	   RETURN r_success
	END IF
	
	#金額或數量存在差異的部分，則按料号+特性+批号+成本域找出差异并写入xckl
   IF p_xckl.xckl105 = 0 AND p_xckl.xckl106 = 0 THEN
      RETURN r_success
	END IF
   #161031-00037#1---e
   
   INITIALIZE l_xckl.* TO NULL
   
   LET l_xckl.* = p_xckl.*
   IF cl_null(l_xckl.xckl006) THEN
      LET l_xckl.xckl006 = ' '
   END IF 
   IF cl_null(l_xckl.xckl007) THEN
      LET l_xckl.xckl007 = ' '
   END IF 
   IF cl_null(l_xckl.xckl008) THEN
      LET l_xckl.xckl008 = ' '
   END IF 
   IF cl_null(l_xckl.xckl009) THEN
      LET l_xckl.xckl009 = ' '
   END IF 
   IF cl_null(l_xckl.xckl010) THEN
      LET l_xckl.xckl010 = ' '
   END IF 
   
   IF cl_null(l_xckl.xckl101) THEN
      LET l_xckl.xckl101 = 0
   END IF
   IF cl_null(l_xckl.xckl102) THEN
      LET l_xckl.xckl102 = 0
   END IF
   IF cl_null(l_xckl.xckl102a) THEN
      LET l_xckl.xckl102a = 0
   END IF
   IF cl_null(l_xckl.xckl102b) THEN
      LET l_xckl.xckl102b = 0
   END IF
   IF cl_null(l_xckl.xckl102c) THEN
      LET l_xckl.xckl102c = 0
   END IF
   IF cl_null(l_xckl.xckl102d) THEN
      LET l_xckl.xckl102d = 0
   END IF
   IF cl_null(l_xckl.xckl102e) THEN
      LET l_xckl.xckl102e = 0
   END IF
   IF cl_null(l_xckl.xckl102f) THEN
      LET l_xckl.xckl102f = 0
   END IF
   IF cl_null(l_xckl.xckl102g) THEN
      LET l_xckl.xckl102g = 0
   END IF
   IF cl_null(l_xckl.xckl102h) THEN
      LET l_xckl.xckl102h = 0
   END IF
   
   IF cl_null(l_xckl.xckl103) THEN
      LET l_xckl.xckl103 = 0
   END IF
   IF cl_null(l_xckl.xckl104) THEN
      LET l_xckl.xckl104 = 0
   END IF
   IF cl_null(l_xckl.xckl104a) THEN
      LET l_xckl.xckl104a = 0
   END IF
   IF cl_null(l_xckl.xckl104b) THEN
      LET l_xckl.xckl104b = 0
   END IF
   IF cl_null(l_xckl.xckl104c) THEN
      LET l_xckl.xckl104c = 0
   END IF
   IF cl_null(l_xckl.xckl104d) THEN
      LET l_xckl.xckl104d = 0
   END IF
   IF cl_null(l_xckl.xckl104e) THEN
      LET l_xckl.xckl104e = 0
   END IF
   IF cl_null(l_xckl.xckl104f) THEN
      LET l_xckl.xckl104f = 0
   END IF
   IF cl_null(l_xckl.xckl104g) THEN
      LET l_xckl.xckl104g = 0
   END IF
   IF cl_null(l_xckl.xckl104h) THEN
      LET l_xckl.xckl104h = 0
   END IF    
   
   IF l_xckl.xckl101 = 0 AND l_xckl.xckl102 = 0 AND l_xckl.xckl102a = 0 AND l_xckl.xckl102b = 0 AND l_xckl.xckl102c = 0 AND l_xckl.xckl102d = 0 AND
      l_xckl.xckl102e= 0 AND l_xckl.xckl102f= 0 AND l_xckl.xckl102g = 0 AND l_xckl.xckl102h = 0 AND
      l_xckl.xckl103 = 0 AND l_xckl.xckl104 = 0 AND l_xckl.xckl104a = 0 AND l_xckl.xckl104b = 0 AND l_xckl.xckl104c = 0 AND l_xckl.xckl104d = 0 AND
      l_xckl.xckl104e= 0 AND l_xckl.xckl104f= 0 AND l_xckl.xckl104g = 0 AND l_xckl.xckl104h = 0 THEN
      RETURN r_success
   END IF                
   #161031-00037#1---s
   #若明细中抓取的值是负数，则*(-1)计算，相当于总+明细的=差异的
   IF ((l_xckl.xckl103 < 0  AND l_xckl.xckl101 > 0) OR (l_xckl.xckl103 > 0  AND l_xckl.xckl101 < 0)) OR
      ((l_xckl.xckl104 < 0  AND l_xckl.xckl102 > 0) OR (l_xckl.xckl104 > 0  AND l_xckl.xckl102 < 0))  THEN
      LET l_xckl.xckl105  = l_xckl.xckl101  + l_xckl.xckl103
      LET l_xckl.xckl106  = l_xckl.xckl102  + l_xckl.xckl104
      LET l_xckl.xckl106a = l_xckl.xckl102a + l_xckl.xckl104a
      LET l_xckl.xckl106b = l_xckl.xckl102b + l_xckl.xckl104b
      LET l_xckl.xckl106c = l_xckl.xckl102c + l_xckl.xckl104c
      LET l_xckl.xckl106d = l_xckl.xckl102d + l_xckl.xckl104d
      LET l_xckl.xckl106e = l_xckl.xckl102e + l_xckl.xckl104e
      LET l_xckl.xckl106f = l_xckl.xckl102f + l_xckl.xckl104f
      LET l_xckl.xckl106g = l_xckl.xckl102g + l_xckl.xckl104g
      LET l_xckl.xckl106h = l_xckl.xckl102h + l_xckl.xckl104h
   ELSE
   #161031-00037#1---e
      LET l_xckl.xckl105 = l_xckl.xckl101 - l_xckl.xckl103
      LET l_xckl.xckl106 = l_xckl.xckl102 - l_xckl.xckl104
      LET l_xckl.xckl106a = l_xckl.xckl102a - l_xckl.xckl104a
      LET l_xckl.xckl106b = l_xckl.xckl102b - l_xckl.xckl104b
      LET l_xckl.xckl106c = l_xckl.xckl102c - l_xckl.xckl104c
      LET l_xckl.xckl106d = l_xckl.xckl102d - l_xckl.xckl104d
      LET l_xckl.xckl106e = l_xckl.xckl102e - l_xckl.xckl104e
      LET l_xckl.xckl106f = l_xckl.xckl102f - l_xckl.xckl104f
      LET l_xckl.xckl106g = l_xckl.xckl102g - l_xckl.xckl104g
      LET l_xckl.xckl106h = l_xckl.xckl102h - l_xckl.xckl104h
   END IF   #161031-00037#1
   
   LET l_n = 0
   SELECT COUNT(1) INTO l_n FROM xckl_t
       WHERE xcklent = l_xckl.xcklent AND xcklld = l_xckl.xcklld AND xckl001 = l_xckl.xckl001
         AND xckl002 = l_xckl.xckl002 AND xckl003 = l_xckl.xckl003 AND xckl004 = l_xckl.xckl004
         AND xckl005 = l_xckl.xckl005 AND xckl006 = l_xckl.xckl006 AND xckl007 = l_xckl.xckl007
         AND xckl008 = l_xckl.xckl008 AND xckl009 = l_xckl.xckl009 AND xckl010 = l_xckl.xckl010
   IF l_n > 0 THEN
      UPDATE xckl_t SET ( xcklcomp,xckl090,
                          xckl101,xckl102,xckl102a,xckl102b,xckl102c,xckl102d,xckl102e,xckl102f,xckl102g,xckl102h,
                          xckl103,xckl104,xckl104a,xckl104b,xckl104c,xckl104d,xckl104e,xckl104f,xckl104g,xckl104h,
                          xckl105,xckl106,xckl106a,xckl106b,xckl106c,xckl106d,xckl106e,xckl106f,xckl106g,xckl106h)
                      = ( l_xckl.xcklcomp,l_xckl.xckl090,
                          l_xckl.xckl101, l_xckl.xckl102, l_xckl.xckl102a,l_xckl.xckl102b,l_xckl.xckl102c,
                          l_xckl.xckl102d,l_xckl.xckl102e,l_xckl.xckl102f,l_xckl.xckl102g,l_xckl.xckl102h,
                          l_xckl.xckl103, l_xckl.xckl104, l_xckl.xckl104a,l_xckl.xckl104b,l_xckl.xckl104c,
                          l_xckl.xckl104d,l_xckl.xckl104e,l_xckl.xckl104f,l_xckl.xckl104g,l_xckl.xckl104h,
                          l_xckl.xckl105, l_xckl.xckl106, l_xckl.xckl106a,l_xckl.xckl106b,l_xckl.xckl106c,
                          l_xckl.xckl106d,l_xckl.xckl106e,l_xckl.xckl106f,l_xckl.xckl106g,l_xckl.xckl106h)
         WHERE xcklent = l_xckl.xcklent AND xcklld = l_xckl.xcklld AND xckl001 = l_xckl.xckl001
           AND xckl002 = l_xckl.xckl002 AND xckl003 = l_xckl.xckl003 AND xckl004 = l_xckl.xckl004
           AND xckl005 = l_xckl.xckl005 AND xckl006 = l_xckl.xckl006 AND xckl007 = l_xckl.xckl007
           AND xckl008 = l_xckl.xckl008 AND xckl009 = l_xckl.xckl009 AND xckl010 = l_xckl.xckl010
   ELSE
      INSERT INTO xckl_t (xcklent,xcklcomp,xcklld,xckl001,xckl002,xckl003,xckl004,xckl005,
                          xckl006,xckl007,xckl008,xckl009,xckl010,xckl090,
                          xckl101,xckl102,xckl102a,xckl102b,xckl102c,xckl102d,xckl102e,xckl102f,xckl102g,xckl102h,
                          xckl103,xckl104,xckl104a,xckl104b,xckl104c,xckl104d,xckl104e,xckl104f,xckl104g,xckl104h,
                          xckl105,xckl106,xckl106a,xckl106b,xckl106c,xckl106d,xckl106e,xckl106f,xckl106g,xckl106h)
          VALUES (l_xckl.xcklent, l_xckl.xcklcomp,l_xckl.xcklld,  l_xckl.xckl001, l_xckl.xckl002,
                  l_xckl.xckl003, l_xckl.xckl004, l_xckl.xckl005, l_xckl.xckl006, l_xckl.xckl007,
                  l_xckl.xckl008, l_xckl.xckl009, l_xckl.xckl010, l_xckl.xckl090,
                  l_xckl.xckl101, l_xckl.xckl102, l_xckl.xckl102a,l_xckl.xckl102b,l_xckl.xckl102c,
                  l_xckl.xckl102d,l_xckl.xckl102e,l_xckl.xckl102f,l_xckl.xckl102g,l_xckl.xckl102h,
                  l_xckl.xckl103, l_xckl.xckl104, l_xckl.xckl104a,l_xckl.xckl104b,l_xckl.xckl104c,
                  l_xckl.xckl104d,l_xckl.xckl104e,l_xckl.xckl104f,l_xckl.xckl104g,l_xckl.xckl104h,
                  l_xckl.xckl105, l_xckl.xckl106, l_xckl.xckl106a,l_xckl.xckl106b,l_xckl.xckl106c,
                  l_xckl.xckl106d,l_xckl.xckl106e,l_xckl.xckl106f,l_xckl.xckl106g,l_xckl.xckl106h)
   END IF
   
   IF SQLCA.sqlcode  THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "xckl_t:"
      LET g_errparam.code   = SQLCA.sqlcode 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()                   
      LET r_success = FALSE
      RETURN r_success
   END IF                                    
   RETURN r_success
   
END FUNCTION

##明细表抓xcck的本期采购入库和仓退的数量和金额写入xckl
PRIVATE FUNCTION axcq603_gen_xckl_2(p_xckk)
#161109-00085#26-s mod
#DEFINE p_xckk          RECORD LIKE xckk_t.*   #161109-00085#26-s mark
DEFINE p_xckk          RECORD  #成本勾稽表
       xckkent LIKE xckk_t.xckkent, #企業編號
       xckkcomp LIKE xckk_t.xckkcomp, #法人組織
       xckkld LIKE xckk_t.xckkld, #帳套
       xckk001 LIKE xckk_t.xckk001, #本位幣順序
       xckk002 LIKE xckk_t.xckk002, #成本計算類型
       xckk003 LIKE xckk_t.xckk003, #年度
       xckk004 LIKE xckk_t.xckk004, #期別
       xckk005 LIKE xckk_t.xckk005, #
       xckk090 LIKE xckk_t.xckk090, #明細程式編號
       xckk101 LIKE xckk_t.xckk101, #總報表數量
       xckk102 LIKE xckk_t.xckk102, #總報表金額
       xckk102a LIKE xckk_t.xckk102a, #材料
       xckk102b LIKE xckk_t.xckk102b, #人工
       xckk102c LIKE xckk_t.xckk102c, #加工
       xckk102d LIKE xckk_t.xckk102d, #制費一
       xckk102e LIKE xckk_t.xckk102e, #制費二
       xckk102f LIKE xckk_t.xckk102f, #制費三
       xckk102g LIKE xckk_t.xckk102g, #製費四
       xckk102h LIKE xckk_t.xckk102h, #制費五
       xckk103 LIKE xckk_t.xckk103, #分報表數量
       xckk104 LIKE xckk_t.xckk104, #分報表金額
       xckk104a LIKE xckk_t.xckk104a, #分報表材料
       xckk104b LIKE xckk_t.xckk104b, #分報表人工
       xckk104c LIKE xckk_t.xckk104c, #分報表加工
       xckk104d LIKE xckk_t.xckk104d, #分報表制費一
       xckk104e LIKE xckk_t.xckk104e, #分報表制費二
       xckk104f LIKE xckk_t.xckk104f, #分報表制費三
       xckk104g LIKE xckk_t.xckk104g, #分報表制費四
       xckk104h LIKE xckk_t.xckk104h, #分報表制費五
       xckk105 LIKE xckk_t.xckk105, #差異數量
       xckk106 LIKE xckk_t.xckk106, #差異金額
       xckk106a LIKE xckk_t.xckk106a, #差異金額-材料
       xckk106b LIKE xckk_t.xckk106b, #差異金額-人工
       xckk106c LIKE xckk_t.xckk106c, #差異金額-加工
       xckk106d LIKE xckk_t.xckk106d, #差異金額-制費一
       xckk106e LIKE xckk_t.xckk106e, #差異金額-制費二
       xckk106f LIKE xckk_t.xckk106f, #差異金額-制費三
       xckk106g LIKE xckk_t.xckk106g, #差異金額-制費四
       xckk106h LIKE xckk_t.xckk106h  #差異金額-制費五
                END RECORD
#161109-00085#26-e mod
DEFINE r_success    LIKE type_t.num5
#161109-00085#26-s mod
#DEFINE l_xckl       RECORD LIKE xckl_t.*   #161109-00085#26-s mark
DEFINE l_xckl       RECORD  #成本勾稽明細表
       xcklent LIKE xckl_t.xcklent, #企業編號
       xcklcomp LIKE xckl_t.xcklcomp, #法人組織
       xcklld LIKE xckl_t.xcklld, #帳套
       xckl001 LIKE xckl_t.xckl001, #本位幣順序
       xckl002 LIKE xckl_t.xckl002, #成本計算類型
       xckl003 LIKE xckl_t.xckl003, #年度
       xckl004 LIKE xckl_t.xckl004, #期別
       xckl005 LIKE xckl_t.xckl005, #
       xckl006 LIKE xckl_t.xckl006, #在製單據編號
       xckl007 LIKE xckl_t.xckl007, #料號
       xckl008 LIKE xckl_t.xckl008, #特徵
       xckl009 LIKE xckl_t.xckl009, #批號
       xckl010 LIKE xckl_t.xckl010, #成本域
       xckl090 LIKE xckl_t.xckl090, #明細程式編號
       xckl101 LIKE xckl_t.xckl101, #總報表數量
       xckl102 LIKE xckl_t.xckl102, #總報表金額
       xckl102a LIKE xckl_t.xckl102a, #材料
       xckl102b LIKE xckl_t.xckl102b, #人工
       xckl102c LIKE xckl_t.xckl102c, #加工
       xckl102d LIKE xckl_t.xckl102d, #制費一
       xckl102e LIKE xckl_t.xckl102e, #制費二
       xckl102f LIKE xckl_t.xckl102f, #制費三
       xckl102g LIKE xckl_t.xckl102g, #製費四
       xckl102h LIKE xckl_t.xckl102h, #制費五
       xckl103 LIKE xckl_t.xckl103, #分報表數量
       xckl104 LIKE xckl_t.xckl104, #分報表金額
       xckl104a LIKE xckl_t.xckl104a, #分報表材料
       xckl104b LIKE xckl_t.xckl104b, #分報表人工
       xckl104c LIKE xckl_t.xckl104c, #分報表加工
       xckl104d LIKE xckl_t.xckl104d, #分報表制費一
       xckl104e LIKE xckl_t.xckl104e, #分報表制費二
       xckl104f LIKE xckl_t.xckl104f, #分報表制費三
       xckl104g LIKE xckl_t.xckl104g, #分報表制費四
       xckl104h LIKE xckl_t.xckl104h, #分報表制費五
       xckl105 LIKE xckl_t.xckl105, #差異數量
       xckl106 LIKE xckl_t.xckl106, #差異金額
       xckl106a LIKE xckl_t.xckl106a, #差異金額-材料
       xckl106b LIKE xckl_t.xckl106b, #差異金額-人工
       xckl106c LIKE xckl_t.xckl106c, #差異金額-加工
       xckl106d LIKE xckl_t.xckl106d, #差異金額-制費一
       xckl106e LIKE xckl_t.xckl106e, #差異金額-制費二
       xckl106f LIKE xckl_t.xckl106f, #差異金額-制費三
       xckl106g LIKE xckl_t.xckl106g, #差異金額-制費四
       xckl106h LIKE xckl_t.xckl106h  #差異金額-制費五
          END RECORD
#161109-00085#26-e mod
DEFINE l_sql        STRING
DEFINE l_sql1       STRING
DEFINE l_xcck055    LIKE type_t.chr80
DEFINE l_sub_sql    STRING
DEFINE l_sql2       STRING
DEFINE l_sql_1      STRING
DEFINE l_sql_2      STRING
DEFINE l_sql_3      STRING

   LET r_success = TRUE
   
   INITIALIZE l_xckl.* TO NULL
   
   LET l_xckl.xcklent = g_enterprise
   LET l_xckl.xcklcomp = g_master.xckkcomp
   LET l_xckl.xcklld = g_master.xckkld
   LET l_xckl.xckl001 = g_master.xckk001
   LET l_xckl.xckl002 = g_master.xckk002
   LET l_xckl.xckl003 = g_master.xckk003
   LET l_xckl.xckl004 = g_master.xckk004  
   LET l_xckl.xckl005 = p_xckk.xckk005
   LET l_xckl.xckl006 = ' ' #在制单据编号
   
   LET l_xckl.xckl090 = p_xckk.xckk090
   
   LET l_sql = ''
   CASE p_xckk.xckk005
      WHEN '102'  #采购入库(采购入库、采购仓退)
         #根據料件+特性+批號等抓取總表xccc中對應的采购數量、金額欄位
         LET l_sql = "SELECT SUM((CASE WHEN xccc201 IS NULL THEN 0 ELSE xccc201 END)),  SUM((CASE WHEN xccc202 IS NULL THEN 0 ELSE xccc202 END)),  ",
                     "       SUM((CASE WHEN xccc202a IS NULL THEN 0 ELSE xccc202a END)),SUM((CASE WHEN xccc202b IS NULL THEN 0 ELSE xccc202b END)),",
                     "       SUM((CASE WHEN xccc202c IS NULL THEN 0 ELSE xccc202c END)),SUM((CASE WHEN xccc202d IS NULL THEN 0 ELSE xccc202d END)),",
                     "       SUM((CASE WHEN xccc202e IS NULL THEN 0 ELSE xccc202e END)),SUM((CASE WHEN xccc202f IS NULL THEN 0 ELSE xccc202f END)),",
                     "       SUM((CASE WHEN xccc202g IS NULL THEN 0 ELSE xccc202g END)),SUM((CASE WHEN xccc202h IS NULL THEN 0 ELSE xccc202h END)) "
                     
      WHEN '117'  #委外入庫(委外入庫、委外聯產品入庫、委外多產出入庫、委外拆件入庫、委外倉退) 
         #根據料件+特性+批號等抓取總表xccc中對應的委外數量、金額欄位
         LET l_sql = "SELECT SUM((CASE WHEN xccc203 IS NULL THEN 0  ELSE xccc203 END)), SUM((CASE WHEN xccc204 IS NULL THEN 0  ELSE xccc204 END)), ",
                     "       SUM((CASE WHEN xccc204a IS NULL THEN 0 ELSE xccc204a END)),SUM((CASE WHEN xccc204b IS NULL THEN 0 ELSE xccc204b END)),",
                     "       SUM((CASE WHEN xccc204c IS NULL THEN 0 ELSE xccc204c END)),SUM((CASE WHEN xccc204d IS NULL THEN 0 ELSE xccc204d END)),",
                     "       SUM((CASE WHEN xccc204e IS NULL THEN 0 ELSE xccc204e END)),SUM((CASE WHEN xccc204f IS NULL THEN 0 ELSE xccc204f END)),",
                     "       SUM((CASE WHEN xccc204g IS NULL THEN 0 ELSE xccc204g END)),SUM((CASE WHEN xccc204h IS NULL THEN 0 ELSE xccc204h END)) "
      
      WHEN '105'  #工单入库(生產入庫、聯產品入庫、多主件產出入庫)  
         LET l_sql = "SELECT SUM((CASE WHEN xccc205 IS NULL THEN 0  ELSE xccc205 END)), SUM((CASE WHEN xccc206 IS NULL THEN 0  ELSE xccc206 END)), ",
                     "       SUM((CASE WHEN xccc206a IS NULL THEN 0 ELSE xccc206a END)),SUM((CASE WHEN xccc206b IS NULL THEN 0 ELSE xccc206b END)),",
                     "       SUM((CASE WHEN xccc206c IS NULL THEN 0 ELSE xccc206c END)),SUM((CASE WHEN xccc206d IS NULL THEN 0 ELSE xccc206d END)),",
                     "       SUM((CASE WHEN xccc206e IS NULL THEN 0 ELSE xccc206e END)),SUM((CASE WHEN xccc206f IS NULL THEN 0 ELSE xccc206f END)),",
                     "       SUM((CASE WHEN xccc206g IS NULL THEN 0 ELSE xccc206g END)),SUM((CASE WHEN xccc206h IS NULL THEN 0 ELSE xccc206h END)) "
      WHEN '115'  #返工入库
         LET l_sql = "SELECT SUM((CASE WHEN xccc209 IS NULL THEN 0  ELSE xccc209 END)), SUM((CASE WHEN xccc210 IS NULL THEN 0  ELSE xccc210 END)), ",
                     "       SUM((CASE WHEN xccc210a IS NULL THEN 0 ELSE xccc210a END)),SUM((CASE WHEN xccc210b IS NULL THEN 0 ELSE xccc210b END)),",
                     "       SUM((CASE WHEN xccc210c IS NULL THEN 0 ELSE xccc210c END)),SUM((CASE WHEN xccc210d IS NULL THEN 0 ELSE xccc210d END)),",
                     "       SUM((CASE WHEN xccc210e IS NULL THEN 0 ELSE xccc210e END)),SUM((CASE WHEN xccc210f IS NULL THEN 0 ELSE xccc210f END)),",
                     "       SUM((CASE WHEN xccc210g IS NULL THEN 0 ELSE xccc210g END)),SUM((CASE WHEN xccc210h IS NULL THEN 0 ELSE xccc210h END)) "  
      WHEN '104'     #杂项入库     
          LET l_sql = "SELECT SUM((CASE WHEN xccc211 IS NULL THEN 0  ELSE xccc211 END)), SUM((CASE WHEN xccc212 IS NULL THEN 0  ELSE xccc212 END)), ",
                      "       SUM((CASE WHEN xccc212a IS NULL THEN 0 ELSE xccc212a END)),SUM((CASE WHEN xccc212b IS NULL THEN 0 ELSE xccc212b END)),",
                      "       SUM((CASE WHEN xccc212c IS NULL THEN 0 ELSE xccc212c END)),SUM((CASE WHEN xccc212d IS NULL THEN 0 ELSE xccc212d END)),",
                      "       SUM((CASE WHEN xccc212e IS NULL THEN 0 ELSE xccc212e END)),SUM((CASE WHEN xccc212f IS NULL THEN 0 ELSE xccc212f END)),",
                      "       SUM((CASE WHEN xccc212g IS NULL THEN 0 ELSE xccc212g END)),SUM((CASE WHEN xccc212h IS NULL THEN 0 ELSE xccc212h END)) "
      WHEN '118'   #调拨入库
         LET l_sql = "SELECT SUM((CASE WHEN xccc217 IS NULL THEN 0  ELSE xccc217 END)), SUM((CASE WHEN xccc218 IS NULL THEN 0  ELSE xccc218 END)), ",
                     "       SUM((CASE WHEN xccc218a IS NULL THEN 0 ELSE xccc218a END)),SUM((CASE WHEN xccc218b IS NULL THEN 0 ELSE xccc218b END)),",
                     "       SUM((CASE WHEN xccc218c IS NULL THEN 0 ELSE xccc218c END)),SUM((CASE WHEN xccc218d IS NULL THEN 0 ELSE xccc218d END)),",
                     "       SUM((CASE WHEN xccc218e IS NULL THEN 0 ELSE xccc218e END)),SUM((CASE WHEN xccc218f IS NULL THEN 0 ELSE xccc218f END)),",
                     "       SUM((CASE WHEN xccc218g IS NULL THEN 0 ELSE xccc218g END)),SUM((CASE WHEN xccc218h IS NULL THEN 0 ELSE xccc218h END)) "
      WHEN '112'   #销退成本
         LET l_sql = "SELECT SUM((CASE WHEN xccc305 IS NULL THEN 0  ELSE xccc305 END)), SUM((CASE WHEN xccc306 IS NULL THEN 0  ELSE xccc306 END)), ",
                     "       SUM((CASE WHEN xccc306a IS NULL THEN 0 ELSE xccc306a END)),SUM((CASE WHEN xccc306b IS NULL THEN 0 ELSE xccc306b END)),",
                     "       SUM((CASE WHEN xccc306c IS NULL THEN 0 ELSE xccc306c END)),SUM((CASE WHEN xccc306d IS NULL THEN 0 ELSE xccc306d END)),",
                     "       SUM((CASE WHEN xccc306e IS NULL THEN 0 ELSE xccc306e END)),SUM((CASE WHEN xccc306f IS NULL THEN 0 ELSE xccc306f END)),",
                     "       SUM((CASE WHEN xccc306g IS NULL THEN 0 ELSE xccc306g END)),SUM((CASE WHEN xccc306h IS NULL THEN 0 ELSE xccc306h END)) " 
      WHEN '114'   #返工领出
         LET l_sql = "SELECT SUM((CASE WHEN xccc207 IS NULL THEN 0  ELSE xccc207 END)), SUM((CASE WHEN xccc208 IS NULL THEN 0  ELSE xccc208 END)), ",
                     "       SUM((CASE WHEN xccc208a IS NULL THEN 0 ELSE xccc208a END)),SUM((CASE WHEN xccc208b IS NULL THEN 0 ELSE xccc208b END)),",
                     "       SUM((CASE WHEN xccc208c IS NULL THEN 0 ELSE xccc208c END)),SUM((CASE WHEN xccc208d IS NULL THEN 0 ELSE xccc208d END)),",
                     "       SUM((CASE WHEN xccc208e IS NULL THEN 0 ELSE xccc208e END)),SUM((CASE WHEN xccc208f IS NULL THEN 0 ELSE xccc208f END)),",
                     "       SUM((CASE WHEN xccc208g IS NULL THEN 0 ELSE xccc208g END)),SUM((CASE WHEN xccc208h IS NULL THEN 0 ELSE xccc208h END)) "
      WHEN '107'   #工单发料
         LET l_sql = "SELECT SUM((CASE WHEN xccc301 IS NULL THEN 0  ELSE xccc301 END)), SUM((CASE WHEN xccc302 IS NULL THEN 0  ELSE xccc302 END)), ",
                     "       SUM((CASE WHEN xccc302a IS NULL THEN 0 ELSE xccc302a END)),SUM((CASE WHEN xccc302b IS NULL THEN 0 ELSE xccc302b END)),",
                     "       SUM((CASE WHEN xccc302c IS NULL THEN 0 ELSE xccc302c END)),SUM((CASE WHEN xccc302d IS NULL THEN 0 ELSE xccc302d END)),",
                     "       SUM((CASE WHEN xccc302e IS NULL THEN 0 ELSE xccc302e END)),SUM((CASE WHEN xccc302f IS NULL THEN 0 ELSE xccc302f END)),",
                     "       SUM((CASE WHEN xccc302g IS NULL THEN 0 ELSE xccc302g END)),SUM((CASE WHEN xccc302h IS NULL THEN 0 ELSE xccc302h END)) "
      WHEN '108'   #杂项发料      
         LET l_sql = "SELECT SUM((CASE WHEN xccc309 IS NULL THEN 0  ELSE xccc309 END)), SUM((CASE WHEN xccc310 IS NULL THEN 0  ELSE xccc310 END)), ",
                     "       SUM((CASE WHEN xccc310a IS NULL THEN 0 ELSE xccc310a END)),SUM((CASE WHEN xccc310b IS NULL THEN 0 ELSE xccc310b END)),",
                     "       SUM((CASE WHEN xccc310c IS NULL THEN 0 ELSE xccc310c END)),SUM((CASE WHEN xccc310d IS NULL THEN 0 ELSE xccc310d END)),",
                     "       SUM((CASE WHEN xccc310e IS NULL THEN 0 ELSE xccc310e END)),SUM((CASE WHEN xccc310f IS NULL THEN 0 ELSE xccc310f END)),",
                     "       SUM((CASE WHEN xccc310g IS NULL THEN 0 ELSE xccc310g END)),SUM((CASE WHEN xccc310h IS NULL THEN 0 ELSE xccc310h END)) "
      WHEN '110'  #销货
         LET l_sql = "SELECT SUM((CASE WHEN xccc303 IS NULL THEN 0  ELSE xccc303 END)), SUM((CASE WHEN xccc304 IS NULL THEN 0  ELSE xccc304 END)), ",
                     "       SUM((CASE WHEN xccc304a IS NULL THEN 0 ELSE xccc304a END)),SUM((CASE WHEN xccc304b IS NULL THEN 0 ELSE xccc304b END)),",
                     "       SUM((CASE WHEN xccc304c IS NULL THEN 0 ELSE xccc304c END)),SUM((CASE WHEN xccc304d IS NULL THEN 0 ELSE xccc304d END)),",
                     "       SUM((CASE WHEN xccc304e IS NULL THEN 0 ELSE xccc304e END)),SUM((CASE WHEN xccc304f IS NULL THEN 0 ELSE xccc304f END)),",
                     "       SUM((CASE WHEN xccc304g IS NULL THEN 0 ELSE xccc304g END)),SUM((CASE WHEN xccc304h IS NULL THEN 0 ELSE xccc304h END)) "
      WHEN '111'   #销售费用
         LET l_sql = "SELECT SUM((CASE WHEN xccc307 IS NULL THEN 0  ELSE xccc307 END)), SUM((CASE WHEN xccc308 IS NULL THEN 0  ELSE xccc308 END)), ",
                     "       SUM((CASE WHEN xccc308a IS NULL THEN 0 ELSE xccc308a END)),SUM((CASE WHEN xccc308b IS NULL THEN 0 ELSE xccc308b END)),",
                     "       SUM((CASE WHEN xccc308c IS NULL THEN 0 ELSE xccc308c END)),SUM((CASE WHEN xccc308d IS NULL THEN 0 ELSE xccc308d END)),",
                     "       SUM((CASE WHEN xccc308e IS NULL THEN 0 ELSE xccc308e END)),SUM((CASE WHEN xccc308f IS NULL THEN 0 ELSE xccc308f END)),",
                     "       SUM((CASE WHEN xccc308g IS NULL THEN 0 ELSE xccc308g END)),SUM((CASE WHEN xccc308h IS NULL THEN 0 ELSE xccc308h END)) "
      WHEN '109'   #盘盈亏
         LET l_sql = "SELECT SUM((CASE WHEN xccc311 IS NULL THEN 0  ELSE xccc311 END)), SUM((CASE WHEN xccc312 IS NULL THEN 0  ELSE xccc312 END)), ",
                     "       SUM((CASE WHEN xccc312a IS NULL THEN 0 ELSE xccc312a END)),SUM((CASE WHEN xccc312b IS NULL THEN 0 ELSE xccc312b END)),",
                     "       SUM((CASE WHEN xccc312c IS NULL THEN 0 ELSE xccc312c END)),SUM((CASE WHEN xccc312d IS NULL THEN 0 ELSE xccc312d END)),",
                     "       SUM((CASE WHEN xccc312e IS NULL THEN 0 ELSE xccc312e END)),SUM((CASE WHEN xccc312f IS NULL THEN 0 ELSE xccc312f END)),",
                     "       SUM((CASE WHEN xccc312g IS NULL THEN 0 ELSE xccc312g END)),SUM((CASE WHEN xccc312h IS NULL THEN 0 ELSE xccc312h END)) "
      WHEN '119'   #调拨出库
         LET l_sql = "SELECT SUM((CASE WHEN xccc313 IS NULL THEN 0  ELSE xccc313 END)), SUM((CASE WHEN xccc314 IS NULL THEN 0  ELSE xccc314 END)), ",
                     "       SUM((CASE WHEN xccc314a IS NULL THEN 0 ELSE xccc314a END)),SUM((CASE WHEN xccc314b IS NULL THEN 0 ELSE xccc314b END)),",
                     "       SUM((CASE WHEN xccc314c IS NULL THEN 0 ELSE xccc314c END)),SUM((CASE WHEN xccc314d IS NULL THEN 0 ELSE xccc314d END)),",
                     "       SUM((CASE WHEN xccc314e IS NULL THEN 0 ELSE xccc314e END)),SUM((CASE WHEN xccc314f IS NULL THEN 0 ELSE xccc314f END)),",
                     "       SUM((CASE WHEN xccc314g IS NULL THEN 0 ELSE xccc314g END)),SUM((CASE WHEN xccc314h IS NULL THEN 0 ELSE xccc314h END)) "
                     
   END CASE
   
   LET l_sql = l_sql , "  FROM xccc_t  ",
                  " WHERE xcccent = '",g_enterprise,"' AND xcccld = '",g_master.xckkld,"' AND xccccomp = '",g_master.xckkcomp,"' ",
                  "   AND xccc001 = '",g_master.xckk001,"' AND xccc003 = '",g_master.xckk002,"' ", 
                  "   AND xccc004 = '",g_master.xckk003,"' AND xccc005 = '",g_master.xckk004,"' ",
                  "   AND (CASE WHEN xccc002 IS NULL THEN ' ' ELSE xccc002 END) = ? ",
                  "   AND (CASE WHEN xccc006 IS NULL THEN ' ' ELSE xccc006 END) = ? ",
                  "   AND (CASE WHEN xccc007 IS NULL THEN ' ' ELSE xccc007 END) = ? ",
                  "   AND (CASE WHEN xccc008 IS NULL THEN ' ' ELSE xccc008 END) = ? "
                  
   PREPARE axcq603_sel_xccc_pb2 FROM l_sql
   DECLARE axcq603_sel_xccc_cs2 CURSOR FOR axcq603_sel_xccc_pb2
   
   #从明细表xcck抓资料
   #l_sql 与l_sql1的区别是，xcck055的条件是否直接写入sql中
   #因为有些核对项目还需限定相关联的xcck020，所以l_sql1供比较特殊的核对项目，自行限定条件
   #LET l_sql = "SELECT (CASE WHEN xcck002 IS NULL THEN ' ' ELSE xcck002 END),",
   #            "       (CASE WHEN xcck010 IS NULL THEN ' ' ELSE xcck010 END),",
   #            "       (CASE WHEN xcck011 IS NULL THEN ' ' ELSE xcck011 END),",
   #            "       (CASE WHEN xcck017 IS NULL THEN ' ' ELSE xcck017 END),",
   LET l_sql = "SELECT SUM((CASE WHEN xcck201  IS NULL THEN 0 ELSE xcck201  END)* xcck009),SUM((CASE WHEN xcck202  IS NULL THEN 0 ELSE xcck202  END)*xcck009),", 
               "       SUM((CASE WHEN xcck202a IS NULL THEN 0 ELSE xcck202a END)* xcck009),SUM((CASE WHEN xcck202b IS NULL THEN 0 ELSE xcck202b END)*xcck009),",
               "       SUM((CASE WHEN xcck202c IS NULL THEN 0 ELSE xcck202c END)* xcck009),SUM((CASE WHEN xcck202d IS NULL THEN 0 ELSE xcck202d END)*xcck009),",
               "       SUM((CASE WHEN xcck202e IS NULL THEN 0 ELSE xcck202e END)* xcck009),SUM((CASE WHEN xcck202f IS NULL THEN 0 ELSE xcck202f END)*xcck009),",
               "       SUM((CASE WHEN xcck202g IS NULL THEN 0 ELSE xcck202g END)* xcck009),SUM((CASE WHEN xcck202h IS NULL THEN 0 ELSE xcck202h END)*xcck009) ",
               " FROM xcck_t ",
               " WHERE xcckent = '",g_enterprise,"' AND xcckld = '",g_master.xckkld,"' AND xcckcomp = '",g_master.xckkcomp,"' ",
               "   AND xcck001 = '",g_master.xckk001,"' AND xcck003 = '",g_master.xckk002,"' ",
               "   AND xcck004 = '",g_master.xckk003,"' AND xcck005 = '",g_master.xckk004,"' ",
               "   AND xcck055 = ? " 
   #用xcckent 用? 传入，是为了匹配l_sql 中有一个?
   #LET l_sql1 = "SELECT (CASE WHEN xcck002 IS NULL THEN ' ' ELSE xcck002 END),",
   #            "       (CASE WHEN xcck010 IS NULL THEN ' ' ELSE xcck010 END),",
   #            "       (CASE WHEN xcck011 IS NULL THEN ' ' ELSE xcck011 END),",
   #            "       (CASE WHEN xcck017 IS NULL THEN ' ' ELSE xcck017 END),",
   LET l_sql1 = "SELECT SUM((CASE WHEN xcck201  IS NULL THEN 0 ELSE xcck201  END)* xcck009),SUM((CASE WHEN xcck202  IS NULL THEN 0 ELSE xcck202  END)*xcck009),", 
               "       SUM((CASE WHEN xcck202a IS NULL THEN 0 ELSE xcck202a END)* xcck009),SUM((CASE WHEN xcck202b IS NULL THEN 0 ELSE xcck202b END)*xcck009),",
               "       SUM((CASE WHEN xcck202c IS NULL THEN 0 ELSE xcck202c END)* xcck009),SUM((CASE WHEN xcck202d IS NULL THEN 0 ELSE xcck202d END)*xcck009),",
               "       SUM((CASE WHEN xcck202e IS NULL THEN 0 ELSE xcck202e END)* xcck009),SUM((CASE WHEN xcck202f IS NULL THEN 0 ELSE xcck202f END)*xcck009),",
               "       SUM((CASE WHEN xcck202g IS NULL THEN 0 ELSE xcck202g END)* xcck009),SUM((CASE WHEN xcck202h IS NULL THEN 0 ELSE xcck202h END)*xcck009) ",
               " FROM xcck_t ",
               " WHERE xcckent = ? AND xcckld = '",g_master.xckkld,"' AND xcckcomp = '",g_master.xckkcomp,"' ",
               "   AND xcck001 = '",g_master.xckk001,"' AND xcck003 = '",g_master.xckk002,"' ",
               "   AND xcck004 = '",g_master.xckk003,"' AND xcck005 = '",g_master.xckk004,"' "
   #用xcckent 用? 传入，是为了匹配l_sql 中有一个?
   LET l_sql_1 = " SELECT DISTINCT a , b ,c , d FROM ( ",
                    "          SELECT DISTINCT (CASE WHEN xcck002 IS NULL THEN ' ' ELSE xcck002 END) a,",
                    "                          (CASE WHEN xcck010 IS NULL THEN ' ' ELSE xcck010 END) b,",
                    "                          (CASE WHEN xcck011 IS NULL THEN ' ' ELSE xcck011 END) c,",
                    "                          (CASE WHEN xcck017 IS NULL THEN ' ' ELSE xcck017 END) d ",
                    "                 FROM xcck_t ",
                    "            WHERE xcckent = '",g_enterprise,"' AND xcckld = '",g_master.xckkld,"' AND xcckcomp = '",g_master.xckkcomp,"' ",
                    "              AND xcck001 = '",g_master.xckk001,"' AND xcck003 = '",g_master.xckk002,"' ",
                    "              AND xcck004 = '",g_master.xckk003,"' AND xcck005 = '",g_master.xckk004,"' ",
                    "              AND xcck055 = ? " 
                    
   LET l_sql_2 = " SELECT DISTINCT a , b ,c , d FROM ( ",
                    "          SELECT DISTINCT (CASE WHEN xcck002 IS NULL THEN ' ' ELSE xcck002 END) a,",
                    "                          (CASE WHEN xcck010 IS NULL THEN ' ' ELSE xcck010 END) b,",
                    "                          (CASE WHEN xcck011 IS NULL THEN ' ' ELSE xcck011 END) c,",
                    "                          (CASE WHEN xcck017 IS NULL THEN ' ' ELSE xcck017 END) d ",
                    "                 FROM xcck_t ",
                    " WHERE xcckent = ? AND xcckld = '",g_master.xckkld,"' AND xcckcomp = '",g_master.xckkcomp,"' ",
                    "   AND xcck001 = '",g_master.xckk001,"' AND xcck003 = '",g_master.xckk002,"' ",
                    "   AND xcck004 = '",g_master.xckk003,"' AND xcck005 = '",g_master.xckk004,"' "

   LET l_xcck055 = ''
   
   #抓取不同类型对应的资料
   CASE p_xckk.xckk005   
      WHEN '102'  # 一般采购
         #160531-00032#1---s
         #LET l_xcck055 =  '201'    #采购入库(采购入库、采购仓退)
         LET l_sql2 = ''
         LET l_sql2 = l_sql1 , " AND xcck055 LIKE '201%' "  #采购入库(采购入库、采购仓退)
         LET l_sql_3 = ''
         LET l_sql_3 = l_sql_2 , " AND xcck055 LIKE '201%' "  #采购入库(采购入库、采购仓退)
         LET l_xcck055 = g_enterprise
         #160531-00032#1---e
      WHEN '117'  #委外入库
         LET l_xcck055 =  '203'    #委外入庫(委外入庫、委外聯產品入庫、委外多產出入庫、委外拆件入庫、委外倉退)  
      WHEN '105'  #工单入库
         LET l_xcck055 =  '205'    #工单入库(生產入庫、聯產品入庫、多主件產出入庫)  
      WHEN '115'  #返工入库 
         LET l_xcck055 =  '209'    #返工入库 
      WHEN '104'  #杂项入库
         LET l_xcck055 =  '211'    #雜收入庫  
      WHEN '118'   #调拨入库 
         LET l_xcck055 =  '217'    #其他入库   
         LET l_sql = l_sql , " AND xcck020 = '401' "   #401.調撥 & inaj004 = '1(入项）' 
         LET l_sql_1 = l_sql_1 , " AND xcck020 = '401' "   #401.調撥 & inaj004 = '1(入项）' 
      WHEN '112'   #销退成本
         IF cl_get_para(g_enterprise,g_site,'S-FIN-6006') = 1 THEN
            LET l_xcck055 =  '305'   #销退(xcck020 = 202.銷售退貨 & S-FIN-6006 = 1)
         END IF
      WHEN '114'  #返工领出
         LET l_xcck055 =  '207'     #重工领出
      WHEN '107'   #工单发料
         #LET l_xcck055 =  '301'     #工单领用（非月加权）  #160531-00032#1
         LET l_xcck055 =  '3012'     #工单领用             #160531-00032#1
      WHEN '108'   #杂项发料 
         LET l_sql2 = ''
         LET l_sql2 = l_sql1 , " AND xcck055 IN ('309','3091','3092') "   #杂发（非月加权） 
         #LET l_sql2 = l_sql2 , " AND xcck020 = '301' "   #'301'  #雜發出庫   #161031-00037#1
         
         LET l_sql_3 = ''
         #LET l_sql_3 = l_sql_2 , " AND xcck055 IN ('309','3091','3092') AND xcck020 = '301' "   #杂发（非月加权）   #161031-00037#1
         LET l_sql_3 = l_sql_2 , " AND xcck055 IN ('309','3091','3092') "   #杂发（非月加权）   #161031-00037#1
         
         LET l_xcck055 = g_enterprise         
      WHEN '110'   #销售出货
         #'303'    #销货(201.銷售出庫) '215' #销退入库(202.銷售退貨 & S-FIN-6006 = 2/3)  307    #销售费用(样品的，记为销售费用)
         # S-FIN-6006 3的话表示xccc中的销售成本是含了销退的，所以xcck明细中要抓出货＋销退；如果是选1的话，表示xccc中的销售成本只有出货，销退成本是做为入项的
         #              所以为2、3，需将销退成本计算到当前核对项目(销货)中
         # S-FIN-6019 勾选的话是xccc中的销售出货就不含样品，还需要抓取样品的xcck明细
         LET l_sql2 = ''
         IF cl_get_para(g_enterprise,g_site,'S-FIN-6019') THEN
            IF cl_get_para(g_enterprise,g_site,'S-FIN-6006') MATCHES '[23]' THEN
               LET l_sql2 = l_sql1 , " AND (xcck055 = '303' OR xcck055 = '215' OR (xcck055 = '307' AND xcck020 ='201')) "   #201.銷售出庫
            ELSE
               LET l_sql2 = l_sql1 , " AND (xcck055 = '303' OR (xcck055 = '307' AND xcck020 ='201')) "   #201.銷售出庫
            END IF
         ELSE
            IF cl_get_para(g_enterprise,g_site,'S-FIN-6006') MATCHES '[23]' THEN
               LET l_sql2 = l_sql1 , " AND (xcck055 = '303' OR xcck055 = '215') "   #201.銷售出庫
            ELSE
               LET l_sql2 = l_sql1 , " AND xcck055 = '303' "   #201.銷售出庫
            END IF
         END IF
         LET l_sql_3 = ''
         IF cl_get_para(g_enterprise,g_site,'S-FIN-6019') THEN
            IF cl_get_para(g_enterprise,g_site,'S-FIN-6006') MATCHES '[23]' THEN
               LET l_sql_3 = l_sql_2 , " AND (xcck055 = '303' OR xcck055 = '215' OR (xcck055 = '307' AND xcck020 ='201')) "   #201.銷售出庫
            ELSE
               LET l_sql_3 = l_sql_2 , " AND (xcck055 = '303' OR (xcck055 = '307' AND xcck020 ='201')) "   #201.銷售出庫
            END IF
         ELSE
            IF cl_get_para(g_enterprise,g_site,'S-FIN-6006') MATCHES '[23]' THEN
               LET l_sql_3 = l_sql_2 , " AND (xcck055 = '303' OR xcck055 = '215') "   #201.銷售出庫
            ELSE
               LET l_sql_3 = l_sql_2 , " AND xcck055 = '303' "   #201.銷售出庫
            END IF
         END IF
         LET l_xcck055 = g_enterprise
         
      WHEN '111'   #销售费用
         LET l_xcck055 =  '307'   #销售费用
         #S-FIN-6019 勾选的话是xccc中的销售出货就不含样品，样品的部分已经算到销售出货里面了，算销售费用时，需除去样品的费用
         IF cl_get_para(g_enterprise,g_site,'S-FIN-6019') THEN
            LET l_sql = l_sql , " AND xcck020 <> '201' "   #201.銷售出庫
            LET l_sql_1 = l_sql_1 , " AND xcck020 <> '201' "   #201.銷售出庫
         END IF
      WHEN '109'   #盘盈亏
         LET l_xcck055 =  '311'   #盘盈亏
      WHEN '119'   #调拨出库
         LET l_sql2 = ''
         #170210-00001#1--mark--start--
         #LET l_sql2 = l_sql1 , " AND xcck055 IN  ('313','3131') "  #其他出库（非月加权）、调拨出库(仅月加权）
         #LET l_sql2 = l_sql2 , " AND xcck020 = '401' "  ##401.調撥 & inaj004 = '2(出项）'
         #LET l_sql_3 = ''
         #LET l_sql_3 = l_sql_2 , " AND xcck055 IN  ('313','3131') AND xcck020 = '401' "  #其他出库（非月加权）、调拨出库(仅月加权）
         #170210-00001#1--mark--end----
         #170210-00001#1--add--start--
         LET l_sql2 = l_sql1 , " AND xcck055 IN  ('3132') "  #其他出库（非月加权）、调拨出库(仅月加权）
         LET l_sql_3 = ''
         LET l_sql_3 = l_sql_2 , " AND xcck055 IN  ('3132') "  #其他出库（非月加权）、调拨出库(仅月加权）
         #170210-00001#1--add--end----
         LET l_xcck055 = g_enterprise  
   END CASE
   
   #该核对项目比较特殊，所以另写的sql
   IF p_xckk.xckk005 = '110' OR  #销售出货
      p_xckk.xckk005 = '108' OR  #杂项发料 
      #160531-00032#1---s
      p_xckk.xckk005 = '102' OR  #采购入库
      p_xckk.xckk005 = '119'     #调拨出库
      #160531-00032#1---e
      THEN
      LET l_sql = l_sql2
      LET l_sql_1 = l_sql_3
   END IF
   
   #LET l_sql = l_sql , " GROUP BY (CASE WHEN xcck002 IS NULL THEN ' ' ELSE xcck002 END),",
   #                    "          (CASE WHEN xcck010 IS NULL THEN ' ' ELSE xcck010 END),",
   #                    "          (CASE WHEN xcck011 IS NULL THEN ' ' ELSE xcck011 END),",
   #                    "          (CASE WHEN xcck017 IS NULL THEN ' ' ELSE xcck017 END) "
   LET l_sql = l_sql , " AND (CASE WHEN xcck002 IS NULL THEN ' ' ELSE xcck002 END) = ? ",
                       " AND (CASE WHEN xcck010 IS NULL THEN ' ' ELSE xcck010 END) = ? ",
                       " AND (CASE WHEN xcck011 IS NULL THEN ' ' ELSE xcck011 END) = ? ",
                       " AND (CASE WHEN xcck017 IS NULL THEN ' ' ELSE xcck017 END) = ? "
   PREPARE axcq603_sel_xcck_pb1 FROM l_sql
   DECLARE axcq603_sel_xcck_cs1 CURSOR FOR axcq603_sel_xcck_pb1
   
   LET l_sql_1 = l_sql_1 , " UNION " ,
                           "  SELECT DISTINCT (CASE WHEN xccc002 IS NULL THEN ' ' ELSE xccc002 END) a, ",
                           "                  (CASE WHEN xccc006 IS NULL THEN ' ' ELSE xccc006 END) b, ",
                           "                  (CASE WHEN xccc007 IS NULL THEN ' ' ELSE xccc007 END) c, ",
                           "                  (CASE WHEN xccc008 IS NULL THEN ' ' ELSE xccc008 END) d  ",
                           "   FROM xccc_t  ",
                           " WHERE xcccent = '",g_enterprise,"' AND xcccld = '",g_master.xckkld,"' AND xccccomp = '",g_master.xckkcomp,"' ",
                           "   AND xccc001 = '",g_master.xckk001,"' AND xccc003 = '",g_master.xckk002,"' ", 
                           "   AND xccc004 = '",g_master.xckk003,"' AND xccc005 = '",g_master.xckk004,"' "
   LET l_sql_1 = l_sql_1 , " ) "
   PREPARE axcq603_sel_xccc002_pb1 FROM l_sql_1
   DECLARE axcq603_sel_xccc002_cs1 CURSOR FOR axcq603_sel_xccc002_pb1
   FOREACH axcq603_sel_xccc002_cs1 USING l_xcck055
                                   INTO l_xckl.xckl010, l_xckl.xckl007, l_xckl.xckl008, l_xckl.xckl009
   
   #FOREACH axcq603_sel_xcck_cs1 USING l_xcck055
   #                             INTO l_xckl.xckl010, l_xckl.xckl007, l_xckl.xckl008, l_xckl.xckl009,
   #                                  l_xckl.xckl103, l_xckl.xckl104, l_xckl.xckl104a,l_xckl.xckl104b,l_xckl.xckl104c,
   #                                  l_xckl.xckl104d,l_xckl.xckl104e,l_xckl.xckl104f,l_xckl.xckl104g,l_xckl.xckl104h   
   #                      
      IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xcck_t"
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      EXECUTE axcq603_sel_xcck_cs1 USING l_xcck055 , l_xckl.xckl010, l_xckl.xckl007, l_xckl.xckl008, l_xckl.xckl009
                                   INTO l_xckl.xckl103, l_xckl.xckl104, l_xckl.xckl104a,l_xckl.xckl104b,l_xckl.xckl104c,
                                        l_xckl.xckl104d,l_xckl.xckl104e,l_xckl.xckl104f,l_xckl.xckl104g,l_xckl.xckl104h   
      
      EXECUTE axcq603_sel_xccc_cs2 USING l_xckl.xckl010, l_xckl.xckl007, l_xckl.xckl008, l_xckl.xckl009
                                   INTO l_xckl.xckl101, l_xckl.xckl102, l_xckl.xckl102a,l_xckl.xckl102b,l_xckl.xckl102c,
                                        l_xckl.xckl102d,l_xckl.xckl102e,l_xckl.xckl102f,l_xckl.xckl102g,l_xckl.xckl102h 
                                        
      IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xccc_t"
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
        
      #161109-00085#26-s mod            
#      IF NOT axcq603_ins_xckl(l_xckl.*) THEN   #161109-00085#26-s mark
      IF NOT axcq603_ins_xckl(l_xckl.xcklent,l_xckl.xcklcomp,l_xckl.xcklld,l_xckl.xckl001,l_xckl.xckl002,
                              l_xckl.xckl003,l_xckl.xckl004,l_xckl.xckl005,l_xckl.xckl006,l_xckl.xckl007,
                              l_xckl.xckl008,l_xckl.xckl009,l_xckl.xckl010,l_xckl.xckl090,l_xckl.xckl101,
                              l_xckl.xckl102,l_xckl.xckl102a,l_xckl.xckl102b,l_xckl.xckl102c,l_xckl.xckl102d,
                              l_xckl.xckl102e,l_xckl.xckl102f,l_xckl.xckl102g,l_xckl.xckl102h,l_xckl.xckl103,
                              l_xckl.xckl104,l_xckl.xckl104a,l_xckl.xckl104b,l_xckl.xckl104c,l_xckl.xckl104d,
                              l_xckl.xckl104e,l_xckl.xckl104f,l_xckl.xckl104g,l_xckl.xckl104h,l_xckl.xckl105,
                              l_xckl.xckl106,l_xckl.xckl106a,l_xckl.xckl106b,l_xckl.xckl106c,l_xckl.xckl106d,
                              l_xckl.xckl106e,l_xckl.xckl106f,l_xckl.xckl106g,l_xckl.xckl106h) THEN
      #161109-00085#26-e mod      
         LET r_success = FALSE
         RETURN r_success
      END IF
      
   END FOREACH                                          
   
   RETURN r_success
   
END FUNCTION

#当站下线和入库调整，抓取xcco,xcck写入
PRIVATE FUNCTION axcq603_gen_xckl_3(p_xckk)
#161109-00085#26-s mod
#DEFINE p_xckk          RECORD LIKE xckk_t.*   #161109-00085#26-s mark
DEFINE p_xckk          RECORD  #成本勾稽表
       xckkent LIKE xckk_t.xckkent, #企業編號
       xckkcomp LIKE xckk_t.xckkcomp, #法人組織
       xckkld LIKE xckk_t.xckkld, #帳套
       xckk001 LIKE xckk_t.xckk001, #本位幣順序
       xckk002 LIKE xckk_t.xckk002, #成本計算類型
       xckk003 LIKE xckk_t.xckk003, #年度
       xckk004 LIKE xckk_t.xckk004, #期別
       xckk005 LIKE xckk_t.xckk005, #
       xckk090 LIKE xckk_t.xckk090, #明細程式編號
       xckk101 LIKE xckk_t.xckk101, #總報表數量
       xckk102 LIKE xckk_t.xckk102, #總報表金額
       xckk102a LIKE xckk_t.xckk102a, #材料
       xckk102b LIKE xckk_t.xckk102b, #人工
       xckk102c LIKE xckk_t.xckk102c, #加工
       xckk102d LIKE xckk_t.xckk102d, #制費一
       xckk102e LIKE xckk_t.xckk102e, #制費二
       xckk102f LIKE xckk_t.xckk102f, #制費三
       xckk102g LIKE xckk_t.xckk102g, #製費四
       xckk102h LIKE xckk_t.xckk102h, #制費五
       xckk103 LIKE xckk_t.xckk103, #分報表數量
       xckk104 LIKE xckk_t.xckk104, #分報表金額
       xckk104a LIKE xckk_t.xckk104a, #分報表材料
       xckk104b LIKE xckk_t.xckk104b, #分報表人工
       xckk104c LIKE xckk_t.xckk104c, #分報表加工
       xckk104d LIKE xckk_t.xckk104d, #分報表制費一
       xckk104e LIKE xckk_t.xckk104e, #分報表制費二
       xckk104f LIKE xckk_t.xckk104f, #分報表制費三
       xckk104g LIKE xckk_t.xckk104g, #分報表制費四
       xckk104h LIKE xckk_t.xckk104h, #分報表制費五
       xckk105 LIKE xckk_t.xckk105, #差異數量
       xckk106 LIKE xckk_t.xckk106, #差異金額
       xckk106a LIKE xckk_t.xckk106a, #差異金額-材料
       xckk106b LIKE xckk_t.xckk106b, #差異金額-人工
       xckk106c LIKE xckk_t.xckk106c, #差異金額-加工
       xckk106d LIKE xckk_t.xckk106d, #差異金額-制費一
       xckk106e LIKE xckk_t.xckk106e, #差異金額-制費二
       xckk106f LIKE xckk_t.xckk106f, #差異金額-制費三
       xckk106g LIKE xckk_t.xckk106g, #差異金額-制費四
       xckk106h LIKE xckk_t.xckk106h  #差異金額-制費五
                END RECORD
#161109-00085#26-e mod
DEFINE r_success    LIKE type_t.num5
#161109-00085#26-s mod
#DEFINE l_xckl       RECORD LIKE xckl_t.*   #161109-00085#26-s mark
DEFINE l_xckl       RECORD  #成本勾稽明細表
       xcklent LIKE xckl_t.xcklent, #企業編號
       xcklcomp LIKE xckl_t.xcklcomp, #法人組織
       xcklld LIKE xckl_t.xcklld, #帳套
       xckl001 LIKE xckl_t.xckl001, #本位幣順序
       xckl002 LIKE xckl_t.xckl002, #成本計算類型
       xckl003 LIKE xckl_t.xckl003, #年度
       xckl004 LIKE xckl_t.xckl004, #期別
       xckl005 LIKE xckl_t.xckl005, #
       xckl006 LIKE xckl_t.xckl006, #在製單據編號
       xckl007 LIKE xckl_t.xckl007, #料號
       xckl008 LIKE xckl_t.xckl008, #特徵
       xckl009 LIKE xckl_t.xckl009, #批號
       xckl010 LIKE xckl_t.xckl010, #成本域
       xckl090 LIKE xckl_t.xckl090, #明細程式編號
       xckl101 LIKE xckl_t.xckl101, #總報表數量
       xckl102 LIKE xckl_t.xckl102, #總報表金額
       xckl102a LIKE xckl_t.xckl102a, #材料
       xckl102b LIKE xckl_t.xckl102b, #人工
       xckl102c LIKE xckl_t.xckl102c, #加工
       xckl102d LIKE xckl_t.xckl102d, #制費一
       xckl102e LIKE xckl_t.xckl102e, #制費二
       xckl102f LIKE xckl_t.xckl102f, #制費三
       xckl102g LIKE xckl_t.xckl102g, #製費四
       xckl102h LIKE xckl_t.xckl102h, #制費五
       xckl103 LIKE xckl_t.xckl103, #分報表數量
       xckl104 LIKE xckl_t.xckl104, #分報表金額
       xckl104a LIKE xckl_t.xckl104a, #分報表材料
       xckl104b LIKE xckl_t.xckl104b, #分報表人工
       xckl104c LIKE xckl_t.xckl104c, #分報表加工
       xckl104d LIKE xckl_t.xckl104d, #分報表制費一
       xckl104e LIKE xckl_t.xckl104e, #分報表制費二
       xckl104f LIKE xckl_t.xckl104f, #分報表制費三
       xckl104g LIKE xckl_t.xckl104g, #分報表制費四
       xckl104h LIKE xckl_t.xckl104h, #分報表制費五
       xckl105 LIKE xckl_t.xckl105, #差異數量
       xckl106 LIKE xckl_t.xckl106, #差異金額
       xckl106a LIKE xckl_t.xckl106a, #差異金額-材料
       xckl106b LIKE xckl_t.xckl106b, #差異金額-人工
       xckl106c LIKE xckl_t.xckl106c, #差異金額-加工
       xckl106d LIKE xckl_t.xckl106d, #差異金額-制費一
       xckl106e LIKE xckl_t.xckl106e, #差異金額-制費二
       xckl106f LIKE xckl_t.xckl106f, #差異金額-制費三
       xckl106g LIKE xckl_t.xckl106g, #差異金額-制費四
       xckl106h LIKE xckl_t.xckl106h  #差異金額-制費五
          END RECORD
#161109-00085#26-e mod
DEFINE l_sql        STRING
DEFINE l_xcck055    LIKE xcck_t.xcck055

   LET r_success = TRUE
   
   INITIALIZE l_xckl.* TO NULL
   
   LET l_xckl.xcklent = g_enterprise
   LET l_xckl.xcklcomp = g_master.xckkcomp
   LET l_xckl.xcklld = g_master.xckkld
   LET l_xckl.xckl001 = g_master.xckk001
   LET l_xckl.xckl002 = g_master.xckk002
   LET l_xckl.xckl003 = g_master.xckk003
   LET l_xckl.xckl004 = g_master.xckk004  
   LET l_xckl.xckl005 = p_xckk.xckk005
   LET l_xckl.xckl006 = ' ' #在制单据编号
   
   LET l_xckl.xckl090 = p_xckk.xckk090
   
   LET l_sql = ''
   # '106'  #当站下线和入库调整
   #根據料件+特性+批號等抓取總表xccc中對應的委外數量、金額欄位
   LET l_sql = "SELECT SUM((CASE WHEN xccc213 IS NULL THEN 0  ELSE xccc213 END)), SUM((CASE WHEN xccc214 IS NULL THEN 0  ELSE xccc214 END)), ",
               "       SUM((CASE WHEN xccc214a IS NULL THEN 0 ELSE xccc214a END)),SUM((CASE WHEN xccc214b IS NULL THEN 0 ELSE xccc214b END)),",
               "       SUM((CASE WHEN xccc214c IS NULL THEN 0 ELSE xccc214c END)),SUM((CASE WHEN xccc214d IS NULL THEN 0 ELSE xccc214d END)),",
               "       SUM((CASE WHEN xccc214e IS NULL THEN 0 ELSE xccc214e END)),SUM((CASE WHEN xccc214f IS NULL THEN 0 ELSE xccc214f END)),",
               "       SUM((CASE WHEN xccc214g IS NULL THEN 0 ELSE xccc214g END)),SUM((CASE WHEN xccc214h IS NULL THEN 0 ELSE xccc214h END)) ",
               "  FROM xccc_t  ",
               " WHERE xcccent = '",g_enterprise,"' AND xcccld = '",g_master.xckkld,"' AND xccccomp = '",g_master.xckkcomp,"' ",
               "   AND xccc001 = '",g_master.xckk001,"' AND xccc003 = '",g_master.xckk002,"' ", 
               "   AND xccc004 = '",g_master.xckk003,"' AND xccc005 = '",g_master.xckk004,"' ",
               "   AND (CASE WHEN xccc002 IS NULL THEN ' ' ELSE xccc002 END) = ? ",
               "   AND (CASE WHEN xccc006 IS NULL THEN ' ' ELSE xccc006 END) = ? ",
               "   AND (CASE WHEN xccc007 IS NULL THEN ' ' ELSE xccc007 END) = ? ",
               "   AND (CASE WHEN xccc008 IS NULL THEN ' ' ELSE xccc008 END) = ? "
               
   PREPARE axcq603_sel_xccc_pb3 FROM l_sql
   DECLARE axcq603_sel_xccc_cs3 CURSOR FOR axcq603_sel_xccc_pb3
   
   LET l_sql = " SELECT (CASE WHEN xcco002 IS NULL THEN ' ' ELSE xcco002 END),",
               "        (CASE WHEN xcco006 IS NULL THEN ' ' ELSE xcco006 END),",
               "        (CASE WHEN xcco007 IS NULL THEN ' ' ELSE xcco007 END),"
   #161031-00037#1---s
               #"        (CASE WHEN xcco008 IS NULL THEN ' ' ELSE xcco008 END),",
   IF g_cost_type = '3' THEN
      LET l_sql = l_sql CLIPPED,"        (CASE WHEN xcco008 IS NULL THEN ' ' ELSE xcco008 END),"  #月加权,则不管批号
   ELSE
      LET l_sql = l_sql CLIPPED," ' '," 
   END IF
               #"        0 ,SUM((CASE WHEN xcco102  IS NULL THEN 0 ELSE xcco102  END)),", 
   LET l_sql = l_sql CLIPPED, "        0 ,SUM((CASE WHEN xcco102  IS NULL THEN 0 ELSE xcco102  END)),",            
   #161031-00037#1---e                   
               "        SUM((CASE WHEN xcco102a IS NULL THEN 0 ELSE xcco102a END)),SUM((CASE WHEN xcco102b IS NULL THEN 0 ELSE xcco102b END)),",
               "        SUM((CASE WHEN xcco102c IS NULL THEN 0 ELSE xcco102c END)),SUM((CASE WHEN xcco102d IS NULL THEN 0 ELSE xcco102d END)),",
               "        SUM((CASE WHEN xcco102e IS NULL THEN 0 ELSE xcco102e END)),SUM((CASE WHEN xcco102f IS NULL THEN 0 ELSE xcco102f END)),",
               "        SUM((CASE WHEN xcco102g IS NULL THEN 0 ELSE xcco102g END)),SUM((CASE WHEN xcco102h IS NULL THEN 0 ELSE xcco102h END)) ",
               " FROM xcco_t ",
               " WHERE xccoent = '",g_enterprise,"' AND xccold = '",g_master.xckkld,"' AND xccocomp = '",g_master.xckkcomp,"' ",
               "   AND xcco001 = '",g_master.xckk001,"' AND xcco003 = '",g_master.xckk002,"' ",
               "   AND xcco004 = '",g_master.xckk003,"' AND xcco005 = '",g_master.xckk004,"' ",
               " GROUP BY (CASE WHEN xcco002 IS NULL THEN ' ' ELSE xcco002 END),",
               "          (CASE WHEN xcco006 IS NULL THEN ' ' ELSE xcco006 END),",
               "          (CASE WHEN xcco007 IS NULL THEN ' ' ELSE xcco007 END),"
   #161031-00037#1---s
               #"        (CASE WHEN xcco008 IS NULL THEN ' ' ELSE xcco008 END),",
   IF g_cost_type = '3' THEN
      LET l_sql = l_sql CLIPPED,"          (CASE WHEN xcco008 IS NULL THEN ' ' ELSE xcco008 END)"  #月加权,则不管批号
   ELSE
      LET l_sql = l_sql CLIPPED," ' '" 
   END IF
   #161031-00037#1---e                
               
                        
   #当站下线是否影响成本，为Y时，加上当站下线的成本
   IF cl_get_para(g_enterprise,g_site,'S-FIN-6006') = 'Y' THEN
      #从明细表xcck抓资料
      LET l_sql = l_sql," UNION ",
                        " SELECT (CASE WHEN xcck002 IS NULL THEN ' ' ELSE xcck002 END),",
                        "        (CASE WHEN xcck010 IS NULL THEN ' ' ELSE xcck010 END),",
                        "        (CASE WHEN xcck011 IS NULL THEN ' ' ELSE xcck011 END),"
      #161031-00037#1---s
                       #"        (CASE WHEN xcck017 IS NULL THEN ' ' ELSE xcck017 END),",
      IF g_cost_type = '3' THEN
         LET l_sql = l_sql CLIPPED,"  (CASE WHEN xcck017 IS NULL THEN ' ' ELSE xcck017 END),"  #月加权,则不管批号
      ELSE
         LET l_sql = l_sql CLIPPED," ' '," 
      END IF    
                        #"        SUM((CASE WHEN xcck201  IS NULL THEN 0 ELSE xcck201  END)* xcck009),SUM((CASE WHEN xcck202  IS NULL THEN 0 ELSE xcck202  END)*xcck009),",
      LET l_sql = l_sql CLIPPED," SUM((CASE WHEN xcck201  IS NULL THEN 0 ELSE xcck201  END)* xcck009),SUM((CASE WHEN xcck202  IS NULL THEN 0 ELSE xcck202  END)*xcck009),",           
      #161031-00037#1---e                             
                        "        SUM((CASE WHEN xcck202a IS NULL THEN 0 ELSE xcck202a END)* xcck009),SUM((CASE WHEN xcck202b IS NULL THEN 0 ELSE xcck202b END)*xcck009),",
                        "        SUM((CASE WHEN xcck202c IS NULL THEN 0 ELSE xcck202c END)* xcck009),SUM((CASE WHEN xcck202d IS NULL THEN 0 ELSE xcck202d END)*xcck009),",
                        "        SUM((CASE WHEN xcck202e IS NULL THEN 0 ELSE xcck202e END)* xcck009),SUM((CASE WHEN xcck202f IS NULL THEN 0 ELSE xcck202f END)*xcck009),",
                        "        SUM((CASE WHEN xcck202g IS NULL THEN 0 ELSE xcck202g END)* xcck009),SUM((CASE WHEN xcck202h IS NULL THEN 0 ELSE xcck202h END)*xcck009) ",
                        " FROM xcck_t ",
                        " WHERE xcckent = '",g_enterprise,"' AND xcckld = '",g_master.xckkld,"' AND xcckcomp = '",g_master.xckkcomp,"' ",
                        "   AND xcck001 = '",g_master.xckk001,"' AND xcck003 = '",g_master.xckk002,"' ",
                        "   AND xcck004 = '",g_master.xckk003,"' AND xcck005 = '",g_master.xckk004,"' ",
                        "   AND xcck055 = '213' AND xcck020 = '115' " ,  #115.當站下線 & S-FIN-6016 = 'Y'
                        " GROUP BY (CASE WHEN xcck002 IS NULL THEN ' ' ELSE xcck002 END),",
                        "          (CASE WHEN xcck010 IS NULL THEN ' ' ELSE xcck010 END),",
                        "          (CASE WHEN xcck011 IS NULL THEN ' ' ELSE xcck011 END),"
      #161031-00037#1---s
                       #"          (CASE WHEN xcck017 IS NULL THEN ' ' ELSE xcck017 END) "
      IF g_cost_type = '3' THEN
         LET l_sql = l_sql CLIPPED,"          (CASE WHEN xcck017 IS NULL THEN ' ' ELSE xcck017 END) "  #月加权,则不管批号
       ELSE
          LET l_sql = l_sql CLIPPED," ' '," 
      END IF
      #161031-00037#1---e       
   END IF
   
   PREPARE axcq603_sel_xcck_pb2 FROM l_sql
   DECLARE axcq603_sel_xcck_cs2 CURSOR FOR axcq603_sel_xcck_pb2
   
   FOREACH axcq603_sel_xcck_cs2 INTO l_xckl.xckl010, l_xckl.xckl007, l_xckl.xckl008, l_xckl.xckl009,
                                     l_xckl.xckl103, l_xckl.xckl104, l_xckl.xckl104a,l_xckl.xckl104b,l_xckl.xckl104c,
                                     l_xckl.xckl104d,l_xckl.xckl104e,l_xckl.xckl104f,l_xckl.xckl104g,l_xckl.xckl104h   
                         
      EXECUTE axcq603_sel_xccc_cs3 USING l_xckl.xckl010, l_xckl.xckl007, l_xckl.xckl008, l_xckl.xckl009
                                   INTO l_xckl.xckl101, l_xckl.xckl102, l_xckl.xckl102a,l_xckl.xckl102b,l_xckl.xckl102c,
                                        l_xckl.xckl102d,l_xckl.xckl102e,l_xckl.xckl102f,l_xckl.xckl102g,l_xckl.xckl102h 
                                        
      #161109-00085#26-s mod            
#      IF NOT axcq603_ins_xckl(l_xckl.*) THEN   #161109-00085#26-s mark
      IF NOT axcq603_ins_xckl(l_xckl.xcklent,l_xckl.xcklcomp,l_xckl.xcklld,l_xckl.xckl001,l_xckl.xckl002,
                              l_xckl.xckl003,l_xckl.xckl004,l_xckl.xckl005,l_xckl.xckl006,l_xckl.xckl007,
                              l_xckl.xckl008,l_xckl.xckl009,l_xckl.xckl010,l_xckl.xckl090,l_xckl.xckl101,
                              l_xckl.xckl102,l_xckl.xckl102a,l_xckl.xckl102b,l_xckl.xckl102c,l_xckl.xckl102d,
                              l_xckl.xckl102e,l_xckl.xckl102f,l_xckl.xckl102g,l_xckl.xckl102h,l_xckl.xckl103,
                              l_xckl.xckl104,l_xckl.xckl104a,l_xckl.xckl104b,l_xckl.xckl104c,l_xckl.xckl104d,
                              l_xckl.xckl104e,l_xckl.xckl104f,l_xckl.xckl104g,l_xckl.xckl104h,l_xckl.xckl105,
                              l_xckl.xckl106,l_xckl.xckl106a,l_xckl.xckl106b,l_xckl.xckl106c,l_xckl.xckl106d,
                              l_xckl.xckl106e,l_xckl.xckl106f,l_xckl.xckl106g,l_xckl.xckl106h) THEN
      #161109-00085#26-e mod      
         LET r_success = FALSE
         RETURN r_success
      END IF
      
   END FOREACH                                          
   
   RETURN r_success
   
END FUNCTION

##1.明细表抓上期的xccb的数据和金额
#2.明细表抓xcce的上期期末数量和金额，抓不到抓上期的xccb的数据和金额
PRIVATE FUNCTION axcq603_gen_xckl_4(p_xckk)
#161109-00085#26-s mod
#DEFINE p_xckk          RECORD LIKE xckk_t.*   #161109-00085#26-s mark
DEFINE p_xckk          RECORD  #成本勾稽表
       xckkent LIKE xckk_t.xckkent, #企業編號
       xckkcomp LIKE xckk_t.xckkcomp, #法人組織
       xckkld LIKE xckk_t.xckkld, #帳套
       xckk001 LIKE xckk_t.xckk001, #本位幣順序
       xckk002 LIKE xckk_t.xckk002, #成本計算類型
       xckk003 LIKE xckk_t.xckk003, #年度
       xckk004 LIKE xckk_t.xckk004, #期別
       xckk005 LIKE xckk_t.xckk005, #
       xckk090 LIKE xckk_t.xckk090, #明細程式編號
       xckk101 LIKE xckk_t.xckk101, #總報表數量
       xckk102 LIKE xckk_t.xckk102, #總報表金額
       xckk102a LIKE xckk_t.xckk102a, #材料
       xckk102b LIKE xckk_t.xckk102b, #人工
       xckk102c LIKE xckk_t.xckk102c, #加工
       xckk102d LIKE xckk_t.xckk102d, #制費一
       xckk102e LIKE xckk_t.xckk102e, #制費二
       xckk102f LIKE xckk_t.xckk102f, #制費三
       xckk102g LIKE xckk_t.xckk102g, #製費四
       xckk102h LIKE xckk_t.xckk102h, #制費五
       xckk103 LIKE xckk_t.xckk103, #分報表數量
       xckk104 LIKE xckk_t.xckk104, #分報表金額
       xckk104a LIKE xckk_t.xckk104a, #分報表材料
       xckk104b LIKE xckk_t.xckk104b, #分報表人工
       xckk104c LIKE xckk_t.xckk104c, #分報表加工
       xckk104d LIKE xckk_t.xckk104d, #分報表制費一
       xckk104e LIKE xckk_t.xckk104e, #分報表制費二
       xckk104f LIKE xckk_t.xckk104f, #分報表制費三
       xckk104g LIKE xckk_t.xckk104g, #分報表制費四
       xckk104h LIKE xckk_t.xckk104h, #分報表制費五
       xckk105 LIKE xckk_t.xckk105, #差異數量
       xckk106 LIKE xckk_t.xckk106, #差異金額
       xckk106a LIKE xckk_t.xckk106a, #差異金額-材料
       xckk106b LIKE xckk_t.xckk106b, #差異金額-人工
       xckk106c LIKE xckk_t.xckk106c, #差異金額-加工
       xckk106d LIKE xckk_t.xckk106d, #差異金額-制費一
       xckk106e LIKE xckk_t.xckk106e, #差異金額-制費二
       xckk106f LIKE xckk_t.xckk106f, #差異金額-制費三
       xckk106g LIKE xckk_t.xckk106g, #差異金額-制費四
       xckk106h LIKE xckk_t.xckk106h  #差異金額-制費五
                END RECORD
#161109-00085#26-e mod
DEFINE r_success    LIKE type_t.num5
#161109-00085#26-s mod
#DEFINE l_xckl       RECORD LIKE xckl_t.*   #161109-00085#26-s mark
DEFINE l_xckl       RECORD  #成本勾稽明細表
       xcklent LIKE xckl_t.xcklent, #企業編號
       xcklcomp LIKE xckl_t.xcklcomp, #法人組織
       xcklld LIKE xckl_t.xcklld, #帳套
       xckl001 LIKE xckl_t.xckl001, #本位幣順序
       xckl002 LIKE xckl_t.xckl002, #成本計算類型
       xckl003 LIKE xckl_t.xckl003, #年度
       xckl004 LIKE xckl_t.xckl004, #期別
       xckl005 LIKE xckl_t.xckl005, #
       xckl006 LIKE xckl_t.xckl006, #在製單據編號
       xckl007 LIKE xckl_t.xckl007, #料號
       xckl008 LIKE xckl_t.xckl008, #特徵
       xckl009 LIKE xckl_t.xckl009, #批號
       xckl010 LIKE xckl_t.xckl010, #成本域
       xckl090 LIKE xckl_t.xckl090, #明細程式編號
       xckl101 LIKE xckl_t.xckl101, #總報表數量
       xckl102 LIKE xckl_t.xckl102, #總報表金額
       xckl102a LIKE xckl_t.xckl102a, #材料
       xckl102b LIKE xckl_t.xckl102b, #人工
       xckl102c LIKE xckl_t.xckl102c, #加工
       xckl102d LIKE xckl_t.xckl102d, #制費一
       xckl102e LIKE xckl_t.xckl102e, #制費二
       xckl102f LIKE xckl_t.xckl102f, #制費三
       xckl102g LIKE xckl_t.xckl102g, #製費四
       xckl102h LIKE xckl_t.xckl102h, #制費五
       xckl103 LIKE xckl_t.xckl103, #分報表數量
       xckl104 LIKE xckl_t.xckl104, #分報表金額
       xckl104a LIKE xckl_t.xckl104a, #分報表材料
       xckl104b LIKE xckl_t.xckl104b, #分報表人工
       xckl104c LIKE xckl_t.xckl104c, #分報表加工
       xckl104d LIKE xckl_t.xckl104d, #分報表制費一
       xckl104e LIKE xckl_t.xckl104e, #分報表制費二
       xckl104f LIKE xckl_t.xckl104f, #分報表制費三
       xckl104g LIKE xckl_t.xckl104g, #分報表制費四
       xckl104h LIKE xckl_t.xckl104h, #分報表制費五
       xckl105 LIKE xckl_t.xckl105, #差異數量
       xckl106 LIKE xckl_t.xckl106, #差異金額
       xckl106a LIKE xckl_t.xckl106a, #差異金額-材料
       xckl106b LIKE xckl_t.xckl106b, #差異金額-人工
       xckl106c LIKE xckl_t.xckl106c, #差異金額-加工
       xckl106d LIKE xckl_t.xckl106d, #差異金額-制費一
       xckl106e LIKE xckl_t.xckl106e, #差異金額-制費二
       xckl106f LIKE xckl_t.xckl106f, #差異金額-制費三
       xckl106g LIKE xckl_t.xckl106g, #差異金額-制費四
       xckl106h LIKE xckl_t.xckl106h  #差異金額-制費五
          END RECORD
#161109-00085#26-e mod
DEFINE l_sql        STRING
DEFINE l_xckk003    LIKE xckk_t.xckk003
DEFINE l_xckk004    LIKE xckk_t.xckk004

   LET r_success = TRUE
   
   INITIALIZE l_xckl.* TO NULL
   
   LET l_xckl.xcklent = g_enterprise
   LET l_xckl.xcklcomp = g_master.xckkcomp
   LET l_xckl.xcklld = g_master.xckkld
   LET l_xckl.xckl001 = g_master.xckk001
   LET l_xckl.xckl002 = g_master.xckk002
   LET l_xckl.xckl003 = g_master.xckk003
   LET l_xckl.xckl004 = g_master.xckk004  
   LET l_xckl.xckl005 = p_xckk.xckk005
   
   LET l_xckl.xckl090 = p_xckk.xckk090
   
   LET l_xckl.xckl007 = ' '
   LET l_xckl.xckl008 = ' '
   LET l_xckl.xckl009 = ' '
   
   #从明细表xccb抓资料
   IF g_source = 'xccb' THEN
      #xccb 明細數量、金額
      LET l_sql = "SELECT (CASE WHEN xccb002 IS NULL THEN ' ' ELSE xccb002 END),",
                  "       (CASE WHEN xccb006 IS NULL THEN ' ' ELSE xccb006 END),",
                  "       (CASE WHEN xccb007 IS NULL THEN ' ' ELSE xccb007 END),", #161031-00037#1 remark
                  "       (CASE WHEN xccb008 IS NULL THEN ' ' ELSE xccb008 END),", #161031-00037#1 remark
                  "       (CASE WHEN xccb009 IS NULL THEN ' ' ELSE xccb009 END),", #161031-00037#1 remark
                  "       SUM((CASE WHEN xccb101 IS NULL THEN 0 ELSE xccb101 END)),  SUM((CASE WHEN xccb102 IS NULL THEN 0 ELSE xccb102 END)),  ",
                  "       SUM((CASE WHEN xccb102a IS NULL THEN 0 ELSE xccb102a END)),SUM((CASE WHEN xccb102b IS NULL THEN 0 ELSE xccb102b END)),",
                  "       SUM((CASE WHEN xccb102c IS NULL THEN 0 ELSE xccb102c END)),SUM((CASE WHEN xccb102d IS NULL THEN 0 ELSE xccb102d END)),",
                  "       SUM((CASE WHEN xccb102e IS NULL THEN 0 ELSE xccb102e END)),SUM((CASE WHEN xccb102f IS NULL THEN 0 ELSE xccb102f END)),",
                  "       SUM((CASE WHEN xccb102g IS NULL THEN 0 ELSE xccb102g END)),SUM((CASE WHEN xccb102h IS NULL THEN 0 ELSE xccb102h END)) ",
                  "  FROM xccb_t , sfaa_t  ",
                  " WHERE xccbent = '",g_enterprise,"' AND xccbld = '",g_master.xckkld,"' AND xccbcomp = '",g_master.xckkcomp,"' ",
                  "   AND xccb001 = '",g_master.xckk001,"' AND xccb003 = '",g_master.xckk002,"' ",
                  "   AND xccb004 = ? AND xccb005 = ? "
      IF p_xckk.xckk005 = '201' THEN #在制期初 
         LET l_sql = l_sql , " AND xccbent = sfaaent AND xccb006 = sfaadocno AND sfaa003 <> '3' " #非拆件工单      
      END IF
      IF p_xckk.xckk005 = '301' THEN  #拆件期初
         LET l_sql = l_sql , " AND xccbent = sfaaent AND xccb006 = sfaadocno AND sfaa003 = '3' " #拆件工单      
      END IF
      LET l_sql = l_sql , " GROUP BY (CASE WHEN xccb002 IS NULL THEN ' ' ELSE xccb002 END),",
                          "          (CASE WHEN xccb006 IS NULL THEN ' ' ELSE xccb006 END),",   
                          "          (CASE WHEN xccb007 IS NULL THEN ' ' ELSE xccb007 END),", #161031-00037#1 remark
                          "          (CASE WHEN xccb008 IS NULL THEN ' ' ELSE xccb008 END),", #161031-00037#1 remark
                          "          (CASE WHEN xccb009 IS NULL THEN ' ' ELSE xccb009 END) "  #161031-00037#1 remark
   ELSE
      IF p_xckk.xckk005 = '201' THEN #在制期初 
         #抓xcce的上期期末数量和金额
         LET l_sql = "SELECT (CASE WHEN xcce002 IS NULL THEN ' ' ELSE xcce002 END),",
                     "       (CASE WHEN xcce006 IS NULL THEN ' ' ELSE xcce006 END),",
                     "       (CASE WHEN xcce007 IS NULL THEN ' ' ELSE xcce007 END),",  #161031-00037#1 remark
                     "       (CASE WHEN xcce008 IS NULL THEN ' ' ELSE xcce008 END),",  #161031-00037#1 remark
                     "       (CASE WHEN xcce009 IS NULL THEN ' ' ELSE xcce009 END),",  #161031-00037#1 remark
                     "       SUM((CASE WHEN xcce901 IS NULL THEN 0 ELSE xcce901 END)),  SUM((CASE WHEN xcce902 IS NULL THEN 0 ELSE xcce902 END)),  ",
                     "       SUM((CASE WHEN xcce902a IS NULL THEN 0 ELSE xcce902a END)),SUM((CASE WHEN xcce902b IS NULL THEN 0 ELSE xcce902b END)),",
                     "       SUM((CASE WHEN xcce902c IS NULL THEN 0 ELSE xcce902c END)),SUM((CASE WHEN xcce902d IS NULL THEN 0 ELSE xcce902d END)),",
                     "       SUM((CASE WHEN xcce902e IS NULL THEN 0 ELSE xcce902e END)),SUM((CASE WHEN xcce902f IS NULL THEN 0 ELSE xcce902f END)),",
                     "       SUM((CASE WHEN xcce902g IS NULL THEN 0 ELSE xcce902g END)),SUM((CASE WHEN xcce902h IS NULL THEN 0 ELSE xcce902h END)) ",
                     " FROM xcce_t ",
                     " WHERE xcceent = '",g_enterprise,"' AND xcceld = '",g_master.xckkld,"' AND xccecomp = '",g_master.xckkcomp,"' ",
                     "   AND xcce001 = '",g_master.xckk001,"' AND xcce003 = '",g_master.xckk002,"' ",
                     "   AND xcce004 = ? AND xcce005 = ? ",
                     " GROUP BY (CASE WHEN xcce002 IS NULL THEN ' ' ELSE xcce002 END),",
                     "          (CASE WHEN xcce006 IS NULL THEN ' ' ELSE xcce006 END),",
                     "          (CASE WHEN xcce007 IS NULL THEN ' ' ELSE xcce007 END),",  #161031-00037#1 remark
                     "          (CASE WHEN xcce008 IS NULL THEN ' ' ELSE xcce008 END),",  #161031-00037#1 remark
                     "          (CASE WHEN xcce009 IS NULL THEN ' ' ELSE xcce009 END) "   #161031-00037#1 remark
                     
      END IF
      IF p_xckk.xckk005 = '301' THEN  #拆件期初
         #抓xcci的上期期末数量和金额
         LET l_sql = "SELECT (CASE WHEN xcci002 IS NULL THEN ' ' ELSE xcci002 END),",
                     "       (CASE WHEN xcci006 IS NULL THEN ' ' ELSE xcci006 END),",
                     "       (CASE WHEN xcci007 IS NULL THEN ' ' ELSE xcci007 END),",  #161031-00037#1 remark
                     "       (CASE WHEN xcci008 IS NULL THEN ' ' ELSE xcci008 END),",  #161031-00037#1 remark
                     "       (CASE WHEN xcci009 IS NULL THEN ' ' ELSE xcci009 END),",  #161031-00037#1 remark
                     "       SUM((CASE WHEN xcci901 IS NULL THEN 0 ELSE xcci901 END)),  SUM((CASE WHEN xcci902 IS NULL THEN 0 ELSE xcci902 END)),  ",
                     "       SUM((CASE WHEN xcci902a IS NULL THEN 0 ELSE xcci902a END)),SUM((CASE WHEN xcci902b IS NULL THEN 0 ELSE xcci902b END)),",
                     "       SUM((CASE WHEN xcci902c IS NULL THEN 0 ELSE xcci902c END)),SUM((CASE WHEN xcci902d IS NULL THEN 0 ELSE xcci902d END)),",
                     "       SUM((CASE WHEN xcci902e IS NULL THEN 0 ELSE xcci902e END)),SUM((CASE WHEN xcci902f IS NULL THEN 0 ELSE xcci902f END)),",
                     "       SUM((CASE WHEN xcci902g IS NULL THEN 0 ELSE xcci902g END)),SUM((CASE WHEN xcci902h IS NULL THEN 0 ELSE xcci902h END)) ",
                     " FROM xcci_t ",
                     " WHERE xccient = '",g_enterprise,"' AND xccild = '",g_master.xckkld,"' AND xccicomp = '",g_master.xckkcomp,"' ",
                     "   AND xcci001 = '",g_master.xckk001,"' AND xcci003 = '",g_master.xckk002,"' ",
                     "   AND xcci004 = ? AND xcci005 = ? ",
                     " GROUP BY (CASE WHEN xcci002 IS NULL THEN ' ' ELSE xcci002 END),",
                     "          (CASE WHEN xcci006 IS NULL THEN ' ' ELSE xcci006 END),",
                     "          (CASE WHEN xcci007 IS NULL THEN ' ' ELSE xcci007 END),",  #161031-00037#1 remark
                     "          (CASE WHEN xcci008 IS NULL THEN ' ' ELSE xcci008 END),",  #161031-00037#1 remark
                     "          (CASE WHEN xcci009 IS NULL THEN ' ' ELSE xcci009 END) "   #161031-00037#1 remark
                     
      END IF
   END IF      
   PREPARE axcq603_sel_xccb_pb1 FROM l_sql
   DECLARE axcq603_sel_xccb_cs1 CURSOR FOR axcq603_sel_xccb_pb1
   
   IF p_xckk.xckk005 = '201' THEN #在制期初 
      #根據工單單號+料件+特性+批號等抓取總表xcce中對應的數量、金額欄位
      LET l_sql = "SELECT SUM((CASE WHEN xcce101 IS NULL THEN 0 ELSE xcce101 END)),  SUM((CASE WHEN xcce102 IS NULL THEN 0 ELSE xcce102 END)),  ",
                  "       SUM((CASE WHEN xcce102a IS NULL THEN 0 ELSE xcce102a END)),SUM((CASE WHEN xcce102b IS NULL THEN 0 ELSE xcce102b END)),",
                  "       SUM((CASE WHEN xcce102c IS NULL THEN 0 ELSE xcce102c END)),SUM((CASE WHEN xcce102d IS NULL THEN 0 ELSE xcce102d END)),",
                  "       SUM((CASE WHEN xcce102e IS NULL THEN 0 ELSE xcce102e END)),SUM((CASE WHEN xcce102f IS NULL THEN 0 ELSE xcce102f END)),",
                  "       SUM((CASE WHEN xcce102g IS NULL THEN 0 ELSE xcce102g END)),SUM((CASE WHEN xcce102h IS NULL THEN 0 ELSE xcce102h END)) ",
                  "  FROM xcce_t  ",
                  " WHERE xcceent = '",g_enterprise,"' AND xcceld = '",g_master.xckkld,"' AND xccecomp = '",g_master.xckkcomp,"' ",
                  "   AND xcce001 = '",g_master.xckk001,"' AND xcce003 = '",g_master.xckk002,"' ", 
                  "   AND xcce004 = '",g_master.xckk003,"' AND xcce005 = '",g_master.xckk004,"' ",
                  "   AND (CASE WHEN xcce002 IS NULL THEN ' ' ELSE xcce002 END) = ? ",
                  "   AND (CASE WHEN xcce006 IS NULL THEN ' ' ELSE xcce006 END) = ? ",
                  "   AND (CASE WHEN xcce007 IS NULL THEN ' ' ELSE xcce007 END) = ? ",  #161031-00037#1 remark
                  "   AND (CASE WHEN xcce008 IS NULL THEN ' ' ELSE xcce008 END) = ? ",  #161031-00037#1 remark
                  "   AND (CASE WHEN xcce009 IS NULL THEN ' ' ELSE xcce009 END) = ? "   #161031-00037#1 remark
   END IF
   IF p_xckk.xckk005 = '301' THEN  #拆件期初
      #根據工單單號+料件+特性+批號等抓取總表xcci中對應的數量、金額欄位
      LET l_sql = "SELECT SUM((CASE WHEN xcci101 IS NULL THEN 0 ELSE xcci101 END)),  SUM((CASE WHEN xcci102 IS NULL THEN 0 ELSE xcci102 END)),  ",
                  "       SUM((CASE WHEN xcci102a IS NULL THEN 0 ELSE xcci102a END)),SUM((CASE WHEN xcci102b IS NULL THEN 0 ELSE xcci102b END)),",
                  "       SUM((CASE WHEN xcci102c IS NULL THEN 0 ELSE xcci102c END)),SUM((CASE WHEN xcci102d IS NULL THEN 0 ELSE xcci102d END)),",
                  "       SUM((CASE WHEN xcci102e IS NULL THEN 0 ELSE xcci102e END)),SUM((CASE WHEN xcci102f IS NULL THEN 0 ELSE xcci102f END)),",
                  "       SUM((CASE WHEN xcci102g IS NULL THEN 0 ELSE xcci102g END)),SUM((CASE WHEN xcci102h IS NULL THEN 0 ELSE xcci102h END)) ",
                  "  FROM xcci_t  ",
                  " WHERE xccient = '",g_enterprise,"' AND xccild = '",g_master.xckkld,"' AND xccicomp = '",g_master.xckkcomp,"' ",
                  "   AND xcci001 = '",g_master.xckk001,"' AND xcci003 = '",g_master.xckk002,"' ", 
                  "   AND xcci004 = '",g_master.xckk003,"' AND xcci005 = '",g_master.xckk004,"' ",
                  "   AND (CASE WHEN xcci002 IS NULL THEN ' ' ELSE xcci002 END) = ? ",
                  "   AND (CASE WHEN xcci006 IS NULL THEN ' ' ELSE xcci006 END) = ? ",
                  "   AND (CASE WHEN xcci007 IS NULL THEN ' ' ELSE xcci007 END) = ? ",  #161031-00037#1 remark
                  "   AND (CASE WHEN xcci008 IS NULL THEN ' ' ELSE xcci008 END) = ? ",  #161031-00037#1 remark
                  "   AND (CASE WHEN xcci009 IS NULL THEN ' ' ELSE xcci009 END) = ? "   #161031-00037#1 remark
   END IF
   PREPARE axcq603_sel_xcce_pb1 FROM l_sql
   DECLARE axcq603_sel_xcce_cs1 CURSOR FOR axcq603_sel_xcce_pb1
   
   LET l_xckk003 = g_previous_xckk003
   LET l_xckk004 = g_previous_xckk004
   
   #抓上一期別的明细资料
   #CASE p_xckk.xckk005   
   #   WHEN '215'         #在制开账调整 
   #      LET l_xckk003 = g_previous_xckk003
   #      LET l_xckk004 = g_previous_xckk004
   #   WHEN '201'         #在制期初
   #      LET l_xckk003 = g_previous_xckk003
   #      LET l_xckk004 = g_previous_xckk004
   #END CASE
   
   FOREACH axcq603_sel_xccb_cs1 USING l_xckk003,l_xckk004
                                INTO l_xckl.xckl010, l_xckl.xckl006, 
                                     l_xckl.xckl007, l_xckl.xckl008, l_xckl.xckl009,  #161031-00037#1 remark
                                     l_xckl.xckl103, l_xckl.xckl104, l_xckl.xckl104a,l_xckl.xckl104b,l_xckl.xckl104c,
                                     l_xckl.xckl104d,l_xckl.xckl104e,l_xckl.xckl104f,l_xckl.xckl104g,l_xckl.xckl104h   
                         
      EXECUTE axcq603_sel_xcce_cs1 USING l_xckl.xckl010,l_xckl.xckl006, 
                                         l_xckl.xckl007, l_xckl.xckl008, l_xckl.xckl009  #161031-00037#1 remark
                                   INTO l_xckl.xckl101, l_xckl.xckl102, l_xckl.xckl102a,l_xckl.xckl102b,l_xckl.xckl102c,
                                        l_xckl.xckl102d,l_xckl.xckl102e,l_xckl.xckl102f,l_xckl.xckl102g,l_xckl.xckl102h 
                                         
      #161109-00085#26-s mod            
#      IF NOT axcq603_ins_xckl(l_xckl.*) THEN   #161109-00085#26-s mark
      IF NOT axcq603_ins_xckl(l_xckl.xcklent,l_xckl.xcklcomp,l_xckl.xcklld,l_xckl.xckl001,l_xckl.xckl002,
                              l_xckl.xckl003,l_xckl.xckl004,l_xckl.xckl005,l_xckl.xckl006,l_xckl.xckl007,
                              l_xckl.xckl008,l_xckl.xckl009,l_xckl.xckl010,l_xckl.xckl090,l_xckl.xckl101,
                              l_xckl.xckl102,l_xckl.xckl102a,l_xckl.xckl102b,l_xckl.xckl102c,l_xckl.xckl102d,
                              l_xckl.xckl102e,l_xckl.xckl102f,l_xckl.xckl102g,l_xckl.xckl102h,l_xckl.xckl103,
                              l_xckl.xckl104,l_xckl.xckl104a,l_xckl.xckl104b,l_xckl.xckl104c,l_xckl.xckl104d,
                              l_xckl.xckl104e,l_xckl.xckl104f,l_xckl.xckl104g,l_xckl.xckl104h,l_xckl.xckl105,
                              l_xckl.xckl106,l_xckl.xckl106a,l_xckl.xckl106b,l_xckl.xckl106c,l_xckl.xckl106d,
                              l_xckl.xckl106e,l_xckl.xckl106f,l_xckl.xckl106g,l_xckl.xckl106h) THEN
      #161109-00085#26-e mod      
         LET r_success = FALSE
         RETURN r_success
      END IF
      
   END FOREACH                                          
   
   RETURN r_success
               
END FUNCTION

#总表抓xcce的非拆件工单的本期投入数量和金额（元件排除DL+OH+SUB），明细表抓xcck的非拆件工单工单发料数量和金额，并写入xckk（排除拆件且元件排除DL+OH+SUB，料件类别是原料）；
#有差异的按在制单号(工单)找出差异并写入xckl
PRIVATE FUNCTION axcq603_gen_xckl_5(p_xckk)
#161109-00085#26-s mod
#DEFINE p_xckk          RECORD LIKE xckk_t.*   #161109-00085#26-s mark
DEFINE p_xckk          RECORD  #成本勾稽表
       xckkent LIKE xckk_t.xckkent, #企業編號
       xckkcomp LIKE xckk_t.xckkcomp, #法人組織
       xckkld LIKE xckk_t.xckkld, #帳套
       xckk001 LIKE xckk_t.xckk001, #本位幣順序
       xckk002 LIKE xckk_t.xckk002, #成本計算類型
       xckk003 LIKE xckk_t.xckk003, #年度
       xckk004 LIKE xckk_t.xckk004, #期別
       xckk005 LIKE xckk_t.xckk005, #
       xckk090 LIKE xckk_t.xckk090, #明細程式編號
       xckk101 LIKE xckk_t.xckk101, #總報表數量
       xckk102 LIKE xckk_t.xckk102, #總報表金額
       xckk102a LIKE xckk_t.xckk102a, #材料
       xckk102b LIKE xckk_t.xckk102b, #人工
       xckk102c LIKE xckk_t.xckk102c, #加工
       xckk102d LIKE xckk_t.xckk102d, #制費一
       xckk102e LIKE xckk_t.xckk102e, #制費二
       xckk102f LIKE xckk_t.xckk102f, #制費三
       xckk102g LIKE xckk_t.xckk102g, #製費四
       xckk102h LIKE xckk_t.xckk102h, #制費五
       xckk103 LIKE xckk_t.xckk103, #分報表數量
       xckk104 LIKE xckk_t.xckk104, #分報表金額
       xckk104a LIKE xckk_t.xckk104a, #分報表材料
       xckk104b LIKE xckk_t.xckk104b, #分報表人工
       xckk104c LIKE xckk_t.xckk104c, #分報表加工
       xckk104d LIKE xckk_t.xckk104d, #分報表制費一
       xckk104e LIKE xckk_t.xckk104e, #分報表制費二
       xckk104f LIKE xckk_t.xckk104f, #分報表制費三
       xckk104g LIKE xckk_t.xckk104g, #分報表制費四
       xckk104h LIKE xckk_t.xckk104h, #分報表制費五
       xckk105 LIKE xckk_t.xckk105, #差異數量
       xckk106 LIKE xckk_t.xckk106, #差異金額
       xckk106a LIKE xckk_t.xckk106a, #差異金額-材料
       xckk106b LIKE xckk_t.xckk106b, #差異金額-人工
       xckk106c LIKE xckk_t.xckk106c, #差異金額-加工
       xckk106d LIKE xckk_t.xckk106d, #差異金額-制費一
       xckk106e LIKE xckk_t.xckk106e, #差異金額-制費二
       xckk106f LIKE xckk_t.xckk106f, #差異金額-制費三
       xckk106g LIKE xckk_t.xckk106g, #差異金額-制費四
       xckk106h LIKE xckk_t.xckk106h  #差異金額-制費五
                END RECORD
#161109-00085#26-e mod
DEFINE r_success    LIKE type_t.num5
#161109-00085#26-s mod
#DEFINE l_xckl       RECORD LIKE xckl_t.*   #161109-00085#26-s mark
DEFINE l_xckl       RECORD  #成本勾稽明細表
       xcklent LIKE xckl_t.xcklent, #企業編號
       xcklcomp LIKE xckl_t.xcklcomp, #法人組織
       xcklld LIKE xckl_t.xcklld, #帳套
       xckl001 LIKE xckl_t.xckl001, #本位幣順序
       xckl002 LIKE xckl_t.xckl002, #成本計算類型
       xckl003 LIKE xckl_t.xckl003, #年度
       xckl004 LIKE xckl_t.xckl004, #期別
       xckl005 LIKE xckl_t.xckl005, #
       xckl006 LIKE xckl_t.xckl006, #在製單據編號
       xckl007 LIKE xckl_t.xckl007, #料號
       xckl008 LIKE xckl_t.xckl008, #特徵
       xckl009 LIKE xckl_t.xckl009, #批號
       xckl010 LIKE xckl_t.xckl010, #成本域
       xckl090 LIKE xckl_t.xckl090, #明細程式編號
       xckl101 LIKE xckl_t.xckl101, #總報表數量
       xckl102 LIKE xckl_t.xckl102, #總報表金額
       xckl102a LIKE xckl_t.xckl102a, #材料
       xckl102b LIKE xckl_t.xckl102b, #人工
       xckl102c LIKE xckl_t.xckl102c, #加工
       xckl102d LIKE xckl_t.xckl102d, #制費一
       xckl102e LIKE xckl_t.xckl102e, #制費二
       xckl102f LIKE xckl_t.xckl102f, #制費三
       xckl102g LIKE xckl_t.xckl102g, #製費四
       xckl102h LIKE xckl_t.xckl102h, #制費五
       xckl103 LIKE xckl_t.xckl103, #分報表數量
       xckl104 LIKE xckl_t.xckl104, #分報表金額
       xckl104a LIKE xckl_t.xckl104a, #分報表材料
       xckl104b LIKE xckl_t.xckl104b, #分報表人工
       xckl104c LIKE xckl_t.xckl104c, #分報表加工
       xckl104d LIKE xckl_t.xckl104d, #分報表制費一
       xckl104e LIKE xckl_t.xckl104e, #分報表制費二
       xckl104f LIKE xckl_t.xckl104f, #分報表制費三
       xckl104g LIKE xckl_t.xckl104g, #分報表制費四
       xckl104h LIKE xckl_t.xckl104h, #分報表制費五
       xckl105 LIKE xckl_t.xckl105, #差異數量
       xckl106 LIKE xckl_t.xckl106, #差異金額
       xckl106a LIKE xckl_t.xckl106a, #差異金額-材料
       xckl106b LIKE xckl_t.xckl106b, #差異金額-人工
       xckl106c LIKE xckl_t.xckl106c, #差異金額-加工
       xckl106d LIKE xckl_t.xckl106d, #差異金額-制費一
       xckl106e LIKE xckl_t.xckl106e, #差異金額-制費二
       xckl106f LIKE xckl_t.xckl106f, #差異金額-制費三
       xckl106g LIKE xckl_t.xckl106g, #差異金額-制費四
       xckl106h LIKE xckl_t.xckl106h  #差異金額-制費五
          END RECORD
#161109-00085#26-e mod
DEFINE l_sql        STRING
DEFINE l_sql_1      STRING

   LET r_success = TRUE
   
   INITIALIZE l_xckl.* TO NULL
   
   LET l_xckl.xcklent = g_enterprise
   LET l_xckl.xcklcomp = g_master.xckkcomp
   LET l_xckl.xcklld = g_master.xckkld
   LET l_xckl.xckl001 = g_master.xckk001
   LET l_xckl.xckl002 = g_master.xckk002
   LET l_xckl.xckl003 = g_master.xckk003
   LET l_xckl.xckl004 = g_master.xckk004  
   LET l_xckl.xckl005 = p_xckk.xckk005
   
   LET l_xckl.xckl090 = p_xckk.xckk090
   
   LET l_xckl.xckl007 = ' '
   LET l_xckl.xckl008 = ' '
   LET l_xckl.xckl009 = ' '
   
   LET l_sql = ''
   CASE p_xckk.xckk005
      WHEN '216'   #原料投入
         #有差异的按在制单号(工单)找出差异并写入xckl
         #161031-00037#1---s
         #LET l_sql = "SELECT SUM(CASE imaa004 WHEN 'M' THEN xcce201+xcce205+xcce207+xcce209 ELSE 0 END),    SUM(CASE imaa004 WHEN 'M' THEN xcce202+xcce206+xcce208+xcce210 ELSE 0 END),    ",
         #            "       SUM(CASE imaa004 WHEN 'M' THEN xcce202a+xcce206a+xcce208a+xcce210a ELSE 0 END),SUM(CASE imaa004 WHEN 'M' THEN xcce202b+xcce206b+xcce208b+xcce210b ELSE 0 END),",
	      #            "       SUM(CASE imaa004 WHEN 'M' THEN xcce202c+xcce206c+xcce208c+xcce210c ELSE 0 END),SUM(CASE imaa004 WHEN 'M' THEN xcce202d+xcce206d+xcce208d+xcce210d ELSE 0 END),",
         #            "       SUM(CASE imaa004 WHEN 'M' THEN xcce202e+xcce206e+xcce208e+xcce210e ELSE 0 END),SUM(CASE imaa004 WHEN 'M' THEN xcce202f+xcce206f+xcce208f+xcce210f ELSE 0 END),",
	      #            "       SUM(CASE imaa004 WHEN 'M' THEN xcce202g+xcce206g+xcce208g+xcce210g ELSE 0 END),SUM(CASE imaa004 WHEN 'M' THEN xcce202h+xcce206h+xcce208h+xcce210h ELSE 0 END) "
         LET l_sql = "SELECT SUM(xcce201+xcce205+xcce207+xcce209),    SUM(xcce202+xcce206+xcce208+xcce210),    ",
                      "      SUM(xcce202a+xcce206a+xcce208a+xcce210a),SUM(xcce202b+xcce206b+xcce208b+xcce210b),",
	                   "      SUM(xcce202c+xcce206c+xcce208c+xcce210c),SUM(xcce202d+xcce206d+xcce208d+xcce210d),",
                      "      SUM(xcce202e+xcce206e+xcce208e+xcce210e),SUM(xcce202f+xcce206f+xcce208f+xcce210f),",
	                   "      SUM(xcce202g+xcce206g+xcce208g+xcce210g),SUM(xcce202h+xcce206h+xcce208h+xcce210h) "
         #161031-00037#1---e   	       
      WHEN '217'   #半成品投入
         #有差异的按在制单号(工单)找出差异并写入xckl
         LET l_sql = "SELECT SUM(CASE imaa004 WHEN 'A' THEN xcce201+xcce205+xcce207+xcce209 ELSE 0 END),    SUM(CASE imaa004 WHEN 'A' THEN xcce202+xcce206+xcce208+xcce210 ELSE 0 END),    ",
                     "       SUM(CASE imaa004 WHEN 'A' THEN xcce202a+xcce206a+xcce208a+xcce210a ELSE 0 END),SUM(CASE imaa004 WHEN 'A' THEN xcce202b+xcce206b+xcce208b+xcce210b ELSE 0 END),",
	                  "       SUM(CASE imaa004 WHEN 'A' THEN xcce202c+xcce206c+xcce208c+xcce210c ELSE 0 END),SUM(CASE imaa004 WHEN 'A' THEN xcce202d+xcce206d+xcce208d+xcce210d ELSE 0 END),",
                     "       SUM(CASE imaa004 WHEN 'A' THEN xcce202e+xcce206e+xcce208e+xcce210e ELSE 0 END),SUM(CASE imaa004 WHEN 'A' THEN xcce202f+xcce206f+xcce208f+xcce210f ELSE 0 END),",
	                  "       SUM(CASE imaa004 WHEN 'A' THEN xcce202g+xcce206g+xcce208g+xcce210g ELSE 0 END),SUM(CASE imaa004 WHEN 'A' THEN xcce202h+xcce206h+xcce208h+xcce210h ELSE 0 END) "

   END CASE
   
   LET l_sql = l_sql , "  FROM xcce_t,imaa_t  ",
                  " WHERE xcceent = '",g_enterprise,"' AND xcceld = '",g_master.xckkld,"' AND xccecomp = '",g_master.xckkcomp,"' ",
                  "   AND xcce001 = '",g_master.xckk001,"' AND xcce003 = '",g_master.xckk002,"' ", 
                  "   AND xcce004 = '",g_master.xckk003,"' AND xcce005 = '",g_master.xckk004,"' ",
                  "   AND xcceent = imaaent AND xcce007  = imaa001 AND xcce007 <> 'DL+OH+SUB' ",
                  "   AND (CASE WHEN xcce002 IS NULL THEN ' ' ELSE xcce002 END) = ? ",
                  "   AND (CASE WHEN xcce006 IS NULL THEN ' ' ELSE xcce006 END) = ? ",
                  "   AND (CASE WHEN xcce007 IS NULL THEN ' ' ELSE xcce007 END) = ? ",  #161031-00037#1 remark
                  "   AND (CASE WHEN xcce008 IS NULL THEN ' ' ELSE xcce008 END) = ? ",  #161031-00037#1 remark
                  "   AND (CASE WHEN xcce009 IS NULL THEN ' ' ELSE xcce009 END) = ? "   #161031-00037#1 remark
   
   #总表抓xcci的拆件工单的本期投入数量和金额（元件排除DL+OH+SUB），明细表抓xcck的拆件工单工单发料数量和金额，并写入xckk；有差异的按在制单号(工单)找出差异并写入xckl
   IF p_xckk.xckk005 = '302' THEN   #拆件投入   
      LET l_sql = " SELECT SUM((CASE WHEN xcci201 IS NULL THEN 0 ELSE xcci201 END)),  SUM((CASE WHEN xcci202 IS NULL THEN 0 ELSE xcci202 END)),  ",
                  "        SUM((CASE WHEN xcci202a IS NULL THEN 0 ELSE xcci202a END)),SUM((CASE WHEN xcci202b IS NULL THEN 0 ELSE xcci202b END)),",
                  "        SUM((CASE WHEN xcci202c IS NULL THEN 0 ELSE xcci202c END)),SUM((CASE WHEN xcci202d IS NULL THEN 0 ELSE xcci202d END)),",
                  "        SUM((CASE WHEN xcci202e IS NULL THEN 0 ELSE xcci202e END)),SUM((CASE WHEN xcci202f IS NULL THEN 0 ELSE xcci202f END)),",
                  "        SUM((CASE WHEN xcci202g IS NULL THEN 0 ELSE xcci202g END)),SUM((CASE WHEN xcci202h IS NULL THEN 0 ELSE xcci202h END)) ",
                  " FROM xcci_t ",
                  " WHERE xccient = '",g_enterprise,"' AND xccild = '",g_master.xckkld,"' AND xccicomp = '",g_master.xckkcomp,"' ",
                  "   AND xcci001 = '",g_master.xckk001,"' AND xcci003 = '",g_master.xckk002,"' ",
                  "   AND xcci004 = '",g_master.xckk003,"' AND xcci005 = '",g_master.xckk004,"' AND xcci007 <> 'DL+OH+SUB' ",
                  "   AND (CASE WHEN xcci002 IS NULL THEN ' ' ELSE xcci002 END) = ? ",
                  "   AND (CASE WHEN xcci006 IS NULL THEN ' ' ELSE xcci006 END) = ? ",
                  #161031-00037#1--s
                  "   AND (CASE WHEN xcci007 IS NULL THEN ' ' ELSE xcci007 END) = ? ", 
                  "   AND (CASE WHEN xcci008 IS NULL THEN ' ' ELSE xcci008 END) = ? ",  
                  "   AND (CASE WHEN xcci009 IS NULL THEN ' ' ELSE xcci009 END) = ? "
                  #161031-00037#1--e
   END IF
   
   PREPARE axcq603_sel_xcce_pb2 FROM l_sql
   DECLARE axcq603_sel_xcce_cs2 CURSOR FOR axcq603_sel_xcce_pb2
   
   #从明细表xcck抓资料
   #LET l_sql = "SELECT (CASE WHEN xcck002 IS NULL THEN ' ' ELSE xcck002 END),",
               #"       (CASE WHEN xcck006 IS NULL THEN ' ' ELSE xcck006 END),",
   LET l_sql = "SELECT SUM((CASE WHEN xcck201  IS NULL THEN 0 ELSE xcck201  END)* xcck009),SUM((CASE WHEN xcck202  IS NULL THEN 0 ELSE xcck202  END)*xcck009),", 
               "       SUM((CASE WHEN xcck202a IS NULL THEN 0 ELSE xcck202a END)* xcck009),SUM((CASE WHEN xcck202b IS NULL THEN 0 ELSE xcck202b END)*xcck009),",
               "       SUM((CASE WHEN xcck202c IS NULL THEN 0 ELSE xcck202c END)* xcck009),SUM((CASE WHEN xcck202d IS NULL THEN 0 ELSE xcck202d END)*xcck009),",
               "       SUM((CASE WHEN xcck202e IS NULL THEN 0 ELSE xcck202e END)* xcck009),SUM((CASE WHEN xcck202f IS NULL THEN 0 ELSE xcck202f END)*xcck009),",
               "       SUM((CASE WHEN xcck202g IS NULL THEN 0 ELSE xcck202g END)* xcck009),SUM((CASE WHEN xcck202h IS NULL THEN 0 ELSE xcck202h END)*xcck009) ",
               " FROM xcck_t , imaa_t  ",
               " WHERE xcckent = '",g_enterprise,"' AND xcckld = '",g_master.xckkld,"' AND xcckcomp = '",g_master.xckkcomp,"' ",
               "   AND xcck001 = '",g_master.xckk001,"' AND xcck003 = '",g_master.xckk002,"' ",
               "   AND xcck004 = '",g_master.xckk003,"' AND xcck005 = '",g_master.xckk004,"' ",
               "   AND xcckent = imaaent AND xcck010  = imaa001 AND xcck010 <> 'DL+OH+SUB' ",
               "   AND (CASE WHEN xcck002 IS NULL THEN ' ' ELSE xcck002 END) = ? ",
               #"   AND (CASE WHEN xcck006 IS NULL THEN ' ' ELSE xcck006 END) = ? ",  #161031-00037#1 mark
               " AND (CASE WHEN xcck047 IS NULL THEN ' ' ELSE xcck047 END) = ? ",     #161031-00037#1 add
               #161031-00037#1--s
               "   AND (CASE WHEN xcck010 IS NULL THEN ' ' ELSE xcck010 END) = ? ", 
               "   AND (CASE WHEN xcck011 IS NULL THEN ' ' ELSE xcck011 END) = ? ",  
               "   AND (CASE WHEN xcck017 IS NULL THEN ' ' ELSE xcck017 END) = ? "
               #161031-00037#1--e
   CASE p_xckk.xckk005
      WHEN '216'   #原料投入
         #元件排除DL+OH+SUB，料件类别是原料
         #LET l_sql = l_sql , " AND imaa004  = 'M' AND xcck055 = '301' AND xcck020 <> '113' "  #xcck里的工单发料，排除拆件  #160531-00032#1  
         #LET l_sql = l_sql , " AND imaa004  = 'M' AND xcck055 = '3012' AND xcck020 <> '113' "  #xcck里的工单发料，排除拆件  #160531-00032#1  #161031-00037#1
         LET l_sql = l_sql , " AND imaa004  <> 'A' AND xcck055 = '3012' AND xcck020 <> '113' "    #161031-00037#1       
      WHEN '217'   #半成品投入
         #元件排除DL+OH+SUB，料件类别是半成品
         #LET l_sql = l_sql , " AND imaa004  = 'A' AND xcck055 = '301' AND xcck020 <> '113' "  #xcck里的工单发料，排除拆件   #160531-00032#1
         LET l_sql = l_sql , " AND imaa004  = 'A' AND xcck055 = '3012' AND xcck020 <> '113' "  #xcck里的工单发料，排除拆件   #160531-00032#1
      WHEN '302'   #拆件投入
         #元件排除DL+OH+SUB
         #LET l_sql = l_sql , " AND xcck055 = '301' AND xcck020 = '113' "  #xcck里的工单发料，拆件  #160531-00032#1
#         LET l_sql = l_sql , " AND xcck055 = '3012' AND xcck020 = '113' "  #xcck里的工单发料，拆件  #160531-00032#1 #170210-00001#1 mark
         #170210-00001#1--add--start--
         LET l_sql = l_sql , " AND xcck055 = '207' AND xcck020 = '302' ",
                             " AND EXISTS (SELECT xcch006 FROM xcch_t ",
                             "              WHERE xcchent = xcckent and xcchcomp = xcckcomp and xcch001 = xcck001 ",
                             "                and xcch003 = xcck003 and xcch004 = xcck004 and xcch005 = xcck005 ",
                             "                and xcch006 = xcck047 )"
         #170210-00001#1--add--end----
   END CASE
   
   #LET l_sql = l_sql , " GROUP BY (CASE WHEN xcck002 IS NULL THEN ' ' ELSE xcck002 END),",
   #                    "          (CASE WHEN xcck006 IS NULL THEN ' ' ELSE xcck006 END)"
   
   PREPARE axcq603_sel_xcck_pb3 FROM l_sql
   DECLARE axcq603_sel_xcck_cs3 CURSOR FOR axcq603_sel_xcck_pb3
   
   #LET l_sql_1 = " SELECT DISTINCT a , b  FROM ( ",  #161031-00037#1
   LET l_sql_1 = " SELECT DISTINCT a , b , c , d , e FROM ( ",  #161031-00037#1
                 "          SELECT DISTINCT (CASE WHEN xcck002 IS NULL THEN ' ' ELSE xcck002 END) a,",
                 #"                          (CASE WHEN xcck006 IS NULL THEN ' ' ELSE xcck006 END) b, ",  #161031-00037#1 mark
                 "                           (CASE WHEN xcck047 IS NULL THEN ' ' ELSE xcck047 END) b, ",  #161031-00037#1 add
                 #161031-00037#1--s
                 "                          (CASE WHEN xcck010 IS NULL THEN ' ' ELSE xcck010 END) c, ", 
                 "                          (CASE WHEN xcck011 IS NULL THEN ' ' ELSE xcck011 END) d, ",  
                 "                          (CASE WHEN xcck017 IS NULL THEN ' ' ELSE xcck017 END) e ",
                 #161031-00037#1--e
                 "                 FROM xcck_t , imaa_t  ",
                 "       WHERE xcckent = '",g_enterprise,"' AND xcckld = '",g_master.xckkld,"' AND xcckcomp = '",g_master.xckkcomp,"' ",
                 "         AND xcck001 = '",g_master.xckk001,"' AND xcck003 = '",g_master.xckk002,"' ",
                 "         AND xcck004 = '",g_master.xckk003,"' AND xcck005 = '",g_master.xckk004,"' ",
                 "         AND xcckent = imaaent AND xcck010  = imaa001 AND xcck010 <> 'DL+OH+SUB' "
    CASE p_xckk.xckk005
      WHEN '216'   #原料投入
         #元件排除DL+OH+SUB，料件类别是原料
         #LET l_sql_1 = l_sql_1 , " AND imaa004  = 'M' AND xcck055 = '301' AND xcck020 <> '113' "  #xcck里的工单发料，排除拆件  #160531-00032#1   
         #LET l_sql_1 = l_sql_1 , " AND imaa004  = 'M' AND xcck055 = '3012' AND xcck020 <> '113' "  #xcck里的工单发料，排除拆件  #160531-00032#1 #161031-00037#1
         LET l_sql = l_sql , " AND imaa004  <> 'A' AND xcck055 = '3012' AND xcck020 <> '113' "    #161031-00037#1                  
      WHEN '217'   #半成品投入
         #元件排除DL+OH+SUB，料件类别是半成品
         #LET l_sql_1 = l_sql_1 , " AND imaa004  = 'A' AND xcck055 = '301' AND xcck020 <> '113' "  #xcck里的工单发料，排除拆件   #160531-00032#1 
         LET l_sql_1 = l_sql_1 , " AND imaa004  = 'A' AND xcck055 = '3012' AND xcck020 <> '113' "  #xcck里的工单发料，排除拆件   #160531-00032#1           
      WHEN '302'   #拆件投入
         #元件排除DL+OH+SUB
         #LET l_sql_1 = l_sql_1 , " AND xcck055 = '301' AND xcck020 = '113' "  #xcck里的工单发料，拆件  #160531-00032#1
         LET l_sql_1 = l_sql_1 , " AND xcck055 = '3012' AND xcck020 = '113' "  #xcck里的工单发料，拆件  #160531-00032#1
   END CASE             
   LET l_sql_1 = l_sql_1 , " UNION "
   IF p_xckk.xckk005 = '302' THEN   #拆件投入  
      LET l_sql_1 = l_sql_1 , "          SELECT DISTINCT (CASE WHEN xcci002 IS NULL THEN ' ' ELSE xcci002 END) a ,",
                              "                          (CASE WHEN xcci006 IS NULL THEN ' ' ELSE xcci006 END) b , ",
                              #161031-00037#1--s
                              "                          (CASE WHEN xcci007 IS NULL THEN ' ' ELSE xcci007 END) c, ", 
                              "                          (CASE WHEN xcci008 IS NULL THEN ' ' ELSE xcci008 END) d, ",  
                              "                          (CASE WHEN xcci009 IS NULL THEN ' ' ELSE xcci009 END) e ",
                              #161031-00037#1--e
                              "            FROM xcci_t ",
                              "            WHERE xccient = '",g_enterprise,"' AND xccild = '",g_master.xckkld,"' AND xccicomp = '",g_master.xckkcomp,"' ",
                              "              AND xcci001 = '",g_master.xckk001,"' AND xcci003 = '",g_master.xckk002,"' ",
                              "              AND xcci004 = '",g_master.xckk003,"' AND xcci005 = '",g_master.xckk004,"' AND xcci007 <> 'DL+OH+SUB' "
   ELSE
      LET l_sql_1 = l_sql_1 , "          SELECT DISTINCT (CASE WHEN xcce002 IS NULL THEN ' ' ELSE xcce002 END) a ,",
                              "                          (CASE WHEN xcce006 IS NULL THEN ' ' ELSE xcce006 END) b ,",
                              #161031-00037#1--s
                              "                          (CASE WHEN xcce007 IS NULL THEN ' ' ELSE xcce007 END) c, ", 
                              "                          (CASE WHEN xcce008 IS NULL THEN ' ' ELSE xcce008 END) d, ",  
                              "                          (CASE WHEN xcce009 IS NULL THEN ' ' ELSE xcce009 END) e ",
                              #161031-00037#1--e
                              "            FROM xcce_t,imaa_t  ",
                              "            WHERE xcceent = '",g_enterprise,"' AND xcceld = '",g_master.xckkld,"' AND xccecomp = '",g_master.xckkcomp,"' ",
                              "              AND xcce001 = '",g_master.xckk001,"' AND xcce003 = '",g_master.xckk002,"' ", 
                              "              AND xcce004 = '",g_master.xckk003,"' AND xcce005 = '",g_master.xckk004,"' ",
                              "              AND xcceent = imaaent AND xcce007  = imaa001 AND xcce007 <> 'DL+OH+SUB' "
   END IF
   LET l_sql_1 = l_sql_1 , " ) "
   PREPARE axcq603_sel_xcck006_pb1 FROM l_sql_1
   DECLARE axcq603_sel_xcck006_cs1 CURSOR FOR axcq603_sel_xcck006_pb1
   
   FOREACH axcq603_sel_xcck006_cs1 INTO l_xckl.xckl010, l_xckl.xckl006,
                                        l_xckl.xckl007,l_xckl.xckl008,l_xckl.xckl009  #161031-00037#1
   #FOREACH axcq603_sel_xcck_cs3 INTO l_xckl.xckl010, l_xckl.xckl006, 
   #                                  l_xckl.xckl103, l_xckl.xckl104, l_xckl.xckl104a,l_xckl.xckl104b,l_xckl.xckl104c,
   #                                  l_xckl.xckl104d,l_xckl.xckl104e,l_xckl.xckl104f,l_xckl.xckl104g,l_xckl.xckl104h   
                         
      IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xcck_t"
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      EXECUTE axcq603_sel_xcck_cs3 USING l_xckl.xckl010,l_xckl.xckl006,
                                         l_xckl.xckl007,l_xckl.xckl008,l_xckl.xckl009  #161031-00037#1
                                   INTO l_xckl.xckl103, l_xckl.xckl104, l_xckl.xckl104a,l_xckl.xckl104b,l_xckl.xckl104c,
                                        l_xckl.xckl104d,l_xckl.xckl104e,l_xckl.xckl104f,l_xckl.xckl104g,l_xckl.xckl104h
     
      #161031-00037#1-S add by lixh 
      LET l_xckl.xckl103 = l_xckl.xckl103 * (-1)
      LET l_xckl.xckl104 = l_xckl.xckl104 * (-1)
      #161031-00037#1-E add by lixh
      
      EXECUTE axcq603_sel_xcce_cs2 USING l_xckl.xckl010,l_xckl.xckl006,
                                         l_xckl.xckl007,l_xckl.xckl008,l_xckl.xckl009  #161031-00037#1
                                   INTO l_xckl.xckl101, l_xckl.xckl102, l_xckl.xckl102a,l_xckl.xckl102b,l_xckl.xckl102c,
                                        l_xckl.xckl102d,l_xckl.xckl102e,l_xckl.xckl102f,l_xckl.xckl102g,l_xckl.xckl102h 
                                        
      IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xccc_t"
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      #161109-00085#26-s mod            
#      IF NOT axcq603_ins_xckl(l_xckl.*) THEN   #161109-00085#26-s mark
      IF NOT axcq603_ins_xckl(l_xckl.xcklent,l_xckl.xcklcomp,l_xckl.xcklld,l_xckl.xckl001,l_xckl.xckl002,
                              l_xckl.xckl003,l_xckl.xckl004,l_xckl.xckl005,l_xckl.xckl006,l_xckl.xckl007,
                              l_xckl.xckl008,l_xckl.xckl009,l_xckl.xckl010,l_xckl.xckl090,l_xckl.xckl101,
                              l_xckl.xckl102,l_xckl.xckl102a,l_xckl.xckl102b,l_xckl.xckl102c,l_xckl.xckl102d,
                              l_xckl.xckl102e,l_xckl.xckl102f,l_xckl.xckl102g,l_xckl.xckl102h,l_xckl.xckl103,
                              l_xckl.xckl104,l_xckl.xckl104a,l_xckl.xckl104b,l_xckl.xckl104c,l_xckl.xckl104d,
                              l_xckl.xckl104e,l_xckl.xckl104f,l_xckl.xckl104g,l_xckl.xckl104h,l_xckl.xckl105,
                              l_xckl.xckl106,l_xckl.xckl106a,l_xckl.xckl106b,l_xckl.xckl106c,l_xckl.xckl106d,
                              l_xckl.xckl106e,l_xckl.xckl106f,l_xckl.xckl106g,l_xckl.xckl106h) THEN
      #161109-00085#26-e mod      
         LET r_success = FALSE
         RETURN r_success
      END IF
      
   END FOREACH                                          
   
   RETURN r_success
   
END FUNCTION

#总表抓xcce的非拆件工单的本期元件=ADJUST投入的金额，明细表抓xccp的非拆件工单的金额，并写入xckk；有差异的按在制单号(工单)找出差异并写入xckl
PRIVATE FUNCTION axcq603_gen_xckl_6(p_xckk)
#161109-00085#26-s mod
#DEFINE p_xckk          RECORD LIKE xckk_t.*   #161109-00085#26-s mark
DEFINE p_xckk          RECORD  #成本勾稽表
       xckkent LIKE xckk_t.xckkent, #企業編號
       xckkcomp LIKE xckk_t.xckkcomp, #法人組織
       xckkld LIKE xckk_t.xckkld, #帳套
       xckk001 LIKE xckk_t.xckk001, #本位幣順序
       xckk002 LIKE xckk_t.xckk002, #成本計算類型
       xckk003 LIKE xckk_t.xckk003, #年度
       xckk004 LIKE xckk_t.xckk004, #期別
       xckk005 LIKE xckk_t.xckk005, #
       xckk090 LIKE xckk_t.xckk090, #明細程式編號
       xckk101 LIKE xckk_t.xckk101, #總報表數量
       xckk102 LIKE xckk_t.xckk102, #總報表金額
       xckk102a LIKE xckk_t.xckk102a, #材料
       xckk102b LIKE xckk_t.xckk102b, #人工
       xckk102c LIKE xckk_t.xckk102c, #加工
       xckk102d LIKE xckk_t.xckk102d, #制費一
       xckk102e LIKE xckk_t.xckk102e, #制費二
       xckk102f LIKE xckk_t.xckk102f, #制費三
       xckk102g LIKE xckk_t.xckk102g, #製費四
       xckk102h LIKE xckk_t.xckk102h, #制費五
       xckk103 LIKE xckk_t.xckk103, #分報表數量
       xckk104 LIKE xckk_t.xckk104, #分報表金額
       xckk104a LIKE xckk_t.xckk104a, #分報表材料
       xckk104b LIKE xckk_t.xckk104b, #分報表人工
       xckk104c LIKE xckk_t.xckk104c, #分報表加工
       xckk104d LIKE xckk_t.xckk104d, #分報表制費一
       xckk104e LIKE xckk_t.xckk104e, #分報表制費二
       xckk104f LIKE xckk_t.xckk104f, #分報表制費三
       xckk104g LIKE xckk_t.xckk104g, #分報表制費四
       xckk104h LIKE xckk_t.xckk104h, #分報表制費五
       xckk105 LIKE xckk_t.xckk105, #差異數量
       xckk106 LIKE xckk_t.xckk106, #差異金額
       xckk106a LIKE xckk_t.xckk106a, #差異金額-材料
       xckk106b LIKE xckk_t.xckk106b, #差異金額-人工
       xckk106c LIKE xckk_t.xckk106c, #差異金額-加工
       xckk106d LIKE xckk_t.xckk106d, #差異金額-制費一
       xckk106e LIKE xckk_t.xckk106e, #差異金額-制費二
       xckk106f LIKE xckk_t.xckk106f, #差異金額-制費三
       xckk106g LIKE xckk_t.xckk106g, #差異金額-制費四
       xckk106h LIKE xckk_t.xckk106h  #差異金額-制費五
                END RECORD
#161109-00085#26-e mod
DEFINE r_success    LIKE type_t.num5
#161109-00085#26-s mod
#DEFINE l_xckl       RECORD LIKE xckl_t.*   #161109-00085#26-s mark
DEFINE l_xckl       RECORD  #成本勾稽明細表
       xcklent LIKE xckl_t.xcklent, #企業編號
       xcklcomp LIKE xckl_t.xcklcomp, #法人組織
       xcklld LIKE xckl_t.xcklld, #帳套
       xckl001 LIKE xckl_t.xckl001, #本位幣順序
       xckl002 LIKE xckl_t.xckl002, #成本計算類型
       xckl003 LIKE xckl_t.xckl003, #年度
       xckl004 LIKE xckl_t.xckl004, #期別
       xckl005 LIKE xckl_t.xckl005, #
       xckl006 LIKE xckl_t.xckl006, #在製單據編號
       xckl007 LIKE xckl_t.xckl007, #料號
       xckl008 LIKE xckl_t.xckl008, #特徵
       xckl009 LIKE xckl_t.xckl009, #批號
       xckl010 LIKE xckl_t.xckl010, #成本域
       xckl090 LIKE xckl_t.xckl090, #明細程式編號
       xckl101 LIKE xckl_t.xckl101, #總報表數量
       xckl102 LIKE xckl_t.xckl102, #總報表金額
       xckl102a LIKE xckl_t.xckl102a, #材料
       xckl102b LIKE xckl_t.xckl102b, #人工
       xckl102c LIKE xckl_t.xckl102c, #加工
       xckl102d LIKE xckl_t.xckl102d, #制費一
       xckl102e LIKE xckl_t.xckl102e, #制費二
       xckl102f LIKE xckl_t.xckl102f, #制費三
       xckl102g LIKE xckl_t.xckl102g, #製費四
       xckl102h LIKE xckl_t.xckl102h, #制費五
       xckl103 LIKE xckl_t.xckl103, #分報表數量
       xckl104 LIKE xckl_t.xckl104, #分報表金額
       xckl104a LIKE xckl_t.xckl104a, #分報表材料
       xckl104b LIKE xckl_t.xckl104b, #分報表人工
       xckl104c LIKE xckl_t.xckl104c, #分報表加工
       xckl104d LIKE xckl_t.xckl104d, #分報表制費一
       xckl104e LIKE xckl_t.xckl104e, #分報表制費二
       xckl104f LIKE xckl_t.xckl104f, #分報表制費三
       xckl104g LIKE xckl_t.xckl104g, #分報表制費四
       xckl104h LIKE xckl_t.xckl104h, #分報表制費五
       xckl105 LIKE xckl_t.xckl105, #差異數量
       xckl106 LIKE xckl_t.xckl106, #差異金額
       xckl106a LIKE xckl_t.xckl106a, #差異金額-材料
       xckl106b LIKE xckl_t.xckl106b, #差異金額-人工
       xckl106c LIKE xckl_t.xckl106c, #差異金額-加工
       xckl106d LIKE xckl_t.xckl106d, #差異金額-制費一
       xckl106e LIKE xckl_t.xckl106e, #差異金額-制費二
       xckl106f LIKE xckl_t.xckl106f, #差異金額-制費三
       xckl106g LIKE xckl_t.xckl106g, #差異金額-制費四
       xckl106h LIKE xckl_t.xckl106h  #差異金額-制費五
          END RECORD
#161109-00085#26-e mod
DEFINE l_sql        STRING
DEFINE l_sql_1      STRING

   LET r_success = TRUE
   
   INITIALIZE l_xckl.* TO NULL
   
   LET l_xckl.xcklent = g_enterprise
   LET l_xckl.xcklcomp = g_master.xckkcomp
   LET l_xckl.xcklld = g_master.xckkld
   LET l_xckl.xckl001 = g_master.xckk001
   LET l_xckl.xckl002 = g_master.xckk002
   LET l_xckl.xckl003 = g_master.xckk003
   LET l_xckl.xckl004 = g_master.xckk004  
   LET l_xckl.xckl005 = p_xckk.xckk005
   
   LET l_xckl.xckl090 = p_xckk.xckk090
   
   LET l_xckl.xckl007 = ' '
   LET l_xckl.xckl008 = ' '
   LET l_xckl.xckl009 = ' '
   
   LET l_sql = ''
   LET l_sql = "SELECT SUM(CASE xcce007 WHEN 'ADJUST' THEN xcce201 ELSE 0 END),SUM(CASE xcce007 WHEN 'ADJUST' THEN xcce202 ELSE 0 END),  ",
               "       SUM(CASE xcce007 WHEN 'ADJUST' THEN xcce202a ELSE 0 END),SUM(CASE xcce007 WHEN 'ADJUST' THEN xcce202b ELSE 0 END),",
               "       SUM(CASE xcce007 WHEN 'ADJUST' THEN xcce202c ELSE 0 END),SUM(CASE xcce007 WHEN 'ADJUST' THEN xcce202d ELSE 0 END),",
               "       SUM(CASE xcce007 WHEN 'ADJUST' THEN xcce202e ELSE 0 END),SUM(CASE xcce007 WHEN 'ADJUST' THEN xcce202f ELSE 0 END),",
               "       SUM(CASE xcce007 WHEN 'ADJUST' THEN xcce202g ELSE 0 END),SUM(CASE xcce007 WHEN 'ADJUST' THEN xcce202h ELSE 0 END) ",
               " FROM xcce_t",
               " WHERE xcceent = '",g_enterprise,"' AND xcceld = '",g_master.xckkld,"' AND xccecomp = '",g_master.xckkcomp,"' ",
               "   AND xcce001 = '",g_master.xckk001,"' AND xcce003 = '",g_master.xckk002,"' ", 
               "   AND xcce004 = '",g_master.xckk003,"' AND xcce005 = '",g_master.xckk004,"' ",
               "   AND (CASE WHEN xcce002 IS NULL THEN ' ' ELSE xcce002 END) = ? ",
               #161031-00037#1--s
               #"   AND (CASE WHEN xcce007 IS NULL THEN ' ' ELSE xcce007 END) = ? ",
               "   AND (CASE WHEN xcce006 IS NULL THEN ' ' ELSE xcce006 END) = ? ",
               "   AND (CASE WHEN xcce007 IS NULL THEN ' ' ELSE xcce007 END) = ? ", 
               "   AND (CASE WHEN xcce008 IS NULL THEN ' ' ELSE xcce008 END) = ? ",  
               "   AND (CASE WHEN xcce009 IS NULL THEN ' ' ELSE xcce009 END) = ? "
               #161031-00037#1--e

   PREPARE axcq603_sel_xcce_pb3 FROM l_sql
   DECLARE axcq603_sel_xcce_cs3 CURSOR FOR axcq603_sel_xcce_pb3
   
   #从明细表xcck抓资料
   #LET l_sql = "SELECT (CASE WHEN xccp002 IS NULL THEN ' ' ELSE xccp002 END),",
   #            "       (CASE WHEN xccp007 IS NULL THEN ' ' ELSE xccp007 END) ",
   LET l_sql = "SELECT SUM((CASE WHEN xccp101 IS NULL THEN 0 ELSE xccp101 END)),  SUM((CASE WHEN xccp102 IS NULL THEN 0 ELSE xccp102 END)),  ",
               "       SUM((CASE WHEN xccp102a IS NULL THEN 0 ELSE xccp102a END)),SUM((CASE WHEN xccp102b IS NULL THEN 0 ELSE xccp102b END)),",
               "       SUM((CASE WHEN xccp102c IS NULL THEN 0 ELSE xccp102c END)),SUM((CASE WHEN xccp102d IS NULL THEN 0 ELSE xccp102d END)),",
               "       SUM((CASE WHEN xccp102e IS NULL THEN 0 ELSE xccp102e END)),SUM((CASE WHEN xccp102f IS NULL THEN 0 ELSE xccp102f END)),",
               "       SUM((CASE WHEN xccp102g IS NULL THEN 0 ELSE xccp102g END)),SUM((CASE WHEN xccp102h IS NULL THEN 0 ELSE xccp102h END)) ",
               "  FROM xccp_t,sfaa_t ",
               "  WHERE xccpent = '",g_enterprise,"' AND xccpld = '",g_master.xckkld,"' AND xccpcomp = '",g_master.xckkcomp,"' ",
               "    AND xccp001 = '",g_master.xckk001,"' AND xccp003 = '",g_master.xckk002,"' ", 
               "    AND xccp004 = '",g_master.xckk003,"' AND xccp005 = '",g_master.xckk004,"' ",
               "    AND xccpent = sfaaent AND xccp007 = sfaadocno AND sfaa003 <> '3' ", #非拆件工单
               "    AND (CASE WHEN xccp002 IS NULL THEN ' ' ELSE xccp002 END) = ? ",
               "    AND (CASE WHEN xccp007 IS NULL THEN ' ' ELSE xccp007 END) = ? "
               #" GROUP BY (CASE WHEN xccp002 IS NULL THEN ' ' ELSE xccp002 END),",
               #"          (CASE WHEN xccp007 IS NULL THEN ' ' ELSE xccp007 END) "
   
   PREPARE axcq603_sel_xccp_pb1 FROM l_sql
   DECLARE axcq603_sel_xccp_cs1 CURSOR FOR axcq603_sel_xccp_pb1
   
   #LET l_sql_1 = " SELECT DISTINCT a , b  FROM ( ",  #161031-00037#1
   LET l_sql_1 = " SELECT DISTINCT a , b , c , d , e FROM ( ",  #161031-00037#1
                 "          SELECT DISTINCT (CASE WHEN xccp002 IS NULL THEN ' ' ELSE xccp002 END) a, ",
                 "                          (CASE WHEN xccp007 IS NULL THEN ' ' ELSE xccp007 END) b, ",
                 #161031-00037#1--s
                 "                          (CASE WHEN sfaa010 IS NULL THEN ' ' ELSE sfaa010 END) c, ", 
                 "                          ' ' d, ",  
                 "                          ' ' e ",
                 #161031-00037#1--e
                 "           FROM xccp_t,sfaa_t ",
                 "           WHERE xccpent = '",g_enterprise,"' AND xccpld = '",g_master.xckkld,"' AND xccpcomp = '",g_master.xckkcomp,"' ",
                 "             AND xccp001 = '",g_master.xckk001,"' AND xccp003 = '",g_master.xckk002,"' ", 
                 "             AND xccp004 = '",g_master.xckk003,"' AND xccp005 = '",g_master.xckk004,"' ",
                 "             AND xccpent = sfaaent AND xccp007 = sfaadocno AND sfaa003 <> '3' " #非拆件工单
   LET l_sql_1 = l_sql_1 , " UNION "
   lET l_sql_1 = l_sql_1 , "  SELECT DISTINCT (CASE WHEN xcce002 IS NULL THEN ' ' ELSE xcce002 END) a, ",
                           #161031-00037#1--s
                           #"                  (CASE WHEN xcce007 IS NULL THEN ' ' ELSE xcce007 END) b ,",
                           "                  (CASE WHEN xcce006 IS NULL THEN ' ' ELSE xcce006 END) b ,",
                           "                  (CASE WHEN xcce007 IS NULL THEN ' ' ELSE xcce007 END) c, ", 
                           "                  (CASE WHEN xcce008 IS NULL THEN ' ' ELSE xcce008 END) d, ",  
                           "                  (CASE WHEN xcce009 IS NULL THEN ' ' ELSE xcce009 END) e ",
                           #161031-00037#1--e
                           "     FROM xcce_t",
                           "     WHERE xcceent = '",g_enterprise,"' AND xcceld = '",g_master.xckkld,"' AND xccecomp = '",g_master.xckkcomp,"' ",
                           "       AND xcce001 = '",g_master.xckk001,"' AND xcce003 = '",g_master.xckk002,"' ", 
                           "       AND xcce004 = '",g_master.xckk003,"' AND xcce005 = '",g_master.xckk004,"' ",
                           "       AND xcce007 = 'ADJUST' "
   LET l_sql_1 = l_sql_1 , " ) "
   PREPARE axcq603_sel_xccp002_pb1 FROM l_sql_1
   DECLARE axcq603_sel_xccp002_cs1 CURSOR FOR axcq603_sel_xccp002_pb1
   FOREACH axcq603_sel_xccp002_cs1 INTO l_xckl.xckl010, l_xckl.xckl006,
                                        l_xckl.xckl007,l_xckl.xckl008,l_xckl.xckl009   #161031-00037#1 
   
   #FOREACH axcq603_sel_xccp_cs1 INTO l_xckl.xckl010, l_xckl.xckl006, 
   #                                  l_xckl.xckl103, l_xckl.xckl104, l_xckl.xckl104a,l_xckl.xckl104b,l_xckl.xckl104c,
   #                                  l_xckl.xckl104d,l_xckl.xckl104e,l_xckl.xckl104f,l_xckl.xckl104g,l_xckl.xckl104h   
                         
      IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xccp_t"
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      EXECUTE axcq603_sel_xccp_cs1 USING l_xckl.xckl010,l_xckl.xckl006
                                   INTO l_xckl.xckl103, l_xckl.xckl104, l_xckl.xckl104a,l_xckl.xckl104b,l_xckl.xckl104c,
                                        l_xckl.xckl104d,l_xckl.xckl104e,l_xckl.xckl104f,l_xckl.xckl104g,l_xckl.xckl104h 
      EXECUTE axcq603_sel_xcce_cs3 USING l_xckl.xckl010,l_xckl.xckl006,
                                         l_xckl.xckl007,l_xckl.xckl008,l_xckl.xckl009   #161031-00037#1 
                                   INTO l_xckl.xckl101, l_xckl.xckl102, l_xckl.xckl102a,l_xckl.xckl102b,l_xckl.xckl102c,
                                        l_xckl.xckl102d,l_xckl.xckl102e,l_xckl.xckl102f,l_xckl.xckl102g,l_xckl.xckl102h 
                                        
      IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xcce_t"
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
       
      #161109-00085#26-s mod            
#      IF NOT axcq603_ins_xckl(l_xckl.*) THEN   #161109-00085#26-s mark
      IF NOT axcq603_ins_xckl(l_xckl.xcklent,l_xckl.xcklcomp,l_xckl.xcklld,l_xckl.xckl001,l_xckl.xckl002,
                              l_xckl.xckl003,l_xckl.xckl004,l_xckl.xckl005,l_xckl.xckl006,l_xckl.xckl007,
                              l_xckl.xckl008,l_xckl.xckl009,l_xckl.xckl010,l_xckl.xckl090,l_xckl.xckl101,
                              l_xckl.xckl102,l_xckl.xckl102a,l_xckl.xckl102b,l_xckl.xckl102c,l_xckl.xckl102d,
                              l_xckl.xckl102e,l_xckl.xckl102f,l_xckl.xckl102g,l_xckl.xckl102h,l_xckl.xckl103,
                              l_xckl.xckl104,l_xckl.xckl104a,l_xckl.xckl104b,l_xckl.xckl104c,l_xckl.xckl104d,
                              l_xckl.xckl104e,l_xckl.xckl104f,l_xckl.xckl104g,l_xckl.xckl104h,l_xckl.xckl105,
                              l_xckl.xckl106,l_xckl.xckl106a,l_xckl.xckl106b,l_xckl.xckl106c,l_xckl.xckl106d,
                              l_xckl.xckl106e,l_xckl.xckl106f,l_xckl.xckl106g,l_xckl.xckl106h) THEN
      #161109-00085#26-e mod      
         LET r_success = FALSE
         RETURN r_success
      END IF
      
   END FOREACH                                          
   
   RETURN r_success
   
END FUNCTION

#在制转出、拆件拆出按逻辑写入xckl
PRIVATE FUNCTION axcq603_gen_xckl_7(p_xckk)
#161109-00085#26-s mod
#DEFINE p_xckk          RECORD LIKE xckk_t.*   #161109-00085#26-s mark
DEFINE p_xckk          RECORD  #成本勾稽表
       xckkent LIKE xckk_t.xckkent, #企業編號
       xckkcomp LIKE xckk_t.xckkcomp, #法人組織
       xckkld LIKE xckk_t.xckkld, #帳套
       xckk001 LIKE xckk_t.xckk001, #本位幣順序
       xckk002 LIKE xckk_t.xckk002, #成本計算類型
       xckk003 LIKE xckk_t.xckk003, #年度
       xckk004 LIKE xckk_t.xckk004, #期別
       xckk005 LIKE xckk_t.xckk005, #
       xckk090 LIKE xckk_t.xckk090, #明細程式編號
       xckk101 LIKE xckk_t.xckk101, #總報表數量
       xckk102 LIKE xckk_t.xckk102, #總報表金額
       xckk102a LIKE xckk_t.xckk102a, #材料
       xckk102b LIKE xckk_t.xckk102b, #人工
       xckk102c LIKE xckk_t.xckk102c, #加工
       xckk102d LIKE xckk_t.xckk102d, #制費一
       xckk102e LIKE xckk_t.xckk102e, #制費二
       xckk102f LIKE xckk_t.xckk102f, #制費三
       xckk102g LIKE xckk_t.xckk102g, #製費四
       xckk102h LIKE xckk_t.xckk102h, #制費五
       xckk103 LIKE xckk_t.xckk103, #分報表數量
       xckk104 LIKE xckk_t.xckk104, #分報表金額
       xckk104a LIKE xckk_t.xckk104a, #分報表材料
       xckk104b LIKE xckk_t.xckk104b, #分報表人工
       xckk104c LIKE xckk_t.xckk104c, #分報表加工
       xckk104d LIKE xckk_t.xckk104d, #分報表制費一
       xckk104e LIKE xckk_t.xckk104e, #分報表制費二
       xckk104f LIKE xckk_t.xckk104f, #分報表制費三
       xckk104g LIKE xckk_t.xckk104g, #分報表制費四
       xckk104h LIKE xckk_t.xckk104h, #分報表制費五
       xckk105 LIKE xckk_t.xckk105, #差異數量
       xckk106 LIKE xckk_t.xckk106, #差異金額
       xckk106a LIKE xckk_t.xckk106a, #差異金額-材料
       xckk106b LIKE xckk_t.xckk106b, #差異金額-人工
       xckk106c LIKE xckk_t.xckk106c, #差異金額-加工
       xckk106d LIKE xckk_t.xckk106d, #差異金額-制費一
       xckk106e LIKE xckk_t.xckk106e, #差異金額-制費二
       xckk106f LIKE xckk_t.xckk106f, #差異金額-制費三
       xckk106g LIKE xckk_t.xckk106g, #差異金額-制費四
       xckk106h LIKE xckk_t.xckk106h  #差異金額-制費五
                END RECORD
#161109-00085#26-e mod
DEFINE r_success    LIKE type_t.num5
#161109-00085#26-s mod
#DEFINE l_xckl       RECORD LIKE xckl_t.*   #161109-00085#26-s mark
DEFINE l_xckl       RECORD  #成本勾稽明細表
       xcklent LIKE xckl_t.xcklent, #企業編號
       xcklcomp LIKE xckl_t.xcklcomp, #法人組織
       xcklld LIKE xckl_t.xcklld, #帳套
       xckl001 LIKE xckl_t.xckl001, #本位幣順序
       xckl002 LIKE xckl_t.xckl002, #成本計算類型
       xckl003 LIKE xckl_t.xckl003, #年度
       xckl004 LIKE xckl_t.xckl004, #期別
       xckl005 LIKE xckl_t.xckl005, #
       xckl006 LIKE xckl_t.xckl006, #在製單據編號
       xckl007 LIKE xckl_t.xckl007, #料號
       xckl008 LIKE xckl_t.xckl008, #特徵
       xckl009 LIKE xckl_t.xckl009, #批號
       xckl010 LIKE xckl_t.xckl010, #成本域
       xckl090 LIKE xckl_t.xckl090, #明細程式編號
       xckl101 LIKE xckl_t.xckl101, #總報表數量
       xckl102 LIKE xckl_t.xckl102, #總報表金額
       xckl102a LIKE xckl_t.xckl102a, #材料
       xckl102b LIKE xckl_t.xckl102b, #人工
       xckl102c LIKE xckl_t.xckl102c, #加工
       xckl102d LIKE xckl_t.xckl102d, #制費一
       xckl102e LIKE xckl_t.xckl102e, #制費二
       xckl102f LIKE xckl_t.xckl102f, #制費三
       xckl102g LIKE xckl_t.xckl102g, #製費四
       xckl102h LIKE xckl_t.xckl102h, #制費五
       xckl103 LIKE xckl_t.xckl103, #分報表數量
       xckl104 LIKE xckl_t.xckl104, #分報表金額
       xckl104a LIKE xckl_t.xckl104a, #分報表材料
       xckl104b LIKE xckl_t.xckl104b, #分報表人工
       xckl104c LIKE xckl_t.xckl104c, #分報表加工
       xckl104d LIKE xckl_t.xckl104d, #分報表制費一
       xckl104e LIKE xckl_t.xckl104e, #分報表制費二
       xckl104f LIKE xckl_t.xckl104f, #分報表制費三
       xckl104g LIKE xckl_t.xckl104g, #分報表制費四
       xckl104h LIKE xckl_t.xckl104h, #分報表制費五
       xckl105 LIKE xckl_t.xckl105, #差異數量
       xckl106 LIKE xckl_t.xckl106, #差異金額
       xckl106a LIKE xckl_t.xckl106a, #差異金額-材料
       xckl106b LIKE xckl_t.xckl106b, #差異金額-人工
       xckl106c LIKE xckl_t.xckl106c, #差異金額-加工
       xckl106d LIKE xckl_t.xckl106d, #差異金額-制費一
       xckl106e LIKE xckl_t.xckl106e, #差異金額-制費二
       xckl106f LIKE xckl_t.xckl106f, #差異金額-制費三
       xckl106g LIKE xckl_t.xckl106g, #差異金額-制費四
       xckl106h LIKE xckl_t.xckl106h  #差異金額-制費五
          END RECORD
#161109-00085#26-e mod
DEFINE l_sql        STRING
DEFINE l_sql_1      STRING

   LET r_success = TRUE
   
   INITIALIZE l_xckl.* TO NULL
   
   LET l_xckl.xcklent = g_enterprise
   LET l_xckl.xcklcomp = g_master.xckkcomp
   LET l_xckl.xcklld = g_master.xckkld
   LET l_xckl.xckl001 = g_master.xckk001
   LET l_xckl.xckl002 = g_master.xckk002
   LET l_xckl.xckl003 = g_master.xckk003
   LET l_xckl.xckl004 = g_master.xckk004  
   LET l_xckl.xckl005 = p_xckk.xckk005
   
   LET l_xckl.xckl090 = p_xckk.xckk090
   
   LET l_xckl.xckl007 = ' '
   LET l_xckl.xckl008 = ' '
   LET l_xckl.xckl009 = ' '
   
   LET l_sql = ''
   CASE p_xckk.xckk005
      WHEN '211'   #在制转出
         #160707-00034#1---s
         #总表抓xcce的非拆件工单的本期转出数量和金额
         #LET l_sql = "SELECT SUM((CASE WHEN xcce301 IS NULL THEN 0 ELSE xcce301 END)),  SUM((CASE WHEN xcce302 IS NULL THEN 0 ELSE xcce302 END)),  ",
         #            "       SUM((CASE WHEN xcce302a IS NULL THEN 0 ELSE xcce302a END)),SUM((CASE WHEN xcce302b IS NULL THEN 0 ELSE xcce302b END)),",
         #            "       SUM((CASE WHEN xcce302c IS NULL THEN 0 ELSE xcce302c END)),SUM((CASE WHEN xcce302d IS NULL THEN 0 ELSE xcce302d END)),",
         #            "       SUM((CASE WHEN xcce302e IS NULL THEN 0 ELSE xcce302e END)),SUM((CASE WHEN xcce302f IS NULL THEN 0 ELSE xcce302f END)),",
         #            "       SUM((CASE WHEN xcce302g IS NULL THEN 0 ELSE xcce302g END)),SUM((CASE WHEN xcce302h IS NULL THEN 0 ELSE xcce302h END)) ",
         #            "  FROM xcce_t  ",
         #            " WHERE xcceent = '",g_enterprise,"' AND xcceld = '",g_master.xckkld,"' AND xccecomp = '",g_master.xckkcomp,"' ",
         #            "   AND xcce001 = '",g_master.xckk001,"' AND xcce003 = '",g_master.xckk002,"' ", 
         #            "   AND xcce004 = '",g_master.xckk003,"' AND xcce005 = '",g_master.xckk004,"' ",
         #            "   AND (CASE WHEN xcce002 IS NULL THEN ' ' ELSE xcce002 END) = ? ",
         #            "   AND (CASE WHEN xcce006 IS NULL THEN ' ' ELSE xcce006 END) = ? " 
         #总表改抓xccd，抓主件的数量
         LET l_sql = "SELECT SUM((CASE WHEN xccd301 IS NULL THEN 0 ELSE xccd301 END)),  SUM((CASE WHEN xccd302 IS NULL THEN 0 ELSE xccd302 END)),  ",
                     "       SUM((CASE WHEN xccd302a IS NULL THEN 0 ELSE xccd302a END)),SUM((CASE WHEN xccd302b IS NULL THEN 0 ELSE xccd302b END)),",
                     "       SUM((CASE WHEN xccd302c IS NULL THEN 0 ELSE xccd302c END)),SUM((CASE WHEN xccd302d IS NULL THEN 0 ELSE xccd302d END)),",
                     "       SUM((CASE WHEN xccd302e IS NULL THEN 0 ELSE xccd302e END)),SUM((CASE WHEN xccd302f IS NULL THEN 0 ELSE xccd302f END)),",
                     "       SUM((CASE WHEN xccd302g IS NULL THEN 0 ELSE xccd302g END)),SUM((CASE WHEN xccd302h IS NULL THEN 0 ELSE xccd302h END)) ",
                     "  FROM xccd_t  ",
                     " WHERE xccdent = '",g_enterprise,"' AND xccdld = '",g_master.xckkld,"' AND xccdcomp = '",g_master.xckkcomp,"' ",
                     "   AND xccd001 = '",g_master.xckk001,"' AND xccd003 = '",g_master.xckk002,"' ", 
                     "   AND xccd004 = '",g_master.xckk003,"' AND xccd005 = '",g_master.xckk004,"' ",
                     "   AND (CASE WHEN xccd002 IS NULL THEN ' ' ELSE xccd002 END) = ? ",
                     "   AND (CASE WHEN xccd006 IS NULL THEN ' ' ELSE xccd006 END) = ? ",
                     #161031-00037#1--s
                     "   AND (CASE WHEN xccd007 IS NULL THEN ' ' ELSE xccd007 END) = ? ", 
                     "   AND (CASE WHEN xccd008 IS NULL THEN ' ' ELSE xccd008 END) = ? ",  
                     "   AND (CASE WHEN xccd009 IS NULL THEN ' ' ELSE xccd009 END) = ? "
                     #161031-00037#1--e                     
         #160707-00034#1---e
      WHEN '303'  #拆件拆出 
         #总表抓xcci的拆件工单的本期转出数量和金额
         LET l_sql = " SELECT SUM((CASE WHEN xcci301 IS NULL THEN 0 ELSE xcci301 END)),  SUM((CASE WHEN xcci302 IS NULL THEN 0 ELSE xcci302 END)),  ",
                     "        SUM((CASE WHEN xcci302a IS NULL THEN 0 ELSE xcci302a END)),SUM((CASE WHEN xcci302b IS NULL THEN 0 ELSE xcci302b END)),",
                     "        SUM((CASE WHEN xcci302c IS NULL THEN 0 ELSE xcci302c END)),SUM((CASE WHEN xcci302d IS NULL THEN 0 ELSE xcci302d END)),",
                     "        SUM((CASE WHEN xcci302e IS NULL THEN 0 ELSE xcci302e END)),SUM((CASE WHEN xcci302f IS NULL THEN 0 ELSE xcci302f END)),",
                     "        SUM((CASE WHEN xcci302g IS NULL THEN 0 ELSE xcci302g END)),SUM((CASE WHEN xcci302h IS NULL THEN 0 ELSE xcci302h END)) ",
                     " FROM xcci_t ",
                     " WHERE xccient = '",g_enterprise,"' AND xccild = '",g_master.xckkld,"' AND xccicomp = '",g_master.xckkcomp,"' ",
                     "   AND xcci001 = '",g_master.xckk001,"' AND xcci003 = '",g_master.xckk002,"' ",
                     "   AND xcci004 = '",g_master.xckk003,"' AND xcci005 = '",g_master.xckk004,"' ",
                     "   AND (CASE WHEN xcci002 IS NULL THEN ' ' ELSE xcci002 END) = ? ",
                     "   AND (CASE WHEN xcci006 IS NULL THEN ' ' ELSE xcci006 END) = ? ",
                     #161031-00037#1--s
                     "   AND (CASE WHEN xcci007 IS NULL THEN ' ' ELSE xcci007 END) = ? ", 
                     "   AND (CASE WHEN xcci008 IS NULL THEN ' ' ELSE xcci008 END) = ? ",  
                     "   AND (CASE WHEN xcci009 IS NULL THEN ' ' ELSE xcci009 END) = ? "
                     #161031-00037#1--e
   END CASE                
   PREPARE axcq603_sel_xcce_pb4 FROM l_sql
   DECLARE axcq603_sel_xcce_cs4 CURSOR FOR axcq603_sel_xcce_pb4
   
   #从明细表xcck抓资料
   #LET l_sql = "SELECT (CASE WHEN xcck002 IS NULL THEN ' ' ELSE xcck002 END),",
   #            "       (CASE WHEN xcck006 IS NULL THEN ' ' ELSE xcck006 END),",
   LET l_sql = "SELECT SUM((CASE WHEN xcck201  IS NULL THEN 0 ELSE xcck201  END)* xcck009),SUM((CASE WHEN xcck202  IS NULL THEN 0 ELSE xcck202  END)*xcck009),", 
               "       SUM((CASE WHEN xcck202a IS NULL THEN 0 ELSE xcck202a END)* xcck009),SUM((CASE WHEN xcck202b IS NULL THEN 0 ELSE xcck202b END)*xcck009),",
               "       SUM((CASE WHEN xcck202c IS NULL THEN 0 ELSE xcck202c END)* xcck009),SUM((CASE WHEN xcck202d IS NULL THEN 0 ELSE xcck202d END)*xcck009),",
               "       SUM((CASE WHEN xcck202e IS NULL THEN 0 ELSE xcck202e END)* xcck009),SUM((CASE WHEN xcck202f IS NULL THEN 0 ELSE xcck202f END)*xcck009),",
               "       SUM((CASE WHEN xcck202g IS NULL THEN 0 ELSE xcck202g END)* xcck009),SUM((CASE WHEN xcck202h IS NULL THEN 0 ELSE xcck202h END)*xcck009) ",
               " FROM xcck_t , sfaa_t  ",  #160531-00032#1   #161031-00037#1 remark
               #" FROM xcck_t , sfaa_t ,sfec_t  ",  #160531-00032#1   #161031-00037#1 mark
               " WHERE xcckent = '",g_enterprise,"' AND xcckld = '",g_master.xckkld,"' AND xcckcomp = '",g_master.xckkcomp,"' ",
               "   AND xcck001 = '",g_master.xckk001,"' AND xcck003 = '",g_master.xckk002,"' ",
               "   AND xcck004 = '",g_master.xckk003,"' AND xcck005 = '",g_master.xckk004,"' ",
               #"   AND xcckent = sfaaent AND xcck006  = sfaadocno "  #160531-00032#1
               #"   AND xcckent = sfecent AND xcck006  = sfecdocno " , #160531-00032#1   #161031-00037#1  mark
               #"   AND sfecent = sfaaent AND sfec001  = sfaadocno "   #160531-00032#1    #161031-00037#1 mark
               "   AND xcckent = sfaaent AND xcck047  = sfaadocno "  #161031-00037#1 add
   CASE p_xckk.xckk005
      WHEN '211'   #在制转出
         LET l_sql = l_sql , " AND sfaa003 <> '3' AND xcck055 = '205' "  #xcck里的工单入库，排除拆件        
      WHEN '303'   #拆件拆出 
         LET l_sql = l_sql , " AND sfaa003 = '3' AND xcck055 = '205' "  ##xcck里的工单入库，拆件 
   END CASE
   
   LET l_sql = l_sql , " AND (CASE WHEN xcck002 IS NULL THEN ' ' ELSE xcck002 END) = ?",
                       #" AND (CASE WHEN xcck006 IS NULL THEN ' ' ELSE xcck006 END) = ? ", #161031-00037#1 mark
                       " AND (CASE WHEN xcck047 IS NULL THEN ' ' ELSE xcck047 END) = ? ",  #161031-00037#1 add
                       #161031-00037#1--s
                       "   AND (CASE WHEN xcck010 IS NULL THEN ' ' ELSE xcck010 END) = ? ", 
                       "   AND (CASE WHEN xcck011 IS NULL THEN ' ' ELSE xcck011 END) = ? ",  
                       "   AND (CASE WHEN xcck017 IS NULL THEN ' ' ELSE xcck017 END) = ? "
                       #161031-00037#1--e
   
   #LET l_sql = l_sql , " GROUP BY (CASE WHEN xcck002 IS NULL THEN ' ' ELSE xcck002 END),",
   #                    "          (CASE WHEN xcck006 IS NULL THEN ' ' ELSE xcck006 END)"
   
   PREPARE axcq603_sel_xcck_pb4 FROM l_sql
   DECLARE axcq603_sel_xcck_cs4 CURSOR FOR axcq603_sel_xcck_pb4
   
   #LET l_sql_1 = " SELECT DISTINCT a , b  FROM ( ",  #161031-00037#1
   LET l_sql_1 = " SELECT DISTINCT a , b , c , d , e FROM ( ",  #161031-00037#1
                 "          SELECT DISTINCT (CASE WHEN xcck002 IS NULL THEN ' ' ELSE xcck002 END) a ,",
                 #"                          (CASE WHEN xcck006 IS NULL THEN ' ' ELSE xcck006 END) b ,", #161031-00037#1 mark
                 "                           (CASE WHEN xcck047 IS NULL THEN ' ' ELSE xcck047 END) b, ",  #161031-00037#1 add
                 #161031-00037#1--s
                 "                          (CASE WHEN xcck010 IS NULL THEN ' ' ELSE xcck010 END) c , ", 
                 "                          (CASE WHEN xcck011 IS NULL THEN ' ' ELSE xcck011 END) d , ",  
                 "                          (CASE WHEN xcck017 IS NULL THEN ' ' ELSE xcck017 END) e ",
                 #161031-00037#1--e
                 "          FROM xcck_t , sfaa_t  ",  #160531-00032#1   #161031-00037#1 remark
                 #"           FROM xcck_t , sfaa_t ,sfec_t  ",  #160531-00032#1  #161031-00037#1 mark
                 "          WHERE xcckent = '",g_enterprise,"' AND xcckld = '",g_master.xckkld,"' AND xcckcomp = '",g_master.xckkcomp,"' ",
                 "            AND xcck001 = '",g_master.xckk001,"' AND xcck003 = '",g_master.xckk002,"' ",
                 "            AND xcck004 = '",g_master.xckk003,"' AND xcck005 = '",g_master.xckk004,"' ",
                 #"            AND xcckent = sfaaent AND xcck006  = sfaadocno "  #160531-00032#1
                 #"            AND xcckent = sfecent AND xcck006  = sfecdocno " , #160531-00032#1  #161031-00037#1 mark
                 #"            AND sfecent = sfaaent AND sfec001  = sfaadocno "   #160531-00032#1  #161031-00037#1 mark
                 "            AND xcckent = sfaaent AND xcck047  = sfaadocno "    #161031-00037#1
    CASE p_xckk.xckk005
      WHEN '211'   #在制转出
         LET l_sql_1 = l_sql_1 , " AND sfaa003 <> '3' AND xcck055 = '205' "  #xcck里的工单入库，排除拆件        
      WHEN '303'   #拆件拆出 
         LET l_sql_1 = l_sql_1 , " AND sfaa003 = '3' AND xcck055 = '205' "  ##xcck里的工单入库，拆件 
   END CASE      
   LET l_sql_1 = l_sql_1 , " UNION "
   IF p_xckk.xckk005 = '303' THEN  #拆件拆出 
      LET l_sql_1 = l_sql_1 , "   SELECT DISTINCT (CASE WHEN xcci002 IS NULL THEN ' ' ELSE xcci002 END) a ,",
                              "                   (CASE WHEN xcci006 IS NULL THEN ' ' ELSE xcci006 END) b ,",
                              #161031-00037#1--s
                              "                   (CASE WHEN xcci007 IS NULL THEN ' ' ELSE xcci007 END) c , ", 
                              "                   (CASE WHEN xcci008 IS NULL THEN ' ' ELSE xcci008 END) d , ",  
                              "                   (CASE WHEN xcci009 IS NULL THEN ' ' ELSE xcci009 END) e ",
                              #161031-00037#1--e
                              "  FROM xcci_t ",
                              " WHERE xccient = '",g_enterprise,"' AND xccild = '",g_master.xckkld,"' AND xccicomp = '",g_master.xckkcomp,"' ",
                              "   AND xcci001 = '",g_master.xckk001,"' AND xcci003 = '",g_master.xckk002,"' ",
                              "   AND xcci004 = '",g_master.xckk003,"' AND xcci005 = '",g_master.xckk004,"' "
   ELSE
      LET l_sql_1 = l_sql_1 , "   SELECT DISTINCT (CASE WHEN xcce002 IS NULL THEN ' ' ELSE xcce002 END) a ,",
                              "                   (CASE WHEN xcce006 IS NULL THEN ' ' ELSE xcce006 END) b ,",
                              #161031-00037#1--s
                              "                   (CASE WHEN xcce007 IS NULL THEN ' ' ELSE xcce007 END) c , ", 
                              "                   (CASE WHEN xcce008 IS NULL THEN ' ' ELSE xcce008 END) d , ",  
                              "                   (CASE WHEN xcce009 IS NULL THEN ' ' ELSE xcce009 END) e ",
                              #161031-00037#1--e
                              "  FROM xcce_t  ",
                              " WHERE xcceent = '",g_enterprise,"' AND xcceld = '",g_master.xckkld,"' AND xccecomp = '",g_master.xckkcomp,"' ",
                              "   AND xcce001 = '",g_master.xckk001,"' AND xcce003 = '",g_master.xckk002,"' ", 
                              "   AND xcce004 = '",g_master.xckk003,"' AND xcce005 = '",g_master.xckk004,"' "
   END IF

   LET l_sql_1 = l_sql_1 , " ) "
   PREPARE axcq603_sel_xcci006_pb1 FROM l_sql_1
   DECLARE axcq603_sel_xcci006_cs1 CURSOR FOR axcq603_sel_xcci006_pb1
   FOREACH axcq603_sel_xcci006_cs1 INTO l_xckl.xckl010, l_xckl.xckl006,
                                        l_xckl.xckl007,l_xckl.xckl008,l_xckl.xckl009  #161031-00037#1
   #FOREACH axcq603_sel_xcck_cs4 INTO l_xckl.xckl010, l_xckl.xckl006, 
   #                                  l_xckl.xckl103, l_xckl.xckl104, l_xckl.xckl104a,l_xckl.xckl104b,l_xckl.xckl104c,
   #                                  l_xckl.xckl104d,l_xckl.xckl104e,l_xckl.xckl104f,l_xckl.xckl104g,l_xckl.xckl104h   
                         
      IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xcck_t"
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      EXECUTE axcq603_sel_xcck_cs4 USING l_xckl.xckl010,l_xckl.xckl006,
                                         l_xckl.xckl007,l_xckl.xckl008,l_xckl.xckl009  #161031-00037#1
                                   INTO l_xckl.xckl103, l_xckl.xckl104, l_xckl.xckl104a,l_xckl.xckl104b,l_xckl.xckl104c,
                                        l_xckl.xckl104d,l_xckl.xckl104e,l_xckl.xckl104f,l_xckl.xckl104g,l_xckl.xckl104h  
      
      EXECUTE axcq603_sel_xcce_cs4 USING l_xckl.xckl010,l_xckl.xckl006,
                                         l_xckl.xckl007,l_xckl.xckl008,l_xckl.xckl009  #161031-00037#1
                                   INTO l_xckl.xckl101, l_xckl.xckl102, l_xckl.xckl102a,l_xckl.xckl102b,l_xckl.xckl102c,
                                        l_xckl.xckl102d,l_xckl.xckl102e,l_xckl.xckl102f,l_xckl.xckl102g,l_xckl.xckl102h 
                                        
      IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xcce_t"
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      
      #161031-00037#1---s 
      IF p_xckk.xckk005 = '211' THEN  #在制转出
         LET l_xckl.xckl103 = l_xckl.xckl101 * (-1)  #在製轉出，明細的數量，直接給總表的數量*(-1),因为明细表抓出来的值是负数  
      END IF
      #161031-00037#1---e
      
      
      #161109-00085#26-s mod            
#      IF NOT axcq603_ins_xckl(l_xckl.*) THEN   #161109-00085#26-s mark
      IF NOT axcq603_ins_xckl(l_xckl.xcklent,l_xckl.xcklcomp,l_xckl.xcklld,l_xckl.xckl001,l_xckl.xckl002,
                              l_xckl.xckl003,l_xckl.xckl004,l_xckl.xckl005,l_xckl.xckl006,l_xckl.xckl007,
                              l_xckl.xckl008,l_xckl.xckl009,l_xckl.xckl010,l_xckl.xckl090,l_xckl.xckl101,
                              l_xckl.xckl102,l_xckl.xckl102a,l_xckl.xckl102b,l_xckl.xckl102c,l_xckl.xckl102d,
                              l_xckl.xckl102e,l_xckl.xckl102f,l_xckl.xckl102g,l_xckl.xckl102h,l_xckl.xckl103,
                              l_xckl.xckl104,l_xckl.xckl104a,l_xckl.xckl104b,l_xckl.xckl104c,l_xckl.xckl104d,
                              l_xckl.xckl104e,l_xckl.xckl104f,l_xckl.xckl104g,l_xckl.xckl104h,l_xckl.xckl105,
                              l_xckl.xckl106,l_xckl.xckl106a,l_xckl.xckl106b,l_xckl.xckl106c,l_xckl.xckl106d,
                              l_xckl.xckl106e,l_xckl.xckl106f,l_xckl.xckl106g,l_xckl.xckl106h) THEN
      #161109-00085#26-e mod      
         LET r_success = FALSE
         RETURN r_success
      END IF
      
   END FOREACH                                          
   
   RETURN r_success
   
END FUNCTION

##在制人工费、拆件人工费写入xckl
PRIVATE FUNCTION axcq603_gen_xckl_8(p_xckk)
#161109-00085#26-s mod
#DEFINE p_xckk          RECORD LIKE xckk_t.*   #161109-00085#26-s mark
DEFINE p_xckk          RECORD  #成本勾稽表
       xckkent LIKE xckk_t.xckkent, #企業編號
       xckkcomp LIKE xckk_t.xckkcomp, #法人組織
       xckkld LIKE xckk_t.xckkld, #帳套
       xckk001 LIKE xckk_t.xckk001, #本位幣順序
       xckk002 LIKE xckk_t.xckk002, #成本計算類型
       xckk003 LIKE xckk_t.xckk003, #年度
       xckk004 LIKE xckk_t.xckk004, #期別
       xckk005 LIKE xckk_t.xckk005, #
       xckk090 LIKE xckk_t.xckk090, #明細程式編號
       xckk101 LIKE xckk_t.xckk101, #總報表數量
       xckk102 LIKE xckk_t.xckk102, #總報表金額
       xckk102a LIKE xckk_t.xckk102a, #材料
       xckk102b LIKE xckk_t.xckk102b, #人工
       xckk102c LIKE xckk_t.xckk102c, #加工
       xckk102d LIKE xckk_t.xckk102d, #制費一
       xckk102e LIKE xckk_t.xckk102e, #制費二
       xckk102f LIKE xckk_t.xckk102f, #制費三
       xckk102g LIKE xckk_t.xckk102g, #製費四
       xckk102h LIKE xckk_t.xckk102h, #制費五
       xckk103 LIKE xckk_t.xckk103, #分報表數量
       xckk104 LIKE xckk_t.xckk104, #分報表金額
       xckk104a LIKE xckk_t.xckk104a, #分報表材料
       xckk104b LIKE xckk_t.xckk104b, #分報表人工
       xckk104c LIKE xckk_t.xckk104c, #分報表加工
       xckk104d LIKE xckk_t.xckk104d, #分報表制費一
       xckk104e LIKE xckk_t.xckk104e, #分報表制費二
       xckk104f LIKE xckk_t.xckk104f, #分報表制費三
       xckk104g LIKE xckk_t.xckk104g, #分報表制費四
       xckk104h LIKE xckk_t.xckk104h, #分報表制費五
       xckk105 LIKE xckk_t.xckk105, #差異數量
       xckk106 LIKE xckk_t.xckk106, #差異金額
       xckk106a LIKE xckk_t.xckk106a, #差異金額-材料
       xckk106b LIKE xckk_t.xckk106b, #差異金額-人工
       xckk106c LIKE xckk_t.xckk106c, #差異金額-加工
       xckk106d LIKE xckk_t.xckk106d, #差異金額-制費一
       xckk106e LIKE xckk_t.xckk106e, #差異金額-制費二
       xckk106f LIKE xckk_t.xckk106f, #差異金額-制費三
       xckk106g LIKE xckk_t.xckk106g, #差異金額-制費四
       xckk106h LIKE xckk_t.xckk106h  #差異金額-制費五
                END RECORD
#161109-00085#26-e mod
DEFINE r_success    LIKE type_t.num5
#161109-00085#26-s mod
#DEFINE l_xckl       RECORD LIKE xckl_t.*   #161109-00085#26-s mark
DEFINE l_xckl       RECORD  #成本勾稽明細表
       xcklent LIKE xckl_t.xcklent, #企業編號
       xcklcomp LIKE xckl_t.xcklcomp, #法人組織
       xcklld LIKE xckl_t.xcklld, #帳套
       xckl001 LIKE xckl_t.xckl001, #本位幣順序
       xckl002 LIKE xckl_t.xckl002, #成本計算類型
       xckl003 LIKE xckl_t.xckl003, #年度
       xckl004 LIKE xckl_t.xckl004, #期別
       xckl005 LIKE xckl_t.xckl005, #
       xckl006 LIKE xckl_t.xckl006, #在製單據編號
       xckl007 LIKE xckl_t.xckl007, #料號
       xckl008 LIKE xckl_t.xckl008, #特徵
       xckl009 LIKE xckl_t.xckl009, #批號
       xckl010 LIKE xckl_t.xckl010, #成本域
       xckl090 LIKE xckl_t.xckl090, #明細程式編號
       xckl101 LIKE xckl_t.xckl101, #總報表數量
       xckl102 LIKE xckl_t.xckl102, #總報表金額
       xckl102a LIKE xckl_t.xckl102a, #材料
       xckl102b LIKE xckl_t.xckl102b, #人工
       xckl102c LIKE xckl_t.xckl102c, #加工
       xckl102d LIKE xckl_t.xckl102d, #制費一
       xckl102e LIKE xckl_t.xckl102e, #制費二
       xckl102f LIKE xckl_t.xckl102f, #制費三
       xckl102g LIKE xckl_t.xckl102g, #製費四
       xckl102h LIKE xckl_t.xckl102h, #制費五
       xckl103 LIKE xckl_t.xckl103, #分報表數量
       xckl104 LIKE xckl_t.xckl104, #分報表金額
       xckl104a LIKE xckl_t.xckl104a, #分報表材料
       xckl104b LIKE xckl_t.xckl104b, #分報表人工
       xckl104c LIKE xckl_t.xckl104c, #分報表加工
       xckl104d LIKE xckl_t.xckl104d, #分報表制費一
       xckl104e LIKE xckl_t.xckl104e, #分報表制費二
       xckl104f LIKE xckl_t.xckl104f, #分報表制費三
       xckl104g LIKE xckl_t.xckl104g, #分報表制費四
       xckl104h LIKE xckl_t.xckl104h, #分報表制費五
       xckl105 LIKE xckl_t.xckl105, #差異數量
       xckl106 LIKE xckl_t.xckl106, #差異金額
       xckl106a LIKE xckl_t.xckl106a, #差異金額-材料
       xckl106b LIKE xckl_t.xckl106b, #差異金額-人工
       xckl106c LIKE xckl_t.xckl106c, #差異金額-加工
       xckl106d LIKE xckl_t.xckl106d, #差異金額-制費一
       xckl106e LIKE xckl_t.xckl106e, #差異金額-制費二
       xckl106f LIKE xckl_t.xckl106f, #差異金額-制費三
       xckl106g LIKE xckl_t.xckl106g, #差異金額-制費四
       xckl106h LIKE xckl_t.xckl106h  #差異金額-制費五
          END RECORD
#161109-00085#26-e mod
DEFINE l_sql        STRING
DEFINE l_xcbk005    LIKE xcbk_t.xcbk005

   LET r_success = TRUE
   
   INITIALIZE l_xckl.* TO NULL
   
   LET l_xckl.xcklent = g_enterprise
   LET l_xckl.xcklcomp = g_master.xckkcomp
   LET l_xckl.xcklld = g_master.xckkld
   LET l_xckl.xckl001 = g_master.xckk001
   LET l_xckl.xckl002 = g_master.xckk002
   LET l_xckl.xckl003 = g_master.xckk003
   LET l_xckl.xckl004 = g_master.xckk004  
   LET l_xckl.xckl005 = p_xckk.xckk005
   
   LET l_xckl.xckl090 = p_xckk.xckk090
   
   LET l_xckl.xckl007 = ' '
   LET l_xckl.xckl008 = ' '
   LET l_xckl.xckl009 = ' '
   
   LET l_xckl.xckl010 = ' '
   
   LET l_sql = ''
   CASE p_xckk.xckk005
      WHEN '200'  #在制人工费  
         #总表抓xcce的
         LET l_sql = "SELECT 0 , ",
                     "      SUM(CASE xcce007 WHEN 'DL+OH+SUB' THEN xcce202 - xcce202a ELSE 0 END), ", #在製總投入 - 材料投入
                     "      0, ",
                     "      SUM(CASE xcce007 WHEN 'DL+OH+SUB' THEN xcce202b ELSE 0 END),SUM(CASE xcce007 WHEN 'DL+OH+SUB' THEN xcce202c ELSE 0 END),",
                     "      SUM(CASE xcce007 WHEN 'DL+OH+SUB' THEN xcce202d ELSE 0 END),SUM(CASE xcce007 WHEN 'DL+OH+SUB' THEN xcce202e ELSE 0 END),",
                     "      SUM(CASE xcce007 WHEN 'DL+OH+SUB' THEN xcce202f ELSE 0 END),SUM(CASE xcce007 WHEN 'DL+OH+SUB' THEN xcce202g ELSE 0 END),",
                     "      SUM(CASE xcce007 WHEN 'DL+OH+SUB' THEN xcce202h ELSE 0 END) ",
                     "  FROM xcce_t  ",
                     " WHERE xcceent = '",g_enterprise,"' AND xcceld = '",g_master.xckkld,"' AND xccecomp = '",g_master.xckkcomp,"' ",
                     "   AND xcce001 = '",g_master.xckk001,"' AND xcce003 = '",g_master.xckk002,"' ", 
                     "   AND xcce004 = '",g_master.xckk003,"' AND xcce005 = '",g_master.xckk004,"' ",
                     "   AND (CASE WHEN xcce002 IS NULL THEN ' ' ELSE xcce002 END) = ? ",
                     "   AND (CASE WHEN xcce006 IS NULL THEN ' ' ELSE xcce006 END) = ? ",
                     #161031-00037#1--s
                     "   AND (CASE WHEN xcce007 IS NULL THEN ' ' ELSE xcce007 END) = ? "
                     #161031-00037#1--e
      WHEN '306'  #拆件人工费 
         #总表抓xcci的
         LET l_sql = " SELECT 0 , ",
                      "       SUM(CASE xcci007 WHEN 'DL+OH+SUB' THEN xcci202 - xcci202a ELSE 0 END), ", #在製總投入 - 材料投入
                      "       0, ",
                      "       SUM(CASE xcci007 WHEN 'DL+OH+SUB' THEN xcci202b ELSE 0 END),SUM(CASE xcci007 WHEN 'DL+OH+SUB' THEN xcci202c ELSE 0 END), ",
                      "       SUM(CASE xcci007 WHEN 'DL+OH+SUB' THEN xcci202d ELSE 0 END),SUM(CASE xcci007 WHEN 'DL+OH+SUB' THEN xcci202e ELSE 0 END), ",
                      "       SUM(CASE xcci007 WHEN 'DL+OH+SUB' THEN xcci202f ELSE 0 END),SUM(CASE xcci007 WHEN 'DL+OH+SUB' THEN xcci202g ELSE 0 END), ",
                      "       SUM(CASE xcci007 WHEN 'DL+OH+SUB' THEN xcci202h ELSE 0 END) ",                                                        
                     " FROM xcci_t ",
                     " WHERE xccient = '",g_enterprise,"' AND xccild = '",g_master.xckkld,"' AND xccicomp = '",g_master.xckkcomp,"' ",
                     "   AND xcci001 = '",g_master.xckk001,"' AND xcci003 = '",g_master.xckk002,"' ",
                     "   AND xcci004 = '",g_master.xckk003,"' AND xcci005 = '",g_master.xckk004,"' ",
                     "   AND (CASE WHEN xcci002 IS NULL THEN ' ' ELSE xcci002 END) = ? ",
                     "   AND (CASE WHEN xcci006 IS NULL THEN ' ' ELSE xcci006 END) = ? ",
                     #161031-00037#1--s
                     "   AND (CASE WHEN xcci007 IS NULL THEN ' ' ELSE xcci007 END) = ? "
                     #161031-00037#1--e
   END CASE                
   PREPARE axcq603_sel_xcce_pb5 FROM l_sql
   DECLARE axcq603_sel_xcce_cs5 CURSOR FOR axcq603_sel_xcce_pb5
   
   #从明细表xcbk抓资料
   CASE g_master.xckk001 
      WHEN '1'  #本位币一
         LET l_sql = " SELECT SUM(xcbk202) "
      WHEN '2'  #本位币二
         LET l_sql = " SELECT SUM(xcbk212) "
      WHEN '3'  #本位币三
         LET l_sql = " SELECT SUM(xcbk222) "
      OTHERWISE
         LET l_sql = " SELECT SUM(xcbk202) "
    END CASE
    LET l_sql = l_sql , "  FROM xcbk_t ",
               "   WHERE xcbkent = '",g_enterprise,"' AND xcbkld = '",g_master.xckkld,"' ",
               "     AND xcbkcomp = '",g_master.xckkcomp,"' AND xcbk001 = '",g_master.xckk002,"' ",
               "     AND xcbk002 = ",g_master.xckk003," AND xcbk003 = ",g_master.xckk004,
               "     AND xcbk005 = ? AND xcbk006 = ? "
   PREPARE axcq603_sel_xcbk3 FROM l_sql
   
   #170309-00065#1---mark---s
   #LET l_sql = " SELECT DISTINCT xcbk006 FROM xcbk_t , sfaa_t  ", 
   #            "   WHERE xcbkent = '",g_enterprise,"' AND xcbkld = '",g_master.xckkld,"' ",
   #            "     AND xcbkcomp = '",g_master.xckkcomp,"' AND xcbk001 = '",g_master.xckk002,"' ",
   #            "     AND xcbk002 = ",g_master.xckk003," AND xcbk003 = ",g_master.xckk004,
   #            "     AND xcbkent = sfaaent AND xcbk006 = sfaadocno "  
   #CASE p_xckk.xckk005
   #   WHEN '200'  #在制人工费 
   #      LET l_sql = l_sql , " AND sfaa003 <> '3' "  #xcck里的工单入库，排除拆件        
   #   WHEN '306'  #拆件人工费 
   #      LET l_sql = l_sql , " AND sfaa003 = '3' "  ##xcck里的工单入库，拆件 
   #END CASE
   #170309-00065#1---mark---e
   #170309-00065#1---add---s
   CASE p_xckk.xckk005
      WHEN '200'  #在制人工费  
         #总表抓xcce的
         LET l_sql = "SELECT DISTINCT xcce006 ",
                     "  FROM xcce_t  ",
                     " WHERE xcceent = '",g_enterprise,"' AND xcceld = '",g_master.xckkld,"' AND xccecomp = '",g_master.xckkcomp,"' ",
                     "   AND xcce001 = '",g_master.xckk001,"' AND xcce003 = '",g_master.xckk002,"' ", 
                     "   AND xcce004 = '",g_master.xckk003,"' AND xcce005 = '",g_master.xckk004,"' "
      WHEN '306'  #拆件人工费 
         #总表抓xcci的
         LET l_sql = " SELECT DISTINCT xcci006",                                                        
                     " FROM xcci_t ",
                     " WHERE xccient = '",g_enterprise,"' AND xccild = '",g_master.xckkld,"' AND xccicomp = '",g_master.xckkcomp,"' ",
                     "   AND xcci001 = '",g_master.xckk001,"' AND xcci003 = '",g_master.xckk002,"' ",
                     "   AND xcci004 = '",g_master.xckk003,"' AND xcci005 = '",g_master.xckk004,"' "
   END CASE             
   #170309-00065#1---add---e
   PREPARE axcq603_sel_xcbk_pb1 FROM l_sql
   DECLARE axcq603_sel_xcbk_cs1 CURSOR FOR axcq603_sel_xcbk_pb1
   
   FOREACH axcq603_sel_xcbk_cs1 INTO l_xckl.xckl006
                         
      IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xcck_t"
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      LET l_xckl.xckl103 = 0 
      LET l_xckl.xckl104a = 0  #材料投入
      LET l_xcbk005 = '1'  #人工
      EXECUTE axcq603_sel_xcbk3 USING l_xcbk005 ,l_xckl.xckl006 INTO l_xckl.xckl104b 
      #明细表抓xcck的非拆件委外工单的委外加工金额
      #加工
      LET l_xckl.xckl104c = 0
      CASE p_xckk.xckk005
         WHEN '200'  #在制人工费 
            #161031-00037#1---s
            ##xcck055先选择工单领用，再通过xcck006参考单号去关联工单类型(关联制程档里)有个委外否
            #SELECT SUM((CASE WHEN xcck202c  IS NULL THEN 0 ELSE xcck202c  END)* xcck009) INTO l_xckl.xckl104c
            #  FROM xcck_t , sfcb_t,sfec_t #160531-00032#1
            #  WHERE xcckent = g_enterprise AND xcckld = g_master.xckkld AND xcckcomp = g_master.xckkcomp
            #    AND xcck001 = g_master.xckk001 AND xcck003 = g_master.xckk002
            #    AND xcck004 = g_master.xckk003 AND xcck005 = g_master.xckk004
            #    #AND xcck055 = '301' AND xcck020 <> '113'  #xcck里的工单发料，排除拆件  #160531-00032#1
            #    AND xcck055 = '3012' AND xcck020 <> '113'  #xcck里的工单发料，排除拆件  #160531-00032#1
            #    #AND xcckent = sfcbent AND xcck006 = sfcbdocno AND sfcb012 = 'Y' #委外否 #160531-00032#1
            #    AND xcckent = sfecent  AND xcck006 = sfecdocno AND sfecent = sfcbent AND sfec001 = sfcbdocno AND sfcb012 = 'Y' #委外否 #160531-00032#1
            #SELECT SUM(CASE apcb001 WHEN '21' THEN apcb113*(-1) ELSE apcb113 END) INTO l_xckl.xckl104c FROM apca_t,apcb_t,pmds_t,pmdt_t  #170306-00029#1 mark
            SELECT SUM(CASE apcb001 WHEN '21' THEN apcb113*(-1) ELSE apcb113 END) INTO l_xckl.xckl104c   #170306-00029#1 add
              #FROM apca_t,apcb_t,pmds_t,pmdt_t,pmdv_t,sfaa_t    #170306-00029#1 add   #170313-00012#1 mark
              FROM apca_t,apcb_t,pmds_t,pmdt_t,pmdp_t,sfaa_t     #170313-00012#1 add
             WHERE apcaent = apcbent AND apcald = apcbld AND apcadocno = apcbdocno 
	            AND pmdsent = pmdtent AND pmdsdocno = pmdtdocno AND pmdsstus = 'S'
	            #170313-00012#1---mod---s
	            #AND pmdtent = pmdvent AND pmdtdocno = pmdvdocno AND pmdtseq = pmdvseq    #170306-00029#1 add  
	            #AND pmdvent = sfaaent AND pmdv014 = sfaadocno 	                         #170306-00029#1 add
	            AND pmdtent = pmdpent AND pmdt001 = pmdpdocno AND pmdt002 = pmdpseq AND pmdt003 = pmdpseq1    
	            AND pmdpent = sfaaent AND pmdp003 = sfaadocno 	                                   
	            #170313-00012#1---mod---s
	            AND pmds011 = '2' AND pmds000 IN ('12','14','20')
	           #AND pmdsdocdt BETWEEN g_bdate AND g_edate  #170210-00001#1 mark
	            AND pmds001 BETWEEN g_bdate AND g_edate    #170210-00001#1 add
	            AND pmds037 = g_curr AND pmdtsite = pmdssite 
	            AND apcaent = g_enterprise AND pmdsent = apcaent
               AND apcald = g_master.xckkld
               AND apcastus = 'Y' AND apcb001 IN ('11','21')
               AND apcb023 = 'N'
	            AND apcb002 = pmdtdocno AND apcb003=pmdtseq
	            AND pmdt001 IS NOT NULL                   #170210-00001#1 add
	            #AND pmdv014 = l_xckl.xckl006   #170306-00029#1 add      #170313-00012#1 mark
	            AND sfaadocno = l_xckl.xckl006    #170313-00012#1 add
	            AND sfaa003 <> '3'             #170306-00029#1 add
            #161031-00037#1---e                
         WHEN '306'  #拆件人工费 
            #xcck055先选择工单领用，再通过xcck006参考单号去关联工单类型(关联制程档里)有个委外否
            SELECT SUM((CASE WHEN xcck202c  IS NULL THEN 0 ELSE xcck202c  END)* xcck009) INTO l_xckl.xckl104c
              #FROM xcck_t , sfcb_t,sfec_t #160531-00032#1  #161031-00037#1 mark
              FROM xcck_t , sfcb_t #161031-00037#1 
              WHERE xcckent = g_enterprise AND xcckld = g_master.xckkld AND xcckcomp = g_master.xckkcomp
                AND xcck001 = g_master.xckk001 AND xcck003 = g_master.xckk002
                AND xcck004 = g_master.xckk003 AND xcck005 = g_master.xckk004 
                #AND xcck055 = '301' AND xcck020 ='113'  #xcck里的工单发料，拆件  #160531-00032#1
                AND xcck055 = '3012' AND xcck020 ='113'  #xcck里的工单发料，拆件  #160531-00032#1
                #AND xcckent = sfcbent AND xcck006 = sfcbdocno AND sfcb012 = 'Y' #委外否  #160531-00032#1
                #AND xcckent = sfecent  AND xcck006 = sfecdocno AND sfecent = sfcbent AND sfec001 = sfcbdocno AND sfcb012 = 'Y' #委外否 #160531-00032#1 #161031-00037#1 mark
                AND xcckent = sfcbent AND xcck047 = sfcbdocno AND sfcb012 = 'Y' #161031-00037#1 
      END CASE  
   
      LET l_xcbk005 = '2'  #製費一
      EXECUTE axcq603_sel_xcbk3 USING l_xcbk005 ,l_xckl.xckl006 INTO l_xckl.xckl104d
      LET l_xcbk005 = '3'  #製費二
      EXECUTE axcq603_sel_xcbk3 USING l_xcbk005 ,l_xckl.xckl006 INTO l_xckl.xckl104e
      LET l_xcbk005 = '4'  #製費三
      EXECUTE axcq603_sel_xcbk3 USING l_xcbk005 ,l_xckl.xckl006 INTO l_xckl.xckl104f
      LET l_xcbk005 = '5'  #製費四
      EXECUTE axcq603_sel_xcbk3 USING l_xcbk005 ,l_xckl.xckl006 INTO l_xckl.xckl104g
      LET l_xcbk005 = '6'  #製費五
      EXECUTE axcq603_sel_xcbk3 USING l_xcbk005 ,l_xckl.xckl006 INTO l_xckl.xckl104h
      #160531-00032#1----s
      IF cl_null(l_xckl.xckl104b) THEN
         LET l_xckl.xckl104b = 0
      END IF
      IF cl_null(l_xckl.xckl104d) THEN
         LET l_xckl.xckl104d = 0
      END IF
      IF cl_null(l_xckl.xckl104e) THEN
         LET l_xckl.xckl104e = 0
      END IF
      IF cl_null(l_xckl.xckl104f) THEN
         LET l_xckl.xckl104f = 0
      END IF
      IF cl_null(l_xckl.xckl104g) THEN
         LET l_xckl.xckl104g = 0
      END IF
      IF cl_null(l_xckl.xckl104h) THEN
         LET l_xckl.xckl104h = 0
      END IF
      #160531-00032#1----e
      LET l_xckl.xckl104 = l_xckl.xckl104b+l_xckl.xckl104d+l_xckl.xckl104e+l_xckl.xckl104f+l_xckl.xckl104g+l_xckl.xckl104h
   
      
      LET l_xckl.xckl007 = 'DL+OH+SUB'  #161031-00037#1
      EXECUTE axcq603_sel_xcce_cs5 USING l_xckl.xckl010,l_xckl.xckl006,l_xckl.xckl007 #161031-00037#1 add xckl007
                                   INTO l_xckl.xckl101, l_xckl.xckl102, l_xckl.xckl102a,l_xckl.xckl102b,l_xckl.xckl102c,
                                        l_xckl.xckl102d,l_xckl.xckl102e,l_xckl.xckl102f,l_xckl.xckl102g,l_xckl.xckl102h 
                                        
      IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xcbk_t"
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
       
      #161109-00085#26-s mod            
#      IF NOT axcq603_ins_xckl(l_xckl.*) THEN   #161109-00085#26-s mark
      IF NOT axcq603_ins_xckl(l_xckl.xcklent,l_xckl.xcklcomp,l_xckl.xcklld,l_xckl.xckl001,l_xckl.xckl002,
                              l_xckl.xckl003,l_xckl.xckl004,l_xckl.xckl005,l_xckl.xckl006,l_xckl.xckl007,
                              l_xckl.xckl008,l_xckl.xckl009,l_xckl.xckl010,l_xckl.xckl090,l_xckl.xckl101,
                              l_xckl.xckl102,l_xckl.xckl102a,l_xckl.xckl102b,l_xckl.xckl102c,l_xckl.xckl102d,
                              l_xckl.xckl102e,l_xckl.xckl102f,l_xckl.xckl102g,l_xckl.xckl102h,l_xckl.xckl103,
                              l_xckl.xckl104,l_xckl.xckl104a,l_xckl.xckl104b,l_xckl.xckl104c,l_xckl.xckl104d,
                              l_xckl.xckl104e,l_xckl.xckl104f,l_xckl.xckl104g,l_xckl.xckl104h,l_xckl.xckl105,
                              l_xckl.xckl106,l_xckl.xckl106a,l_xckl.xckl106b,l_xckl.xckl106c,l_xckl.xckl106d,
                              l_xckl.xckl106e,l_xckl.xckl106f,l_xckl.xckl106g,l_xckl.xckl106h) THEN
      #161109-00085#26-e mod      
         LET r_success = FALSE
         RETURN r_success
      END IF
      
   END FOREACH    

   #在制投入-加工 明细表抓xcck的非拆件委外工单的委外加工金额，并写入xckk；有差异的按在制单号(工单)找出差异并写入xckl
   #LET l_sql = " SELECT xcck006,SUM((CASE WHEN xcck202c  IS NULL THEN 0 ELSE xcck202c  END)* xcck009) ,", #161031-00037#1 mark
   LET l_sql = " SELECT xcck047,SUM((CASE WHEN xcck202c  IS NULL THEN 0 ELSE xcck202c  END)* xcck009) ,",  #161031-00037#1   
               #161031-00037#1---s
               "        (CASE WHEN xcck010 IS NULL THEN ' ' ELSE xcck010 END) ,",
               "        (CASE WHEN xcck011 IS NULL THEN ' ' ELSE xcck011 END) ,",
               "        (CASE WHEN xcck017 IS NULL THEN ' ' ELSE xcck017 END) ",
               #161031-00037#1----e
               "  FROM xcck_t , sfcb_t ", #160531-00032#1  #161031-00037#1 remark
               #"  FROM xcck_t,sfcb_t,sfec_t  ",  #160531-00032#1  #161031-00037#1 mark
               "   WHERE xcckent = '",g_enterprise,"' AND xcckld = '",g_master.xckkld,"' AND xcckcomp = '",g_master.xckkcomp,"' ",
               "     AND xcck001 = '",g_master.xckk001,"' AND xcck003 = '",g_master.xckk002,"' ",
               "     AND xcck004 = '",g_master.xckk003,"' AND xcck005 = '",g_master.xckk004,"' ",
               #"     AND xcckent = sfcbent AND xcck006 = sfcbdocno AND sfcb012 = 'Y' ", #委外否 #160531-00032#1
               #"     AND xcckent = sfecent AND xcck006 = sfecdocno AND sfecent = sfcbent AND sfec001 = sfcbdocno AND sfcb012 = 'Y' " , #委外否 #160531-00032#1  #161031-00037#1 mark
               "     AND xcckent = sfcbent AND xcck047 = sfcbdocno AND sfcb012 = 'Y' ", #委外否 #161031-00037#1 
               #"     AND xcck055 = '301' ",   #160531-00032#1
               "     AND xcck055 = '3012' ",   #160531-00032#1
               #当前类型没有写入xckl的
               #"     AND xcck006 NOT IN ( SELECT xckl006 FROM xckl_t WHERE xcklent = '",g_enterprise,"' AND xcklld = '",g_master.xckkld,"' ", #161031-00037#1 
               "     AND xcck047 NOT IN ( SELECT xckl006 FROM xckl_t WHERE xcklent = '",g_enterprise,"' AND xcklld = '",g_master.xckkld,"' ", #161031-00037#1 
               "                          AND xckl001 = '",g_master.xckk001,"' AND xckl002 '",g_master.xckk002,"' ",
               "                          AND xckl003 = '",g_master.xckk003,"' AND xckl004 = '",g_master.xckk004,"' ",
               "                          AND xckl005 = '",p_xckk.xckk005,"' AND xckl007 = ' ' AND xckl008 = ' ' AND xckl009 = ' ' AND xckl010 = ' ' ",
               "                        ) " 
               
   CASE p_xckk.xckk005
      WHEN '200'  #在制人工费 
         LET l_sql = l_sql , " AND xcck020 <> '113' "  #xcck里的工单发料，排除拆件      
      WHEN '306'  #拆件人工费 
         LET l_sql = l_sql , " AND xcck020 = '113' "  #xcck里的工单发料，拆件 
   END CASE  
   #LET l_sql = l_sql , " GROUP BY xcck006 ,", #160531-00032#1  #161031-00037#1 
   LET l_sql = l_sql , " GROUP BY xcck047 ,", #160531-00032#1  #161031-00037#1 
                       #161031-00037#1---s 
                       "          (CASE WHEN xcck010 IS NULL THEN ' ' ELSE xcck010 END),",  
                       "          (CASE WHEN xcck011 IS NULL THEN ' ' ELSE xcck011 END),",  
                       "          (CASE WHEN xcck017 IS NULL THEN ' ' ELSE xcck017 END) "          
                       #161031-00037#1---e
   PREPARE axcq603_sel_xcck_pb5 FROM l_sql
   DECLARE axcq603_sel_xcck_cs5 CURSOR FOR axcq603_sel_xcck_pb5
   
   FOREACH axcq603_sel_xcck_cs5 INTO l_xckl.xckl006,l_xckl.xckl104c,
                                     l_xckl.xckl007,l_xckl.xckl008,l_xckl.xckl009   #161031-00037#1
                         
      IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xcck_t"
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      LET l_xckl.xckl103 = 0
      LET l_xckl.xckl104a = 0  #材料投入
      LET l_xckl.xckl104d = 0
      LET l_xckl.xckl104e = 0
      LET l_xckl.xckl104f = 0
      LET l_xckl.xckl104g = 0
      LET l_xckl.xckl104h = 0
      LET l_xckl.xckl104 = l_xckl.xckl104b+l_xckl.xckl104d+l_xckl.xckl104e+l_xckl.xckl104f+l_xckl.xckl104g+l_xckl.xckl104h
   
   
      EXECUTE axcq603_sel_xcce_cs5 USING l_xckl.xckl010,l_xckl.xckl006,l_xckl.xckl007 #161031-00037#1 add xckl007
                                   INTO l_xckl.xckl101, l_xckl.xckl102, l_xckl.xckl102a,l_xckl.xckl102b,l_xckl.xckl102c,
                                        l_xckl.xckl102d,l_xckl.xckl102e,l_xckl.xckl102f,l_xckl.xckl102g,l_xckl.xckl102h 
                                        
      IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "xcck_t"
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
       
      #161109-00085#26-s mod            
#      IF NOT axcq603_ins_xckl(l_xckl.*) THEN   #161109-00085#26-s mark
      IF NOT axcq603_ins_xckl(l_xckl.xcklent,l_xckl.xcklcomp,l_xckl.xcklld,l_xckl.xckl001,l_xckl.xckl002,
                              l_xckl.xckl003,l_xckl.xckl004,l_xckl.xckl005,l_xckl.xckl006,l_xckl.xckl007,
                              l_xckl.xckl008,l_xckl.xckl009,l_xckl.xckl010,l_xckl.xckl090,l_xckl.xckl101,
                              l_xckl.xckl102,l_xckl.xckl102a,l_xckl.xckl102b,l_xckl.xckl102c,l_xckl.xckl102d,
                              l_xckl.xckl102e,l_xckl.xckl102f,l_xckl.xckl102g,l_xckl.xckl102h,l_xckl.xckl103,
                              l_xckl.xckl104,l_xckl.xckl104a,l_xckl.xckl104b,l_xckl.xckl104c,l_xckl.xckl104d,
                              l_xckl.xckl104e,l_xckl.xckl104f,l_xckl.xckl104g,l_xckl.xckl104h,l_xckl.xckl105,
                              l_xckl.xckl106,l_xckl.xckl106a,l_xckl.xckl106b,l_xckl.xckl106c,l_xckl.xckl106d,
                              l_xckl.xckl106e,l_xckl.xckl106f,l_xckl.xckl106g,l_xckl.xckl106h) THEN
      #161109-00085#26-e mod      
         LET r_success = FALSE
         RETURN r_success
      END IF
      
   END FOREACH    
   
   RETURN r_success
   
END FUNCTION

#库存明细差异页签资料填充
#161031-00037#1 add
PRIVATE FUNCTION axcq603_b_fill_xckl()
DEFINE li_ac           LIKE type_t.num10
DEFINE l_i             LIKE type_t.num10   
   
   LET li_ac = l_ac
 
#Page3
   CALL g_xckk3_d.clear()
   
#Page4
   CALL g_xckk4_d.clear() 
   
   LET g_sql = "SELECT UNIQUE gzcb012,xckl005,xckl007,xckl008,xckl009,
                  xckl101,xckl102,xckl103,xckl104,xckl105,xckl106,
                  xckl102a,xckl104a,xckl106a,xckl102b,xckl104b,xckl106b,xckl102c,xckl104c,xckl106c,xckl102d,xckl104d, 
                  xckl106d,xckl102e,xckl104e,xckl106e,xckl102f,xckl104f,xckl106f,xckl102g,xckl104g,xckl106g,xckl102h, 
                  xckl104h,xckl106h,t1.gzcbl004,t2.imaal003,t3.imaal004,t4.inaml004 ",
            "     FROM xckl_t ",
            "    LEFT JOIN gzcbl_t t1 ON t1.gzcbl001 = '8922' AND t1.gzcbl002 = xckl005 AND t1.gzcbl003 = '"||g_dlang||"'" ,  
            "    LEFT JOIN imaal_t t2 ON t2.imaalent = xcklent AND t2.imaal001 = xckl007 AND t2.imaal002 = '"||g_dlang||"'" ,   #170112-00033#1 add ent
            "    LEFT JOIN imaal_t t3 ON t3.imaalent = xcklent AND t3.imaal001 = xckl007 AND t3.imaal002 = '"||g_dlang||"'" ,   #170112-00033#1 add ent         
            "    LEFT JOIN inaml_t t4 ON t4.inamlent = xcklent AND t4.inaml001 = xckl007 AND t4.inaml002 = xckl008 AND t4.inaml003 = '"||g_dlang||"'" ,  #170112-00033#1 add ent
            "    , gzcb_t ",
            "  WHERE xcklent  = ",g_enterprise,
            "    AND xcklcomp = '",g_master.xckkcomp,"'",    #法人
            "    AND xcklld   = '",g_master.xckkld,"'",      #账套
            "    AND xckl001  = '",g_master.xckk001,"'",     #本位币顺序
            "    AND xckl002  = '",g_master.xckk002,"'",     #成本计算类型
            "    AND xckl003  = '",g_master.xckk003,"'",     #年度  
            "    AND xckl004  = '",g_master.xckk004,"'",     #期别
            "    AND gzcb001 = '8922' AND gzcb002 = xckl005 ",
            "    AND xckl005 LIKE '1%' "   #库存明细部分的核对项目编号
   #---增加帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET g_sql = g_sql ," AND xcklld IN ",g_wc_cs_ld
    END IF
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET g_sql = g_sql ," AND xcklcomp IN ",g_wc_cs_comp
   END IF             
   LET g_sql = g_sql , " ORDER BY gzcb012 "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axcq603_pb4 FROM g_sql
   DECLARE b_fill_curs4 CURSOR FOR axcq603_pb4

   LET l_ac = 1
   FOREACH b_fill_curs4 INTO g_xckk3_d[l_ac].gzcb012,
                 g_xckk3_d[l_ac].xckl005,g_xckk3_d[l_ac].xckl007,g_xckk3_d[l_ac].xckl008,
                 g_xckk3_d[l_ac].xckl009,g_xckk3_d[l_ac].xckl101,g_xckk3_d[l_ac].xckl102,g_xckk3_d[l_ac].xckl103, 
                 g_xckk3_d[l_ac].xckl104,g_xckk3_d[l_ac].xckl105,g_xckk3_d[l_ac].xckl106,g_xckk3_d[l_ac].xckl102a, 
                 g_xckk3_d[l_ac].xckl104a,g_xckk3_d[l_ac].xckl106a,g_xckk3_d[l_ac].xckl102b,g_xckk3_d[l_ac].xckl104b, 
                 g_xckk3_d[l_ac].xckl106b,g_xckk3_d[l_ac].xckl102c,g_xckk3_d[l_ac].xckl104c,g_xckk3_d[l_ac].xckl106c, 
                 g_xckk3_d[l_ac].xckl102d,g_xckk3_d[l_ac].xckl104d,g_xckk3_d[l_ac].xckl106d,g_xckk3_d[l_ac].xckl102e, 
                 g_xckk3_d[l_ac].xckl104e,g_xckk3_d[l_ac].xckl106e,g_xckk3_d[l_ac].xckl102f,g_xckk3_d[l_ac].xckl104f, 
                 g_xckk3_d[l_ac].xckl106f,g_xckk3_d[l_ac].xckl102g,g_xckk3_d[l_ac].xckl104g,g_xckk3_d[l_ac].xckl106g, 
                 g_xckk3_d[l_ac].xckl102h,g_xckk3_d[l_ac].xckl104h,g_xckk3_d[l_ac].xckl106h,
                 g_xckk3_d[l_ac].xckl005_desc,g_xckk3_d[l_ac].xckl007_desc,g_xckk3_d[l_ac].xckl007_desc_1,
                 g_xckk3_d[l_ac].xckl008_desc
       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF 
      
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend =  "" 
         LET g_errparam.code   =  9035 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
 
   END FOREACH 
   
    LET g_sql = "SELECT UNIQUE gzcb012,xckl005,xckl006,xckl007,xckl008,xckl009,
                  xckl101,xckl102,xckl103,xckl104,xckl105,xckl106, 
                  xckl102a,xckl104a,xckl106a,xckl102b,xckl104b,xckl106b,xckl102c,xckl104c,xckl106c,xckl102d,xckl104d, 
                  xckl106d,xckl102e,xckl104e,xckl106e,xckl102f,xckl104f,xckl106f,xckl102g,xckl104g,xckl106g,xckl102h, 
                  xckl104h,xckl106h,t1.gzcbl004,t2.imaal003,t3.imaal004,t4.inaml004 ",
            "     FROM xckl_t ",
            "    LEFT JOIN gzcbl_t t1 ON t1.gzcbl001 = '8922' AND t1.gzcbl002 = xckl005 AND t1.gzcbl003 = '"||g_dlang||"'" ,  
            "    LEFT JOIN imaal_t t2 ON t2.imaalent = xcklent AND t2.imaal001 = xckl007 AND t2.imaal002 = '"||g_dlang||"'" ,   #170112-00033#1 add ent
            "    LEFT JOIN imaal_t t3 ON t3.imaalent = xcklent AND t3.imaal001 = xckl007 AND t3.imaal002 = '"||g_dlang||"'" ,   #170112-00033#1 add ent         
            "    LEFT JOIN inaml_t t4 ON t4.inamlent = xcklent AND t4.inaml001 = xckl007 AND t4.inaml002 = xckl008 AND t4.inaml003 = '"||g_dlang||"'" ,  #170112-00033#1 add ent
            "    , gzcb_t ", 
            "  WHERE xcklent  = ",g_enterprise,
            "    AND xcklcomp = '",g_master.xckkcomp,"'",    #法人
            "    AND xcklld   = '",g_master.xckkld,"'",      #账套
            "    AND xckl001  = '",g_master.xckk001,"'",     #本位币顺序
            "    AND xckl002  = '",g_master.xckk002,"'",     #成本计算类型
            "    AND xckl003  = '",g_master.xckk003,"'",     #年度  
            "    AND xckl004  = '",g_master.xckk004,"'",     #期别
            "    AND gzcb001 = '8922' AND gzcb002 = xckl005 ",
            "    AND (xckl005 LIKE '2%' OR xckl005 LIKE '3%' ) "   #在制明细部分的核对项目编号
   #---增加帳套權限控管
   IF NOT cl_null(g_wc_cs_ld) THEN
      LET g_sql = g_sql ," AND xcklld IN ",g_wc_cs_ld
    END IF
   #---增加法人過濾條件
   IF NOT cl_null(g_wc_cs_comp) THEN
      LET g_sql = g_sql ," AND xcklcomp IN ",g_wc_cs_comp
   END IF             
   LET g_sql = g_sql , " ORDER BY gzcb012 "
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   PREPARE axcq603_pb5 FROM g_sql
   DECLARE b_fill_curs5 CURSOR FOR axcq603_pb5

   LET l_ac = 1
   FOREACH b_fill_curs5 INTO g_xckk4_d[l_ac].gzcb012,
                 g_xckk4_d[l_ac].xckl005,g_xckk4_d[l_ac].xckl006,g_xckk4_d[l_ac].xckl007,g_xckk4_d[l_ac].xckl008,
                 g_xckk4_d[l_ac].xckl009,g_xckk4_d[l_ac].xckl101,g_xckk4_d[l_ac].xckl102,g_xckk4_d[l_ac].xckl103, 
                 g_xckk4_d[l_ac].xckl104,g_xckk4_d[l_ac].xckl105,g_xckk4_d[l_ac].xckl106,g_xckk4_d[l_ac].xckl102a, 
                 g_xckk4_d[l_ac].xckl104a,g_xckk4_d[l_ac].xckl106a,g_xckk4_d[l_ac].xckl102b,g_xckk4_d[l_ac].xckl104b, 
                 g_xckk4_d[l_ac].xckl106b,g_xckk4_d[l_ac].xckl102c,g_xckk4_d[l_ac].xckl104c,g_xckk4_d[l_ac].xckl106c, 
                 g_xckk4_d[l_ac].xckl102d,g_xckk4_d[l_ac].xckl104d,g_xckk4_d[l_ac].xckl106d,g_xckk4_d[l_ac].xckl102e, 
                 g_xckk4_d[l_ac].xckl104e,g_xckk4_d[l_ac].xckl106e,g_xckk4_d[l_ac].xckl102f,g_xckk4_d[l_ac].xckl104f, 
                 g_xckk4_d[l_ac].xckl106f,g_xckk4_d[l_ac].xckl102g,g_xckk4_d[l_ac].xckl104g,g_xckk4_d[l_ac].xckl106g, 
                 g_xckk4_d[l_ac].xckl102h,g_xckk4_d[l_ac].xckl104h,g_xckk4_d[l_ac].xckl106h,
                 g_xckk4_d[l_ac].xckl005_1_desc,g_xckk4_d[l_ac].xckl007_1_desc,g_xckk4_d[l_ac].xckl007_1_desc_1,
                 g_xckk4_d[l_ac].xckl008_1_desc
       
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "FOREACH:" 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF 
      
      IF l_ac > g_max_rec THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend =  "" 
         LET g_errparam.code   =  9035 
         LET g_errparam.popup  = TRUE 
         CALL cl_err()
 
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
 
   END FOREACH 
   
#Page3
   CALL g_xckk3_d.deleteElement(g_xckk3_d.getLength())

#Page4
   CALL g_xckk4_d.deleteElement(g_xckk4_d.getLength())
 
   LET l_ac = li_ac
   
END FUNCTION

#效能优化，优化写入xckl的写法
#170220-00001#1
PRIVATE FUNCTION axcq603_insert_xckl(p_xckk005,p_xckk090)
DEFINE r_success    LIKE type_t.num5
DEFINE l_xckl       RECORD  #成本勾稽明細表
       xcklent LIKE xckl_t.xcklent, #企業編號
       xcklcomp LIKE xckl_t.xcklcomp, #法人組織
       xcklld LIKE xckl_t.xcklld, #帳套
       xckl001 LIKE xckl_t.xckl001, #本位幣順序
       xckl002 LIKE xckl_t.xckl002, #成本計算類型
       xckl003 LIKE xckl_t.xckl003, #年度
       xckl004 LIKE xckl_t.xckl004, #期別
       xckl005 LIKE xckl_t.xckl005, #
       xckl006 LIKE xckl_t.xckl006, #在製單據編號
       xckl007 LIKE xckl_t.xckl007, #料號
       xckl008 LIKE xckl_t.xckl008, #特徵
       xckl009 LIKE xckl_t.xckl009, #批號
       xckl010 LIKE xckl_t.xckl010, #成本域
       xckl090 LIKE xckl_t.xckl090, #明細程式編號
       xckl101 LIKE xckl_t.xckl101, #總報表數量
       xckl102 LIKE xckl_t.xckl102, #總報表金額
       xckl102a LIKE xckl_t.xckl102a, #材料
       xckl102b LIKE xckl_t.xckl102b, #人工
       xckl102c LIKE xckl_t.xckl102c, #加工
       xckl102d LIKE xckl_t.xckl102d, #制費一
       xckl102e LIKE xckl_t.xckl102e, #制費二
       xckl102f LIKE xckl_t.xckl102f, #制費三
       xckl102g LIKE xckl_t.xckl102g, #製費四
       xckl102h LIKE xckl_t.xckl102h, #制費五
       xckl103 LIKE xckl_t.xckl103, #分報表數量
       xckl104 LIKE xckl_t.xckl104, #分報表金額
       xckl104a LIKE xckl_t.xckl104a, #分報表材料
       xckl104b LIKE xckl_t.xckl104b, #分報表人工
       xckl104c LIKE xckl_t.xckl104c, #分報表加工
       xckl104d LIKE xckl_t.xckl104d, #分報表制費一
       xckl104e LIKE xckl_t.xckl104e, #分報表制費二
       xckl104f LIKE xckl_t.xckl104f, #分報表制費三
       xckl104g LIKE xckl_t.xckl104g, #分報表制費四
       xckl104h LIKE xckl_t.xckl104h, #分報表制費五
       xckl105 LIKE xckl_t.xckl105, #差異數量
       xckl106 LIKE xckl_t.xckl106, #差異金額
       xckl106a LIKE xckl_t.xckl106a, #差異金額-材料
       xckl106b LIKE xckl_t.xckl106b, #差異金額-人工
       xckl106c LIKE xckl_t.xckl106c, #差異金額-加工
       xckl106d LIKE xckl_t.xckl106d, #差異金額-制費一
       xckl106e LIKE xckl_t.xckl106e, #差異金額-制費二
       xckl106f LIKE xckl_t.xckl106f, #差異金額-制費三
       xckl106g LIKE xckl_t.xckl106g, #差異金額-制費四
       xckl106h LIKE xckl_t.xckl106h  #差異金額-制費五
          END RECORD
DEFINE p_xckk005    LIKE xckk_t.xckk005 
DEFINE p_xckk090    LIKE xckk_t.xckk090
DEFINE l_n          LIKE type_t.num5
DEFINE l_sql        STRING   
DEFINE l_sql_1      STRING   
DEFINE l_sql_2      STRING   
DEFINE l_sub_sql    STRING   
DEFINE l_sql_3      STRING
DEFINE l_sql_b      STRING 
DEFINE l_sql_c      STRING 
DEFINE l_sql_d      STRING 
DEFINE l_sql_e      STRING 
DEFINE l_sql_f      STRING 
DEFINE l_sql_g      STRING
DEFINE l_sql_h      STRING 

   LET r_success = TRUE

   
   INITIALIZE l_xckl.* TO NULL
   LET l_xckl.xckl005 = p_xckk005
   LET l_xckl.xckl090 = p_xckk090
   
   LET l_sql_1 = " INSERT INTO xckl_t (xcklent,xcklcomp,xcklld,             ", 
               "                     xckl001,xckl002,xckl003,xckl004,     ",
               "                     xckl005,                             ",
               "                     xckl006,xckl007,                     ",
               "                     xckl008,xckl009,xckl010,xckl090,     ",
               "                     xckl101,xckl102,                     ",
               "                     xckl102a,xckl102b,xckl102c,xckl102d, ",
               "                     xckl102e,xckl102f,xckl102g,xckl102h, ",
               "                     xckl103,xckl104,                     ",
               "                     xckl104a,xckl104b,xckl104c,xckl104d, ",
               "                     xckl104e,xckl104f,xckl104g,xckl104h, ",
               "                     xckl105,xckl106,                     ",
               "                     xckl106a,xckl106b,xckl106c,xckl106d, ",
               "                     xckl106e,xckl106f,xckl106g,xckl106h) ",
               " SELECT ",g_enterprise," ,'",g_master.xckkcomp,"', '",g_master.xckkld,"',   ",
               "        '",g_master.xckk001,"','",g_master.xckk002,"',",g_master.xckk003," , ",g_master.xckk004," , ",
               "        '",l_xckl.xckl005,"', ",  #l_xckl.xckl005
               " 	      (CASE WHEN xckl006 IS NULL THEN ' ' ELSE xckl006 END), xckl007, ",
               " 	      (CASE WHEN xckl008 IS NULL THEN ' ' ELSE xckl008 END),(CASE WHEN xckl009  IS NULL THEN ' ' ELSE xckl009 END),",
               "        (CASE WHEN xckl010  IS NULL THEN ' ' ELSE xckl010 END), ",
               "        '",l_xckl.xckl090,"' , ",  #l_xckl.xckl090
               "        SUM(xckl101) xckl101,SUM(xckl102) xckl102,                                                  ",
               "        SUM(xckl102a) xckl102a,SUM(xckl102b) xckl102b,SUM(xckl102c) xckl102c,SUM(xckl102d) xckl102d,",
               "        SUM(xckl102e) xckl102e,SUM(xckl102f) xckl102f,SUM(xckl102g) xckl102g,SUM(xckl102h) xckl102h,",
               "        SUM(xckl103) xckl103,SUM(xckl104) xckl104,                                                  ",
               "        SUM(xckl104a) xckl104a,SUM(xckl104b) xckl104b,SUM(xckl104c) xckl104c,SUM(xckl104d) xckl104d,",
               "        SUM(xckl104e) xckl104e,SUM(xckl104f) xckl104f,SUM(xckl104g) xckl104g,SUM(xckl104h) xckl104h,",
               "        (SUM(xckl101)-SUM(xckl103)) xckl105,(SUM(xckl102)-SUM(xckl104)) xckl106,                    ",
               "        (SUM(xckl102a)-SUM(xckl104a)) xckl106a,(SUM(xckl102b)-SUM(xckl104b)) xckl106b,(SUM(xckl102c)-SUM(xckl104c)) xckl106c,(SUM(xckl102d)-SUM(xckl104d)) xckl106d, ",
               "        (SUM(xckl102e)-SUM(xckl104e)) xckl106e,(SUM(xckl102f)-SUM(xckl104f)) xckl106f,(SUM(xckl102g)-SUM(xckl104g)) xckl106g,(SUM(xckl102h)-SUM(xckl104h)) xckl106h  ",
               "   FROM  ( "

   #170406-00027#1 add start  -----
   CASE l_xckl.xckl005 
      WHEN '217'       
         LET l_sql_2 = " ) ",                           
                        "  GROUP BY xckl010,xckl006,xckl007,xckl008,xckl009 HAVING ((SUM(xckl101)-(SUM(xckl103)*-1)) <> 0 OR (SUM(xckl102)-(SUM(xckl104)*-1)) <> 0  ",
                        "     OR (SUM(xckl102a)-(SUM(xckl104a)*-1)) <> 0 OR (SUM(xckl102b)-(SUM(xckl104b)*-1)) <> 0 OR (SUM(xckl102c)-(SUM(xckl104c)*-1)) <> 0 OR (SUM(xckl102d)-(SUM(xckl104d)*-1)) <> 0 ",
                        "     OR (SUM(xckl102e)-(SUM(xckl104e)*-1)) <> 0 OR (SUM(xckl102f)-(SUM(xckl104f)*-1)) <> 0 OR (SUM(xckl102g)-(SUM(xckl104g)*-1)) <> 0 OR (SUM(xckl102h)-(SUM(xckl104h)*-1)) <> 0) "
      OTHERWISE
   #170406-00027#1 add end   -----
         LET l_sql_2 = " ) ",                           
                        "  GROUP BY xckl010,xckl006,xckl007,xckl008,xckl009 HAVING ((SUM(xckl101)-SUM(xckl103)) <> 0 OR (SUM(xckl102)-SUM(xckl104)) <> 0  ",
                        "     OR (SUM(xckl102a)-SUM(xckl104a)) <> 0 OR (SUM(xckl102b)-SUM(xckl104b)) <> 0 OR (SUM(xckl102c)-SUM(xckl104c)) <> 0 OR (SUM(xckl102d)-SUM(xckl104d)) <> 0 ",
                        "     OR (SUM(xckl102e)-SUM(xckl104e)) <> 0 OR (SUM(xckl102f)-SUM(xckl104f)) <> 0 OR (SUM(xckl102g)-SUM(xckl104g)) <> 0 OR (SUM(xckl102h)-SUM(xckl104h)) <> 0) "
   END CASE #170406-00027#1 add
                  


   #总表抓xcce的非拆件工单的本期转出数量和金额，明细表抓xcck的非拆件工单入库的数量和金额，并写入xckk；有差异的按在制单号(工单)找出差异并写入xckl
   #LET l_xckk.xckk103 = l_xckk.xckk101 * (-1) #在製轉出，明細的數量，直接給總表的數量*(-1),因为明细表抓出来的值是负数  #161031-00037#1
   LET l_sql_3 = " INSERT INTO xckl_t (xcklent,xcklcomp,xcklld,             ", 
               "                     xckl001,xckl002,xckl003,xckl004,     ",
               "                     xckl005,                             ",
               "                     xckl006,xckl007,                     ",
               "                     xckl008,xckl009,xckl010,xckl090,     ",
               "                     xckl101,xckl102,                     ",
               "                     xckl102a,xckl102b,xckl102c,xckl102d, ",
               "                     xckl102e,xckl102f,xckl102g,xckl102h, ",
               "                     xckl103,xckl104,                     ",
               "                     xckl104a,xckl104b,xckl104c,xckl104d, ",
               "                     xckl104e,xckl104f,xckl104g,xckl104h, ",
               "                     xckl105,xckl106,                     ",
               "                     xckl106a,xckl106b,xckl106c,xckl106d, ",
               "                     xckl106e,xckl106f,xckl106g,xckl106h) ",
               " SELECT ",g_enterprise," ,'",g_master.xckkcomp,"', '",g_master.xckkld,"',   ",
               "         '",g_master.xckk001,"','",g_master.xckk002,"',",g_master.xckk003," , ",g_master.xckk004," , ",
               "         ? , ",  #l_xckl.xckl005
               " 	      (CASE WHEN xckl006 IS NULL THEN ' ' ELSE xckl006 END), xckl007, ",
               " 	      (CASE WHEN xckl008 IS NULL THEN ' ' ELSE xckl008 END),(CASE WHEN xckl009  IS NULL THEN ' ' ELSE xckl009 END),",
               "        (CASE WHEN xckl010  IS NULL THEN ' ' ELSE xckl010 END), ",
               "         ? , ",  #l_xckl.xckl090
               "        SUM(xckl101) xckl101,SUM(xckl102) xckl102,                                                  ",
               "        SUM(xckl102a) xckl102a,SUM(xckl102b) xckl102b,SUM(xckl102c) xckl102c,SUM(xckl102d) xckl102d,",
               "        SUM(xckl102e) xckl102e,SUM(xckl102f) xckl102f,SUM(xckl102g) xckl102g,SUM(xckl102h) xckl102h,",
               "        SUM(xckl101)*(-1) xckl103,SUM(xckl104) xckl104,                                                  ",
               "        SUM(xckl104a) xckl104a,SUM(xckl104b) xckl104b,SUM(xckl104c) xckl104c,SUM(xckl104d) xckl104d,",
               "        SUM(xckl104e) xckl104e,SUM(xckl104f) xckl104f,SUM(xckl104g) xckl104g,SUM(xckl104h) xckl104h,",
               "        (SUM(xckl101)-SUM(xckl103)) xckl105,(SUM(xckl102)-SUM(xckl104)) xckl106,                    ",
               "        (SUM(xckl102a)-SUM(xckl104a)) xckl106a,(SUM(xckl102b)-SUM(xckl104b)) xckl106b,(SUM(xckl102c)-SUM(xckl104c)) xckl106c,(SUM(xckl102d)-SUM(xckl104d)) xckl106d, ",
               "        (SUM(xckl102e)-SUM(xckl104e)) xckl106e,(SUM(xckl102f)-SUM(xckl104f)) xckl106f,(SUM(xckl102g)-SUM(xckl104g)) xckl106g,(SUM(xckl102h)-SUM(xckl104h)) xckl106h  ",
               "   FROM  ( "

   CASE l_xckl.xckl005
      WHEN '103'          #库存开账调整
         #库存开账调整总表抓xccj   
         LET l_sub_sql = " SELECT xccj002 xckl010,xccj010 xckl007,xccj011 xckl008,xccj017 xckl009,' ' xckl006 ,  ",
                         "        SUM((CASE WHEN xccj101  IS NULL THEN 0 ELSE xccj101  END)*xccj009) xckl101,   ",
                         "        SUM((CASE WHEN xccj102  IS NULL THEN 0 ELSE xccj102  END)*xccj009) xckl102,   ",  
                         "        SUM((CASE WHEN xccj102a IS NULL THEN 0 ELSE xccj102a END)*xccj009) xckl102a,",
                         "        SUM((CASE WHEN xccj102b IS NULL THEN 0 ELSE xccj102b END)*xccj009) xckl102b,", 
                         "        SUM((CASE WHEN xccj102c IS NULL THEN 0 ELSE xccj102c END)*xccj009) xckl102c,",
                         "        SUM((CASE WHEN xccj102d IS NULL THEN 0 ELSE xccj102d END)*xccj009) xckl102d,",   
                         "        SUM((CASE WHEN xccj102e IS NULL THEN 0 ELSE xccj102e END)*xccj009) xckl102e,",
                         "        SUM((CASE WHEN xccj102f IS NULL THEN 0 ELSE xccj102f END)*xccj009) xckl102f,", 
                         "        SUM((CASE WHEN xccj102g IS NULL THEN 0 ELSE xccj102g END)*xccj009) xckl102g,",
                         "        SUM((CASE WHEN xccj102h IS NULL THEN 0 ELSE xccj102h END)*xccj009) xckl102h,",
                         "        0 xckl103,0 xckl104,                         ",
                         "        0 xckl104a,0 xckl104b,0 xckl104c,0 xckl104d, ",
                         "        0 xckl104e,0 xckl104f,0 xckl104g,0 xckl104h  ",
                         "   FROM xccj_t  ",
                         "  WHERE xccjent = ",g_enterprise,
                         "    AND xccjld = '",g_master.xckkld,"' ",
                         "    AND xccjcomp = '",g_master.xckkcomp,"' ",
                         "    AND xccj001 = '",g_master.xckk001,"' ",
                         "    AND xccj003 = '",g_master.xckk002,"' ",
                         "    AND xccj004 = ",g_master.xckk003,
                         "    AND xccj005 = ",g_master.xckk004,
                         "   GROUP BY xccj002,xccj010,xccj011,xccj017   ",
                         "  UNION ",
                         " SELECT xcca002 xckl010,xcca006 xckl007,xcca007 xckl008,xcca008 xckl009,' ' xckl006 ,",    
                         "        0 xckl101,0 xckl102,                                                          ",
                         "        0 xckl102a,0 xckl102b,0 xckl102c,0 xckl102d,                                  ",
                         "        0 xckl102e,0 xckl102f,0 xckl102g,0 xckl102h,                                  "
         #明细表抓上期的xcca的数量和金额
         IF g_cost_type = '2' THEN  #170210-00001#1 add
            LET l_sub_sql = l_sub_sql , " SUM((CASE WHEN xcca101  IS NULL THEN 0 ELSE xcca101  END)) xckl103,  ",
                                        " SUM((CASE WHEN xcca102  IS NULL THEN 0 ELSE xcca102  END)) xckl104,  ",
                                        " SUM((CASE WHEN xcca102a IS NULL THEN 0 ELSE xcca102a END)) xckl104a, ",
                                        " SUM((CASE WHEN xcca102b IS NULL THEN 0 ELSE xcca102b END)) xckl104b, ", 
                                        " SUM((CASE WHEN xcca102c IS NULL THEN 0 ELSE xcca102c END)) xckl104c, ",
                                        " SUM((CASE WHEN xcca102d IS NULL THEN 0 ELSE xcca102d END)) xckl104d, ", 
                                        " SUM((CASE WHEN xcca102e IS NULL THEN 0 ELSE xcca102e END)) xckl104e, ",
                                        " SUM((CASE WHEN xcca102f IS NULL THEN 0 ELSE xcca102f END)) xckl104f, ", 
                                        " SUM((CASE WHEN xcca102g IS NULL THEN 0 ELSE xcca102g END)) xckl104g, ",
                                        " SUM((CASE WHEN xcca102h IS NULL THEN 0 ELSE xcca102h END)) xckl104h  "
         #170210-00001#1--add--start--
         #判斷非先進先出成本，明細就直接給0
         ELSE
            LET l_sub_sql = l_sub_sql , "  0 xckl103, 0 xckl104, 0 xckl104a, 0 xckl104b, 0 xckl104c, ",
                                        "  0 xckl104d,0 xckl104e,0 xckl104f, 0 xckl104g, 0 xckl104h  "
         END IF
         #170210-00001#1--add--end----  
         LET l_sub_sql = l_sub_sql , "   FROM xcca_t              ",
                                     "  WHERE xccaent = ",g_enterprise,
                                     "    AND xccald = '",g_master.xckkld,"' ",
                                     "    AND xccacomp = '",g_master.xckkcomp,"' ",
                                     "    AND xcca001 = '",g_master.xckk001,"' ",
                                     "    AND xcca003 = '",g_master.xckk002,"' ",
                                     "    AND xcca004 = ",g_previous_xckk003,
                                     "    AND xcca005 = ",g_previous_xckk004,
                                     "  GROUP BY xcca002,xcca006,xcca007,xcca008 "
                                     
         LET l_sql = l_sql_1 , l_sub_sql , l_sql_2
         PREPARE axcq603_ins_xckl_pb1 FROM l_sql
         DECLARE axcq603_ins_xckl_cs1 CURSOR FOR axcq603_ins_xckl_pb1
         EXECUTE axcq603_ins_xckl_cs1
         IF SQLCA.sqlcode  THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "axcq603_ins_xckl_cs1:"
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()                   
            LET r_success = FALSE
            RETURN r_success
         END IF    
   
     #总表抓xccc的本期期初数量和金额，明细表抓xccc的上期期末数量和金额，抓不到抓上期的xcca的数据和金额，并写入xckk；有差异的按料号+特性+批号+成本域找出差异并写入xckl
     WHEN '101'          #库存期初
         LET l_sub_sql = " SELECT xccc002 xckl010,xccc006 xckl007,xccc007 xckl008,xccc008 xckl009,' ' xckl006 ,   ",
                         "        SUM((CASE WHEN xccc101  IS NULL THEN 0 ELSE xccc101  END)) xckl101,   ",
                         "        SUM((CASE WHEN xccc102  IS NULL THEN 0 ELSE xccc102  END)) xckl102,   ",  
                         "        SUM((CASE WHEN xccc102a IS NULL THEN 0 ELSE xccc102a END)) xckl102a,",
                         "        SUM((CASE WHEN xccc102b IS NULL THEN 0 ELSE xccc102b END)) xckl102b,", 
                         "        SUM((CASE WHEN xccc102c IS NULL THEN 0 ELSE xccc102c END)) xckl102c,",
                         "        SUM((CASE WHEN xccc102d IS NULL THEN 0 ELSE xccc102d END)) xckl102d,",   
                         "        SUM((CASE WHEN xccc102e IS NULL THEN 0 ELSE xccc102e END)) xckl102e,",
                         "        SUM((CASE WHEN xccc102f IS NULL THEN 0 ELSE xccc102f END)) xckl102f,", 
                         "        SUM((CASE WHEN xccc102g IS NULL THEN 0 ELSE xccc102g END)) xckl102g,",
                         "        SUM((CASE WHEN xccc102h IS NULL THEN 0 ELSE xccc102h END)) xckl102h,",
                         "        0 xckl103,0 xckl104,                         ",
                         "        0 xckl104a,0 xckl104b,0 xckl104c,0 xckl104d, ",
                         "        0 xckl104e,0 xckl104f,0 xckl104g,0 xckl104h  ",
                         "   FROM xccc_t  ",
                         "  WHERE xcccent = ",g_enterprise,
                         "    AND xcccld = '",g_master.xckkld,"' ",
                         "    AND xccccomp = '",g_master.xckkcomp,"' ",
                         "    AND xccc001 = '",g_master.xckk001,"' ",
                         "    AND xccc003 = '",g_master.xckk002,"' ",
                         "    AND xccc004 = ",g_master.xckk003,
                         "    AND xccc005 = ",g_master.xckk004,
                         "   GROUP BY xccc002,xccc006,xccc007,xccc008   ",
                         "  UNION "
                         
         #明细表抓上期的xcca的数量和金额
         SELECT SUM((CASE WHEN xcca101 IS NULL THEN 0 ELSE xcca101 END)),  SUM((CASE WHEN xcca102 IS NULL THEN 0 ELSE xcca102 END)), 
                SUM((CASE WHEN xcca102a IS NULL THEN 0 ELSE xcca102a END)),SUM((CASE WHEN xcca102b IS NULL THEN 0 ELSE xcca102b END)),
                SUM((CASE WHEN xcca102c IS NULL THEN 0 ELSE xcca102c END)),SUM((CASE WHEN xcca102d IS NULL THEN 0 ELSE xcca102d END)),
                SUM((CASE WHEN xcca102e IS NULL THEN 0 ELSE xcca102e END)),SUM((CASE WHEN xcca102f IS NULL THEN 0 ELSE xcca102f END)),
                SUM((CASE WHEN xcca102g IS NULL THEN 0 ELSE xcca102g END)),SUM((CASE WHEN xcca102h IS NULL THEN 0 ELSE xcca102h END))       
            INTO l_xckl.xckl103, l_xckl.xckl104, l_xckl.xckl104a,l_xckl.xckl104b,l_xckl.xckl104c,
                 l_xckl.xckl104d,l_xckl.xckl104e,l_xckl.xckl104f,l_xckl.xckl104g,l_xckl.xckl104h
         FROM xcca_t 
         WHERE xccaent = g_enterprise AND xccald = g_master.xckkld AND xccacomp = g_master.xckkcomp
           AND xcca001 = g_master.xckk001 AND xcca003 = g_master.xckk002 
           AND xcca004 = g_previous_xckk003 AND xcca005 = g_previous_xckk004
         
         #抓不到抓上期的xcca的数据和金额
         IF (cl_null(l_xckl.xckl103)  OR l_xckl.xckl103 = 0) AND
            (cl_null(l_xckl.xckl104)  OR l_xckl.xckl104 = 0) AND
            (cl_null(l_xckl.xckl104a) OR l_xckl.xckl104a = 0) AND
            (cl_null(l_xckl.xckl104b) OR l_xckl.xckl104b = 0) AND
            (cl_null(l_xckl.xckl104c) OR l_xckl.xckl104c = 0) AND
            (cl_null(l_xckl.xckl104d) OR l_xckl.xckl104d = 0) AND
            (cl_null(l_xckl.xckl104e) OR l_xckl.xckl104e = 0) AND
            (cl_null(l_xckl.xckl104f) OR l_xckl.xckl104f = 0) AND
            (cl_null(l_xckl.xckl104g) OR l_xckl.xckl104g = 0) AND
            (cl_null(l_xckl.xckl104h) OR l_xckl.xckl104h = 0) THEN
            LET l_sub_sql = l_sub_sql , " SELECT xccc002 xckl010,xccc006 xckl007,xccc007 xckl008,xccc008 xckl009, ' ' xckl006 , ",    
                                        "        0 xckl101,0 xckl102,                                                          ",
                                        "        0 xckl102a,0 xckl102b,0 xckl102c,0 xckl102d,                                  ",
                                        "        0 xckl102e,0 xckl102f,0 xckl102g,0 xckl102h,                                  ",
                                        "        SUM((CASE WHEN xccc901 IS NULL THEN 0 ELSE xccc901 END)) xckl103, ",            
                                        "        SUM((CASE WHEN xccc902 IS NULL THEN 0 ELSE xccc902 END)) xckl104, ",
                                        "        SUM((CASE WHEN xccc902a IS NULL THEN 0 ELSE xccc902a END)) xckl104a,",
                                        "        SUM((CASE WHEN xccc902b IS NULL THEN 0 ELSE xccc902b END)) xckl104b,",
                                        "        SUM((CASE WHEN xccc902c IS NULL THEN 0 ELSE xccc902c END)) xckl104c,",
                                        "        SUM((CASE WHEN xccc902d IS NULL THEN 0 ELSE xccc902d END)) xckl104d, ",
                                        "        SUM((CASE WHEN xccc902e IS NULL THEN 0 ELSE xccc902e END)) xckl104e,",
                                        "        SUM((CASE WHEN xccc902f IS NULL THEN 0 ELSE xccc902f END)) xckl104f, ",
                                        "        SUM((CASE WHEN xccc902g IS NULL THEN 0 ELSE xccc902g END)) xckl104g,",
                                        "        SUM((CASE WHEN xccc902h IS NULL THEN 0 ELSE xccc902h END)) xckl104h  ",
                                        "   FROM xccc_t  ",
                                        "  WHERE xcccent = ",g_enterprise,
                                        "    AND xcccld = '",g_master.xckkld,"' ",
                                        "    AND xccccomp = '",g_master.xckkcomp,"' ",
                                        "    AND xccc001 = '",g_master.xckk001,"' ",
                                        "    AND xccc003 = '",g_master.xckk002,"' ",
                                        "    AND xccc004 = ",g_previous_xckk003,
                                        "    AND xccc005 = ",g_previous_xckk004,
                                        "   GROUP BY xccc002,xccc006,xccc007,xccc008   "
         ELSE      
            LET l_sub_sql = l_sub_sql , " SELECT xcca002 xckl010,xcca006 xckl007,xcca007 xckl008,xcca008 xckl009, ' ' xckl006 , ",    
                                        "        0 xckl101,0 xckl102,                                                          ",
                                        "        0 xckl102a,0 xckl102b,0 xckl102c,0 xckl102d,                                  ",
                                        "        0 xckl102e,0 xckl102f,0 xckl102g,0 xckl102h,                                  ",
                                        "        SUM((CASE WHEN xcca101  IS NULL THEN 0 ELSE xcca101  END)) xckl103,  ",
                                        "        SUM((CASE WHEN xcca102  IS NULL THEN 0 ELSE xcca102  END)) xckl104,  ",
                                        "        SUM((CASE WHEN xcca102a IS NULL THEN 0 ELSE xcca102a END)) xckl104a, ",
                                        "        SUM((CASE WHEN xcca102b IS NULL THEN 0 ELSE xcca102b END)) xckl104b, ", 
                                        "        SUM((CASE WHEN xcca102c IS NULL THEN 0 ELSE xcca102c END)) xckl104c, ",
                                        "        SUM((CASE WHEN xcca102d IS NULL THEN 0 ELSE xcca102d END)) xckl104d, ", 
                                        "        SUM((CASE WHEN xcca102e IS NULL THEN 0 ELSE xcca102e END)) xckl104e, ",
                                        "        SUM((CASE WHEN xcca102f IS NULL THEN 0 ELSE xcca102f END)) xckl104f, ", 
                                        "        SUM((CASE WHEN xcca102g IS NULL THEN 0 ELSE xcca102g END)) xckl104g, ",
                                        "        SUM((CASE WHEN xcca102h IS NULL THEN 0 ELSE xcca102h END)) xckl104h  ",
                                        "   FROM xcca_t              ",
                                        "  WHERE xccaent = ",g_enterprise,
                                        "    AND xccald = '",g_master.xckkld,"' ",
                                        "    AND xccacomp = '",g_master.xckkcomp,"' ",
                                        "    AND xcca001 = '",g_master.xckk001,"' ",
                                        "    AND xcca003 = '",g_master.xckk002,"' ",
                                        "    AND xcca004 = ",g_previous_xckk003,
                                        "    AND xcca005 = ",g_previous_xckk004,
                                        "  GROUP BY xcca002,xcca006,xcca007,xcca008 "
         END IF
         
         LET l_sql = l_sql_1 , l_sub_sql , l_sql_2
         PREPARE axcq603_ins_xckl_pb2 FROM l_sql
         DECLARE axcq603_ins_xckl_cs2 CURSOR FOR axcq603_ins_xckl_pb2
         EXECUTE axcq603_ins_xckl_cs2
         IF SQLCA.sqlcode  THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "axcq603_ins_xckl_cs2:"
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()                   
            LET r_success = FALSE
            RETURN r_success
         END IF    

      #总表抓xccc的本期采购入库数量和金额，明细表抓xcck的本期采购入库和仓退的数量和金额，并写入xckk；有差异的按料号+特性+批号+成本域找出差异并写入xckl
      WHEN '102'          #一般采购
         LET l_sub_sql = " SELECT xccc002 xckl010,xccc006 xckl007,xccc007 xckl008,xccc008 xckl009,' ' xckl006 ,",
                         "        SUM((CASE WHEN xccc201  IS NULL THEN 0 ELSE xccc201  END)) xckl101,   ",
                         "        SUM((CASE WHEN xccc202  IS NULL THEN 0 ELSE xccc202  END)) xckl102,   ",  
                         "        SUM((CASE WHEN xccc202a IS NULL THEN 0 ELSE xccc202a END)) xckl102a,",
                         "        SUM((CASE WHEN xccc202b IS NULL THEN 0 ELSE xccc202b END)) xckl102b,", 
                         "        SUM((CASE WHEN xccc202c IS NULL THEN 0 ELSE xccc202c END)) xckl102c,",
                         "        SUM((CASE WHEN xccc202d IS NULL THEN 0 ELSE xccc202d END)) xckl102d,",   
                         "        SUM((CASE WHEN xccc202e IS NULL THEN 0 ELSE xccc202e END)) xckl102e,",
                         "        SUM((CASE WHEN xccc202f IS NULL THEN 0 ELSE xccc202f END)) xckl102f,", 
                         "        SUM((CASE WHEN xccc202g IS NULL THEN 0 ELSE xccc202g END)) xckl102g,",
                         "        SUM((CASE WHEN xccc202h IS NULL THEN 0 ELSE xccc202h END)) xckl102h,",
                         "        0 xckl103,0 xckl104,                         ",
                         "        0 xckl104a,0 xckl104b,0 xckl104c,0 xckl104d, ",
                         "        0 xckl104e,0 xckl104f,0 xckl104g,0 xckl104h  ",
                         "   FROM xccc_t  ",
                         "  WHERE xcccent = ",g_enterprise,
                         "    AND xcccld = '",g_master.xckkld,"' ",
                         "    AND xccccomp = '",g_master.xckkcomp,"' ",
                         "    AND xccc001 = '",g_master.xckk001,"' ",
                         "    AND xccc003 = '",g_master.xckk002,"' ",
                         "    AND xccc004 = ",g_master.xckk003,
                         "    AND xccc005 = ",g_master.xckk004,
                         "   GROUP BY xccc002,xccc006,xccc007,xccc008   ",
                         "  UNION ",
                         " SELECT xcck002 xckl010,xcck010 xckl007,xcck011 xckl008,xcck017 xckl009, ' ' xckl006 ,",    
                         "        0 xckl101,0 xckl102,                                                          ",
                         "        0 xckl102a,0 xckl102b,0 xckl102c,0 xckl102d,                                  ",
                         "        0 xckl102e,0 xckl102f,0 xckl102g,0 xckl102h,                                  ",
                         "        SUM((CASE WHEN xcck201  IS NULL THEN 0 ELSE xcck201  END)* xcck009) xckl103,  ",
                         "        SUM((CASE WHEN xcck202  IS NULL THEN 0 ELSE xcck202  END)*xcck009)  xckl104,  ",
                         "        SUM((CASE WHEN xcck202a IS NULL THEN 0 ELSE xcck202a END)* xcck009) xckl104a, ",
                         "        SUM((CASE WHEN xcck202b IS NULL THEN 0 ELSE xcck202b END)*xcck009)  xckl104b, ", 
                         "        SUM((CASE WHEN xcck202c IS NULL THEN 0 ELSE xcck202c END)* xcck009) xckl104c, ",
                         "        SUM((CASE WHEN xcck202d IS NULL THEN 0 ELSE xcck202d END)*xcck009)  xckl104d, ", 
                         "        SUM((CASE WHEN xcck202e IS NULL THEN 0 ELSE xcck202e END)* xcck009) xckl104e, ",
                         "        SUM((CASE WHEN xcck202f IS NULL THEN 0 ELSE xcck202f END)*xcck009)  xckl104f, ", 
                         "        SUM((CASE WHEN xcck202g IS NULL THEN 0 ELSE xcck202g END)* xcck009) xckl104g, ",
                         "        SUM((CASE WHEN xcck202h IS NULL THEN 0 ELSE xcck202h END)*xcck009)  xckl104h  ",
                         "   FROM xcck_t              ",
                         "  WHERE xcckent = ",g_enterprise,
                         "    AND xcckld = '",g_master.xckkld,"' ",
                         "    AND xcckcomp = '",g_master.xckkcomp,"' ",
                         "    AND xcck001 = '",g_master.xckk001,"' ",
                         "    AND xcck003 = '",g_master.xckk002,"' ",
                         "    AND xcck004 = ",g_master.xckk003,
                         "    AND xcck005 = ",g_master.xckk004,
                         "    AND xcck055 LIKE '201%' ",
                         "  GROUP BY xcck002,xcck010,xcck011,xcck017   "
         LET l_sql = l_sql_1 , l_sub_sql , l_sql_2
         PREPARE axcq603_ins_xckl_pb3 FROM l_sql
         DECLARE axcq603_ins_xckl_cs3 CURSOR FOR axcq603_ins_xckl_pb3
         EXECUTE axcq603_ins_xckl_cs3
         IF SQLCA.sqlcode  THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "axcq603_ins_xckl_cs3:"
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()                   
            LET r_success = FALSE
            RETURN r_success
         END IF    
   
      #总表抓xccc的本期委外入库数量和金额，明细表抓xcck的本期委外入库的数量和金额，并写入xckk；有差异的按料号+特性+批号+成本域找出差异并写入xckl
      WHEN '117'          #委外入库
         LET l_sub_sql = " SELECT xccc002 xckl010,xccc006 xckl007,xccc007 xckl008,xccc008 xckl009,' ' xckl006 ,",
                         "        SUM((CASE WHEN xccc203  IS NULL THEN 0 ELSE xccc203  END)) xckl101,   ",
                         "        SUM((CASE WHEN xccc204  IS NULL THEN 0 ELSE xccc204  END)) xckl102,   ",  
                         "        SUM((CASE WHEN xccc204a IS NULL THEN 0 ELSE xccc204a END)) xckl102a,",
                         "        SUM((CASE WHEN xccc204b IS NULL THEN 0 ELSE xccc204b END)) xckl102b,", 
                         "        SUM((CASE WHEN xccc204c IS NULL THEN 0 ELSE xccc204c END)) xckl102c,",
                         "        SUM((CASE WHEN xccc204d IS NULL THEN 0 ELSE xccc204d END)) xckl102d,",   
                         "        SUM((CASE WHEN xccc204e IS NULL THEN 0 ELSE xccc204e END)) xckl102e,",
                         "        SUM((CASE WHEN xccc204f IS NULL THEN 0 ELSE xccc204f END)) xckl102f,", 
                         "        SUM((CASE WHEN xccc204g IS NULL THEN 0 ELSE xccc204g END)) xckl102g,",
                         "        SUM((CASE WHEN xccc204h IS NULL THEN 0 ELSE xccc204h END)) xckl102h,",
                         "        0 xckl103,0 xckl104,                         ",
                         "        0 xckl104a,0 xckl104b,0 xckl104c,0 xckl104d, ",
                         "        0 xckl104e,0 xckl104f,0 xckl104g,0 xckl104h  ",
                         "   FROM xccc_t  ",
                         "  WHERE xcccent = ",g_enterprise,
                         "    AND xcccld = '",g_master.xckkld,"' ",
                         "    AND xccccomp = '",g_master.xckkcomp,"' ",
                         "    AND xccc001 = '",g_master.xckk001,"' ",
                         "    AND xccc003 = '",g_master.xckk002,"' ",
                         "    AND xccc004 = ",g_master.xckk003,
                         "    AND xccc005 = ",g_master.xckk004,
                         "   GROUP BY xccc002,xccc006,xccc007,xccc008   ",
                         "  UNION ",
                         " SELECT xcck002 xckl010,xcck010 xckl007,xcck011 xckl008,xcck017 xckl009, ' ' xckl006 ,",    
                         "        0 xckl101,0 xckl102,                                                          ",
                         "        0 xckl102a,0 xckl102b,0 xckl102c,0 xckl102d,                                  ",
                         "        0 xckl102e,0 xckl102f,0 xckl102g,0 xckl102h,                                  ",
                         "        SUM((CASE WHEN xcck201  IS NULL THEN 0 ELSE xcck201  END)* xcck009) xckl103,  ",
                         "        SUM((CASE WHEN xcck202  IS NULL THEN 0 ELSE xcck202  END)*xcck009)  xckl104,  ",
                         "        SUM((CASE WHEN xcck202a IS NULL THEN 0 ELSE xcck202a END)* xcck009) xckl104a, ",
                         "        SUM((CASE WHEN xcck202b IS NULL THEN 0 ELSE xcck202b END)*xcck009)  xckl104b, ", 
                         "        SUM((CASE WHEN xcck202c IS NULL THEN 0 ELSE xcck202c END)* xcck009) xckl104c, ",
                         "        SUM((CASE WHEN xcck202d IS NULL THEN 0 ELSE xcck202d END)*xcck009)  xckl104d, ", 
                         "        SUM((CASE WHEN xcck202e IS NULL THEN 0 ELSE xcck202e END)* xcck009) xckl104e, ",
                         "        SUM((CASE WHEN xcck202f IS NULL THEN 0 ELSE xcck202f END)*xcck009)  xckl104f, ", 
                         "        SUM((CASE WHEN xcck202g IS NULL THEN 0 ELSE xcck202g END)* xcck009) xckl104g, ",
                         "        SUM((CASE WHEN xcck202h IS NULL THEN 0 ELSE xcck202h END)*xcck009)  xckl104h  ",
                         "   FROM xcck_t              ",
                         "  WHERE xcckent = ",g_enterprise,
                         "    AND xcckld = '",g_master.xckkld,"' ",
                         "    AND xcckcomp = '",g_master.xckkcomp,"' ",
                         "    AND xcck001 = '",g_master.xckk001,"' ",
                         "    AND xcck003 = '",g_master.xckk002,"' ",
                         "    AND xcck004 = ",g_master.xckk003,
                         "    AND xcck005 = ",g_master.xckk004,
                         "    AND xcck055 IN ('203','2030') ",  ##采购入库(采购入库、采购仓退) 
                         "  GROUP BY xcck002,xcck010,xcck011,xcck017   "
         LET l_sql = l_sql_1 , l_sub_sql , l_sql_2
         PREPARE axcq603_ins_xckl_pb4 FROM l_sql
         DECLARE axcq603_ins_xckl_cs4 CURSOR FOR axcq603_ins_xckl_pb4
         EXECUTE axcq603_ins_xckl_cs4
         IF SQLCA.sqlcode  THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "axcq603_ins_xckl_cs4:"
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()                   
            LET r_success = FALSE
            RETURN r_success
         END IF    
   
      #总表抓xccc的本期一般工单入库数量和金额，明细表抓xcck的本期一般工单入库的数量和金额，并写入xckk；有差异的按料号+特性+批号+成本域找出差异并写入xckl
      WHEN '105'          #工单入库
         LET l_sub_sql = " SELECT xccc002 xckl010,xccc006 xckl007,xccc007 xckl008,xccc008 xckl009,' ' xckl006 ,",
                         "        SUM((CASE WHEN xccc205  IS NULL THEN 0 ELSE xccc205  END)) xckl101,   ",
                         "        SUM((CASE WHEN xccc206  IS NULL THEN 0 ELSE xccc206  END)) xckl102,   ",  
                         "        SUM((CASE WHEN xccc206a IS NULL THEN 0 ELSE xccc206a END)) xckl102a,",
                         "        SUM((CASE WHEN xccc206b IS NULL THEN 0 ELSE xccc206b END)) xckl102b,", 
                         "        SUM((CASE WHEN xccc206c IS NULL THEN 0 ELSE xccc206c END)) xckl102c,",
                         "        SUM((CASE WHEN xccc206d IS NULL THEN 0 ELSE xccc206d END)) xckl102d,",   
                         "        SUM((CASE WHEN xccc206e IS NULL THEN 0 ELSE xccc206e END)) xckl102e,",
                         "        SUM((CASE WHEN xccc206f IS NULL THEN 0 ELSE xccc206f END)) xckl102f,", 
                         "        SUM((CASE WHEN xccc206g IS NULL THEN 0 ELSE xccc206g END)) xckl102g,",
                         "        SUM((CASE WHEN xccc206h IS NULL THEN 0 ELSE xccc206h END)) xckl102h,",
                         "        0 xckl103,0 xckl104,                         ",
                         "        0 xckl104a,0 xckl104b,0 xckl104c,0 xckl104d, ",
                         "        0 xckl104e,0 xckl104f,0 xckl104g,0 xckl104h  ",
                         "   FROM xccc_t  ",
                         "  WHERE xcccent = ",g_enterprise,
                         "    AND xcccld = '",g_master.xckkld,"' ",
                         "    AND xccccomp = '",g_master.xckkcomp,"' ",
                         "    AND xccc001 = '",g_master.xckk001,"' ",
                         "    AND xccc003 = '",g_master.xckk002,"' ",
                         "    AND xccc004 = ",g_master.xckk003,
                         "    AND xccc005 = ",g_master.xckk004,
                         "   GROUP BY xccc002,xccc006,xccc007,xccc008   ",
                         "  UNION ",
                         " SELECT xcck002 xckl010,xcck010 xckl007,xcck011 xckl008,xcck017 xckl009,' ' xckl006 ,",    
                         "        0 xckl101,0 xckl102,                                                          ",
                         "        0 xckl102a,0 xckl102b,0 xckl102c,0 xckl102d,                                  ",
                         "        0 xckl102e,0 xckl102f,0 xckl102g,0 xckl102h,                                  ",
                         "        SUM((CASE WHEN xcck201  IS NULL THEN 0 ELSE xcck201  END)* xcck009) xckl103,  ",
                         "        SUM((CASE WHEN xcck202  IS NULL THEN 0 ELSE xcck202  END)*xcck009)  xckl104,  ",
                         "        SUM((CASE WHEN xcck202a IS NULL THEN 0 ELSE xcck202a END)* xcck009) xckl104a, ",
                         "        SUM((CASE WHEN xcck202b IS NULL THEN 0 ELSE xcck202b END)*xcck009)  xckl104b, ", 
                         "        SUM((CASE WHEN xcck202c IS NULL THEN 0 ELSE xcck202c END)* xcck009) xckl104c, ",
                         "        SUM((CASE WHEN xcck202d IS NULL THEN 0 ELSE xcck202d END)*xcck009)  xckl104d, ", 
                         "        SUM((CASE WHEN xcck202e IS NULL THEN 0 ELSE xcck202e END)* xcck009) xckl104e, ",
                         "        SUM((CASE WHEN xcck202f IS NULL THEN 0 ELSE xcck202f END)*xcck009)  xckl104f, ", 
                         "        SUM((CASE WHEN xcck202g IS NULL THEN 0 ELSE xcck202g END)* xcck009) xckl104g, ",
                         "        SUM((CASE WHEN xcck202h IS NULL THEN 0 ELSE xcck202h END)*xcck009)  xckl104h  ",
                         "   FROM xcck_t              ",
                         "  WHERE xcckent = ",g_enterprise,
                         "    AND xcckld = '",g_master.xckkld,"' ",
                         "    AND xcckcomp = '",g_master.xckkcomp,"' ",
                         "    AND xcck001 = '",g_master.xckk001,"' ",
                         "    AND xcck003 = '",g_master.xckk002,"' ",
                         "    AND xcck004 = ",g_master.xckk003,
                         "    AND xcck005 = ",g_master.xckk004,
                         "    AND xcck055 IN ('205','2050') "  ,
                         "  GROUP BY xcck002,xcck010,xcck011,xcck017   "
         LET l_sql = l_sql_1 , l_sub_sql , l_sql_2
         PREPARE axcq603_ins_xckl_pb5 FROM l_sql
         DECLARE axcq603_ins_xckl_cs5 CURSOR FOR axcq603_ins_xckl_pb5
         EXECUTE axcq603_ins_xckl_cs5
         IF SQLCA.sqlcode  THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "axcq603_ins_xckl_cs5:"
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()                   
            LET r_success = FALSE
            RETURN r_success
         END IF

      #总表抓xccc的本期返工工单入库数量和金额，明细表抓xcck的本期返工工单入库的数量和金额，并写入xckk；有差异的按料号+特性+批号+成本域找出差异并写入xckl
      WHEN '115'          #返工入库
         LET l_sub_sql = " SELECT xccc002 xckl010,xccc006 xckl007,xccc007 xckl008,xccc008 xckl009,' ' xckl006 ,",
                         "        SUM((CASE WHEN xccc209  IS NULL THEN 0 ELSE xccc209  END)) xckl101,   ",
                         "        SUM((CASE WHEN xccc210  IS NULL THEN 0 ELSE xccc210  END)) xckl102,   ",  
                         "        SUM((CASE WHEN xccc210a IS NULL THEN 0 ELSE xccc210a END)) xckl102a,",
                         "        SUM((CASE WHEN xccc210b IS NULL THEN 0 ELSE xccc210b END)) xckl102b,", 
                         "        SUM((CASE WHEN xccc210c IS NULL THEN 0 ELSE xccc210c END)) xckl102c,",
                         "        SUM((CASE WHEN xccc210d IS NULL THEN 0 ELSE xccc210d END)) xckl102d,",   
                         "        SUM((CASE WHEN xccc210e IS NULL THEN 0 ELSE xccc210e END)) xckl102e,",
                         "        SUM((CASE WHEN xccc210f IS NULL THEN 0 ELSE xccc210f END)) xckl102f,", 
                         "        SUM((CASE WHEN xccc210g IS NULL THEN 0 ELSE xccc210g END)) xckl102g,",
                         "        SUM((CASE WHEN xccc210h IS NULL THEN 0 ELSE xccc210h END)) xckl102h,",
                         "        0 xckl103,0 xckl104,                         ",
                         "        0 xckl104a,0 xckl104b,0 xckl104c,0 xckl104d, ",
                         "        0 xckl104e,0 xckl104f,0 xckl104g,0 xckl104h  ",
                         "   FROM xccc_t  ",
                         "  WHERE xcccent = ",g_enterprise,
                         "    AND xcccld = '",g_master.xckkld,"' ",
                         "    AND xccccomp = '",g_master.xckkcomp,"' ",
                         "    AND xccc001 = '",g_master.xckk001,"' ",
                         "    AND xccc003 = '",g_master.xckk002,"' ",
                         "    AND xccc004 = ",g_master.xckk003,
                         "    AND xccc005 = ",g_master.xckk004,
                         "   GROUP BY xccc002,xccc006,xccc007,xccc008   ",
                         "  UNION ",
                         " SELECT xcck002 xckl010,xcck010 xckl007,xcck011 xckl008,xcck017 xckl009,' ' xckl006 ,",    
                         "        0 xckl101,0 xckl102,                                                          ",
                         "        0 xckl102a,0 xckl102b,0 xckl102c,0 xckl102d,                                  ",
                         "        0 xckl102e,0 xckl102f,0 xckl102g,0 xckl102h,                                  ",
                         "        SUM((CASE WHEN xcck201  IS NULL THEN 0 ELSE xcck201  END)* xcck009) xckl103,  ",
                         "        SUM((CASE WHEN xcck202  IS NULL THEN 0 ELSE xcck202  END)*xcck009)  xckl104,  ",
                         "        SUM((CASE WHEN xcck202a IS NULL THEN 0 ELSE xcck202a END)* xcck009) xckl104a, ",
                         "        SUM((CASE WHEN xcck202b IS NULL THEN 0 ELSE xcck202b END)*xcck009)  xckl104b, ", 
                         "        SUM((CASE WHEN xcck202c IS NULL THEN 0 ELSE xcck202c END)* xcck009) xckl104c, ",
                         "        SUM((CASE WHEN xcck202d IS NULL THEN 0 ELSE xcck202d END)*xcck009)  xckl104d, ", 
                         "        SUM((CASE WHEN xcck202e IS NULL THEN 0 ELSE xcck202e END)* xcck009) xckl104e, ",
                         "        SUM((CASE WHEN xcck202f IS NULL THEN 0 ELSE xcck202f END)*xcck009)  xckl104f, ", 
                         "        SUM((CASE WHEN xcck202g IS NULL THEN 0 ELSE xcck202g END)* xcck009) xckl104g, ",
                         "        SUM((CASE WHEN xcck202h IS NULL THEN 0 ELSE xcck202h END)*xcck009)  xckl104h  ",
                         "   FROM xcck_t              ",
                         "  WHERE xcckent = ",g_enterprise,
                         "    AND xcckld = '",g_master.xckkld,"' ",
                         "    AND xcckcomp = '",g_master.xckkcomp,"' ",
                         "    AND xcck001 = '",g_master.xckk001,"' ",
                         "    AND xcck003 = '",g_master.xckk002,"' ",
                         "    AND xcck004 = ",g_master.xckk003,
                         "    AND xcck005 = ",g_master.xckk004,
                         "    AND xcck055 IN ('209','2090') " , 
                         "  GROUP BY xcck002,xcck010,xcck011,xcck017   "
         LET l_sql = l_sql_1 , l_sub_sql , l_sql_2
         PREPARE axcq603_ins_xckl_pb6 FROM l_sql
         DECLARE axcq603_ins_xckl_cs6 CURSOR FOR axcq603_ins_xckl_pb6
         EXECUTE axcq603_ins_xckl_cs6
         IF SQLCA.sqlcode  THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "axcq603_ins_xckl_cs6:"
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()                   
            LET r_success = FALSE
            RETURN r_success
         END IF

      #总表抓xccc的本期杂项入库数量和金额，明细表抓xcck的本期杂项入库和仓退的数量和金额，并写入xckk；有差异的按料号+特性+批号+成本域找出差异并写入xckl
      WHEN '104'          #杂项入库
         LET l_sub_sql = " SELECT xccc002 xckl010,xccc006 xckl007,xccc007 xckl008,xccc008 xckl009,' ' xckl006 ,",
                         "        SUM((CASE WHEN xccc211  IS NULL THEN 0 ELSE xccc211  END)) xckl101,   ",
                         "        SUM((CASE WHEN xccc212  IS NULL THEN 0 ELSE xccc212  END)) xckl102,   ",  
                         "        SUM((CASE WHEN xccc212a IS NULL THEN 0 ELSE xccc212a END)) xckl102a,",
                         "        SUM((CASE WHEN xccc212b IS NULL THEN 0 ELSE xccc212b END)) xckl102b,", 
                         "        SUM((CASE WHEN xccc212c IS NULL THEN 0 ELSE xccc212c END)) xckl102c,",
                         "        SUM((CASE WHEN xccc212d IS NULL THEN 0 ELSE xccc212d END)) xckl102d,",   
                         "        SUM((CASE WHEN xccc212e IS NULL THEN 0 ELSE xccc212e END)) xckl102e,",
                         "        SUM((CASE WHEN xccc212f IS NULL THEN 0 ELSE xccc212f END)) xckl102f,", 
                         "        SUM((CASE WHEN xccc212g IS NULL THEN 0 ELSE xccc212g END)) xckl102g,",
                         "        SUM((CASE WHEN xccc212h IS NULL THEN 0 ELSE xccc212h END)) xckl102h,",
                         "        0 xckl103,0 xckl104,                         ",
                         "        0 xckl104a,0 xckl104b,0 xckl104c,0 xckl104d, ",
                         "        0 xckl104e,0 xckl104f,0 xckl104g,0 xckl104h  ",
                         "   FROM xccc_t  ",
                         "  WHERE xcccent = ",g_enterprise,
                         "    AND xcccld = '",g_master.xckkld,"' ",
                         "    AND xccccomp = '",g_master.xckkcomp,"' ",
                         "    AND xccc001 = '",g_master.xckk001,"' ",
                         "    AND xccc003 = '",g_master.xckk002,"' ",
                         "    AND xccc004 = ",g_master.xckk003,
                         "    AND xccc005 = ",g_master.xckk004,
                         "   GROUP BY xccc002,xccc006,xccc007,xccc008   ",
                         "  UNION ",
                         " SELECT xcck002 xckl010,xcck010 xckl007,xcck011 xckl008,xcck017 xckl009, ' ' xckl006 ,",    
                         "        0 xckl101,0 xckl102,                                                          ",
                         "        0 xckl102a,0 xckl102b,0 xckl102c,0 xckl102d,                                  ",
                         "        0 xckl102e,0 xckl102f,0 xckl102g,0 xckl102h,                                  ",
                         "        SUM((CASE WHEN xcck201  IS NULL THEN 0 ELSE xcck201  END)* xcck009) xckl103,  ",
                         "        SUM((CASE WHEN xcck202  IS NULL THEN 0 ELSE xcck202  END)*xcck009)  xckl104,  ",
                         "        SUM((CASE WHEN xcck202a IS NULL THEN 0 ELSE xcck202a END)* xcck009) xckl104a, ",
                         "        SUM((CASE WHEN xcck202b IS NULL THEN 0 ELSE xcck202b END)*xcck009)  xckl104b, ", 
                         "        SUM((CASE WHEN xcck202c IS NULL THEN 0 ELSE xcck202c END)* xcck009) xckl104c, ",
                         "        SUM((CASE WHEN xcck202d IS NULL THEN 0 ELSE xcck202d END)*xcck009)  xckl104d, ", 
                         "        SUM((CASE WHEN xcck202e IS NULL THEN 0 ELSE xcck202e END)* xcck009) xckl104e, ",
                         "        SUM((CASE WHEN xcck202f IS NULL THEN 0 ELSE xcck202f END)*xcck009)  xckl104f, ", 
                         "        SUM((CASE WHEN xcck202g IS NULL THEN 0 ELSE xcck202g END)* xcck009) xckl104g, ",
                         "        SUM((CASE WHEN xcck202h IS NULL THEN 0 ELSE xcck202h END)*xcck009)  xckl104h  ",
                         "   FROM xcck_t              ",
                         "  WHERE xcckent = ",g_enterprise,
                         "    AND xcckld = '",g_master.xckkld,"' ",
                         "    AND xcckcomp = '",g_master.xckkcomp,"' ",
                         "    AND xcck001 = '",g_master.xckk001,"' ",
                         "    AND xcck003 = '",g_master.xckk002,"' ",
                         "    AND xcck004 = ",g_master.xckk003,
                         "    AND xcck005 = ",g_master.xckk004,
                         "    AND xcck055 = '211'  " ,  #杂项入库(雜收入庫)
                         "  GROUP BY xcck002,xcck010,xcck011,xcck017   "
         LET l_sql = l_sql_1 , l_sub_sql , l_sql_2
         PREPARE axcq603_ins_xckl_pb7 FROM l_sql
         DECLARE axcq603_ins_xckl_cs7 CURSOR FOR axcq603_ins_xckl_pb7
         EXECUTE axcq603_ins_xckl_cs7
         IF SQLCA.sqlcode  THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "axcq603_ins_xckl_cs7:"
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()                   
            LET r_success = FALSE
            RETURN r_success
         END IF
   
      #总表抓xccc的本期调拨入库数量和金额，明细表抓xcck的本期调拨入库的数量和金额，并写入xckk；有差异的按料号+特性+批号+成本域找出差异并写入xckl
      WHEN '118'          #调拨入库
         LET l_sub_sql = " SELECT xccc002 xckl010,xccc006 xckl007,xccc007 xckl008,xccc008 xckl009,' ' xckl006 ,",
                         "        SUM((CASE WHEN xccc217  IS NULL THEN 0 ELSE xccc217  END)) xckl101,   ",
                         "        SUM((CASE WHEN xccc218  IS NULL THEN 0 ELSE xccc218  END)) xckl102,   ",  
                         "        SUM((CASE WHEN xccc218a IS NULL THEN 0 ELSE xccc218a END)) xckl102a,",
                         "        SUM((CASE WHEN xccc218b IS NULL THEN 0 ELSE xccc218b END)) xckl102b,", 
                         "        SUM((CASE WHEN xccc218c IS NULL THEN 0 ELSE xccc218c END)) xckl102c,",
                         "        SUM((CASE WHEN xccc218d IS NULL THEN 0 ELSE xccc218d END)) xckl102d,",   
                         "        SUM((CASE WHEN xccc218e IS NULL THEN 0 ELSE xccc218e END)) xckl102e,",
                         "        SUM((CASE WHEN xccc218f IS NULL THEN 0 ELSE xccc218f END)) xckl102f,", 
                         "        SUM((CASE WHEN xccc218g IS NULL THEN 0 ELSE xccc218g END)) xckl102g,",
                         "        SUM((CASE WHEN xccc218h IS NULL THEN 0 ELSE xccc218h END)) xckl102h,",
                         "        0 xckl103,0 xckl104,                         ",
                         "        0 xckl104a,0 xckl104b,0 xckl104c,0 xckl104d, ",
                         "        0 xckl104e,0 xckl104f,0 xckl104g,0 xckl104h  ",
                         "   FROM xccc_t  ",
                         "  WHERE xcccent = ",g_enterprise,
                         "    AND xcccld = '",g_master.xckkld,"' ",
                         "    AND xccccomp = '",g_master.xckkcomp,"' ",
                         "    AND xccc001 = '",g_master.xckk001,"' ",
                         "    AND xccc003 = '",g_master.xckk002,"' ",
                         "    AND xccc004 = ",g_master.xckk003,
                         "    AND xccc005 = ",g_master.xckk004,
                         "   GROUP BY xccc002,xccc006,xccc007,xccc008   ",
                         "  UNION ",
                         " SELECT xcck002 xckl010,xcck010 xckl007,xcck011 xckl008,xcck017 xckl009,' ' xckl006 ,",    
                         "        0 xckl101,0 xckl102,                                                          ",
                         "        0 xckl102a,0 xckl102b,0 xckl102c,0 xckl102d,                                  ",
                         "        0 xckl102e,0 xckl102f,0 xckl102g,0 xckl102h,                                  ",
                         "        SUM((CASE WHEN xcck201  IS NULL THEN 0 ELSE xcck201  END)* xcck009) xckl103,  ",
                         "        SUM((CASE WHEN xcck202  IS NULL THEN 0 ELSE xcck202  END)*xcck009)  xckl104,  ",
                         "        SUM((CASE WHEN xcck202a IS NULL THEN 0 ELSE xcck202a END)* xcck009) xckl104a, ",
                         "        SUM((CASE WHEN xcck202b IS NULL THEN 0 ELSE xcck202b END)*xcck009)  xckl104b, ", 
                         "        SUM((CASE WHEN xcck202c IS NULL THEN 0 ELSE xcck202c END)* xcck009) xckl104c, ",
                         "        SUM((CASE WHEN xcck202d IS NULL THEN 0 ELSE xcck202d END)*xcck009)  xckl104d, ", 
                         "        SUM((CASE WHEN xcck202e IS NULL THEN 0 ELSE xcck202e END)* xcck009) xckl104e, ",
                         "        SUM((CASE WHEN xcck202f IS NULL THEN 0 ELSE xcck202f END)*xcck009)  xckl104f, ", 
                         "        SUM((CASE WHEN xcck202g IS NULL THEN 0 ELSE xcck202g END)* xcck009) xckl104g, ",
                         "        SUM((CASE WHEN xcck202h IS NULL THEN 0 ELSE xcck202h END)*xcck009)  xckl104h  ",
                         "   FROM xcck_t              ",
                         "  WHERE xcckent = ",g_enterprise,
                         "    AND xcckld = '",g_master.xckkld,"' ",
                         "    AND xcckcomp = '",g_master.xckkcomp,"' ",
                         "    AND xcck001 = '",g_master.xckk001,"' ",
                         "    AND xcck003 = '",g_master.xckk002,"' ",
                         "    AND xcck004 = ",g_master.xckk003,
                         "    AND xcck005 = ",g_master.xckk004,
                         "    AND xcck055 IN ('217','3131') AND xcck020 = '401' ",
                         "  GROUP BY xcck002,xcck010,xcck011,xcck017   "
         LET l_sql = l_sql_1 , l_sub_sql , l_sql_2
         PREPARE axcq603_ins_xckl_pb8 FROM l_sql
         DECLARE axcq603_ins_xckl_cs8 CURSOR FOR axcq603_ins_xckl_pb8
         EXECUTE axcq603_ins_xckl_cs8
         IF SQLCA.sqlcode  THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "axcq603_ins_xckl_cs8:"
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()                   
            LET r_success = FALSE
            RETURN r_success
         END IF

      #总表抓xccc的本期销退成本的数量和金额，明细表根据aoos020中销退成本参数设定，抓xcck的本期销售退货的数量和金额，并写入xckk；有差异的按料号+特性+批号+成本域找出差异并写入xckl   
      WHEN '112'          #销退成本
         LET l_sub_sql = " SELECT xccc002 xckl010,xccc006 xckl007,xccc007 xckl008,xccc008 xckl009,' ' xckl006 ,",
                         "        SUM((CASE WHEN xccc215  IS NULL THEN 0 ELSE xccc215  END)) xckl101,   ",
                         "        SUM((CASE WHEN xccc216  IS NULL THEN 0 ELSE xccc216  END)) xckl102,   ",  
                         "        SUM((CASE WHEN xccc216a IS NULL THEN 0 ELSE xccc216a END)) xckl102a,",
                         "        SUM((CASE WHEN xccc216b IS NULL THEN 0 ELSE xccc216b END)) xckl102b,", 
                         "        SUM((CASE WHEN xccc216c IS NULL THEN 0 ELSE xccc216c END)) xckl102c,",
                         "        SUM((CASE WHEN xccc216d IS NULL THEN 0 ELSE xccc216d END)) xckl102d,",   
                         "        SUM((CASE WHEN xccc216e IS NULL THEN 0 ELSE xccc216e END)) xckl102e,",
                         "        SUM((CASE WHEN xccc216f IS NULL THEN 0 ELSE xccc216f END)) xckl102f,", 
                         "        SUM((CASE WHEN xccc216g IS NULL THEN 0 ELSE xccc216g END)) xckl102g,",
                         "        SUM((CASE WHEN xccc216h IS NULL THEN 0 ELSE xccc216h END)) xckl102h,",
                         "        0 xckl103,0 xckl104,                         ",
                         "        0 xckl104a,0 xckl104b,0 xckl104c,0 xckl104d, ",
                         "        0 xckl104e,0 xckl104f,0 xckl104g,0 xckl104h  ",
                         "   FROM xccc_t  ",
                         "  WHERE xcccent = ",g_enterprise,
                         "    AND xcccld = '",g_master.xckkld,"' ",
                         "    AND xccccomp = '",g_master.xckkcomp,"' ",
                         "    AND xccc001 = '",g_master.xckk001,"' ",
                         "    AND xccc003 = '",g_master.xckk002,"' ",
                         "    AND xccc004 = ",g_master.xckk003,
                         "    AND xccc005 = ",g_master.xckk004,
                         "   GROUP BY xccc002,xccc006,xccc007,xccc008   ",
                         "  UNION ",
                         " SELECT xcck002 xckl010,xcck010 xckl007,xcck011 xckl008,xcck017 xckl009,' ' xckl006 ,",    
                         "        0 xckl101,0 xckl102,                                                          ",
                         "        0 xckl102a,0 xckl102b,0 xckl102c,0 xckl102d,                                  ",
                         "        0 xckl102e,0 xckl102f,0 xckl102g,0 xckl102h,                                  ",
                         "        SUM((CASE WHEN xcck201  IS NULL THEN 0 ELSE xcck201  END)* xcck009) xckl103,  ",
                         "        SUM((CASE WHEN xcck202  IS NULL THEN 0 ELSE xcck202  END)*xcck009)  xckl104,  ",
                         "        SUM((CASE WHEN xcck202a IS NULL THEN 0 ELSE xcck202a END)* xcck009) xckl104a, ",
                         "        SUM((CASE WHEN xcck202b IS NULL THEN 0 ELSE xcck202b END)*xcck009)  xckl104b, ", 
                         "        SUM((CASE WHEN xcck202c IS NULL THEN 0 ELSE xcck202c END)* xcck009) xckl104c, ",
                         "        SUM((CASE WHEN xcck202d IS NULL THEN 0 ELSE xcck202d END)*xcck009)  xckl104d, ", 
                         "        SUM((CASE WHEN xcck202e IS NULL THEN 0 ELSE xcck202e END)* xcck009) xckl104e, ",
                         "        SUM((CASE WHEN xcck202f IS NULL THEN 0 ELSE xcck202f END)*xcck009)  xckl104f, ", 
                         "        SUM((CASE WHEN xcck202g IS NULL THEN 0 ELSE xcck202g END)* xcck009) xckl104g, ",
                         "        SUM((CASE WHEN xcck202h IS NULL THEN 0 ELSE xcck202h END)*xcck009)  xckl104h  ",
                         "   FROM xcck_t              ",
                         "  WHERE xcckent = ",g_enterprise,
                         "    AND xcckld = '",g_master.xckkld,"' ",
                         "    AND xcckcomp = '",g_master.xckkcomp,"' ",
                         "    AND xcck001 = '",g_master.xckk001,"' ",
                         "    AND xcck003 = '",g_master.xckk002,"' ",
                         "    AND xcck004 = ",g_master.xckk003,
                         "    AND xcck005 = ",g_master.xckk004,
                         "    AND xcck055 = '215'    ",
                         "  GROUP BY xcck002,xcck010,xcck011,xcck017   "
         LET l_sql = l_sql_1 , l_sub_sql , l_sql_2
         PREPARE axcq603_ins_xckl_pb9 FROM l_sql
         DECLARE axcq603_ins_xckl_cs9 CURSOR FOR axcq603_ins_xckl_pb9
         EXECUTE axcq603_ins_xckl_cs9
         IF SQLCA.sqlcode  THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "axcq603_ins_xckl_cs9:"
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()                   
            LET r_success = FALSE
            RETURN r_success
         END IF
   
      #总表抓xccc的本期入库调整的金额，明细表抓xcco的本期入库调整金额，并写入xckk；有差异的按料号+特性+批号+成本域找出差异并写入xckl
      WHEN '106'         #当站下线和入库调整 
         LET l_sub_sql = " SELECT xccc002 xckl010,xccc006 xckl007,xccc007 xckl008,xccc008 xckl009,' ' xckl006 ,",
                         "        SUM((CASE WHEN xccc213  IS NULL THEN 0 ELSE xccc213  END)) xckl101,   ",
                         "        SUM((CASE WHEN xccc214  IS NULL THEN 0 ELSE xccc214  END)) xckl102,   ",  
                         "        SUM((CASE WHEN xccc214a IS NULL THEN 0 ELSE xccc214a END)) xckl102a,",
                         "        SUM((CASE WHEN xccc214b IS NULL THEN 0 ELSE xccc214b END)) xckl102b,", 
                         "        SUM((CASE WHEN xccc214c IS NULL THEN 0 ELSE xccc214c END)) xckl102c,",
                         "        SUM((CASE WHEN xccc214d IS NULL THEN 0 ELSE xccc214d END)) xckl102d,",   
                         "        SUM((CASE WHEN xccc214e IS NULL THEN 0 ELSE xccc214e END)) xckl102e,",
                         "        SUM((CASE WHEN xccc214f IS NULL THEN 0 ELSE xccc214f END)) xckl102f,", 
                         "        SUM((CASE WHEN xccc214g IS NULL THEN 0 ELSE xccc214g END)) xckl102g,",
                         "        SUM((CASE WHEN xccc214h IS NULL THEN 0 ELSE xccc214h END)) xckl102h,",
                         "        0 xckl103,0 xckl104,                         ",
                         "        0 xckl104a,0 xckl104b,0 xckl104c,0 xckl104d, ",
                         "        0 xckl104e,0 xckl104f,0 xckl104g,0 xckl104h  ",
                         "   FROM xccc_t  ",
                         "  WHERE xcccent = ",g_enterprise,
                         "    AND xcccld = '",g_master.xckkld,"' ",
                         "    AND xccccomp = '",g_master.xckkcomp,"' ",
                         "    AND xccc001 = '",g_master.xckk001,"' ",
                         "    AND xccc003 = '",g_master.xckk002,"' ",
                         "    AND xccc004 = ",g_master.xckk003,
                         "    AND xccc005 = ",g_master.xckk004,
                         "   GROUP BY xccc002,xccc006,xccc007,xccc008   ",
                         "  UNION ",
                         " SELECT xcco002 xckl010,xcco006 xckl007,xcco007 xckl008,xcco008 xckl009,' ' xckl006 ,",    
                         "        0 xckl101,0 xckl102,                                                          ",
                         "        0 xckl102a,0 xckl102b,0 xckl102c,0 xckl102d,                                  ",
                         "        0 xckl102e,0 xckl102f,0 xckl102g,0 xckl102h,                                  ",
                         "        0 xckl103,  ",
                         "        SUM((CASE WHEN xcco102 IS NULL THEN 0  ELSE xcco102 END))  xckl104,  ",
                         "        SUM((CASE WHEN xcco102a IS NULL THEN 0 ELSE xcco102a END)) xckl104a, ",
                         "        SUM((CASE WHEN xcco102b IS NULL THEN 0 ELSE xcco102b END)) xckl104b, ", 
                         "        SUM((CASE WHEN xcco102c IS NULL THEN 0 ELSE xcco102c END)) xckl104c, ",
                         "        SUM((CASE WHEN xcco102d IS NULL THEN 0 ELSE xcco102d END)) xckl104d, ", 
                         "        SUM((CASE WHEN xcco102e IS NULL THEN 0 ELSE xcco102e END)) xckl104e, ",
                         "        SUM((CASE WHEN xcco102f IS NULL THEN 0 ELSE xcco102f END)) xckl104f, ", 
                         "        SUM((CASE WHEN xcco102g IS NULL THEN 0 ELSE xcco102g END)) xckl104g, ",
                         "        SUM((CASE WHEN xcco102h IS NULL THEN 0 ELSE xcco102h END)) xckl104h  ",
                         "   FROM xcco_t              ",
                         "  WHERE xccoent = ",g_enterprise,
                         "    AND xccold = '",g_master.xckkld,"' ",
                         "    AND xccocomp = '",g_master.xckkcomp,"' ",
                         "    AND xcco001 = '",g_master.xckk001,"' ",
                         "    AND xcco003 = '",g_master.xckk002,"' ",
                         "    AND xcco004 = ",g_master.xckk003,
                         "    AND xcco005 = ",g_master.xckk004,
                         "  GROUP BY xcco002,xcco006,xcco007,xcco008   "
         
         #当站下线是否影响成本，为Y时，加上当站下线的成本
         IF cl_get_para(g_enterprise,g_site,'S-FIN-6006') = 'Y' THEN
            LET l_sub_sql = l_sub_sql , "  UNION ",
                                        " SELECT xcck002 xckl010,xcck010 xckl007,xcck011 xckl008,xcck017 xckl009,' ' xckl006 , ",    
                                        "        0 xckl101,0 xckl102,                                                          ",
                                        "        0 xckl102a,0 xckl102b,0 xckl102c,0 xckl102d,                                  ",
                                        "        0 xckl102e,0 xckl102f,0 xckl102g,0 xckl102h,                                  ",
                                        "        SUM((CASE WHEN xcck201  IS NULL THEN 0 ELSE xcck201  END)* xcck009) xckl103,  ",
                                        "        SUM((CASE WHEN xcck202  IS NULL THEN 0 ELSE xcck202  END)*xcck009)  xckl104,  ",
                                        "        SUM((CASE WHEN xcck202a IS NULL THEN 0 ELSE xcck202a END)* xcck009) xckl104a, ",
                                        "        SUM((CASE WHEN xcck202b IS NULL THEN 0 ELSE xcck202b END)*xcck009)  xckl104b, ", 
                                        "        SUM((CASE WHEN xcck202c IS NULL THEN 0 ELSE xcck202c END)* xcck009) xckl104c, ",
                                        "        SUM((CASE WHEN xcck202d IS NULL THEN 0 ELSE xcck202d END)*xcck009)  xckl104d, ", 
                                        "        SUM((CASE WHEN xcck202e IS NULL THEN 0 ELSE xcck202e END)* xcck009) xckl104e, ",
                                        "        SUM((CASE WHEN xcck202f IS NULL THEN 0 ELSE xcck202f END)*xcck009)  xckl104f, ", 
                                        "        SUM((CASE WHEN xcck202g IS NULL THEN 0 ELSE xcck202g END)* xcck009) xckl104g, ",
                                        "        SUM((CASE WHEN xcck202h IS NULL THEN 0 ELSE xcck202h END)*xcck009)  xckl104h  ",
                                        "   FROM xcck_t              ",
                                        "  WHERE xcckent = ",g_enterprise,
                                        "    AND xcckld = '",g_master.xckkld,"' ",
                                        "    AND xcckcomp = '",g_master.xckkcomp,"' ",
                                        "    AND xcck001 = '",g_master.xckk001,"' ",
                                        "    AND xcck003 = '",g_master.xckk002,"' ",
                                        "    AND xcck004 = ",g_master.xckk003,
                                        "    AND xcck005 = ",g_master.xckk004,
                                        "    AND xcck055 = '213'  AND xcck020 = '115' ",   #115.當站下線 & S-FIN-6016 = 'Y'
                                        "  GROUP BY xcck002,xcck010,xcck011,xcck017   "
         END IF
         LET l_sql = l_sql_1 , l_sub_sql , l_sql_2
         PREPARE axcq603_ins_xckl_pb10 FROM l_sql
         DECLARE axcq603_ins_xckl_cs10 CURSOR FOR axcq603_ins_xckl_pb10
         EXECUTE axcq603_ins_xckl_cs10
         IF SQLCA.sqlcode  THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "axcq603_ins_xckl_cs10:"
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()                   
            LET r_success = FALSE
            RETURN r_success
         END IF
         
      #总表抓xccc的本期返工发料的数量和金额，明细表抓xcck的本期返工工单领用和退料的数量和金额，并写入xckk；有差异的按料号+特性+批号+成本域找出差异并写入xckl   
      WHEN '114'         #返工领出
        LET l_sub_sql = " SELECT xccc002 xckl010,xccc006 xckl007,xccc007 xckl008,xccc008 xckl009,' ' xckl006 ,",
                        "        SUM((CASE WHEN xccc207  IS NULL THEN 0 ELSE xccc207  END)) xckl101,   ",
                        "        SUM((CASE WHEN xccc208  IS NULL THEN 0 ELSE xccc208  END)) xckl102,   ",  
                        "        SUM((CASE WHEN xccc208a IS NULL THEN 0 ELSE xccc208a END)) xckl102a,",
                        "        SUM((CASE WHEN xccc208b IS NULL THEN 0 ELSE xccc208b END)) xckl102b,", 
                        "        SUM((CASE WHEN xccc208c IS NULL THEN 0 ELSE xccc208c END)) xckl102c,",
                        "        SUM((CASE WHEN xccc208d IS NULL THEN 0 ELSE xccc208d END)) xckl102d,",   
                        "        SUM((CASE WHEN xccc208e IS NULL THEN 0 ELSE xccc208e END)) xckl102e,",
                        "        SUM((CASE WHEN xccc208f IS NULL THEN 0 ELSE xccc208f END)) xckl102f,", 
                        "        SUM((CASE WHEN xccc208g IS NULL THEN 0 ELSE xccc208g END)) xckl102g,",
                        "        SUM((CASE WHEN xccc208h IS NULL THEN 0 ELSE xccc208h END)) xckl102h,",
                        "        0 xckl103,0 xckl104,                         ",
                        "        0 xckl104a,0 xckl104b,0 xckl104c,0 xckl104d, ",
                        "        0 xckl104e,0 xckl104f,0 xckl104g,0 xckl104h  ",
                        "   FROM xccc_t  ",
                        "  WHERE xcccent = ",g_enterprise,
                        "    AND xcccld = '",g_master.xckkld,"' ",
                        "    AND xccccomp = '",g_master.xckkcomp,"' ",
                        "    AND xccc001 = '",g_master.xckk001,"' ",
                        "    AND xccc003 = '",g_master.xckk002,"' ",
                        "    AND xccc004 = ",g_master.xckk003,
                        "    AND xccc005 = ",g_master.xckk004,
                        "   GROUP BY xccc002,xccc006,xccc007,xccc008   ",
                        "  UNION ",
                        " SELECT xcck002 xckl010,xcck010 xckl007,xcck011 xckl008,xcck017 xckl009, ' ' xckl006 ,",    
                        "        0 xckl101,0 xckl102,                                                          ",
                        "        0 xckl102a,0 xckl102b,0 xckl102c,0 xckl102d,                                  ",
                        "        0 xckl102e,0 xckl102f,0 xckl102g,0 xckl102h,                                  ",
                        "        SUM((CASE WHEN xcck201  IS NULL THEN 0 ELSE xcck201  END)* xcck009) xckl103,  ",
                        "        SUM((CASE WHEN xcck202  IS NULL THEN 0 ELSE xcck202  END)*xcck009)  xckl104,  ",
                        "        SUM((CASE WHEN xcck202a IS NULL THEN 0 ELSE xcck202a END)* xcck009) xckl104a, ",
                        "        SUM((CASE WHEN xcck202b IS NULL THEN 0 ELSE xcck202b END)*xcck009)  xckl104b, ", 
                        "        SUM((CASE WHEN xcck202c IS NULL THEN 0 ELSE xcck202c END)* xcck009) xckl104c, ",
                        "        SUM((CASE WHEN xcck202d IS NULL THEN 0 ELSE xcck202d END)*xcck009)  xckl104d, ", 
                        "        SUM((CASE WHEN xcck202e IS NULL THEN 0 ELSE xcck202e END)* xcck009) xckl104e, ",
                        "        SUM((CASE WHEN xcck202f IS NULL THEN 0 ELSE xcck202f END)*xcck009)  xckl104f, ", 
                        "        SUM((CASE WHEN xcck202g IS NULL THEN 0 ELSE xcck202g END)* xcck009) xckl104g, ",
                        "        SUM((CASE WHEN xcck202h IS NULL THEN 0 ELSE xcck202h END)*xcck009)  xckl104h  ",
                        "   FROM xcck_t              ",
                        "  WHERE xcckent = ",g_enterprise,
                        "    AND xcckld = '",g_master.xckkld,"' ",
                        "    AND xcckcomp = '",g_master.xckkcomp,"' ",
                        "    AND xcck001 = '",g_master.xckk001,"' ",
                        "    AND xcck003 = '",g_master.xckk002,"' ",
                        "    AND xcck004 = ",g_master.xckk003,
                        "    AND xcck005 = ",g_master.xckk004,
                        "    AND xcck055 = '207'    ", #重工领出(302.生產發料 & sfaa042 = 'Y' & 发料料号的成本阶 <= sfaa010的成本阶、303.生產退料 & sfaa042 = 'Y' & 发料料号的成本阶 <= sfaa010的成本阶)     
                        "  GROUP BY xcck002,xcck010,xcck011,xcck017   "
        LET l_sql = l_sql_1 , l_sub_sql , l_sql_2
        PREPARE axcq603_ins_xckl_pb11 FROM l_sql
        DECLARE axcq603_ins_xckl_cs11 CURSOR FOR axcq603_ins_xckl_pb11
        EXECUTE axcq603_ins_xckl_cs11
        IF SQLCA.sqlcode  THEN
           INITIALIZE g_errparam TO NULL 
           LET g_errparam.extend = "axcq603_ins_xckl_cs11:"
           LET g_errparam.code   = SQLCA.sqlcode 
           LET g_errparam.popup  = TRUE 
           CALL cl_err()                   
           LET r_success = FALSE
           RETURN r_success
        END IF
   
      #总表抓xccc的本期一般工单发料的数量和金额，明细表抓xcck的本期一般工单领用和退料的数量和金额，并写入xckk；有差异的按料号+特性+批号+成本域找出差异并写入xckl
      WHEN '107'         #工单发料
         LET l_sub_sql = " SELECT xccc002 xckl010,xccc006 xckl007,xccc007 xckl008,xccc008 xckl009, ' ' xckl006 ,",
                         "        SUM((CASE WHEN xccc301  IS NULL THEN 0 ELSE xccc301  END)) xckl101,   ",
                         "        SUM((CASE WHEN xccc302  IS NULL THEN 0 ELSE xccc302  END)) xckl102,   ",  
                         "        SUM((CASE WHEN xccc302a IS NULL THEN 0 ELSE xccc302a END)) xckl102a,",
                         "        SUM((CASE WHEN xccc302b IS NULL THEN 0 ELSE xccc302b END)) xckl102b,", 
                         "        SUM((CASE WHEN xccc302c IS NULL THEN 0 ELSE xccc302c END)) xckl102c,",
                         "        SUM((CASE WHEN xccc302d IS NULL THEN 0 ELSE xccc302d END)) xckl102d,",   
                         "        SUM((CASE WHEN xccc302e IS NULL THEN 0 ELSE xccc302e END)) xckl102e,",
                         "        SUM((CASE WHEN xccc302f IS NULL THEN 0 ELSE xccc302f END)) xckl102f,", 
                         "        SUM((CASE WHEN xccc302g IS NULL THEN 0 ELSE xccc302g END)) xckl102g,",
                         "        SUM((CASE WHEN xccc302h IS NULL THEN 0 ELSE xccc302h END)) xckl102h,",
                         "        0 xckl103,0 xckl104,                         ",
                         "        0 xckl104a,0 xckl104b,0 xckl104c,0 xckl104d, ",
                         "        0 xckl104e,0 xckl104f,0 xckl104g,0 xckl104h  ",
                         "   FROM xccc_t  ",
                         "  WHERE xcccent = ",g_enterprise,
                         "    AND xcccld = '",g_master.xckkld,"' ",
                         "    AND xccccomp = '",g_master.xckkcomp,"' ",
                         "    AND xccc001 = '",g_master.xckk001,"' ",
                         "    AND xccc003 = '",g_master.xckk002,"' ",
                         "    AND xccc004 = ",g_master.xckk003,
                         "    AND xccc005 = ",g_master.xckk004,
                         "   GROUP BY xccc002,xccc006,xccc007,xccc008   ",
                         "  UNION ",
                         " SELECT xcck002 xckl010,xcck010 xckl007,xcck011 xckl008,xcck017 xckl009, ' ' xckl006 ,",    
                         "        0 xckl101,0 xckl102,                                                          ",
                         "        0 xckl102a,0 xckl102b,0 xckl102c,0 xckl102d,                                  ",
                         "        0 xckl102e,0 xckl102f,0 xckl102g,0 xckl102h,                                  ",
                         "        SUM((CASE WHEN xcck201  IS NULL THEN 0 ELSE xcck201  END)* xcck009) xckl103,  ",
                         "        SUM((CASE WHEN xcck202  IS NULL THEN 0 ELSE xcck202  END)*xcck009)  xckl104,  ",
                         "        SUM((CASE WHEN xcck202a IS NULL THEN 0 ELSE xcck202a END)* xcck009) xckl104a, ",
                         "        SUM((CASE WHEN xcck202b IS NULL THEN 0 ELSE xcck202b END)*xcck009)  xckl104b, ", 
                         "        SUM((CASE WHEN xcck202c IS NULL THEN 0 ELSE xcck202c END)* xcck009) xckl104c, ",
                         "        SUM((CASE WHEN xcck202d IS NULL THEN 0 ELSE xcck202d END)*xcck009)  xckl104d, ", 
                         "        SUM((CASE WHEN xcck202e IS NULL THEN 0 ELSE xcck202e END)* xcck009) xckl104e, ",
                         "        SUM((CASE WHEN xcck202f IS NULL THEN 0 ELSE xcck202f END)*xcck009)  xckl104f, ", 
                         "        SUM((CASE WHEN xcck202g IS NULL THEN 0 ELSE xcck202g END)* xcck009) xckl104g, ",
                         "        SUM((CASE WHEN xcck202h IS NULL THEN 0 ELSE xcck202h END)*xcck009)  xckl104h  ",
                         "   FROM xcck_t              ",
                         "  WHERE xcckent = ",g_enterprise,
                         "    AND xcckld = '",g_master.xckkld,"' ",
                         "    AND xcckcomp = '",g_master.xckkcomp,"' ",
                         "    AND xcck001 = '",g_master.xckk001,"' ",
                         "    AND xcck003 = '",g_master.xckk002,"' ",
                         "    AND xcck004 = ",g_master.xckk003,
                         "    AND xcck005 = ",g_master.xckk004,
                         "    AND xcck055 IN ('301','3011','3012')   ", 
                         "  GROUP BY xcck002,xcck010,xcck011,xcck017   "
         LET l_sql = l_sql_1 , l_sub_sql , l_sql_2
         PREPARE axcq603_ins_xckl_pb12 FROM l_sql
         DECLARE axcq603_ins_xckl_cs12 CURSOR FOR axcq603_ins_xckl_pb12
         EXECUTE axcq603_ins_xckl_cs12
         IF SQLCA.sqlcode  THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "axcq603_ins_xckl_cs12:"
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()                   
            LET r_success = FALSE
            RETURN r_success
         END IF

      #总表抓xccc的本期杂项发料的数量和金额，明细表抓xcck的本期杂项发料的数量和金额，并写入xckk；有差异的按料号+特性+批号+成本域找出差异并写入xckl      
      WHEN '108'         #杂项发料
        LET l_sub_sql = " SELECT xccc002 xckl010,xccc006 xckl007,xccc007 xckl008,xccc008 xckl009,' ' xckl006 ,",
                        "        SUM((CASE WHEN xccc309  IS NULL THEN 0 ELSE xccc309  END)) xckl101,   ",
                        "        SUM((CASE WHEN xccc310  IS NULL THEN 0 ELSE xccc310  END)) xckl102,   ",  
                        "        SUM((CASE WHEN xccc310a IS NULL THEN 0 ELSE xccc310a END)) xckl102a,",
                        "        SUM((CASE WHEN xccc310b IS NULL THEN 0 ELSE xccc310b END)) xckl102b,", 
                        "        SUM((CASE WHEN xccc310c IS NULL THEN 0 ELSE xccc310c END)) xckl102c,",
                        "        SUM((CASE WHEN xccc310d IS NULL THEN 0 ELSE xccc310d END)) xckl102d,",   
                        "        SUM((CASE WHEN xccc310e IS NULL THEN 0 ELSE xccc310e END)) xckl102e,",
                        "        SUM((CASE WHEN xccc310f IS NULL THEN 0 ELSE xccc310f END)) xckl102f,", 
                        "        SUM((CASE WHEN xccc310g IS NULL THEN 0 ELSE xccc310g END)) xckl102g,",
                        "        SUM((CASE WHEN xccc310h IS NULL THEN 0 ELSE xccc310h END)) xckl102h,",
                        "        0 xckl103,0 xckl104,                         ",
                        "        0 xckl104a,0 xckl104b,0 xckl104c,0 xckl104d, ",
                        "        0 xckl104e,0 xckl104f,0 xckl104g,0 xckl104h  ",
                        "   FROM xccc_t  ",
                        "  WHERE xcccent = ",g_enterprise,
                        "    AND xcccld = '",g_master.xckkld,"' ",
                        "    AND xccccomp = '",g_master.xckkcomp,"' ",
                        "    AND xccc001 = '",g_master.xckk001,"' ",
                        "    AND xccc003 = '",g_master.xckk002,"' ",
                        "    AND xccc004 = ",g_master.xckk003,
                        "    AND xccc005 = ",g_master.xckk004,
                        "   GROUP BY xccc002,xccc006,xccc007,xccc008   ",
                        "  UNION ",
                        " SELECT xcck002 xckl010,xcck010 xckl007,xcck011 xckl008,xcck017 xckl009, ' ' xckl006 , ",    
                        "        0 xckl101,0 xckl102,                                                          ",
                        "        0 xckl102a,0 xckl102b,0 xckl102c,0 xckl102d,                                  ",
                        "        0 xckl102e,0 xckl102f,0 xckl102g,0 xckl102h,                                  ",
                        "        SUM((CASE WHEN xcck201  IS NULL THEN 0 ELSE xcck201  END)* xcck009) xckl103,  ",
                        "        SUM((CASE WHEN xcck202  IS NULL THEN 0 ELSE xcck202  END)*xcck009)  xckl104,  ",
                        "        SUM((CASE WHEN xcck202a IS NULL THEN 0 ELSE xcck202a END)* xcck009) xckl104a, ",
                        "        SUM((CASE WHEN xcck202b IS NULL THEN 0 ELSE xcck202b END)*xcck009)  xckl104b, ", 
                        "        SUM((CASE WHEN xcck202c IS NULL THEN 0 ELSE xcck202c END)* xcck009) xckl104c, ",
                        "        SUM((CASE WHEN xcck202d IS NULL THEN 0 ELSE xcck202d END)*xcck009)  xckl104d, ", 
                        "        SUM((CASE WHEN xcck202e IS NULL THEN 0 ELSE xcck202e END)* xcck009) xckl104e, ",
                        "        SUM((CASE WHEN xcck202f IS NULL THEN 0 ELSE xcck202f END)*xcck009)  xckl104f, ", 
                        "        SUM((CASE WHEN xcck202g IS NULL THEN 0 ELSE xcck202g END)* xcck009) xckl104g, ",
                        "        SUM((CASE WHEN xcck202h IS NULL THEN 0 ELSE xcck202h END)*xcck009)  xckl104h  ",
                        "   FROM xcck_t              ",
                        "  WHERE xcckent = ",g_enterprise,
                        "    AND xcckld = '",g_master.xckkld,"' ",
                        "    AND xcckcomp = '",g_master.xckkcomp,"' ",
                        "    AND xcck001 = '",g_master.xckk001,"' ",
                        "    AND xcck003 = '",g_master.xckk002,"' ",
                        "    AND xcck004 = ",g_master.xckk003,
                        "    AND xcck005 = ",g_master.xckk004,
                        "    AND xcck055 IN  ('309','3091','3092')   ", 
                        "  GROUP BY xcck002,xcck010,xcck011,xcck017   "
        LET l_sql = l_sql_1 , l_sub_sql , l_sql_2
        PREPARE axcq603_ins_xckl_pb13 FROM l_sql
        DECLARE axcq603_ins_xckl_cs13 CURSOR FOR axcq603_ins_xckl_pb13
        EXECUTE axcq603_ins_xckl_cs13
        IF SQLCA.sqlcode  THEN
           INITIALIZE g_errparam TO NULL 
           LET g_errparam.extend = "axcq603_ins_xckl_cs13:"
           LET g_errparam.code   = SQLCA.sqlcode 
           LET g_errparam.popup  = TRUE 
           CALL cl_err()                   
           LET r_success = FALSE
           RETURN r_success
        END IF

      #总表抓xccc的本期销售出货的数量和金额，明细表根据aoos020中销退成本参数设定，抓xcck的本期销售出货或退货或样品的数量和金额，并写入xckk；有差异的按料号+特性+批号+成本域找出差异并写入xckl  
      WHEN '110'         #销售出货
         LET l_sub_sql = " SELECT xccc002 xckl010,xccc006 xckl007,xccc007 xckl008,xccc008 xckl009,' ' xckl006 ,",
                         "        SUM((CASE WHEN xccc303  IS NULL THEN 0 ELSE xccc303  END)) xckl101,   ",
                         "        SUM((CASE WHEN xccc304  IS NULL THEN 0 ELSE xccc304  END)) xckl102,   ",  
                         "        SUM((CASE WHEN xccc304a IS NULL THEN 0 ELSE xccc304a END)) xckl102a,",
                         "        SUM((CASE WHEN xccc304b IS NULL THEN 0 ELSE xccc304b END)) xckl102b,", 
                         "        SUM((CASE WHEN xccc304c IS NULL THEN 0 ELSE xccc304c END)) xckl102c,",
                         "        SUM((CASE WHEN xccc304d IS NULL THEN 0 ELSE xccc304d END)) xckl102d,",   
                         "        SUM((CASE WHEN xccc304e IS NULL THEN 0 ELSE xccc304e END)) xckl102e,",
                         "        SUM((CASE WHEN xccc304f IS NULL THEN 0 ELSE xccc304f END)) xckl102f,", 
                         "        SUM((CASE WHEN xccc304g IS NULL THEN 0 ELSE xccc304g END)) xckl102g,",
                         "        SUM((CASE WHEN xccc304h IS NULL THEN 0 ELSE xccc304h END)) xckl102h,",
                         "        0 xckl103,0 xckl104,                         ",
                         "        0 xckl104a,0 xckl104b,0 xckl104c,0 xckl104d, ",
                         "        0 xckl104e,0 xckl104f,0 xckl104g,0 xckl104h  ",
                         "   FROM xccc_t  ",
                         "  WHERE xcccent = ",g_enterprise,
                         "    AND xcccld = '",g_master.xckkld,"' ",
                         "    AND xccccomp = '",g_master.xckkcomp,"' ",
                         "    AND xccc001 = '",g_master.xckk001,"' ",
                         "    AND xccc003 = '",g_master.xckk002,"' ",
                         "    AND xccc004 = ",g_master.xckk003,
                         "    AND xccc005 = ",g_master.xckk004,
                         "   GROUP BY xccc002,xccc006,xccc007,xccc008   ",
                         "  UNION ",
                         " SELECT xcck002 xckl010,xcck010 xckl007,xcck011 xckl008,xcck017 xckl009,' ' xckl006 ,",    
                         "        0 xckl101,0 xckl102,                                                          ",
                         "        0 xckl102a,0 xckl102b,0 xckl102c,0 xckl102d,                                  ",
                         "        0 xckl102e,0 xckl102f,0 xckl102g,0 xckl102h,                                  ",
                         "        SUM((CASE WHEN xcck201  IS NULL THEN 0 ELSE xcck201  END)* xcck009) xckl103,  ",
                         "        SUM((CASE WHEN xcck202  IS NULL THEN 0 ELSE xcck202  END)*xcck009)  xckl104,  ",
                         "        SUM((CASE WHEN xcck202a IS NULL THEN 0 ELSE xcck202a END)* xcck009) xckl104a, ",
                         "        SUM((CASE WHEN xcck202b IS NULL THEN 0 ELSE xcck202b END)*xcck009)  xckl104b, ", 
                         "        SUM((CASE WHEN xcck202c IS NULL THEN 0 ELSE xcck202c END)* xcck009) xckl104c, ",
                         "        SUM((CASE WHEN xcck202d IS NULL THEN 0 ELSE xcck202d END)*xcck009)  xckl104d, ", 
                         "        SUM((CASE WHEN xcck202e IS NULL THEN 0 ELSE xcck202e END)* xcck009) xckl104e, ",
                         "        SUM((CASE WHEN xcck202f IS NULL THEN 0 ELSE xcck202f END)*xcck009)  xckl104f, ", 
                         "        SUM((CASE WHEN xcck202g IS NULL THEN 0 ELSE xcck202g END)* xcck009) xckl104g, ",
                         "        SUM((CASE WHEN xcck202h IS NULL THEN 0 ELSE xcck202h END)*xcck009)  xckl104h  ",
                         "   FROM xcck_t              ",
                         "  WHERE xcckent = ",g_enterprise,
                         "    AND xcckld = '",g_master.xckkld,"' ",
                         "    AND xcckcomp = '",g_master.xckkcomp,"' ",
                         "    AND xcck001 = '",g_master.xckk001,"' ",
                         "    AND xcck003 = '",g_master.xckk002,"' ",
                         "    AND xcck004 = ",g_master.xckk003,
                         "    AND xcck005 = ",g_master.xckk004,
                         "    AND xcck055 IN ('303','305')   ", 
                         "  GROUP BY xcck002,xcck010,xcck011,xcck017   "
         LET l_sql = l_sql_1 , l_sub_sql , l_sql_2
         PREPARE axcq603_ins_xckl_pb14 FROM l_sql
         DECLARE axcq603_ins_xckl_cs14 CURSOR FOR axcq603_ins_xckl_pb14
         EXECUTE axcq603_ins_xckl_cs14
         IF SQLCA.sqlcode  THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "axcq603_ins_xckl_cs14:"
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()                   
            LET r_success = FALSE
            RETURN r_success
         END IF
   
      #总表抓xccc的本期销售费用的数量和金额
      WHEN '111'         #销售费用
         LET l_sub_sql = " SELECT xccc002 xckl010,xccc006 xckl007,xccc007 xckl008,xccc008 xckl009,' ' xckl006 ,",
                         "        SUM((CASE WHEN xccc307  IS NULL THEN 0 ELSE xccc307  END)) xckl101,   ",
                         "        SUM((CASE WHEN xccc308  IS NULL THEN 0 ELSE xccc308  END)) xckl102,   ",  
                         "        SUM((CASE WHEN xccc308a IS NULL THEN 0 ELSE xccc308a END)) xckl102a,",
                         "        SUM((CASE WHEN xccc308b IS NULL THEN 0 ELSE xccc308b END)) xckl102b,", 
                         "        SUM((CASE WHEN xccc308c IS NULL THEN 0 ELSE xccc308c END)) xckl102c,",
                         "        SUM((CASE WHEN xccc308d IS NULL THEN 0 ELSE xccc308d END)) xckl102d,",   
                         "        SUM((CASE WHEN xccc308e IS NULL THEN 0 ELSE xccc308e END)) xckl102e,",
                         "        SUM((CASE WHEN xccc308f IS NULL THEN 0 ELSE xccc308f END)) xckl102f,", 
                         "        SUM((CASE WHEN xccc308g IS NULL THEN 0 ELSE xccc308g END)) xckl102g,",
                         "        SUM((CASE WHEN xccc308h IS NULL THEN 0 ELSE xccc308h END)) xckl102h,",
                         "        0 xckl103,0 xckl104,                         ",
                         "        0 xckl104a,0 xckl104b,0 xckl104c,0 xckl104d, ",
                         "        0 xckl104e,0 xckl104f,0 xckl104g,0 xckl104h  ",
                         "   FROM xccc_t  ",
                         "  WHERE xcccent = ",g_enterprise,
                         "    AND xcccld = '",g_master.xckkld,"' ",
                         "    AND xccccomp = '",g_master.xckkcomp,"' ",
                         "    AND xccc001 = '",g_master.xckk001,"' ",
                         "    AND xccc003 = '",g_master.xckk002,"' ",
                         "    AND xccc004 = ",g_master.xckk003,
                         "    AND xccc005 = ",g_master.xckk004,
                         "   GROUP BY xccc002,xccc006,xccc007,xccc008   ",
                         "  UNION ",
                         " SELECT xcck002 xckl010,xcck010 xckl007,xcck011 xckl008,xcck017 xckl009, ' ' xckl006 , ",    
                         "        0 xckl101,0 xckl102,                                                          ",
                         "        0 xckl102a,0 xckl102b,0 xckl102c,0 xckl102d,                                  ",
                         "        0 xckl102e,0 xckl102f,0 xckl102g,0 xckl102h,                                  ",
                         "        SUM((CASE WHEN xcck201  IS NULL THEN 0 ELSE xcck201  END)* xcck009) xckl103,  ",
                         "        SUM((CASE WHEN xcck202  IS NULL THEN 0 ELSE xcck202  END)*xcck009)  xckl104,  ",
                         "        SUM((CASE WHEN xcck202a IS NULL THEN 0 ELSE xcck202a END)* xcck009) xckl104a, ",
                         "        SUM((CASE WHEN xcck202b IS NULL THEN 0 ELSE xcck202b END)*xcck009)  xckl104b, ", 
                         "        SUM((CASE WHEN xcck202c IS NULL THEN 0 ELSE xcck202c END)* xcck009) xckl104c, ",
                         "        SUM((CASE WHEN xcck202d IS NULL THEN 0 ELSE xcck202d END)*xcck009)  xckl104d, ", 
                         "        SUM((CASE WHEN xcck202e IS NULL THEN 0 ELSE xcck202e END)* xcck009) xckl104e, ",
                         "        SUM((CASE WHEN xcck202f IS NULL THEN 0 ELSE xcck202f END)*xcck009)  xckl104f, ", 
                         "        SUM((CASE WHEN xcck202g IS NULL THEN 0 ELSE xcck202g END)* xcck009) xckl104g, ",
                         "        SUM((CASE WHEN xcck202h IS NULL THEN 0 ELSE xcck202h END)*xcck009)  xckl104h  ",
                         "   FROM xcck_t              ",
                         "  WHERE xcckent = ",g_enterprise,
                         "    AND xcckld = '",g_master.xckkld,"' ",
                         "    AND xcckcomp = '",g_master.xckkcomp,"' ",
                         "    AND xcck001 = '",g_master.xckk001,"' ",
                         "    AND xcck003 = '",g_master.xckk002,"' ",
                         "    AND xcck004 = ",g_master.xckk003,
                         "    AND xcck005 = ",g_master.xckk004
         #S-FIN-6019 勾选的话是xccc中的销售出货就不含样品，样品的部分已经算到销售出货里面了，算销售费用时，需除去样品的费用
         IF cl_get_para(g_enterprise,g_site,'S-FIN-6019') THEN
            LET l_sub_sql = l_sub_sql , " AND (xcck055 = '307' AND xcck020 <> '201') "   #201.銷售出庫
         ELSE
            LET l_sub_sql = l_sub_sql , " AND xcck055 = '307'"   #201.銷售出庫 
         END IF                 
         LET l_sub_sql = l_sub_sql , "    AND xcck055 IN ('303','305')   ", 
                                     "  GROUP BY xcck002,xcck010,xcck011,xcck017   "
         LET l_sql = l_sql_1 , l_sub_sql , l_sql_2
         PREPARE axcq603_ins_xckl_pb15 FROM l_sql
         DECLARE axcq603_ins_xckl_cs15 CURSOR FOR axcq603_ins_xckl_pb15
         EXECUTE axcq603_ins_xckl_cs15
         IF SQLCA.sqlcode  THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "axcq603_ins_xckl_cs15:"
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()                   
            LET r_success = FALSE
            RETURN r_success
         END IF

      #总表抓xccc的本期盘盈亏的数量和金额，明细表抓xcck的本期盘盈亏的数量和金额，并写入xckk；有差异的按料号+特性+批号+成本域找出差异并写入xckl
      WHEN '109'         #盘盈亏
        LET l_sub_sql = " SELECT xccc002 xckl010,xccc006 xckl007,xccc007 xckl008,xccc008 xckl009,' ' xckl006 ,",
                        "        SUM((CASE WHEN xccc311  IS NULL THEN 0 ELSE xccc311  END)) xckl101,   ",
                        "        SUM((CASE WHEN xccc312  IS NULL THEN 0 ELSE xccc312  END)) xckl102,   ",  
                        "        SUM((CASE WHEN xccc312a IS NULL THEN 0 ELSE xccc312a END)) xckl102a,",
                        "        SUM((CASE WHEN xccc312b IS NULL THEN 0 ELSE xccc312b END)) xckl102b,", 
                        "        SUM((CASE WHEN xccc312c IS NULL THEN 0 ELSE xccc312c END)) xckl102c,",
                        "        SUM((CASE WHEN xccc312d IS NULL THEN 0 ELSE xccc312d END)) xckl102d,",   
                        "        SUM((CASE WHEN xccc312e IS NULL THEN 0 ELSE xccc312e END)) xckl102e,",
                        "        SUM((CASE WHEN xccc312f IS NULL THEN 0 ELSE xccc312f END)) xckl102f,", 
                        "        SUM((CASE WHEN xccc312g IS NULL THEN 0 ELSE xccc312g END)) xckl102g,",
                        "        SUM((CASE WHEN xccc312h IS NULL THEN 0 ELSE xccc312h END)) xckl102h,",
                        "        0 xckl103,0 xckl104,                         ",
                        "        0 xckl104a,0 xckl104b,0 xckl104c,0 xckl104d, ",
                        "        0 xckl104e,0 xckl104f,0 xckl104g,0 xckl104h  ",
                        "   FROM xccc_t  ",
                        "  WHERE xcccent = ",g_enterprise,
                        "    AND xcccld = '",g_master.xckkld,"' ",
                        "    AND xccccomp = '",g_master.xckkcomp,"' ",
                        "    AND xccc001 = '",g_master.xckk001,"' ",
                        "    AND xccc003 = '",g_master.xckk002,"' ",
                        "    AND xccc004 = ",g_master.xckk003,
                        "    AND xccc005 = ",g_master.xckk004,
                        "   GROUP BY xccc002,xccc006,xccc007,xccc008   ",
                        "  UNION ",
                        " SELECT xcck002 xckl010,xcck010 xckl007,xcck011 xckl008,xcck017 xckl009, ' ' xckl006 ,",    
                        "        0 xckl101,0 xckl102,                                                          ",
                        "        0 xckl102a,0 xckl102b,0 xckl102c,0 xckl102d,                                  ",
                        "        0 xckl102e,0 xckl102f,0 xckl102g,0 xckl102h,                                  ",
                        "        SUM((CASE WHEN xcck201  IS NULL THEN 0 ELSE xcck201  END)* xcck009) xckl103,  ",
                        "        SUM((CASE WHEN xcck202  IS NULL THEN 0 ELSE xcck202  END)*xcck009)  xckl104,  ",
                        "        SUM((CASE WHEN xcck202a IS NULL THEN 0 ELSE xcck202a END)* xcck009) xckl104a, ",
                        "        SUM((CASE WHEN xcck202b IS NULL THEN 0 ELSE xcck202b END)*xcck009)  xckl104b, ", 
                        "        SUM((CASE WHEN xcck202c IS NULL THEN 0 ELSE xcck202c END)* xcck009) xckl104c, ",
                        "        SUM((CASE WHEN xcck202d IS NULL THEN 0 ELSE xcck202d END)*xcck009)  xckl104d, ", 
                        "        SUM((CASE WHEN xcck202e IS NULL THEN 0 ELSE xcck202e END)* xcck009) xckl104e, ",
                        "        SUM((CASE WHEN xcck202f IS NULL THEN 0 ELSE xcck202f END)*xcck009)  xckl104f, ", 
                        "        SUM((CASE WHEN xcck202g IS NULL THEN 0 ELSE xcck202g END)* xcck009) xckl104g, ",
                        "        SUM((CASE WHEN xcck202h IS NULL THEN 0 ELSE xcck202h END)*xcck009)  xckl104h  ",
                        "   FROM xcck_t              ",
                        "  WHERE xcckent = ",g_enterprise,
                        "    AND xcckld = '",g_master.xckkld,"' ",
                        "    AND xcckcomp = '",g_master.xckkcomp,"' ",
                        "    AND xcck001 = '",g_master.xckk001,"' ",
                        "    AND xcck003 = '",g_master.xckk002,"' ",
                        "    AND xcck004 = ",g_master.xckk003,
                        "    AND xcck005 = ",g_master.xckk004,
                        "    AND xcck055 = '311'   ", 
                        "  GROUP BY xcck002,xcck010,xcck011,xcck017   "
        LET l_sql = l_sql_1 , l_sub_sql , l_sql_2
        PREPARE axcq603_ins_xckl_pb16 FROM l_sql
        DECLARE axcq603_ins_xckl_cs16 CURSOR FOR axcq603_ins_xckl_pb16
        EXECUTE axcq603_ins_xckl_cs16
        IF SQLCA.sqlcode  THEN
           INITIALIZE g_errparam TO NULL 
           LET g_errparam.extend = "axcq603_ins_xckl_cs16:"
           LET g_errparam.code   = SQLCA.sqlcode 
           LET g_errparam.popup  = TRUE 
           CALL cl_err()                   
           LET r_success = FALSE
           RETURN r_success
        END IF
   
      #总表抓xccc的本期调拨出库数量和金额，明细表抓xcck的本期调拨出库的数量和金额，并写入xckk；有差异的按料号+特性+批号+成本域找出差异并写入xckl
      WHEN '119'         #调拨出库
         LET l_sub_sql = " SELECT xccc002 xckl010,xccc006 xckl007,xccc007 xckl008,xccc008 xckl009,' ' xckl006 ,",
                         "        SUM((CASE WHEN xccc313  IS NULL THEN 0 ELSE xccc313  END)) xckl101,   ",
                         "        SUM((CASE WHEN xccc314  IS NULL THEN 0 ELSE xccc314  END)) xckl102,   ",  
                         "        SUM((CASE WHEN xccc314a IS NULL THEN 0 ELSE xccc314a END)) xckl102a,",
                         "        SUM((CASE WHEN xccc314b IS NULL THEN 0 ELSE xccc314b END)) xckl102b,", 
                         "        SUM((CASE WHEN xccc314c IS NULL THEN 0 ELSE xccc314c END)) xckl102c,",
                         "        SUM((CASE WHEN xccc314d IS NULL THEN 0 ELSE xccc314d END)) xckl102d,",   
                         "        SUM((CASE WHEN xccc314e IS NULL THEN 0 ELSE xccc314e END)) xckl102e,",
                         "        SUM((CASE WHEN xccc314f IS NULL THEN 0 ELSE xccc314f END)) xckl102f,", 
                         "        SUM((CASE WHEN xccc314g IS NULL THEN 0 ELSE xccc314g END)) xckl102g,",
                         "        SUM((CASE WHEN xccc314h IS NULL THEN 0 ELSE xccc314h END)) xckl102h,",
                         "        0 xckl103,0 xckl104,                         ",
                         "        0 xckl104a,0 xckl104b,0 xckl104c,0 xckl104d, ",
                         "        0 xckl104e,0 xckl104f,0 xckl104g,0 xckl104h  ",
                         "   FROM xccc_t  ",
                         "  WHERE xcccent = ",g_enterprise,
                         "    AND xcccld = '",g_master.xckkld,"' ",
                         "    AND xccccomp = '",g_master.xckkcomp,"' ",
                         "    AND xccc001 = '",g_master.xckk001,"' ",
                         "    AND xccc003 = '",g_master.xckk002,"' ",
                         "    AND xccc004 = ",g_master.xckk003,
                         "    AND xccc005 = ",g_master.xckk004,
                         "   GROUP BY xccc002,xccc006,xccc007,xccc008   ",
                         "  UNION ",
                         " SELECT xcck002 xckl010,xcck010 xckl007,xcck011 xckl008,xcck017 xckl009,' ' xckl006 , ",    
                         "        0 xckl101,0 xckl102,                                                          ",
                         "        0 xckl102a,0 xckl102b,0 xckl102c,0 xckl102d,                                  ",
                         "        0 xckl102e,0 xckl102f,0 xckl102g,0 xckl102h,                                  ",
                         "        SUM((CASE WHEN xcck201  IS NULL THEN 0 ELSE xcck201  END)* xcck009) xckl103,  ",
                         "        SUM((CASE WHEN xcck202  IS NULL THEN 0 ELSE xcck202  END)*xcck009)  xckl104,  ",
                         "        SUM((CASE WHEN xcck202a IS NULL THEN 0 ELSE xcck202a END)* xcck009) xckl104a, ",
                         "        SUM((CASE WHEN xcck202b IS NULL THEN 0 ELSE xcck202b END)*xcck009)  xckl104b, ", 
                         "        SUM((CASE WHEN xcck202c IS NULL THEN 0 ELSE xcck202c END)* xcck009) xckl104c, ",
                         "        SUM((CASE WHEN xcck202d IS NULL THEN 0 ELSE xcck202d END)*xcck009)  xckl104d, ", 
                         "        SUM((CASE WHEN xcck202e IS NULL THEN 0 ELSE xcck202e END)* xcck009) xckl104e, ",
                         "        SUM((CASE WHEN xcck202f IS NULL THEN 0 ELSE xcck202f END)*xcck009)  xckl104f, ", 
                         "        SUM((CASE WHEN xcck202g IS NULL THEN 0 ELSE xcck202g END)* xcck009) xckl104g, ",
                         "        SUM((CASE WHEN xcck202h IS NULL THEN 0 ELSE xcck202h END)*xcck009)  xckl104h  ",
                         "   FROM xcck_t              ",
                         "  WHERE xcckent = ",g_enterprise,
                         "    AND xcckld = '",g_master.xckkld,"' ",
                         "    AND xcckcomp = '",g_master.xckkcomp,"' ",
                         "    AND xcck001 = '",g_master.xckk001,"' ",
                         "    AND xcck003 = '",g_master.xckk002,"' ",
                         "    AND xcck004 = ",g_master.xckk003,
                         "    AND xcck005 = ",g_master.xckk004,
                         "    AND xcck055 = '3132'   ", 
                         "  GROUP BY xcck002,xcck010,xcck011,xcck017   "
         LET l_sql = l_sql_1 , l_sub_sql , l_sql_2
         PREPARE axcq603_ins_xckl_pb17 FROM l_sql
         DECLARE axcq603_ins_xckl_cs17 CURSOR FOR axcq603_ins_xckl_pb17
         EXECUTE axcq603_ins_xckl_cs17
         IF SQLCA.sqlcode  THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "axcq603_ins_xckl_cs17:"
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()                   
            LET r_success = FALSE
            RETURN r_success
         END IF
   
   
      #总表和明细表都从xccc中抓金额并写入xckk中，无差异需处理。
      WHEN '113'         #结存调整
      
      
      #总表和明细表都从xccc中抓金额并写入xckk中，无差异需处理。   
      WHEN '116'         #库存期末

      #总表抓xcce的非拆件工单的本期期初数量和金额，明细表抓上期的非拆件工单的xccb的数量和金额，并写入xckk；有差异的按在制单号(工单)找出差异并写入xckl
      WHEN '215'         #在制开账调整
         LET l_sub_sql = " SELECT xcce002 xckl010,xcce006 xckl006,xcce007 xckl007,xcce008 xckl008,xcce009 xckl009,",
                         "        SUM((CASE WHEN xcce101  IS NULL THEN 0 ELSE xcce101  END)) xckl101,   ",
                         "        SUM((CASE WHEN xcce102  IS NULL THEN 0 ELSE xcce102  END)) xckl102,   ",  
                         "        SUM((CASE WHEN xcce102a IS NULL THEN 0 ELSE xcce102a END)) xckl102a,",
                         "        SUM((CASE WHEN xcce102b IS NULL THEN 0 ELSE xcce102b END)) xckl102b,", 
                         "        SUM((CASE WHEN xcce102c IS NULL THEN 0 ELSE xcce102c END)) xckl102c,",
                         "        SUM((CASE WHEN xcce102d IS NULL THEN 0 ELSE xcce102d END)) xckl102d,",   
                         "        SUM((CASE WHEN xcce102e IS NULL THEN 0 ELSE xcce102e END)) xckl102e,",
                         "        SUM((CASE WHEN xcce102f IS NULL THEN 0 ELSE xcce102f END)) xckl102f,", 
                         "        SUM((CASE WHEN xcce102g IS NULL THEN 0 ELSE xcce102g END)) xckl102g,",
                         "        SUM((CASE WHEN xcce102h IS NULL THEN 0 ELSE xcce102h END)) xckl102h,",
                         "        0 xckl103,0 xckl104,                         ",
                         "        0 xckl104a,0 xckl104b,0 xckl104c,0 xckl104d, ",
                         "        0 xckl104e,0 xckl104f,0 xckl104g,0 xckl104h  ",
                         "   FROM xcce_t  ",
                         "  WHERE xcceent = ",g_enterprise,
                         "    AND xcceld = '",g_master.xckkld,"' ",
                         "    AND xccecomp = '",g_master.xckkcomp,"' ",
                         "    AND xcce001 = '",g_master.xckk001,"' ",
                         "    AND xcce003 = '",g_master.xckk002,"' ",
                         "    AND xcce004 = ",g_master.xckk003,
                         "    AND xcce005 = ",g_master.xckk004,
                         "   GROUP BY xcce002,xcce006,xcce007,xcce008,xcce009   ",
                         "  UNION "
         
         #明细表抓上期的xccb的数量和金额
         SELECT SUM((CASE WHEN xccb101 IS NULL THEN 0 ELSE xccb101 END)),  SUM((CASE WHEN xccb102 IS NULL THEN 0 ELSE xccb102 END)), 
                SUM((CASE WHEN xccb102a IS NULL THEN 0 ELSE xccb102a END)),SUM((CASE WHEN xccb102b IS NULL THEN 0 ELSE xccb102b END)),
                SUM((CASE WHEN xccb102c IS NULL THEN 0 ELSE xccb102c END)),SUM((CASE WHEN xccb102d IS NULL THEN 0 ELSE xccb102d END)),
                SUM((CASE WHEN xccb102e IS NULL THEN 0 ELSE xccb102e END)),SUM((CASE WHEN xccb102f IS NULL THEN 0 ELSE xccb102f END)),
                SUM((CASE WHEN xccb102g IS NULL THEN 0 ELSE xccb102g END)),SUM((CASE WHEN xccb102h IS NULL THEN 0 ELSE xccb102h END))
            INTO l_xckl.xckl103, l_xckl.xckl104, l_xckl.xckl104a,l_xckl.xckl104b,l_xckl.xckl104c,
                 l_xckl.xckl104d,l_xckl.xckl104e,l_xckl.xckl104f,l_xckl.xckl104g,l_xckl.xckl104h
         FROM xccb_t , sfaa_t    #160719-00012#1  
         WHERE xccbent = g_enterprise AND xccbld = g_master.xckkld AND xccbcomp = g_master.xckkcomp
           AND xccb001 = g_master.xckk001 AND xccb003 = g_master.xckk002 
           AND xccb004 = g_previous_xckk003 AND xccb005 = g_previous_xckk004
           AND xccbent = sfaaent AND xccb006 = sfaadocno AND sfaa003 <> '3'  #非拆件工单  #160719-00012#1  
         
         #抓不到抓上期的xcce的数据和金额
         IF (cl_null(l_xckl.xckl103)  OR l_xckl.xckl103 = 0) AND
            (cl_null(l_xckl.xckl104)  OR l_xckl.xckl104 = 0) AND
            (cl_null(l_xckl.xckl104a) OR l_xckl.xckl104a = 0) AND
            (cl_null(l_xckl.xckl104b) OR l_xckl.xckl104b = 0) AND
            (cl_null(l_xckl.xckl104c) OR l_xckl.xckl104c = 0) AND
            (cl_null(l_xckl.xckl104d) OR l_xckl.xckl104d = 0) AND
            (cl_null(l_xckl.xckl104e) OR l_xckl.xckl104e = 0) AND
            (cl_null(l_xckl.xckl104f) OR l_xckl.xckl104f = 0) AND
            (cl_null(l_xckl.xckl104g) OR l_xckl.xckl104g = 0) AND
            (cl_null(l_xckl.xckl104h) OR l_xckl.xckl104h = 0) THEN
            LET l_sub_sql = l_sub_sql , " SELECT xcce002 xckl010,xcce006 xckl006,xcce007 xckl007,xcce008 xckl008,xcce009 xckl009, ",    
                                        "        0 xckl101,0 xckl102,                                                          ",
                                        "        0 xckl102a,0 xckl102b,0 xckl102c,0 xckl102d,                                  ",
                                        "        0 xckl102e,0 xckl102f,0 xckl102g,0 xckl102h,                                  ",
                                        "        SUM((CASE WHEN xcce901 IS NULL THEN 0 ELSE  xcce901 END)) xckl103, ",            
                                        "        SUM((CASE WHEN xcce902 IS NULL THEN 0 ELSE  xcce902 END)) xckl104, ",
                                        "        SUM((CASE WHEN xcce902a IS NULL THEN 0 ELSE xcce902a END)) xckl104a,",
                                        "        SUM((CASE WHEN xcce902b IS NULL THEN 0 ELSE xcce902b END)) xckl104b,",
                                        "        SUM((CASE WHEN xcce902c IS NULL THEN 0 ELSE xcce902c END)) xckl104c,",
                                        "        SUM((CASE WHEN xcce902d IS NULL THEN 0 ELSE xcce902d END)) xckl104d, ",
                                        "        SUM((CASE WHEN xcce902e IS NULL THEN 0 ELSE xcce902e END)) xckl104e,",
                                        "        SUM((CASE WHEN xcce902f IS NULL THEN 0 ELSE xcce902f END)) xckl104f, ",
                                        "        SUM((CASE WHEN xcce902g IS NULL THEN 0 ELSE xcce902g END)) xckl104g,",
                                        "        SUM((CASE WHEN xcce902h IS NULL THEN 0 ELSE xcce902h END)) xckl104h  ",
                                        "   FROM xcce_t  ",
                                        "  WHERE xcceent = ",g_enterprise,
                                        "    AND xcceld = '",g_master.xckkld,"' ",
                                        "    AND xccecomp = '",g_master.xckkcomp,"' ",
                                        "    AND xcce001 = '",g_master.xckk001,"' ",
                                        "    AND xcce003 = '",g_master.xckk002,"' ",
                                        "    AND xcce004 = ",g_previous_xckk003,
                                        "    AND xcce005 = ",g_previous_xckk004,
                                        "   GROUP BY xcce002,xcce006,xcce007,xcce008,xcce009 "
         ELSE
            LET l_sub_sql = l_sub_sql , " SELECT xccb002 xckl010,xccb006 xckl006,xccb007 xckl007,xccb008 xckl008,xccb009 xckl009, ",    
                                        "        0 xckl101,0 xckl102,                                                          ",
                                        "        0 xckl102a,0 xckl102b,0 xckl102c,0 xckl102d,                                  ",
                                        "        0 xckl102e,0 xckl102f,0 xckl102g,0 xckl102h,                                  ",
                                        "        SUM((CASE WHEN xccb101  IS NULL THEN 0 ELSE xccb101  END)) xckl103,  ",
                                        "        SUM((CASE WHEN xccb102  IS NULL THEN 0 ELSE xccb102  END)) xckl104,  ",
                                        "        SUM((CASE WHEN xccb102a IS NULL THEN 0 ELSE xccb102a END)) xckl104a, ",
                                        "        SUM((CASE WHEN xccb102b IS NULL THEN 0 ELSE xccb102b END)) xckl104b, ", 
                                        "        SUM((CASE WHEN xccb102c IS NULL THEN 0 ELSE xccb102c END)) xckl104c, ",
                                        "        SUM((CASE WHEN xccb102d IS NULL THEN 0 ELSE xccb102d END)) xckl104d, ", 
                                        "        SUM((CASE WHEN xccb102e IS NULL THEN 0 ELSE xccb102e END)) xckl104e, ",
                                        "        SUM((CASE WHEN xccb102f IS NULL THEN 0 ELSE xccb102f END)) xckl104f, ", 
                                        "        SUM((CASE WHEN xccb102g IS NULL THEN 0 ELSE xccb102g END)) xckl104g, ",
                                        "        SUM((CASE WHEN xccb102h IS NULL THEN 0 ELSE xccb102h END)) xckl104h  ",
                                        "   FROM xccb_t, sfaa_t    ",
                                        "  WHERE xccbent = ",g_enterprise,
                                        "    AND xccbld = '",g_master.xckkld,"' ",
                                        "    AND xccbcomp = '",g_master.xckkcomp,"' ",
                                        "    AND xccb001 = '",g_master.xckk001,"' ",
                                        "    AND xccb003 = '",g_master.xckk002,"' ",
                                        "    AND xccb004 = ",g_previous_xckk003,
                                        "    AND xccb005 = ",g_previous_xckk004,
                                        "    AND xccbent = sfaaent AND xccb006 = sfaadocno AND sfaa003 <> '3' ",  #非拆件工单  #160719-00012#1  
                                        "  GROUP BY xccb002,xccb006,xccb007,xccb008,xccb009 "
         END IF 
         
         LET l_sql = l_sql_1 , l_sub_sql , l_sql_2
         PREPARE axcq603_ins_xckl_pb18 FROM l_sql
         DECLARE axcq603_ins_xckl_cs18 CURSOR FOR axcq603_ins_xckl_pb18
         EXECUTE axcq603_ins_xckl_cs18
         IF SQLCA.sqlcode  THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "axcq603_ins_xckl_cs18:"
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()                   
            LET r_success = FALSE
            RETURN r_success
         END IF
         
   
      #总表抓xcce的非拆件工单的本期期初数量和金额，明细表抓xcce的上期非拆件工单的期末数量和金额，抓不到抓上期的非拆件工单的xccb的数据和金额，并写入xckk；有差异的按在制单号(工单)找出差异并写入xckl
      WHEN '201'         #在制期初
         LET l_sub_sql = " SELECT xcce002 xckl010,xcce006 xckl006,xcce007 xckl007,xcce008 xckl008,xcce009 xckl009,",
                         "        SUM((CASE WHEN xcce101  IS NULL THEN 0 ELSE xcce101  END)) xckl101,   ",
                         "        SUM((CASE WHEN xcce102  IS NULL THEN 0 ELSE xcce102  END)) xckl102,   ",  
                         "        SUM((CASE WHEN xcce102a IS NULL THEN 0 ELSE xcce102a END)) xckl102a,",
                         "        SUM((CASE WHEN xcce102b IS NULL THEN 0 ELSE xcce102b END)) xckl102b,", 
                         "        SUM((CASE WHEN xcce102c IS NULL THEN 0 ELSE xcce102c END)) xckl102c,",
                         "        SUM((CASE WHEN xcce102d IS NULL THEN 0 ELSE xcce102d END)) xckl102d,",   
                         "        SUM((CASE WHEN xcce102e IS NULL THEN 0 ELSE xcce102e END)) xckl102e,",
                         "        SUM((CASE WHEN xcce102f IS NULL THEN 0 ELSE xcce102f END)) xckl102f,", 
                         "        SUM((CASE WHEN xcce102g IS NULL THEN 0 ELSE xcce102g END)) xckl102g,",
                         "        SUM((CASE WHEN xcce102h IS NULL THEN 0 ELSE xcce102h END)) xckl102h,",
                         "        0 xckl103,0 xckl104,                         ",
                         "        0 xckl104a,0 xckl104b,0 xckl104c,0 xckl104d, ",
                         "        0 xckl104e,0 xckl104f,0 xckl104g,0 xckl104h  ",
                         "   FROM xcce_t  ",
                         "  WHERE xcceent = ",g_enterprise,
                         "    AND xcceld = '",g_master.xckkld,"' ",
                         "    AND xccecomp = '",g_master.xckkcomp,"' ",
                         "    AND xcce001 = '",g_master.xckk001,"' ",
                         "    AND xcce003 = '",g_master.xckk002,"' ",
                         "    AND xcce004 = ",g_master.xckk003,
                         "    AND xcce005 = ",g_master.xckk004,
                         "   GROUP BY xcce002,xcce006,xcce007,xcce008,xcce009   ",
                         "  UNION "
         
         #明细表抓上期的xccb的数量和金额
         SELECT SUM((CASE WHEN xccb101 IS NULL THEN 0 ELSE xccb101 END)),  SUM((CASE WHEN xccb102 IS NULL THEN 0 ELSE xccb102 END)), 
                SUM((CASE WHEN xccb102a IS NULL THEN 0 ELSE xccb102a END)),SUM((CASE WHEN xccb102b IS NULL THEN 0 ELSE xccb102b END)),
                SUM((CASE WHEN xccb102c IS NULL THEN 0 ELSE xccb102c END)),SUM((CASE WHEN xccb102d IS NULL THEN 0 ELSE xccb102d END)),
                SUM((CASE WHEN xccb102e IS NULL THEN 0 ELSE xccb102e END)),SUM((CASE WHEN xccb102f IS NULL THEN 0 ELSE xccb102f END)),
                SUM((CASE WHEN xccb102g IS NULL THEN 0 ELSE xccb102g END)),SUM((CASE WHEN xccb102h IS NULL THEN 0 ELSE xccb102h END))
            INTO l_xckl.xckl103, l_xckl.xckl104, l_xckl.xckl104a,l_xckl.xckl104b,l_xckl.xckl104c,
                 l_xckl.xckl104d,l_xckl.xckl104e,l_xckl.xckl104f,l_xckl.xckl104g,l_xckl.xckl104h
         FROM xccb_t , sfaa_t    #160719-00012#1  
         WHERE xccbent = g_enterprise AND xccbld = g_master.xckkld AND xccbcomp = g_master.xckkcomp
           AND xccb001 = g_master.xckk001 AND xccb003 = g_master.xckk002 
           AND xccb004 = g_previous_xckk003 AND xccb005 = g_previous_xckk004
           AND xccbent = sfaaent AND xccb006 = sfaadocno AND sfaa003 <> '3'  #非拆件工单  #160719-00012#1  
         
         #抓不到抓上期的xcce的数据和金额
         IF (cl_null(l_xckl.xckl103)  OR l_xckl.xckl103 = 0) AND
            (cl_null(l_xckl.xckl104)  OR l_xckl.xckl104 = 0) AND
            (cl_null(l_xckl.xckl104a) OR l_xckl.xckl104a = 0) AND
            (cl_null(l_xckl.xckl104b) OR l_xckl.xckl104b = 0) AND
            (cl_null(l_xckl.xckl104c) OR l_xckl.xckl104c = 0) AND
            (cl_null(l_xckl.xckl104d) OR l_xckl.xckl104d = 0) AND
            (cl_null(l_xckl.xckl104e) OR l_xckl.xckl104e = 0) AND
            (cl_null(l_xckl.xckl104f) OR l_xckl.xckl104f = 0) AND
            (cl_null(l_xckl.xckl104g) OR l_xckl.xckl104g = 0) AND
            (cl_null(l_xckl.xckl104h) OR l_xckl.xckl104h = 0) THEN
            LET l_sub_sql = l_sub_sql , " SELECT xcce002 xckl010,xcce006 xckl006,xcce007 xckl007,xcce008 xckl008,xcce009 xckl009, ",    
                                        "        0 xckl101,0 xckl102,                                                          ",
                                        "        0 xckl102a,0 xckl102b,0 xckl102c,0 xckl102d,                                  ",
                                        "        0 xckl102e,0 xckl102f,0 xckl102g,0 xckl102h,                                  ",
                                        "        SUM((CASE WHEN xcce901 IS NULL THEN 0 ELSE  xcce901 END)) xckl103, ",            
                                        "        SUM((CASE WHEN xcce902 IS NULL THEN 0 ELSE  xcce902 END)) xckl104, ",
                                        "        SUM((CASE WHEN xcce902a IS NULL THEN 0 ELSE xcce902a END)) xckl104a,",
                                        "        SUM((CASE WHEN xcce902b IS NULL THEN 0 ELSE xcce902b END)) xckl104b,",
                                        "        SUM((CASE WHEN xcce902c IS NULL THEN 0 ELSE xcce902c END)) xckl104c,",
                                        "        SUM((CASE WHEN xcce902d IS NULL THEN 0 ELSE xcce902d END)) xckl104d, ",
                                        "        SUM((CASE WHEN xcce902e IS NULL THEN 0 ELSE xcce902e END)) xckl104e,",
                                        "        SUM((CASE WHEN xcce902f IS NULL THEN 0 ELSE xcce902f END)) xckl104f, ",
                                        "        SUM((CASE WHEN xcce902g IS NULL THEN 0 ELSE xcce902g END)) xckl104g,",
                                        "        SUM((CASE WHEN xcce902h IS NULL THEN 0 ELSE xcce902h END)) xckl104h  ",
                                        "   FROM xcce_t  ",
                                        "  WHERE xcceent = ",g_enterprise,
                                        "    AND xcceld = '",g_master.xckkld,"' ",
                                        "    AND xccecomp = '",g_master.xckkcomp,"' ",
                                        "    AND xcce001 = '",g_master.xckk001,"' ",
                                        "    AND xcce003 = '",g_master.xckk002,"' ",
                                        "    AND xcce004 = ",g_previous_xckk003,
                                        "    AND xcce005 = ",g_previous_xckk004,
                                        "   GROUP BY xcce002,xcce006,xcce007,xcce008,xcce009 "
         ELSE
            LET l_sub_sql = l_sub_sql , " SELECT xccb002 xckl010,xccb006 xckl006,xccb007 xckl007,xccb008 xckl008,xccb009 xckl009, ",    
                                        "        0 xckl101,0 xckl102,                                                          ",
                                        "        0 xckl102a,0 xckl102b,0 xckl102c,0 xckl102d,                                  ",
                                        "        0 xckl102e,0 xckl102f,0 xckl102g,0 xckl102h,                                  ",
                                        "        SUM((CASE WHEN xccb101  IS NULL THEN 0 ELSE xccb101  END)) xckl103,  ",
                                        "        SUM((CASE WHEN xccb102  IS NULL THEN 0 ELSE xccb102  END)) xckl104,  ",
                                        "        SUM((CASE WHEN xccb102a IS NULL THEN 0 ELSE xccb102a END)) xckl104a, ",
                                        "        SUM((CASE WHEN xccb102b IS NULL THEN 0 ELSE xccb102b END)) xckl104b, ", 
                                        "        SUM((CASE WHEN xccb102c IS NULL THEN 0 ELSE xccb102c END)) xckl104c, ",
                                        "        SUM((CASE WHEN xccb102d IS NULL THEN 0 ELSE xccb102d END)) xckl104d, ", 
                                        "        SUM((CASE WHEN xccb102e IS NULL THEN 0 ELSE xccb102e END)) xckl104e, ",
                                        "        SUM((CASE WHEN xccb102f IS NULL THEN 0 ELSE xccb102f END)) xckl104f, ", 
                                        "        SUM((CASE WHEN xccb102g IS NULL THEN 0 ELSE xccb102g END)) xckl104g, ",
                                        "        SUM((CASE WHEN xccb102h IS NULL THEN 0 ELSE xccb102h END)) xckl104h  ",
                                        "   FROM xccb_t, sfaa_t    ",
                                        "  WHERE xccbent = ",g_enterprise,
                                        "    AND xccbld = '",g_master.xckkld,"' ",
                                        "    AND xccbcomp = '",g_master.xckkcomp,"' ",
                                        "    AND xccb001 = '",g_master.xckk001,"' ",
                                        "    AND xccb003 = '",g_master.xckk002,"' ",
                                        "    AND xccb004 = ",g_previous_xckk003,
                                        "    AND xccb005 = ",g_previous_xckk004,
                                        "    AND xccbent = sfaaent AND xccb006 = sfaadocno AND sfaa003 <> '3' ",  #非拆件工单  #160719-00012#1  
                                        "  GROUP BY xccb002,xccb006,xccb007,xccb008,xccb009 "
         END IF 
         
         LET l_sql = l_sql_1 , l_sub_sql , l_sql_2
         PREPARE axcq603_ins_xckl_pb19 FROM l_sql
         DECLARE axcq603_ins_xckl_cs19 CURSOR FOR axcq603_ins_xckl_pb19
         EXECUTE axcq603_ins_xckl_cs19
         IF SQLCA.sqlcode  THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "axcq603_ins_xckl_cs19:"
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()                   
            LET r_success = FALSE
            RETURN r_success
         END IF

   
      #总表抓xcce的非拆件工单的本期投入数量和金额（元件排除DL+OH+SUB，料件类别是原料），明细表抓xcck的非拆件工单工单发料数量和金额，并写入xckk（排除拆件且元件排除DL+OH+SUB，料件类别是原料）；
      #有差异的按在制单号(工单)找出差异并写入xckl
      WHEN '216'         #原料投入
         LET l_sub_sql = " SELECT xcce002 xckl010,xcce006 xckl006,xcce007 xckl007,xcce008 xckl008,xcce009 xckl009,",
                         "        SUM(xcce201+xcce205+xcce207+xcce209) xckl101,   ",
                         "        SUM(xcce202+xcce206+xcce208+xcce210) xckl102,   ",  
                         "        SUM(xcce202a+xcce206a+xcce208a+xcce210a) xckl102a,",
                         "        SUM(xcce202b+xcce206b+xcce208b+xcce210b) xckl102b,", 
                         "        SUM(xcce202c+xcce206c+xcce208c+xcce210c) xckl102c,",
                         "        SUM(xcce202d+xcce206d+xcce208d+xcce210d) xckl102d,",   
                         "        SUM(xcce202e+xcce206e+xcce208e+xcce210e) xckl102e,",
                         "        SUM(xcce202f+xcce206f+xcce208f+xcce210f) xckl102f,", 
                         "        SUM(xcce202g+xcce206g+xcce208g+xcce210g) xckl102g,",
                         "        SUM(xcce202h+xcce206h+xcce208h+xcce210h) xckl102h,",
                         "        0 xckl103,0 xckl104,                         ",
                         "        0 xckl104a,0 xckl104b,0 xckl104c,0 xckl104d, ",
                         "        0 xckl104e,0 xckl104f,0 xckl104g,0 xckl104h  ",
                         "   FROM xcce_t ,imaa_t   ",
                         "  WHERE xcceent = ",g_enterprise,
                         "    AND xcceld = '",g_master.xckkld,"' ",
                         "    AND xccecomp = '",g_master.xckkcomp,"' ",
                         "    AND xcce001 = '",g_master.xckk001,"' ",
                         "    AND xcce003 = '",g_master.xckk002,"' ",
                         "    AND xcce004 = ",g_master.xckk003,
                         "    AND xcce005 = ",g_master.xckk004,
                         "    AND xcceent = imaaent AND xcce007  = imaa001 AND xcce007 <> 'DL+OH+SUB' AND imaa004 <> 'A' ",
                         "   GROUP BY xcce002,xcce006,xcce007,xcce008,xcce009   ",
                         "  UNION ",
                         " SELECT xcck002 xckl010,xcck010 xckl007,xcck011 xckl008,xcck017 xckl009,xcck047 xckl006 , ",    
                         "        0 xckl101,0 xckl102,                                                          ",
                         "        0 xckl102a,0 xckl102b,0 xckl102c,0 xckl102d,                                  ",
                         "        0 xckl102e,0 xckl102f,0 xckl102g,0 xckl102h,                                  ",
                         "        SUM((CASE WHEN xcck201  IS NULL THEN 0 ELSE xcck201  END)* xcck009) xckl103,  ",
                         "        SUM((CASE WHEN xcck202  IS NULL THEN 0 ELSE xcck202  END)*xcck009)  xckl104,  ",
                         "        SUM((CASE WHEN xcck202a IS NULL THEN 0 ELSE xcck202a END)* xcck009) xckl104a, ",
                         "        SUM((CASE WHEN xcck202b IS NULL THEN 0 ELSE xcck202b END)*xcck009)  xckl104b, ", 
                         "        SUM((CASE WHEN xcck202c IS NULL THEN 0 ELSE xcck202c END)* xcck009) xckl104c, ",
                         "        SUM((CASE WHEN xcck202d IS NULL THEN 0 ELSE xcck202d END)*xcck009)  xckl104d, ", 
                         "        SUM((CASE WHEN xcck202e IS NULL THEN 0 ELSE xcck202e END)* xcck009) xckl104e, ",
                         "        SUM((CASE WHEN xcck202f IS NULL THEN 0 ELSE xcck202f END)*xcck009)  xckl104f, ", 
                         "        SUM((CASE WHEN xcck202g IS NULL THEN 0 ELSE xcck202g END)* xcck009) xckl104g, ",
                         "        SUM((CASE WHEN xcck202h IS NULL THEN 0 ELSE xcck202h END)*xcck009)  xckl104h  ",
                         "   FROM xcck_t              ",
                         "  WHERE xcckent = ",g_enterprise,
                         "    AND xcckld = '",g_master.xckkld,"' ",
                         "    AND xcckcomp = '",g_master.xckkcomp,"' ",
                         "    AND xcck001 = '",g_master.xckk001,"' ",
                         "    AND xcck003 = '",g_master.xckk002,"' ",
                         "    AND xcck004 = ",g_master.xckk003,
                         "    AND xcck005 = ",g_master.xckk004,
                         "    AND xcck055 = '3012' AND xcck020 <> '113' ", 
                         "    AND xcck010 IN (SELECT imaa001 FROM imaa_t WHERE imaaent = '",g_enterprise,"' AND imaa004  <> 'A') AND xcck010 <> 'DL+OH+SUB' " ,
                         "  GROUP BY xcck002,xcck010,xcck011,xcck017,xcck047   "
         LET l_sql = l_sql_1 , l_sub_sql , l_sql_2
         PREPARE axcq603_ins_xckl_pb20 FROM l_sql
         DECLARE axcq603_ins_xckl_cs20 CURSOR FOR axcq603_ins_xckl_pb20
         EXECUTE axcq603_ins_xckl_cs20
         IF SQLCA.sqlcode  THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "axcq603_ins_xckl_cs20:"
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()                   
            LET r_success = FALSE
            RETURN r_success
         END IF
   
      #总表抓xcce的非拆件工单的本期投入数量和金额（元件排除DL+OH+SUB，料件类别是半成品），明细表抓xcck的非拆件工单工单发料数量和金额，并写入xckk（排除拆件且元件排除DL+OH+SUB，料件类别是半成品）；
      #有差异的按在制单号(工单)找出差异并写入xckl
      WHEN '217'         #半成品投入
         LET l_sub_sql = " SELECT xcce002 xckl010,xcce006 xckl006,xcce007 xckl007,xcce008 xckl008,xcce009 xckl009,",
                         "        SUM(xcce201+xcce205+xcce207+xcce209) xckl101,   ",
                         "        SUM(xcce202+xcce206+xcce208+xcce210) xckl102,   ",  
                         "        SUM(xcce202a+xcce206a+xcce208a+xcce210a) xckl102a,",
                         "        SUM(xcce202b+xcce206b+xcce208b+xcce210b) xckl102b,", 
                         "        SUM(xcce202c+xcce206c+xcce208c+xcce210c) xckl102c,",
                         "        SUM(xcce202d+xcce206d+xcce208d+xcce210d) xckl102d,",   
                         "        SUM(xcce202e+xcce206e+xcce208e+xcce210e) xckl102e,",
                         "        SUM(xcce202f+xcce206f+xcce208f+xcce210f) xckl102f,", 
                         "        SUM(xcce202g+xcce206g+xcce208g+xcce210g) xckl102g,",
                         "        SUM(xcce202h+xcce206h+xcce208h+xcce210h) xckl102h,",
                         "        0 xckl103,0 xckl104,                         ",
                         "        0 xckl104a,0 xckl104b,0 xckl104c,0 xckl104d, ",
                         "        0 xckl104e,0 xckl104f,0 xckl104g,0 xckl104h  ",
                         "   FROM xcce_t ,imaa_t   ",
                         "  WHERE xcceent = ",g_enterprise,
                         "    AND xcceld = '",g_master.xckkld,"' ",
                         "    AND xccecomp = '",g_master.xckkcomp,"' ",
                         "    AND xcce001 = '",g_master.xckk001,"' ",
                         "    AND xcce003 = '",g_master.xckk002,"' ",
                         "    AND xcce004 = ",g_master.xckk003,
                         "    AND xcce005 = ",g_master.xckk004,
                         "    AND xcceent = imaaent AND xcce007  = imaa001 AND xcce007 <> 'DL+OH+SUB' AND imaa004 = 'A' ",
                         "   GROUP BY xcce002,xcce006,xcce007,xcce008,xcce009   ",
                         "  UNION ",
                         #" SELECT xcck002 xckl010,xcck010 xckl007,xcck011 xckl008,xcck017 xckl009,xcck047 xckl006 , ",  #170406-00027#1 mark                            
                         " SELECT xcck002 xckl010,xcck047 xckl006 ,xcck010 xckl007,xcck011 xckl008,xcck017 xckl009 , ",   #170406-00027#1 add
                         "        0 xckl101,0 xckl102,                                                          ",
                         "        0 xckl102a,0 xckl102b,0 xckl102c,0 xckl102d,                                  ",
                         "        0 xckl102e,0 xckl102f,0 xckl102g,0 xckl102h,                                  ",
                         "        SUM((CASE WHEN xcck201  IS NULL THEN 0 ELSE xcck201  END)* xcck009) xckl103,  ",
                         "        SUM((CASE WHEN xcck202  IS NULL THEN 0 ELSE xcck202  END)*xcck009)  xckl104,  ",
                         "        SUM((CASE WHEN xcck202a IS NULL THEN 0 ELSE xcck202a END)* xcck009) xckl104a, ",
                         "        SUM((CASE WHEN xcck202b IS NULL THEN 0 ELSE xcck202b END)*xcck009)  xckl104b, ", 
                         "        SUM((CASE WHEN xcck202c IS NULL THEN 0 ELSE xcck202c END)* xcck009) xckl104c, ",
                         "        SUM((CASE WHEN xcck202d IS NULL THEN 0 ELSE xcck202d END)*xcck009)  xckl104d, ", 
                         "        SUM((CASE WHEN xcck202e IS NULL THEN 0 ELSE xcck202e END)* xcck009) xckl104e, ",
                         "        SUM((CASE WHEN xcck202f IS NULL THEN 0 ELSE xcck202f END)*xcck009)  xckl104f, ", 
                         "        SUM((CASE WHEN xcck202g IS NULL THEN 0 ELSE xcck202g END)* xcck009) xckl104g, ",
                         "        SUM((CASE WHEN xcck202h IS NULL THEN 0 ELSE xcck202h END)*xcck009)  xckl104h  ",
                         "   FROM xcck_t              ",
                         "  WHERE xcckent = ",g_enterprise,
                         "    AND xcckld = '",g_master.xckkld,"' ",
                         "    AND xcckcomp = '",g_master.xckkcomp,"' ",
                         "    AND xcck001 = '",g_master.xckk001,"' ",
                         "    AND xcck003 = '",g_master.xckk002,"' ",
                         "    AND xcck004 = ",g_master.xckk003,
                         "    AND xcck005 = ",g_master.xckk004,
                         "    AND xcck055 IN ('207','3012') AND xcck020 <> '113' ", 
                         "    AND xcck010 IN (SELECT imaa001 FROM imaa_t WHERE imaaent = '",g_enterprise,"' AND imaa004  = 'A') AND xcck010 <> 'DL+OH+SUB' " ,
                         "  GROUP BY xcck002,xcck010,xcck011,xcck017,xcck047   "
         LET l_sql = l_sql_1 , l_sub_sql , l_sql_2
         PREPARE axcq603_ins_xckl_pb21 FROM l_sql
         DECLARE axcq603_ins_xckl_cs21 CURSOR FOR axcq603_ins_xckl_pb21
         EXECUTE axcq603_ins_xckl_cs21
         IF SQLCA.sqlcode  THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "axcq603_ins_xckl_cs21:"
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()                   
            LET r_success = FALSE
            RETURN r_success
         END IF
   
   
      #总表抓xcce的非拆件工单的本期元件=DL+OH+SUB投入的金额，明细表抓xcbk的非拆件工单人工金额，并写入xckk；有差异的按在制单号(工单)找出差异并写入xckl
      WHEN '200'         #在制人工费
         #明细表抓xcbk的非拆件工单人工金额
         CASE g_master.xckk001 
            WHEN '1'  #本位币一
               LET l_sql = " SELECT SUM(xcbk202) xcbk202 "
            WHEN '2'  #本位币二
               LET l_sql = " SELECT SUM(xcbk212) xcbk202 "
            WHEN '3'  #本位币三
               LET l_sql = " SELECT SUM(xcbk222) xcbk202 "
            OTHERWISE
               LET l_sql = " SELECT SUM(xcbk202) xcbk202 "
         END CASE
         
         LET l_sql = l_sql, " FROM xcbk_t,sfaa_t ",  
                     "   WHERE xcbkent = '",g_enterprise,"' AND xcbkld = '",g_master.xckkld,"' ",
                     "     AND xcbkcomp = '",g_master.xckkcomp,"' AND xcbk001 = '",g_master.xckk002,"' ",
                     "     AND xcbk002 = ",g_master.xckk003," AND xcbk003 = ",g_master.xckk004,
                     "     AND xcbkent = sfaaent AND xcbk006 = sfaadocno AND sfaa003 <> '3' " #非拆件工单  
         #xckk104b  人工
         LET l_sql_b = l_sql, " AND xcbk005 = '1' "
         #xckk104d  #製費一       
         LET l_sql_d = l_sql, " AND xcbk005 = '2' "
         #xckk104e  #製費二       
         LET l_sql_e = l_sql, " AND xcbk005 = '3' "
         #xckk104f  #製費三       
         LET l_sql_f = l_sql, " AND xcbk005 = '4' "
         #xckk104g  #製費四
         LET l_sql_g = l_sql, " AND xcbk005 = '5' "
         #xckk104h  #製費五
         LET l_sql_h = l_sql, " AND xcbk005 = '6' "  
         
  #      xckk104c
         CASE g_master.xckk001
            WHEN '1'  #本位币一
               LET l_sql = " SELECT SUM(CASE apcb001 WHEN '21' THEN apcb113*(-1) ELSE apcb113 END) apcb113 "
            WHEN '2'  #本位币二
               LET l_sql = " SELECT SUM(CASE apcb001 WHEN '21' THEN apcb123*(-1) ELSE apcb123 END) apcb113 "
            WHEN '3'  #本位币三
               LET l_sql = " SELECT SUM(CASE apcb001 WHEN '21' THEN apcb133*(-1) ELSE apcb133 END) apcb113 "
            OTHERWISE
               LET l_sql = " SELECT SUM(CASE apcb001 WHEN '21' THEN apcb113*(-1) ELSE apcb113 END) apcb113 "
         END CASE
         LET l_sql_c = l_sql, " FROM apca_t,apcb_t,pmds_t,pmdt_t,pmdp_t,sfaa_t ", 
                            " WHERE apcaent = apcbent AND apcald = apcbld AND apcadocno = apcbdocno ",
                            "   AND pmdsent = pmdtent AND pmdsdocno = pmdtdocno AND pmdssite = pmdtsite  ",
                            "   AND apcbent = pmdtent AND apcb002 = pmdtdocno AND apcb003 = pmdtseq ",
                            "   AND pmdtent = pmdpent AND pmdt001 = pmdpdocno AND pmdt002 = pmdpseq AND pmdt003 = pmdpseq1 ",  
	                         "   AND pmdpent = sfaaent AND pmdp003 = sfaadocno ",                             
                            "   AND pmds000 IN ('12','14','20') AND pmds011 = '2'  AND pmdsstus = 'S' ",
                            "   AND pmds001 BETWEEN '",g_bdate,"' AND '",g_edate,"' ",
                            "   AND pmds037 = '",g_curr,"'",   
                            "   AND apcaent = ",g_enterprise,
                            "   AND apcald = '",g_master.xckkld,"'",
                            "   AND apcastus = 'Y' AND apcb001 IN ('11','21') ",
                            "   AND apcb023 = 'N'AND pmdt001 IS NOT NULL ",
                            "   AND sfaa003 <> '3' "     
         
         LET l_sub_sql = " SELECT xcce002 xckl010,xcce006 xckl006,xcce007 xckl007,xcce008 xckl008,xcce009 xckl009,",
                         "        0 xckl101,   ",
                         "        SUM(CASE xcce007 WHEN 'DL+OH+SUB' THEN xcce202 - xcce202a ELSE 0 END) xckl102,   ",  
                         "        0 xckl102a,",
                         "        SUM(CASE xcce007 WHEN 'DL+OH+SUB' THEN xcce202b ELSE 0 END) xckl102b,", 
                         "        SUM(CASE xcce007 WHEN 'DL+OH+SUB' THEN xcce202c ELSE 0 END) xckl102c,",
                         "        SUM(CASE xcce007 WHEN 'DL+OH+SUB' THEN xcce202d ELSE 0 END) xckl102d,",   
                         "        SUM(CASE xcce007 WHEN 'DL+OH+SUB' THEN xcce202e ELSE 0 END) xckl102e,",
                         "        SUM(CASE xcce007 WHEN 'DL+OH+SUB' THEN xcce202f ELSE 0 END) xckl102f,", 
                         "        SUM(CASE xcce007 WHEN 'DL+OH+SUB' THEN xcce202g ELSE 0 END) xckl102g,",
                         "        SUM(CASE xcce007 WHEN 'DL+OH+SUB' THEN xcce202h ELSE 0 END) xckl102h,",
                         "        0 xckl103,(SUM(b.xcbk202)+SUM(c.apcb113)+SUM(d.xcbk202)+SUM(e.xcbk202)+SUM(f.xcbk202)+SUM(g.xcbk202)+SUM(h.xcbk202)) xckl104,                         ",
                         "        0 xckl104a,SUM(b.xcbk202) xckl104b,SUM(c.apcb113) xckl104c,SUM(d.xcbk202) xckl104d, ",
                         "        SUM(e.xcbk202) xckl104e,SUM(f.xcbk202) xckl104f,SUM(g.xcbk202) xckl104g,SUM(h.xcbk202) xckl104h  ",
                         "   FROM xcce_t  ,  ",
                         "        (",l_sql_b,") b ,",
                         "        (",l_sql_c,") c ,",
                         "        (",l_sql_d,") d ,",
                         "        (",l_sql_e,") e ,",
                         "        (",l_sql_f,") f ,",
                         "        (",l_sql_g,") g ,",
                         "        (",l_sql_h,") h ",
                         "  WHERE xcceent = ",g_enterprise,
                         "    AND xcceld = '",g_master.xckkld,"' ",
                         "    AND xccecomp = '",g_master.xckkcomp,"' ",
                         "    AND xcce001 = '",g_master.xckk001,"' ",
                         "    AND xcce003 = '",g_master.xckk002,"' ",
                         "    AND xcce004 = ",g_master.xckk003,
                         "    AND xcce005 = ",g_master.xckk004,
                         "   GROUP BY xcce002,xcce006,xcce007,xcce008,xcce009   "
         LET l_sql = l_sql_1 , l_sub_sql , l_sql_2
         PREPARE axcq603_ins_xckl_pb22 FROM l_sql
         DECLARE axcq603_ins_xckl_cs22 CURSOR FOR axcq603_ins_xckl_pb22
         EXECUTE axcq603_ins_xckl_cs22
         IF SQLCA.sqlcode  THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "axcq603_ins_xckl_cs22:"
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()                   
            LET r_success = FALSE
            RETURN r_success
         END IF
   
      #总表抓xcce的非拆件工单的本期元件=ADJUST投入的金额，明细表抓xccp的非拆件工单的金额，并写入xckk；有差异的按在制单号(工单)找出差异并写入xckl
      WHEN '210'         #在制调整
         LET l_sub_sql = " SELECT xcce002 xckl010,xcce006 xckl006,xcce007 xckl007,xcce008 xckl008,xcce009 xckl009,",
                         "        SUM(CASE xcce007 WHEN 'ADJUST' THEN xcce201 ELSE 0 END) xckl101,   ",
                         "        SUM(CASE xcce007 WHEN 'ADJUST' THEN xcce202 ELSE 0 END) xckl102,   ",  
                         "        SUM(CASE xcce007 WHEN 'ADJUST' THEN xcce202a ELSE 0 END) xckl102a,",
                         "        SUM(CASE xcce007 WHEN 'ADJUST' THEN xcce202b ELSE 0 END) xckl102b,", 
                         "        SUM(CASE xcce007 WHEN 'ADJUST' THEN xcce202c ELSE 0 END) xckl102c,",
                         "        SUM(CASE xcce007 WHEN 'ADJUST' THEN xcce202d ELSE 0 END) xckl102d,",   
                         "        SUM(CASE xcce007 WHEN 'ADJUST' THEN xcce202e ELSE 0 END) xckl102e,",
                         "        SUM(CASE xcce007 WHEN 'ADJUST' THEN xcce202f ELSE 0 END) xckl102f,", 
                         "        SUM(CASE xcce007 WHEN 'ADJUST' THEN xcce202g ELSE 0 END) xckl102g,",
                         "        SUM(CASE xcce007 WHEN 'ADJUST' THEN xcce202h ELSE 0 END) xckl102h,",
                         "        0 xckl103,0 xckl104,                         ",
                         "        0 xckl104a,0 xckl104b,0 xckl104c,0 xckl104d, ",
                         "        0 xckl104e,0 xckl104f,0 xckl104g,0 xckl104h  ",
                         "   FROM xcce_t    ",
                         "  WHERE xcceent = ",g_enterprise,
                         "    AND xcceld = '",g_master.xckkld,"' ",
                         "    AND xccecomp = '",g_master.xckkcomp,"' ",
                         "    AND xcce001 = '",g_master.xckk001,"' ",
                         "    AND xcce003 = '",g_master.xckk002,"' ",
                         "    AND xcce004 = ",g_master.xckk003,
                         "    AND xcce005 = ",g_master.xckk004,
                         "   GROUP BY xcce002,xcce006,xcce007,xcce008,xcce009   ",
                         "  UNION ",
                         " SELECT xccp002 xckl010,' ' xckl007,' ' xckl008,' ' xckl009,xccp007 xckl006 , ",    
                         "        0 xckl101,0 xckl102,                                                          ",
                         "        0 xckl102a,0 xckl102b,0 xckl102c,0 xckl102d,                                  ",
                         "        0 xckl102e,0 xckl102f,0 xckl102g,0 xckl102h,                                  ",
                         "        SUM((CASE WHEN xccp101  IS NULL THEN 0 ELSE xccp101  END)) xckl103,  ",
                         "        SUM((CASE WHEN xccp102  IS NULL THEN 0 ELSE xccp102  END)) xckl104,  ",
                         "        SUM((CASE WHEN xccp102a IS NULL THEN 0 ELSE xccp102a END)) xckl104a, ",
                         "        SUM((CASE WHEN xccp102b IS NULL THEN 0 ELSE xccp102b END)) xckl104b, ", 
                         "        SUM((CASE WHEN xccp102c IS NULL THEN 0 ELSE xccp102c END)) xckl104c, ",
                         "        SUM((CASE WHEN xccp102d IS NULL THEN 0 ELSE xccp102d END)) xckl104d, ", 
                         "        SUM((CASE WHEN xccp102e IS NULL THEN 0 ELSE xccp102e END)) xckl104e, ",
                         "        SUM((CASE WHEN xccp102f IS NULL THEN 0 ELSE xccp102f END)) xckl104f, ", 
                         "        SUM((CASE WHEN xccp102g IS NULL THEN 0 ELSE xccp102g END)) xckl104g, ",
                         "        SUM((CASE WHEN xccp102h IS NULL THEN 0 ELSE xccp102h END)) xckl104h  ",
                         "   FROM xccp_t ,sfaa_t  ",
                         "  WHERE xccpent = ",g_enterprise,
                         "    AND xccpld = '",g_master.xckkld,"' ",
                         "    AND xccpcomp = '",g_master.xckkcomp,"' ",
                         "    AND xccp001 = '",g_master.xckk001,"' ",
                         "    AND xccp003 = '",g_master.xckk002,"' ",
                         "    AND xccp004 = ",g_master.xckk003,
                         "    AND xccp005 = ",g_master.xckk004,
                         "    AND xccpent = sfaaent AND xccp007 = sfaadocno AND sfaa003 <> '3' ",
                         "  GROUP BY xccp002,' ',' ',' ',xccp007   "
         LET l_sql = l_sql_1 , l_sub_sql , l_sql_2
         PREPARE axcq603_ins_xckl_pb23 FROM l_sql
         DECLARE axcq603_ins_xckl_cs23 CURSOR FOR axcq603_ins_xckl_pb23
         EXECUTE axcq603_ins_xckl_cs23
         IF SQLCA.sqlcode  THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "axcq603_ins_xckl_cs23:"
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()                   
            LET r_success = FALSE
            RETURN r_success
         END IF
   
      #总表抓xcce的非拆件工单的本期转出数量和金额，明细表抓xcck的非拆件工单入库的数量和金额，并写入xckk；有差异的按在制单号(工单)找出差异并写入xckl
      WHEN '211'         #在制转出
         LET l_sub_sql = " SELECT xcce002 xckl010,xcce006 xckl006,xcce007 xckl007,xcce008 xckl008,xcce009 xckl009,",
                         "        SUM((CASE WHEN xcce301  IS NULL THEN 0 ELSE xcce301  END)) xckl101,   ",
                         "        SUM((CASE WHEN xcce302  IS NULL THEN 0 ELSE xcce302  END)) xckl102,   ",  
                         "        SUM((CASE WHEN xcce302a IS NULL THEN 0 ELSE xcce302a END)) xckl102a,",
                         "        SUM((CASE WHEN xcce302b IS NULL THEN 0 ELSE xcce302b END)) xckl102b,", 
                         "        SUM((CASE WHEN xcce302c IS NULL THEN 0 ELSE xcce302c END)) xckl102c,",
                         "        SUM((CASE WHEN xcce302d IS NULL THEN 0 ELSE xcce302d END)) xckl102d,",   
                         "        SUM((CASE WHEN xcce302e IS NULL THEN 0 ELSE xcce302e END)) xckl102e,",
                         "        SUM((CASE WHEN xcce302f IS NULL THEN 0 ELSE xcce302f END)) xckl102f,", 
                         "        SUM((CASE WHEN xcce302g IS NULL THEN 0 ELSE xcce302g END)) xckl102g,",
                         "        SUM((CASE WHEN xcce302h IS NULL THEN 0 ELSE xcce302h END)) xckl102h,",
                         "        0 xckl103,0 xckl104,                         ",
                         "        0 xckl104a,0 xckl104b,0 xckl104c,0 xckl104d, ",
                         "        0 xckl104e,0 xckl104f,0 xckl104g,0 xckl104h  ",
                         "   FROM xcce_t    ",
                         "  WHERE xcceent = ",g_enterprise,
                         "    AND xcceld = '",g_master.xckkld,"' ",
                         "    AND xccecomp = '",g_master.xckkcomp,"' ",
                         "    AND xcce001 = '",g_master.xckk001,"' ",
                         "    AND xcce003 = '",g_master.xckk002,"' ",
                         "    AND xcce004 = ",g_master.xckk003,
                         "    AND xcce005 = ",g_master.xckk004,
                         "   GROUP BY xcce002,xcce006,xcce007,xcce008,xcce009   ",
                         "  UNION ",
                         " SELECT xcck002 xckl010,xcck010 xckl007,xcck011 xckl008,xcck017 xckl009,xcck047 xckl006 , ",    
                         "        0 xckl101,0 xckl102,                                                          ",
                         "        0 xckl102a,0 xckl102b,0 xckl102c,0 xckl102d,                                  ",
                         "        0 xckl102e,0 xckl102f,0 xckl102g,0 xckl102h,                                  ",
                         "        SUM((CASE WHEN xcck201  IS NULL THEN 0 ELSE xcck201  END)* xcck009) xckl103,  ",
                         "        SUM((CASE WHEN xcck202  IS NULL THEN 0 ELSE xcck202  END)*xcck009)  xckl104,  ",
                         "        SUM((CASE WHEN xcck202a IS NULL THEN 0 ELSE xcck202a END)* xcck009) xckl104a, ",
                         "        SUM((CASE WHEN xcck202b IS NULL THEN 0 ELSE xcck202b END)*xcck009)  xckl104b, ", 
                         "        SUM((CASE WHEN xcck202c IS NULL THEN 0 ELSE xcck202c END)* xcck009) xckl104c, ",
                         "        SUM((CASE WHEN xcck202d IS NULL THEN 0 ELSE xcck202d END)*xcck009)  xckl104d, ", 
                         "        SUM((CASE WHEN xcck202e IS NULL THEN 0 ELSE xcck202e END)* xcck009) xckl104e, ",
                         "        SUM((CASE WHEN xcck202f IS NULL THEN 0 ELSE xcck202f END)*xcck009)  xckl104f, ", 
                         "        SUM((CASE WHEN xcck202g IS NULL THEN 0 ELSE xcck202g END)* xcck009) xckl104g, ",
                         "        SUM((CASE WHEN xcck202h IS NULL THEN 0 ELSE xcck202h END)*xcck009)  xckl104h  ",
                         "   FROM xcck_t              ",
                         "  WHERE xcckent = ",g_enterprise,
                         "    AND xcckld = '",g_master.xckkld,"' ",
                         "    AND xcckcomp = '",g_master.xckkcomp,"' ",
                         "    AND xcck001 = '",g_master.xckk001,"' ",
                         "    AND xcck003 = '",g_master.xckk002,"' ",
                         "    AND xcck004 = ",g_master.xckk003,
                         "    AND xcck005 = ",g_master.xckk004,
                         "    AND xcck055 IN ('203','2030','205','2050','209','2090') ", 
                         "    AND xcck047 IN (SELECT DISTINCT sfaadocno FROM sfaa_t WHERE sfaaent = '",g_enterprise,"' AND sfaa003 <> '3' )",
                         "  GROUP BY xcck002,xcck010,xcck011,xcck017,xcck047   "
         LET l_sql = l_sql_3 , l_sub_sql , l_sql_2
         PREPARE axcq603_ins_xckl_pb24 FROM l_sql
         DECLARE axcq603_ins_xckl_cs24 CURSOR FOR axcq603_ins_xckl_pb24
         EXECUTE axcq603_ins_xckl_cs24
         IF SQLCA.sqlcode  THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "axcq603_ins_xckl_cs24:"
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()                   
            LET r_success = FALSE
            RETURN r_success
         END IF
   
      #总表抓和明细表xcce的非拆件工单的本期差异转出数量和金额，并写入xckk；无差异
      WHEN '212'         #差异转出
      
      
      #总表抓和明细表xcce的非拆件工单的本期期末数量和金额，并写入xckk；无差异
      WHEN '214'         #在制期末
     
      #总表抓xcci的拆件工单的本期期初数量和金额，明细表抓xcci的上期拆件工单的期末数量和金额，抓不到抓上期的拆件工单的xccb的数据和金额，并写入xckk；有差异的按在制单号(工单)找出差异并写入xckl
      WHEN '301'         #拆件期初
         LET l_sub_sql = " SELECT xcci002 xckl010,xcci006 xckl006,xcci007 xckl007,xcci008 xckl008,xcci009 xckl009,",
                         "        SUM((CASE WHEN xcci101  IS NULL THEN 0 ELSE xcci101  END)) xckl101,   ",
                         "        SUM((CASE WHEN xcci102  IS NULL THEN 0 ELSE xcci102  END)) xckl102,   ",  
                         "        SUM((CASE WHEN xcci102a IS NULL THEN 0 ELSE xcci102a END)) xckl102a,",
                         "        SUM((CASE WHEN xcci102b IS NULL THEN 0 ELSE xcci102b END)) xckl102b,", 
                         "        SUM((CASE WHEN xcci102c IS NULL THEN 0 ELSE xcci102c END)) xckl102c,",
                         "        SUM((CASE WHEN xcci102d IS NULL THEN 0 ELSE xcci102d END)) xckl102d,",   
                         "        SUM((CASE WHEN xcci102e IS NULL THEN 0 ELSE xcci102e END)) xckl102e,",
                         "        SUM((CASE WHEN xcci102f IS NULL THEN 0 ELSE xcci102f END)) xckl102f,", 
                         "        SUM((CASE WHEN xcci102g IS NULL THEN 0 ELSE xcci102g END)) xckl102g,",
                         "        SUM((CASE WHEN xcci102h IS NULL THEN 0 ELSE xcci102h END)) xckl102h,",
                         "        0 xckl103,0 xckl104,                         ",
                         "        0 xckl104a,0 xckl104b,0 xckl104c,0 xckl104d, ",
                         "        0 xckl104e,0 xckl104f,0 xckl104g,0 xckl104h  ",
                         "   FROM xcci_t    ",
                         "  WHERE xccient = ",g_enterprise,
                         "    AND xccild = '",g_master.xckkld,"' ",
                         "    AND xccicomp = '",g_master.xckkcomp,"' ",
                         "    AND xcci001 = '",g_master.xckk001,"' ",
                         "    AND xcci003 = '",g_master.xckk002,"' ",
                         "    AND xcci004 = ",g_master.xckk003,
                         "    AND xcci005 = ",g_master.xckk004,
                         "   GROUP BY xcci002,xcci006,xcci007,xcci008,xcci009   ",
                         "  UNION "
         #抓xcci的上期期末数量和金额
         SELECT SUM((CASE WHEN xcci901 IS NULL THEN 0 ELSE xcci901 END)),  SUM((CASE WHEN xcci902 IS NULL THEN 0 ELSE xcci902 END)), 
                SUM((CASE WHEN xcci902a IS NULL THEN 0 ELSE xcci902a END)),SUM((CASE WHEN xcci902b IS NULL THEN 0 ELSE xcci902b END)),
                SUM((CASE WHEN xcci902c IS NULL THEN 0 ELSE xcci902c END)),SUM((CASE WHEN xcci902d IS NULL THEN 0 ELSE xcci902d END)),
                SUM((CASE WHEN xcci902e IS NULL THEN 0 ELSE xcci902e END)),SUM((CASE WHEN xcci902f IS NULL THEN 0 ELSE xcci902f END)),
                SUM((CASE WHEN xcci902g IS NULL THEN 0 ELSE xcci902g END)),SUM((CASE WHEN xcci902h IS NULL THEN 0 ELSE xcci902h END))
            INTO l_xckl.xckl103, l_xckl.xckl104, l_xckl.xckl104a,l_xckl.xckl104b,l_xckl.xckl104c,
                 l_xckl.xckl104d,l_xckl.xckl104e,l_xckl.xckl104f,l_xckl.xckl104g,l_xckl.xckl104h
         FROM xcci_t 
         WHERE xccient = g_enterprise AND xccild = g_master.xckkld AND xccicomp = g_master.xckkcomp
           AND xcci001 = g_master.xckk001 AND xcci003 = g_master.xckk002 
           AND xcci004 = g_previous_xckk003 AND xcci005 = g_previous_xckk004
         IF SQLCA.sqlcode <> 0 AND SQLCA.sqlcode <> 100 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "xcci_t:7"
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success
         END IF
         
         #抓不到抓上期的xccb的数据和金额
         IF (cl_null(l_xckl.xckl103)  OR l_xckl.xckl103 = 0) AND
            (cl_null(l_xckl.xckl104)  OR l_xckl.xckl104 = 0) AND
            (cl_null(l_xckl.xckl104a) OR l_xckl.xckl104a = 0) AND
            (cl_null(l_xckl.xckl104b) OR l_xckl.xckl104b = 0) AND
            (cl_null(l_xckl.xckl104c) OR l_xckl.xckl104c = 0) AND
            (cl_null(l_xckl.xckl104d) OR l_xckl.xckl104d = 0) AND
            (cl_null(l_xckl.xckl104e) OR l_xckl.xckl104e = 0) AND
            (cl_null(l_xckl.xckl104f) OR l_xckl.xckl104f = 0) AND
            (cl_null(l_xckl.xckl104g) OR l_xckl.xckl104g = 0) AND
            (cl_null(l_xckl.xckl104h) OR l_xckl.xckl104h = 0) THEN
            LET l_sub_sql = l_sub_sql , " SELECT xcci002 xckl010,xcci006 xckl006,xcci007 xckl007,xcci008 xckl008,xcci009 xckl009, ",    
                                        "        0 xckl101,0 xckl102,                                                          ",
                                        "        0 xckl102a,0 xckl102b,0 xckl102c,0 xckl102d,                                  ",
                                        "        0 xckl102e,0 xckl102f,0 xckl102g,0 xckl102h,                                  ",
                                        "        SUM((CASE WHEN xcci901 IS NULL THEN 0 ELSE  xcci901 END)) xckl103, ",            
                                        "        SUM((CASE WHEN xcci902 IS NULL THEN 0 ELSE  xcci902 END)) xckl104, ",
                                        "        SUM((CASE WHEN xcci902a IS NULL THEN 0 ELSE xcci902a END)) xckl104a,",
                                        "        SUM((CASE WHEN xcci902b IS NULL THEN 0 ELSE xcci902b END)) xckl104b,",
                                        "        SUM((CASE WHEN xcci902c IS NULL THEN 0 ELSE xcci902c END)) xckl104c,",
                                        "        SUM((CASE WHEN xcci902d IS NULL THEN 0 ELSE xcci902d END)) xckl104d, ",
                                        "        SUM((CASE WHEN xcci902e IS NULL THEN 0 ELSE xcci902e END)) xckl104e,",
                                        "        SUM((CASE WHEN xcci902f IS NULL THEN 0 ELSE xcci902f END)) xckl104f, ",
                                        "        SUM((CASE WHEN xcci902g IS NULL THEN 0 ELSE xcci902g END)) xckl104g,",
                                        "        SUM((CASE WHEN xcci902h IS NULL THEN 0 ELSE xcci902h END)) xckl104h  ",
                                        "   FROM xcci_t  ",
                                        "  WHERE xccient = ",g_enterprise,
                                        "    AND xccild = '",g_master.xckkld,"' ",
                                        "    AND xccicomp = '",g_master.xckkcomp,"' ",
                                        "    AND xcci001 = '",g_master.xckk001,"' ",
                                        "    AND xcci003 = '",g_master.xckk002,"' ",
                                        "    AND xcci004 = ",g_previous_xckk003,
                                        "    AND xcci005 = ",g_previous_xckk004,
                                        "   GROUP BY xcci002,xcci006,xcci007,xcci008,xcci009 "
         ELSE
            LET l_sub_sql = l_sub_sql , " SELECT xccb002 xckl010,xccb006 xckl006,xccb007 xckl007,xccb008 xckl008,xccb009 xckl009, ",    
                                        "        0 xckl101,0 xckl102,                                                          ",
                                        "        0 xckl102a,0 xckl102b,0 xckl102c,0 xckl102d,                                  ",
                                        "        0 xckl102e,0 xckl102f,0 xckl102g,0 xckl102h,                                  ",
                                        "        SUM((CASE WHEN xccb101  IS NULL THEN 0 ELSE xccb101  END)) xckl103,  ",
                                        "        SUM((CASE WHEN xccb102  IS NULL THEN 0 ELSE xccb102  END)) xckl104,  ",
                                        "        SUM((CASE WHEN xccb102a IS NULL THEN 0 ELSE xccb102a END)) xckl104a, ",
                                        "        SUM((CASE WHEN xccb102b IS NULL THEN 0 ELSE xccb102b END)) xckl104b, ", 
                                        "        SUM((CASE WHEN xccb102c IS NULL THEN 0 ELSE xccb102c END)) xckl104c, ",
                                        "        SUM((CASE WHEN xccb102d IS NULL THEN 0 ELSE xccb102d END)) xckl104d, ", 
                                        "        SUM((CASE WHEN xccb102e IS NULL THEN 0 ELSE xccb102e END)) xckl104e, ",
                                        "        SUM((CASE WHEN xccb102f IS NULL THEN 0 ELSE xccb102f END)) xckl104f, ", 
                                        "        SUM((CASE WHEN xccb102g IS NULL THEN 0 ELSE xccb102g END)) xckl104g, ",
                                        "        SUM((CASE WHEN xccb102h IS NULL THEN 0 ELSE xccb102h END)) xckl104h  ",
                                        "   FROM xccb_t, sfaa_t    ",
                                        "  WHERE xccbent = ",g_enterprise,
                                        "    AND xccbld = '",g_master.xckkld,"' ",
                                        "    AND xccbcomp = '",g_master.xckkcomp,"' ",
                                        "    AND xccb001 = '",g_master.xckk001,"' ",
                                        "    AND xccb003 = '",g_master.xckk002,"' ",
                                        "    AND xccb004 = ",g_previous_xckk003,
                                        "    AND xccb005 = ",g_previous_xckk004,
                                        "    AND xccbent = sfaaent AND xccb006 = sfaadocno AND sfaa003 = '3' ",  #拆件工单  #160719-00012#1  
                                        "  GROUP BY xccb002,xccb006,xccb007,xccb008,xccb009 "
         END IF
         LET l_sql = l_sql_3 , l_sub_sql , l_sql_2
         PREPARE axcq603_ins_xckl_pb25 FROM l_sql
         DECLARE axcq603_ins_xckl_cs25 CURSOR FOR axcq603_ins_xckl_pb25
         EXECUTE axcq603_ins_xckl_cs25
         IF SQLCA.sqlcode  THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "axcq603_ins_xckl_cs25:"
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()                   
            LET r_success = FALSE
            RETURN r_success
         END IF

      #总表抓xcci的拆件工单的本期投入数量和金额（元件排除DL+OH+SUB），明细表抓xcck的拆件工单工单发料数量和金额，并写入xckk；有差异的按在制单号(工单)找出差异并写入xckl
      WHEN '302'         #拆件投入
         LET l_sub_sql = " SELECT xcci002 xckl010,xcci006 xckl006,xcci007 xckl007,xcci008 xckl008,xcci009 xckl009,",
                         "        SUM((CASE WHEN xcci201  IS NULL THEN 0 ELSE xcci201  END)) xckl101,   ",
                         "        SUM((CASE WHEN xcci202  IS NULL THEN 0 ELSE xcci202  END)) xckl102,   ",  
                         "        SUM((CASE WHEN xcci202a IS NULL THEN 0 ELSE xcci202a END)) xckl102a,",
                         "        SUM((CASE WHEN xcci202b IS NULL THEN 0 ELSE xcci202b END)) xckl102b,", 
                         "        SUM((CASE WHEN xcci202c IS NULL THEN 0 ELSE xcci202c END)) xckl102c,",
                         "        SUM((CASE WHEN xcci202d IS NULL THEN 0 ELSE xcci202d END)) xckl102d,",   
                         "        SUM((CASE WHEN xcci202e IS NULL THEN 0 ELSE xcci202e END)) xckl102e,",
                         "        SUM((CASE WHEN xcci202f IS NULL THEN 0 ELSE xcci202f END)) xckl102f,", 
                         "        SUM((CASE WHEN xcci202g IS NULL THEN 0 ELSE xcci202g END)) xckl102g,",
                         "        SUM((CASE WHEN xcci202h IS NULL THEN 0 ELSE xcci202h END)) xckl102h,",
                         "        0 xckl103,0 xckl104,                         ",
                         "        0 xckl104a,0 xckl104b,0 xckl104c,0 xckl104d, ",
                         "        0 xckl104e,0 xckl104f,0 xckl104g,0 xckl104h  ",
                         "   FROM xcci_t    ",
                         "  WHERE xccient = ",g_enterprise,
                         "    AND xccild = '",g_master.xckkld,"' ",
                         "    AND xccicomp = '",g_master.xckkcomp,"' ",
                         "    AND xcci001 = '",g_master.xckk001,"' ",
                         "    AND xcci003 = '",g_master.xckk002,"' ",
                         "    AND xcci004 = ",g_master.xckk003,
                         "    AND xcci005 = ",g_master.xckk004,
                         "   GROUP BY xcci002,xcci006,xcci007,xcci008,xcci009   ",
                         "  UNION ",
                         " SELECT xcck002 xckl010,xcck010 xckl007,xcck011 xckl008,xcck017 xckl009,xcck047 xckl006 , ",    
                         "        0 xckl101,0 xckl102,                                                          ",
                         "        0 xckl102a,0 xckl102b,0 xckl102c,0 xckl102d,                                  ",
                         "        0 xckl102e,0 xckl102f,0 xckl102g,0 xckl102h,                                  ",
                         "        SUM((CASE WHEN xcck201  IS NULL THEN 0 ELSE xcck201  END)* xcck009) xckl103,  ",
                         "        SUM((CASE WHEN xcck202  IS NULL THEN 0 ELSE xcck202  END)*xcck009)  xckl104,  ",
                         "        SUM((CASE WHEN xcck202a IS NULL THEN 0 ELSE xcck202a END)* xcck009) xckl104a, ",
                         "        SUM((CASE WHEN xcck202b IS NULL THEN 0 ELSE xcck202b END)*xcck009)  xckl104b, ", 
                         "        SUM((CASE WHEN xcck202c IS NULL THEN 0 ELSE xcck202c END)* xcck009) xckl104c, ",
                         "        SUM((CASE WHEN xcck202d IS NULL THEN 0 ELSE xcck202d END)*xcck009)  xckl104d, ", 
                         "        SUM((CASE WHEN xcck202e IS NULL THEN 0 ELSE xcck202e END)* xcck009) xckl104e, ",
                         "        SUM((CASE WHEN xcck202f IS NULL THEN 0 ELSE xcck202f END)*xcck009)  xckl104f, ", 
                         "        SUM((CASE WHEN xcck202g IS NULL THEN 0 ELSE xcck202g END)* xcck009) xckl104g, ",
                         "        SUM((CASE WHEN xcck202h IS NULL THEN 0 ELSE xcck202h END)*xcck009)  xckl104h  ",
                         "   FROM xcck_t              ",
                         "  WHERE xcckent = ",g_enterprise,
                         "    AND xcckld = '",g_master.xckkld,"' ",
                         "    AND xcckcomp = '",g_master.xckkcomp,"' ",
                         "    AND xcck001 = '",g_master.xckk001,"' ",
                         "    AND xcck003 = '",g_master.xckk002,"' ",
                         "    AND xcck004 = ",g_master.xckk003,
                         "    AND xcck055 = '207' AND xcck020 = '302' ",
                         "    AND EXISTS (SELECT xcch006 FROM xcch_t ",
                         "                 WHERE xcchent = xcckent AND xcchcomp = xcckcomp AND xcch001 = xcck001 ",
                         "                   AND xcch003 = xcck003 AND xcch004 = xcck004 AND xcch005 = xcck005 ",
                         "                   AND xcch006 = xcck047 )",
                         "    AND xcck010 <> 'DL+OH+SUB' "  ,
                         "  GROUP BY xcck002,xcck010,xcck011,xcck017,xcck047   "
         LET l_sql = l_sql_3 , l_sub_sql , l_sql_2
         PREPARE axcq603_ins_xckl_pb26 FROM l_sql
         DECLARE axcq603_ins_xckl_cs26 CURSOR FOR axcq603_ins_xckl_pb26
         EXECUTE axcq603_ins_xckl_cs26
         IF SQLCA.sqlcode  THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "axcq603_ins_xckl_cs26:"
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()                   
            LET r_success = FALSE
            RETURN r_success
         END IF
   
      #总表抓xcci的拆件工单的本期元件=DL+OH+SUB投入人工金额，明细表抓xcbk的拆件工单人工金额，并写入xckk；有差异的按在制单号(工单)找出差异并写入xckl 
      WHEN '306'         #拆件人工费
         #明细表抓xcbk的非拆件工单人工金额
         CASE g_master.xckk001 
            WHEN '1'  #本位币一
               LET l_sql = " SELECT SUM(xcbk202) xcbk202 "
            WHEN '2'  #本位币二
               LET l_sql = " SELECT SUM(xcbk212) xcbk202 "
            WHEN '3'  #本位币三
               LET l_sql = " SELECT SUM(xcbk222) xcbk202 "
            OTHERWISE
               LET l_sql = " SELECT SUM(xcbk202) xcbk202 "
         END CASE
         
         LET l_sql = l_sql, " FROM xcbk_t,sfaa_t ",  
                     "   WHERE xcbkent = '",g_enterprise,"' AND xcbkld = '",g_master.xckkld,"' ",
                     "     AND xcbkcomp = '",g_master.xckkcomp,"' AND xcbk001 = '",g_master.xckk002,"' ",
                     "     AND xcbk002 = ",g_master.xckk003," AND xcbk003 = ",g_master.xckk004,
                     "     AND xcbkent = sfaaent AND xcbk006 = sfaadocno AND sfaa003 = '3' " #拆件工单  
         #xckk104b  人工
         LET l_sql_b = l_sql, " AND xcbk005 = '1' "
         #xckk104d  #製費一       
         LET l_sql_d = l_sql, " AND xcbk005 = '2' "
         #xckk104e  #製費二       
         LET l_sql_e = l_sql, " AND xcbk005 = '3' "
         #xckk104f  #製費三       
         LET l_sql_f = l_sql, " AND xcbk005 = '4' "
         #xckk104g  #製費四
         LET l_sql_g = l_sql, " AND xcbk005 = '5' "
         #xckk104h  #製費五
         LET l_sql_h = l_sql, " AND xcbk005 = '6' "  
        
        #xckk104c
         CASE g_master.xckk001
            WHEN '1'  #本位币一
               LET l_sql = " SELECT SUM(CASE apcb001 WHEN '21' THEN apcb113*(-1) ELSE apcb113 END) apcb113 "
            WHEN '2'  #本位币二
               LET l_sql = " SELECT SUM(CASE apcb001 WHEN '21' THEN apcb123*(-1) ELSE apcb123 END) apcb113 "
            WHEN '3'  #本位币三
               LET l_sql = " SELECT SUM(CASE apcb001 WHEN '21' THEN apcb133*(-1) ELSE apcb133 END) apcb113 "
            OTHERWISE
               LET l_sql = " SELECT SUM(CASE apcb001 WHEN '21' THEN apcb113*(-1) ELSE apcb113 END) apcb113 "
         END CASE
         LET l_sql_c = l_sql, " FROM apca_t,apcb_t,pmds_t,pmdt_t,pmdp_t,sfaa_t ", 
                            " WHERE apcaent = apcbent AND apcald = apcbld AND apcadocno = apcbdocno ",
                            "   AND pmdsent = pmdtent AND pmdsdocno = pmdtdocno AND pmdssite = pmdtsite  ",
                            "   AND apcbent = pmdtent AND apcb002 = pmdtdocno AND apcb003 = pmdtseq ",
                            "   AND pmdtent = pmdpent AND pmdt001 = pmdpdocno AND pmdt002 = pmdpseq AND pmdt003 = pmdpseq1 ",  
	                         "   AND pmdpent = sfaaent AND pmdp003 = sfaadocno ",                             
                            "   AND pmds000 IN ('12','14','20') AND pmds011 = '2'  AND pmdsstus = 'S' ",
                            "   AND pmds001 BETWEEN '",g_bdate,"' AND '",g_edate,"' ",
                            "   AND pmds037 = '",g_curr,"'",   
                            "   AND apcaent = ",g_enterprise,
                            "   AND apcald = '",g_master.xckkld,"'",
                            "   AND apcastus = 'Y' AND apcb001 IN ('11','21') ",
                            "   AND apcb023 = 'N'AND pmdt001 IS NOT NULL ",
                            "   AND sfaa003 = '3' "     
         
         LET l_sub_sql = " SELECT xcci002 xckl010,xcci006 xckl006,xcci007 xckl007,xcci008 xckl008,xcci009 xckl009,",
                         "        0 xckl101,   ",
                         "        SUM(CASE xcci007 WHEN 'DL+OH+SUB' THEN xcci202 - xcci202a ELSE 0 END) xckl102,   ",  
                         "        0 xckl102a,",
                         "        SUM(CASE xcci007 WHEN 'DL+OH+SUB' THEN xcci202b ELSE 0 END) xckl102b,", 
                         "        SUM(CASE xcci007 WHEN 'DL+OH+SUB' THEN xcci202c ELSE 0 END) xckl102c,",
                         "        SUM(CASE xcci007 WHEN 'DL+OH+SUB' THEN xcci202d ELSE 0 END) xckl102d,",   
                         "        SUM(CASE xcci007 WHEN 'DL+OH+SUB' THEN xcci202e ELSE 0 END) xckl102e,",
                         "        SUM(CASE xcci007 WHEN 'DL+OH+SUB' THEN xcci202f ELSE 0 END) xckl102f,", 
                         "        SUM(CASE xcci007 WHEN 'DL+OH+SUB' THEN xcci202g ELSE 0 END) xckl102g,",
                         "        SUM(CASE xcci007 WHEN 'DL+OH+SUB' THEN xcci202h ELSE 0 END) xckl102h,",
                         "        0 xckl103,(SUM(b.xcbk202)+SUM(c.apcb113)+SUM(d.xcbk202)+SUM(e.xcbk202)+SUM(f.xcbk202)+SUM(g.xcbk202)+SUM(h.xcbk202)) xckl104,                         ",
                         "        0 xckl104a,SUM(b.xcbk202) xckl104b,SUM(c.apcb113) xckl104c,SUM(d.xcbk202) xckl104d, ",
                         "        SUM(e.xcbk202) xckl104e,SUM(f.xcbk202) xckl104f,SUM(g.xcbk202) xckl104g,SUM(h.xcbk202) xckl104h  ",
                         "   FROM xcci_t  ,  ",
                         "        (",l_sql_b,") b ,",
                         "        (",l_sql_c,") c ,",
                         "        (",l_sql_d,") d ,",
                         "        (",l_sql_e,") e ,",
                         "        (",l_sql_f,") f ,",
                         "        (",l_sql_g,") g ,",
                         "        (",l_sql_h,") h ",
                         "  WHERE xccient = ",g_enterprise,
                         "    AND xccild = '",g_master.xckkld,"' ",
                         "    AND xccicomp = '",g_master.xckkcomp,"' ",
                         "    AND xcci001 = '",g_master.xckk001,"' ",
                         "    AND xcci003 = '",g_master.xckk002,"' ",
                         "    AND xcci004 = ",g_master.xckk003,
                         "    AND xcci005 = ",g_master.xckk004,
                         "   GROUP BY xcci002,xcci006,xcci007,xcci008,xcci009   "
         LET l_sql = l_sql_3 , l_sub_sql , l_sql_2
         PREPARE axcq603_ins_xckl_pb27 FROM l_sql
         DECLARE axcq603_ins_xckl_cs27 CURSOR FOR axcq603_ins_xckl_pb27
         EXECUTE axcq603_ins_xckl_cs27
         IF SQLCA.sqlcode  THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "axcq603_ins_xckl_cs22:"
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()                   
            LET r_success = FALSE
            RETURN r_success
         END IF
   
      #总表抓xcci的拆件工单的本期转出数量和金额，明细表抓xcck的拆件工单入库的数量和金额，并写入xckk；有差异的按在制单号(工单)找出差异并写入xckl
      WHEN '303'         #拆件拆出
         LET l_sub_sql = " SELECT xcci002 xckl010,xcci006 xckl006,xcci007 xckl007,xcci008 xckl008,xcci009 xckl009,",
                         "        SUM((CASE WHEN xcci301  IS NULL THEN 0 ELSE xcci301  END)) xckl101,   ",
                         "        SUM((CASE WHEN xcci302  IS NULL THEN 0 ELSE xcci302  END)) xckl102,   ",  
                         "        SUM((CASE WHEN xcci302a IS NULL THEN 0 ELSE xcci302a END)) xckl102a,",
                         "        SUM((CASE WHEN xcci302b IS NULL THEN 0 ELSE xcci302b END)) xckl102b,", 
                         "        SUM((CASE WHEN xcci302c IS NULL THEN 0 ELSE xcci302c END)) xckl102c,",
                         "        SUM((CASE WHEN xcci302d IS NULL THEN 0 ELSE xcci302d END)) xckl102d,",   
                         "        SUM((CASE WHEN xcci302e IS NULL THEN 0 ELSE xcci302e END)) xckl102e,",
                         "        SUM((CASE WHEN xcci302f IS NULL THEN 0 ELSE xcci302f END)) xckl102f,", 
                         "        SUM((CASE WHEN xcci302g IS NULL THEN 0 ELSE xcci302g END)) xckl102g,",
                         "        SUM((CASE WHEN xcci302h IS NULL THEN 0 ELSE xcci302h END)) xckl102h,",
                         "        0 xckl103,0 xckl104,                         ",
                         "        0 xckl104a,0 xckl104b,0 xckl104c,0 xckl104d, ",
                         "        0 xckl104e,0 xckl104f,0 xckl104g,0 xckl104h  ",
                         "   FROM xcci_t    ",
                         "  WHERE xccient = ",g_enterprise,
                         "    AND xccild = '",g_master.xckkld,"' ",
                         "    AND xccicomp = '",g_master.xckkcomp,"' ",
                         "    AND xcci001 = '",g_master.xckk001,"' ",
                         "    AND xcci003 = '",g_master.xckk002,"' ",
                         "    AND xcci004 = ",g_master.xckk003,
                         "    AND xcci005 = ",g_master.xckk004,
                         "   GROUP BY xcci002,xcci006,xcci007,xcci008,xcci009   ",
                         "  UNION ",
                         " SELECT xcck002 xckl010,xcck010 xckl007,xcck011 xckl008,xcck017 xckl009,xcck047 xckl006 , ",    
                         "        0 xckl101,0 xckl102,                                                          ",
                         "        0 xckl102a,0 xckl102b,0 xckl102c,0 xckl102d,                                  ",
                         "        0 xckl102e,0 xckl102f,0 xckl102g,0 xckl102h,                                  ",
                         "        SUM((CASE WHEN xcck201  IS NULL THEN 0 ELSE xcck201  END)* xcck009) xckl103,  ",
                         "        SUM((CASE WHEN xcck202  IS NULL THEN 0 ELSE xcck202  END)*xcck009)  xckl104,  ",
                         "        SUM((CASE WHEN xcck202a IS NULL THEN 0 ELSE xcck202a END)* xcck009) xckl104a, ",
                         "        SUM((CASE WHEN xcck202b IS NULL THEN 0 ELSE xcck202b END)*xcck009)  xckl104b, ", 
                         "        SUM((CASE WHEN xcck202c IS NULL THEN 0 ELSE xcck202c END)* xcck009) xckl104c, ",
                         "        SUM((CASE WHEN xcck202d IS NULL THEN 0 ELSE xcck202d END)*xcck009)  xckl104d, ", 
                         "        SUM((CASE WHEN xcck202e IS NULL THEN 0 ELSE xcck202e END)* xcck009) xckl104e, ",
                         "        SUM((CASE WHEN xcck202f IS NULL THEN 0 ELSE xcck202f END)*xcck009)  xckl104f, ", 
                         "        SUM((CASE WHEN xcck202g IS NULL THEN 0 ELSE xcck202g END)* xcck009) xckl104g, ",
                         "        SUM((CASE WHEN xcck202h IS NULL THEN 0 ELSE xcck202h END)*xcck009)  xckl104h  ",
                         "   FROM xcck_t              ",
                         "  WHERE xcckent = ",g_enterprise,
                         "    AND xcckld = '",g_master.xckkld,"' ",
                         "    AND xcckcomp = '",g_master.xckkcomp,"' ",
                         "    AND xcck001 = '",g_master.xckk001,"' ",
                         "    AND xcck003 = '",g_master.xckk002,"' ",
                         "    AND xcck004 = ",g_master.xckk003,
                         "    AND xcck047 IN (SELECT sfaadocno FROM sfaa_t WHERE sfaaent = '",g_enterprise,"' AND sfaa003 ='3' )",
                         "    AND xcck055 = '3012' AND xcck020 = '113' " ,
                         "  GROUP BY xcck002,xcck010,xcck011,xcck017,xcck047   "
         LET l_sql = l_sql_3 , l_sub_sql , l_sql_2
         PREPARE axcq603_ins_xckl_pb28 FROM l_sql
         DECLARE axcq603_ins_xckl_cs28 CURSOR FOR axcq603_ins_xckl_pb28
         EXECUTE axcq603_ins_xckl_cs28
         IF SQLCA.sqlcode  THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "axcq603_ins_xckl_cs28:"
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()                   
            LET r_success = FALSE
            RETURN r_success
         END IF

      #总表抓和明细表xcci的拆件工单的本期差异转出数量和金额，并写入xckk；无差异
      WHEN '304'         #拆件差异
      
      #总表抓和明细表xcci的拆件工单的本期期末数量和金额，并写入xckk；无差异 
      WHEN '305'         #拆件结存
   END CASE
   
   RETURN r_success
   
END FUNCTION

 
{</section>}
 
