#該程式未解開Section, 採用最新樣板產出!
{<section id="aint701.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0026(2017-01-20 11:34:50), PR版次:0026(2017-01-23 13:46:31)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000017
#+ Filename...: aint701
#+ Description: 揀貨裝箱單維護作業
#+ Creator....: 06814(2016-09-06 16:15:41)
#+ Modifier...: 06814 -SD/PR- 06814
 
{</section>}
 
{<section id="aint701.global" >}
#應用 t01 樣板自動產生(Version:79)
#add-point:填寫註解說明 name="global.memo" 
#Memos
#160909-00069#6  2016/09/24 by 08172 增加审核作废
#161006-00008#6  2016/10/18 by 06137 組織類型與職能開窗清單調整
#161024-00023#4  2016/10/25 by 06814 1.裝箱單單據明細，改為直接從裝箱來源inbp檔裡取值，原需求類型、需求單號、需求項次欄位名稱改為來源類型、來源單號、來源項次
#                                    2.單據明細頁簽改為放置待裝明細頁簽前面
#                                    3.單頭需求對象，IF 需求對像類型[inbm008]=‘3.供應商’then 顯示供應商名稱，
#                                    4.頁面開放來源類型[inbm004]
#                                    5.增加臨時表，臨時表字段同裝箱明細，增加序號欄位，序號放到箱號後，
#                                      1.當裝箱狀態為未封箱，掃碼錄入時，裝箱明細顯示臨時表信息，
#                                        掃碼時，每掃一次，寫入一筆到臨時表(同一商品，掃兩次，就顯示兩筆，數量均為1)，
#                                      2.當封箱確認後，清空臨時表信息，裝箱明細顯示正式表信息
#                                    6.掃碼原更新pmcz裡已裝箱改為更新裝箱來源檔.已裝箱量[inbp009]
#                                    7.裝箱單審核，調用apmt521生成入庫單公用元件，
#                                      傳入單據類型=2.裝箱單、單號=來源單號[inbm005]，生成已審核未過賬的委外採購入庫單
#161024-00023#14  2016/10/31 by 08172 回写已装箱量和删箱处理回写已装箱量pmcz064，不需加site相等条件
#161102-00026#6   2016/11/03 by 06189 单身增加汇总
#161024-00023#21  2016/11/21 by 06814 單身(單據明細,待裝明細)增加查詢功能
#161017-00051#15  2016/12/01 by 06814 1.aint701 箱明细页签默认按照箱号降序显示，最新的箱号在第一行
#                                     2.aint701 装箱明细页签默认按照扫码顺序降序显示，最新的扫描记录在第一行
#                                     3.aint701 单据明细和箱明细区域可以上下拖动，调整区域大小，箱明细可向下拖，现在看到的箱号太少
#                                     4.aint701 浏览数据页签增加应装箱量、已装箱量，分别汇总单据明细的应装数量和已装数量
#                                     5.aint701 在扫描完成以后，点击确认或者取消 ，if最大箱号的装箱明细内容为空，则删除最大箱号的箱明细信息
#161024-00023#22  2016/12/02 by 06814 if 来源类型<>4.配送单，则扫码时允许数量超出应装箱量
#161208-00023#3   2016/12/08 by 06814 1.aint701单据明细页签增加价格(虚字段，抓取imaa116)
#                                     2.来源为4.配送单的部分的单据明细页签增加库位和库位说明，
#                                       对应aint705中需求汇总页签的库位(只显示不存字段)，
#                                       增加发货库存、发货库位名称、发货储位、发货储位名称、收货库位、收货库位名称、收货储位、收货储位名称，
#                                       aint701其他来源的部分，库位栏位隐藏
#161208-00023#5   2016/12/09 by 06814 1.如果aint701来源类型是5.委外采购收货、8.采购收货时，扫码的时候，装箱明细的记录同商品+特征的只显示一笔，扫码后，数量累加；
#                                     2.异常处理：aint701箱明细和装箱明细要实时回写数据库，现在客户那边程序异常退出，导致有已装箱，但是箱明细和装箱明细里没有资料的数据
#161213-00004#1   2016/12/13 by 06814 1.串色、串码入库处理，調整檢核段與掃碼段的處理，详见分镜(aint701)
#                                     2.掃碼更新inbp_t已裝箱量後，針對來源項次是空的，如果來源項次是空，並且已裝箱量為0，則刪除此筆inbp
#                                     3.修正匯出excel
#161213-00004#7   2016/12/17 by 06137 删箱时，如果inbp008、inbp009同时为0，则删除本笔单身inbp
#161213-00004#8   2016/12/20 by 06814 1.编辑状态下，按向下按钮，箱明细里应该可以新增一箱
#                                     2.封箱完，自動產生箱號之後,即使點了取消,也必須刪自動產生且裝箱明細為空的最大箱號
#161213-00004#11  2016/12/20 by 06814 1.BUG修改：扫的商品会跑到已封箱的B1001箱里,加上控卡,新增箱明細前檢查,若已封箱就報錯提示:已封箱不允許掃入商品
#161217-00002#2   2016/12/21 by 06814 1.隱藏下拉選單:來源類別8.採購收貨單
#161220-00037#3   2016/12/22 by 06814 1.单身开放项次(inbpseq)栏位
#                                     2.更新pmcz的数量修改方式改为累加，见分镜
#161229-00039#1   2016/12/30 By 06932 aint701来源是委外采购收料时，如果来源单的单身库位为空，审核报错目前是按照料号一笔一笔报错的，要改成汇总的模式，报一次错就好
#170104-00068#1   2017/01/05 By 06814 1.增加功能:串色串碼時,掃碼錄入成功使用不同的提示音
#                                     2.開放下拉選單:來源類別8.採購收貨單
#170119-00027#1   2017/01/20 By 06814 aint701打印优化：1.aint701点打印按钮调ainr701界面，点打印或者快速打印，进去预览画面，
#                                                       关闭预览画面时，须同步关闭报表元件选择界面和R作业的前端界面；
#                                                     2.箱明细页签的封箱页签后，增加清单和汇总两个按钮，
#                                                       点击清单按钮，按照当时定位的箱号行，进入装装箱清单的预览打印界面，
#                                                       点击汇总按钮，进入装箱汇总单预览打印界面
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
PRIVATE type type_g_inbm_m        RECORD
       inbmsite LIKE inbm_t.inbmsite, 
   inbmsite_desc LIKE type_t.chr80, 
   inbmdocdt LIKE inbm_t.inbmdocdt, 
   inbmdocno LIKE inbm_t.inbmdocno, 
   inbm003 LIKE inbm_t.inbm003, 
   inbm005 LIKE inbm_t.inbm005, 
   inbm005_desc LIKE type_t.chr80, 
   inbm006 LIKE inbm_t.inbm006, 
   inbm006_desc LIKE type_t.chr80, 
   inbm007 LIKE inbm_t.inbm007, 
   inbm004 LIKE inbm_t.inbm004, 
   inbm001 LIKE inbm_t.inbm001, 
   inbm001_desc LIKE type_t.chr80, 
   inbm002 LIKE inbm_t.inbm002, 
   inbmunit LIKE inbm_t.inbmunit, 
   inbmunit_desc LIKE type_t.chr80, 
   inbm008 LIKE inbm_t.inbm008, 
   inbmstus LIKE inbm_t.inbmstus, 
   inbmownid LIKE inbm_t.inbmownid, 
   inbmownid_desc LIKE type_t.chr80, 
   inbmowndp LIKE inbm_t.inbmowndp, 
   inbmowndp_desc LIKE type_t.chr80, 
   inbmcrtid LIKE inbm_t.inbmcrtid, 
   inbmcrtid_desc LIKE type_t.chr80, 
   inbmcrtdp LIKE inbm_t.inbmcrtdp, 
   inbmcrtdp_desc LIKE type_t.chr80, 
   inbmcrtdt LIKE inbm_t.inbmcrtdt, 
   inbmmodid LIKE inbm_t.inbmmodid, 
   inbmmodid_desc LIKE type_t.chr80, 
   inbmmoddt LIKE inbm_t.inbmmoddt, 
   inbmcnfid LIKE inbm_t.inbmcnfid, 
   inbmcnfid_desc LIKE type_t.chr80, 
   inbmcnfdt LIKE inbm_t.inbmcnfdt, 
   inbn001_1 LIKE type_t.chr500, 
   l_symbol LIKE type_t.chr1, 
   l_num LIKE type_t.num10, 
   inbo010_1 LIKE type_t.chr500
       END RECORD
 
#單身 type 宣告
PRIVATE TYPE type_g_inbn_d        RECORD
       inbnsite LIKE inbn_t.inbnsite, 
   inbnunit LIKE inbn_t.inbnunit, 
   inbn001 LIKE inbn_t.inbn001, 
   l_cnt_kind LIKE type_t.num5, 
   l_count LIKE type_t.num5, 
   inbn002 LIKE inbn_t.inbn002
       END RECORD
PRIVATE TYPE type_g_inbn2_d RECORD
       inbosite LIKE inbo_t.inbosite, 
   inbounit LIKE inbo_t.inbounit, 
   inbo002 LIKE inbo_t.inbo002, 
   l_seq LIKE type_t.num10, 
   inbo001 LIKE inbo_t.inbo001, 
   inbo010 LIKE inbo_t.inbo010, 
   inbo006 LIKE inbo_t.inbo006, 
   inbo006_desc LIKE type_t.chr500, 
   inbo006_desc_1 LIKE type_t.chr500, 
   inbo007 LIKE inbo_t.inbo007, 
   inbo007_desc LIKE type_t.chr500, 
   inbo008 LIKE inbo_t.inbo008, 
   inbo008_desc LIKE type_t.chr500, 
   inbo009 LIKE inbo_t.inbo009
       END RECORD
 
 
PRIVATE TYPE type_browser RECORD
         b_statepic     LIKE type_t.chr50,
            b_inbmsite LIKE inbm_t.inbmsite,
   b_inbmsite_desc LIKE type_t.chr80,
      b_inbmdocdt LIKE inbm_t.inbmdocdt,
      b_inbmdocno LIKE inbm_t.inbmdocno,
      b_inbmunit LIKE inbm_t.inbmunit,
   b_inbmunit_desc LIKE type_t.chr80,
      b_inbm001 LIKE inbm_t.inbm001,
   b_inbm001_desc LIKE type_t.chr80,
      b_inbm002 LIKE inbm_t.inbm002,
      b_inbm007 LIKE inbm_t.inbm007,
   b_inbp008 LIKE inbp_t.inbp008,
   b_inbp009 LIKE inbp_t.inbp009,
      b_inbmstus LIKE inbm_t.inbmstus,
      b_inbm008 LIKE inbm_t.inbm008
       END RECORD
       
#add-point:自定義模組變數(Module Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_skip            LIKE type_t.chr1  #是否略過此筆單身移至下一個單身
DEFINE g_skip_1          LIKE type_t.chr1  #條碼是否可輸入
DEFINE g_next_inbo010    LIKE type_t.num5  #接下來是否跳轉至條碼欄位
DEFINE g_delete_flag     LIKE type_t.num5  #是否剛刪除完(TRUE:刪除完後尚未新增一筆箱明細;FALSE:有新增一筆箱明細)
#161024-00023#4 20161025 mark by beckxie---S
#TYPE type_g_inbn3_d      RECORD
#        pmcz004          LIKE pmcz_t.pmcz004,
#        pmcz004_desc     LIKE type_t.chr500, 
#        pmcz004_desc_1   LIKE type_t.chr500, 
#        pmcz005          LIKE pmcz_t.pmcz005,
#        pmcz005_desc     LIKE type_t.chr500, 
#        pmcz006          LIKE pmcz_t.pmcz006,
#        pmcz006_desc     LIKE type_t.chr500, 
#        l_sum            LIKE type_t.num10,
#        l_count_1        LIKE type_t.num10
#                         END RECORD
#161024-00023#4 20161025 mark by beckxie---E
#161024-00023#4 20161025 add by beckxie---S
TYPE type_g_inbn3_d      RECORD
        inbp005          LIKE inbp_t.inbp005,
        inbp005_1_desc   LIKE type_t.chr500, 
        inbp005_1_desc_1 LIKE type_t.chr500, 
        inbp006          LIKE inbp_t.inbp006,
        inbp006_desc     LIKE type_t.chr500, 
        inbp007          LIKE inbp_t.inbp007,
        inbp007_desc     LIKE type_t.chr500, 
        l_sum            LIKE type_t.num10,
        l_count_1        LIKE type_t.num10
                         END RECORD
#161024-00023#4 20161025 add by beckxie---E
#161024-00023#4 20161025 mark by beckxie---S
#TYPE type_g_inbn4_d      RECORD
#        pmcz023          LIKE pmcz_t.pmcz023,
#        pmcz001          LIKE pmcz_t.pmcz001,
#        pmcz002          LIKE pmcz_t.pmcz002,
#        pmcz003          LIKE pmcz_t.pmcz003,
#        pmcz004_1        LIKE pmcz_t.pmcz004,
#        pmcz004_1_desc   LIKE type_t.chr500, 
#        pmcz004_1_desc_1 LIKE type_t.chr500, 
#        pmcz005_1        LIKE pmcz_t.pmcz005,
#        pmcz005_1_desc   LIKE type_t.chr500, 
#        pmcz006_1        LIKE pmcz_t.pmcz006,
#        pmcz006_1_desc   LIKE type_t.chr500, 
#        pmcz051          LIKE pmcz_t.pmcz051,
#        pmcz064          LIKE pmcz_t.pmcz064,
#        l_count_2        LIKE type_t.num10,
#        l_count_3        LIKE type_t.num20,
#        indjseq          LIKE indj_t.indjseq
#                         END RECORD
#161024-00023#4 20161025 mark by beckxie---E
#161024-00023#4 20161025 add by beckxie---S
TYPE type_g_inbn4_d   RECORD  #裝箱來源檔
     inbpseq          LIKE inbp_t.inbpseq, #項次   #161220-00037#3 20161222 add by beckxie
     inbp001          LIKE inbp_t.inbp001, #來源單據類型
     inbp002          LIKE inbp_t.inbp002, #來源單號
     inbp003          LIKE inbp_t.inbp003, #來源項次
     inbp010          LIKE inbp_t.inbp010, #需求類型
     inbp011          LIKE inbp_t.inbp011, #需求單號
     inbp012          LIKE inbp_t.inbp012, #需求項次
     inbp004          LIKE inbp_t.inbp004, #商品條碼
     inbp005          LIKE inbp_t.inbp005, #商品編碼
     inbp005_desc     LIKE type_t.chr500, 
     inbp005_desc_1   LIKE type_t.chr500, 
     inbp006          LIKE inbp_t.inbp006, #產品特徵
     inbp006_desc     LIKE type_t.chr500, 
     inbp007          LIKE inbp_t.inbp007, #單位
     inbp007_desc     LIKE type_t.chr500, 
     #161208-00023#3 20161208 add by beckxie---S
     indj012          LIKE indj_t.indj012,
     indj012_desc     LIKE type_t.chr500,
     indj013          LIKE indj_t.indj013,
     indj013_desc     LIKE type_t.chr500,
     indj015          LIKE indj_t.indj015,
     indj015_desc     LIKE type_t.chr500,
     indj016          LIKE indj_t.indj016,
     indj016_desc     LIKE type_t.chr500,
     #161208-00023#3 20161208 add by beckxie---E
     inbp008          LIKE inbp_t.inbp008, #數量
     inbp009          LIKE inbp_t.inbp009, #已裝箱量
     l_count_2        LIKE type_t.num10,
     l_imaa116        LIKE type_t.num20_6,   #161208-00023#3 20161208 add by beckxie
     l_count_3        LIKE type_t.num20_6
END RECORD
DEFINE g_temp_init_flag  LIKE type_t.num5   #是否需要刷新temp table
#161024-00023#4 20161025 add by beckxie---E
DEFINE g_cmd             LIKE type_t.chr1   #161017-00051#15 20161201 add by beckxie
DEFINE g_flag            LIKE type_t.chr1   #是否為串色串碼  #170104-00068#1  20170105 add by beckxie
DEFINE g_inbn3_d         DYNAMIC ARRAY OF type_g_inbn3_d
DEFINE g_inbn3_d_t       type_g_inbn3_d
DEFINE g_inbn3_d_o       type_g_inbn3_d
DEFINE g_inbn3_d_mask_o  DYNAMIC ARRAY OF type_g_inbn3_d #轉換遮罩前資料
DEFINE g_inbn3_d_mask_n  DYNAMIC ARRAY OF type_g_inbn3_d #轉換遮罩後資料
DEFINE g_detail_idx3     LIKE type_t.num10
DEFINE g_inbn4_d         DYNAMIC ARRAY OF type_g_inbn4_d
DEFINE g_inbn4_d_t       type_g_inbn4_d
DEFINE g_inbn4_d_o       type_g_inbn4_d
DEFINE g_inbn4_d_mask_o  DYNAMIC ARRAY OF type_g_inbn4_d #轉換遮罩前資料
DEFINE g_inbn4_d_mask_n  DYNAMIC ARRAY OF type_g_inbn4_d #轉換遮罩後資料
DEFINE g_detail_idx4     LIKE type_t.num10
DEFINE g_wc3_table1      STRING   #161024-00023#21 20161121 add by beckxie
DEFINE g_wc4_table1      STRING   #161024-00023#21 20161121 add by beckxie
#end add-point
       
#模組變數(Module Variables)
DEFINE g_inbm_m          type_g_inbm_m
DEFINE g_inbm_m_t        type_g_inbm_m
DEFINE g_inbm_m_o        type_g_inbm_m
DEFINE g_inbm_m_mask_o   type_g_inbm_m #轉換遮罩前資料
DEFINE g_inbm_m_mask_n   type_g_inbm_m #轉換遮罩後資料
 
   DEFINE g_inbmdocno_t LIKE inbm_t.inbmdocno
 
 
DEFINE g_inbn_d          DYNAMIC ARRAY OF type_g_inbn_d
DEFINE g_inbn_d_t        type_g_inbn_d
DEFINE g_inbn_d_o        type_g_inbn_d
DEFINE g_inbn_d_mask_o   DYNAMIC ARRAY OF type_g_inbn_d #轉換遮罩前資料
DEFINE g_inbn_d_mask_n   DYNAMIC ARRAY OF type_g_inbn_d #轉換遮罩後資料
DEFINE g_inbn2_d          DYNAMIC ARRAY OF type_g_inbn2_d
DEFINE g_inbn2_d_t        type_g_inbn2_d
DEFINE g_inbn2_d_o        type_g_inbn2_d
DEFINE g_inbn2_d_mask_o   DYNAMIC ARRAY OF type_g_inbn2_d #轉換遮罩前資料
DEFINE g_inbn2_d_mask_n   DYNAMIC ARRAY OF type_g_inbn2_d #轉換遮罩後資料
 
 
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
 
{<section id="aint701.main" >}
#應用 a26 樣板自動產生(Version:7)
#+ 作業開始(主程式類型)
MAIN
   #add-point:main段define(客製用) name="main.define_customerization"
   
   #end add-point   
   #add-point:main段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="main.define"
   DEFINE l_success LIKE type_t.num5   #161006-00008#6 Add By Ken 161018
   #end add-point   
   
   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
       
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("ain","")
 
   #add-point:作業初始化 name="main.init"
   
   #end add-point
   
   
 
   #LOCK CURSOR (identifier)
   #add-point:SQL_define name="main.define_sql"
   
   #end add-point
   LET g_forupd_sql = " SELECT inbmsite,'',inbmdocdt,inbmdocno,inbm003,inbm005,'',inbm006,'',inbm007, 
       inbm004,inbm001,'',inbm002,inbmunit,'',inbm008,inbmstus,inbmownid,'',inbmowndp,'',inbmcrtid,'', 
       inbmcrtdp,'',inbmcrtdt,inbmmodid,'',inbmmoddt,inbmcnfid,'',inbmcnfdt,'','','',''", 
                      " FROM inbm_t",
                      " WHERE inbment= ? AND inbmdocno=? FOR UPDATE"
   #add-point:SQL_define name="main.after_define_sql"
   
   #end add-point
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)                #轉換不同資料庫語法
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aint701_cl CURSOR FROM g_forupd_sql                 # LOCK CURSOR
 
   LET g_sql = " SELECT DISTINCT t0.inbmsite,t0.inbmdocdt,t0.inbmdocno,t0.inbm003,t0.inbm005,t0.inbm006, 
       t0.inbm007,t0.inbm004,t0.inbm001,t0.inbm002,t0.inbmunit,t0.inbm008,t0.inbmstus,t0.inbmownid,t0.inbmowndp, 
       t0.inbmcrtid,t0.inbmcrtdp,t0.inbmcrtdt,t0.inbmmodid,t0.inbmmoddt,t0.inbmcnfid,t0.inbmcnfdt,t1.ooefl003 , 
       t2.ooag011 ,t3.ooefl003 ,t4.ooefl003 ,t5.ooefl003 ,t6.ooag011 ,t7.ooefl003 ,t8.ooag011 ,t9.ooefl003 , 
       t10.ooag011 ,t11.ooag011",
               " FROM inbm_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.inbmsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t2 ON t2.ooagent="||g_enterprise||" AND t2.ooag001=t0.inbm005  ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.inbm006 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.inbm001 AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.inbmunit AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.inbmownid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.inbmowndp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.inbmcrtid  ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent="||g_enterprise||" AND t9.ooefl001=t0.inbmcrtdp AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.inbmmodid  ",
               " LEFT JOIN ooag_t t11 ON t11.ooagent="||g_enterprise||" AND t11.ooag001=t0.inbmcnfid  ",
 
               " WHERE t0.inbment = " ||g_enterprise|| " AND t0.inbmdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #add-point:SQL_define name="main.after_refresh_sql"
   #161208-00023#3 20161208 mark by beckxie---S
   #LET g_sql = " SELECT DISTINCT t0.inbmsite,t0.inbmdocdt,t0.inbmdocno,t0.inbmunit,t0.inbm005,t0.inbm006, ",
   #            #161024-00023#4 20161025 modify(add inbm003) by beckxie---S
   #            #"                 t0.inbm001,t0.inbm002,t0.inbm004,t0.inbm008,t0.inbmstus,t0.inbm007,t0.inbmownid,t0.inbmowndp,  ",
   #            "                 t0.inbm007,t0.inbm001,t0.inbm002,t0.inbm003,t0.inbm004,t0.inbm008,t0.inbmstus,t0.inbmownid,t0.inbmowndp,  ",
   #161208-00023#3 20161208 mark by beckxie---E
   #161208-00023#3 20161208 add by beckxie---S
   LET g_sql = " SELECT DISTINCT t0.inbmsite,t0.inbmdocdt,t0.inbmdocno,t0.inbm003,t0.inbm005,t0.inbm006, ",
               #161024-00023#4 20161025 modify(add inbm003) by beckxie---S
               #"                 t0.inbm001,t0.inbm002,t0.inbm004,t0.inbm008,t0.inbmstus,t0.inbm007,t0.inbmownid,t0.inbmowndp,  ",
               "                 t0.inbm007,t0.inbm004,t0.inbm001,t0.inbm002,t0.inbmunit,t0.inbm008,t0.inbmstus,t0.inbmownid,t0.inbmowndp,  ",
   #161208-00023#3 20161208 add by beckxie---E
               #161024-00023#4 20161025 modify(add inbm003) by beckxie---E
               "                 t0.inbmcrtid,t0.inbmcrtdp,t0.inbmcrtdt,t0.inbmmodid,t0.inbmmoddt,t0.inbmcnfid,t0.inbmcnfdt,t1.ooefl003 ,  ",
               "                 t3.ooag011,t4.ooefl003 ,",
               #需求對象說明
               #161024-00023#4 20161025 modify by beckxie---E
               #"                 CASE WHEN t0.inbm008 = '1' THEN t5.ooefl003 ELSE t12.pmaal004 END,",
               "                 CASE WHEN t0.inbm008 = '1' THEN t5.ooefl003 ",
               "                      WHEN t0.inbm008 = '2' THEN t12.pmaal004 ",
               "                      WHEN t0.inbm008 = '3' THEN t12.pmaal004 END,",
               #161024-00023#4 20161025 modify by beckxie---E
               "                 t2.ooefl003 ,t6.ooag011 ,t7.ooefl003 ,t8.ooag011 ,t9.ooefl003 ,  ",
               "                 t10.ooag011 ,t11.ooag011",
   
               " FROM inbm_t t0",
                              " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.inbmsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.inbmunit AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t3 ON t3.ooagent="||g_enterprise||" AND t3.ooag001=t0.inbm005  ",
               " LEFT JOIN ooefl_t t4 ON t4.ooeflent="||g_enterprise||" AND t4.ooefl001=t0.inbm006 AND t4.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t5 ON t5.ooeflent="||g_enterprise||" AND t5.ooefl001=t0.inbm001 AND t5.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t6 ON t6.ooagent="||g_enterprise||" AND t6.ooag001=t0.inbmownid  ",
               " LEFT JOIN ooefl_t t7 ON t7.ooeflent="||g_enterprise||" AND t7.ooefl001=t0.inbmowndp AND t7.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t8 ON t8.ooagent="||g_enterprise||" AND t8.ooag001=t0.inbmcrtid  ",
               " LEFT JOIN ooefl_t t9 ON t9.ooeflent="||g_enterprise||" AND t9.ooefl001=t0.inbmcrtdp AND t9.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooag_t t10 ON t10.ooagent="||g_enterprise||" AND t10.ooag001=t0.inbmmodid  ",
               " LEFT JOIN ooag_t t11 ON t11.ooagent="||g_enterprise||" AND t11.ooag001=t0.inbmcnfid  ",
               " LEFT JOIN pmaal_t t12 ON t12.pmaalent="||g_enterprise||" AND t12.pmaal001 = t0.inbm001 AND t12.pmaal002 = '"||g_dlang||"' ",
 
               " WHERE t0.inbment = " ||g_enterprise|| " AND t0.inbmdocno = ?"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
   #end add-point
   PREPARE aint701_master_referesh FROM g_sql
 
    
 
   
   IF g_bgjob = "Y" THEN
      #add-point:Service Call name="main.servicecall"
      
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_aint701 WITH FORM cl_ap_formpath("ain",g_code)
   
      #瀏覽頁簽資料初始化
      CALL cl_ui_init()
   
      #程式初始化
      CALL aint701_init()   
 
      #進入選單 Menu (="N")
      CALL aint701_ui_dialog() 
      
      #add-point:畫面關閉前 name="main.before_close"
      
      #end add-point
 
      #畫面關閉
      CLOSE WINDOW w_aint701
      
   END IF 
   
   CLOSE aint701_cl
   
   
 
   #add-point:作業離開前 name="main.exit"
   CALL s_aooi500_drop_temp() RETURNING l_success   #161006-00008#6 Add By Ken 161018
   CALL aint701_drop_temp() RETURNING l_success   #161024-00023#4 20161025 add by beckxie
   #end add-point
 
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
 
 
 
{</section>}
 
{<section id="aint701.init" >}
#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION aint701_init()
   #add-point:init段define(客製用) name="init.define_customerization"
   
   #end add-point    
   #add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="init.define"
   DEFINE l_success LIKE type_t.num5   #161006-00008#6 Add By Ken 161018
   DEFINE l_sql     STRING             #161017-00051#15 20161201 add by beckxie
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
      CALL cl_set_combo_scc_part('inbmstus','13','N,Y,X')
 
      CALL cl_set_combo_scc('inbm003','6977') 
   CALL cl_set_combo_scc('inbm008','6968') 
   CALL cl_set_combo_scc('inbn002','6969') 
 
   LET gwin_curr = ui.Window.getCurrent()  #取得現行畫面
   LET gfrm_curr = gwin_curr.getForm()     #取出物件化後的畫面物件
   
   #page群組
   LET g_idx_group = om.SaxAttributes.create()
   CALL g_idx_group.addAttribute("'1',","1")
   CALL g_idx_group.addAttribute("'2',","1")
 
 
   #add-point:畫面資料初始化 name="init.init"
   #CALL cl_set_combo_scc('pmcz023','6874')   #161024-00023#4 20161025 mark by beckxie
   CALL cl_set_combo_scc('inbp010','6874')    #161024-00023#4 20161025 add by beckxie
   CALL cl_set_combo_scc('inbp001','6977')    #161024-00023#4 20161025 add by beckxie
   #170104-00068#1 20170106 mark by beckxie---S
   #CALL cl_set_combo_scc_part('inbm003','6977','4,5,6,7,9')    #161217-00002#2 20161221 add by beckxie
   #CALL cl_set_combo_scc_part('inbp001','6977','4,5,6,7,9')    #161217-00002#2 20161221 add by beckxie
   #170104-00068#1 20170106 mark by beckxie---E
   CALL cl_set_combo_scc_part('b_inbmstus','13','N,X,Y')
   #LET g_errshow = 1   #161024-00023#11 20161030 mark by beckxie
   LET g_errshow = 0    #161024-00023#11 20161030 add by beckxie
   LET g_skip = TRUE
   LET g_delete_flag = FALSE
   CALL s_aooi500_create_temp() RETURNING l_success     #161006-00008#6 Add By Ken 161018
   CALL aint701_create_temp() RETURNING l_success       #161024-00023#4 20161025 add by beckxie
   LET g_temp_init_flag = TRUE                          #161024-00023#4 20161025 add by beckxie
    
   CALL s_lot_auto_create_tmp('aint513') RETURNING l_success   #161024-00023#4 20161025 add by beckxie
   
   #161017-00051#15 20161201 add by beckxie---S
   LET l_sql = " SELECT SUM(inbp008),SUM(inbp009) ",
               "   FROM inbp_t ",
               "  WHERE inbpent = ",g_enterprise,
               "    AND inbpdocno = ? ",
               "  GROUP BY inbpent,inbpdocno "
   
   PREPARE aint701_sum_inbp_pre FROM l_sql
   #161017-00051#15 20161201 add by beckxie---E
   LET g_cmd = ''  #161017-00051#15 20161201 add by beckxie
   #end add-point
   
   #初始化搜尋條件
   CALL aint701_default_search()
    
END FUNCTION
 
{</section>}
 
{<section id="aint701.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION aint701_ui_dialog()
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
   
   
   LET lb_first = TRUE
   
   #add-point:ui_dialog段before dialog  name="ui_dialog.before_dialog"
   
   #end add-point
   
   WHILE TRUE 
   
      IF g_action_choice = "logistics" THEN
         #清除畫面及相關資料
         CLEAR FORM
         CALL g_browser.clear()       
         INITIALIZE g_inbm_m.* TO NULL
         CALL g_inbn_d.clear()
         CALL g_inbn2_d.clear()
 
         LET g_wc  = ' 1=2'
         LET g_wc2 = ' 1=1'
         LET g_action_choice = ""
         CALL aint701_init()
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
               
               CALL aint701_fetch('') # reload data
               LET l_ac = 1
               CALL aint701_ui_detailshow() #Setting the current row 
         
               CALL aint701_idx_chk()
               #NEXT FIELD inbn001
         
               ON ACTION qbefield_user   #欄位隱藏設定 
                  LET g_action_choice="qbefield_user"
                  CALL cl_ui_qbefield_user()
         END DISPLAY
    
         DISPLAY ARRAY g_inbn_d TO s_detail1.* ATTRIBUTES(COUNT=g_rec_b) #page1  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aint701_idx_chk()
               #確定當下選擇的筆數
               LET l_ac = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx = l_ac
               LET g_detail_idx_list[1] = l_ac
               CALL g_idx_group.addAttribute("'1',",l_ac)
               CALL aint701_b_fill2('2')
 
               #add-point:page1, before row動作 name="ui_dialog.page1.before_row"
               LET g_inbm_m.inbn001_1 = g_inbn_d[g_detail_idx].inbn001
               DISPLAY BY NAME g_inbm_m.inbn001_1
               CALL aint701_set_act_visible()
               CALL aint701_set_act_no_visible()
               CALL aint701_set_comp_visible_b()      #161024-00023#4 20161026 add by beckxie
               CALL aint701_set_comp_no_visible_b()   #161024-00023#4 20161026 add by beckxie
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
               CALL aint701_idx_chk()
               #add-point:page1自定義行為 name="ui_dialog.page1.before_display"
               CALL aint701_set_comp_visible_b()      #161024-00023#4 20161026 add by beckxie
               CALL aint701_set_comp_no_visible_b()   #161024-00023#4 20161026 add by beckxie
               #end add-point
               
            #自訂ACTION(detail_show,page_1)
            
               
            #add-point:page1自定義行為 name="ui_dialog.page1.action"
            
            #end add-point
               
         END DISPLAY
        
 
         
         #第二階單身段落
         DISPLAY ARRAY g_inbn2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aint701_idx_chk()
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
               CALL aint701_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"
               
               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"
            
            #end add-point
         
         END DISPLAY
 
         
         #add-point:ui_dialog段自定義display array name="ui_dialog.more_displayarray"
         DISPLAY ARRAY g_inbn3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aint701_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_detail_idx3 = l_ac
               LET g_detail_idx_list[3] = l_ac
               CALL g_idx_group.addAttribute("'3',",l_ac)
               
               #add-point:page2, before row動作 name="ui_dialog.body2.before_row"

               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在下階單身則控制筆數位置
               IF g_loc = 'd' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
               END IF
               LET g_loc = 'd'
               LET l_ac = DIALOG.getCurrentRow("s_detail3")
               LET g_current_page = 3
               #顯示單身筆數
               CALL aint701_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"

               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"

            #end add-point
         
         END DISPLAY
         DISPLAY ARRAY g_inbn4_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b)  
    
            BEFORE ROW
               #顯示單身筆數
               CALL aint701_idx_chk()
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_detail_idx4 = l_ac
               LET g_detail_idx_list[4] = l_ac
               CALL g_idx_group.addAttribute("'4',",l_ac)
               
               #add-point:page2, before row動作 name="ui_dialog.body2.before_row"

               #end add-point
               
            BEFORE DISPLAY
               #如果一直都在下階單身則控制筆數位置
               IF g_loc = 'd' THEN
                  CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'4',"))
               END IF
               LET g_loc = 'd'
               LET l_ac = DIALOG.getCurrentRow("s_detail4")
               LET g_current_page = 4
               #顯示單身筆數
               CALL aint701_idx_chk()
               #add-point:page2自定義行為 name="ui_dialog.body2.before_display"

               #end add-point
      
            #自訂ACTION(detail_show,page_2)
            
         
            #add-point:page2自定義行為 name="ui_dialog.body2.action"

            #end add-point
         
         END DISPLAY
         #end add-point
         
         SUBDIALOG lib_cl_dlg.cl_dlg_qryplan
         SUBDIALOG lib_cl_dlg.cl_dlg_relateapps
      
         BEFORE DIALOG
            #先填充browser資料
            CALL aint701_browser_fill("")
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
               CALL aint701_fetch('') # reload data
            END IF
            #LET g_detail_idx = 1
            CALL aint701_ui_detailshow() #Setting the current row 
            
            #筆數顯示
            LET g_current_page = 1
            CALL aint701_idx_chk()
            CALL cl_ap_performance_cal()
            #add-point:ui_dialog段before_dialog2 name="ui_dialog.before_dialog2"
            LET g_inbm_m.l_symbol = '0'
            DISPLAY BY NAME g_inbm_m.l_symbol
            LET g_delete_flag = FALSE
            #end add-point
 
         #add-point:ui_dialog段more_action name="ui_dialog.more_action"
         
         #end add-point
 
         #狀態碼切換
         ON ACTION statechange
            LET g_action_choice = "statechange"
            CALL aint701_statechange()
            #根據資料狀態切換action狀態
            CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
            CALL aint701_set_act_visible()   
            CALL aint701_set_act_no_visible()
            IF NOT (g_inbm_m.inbmdocno IS NULL
 
              ) THEN
               #組合條件
               LET g_add_browse = " inbment = " ||g_enterprise|| " AND",
                                  " inbmdocno = '", g_inbm_m.inbmdocno, "' "
 
               #填到對應位置
               CALL aint701_browser_fill("")
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
                     WHEN la_wc[li_idx].tableid = "inbm_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "inbn_t" 
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
               CALL aint701_browser_fill("F")   #browser_fill()會將notice區塊清空
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
                     WHEN la_wc[li_idx].tableid = "inbm_t" 
                        LET g_wc = la_wc[li_idx].wc
                     WHEN la_wc[li_idx].tableid = "inbn_t" 
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
                  CALL aint701_browser_fill("F")
                  IF g_browser_cnt = 0 THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "" 
                     LET g_errparam.code = "-100" 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     CLEAR FORM
                  ELSE
                     CALL aint701_fetch("F")
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
               CALL aint701_filter()
               EXIT DIALOG
 
 
 
         
         ON ACTION first
            LET g_action_choice = "fetch"
            CALL aint701_fetch('F')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aint701_idx_chk()
            
         ON ACTION previous
            LET g_action_choice = "fetch"
            CALL aint701_fetch('P')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aint701_idx_chk()
            
         ON ACTION jump
            LET g_action_choice = "fetch"
            CALL aint701_fetch('/')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aint701_idx_chk()
            
         ON ACTION next
            LET g_action_choice = "fetch"
            CALL aint701_fetch('N')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aint701_idx_chk()
            
         ON ACTION last
            LET g_action_choice = "fetch"
            CALL aint701_fetch('L')
            LET g_current_row = g_current_idx
            LET g_curr_diag = ui.DIALOG.getCurrent()
            CALL aint701_idx_chk()
          
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
                  LET g_export_node[1] = base.typeInfo.create(g_inbn_d)
                  LET g_export_id[1]   = "s_detail1"
                  LET g_export_node[2] = base.typeInfo.create(g_inbn2_d)
                  LET g_export_id[2]   = "s_detail2"
 
                  #add-point:ON ACTION exporttoexcel name="menu.exporttoexcel"
                  #161213-00022#2 20161216 add by beckxie---S
                  LET g_export_node[3] = base.typeInfo.CREATE(g_inbn4_d)
                  LET g_export_id[3]   = "s_detail4"
                  LET g_export_node[4] = base.typeInfo.CREATE(g_inbn3_d)
                  LET g_export_id[4]   = "s_detail3"
                  #161213-00022#2 20161216 add by beckxie---E
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
               NEXT FIELD inbn001
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
               CALL aint701_modify()
               #add-point:ON ACTION modify name="menu.modify"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION modify_detail
            LET g_action_choice="modify_detail"
            IF cl_auth_chk_act("modify") THEN
               LET g_aw = g_curr_diag.getCurrentItem()
               CALL aint701_modify()
               #add-point:ON ACTION modify_detail name="menu.modify_detail"
               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION print_g02
            LET g_action_choice="print_g02"
               
               #add-point:ON ACTION print_g02 name="menu.print_g02"
               CALL aint701_print('2')   #170119-00027#1 20170120 add by beckxie
               #END add-point
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION output
            LET g_action_choice="output"
            IF cl_auth_chk_act("output") THEN
               
               #add-point:ON ACTION output name="menu.output"
               
               #END add-point
               &include "erp/ain/aint701_rep.4gl"
               #add-point:ON ACTION output.after name="menu.after_output"
               #CALL aint701_01(g_inbm_m.inbmdocno,g_inbm_m.inbn001_1)
               IF NOT cl_null(g_inbm_m.inbmdocno) THEN
                  LET la_param.prog = 'ainr701'
                  LET la_param.param[1] = g_inbm_m.inbmdocno
                  LET la_param.param[3] = 'aint701'          #170119-00027#1 20170123 add by beckxie
                  LET ls_js = util.JSON.stringify(la_param)
                  #CALL cl_cmdrun_wait(ls_js)
                  CALL cl_cmdrun(ls_js)
               END IF               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION quickprint
            LET g_action_choice="quickprint"
            IF cl_auth_chk_act("quickprint") THEN
               
               #add-point:ON ACTION quickprint name="menu.quickprint"
               #170119-00027#1 20170120 add by beckxie---S
               IF NOT cl_null(g_inbm_m.inbmdocno) THEN
                  LET la_param.prog = 'ainr701'
                  LET la_param.param[1] = g_inbm_m.inbmdocno
                  LET la_param.param[3] = 'aint701'
                  LET ls_js = util.JSON.stringify(la_param)
                  CALL cl_cmdrun(ls_js)
               END IF
               #170119-00027#1 20170120 add by beckxie---E
               #END add-point
               &include "erp/ain/aint701_rep.4gl"
               #add-point:ON ACTION quickprint.after name="menu.after_quickprint"
               #CALL aint701_01(g_inbm_m.inbmdocno,g_inbm_m.inbn001_1)
               IF NOT cl_null(g_inbm_m.inbmdocno) THEN
                  LET la_param.prog = 'ainr701'
                  LET la_param.param[1] = g_inbm_m.inbmdocno
                  LET la_param.param[3] = 'aint701'          #170119-00027#1 20170123 add by beckxie
                  LET ls_js = util.JSON.stringify(la_param)
                  #CALL cl_cmdrun_wait(ls_js)
                  CALL cl_cmdrun(ls_js)
               END IF               
               #END add-point
               
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION print_g01
            LET g_action_choice="print_g01"
               
               #add-point:ON ACTION print_g01 name="menu.print_g01"
               CALL aint701_print('1')   #170119-00027#1 20170120 add by beckxie
               #END add-point
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION query
            LET g_action_choice="query"
            IF cl_auth_chk_act("query") THEN
               CALL aint701_query()
               #add-point:ON ACTION query name="menu.query"
               
               #END add-point
               #應用 a59 樣板自動產生(Version:3)  
               CALL g_curr_diag.setCurrentRow("s_detail1",1)
               CALL g_curr_diag.setCurrentRow("s_detail2",1)
 
 
 
 
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION seal_box
            LET g_action_choice="seal_box"
               
               #add-point:ON ACTION seal_box name="menu.seal_box"
               IF NOT cl_null(g_inbm_m.inbmdocno) AND NOT cl_null(g_inbm_m.inbn001_1) THEN
                  CALL aint701_02(g_inbm_m.inbmdocno,g_inbm_m.inbn001_1)
                  LET INT_FLAG = 0
                  CALL aint701_set_act_visible()
                  CALL aint701_set_act_no_visible()
                  CALL aint701_b_fill()
               END IF
               #END add-point
 
 
 
 
         
         #應用 a46 樣板自動產生(Version:3)
         #新增相關文件
         ON ACTION related_document
            CALL aint701_set_pk_array()
            IF cl_auth_chk_act("related_document") THEN
               #add-point:ON ACTION related_document name="ui_dialog.dialog.related_document"
               
               #END add-point
               CALL cl_doc()
            END IF
            
         ON ACTION agendum
            CALL aint701_set_pk_array()
            #add-point:ON ACTION agendum name="ui_dialog.dialog.agendum"
            
            #END add-point
            CALL cl_user_overview()
            CALL cl_user_overview_set_follow_pic()
         
         ON ACTION followup
            CALL aint701_set_pk_array()
            #add-point:ON ACTION followup name="ui_dialog.dialog.followup"
            
            #END add-point
            CALL cl_user_overview_follow(g_inbm_m.inbmdocdt)
 
 
 
         
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
 
{<section id="aint701.browser_fill" >}
#+ 瀏覽頁簽資料填充
PRIVATE FUNCTION aint701_browser_fill(ps_page_action)
   #add-point:browser_fill段define(客製用) name="browser_fill.define_customerization"
   
   #end add-point  
   DEFINE ps_page_action    STRING
   DEFINE l_wc              STRING
   DEFINE l_wc2             STRING
   DEFINE l_sql             STRING
   DEFINE l_sub_sql         STRING
   DEFINE l_sql_rank        STRING
   #add-point:browser_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="browser_fill.define"
   DEFINE l_where           STRING    #161006-00008#6 Add By Ken 161018
   #end add-point    
   
   #add-point:Function前置處理 name="browser_fill.before_browser_fill"
   #161006-00008#6 Add By Ken 161018(S)
   LET l_where = s_aooi500_sql_where(g_prog,'inbmsite')   
   IF cl_null(g_wc) THEN
      LET g_wc = l_where
   ELSE
      LET g_wc = g_wc CLIPPED," AND ",l_where
   END IF   
   #161006-00008#6 Add By Ken 161018(E)
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
      LET l_sub_sql = " SELECT DISTINCT inbmdocno ",
                      " FROM inbm_t ",
                      " ",
                      " LEFT JOIN inbn_t ON inbnent = inbment AND inbmdocno = inbndocno ", "  ",
                      #add-point:browser_fill段sql(inbn_t1) name="browser_fill.cnt.join.}"
 
                      #end add-point
 
                      " LEFT JOIN inbo_t ON inboent = inbment AND inbndocno = inbodocno AND inbn001 = inbo001", "  ",
                      #add-point:browser_fill段sql(inbo_t1) name="browser_fill.cnt.join.inbo_t1"
 
                      #end add-point
 
 
                      " ", 
                      " ", 
 
                      " ",
 
 
                      " WHERE inbment = " ||g_enterprise|| " AND inbnent = " ||g_enterprise|| " AND ",l_wc, " AND ", l_wc2, cl_sql_add_filter("inbm_t")
   ELSE
      #單身未輸入搜尋條件
      LET l_sub_sql = " SELECT DISTINCT inbmdocno ",
                      " FROM inbm_t ", 
                      "  ",
                      "  ",
                      " WHERE inbment = " ||g_enterprise|| " AND ",l_wc CLIPPED, cl_sql_add_filter("inbm_t")
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
      INITIALIZE g_inbm_m.* TO NULL
      CALL g_inbn_d.clear()        
      CALL g_inbn2_d.clear() 
 
      #add-point:browser_fill g_add_browse段額外處理 name="browser_fill.add_browse.other"
      CALL g_inbn3_d.clear()
      CALL g_inbn4_d.clear()
      #end add-point   
      CALL g_browser.clear()
      LET g_cnt = 1
   ELSE
      LET l_wc  = g_add_browse
      LET l_wc2 = " 1=1" 
      LET g_cnt = g_current_idx
   END IF
 
   #依照t0.inbmsite,t0.inbmdocdt,t0.inbmdocno,t0.inbmunit,t0.inbm001,t0.inbm002,t0.inbm007,t0.inbmstus,t0.inbm008 Browser欄位定義(取代原本bs_sql功能)
   #考量到單身可能下條件, 所以此處需join單身所有table
   #DISTINCT是為了避免在join時出現重複的資料(如果不加DISTINCT則須在程式中過濾)
   IF g_wc2 <> " 1=1" THEN
      #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.inbmstus,t0.inbmsite,t0.inbmdocdt,t0.inbmdocno,t0.inbmunit,t0.inbm001, 
          t0.inbm002,t0.inbm007,t0.inbmstus,t0.inbm008,t1.ooefl003 ,t2.ooefl003 ,t3.ooefl003 ",
                  " FROM inbm_t t0",
                  "  ",
                  "  LEFT JOIN inbn_t ON inbnent = inbment AND inbmdocno = inbndocno ", "  ", 
                  #add-point:browser_fill段sql(inbn_t1) name="browser_fill.join.inbn_t1"
                  
                  #end add-point
 
                  "  LEFT JOIN inbo_t ON inboent = inbment AND inbndocno = inbodocno AND inbn001 = inbo001", "  ", 
                  #add-point:browser_fill段sql(inbo_t1) name="browser_fill.join.inbo_t1"
                  
                  #end add-point
 
 
                  " ", 
 
                  " ",
 
 
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.inbmsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.inbmunit AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.inbm001 AND t3.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.inbment = " ||g_enterprise|| " AND ",l_wc," AND ",l_wc2, cl_sql_add_filter("inbm_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.inbmstus,t0.inbmsite,t0.inbmdocdt,t0.inbmdocno,t0.inbmunit,t0.inbm001, 
          t0.inbm002,t0.inbm007,t0.inbmstus,t0.inbm008,t1.ooefl003 ,t2.ooefl003 ,t3.ooefl003 ",
                  " FROM inbm_t t0",
                  "  ",
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.inbmsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.inbmunit AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.inbm001 AND t3.ooefl002='"||g_dlang||"' ",
 
                  " WHERE t0.inbment = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("inbm_t")
   END IF
   #add-point:browser_fill,sql wc name="browser_fill.fill_sqlwc"
   IF g_wc2 <> " 1=1" THEN
   #單身有輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.inbmstus,t0.inbmsite,t0.inbmdocdt,t0.inbmdocno,t0.inbmunit,t0.inbm001, 
          t0.inbm002,t0.inbm007,t0.inbmstus,t0.inbm008,t1.ooefl003 ,t2.ooefl003 ,",
          #161024-00023#4 20161025 modify by beckxie---S
          #" CASE WHEN t0.inbm008 = '1' THEN t3.ooefl003 ELSE t4.pmaal004 END ",
          "  CASE WHEN t0.inbm008 = '1' THEN t3.ooefl003 ",
          "       WHEN t0.inbm008 = '2' THEN t4.pmaal004 ",
          "       WHEN t0.inbm008 = '3' THEN t4.pmaal004 END",
          #161024-00023#4 20161025 modify by beckxie---E
          
                  " FROM inbm_t t0",
                  "  ",
                  "  LEFT JOIN inbn_t ON inbnent = inbment AND inbmdocno = inbndocno ", "  ", 
                  #add-point:browser_fill段sql(inbn_t1) name="browser_fill.join.inbn_t1"
                  "  LEFT JOIN inbp_t ON inbpent = inbment AND inbpdocno = inbmdocno ",   #161024-00023#21 20161121 add by beckxie
                  "  LEFT JOIN indj_t ON indjent = inbpent AND indjdocno = inbp002 AND indjseq = inbp003 AND inbp001 = '4' ",   #161208-00023#3 20161208 add by beckxie
                  #end add-point
 
                  "  LEFT JOIN inbo_t ON inboent = inbment AND inbndocno = inbodocno AND inbn001 = inbo001", "  ", 
                  #add-point:browser_fill段sql(inbo_t1) name="browser_fill.join.inbo_t1"
                  #end add-point
 
 
                  " ", 
 
                  " ",
 
 
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.inbmsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.inbmunit AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.inbm001 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t4 ON t4.pmaalent="||g_enterprise||" AND t4.pmaal001 = t0.inbm001 AND t4.pmaal002 = '"||g_dlang||"' ",
 
                  " WHERE t0.inbment = " ||g_enterprise|| " AND ",l_wc,"   AND ",l_wc2,cl_sql_add_filter("inbm_t")
   ELSE
      #單身無輸入搜尋條件   
      LET g_sql = " SELECT DISTINCT t0.inbmstus,t0.inbmsite,t0.inbmdocdt,t0.inbmdocno,t0.inbmunit,t0.inbm001, 
          t0.inbm002,t0.inbm007,t0.inbmstus,t0.inbm008,t1.ooefl003 ,t2.ooefl003 ,",
          " CASE WHEN t0.inbm008 = '1' THEN t3.ooefl003 ELSE t4.pmaal004 END ",
                  " FROM inbm_t t0",
                  "  ",
                                 " LEFT JOIN ooefl_t t1 ON t1.ooeflent="||g_enterprise||" AND t1.ooefl001=t0.inbmsite AND t1.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t2 ON t2.ooeflent="||g_enterprise||" AND t2.ooefl001=t0.inbmunit AND t2.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN ooefl_t t3 ON t3.ooeflent="||g_enterprise||" AND t3.ooefl001=t0.inbm001 AND t3.ooefl002='"||g_dlang||"' ",
               " LEFT JOIN pmaal_t t4 ON t4.pmaalent="||g_enterprise||" AND t4.pmaal001 = t0.inbm001 AND t4.pmaal002 = '"||g_dlang||"' ",
                  " WHERE t0.inbment = " ||g_enterprise|| " AND ",l_wc, cl_sql_add_filter("inbm_t")
   END IF
   #end add-point
   LET g_sql = g_sql, " ORDER BY inbmdocno ",g_order
 
   #add-point:browser_fill,before_prepare name="browser_fill.before_prepare"
   #DISPLAY "g_sql:" , g_sql
   #end add-point
        
   #LET g_sql = cl_sql_add_tabid(g_sql,"inbm_t") #WC重組
   LET g_sql = cl_sql_add_mask(g_sql) #遮蔽特定資料
   
   IF g_sql.getIndexOf(" 1=2",1) THEN
      DISPLAY "INFO: 1=2 jumped!"
   ELSE
      PREPARE browse_pre FROM g_sql
      DECLARE browse_cur CURSOR FOR browse_pre
      
      #add-point:browser_fill段open cursor name="browser_fill.open"
      
      #end add-point
      
      FOREACH browse_cur INTO g_browser[g_cnt].b_statepic,g_browser[g_cnt].b_inbmsite,g_browser[g_cnt].b_inbmdocdt, 
          g_browser[g_cnt].b_inbmdocno,g_browser[g_cnt].b_inbmunit,g_browser[g_cnt].b_inbm001,g_browser[g_cnt].b_inbm002, 
          g_browser[g_cnt].b_inbm007,g_browser[g_cnt].b_inbmstus,g_browser[g_cnt].b_inbm008,g_browser[g_cnt].b_inbmsite_desc, 
          g_browser[g_cnt].b_inbmunit_desc,g_browser[g_cnt].b_inbm001_desc
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "Foreach:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
      
         #add-point:browser_fill段reference name="browser_fill.reference"
         #161017-00051#15 20161201 add by beckxie---S
         #該單據應裝數量,已裝數量總和
         LET g_browser[g_cnt].b_inbp008 = 0
         LET g_browser[g_cnt].b_inbp009 = 0
         EXECUTE aint701_sum_inbp_pre USING g_browser[g_cnt].b_inbmdocno
            INTO g_browser[g_cnt].b_inbp008,g_browser[g_cnt].b_inbp009
         #161017-00051#15 20161201 add by beckxie---E
         #end add-point
      
         #遮罩相關處理
         CALL aint701_browser_mask()
      
               #應用 a24 樣板自動產生(Version:3)
      #browser顯示圖片
      CASE g_browser[g_cnt].b_statepic
         WHEN "N"
            LET g_browser[g_cnt].b_statepic = "stus/16/unconfirmed.png"
         WHEN "Y"
            LET g_browser[g_cnt].b_statepic = "stus/16/confirmed.png"
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
   
   IF cl_null(g_browser[g_cnt].b_inbmdocno) THEN
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
 
{<section id="aint701.ui_headershow" >}
#+ 單頭資料重新顯示
PRIVATE FUNCTION aint701_ui_headershow()
   #add-point:ui_headershow段define(客製用) name="ui_headershow.define_customerization"
   
   #end add-point  
   #add-point:ui_headershow段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ui_headershow.define"
   
   #end add-point      
   
   #add-point:Function前置處理  name="ui_headershow.pre_function"
 
   #end add-point
   
   LET g_inbm_m.inbmdocno = g_browser[g_current_idx].b_inbmdocno   
 
   EXECUTE aint701_master_referesh USING g_inbm_m.inbmdocno INTO g_inbm_m.inbmsite,g_inbm_m.inbmdocdt, 
       g_inbm_m.inbmdocno,g_inbm_m.inbm003,g_inbm_m.inbm005,g_inbm_m.inbm006,g_inbm_m.inbm007,g_inbm_m.inbm004, 
       g_inbm_m.inbm001,g_inbm_m.inbm002,g_inbm_m.inbmunit,g_inbm_m.inbm008,g_inbm_m.inbmstus,g_inbm_m.inbmownid, 
       g_inbm_m.inbmowndp,g_inbm_m.inbmcrtid,g_inbm_m.inbmcrtdp,g_inbm_m.inbmcrtdt,g_inbm_m.inbmmodid, 
       g_inbm_m.inbmmoddt,g_inbm_m.inbmcnfid,g_inbm_m.inbmcnfdt,g_inbm_m.inbmsite_desc,g_inbm_m.inbm005_desc, 
       g_inbm_m.inbm006_desc,g_inbm_m.inbm001_desc,g_inbm_m.inbmunit_desc,g_inbm_m.inbmownid_desc,g_inbm_m.inbmowndp_desc, 
       g_inbm_m.inbmcrtid_desc,g_inbm_m.inbmcrtdp_desc,g_inbm_m.inbmmodid_desc,g_inbm_m.inbmcnfid_desc 
 
   
   CALL aint701_inbm_t_mask()
   CALL aint701_show()
      
END FUNCTION
 
{</section>}
 
{<section id="aint701.ui_detailshow" >}
#+ 單身資料重新顯示
PRIVATE FUNCTION aint701_ui_detailshow()
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
 
{<section id="aint701.ui_browser_refresh" >}
#+ 瀏覽頁簽資料重新顯示
PRIVATE FUNCTION aint701_ui_browser_refresh()
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
      IF g_browser[l_i].b_inbmdocno = g_inbm_m.inbmdocno 
 
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
 
{<section id="aint701.construct" >}
#+ QBE資料查詢
PRIVATE FUNCTION aint701_construct()
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
   INITIALIZE g_inbm_m.* TO NULL
   CALL g_inbn_d.clear()        
   CALL g_inbn2_d.clear() 
 
   
   LET g_action_choice = ""
    
   INITIALIZE g_wc TO NULL
   INITIALIZE g_wc2 TO NULL
   
   INITIALIZE g_wc2_table1 TO NULL
 
    
   LET g_qryparam.state = 'c'
   
   #add-point:cs段開始前 name="cs.before_construct"
   CALL g_inbn3_d.clear()
   CALL g_inbn4_d.clear()
   #161208-00023#3 20161208 add by beckxie---S
   CALL aint701_set_comp_visible_b()
   CALL aint701_set_comp_no_visible_b()
   #161208-00023#3 20161208 add by beckxie---E
   #end add-point 
   
   #使用DIALOG包住 單頭CONSTRUCT及單身CONSTRUCT
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      
      #單頭
      CONSTRUCT BY NAME g_wc ON inbmsite,inbmdocdt,inbmdocno,inbm003,inbm005,inbm006,inbm007,inbm004, 
          inbm001,inbm002,inbmunit,inbm008,inbmstus,inbmownid,inbmowndp,inbmcrtid,inbmcrtdp,inbmcrtdt, 
          inbmmodid,inbmmoddt,inbmcnfid,inbmcnfdt,inbo010_1
 
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.head.before_construct"
            
            #end add-point 
            
         #公用欄位開窗相關處理
         #應用 a11 樣板自動產生(Version:3)
         #共用欄位查詢處理  
         ##----<<inbmcrtdt>>----
         AFTER FIELD inbmcrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
 
         #----<<inbmmoddt>>----
         AFTER FIELD inbmmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<inbmcnfdt>>----
         AFTER FIELD inbmcnfdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)
         
         #----<<inbmpstdt>>----
 
 
 
            
         #一般欄位開窗相關處理    
                  #Ctrlp:construct.c.inbmsite
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbmsite
            #add-point:ON ACTION controlp INFIELD inbmsite name="construct.c.inbmsite"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'inbmsite',g_site,'c')   #161006-00008#6 Add By Ken 161018            
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbmsite  #顯示到畫面上
            NEXT FIELD inbmsite                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbmsite
            #add-point:BEFORE FIELD inbmsite name="construct.b.inbmsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbmsite
            
            #add-point:AFTER FIELD inbmsite name="construct.a.inbmsite"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbmdocdt
            #add-point:BEFORE FIELD inbmdocdt name="construct.b.inbmdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbmdocdt
            
            #add-point:AFTER FIELD inbmdocdt name="construct.a.inbmdocdt"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inbmdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbmdocdt
            #add-point:ON ACTION controlp INFIELD inbmdocdt name="construct.c.inbmdocdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.inbmdocno
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbmdocno
            #add-point:ON ACTION controlp INFIELD inbmdocno name="construct.c.inbmdocno"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inbmdocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbmdocno  #顯示到畫面上
            NEXT FIELD inbmdocno                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbmdocno
            #add-point:BEFORE FIELD inbmdocno name="construct.b.inbmdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbmdocno
            
            #add-point:AFTER FIELD inbmdocno name="construct.a.inbmdocno"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbm003
            #add-point:BEFORE FIELD inbm003 name="construct.b.inbm003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbm003
            
            #add-point:AFTER FIELD inbm003 name="construct.a.inbm003"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inbm003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbm003
            #add-point:ON ACTION controlp INFIELD inbm003 name="construct.c.inbm003"
            
            #END add-point
 
 
         #Ctrlp:construct.c.inbm005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbm005
            #add-point:ON ACTION controlp INFIELD inbm005 name="construct.c.inbm005"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbm005  #顯示到畫面上
            NEXT FIELD inbm005                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbm005
            #add-point:BEFORE FIELD inbm005 name="construct.b.inbm005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbm005
            
            #add-point:AFTER FIELD inbm005 name="construct.a.inbm005"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inbm006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbm006
            #add-point:ON ACTION controlp INFIELD inbm006 name="construct.c.inbm006"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_4()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbm006  #顯示到畫面上
            NEXT FIELD inbm006                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbm006
            #add-point:BEFORE FIELD inbm006 name="construct.b.inbm006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbm006
            
            #add-point:AFTER FIELD inbm006 name="construct.a.inbm006"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbm007
            #add-point:BEFORE FIELD inbm007 name="construct.b.inbm007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbm007
            
            #add-point:AFTER FIELD inbm007 name="construct.a.inbm007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inbm007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbm007
            #add-point:ON ACTION controlp INFIELD inbm007 name="construct.c.inbm007"
            
            #END add-point
 
 
         #Ctrlp:construct.c.inbm004
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbm004
            #add-point:ON ACTION controlp INFIELD inbm004 name="construct.c.inbm004"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_indidocno()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbm004  #顯示到畫面上
            NEXT FIELD inbm004                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbm004
            #add-point:BEFORE FIELD inbm004 name="construct.b.inbm004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbm004
            
            #add-point:AFTER FIELD inbm004 name="construct.a.inbm004"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inbm001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbm001
            #add-point:ON ACTION controlp INFIELD inbm001 name="construct.c.inbm001"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmcz062()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbm001  #顯示到畫面上
            NEXT FIELD inbm001                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbm001
            #add-point:BEFORE FIELD inbm001 name="construct.b.inbm001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbm001
            
            #add-point:AFTER FIELD inbm001 name="construct.a.inbm001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inbm002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbm002
            #add-point:ON ACTION controlp INFIELD inbm002 name="construct.c.inbm002"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmcz001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbm002  #顯示到畫面上
            NEXT FIELD inbm002                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbm002
            #add-point:BEFORE FIELD inbm002 name="construct.b.inbm002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbm002
            
            #add-point:AFTER FIELD inbm002 name="construct.a.inbm002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inbmunit
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbmunit
            #add-point:ON ACTION controlp INFIELD inbmunit name="construct.c.inbmunit"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = s_aooi500_q_where(g_prog,'inbmunit',g_site,'c')   #161006-00008#6 Add By Ken 161018            
            CALL q_ooef001_24()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbmunit  #顯示到畫面上
            NEXT FIELD inbmunit                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbmunit
            #add-point:BEFORE FIELD inbmunit name="construct.b.inbmunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbmunit
            
            #add-point:AFTER FIELD inbmunit name="construct.a.inbmunit"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbm008
            #add-point:BEFORE FIELD inbm008 name="construct.b.inbm008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbm008
            
            #add-point:AFTER FIELD inbm008 name="construct.a.inbm008"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inbm008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbm008
            #add-point:ON ACTION controlp INFIELD inbm008 name="construct.c.inbm008"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbmstus
            #add-point:BEFORE FIELD inbmstus name="construct.b.inbmstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbmstus
            
            #add-point:AFTER FIELD inbmstus name="construct.a.inbmstus"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inbmstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbmstus
            #add-point:ON ACTION controlp INFIELD inbmstus name="construct.c.inbmstus"
            
            #END add-point
 
 
         #Ctrlp:construct.c.inbmownid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbmownid
            #add-point:ON ACTION controlp INFIELD inbmownid name="construct.c.inbmownid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbmownid  #顯示到畫面上
            NEXT FIELD inbmownid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbmownid
            #add-point:BEFORE FIELD inbmownid name="construct.b.inbmownid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbmownid
            
            #add-point:AFTER FIELD inbmownid name="construct.a.inbmownid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inbmowndp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbmowndp
            #add-point:ON ACTION controlp INFIELD inbmowndp name="construct.c.inbmowndp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbmowndp  #顯示到畫面上
            NEXT FIELD inbmowndp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbmowndp
            #add-point:BEFORE FIELD inbmowndp name="construct.b.inbmowndp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbmowndp
            
            #add-point:AFTER FIELD inbmowndp name="construct.a.inbmowndp"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inbmcrtid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbmcrtid
            #add-point:ON ACTION controlp INFIELD inbmcrtid name="construct.c.inbmcrtid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbmcrtid  #顯示到畫面上
            NEXT FIELD inbmcrtid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbmcrtid
            #add-point:BEFORE FIELD inbmcrtid name="construct.b.inbmcrtid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbmcrtid
            
            #add-point:AFTER FIELD inbmcrtid name="construct.a.inbmcrtid"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inbmcrtdp
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbmcrtdp
            #add-point:ON ACTION controlp INFIELD inbmcrtdp name="construct.c.inbmcrtdp"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooeg001_9()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbmcrtdp  #顯示到畫面上
            NEXT FIELD inbmcrtdp                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbmcrtdp
            #add-point:BEFORE FIELD inbmcrtdp name="construct.b.inbmcrtdp"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbmcrtdp
            
            #add-point:AFTER FIELD inbmcrtdp name="construct.a.inbmcrtdp"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbmcrtdt
            #add-point:BEFORE FIELD inbmcrtdt name="construct.b.inbmcrtdt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.inbmmodid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbmmodid
            #add-point:ON ACTION controlp INFIELD inbmmodid name="construct.c.inbmmodid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbmmodid  #顯示到畫面上
            NEXT FIELD inbmmodid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbmmodid
            #add-point:BEFORE FIELD inbmmodid name="construct.b.inbmmodid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbmmodid
            
            #add-point:AFTER FIELD inbmmodid name="construct.a.inbmmodid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbmmoddt
            #add-point:BEFORE FIELD inbmmoddt name="construct.b.inbmmoddt"
            
            #END add-point
 
 
         #Ctrlp:construct.c.inbmcnfid
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbmcnfid
            #add-point:ON ACTION controlp INFIELD inbmcnfid name="construct.c.inbmcnfid"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooag001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbmcnfid  #顯示到畫面上
            NEXT FIELD inbmcnfid                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbmcnfid
            #add-point:BEFORE FIELD inbmcnfid name="construct.b.inbmcnfid"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbmcnfid
            
            #add-point:AFTER FIELD inbmcnfid name="construct.a.inbmcnfid"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbmcnfdt
            #add-point:BEFORE FIELD inbmcnfdt name="construct.b.inbmcnfdt"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbo010_1
            #add-point:BEFORE FIELD inbo010_1 name="construct.b.inbo010_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbo010_1
            
            #add-point:AFTER FIELD inbo010_1 name="construct.a.inbo010_1"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.inbo010_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbo010_1
            #add-point:ON ACTION controlp INFIELD inbo010_1 name="construct.c.inbo010_1"
            
            #END add-point
 
 
 
         
      END CONSTRUCT
 
      #單身根據table分拆construct
      CONSTRUCT g_wc2_table1 ON inbnsite,inbnunit,inbn001,l_count,inbn002
           FROM s_detail1[1].inbnsite,s_detail1[1].inbnunit,s_detail1[1].inbn001,s_detail1[1].l_count, 
               s_detail1[1].inbn002
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理
       
         
       #單身一般欄位開窗相關處理
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbnsite
            #add-point:BEFORE FIELD inbnsite name="construct.b.page1.inbnsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbnsite
            
            #add-point:AFTER FIELD inbnsite name="construct.a.page1.inbnsite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbnsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbnsite
            #add-point:ON ACTION controlp INFIELD inbnsite name="construct.c.page1.inbnsite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbnunit
            #add-point:BEFORE FIELD inbnunit name="construct.b.page1.inbnunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbnunit
            
            #add-point:AFTER FIELD inbnunit name="construct.a.page1.inbnunit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbnunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbnunit
            #add-point:ON ACTION controlp INFIELD inbnunit name="construct.c.page1.inbnunit"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page1.inbn001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbn001
            #add-point:ON ACTION controlp INFIELD inbn001 name="construct.c.page1.inbn001"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inbn001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbn001  #顯示到畫面上
            NEXT FIELD inbn001                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbn001
            #add-point:BEFORE FIELD inbn001 name="construct.b.page1.inbn001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbn001
            
            #add-point:AFTER FIELD inbn001 name="construct.a.page1.inbn001"
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_count
            #add-point:BEFORE FIELD l_count name="construct.b.page1.l_count"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_count
            
            #add-point:AFTER FIELD l_count name="construct.a.page1.l_count"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.l_count
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_count
            #add-point:ON ACTION controlp INFIELD l_count name="construct.c.page1.l_count"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbn002
            #add-point:BEFORE FIELD inbn002 name="construct.b.page1.inbn002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbn002
            
            #add-point:AFTER FIELD inbn002 name="construct.a.page1.inbn002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page1.inbn002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbn002
            #add-point:ON ACTION controlp INFIELD inbn002 name="construct.c.page1.inbn002"
            
            #END add-point
 
 
   
       
      END CONSTRUCT
      
 
      
      CONSTRUCT g_wc2_table2 ON inbosite,inbounit,inbo002,inbo001,inbo010,inbo006,inbo007,inbo008
           FROM s_detail2[1].inbosite,s_detail2[1].inbounit,s_detail2[1].inbo002,s_detail2[1].inbo001, 
               s_detail2[1].inbo010,s_detail2[1].inbo006,s_detail2[1].inbo007,s_detail2[1].inbo008
                      
         BEFORE CONSTRUCT
            #add-point:cs段before_construct name="cs.body2.before_construct"
            
            #end add-point 
            
       #單身公用欄位開窗相關處理(table 2)
       
       
       #單身一般欄位開窗相關處理       
                #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbosite
            #add-point:BEFORE FIELD inbosite name="construct.b.page2.inbosite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbosite
            
            #add-point:AFTER FIELD inbosite name="construct.a.page2.inbosite"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.inbosite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbosite
            #add-point:ON ACTION controlp INFIELD inbosite name="construct.c.page2.inbosite"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbounit
            #add-point:BEFORE FIELD inbounit name="construct.b.page2.inbounit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbounit
            
            #add-point:AFTER FIELD inbounit name="construct.a.page2.inbounit"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.inbounit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbounit
            #add-point:ON ACTION controlp INFIELD inbounit name="construct.c.page2.inbounit"
            
            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbo002
            #add-point:BEFORE FIELD inbo002 name="construct.b.page2.inbo002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbo002
            
            #add-point:AFTER FIELD inbo002 name="construct.a.page2.inbo002"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.inbo002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbo002
            #add-point:ON ACTION controlp INFIELD inbo002 name="construct.c.page2.inbo002"
            
            #END add-point
 
 
         #Ctrlp:construct.c.page2.inbo001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbo001
            #add-point:ON ACTION controlp INFIELD inbo001 name="construct.c.page2.inbo001"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inbn001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbo001  #顯示到畫面上
            NEXT FIELD inbo001                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbo001
            #add-point:BEFORE FIELD inbo001 name="construct.b.page2.inbo001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbo001
            
            #add-point:AFTER FIELD inbo001 name="construct.a.page2.inbo001"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.inbo010
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbo010
            #add-point:ON ACTION controlp INFIELD inbo010 name="construct.c.page2.inbo010"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imay003_2()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbo010  #顯示到畫面上
            NEXT FIELD inbo010                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbo010
            #add-point:BEFORE FIELD inbo010 name="construct.b.page2.inbo010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbo010
            
            #add-point:AFTER FIELD inbo010 name="construct.a.page2.inbo010"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.inbo006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbo006
            #add-point:ON ACTION controlp INFIELD inbo006 name="construct.c.page2.inbo006"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbo006  #顯示到畫面上
            NEXT FIELD inbo006                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbo006
            #add-point:BEFORE FIELD inbo006 name="construct.b.page2.inbo006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbo006
            
            #add-point:AFTER FIELD inbo006 name="construct.a.page2.inbo006"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.inbo007
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbo007
            #add-point:ON ACTION controlp INFIELD inbo007 name="construct.c.page2.inbo007"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inbo007()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbo007  #顯示到畫面上
            NEXT FIELD inbo007                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbo007
            #add-point:BEFORE FIELD inbo007 name="construct.b.page2.inbo007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbo007
            
            #add-point:AFTER FIELD inbo007 name="construct.a.page2.inbo007"
            
            #END add-point
            
 
 
         #Ctrlp:construct.c.page2.inbo008
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbo008
            #add-point:ON ACTION controlp INFIELD inbo008 name="construct.c.page2.inbo008"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbo008  #顯示到畫面上
            NEXT FIELD inbo008                     #返回原欄位
    



            #END add-point
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbo008
            #add-point:BEFORE FIELD inbo008 name="construct.b.page2.inbo008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbo008
            
            #add-point:AFTER FIELD inbo008 name="construct.a.page2.inbo008"
            
            #END add-point
            
 
 
   
       
      END CONSTRUCT
 
 
      
      #add-point:cs段add_cs(本段內只能出現新的CONSTRUCT指令) name="cs.add_cs"
      #161024-00023#21 20161121 add by beckxie---S
      #單據明細
      #CONSTRUCT g_wc4_table1 ON inbp001,inbp002,inbp003,inbp010,inbp011,   #161220-00037#3 20161222 mark by beckxie
      CONSTRUCT g_wc4_table1 ON inbpseq,                                    #161220-00037#3 20161222 add by beckxie
                                inbp001,inbp002,inbp003,inbp010,inbp011,    #161220-00037#3 20161222 add by beckxie
                                inbp012,inbp004,inbp005,inbp006,inbp007,
                                inbp008,inbp009,
                                indj012,indj013,indj015,indj016   #161208-00023#3 20161208 add by beckxie
                #FROM s_detail4[1].inbp001,s_detail4[1].inbp002,s_detail4[1].inbp003,s_detail4[1].inbp010,s_detail4[1].inbp011,   #161220-00037#3 20161222 mark by beckxie
                FROM s_detail4[1].inbpseq,                                                                                        #161220-00037#3 20161222 add by beckxie
                     s_detail4[1].inbp001,s_detail4[1].inbp002,s_detail4[1].inbp003,s_detail4[1].inbp010,s_detail4[1].inbp011,    #161220-00037#3 20161222 add by beckxie
                     s_detail4[1].inbp012,s_detail4[1].inbp004,s_detail4[1].inbp005,s_detail4[1].inbp006,s_detail4[1].inbp007,
                     s_detail4[1].inbp008,s_detail4[1].inbp009,
                     s_detail4[1].indj012,s_detail4[1].indj013,s_detail4[1].indj015,s_detail4[1].indj016   #161208-00023#3 20161208 add by beckxie
         ON ACTION controlp INFIELD inbp002
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_indidocno()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbp002  #顯示到畫面上
            NEXT FIELD inbp002                     #返回原欄位
            
         ON ACTION controlp INFIELD inbp011
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_pmcz062()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbp011  #顯示到畫面上
            NEXT FIELD inbp011                     #返回原欄位
            
         ON ACTION controlp INFIELD inbp004
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imay003_9()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbp004  #顯示到畫面上
            NEXT FIELD inbp004                     #返回原欄位
            
         ON ACTION controlp INFIELD inbp005
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbp005  #顯示到畫面上
            NEXT FIELD inbp005                     #返回原欄位   
            
         ON ACTION controlp INFIELD inbp006
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inbp006()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbp006  #顯示到畫面上
            NEXT FIELD inbp006                     #返回原欄位
            
         ON ACTION controlp INFIELD inbp007
            #add-point:ON ACTION controlp INFIELD inbm001 name="construct.c.inbm001"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbp007  #顯示到畫面上
            NEXT FIELD inbp007                     #返回原欄位
         #161208-00023#3 20161208 add by beckxie---S
         ON ACTION controlp INFIELD indj012
            #add-point:ON ACTION controlp INFIELD inbm001 name="construct.c.inbm001"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_23()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO indj012  #顯示到畫面上
            NEXT FIELD indj012                     #返回原欄位
            
         ON ACTION controlp INFIELD indj013
            #add-point:ON ACTION controlp INFIELD inbm001 name="construct.c.inbm001"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inab002_6()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO indj013  #顯示到畫面上
            NEXT FIELD indj013                     #返回原欄位
            
         ON ACTION controlp INFIELD indj015
            #add-point:ON ACTION controlp INFIELD inbm001 name="construct.c.inbm001"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inaa001_23()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO indj015  #顯示到畫面上
            NEXT FIELD indj015                     #返回原欄位
            
         ON ACTION controlp INFIELD indj016
            #add-point:ON ACTION controlp INFIELD inbm001 name="construct.c.inbm001"
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inab002_6()                     #呼叫開窗
            DISPLAY g_qryparam.return1 TO indj016  #顯示到畫面上
            NEXT FIELD indj016                     #返回原欄位   
            
         #161208-00023#3 20161208 add by beckxie---E         
      END CONSTRUCT
      #待裝明細
      CONSTRUCT g_wc3_table1 ON inbp005,inbp006,inbp007
                FROM s_detail3[1].inbp005_1,s_detail3[1].inbp006_1,s_detail3[1].inbp007_1
                
         ON ACTION controlp INFIELD inbp005_1
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_imaa001()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbp005_1  #顯示到畫面上
            NEXT FIELD inbp005_1                     #返回原欄位   
            
         ON ACTION controlp INFIELD inbp006_1
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_inbp006()                         #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbp006_1  #顯示到畫面上
            NEXT FIELD inbp006_1                     #返回原欄位
            
         ON ACTION controlp INFIELD inbp007_1
            #應用 a08 樣板自動產生(Version:3)
            #開窗c段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c' 
            LET g_qryparam.reqry = FALSE
            CALL q_ooca001_1()                       #呼叫開窗
            DISPLAY g_qryparam.return1 TO inbp007_1  #顯示到畫面上
            NEXT FIELD inbp007_1                     #返回原欄位
            
      END CONSTRUCT
      #161024-00023#21 20161121 add by beckxie---E
      #end add-point
 
      BEFORE DIALOG
         CALL cl_qbe_init()
         #add-point:cs段b_dialog name="cs.b_dialog"
         #add by geza 20161103 #161102-00026#6（S）
         LET g_inbn_d[1].inbn001 = ""
         DISPLAY ARRAY g_inbn_d TO s_detail1.*
            BEFORE DISPLAY
               EXIT DISPLAY
         END DISPLAY
         LET g_inbn2_d[1].inbo002 = ""
         DISPLAY ARRAY g_inbn2_d TO s_detail2.*
            BEFORE DISPLAY
               EXIT DISPLAY
         END DISPLAY
         #161024-00023#21 20161121 add by beckxie---S
         #待裝明細
         LET g_inbn3_d[1].inbp005 = ""
         DISPLAY ARRAY g_inbn3_d TO s_detail3.*
            BEFORE DISPLAY
               EXIT DISPLAY
         END DISPLAY
         #單據明細
         LET g_inbn4_d[1].inbp001 = ""
         DISPLAY ARRAY g_inbn4_d TO s_detail4.*
            BEFORE DISPLAY
               EXIT DISPLAY
         END DISPLAY
         #161024-00023#21 20161121 add by beckxie---E
         #add by geza 20161103 #161102-00026#6（E）
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
                  WHEN la_wc[li_idx].tableid = "inbm_t" 
                     LET g_wc = la_wc[li_idx].wc
                  WHEN la_wc[li_idx].tableid = "inbn_t" 
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
   #161024-00023#21 20161121 add by beckxie---S
   #待裝明細
   IF g_wc3_table1 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc3_table1 ," AND inbp008 != inbp009 "
   END IF
   #單據明細
   IF g_wc4_table1 <> " 1=1" THEN
      LET g_wc2 = g_wc2 ," AND ", g_wc4_table1
   END IF
   #161024-00023#21 20161121 add by beckxie---E
   #end add-point    
 
   IF INT_FLAG THEN
      RETURN
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aint701.filter" >}
#應用 a50 樣板自動產生(Version:8)
#+ filter過濾功能
PRIVATE FUNCTION aint701_filter()
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
      CONSTRUCT g_wc_filter ON inbmsite,inbmdocdt,inbmdocno,inbmunit,inbm001,inbm002,inbm007,inbmstus, 
          inbm008
                          FROM s_browse[1].b_inbmsite,s_browse[1].b_inbmdocdt,s_browse[1].b_inbmdocno, 
                              s_browse[1].b_inbmunit,s_browse[1].b_inbm001,s_browse[1].b_inbm002,s_browse[1].b_inbm007, 
                              s_browse[1].b_inbmstus,s_browse[1].b_inbm008
 
         BEFORE CONSTRUCT
               DISPLAY aint701_filter_parser('inbmsite') TO s_browse[1].b_inbmsite
            DISPLAY aint701_filter_parser('inbmdocdt') TO s_browse[1].b_inbmdocdt
            DISPLAY aint701_filter_parser('inbmdocno') TO s_browse[1].b_inbmdocno
            DISPLAY aint701_filter_parser('inbmunit') TO s_browse[1].b_inbmunit
            DISPLAY aint701_filter_parser('inbm001') TO s_browse[1].b_inbm001
            DISPLAY aint701_filter_parser('inbm002') TO s_browse[1].b_inbm002
            DISPLAY aint701_filter_parser('inbm007') TO s_browse[1].b_inbm007
            DISPLAY aint701_filter_parser('inbmstus') TO s_browse[1].b_inbmstus
            DISPLAY aint701_filter_parser('inbm008') TO s_browse[1].b_inbm008
      
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
 
      CALL aint701_filter_show('inbmsite')
   CALL aint701_filter_show('inbmdocdt')
   CALL aint701_filter_show('inbmdocno')
   CALL aint701_filter_show('inbmunit')
   CALL aint701_filter_show('inbm001')
   CALL aint701_filter_show('inbm002')
   CALL aint701_filter_show('inbm007')
   CALL aint701_filter_show('inbmstus')
   CALL aint701_filter_show('inbm008')
 
END FUNCTION
 
{</section>}
 
{<section id="aint701.filter_parser" >}
#+ filter過濾功能
PRIVATE FUNCTION aint701_filter_parser(ps_field)
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
 
{<section id="aint701.filter_show" >}
#+ 顯示過濾條件
PRIVATE FUNCTION aint701_filter_show(ps_field)
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
   LET ls_condition = aint701_filter_parser(ps_field)
   IF NOT cl_null(ls_condition) THEN
      LET ls_title = ls_title, '※', ls_condition, '※'
   END IF
 
   #將資料顯示回去
   CALL lnode_item.setAttribute("text",ls_title)
 
END FUNCTION
 
{</section>}
 
{<section id="aint701.query" >}
#+ 資料查詢QBE功能準備
PRIVATE FUNCTION aint701_query()
   #add-point:query段define(客製用) name="query.define_customerization"
   
   #end add-point   
   DEFINE ls_wc STRING
   #add-point:query段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="query.define"
   
   #end add-point   
   
   #add-point:Function前置處理  name="query.pre_function"
   LET g_temp_init_flag = TRUE   #161024-00023#4 20161025 add by beckxie
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
   CALL g_inbn_d.clear()
   CALL g_inbn2_d.clear()
 
   
   #add-point:query段other name="query.other"
   CALL g_inbn3_d.clear()
   CALL g_inbn4_d.clear()
   #end add-point   
   
   DISPLAY '' TO FORMONLY.idx
   DISPLAY '' TO FORMONLY.cnt
   DISPLAY '' TO FORMONLY.b_index
   DISPLAY '' TO FORMONLY.b_count
   DISPLAY '' TO FORMONLY.h_index
   DISPLAY '' TO FORMONLY.h_count
   
   CALL aint701_construct()
 
   IF INT_FLAG THEN
      #取消查詢
      LET INT_FLAG = 0
      #LET g_wc = ls_wc
      LET g_wc = " 1=2"
      CALL aint701_browser_fill("")
      CALL aint701_fetch("")
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
      CALL aint701_filter_show('inbmsite')
   CALL aint701_filter_show('inbmdocdt')
   CALL aint701_filter_show('inbmdocno')
   CALL aint701_filter_show('inbmunit')
   CALL aint701_filter_show('inbm001')
   CALL aint701_filter_show('inbm002')
   CALL aint701_filter_show('inbm007')
   CALL aint701_filter_show('inbmstus')
   CALL aint701_filter_show('inbm008')
   CALL aint701_browser_fill("F")
         
   IF g_browser_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "-100" 
      LET g_errparam.popup = TRUE 
      CALL cl_err()
   ELSE
      CALL aint701_fetch("F") 
      #顯示單身筆數
      CALL aint701_idx_chk()
   END IF
 
END FUNCTION
 
{</section>}
 
{<section id="aint701.fetch" >}
#+ 指定PK後抓取單頭其他資料
PRIVATE FUNCTION aint701_fetch(p_flag)
   #add-point:fetch段define(客製用) name="fetch.define_customerization"
   
   #end add-point    
   DEFINE p_flag     LIKE type_t.chr1
   DEFINE ls_msg     STRING
   #add-point:fetch段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="fetch.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="fetch.pre_function"
   CALL g_inbn_d.clear()
   LET g_inbm_m.l_num = 1
   LET g_inbm_m.l_symbol = '0'
   LET g_detail_idx  = 1
   LET g_detail_idx2 = 1
   #各個page指標
   LET g_detail_idx_list[1] = 1 
   LET g_detail_idx_list[2] = 1
    
   CALL g_curr_diag.setCurrentRow("s_detail1",1)    
   CALL g_curr_diag.setCurrentRow("s_detail2",1)
   LET g_temp_init_flag = TRUE   #161024-00023#4 20161025 add by beckxie
   #end add-point
   
   IF g_browser_cnt = 0 THEN
      RETURN
   END IF
 
   #清空第二階單身
   CALL g_inbn2_d.clear()
 
   
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
   
   LET g_inbm_m.inbmdocno = g_browser[g_current_idx].b_inbmdocno
 
   
   #重讀DB,因TEMP有不被更新特性
   EXECUTE aint701_master_referesh USING g_inbm_m.inbmdocno INTO g_inbm_m.inbmsite,g_inbm_m.inbmdocdt, 
       g_inbm_m.inbmdocno,g_inbm_m.inbm003,g_inbm_m.inbm005,g_inbm_m.inbm006,g_inbm_m.inbm007,g_inbm_m.inbm004, 
       g_inbm_m.inbm001,g_inbm_m.inbm002,g_inbm_m.inbmunit,g_inbm_m.inbm008,g_inbm_m.inbmstus,g_inbm_m.inbmownid, 
       g_inbm_m.inbmowndp,g_inbm_m.inbmcrtid,g_inbm_m.inbmcrtdp,g_inbm_m.inbmcrtdt,g_inbm_m.inbmmodid, 
       g_inbm_m.inbmmoddt,g_inbm_m.inbmcnfid,g_inbm_m.inbmcnfdt,g_inbm_m.inbmsite_desc,g_inbm_m.inbm005_desc, 
       g_inbm_m.inbm006_desc,g_inbm_m.inbm001_desc,g_inbm_m.inbmunit_desc,g_inbm_m.inbmownid_desc,g_inbm_m.inbmowndp_desc, 
       g_inbm_m.inbmcrtid_desc,g_inbm_m.inbmcrtdp_desc,g_inbm_m.inbmmodid_desc,g_inbm_m.inbmcnfid_desc 
 
   
   #遮罩相關處理
   LET g_inbm_m_mask_o.* =  g_inbm_m.*
   CALL aint701_inbm_t_mask()
   LET g_inbm_m_mask_n.* =  g_inbm_m.*
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aint701_set_act_visible()   
   CALL aint701_set_act_no_visible()
   
   #add-point:fetch段action控制 name="fetch.action_control"
   
   #end add-point  
   
   
   
   #add-point:fetch結束前 name="fetch.after"
   CALL g_inbn3_d.clear()
   CALL g_inbn4_d.clear()
   #end add-point
   
   #保存單頭舊值
   LET g_inbm_m_t.* = g_inbm_m.*
   LET g_inbm_m_o.* = g_inbm_m.*
   
   LET g_data_owner = g_inbm_m.inbmownid      
   LET g_data_dept  = g_inbm_m.inbmowndp
   
   #重新顯示   
   CALL aint701_show()
 
   
 
END FUNCTION
 
{</section>}
 
{<section id="aint701.insert" >}
#+ 資料新增
PRIVATE FUNCTION aint701_insert()
   #add-point:insert段define(客製用) name="insert.define_customerization"
   
   #end add-point    
   #add-point:insert段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="insert.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="insert.pre_function"
   
   #end add-point
   
   #清畫面欄位內容
   CLEAR FORM                    
   CALL g_inbn_d.clear()   
   CALL g_inbn2_d.clear()  
 
 
   INITIALIZE g_inbm_m.* TO NULL             #DEFAULT 設定
   
   LET g_inbmdocno_t = NULL
 
   
   LET g_master_insert = FALSE
   
   #add-point:insert段before name="insert.before"
   
   #end add-point    
   
   CALL s_transaction_begin()
   WHILE TRUE
      #公用欄位給值(單頭)
      #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_inbm_m.inbmownid = g_user
      LET g_inbm_m.inbmowndp = g_dept
      LET g_inbm_m.inbmcrtid = g_user
      LET g_inbm_m.inbmcrtdp = g_dept 
      LET g_inbm_m.inbmcrtdt = cl_get_current()
      LET g_inbm_m.inbmmodid = g_user
      LET g_inbm_m.inbmmoddt = cl_get_current()
      LET g_inbm_m.inbmstus = 'N'
 
 
 
 
      #append欄位給值
      
     
      #一般欄位給值
            LET g_inbm_m.l_symbol = "0"
      LET g_inbm_m.l_num = "1"
 
  
      #add-point:單頭預設值 name="insert.default"
 
      #end add-point 
      
      #保存單頭舊值(用於資料輸入錯誤還原預設值時使用)
      LET g_inbm_m_t.* = g_inbm_m.*
      LET g_inbm_m_o.* = g_inbm_m.*
      
      #顯示狀態(stus)圖片
            #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_inbm_m.inbmstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
    
      CALL aint701_input("a")
      
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
         INITIALIZE g_inbm_m.* TO NULL
         INITIALIZE g_inbn_d TO NULL
         INITIALIZE g_inbn2_d TO NULL
 
         #add-point:取消新增後 name="insert.cancel"
         
         #end add-point 
         CALL aint701_show()
         RETURN
      END IF
      
      LET INT_FLAG = 0
      #CALL g_inbn_d.clear()
      #CALL g_inbn2_d.clear()
 
 
      LET g_rec_b = 0
      CALL s_transaction_end('Y','0')
      EXIT WHILE
        
   END WHILE
   
   #根據資料狀態切換action狀態
   CALL cl_set_act_visible("statechange,modify,modify_detail,delete,reproduce", TRUE)
   CALL aint701_set_act_visible()   
   CALL aint701_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_inbmdocno_t = g_inbm_m.inbmdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " inbment = " ||g_enterprise|| " AND",
                      " inbmdocno = '", g_inbm_m.inbmdocno, "' "
 
                      
   #add-point:組合新增資料的條件後 name="insert.after.add_browse"
   
   #end add-point
      
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aint701_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   CLOSE aint701_cl
   
   CALL aint701_idx_chk()
   
   #撈取異動後的資料(主要是帶出reference)
   EXECUTE aint701_master_referesh USING g_inbm_m.inbmdocno INTO g_inbm_m.inbmsite,g_inbm_m.inbmdocdt, 
       g_inbm_m.inbmdocno,g_inbm_m.inbm003,g_inbm_m.inbm005,g_inbm_m.inbm006,g_inbm_m.inbm007,g_inbm_m.inbm004, 
       g_inbm_m.inbm001,g_inbm_m.inbm002,g_inbm_m.inbmunit,g_inbm_m.inbm008,g_inbm_m.inbmstus,g_inbm_m.inbmownid, 
       g_inbm_m.inbmowndp,g_inbm_m.inbmcrtid,g_inbm_m.inbmcrtdp,g_inbm_m.inbmcrtdt,g_inbm_m.inbmmodid, 
       g_inbm_m.inbmmoddt,g_inbm_m.inbmcnfid,g_inbm_m.inbmcnfdt,g_inbm_m.inbmsite_desc,g_inbm_m.inbm005_desc, 
       g_inbm_m.inbm006_desc,g_inbm_m.inbm001_desc,g_inbm_m.inbmunit_desc,g_inbm_m.inbmownid_desc,g_inbm_m.inbmowndp_desc, 
       g_inbm_m.inbmcrtid_desc,g_inbm_m.inbmcrtdp_desc,g_inbm_m.inbmmodid_desc,g_inbm_m.inbmcnfid_desc 
 
   
   
   #遮罩相關處理
   LET g_inbm_m_mask_o.* =  g_inbm_m.*
   CALL aint701_inbm_t_mask()
   LET g_inbm_m_mask_n.* =  g_inbm_m.*
   
   #將資料顯示到畫面上
   DISPLAY BY NAME g_inbm_m.inbmsite,g_inbm_m.inbmsite_desc,g_inbm_m.inbmdocdt,g_inbm_m.inbmdocno,g_inbm_m.inbm003, 
       g_inbm_m.inbm005,g_inbm_m.inbm005_desc,g_inbm_m.inbm006,g_inbm_m.inbm006_desc,g_inbm_m.inbm007, 
       g_inbm_m.inbm004,g_inbm_m.inbm001,g_inbm_m.inbm001_desc,g_inbm_m.inbm002,g_inbm_m.inbmunit,g_inbm_m.inbmunit_desc, 
       g_inbm_m.inbm008,g_inbm_m.inbmstus,g_inbm_m.inbmownid,g_inbm_m.inbmownid_desc,g_inbm_m.inbmowndp, 
       g_inbm_m.inbmowndp_desc,g_inbm_m.inbmcrtid,g_inbm_m.inbmcrtid_desc,g_inbm_m.inbmcrtdp,g_inbm_m.inbmcrtdp_desc, 
       g_inbm_m.inbmcrtdt,g_inbm_m.inbmmodid,g_inbm_m.inbmmodid_desc,g_inbm_m.inbmmoddt,g_inbm_m.inbmcnfid, 
       g_inbm_m.inbmcnfid_desc,g_inbm_m.inbmcnfdt,g_inbm_m.inbn001_1,g_inbm_m.l_symbol,g_inbm_m.l_num, 
       g_inbm_m.inbo010_1
   
   #add-point:新增結束後 name="insert.after"
   
   #end add-point 
   
   LET g_data_owner = g_inbm_m.inbmownid      
   LET g_data_dept  = g_inbm_m.inbmowndp
   
   #功能已完成,通報訊息中心
   CALL aint701_msgcentre_notify('insert')
   
END FUNCTION
 
{</section>}
 
{<section id="aint701.modify" >}
#+ 資料修改
PRIVATE FUNCTION aint701_modify()
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
   LET g_inbm_m_t.* = g_inbm_m.*
   LET g_inbm_m_o.* = g_inbm_m.*
   
   IF g_inbm_m.inbmdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   ERROR ""
  
   LET g_inbmdocno_t = g_inbm_m.inbmdocno
 
   CALL s_transaction_begin()
   
   OPEN aint701_cl USING g_enterprise,g_inbm_m.inbmdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aint701_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aint701_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aint701_master_referesh USING g_inbm_m.inbmdocno INTO g_inbm_m.inbmsite,g_inbm_m.inbmdocdt, 
       g_inbm_m.inbmdocno,g_inbm_m.inbm003,g_inbm_m.inbm005,g_inbm_m.inbm006,g_inbm_m.inbm007,g_inbm_m.inbm004, 
       g_inbm_m.inbm001,g_inbm_m.inbm002,g_inbm_m.inbmunit,g_inbm_m.inbm008,g_inbm_m.inbmstus,g_inbm_m.inbmownid, 
       g_inbm_m.inbmowndp,g_inbm_m.inbmcrtid,g_inbm_m.inbmcrtdp,g_inbm_m.inbmcrtdt,g_inbm_m.inbmmodid, 
       g_inbm_m.inbmmoddt,g_inbm_m.inbmcnfid,g_inbm_m.inbmcnfdt,g_inbm_m.inbmsite_desc,g_inbm_m.inbm005_desc, 
       g_inbm_m.inbm006_desc,g_inbm_m.inbm001_desc,g_inbm_m.inbmunit_desc,g_inbm_m.inbmownid_desc,g_inbm_m.inbmowndp_desc, 
       g_inbm_m.inbmcrtid_desc,g_inbm_m.inbmcrtdp_desc,g_inbm_m.inbmmodid_desc,g_inbm_m.inbmcnfid_desc 
 
   
   #檢查是否允許此動作
   IF NOT aint701_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_inbm_m_mask_o.* =  g_inbm_m.*
   CALL aint701_inbm_t_mask()
   LET g_inbm_m_mask_n.* =  g_inbm_m.*
   
   
   
   #add-point:modify段show之前 name="modify.before_show"
   
   #end add-point  
   
   #LET l_wc2_table1 = g_wc2_table1
   #LET g_wc2_table1 = " 1=1"
 
   #LET l_wc2_table2 = g_wc2_table2
   #LET l_wc2_table2 = " 1=1"
 
 
   
   CALL aint701_show()
   #add-point:modify段show之後 name="modify.after_show"
   
   #end add-point
   
   #LET g_wc2_table1 = l_wc2_table1
 
   #LET  g_wc2_table2 = l_wc2_table2 
 
 
    
   WHILE TRUE
      LET g_inbmdocno_t = g_inbm_m.inbmdocno
 
      
      #寫入修改者/修改日期資訊(單頭)
      LET g_inbm_m.inbmmodid = g_user 
LET g_inbm_m.inbmmoddt = cl_get_current()
LET g_inbm_m.inbmmodid_desc = cl_get_username(g_inbm_m.inbmmodid)
      
      #add-point:modify段修改前 name="modify.before_input"
      
      #end add-point
      
      #欄位更改
      LET g_loc = 'n'
      LET g_update = FALSE
      LET g_master_commit = "N"
      CALL aint701_input("u")
      LET g_loc = 'n'
 
      #add-point:modify段修改後 name="modify.after_input"
      #161017-00051#15 20161201 add by beckxie---S
      LET g_temp_init_flag = TRUE
      LET g_cmd = ''  
      CALL aint701_b_fill()
      CALL aint701_b_fill2('2')
      #170119-00027#1 20170120 add by beckxie---S
      LET l_ac = 1
      LET g_detail_idx = l_ac
      CALL g_curr_diag.setCurrentRow("s_detail1",l_ac)
      LET g_inbm_m.inbn001_1 = g_inbn_d[g_detail_idx].inbn001
      DISPLAY BY NAME g_inbm_m.inbn001_1
      #170119-00027#1 20170120 add by beckxie---E
      CALL aint701_set_comp_visible_b()
      CALL aint701_set_comp_no_visible_b()
      #161017-00051#15 20161201 add by beckxie---E
      #end add-point
      
      IF g_update OR NOT INT_FLAG THEN
         #若有modid跟moddt則進行update
         UPDATE inbm_t SET (inbmmodid,inbmmoddt) = (g_inbm_m.inbmmodid,g_inbm_m.inbmmoddt)
          WHERE inbment = g_enterprise AND inbmdocno = g_inbmdocno_t
 
      END IF
    
      IF INT_FLAG THEN
         CALL s_transaction_end('N','0')
         LET INT_FLAG = 0
         #若單頭無commit則還原
         IF g_master_commit = "N" THEN
            LET g_inbm_m.* = g_inbm_m_t.*
            CALL aint701_show()
         END IF
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = '' 
         LET g_errparam.code = 9001 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN
      END IF 
                  
      #若單頭key欄位有變更
      IF g_inbm_m.inbmdocno != g_inbm_m_t.inbmdocno
 
      THEN
         CALL s_transaction_begin()
         
         #add-point:單身fk修改前 name="modify.body.b_fk_update"
         
         #end add-point
         
         #更新單身key值
         UPDATE inbn_t SET inbndocno = g_inbm_m.inbmdocno
 
          WHERE inbnent = g_enterprise AND inbndocno = g_inbm_m_t.inbmdocno
 
            
         #add-point:單身fk修改中 name="modify.body.m_fk_update"
         
         #end add-point
 
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            #   INITIALIZE g_errparam TO NULL 
            #   LET g_errparam.extend = "inbn_t" 
            #   LET g_errparam.code = "std-00009" 
            #   LET g_errparam.popup = TRUE 
            #   CALL cl_err()
            #   CALL s_transaction_end('N','0')
            #   CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "inbn_t:",SQLERRMESSAGE 
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
         UPDATE inbo_t
            SET inbodocno = g_inbm_m.inbmdocno
 
          WHERE inboent = g_enterprise AND
                inbodocno = g_inbmdocno_t
 
         #add-point:單身fk修改中 name="modify.body.m_fk_update2"
         
         #end add-point
         CASE
            WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "inbo_t" 
               LET g_errparam.code = "std-00009" 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CONTINUE WHILE
            WHEN SQLCA.SQLCODE #其他錯誤
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "inbo_t:",SQLERRMESSAGE 
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
   CALL aint701_set_act_visible()   
   CALL aint701_set_act_no_visible()
 
   #組合新增資料的條件
   LET g_add_browse = " inbment = " ||g_enterprise|| " AND",
                      " inbmdocno = '", g_inbm_m.inbmdocno, "' "
 
   #填到對應位置
   CALL aint701_browser_fill("")
 
   CLOSE aint701_cl
   
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aint701_msgcentre_notify('modify')
 
END FUNCTION 
 
{</section>}
 
{<section id="aint701.input" >}
#+ 資料輸入
PRIVATE FUNCTION aint701_input(p_cmd)
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
   DEFINE  l_str                 STRING
   DEFINE  l_str1                STRING
   DEFINE  l_str2                STRING
   DEFINE  l_cnt1                LIKE type_t.num5
   DEFINE  l_success             LIKE type_t.num5    #161017-00051#15 20161201 add by beckxie
   DEFINE  l_inbn002             LIKE inbn_t.inbn002 #161213-00004#11 20161220 add by beckxie
   #end add-point  
   
   #add-point:Function前置處理  name="input.pre_function"
   LET g_cmd = p_cmd #161017-00051#15 20161201 add by beckxie
   #end add-point
   
   #先做狀態判定
   IF p_cmd = 'r' THEN
      LET l_cmd_t = 'r'
      LET p_cmd   = 'a'
   ELSE
      LET l_cmd_t = p_cmd
   END IF   
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_inbm_m.inbmsite,g_inbm_m.inbmsite_desc,g_inbm_m.inbmdocdt,g_inbm_m.inbmdocno,g_inbm_m.inbm003, 
       g_inbm_m.inbm005,g_inbm_m.inbm005_desc,g_inbm_m.inbm006,g_inbm_m.inbm006_desc,g_inbm_m.inbm007, 
       g_inbm_m.inbm004,g_inbm_m.inbm001,g_inbm_m.inbm001_desc,g_inbm_m.inbm002,g_inbm_m.inbmunit,g_inbm_m.inbmunit_desc, 
       g_inbm_m.inbm008,g_inbm_m.inbmstus,g_inbm_m.inbmownid,g_inbm_m.inbmownid_desc,g_inbm_m.inbmowndp, 
       g_inbm_m.inbmowndp_desc,g_inbm_m.inbmcrtid,g_inbm_m.inbmcrtid_desc,g_inbm_m.inbmcrtdp,g_inbm_m.inbmcrtdp_desc, 
       g_inbm_m.inbmcrtdt,g_inbm_m.inbmmodid,g_inbm_m.inbmmodid_desc,g_inbm_m.inbmmoddt,g_inbm_m.inbmcnfid, 
       g_inbm_m.inbmcnfid_desc,g_inbm_m.inbmcnfdt,g_inbm_m.inbn001_1,g_inbm_m.l_symbol,g_inbm_m.l_num, 
       g_inbm_m.inbo010_1
   
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
   LET g_forupd_sql = "SELECT inbnsite,inbnunit,inbn001,inbn002 FROM inbn_t WHERE inbnent=? AND inbndocno=?  
       AND inbn001=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aint701_bcl CURSOR FROM g_forupd_sql
   
 
   
   #add-point:input段define_sql name="input.define_sql2"
   
   #end add-point 
   LET g_forupd_sql = "SELECT inbosite,inbounit,inbo002,inbo001,inbo010,inbo006,inbo007,inbo008,inbo009  
       FROM inbo_t WHERE inboent=? AND inbodocno=? AND inbo001=? AND inbo002=? FOR UPDATE"
   #add-point:input段define_sql name="input.after_define_sql2"
   
   #end add-point 
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE aint701_bcl2 CURSOR FROM g_forupd_sql
 
 
 
   #add-point:input段define_sql name="input.other_sql"
   
   #end add-point 
 
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   LET g_qryparam.state = 'i'
   
   #控制key欄位可否輸入
   CALL aint701_set_entry(p_cmd)
   #add-point:set_entry後 name="input.after_set_entry"
   
   #end add-point
   CALL aint701_set_no_entry(p_cmd)
 
   DISPLAY BY NAME g_inbm_m.inbmsite,g_inbm_m.inbmdocdt,g_inbm_m.inbmdocno,g_inbm_m.inbm003,g_inbm_m.inbm005, 
       g_inbm_m.inbm006,g_inbm_m.inbm007,g_inbm_m.inbm004,g_inbm_m.inbm001,g_inbm_m.inbm002,g_inbm_m.inbmunit, 
       g_inbm_m.inbm008,g_inbm_m.inbmstus,g_inbm_m.l_symbol,g_inbm_m.l_num,g_inbm_m.inbo010_1
   
   LET lb_reproduce = FALSE
   LET l_ac_t = 1
   
   #關閉被遮罩相關欄位輸入, 無法確定USER是否會需要輸入此欄位
   #因此先行關閉, 若有需要可於下方add-point中自行開啟
   CALL cl_mask_set_no_entry()
   
   #add-point:資料輸入前 name="input.before_input"
   
   #end add-point
   
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
 
{</section>}
 
{<section id="aint701.input.head" >}
      #單頭段
      INPUT BY NAME g_inbm_m.inbmsite,g_inbm_m.inbmdocdt,g_inbm_m.inbmdocno,g_inbm_m.inbm003,g_inbm_m.inbm005, 
          g_inbm_m.inbm006,g_inbm_m.inbm007,g_inbm_m.inbm004,g_inbm_m.inbm001,g_inbm_m.inbm002,g_inbm_m.inbmunit, 
          g_inbm_m.inbm008,g_inbm_m.inbmstus,g_inbm_m.l_symbol,g_inbm_m.l_num,g_inbm_m.inbo010_1 
         ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION(master_input)
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION print_g02
            LET g_action_choice="print_g02"
               
               #add-point:ON ACTION print_g02 name="input.master_input.print_g02"
               CALL aint701_print('2')   #170119-00027#1 20170120 add by beckxie
               #END add-point
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION print_g01
            LET g_action_choice="print_g01"
               
               #add-point:ON ACTION print_g01 name="input.master_input.print_g01"
               CALL aint701_print('1')   #170119-00027#1 20170120 add by beckxie
               #END add-point
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION seal_box
            LET g_action_choice="seal_box"
               
               #add-point:ON ACTION seal_box name="input.master_input.seal_box"
               CALL aint701_seal_box()
               
               IF g_inbn3_d.getlength() = 0 THEN
                  LET g_detail_idx = l_ac #全部已封裝且待裝明細沒資料就結束
                  CALL aint701_b_fill()
                  LET g_detail_idx_list[1] = l_ac
                  CALL aint701_b_fill2('2')
                  LET g_inbn_d_t.* = g_inbn_d[l_ac].*  #BACKUP   #161213-00022#2 20161215 add by beckxie
                  LET g_inbn_d_o.* = g_inbn_d[l_ac].*  #BACKUP   #161213-00022#2 20161215 add by beckxie
                  ACCEPT DIALOG
               END IF
               LET g_detail_idx = 1 #161017-00051#15 20161201 add by beckxie
               CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)
               LET l_ac = g_detail_idx
               LET g_detail_idx_list[1] = g_detail_idx
               
               CALL aint701_set_entry_b(l_cmd)
               CALL aint701_set_no_entry_b(l_cmd)
               
               LET g_inbm_m.inbo010_1 = ''
               DISPLAY BY NAME g_inbm_m.inbo010_1
               DISPLAY g_inbn_d[l_ac].inbn001 TO inbn001_1
               
               LET g_inbn_d_t.* = g_inbn_d[l_ac].*  #BACKUP
               LET g_inbn_d_o.* = g_inbn_d[l_ac].*  #BACKUP
               CALL aint701_b_fill2('2')
               
               NEXT FIELD inbo010_1
               #END add-point
 
 
 
 
     
         BEFORE INPUT
            IF s_transaction_chk("N",0) THEN
               CALL s_transaction_begin()
            END IF
            OPEN aint701_cl USING g_enterprise,g_inbm_m.inbmdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aint701_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aint701_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            IF l_cmd_t = 'r' THEN
               
            END IF
            #因應離開單頭後已寫入資料庫, 若重新回到單頭則視為修改
            #因此需於此處開啟/關閉欄位
            CALL aint701_set_entry(p_cmd)
            #add-point:資料輸入前 name="input.m.before_input"
            #161024-00023#13 20161031 mark by beckxie---S
            #LET g_inbm_m.l_symbol = '0'
            #DISPLAY BY NAME g_inbm_m.l_symbol 
            #LET g_inbm_m.l_num = 1           #161024-00023#4 20161026 add by beckxie
            #DISPLAY BY NAME g_inbm_m.l_num   #161024-00023#4 20161026 add by beckxie
            #161024-00023#13 20161031 mark by beckxie---E
            CALL aint701_set_no_entry(p_cmd)
            #條碼可輸入的話,直接先進入條碼欄位
            IF g_skip_1 = TRUE THEN
               #若箱明細無資料,但待裝明細有資料,新增一筆箱明細
               CALL aint701_b_fill()
               IF g_inbn_d.getlength() = 0 AND g_inbn3_d.getlength() > 0 THEN
               
                  INSERT INTO inbn_t (inbnent,inbnsite,inbnunit,inbndocno,inbn001,inbn002)
                  VALUES (g_enterprise,g_inbm_m.inbmsite,g_inbm_m.inbmunit,g_inbm_m.inbmdocno,'B1001','1')
                  
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "ins_inbn_t"
                     LET g_errparam.code   = SQLCA.sqlcode 
                     #LET g_errparam.popup  = TRUE   #161024-00023#12 20161030 mark by beckxie
                     LET g_errparam.popup  = FALSE   #161024-00023#12 20161030 add by beckxie
                     CALL cl_err()
                  END IF
                  CALL aint701_b_fill()
               END IF
               CALL aint701_set_entry(p_cmd)    #20160919
               CALL aint701_set_no_entry(p_cmd) #20160919
               NEXT FIELD inbo010_1             #20160919
            ELSE
               #單身跳轉至
               LET l_cnt1 = g_inbn_d.getlength()
               CALL aint701_find() RETURNING g_detail_idx
               #如果欲跳轉到的筆數到大於最後一筆,且待裝明細有資料需新增下一筆
               IF g_detail_idx > l_cnt1 THEN
                  IF g_inbn3_d.getlength() > 0 AND g_delete_flag != TRUE THEN   #待裝明細有資料&剛刪箱完也不新增
                     
                     #CALL aint701_inbn001_init(g_inbn_d[g_detail_idx-1].inbn001) RETURNING g_inbn_d[g_detail_idx].inbn001   #161017-00051#15 20161201 mark by beckxie
                     CALL aint701_inbn001_init() RETURNING g_inbn_d[g_detail_idx].inbn001   #161017-00051#15 20161201 add by beckxie
                     
                     IF NOT cl_null(g_inbn_d[g_detail_idx].inbn001) THEN
                        INSERT INTO inbn_t (inbnent,inbnsite,inbnunit,inbndocno,inbn001,inbn002)
                        VALUES (g_enterprise,g_inbm_m.inbmsite,g_inbm_m.inbmsite,g_inbm_m.inbmdocno,g_inbn_d[g_detail_idx].inbn001,'1')
                        IF SQLCA.SQLcode THEN
                           INITIALIZE g_errparam TO NULL 
                           LET g_errparam.extend = "ins_inbn_t"
                           LET g_errparam.code   = SQLCA.sqlcode 
                           #LET g_errparam.popup  = TRUE   #161024-00023#12 20161030 mark by beckxie
                           LET g_errparam.popup  = FALSE   #161024-00023#12 20161030 add by beckxie
                           CALL cl_err()
                        END IF
                        CALL aint701_b_fill()
                     END IF
                  ELSE
                     LET g_detail_idx = l_ac #全部已封裝且待裝明細沒資料就結束
                     LET g_detail_idx_list[1] = l_ac
                     CALL aint701_b_fill()
                     CALL aint701_b_fill2('2')
                     
                     CALL aint701_set_entry(p_cmd)
                     CALL aint701_set_no_entry(p_cmd)
                     
                     NEXT FIELD inbm005
                  END IF
               END IF
               LET g_detail_idx = 1 #161017-00051#15 20161201 add by beckxie
               CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)
               LET l_ac = g_detail_idx
               LET g_detail_idx_list[1] = g_detail_idx
               
               CALL aint701_set_entry(p_cmd)
               CALL aint701_set_no_entry(p_cmd)
               CALL aint701_set_entry_b(p_cmd)
               CALL aint701_set_no_entry_b(p_cmd)
               
               DISPLAY g_inbn_d[l_ac].inbn001 TO inbn001_1
               LET g_inbn_d_t.* = g_inbn_d[l_ac].*  #BACKUP
               LET g_inbn_d_o.* = g_inbn_d[l_ac].*  #BACKUP
               CALL aint701_b_fill()
               CALL aint701_b_fill2('2')
               
               NEXT FIELD inbo010_1
            END IF
            #end add-point
            CALL aint701_set_no_entry(p_cmd)
    
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbmsite
            
            #add-point:AFTER FIELD inbmsite name="input.a.inbmsite"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_inbm_m.inbmsite
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_inbm_m.inbmsite_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_inbm_m.inbmsite_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbmsite
            #add-point:BEFORE FIELD inbmsite name="input.b.inbmsite"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbmsite
            #add-point:ON CHANGE inbmsite name="input.g.inbmsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbmdocdt
            #add-point:BEFORE FIELD inbmdocdt name="input.b.inbmdocdt"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbmdocdt
            
            #add-point:AFTER FIELD inbmdocdt name="input.a.inbmdocdt"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbmdocdt
            #add-point:ON CHANGE inbmdocdt name="input.g.inbmdocdt"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbmdocno
            #add-point:BEFORE FIELD inbmdocno name="input.b.inbmdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbmdocno
            
            #add-point:AFTER FIELD inbmdocno name="input.a.inbmdocno"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  NOT cl_null(g_inbm_m.inbmdocno) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_inbm_m.inbmdocno != g_inbmdocno_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM inbm_t WHERE "||"inbment = '" ||g_enterprise|| "' AND "||"inbmdocno = '"||g_inbm_m.inbmdocno ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF




            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbmdocno
            #add-point:ON CHANGE inbmdocno name="input.g.inbmdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbm003
            #add-point:BEFORE FIELD inbm003 name="input.b.inbm003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbm003
            
            #add-point:AFTER FIELD inbm003 name="input.a.inbm003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbm003
            #add-point:ON CHANGE inbm003 name="input.g.inbm003"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbm005
            
            #add-point:AFTER FIELD inbm005 name="input.a.inbm005"
            IF NOT cl_null(g_inbm_m.inbm005) THEN 
               IF g_inbm_m.inbm005 != g_inbm_m_o.inbm005 OR cl_null(g_inbm_m_o.inbm005) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_inbm_m.inbm005
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aim-00070:sub-01302|aooi130|",cl_get_progname("aooi130",g_lang,"2"),"|:EXEPROGaooi130"
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_ooag001") THEN
                     LET g_inbm_m.inbm005 = g_inbm_m_o.inbm005
                     CALL s_desc_get_person_desc(g_inbm_m.inbm005) RETURNING g_inbm_m.inbm005_desc
                     DISPLAY BY NAME g_inbm_m.inbm005,g_inbm_m.inbm005_desc
                     #檢查失敗時後續處理
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
            LET g_inbm_m_o.inbm005 = g_inbm_m.inbm005
            CALL s_desc_get_person_desc(g_inbm_m.inbm005) RETURNING g_inbm_m.inbm005_desc
            DISPLAY BY NAME g_inbm_m.inbm005,g_inbm_m.inbm005_desc
            
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbm005
            #add-point:BEFORE FIELD inbm005 name="input.b.inbm005"
            LET g_delete_flag = FALSE
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbm005
            #add-point:ON CHANGE inbm005 name="input.g.inbm005"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbm006
            
            #add-point:AFTER FIELD inbm006 name="input.a.inbm006"
            IF NOT cl_null(g_inbm_m.inbm006) THEN
               IF g_inbm_m.inbm006 != g_inbm_m_o.inbm006 OR cl_null(g_inbm_m_o.inbm006) THEN
                  INITIALIZE g_chkparam.* TO NULL
                  #設定g_chkparam.*的參數
                  LET g_chkparam.arg1 = g_inbm_m.inbm006
                  LET g_chkparam.arg2 = g_inbm_m.inbmdocdt
                  LET g_errshow = TRUE #是否開窗                   
                  LET g_chkparam.err_str[1] ="aoo-00029:sub-01302|aooi125|",cl_get_progname("aooi125",g_lang,"2"),"|:EXEPROGaooi125"
                  #呼叫檢查存在並帶值的library
                  IF NOT cl_chk_exist("v_ooeg001") THEN
                     LET g_inbm_m.inbm006 = g_inbm_m_o.inbm006
                     CALL s_desc_get_department_desc(g_inbm_m.inbm006) RETURNING g_inbm_m.inbm006_desc 
                     DISPLAY BY NAME g_inbm_m.inbm006,g_inbm_m.inbm006_desc
                     #檢查失敗時後續處理
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            LET g_inbm_m_o.inbm006 = g_inbm_m.inbm006
            CALL s_desc_get_department_desc(g_inbm_m.inbm006) RETURNING g_inbm_m.inbm006_desc 
            DISPLAY BY NAME g_inbm_m.inbm006,g_inbm_m.inbm006_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbm006
            #add-point:BEFORE FIELD inbm006 name="input.b.inbm006"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbm006
            #add-point:ON CHANGE inbm006 name="input.g.inbm006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbm007
            #add-point:BEFORE FIELD inbm007 name="input.b.inbm007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbm007
            
            #add-point:AFTER FIELD inbm007 name="input.a.inbm007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbm007
            #add-point:ON CHANGE inbm007 name="input.g.inbm007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbm004
            #add-point:BEFORE FIELD inbm004 name="input.b.inbm004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbm004
            
            #add-point:AFTER FIELD inbm004 name="input.a.inbm004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbm004
            #add-point:ON CHANGE inbm004 name="input.g.inbm004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbm001
            
            #add-point:AFTER FIELD inbm001 name="input.a.inbm001"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_inbm_m.inbm001
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_inbm_m.inbm001_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_inbm_m.inbm001_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbm001
            #add-point:BEFORE FIELD inbm001 name="input.b.inbm001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbm001
            #add-point:ON CHANGE inbm001 name="input.g.inbm001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbm002
            #add-point:BEFORE FIELD inbm002 name="input.b.inbm002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbm002
            
            #add-point:AFTER FIELD inbm002 name="input.a.inbm002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbm002
            #add-point:ON CHANGE inbm002 name="input.g.inbm002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbmunit
            
            #add-point:AFTER FIELD inbmunit name="input.a.inbmunit"
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_inbm_m.inbmunit
            CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_inbm_m.inbmunit_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_inbm_m.inbmunit_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbmunit
            #add-point:BEFORE FIELD inbmunit name="input.b.inbmunit"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbmunit
            #add-point:ON CHANGE inbmunit name="input.g.inbmunit"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbm008
            #add-point:BEFORE FIELD inbm008 name="input.b.inbm008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbm008
            
            #add-point:AFTER FIELD inbm008 name="input.a.inbm008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbm008
            #add-point:ON CHANGE inbm008 name="input.g.inbm008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbmstus
            #add-point:BEFORE FIELD inbmstus name="input.b.inbmstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbmstus
            
            #add-point:AFTER FIELD inbmstus name="input.a.inbmstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbmstus
            #add-point:ON CHANGE inbmstus name="input.g.inbmstus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_symbol
            #add-point:BEFORE FIELD l_symbol name="input.b.l_symbol"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_symbol
            
            #add-point:AFTER FIELD l_symbol name="input.a.l_symbol"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_symbol
            #add-point:ON CHANGE l_symbol name="input.g.l_symbol"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD l_num
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_inbm_m.l_num,"0","0","","","azz-00079",1) THEN
               NEXT FIELD l_num
            END IF 
 
 
 
            #add-point:AFTER FIELD l_num name="input.a.l_num"
            #161024-00023#4 20161026 add by beckxie---S
            IF cl_null(g_inbm_m.l_num) THEN
               LET g_inbm_m.l_num = 1 
               DISPLAY BY NAME g_inbm_m.l_num
            END IF
            #161024-00023#4 20161026 add by beckxie---E
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD l_num
            #add-point:BEFORE FIELD l_num name="input.b.l_num"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE l_num
            #add-point:ON CHANGE l_num name="input.g.l_num"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbo010_1
            #add-point:BEFORE FIELD inbo010_1 name="input.b.inbo010_1"
            #若箱明細無資料,但待裝明細有資料,新增一筆箱明細
            CALL aint701_b_fill()
            CALL aint701_b_fill2('2')
            #刪箱完也不新增
            IF g_inbn_d.getlength() = 0 AND g_inbn3_d.getlength() > 0 AND g_delete_flag != TRUE THEN   
               INSERT INTO inbn_t (inbnent,inbnsite,inbnunit,inbndocno,inbn001,inbn002)
               VALUES (g_enterprise,g_inbm_m.inbmsite,g_inbm_m.inbmunit,g_inbm_m.inbmdocno,'B1001','1')
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "ins_inbn_t"
                  LET g_errparam.code   = SQLCA.sqlcode 
                  #LET g_errparam.popup  = TRUE   #161024-00023#12 20161030 mark by beckxie
                  LET g_errparam.popup  = FALSE   #161024-00023#12 20161030 add by beckxie
                  CALL cl_err()
               END IF
               CALL aint701_b_fill()
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET g_detail_idx_list[1] = g_detail_idx
               LET g_inbm_m.inbn001_1 = g_inbn_d[g_detail_idx].inbn001
               DISPLAY BY NAME g_inbm_m.inbn001_1
            END IF
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbo010_1
            
            #add-point:AFTER FIELD inbo010_1 name="input.a.inbo010_1"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbo010_1
            #add-point:ON CHANGE inbo010_1 name="input.g.inbo010_1"
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET g_inbm_m.inbn001_1 = g_inbn_d[g_detail_idx].inbn001
            DISPLAY BY NAME g_inbm_m.inbn001_1
            IF (NOT cl_null(g_inbm_m.inbo010_1)) AND (NOT cl_null(g_inbm_m.inbn001_1)) THEN
               #161213-00004#11 20161220 add by beckxie---S
               #防呆:先判斷目前這筆箱號 是不是已封箱
               LET l_inbn002 = ''
               SELECT inbn002 INTO l_inbn002
                 FROM inbn_t
                WHERE inbnent = g_enterprise
                  AND inbndocno = g_inbm_m.inbmdocno
                  AND inbn001 = g_inbm_m.inbn001_1
               #箱狀態若不為[1.未封箱]的話報錯提示:箱狀態為未封箱才可以進行裝箱!
               IF l_inbn002 != '1' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = g_inbm_m.inbn001_1
                  LET g_errparam.code   = "ain-00862"
                  LET g_errparam.popup  = FALSE   
                  CALL cl_err()
               END IF
               #161213-00004#11 20161220 add by beckxie---E
               #IF aint701_inbo010_chk() THEN   #161213-00004#11 20161220 mark by beckxie
               IF aint701_inbo010_chk() AND l_inbn002 = '1' THEN   #161213-00004#11 20161220 add by beckxie
                  IF aint701_ins_inbo() THEN
                     #成功提示音
                     #161213-00004#1 20161213 add by beckxie---S
                     ##SA要求實時寫入,所以異動後寫入並重新開啟事務
                     IF s_transaction_chk('Y','0') THEN
                        DISPLAY "g_intrans"
                        CALL s_transaction_end('Y','0')
                        CALL s_transaction_begin()
                     END IF
                     #161213-00004#1 20161213 add by beckxie---E
                     #170104-00068#1 20170105 add by beckxie---S
                     IF g_flag THEN   
                        #當g_flag = TRUE ,使用串色串碼提示音
                        CALL ui.Interface.frontCall("standard", "playsound", ["C:////Windows////Media////overstep.wav"], [])
                     ELSE
                        #當g_flag = FALSE ,使用原本正確掃入的提示音
                     #170104-00068#1 20170105 add by beckxie---E
                        CALL ui.Interface.frontCall("standard", "playsound", ["C:////Windows////Media////right.wav"], [])
                     END IF   #170104-00068#1 20170105 add by beckxie
                  ELSE
                     #161213-00004#1 20161213 add by beckxie---S
                     ##SA要求實時寫入,所以異動後寫入並重新開啟事務
                     IF s_transaction_chk('Y','0') THEN
                        DISPLAY "g_intrans"
                        CALL s_transaction_end('N','0')
                        CALL s_transaction_begin()
                     END IF
                     #161213-00004#1 20161213 add by beckxie---E
                     #失敗提示音
                     CALL ui.Interface.frontCall("standard", "playsound", ["C:////Windows////Media////wrong.wav"], [])
                  END IF
               ELSE
                  #失敗提示音
                  CALL ui.Interface.frontCall("standard", "playsound", ["C:////Windows////Media////wrong.wav"], [])
               END IF
            ELSE
               #失敗提示音
               CALL ui.Interface.frontCall("standard", "playsound", ["C:////Windows////Media////wrong.wav"], [])
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = ""
               LET g_errparam.code   = 'ain-00789'
               #LET g_errparam.popup  = TRUE   #161024-00023#12 20161030 mark by beckxie
               LET g_errparam.popup  = FALSE   #161024-00023#12 20161030 add by beckxie
               CALL cl_err()
            END IF
            LET g_inbm_m.inbo010_1 = ''
            DISPLAY BY NAME g_inbm_m.inbo010_1
            LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
            LET l_ac = g_detail_idx
            LET g_detail_idx_list[1] = g_detail_idx
            CALL aint701_b_fill()
            CALL aint701_b_fill2('2')
            NEXT FIELD inbo010_1
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.inbmsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbmsite
            #add-point:ON ACTION controlp INFIELD inbmsite name="input.c.inbmsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.inbmdocdt
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbmdocdt
            #add-point:ON ACTION controlp INFIELD inbmdocdt name="input.c.inbmdocdt"
            
            #END add-point
 
 
         #Ctrlp:input.c.inbmdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbmdocno
            #add-point:ON ACTION controlp INFIELD inbmdocno name="input.c.inbmdocno"
            
            #END add-point
 
 
         #Ctrlp:input.c.inbm003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbm003
            #add-point:ON ACTION controlp INFIELD inbm003 name="input.c.inbm003"
            
            #END add-point
 
 
         #Ctrlp:input.c.inbm005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbm005
            #add-point:ON ACTION controlp INFIELD inbm005 name="input.c.inbm005"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_inbm_m.inbm005             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

 
            CALL q_ooag001()                                #呼叫開窗
 
            LET g_inbm_m.inbm005 = g_qryparam.return1              
            CALL s_desc_get_person_desc(g_inbm_m.inbm005) RETURNING g_inbm_m.inbm005_desc
            DISPLAY g_inbm_m.inbm005 TO inbm005              #
            DISPLAY BY NAME g_inbm_m.inbm005_desc
            NEXT FIELD inbm005                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.inbm006
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbm006
            #add-point:ON ACTION controlp INFIELD inbm006 name="input.c.inbm006"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_inbm_m.inbm006             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

 
            CALL q_ooeg001_9()                                #呼叫開窗
 
            LET g_inbm_m.inbm006 = g_qryparam.return1              

            DISPLAY g_inbm_m.inbm006 TO inbm006              #
            CALL s_desc_get_department_desc(g_inbm_m.inbm006) RETURNING g_inbm_m.inbm006_desc 
            DISPLAY BY NAME g_inbm_m.inbm006_desc
            NEXT FIELD inbm006                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.inbm007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbm007
            #add-point:ON ACTION controlp INFIELD inbm007 name="input.c.inbm007"
            
            #END add-point
 
 
         #Ctrlp:input.c.inbm004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbm004
            #add-point:ON ACTION controlp INFIELD inbm004 name="input.c.inbm004"
            
            #END add-point
 
 
         #Ctrlp:input.c.inbm001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbm001
            #add-point:ON ACTION controlp INFIELD inbm001 name="input.c.inbm001"
            
            #END add-point
 
 
         #Ctrlp:input.c.inbm002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbm002
            #add-point:ON ACTION controlp INFIELD inbm002 name="input.c.inbm002"
            
            #END add-point
 
 
         #Ctrlp:input.c.inbmunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbmunit
            #add-point:ON ACTION controlp INFIELD inbmunit name="input.c.inbmunit"
            
            #END add-point
 
 
         #Ctrlp:input.c.inbm008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbm008
            #add-point:ON ACTION controlp INFIELD inbm008 name="input.c.inbm008"
            
            #END add-point
 
 
         #Ctrlp:input.c.inbmstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbmstus
            #add-point:ON ACTION controlp INFIELD inbmstus name="input.c.inbmstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_symbol
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_symbol
            #add-point:ON ACTION controlp INFIELD l_symbol name="input.c.l_symbol"
            
            #END add-point
 
 
         #Ctrlp:input.c.l_num
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD l_num
            #add-point:ON ACTION controlp INFIELD l_num name="input.c.l_num"
            
            #END add-point
 
 
         #Ctrlp:input.c.inbo010_1
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbo010_1
            #add-point:ON ACTION controlp INFIELD inbo010_1 name="input.c.inbo010_1"
            
            #END add-point
 
 
 #欄位開窗
            
         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
 
            #CALL cl_err_collect_show()      #錯誤訊息統整顯示
            #CALL cl_showmsg()
            DISPLAY BY NAME g_inbm_m.inbmdocno
                        
            #add-point:單頭INPUT後 name="input.head.after_input"
            LET g_next_inbo010 = TRUE
            #end add-point
                        
            IF p_cmd <> 'u' THEN
    
               CALL s_transaction_begin()
               
               #add-point:單頭新增前 name="input.head.b_insert"
               
               #end add-point
               
               INSERT INTO inbm_t (inbment,inbmsite,inbmdocdt,inbmdocno,inbm003,inbm005,inbm006,inbm007, 
                   inbm004,inbm001,inbm002,inbmunit,inbm008,inbmstus,inbmownid,inbmowndp,inbmcrtid,inbmcrtdp, 
                   inbmcrtdt,inbmmodid,inbmmoddt,inbmcnfid,inbmcnfdt)
               VALUES (g_enterprise,g_inbm_m.inbmsite,g_inbm_m.inbmdocdt,g_inbm_m.inbmdocno,g_inbm_m.inbm003, 
                   g_inbm_m.inbm005,g_inbm_m.inbm006,g_inbm_m.inbm007,g_inbm_m.inbm004,g_inbm_m.inbm001, 
                   g_inbm_m.inbm002,g_inbm_m.inbmunit,g_inbm_m.inbm008,g_inbm_m.inbmstus,g_inbm_m.inbmownid, 
                   g_inbm_m.inbmowndp,g_inbm_m.inbmcrtid,g_inbm_m.inbmcrtdp,g_inbm_m.inbmcrtdt,g_inbm_m.inbmmodid, 
                   g_inbm_m.inbmmoddt,g_inbm_m.inbmcnfid,g_inbm_m.inbmcnfdt) 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "g_inbm_m:",SQLERRMESSAGE 
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
                  CALL aint701_detail_reproduce()
                  #因應特定程式需求, 重新刷新單身資料
                  CALL aint701_b_fill()
                  CALL aint701_b_fill2('0')
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
               CALL aint701_inbm_t_mask_restore('restore_mask_o')
               
               UPDATE inbm_t SET (inbmsite,inbmdocdt,inbmdocno,inbm003,inbm005,inbm006,inbm007,inbm004, 
                   inbm001,inbm002,inbmunit,inbm008,inbmstus,inbmownid,inbmowndp,inbmcrtid,inbmcrtdp, 
                   inbmcrtdt,inbmmodid,inbmmoddt,inbmcnfid,inbmcnfdt) = (g_inbm_m.inbmsite,g_inbm_m.inbmdocdt, 
                   g_inbm_m.inbmdocno,g_inbm_m.inbm003,g_inbm_m.inbm005,g_inbm_m.inbm006,g_inbm_m.inbm007, 
                   g_inbm_m.inbm004,g_inbm_m.inbm001,g_inbm_m.inbm002,g_inbm_m.inbmunit,g_inbm_m.inbm008, 
                   g_inbm_m.inbmstus,g_inbm_m.inbmownid,g_inbm_m.inbmowndp,g_inbm_m.inbmcrtid,g_inbm_m.inbmcrtdp, 
                   g_inbm_m.inbmcrtdt,g_inbm_m.inbmmodid,g_inbm_m.inbmmoddt,g_inbm_m.inbmcnfid,g_inbm_m.inbmcnfdt) 
 
                WHERE inbment = g_enterprise AND inbmdocno = g_inbmdocno_t
 
               IF SQLCA.SQLCODE THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = "inbm_t:",SQLERRMESSAGE 
                  LET g_errparam.code = SQLCA.SQLCODE 
                  LET g_errparam.popup = TRUE 
                  CALL s_transaction_end('N','0')
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               
               #add-point:單頭修改中 name="input.head.m_update"
               
               #end add-point
               
               
               
               
               #將遮罩欄位進行遮蔽
               CALL aint701_inbm_t_mask_restore('restore_mask_n')
               
               #修改歷程記錄(單頭修改)
               LET g_log1 = util.JSON.stringify(g_inbm_m_t)
               LET g_log2 = util.JSON.stringify(g_inbm_m)
               IF NOT cl_log_modified_record(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
               
               #add-point:單頭修改後 name="input.head.a_update"
               
               #end add-point
            END IF
            
            LET g_master_commit = "Y"
            LET g_inbmdocno_t = g_inbm_m.inbmdocno
 
            
      END INPUT
   
 
{</section>}
 
{<section id="aint701.input.body" >}
   
      #Page1 預設值產生於此處
      INPUT ARRAY g_inbn_d FROM s_detail1.*
          ATTRIBUTE(COUNT = g_rec_b,WITHOUT DEFAULTS, #MAXCOUNT = g_max_rec,
                  INSERT ROW = l_allow_insert, 
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
 
         #自訂ACTION(detail_input,page_1)
         
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION print_g02
            LET g_action_choice="print_g02"
               
               #add-point:ON ACTION print_g02 name="input.detail_input.page1.print_g02"
               CALL aint701_print('2')   #170119-00027#1 20170120 add by beckxie
               #END add-point
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION print_g01
            LET g_action_choice="print_g01"
               
               #add-point:ON ACTION print_g01 name="input.detail_input.page1.print_g01"
               CALL aint701_print('1')   #170119-00027#1 20170120 add by beckxie
               #END add-point
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION seal_box
            LET g_action_choice="seal_box"
               
               #add-point:ON ACTION seal_box name="input.detail_input.page1.seal_box"
               CALL aint701_seal_box()
               
               IF g_inbn3_d.getlength() = 0 THEN
                  LET g_detail_idx = l_ac #全部已封裝且待裝明細沒資料就結束
                  LET l_ac = g_detail_idx
                  LET g_detail_idx_list[1] = g_detail_idx
                  CALL aint701_b_fill()
                  CALL aint701_b_fill2('2')
                  ACCEPT DIALOG
               END IF
               CALL DIALOG.setCurrentRow("s_detail1",g_detail_idx)
               LET l_ac = g_detail_idx
               LET g_detail_idx_list[1] = g_detail_idx
               CALL aint701_set_entry_b(l_cmd)
               CALL aint701_set_no_entry_b(l_cmd)
               DISPLAY g_inbn_d[l_ac].inbn001 TO inbn001_1
               LET g_inbn_d_t.* = g_inbn_d[l_ac].*  #BACKUP
               LET g_inbn_d_o.* = g_inbn_d[l_ac].*  #BACKUP
               CALL aint701_b_fill2('2')
               NEXT FIELD inbo010_1
               #END add-point
 
 
 
 
         
         BEFORE INPUT
            #add-point:資料輸入前 name="input.body.before_input2"
            
            #end add-point
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN 
              CALL FGL_SET_ARR_CURR(g_inbn_d.getLength()+1) 
              LET g_insert = 'N' 
           END IF 
 
            CALL aint701_b_fill()
            #如果一直都在單身1則控制筆數位置
            IF g_loc = 'm' AND g_rec_b != 0 THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'1',"))
            END IF
            LET g_loc = 'm'
            LET g_rec_b = g_inbn_d.getLength()
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
            CALL aint701_b_fill2('2')
 
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            OPEN aint701_cl USING g_enterprise,g_inbm_m.inbmdocno
            IF SQLCA.SQLCODE THEN   #(ver:78)
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "OPEN aint701_cl:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
               LET g_errparam.popup = TRUE 
               CLOSE aint701_cl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               RETURN
            END IF
            
            LET g_rec_b = g_inbn_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND g_inbn_d[l_ac].inbn001 IS NOT NULL
 
            THEN
               LET l_cmd='u'
               LET g_inbn_d_t.* = g_inbn_d[l_ac].*  #BACKUP
               LET g_inbn_d_o.* = g_inbn_d[l_ac].*  #BACKUP
               CALL aint701_set_entry_b(l_cmd)
               #add-point:modify段after_set_entry_b name="input.body.after_set_entry_b"
 
               #end add-point  
               CALL aint701_set_no_entry_b(l_cmd)
               IF NOT aint701_lock_b("inbn_t","'1'") THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH aint701_bcl INTO g_inbn_d[l_ac].inbnsite,g_inbn_d[l_ac].inbnunit,g_inbn_d[l_ac].inbn001, 
                      g_inbn_d[l_ac].inbn002
                  IF SQLCA.SQLCODE THEN
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = g_inbn_d_t.inbn001,":",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
                  
                  #遮罩相關處理
                  LET g_inbn_d_mask_o[l_ac].* =  g_inbn_d[l_ac].*
                  CALL aint701_inbn_t_mask()
                  LET g_inbn_d_mask_n[l_ac].* =  g_inbn_d[l_ac].*
                  
                  LET g_bfill = "N"
                  CALL aint701_show()
                  LET g_bfill = "Y"
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            #add-point:modify段before row name="input.body.before_row"
            LET g_inbm_m.inbn001_1= g_inbn_d[l_ac].inbn001
            DISPLAY BY NAME g_inbm_m.inbn001_1 
            CALL aint701_set_entry(l_cmd)
            CALL aint701_set_no_entry(l_cmd)
            CALL aint701_set_act_visible()
            CALL aint701_set_act_no_visible()
            CALL aint701_set_act_visible_b()
            CALL aint701_set_act_no_visible_b()
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
            INITIALIZE g_inbn_d[l_ac].* TO NULL 
            INITIALIZE g_inbn_d_t.* TO NULL 
            INITIALIZE g_inbn_d_o.* TO NULL 
            #公用欄位給值(單身)
            
            #自定義預設值
                  LET g_inbn_d[l_ac].inbn002 = "1"
 
            #add-point:modify段before備份 name="input.body.insert.before_bak"
            LET g_inbn_d[l_ac].l_cnt_kind = 0
            LET g_inbn_d[l_ac].l_count= 0
            LET g_inbn_d[l_ac].inbn001 = "B1001"
            #自动新增箱，都是其他箱都封箱了，并且还有待扫信息，才会帮他自动新增箱
            LET l_cnt1 = g_inbn_d.getlength()
            #如果欲跳轉到的筆數到大於最後一筆,且待裝明細有資料需新增下一筆
            IF g_delete_flag THEN
               LET g_skip_1 = FALSE
               LET g_detail_idx = g_detail_idx-1         #161024-00023#11 20161030 add by beckxie
               LET g_detail_idx_list[1] = g_detail_idx   #161024-00023#11 20161030 add by beckxie
               NEXT FIELD inbm005
            END IF
            #IF l_ac > (l_cnt1-1) AND l_ac >1 THEN   #161213-00004#8 20161219 mark by beckxie
               #编辑状态下，按向下按钮，箱明细里应该可以新增一箱   #161213-00004#8 20161219 add by beckxie
               #IF g_inbn3_d.getlength() > 0 THEN   #待裝明細有資料   #161213-00004#8 20161219 mark by beckxie
               
                  #CALL aint701_inbn001_init(g_inbn_d[l_ac-1].inbn001) RETURNING g_inbn_d[l_ac].inbn001   #161017-00051#15 20161201 mark by beckxie
                  CALL aint701_inbn001_init() RETURNING g_inbn_d[l_ac].inbn001   #161017-00051#15 20161201 add by beckxie
                  LET g_next_inbo010 = TRUE  #接下來跳轉至條碼
            #161213-00004#8 20161219 mark by beckxie---S
            #   ELSE
            #      LET g_detail_idx = l_ac #全部已封裝且待裝明細沒資料就結束
            #      LET g_detail_idx_list[1] = l_ac
            #      CALL aint701_b_fill()
            #      CALL aint701_b_fill2('2')
            #      EXIT DIALOG
            #   END IF
            #   
            #ELSE
            #    LET g_detail_idx = l_ac
            #END IF
            #161213-00004#8 20161219 mark by beckxie---E
            CALL aint701_set_act_visible()
            CALL aint701_set_act_no_visible()
            LET g_inbm_m.inbn001_1= g_inbn_d[l_ac].inbn001
            DISPLAY BY NAME g_inbm_m.inbn001_1 
            #end add-point
            LET g_inbn_d_t.* = g_inbn_d[l_ac].*     #新輸入資料
            LET g_inbn_d_o.* = g_inbn_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL aint701_set_entry_b(l_cmd)
            #add-point:modify段after_set_entry_b name="input.body.insert.after_set_entry_b"
            
            #end add-point
            CALL aint701_set_no_entry_b(l_cmd)
            IF lb_reproduce THEN
               LET lb_reproduce = FALSE
               LET g_inbn_d[li_reproduce_target].* = g_inbn_d[li_reproduce].*
 
               LET g_inbn_d[li_reproduce_target].inbn001 = NULL
 
            END IF
            
 
            #add-point:modify段before insert name="input.body.before_insert"
            LET g_delete_flag = FALSE   #新增一筆時將刪除判斷設置為FALSE
            IF g_next_inbo010 THEN
               LET g_next_inbo010 = FALSE
               DISPLAY BY NAME g_inbn_d[l_ac].inbn001,g_inbn_d[l_ac].l_cnt_kind,g_inbn_d[l_ac].l_count,g_inbn_d[l_ac].inbn002
               NEXT FIELD inbo010_1
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
            SELECT COUNT(1) INTO l_count FROM inbn_t 
             WHERE inbnent = g_enterprise AND inbndocno = g_inbm_m.inbmdocno
 
               AND inbn001 = g_inbn_d[l_ac].inbn001
 
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #add-point:單身新增前 name="input.body.b_insert"
               
               #end add-point
            
               #同步新增到同層的table
                              INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_inbm_m.inbmdocno
               LET gs_keys[2] = g_inbn_d[g_detail_idx].inbn001
               CALL aint701_insert_b('inbn_t',gs_keys,"'1'")
                           
               #add-point:單身新增後 name="input.body.a_insert"
               
               #end add-point
            ELSE    
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = 'INSERT' 
               LET g_errparam.code = "std-00006" 
               LET g_errparam.popup = TRUE 
               INITIALIZE g_inbn_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CALL cl_err()
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "inbn_t:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL s_transaction_end('N','0')                    
               CALL cl_err()
               CANCEL INSERT
            ELSE
               #先刷新資料
               #CALL aint701_b_fill()
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
               LET gs_keys[01] = g_inbm_m.inbmdocno
 
               LET gs_keys[gs_keys.getLength()+1] = g_inbn_d_t.inbn001
 
            
               #刪除同層單身
               IF NOT aint701_delete_b('inbn_t',gs_keys,"'1'") THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aint701_bcl
                  CANCEL DELETE
               END IF
    
               #刪除下層單身
               IF NOT aint701_key_delete_b(gs_keys,'inbn_t') THEN
                  CALL s_transaction_end('N','0')
                  CLOSE aint701_bcl
                  CANCEL DELETE
               END IF
               
               #刪除多語言
               
 
               
               #add-point:單身刪除中 name="input.body.m_delete"
               
               #end add-point 
               
               CALL s_transaction_end('Y','0')
               CLOSE aint701_bcl
            
               LET g_rec_b = g_rec_b-1
               #add-point:單身刪除後 name="input.body.a_delete"
               
               #end add-point
               LET l_count = g_inbn_d.getLength()
               
               #add-point:單身刪除後(<>d) name="input.body.after_delete"
               #IF l_ac = g_inbn_d.getLength() THEN
                  LET g_delete_flag = TRUE   #刪除一筆時將刪除判斷設置為TRUE
               #END IF 
               #end add-point
            END IF
 
         AFTER DELETE
            #如果是最後一筆
            IF l_ac = (g_inbn_d.getLength() + 1) THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
            END IF
 
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbnsite
            #add-point:BEFORE FIELD inbnsite name="input.b.page1.inbnsite"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbnsite
            
            #add-point:AFTER FIELD inbnsite name="input.a.page1.inbnsite"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbnsite
            #add-point:ON CHANGE inbnsite name="input.g.page1.inbnsite"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbnunit
            #add-point:BEFORE FIELD inbnunit name="input.b.page1.inbnunit"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbnunit
            
            #add-point:AFTER FIELD inbnunit name="input.a.page1.inbnunit"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbnunit
            #add-point:ON CHANGE inbnunit name="input.g.page1.inbnunit"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD inbn001
            #add-point:BEFORE FIELD inbn001 name="input.b.page1.inbn001"
            CALL aint701_b_fill() #20161028
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD inbn001
            
            #add-point:AFTER FIELD inbn001 name="input.a.page1.inbn001"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF  g_inbm_m.inbmdocno IS NOT NULL AND g_inbn_d[g_detail_idx].inbn001 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_inbm_m.inbmdocno != g_inbmdocno_t OR g_inbn_d[g_detail_idx].inbn001 != g_inbn_d_t.inbn001)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(1) FROM inbn_t WHERE "||"inbnent = '" ||g_enterprise|| "' AND "||"inbndocno = '"||g_inbm_m.inbmdocno ||"' AND "|| "inbn001 = '"||g_inbn_d[g_detail_idx].inbn001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            
            #CALL aint701_b_fill2('2')   #161213-00022#2 20161215 mark by beckxie
            LET l_ac = g_detail_idx   #161213-00022#2 20161215 add by beckxie
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE inbn001
            #add-point:ON CHANGE inbn001 name="input.g.page1.inbn001"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.inbnsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbnsite
            #add-point:ON ACTION controlp INFIELD inbnsite name="input.c.page1.inbnsite"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbnunit
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbnunit
            #add-point:ON ACTION controlp INFIELD inbnunit name="input.c.page1.inbnunit"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.inbn001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD inbn001
            #add-point:ON ACTION controlp INFIELD inbn001 name="input.c.page1.inbn001"
            
            #END add-point
 
 
 
 
         ON ROW CHANGE
            IF INT_FLAG THEN
               LET INT_FLAG = 0
               LET g_inbn_d[l_ac].* = g_inbn_d_t.*
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = '' 
               LET g_errparam.code = 9001 
               LET g_errparam.popup = FALSE 
               CLOSE aint701_bcl
               CALL s_transaction_end('N','0')
               CALL cl_err()
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = g_inbn_d[l_ac].inbn001 
               LET g_errparam.code = -263 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               LET g_inbn_d[l_ac].* = g_inbn_d_t.*
            ELSE
            
               #add-point:單身修改前 name="input.body.b_update"
               
               #end add-point
               
               #寫入修改者/修改日期資訊(單身)
               
      
               #將遮罩欄位還原
               CALL aint701_inbn_t_mask_restore('restore_mask_o')
      
               UPDATE inbn_t SET (inbndocno,inbnsite,inbnunit,inbn001,inbn002) = (g_inbm_m.inbmdocno, 
                   g_inbn_d[l_ac].inbnsite,g_inbn_d[l_ac].inbnunit,g_inbn_d[l_ac].inbn001,g_inbn_d[l_ac].inbn002) 
 
                WHERE inbnent = g_enterprise AND inbndocno = g_inbm_m.inbmdocno 
 
                  AND inbn001 = g_inbn_d_t.inbn001 #項次   
 
                  
               #add-point:單身修改中 name="input.body.m_update"
               
               #end add-point
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     LET g_inbn_d[l_ac].* = g_inbn_d_t.*
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "inbn_t" 
                     LET g_errparam.code = "std-00009" 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()
                     
                  WHEN SQLCA.SQLCODE #其他錯誤
                     LET g_inbn_d[l_ac].* = g_inbn_d_t.*  
                     INITIALIZE g_errparam TO NULL 
                     LET g_errparam.extend = "inbn_t:",SQLERRMESSAGE 
                     LET g_errparam.code = SQLCA.SQLCODE 
                     LET g_errparam.popup = TRUE 
                     CALL s_transaction_end('N','0')
                     CALL cl_err()                   
                     
                  OTHERWISE
                     #資料多語言用-增/改
                     
                                    INITIALIZE gs_keys TO NULL 
               LET gs_keys[1] = g_inbm_m.inbmdocno
               LET gs_keys_bak[1] = g_inbmdocno_t
               LET gs_keys[2] = g_inbn_d[g_detail_idx].inbn001
               LET gs_keys_bak[2] = g_inbn_d_t.inbn001
               CALL aint701_update_b('inbn_t',gs_keys,gs_keys_bak,"'1'")
               END CASE
 
               #將遮罩欄位進行遮蔽
               CALL aint701_inbn_t_mask_restore('restore_mask_n')
               
               #判斷key是否有改變
               INITIALIZE gs_keys TO NULL
               IF NOT(g_inbn_d[g_detail_idx].inbn001 = g_inbn_d_t.inbn001 
 
                  ) THEN
                  LET gs_keys[01] = g_inbm_m.inbmdocno
 
                  LET gs_keys[gs_keys.getLength()+1] = g_inbn_d_t.inbn001
 
                  CALL aint701_key_update_b(gs_keys,'inbn_t')
               END IF
               
               #修改歷程記錄(單身修改)
               LET g_log1 = util.JSON.stringify(g_inbm_m),util.JSON.stringify(g_inbn_d_t)
               LET g_log2 = util.JSON.stringify(g_inbm_m),util.JSON.stringify(g_inbn_d[l_ac])
               IF NOT cl_log_modified_record_d(g_log1,g_log2) THEN 
                  CALL s_transaction_end('N','0')
               END IF
               
               #add-point:單身修改後 name="input.body.a_update"
 
               #end add-point
 
            END IF
            
         AFTER ROW
            #add-point:單身after_row name="input.body.after_row"
            LET g_delete_flag = FALSE   #161017-00051#15 20161201 add by beckxie
            #end add-point
            CALL aint701_unlock_b("inbn_t","'1'")
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
               LET g_inbn_d[li_reproduce_target].* = g_inbn_d[li_reproduce].*
 
               LET g_inbn_d[li_reproduce_target].inbn001 = NULL
 
            ELSE
               CALL FGL_SET_ARR_CURR(g_inbn_d.getLength()+1)
               LET lb_reproduce = TRUE
               LET li_reproduce = l_ac
               LET li_reproduce_target = g_inbn_d.getLength()+1
            END IF
            
         #ON ACTION cancel
         #   LET INT_FLAG = 1
         #   LET g_detail_idx = 1
         #   EXIT DIALOG 
 
      END INPUT
      
 
      
 
 
      DISPLAY ARRAY g_inbn2_d TO s_detail2.* ATTRIBUTES(COUNT=g_rec_b)  
    
         BEFORE ROW 
            CALL aint701_idx_chk()
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
            CALL aint701_idx_chk()
            LET g_current_page = 2
      
         #自訂ACTION(detail_show,page_2)
         
      
         #add-point:page2自定義行為 name="input.body2.action"
         
         #end add-point
      
      END DISPLAY
 
 
{</section>}
 
{<section id="aint701.input.other" >}
      
      #add-point:自定義input name="input.more_input"
      DISPLAY ARRAY g_inbn3_d TO s_detail3.* ATTRIBUTES(COUNT=g_rec_b)  
    
         BEFORE ROW 
            CALL aint701_idx_chk()
            LET l_ac = DIALOG.getCurrentRow("s_detail3")
            LET g_detail_idx3 = l_ac
            
            #add-point:page2, before row動作 name="input.body2.before_row"

            #end add-point
            
         BEFORE DISPLAY
            #如果一直都在單身2則控制筆數位置
            IF g_loc = 'd' THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'3',"))
            END IF
            LET g_loc = 'd'
            LET l_ac = DIALOG.getCurrentRow("s_detail3")
            CALL aint701_idx_chk()
            LET g_current_page = 3
      
         #自訂ACTION(detail_show,page_2)
         
      
         #add-point:page2自定義行為 name="input.body2.action"

         #end add-point
      
      END DISPLAY
      DISPLAY ARRAY g_inbn4_d TO s_detail4.* ATTRIBUTES(COUNT=g_rec_b)  
    
         BEFORE ROW 
            CALL aint701_idx_chk()
            LET l_ac = DIALOG.getCurrentRow("s_detail4")
            LET g_detail_idx4 = l_ac
            
            #add-point:page2, before row動作 name="input.body2.before_row"

            #end add-point
            
         BEFORE DISPLAY
            #如果一直都在單身2則控制筆數位置
            IF g_loc = 'd' THEN
               CALL FGL_SET_ARR_CURR(g_idx_group.getValue("'4',"))
            END IF
            LET g_loc = 'd'
            LET l_ac = DIALOG.getCurrentRow("s_detail4")
            CALL aint701_idx_chk()
            LET g_current_page = 4
      
         #自訂ACTION(detail_show,page_2)
         
      
         #add-point:page2自定義行為 name="input.body2.action"

         #end add-point
      
      END DISPLAY
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
            NEXT FIELD inbmdocno
         ELSE
            CASE g_aw
               WHEN "s_detail1"
                  NEXT FIELD inbnsite
               WHEN "s_detail2"
                  NEXT FIELD inbosite
 
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
         #161017-00051#15 20161201 add by beckxie---S
         CALL aint701_delete_inbn() RETURNING l_success
         #LET g_cmd = ''   #161213-00004#11 20161220 mark by beckxie
         
         #CALL aint701_b_fill()
         #CALL aint701_b_fill2('')
         #LET l_ac = g_detail_idx   #161213-00004#11 20161220 mark by beckxie
         #LET g_inbn_d_t.* = g_inbn_d[l_ac].*  #BACKUP   #161213-00022#2 20161215 mark by beckxie
         #LET g_inbn_d_o.* = g_inbn_d[l_ac].*  #BACKUP   #161213-00022#2 20161215 mark by beckxie
         #161017-00051#15 20161201 add by beckxie---E
         #end add-point    
         ACCEPT DIALOG
        
      ON ACTION cancel      #在dialog button (放棄)
         #add-point:input段cancel name="input.cancel"
         #161017-00051#15 20161201 add by beckxie---S
         CALL aint701_delete_inbn() RETURNING l_success
         #LET g_cmd = ''   #161213-00004#11 20161220 mark by beckxie
         #161213-00004#8 20161220 add by beckxie---S
         #即使點了取消,也必須刪自動產生且裝箱明細為空的最大箱號)
         IF s_transaction_chk('Y','0') THEN
            DISPLAY "g_intrans"
            CALL s_transaction_end('Y','0')
            CALL s_transaction_begin()
         END IF
         #161213-00004#8 20161220 add by beckxie---E
         #CALL aint701_b_fill()
         #CALL aint701_b_fill2('')
         #161213-00004#11 20161220 mark by beckxie---S
         #LET l_ac = g_detail_idx   
         #LET g_inbn_d_t.* = g_inbn_d[l_ac].*  #BACKUP  
         #LET g_inbn_d_o.* = g_inbn_d[l_ac].*  #BACKUP  
         #161213-00004#11 20161220 mark by beckxie---E
         #161017-00051#15 20161201 add by beckxie---E
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
 
{<section id="aint701.show" >}
#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION aint701_show()
   #add-point:show段define(客製用) name="show.define_customerization"
   
   #end add-point  
   DEFINE l_ac_t    LIKE type_t.num10
   #add-point:show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="show.define"
   
   #end add-point  
   
   #add-point:Function前置處理 name="show.before"
 
   #end add-point
   
   
   
   IF g_bfill = "Y" THEN
      CALL aint701_b_fill() #單身填充
      CALL aint701_b_fill2('0') #單身填充
   END IF
     
   #帶出公用欄位reference值
   #應用 a12 樣板自動產生(Version:4)
 
 
 
   
   #顯示followup圖示
   #應用 a48 樣板自動產生(Version:3)
   CALL aint701_set_pk_array()
   #add-point:ON ACTION agendum name="show.follow_pic"
   CALL aint701_set_comp_visible_b()      #161024-00023#4 20161026 add by beckxie
   CALL aint701_set_comp_no_visible_b()   #161024-00023#4 20161026 add by beckxie
   #END add-point
   CALL cl_user_overview_set_follow_pic()
  
 
 
 
   
   LET l_ac_t = l_ac
   
   #讀入ref值(單頭)
   #add-point:show段reference name="show.head.reference"
   
   #end add-point
   
   #遮罩相關處理
   LET g_inbm_m_mask_o.* =  g_inbm_m.*
   CALL aint701_inbm_t_mask()
   LET g_inbm_m_mask_n.* =  g_inbm_m.*
   
   #將資料輸出到畫面上
   DISPLAY BY NAME g_inbm_m.inbmsite,g_inbm_m.inbmsite_desc,g_inbm_m.inbmdocdt,g_inbm_m.inbmdocno,g_inbm_m.inbm003, 
       g_inbm_m.inbm005,g_inbm_m.inbm005_desc,g_inbm_m.inbm006,g_inbm_m.inbm006_desc,g_inbm_m.inbm007, 
       g_inbm_m.inbm004,g_inbm_m.inbm001,g_inbm_m.inbm001_desc,g_inbm_m.inbm002,g_inbm_m.inbmunit,g_inbm_m.inbmunit_desc, 
       g_inbm_m.inbm008,g_inbm_m.inbmstus,g_inbm_m.inbmownid,g_inbm_m.inbmownid_desc,g_inbm_m.inbmowndp, 
       g_inbm_m.inbmowndp_desc,g_inbm_m.inbmcrtid,g_inbm_m.inbmcrtid_desc,g_inbm_m.inbmcrtdp,g_inbm_m.inbmcrtdp_desc, 
       g_inbm_m.inbmcrtdt,g_inbm_m.inbmmodid,g_inbm_m.inbmmodid_desc,g_inbm_m.inbmmoddt,g_inbm_m.inbmcnfid, 
       g_inbm_m.inbmcnfid_desc,g_inbm_m.inbmcnfdt,g_inbm_m.inbn001_1,g_inbm_m.l_symbol,g_inbm_m.l_num, 
       g_inbm_m.inbo010_1
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_inbm_m.inbmstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #讀入ref值(單身)
   FOR l_ac = 1 TO g_inbn_d.getLength()
      #add-point:show段單身reference name="show.body.reference"
      
      #end add-point
   END FOR
   
   FOR l_ac = 1 TO g_inbn2_d.getLength()
      #add-point:show段單身reference name="show.body2.reference"
      
      #end add-point
   END FOR
 
   
    
   
   #add-point:show段other name="show.other"
   LET g_inbm_m.inbn001_1 = g_inbn_d[g_detail_idx].inbn001
   DISPLAY BY NAME g_inbm_m.inbn001_1   
   #end add-point  
   
   LET l_ac = l_ac_t
   
   #移動上下筆可以連動切換資料
   CALL cl_show_fld_cont()     
 
   CALL aint701_detail_show()
 
   #add-point:show段之後 name="show.after"
   CALL aint701_set_act_visible()
   CALL aint701_set_act_no_visible()
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="aint701.detail_show" >}
#+ 第二階單身reference
PRIVATE FUNCTION aint701_detail_show()
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
 
{<section id="aint701.reproduce" >}
#+ 資料複製
PRIVATE FUNCTION aint701_reproduce()
   #add-point:reproduce段define(客製用) name="reproduce.define_customerization"
   
   #end add-point   
   DEFINE l_newno     LIKE inbm_t.inbmdocno 
   DEFINE l_oldno     LIKE inbm_t.inbmdocno 
 
   DEFINE l_master    RECORD LIKE inbm_t.* #此變數樣板目前無使用
   DEFINE l_detail    RECORD LIKE inbn_t.* #此變數樣板目前無使用
 
   DEFINE l_detail2    RECORD LIKE inbo_t.* #此變數樣板目前無使用
 
 
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
   
   IF g_inbm_m.inbmdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
    
   LET g_inbmdocno_t = g_inbm_m.inbmdocno
 
    
   LET g_inbm_m.inbmdocno = ""
 
 
   CALL cl_set_head_visible("","YES")
 
   #公用欄位給予預設值
   #應用 a14 樣板自動產生(Version:5)    
      #公用欄位新增給值  
      LET g_inbm_m.inbmownid = g_user
      LET g_inbm_m.inbmowndp = g_dept
      LET g_inbm_m.inbmcrtid = g_user
      LET g_inbm_m.inbmcrtdp = g_dept 
      LET g_inbm_m.inbmcrtdt = cl_get_current()
      LET g_inbm_m.inbmmodid = g_user
      LET g_inbm_m.inbmmoddt = cl_get_current()
      LET g_inbm_m.inbmstus = 'N'
 
 
 
   
   CALL s_transaction_begin()
   
   #add-point:複製輸入前 name="reproduce.head.b_input"
   
   #end add-point
   
   #顯示狀態(stus)圖片
         #應用 a21 樣板自動產生(Version:3)
	  #根據當下狀態碼顯示圖片
      CASE g_inbm_m.inbmstus 
         WHEN "N"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
         WHEN "Y"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
 
 
 
   
   #清空key欄位的desc
   
   
   CALL aint701_input("r")
   
   IF INT_FLAG AND NOT g_master_insert THEN
      LET INT_FLAG = 0
      DISPLAY g_detail_cnt  TO FORMONLY.h_count    #總筆數
      DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
      LET INT_FLAG = 0
      INITIALIZE g_inbm_m.* TO NULL
      INITIALIZE g_inbn_d TO NULL
      INITIALIZE g_inbn2_d TO NULL
 
      #add-point:複製取消後 name="reproduce.cancel"
      
      #end add-point
      CALL aint701_show()
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
   CALL aint701_set_act_visible()   
   CALL aint701_set_act_no_visible()
   
   #將新增的資料併入搜尋條件中
   LET g_inbmdocno_t = g_inbm_m.inbmdocno
 
   
   #組合新增資料的條件
   LET g_add_browse = " inbment = " ||g_enterprise|| " AND",
                      " inbmdocno = '", g_inbm_m.inbmdocno, "' "
 
   #填到最後面
   LET g_current_idx = g_browser.getLength() + 1
   CALL aint701_browser_fill("")
   
   DISPLAY g_browser_cnt TO FORMONLY.h_count    #總筆數
   DISPLAY g_current_idx TO FORMONLY.h_index    #當下筆數
   CALL cl_navigator_setting(g_current_idx, g_browser_cnt)
   
   #add-point:完成複製段落後 name="reproduce.after_reproduce"
   
   #end add-point
   
   CALL aint701_idx_chk()
   
   LET g_data_owner = g_inbm_m.inbmownid      
   LET g_data_dept  = g_inbm_m.inbmowndp
   
   #功能已完成,通報訊息中心
   CALL aint701_msgcentre_notify('reproduce')
 
END FUNCTION
 
{</section>}
 
{<section id="aint701.detail_reproduce" >}
#+ 單身自動複製
PRIVATE FUNCTION aint701_detail_reproduce()
   #add-point:delete段define(客製用) name="detail_reproduce.define_customerization"
   
   #end add-point    
   DEFINE ls_sql      STRING
   DEFINE ld_date     DATETIME YEAR TO SECOND
   DEFINE l_detail    RECORD LIKE inbn_t.* #此變數樣板目前無使用
 
   DEFINE l_detail2    RECORD LIKE inbo_t.* #此變數樣板目前無使用
 
 
   #add-point:delete段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="detail_reproduce.define"
   
   #end add-point    
   
   #add-point:Function前置處理  name="detail_reproduce.pre_function"
   
   #end add-point
   
   CALL s_transaction_begin()
   
   LET ld_date = cl_get_current()
   
   DROP TABLE aint701_detail
   
   #add-point:單身複製前1 name="detail_reproduce.body.table1.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM inbn_t
    WHERE inbnent = g_enterprise AND inbndocno = g_inbmdocno_t
 
    INTO TEMP aint701_detail
 
   #將key修正為調整後   
   UPDATE aint701_detail 
      #更新key欄位
      SET inbndocno = g_inbm_m.inbmdocno
 
      #更新共用欄位
      
 
   #add-point:單身修改前 name="detail_reproduce.body.table1.b_update"
   
   #end add-point                                       
  
   #將資料塞回原table   
   INSERT INTO inbn_t SELECT * FROM aint701_detail
   
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
   DROP TABLE aint701_detail
   
   #add-point:單身複製後1 name="detail_reproduce.body.table1.a_insert"
   
   #end add-point
 
 
   
   #add-point:單身複製前 name="detail_reproduce.body.table2.b_insert"
   
   #end add-point
   
   #CREATE TEMP TABLE
   SELECT * FROM inbo_t 
    WHERE inboent = g_enterprise AND inbodocno = g_inbmdocno_t
 
    INTO TEMP aint701_detail
 
   #將key修正為調整後   
   UPDATE aint701_detail SET inbodocno = g_inbm_m.inbmdocno
 
  
   #add-point:單身修改前 name="detail_reproduce.body.table2.b_update"
   
   #end add-point    
  
   #將資料塞回原table   
   INSERT INTO inbo_t SELECT * FROM aint701_detail
   
   #add-point:單身複製中 name="detail_reproduce.body.table2.m_insert"
   
   #end add-point
   
   #刪除TEMP TABLE
   DROP TABLE aint701_detail
   
   LET g_data_owner = g_inbm_m.inbmownid      
   LET g_data_dept  = g_inbm_m.inbmowndp
   
   #add-point:單身複製後 name="detail_reproduce.body.table2.a_insert"
   
   #end add-point
 
 
   
   #多語言複製段落
   
   
   CALL s_transaction_end('Y','0')
   
   #已新增完, 調整資料內容(修改時使用)
   LET g_inbmdocno_t = g_inbm_m.inbmdocno
 
   
END FUNCTION
 
{</section>}
 
{<section id="aint701.delete" >}
#+ 資料刪除
PRIVATE FUNCTION aint701_delete()
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
   
   IF g_inbm_m.inbmdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code = "std-00003" 
      LET g_errparam.popup = FALSE 
      CALL cl_err()
      RETURN
   END IF
   
   
   
   CALL s_transaction_begin()
 
   OPEN aint701_cl USING g_enterprise,g_inbm_m.inbmdocno
   IF SQLCA.SQLCODE THEN   #(ver:78)
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aint701_cl:",SQLERRMESSAGE 
      LET g_errparam.code = SQLCA.SQLCODE   #(ver:78)
      LET g_errparam.popup = TRUE 
      CLOSE aint701_cl
      CALL s_transaction_end('N','0')
      CALL cl_err()
      RETURN
   END IF
 
   #顯示最新的資料
   EXECUTE aint701_master_referesh USING g_inbm_m.inbmdocno INTO g_inbm_m.inbmsite,g_inbm_m.inbmdocdt, 
       g_inbm_m.inbmdocno,g_inbm_m.inbm003,g_inbm_m.inbm005,g_inbm_m.inbm006,g_inbm_m.inbm007,g_inbm_m.inbm004, 
       g_inbm_m.inbm001,g_inbm_m.inbm002,g_inbm_m.inbmunit,g_inbm_m.inbm008,g_inbm_m.inbmstus,g_inbm_m.inbmownid, 
       g_inbm_m.inbmowndp,g_inbm_m.inbmcrtid,g_inbm_m.inbmcrtdp,g_inbm_m.inbmcrtdt,g_inbm_m.inbmmodid, 
       g_inbm_m.inbmmoddt,g_inbm_m.inbmcnfid,g_inbm_m.inbmcnfdt,g_inbm_m.inbmsite_desc,g_inbm_m.inbm005_desc, 
       g_inbm_m.inbm006_desc,g_inbm_m.inbm001_desc,g_inbm_m.inbmunit_desc,g_inbm_m.inbmownid_desc,g_inbm_m.inbmowndp_desc, 
       g_inbm_m.inbmcrtid_desc,g_inbm_m.inbmcrtdp_desc,g_inbm_m.inbmmodid_desc,g_inbm_m.inbmcnfid_desc 
 
   
   
   #檢查是否允許此動作
   IF NOT aint701_action_chk() THEN
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #遮罩相關處理
   LET g_inbm_m_mask_o.* =  g_inbm_m.*
   CALL aint701_inbm_t_mask()
   LET g_inbm_m_mask_n.* =  g_inbm_m.*
   
   CALL aint701_show()
   
   #add-point:delete段before ask name="delete.before_ask"
   
   #end add-point 
 
   IF cl_ask_del_master() THEN              #確認一下
   
      #add-point:單頭刪除前 name="delete.head.b_delete"
      
      #end add-point   
      
      #應用 a47 樣板自動產生(Version:4)
      #刪除相關文件
      CALL aint701_set_pk_array()
      #add-point:相關文件刪除前 name="delete.befroe.related_document_remove"
      
      #end add-point   
      CALL cl_doc_remove()  
 
 
 
  
  
      #資料備份
      LET g_inbmdocno_t = g_inbm_m.inbmdocno
 
 
      DELETE FROM inbm_t
       WHERE inbment = g_enterprise AND inbmdocno = g_inbm_m.inbmdocno
 
       
      #add-point:單頭刪除中 name="delete.head.m_delete"
      
      #end add-point
       
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = g_inbm_m.inbmdocno,":",SQLERRMESSAGE  
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
      
      DELETE FROM inbn_t
       WHERE inbnent = g_enterprise AND inbndocno = g_inbm_m.inbmdocno
 
 
      #add-point:單身刪除中 name="delete.body.m_delete"
      
      #end add-point
         
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "inbn_t:",SQLERRMESSAGE 
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
      DELETE FROM inbo_t
       WHERE inboent = g_enterprise AND
             inbodocno = g_inbm_m.inbmdocno
      #add-point:單身刪除中 name="delete.body.m_delete2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "inbo_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL s_transaction_end('N','0')
         CALL cl_err()
         RETURN
      END IF      
 
      #add-point:單身刪除後 name="delete.body.a_delete2"
      
      #end add-point
 
 
      
      #修改歷程記錄(刪除)
      LET g_log1 = util.JSON.stringify(g_inbm_m)   #(ver:78)
      IF NOT cl_log_modified_record(g_log1,'') THEN    #(ver:78)
         CLOSE aint701_cl
         CALL s_transaction_end('N','0')
         RETURN
      END IF
             
      CLEAR FORM
      CALL g_inbn_d.clear() 
      CALL g_inbn2_d.clear()       
 
     
      CALL aint701_ui_browser_refresh()  
      #CALL aint701_ui_headershow()  
      #CALL aint701_ui_detailshow()
 
      #add-point:多語言刪除 name="delete.lang.before_delete"
      
      #end add-point
      
      #單頭多語言刪除
      
      
      #單身多語言刪除
      
      
 
   
      #add-point:多語言刪除 name="delete.lang.delete"
      
      #end add-point
      
      IF g_browser_cnt > 0 THEN 
         #CALL aint701_browser_fill("")
         CALL aint701_fetch('P')
         DISPLAY g_browser_cnt TO FORMONLY.h_count   #總筆數的顯示
         DISPLAY g_browser_cnt TO FORMONLY.b_count   #總筆數的顯示
      ELSE
         CLEAR FORM
      END IF
      
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
 
   CLOSE aint701_cl
 
   #功能已完成,通報訊息中心
   CALL aint701_msgcentre_notify('delete')
    
END FUNCTION
 
{</section>}
 
{<section id="aint701.b_fill" >}
#+ 單身陣列填充
PRIVATE FUNCTION aint701_b_fill()
   #add-point:b_fill段define(客製用) name="b_fill.define_customerization"
   
   #end add-point     
   DEFINE p_wc2      STRING
   DEFINE li_idx     LIKE type_t.num10
   #add-point:b_fill段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill.define"
   DEFINE l_sql      STRING
   DEFINE l_inag007  LIKE inag_t.inag007   #庫存單位
   DEFINE l_inag009  LIKE inag_t.inag009   #庫存數量
   DEFINE l_success  LIKE type_t.num5
   DEFINE l_qty      LIKE type_t.num20     #轉換單位後的數量
   DEFINE l_i        LIKE type_t.num5      #161213-00022#2 20161216 add by beckxie
   #end add-point     
   
   #add-point:Function前置處理  name="b_fill.pre_function"
   
   #end add-point
   
   #清空第一階單身
   CALL g_inbn_d.clear()
 
 
   #add-point:b_fill段sql_before name="b_fill.sql_before"
   CALL g_inbn3_d.clear()
   CALL g_inbn4_d.clear()
   #end add-point
   
   #判斷是否填充
   IF aint701_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF (g_action_choice = "query" OR cl_null(g_action_choice))
      #add-point:b_fill段long_sql_if name="b_fill.long_sql_if"
      
      #end add-point
      THEN
         LET g_sql = "SELECT  DISTINCT inbnsite,inbnunit,inbn001,inbn002  FROM inbn_t",   
                     " INNER JOIN inbm_t ON inbment = " ||g_enterprise|| " AND inbmdocno = inbndocno ",
 
                     #"",
                     " LEFT JOIN inbo_t ON inbnent = inboent AND inbndocno = inbodocno AND inbn001 = inbo001 ",
                     "",
                     #下層單身所需的join條件
                     " ",
 
 
                     
                     " WHERE inbnent=? AND inbndocno=?"
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
 
         
         LET g_sql = g_sql, " ORDER BY inbn_t.inbn001"
         
         #add-point:單身填充控制 name="b_fill.sql"
         #瀏覽時為升序,編輯時為降序
         IF NOT cl_null(g_cmd) THEN
            LET g_sql = g_sql, " DESC "   #161017-00051#15 20161201 add by beckxie
         END IF
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aint701_pb FROM g_sql
         DECLARE b_fill_cs CURSOR FOR aint701_pb
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
   #  OPEN b_fill_cs USING g_enterprise,g_inbm_m.inbmdocno   #(ver:78)
                                               
      FOREACH b_fill_cs USING g_enterprise,g_inbm_m.inbmdocno INTO g_inbn_d[l_ac].inbnsite,g_inbn_d[l_ac].inbnunit, 
          g_inbn_d[l_ac].inbn001,g_inbn_d[l_ac].inbn002   #(ver:78)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         #款數
         SELECT COUNT(1) INTO g_inbn_d[l_ac].l_cnt_kind 
           FROM (SELECT inbo001,inbo006,inbo007 FROM inbo_t
          WHERE inboent = g_enterprise AND inbodocno = g_inbm_m.inbmdocno
            AND inbo001 = g_inbn_d[l_ac].inbn001
          GROUP BY inbo001,inbo006,inbo007)
         #數量
         SELECT SUM(inbo009) INTO g_inbn_d[l_ac].l_count FROM inbo_t 
          WHERE inboent = g_enterprise AND inbodocno = g_inbm_m.inbmdocno 
            AND inbo001 = g_inbn_d[l_ac].inbn001
          GROUP BY inbo001
         IF cl_null(g_inbn_d[l_ac].l_cnt_kind) THEN
            LET g_inbn_d[l_ac].l_cnt_kind  = 0
         END IF
         IF cl_null(g_inbn_d[l_ac].l_count) THEN
            LET g_inbn_d[l_ac].l_count  = 0
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
   #s_detail3
   #待裝明細
   IF aint701_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF g_action_choice <> 'fetch' OR cl_null(g_action_choice) THEN
         #161024-00023#4 20161026 mark by beckxie---S
         #LET g_sql = "SELECT pmcz004,imaal003,imaal004,pmcz005,pmcz005_desc, ",
         #            "                    pmcz006,pmcz006_desc,l_sum,'' ",
         #            "  FROM (SELECT pmcz004,imaal003,imaal004,pmcz005,pmcz005_desc, ",
         #            "               pmcz006,pmcz006_desc,COALESCE(SUM(l_count2),0) l_sum , ",
         #            "       '' ",
         #            "         FROM (SELECT pmcz023,pmcz001,pmcz002,pmcz003,pmcz004, ",
         #            "                      imaal003,imaal004,pmcz005, ",
         #            "                      (SELECT inaml004 ",
         #            "                         FROM inaml_t ",
         #            "                        WHERE inamlent = pmczent ",
         #            "                          AND inaml001 = pmcz004 ",
         #            "                          AND inaml002 = pmcz005 ",
         #            "                          AND inaml003 = '",g_dlang,"') pmcz005_desc, ",
         #            "                      pmcz006,",
         #            "                      (SELECT oocal003 ",
         #            "                         FROM oocal_t ",
         #            "                        WHERE oocalent = pmczent ",
         #            "                          AND oocal001 = pmcz006 ",
         #            "                          AND oocal002 = '",g_dlang,"') pmcz006_desc, ",
         #            "                      COALESCE(pmcz051,0) pmcz051,",
         #            "                      COALESCE(pmcz064,0) pmcz064, ",
         #            "                      COALESCE((pmcz051-pmcz064),0) l_count2,",
         #            "                      COALESCE((imaa157*pmcz064),0) l_count3 ",
         #            "                 FROM inbm_t ,indj_t ,pmcz_t ",
         #            "                      LEFT JOIN imaa_t ON imaaent = pmczent AND imaa001 = pmcz004 ",
         #            "                      LEFT JOIN imaal_t ON imaalent = pmczent AND imaal001 = pmcz004 AND imaal002 = '",g_dlang,"' ",
         #            "                WHERE indjent = inbment AND indjdocno = inbm004 AND inbm003 ='1' ",
         #            "                  AND pmczent = indjent AND pmcz001 = indj001 ",
         #            "                  AND pmcz002 = indj002 AND pmcz063 = inbm008 ",
         #            "                  AND pmcz062 = inbm001 AND pmcz001 = COALESCE(inbm002,pmcz001) ",
         #            "                  AND inbment=? AND inbmdocno=? ) ",
         #            "         GROUP BY pmcz004,imaal003,imaal004,pmcz005,pmcz005_desc,pmcz006,pmcz006_desc) ",
         #            "  WHERE l_sum > 0 " #差異量>0 才顯示
         #161024-00023#4 20161026 mark by beckxie---E
         #161024-00023#4 20161026 add by beckxie---S
         LET g_sql = "SELECT inbp005,imaal003,imaal004,inbp006,inbp006_desc, ",
                     "                    inbp007,inbp007_desc,l_sum,'' ",
                     "  FROM (SELECT inbp005,imaal003,imaal004,inbp006,inbp006_desc,",
                     "               inbp007,inbp007_desc,COALESCE(SUM(l_count2),0) l_sum ",
                     "         FROM (SELECT inbp005,imaal003,imaal004, ",
                     "                      inbp006,",
                     "                      (SELECT inaml004 ",
                     "                         FROM inaml_t ",
                     "                        WHERE inamlent = inbpent ",
                     "                          AND inaml001 = inbp005 ",
                     "                          AND inaml002 = inbp006 ",
                     "                          AND inaml003 = '",g_dlang,"') inbp006_desc, ",
                     "                      inbp007,",
                     "                      (SELECT oocal003 ",
                     "                         FROM oocal_t ",
                     "                        WHERE oocalent = inbpent ",
                     "                          AND oocal001 = inbp007 ",
                     "                          AND oocal002 = '",g_dlang,"') inbp007_desc, ",
                     "                      (COALESCE(inbp008,0)-COALESCE(inbp009,0)) l_count2 ",
                     "                 FROM inbp_t ",
                     "                      LEFT JOIN imaal_t ON imaalent = inbpent AND imaal001 = inbp005 AND imaal002 = '",g_dlang,"' ",
                     #"                WHERE inbpent = ? AND inbpdocno = ? ) ",   #161024-00023#21 20161121 mark by beckxie
                     "                WHERE inbpent = ? AND inbpdocno = ? AND ",g_wc3_table1,") ",   #161024-00023#21 20161121 add by beckxie
                     "         GROUP BY inbp005,imaal003,imaal004,inbp006,inbp006_desc,inbp007,inbp007_desc) ",
                     "  WHERE l_sum > 0 " #差異量>0 才顯示
         #161024-00023#4 20161026 add by beckxie---E
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"
   
         #end add-point
         #IF NOT cl_null(g_wc4_table1) THEN
         #   LET g_sql = g_sql CLIPPED, " AND ", g_wc4_table1 CLIPPED
         #END IF
         
         #子單身的WC
   
         
         #LET g_sql = g_sql, " ORDER BY pmcz004,pmcz005,pmcz006"   #161024-00023#4 20161026 mark by beckxie
         LET g_sql = g_sql, " ORDER BY inbp005,inbp006,inbp007"    #161024-00023#4 20161026 add by beckxie
         
         #add-point:單身填充控制 name="b_fill.sql"
         #庫存量
         LET l_sql = "SELECT inag007,SUM(inag009) ",
                     "  FROM inag_t ",
                     " WHERE inagent = ",g_enterprise," AND inagsite = '",g_inbm_m.inbmsite,"' ",
                     "   AND inag001 = ? ",
                     "   AND inag002 = ? ",
                     "   AND inag010 = 'Y' ",
                     " GROUP BY inag007 "
         PREPARE sel_inag_pre FROM l_sql
         DECLARE sel_inag_cs CURSOR FOR sel_inag_pre
         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aint701_pb3 FROM g_sql
         DECLARE b_fill_cs3 CURSOR FOR aint701_pb3
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs3 USING g_enterprise,g_inbm_m.inbmdocno
      #161024-00023#4 20161025 mark by beckxie---S
      #FOREACH b_fill_cs3 INTO g_inbn3_d[l_ac].pmcz004,g_inbn3_d[l_ac].pmcz004_desc,g_inbn3_d[l_ac].pmcz004_desc_1,g_inbn3_d[l_ac].pmcz005,g_inbn3_d[l_ac].pmcz005_desc,
      #                        g_inbn3_d[l_ac].pmcz006,g_inbn3_d[l_ac].pmcz006_desc,g_inbn3_d[l_ac].l_sum,g_inbn3_d[l_ac].l_count_1
      #161024-00023#4 20161025 mark by beckxie---E
      #161024-00023#4 20161025 add by beckxie---S
      FOREACH b_fill_cs3 INTO g_inbn3_d[l_ac].inbp005,g_inbn3_d[l_ac].inbp005_1_desc,g_inbn3_d[l_ac].inbp005_1_desc_1,  g_inbn3_d[l_ac].inbp006,g_inbn3_d[l_ac].inbp006_desc,
                              g_inbn3_d[l_ac].inbp007,  g_inbn3_d[l_ac].inbp007_desc,           g_inbn3_d[l_ac].l_sum,g_inbn3_d[l_ac].l_count_1
      #161024-00023#4 20161025 add by beckxie---E
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            #LET g_errparam.popup  = TRUE   #161024-00023#12 20161030 mark by beckxie
            LET g_errparam.popup  = FALSE   #161024-00023#12 20161030 add by beckxie
            CALL cl_err()
            EXIT FOREACH
         END IF
         
         #add-point:b_fill段資料填充 name="b_fill.fill"
         #庫存量
         LET g_inbn3_d[l_ac].l_count_1 = 0
         LET l_inag007 = ''
         LET l_inag009 = 0
         LET l_success = ''
         LET l_qty = 0
         #FOREACH sel_inag_cs USING g_inbn3_d[l_ac].pmcz004,g_inbn3_d[l_ac].pmcz005   #161024-00023#4 20161025 mark by beckxie
         FOREACH sel_inag_cs USING g_inbn3_d[l_ac].inbp005,g_inbn3_d[l_ac].inbp006    #161024-00023#4 20161025 add by beckxie
                              INTO l_inag007,l_inag009
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "FOREACH:sel_inag_cs "
               LET g_errparam.code   = SQLCA.sqlcode 
               #LET g_errparam.popup  = TRUE   #161024-00023#12 20161030 mark by beckxie
               LET g_errparam.popup  = FALSE   #161024-00023#12 20161030 add by beckxie
               CALL cl_err()
               EXIT FOREACH
            END IF
            #IF l_inag007 = g_inbn3_d[l_ac].pmcz006 THEN   #161024-00023#4 20161025 mark by beckxie
            IF l_inag007 = g_inbn3_d[l_ac].inbp007 THEN    #161024-00023#4 20161025 add by beckxie
               #若單位相等,不進行換算
               LET g_inbn3_d[l_ac].l_count_1 = g_inbn3_d[l_ac].l_count_1 + l_inag009
            ELSE
               #單位不同,進行換算
               #161024-00023#4 20161025 modify by beckxie---S
               #CALL s_aooi250_convert_qty(g_inbn3_d[l_ac].pmcz004,l_inag007,g_inbn3_d[l_ac].pmcz006,l_inag009)
               CALL s_aooi250_convert_qty(g_inbn3_d[l_ac].inbp005,l_inag007,g_inbn3_d[l_ac].inbp007,l_inag009)
               #161024-00023#4 20161025 modify by beckxie---E
                    RETURNING l_success,l_qty
               IF l_success THEN 
                  LET g_inbn3_d[l_ac].l_count_1 = g_inbn3_d[l_ac].l_count_1 + l_qty
               END IF
            END IF
            LET l_inag007 = ''
            LET l_inag009 = 0
            LET l_success = ''
            LET l_qty = 0
         END FOREACH
         #end add-point
      
         IF l_ac > g_max_rec THEN
            IF g_error_show = 1 THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = l_ac
               LET g_errparam.code   = 9035 
               #LET g_errparam.popup  = TRUE   #161024-00023#12 20161030 mark by beckxie
               LET g_errparam.popup  = FALSE   #161024-00023#12 20161030 add by beckxie
               CALL cl_err()
            END IF
            EXIT FOREACH
         END IF
         
         LET l_ac = l_ac + 1
      END FOREACH
      LET g_error_show = 0
   
   END IF
   
   #s_detail4
   #單據明細
   IF aint701_fill_chk(1) THEN
      #切換上下筆時不重組SQL
      IF g_action_choice <> 'fetch' OR cl_null(g_action_choice) THEN
         #161024-00023#4 20161025 mark by beckxie---S      
         #LET g_sql = "SELECT pmcz023,pmcz001,pmcz002,pmcz003,pmcz004, ",
         #            "       imaal003,imaal004,pmcz005, ",
         #            "       (SELECT inaml004 ",
         #            "          FROM inaml_t ",
         #            "         WHERE inamlent = pmczent ",
         #            "           AND inaml001 = pmcz004 ",
         #            "           AND inaml002 = pmcz005 ",
         #            "           AND inaml003 = '",g_dlang,"') pmcz005_desc, ",
         #            "       pmcz006,",
         #            "       (SELECT oocal003 ",
         #            "          FROM oocal_t ",
         #            "         WHERE oocalent = pmczent ",
         #            "           AND oocal001 = pmcz006 ",
         #            "           AND oocal002 = '",g_dlang,"') pmcz006_desc, ",
         #            "       COALESCE(pmcz051,0), ",
         #            "       COALESCE(pmcz064,0),COALESCE((pmcz051-pmcz064),0),COALESCE((imaa157*pmcz064),0) l_money, ",
         #            "       indjseq ",
         #            "  FROM inbm_t ,indj_t ,pmcz_t ",
         #            "       LEFT JOIN imaa_t ON imaaent = pmczent AND imaa001 = pmcz004 ",
         #            "       LEFT JOIN imaal_t ON imaalent = pmczent AND imaal001 = pmcz004 AND imaal002 = '",g_dlang,"' ",
         #            " WHERE indjent = inbment and indjdocno = inbm004 and inbm003 ='1' ",
         #            "   AND pmczent = indjent AND pmcz001 = indj001 AND pmcz002 = indj002 AND pmcz063= inbm008 AND pmcz062 = inbm001 ",
         #            "   AND pmcz001 = COALESCE(inbm002,pmcz001) ",
         #            "   AND inbment=? AND inbmdocno=?"
         #161024-00023#4 20161025 mark by beckxie---E
         #161024-00023#4 20161025 add by beckxie---S
         #LET g_sql = " SELECT inbp001,inbp002,inbp003,inbp010,inbp011, ",   #161220-00037#3 20161222 mark by beckxie
         LET g_sql = " SELECT inbpseq, ",                                    #161220-00037#3 20161222 add by beckxie
                     "        inbp001,inbp002,inbp003,inbp010,inbp011, ",    #161220-00037#3 20161222 add by beckxie
                     "        inbp012,inbp004,inbp005,imaal003,imaal004, ",
                     "        inbp006,",
                     "        (SELECT inaml004 ",
                     "           FROM inaml_t ",
                     "          WHERE inamlent = inbpent ",
                     "            AND inaml001 = inbp005 ",
                     "            AND inaml002 = inbp006 ",
                     "            AND inaml003 = '",g_dlang,"') inbp006_desc, ",
                     "        inbp007,",
                     "        (SELECT oocal003 ",
                     "           FROM oocal_t ",
                     "          WHERE oocalent = inbpent ",
                     "            AND oocal001 = inbp007 ",
                     "            AND oocal002 = '",g_dlang,"') inbp007_desc, ",
                     #161213-00022#2 20161215 mark by beckxie---S
                     ##161208-00023#3 20161208 add by beckxie---S
                     ##增加庫位儲位帶值
                     #"        indj012,(SELECT inayl003 FROM inayl_t ",
                     #"                  WHERE inaylent = ",g_enterprise,
                     #"                    AND inayl001 = indj012 ",
                     #"                    AND inayl002 = '",g_dlang,"') indj012_desc, ",
                     #"        indj013,(SELECT inab003 FROM inab_t ",
                     #"                  WHERE inabent = ",g_enterprise,
                     #"                    AND inabsite = indjsite ",
                     #"                    AND inab001 = indj012 ",
                     #"                    AND inab002 = indj013) indj013_desc, ",
                     #"        indj015,(SELECT inayl003 FROM inayl_t ",
                     #"                  WHERE inaylent = ",g_enterprise,
                     #"                    AND inayl001 = indj015 ",
                     #"                    AND inayl002 = '",g_dlang,"') indj015_desc,",
                     #"        indj016,(SELECT inab003 FROM inab_t ",
                     #"                  WHERE inabent = ",g_enterprise,
                     #"                    AND inabsite = indjsite ",
                     #"                    AND inab001 = indj016 ",
                     #"                    AND inab002 = indj013) indj016_desc, ",
                     ##161208-00023#3 20161208 add by beckxie---E
                     #161213-00022#2 20161215 mark by beckxie---E
                     #161213-00022#2 20161215 add by beckxie---S
                     #增加庫位儲位帶值
                     #0.当来源为4.配送单的部分的对应aint705中需求汇总页签的库位、储位
                     #1.当来源为5.委外收货单or8.一般采购收货单，显示收货库位、储位，对应显示来源apmt521 or apmt520里的库位、储位，
                     #2.当来源为6.门店仓退单，显示收货库位和发货库位、储位，对应显示来源aint513上的库位、储位，
                     #3.当来源为7.分销销退单，显示收货库位、储位，对应显示来源adbt600上的库位、储位
                     #發貨庫位
                     "        CASE WHEN inbp001 = '4' THEN indj012 ",
                     "             WHEN inbp001 = '6' THEN indd022 ",
                     "        END indj012, ",
                     #發貨庫位說明
                     "        (SELECT inayl003 FROM inayl_t ",
                     "          WHERE inaylent = ",g_enterprise,
                     "            AND inayl001 = (CASE WHEN inbp001 = '4' THEN indj012 ",
                     "                                 WHEN inbp001 = '6' THEN indd022 ",
                     "                            END )", 
                     "            AND inayl002 = '",g_dlang,"') indj012_desc, ",
                     #發貨儲位
                     "        CASE WHEN inbp001 = '4' THEN indj013 ",
                     "             WHEN inbp001 = '6' THEN indd023 ",
                     "        END indj013, ",
                     #發貨儲位說明
                     "        CASE WHEN inbp001 = '4' THEN ",
                     "                (SELECT inab003 FROM inab_t ",
                     "                  WHERE inabent = ",g_enterprise,
                     "                    AND inabsite = indjsite ",
                     "                    AND inab001 = indj012 ",
                     "                    AND inab002 = indj013) ",
                     "             WHEN inbp001 = '6' THEN ",
                     "                (SELECT inab003 FROM inab_t ",
                     "                  WHERE inabent = ",g_enterprise,
                     "                    AND inabsite = inddsite ",
                     "                    AND inab001 = indd022 ",
                     "                    AND inab002 = indd023) ",
                     "        END indj013_desc, ",
                     #收貨庫位
                     "        CASE WHEN inbp001 = '4' THEN indj015 ",
                     "             WHEN inbp001 = '5' OR inbp001 = '8' THEN pmdt016 ",
                     "             WHEN inbp001 = '6' THEN indd032 ",
                     "             WHEN inbp001 = '7' THEN xmdl014 ",
                     "        END indj015, ",
                     #收貨庫位說明
                     "        (SELECT inayl003 FROM inayl_t ",
                     "          WHERE inaylent = ",g_enterprise,
                     "            AND inayl001 = (CASE WHEN inbp001 = '4' THEN indj015 ",
                     "                                 WHEN inbp001 = '5' OR inbp001 = '8' THEN pmdt016 ",
                     "                                 WHEN inbp001 = '6' THEN indd032 ",
                     "                                 WHEN inbp001 = '7' THEN xmdl014 ",
                     "                            END )",
                     "            AND inayl002 = '",g_dlang,"') indj015_desc,",
                     #收貨儲位
                     "        CASE WHEN inbp001 = '4' THEN indj016 ",
                     "             WHEN inbp001 = '5' OR inbp001 = '8' THEN pmdt017 ",
                     "             WHEN inbp001 = '6' THEN indd033 ",
                     "             WHEN inbp001 = '7' THEN xmdl015 ",
                     "        END indj016, ",
                     #收貨儲位說明
                     "        CASE WHEN inbp001 = '4' THEN ",
                     "                (SELECT inab003 FROM inab_t ",
                     "                  WHERE inabent = ",g_enterprise,
                     "                    AND inabsite = indjsite ",
                     "                    AND inab001 = indj015 ",
                     "                    AND inab002 = indj016) ",
                     "             WHEN inbp001 = '5' OR inbp001 = '8' THEN ",
                     "                (SELECT inab003 FROM inab_t ",
                     "                  WHERE inabent = ",g_enterprise,
                     "                    AND inabsite = pmdtsite ",
                     "                    AND inab001 = pmdt016 ",
                     "                    AND inab002 = pmdt017) ",
                     "             WHEN inbp001 = '6' THEN ",
                     "                (SELECT inab003 FROM inab_t ",
                     "                  WHERE inabent = ",g_enterprise,
                     "                    AND inabsite = inddsite",
                     "                    AND inab001 = indd032 ",
                     "                    AND inab002 = indd033) ",
                     "             WHEN inbp001 = '7' THEN ",
                     "                (SELECT inab003 FROM inab_t ",
                     "                  WHERE inabent = ",g_enterprise,
                     "                    AND inabsite = xmdlsite",
                     "                    AND inab001 = xmdl014 ",
                     "                    AND inab002 = xmdl015) ",
                     "        END indj016_desc, ",
                     #161213-00022#2 20161215 add by beckxie---E
                     "        inbp008,inbp009,",
                     "        (COALESCE(inbp008,0)-COALESCE(inbp009,0)) l_count_2, ", #差異量(應裝-已裝)
                     #"        (COALESCE(imaa157,0)*COALESCE(inbp009,0)) l_count_3  ", #裝箱金額
                     #161208-00023#3 20161208 add by beckxie---S
                     #價格
                     "        (SELECT imaa116 FROM imaa_t WHERE imaaent = ",g_enterprise,
                     "                                      AND imaa001 = inbp005 ) imaa116,",
                     #161208-00023#3 20161208 add by beckxie---E
                     "        (COALESCE(imaa116,0)*COALESCE(inbp009,0)) l_count_3  ", #裝箱金額
                     "   FROM inbp_t ",
                     "        LEFT JOIN imaa_t ON imaaent = inbpent AND imaa001 = inbp005 ",
                     "        LEFT JOIN imaal_t ON imaalent = inbpent AND imaal001 = inbp005 AND imaal002 = '",g_dlang,"' ",
                      #161208-00023#3 20161208 add by beckxie---S
                     #增加庫位儲位帶值
                     "        LEFT JOIN indj_t ON indjent = inbpent AND indjdocno = inbp002 AND indjseq = inbp003 AND inbp001 = '4' ",
                      #161208-00023#3 20161208 add by beckxie---E
                      #161213-00022#2 20161215 add by beckxie---S
                      "       LEFT JOIN pmdt_t ON pmdtent = inbpent AND pmdtdocno = inbp002 AND pmdtseq = inbp003 AND inbp001 IN ('5','8') ",
                      "       LEFT JOIN indd_t ON inddent = inbpent AND indddocno = inbp002 AND inddseq = inbp003 AND inbp001 = '6' ",
                      "       LEFT JOIN xmdl_t ON xmdlent = inbpent AND xmdldocno = inbp002 AND xmdlseq = inbp003 AND inbp001 = '7' ",
                      #161213-00022#2 20161215 add by beckxie---E
                     #"  WHERE inbpent = ? AND inbpdocno = ? "   #161024-00023#21 20161121 mark by beckxie
                     "  WHERE inbpent = ? AND inbpdocno = ? AND ",g_wc4_table1   #161024-00023#21 20161121 add by beckxie
         #161024-00023#4 20161025 add by beckxie---E
         DISPLAY "###########g_sql : ", g_sql
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         #add-point:b_fill段sql_before name="b_fill.body.fill_sql"

         #end add-point
         #IF NOT cl_null(g_wc4_table1) THEN
         #   LET g_sql = g_sql CLIPPED, " AND ", g_wc4_table1 CLIPPED
         #END IF
         
         #子單身的WC
 
         
         #LET g_sql = g_sql, " ORDER BY pmcz023,pmcz001,pmcz002,pmcz003,pmcz004 "   #161024-00023#4 20161025 mark by beckxie
         LET g_sql = g_sql, " ORDER BY inbp001,inbp002,inbp003,inbp010,inbp011,inbp012,inbp004,inbp005,inbp006,inbp007"   #161024-00023#4 20161025 add by beckxie
         
         #add-point:單身填充控制 name="b_fill.sql"

         #end add-point
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aint701_pb4 FROM g_sql
         DECLARE b_fill_cs4 CURSOR FOR aint701_pb4
      END IF
      
      LET g_cnt = l_ac
      LET l_ac = 1
      
      OPEN b_fill_cs4 USING g_enterprise,g_inbm_m.inbmdocno
      #161024-00023#4 20161025 mark by beckxie---S                                         
      #FOREACH b_fill_cs4 INTO g_inbn4_d[l_ac].pmcz023,g_inbn4_d[l_ac].pmcz001,g_inbn4_d[l_ac].pmcz002,g_inbn4_d[l_ac].pmcz003,g_inbn4_d[l_ac].pmcz004_1,
      #                        g_inbn4_d[l_ac].pmcz004_1_desc,g_inbn4_d[l_ac].pmcz004_1_desc_1,g_inbn4_d[l_ac].pmcz005_1,g_inbn4_d[l_ac].pmcz005_1_desc,g_inbn4_d[l_ac].pmcz006_1,
      #                        g_inbn4_d[l_ac].pmcz006_1_desc,g_inbn4_d[l_ac].pmcz051,g_inbn4_d[l_ac].pmcz064,g_inbn4_d[l_ac].l_count_2,g_inbn4_d[l_ac].l_count_3,
      #                        g_inbn4_d[l_ac].indjseq
      #161024-00023#4 20161025 mark by beckxie---E
      #161024-00023#4 20161025 add by beckxie---S                                         
      #FOREACH b_fill_cs4 INTO g_inbn4_d[l_ac].inbp001, g_inbn4_d[l_ac].inbp002    , g_inbn4_d[l_ac].inbp003   ,     g_inbn4_d[l_ac].inbp010,       g_inbn4_d[l_ac].inbp011,   #161220-00037#3 20161222 mark by beckxie
      FOREACH b_fill_cs4 INTO g_inbn4_d[l_ac].inbpseq,                                                                                                                        #161220-00037#3 20161222 add by beckxie
                              g_inbn4_d[l_ac].inbp001, g_inbn4_d[l_ac].inbp002    , g_inbn4_d[l_ac].inbp003   ,     g_inbn4_d[l_ac].inbp010,       g_inbn4_d[l_ac].inbp011,   #161220-00037#3 20161222 add by beckxie
                              g_inbn4_d[l_ac].inbp012, g_inbn4_d[l_ac].inbp004    , g_inbn4_d[l_ac].inbp005   ,g_inbn4_d[l_ac].inbp005_desc,g_inbn4_d[l_ac].inbp005_desc_1,
                              #161208-00023#3 20161208 mark by beckxie---S
                              #g_inbn4_d[l_ac].inbp006,g_inbn4_d[l_ac].inbp006_desc, g_inbn4_d[l_ac].inbp007,g_inbn4_d[l_ac].inbp007_desc,       g_inbn4_d[l_ac].inbp008,   
                              #g_inbn4_d[l_ac].inbp009,   g_inbn4_d[l_ac].l_count_2,g_inbn4_d[l_ac].l_count_3
                              #161208-00023#3 20161208 mark by beckxie---E
                              #161208-00023#3 20161208 add by beckxie---S
                              g_inbn4_d[l_ac].inbp006, g_inbn4_d[l_ac].inbp006_desc, g_inbn4_d[l_ac].inbp007  ,g_inbn4_d[l_ac].inbp007_desc,
                              g_inbn4_d[l_ac].indj012, g_inbn4_d[l_ac].indj012_desc, g_inbn4_d[l_ac].indj013  ,g_inbn4_d[l_ac].indj013_desc,
                              g_inbn4_d[l_ac].indj015, g_inbn4_d[l_ac].indj015_desc, g_inbn4_d[l_ac].indj016  ,g_inbn4_d[l_ac].indj016_desc,
                              g_inbn4_d[l_ac].inbp008, g_inbn4_d[l_ac].inbp009     , g_inbn4_d[l_ac].l_count_2,   g_inbn4_d[l_ac].l_imaa116,
                              g_inbn4_d[l_ac].l_count_3
                              #161208-00023#3 20161208 add by beckxie---E
                              
                              
      #161024-00023#4 20161025 add by beckxie---E
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = TRUE 
            CALL cl_err()
            EXIT FOREACH
         END IF
        
         #add-point:b_fill段資料填充 name="b_fill.fill"
         
         
         #end add-point
      
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
      LET g_error_show = 0
      #161213-00022#2 20161216 add by beckxie---S
      #if 应装量为0 and 单身库位为空，则库位显示同单身第一笔同商品的库位
      FOR l_ac = 1 TO g_inbn4_d.getlength() 
       
         IF g_inbn4_d[l_ac].inbp008 = 0 THEN
         
            #若發貨庫位為空
            IF cl_null(g_inbn4_d[l_ac].indj012) THEN
               #1.取同單身第一筆同商品的庫位
               FOR l_i = 1 TO g_inbn4_d.getlength() 
                  IF g_inbn4_d[l_ac].inbp005 = g_inbn4_d[l_i].inbp005 AND NOT cl_null(g_inbn4_d[l_i].indj012) THEN
                     LET g_inbn4_d[l_ac].indj012 = g_inbn4_d[l_i].indj012
                     LET g_inbn4_d[l_ac].indj012_desc = g_inbn4_d[l_i].indj012_desc
                     EXIT FOR
                  END IF
               END FOR
               #2.若取不到,就取第一筆庫位賦值
               IF cl_null(g_inbn4_d[l_ac].indj012) THEN
                  FOR l_i = 1 TO g_inbn4_d.getlength() 
                     IF NOT cl_null(g_inbn4_d[l_i].indj012) THEN
                        LET g_inbn4_d[l_ac].indj012 = g_inbn4_d[l_i].indj012
                        LET g_inbn4_d[l_ac].indj012_desc = g_inbn4_d[l_i].indj012_desc
                        EXIT FOR
                     END IF
                  END FOR
               END IF
            END IF
            
            #若發貨儲位為空
            IF cl_null(g_inbn4_d[l_ac].indj013) THEN 
               #1.取同單身第一筆同商品的庫位
               FOR l_i = 1 TO g_inbn4_d.getlength() 
                  IF g_inbn4_d[l_ac].inbp005 = g_inbn4_d[l_i].inbp005 AND NOT cl_null(g_inbn4_d[l_i].indj013) THEN
                     LET g_inbn4_d[l_ac].indj013 = g_inbn4_d[l_i].indj013
                     LET g_inbn4_d[l_ac].indj013_desc = g_inbn4_d[l_i].indj013_desc
                     EXIT FOR
                  END IF
               END FOR
               #2.若取不到,就取第一筆庫位賦值
               IF cl_null(g_inbn4_d[l_ac].indj013) THEN
                  FOR l_i = 1 TO g_inbn4_d.getlength() 
                     IF NOT cl_null(g_inbn4_d[l_i].indj013) THEN
                        LET g_inbn4_d[l_ac].indj013 = g_inbn4_d[l_i].indj013
                        LET g_inbn4_d[l_ac].indj013_desc = g_inbn4_d[l_i].indj013_desc
                        EXIT FOR
                     END IF
                  END FOR
               END IF
            END IF
            
            #若收貨庫位為空
            IF cl_null(g_inbn4_d[l_ac].indj015) THEN
            
               #1.取同單身第一筆同商品的庫位
               FOR l_i = 1 TO g_inbn4_d.getlength() 
                  IF g_inbn4_d[l_ac].inbp005 = g_inbn4_d[l_i].inbp005 AND NOT cl_null(g_inbn4_d[l_i].indj015) THEN
                     LET g_inbn4_d[l_ac].indj015 = g_inbn4_d[l_i].indj015
                     LET g_inbn4_d[l_ac].indj015_desc = g_inbn4_d[l_i].indj015_desc
                     EXIT FOR
                  END IF
               END FOR
               
               #2.若取不到,就取第一筆庫位賦值
               IF cl_null(g_inbn4_d[l_ac].indj015) THEN
                  FOR l_i = 1 TO g_inbn4_d.getlength() 
                     IF NOT cl_null(g_inbn4_d[l_i].indj015) THEN
                        LET g_inbn4_d[l_ac].indj015 = g_inbn4_d[l_i].indj015
                        LET g_inbn4_d[l_ac].indj015_desc = g_inbn4_d[l_i].indj015_desc
                        EXIT FOR
                     END IF
                  END FOR
               END IF
            END IF 
            
            #若收貨儲位為空
            IF cl_null(g_inbn4_d[l_ac].indj016) THEN 
               #1.取同單身第一筆同商品的庫位
               FOR l_i = 1 TO g_inbn4_d.getlength() 
                  IF g_inbn4_d[l_ac].inbp005 = g_inbn4_d[l_i].inbp005 AND NOT cl_null(g_inbn4_d[l_i].indj016) THEN
                     LET g_inbn4_d[l_ac].indj016 = g_inbn4_d[l_i].indj016
                     LET g_inbn4_d[l_ac].indj016_desc = g_inbn4_d[l_i].indj016_desc
                     EXIT FOR
                  END IF
               END FOR
               #2.若取不到,就取第一筆庫位賦值
               IF cl_null(g_inbn4_d[l_ac].indj016) THEN
                  FOR l_i = 1 TO g_inbn4_d.getlength() 
                     IF NOT cl_null(g_inbn4_d[l_i].indj013) THEN
                        LET g_inbn4_d[l_ac].indj016 = g_inbn4_d[l_i].indj016
                        LET g_inbn4_d[l_ac].indj016_desc = g_inbn4_d[l_i].indj016_desc
                        EXIT FOR
                     END IF
                  END FOR
               END IF
            END IF
            
         END IF
         
      END FOR
      #161213-00022#2 20161216 add by beckxie---E
   END IF
   CALL g_inbn3_d.deleteElement(g_inbn3_d.getLength())
   CALL g_inbn4_d.deleteElement(g_inbn4_d.getLength())
   
   #161024-00023#4 20161026 add by beckxie---S
   IF g_temp_init_flag THEN 
      CALL aint701_temp_init() RETURNING l_success  
   END IF
   #161024-00023#4 20161026 add by beckxie---E
   #end add-point
   
   CALL g_inbn_d.deleteElement(g_inbn_d.getLength())
 
   
 
   LET l_ac = g_cnt
   LET g_cnt = 0  
   
   FREE aint701_pb
 
   
   LET li_idx = l_ac
   
   #遮罩相關處理
   FOR l_ac = 1 TO g_inbn_d.getLength()
      LET g_inbn_d_mask_o[l_ac].* =  g_inbn_d[l_ac].*
      CALL aint701_inbn_t_mask()
      LET g_inbn_d_mask_n[l_ac].* =  g_inbn_d[l_ac].*
   END FOR
   
   LET g_inbn2_d_mask_o.* =  g_inbn2_d.*
   FOR l_ac = 1 TO g_inbn2_d.getLength()
      LET g_inbn2_d_mask_o[l_ac].* =  g_inbn2_d[l_ac].*
      CALL aint701_inbo_t_mask()
      LET g_inbn2_d_mask_n[l_ac].* =  g_inbn2_d[l_ac].*
   END FOR
 
   
   LET l_ac = li_idx
   
   CALL cl_ap_performance_next_end()
 
END FUNCTION
 
{</section>}
 
{<section id="aint701.delete_b" >}
#+ 刪除單身後其他table連動
PRIVATE FUNCTION aint701_delete_b(ps_table,ps_keys_bak,ps_page)
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
      DELETE FROM inbn_t
       WHERE inbnent = g_enterprise AND
         inbndocno = ps_keys_bak[1] AND inbn001 = ps_keys_bak[2]
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
         CALL g_inbn_d.deleteElement(li_idx) 
      END IF 
 
   END IF
   
 
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table2
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:delete_b段刪除前 name="delete_b.b_delete2"
 
      #end add-point    
      DELETE FROM inbo_t
       WHERE inboent = g_enterprise AND
             inbodocno = ps_keys_bak[1] AND inbo001 = ps_keys_bak[2] AND inbo002 = ps_keys_bak[3]
      #add-point:delete_b段刪除中 name="delete_b.m_delete2"
      #161024-00023#4 20161026 add by beckxie---S
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "inbo_t:",SQLERRMESSAGE 
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
      DELETE FROM aint701_inbo_temp 
         WHERE inboent = g_enterprise AND
             inbodocno = ps_keys_bak[1] AND inbo001 = ps_keys_bak[2] #AND inbo002 = ps_keys_bak[3]
      #161024-00023#4 20161026 add by beckxie---E
      #end add-point    
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "inbo_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
         RETURN FALSE
      END IF
    
      LET li_idx = g_detail_idx2
      IF ps_page <> "'2'" THEN 
         CALL g_inbn2_d.deleteElement(li_idx) 
      END IF 
 
      #add-point:delete_b段刪除後 name="delete_b.a_delete2"
      
      #end add-point    
   END IF
 
 
   
   #add-point:delete_b段other name="delete_b.other"
   #CALL aint701_b_fill()   #161024-00023#11 20161030 add by beckxie
   #CALL aint701_b_fill2('2') #161024-00023#11 20161030 add by beckxie
   #end add-point  
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aint701.insert_b" >}
#+ 新增單身後其他table連動
PRIVATE FUNCTION aint701_insert_b(ps_table,ps_keys,ps_page)
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
      INSERT INTO inbn_t
                  (inbnent,
                   inbndocno,
                   inbn001
                   ,inbnsite,inbnunit,inbn002) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2]
                   ,g_inbn_d[g_detail_idx].inbnsite,g_inbn_d[g_detail_idx].inbnunit,g_inbn_d[g_detail_idx].inbn002) 
 
      #add-point:insert_b段資料新增中 name="insert_b.m_insert"
      
      #end add-point 
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "inbn_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx
      IF ps_page <> "'1'" THEN 
         CALL g_inbn_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert"
      
      #end add-point 
   END IF
   
 
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      #add-point:insert_b段資料新增前 name="insert_b.before_insert2"
      
      #end add-point 
      INSERT INTO inbo_t
                  (inboent,
                   inbodocno,inbo001,
                   inbo002
                   ,inbosite,inbounit,inbo010,inbo006,inbo007,inbo008,inbo009) 
            VALUES(g_enterprise,
                   ps_keys[1],ps_keys[2],ps_keys[3]
                   ,g_inbn2_d[g_detail_idx2].inbosite,g_inbn2_d[g_detail_idx2].inbounit,g_inbn2_d[g_detail_idx2].inbo010, 
                       g_inbn2_d[g_detail_idx2].inbo006,g_inbn2_d[g_detail_idx2].inbo007,g_inbn2_d[g_detail_idx2].inbo008, 
                       g_inbn2_d[g_detail_idx2].inbo009)
      #add-point:insert_b段資料新增中 name="insert_b.m_insert2"
      
      #end add-point
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "inbo_t:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = FALSE 
         CALL cl_err()
      END IF
      
      LET li_idx = g_detail_idx2
      IF ps_page <> "'2'" THEN 
         CALL g_inbn2_d.insertElement(li_idx) 
      END IF 
 
      #add-point:insert_b段資料新增後 name="insert_b.after_insert2"
      
      #end add-point
   END IF
 
 
   
   #add-point:insert_b段other name="insert_b.other"
   
   #end add-point     
   
END FUNCTION
 
{</section>}
 
{<section id="aint701.update_b" >}
#+ 修改單身後其他table連動
PRIVATE FUNCTION aint701_update_b(ps_table,ps_keys,ps_keys_bak,ps_page)
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
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "inbn_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update"
      
      #end add-point 
      
      #將遮罩欄位還原
      CALL aint701_inbn_t_mask_restore('restore_mask_o')
               
      UPDATE inbn_t 
         SET (inbndocno,
              inbn001
              ,inbnsite,inbnunit,inbn002) 
              = 
             (ps_keys[1],ps_keys[2]
              ,g_inbn_d[g_detail_idx].inbnsite,g_inbn_d[g_detail_idx].inbnunit,g_inbn_d[g_detail_idx].inbn002)  
 
         WHERE inbnent = g_enterprise AND inbndocno = ps_keys_bak[1] AND inbn001 = ps_keys_bak[2]
      #add-point:update_b段修改中 name="update_b.m_update"
      
      #end add-point   
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "inbn_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "inbn_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aint701_inbn_t_mask_restore('restore_mask_n')
               
      #add-point:update_b段修改後 name="update_b.after_update"
      
      #end add-point  
   END IF
   
   #子表處理
   IF ls_group.getIndexOf(ps_page,1) > 0 THEN
      
   END IF
   
   
 
   
   LET ls_group = "'2',"
   #判斷是否是同一群組的table
   IF ls_group.getIndexOf(ps_page,1) > 0 AND ps_table <> "inbo_t" THEN
      #add-point:update_b段修改前 name="update_b.before_update2"
      
      #end add-point
      
      #將遮罩欄位還原
      CALL aint701_inbo_t_mask_restore('restore_mask_o')
               
      UPDATE inbo_t 
         SET (inbodocno,inbo001,
              inbo002
              ,inbosite,inbounit,inbo010,inbo006,inbo007,inbo008,inbo009) 
              = 
             (ps_keys[1],ps_keys[2],ps_keys[3]
              ,g_inbn2_d[g_detail_idx2].inbosite,g_inbn2_d[g_detail_idx2].inbounit,g_inbn2_d[g_detail_idx2].inbo010, 
                  g_inbn2_d[g_detail_idx2].inbo006,g_inbn2_d[g_detail_idx2].inbo007,g_inbn2_d[g_detail_idx2].inbo008, 
                  g_inbn2_d[g_detail_idx2].inbo009) 
         WHERE inboent = g_enterprise AND inbodocno = ps_keys_bak[1] AND inbo001 = ps_keys_bak[2] AND inbo002 = ps_keys_bak[3]
      #add-point:update_b段修改中 name="update_b.m_update2"
      
      #end add-point  
      CASE
         WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "inbo_t" 
            LET g_errparam.code = "std-00009" 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "inbo_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
 
      END CASE
      
      #將遮罩欄位進行遮蔽
      CALL aint701_inbo_t_mask_restore('restore_mask_n')
               
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
 
{<section id="aint701.key_update_b" >}
#+ 上層單身key欄位變動後, 連帶修正下層單身key欄位
PRIVATE FUNCTION aint701_key_update_b(ps_keys_bak,ps_table)
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
   IF ps_table = 'inbn_t' THEN
      #add-point:update_b段修改前 name="key_update_b.before_update2"
      
      #end add-point
      
      UPDATE inbo_t 
         SET (inbodocno,inbo001) 
              = 
             (g_inbm_m.inbmdocno,g_inbn_d[g_detail_idx].inbn001) 
         WHERE inboent = g_enterprise AND
               inbodocno = ps_keys_bak[1] AND inbo001 = ps_keys_bak[2]
 
      #add-point:update_b段修改中 name="key_update_b.m_update2"
      
      #end add-point
              
      CASE
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "inbo_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
            #若有多語言table資料一同更新
            
      END CASE
      
      #add-point:update_b段修改後 name="key_update_b.after_update2"
      #161024-00023#4 20161026 add by beckxie---S
      UPDATE aint701_inbo_temp 
         SET (inbodocno,inbo001) 
              = 
             (g_inbm_m.inbmdocno,g_inbn_d[g_detail_idx].inbn001) 
         WHERE inboent = g_enterprise AND
               inbodocno = ps_keys_bak[1] AND inbo001 = ps_keys_bak[2]
      CASE
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "inbo_t:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            #LET g_errparam.popup  = TRUE   #161024-00023#12 20161030 mark by beckxie
            LET g_errparam.popup  = FALSE   #161024-00023#12 20161030 add by beckxie
            CALL s_transaction_end('N','0')
            CALL cl_err()
            
         OTHERWISE
            #若有多語言table資料一同更新
            
      END CASE
      #161024-00023#4 20161026 add by beckxie---E
      CALL aint701_b_fill()
      CALL aint701_b_fill2('2')
      #end add-point
   END IF
 
 
   
END FUNCTION
 
{</section>}
 
{<section id="aint701.key_delete_b" >}
#+ 上層單身刪除後, 連帶刪除下層單身key欄位
PRIVATE FUNCTION aint701_key_delete_b(ps_keys_bak,ps_table)
   #add-point:delete_b段define(客製用) name="key_delete_b.define_customerization"
   
   #end add-point
   DEFINE ps_keys_bak       DYNAMIC ARRAY OF VARCHAR(500)
   DEFINE ps_table          STRING
   DEFINE l_field_keys      DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak    DYNAMIC ARRAY OF STRING
   DEFINE l_new_key         DYNAMIC ARRAY OF STRING
   DEFINE l_old_key         DYNAMIC ARRAY OF STRING
   #add-point:delete_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="key_delete_b.define"
   DEFINE l_inbo     RECORD
          inbo002    LIKE inbo_t.inbo002,
          inbo003    LIKE inbo_t.inbo003,
          inbo004    LIKE inbo_t.inbo004,
          inbo005    LIKE inbo_t.inbo005,
          inbo006    LIKE inbo_t.inbo006,
          inbo007    LIKE inbo_t.inbo007,
          inbo008    LIKE inbo_t.inbo008,
          inbo009    LIKE inbo_t.inbo009,
          inbo010    LIKE inbo_t.inbo010,
          inbo011    LIKE inbo_t.inbo011
                     END RECORD
   DEFINE l_sql      STRING
   #161024-00023#11 20161030 add by beckxie---S
   DEFINE l_pmczsite LIKE pmcz_t.pmczsite
   DEFINE l_pmcz001  LIKE pmcz_t.pmcz001   
   DEFINE l_pmcz002  LIKE pmcz_t.pmcz002
   DEFINE l_pmcz023  LIKE pmcz_t.pmcz023
   DEFINE l_pmcz064  LIKE pmcz_t.pmcz064
   #161024-00023#11 20161030 add by beckxie---E
   #161213-00004#7 Add By Ken 20161217(S)
   DEFINE l_inbp008  LIKE inbp_t.inbp008
   DEFINE l_inbp009  LIKE inbp_t.inbp009
   #161213-00004#7 Add By Ken 20161217(E)
   #end add-point
   
   #add-point:Function前置處理  name="key_delete_b.pre_function"
   
   #end add-point
   
   #如果是上層單身則進行delete
   IF ps_table = 'inbn_t' THEN
      #add-point:delete_b段修改前 name="key_delete_b.before_delete2"
      #刪除箱號前,需更新已裝箱量(pmcz064)
      LET l_sql = "SELECT inbo002,inbo003,inbo004,inbo005,inbo006,inbo007,inbo008,inbo009,inbo010,inbo011 ",
                  "  FROM inbo_t ",
                  " WHERE inboent = ",g_enterprise,
                  "   AND inbodocno = '",ps_keys_bak[1],"' ",
                  "   AND inbo001 = '",ps_keys_bak[2],"' ",
                  " ORDER BY inbo002 "
                  
      PREPARE sel_inbo_pre FROM l_sql
      DECLARE sel_inbo_cs CURSOR FOR sel_inbo_pre
      
      INITIALIZE l_inbo TO NULL
      
      FOREACH sel_inbo_cs INTO l_inbo.inbo002,l_inbo.inbo003,l_inbo.inbo004,l_inbo.inbo005,l_inbo.inbo006,
                               l_inbo.inbo007,l_inbo.inbo008,l_inbo.inbo009,l_inbo.inbo010,l_inbo.inbo011
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            #LET g_errparam.popup  = TRUE   #161024-00023#12 20161030 mark by beckxie
            LET g_errparam.popup  = FALSE   #161024-00023#12 20161030 add by beckxie
            CALL cl_err()
            EXIT FOREACH
         END IF
         #161024-00023#4 20161026 mark by beckxie---S
         ##將該項次的pmcz064還原
         #UPDATE pmcz_t SET pmcz064 = (pmcz064-l_inbo.inbo009)
         # WHERE pmczent = g_enterprise
         #   AND pmcz001 = l_inbo.inbo004
         #   AND pmcz002 = l_inbo.inbo005
         #   AND pmcz062 = g_inbm_m.inbm001
         #   
         #IF SQLCA.sqlcode THEN
         #   INITIALIZE g_errparam TO NULL 
         #   LET g_errparam.extend = "upd_pmcz064"
         #   LET g_errparam.code   = SQLCA.sqlcode 
         #   LET g_errparam.popup  = TRUE
         #   CALL cl_err()
         #END IF
         #161024-00023#4 20161026 mark by beckxie---E
         #161024-00023#4 20161026 add by beckxie---S
         #將該項次的inbp009還原
         UPDATE inbp_t SET inbp009 = (inbp009-l_inbo.inbo009)
          WHERE inbpent = g_enterprise
            AND inbpdocno = g_inbm_m.inbmdocno
            AND inbpseq = l_inbo.inbo011
            
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "upd_inbp009"
            LET g_errparam.code   = SQLCA.sqlcode 
            #LET g_errparam.popup  = TRUE   #161024-00023#12 20161030 mark by beckxie
            LET g_errparam.popup  = FALSE   #161024-00023#12 20161030 add by beckxie
            CALL cl_err()
         END IF
         

         #161024-00023#4 20161026 add by beckxie---E
         
         #161213-00004#7 Add By Ken 20161217(S)
         #更新已裝箱量後 應裝箱量、已裝箱量如都是0的話 刪應裝明細內容
         SELECT inbp008,inbp009 INTO l_inbp008,l_inbp009
           FROM inbp_t
          WHERE inbpent = g_enterprise
            AND inbpdocno = g_inbm_m.inbmdocno
            AND inbpseq = l_inbo.inbo011
            
         IF l_inbp008 = 0 AND l_inbp009 = 0 THEN
            DELETE FROM inbp_t
             WHERE inbpent = g_enterprise
               AND inbpdocno = g_inbm_m.inbmdocno
               AND inbpseq = l_inbo.inbo011 
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "del inbp_t"
               LET g_errparam.code   = SQLCA.sqlcode                
               LET g_errparam.popup  = FALSE   
               CALL cl_err()
            END IF               
         END IF
         #161213-00004#7 Add By Ken 20161217(E)
           
         #161024-00023#11 20161030 add by beckxie---S
         #更新inbp_t後,仍然需要更新需求匯總pmcz_t 已裝箱量
         #異動完成:更新pmcz064已裝箱量
         SELECT   inbpsite,  inbp009,  inbp010,  inbp011,  inbp012 
           INTO l_pmczsite,l_pmcz064,l_pmcz023,l_pmcz001,l_pmcz002
           FROM inbp_t 
          WHERE inbpent = g_enterprise 
            AND inbpdocno = g_inbm_m.inbmdocno
            AND inbpseq = l_inbo.inbo011
         IF NOT cl_null(l_pmcz023) THEN
            #已装箱量[pmcz064]=已装箱量[pmcz064]-已装箱量[inbp009]
            #UPDATE pmcz_t SET pmcz064 = l_pmcz064                 #161220-00037#3 20161222 mark by beckxie
            UPDATE pmcz_t SET pmcz064 = pmcz064 - l_inbo.inbo009   #161220-00037#3 20161222  add by beckxie
             WHERE pmczent = g_enterprise
#               AND pmczsite = l_pmczsite    #161024-00023#14 by 08172
               AND pmcz001 = l_pmcz001
               AND pmcz002 = l_pmcz002
               AND pmcz023 = l_pmcz023
               
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "UPDATE pmcz_t"
               LET g_errparam.code   = SQLCA.sqlcode 
               #LET g_errparam.popup  = TRUE   #161024-00023#12 20161030 mark by beckxie
               LET g_errparam.popup  = FALSE   #161024-00023#12 20161030 add by beckxie
               CALL cl_err()
            END IF
         END IF
         LET l_pmczsite = '' 
         LET l_pmcz064 = ''
         LET l_pmcz023 = ''
         LET l_pmcz001 = ''
         LET l_pmcz002 = ''
         #161024-00023#11 20161030 add by beckxie---E
         INITIALIZE l_inbo TO NULL
         
      END FOREACH
      #end add-point
      
      DELETE FROM inbo_t 
            WHERE inboent = g_enterprise AND
                  inbodocno = ps_keys_bak[1] AND inbo001 = ps_keys_bak[2]
 
      #add-point:delete_b段修改中 name="key_delete_b.m_delete2"
      
      #end add-point
              
      CASE
         WHEN SQLCA.SQLCODE #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "inbo_t:",SQLERRMESSAGE 
            LET g_errparam.code = SQLCA.SQLCODE 
            LET g_errparam.popup = TRUE 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            RETURN FALSE
         OTHERWISE
      END CASE
 
       
 
      #add-point:delete_b段修改後 name="key_delete_b.after_delete2"
      #161024-00023#4 20161026 add by beckxie---S
      DELETE FROM aint701_inbo_temp
            WHERE inboent = g_enterprise AND
                  inbodocno = ps_keys_bak[1] AND inbo001 = ps_keys_bak[2]
      CASE
         WHEN SQLCA.sqlcode #其他錯誤
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "inbo_t:",SQLERRMESSAGE 
            LET g_errparam.code   = SQLCA.sqlcode 
            #LET g_errparam.popup  = TRUE   #161024-00023#12 20161030 mark by beckxie
            LET g_errparam.popup  = FALSE   #161024-00023#12 20161030 add by beckxie 
            CALL s_transaction_end('N','0')
            CALL cl_err()
            RETURN FALSE
         OTHERWISE
      END CASE
      #161024-00023#4 20161026 add by beckxie---E
      #end add-point
   END IF
 
 
   
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aint701.lock_b" >}
#+ 連動lock其他單身table資料
PRIVATE FUNCTION aint701_lock_b(ps_table,ps_page)
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
   #CALL aint701_b_fill()
   
   #鎖定整組table
   #LET ls_group = "'1',"
   #僅鎖定自身table
   LET ls_group = "inbn_t"
   
   IF ls_group.getIndexOf(ps_table,1) THEN
      OPEN aint701_bcl USING g_enterprise,
                                       g_inbm_m.inbmdocno,g_inbn_d[g_detail_idx].inbn001     
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aint701_bcl:",SQLERRMESSAGE 
         LET g_errparam.code = SQLCA.SQLCODE 
         LET g_errparam.popup = TRUE 
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
                                    
 
   
   #鎖定整組table
   #LET ls_group = "'2',"
   #僅鎖定自身table
   LET ls_group = "inbo_t"
   IF ls_group.getIndexOf(ps_table,1) THEN
   
      OPEN aint701_bcl2 USING g_enterprise,
                                             g_inbm_m.inbmdocno,g_inbn_d[g_detail_idx].inbn001,
                                             g_inbn2_d[g_detail_idx2].inbo002
      IF SQLCA.SQLCODE THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "aint701_bcl2:",SQLERRMESSAGE 
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
 
{<section id="aint701.unlock_b" >}
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION aint701_unlock_b(ps_table,ps_page)
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
      CLOSE aint701_bcl
   END IF
   
 
   
   LET ls_group = "'2',"
   
   IF ls_group.getIndexOf(ps_page,1) THEN
      CLOSE aint701_bcl2
   END IF
 
 
 
   #add-point:unlock_b段other name="unlock_b.other"
   
   #end add-point  
 
END FUNCTION
 
{</section>}
 
{<section id="aint701.set_entry" >}
#+ 單頭欄位開啟設定
PRIVATE FUNCTION aint701_set_entry(p_cmd)
   #add-point:set_entry段define(客製用) name="set_entry.define_customerization"
   
   #end add-point       
   DEFINE p_cmd   LIKE type_t.chr1  
   #add-point:set_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_entry.define"
   
   #end add-point       
   
   #add-point:Function前置處理  name="set_entry.pre_function"
   
   #end add-point
   
   CALL cl_set_comp_entry("inbmdocno",TRUE)
   
   IF p_cmd = 'a' THEN
      CALL cl_set_comp_entry("inbmdocno",TRUE)
      CALL cl_set_comp_entry("inbmdocdt",TRUE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,TRUE)
      END IF
      #add-point:set_entry段欄位控制 name="set_entry.field_control"
      
      #end add-point  
   END IF
   
   #add-point:set_entry段欄位控制後 name="set_entry.after_control"
   CALL cl_set_comp_entry("inbo010_1",TRUE)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aint701.set_no_entry" >}
#+ 單頭欄位關閉設定
PRIVATE FUNCTION aint701_set_no_entry(p_cmd)
   #add-point:set_no_entry段define(客製用) name="set_no_entry.define_customerization"
   
   #end add-point     
   DEFINE p_cmd   LIKE type_t.chr1   
   #add-point:set_no_entry段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_no_entry.define"
   
   #end add-point     
   
   #add-point:Function前置處理  name="set_no_entry.pre_function"
   
   #end add-point
   
   IF p_cmd = 'u' AND g_chkey = 'N' THEN
      CALL cl_set_comp_entry("inbmdocno",FALSE)
      #根據azzi850使用者身分開關特定欄位
      IF NOT cl_null(g_no_entry) THEN
         CALL cl_set_comp_entry(g_no_entry,FALSE)
      END IF
      #add-point:set_no_entry段欄位控制 name="set_no_entry.field_control"
      
      #end add-point 
   END IF 
   
   IF p_cmd = 'u' THEN  #docno,ld欄位確認是絕對關閉
      CALL cl_set_comp_entry("inbmdocno",FALSE)
   END IF 
 
#  IF p_cmd = 'u' THEN  #docdt欄位依照設定關閉(FALSE則為設定不同意修正) #(ver:78)
      IF NOT cl_chk_update_docdt() THEN
         CALL cl_set_comp_entry("inbmdocdt",FALSE)
      END IF
#  END IF 
   
   #add-point:set_no_entry段欄位控制後 name="set_no_entry.after_control"
   IF g_inbn_d.getlength() > 0 THEN
      IF g_inbn_d[g_detail_idx].inbn002 != '1' THEN
         LET g_skip_1 = FALSE
         CALL cl_set_comp_entry("inbo010_1",FALSE)
      ELSE 
         LET g_skip_1 = TRUE
      END IF
   END IF
   CALL cl_set_comp_entry("inbmdocdt",FALSE)
   #end add-point 
 
END FUNCTION
 
{</section>}
 
{<section id="aint701.set_entry_b" >}
#+ 單身欄位開啟設定
PRIVATE FUNCTION aint701_set_entry_b(p_cmd)
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
   CALL cl_set_comp_entry("inbn001",TRUE)
   #end add-point  
END FUNCTION
 
{</section>}
 
{<section id="aint701.set_no_entry_b" >}
#+ 單身欄位關閉設定
PRIVATE FUNCTION aint701_set_no_entry_b(p_cmd)
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
   #20160920 mark by beckxie---S
   #SA:已封箱也允許修改箱號,讓user可以在編輯狀態時移動光標
   #IF g_inbn_d.getlength() > 0 THEN
   #   IF g_inbn_d[l_ac].inbn002 !='1' THEN
   #      CALL cl_set_comp_entry("inbn001",FALSE)
   #      LET g_skip = TRUE
   #   ELSE
   #      LET g_skip = FALSE
   #   END IF
   #END IF
   #20160920 mark by beckxie---E
   #end add-point     
END FUNCTION
 
{</section>}
 
{<section id="aint701.set_act_visible" >}
#+ 單頭權限開啟
PRIVATE FUNCTION aint701_set_act_visible()
   #add-point:set_act_visible段define(客製用) name="set_act_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible.define"
   
   #end add-point   
   #add-point:set_act_visible段 name="set_act_visible.set_act_visible"
   CALL cl_set_act_visible("seal_box,modify,modify_detail",TRUE)
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aint701.set_act_no_visible" >}
#+ 單頭權限關閉
PRIVATE FUNCTION aint701_set_act_no_visible()
   #add-point:set_act_no_visible段define(客製用) name="set_act_no_visible.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible.define"
   
   #end add-point   
   #add-point:set_act_no_visible段 name="set_act_no_visible.set_act_no_visible"
   #單據未審核時,才可使用
   IF g_inbm_m.inbmstus != 'N' THEN
      CALL cl_set_act_visible("seal_box,modify,modify_detail",FALSE)
   END IF
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aint701.set_act_visible_b" >}
#+ 單身權限開啟
PRIVATE FUNCTION aint701_set_act_visible_b()
   #add-point:set_act_visible_b段define(客製用) name="set_act_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_visible_b.define"
   
   #end add-point   
   #add-point:set_act_visible_b段 name="set_act_visible_b.set_act_visible_b"
   CALL cl_set_act_visible("delete",TRUE)    #20160920 add by beckxie
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aint701.set_act_no_visible_b" >}
#+ 單身權限關閉
PRIVATE FUNCTION aint701_set_act_no_visible_b()
   #add-point:set_act_no_visible_b段define(客製用) name="set_act_no_visible_b.define_customerization"
   
   #end add-point   
   #add-point:set_act_no_visible_b段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="set_act_no_visible_b.define"
   
   #end add-point   
   #add-point:set_act_no_visible_b段 name="set_act_no_visible_b.set_act_no_visible_b"
   #20160920 add by beckxie---S
   IF l_ac > 0 THEN 
      IF g_inbn_d[l_ac].inbn002 !='1' THEN
         CALL cl_set_act_visible("delete",FALSE)    
      END IF
   END IF
   #20160920 add by beckxie---E
   #end add-point   
END FUNCTION
 
{</section>}
 
{<section id="aint701.default_search" >}
#+ 外部參數搜尋
PRIVATE FUNCTION aint701_default_search()
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
      LET ls_wc = ls_wc, " inbmdocno = '", g_argv[01], "' AND "
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
               WHEN la_wc[li_idx].tableid = "inbm_t" 
                  LET g_wc = la_wc[li_idx].wc
               WHEN la_wc[li_idx].tableid = "inbn_t" 
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
 
{<section id="aint701.state_change" >}
   #應用 a09 樣板自動產生(Version:17)
#+ 確認碼變更 
PRIVATE FUNCTION aint701_statechange()
   #add-point:statechange段define(客製用) name="statechange.define_customerization"
   
   #end add-point  
   DEFINE lc_state LIKE type_t.chr5
   #add-point:statechange段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="statechange.define"
   DEFINE l_success   LIKE type_t.num5
   #end add-point  
   
   #add-point:Function前置處理 name="statechange.before"
   
   #end add-point  
   
   ERROR ""     #清空畫面右下側ERROR區塊
 
   IF g_inbm_m.inbmdocno IS NULL
 
   THEN
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "" 
      LET g_errparam.code   = "std-00003" 
      LET g_errparam.popup  = FALSE 
      CALL cl_err()
      RETURN
   END IF
 
   CALL s_transaction_begin()
   
   OPEN aint701_cl USING g_enterprise,g_inbm_m.inbmdocno
   IF STATUS THEN
      CLOSE aint701_cl
      CALL s_transaction_end('N','0')
      INITIALIZE g_errparam TO NULL 
      LET g_errparam.extend = "OPEN aint701_cl:" 
      LET g_errparam.code   = STATUS 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN
   END IF
   
   #顯示最新的資料
   EXECUTE aint701_master_referesh USING g_inbm_m.inbmdocno INTO g_inbm_m.inbmsite,g_inbm_m.inbmdocdt, 
       g_inbm_m.inbmdocno,g_inbm_m.inbm003,g_inbm_m.inbm005,g_inbm_m.inbm006,g_inbm_m.inbm007,g_inbm_m.inbm004, 
       g_inbm_m.inbm001,g_inbm_m.inbm002,g_inbm_m.inbmunit,g_inbm_m.inbm008,g_inbm_m.inbmstus,g_inbm_m.inbmownid, 
       g_inbm_m.inbmowndp,g_inbm_m.inbmcrtid,g_inbm_m.inbmcrtdp,g_inbm_m.inbmcrtdt,g_inbm_m.inbmmodid, 
       g_inbm_m.inbmmoddt,g_inbm_m.inbmcnfid,g_inbm_m.inbmcnfdt,g_inbm_m.inbmsite_desc,g_inbm_m.inbm005_desc, 
       g_inbm_m.inbm006_desc,g_inbm_m.inbm001_desc,g_inbm_m.inbmunit_desc,g_inbm_m.inbmownid_desc,g_inbm_m.inbmowndp_desc, 
       g_inbm_m.inbmcrtid_desc,g_inbm_m.inbmcrtdp_desc,g_inbm_m.inbmmodid_desc,g_inbm_m.inbmcnfid_desc 
 
   
 
   #檢查是否允許此動作
   IF NOT aint701_action_chk() THEN
      CLOSE aint701_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
 
   #將資料顯示到畫面上
   DISPLAY BY NAME g_inbm_m.inbmsite,g_inbm_m.inbmsite_desc,g_inbm_m.inbmdocdt,g_inbm_m.inbmdocno,g_inbm_m.inbm003, 
       g_inbm_m.inbm005,g_inbm_m.inbm005_desc,g_inbm_m.inbm006,g_inbm_m.inbm006_desc,g_inbm_m.inbm007, 
       g_inbm_m.inbm004,g_inbm_m.inbm001,g_inbm_m.inbm001_desc,g_inbm_m.inbm002,g_inbm_m.inbmunit,g_inbm_m.inbmunit_desc, 
       g_inbm_m.inbm008,g_inbm_m.inbmstus,g_inbm_m.inbmownid,g_inbm_m.inbmownid_desc,g_inbm_m.inbmowndp, 
       g_inbm_m.inbmowndp_desc,g_inbm_m.inbmcrtid,g_inbm_m.inbmcrtid_desc,g_inbm_m.inbmcrtdp,g_inbm_m.inbmcrtdp_desc, 
       g_inbm_m.inbmcrtdt,g_inbm_m.inbmmodid,g_inbm_m.inbmmodid_desc,g_inbm_m.inbmmoddt,g_inbm_m.inbmcnfid, 
       g_inbm_m.inbmcnfid_desc,g_inbm_m.inbmcnfdt,g_inbm_m.inbn001_1,g_inbm_m.l_symbol,g_inbm_m.l_num, 
       g_inbm_m.inbo010_1
 
   CASE g_inbm_m.inbmstus
      WHEN "N"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/unconfirmed.png")
      WHEN "Y"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/confirmed.png")
      WHEN "X"
         CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
      
   END CASE
 
   #add-point:資料刷新後 name="statechange.after_refresh"
   
   #end add-point
 
   MENU "" ATTRIBUTES (STYLE="popup")
      BEFORE MENU
         HIDE OPTION "approved"
         HIDE OPTION "rejection"
         CASE g_inbm_m.inbmstus
            
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "Y"
               HIDE OPTION "confirmed"
            WHEN "X"
               HIDE OPTION "invalid"
         END CASE
     
      #add-point:menu前 name="statechange.before_menu"
      #160909-00069#6 -s by 08172
      CASE g_inbm_m.inbmstus
            
            WHEN "N"
               HIDE OPTION "unconfirmed"
            WHEN "X"
               HIDE OPTION "unconfirmed"
               HIDE OPTION "invalid"
               HIDE OPTION "confirmed"
               
               RETURN
            WHEN "Y"
               HIDE OPTION "confirmed"
               HIDE OPTION "invalid"
         END CASE
         #160909-00069#6 -e by 08172
      #end add-point
      
      
	  
      ON ACTION unconfirmed
         IF cl_auth_chk_act("unconfirmed") THEN
            LET lc_state = "N"
            #add-point:action控制 name="statechange.unconfirmed"
            #160909-00069#6 -s by 08172
            CALL cl_err_collect_init()  #161229-00039#1  add by yany 2016/12/30
            CALL s_aint701_unconf_chk(g_inbm_m.inbmdocno) RETURNING l_success
            IF l_success THEN
               IF cl_ask_confirm('lib-015') THEN
                  CALL s_transaction_begin()
                  CALL s_aint701_unconf_upd(g_inbm_m.inbmdocno) RETURNING l_success
                  IF NOT l_success THEN
                     CALL s_transaction_end('N','0')
                     CALL cl_err_collect_show()  #161229-00039#1  add by yany 2016/12/30
                     RETURN
                  ELSE
                     CALL s_transaction_end('Y','1')
                  END IF
               ELSE
                  CALL cl_err_collect_show()  #161229-00039#1  add by yany 2016/12/30
                  CALL s_transaction_end('N','0')   
                  RETURN
               END IF
            ELSE
               CALL cl_err_collect_show()  #161229-00039#1  add by yany 2016/12/30
               CALL s_transaction_end('N','0')   
               RETURN    
            END IF
            #160909-00069#6 -e by 08172
            #end add-point
         END IF
         EXIT MENU
      ON ACTION confirmed
         IF cl_auth_chk_act("confirmed") THEN
            LET lc_state = "Y"
            #add-point:action控制 name="statechange.confirmed"
            #160909-00069#6 -s by 08172
            CALL cl_err_collect_init()  #161229-00039#1  add by yany 2016/12/30
            CALL s_aint701_conf_chk(g_inbm_m.inbmdocno) RETURNING l_success
            IF l_success THEN
               IF cl_ask_confirm('lib-014') THEN
                  CALL s_transaction_begin()
                  CALL s_aint701_conf_upd(g_inbm_m.inbmdocno) RETURNING l_success
                  IF NOT l_success THEN
                     CALL s_transaction_end('N','0') 
                     CALL cl_err_collect_show()  #161229-00039#1  add by yany 2016/12/30
                     RETURN
                  ELSE
                     CALL s_transaction_end('Y','1')
                  END IF
               ELSE
                  CALL cl_err_collect_show()   #161229-00039#1  add by yany 2016/12/30
                  CALL s_transaction_end('N','0')   
                  RETURN
               END IF
            ELSE
               CALL cl_err_collect_show()   #161229-00039#1  add by yany 2016/12/30
               CALL s_transaction_end('N','0')   
               RETURN    
            END IF
            #160909-00069#6 -e by 08172
            #end add-point
         END IF
         EXIT MENU
      ON ACTION invalid
         IF cl_auth_chk_act("invalid") THEN
            LET lc_state = "X"
            #add-point:action控制 name="statechange.invalid"
            #160909-00069#6 -s by 08172
            CALL cl_err_collect_init()  #161229-00039#1  add by yany 2016/12/30
            CALL s_aint701_invalid_chk(g_inbm_m.inbmdocno) RETURNING l_success
            IF l_success THEN
               IF cl_ask_confirm('lib-016') THEN
                  CALL s_transaction_begin()
                  CALL s_aint701_invalid_upd(g_inbm_m.inbmdocno) RETURNING l_success
                  IF NOT l_success THEN
                     CALL s_transaction_end('N','0')
                     CALL cl_err_collect_show()   #161229-00039#1  add by yany 2016/12/30
                     RETURN
                  ELSE
                     CALL s_transaction_end('Y','1')
                  END IF
               ELSE
                  CALL cl_err_collect_show()   #161229-00039#1  add by yany 2016/12/30
                  CALL s_transaction_end('N','0')   
                  RETURN
               END IF
            ELSE
               CALL cl_err_collect_show()   #161229-00039#1  add by yany 2016/12/30
               CALL s_transaction_end('N','0')   
               RETURN    
            END IF
            #160909-00069#6 -e by 08172
            #end add-point
         END IF
         EXIT MENU
 
      #add-point:stus控制 name="statechange.more_control"
      
      #end add-point
      
   END MENU
   
   #確認被選取的狀態碼在清單中
   IF (lc_state <> "N" 
      AND lc_state <> "Y"
      AND lc_state <> "X"
      ) OR 
      g_inbm_m.inbmstus = lc_state OR cl_null(lc_state) THEN
      CLOSE aint701_cl
      CALL s_transaction_end('N','0')
      RETURN
   END IF
   
   #add-point:stus修改前 name="statechange.b_update"
   
   #end add-point
   
   LET g_inbm_m.inbmmodid = g_user
   LET g_inbm_m.inbmmoddt = cl_get_current()
   LET g_inbm_m.inbmstus = lc_state
   
   #異動狀態碼欄位/修改人/修改日期
   UPDATE inbm_t 
      SET (inbmstus,inbmmodid,inbmmoddt) 
        = (g_inbm_m.inbmstus,g_inbm_m.inbmmodid,g_inbm_m.inbmmoddt)     
    WHERE inbment = g_enterprise AND inbmdocno = g_inbm_m.inbmdocno
 
    
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
         WHEN "X"
            CALL gfrm_curr.setElementImage("statechange", "stus/32/invalid.png")
         
      END CASE
    
      #撈取異動後的資料
      EXECUTE aint701_master_referesh USING g_inbm_m.inbmdocno INTO g_inbm_m.inbmsite,g_inbm_m.inbmdocdt, 
          g_inbm_m.inbmdocno,g_inbm_m.inbm003,g_inbm_m.inbm005,g_inbm_m.inbm006,g_inbm_m.inbm007,g_inbm_m.inbm004, 
          g_inbm_m.inbm001,g_inbm_m.inbm002,g_inbm_m.inbmunit,g_inbm_m.inbm008,g_inbm_m.inbmstus,g_inbm_m.inbmownid, 
          g_inbm_m.inbmowndp,g_inbm_m.inbmcrtid,g_inbm_m.inbmcrtdp,g_inbm_m.inbmcrtdt,g_inbm_m.inbmmodid, 
          g_inbm_m.inbmmoddt,g_inbm_m.inbmcnfid,g_inbm_m.inbmcnfdt,g_inbm_m.inbmsite_desc,g_inbm_m.inbm005_desc, 
          g_inbm_m.inbm006_desc,g_inbm_m.inbm001_desc,g_inbm_m.inbmunit_desc,g_inbm_m.inbmownid_desc, 
          g_inbm_m.inbmowndp_desc,g_inbm_m.inbmcrtid_desc,g_inbm_m.inbmcrtdp_desc,g_inbm_m.inbmmodid_desc, 
          g_inbm_m.inbmcnfid_desc
      
      #將資料顯示到畫面上
      DISPLAY BY NAME g_inbm_m.inbmsite,g_inbm_m.inbmsite_desc,g_inbm_m.inbmdocdt,g_inbm_m.inbmdocno, 
          g_inbm_m.inbm003,g_inbm_m.inbm005,g_inbm_m.inbm005_desc,g_inbm_m.inbm006,g_inbm_m.inbm006_desc, 
          g_inbm_m.inbm007,g_inbm_m.inbm004,g_inbm_m.inbm001,g_inbm_m.inbm001_desc,g_inbm_m.inbm002, 
          g_inbm_m.inbmunit,g_inbm_m.inbmunit_desc,g_inbm_m.inbm008,g_inbm_m.inbmstus,g_inbm_m.inbmownid, 
          g_inbm_m.inbmownid_desc,g_inbm_m.inbmowndp,g_inbm_m.inbmowndp_desc,g_inbm_m.inbmcrtid,g_inbm_m.inbmcrtid_desc, 
          g_inbm_m.inbmcrtdp,g_inbm_m.inbmcrtdp_desc,g_inbm_m.inbmcrtdt,g_inbm_m.inbmmodid,g_inbm_m.inbmmodid_desc, 
          g_inbm_m.inbmmoddt,g_inbm_m.inbmcnfid,g_inbm_m.inbmcnfid_desc,g_inbm_m.inbmcnfdt,g_inbm_m.inbn001_1, 
          g_inbm_m.l_symbol,g_inbm_m.l_num,g_inbm_m.inbo010_1
   END IF
 
   #add-point:stus修改後 name="statechange.a_update"
   
   #end add-point
 
   #add-point:statechange段結束前 name="statechange.after"
   
   #end add-point  
 
   CLOSE aint701_cl
   CALL s_transaction_end('Y','0')
 
   #功能已完成,通報訊息中心
   CALL aint701_msgcentre_notify('statechange:'||lc_state)
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aint701.idx_chk" >}
#+ 顯示正確的單身資料筆數
PRIVATE FUNCTION aint701_idx_chk()
   #add-point:idx_chk段define(客製用) name="idx_chk.define_customerization"
   
   #end add-point  
   #add-point:idx_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="idx_chk.define"
   
   #end add-point  
   
   #add-point:Function前置處理  name="idx_chk.pre_function"
   
   #end add-point
   
   IF g_current_page = 1 THEN
      LET g_detail_idx = g_curr_diag.getCurrentRow("s_detail1")
      IF g_detail_idx > g_inbn_d.getLength() THEN
         LET g_detail_idx = g_inbn_d.getLength()
      END IF
      IF g_detail_idx = 0 AND g_inbn_d.getLength() <> 0 THEN
         LET g_detail_idx = 1
      END IF
      DISPLAY g_detail_idx TO FORMONLY.idx
      DISPLAY g_inbn_d.getLength() TO FORMONLY.cnt
   END IF
   
   IF g_current_page = 2 THEN
      LET g_detail_idx2 = g_curr_diag.getCurrentRow("s_detail2")
      IF g_detail_idx2 > g_inbn2_d.getLength() THEN
         LET g_detail_idx2 = g_inbn2_d.getLength()
      END IF
      IF g_detail_idx2 = 0 AND g_inbn2_d.getLength() <> 0 THEN
         LET g_detail_idx2 = 1
      END IF
      DISPLAY g_detail_idx2 TO FORMONLY.idx
      DISPLAY g_inbn2_d.getLength() TO FORMONLY.cnt
   END IF
 
   
   #add-point:idx_chk段other name="idx_chk.other"
   
   #end add-point  
   
END FUNCTION
 
{</section>}
 
{<section id="aint701.b_fill2" >}
#+ 單身陣列填充2
PRIVATE FUNCTION aint701_b_fill2(pi_idx)
   #add-point:b_fill2段define(客製用) name="b_fill2.define_customerization"
   
   #end add-point
   DEFINE pi_idx                 LIKE type_t.num10
   DEFINE li_ac                  LIKE type_t.num10
   DEFINE li_detail_idx_tmp      LIKE type_t.num10
   DEFINE ls_chk                 LIKE type_t.chr1
   #add-point:b_fill2段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="b_fill2.define"
   DEFINE l_inbn002              LIKE inbn_t.inbn002   #161024-00023#4 20161026 add by beckxie
   #end add-point
   
   #add-point:Function前置處理  name="b_fill2.pre_function"
   LET g_inbm_m.inbn001_1 = g_inbn_d[g_detail_idx].inbn001
   DISPLAY BY NAME g_inbm_m.inbn001_1
   #end add-point
   
   LET li_ac = l_ac 
   
   IF g_detail_idx <= 0 THEN
      RETURN
   END IF
   
   LET li_detail_idx_tmp = g_detail_idx
   
   IF aint701_fill_chk(2) THEN
      IF (pi_idx = 2 OR pi_idx = 0 ) AND g_inbn_d.getLength() > 0 THEN
               CALL g_inbn2_d.clear()
 
         
         #取得該單身上階單身的idx
         LET g_detail_idx = g_detail_idx_list[1]
         
         LET g_sql = "SELECT  DISTINCT inbosite,inbounit,inbo002,inbo001,inbo010,inbo006,inbo007,inbo008, 
             inbo009 ,t1.imaal003 ,t2.inaml004 ,t3.oocal003 FROM inbo_t",    
                     "",
                                    " LEFT JOIN imaal_t t1 ON t1.imaalent="||g_enterprise||" AND t1.imaal001=inbo006 AND t1.imaal002='"||g_dlang||"' ",
               " LEFT JOIN inaml_t t2 ON t2.inamlent="||g_enterprise||" AND t2.inaml001=inbo006 AND t2.inaml002=inbo007 AND t2.inaml003='"||g_dlang||"' ",
               " LEFT JOIN oocal_t t3 ON t3.oocalent="||g_enterprise||" AND t3.oocal001=inbo008 AND t3.oocal002='"||g_dlang||"' ",
 
                     " WHERE inboent=? AND inbodocno=? AND inbo001=?"
         
         IF NOT cl_null(g_wc2_table2) THEN
            LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
         END IF
         
         LET g_sql = g_sql, " ORDER BY  inbo_t.inbo002" 
                            
         #add-point:單身填充前 name="b_fill2.before_fill2"
         #161024-00023#4 20161026 add by beckxie---S
         #依照[是否封箱]顯示裝箱明細內容:
         SELECT inbn002 INTO l_inbn002 
           FROM inbn_t
          WHERE inbnent = g_enterprise
            AND inbndocno = g_inbm_m.inbmdocno
            AND inbn001 = g_inbn_d[g_detail_idx].inbn001    
            
         CASE l_inbn002
            WHEN '1'   #1.未封箱:顯示temp table 資料
               LET g_sql = "SELECT  DISTINCT inbosite,inbounit,seq,inbo001,inbo010,inbo006, ",
                           "                 inbo007,inbo008,inbo009,t1.imaal003 ,t2.inaml004 , ", 
                           "                 t3.oocal003  ",
                           "  FROM aint701_inbo_temp ",
                           "              LEFT JOIN imaal_t t1 ON t1.imaalent=inboent AND t1.imaal001=inbo006 AND t1.imaal002='",g_dlang,"' ",
                           "              LEFT JOIN inaml_t t2 ON t2.inamlent=inboent AND t2.inaml001=inbo006 AND t2.inaml002=inbo007 AND t2.inaml003='",g_dlang,"' ",
                           "              LEFT JOIN oocal_t t3 ON t3.oocalent=inboent AND t3.oocal001=inbo008 AND t3.oocal002='",g_dlang,"' ",
               
                           " WHERE inboent=? AND inbodocno=? AND inbo001=?"
               
               IF NOT cl_null(g_wc2_table2) THEN
                  LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
               END IF
               #161017-00051#15 20161201 add by beckxie---S
               #未封箱掃碼時改為依照掃碼順序降序顯示
               #LET g_sql = g_sql, " ORDER BY inbosite,inbounit,seq,inbo001,inbo010,inbo006 "
               LET g_sql = g_sql, " ORDER BY seq DESC"
               #161017-00051#15 20161201 add by beckxie---E
            WHEN '2'   #2.已封箱:顯示inbo_t資料
         #161024-00023#4 20161026 add by beckxie---E
               LET g_sql = "SELECT  DISTINCT inbosite,inbounit,'',inbo001,inbo010,inbo006, ",
                           "                 inbo007,inbo008,SUM(inbo009),t1.imaal003 ,t2.inaml004 , ", 
                           "                 t3.oocal003  ",
                           "  FROM inbo_t LEFT JOIN imaal_t t1 ON t1.imaalent=inboent AND t1.imaal001=inbo006 AND t1.imaal002='",g_dlang,"' ",
                           "              LEFT JOIN inaml_t t2 ON t2.inamlent=inboent AND t2.inaml001=inbo006 AND t2.inaml002=inbo007 AND t2.inaml003='",g_dlang,"' ",
                           "              LEFT JOIN oocal_t t3 ON t3.oocalent=inboent AND t3.oocal001=inbo008 AND t3.oocal002='",g_dlang,"' ",
               
                           " WHERE inboent=? AND inbodocno=? AND inbo001=?"
               
               IF NOT cl_null(g_wc2_table2) THEN
                  LET g_sql = g_sql CLIPPED," AND ",g_wc2_table2 CLIPPED
               END IF
               
               LET g_sql = g_sql, " GROUP BY inbosite,inbounit,inbo001,inbo010,inbo006,inbo007,inbo008,t1.imaal003,t2.inaml004,t3.oocal003 ",
                                  " ORDER BY inbosite,inbounit,inbo001,inbo010,inbo006 " 
         
         END CASE   #161024-00023#4 20161026 add by beckxie
         #end add-point
         
         #先清空資料
               CALL g_inbn2_d.clear()
 
         
         LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料
         PREPARE aint701_pb2 FROM g_sql
         DECLARE b_fill_curs2 CURSOR FOR aint701_pb2
         
      #  OPEN b_fill_curs2 USING g_enterprise,g_inbm_m.inbmdocno,g_inbn_d[g_detail_idx].inbn001   #(ver:78) 
 
         LET l_ac = 1
         FOREACH b_fill_curs2 USING g_enterprise,g_inbm_m.inbmdocno,g_inbn_d[g_detail_idx].inbn001 INTO g_inbn2_d[l_ac].inbosite, 
             g_inbn2_d[l_ac].inbounit,g_inbn2_d[l_ac].inbo002,g_inbn2_d[l_ac].inbo001,g_inbn2_d[l_ac].inbo010, 
             g_inbn2_d[l_ac].inbo006,g_inbn2_d[l_ac].inbo007,g_inbn2_d[l_ac].inbo008,g_inbn2_d[l_ac].inbo009, 
             g_inbn2_d[l_ac].inbo006_desc,g_inbn2_d[l_ac].inbo007_desc,g_inbn2_d[l_ac].inbo008_desc  
               #(ver:78)
            IF SQLCA.SQLCODE THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "FOREACH:",SQLERRMESSAGE 
               LET g_errparam.code = SQLCA.SQLCODE 
               LET g_errparam.popup = TRUE 
               CALL cl_err()
               EXIT FOREACH
            END IF
            
            #add-point:b_fill段資料填充 name="b_fill2.fill2"
            IF l_inbn002 = '1' THEN   #未封箱
               LET g_inbn2_d[l_ac].l_seq =  g_inbn2_d[l_ac].inbo002
               SELECT inbo002 INTO g_inbn2_d[l_ac].inbo002
                 FROM aint701_inbo_temp
                WHERE inboent = g_enterprise
                  AND inbodocno = g_inbm_m.inbmdocno
                  AND inbo001 = g_inbn2_d[l_ac].inbo001
                  AND inbo002 = g_inbn2_d[l_ac].inbo002
            END IF
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
               CALL g_inbn2_d.deleteElement(g_inbn2_d.getLength())
 
      END IF
   END IF
 
 
      
   LET g_inbn2_d_mask_o.* =  g_inbn2_d.*
   FOR l_ac = 1 TO g_inbn2_d.getLength()
      LET g_inbn2_d_mask_o[l_ac].* =  g_inbn2_d[l_ac].*
      CALL aint701_inbo_t_mask()
      LET g_inbn2_d_mask_n[l_ac].* =  g_inbn2_d[l_ac].*
   END FOR
 
      
   #add-point:單身填充後 name="b_fill2.after_fill"
 
   #end add-point
    
   LET l_ac = li_ac
   
   CALL aint701_detail_show()
   
   LET g_detail_idx = li_detail_idx_tmp
   
END FUNCTION
 
{</section>}
 
{<section id="aint701.fill_chk" >}
#+ 單身填充確認
PRIVATE FUNCTION aint701_fill_chk(ps_idx)
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
 
{<section id="aint701.status_show" >}
PRIVATE FUNCTION aint701_status_show()
   #add-point:status_show段define(客製用) name="status_show.define_customerization"
   
   #end add-point
   #add-point:status_show段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="status_show.define"
   
   #end add-point
   
   #add-point:status_show段status_show name="status_show.status_show"
   
   #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aint701.mask_functions" >}
&include "erp/ain/aint701_mask.4gl"
 
{</section>}
 
{<section id="aint701.signature" >}
   
 
{</section>}
 
{<section id="aint701.set_pk_array" >}
   #應用 a51 樣板自動產生(Version:8)
#+ 給予pk_array內容
PRIVATE FUNCTION aint701_set_pk_array()
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
   LET g_pk_array[1].values = g_inbm_m.inbmdocno
   LET g_pk_array[1].column = 'inbmdocno'
 
   
   #add-point:set_pk_array段之後 name="set_pk_array.after"
   
   #end add-point  
   
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aint701.other_dialog" readonly="Y" >}
   
 
{</section>}
 
{<section id="aint701.msgcentre_notify" >}
#應用 a66 樣板自動產生(Version:6)
PRIVATE FUNCTION aint701_msgcentre_notify(lc_state)
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
   CALL aint701_set_pk_array()
   #單頭資料填寫
   LET g_msgparam.data[1] = util.JSON.stringify(g_inbm_m)
 
   #add-point:msgcentre其他通知 name="msgcentre_notify.process"
   
   #end add-point
 
   #呼叫訊息中心傳遞本關完成訊息
   CALL cl_msgcentre_notify()
 
END FUNCTION
 
 
 
 
{</section>}
 
{<section id="aint701.action_chk" >}
#+ 修改/刪除前行為檢查(是否可允許此動作), 若有其他行為須管控也可透過此段落
PRIVATE FUNCTION aint701_action_chk()
   #add-point:action_chk段define(客製用) name="action_chk.define_customerization"
   
   #end add-point
   #add-point:action_chk段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="action_chk.define"
   
   #end add-point
   
   #add-point:action_chk段action_chk name="action_chk.action_chk"
   
   #end add-point
      
   RETURN TRUE
   
END FUNCTION
 
{</section>}
 
{<section id="aint701.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 條碼檢查
# Memo...........:
# Usage..........: CALL aint701_inbo010_chk()
#                  RETURNING r_success
# Input parameter: 無
# Return code....: r_success TRUE/FALSE
# Date & Author..: 20160907 add by beckxie
# Modify.........:
################################################################################
PRIVATE FUNCTION aint701_inbo010_chk()
   DEFINE l_imay001            LIKE imay_t.imay001
   DEFINE l_imay019            LIKE imay_t.imay019
   DEFINE l_imay004            LIKE imay_t.imay004
   DEFINE l_success            LIKE type_t.chr1
   DEFINE l_cnt                LIKE type_t.num5
   DEFINE l_diff               LIKE type_t.num5   #161213-00004#1 20161213 add by beckxie
   DEFINE r_success            LIKE type_t.num5
   
   LET r_success = TRUE
   
   CALL s_analyse_barcode(g_inbm_m.inbo010_1,'0') RETURNING l_imay001,l_imay019,l_imay004,l_success
   IF l_success='Y' THEN
   
      #161024-00023#4 20161026 add by beckxie---S
      #IF g_inbm_m.l_symbol = '1' THEN #減   #161024-00023#22 20161202 mark by beckxie
      
      #1.檢查是否存在單據明細
      
      #来源类型=‘4.配送单’  and 料号+产品特征+单位不存在于[单据明细]页面的料号+产品特征+单位
      #show err:
      #IF g_inbm_m.inbm003 = '4' THEN   #161213-00004#1 20161214 mark by beckxie 
      IF g_inbm_m.inbm003 = '4' OR g_inbm_m.inbm003 = '5' THEN   #161213-00004#1 20161214 add by beckxie
         
         SELECT COUNT(1) INTO l_cnt
           FROM inbp_t
          WHERE inbpent = g_enterprise
            AND inbpdocno = g_inbm_m.inbmdocno
            AND inbp005 = l_imay001
            AND inbp006 = COALESCE(l_imay019,' ')
            AND inbp007 = l_imay004
            
         IF l_cnt = 0 THEN
            #此條碼[ %1 ]、商品[ %2 ]、產品特徵[ %3 ]、單位[ %4 ]，不存在於[單據明細]中！
            LET r_success = FALSE
            INITIALIZE g_errparam TO NULL
            #LET g_errparam.code   = "ain-00788"   #161024-00023#22 20161202 mark by beckxie
            LET g_errparam.code   = "ain-00851"    #161024-00023#22 20161202 add by beckxie
            LET g_errparam.replace[1] = g_inbm_m.inbo010_1
            LET g_errparam.replace[2] = l_imay001
            LET g_errparam.replace[3] = l_imay019
            LET g_errparam.replace[4] = l_imay004
            #LET g_errparam.popup  = TRUE   #161024-00023#12 20161030 mark by beckxie
            LET g_errparam.popup  = FALSE   #161024-00023#12 20161030 add by beckxie
            CALL cl_err()
            RETURN r_success
         END IF
         
      END IF   #161213-00004#1 20161213 add by beckxie
      #161213-00004#1 20161213 add by beckxie---S
      #来源类型=‘7.分销退货单’ and 料号 不存在于[单据明细]页面的料号 
      #show err:
      IF g_inbm_m.inbm003 = '7' THEN   #161213-00004#1 20161213 add by beckxie
      
         LET l_cnt = 0 
         SELECT COUNT(1) INTO l_cnt
           FROM inbp_t
          WHERE inbpent = g_enterprise
            AND inbpdocno = g_inbm_m.inbmdocno
            AND inbp005 = l_imay001
            
         IF l_cnt = 0 THEN
            #此條碼[ %1 ]、商品[ %2 ]，不存在於[單據明細]中！
            LET r_success = FALSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code   = "ain-00859"
            LET g_errparam.replace[1] = g_inbm_m.inbo010_1
            LET g_errparam.replace[2] = l_imay001
            LET g_errparam.popup  = FALSE   
            CALL cl_err()
            RETURN r_success
         END IF
         
      END IF
      #161213-00004#1 20161213 add by beckxie---E
      #ELSE   #161024-00023#22 20161202 mark by beckxie
      #161024-00023#4 20161026 add by beckxie---E
      
      #2.檢查是否存在於待裝明細中
      
      #来源类型=‘4.配送单’  and 本次扫入数量> 待装量,show error msg:'该条码商品数量超出待装量!'
      IF g_inbm_m.inbm003 = '4' AND g_inbm_m.l_symbol != '1' THEN   #161024-00023#22 20161202 add by beckxie
         #161024-00023#4 20161026 add by beckxie---S
         LET l_cnt = 0
         SELECT COUNT(1) INTO l_cnt
           FROM inbp_t
          WHERE inbpent = g_enterprise
            AND inbpdocno = g_inbm_m.inbmdocno 
            AND inbp005 = l_imay001
            AND inbp006 = COALESCE(l_imay019,' ')
            AND inbp007 = l_imay004
            AND (inbp008-inbp009) != 0
         #161024-00023#4 20161026 add by beckxie---E
         #161024-00023#4 20161026 mark by beckxie---S
         #SELECT COUNT(1) INTO l_cnt
         #  FROM (SELECT pmcz023,pmcz001,pmcz002,pmcz003,pmcz004, 
         #               pmcz005,pmcz006
         #          FROM inbm_t ,indj_t ,pmcz_t 
         #               LEFT JOIN imaa_t ON imaaent = pmczent AND imaa001 = pmcz004 
         #         WHERE indjent = inbment AND indjdocno = inbm004 AND inbm003 ='1' 
         #           AND pmczent = indjent AND pmcz001 = indj001 
         #           AND pmcz002 = indj002 AND pmcz063 = inbm008 
         #           AND pmcz062 = inbm001 AND pmcz001 = COALESCE(inbm002,pmcz001) 
         #           AND inbment = g_enterprise AND inbmdocno = g_inbm_m.inbmdocno 
         #           AND (pmcz051-pmcz064) != 0 )
         #  WHERE pmcz004 = l_imay001 AND pmcz005 = COALESCE(l_imay019,' ') AND pmcz006 = l_imay004
         #  GROUP BY pmcz004,pmcz005,pmcz006
         #161024-00023#4 20161026 mark by beckxie---E
         IF l_cnt = 0 THEN
            #此條碼[ %1 ]、商品[ %2 ]、產品特徵[ %3 ]、單位[ %4 ]，不存在於[待裝明細]中！
            LET r_success = FALSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code   = "ain-00787"
            LET g_errparam.replace[1] = g_inbm_m.inbo010_1
            LET g_errparam.replace[2] = l_imay001
            LET g_errparam.replace[3] = l_imay019
            LET g_errparam.replace[4] = l_imay004
            #LET g_errparam.popup  = TRUE   #161024-00023#12 20161030 mark by beckxie
            LET g_errparam.popup  = FALSE   #161024-00023#12 20161030 add by beckxie
            CALL cl_err()
            RETURN r_success
         END IF
            
      END IF  #161024-00023#22 20161202 add by beckxie
      #END IF   #161024-00023#4 20161026 add by beckxie   #161024-00023#22 20161202 mark by beckxie
      
      #161213-00004#1 20161213 add by beckxie---S
      #IF 来源类型=‘7.分销退货单’  and 本次扫入数量> sum(同商品单据明细页的差异量）
      #show error msg:'该条码商品数量超出!'
      IF g_inbm_m.inbm003 = '7' AND g_inbm_m.l_symbol != '1' THEN
         LET l_diff = 0
         SELECT SUM(inbp008-inbp009) INTO l_diff 
           FROM inbp_t
          WHERE inbpent = g_enterprise
            AND inbpdocno = g_inbm_m.inbmdocno 
            AND inbp005 = l_imay001 
        
         IF g_inbm_m.l_num - l_diff > 0 THEN
            #本次掃入數量[ %1 ] 超出此商品[ %2 ] 差異量[ %3 ]！
            LET r_success = FALSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code   = "ain-00860"
            LET g_errparam.replace[1] = g_inbm_m.l_num
            LET g_errparam.replace[2] = l_imay001
            LET g_errparam.replace[3] = l_diff
            LET g_errparam.popup  = FALSE   
            CALL cl_err()
            RETURN r_success
         END IF
      END IF
      #161213-00004#1 20161213 add by beckxie---E
      
   ELSE
      #解析失敗
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 新增資料至裝箱明細inbo_t中
# Memo...........:
# Usage..........: CALL aint701_ins_inbo()
#                  RETURNING r_success
# Input parameter: 無
# Return code....: 無
# Date & Author..: 20160907 add by beckxie
# Modify.........:
################################################################################
PRIVATE FUNCTION aint701_ins_inbo()
   DEFINE l_imay001            LIKE imay_t.imay001
   DEFINE l_imay019            LIKE imay_t.imay019
   DEFINE l_imay004            LIKE imay_t.imay004
   DEFINE l_success            LIKE type_t.chr1
   DEFINE l_inbo    RECORD                 #裝箱單單身商品明細檔
          inboent   LIKE inbo_t.inboent,   #企業編號
          inbosite  LIKE inbo_t.inbosite,  #營運據點
          inbounit  LIKE inbo_t.inbounit,  #物流中心
          inbodocno LIKE inbo_t.inbodocno, #單據編號
          inbo001   LIKE inbo_t.inbo001,   #箱號
          inbo002   LIKE inbo_t.inbo002,   #項次
          l_seq     LIKE type_t.num10,     #掃碼順序
          inbo003   LIKE inbo_t.inbo003,   #來源需求類型
          inbo004   LIKE inbo_t.inbo004,   #來源需求單號
          inbo005   LIKE inbo_t.inbo005,   #來源需求項次
          inbo006   LIKE inbo_t.inbo006,   #商品編碼
          inbo007   LIKE inbo_t.inbo007,   #產品特征
          inbo008   LIKE inbo_t.inbo008,   #單位
          inbo009   LIKE inbo_t.inbo009,   #裝箱數量
          inbo010   LIKE inbo_t.inbo010,   #條碼
          inbo011   LIKE inbo_t.inbo011    #來源項次
   END RECORD
   DEFINE l_cnt     LIKE type_t.num5
   DEFINE l_symbol  LIKE type_t.num5
   #161024-00023#4 20161026 add by beckxie---S
   DEFINE l_seq      LIKE type_t.num10     #掃碼順序
   DEFINE l_num_all  LIKE type_t.num5      #本次剩餘掃入量
   DEFINE l_scan_tmp LIKE type_t.num5      #該項次可掃入量
   DEFINE l_cost_tmp LIKE type_t.num5      #該項次可扣除量
   DEFINE l_sum_scan LIKE type_t.num5      #此裝箱單,此商品,產品特徵,單位可掃入量
   DEFINE l_sum_cost LIKE type_t.num5      #此裝箱單,此商品,產品特徵,單位可扣量
   DEFINE l_inbo009  LIKE inbo_t.inbo009
   DEFINE l_sql      STRING
   DEFINE l_inbpseq  LIKE inbp_t.inbpseq
   DEFINE l_inbp004  LIKE inbp_t.inbp004   
   DEFINE l_inbp005  LIKE inbp_t.inbp005 
   DEFINE l_inbp006  LIKE inbp_t.inbp006 
   DEFINE l_inbp007  LIKE inbp_t.inbp007
   DEFINE l_inbp008  LIKE inbp_t.inbp008
   DEFINE l_inbp009  LIKE inbp_t.inbp009
   DEFINE l_inbp010  LIKE inbp_t.inbp010
   #161024-00023#4 20161026 add by beckxie---E
   #161024-00023#11 20161030 add by beckxie---S
   DEFINE l_pmczsite LIKE pmcz_t.pmczsite
   DEFINE l_pmcz001  LIKE pmcz_t.pmcz001   
   DEFINE l_pmcz002  LIKE pmcz_t.pmcz002
   DEFINE l_pmcz023  LIKE pmcz_t.pmcz023
   DEFINE l_pmcz064  LIKE pmcz_t.pmcz064
   #161024-00023#11 20161030 add by beckxie---E
   DEFINE r_success LIKE type_t.num5
   #161024-00023#4 20161026 mark by beckxie---S
   #DEFINE l_pmcz001 LIKE pmcz_t.pmcz001
   #DEFINE l_pmcz002 LIKE pmcz_t.pmcz002
   #DEFINE l_pmcz003 LIKE pmcz_t.pmcz003
   #DEFINE l_pmcz004 LIKE pmcz_t.pmcz004
   #DEFINE l_pmcz005 LIKE pmcz_t.pmcz005
   #DEFINE l_pmcz006 LIKE pmcz_t.pmcz006
   #DEFINE l_pmcz023 LIKE pmcz_t.pmcz023
   #DEFINE l_indjseq LIKE indj_t.indjseq
   #161024-00023#4 20161026 mark by beckxie---E
   #161213-00004#1 20161213 add by beckxie---S
   DEFINE l_inbp RECORD  #裝箱單身檔
          inbpent   LIKE inbp_t.inbpent,   #企業編號
          inbpsite  LIKE inbp_t.inbpsite,  #營運據點
          inbpdocno LIKE inbp_t.inbpdocno, #單據編號
          inbpseq   LIKE inbp_t.inbpseq,   #項次
          inbp001   LIKE inbp_t.inbp001,   #來源單據類型
          inbp002   LIKE inbp_t.inbp002,   #來源單號
          inbp003   LIKE inbp_t.inbp003,   #來源項次
          inbp004   LIKE inbp_t.inbp004,   #商品條碼
          inbp005   LIKE inbp_t.inbp005,   #商品編碼
          inbp006   LIKE inbp_t.inbp006,   #產品特徵
          inbp007   LIKE inbp_t.inbp007,   #單位
          inbp008   LIKE inbp_t.inbp008,   #數量
          inbp009   LIKE inbp_t.inbp009,   #已裝箱量
          inbp010   LIKE inbp_t.inbp010,   #需求類型
          inbp011   LIKE inbp_t.inbp011,   #需求單號
          inbp012   LIKE inbp_t.inbp012    #需求項次
   END RECORD
   DEFINE l_seq_max LIKE type_t.num5 
   #161213-00004#1 20161213 add by beckxie---E
   
   
   LET r_success = TRUE
   
   CASE g_inbm_m.l_symbol
      WHEN '0'
         LET l_symbol = '1'
      WHEN '1'
         LET l_symbol = '-1'
   END CASE
      
   CALL s_analyse_barcode(g_inbm_m.inbo010_1,'0') RETURNING l_imay001,l_imay019,l_imay004,l_success
   IF l_success = 'Y' AND NOT cl_null(l_imay001) AND NOT cl_null(l_imay004) THEN
      #161024-00023#4 20161026 mark by beckxie---S
      #SELECT pmcz001,pmcz002,pmcz003,pmcz004,pmcz005,
      #       pmcz006,pmcz023,indjseq
      #  INTO l_pmcz001,l_pmcz002,l_pmcz003,l_pmcz004,l_pmcz005,
      #       l_pmcz006,l_pmcz023,l_indjseq
      #  FROM (SELECT pmcz001,pmcz002,pmcz003,pmcz004,pmcz005,
      #               pmcz006,pmcz023,indjseq
      #          FROM inbm_t ,indj_t ,pmcz_t 
      #               LEFT JOIN imaa_t ON imaaent = pmczent AND imaa001 = pmcz004 
      #         WHERE indjent = inbment AND indjdocno = inbm004 AND inbm003 ='1' 
      #           AND pmczent = indjent AND pmcz001 = indj001 
      #           AND pmcz002 = indj002 AND pmcz063 = inbm008 
      #           AND pmcz062 = inbm001 AND pmcz001 = COALESCE(inbm002,pmcz001) 
      #           AND inbment = g_enterprise AND inbmdocno = g_inbm_m.inbmdocno 
      #           AND pmcz051 > pmcz064 )  #排除的已配發量已足夠的單據
      # WHERE pmcz004 = l_imay001 AND pmcz005 = COALESCE(l_imay019,' ') AND pmcz006 = l_imay004
      # GROUP BY pmcz001,pmcz002,pmcz003,pmcz004,pmcz005,pmcz006,pmcz023,indjseq
      #IF SQLCA.sqlcode = 100 THEN
      #   INITIALIZE g_errparam TO NULL 
      #   LET g_errparam.extend = "sel_pmcz"
      #   LET g_errparam.code   = SQLCA.sqlcode 
      #   LET g_errparam.popup  = TRUE
      #   CALL cl_err()
      #   LET r_success = FALSE
      #   RETURN r_success
      #END IF
      #161024-00023#4 20161026 mark by beckxie---E
      #161024-00023#4 20161026 add by beckxie---S
      #20161028---S
      #SELECT inbpseq,inbp004,inbp005,inbp006,inbp007
      #  INTO l_inbpseq,l_inbp004,l_inbp005,l_inbp006,l_inbp007
      #  FROM inbp_t
      # WHERE inbpent = g_enterprise
      #   AND inbpdocno = g_inbm_m.inbmdocno
      #   AND inbp005 = l_imay001
      #   AND inbp006 = COALESCE(l_imay019,' ')
      #   AND inbp007 = l_imay004
      #IF SQLCA.sqlcode = 100 THEN
      #   INITIALIZE g_errparam TO NULL 
      #   LET g_errparam.extend = "sel_inbp"
      #   LET g_errparam.code   = SQLCA.sqlcode 
      #   LET g_errparam.popup  = TRUE
      #   CALL cl_err()
      #   LET r_success = FALSE
      #   RETURN r_success
      #END IF
      #20161028---E
      #161213-00004#1 20161213 add by beckxie---S
      #若不存在於inbp_t,新增一筆單身
      LET l_cnt = 0
      SELECT COUNT(1) INTO l_cnt 
        FROM inbp_t
       WHERE inbpent = g_enterprise
         AND inbpdocno = g_inbm_m.inbmdocno
         AND inbp005 = l_imay001
         AND inbp006 = COALESCE(l_imay019,' ')
         AND inbp007 = l_imay004
      IF l_cnt = 0 THEN
         #新增一筆
         
         LET l_seq_max = 0
         SELECT COALESCE(MAX(inbpseq),0) INTO l_seq_max
           FROM inbp_t
          WHERE inbpent = g_enterprise
            AND inbpdocno = g_inbm_m.inbmdocno
            
         INITIALIZE l_inbp TO NULL 
         
         LET l_inbp.inbpent   = g_enterprise
         LET l_inbp.inbpsite  = g_inbm_m.inbmsite
         LET l_inbp.inbpdocno = g_inbm_m.inbmdocno
         
         #最大項次+1
         IF cl_null(l_seq_max) THEN
            LET l_seq_max = 1
         ELSE
            LET l_seq_max = l_seq_max + 1
         END IF
         LET l_inbp.inbpseq   = l_seq_max
         
         LET l_inbp.inbp001   = g_inbm_m.inbm003
         LET l_inbp.inbp002   = g_inbm_m.inbm004
         
         #aint701写入串色串码的时候，来源项次由为空，改为同来源单号，按流水号写入 20161215
         SELECT COALESCE(MAX(inbp003),0) INTO l_inbp.inbp003
           FROM inbp_t
          WHERE inbpent = g_enterprise
            AND inbpdocno = g_inbm_m.inbmdocno
            AND inbp002 = g_inbm_m.inbm004
         IF cl_null(l_inbp.inbp003) THEN
            LET l_inbp.inbp003 = 1
         ELSE
            LET l_inbp.inbp003 = l_inbp.inbp003 + 1
         END IF
         
         
         SELECT imay003 INTO l_inbp.inbp004
           FROM imay_t
          WHERE imayent = g_enterprise
            AND imay001 = l_imay001
            AND imay004 = l_imay004
            AND imay019 = l_imay019
            
         LET l_inbp.inbp005   = l_imay001            #料號
         LET l_inbp.inbp006   = l_imay019            #產品特徵
         LET l_inbp.inbp007   = l_imay004            #單位
         LET l_inbp.inbp008   = 0                    #應裝數量
         LET l_inbp.inbp009   = 0                    #已裝數量
         LET l_inbp.inbp010   = ''
         LET l_inbp.inbp011   = ''
         LET l_inbp.inbp012   = ''
         INSERT INTO inbp_t (inbpent,inbpsite,inbpdocno,inbpseq,inbp001,
                             inbp002, inbp003,  inbp004,inbp005,inbp006,
                             inbp007, inbp008,  inbp009,inbp010,inbp011,
                             inbp012)
                     VALUES (l_inbp.inbpent,l_inbp.inbpsite,l_inbp.inbpdocno,l_inbp.inbpseq,l_inbp.inbp001,
                             l_inbp.inbp002, l_inbp.inbp003,  l_inbp.inbp004,l_inbp.inbp005,l_inbp.inbp006,
                             l_inbp.inbp007, l_inbp.inbp008,  l_inbp.inbp009,l_inbp.inbp010,l_inbp.inbp011,
                             l_inbp.inbp012)
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "ins_inbp"
            LET g_errparam.code   = SQLCA.sqlcode 
            LET g_errparam.popup  = FALSE
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success
         END IF
      END IF
      
      #161213-00004#1 20161213 add by beckxie---E
      #該商品,產品特徵,單位 全部可扣量,全部可掃量
      SELECT SUM(inbp009),SUM(inbp008-inbp009) INTO l_sum_cost,l_sum_scan
        FROM inbp_t
       WHERE inbpent = g_enterprise
         AND inbpdocno = g_inbm_m.inbmdocno
         AND inbp005 = l_imay001
         AND inbp006 = COALESCE(l_imay019,' ')
         AND inbp007 = l_imay004
      #檢查本次掃入是否超過裝箱單可掃,可扣數量   
      CASE l_symbol
         WHEN '1' #加:掃入
            #如果本次掃入量>全部可掃量
            #IF g_inbm_m.l_num > l_sum_scan THEN   #161024-00023#22 20161202 mark by beckxie
            IF g_inbm_m.l_num > l_sum_scan AND g_inbm_m.inbm003 = '4' THEN   #161024-00023#22 20161202 add by beckxie
               #[本次掃碼數量:%1 ] 不可大於 此裝箱單 [商品：%2 ] [產品特徵：%3 ] [單位：%4 ] [全部可掃碼數量: %5 ]
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = ''
               LET g_errparam.code   = 'ain-00817' 
               #LET g_errparam.popup  = TRUE   #161024-00023#12 20161030 mark by beckxie
               LET g_errparam.popup  = FALSE   #161024-00023#12 20161030 add by beckxie
               LET g_errparam.replace[1] = g_inbm_m.l_num
               LET g_errparam.replace[2] = l_imay001
               LET g_errparam.replace[3] = l_imay019
               LET g_errparam.replace[4] = l_imay004
               LET g_errparam.replace[5] = l_sum_scan
               CALL cl_err()
               LET r_success = FALSE
               RETURN r_success
            END IF
         WHEN '-1' #減:
            #如果本次扣除量>全部可扣量
            IF g_inbm_m.l_num > l_sum_cost THEN
               #[本次扣除數量:%1 ] 不可大於 此裝箱單 [商品：%2 ] [產品特徵：%3 ] [單位：%4 ] [全部可扣除數量: %5 ]
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = ''
               LET g_errparam.code   = 'ain-00818' 
               #LET g_errparam.popup  = TRUE   #161024-00023#12 20161030 mark by beckxie
               LET g_errparam.popup  = FALSE   #161024-00023#12 20161030 add by beckxie
               LET g_errparam.replace[1] = g_inbm_m.l_num
               LET g_errparam.replace[2] = l_imay001
               LET g_errparam.replace[3] = l_imay019
               LET g_errparam.replace[4] = l_imay004
               LET g_errparam.replace[5] = l_sum_cost
               CALL cl_err()
               LET r_success = FALSE
               RETURN r_success
            END IF
      END CASE      
                                                                   #   該項次可掃入量,可扣除量
      LET l_sql = " SELECT inbpseq,inbp004,inbp005,inbp006,inbp007,(inbp008-inbp009),inbp009,inbp010",
                  "   FROM inbp_t ",
                  "  WHERE inbpent = ",g_enterprise,
                  "    AND inbpdocno = '",g_inbm_m.inbmdocno,"' ",
                  "    AND inbp005 = '",l_imay001,"' ",
                  "    AND inbp006 = COALESCE('",l_imay019,"',' ') ",
                  "    AND inbp007 = '",l_imay004,"' ",
                  "  ORDER BY inbpseq "   #161213-00004#1 20161213 add by beckxie
      PREPARE aint701_inbp_sel_pre FROM l_sql
      DECLARE aint701_inbp_sel_cur CURSOR FOR aint701_inbp_sel_pre
      
      LET l_num_all = g_inbm_m.l_num
      LET l_seq = ''
                                                                                      #該項次可掃入量,可扣除量
      FOREACH aint701_inbp_sel_cur INTO l_inbpseq,l_inbp004,l_inbp005,l_inbp006,l_inbp007,l_scan_tmp,l_cost_tmp,l_inbp010
         IF SQLCA.sqlcode = 100 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "sel_inbp"
            LET g_errparam.code   = SQLCA.sqlcode 
            #LET g_errparam.popup  = TRUE   #161024-00023#12 20161030 mark by beckxie
            LET g_errparam.popup  = FALSE   #161024-00023#12 20161030 add by beckxie
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success
         END IF
         
         CASE l_symbol
            WHEN '1' #加:掃入
               #161024-00023#22 20161202 add by beckxie---S
               IF g_inbm_m.inbm003 <> '4' AND l_scan_tmp < l_num_all THEN
                  #若還有其他項次的話,且本項次已裝完,就裝在下一筆
                  #161213-00004#1 20161213 add by beckxie
                  LET l_seq_max = 0
                  SELECT MAX(inbpseq) INTO l_seq_max
                    FROM inbp_t 
                   WHERE inbpent = g_enterprise
                     AND inbpdocno = g_inbm_m.inbmdocno
                     AND inbp005 = l_imay001
                     AND inbp006 = COALESCE(l_imay019,' ')
                     AND inbp007 = l_imay004
                     
                  #若已經是最後一筆,就繼續裝在這筆
                  IF l_seq_max = l_inbpseq THEN
                  #161213-00004#1 20161213 add by beckxie---E
                     LET l_scan_tmp = l_num_all
                  END IF   #161213-00004#1 20161213 add by beckxie
               END IF
               #161024-00023#22 20161202 add by beckxie---E
               #本項次可掃量=0時
               #IF l_scan_tmp = 0 THEN   #161213-00004#1 20161213 mark by beckxie
               IF l_scan_tmp <= 0 THEN   #161213-00004#1 20161213 add by beckxie
                  CONTINUE FOREACH
               END IF
               #如果本次掃入量大於該項次可掃入量
               IF l_num_all > l_scan_tmp THEN
                  LET l_inbo009 = l_scan_tmp
                  LET l_num_all = l_num_all-l_inbo009
               ELSE
                  LET l_inbo009 = l_num_all
                  LET l_num_all = l_num_all-l_inbo009 #0 l_num_all 待掃量為0 , 就不繼續FOREACH
               END IF
            WHEN '-1' #減:扣除
               #本項次可扣量=0時
               IF l_cost_tmp = 0 THEN
                  CONTINUE FOREACH
               END IF
               #如果本次扣除量大於該項次可扣除量
               IF l_num_all > l_cost_tmp THEN
                  LET l_inbo009 = l_cost_tmp
                  LET l_num_all = l_num_all-l_inbo009
               ELSE
                  LET l_inbo009 = l_num_all
                  LET l_num_all = l_num_all-l_inbo009 #0 l_num_all 待扣量為0 , 就不繼續FOREACH
               END IF
         END CASE
         #161024-00023#4 20161026 add by beckxie---E
         LET l_inbo.inboent   = g_enterprise
         LET l_inbo.inbosite  = g_inbm_m.inbmsite
         LET l_inbo.inbounit  = g_inbm_m.inbmunit
         LET l_inbo.inbodocno = g_inbm_m.inbmdocno
         LET l_inbo.inbo001   = g_inbn_d[g_detail_idx].inbn001
         
         SELECT MAX(inbo002)+1 INTO l_inbo.inbo002
           FROM inbo_t 
          WHERE inboent = g_enterprise 
            AND inbodocno = g_inbm_m.inbmdocno 
            AND inbo001 = g_inbn_d[g_detail_idx].inbn001
         IF cl_null(l_inbo.inbo002) THEN
            LET l_inbo.inbo002 = 1
         END IF
         #161024-00023#4 20161026 mark by beckxie---S
         #LET l_inbo.inbo003   = l_pmcz023   
         #LET l_inbo.inbo004   = l_pmcz001
         #LET l_inbo.inbo005   = l_pmcz002
         #LET l_inbo.inbo006   = l_pmcz004
         #LET l_inbo.inbo007   = l_pmcz005
         #LET l_inbo.inbo008   = l_pmcz006
         #LET l_inbo.inbo010   = l_pmcz003
         #LET l_inbo.inbo011   = l_indjseq
         #161024-00023#4 20161026 mark by beckxie---E
         #161024-00023#4 20161026 add by beckxie---S
         LET l_inbo.inbo006 = l_inbp005
         LET l_inbo.inbo007 = l_inbp006
         LET l_inbo.inbo008 = l_inbp007
         LET l_inbo.inbo009 = l_inbo009
         LET l_inbo.inbo010 = l_inbp004
         LET l_inbo.inbo011 = l_inbpseq
         #161024-00023#4 20161026 add by beckxie---E
         
         #檢查需新增一筆或更新數量
         SELECT COUNT(1) INTO l_cnt FROM inbo_t
          WHERE inboent = g_enterprise
            AND inbodocno = g_inbm_m.inbmdocno
            AND inbo001 = g_inbn_d[g_detail_idx].inbn001
            AND inbo011 = l_inbo.inbo011   #161024-00023#4 20161026 add by beckxie
            #161024-00023#4 20161026 mark by beckxie---S
            #AND inbo003 = l_inbo.inbo003
            #AND inbo004 = l_inbo.inbo004
            #AND inbo005 = l_inbo.inbo005
            #161024-00023#4 20161026 mark by beckxie---E
         IF l_cnt > 0 THEN 
            #已存在裝箱明細,更新裝箱明細數量
            UPDATE inbo_t SET inbo009 = inbo009+(l_inbo.inbo009*l_symbol)
             WHERE inboent = g_enterprise
               AND inbodocno = g_inbm_m.inbmdocno
               AND inbo001 = g_inbn_d[g_detail_idx].inbn001
               AND inbo011 = l_inbo.inbo011   #161024-00023#4 20161026 add by beckxie
               #161024-00023#4 20161026 mark by beckxie---S
               #AND inbo003 = l_inbo.inbo003
               #AND inbo004 = l_inbo.inbo004
               #AND inbo005 = l_inbo.inbo005
               #161024-00023#4 20161026 mark by beckxie---E
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "UPDATE inbo_t"
               LET g_errparam.code   = SQLCA.sqlcode 
               #LET g_errparam.popup  = TRUE   #161024-00023#12 20161030 mark by beckxie
               LET g_errparam.popup  = FALSE   #161024-00023#12 20161030 add by beckxie
               CALL cl_err()
               LET r_success = FALSE
               RETURN r_success
            END IF
         ELSE
            IF g_inbm_m.l_symbol ='1' THEN
               #欲刪除條碼[ %1 ]、商品[ %2 ] ，不存在於[裝箱明細中]！
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = ""
               LET g_errparam.code   = 'ain-00788' 
               LET g_errparam.replace[1] = g_inbm_m.inbo010_1
               LET g_errparam.replace[2] = l_imay001
               LET g_errparam.replace[3] = l_imay004
               #LET g_errparam.popup  = TRUE   #161024-00023#12 20161030 mark by beckxie
               LET g_errparam.popup  = FALSE   #161024-00023#12 20161030 add by beckxie
               CALL cl_err()
               LET r_success = FALSE
               RETURN r_success
            END IF
            #不存在裝箱明細,新增至裝箱明細中
            INSERT INTO inbo_t 
                       (inboent,inbosite,inbounit,inbodocno,inbo001,
                        #inbo002, inbo003, inbo004,  inbo005,inbo006,   #161024-00023#4 20161026 mark by beckxie
                        inbo002, inbo006,                               #161024-00023#4 20161026 add by beckxie
                        inbo007, inbo008, inbo009,  inbo010,inbo011)
                 VALUES(l_inbo.inboent,l_inbo.inbosite,l_inbo.inbounit,l_inbo.inbodocno,l_inbo.inbo001,
                        #l_inbo.inbo002, l_inbo.inbo003, l_inbo.inbo004,  l_inbo.inbo005,l_inbo.inbo006,   #161024-00023#4 20161026 mark by beckxie
                        l_inbo.inbo002, l_inbo.inbo006,                                                    #161024-00023#4 20161026 add by beckxie
                        l_inbo.inbo007, l_inbo.inbo008, l_inbo.inbo009,  l_inbo.inbo010,l_inbo.inbo011)
            
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "INSERT INTO inbo_t"
               LET g_errparam.code   = SQLCA.sqlcode 
               #LET g_errparam.popup  = TRUE   #161024-00023#12 20161030 mark by beckxie
               LET g_errparam.popup  = FALSE   #161024-00023#12 20161030 add by beckxie
               CALL cl_err()
               LET r_success = FALSE
               RETURN r_success
            END IF
         END IF
         #161024-00023#4 20161026 add by beckxie---S
         ##新增至temp table
         #SELECT MAX(seq)+1 INTO l_inbo.l_seq FROM aint701_inbo_temp 
         # WHERE inboent = g_enterprise 
         #   AND inbodocno = g_inbm_m.inbmdocno
         #   AND inbo001 = l_inbo.inbo001
         #IF cl_null(l_inbo.l_seq) THEN
         #   LET l_inbo.l_seq = 1
         #END IF
         #
         #INSERT INTO aint701_inbo_temp 
         #           (inboent,inbosite,inbounit,inbodocno,inbo001,
         #            inbo002,     seq, inbo006,
         #            inbo007, inbo008, inbo009,  inbo010,inbo011)
         #     VALUES(l_inbo.inboent,l_inbo.inbosite,        l_inbo.inbounit,l_inbo.inbodocno,l_inbo.inbo001,
         #            l_inbo.inbo002,   l_inbo.l_seq,         l_inbo.inbo006,
         #            l_inbo.inbo007, l_inbo.inbo008,l_inbo.inbo009*l_symbol,  l_inbo.inbo010,l_inbo.inbo011)
         #IF SQLCA.sqlcode THEN
         #   INITIALIZE g_errparam TO NULL 
         #   LET g_errparam.extend = "INSERT INTO aint701_inbo_temp"
         #   LET g_errparam.code   = SQLCA.sqlcode 
         #   LET g_errparam.popup  = TRUE
         #   CALL cl_err()
         #   LET r_success = FALSE
         #   RETURN r_success
         #END IF
         #161208-00023#5 20161209 add by beckxie---S
         #IF g_inbm_m.inbm003 = '5' OR g_inbm_m.inbm003 = '8' THEN   #161217-00002#4 20161223 mark by beckxie
         IF g_inbm_m.inbm003 = '5' OR g_inbm_m.inbm003 = '8' OR g_inbm_m.inbm003 = '9' THEN   #161217-00002#4 20161223 add by beckxie
            LET l_seq = ''
            SELECT seq INTO l_seq
              FROM aint701_inbo_temp
             WHERE inboent = g_enterprise 
               AND inbodocno = g_inbm_m.inbmdocno
               AND inbo001 = l_inbo.inbo001
               AND inbo006 = l_inbo.inbo006
               AND inbo007 = l_inbo.inbo007
               AND inbo008 = l_inbo.inbo008
         END IF
         #161208-00023#5 20161209 add by beckxie---E
         #新增至temp table
         IF cl_null(l_seq) THEN
            SELECT MAX(seq)+1 INTO l_seq FROM aint701_inbo_temp 
             WHERE inboent = g_enterprise 
               AND inbodocno = g_inbm_m.inbmdocno
               AND inbo001 = l_inbo.inbo001
            IF cl_null(l_seq) THEN
               LET l_seq = 1
            END IF
            
            INSERT INTO aint701_inbo_temp 
                       (inboent,inbosite,inbounit,inbodocno,inbo001,
                        inbo002,     seq, inbo006,
                        inbo007, inbo008, inbo009,  inbo010,inbo011)
                 VALUES(l_inbo.inboent,l_inbo.inbosite,        l_inbo.inbounit,l_inbo.inbodocno,l_inbo.inbo001,
                        l_inbo.inbo002,          l_seq,         l_inbo.inbo006,
                        l_inbo.inbo007, l_inbo.inbo008,l_inbo.inbo009*l_symbol,  l_inbo.inbo010,l_inbo.inbo011)
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "INSERT INTO aint701_inbo_temp"
               LET g_errparam.code   = SQLCA.sqlcode 
               #LET g_errparam.popup  = TRUE   #161024-00023#12 20161030 mark by beckxie
               LET g_errparam.popup  = FALSE   #161024-00023#12 20161030 add by beckxie
               CALL cl_err()
               LET r_success = FALSE
               RETURN r_success
            END IF
         ELSE
            UPDATE aint701_inbo_temp SET inbo009 = inbo009 + (l_inbo.inbo009*l_symbol)
             WHERE seq = l_seq
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "upd aint701_inbo_temp"
               LET g_errparam.code   = SQLCA.sqlcode 
               #LET g_errparam.popup  = TRUE   #161024-00023#12 20161030 mark by beckxie
               LET g_errparam.popup  = FALSE   #161024-00023#12 20161030 add by beckxie
               CALL cl_err()
               LET r_success = FALSE
               RETURN r_success
            END IF
         END IF
         #161024-00023#4 20161026 add by beckxie---E
         #若裝箱數量扣為0，則將該筆資料刪除
         DELETE FROM inbo_t
          WHERE inboent = g_enterprise
            AND inbodocno = g_inbm_m.inbmdocno
            AND inbo001 = g_inbn_d[g_detail_idx].inbn001
            AND inbo009 = 0
            AND inbo011 = l_inbo.inbo011   #161024-00023#4 20161026 add by beckxie
            #161024-00023#4 20161026 mark by beckxie---S
            #AND inbo003 = l_inbo.inbo003
            #AND inbo004 = l_inbo.inbo004
            #AND inbo005 = l_inbo.inbo005
            #161024-00023#4 20161026 mark by beckxie---E
            
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "del_inbo_t"
            LET g_errparam.code   = SQLCA.sqlcode 
            #LET g_errparam.popup  = TRUE   #161024-00023#12 20161030 mark by beckxie
            LET g_errparam.popup  = FALSE   #161024-00023#12 20161030 add by beckxie
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success
         END IF
         
         #161024-00023#4 20161026 mark by beckxie---S
         ##異動完成:更新pmcz064已裝箱量
         #UPDATE pmcz_t SET pmcz064 = COALESCE(pmcz064,0)+(l_inbo.inbo009*l_symbol)
         # WHERE pmczent = g_enterprise
         #   AND pmcz001 = l_inbo.inbo004
         #   AND pmcz002 = l_inbo.inbo005
         #   AND pmcz062 = g_inbm_m.inbm001
         #   
         #IF SQLCA.sqlcode THEN
         #   INITIALIZE g_errparam TO NULL 
         #   LET g_errparam.extend = "UPDATE pmcz_t"
         #   LET g_errparam.code   = SQLCA.sqlcode 
         #   LET g_errparam.popup  = TRUE
         #   CALL cl_err()
         #   LET r_success = FALSE
         
         #   RETURN r_success
         #END IF
         #161024-00023#4 20161026 mark by beckxie---E
         #161024-00023#4 20161026 add by beckxie---S
         #異動完成:更新inbp009已裝箱量
         UPDATE inbp_t SET inbp009 = COALESCE(inbp009,0)+(l_inbo.inbo009*l_symbol)
          WHERE inbpent = g_enterprise
            AND inbpdocno = g_inbm_m.inbmdocno
            AND inbpseq = l_inbo.inbo011
            
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.extend = "UPDATE inbp009"
            LET g_errparam.code   = SQLCA.sqlcode 
            #LET g_errparam.popup  = TRUE   #161024-00023#12 20161030 mark by beckxie
            LET g_errparam.popup  = FALSE   #161024-00023#12 20161030 add by beckxie
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success
         END IF
         #161024-00023#4 20161026 add by beckxie---E
         #170104-00068#1 20170105 add by beckxie---S
         #若新增一筆inbp008 = 0 的項次,代表為串色串碼,將flag,串色串碼=是
         LET g_flag = FALSE   #初始化串色串碼=否
         LET l_cnt = 0
         SELECT COUNT(1) INTO l_cnt 
           FROM inbp_t
          WHERE inbpent = g_enterprise
            AND inbpdocno = g_inbm_m.inbmdocno
            AND inbpseq = l_inbo.inbo011
            AND inbp008 = 0
         IF l_cnt != 0 THEN
            LET g_flag = TRUE
         END IF
         #170104-00068#1 20170105 add by beckxie---E
         #161213-00004#1 20161214 add by beckxie---S
         #更新inbp_t後，針對來源項次是空的，如果來源項次是空，並且已裝箱量為0，則刪除此筆inbp
         #來源項次為空改為应装数量为0的判断 20161216
         LET l_cnt = 0
         SELECT COUNT(1) INTO l_cnt 
           FROM inbp_t
          WHERE inbpent = g_enterprise
            AND inbpdocno = g_inbm_m.inbmdocno
            AND inbpseq = l_inbpseq
            #AND inbp003 IS NULL
            AND inbp008 = 0
            AND inbp009 = 0
         IF l_cnt != 0 THEN
            DELETE FROM inbp_t
             WHERE inbpent = g_enterprise
               AND inbpdocno = g_inbm_m.inbmdocno
               AND inbpseq = l_inbpseq
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "del inbp_t"
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = FALSE   
               CALL cl_err()
               LET r_success = FALSE
               RETURN r_success
            END IF
         END IF
         #161213-00004#1 20161214 add by beckxie---E
         #161024-00023#11 20161030 add by beckxie---S
         #更新inbp_t後,仍然需要更新需求匯總pmcz_t 已裝箱量
         IF NOT cl_null(l_inbp010) THEN
            #異動完成:更新pmcz064已裝箱量
            SELECT   inbpsite,  inbp009,  inbp010,  inbp011,  inbp012 
              INTO l_pmczsite,l_pmcz064,l_pmcz023,l_pmcz001,l_pmcz002
              FROM inbp_t 
             WHERE inbpent = g_enterprise 
               AND inbpdocno = g_inbm_m.inbmdocno
               AND inbpseq = l_inbo.inbo011
                 
            #已装箱量[pmcz064]=已装箱量[pmcz064]+扫码数量*异动方向（+乘以1，减乘以-1）
            #UPDATE pmcz_t SET pmcz064 = l_pmcz064                                      #161220-00037#3 20161222 mark by beckxie
            UPDATE pmcz_t SET pmcz064 = COALESCE(pmcz064,0)+(l_inbo.inbo009*l_symbol)   #161220-00037#3 20161222  add by beckxie
             WHERE pmczent = g_enterprise
#               AND pmczsite = l_pmczsite     #161024-00023#14 by 08172 
               AND pmcz001 = l_pmcz001
               AND pmcz002 = l_pmcz002
               AND pmcz023 = l_pmcz023
               
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "UPDATE pmcz_t"
               LET g_errparam.code   = SQLCA.sqlcode 
               #LET g_errparam.popup  = TRUE   #161024-00023#12 20161030 mark by beckxie
               LET g_errparam.popup  = FALSE   #161024-00023#12 20161030 add by beckxie
               CALL cl_err()
               LET r_success = FALSE
            
               RETURN r_success
            END IF
         END IF
         #161024-00023#11 20161030 add by beckxie---E
         #若待分配入量=0(全部分配完),離開
         IF l_num_all = 0 THEN
            EXIT FOREACH
         END IF 
      END FOREACH
      
   ELSE
      #解析失敗
      LET r_success = FALSE
      RETURN r_success
   END IF
   #161213-00004#1 20161213 mark by beckxie---S
   ##161208-00023#5 20161209 add by beckxie---S
   ###SA要求實時寫入,所以異動後寫入並重新開啟事務
   #IF s_transaction_chk('Y','0') THEN
   #   DISPLAY "g_intrans"
   #   CALL s_transaction_end('Y','0')
   #   CALL s_transaction_begin()
   #END IF
   ##161208-00023#5 20161209 add by beckxie---E
   #161213-00004#1 20161213 mark by beckxie---E
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: inbn_t預設值
# Memo...........:
# Usage..........: CALL aint701_inbn_init()
# Input parameter: 無
# Return code....: 無
# Date & Author..: 20160908 add by beckxie
# Modify.........:
################################################################################
PRIVATE FUNCTION aint701_inbn_init()
   
   IF l_ac >0 THEN
      LET g_inbn_d[l_ac].inbn002 = "1"
      LET g_inbn_d[l_ac].inbnsite = g_inbm_m.inbmsite
      LET g_inbn_d[l_ac].inbnunit = g_inbm_m.inbmunit
      SELECT MAX(inbn001) INTO g_inbn_d[l_ac].inbn001
        FROM inbn_t WHERE inbnent = g_enterprise AND inbndocno = g_inbm_m.inbmdocno
      IF cl_null(g_inbn_d[l_ac].inbn001) THEN
         LET g_inbn_d[l_ac].inbn001 = "B1001"
      ELSE
         #CALL aint701_inbn001_init(g_inbn_d[l_ac].inbn001) RETURNING g_inbn_d[l_ac].inbn001   #161017-00051#15 20161201 mark by beckxie
         CALL aint701_inbn001_init() RETURNING g_inbn_d[l_ac].inbn001   #161017-00051#15 20161201 add by beckxie
      END IF
      DISPLAY g_inbn_d[l_ac].inbn001 TO inbn001_1
      DISPLAY g_inbn_d[l_ac].inbn001 TO inbn001
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 由l_ac+1往下找資料筆數inbn002為1的資料筆數位置
# Memo...........:
# Usage..........: CALL aint701_find()
#                  RETURNING r_ac
# Input parameter: 無
# Return code....: r_ac   筆數位置
# Date & Author..: 20160908 add by beckxie
# Modify.........:
################################################################################
PRIVATE FUNCTION aint701_find()
   DEFINE l_i        LIKE type_t.num5
   DEFINE r_ac       LIKE type_t.num5
   
   LET r_ac = ''
   
   #IF l_ac > g_inbn_d.getlength() THEN
   #   RETURN r_ac
   #END IF
   #由第一筆資料往下找,inbn002箱狀態 為1.未封箱的資料筆數位置
   FOR l_i = 1 TO g_inbn_d.getlength()
      IF g_inbn_d[l_i].inbn002 = '1' THEN
         LET r_ac = l_i
         RETURN r_ac
      END IF
   END FOR
   #刪除FOR虛增的一筆資料
   #找完結果沒有新的一筆,代表需新增一筆
   LET r_ac = l_i
   
   RETURN r_ac
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL aint701_inbn001_init()
#                  RETURNING r_inbn001
# Input parameter: 
# Return code....: r_inbn001      新箱號
# Date & Author..: 20160908 add by beckxie
# Modify.........: 將傳入參數:p_inbn001 移除 #161017-00051#15 20161201 add by beckxie
################################################################################
PRIVATE FUNCTION aint701_inbn001_init()
   DEFINE p_inbn001          LIKE inbn_t.inbn001
   DEFINE l_str              STRING
   DEFINE l_str1             STRING
   DEFINE l_inbn001          LIKE inbn_t.inbn001   #161017-00051#15 20161201 add by beckxie
   DEFINE l_str2             STRING
   DEFINE r_inbn001          LIKE inbn_t.inbn001
   
   #161017-00051#15 20161201 add by beckxie---S
   SELECT MAX(inbn001) INTO l_inbn001
                       FROM inbn_t
                      WHERE inbnent = g_enterprise
                        AND inbndocno = g_inbm_m.inbmdocno
   #161017-00051#15 20161201 add by beckxie---E
   #LET l_str = p_inbn001  #161017-00051#15 20161201 mark by beckxie
   IF cl_null(l_inbn001) THEN
      LET r_inbn001 = "B1001"
   ELSE
      LET l_str = l_inbn001   
   #161017-00051#15 20161201 add by beckxie---E
      LET l_str1 = l_str.subString(2,l_str.getlength())+1
      LET l_str2 = l_str.getCharAt(1)
      LET r_inbn001 = l_str2.trim() CLIPPED,l_str1.trim() USING "####"
   
   END IF   #161017-00051#15 20161201 add by beckxie
   RETURN r_inbn001
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
PRIVATE FUNCTION aint701_seal_box()
   DEFINE l_cnt   LIKE type_t.num5
   DEFINE l_cnt1  LIKE type_t.num5
   LET g_temp_init_flag = TRUE   #161017-00051#15 20161201 add by beckxie
   LET g_inbm_m.inbn001_1 = g_inbn_d[g_detail_idx].inbn001
   DISPLAY BY NAME g_inbm_m.inbn001_1
   #封箱
   IF NOT cl_null(g_inbm_m.inbmdocno) AND NOT cl_null(g_inbm_m.inbn001_1) THEN
      CALL aint701_02(g_inbm_m.inbmdocno,g_inbm_m.inbn001_1)
      LET INT_FLAG = 0
      CALL aint701_set_act_visible()
      CALL aint701_set_act_no_visible()
      CALL aint701_b_fill()
   END IF
   #找尋該跳至哪一筆
   LET l_cnt = ''
   LET l_cnt1 = g_inbn_d.getlength() #原長度
   CALL aint701_find() RETURNING l_cnt
   IF NOT cl_null(l_cnt) THEN
      LET g_detail_idx = l_cnt
   END IF
   #如果欲跳轉到的筆數到大於最後一筆,且待裝明細有資料需新增下一筆
   IF g_detail_idx > l_cnt1 THEN
      IF g_inbn3_d.getlength() > 0 THEN   #待裝明細有資料
         #CALL aint701_inbn001_init(g_inbn_d[g_detail_idx-1].inbn001) RETURNING g_inbn_d[g_detail_idx].inbn001   #161017-00051#15 20161201 mark by beckxie
         CALL aint701_inbn001_init() RETURNING g_inbn_d[g_detail_idx].inbn001   #161017-00051#15 20161201 add by beckxie
         IF NOT cl_null(g_inbn_d[g_detail_idx].inbn001) THEN
            INSERT INTO inbn_t (inbnent,inbnsite,inbnunit,inbndocno,inbn001,inbn002)
            VALUES (g_enterprise,g_inbm_m.inbmsite,g_inbm_m.inbmsite,g_inbm_m.inbmdocno,g_inbn_d[g_detail_idx].inbn001,'1')
            IF SQLCA.SQLcode THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = "ins_inbn_t"
               LET g_errparam.code   = SQLCA.sqlcode 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
            END IF
            CALL aint701_b_fill()
         END IF
      END IF
   END IF
END FUNCTION

################################################################################
# Descriptions...: 建立temp table(為了裝箱明細inbo_t需要的序號)
# Memo...........:
# Usage..........: CALL aint701_create_temp()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success TRUE/FALSE
# Date & Author..: #161024-00023#4 20161025 add by beckxie
# Modify.........:
################################################################################
PRIVATE FUNCTION aint701_create_temp()
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_session   LIKE type_t.num10
   
   LET r_success = TRUE
   WHENEVER ERROR CONTINUE   
   
   #目前SESSIONID
   LET l_session = ''
   SELECT USERENV('SESSIONID') INTO l_session FROM DUAL
   DISPLAY "[session_id:] ",l_session
   
   IF NOT aint701_drop_temp() THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   CREATE TEMP TABLE aint701_inbo_temp(
                     inboent   LIKE inbo_t.inboent,   #企業編號
                     inbosite  LIKE inbo_t.inbosite,  #營運據點
                     inbounit  LIKE inbo_t.inbounit,  #物流中心
                     inbodocno LIKE inbo_t.inbodocno, #單據編號
                     inbo001   LIKE inbo_t.inbo001,   #箱號
                     inbo002   LIKE inbo_t.inbo002,   #項次
                     seq       LIKE type_t.num10,     #錄入次序
                     inbo003   LIKE inbo_t.inbo003,   #來源需求類型
                     inbo004   LIKE inbo_t.inbo004,   #來源需求單號
                     inbo005   LIKE inbo_t.inbo005,   #來源需求項次
                     inbo006   LIKE inbo_t.inbo006,   #商品編碼
                     inbo007   LIKE inbo_t.inbo007,   #產品特征
                     inbo008   LIKE inbo_t.inbo008,   #單位
                     inbo009   LIKE inbo_t.inbo009,   #裝箱數量
                     inbo010   LIKE inbo_t.inbo010,   #條碼
                     inbo011   LIKE inbo_t.inbo011    #來源項次
   )
      
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'Create aint701_inbo_temp'
      #LET g_errparam.popup  = TRUE   #161024-00023#12 20161030 mark by beckxie
      LET g_errparam.popup  = FALSE   #161024-00023#12 20161030 add by beckxie
      LET r_success = FALSE
      RETURN r_success
   END IF
   
   RETURN r_success
END FUNCTION
################################################################################
# Descriptions...: drop temp table(為了裝箱明細inbo_t需要的序號)
# Memo...........:
# Usage..........: CALL aint701_drop_temp()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success TRUE/FALSE
# Date & Author..: #161024-00023#4 20161025 add by beckxie
# Modify.........:
################################################################################
PRIVATE FUNCTION aint701_drop_temp()
   DEFINE r_success   LIKE type_t.num5
   
   LET r_success = TRUE
   WHENEVER ERROR CONTINUE   
   
   DROP TABLE aint701_inbo_temp
   IF NOT (SQLCA.sqlcode = 0 OR SQLCA.sqlcode = -206) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'drop aint701_inbo_temp'
      #LET g_errparam.popup  = TRUE   #161024-00023#12 20161030 mark by beckxie
      LET g_errparam.popup  = FALSE   #161024-00023#12 20161030 add by beckxie
      LET r_success = FALSE
      RETURN r_success
   END IF
  
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 塞入temp table
# Memo...........:
# Usage..........: CALL aint701_temp_init()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success TRUE/FALSE
# Date & Author..: 20161026 add by beckxie
# Modify.........:
################################################################################
PRIVATE FUNCTION aint701_temp_init()
   #161024-00023#4 20161026 add by beckxie---S
   DEFINE r_success LIKE type_t.num5
   DEFINE l_sql     STRING 
   
   LET r_success = TRUE 
   LET g_temp_init_flag = FALSE
   #刪除
   DELETE FROM aint701_inbo_temp 
   #塞值
   IF g_detail_idx > 0 THEN 
      LET l_sql = "INSERT INTO aint701_inbo_temp ",
                  "          (inboent,inbosite,inbounit,inbodocno,inbo001, ",
                  "               seq, inbo006,inbo007, inbo008, inbo009, ",
                  "           inbo010) ",
                  " SELECT    inboent,inbosite,inbounit,inbodocno,inbo001, ",
                  "        DENSE_RANK() OVER(PARTITION BY inbo001 ORDER BY inboent,inbosite,inbounit,inbodocno,inbo001,inbo006,inbo007,inbo008), ",
                  "        inbo006,inbo007, inbo008,s_inbo009, ",
                  "           inbo010 ",
                  "   FROM ( SELECT inboent,inbosite,inbounit,inbodocno,inbo001, ",
                  "                 inbo006,inbo007, inbo008, SUM(inbo009) s_inbo009, ",
                  "                 inbo010 ",
                  "            FROM inbo_t,inbn_t ",
                  "           WHERE inbnent = inboent ",
                  "             AND inbndocno = inbodocno ",
                  "             AND inbn001 = inbo001  ",
                  "             AND inboent = ",g_enterprise,
                  "             AND inbodocno = '",g_inbm_m.inbmdocno,"' ",
                  "             AND inbn002 = '1' ",
                  "           GROUP BY inboent,inbosite,inbounit,inbodocno,inbo001, ",
                  "                    inbo006, inbo007, inbo008,inbo010) "
      
      PREPARE aint701_temp_init_pre FROM l_sql
      EXECUTE aint701_temp_init_pre
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "INSERT INTO aint701_inbo_temp"
         LET g_errparam.code   = SQLCA.sqlcode 
         #LET g_errparam.popup  = TRUE   #161024-00023#12 20161030 mark by beckxie
         LET g_errparam.popup  = FALSE   #161024-00023#12 20161030 add by beckxie
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
   END IF
   
   RETURN r_success
   #161024-00023#4 20161026 add by beckxie---E
END FUNCTION

PRIVATE FUNCTION aint701_set_comp_visible_b()
   CALL cl_set_comp_visible("l_seq", TRUE)   #161024-00023#4 20161026 add by beckxie
   #161208-00023#3 20161208 add by beckxie---S
   CALL cl_set_comp_visible("indj012,indj012_desc,indj013,indj013_desc", TRUE)
   #CALL cl_set_comp_visible("indj015,indj015_desc,indj016,indj016_desc", TRUE)   #161213-00022#2 20161215 mark by beckxie
   #161208-00023#3 20161208 add by beckxie---E
END FUNCTION

PRIVATE FUNCTION aint701_set_comp_no_visible_b()
   #161024-00023#4 20161026 add by beckxie---S
   IF g_detail_idx > 0 THEN
      IF g_inbn_d[g_detail_idx].inbn002 = '2' THEN    #等於已封箱時,必須隱藏掃碼順序
        CALL cl_set_comp_visible("l_seq", FALSE) 
      END IF
   END IF
   #161024-00023#4 20161026 add by beckxie---E
   #161213-00022#2 20161215 mark by beckxie---S
   ##161208-00023#3 20161208 add by beckxie---S
   #IF g_inbm_m.inbm003 !='4' THEN   
   #   CALL cl_set_comp_visible("indj012,indj012_desc,indj013,indj013_desc", FALSE)
   #   CALL cl_set_comp_visible("indj015,indj015_desc,indj016,indj016_desc", FALSE)
   #END IF
   ##161208-00023#3 20161208 add by beckxie---E
   #161213-00022#2 20161215 mark by beckxie---E
   #161213-00022#2 20161215 add by beckxie---S
   IF g_inbm_m.inbm003 ='5' OR g_inbm_m.inbm003 ='7' OR g_inbm_m.inbm003 ='8' THEN   
      CALL cl_set_comp_visible("indj012,indj012_desc,indj013,indj013_desc", FALSE) #發貨庫位,儲位
   END IF
   #161213-00022#2 20161215 add by beckxie---E
END FUNCTION

################################################################################
# Descriptions...: 將最新一筆無資料的箱號刪除
# Memo...........:
# Usage..........: CALL aint701_delete_inbn()
#                  RETURNING r_success
# Input parameter: 
# Return code....: r_success  TRUE/FALSE
# Date & Author..: 20161201 add by beckxie
# Modify.........:
################################################################################
PRIVATE FUNCTION aint701_delete_inbn()
   DEFINE l_cnt       LIKE type_t.num5
   DEFINE l_inbn001   LIKE inbn_t.inbn001
   DEFINE r_success   LIKE type_t.num5
   
   LET r_success = TRUE
   
   LET l_inbn001 = 0
   SELECT MAX(inbn001) INTO l_inbn001 
     FROM inbn_t 
    WHERE inbnent = g_enterprise 
      AND inbndocno = g_inbm_m.inbmdocno
   
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt
     FROM inbo_t
    WHERE inboent = g_enterprise
      AND inbodocno = g_inbm_m.inbmdocno
      AND inbo001 = l_inbn001
   IF l_cnt = 0 THEN
      
      DELETE FROM inbn_t
       WHERE inbnent = g_enterprise
         AND inbndocno = g_inbm_m.inbmdocno
         AND inbn001 = l_inbn001
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL 
         LET g_errparam.extend = "DELETE FROM inbn_t"
         LET g_errparam.code   = SQLCA.sqlcode 
         LET g_errparam.popup  = FALSE   
         CALL cl_err()
         LET r_success = FALSE
         RETURN r_success
      END IF
      
   END IF
   
   
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 兩個按鈕,列印裝箱清單與匯總單
# Memo...........:
# Usage..........: CALL aint701_print(p_type)
# Input parameter: p_type    1:清單(呼叫aint701_g01) 2:匯總(呼叫aint701_g02)
# Return code....: 無
# Date & Author..: #170119-00027#1 20170120 add by beckxie
# Modify.........:
################################################################################
PRIVATE FUNCTION aint701_print(p_type)
   DEFINE p_type        LIKE type_t.chr1   #1:清單(呼叫aint701_g01) 2:匯總(呼叫aint701_g02)
   DEFINE l_print_wc    STRING  
   
   CASE p_type
      WHEN '1'   #1:清單(呼叫aint701_g01) 
         LET g_action_choice="quickprint"
         LET l_print_wc = " inbment ="|| g_enterprise ||" AND inbmdocno ='"|| g_inbm_m.inbmdocno||"' AND inbn001 ='"||g_inbm_m.inbn001_1||"' "
         CALL aint701_g01(l_print_wc)
         LET g_action_choice="print_g01"
      WHEN '2'   #2:匯總(呼叫aint701_g02)
         LET g_action_choice="quickprint"
         LET l_print_wc = " inbment ="|| g_enterprise ||" AND inbmdocno ='"|| g_inbm_m.inbmdocno||"'"
         CALL aint701_g02(l_print_wc,g_inbm_m.inbm008,g_inbm_m.inbm003)
         LET g_action_choice="print_g02"
   END CASE
   
END FUNCTION

 
{</section>}
 
