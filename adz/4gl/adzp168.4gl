#r.c adzp168;
#r.c adzp168_01;
#r.c adzp168_stus;
#r.c sadzp168_1;
#r.c sadzp168_2;
#r.c sadzp168_3;
#r.c sadzp168_4fd;
#cd $ADZ/42m;
#fgl2p -o ../42r/adzp168.42r WSHelper.42m libgre.42x adz_adzp168.42m adz.42x azz.42x lib.42x lng.42x qry.42x sub.42x adz_adzp168_01.42m adz_adzp168_stus.42m adz_sadzp168_4fd.42m adz_sadzp168_1.42m adz_sadzp168_2.42m adz_sadzp168_3.42m;
#cd ../4gl;


#+ Version..: T100-ERP-1.00.00(版次:1) Build-000720
#+
#+ Filename...: adzp168
#+ Description: 畫面產生器
#+ Creator....: tsai_yen(12/11/20)
#+ Buildtype..:
#+ Modifier...:                    2013/07/16 1.cdfSite可拉到畫面,但非必選
#                                             2.狀態碼不開放讓使用者加入"查詢方案",因為程式會自動產生
#+ Modifier...:                    2013/07/30 空框架畫面檔:1.必為空框架程式碼; 2.不可有資料瀏覽區塊
#+ Modifier...:                    2013/08/12 子程式0812
#+ Modifier...:                    2013/08/14 假雙檔PK
#+ Modifier...:                    2013/08/26 銀和希望加入資料表的時候 不要卡住一定要有共用欄位才可以進入
#+ Modifier...:                    2013/08/13 底稿
#+ Modifier...:                    2013/08/29 [便利] 畫面結構刪除欄位操作
#+ Modifier...:                    2013/08/30 主程式在拉入Table後，視版型自動新增page_info及帶入共用欄位
#+ Modifier...:                    2013/09/17 (2-2-2-5)資料表設定:多檔資料表設定(只能由單頭主Table往下延伸，最多只能加到第三層)
#+ Modifier...:                    2013/12/06 (2-2-2-2)查詢作業版型設定 Q類的Tree未定案,先只做F類的:#檢查是否需要設Tree的相關設定
#+ Modifier...: No.FUN-131216      2013/12/16 (2-2-2-2)查詢作業版型設定 暫時配合4gl產生器只開放:Q類單身切割框架為"不切割",單身框架為"Table" 4fd先移除"Tree"的選項
#+ Modifier...:                    2013/12/16 Hiko 異動schema : 1.移除dzah_t 2.增加dzam_t
#+ Modifier...:                    2013/12/16 加上controlg
#+ Modifier...:                    2013/12/24 單身框架 改成ComboBox,依樣版使用不同選項
#+ Modifier...:                    2014/01/18 mark cl_qbe相關
#+ Modifier...:                    2014/01/22 Hiko: 1.dzag007是否為單頭Table Y/N,主表判斷是否為單頭Table (單檔、雙檔、假雙檔)
#                                                   2.dzfs010等於dzfq010
#                                                   3.dzfs009是否連動: r.a都預設為'Y'; 但若dzfs010='Tree'或dzfs003='s_browse'(查詢方案是Table)時,則dzfs009='N'
#+ Modifier...:                    2014/01/27 HJ: dzfq013資料來自gzde006,且不可在r.a維護. 代碼變更(m->a:全功能/ i->b:INPUT / c:CONSTRUCT)
#+ Modifier...:                    2014/02/11 不再產生程式，程式由設計器處理。暫時先以LET g_dzfq_m.dzfq015 = "Y" 快速產生
#+ Modifier...:                    2014/05/13 不再判斷程式是否為Free Style
#+ Modifier...:                    2014/05/23 客戶代號dzax005,dzag011,dzfs011,dzff009
#+ Modifier...: No.FUN-140605      2014/06/05 P003_00 ex. apmp490
#+ Modifier...: No.FUN-140923      2014/09/23 規格版次dzaa002,識別碼版次dzaa004 欄位型態改數值,相關欄位與變數都要改型態
#+ Modifier...:                    2014/10/07 保留參數個數dzax007,預設NULL
#+ Modifier...: No.FUN-141120      2014/11/20 挑選欄位支援多選方式
#+ Modifier...: No.FUN-150228      2015/02/28 子畫面可以自行選擇是否要空框架畫面檔;子畫面F005_00必為多筆mq;子畫面沒有P002和Q002
#+ Modifier...: No.160329-00027#1  2016/03/29 行業別管制維護.依附於需求單160323-00027#1
#                                             (0)：可r.a
#                                             (1)：標準環境不可以開發行業程式(ex:aiti001_ph、biti001_ph)
#                                             (2)：行業環境不可以開發標準程式(ex:aiti001)
#                                             (3)：行業環境下此程式為強制引用,得透過adzp600來產生
#                                             非空框架畫面,沒設定欄位就要產生畫面,顯示錯誤訊息：請先完成欄位設定
#+ Modifier...: No.160707-00028#1  2016/07/07 r.a樣版類型切換時要先設是否為空框架,再產生畫面結構

#CREATE TEMP TABLE adzp168_form_tmp   -> adzp168t1
#CREATE TEMP TABLE adzp168_col_tmp    -> adzp168t2
#CREATE TEMP TABLE adzp168_dzff_tmp   -> adzp168t3

IMPORT os

SCHEMA ds

GLOBALS "../../cfg/top_global.inc"
GLOBALS "../4gl/adzp168_global.inc"

SCHEMA ds

PRIVATE TYPE type_g_column RECORD    #欄位列表
   b_sel            LIKE type_t.chr1,       #挑選
   b_pk             STRING,                 #Primary Key
   b_fk             STRING,                 #Foreign Key
   b_colid          LIKE dzeb_t.dzeb002,    #節點名稱: 欄位代碼
   b_colname        LIKE dzebl_t.dzebl003,  #欄位名稱
   b_fk_tb          LIKE dzed_t.dzed005,    #外來鍵表格
   b_dzeb022        LIKE dzeb_t.dzeb022,    #屬於哪一種欄位定義代碼(dzek001)
   b_dzekgrp        LIKE dzek_t.dzek001,    #欄位定義代碼群組grpUIBelong/grpUIStateinfo
   b_ptableid       LIKE dzea_t.dzea001,    #資料表代碼-父
   b_tableid        LIKE dzeb_t.dzeb001,    #資料表代碼
   b_dzef008        LIKE dzef_t.dzef008,    #參考欄位
   b_dzer007        LIKE dzer_t.dzer007     #多語言欄位
   END RECORD
PRIVATE TYPE type_g_column_att RECORD       #欄位列表顏色屬性,已使用的欄位要變色
   b_sel            STRING,
   b_pk             STRING,
   b_fk             STRING,
   b_colid          STRING,
   b_colname        STRING,
   b_fk_tb          STRING,
   b_dzeb022        STRING,
   b_dzekgrp        STRING,
   b_ptableid       STRING,
   b_tableid        STRING
   END RECORD

TYPE type_g_form_col RECORD
      arridx        INTEGER,       #array index: for 欄位

      rootarea      VARCHAR(20),   #所屬區塊vb_master,vb_detail,vb_detailexp
      cont_tag      VARCHAR(20),   #4fd tag 類型: for container
      cont_tagname  VARCHAR(40),   #4fd tag name: for container

      row_seq       INTEGER,       #順序(同階層中的排序): for ScrollGrid row

      dzfr003       INTEGER,       #編號(流水號): for 欄位
      dzfr004       INTEGER,       #父節點編號
      dzfr005       INTEGER,       #順序(同階層中的排序): for 欄位
      dzfr009       VARCHAR(15),   #資料表代碼
      dzfr010       VARCHAR(20),   #欄位代碼

      dzfr011       VARCHAR(1),    #是否可刪除
      dzfr012       VARCHAR(40),   #4fd tag name前置名稱(s_detail/folder_/page_/page_info_/group_/Grid/HBox/VBox)
      dzeb004       VARCHAR(1),    #primary key
      dzeb022       VARCHAR(50),   #屬於哪一種欄位定義代碼(dzek001)
      dzekgrp       VARCHAR(50),   #欄位定義代碼群組grpUIBelong/grpUIStateinfo
      gzzd005       VARCHAR(200),  #畫面元件多語言 by g_lang
      dzef008       VARCHAR(80),   #參考欄位
      dzer007       VARCHAR(80),   #多語言欄位

      dzep009       INTEGER,       #欄位顯示寬度
      widget_hight  INTEGER,       #欄位顯示高度
      prog_ins      VARCHAR(20)    #新增資料的程式
      END RECORD

DEFINE g_dzfq003_t     LIKE dzfq_t.dzfq003
DEFINE g_dzfq004_t     LIKE dzfq_t.dzfq004

DEFINE g_dzfr_d        DYNAMIC ARRAY OF type_g_dzfr_d
DEFINE g_dzfr_d_t      type_g_dzfr_d

DEFINE g_browser    DYNAMIC ARRAY OF RECORD    #資料瀏覽之欄位
         b_statepic  LIKE type_t.chr50,
         b_dzfq003   LIKE dzfq_t.dzfq003,
         b_dzfq004   LIKE dzfq_t.dzfq004,
         rank        LIKE type_t.num10
      END RECORD

DEFINE g_wc                  STRING
DEFINE g_wc2                 STRING                        #單身CONSTRUCT結果

DEFINE g_sql                 STRING
DEFINE g_forupd_sql          STRING
DEFINE g_before_input_done   LIKE type_t.num5
DEFINE g_cnt                 LIKE type_t.num10
DEFINE g_current_idx         LIKE type_t.num10
DEFINE g_jump                LIKE type_t.num10
DEFINE g_no_ask              LIKE type_t.num5
DEFINE g_rec_b               LIKE type_t.num5
DEFINE l_ac                  LIKE type_t.num5
DEFINE g_curr_diag           ui.Dialog                     #Current Dialog

DEFINE g_pagestart           LIKE type_t.num5
DEFINE gwin_curr             ui.Window                     #Current Window
DEFINE gfrm_curr             ui.Form                       #Current Form
DEFINE g_page_action         STRING                        #page action
DEFINE g_header_hidden       LIKE type_t.num5              #隱藏單頭
DEFINE g_worksheet_hidden    LIKE type_t.num5              #隱藏工作Panel
DEFINE g_page                STRING                        #第幾頁

DEFINE g_detail_cnt          LIKE type_t.num5              #單身總筆數
DEFINE g_detail_idx          LIKE type_t.num5              #單身目前所在筆數
DEFINE g_browser_cnt         LIKE type_t.num5              #Browser總筆數
DEFINE g_browser_idx         LIKE type_t.num5              #Browser目前所在筆數
DEFINE g_temp_idx            LIKE type_t.num5              #Browser目前所在筆數(暫存用)

DEFINE g_searchcol           STRING                        #查詢欄位代碼
DEFINE g_searchstr           STRING                        #查詢欄位字串
DEFINE g_order               STRING                        #查詢排序欄位

DEFINE g_current_row         LIKE type_t.num5              #Browser所在筆數
DEFINE g_current_sw          BOOLEAN                       #Browser所在筆數用開關
DEFINE g_current_page        LIKE type_t.num5              #目前所在頁數

DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE gs_keys               DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列
DEFINE gs_keys_bak           DYNAMIC ARRAY OF VARCHAR(500) #同步資料用陣列

DEFINE g_wc_table1           STRING                        #第1個單身table所使用的g_wc

DEFINE g_form_idx        LIKE type_t.num5   #g_form_tree的index，用於tree_fill()的recursive
DEFINE g_tbtree_idx      LIKE type_t.num10
DEFINE g_tbtree_idx_t    LIKE type_t.num10
DEFINE g_column_idx      LIKE type_t.num10
DEFINE g_ftree_idx       LIKE type_t.num10
DEFINE g_ftree_idx_t     LIKE type_t.num10
DEFINE g_table_add       LIKE dzea_t.dzea001   #要加入的Table代碼
DEFINE g_color_sel       STRING                #顏色:表示此資料已使用
DEFINE g_gzza002         LIKE gzza_t.gzza002   #程式類別
DEFINE g_column          DYNAMIC ARRAY OF type_g_column       #欄位列表
DEFINE g_column_att      DYNAMIC ARRAY OF type_g_column_att   #欄位列表-已勾選的資料
DEFINE g_cdfCommon_sql   STRING                #共用欄位SQL條件
DEFINE g_cdfUd_sql       STRING                #自定義欄位SQL條件

DEFINE l_form_data_test  DYNAMIC ARRAY OF type_g_dzfr_d
DEFINE g_form_tree_t     DYNAMIC ARRAY OF type_form_tree   #畫面樣版架構-tree(舊值備份)

TYPE type_g_form_area_stc RECORD    #畫面區塊階層架構
   dzfr006   LIKE dzfr_t.dzfr006,   #4fd tag 類型
   addcol    BOOLEAN                #可加入欄位
   END RECORD
DEFINE g_form_stc         DYNAMIC ARRAY OF type_g_form_area_stc  #畫面區塊階層架構
DEFINE g_form_vbm_stc     DYNAMIC ARRAY OF type_g_form_area_stc  #畫面區塊階層架構-單頭
DEFINE g_form_vbd_stc     DYNAMIC ARRAY OF type_g_form_area_stc  #畫面區塊階層架構-單身
DEFINE g_form_vbm_exp_stc DYNAMIC ARRAY OF type_g_form_area_stc  #畫面區塊階層架構-單身底下附屬區塊
DEFINE g_form_vbhl_stc    DYNAMIC ARRAY OF type_g_form_area_stc  #畫面區塊階層架構-單頭固定區塊
DEFINE g_def_reset        BOOLEAN    #是否重設預設值
DEFINE g_exit_dialog_i    BOOLEAN    #是否離開dialog
DEFINE ms_cust            LIKE dzaa_t.dzaa010   #客戶代號

#樣板改變前的暫存檔
DEFINE g_dzfq_m_t02       type_g_dzfq_m
DEFINE g_tbtree_t02       DYNAMIC ARRAY OF type_g_tbtree       #程式主Table設定表

#+ 作業開始
MAIN
   DEFINE l_win_curr      ui.Window             #Current Window
   DEFINE l_frm_curr      ui.Form               #Current Form
   DEFINE ls_cfg_path     STRING
   DEFINE ls_4st_path     STRING
   DEFINE ls_img_path     STRING
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log

   #依模組進行系統初始化設定(系統設定)
   #CALL cl_ap_init("adz","")
   CALL cl_tool_init()   #ADZ模組專用

   #LOCK CURSOR
   LET g_forupd_sql = "SELECT dzfq001,dzfq002,dzfq003,dzfq004,dzfq005,dzfq006,dzfq007,dzfq008,dzfq009,dzfq010,dzfq011,dzfq012,dzfq013,dzfq014,dzfq015,dzfq016,dzfqstus,dzfqmodid,'',dzfqmoddt,dzfqownid,'',dzfqowndp,'',dzfqcrtid,'',dzfqcrtdp,'',dzfqcrtdt FROM dzfq_t WHERE dzfq003=? AND dzfq004=? FOR UPDATE"
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE adzp168_cl CURSOR FROM g_forupd_sql   #cursor lock

   IF g_bgjob = "Y" THEN

      #add-point:Service Call
      {<point name="main.servicecall" />}
      #end add-point
   ELSE
      #畫面開啟 (identifier)
      OPEN WINDOW w_adzp168 WITH FORM cl_ap_formpath("adz",g_code)

      #瀏覽頁簽資料初始化
      #CALL cl_ui_init()

      #adz模組採用的畫面風格
      #關閉Genero預設的視窗
      TRY
         CLOSE WINDOW screen
      CATCH
      END TRY

      LET l_win_curr = ui.Window.getCurrent()  #取得現行畫面
      LET l_frm_curr = l_win_curr.getForm()    #取出物件化後的畫面物件

      CALL cl_ui_wintitle(1) #工具抬頭名稱
      CALL cl_load_4ad_interface(NULL)

      LET ls_img_path = os.Path.join(os.Path.join(FGL_GETENV("RES"), "img"), "ui")
      CALL l_win_curr.setImage(os.Path.join(os.Path.join(ls_img_path, "logo"), "dsc_logo.ico"))

      LET ls_cfg_path = os.Path.join(FGL_GETENV("ERP"), "cfg")
      LET ls_4st_path = os.Path.join(os.Path.join(os.Path.join(ls_cfg_path, "4st"), g_lang), "designer.4st")
      CALL ui.Interface.loadStyles(ls_4st_path)

      #程式初始化
      CALL adzp168_init()

      #DISPLAY "test_msg g_lang=",g_lang
      #DISPLAY "test_msg g_dlang=",g_dlang

      #預設為新增模式
      LET g_def_reset = TRUE         #是否重設預設值
      CALL adzp168_insert("new",NULL)

      #畫面關閉
      CLOSE WINDOW w_adzp168
   END IF


   DROP TABLE adzp168t1
   DROP TABLE adzp168t2
   DROP TABLE adzp168t3

   #離開作業
   CALL cl_ap_exitprogram("0")

END MAIN


#+ 瀏覽頁簽資料初始化
PRIVATE FUNCTION adzp168_init()
   DEFINE l_dzfm001 LIKE dzfm_t.dzfm001   #結構代號
   DEFINE l_str     STRING
   DEFINE l_i       LIKE type_t.num5
   DEFINE l_k       LIKE type_t.num5

   #CALL cl_err_msg(NULL, "adz-00022", "r.a 畫面產生器只產生畫面。產生完成後若還需要繼續產出程式碼，請接續使用『T100設計器』並點選『下載程式』功能。", 1)   #%1

   CALL sadzp168_1_is_alm()   #是否啟動ALM
   LET ms_dgenv = FGL_GETENV("DGENV") CLIPPED
   LET ms_cust = FGL_GETENV("CUST") CLIPPED

   LET g_ver_dzba002 = "1"   #程式代碼版次
   LET g_ver_dzaa002 = "1"   #規格版次，對應到dzaa002(PK) r.a都是1
   LET g_ver_dzag003 = "1"   #識別碼版次dzaa004
   #LET g_ver_tpl = "1"       #畫面樣版結構版號 dzfm002
   CALL sadzp168_1_ver_ra() RETURNING g_ver_ra   #設計工具版號

   LET g_color_sel = "#eeffd4 reverse"   #顏色:表示此資料已使用

   LET g_tbtree_idx = 0
   LET g_column_idx= 0
   LET g_ftree_idx = 0

   CALL g_tbtree.clear()
   CALL g_column.clear()
   CALL g_column_att.clear()
   CALL g_form_tree.clear()

   #自定義欄位SQL條件
   LET g_cdfUd_sql = "'cdfUserDefineDateTime','cdfUserDefineNumber','cdfUserDefineVarchar'"
   #共用欄位SQL條件
   LET g_cdfCommon_sql = "'cdfOwnerID','cdfOwnerDept','cdfCreateID','cdfCreateDept','cdfCreateDate','cdfModifyID','cdfModifyDate','cdfConfirmID','cdfConfirmDate','cdfPostID','cdfPostDate'"

   #Create temp table 畫面樣版架構暫存檔
   CREATE TEMP TABLE adzp168t1
   (
      arridx   INTEGER,       #array index: for 欄位
      dzfr003  INTEGER,       #編號(流水號)
      dzfr004  INTEGER,       #父節點編號
      dzfr005  INTEGER,       #順序(同階層中的排序)
      dzfr006  VARCHAR(20),   #4fd tag 類型
      dzfr007  VARCHAR(40),   #4fd tag name
      dzfr008  INTEGER,       #4fd tag name 編號
      dzfr009  VARCHAR(15),   #資料表代碼
      dzfr010  VARCHAR(20),   #欄位代碼
      dzfr011  VARCHAR(1),    #是否可刪除
      dzfr012  VARCHAR(40),   #4fd tag name前置名稱(s_detail/folder_/page_/page_info_/group_/Grid/HBox/VBox)
      dzeb004  VARCHAR(1),    #primary key
      dzeb022  VARCHAR(50),   #屬於哪一種欄位定義代碼(dzek001)
      dzekgrp  VARCHAR(50),   #欄位定義代碼群組grpUIBelong/grpUIStateinfo
      gzzd005  VARCHAR(200),  #畫面元件多語言 by g_lang
      dzef008  VARCHAR(80),   #參考欄位
      dzer007  VARCHAR(80)    #多語言欄位
   );
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'CREATE TEMP:'
      LET g_errparam.popup = FALSE
      CALL cl_err()
   END IF

   #Create temp table 畫面樣版架構container和欄位關係暫存檔
   CREATE TEMP TABLE adzp168t2
   (
      arridx        INTEGER,       #array index: for 欄位

      rootarea      VARCHAR(20),   #所屬區塊vb_master,vb_detail,vb_detailexp
      cont_tag      VARCHAR(20),   #4fd tag 類型: for container
      cont_tagname  VARCHAR(40),   #4fd tag name: for container

      row_seq       INTEGER,       #順序(同階層中的排序): for ScrollGrid row

      dzfr003       INTEGER,       #編號(流水號): for 欄位
      dzfr004       INTEGER,       #父節點編號
      dzfr005       INTEGER,       #順序(同階層中的排序): for 欄位
      dzfr009       VARCHAR(15),   #資料表代碼
      dzfr010       VARCHAR(20),   #欄位代碼

      dzfr011       VARCHAR(1),    #是否可刪除
      dzfr012       VARCHAR(40),   #4fd tag name前置名稱(s_detail/folder_/page_/page_info_/group_/Grid/HBox/VBox)
      dzeb004       VARCHAR(1),    #primary key
      dzeb022       VARCHAR(50),   #屬於哪一種欄位定義代碼(dzek001)
      dzekgrp       VARCHAR(50),   #欄位定義代碼群組grpUIBelong/grpUIStateinfo
      gzzd005       VARCHAR(200),  #畫面元件多語言 by g_lang
      dzef008       VARCHAR(80),   #參考欄位
      dzer007       VARCHAR(80),   #多語言欄位

      dzep009       INTEGER,       #欄位顯示寬度
      widget_hight  INTEGER,       #欄位顯示高度
      prog_ins      VARCHAR(20)    #新增資料的程式
   );
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'CREATE TEMP:'
      LET g_errparam.popup = FALSE
      CALL cl_err()
   END IF

   #FUN-140923
   #Create temp table 畫面結構設計附屬設定表
   CREATE TEMP TABLE adzp168t3
   (
      dzff001 VARCHAR(20),
      dzff002 INTEGER,
      dzff003 VARCHAR(20),
      dzff004 INTEGER,
      dzff005 VARCHAR(20),
      dzff006 VARCHAR(15),
      dzff007 VARCHAR(20),
      dzff008 VARCHAR(1)
   );

   #現有的結構代號
   LET g_sql = "SELECT dzfm001",
                 " FROM dzfm_t ",
                 " WHERE dzfm008='Y'",
                 " GROUP BY dzfm001,dzfm008",
                 " ORDER BY dzfm001"

   PREPARE adzp168_dzfm001_pre FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'PREPARE:'
      LET g_errparam.popup = FALSE
      CALL cl_err()
   END IF
   DECLARE adzp168_dzfm001_cur CURSOR FOR adzp168_dzfm001_pre

   LET l_i = 0
   CALL g_tplcode.clear()
   FOREACH adzp168_dzfm001_cur INTO l_dzfm001   #Q001_hq
      LET l_i = l_i + 1
      LET l_str = l_dzfm001
      LET g_tplcode[l_i].dzfm001 = l_dzfm001
      LET g_tplcode[l_i].progtype = l_str.getCharAt(1)
      LET l_k = l_str.getIndexOf("_",1)
      LET g_tplcode[l_i].formtype = l_str.subString(2,l_k-1)
      LET g_tplcode[l_i].setbrowse = l_str.subString(l_k+1,l_str.getLength())
   END FOREACH


   #程式基本資料chk
   LET g_sql = "SELECT COUNT(*) FROM gzza_t WHERE gzza001=?"
   PREPARE adzp168_gzza001_chk FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'PREPARE:'
      LET g_errparam.popup = FALSE
      CALL cl_err()
   END IF

   #表格型態
   LET g_sql = "SELECT dzea004 FROM dzea_t WHERE dzea001 = ?"
   PREPARE adzp168_dzea004_pre FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'PREPARE:'
      LET g_errparam.popup = FALSE
      CALL cl_err()
   END IF

   #欄位資料排除共用欄位, ent企業編號
   #dzeb022=欄位定義代碼(dzek001)
   LET g_sql = "SELECT dzeb002,dzebl003,dzeb022,dzekgrp, dzef008,dzer007 FROM",
               " (",
                   " (SELECT '1' AS seq,dzeb001,dzeb002,dzeb021,dzeb022 FROM dzeb_t WHERE dzeb001 = ?",
                       " AND (dzeb022 NOT IN ('cdfEnterprise') OR dzeb022 IS NULL)",
                       " AND dzeb022 = 'cdfStatus'",
                   " )",
                   " UNION",
                   " (SELECT '2' AS seq,dzeb001,dzeb002,dzeb021,dzeb022 FROM dzeb_t WHERE dzeb001 = ?",
                       " AND (dzeb022 NOT IN ('cdfEnterprise') OR dzeb022 IS NULL)",
                       " AND dzeb004 = 'Y'",
                   " )",
                   " UNION",
                   " (SELECT '3' AS seq,dzeb001,dzeb002,dzeb021,dzeb022 FROM dzeb_t WHERE dzeb001 = ?",
                       " AND dzeb004 <> 'Y'",
                       " AND (dzeb022 IS NULL OR",
                              " (dzeb022 NOT IN ('cdfEnterprise')",
                                " AND dzeb022 <> 'cdfStatus'",
                                " AND dzeb022 NOT IN (SELECT dzek002 FROM dzek_t WHERE dzek001 IN ('grpUIBelong','grpUIStateinfo'))",
                              " )",
                           " )",
                   " )",
                   " UNION",
                   " (SELECT '4' AS seq,dzeb001,dzeb002,dzeb021,dzeb022 FROM dzeb_t WHERE dzeb001 = ?",
                       " AND (dzeb022 NOT IN ('cdfEnterprise') OR dzeb022 IS NULL)",
                       " AND dzeb022 IN (SELECT dzek002 FROM dzek_t WHERE dzek001 IN ('grpUIBelong'))",
                   " )",
                   " UNION",
                   " (SELECT '5' AS seq,dzeb001,dzeb002,dzeb021,dzeb022 FROM dzeb_t WHERE dzeb001 = ?",
                       " AND (dzeb022 NOT IN ('cdfEnterprise') OR dzeb022 IS NULL)",
                       " AND dzeb022 IN (SELECT dzek002 FROM dzek_t WHERE dzek001 IN ('grpUIStateinfo'))",
                   " )",
                " )",
                " LEFT JOIN",
                " (SELECT dzebl001,dzebl003 FROM dzebl_t WHERE dzebl002 = ?)",
                " ON dzeb002 = dzebl001",
                " LEFT JOIN",
                " (SELECT dzek001 AS dzekgrp,dzek002,dzek006 FROM dzek_t WHERE dzek001 IN ('grpUIBelong','grpUIStateinfo'))",
                " ON dzek002 = dzeb022",
                " LEFT JOIN dzef_t ON dzeb001 = dzef001 AND dzeb002 = dzef002",
                " LEFT JOIN dzer_t ON dzeb001 = dzer001 AND dzeb002 = dzer002 AND dzer003 = 1"
   IF ms_dgenv = "s" THEN   #產中標準環境不可以開通自定義欄位
      LET g_sql = g_sql CLIPPED," WHERE (dzeb022 NOT IN (",g_cdfUd_sql CLIPPED,") OR dzeb022 IS NULL)"
   END IF
   LET g_sql = g_sql CLIPPED," ORDER BY seq,dzek006,dzeb002"
   PREPARE adzp168_col_fill FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'PREPARE:'
      LET g_errparam.popup = FALSE
      CALL cl_err()
   END IF
   DECLARE adzp168_col_fillcur CURSOR FOR adzp168_col_fill

   #Table中的共用欄位數
   LET g_sql = "SELECT COUNT(dzeb002) FROM dzeb_t WHERE dzeb001 = ? ",
               #" AND dzeb022 IN ('cdfCommon')"
               " AND dzeb022 IN (",g_cdfCommon_sql CLIPPED,")"
   PREPARE adzp168_info_col_com FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'PREPARE:'
      LET g_errparam.popup = FALSE
      CALL cl_err()
   END IF

   #Table中的狀態碼
   LET g_sql = "SELECT dzeb002,dzebl003 FROM",
               " (SELECT dzeb002 FROM dzeb_t WHERE dzeb001 = ?",
                   " AND dzeb022 IN ('cdfStatus')",
                ")",
               " LEFT JOIN",
               "(SELECT dzebl001,dzebl003 FROM dzebl_t WHERE dzebl002 = ?)",
               " ON dzeb002 = dzebl001"
   PREPARE adzp168_info_col_stus FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'PREPARE:'
      LET g_errparam.popup = FALSE
      CALL cl_err()
   END IF


   #資料表鍵值檔:全部
   LET g_sql = "SELECT dzed003,dzed004,dzed005 FROM dzed_t WHERE dzed001 = ?"
   PREPARE adzp168_col_pkfk_1 FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'PREPARE:'
      LET g_errparam.popup = FALSE
      CALL cl_err()
   END IF
   DECLARE adzp168_col_pkfkcur_1 CURSOR FOR adzp168_col_pkfk_1


   #資料表鍵值檔by 鍵值形式P,F - 鍵值欄位
   LET g_sql = "SELECT dzed004 FROM dzed_t WHERE dzed001 = ? AND dzed003 = ? AND dzed005 = ?"
   PREPARE adzp168_col_pkfk_2 FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'PREPARE:'
      LET g_errparam.popup = FALSE
      CALL cl_err()
   END IF
   DECLARE adzp168_col_pkfkcur_2 CURSOR FOR adzp168_col_pkfk_2

   #資料表鍵值檔by 鍵值形式P,F - 外來鍵欄位
   LET g_sql = "SELECT dzed006 FROM dzed_t WHERE dzed001 = ? AND dzed003 = ? AND dzed005 = ?"
   PREPARE adzp168_col_pkfk_3 FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'PREPARE:'
      LET g_errparam.popup = FALSE
      CALL cl_err()
   END IF
   DECLARE adzp168_col_pkfkcur_3 CURSOR FOR adzp168_col_pkfk_3

   #cdfSite可拉到畫面,但非必選
   LET g_sql = "SELECT dzeb002,dzeb022 FROM dzeb_t WHERE dzeb001 = ? AND dzeb004 = 'Y' AND (dzeb022 NOT IN ('cdfEnterprise'))"
   PREPARE adzp168_col_pk_pre1 FROM g_sql
   DECLARE adzp168_col_pk_cur1 CURSOR FOR adzp168_col_pk_pre1

   #PK,需要和FK比對時使用
   LET g_sql = "SELECT dzeb002 FROM dzeb_t WHERE dzeb001 = ? AND dzeb004 = 'Y'"
   PREPARE adzp168_col_pk_pre2 FROM g_sql
   DECLARE adzp168_col_pk_cur2 CURSOR FOR adzp168_col_pk_pre2


   #form structure
   #新增資料到畫面樣版架構暫存檔
   LET g_sql = "INSERT INTO adzp168t1 VALUES (0,?,?,?,? ,?,?,?,?,? ,?,?,?,?,? ,?,?)"
   PREPARE adzp168t1_ins FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'PREPARE TMP:'
      LET g_errparam.popup = FALSE
      CALL cl_err()
   END IF

   #新增資料到畫面樣版架構container和欄位關係暫存檔
   LET g_sql = "INSERT INTO adzp168t2 VALUES (?,?,?,?,? ,?,?,?,?,? ,?,?,?,?,? ,?,?,?,?,? ,?,?)"
   PREPARE adzp168t2_ins FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'PREPARE TMP:'
      LET g_errparam.popup = FALSE
      CALL cl_err()
   END IF

   #畫面樣版Tree資料
   LET g_sql = "SELECT a.*,cnt.child_cnt",
                 " FROM",
                 " (",
                    " SELECT dzfr003,dzfr004,dzfr005,dzfr006,dzfr007,dzfr008,dzfr009,dzfr010,dzfr011,dzfr012,dzeb004,dzeb022,dzekgrp,gzzd005,dzef008,dzer007",
                       " FROM adzp168t1 WHERE dzfr004 = ?",
                 " ) a",
                 " LEFT JOIN",
                 " (",
                    " SELECT dzfr004,COUNT(dzfr004) AS child_cnt",
                       " FROM adzp168t1 GROUP BY dzfr004",
                 " ) cnt",
                 " ON a.dzfr003 = cnt.dzfr004",
                 " ORDER BY a.dzfr004,a.dzfr005"
   PREPARE adzp168_form_tree_pre1 FROM g_sql
   IF SQLCA.sqlcode THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = SQLCA.sqlcode
       LET g_errparam.extend = 'PREPARE:'
       LET g_errparam.popup = TRUE
       CALL cl_err()
       EXIT PROGRAM
   END IF
   DECLARE adzp168_form_tree_cs1 CURSOR FOR adzp168_form_tree_pre1

   #刪除畫面樣版架構暫存檔
   LET g_sql = "DELETE FROM adzp168t1"
   PREPARE adzp168_form_tree_del_pre FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'PREPARE TMP:'
      LET g_errparam.popup = FALSE
      CALL cl_err()
   END IF

   #依編號(流水號)刪除資料
   LET g_sql = "DELETE FROM adzp168t1 WHERE dzfr003 = ?"
   PREPARE adzp168_form_tree_del_dzfr003_pre FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'PREPARE TMP:'
      LET g_errparam.popup = FALSE
      CALL cl_err()
   END IF

   #依父節點編號刪除資料
   LET g_sql = "DELETE FROM adzp168t1 WHERE dzfr004 = ?"
   PREPARE adzp168_form_tree_del_dzfr004_pre FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'PREPARE TMP:'
      LET g_errparam.popup = FALSE
      CALL cl_err()
   END IF

   #Table與Screen Record對應
   LET g_sql = "UPDATE adzp168t1 SET dzfr009 = ? WHERE dzfr003 = ?"
   PREPARE adzp168t1_upd02_pre FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'PREPARE TMP:'
      LET g_errparam.popup = FALSE
      CALL cl_err()
   END IF


   #畫面多語言是否存在
   LET g_sql = "SELECT COUNT(DISTINCT gzzd003) FROM gzzd_t",
               " WHERE gzzd001 = ? AND gzzd002 = ? AND gzzd003 = ? AND gzzd004 = ?"
   PREPARE adzp168_formlang_cnt_pre FROM g_sql



   LET g_sql = "INSERT INTO dzfq_t(dzfq001,dzfq002,dzfq003,dzfq004,dzfq005,",
                                  "dzfq006,dzfq007,dzfq008,dzfq009,dzfq010,",
                                  "dzfq011,dzfq012,dzfq013,dzfq014,dzfq015,dzfq016,",
                                  "dzfqmodid,dzfqmoddt,dzfqownid,dzfqowndp,dzfqcrtid,dzfqcrtdp,dzfqcrtdt,dzfqstus)",
                  "  VALUES(?,?,?,?,? ,?,?,?,?,? ,?,?,?,?,? ,?,?,?,?,? ,?,?,?,?)"
   PREPARE adzp168_dzfq_ins FROM g_sql
   LET g_sql = "INSERT INTO dzfr_t(dzfr001,dzfr002,dzfr003,dzfr004,dzfr005,",
                                 " dzfr006,dzfr007,dzfr008,dzfr009,dzfr010,",
                                 " dzfr011,dzfr012)",
                  "  VALUES(?,?,?,?,? ,?,?,?,?,? ,?,?)"
   PREPARE adzp168_dzfr_ins FROM g_sql

   LET g_sql = "DELETE FROM dzfq_t WHERE dzfq003 = ? AND dzfq004 = ?"
   PREPARE adzp168_dzfq_del FROM g_sql

   #畫面結構設計內容檔 - 刪除正式資料
   LET g_sql = "DELETE FROM dzfr_t WHERE dzfr001 = ? AND dzfr002 = ?"
   PREPARE adzp168_dzfr_y_del FROM g_sql

   LET g_sql = "SELECT gzzd005 FROM gzzd_t WHERE gzzdstus = 'Y' AND gzzd001 = ? AND gzzd002 = ? AND gzzd003 = ? AND gzzd004 = ?"
   PREPARE adzp168_formlang_pre01 FROM g_sql

   #for adzp168_01() Tree ----------------
   #畫面結構設計附屬設定表
   LET g_sql = " SELECT dzff001,dzff002,dzff003,dzff004,dzff005,dzff006,dzff007,dzff008",
                " FROM adzp168t3",
                " WHERE dzff001=? AND dzff002=? AND dzff003=? AND dzff005=?",
                "  ORDER BY dzff003,dzff004"
   PREPARE adzp168_dzff_sel_pre1 FROM g_sql
   DECLARE adzp168_dzff_sel_curs1 CURSOR FOR adzp168_dzff_sel_pre1
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'PREPARE gen_4fd:'
      LET g_errparam.popup = FALSE
      CALL cl_err()
   END IF

   #畫面結構設計附屬設定表
   LET g_sql = " SELECT dzff001,dzff002,dzff003,dzff004,dzff005,dzff006,dzff007,dzff008",
                " FROM adzp168t3",
                " WHERE dzff001=? AND dzff002=? AND dzff003=?",
                "  ORDER BY dzff004"
   PREPARE adzp168_dzff_sel_pre2 FROM g_sql
   DECLARE adzp168_dzff_sel_curs2 CURSOR FOR adzp168_dzff_sel_pre2
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'PREPARE gen_4fd:'
      LET g_errparam.popup = FALSE
      CALL cl_err()
   END IF

   #畫面結構設計附屬設定表
   LET g_sql = " SELECT dzff003",
                " FROM adzp168t3",
                " WHERE dzff001=? AND dzff002=?",
                " GROUP BY dzff003"
   PREPARE adzp168_dzff_sel_pre3 FROM g_sql
   DECLARE adzp168_dzff_sel_curs3 CURSOR FOR adzp168_dzff_sel_pre3
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'PREPARE gen_4fd:'
      LET g_errparam.popup = FALSE
      CALL cl_err()
   END IF

   #刪除暫存檔dzff
   LET g_sql = "DELETE FROM adzp168t3 WHERE dzff001 = ? AND dzff002 = ?"
   PREPARE adzp168t3_del_all_pre FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'PREPARE:'
      LET g_errparam.popup = FALSE
      CALL cl_err()
   END IF

   #刪除畫面結構設計附屬設定表
   LET g_sql = "DELETE FROM dzff_t WHERE dzff001 = ? AND dzff002 = ? AND dzff008 = ?"
   PREPARE adzp168_dzff_del_pre FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'PREPARE:'
      LET g_errparam.popup = FALSE
      CALL cl_err()
   END IF


   #程式資料表設定檔
   LET g_sql = "DELETE FROM dzag_t WHERE dzag001 = ? AND dzag003 = ? AND dzag006 = ?"
   PREPARE adzp168_dzag_del_pre FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'PREPARE del:'
      LET g_errparam.popup = FALSE
      CALL cl_err()
   END IF

   #檢查相符合程式資料表設計資料是否已存在
   LET g_sql = "SELECT COUNT(*) FROM dzag_t WHERE dzag001 = ? AND dzag003 = ? AND dzag006 = ?"
   PREPARE adzp168_dzag_cnt_pre FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'PREPARE cnt:'
      LET g_errparam.popup = FALSE
      CALL cl_err()
   END IF

   #新增程式資料表設定
   LET g_sql = "INSERT INTO dzag_t(dzag001,dzag002,dzag003,dzag004,dzag005,dzag006,dzag007,dzag011,dzag012,",
                                   "dzagmodid,dzagmoddt,dzagownid,dzagowndp,dzagcrtid,dzagcrtdp,dzagcrtdt,dzagstus)",
               " VALUES(?,?,?,?,? ,?,?,?,?,? ,?,?,?,?,? ,?,?)"
   PREPARE adzp168_dzag_ins_pre FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'PREPARE ins:'
      LET g_errparam.popup = FALSE
      CALL cl_err()
   END IF


   #程式Table與Screen Record對應檔
   LET g_sql = "DELETE FROM dzfs_t WHERE dzfs001 = ? AND dzfs002 = ? AND dzfs005 = ?"
   PREPARE adzp168_dzfs_del FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'PREPARE del:'
      LET g_errparam.popup = FALSE
      CALL cl_err()
   END IF

   #新增程式Table與Screen Record對應檔
   LET g_sql = "INSERT INTO dzfs_t (dzfs001,dzfs002,dzfs003,dzfs004,dzfs005,",
                                   "dzfs006,dzfs007,dzfs008,dzfs009,dzfs010,",
                                   "dzfs011,dzfs012,",
                                   "dzfsmodid,dzfsmoddt,dzfsownid,dzfsowndp,dzfscrtid,dzfscrtdp,dzfscrtdt,dzfsstus)",
               " VALUES(?,?,?,?,? ,?,?,?,?,? ,?,?,?,?,? ,?,?,?,?,?)"
   PREPARE adzp168_dzfs_ins_pre FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'PREPARE ins:'
      LET g_errparam.popup = FALSE
      CALL cl_err()
   END IF

   CALL adzp168_cb_progtype()
   CALL sadzp168_1_cb_dzfq005("dzfq005","adzp168") RETURNING g_dzfq_m.dzfq005
   CALL adzp168_cb_dzfq008()
   CALL adzp168_cb_dzfq009()
   CALL adzp168_cb_dzfq010()

   CALL cl_set_combo_scc('dzfq013','79')   #azzi600
END FUNCTION

#+ 資料新增
PRIVATE FUNCTION adzp168_insert(p_default,p_dzfq004)
   DEFINE p_default   STRING                #設定預設值的方式 new:完全新增; draft:開啟底稿新增
   DEFINE p_dzfq004   LIKE dzfq_t.dzfq004   #畫面代號

   CLEAR FORM                    #清畫面欄位內容
   LET g_tbtree_idx = 0
   LET g_column_idx= 0
   LET g_ftree_idx = 0

   CALL g_dzfr_d.clear()        #清除陣列
   CALL g_tbtree.clear()        #清除陣列
   CALL g_column.clear()
   CALL g_column_att.clear()
   CALL g_form_tree.clear()

   #INITIALIZE g_dzfq_m.* LIKE dzfq_t.*             #DEFAULT 設定
   INITIALIZE g_dzfq_m TO NULL

   CASE p_default
      WHEN "new"
         LET g_def_reset = TRUE          #是否重設預設值
      WHEN "draft"
         LET g_def_reset = FALSE         #是否重設預設值
         CALL adzp168_draft_read(p_dzfq004)   #開啟底稿
   END CASE

   LET g_dzfq003_t = NULL   #key
   LET g_dzfq004_t = NULL   #key

   LET g_exit_dialog_i = FALSE
   WHILE g_exit_dialog_i = FALSE
      LET g_dzfq_m.dzfqcrtid = g_user
      LET g_dzfq_m.dzfqcrtdp = g_dept
      LET g_dzfq_m.dzfqcrtdt = cl_get_current()
      LET g_dzfq_m.dzfqownid = g_user
      LET g_dzfq_m.dzfqowndp = g_dept
      LET g_dzfq_m.dzfqmodid = g_user
      LET g_dzfq_m.dzfqmoddt = cl_get_current()
      LET g_dzfq_m.dzfqstus = 'Y'
      CALL adzp168_common_desc()   #共用欄位名稱

      #單頭預設值
      LET g_dzfq_m.dzfq003 = g_ver_dzaa002 #規格版次

      #開啟底稿新增
      CASE p_default
         WHEN "new"
            LET g_dzfq_m.dzfq005 = "M"      #M:主程式與畫面/S:子程式與畫面/F:子畫面
            CALL adzp168_cb_progtype()
            CALL adzp168_cb_dzfq008()
            CALL adzp168_cb_dzfq009()
            CALL adzp168_cb_dzfq010()
            CALL adzp168_default_set("m")   #畫面結構設計主檔預設值-單頭
            CALL adzp168_default_set("d")   #畫面結構設計主檔預設值-單身
         WHEN "draft"
            CALL adzp168_cb_progtype()
            CALL adzp168_cb_dzfq008()
            CALL adzp168_cb_dzfq009()
            CALL adzp168_cb_dzfq010()
            CALL adzp168_get_4fd_inf()   #取得產生4fd所需要的資訊
      END CASE

      CALL adzp168_input("a")

      IF INT_FLAG THEN
         LET INT_FLAG = 0
         LET g_dzfq_m.* = g_dzfq_m_t.*
         CALL adzp168_show()
         #CALL cl_err('',9001,0)
         EXIT WHILE
      END IF

      IF g_def_reset = FALSE THEN
         LET p_default = "draft"
      END IF
      CALL g_dzfr_d.clear()
      #CALL g_form_tree.clear()

      LET g_rec_b = 0
      #EXIT WHILE

   END WHILE


   CASE g_action_choice
      WHEN "gen_4fd"
         CALL adzp168_gen_4fd()
         LET g_def_reset = FALSE         #是否重設預設值
         CALL adzp168_input("a")

      #WHEN "draft_save"   #儲存底稿
      #   LET g_exit_dialog_i = TRUE
      #   CALL adzp168_draft_save()
      #   LET g_def_reset = FALSE         #是否重設預設值
      #   #CALL adzp168_input("a")

      WHEN "draft_read"
         IF NOT cl_null(g_dzfq_m.dzfq004) THEN
            LET g_def_reset = FALSE         #是否重設預設值
            CALL adzp168_insert("draft",g_dzfq_m.dzfq004)
         END IF
   END CASE
END FUNCTION


#+ 資料輸入
PRIVATE FUNCTION adzp168_input(p_cmd)
   {<Local define>}
   DEFINE p_cmd            LIKE type_t.chr1
   DEFINE l_cmd            LIKE type_t.chr1
   DEFINE l_ac_t           LIKE type_t.num5      #未取消的ARRAY CNT
   DEFINE l_n              LIKE type_t.num5      #檢查重複用
   DEFINE l_cnt            LIKE type_t.num5      #檢查重複用
   DEFINE l_addcol_cnt     LIKE type_t.num5      #新增欄位數量
   DEFINE l_count          LIKE type_t.num5
   DEFINE l_i              LIKE type_t.num5
   DEFINE l_j              LIKE type_t.num5
   DEFINE l_k              LIKE type_t.num5
   DEFINE l_end            LIKE type_t.num5
   DEFINE l_insert         BOOLEAN
   DEFINE ls_return        STRING
   DEFINE l_var_keys       DYNAMIC ARRAY OF STRING
   DEFINE l_field_keys     DYNAMIC ARRAY OF STRING
   DEFINE l_vars           DYNAMIC ARRAY OF STRING
   DEFINE l_fields         DYNAMIC ARRAY OF STRING
   DEFINE l_var_keys_bak   DYNAMIC ARRAY OF STRING

   DEFINE l_dzeal003      LIKE dzeal_t.dzeal003
   DEFINE l_dzea003       LIKE dzea_t.dzea003
   DEFINE l_dzea007       LIKE dzea_t.dzea007

   DEFINE l_tok           base.StringTokenizer
   DEFINE l_str           STRING
   DEFINE l_str2          STRING
   DEFINE ls_id           STRING
   DEFINE ls_pid          STRING
   DEFINE ls_id_seq       STRING
   DEFINE l_tbtree_cnt    LIKE type_t.num5
   DEFINE l_isadd         BOOLEAN
   DEFINE l_chk           BOOLEAN
   DEFINE l_chk2          BOOLEAN
   DEFINE l_entry         BOOLEAN               #是否開啟欄位
   DEFINE l_reflash       BOOLEAN               #是否有重新整理
   DEFINE l_tb_master     LIKE dzed_t.dzed001   #主table代號
   DEFINE l_dzfr003_child  LIKE dzfr_t.dzfr003   #編號-子節點
   DEFINE l_dzfr003       LIKE dzfr_t.dzfr003   #編號(流水號)
   DEFINE l_dzfr004       LIKE dzfr_t.dzfr004   #父節點編號
   DEFINE l_dzfr005       LIKE dzfr_t.dzfr005   #順序(同階層中的排序)
   DEFINE l_dzfr006       LIKE dzfr_t.dzfr006   #4fd tag 類型
   DEFINE l_dzfr007       LIKE dzfr_t.dzfr007   #4fd tag name
   DEFINE l_dzfr008       LIKE dzfr_t.dzfr008   #4fd tag name 編號
   DEFINE l_dzfr011       LIKE dzfr_t.dzfr011   #是否可刪除
   DEFINE l_dzfr012       LIKE dzfr_t.dzfr012   #4fd tag name前置名稱(s_detail/folder_/page_/page_info_/group_/Grid/HBox/VBox)
   DEFINE l_gzzd005       LIKE gzzd_t.gzzd005
   DEFINE l_root_idx      LIKE type_t.num5      #focus的Root節點index
   DEFINE l_rootid        STRING
   DEFINE l_gzca001       LIKE gzca_t.gzca001
   DEFINE l_tabletype     LIKE dzea_t.dzea004   #表格型態
   DEFINE l_img_dir       STRING
   DEFINE l_win_curr      ui.Window             #Current Window
   DEFINE l_frm_curr      ui.Form               #Current Form
   DEFINE l_gzza002_t     LIKE gzza_t.gzza002   #程式類別
   DEFINE l_dnd           ui.DragDrop
   DEFINE l_drag_idx      LIKE type_t.num5
   DEFINE l_drop_idx      LIKE type_t.num5
   DEFINE l_drag_source   STRING
   DEFINE l_drag_value    STRING
   DEFINE l_tbtree_idx    LIKE type_t.num10
   DEFINE ls_result_ind   STRING                #行業別管制維護 #160329-00027#1

   LET l_win_curr = ui.Window.getCurrent()  #取得現行畫面
   LET l_frm_curr = l_win_curr.getForm()    #取出物件化後的畫面物件

   CALL cl_set_head_visible("","YES")

   LET l_insert = FALSE
   LET g_action_choice = ""

   LET g_forupd_sql = "SELECT dzfr003,dzfr004,dzfr005,dzfr006,dzfr007,dzfr008,dzfr009,dzfr010,dzfr011,dzfr012 FROM dzfr_t WHERE dzfr001=? AND dzfr002=? AND dzfr003=? FOR UPDATE"
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   DECLARE adzp168_bcl CURSOR FROM g_forupd_sql

   LET g_qryparam.state = 'i'

   DISPLAY BY NAME g_dzfq_m.dzfq004,g_dzfq_m.cbo_progtype,g_dzfq_m.cbo_formtype,g_dzfq_m.cbo_setbrowse,g_dzfq_m.dzfq005,g_dzfq_m.dzfq006,g_dzfq_m.dzfq007,g_dzfq_m.dzfq008,g_dzfq_m.dzfq009,g_dzfq_m.dzfq010,g_dzfq_m.dzfq011,g_dzfq_m.dzfq012,g_dzfq_m.dzfq013,g_dzfq_m.dzfq014,g_dzfq_m.dzfq015,g_dzfq_m.dzfqmodid,g_dzfq_m.dzfqmodid_desc,g_dzfq_m.dzfqmoddt,g_dzfq_m.dzfqownid,g_dzfq_m.dzfqownid_desc,g_dzfq_m.dzfqowndp,g_dzfq_m.dzfqowndp_desc,g_dzfq_m.dzfqcrtid,g_dzfq_m.dzfqcrtid_desc,g_dzfq_m.dzfqcrtdp,g_dzfq_m.dzfqcrtdp_desc,g_dzfq_m.dzfqcrtdt

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)   #in FUNCTION adzp168_input

      #單頭段
      INPUT g_dzfq_m.dzfq004,g_dzfq_m.cbo_progtype,g_dzfq_m.cbo_formtype,g_dzfq_m.cbo_setbrowse,g_dzfq_m.dzfq005,g_dzfq_m.dzfq006,g_dzfq_m.dzfq007,g_dzfq_m.dzfq008,g_dzfq_m.dzfq009,g_dzfq_m.dzfq010,g_dzfq_m.dzfq011,g_dzfq_m.dzfq012,g_dzfq_m.dzfq013,g_dzfq_m.dzfq014,g_dzfq_m.dzfq015,
            g_dzfq_m.dzfqmodid,g_dzfq_m.dzfqmoddt,g_dzfq_m.dzfqownid,g_dzfq_m.dzfqowndp,g_dzfq_m.dzfqcrtid,g_dzfq_m.dzfqcrtdp,g_dzfq_m.dzfqcrtdt
         FROM dzfq004,cbo_progtype,cbo_formtype,cbo_setbrowse,dzfq005,dzfq006,dzfq007,dzfq008,dzfq009,dzfq010,dzfq011,dzfq012,dzfq013,dzfq014,dzfq015,
              dzfqmodid,dzfqmoddt,dzfqownid,dzfqowndp,dzfqcrtid,dzfqcrtdp,dzfqcrtdt

         ATTRIBUTE(WITHOUT DEFAULTS)


         BEFORE FIELD dzfq004   #程式開啟,未輸入程式代碼就先顯示預覽圖片
            LET l_cnt = g_form_tree.getLength()
            IF l_cnt = 0 THEN
               CALL adzp168_form_tpl(g_dzfq_m.dzfq001)
            END IF
            #CALL adzp168_dzfq001_str() #結構代號組字串
            #CALL adzp168_tpl_img()
            #IF l_cnt = 0 THEN
            #   LET g_ftree_idx = 0
            #   CALL g_form_tree.clear()   #再刪除,因為程式代碼改變時會重新產生,避免設定被清空,此步驟屬於後段,先不開放設定
            #END IF


         ON CHANGE cbo_progtype
            LET g_def_reset = TRUE   #任何修改都可能需要重設預設值
            CALL adzp168_cb_formtype()
            CALL adzp168_cb_setbrowse()
            CALL adzp168_dzfq001_str()   #結構代號組字串
            CALL adzp168_cb_dzfq009()
            CALL adzp168_cb_dzfq010()
            CALL adzp168_default_set_dzfq015(TRUE) RETURNING l_entry   #因為progtype會影響是否空框架   #160707-00028#1
            CALL adzp168_set_comp_entry("dzfq015",l_entry)   #160707-00028#1
            CALL adzp168_form_tpl(g_dzfq_m.dzfq001)
            CALL adzp168_get_4fd_inf()   #取得產生4fd所需要的資訊
            CALL adzp168_set_entry_by_type(p_cmd,TRUE)
            CALL adzp168_tpl_img()
            CALL adzp168_toolbar(FALSE)

            IF g_dzfq_m.dzfq015 = "Y" THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  "adz-00019"   #空框架畫面檔不需要設定欄位
               LET g_errparam.extend = NULL
               LET g_errparam.popup = TRUE
               CALL cl_err()
               CALL DIALOG.nextField("formonly.cbo_setbrowse")
            END IF

            #重設按鈕
            IF g_form_tree.getLength() >= 1 THEN
               LET g_ftree_idx = 1
               CALL DIALOG.setCurrentRow("s_form_tree",g_ftree_idx)
            END IF

            CALL adzp168_form_tree_root_idx(g_ftree_idx) RETURNING l_root_idx

            CALL adzp168_set_act_add_master(l_root_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("add_master",l_chk)
            CALL adzp168_set_act_del_master(l_root_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("del_master",l_chk)

            CALL adzp168_set_act_add_detail(l_root_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("add_detail",l_chk)
            CALL adzp168_set_act_del_detail(l_root_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("del_detail",l_chk)

            CALL adzp168_set_act_add_pageinfo(l_root_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("add_pageinfo",l_chk)

            CALL adzp168_tree_config_chk(FALSE) RETURNING l_i
            IF l_i > 0 THEN
               CALL DIALOG.setActionActive("tree_config",TRUE)
            ELSE
               CALL DIALOG.setActionActive("tree_config",FALSE)
            END IF

            CALL adzp168_set_act_status_config() RETURNING l_chk
            CALL DIALOG.setActionActive("status_config",l_chk)

            CALL adzp168_set_act_col_up(g_ftree_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("col_up",l_chk)
            CALL adzp168_set_act_col_down(g_ftree_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("col_down",l_chk)


         ON CHANGE cbo_formtype
            LET g_def_reset = TRUE   #任何修改都可能需要重設預設值
            CALL adzp168_cb_setbrowse()
            CALL adzp168_dzfq001_str() #結構代號組字串
            CALL adzp168_cb_dzfq009()
            CALL adzp168_cb_dzfq010()
            CALL adzp168_default_set_dzfq015(TRUE) RETURNING l_entry   #因為formtype會影響,ex. P001,P003才預設空框架,P002不是
            CALL adzp168_set_comp_entry("dzfq015",l_entry)   #FUN-150228
            CALL adzp168_form_tpl(g_dzfq_m.dzfq001)
            CALL adzp168_get_4fd_inf()   #取得產生4fd所需要的資訊
            CALL adzp168_set_entry_by_type(p_cmd,FALSE)
            CALL adzp168_toolbar(FALSE)

            IF g_dzfq_m.dzfq015 = "Y" THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  "adz-00019"   #空框架畫面檔不需要設定欄位
               LET g_errparam.extend = NULL
               LET g_errparam.popup = TRUE
               CALL cl_err()
               CALL DIALOG.nextField("formonly.cbo_setbrowse")
            END IF

            #重設按鈕
            IF g_form_tree.getLength() >= 1 THEN
               LET g_ftree_idx = 1
               CALL DIALOG.setCurrentRow("s_form_tree",g_ftree_idx)
            END IF

            CALL adzp168_form_tree_root_idx(g_ftree_idx) RETURNING l_root_idx

            CALL adzp168_set_act_add_master(l_root_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("add_master",l_chk)
            CALL adzp168_set_act_del_master(l_root_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("del_master",l_chk)

            CALL adzp168_set_act_add_pageinfo(l_root_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("add_pageinfo",l_chk)

            CALL adzp168_set_act_add_detail(l_root_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("add_detail",l_chk)
            CALL adzp168_set_act_del_detail(l_root_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("del_detail",l_chk)

            CALL adzp168_tree_config_chk(FALSE) RETURNING l_i
            IF l_i > 0 THEN
               CALL DIALOG.setActionActive("tree_config",TRUE)
            ELSE
               CALL DIALOG.setActionActive("tree_config",FALSE)
            END IF

            CALL adzp168_set_act_status_config() RETURNING l_chk
            CALL DIALOG.setActionActive("status_config",l_chk)

            CALL adzp168_set_act_col_up(g_ftree_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("col_up",l_chk)
            CALL adzp168_set_act_col_down(g_ftree_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("col_down",l_chk)


         BEFORE FIELD cbo_setbrowse
            CALL adzp168_tpl_change_before()

         AFTER FIELD cbo_setbrowse
            #重設按鈕
            IF g_form_tree.getLength() >= 1 THEN
               LET g_ftree_idx = 1
               CALL DIALOG.setCurrentRow("s_form_tree",g_ftree_idx)
            END IF

            CALL adzp168_form_tree_root_idx(g_ftree_idx) RETURNING l_root_idx

            CALL adzp168_set_act_add_master(l_root_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("add_master",l_chk)
            CALL adzp168_set_act_del_master(l_root_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("del_master",l_chk)

            CALL adzp168_set_act_add_detail(l_root_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("add_detail",l_chk)
            CALL adzp168_set_act_del_detail(l_root_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("del_detail",l_chk)

            CALL adzp168_tree_config_chk(FALSE) RETURNING l_i
            IF l_i > 0 THEN
               CALL DIALOG.setActionActive("tree_config",TRUE)
            ELSE
               CALL DIALOG.setActionActive("tree_config",FALSE)
            END IF

            CALL adzp168_set_act_status_config() RETURNING l_chk
            CALL DIALOG.setActionActive("status_config",l_chk)

            CALL adzp168_set_act_col_up(g_ftree_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("col_up",l_chk)
            CALL adzp168_set_act_col_down(g_ftree_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("col_down",l_chk)


         ON CHANGE cbo_setbrowse   #資料瀏覽區塊(00:不需要/sc:查詢方案/ht:左方樹狀/vt:上方樹狀)
            LET g_def_reset = TRUE   #任何修改都可能需要重設預設值
            CALL adzp168_dzfq001_str() #結構代號組字串
            #CALL adzp168_cb_dzfq009()
            #CALL adzp168_cb_dzfq010()

            CALL adzp168_form_tpl(g_dzfq_m.dzfq001)
            #無資料瀏覽區塊轉查詢方案,自動保留畫面結構
            CALL adzp168_tpl_change_after()
            LET g_ftree_idx_t = g_ftree_idx
            CALL adzp168_m_to_browse(g_ftree_idx_t) RETURNING g_ftree_idx #把單頭欄位依序產生到s_browse
            CALL DIALOG.setCurrentRow("s_form_tree",g_ftree_idx)

            CALL adzp168_get_4fd_inf()   #取得產生4fd所需要的資訊


         ON CHANGE dzfq004   #畫面代號
            LET g_def_reset = TRUE   #任何修改都可能需要重設預設值
            CALL adzp168_toolbar(FALSE)
            CALL adzp168_col_setcolor()
            CALL adzp168_dzfq001_str() #結構代號組字串
            CALL adzp168_form_tpl(g_dzfq_m.dzfq001)

            #重設按鈕
            IF g_form_tree.getLength() >= 1 THEN
               LET g_ftree_idx = 1
               CALL DIALOG.setCurrentRow("s_form_tree",g_ftree_idx)
            END IF

            CALL adzp168_form_tree_root_idx(g_ftree_idx) RETURNING l_root_idx

            CALL adzp168_set_act_add_master(l_root_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("add_master",l_chk)
            CALL adzp168_set_act_del_master(l_root_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("del_master",l_chk)

            CALL adzp168_set_act_add_detail(l_root_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("add_detail",l_chk)
            CALL adzp168_set_act_del_detail(l_root_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("del_detail",l_chk)

            CALL adzp168_set_act_add_pageinfo(l_root_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("add_pageinfo",l_chk)

            CALL adzp168_tree_config_chk(FALSE) RETURNING l_i
            IF l_i > 0 THEN
               CALL DIALOG.setActionActive("tree_config",TRUE)
            ELSE
               CALL DIALOG.setActionActive("tree_config",FALSE)
            END IF

            CALL adzp168_set_act_status_config() RETURNING l_chk
            CALL DIALOG.setActionActive("status_config",l_chk)

            CALL adzp168_set_act_col_up(g_ftree_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("col_up",l_chk)
            CALL adzp168_set_act_col_down(g_ftree_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("col_down",l_chk)


         #ON CHANGE dzfq004 然後跑BEFORE FIELD dzfq004,此時值有誤卻能繼續往下執行了
         AFTER FIELD dzfq004
            IF NOT cl_null(g_dzfq_m.dzfq003) AND NOT cl_null(g_dzfq_m.dzfq004) THEN
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_dzfq_m.dzfq003 != g_dzfq003_t  OR g_dzfq_m.dzfq004 != g_dzfq004_t )) THEN
                  LET l_chk = TRUE
                  #程式代碼基本資料檢查
                  IF l_chk THEN
                     CALL sadzp168_1_prog_chk(g_dzfq_m.dzfq004,g_dzfq_m.dzfq005) RETURNING l_chk
                  END IF

                  ###160329-00027#1 START ###
                  #行業別管制維護
                  IF l_chk AND g_dzfq_m.dzfq005 = "M" THEN
                     CALL sadzp060_ind_check_status(g_dzfq_m.dzfq004) RETURNING ls_result_ind
                     CASE
                        WHEN ls_result_ind = "1"
                           #標準環境不可以開發行業程式 (ex:aiti001_ph,biti001_ph)
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = "adz-00817"   #標準環境不可以開發行業程式%1
                           LET g_errparam.extend = ""
                           LET g_errparam.popup = TRUE
                           LET g_errparam.replace[1] = g_dzfq_m.dzfq004
                           CALL cl_err()
                           LET l_chk = FALSE

                        WHEN ls_result_ind = "2"
                           #行業環境不可以開發標準程式 (ex:aiti001)
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = "adz-00818"   #行業環境不可以開發標準程式%1
                           LET g_errparam.extend = ""
                           LET g_errparam.popup = TRUE
                           LET g_errparam.replace[1] = g_dzfq_m.dzfq004
                           CALL cl_err()
                           LET l_chk = FALSE

                        WHEN ls_result_ind = "3"
                           #行業環境此程式為強制引用
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = "adz-00576"   #程式代號 %1 是屬於強制引用標準的行業程式, 得透過adzp600來產生.
                           LET g_errparam.extend = ""
                           LET g_errparam.popup = TRUE
                           LET g_errparam.replace[1] = g_dzfq_m.dzfq004
                           CALL cl_err()
                           LET l_chk = FALSE
                     END CASE
                  END IF
                  ###160329-00027#1 END ###

                  #判斷是否已經簽出 for Hiko
                  IF l_chk THEN
                     LET l_str = NULL
                     CALL sadzp060_2_have_checked_out(g_dzfq_m.dzfq004, g_dzfq_m.dzfq005, "SD",1) RETURNING l_str
                     IF NOT cl_null(l_str) THEN
                        LET l_chk = FALSE
                     ELSE
                        LET l_chk = TRUE
                     END IF
                  END IF
                  #畫面設計資料是否可覆蓋
                  IF l_chk THEN
                     IF NOT sadzp168_1_dzaa_exist(g_dzfq_m.dzfq004,g_dzfq_m.dzfq005,FALSE) THEN
                        LET l_chk = FALSE
                     END IF
                  END IF

                  IF NOT l_chk THEN
                     LET g_dzfq_m.dzfq004 = NULL
                     LET g_dzfq_m.gzzal003 = NULL
                     DISPLAY g_dzfq_m.dzfq004,g_dzfq_m.gzzal003 TO dzfq004,lb_gzzal003
                     CALL DIALOG.nextField("dzfq004")
                  ELSE
                     LET l_gzza002_t = g_gzza002   #程式類別
                     CALL sadzp168_1_gzza002(g_dzfq_m.dzfq004,g_dzfq_m.dzfq005) RETURNING g_gzza002,g_gzza003,g_gzza003_module,g_dzfq_m.gzzal003      #程式類別,模組代碼,程式名稱,是否使用樣板
                     IF l_gzza002_t <> g_gzza002 THEN   #程式類別改變會影響ToolBar
                        CALL adzp168_toolbar(FALSE)
                     END IF

                     CALL adzp168_default_set_dzfq013()  #畫面結構設計主檔預設值-子程式進入模式(a:全功能/ b:INPUT / c:CONSTRUCT)
                     CALL adzp168_set_entry_by_dzfq004(g_dzfq_m.dzfq005)
                     DISPLAY g_dzfq_m.gzzal003 TO lb_gzzal003
                  END IF
               END IF
            END IF


         ON CHANGE dzfq005   #主/子程式
            LET g_def_reset = TRUE   #任何修改都可能需要重設預設值
            CALL adzp168_cb_progtype()
            CALL adzp168_cb_formtype()
            CALL adzp168_cb_setbrowse()      #子程式不要有瀏覽區塊
            CALL adzp168_dzfq001_str()       #結構代號組字串
            CALL adzp168_cb_dzfq009()
            CALL adzp168_cb_dzfq010()
            CALL adzp168_default_set_dzfq015(TRUE) RETURNING l_entry
            CALL adzp168_set_comp_entry("dzfq015",l_entry)   #FUN-150228
            CALL adzp168_form_tpl(g_dzfq_m.dzfq001)
            CALL adzp168_get_4fd_inf()       #取得產生4fd所需要的資訊
            CALL adzp168_set_entry_by_type(p_cmd,FALSE)
            CALL adzp168_toolbar(FALSE)
            CALL adzp168_tpl_img()           #因為可能改變dzfq006的值

            LET g_dzfq_m.dzfq004 = NULL
            LET g_dzfq_m.gzzal003 = NULL
            DISPLAY g_dzfq_m.dzfq004,g_dzfq_m.gzzal003 TO dzfq004,lb_gzzal003
            NEXT FIELD CURRENT


         ON CHANGE dzfq006
            #LET g_def_reset = TRUE   #任何修改都可能需要重設預設值
            CALL adzp168_tpl_img()


         ON CHANGE dzfq007
            LET g_def_reset = FALSE   #任何修改都可能需要重設預設值
            CALL adzp168_form_tpl(g_dzfq_m.dzfq001)

            #重設按鈕
            IF g_form_tree.getLength() >= 1 THEN
               LET g_ftree_idx = 1
               CALL DIALOG.setCurrentRow("s_form_tree",g_ftree_idx)
            END IF

            CALL adzp168_form_tree_root_idx(g_ftree_idx) RETURNING l_root_idx

            CALL adzp168_set_act_add_master(l_root_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("add_master",l_chk)
            CALL adzp168_set_act_del_master(l_root_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("del_master",l_chk)

            CALL adzp168_set_act_add_detail(l_root_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("add_detail",l_chk)
            CALL adzp168_set_act_del_detail(l_root_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("del_detail",l_chk)

            CALL adzp168_set_act_add_pageinfo(l_root_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("add_pageinfo",l_chk)

            CALL adzp168_tree_config_chk(FALSE) RETURNING l_i
            IF l_i > 0 THEN
               CALL DIALOG.setActionActive("tree_config",TRUE)
            ELSE
               CALL DIALOG.setActionActive("tree_config",FALSE)
            END IF

            CALL adzp168_set_act_status_config() RETURNING l_chk
            CALL DIALOG.setActionActive("status_config",l_chk)

            CALL adzp168_set_act_col_up(g_ftree_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("col_up",l_chk)
            CALL adzp168_set_act_col_down(g_ftree_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("col_down",l_chk)



         ON CHANGE dzfq009
            LET g_def_reset = TRUE   #任何修改都可能需要重設預設值
            CALL adzp168_form_tpl(g_dzfq_m.dzfq001)

            #重設按鈕
            IF g_form_tree.getLength() >= 1 THEN
               LET g_ftree_idx = 1
               CALL DIALOG.setCurrentRow("s_form_tree",g_ftree_idx)
            END IF

            CALL adzp168_form_tree_root_idx(g_ftree_idx) RETURNING l_root_idx

            CALL adzp168_set_act_add_master(l_root_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("add_master",l_chk)
            CALL adzp168_set_act_del_master(l_root_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("del_master",l_chk)

            CALL adzp168_set_act_add_detail(l_root_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("add_detail",l_chk)
            CALL adzp168_set_act_del_detail(l_root_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("del_detail",l_chk)

            CALL adzp168_set_act_add_pageinfo(l_root_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("add_pageinfo",l_chk)

            CALL adzp168_tree_config_chk(FALSE) RETURNING l_i
            IF l_i > 0 THEN
               CALL DIALOG.setActionActive("tree_config",TRUE)
            ELSE
               CALL DIALOG.setActionActive("tree_config",FALSE)
            END IF

            CALL adzp168_set_act_status_config() RETURNING l_chk
            CALL DIALOG.setActionActive("status_config",l_chk)

            CALL adzp168_set_act_col_up(g_ftree_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("col_up",l_chk)
            CALL adzp168_set_act_col_down(g_ftree_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("col_down",l_chk)


         ON CHANGE dzfq010
            LET g_def_reset = TRUE   #任何修改都可能需要重設預設值
            CALL adzp168_form_tpl(g_dzfq_m.dzfq001)

            #重設按鈕
            IF g_form_tree.getLength() >= 1 THEN
               LET g_ftree_idx = 1
               CALL DIALOG.setCurrentRow("s_form_tree",g_ftree_idx)
            END IF

            CALL adzp168_form_tree_root_idx(g_ftree_idx) RETURNING l_root_idx

            CALL adzp168_set_act_add_master(l_root_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("add_master",l_chk)
            CALL adzp168_set_act_del_master(l_root_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("del_master",l_chk)

            CALL adzp168_set_act_add_detail(l_root_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("add_detail",l_chk)
            CALL adzp168_set_act_del_detail(l_root_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("del_detail",l_chk)

            CALL adzp168_set_act_add_pageinfo(l_root_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("add_pageinfo",l_chk)

            CALL adzp168_tree_config_chk(FALSE) RETURNING l_i
            IF l_i > 0 THEN
               CALL DIALOG.setActionActive("tree_config",TRUE)
            ELSE
               CALL DIALOG.setActionActive("tree_config",FALSE)
            END IF

            CALL adzp168_set_act_status_config() RETURNING l_chk
            CALL DIALOG.setActionActive("status_config",l_chk)

            CALL adzp168_set_act_col_up(g_ftree_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("col_up",l_chk)
            CALL adzp168_set_act_col_down(g_ftree_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("col_down",l_chk)


         ON CHANGE dzfq015  #??
            IF g_dzfq_m.dzfq015 = "Y" THEN
               #刪除全部欄位
               SELECT COUNT(*) INTO l_cnt FROM adzp168t1 WHERE dzfr006 = 'Field' AND dzfr009 IS NOT NULL AND dzfr010 IS NOT NULL
               IF l_cnt > 0 THEN
                  DELETE FROM adzp168t1 WHERE dzfr006 = 'Field' AND dzfr009 IS NOT NULL AND dzfr010 IS NOT NULL
                  CALL adzp168_form_tree_fill("0",0,"0",FALSE)   #刪完後再重整tree
               END IF

               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  "adz-00019"   #空框架畫面檔不需要設定欄位
               LET g_errparam.extend = NULL
               LET g_errparam.popup = TRUE
               CALL cl_err()
               CALL DIALOG.nextField("formonly.cbo_setbrowse")
            END IF

         #欄位檢查
         #---------------------------<  Master  >---------------------------
         #----<<dzfq004>>----
         ON ACTION controlp INFIELD dzfq004
            CALL sadzp168_1_prog_qry("i",ms_dgenv,g_dzfq_m.dzfq005,g_gzza003,g_dzfq_m.dzfq004,g_dzfq_m.gzzal003,g_gzza002) RETURNING g_dzfq_m.dzfq004,g_dzfq_m.gzzal003,g_gzza002

            CALL sadzp168_1_gzza002(g_dzfq_m.dzfq004,g_dzfq_m.dzfq005) RETURNING g_gzza002,g_gzza003,g_gzza003_module,g_dzfq_m.gzzal003      #程式類別,模組代碼,程式名稱,是否使用樣板
            CALL adzp168_set_entry_by_dzfq004(g_dzfq_m.dzfq005)
            DISPLAY g_dzfq_m.dzfq004,g_dzfq_m.gzzal003 TO dzfq004,lb_gzzal003


         AFTER INPUT
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF
            DISPLAY BY NAME g_dzfq_m.dzfq003,g_dzfq_m.dzfq004 #key

            IF p_cmd <> 'u' THEN
            END IF
      END INPUT


      INPUT g_table_add FROM dzea001
         ATTRIBUTE(WITHOUT DEFAULTS)

         ON ACTION controlp INFIELD dzea001
            #CALL q_dzea001(FALSE, FALSE, NULL, NULL, NULL, NULL) RETURNING g_table_add,l_dzeal003,l_dzea003,l_dzea007
            LET g_qryparam.state = "i"
            LET g_qryparam.reqry = FALSE
            #LET l_str = g_lang
            #LET g_qryparam.where = "dzeal002=",l_str CLIPPED
            LET g_qryparam.default1 = NULL
            LET g_qryparam.default2 = NULL
            LET g_qryparam.default3 = NULL
            LET g_qryparam.default4 = NULL
            CALL q_dzea001()
            LET g_qryparam.where = NULL
            LET g_table_add = g_qryparam.return1
            LET l_dzeal003 = g_qryparam.return2
            LET l_dzea003 = g_qryparam.return3
            LET l_dzea007 = g_qryparam.return4

            LET INT_FLAG = 0   #避免開窗按取消後誤判
            DISPLAY g_table_add TO dzea001
      END INPUT


      #功能鍵設定
      #INPUT ARRAY g_toolbar FROM s_toolbar.*
      #    ATTRIBUTES(APPEND ROW=FALSE, INSERT ROW=FALSE, DELETE ROW=FALSE)
      #END INPUT

      #設定Table
      DISPLAY ARRAY g_tbtree TO s_tabtree.* ATTRIBUTES(COUNT=g_tbtree.getLength())
         BEFORE DISPLAY
            LET l_cnt = g_tbtree.getLength()
            IF l_cnt >= 1 THEN
               LET g_tbtree_idx = 1
               CALL DIALOG.setCurrentRow("s_tabtree",g_tbtree_idx)
            END IF

         BEFORE ROW
            LET g_tbtree_idx = DIALOG.getCurrentRow("s_tabtree")
            CALL adzp168_col_fill(g_tbtree[g_tbtree_idx].b_tableid)
            CALL adzp168_set_act_status_config() RETURNING l_chk
            CALL DIALOG.setActionActive("status_config",l_chk)
            #FUN-141120
            #挑選欄位支援多選方式
            LET l_cnt = g_column.getLength()
            FOR l_i = l_cnt TO 1 STEP -1
               IF g_column[l_i].b_sel = "Y" THEN
                  CALL DIALOG.setSelectionRange( "s_column", l_i, l_i, TRUE)
               ELSE
                  CALL DIALOG.setSelectionRange( "s_column", l_i, l_i, FALSE)
               END IF
            END FOR
      END DISPLAY

      #挑選欄位   #FUN-141120 mark
      #INPUT ARRAY g_column FROM s_column.*
      #    ATTRIBUTES(APPEND ROW=FALSE, INSERT ROW=FALSE, DELETE ROW=FALSE)
      #
      #   BEFORE INPUT
      #      CALL DIALOG.setArrayAttributes("s_column", g_column_att)   #欄位列表顏色屬性,已使用的欄位要變色
      #
      #      IF g_form_tree.getLength() > 0 THEN   #畫面設計有樣板資料
      #         CALL DIALOG.setActionActive("del_col",TRUE)
      #      ELSE
      #         CALL DIALOG.setActionActive("del_col",FALSE)
      #      END IF
      #
      #      #加入欄位的按鈕
      #      CALL adzp168_set_act_add_col() RETURNING l_chk
      #      CALL DIALOG.setActionActive("add_col",l_chk)
      #
      #   BEFORE ROW
      #      LET g_column_idx = DIALOG.getCurrentRow("s_column")
      #
      #   ON CHANGE chk
      #      #強制勾選或不選
      #      CALL adzp168_col_must_sel(g_column[g_column_idx].b_sel,g_column_idx,TRUE) RETURNING g_column[g_column_idx].b_sel
      #END INPUT
      #FUN-141120
      DISPLAY ARRAY g_column TO s_column.* ATTRIBUTES(COUNT=g_column.getLength())
         BEFORE DISPLAY
            CALL DIALOG.setArrayAttributes("s_column", g_column_att)   #欄位列表顏色屬性,已使用的欄位要變色

            IF g_form_tree.getLength() > 0 THEN   #畫面設計有樣板資料
               CALL DIALOG.setActionActive("del_col",TRUE)
            ELSE
               CALL DIALOG.setActionActive("del_col",FALSE)
            END IF

            #加入欄位的按鈕
            CALL adzp168_set_act_add_col() RETURNING l_chk
            CALL DIALOG.setActionActive("add_col",l_chk)

         #BEFORE ROW
         #   #[FJS] (SUP-966) BEFORE ROW and DIALOG.isRowSelected
         #   #BEFORE ROW時 DIALOG.isRowSelected卻是false
         #   #LET g_column_idx = DIALOG.getCurrentRow("s_column")   #暫解
         #   #CALL DIALOG.setCurrentRow("s_column", g_column_idx)   #暫解
      END DISPLAY

      DISPLAY ARRAY g_form_tree TO s_form_tree.* ATTRIBUTES(COUNT=g_form_tree.getLength())
         BEFORE DISPLAY
            IF g_form_tree.getLength() >= 1 THEN
               LET g_ftree_idx = 1
               CALL DIALOG.setCurrentRow("s_form_tree",g_ftree_idx)
            END IF

         BEFORE ROW
            LET g_ftree_idx = DIALOG.getCurrentRow("s_form_tree")
            CALL adzp168_form_tree_root_idx(g_ftree_idx) RETURNING l_root_idx

            CALL adzp168_set_act_add_master(l_root_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("add_master",l_chk)
            CALL adzp168_set_act_del_master(l_root_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("del_master",l_chk)

            CALL adzp168_set_act_add_detail(l_root_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("add_detail",l_chk)
            CALL adzp168_set_act_del_detail(l_root_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("del_detail",l_chk)

            CALL adzp168_set_act_add_pageinfo(l_root_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("add_pageinfo",l_chk)

            CALL adzp168_tree_config_chk(FALSE) RETURNING l_i
            IF l_i > 0 THEN
               CALL DIALOG.setActionActive("tree_config",TRUE)
            ELSE
               CALL DIALOG.setActionActive("tree_config",FALSE)
            END IF

            CALL adzp168_set_act_status_config() RETURNING l_chk
            CALL DIALOG.setActionActive("status_config",l_chk)

            #欄位往前的按鈕
            CALL adzp168_set_act_col_up(g_ftree_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("col_up",l_chk)

            #欄位往後的按鈕
            CALL adzp168_set_act_col_down(g_ftree_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("col_down",l_chk)

            #加入欄位的按鈕
            CALL adzp168_set_act_add_col() RETURNING l_chk
            CALL DIALOG.setActionActive("add_col",l_chk)
            CALL adzp168_set_act_add_col_ghost() RETURNING l_chk
            CALL DIALOG.setActionActive("add_col_ghost",l_chk)

            CALL adzp168_set_act_del_col() RETURNING l_chk
            CALL DIALOG.setActionActive("del_col",l_chk)


            #樹狀設定
            CALL adzp168_tree_config_chk(FALSE) RETURNING l_i
            IF l_i > 0 THEN
               CALL DIALOG.setActionActive("tree_config",TRUE)
            ELSE
               CALL DIALOG.setActionActive("tree_config",FALSE)
            END IF

         #Drag and Drop
         ON DRAG_START(l_dnd)
            #DISPLAY "sr_right ON DRAG_START"
            LET l_drag_source = "s_form_tree"
            LET l_drag_idx = arr_curr()
            LET l_drag_value = g_form_tree[l_drag_idx].b_id
            #DISPLAY "l_drag_idx=",l_drag_idx,",l_drag_value=",l_drag_value

         ON DRAG_FINISHED(l_dnd)
            #DISPLAY "sr_right ON DRAG_FINISHED"
            INITIALIZE l_drag_source TO NULL

         ON DRAG_ENTER(l_dnd)
            #DISPLAY "sr_right ON DRAG_ENTER"
            IF l_drag_source IS NULL THEN
                CALL l_dnd.setOperation(NULL)
            END IF

         ON DROP(l_dnd)
            #DISPLAY "sr_right ON DROP"
            IF l_drag_source == "s_form_tree" THEN
               LET l_drop_idx = l_dnd.getLocationRow()
               LET l_cnt = g_form_tree.getLength()

               #若是在加欄位後面,則從後面開始加入
               IF (g_form_tree[l_drop_idx].dzfr006 = "Field" OR g_form_tree[l_drop_idx].dzfr006 = "ghost") THEN
                  LET l_i = l_cnt
                  LET l_end = 0
               ELSE
                  LET l_i = 1
                  LET l_end = l_cnt + 1
               END IF

               WHILE l_i <> l_end
                  IF DIALOG.isRowSelected("s_form_tree",l_i) THEN
                     IF (g_form_tree[l_i].dzfr006 = "Field" OR g_form_tree[l_i].dzfr006 = "ghost") AND g_form_tree[l_i].dzfr011 = "Y" THEN
                        #DISPLAY "Move ",g_form_tree[l_i].b_id," TO ",g_form_tree[l_drop_idx].b_id

                        CALL adzp168_form_tree_del_area(l_i)
                        CALL adzp168t2_fill_01()
                        CALL adzp168_form_tree_add_col("ftree",l_i,l_drop_idx) RETURNING l_addcol_cnt
                        IF l_addcol_cnt = 0 THEN
                           #沒有拖曳成功,再放回原位
                           CALL adzp168_form_tree_add_col("ftree",l_i,l_i) RETURNING l_addcol_cnt
                        END IF
                     END IF
                  END IF

                  IF (g_form_tree[l_drop_idx].dzfr006 = "Field" OR g_form_tree[l_drop_idx].dzfr006 = "ghost") THEN
                     LET l_i = l_i - 1
                  ELSE
                     LET l_i = l_i + 1
                  END IF
               END WHILE

               CALL adzp168_form_tree_fill("0",0,"0",FALSE)   #重整tree
               CALL adzp168_m_to_browse(g_ftree_idx_t) RETURNING g_ftree_idx #把單頭欄位依序產生到s_browse
               LET g_ftree_idx = l_drop_idx   #停留在拖曳的目標列
               CALL DIALOG.setCurrentRow("s_form_tree",g_ftree_idx)
               #CALL l_dnd.dropInternal()
            END IF
      END DISPLAY


      BEFORE DIALOG
         CALL DIALOG.setSelectionMode("s_column",1)     #multi-range selection   #FUN-141120
         CALL DIALOG.setSelectionMode("s_form_tree",1)  #multi-range selection

         CALL adzp168_col_setcolor()
         CALL DIALOG.setArrayAttributes("s_column", g_column_att)   #欄位列表顏色屬性,已使用的欄位要變色

         IF g_tbtree_idx > 0 THEN
            CALL DIALOG.setCurrentRow("s_tabtree",g_tbtree_idx)
            CALL adzp168_col_fill(g_tbtree[g_tbtree_idx].b_tableid)
            CALL adzp168_set_act_status_config() RETURNING l_chk
            CALL DIALOG.setActionActive("status_config",l_chk)

            #FUN-141120
            #挑選欄位支援多選方式
            LET l_cnt = g_column.getLength()
            FOR l_i = l_cnt TO 1 STEP -1
               IF g_column[l_i].b_sel = "Y" THEN
                  CALL DIALOG.setSelectionRange( "s_column", l_i, l_i, TRUE)
               ELSE
                  CALL DIALOG.setSelectionRange( "s_column", l_i, l_i, FALSE)
               END IF
            END FOR
         END IF

         CALL adzp168_set_entry_by_type(p_cmd,FALSE)

         CALL adzp168_form_tree_root_idx(g_ftree_idx) RETURNING l_root_idx

         CALL adzp168_set_act_add_master(l_root_idx) RETURNING l_chk
         CALL DIALOG.setActionActive("add_master",l_chk)
         CALL adzp168_set_act_del_master(l_root_idx) RETURNING l_chk
         CALL DIALOG.setActionActive("del_master",l_chk)

         CALL adzp168_set_act_add_detail(l_root_idx) RETURNING l_chk
         CALL DIALOG.setActionActive("add_detail",l_chk)
         CALL adzp168_set_act_del_detail(l_root_idx) RETURNING l_chk
         CALL DIALOG.setActionActive("del_detail",l_chk)

         CALL adzp168_set_act_add_pageinfo(l_root_idx) RETURNING l_chk
         CALL DIALOG.setActionActive("add_pageinfo",l_chk)

         CALL adzp168_tree_config_chk(FALSE) RETURNING l_i
         IF l_i > 0 THEN
            CALL DIALOG.setActionActive("tree_config",TRUE)
         ELSE
            CALL DIALOG.setActionActive("tree_config",FALSE)
         END IF

         CALL adzp168_set_act_status_config() RETURNING l_chk
         CALL DIALOG.setActionActive("status_config",l_chk)

         CALL adzp168_set_act_col_up(g_ftree_idx) RETURNING l_chk
         CALL DIALOG.setActionActive("col_up",l_chk)
         CALL adzp168_set_act_col_down(g_ftree_idx) RETURNING l_chk
         CALL DIALOG.setActionActive("col_down",l_chk)


      ON ACTION focus_page_2
         IF g_dzfq_m.dzfq015 = "N" THEN
            CALL DIALOG.nextField("dzea001")
            CALL DIALOG.setCurrentRow("s_tabtree",g_tbtree_idx)
            CALL DIALOG.setCurrentRow("s_column",g_column_idx)
         ELSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00019"   #空框架畫面檔不需要設定欄位
            LET g_errparam.extend = NULL
            LET g_errparam.popup = TRUE
            CALL cl_err()
            CALL DIALOG.nextField("formonly.cbo_setbrowse")
         END IF

      ON ACTION focus_page_toolbar
         LET l_cnt = g_toolbar.getLength()
         IF l_cnt = 0 THEN
            CALL adzp168_toolbar(FALSE)
            LET l_cnt = g_toolbar.getLength()
         END IF
         IF l_cnt > 0 THEN
            CALL DIALOG.nextField("toolbar_chk")
         END IF

      ON ACTION add_table   #設定Table - 加入Table
         IF NOT cl_null(g_table_add) THEN
            LET l_chk = TRUE
            LET l_img_dir = "16/"

            LET l_cnt = 0
            LET g_sql = "SELECT COUNT(dzea001) FROM dzea_t WHERE dzea001 = ?"
            PREPARE adzp168_dzea001_cnt_pre FROM g_sql
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'PREPARE:'
               LET g_errparam.popup = FALSE
               CALL cl_err()
            END IF
            EXECUTE adzp168_dzea001_cnt_pre USING g_table_add INTO l_cnt

            IF l_cnt = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  "adz-00050"
               LET g_errparam.extend = NULL
               LET g_errparam.popup = TRUE
               LET g_errparam.replace[1] =  g_table_add
               CALL cl_err()
            ELSE
               IF l_chk THEN
                  LET l_tbtree_cnt = g_tbtree.getLength()
                  LET l_i = l_tbtree_cnt + 1

                  #虛擬節點
                  IF l_tbtree_cnt = 0 THEN
                     LET g_tbtree[l_i].b_tableid   = "Table"
                     LET g_tbtree[l_i].b_tablename = ""
                     LET g_tbtree[l_i].b_img   = l_img_dir CLIPPED,"database"
                     LET g_tbtree[l_i].b_pid   = ""
                     LET g_tbtree[l_i].b_id    = "0"
                     LET g_tbtree[l_i].b_hasC  = TRUE
                     LET g_tbtree[l_i].b_exp   = TRUE
                     LET g_tbtree[l_i].b_level = 0
                     LET l_tbtree_cnt = g_tbtree.getLength()
                     LET l_i = l_tbtree_cnt + 1
                  END IF

                  IF l_tbtree_cnt = 1 THEN
                        LET g_tbtree[l_i].b_tableid   = g_table_add
                        CALL adzp168_tablename(g_table_add) RETURNING g_tbtree[l_i].b_tablename

                        LET g_tbtree[l_i].b_img   = l_img_dir CLIPPED,"headeraction"
                        LET g_tbtree[l_i].b_pid   = "0"
                        LET g_tbtree[l_i].b_id    = "0.1"
                        LET g_tbtree[l_i].b_hasC  = FALSE
                        LET g_tbtree[l_i].b_exp   = FALSE
                        LET g_tbtree[l_i].b_level = 1
                        EXECUTE adzp168_info_col_stus USING g_table_add,g_lang INTO g_tbtree[l_i].b_stus,l_gzzd005

                        LET l_isadd = TRUE
                        LET g_tbtree_idx = l_i
                        CALL DIALOG.setCurrentRow("s_tabtree",g_tbtree_idx)
                        CALL adzp168_prog_class()
                        CALL adzp168_col_fill(g_table_add)
                  ELSE  #add下層節點
                     IF l_tbtree_cnt = 1 THEN
                        LET g_tbtree_idx = 1
                        CALL DIALOG.setCurrentRow("s_tabtree",g_tbtree_idx)
                     END IF

                     LET l_isadd = TRUE
                     #只有單頭主Table才可以加入子Table
                     #IF g_tbtree[g_tbtree_idx].b_id <> "0" AND g_tbtree_idx > 2 THEN

                     #樣版規範：只能由單頭主Table往下延伸，而且最多只能加到第三層
                     IF g_tbtree_idx >= 2 THEN
                        LET l_str = g_tbtree[g_tbtree_idx].b_id
                        IF l_str.getIndexOf(g_tbtree[2].b_id,1) = 0 THEN
                           LET l_isadd = FALSE
                        END IF
                        #最多只能加到第三層
                        IF g_tbtree[g_tbtree_idx].b_level > 3 THEN
                           LET l_isadd = FALSE
                        END IF
                     END IF
                     IF NOT l_isadd THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code =  "adz-00186"
                        LET g_errparam.extend = NULL
                        LET g_errparam.popup = TRUE
                        CALL cl_err()
                     END IF

                     #Table代碼重複,不可加入節點
                     IF l_isadd THEN
                        FOR l_j = 1 TO l_tbtree_cnt
                           IF g_table_add = g_tbtree[l_j].b_tableid THEN
                              LET l_isadd = FALSE
                              INITIALIZE g_errparam TO NULL
                              LET g_errparam.code =  "std-00004"
                              LET g_errparam.extend = NULL
                              LET g_errparam.popup = TRUE
                              CALL cl_err()
                              EXIT FOR
                           END IF
                        END FOR
                     END IF

                     #加入節點
                     IF l_isadd = TRUE AND g_tbtree_idx > 0 AND g_tbtree_idx <= l_tbtree_cnt THEN
                        LET ls_pid = g_tbtree[g_tbtree_idx].b_id
                        #檢查父子Table之間是否有設外來鍵
                        IF g_tbtree[g_tbtree_idx].b_id = "0" THEN   #檢查
                           #查主Table
                           FOR l_j = 1 TO l_tbtree_cnt
                              IF g_tbtree[l_j].b_pid = g_tbtree[g_tbtree_idx].b_id THEN
                                 LET l_tb_master = g_tbtree[l_j].b_tableid
                                 EXIT FOR
                              END IF
                           END FOR

                           CALL adzp168_table_fkchk(g_table_add, l_tb_master,"F",FALSE) RETURNING l_isadd   #檢查父子Table之間的外來鍵是否設定完整
                        ELSE
                           #依結構代號限制
                           LET l_str = g_dzfq_m.cbo_progtype CLIPPED,g_dzfq_m.cbo_formtype CLIPPED

                           #不可以設多階層
                           IF l_str = "F001" THEN
                              LET l_isadd = FALSE
                           END IF

                           IF l_isadd THEN
                              CALL adzp168_table_fkchk(g_table_add, g_tbtree[g_tbtree_idx].b_tableid,"F",TRUE) RETURNING l_isadd
                              #IF adzp168_table_fkchk(g_table_add, g_tbtree[g_tbtree_idx].b_tableid,"F",TRUE) = 0 THEN
                              #   LET l_isadd = FALSE
                              #   CALL cl_err_msg(NULL, "adz-00051", g_table_add CLIPPED || "|" || g_tbtree[g_tbtree_idx].b_tableid CLIPPED || "|Foreign", 0) #%1中沒有設來自於%2的外來鍵
                              #END IF
                           END IF
                        END IF

                        IF l_isadd THEN   #檢查
                           #id序號
                           LET ls_id_seq = NULL
                           LET l_str = NULL
                           IF g_tbtree[g_tbtree_idx].b_hasC THEN
                              FOR l_n = 1 TO l_tbtree_cnt
                                 IF g_tbtree[l_n].b_pid = g_tbtree[g_tbtree_idx].b_id THEN
                                    LET l_str = g_tbtree[l_n].b_id
                                 END IF
                              END FOR
                           ELSE
                              LET ls_id_seq = "1"
                           END IF

                           IF cl_null(ls_id_seq) THEN
                              LET l_k = 0
                              LET l_tok = base.StringTokenizer.createExt(l_str CLIPPED,".","",TRUE)
                              WHILE l_tok.hasMoreTokens()
                                 LET ls_id_seq = l_tok.nextToken()
                              END WHILE
                              LET l_k = ls_id_seq.trim()   #ex: 2
                              LET ls_id_seq = l_k + 1      #ex: 3
                           END IF

                           #父節點
                           LET g_tbtree[g_tbtree_idx].b_hasC = TRUE
                           LET g_tbtree[g_tbtree_idx].b_exp = TRUE

                           #新增節點
                           LET l_j = 0   #查父節點底下子孫排到陣列中的最後index
                           LET l_str = ls_pid CLIPPED || "."
                           FOR l_n = 1 TO l_tbtree_cnt
                              LET l_str2 = g_tbtree[l_n].b_id
                              IF l_str2.getIndexOf(l_str,1) = 1 THEN
                                 LET l_j = l_n
                              END IF
                           END FOR

                           IF l_j = 0 THEN
                              LET l_i = g_tbtree_idx + 1  #加在父節點後面
                           ELSE
                              LET l_i = l_j + 1           #加在父節點的子孫群後面
                           END IF
                           IF g_tbtree_idx < l_tbtree_cnt THEN
                              CALL g_tbtree.insertElement(l_i)
                           END IF

                           LET g_tbtree[l_i].b_tableid   = g_table_add
                           CALL adzp168_tablename(g_table_add) RETURNING g_tbtree[l_i].b_tablename
                           LET g_tbtree[l_i].b_pid   = ls_pid
                           LET g_tbtree[l_i].b_id = g_tbtree[g_tbtree_idx].b_id CLIPPED || "." || ls_id_seq CLIPPED  #ex: 1.1.3
                           LET g_tbtree[l_i].b_hasC  = FALSE
                           LET g_tbtree[l_i].b_exp   = FALSE
                           LET g_tbtree[l_i].b_level = g_tbtree[g_tbtree_idx].b_level + 1
                           IF g_tbtree[l_i].b_level = 1 THEN
                              LET g_tbtree[l_i].b_img = l_img_dir CLIPPED,"headeraction"
                           ELSE
                              LET g_tbtree[l_i].b_img = l_img_dir CLIPPED,"detailaction"
                           END IF

                           EXECUTE adzp168_info_col_stus USING g_table_add,g_lang INTO g_tbtree[l_i].b_stus,l_gzzd005

                           CALL adzp168_tbtree_delnull() #資料表設定 - 刪除自動冒出來的空資料

                           LET l_isadd = TRUE
                           LET g_tbtree_idx = l_i
                           CALL DIALOG.setCurrentRow("s_tabtree",g_tbtree_idx)

                           IF adzp168_jiashuangdang_change() THEN   #假雙檔加了單身Table變成不是假雙檔後，要刪除放在單身的單頭欄位
                              CALL DIALOG.setCurrentRow("s_form_tree",g_ftree_idx)
                           END IF
                           CALL adzp168_prog_class()
                           CALL adzp168_col_fill(g_table_add)
                        END IF
                     END IF
                  END IF

               END IF

               IF l_chk AND l_isadd AND g_tbtree_idx > 0 THEN
                  #主程式在拉入Table後，視版型自動新增page_info及帶入共用欄位
                  IF g_dzfq_m.dzfq005 = "M" THEN
                     CALL adzp168_common_col_add_01(g_tbtree_idx)   #自動新增共用欄位
                     CALL adzp168_col_setcolor()
                     CALL DIALOG.setArrayAttributes("s_column", g_column_att)   #欄位列表顏色屬性,已使用的欄位要變色
                     CALL DIALOG.setCurrentRow("s_form_tree",g_ftree_idx)
                  END IF

                  CALL adzp168_default_set_dzfq006() RETURNING l_entry

                  CALL adzp168_set_act_status_config() RETURNING l_chk
                  CALL DIALOG.setActionActive("status_config",l_chk)
               END IF

            END IF
         END IF


      ON ACTION del_table   #設定Table - 刪除Table
         LET l_tbtree_cnt = g_tbtree.getLength()

         IF g_tbtree_idx > 1 AND g_tbtree_idx <= l_tbtree_cnt THEN
            IF cl_ask_confirm_parm("adz-00064","") = TRUE THEN   #是否刪除此筆資料
               LET ls_id = g_tbtree[g_tbtree_idx].b_id
               LET ls_pid = g_tbtree[g_tbtree_idx].b_pid
               LET l_str = ls_id CLIPPED || "."
               #刪本節點
               CALL adzp168_form_tree_del_col02(g_tbtree[g_tbtree_idx].b_tableid)   #刪除欄位by table

               CALL g_tbtree.deleteElement(g_tbtree_idx)

               LET l_tbtree_cnt = g_tbtree.getLength()
               IF l_tbtree_cnt > 0 THEN
                  LET l_cnt = 0    #兄弟數
                  FOR l_n = 1 TO l_tbtree_cnt
                     IF ls_pid = g_tbtree[l_n].b_pid THEN #相同父節點
                        LET l_cnt = l_cnt + 1
                        LET g_tbtree_idx = l_n
                     END IF
                  END FOR

                  FOR l_i = l_tbtree_cnt TO 1 STEP -1
                     #父節點無子
                     IF g_tbtree[l_i].b_id = ls_pid AND l_cnt = 0 THEN
                        LET g_tbtree[l_i].b_hasC  = FALSE
                        LET g_tbtree[l_i].b_exp   = FALSE
                        LET g_tbtree_idx = l_i
                     END IF

                     #刪子節點
                     LET l_str2 = g_tbtree[l_i].b_id
                     IF l_str2.getIndexOf(l_str,1) = 1 THEN
                        CALL adzp168_form_tree_del_col02(g_tbtree[l_i].b_tableid)   #刪除欄位by table
                        CALL g_tbtree.deleteElement(l_i)
                     END IF
                  END FOR
               END IF

               IF g_tbtree.getLength() = 0 THEN
                  LET g_tbtree_idx = 0
                  EXECUTE adzp168t3_del_all_pre USING g_dzfq_m.dzfq004,g_ver_dzag003    #刪除暫存檔dzff
               ELSE
                  LET g_tbtree_idx = 1
               END IF
               IF g_tbtree_idx > 0 THEN
                  CALL DIALOG.setCurrentRow("s_tabtree",g_tbtree_idx)
                  CALL adzp168_col_fill(g_tbtree[g_tbtree_idx].b_tableid)
               ELSE
                  CALL DIALOG.nextField("dzea001")  #focus 避免離開input時focus到畫面右下方
                  CALL adzp168_col_fill(NULL)
               END IF

               CALL adzp168_tbtree_delnull() #資料表設定 - 刪除自動冒出來的空資料

               CALL adzp168_set_act_status_config() RETURNING l_chk
               CALL DIALOG.setActionActive("status_config",l_chk)

               CALL adzp168_form_tree_fill("0",0,"0",FALSE)   #刪完後再重整tree
               CALL adzp168_form_tree_del_chkarea()
               CALL adzp168_form_tree_fill("0",0,"0",FALSE)   #刪完後再重整tree

               LET l_cnt = g_form_tree.getLength()
               IF g_ftree_idx > l_cnt THEN
                  LET g_ftree_idx = l_cnt
               END IF
               CALL DIALOG.setCurrentRow("s_form_tree",g_ftree_idx)

               CALL adzp168_col_setcolor()
               CALL DIALOG.setArrayAttributes("s_column", g_column_att)   #欄位列表顏色屬性,已使用的欄位要變色

               #加入欄位的按鈕
               CALL adzp168_set_act_add_col() RETURNING l_chk
               CALL DIALOG.setActionActive("add_col",l_chk)

               #Table中有欄位才可以挑選
               #IF g_column.getLength() > 0 AND g_form_tree.getLength() > 0 THEN
               #   CALL DIALOG.setActionActive("add_col",TRUE)
               #ELSE
               #   CALL DIALOG.setActionActive("add_col",FALSE)
               #END IF

            END IF

            CALL adzp168_prog_class()  #例外檢查的程式類型(假雙檔:JiaShuangDang)
            CALL adzp168_dzfq016()   #樹狀結構類別設定值是否清空
         END IF


      ON ACTION status_config   #設定狀態碼
         LET l_cnt = 0
         IF g_tbtree_idx > 0 THEN
            IF adzp168_set_act_status_config() THEN
               CALL adzp168_stus(g_tbtree_idx)
            END IF
         END IF


      ON ACTION selectgeneral   #挑選欄位 - 一般欄位全選
         CALL adzp168_selectinfo("selectgeneral","Y")
         #FUN-141120
         #挑選欄位支援多選方式
         LET l_cnt = g_column.getLength()
         FOR l_i = l_cnt TO 1 STEP -1
            IF g_column[l_i].b_sel = "Y" THEN
               CALL DIALOG.setSelectionRange( "s_column", l_i, l_i, TRUE)
            ELSE
               CALL DIALOG.setSelectionRange( "s_column", l_i, l_i, FALSE)
            END IF
         END FOR

      ON ACTION selectgeneral_none   #挑選欄位 - 一般欄位全不選
         CALL adzp168_selectinfo("selectgeneral","N")
         #FUN-141120
         #挑選欄位支援多選方式
         LET l_cnt = g_column.getLength()
         FOR l_i = l_cnt TO 1 STEP -1
            IF g_column[l_i].b_sel = "Y" THEN
               CALL DIALOG.setSelectionRange( "s_column", l_i, l_i, TRUE)
            ELSE
               CALL DIALOG.setSelectionRange( "s_column", l_i, l_i, FALSE)
            END IF
         END FOR

      ON ACTION selectinfo   #挑選欄位 - 共用欄位全選
         CALL adzp168_selectinfo("selectinfo","Y")
         #FUN-141120
         #挑選欄位支援多選方式
         LET l_cnt = g_column.getLength()
         FOR l_i = l_cnt TO 1 STEP -1
            IF g_column[l_i].b_sel = "Y" THEN
               CALL DIALOG.setSelectionRange( "s_column", l_i, l_i, TRUE)
            ELSE
               CALL DIALOG.setSelectionRange( "s_column", l_i, l_i, FALSE)
            END IF
         END FOR

      ON ACTION selectinfo_none   #挑選欄位 - 共用欄位全不選
         CALL adzp168_selectinfo("selectinfo","N")
         #FUN-141120
         #挑選欄位支援多選方式
         LET l_cnt = g_column.getLength()
         FOR l_i = l_cnt TO 1 STEP -1
            IF g_column[l_i].b_sel = "Y" THEN
               CALL DIALOG.setSelectionRange( "s_column", l_i, l_i, TRUE)
            ELSE
               CALL DIALOG.setSelectionRange( "s_column", l_i, l_i, FALSE)
            END IF
         END FOR

      ON ACTION add_col_ghost  #畫面設計 - 加入空白欄位
         CALL adzp168_form_tree_add_col_ghost()


      ON ACTION add_col  #畫面設計 - 加入欄位
         #FUN-141120
         #挑選欄位支援多選方式
         LET l_cnt = g_column.getLength()
         FOR l_i = l_cnt TO 1 STEP -1
            IF DIALOG.isRowSelected("s_column",l_i) THEN
               LET g_column[l_i].b_sel = "Y"
            ELSE
               LET g_column[l_i].b_sel = "N"
            END IF
            #強制勾選或不選
            CALL adzp168_col_must_sel(g_column[l_i].b_sel,l_i,TRUE) RETURNING g_column[l_i].b_sel
            #有勾選的變成選取列
            IF g_column[l_i].b_sel = "Y" THEN
               CALL DIALOG.setSelectionRange( "s_column", l_i, l_i, TRUE)
            ELSE
               CALL DIALOG.setSelectionRange( "s_column", l_i, l_i, FALSE)
            END IF
         END FOR


         LET g_ftree_idx_t = g_ftree_idx
         CALL adzp168_form_tree_add_col("column",0,g_ftree_idx) RETURNING l_addcol_cnt

         CALL adzp168_m_to_browse(g_ftree_idx_t) RETURNING g_ftree_idx #把單頭欄位依序產生到s_browse
         #LET l_cnt = g_form_tree.getLength()
         CALL DIALOG.setCurrentRow("s_form_tree",g_ftree_idx)

         #LET g_ftree_idx = DIALOG.getCurrentRow("s_form_tree")
         CALL adzp168_col_setcolor()
         CALL DIALOG.setArrayAttributes("s_column", g_column_att)   #欄位列表顏色屬性,已使用的欄位要變色
         #樹狀設定
         CALL adzp168_tree_config_chk(FALSE) RETURNING l_i
         IF l_i > 0 THEN
            CALL DIALOG.setActionActive("tree_config",TRUE)
         ELSE
            CALL DIALOG.setActionActive("tree_config",FALSE)
         END IF

      ON ACTION del_col   #畫面設計 - 刪除欄位
         IF g_ftree_idx > 0 THEN
            LET g_ftree_idx_t = 0  #刪除後的指標

            LET l_cnt = g_form_tree.getLength()
            FOR l_i = l_cnt TO 1 STEP -1   #從後面的欄位先刪除
               IF DIALOG.isRowSelected("s_form_tree",l_i) THEN
                  IF (g_form_tree[l_i].dzfr006 = "Field" OR g_form_tree[l_i].dzfr006 = "ghost") AND g_form_tree[l_i].dzfr011 = "Y" THEN
                     CALL adzp168_form_tree_del_area(l_i)
                     LET g_ftree_idx_t = l_i
                  END IF
               END IF
            END FOR
            IF g_ftree_idx_t > 0 THEN  #刪除後的指標
               LET l_dzfr004 = g_form_tree[g_ftree_idx_t].dzfr004   #父節點編號
            ELSE
               LET g_ftree_idx_t = 1
            END IF

            CALL adzp168_form_tree_fill("0",0,"0",FALSE)   #多選刪完後再重整tree

            LET l_cnt = g_form_tree.getLength()
            IF g_ftree_idx_t > l_cnt THEN
               LET g_ftree_idx_t = l_cnt
            END IF

            IF g_ftree_idx_t > 0 THEN #刪除後的指標
               IF g_form_tree[g_ftree_idx_t].dzfr004 = l_dzfr004 THEN
                  LET g_ftree_idx = g_ftree_idx_t
               END IF
            END IF

            CALL adzp168_m_to_browse(g_ftree_idx_t) RETURNING g_ftree_idx #把單頭欄位依序產生到s_browse
            CALL DIALOG.setCurrentRow("s_form_tree",g_ftree_idx)


            CALL adzp168_form_tree_root_idx(g_ftree_idx) RETURNING l_root_idx

            CALL adzp168_set_act_add_col() RETURNING l_chk
            CALL DIALOG.setActionActive("add_col",l_chk)
            CALL adzp168_set_act_add_col_ghost() RETURNING l_chk
            CALL DIALOG.setActionActive("add_col_ghost",l_chk)

            CALL adzp168_set_act_col_up(g_ftree_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("col_up",l_chk)
            CALL adzp168_set_act_col_down(g_ftree_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("col_down",l_chk)

            CALL adzp168_set_act_add_master(l_root_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("add_master",l_chk)
            CALL adzp168_set_act_del_master(l_root_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("del_master",l_chk)

            CALL adzp168_set_act_add_detail(l_root_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("add_detail",l_chk)
            CALL adzp168_set_act_del_detail(l_root_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("del_detail",l_chk)

            CALL adzp168_set_act_add_pageinfo(l_root_idx) RETURNING l_chk
            CALL DIALOG.setActionActive("add_pageinfo",l_chk)

            CALL adzp168_tree_config_chk(FALSE) RETURNING l_i
            IF l_i > 0 THEN
               CALL DIALOG.setActionActive("tree_config",TRUE)
            ELSE
               CALL DIALOG.setActionActive("tree_config",FALSE)
            END IF

            CALL adzp168_set_act_status_config() RETURNING l_chk
            CALL DIALOG.setActionActive("status_config",l_chk)

            CALL adzp168_col_setcolor()
            CALL DIALOG.setArrayAttributes("s_column", g_column_att)   #欄位列表顏色屬性,已使用的欄位要變色
            #樹狀設定
            CALL adzp168_tree_config_chk(FALSE) RETURNING l_i
            IF l_i > 0 THEN
               CALL DIALOG.setActionActive("tree_config",TRUE)
            ELSE
               CALL DIALOG.setActionActive("tree_config",FALSE)
            END IF
        END IF


      ON ACTION col_up     #畫面設計 - 欄位往前
         IF g_ftree_idx > 0 THEN
            LET l_cnt = g_form_tree.getLength()
            LET l_k = 0    #異動數量

            LET l_i = g_ftree_idx
            #多選功能
            #FOR l_i = 2 TO l_cnt
            #   IF DIALOG.isRowSelected("s_form_tree",l_i) THEN
                  CALL adzp168_set_act_col_up(l_i) RETURNING l_chk
                  IF l_chk THEN
                     LET l_j = g_form_tree[l_i].dzfr005 - 1
                     UPDATE adzp168t1 SET dzfr005 = dzfr005 + 1
                        WHERE dzfr003 = (
                           SELECT dzfr003 FROM adzp168t1
                           WHERE dzfr004 = g_form_tree[l_i].dzfr004 AND dzfr005 = l_j)
                     UPDATE adzp168t1 SET dzfr005 = dzfr005 - 1
                        WHERE dzfr003 = g_form_tree[l_i].dzfr003

                     LET l_k = l_k + 1
                     IF l_k = 1 THEN
                        LET l_dzfr003 = g_form_tree[l_i].dzfr003
                     END IF
                  END IF
            #   END IF
            #END FOR

            IF l_k > 0 THEN  #有異動
               CALL adzp168_form_tree_fill("0",0,"0",TRUE)
               #focus在原本選的第一筆資料
               FOR l_i = 2 TO l_cnt
                  IF g_form_tree[l_i].dzfr003 = l_dzfr003 THEN
                     LET g_ftree_idx = l_i
                     EXIT FOR
                  END IF
               END FOR

               CALL DIALOG.setCurrentRow("s_form_tree",g_ftree_idx)

               CALL adzp168_set_act_col_up(g_ftree_idx) RETURNING l_chk
               CALL DIALOG.setActionActive("col_up",l_chk)
               CALL adzp168_set_act_col_down(g_ftree_idx) RETURNING l_chk
               CALL DIALOG.setActionActive("col_down",l_chk)
            END IF
         END IF


      ON ACTION col_down   #畫面設計 - 欄位往後
         IF g_ftree_idx > 0 THEN
            LET l_cnt = g_form_tree.getLength()
            LET l_k = 0    #異動數量

            LET l_i = g_ftree_idx
            #多選功能
            #FOR l_i = l_cnt TO 2 STEP -1
            #   IF DIALOG.isRowSelected("s_form_tree",l_i) THEN
                  CALL adzp168_set_act_col_down(l_i) RETURNING l_chk
                  IF l_chk THEN
                     LET l_j = g_form_tree[l_i].dzfr005 + 1
                     UPDATE adzp168t1 SET dzfr005 = dzfr005 - 1
                        WHERE dzfr003 = (
                           SELECT dzfr003 FROM adzp168t1
                           WHERE dzfr004 = g_form_tree[l_i].dzfr004 AND dzfr005 = l_j)
                     UPDATE adzp168t1 SET dzfr005 = dzfr005 + 1
                        WHERE dzfr003 = g_form_tree[l_i].dzfr003

                     LET l_k = l_k + 1
                     IF l_k = 1 THEN
                        LET l_dzfr003 = g_form_tree[l_i].dzfr003
                     END IF
                  END IF
            #   END IF
            #END FOR

            IF l_k > 0 THEN  #有異動
               CALL adzp168_form_tree_fill("0",0,"0",TRUE)
               #focus在原本選的第一筆資料
               FOR l_i = 2 TO l_cnt
                  IF g_form_tree[l_i].dzfr003 = l_dzfr003 THEN
                     LET g_ftree_idx = l_i
                     EXIT FOR
                  END IF
               END FOR

               CALL DIALOG.setCurrentRow("s_form_tree",g_ftree_idx)

               CALL adzp168_set_act_col_up(g_ftree_idx) RETURNING l_chk
               CALL DIALOG.setActionActive("col_up",l_chk)
               CALL adzp168_set_act_col_down(g_ftree_idx) RETURNING l_chk
               CALL DIALOG.setActionActive("col_down",l_chk)
            END IF
         END IF


         ON ACTION add_master   #加入單頭區塊
            CALL adzp168_form_add_master("vb_master",g_ftree_idx,g_dzfq_m.dzfq007,"Y")


         ON ACTION del_master   #刪除單頭區塊
            CALL adzp168_form_tree_root_idx(g_ftree_idx) RETURNING l_root_idx
            #IF g_form_tree[l_root_idx].dzfr007 = "vb_master" AND g_form_tree[g_ftree_idx].dzfr011 = "Y" THEN
            CALL adzp168_set_act_del_master(l_root_idx) RETURNING l_chk
            IF l_chk THEN
               CALL adzp168_form_tree_del_area(g_ftree_idx)
               CALL adzp168_form_tree_fill("0",0,"0",FALSE)   #多選刪完後再重整tree
               CALL DIALOG.setCurrentRow("s_form_tree",g_ftree_idx)

               CALL adzp168_set_act_col_up(g_ftree_idx) RETURNING l_chk
               CALL DIALOG.setActionActive("col_up",l_chk)
               CALL adzp168_set_act_col_down(g_ftree_idx) RETURNING l_chk
               CALL DIALOG.setActionActive("col_down",l_chk)

               CALL adzp168_set_act_add_master(l_root_idx) RETURNING l_chk
               CALL DIALOG.setActionActive("add_master",l_chk)
               CALL adzp168_set_act_del_master(l_root_idx) RETURNING l_chk
               CALL DIALOG.setActionActive("del_master",l_chk)

               CALL adzp168_col_setcolor()
               CALL DIALOG.setArrayAttributes("s_column", g_column_att)   #欄位列表顏色屬性,已使用的欄位要變色
            END IF


         ON ACTION add_detail   #加入單身區塊
            #CALL adzp168_set_act_add_col_ghost() RETURNING l_chk
            #IF l_chk THEN
            #   CALL adzp168_form_tree_add_col_ghost()   #畫面設計 - 加入空白欄位
            #ELSE
               CALL adzp168_form_add_detail(g_ftree_idx,"Y") RETURNING l_dzfr003
            #END IF


         ON ACTION del_detail   #刪除單身區塊
            CALL adzp168_form_tree_root_idx(g_ftree_idx) RETURNING l_root_idx
            #IF g_form_tree[l_root_idx].dzfr007 = "vb_detail" AND g_form_tree[g_ftree_idx].dzfr011 = "Y" AND g_form_tree[g_ftree_idx].dzfr006 <> "Field" THEN
            CALL adzp168_set_act_del_detail(l_root_idx) RETURNING l_chk
            IF l_chk THEN
               CALL adzp168_form_tree_del_area(g_ftree_idx)
               CALL adzp168_form_tree_fill("0",0,"0",FALSE)   #多選刪完後再重整tree
               CALL DIALOG.setCurrentRow("s_form_tree",g_ftree_idx)

               CALL adzp168_set_act_col_up(g_ftree_idx) RETURNING l_chk
               CALL DIALOG.setActionActive("col_up",l_chk)
               CALL adzp168_set_act_col_down(g_ftree_idx) RETURNING l_chk
               CALL DIALOG.setActionActive("col_down",l_chk)

               CALL adzp168_col_setcolor()
               CALL DIALOG.setArrayAttributes("s_column", g_column_att)   #欄位列表顏色屬性,已使用的欄位要變色

               CALL adzp168_set_act_add_detail(l_root_idx) RETURNING l_chk
               CALL DIALOG.setActionActive("add_detail",l_chk)
               CALL adzp168_set_act_del_detail(l_root_idx) RETURNING l_chk
               CALL DIALOG.setActionActive("del_detail",l_chk)

               CALL adzp168_set_act_add_pageinfo(l_root_idx) RETURNING l_chk
               CALL DIALOG.setActionActive("add_pageinfo",l_chk)

               CALL adzp168_tree_config_chk(FALSE) RETURNING l_i
               IF l_i > 0 THEN
                  CALL DIALOG.setActionActive("tree_config",TRUE)
               ELSE
                  CALL DIALOG.setActionActive("tree_config",FALSE)
               END IF

               CALL adzp168_set_act_status_config() RETURNING l_chk
               CALL DIALOG.setActionActive("status_config",l_chk)
            END IF



      ON ACTION add_pageinfo  #加入狀態頁籤
         CALL adzp168_form_add_pageinfo(g_ftree_idx,"Y") RETURNING l_dzfr003,l_dzfr003_child


      ON ACTION tree_config   #樹狀設定
         LET g_ftree_idx = DIALOG.getCurrentRow("s_form_tree")
         CALL adzp168_tree_config_chk(TRUE) RETURNING l_i
         IF l_i > 0 THEN
            CALL adzp168_01(l_i)

            CALL adzp168_treeconfig_to_4fd(g_ftree_idx_t) RETURNING g_ftree_idx,l_reflash
            IF l_reflash THEN
               CALL DIALOG.setCurrentRow("s_form_tree",g_ftree_idx)
            END IF
         ELSE
            CALL DIALOG.setActionActive("tree_config",FALSE)
         END IF

      #ON ACTION del_tsd   #刪除TSD資料

      ON ACTION gen_4fd   #產生4fd
         LET g_def_reset = FALSE   #是否重設預設值
         LET g_action_choice = "gen_4fd"
         CALL adzp168_treeconfig_to_4fd(g_ftree_idx_t) RETURNING g_ftree_idx,l_reflash
         IF l_reflash THEN
            CALL DIALOG.setCurrentRow("s_form_tree",g_ftree_idx)
         END IF
         ACCEPT DIALOG

      ON ACTION draft_save
         LET g_def_reset = FALSE   #是否重設預設值
         LET g_action_choice = "draft_save"
         ACCEPT DIALOG

      ON ACTION draft_read   #開啟底稿
         LET g_action_choice = "draft_read"
         LET l_str = "dzfv001='",g_ver_ra CLIPPED,"'"   #限定r.a設計工具版號
         CALL sadzp168_1_prog_draft_qry("i",g_gzza003,g_dzfq_m.dzfq004,g_dzfq_m.gzzal003,l_str) RETURNING g_gzza003,g_dzfq_m.dzfq004,g_dzfq_m.gzzal003   #開窗-底稿程式代號

         CALL sadzp168_1_gzza002(g_dzfq_m.dzfq004,g_dzfq_m.dzfq005) RETURNING g_gzza002,g_gzza003,g_gzza003_module,g_dzfq_m.gzzal003      #程式類別,模組代碼,程式名稱,是否使用樣板
         DISPLAY g_dzfq_m.gzzal003 TO lb_gzzal003
         EXIT DIALOG


      ON ACTION controlf
         CALL cl_set_focus_form(ui.Interface.getRootNode()) RETURNING g_fld_name,g_frm_name
         CALL cl_fldhelp(g_frm_name,g_fld_name,g_lang)

      ON ACTION controlr
         CALL cl_show_req_fields()

      ON ACTION controls
         CALL cl_set_head_visible("","AUTO")

      #ON ACTION accept
      #   DISPLAY "ACCEPT DIALOG"

      #ON ACTION cancel      #在dialog button (放棄)
      #   LET g_action_choice=""
      #   LET INT_FLAG = TRUE
      #   EXIT DIALOG

      ON ACTION close       #在dialog 右上角 (X)
         LET INT_FLAG=TRUE
         LET g_action_choice = "exit"
         EXIT DIALOG

      ON ACTION exit        #toolbar 離開
         LET INT_FLAG=TRUE
         LET g_action_choice = "exit"
         EXIT DIALOG

      ##交談指令共用ACTION
      #&include "common_action.4gl"
      #   CONTINUE DIALOG
      ON ACTION about
         CALL cl_about()

      ON ACTION controlg
        CALL cl_cmdask()

      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE DIALOG
      #交談指令共用ACTION --- end

   END DIALOG

   CASE g_action_choice
      WHEN "gen_4fd"
         CALL adzp168_gen_4fd()
         LET g_def_reset = FALSE         #是否重設預設值
         CALL adzp168_input(p_cmd)

      WHEN "draft_save"   #儲存底稿
         #LET g_exit_dialog_i = TRUE
         CALL adzp168_draft_save()
         LET g_def_reset = FALSE         #是否重設預設值
         #CALL adzp168_input(p_cmd)

      WHEN "draft_read"
         IF NOT cl_null(g_dzfq_m.dzfq004) THEN
            LET g_exit_dialog_i = TRUE
         END IF
   END CASE

END FUNCTION


#+ 單頭資料重新顯示及單身資料重抓
PRIVATE FUNCTION adzp168_show()
   {<Local define>}
   DEFINE l_ac_t    LIKE type_t.num5
   DEFINE l_sql     STRING
   {</Local define>}
   #add-point:show段define
   {<point name="show.define"/>}
   #end add-point

   #add-point:show段之前
   {<point name="show.before"/>}
   #end add-point

   LET g_dzfq_m_t.* = g_dzfq_m.*      #保存單頭舊值

   #帶出預設欄位之值
   LET g_dzfq_m.dzfqmodid_desc = cl_get_username(g_dzfq_m.dzfqmodid)
   LET g_dzfq_m.dzfqownid_desc = cl_get_username(g_dzfq_m.dzfqownid)
   LET g_dzfq_m.dzfqcrtid_desc = cl_get_username(g_dzfq_m.dzfqcrtid)
   LET g_dzfq_m.dzfqcrtdp_desc = cl_get_deptname(g_dzfq_m.dzfqcrtdp)
   LET g_dzfq_m.dzfqowndp_desc = cl_get_deptname(g_dzfq_m.dzfqowndp)

   DISPLAY BY NAME g_dzfq_m.dzfq004,g_dzfq_m.cbo_progtype,g_dzfq_m.cbo_formtype,g_dzfq_m.cbo_setbrowse,g_dzfq_m.dzfq005,g_dzfq_m.dzfq006,g_dzfq_m.dzfq007,g_dzfq_m.dzfq008,g_dzfq_m.dzfq009,g_dzfq_m.dzfq010,g_dzfq_m.dzfq011,g_dzfq_m.dzfq012,g_dzfq_m.dzfq013,g_dzfq_m.dzfq014,g_dzfq_m.dzfq015,g_dzfq_m.dzfqmodid,g_dzfq_m.dzfqmodid_desc,g_dzfq_m.dzfqmoddt,g_dzfq_m.dzfqownid,g_dzfq_m.dzfqownid_desc,g_dzfq_m.dzfqowndp,g_dzfq_m.dzfqowndp_desc,g_dzfq_m.dzfqcrtid,g_dzfq_m.dzfqcrtid_desc,g_dzfq_m.dzfqcrtdp,g_dzfq_m.dzfqcrtdp_desc,g_dzfq_m.dzfqcrtdt
END FUNCTION

#+ 單頭欄位開啟設定
PRIVATE FUNCTION adzp168_set_entry(p_cmd)
   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1
   {</Local define>}
   #add-point:set_entry段define
   {<point name="set_entry.define"/>}
   #end add-point

   IF p_cmd = 'a' AND ( NOT g_before_input_done ) THEN
      CALL adzp168_set_comp_entry("dzfq004",TRUE)
   END IF

END FUNCTION


#+ 單頭欄位關閉設定
PRIVATE FUNCTION adzp168_set_no_entry(p_cmd)
   {<Local define>}
   DEFINE p_cmd   LIKE type_t.chr1
   {</Local define>}
   #add-point:set_no_entry段define
   {<point name="set_no_entry.define"/>}
   #end add-point

   IF p_cmd = 'u' AND g_chkey = 'N' AND ( NOT g_before_input_done ) THEN
      CALL adzp168_set_comp_entry("dzfq004",FALSE)
   END IF

END FUNCTION

#+ 單頭欄位開啟設定-依程式,畫面類型
PRIVATE FUNCTION adzp168_set_entry_by_type(p_cmd,p_reset_all)
   DEFINE p_cmd               LIKE type_t.chr1
   DEFINE p_reset_all         BOOLEAN
   DEFINE l_type              STRING
   DEFINE l_str               STRING

   LET l_type = g_dzfq_m.cbo_progtype CLIPPED,g_dzfq_m.cbo_formtype CLIPPED
   CALL adzp168_set_comp_entry("cbo_setbrowse,dzfq006,dzfq007,dzfq008,dzfq009,dzfq010,dzfq011",TRUE)
   #CALL adzp168_set_comp_entry("dzfq010",FALSE)

   CASE
      WHEN l_type = "F001"
         CALL adzp168_set_comp_entry("dzfq009,dzfq010,dzfq011",FALSE)
         #dzfq009 單身切割框架
         #dzfq010 單身框架
         #dzfq011 單身狀態碼功能鍵區塊
         #dzfq012 單身串查

      WHEN l_type = "F002"
         CALL adzp168_set_comp_entry("formonly.cbo_setbrowse,dzfq007,dzfq008",FALSE)
         #cbo_setbrowse   資料瀏覽區塊 (00不需要/ sc查詢方案/ ht左方樹狀/ vt上方樹狀)
         #dzfq007 單頭框架
         #dzfq008 換行數量

      WHEN g_dzfq_m.cbo_progtype = "Q"
         CALL adzp168_set_comp_entry("dzfq010",TRUE)   #單身框架可以選Tree
         CALL adzp168_set_comp_entry("dzfq006,dzfq008",FALSE)
         IF g_4fd_inf.form_vbm_idx > 0 THEN   #單頭框架
            CALL adzp168_set_comp_entry("dzfq007",TRUE)
         ELSE
            CALL adzp168_set_comp_entry("dzfq007",FALSE)
         END IF

      WHEN g_dzfq_m.cbo_progtype = "P" OR g_dzfq_m.cbo_progtype = "R"
         CALL adzp168_set_comp_entry("dzfq006,dzfq007,dzfq008,dzfq010",FALSE)
         IF g_4fd_inf.form_vbd_idx > 0 THEN   #單身切割框架
            CALL adzp168_set_comp_entry("dzfq009",TRUE)
         ELSE
            CALL adzp168_set_comp_entry("dzfq009",FALSE)
         END IF
   END CASE

   CALL adzp168_set_entry_by_dzfq005(p_cmd,p_reset_all)   #單頭欄位開啟設定-依主/子程式

   IF (p_cmd = 'a' OR p_cmd = 'u') AND g_def_reset THEN
      IF g_4fd_inf.form_vbm_idx = 0 OR p_reset_all THEN
         CALL adzp168_default_set("m")   #畫面結構設計主檔預設值-單頭
      END IF
      IF g_4fd_inf.form_vbd_idx = 0 OR p_reset_all THEN
         CALL adzp168_default_set("d")   #畫面結構設計主檔預設值-單身
      END IF
   END IF

   CALL adzp168_set_entry_by_cbo_setbrowse()
END FUNCTION

#+ 單頭欄位開啟設定-依程式,畫面類型
PRIVATE FUNCTION adzp168_set_entry_by_cbo_setbrowse()
   DEFINE l_entry    BOOLEAN   #是否開啟欄位
   DEFINE l_str      STRING

   CALL adzp168_default_set_dzfq006() RETURNING l_entry   #畫面結構設計主檔預設值-單頭資料(mq:多筆/sq:單筆)
   CALL adzp168_set_comp_entry("dzfq006",l_entry)
END FUNCTION

#+ 單頭欄位開啟設定-依畫面代碼
PRIVATE FUNCTION adzp168_set_entry_by_dzfq004(p_dzfq005)
   DEFINE p_dzfq005       LIKE dzfq_t.dzfq005   #主/子程式(M:主程式與畫面、S:子程式與畫面、F:子畫面（含應用元件畫面）)
   #DEFINE l_chk           BOOLEAN
   #DEFINE l_chk2          BOOLEAN
   #
   #LET l_chk = FALSE
   #LET l_chk2 = FALSE
   #CASE
   #   WHEN p_dzfq005 = "M" OR p_dzfq005 = "S"
   #      IF p_use_tpl = "Y" THEN
   #         LET l_chk = FALSE
   #         LET l_chk2 = FALSE
   #      ELSE
   #         LET l_chk = FALSE
   #         LET l_chk2 = TRUE
   #      END IF
   #
   #   WHEN p_dzfq005 = "F"
   #         LET l_chk = FALSE
   #         LET l_chk2 = TRUE
   #END CASE
   #CALL adzp168_set_comp_entry("dzfq014",l_chk)
   #CALL adzp168_set_comp_entry("dzfq015",l_chk2)   #改由4fd固定無法輸入
END FUNCTION

#+ 單頭欄位開啟設定-依主/子程式
PRIVATE FUNCTION adzp168_set_entry_by_dzfq005(p_cmd,p_reset_all)   #+ 單頭欄位開啟設定-依主/子程式
   DEFINE p_cmd              LIKE type_t.chr1
   DEFINE p_reset_all        BOOLEAN
   DEFINE l_entry            BOOLEAN   #是否開啟欄位
   DEFINE l_str              STRING


   #LET l_entry_dzfq006 = TRUE
   #
   #IF g_dzfq_m.cbo_setbrowse <> "00" THEN
   #   LET g_dzfq_m.dzfq006 = "mq"   #單頭資料(mq:多筆/sq:單筆)
   #   LET l_entry_dzfq006 = FALSE
   #END IF
   #
   ##限定版型F002只有F002_00_sq
   #LET l_str = g_dzfq_m.cbo_progtype CLIPPED,g_dzfq_m.cbo_formtype CLIPPED
   #IF l_str = "F002" THEN   #OR l_str = "F004"
   #   LET g_dzfq_m.dzfq006 = "sq"
   #   LET l_entry_dzfq006 = FALSE
   #END IF
   #
   ##單頭 + 主程式 + 資料瀏覽區塊(00不需要),則單頭資料必選mq:多筆,因為會無法切換資料
   #IF g_4fd_inf.form_vbm_idx > 0 AND g_dzfq_m.dzfq005 = "M" AND g_dzfq_m.cbo_setbrowse = "00" THEN
   #   LET g_dzfq_m.dzfq006 = "mq"       #mq:多筆/sq:單筆
   #   LET l_entry_dzfq006 = FALSE
   #END IF

   CALL adzp168_default_set_dzfq006() RETURNING l_entry   #畫面結構設計主檔預設值-單頭資料(mq:多筆/sq:單筆)
   CALL adzp168_set_comp_entry("dzfq006",l_entry)

   #是否要空框架畫面檔
   CALL adzp168_default_set_dzfq015(p_reset_all) RETURNING l_entry #預設值   #FUN-150228
   CALL adzp168_set_comp_entry("dzfq015",l_entry)   #FUN-150228

   #CALL adzp168_default_set_dzfq013() RETURNING l_entry   #畫面結構設計主檔預設值-子程式進入模式(a:全功能/ b:INPUT / c:CONSTRUCT)
   #CALL adzp168_set_comp_entry("dzfq013",l_entry)
END FUNCTION


#+ 單身欄位開啟設定
PRIVATE FUNCTION adzp168_set_entry_b()
   #add-point:set_entry_b段define
   {<point name="set_entry_b.define"/>}
   #end add-point
END FUNCTION


#+ 單身欄位關閉設定
PRIVATE FUNCTION adzp168_set_no_entry_b()
   #add-point:set_no_entry_b段define
   {<point name="set_no_entry_b.define"/>}
   #end add-point
END FUNCTION


#+ 是否可以按-設定狀態碼的按鈕
PRIVATE FUNCTION adzp168_set_act_status_config()
   DEFINE l_chk   BOOLEAN

   LET l_chk = FALSE
   IF g_tbtree_idx > 0 THEN
      IF NOT cl_null(g_tbtree[g_tbtree_idx].b_stus) THEN
         LET l_chk = TRUE
      ELSE
         LET l_chk = FALSE
      END IF
   END IF

   RETURN l_chk
END FUNCTION


#+ 是否可以按-加入資料表的按鈕
PRIVATE FUNCTION adzp168_set_act_add_table()
   DEFINE l_chk   BOOLEAN

   IF g_dzfq_m.dzfq015 = "Y" THEN
      LET l_chk = FALSE
   ELSE
      LET l_chk = TRUE
   END IF

   RETURN l_chk
END FUNCTION

#+ 是否可以按-加入欄位的按鈕
PRIVATE FUNCTION adzp168_set_act_add_col()
   DEFINE l_chk        BOOLEAN
   DEFINE l_root_idx   LIKE type_t.num5
   DEFINE l_cnt1       LIKE type_t.num10
   DEFINE l_cnt2       LIKE type_t.num10

   LET l_chk = FALSE

   #Table中有欄位才可以挑選
   LET l_cnt1 = g_column.getLength()
   LET l_cnt2 = g_form_tree.getLength()
   IF l_cnt1 > 0 AND l_cnt2 > 0 AND g_ftree_idx > 0 THEN
      LET l_chk = TRUE
   END IF

   IF l_chk THEN
      CALL adzp168_form_tree_root_idx(g_ftree_idx) RETURNING l_root_idx
      CASE g_form_tree[l_root_idx].dzfr007
         #是否有瀏覽表
         WHEN "s_browse"
            IF g_4fd_inf.l_jiashuangdang AND g_dzfq_m.cbo_setbrowse = "sc" THEN
               LET l_chk = FALSE
            ELSE
               LET l_chk = TRUE
            END IF

         #單頭
         WHEN "vb_master"
            IF g_form_tree[g_ftree_idx].dzfr006 = "Page"
               OR g_form_tree[g_ftree_idx].dzfr006 = "Group"
               OR g_form_tree[g_ftree_idx].dzfr006 = "Grid"
               OR g_form_tree[g_ftree_idx].dzfr006 = "Field" THEN

               LET l_chk = TRUE
            ELSE
               LET l_chk = FALSE
            END IF

         WHEN "vb_detail"
            IF g_form_tree[g_ftree_idx].dzfr006 = "Tree"
               OR g_form_tree[g_ftree_idx].dzfr006 = "Table"
               #OR g_form_tree[g_ftree_idx].dzfr006 = "ScrollGrid"
               OR g_form_tree[g_ftree_idx].dzfr006 = "row"
               OR g_form_tree[g_ftree_idx].dzfr006 = "Field" THEN

               LET l_chk = TRUE
            ELSE
               LET l_chk = FALSE
            END IF

         WHEN "vb_detailexp"
            IF g_form_tree[g_ftree_idx].dzfr006 = "Page"
               OR g_form_tree[g_ftree_idx].dzfr006 = "Field" THEN

               LET l_chk = TRUE
            ELSE
               LET l_chk = FALSE
            END IF

         WHEN "vb_headerlock"
            IF g_form_tree[g_ftree_idx].dzfr006 = "Group" THEN
               LET l_chk = TRUE
            ELSE
               LET l_chk = FALSE
            END IF

         OTHERWISE   #瀏覽表之類的
            IF g_form_tree[g_ftree_idx].dzfr006 = "Tree"
               OR g_form_tree[g_ftree_idx].dzfr006 = "Table"
               OR g_form_tree[g_ftree_idx].dzfr006 = "Field" THEN

               LET l_chk = TRUE
            ELSE
               LET l_chk = FALSE
            END IF
      END CASE
   END IF

   RETURN l_chk
END FUNCTION

#+ 是否可以按-刪除欄位的按鈕
PRIVATE FUNCTION adzp168_set_act_del_col()
   DEFINE l_chk        BOOLEAN
   DEFINE l_root_idx   LIKE type_t.num5

   IF (g_form_tree[g_ftree_idx].dzfr006 = "Field" OR g_form_tree[g_ftree_idx].dzfr006 = "ghost") AND g_form_tree[g_ftree_idx].dzfr011 = "Y" THEN
      LET l_chk = TRUE
   ELSE
      LET l_chk = FALSE
   END IF

   RETURN l_chk
END FUNCTION

#+ 是否可以按-加入空白欄位的按鈕
PRIVATE FUNCTION adzp168_set_act_add_col_ghost()
   DEFINE l_chk        BOOLEAN
   DEFINE l_root_idx   LIKE type_t.num5
   DEFINE l_cnt1       LIKE type_t.num10
   DEFINE l_cnt2       LIKE type_t.num10

   LET l_chk = FALSE

   IF g_tbtree_idx > 0 THEN
      IF g_form_tree[g_ftree_idx].dzfr006 = "row" THEN
         LET l_chk = TRUE
      END IF
   END IF

   RETURN l_chk
END FUNCTION

#+ 是否可以按-欄位往前的按鈕
PRIVATE FUNCTION adzp168_set_act_col_up(p_ftree_idx)
   DEFINE p_ftree_idx     LIKE type_t.num10
   DEFINE l_chk           BOOLEAN
   DEFINE l_root_idx      LIKE type_t.num5      #focus的Root節點index

   LET l_chk = FALSE
   IF p_ftree_idx > 0 THEN
      IF g_form_tree[p_ftree_idx].dzfr005 > 1 THEN   #順序(同階層中的排序)
         CALL adzp168_form_tree_root_idx(p_ftree_idx) RETURNING l_root_idx

         CASE
            WHEN g_form_tree[p_ftree_idx].dzfr006 = "Field" OR g_form_tree[p_ftree_idx].dzfr006 = "ghost"
               LET l_chk = TRUE
               #單頭狀態碼不可改順序
               IF NOT cl_null(g_form_tree[p_ftree_idx].dzeb022) THEN
                 IF g_form_tree[p_ftree_idx].dzeb022 = "cdfStatus" AND g_form_tree[l_root_idx].dzfr007 = "vb_master" THEN
                    LET l_chk = FALSE
                 END IF
               END IF

            WHEN g_form_tree[p_ftree_idx].dzfr006 = g_dzfq_m.dzfq007 OR g_form_tree[p_ftree_idx].dzfr006 = "Page"
                 LET l_chk = TRUE
         END CASE
     END IF
   END IF

   RETURN l_chk
END FUNCTION


#+ 是否可以按-欄位往後的按鈕
PRIVATE FUNCTION adzp168_set_act_col_down(p_ftree_idx)
   DEFINE p_ftree_idx     LIKE type_t.num10
   DEFINE l_chk           BOOLEAN
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_next_i        LIKE type_t.num5      #下一列index
   DEFINE l_dzfr005       LIKE dzfr_t.dzfr005   #順序(同階層中的排序)
   DEFINE l_root_idx      LIKE type_t.num5      #focus的Root節點index

   LET l_chk = FALSE

   IF p_ftree_idx > 0 THEN
      CALL adzp168_form_tree_root_idx(p_ftree_idx) RETURNING l_root_idx
      CALL adzp168t1_new_dzfr005(g_form_tree[p_ftree_idx].dzfr004) RETURNING l_dzfr005
      LET l_dzfr005 = l_dzfr005 - 1

      #不是最後一列,在同階層中不是最後一個
      IF p_ftree_idx < g_form_tree.getLength() AND g_form_tree[p_ftree_idx].dzfr005 < l_dzfr005 THEN

         CASE
            WHEN g_form_tree[p_ftree_idx].dzfr006 = "Field" OR g_form_tree[p_ftree_idx].dzfr006 = "ghost"
               LET l_chk = TRUE

               #狀態碼本身不能換順序
               IF NOT cl_null(g_form_tree[p_ftree_idx].dzeb022) THEN
                 IF g_form_tree[p_ftree_idx].dzeb022 = "cdfStatus" AND g_form_tree[l_root_idx].dzfr007 = "vb_master" THEN
                    LET l_chk = FALSE
                 END IF
               END IF
               #下一列是狀態碼不能換順序
               LET l_next_i = p_ftree_idx + 1   #下一列index
               IF NOT cl_null(g_form_tree[l_next_i].dzeb022) THEN
                 IF g_form_tree[l_next_i].dzeb022 = "cdfStatus" AND g_form_tree[l_root_idx].dzfr007 = "vb_master" THEN
                    LET l_chk = FALSE
                 END IF
               END IF

            WHEN g_form_tree[p_ftree_idx].dzfr006 = g_dzfq_m.dzfq007 OR g_form_tree[p_ftree_idx].dzfr006 = "Page"
                 LET l_chk = TRUE
         END CASE

     END IF
   END IF

   RETURN l_chk
END FUNCTION


#+ 是否可以按-加入單頭區塊的按鈕
PRIVATE FUNCTION adzp168_set_act_add_master(p_root_idx)
   DEFINE p_root_idx      LIKE type_t.num5      #focus的Root節點index
   DEFINE l_root_idx      LIKE type_t.num5      #focus的Root節點index
   DEFINE l_chk   BOOLEAN

   LET l_chk = FALSE

   CASE
      WHEN g_dzfq_m.dzfq015 = "Y"    #空框架畫面檔
         LET l_chk = FALSE

      OTHERWISE
         IF g_ftree_idx > 0 THEN
            IF p_root_idx > 0 THEN
               LET l_root_idx = p_root_idx
            ELSE
               CALL adzp168_form_tree_root_idx(g_ftree_idx) RETURNING l_root_idx
            END IF

            IF g_form_tree[l_root_idx].dzfr007 = "vb_master" AND (g_form_tree[g_ftree_idx].dzfr007 = "vb_master" OR g_form_tree[g_ftree_idx].dzfr006 = "Folder") THEN
               LET l_chk = TRUE
            ELSE
               LET l_chk = FALSE
            END IF

            #for第一區不開放(寫)
            #IF g_dzfq_m.dzfq007 = "Folder" AND g_form_tree[g_ftree_idx].dzfr007 = "vb_master" THEN
            #   LET l_chk = FALSE
            #END IF

         END IF
   END CASE

   RETURN l_chk
END FUNCTION

#+ 是否可以按-刪除單頭區塊的按鈕
PRIVATE FUNCTION adzp168_set_act_del_master(p_root_idx)
   DEFINE p_root_idx      LIKE type_t.num5      #focus的Root節點index
   DEFINE l_root_idx      LIKE type_t.num5
   DEFINE l_chk   BOOLEAN

   LET l_chk = FALSE
   IF g_ftree_idx > 0 THEN
      IF p_root_idx > 0 THEN
         LET l_root_idx = p_root_idx
      ELSE
         CALL adzp168_form_tree_root_idx(g_ftree_idx) RETURNING l_root_idx
      END IF

      IF g_form_tree[l_root_idx].dzfr007 = "vb_master" AND g_form_tree[g_ftree_idx].dzfr011 = "Y" AND g_form_tree[g_ftree_idx].dzfr006 <> "Field" THEN
         LET l_chk = TRUE
      ELSE
         LET l_chk = FALSE
      END IF
   END IF

   RETURN l_chk
END FUNCTION


#+ 是否可以按-加入單身區塊的按鈕
PRIVATE FUNCTION adzp168_set_act_add_detail(p_root_idx)
   DEFINE p_root_idx      LIKE type_t.num5      #focus的Root節點index
   DEFINE l_root_idx      LIKE type_t.num5      #focus的Root節點index
   DEFINE l_chk           BOOLEAN

   LET l_chk = FALSE

   CASE
      WHEN g_dzfq_m.dzfq015 = "Y"    #空框架畫面檔
         LET l_chk = FALSE

      OTHERWISE
         IF g_ftree_idx > 0 THEN
            IF p_root_idx > 0 THEN
               LET l_root_idx = p_root_idx
            ELSE
               CALL adzp168_form_tree_root_idx(g_ftree_idx) RETURNING l_root_idx
            END IF

            CASE
              WHEN g_form_tree[g_ftree_idx].dzfr012 = "page_info_"   #狀態頁籤
                 LET l_chk = FALSE

              WHEN g_form_tree[g_ftree_idx].dzfr006 = "ScrollGrid"
                 LET l_chk = TRUE

              WHEN g_form_tree[l_root_idx].dzfr007 = "vb_detail" AND g_dzfq_m.dzfq009 <> "sarray"
                 CASE
                    WHEN g_form_tree[g_ftree_idx].dzfr007 = "vb_detail" AND g_dzfq_m.dzfq009 = "Folder"
                        LET l_chk = TRUE

                    WHEN (g_form_tree[g_ftree_idx].dzfr007 <> "vb_detail" AND (g_form_tree[g_ftree_idx].dzfr006 = "Folder" OR g_form_tree[g_ftree_idx].dzfr006 = "HBox" OR g_form_tree[g_ftree_idx].dzfr006 = "VBox"))
                         #(g_form_tree[g_ftree_idx].dzfr007 = "vb_detail" AND g_dzfq_m.dzfq009 <> "HBox" AND g_dzfq_m.dzfq009 <> "VBox") OR
                         #(g_form_tree[g_ftree_idx].dzfr007 <> "vb_detail" AND (g_form_tree[g_ftree_idx].dzfr006 = "Folder" OR g_form_tree[g_ftree_idx].dzfr006 = "HBox" OR g_form_tree[g_ftree_idx].dzfr006 = "VBox"))

                       LET l_chk = TRUE

                    WHEN g_form_tree[g_ftree_idx].b_hasC = FALSE
                       #單身切割框架(sarray:單一/Folder/HBox/VBox/HFolder/VFolder), Page底下要可以加Table
                       IF g_form_tree[g_ftree_idx].dzfr006 = g_dzfq_m.dzfq009 OR g_form_tree[g_ftree_idx].dzfr006 = "Page" THEN
                          LET l_chk = TRUE
                       END IF

                 END CASE

              WHEN g_form_tree[l_root_idx].dzfr007 = "vb_detailexp"
                 CASE
                    WHEN g_form_tree[g_ftree_idx].dzfr007 = "vb_detailexp" OR g_form_tree[g_ftree_idx].dzfr006 = "Folder"
                       LET l_chk = TRUE
                 END CASE
            END CASE

            #for第一區不開放(寫)
            #IF (g_dzfq_m.dzfq009 = "Folder" AND g_form_tree[g_ftree_idx].dzfr007 = "vb_detail") OR g_form_tree[g_ftree_idx].dzfr007 = "vb_detailexp" THEN
            #   LET l_chk = FALSE
            #END IF

         END IF

   END CASE

   #IF NOT l_chk THEN   #是否可以按-加入空白欄位的按鈕
   #   CALL adzp168_set_act_add_col_ghost() RETURNING l_chk
   #END IF

   RETURN l_chk
END FUNCTION

#+ 是否可以按-刪除單身區塊的按鈕
PRIVATE FUNCTION adzp168_set_act_del_detail(p_root_idx)
   DEFINE p_root_idx      LIKE type_t.num5      #focus的Root節點index
   DEFINE l_root_idx      LIKE type_t.num5      #focus的Root節點index
   DEFINE l_chk   BOOLEAN

   LET l_chk = FALSE
   IF g_ftree_idx > 0 THEN
      IF p_root_idx > 0 THEN
         LET l_root_idx = p_root_idx
      ELSE
         CALL adzp168_form_tree_root_idx(g_ftree_idx) RETURNING l_root_idx
      END IF

      IF (g_form_tree[l_root_idx].dzfr007 = "vb_detail" OR g_form_tree[l_root_idx].dzfr007 = "vb_detailexp") AND g_form_tree[g_ftree_idx].dzfr011 = "Y" AND g_form_tree[g_ftree_idx].dzfr006 <> "Field" THEN
         LET l_chk = TRUE
         #外層有單身切割框架,不能直接刪單身框架,要從單身切割框架開始刪除
         #IF g_dzfq_m.dzfq009 <> "sarray" AND g_form_tree[g_ftree_idx].dzfr006 = g_dzfq_m.dzfq010 THEN
         IF g_form_tree[g_ftree_idx].dzfr011 = "N" THEN
            LET l_chk = FALSE
         END IF
      ELSE
         LET l_chk = FALSE
      END IF
   END IF

   #IF NOT l_chk THEN   #是否可以按-加入空白欄位的按鈕
   #   CALL adzp168_set_act_add_col_ghost() RETURNING l_chk
   #END IF

   RETURN l_chk
END FUNCTION


#+ 是否可以按-加入狀態頁籤的按鈕
PRIVATE FUNCTION adzp168_set_act_add_pageinfo(p_root_idx)
   DEFINE p_root_idx      LIKE type_t.num5      #focus的Root節點index
   DEFINE l_root_idx      LIKE type_t.num5      #focus的Root節點index
   DEFINE l_chk   BOOLEAN

   LET l_chk = FALSE

   CASE
      WHEN g_dzfq_m.dzfq015 = "Y"    #空框架畫面檔
         LET l_chk = FALSE

      WHEN g_dzfq_m.cbo_progtype <> "F"   #ex.Q類不自動加入
         LET l_chk = FALSE

      OTHERWISE
         IF g_ftree_idx > 0 THEN
            IF p_root_idx > 0 THEN
               LET l_root_idx = p_root_idx
            ELSE
               CALL adzp168_form_tree_root_idx(g_ftree_idx) RETURNING l_root_idx
            END IF

            CASE
               #假雙檔的單頭不可放共用欄位和狀態碼
               WHEN g_4fd_inf.l_jiashuangdang = TRUE AND g_form_tree[l_root_idx].dzfr007 = "vb_master"
                  LET l_chk = FALSE

               WHEN g_form_tree[g_ftree_idx].dzfr006 = "Folder"
                  LET l_chk = TRUE

            END CASE
         END IF
   END CASE

   RETURN l_chk
END FUNCTION


#+ 設定下拉式選單內容-換行字段數量
PRIVATE FUNCTION adzp168_cb_dzfq008()
   DEFINE ls_values       STRING                          #ComboBox values
   DEFINE ls_items        STRING                          #ComboBox items
   DEFINE l_i             LIKE type_t.num5
   DEFINE ls_val          STRING
   DEFINE ls_text         STRING
   DEFINE l_str           STRING

   FOR l_i=1 TO 20
      LET l_str = l_i
      IF l_i = 1 THEN
         LET ls_values = l_str CLIPPED
         LET ls_items = l_str CLIPPED
      ELSE
         LET ls_values = ls_values CLIPPED, ",", l_str CLIPPED
         LET ls_items = ls_items CLIPPED, ",", l_str CLIPPED
      END IF
      IF l_i = 7 AND g_def_reset THEN
         LET g_dzfq_m.dzfq008 = l_i   #default 7
      END IF
   END FOR

   CALL cl_set_combo_items("dzfq008", ls_values, ls_items)
END FUNCTION

#+ 設定下拉式選單內容-單身切割框架
PRIVATE FUNCTION adzp168_cb_dzfq009()
   DEFINE ls_values       STRING                #ComboBox values
   DEFINE ls_items        STRING                #ComboBox items
   DEFINE ls_items_pre    STRING                #多語言代碼前置名稱
   DEFINE l_gzzd003       LIKE gzzd_t.gzzd003   #多語言代碼
   DEFINE l_gzzd005       LIKE gzzd_t.gzzd005   #多語言名稱
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_j             LIKE type_t.num5
   DEFINE l_n             LIKE type_t.num5
   DEFINE l_exist         BOOLEAN
   DEFINE ls_val          STRING
   DEFINE ls_text         STRING
   DEFINE l_str           STRING
   DEFINE l_itemarr       DYNAMIC ARRAY OF STRING

   CALL l_itemarr.clear()

   LET l_i = 1
   LET l_itemarr[l_i] = "sarray"

   LET l_str = g_dzfq_m.cbo_progtype CLIPPED, g_dzfq_m.cbo_formtype CLIPPED
   IF l_str <> "F004" THEN   #F004
      LET l_i = l_i + 1
      #LET l_itemarr[l_i] = "Folder"
      LET l_itemarr[l_i] = "HFolder"
      LET l_i = l_i + 1
      LET l_itemarr[l_i] = "VFolder"
   END IF

   IF g_dzfq_m.cbo_progtype = "Q" THEN
      LET l_i = l_i + 1
      LET l_itemarr[l_i] = "HGroup"
      LET l_i = l_i + 1
      LET l_itemarr[l_i] = "VGroup"
   END IF

   LET ls_items_pre = "cbo_dzfq009."

   FOR l_i = 1 TO l_itemarr.getLength()
      IF l_i = 1 THEN
         LET ls_values = l_itemarr[l_i] CLIPPED
         LET l_gzzd003 = ls_items_pre CLIPPED,l_itemarr[l_i] CLIPPED

         LET l_gzzd005 = NULL
         EXECUTE adzp168_formlang_pre01 INTO l_gzzd005 USING 'adzp168',g_lang,l_gzzd003,"c"
         IF cl_null(l_gzzd005) THEN
            EXECUTE adzp168_formlang_pre01 INTO l_gzzd005 USING 'adzp168',g_lang,l_gzzd003,"s"
            IF cl_null(l_gzzd005) THEN
               LET l_gzzd005 = l_itemarr[l_i] CLIPPED
            END IF
         END IF
         LET ls_items = l_gzzd005 CLIPPED

         IF g_def_reset THEN
            LET g_dzfq_m.dzfq009 = l_itemarr[l_i] CLIPPED
         END IF
      ELSE
         LET ls_values = ls_values CLIPPED, ",", l_itemarr[l_i] CLIPPED
         LET l_gzzd003 = ls_items_pre CLIPPED,l_itemarr[l_i] CLIPPED

         LET l_gzzd005 = NULL
         EXECUTE adzp168_formlang_pre01 INTO l_gzzd005 USING 'adzp168',g_lang,l_gzzd003,"c"
         IF cl_null(l_gzzd005) THEN
            EXECUTE adzp168_formlang_pre01 INTO l_gzzd005 USING 'adzp168',g_lang,l_gzzd003,"s"
            IF cl_null(l_gzzd005) THEN
               LET l_gzzd005 = l_itemarr[l_i] CLIPPED
            END IF
         END IF
         LET ls_items = ls_items CLIPPED, ",", l_gzzd005 CLIPPED
      END IF
   END FOR

   CALL cl_set_combo_items("dzfq009", ls_values, ls_items)
END FUNCTION

#+ 設定下拉式選單內容-單身框架
PRIVATE FUNCTION adzp168_cb_dzfq010()
   DEFINE ls_values       STRING                #ComboBox values
   DEFINE ls_items        STRING                #ComboBox items
   DEFINE ls_items_pre    STRING                #多語言代碼前置名稱
   DEFINE l_gzzd003       LIKE gzzd_t.gzzd003   #多語言代碼
   DEFINE l_gzzd005       LIKE gzzd_t.gzzd005   #多語言名稱
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_j             LIKE type_t.num5
   DEFINE l_n             LIKE type_t.num5
   DEFINE l_exist         BOOLEAN
   DEFINE ls_val          STRING
   DEFINE ls_text         STRING
   DEFINE l_str           STRING
   DEFINE l_itemarr       DYNAMIC ARRAY OF STRING

   CALL l_itemarr.clear()

   LET l_i = 1
   LET l_itemarr[l_i] = "Table"

   #F002~F004可以有Table、ScrollGrid, Q類的未來是Table、Tree
   LET l_str = g_dzfq_m.cbo_progtype CLIPPED, g_dzfq_m.cbo_formtype CLIPPED
   CASE
      WHEN g_dzfq_m.cbo_progtype = "F" AND l_str <> "F001"
         LET l_i = l_i + 1
         LET l_itemarr[l_i] = "ScrollGrid"
      WHEN l_str = "Q001"    #暫時不開放Q類的Tree
         LET l_i = l_i + 1
         LET l_itemarr[l_i] = "Tree"
   END CASE

   FOR l_i = 1 TO l_itemarr.getLength()
      IF l_i = 1 THEN
         LET ls_values = l_itemarr[l_i] CLIPPED
         LET ls_items = l_itemarr[l_i] CLIPPED

         IF g_def_reset THEN
            LET g_dzfq_m.dzfq010 = l_itemarr[l_i] CLIPPED
         END IF
      ELSE
         LET ls_values = ls_values CLIPPED, ",", l_itemarr[l_i] CLIPPED
         LET ls_items = ls_items CLIPPED, ",", l_itemarr[l_i] CLIPPED
      END IF
   END FOR

   CALL cl_set_combo_items("dzfq010", ls_values, ls_items)
END FUNCTION

#+ 設定下拉式選單內容-程式類型(S/F/R/P/Q)
PRIVATE FUNCTION adzp168_cb_progtype()
   DEFINE ls_values       STRING                          #ComboBox values
   DEFINE ls_items        STRING                          #ComboBox items
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_j             LIKE type_t.num5
   DEFINE l_n             LIKE type_t.num5
   DEFINE l_exist         BOOLEAN
   DEFINE ls_val          STRING
   DEFINE ls_text         STRING
   DEFINE l_str           STRING
   DEFINE l_progtype      DYNAMIC ARRAY OF STRING
   DEFINE ls_items_pre    STRING                #多語言代碼前置名稱
   DEFINE l_gzzd003       LIKE gzzd_t.gzzd003   #多語言代碼
   DEFINE l_gzzd005       LIKE gzzd_t.gzzd005   #多語言名稱

   CALL l_progtype.clear()
   LET ls_items_pre = "cbo_progtype."

   FOR l_i = 1 TO g_tplcode.getLength()
      IF g_tplcode[l_i].progtype <> "F" AND g_dzfq_m.dzfq005 = "S" THEN    #M:主程式與畫面/S:子程式與畫面/F:子畫面   #暫時配合4gl產生器現有功能,子程式限F001,F002,F003
         CONTINUE FOR   #例如:程式類型"Q",子程式不可設定
      END IF

      LET l_n = l_progtype.getLength()

      LET l_gzzd003 = ls_items_pre CLIPPED,g_tplcode[l_i].progtype CLIPPED
      LET l_gzzd005 = NULL
      EXECUTE adzp168_formlang_pre01 INTO l_gzzd005 USING 'adzp168',g_lang,l_gzzd003,"c"
      IF cl_null(l_gzzd005) THEN
         EXECUTE adzp168_formlang_pre01 INTO l_gzzd005 USING 'adzp168',g_lang,l_gzzd003,"s"
         IF cl_null(l_gzzd005) THEN
            LET l_gzzd005 = g_tplcode[l_i].progtype CLIPPED
         END IF
      END IF


      IF l_i = 1 THEN
         LET l_progtype[1] = g_tplcode[l_i].progtype CLIPPED
         LET ls_values = g_tplcode[l_i].progtype CLIPPED
         LET ls_items = g_tplcode[l_i].progtype CLIPPED,".",l_gzzd005 CLIPPED

         IF g_def_reset THEN
            LET g_dzfq_m.cbo_progtype = g_tplcode[l_i].progtype CLIPPED
         END IF
      ELSE
         IF g_tplcode[l_i].progtype <> l_progtype[l_n] THEN
            LET l_exist = FALSE
            FOR l_j = 1 TO l_n
               IF g_tplcode[l_i].progtype = l_progtype[l_j] THEN
                  LET l_exist = TRUE
                  EXIT FOR
               END IF
            END FOR
            IF NOT l_exist THEN
               LET l_n = l_n + 1
               LET l_progtype[l_n] = g_tplcode[l_i].progtype
               LET ls_values = ls_values CLIPPED, ",", g_tplcode[l_i].progtype CLIPPED
               LET ls_items = ls_items CLIPPED, ",", g_tplcode[l_i].progtype CLIPPED,".",l_gzzd005 CLIPPED
            END IF
         END IF
      END IF
   END FOR

   CALL cl_set_combo_items("cbo_progtype", ls_values, ls_items)
   CALL adzp168_cb_formtype()
END FUNCTION

#+ 設定下拉式選單內容-畫面類型(001/002/003...)
PRIVATE FUNCTION adzp168_cb_formtype()
   DEFINE ls_values       STRING                #ComboBox values
   DEFINE ls_items        STRING                #ComboBox items
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_j             LIKE type_t.num5
   DEFINE l_n             LIKE type_t.num5
   DEFINE l_exist         BOOLEAN
   DEFINE ls_val          STRING
   DEFINE ls_text         STRING
   DEFINE l_str           STRING
   DEFINE l_formtype      DYNAMIC ARRAY OF STRING
   DEFINE ls_items_pre    STRING                #多語言代碼前置名稱
   DEFINE l_gzzd003       LIKE gzzd_t.gzzd003   #多語言代碼
   DEFINE l_gzzd005       LIKE gzzd_t.gzzd005   #多語言名稱
   DEFINE l_tplcode DYNAMIC ARRAY OF RECORD     #解析現有公版的結構代號   #暫時配合4gl產生器現有功能,子程式限F001,F002
          dzfm001    LIKE dzfm_t.dzfm001,       #結構代號
          progtype   STRING,
          formtype   STRING,
          setbrowse  STRING
          END RECORD
   DEFINE l_dzfm001       LIKE dzfm_t.dzfm001
   DEFINE l_k             LIKE type_t.num5


   CALL l_formtype.clear()
   LET ls_items_pre = "cbo_formtype."

   IF g_dzfq_m.dzfq005 = "M" OR g_dzfq_m.dzfq005 = "F" THEN    #M:主程式與畫面/S:子程式與畫面/F:子畫面   #暫時配合4gl產生器現有功能,子程式限F001,F002,F003

      FOR l_i = 1 TO g_tplcode.getLength()
         IF g_tplcode[l_i].progtype = g_dzfq_m.cbo_progtype THEN
            #例外不納入
            IF g_dzfq_m.dzfq005 = "F" AND
              ((g_tplcode[l_i].progtype = "P" AND g_tplcode[l_i].formtype = "002") OR    #FUN-150228
               (g_tplcode[l_i].progtype = "Q" AND g_tplcode[l_i].formtype = "002")) THEN   #FUN-150228
               CONTINUE FOR
            END IF

            LET l_n = l_formtype.getLength()

            LET l_gzzd003 = ls_items_pre CLIPPED,g_dzfq_m.cbo_progtype,".",g_tplcode[l_i].formtype CLIPPED
            EXECUTE adzp168_formlang_pre01 INTO l_gzzd005 USING 'adzp168',g_lang,l_gzzd003,"s"

            IF l_n = 0 THEN
               LET l_formtype[1] = g_tplcode[l_i].formtype CLIPPED
               LET ls_values = g_tplcode[l_i].formtype CLIPPED
               LET ls_items = g_tplcode[l_i].formtype CLIPPED,".",l_gzzd005 CLIPPED

               IF g_def_reset THEN
                  LET g_dzfq_m.cbo_formtype = g_tplcode[l_i].formtype CLIPPED
               END IF
            ELSE
               IF g_tplcode[l_i].formtype <> l_formtype[l_n] THEN
                  LET l_exist = FALSE
                  FOR l_j = 1 TO l_n
                     IF g_tplcode[l_i].formtype = l_formtype[l_j] THEN
                        LET l_exist = TRUE
                        EXIT FOR
                     END IF
                  END FOR
                  IF NOT l_exist THEN
                     LET l_n = l_n + 1
                     LET l_formtype[l_n] = g_tplcode[l_i].formtype
                     LET ls_values = ls_values CLIPPED, ",", g_tplcode[l_i].formtype CLIPPED
                     LET ls_items = ls_items CLIPPED, ",", g_tplcode[l_i].formtype CLIPPED,".",l_gzzd005 CLIPPED
                  END IF
               END IF
            END IF
         END IF
      END FOR

   #暫時配合4gl產生器現有功能,子程式限F001,F002,F003非假雙檔 -----------
   ELSE

      #現有的結構代號
      LET g_sql = "SELECT dzfm001",
                    " FROM dzfm_t ",
                    " WHERE dzfm008='Y'",
                      " AND (dzfm001 LIKE 'F001%' OR dzfm001 LIKE 'F002%' OR dzfm001 LIKE 'F003%')",   #子程式0812
                    " GROUP BY dzfm001,dzfm008",
                    " ORDER BY dzfm001"

      PREPARE adzp168_dzfm001_02_pre FROM g_sql
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'PREPARE:'
         LET g_errparam.popup = FALSE
         CALL cl_err()
      END IF
      DECLARE adzp168_dzfm001_02_cur CURSOR FOR adzp168_dzfm001_02_pre

      LET l_i = 0
      CALL l_tplcode.clear()
      FOREACH adzp168_dzfm001_02_cur INTO l_dzfm001
         LET l_i = l_i + 1
         LET l_str = l_dzfm001
         LET l_tplcode[l_i].dzfm001 = l_dzfm001
         LET l_tplcode[l_i].progtype = l_str.getCharAt(1)
         LET l_k = l_str.getIndexOf("_",1)
         LET l_tplcode[l_i].formtype = l_str.subString(2,l_k-1)
         LET l_tplcode[l_i].setbrowse = l_str.subString(l_k+1,l_str.getLength())
      END FOREACH

      FOR l_i = 1 TO l_tplcode.getLength()
         IF l_tplcode[l_i].progtype = g_dzfq_m.cbo_progtype THEN
            LET l_n = l_formtype.getLength()

            LET l_gzzd003 = ls_items_pre CLIPPED,g_dzfq_m.cbo_progtype,".",l_tplcode[l_i].formtype CLIPPED
            EXECUTE adzp168_formlang_pre01 INTO l_gzzd005 USING 'adzp168',g_lang,l_gzzd003,"s"

            IF l_n = 0 THEN
               LET l_formtype[1] = l_tplcode[l_i].formtype CLIPPED
               LET ls_values = l_tplcode[l_i].formtype CLIPPED
               LET ls_items = l_tplcode[l_i].formtype CLIPPED,".",l_gzzd005 CLIPPED

               IF g_def_reset THEN
                  LET g_dzfq_m.cbo_formtype = l_tplcode[l_i].formtype CLIPPED
               END IF
            ELSE
               IF l_tplcode[l_i].formtype <> l_formtype[l_n] THEN
                  LET l_exist = FALSE
                  FOR l_j = 1 TO l_n
                     IF l_tplcode[l_i].formtype = l_formtype[l_j] THEN
                        LET l_exist = TRUE
                        EXIT FOR
                     END IF
                  END FOR
                  IF NOT l_exist THEN
                     LET l_n = l_n + 1
                     LET l_formtype[l_n] = l_tplcode[l_i].formtype
                     LET ls_values = ls_values CLIPPED, ",", l_tplcode[l_i].formtype CLIPPED
                     LET ls_items = ls_items CLIPPED, ",", l_tplcode[l_i].formtype CLIPPED,".",l_gzzd005 CLIPPED
                  END IF
               END IF
            END IF
         END IF
      END FOR
   END IF
   ### -----------

   CALL cl_set_combo_items("cbo_formtype", ls_values, ls_items)
   CALL adzp168_cb_setbrowse()
END FUNCTION


#+ 設定下拉式選單內容-資料瀏覽區塊(sc:查詢方案/ ht:左方樹狀/ vt:上方樹狀/ 00:不需要)
PRIVATE FUNCTION adzp168_cb_setbrowse()
   DEFINE ls_values       STRING                #ComboBox values
   DEFINE ls_items        STRING                #ComboBox items
   DEFINE ls_items_pre    STRING                #多語言代碼前置名稱
   DEFINE l_gzzd003       LIKE gzzd_t.gzzd003   #多語言代碼
   DEFINE l_gzzd005       LIKE gzzd_t.gzzd005   #多語言名稱
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_j             LIKE type_t.num5
   DEFINE l_n             LIKE type_t.num5
   DEFINE l_exist         BOOLEAN
   DEFINE ls_val          STRING
   DEFINE ls_text         STRING
   DEFINE l_str           STRING
   DEFINE l_setbrowse     DYNAMIC ARRAY OF STRING
   DEFINE l_chk           BOOLEAN

   LET ls_items_pre = "cbo_setbrowse."
   CALL l_setbrowse.clear()

   FOR l_i = 1 TO g_tplcode.getLength()
      CASE
         #子程式不要有瀏覽區塊
         WHEN g_dzfq_m.dzfq005 = "S" OR g_dzfq_m.dzfq005 = "F"
            IF g_tplcode[l_i].setbrowse = "00" THEN
               LET l_chk = TRUE
            ELSE
               LET l_chk = FALSE
            END IF
         OTHERWISE
            LET l_chk = TRUE
      END CASE

      IF l_chk AND g_tplcode[l_i].progtype = g_dzfq_m.cbo_progtype AND g_tplcode[l_i].formtype = g_dzfq_m.cbo_formtype THEN
         LET l_n = l_setbrowse.getLength()

         IF l_n = 0 THEN
            #LET l_n = 1
            #LET l_setbrowse[l_n] = "00"
            #LET ls_values = l_setbrowse[l_n] CLIPPED
            #LET ls_items = l_setbrowse[l_n] CLIPPED

            LET l_n = l_n + 1
            LET l_setbrowse[l_n] = g_tplcode[l_i].setbrowse CLIPPED
            LET ls_values = l_setbrowse[l_n] CLIPPED

            LET l_gzzd003 = ls_items_pre CLIPPED,l_setbrowse[l_n] CLIPPED
            LET l_gzzd005 = NULL
            EXECUTE adzp168_formlang_pre01 INTO l_gzzd005 USING 'adzp168',g_lang,l_gzzd003,"c"
            IF cl_null(l_gzzd005) THEN
               EXECUTE adzp168_formlang_pre01 INTO l_gzzd005 USING 'adzp168',g_lang,l_gzzd003,"s"
               IF cl_null(l_gzzd005) THEN
                  LET l_gzzd005 = l_setbrowse[l_n] CLIPPED
               END IF
            END IF
            LET ls_items = l_gzzd005 CLIPPED

            IF g_def_reset THEN
               LET g_dzfq_m.cbo_setbrowse = g_tplcode[l_i].setbrowse CLIPPED
               CALL adzp168_dzfq016()   #樹狀結構類別設定值是否清空
            END IF

            CALL adzp168_dzfq001_str()
         ELSE
            IF g_tplcode[l_i].setbrowse <> l_setbrowse[l_n] THEN
               LET l_exist = FALSE
               FOR l_j = 1 TO l_n
                  IF g_tplcode[l_i].setbrowse = l_setbrowse[l_j] THEN
                     LET l_exist = TRUE
                     EXIT FOR
                  END IF
               END FOR
               IF NOT l_exist THEN
                  LET l_n = l_n + 1
                  LET l_setbrowse[l_n] = g_tplcode[l_i].setbrowse
                  LET ls_values = ls_values CLIPPED, ",", l_setbrowse[l_n] CLIPPED

                  LET l_gzzd003 = ls_items_pre CLIPPED,l_setbrowse[l_n] CLIPPED
                  LET l_gzzd005 = NULL
                  EXECUTE adzp168_formlang_pre01 INTO l_gzzd005 USING 'adzp168',g_lang,l_gzzd003,"c"
                  IF cl_null(l_gzzd005) THEN
                     EXECUTE adzp168_formlang_pre01 INTO l_gzzd005 USING 'adzp168',g_lang,l_gzzd003,"s"
                     IF cl_null(l_gzzd005) THEN
                        LET l_gzzd005 = l_setbrowse[l_n] CLIPPED
                     END IF
                  END IF
                  LET ls_items = ls_items CLIPPED, ",", l_gzzd005 CLIPPED
                  #LET ls_items = ls_items CLIPPED, ",", l_setbrowse[l_n] CLIPPED
               END IF
            END IF
         END IF
      END IF
   END FOR

   CALL cl_set_combo_items("cbo_setbrowse", ls_values, ls_items)
END FUNCTION

#+ 結構代號組字串
PRIVATE FUNCTION adzp168_dzfq001_str()
   LET g_dzfq_m.dzfq001 = g_dzfq_m.cbo_progtype CLIPPED,g_dzfq_m.cbo_formtype CLIPPED,"_",g_dzfq_m.cbo_setbrowse CLIPPED

   #F003_sc
END FUNCTION

#+ 結構代號拆解字串
FUNCTION adzp168_dzfq001_substr()
   DEFINE l_progtype  STRING       #程式類型(S/F/R/P)
   DEFINE l_formtype  STRING       #畫面類型(001/002/003...)
   DEFINE l_setbrowse STRING       #資料瀏覽區塊(sc/ht/vt/00)
   DEFINE l_dzfq001   STRING
   DEFINE l_i         LIKE type_t.num5
   DEFINE l_k         LIKE type_t.num5

   LET l_dzfq001 = g_dzfq_m.dzfq001
   IF NOT cl_null(l_dzfq001) THEN
      LET l_progtype = l_dzfq001.getCharAt(1)
      LET l_k = l_dzfq001.getIndexOf("_",1)
      LET l_formtype = l_dzfq001.subString(2,l_k-1)
      LET l_setbrowse = l_dzfq001.subString(l_k+1,l_dzfq001.getLength())
   END IF

   RETURN l_progtype,l_formtype,l_setbrowse
   #l_progtype=F,l_formtype=003,l_setbrowse=sc
END FUNCTION

#+ 樹狀結構類別設定值是否清空
FUNCTION adzp168_dzfq016()
   #不可設定樹狀屬性時 或 樣版不支援樹狀結構類別
   IF (adzp168_tree_config_chk(FALSE) = 0) OR (NOT sadzp168_1_dzfq016_chk(g_dzfq_m.dzfq016,FALSE)) THEN
      LET g_dzfq_m.dzfq016 = NULL
      EXECUTE adzp168t3_del_all_pre USING g_dzfq_m.dzfq004,g_ver_dzag003    #刪除暫存檔dzff
   END IF
END FUNCTION


#+ ToolBar Action
PRIVATE FUNCTION adzp168_toolbar(p_is_draft)
   DEFINE p_is_draft BOOLEAN          #是否使用底稿
   DEFINE l_ddoc     om.DomDocument
   DEFINE l_dnode    om.DomNode
   DEFINE l_dnode_c  om.DomNode
   DEFINE l_path     STRING
   DEFINE l_file     STRING
   DEFINE l_name     STRING
   DEFINE l_cnt_att  LIKE type_t.num5
   DEFINE l_cnt_ch   LIKE type_t.num5
   DEFINE l_cnt_tb   LIKE type_t.num5
   DEFINE l_i        LIKE type_t.num5
   DEFINE l_j        LIKE type_t.num5
   DEFINE l_k        LIKE type_t.num5
   DEFINE l_idx      LIKE type_t.num5
   DEFINE l_str      STRING
   DEFINE l_chk      BOOLEAN
   DEFINE l_act_set DYNAMIC ARRAY OF RECORD
            dzfu002   LIKE dzfu_t.dzfu002   #不可設定的action
            END RECORD

   CALL l_act_set.clear()
   CALL g_toolbar.clear()
   LET l_cnt_ch = 0
   LET l_cnt_tb = 0

   IF g_dzfq_m.dzfq015 = "N" THEN    #是否空框架畫面檔
      IF cl_null(g_gzza002) THEN
         CALL sadzp168_1_gzza002(g_dzfq_m.dzfq004,g_dzfq_m.dzfq005) RETURNING g_gzza002,g_gzza003,g_gzza003_module,g_dzfq_m.gzzal003      #程式類別,模組代碼,程式名稱,是否使用樣板
      END IF

      #不可設定的action
      LET g_sql = "SELECT dzfu002 FROM dzfu_t WHERE dzfustus='Y' AND dzfu001 = ?"
      PREPARE adzp168_dzfu002_stus_y_pre FROM g_sql
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'PREPARE stus_n_pre:'
         LET g_errparam.popup = FALSE
         CALL cl_err()
      END IF
      DECLARE adzp168_dzfu002_stus_y_cur CURSOR FOR adzp168_dzfu002_stus_y_pre

      LET l_i = 1
      FOREACH adzp168_dzfu002_stus_y_cur USING g_gzza002 INTO l_act_set[l_i].dzfu002
         LET l_i = l_i + 1
      END FOREACH
      CALL l_act_set.deleteElement(l_i)
      LET l_i = l_act_set.getLength()
      IF l_i = 0 THEN
         DISPLAY "[msg]: There isn't the action on the ToolBar. ",g_dzfq_m.dzfq001 CLIPPED," + gzza002=",g_gzza002 CLIPPED
      END IF

      #讀取4tb
      LET l_path = FGL_GETENV("ERP")
      LET l_path = os.Path.join(FGL_GETENV("ERP"), "cfg")
      LET l_path = os.Path.join(l_path, "4tb")

      LET l_file = "toolbar_",g_gzza002 CLIPPED,".4tb"
      LET l_file = os.Path.join(l_path, l_file)
      IF os.Path.exists(l_file) THEN
         LET l_ddoc = om.DomDocument.createFromXmlFile(l_file)
         LET l_dnode = l_ddoc.getDocumentElement()
         LET l_cnt_ch = l_dnode.getChildCount()

         IF l_cnt_ch > 0 THEN
            FOR l_i = 1 TO l_cnt_ch
              LET l_dnode_c = l_dnode.getChildByIndex(l_i)
              IF l_dnode_c IS NOT NULL THEN
                 IF l_dnode_c.getTagName() = "ToolBarItem" THEN
                    LET l_cnt_att = l_dnode_c.getAttributesCount()
                    FOR l_j = 1 TO l_cnt_att
                       CASE l_dnode_c.getAttributeName(l_j)
                          WHEN "name"
                             LET l_str = g_dzfq_m.cbo_progtype CLIPPED,g_dzfq_m.cbo_formtype CLIPPED
                             #IF l_str = "F002"
                             #   AND (l_dnode_c.getAttributeValue(l_j) <> "query"
                             #   AND l_dnode_c.getAttributeValue(l_j) <> "modify"
                             #   AND l_dnode_c.getAttributeValue(l_j) <> "insert"
                             #   AND l_dnode_c.getAttributeValue(l_j) <> "delete") THEN
                             #   DISPLAY "i02樣板中不含",l_dnode_c.getAttributeValue(l_j)
                             #   EXIT FOR
                             #ELSE
                                LET l_idx = g_toolbar.getLength() + 1
                                LET g_toolbar[l_idx].tb_act_id = l_dnode_c.getAttributeValue(l_j)
                                IF p_is_draft THEN
                                   LET g_toolbar[l_idx].toolbar_chk = "N"
                                ELSE
                                   LET g_toolbar[l_idx].toolbar_chk = "Y"
                                END IF
                             #END IF
                          WHEN "image"
                             LET g_toolbar[l_idx].tb_img = l_dnode_c.getAttributeValue(l_j)
                       END CASE
                    END FOR
                 END IF
              END IF
            END FOR
         END IF
      ELSE
         DISPLAY l_file CLIPPED," doesn't exist."
      END IF

      #刪除不可設定的action
      LET l_cnt_tb = g_toolbar.getLength()
      LET l_idx = g_toolbar.getLength()
      WHILE l_idx > 0
         LET l_chk = FALSE
         FOR l_i = 1 TO l_act_set.getLength()
            IF g_toolbar[l_idx].tb_act_id = l_act_set[l_i].dzfu002 THEN
               #CALL g_toolbar.deleteElement(l_idx)
               LET l_chk = TRUE
               EXIT FOR
            END IF
         END FOR

         IF NOT l_chk THEN
            CALL g_toolbar.deleteElement(l_idx)
         END IF
         LET l_idx = l_idx - 1
      END WHILE

      #讀取4ad補資訊
      LET l_i = g_toolbar.getLength()
      IF l_i > 0 THEN
         LET l_path = FGL_GETENV("ERP")
         LET l_path = os.Path.join(FGL_GETENV("ERP"), "cfg")
         LET l_path = os.Path.join(l_path, "4ad")

         LET l_str = g_lang
         LET l_file = "tiptop_",l_str CLIPPED,".4ad"
         LET l_file = os.Path.join(l_path, l_file)

         IF os.Path.exists(l_file) THEN
            LET l_ddoc = om.DomDocument.createFromXmlFile(l_file)
            LET l_dnode = l_ddoc.getDocumentElement()
            LET l_cnt_ch = l_dnode.getChildCount()

            IF l_cnt_ch > 0 THEN
               LET l_cnt_tb = g_toolbar.getLength()
               FOR l_i = 1 TO l_cnt_ch
                 LET l_dnode_c = l_dnode.getChildByIndex(l_i)
                 IF l_dnode_c IS NOT NULL THEN
                    IF l_dnode_c.getTagName() = "ActionDefault" THEN
                       LET l_cnt_att = l_dnode_c.getAttributesCount()
                       LET l_idx = 0
                       FOR l_j = 1 TO l_cnt_att
                          CASE l_dnode_c.getAttributeName(l_j)
                             WHEN "name"
                                FOR l_k = 1 TO l_cnt_tb
                                   LET l_str = l_dnode_c.getAttributeValue(l_j)
                                   IF g_toolbar[l_k].tb_act_id = l_str THEN
                                      LET l_idx = l_k
                                   END IF
                                END FOR

                             WHEN "text"
                                IF l_idx > 0 THEN
                                   IF cl_null(g_toolbar[l_idx].tb_act_name) THEN
                                      LET g_toolbar[l_idx].tb_act_name = l_dnode_c.getAttributeValue(l_j)
                                   END IF
                                END IF

                             WHEN "image"
                                IF l_idx > 0 THEN
                                   IF cl_null(g_toolbar[l_idx].tb_img) THEN
                                      LET g_toolbar[l_idx].tb_img = l_dnode_c.getAttributeValue(l_j)
                                   END IF
                                END IF
                          END CASE
                       END FOR
                    END IF
                 END IF
               END FOR
            END IF
         ELSE
            DISPLAY l_file CLIPPED," doesn't exist."
         END IF

      END IF
   END IF

   IF p_is_draft THEN
      CALL adzp168_toolbar_draft_fill()
   END IF
END FUNCTION


#+ 查詢Table名稱
PRIVATE FUNCTION adzp168_tablename(p_tableid)
   DEFINE  p_tableid   LIKE dzeal_t.dzeal001   #Table代碼
   DEFINE  l_ret       LIKE dzeal_t.dzeal003   #Table名稱
   DEFINE  l_i         LIKE type_t.num5

   LET g_sql = "SELECT dzeal003 FROM dzeal_t WHERE dzeal001 = ? AND dzeal002 = ?"
   PREPARE adzp168_tablename_pre FROM g_sql
   EXECUTE adzp168_tablename_pre USING p_tableid,g_lang INTO l_ret

   RETURN l_ret
END FUNCTION

#+ 檢查父子Table之間的外來鍵是否設定完整
PRIVATE FUNCTION adzp168_table_fkchk(p_tb1,p_tb2,p_type,p_ischild)
   DEFINE p_tb1       LIKE dzed_t.dzed001   #table代號 (子)
   DEFINE p_tb2       LIKE dzed_t.dzed005   #外來鍵表格 (父)
   DEFINE p_type      LIKE dzed_t.dzed003   #鍵值形式
   DEFINE l_type_msg  LIKE dzed_t.dzed003   #鍵值形式 for msg
   DEFINE p_ischild   BOOLEAN               #table代號是否為外來鍵表格的下階層
   DEFINE l_cnt       LIKE type_t.num5
   DEFINE l_i         LIKE type_t.num5
   DEFINE l_j         LIKE type_t.num5
   DEFINE l_tb1_idx   LIKE type_t.num5
   DEFINE l_tb2_idx   LIKE type_t.num5      #外來鍵表格index
   DEFINE l_dzed004   LIKE dzed_t.dzed004   #鍵值欄位
   DEFINE l_dzed006   LIKE dzed_t.dzed006   #外來鍵欄位
   DEFINE l_str       STRING
   DEFINE l_tok       base.StringTokenizer
   DEFINE l_tmp       STRING
   DEFINE l_chk       BOOLEAN
   DEFINE l_pk            DYNAMIC ARRAY OF RECORD
      dzeb001   LIKE dzeb_t.dzeb001,         #table代號
      dzeb002   LIKE dzeb_t.dzeb002,         #欄位代號
      l_chk     BOOLEAN
      END RECORD

   IF adzp168_notchk() AND g_tbtree_idx = 1 THEN   #特殊版型不檢查單頭資料表
      LET l_chk = TRUE
   ELSE
      LET l_chk = FALSE

      LET g_sql = "SELECT COUNT(dzed002) FROM dzed_t WHERE dzed001 = ? AND dzed003 = ? AND dzed005 = ?"
      PREPARE adzp168_table_fkchk_fk FROM g_sql
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'PREPARE:'
         LET g_errparam.popup = FALSE
         CALL cl_err()
      END IF
      EXECUTE adzp168_table_fkchk_fk USING p_tb1,p_type,p_tb2 INTO l_cnt

      CASE p_type
         WHEN "F"
            LET l_type_msg = "Foreign"
         #WHEN "P"
         #   LET l_type_msg = "Primary Key"
      END CASE

      IF l_cnt = 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  "adz-00051"
         LET g_errparam.extend = NULL
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] =  p_tb1 CLIPPED
         LET g_errparam.replace[2] =  p_tb2 CLIPPED
         CALL cl_err()
      ELSE
         LET l_tb2_idx = 0
         FOR l_i = 2 TO g_tbtree.getLength()
            IF g_tbtree[l_i].b_tableid = p_tb2 THEN
               LET l_tb2_idx = l_i
            END IF
         END FOR

         #父PK是否都有設在子的FK
         LET l_cnt = 0
         LET l_j = 1
         CALL l_pk.clear()
         FOREACH adzp168_col_pk_cur2 USING p_tb2 INTO l_pk[l_j].dzeb002   #父PK
            LET l_pk[l_j].dzeb001 = p_tb2 CLIPPED
            LET l_pk[l_j].l_chk = FALSE

            FOREACH adzp168_col_pkfkcur_3 USING p_tb1,'F',g_tbtree[l_tb2_idx].b_tableid INTO l_dzed006
               LET l_str = l_dzed006 CLIPPED
               LET l_tok = base.StringTokenizer.createExt(l_str CLIPPED,",","",TRUE)	#指定分隔符號
               WHILE l_tok.hasMoreTokens()	#依序取得子字串
                  LET l_tmp = l_tok.nextToken()
                  LET l_tmp = l_tmp.trim()

                  IF l_tmp = l_pk[l_j].dzeb002 THEN
                     LET l_pk[l_j].l_chk = TRUE
                     EXIT WHILE
                  END IF
               END WHILE
            END FOREACH

            #父PK沒設於子FK
            IF NOT l_pk[l_j].l_chk THEN
               LET l_chk = FALSE
               EXIT FOREACH
            ELSE
               LET l_chk = TRUE
            END IF

            LET l_j = l_pk.getLength() + 1
         END FOREACH
         CALL l_pk.deleteElement(l_j)

         LET l_cnt = l_pk.getLength()

         IF NOT l_chk THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00079"
            LET g_errparam.extend = NULL
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] =  p_tb1 CLIPPED
            LET g_errparam.replace[2] =  p_tb2 CLIPPED
            CALL cl_err()
         END IF


         #PK數量與FK數量比對
         IF l_chk THEN
            LET l_cnt = 0
            LET l_j = 1
            CALL l_pk.clear()

            FOREACH adzp168_col_pk_cur2 USING p_tb1 INTO l_pk[l_j].dzeb002   #單身PK
               LET l_pk[l_j].dzeb001 = p_tb1 CLIPPED
               LET l_pk[l_j].l_chk = FALSE

               FOREACH adzp168_col_pkfkcur_2 USING p_tb1,'F',g_tbtree[l_tb2_idx].b_tableid INTO l_dzed004
                  LET l_str = l_dzed004 CLIPPED
                  LET l_tok = base.StringTokenizer.createExt(l_str CLIPPED,",","",TRUE)	#指定分隔符號
                  WHILE l_tok.hasMoreTokens()	#依序取得子字串
                     LET l_tmp = l_tok.nextToken()
                     LET l_tmp = l_tmp.trim()

                     IF l_tmp = l_pk[l_j].dzeb002 THEN #排除PK = FK
                        CALL l_pk.deleteElement(l_j)
                        EXIT WHILE
                     END IF
                  END WHILE
               END FOREACH

               LET l_j = l_pk.getLength() + 1
            END FOREACH
            CALL l_pk.deleteElement(l_j)

            LET l_cnt = l_pk.getLength()


            #主Table的下階層Table,要有自己的PK(PK數量多於FK)
            IF p_ischild THEN
               IF l_cnt > 0 THEN    #PK數量 > FK數量
                  LET l_chk = TRUE
               ELSE
                  LET l_chk = FALSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  "adz-00080"
                  LET g_errparam.extend = NULL
                  LET g_errparam.popup = TRUE
                  LET g_errparam.replace[1] =  p_tb1 CLIPPED
                  LET g_errparam.replace[2] =  p_tb2 CLIPPED
                  CALL cl_err()
               END IF

            ELSE
               IF l_cnt >= 0 THEN    #PK數量 >= FK數量
                  LET l_chk = TRUE
               ELSE
                  LET l_chk = FALSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  "adz-00081"
                  LET g_errparam.extend = NULL
                  LET g_errparam.popup = TRUE
                  LET g_errparam.replace[1] =  p_tb1 CLIPPED
                  LET g_errparam.replace[2] =  p_tb2 CLIPPED
                  CALL cl_err()
               END IF
                #2014/04/10 開放,不限制主Table的同階層Table,外來鍵必須完全等於主Table,只限制有比主Table的PK多就好
            #   #主Table的同階層Table,外來鍵必須完全等於主Table
            #   IF l_cnt = 0 THEN    #PK數量 = FK數量
            #      LET l_chk = TRUE
            #   ELSE
            #      LET l_chk = FALSE
            #      CALL cl_err_msg(NULL, "adz-00081", p_tb1 CLIPPED || "|" || p_tb2 CLIPPED , 1)  #主Table的同階層Table %1,外來鍵必須完全等於主Table %2的主鍵
            #   END IF
            END IF
         END IF
      END IF
   END IF

   RETURN l_chk
END FUNCTION

#+ 例外的特殊版型
PRIVATE FUNCTION adzp168_notchk()
   DEFINE l_chk           BOOLEAN

   IF (g_dzfq_m.cbo_progtype = "Q" AND g_dzfq_m.cbo_setbrowse <> "00") OR g_dzfq_m.cbo_progtype = "P" OR g_dzfq_m.cbo_progtype = "R" THEN
      LET l_chk = TRUE
   ELSE
      LET l_chk = FALSE
   END IF

   RETURN l_chk
END FUNCTION

#+ 畫面樣版
PRIVATE FUNCTION adzp168_form_tpl(p_formtpl)
   DEFINE p_formtpl       LIKE dzfq_t.dzfq001    #畫面結構代號
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_j             LIKE type_t.num5
   DEFINE l_zero          LIKE type_t.num10
   DEFINE l_dzfm RECORD
      dzfm004 LIKE dzfm_t.dzfm004,
      dzfm005 LIKE dzfm_t.dzfm005,
      dzfm006 LIKE dzfm_t.dzfm006,
      dzfm007 LIKE dzfm_t.dzfm007,
      dzfm008 LIKE dzfm_t.dzfm008,
      dzfm009 LIKE dzfm_t.dzfm009,
      dzfm010 LIKE dzfm_t.dzfm010
      END RECORD
   DEFINE l_add_m_idx      LIKE type_t.num10   #預設加入單頭區塊index
   DEFINE l_add_d_idx      LIKE type_t.num10   #預設加入單身區塊index
   DEFINE l_add_d_exp_idx  LIKE type_t.num10   #預設加入單身底下附屬區塊index
   DEFINE l_str            STRING
   DEFINE l_dzfr003        LIKE dzfr_t.dzfr003 #編號

   LET g_ftree_idx = 0
   CALL g_form_vbm_stc.clear()
   CALL g_form_vbd_stc.clear()
   CALL g_form_vbm_exp_stc.clear()
   #CALL g_dzfr_d.clear()
   #CLEAR FORM

   DELETE FROM adzp168t1
   LET g_sql = "SELECT dzfm004,dzfm005,dzfm006,dzfm007,dzfm008,dzfm009,dzfm010",
               " FROM dzfm_t WHERE dzfm001 = ? AND dzfm002 = ? AND dzfm008 = 'Y' ORDER BY dzfm003"
   PREPARE adzp168_form_tpl FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'PREPARE:'
      LET g_errparam.popup = FALSE
      CALL cl_err()
   END IF
   DECLARE adzp168_form_tplcur CURSOR FOR adzp168_form_tpl

   IF cl_null(g_dzfq_m.dzfq002) THEN   #for new
      #公版-畫面樣版結構版號,取得最新版      #todo
      LET g_sql = "SELECT MAX(dzfm002) FROM dzfm_t WHERE dzfm001=?"
      PREPARE adzp168_form_ver_tpl FROM g_sql
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'PREPARE:'
         LET g_errparam.popup = FALSE
         CALL cl_err()
      END IF
      EXECUTE adzp168_form_ver_tpl USING p_formtpl INTO g_ver_tpl  #最新版
      LET g_dzfq_m.dzfq002 = g_ver_tpl CLIPPED
   ELSE
      LET g_ver_tpl = g_dzfq_m.dzfq002 CLIPPED
   END IF


   LET l_zero = 0
   LET l_i = 1
   LET l_add_m_idx = 0
   LET l_add_d_idx = 0
   LET l_add_d_exp_idx = 0
   FOREACH adzp168_form_tplcur USING p_formtpl,g_ver_tpl INTO l_dzfm.*
      LET l_dzfm.dzfm006 = l_dzfm.dzfm006 CLIPPED
      LET l_dzfm.dzfm007 = l_dzfm.dzfm007 CLIPPED
      EXECUTE adzp168t1_ins USING l_i,l_zero,l_i,l_dzfm.dzfm007,l_dzfm.dzfm006,l_zero,'','','N','','','','','','',''
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'ins TEMP:'
         LET g_errparam.popup = FALSE
         CALL cl_err()
         EXIT FOREACH
      END IF

      IF g_dzfq_m.dzfq015 = "N" THEN   #非空框架畫面檔
         #畫面區塊階層架構-單頭 g_form_vbm_stc
         #Folder -> Page
         #Group
         #Grid

         #畫面區塊階層架構-單身 g_form_vbd_stc
         #Table
         #ScrollGrid -> row
         #Hbox -> Folder -> Page -> Table
         #Vbox -> Folder -> Page -> Table
         #Hbox -> Folder -> Page -> ScrollGrid -> row
         #Vbox -> Folder -> Page -> ScrollGrid -> row
         #Hbox -> Group -> Table
         #Vbox -> Group -> Table
         #Hbox -> Group -> Tree
         #Vbox -> Group -> Tree

         #畫面區塊階層架構-單身底下附屬區塊 g_form_vbm_exp_stc
         #Folder -> Page

         #畫面區塊階層架構-單頭固定區塊 g_form_vbhl_stc
         #Group

         LET l_j = 0
         CASE l_dzfm.dzfm006
            WHEN "vb_headerlock"   #單頭固定區塊
               LET l_j = l_j + 1
               LET g_form_vbhl_stc[l_j].dzfr006 = "Group"
               LET g_form_vbhl_stc[l_j].addcol = TRUE

            WHEN "vb_master"
               LET l_add_m_idx = l_i
               #階層架構
               CASE g_dzfq_m.dzfq007   #單頭框架(Folder/Group/Grid)
                  WHEN "Folder"
                     LET l_j = l_j + 1
                     LET g_form_vbm_stc[l_j].dzfr006 = g_dzfq_m.dzfq007 CLIPPED
                     LET g_form_vbm_stc[l_j].addcol = FALSE
                     LET l_j = l_j + 1
                     LET g_form_vbm_stc[l_j].dzfr006 = "Page"
                     LET g_form_vbm_stc[l_j].addcol = TRUE
                  OTHERWISE
                     LET l_j = l_j + 1
                     LET g_form_vbm_stc[l_j].dzfr006 = g_dzfq_m.dzfq007 CLIPPED
                     LET g_form_vbm_stc[l_j].addcol = TRUE
               END CASE

            WHEN "vb_detail"
               LET l_add_d_idx = l_i
               #階層架構
               CASE g_dzfq_m.dzfq009   #單身切割框架(sarray:單一/Folder/HBox/VBox/HFolder/VFolder/HGroup/VGroup)
                  WHEN "HFolder"
                     LET l_j = l_j + 1
                     LET g_form_vbd_stc[l_j].dzfr006 = "HBox"
                     LET g_form_vbd_stc[l_j].addcol = FALSE
                  WHEN "VFolder"
                     LET l_j = l_j + 1
                     LET g_form_vbd_stc[l_j].dzfr006 = "VBox"
                     LET g_form_vbd_stc[l_j].addcol = FALSE
                  WHEN "HGroup"
                     LET l_j = l_j + 1
                     LET g_form_vbd_stc[l_j].dzfr006 = "HBox"
                     LET g_form_vbd_stc[l_j].addcol = FALSE
                  WHEN "VGroup"
                     LET l_j = l_j + 1
                     LET g_form_vbd_stc[l_j].dzfr006 = "VBox"
                     LET g_form_vbd_stc[l_j].addcol = FALSE
               END CASE

               LET l_str = g_dzfq_m.dzfq009
               CASE
                  WHEN l_str.getIndexOf("Folder",1) > 0
                     LET l_j = l_j + 1
                     LET g_form_vbd_stc[l_j].dzfr006 = "Folder"
                     LET g_form_vbd_stc[l_j].addcol = FALSE
                     LET l_j = l_j + 1
                     LET g_form_vbd_stc[l_j].dzfr006 = "Page"
                     LET g_form_vbd_stc[l_j].addcol = FALSE
                  WHEN l_str.getIndexOf("Group",1) > 0
                     LET l_j = l_j + 1
                     LET g_form_vbd_stc[l_j].dzfr006 = "Group"
                     LET g_form_vbd_stc[l_j].addcol = FALSE
               END CASE

               #單身框架(Table/ScrollGrid)
               LET l_j = l_j + 1
               LET g_form_vbd_stc[l_j].dzfr006 = g_dzfq_m.dzfq010 CLIPPED
               LET g_form_vbd_stc[l_j].addcol = TRUE
               CASE g_dzfq_m.dzfq010
                  WHEN "ScrollGrid"
                     LET l_j = l_j + 1
                     LET g_form_vbd_stc[l_j].dzfr006 = "row"
                     LET g_form_vbd_stc[l_j].addcol = TRUE
               END CASE

            WHEN "vb_detailexp"
               LET l_add_d_exp_idx = l_i
               LET l_j = l_j + 1
               LET g_form_vbm_exp_stc[l_j].dzfr006 = "Folder"
               LET g_form_vbm_exp_stc[l_j].addcol = FALSE
               LET l_j = l_j + 1
               LET g_form_vbm_exp_stc[l_j].dzfr006 = "Page"
               LET g_form_vbm_exp_stc[l_j].addcol = TRUE
         END CASE
      END IF
      LET l_i = l_i + 1
   END FOREACH
   #CALL g_dzfr_d.deleteElement(l_i)

   #DISPLAY "stc------------------"
   #IF g_form_vbm_stc.getLength() > 0 THEN
   #   LET l_str = NULL
   #   FOR l_j = 1 TO g_form_vbm_stc.getLength()
   #      LET l_str = l_str,",",g_form_vbm_stc[l_j].dzfr006
   #   END FOR
   #  DISPLAY "g_form_vbm_stc: ",l_str
   #END IF
   #IF g_form_vbd_stc.getLength() > 0 THEN
   #   LET l_str = NULL
   #   FOR l_j = 1 TO g_form_vbd_stc.getLength()
   #      LET l_str = l_str,",",g_form_vbd_stc[l_j].dzfr006
   #   END FOR
   #  DISPLAY "g_form_vbd_stc: ",l_str
   #END IF
   #IF g_form_vbm_exp_stc.getLength() > 0 THEN
   #   LET l_str = NULL
   #   FOR l_j = 1 TO g_form_vbm_exp_stc.getLength()
   #      LET l_str = l_str,",",g_form_vbm_exp_stc[l_j].dzfr006
   #   END FOR
   #  DISPLAY "g_form_vbm_exp_stc: ",l_str
   #END IF


   CALL adzp168_form_tree_fill("0",0,"0",TRUE)

   IF g_form_tree.getLength() > 0 THEN   #預設focus
      #預設新增區塊
      IF l_add_m_idx > 0 THEN   #單頭
         CALL adzp168_form_add_master("vb_master",l_add_m_idx,g_dzfq_m.dzfq007,"N")
      END IF

      IF l_add_d_idx > 0 THEN   #單身
         FOR l_i = 1 TO g_form_tree.getLength()   #因為新增單頭時重整array,所以要重新找index
            IF g_form_tree[l_i].dzfr007 = "vb_detail" THEN
               CALL adzp168_form_add_detail(l_i,"N") RETURNING l_dzfr003
               EXIT FOR
            END IF
         END FOR
      END IF

      #單身底下附屬區塊,模擬單頭的方式加入Folder
      IF l_add_d_exp_idx > 0 THEN
         FOR l_i = 1 TO g_form_tree.getLength()   #因為新增單身時重整array,所以要重新找index
            IF g_form_tree[l_i].dzfr007 = "vb_detailexp" THEN
               CALL adzp168_form_add_master("vb_detailexp",l_i,"Folder","N")
               EXIT FOR
            END IF
         END FOR
      END IF

      #單頭固定區塊,模擬單頭的方式加入Group
      FOR l_i = 1 TO g_form_tree.getLength()   #因為新增單身時重整array,所以要重新找index
         IF g_form_tree[l_i].dzfr007 = "vb_headerlock" THEN
            CALL adzp168_form_add_master("vb_headerlock",l_i,"Group","N")
            EXIT FOR
         END IF
      END FOR

      LET g_ftree_idx = 1
   END IF

   IF g_def_reset THEN
      LET g_tbtree_idx = 0
      LET g_column_idx= 0

      CALL g_tbtree.clear() #todo
      CALL g_column.clear() #todo
      CALL adzp168_col_setcolor()
   END IF
   CALL adzp168_set_entry_by_cbo_setbrowse()
   CALL adzp168_tpl_img()

   EXECUTE adzp168t3_del_all_pre USING g_dzfq_m.dzfq004,g_ver_dzag003    #刪除暫存檔dzff
END FUNCTION


#+ 顯示畫面樣版Demo圖片
PRIVATE FUNCTION adzp168_tpl_img()
   DEFINE l_img_dir        STRING   #圖片路徑
   DEFINE l_img_template   STRING
   DEFINE l_str            STRING
   DEFINE l_str2           STRING

   LET l_img_dir = "formtplpic/"

   LET l_img_dir = l_img_dir CLIPPED,g_dzfq_m.dzfq001 CLIPPED
                        ,"_",g_dzfq_m.dzfq006 CLIPPED,"/"

   IF g_4fd_inf.form_vbm_idx > 0 THEN
      LET l_img_template = g_dzfq_m.dzfq007 CLIPPED   #單頭框架
      #LET l_str = l_str.toLowerCase()
   END IF

   IF g_4fd_inf.form_vbd_idx > 0 THEN
      IF cl_null(l_img_template) THEN
         LET l_img_template = "b",g_dzfq_m.dzfq009 CLIPPED ,"_",g_dzfq_m.dzfq010 CLIPPED
      ELSE
         LET l_img_template = l_img_template CLIPPED,"_", "b",g_dzfq_m.dzfq009 CLIPPED ,"_",g_dzfq_m.dzfq010 CLIPPED
      END IF
   END IF

   #因完全沒有畫面結構的空框架版型,無法從畫面結構產生圖片名稱,所以要預設圖片名稱
   IF cl_null(l_img_template) AND (g_dzfq_m.cbo_progtype = "P" OR g_dzfq_m.cbo_progtype = "R") THEN
      LET l_img_template = g_dzfq_m.dzfq007 CLIPPED   #單頭框架
   END IF
   LET l_img_template = l_img_template.toLowerCase()
   LET l_img_template = l_img_dir CLIPPED,l_img_template

   #img_template=formtplpic/F001_00_mq/folder
   DISPLAY l_img_template TO img_template
END FUNCTION

#+ 取得產生4fd所需要的資訊
PRIVATE FUNCTION adzp168_get_4fd_inf()
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_cnt           LIKE type_t.num5

   LET l_cnt = g_form_tree.getLength()
   IF l_cnt = 0 THEN
      LET g_4fd_inf.form_browse_idx = 0      #瀏覽表index
      LET g_4fd_inf.form_vbm_idx = 0         #單頭index
      LET g_4fd_inf.form_vbd_idx = 0         #單身index
      LET g_4fd_inf.form_vbd_exp_idx = 0     #單身底下附屬區塊index
      LET g_4fd_inf.l_jiashuangdang = FALSE
   ELSE
      FOR l_i = 1 TO l_cnt
         #產生4fd所需要的資訊
         CASE g_form_tree[l_i].dzfr007
            WHEN "s_browse"       #是否有瀏覽表
               LET g_4fd_inf.form_browse_idx = l_i
            WHEN "vb_master"      #是否有單頭
               LET g_4fd_inf.form_vbm_idx = l_i
            WHEN "vb_detail"      #是否有單身
               LET g_4fd_inf.form_vbd_idx = l_i
            WHEN "vb_detailexp"   #是否有單身底下附屬區塊
               LET g_4fd_inf.form_vbd_exp_idx = l_i
            WHEN "vb_headerlock"  #是否有單頭固定區塊
               LET g_4fd_inf.form_vbhl_idx = l_i
         END CASE
      END FOR

      CALL adzp168_prog_class()   #程式變化類型(假雙檔:JiaShuangDang)
   END IF
END FUNCTION


#+ 畫面樣版Tree資料
PRIVATE FUNCTION adzp168_form_tree_fill(p_pid,p_plevel,p_dzfr004,p_isrename)
   DEFINE p_pid           STRING                #tree - 父節點id
   DEFINE p_plevel        LIKE type_t.num5      #tree - 父階層
   DEFINE p_dzfr004       LIKE dzfr_t.dzfr004   #父節點編號
   DEFINE p_isrename      BOOLEAN               #是否重新命名(將影響已存在的畫面多語言對應)
   DEFINE p_open_dzfr003  LIKE dzfr_t.dzfr003   #指定打開的節點編號(流水號)
   DEFINE l_level         LIKE type_t.num5      #tree - 階層
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_j             LIKE type_t.num5
   DEFINE l_k             LIKE type_t.num5
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_form_data     DYNAMIC ARRAY OF type_g_dzfr_d
   DEFINE l_str           STRING
   DEFINE l_seq           LIKE dzfr_t.dzfr005   #順序(同階層中的排序)
   DEFINE l_sidx          LIKE type_t.num5
   DEFINE l_eidx          LIKE type_t.num5
   DEFINE l_gzzd003       LIKE gzzd_t.gzzd003
   DEFINE l_gzzd005       LIKE gzzd_t.gzzd005
   DEFINE l_img_dir       STRING
   DEFINE l_ln01          LIKE type_t.num5      #資料數,為了判斷遞迴結束
   DEFINE l_ln02          LIKE type_t.num5      #資料數
   DEFINE l_root_idx      LIKE type_t.num5      #focus的Root節點index

   LET l_img_dir = "16/"

   IF p_plevel = 0 THEN
      LET g_form_idx = 0
      LET g_4fd_inf.form_browse_idx = 0      #瀏覽表index
      LET g_4fd_inf.form_vbm_idx = 0         #單頭index
      LET g_4fd_inf.form_vbd_idx = 0         #單身index
      LET g_4fd_inf.form_vbd_exp_idx = 0     #單身底下附屬區塊index
      LET g_4fd_inf.l_jiashuangdang = FALSE

      CALL g_form_tree_t.clear()
      #IF g_def_reset THEN    #是否重設預設值
         LET l_cnt = g_form_tree.getLength()
         FOR l_i = 1 TO l_cnt
            LET g_form_tree_t[l_i].b_hasC = g_form_tree[l_i].b_hasC
            LET g_form_tree_t[l_i].b_exp = g_form_tree[l_i].b_exp
            LET g_form_tree_t[l_i].dzfr003 = g_form_tree[l_i].dzfr003
         END FOR
      #END IF

      CALL g_form_tree.clear()
      SELECT COUNT(*) INTO l_ln01 FROM adzp168t1
   END IF

   #在FOREACH中直接使用recursive,資料會錯亂,所以先將資料放到陣列後處理
   LET l_cnt = 1
   CALL l_form_data.clear()
   FOREACH adzp168_form_tree_cs1 USING p_dzfr004 INTO l_form_data[l_cnt].*
      IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'FOREACH:'
          LET g_errparam.popup = TRUE
          CALL cl_err()
          EXIT FOREACH
      END IF
      LET l_cnt = l_cnt + 1
   END FOREACH
   CALL l_form_data.deleteelement(l_cnt)  #刪除FOREACH最後新增的空白列
   LET l_cnt = l_cnt - 1

   IF l_cnt >0 THEN
      LET l_level = p_plevel + 1
      FOR l_i=1 TO l_cnt
         LET g_form_idx = g_form_idx + 1

         LET g_form_tree[g_form_idx].b_pid = p_pid CLIPPED
         LET l_str = l_i  #數值轉字串
         IF l_level = 1 THEN
            LET g_form_tree[g_form_idx].b_id = l_str CLIPPED
         ELSE
            LET g_form_tree[g_form_idx].b_id = g_form_tree[g_form_idx].b_pid CLIPPED,".",l_str CLIPPED
         END IF
         LET l_seq = l_str CLIPPED

         LET g_form_tree[g_form_idx].b_level = l_level
         LET g_form_tree[g_form_idx].dzfr003 = l_form_data[l_i].dzfr003 CLIPPED   #編號(流水號)
         LET g_form_tree[g_form_idx].dzfr004 = l_form_data[l_i].dzfr004 CLIPPED   #父節點編號
         LET g_form_tree[g_form_idx].dzfr005 = l_form_data[l_i].dzfr005 CLIPPED   #順序(同階層中的排序)
         LET g_form_tree[g_form_idx].dzfr006 = l_form_data[l_i].dzfr006 CLIPPED   #4fd tag 類型
         LET g_form_tree[g_form_idx].dzfr007 = l_form_data[l_i].dzfr007 CLIPPED   #4fd tag name
         LET g_form_tree[g_form_idx].dzfr008 = l_form_data[l_i].dzfr008 CLIPPED   #4fd tag name 編號
         LET g_form_tree[g_form_idx].dzfr009 = l_form_data[l_i].dzfr009 CLIPPED   #資料表代碼
         LET g_form_tree[g_form_idx].dzfr010 = l_form_data[l_i].dzfr010 CLIPPED   #欄位代碼
         LET g_form_tree[g_form_idx].dzfr011 = l_form_data[l_i].dzfr011 CLIPPED   #是否可刪除
         LET g_form_tree[g_form_idx].dzfr012 = l_form_data[l_i].dzfr012 CLIPPED   #4fd tag name前置名稱(s_detail/folder_/page_/page_info_/group_/Grid/HBox/VBox)
         LET g_form_tree[g_form_idx].dzeb004 = l_form_data[l_i].dzeb004 CLIPPED   #primary key
         LET g_form_tree[g_form_idx].dzeb022 = l_form_data[l_i].dzeb022 CLIPPED   #屬於哪一種欄位定義代碼
         LET g_form_tree[g_form_idx].dzekgrp = l_form_data[l_i].dzekgrp CLIPPED   #欄位定義代碼群組grpUIBelong/grpUIStateinfo
         LET g_form_tree[g_form_idx].gzzd005 = l_form_data[l_i].gzzd005 CLIPPED   #畫面元件多語言 by g_lang
         LET g_form_tree[g_form_idx].dzef008 = l_form_data[l_i].dzef008 CLIPPED   #參考欄位
         LET g_form_tree[g_form_idx].dzer007 = l_form_data[l_i].dzer007 CLIPPED   #多語言欄位

         #array index
         UPDATE adzp168t1
            SET arridx = g_form_idx
            WHERE dzfr003 =  g_form_tree[g_form_idx].dzfr003

         IF g_form_tree[g_form_idx].b_level = 1 THEN
            LET l_gzzd005 = NULL
            LET l_gzzd003 = g_form_tree[g_form_idx].dzfr007 CLIPPED
            EXECUTE adzp168_formlang_pre01 USING 'adzp168',g_lang,l_gzzd003,"s" INTO l_gzzd005
            IF NOT cl_null(l_gzzd005) THEN
               LET g_form_tree[g_form_idx].gzzd005 = l_gzzd005 CLIPPED
            END IF
         END IF

         #節點名稱
         CASE
            WHEN g_form_tree[g_form_idx].dzfr006 = "ghost"
               EXECUTE adzp168_formlang_pre01 INTO l_gzzd005 USING 'adzp168',g_lang,'lbl_col_ghost',"s"
               LET g_form_tree[g_form_idx].b_show = l_gzzd005 CLIPPED

            WHEN g_form_tree[g_form_idx].dzfr006 = "Field"
               LET g_form_tree[g_form_idx].b_show = g_form_tree[g_form_idx].dzfr010 CLIPPED,":",g_form_tree[g_form_idx].dzfr007 CLIPPED," ",g_form_tree[g_form_idx].gzzd005 CLIPPED
            WHEN g_form_tree[g_form_idx].dzfr012 = "page_info_"   #加入共用欄位
               EXECUTE adzp168_formlang_pre01 INTO l_gzzd005 USING 'adzp168',g_lang,'lbl_pageinfo_area',"s"
               LET g_form_tree[g_form_idx].b_show = g_form_tree[g_form_idx].dzfr006 CLIPPED,":",g_form_tree[g_form_idx].dzfr007 CLIPPED," ",g_form_tree[g_form_idx].gzzd005 CLIPPED,"(",l_gzzd005 CLIPPED,")"
            WHEN g_form_tree[g_form_idx].dzfr007 = "group_1"
               CALL adzp168_form_tree_root_idx(g_form_idx) RETURNING l_root_idx
               IF l_root_idx = g_4fd_inf.form_vbhl_idx THEN
                  EXECUTE adzp168_formlang_pre01 INTO l_gzzd005 USING 'adzp168',g_lang,'lbl_vb_headerlock',"s"
                  LET g_form_tree[g_form_idx].b_show = l_gzzd005 CLIPPED
               END IF
            OTHERWISE
               LET g_form_tree[g_form_idx].b_show = g_form_tree[g_form_idx].dzfr006 CLIPPED,":",g_form_tree[g_form_idx].dzfr007 CLIPPED," ",g_form_tree[g_form_idx].gzzd005 CLIPPED
         END CASE

         #節點圖片
         CASE #Folder/Page/Group/Grid/HBox/VBox/Table/ScrollGrid/Tree/Field
            WHEN g_form_tree[g_form_idx].dzfr006 = "Folder"
               LET g_form_tree[g_form_idx].b_img = l_img_dir CLIPPED,"folder"

            WHEN g_form_tree[g_form_idx].dzfr006 = "Page"
               IF g_form_tree[g_form_idx].dzfr012 = "page_info_" THEN
                  LET g_form_tree[g_form_idx].b_img = l_img_dir CLIPPED,"page_info"
               ELSE
                  LET g_form_tree[g_form_idx].b_img = l_img_dir CLIPPED,"page"
               END IF

            WHEN g_form_tree[g_form_idx].dzfr006 = "Group"
               LET g_form_tree[g_form_idx].b_img = l_img_dir CLIPPED,"group"
            WHEN g_form_tree[g_form_idx].dzfr006 = "Grid"
               LET g_form_tree[g_form_idx].b_img = l_img_dir CLIPPED,"grid"
            WHEN g_form_tree[g_form_idx].dzfr006 = "HBox"
               LET g_form_tree[g_form_idx].b_img = l_img_dir CLIPPED,"hbox"
            WHEN g_form_tree[g_form_idx].dzfr006 = "VBox"
               LET g_form_tree[g_form_idx].b_img = l_img_dir CLIPPED,"vbox"
            WHEN g_form_tree[g_form_idx].dzfr006 = "Table"
               LET g_form_tree[g_form_idx].b_img = l_img_dir CLIPPED,"table"
            WHEN g_form_tree[g_form_idx].dzfr006 = "ScrollGrid"
               LET g_form_tree[g_form_idx].b_img = l_img_dir CLIPPED,"scrollgrid"
            WHEN g_form_tree[g_form_idx].dzfr006 = "Tree"
               LET g_form_tree[g_form_idx].b_img = l_img_dir CLIPPED,"tree"
            WHEN g_form_tree[g_form_idx].dzfr006 = "Field"
               LET g_form_tree[g_form_idx].b_img = l_img_dir CLIPPED,"text_edit"

               IF NOT cl_null(g_form_tree[g_form_idx].dzef008) THEN   #參考欄位
                  LET g_form_tree[g_form_idx].b_img = l_img_dir CLIPPED,"references"
               END IF

               IF NOT cl_null(g_form_tree[g_form_idx].dzer007) THEN   #多語言欄位
                  LET g_form_tree[g_form_idx].b_img = l_img_dir CLIPPED,"language"
               END IF
            WHEN g_form_tree[g_form_idx].dzfr006 = "row"
               LET g_form_tree[g_form_idx].b_img = l_img_dir CLIPPED,"row"
            WHEN g_form_tree[g_form_idx].dzfr006 = "ghost"
               LET g_form_tree[g_form_idx].b_img = l_img_dir CLIPPED,"col_ghost"

            OTHERWISE
               LET g_form_tree[g_form_idx].b_img = l_img_dir CLIPPED,"module"
         END CASE

         CALL adzp168_get_4fd_inf()   #取得產生4fd所需要的資訊

         LET g_sql = "UPDATE adzp168t1 SET dzfr005 = ?, dzfr007 = ? WHERE dzfr003 = ?"
         PREPARE adzp168t1_upd01_pre FROM g_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'PREPARE TMP:'
            LET g_errparam.popup = FALSE
            CALL cl_err()
         END IF
         #依照tree重新排序,避免刪除節點後順序跳號
         IF g_form_tree[g_form_idx].dzfr005 <> l_seq THEN
            LET g_form_tree[g_form_idx].dzfr005 = l_seq CLIPPED
            EXECUTE adzp168t1_upd01_pre USING g_form_tree[g_form_idx].dzfr005,g_form_tree[g_form_idx].dzfr007,g_form_tree[g_form_idx].dzfr003
         END IF

         #有子節點
         IF l_form_data[l_i].child_cnt > 0 THEN
            LET g_form_tree[g_form_idx].b_hasC = TRUE
            LET g_form_tree[g_form_idx].b_exp = TRUE

            #保持原本節點是否展開
            LET l_k = g_form_tree_t.getLength()
            FOR l_j = 1 TO l_k
               IF g_form_tree_t[l_j].dzfr003 = g_form_tree[g_form_idx].dzfr003 AND g_form_tree_t[l_j].b_hasC = g_form_tree[g_form_idx].b_hasC THEN
                  IF NOT cl_null(g_form_tree_t[l_j].b_exp) THEN
                     LET g_form_tree[g_form_idx].b_exp = g_form_tree_t[l_j].b_exp
                  END IF
               END IF
            END FOR

            CALL adzp168_form_tree_fill(g_form_tree[g_form_idx].b_id,g_form_tree[g_form_idx].b_level,g_form_tree[g_form_idx].dzfr003,p_isrename)
         ELSE
            LET g_form_tree[g_form_idx].b_hasC = FALSE
            LET g_form_tree[g_form_idx].b_exp = FALSE
         END IF
       END FOR

      #判斷遞迴結束
      LET l_ln02 = g_form_tree.getLength()
      IF l_ln01 = l_ln02 THEN   #data都放入array中
         CALL adzp168t2_fill_01()
         CALL adzp168_sr_table()
      END IF
   END IF
END FUNCTION

#+ Screen Record更新對應資料表
PRIVATE FUNCTION adzp168_sr_table()
   DEFINE l_form_sr       type_g_form_col
   DEFINE l_form_col      type_g_form_col
   DEFINE l_chk           BOOLEAN

   #Screen Record先清空資料表
   LET g_sql = "SELECT arridx,dzfr003,dzfr007 FROM adzp168t1 WHERE dzfr006 IN ('Table','Tree','ScrollGrid')"
   PREPARE adzp168_sr_table_pre FROM g_sql
   DECLARE adzp168_sr_table_cur CURSOR FOR adzp168_sr_table_pre
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'PREPARE sr_table:'
      LET g_errparam.popup = FALSE
      CALL cl_err()
   END IF
   FOREACH adzp168_sr_table_cur INTO l_form_sr.arridx,l_form_sr.dzfr003,l_form_sr.cont_tagname
      LET l_chk = FALSE
      #Screen Record有欄位,更新對應資料表
      LET g_sql = "SELECT cont_tag,cont_tagname,dzfr009 FROM adzp168t2 WHERE cont_tag IN ('Table','Tree','ScrollGrid') AND dzfr005 = 1 AND cont_tagname = ? GROUP BY cont_tag,cont_tagname,dzfr009"
      PREPARE adzp168_sr_table_col_pre FROM g_sql
      DECLARE adzp168_sr_table_col_cur CURSOR FOR adzp168_sr_table_col_pre
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'PREPARE sr_table_col:'
         LET g_errparam.popup = FALSE
         CALL cl_err()
      END IF

      FOREACH adzp168_sr_table_col_cur USING l_form_sr.cont_tagname INTO l_form_col.cont_tag,l_form_col.cont_tagname,l_form_col.dzfr009
         EXECUTE adzp168t1_upd02_pre USING l_form_col.dzfr009,l_form_col.dzfr003
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'sr_table tmp_upd02:'
            LET g_errparam.popup = FALSE
            CALL cl_err()
         ELSE
            LET l_chk = TRUE
            LET g_form_tree[l_form_sr.arridx].dzfr009 = l_form_col.dzfr009
         END IF
      END FOREACH

      #Screen Record沒有欄位,清空的資料表
      IF NOT l_chk THEN
         EXECUTE adzp168t1_upd02_pre USING "",l_form_sr.dzfr003
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'sr_table tmp_upd02:'
            LET g_errparam.popup = FALSE
            CALL cl_err()
         ELSE
            LET g_form_tree[l_form_sr.arridx].dzfr009 = ""
         END IF
      END IF
   END FOREACH
END FUNCTION

#+ 畫面樣版Tree資料底稿
PRIVATE FUNCTION adzp168_form_tree_draft_fill()
   DEFINE l_dzfr_d type_g_dzfr_d

   LET g_sql = "SELECT fz.*,dzeb004,dzeb022,dzekgrp,dzebl003, dzef008,dzer007 FROM",
               " (SELECT dzfz004,dzfz005,",
                       " dzfz006,dzfz007,dzfz008,dzfz009,dzfz010,",
                       " dzfz011,dzfz012,dzfz013",
                 " FROM dzfz_t",
                 " WHERE dzfz001 = ? AND dzfz002 = ? AND dzfz003 = ?",
                " ) fz",
                " LEFT JOIN",
                " (SELECT dzeb001,dzeb002,dzeb004,dzeb022 FROM dzeb_t",
                " ) eb",
                " ON fz.dzfz010 = eb.dzeb001 AND fz.dzfz011 = eb.dzeb002",

                " LEFT JOIN",
                " (SELECT dzebl001,dzebl003 FROM dzebl_t WHERE dzebl002 = ?)",
                " ON fz.dzfz011 = dzebl001",

                " LEFT JOIN",
                " (SELECT dzek001 AS dzekgrp,dzek002 FROM dzek_t WHERE dzek001 IN ('grpUIBelong','grpUIStateinfo'))",
                " ON dzek002 = eb.dzeb022",
                " LEFT JOIN dzef_t ON dzeb001 = dzef001 AND dzeb002 = dzef002",
                " LEFT JOIN dzer_t ON dzeb001 = dzer001 AND dzeb002 = dzer002 AND dzer003 = 1"

   PREPARE adzp168_dzfz_sel_01_pre FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'PREPARE form_tree_draft_fill:'
      LET g_errparam.popup = FALSE
      CALL cl_err()
   END IF

   DECLARE adzp168_dzfz_sel_01_cur01 CURSOR FOR adzp168_dzfz_sel_01_pre

   EXECUTE adzp168_form_tree_del_pre
   FOREACH adzp168_dzfz_sel_01_cur01 USING g_ver_ra,g_user,g_dzfq_m.dzfq004,g_lang INTO l_dzfr_d.*
      EXECUTE adzp168t1_ins USING l_dzfr_d.dzfr003,l_dzfr_d.dzfr004,l_dzfr_d.dzfr005,
                                         l_dzfr_d.dzfr006,l_dzfr_d.dzfr007,l_dzfr_d.dzfr008,l_dzfr_d.dzfr009,l_dzfr_d.dzfr010,
                                         l_dzfr_d.dzfr011,l_dzfr_d.dzfr012,
                                         l_dzfr_d.dzeb004,l_dzfr_d.dzeb022,l_dzfr_d.dzekgrp,l_dzfr_d.gzzd005,l_dzfr_d.dzef008,l_dzfr_d.dzer007
   END FOREACH

   CALL adzp168_form_tree_fill("0",0,"0",FALSE)
END FUNCTION


#+ 畫面樣版架構container和欄位關係暫存檔-填充資料
PRIVATE FUNCTION adzp168t2_fill_01()
   DEFINE l_root_idx      LIKE type_t.num5      #focus的Root節點index
   DEFINE l_form_col      type_g_form_col
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_find          BOOLEAN
   DEFINE l_dzfr003       LIKE dzfr_t.dzfr003
   DEFINE l_dzfr004       LIKE dzfr_t.dzfr004
   DEFINE l_seq           LIKE dzfr_t.dzfr005

   DEFINE ls_arridx       STRING
   DEFINE ls_row_seq      STRING
   DEFINE ls_dzfr003      STRING
   DEFINE ls_dzfr004      STRING
   DEFINE ls_dzfr005      STRING
   DEFINE ls_dzep009      STRING
   DEFINE ls_widget_hight STRING

   DELETE FROM adzp168t2

   SELECT COUNT(*) INTO l_cnt FROM adzp168t1 WHERE dzfr006 = 'Field'

   IF l_cnt > 0 THEN
      #EXECUTE adzp168t2_ins USING
      INSERT INTO adzp168t2(arridx,dzfr003,dzfr004,dzfr005,dzfr009,dzfr010,dzfr011,dzfr012,dzeb004,dzeb022,dzekgrp,gzzd005,dzef008,dzer007,prog_ins)
         SELECT arridx,dzfr003,dzfr004,dzfr005,dzfr009,dzfr010,dzfr011,dzfr012,dzeb004,dzeb022,dzekgrp,gzzd005,dzef008,dzer007,'adzp168'
               FROM adzp168t1
               WHERE dzfr006 IN ('Field','ghost')
            #LEFT JOIN
            #(SELECT dzeb001,dzeb002,dzep009 FROM dzeb_t)
            #ON dzfr009 = dzeb001 AND dzfr010 = dzeb002

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'INSERT TEMP SELECT:'
         LET g_errparam.popup = FALSE
         CALL cl_err()
      END IF

      SELECT COUNT(*) INTO l_cnt FROM adzp168t2
      #DISPLAY "adzp168t2 Field=",l_cnt

      LET g_sql = "SELECT * FROM adzp168t2 ORDER BY arridx"
      PREPARE adzp168t2_pre1 FROM g_sql
      DECLARE adzp168t2_cur1 CURSOR FOR adzp168t2_pre1
      FOREACH adzp168t2_cur1 INTO l_form_col.*
         CALL adzp168_form_tree_root_idx(l_form_col.arridx) RETURNING l_root_idx
         IF l_root_idx > 0 THEN
            #所屬區塊vb_master,vb_detail,vb_detailexp,vb_headerlock
            UPDATE adzp168t2
               SET rootarea = g_form_tree[l_root_idx].dzfr007
               WHERE dzfr003 =  l_form_col.dzfr003
         END IF
         #cont_tag      VARCHAR(20),   #4fd tag 類型: for container
         #cont_tagname  VARCHAR(40),   #4fd tag name: for container

         #row_seq       INTEGER,    #順序(同階層中的排序): for ScrollGrid row

         LET l_dzfr004 = l_form_col.dzfr004
         LET l_find = FALSE
         WHILE l_find = FALSE
            SELECT dzfr003,dzfr004,dzfr005,dzfr006,dzfr007 INTO l_dzfr003,l_dzfr004,l_seq,l_form_col.cont_tag,l_form_col.cont_tagname FROM adzp168t1 WHERE dzfr003 = l_dzfr004
            CASE
               WHEN l_form_col.cont_tag = "row"
                  UPDATE adzp168t2
                     SET row_seq = l_seq
                     WHERE dzfr003 =  l_form_col.dzfr003

               WHEN l_form_col.cont_tag = "Table" OR l_form_col.cont_tag = "ScrollGrid" OR l_form_col.cont_tag = "Tree"
                  LET l_find = TRUE
                  UPDATE adzp168t2
                     SET cont_tag = l_form_col.cont_tag,
                         cont_tagname = l_form_col.cont_tagname
                     WHERE dzfr003 =  l_form_col.dzfr003

               WHEN l_form_col.cont_tag = "Page" OR l_form_col.cont_tag = "Group" OR l_form_col.cont_tag = "Grid"
                  LET l_find = TRUE
                  UPDATE adzp168t2
                     SET cont_tag = l_form_col.cont_tag,
                         cont_tagname = l_form_col.cont_tagname
                     WHERE dzfr003 =  l_form_col.dzfr003

               WHEN l_dzfr003 = 1
                  LET l_find = TRUE
            END CASE
         END WHILE
      END FOREACH
   END IF

   #DISPLAY "-----------------"
   #FOREACH adzp168t2_cur1 INTO l_form_col.*
   #   LET ls_arridx  = l_form_col.arridx
   #   LET ls_row_seq = l_form_col.row_seq
   #   IF ls_row_seq IS NULL THEN
   #      LET ls_row_seq = 0
   #   END IF
   #   LET ls_dzfr003 = l_form_col.dzfr003
   #   LET ls_dzfr004 = l_form_col.dzfr004
   #   LET ls_dzfr005 = l_form_col.dzfr005
   #   LET ls_dzep009 = l_form_col.dzep009
   #   LET ls_widget_hight = l_form_col.widget_hight
   #
   #   DISPLAY
   #    "'",ls_arridx CLIPPED,"'"
   #    ,",'",l_form_col.rootarea CLIPPED,"'"
   #    ,",'",l_form_col.cont_tag CLIPPED,"'"
   #    ,",'",l_form_col.cont_tagname CLIPPED,"'"
   #    ,",'",ls_row_seq CLIPPED,"'"
   #
   #    ,",'",ls_dzfr003 CLIPPED,"'"
   #    ,",'",ls_dzfr004 CLIPPED,"'"
   #    ,",'",ls_dzfr005 CLIPPED,"'"
   #    ,",'",l_form_col.dzfr009 CLIPPED,"'"
   #    ,",'",l_form_col.dzfr010 CLIPPED,"'"
   #
   #    ,",'",l_form_col.dzfr011 CLIPPED,"'"
   #    ,",'",l_form_col.dzfr012 CLIPPED,"'"
   #    ,",'",l_form_col.dzeb004 CLIPPED,"'"
   #    ,",'",l_form_col.dzeb022 CLIPPED,"'"
   #    ,",'",l_form_col.dzekgrp CLIPPED,"'"
   #    ,",'",l_form_col.gzzd005 CLIPPED,"'"
   #    ,",'",l_form_col.dzef008 CLIPPED,"'"
   #    ,",'",l_form_col.dzer007 CLIPPED,"'"
   #
   #    ,",'",ls_dzep009 CLIPPED,"'"
   #    ,",'",ls_widget_hight CLIPPED,"'"
   #    ,",'",l_form_col.prog_ins CLIPPED,"'"
   #END FOREACH

   #DISPLAY "-----------------"
   #FOREACH adzp168t2_cur1 INTO l_form_col.*
   #   LET ls_arridx  = l_form_col.arridx
   #   LET ls_row_seq = l_form_col.row_seq
   #   IF ls_row_seq IS NULL THEN
   #      LET ls_row_seq = 0
   #   END IF
   #   LET ls_dzfr003 = l_form_col.dzfr003
   #   LET ls_dzfr004 = l_form_col.dzfr004
   #   LET ls_dzfr005 = l_form_col.dzfr005
   #   LET ls_dzep009 = l_form_col.dzep009
   #   LET ls_widget_hight = l_form_col.widget_hight
   #
   #   DISPLAY "INSERT INTO adzp168t2 VALUES (",
   #
   #   "'",ls_arridx CLIPPED,"'"
   #   ,",'",l_form_col.rootarea CLIPPED,"'"
   #   ,",'",l_form_col.cont_tag CLIPPED,"'"
   #   ,",'",l_form_col.cont_tagname CLIPPED,"'"
   #   ,",'",ls_row_seq CLIPPED,"'"
   #
   #   ,",'",ls_dzfr003 CLIPPED,"'"
   #   ,",'",ls_dzfr004 CLIPPED,"'"
   #   ,",'",ls_dzfr005 CLIPPED,"'"
   #   ,",'",l_form_col.dzfr009 CLIPPED,"'"
   #   ,",'",l_form_col.dzfr010 CLIPPED,"'"
   #
   #   ,",'",l_form_col.dzfr011 CLIPPED,"'"
   #   ,",'",l_form_col.dzfr012 CLIPPED,"'"
   #   ,",'",l_form_col.dzeb004 CLIPPED,"'"
   #   ,",'",l_form_col.dzeb022 CLIPPED,"'"
   #   ,",'",l_form_col.dzekgrp CLIPPED,"'"
   #   ,",'",l_form_col.gzzd005 CLIPPED,"'"
   #   ,",'",l_form_col.dzef008 CLIPPED,"'"
   #   ,",'",l_form_col.dzer007 CLIPPED,"'"
   #
   #   ,",'",ls_dzep009 CLIPPED,"'"
   #   ,",'",ls_widget_hight CLIPPED,"'"
   #   ,",'",l_form_col.prog_ins CLIPPED,"'"
   #
   #   ,")"
   #
   #
   #END FOREACH

END FUNCTION

#+ 設定Page顯示名稱
PRIVATE FUNCTION adzp168_page_name(p_isrename,p_gzzd001,p_gzzd002,p_gzzd003,p_gzzd004)
   DEFINE p_isrename  BOOLEAN                #TRUE:rename
   DEFINE p_gzzd001   LIKE gzzd_t.gzzd001
   DEFINE p_gzzd002   LIKE gzzd_t.gzzd002
   DEFINE p_gzzd003   LIKE gzzd_t.gzzd003
   DEFINE p_gzzd004   LIKE gzzd_t.gzzd004
   DEFINE l_gzzd005   LIKE gzzd_t.gzzd005
   DEFINE l_cnt       LIKE type_t.num5

   #設定Page顯示名稱
   #畫面多語言是否存在
   EXECUTE adzp168_formlang_cnt_pre USING p_gzzd001,p_gzzd002,p_gzzd003,p_gzzd004 INTO l_cnt
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'sel:'
      LET g_errparam.popup = FALSE
      CALL cl_err()
      RETURN NULL
   END IF

   IF l_cnt > 0 THEN
      EXECUTE adzp168_formlang_pre01 USING p_gzzd001,p_gzzd002,p_gzzd003,p_gzzd004 INTO l_gzzd005
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'sel:'
         LET g_errparam.popup = FALSE
         CALL cl_err()
         RETURN NULL
      END IF
   ELSE
      IF p_isrename THEN
         PROMPT p_gzzd003,":" FOR l_gzzd005
            ON IDLE 60
         END PROMPT
      END IF
   END IF

   RETURN l_gzzd005
END FUNCTION

#+ 設定欄位列表顏色屬性,已使用的欄位要變色
PRIVATE FUNCTION adzp168_col_setcolor()
   DEFINE l_i     LIKE type_t.num5
   DEFINE l_cnt   LIKE type_t.num5

   FOR l_i = 1 TO  g_column.getLength()
      #欄位列表顏色屬性,已使用的欄位要變色
      #g_column_att g_color_sel
      SELECT COUNT(*) INTO l_cnt FROM adzp168t1 WHERE dzfr009 = g_column[l_i].b_tableid AND dzfr010 = g_column[l_i].b_colid
      IF l_cnt > 0 THEN
         LET g_column_att[l_i].b_sel = g_color_sel
         LET g_column_att[l_i].b_pk = g_color_sel
         LET g_column_att[l_i].b_fk = g_color_sel
         LET g_column_att[l_i].b_colid = g_color_sel
         LET g_column_att[l_i].b_colname = g_color_sel
         LET g_column_att[l_i].b_fk_tb = g_color_sel
         LET g_column_att[l_i].b_dzeb022 = g_color_sel
         LET g_column_att[l_i].b_dzekgrp = g_color_sel
         LET g_column_att[l_i].b_ptableid = g_color_sel
         LET g_column_att[l_i].b_tableid = g_color_sel
      ELSE
         LET g_column_att[l_i].b_sel = NULL
         LET g_column_att[l_i].b_pk = NULL
         LET g_column_att[l_i].b_fk = NULL
         LET g_column_att[l_i].b_colid = NULL
         LET g_column_att[l_i].b_colname = NULL
         LET g_column_att[l_i].b_fk_tb = NULL
         LET g_column_att[l_i].b_dzeb022 = NULL
         LET g_column_att[l_i].b_dzekgrp = NULL
         LET g_column_att[l_i].b_ptableid = NULL
         LET g_column_att[l_i].b_tableid = NULL
      END IF
   END FOR
END FUNCTION


#+ 畫面設計 - 刪除欄位by table
PRIVATE FUNCTION adzp168_form_tree_del_col02(p_table)
   DEFINE p_table         LIKE dzfr_t.dzfr009     #畫面樣版架構-tree要刪除的index
   DEFINE l_i             LIKE type_t.num5

   IF NOT cl_null(p_table) THEN
      LET g_sql = "DELETE FROM adzp168t1 WHERE dzfr011 = 'Y' AND dzfr009 = ?"
      PREPARE adzp168_form_tree_del_col02_pre FROM g_sql
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'PREPARE TMP:'
         LET g_errparam.popup = FALSE
         CALL cl_err()
      END IF

      EXECUTE adzp168_form_tree_del_col02_pre USING p_table
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'del:'
         LET g_errparam.popup = FALSE
         CALL cl_err()
      END IF
   END IF
END FUNCTION

#+ 畫面設計 - 刪除欄位後檢查是否刪除容器
PRIVATE FUNCTION adzp168_form_tree_del_chkarea()
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_root_idx      LIKE type_t.num5      #focus的Root節點index
   DEFINE l_chk           BOOLEAN

   LET l_cnt = g_form_tree.getLength()

   IF l_cnt > 0 THEN
      FOR l_i = l_cnt TO 1 STEP -1
         LET l_chk = FALSE

         IF g_form_tree[l_i].b_hasC = FALSE AND g_form_tree[l_i].dzfr011 = "Y" THEN
            CALL adzp168_form_tree_root_idx(l_i) RETURNING l_root_idx

            CASE g_form_tree[l_root_idx].dzfr007
               #單頭
               WHEN "vb_master"
                  IF g_form_tree[l_i].dzfr006 = "Page"
                     OR g_form_tree[l_i].dzfr006 = "Group"
                     OR g_form_tree[l_i].dzfr006 = "Grid" THEN

                     LET l_chk = TRUE
                  ELSE
                     LET l_chk = FALSE
                  END IF

               WHEN "vb_detail"
                  IF g_form_tree[l_i].dzfr006 = "Tree"
                     OR g_form_tree[l_i].dzfr006 = "Table"
                     OR g_form_tree[l_i].dzfr006 = "ScrollGrid"
                     OR g_form_tree[l_i].dzfr006 = "row"
                     OR g_form_tree[l_i].dzfr006 = "Page"
                     OR g_form_tree[l_i].dzfr006 = "HBox"
                     OR g_form_tree[l_i].dzfr006 = "VBox" THEN

                     LET l_chk = TRUE
                  ELSE
                     LET l_chk = FALSE
                  END IF
            END CASE
         END IF

         IF l_chk THEN
            CALL adzp168_form_tree_del_area(l_i)
         END IF
      END FOR
   END IF
END FUNCTION

#+ 資料表設定 - 刪除自動冒出來的空資料
PRIVATE FUNCTION adzp168_tbtree_delnull()
   DEFINE l_n             LIKE type_t.num5
   DEFINE l_i             LIKE type_t.num5

   LET l_n = g_tbtree.getLength()
   IF l_n > 0 THEN
      FOR l_i=l_n TO 1 STEP -1
         IF cl_null(g_tbtree[l_i].b_id) THEN
            CALL g_tbtree.deleteElement(l_i)
         END IF
      END FOR
   END IF
END FUNCTION

#+ 外來鍵資料表index
PRIVATE FUNCTION adzp168_tbtree_pkfrom_idx(p_table)
   DEFINE p_table         LIKE dzeb_t.dzeb001   #table代號
   DEFINE l_tbtree_idx    LIKE type_t.num5      #資料表index
   DEFINE l_tbtree_f_idx  LIKE type_t.num5      #外來鍵資料表index
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_i             LIKE type_t.num5

   LET l_tbtree_idx = 0
   LET l_tbtree_f_idx = 0

   LET l_cnt = g_tbtree.getLength()
   #資料表index
   FOR l_i = 2 TO l_cnt
      IF p_table = g_tbtree[l_i].b_tableid THEN
         LET l_tbtree_idx = l_i
         EXIT FOR
      END IF
   END FOR
   #外來鍵資料表index
   IF l_tbtree_idx > 2 THEN
      #Level 1的資料表與主資料表關聯
      IF g_tbtree[l_tbtree_idx].b_level = 1 THEN
         LET l_tbtree_f_idx = 2
      ELSE
      #與上層資料表關聯
         FOR l_i = l_cnt TO 2 STEP -1
            IF g_tbtree[l_i].b_id = g_tbtree[l_tbtree_idx].b_pid THEN
               LET l_tbtree_f_idx = l_i
               EXIT FOR
            END IF
         END FOR
      END IF
   END IF

   RETURN l_tbtree_f_idx   #資料表父節點index
END FUNCTION


#+ 欄位資料
PRIVATE FUNCTION adzp168_col_fill(p_table)
   DEFINE p_table         LIKE dzeb_t.dzeb001   #table代號
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_j             LIKE type_t.num5
   DEFINE l_k             LIKE type_t.num5
   DEFINE l_dzed003       LIKE dzed_t.dzed003   #鍵值形式
   DEFINE l_dzed004       LIKE dzed_t.dzed004   #鍵值欄位
   DEFINE l_dzed005       LIKE dzed_t.dzed005   #外來鍵表格
   DEFINE l_str           STRING
   DEFINE l_tok           base.StringTokenizer
   DEFINE l_tmp           STRING
   DEFINE l_tbtree_f_idx  LIKE type_t.num5      #資料表父節點index

   CALL g_column.clear()
   CALL g_column_att.clear()

   IF p_table IS NOT NULL THEN
      LET l_i = 1
      FOREACH adzp168_col_fillcur USING p_table,p_table,p_table,p_table,p_table,g_lang INTO g_column[l_i].b_colid,g_column[l_i].b_colname,g_column[l_i].b_dzeb022,g_column[l_i].b_dzekgrp,g_column[l_i].b_dzef008,g_column[l_i].b_dzer007
         LET g_column[l_i].b_sel = "N"
         LET g_column[l_i].b_tableid = p_table CLIPPED

         #資料表代碼-父
         FOR l_j = 1 TO g_tbtree.getLength()
            IF p_table = g_tbtree[l_j].b_tableid THEN
               FOR l_k = 1 TO g_tbtree.getLength()
                  IF g_tbtree[l_j].b_pid = g_tbtree[l_k].b_id THEN
                     IF l_k = 1 THEN   #虛擬root Table
                        LET g_column[l_i].b_ptableid = g_tbtree[2].b_tableid
                     ELSE
                        LET g_column[l_i].b_ptableid = g_tbtree[l_k].b_tableid
                     END IF
                  END IF
               END FOR
            END IF
         END FOR

         LET l_i = l_i + 1
      END FOREACH
      CALL g_column.deleteElement(l_i)

      #PF,FK
      IF g_column.getLength() > 0 AND g_tbtree_idx > 0 THEN
         #IF g_dzfq_m.dzfq011 = "00" AND g_tbtree[g_tbtree_idx].b_level > 1 THEN   #單身狀態碼功能鍵區塊(sb:需要 /00: 不需要)
         #   FOR l_i = 1 TO g_column.getLength()
         #      IF g_column[l_i].b_dzeb022 = "cdfStatus" THEN
         #         CALL g_column.deleteElement(l_i)
         #      END IF
         #   END FOR
         #END IF

         #LET l_i = 1
         FOREACH adzp168_col_pkfkcur_1 USING p_table INTO l_dzed003,l_dzed004,l_dzed005
            LET l_str = l_dzed004
            CASE
               WHEN l_dzed003 = "P" OR l_dzed003 = "R"
                     LET l_tok = base.StringTokenizer.createExt(l_str CLIPPED,",","",TRUE)	#指定分隔符號
                     WHILE l_tok.hasMoreTokens()	#依序取得子字串
                        LET l_tmp = l_tok.nextToken()
                        LET l_tmp = l_tmp.trim()
                        FOR l_i = 1 TO g_column.getLength()
                           IF l_tmp = g_column[l_i].b_colid THEN
                              LET g_column[l_i].b_pk = "PK"
                              CALL adzp168_col_must_sel("N",l_i,FALSE) RETURNING g_column[l_i].b_sel
                              #單頭PK必選
                              #IF p_table = g_tbtree[1].b_tableid THEN
                              #   LET g_column[l_i].b_sel = "Y"
                              #END IF
                              EXIT FOR
                           END IF
                        END FOR
                     END WHILE
               WHEN l_dzed003 = "F"
                 CALL adzp168_tbtree_pkfrom_idx(p_table) RETURNING l_tbtree_f_idx   #外來鍵資料表index
                 IF l_tbtree_f_idx > 0 THEN
                    IF l_dzed005 = g_tbtree[l_tbtree_f_idx].b_tableid THEN  #此檢查避免有設多組Foreign Key時誤取錯組
                       LET l_tok = base.StringTokenizer.createExt(l_str CLIPPED,",","",TRUE)	#指定分隔符號
                       WHILE l_tok.hasMoreTokens()	#依序取得子字串
                          LET l_tmp = l_tok.nextToken()
                          LET l_tmp = l_tmp.trim()
                          FOR l_i = 1 TO g_column.getLength()
                             IF l_tmp = g_column[l_i].b_colid THEN
                                LET g_column[l_i].b_fk = "FK"
                                LET g_column[l_i].b_fk_tb = l_dzed005
                                EXIT FOR
                             END IF
                          END FOR
                       END WHILE
                    END IF
                 END IF
            END CASE
         END FOREACH
      END IF

      CALL adzp168_col_setcolor()
   END IF
END FUNCTION


#+ 強制勾選或不選
PRIVATE FUNCTION adzp168_col_must_sel(p_sel,p_col_idx,p_bytpl)
   DEFINE p_sel        LIKE type_t.chr1
   DEFINE p_col_idx    LIKE type_t.num5
   DEFINE p_bytpl      BOOLEAN            #是否依版型限制
   DEFINE l_sel        LIKE type_t.chr1   #NULL(不強制)/Y(單頭PK必選)/N(單身PK且為FK來自單頭欄位,不可選)

   IF NOT adzp168_notchk() THEN   #特殊版型不檢查
      #單頭PK必選
      IF g_column[p_col_idx].b_pk = "PK" THEN
         LET l_sel = "Y"
         IF p_bytpl THEN
            #假雙檔:同時有Master和Detail,兩區都需要有key,因此不能要求全選key,資料要送出前再檢查key是否都有選
            #cdfSite可拉到畫面,但非必選
            IF g_4fd_inf.l_jiashuangdang OR g_column[p_col_idx].b_dzeb022 = "cdfSite" THEN
               LET l_sel = p_sel
            END IF
         END IF
      END IF

      #不可選:排除FK來自主Table的欄位- 非單檔多欄
      IF g_tbtree_idx > 2
         AND g_column[p_col_idx].b_pk = "PK"
         AND g_column[p_col_idx].b_fk = "FK"
         AND g_column[p_col_idx].b_fk_tb = g_column[p_col_idx].b_ptableid THEN
            #IF g_tbtree[g_tbtree_idx].b_level > 1 THEN   #單身
               LET l_sel = "N"
            #END IF
      END IF
   END IF

   IF l_sel IS NULL THEN  #不強制,則不改變
      LET l_sel = p_sel
   END IF
   RETURN l_sel
END FUNCTION


#+ 暫存檔編號(流水號) - for新增資料
PRIVATE FUNCTION adzp168t1_new_dzfr003()
   DEFINE l_dzfr003   LIKE dzfr_t.dzfr003

   #編號(流水號)
   LET g_sql = "SELECT MAX(dzfr003) FROM adzp168t1"
   PREPARE adzp168t1_new_dzfr003_pre FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'PREPARE TMP:'
      LET g_errparam.popup = FALSE
      CALL cl_err()
   END IF

   EXECUTE adzp168t1_new_dzfr003_pre INTO l_dzfr003
   IF l_dzfr003 IS NULL THEN   #ORACLE直至8i才提供CASE WHEN
      LET l_dzfr003 = 1
   ELSE
      LET l_dzfr003 = l_dzfr003 + 1
   END IF

   RETURN l_dzfr003
END FUNCTION


#+ 暫存檔順序(同階層中的排序) - for新增子節點
PRIVATE FUNCTION adzp168t1_new_dzfr005(p_dzfr004)
   DEFINE p_dzfr004   LIKE dzfr_t.dzfr004   #父節點編號
   DEFINE l_dzfr005   LIKE dzfr_t.dzfr005   #順序(同階層中的排序)

   #順序(同階層中的排序)
   LET g_sql = "SELECT MAX(dzfr005) FROM adzp168t1 WHERE dzfr004 = ?"
   PREPARE adzp168t1_new_dzfr005_pre FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'PREPARE TMP:'
      LET g_errparam.popup = FALSE
      CALL cl_err()
   END IF

   EXECUTE adzp168t1_new_dzfr005_pre USING p_dzfr004 INTO l_dzfr005
   IF l_dzfr005 IS NULL THEN
      LET l_dzfr005 = 1
   ELSE
      LET l_dzfr005 = l_dzfr005 + 1
   END IF

   RETURN l_dzfr005
END FUNCTION

#+ 暫存檔4fd tag 類型 - for新增資料
PRIVATE FUNCTION adzp168t1_new_tag_m(p_dzfq007)
   DEFINE p_dzfq007   LIKE dzfq_t.dzfq007   #單頭框架(Folder/Group/Grid)
   DEFINE l_tag       LIKE dzfr_t.dzfr006   #4fd tag 類型

   LET l_tag = p_dzfq007 CLIPPED
   RETURN l_tag
END FUNCTION

#+ 暫存檔4fd tag 類型 - for新增單身切割框架
PRIVATE FUNCTION adzp168t1_new_tag_d1(p_dzfq009)
   DEFINE p_dzfq009   LIKE dzfq_t.dzfq009   #單身切割框架(sarray:單一/Folder/HBox/VBox/HFolder/VFolder)
   DEFINE l_tag       LIKE dzfr_t.dzfr006   #4fd tag 類型

   CASE
      WHEN p_dzfq009 = "sarray"
         LET l_tag = NULL
      WHEN p_dzfq009 = "HFolder"
         LET l_tag = "HBox"
      WHEN p_dzfq009 = "VFolder"
         LET l_tag = "VBox"
      OTHERWISE
         LET l_tag = p_dzfq009 CLIPPED
   END CASE

   #IF (NOT cl_null(p_dzfq009)) AND p_dzfq009 <> "sarray" THEN
   #   LET l_tag = p_dzfq009 CLIPPED
   #END IF

   RETURN l_tag
END FUNCTION

#+ 暫存檔4fd tag 類型 - for新增單身框架
PRIVATE FUNCTION adzp168t1_new_tag_d2(p_dzfq010)
   DEFINE p_dzfq010   LIKE dzfq_t.dzfq010   #單身框架(Table/ScrollGrid)
   DEFINE l_tag       LIKE dzfr_t.dzfr006   #4fd tag 類型

   LET l_tag = p_dzfq010 CLIPPED
   RETURN l_tag
END FUNCTION


#+ 暫存檔4fd tag name - for新增資料
PRIVATE FUNCTION adzp168t1_new_tagname(p_tag)
   DEFINE p_tag           LIKE dzfr_t.dzfr006   #4fd tag 類型
   DEFINE l_tagname       LIKE dzfr_t.dzfr007   #4fd tag name
   DEFINE l_tagname_pre   LIKE dzfr_t.dzfr012   #4fd tag name前置名稱(s_detail/folder_/page_/page_info_/group_/Grid/HBox/VBox)
   DEFINE l_seq           LIKE dzfr_t.dzfr008   #編號
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_str           STRING
   DEFINE l_dzfr DYNAMIC ARRAY OF RECORD
            dzfr007   LIKE dzfr_t.dzfr007,  #4fd tag name
            dzfr008   LIKE dzfr_t.dzfr008,  #4fd tag name 編號
            dzfr012   LIKE dzfr_t.dzfr012   #4fd tag name前置名稱
            END RECORD


   LET p_tag = p_tag CLIPPED

   CASE
      WHEN p_tag = "Grid" OR p_tag = "HBox" OR p_tag = "VBox"
         LET l_tagname_pre = p_tag
      WHEN p_tag = "Table" OR p_tag = "ScrollGrid" OR p_tag = "Tree"
         LET l_tagname_pre = "s_detail"
      OTHERWISE
         LET l_str = p_tag
         LET l_tagname_pre = l_str.toLowerCase() CLIPPED,"_"
   END CASE

   #此4fd tag name的數量
   LET g_sql = "SELECT COUNT(dzfr012) FROM adzp168t1 WHERE dzfr012 = ? AND dzfr008 > 0"
   PREPARE adzp168t1_new_tagname_cnt_pre FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'PREPARE TMP COUNT:'
      LET g_errparam.popup = FALSE
      CALL cl_err()
   END IF
   EXECUTE adzp168t1_new_tagname_cnt_pre USING l_tagname_pre INTO l_cnt

   LET l_seq = 0
   IF l_cnt = 0 THEN
      LET l_seq = 1
   ELSE
      LET g_sql = "SELECT dzfr007,dzfr008,dzfr012 FROM adzp168t1 WHERE dzfr012 = ? AND dzfr008 > 0 ORDER BY dzfr008"
      PREPARE adzp168t1_new_tagname_pre FROM g_sql
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'PREPARE TMP:'
         LET g_errparam.popup = FALSE
         CALL cl_err()
      END IF
      DECLARE adzp168t1_new_tagnamecur CURSOR FOR adzp168t1_new_tagname_pre

      LET l_i = 1
      FOREACH adzp168t1_new_tagnamecur USING l_tagname_pre INTO l_dzfr[l_i].dzfr007,l_dzfr[l_i].dzfr008
         #若中間有跳號,則取用這個沒用到的號碼
         IF l_dzfr[l_i].dzfr008 <> l_i THEN
            LET l_seq = l_i
            EXIT FOREACH
         END IF
         LET l_i = l_i + 1
      END FOREACH
   END IF

   IF l_seq = 0 THEN
      LET l_seq = l_cnt + 1
   END IF

   LET l_str = l_seq
   LET l_tagname = l_tagname_pre CLIPPED,l_str CLIPPED

   RETURN l_tagname,l_tagname_pre,l_seq
END FUNCTION


#+ 畫面設計 - 查tree的Root節點index
FUNCTION adzp168_form_tree_root_idx(p_idx)
   DEFINE p_idx      LIKE type_t.num5   #g_ftree_idx
   DEFINE l_idx      LIKE type_t.num5
   DEFINE l_chk      BOOLEAN
   DEFINE l_msg      STRING
   DEFINE l_cnt      LIKE type_t.num5
   DEFINE l_i        LIKE type_t.num5
   DEFINE l_str      STRING
   DEFINE l_tok       base.StringTokenizer
   DEFINE l_tmp       STRING

   LET l_idx = 0
   LET l_cnt = g_form_tree.getLength()
   IF p_idx > 0 THEN
      LET l_str = g_form_tree[p_idx].b_id  #focus
      LET l_tok = base.StringTokenizer.createExt(l_str CLIPPED,".","",TRUE)	#指定分隔符號
      WHILE l_tok.hasMoreTokens()	#依序取得子字串
         LET l_tmp = l_tok.nextToken()
         LET l_tmp = l_tmp.trim()
         EXIT WHILE #取第一個來判斷root的id
      END WHILE

      FOR l_i = 1 TO l_cnt
         IF g_form_tree[l_i].b_id = l_tmp THEN
            LET l_idx = l_i
            EXIT FOR
         END IF
      END FOR
   END IF

   RETURN l_i
END FUNCTION


#+ 挑選欄位 - 共用欄位全選/全不選
PRIVATE FUNCTION adzp168_selectinfo(p_class,p_sel)
   DEFINE p_class   STRING                 #selectgeneral:挑選一般欄位 /selectinfo:挑選共用欄位
   DEFINE p_sel     LIKE type_t.chr1       #挑選
   DEFINE l_i       LIKE type_t.num5

   CASE p_class
      WHEN "selectgeneral"
         IF g_column.getLength() > 0 THEN
            FOR l_i = 1 TO g_column.getLength()
               IF cl_null(g_column[l_i].b_dzekgrp) OR (g_column[l_i].b_dzekgrp <> "grpUIBelong" AND g_column[l_i].b_dzekgrp <> "grpUIStateinfo") THEN
                  LET g_column[l_i].b_sel = p_sel
               END IF
               #強制勾選或不選
               CALL adzp168_col_must_sel(g_column[l_i].b_sel,l_i,TRUE) RETURNING g_column[l_i].b_sel
            END FOR
         END IF

      WHEN "selectinfo"
         IF g_column.getLength() > 0 THEN
            FOR l_i = 1 TO g_column.getLength()
               IF g_column[l_i].b_dzekgrp = "grpUIBelong" OR g_column[l_i].b_dzekgrp = "grpUIStateinfo" THEN
                  LET g_column[l_i].b_sel = p_sel
               END IF
               #強制勾選或不選
               CALL adzp168_col_must_sel(g_column[l_i].b_sel,l_i,TRUE) RETURNING g_column[l_i].b_sel
            END FOR
         END IF
   END CASE
END FUNCTION

#+ 畫面設計 - 加入欄位
PRIVATE FUNCTION adzp168_form_tree_add_col(p_source,p_from_idx,p_ftree_idx)
   DEFINE p_source        STRING                #來源  column:從畫面勾選欄位加入 / ftree:從畫面結構拖曳加入
   DEFINE p_from_idx      LIKE type_t.num10
   DEFINE p_ftree_idx     LIKE type_t.num10
   DEFINE l_tbtree_idx    LIKE type_t.num10
   DEFINE l_column        DYNAMIC ARRAY OF type_g_column       #欄位列表
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_add_cnt       LIKE type_t.num5      #新增欄位數量
   DEFINE l_add_cnt2      LIKE type_t.num5
   DEFINE l_stus_dzfr003  LIKE dzfr_t.dzfr003   #編號
   DEFINE l_stus_seq      LIKE type_t.num5      #順序
   DEFINE l_chk           BOOLEAN               #是否可以加入欄位
   DEFINE l_pk            LIKE dzeb_t.dzeb004
   DEFINE l_dzfr003       LIKE dzfr_t.dzfr003   #編號(流水號)
   DEFINE l_dzfr004       LIKE dzfr_t.dzfr004   #父節點編號
   DEFINE l_dzfr005       LIKE dzfr_t.dzfr005   #順序(同階層中的排序)
   DEFINE l_dzfr006       LIKE dzfr_t.dzfr006   #4fd tag 類型
   DEFINE l_dzfr007       LIKE dzfr_t.dzfr007   #4fd tag name
   DEFINE l_dzfr008       LIKE dzfr_t.dzfr008   #4fd tag name 編號
   DEFINE l_dzfr009       LIKE dzfr_t.dzfr009   #資料表代碼
   DEFINE l_dzfr010       LIKE dzfr_t.dzfr010   #欄位代碼
   DEFINE l_dzfr012       LIKE dzfr_t.dzfr012   #4fd tag name前置名稱(s_detail/folder_/page_/page_info_/group_/Grid/HBox/VBox)
   DEFINE l_dzeb022       LIKE dzeb_t.dzeb022   #屬於哪一種欄位定義代碼
   DEFINE l_dzekgrp       LIKE dzek_t.dzek001   #欄位定義代碼群組grpUIBelong/grpUIStateinfo
   DEFINE l_gzzd005       LIKE gzzd_t.gzzd005
   DEFINE l_root_idx      LIKE type_t.num5      #focus的Root節點index
   DEFINE l_sr_idx        LIKE type_t.num5      #欄位所屬ScreenRecord的index
   DEFINE l_dzeb002       LIKE dzeb_t.dzeb002   #欄位代號
   DEFINE l_dzeb004       LIKE dzeb_t.dzeb004   #primary key
   DEFINE l_dzfr_d_t      type_g_dzfr_d
   DEFINE l_msg           STRING

   LET l_chk = FALSE
   LET l_sr_idx = 0
   CALL l_column.clear()

   CASE p_source
      WHEN "column"   #從畫面勾選欄位加入
         LET l_column.* = g_column.*
         LET l_tbtree_idx = g_tbtree_idx

      WHEN "ftree"    #從畫面結構拖曳加入
         LET l_column[1].b_sel      = "Y"                              #挑選
         IF g_form_tree[p_from_idx].dzeb004 = "Y" THEN   #Primary Key
            LET l_column[1].b_pk = "PK"
         END IF
         LET l_column[1].b_fk       = ""                               #Foreign Key
         LET l_column[1].b_colid    = g_form_tree[p_from_idx].dzfr010  #節點名稱: 欄位代碼
         LET l_column[1].b_colname  = g_form_tree[p_from_idx].gzzd005  #欄位名稱
         LET l_column[1].b_fk_tb    = ""                               #外來鍵表格
         LET l_column[1].b_dzeb022  = g_form_tree[p_from_idx].dzeb022  #屬於哪一種欄位定義代碼(dzek001)
         LET l_column[1].b_dzekgrp  = g_form_tree[p_from_idx].dzekgrp  #欄位定義代碼群組grpUIBelong/grpUIStateinfo
         LET l_column[1].b_ptableid = ""                               #資料表代碼-父
         LET l_column[1].b_tableid  = g_form_tree[p_from_idx].dzfr009  #資料表代碼
         LET l_column[1].b_dzef008  = g_form_tree[p_from_idx].dzef008  #參考欄位
         LET l_column[1].b_dzer007  = g_form_tree[p_from_idx].dzer007  #多語言欄位

         FOR l_i = 1 TO g_tbtree.getLength()
            IF g_tbtree[l_i].b_tableid = l_column[1].b_tableid THEN
               LET l_tbtree_idx = l_i
            END IF
         END FOR
   END CASE

   IF l_tbtree_idx > 0 AND l_column.getLength() > 0
      AND p_ftree_idx > 0 AND p_ftree_idx <= g_form_tree.getLength() THEN

      CALL adzp168_form_tree_root_idx(p_ftree_idx) RETURNING l_root_idx

      #檢查欄位可以放的區塊
      CASE
         #單頭
         WHEN (g_form_tree[l_root_idx].dzfr007 = "vb_master" AND
                 (g_form_tree[p_ftree_idx].dzfr006 = "Page"
                    OR g_form_tree[p_ftree_idx].dzfr006 = "Group"
                    OR g_form_tree[p_ftree_idx].dzfr006 = "Grid"
                    OR g_form_tree[p_ftree_idx].dzfr006 = "Field"))
               OR
               (g_form_tree[l_root_idx].dzfr007 = "vb_headerlock" AND g_form_tree[p_ftree_idx].dzfr006 = "Group")

               #只能放單頭Table欄位
               IF adzp168_notchk() THEN
                  LET l_chk = TRUE
               ELSE
                  IF g_tbtree[l_tbtree_idx].b_level <> 1 THEN
                     LET l_chk = FALSE
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code =  "adz-00053"
                     LET g_errparam.extend = NULL
                     LET g_errparam.popup = TRUE
                     LET g_errparam.replace[1] =  g_tbtree[l_tbtree_idx].b_tableid
                     LET g_errparam.replace[2] =  g_form_tree[p_ftree_idx].b_show
                     CALL cl_err()
                  ELSE
                     LET l_chk = TRUE
                  END IF
               END IF

         #單身
         WHEN (g_form_tree[l_root_idx].dzfr007 = "vb_detailexp" AND
                  (g_form_tree[p_ftree_idx].dzfr006 = "Page"
                  OR g_form_tree[p_ftree_idx].dzfr006 = "Field"))
              OR(g_form_tree[l_root_idx].dzfr007 = "vb_detail" AND
                  (g_form_tree[p_ftree_idx].dzfr006 = "Tree"
                  OR g_form_tree[p_ftree_idx].dzfr006 = "Table"
                  #OR g_form_tree[p_ftree_idx].dzfr006 = "ScrollGrid"
                  OR g_form_tree[p_ftree_idx].dzfr006 = "row"
                  OR g_form_tree[p_ftree_idx].dzfr006 = "Field" ))

               #只能放單身Table欄位:雙擋,vb_detailexp; 不限制:假雙擋
               IF (NOT adzp168_notchk()) AND
                  (
                     (g_4fd_inf.l_jiashuangdang = FALSE AND g_4fd_inf.form_vbm_idx AND g_tbtree[l_tbtree_idx].b_level = 1) OR
                     (g_4fd_inf.l_jiashuangdang = TRUE AND l_tbtree_idx <> 2) OR
                     (g_form_tree[l_root_idx].dzfr007 = "vb_detailexp" AND g_tbtree[l_tbtree_idx].b_level = 1)
                  ) THEN

                  LET l_chk = FALSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  "adz-00053"
                  LET g_errparam.extend = NULL
                  LET g_errparam.popup = TRUE
                  LET g_errparam.replace[1] =  g_tbtree[l_tbtree_idx].b_tableid
                  LET g_errparam.replace[2] =  g_form_tree[p_ftree_idx].b_show
                  CALL cl_err()
               ELSE
                  LET l_chk = TRUE
                  IF g_form_tree[p_ftree_idx].dzfr006 = "Field" THEN
                     FOR l_i = 1 TO g_form_tree.getLength()
                        IF g_form_tree[l_i].b_id = g_form_tree[p_ftree_idx].b_pid THEN
                           LET l_sr_idx = l_i
                        END IF
                     END FOR
                  ELSE
                     LET l_sr_idx = p_ftree_idx
                  END IF
               END IF


        OTHERWISE   #瀏覽表之類的
            IF g_form_tree[p_ftree_idx].dzfr006 = "Tree"
               OR g_form_tree[p_ftree_idx].dzfr006 = "Table"
               OR g_form_tree[p_ftree_idx].dzfr006 = "Field" THEN

               #s_browse只能放單頭主Table欄位
               IF (adzp168_notchk()) OR
                   (g_tbtree[l_tbtree_idx].b_id = "0.1" OR (g_form_tree[p_ftree_idx].dzfr006 = "Tree"))   #因Tree的id和pid不同Table而開放
                  THEN

                  LET l_chk = TRUE
                  IF g_form_tree[p_ftree_idx].dzfr006 = "Field" THEN
                     FOR l_i = 1 TO g_form_tree.getLength()
                        IF g_form_tree[l_i].b_id = g_form_tree[p_ftree_idx].b_pid THEN
                           LET l_sr_idx = l_i
                        END IF
                     END FOR
                  ELSE
                     LET l_sr_idx = p_ftree_idx
                  END IF
               ELSE
                  LET l_chk = FALSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  "adz-00053"
                  LET g_errparam.extend = NULL
                  LET g_errparam.popup = TRUE
                  LET g_errparam.replace[1] =  g_tbtree[l_tbtree_idx].b_tableid
                  LET g_errparam.replace[2] =  g_form_tree[p_ftree_idx].b_show
                  CALL cl_err()
               END IF
            END IF
      END CASE


      #不可加入的欄位,取消勾選
      IF l_chk AND (NOT adzp168_notchk()) THEN
         CASE
            #假雙檔的單頭不可放共用欄位和狀態碼
            WHEN g_4fd_inf.l_jiashuangdang = TRUE AND g_form_tree[l_root_idx].dzfr007 = "vb_master"
               LET l_msg = NULL
               FOR l_i = 1 TO l_column.getLength()
                  IF l_column[l_i].b_sel = "Y" THEN
                     CASE
                        #共用欄位
                        WHEN NOT cl_null(l_column[l_i].b_dzekgrp)
                           IF l_column[l_i].b_dzekgrp = "grpUIBelong" OR l_column[l_i].b_dzekgrp = "grpUIStateinfo" THEN
                              LET l_column[l_i].b_sel = "N"
                           END IF
                        #狀態碼
                        WHEN NOT cl_null(l_column[l_i].b_dzeb022)
                           IF l_column[l_i].b_dzeb022 = "cdfStatus" THEN
                              LET l_column[l_i].b_sel = "N"
                           END IF
                     END CASE

                     IF l_column[l_i].b_sel = "N" THEN
                        IF cl_null(l_msg) THEN
                           LET l_msg = l_column[l_i].b_colid CLIPPED
                        ELSE
                           LET l_msg = l_msg CLIPPED,",",l_column[l_i].b_colid CLIPPED
                        END IF
                     END IF
                  END IF
               END FOR

               IF NOT cl_null(l_msg) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  "adz-00069"
                  LET g_errparam.extend = NULL
                  LET g_errparam.popup = TRUE
                  LET g_errparam.replace[1] =  l_msg
                  CALL cl_err()
               END IF

            #狀態碼不開放讓使用者加入"查詢方案",因為程式會自動產生
            WHEN g_dzfq_m.cbo_setbrowse = "sc" AND g_form_tree[l_root_idx].dzfr007 = "s_browse"
               LET l_msg = NULL
               FOR l_i = 1 TO l_column.getLength()
                  IF l_column[l_i].b_sel = "Y" THEN
                     CASE
                        #狀態碼
                        WHEN NOT cl_null(l_column[l_i].b_dzeb022)
                           IF l_column[l_i].b_dzeb022 = "cdfStatus" THEN
                              LET l_column[l_i].b_sel = "N"
                           END IF
                     END CASE

                     IF l_column[l_i].b_sel = "N" THEN
                        IF cl_null(l_msg) THEN
                           LET l_msg = l_column[l_i].b_colid CLIPPED
                        ELSE
                           LET l_msg = l_msg CLIPPED,",",l_column[l_i].b_colid CLIPPED
                        END IF
                     END IF
                  END IF
               END FOR

               IF NOT cl_null(l_msg) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  "adz-00084"
                  LET g_errparam.extend = NULL
                  LET g_errparam.popup = TRUE
                  LET g_errparam.replace[1] =  l_msg
                  CALL cl_err()
               END IF

         END CASE
      END IF

      IF l_chk THEN
         #在欄位後面插入新欄位
         IF g_form_tree[p_ftree_idx].dzfr006 = "Field" THEN
            #檢查可以新增的欄位數量
            LET l_add_cnt = 0
            FOR l_i = 1 TO l_column.getLength()
               IF l_column[l_i].b_sel = "Y" AND adzp168_form_tree_add_col_page_info_chk(p_ftree_idx,l_i,l_column) THEN
                  LET l_add_cnt = l_add_cnt + 1
               END IF
            END FOR

            UPDATE adzp168t1 SET dzfr005 = dzfr005 + l_add_cnt
               WHERE dzfr004 = g_form_tree[p_ftree_idx].dzfr004 AND dzfr005 > g_form_tree[p_ftree_idx].dzfr005
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  SQLCA.sqlcode
               LET g_errparam.extend = "upd:"
               LET g_errparam.popup = TRUE
               CALL cl_err()
            END IF
         END IF

         LET l_dzfr005 = 0
         FOR l_i = 1 TO l_column.getLength()
            IF l_column[l_i].b_sel = "Y" AND adzp168_form_tree_add_col_page_info_chk(p_ftree_idx,l_i,l_column) THEN
               LET l_dzfr010 = l_column[l_i].b_colid CLIPPED

               #vb_detailexp:1.不可有PK,因為都放在vb_detail; 2.不可與單身欄位重複
               IF g_form_tree[l_root_idx].dzfr007 = "vb_detailexp" AND l_column[l_i].b_pk = "PK" THEN
                  LET l_chk = FALSE
               ELSE
                  LET l_chk = TRUE
               END IF

               IF l_chk THEN
                  CALL adzp168_form_tree_add_col_exist(p_ftree_idx,l_dzfr010,l_column[l_i].b_pk) RETURNING l_chk
               END IF

               IF l_chk THEN
                   CALL adzp168t1_new_dzfr003() RETURNING l_dzfr003   #暫存檔編號(流水號) - for新增資料

                   IF g_form_tree[p_ftree_idx].dzfr006 = "Field" THEN
                      IF l_dzfr005 = 0 THEN
                         LET l_dzfr005 = g_form_tree[p_ftree_idx].dzfr005 + 1   #排在此欄位後面
                      ELSE
                         LET l_dzfr005 = l_dzfr005 + 1
                      END IF
                   ELSE
                      CALL adzp168t1_new_dzfr005(g_form_tree[p_ftree_idx].dzfr003) RETURNING l_dzfr005   #暫存檔順序(同階層中的排序) - for新增資料
                   END IF

                   LET l_dzfr006 = "Field"  #4fd tag 類型 - for新增資料
                   LET l_dzfr007 = ""
                   LET l_dzfr008 = ""
                   LET l_dzfr009 = l_column[l_i].b_tableid CLIPPED   #g_tbtree[l_tbtree_idx].b_tableid CLIPPED

                   #SELECT dzeb022 INTO l_dzeb022 FROM dzeb_t WHERE dzeb002 = l_dzfr010
                   LET l_gzzd005 = l_column[l_i].b_colname
                   LET l_dzeb022 = l_column[l_i].b_dzeb022
                   LET l_dzekgrp = l_column[l_i].b_dzekgrp
                   #CALL adzp168t1_new_tagname(l_dzfr006) RETURNING l_dzfr007,l_dzfr008   #4fd tag name,4fd tag name 編號 - for新增資料
                   #CALL adzp168_page_name(FALSE,g_dzfq_m.dzfq004,g_lang,l_dzfr007,g_cust) RETURNING l_gzzd005

                   IF l_chk AND l_sr_idx > 0 THEN   #欄位屬於Screen Record
                      IF (NOT adzp168_notchk()) AND
                         (l_dzfr009 <> g_form_tree[l_sr_idx].dzfr009 AND (g_form_tree[p_ftree_idx].dzfr006 <> "Tree"))   #因Tree的id和pid不同Table而開放
                        THEN

                         INITIALIZE g_errparam TO NULL
                         LET g_errparam.code =  "adz-00053"
                         LET g_errparam.extend = NULL
                         LET g_errparam.popup = TRUE
                         LET g_errparam.replace[1] =  l_dzfr010
                         LET g_errparam.replace[2] =  g_form_tree[l_sr_idx].b_show
                         CALL cl_err()
                         LET l_chk = FALSE
                         #ROLLBACK WORK
                         EXIT FOR
                      END IF
                   END IF
               END IF

               IF l_chk THEN
                  IF g_form_tree[p_ftree_idx].dzfr006 = "Field" THEN
                     LET l_dzfr004 = g_form_tree[p_ftree_idx].dzfr004
                  ELSE
                     LET l_dzfr004 = g_form_tree[p_ftree_idx].dzfr003
                  END IF

               #   #狀態碼，單身預設位置第一次拉入狀態碼欄位時擺放於第一個欄位，但後續可自行更動位置。
               #   IF l_column[l_i].b_dzeb022 = "cdfStatus" AND g_form_tree[l_root_idx].dzfr007 = "vb_detail" THEN
               #      UPDATE adzp168t1 SET dzfr005 = dzfr005 + 1
               #         WHERE dzfr004 = l_dzfr004
               #      LET l_dzfr005 = 1
               #   END IF
               END IF

               IF l_chk THEN
                  IF l_column[l_i].b_pk = "PK" THEN
                     LET l_dzeb004 = "Y"
                  ELSE
                     LET l_dzeb004 = "N"
                  END IF

                  EXECUTE adzp168t1_ins USING l_dzfr003,l_dzfr004,l_dzfr005,l_dzfr006,l_dzfr007,l_dzfr008,l_dzfr009,l_dzfr010,'Y',l_dzfr012,l_dzeb004,l_dzeb022,l_dzekgrp,l_gzzd005,l_column[l_i].b_dzef008,l_column[l_i].b_dzer007
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = 'ins TEMP:'
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
                     #ROLLBACK WORK
                     #LET l_chk = FALSE
                     EXIT FOR
                  END IF
                  LET l_add_cnt2 = l_add_cnt2 + 1
               END IF
            END IF
         END FOR

         IF l_add_cnt2 > 0 THEN   #有加入欄位
            IF NOT adzp168_notchk() THEN
               #單頭狀態碼放在最後,2015/04/09 單身狀態碼放在最後
               CASE
                  WHEN g_form_tree[l_root_idx].dzfr007 = "vb_master" OR
                       g_form_tree[l_root_idx].dzfr007 = "vb_detail"
                     LET g_sql = "SELECT dzfr003,dzfr005 FROM adzp168t1",
                                 " WHERE dzfr004 = ? AND dzeb022 = ?"
                     PREPARE adzp168_form_tree_add_col_stus_seq FROM g_sql
                     IF SQLCA.sqlcode THEN
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code = SQLCA.sqlcode
                        LET g_errparam.extend = 'PREPARE stus_seq:'
                        LET g_errparam.popup = FALSE
                        CALL cl_err()
                     END IF

                     LET l_stus_dzfr003 = NULL
                     LET l_stus_seq = 0

                     EXECUTE adzp168_form_tree_add_col_stus_seq USING l_dzfr004,'cdfStatus' INTO l_stus_dzfr003,l_stus_seq

                     IF l_stus_seq > 0 THEN
                        UPDATE adzp168t1 SET dzfr005 = dzfr005 - 1
                           WHERE dzfr003 = (
                              SELECT dzfr003 FROM adzp168t1
                              WHERE dzfr004 = l_dzfr004 AND dzfr005 > l_stus_seq)

                        CALL adzp168t1_new_dzfr005(l_dzfr004) RETURNING l_dzfr005
                        UPDATE adzp168t1 SET dzfr005 = l_dzfr005
                           WHERE dzfr003 = l_stus_dzfr003
                     END IF
               END CASE
            END IF

            IF p_source <> "ftree" THEN
               CALL adzp168_form_tree_fill("0",0,"0",FALSE)   #重整tree
            END IF
         END IF  #有加入欄位

      END IF
   END IF

   RETURN l_add_cnt2
END FUNCTION


#+ 畫面設計 - 加入空白欄位 for ScrollGrid
PRIVATE FUNCTION adzp168_form_tree_add_col_ghost()
   DEFINE l_dzfr003       LIKE dzfr_t.dzfr003   #編號(流水號)
   DEFINE l_dzfr004       LIKE dzfr_t.dzfr004   #父節點編號
   DEFINE l_dzfr005       LIKE dzfr_t.dzfr005   #順序(同階層中的排序)
   DEFINE l_dzfr006       LIKE dzfr_t.dzfr006   #4fd tag 類型
   DEFINE l_dzfr007       LIKE dzfr_t.dzfr007   #4fd tag name
   DEFINE l_dzfr008       LIKE dzfr_t.dzfr008   #4fd tag name 編號
   DEFINE l_dzfr012       LIKE dzfr_t.dzfr012   #4fd tag name前置名稱(s_detail/folder_/page_/page_info_/group_/Grid/HBox/VBox)

   IF g_tbtree_idx > 0 THEN
      IF g_form_tree[g_ftree_idx].dzfr006 = "row" THEN
         LET l_dzfr004 = g_form_tree[g_ftree_idx].dzfr003

         CALL adzp168t1_new_dzfr003() RETURNING l_dzfr003   #暫存檔編號(流水號) - for新增資料
         CALL adzp168t1_new_dzfr005(l_dzfr004) RETURNING l_dzfr005   #暫存檔順序(同階層中的排序) - for新增資料
         LET l_dzfr006 = "ghost"  #4fd tag 類型
         CALL adzp168t1_new_tagname(l_dzfr006) RETURNING l_dzfr007,l_dzfr012,l_dzfr008   #4fd tag name,4fd tag name前置名稱,4fd tag name 編號 - for新增資料


         EXECUTE adzp168t1_ins USING l_dzfr003,l_dzfr004,l_dzfr005,l_dzfr006,l_dzfr007,l_dzfr008,'','','Y',l_dzfr012,'N','','','','',''
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'ins TEMP:'
            LET g_errparam.popup = FALSE
            CALL cl_err()
         ELSE
            CALL adzp168_form_tree_fill("0",0,"0",FALSE)   #重整tree
         END IF
      END IF
   END IF
END FUNCTION

#+ 自動新增共用欄位-步驟01
PRIVATE FUNCTION adzp168_common_col_add_01(p_tbtree_idx)
   DEFINE p_tbtree_idx    LIKE type_t.num5
   DEFINE l_area_idx      LIKE type_t.num5      #區塊index
   DEFINE l_cnt           LIKE type_t.num5

   LET l_area_idx = 0
   IF p_tbtree_idx > 1 AND (NOT adzp168_notchk()) THEN
      IF g_tbtree[p_tbtree_idx].b_level = 1 THEN
         CASE
            WHEN g_4fd_inf.form_vbm_idx > 0
               IF g_4fd_inf.l_jiashuangdang THEN  #假雙檔共用欄位放單身
                  IF g_4fd_inf.form_vbd_idx > 0 THEN
                     CALL adzp168_common_col_add_02(p_tbtree_idx,g_4fd_inf.form_vbd_idx)
                  END IF
               ELSE
                  CALL adzp168_common_col_add_02(p_tbtree_idx,g_4fd_inf.form_vbm_idx)
               END IF
            WHEN g_4fd_inf.form_vbd_idx > 0   #F002
               CALL adzp168_common_col_add_02(p_tbtree_idx,g_4fd_inf.form_vbd_idx)
         END CASE
      ELSE
         #單頭
         #加入單身Table時,由假雙檔變不是假雙檔,再把先前主Table放在單身page_info刪除,改加到單頭
         EXECUTE adzp168_info_col_com USING g_tbtree[2].b_tableid INTO l_cnt   #Table中的共用欄位數
         IF g_4fd_inf.form_vbm_idx > 0 AND l_cnt > 0 THEN    #主Table有共用欄位
            #DELETE FROM adzp168t1 WHERE dzekgrp IN ('grpUIBelong','grpUIStateinfo') AND dzfr009 = g_tbtree[2].b_tableid

            #單頭是否已有此Table的共用欄位,若存在則不需自動加入
            SELECT COUNT(dzfr010) INTO l_cnt FROM adzp168t2
               WHERE dzekgrp IN ('grpUIBelong','grpUIStateinfo')
                 AND rootarea = 'vb_master' AND dzfr009 = g_tbtree[2].b_tableid
            IF l_cnt = 0 THEN
               CALL adzp168_common_col_add_02(2,g_4fd_inf.form_vbm_idx)
            END IF
         END IF

         #單身
         CALL adzp168_common_col_add_02(p_tbtree_idx,g_4fd_inf.form_vbd_idx)
      END IF
   END IF

END FUNCTION


#+ 自動新增共用欄位-步驟02
PRIVATE FUNCTION adzp168_common_col_add_02(p_tbtree_idx,p_area_idx)
   DEFINE p_tbtree_idx     LIKE type_t.num5
   DEFINE p_area_idx       LIKE type_t.num5      #區塊index
   DEFINE l_root_idx       LIKE type_t.num5      #focus的Root節點index
   DEFINE l_dzfr003_child  LIKE dzfr_t.dzfr003   #編號-子節點
   DEFINE l_dzfr003        LIKE dzfr_t.dzfr003   #編號(流水號)
   DEFINE l_ftree_idx      LIKE type_t.num5
   DEFINE l_ftree_cnt      LIKE type_t.num5
   DEFINE l_cnt            LIKE type_t.num5
   DEFINE l_addcol_cnt     LIKE type_t.num5      #新增欄位數量
   DEFINE l_i              LIKE type_t.num5
   DEFINE l_str            STRING

   LET l_dzfr003 = 0
   LET l_ftree_cnt = g_form_tree.getLength()
   EXECUTE adzp168_info_col_com USING g_tbtree[p_tbtree_idx].b_tableid INTO l_cnt   #Table中的共用欄位數

   IF l_cnt > 0 THEN
      CASE
         WHEN p_area_idx = g_4fd_inf.form_vbm_idx   #單頭
            IF g_dzfq_m.dzfq007 = "Folder" THEN
                  FOR l_i = 1 TO l_ftree_cnt
                     CALL adzp168_form_tree_root_idx(l_i) RETURNING l_root_idx
                     IF l_root_idx = p_area_idx THEN
                        IF g_form_tree[l_i].dzfr006 = "Folder" THEN
                           CALL adzp168_form_add_pageinfo(l_i,"Y") RETURNING l_dzfr003,l_dzfr003_child
                           EXIT FOR
                        END IF
                     END IF
                  END FOR
            END IF
         WHEN p_area_idx = g_4fd_inf.form_vbd_idx   #單身
            LET l_str = g_dzfq_m.dzfq009 CLIPPED
            CASE
               WHEN g_dzfq_m.dzfq009 = "sarray"
                  FOR l_i = 1 TO l_ftree_cnt
                     CALL adzp168_form_tree_root_idx(l_i) RETURNING l_root_idx
                     IF l_root_idx = p_area_idx THEN
                        IF (cl_null(g_form_tree[l_i].dzfr009) OR g_form_tree[l_i].dzfr009 = g_tbtree[p_tbtree_idx].b_tableid)
                           AND (g_form_tree[l_i].dzfr006 = "Table" OR g_form_tree[l_i].dzfr006 = "ScrollGrid" OR g_form_tree[l_i].dzfr006 = "Tree") THEN

                           IF g_form_tree[l_i].dzfr006 = "ScrollGrid" THEN
                              LET l_i = l_i + 1   #row
                           END IF

                           LET l_dzfr003 = g_form_tree[l_i].dzfr003
                           EXIT FOR
                        END IF
                     END IF
                  END FOR

               WHEN l_str.getIndexOf("Folder",1) > 0
                  FOR l_i = 1 TO l_ftree_cnt
                     CALL adzp168_form_tree_root_idx(l_i) RETURNING l_root_idx
                     IF l_root_idx = p_area_idx THEN
                        IF g_form_tree[l_i].dzfr006 = "Folder" THEN
                           CALL adzp168_form_add_pageinfo(l_i,"Y") RETURNING l_dzfr003,l_dzfr003_child
                           EXIT FOR
                        END IF
                     END IF
                  END FOR
            END CASE

         IF l_dzfr003_child > 0 THEN
            LET l_dzfr003 = l_dzfr003_child
            #DISPLAY "adzp168_common_col_add l_dzfr003=",l_dzfr003,"; l_dzfr003_child=",l_dzfr003_child
         END IF
      END CASE
   END IF

   #畫面結構中要加入共用欄位的g_form_tree index
   IF l_dzfr003 > 0 THEN
      CALL adzp168_form_tree_fill("0",0,"0",FALSE)   #重整tree
      LET l_ftree_cnt = g_form_tree.getLength()
      FOR l_i = 1 TO l_ftree_cnt
         CALL adzp168_form_tree_root_idx(l_i) RETURNING l_root_idx
         IF l_root_idx = p_area_idx THEN
            IF g_form_tree[l_i].dzfr003 = l_dzfr003 THEN
               LET l_ftree_idx = l_i
               EXIT FOR
            END IF
         END IF
      END FOR
   END IF

   IF l_ftree_idx > 0 THEN
      LET g_tbtree_idx_t = g_tbtree_idx
      LET g_tbtree_idx = p_tbtree_idx
      LET g_ftree_idx_t = g_ftree_idx
      LET g_ftree_idx = l_ftree_idx
      CALL adzp168_col_fill(g_tbtree[g_tbtree_idx].b_tableid)
      CALL adzp168_selectinfo("selectgeneral","N")   #挑選欄位 - 一般欄位全不選,避免假雙檔把PK都設在單身
      CALL adzp168_selectinfo("selectinfo","Y")
      CALL adzp168_form_tree_add_col("column",0,g_ftree_idx) RETURNING l_addcol_cnt
      LET g_tbtree_idx = g_tbtree_idx_t
      LET g_ftree_idx = 1 #g_ftree_idx_t
      CALL adzp168_col_fill(g_tbtree[g_tbtree_idx].b_tableid)
      CALL adzp168_selectinfo("selectinfo","N")
      #DISPLAY "adzp168_common_col_add l_ftree_idx=",l_ftree_idx
   END IF
END FUNCTION

#+ 畫面設計 - 是否可以加入共用欄位
PRIVATE FUNCTION adzp168_form_tree_add_col_page_info_chk(p_ftree_idx,p_col_idx,p_column)
   DEFINE p_ftree_idx     LIKE type_t.num5
   DEFINE p_col_idx       LIKE type_t.num5
   DEFINE p_column        DYNAMIC ARRAY OF type_g_column       #欄位列表
   DEFINE l_chk           BOOLEAN
   DEFINE l_is_page_info  BOOLEAN
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_ftree_cnt     LIKE type_t.num5
   DEFINE l_root_idx      LIKE type_t.num5      #focus的Root節點index

   LET l_chk = FALSE

   CALL adzp168_form_tree_root_idx(p_ftree_idx) RETURNING l_root_idx

   #非共用欄位,不可放在page_info
   #單頭共用欄位只能放在page_info
   #單身共用欄位,不控管
   #單身切割框架為不切割時的Table都可放
   IF g_form_tree[p_ftree_idx].dzfr012 = "page_info_" THEN
      LET l_is_page_info = TRUE
   ELSE
      CALL adzp168_form_tree_add_col_page_info_chk_loop(l_root_idx,p_ftree_idx,g_form_tree[p_ftree_idx].dzfr004) RETURNING l_is_page_info
   END IF

   CASE
      WHEN g_form_tree[l_root_idx].dzfr006 = "Tree" OR g_form_tree[l_root_idx].dzfr007 = "s_browse"
         LET l_chk = TRUE

      #單身PK可以在多個單身出現,所以不控管
      WHEN g_form_tree[l_root_idx].dzfr007 = "vb_detail" AND p_column[p_col_idx].b_pk = "PK"
         LET l_chk = TRUE

      #單身共用欄位,不控管
      WHEN g_form_tree[l_root_idx].dzfr007 = "vb_detail" AND (p_column[p_col_idx].b_dzekgrp = "grpUIStateinfo" OR p_column[p_col_idx].b_dzekgrp = "grpUIBelong")
         LET l_chk = TRUE

      #單身切割框架為不切割時的Table都可放
      WHEN g_form_tree[l_root_idx].dzfr007 = "vb_detail" AND g_dzfq_m.dzfq009 = "sarray"
         LET l_chk = TRUE

      WHEN p_column[p_col_idx].b_dzekgrp = "grpUIStateinfo" OR p_column[p_col_idx].b_dzekgrp = "grpUIBelong"
         IF l_is_page_info THEN
            LET l_chk = TRUE
         ELSE
            LET l_chk = FALSE
         END IF

      OTHERWISE
         IF l_is_page_info THEN
            LET l_chk = FALSE
         ELSE
            LET l_chk = TRUE
         END IF
   END CASE


   RETURN l_chk
END FUNCTION

#+ 畫面設計 - 是否可以加入共用欄位,查是否屬於page_info
PRIVATE FUNCTION adzp168_form_tree_add_col_page_info_chk_loop(p_root_idx,p_ftree_idx,p_dzfr004)
   DEFINE p_root_idx      LIKE type_t.num5      #focus的Root節點index
   DEFINE p_ftree_idx     LIKE type_t.num5
   DEFINE p_dzfr004       LIKE dzfr_t.dzfr004   #父節點編號
   DEFINE l_chk           BOOLEAN
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_ftree_cnt     LIKE type_t.num5

   LET l_chk = FALSE

   FOR l_i = p_ftree_idx TO p_root_idx STEP -1
      IF g_form_tree[l_i].dzfr003 = p_dzfr004 THEN
         IF g_form_tree[l_i].dzfr012 = "page_info_" THEN
            LET l_chk = TRUE
            EXIT FOR
         ELSE
            #再往上找
            CALL adzp168_form_tree_add_col_page_info_chk_loop(p_root_idx,l_i,g_form_tree[l_i].dzfr004) RETURNING l_chk
            IF l_chk THEN
               EXIT FOR
            END IF
         END IF
      END IF
   END FOR

   RETURN l_chk
END FUNCTION

#+ 把單頭欄位依序產生到s_browse
PRIVATE FUNCTION adzp168_m_to_browse(p_ftree_idx)
   DEFINE p_ftree_idx     LIKE type_t.num10
   DEFINE l_chk           BOOLEAN
   DEFINE l_area_idx      LIKE type_t.num5      #區塊index
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_j             LIKE type_t.num5
   DEFINE l_cnt           LIKE type_t.num5

   DEFINE l_rootid        STRING
   DEFINE l_str           STRING
   DEFINE l_end           LIKE type_t.num5

   DEFINE l_dzfr003       LIKE dzfr_t.dzfr003   #編號(流水號)
   DEFINE l_dzfr004       LIKE dzfr_t.dzfr004   #父節點編號
   DEFINE l_dzfr005       LIKE dzfr_t.dzfr005   #順序(同階層中的排序)
   DEFINE l_dzfr006       LIKE dzfr_t.dzfr006   #4fd tag 類型
   DEFINE l_dzfr007       LIKE dzfr_t.dzfr007   #4fd tag name
   DEFINE l_dzfr008       LIKE dzfr_t.dzfr008   #4fd tag name 編號
   DEFINE l_dzfr011       LIKE dzfr_t.dzfr011   #是否可刪除
   DEFINE l_dzfr012       LIKE dzfr_t.dzfr012   #4fd tag name前置名稱(s_detail/folder_/page_/page_info_/group_/Grid/HBox/VBox)
   DEFINE l_gzzd005       LIKE gzzd_t.gzzd005
   DEFINE l_form_col      type_g_form_col

   #資料瀏覽區塊
   IF g_4fd_inf.form_browse_idx > 0 THEN
      LET l_chk = FALSE
      LET l_area_idx = g_4fd_inf.form_browse_idx
      LET l_rootid = g_form_tree[l_area_idx].b_id CLIPPED || "."

      LET l_str = g_dzfq_m.cbo_progtype CLIPPED,g_dzfq_m.cbo_formtype CLIPPED
      CASE
         #F003+查詢方案+假雙檔
         WHEN g_dzfq_m.cbo_setbrowse = "sc" AND g_4fd_inf.l_jiashuangdang AND (l_str = "F003" OR l_str = "F005")
            LET l_chk = TRUE
            LET l_cnt = g_form_tree.getLength()
            #刪除欄位
            FOR l_i = l_cnt TO l_area_idx STEP -1
               LET l_str = g_form_tree[l_i].b_id
               IF l_str.getIndexOf(l_rootid,1) = 1 THEN
                  IF g_form_tree[l_i].dzfr006 = "Field" AND g_form_tree[l_i].dzfr011 = "Y" THEN
                     CALL adzp168_form_tree_del_area(l_i)
                     LET p_ftree_idx = p_ftree_idx - 1
                  END IF
               END IF
            END FOR
      END CASE

      #加入單頭欄位
      IF l_chk THEN
         LET l_chk = FALSE
         CALL adzp168_form_tree_fill("0",0,"0",FALSE)   #重整tree

         LET l_area_idx = g_4fd_inf.form_vbm_idx
         LET l_rootid = g_form_tree[l_area_idx].b_id CLIPPED || "."
         LET l_cnt = g_form_tree.getLength()

         #單頭主表的PK欄位
         LET g_sql = "SELECT * FROM adzp168t2 WHERE rootarea IN ('vb_master','vb_headerlock') AND dzfr009 = ? AND dzeb004 = 'Y' ORDER BY arridx"
         PREPARE adzp168_m_to_browse_pre FROM g_sql
         DECLARE adzp168_m_to_browse_cur CURSOR FOR adzp168_m_to_browse_pre
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'PREPARE m_to_browse:'
            LET g_errparam.popup = FALSE
            CALL cl_err()
         END IF

         LET l_form_col.dzfr009 = g_tbtree[2].b_tableid   #主資料表代碼
         FOREACH adzp168_m_to_browse_cur USING l_form_col.dzfr009 INTO l_form_col.*
            #DISPLAY "add pk:",l_form_col.dzfr010
            CALL adzp168t1_new_dzfr003() RETURNING l_dzfr003   #暫存檔編號(流水號) - for新增資料
            CALL adzp168t1_new_dzfr005(g_form_tree[g_4fd_inf.form_browse_idx].dzfr003) RETURNING l_dzfr005   #暫存檔順序(同階層中的排序) - for新增資料
            EXECUTE adzp168t1_ins USING l_dzfr003,g_form_tree[g_4fd_inf.form_browse_idx].dzfr003,l_dzfr005,'Field','','',l_form_col.dzfr009,l_form_col.dzfr010,l_form_col.dzfr011,l_form_col.dzfr012,l_form_col.dzeb004,l_form_col.dzeb022,l_form_col.dzekgrp,l_form_col.gzzd005,l_form_col.dzef008,l_form_col.dzer007
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'ins TEMP:'||g_form_tree[g_4fd_inf.form_browse_idx].gzzd005 CLIPPED
               LET g_errparam.popup = FALSE
               CALL cl_err()
               EXIT FOREACH
            ELSE
               LET l_chk = TRUE
               LET p_ftree_idx = p_ftree_idx + 1
            END IF
         END FOREACH

         IF l_chk THEN
            CALL adzp168_form_tree_fill("0",0,"0",FALSE)   #重整tree
         END IF
      END IF
   END IF

   IF p_ftree_idx <= 0 THEN
      LET p_ftree_idx = 1
   END IF

   RETURN p_ftree_idx
END FUNCTION

#+ 把樹狀屬性設定產生到畫面結構
# type~type6,id,pid所設的欄位要加入單頭,單身
PRIVATE FUNCTION adzp168_treeconfig_to_4fd(p_ftree_idx)
   DEFINE p_ftree_idx     LIKE type_t.num10
   DEFINE l_dzff_d        type_g_dzff_d         #畫面結構設計附屬設定表
   DEFINE l_chk           BOOLEAN
   DEFINE l_exist         BOOLEAN               #是否存在
   DEFINE l_area_idx      LIKE type_t.num5      #區塊index
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_j             LIKE type_t.num5
   DEFINE l_k             LIKE type_t.num5
   DEFINE l_add_cnt       LIKE type_t.num5
   DEFINE l_addcol_cnt    LIKE type_t.num5      #新增欄位數量
   DEFINE l_form_tree_cnt LIKE type_t.num5
   DEFINE l_tbtree_cnt    LIKE type_t.num5
   DEFINE l_tbtree_idx    LIKE type_t.num5
   DEFINE l_root_idx      LIKE type_t.num5
   DEFINE l_ct_idx        LIKE type_t.num5      #Container節點index
   DEFINE l_ct1_idx       LIKE type_t.num5      #第一個Container節點index
   DEFINE l_table_leve    LIKE type_t.num5      #階層
   DEFINE l_reflash       BOOLEAN               #是否有重新整理
   DEFINE l_form_tree_len LIKE type_t.num5
   DEFINE l_rootid        STRING
   DEFINE l_str           STRING
   DEFINE ls_dzff005      STRING
   DEFINE l_end           LIKE type_t.num5
   DEFINE l_form_tree RECORD
      b_show    STRING,                #節點名稱
      b_img     STRING,                #節點圖片
      b_pid     STRING,                #父節點id
      b_id      STRING,                #節點id
      b_hasC    BOOLEAN,               #TRUE:有子節點, FALSE:無子節點
      b_exp     BOOLEAN,               #TRUE:展開, FALSE:不展開
      b_level   LIKE type_t.num5,      #階層
      dzfr003   LIKE dzfr_t.dzfr003,   #編號(流水號)
      dzfr004   LIKE dzfr_t.dzfr004,   #父節點編號
      dzfr005   LIKE dzfr_t.dzfr005,   #順序(同階層中的排序)
      dzfr006   LIKE dzfr_t.dzfr006,   #4fd tag 類型
      dzfr007   LIKE dzfr_t.dzfr007,   #4fd tag name
      dzfr008   LIKE dzfr_t.dzfr008,   #4fd tag name 編號
      dzfr009   LIKE dzfr_t.dzfr009,   #資料表代碼
      dzfr010   LIKE dzfr_t.dzfr010,   #欄位代碼
      dzfr011   LIKE dzfr_t.dzfr011,   #是否可刪除
      dzfr012   LIKE dzfr_t.dzfr012,   #4fd tag name前置名稱(s_detail/folder_/page_/page_info_/group_/Grid/HBox/VBox)
      dzeb004   LIKE dzeb_t.dzeb004,   #primary key
      dzeb022   LIKE dzeb_t.dzeb022,   #屬於哪一種欄位定義代碼(dzek001)
      dzekgrp   LIKE dzek_t.dzek001,   #欄位定義代碼群組grpUIBelong/grpUIStateinfo
      gzzd005   LIKE gzzd_t.gzzd005,   #畫面元件多語言 by g_lang
      #產生4fd所需要的資訊----
      dzef008   LIKE dzef_t.dzef008,   #參考欄位
      dzer007   LIKE dzer_t.dzer007    #多語言欄位
      END RECORD

   LET l_chk = FALSE
   LET l_reflash = FALSE
   LET l_form_tree_cnt = g_form_tree.getLength()
   LET l_tbtree_cnt = g_tbtree.getLength()

   IF l_form_tree_cnt> 0 AND l_tbtree_cnt > 0 AND g_4fd_inf.form_browse_idx > 0 THEN
      IF g_form_tree[g_4fd_inf.form_browse_idx].dzfr006 = "Tree" THEN
         LET l_chk = TRUE
      END IF
   END IF

   IF l_chk  THEN
      FOREACH adzp168_dzff_sel_curs2 USING g_dzfq_m.dzfq004,g_dzfq_m.dzfq003,g_form_tree[g_4fd_inf.form_browse_idx].dzfr007
            INTO l_dzff_d.dzff001,l_dzff_d.dzff002,l_dzff_d.dzff003,
                 l_dzff_d.dzff004,l_dzff_d.dzff005,l_dzff_d.dzff006,l_dzff_d.dzff007,l_dzff_d.dzff008

         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET l_chk = FALSE
            EXIT FOREACH
         END IF

         LET l_table_leve = 0
         LET l_tbtree_idx = 0
         FOR l_i = 1 TO l_tbtree_cnt
            IF g_tbtree[l_i].b_tableid = l_dzff_d.dzff006 THEN
               LET l_table_leve = g_tbtree[l_i].b_level
               LET l_tbtree_idx = l_i
               EXIT FOR
            END IF
         END FOR

         IF l_tbtree_idx > 1 THEN
            IF NOT cl_null(l_dzff_d.dzff007) AND ls_dzff005.getIndexOf("type" ,1) OR l_dzff_d.dzff005 = "id" OR l_dzff_d.dzff005 = "pid" THEN
               #單頭:Level 1 Table
               IF g_4fd_inf.form_vbm_idx > 0 AND l_table_leve = 1 THEN
                  LET l_exist = FALSE
                  LET l_area_idx = g_4fd_inf.form_vbm_idx
                  LET l_rootid = g_form_tree[l_area_idx].b_id CLIPPED || "."

                  FOR l_i = l_area_idx + 1 TO l_form_tree_cnt
                     LET l_str = g_form_tree[l_i].b_id
                     IF l_str.getIndexOf(l_rootid,1) = 1 THEN
                        IF g_form_tree[l_i].dzfr010 = l_dzff_d.dzff007 THEN
                           LET l_exist = TRUE
                        END IF
                     ELSE
                        EXIT FOR
                     END IF
                  END FOR

                  IF NOT l_exist THEN
                     LET l_j = 0
                     #要加入欄位的容器index,單頭若有Folder則欄位加在第一個Page
                     FOR l_i = l_area_idx + 1 TO l_form_tree_cnt
                        LET l_str = g_form_tree[l_i].b_id
                        IF l_str.getIndexOf(l_rootid,1) = 1 THEN
                           IF g_form_tree[l_i].dzfr006 = "Page" OR g_form_tree[l_i].dzfr006 = "Group" OR g_form_tree[l_i].dzfr006 = "Grid" THEN
                              LET l_j = l_i
                              EXIT FOR
                           END IF
                        ELSE
                           EXIT FOR
                        END IF
                     END FOR

                     IF l_j > 0 THEN

                        #CALL adzp168t1_new_dzfr003() RETURNING l_form_tree.dzfr003   #暫存檔編號(流水號) - for新增資料
                        #CALL adzp168t1_new_dzfr005(g_form_tree[l_j].dzfr003) RETURNING l_form_tree.dzfr005   #暫存檔順序(同階層中的排序) - for新增資料
                        #LET l_form_tree.dzfr006 = "Field"            #4fd tag 類型
                        #LET l_form_tree.dzfr007 = ""                 #4fd tag name
                        #LET l_form_tree.dzfr008 = ""                 #4fd tag name 編號
                        LET l_form_tree.dzfr009 = l_dzff_d.dzff006 CLIPPED    #資料表代碼
                        #LET l_form_tree.dzfr010 = l_dzff_d.dzff007   #欄位代碼
                        #LET l_form_tree.dzfr011 = "Y"                #是否可刪除
                        #LET l_form_tree.dzeb004 = #primary key
                        #LET l_form_tree.dzeb022 = #屬於哪一種欄位定義代碼(dzek001)
                        #LET l_form_tree.gzzd005 = #畫面元件多語言 by g_lang
                        #LET l_form_tree.dzef008 = #參考欄位
                        #LET l_form_tree.dzer007 = #多語言欄位

                        #備份設定
                        LET g_tbtree_idx_t = g_tbtree_idx
                        LET g_tbtree_idx = l_tbtree_idx

                        LET g_ftree_idx_t = g_ftree_idx
                        LET g_ftree_idx = l_j

                        CALL adzp168_col_fill(l_dzff_d.dzff006)   #g_tbtree[g_tbtree_idx].b_tableid
                        FOR l_i = 1 TO  g_column.getLength()
                           IF g_column[l_i].b_colid = l_dzff_d.dzff007 THEN
                              LET g_column[l_i].b_sel = "Y"
                           END IF

                        END FOR

                        LET l_reflash = TRUE
                        LET g_ftree_idx_t = g_ftree_idx
                        CALL adzp168_form_tree_add_col("column",0,g_ftree_idx) RETURNING l_addcol_cnt

                        #CALL adzp168_m_to_browse(g_ftree_idx_t) RETURNING g_ftree_idx #把單頭欄位依序產生到s_browse
                        #LET l_cnt = g_form_tree.getLength()
                        #CALL DIALOG.setCurrentRow("s_form_tree",g_ftree_idx)

                        #還原設定
                        LET g_tbtree_idx = g_tbtree_idx_t
                        #LET g_ftree_idx = g_ftree_idx_t
                        IF g_tbtree[g_tbtree_idx].b_tableid <> l_dzff_d.dzff006 THEN
                           CALL adzp168_col_fill(g_tbtree[g_tbtree_idx].b_tableid)
                        END IF
                        #table -> col fill -> add_col

                        #EXECUTE adzp168t1_ins USING l_form_tree.dzfr003,g_form_tree[l_j].dzfr003,l_form_tree.dzfr005,l_form_tree.dzfr006,l_form_tree.dzfr007,l_form_tree.dzfr008,l_form_tree.dzfr009,l_form_tree.dzfr010,l_form_tree.dzfr011
                        #,l_form_tree.dzeb004,l_form_tree.dzeb022,l_form_tree.gzzd005,l_form_tree.dzef008,l_form_tree.dzer007
                     END IF

                     #      IF SQLCA.sqlcode THEN
                     #         CALL cl_err('ins:'||g_form_tree[g_4fd_inf.form_browse_idx].gzzd005 CLIPPED,SQLCA.sqlcode,0)
                     #      ELSE
                     #         LET p_ftree_idx = p_ftree_idx + 1
                     #      END IF
                     #      LET l_chk = TRUE

                     #CALL adzp168_form_tree_fill("0",0,"0",FALSE)   #重整tree
                  END IF
               END IF

               #單身
               IF g_4fd_inf.form_vbd_idx > 0 AND l_table_leve > 1 THEN
                  LET l_exist = FALSE
                  LET l_area_idx = g_4fd_inf.form_vbd_idx
                  LET l_rootid = g_form_tree[l_area_idx].b_id CLIPPED || "."


                  LET l_form_tree_len = g_form_tree.getLength()
                  LET l_ct1_idx = 0
                  LET l_add_cnt = 0
                  FOR l_k = l_area_idx + 1 TO l_form_tree_len
                     CALL adzp168_form_tree_root_idx(l_k) RETURNING l_root_idx
                     IF l_root_idx = l_area_idx THEN
                        IF g_form_tree[l_k].dzfr006 = g_dzfq_m.dzfq010 THEN   #單身框架(Table/ScrollGrid)
                           LET l_chk = FALSE
                           LET l_ct_idx =  l_k
                           IF l_ct1_idx = 0 THEN   #第一個Container節點index
                              LET l_ct1_idx = l_ct_idx
                           END IF

                           IF g_form_tree[l_ct_idx].dzfr009 = l_dzff_d.dzff006 THEN #同資料表代碼
                             #DISPLAY g_form_tree[l_ct_idx].b_show," test_msg need add l_dzff_d.dzff005=",l_dzff_d.dzff005,"; l_dzff_d.dzff007=",l_dzff_d.dzff007
                             #LET l_form_tree.dzfr009 = l_dzff_d.dzff006 CLIPPED    #資料表代碼

                             #備份設定
                             LET g_tbtree_idx_t = g_tbtree_idx
                             LET g_tbtree_idx = l_tbtree_idx

                             LET g_ftree_idx_t = g_ftree_idx
                             LET g_ftree_idx = l_ct_idx

                             CALL adzp168_col_fill(l_dzff_d.dzff006)   #g_tbtree[g_tbtree_idx].b_tableid
                             FOR l_i = 1 TO g_column.getLength()
                                IF g_column[l_i].b_colid = l_dzff_d.dzff007 THEN
                                   LET g_column[l_i].b_sel = "Y"
                                   #強制勾選或不選
                                   CALL adzp168_col_must_sel(g_column[l_i].b_sel,l_i,TRUE) RETURNING g_column[l_i].b_sel
                                   IF g_column[l_i].b_sel = "Y" THEN
                                      LET l_add_cnt = l_add_cnt + 1
                                      #DISPLAY "test_msg col:",g_column[l_i].b_colid
                                   END IF
                                END IF
                             END FOR

                             LET l_reflash = TRUE
                             LET g_ftree_idx_t = g_ftree_idx
                             CALL adzp168_form_tree_add_col("column",0,g_ftree_idx) RETURNING l_addcol_cnt

                             #還原設定
                             LET g_tbtree_idx = g_tbtree_idx_t
                             #LET g_ftree_idx = g_ftree_idx_t
                             IF g_tbtree[g_tbtree_idx].b_tableid <> l_dzff_d.dzff006 THEN
                                CALL adzp168_col_fill(g_tbtree[g_tbtree_idx].b_tableid)
                             END IF
                           END IF

                        END IF
                     ELSE
                        EXIT FOR
                     END IF
                  END FOR

                  #找不到單身有設定相同Table,則加在第一個單身
                  IF l_add_cnt = 0 AND l_ct1_idx > 0 THEN
                     LET l_ct_idx = l_ct1_idx

                     #備份設定
                     LET g_tbtree_idx_t = g_tbtree_idx
                     LET g_tbtree_idx = l_tbtree_idx

                     LET g_ftree_idx_t = g_ftree_idx
                     LET g_ftree_idx = l_ct_idx

                     CALL adzp168_col_fill(l_dzff_d.dzff006)   #g_tbtree[g_tbtree_idx].b_tableid
                     FOR l_i = 1 TO g_column.getLength()
                        IF g_column[l_i].b_colid = l_dzff_d.dzff007 THEN
                           LET g_column[l_i].b_sel = "Y"
                           #強制勾選或不選
                           CALL adzp168_col_must_sel(g_column[l_i].b_sel,l_i,TRUE) RETURNING g_column[l_i].b_sel
                           IF g_column[l_i].b_sel = "Y" THEN
                              LET l_add_cnt = l_add_cnt + 1
                              #DISPLAY "test_msg col:",g_column[l_i].b_colid
                           END IF
                        END IF
                     END FOR

                     LET l_reflash = TRUE
                     LET g_ftree_idx_t = g_ftree_idx
                     CALL adzp168_form_tree_add_col("column",0,g_ftree_idx) RETURNING l_addcol_cnt

                     #還原設定
                     LET g_tbtree_idx = g_tbtree_idx_t
                     #LET g_ftree_idx = g_ftree_idx_t
                     IF g_tbtree[g_tbtree_idx].b_tableid <> l_dzff_d.dzff006 THEN
                        CALL adzp168_col_fill(g_tbtree[g_tbtree_idx].b_tableid)
                     END IF
                  END IF

               END IF
            END IF


            IF NOT cl_null(l_dzff_d.dzff007) AND (ls_dzff005.getIndexOf("type" ,1) = 1 OR l_dzff_d.dzff005 = "id" OR l_dzff_d.dzff005 = "pid" OR l_dzff_d.dzff005 = "desc") THEN
               #Tree
               IF g_4fd_inf.form_browse_idx > 0
                    AND l_table_leve = 1   #2013/09/13 柏榕:不可放入單身欄位
                 THEN

                  LET l_area_idx = g_4fd_inf.form_browse_idx
                  LET l_rootid = g_form_tree[l_area_idx].b_id CLIPPED || "."
                  IF g_form_tree[l_area_idx].dzfr006 = "Tree" THEN
                     LET l_exist = FALSE

                     FOR l_i = l_area_idx + 1 TO l_form_tree_cnt
                        LET l_str = g_form_tree[l_i].b_id
                        IF l_str.getIndexOf(l_rootid,1) = 1 THEN
                           IF g_form_tree[l_i].dzfr010 = l_dzff_d.dzff007 THEN
                              LET l_exist = TRUE
                           END IF
                        ELSE
                           EXIT FOR
                        END IF
                     END FOR

                     IF NOT l_exist THEN
                        LET l_form_tree.dzfr009 = l_dzff_d.dzff006 CLIPPED    #資料表代碼

                        #備份設定
                        LET g_tbtree_idx_t = g_tbtree_idx
                        LET g_tbtree_idx = l_tbtree_idx

                        LET g_ftree_idx_t = g_ftree_idx
                        LET g_ftree_idx = l_area_idx

                        CALL adzp168_col_fill(l_dzff_d.dzff006)   #g_tbtree[g_tbtree_idx].b_tableid
                        FOR l_i = 1 TO  g_column.getLength()
                           IF g_column[l_i].b_colid = l_dzff_d.dzff007 THEN
                              LET g_column[l_i].b_sel = "Y"
                           END IF

                        END FOR

                        LET l_reflash = TRUE
                        LET g_ftree_idx_t = g_ftree_idx
                        CALL adzp168_form_tree_add_col("column",0,g_ftree_idx) RETURNING l_addcol_cnt

                        #還原設定
                        LET g_tbtree_idx = g_tbtree_idx_t
                        #LET g_ftree_idx = g_ftree_idx_t
                        IF g_tbtree[g_tbtree_idx].b_tableid <> l_dzff_d.dzff006 THEN
                           CALL adzp168_col_fill(g_tbtree[g_tbtree_idx].b_tableid)
                        END IF
                        #table -> col fill -> add_col
                     END IF

                  END IF
               END IF
            END IF
        END IF
      END FOREACH
   END IF

   RETURN g_ftree_idx,l_reflash
END FUNCTION


#+ 產生畫面設計底稿
PRIVATE FUNCTION adzp168_draft_save()
   DEFINE l_chk           BOOLEAN
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_dzff_d        type_g_dzff_d        #畫面結構設計附屬設定表
   DEFINE l_dzfy004       LIKE dzfy_t.dzfy004  #Action ID

   LET l_chk = TRUE


   #產生4fd所需要的資訊
   LET g_4fd_inf.d_tb1 = NULL        #第一個單身的Table

   CALL sadzp168_1_draft_exist(g_ver_ra,g_dzfq_m.dzfqownid,g_dzfq_m.dzfq004) RETURNING l_chk   #畫面設計資料是否可覆蓋

   IF l_chk THEN
      CALL adzp168_dzfq016()   #樹狀結構類別設定值是否清空
   END IF

   IF l_chk THEN
      #畫面結構設計主檔底稿
      LET g_sql = "INSERT INTO dzfv_t(dzfv001,dzfv002,dzfv003,dzfv004,dzfv005,",
                                     "dzfv006,dzfv007,dzfv008,dzfv009,dzfv010,",
                                     "dzfv011,dzfv012,dzfv013,dzfv014,dzfv015)",
                     "  VALUES(?,?,?,?,? ,?,?,?,?,? ,?,?,?,?,?)"
      PREPARE adzp168_dzfv_ins FROM g_sql

      #畫面結構設計內容檔底稿
      LET g_sql = "INSERT INTO dzfz_t(dzfz001,dzfz002,dzfz003,dzfz004,dzfz005,",
                                    " dzfz006,dzfz007,dzfz008,dzfz009,dzfz010,",
                                    " dzfz011,dzfz012,dzfz013)",
                     "  VALUES(?,?,?,?,? ,?,?,?,?,? ,?,?,?)"
      PREPARE adzp168_dzfz_ins FROM g_sql

      #畫面樣版ToolBar功能鍵設定檔底稿(只記錄已勾選)
      LET g_sql = "INSERT INTO dzfy_t(dzfy001,dzfy002,dzfy003,dzfy004)",
                     "  VALUES(?,?,?,?)"
      PREPARE adzp168_dzfy_ins FROM g_sql
   END IF

   BEGIN WORK

   IF l_chk THEN
      CALL adzp168_draft_del(FALSE) RETURNING l_chk   #刪除底稿
   END IF

   IF l_chk THEN
      #畫面結構設計主檔
      EXECUTE adzp168_dzfv_ins USING g_ver_ra,g_dzfq_m.dzfqownid,
                                     g_dzfq_m.dzfq001,g_dzfq_m.dzfq004,g_dzfq_m.dzfq005,
                                     g_dzfq_m.dzfq006,g_dzfq_m.dzfq007,g_dzfq_m.dzfq008,g_dzfq_m.dzfq009,g_dzfq_m.dzfq010,
                                     g_dzfq_m.dzfq012,g_dzfq_m.dzfq013,g_dzfq_m.dzfq014,g_dzfq_m.dzfq015,g_dzfq_m.dzfq016
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'ins draft_save_01:'
         LET g_errparam.popup = FALSE
         CALL cl_err()
         LET l_chk = FALSE
      ELSE
         #樹狀結構屬性設定檔底稿
         CALL adzp168_dzff_dzfw_ins("N") RETURNING l_chk
      END IF
   END IF

   IF l_chk THEN
      FOR l_i = 1 TO g_form_tree.getLength()
         #畫面結構設計內容檔底稿
         EXECUTE adzp168_dzfz_ins USING g_ver_ra,g_dzfq_m.dzfqownid,
                                        g_dzfq_m.dzfq004,g_form_tree[l_i].dzfr003,g_form_tree[l_i].dzfr004,g_form_tree[l_i].dzfr005,
                                        g_form_tree[l_i].dzfr006,g_form_tree[l_i].dzfr007,g_form_tree[l_i].dzfr008,g_form_tree[l_i].dzfr009,g_form_tree[l_i].dzfr010,
                                        g_form_tree[l_i].dzfr011,g_form_tree[l_i].dzfr012
         IF SQLCA.sqlcode THEN
            LET l_chk = FALSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'ins:'
            LET g_errparam.popup = FALSE
            CALL cl_err()
            EXIT FOR
         END IF
      END FOR
   END IF

   #程式資料表設定
   IF l_chk AND g_dzfq_m.dzfq015 = "N" THEN
      CALL adzp168_dzag("N") RETURNING l_chk
   END IF

   #dzfy_t 畫面樣版ToolBar功能鍵設定檔底稿(只記錄已勾選)
   IF l_chk THEN
      LET l_cnt = g_toolbar.getLength()
      IF l_cnt > 0 THEN
         FOR l_i = 1 TO l_cnt
            IF g_toolbar[l_i].toolbar_chk = "Y" THEN
               LET l_dzfy004 = g_toolbar[l_i].tb_act_id CLIPPED
               EXECUTE adzp168_dzfy_ins USING g_ver_ra,g_dzfq_m.dzfqownid,g_dzfq_m.dzfq004,l_dzfy004
            END IF
         END FOR
      END IF
   END IF

   IF l_chk THEN
      COMMIT WORK
   ELSE
      ROLLBACK WORK
   END IF
END FUNCTION

#+ 產生4fd
PRIVATE FUNCTION adzp168_gen_4fd()
   DEFINE l_chk           BOOLEAN
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_dzff_d        type_g_dzff_d        #畫面結構設計附屬設定表
   DEFINE l_dzfs006       LIKE dzfs_t.dzfs006  #允許插入
   DEFINE l_dzfs007       LIKE dzfs_t.dzfs007  #允許刪除
   DEFINE l_dzfs008       LIKE dzfs_t.dzfs008  #允許新增
   DEFINE l_dzfs009       LIKE dzfs_t.dzfs009  #是否連動
   DEFINE l_dzax002       LIKE dzax_t.dzax002   #progtype
   DEFINE l_msg           STRING

   LET l_chk = TRUE

   #產生4fd所需要的資訊
   LET g_4fd_inf.d_tb1 = NULL        #第一個單身的Table

   LET l_msg = NULL
   CALL sadzp060_2_have_checked_out(g_dzfq_m.dzfq004, g_dzfq_m.dzfq005, "SD",1) RETURNING l_msg   #判斷是否已經簽出 for Hiko
   IF cl_null(l_msg) THEN
      LET l_chk = TRUE

      IF l_chk THEN
         CALL adzp168_dzfq016()   #樹狀結構類別設定值是否清空
      END IF

      IF l_chk AND g_dzfq_m.dzfq015 = "N" THEN
         CALL adzp168_gen_4fd_chk() RETURNING l_chk  #產生4fd前的檢查
      END IF

      IF l_chk THEN
         CALL sadzp168_1_dzaa_exist(g_dzfq_m.dzfq004,g_dzfq_m.dzfq005,TRUE) RETURNING l_chk   #畫面設計資料是否可覆蓋
      END IF

      IF l_chk THEN
         CALL cl_progress_bar(4)
         CALL cl_getmsg("adz-00014",g_lang) RETURNING l_msg
         CALL cl_progress_ing(l_msg)   #儲存設定資料

         IF l_chk THEN
            BEGIN WORK
            #CALL sadzp168_1_del(g_dzfq_m.dzfq004) RETURNING l_chk

            EXECUTE adzp168_dzfq_del USING g_dzfq_m.dzfq003,g_dzfq_m.dzfq004
            EXECUTE adzp168_dzfr_y_del USING g_dzfq_m.dzfq003,g_dzfq_m.dzfq004
            EXECUTE adzp168_dzfs_del USING g_ver_dzag003,g_dzfq_m.dzfq004,ms_dgenv
            EXECUTE adzp168_dzff_del_pre USING g_dzfq_m.dzfq004,g_ver_dzag003,ms_dgenv

            #畫面結構設計主檔
            EXECUTE adzp168_dzfq_ins USING g_dzfq_m.dzfq001,g_dzfq_m.dzfq002,g_dzfq_m.dzfq003,g_dzfq_m.dzfq004,g_dzfq_m.dzfq005,
                                           g_dzfq_m.dzfq006,g_dzfq_m.dzfq007,g_dzfq_m.dzfq008,g_dzfq_m.dzfq009,g_dzfq_m.dzfq010,
                                           g_dzfq_m.dzfq011,g_dzfq_m.dzfq012,g_dzfq_m.dzfq013,g_dzfq_m.dzfq014,g_dzfq_m.dzfq015,
                                           g_dzfq_m.dzfq016,
                                           g_dzfq_m.dzfqmodid,g_dzfq_m.dzfqmoddt,g_dzfq_m.dzfqownid,g_dzfq_m.dzfqowndp,g_dzfq_m.dzfqcrtid,g_dzfq_m.dzfqcrtdp,g_dzfq_m.dzfqcrtdt,g_dzfq_m.dzfqstus
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'ins:'
               LET g_errparam.popup = FALSE
               CALL cl_err()
               ROLLBACK WORK
               LET l_chk = FALSE
            END IF

            IF l_chk THEN
               CALL adzp168_dzff_dzfw_ins("Y") RETURNING l_chk
               IF NOT l_chk THEN
                  ROLLBACK WORK
               END IF
            END IF

            IF l_chk THEN
               FOR l_i = 1 TO g_form_tree.getLength()
                  #畫面結構設計內容檔
                  EXECUTE adzp168_dzfr_ins USING g_dzfq_m.dzfq003,g_dzfq_m.dzfq004,g_form_tree[l_i].dzfr003,g_form_tree[l_i].dzfr004,g_form_tree[l_i].dzfr005,
                                                 g_form_tree[l_i].dzfr006,g_form_tree[l_i].dzfr007,g_form_tree[l_i].dzfr008,g_form_tree[l_i].dzfr009,g_form_tree[l_i].dzfr010,
                                                 g_form_tree[l_i].dzfr011,g_form_tree[l_i].dzfr012
                  IF SQLCA.sqlcode THEN
                     LET l_chk = FALSE
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = 'ins:'
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
                     ROLLBACK WORK
                     EXIT FOR
                  END IF

                  #新增程式Table與Screen Record對應檔
                  IF g_form_tree[l_i].dzfr006 = "Table" OR g_form_tree[l_i].dzfr006 = "ScrollGrid" OR g_form_tree[l_i].dzfr006 = "Tree" THEN
                     IF (NOT cl_null(g_form_tree[l_i].dzfr007)) AND (NOT cl_null(g_form_tree[l_i].dzfr009)) THEN
                        #r.a都預設為'Y'; 但若dzfs010='Tree'或dzfs003='s_browse'(查詢方案是Table)時,則dzfs009='N'   #2014/01/22
                        #s_browse的dzfs006,dzfs007,dzfs008建議INSERT ROW/DELETE ROW/APPEND ROW預設為'N'   #2015/10/02 Hiko
                        LET l_dzfs006 = "Y"
                        LET l_dzfs007 = "Y"
                        LET l_dzfs008 = "Y"
                        LET l_dzfs009 = "Y"
                        IF g_form_tree[l_i].dzfr006 = "Tree" OR g_form_tree[l_i].dzfr007 = "s_browse" THEN
                           LET l_dzfs006 = "N"
                           LET l_dzfs007 = "N"
                           LET l_dzfs008 = "N"
                           LET l_dzfs009 = "N"
                        END IF

                        EXECUTE adzp168_dzfs_ins_pre USING g_ver_dzag003,g_dzfq_m.dzfq004,g_form_tree[l_i].dzfr007,g_form_tree[l_i].dzfr009,ms_dgenv,
                                                           l_dzfs006,l_dzfs007,l_dzfs008,l_dzfs009,g_form_tree[l_i].dzfr006,
                                                           ms_cust,ms_dgenv,
                                                           g_dzfq_m.dzfqmodid,g_dzfq_m.dzfqmoddt,g_dzfq_m.dzfqownid,g_dzfq_m.dzfqowndp,g_dzfq_m.dzfqcrtid,g_dzfq_m.dzfqcrtdp,g_dzfq_m.dzfqcrtdt,g_dzfq_m.dzfqstus
                        IF SQLCA.sqlcode THEN
                           LET l_chk = FALSE
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code = SQLCA.sqlcode
                           LET g_errparam.extend = 'ins:'
                           LET g_errparam.popup = FALSE
                           CALL cl_err()
                           ROLLBACK WORK
                           EXIT FOR
                        END IF
                     END IF
                  END IF

                  #第一個單身的Table
                  IF g_4fd_inf.form_vbd_idx > 0 AND cl_null(g_4fd_inf.d_tb1) THEN
                     IF adzp168_form_tree_root_idx(l_i) = g_4fd_inf.form_vbd_idx AND (g_form_tree[l_i].dzfr006 = "Table" OR g_form_tree[l_i].dzfr006 = "ScrollGrid" OR g_form_tree[l_i].dzfr006 = "Tree") THEN
                        LET g_4fd_inf.d_tb1 = g_form_tree[l_i].dzfr009 CLIPPED
                     END IF
                  END IF
               END FOR
            END IF

            #程式資料表設定
            IF l_chk AND g_dzfq_m.dzfq015 = "N" THEN
               CALL adzp168_dzag("Y") RETURNING l_chk
               #IF NOT l_chk THEN
               #   ROLLBACK WORK
               #END IF
            END IF

            #程式設計基本設定表dzax_t
            IF l_chk THEN
               LET g_sql = "DELETE FROM dzax_t WHERE dzax001=? AND dzax006=?"
               PREPARE adzp168_dzax_del_pre FROM g_sql
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = 'PREPARE:'
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
               END IF
               EXECUTE adzp168_dzax_del_pre USING g_dzfq_m.dzfq004,ms_dgenv

               #是否為Free Style:在r.a預設是'N'
               LET g_sql = "INSERT INTO dzax_t(dzax001,dzax002,dzax003,dzax004,dzax005,dzax006,dzax007,",
                                 "dzaxownid,dzaxowndp,dzaxcrtid,dzaxcrtdp,dzaxcrtdt,dzaxstus)",
                           " VALUES(?,?,'N','N',? ,?,NULL,?,?,? ,?,?,?)"
               PREPARE adzp168_dzax_ins_pre FROM g_sql
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = 'PREPARE:'
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
               END IF

               LET l_dzax002 = g_dzfq_m.cbo_progtype CLIPPED
               #HJ: 2014/04/18 "P002"，dzax002 指定為W  select dzax002 from dzax_t where dzax001='aiti201';
               IF g_dzfq_m.cbo_progtype = "P" AND g_dzfq_m.cbo_formtype = "002" THEN
                  LET l_dzax002 = "W"
               END IF

               EXECUTE adzp168_dzax_ins_pre USING g_dzfq_m.dzfq004,l_dzax002,ms_cust,ms_dgenv,
                          g_dzfq_m.dzfqownid,g_dzfq_m.dzfqowndp,g_dzfq_m.dzfqcrtid,g_dzfq_m.dzfqcrtdp,g_dzfq_m.dzfqcrtdt,g_dzfq_m.dzfqstus
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = 'ins:'
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  ROLLBACK WORK
                  LET l_chk = FALSE
               END IF
            END IF

            IF l_chk THEN
               #DISPLAY ""
               #DISPLAY "test_msg ------------------------------------------"
               #DISPLAY "test_msg Author: Jay"
               #DISPLAY "test_msg sadzp168_4fd('",g_dzfq_m.dzfq004 CLIPPED,"')"
               #DISPLAY ""

               LET g_rtn_msg = FALSE
               IF sadzp168_4fd(g_dzfq_m.dzfq004) THEN
                  #DISPLAY ""
                  #DISPLAY "test_msg ------------------------------------------"
                  #DISPLAY "test_msg Author: Jay"
                  #DISPLAY "test_msg sadzp168_insert_tsd('",g_dzfq_m.dzfq004 CLIPPED,"','",g_dzfq_m.cbo_progtype CLIPPED,"','",g_dzfq_m.cbo_formtype CLIPPED,"')"
                  #DISPLAY ""
                  IF sadzp168_insert_tsd(g_dzfq_m.dzfq004, g_dzfq_m.cbo_progtype, g_dzfq_m.cbo_formtype) THEN
                     #DISPLAY "test_msg Author: Hiko"
                     #2014/2/27 mark: 下載給設計器時才需要產生tsd
                  ELSE
                     LET l_chk = FALSE
                  END IF
               ELSE
                  LET l_chk = FALSE
               END IF
            END IF

            IF l_chk THEN
               COMMIT WORK
            ELSE
               ROLLBACK WORK
            END IF
         END IF


         CALL cl_getmsg("adz-00016",g_lang) RETURNING l_msg
         CALL cl_progress_ing(l_msg)   #解析設計資料
         IF l_chk THEN
            #DISPLAY ""
            #DISPLAY ""
            #DISPLAY "test_msg ------------------------------------------"
            #DISPLAY "test_msg Author: Jay"
            #DISPLAY "test_msg sadzp168_3('",DOWNSHIFT(g_gzza003) CLIPPED,"','",g_dzfq_m.dzfq004 CLIPPED,"','",g_ver_dzaa002 CLIPPED,"')"
            #DISPLAY ""

            #解析4fd成設計資料 by Jay:sadzp168_3(實際模組, 畫面代碼 , 規格版號,DGENV使用標示:s-標準產品, c-客製)
            #sadzp168_3有自己的TRANSACTION
            LET g_rtn_msg = TRUE
            CALL sadzp168_3(DOWNSHIFT(g_gzza003_module), g_dzfq_m.dzfq004 , g_ver_dzaa002, ms_dgenv) RETURNING l_chk,l_msg  #todo
            IF NOT l_chk AND NOT cl_null(l_msg) THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  "adz-00022"
               LET g_errparam.extend = NULL
               LET g_errparam.popup = TRUE
               LET g_errparam.replace[1] =  l_msg CLIPPED
               CALL cl_err()
            END IF
         END IF

         CALL cl_getmsg("adz-00018",g_lang) RETURNING l_msg
         CALL cl_progress_ing(l_msg)   #預覽畫面
         IF l_chk THEN
            CALL adzp168_final() RETURNING l_chk
         END IF
         CALL cl_progress_ing('')

         IF l_chk THEN
            CALL adzp168_draft_del(TRUE) RETURNING l_chk   #刪除底稿
         END IF
      END IF
   END IF
END FUNCTION


#+ 產生4fd前的檢查
PRIVATE FUNCTION adzp168_gen_4fd_chk()
   DEFINE l_chk      BOOLEAN
   DEFINE l_cnt      LIKE type_t.num5
   DEFINE l_len      LIKE type_t.num5
   DEFINE l_i        LIKE type_t.num5
   DEFINE l_j        LIKE type_t.num5
   DEFINE l_dzfr007  LIKE dzfr_t.dzfr007
   DEFINE l_str      STRING
   DEFINE l_msg      STRING
   DEFINE l_form_col DYNAMIC ARRAY OF type_g_form_col
   #DEFINE l_dzfq016  LIKE dzfq_t.dzfq016   #樹狀結構類別

   LET l_chk = FALSE

   CALL adzp168_prog_class()   #例外檢查的程式類型(假雙檔:JiaShuangDang)

   #Table設定
   LET l_cnt = g_tbtree.getLength()
   IF l_cnt < 2 THEN
      LET l_chk = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00821"   #請先完成欄位設定   #160329-00027#1
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      CALL cl_err()
   ELSE
      LET l_chk = TRUE

      #F003_00 2013/05/08需要有單身資料表,目前談定的規格：假雙檔的作業都會含有查詢方案。至於未來是否會出現不含查詢方案的假雙檔可以再談
      #必為雙檔，日後子程式才可能會是假雙檔
      #2013/05/20 Saki,HJ: F003_00開放假雙檔
      #IF l_chk AND g_4fd_inf.form_vbm_idx > 0 AND g_4fd_inf.form_vbd_idx > 0 AND g_4fd_inf.form_browse_idx = 0 AND g_4fd_inf.l_jiashuangdang THEN
      #      LET l_chk = FALSE
      #      FOR l_i = 2 TO l_cnt
      #         IF g_tbtree[l_i].b_level = 2 THEN
      #            LET l_chk = TRUE
      #            EXIT FOR
      #         END IF
      #      END FOR
      #
      #      IF NOT l_chk THEN
      #         CALL cl_err_msg(NULL, "adz-00054", "", 0)   #需要有單身資料表
      #      END IF
      #END IF

      #子程式不支援假雙檔
      IF l_chk AND g_dzfq_m.dzfq005 = "S" AND g_4fd_inf.l_jiashuangdang THEN   #子程式0812
         LET l_chk = FALSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  "adz-00155"
         LET g_errparam.extend = NULL
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF

      #F003 + Tree 需要有單身資料表
      IF l_chk AND g_4fd_inf.form_vbm_idx > 0 AND g_4fd_inf.form_vbd_idx > 0 AND g_4fd_inf.form_browse_idx > 0 THEN
         IF g_form_tree[g_4fd_inf.form_browse_idx].dzfr006 = "Tree" THEN
            LET l_chk = FALSE
            FOR l_i = 2 TO l_cnt
               IF g_tbtree[l_i].b_level = 2 THEN
                  LET l_chk = TRUE
                  EXIT FOR
               END IF
            END FOR

            IF NOT l_chk THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  "adz-00054"
               LET g_errparam.extend = NULL
               LET g_errparam.popup = TRUE
               CALL cl_err()
            END IF
         END IF
      END IF

   END IF

   #資料表要有使用欄位
   IF l_chk THEN
      FOR l_i = 2 TO g_tbtree.getLength()
         SELECT COUNT(dzfr010) INTO l_cnt FROM adzp168t1
            WHERE dzfr009 = g_tbtree[l_i].b_tableid AND dzfr010 IS NOT NULL

         IF l_cnt = 0 THEN
            LET l_chk = FALSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00063"
            LET g_errparam.extend = NULL
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] =  g_tbtree[l_i].b_tableid
            CALL cl_err()
            EXIT FOR
         END IF
      END FOR
   END IF

   #該加欄位的容器是否都有欄位(單身凍結vb_detailexp不檢查)
   IF l_chk THEN   #瀏覽表
      IF g_4fd_inf.form_browse_idx > 0 THEN
         CALL adzp168_have_col(g_4fd_inf.form_browse_idx) RETURNING l_chk
      END IF
   END IF
   IF l_chk THEN   #單頭
      IF g_4fd_inf.form_vbm_idx > 0 THEN
         CALL adzp168_have_col(g_4fd_inf.form_vbm_idx) RETURNING l_chk
      END IF
   END IF
   IF l_chk THEN   #單身
      IF g_4fd_inf.form_vbd_idx > 0 THEN
         CALL adzp168_have_col(g_4fd_inf.form_vbd_idx) RETURNING l_chk
      END IF
   END IF
   IF l_chk THEN   #單頭固定區塊
      IF g_4fd_inf.form_vbhl_idx > 0 THEN
         CALL adzp168_have_col(g_4fd_inf.form_vbhl_idx) RETURNING l_chk
      END IF
   END IF

   #IF l_chk THEN
      #檢查browser PK和Master的是否一致
      #有需要加入欄位的Tree,則需要檢查PK和Master的是否一致
      #已在adzp168_have_pk()#資料瀏覽區塊:檢查主Table
   #END IF

   #是否根節點底下都有設PK
   IF l_chk AND (NOT adzp168_notchk()) THEN
      CALL adzp168_have_pk() RETURNING l_chk
   END IF

   #level 1 Table的PK必須設在Master,browser,Tree,Table; 假雙檔則Detail也會有


   #檢查是否需要設Tree的相關設定
   IF l_chk AND g_dzfq_m.cbo_progtype = "F" THEN
      LET g_sql = "SELECT dzfr007 FROM adzp168t1 WHERE dzfr006 = 'Tree'"
      PREPARE adzp168_tree_dzfr007 FROM g_sql
      DECLARE adzp168_tree_dzfr007_cur CURSOR FOR  adzp168_tree_dzfr007
      FOREACH adzp168_tree_dzfr007_cur INTO l_dzfr007
         SELECT COUNT(dzff004) INTO l_cnt FROM adzp168t3
            WHERE dzff003 = l_dzfr007
              AND dzff005 IN ('id')
              AND dzff006 IS NOT NULL
              AND dzff007 IS NOT NULL
          IF l_cnt = 0 THEN
             LET l_chk = FALSE
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code =  "adz-00021"
             LET g_errparam.extend = NULL
             LET g_errparam.popup = TRUE
             LET g_errparam.replace[1] =  l_dzfr007 CLIPPED
             CALL cl_err()
             EXIT FOREACH
          ELSE
             #SELECT DISTINCT dzff009 INTO l_dzff009 FROM adzp168t3
             #   WHERE dzff003 = l_dzfr007

             CALL sadzp168_1_dzff_chk(FALSE,l_dzfr007,g_dzfq_m.dzfq016) RETURNING l_chk
          END IF
      END FOREACH
   END IF

   IF (NOT adzp168_notchk()) THEN
      #檢查畫面結構中若大於一組共用欄位(Ex. 單頭單身皆有共用欄位在畫面上)，則出現提示訊息，告知一組以外的共用欄位預設值必須自行撰寫
      LET g_sql = "SELECT dzfr009 FROM adzp168t2 WHERE dzeb022 IN (",g_cdfCommon_sql CLIPPED,")",
                  " GROUP BY dzfr009"
      PREPARE adzp168_gen_4fd_chk_com01 FROM g_sql
      DECLARE adzp168_gen_4fd_chk_com_cur01 CURSOR FOR adzp168_gen_4fd_chk_com01

      LET l_i = 1
      LET l_msg = NULL
      CALL l_form_col.clear()
      FOREACH adzp168_gen_4fd_chk_com_cur01 INTO l_form_col[l_i].dzfr009
            IF cl_null(l_msg) THEN
               LET l_msg = l_form_col[l_i].dzfr009 CLIPPED
            ELSE
               LET l_msg = l_msg CLIPPED,",",l_form_col[l_i].dzfr009 CLIPPED
            END IF

         LET l_i = l_i + 1
      END FOREACH
      CALL l_form_col.deleteElement(l_i)
      LET l_cnt = l_form_col.getLength()
      IF l_cnt > 1 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  "adz-00151"
         LET g_errparam.extend = NULL
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] =  l_msg
         CALL cl_err()
      END IF
   END IF

   RETURN l_chk
END FUNCTION


#+ 是否有設PK
PRIVATE FUNCTION adzp168_have_pk()
   DEFINE p_area_idx      LIKE type_t.num5      #區塊index
   DEFINE l_area_idx      LIKE type_t.num5      #區塊index
   DEFINE l_chk           BOOLEAN
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_pk_cnt        LIKE type_t.num5
   DEFINE l_pk_cnt2       LIKE type_t.num5
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_j             LIKE type_t.num5
   DEFINE l_k             LIKE type_t.num5
   DEFINE l_pk_i          LIKE type_t.num5
   DEFINE l_form_tree_len LIKE type_t.num5
   DEFINE l_msg           STRING
   DEFINE l_msg1          STRING
   DEFINE l_msg2          STRING
   DEFINE l_str           STRING
   DEFINE l_rootid        STRING
   DEFINE l_root_idx      LIKE type_t.num5
   DEFINE l_4fd_tag       LIKE dzfr_t.dzfr006   #可以放欄位的4fd tag
   DEFINE l_ct_idx        LIKE type_t.num5      #Container節點index
   DEFINE l_tbtree_f_idx  LIKE type_t.num5      #外來鍵資料表index
   DEFINE l_dzed004       LIKE dzed_t.dzed004   #鍵值欄位
   TYPE type_l_pk RECORD                #記錄各PK
      dzeb001   LIKE dzeb_t.dzeb001,            #table代號
      dzeb002   LIKE dzeb_t.dzeb002,            #欄位代號
      dzeb022   LIKE dzeb_t.dzeb022,
      l_area    LIKE dzfr_t.dzfr007             #使用區塊
      END RECORD
   DEFINE l_pk_01         DYNAMIC ARRAY OF type_l_pk
   DEFINE l_pk_main       DYNAMIC ARRAY OF type_l_pk   #主資料表PK
   DEFINE l_tok           base.StringTokenizer
   DEFINE l_tmp           STRING
   DEFINE l_form_col      type_g_form_col


   LET l_chk = TRUE
   LET l_msg = NULL
   LET l_msg1 = NULL
   LET l_msg2 = NULL

   #主資料表PK
   CALL l_pk_main.clear()
   LET l_cnt = 1
   LET l_i = 2
   FOREACH adzp168_col_pk_cur1 USING g_tbtree[l_i].b_tableid INTO l_pk_main[l_cnt].dzeb002,l_pk_main[l_cnt].dzeb022
      LET l_pk_main[l_cnt].dzeb001 = g_tbtree[l_i].b_tableid CLIPPED
      LET l_pk_main[l_cnt].l_area = NULL
      LET l_cnt = l_cnt + 1
   END FOREACH
   CALL l_pk_main.deleteElement(l_cnt)

   LET l_cnt = l_pk_main.getLength()
   IF l_cnt > 0 THEN
      IF cl_null(l_pk_main[l_cnt].dzeb002) THEN
         CALL l_pk_main.deleteElement(l_cnt)
         LET l_cnt = l_pk_main.getLength()
      END IF
   END IF
   IF l_cnt = 0 THEN
      LET l_chk = FALSE
      #LET l_msg = g_tbtree[l_i].b_tableid CLIPPED,"| "
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00020"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = g_tbtree[l_i].b_tableid
      LET g_errparam.replace[2] = ""
      CALL cl_err()
   END IF

   LET g_sql = "SELECT dzfr010 FROM adzp168t2 WHERE rootarea = ? AND dzfr009 = ? AND dzeb004 = 'Y'"
   PREPARE adzp168_have_pk_area_pre FROM g_sql
   DECLARE adzp168_have_pk_area_cur CURSOR FOR adzp168_have_pk_area_pre
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'PREPARE have_pk_area:'
      LET g_errparam.popup = FALSE
      CALL cl_err()
   END IF

   LET g_sql = "SELECT COUNT(dzfr010) FROM adzp168t2 WHERE rootarea = ? AND dzfr010 = ? AND dzeb004 = 'Y'"
   PREPARE adzp168_have_pk_cnt_area_pre01 FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'PREPARE have_pk_cnt_area:'
      LET g_errparam.popup = FALSE
      CALL cl_err()
   END IF

   LET g_sql = "SELECT COUNT(dzfr010) FROM adzp168t2 WHERE dzfr009 = ? AND dzfr010 = ?"
   PREPARE adzp168_have_pk_cnt_area_pre02 FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'PREPARE have_pk_cnt_area:'
      LET g_errparam.popup = FALSE
      CALL cl_err()
   END IF

   LET g_sql = "SELECT COUNT(dzfr010) FROM adzp168t2 WHERE cont_tagname = ? AND dzfr009 = ? AND dzfr010 = ?"
   PREPARE adzp168_have_pk_cnt_area_pre03 FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'PREPARE have_pk_cnt_area:'
      LET g_errparam.popup = FALSE
      CALL cl_err()
   END IF

   LET g_sql = "SELECT COUNT(dzfr010) FROM adzp168t2 WHERE rootarea = ? AND dzfr009 = ? AND dzfr010 = ? AND dzeb004 = 'Y'"
   PREPARE adzp168_have_pk_area_pre04 FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'PREPARE have_pk_area:'
      LET g_errparam.popup = FALSE
      CALL cl_err()
   END IF


   IF l_chk THEN
      #主要區塊使用的主資料表PK, ex.假雙檔的單頭,單檔多欄的單身
      CASE
         WHEN g_4fd_inf.form_vbm_idx > 0    #單頭
            LET l_area_idx = g_4fd_inf.form_vbm_idx
         WHEN g_4fd_inf.form_vbd_idx > 0    #單身
            LET l_area_idx = g_4fd_inf.form_vbd_idx
      END CASE

      LET l_form_col.rootarea = g_form_tree[l_area_idx].dzfr007 CLIPPED

      LET l_cnt = l_pk_main.getLength()
      LET l_i = 2
      LET l_form_col.dzfr009 = g_tbtree[l_i].b_tableid CLIPPED
      FOREACH adzp168_have_pk_area_cur USING l_form_col.rootarea,l_form_col.dzfr009 INTO l_form_col.dzfr010
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'sel have_pk_area:'
            LET g_errparam.popup = FALSE
            CALL cl_err()
            EXIT FOREACH
         END IF

         FOR l_j = 1 TO l_cnt
            IF l_pk_main[l_j].dzeb001 = l_form_col.dzfr009 AND l_pk_main[l_j].dzeb002 = l_form_col.dzfr010 THEN
               LET l_pk_main[l_j].l_area = l_form_col.rootarea CLIPPED
            END IF
         END FOR
      END FOREACH

      #主資料表PK都要使用,cdfSite可拉到畫面,但非必選
      LET l_msg1 = NULL
      FOR l_j = 1 TO l_cnt
         IF l_pk_main[l_j].dzeb022 <> "cdfSite" THEN   #cdfSite可拉到畫面,但非必選
            LET l_form_col.dzfr009 = l_pk_main[l_j].dzeb001 CLIPPED
            LET l_form_col.dzfr010 = l_pk_main[l_j].dzeb002 CLIPPED

            EXECUTE adzp168_have_pk_cnt_area_pre02 USING l_form_col.dzfr009,l_form_col.dzfr010 INTO l_pk_cnt
            IF l_pk_cnt = 0 THEN
               IF cl_null(l_msg1) THEN
                  LET l_msg1 = l_pk_main[l_j].dzeb002 CLIPPED
               ELSE
                  LET l_msg1 = l_msg1 CLIPPED,", ",l_pk_main[l_j].dzeb002 CLIPPED
               END IF
            END IF
         END IF
      END FOR
      IF NOT cl_null(l_msg1) THEN
         LET l_chk = FALSE
         LET l_msg1 = "Primary Key:",l_msg1
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  "adz-00017"
         LET g_errparam.extend = NULL
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] =  l_msg1
         CALL cl_err()
      END IF


      #資料瀏覽區塊:檢查主Table
      IF l_chk AND g_4fd_inf.form_browse_idx > 0 THEN
         LET l_msg1 = NULL
         LET l_area_idx = g_4fd_inf.form_browse_idx
         LET l_form_col.rootarea = g_form_tree[l_area_idx].dzfr007 CLIPPED
         LET l_cnt = l_pk_main.getLength()
         FOR l_j = 1 TO l_cnt
            IF NOT cl_null(l_pk_main[l_j].l_area) THEN
               LET l_form_col.dzfr010 = l_pk_main[l_j].dzeb002 CLIPPED
               EXECUTE adzp168_have_pk_cnt_area_pre01 USING l_form_col.rootarea,l_form_col.dzfr010 INTO l_pk_cnt
               IF l_pk_cnt = 0 THEN
                  IF cl_null(l_msg1) THEN
                     LET l_msg1 = l_pk_main[l_j].dzeb002 CLIPPED
                  ELSE
                     LET l_msg1 = l_msg1 CLIPPED,", ",l_pk_main[l_j].dzeb002 CLIPPED
                  END IF
               END IF
            END IF
         END FOR
         IF NOT cl_null(l_msg1) THEN
            LET l_chk = FALSE
            #LET l_msg = g_form_tree[l_area_idx].b_show CLIPPED,"|",l_msg1 CLIPPED
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00020"
            LET g_errparam.extend = NULL
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = g_form_tree[l_area_idx].b_show
            LET g_errparam.replace[2] = l_msg1
            CALL cl_err()
         END IF
      END IF

      #單頭
      #單頭固定區塊等到檢查單頭時，再一起檢查
      IF l_chk AND g_4fd_inf.form_vbm_idx > 0 AND g_4fd_inf.l_jiashuangdang = FALSE AND l_area_idx <> g_4fd_inf.form_vbhl_idx THEN
         LET l_msg1 = NULL
         LET l_area_idx = g_4fd_inf.form_vbm_idx
         LET l_form_col.rootarea = g_form_tree[l_area_idx].dzfr007 CLIPPED
         LET l_cnt = l_pk_main.getLength()
         FOR l_j = 1 TO l_cnt
            IF l_pk_main[l_j].dzeb022 <> "cdfSite" THEN   #cdfSite可拉到畫面,但非必選
               LET l_form_col.dzfr010 = l_pk_main[l_j].dzeb002 CLIPPED
               EXECUTE adzp168_have_pk_cnt_area_pre01 USING l_form_col.rootarea,l_form_col.dzfr010 INTO l_pk_cnt

               IF g_4fd_inf.form_vbhl_idx > 0 THEN
                  LET l_str = l_form_col.rootarea            #備份vb_master的
                  LET l_form_col.rootarea = g_form_tree[g_4fd_inf.form_vbhl_idx].dzfr007 CLIPPED
                  EXECUTE adzp168_have_pk_cnt_area_pre01 USING l_form_col.rootarea,l_form_col.dzfr010 INTO l_pk_cnt2
                  LET l_form_col.rootarea = l_str CLIPPED    #還原vb_master的
                  LET l_pk_cnt = l_pk_cnt + l_pk_cnt2        #vb_master + vb_headerlock
               END IF

               IF l_pk_cnt = 0 THEN
                  IF cl_null(l_msg1) THEN
                     LET l_msg1 = l_pk_main[l_j].dzeb002 CLIPPED
                  ELSE
                     LET l_msg1 = l_msg1 CLIPPED,", ",l_pk_main[l_j].dzeb002 CLIPPED
                  END IF
               END IF
            END IF
         END FOR
         IF NOT cl_null(l_msg1) THEN
            LET l_chk = FALSE
            #LET l_msg = g_form_tree[l_area_idx].b_show CLIPPED,"|",l_msg1 CLIPPED
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00020"
            LET g_errparam.extend = NULL
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] = g_form_tree[l_area_idx].b_show
            LET g_errparam.replace[2] = l_msg1
            CALL cl_err()
         END IF
      END IF

      #單身
      IF l_chk AND g_4fd_inf.form_vbd_idx > 0 THEN
         #cdfSite可拉到畫面,但非必選
         LET l_area_idx = g_4fd_inf.form_vbd_idx
         LET l_form_col.rootarea = g_form_tree[l_area_idx].dzfr007 CLIPPED
         LET l_form_tree_len = g_form_tree.getLength()
         #LET l_j = g_tbtree.getLength()
         FOR l_k = l_area_idx TO l_form_tree_len
            CALL adzp168_form_tree_root_idx(l_k) RETURNING l_root_idx
            IF l_root_idx = l_area_idx THEN
               IF g_form_tree[l_k].dzfr006 = g_dzfq_m.dzfq010 THEN   #單身框架(Table/ScrollGrid)
                  LET l_msg1 = NULL
                  LET l_form_col.cont_tagname = g_form_tree[l_k].dzfr007      #4fd tag name: for container
                  LET l_form_col.dzfr009 = g_form_tree[l_k].dzfr009 CLIPPED   #資料表代碼
                  #PK是否完整
                  CALL l_pk_01.clear()
                  LET l_pk_i = 1
                  CALL adzp168_tbtree_pkfrom_idx(l_form_col.dzfr009) RETURNING l_tbtree_f_idx   #外來鍵資料表index
                  IF l_tbtree_f_idx > 0 THEN
                     FOREACH adzp168_col_pk_cur1 USING l_form_col.dzfr009 INTO l_pk_01[l_pk_i].dzeb002,l_pk_01[l_pk_i].dzeb022
                        LET l_pk_01[l_pk_i].dzeb001 = l_form_col.dzfr009 CLIPPED
                        #IF l_form_col.dzfr009 <> l_pk_main[1].dzeb001 THEN   #非使用主資料表,排除FK來自主Table
                        IF l_form_col.dzfr009 <> g_tbtree[l_tbtree_f_idx].b_tableid THEN   #非使用主資料表,排除FK來自外來鍵資料表
                           #排除FK來自主Table的欄位- 非單檔多欄
                           #FOREACH adzp168_col_pkfkcur_2 USING l_pk_01[l_pk_i].dzeb001,'F',l_pk_main[1].dzeb001 INTO l_dzed004
                           FOREACH adzp168_col_pkfkcur_2 USING l_pk_01[l_pk_i].dzeb001,'F',g_tbtree[l_tbtree_f_idx].b_tableid INTO l_dzed004
                              LET l_str = l_dzed004 CLIPPED
                              LET l_tok = base.StringTokenizer.createExt(l_str CLIPPED,",","",TRUE)	#指定分隔符號
                              WHILE l_tok.hasMoreTokens()	#依序取得子字串
                                 LET l_tmp = l_tok.nextToken()
                                 LET l_tmp = l_tmp.trim()

                                 IF l_tmp = l_pk_01[l_pk_i].dzeb002 THEN
                                    CALL l_pk_01.deleteElement(l_pk_i)
                                    EXIT WHILE
                                 END IF
                              END WHILE
                           END FOREACH
                        END IF

                        LET l_cnt = l_pk_01.getLength()
                        LET l_pk_i = l_cnt + 1
                     END FOREACH
                  END IF
                  CALL l_pk_01.deleteElement(l_pk_i)

                  #檢查單身是否有PK,例如假雙檔不可把PK都放單頭沒放單身
                  IF l_chk THEN
                     SELECT COUNT(*) INTO l_cnt FROM adzp168t2
                        WHERE cont_tagname = l_form_col.cont_tagname AND dzeb004 = 'Y'
                     IF l_cnt = 0 THEN
                        LET l_chk = FALSE
                        #LET l_msg = l_form_col.cont_tagname CLIPPED,"| "
                        INITIALIZE g_errparam TO NULL
                        LET g_errparam.code =  "adz-00020"
                        LET g_errparam.extend = NULL
                        LET g_errparam.popup = TRUE
                        LET g_errparam.replace[1] = l_form_col.cont_tagname
                        LET g_errparam.replace[2] = ""
                        CALL cl_err()
                     END IF
                  END IF

                  #檢查單身PK是否有完全使用
                  IF l_chk THEN
                     #假雙檔要排除使用於單頭的pk
                     IF g_4fd_inf.l_jiashuangdang = TRUE THEN
                        LET l_cnt = l_pk_01.getLength()
                        IF l_cnt > 0  THEN
                           FOR l_pk_i = l_cnt TO 1 STEP -1
                              FOR l_j = 1 TO l_pk_main.getLength()
                                 IF l_pk_01[l_pk_i].dzeb002 = l_pk_main[l_j].dzeb002 AND (NOT cl_null(l_pk_main[l_j].l_area)) THEN
                                    CALL l_pk_01.deleteElement(l_pk_i)
                                 END IF
                              END FOR
                           END FOR
                        END IF
                     END IF

                     #檢查單身PK是否有完全使用
                     LET l_cnt = l_pk_01.getLength()
                     IF l_cnt > 0 THEN
                        FOR l_j = 1 TO l_cnt
                           IF l_pk_01[l_j].dzeb022 <> "cdfSite" THEN   #cdfSite可拉到畫面,但非必選
                              LET l_pk_cnt = 0
                              LET l_form_col.dzfr009 = l_pk_01[l_j].dzeb001
                              LET l_form_col.dzfr010 = l_pk_01[l_j].dzeb002
                              EXECUTE adzp168_have_pk_cnt_area_pre03 USING l_form_col.cont_tagname,l_form_col.dzfr009,l_form_col.dzfr010 INTO l_pk_cnt
                              IF l_pk_cnt = 0 THEN
                                 IF cl_null(l_msg1) THEN
                                    LET l_msg1 = l_pk_01[l_j].dzeb002 CLIPPED
                                 ELSE
                                    LET l_msg1 = l_msg1 CLIPPED,", ",l_pk_01[l_j].dzeb002 CLIPPED
                                 END IF
                              END IF
                           END IF
                        END FOR

                        IF NOT cl_null(l_msg1) THEN
                           LET l_chk = FALSE
                           #LET l_msg = l_form_col.cont_tagname CLIPPED,"|",l_msg1 CLIPPED
                           INITIALIZE g_errparam TO NULL
                           LET g_errparam.code =  "adz-00020"
                           LET g_errparam.extend = NULL
                           LET g_errparam.popup = TRUE
                           LET g_errparam.replace[1] = l_form_col.cont_tagname
                           LET g_errparam.replace[2] = l_msg1
                           CALL cl_err()
                           EXIT FOR
                        END IF
                     END IF
                  END IF

               END IF    #單身框架(Table/ScrollGrid)
            ELSE
               EXIT FOR
            END IF
         END FOR
         #LET l_i = 2
         #LET l_form_col.dzfr009 = g_tbtree[l_i].b_tableid CLIPPED
      END IF

   END IF

   RETURN l_chk
END FUNCTION


#+ 該加欄位的容器是否都有欄位
PRIVATE FUNCTION adzp168_have_col(p_area_idx)
   DEFINE p_area_idx     LIKE type_t.num5      #區塊index  ex.瀏覽表,單頭,單身
   DEFINE l_chk          BOOLEAN
   DEFINE l_cnt          LIKE type_t.num5
   DEFINE l_i            LIKE type_t.num5
   DEFINE l_msg          STRING
   DEFINE l_msg1         STRING
   DEFINE l_msg2         STRING
   DEFINE l_str          STRING
   DEFINE l_rootid       STRING
   DEFINE l_4fd_tag      LIKE dzfr_t.dzfr006   #可以放欄位的4fd tag
   DEFINE l_ct_idx       LIKE type_t.num5      #Container節點index
   DEFINE l_cont_tagname VARCHAR(40)              #4fd tag name: for container

   LET l_chk = TRUE
   LET l_msg = NULL
   LET l_msg1 = NULL
   LET l_msg2 = NULL
   LET l_cnt = 1

   IF p_area_idx <= 0 THEN
      RETURN FALSE
   END IF

   LET l_rootid = g_form_tree[p_area_idx].b_id CLIPPED || "."
   LET l_4fd_tag = g_form_tree[p_area_idx].dzfr006

   #資料瀏覽區塊


   #單頭固定區塊
   IF p_area_idx = g_4fd_inf.form_vbhl_idx THEN
      #可以放欄位的4fd tag
      LET l_4fd_tag = "Group"
   END IF

   #單頭
   IF p_area_idx = g_4fd_inf.form_vbm_idx THEN
      #可以放欄位的4fd tag
      IF g_dzfq_m.dzfq007 = "Folder" THEN  #單頭框架(Folder/Group/Grid)
         LET l_4fd_tag = "Page"
      ELSE
         LET l_4fd_tag = g_dzfq_m.dzfq007
      END IF
   END IF

   #單身
   IF p_area_idx = g_4fd_inf.form_vbd_idx THEN
      LET l_4fd_tag = g_dzfq_m.dzfq010   #單身框架(Table/ScrollGrid)
      #IF l_4fd_tag = "ScrollGrid" THEN
      #   LET l_4fd_tag = "row"
      #END IF
   END IF


   LET g_sql = "SELECT COUNT(*) FROM adzp168t2 WHERE cont_tagname = ?"
   PREPARE adzp168t2_cnt_pre01 FROM g_sql

   LET l_msg = NULL
   FOR l_i = p_area_idx TO g_form_tree.getLength()
      LET l_str = g_form_tree[l_i].b_id
      IF (l_i = p_area_idx) OR (l_str.getIndexOf(l_rootid,1) = 1) THEN
         IF g_form_tree[l_i].dzfr006 = l_4fd_tag THEN
            LET l_cnt = 0
            LET l_cont_tagname = g_form_tree[l_i].dzfr007 CLIPPED
            EXECUTE adzp168t2_cnt_pre01 USING l_cont_tagname INTO l_cnt
            IF l_cnt = 0 THEN
               LET l_chk = FALSE
               LET l_msg = g_form_tree[l_i].b_show
               EXIT FOR
            END IF
         END IF
      END IF
   END FOR

   IF NOT l_chk THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00015"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] =  l_msg CLIPPED
      CALL cl_err()
   END IF

   #IF p_area_idx > 0 THEN
   #   LET l_ct_idx = 0
   #   LET l_cnt = 0
   #   LET l_msg = NULL
   #   FOR l_i = p_area_idx TO g_form_tree.getLength()
   #      LET l_str = g_form_tree[l_i].b_id
   #      IF l_str.getIndexOf(l_rootid,1) = 1 THEN
   #         IF g_form_tree[l_i].dzfr006 = l_4fd_tag THEN
   #            #多個容器
   #            IF l_ct_idx > 0 AND l_cnt = 0 THEN   #找下一個容器,先檢查上一個的欄位數量
   #               LET l_chk = FALSE
   #               LET l_msg = g_form_tree[l_ct_idx].b_show
   #               EXIT FOR
   #            END IF
   #            LET l_ct_idx = l_i
   #            LET l_cnt = 0
   #         ELSE
   #            IF g_form_tree[l_i].dzfr006 = "Field" THEN
   #               LET l_cnt = l_cnt + 1
   #            END IF
   #         END IF
   #      ELSE
   #         IF l_i <> p_area_idx THEN
   #            EXIT FOR
   #         END IF
   #      END IF
   #   END FOR
   #
   #   #一個容器
   #   IF cl_null(l_msg) AND l_cnt = 0 THEN
   #      LET l_chk = FALSE
   #      IF l_ct_idx > 0 THEN
   #         LET l_msg = g_form_tree[l_ct_idx].b_show
   #      ELSE
   #         LET l_msg = g_form_tree[p_area_idx].b_show   #ex. 瀏覽表是root,沒欄位不會找到l_ct_idx
   #      END IF
   #   END IF
   #
   #   IF NOT l_chk THEN
   #      CALL cl_err_msg(NULL, "adz-00015", l_msg CLIPPED, 0)
   #   END IF
   #END IF

   RETURN l_chk
END FUNCTION




#+ 程式資料表設定
PRIVATE FUNCTION adzp168_dzag(p_real)
   DEFINE p_real        LIKE type_t.chr1      #是否為正式資料 Y/N
   DEFINE l_chk         BOOLEAN
   DEFINE l_cnt         LIKE type_t.num5
   DEFINE l_i           LIKE type_t.num5
   DEFINE l_j           LIKE type_t.num5
   DEFINE l_dzag        RECORD LIKE dzag_t.*
   DEFINE l_gzca001     LIKE gzca_t.gzca001   #狀態碼類別
   DEFINE l_gzcb002     LIKE gzcb_t.gzcb002   #狀態碼
   DEFINE l_tabletype   LIKE dzea_t.dzea004   #表格型態

   LET l_chk = TRUE

   IF g_tbtree.getLength() > 0 THEN
      IF l_chk THEN
         LET l_dzag.dzag001 = g_dzfq_m.dzfq004         #程式代號
         LET l_dzag.dzag003 = g_ver_dzag003            #識別碼版次
         LET l_dzag.dzag011 = ms_cust                  #客戶代號

         IF p_real = "Y" THEN   #正式資料
            #檢查相符合程式資料表設計資料是否已存在
            EXECUTE adzp168_dzag_cnt_pre USING l_dzag.dzag001,l_dzag.dzag003,ms_dgenv INTO l_cnt
            IF SQLCA.sqlcode THEN
               LET l_chk = FALSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'sel cnt:'
               LET g_errparam.popup = FALSE
               CALL cl_err()
            END IF

            IF l_cnt > 0 THEN
               #刪除相關資料
               EXECUTE adzp168_dzag_del_pre USING l_dzag.dzag001,l_dzag.dzag003,ms_dgenv
               IF SQLCA.sqlcode THEN
                  LET l_chk = FALSE
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = 'del:'
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
               END IF
            END IF
         END IF
      END IF

      IF l_chk THEN
         #新增程式資料表設定
         LET l_cnt = g_tbtree.getLength()
         FOR l_i = 2 TO l_cnt   #排除[1]虛擬root
            LET l_dzag.dzag002 = g_tbtree[l_i].b_tableid CLIPPED  #資料表代號
            LET l_dzag.dzag004 = NULL          #上層資料表
            IF g_tbtree[l_i].b_level > 1 THEN  #需要找上層資料表
               FOR l_j = l_i - 1 TO 1 STEP -1
                  IF g_tbtree[l_i].b_pid  = g_tbtree[l_j].b_id THEN
                     LET l_dzag.dzag004 = g_tbtree[l_j].b_tableid CLIPPED
                     EXIT FOR
                  END IF
               END FOR
            END IF

            #是否為主Table (第一個Table)
            IF l_i = 2 THEN
               LET l_dzag.dzag005 = "Y"
            ELSE
               LET l_dzag.dzag005 = "N"
            END IF

            LET l_dzag.dzag006 = ms_dgenv CLIPPED

            IF p_real = "Y" THEN   #正式資料
               #是否為單頭Table : Y/N
               LET l_dzag.dzag007 = "N"
               IF l_dzag.dzag005 = "Y" THEN
                  #2014/01/22
                  LET l_j = 0
                  SELECT COUNT(*) INTO l_j FROM adzp168t2
                     WHERE dzfr009 = l_dzag.dzag002 AND rootarea = 'vb_master'

                  IF l_j > 0 THEN
                     LET l_dzag.dzag007 = "Y"
                  END IF
               END IF

               EXECUTE adzp168_dzag_ins_pre USING l_dzag.dzag001,l_dzag.dzag002,l_dzag.dzag003,l_dzag.dzag004,l_dzag.dzag005,l_dzag.dzag006,l_dzag.dzag007,l_dzag.dzag011,ms_dgenv,
                                                  g_dzfq_m.dzfqmodid,g_dzfq_m.dzfqmoddt,g_dzfq_m.dzfqownid,g_dzfq_m.dzfqowndp,g_dzfq_m.dzfqcrtid,g_dzfq_m.dzfqcrtdp,g_dzfq_m.dzfqcrtdt,g_dzfq_m.dzfqstus
            ELSE   #底稿
               #新增程式資料表設定底稿
               LET g_sql = "INSERT INTO dzfx_t (dzfx001,dzfx002,dzfx003,dzfx004,dzfx005)",
                           " VALUES(?,?,?,?,?)"
               PREPARE adzp168_dzfx_ins_pre FROM g_sql
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = 'PREPARE ins:'
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
               END IF

               EXECUTE adzp168_dzfx_ins_pre USING g_ver_ra,g_dzfq_m.dzfqownid,
                                                  l_dzag.dzag001,l_dzag.dzag002,l_dzag.dzag004
            END IF
            IF SQLCA.sqlcode THEN
               LET l_chk = FALSE
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'ins:'
               LET g_errparam.popup = FALSE
               CALL cl_err()
               EXIT FOR
            END IF

         END FOR
      END IF
   END IF

   RETURN l_chk
END FUNCTION


#+ 刪除畫面結構包含子節點
PRIVATE FUNCTION adzp168_form_tree_del_area(p_idx)
   DEFINE p_idx        LIKE type_t.num10   #要刪除的節點index
   DEFINE l_idx        LIKE type_t.num10   #要刪除的節點index
   DEFINE l_cnt        LIKE type_t.num10
   DEFINE l_str        STRING
   DEFINE l_rootid     STRING
   DEFINE l_i          LIKE type_t.num10
   DEFINE l_k          LIKE type_t.num10
   DEFINE l_tree_cnt   LIKE type_t.num10
   DEFINE l_ln         LIKE type_t.num5

   #CALL adzp168_form_tree_root_idx(g_ftree_idx) RETURNING l_root_idx
   LET l_tree_cnt = g_form_tree.getLength()

   LET l_idx = p_idx

   #刪除節點後不可空留父節點
   CALL adzp168_form_stc(p_idx) RETURNING l_ln
   IF l_ln > 1 THEN
      CALL adzp168_form_tree_del_area_idx(p_idx) RETURNING l_idx  #是否從父節點往下刪除
   END IF

   #刪除節點
   EXECUTE adzp168_form_tree_del_dzfr003_pre USING g_form_tree[l_idx].dzfr003

   #刪除子節點
   LET l_rootid = g_form_tree[l_idx].b_id CLIPPED || "."   #1.2.
   FOR l_i = 1 TO l_tree_cnt
      LET l_str = g_form_tree[l_i].b_id   #1.2.3.1 或 1.2.3.1.1
      IF l_str.getIndexOf(l_rootid,1) = 1 THEN   #找到是"1.2."開頭的
         EXECUTE adzp168_form_tree_del_dzfr003_pre USING g_form_tree[l_i].dzfr003
      END IF
   END FOR

   #CALL adzp168_form_tree_fill("0",0,"0",FALSE)
   IF (l_idx - 1) > 0 THEN
      LET g_ftree_idx = l_idx - 1
   ELSE
      LET g_ftree_idx = 0
   END IF
END FUNCTION

#+ 是否從父節點往下刪除
PRIVATE FUNCTION adzp168_form_tree_del_area_idx(p_idx)
   DEFINE p_idx        LIKE type_t.num10   #要刪除的節點index
   DEFINE l_idx        LIKE type_t.num10   #要刪除的節點index
   DEFINE l_cnt        LIKE type_t.num10
   DEFINE l_str        STRING
   DEFINE l_rootid     STRING
   DEFINE l_i          LIKE type_t.num10
   DEFINE l_k          LIKE type_t.num10
   DEFINE l_tree_cnt   LIKE type_t.num10

   LET l_tree_cnt = g_form_tree.getLength()
   LET l_idx = p_idx

   #是否從父節點往下刪除
   IF g_form_tree[p_idx].dzfr006 <> "Field" THEN
      LET g_sql = "SELECT COUNT(dzfr003) FROM adzp168t1 WHERE dzfr004 = ?"
      PREPARE adzp168_form_tree_del_area_brother_cnt_pre FROM g_sql
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'PREPARE TMP COUNT:'
         LET g_errparam.popup = FALSE
         CALL cl_err()
      END IF
      EXECUTE adzp168_form_tree_del_area_brother_cnt_pre USING g_form_tree[p_idx].dzfr004 INTO l_cnt

      #只有自己,沒有同階層的兄弟,則要從父節點開始刪除
      IF l_cnt = 1 THEN
         FOR l_i = 1 TO l_tree_cnt
            IF g_form_tree[l_i].dzfr003 = g_form_tree[p_idx].dzfr004 AND g_form_tree[l_i].dzfr011 = "Y" THEN
               LET l_idx = l_i
               #再往上層找
               CALL adzp168_form_tree_del_area_idx(l_idx) RETURNING l_idx
               EXIT FOR
            END IF
         END FOR
      END IF
   END IF

   RETURN l_idx
END FUNCTION


#+ 加入單頭區塊
PRIVATE FUNCTION adzp168_form_add_master(p_area,p_ftree_idx,p_dzfq007,p_dzfr011)
   DEFINE p_area          LIKE dzfr_t.dzfr007   #加入區塊的4fd tag name   #vb_master,vb_detailexp
   DEFINE p_ftree_idx     LIKE type_t.num10
   DEFINE p_dzfq007       LIKE dzfq_t.dzfq007   #框架
   DEFINE p_dzfr011       LIKE dzfr_t.dzfr011   #是否可刪除
   DEFINE l_root_idx      LIKE type_t.num5      #focus的Root節點index
   DEFINE l_rootid        STRING
   DEFINE l_dzfr003       LIKE dzfr_t.dzfr003   #編號(流水號)
   DEFINE l_dzfr004       LIKE dzfr_t.dzfr004   #父節點編號
   DEFINE l_dzfr005       LIKE dzfr_t.dzfr005   #順序(同階層中的排序)
   DEFINE l_dzfr006       LIKE dzfr_t.dzfr006   #4fd tag 類型
   DEFINE l_dzfr007       LIKE dzfr_t.dzfr007   #4fd tag name
   DEFINE l_dzfr008       LIKE dzfr_t.dzfr008   #4fd tag name 編號
   DEFINE l_dzfr011       LIKE dzfr_t.dzfr011   #是否可刪除
   DEFINE l_dzfr012       LIKE dzfr_t.dzfr012   #4fd tag name前置名稱(s_detail/folder_/page_/page_info_/group_/Grid/HBox/VBox)
   DEFINE l_gzzd005       LIKE gzzd_t.gzzd005
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_str           STRING

   #CALL adzp168_form_tree_root_idx(p_ftree_idx) RETURNING l_root_idx
   #IF g_form_tree[l_root_idx].dzfr007 = p_area THEN
   CALL adzp168_form_add_container01(p_area,p_ftree_idx,p_dzfq007,NULL,NULL,p_dzfr011) RETURNING l_dzfr004,l_dzfr006
   IF l_dzfr004 > 0 THEN
      CALL adzp168_form_add_container02(p_area,p_ftree_idx,l_dzfr004,l_dzfr006,p_dzfr011) RETURNING l_dzfr004
      CALL adzp168_form_tree_fill("0",0,"0",FALSE)   #重整tree
   END IF
END FUNCTION


#+ 加入單身區塊
PRIVATE FUNCTION adzp168_form_add_detail(p_ftree_idx,p_dzfr011)
   DEFINE p_ftree_idx     LIKE type_t.num10
   DEFINE p_dzfr011       LIKE dzfr_t.dzfr011   #是否可刪除
   DEFINE l_ftree_idx     LIKE type_t.num10
   DEFINE l_root_idx      LIKE type_t.num5      #focus的Root節點index
   DEFINE l_rootid        STRING
   DEFINE l_dzfr003       LIKE dzfr_t.dzfr003   #編號(流水號)
   DEFINE l_dzfr004       LIKE dzfr_t.dzfr004   #父節點編號
   DEFINE l_dzfr005       LIKE dzfr_t.dzfr005   #順序(同階層中的排序)
   DEFINE l_dzfr006       LIKE dzfr_t.dzfr006   #4fd tag 類型
   DEFINE l_dzfr007       LIKE dzfr_t.dzfr007   #4fd tag name
   DEFINE l_dzfr008       LIKE dzfr_t.dzfr008   #4fd tag name 編號
   DEFINE l_dzfr011       LIKE dzfr_t.dzfr011   #是否可刪除
   DEFINE l_dzfr012       LIKE dzfr_t.dzfr012   #4fd tag name前置名稱
   DEFINE l_gzzd005       LIKE gzzd_t.gzzd005
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_ln            LIKE type_t.num5
   DEFINE l_dzfr007_p     LIKE dzfr_t.dzfr007   #父節點4fd tag name
   DEFINE l_str           STRING
   DEFINE l_chk           BOOLEAN


   CALL adzp168_form_tree_root_idx(p_ftree_idx) RETURNING l_root_idx

   LET l_chk = FALSE
   CALL adzp168_form_stc(p_ftree_idx) RETURNING l_ln

   IF l_ln > 0 THEN
      LET l_dzfr004 = NULL
      IF p_ftree_idx = l_root_idx THEN   #focus root
         LET l_chk = TRUE
         LET l_dzfr004 = g_form_tree[p_ftree_idx].dzfr003
      END IF

      FOR l_i = 1 TO l_ln
         IF l_chk THEN
            CALL adzp168t1_new_dzfr003() RETURNING l_dzfr003   #暫存檔編號(流水號) - for新增資料
            CALL adzp168t1_new_dzfr005(l_dzfr004) RETURNING l_dzfr005   #暫存檔順序(同階層中的排序) - for新增資料
            LET l_dzfr006 = g_form_stc[l_i].dzfr006 CLIPPED  #4fd tag 類型
            CALL adzp168t1_new_tagname(l_dzfr006) RETURNING l_dzfr007,l_dzfr012,l_dzfr008   #4fd tag name,4fd tag name前置名稱,4fd tag name 編號 - for新增資料

            IF NOT cl_null(p_dzfr011) THEN
               LET l_dzfr011 = p_dzfr011
            ELSE
               LET l_dzfr011 = "Y"
            END IF

            EXECUTE adzp168t1_ins USING l_dzfr003,l_dzfr004,l_dzfr005,l_dzfr006,l_dzfr007,l_dzfr008,'','',l_dzfr011,l_dzfr012,'','','','','',''
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'ins TEMP:'
               LET g_errparam.popup = FALSE
               CALL cl_err()
            ELSE
               LET l_dzfr004 = l_dzfr003
            END IF
         ELSE
            IF g_form_tree[p_ftree_idx].dzfr006 = g_form_stc[l_i].dzfr006 THEN
               LET l_chk = TRUE
               LET l_dzfr004 = g_form_tree[p_ftree_idx].dzfr003
            END IF
         END IF
      END FOR
   END IF

   IF l_chk THEN
      CALL adzp168_form_tree_fill("0",0,"0",FALSE)   #重整tree
   END IF

   RETURN l_dzfr003
END FUNCTION

#+ 加入狀態頁籤
PRIVATE FUNCTION adzp168_form_add_pageinfo(p_ftree_idx,p_dzfr011)
   #DEFINE p_area           LIKE dzfr_t.dzfr007   #加入區塊的4fd tag name   #vb_master,vb_detail,vb_detailexp
   DEFINE p_ftree_idx      LIKE type_t.num10
   #DEFINE p_container      LIKE dzfq_t.dzfq007   #框架=> 單頭框架:Folder/Group/Grid; 單身切割框架:sarray單一/Folder/HBox/VBox
   DEFINE p_dzfr011        LIKE dzfr_t.dzfr011   #是否可刪除
   DEFINE l_root_idx       LIKE type_t.num5      #focus的Root節點index
   DEFINE l_rootid         STRING
   DEFINE l_dzfr003_add    LIKE dzfr_t.dzfr003   #編號add
   DEFINE l_dzfr003_child  LIKE dzfr_t.dzfr003   #編號
   DEFINE l_dzfr003        LIKE dzfr_t.dzfr003   #編號(流水號)
   DEFINE l_dzfr004        LIKE dzfr_t.dzfr004   #父節點編號
   DEFINE l_dzfr005        LIKE dzfr_t.dzfr005   #順序(同階層中的排序)
   DEFINE l_dzfr006        LIKE dzfr_t.dzfr006   #4fd tag 類型
   DEFINE l_dzfr007        LIKE dzfr_t.dzfr007   #4fd tag name
   DEFINE l_dzfr008        LIKE dzfr_t.dzfr008   #4fd tag name 編號
   DEFINE l_dzfr011        LIKE dzfr_t.dzfr011   #是否可刪除
   DEFINE l_dzfr012        LIKE dzfr_t.dzfr012   #4fd tag name前置名稱(s_detail/folder_/page_/page_info_/group_/Grid/HBox/VBox)
   DEFINE l_gzzd005        LIKE gzzd_t.gzzd005
   DEFINE l_i              LIKE type_t.num5
   DEFINE l_ftree_cnt      LIKE type_t.num5
   DEFINE l_str            STRING
   DEFINE l_ftree_idx      LIKE type_t.num5

   IF g_dzfq_m.cbo_progtype = "F" THEN  #ex.Q類,P類不自動加入
      CALL adzp168_form_tree_root_idx(p_ftree_idx) RETURNING l_root_idx
      IF g_form_tree[p_ftree_idx].dzfr006 = "Folder" THEN
         LET l_dzfr004 = g_form_tree[p_ftree_idx].dzfr003
         LET l_dzfr006 = NULL   #4fd tag 類型
            CALL adzp168t1_new_dzfr003() RETURNING l_dzfr003   #暫存檔編號(流水號) - for新增資料
            CALL adzp168t1_new_dzfr005(g_form_tree[p_ftree_idx].dzfr003) RETURNING l_dzfr005   #暫存檔順序(同階層中的排序) - for新增資料

            #4fd tag 類型 - for新增資料
            LET l_dzfr006 = "Page"

            CALL adzp168t1_new_dzfr003() RETURNING l_dzfr003   #暫存檔編號(流水號) - for新增資料
            CALL adzp168t1_new_dzfr005(l_dzfr004) RETURNING l_dzfr005   #暫存檔順序(同階層中的排序) - for新增資料
            #CALL adzp168t1_new_tag_d1("Page") RETURNING l_dzfr006   #4fd tag 類型 - for新增資料
            CALL adzp168t1_new_tagname("page_info") RETURNING l_dzfr007,l_dzfr012,l_dzfr008   #4fd tag name,4fd tag name 編號 - for新增資料
            CALL adzp168_page_name(FALSE,g_dzfq_m.dzfq004,g_lang,l_dzfr007,ms_dgenv) RETURNING l_gzzd005

            IF NOT cl_null(p_dzfr011) THEN
               LET l_dzfr011 = p_dzfr011
            ELSE
               LET l_dzfr011 = "Y"
            END IF

            EXECUTE adzp168t1_ins USING l_dzfr003,l_dzfr004,l_dzfr005,l_dzfr006,l_dzfr007,l_dzfr008,'','',l_dzfr011,l_dzfr012,'','','',l_gzzd005,'',''
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'ins TEMP:'
               LET g_errparam.popup = FALSE
               CALL cl_err()
            ELSE
               LET l_dzfr003_add = l_dzfr003
               CALL adzp168_form_tree_fill("0",0,"0",FALSE)   #重整tree
               #單身在Page底下還要加節點
               IF g_form_tree[l_root_idx].dzfr007 = "vb_detail" THEN
                  LET l_ftree_cnt = g_form_tree.getLength()
                  FOR l_i = 1 TO l_ftree_cnt
                     IF g_form_tree[l_i].dzfr003 = l_dzfr003 THEN
                        LET l_ftree_idx = l_i
                        CALL adzp168_form_add_detail(l_ftree_idx,"Y") RETURNING l_dzfr003_child
                        EXIT FOR
                     END IF
                  END FOR
               END IF
            END IF
            #CALL test_debug()
      END IF
   END IF

   RETURN l_dzfr003_add,l_dzfr003_child
END FUNCTION


#+ 加入Container第一層
#PRIVATE FUNCTION adzp168_form_add_container01(p_area,p_ftree_idx,p_container,p_dzfr011)
PRIVATE FUNCTION adzp168_form_add_container01(p_area,p_ftree_idx,p_container,p_dzfr004,p_dzfr006,p_dzfr011)
   DEFINE p_area          LIKE dzfr_t.dzfr007   #加入區塊的4fd tag name   #vb_master,vb_detail,vb_detailexp
   DEFINE p_ftree_idx     LIKE type_t.num10
   DEFINE p_container     LIKE dzfq_t.dzfq007   #框架=> 單頭框架:Folder/Group/Grid; 單身切割框架:sarray單一/Folder/HBox/VBox
   DEFINE p_dzfr004       LIKE dzfr_t.dzfr004   #父節點編號
   DEFINE p_dzfr006       LIKE dzfr_t.dzfr006   #4fd tag 類型,是Folder才可以加Page
   DEFINE p_dzfr011       LIKE dzfr_t.dzfr011   #是否可刪除
   DEFINE l_root_idx      LIKE type_t.num5      #focus的Root節點index
   DEFINE l_rootid        STRING
   DEFINE l_dzfr003       LIKE dzfr_t.dzfr003   #編號(流水號)
   DEFINE l_dzfr004       LIKE dzfr_t.dzfr004   #父節點編號
   DEFINE l_dzfr005       LIKE dzfr_t.dzfr005   #順序(同階層中的排序)
   DEFINE l_dzfr006       LIKE dzfr_t.dzfr006   #4fd tag 類型
   DEFINE l_dzfr007       LIKE dzfr_t.dzfr007   #4fd tag name
   DEFINE l_dzfr008       LIKE dzfr_t.dzfr008   #4fd tag name 編號
   DEFINE l_dzfr011       LIKE dzfr_t.dzfr011   #是否可刪除
   DEFINE l_dzfr012       LIKE dzfr_t.dzfr012   #4fd tag name前置名稱(s_detail/folder_/page_/page_info_/group_/Grid/HBox/VBox)
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_str           STRING

   CALL adzp168_form_tree_root_idx(p_ftree_idx) RETURNING l_root_idx
   IF g_form_tree[l_root_idx].dzfr007 = p_area THEN
      IF NOT cl_null(p_dzfr004) THEN
         LET l_dzfr004 = p_dzfr004 CLIPPED
      ELSE
         LET l_dzfr004 = g_form_tree[p_ftree_idx].dzfr003
      END IF

      CALL adzp168t1_new_dzfr003() RETURNING l_dzfr003   #暫存檔編號(流水號) - for新增資料
      CALL adzp168t1_new_dzfr005(l_dzfr004) RETURNING l_dzfr005   #暫存檔順序(同階層中的排序) - for新增資料

      #4fd tag 類型 - for新增資料
      IF NOT cl_null(p_dzfr006) THEN
         LET l_dzfr006 = p_dzfr006 CLIPPED
      ELSE
         LET l_dzfr006 = NULL   #4fd tag 類型
         CASE
            WHEN p_area = "vb_master" OR p_area = "vb_detailexp" OR p_area = "vb_headerlock"
               CALL adzp168t1_new_tag_m(p_container) RETURNING l_dzfr006
            WHEN p_area = "vb_detail" #AND p_ftree_idx = l_root_idx
               CALL adzp168t1_new_tag_d1(p_container) RETURNING l_dzfr006
         END CASE
      END IF

      IF NOT cl_null(l_dzfr006) THEN
         #找編號給下階層當父節點編號
         IF p_ftree_idx <> l_root_idx THEN #AND (l_dzfr006 = "Folder" OR l_dzfr006 = "HBox" OR l_dzfr006 = "VBox")

            LET l_dzfr004 = g_form_tree[p_ftree_idx].dzfr003
            IF g_form_tree[p_ftree_idx].dzfr006 <> "Folder" THEN #下階層不可加page
            #IF l_dzfr006 <> "Folder" THEN #下階層不可加page
               LET l_dzfr006 = NULL
            END IF
         ELSE
            CALL adzp168t1_new_tagname(l_dzfr006) RETURNING l_dzfr007,l_dzfr012,l_dzfr008   #4fd tag name,4fd tag name 編號 - for新增資料

            IF NOT cl_null(p_dzfr011) THEN
               LET l_dzfr011 = p_dzfr011
            ELSE
               IF l_dzfr006 = "Folder" THEN
                  LET l_dzfr011 = "N"
               ELSE
                  LET l_dzfr011 = "Y"
               END IF
            END IF

            EXECUTE adzp168t1_ins USING l_dzfr003,l_dzfr004,l_dzfr005,l_dzfr006,l_dzfr007,l_dzfr008,'','',l_dzfr011,l_dzfr012,'','','','','',''
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = 'ins TEMP:'
               LET g_errparam.popup = FALSE
               CALL cl_err()
            END IF
            #CALL test_debug()
            LET l_dzfr004 = l_dzfr003   #for 底下要加的節點
         END IF
      END IF


   END IF

   RETURN l_dzfr004,l_dzfr006
END FUNCTION

#+ 加入Container第二層
PRIVATE FUNCTION adzp168_form_add_container02(p_area,p_ftree_idx,p_dzfr004,p_dzfr006,p_dzfr011)
#adzp168_form_add_master(p_area,p_ftree_idx,p_dzfq007,p_dzfr011)
   DEFINE p_area          LIKE dzfr_t.dzfr007   #加入區塊的4fd tag name   #vb_master,vb_detailexp
   DEFINE p_ftree_idx     LIKE type_t.num10
   DEFINE p_dzfr004       LIKE dzfr_t.dzfr004   #父節點編號
   DEFINE p_dzfr006       LIKE dzfr_t.dzfr006   #4fd tag 類型,是Folder才可以加Page
   DEFINE p_dzfr011       LIKE dzfr_t.dzfr011   #是否可刪除
   DEFINE l_root_idx      LIKE type_t.num5      #focus的Root節點index
   DEFINE l_rootid        STRING
   DEFINE l_dzfr003       LIKE dzfr_t.dzfr003   #編號(流水號)
   DEFINE l_dzfr004       LIKE dzfr_t.dzfr004   #父節點編號
   DEFINE l_dzfr005       LIKE dzfr_t.dzfr005   #順序(同階層中的排序)
   DEFINE l_dzfr006       LIKE dzfr_t.dzfr006   #4fd tag 類型
   DEFINE l_dzfr007       LIKE dzfr_t.dzfr007   #4fd tag name
   DEFINE l_dzfr008       LIKE dzfr_t.dzfr008   #4fd tag name 編號
   DEFINE l_dzfr011       LIKE dzfr_t.dzfr011   #是否可刪除
   DEFINE l_dzfr012       LIKE dzfr_t.dzfr012   #4fd tag name前置名稱(s_detail/folder_/page_/page_info_/group_/Grid/HBox/VBox)
   DEFINE l_gzzd005       LIKE gzzd_t.gzzd005
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_str           STRING

   IF p_dzfr004 > 0 THEN
      IF p_dzfr006 = "Folder" OR g_form_tree[p_ftree_idx].dzfr006 = "Folder"  THEN   #add Page
         CALL adzp168t1_new_dzfr003() RETURNING l_dzfr003   #暫存檔編號(流水號) - for新增資料
         CALL adzp168t1_new_dzfr005(p_dzfr004) RETURNING l_dzfr005   #暫存檔順序(同階層中的排序) - for新增資料
         CALL adzp168t1_new_tag_d1("Page") RETURNING l_dzfr006   #4fd tag 類型 - for新增資料
         CALL adzp168t1_new_tagname(l_dzfr006) RETURNING l_dzfr007,l_dzfr012,l_dzfr008   #4fd tag name,4fd tag name 編號 - for新增資料
         CALL adzp168_page_name(FALSE,g_dzfq_m.dzfq004,g_lang,l_dzfr007,ms_dgenv) RETURNING l_gzzd005

         IF NOT cl_null(p_dzfr011) THEN
            LET l_dzfr011 = p_dzfr011
         ELSE
            LET l_dzfr011 = "Y"
         END IF

         EXECUTE adzp168t1_ins USING l_dzfr003,p_dzfr004,l_dzfr005,l_dzfr006,l_dzfr007,l_dzfr008,'','',l_dzfr011,l_dzfr012,'','','',l_gzzd005,'',''
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'ins TEMP:'
            LET g_errparam.popup = FALSE
            CALL cl_err()
         END IF
         #CALL test_debug()
         LET l_dzfr004 = l_dzfr003   #for 底下要加的單身框架
      END IF
   END IF

   IF l_dzfr004 = 0 THEN
      LET l_dzfr004 = p_dzfr004
   END IF

   RETURN l_dzfr004
END FUNCTION


#+ 畫面設計 - 欄位是否存在
PRIVATE FUNCTION adzp168_form_tree_add_col_exist(p_ftree_idx,p_column,p_pk)
   DEFINE p_ftree_idx     LIKE type_t.num10     #放欄位容器的index
   DEFINE p_column        LIKE dzfr_t.dzfr010   #欄位代碼
   DEFINE p_pk            STRING                #Primary Key
   DEFINE l_root_idx      LIKE type_t.num5      #focus的Root節點index
   DEFINE l_i             LIKE type_t.num10
   DEFINE l_cnt           LIKE type_t.num10
   DEFINE l_rootarea      STRING                #需要檢查的區塊
   DEFINE l_rootid        STRING
   DEFINE l_str           STRING
   DEFINE l_exist         BOOLEAN
   DEFINE l_chk           BOOLEAN
   DEFINE l_idx           LIKE type_t.num10
   DEFINE l_form_col      type_g_form_col
   DEFINE l_dzfr003       LIKE dzfr_t.dzfr003
   DEFINE l_dzfr004       LIKE dzfr_t.dzfr004
   DEFINE l_find          BOOLEAN

   #LET l_exist = FALSE
   CALL adzp168_form_tree_root_idx(p_ftree_idx) RETURNING l_root_idx
   IF cl_null(p_pk) THEN
      LET p_pk = ""
   END IF

   LET l_form_col.dzfr010 = p_column CLIPPED
   LET l_form_col.cont_tag = g_form_tree[p_ftree_idx].dzfr006 CLIPPED
   LET l_form_col.cont_tagname = g_form_tree[p_ftree_idx].dzfr007 CLIPPED
   #需要往上找Container
   IF l_form_col.cont_tag <> "Tree" AND l_form_col.cont_tag <> "Table" AND l_form_col.cont_tag <> "ScrollGrid"
      AND l_form_col.cont_tag <> "Page" AND l_form_col.cont_tag <> "Group" AND l_form_col.cont_tag <> "Grid" THEN

      LET l_dzfr004 = g_form_tree[p_ftree_idx].dzfr004
      LET l_find = FALSE
      WHILE l_find = FALSE
         SELECT dzfr003,dzfr004,dzfr006,dzfr007 INTO l_dzfr003,l_dzfr004,l_form_col.cont_tag,l_form_col.cont_tagname FROM adzp168t1 WHERE dzfr003 = l_dzfr004
         CASE
            WHEN l_form_col.cont_tag = "Table" OR l_form_col.cont_tag = "ScrollGrid" OR l_form_col.cont_tag = "Tree"
               LET l_find = TRUE

            WHEN l_form_col.cont_tag = "Page" OR l_form_col.cont_tag = "Group" OR l_form_col.cont_tag = "Grid"
               LET l_find = TRUE

            WHEN l_dzfr003 = 1
               LET l_find = TRUE
         END CASE
      END WHILE
   END IF


   #單身PK可以在多個單身出現
   IF (NOT cl_null(p_pk)) AND (l_form_col.cont_tag = "Table" OR l_form_col.cont_tag = "ScrollGrid" OR l_form_col.cont_tag = "Tree") THEN   #Screen Record
      SELECT COUNT(*) INTO l_cnt FROM adzp168t2
         WHERE cont_tagname = l_form_col.cont_tagname
            #AND dzfr009 = l_form_col.dzfr009
            AND dzfr010 = l_form_col.dzfr010
   ELSE
      LET l_rootarea = "'",g_form_tree[l_root_idx].dzfr007 CLIPPED,"'"
      LET g_sql = "SELECT COUNT(*) FROM adzp168t2",
                  " WHERE rootarea IN (",l_rootarea CLIPPED,")",
                    #" AND dzfr009 = ?",
                    " AND dzfr010 = ?"
      PREPARE adzp168_form_tree_add_col_exist_pre01 FROM g_sql
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'PREPARE:'
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF

      EXECUTE adzp168_form_tree_add_col_exist_pre01 USING l_form_col.dzfr010 INTO l_cnt
   END IF

   #需要聯合檢查的區塊
   IF l_cnt = 0 THEN
      LET l_rootarea = ""

      #單頭固定區塊
      IF g_4fd_inf.form_vbhl_idx > 0 AND (g_form_tree[l_root_idx].dzfr007 = "vb_master" OR g_form_tree[l_root_idx].dzfr007 = "vb_headerlock") THEN
         LET l_rootarea = l_rootarea,",'vb_master','vb_headerlock'"
      END IF

      #單身底下附屬區塊
      IF g_4fd_inf.form_vbd_exp_idx > 0 AND (g_form_tree[l_root_idx].dzfr007 = "vb_detail" OR g_form_tree[l_root_idx].dzfr007 = "vb_detailexp") THEN
         LET l_rootarea = l_rootarea,",'vb_detail','vb_detailexp'"
         #CASE g_form_tree[l_root_idx].dzfr007
         #   WHEN "vb_detailexp"
         #      LET l_rootarea = l_rootarea,",'vb_detail'"
         #   WHEN "vb_detail"
         #      LET l_rootarea = l_rootarea,",'vb_detailexp'"
         #END CASE
      END IF

      #因為F003可用於標準假雙檔(只有一個Table),需要查單頭,單身
      IF g_4fd_inf.l_jiashuangdang > 0 THEN
         CASE
            WHEN g_form_tree[l_root_idx].dzfr007 = "vb_master" OR g_form_tree[l_root_idx].dzfr007 = "vb_headerlock"
               LET l_rootarea = l_rootarea,",'vb_detail'"
            WHEN g_form_tree[l_root_idx].dzfr007 = "vb_detail"
               LET l_rootarea = l_rootarea,",'vb_master','vb_headerlock'"
         END CASE
      END IF

      IF NOT cl_null(l_rootarea) THEN
         LET l_rootarea = l_rootarea.subString(2,l_rootarea.getLength())
         LET g_sql = "SELECT COUNT(*) FROM adzp168t2",
                     " WHERE rootarea IN (",l_rootarea CLIPPED,")",
                       #" AND dzfr009 = ?",
                       " AND dzfr010 = ?"
         PREPARE adzp168_form_tree_add_col_exist_pre02 FROM g_sql
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'PREPARE:'
            LET g_errparam.popup = TRUE
            CALL cl_err()
         END IF

         EXECUTE adzp168_form_tree_add_col_exist_pre02 USING l_form_col.dzfr010 INTO l_cnt
      END IF

   END IF

   IF l_cnt > 0 THEN
      LET l_chk = FALSE
   ELSE
      LET l_chk = TRUE
   END IF

   RETURN l_chk
END FUNCTION


#+ 檢查是否可以按按鈕"tree_config"
PRIVATE FUNCTION adzp168_tree_config_chk(p_showmsg)
   DEFINE p_showmsg       BOOLEAN            #是否顯示訊息 for table_limit
   #DEFINE l_chk           BOOLEAN
   DEFINE l_chk2          BOOLEAN
   DEFINE l_idx           LIKE type_t.num5   #需要設定的節點ndex
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_j             LIKE type_t.num5
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_str           STRING

   #LET l_chk = FALSE
   LET l_idx = 0
   LET l_str = "Tree"

   IF g_tbtree.getLength() > 1 THEN
      LET l_chk2 = TRUE
   END IF

   IF l_chk2 AND g_ftree_idx > 0 AND g_4fd_inf.form_browse_idx > 0 AND g_4fd_inf.l_jiashuangdang = FALSE THEN
      IF g_form_tree[g_4fd_inf.form_browse_idx].dzfr006 = "Tree" THEN
         LET l_idx = g_4fd_inf.form_browse_idx
      END IF

      #畫面結構所focus的節點是Tree則回傳index,否則搜尋Tree元件在哪一個index
      #IF g_form_tree[g_ftree_idx].dzfr006 = l_str THEN
      #   LET l_idx = g_ftree_idx
      #ELSE
      #   FOR l_i = 1 TO g_form_tree.getLength()
      #      IF g_form_tree[l_i].dzfr006 = l_str THEN
      #         LET l_idx = l_i
      #         EXIT FOR
      #      END IF
      #   END FOR
      #END IF
   END IF

   #先不檢查資料表代碼,都使用主表當Tree的資料表
   #IF l_idx > 0 THEN
   #   IF cl_null(g_form_tree[l_idx].dzfr009) THEN   #資料表代碼
   #      LET l_idx = 0
   #   END IF
   #END IF

   RETURN l_idx
END FUNCTION


#+ 完成畫面與程式
PRIVATE FUNCTION adzp168_final()
   DEFINE l_cmd       STRING
   DEFINE l_buf       STRING
   DEFINE l_chk       BOOLEAN           #檢查是否執行成功
   DEFINE l_str       STRING
   DEFINE l_sindex    LIKE type_t.num5

   LET l_chk = TRUE

   IF l_chk THEN
      LET l_cmd = l_cmd CLIPPED,"r.r azzp189 '",g_dzfq_m.dzfq004 CLIPPED,"'"    #r.p預覽畫面,畫面剛產出沒有42s所以不用傳語言別
      CALL cl_cmdrun_openpipe("r.p",l_cmd,TRUE) RETURNING l_chk,l_str
   END IF

   RETURN l_chk
END FUNCTION


#+ 畫面結構設計主檔預設值
PRIVATE FUNCTION adzp168_default_set(p_set)
   DEFINE p_set    STRING
   DEFINE l_str    STRING
   DEFINE l_entry  BOOLEAN   #是否開啟欄位

   CASE p_set
      WHEN "m"   #單頭
         CALL adzp168_default_set_dzfq006() RETURNING l_entry   #畫面結構設計主檔預設值-單頭資料(mq:多筆/sq:單筆)
         LET g_dzfq_m.dzfq007 = "Folder"   #Folder/Group/Grid
         LET g_dzfq_m.dzfq008 = "7"
         LET g_dzfq_m.dzfq014 = "N"
         CALL adzp168_default_set_dzfq015(TRUE) RETURNING l_entry
         CALL adzp168_set_comp_entry("dzfq015",l_entry)   #FUN-150228

      WHEN "d"   #單身
         LET g_dzfq_m.dzfq009 = "sarray"   #sarray:單一/Folder/HBox/VBox
         LET g_dzfq_m.dzfq010 = "Table"    #Table/ScrollGrid
         LET g_dzfq_m.dzfq011 = "00"       #sb:需要 /00: 不需要
   END CASE

   CALL adzp168_default_set_dzfq012() RETURNING l_entry   #畫面結構設計主檔預設值-單身串查(Y:需要 /N:不需要)
   CALL adzp168_default_set_dzfq013()  #畫面結構設計主檔預設值-子程式進入模式(a:全功能/ b:INPUT / c:CONSTRUCT)
END FUNCTION

#+ 畫面結構設計主檔預設值-單頭資料(mq:多筆/sq:單筆)
PRIVATE FUNCTION adzp168_default_set_dzfq006()
   DEFINE l_dzfq006_t    LIKE dzfq_t.dzfq006
   DEFINE l_dzfq006_new  LIKE dzfq_t.dzfq006
   DEFINE l_entry        BOOLEAN     #是否開啟欄位
   DEFINE l_str          STRING
   DEFINE l_cnt          LIKE type_t.num5
   DEFINE l_i            LIKE type_t.num5
   DEFINE l_legal        BOOLEAN     #是否符合規則,不符合規則一定要重設

   LET l_entry = TRUE
   LET l_legal = TRUE
   LET l_dzfq006_t = g_dzfq_m.dzfq006
   LET l_dzfq006_new = NULL #"mq"       #mq:多筆/sq:單筆

   #下列為特殊狀況:
   #資料瀏覽區塊(非00不需要)
   IF g_dzfq_m.cbo_setbrowse <> "00" THEN
      LET l_dzfq006_new = "mq"   #單頭資料(mq:多筆/sq:單筆)
      LET l_entry = FALSE
      #包含查詢方案:必多筆mq
   END IF

   #限定版型F002只有F002_00_sq
   #資料表結構為單檔時，單頭資料:"sq"單筆；資料表結構為雙檔時，"mq"多筆
   LET l_str = g_dzfq_m.cbo_progtype CLIPPED,g_dzfq_m.cbo_formtype CLIPPED
   CASE
      WHEN l_str = "F002"    #OR l_str = "F004"
         LET l_dzfq006_new = "sq"

         LET l_cnt = g_tbtree.getLength()
         FOR l_i = 2 TO l_cnt
            IF g_tbtree[l_i].b_level > 1 THEN
               LET l_dzfq006_new = "mq"
            END IF
         END FOR
         LET l_entry = FALSE

      WHEN l_str = "Q001"
         LET l_dzfq006_new = "sq"
         LET l_entry = FALSE

      #子畫面F005_00,Q002_00必為多筆mq
      WHEN (g_dzfq_m.dzfq005 = "F" AND l_str = "F005") OR   #FUN-150228
           (g_dzfq_m.dzfq005 = "F" AND l_str = "Q002")      #FUN-150228
         LET l_dzfq006_new = "mq"
         LET l_entry = FALSE

      WHEN g_dzfq_m.cbo_progtype = "P" OR g_dzfq_m.cbo_progtype = "R"
         LET l_dzfq006_new = "sq"
         LET l_entry = FALSE
   END CASE

   #單頭 + 主程式 + 資料瀏覽區塊(00不需要),則單頭資料必選mq:多筆,因為會無法切換資料
   IF g_dzfq_m.cbo_setbrowse = "00" AND g_4fd_inf.form_vbm_idx > 0 AND g_dzfq_m.dzfq005 = "M" THEN
      LET l_dzfq006_new = "mq"
      LET l_entry = FALSE
   END IF

   IF cl_null(g_dzfq_m.dzfq006) THEN
       LET l_legal = FALSE
       LET l_dzfq006_new = "mq"
   END IF
   IF NOT cl_null(l_dzfq006_new) THEN
      IF l_dzfq006_t <> l_dzfq006_new THEN
         LET l_legal = FALSE
      END IF
   END IF

   #IF NOT g_def_reset THEN
   IF NOT l_legal THEN
      LET g_dzfq_m.dzfq006 = l_dzfq006_new
   END IF

   RETURN l_entry
END FUNCTION

#+ 畫面結構設計主檔預設值-單身串查(Y:需要 /N:不需要)
PRIVATE FUNCTION adzp168_default_set_dzfq012()
   DEFINE l_dzfq012_t   LIKE dzfq_t.dzfq012
   DEFINE l_entry       BOOLEAN   #是否開啟欄位
   DEFINE l_str         STRING
   DEFINE l_type        STRING

   #LET l_entry = TRUE
   #LET l_dzfq012_t = g_dzfq_m.dzfq012
   LET g_dzfq_m.dzfq012 = "Y"
   LET l_type = g_dzfq_m.cbo_progtype CLIPPED,g_dzfq_m.cbo_formtype CLIPPED
   CASE
      WHEN g_dzfq_m.cbo_progtype = "Q"
         LET g_dzfq_m.dzfq012 = "N"
   END CASE

   #CASE
   #   WHEN l_type = "F001" OR g_dzfq_m.cbo_progtype = "Q"
   #      LET l_entry = FALSE
   #END CASE
   #
   #
   #IF NOT g_def_reset THEN
   #   LET g_dzfq_m.dzfq012 = l_dzfq012_t
   #END IF

   #2013/12/05 Saki
   LET l_entry = FALSE   #不開放設定

   RETURN l_entry
END FUNCTION

#+ 畫面結構設計主檔預設值-子程式進入模式(a:全功能/ b:INPUT / c:CONSTRUCT)   #資料來自azzi901
PRIVATE FUNCTION adzp168_default_set_dzfq013()
   DEFINE l_dzfq013_t   LIKE dzfq_t.dzfq013
   DEFINE l_entry       BOOLEAN   #是否開啟欄位
   DEFINE l_str         STRING
   DEFINE l_sql         STRING

   #LET l_entry = FALSE

   LET g_dzfq_m.dzfq013 = NULL
   IF NOT cl_null(g_dzfq_m.dzfq004) THEN
      LET l_sql = "SELECT DISTINCT gzde006 FROM gzde_t",
                  " WHERE gzdestus = 'Y' AND gzde001 = ?"
      PREPARE adzp168_gzde006_pre01 FROM l_sql
      IF SQLCA.sqlcode THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = SQLCA.sqlcode
       LET g_errparam.extend = 'PREPARE:'
       LET g_errparam.popup = FALSE
       CALL cl_err()
      END IF
      EXECUTE adzp168_gzde006_pre01 USING g_dzfq_m.dzfq004 INTO g_dzfq_m.dzfq013
   END if

   IF cl_null(g_dzfq_m.dzfq013) THEN
      LET g_dzfq_m.dzfq013 = "a"
   END IF

   #LET l_dzfq013_t = g_dzfq_m.dzfq013
   #
   #CASE g_dzfq_m.dzfq005
   #   WHEN "M"   #M:主程式與畫面、S:子程式與畫面、F:子畫面（含應用元件畫面）
   #      LET g_dzfq_m.dzfq013 = "a"
   #
   #   WHEN "S"
   #      #限定版型F001
   #      LET l_str = g_dzfq_m.cbo_progtype CLIPPED,g_dzfq_m.cbo_formtype CLIPPED
   #      IF l_str = "F001" OR l_str = "F002" THEN
   #         LET g_dzfq_m.dzfq013 = "b"
   #         LET l_entry = TRUE
   #      ELSE
   #         LET g_dzfq_m.dzfq013 = "a"
   #      END IF
   #
   #   OTHERWISE
   #      LET g_dzfq_m.dzfq013 = "a"
   #END CASE
   #
   #IF NOT g_def_reset THEN
   #   LET g_dzfq_m.dzfq013 = l_dzfq013_t
   #END IF
   #
   #RETURN l_entry
END FUNCTION


#+ 畫面結構設計主檔預設值-空框架畫面檔
PRIVATE FUNCTION adzp168_default_set_dzfq015(p_reset_all)
   DEFINE p_reset_all     BOOLEAN
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_type          STRING
   DEFINE l_entry         BOOLEAN     #是否開啟欄位   #FUN-150228

   LET l_type = g_dzfq_m.cbo_progtype CLIPPED,g_dzfq_m.cbo_formtype CLIPPED

   IF g_dzfq_m.dzfq005 = "F" THEN #M:主程式與畫面、S:子程式與畫面、F:子畫面（含應用元件畫面）#FUN-150228
      LET l_entry = TRUE
   ELSE
      LET l_entry = FALSE
   END IF

   IF l_type = "P001" OR l_type = "P003" OR l_type = "R001" THEN   #FUN-140605
      LET g_dzfq_m.dzfq015 = "Y"   #版型限定,且不能修改
      LET l_entry = FALSE          #FUN-150228
   ELSE
      IF p_reset_all THEN
         LET g_dzfq_m.dzfq015 = "N"
      END IF
   END IF

   IF g_dzfq_m.dzfq015 = "Y" THEN
      CALL g_tbtree.clear()
      LET g_tbtree_idx = 0

      CALL adzp168_col_fill(NULL)
      CALL adzp168_col_setcolor()

      #刪除全部欄位
      #SELECT COUNT(*) INTO l_cnt FROM adzp168t1 WHERE dzfr006 = 'Field' AND dzfr009 IS NOT NULL AND dzfr010 IS NOT NULL
      #IF l_cnt > 0 THEN
      #   DELETE FROM adzp168t1 WHERE dzfr006 = 'Field' AND dzfr009 IS NOT NULL AND dzfr010 IS NOT NULL
      #   CALL adzp168_form_tree_fill("0",0,"0",FALSE)   #刪完後再重整tree
      #END IF
   END IF

   RETURN l_entry
END FUNCTION

##################################################
# Description   : 程式變化類型
# Date & Author : 2013/04/13 by tsai_yen
# Parameter     : none
# Return        : void
##################################################
PUBLIC FUNCTION adzp168_prog_class()
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_chk           BOOLEAN
   DEFINE l_level         LIKE type_t.num5       #階層

   #假雙檔
   LET g_4fd_inf.l_jiashuangdang = FALSE
   LET l_cnt = g_tbtree.getLength()
   IF l_cnt >= 2 THEN
      LET l_level = 1
      FOR l_i = 2 TO l_cnt
         IF g_tbtree[l_i].b_level > 1 THEN
            LET l_level = g_tbtree[l_i].b_level
         END IF
      END FOR
      #只有Level 1的Table,但有單頭和單身
      IF l_level = 1 AND g_4fd_inf.form_vbm_idx > 0 AND g_4fd_inf.form_vbd_idx > 0 AND g_4fd_inf.form_vbd_exp_idx = 0 THEN
         LET g_4fd_inf.l_jiashuangdang = TRUE
      END IF
   END IF
END FUNCTION


##################################################
# Description   : 刪除放在單身的單頭欄位
# Date & Author : 2013/04/20 by tsai_yen
# Parameter     : none
# Return        : void
##################################################
PRIVATE FUNCTION adzp168_jiashuangdang_change()
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_j             LIKE type_t.num5
   DEFINE l_chk           BOOLEAN
   DEFINE l_level         LIKE type_t.num5       #階層
   DEFINE l_root_idx      LIKE type_t.num5
   DEFINE l_cnt_tbtree    LIKE type_t.num5
   DEFINE l_sc RECORD
      arridx   LIKE type_t.num5,
      dzfr007  LIKE dzfr_t.dzfr007,
      col_cnt  LIKE type_t.num5        #欄位數量
      END RECORD

   LET l_chk = FALSE

   #假雙檔加了單身Table變成不是假雙檔後，要刪除放在單身的單頭欄位
   IF g_4fd_inf.l_jiashuangdang AND g_4fd_inf.form_vbm_idx > 0 AND g_4fd_inf.form_vbd_idx > 0 THEN
      CALL adzp168_prog_class()
      IF NOT g_4fd_inf.l_jiashuangdang THEN
         LET l_cnt_tbtree = g_tbtree.getLength()
         LET l_cnt = g_form_tree.getLength()
         FOR l_i=l_cnt TO g_4fd_inf.form_vbd_idx STEP -1   #要刪陣列從後面開始,否則index會錯亂
             CALL adzp168_form_tree_root_idx(l_i) RETURNING l_root_idx
             IF l_root_idx = g_4fd_inf.form_vbd_idx THEN   #單身
                #刪除放在單身的單頭欄位
                IF g_form_tree[l_i].dzfr006 = "Field" AND g_form_tree[l_i].dzfr011 = "Y" THEN
                   FOR l_j = 2 TO l_cnt_tbtree   #是否屬於單頭欄位
                      IF g_form_tree[l_i].dzfr009 = g_tbtree[l_j].b_tableid AND g_tbtree[l_j].b_level = 1 THEN
                         CALL adzp168_form_tree_del_area(l_i)
                         LET l_chk = TRUE
                      END IF
                   END FOR
                END IF
             END IF
         END FOR
      END IF
   END IF


   IF l_chk THEN
      #單身若無欄位就刪除
      CALL adzp168_form_tree_fill("0",0,"0",FALSE)   #多選刪完後再重整tree
      LET g_sql = "SELECT arridx,dzfr007,col_cnt",
                    " FROM",
                    " (SELECT arridx,dzfr007 FROM adzp168t1 WHERE dzfr006 IN ('Table','ScrollGrid') AND dzfr011 = 'Y')",
                    " LEFT JOIN",
                    " (SELECT cont_tagname,COUNT(cont_tagname) AS col_cnt FROM adzp168t2",
                      " WHERE rootarea = 'vb_detail'",
                      " GROUP BY cont_tagname)",
                    " ON dzfr007 = cont_tagname",
                    " ORDER BY arridx DESC"
      PREPARE adzp168_jiashuangdang_change_clear_pre_02 FROM g_sql
      DECLARE adzp168_jiashuangdang_change_clear_cur_02 CURSOR FOR adzp168_jiashuangdang_change_clear_pre_02
      FOREACH adzp168_jiashuangdang_change_clear_cur_02 INTO l_sc.arridx,l_sc.dzfr007,l_sc.col_cnt
         #DISPLAY l_sc.arridx,",",l_sc.dzfr007,",",l_sc.col_cnt
         IF cl_null(l_sc.col_cnt) OR l_sc.col_cnt = 0 THEN
            CALL adzp168_form_tree_del_area(l_sc.arridx)
         END IF
      END FOREACH

      CALL adzp168_form_tree_fill("0",0,"0",FALSE)
   END IF

   RETURN l_chk
END FUNCTION


PRIVATE FUNCTION test_debug()
   DEFINE p_pid           STRING                #tree - 父節點id
   DEFINE p_plevel        LIKE type_t.num5      #tree - 父階層
   DEFINE p_dzfr004       LIKE dzfr_t.dzfr004   #父節點編號
   DEFINE p_isrename      BOOLEAN               #是否重新命名(將影響已存在的畫面多語言對應)
   DEFINE l_level         LIKE type_t.num5      #tree - 階層
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_j             LIKE type_t.num5
   DEFINE l_cnt           LIKE type_t.num5

   DEFINE l_str           STRING
   DEFINE l_seq           LIKE dzfr_t.dzfr005   #順序(同階層中的排序)
   DEFINE l_sidx          LIKE type_t.num5
   DEFINE l_eidx          LIKE type_t.num5

   #畫面樣版Tree資料
   LET g_sql = "SELECT a.*,cnt.child_cnt",
                 " FROM",
                 " (",
                    " SELECT idx,dzfr003,dzfr004,dzfr005,dzfr006,dzfr007,dzfr008,dzfr009,dzfr010,dzfr011,dzfr012,dzeb004,dzeb022,dzekgrp,gzzd005,dzef008,dzer007",
                       " FROM adzp168t1 ",
                 " ) a",
                 " LEFT JOIN",
                 " (",
                    " SELECT dzfr004,COUNT(dzfr004) AS child_cnt",
                       " FROM adzp168t1 GROUP BY dzfr004",
                 " ) cnt",
                 " ON a.dzfr003 = cnt.dzfr004",
                 " ORDER BY a.dzfr004,a.dzfr005"
   PREPARE test_pre1 FROM g_sql
   IF SQLCA.sqlcode THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = SQLCA.sqlcode
       LET g_errparam.extend = 'PREPARE:'
       LET g_errparam.popup = TRUE
       CALL cl_err()
       EXIT PROGRAM
   END IF
   DECLARE test_cs1 CURSOR FOR test_pre1

   #在FOREACH中直接使用recursive,資料會錯亂,所以先將資料放到陣列後處理
   LET l_cnt = 1
   CALL l_form_data_test.clear()
   FOREACH test_cs1 INTO l_form_data_test[l_cnt].*
      IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'FOREACH:'
          LET g_errparam.popup = TRUE
          CALL cl_err()
          EXIT FOREACH
      END IF
      LET l_form_data_test[l_cnt].dzfr003 = l_form_data_test[l_cnt].dzfr003 CLIPPED
      LET l_form_data_test[l_cnt].dzfr004 = l_form_data_test[l_cnt].dzfr004 CLIPPED
      LET l_form_data_test[l_cnt].dzfr005 = l_form_data_test[l_cnt].dzfr005 CLIPPED
      LET l_form_data_test[l_cnt].dzfr006 = l_form_data_test[l_cnt].dzfr006 CLIPPED
      LET l_form_data_test[l_cnt].dzfr007 = l_form_data_test[l_cnt].dzfr007 CLIPPED
      LET l_form_data_test[l_cnt].dzfr008 = l_form_data_test[l_cnt].dzfr008 CLIPPED
      LET l_form_data_test[l_cnt].dzfr009 = l_form_data_test[l_cnt].dzfr009 CLIPPED
      LET l_form_data_test[l_cnt].dzfr010 = l_form_data_test[l_cnt].dzfr010 CLIPPED
      LET l_form_data_test[l_cnt].dzfr011 = l_form_data_test[l_cnt].dzfr011 CLIPPED
      LET l_form_data_test[l_cnt].dzfr012 = l_form_data_test[l_cnt].dzfr012 CLIPPED
      LET l_form_data_test[l_cnt].dzeb004 = l_form_data_test[l_cnt].dzeb004 CLIPPED
      LET l_form_data_test[l_cnt].dzeb022 = l_form_data_test[l_cnt].dzeb022 CLIPPED
      LET l_form_data_test[l_cnt].dzekgrp = l_form_data_test[l_cnt].dzekgrp CLIPPED
      LET l_form_data_test[l_cnt].gzzd005 = l_form_data_test[l_cnt].gzzd005 CLIPPED
      LET l_form_data_test[l_cnt].child_cnt = l_form_data_test[l_cnt].child_cnt CLIPPED

      LET l_cnt = l_cnt + 1
   END FOREACH
   CALL l_form_data_test.deleteelement(l_cnt)  #刪除FOREACH最後新增的空白列
   LET l_cnt = l_cnt - 1
END FUNCTION

##################################################
# Description   : 共用欄位名稱
# Date & Author : 2013/07/12 by tsai_yen
# Parameter     : none
# Return        : void
##################################################
PUBLIC FUNCTION adzp168_common_desc()
   LET g_dzfq_m.dzfqownid_desc = cl_get_username(g_dzfq_m.dzfqownid)
   LET g_dzfq_m.dzfqowndp_desc = cl_get_deptname(g_dzfq_m.dzfqowndp)
   LET g_dzfq_m.dzfqcrtid_desc = cl_get_username(g_dzfq_m.dzfqcrtid)
   LET g_dzfq_m.dzfqcrtdp_desc = cl_get_deptname(g_dzfq_m.dzfqcrtdp)
   LET g_dzfq_m.dzfqmodid_desc = cl_get_username(g_dzfq_m.dzfqmodid)
END FUNCTION


##################################################
# Description   : 畫面區塊階層架構
# Date & Author : 2013/07/30 by tsai_yen
# Parameter     : p_ftree_idx
# Return        : l_ln
##################################################
PRIVATE FUNCTION adzp168_form_stc(p_ftree_idx)
   DEFINE p_ftree_idx     LIKE type_t.num10     #focus的節點index
   DEFINE l_root_idx      LIKE type_t.num5      #focus的Root節點index
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_ln            LIKE type_t.num5      #畫面區塊階層架構Array Length

   CALL g_form_stc.clear()
   CALL adzp168_form_tree_root_idx(p_ftree_idx) RETURNING l_root_idx

   CASE g_form_tree[l_root_idx].dzfr007
      WHEN "vb_master"
         LET l_ln = g_form_vbm_stc.getLength()
         IF l_ln > 0 THEN
            FOR l_i = 1 TO l_ln
               LET g_form_stc[l_i].dzfr006 = g_form_vbm_stc[l_i].dzfr006 CLIPPED
               LET g_form_stc[l_i].addcol = g_form_vbm_stc[l_i].addcol
            END FOR
         END IF

      WHEN "vb_detail"
         LET l_ln = g_form_vbd_stc.getLength()
         IF l_ln > 0 THEN
            FOR l_i = 1 TO l_ln
               LET g_form_stc[l_i].dzfr006 = g_form_vbd_stc[l_i].dzfr006 CLIPPED
               LET g_form_stc[l_i].addcol = g_form_vbd_stc[l_i].addcol
            END FOR
         END IF

      WHEN "vb_detailexp"
         LET l_ln = g_form_vbm_exp_stc.getLength()
         IF l_ln > 0 THEN
            FOR l_i = 1 TO l_ln
               LET g_form_stc[l_i].dzfr006 = g_form_vbm_exp_stc[l_i].dzfr006 CLIPPED
               LET g_form_stc[l_i].addcol = g_form_vbm_exp_stc[l_i].addcol
            END FOR
         END IF

      WHEN "vb_headerlock"
         LET l_ln = g_form_vbhl_stc.getLength()
         IF l_ln > 0 THEN
            FOR l_i = 1 TO l_ln
               LET g_form_stc[l_i].dzfr006 = g_form_vbhl_stc[l_i].dzfr006 CLIPPED
               LET g_form_stc[l_i].addcol = g_form_vbhl_stc[l_i].addcol
            END FOR
         END IF
   END CASE

   LET l_ln = g_form_stc.getLength()

   RETURN l_ln
END FUNCTION



#+ 樹狀結構屬性設定檔/底稿
PRIVATE FUNCTION adzp168_dzff_dzfw_ins(p_real)
   DEFINE p_real          LIKE type_t.chr1      #是否為正式資料 Y/N
   DEFINE l_chk           BOOLEAN
   DEFINE l_add           BOOLEAN               #是否有新增資料
   DEFINE l_dzff_d        type_g_dzff_d         #畫面結構設計附屬設定表
   DEFINE l_dzff_att      STRING                #樹狀結構可以設定的屬性
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_tok           base.StringTokenizer
   DEFINE l_str           STRING

   LET l_chk = TRUE

   LET g_sql = "INSERT INTO dzff_t (dzff001,dzff002,dzff003,dzff004,dzff005, dzff006,dzff007,dzff008,dzff009,",
                                   "dzffmodid,dzffmoddt,dzffownid,dzffowndp,dzffcrtid,dzffcrtdp,dzffcrtdt,dzffstus)",
               " VALUES (?,?,?,?,? ,?,?,?,?,? ,?,?,?,?,? ,?,?)"
   PREPARE adzp168_dzff_ins_pre FROM g_sql
   IF SQLCA.sqlcode THEN
      LET l_chk = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'PREPARE gen_4fd:'
      LET g_errparam.popup = FALSE
      CALL cl_err()
   END IF

   LET g_sql = "INSERT INTO dzfw_t (dzfw001,dzfw002,dzfw003,dzfw004,dzfw005,dzfw006,dzfw007,dzfw008)",
               " VALUES (?,?,?,?,? ,?,?,?)"
   PREPARE adzp168_dzfw_ins_pre FROM g_sql
   IF SQLCA.sqlcode THEN
      LET l_chk = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'PREPARE gen_4fd:'
      LET g_errparam.popup = FALSE
      CALL cl_err()
   END IF

   IF l_chk THEN
      #Tree 4fd tag name (s_browse,s_detail1)
      FOREACH adzp168_dzff_sel_curs3 USING g_dzfq_m.dzfq004,g_dzfq_m.dzfq003 INTO l_dzff_d.dzff003
         LET l_dzff_d.dzff003 = l_dzff_d.dzff003 CLIPPED
         #全部屬性
         CALL sadzp168_1_dzff_default_str(l_dzff_d.dzff003,"ALL") RETURNING l_dzff_att
         LET l_i = 0
         LET l_tok = base.StringTokenizer.createExt(l_dzff_att CLIPPED,",","",TRUE)	#指定分隔符號
         WHILE l_tok.hasMoreTokens()	#依序取得子字串
            LET l_str = l_tok.nextToken()
            LET l_i = l_i + 1

            LET l_add = FALSE
            LET l_dzff_d.dzff005 = l_str CLIPPED
            #畫面結構設計附屬設定表
            FOREACH adzp168_dzff_sel_curs1 USING g_dzfq_m.dzfq004,g_dzfq_m.dzfq003,l_dzff_d.dzff003,l_dzff_d.dzff005
                  INTO l_dzff_d.dzff001,l_dzff_d.dzff002,l_dzff_d.dzff003,l_dzff_d.dzff004,l_dzff_d.dzff005,
                       l_dzff_d.dzff006,l_dzff_d.dzff007,l_dzff_d.dzff008

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "FOREACH:"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  #ROLLBACK WORK
                  LET l_chk = FALSE
                  EXIT FOREACH
               END IF

               IF p_real = "Y" THEN  #正式資料
                  EXECUTE adzp168_dzff_ins_pre USING #g_dzfq_m.dzfq004,g_dzfq_m.dzfq003,l_dzff_d.dzff003,
                                                     l_dzff_d.dzff001,l_dzff_d.dzff002,l_dzff_d.dzff003,
                                                     l_dzff_d.dzff004,l_dzff_d.dzff005,l_dzff_d.dzff006,l_dzff_d.dzff007,l_dzff_d.dzff008,ms_cust,
                                                     g_dzfq_m.dzfqmodid,g_dzfq_m.dzfqmoddt,g_dzfq_m.dzfqownid,g_dzfq_m.dzfqowndp,g_dzfq_m.dzfqcrtid,g_dzfq_m.dzfqcrtdp,g_dzfq_m.dzfqcrtdt,g_dzfq_m.dzfqstus
               ELSE   #底稿
                  EXECUTE adzp168_dzfw_ins_pre USING g_ver_ra,g_dzfq_m.dzfqownid,
                                                     l_dzff_d.dzff001,l_dzff_d.dzff003,
                                                     l_dzff_d.dzff004,l_dzff_d.dzff005,l_dzff_d.dzff006,l_dzff_d.dzff007
               END IF

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = 'ins: tree'
                  LET g_errparam.popup = FALSE
                  CALL cl_err()
                  #ROLLBACK WORK
                  LET l_chk = FALSE
                  EXIT FOREACH
               END IF

               LET l_add = TRUE
            END FOREACH

            #IF NOT l_add THEN   #補資料
            #   LET l_dzff_d.dzff001 = g_dzfq_m.dzfq004 CLIPPED
            #   LET l_dzff_d.dzff002 = g_dzfq_m.dzfq003 CLIPPED
            #   LET l_dzff_d.dzff003 = l_dzff_d.dzff003 CLIPPED
            #   LET l_dzff_d.dzff004 = l_i
            #   LET l_dzff_d.dzff005 = l_str CLIPPED
            #   LET l_dzff_d.dzff006 = ""
            #   LET l_dzff_d.dzff007 = ""
            #   LET l_dzff_d.dzff008 = ms_dgenv CLIPPED
            #
            #   IF p_real = "Y" THEN  #正式資料
            #      EXECUTE adzp168_dzff_ins_pre USING #g_dzfq_m.dzfq004,g_dzfq_m.dzfq003,l_dzff_d.dzff003,
            #                                         l_dzff_d.dzff001,l_dzff_d.dzff002,l_dzff_d.dzff003,
            #                                         l_dzff_d.dzff004,l_dzff_d.dzff005,l_dzff_d.dzff006,l_dzff_d.dzff007,l_dzff_d.dzff008,
            #                                         g_dzfq_m.dzfqmodid,g_dzfq_m.dzfqmoddt,g_dzfq_m.dzfqownid,g_dzfq_m.dzfqowndp,g_dzfq_m.dzfqcrtid,g_dzfq_m.dzfqcrtdp,g_dzfq_m.dzfqcrtdt,g_dzfq_m.dzfqstus
            #   ELSE   #底稿
            #      EXECUTE adzp168_dzfw_ins_pre USING g_ver_ra,g_dzfq_m.dzfqownid,
            #                                         l_dzff_d.dzff001,l_dzff_d.dzff003,
            #                                         l_dzff_d.dzff004,l_dzff_d.dzff005,l_dzff_d.dzff006,l_dzff_d.dzff007
            #   END IF
            #END IF
         END WHILE
      END FOREACH
   END IF

   RETURN l_chk
END FUNCTION


#+ 開啟底稿
PRIVATE FUNCTION adzp168_draft_read(p_dzfq004)
   DEFINE p_dzfq004   LIKE dzfq_t.dzfq004   #畫面代號

   #dzfv_t 畫面結構設計主檔底稿
   LET g_sql = "SELECT dzfv003,dzfv004,dzfv005,dzfv006,dzfv007,dzfv008,dzfv009,dzfv010,dzfv011,dzfv012,dzfv013,dzfv014,dzfv015",
                " FROM dzfv_t",
                " WHERE dzfv001 = ? AND dzfv002 = ? AND dzfv004 = ?"
   PREPARE adzp168_draft_read_dzfv_sel_pre FROM g_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'PREPARE draft_read:'
      LET g_errparam.popup = FALSE
      CALL cl_err()
   ELSE
      EXECUTE adzp168_draft_read_dzfv_sel_pre USING g_ver_ra,g_user,p_dzfq004
         INTO g_dzfq_m.dzfq001,g_dzfq_m.dzfq004,g_dzfq_m.dzfq005,
              g_dzfq_m.dzfq006,g_dzfq_m.dzfq007,g_dzfq_m.dzfq008,g_dzfq_m.dzfq009,g_dzfq_m.dzfq010,
              g_dzfq_m.dzfq012,g_dzfq_m.dzfq013,g_dzfq_m.dzfq014,g_dzfq_m.dzfq015,g_dzfq_m.dzfq016

      CALL adzp168_dzfq001_substr() RETURNING g_dzfq_m.cbo_progtype,g_dzfq_m.cbo_formtype,g_dzfq_m.cbo_setbrowse
   END IF

   #dzfx_t 規格Table設定表底稿
   CALL adzp168_dzfx_fill("0",0,NULL)
   IF g_tbtree_idx > 1 THEN
      LET g_tbtree_idx = 2
   END IF

   #dzfz_t 畫面結構設計內容檔底稿
   CALL adzp168_form_tpl(g_dzfq_m.dzfq001)
   CALL adzp168_form_tree_draft_fill()

   #dzfw_t 樹狀結構屬性設定檔底稿
   CALL adzp168t3_draft_fill()

   #dzfy_t 畫面樣版ToolBar功能鍵設定檔底稿(只記錄已勾選)
   CALL adzp168_toolbar(TRUE)
END FUNCTION

#+ 規格Table設定表底稿資料填充
PRIVATE FUNCTION adzp168_dzfx_fill(p_pid,p_plevel,p_dzfx005)
   DEFINE p_pid           STRING                #tree - 父節點id
   DEFINE p_plevel        LIKE type_t.num5      #tree - 父階層
   DEFINE p_dzfx005       LIKE dzfx_t.dzfx005   #父節點table
   DEFINE l_level         LIKE type_t.num5      #tree - 階層
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_j             LIKE type_t.num5
   DEFINE l_k             LIKE type_t.num5
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_tbtree_data   DYNAMIC ARRAY OF type_g_dzfx_data
   DEFINE l_str           STRING
   DEFINE l_seq           LIKE dzfr_t.dzfr005   #順序(同階層中的排序)
   DEFINE l_sidx          LIKE type_t.num5
   DEFINE l_eidx          LIKE type_t.num5
   DEFINE l_gzzd003       LIKE gzzd_t.gzzd003
   DEFINE l_gzzd005       LIKE gzzd_t.gzzd005
   DEFINE l_img_dir       STRING
   DEFINE l_ln01          LIKE type_t.num5      #資料數,為了判斷遞迴結束
   DEFINE l_ln02          LIKE type_t.num5      #資料數
   DEFINE l_where         STRING

   LET l_img_dir = "16/"

   IF p_plevel = 0 THEN
      LET g_tbtree_idx = 1

      CALL g_tbtree.clear()

      LET g_tbtree[g_tbtree_idx].b_tableid   = "Table"
      LET g_tbtree[g_tbtree_idx].b_tablename = ""
      LET g_tbtree[g_tbtree_idx].b_img   = l_img_dir CLIPPED,"database"
      LET g_tbtree[g_tbtree_idx].b_pid   = ""
      LET g_tbtree[g_tbtree_idx].b_id    = "0"
      LET g_tbtree[g_tbtree_idx].b_hasC  = TRUE
      LET g_tbtree[g_tbtree_idx].b_exp   = TRUE
      LET g_tbtree[g_tbtree_idx].b_level = 0

      LET p_pid = g_tbtree[g_tbtree_idx].b_id

      LET g_sql = "SELECT COUNT(*) FROM dzfx_t WHERE dzfx001 = ? AND dzfx002 = ? AND dzfx003 =?"
      PREPARE adzp168_dzfx_cnt_pre FROM g_sql
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'PREPARE table_draft_fill_01:'
         LET g_errparam.popup = FALSE
         CALL cl_err()
      END IF
      EXECUTE adzp168_dzfx_cnt_pre USING g_ver_ra,g_user,g_dzfq_m.dzfq004 INTO l_ln01
   END IF

   #在FOREACH中直接使用recursive,資料會錯亂,所以先將資料放到陣列後處理
   LET l_cnt = 1
   CALL l_tbtree_data.clear()

   #畫面樣版Tree資料
   IF p_dzfx005 IS NULL THEN
      LET l_where = " AND dzfx005 IS NULL"
   ELSE
      LET l_where = " AND dzfx005 = '",p_dzfx005 CLIPPED,"'"
   END IF
   LET g_sql = "SELECT a.*,cnt.child_cnt",
                 " FROM",
                 " (",
                    " SELECT dzfx004,dzfx005",
                       " FROM dzfx_t",
                       " WHERE dzfx001 = ? AND dzfx002 = ? AND dzfx003 = ?",l_where CLIPPED,
                 " ) a",
                 " LEFT JOIN",
                 " (",
                    " SELECT dzfx005,COUNT(dzfx005) AS child_cnt",
                       " FROM dzfx_t",
                       " WHERE dzfx001 = ? AND dzfx002 = ? AND dzfx003 = ?",
                       " GROUP BY dzfx005",
                 " ) cnt",
                 " ON a.dzfx004 = cnt.dzfx005",
                 " ORDER BY a.dzfx004,a.dzfx005"
   PREPARE adzp168_dzfx_pre1 FROM g_sql
   IF SQLCA.sqlcode THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = SQLCA.sqlcode
       LET g_errparam.extend = 'PREPARE:'
       LET g_errparam.popup = TRUE
       CALL cl_err()
       EXIT PROGRAM
   END IF
   DECLARE adzp168_dzfx_cs1 CURSOR FOR adzp168_dzfx_pre1

   FOREACH adzp168_dzfx_cs1 USING g_ver_ra,g_user,g_dzfq_m.dzfq004,g_ver_ra,g_user,g_dzfq_m.dzfq004 INTO l_tbtree_data[l_cnt].*
      IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'FOREACH:'
          LET g_errparam.popup = TRUE
          CALL cl_err()
          EXIT FOREACH
      END IF
      LET l_cnt = l_cnt + 1
   END FOREACH
   CALL l_tbtree_data.deleteelement(l_cnt)  #刪除FOREACH最後新增的空白列
   LET l_cnt = l_cnt - 1

   IF l_cnt >0 THEN
      LET l_level = p_plevel + 1
      FOR l_i=1 TO l_cnt
         LET g_tbtree_idx = g_tbtree_idx + 1

         LET g_tbtree[g_tbtree_idx].b_pid = p_pid CLIPPED
         LET l_str = l_i  #數值轉字串

         LET g_tbtree[g_tbtree_idx].b_id = g_tbtree[g_tbtree_idx].b_pid CLIPPED,".",l_str CLIPPED
         IF l_level = 1 THEN
            LET g_tbtree[g_tbtree_idx].b_img = l_img_dir CLIPPED,"headeraction"
         ELSE
            LET g_tbtree[g_tbtree_idx].b_img = l_img_dir CLIPPED,"detailaction"
         END IF

         LET g_tbtree[g_tbtree_idx].b_level = l_level
         LET g_tbtree[g_tbtree_idx].b_tableid = l_tbtree_data[l_i].dzfx004 CLIPPED   #Table編號
         CALL adzp168_tablename(g_tbtree[g_tbtree_idx].b_tableid) RETURNING g_tbtree[g_tbtree_idx].b_tablename
         EXECUTE adzp168_info_col_stus USING g_tbtree[g_tbtree_idx].b_tableid,g_lang INTO g_tbtree[g_tbtree_idx].b_stus,l_gzzd005

         #有子節點
         IF l_tbtree_data[l_i].child_cnt > 0 THEN
            LET g_tbtree[g_tbtree_idx].b_hasC = TRUE
            LET g_tbtree[g_tbtree_idx].b_exp = TRUE

            CALL adzp168_dzfx_fill(g_tbtree[g_tbtree_idx].b_id,g_tbtree[g_tbtree_idx].b_level,g_tbtree[g_tbtree_idx].b_tableid)
         ELSE
            LET g_tbtree[g_tbtree_idx].b_hasC = FALSE
            LET g_tbtree[g_tbtree_idx].b_exp = FALSE
         END IF
      END FOR


      #判斷遞迴結束
      #LET l_ln02 = g_tbtree.getLength()
      #IF l_ln01 = l_ln02 THEN   #data都放入array中
      #   CALL adzp168t2_fill_01()
      #END IF
   END IF
END FUNCTION


#+ 樹狀結構屬性設定檔底稿
PRIVATE FUNCTION adzp168t3_draft_fill()
   DEFINE l_dzff_d        type_g_dzff_d         #畫面結構設計附屬設定表

   LET g_sql = "INSERT INTO adzp168t3(dzff001,dzff002,dzff003,dzff004,dzff005",
                                           ",dzff006,dzff007,dzff008)",
                  " VALUES(?,?,?,?,? ,?,?,?)"
   PREPARE adzp168t3_ins_pre01 FROM g_sql

   LET g_sql = "SELECT dzfw004,dzfw005,dzfw006,dzfw007,dzfw008",
               " FROM dzfw_t",
               " WHERE dzfw001 = ? AND dzfw002 = ? AND dzfw003 = ?"
   PREPARE adzp168_dzfw_sel_pre01 FROM g_sql
   DECLARE adzp168_dzfw_sel_cur01 CURSOR FOR adzp168_dzfw_sel_pre01

   DELETE FROM adzp168t3
   FOREACH adzp168_dzfw_sel_cur01 USING g_ver_ra,g_user,g_dzfq_m.dzfq004
                                  INTO l_dzff_d.dzff003,l_dzff_d.dzff004,l_dzff_d.dzff005,l_dzff_d.dzff006,l_dzff_d.dzff007

      EXECUTE adzp168t3_ins_pre01 USING g_dzfq_m.dzfq004,g_ver_dzag003,
                                               l_dzff_d.dzff003,l_dzff_d.dzff004,l_dzff_d.dzff005,l_dzff_d.dzff006,l_dzff_d.dzff007,ms_dgenv
   END FOREACH
END FUNCTION


#+ 畫面樣版ToolBar功能鍵設定檔底稿(只記錄已勾選)
PRIVATE FUNCTION adzp168_toolbar_draft_fill()
   DEFINE l_cnt       LIKE type_t.num5
   DEFINE l_i         LIKE type_t.num5
   DEFINE l_dzfy004   LIKE dzfy_t.dzfy004

   LET l_cnt = g_toolbar.getLength()

   IF l_cnt > 0 THEN
      FOR l_i = 1 TO l_cnt
         IF g_toolbar[l_i].tb_act_id = l_dzfy004 THEN
            LET g_toolbar[l_i].toolbar_chk = "N"
         END IF
      END FOR

      LET g_sql = "SELECT dzfy004 FROM dzfy_t WHERE dzfy001 = ? AND dzfy002 = ? AND dzfy003 = ?"
      PREPARE adzp168_dzfy_sel_pre01 FROM g_sql
      DECLARE adzp168_dzfy_sel_cur01 CURSOR FOR adzp168_dzfy_sel_pre01
      FOREACH adzp168_dzfy_sel_cur01 USING g_ver_ra,g_user,g_dzfq_m.dzfq004 INTO l_dzfy004
         FOR l_i = 1 TO l_cnt
            IF g_toolbar[l_i].tb_act_id = l_dzfy004 THEN
               LET g_toolbar[l_i].toolbar_chk = "Y"
            END IF
         END FOR
      END FOREACH
   END IF
END FUNCTION


#+ 刪除底稿
PRIVATE FUNCTION adzp168_draft_del(p_confirm)
   DEFINE p_confirm   BOOLEAN   #是否顯示詢問視窗
   DEFINE l_chk       BOOLEAN
   DEFINE l_isdel     BOOLEAN   #是否刪除
   DEFINE l_cnt       LIKE type_t.num5

   LET l_chk = TRUE
   LET l_isdel = TRUE

   IF p_confirm THEN
      #畫面結構設計主檔底稿
      LET l_cnt = 0
      LET g_sql = "SELECT COUNT(dzfv004) FROM dzfv_t",
                   " WHERE dzfv002 = ? AND dzfv004 = ?"
      PREPARE adzp168_draft_read_dzfv_cnt_pre FROM g_sql
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'PREPARE draft_read:'
         LET g_errparam.popup = FALSE
         CALL cl_err()
      ELSE
         EXECUTE adzp168_draft_read_dzfv_cnt_pre USING g_user,g_dzfq_m.dzfq004 INTO l_cnt
      END IF

      IF l_cnt > 0 THEN
         IF NOT cl_ask_confirm_parm("adz-00165","") THEN   #請問是否要刪除底稿資料？
            LET l_isdel = FALSE
         END IF
      END IF
   END IF

   IF l_isdel THEN
      #畫面結構設計內容檔 - 刪除底稿
      LET g_sql = "DELETE FROM dzfz_t WHERE dzfz002 = ? AND dzfz003 = ?"
      PREPARE adzp168_dzfz_del FROM g_sql
      IF SQLCA.sqlcode THEN
         LET l_chk = FALSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'PREPARE draft_save_del_01:'
         LET g_errparam.popup = FALSE
         CALL cl_err()
      END IF

      #畫面結構設計主檔底稿 - 刪除包含舊的設計工具版號資料
      LET g_sql = "DELETE FROM dzfv_t WHERE dzfv002 = ? AND dzfv004 = ?"
      PREPARE adzp168_draft_save_dzfv_del FROM g_sql
      IF SQLCA.sqlcode THEN
         LET l_chk = FALSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'PREPARE draft_save_del_02:'
         LET g_errparam.popup = FALSE
         CALL cl_err()
      END IF

      #樹狀結構屬性設定檔底稿 - 刪除包含舊的設計工具版號資料
      LET g_sql = "DELETE FROM dzfw_t WHERE dzfw002 = ?  AND dzfw003 = ?"
      PREPARE adzp168_draft_save_dzfw_del FROM g_sql
      IF SQLCA.sqlcode THEN
         LET l_chk = FALSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'PREPARE draft_save_del_03:'
         LET g_errparam.popup = FALSE
         CALL cl_err()
      END IF

      #規格Table設定表底稿 - 刪除包含舊的設計工具版號資料
      LET g_sql = "DELETE FROM dzfx_t WHERE dzfx002 = ?  AND dzfx003 = ?"
      PREPARE adzp168_draft_save_dzfx_del FROM g_sql
      IF SQLCA.sqlcode THEN
         LET l_chk = FALSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'PREPARE draft_save_del_04:'
         LET g_errparam.popup = FALSE
         CALL cl_err()
      END IF

      #dzfy_t 畫面樣版ToolBar功能鍵設定檔底稿(只記錄已勾選)
      LET g_sql = "DELETE FROM dzfy_t WHERE dzfy002 = ?  AND dzfy003 = ?"
      PREPARE adzp168_draft_save_dzfy_del FROM g_sql
      IF SQLCA.sqlcode THEN
         LET l_chk = FALSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = 'PREPARE draft_save_del_05:'
         LET g_errparam.popup = FALSE
         CALL cl_err()
      END IF

      IF l_chk THEN
         EXECUTE adzp168_dzfz_del USING g_user,g_dzfq_m.dzfq004
         IF SQLCA.sqlcode THEN
            LET l_chk = FALSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'draft_save_del_01:'
            LET g_errparam.popup = FALSE
            CALL cl_err()
         END IF

         EXECUTE adzp168_draft_save_dzfv_del USING g_user,g_dzfq_m.dzfq004
         IF SQLCA.sqlcode THEN
            LET l_chk = FALSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'draft_save_del_02:'
            LET g_errparam.popup = FALSE
            CALL cl_err()
         END IF

         EXECUTE adzp168_draft_save_dzfw_del USING g_user,g_dzfq_m.dzfq004
         IF SQLCA.sqlcode THEN
            LET l_chk = FALSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'draft_save_del_03:'
            LET g_errparam.popup = FALSE
            CALL cl_err()
         END IF

         EXECUTE adzp168_draft_save_dzfx_del USING g_user,g_dzfq_m.dzfq004
         IF SQLCA.sqlcode THEN
            LET l_chk = FALSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'del: draft_save_del_04'
            LET g_errparam.popup = FALSE
            CALL cl_err()
         END IF

         EXECUTE adzp168_draft_save_dzfy_del USING g_user,g_dzfq_m.dzfq004
         IF SQLCA.sqlcode THEN
            LET l_chk = FALSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = 'draft_save_del_05:'
            LET g_errparam.popup = FALSE
            CALL cl_err()
         END IF
      END IF
   END IF

   RETURN l_chk
END FUNCTION

#+ 畫面樣版改變前
PRIVATE FUNCTION adzp168_tpl_change_before()
   DEFINE l_i LIKE type_t.num5
   DEFINE l_len LIKE type_t.num5

   LET g_dzfq_m_t02.* = g_dzfq_m.*      #保存單頭舊值
   CALL g_tbtree_t02.clear()

   #備份-資料表
   LET l_len = g_tbtree.getLength()
   FOR l_i = 1 TO l_len
      LET g_tbtree_t02[l_i].* = g_tbtree[l_i].*
   END FOR

   #備份-畫面結構
   DROP TABLE adzp168tt1
   SELECT * FROM adzp168t1 INTO TEMP adzp168tt1

END FUNCTION

#+ 畫面樣版改變後
PRIVATE FUNCTION adzp168_tpl_change_after()
   DEFINE l_i LIKE type_t.num5
   DEFINE l_len LIKE type_t.num5
   TYPE l_type_adzp168t1 RECORD
      arridx   INTEGER,       #array index: for 欄位
      dzfr003  INTEGER,       #編號(流水號)
      dzfr004  INTEGER,       #父節點編號
      dzfr005  INTEGER,       #順序(同階層中的排序)
      dzfr006  VARCHAR(20),   #4fd tag 類型
      dzfr007  VARCHAR(40),   #4fd tag name
      dzfr008  INTEGER,       #4fd tag name 編號
      dzfr009  VARCHAR(15),   #資料表代碼
      dzfr010  VARCHAR(20),   #欄位代碼
      dzfr011  VARCHAR(1),    #是否可刪除
      dzfr012  VARCHAR(40),   #4fd tag name前置名稱(s_detail/folder_/page_/page_info_/group_/Grid/HBox/VBox)
      dzeb004  VARCHAR(1),    #primary key
      dzeb022  VARCHAR(50),   #屬於哪一種欄位定義代碼(dzek001)
      dzekgrp  VARCHAR(50),   #欄位定義代碼群組grpUIBelong/grpUIStateinfo
      gzzd005  VARCHAR(200),  #畫面元件多語言 by g_lang
      dzef008  VARCHAR(80),   #參考欄位
      dzer007  VARCHAR(80)    #多語言欄位
      END RECORD
   DEFINE l_t02 l_type_adzp168t1
   DEFINE l_t03 l_type_adzp168t1

   IF (g_dzfq_m_t02.cbo_setbrowse = "00" AND g_dzfq_m.cbo_setbrowse ="sc") THEN
      #還原備份-資料表,資料表的欄位
      CALL g_tbtree.clear()
      CALL g_column.clear()

      LET l_len = g_tbtree_t02.getLength()
      FOR l_i = 1 TO l_len
         LET g_tbtree[l_i].* = g_tbtree_t02[l_i].*
         IF l_i = 2 THEN
            LET g_tbtree_idx = l_i
            CALL adzp168_col_fill(g_tbtree[g_tbtree_idx].b_tableid)
            IF g_column.getLength() > 0 THEN
               LET g_column_idx = 1
            END IF
         END IF
      END FOR

      #樣板轉換前
      LET g_sql = "SELECT * FROM adzp168tt1 ORDER BY arridx"
      PREPARE l_adzp168_tpl_change_after_pre2 FROM g_sql
      DECLARE l_adzp168_tpl_change_after_cur2 CURSOR FOR l_adzp168_tpl_change_after_pre2
      #樣板轉換後-公版無欄位,並且在轉換前就存在,表示這些節點底下可能需要保留轉換前的子節點
      DROP TABLE adzp168tt2
      SELECT * FROM adzp168t1 INTO TEMP adzp168tt2
      LET g_sql = "SELECT * FROM adzp168tt2 WHERE dzfr007 IN (SELECT dzfr007 FROM adzp168tt1) ORDER BY arridx"
      PREPARE l_adzp168_tpl_change_after_pre3 FROM g_sql
      DECLARE l_adzp168_tpl_change_after_cur3 CURSOR FOR l_adzp168_tpl_change_after_pre3

      #DISPLAY "adzp168tt1:"
      #FOREACH l_adzp168_tpl_change_after_cur2 INTO l_t02.*
      #   DISPLAY l_t02.arridx,",",l_t02.dzfr003,",",l_t02.dzfr004,",",l_t02.dzfr007,",",l_t02.dzfr010
      #END FOREACH

      #DISPLAY "adzp168tt2:"
      #FOREACH l_adzp168_tpl_change_after_cur3 INTO l_t03.*
      #   DISPLAY l_t03.arridx,",",l_t03.dzfr003,",",l_t03.dzfr004,",",l_t03.dzfr007,",",l_t03.dzfr010
      #END FOREACH

      FOREACH l_adzp168_tpl_change_after_cur3 INTO l_t03.*
         IF l_t03.dzfr004 = "0" THEN
            SELECT dzfr003 INTO l_t02.dzfr003 FROM adzp168tt1 WHERE dzfr007 = l_t03.dzfr007
            CALL adzp168_tpl_change_tpl(l_t02.dzfr003,l_t03.dzfr007)
         END IF
      END FOREACH

      CALL adzp168_form_tree_fill("0",0,"0",FALSE)   #刪完後再重整tree
      CALL adzp168_col_setcolor()

      DROP TABLE adzp168tt1
      DROP TABLE adzp168tt2
   END IF
END FUNCTION

#+ 畫面樣版Tree資料
PRIVATE FUNCTION adzp168_tpl_change_tpl(p_dzfr004,p_dzfr007)
   DEFINE p_dzfr004       LIKE dzfr_t.dzfr004   #父節點編號
   DEFINE p_dzfr007       LIKE dzfr_t.dzfr007   #4fd tag name
   DEFINE l_dzfr003       LIKE dzfr_t.dzfr003   #編號(流水號)
   DEFINE l_new_dzfr003   LIKE dzfr_t.dzfr003   #編號(流水號)
   DEFINE l_new_dzfr004   LIKE dzfr_t.dzfr004   #父節點編號
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_cnt_2         LIKE type_t.num5
   TYPE l_type_adzp168t1 RECORD
      arridx   INTEGER,       #array index: for 欄位
      dzfr003  INTEGER,       #編號(流水號)
      dzfr004  INTEGER,       #父節點編號
      dzfr005  INTEGER,       #順序(同階層中的排序)
      dzfr006  VARCHAR(20),   #4fd tag 類型
      dzfr007  VARCHAR(40),   #4fd tag name
      dzfr008  INTEGER,       #4fd tag name 編號
      dzfr009  VARCHAR(15),   #資料表代碼
      dzfr010  VARCHAR(20),   #欄位代碼
      dzfr011  VARCHAR(1),    #是否可刪除
      dzfr012  VARCHAR(40),   #4fd tag name前置名稱(s_detail/folder_/page_/page_info_/group_/Grid/HBox/VBox)
      dzeb004  VARCHAR(1),    #primary key
      dzeb022  VARCHAR(50),   #屬於哪一種欄位定義代碼(dzek001)
      dzekgrp  VARCHAR(50),   #欄位定義代碼群組grpUIBelong/grpUIStateinfo
      gzzd005  VARCHAR(200),  #畫面元件多語言 by g_lang
      dzef008  VARCHAR(80),   #參考欄位
      dzer007  VARCHAR(80)    #多語言欄位
      END RECORD
   DEFINE l_form_data     DYNAMIC ARRAY OF l_type_adzp168t1

   LET g_sql ="SELECT * FROM adzp168tt1 WHERE dzfr004 =? ORDER BY dzfr005"
   PREPARE adzp168_tpl_change_tpl_pre01 FROM g_sql
   DECLARE adzp168_tpl_change_tpl_cur01 CURSOR FOR adzp168_tpl_change_tpl_pre01
   #在FOREACH中直接使用recursive,資料會錯亂,所以先將資料放到陣列後處理
   LET l_cnt = 1
   CALL l_form_data.clear()
   FOREACH adzp168_tpl_change_tpl_cur01 USING p_dzfr004 INTO l_form_data[l_cnt].*
      IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = 'FOREACH:'
          LET g_errparam.popup = TRUE
          CALL cl_err()
          EXIT FOREACH
      END IF
      LET l_cnt = l_cnt + 1
   END FOREACH
   CALL l_form_data.deleteelement(l_cnt)  #刪除FOREACH最後新增的空白列
   LET l_cnt = l_cnt - 1

   IF l_cnt >0 THEN
      FOR l_i=1 TO l_cnt
         #已存在不用加入,再往下找
         SELECT COUNT(*) INTO l_cnt_2 FROM adzp168tt2 WHERE dzfr007 = l_form_data[l_i].dzfr007
         IF l_cnt_2 = 0 THEN
            #加入
            CALL adzp168t1_new_dzfr003() RETURNING l_new_dzfr003   #暫存檔編號(流水號) - for新增資料
            SELECT dzfr003 INTO l_new_dzfr004 FROM adzp168t1 WHERE dzfr007 = p_dzfr007
            EXECUTE adzp168t1_ins USING l_new_dzfr003,l_new_dzfr004,l_form_data[l_i].dzfr005,l_form_data[l_i].dzfr006,l_form_data[l_i].dzfr007,l_form_data[l_i].dzfr008,l_form_data[l_i].dzfr009,l_form_data[l_i].dzfr010,l_form_data[l_i].dzfr011,l_form_data[l_i].dzfr012,l_form_data[l_i].dzeb004,l_form_data[l_i].dzeb022,l_form_data[l_i].dzekgrp,l_form_data[l_i].gzzd005,l_form_data[l_i].dzef008,l_form_data[l_i].dzer007
         END IF
         #是否有子節點
         SELECT COUNT(*) INTO l_cnt_2 FROM adzp168tt1 WHERE dzfr004 = l_form_data[l_i].dzfr003
         IF l_cnt_2 > 0 THEN
            CALL adzp168_tpl_change_tpl(l_form_data[l_i].dzfr003,l_form_data[l_i].dzfr007)
         END IF
      END FOR
   END IF
END FUNCTION

############################################################
#+ @code
#+ 函式目的  動態設定元件是否可輸入
#+ @param    ps_fields  STRING     要設定元件是否可輸入的欄位名稱字串(中間以逗點分隔)
#+ @param    pi_entry   NUMBER(5)  是否可輸入(TRUE→可輸入,FALSE→不可輸入)
############################################################
#因為library中的cl_set_comp_entry不設"active"，
#導致r.a問題:
#1.選Q001和Q002切換時,無法正確設定欄位是否可以輸入(RadioGroup,ComboBox)
#2.選Q001,按"欄位設定"頁籤,再按回"基本項目"頁籤....閃一下回不去
PRIVATE FUNCTION adzp168_set_comp_entry(ps_fields,pi_entry)
  DEFINE ps_fields     STRING
  DEFINE pi_entry      LIKE type_t.num5
  DEFINE lst_fields    base.StringTokenizer
  DEFINE ls_field_name STRING
  #DEFINE lwin_curr     ui.Window #test
  #DEFINE lnode_win     om.DomNode #test
  DEFINE llst_items    om.NodeList
  DEFINE li_i          LIKE type_t.num5
  DEFINE lnode_item    om.DomNode
  DEFINE ls_item_name  STRING
  DEFINE lc_field      LIKE type_t.chr20
  DEFINE dd            ui.Dialog     #test

  LET dd = ui.Dialog.getCurrent()   #test

  IF dd IS NULL THEN   #test
     RETURN
  END IF

  IF g_bgjob = 'Y' AND g_gui_type NOT MATCHES "[13]" THEN
     RETURN
  END IF

  IF (ps_fields IS NULL) THEN
     RETURN
  END IF

  LET ps_fields = ps_fields.toLowerCase()

  LET lst_fields = base.StringTokenizer.create(ps_fields, ",")

  #LET lwin_curr = ui.Window.getCurrent() #test
  #LET lnode_win = lwin_curr.getNode() #test

  #LET llst_items = lnode_win.selectByPath("//Form//*") #test

  WHILE lst_fields.hasMoreTokens()
    LET ls_field_name = lst_fields.nextToken()
    LET ls_field_name = ls_field_name.trim()

    #T6 只可以鎖定主要輸入頁面
    IF NOT ls_field_name.getIndexOf("_t",1) OR NOT ls_field_name.getIndexOf("formonly.",1) THEN

       #判斷是不是多語言檔或提速檔
       LET lc_field = ls_field_name
       SELECT dzea004 INTO lc_field FROM dzea_t,dzeb_t
        WHERE dzeb001 = dzea001
          AND dzeb002 = lc_field

       IF lc_field = "L" OR lc_field = "V" THEN
          LET ls_field_name = ls_field_name.subString(1,5),"_t.",ls_field_name
       ELSE
          LET ls_field_name = ls_field_name.subString(1,4),"_t.",ls_field_name
       END IF
    END IF

    IF (ls_field_name.getLength() > 0) THEN
       CALL dd.setFieldActive(ls_field_name,pi_entry) #test
       #FOR li_i = 1 TO llst_items.getLength()
       #    LET lnode_item = llst_items.item(li_i)
       #
       #    #先抓取Name (有含table.colname) 不存在再試抓 colName (不含table name)
       #    LET ls_item_name = lnode_item.getAttribute("name")
       #
       #    IF (ls_item_name IS NULL) THEN
       #       LET ls_item_name = lnode_item.getAttribute("colName")
       #
       #       IF (ls_item_name IS NULL) THEN
       #          CONTINUE FOR
       #       END IF
       #    END IF
       #
       #    LET ls_item_name = ls_item_name.trim()
       #
       #    IF (ls_item_name.equals(ls_field_name)) THEN
       #       #不特別再設active屬性, 讓是否輸入狀態自動導致active值改變
       #       #因為在新增狀態下程式規範將pk欄位開啟, 若規格設定INPUT內不輸入pk欄位,
       #       #會導致介面被改為active+entry的外觀但卻無法輸入
       #       IF (pi_entry) THEN
       #          CALL lnode_item.setAttribute("noEntry", "0")
       #          CALL lnode_item.setAttribute("active", "1")   #和library不同
       #       ELSE
       #          CALL lnode_item.setAttribute("noEntry", "1")
       #          CALL lnode_item.setAttribute("active", "0")   #和library不同
       #       END IF
       #
       #       EXIT FOR
       #    END IF
       #END FOR
    END IF
  END WHILE
END FUNCTION
#adzp168tt1:
#          1,          1,          0,vb_master,
#          2,          3,          1,folder_1,
#          3,          4,          3,page_1,
#          4,         24,          4,           ,itya001
#          5,         25,          4,           ,itya002
#          6,         26,          4,           ,itya003
#          7,         27,          4,           ,itya004
#          8,          2,          0,vb_detail,
#          9,          5,          2,s_detail1,
#         10,         16,          5,           ,ityb003
#         11,         17,          5,           ,itybownid
#         12,         18,          5,           ,itybowndp
#         13,         19,          5,           ,itybcrtid
#         14,         20,          5,           ,itybcrtdp
#         15,         21,          5,           ,itybcrtdt
#         16,         22,          5,           ,itybmodid
#         17,         23,          5,           ,itybmoddt
#adzp168tt2:
##排除      1,          1,          0,s_browse,
#          2,          2,          0,vb_master,
#          3,          4,          2,folder_1,
#          4,          5,          4,page_1,
#          5,          3,          0,vb_detail,
#          6,          6,          3,s_detail1,

#adzp168tt1:                                         p_dzfr004=     1,vb_master
#          1,      1,  0,vb_master,                        p_dzfr004=     3,folder_1
#          2,      3,  1,folder_1,                         p_dzfr004=     4,page_1
#          3,      4,  3,page_1,                           加入    10,     5,             ,itya001
#          4,     29,  4,             ,itya001             加入    11,     5,             ,itya002
#          5,     30,  4,             ,itya002             加入    12,     4,page_info_1
#          6,      9,  3,page_info_1,                      p_dzfr004=     9,page_info_1
#          7,     10,  9,             ,ityaownid           加入    13,    12,             ,ityaownid
#          8,      2,  0,vb_detail,                        p_dzfr004=     2,vb_detail
#          9,      5,  2,HBox1,                            p_dzfr004=     5,HBox1
#         10,      6,  5,folder_2,                         p_dzfr004=     6,folder_2
#         11,      7,  6,page_2,                           p_dzfr004=     7,page_2
#         12,      8,  7,s_detail1,                        p_dzfr004=     8,s_detail1
#         13,     31,  8,             ,ityb003             加入    14,     9,             ,ityb003
#         14,     19,  6,page_info_2,                      加入    15,     7,page_info_2
#         15,     20, 19,s_detail2,                        p_dzfr004=    19,page_info_2
#         16,     21, 20,             ,ityb003             加入    16,    15,s_detail2,
#         17,     22, 20,             ,itybownid           p_dzfr004=    20,s_detail2
#adzp168tt2:                                         加入    17,    16,             ,ityb003
#          2,      2,  0,vb_master,                        加入    18,    16,             ,itybownid
#          3,      4,  2,folder_1,
#          4,      5,  4,page_1,
#          5,      3,  0,vb_detail,
#          6,      6,  3,HBox1,
#          7,      7,  6,folder_2,
#          8,      8,  7,page_2,
#          9,      9,  8,s_detail1,