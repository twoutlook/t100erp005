#+ Version....: T6-ERP-1.00.00 Build-000005
#+
#+ Filename...: adzp168全域變數
#+ Buildtype..:
#+ Memo.......:

SCHEMA ds

GLOBALS
   #單頭 type 宣告
   TYPE type_g_dzfq_m        RECORD
      dzfq001 LIKE dzfq_t.dzfq001,   #結構代號
      dzfq002 LIKE dzfq_t.dzfq002,   #版號
      dzfq003 LIKE dzfq_t.dzfq003,   #識別碼版號 1
      dzfq004 LIKE dzfq_t.dzfq004,   #畫面代號
      dzfq005 LIKE dzfq_t.dzfq005,   #主/子程式(M:主程式與畫面、S:子程式與畫面、F:子畫面（含應用元件畫面）)
      dzfq006 LIKE dzfq_t.dzfq006,   #單頭資料(mq:多筆/sq:單筆)
      dzfq007 LIKE dzfq_t.dzfq007,   #單頭框架(Folder/Group/Grid)
      dzfq008 LIKE dzfq_t.dzfq008,   #換行數量
      dzfq009 LIKE dzfq_t.dzfq009,   #單身切割框架(sarray:單一/Folder/HBox/VBox/HFolder/VFolder/HGroup/VGroup)
      dzfq010 LIKE dzfq_t.dzfq010,   #單身框架(Table/Tree/ScrollGrid)
      dzfq011 LIKE dzfq_t.dzfq011,   #單身狀態碼功能鍵區塊
      dzfq012 LIKE dzfq_t.dzfq012,   #單身串查(Y:需要 /N:不需要)
      dzfq013 LIKE dzfq_t.dzfq013,   #子程式進入模式(m:全功能/ i:INPUT / c:CONSTRUCT)
      dzfq014 LIKE dzfq_t.dzfq014,   #空框架程式碼 Y/N
      dzfq015 LIKE dzfq_t.dzfq015,   #空框架畫面檔 Y/N
      dzfq016 LIKE dzfq_t.dzfq016,   #樹狀結構類別(recu_01:遞迴單檔樹狀/ recu_02:遞迴主從表樹狀/ type_01:階層分類樹狀)
      dzfqstus       LIKE dzfq_t.dzfqstus,
      dzfqmodid      LIKE dzfq_t.dzfqmodid,
      dzfqmodid_desc LIKE type_t.chr500,
      dzfqmoddt      DATETIME YEAR TO SECOND,
      dzfqownid      LIKE dzfq_t.dzfqownid,
      dzfqownid_desc LIKE type_t.chr500,
      dzfqowndp      LIKE dzfq_t.dzfqowndp,
      dzfqowndp_desc LIKE type_t.chr500,
      dzfqcrtid      LIKE dzfq_t.dzfqcrtid,
      dzfqcrtid_desc LIKE type_t.chr500,
      dzfqcrtdp      LIKE dzfq_t.dzfqcrtdp,
      dzfqcrtdp_desc LIKE type_t.chr500,
      dzfqcrtdt      DATETIME YEAR TO SECOND,
      cbo_progtype   STRING,                  #程式類型(S/F/R/P/Q)
      cbo_formtype   STRING,                  #畫面類型(001/002/003...)
      cbo_setbrowse  STRING,                  #資料瀏覽區塊 (00不需要/ sc查詢方案/ ht左方樹狀/ vt上方樹狀)
      gzzal003       LIKE gzzal_t.gzzal003    #程式名稱
      END RECORD

   #單身 type 宣告
   TYPE type_g_dzfr_d        RECORD
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
      dzer007   LIKE dzer_t.dzer007,   #多語言欄位

      child_cnt LIKE type_t.num5       #子節點數
      END RECORD


   TYPE type_toolbar RECORD
      tb_img       STRING,               #圖片
      tb_act_id    STRING,               #Action ID
      tb_act_name  STRING,               #Action 名稱
      toolbar_chk  LIKE type_t.chr1      #是否生效Y/N
      END RECORD

   TYPE type_form_tree RECORD    #畫面樣版架構-tree
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
      dzeb005   LIKE dzeb_t.dzeb005,   #資料表設計器設計欄位是否可為null
      gztd003   LIKE gztd_t.gztd003,   #欄位資料型態
      gztd008   LIKE gztd_t.gztd008,   #欄位資料長度
      dzep009   LIKE dzep_t.dzep009,   #欄位顯示寬度
      dzep010   LIKE dzep_t.dzep010,   #欄位顯示控件代碼
      dzep020   LIKE dzep_t.dzep020,   #程式串查設定
      dzej003   LIKE dzej_t.dzej003,   #欄位顯示控件
      dzef006   LIKE dzef_t.dzef006,   #參考欄位所屬資料表
      dzef008   LIKE dzef_t.dzef008,   #參考欄位*
      dzer005   LIKE dzer_t.dzer005,   #取值表格
      dzer007   LIKE dzer_t.dzer007,   #多語言欄位*
      dzet006   LIKE dzet_t.dzet006,   #助記碼欄位
      detailPK  LIKE type_t.chr30      #單身多頁籤的PK欄位時,widget name的名稱(單身第2個頁籤之後的PK欄位)
      END RECORD

   TYPE type_g_tbtree    RECORD        #程式主Table設定表
      b_tableid        LIKE dzea_t.dzea001,    #節點名稱: 資料表代碼
      b_tablename      LIKE dzeal_t.dzeal003,  #資料表名稱
      b_img            STRING,                 #節點圖片
      b_pid            LIKE type_t.chr100,     #父節點id
      b_id             LIKE type_t.chr100,     #節點id
      b_hasC           BOOLEAN,                #是否有有子節點 0:否 1:是
      b_exp            BOOLEAN,                #是否展開 0:不展開 1:展開
      b_level          LIKE type_t.num5,       #階層
      b_stus           LIKE dzeb_t.dzeb002     #狀態碼欄位
      END RECORD

   TYPE type_g_dzfx_data    RECORD     #程式主Table設定表底稿
      dzfx004          LIKE dzfx_t.dzfx004,    #Table編號
      dzfx005          LIKE dzfx_t.dzfx005,    #上層Table編號
      child_cnt        LIKE type_t.num5        #子節點數
      END RECORD

   #模組變數(Module Variables)
   DEFINE g_dzfq_m          type_g_dzfq_m
   DEFINE g_dzfq_m_t        type_g_dzfq_m

   DEFINE g_tplcode DYNAMIC ARRAY OF RECORD #解析現有公版的結構代號
          dzfm001    LIKE dzfm_t.dzfm001,   #結構代號
          progtype   STRING,
          formtype   STRING,
          setbrowse  STRING
          END RECORD

   DEFINE g_tbtree     DYNAMIC ARRAY OF type_g_tbtree    #程式主Table設定表
   DEFINE g_form_tree  DYNAMIC ARRAY OF type_form_tree   #畫面樣版架構-tree
   DEFINE g_toolbar    DYNAMIC ARRAY OF type_toolbar

   DEFINE g_4fd_inf       RECORD       #產生4fd所需要的資訊
      form_browse_idx  LIKE type_t.num10,   #瀏覽表index
      form_vbm_idx     LIKE type_t.num10,   #單頭index,vb_master在陣列中的索引
      form_vbd_idx     LIKE type_t.num10,   #單身index,vb_detail在陣列中的索引
      form_vbd_exp_idx LIKE type_t.num10,   #單身底下附屬區塊index,單身凍結vb_detailexp在陣列中的索引
      form_vbhl_idx    LIKE type_t.num10,   #單頭固定區塊index,vb_headerlock在陣列中的索引
      d_tb1            LIKE dzea_t.dzea001, #第一個單身的Table
      l_jiashuangdang  BOOLEAN              #是否為假雙檔
      END RECORD


   #for sadzp168_1() Tree ----------------
   TYPE type_g_dzff_d RECORD
      dzff001   LIKE dzff_t.dzff001,  #程式代號
      dzff002   LIKE dzff_t.dzff002,  #設計點版本  1.0
      dzff003   LIKE dzff_t.dzff003,  #4fd tag name (s_browse,s_detail1)
      dzff004   LIKE dzff_t.dzff004,  #編號
      dzff005   LIKE dzff_t.dzff005,  #屬性(ex.描述desc,pid,id,type,提速檔speed,spid,sid,stype)
      dzff006   LIKE dzff_t.dzff006,  #資料表代碼
      dzff007   LIKE dzff_t.dzff007,  #欄位代號
      dzff008   LIKE dzff_t.dzff008   #使用標示 (s:標準/ c:客製)
      END RECORD

   DEFINE g_dzff_default  DYNAMIC ARRAY OF type_g_dzff_d   #預設可設定的屬性
   DEFINE g_dzff_d        DYNAMIC ARRAY OF type_g_dzff_d
   #for sadzp168_1() Tree ---------------- END

   DEFINE g_erpalm          STRING                #是否啟動ALM  Y/N
   DEFINE ms_dgenv          LIKE dzaa_t.dzaa009   #環境變數DGENV客製標示(s:標準/ c:客製)
   #DEFINE g_cust            LIKE type_t.chr1      #客製碼   0:非客製 / 1:客製
   DEFINE g_gzza003         LIKE gzza_t.gzza003   #模組代碼(基本資料中的模組)
   DEFINE g_gzza003_module  LIKE gzza_t.gzza003   #實際模組(標準程式從設計器轉客製後基本資料的模組是AXM,但實際目錄模組會是CXM)

   #DEFINE g_ver_dzae002     LIKE dzae_t.dzae002   #程式版次   #No Use
   DEFINE g_ver_dzba002     LIKE dzba_t.dzba002   #程式代碼版次
   DEFINE g_ver_dzaa002     LIKE dzaa_t.dzaa002   #規格版次(dzaa002)
   DEFINE g_ver_dzag003     LIKE dzag_t.dzag003   #識別碼版次(dzaa004)
   #DEFINE g_ver_dzfb002     LIKE dzfb_t.dzfb002   #設計器版本(no use)      #todo
   #DEFINE g_ver_dzfb003     LIKE dzfb_t.dzfb003   #設計資料版本計數(no use) #todo
   DEFINE g_ver_tpl         LIKE dzfm_t.dzfm002   #畫面樣版結構版號
   DEFINE g_ver_ra          LIKE dzfv_t.dzfv001   #設計工具版號

   DEFINE g_rtn_msg         BOOLEAN               #FALSE:副程式自己顯示顯示訊息 TRUE:回傳給呼叫者自己顯示訊息(for Jay)

DEFINE g_udset RECORD   #for adzp169
   dzfq005           LIKE dzfq_t.dzfq005,     #程式類型
   dzfi001           LIKE dzfi_t.dzfi001,     #結構代號(畫面代號)
   udtable           LIKE dzeb_t.dzeb001,     #資料表來源
   udcol             LIKE dzeb_t.dzeb002,     #自定義欄位
   gzzal003          LIKE gzzal_t.gzzal003,   #程式名稱
   dzebl003          LIKE dzebl_t.dzebl003,   #自定義欄位名稱
   dzfj006           LIKE dzfj_t.dzfj006,     #控件類型
   dzfj005_rel       LIKE dzfj_t.dzfj005,     #相對欄位
   rel_position      LIKE type_t.chr1,        #相對位置 1..之上,2.之下
   dzca001_i         LIKE dzca_t.dzca001,     #編輯時開窗adzi210
   dzca001_c         LIKE dzca_t.dzca001,     #查詢時開窗adzi210
   dzcd001           LIKE dzcd_t.dzcd001,     #校驗帶值adzi220; r.t的校驗帶值dzep019可存放多個,並且以逗號分隔,此處快速開通欄位,先用一個就好
   dzca001_i_desc    LIKE dzcal_t.dzcal003,   #編輯時開窗
   dzca001_c_desc    LIKE dzcal_t.dzcal003,   #查詢時開窗
   dzcd001_desc      LIKE dzcdl_t.dzcdl003    #校驗帶值
   END RECORD
DEFINE g_dzaf003     LIKE dzaf_t.dzaf003      #規格版號
DEFINE g_dzaf010     LIKE dzaf_t.dzaf010      #識別標示 s/c

#▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂
   #for sadzp168_3() 4fd設計資料schema------------------------
   
   #欄位field type種類
   CONSTANT g_non_database = "1"     #NON_DATABASE   
   CONSTANT g_column_like =  "2"     #COLUMN_LIKE
   CONSTANT g_table_alias =  "3"     #TABLE_ALIAS
   CONSTANT g_table_column = "4"     #TABLE_COLUMN

   TYPE type_g_dzfi             RECORD          #畫面結構檔
      dzfi001          LIKE dzfi_t.dzfi001,     #結構代號(PK)
      dzfi002          LIKE dzfi_t.dzfi002,     #版次(PK)
      dzfi003          LIKE dzfi_t.dzfi003,     #編號(資料流水號)(PK)
      dzfi004          LIKE dzfi_t.dzfi004,     #群組代碼
      dzfi005          LIKE dzfi_t.dzfi005,     #順序
      dzfi006          LIKE dzfi_t.dzfi006,     #元件組代碼
      dzfi007          LIKE dzfi_t.dzfi007,     #節點類型
      dzfi008          LIKE dzfi_t.dzfi008,     #是否顯示於畫面結構
      dzfi009          LIKE dzfi_t.dzfi009,     #識別標示:s-標準產品, c-客製(PK)
      dzfi010          LIKE dzfi_t.dzfi010,     #包含元素類型(0:Container, 1:元件組合, 2:xml, 3:Widget)
      dzfi011          LIKE dzfi_t.dzfi011,     #直橫排列V/H
      dzfi012          LIKE dzfi_t.dzfi012,     #節點階層
      dzfi013          LIKE dzfi_t.dzfi013,     #群組X軸位置
      dzfi014          LIKE dzfi_t.dzfi014,     #群組Y軸位置
      dzfi015          LIKE dzfi_t.dzfi015,     #群組寬度
      dzfi016          LIKE dzfi_t.dzfi016,     #群組高度
      dzfiownid        LIKE dzfi_t.dzfiownid, 
      dzfiowndp        LIKE dzfi_t.dzfiowndp, 
      dzficrtid        LIKE dzfi_t.dzficrtid, 
      dzficrtdp        LIKE dzfi_t.dzficrtdp, 
      dzficrtdt        LIKE dzfi_t.dzficrtdt, 
      dzfimodid        LIKE dzfi_t.dzfimodid, 
      dzfimoddt        LIKE dzfi_t.dzfimoddt,
      dzfistus         LIKE dzfi_t.dzfistus,
      dzfi017          LIKE dzfi_t.dzfi017      #客戶代號
      END RECORD
                
   TYPE type_g_dzfj             RECORD          #畫面元件組合檔
      dzfj001          LIKE dzfj_t.dzfj001,
      dzfj002          LIKE dzfj_t.dzfj002,
      dzfj003          LIKE dzfj_t.dzfj003,     #元件組代碼
      dzfj004          LIKE dzfj_t.dzfj004,     #順序
      dzfj005          LIKE dzfj_t.dzfj005,     #包含元件代碼
      dzfj006          LIKE dzfj_t.dzfj006,     #節點類型
      dzfj007          LIKE dzfj_t.dzfj007,     #所屬結構類型
      dzfj008          LIKE dzfj_t.dzfj008,     #所屬結構代碼
      dzfj009          LIKE dzfj_t.dzfj009,     #所屬結構標籤代碼
      dzfj010          LIKE dzfj_t.dzfj010,     #欄位標籤代碼
      dzfj011          LIKE dzfj_t.dzfj011,     #參考欄位控件代號
      dzfj012          LIKE dzfj_t.dzfj012,     #是否為參考欄位
      dzfj013          LIKE dzfj_t.dzfj013,     #元件X軸位置
      dzfj014          LIKE dzfj_t.dzfj014,     #元件Y軸位置
      dzfj015          LIKE dzfj_t.dzfj015,     #元件寬度
      dzfj016          LIKE dzfj_t.dzfj016,     #元件高度
      dzfjstus         LIKE dzfj_t.dzfjstus,
      dzfj017          LIKE dzfj_t.dzfj017,     #識別標示
      dzfj018          LIKE dzfj_t.dzfj018      #客戶代號
      END RECORD
   
   TYPE type_g_dzfk             RECORD          #畫面元件屬性檔
      dzfk001          LIKE dzfk_t.dzfk001,     #結構代號
      dzfk002          LIKE dzfk_t.dzfk002,     #(產品)版號
      dzfk003          LIKE dzfk_t.dzfk003,     #元件代碼
      dzfk004          LIKE dzfk_t.dzfk004,     #no use
      dzfk005          LIKE dzfk_t.dzfk005,     #no use
      dzfk006          LIKE dzfk_t.dzfk006,     #no use
      dzfk007          LIKE dzfk_t.dzfk007,     #識別標示
      dzfk008          LIKE dzfk_t.dzfk008,     #客戶代號
      dzfk009          LIKE dzfk_t.dzfk009      #屬性值
      END RECORD
                
   TYPE type_g_dzfl             RECORD          #畫面元件屬性檔
      dzfl001          LIKE dzfl_t.dzfl001,
      dzfl002          LIKE dzfl_t.dzfl002,
      dzfl003          LIKE dzfl_t.dzfl003,
      dzfl004          LIKE dzfl_t.dzfl004,
      dzfl005          LIKE dzfl_t.dzfl005,
      dzfl006          LIKE dzfl_t.dzfl006,
      dzflstus         LIKE dzfl_t.dzflstus,
      dzfl007          LIKE dzfl_t.dzfl007,     #識別標示
      dzfl008          LIKE dzfl_t.dzfl008      #客戶代號
      END RECORD

   TYPE type_g_field RECORD
      dzfr003          LIKE dzfr_t.dzfr003,     #節點編號
      sort             LIKE dzfr_t.dzfr005,     #欄位排序
      sqlTabName       LIKE dzfr_t.dzfr009,     #欄位所屬table名稱
      colName          LIKE dzfr_t.dzfr010,     #欄位名稱
      attrName         LIKE type_t.chr50,       #table名稱.欄位名稱, exp:dzea_t.dzea001
      attrRequired     LIKE dzeb_t.dzeb004,     #required目前先假定為primary key,就需為Y
      notNull          LIKE dzeb_t.dzeb005,     #資料表設計器設計欄位是否可為null
      datatype         LIKE gztd_t.gztd003,     #欄位資料型態
      length           LIKE gztd_t.gztd008,     #欄位資料長度
      dzep010          LIKE dzep_t.dzep010,     #欄位顯示控件代碼
      dzej003          LIKE dzej_t.dzej003,     #欄位r.t預設顯示控件
      widget           base.StringBuffer,       #欄位顯示控件
      widgetName       base.StringBuffer,       #控件代號
      widgetWidth      LIKE dzep_t.dzep009,     #控件畫面寬度
      reftable         LIKE dzef_t.dzef006,     #參考欄位所屬資料表
      refField         LIKE dzef_t.dzef008,     #參考欄位
      dzai005          base.StringBuffer,       #參考欄位所依附的欄位控件名稱(dzef002:widget name)
      dzai002          base.StringBuffer,       #參考欄位的控件名稱(dzef008:widget name)
      langField        LIKE dzer_t.dzer007,     #多語言欄位#todo:#
      dzer005          LIKE dzer_t.dzer005,     #多語言欄位的取值表格代碼
      dzaj005          base.StringBuffer,       #多語言欄位所依附的欄位控件名稱(dzer002:widget name)
      dzaj002          base.StringBuffer,       #多語言欄位的控件名稱(dzer007:widget name)
      mnemField        LIKE dzet_t.dzet006,     #助記碼欄位#todo:#
      dzet002          LIKE dzet_t.dzet002,     #助記碼欄位所依附的欄位控件名稱(dzet002:widget name)
      detailPK         LIKE type_t.chr30,       #單身多頁籤的PK欄位時,widget name的名稱(單身第2個頁籤之後的PK欄位)
      dzep020          LIKE dzep_t.dzep020,     #程式串查設定
      dzal005          base.StringBuffer,       #串查所依附的欄位控件名稱
      dzal002          base.StringBuffer,       #串查的控件名稱
      dzekWarp         LIKE type_t.chr1,        #共用欄位是否需折行
      dzek001          LIKE dzek_t.dzek001,     #共用欄位隸屬那一個分群(dzek001)
      dzeb022          LIKE dzeb_t.dzeb022,     #屬於哪一種欄位定義代碼(dzek002)
      srowSeq          LIKE type_t.num5,        #行排序
      srow             LIKE type_t.chr10,       #欄位所屬行名稱
      dzfr006          LIKE dzfr_t.dzfr006,     #4fd tag 類型
      dzep021          LIKE dzep_t.dzep021,     #欄位顯示格式
      dzep022          LIKE dzep_t.dzep022,     #串查型態
      dzep023          LIKE dzep_t.dzep023      #大小寫   #by Saki
             END RECORD 

   TYPE type_g_widget_info RECORD    #欄位widget設計資訊
      dzeb005          LIKE dzeb_t.dzeb005,     #資料表設計器設計欄位是否可為null
      gztd003          LIKE gztd_t.gztd003,     #欄位資料型態
      gztd008          LIKE gztd_t.gztd008,     #欄位資料長度
      dzep009          LIKE dzep_t.dzep009,     #欄位顯示寬度
      dzep010          LIKE dzep_t.dzep010,     #欄位顯示控件代碼
      dzep020          LIKE dzep_t.dzep020,     #程式串查設定
      dzej003          LIKE dzej_t.dzej003,     #欄位顯示控件
      dzef006          LIKE dzef_t.dzef006,     #參考欄位所屬資料表
      dzef008          LIKE dzef_t.dzef008,     #參考欄位*
      dzer005          LIKE dzer_t.dzer005,     #取值表格
      dzer007          LIKE dzer_t.dzer007,     #多語言欄位*
      dzet006          LIKE dzet_t.dzet006,     #助記碼欄位
      dzep021          LIKE dzep_t.dzep021,     #顯示格式
      dzep022          LIKE dzep_t.dzep022,     #串查型態
      dzep023          LIKE dzep_t.dzep023      #大小寫   #by Saki
      END RECORD
   
   DEFINE g_fieldId_max      LIKE type_t.num10  #4fd上 fieldid 最大值
   DEFINE g_tabIndex_max     LIKE type_t.num10  #4fd上 tabIndex 最大值 

   #for sadzp168_3() 4fd設計資料schema------------------------ END
     

END GLOBALS