#+ 程式版本......: T6 Version 1.00.00 Build-0001 at 13/02/22
#
#+ 程式代碼......: adzp168
#+ 設計人員......: Jay
# Prog. Version..: 'T6-12.01.21(00000)'     #
#
# Program name   : sadzp168_4fd.4gl 
# Description    : 4fd畫面自動產生工具
# Memo           :
# 各widget屬性請參考:C:\Program Files\FourJs\Genero Studio-2.40.11\gst\conf\mod-fd.spec
# Modify         : 2014/09/01 by Hiko : dzac006,dzac007預設給NULL.
#                : 2015/05/08 by Hiko : NOT NULL由dzeb005改成dzep005
#                : 2016/08/17 by tracy_lee : 位於Table中的必要欄位，不可隱藏 (FUN 160817-00025)

IMPORT os
SCHEMA ds

GLOBALS "../../cfg/top_global.inc"
GLOBALS "../4gl/adzp168_global.inc"

CONSTANT g_module = "mdl"     #各template所在路徑
CONSTANT g_stus = "stus"      #資料表[狀態碼]欄位尾碼關鍵字
CONSTANT g_modu = "modu"      #資料表共用欄位(modu,oriu,user...):以[資料修改者]欄位尾碼關鍵字為判斷依據

#結構類型
CONSTANT g_browse = "s_browse"          #(1)瀏覽表(browser)
CONSTANT g_table = 2                    #(2)Table容器(單檔多欄用)
CONSTANT g_master = "vb_master"         #(3)單頭
CONSTANT g_detail = "vb_detail"         #(4)單身
CONSTANT g_btree = "b_tree"             #(5)樹狀
CONSTANT g_detailexp = "vb_detailexp"   #(6)單身鎖定
CONSTANT g_common = "common_info"       #(7)公用欄位
CONSTANT g_qbe = "qbe"                  #(8)QBE Grid
CONSTANT g_headerlock = "vb_headerlock" #(9)單頭鎖定
#CONSTANT g_scroll_grid = "ScrollGrid"   #(8)ScrollGrid

#畫面樣版結構設計檔 type 宣告
TYPE type_g_dzfm          RECORD
   dzfm003   LIKE dzfm_t.dzfm003,   #編號(流水號)
   dzfm004   LIKE dzfm_t.dzfm004,   #群組代碼
   dzfm005   LIKE dzfm_t.dzfm005,   #順序
   dzfm006   LIKE dzfm_t.dzfm006,   #元件(組)代碼
   dzfm007   LIKE dzfm_t.dzfm007,   #節點類型
   dzfm008   LIKE dzfm_t.dzfm008,   #畫面結構中是否顯示
   dzfm009   LIKE dzfm_t.dzfm009,   #包含元素類型
   dzfm010   LIKE dzfm_t.dzfm010    #直橫排列V/H
   END RECORD

#page資訊 type定義
TYPE type_g_page_info RECORD
                spage         STRING,               #LIKE dzfb_t.dzfb008,
                container     STRING,
                stable        STRING,               #此page如果為單身結構:則需紀錄r.a的table元件名稱
                ##dzfr009       LIKE dzfr_t.dzfr009,  #此page如果為單身結構:則需紀錄資料表代碼
                dzfr012       LIKE dzfr_t.dzfr012,  #page tag name前置名稱(如:公用欄位頁籤-"page_info_")
                ##sflag         LIKE type_t.chr1,     #此page的資料表是否在4fd裡第一次出現(後面的page如果也是同資料表,就不再產出公用欄位)
                child_node    STRING,               #子節點container樣式(如:Table, ScrollGrid ...)
                sfield        DYNAMIC ARRAY OF type_g_field
             END RECORD
             
#每個page下的欄位list
TYPE type_g_page DYNAMIC ARRAY OF type_g_page_info

#每個folder下所包含的page
TYPE type_g_folder DYNAMIC ARRAY OF RECORD
                sfolder       STRING,               #LIKE dzfb_t.dzfb006,
                container     STRING,
                spage         type_g_page
             END RECORD

#adzp168右邊Tree View下的結構類型
TYPE type_g_structure DYNAMIC ARRAY OF RECORD
                structure    STRING,     #樣版所定義的結構類型名稱(dzfm006=>dzfm008='Y')
                container    STRING,     #結構類型的container樣式(如:VBox, HBox, table, tree...)
                stype        STRING,     #結構類型所屬分類(如:瀏灠表, 單頭, 單身, Tree)
                sfolder      type_g_folder
             END RECORD

#單身各頁籤的PK欄位
TYPE type_g_pk_field DYNAMIC ARRAY OF RECORD
                widget       STRING,
                colName      LIKE dzfr_t.dzfr010,   #欄位名稱
                detailPK     LIKE type_t.chr30      #單身多頁籤的PK欄位時,widget name的名稱(單身第2個頁籤之後的PK欄位)
             END RECORD

#單身各頁籤的PK
TYPE type_g_detail_pk DYNAMIC ARRAY OF RECORD
                table_container_name   STRING,      #table[container]在4fd上的widget name
                pk_field               type_g_pk_field
             END RECORD

DEFINE g_dzfr                type_g_structure        #畫面結構資料

DEFINE g_template_node       om.DomNode              #UI樣版
DEFINE g_form                om.DomNode              #樣版上的Form節點
DEFINE g_sr_ref              om.DomNode              #新增SR節點時,所需參考的SR(Undefined)節點
DEFINE g_container_node_t    om.DomNode              #目前正在進行插入欄位widget設計資料的container node備份
DEFINE g_detail_child        om.DomNode              #單身的第一個欄位資訊
DEFINE g_detail_lbl_child    om.DomNode              #單身的第一個欄位Static Label節點資訊
#DEFINE g_detail_sr_child     om.DomNode              #單身sr的第一個欄位資訊

DEFINE g_grid_num            LIKE type_t.num5        #新增grid時,grid目前用到第幾個
DEFINE g_hbox_num            LIKE type_t.num5        #新增hbox時,hbox目前用到第幾個
DEFINE g_num                 LIKE type_t.num5        #紀錄目前用的container序號

DEFINE g_dzaa006             LIKE type_t.chr1        #使用標示:s-標準產品, c-客製
DEFINE g_searchcol_items     STRING                  #單頭的searchcol comboBox下可以提供查詢的[欄位]Items項目
DEFINE g_detail_pk           type_g_detail_pk        #記錄單身各頁籤的PK欄位

DEFINE g_master_grid_info    DYNAMIC ARRAY OF om.DomNode     #單頭共用欄位的父節點(container node)
DEFINE g_load_grid_state     LIKE type_t.chr1                #此次畫面設計資料中是否已經載入過切片
#DEFINE g_is_frame            LIKE type_t.chr1
DEFINE g_dzaa008             LIKE dzaa_t.dzaa008     #產品版本
DEFINE g_dzaa009             LIKE dzaa_t.dzaa009     #識別標示
DEFINE g_dzaa010             LIKE dzaa_t.dzaa010     #客戶代號
#DEFINE g_dzaa011             LIKE dzaa_t.dzaa011     #本版次異動

FUNCTION sadzp168_4fd(p_prog)
   DEFINE p_prog            LIKE dzfi_t.dzfi001   #UI程式代號

   DEFINE l_result            BOOLEAN

   WHENEVER ERROR CALL cl_err_msg_log
   
   IF cl_null(p_prog) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00009"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF

   CALL sadzp168_init(p_prog)

   #取得結構代號樣版
   LET g_template_node = sadzp168_get_ui_template()

   IF g_template_node IS NULL THEN
      RETURN FALSE
   END IF

   #依r.a設置組合需要的切片檔至樣版檔中
   IF NOT sadzp168_get_template_snippet(g_template_node) THEN
      RETURN FALSE
   END IF
   
   #IF sadzp168_2_gen_4fd_file(p_prog, g_template_node) THEN
   #   DISPLAY "structure."
   #END IF
   
   #產生空框架畫面檔
   IF g_dzfq_m.dzfq015 = "N" THEN
      #依畫面樣版結構點取得r.a設計資料
      IF NOT sadzp168_get_dzfr_data() THEN
         RETURN FALSE
      END IF

      #將r.a設計資料新增至畫面樣版中
      IF NOT sadzp168_add_node(g_template_node) THEN
         RETURN FALSE
      END IF
   END IF

   #實際生成 4fd畫面檔
   IF NOT sadzp168_2_gen_4fd_file(p_prog, g_template_node, TRUE) THEN
      RETURN FALSE
   END IF

   RETURN TRUE
END FUNCTION

#+ 程式相關資料初始化
PRIVATE FUNCTION sadzp168_init(p_prog)
   DEFINE p_prog            LIKE dzfi_t.dzfi001   #UI程式代號
   
   DEFINE l_sql             STRING

   CALL g_dzfr.clear()
   CALL g_detail_pk.clear()
   CALL g_master_grid_info.clear()

   LET g_num = 1
   LET g_fieldId_max = 0
   LET g_tabIndex_max = 0

   LET g_dzaa006 = FGL_GETENV("DGENV")     #"s":標準; "c"客製
   LET g_dzaa008 = FGL_GETENV("ERPVER")    #產品版本
   LET g_dzaa009 = FGL_GETENV("DGENV")     #識別標示
   LET g_dzaa010 = FGL_GETENV("CUST")      #客戶代號
   
   LET g_load_grid_state = FALSE

   #取得欄位相關設計資訊
   LET l_sql = "SELECT DISTINCT dzep005, gztd003, gztd008, dzep009, dzep010, ",
               "                dzep020, dzej003, dzef006, dzef008, dzer005, ",
               "                dzer007, dzet006, dzep021, dzep022, dzep023 ",   #by Saki add dzep023
               " FROM dzfr_t LEFT JOIN dzeb_t ON dzfr009 = dzeb001 AND dzfr010 = dzeb002 ",
               "    LEFT JOIN gztd_t ON dzeb006 = gztd001 ",
               "    LEFT JOIN dzep_t ON dzeb001 = dzep001 AND dzeb002 = dzep002 ",
               "    LEFT JOIN dzej_t ON dzep010 = dzej002 AND dzej001 = 'GENERO_WIDGETS' ",
               "    LEFT JOIN dzef_t ON dzfr009 = dzef001 AND dzfr010 = dzef002 ",  #AND dzef010 = 1
               "    LEFT JOIN dzer_t ON dzfr009 = dzer001 AND dzfr010 = dzer002 ",  #AND dzer003 = 1 ",
               "    LEFT JOIN dzet_t ON dzfr009 = dzet001 AND dzfr010 = dzet002 ",
               " WHERE dzfr006 = 'Field' AND dzfr001 = ? AND dzfr002 = ? AND dzfr009 = ? AND dzfr010 = ? "
   PREPARE sadzp168_field_info_pre FROM l_sql
   
   ##多語言關聯設定
   #LET l_sql = "SELECT * FROM dzer_t ",
   #            "  WHERE dzer001 = ? AND dzer002 = ?",
   #            "  ORDER BY dzer003"
                     
   #PREPARE sadzp168_dzer FROM l_sql
   #DECLARE dzer_cs CURSOR FOR sadzp168_dzer


   ##程式狀態碼設定
   #LET l_sql = "SELECT dzft004, dzft005 FROM dzft_t ",
   #            "  WHERE dzftstus = 'Y' ", 
   #            "    AND dzft001 = ? AND dzft002 = ? ",
   #            "    AND dzft003 = ? AND dzft006 = ? ",
   #            "  ORDER BY dzft007"
   #                  
   #PREPARE sadzp168_dzft FROM l_sql
   #DECLARE dzft_cs CURSOR FOR sadzp168_dzft

   #取得資料表FK欄位設定
   LET l_sql = "SELECT dzed004 FROM dzed_t ",
               "  WHERE dzed001 = ? AND dzed003 = 'F' ",
               "    AND dzed005 = (SELECT dzag004 FROM dzag_t ",
               "                     WHERE dzag001 = ? AND dzag002 = ? ",
               "                       AND dzag003 = ? AND dzag005 = 'N' ",
               "                       AND dzag006 = ?)"
               
   PREPARE sadzp168_dzed_fk_pre FROM l_sql
   DECLARE sadzp168_dzed_fk_cur CURSOR FOR sadzp168_dzed_fk_pre

   #取得資料表PK欄位設定   
   LET l_sql = "SELECT dzeb002 FROM dzeb_t WHERE dzeb001 = ? AND dzeb004 = 'Y'"
   
   PREPARE sadzp168_dzeb_pk_pre FROM l_sql   
   DECLARE sadzp168_dzeb_pk_cur CURSOR FOR sadzp168_dzeb_pk_pre

   #UPDATE 欄位設計資訊中的欄位寬度和欄位高度
   LET l_sql = "UPDATE adzp168t2 SET dzep009 = ?, widget_hight = ? ",
               "  WHERE dzfr003 = ?"
   PREPARE sadzp168_168t2_upd_pre FROM l_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  SQLCA.sqlcode
      LET g_errparam.extend = 'PREPARE sadzp168_168t2_upd_pre:'
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF

   #取得此排橫向控件最大高度
   #LET l_sql = "SELECT MAX(widget_hight) FROM adzp168t2 ",
   #            "  WHERE (cont_tagname, dzfr005) IN ", 
   #            "    (SELECT cont_tagname, dzfr005 FROM adzp168t2 ", 
   #            "       WHERE dzfr003 = ?)"
   LET l_sql = "SELECT MAX(widget_hight) FROM adzp168t2 ",
               "    WHERE cont_tagname = ? AND row_seq = ? "
   PREPARE sadzp168_widget_hight_pre FROM l_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  SQLCA.sqlcode
      LET g_errparam.extend = 'PREPARE sadzp168_widget_hight_pre:'
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF

   #取得此排直向控件最大寬度
   LET l_sql = "SELECT MAX(dzep009) FROM adzp168t2 ",
               "  WHERE (cont_tagname, dzfr005) IN ",
               "    (SELECT cont_tagname, dzfr005 FROM adzp168t2 ",
               "       WHERE dzfr003 = ?)"
   PREPARE sadzp168_widget_width_pre FROM l_sql
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  SQLCA.sqlcode
      LET g_errparam.extend = 'PREPARE sadzp168_widget_width_pre:'
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF

   #取得Tree相關設計資訊
   LET l_sql = "SELECT DISTINCT dzfr007 FROM adzp168t1 ",
               "  WHERE dzfr006 = 'Tree' "
   PREPARE sadzp168_tree_info_pre FROM l_sql
   DECLARE sadzp168_tree_info_cur CURSOR FOR sadzp168_tree_info_pre
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  SQLCA.sqlcode
      LET g_errparam.extend = 'PREPARE sadzp168_tree_info_cur:'
      LET g_errparam.popup = TRUE
      CALL cl_err()
   END IF
END FUNCTION

#+ 載入程式所屬UI template node
PRIVATE FUNCTION sadzp168_get_ui_template()
   DEFINE l_template_file   STRING         #UI樣版檔檔案名稱,form_xxx_x.4fd
   DEFINE l_file            STRING         #4fd路徑
   DEFINE l_statepic        om.DomNode     #browse上的b_statepic欄位
   
   DEFINE r_template_node   om.DomNode     #UI樣版

   INITIALIZE r_template_node TO NULL
   INITIALIZE g_form TO NULL
   INITIALIZE g_sr_ref TO NULL
   INITIALIZE l_statepic TO NULL

   LET l_file = ""
   
   #取得樣版結構代號
   LET l_template_file = g_dzfq_m.dzfq001 CLIPPED, ".snippet"

   #取得樣版檔案所在完整路徑
   LET l_file = sadzp168_load_file(l_template_file)
   IF cl_null(l_file) THEN
      INITIALIZE r_template_node TO NULL
      RETURN r_template_node
   END IF

   #取得整個樣版檔domNode
   LET r_template_node = sadzp168_2_load_xml_to_dom(l_file)

   IF r_template_node IS NULL THEN
      #樣版檔載入失敗.
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00070"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] =  l_template_file CLIPPED
      CALL cl_err()
      
      INITIALIZE r_template_node TO NULL
      RETURN r_template_node
   END IF

   #todo:
   #1.取得樣版的Form節點
   #2.取得一個參考的Screen Record節點,目前預設取得[Undefined]
   #  預備之後新增Screen Record節點,可參考其屬性
   LET g_form = sadzp168_2_get_domNode(r_template_node, "Form", "name", g_dzfq_m.dzfq001)
   LET g_sr_ref = sadzp168_2_get_domNode(r_template_node, "Record", "name", "Undefined")

   #設置Form的程式代碼和顯示title
   CALL g_form.setAttribute("name", g_dzfq_m.dzfq004 CLIPPED)
   CALL g_form.setAttribute("text", g_dzfq_m.dzfq004 CLIPPED)
   #取得樣版版型在tag註記中
   CALL g_form.setAttribute("tag", g_dzfq_m.dzfq001 CLIPPED)
   
   #取得UI畫面樣版檔目前所使用的fieldId和tabIndex最大值
   CALL sadzp168_2_search_fieldId_tabIndex_max(r_template_node, g_fieldId_max, g_tabIndex_max)
      RETURNING g_fieldId_max, g_tabIndex_max

   #todo:假雙檔在browse上的b_statepic欄位目前先隱藏
   IF g_4fd_inf.l_jiashuangdang THEN
      LET l_statepic = sadzp168_2_get_domNode(r_template_node, "FFImage", "name", "b_statepic")
      
      IF l_statepic IS NOT NULL THEN
         CALL l_statepic.setAttribute("hidden", "true")
      END IF
   END IF
   
   RETURN r_template_node
END FUNCTION

#+ 載入UI樣版設定資訊xml
PRIVATE FUNCTION sadzp168_load_snippet_file(p_node, p_snippet_file)
   DEFINE p_node             om.DomNode
   DEFINE p_snippet_file     STRING       #要轉成domNode的切片檔案

   DEFINE r_snippet_node     om.DomNode

   INITIALIZE r_snippet_node TO NULL
   
   #取得切片檔所在完整路徑
   LET p_snippet_file = sadzp168_load_file(p_snippet_file)
   
   IF cl_null(p_snippet_file) THEN
      DISPLAY "The ", p_snippet_file, " snippet isn't exist."   #無切片檔案.
      RETURN r_snippet_node
   END IF

   #將單頭切片檔加入樣版檔中
   LET r_snippet_node = p_node.loadXml(p_snippet_file) 

   IF r_snippet_node IS NULL THEN
      #樣版檔插入切片檔時失敗.
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00070"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] =  p_snippet_file.trim()
      CALL cl_err()
   END IF

   RETURN r_snippet_node
END FUNCTION

#+ 載入UI樣版設定資訊xml
PRIVATE FUNCTION sadzp168_load_file(p_file)
   DEFINE p_file             STRING       #要轉成domNode的檔案
   DEFINE ln_node            om.DomNode   
   DEFINE r_file             STRING       #檔案完整路徑組合
   
   INITIALIZE ln_node TO NULL

   LET r_file = ""
   
   #取得UI畫面樣版檔:form_xxxxx.4fd檔
   LET r_file = os.Path.join(FGL_GETENV("ERP"), g_module)
   LET r_file = os.Path.join(r_file, p_file)

   IF (NOT cl_null(r_file)) AND (NOT os.Path.exists(r_file)) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00010"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_file = ""
   END IF

   RETURN r_file
END FUNCTION

#+ 取得該結構代號樣版下有那些結構
PRIVATE FUNCTION sadzp168_get_template_snippet(p_template_node)
   DEFINE p_template_node   om.DomNode     #UI樣版
   
   DEFINE l_dzfm            type_g_dzfm    #畫面樣版結構設計檔
   DEFINE l_sql             STRING
   
   IF cl_null(g_dzfq_m.dzfq001) THEN
      #程式代碼不存在
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00009"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF

   #取得樣版結構(如:雙檔有s_browse, vb_master, vb_detail), dzfm008='Y':表示為畫面結構檔位置(r.a可新增欄位設計資料)
   LET l_sql = "SELECT dzfm003, dzfm004, dzfm005, dzfm006, dzfm007, ",
               "       dzfm008, dzfm009, dzfm010 ",
               "  FROM dzfm_t ",
               "  WHERE dzfm001 = ? AND dzfm002 = ? AND dzfm008 = 'Y' ",
               "  ORDER BY dzfm003"
               
   PREPARE sadzp168_dzfm FROM l_sql
   DECLARE dzfm_cs CURSOR FOR sadzp168_dzfm
   
   OPEN dzfm_cs USING g_dzfq_m.dzfq001, g_dzfq_m.dzfq002
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "OPEN dzfm_cs:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE dzfm_cs
      RETURN FALSE
   END IF

   #取得畫面結構(如:雙檔有s_browse, vb_master, vb_detail)
   FOREACH dzfm_cs INTO l_dzfm.*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH dzfm_cs:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN FALSE
      END IF

      #依結構代號不同,加入樣版檔公版所需要的snippet檔
      CASE l_dzfm.dzfm006
         WHEN g_master     #單頭"vb_master" 
            IF NOT sadzp168_get_master_snippet(p_template_node, l_dzfm.*) THEN
               RETURN FALSE
            END IF
            
         WHEN g_detail     #單身"vb_detail" 
           IF NOT sadzp168_get_detail_snippet(p_template_node, l_dzfm.*) THEN
              RETURN FALSE
           END IF

         WHEN g_detailexp  #單身鎖定"vb_detailexp"
           IF NOT sadzp168_get_detailexp_snippet(p_template_node, l_dzfm.*) THEN
              RETURN FALSE
           END IF
           
      END CASE
   END FOREACH

   #單頭資料筆數設定(mq:多筆, sq:單筆)
   #IF (NOT cl_null(g_dzfq_m.dzfq006)) AND (g_dzfq_m.dzfq006 = "mq") THEN
   IF NOT cl_null(g_dzfq_m.dzfq006) THEN
      IF NOT sadzp168_get_quantity_snippet(p_template_node) THEN
         DISPLAY "sadzp167_get_quantity_snippet is null."
      END IF
   END IF
   
   RETURN TRUE
END FUNCTION

#+ 載入本次畫面設計檔單頭需要的公版snippet
PRIVATE FUNCTION sadzp168_get_master_snippet(p_template_node, p_dzfm)
   DEFINE p_template_node   om.DomNode              #UI樣版
   DEFINE p_dzfm            type_g_dzfm             #畫面樣版結構設計檔
   
   DEFINE l_structure_node  om.DomNode              #要加入切片node的主結構node(如:vb_master, vb_detail)
   DEFINE l_snippet_file    STRING                  #切片檔案名稱
   DEFINE l_node            om.DomNode
   DEFINE l_dzea001         LIKE dzea_t.dzea001     #資料表名稱
   
   INITIALIZE l_structure_node TO NULL
   INITIALIZE l_node TO NULL
   
   LET l_snippet_file = ""
   LET l_dzea001 = ""
   
   ######取得單頭切片檔(snippet)#####
   #取得樣版檔是否有單頭結構(dzfm006:元件組代碼, dzfm007:節點類型)
   LET l_structure_node = sadzp168_2_get_domNode(p_template_node, p_dzfm.dzfm007, "name", p_dzfm.dzfm006)

   IF l_structure_node IS NULL THEN
      #樣版單頭結構點不存在
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00072"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] =  p_dzfm.dzfm006 CLIPPED
      CALL cl_err()
      RETURN FALSE
   END IF
   
   LET l_snippet_file = "master_"
 
   #取得單頭container結構樣式
   LET l_snippet_file = l_snippet_file, g_dzfq_m.dzfq007 CLIPPED
   
   LET l_snippet_file = l_snippet_file, ".snippet"

   #取得單頭切片檔
   LET l_node = sadzp168_load_snippet_file(l_structure_node, l_snippet_file)

   IF l_node IS NULL THEN
      RETURN FALSE
   END IF

   #處理切片檔中有些widget需要在Screen Record增加一個子節點
   CALL sadzp168_add_template_sr_node(l_node)

   CALL sadzp168_container_resize(l_node, l_node.getAttribute("gridWidth"), l_node.getAttribute("gridHeight"))
   
   RETURN TRUE
END FUNCTION

#+ 載入本次畫面設計檔單身需要的公版snippet
PRIVATE FUNCTION sadzp168_get_detail_snippet(p_template_node, p_dzfm)
   DEFINE p_template_node   om.DomNode              #UI樣版
   DEFINE p_dzfm            type_g_dzfm             #畫面樣版結構設計檔
   
   DEFINE l_structure_node  om.DomNode              #要加入切片node的主結構node(如:vb_master, vb_detail)
   DEFINE l_snippet_file    STRING                  #切片檔案名稱
   DEFINE l_node            om.DomNode
   DEFINE l_sr_node         om.DomNode              #Table的Screen Record節點
   DEFINE l_parent_node     om.DomNode              #切片檔的父節點
   DEFINE l_table_node      om.DomNode              #Table(container)的節點
   DEFINE l_dzea001         LIKE dzea_t.dzea001     #資料表代碼
   DEFINE l_sr_node_list    om.NodeList             #Table(container)的sr節點
   DEFINE l_i               LIKE type_t.num5
   DEFINE l_name            STRING
   DEFINE l_dzfq010         LIKE dzfq_t.dzfq010     #單身框架樣式
   
   INITIALIZE l_structure_node TO NULL
   INITIALIZE l_node TO NULL
   INITIALIZE l_sr_node TO NULL

   LET l_dzea001 = ""   
   LET l_snippet_file = ""
   LET l_dzfq010 = ""
   
   ######取得單身切片檔(snippet)#####
   #取得樣版檔是否有單身結構(dzfm006:元件組代碼, dzfm007:節點類型)
   LET l_structure_node = sadzp168_2_get_domNode(p_template_node, p_dzfm.dzfm007, "name", p_dzfm.dzfm006)

   IF l_structure_node IS NULL THEN
      #樣版單身結構點不存在
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00072"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] =  p_dzfm.dzfm006 CLIPPED
      CALL cl_err()
      RETURN FALSE
   END IF
   
   LET l_snippet_file = "detail_"

   #Q類版型
   IF g_dzfq_m.cbo_progtype = "Q" THEN
      LET l_snippet_file = "Q_", l_snippet_file.trim()
   END IF
   
   #取得單身切割框架樣式
   LET l_snippet_file = l_snippet_file, g_dzfq_m.dzfq009 CLIPPED, "_"

   #取得單身框架樣式(Table, ScrollGrid)
   LET l_snippet_file = l_snippet_file, g_dzfq_m.dzfq010 CLIPPED   #, "_"
   LET l_dzfq010 = g_dzfq_m.dzfq010 CLIPPED
   IF cl_null(l_dzfq010) THEN
      LET l_dzfq010 = "Table"
   END IF
   
   ####取得單身狀態碼功能鍵區塊
   ###LET l_snippet_file = l_snippet_file, g_dzfq_m.dzfq011 CLIPPED
   
   LET l_snippet_file = l_snippet_file, ".snippet"
   
   #取得單身切片檔
   LET l_node = sadzp168_load_snippet_file(l_structure_node, l_snippet_file)

   IF l_node IS NULL THEN
      RETURN FALSE
   END IF

   #Q類公版切片--Tree裡的子節點加上tag="tree_clone"(以利複製)
   CALL sadzp168_tree_init(l_node, "", "1")
   
   #####新增Table或ScrollGrid的Screen Record節點#####
   #取得樣版切片檔中有多少個Table或ScrollGrid(container)元件
   LET l_parent_node = l_node.getParent()
   LET l_sr_node_list = l_parent_node.selectByTagName(l_dzfq010)

   #檢查該Table或ScrollGrid相對應的SR節點是否存在
   FOR l_i = 1 to l_sr_node_list.getLength()
      LET l_table_node = l_sr_node_list.item(l_i)
      LET l_name = l_table_node.getAttribute("name")

      #尋找SR節點是否已存在樣版中
      LET l_sr_node = sadzp168_2_get_domNode(p_template_node, "Record", "name", l_name)

      #SR節點不存在時,新增此節點   
      IF l_sr_node IS NULL THEN
         LET l_sr_node = sadzp168_add_sr_structure(p_template_node, l_name)
      END IF

      #處理切片檔中有些widget需要在Screen Record增加一個子節點
      CALL sadzp168_add_template_sr_node(l_table_node)
   END FOR

   CALL sadzp168_container_resize(l_node, l_node.getAttribute("gridWidth"), l_node.getAttribute("gridHeight"))
   
   RETURN TRUE
END FUNCTION

#+ 載入本次畫面設計檔單頭資料是[多筆]或[單筆]需要的公版snippet
PRIVATE FUNCTION sadzp168_get_quantity_snippet(p_template_node)
   DEFINE p_template_node   om.DomNode              #UI樣版
   
   DEFINE l_structure_node  om.DomNode              #要加入切片node的主結構node(vb_quantity)
   DEFINE l_snippet_file    STRING                  #切片檔案名稱
   DEFINE l_node            om.DomNode
   DEFINE l_detail_qry      om.DomNode              #單身串查action node
   
   INITIALIZE l_structure_node TO NULL
   INITIALIZE l_node TO NULL
   INITIALIZE l_detail_qry TO NULL
   
   LET l_snippet_file = ""
   
   #取得單頭資料是[多筆]或[單筆]的結構點(是否出現控制上/下筆移動控制等action)
   LET l_structure_node = sadzp168_2_get_domNode(p_template_node, "VBox", "name", "vb_quantity")

   #vb_quantity結構點不一定會在存在切片檔中
   IF l_structure_node IS NULL THEN
      RETURN FALSE
   END IF

   #Q類版型vb_quantity切片規則不同
   IF g_dzfq_m.dzfq001 MATCHES "Q001*" OR g_dzfq_m.dzfq001 MATCHES "P002*" THEN
      IF (g_tbtree.getLength() - 1) >= 2 THEN
         LET l_snippet_file = g_dzfq_m.dzfq001 CLIPPED, "_", "2.snippet"
      ELSE
         LET l_snippet_file = g_dzfq_m.dzfq001 CLIPPED, "_", "1.snippet"
      END IF
   ELSE
      #取得樣版結構代號和切片檔案名稱(mq:多筆/sq:單筆)
      LET l_snippet_file = g_dzfq_m.dzfq001 CLIPPED, "_", g_dzfq_m.dzfq006 CLIPPED, ".snippet"
   END IF
   
   #取得單頭資料多筆切片檔
   LET l_node = sadzp168_load_snippet_file(l_structure_node, l_snippet_file)

   IF l_node IS NULL THEN
      RETURN FALSE
   END IF

   
   #####處理單身串查action#####
   #取得此畫面代號是否[設置單身串查功能]
   IF g_dzfq_m.dzfq012 = "N" THEN
      #取得樣版中單身串查功能button節點(detail_qrystr)
      LET l_detail_qry = sadzp168_2_get_domNode(l_node, "Button", "name", "detail_qrystr")

      #130515討論出r.a的[單身串查]若沒有勾選,採隱藏方式--而不要直接刪除節點.
      #所以以下邏輯mark
      #IF l_detail_qry IS NOT NULL THEN
      #   INITIALIZE l_node TO NULL
      #
      #   #取得單身串查button的父節點
      #   LET l_node = l_detail_qry.getParent()
      #
      #   #沒有[設置單身串查功能],所以刪除此節點
      #   CALL l_node.removeChild(l_detail_qry)
      #END IF
      CALL l_detail_qry.setAttribute("hidden", "true")
   END IF

   #處理切片檔中有些widget需要在Screen Record增加一個子節點
   CALL sadzp168_add_template_sr_node(l_node)

   CALL sadzp168_container_resize(l_node, l_node.getAttribute("gridWidth"), l_node.getAttribute("gridHeight"))

   RETURN TRUE
END FUNCTION

#+ 載入本次畫面設計檔單身鎖定需要的公版snippet
PRIVATE FUNCTION sadzp168_get_detailexp_snippet(p_template_node, p_dzfm)
   DEFINE p_template_node   om.DomNode              #UI樣版
   DEFINE p_dzfm            type_g_dzfm             #畫面樣版結構設計檔
   
   DEFINE l_structure_node  om.DomNode              #要加入切片node的主結構node(如:vb_master, vb_detail)
   DEFINE l_snippet_file    STRING                  #切片檔案名稱
   DEFINE l_node            om.DomNode
   
   INITIALIZE l_structure_node TO NULL
   INITIALIZE l_node TO NULL
   
   LET l_snippet_file = ""
   
   ######取得單身鎖定切片檔(snippet)#####
   #取得樣版檔單身鎖定(vb_detailexp)結構(dzfm006:元件組代碼, dzfm007:節點類型)
   LET l_structure_node = sadzp168_2_get_domNode(p_template_node, p_dzfm.dzfm007, "name", p_dzfm.dzfm006)

   IF l_structure_node IS NULL THEN
      #樣版單頭結構點不存在
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00072"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] =  p_dzfm.dzfm006 CLIPPED
      CALL cl_err()
      RETURN FALSE
   END IF

   #todo:目前單身鎖定固定取得detailexp_Folder.snippet切片
   LET l_snippet_file = "detailexp_Folder.snippet"
   
   #取得單身鎖定切片檔
   LET l_node = sadzp168_load_snippet_file(l_structure_node, l_snippet_file) 

   IF l_node IS NULL THEN
      RETURN FALSE
   END IF

   #處理切片檔中有些widget需要在Screen Record增加一個子節點
   CALL sadzp168_add_template_sr_node(l_node)
   
   CALL sadzp168_container_resize(l_node, l_node.getAttribute("gridWidth"), l_node.getAttribute("gridHeight"))
   
   RETURN TRUE
END FUNCTION

#+ 取得本次畫面設計檔的主要資料表
PRIVATE FUNCTION sadzp168_get_main_table()
   DEFINE l_i               LIKE type_t.num10
   DEFINE l_dzea001         LIKE dzea_t.dzea001     #資料表代碼

   LET l_dzea001 = ""
   
   IF g_tbtree.getLength() = 0 THEN
      #取得主要(master)資料表代碼失敗--單頭資料表代碼不存在
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00071"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN l_dzea001
   END IF

   FOR l_i = 1 TO g_tbtree.getLength()
       IF g_tbtree[l_i].b_pid = "0" AND g_tbtree[l_i].b_id = "0.1" THEN
          LET l_dzea001 = g_tbtree[l_i].b_tableid
          EXIT FOR
       END IF
   END FOR

   RETURN l_dzea001
END FUNCTION

#+ 檢查欄位名稱是否存在
PRIVATE FUNCTION sadzp168_get_field_exist(p_dzeb001, p_dzeb002)
   DEFINE p_dzeb001         LIKE dzeb_t.dzeb001   #資料表名稱
   DEFINE p_dzeb002         LIKE dzeb_t.dzeb002   #欄位名稱
   
   DEFINE l_cnt             LIKE type_t.num5

   LET l_cnt = 0
   
   SELECT COUNT(*) INTO l_cnt FROM dzeb_t 
     WHERE dzeb001 = p_dzeb001
       AND dzeb002 LIKE '%' || p_dzeb002
   
   IF l_cnt > 0 THEN
      RETURN TRUE
   END IF

   DISPLAY p_dzeb002, " does not exist in the ", p_dzeb001, "."
   RETURN FALSE
END FUNCTION

#+ 處理公版 切片檔中有些widget需要在Screen Record增加一個子節點
#  (todo:初步判斷widget有fieldId屬性)
PRIVATE FUNCTION sadzp168_add_template_sr_node(p_domNode)
   DEFINE p_domNode         om.DomNode            #公版的切片檔(snippet檔)

   DEFINE l_parent_node     om.DomNode            #widget的父節點
   DEFINE l_sr_node         om.DomNode            #Screen Record節點
   DEFINE l_sr_child        om.DomNode            #SR要新增的子節點欄位

   INITIALIZE l_parent_node TO NULL
   INITIALIZE l_sr_node TO NULL
   INITIALIZE l_sr_child TO NULL

   #####新增SR的子節點#####
   #130731:dzfq015 = "Y" 時表示產生空框架畫面檔,這時候就需要將table裡的預設欄位[defaultb]也產生一筆SR node
   IF NOT cl_null(p_domNode.getAttribute("fieldId")) AND ((p_domNode.getAttribute("name") <> "defaultb") OR g_dzfq_m.dzfq015 = "Y") THEN
      #重新取得一個新的fieldId值(因為樣版檔是以組合snippet檔方式,fieldId有可能會重覆)
      #fieldId值依續加1
      CALL sadzp168_2_field_add_index(p_domNode, "fieldId", g_fieldId_max, g_tabIndex_max)
         RETURNING g_fieldId_max, g_tabIndex_max
   
      #取得widget的父節點
      LET l_parent_node = p_domNode.getParent()

      #取得widget相對應的sr節點
      IF l_parent_node.getTagName() = "Table" OR l_parent_node.getTagName() = "Tree" OR l_parent_node.getTagName() = "ScrollGrid" THEN
         LET l_sr_node = sadzp168_2_get_domNode(g_template_node, "Record", "name", l_parent_node.getAttribute("name"))

         #SR節點不存在時,新增此節點   
         IF l_sr_node IS NULL THEN
            LET l_sr_node = sadzp168_add_sr_structure(g_template_node, l_parent_node.getAttribute("name"))
         END IF
      ELSE
         LET l_sr_node = g_sr_ref
      END IF

      #尋找sr子節點是否已存在
      LET l_sr_child = sadzp168_2_get_domNode(l_sr_node, "Record", "name", p_domNode.getAttribute("name"))

      #新增一個sr子節點
      IF l_sr_child IS NULL THEN
         LET l_sr_child = l_sr_node.createChild("RecordField")
      
         #設置新sr child node的屬性
         CALL sadzp168_2_set_sr_attr(l_sr_child, p_domNode)
      END IF
   END IF

   #####一併處理tabIndex屬性#####
   IF NOT cl_null(p_domNode.getAttribute("tabIndex")) THEN
      #tabIndex值依續加1
      CALL sadzp168_2_field_add_index(p_domNode, "tabIndex", g_fieldId_max, g_tabIndex_max)
         RETURNING g_fieldId_max, g_tabIndex_max
   END IF
   
   #控制權移到其第一個子節點
   LET p_domNode = p_domNode.getFirstChild()

   #若節點為空則不再進行遞迴
   WHILE p_domNode IS NOT NULL   
      CALL sadzp168_add_template_sr_node(p_domNode)
      
      #控制權移到下一個同層的節點
      LET p_domNode = p_domNode.getNext()   
   END WHILE
END FUNCTION

#+ 處理公版 增加SR結構點
#  (todo:初步判斷widget有fieldId屬性)
PRIVATE FUNCTION sadzp168_add_sr_structure(p_template_node, p_sr_name)
   DEFINE p_template_node   om.DomNode              #UI樣版
   DEFINE p_sr_name         STRING                  #Screen Record節點的[name]屬性設置值

   DEFINE l_sr_node         om.DomNode              #Screen Record節點 
   DEFINE l_i               LIKE type_t.num5

   INITIALIZE l_sr_node TO NULL
   
   LET l_sr_node = p_template_node.createChild("Record")

   #抄寫公版上SR節點的屬性
   FOR l_i = 1 TO g_sr_ref.getAttributesCount()
       CALL l_sr_node.setAttribute(g_sr_ref.getAttributeName(l_i), g_sr_ref.getAttributeValue(l_i))

       #變更SR節點[name]屬性
       IF g_sr_ref.getAttributeName(l_i) = "name" THEN
          CALL l_sr_node.setAttribute("name", p_sr_name.trim())
       END IF
          
       IF g_sr_ref.getAttributeName(l_i) = "uid" THEN
          CALL l_sr_node.removeAttribute("uid")
       END IF
   END FOR

   #將新增的 Screen Record節點 insert在 Form節點之前
   CALL p_template_node.insertBefore(l_sr_node, g_form)

   RETURN l_sr_node
END FUNCTION

#+ 取得各結構畫面設計資料,並增加欄位node
PRIVATE FUNCTION sadzp168_get_dzfr_data()   
   DEFINE l_i                  LIKE type_t.num5
   DEFINE l_structure_cnt      LIKE type_t.num5        #畫面樣版的結構點數量
   DEFINE l_level1             LIKE type_t.num5        #第一階層設計資料順序
   DEFINE l_level2             LIKE type_t.num5        #第二階層設計資料順序
   DEFINE l_level3             LIKE type_t.num5        #第三階層設計資料順序
   DEFINE l_level1_id          STRING                  #第一階層設計點名稱
   DEFINE l_level2_id          STRING                  #第二階層設計點名稱
   DEFINE l_level1_container   STRING                  #第一階層設計點container樣式
   DEFINE l_level2_container   STRING                  #第二階層設計點container樣式
   DEFINE l_dzfr008            LIKE dzfr_t.dzfr008
   DEFINE l_table_id           STRING                  #此page如果為單身結構:則需紀錄r.a的table元件名稱
   DEFINE l_dzfr012            LIKE dzfr_t.dzfr012     #page tag name前置名稱(如:公用欄位頁籤-"page_info_")
   DEFINE l_name               STRING                  #widget名稱
   DEFINE l_j                  LIKE type_t.num5        #單身多頁籤table(container)數量
   DEFINE l_k                  LIKE type_t.num5        #table裡的pk欄位數量
   DEFINE l_uib_cnt            LIKE type_t.num5        #[資料歸屬]公用欄位數量
   DEFINE l_uis_cnt            LIKE type_t.num5        #[資料狀態資訊]公用欄位數量
   DEFINE l_row_id             STRING
   DEFINE l_row_sequence       LIKE type_t.num5        #行排序
   DEFINE l_child_node         STRING                  #page內的子節點container樣式(如:Table, ScrollGrid ...)
   DEFINE l_widget_height      INTEGER                 #widget控件高度
   DEFINE l_dzep009            INTEGER                 #widget控件寬度
   DEFINE l_widget_info        type_g_widget_info
   
   DEFINE l_qbe_cnt            LIKE type_t.num5        #QBE欄位數量
   DEFINE l_qbe_structure      LIKE type_t.num5        #QBE structure index
   DEFINE l_column_exist       LIKE type_t.chr1        #欄位是否重覆存在設計資料
   
   LET l_j = 0
   LET l_k = 1

   ############################################################
   #Q, P類版型--QBE框架欄位為r.a界面所建立的欄位總合,因此建立一個QBE Structure,存放所有欄位資訊
   IF (g_dzfq_m.cbo_progtype = "Q" OR g_dzfq_m.cbo_progtype = "P") AND (g_dzfq_m.cbo_setbrowse = "vq" OR g_dzfq_m.cbo_setbrowse = "hq") THEN
      #設定一個structure cnt給qbe使用
      LET l_structure_cnt = l_structure_cnt + 1

      LET g_dzfr[l_structure_cnt].structure = g_qbe

      IF g_dzfq_m.cbo_setbrowse = "vq" THEN
         LET g_dzfr[l_structure_cnt].container = "HBox"
      ELSE
         LET g_dzfr[l_structure_cnt].container = "VBox"
      END IF
      
      LET g_dzfr[l_structure_cnt].stype = g_qbe

      LET g_dzfr[l_structure_cnt].sfolder[1].sfolder = "folder_qbe"
      LET g_dzfr[l_structure_cnt].sfolder[1].container = "Folder"

      LET g_dzfr[l_structure_cnt].sfolder[1].spage[1].spage = "page_qbe1"
      LET g_dzfr[l_structure_cnt].sfolder[1].spage[1].container = "Page"
      LET g_dzfr[l_structure_cnt].sfolder[1].spage[1].child_node = ""
      LET g_dzfr[l_structure_cnt].sfolder[1].spage[1].stable = ""
      LET g_dzfr[l_structure_cnt].sfolder[1].spage[1].dzfr012 = "page_qbe"

      LET l_qbe_cnt = 1
      LET l_qbe_structure = l_structure_cnt
   END IF
   ############################################################
   
   #循序取得r.a的欄位設計資料
   FOR l_i = 1 TO g_form_tree.getLength()
       INITIALIZE l_widget_info TO NULL
       
       #取得欄位相關設計資訊
       #dzfr010欄位代碼
       IF NOT cl_null(g_form_tree[l_i].dzfr010) THEN
          EXECUTE sadzp168_field_info_pre USING g_dzfq_m.dzfq003, g_dzfq_m.dzfq004, g_form_tree[l_i].dzfr009, g_form_tree[l_i].dzfr010
             INTO l_widget_info.*         
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code =  SQLCA.sqlcode
             LET g_errparam.extend = 'sel: sadzp168_field_info_pre'
             LET g_errparam.popup = TRUE
             CALL cl_err()
             RETURN FALSE
          END IF
       END IF
       
       #階層為1:表示為此畫面樣版的結構點設計位置(可拉欄位設計資料)
       IF g_form_tree[l_i].b_level = 1 THEN
          IF l_i <> 1 THEN
             CALL g_dzfr[l_structure_cnt].sfolder[l_level1].spage[l_level2].sfield.deleteElement(l_level3)
          END IF
          
          #取得畫面樣版的結構點名稱(可在此結構點下插入r.a的欄位widget設計資料)
          LET l_structure_cnt = l_structure_cnt + 1

          LET g_dzfr[l_structure_cnt].structure = g_form_tree[l_i].dzfr007
          LET g_dzfr[l_structure_cnt].container = g_form_tree[l_i].dzfr006

          #todo:為了程式邏輯處理,需要將結構類型分類樣式(如:瀏灠表, 單頭, 單身, Tree)
          #tree的結構需另外處理,因此獨立一種結構出來
          IF g_dzfr[l_structure_cnt].container = "Tree" THEN
             LET g_dzfr[l_structure_cnt].stype = g_btree
          ELSE
             LET g_dzfr[l_structure_cnt].stype = g_form_tree[l_i].dzfr007
          END IF
          
          LET l_level1 = 0
          LET l_level2 = 0
          LET l_level3 = 1
          LET l_level1_id = "No folder"
          LET l_level1_container = ""
          LET l_level2_id = "No page"
          LET l_level2_container = ""
          LET l_child_node = ""
          LET l_table_id = ""          
          LET l_dzfr012 = ""
          LET l_uib_cnt = 0
          LET l_uis_cnt = 0
       ELSE
          #todo:目前將r.a設計資料概略分為三層[folder(group, grid), page, field]
          ##########取得第一層(folder層)的設計資料##########
          #todo:130704 改變第一階層設計點定義為Folder/Group/Grid
          IF g_form_tree[l_i].dzfr006 = "Folder" OR g_form_tree[l_i].dzfr006 = "Group" OR g_form_tree[l_i].dzfr006 = "Grid" THEN
             #判斷此設計點名稱是否已存在陣列中
             LET l_level1 = l_level1 + 1

             IF g_form_tree[l_i].dzfr006 = "Folder" THEN
                LET l_level2_id = ""
             END IF
                
             LET l_level2_container = ""
             LET l_child_node = ""
             LET l_table_id = ""
             LET l_dzfr012 = ""
             LET l_level2 = 0
             LET l_level3 = 1

             LET l_level1_id = g_form_tree[l_i].dzfr007
             LET l_level1_container = g_form_tree[l_i].dzfr006
          END IF

          ##########取得第二層(page層)的設計資料##########
          IF g_form_tree[l_i].dzfr006 = "Page" THEN
             #判斷此設計點名稱是否已存在陣列中
             LET l_level2 = l_level2 + 1
             LET l_level3 = 1

             LET l_level2_id = g_form_tree[l_i].dzfr007
             LET l_level2_container = g_form_tree[l_i].dzfr006
             LET l_dzfr012 = g_form_tree[l_i].dzfr012
                
             LET l_uib_cnt = 0
             LET l_uis_cnt = 0
          END IF

          IF g_form_tree[l_i].dzfr006 = "Table" OR g_form_tree[l_i].dzfr006 = "ScrollGrid" OR g_form_tree[l_i].dzfr006 = "Tree" THEN
             LET l_child_node = g_form_tree[l_i].dzfr006
             LET l_table_id = g_form_tree[l_i].dzfr007
             LET l_dzfr008 = g_form_tree[l_i].dzfr008
             LET l_row_id = ""
             LET l_row_sequence = 0
             
             #4fd所存在的table(container)數量
             LET l_j = l_j + 1
             LET l_k = 1
          END IF

          #取得ScrollGrid的欄位所屬行名稱
          IF g_form_tree[l_i].dzfr006 = "row" THEN
             LET l_row_id = g_form_tree[l_i].dzfr007
             LET l_row_sequence = g_form_tree[l_i].dzfr005
          END IF
          
          ##########取得第三層(page層)的設計資料##########
          IF g_form_tree[l_i].dzfr006 = "Field" OR g_form_tree[l_i].dzfr006 = "ghost" THEN
             #取得第一階層設計點名稱
             IF l_level1_id = "No folder" THEN
                LET l_level1 = 1
             END IF
             
             LET g_dzfr[l_structure_cnt].sfolder[l_level1].sfolder = l_level1_id
             LET g_dzfr[l_structure_cnt].sfolder[l_level1].container = l_level1_container
             
             #取得第二階層設計點名稱
             IF l_level2_id = "No page" THEN
                LET l_level2 = 1
                LET l_dzfr012 = ""
             END IF
             
             LET g_dzfr[l_structure_cnt].sfolder[l_level1].spage[l_level2].spage = l_level2_id
             LET g_dzfr[l_structure_cnt].sfolder[l_level1].spage[l_level2].container = l_level2_container
             LET g_dzfr[l_structure_cnt].sfolder[l_level1].spage[l_level2].child_node = l_child_node
             LET g_dzfr[l_structure_cnt].sfolder[l_level1].spage[l_level2].stable = l_table_id
             LET g_dzfr[l_structure_cnt].sfolder[l_level1].spage[l_level2].dzfr012 = l_dzfr012
             
             #取得第三階層欄位產生4fd widget時所需資訊
             LET g_dzfr[l_structure_cnt].sfolder[l_level1].spage[l_level2].sfield[l_level3].dzfr003 = g_form_tree[l_i].dzfr003
             LET g_dzfr[l_structure_cnt].sfolder[l_level1].spage[l_level2].sfield[l_level3].sort = g_form_tree[l_i].dzfr005
             LET g_dzfr[l_structure_cnt].sfolder[l_level1].spage[l_level2].sfield[l_level3].sqlTabName = g_form_tree[l_i].dzfr009
             LET g_dzfr[l_structure_cnt].sfolder[l_level1].spage[l_level2].sfield[l_level3].colName = g_form_tree[l_i].dzfr010
             LET g_dzfr[l_structure_cnt].sfolder[l_level1].spage[l_level2].sfield[l_level3].attrName = g_form_tree[l_i].dzfr009, ".", g_form_tree[l_i].dzfr010
             LET g_dzfr[l_structure_cnt].sfolder[l_level1].spage[l_level2].sfield[l_level3].attrRequired = g_form_tree[l_i].dzeb004
             LET g_dzfr[l_structure_cnt].sfolder[l_level1].spage[l_level2].sfield[l_level3].notNull = l_widget_info.dzeb005 #2015/05/08 by Hiko:因為牽涉到type,所以這裡的dzeb005就不改成dzep005
             LET g_dzfr[l_structure_cnt].sfolder[l_level1].spage[l_level2].sfield[l_level3].datatype = l_widget_info.gztd003
             LET g_dzfr[l_structure_cnt].sfolder[l_level1].spage[l_level2].sfield[l_level3].length = l_widget_info.gztd008
             LET g_dzfr[l_structure_cnt].sfolder[l_level1].spage[l_level2].sfield[l_level3].dzep010 = l_widget_info.dzep010
             LET g_dzfr[l_structure_cnt].sfolder[l_level1].spage[l_level2].sfield[l_level3].dzej003 = l_widget_info.dzej003
             LET g_dzfr[l_structure_cnt].sfolder[l_level1].spage[l_level2].sfield[l_level3].widgetWidth = l_widget_info.dzep009
             LET g_dzfr[l_structure_cnt].sfolder[l_level1].spage[l_level2].sfield[l_level3].reftable = l_widget_info.dzef006
             LET g_dzfr[l_structure_cnt].sfolder[l_level1].spage[l_level2].sfield[l_level3].refField = l_widget_info.dzef008
             LET g_dzfr[l_structure_cnt].sfolder[l_level1].spage[l_level2].sfield[l_level3].detailPK = g_form_tree[l_i].detailPK

             LET g_dzfr[l_structure_cnt].sfolder[l_level1].spage[l_level2].sfield[l_level3].langField = l_widget_info.dzer007
             LET g_dzfr[l_structure_cnt].sfolder[l_level1].spage[l_level2].sfield[l_level3].dzer005 = l_widget_info.dzer005
             LET g_dzfr[l_structure_cnt].sfolder[l_level1].spage[l_level2].sfield[l_level3].mnemField = l_widget_info.dzet006
             LET g_dzfr[l_structure_cnt].sfolder[l_level1].spage[l_level2].sfield[l_level3].dzet002 = ""
             LET g_dzfr[l_structure_cnt].sfolder[l_level1].spage[l_level2].sfield[l_level3].dzep020 = l_widget_info.dzep020
             LET g_dzfr[l_structure_cnt].sfolder[l_level1].spage[l_level2].sfield[l_level3].dzek001 = g_form_tree[l_i].dzekgrp
             LET g_dzfr[l_structure_cnt].sfolder[l_level1].spage[l_level2].sfield[l_level3].dzeb022 = g_form_tree[l_i].dzeb022
             LET g_dzfr[l_structure_cnt].sfolder[l_level1].spage[l_level2].sfield[l_level3].dzep021 = l_widget_info.dzep021
             LET g_dzfr[l_structure_cnt].sfolder[l_level1].spage[l_level2].sfield[l_level3].dzep022 = l_widget_info.dzep022
             LET g_dzfr[l_structure_cnt].sfolder[l_level1].spage[l_level2].sfield[l_level3].dzep023 = l_widget_info.dzep023   #by Saki
             
             LET g_dzfr[l_structure_cnt].sfolder[l_level1].spage[l_level2].sfield[l_level3].srowSeq = l_row_sequence
             LET g_dzfr[l_structure_cnt].sfolder[l_level1].spage[l_level2].sfield[l_level3].srow = l_row_id
             LET g_dzfr[l_structure_cnt].sfolder[l_level1].spage[l_level2].sfield[l_level3].dzfr006 = g_form_tree[l_i].dzfr006

             LET l_widget_height = sadzp168_grid_height(l_widget_info.dzep010)
             LET l_dzep009 = l_widget_info.dzep009
             
             #計算公用欄位是否需折行
             IF g_dzfr[l_structure_cnt].structure = g_master THEN
                IF g_form_tree[l_i].dzekgrp = "grpUIBelong" THEN
                   LET l_uib_cnt = l_uib_cnt + 1

                   #餘數=1時,表示公用欄位需折行
                   IF (l_uib_cnt <> 1) AND ((l_uib_cnt MOD g_dzfq_m.dzfq008)) = 1 THEN
                      LET g_dzfr[l_structure_cnt].sfolder[l_level1].spage[l_level2].sfield[l_level3].dzekWarp = TRUE
                   ELSE
                      LET g_dzfr[l_structure_cnt].sfolder[l_level1].spage[l_level2].sfield[l_level3].dzekWarp = FALSE
                   END IF
                END IF

                IF g_form_tree[l_i].dzekgrp = "grpUIStateinfo" THEN
                   LET l_uis_cnt = l_uis_cnt + 1

                   #餘數=1時,表示公用欄位需折行
                   IF (l_uis_cnt <> 1) AND ((l_uis_cnt MOD g_dzfq_m.dzfq008)) = 1 THEN
                      LET g_dzfr[l_structure_cnt].sfolder[l_level1].spage[l_level2].sfield[l_level3].dzekWarp = TRUE
                   ELSE
                      LET g_dzfr[l_structure_cnt].sfolder[l_level1].spage[l_level2].sfield[l_level3].dzekWarp = FALSE
                   END IF
                END IF
             END IF
             
             ####因應單身多頁籤,PK欄位(attrRequired)需要在每個頁籤上出現,為避色4fd widget name重覆######
             #所以在此變更屬於單身結構類型(g_detail)的欄位名稱(colName)
             #變更的需求只需要從第2個page開始,第1個page保持其TABLE_COLUMN型態
             LET l_column_exist = FALSE
             IF g_dzfr[l_structure_cnt].structure = g_detail AND 
                g_dzfr[l_structure_cnt].sfolder[l_level1].spage[l_level2].sfield[l_level3].attrRequired = "Y" THEN 

                #取得cloumn是否已存在4fd檔(存在時:開始變更PK欄位的命名原則)
                IF sadzp168_get_column_exist(g_form_tree[l_i].dzfr010) THEN
                   #命名原則為隨著page個數增加'_x'. 例如: 第二個page:gztb002_2,第三個page:gztb002_3...
                   LET l_name = g_dzfr[l_structure_cnt].sfolder[l_level1].spage[l_level2].sfield[l_level3].colName CLIPPED
                   LET l_name = l_name.trim(), "_", l_dzfr008 USING "<<<<<"
                   LET g_dzfr[l_structure_cnt].sfolder[l_level1].spage[l_level2].sfield[l_level3].detailPK = l_name.trim()
                   LET l_column_exist = TRUE
                END IF
                
                #記錄單身各table(container) PK欄位
                LET g_detail_pk[l_j].table_container_name = l_table_id
                LET g_detail_pk[l_j].pk_field[l_k].widget = l_widget_info.dzej003
                LET g_detail_pk[l_j].pk_field[l_k].colName = g_form_tree[l_i].dzfr010
                LET g_detail_pk[l_j].pk_field[l_k].detailPK = g_dzfr[l_structure_cnt].sfolder[l_level1].spage[l_level2].sfield[l_level3].detailPK

                #當detailPK值為null時,表示為TABLE_COLUMN欄位,取TABLE_COLUMN欄位名稱
                IF cl_null(g_detail_pk[l_j].pk_field[l_k].detailPK) THEN
                   LET g_detail_pk[l_j].pk_field[l_k].detailPK = g_dzfr[l_structure_cnt].sfolder[l_level1].spage[l_level2].sfield[l_level3].attrName
                END IF
                LET l_k = l_k + 1
             END IF
             ##################################################################################

             #ScrollGrid產生需用到adzp168t2資料表,需要UPDATE widget的長/寬
             IF g_dzfr[l_structure_cnt].sfolder[l_level1].spage[l_level2].child_node = "ScrollGrid" THEN
                IF cl_null(l_dzep009) OR l_dzep009 = 0 THEN
                   LET l_dzep009 = 10
                END IF

                IF cl_null(l_widget_height) OR l_widget_height = 0 THEN
                   LET l_widget_height = 1
                END IF
             
                EXECUTE sadzp168_168t2_upd_pre USING l_dzep009, l_widget_height, g_form_tree[l_i].dzfr003
                IF SQLCA.sqlcode THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code =  SQLCA.sqlcode
                    LET g_errparam.extend = 'upd sadzp168_168t2_upd_pre:'
                    LET g_errparam.popup = TRUE
                    CALL cl_err()
                    #RETURN FALSE
                END IF 
             END IF
             
             ##########Q, P類版型--QBE Structure,再存放一份所有欄位資訊##########
             IF (g_dzfq_m.cbo_progtype = "Q" OR g_dzfq_m.cbo_progtype = "P") AND (g_dzfq_m.cbo_setbrowse = "vq" OR g_dzfq_m.cbo_setbrowse = "hq") AND (NOT l_column_exist) THEN
                LET g_dzfr[l_qbe_structure].sfolder[1].spage[1].sfield[l_qbe_cnt].* = g_dzfr[l_structure_cnt].sfolder[l_level1].spage[l_level2].sfield[l_level3].*
                LET l_qbe_cnt = l_qbe_cnt + 1
             END IF
             ############################################################
             
             LET l_level3 = l_level3 + 1
          END IF

       END IF
   END FOR  

   RETURN TRUE
END FUNCTION

#+ 取得單身的第一個欄位資訊(如:Edit--defaultb)
PRIVATE FUNCTION sadzp168_get_detail_defaultb(p_template_node, p_dzfq010)
   DEFINE p_template_node      om.DomNode              #主結構點node
   DEFINE p_dzfq010            LIKE dzfq_t.dzfq010     #單身框架樣式(Table,ScrollGrid)
   
   DEFINE r_detail_child       om.DomNode              #單身的第一個欄位資訊
   DEFINE r_detail_lbl_child   om.DomNode              #單身的第一個欄位Static Label節點資訊

   INITIALIZE r_detail_child TO NULL
   INITIALIZE r_detail_lbl_child TO NULL

   LET p_dzfq010 = p_dzfq010 CLIPPED
   
   #取得單身的第一個欄位資訊
   IF g_dzfq_m.cbo_progtype = "Q" THEN
      #Q類版型第一個欄位和一般不同
      LET r_detail_child = sadzp168_2_get_domNode(p_template_node, "CheckBox", "name", "sel")
   ELSE
      LET r_detail_child = sadzp168_2_get_domNode(p_template_node, "Edit", "name", "defaultb")
   END IF

   IF p_dzfq010 = "ScrollGrid" THEN
      LET r_detail_lbl_child = sadzp168_2_get_domNode(p_template_node, "Label", "name", "lbl_defaultb")
   ELSE
      #todo:defaultb是新增一個table[container]時,預設的欄位(需刪除),所以posX固定預設為0
      IF NOT cl_null(r_detail_child.getAttribute("posX")) THEN
         CALL r_detail_child.setAttribute("posX", "0")
      END IF
   END IF
   
   RETURN r_detail_child, r_detail_lbl_child
END FUNCTION

#+ 取得畫面樣版結構可插入設計資料的container node
PRIVATE FUNCTION sadzp168_get_level1_domNode(p_node, p_folder, p_level1)
   DEFINE p_node            om.DomNode              #主結構點node
   DEFINE p_folder          type_g_folder           #第一階層設計資料(Folder)
   #DEFINE p_level1_id       STRING                  #第一階層設計點名稱
   DEFINE p_level1          LIKE type_t.num5        #第一階層設計資料順序

   DEFINE l_level1_node     om.DomNode              #在主結構點下的最後一個[第一階層設計結構點(如:Folder)]
   DEFINE l_node_list       om.NodeList
   DEFINE l_dzfm006         LIKE dzfm_t.dzfm006     #結構點類型
   
   DEFINE r_container_node  om.DomNode              #可以插入欄位widget設計資料的container node
   
   INITIALIZE r_container_node TO NULL
   INITIALIZE l_level1_node TO NULL
   
   #第一階層設計點名稱為:"No folder",表示沒有第一階層設計點node
   IF p_folder[p_level1].sfolder = "No folder" THEN
      LET r_container_node = p_node
      RETURN r_container_node
   END IF

   #取得第一階層的container類型與是否已存在4fd檔
   LET l_node_list = p_node.selectByTagName(p_folder[p_level1].container.trim())
   LET l_dzfm006 = p_node.getAttribute("name")

   IF l_node_list.getLength() > 0 THEN
      LET r_container_node = l_node_list.item(p_level1)

      #新增切片檔結構
      #todo:目前公版原則上只提供一個可插入的container
      IF r_container_node IS NULL OR p_level1 > 1 THEN
         #取得最後一個[第一階層設計結構點]
         LET l_level1_node = l_node_list.item(l_node_list.getLength())

         #多container為"Group"型式時,需剔除[狀態欄]欄位的Group
         IF l_level1_node.getTagName() = "Group" AND l_level1_node.getAttribute("name") = "group_statebtn" AND p_level1 > 1 THEN
            LET l_level1_node = l_node_list.item(l_node_list.getLength() - 1)
         END IF
               
         #依結構代號不同,加入樣版檔公版所需要的snippet檔
         LET r_container_node = sadzp168_add_container_snippet(l_dzfm006, l_level1_node, p_folder, p_level1)

         #由r.a新增加的切片是可以在Spce Designer刪除的
         #利用"add_snippet_prg"關鍵字來表示,需要將這一個整個切片的公版tag屬性"CantDel"去除
         CALL r_container_node.setAttribute("tag", "add_snippet_prg")
      END IF
   ELSE
      LET r_container_node = p_node
   END IF

   RETURN r_container_node
END FUNCTION

#+ 取得畫面樣版結構可插入設計資料的container node
PRIVATE FUNCTION sadzp168_get_container_node(p_structure, p_node, p_level2, p_page)
   DEFINE p_structure       STRING                  #樣版所定義的結構類型名稱
   DEFINE p_node            om.DomNode              #第一階層設計點node
   DEFINE p_level2          LIKE type_t.num5        #第二階層設計資料順序
   DEFINE p_page            type_g_page_info        #此page相關資訊

   DEFINE l_tag             STRING                  #container node的tag標記值(如:insW_CantDel)
   DEFINE r_container_node  om.DomNode              #可以插入欄位widget設計資料的container node
   DEFINE l_node_list       om.NodeList
   DEFINE l_del             LIKE type_t.chr1
   
   INITIALIZE r_container_node TO NULL

   LET l_del = FALSE
   LET l_tag = "insW_CantDel"

   #todo:master_Grid.snippet切片,因為只有一個Grid節點所以只能直接找[tag]值="add_snippet_prg"(這段應該要想辦法改寫判斷)
   IF p_node.getTagName() = "Grid" AND p_node.getAttribute("tag") = "add_snippet_prg" THEN
      LET l_tag = "add_snippet_prg"
      LET l_del = TRUE
   END IF
   
   #檢查樣版中是否存在相對應的結構點
   IF p_page.spage <> "No page" THEN      
      LET l_node_list =  p_node.selectByTagName(p_page.container.trim())   
      IF l_node_list.getLength() > 0 THEN
         LET r_container_node = l_node_list.item(p_level2)
      END IF

      #第二階層設計點node是否已存在樣版中,如果不為原樣版內結構,則新增此結構點node
      IF r_container_node IS NULL THEN
         #page name = "page_info_xx"時表示為公用欄位頁籤
         IF p_page.dzfr012 = "page_info_" THEN
            LET r_container_node = sadzp168_add_page_info(p_structure, p_node, p_level2, p_page.*)
         ELSE 
            LET r_container_node = sadzp168_add_level2(p_node, p_page.spage, p_page.container, p_page.stable)
         END IF

         IF r_container_node IS NULL THEN
            #新增結構點失敗
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  "adz-00075"
            LET g_errparam.extend = NULL
            LET g_errparam.popup = TRUE
            LET g_errparam.replace[1] =  p_page.spage
            CALL cl_err()
            DISPLAY p_page.spage, " node: ",     p_node.getTagName(), ".", p_node.getAttribute("name"), " isn't insert."
         END IF
   
         RETURN r_container_node
      END IF
   END IF

   #取得可插入設計資料的結構點(如:雙檔browser設計點為s_browse, 單頭設計點為Grid4...)
   CALL sadzp168_get_container_position(p_node, l_tag)
      RETURNING r_container_node

   IF r_container_node IS NULL THEN
      #結構點設計位置不存在
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00072"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] =  p_page.spage
      CALL cl_err()
      DISPLAY p_page.spage, " node: ", p_node.getTagName(), ".", p_node.getAttribute("name"), " isn't exist." 
      INITIALIZE r_container_node TO NULL
      RETURN r_container_node
   END IF

   #由r.a新增加的切片是可以在Spce Designer刪除的
   #利用"add_snippet_prg"關鍵字來表示,需要將這一個整個切片的公版tag屬性"CantDel"去除
   IF p_node.getAttribute("tag") = "add_snippet_prg" THEN
      CALL p_node.setAttribute("tag", "")

      #可新增欄位設計資訊的Container也是可以在Spce Designer刪除的
      IF r_container_node.getAttribute("tag") = "CantDel" THEN
         CALL r_container_node.setAttribute("tag", "")
      END IF
   END IF

   #todo:由r.a新增加的切片是可以在Spce Designer刪除的
   IF l_del AND p_node.getAttribute("tag") = "CantDel" THEN
      CALL p_node.setAttribute("tag", "")
   END IF

   #140117:子程式嵌入關係---需讓s_detail1可以更名,所以將tag資訊(CantDel)清除
   IF r_container_node.getAttribute("name") = "s_detail1" THEN
      CALL r_container_node.setAttribute("tag", "")
   END IF
   
   RETURN r_container_node
END FUNCTION

#+ 新增共用欄位頁籤
PRIVATE FUNCTION sadzp168_add_page_info(p_structure, p_node, p_level2, p_page)
   DEFINE p_structure       STRING                  #樣版所定義的結構類型名稱
   DEFINE p_node            om.DomNode              #第一階層設計點node
   DEFINE p_level2          LIKE type_t.num5        #第二階層設計資料順序
   DEFINE p_page            type_g_page_info        #此page相關資訊

   DEFINE l_snippet_file    STRING                  #共用欄位切片檔案名稱
   DEFINE l_table_list      om.NodeList             #Table(container)的sr節點
   DEFINE l_table_node      om.DomNode              #Table(container)的節點
   DEFINE l_sr_node         om.DomNode              #Table的Screen Record節點
   DEFINE l_i               LIKE type_t.num5
   DEFINE l_name            STRING
   DEFINE l_tag             STRING
   DEFINE l_folder          type_g_folder
   
   DEFINE r_snippet_node  om.DomNode              #可以插入欄位widget設計資料的container node

   INITIALIZE r_snippet_node TO NULL
   
   LET l_snippet_file = ""
   LET l_tag = "insW_CantDel"
   
   CASE p_structure
      WHEN g_master
         LET l_snippet_file = "master_common.snippet"
         
      WHEN g_detail
         IF g_dzfq_m.dzfq010 = "ScrollGrid" THEN
            LET l_snippet_file = "detail_ScrollGrid_common.snippet"
         ELSE
            LET l_snippet_file = "detail_Table_common.snippet"
         END IF

   END CASE

   #取得共用欄位切片檔
   LET r_snippet_node = sadzp168_load_snippet_file(p_node, l_snippet_file)

   IF r_snippet_node IS NULL THEN
      RETURN r_snippet_node
   END IF

   #變更切片檔container命名
   LET l_folder[1].spage[1].* = p_page.*
   CALL sadzp168_container_rename(r_snippet_node, l_folder, "1")
   
   #####新增Table的Screen Record節點#####
   #取得樣版切片檔中有多少個Table/ScrollGrid(container)元件
   LET l_table_list = r_snippet_node.selectByTagName(g_dzfq_m.dzfq010)

   #檢查該Table相對應的SR節點是否存在
   FOR l_i = 1 to l_table_list.getLength()
      LET l_table_node = l_table_list.item(l_i)
      LET l_name = l_table_node.getAttribute("name")

      #尋找SR節點是否已存在樣版中
      LET l_sr_node = sadzp168_2_get_domNode(g_template_node, "Record", "name", l_name)

      #SR節點不存在時,新增此節點   
      IF l_sr_node IS NULL THEN
         LET l_sr_node = sadzp168_add_sr_structure(g_template_node, l_name)
      END IF

      #處理切片檔中有些widget需要在Screen Record增加一個子節點
      CALL sadzp168_add_template_sr_node(l_table_node)
   END FOR

   #結構類型為單身時,需取得插入設計資料的結構點
   IF p_structure = g_detail THEN    #AND (g_dzfq_m.dzfq010 = "Table" OR g_dzfq_m.dzfq010 = "ScrollGrid") THEN
      LET r_snippet_node = sadzp168_get_container_position(r_snippet_node, l_tag)
   END IF
   
   RETURN r_snippet_node
END FUNCTION
   
#+ 取得畫面樣版結構可插入設計資料的container名稱
PRIVATE FUNCTION sadzp168_get_container_position(p_node, p_tag)
   DEFINE p_node            om.DomNode              #第一階層設計點node
   DEFINE p_tag             STRING                  #container node的tag標記值(如:insW_CantDel)
   
   DEFINE r_insert_node     om.DomNode              #可以插入欄位widget設計資料的container node

   INITIALIZE r_insert_node TO NULL

   #取得tag屬性值是否符合(如:insW_CantDel)
   IF p_node.getAttribute("tag") = p_tag THEN
      #共用欄位區塊不限制不可調動
      IF NOT (p_tag = "insUIB" OR p_tag = "insUIS") THEN
         CALL p_node.setAttribute("tag", "CantDel")
      END IF
      
      LET r_insert_node = p_node
      RETURN r_insert_node
   END IF
      
   #可插入設計資料的container節點(如:tag屬性為[insW_CantDel])
   LET p_node = p_node.getFirstChild()

   WHILE p_node IS NOT NULL
      #繼續逐層往下往子節點解析比對(由外而內)
      LET r_insert_node = sadzp168_get_container_position(p_node, p_tag)
      IF r_insert_node IS NOT NULL THEN
         EXIT WHILE
      ELSE
         LET p_node = p_node.getNext()
      END IF
   END WHILE
   
   RETURN r_insert_node
END FUNCTION

#+ 增加第二階層設計點node前置作業
PRIVATE FUNCTION sadzp168_add_level2(p_node, p_name, p_tag, p_table_id)
   DEFINE p_node             om.DomNode            #第一階層設計點node
   DEFINE p_name             STRING                #新第二階層設計點名稱
   DEFINE p_tag              STRING                #新第二階層設計點tag型式
   DEFINE p_table_id         STRING                #此page如果為單身結構:則需紀錄r.a的table元件名稱
   
   DEFINE l_node             om.DomNode            #目前運作新增欄位節點的domNode
   DEFINE l_node_before      om.DomNode            #要新增的第二階層設計點,準備新增在那個節點之前
   DEFINE l_parent_node      om.DomNode
   DEFINE l_new_node         om.DomNode            #新的第二階層設計點node(包含子結構一直到可插入設計資料的container)
   DEFINE l_sr_node          om.DomNode            #Screen Record節點
   DEFINE l_table_child      om.DomNode            #table container要新增的預設欄位(defaultb)
   DEFINE l_node_list        om.NodeList
   DEFINE l_i                LIKE type_t.num5 
   DEFINE l_j                LIKE type_t.num5 
   DEFINE l_idx              LIKE type_t.num5 
   DEFINE l_cnt              LIKE type_t.num5 
   DEFINE l_name             STRING
   DEFINE l_tree_child       om.DomNode            #原tree container要新增的預設欄位
   DEFINE l_tree_child_new   om.DomNode            #新tree container要新增的預設欄位
   DEFINE l_str              STRING
   DEFINE l_tree_attr        RECORD
                expandedColumn    STRING,
                idColumn          STRING,
                isNodeColumn      STRING,
                parentIdColumn    STRING
             END RECORD

   DEFINE r_container_node   om.DomNode            #新建立的可插入欄位widget設計資料的container node

   IF cl_null(p_name) THEN
      DISPLAY "The level2 name is not setting."
   END IF
   
   INITIALIZE l_node TO NULL
   INITIALIZE l_node_before TO NULL
   INITIALIZE l_parent_node TO NULL
   INITIALIZE l_sr_node TO NULL
   INITIALIZE r_container_node TO NULL
   INITIALIZE l_tree_child TO NULL
   INITIALIZE l_tree_child_new TO NULL

   LET l_cnt = 0
   
   ###############取得第二階層設計結構點###############
   #取得正在進行插入欄位widget設計資料的container node
   #利用這個node往上取父節點,比對與新的第二階層設計點同樣的tag後
   #開始往下複製相同的結構內容到新的第二階層設計點之下,以利再插入另一組新的設計資料
   LET l_node = g_container_node_t
   
   WHILE l_node IS NOT NULL 
      #往上尋找父節點的Container型式是否與新的第二階層設計點Container型式符合(如:page)
      IF l_node.getTagName() = p_tag THEN
         LET l_parent_node = l_node

         #判斷[新的第二階層設計點]是否採取[插入]方式新增
         #取得符合的tag型式所有節點
         LET l_node_list = p_node.selectByTagName(p_tag.trim())

         #取得符合[新的第二階層設計點]的Container型式共有多少個節點
         LET l_cnt = l_node_list.getLength()

         #取得node list裡符合目前正在進行插入欄位widget設計資料的container node
         FOR l_i = 1 to l_node_list.getLength()
            LET l_node_before = l_node_list.item(l_i) 
            
            IF l_node_before.getAttribute("name") = l_node.getAttribute("name") THEN
               #目前節點index位置小於總數量時,表示採取[插入]方式新增
               #所以需再找到下一層節點後,就直接離開While
               #這樣才可以新增一個page插入在這個節點之前
               IF l_i < l_cnt THEN
                  LET l_node_before = l_node_list.item(l_i + 1)
               ELSE
                  #目前index = 總數量時:表示不需採插入方式新增,直接將新結構點加在最後面即可
                  INITIALIZE l_node_before TO NULL
               END IF

               EXIT WHILE
            END IF
         END FOR

         #todo:理論上不會執行到下一行,有的話表示邏輯或節點應該有錯
         EXIT WHILE
      END IF

      #繼續往上層父節點尋找(採由內而外方式)
      LET l_node = l_node.getParent()
   END WHILE

   IF l_parent_node IS NULL THEN
      #新的第二階層設計點無法取得相對應的node結構點
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00072"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] =  p_node.getAttribute("name") 
      CALL cl_err()
      
      DISPLAY "Level 2 structure isn't found."
      INITIALIZE r_container_node TO NULL
      RETURN r_container_node
   END IF

   ###############複製第二階層設計點裡的結構內容###############
   #如:雙檔單頭結構內容--Page->HBox->Grid (而r.a的設計資料是新增在Grid container中)
   
   #由上而下複製結構內容一直到和g_container_node_t的Tag型式一樣為止
   INITIALIZE l_node TO NULL
   LET l_node = l_parent_node

   INITIALIZE l_parent_node TO NULL
   LET l_parent_node = p_node
   
   WHILE l_node IS NOT NULL
      #開始複製結構內容
      LET l_new_node = l_parent_node.createChild(l_node.getTagName())

      #抄寫結構點元件的屬性
      FOR l_i = 1 TO l_node.getAttributesCount()
          CALL l_new_node.setAttribute(l_node.getAttributeName(l_i), l_node.getAttributeValue(l_i))
          
          #11/28 決議:避免主程式,子程式,子畫面的多語言在控件同名的前提下,更改Page的text增加程式編號
          IF p_tag = "Page" AND l_node.getAttributeName(l_i) = "text" THEN
             LET l_name = p_name, ".", g_dzfq_m.dzfq004 CLIPPED
             CALL l_new_node.setAttribute(l_node.getAttributeName(l_i), l_name)
          END IF
                  
          #4fd widget命名需為唯一,依tag型式不同,而有不同的命名規則
          IF l_node.getAttributeName(l_i) = "name" THEN
             CASE l_node.getTagName()
                WHEN p_tag
                   LET l_name = p_name.trim()
 
                WHEN "Table" 
                   IF NOT cl_null(p_table_id) THEN
                      LET l_name = p_table_id.trim()
                   ELSE
                      LET l_name = l_new_node.getTagName(), "_gen", g_num USING "<<<<<"  
                      LET g_num = g_num + 1
                   END IF

                   ###在新Table下新增一欄位####################
                   #g_detail_child:為一開始在取單身結構node時,就先紀錄的[defaultb]子節點
                   IF g_detail_child IS NOT NULL THEN
                      LET l_table_child = l_new_node.createChild(g_detail_child.getTagName())
   
                      #抄寫公版上欄位元件的屬性
                      FOR l_j = 1 TO g_detail_child.getAttributesCount()
                          CALL l_table_child.setAttribute(g_detail_child.getAttributeName(l_j), g_detail_child.getAttributeValue(l_j))
                      END FOR

                      IF g_detail_child.getTagName() = "CheckBox" AND g_detail_child.getAttribute("name") = "sel" THEN
                         CALL l_table_child.setAttribute("tag", "Del")
                      END IF
                   END IF
   
                   ###新建table container元件時,需一併建立SR node結構
                   LET l_sr_node = sadzp168_add_sr_structure(g_template_node, l_name)

                WHEN "ScrollGrid" 
                   IF NOT cl_null(p_table_id) THEN
                      LET l_name = p_table_id.trim()
                   ELSE
                      LET l_name = l_new_node.getTagName(), "_gen", g_num USING "<<<<<"  
                      LET g_num = g_num + 1
                   END IF

                   ###在新ScrollGrid下新增一個Static Label和Edit欄位####################
                   IF g_detail_lbl_child IS NOT NULL THEN
                      LET l_table_child = l_new_node.createChild(g_detail_lbl_child.getTagName())
   
                      #抄寫公版上欄位元件的屬性
                      FOR l_j = 1 TO g_detail_lbl_child.getAttributesCount()
                          CALL l_table_child.setAttribute(g_detail_lbl_child.getAttributeName(l_j), g_detail_lbl_child.getAttributeValue(l_j))
                      END FOR
                   END IF

                   INITIALIZE l_table_child TO NULL
                    
                   #g_detail_child:為一開始在取單身結構node時,就先紀錄的[defaultb]子節點
                   IF g_detail_child IS NOT NULL THEN
                      LET l_table_child = l_new_node.createChild(g_detail_child.getTagName())
   
                      #抄寫公版上欄位元件的屬性
                      FOR l_j = 1 TO g_detail_child.getAttributesCount()
                          CALL l_table_child.setAttribute(g_detail_child.getAttributeName(l_j), g_detail_child.getAttributeValue(l_j))
                      END FOR
                   END IF
   
                   ###新建ScrollGrid container元件時,需一併建立SR node結構
                   LET l_sr_node = sadzp168_add_sr_structure(g_template_node, l_name)
                        
                WHEN "Tree" 
                   IF NOT cl_null(p_table_id) THEN
                      LET l_name = p_table_id.trim()
                   ELSE
                      LET l_name = l_new_node.getTagName(), "_gen", g_num USING "<<<<<"  
                      LET g_num = g_num + 1
                   END IF
   
                   ###新建Tree container元件時,需一併建立SR node結構
                   LET l_sr_node = sadzp168_add_sr_structure(g_template_node, l_name)

                   ###在新Tree下新增必須欄位####################
                   LET l_tree_child = l_node.getFirstChild()

                   WHILE l_tree_child IS NOT NULL
                      #Tree需預設"name", "pid", "id", "exp", "isnode", "isExp", "expcode" 7個子節點
                      #在一開始載入Tree的公版切片時,有做過tag="tree_clone"處理(sadzp168_tree_init)
                      IF l_tree_child.getAttribute("tag") = "tree_clone" THEN
                         LET l_tree_child_new = l_new_node.createChild(l_tree_child.getTagName())

                         #抄寫公版上欄位元件的屬性
                         FOR l_j = 1 TO l_tree_child.getAttributesCount()
                             CALL l_tree_child_new.setAttribute(l_tree_child.getAttributeName(l_j), l_tree_child.getAttributeValue(l_j))
                         END FOR

                         #變更控件名稱
                         #LET l_str = l_tree_child.getAttribute("name") CLIPPED, "_", l_name.trim()
                         LET l_str = l_tree_child.getAttribute("name") CLIPPED
                         LET l_idx = l_str.getIndexOf("_gen", 1)
                         
                         IF l_idx > 0 THEN
                            LET l_str = l_str.subString(1, l_idx + 3), g_num USING "<<<<<"  
                         ELSE
                            LET l_str = l_str, "_gen", g_num USING "<<<<<"
                         END IF
                         LET g_num = g_num + 1
      
                         CALL l_tree_child_new.setAttribute("name", l_str)

                         #Tree父/子 ...等:節點關係屬性設置
                         CASE    #l_tree_child.getAttribute("name")
                            WHEN l_str.subString(1, 3) = "exp"
                               LET l_tree_attr.expandedColumn = l_str.trim()
                               
                            WHEN l_str.subString(1, 2) = "id"
                               LET l_tree_attr.idColumn = l_str.trim()
                               
                            WHEN l_str.subString(1, 6) = "isnode"
                               LET l_tree_attr.isNodeColumn = l_str.trim()
                            
                            WHEN l_str.subString(1, 3) = "pid"
                               #CALL l_new_node.setAttribute("parentIdColumn", l_str.trim())
                               LET l_tree_attr.parentIdColumn = l_str.trim()
                         END CASE
                      END IF

                      LET l_tree_child = l_tree_child.getNext()
                   END WHILE

                   CALL l_new_node.setAttribute("name", l_name.trim())
                   CALL sadzp168_add_template_sr_node(l_new_node)

                   #Q類樣版--刪除Tree子節點的tag="tree_clone"屬性
                   #(刪除被複製的Tree節點)
                   CALL sadzp168_tree_init(l_node, l_node.getAttribute("name"), "2")

                OTHERWISE
                   LET l_name = l_new_node.getTagName(), "_gen", g_num USING "<<<<<"  
                   LET g_num = g_num + 1
             END CASE

             CALL l_new_node.setAttribute("name", l_name.trim())
          END IF
      END FOR

      #Tree父/子 ...等:節點關係屬性設置
      IF l_new_node.getTagName() = "Tree" THEN
         CALL l_new_node.setAttribute("expandedColumn", l_tree_attr.expandedColumn)
         CALL l_new_node.setAttribute("idColumn", l_tree_attr.idColumn)
         CALL l_new_node.setAttribute("isNodeColumn", l_tree_attr.isNodeColumn)
         CALL l_new_node.setAttribute("parentIdColumn", l_tree_attr.parentIdColumn)
      END IF
      
      #變更container text屬性值
      IF NOT cl_null(l_new_node.getAttribute("text")) THEN
         #CALL l_new_node.setAttribute("text", l_new_node.getAttribute("name"))
         
         #11/28 決議:避免主程式,子程式,子畫面的多語言在控件同名的前提下,更改Page的text增加程式編號
         IF l_new_node.getTagName() = "Page" THEN
            LET l_name = p_name, ".", g_dzfq_m.dzfq004 CLIPPED
            CALL l_new_node.setAttribute("text", l_name)
         ELSE
            CALL l_new_node.setAttribute("text", l_new_node.getAttribute("name"))
         END IF
      END IF

      #新增加的Container是可以在Spce Designer刪除的
      IF l_new_node.getAttribute("tag") = "CantDel" THEN
         CALL l_new_node.setAttribute("tag", "")
      END IF
   
      #新增的結構若符合[新的第二階層設計點]的Container型式(如:page)
      IF l_new_node.getTagName() = p_tag THEN
         #新的第二階層設計點插入在剛找到的l_node_before之前
         IF l_node_before IS NOT NULL THEN
            CALL l_parent_node.insertBefore(l_new_node, l_node_before)
         END IF
      END IF

      #紀錄目前可新增r.a設計資料的container
      IF l_new_node.getTagName() = g_container_node_t.getTagName() THEN
         LET r_container_node = l_new_node
         EXIT WHILE
      END IF
      
      INITIALIZE l_parent_node TO NULL
      LET l_parent_node = l_new_node
   
      #由外而內複製結構內容
      LET l_node = l_node.getFirstChild()
   END WHILE

   RETURN r_container_node
END FUNCTION

#+ 取得各結構畫面設計資料,並增加欄位node
PRIVATE FUNCTION sadzp168_add_node(p_template_node)
   DEFINE p_template_node   om.DomNode              #UI樣版

   DEFINE l_structure_n     LIKE type_t.num5        #畫面樣版的結構點數量
   DEFINE l_level1          LIKE type_t.num5        #第一階層設計資料順序
   DEFINE l_level2          LIKE type_t.num5        #第二階層設計資料順序

   DEFINE l_structure_node  om.DomNode              #畫面樣版結構點node(如:雙檔有s_browse, vb_master, vb_detail)
   DEFINE l_level1_node     om.DomNode              #第一階層結構點node(通常應該是folder)
   DEFINE l_container_node  om.DomNode              #可以插入欄位widget設計資料的container node
   DEFINE l_result          BOOLEAN

   INITIALIZE l_structure_node TO NULL
   INITIALIZE l_container_node TO NULL
   INITIALIZE l_level1_node TO NULL
   
   #結構類型
   FOR l_structure_n = 1 TO g_dzfr.getLength()

      #取得樣版檔結構點node
      LET l_structure_node = sadzp168_2_get_domNode(p_template_node, g_dzfr[l_structure_n].container, "name", g_dzfr[l_structure_n].structure)

      #為單身結構時(vb_detail):取得單身的第一個欄位資訊,方便未來增加table container時,可以直接增加一個widget在裡面
      IF g_dzfr[l_structure_n].structure = g_detail THEN
         INITIALIZE g_detail_child TO NULL
         INITIALIZE g_detail_lbl_child TO NULL
   
         CALL sadzp168_get_detail_defaultb(p_template_node, g_dzfq_m.dzfq010)
            RETURNING g_detail_child, g_detail_lbl_child
      END IF
      
      #第一階層設計資料(如:folder)
      FOR l_level1 = 1 TO g_dzfr[l_structure_n].sfolder.getLength()

          #取得第一階層結構點node(如:folder)
          LET l_level1_node = sadzp168_get_level1_domNode(l_structure_node, g_dzfr[l_structure_n].sfolder, l_level1)

          #取得第一階層結構點node失敗    
          IF l_level1_node IS NULL THEN
             RETURN FALSE
          END IF
          
          #第二階層設計資料(如:page)
          FOR l_level2 = 1 TO g_dzfr[l_structure_n].sfolder[l_level1].spage.getLength()

              #取得此次結構類型在樣版裡page下的node節點位置
              LET l_container_node = sadzp168_get_container_node(g_dzfr[l_structure_n].structure, 
                                                                 l_level1_node,  
                                                                 l_level2, 
                                                                 g_dzfr[l_structure_n].sfolder[l_level1].spage[l_level2].*)

              #取得結構點node失敗    
              IF l_container_node IS NULL THEN
                 RETURN FALSE
              END IF

              #處理公用欄位頁籤(因為公用欄位採取載入切片方式單獨處理)
              IF g_dzfr[l_structure_n].sfolder[l_level1].spage[l_level2].dzfr012 = "page_info_" THEN
                 LET l_result = sadzp168_common_add_field_pre(g_dzfr[l_structure_n].structure, g_dzfr[l_structure_n].sfolder[l_level1].spage[l_level2].*, l_container_node)

                 IF NOT l_result THEN
                    RETURN FALSE
                 END IF
                 
                 CONTINUE FOR
              END IF

              #將目前運行的container node備份,方便之後複製container用
              LET g_container_node_t = l_container_node

              #依結構類型所屬分類,分開程式處理邏輯
              CASE g_dzfr[l_structure_n].stype
                 WHEN g_browse   #瀏覽表(browser)
                    CALL sadzp168_table_add_field_pre(g_dzfr[l_structure_n].sfolder[l_level1].spage[l_level2].*, 
                                                      g_dzfr[l_structure_n].structure, 
                                                      l_container_node)

                 WHEN g_table     #Table容器(單檔多欄用)
                    #CALL sadzp168_table_add_field_pre(g_dzfa_m.structure[li_dzfb004].sfolder[li_dzfb006].spage[li_dzfb008].*, 
                    #                                  g_dzfa_m.structure[li_dzfb004].structure)

                 WHEN g_master    #單頭
                    CALL sadzp168_master_add_field_pre(g_dzfr[l_structure_n].sfolder[l_level1].spage[l_level2].*, 
                                                       g_dzfr[l_structure_n].stype, 
                                                       l_container_node)
                                     
                 WHEN g_detail    #單身(table)
                    #單身可分Table和ScrollGrid二種,Q類也有Tree
                    CASE g_dzfr[l_structure_n].sfolder[l_level1].spage[l_level2].child_node
                       WHEN "ScrollGrid"
                          IF NOT sadzp168_scrollgrid_add_field_pre(g_dzfr[l_structure_n].sfolder[l_level1].spage[l_level2].*, l_container_node) THEN
                             RETURN FALSE
                          END IF
                          
                       WHEN "Tree"
                          CALL sadzp168_tree_add_field_pre(g_dzfr[l_structure_n].sfolder[l_level1].spage[l_level2].*, l_container_node)

                       OTHERWISE
                          CALL sadzp168_table_add_field_pre(g_dzfr[l_structure_n].sfolder[l_level1].spage[l_level2].*, 
                                                            g_dzfr[l_structure_n].structure, 
                                                            l_container_node)
                    END CASE
                    
                    #IF g_dzfr[l_structure_n].sfolder[l_level1].spage[l_level2].child_node = "ScrollGrid" THEN
                    #   IF NOT sadzp168_scrollgrid_add_field_pre(g_dzfr[l_structure_n].sfolder[l_level1].spage[l_level2].*, l_container_node) THEN
                    #      RETURN FALSE
                    #   END IF
                    #ELSE
                    #   CALL sadzp168_table_add_field_pre(g_dzfr[l_structure_n].sfolder[l_level1].spage[l_level2].*, 
                    #                                     g_dzfr[l_structure_n].structure, 
                    #                                     l_container_node)
                    #END IF
                                                     
                 WHEN g_btree      #樹狀(tree)
                    CALL sadzp168_tree_add_field_pre(g_dzfr[l_structure_n].sfolder[l_level1].spage[l_level2].*, l_container_node)

                 WHEN g_detailexp  #單身鎖定(產生widget方式同單頭)
                    CALL sadzp168_master_add_field_pre(g_dzfr[l_structure_n].sfolder[l_level1].spage[l_level2].*, 
                                                       g_dzfr[l_structure_n].stype, 
                                                       l_container_node)

                 WHEN g_qbe        #Q類版型--QBE Grid(產生widget方式同單頭)
                    CALL sadzp168_master_add_field_pre(g_dzfr[l_structure_n].sfolder[l_level1].spage[l_level2].*, 
                                                       g_dzfr[l_structure_n].stype, 
                                                       l_container_node)

                 WHEN g_headerlock #單頭鎖定(產生widget方式同單頭)
                    CALL sadzp168_master_add_field_pre(g_dzfr[l_structure_n].sfolder[l_level1].spage[l_level2].*, 
                                                       g_dzfr[l_structure_n].stype, 
                                                       l_container_node)
             END CASE
             
          END FOR

          #Q類樣版--刪除Tree子節點的tag="tree_clone"屬性
          IF g_dzfq_m.cbo_progtype = "Q" AND l_container_node.getTagName() = "Tree" THEN
             CALL sadzp168_tree_init(l_container_node, l_container_node.getAttribute("name"), "2")
          END IF
          
      END FOR

   END FOR
   
   RETURN TRUE
END FUNCTION

#+ 在table domNode中增加欄位節點的前置作業
PRIVATE FUNCTION sadzp168_table_add_field_pre(p_spage, p_structure, p_container_node)
   DEFINE p_spage             type_g_page_info
   DEFINE p_structure         STRING                #此table要新增在那種結構類型(單檔多欄和browser就不一樣)
   DEFINE p_container_node    om.DomNode            #要將設計資料新增在那一個結構類型[container]下(單檔多欄和browser就不一樣)

   DEFINE l_table_node        om.DomNode            #table node
   DEFINE l_table_child       om.DomNode            #新增的欄位node要增加在那個節點之前
   DEFINE l_posX              LIKE type_t.num10     #目前元件X軸位置
   DEFINE l_posY              LIKE type_t.num10     #目前元件Y軸位置
   DEFINE l_grid_height       LIKE type_t.num10
   DEFINE l_grid_width        LIKE type_t.num10
   DEFINE l_table_width       LIKE type_t.num10     #table用到的總width
   DEFINE l_add_field         LIKE type_t.chr1      #是否已經找到需要新增的子節點位置
   DEFINE l_add_done          LIKE type_t.chr1      #是否已經做過欄位新增
   DEFINE l_child_count       LIKE type_t.num10     #table容器子節點總個數
   DEFINE l_is_del            LIKE type_t.chr1      #子節點是否需刪除
   DEFINE l_immed_insert      LIKE type_t.chr1      #子節點是否採直接新增方式
   DEFINE l_sr_node           om.DomNode            #原公版的sr node
   DEFINE l_sr_before         om.DomNode            #要新增的欄位,準備新增在那個sr node子節點之前
   DEFINE l_del_table_child   om.DomNode            #Table 要刪除的子節點
   DEFINE l_del_sr_child      om.DomNode            #sr 要刪除的子節點

   DEFINE l_n                 LIKE type_t.num5

   INITIALIZE l_table_node TO NULL
   INITIALIZE l_table_child TO NULL
   INITIALIZE l_sr_node TO NULL
   INITIALIZE l_sr_before TO NULL
   INITIALIZE l_del_table_child TO NULL
   INITIALIZE l_del_sr_child TO NULL
   
   LET l_table_width = 0
   LET l_posX = 0
   LET l_child_count = 0
   LET l_add_field = "N"
   LET l_add_done = "N"
   LET l_n = 0
   LET l_is_del = "N"
   LET l_immed_insert = "N"

   #取得設計資料要新增在那個結構類型(container)下的node節點位置
   LET l_table_node = p_container_node
   
   #取得sr node的節點位置
   LET l_sr_node = sadzp168_2_get_domNode(g_template_node, "Record", "name", l_table_node.getAttribute("name"))

   #找出目前新增欄位結構要新增在那個節點前
   LET l_sr_before = l_sr_node.getFirstChild()
   WHILE l_sr_before IS NOT NULL
      LET l_n = l_n + 1
      
      #取得要插入的節點名稱(設計資料在table的插入點有可能在狀態欄[stus]後, 類型可能為RecordField)
      IF l_sr_before.getAttribute("name") = g_stus AND l_sr_before.getTagName() = "RecordField" THEN

         #container內如果此子節點不為唯一的節點,則往下再跑一個節點,以利做domNode.insertBefore
         IF l_n < l_sr_node.getChildCount() THEN
            #已經找到要新增在那個子節點之前,直接離開While
            LET l_sr_before = l_sr_before.getNext()
         END IF
         EXIT WHILE
      END IF
      LET l_sr_before = l_sr_before.getNext()
   END WHILE

   #todo:沒有找到插入點,代表直接新增在container的最後面節點即可(採直接新增方式)
   IF l_sr_before IS NULL THEN
      LET l_immed_insert = "Y"
   END IF
   
   #找出目前新增欄位結構要新增在那個節點前
   LET l_table_child = l_table_node.getFirstChild()
   WHILE l_table_child IS NOT NULL
      IF l_immed_insert = "Y" AND l_add_done = "N" THEN
         ####Q類版型還要多計算一個"sel" checkbox欄位
         ###IF g_dzfq_m.cbo_progtype <> "Q" THEN
         ###   #單身table 直接新增欄位即可
         LET l_add_field = "Y"
         ###END IF
         
         #單身table第一個欄位啟始位置posX軸都是0
         LET l_posX = l_table_child.getAttribute("posX")
         
         IF cl_null(l_posX) THEN
            LET l_posX = 0
         END IF

         #新增欄位設計資料時,如果公版已有其他子節點又不採[插入]方式新增時,posX值需往後累加
         IF l_sr_before IS NULL AND l_sr_node.getChildCount() > 0 THEN
            LET l_grid_width = l_table_child.getAttribute("gridWidth")
      
            #下一個欄位的X軸位置
            LET l_posX = l_posX + l_grid_width
            LET l_table_width = l_table_width + l_grid_width
         END IF
      END IF
      
      #已經找到要新增的子節點位置(l_add_field), 且尚未做過4fd欄位新增(l_add_done)
      IF l_add_field = "Y" AND l_add_done = "N" THEN
         #判斷設計資料欄位是否採取[插入]方式
         IF l_sr_before IS NULL THEN
            CALL sadzp168_table_add_field(p_spage.*, p_structure, l_table_node, NULL, l_sr_node, NULL, l_posX, l_table_width)
               RETURNING l_posX, l_table_width
         ELSE
            IF l_sr_before.getAttribute("name") = g_stus AND l_sr_before.getTagName() = "RecordField" THEN
               CALL sadzp168_table_add_field(p_spage.*, p_structure, l_table_node, l_table_child, l_sr_node, NULL, l_posX, l_table_width)
                  RETURNING l_posX, l_table_width
            ELSE
               CALL sadzp168_table_add_field(p_spage.*, p_structure, l_table_node, l_table_child, l_sr_node, l_sr_before, l_posX, l_table_width)
                  RETURNING l_posX, l_table_width
            END IF
         END IF
         LET l_add_done = "Y"
      END IF

      #判斷是否為欄位插入點位置
      IF l_table_child.getAttribute("name") = g_stus AND (l_table_child.getTagName() = "CheckBox" OR l_table_child.getTagName() = "ButtonEdit") THEN
         LET l_add_field = "Y"
      END IF

      #畫面公版上欄位屬性[tag]若有設定[Del]表示此欄位需刪除
      #如:單身table預設欄位(defaultb)需刪除
      #此處就先紀錄要刪除的子節點
      IF l_table_child.getAttribute("tag") = "Del" THEN
         LET l_is_del = "Y"
         LET l_del_table_child = l_table_child
      END IF
         
      IF l_add_done = "N" THEN
         #目前欄位的X軸位置
         LET l_posX = l_table_child.getAttribute("posX")
         LET l_posY = l_table_child.getAttribute("posY")
      END IF
      
      #計算下一個欄位啟始X軸位置和統計table已用掉的總寬度,exp:Phantom(widget)沒有高度和寬度的設置
      #直接新增方式,就不計算公版預設欄位的的長/寬
      IF l_immed_insert <> "Y" AND (NOT cl_null(l_table_child.getAttribute("gridWidth"))) THEN
         #子節點屬於要刪除欄位時,不計算其位置
         IF l_table_child.getAttribute("tag") <> "Del" OR cl_null(l_table_child.getAttribute("tag")) THEN
            #新增欄位設計資料後,如果還有其他欄位需做posX值往後移動
            IF l_add_done = "Y" THEN
               IF NOT cl_null(l_table_child.getAttribute("posX")) THEN
                  CALL l_table_child.setAttribute("posX", l_posX)
               END IF
            END IF

            LET l_grid_height = l_table_child.getAttribute("gridHeight")
            LET l_grid_width = l_table_child.getAttribute("gridWidth")

            #下一個欄位的X軸位置
            LET l_posX = l_posX + l_grid_width
            LET l_table_width = l_table_width + l_grid_width
         END IF
      END IF
      
      LET l_table_child = l_table_child.getNext()
   END WHILE

   #將[tag]屬性標記為[Del]的節點刪除
   #如:把s_detail1上預設的欄位(defaultb)刪除
   IF l_is_del = "Y" AND l_del_table_child IS NOT NULL THEN
      CALL l_table_node.removeChild(l_del_table_child)

      #刪除SR 上的節點
      LET l_del_sr_child = sadzp168_2_get_domNode(l_sr_node, "RecordField", "name", l_del_table_child.getAttribute("name"))
      IF l_del_sr_child IS NOT NULL THEN
         CALL l_sr_node.removeChild(l_del_sr_child)
      END IF 
   END IF
   
   #所以重新調整Table和VBox等相關容器的寬度,避免編譯失敗
   #table容器的寬度 = 已用寬度 + 欄位個數 + 1
   LET l_child_count = l_table_node.getChildCount()
   LET l_table_width = l_table_width + l_child_count + 2
   CALL l_table_node.setAttribute("gridWidth", l_table_width)
   CALL sadzp168_container_resize(l_table_node, l_table_width, l_grid_height)
END FUNCTION

#+ 在table domNode中增加欄位點資訊
PRIVATE FUNCTION sadzp168_table_add_field(p_spage, p_structure, p_table_node, p_table_before, p_sr_node, p_sr_before, p_posX, p_table_width)
   DEFINE p_spage        type_g_page_info
   DEFINE p_structure    STRING                #此table要新增在那種結構類型(單檔多欄和browser就不一樣)
   DEFINE p_table_node   om.DomNode            #原公版的table node
   DEFINE p_table_before om.DomNode            #要新增的欄位,準備新增在那個子節點之前
   DEFINE p_sr_node      om.DomNode            #原公版的sr node
   DEFINE p_sr_before    om.DomNode            #要新增的欄位,準備新增在那個sr node子節點之前
   DEFINE p_posX         LIKE type_t.num10     #下一個欄位元件X軸位置
   DEFINE p_table_width  LIKE type_t.num10     #統計table用到的總width

   DEFINE l_new_child    om.DomNode            #新增欄位的子節點
   DEFINE l_field_type   LIKE type_t.chr1      #新欄位的fieldType
   DEFINE l_level3       LIKE type_t.num5
   DEFINE l_widget       STRING                #新增欄位的控件樣式
   DEFINE l_grid_height  LIKE type_t.num10
   DEFINE l_grid_width   LIKE type_t.num10
   DEFINE l_posY         LIKE type_t.num10     #下一個欄位元件Y軸位置
   DEFINE l_sr_child     om.DomNode            #要新增的欄位
   DEFINE l_ref_name     STRING                #欄位的widget name
   DEFINE l_str          STRING
   DEFINE l_node_r       om.DomNode
   DEFINE l_dzek002      LIKE dzek_t.dzek002   #欄位代號
   
   #單頭searchcol items項目先清空
   LET g_searchcol_items = ""

   #table內的欄位Y軸都定義為0 
   LET l_posY = 0
   
   #處理要新增的欄位
   FOR l_level3 = 1 TO p_spage.sfield.getLength()
      #DISPLAY "         colName:", p_spage.sfield[l_level3].colName, ASCII 10
      
      #create欄位歸屬widget(dzep010)子節點
      LET l_widget = sadzp168_get_widget(p_spage.sfield[l_level3].dzej003)

      #取得狀態碼widget樣式
      IF p_spage.sfield[l_level3].dzeb022 = "cdfStatus" THEN
         #狀態碼欄位widget型態規則:B + SCC選項Y/N就產生CheckBox，其他都做ComboBox
         LET l_widget = sadzp168_get_stus_widget(p_spage.sfield[l_level3].sqlTabName, p_spage.sfield[l_level3].colName, p_spage.sfield[l_level3].dzej003)
      END IF

      LET l_new_child = p_table_node.createChild(l_widget.trim())
      
      #瀏覽表(browser)和Q, P類版型的field type都以column like為主
      IF p_structure = g_browse OR (g_dzfq_m.cbo_progtype = "Q" OR g_dzfq_m.cbo_progtype = "P") THEN     
         LET l_field_type = g_column_like
      ELSE
         #單身多頁籤PK欄位widget name不能重覆需rename,因此fieldType屬性為COLUMN_LIKE型態
         IF p_structure = g_detail AND (NOT cl_null(p_spage.sfield[l_level3].detailPK)) THEN
            LET l_field_type = g_column_like
         ELSE
            LET l_field_type = g_table_column
         END IF
      END IF

      CALL sadzp168_set_common_attr(p_spage.sfield[l_level3].*, l_new_child, l_field_type, l_widget, p_posX, l_posY)
         RETURNING l_grid_height, l_grid_width

      #130916 單身產生公用欄位,單身title屬性可以統一名稱
      IF NOT cl_null(p_spage.sfield[l_level3].dzek001) THEN
         SELECT dzek002 INTO l_dzek002 FROM dzek_t WHERE dzek001 = p_spage.sfield[l_level3].dzeb022

         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  STATUS
            LET g_errparam.extend = "SELECT dzek_t(table):"
            LET g_errparam.popup = TRUE
            CALL cl_err()
         ELSE
            IF NOT cl_null(l_dzek002) THEN
               CALL l_new_child.setAttribute("title", "lbl_" || l_dzek002 CLIPPED)
            END IF
         END IF
      END IF

      
      #記錄欄位真正顯示控件
      LET p_spage.sfield[l_level3].widget = base.StringBuffer.create()
      LET l_str = l_new_child.getAttribute("widget")
      CALL p_spage.sfield[l_level3].widget.append(l_str.trim())
      
      #記錄欄位真正顯示控件代號
      LET p_spage.sfield[l_level3].widgetName = base.StringBuffer.create()
      LET l_str = l_new_child.getAttribute("name")
      CALL p_spage.sfield[l_level3].widgetName.append(l_str.trim())
      
      #計算目前已用到多少寬度
      LET p_table_width = p_table_width + l_grid_width
      #下一個欄位點的X軸位置
      LET p_posX = p_posX + l_grid_width

      #將新欄位插入在指定的table child node節點前
      IF p_table_before IS NOT NULL THEN
         #新增欄位子節點在新的table node中,並採用插入方式
         CALL p_table_node.insertBefore(l_new_child, p_table_before)
      END IF

      ############處理Screen Records##############################
      LET l_sr_child = p_sr_node.createChild("RecordField")

      #設置新sr child node的屬性
      CALL sadzp168_set_sr_attr(l_sr_child, l_new_child.getAttribute("sqlTabName") CLIPPED, l_new_child.getAttribute("colName") CLIPPED, l_new_child.getAttribute("name") CLIPPED, l_field_type)

      #將新欄位插入在指定的sr 節點前
      IF p_sr_before IS NOT NULL THEN
         #新增欄位子節點在新的sr node中
         CALL p_sr_node.insertBefore(l_sr_child, p_sr_before)
      END IF 
      ############################################################
      
      ############記錄串查欄位控件和依附控件設定########################
      #雖然單身不用產生串查控件,但是因為tsd需有串查資訊,所以需要在這裡做依附控件資訊的記錄
      #s_browse不需加入串查功能
      IF NOT cl_null(p_spage.sfield[l_level3].dzep020) AND p_structure <> g_browse THEN
         #記錄串查欄位所依附欄位的控件名稱
         LET p_spage.sfield[l_level3].dzal005 = base.StringBuffer.create()
         LET l_str = l_new_child.getAttribute("name")
         CALL p_spage.sfield[l_level3].dzal005.append(l_str)

         #Q類作業需實際新增一個欄位串查
         IF g_dzfq_m.cbo_progtype = "Q" THEN
            #串查欄位命名,只需欄位前名稱加上'url_', exp:dzea001=> url_dzea001;
            LET l_ref_name = l_new_child.getAttribute("name") CLIPPED

            #加入串查欄位
            CALL sadzp168_table_add_url(p_table_node, l_new_child, p_sr_node, l_ref_name, p_posX, l_posY)
               RETURNING l_grid_width, l_grid_height, l_str

            LET l_ref_name = l_str.trim()                      #記錄串查欄位控件名稱
            LET p_table_width = p_table_width + l_grid_width   #計算目前已用到多少寬度   
            LET p_posX = p_posX + l_grid_width                 #下一個欄位點的X軸位置
         ELSE
            #記錄串查欄位控件名稱
            #140313:修改非Q類串查欄位控件名稱規格
            LET l_ref_name = l_new_child.getAttribute("name") CLIPPED
            #IF l_field_type = g_table_column THEN
            #   LET l_ref_name = "prog_", p_spage.sfield[l_level3].colName CLIPPED
            #ELSE
            #   LET l_ref_name = "prog_", l_str.trim()
            #END IF
         END IF

         #記錄串查欄位的控件名稱
         LET p_spage.sfield[l_level3].dzal002 = base.StringBuffer.create()
         CALL p_spage.sfield[l_level3].dzal002.append(l_ref_name)
      END IF
      ############################################################

      ############處理reference欄位################################
      IF NOT cl_null(p_spage.sfield[l_level3].refField) THEN   #130514開放s_browse自動加入ref欄位功能   AND p_structure <> g_browse THEN
         INITIALIZE l_node_r TO NULL
         
         #記錄參考欄位所依附欄位的控件名稱
         LET p_spage.sfield[l_level3].dzai005 = base.StringBuffer.create()
         LET l_str = l_new_child.getAttribute("name")
         CALL p_spage.sfield[l_level3].dzai005.append(l_str)
         
         #TABLE_COLUMN reference欄位命名,只需欄位名稱加上'_desc', exp:dzea_t.dzea001=> dzea001_desc
         IF l_field_type = g_table_column THEN
            LET l_ref_name = p_spage.sfield[l_level3].colName CLIPPED
         ELSE
            #瀏覽表(browser)不處理reference欄位, exp:gztb002_2=> gztb002_2_desc; b_gztb002=> b_gztb002_desc
            #130514開放s_browse自動加入ref欄位功能
            #IF p_structure <> g_browse THEN
            LET l_ref_name = l_new_child.getAttribute("name") CLIPPED
            #END IF
         END IF
         
         #加入reference欄位
         #150608 mail:將Table裡面的FFLabel欄位改為Edit,並設為noEntry
         #CALL sadzp168_add_reference(p_table_node, p_table_before, p_sr_node, p_sr_before, l_ref_name.trim(), p_spage.sfield[l_level3].refField, p_posX, l_posY)
         CALL sadzp168_table_add_reference(p_table_node, p_table_before, p_sr_node, p_sr_before, l_ref_name.trim(), p_spage.sfield[l_level3].refField, p_posX, l_posY)
            RETURNING l_grid_width, l_grid_height, l_node_r 

         #公用欄位的reference欄位,單身title屬性也可以統一名稱(ex:ownid_desc)
         IF NOT cl_null(l_dzek002) THEN
            CALL l_node_r.setAttribute("title", l_dzek002 CLIPPED || "_desc")
         END IF
         
         #記錄參考欄位的控件名稱
         LET p_spage.sfield[l_level3].dzai002 = base.StringBuffer.create()
         LET l_ref_name = l_node_r.getAttribute("name") CLIPPED
         CALL p_spage.sfield[l_level3].dzai002.append(l_ref_name)
         
         LET p_table_width = p_table_width + l_grid_width   #計算目前已用到多少寬度   
         LET p_posX = p_posX + l_grid_width                 #下一個欄位點的X軸位置
      END IF
      ###########################################################

      ############處理多語言欄位控件################################
      IF g_dzfq_m.cbo_progtype = "Q" OR g_dzfq_m.cbo_progtype = "P" THEN
         #Q類版型不需產生多語言欄位

      ELSE
         #當此欄位有多語言欄位時,需要補資料多語言欄位在widget下面
         #當detailPK有值時,代表不是在單身第一次出現的PK欄位,所以就不再做多語言欄位的產生
         IF p_structure <> g_browse AND 
            (NOT cl_null(p_spage.sfield[l_level3].langField)) AND 
            cl_null(p_spage.sfield[l_level3].detailPK) THEN

            INITIALIZE l_node_r TO NULL
         
            #記錄多語言欄位所依附欄位的控件名稱
            LET p_spage.sfield[l_level3].dzaj005 = base.StringBuffer.create()
            LET l_str = l_new_child.getAttribute("name")
            CALL p_spage.sfield[l_level3].dzaj005.append(l_str)
            
            #加入多語言資料欄位
            CALL sadzp168_add_lang(p_table_node, p_table_before, p_sr_node, p_sr_before, p_spage.sfield[l_level3].dzer005, p_spage.sfield[l_level3].langField, p_posX, l_posY)
               RETURNING l_grid_width, l_grid_height, l_node_r
          
            LET p_spage.sfield[l_level3].dzaj002 = base.StringBuffer.create()
            LET l_ref_name = l_node_r.getAttribute("name") CLIPPED
            CALL p_spage.sfield[l_level3].dzaj002.append(l_ref_name)

            LET p_table_width = p_table_width + l_grid_width   #計算目前已用到多少寬度   
            LET p_posX = p_posX + l_grid_width                 #下一個欄位點的X軸位置
         END IF
      END IF
      ###########################################################

      
      ##含有s_browse的樣版,需紀錄searchcol comboBox下可以提供查詢的[欄位]Items項目
      #IF cl_null(g_searchcol_items.trim()) THEN
      #   LET g_searchcol_items = p_spage.sfield[l_level3].colName CLIPPED
      #ELSE
      #   LET g_searchcol_items = g_searchcol_items, ",", p_spage.sfield[l_level3].colName CLIPPED
      #END IF
   END FOR

   ##只有瀏覽表(browser)的結構時,才需要做searchcol的處理
   #IF p_structure = g_browse THEN
   #   #新增樣版在s_browse時有searchcol(comboBox)的欄位子項目
   #   CALL sadzp168_master_searchcol_add_items()
   #END IF
         
   RETURN p_posX, p_table_width 
END FUNCTION

#+ todo:檢查欄位的widget(顯示控件的樣式dzep010)
PRIVATE FUNCTION sadzp168_get_widget(p_widget)
   DEFINE p_widget          STRING
   DEFINE r_widget          STRING

   LET r_widget = p_widget
  
   IF cl_null(r_widget) THEN
      LET r_widget = "Edit"
   END IF
   
   RETURN r_widget
END FUNCTION

#+ todo:檢查status欄位(狀態欄)的widget(顯示控件的樣式dzep010)
PRIVATE FUNCTION sadzp168_get_stus_widget(p_dzea001, p_dzea002, p_widget)
   DEFINE p_dzea001         LIKE dzea_t.dzea001   #資料表代碼
   DEFINE p_dzea002         LIKE dzea_t.dzea002   #欄位代碼
   DEFINE p_widget          STRING                #欄位控件型態
   
   DEFINE l_dzea004         LIKE dzea_t.dzea004   #表格型態
   DEFINE l_cnt             LIKE type_t.num5

   DEFINE r_widget          STRING 

   LET r_widget = p_widget
   
   #取得資料表格型態
   SELECT dzea004 INTO l_dzea004 FROM dzea_t 
     WHERE dzea001 = p_dzea001
     
   IF SQLCA.sqlcode THEN
      #CALL cl_err("SELECT dzek_t:", STATUS, 1)
      DISPLAY "SELECT dzea_t(dzea001=", p_dzea001 CLIPPED, "):", STATUS
      RETURN r_widget
   END IF

   #取得SCC選項個數
   SELECT COUNT(*) INTO l_cnt FROM gzcc_t 
     WHERE gzcc001 = p_dzea001
       AND gzcc002 = p_dzea002
       
   IF SQLCA.sqlcode THEN
      #CALL cl_err("SELECT gzcc_t:", STATUS, 1)
      DISPLAY "SELECT gzcc_t(gzcc001=", p_dzea001 CLIPPED, "; gzcc002=", p_dzea002 CLIPPED, "):", STATUS
      RETURN r_widget
   END IF

   #B + SCC選項Y/N就產生CheckBox
   IF l_dzea004 = "B" AND l_cnt <= 2 THEN
      LET r_widget = "CheckBox"
   END IF

   RETURN r_widget
END FUNCTION

#設置Widget的共同屬性
PUBLIC FUNCTION sadzp168_set_common_attr(p_field_info, p_new_node, p_field_type, p_widget, p_posX, p_posY)
   DEFINE p_field_info        type_g_field          #新建欄位資訊
   DEFINE p_new_node          om.DomNode            #新欄位的node
   DEFINE p_field_type        LIKE type_t.chr1      #新欄位的fieldType
   DEFINE p_widget            STRING                #新增欄位的控件樣式
   DEFINE p_posX              LIKE type_t.num10     #widget X軸位置
   DEFINE p_posY              LIKE type_t.num10     #widget Y軸位置
   
   #DEFINE l_widget            STRING                #新增欄位的控件樣式
   DEFINE l_parent_node       om.DomNode            

   DEFINE r_widget_height     LIKE type_t.num10
   DEFINE r_widget_width      LIKE type_t.num10

   LET r_widget_height = 0
   LET r_widget_width = 0

   IF p_new_node IS NOT NULL THEN
      #增加欄位fieldId和tabIndex都要依續加1
      CALL sadzp168_field_add_index()
      
      CALL p_new_node.setAttribute("aggregateColName", "")
      CALL p_new_node.setAttribute("aggregateName", "")
      CALL p_new_node.setAttribute("aggregateTableAliasName", "")
      CALL p_new_node.setAttribute("aggregateTableName", "")
      CALL p_new_node.setAttribute("columnCount", "")
      CALL p_new_node.setAttribute("fieldId", g_fieldId_max) 

      CASE p_field_type
         WHEN g_non_database    #NON_DATABASE
            
         WHEN g_column_like     #COLUMN_LIKE
            CALL p_new_node.setAttribute("fieldType", "COLUMN_LIKE")

            #符合單身多頁籤PK欄位命名原則時
            #widget name依據sadzp168_get_4fd_structure()內命名原則的邏輯:detailPK值
            IF NOT cl_null(p_field_info.detailPK) THEN
               CALL p_new_node.setAttribute("name", p_field_info.detailPK CLIPPED)
            ELSE
               CALL p_new_node.setAttribute("name", "b_" || p_field_info.colName CLIPPED)
            END IF
            CALL p_new_node.setAttribute("colName", p_field_info.colName CLIPPED)
            CALL p_new_node.setAttribute("sqlTabName", p_field_info.sqlTabName CLIPPED)
            
         WHEN g_table_alias     #TABLE_ALIAS
          
         WHEN g_table_column    #TABLE_COLUMN
            CALL p_new_node.setAttribute("fieldType", "TABLE_COLUMN")
            CALL p_new_node.setAttribute("name", p_field_info.attrName CLIPPED) 
            CALL p_new_node.setAttribute("colName", p_field_info.colName CLIPPED)
            CALL p_new_node.setAttribute("sqlTabName", p_field_info.sqlTabName CLIPPED)
            
         OTHERWISE
      END CASE

      LET r_widget_height = sadzp168_grid_height(p_field_info.dzep010)
      
      #依r.t設定欄位顯示寬度
      LET r_widget_width = p_field_info.widgetWidth
      IF cl_null(r_widget_width) OR r_widget_width = 0 THEN
         LET r_widget_width = 10
      END IF
      
      CALL p_new_node.setAttribute("gridHeight", r_widget_height)  
      CALL p_new_node.setAttribute("gridWidth", r_widget_width)

      CALL p_new_node.setAttribute("posX", p_posX)
      CALL p_new_node.setAttribute("posY", p_posY)

      #公用欄位不可為編輯狀態
      IF NOT cl_null(p_field_info.dzek001) THEN
         CALL p_new_node.setAttribute("noEntry", "true")
      ELSE
         CALL p_new_node.setAttribute("noEntry", "false")
      END IF

      #單身第2頁籤後的PK欄位不可為編輯狀態
      IF NOT cl_null(p_field_info.detailPK) THEN
         CALL p_new_node.setAttribute("noEntry", "true")
      END IF
      
      CALL p_new_node.setAttribute("notNull", sadzp168_transform_boolean_value(p_field_info.notNull CLIPPED))
      CALL p_new_node.setAttribute("required", sadzp168_transform_boolean_value(p_field_info.attrRequired CLIPPED))
      # 位於Table中的必要欄位，不可隱藏 (FUN 160817-00025) 
      CALL p_new_node.setAttribute("unhidable", sadzp168_transform_boolean_value(p_field_info.attrRequired CLIPPED))

      CALL p_new_node.setAttribute("rowCount", "")
      #CALL p_new_node.setAttribute("sqlType", p_sqlype)   #因為資料型態的mapping關係不確定,因此先不給,因為好像不給也沒關係
      CALL p_new_node.setAttribute("stepX", "")
      CALL p_new_node.setAttribute("stepY", "")
      CALL p_new_node.setAttribute("tabIndex", g_tabIndex_max)

      #父節點為Table或Tree,需加上title屬性
      LET l_parent_node = p_new_node.getParent() 
      IF l_parent_node.getTagName() = "Table" OR l_parent_node.getTagName() = "Tree" THEN
         CALL p_new_node.setAttribute("title", "lbl_" || p_field_info.colName CLIPPED)
         #Table和Tree二種widget內的欄位gridHeight都固定為1
         CALL p_new_node.setAttribute("gridHeight", "1")  
      END IF
      
      CALL p_new_node.setAttribute("hidden", "")

      #必要欄位sytle屬性需設定"required"
      IF p_field_info.attrRequired = "Y" THEN
         CALL p_new_node.setAttribute("style", "required")
      ELSE
         CALL p_new_node.setAttribute("style", "")
      END IF

      #設定欄位顯示格式
      IF NOT cl_null(p_field_info.dzep021) THEN
         #ButtonEdit, DateEdit, Edit, FFLabel, SpinEdit, TimeEdit => 才有format屬性
         IF p_field_info.dzep010 = "01" OR p_field_info.dzep010 = "04" OR p_field_info.dzep010 = "05" OR 
            p_field_info.dzep010 = "07" OR p_field_info.dzep010 = "11" OR p_field_info.dzep010 = "13" THEN
            
            CALL p_new_node.setAttribute("format", p_field_info.dzep021 CLIPPED)
         END IF
      END IF

      #設定欄位大小寫  #by Saki
      IF NOT cl_null(p_field_info.dzep023) THEN
         #ButtonEdit, Edit, TimeEdit, TextEdit => 才有case屬性
         IF p_field_info.dzep010 = "01" OR p_field_info.dzep010 = "05" OR p_field_info.dzep010 = "12" OR
            p_field_info.dzep010 = "13" THEN
            CALL p_new_node.setAttribute("case", p_field_info.dzep023 CLIPPED)
         END IF
      END IF
      
      #補上因為不同的widget,有不同的屬性需要增加
      CALL sadzp168_set_other_attr(p_new_node, p_field_info.dzep010, p_widget)
   ELSE
      DISPLAY "p_new_node is null."
   END IF

   RETURN r_widget_height, r_widget_width 
END FUNCTION

#+ fieldId和tabIndex屬性都要是4fd的唯一值
PRIVATE FUNCTION sadzp168_field_add_index() 
   #因為要新增加開窗欄位,所以fieldId和tabIndex都要依續加1,都要是畫面的唯一值
   LET g_fieldId_max = g_fieldId_max + 1
   LET g_tabIndex_max = g_tabIndex_max + 1
END FUNCTION

#+ 取得的widget所要設定的高度
PRIVATE FUNCTION sadzp168_grid_height(p_widget_code)
   DEFINE p_widget_code     STRING
   DEFINE r_height          LIKE type_t.num10

   LET r_height = 1

   #todo:按照4fd產生規則image控件高度為4,TextEdit為加值條件?,其餘都為1
   CASE p_widget_code.trim()
      WHEN "06"   #FFImage
         LET r_height = 4
      WHEN "12"   #TextEdit
         LET r_height = 10
      OTHERWISE
         LET r_height = 1
   END CASE
   
   RETURN r_height
END FUNCTION

#+ 取得的widget所要設定的寬度
PRIVATE FUNCTION sadzp168_grid_width(p_col_name, p_widget_code, p_length) 
   DEFINE p_col_name        STRING                #欄位名稱
   DEFINE p_widget_code     STRING                #控件的代碼
   DEFINE p_length          STRING                #欄位資料長度
   
   DEFINE l_length          LIKE type_t.num10
   
   DEFINE r_width           LIKE type_t.num10

   LET r_width = 15
   
   IF cl_null(p_length) THEN
      DISPLAY "The data length(", p_length, ") of ", p_col_name CLIPPED, " is null."
      RETURN r_width
   END IF

   #如果是數值型態,中間可能會有逗點(','),也需過濾抓取整數位
   TRY 
      IF p_length.getIndexOf(",", 1) > 0 THEN
         LET l_length = p_length.subString(1, p_length.getIndexOf(",", 1) - 1)
      ELSE
         LET l_length = p_length
      END IF
   CATCH
      DISPLAY "The data length of ", p_col_name CLIPPED, " is null."
      RETURN r_width
   END TRY

   #目前設定資料型態長度如果大於30,直接設定寬度為30
   IF l_length > 30 THEN
      LET l_length = 30
   END IF
   
   CASE p_widget_code.trim()
      WHEN "01"        #"ButtonEdit"
         LET r_width = l_length
      WHEN "02"        #"CheckBox"
         LET r_width = 20
      WHEN "03"        #"ComboBox"
         LET r_width = 10
      WHEN "04"        #"DateEdit"     
         LET r_width = l_length
      WHEN "05"        #"Edit"
         LET r_width = l_length
      WHEN "06"        #FFImage
         LET r_width = 17
      WHEN "07"        #FFLabel
         LET r_width = 10
      WHEN "08"        #ProgressBar
      
      WHEN "09"        #"RadioGroup"
         LET r_width = 20   
      WHEN "10"        #Slider
         LET r_width = 10
      WHEN "11"        #SpinEdit
         LET r_width = 10 
      WHEN "12"        #"TextEdit"
         LET r_width = 30
      WHEN "13"        #"TimeEdit"
         LET r_width = l_length
      WHEN "14"        #Field
        
      WHEN "15"        #WebComponent

      OTHERWISE
         LET r_width = l_length
   END CASE

   #避免發生unique tagName error
   IF r_width < 5 THEN
      LET r_width = 5
   END IF
   
   RETURN r_width
END FUNCTION

#+ 針對不同的widget,設置有差異的屬性值
PRIVATE FUNCTION sadzp168_set_other_attr(p_new_node, p_widget_code, p_widget)
   DEFINE p_new_node     om.DomNode            #新增欄位的子節點
   DEFINE p_widget_code  STRING                #控件的代碼
   DEFINE p_widget       STRING                #新增欄位的控件樣式

   DEFINE l_col_name     STRING                #控件欄位名稱 
   DEFINE l_parent_node  om.DomNode            #父節點node
   
   IF p_new_node IS NOT NULL AND p_widget IS NOT NULL THEN 
      CALL p_new_node.setAttribute("widget", p_widget.trim())
   ELSE
      DISPLAY "The field node or widget name is null."
      RETURN
   END IF

   #取得父節點
   LET l_parent_node = p_new_node.getParent()
   
   #取得欄位名稱
   LET l_col_name = p_new_node.getAttribute("colName")
   CALL p_new_node.setAttribute("comment", "cmt_" || l_col_name.trim())
   
   #CASE p_widget_code.trim()
   CASE p_widget.trim()
      WHEN "ButtonEdit"   #"01"        #"ButtonEdit"
         CALL p_new_node.setAttribute("scroll", "true")
         CALL p_new_node.setAttribute("image", "16/openwindow.png")
         CALL p_new_node.setAttribute("action", "controlp")
         CALL p_new_node.setAttribute("lstrcomment", "true")
         CALL p_new_node.setAttribute("lstrtitle", "true")
         CALL p_new_node.setAttribute("lstrAggregatetext", "true")
         
      WHEN "CheckBox"     #"02"        #"CheckBox"
         CALL p_new_node.setAttribute("valueChecked", "Y")
         CALL p_new_node.setAttribute("valueUnchecked", "N")
         CALL p_new_node.setAttribute("sizePolicy", "dynamic")
         CALL p_new_node.setAttribute("lstrcomment", "true")
         CALL p_new_node.setAttribute("lstrtitle", "false")
         CALL p_new_node.setAttribute("lstrtext", "true")
         CALL p_new_node.setAttribute("lstrtitle", "true")
         CALL p_new_node.setAttribute("lstrAggregatetext", "true")

         IF NOT (l_parent_node.getTagName() = "Table" OR l_parent_node.getTagName() = "Tree") THEN
            CALL p_new_node.setAttribute("text", "lbl_" || l_col_name.trim())
         END IF
         
      WHEN "ComboBox"     #"03"        #"ComboBox"
         CALL p_new_node.setAttribute("scroll", "true")
         CALL p_new_node.setAttribute("sizePolicy", "dynamic")
         CALL p_new_node.setAttribute("queryEditable", "true")
         CALL p_new_node.setAttribute("lstrcomment", "true")
         CALL p_new_node.setAttribute("lstrtitle", "true")
         CALL p_new_node.setAttribute("lstrAggregatetext", "true")

         ###130619取消ComboBox的items自動產生,改由runtime由lib動態產生
         ####建立items子項目
         ###CALL sadzp168_set_items_attr(p_new_node)
         
      WHEN "DateEdit"     #"04"        #"DateEdit"     
         CALL p_new_node.setAttribute("lstrcomment", "true")
         CALL p_new_node.setAttribute("lstrtitle", "true")
         CALL p_new_node.setAttribute("lstrAggregatetext", "true")
         
      WHEN "Edit"         #"05"        #"Edit"
         CALL p_new_node.setAttribute("scroll", "true")
         CALL p_new_node.setAttribute("lstrcomment", "true")
         CALL p_new_node.setAttribute("lstrtitle", "true")
         CALL p_new_node.setAttribute("lstrAggregatetext", "true")

         #Table元件內補aggregate相關屬性
         IF l_parent_node.getTagName() = "Table" THEN
            CALL p_new_node.setAttribute("aggregate", "")
            CALL p_new_node.setAttribute("aggregateName", "")
            CALL p_new_node.setAttribute("aggregateText", "")
            CALL p_new_node.setAttribute("aggregateType", "sum")
            CALL p_new_node.setAttribute("lstrAggregatetext", "true")
         END IF

      WHEN "FFImage"      #"06"        #FFImage
         CALL p_new_node.setAttribute("comment", "cmt_img_" || l_col_name.trim())
         CALL p_new_node.setAttribute("widthUnit", "pixels")
         CALL p_new_node.setAttribute("heightUnit", "pixels")
         CALL p_new_node.setAttribute("autoScale", "true")
         CALL p_new_node.setAttribute("justify", "center")
         CALL p_new_node.setAttribute("stretch", "none")
         CALL p_new_node.setAttribute("lstrcomment", "true")
         CALL p_new_node.setAttribute("lstrtitle", "true")
         CALL p_new_node.setAttribute("lstrAggregatetext", "true")
         
      WHEN "FFLabel"      #"07"        #FFLabel
         CALL p_new_node.setAttribute("lstrcomment", "true")
         CALL p_new_node.setAttribute("lstrtitle", "true")
         CALL p_new_node.setAttribute("lstrAggregatetext", "true")
         
      WHEN "ProgressBar"  #"08"        #ProgressBar
         CALL p_new_node.setAttribute("lstrcomment", "true")
         CALL p_new_node.setAttribute("lstrtitle", "true")
         CALL p_new_node.setAttribute("lstrAggregatetext", "true")
         
      WHEN "RadioGroup"   #"09"        #"RadioGroup"
         CALL p_new_node.setAttribute("orientation", "horizontal")
         CALL p_new_node.setAttribute("lstrcomment", "true")
         CALL p_new_node.setAttribute("lstrtitle", "true")
         CALL p_new_node.setAttribute("lstrAggregatetext", "true")

         ###130619取消ComboBox的items自動產生,改由runtime由lib動態產生
         ####建立items子項目
         ###CALL sadzp168_set_items_attr(p_new_node)
         
      WHEN "Slider"       #"10"        #Slider
         CALL p_new_node.setAttribute("step", "1")
         CALL p_new_node.setAttribute("sliderOrientation", "horizontal")
         CALL p_new_node.setAttribute("valueMin", "0")
         CALL p_new_node.setAttribute("valueMax", "5")
         CALL p_new_node.setAttribute("lstrcomment", "true")
         CALL p_new_node.setAttribute("lstrtitle", "true")
         CALL p_new_node.setAttribute("lstrAggregatetext", "true")
         
      WHEN "SpinEdit"     #"11"        #SpinEdit
         CALL p_new_node.setAttribute("scroll", "true")
         CALL p_new_node.setAttribute("step", "1")
         CALL p_new_node.setAttribute("valueMin", "0")
         CALL p_new_node.setAttribute("valueMax", "100")
         CALL p_new_node.setAttribute("lstrcomment", "true")
         CALL p_new_node.setAttribute("lstrtitle", "true")
         CALL p_new_node.setAttribute("lstrAggregatetext", "true")
          
      WHEN "TextEdit"     #"12"        #"TextEdit"
         CALL p_new_node.setAttribute("lstrcomment", "true")
         CALL p_new_node.setAttribute("lstrtitle", "true")
         CALL p_new_node.setAttribute("lstrAggregatetext", "true")
         
      WHEN "TimeEdit"     #"13"        #"TimeEdit"
         CALL p_new_node.setAttribute("scroll", "true")
         CALL p_new_node.setAttribute("lstrcomment", "true")
         CALL p_new_node.setAttribute("lstrtitle", "true")
         CALL p_new_node.setAttribute("lstrAggregatetext", "true")
         
      WHEN "Field"        #"14"        #Field
         CALL p_new_node.setAttribute("lstrcomment", "true")
         CALL p_new_node.setAttribute("lstrtitle", "true")
         CALL p_new_node.setAttribute("lstrAggregatetext", "true")
         
      WHEN "WebComponent" #"15"        #WebComponent
         CALL p_new_node.setAttribute("lstrcomment", "true")
         
      OTHERWISE
         
   END CASE
   
END FUNCTION

#設置sr的RecordField屬性
PRIVATE FUNCTION sadzp168_set_sr_attr(p_new_node, p_tab_name, p_col_name, p_name, p_field_type)
   DEFINE p_new_node          om.DomNode            #新欄位的node
   DEFINE p_tab_name          STRING                #欄位所屬資料表名稱
   DEFINE p_col_name          STRING                #欄位名稱
   DEFINE p_name              STRING                #4fd上widget屬性TABLE_COLUMN時的命名(name屬性)
   DEFINE p_field_type        LIKE type_t.chr1      #欄位的fieldType

   CASE p_field_type
      WHEN g_non_database    #NON_DATABASE
         CALL p_new_node.setAttribute("name", p_name.trim())
         CALL p_new_node.setAttribute("colName", "")
         CALL p_new_node.setAttribute("sqlTabName", "")
         
      WHEN g_column_like     #COLUMN_LIKE
         CALL p_new_node.setAttribute("fieldType", "COLUMN_LIKE")

         CALL p_new_node.setAttribute("name", p_name.trim())
         CALL p_new_node.setAttribute("colName", p_col_name.trim())
         CALL p_new_node.setAttribute("sqlTabName", p_tab_name.trim())
         
      WHEN g_table_alias     #TABLE_ALIAS
        
      WHEN g_table_column    #TABLE_COLUMN
         CALL p_new_node.setAttribute("fieldType", "TABLE_COLUMN")
         CALL p_new_node.setAttribute("name", p_name.trim())
         CALL p_new_node.setAttribute("colName", p_col_name.trim())
         CALL p_new_node.setAttribute("sqlTabName", p_tab_name.trim())
      OTHERWISE
   END CASE

   CALL p_new_node.setAttribute("fieldIdRef", g_fieldId_max) 
   
END FUNCTION

#+ 針對ScrollGrid下的欄位設置特殊屬性
PRIVATE FUNCTION sadzp168_set_scrollgrid_attr(p_node, p_row_cnt)
   DEFINE p_node         om.DomNode            #要設置屬性的node
   DEFINE p_row_cnt      LIKE type_t.num5      #共有幾排row

   #屬於ScrollGrid下的控件需額外設定以下屬性
   CALL p_node.setAttribute("repeat", g_detail_child.getAttribute("repeat"))
   CALL p_node.setAttribute("columnCount", g_detail_child.getAttribute("columnCount"))
   CALL p_node.setAttribute("rowCount", g_detail_child.getAttribute("rowCount"))
   CALL p_node.setAttribute("stepX", g_detail_child.getAttribute("stepX"))      
   CALL p_node.setAttribute("stepY", p_row_cnt)
      
END FUNCTION

#+ 在新增欄位時,widget後面增加reference欄位
PRIVATE FUNCTION sadzp168_add_reference(p_node, p_node_before, p_sr_node, p_sr_before, p_field_name, p_title, p_posX, p_posY)
   DEFINE p_node         om.DomNode            #需要新增欄位節點的domNode
   DEFINE p_node_before  om.DomNode            #欄位要新增在node節點之前
   DEFINE p_sr_node      om.DomNode            #原公版的sr node
   DEFINE p_sr_before    om.DomNode            #欄位要新增在sr node節點之前
   DEFINE p_field_name   STRING                #欄位名稱
   DEFINE p_title        STRING                #欄位title屬性
   DEFINE p_posX         LIKE type_t.num10     #Label元件X軸位置
   DEFINE p_posY         LIKE type_t.num10     #Label元件Y軸位置
   
   DEFINE l_new_child    om.DomNode            #新增欄位的子節點
   DEFINE l_sr_child     om.DomNode            #要新增的欄位
   DEFINE l_grid_height  LIKE type_t.num10
   DEFINE l_grid_width   LIKE type_t.num10
   DEFINE l_name         STRING                #FFLabel的name屬性值
   
   #Static Label(敘述):預設高為1,寬為10
   LET l_grid_height = 1 
   LET l_grid_width = 10
   LET l_name = p_field_name CLIPPED, "_desc"
   
   #增加欄位FFLabel只會用到fieldId,因此將值加1
   LET g_fieldId_max = g_fieldId_max + 1
      
   #當主要欄位需要有參考欄位輔助說明時,需增加FFLabel
   #exp:[地區別] [地區別名稱]
   LET l_new_child = p_node.createChild("FFLabel")

   CALL l_new_child.setAttribute("aggregateColName", "")
   CALL l_new_child.setAttribute("aggregateName", "")
   CALL l_new_child.setAttribute("aggregateTableAliasName", "")
   CALL l_new_child.setAttribute("aggregateTableName", "")
   CALL l_new_child.setAttribute("colName", "")
   CALL l_new_child.setAttribute("columnCount", "")
   CALL l_new_child.setAttribute("fieldId", g_fieldId_max) 

   CALL l_new_child.setAttribute("fieldType", "NON_DATABASE")
   CALL l_new_child.setAttribute("name", l_name.trim())

   CALL l_new_child.setAttribute("gridHeight", l_grid_height)  
   CALL l_new_child.setAttribute("gridWidth", l_grid_width)

   CALL l_new_child.setAttribute("posX", p_posX)
   CALL l_new_child.setAttribute("posY", p_posY)
   CALL l_new_child.setAttribute("rowCount", "")
   CALL l_new_child.setAttribute("sqlTabName", "")
   CALL l_new_child.setAttribute("stepX", "")
   CALL l_new_child.setAttribute("stepY", "")
   CALL l_new_child.setAttribute("style", "reference")
   CALL l_new_child.setAttribute("sizePolicy", "fixed")
   CALL l_new_child.setAttribute("comment", "cmt_" || l_name.trim())
   CALL l_new_child.setAttribute("widget", "FFLabel")
   CALL l_new_child.setAttribute("lstrcomment", "true")
   CALL l_new_child.setAttribute("lstrtitle", "true")
   CALL l_new_child.setAttribute("lstrAggregatetext", "true")

   IF p_node.getTagName() = "Table" OR p_node.getTagName() = "Tree" THEN
      CALL l_new_child.setAttribute("title", "lbl_" || p_title.trim())
   END IF
   
   #將新欄位插入在指定的節點前
   IF p_node_before IS NOT NULL THEN
      CALL p_node.insertBefore(l_new_child, p_node_before)
   END IF
   
   ###處理Screen Records###
   LET l_sr_child = p_sr_node.createChild("RecordField")
   CALL l_sr_child.setAttribute("colName", "")
   CALL l_sr_child.setAttribute("fieldIdRef", g_fieldId_max) 
   CALL l_sr_child.setAttribute("fieldType", "NON_DATABASE")
   CALL l_sr_child.setAttribute("name", l_name.trim())
   CALL l_sr_child.setAttribute("sqlTabName", "")

   #將新欄位插入在指定的sr 節點前
   IF p_sr_before IS NOT NULL THEN
      CALL p_sr_node.insertBefore(l_sr_child, p_sr_before)
   END IF
   
   RETURN l_grid_width, l_grid_height, l_new_child
END FUNCTION

#+ 在新增欄位時,widget增加多語言欄位
PRIVATE FUNCTION sadzp168_add_lang(p_node, p_node_before, p_sr_node, p_sr_before, p_table_name, p_field_name, p_posX, p_posY)
   DEFINE p_node         om.DomNode            #需要新增欄位節點的domNode
   DEFINE p_node_before  om.DomNode            #欄位要新增在node節點之前
   DEFINE p_sr_node      om.DomNode            #原公版的sr node
   DEFINE p_sr_before    om.DomNode            #欄位要新增在sr node節點之前
   DEFINE p_table_name   STRING                #資料表名稱
   DEFINE p_field_name   STRING                #欄位名稱
   #DEFINE p_title        STRING                #欄位title屬性
   DEFINE p_posX         LIKE type_t.num10     #Label元件X軸位置
   DEFINE p_posY         LIKE type_t.num10     #Label元件Y軸位置
   
   DEFINE l_new_child    om.DomNode            #新增欄位的子節點
   DEFINE l_sr_child     om.DomNode            #要新增的欄位
   DEFINE l_parent_node  om.DomNode
   DEFINE l_grid_height  LIKE type_t.num10
   DEFINE l_grid_width   LIKE type_t.num10
   DEFINE l_name         STRING                #FFLabel的name屬性值
   
   #多語言欄位:預設高為1,寬為30
   LET l_grid_height = 1 
   LET l_grid_width = 30
   LET l_name = p_table_name.trim(), ".", p_field_name.trim()
   
   #增加多語言欄位(ButtonEdit) fieldId和tabIndex都要依續加1
   CALL sadzp168_field_add_index()
      
   #當主要欄位需要有多語言欄位資料編輯時,需增加ButtonEdit
   #exp:[料件編號] [品名]
   LET l_new_child = p_node.createChild("ButtonEdit")

   CALL l_new_child.setAttribute("aggregateColName", "")
   CALL l_new_child.setAttribute("aggregateName", "")
   CALL l_new_child.setAttribute("aggregateTableAliasName", "")
   CALL l_new_child.setAttribute("aggregateTableName", "")
   CALL l_new_child.setAttribute("columnCount", "")
   CALL l_new_child.setAttribute("fieldId", g_fieldId_max) 
      
   CALL l_new_child.setAttribute("fieldType", "TABLE_COLUMN")
   CALL l_new_child.setAttribute("sqlTabName", p_table_name.trim())
   CALL l_new_child.setAttribute("colName", p_field_name.trim())
   CALL l_new_child.setAttribute("name", l_name.trim()) 

   CALL l_new_child.setAttribute("gridHeight", l_grid_height)  
   CALL l_new_child.setAttribute("gridWidth", l_grid_width)

   CALL l_new_child.setAttribute("posX", p_posX)
   CALL l_new_child.setAttribute("posY", p_posY)
   
   CALL l_new_child.setAttribute("noEntry", "false")
   CALL l_new_child.setAttribute("notNull", "false")
   CALL l_new_child.setAttribute("required", "false")

   CALL l_new_child.setAttribute("rowCount", "")
   CALL l_new_child.setAttribute("stepX", "")
   CALL l_new_child.setAttribute("stepY", "")
   CALL l_new_child.setAttribute("tabIndex", g_tabIndex_max)
      
   #父節點為Table或Tree,需加上title屬性
   LET l_parent_node = l_new_child.getParent() 
   IF l_parent_node.getTagName() = "Table" OR l_parent_node.getTagName() = "Tree" THEN
      CALL l_new_child.setAttribute("title", "lbl_" || p_field_name.trim())
      #Table和Tree二種widget內的欄位gridHeight都固定為1
      CALL l_new_child.setAttribute("gridHeight", "1")  
   END IF
      
   CALL l_new_child.setAttribute("hidden", "")
   CALL l_new_child.setAttribute("style", "")
      
   CALL l_new_child.setAttribute("scroll", "true")
   CALL l_new_child.setAttribute("image", "16/langmodify.png")
   CALL l_new_child.setAttribute("action", "update_item")
   CALL l_new_child.setAttribute("lstrcomment", "true")
   CALL l_new_child.setAttribute("lstrtitle", "true")
   CALL l_new_child.setAttribute("lstrAggregatetext", "true")   
      
   CALL l_new_child.setAttribute("comment", "cmt_" || p_field_name.trim())
   CALL l_new_child.setAttribute("widget", "ButtonEdit")
   
   #將新欄位插入在指定的節點前
   IF p_node_before IS NOT NULL THEN
      CALL p_node.insertBefore(l_new_child, p_node_before)
   END IF
   
   ###處理Screen Records###
   LET l_sr_child = p_sr_node.createChild("RecordField")

   CALL l_sr_child.setAttribute("fieldType", "TABLE_COLUMN")
   CALL l_sr_child.setAttribute("sqlTabName", p_table_name.trim())
   CALL l_sr_child.setAttribute("colName", p_field_name.trim())
   CALL l_sr_child.setAttribute("name", l_name.trim())
   CALL l_sr_child.setAttribute("fieldIdRef", g_fieldId_max) 
         

   #將新欄位插入在指定的sr 節點前
   IF p_sr_before IS NOT NULL THEN
      CALL p_sr_node.insertBefore(l_sr_child, p_sr_before)
   END IF
   
   RETURN l_grid_width, l_grid_height, l_new_child
END FUNCTION

#+ 轉換"Y"=>"true"; "N"=>"false"
PRIVATE FUNCTION sadzp168_transform_boolean_value(p_value)
   DEFINE p_value           STRING
   DEFINE r_value           LIKE type_t.chr5

   LET r_value = ""

   IF p_value.toUpperCase() = "Y" THEN
      LET r_value = "true"
   ELSE
      LET r_value = "false"
   END IF
   
   RETURN r_value
END FUNCTION

#+ 調整Table和VBox、Grid、Form的寬度
#todo:resize邏輯可以再檢視一遍
PRIVATE FUNCTION sadzp168_container_resize(p_node, p_width, p_height)
   DEFINE p_node            om.DomNode            #table的節點domNode
   DEFINE p_width           LIKE type_t.num10     #此次要設定的容器大小
   DEFINE p_height          LIKE type_t.num10     #此次要設定的容器大小
   
   DEFINE l_width_source    LIKE type_t.num10     #容器原始大小
   DEFINE l_height_source   LIKE type_t.num10     #容器原始大小
   DEFINE l_grid_width      LIKE type_t.num10     #子容器寬度
   DEFINE l_child           om.DomNode 
   DEFINE l_posX            LIKE type_t.num10
   DEFINE l_grid_height     LIKE type_t.num10     #子容器寬度
   DEFINE l_posY            LIKE type_t.num10
   
   LET p_node = p_node.getParent()
   LET l_width_source = 0
   LET l_height_source = 0
   LET l_grid_width = 0
   LET l_posX = 0
   LET l_grid_height = 0
   LET l_posY = 0
   
   #ManagedForm:表示已達到XML Document頂端
   IF p_node.getTagName() = "ManagedForm" THEN
      RETURN
   END IF
      
   #DISPLAY "TagName:", p_node.getTagName(), ";", ASCII 10
   IF (NOT cl_null(p_node.getAttribute("gridWidth"))) AND (NOT cl_null(p_node.getAttribute("gridHeight"))) THEN
      #DISPLAY "   gridWidth:", p_width, ";"
      LET l_width_source = p_node.getAttribute("gridWidth")
      LET l_height_source = p_node.getAttribute("gridHeight")
      
      CASE p_node.getTagName()
         WHEN "VBox"
            LET l_child = p_node.getFirstChild()
            LET l_posY = l_child.getAttribute("posY")   #取得第一個子元件的Y軸
            
            WHILE l_child IS NOT NULL
               #取得子元件X軸所用最大的值
               IF l_posX < l_child.getAttribute("posX") THEN
                  LET l_posX = l_child.getAttribute("posX")   
               END IF
               
               #每個子元件需跟著變更Y軸位置
               IF (NOT cl_null(l_posY)) AND (NOT cl_null(l_child.getAttribute("posY"))) AND l_child.getAttribute("posY") < l_posY THEN
                  CALL l_child.setAttribute("posY", l_posY)
               END IF

               #紀錄子元件最大寬度
               IF (NOT cl_null(l_child.getAttribute("gridWidth"))) AND l_child.getAttribute("gridWidth") > p_width THEN
                  LET p_width = l_child.getAttribute("gridWidth")
               END IF
               
               IF (NOT cl_null(l_child.getAttribute("gridWidth"))) AND l_child.getAttribute("gridWidth") < p_width THEN
                  CALL l_child.setAttribute("gridWidth", p_width)
               END IF

               #計算下一個子元件的Y軸位置, exp:下一個元件Y軸位置 = 元件目前Y軸位置 + 元件高度
               LET l_grid_height = l_child.getAttribute("gridHeight")
               LET l_posY = l_posY + l_grid_height

               LET l_child = l_child.getNext()
            END WHILE
            LET p_height = l_posY + 4
            LET p_width = p_width + l_posX

         WHEN "Group"
            LET l_child = p_node.getFirstChild()
            LET l_posX = l_child.getAttribute("posX")   #取得第一個子元件的X軸
            LET l_posY = l_child.getAttribute("posY")   #取得第一個子元件的Y軸
            
            LET p_width = p_width + l_posX + 1
            LET p_height = p_height + l_posY + 1

         WHEN "Folder"
            LET p_width = p_width + 2
            LET p_height = p_height + 2
            
         WHEN "HBox"
            #IF p_node.getChildCount() > 1 THEN
            LET l_child = p_node.getFirstChild()
            LET l_posX = l_child.getAttribute("posX")   #取得第一個子元件的X軸
            
            WHILE l_child IS NOT NULL
               #取得子元件Y軸所用最大的值
               IF l_posY < l_child.getAttribute("posY") THEN
                  LET l_posY = l_child.getAttribute("posY")   
               END IF
               
               #每個子元件需跟著變更X軸位置
               IF (NOT cl_null(l_posX)) AND (NOT cl_null(l_child.getAttribute("posX"))) AND l_child.getAttribute("posX") < l_posX THEN
                  CALL l_child.setAttribute("posX", l_posX)
               END IF

               #紀錄子元件最大高度
               IF (NOT cl_null(l_child.getAttribute("gridHeight"))) AND l_child.getAttribute("gridHeight") > p_height THEN
                  LET p_height = l_child.getAttribute("gridHeight")
               END IF
               
               IF (NOT cl_null(l_child.getAttribute("gridHeight"))) AND l_child.getAttribute("gridHeight") < p_height THEN
                  CALL l_child.setAttribute("gridHeight", p_height)
               END IF

               #計算下一個子元件的X軸位置, exp:下一個元件X軸位置 = 元件目前X軸位置 + 元件寬度
               LET l_grid_width = l_child.getAttribute("gridWidth")
               LET l_posX = l_posX + l_grid_width

               LET l_child = l_child.getNext()
            END WHILE
            LET p_width = l_posX + 4
            LET p_height = p_height + l_posY

         #WHEN "Form"
         OTHERWISE
            LET l_child = p_node.getFirstChild()
            LET l_posX = l_child.getAttribute("posX")   #取得第一個子元件的X軸
            
            WHILE l_child IS NOT NULL
               #取得子元件Y軸所用最大的值
               IF l_posY < l_child.getAttribute("posY") THEN
                  LET l_posY = l_child.getAttribute("posY")   
               END IF

               #紀錄子元件最大高度
               IF (NOT cl_null(l_child.getAttribute("gridHeight"))) AND l_child.getAttribute("gridHeight") > p_height THEN
                  LET p_height = l_child.getAttribute("gridHeight")
               END IF
               
               IF (NOT cl_null(l_child.getAttribute("gridHeight"))) AND l_child.getAttribute("gridHeight") < p_height THEN
                  CALL l_child.setAttribute("gridHeight", p_height)
               END IF

               #計算下一個子元件的X軸位置, exp:下一個元件X軸位置 = 元件目前X軸位置 + 元件寬度
               LET l_grid_width = l_child.getAttribute("gridWidth")
               LET l_posX = l_posX + l_grid_width
                  
               LET l_child = l_child.getNext()
            END WHILE
            LET p_width = l_posX + 1
            LET p_height = p_height + l_posY
      END CASE

      #如果父節點container的原始寬度小於要設置的寬度,則設定新的最大寬度
      IF l_width_source < p_width THEN
         CALL p_node.setAttribute("gridWidth", p_width)
      END IF

      #如果父節點container的原始高度小於要設置的高度,則設定新的最大高度
      IF l_height_source < p_height THEN
         CALL p_node.setAttribute("gridHeight", p_height)
      END IF
   END IF

   CALL sadzp168_container_resize(p_node, p_width, p_height)
END FUNCTION

#+ 在單頭 domNode中增加欄位節點的前置作業
PRIVATE FUNCTION sadzp168_master_add_field_pre(p_spage, p_stype, p_container_node)
   DEFINE p_spage             type_g_page_info
   DEFINE p_stype             STRING                #結構類型所屬分類(如:瀏灠表, 單頭, 單身, Tree)
   DEFINE p_container_node    om.DomNode            #要將設計資料新增在那一個結構類型[container]下
   
   DEFINE l_master_node       om.DomNode            #樣版單頭node
   DEFINE l_common_node       om.DomNode            #樣版公用欄位node
   DEFINE l_master_sr_node    om.DomNode            #樣版單頭所屬sr node

   INITIALIZE l_master_node TO NULL
   INITIALIZE l_master_sr_node TO NULL
   INITIALIZE l_common_node TO NULL
   
   #取得設計資料要新增在那個結構類型(container)下的node節點位置
   LET l_master_node = p_container_node

   #取得樣版單頭 sr node
   LET l_master_sr_node = sadzp168_get_master_sr_domNode()

   ###IF (g_dzfq_m.cbo_progtype = "Q" OR g_dzfq_m.cbo_progtype = "P") AND (g_dzfq_m.cbo_setbrowse = "vq" OR g_dzfq_m.cbo_setbrowse = "hq") THEN
   IF p_stype = g_qbe THEN
      #在一般QBE中新增欄位節點
      CALL sadzp168_qbe_add_field(p_spage.*, l_master_node, l_master_sr_node)
   ELSE
      #在一般單頭中新增欄位節點
      CALL sadzp168_master_add_field(p_spage.*, p_stype, l_master_node, l_master_sr_node)
   END IF
END FUNCTION

#+ 在單頭 domNode中增加欄位點資訊
PRIVATE FUNCTION sadzp168_master_add_field(p_spage, p_stype, p_master_node, p_sr_node)
   DEFINE p_spage             type_g_page_info
   DEFINE p_stype             STRING                #結構類型所屬分類(如:瀏灠表, 單頭, 單身, Tree)
   DEFINE p_master_node       om.DomNode            #需要新增欄位節點的domNode
   DEFINE p_sr_node           om.DomNode            #公版單頭所屬的sr node

   DEFINE l_new_child         om.DomNode            #新增欄位的子節點
   DEFINE l_sr_child          om.DomNode            #sr要新增的子即點
   DEFINE l_level3            LIKE type_t.num5
   DEFINE l_widget            STRING                #新增欄位的控件樣式
   DEFINE l_posX              LIKE type_t.num10     #下一個欄位元件X軸位置
   DEFINE l_posY              LIKE type_t.num10     #下一個欄位元件Y軸位置
   DEFINE l_posX_start        LIKE type_t.num10     #每一排元件X軸啟始位置
   DEFINE l_posY_start        LIKE type_t.num10     #每一排元件Y軸啟始位置
   DEFINE l_grid_height       LIKE type_t.num10
   DEFINE l_grid_width        LIKE type_t.num10
   DEFINE l_posX_max          LIKE type_t.num10     #此grid中欄位控件用到的posX最大值(準備下一排grid使用的posX起始點)
   DEFINE l_posY_max          LIKE type_t.num10     #此grid中欄位控件用到的posY最大值(準備下一行欄位控件使用的poxY起始點)
   DEFINE l_container_height  LIKE type_t.num10     #上層父節點container已用高度
   DEFINE l_container_width   LIKE type_t.num10     #上層父節點container已用總寬度
   DEFINE l_field_type        LIKE type_t.chr1      #新欄位的fieldType
   DEFINE l_ref_name          STRING                #reference欄位的widget name
   DEFINE l_str               STRING
   DEFINE l_flag              LIKE type_t.chr1
   DEFINE l_dzer              RECORD LIKE dzer_t.*  #欄位資料多語言設計表
   DEFINE l_stus_field        type_g_field          #status欄位資訊
   DEFINE l_node_r            om.DomNode
   DEFINE l_dzfq008           LIKE dzfq_t.dzfq008   #換行數量
   DEFINE l_header_lock       om.DomNode            #單頭鎖定[headerlock_group]
   
   INITIALIZE l_stus_field.* TO NULL
   INITIALIZE l_node_r TO NULL
   INITIALIZE l_header_lock TO NULL
   
   #一般單頭樣式新增欄位,直接用r.a上的換行數量
   LET l_dzfq008 = g_dzfq_m.dzfq008

   #單頭鎖定樣式新增欄位,固定3個欄位換一行
   IF p_stype = g_headerlock THEN
      LET l_dzfq008 = 3
   END IF
   
   #預設單頭欄位的啟始位置
   IF p_master_node.getTagName() <> "Group" THEN
      LET l_posX_start = 1
      LET l_posY_start = 0
   ELSE
      #Group widget的posX 和posY 起始位置至少都是1開始
      LET l_posX_start = 1
      LET l_posY_start = 1
   END IF
   
   LET l_posX = l_posX_start 
   LET l_posY = l_posY_start
   LET l_posX_max = 0
   LET l_posY_max = 0
   LET l_container_width = 0
   LET l_container_height = 0

   #Q, P類版型的field type都以column like為主
   IF g_dzfq_m.cbo_progtype = "Q" OR g_dzfq_m.cbo_progtype = "P" THEN     
      LET l_field_type = g_column_like
   ELSE
      #預設 單頭的欄位都是TABLE_COLUMN型態
      LET l_field_type = g_table_column
   END IF
   
   #處理要新增的欄位
   FOR l_level3 = 1 TO p_spage.sfield.getLength()

      #載入stus切片檔案
      IF p_spage.sfield[l_level3].dzeb022 = "cdfStatus" AND (NOT (g_dzfq_m.cbo_progtype = "Q" OR g_dzfq_m.cbo_progtype = "P")) THEN
         LET p_spage.sfield[l_level3].widget = base.StringBuffer.create()
         LET p_spage.sfield[l_level3].widgetName = base.StringBuffer.create()

         LET l_stus_field.* = p_spage.sfield[l_level3].*
      ELSE
         #create欄位歸屬widget(dzep010)子節點
         LET l_widget = sadzp168_get_widget(p_spage.sfield[l_level3].dzej003)

         #在單頭中的一個欄位控件新增 = [Label(敘述)] + [欄位控件] + [FFLabel(參考欄位)]
         #X軸隨wdiget累加: Y軸在同一列不變

         #如果欄位有設定串查功能,就需要用Button的控件
         IF NOT cl_null(p_spage.sfield[l_level3].dzep020) THEN
            #增加串查功能
            CALL sadzp168_master_add_qrystr(p_master_node, p_spage.sfield[l_level3].colName, l_posX, l_posY)
               RETURNING l_grid_width, l_grid_height, l_ref_name
         ELSE
            #增加Label(敘述)
            CALL sadzp168_add_static_label(p_master_node, p_spage.sfield[l_level3].*, l_field_type, l_posX, l_posY, "10")
               RETURNING l_grid_width, l_grid_height, l_node_r
         END IF

         #下一個欄位點的X軸位置
         LET l_posX = l_posX + l_grid_width + 1
      
         #比較一下同一列的每個widget高度最大己用posY值
         IF l_posY_max < l_grid_height THEN
            LET l_posY_max = l_grid_height
         END IF
      
         #新增真正可操作的欄位子節點widget
         LET l_new_child = p_master_node.createChild(l_widget.trim()) 

         CALL sadzp168_set_common_attr(p_spage.sfield[l_level3].*, l_new_child, l_field_type, l_widget, l_posX, l_posY)
            RETURNING l_grid_height, l_grid_width

         #記錄欄位真正顯示控件
         LET p_spage.sfield[l_level3].widget = base.StringBuffer.create()
         LET l_str = l_new_child.getAttribute("widget")
         CALL p_spage.sfield[l_level3].widget.append(l_str.trim())

         #記錄欄位真正顯示控件代號
         LET p_spage.sfield[l_level3].widgetName = base.StringBuffer.create()
         LET l_str = l_new_child.getAttribute("name")
         CALL p_spage.sfield[l_level3].widgetName.append(l_str.trim())
      
         #比較一下同一列的每個widget高度最大己用posY值
         IF l_posY_max < l_grid_height THEN
            LET l_posY_max = l_grid_height
         END IF

         #下一個欄位點的X軸位置
         LET l_posX = l_posX + l_grid_width + 1 

         ############處理Screen Records##############################
         LET l_sr_child = p_sr_node.createChild("RecordField")

         #設置新sr child node的屬性
         CALL sadzp168_set_sr_attr(l_sr_child, l_new_child.getAttribute("sqlTabName") CLIPPED, l_new_child.getAttribute("colName") CLIPPED, l_new_child.getAttribute("name") CLIPPED, l_field_type)
         ###########################################################

         ############記錄串查欄位控件和依附控件設定########################
         #因為程式邏輯是先產生串查Button才產生欄位控件,所以需要在這裡才能做依附控件資訊的記錄
         IF NOT cl_null(p_spage.sfield[l_level3].dzep020) THEN
            #記錄串查欄位所依附欄位的控件名稱
            LET p_spage.sfield[l_level3].dzal005 = base.StringBuffer.create()
            LET l_str = l_new_child.getAttribute("name")
            CALL p_spage.sfield[l_level3].dzal005.append(l_str)

            #記錄串查欄位控件名稱
            LET p_spage.sfield[l_level3].dzal002 = base.StringBuffer.create()
            CALL p_spage.sfield[l_level3].dzal002.append(l_ref_name)
         END IF
         ############################################################
      
         ############處理reference欄位################################
         #當此欄位有參考欄位時,需要補reference欄位在後面
         IF NOT cl_null(p_spage.sfield[l_level3].refField) THEN
            INITIALIZE l_node_r TO NULL
            
            #記錄參考欄位所依附欄位的控件名稱
            LET p_spage.sfield[l_level3].dzai005 = base.StringBuffer.create()
            LET l_str = l_new_child.getAttribute("name")
            CALL p_spage.sfield[l_level3].dzai005.append(l_str)
         
            #TABLE_COLUMN reference欄位命名,只需欄位名稱加上'_desc', exp:dzea_t.dzea001=> dzea001_desc
            IF l_field_type = g_table_column THEN
               LET l_ref_name = p_spage.sfield[l_level3].colName CLIPPED
            ELSE
               #exp:gztb002_2=> gztb002_2_desc; b_gztb002=> b_gztb002_desc
               LET l_ref_name = l_new_child.getAttribute("name") CLIPPED
            END IF
         
            #因為節點不需要採插入方式,因此變數傳入NULL
            CALL sadzp168_add_reference(p_master_node, NULL, p_sr_node, NULL, l_ref_name.trim(), "", l_posX, l_posY)
               RETURNING l_grid_width, l_grid_height, l_node_r

            LET p_spage.sfield[l_level3].dzai002 = base.StringBuffer.create()
            LET l_ref_name = l_node_r.getAttribute("name") CLIPPED
            CALL p_spage.sfield[l_level3].dzai002.append(l_ref_name)
         
            LET l_posX = l_posX + l_grid_width + 1   #下一個欄位點的X軸位置

            #比較一下同一列的每個widget高度最大己用posY值
            IF l_posY_max < l_grid_height THEN
               LET l_posY_max = l_grid_height
            END IF
         END IF
         ###########################################################

         ############處理多語言欄位控件################################
         #當此欄位有多語言欄位時,需要補資料多語言欄位在widget下面
         #Q, P類版型不需產生多語言欄位
         IF (NOT cl_null(p_spage.sfield[l_level3].langField)) AND (NOT (g_dzfq_m.cbo_progtype = "Q" OR g_dzfq_m.cbo_progtype = "P")) THEN
            INITIALIZE l_node_r TO NULL
            
            #記錄多語言欄位所依附欄位的控件名稱
            LET p_spage.sfield[l_level3].dzaj005 = base.StringBuffer.create()
            LET l_str = l_new_child.getAttribute("name")
            CALL p_spage.sfield[l_level3].dzaj005.append(l_str)

            #資料多語言欄位widget在依附欄位的下面一排(posY 要向下移動)
            LET l_posY = l_posY + l_posY_max

            LET l_posX = l_new_child.getAttribute("posX")
         
            #因為節點不需要採插入方式,因此變數傳入NULL
            CALL sadzp168_add_lang(p_master_node, NULL, p_sr_node, NULL, p_spage.sfield[l_level3].dzer005, p_spage.sfield[l_level3].langField, l_posX, l_posY)
               RETURNING l_grid_width, l_grid_height, l_node_r

            LET p_spage.sfield[l_level3].dzaj002 = base.StringBuffer.create()
            LET l_ref_name = l_node_r.getAttribute("name") CLIPPED
            CALL p_spage.sfield[l_level3].dzaj002.append(l_ref_name)
     
            LET l_posX = l_posX + l_grid_width + 1   #下一個欄位點的X軸位置

            #比較一下此grid寬度最大己用posX值
            IF l_posX_max < l_posX THEN
               LET l_posX_max = l_posX
            END IF
 
            #因為資料多語言wdiget控件為自己新的獨立一列,因此記錄資料多語言widget高度為posY 此列最大值
            LET l_posY_max = l_grid_height
         END IF
         #LET l_cnt = 0
      
         #SELECT COUNT(*) INTO l_cnt FROM dzer_t
         #  WHERE dzer001 = p_spage.sfield[l_level3].sqlTabName 
         #    AND dzer002 = p_spage.sfield[l_level3].colName

         ##取得多語言關聯設定
         #IF l_cnt > 0 THEN
         #   OPEN dzer_cs USING p_spage.sfield[l_level3].sqlTabName, p_spage.sfield[l_level3].colName
         #   IF SQLCA.sqlcode THEN
         #      CALL cl_err("OPEN master dzer_cs:", STATUS, 1)
         #      CLOSE dzer_cs
         #      RETURN
         #   END IF

         #   FOREACH dzer_cs INTO l_dzer.*
         #      IF SQLCA.sqlcode THEN
         #         CALL cl_err("FOREACH master dzer_cs:", SQLCA.sqlcode, 1)
         #         EXIT FOREACH
         #      END IF

         #   END FOREACH
         #END IF
         ###########################################################
      
         #比較一下此grid寬度最大己用posX值
         IF l_posX_max < l_posX THEN
            LET l_posX_max = l_posX
         END IF

         #同一排下一組控件的posX, posY啟始位置
         LET l_posX = l_posX_start 
         LET l_posY = l_posY + l_posY_max

         #計算父節點container目前已用到的最高高度
         IF l_container_height < l_posY THEN
            LET l_container_height = l_posY
         END IF

         #todo:l_posY_max:這裡應該要初始化,否則應該會影響下一排最大高度的控制
         LET l_posY_max = 0
      END IF

      #在一排欄位換行時或新增欄位結束時,處理高度和寬度的設定
      ###IF ((l_level3 MOD g_dzfq_m.dzfq008) = 0) OR (l_level3 = p_spage.sfield.getLength()) THEN
      IF ((l_level3 MOD l_dzfq008) = 0) OR (l_level3 = p_spage.sfield.getLength()) THEN
         #grid的預設高度 < grid目前已用高度,則resize為使用的高度
         IF p_master_node.getAttribute("gridHeight") < l_container_height THEN
            CALL p_master_node.setAttribute("gridHeight", l_container_height)
         END IF
      
         #先將目前grid resize為使用的寬度
         IF p_master_node.getAttribute("gridWidth") < l_posX_max THEN
            CALL p_master_node.setAttribute("gridWidth", l_posX_max)
         END IF

         #i07假雙檔的單頭直接在Group container內換行即可
         IF p_master_node.getTagName() <> "Group" THEN
            #計算父節點container目前已用到多少寬度
            LET l_container_width = l_container_width + l_posX_max
               
            #欄位已處理數量小於新增總數量時,才需要新增新的grid
            IF l_level3 < p_spage.sfield.getLength() THEN
               #元件換行時需新增一grid,且接回新grid的節點
               #以利在這個grid節點中,再進行欄位的新增
               CALL sadzp168_add_grid(p_master_node, "") RETURNING p_master_node

               ##計算父節點container目前已用到多少寬度
               #LET l_container_width = l_container_width + l_posX_max
            END IF
            
            LET l_posX = l_posX_start 
            LET l_posY = l_posY_start
         ELSE
            #同一個grid container內的換行,下一排直接引用上一排所用的最大posX值,為下一排的posX啟始值
            #再加1:這樣看起來才有排序的感覺
            LET l_posX = l_posX_max + 1
            #下一排posY預設值為l_posY_start每一排的預設起點
            LET l_posY = l_posY_start

            #計算父節點container目前已用到多少寬度
            LET l_container_width = l_posX_max
         END IF
      END IF
   END FOR

   IF cl_null(l_container_width) OR l_container_width = 0 THEN
      LET l_container_width = p_master_node.getAttribute("gridWidth")
   END IF

   IF cl_null(l_container_height) OR l_container_height = 0 THEN
      LET l_container_height = p_master_node.getAttribute("gridHeight")
   END IF
   
   #載入stus切片檔案
   #單頭鎖定的stus切片檔案,因為不和單頭鎖定的Grid同一層,因此放到整個Form resize後再做
   IF l_stus_field.dzeb022 = "cdfStatus" AND p_stype <> "vb_headerlock" THEN      
      CALL sadzp168_get_master_status_snippet(p_master_node, l_stus_field.*)
         RETURNING l_flag, l_grid_width

      #stus切片為一整個grid,所以計算父節點container目前已用到多少寬度
      IF l_flag THEN
         LET l_container_width = l_container_width + l_grid_width
      END IF
   END IF
      
   #Group widget的高度和寬度必需比已用掉的還要大=>高度+2; 寬度+1
   IF p_master_node.getTagName() = "Group" THEN
      LET l_container_height = l_container_height + 2
      LET l_container_width = l_container_width + 1
      CALL p_master_node.setAttribute("gridHeight", l_container_height)
      CALL p_master_node.setAttribute("gridWidth", l_container_width)
   END IF
   
   #調整由內而外所有的container size
   CALL sadzp168_container_resize(p_master_node, l_container_width, l_container_height)

   
   #載入單頭鎖定的stus切片檔案
   IF l_stus_field.dzeb022 = "cdfStatus" AND p_stype = "vb_headerlock" THEN
      #取得單頭鎖定的[headerlock_group]節點,準備用來載入單頭鎖定的stus切片
      #因為FUNCTION get_master_status_snippet(), 是用和載入stus切片的同層節點當參數,因此取得單頭鎖定的[headerlock_group]節點
      LET l_header_lock = sadzp168_2_get_domNode(g_template_node, "Group", "name", "headerlock_group")

      IF l_header_lock IS NULL THEN
         #樣版單頭結構點不存在
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  "adz-00072"
         LET g_errparam.extend = NULL
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] =  "headerlock_group"
         CALL cl_err()
         RETURN
      END IF

      #載入stus切片檔案
      CALL sadzp168_get_master_status_snippet(l_header_lock, l_stus_field.*)
         RETURNING l_flag, l_grid_width
      
      #stus切片為一整個grid,所以計算父節點container目前已用到多少寬度
      IF l_flag THEN
         LET l_container_width = l_header_lock.getAttribute("posX") + l_header_lock.getAttribute("gridWidth") 
         LET l_container_width = l_container_width + l_grid_width
      ELSE
         RETURN
      END IF

      CALL sadzp168_container_resize(p_master_node, l_container_width, l_container_height)
   END IF

   
   ##############################
   IF p_master_node.getChildCount() = 0 THEN
      CALL g_template_node.removeChild(p_master_node)
   END IF
   ##############################
END FUNCTION

#+ 取得單頭所屬的sr domNode
PRIVATE FUNCTION sadzp168_get_master_sr_domNode()
   DEFINE l_sr_node      om.DomNode            #原公版的sr node
   DEFINE l_tag          LIKE dzfh_t.dzfh004   #要尋找節點的tag名稱
   DEFINE l_name         LIKE dzfh_t.dzfh005   #要尋找tag的name名稱

   #srName="Undefined" srTag="Record"
   #取得4fd樣版 sr的xml tag名稱
   LET l_tag = "Record"
   #取得4fd樣版 sr的xml name名稱
   LET l_name = "Undefined"
         
   #因為在4fd上單頭內所有欄位會搭配Screen Records出現
   #所以這裡順便找樣版內sr node的節點位置
   LET l_sr_node = sadzp168_2_get_domNode(g_template_node, l_tag, "name", l_name)

   RETURN l_sr_node
         
END FUNCTION

#+ 在新增欄位時,widget前面需增加Static Label(敘述)
PRIVATE FUNCTION sadzp168_add_static_label(p_node, p_field, p_field_type, p_posX, p_posY, p_grid_width)
   DEFINE p_node         om.DomNode            #需要新增欄位節點的domNode
   DEFINE p_field        type_g_field          #欄位資訊
   DEFINE p_field_type   LIKE type_t.chr1      #新欄位的fieldType
   DEFINE p_posX         LIKE type_t.num10     #Label元件X軸位置
   DEFINE p_posY         LIKE type_t.num10     #Label元件Y軸位置
   DEFINE p_grid_width   LIKE type_t.num10
   
   DEFINE l_new_child    om.DomNode            #新增欄位的子節點
   DEFINE l_grid_height  LIKE type_t.num10
   DEFINE l_dzek002      LIKE dzek_t.dzek002

   INITIALIZE l_new_child TO NULL
   
   LET l_dzek002 = ""
   
   #Static Label(敘述):預設高為1,寬為10(除了ScrollGrid外,預設寬為10)
   LET l_grid_height = 1 
   IF cl_null(p_grid_width) OR p_grid_width = 0 THEN
      LET p_grid_width = 10
   END IF

   #如果widge是CheckBox, 則不在前面新增Label
   IF p_field.dzej003 CLIPPED = "CheckBox" AND p_node.getTagName() <> "ScrollGrid" THEN
      RETURN p_grid_width, l_grid_height, l_new_child
   END IF

   #在單頭裡新增欄位,需在這個欄位前方增加一個Label(敘述)控件,
   #目的為這個欄位的用途說明敘述
   LET l_new_child = p_node.createChild("Label")
   CALL l_new_child.setAttribute("gridHeight", l_grid_height)  
   CALL l_new_child.setAttribute("gridWidth", p_grid_width)

   IF p_field_type = g_table_column THEN
      CALL l_new_child.setAttribute("name", "lbl_" || p_field.colName CLIPPED)
   ELSE
      CALL l_new_child.setAttribute("name", "lbl_b_" || p_field.colName CLIPPED)
   END IF
   
   CALL l_new_child.setAttribute("posX", p_posX)

   CALL l_new_child.setAttribute("posY", p_posY)
   CALL l_new_child.setAttribute("text", "lbl_" || p_field.colName CLIPPED)
   CALL l_new_child.setAttribute("lstrcomment", "true")
   CALL l_new_child.setAttribute("lstrtext", "true")

   IF p_node.getTagName() = "ScrollGrid" THEN
      CALL l_new_child.setAttribute("style", "scrollgridtype")
   END IF
   
   #公用欄位的lable text屬性可以統一名稱
   IF NOT cl_null(p_field.dzek001) THEN
      SELECT dzek002 INTO l_dzek002 FROM dzek_t WHERE dzek001 = p_field.dzeb022

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  STATUS
         LET g_errparam.extend = "SELECT dzek_t:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
      ELSE
         IF NOT cl_null(l_dzek002) THEN
            CALL l_new_child.setAttribute("text", "lbl_" || l_dzek002 CLIPPED)
         END IF
      END IF
   END IF
   
   RETURN p_grid_width, l_grid_height, l_new_child
END FUNCTION

#+ 在新增單頭欄位時,widget前面增加串查功能(Button)
PRIVATE FUNCTION sadzp168_master_add_qrystr(p_master_node, p_field_name, p_posX, p_posY)
   DEFINE p_master_node  om.DomNode            #需要新增欄位節點的domNode
   DEFINE p_field_name   STRING                #欄位名稱
   DEFINE p_posX         LIKE type_t.num10     #Label元件X軸位置
   DEFINE p_posY         LIKE type_t.num10     #Label元件Y軸位置
   
   DEFINE l_new_child    om.DomNode            #新增欄位的子節點
   DEFINE l_grid_height  LIKE type_t.num10
   DEFINE l_grid_width   LIKE type_t.num10
   DEFINE l_name         STRING
   
   #Static Label(敘述):預設高為1,寬為10
   LET l_grid_height = 1 
   LET l_grid_width = 10

   #依130515串查功能討論要求,暫時先將命名規則改成"prog_"開頭
   #LET l_name =  "lbl_", p_field_name.trim()
   LET l_name =  "prog_", p_field_name.trim()
   
   #在單頭裡新增欄位,增加串查功能(Button)控件,
   LET l_new_child = p_master_node.createChild("Button")
   CALL l_new_child.setAttribute("gridHeight", l_grid_height)  
   CALL l_new_child.setAttribute("gridWidth", l_grid_width)

   CALL l_new_child.setAttribute("name", l_name.trim())
   CALL l_new_child.setAttribute("posX", p_posX)

   CALL l_new_child.setAttribute("posY", p_posY)
   CALL l_new_child.setAttribute("text", "lbl_" || p_field_name.trim())
   CALL l_new_child.setAttribute("style", "button_qrystr")
   CALL l_new_child.setAttribute("comment", "cmt_lbl_" || p_field_name.trim())
   
   #tabIndex值依續加1
   CALL sadzp168_2_field_add_index(l_new_child, "tabIndex", g_fieldId_max, g_tabIndex_max)
      RETURNING g_fieldId_max, g_tabIndex_max
         
   RETURN l_grid_width, l_grid_height, l_name
END FUNCTION

#+ 在單頭 domNode中增加grid
PRIVATE FUNCTION sadzp168_add_grid(p_node, p_type)
   DEFINE p_node         om.DomNode            #目前在單頭運作新增欄位的的page domNode
   DEFINE p_type         STRING                #
   
   DEFINE l_posX         LIKE type_t.num10     #新grid的X軸位置
   DEFINE l_posY         LIKE type_t.num10     #新grid的Y軸位置
   DEFINE l_parent_node  om.DomNode            #grid的上層父節點
   DEFINE l_child        om.DomNode            #各grid節點
   DEFINE l_new_grid     om.DomNode            #要新增的grid節點
   DEFINE l_grid_count   LIKE type_t.num5      #HBox下有多少grid
   DEFINE l_num          LIKE type_t.num5      #目前在HBox下第幾個grid
   DEFINE l_index        LIKE type_t.num5      #原本grid在HBox下的index位置
   DEFINE l_name         STRING                #grid的名稱
   DEFINE l_idx          LIKE type_t.num5
   
   INITIALIZE l_parent_node TO NULL
   
   LET l_num = 0
   LET l_index = 0
   
   #定義新的Grid名稱,因為在4fd中每一個元件的都是唯一
   IF (NOT cl_null(p_type)) AND p_type = g_common THEN
      #公用欄位的grid在切片載入時會重新命名,exp:name="grid_belong_gen2"
      LET l_name = p_node.getAttribute("name")
      LET l_idx = l_name.getIndexOf("_gen", 1)
      IF l_idx > 0 THEN
         LET l_name = l_name.subString(1, l_idx + 3), g_num USING "<<<<<"  
      ELSE
         LET l_name = p_node.getAttribute("name"), "_gen", g_num USING "<<<<<"
      END IF
   ELSE
      LET l_name = "Grid_gen", g_num USING "<<<<<"
   END IF
   
   #找到父節點
   LET l_parent_node = p_node.getParent()

   CASE l_parent_node.getTagName()
      WHEN "HBox"
         LET l_posX = p_node.getAttribute("posX") + p_node.getAttribute("gridWidth") 
         LET l_posY = p_node.getAttribute("posY") 

      WHEN "VBox"
         LET l_posX = p_node.getAttribute("posX") 
         LET l_posY = p_node.getAttribute("posY") + p_node.getAttribute("gridHeight")
         
   END CASE

   #統計父節點下共有幾個grid
   LET l_grid_count = l_parent_node.getChildCount()

   #在這個父節點下,找所有grid的節點
   LET l_child = l_parent_node.getFirstChild()
   WHILE l_child IS NOT NULL
      #DISPLAY "   l_grid_child.tag:", l_child.getTagName(), ASCII 10
      #DISPLAY "   l_grid_child.name:", l_child.getAttribute("name")

      LET l_num = l_num + 1

      #已找到原本節點,原本後面的grid節點需變更posX位置,避免和新grid位置重疊
      IF l_index <> 0 AND l_num > l_index THEN
         CASE l_parent_node.getTagName()
            WHEN "HBox"
               CALL l_child.setAttribute("posX", l_posX)
         
               #統計下一個grid應該設置的posX位置
               LET l_posX = l_posX + l_child.getAttribute("gridWidth")

            WHEN "VBox"
               CALL l_child.setAttribute("posY", l_posY)
         
               #統計下一個grid應該設置的posY位置
               LET l_posY = l_posY + l_child.getAttribute("gridHeight")
         END CASE
      END IF

      #如果小於目前grid的寬/高度相比,把其它grid都設置和目前grid的寬/高度相同
      IF l_child.getAttribute("gridWidth") < p_node.getAttribute("gridWidth") THEN
         CALL l_child.setAttribute("gridWidth", p_node.getAttribute("gridWidth"))
      END IF
      
      IF l_child.getAttribute("gridHeight") < p_node.getAttribute("gridHeight") THEN
         CALL l_child.setAttribute("gridHeight", p_node.getAttribute("gridHeight"))
      END IF
      
      #找到目前正在使用的grid節點時,就需在下一個gird節點前,新增一個grid
      IF l_child.getTagName() = p_node.getTagName() AND l_child.getAttribute("name") = p_node.getAttribute("name") THEN
         LET l_index = l_num
         
         #新增一個grid節點
         LET l_new_grid = l_parent_node.createChild("Grid")
         CALL l_new_grid.setAttribute("name", l_name.trim())
         CALL l_new_grid.setAttribute("posX", l_posX)
         CALL l_new_grid.setAttribute("posY", l_posY)
         
         #高度和寬度都預設為和前一個grid同
         CALL l_new_grid.setAttribute("gridHeight", p_node.getAttribute("gridHeight"))
         CALL l_new_grid.setAttribute("gridWidth", p_node.getAttribute("gridWidth"))
         CALL l_new_grid.setAttribute("style", "")

         ##統計下一個grid應該設置的posX位置
         #LET l_posX = l_posX + l_new_grid.getAttribute("gridWidth")

         #新增下一個grid時名稱的序號
         LET g_num = g_num + 1
         
         #如果這個grid不為最後一個節點,則找到下一個grid節點
         #這樣才可以新增一個grid插入在這個節點之前
         LET l_child = l_child.getNext()
         IF l_num < l_grid_count THEN
            #新grid節點插入在剛找到的下一個節點之前
            CALL l_parent_node.insertBefore(l_new_grid, l_child)
         END IF
         EXIT WHILE
      ELSE
         LET l_child = l_child.getNext()
      END IF
   END WHILE

   RETURN l_new_grid
END FUNCTION

##+ 處理共用欄位節點(包含status欄位)
#PRIVATE FUNCTION sadzp168_set_common_info(p_node, p_table_name)
#   DEFINE p_node         om.DomNode
#   DEFINE p_table_name   LIKE dzea_t.dzea001   #資料表名稱 
#   
#   DEFINE l_tmpStr       STRING
#   DEFINE l_name         LIKE dzej_t.dzej005   #要尋找tag的name名稱
#   DEFINE l_dzeb002      LIKE dzeb_t.dzeb002   #此資料表的共用欄位欄位名稱
#   DEFINE l_field_type   STRING                #共用欄位的fieldType
#   DEFINE l_widget_name  STRING                #共用欄位的widget name
#   DEFINE l_sr_node      om.DomNode            #共用欄位的sr node父節點
#   DEFINE l_sr_child     om.DomNode            #共用欄位的sr node
#   DEFINE l_table_name   LIKE dzea_t.dzea001   #資料表名稱 
#   DEFINE l_parent       om.DomNode            #父節點
#   DEFINE l_str          STRING
#   DEFINE l_idx          LIKE type_t.num5 
#   DEFINE l_dzfs003      LIKE dzfs_t.dzfs003   #Screen Record名稱
#   DEFINE l_grid_info    om.DomNode            #單頭的共用欄位父節點container node
#   
#   INITIALIZE l_sr_node TO NULL
#   INITIALIZE l_sr_child TO NULL
#   INITIALIZE l_grid_info TO NULL
#   
#   LET l_name = ""
#   LET l_table_name = ""
#   LET l_str = ""
#   LET l_idx = 0
#   LET l_dzfs003 = ""
#   
#   #取得此節點"fieldId"的屬性值
#   LET l_tmpStr = p_node.getAttribute("tag")
#
#   #共用欄位tag屬性值會設為[cdfCommon]; 狀態欄欄位屬性值會設為[cdfStatus]
#   IF l_tmpStr = "cdfCommon" OR l_tmpStr = "cdfStatus" THEN
#      ##########取得資料表名稱##########
#      #取得父節點
#      LET l_parent = p_node.getParent() 
#     
#      #父節點如果為[Table]表示為單身,則資料表應該要取單身所屬的資料表代碼
#      IF l_parent IS NOT NULL THEN
#         IF l_parent.getTagName() = "Table" OR l_parent.getTagName() = "Tree" THEN
#            #例如:取得單身資料表的公用欄位頁籤table(container)名稱:s_detail1_info
#            LET l_str = l_parent.getAttribute("name")
#
#            #取得單身主要頁籤的 SR 名稱
#            LET l_idx = l_str.getIndexOf("_info", 1)
#            IF l_idx > 0 THEN
#               LET l_str = l_str.subString(1, l_idx - 1)
#            END IF
#
#            #取得資料表代碼
#            IF NOT cl_null(l_str) THEN
#               LET l_dzfs003 = l_str
#               SELECT dzfs004 INTO l_table_name FROM dzfs_t
#                 WHERE dzfs001 = g_dzfq_m.dzfq003
#                   AND dzfs002 = g_dzfq_m.dzfq004
#                   AND dzfs003 = l_dzfs003
#            END IF
#
#            #處理單身共用欄位頁籤中需要加入PK欄位(PK欄位加在 modu 欄位前)
#            IF p_node.getAttribute("name") = "modu" AND (NOT g_dzfq_m.dzfq009 = "sarray") THEN
#               CALL sadzp168_get_detail_pk(l_parent, p_node, l_table_name, l_dzfs003)
#            END IF
#
#            #取得此公用欄位的SR 父節點
#            LET l_sr_node = sadzp168_2_get_domNode(g_template_node, "Record", "name", l_parent.getAttribute("name"))
#         ELSE
#            #取得公用欄位的父節點container
#            IF p_node.getAttribute("name") = "modu" THEN
#               LET l_grid_info = p_node.getParent()
#
#               ##處理公用欄位折行
#               ##CALL sadzp168_set_common_structure(l_grid_info)
#               
#               IF g_master_grid_info.getLength() = 0 THEN
#                  LET g_master_grid_info[1] = l_grid_info
#               ELSE
#                  LET g_master_grid_info[g_master_grid_info.getLength() + 1] = l_grid_info
#               END IF
#            END IF
#            
#            LET l_table_name = p_table_name
#
#            #取得此公用欄位的SR 父節點
#            LET l_sr_node = sadzp168_2_get_domNode(g_template_node, "Record", "name", "Undefined")
#         END IF
#      END IF
#
#      #取得節點的 name名稱
#      LET l_str = p_node.getAttribute("name")
#
#      #取得參考欄位所對應的欄位名稱(如:modu_desc是modu的參考欄位)
#      LET l_idx = l_str.getIndexOf("_desc", 1)
#            
#      IF l_idx > 0 THEN
#         LET l_str = l_str.subString(1, l_idx - 1)
#      END IF
#
#      LET l_name = l_str.trim()
#            
#      #取得共用欄位位名稱
#      SELECT dzeb002 INTO l_dzeb002 FROM dzeb_t 
#        WHERE dzeb001 = l_table_name
#          AND dzeb002 LIKE '%' || l_name
#
#      IF NOT cl_null(l_dzeb002) THEN
#         LET l_str = p_node.getAttribute("name")
#         
#         #公用欄位之參考欄位屬性處理
#         IF l_str.getIndexOf("_desc", 1) > 0 THEN
#            LET l_widget_name = l_dzeb002 CLIPPED, "_desc"
#            
#            ############處理Screen Records##############################
#            LET l_sr_child = sadzp168_2_get_domNode(l_sr_node, "RecordField", "name", p_node.getAttribute("name"))
#
#            CALL l_sr_child.setAttribute("name", l_widget_name.trim())
#            ###########################################################
#
#            CALL p_node.setAttribute("name", l_widget_name.trim())
#         ELSE
#            LET l_field_type = "TABLE_COLUMN"
#            LET l_widget_name = l_table_name CLIPPED, ".", l_dzeb002 CLIPPED
#   
#            CALL p_node.setAttribute("colName", l_dzeb002 CLIPPED)
#            CALL p_node.setAttribute("fieldType", l_field_type.trim()) 
#            CALL p_node.setAttribute("name", l_widget_name.trim())
#            CALL p_node.setAttribute("sqlTabName", l_table_name CLIPPED)
#
#            ############處理Screen Records##############################
#            #LET l_sr_child = sadzp168_2_get_domNode(g_template_node, "RecordField", "name", l_name)
#            LET l_sr_child = sadzp168_2_get_domNode(l_sr_node, "RecordField", "name", l_name)
#            CALL l_sr_child.setAttribute("colName", l_dzeb002 CLIPPED)
#            CALL l_sr_child.setAttribute("fieldType", l_field_type.trim())      
#
#            CALL l_sr_child.setAttribute("name", l_widget_name.trim())
#            CALL l_sr_child.setAttribute("sqlTabName", l_table_name CLIPPED)
#            ###########################################################
#         END IF
#      ELSE
#         #當樣版有共用欄位,卻在資料表設計器(dzeb_t)找不到欄位定義時,處理方式?
#         DISPLAY "tag name:", l_name, " is not exist in dzeb_t"
#      END IF
#
#      #處理status欄位需依狀態碼分類來轉換成ComboBox
#      IF l_tmpStr = "cdfStatus" THEN
#         IF NOT sadzp168_set_status_widget(l_parent, p_node, l_table_name) THEN
#            DISPLAY "set status widget is failed."
#         END IF
#      END IF
#   END IF
#   
#   ##控制權移到其第一個子節點
#   #LET p_node = p_node.getFirstChild()
#   #控制權移到其最後一個子節點
#   LET p_node = p_node.getLastChild()
#
#   #若節點為空則不再進行遞迴
#   WHILE p_node IS NOT NULL   
#      CALL sadzp168_set_common_info(p_node, p_table_name)
#      
#      ##控制權移到下一個同層的節點
#      #LET p_node = p_node.getNext()
#      #控制權移到上一個同層的節點
#      LET p_node = p_node.getPrevious()
#
#   END WHILE
#END FUNCTION

#+ 處理單頭公用欄位折行
PRIVATE FUNCTION sadzp168_set_common_structure(p_grid_info)
   DEFINE p_grid_info         om.DomNode            #單頭的共用欄位父節點container node

   DEFINE l_grid_info_t       om.DomNode            #單頭的共用欄位父節點container node備份
   DEFINE l_parent            om.DomNode
   DEFINE l_new_hbox          om.DomNode
   DEFINE l_new_grid          om.DomNode
   DEFINE l_common_node       om.DomNode
   DEFINE l_posX              LIKE type_t.num10
   DEFINE l_posY              LIKE type_t.num10
   DEFINE l_posY_t            LIKE type_t.num10     #上一個控件posY值,判斷是否為同一組共用欄位
   DEFINE l_name              STRING
   DEFINE l_child_node        om.DomNode            #公用欄位節點 
   DEFINE l_previous_node     om.DomNode
   DEFINE l_hbox_height       LIKE type_t.num10     #HBox已用高度
   DEFINE l_hbox_width        LIKE type_t.num10     #HBox已用寬度
   DEFINE l_n                 LIKE type_t.num10
   DEFINE l_i                 LIKE type_t.num10

   INITIALIZE l_new_grid TO NULL
   INITIALIZE l_common_node TO NULL
   
   IF p_grid_info IS NULL OR g_dzfq_m.dzfq008 >= 7 THEN
      RETURN
   END IF

   LET l_n = 1
   LET l_posY_t = 0
   LET l_hbox_height = 0
   LET l_hbox_width = 0
   LET l_grid_info_t = p_grid_info 

   #再往上層取得container的父節點,準備新增HBox節點
   LET l_parent = p_grid_info.getParent()

   ############新增一個HBox結構##################################################
   LET l_new_hbox = l_parent.createChild("HBox")

   #定義新的HBox名稱,因為在4fd中每一個元件的都是唯一
   LET l_name = l_new_hbox.getTagName(), "_gen", g_num USING "<<<<<"  
   LET g_num = g_num + 1

   CALL l_new_hbox.setAttribute("name", l_name)
   CALL l_new_hbox.setAttribute("posX", "0")
   CALL l_new_hbox.setAttribute("posY", "0")
   CALL l_new_hbox.setAttribute("splitter", "false")

   ############把原先的Grid_info結構(放公用欄位的Grid)append在這個HBox下#############
   CALL l_new_hbox.appendChild(p_grid_info)

   #因為Grid_info已經移到HBox結構中,posX值需從2開始
   LET l_posX = p_grid_info.getAttribute("posX") + 2
   CALL p_grid_info.setAttribute("posX", l_posX)
   
   #取得原公用欄位Grid已佔用的寬度和高度
   LET l_hbox_width = p_grid_info.getAttribute("posX") + p_grid_info.getAttribute("gridWidth")
   LET l_hbox_height = p_grid_info.getAttribute("posY") + p_grid_info.getAttribute("gridHeight")

   #下一個Grid的posX起始位置
   LET l_posX = l_hbox_width


  ############處理公用欄位折行####################################################
   LET l_child_node = l_grid_info_t.getFirstChild()
   WHILE l_child_node IS NOT NULL
      LET l_posY =  l_child_node.getAttribute("posY")

      #當公用欄位不為同一組時
      IF l_posY_t <> l_posY THEN
         LET l_n = l_n + 1
         LET l_posY_t = l_posY

         #取得畫面設定換行數量
         #MOD結果 = 1時:表示為新的折行開始
         IF l_n MOD g_dzfq_m.dzfq008 = 1 THEN
            ############新增另一個Grid結構(放折行的公用欄位)#############
            LET l_new_grid = l_new_hbox.createChild("Grid")
            LET l_n = 1
   
            #定義新的HBox名稱,因為在4fd中每一個元件的都是唯一
            LET l_name = l_new_grid.getTagName(), "_gen", g_num USING "<<<<<"  
            LET g_num = g_num + 1

            CALL l_new_grid.setAttribute("name", l_name)   
            CALL l_new_grid.setAttribute("posX", l_posX)
            CALL l_new_grid.setAttribute("posY", p_grid_info.getAttribute("posY"))
            CALL l_new_grid.setAttribute("gridHeight", p_grid_info.getAttribute("gridHeight"))  
            CALL l_new_grid.setAttribute("gridWidth", p_grid_info.getAttribute("gridWidth"))

            #取得目前所有Gird已用掉的總寬度
            LET l_hbox_width = l_hbox_width + l_new_grid.getAttribute("gridWidth")

            LET l_posX = l_posX + p_grid_info.getAttribute("gridWidth")
         END IF
      END IF

      #將公用欄位節點插入新Grid中
      IF l_new_grid IS NOT NULL THEN
         LET l_common_node = l_new_grid.createChild(l_child_node.getTagName())

         #抄寫控件的屬性
         FOR l_i = 1 TO l_child_node.getAttributesCount()
             CALL l_common_node.setAttribute(l_child_node.getAttributeName(l_i), l_child_node.getAttributeValue(l_i))
         END FOR
      
         #變更公用欄位節點位置
         CALL l_common_node.setAttribute("posY", l_n - 1)

         LET l_previous_node = l_child_node
         LET l_child_node = l_child_node.getNext()
         
         #移除原有的公用欄位節點
         CALL p_grid_info.removeChild(l_previous_node)       
      ELSE
         LET l_child_node = l_child_node.getNext()
      END IF
   END WHILE

   LET l_hbox_width = l_hbox_width + 4

   CALL l_new_hbox.setAttribute("gridWidth", l_hbox_width)
   CALL l_new_hbox.setAttribute("gridHeight", l_hbox_height)  

   CALL sadzp168_container_resize(l_new_hbox, l_hbox_width, l_hbox_height)
      
END FUNCTION

#+ 取得欄位設計資料是否已存在4fd(變更widget name)--目前設計只有單身PK欄位有可能會重覆
PRIVATE FUNCTION sadzp168_get_column_exist(p_dzfr010)
   DEFINE p_dzfr010                    LIKE dzfr_t.dzfr010
   DEFINE l_i                          LIKE type_t.num5
   DEFINE l_j                          LIKE type_t.num5 
   DEFINE r_exist                      LIKE type_t.chr1

   LET r_exist = FALSE
   
   #判斷widget欄位是否已存在單身頁籤,存在時需變更PK欄位的命名原則,以免4fd widget命名重覆
   FOR l_i = 1 TO g_detail_pk.getLength()
      #逐一判斷欄位是否已存在
      FOR l_j = 1 TO g_detail_pk[l_i].pk_field.getLength()
         IF g_detail_pk[l_i].pk_field[l_j].colName = p_dzfr010 THEN
            LET r_exist = TRUE
            RETURN r_exist
         END IF
      END FOR
   END FOR

   RETURN r_exist
END FUNCTION
           
#+ 取得單身資料表PK欄位(不包含FK欄位)
PRIVATE FUNCTION sadzp168_get_detail_pk(p_node, p_node_before, p_dzea001, p_table_container_name)
   DEFINE p_node                       om.DomNode            #單身table[container]父節點
   DEFINE p_node_before                om.DomNode            #準備新增在那個節點之前(通常是mudu節點)
   DEFINE p_dzea001                    LIKE dzea_t.dzea001   #資料表名稱 
   DEFINE p_table_container_name       STRING                #單身頁籤中table container name 屬性值

   DEFINE l_node_ref                   om.DomNode            #PK欄位參考點
   DEFINE l_new_node                   om.DomNode
   DEFINE l_dzed004                    LIKE dzed_t.dzed004
   DEFINE l_dzed004_str                STRING
   DEFINE l_dzeb002                    LIKE dzeb_t.dzeb002
   #DEFINE l_dzeb002_str                STRING
   DEFINE l_i                          LIKE type_t.num5
   DEFINE l_j                          LIKE type_t.num5
   DEFINE l_k                          LIKE type_t.num5
   DEFINE l_name                       STRING
   DEFINE l_posX                       LIKE type_t.num10
   DEFINE l_child_node                 om.DomNode
   DEFINE l_flag                       LIKE type_t.chr1
   DEFINE l_sr_node                    om.DomNode
   DEFINE l_sr_child                   om.DomNode
   DEFINE l_sr_before                  om.DomNode
   DEFINE l_grid_height                LIKE type_t.num10
   DEFINE l_table_width                LIKE type_t.num10     #table用到的總width
   DEFINE l_child_count                LIKE type_t.num10
   DEFINE l_dzfs003                    LIKE dzfs_t.dzfs003
   DEFINE l_dzfs004                    LIKE dzfs_t.dzfs004
   DEFINE l_cnt                        LIKE type_t.num5
   DEFINE l_tok                        base.StringTokenizer
   DEFINE l_tmp                        STRING
   DEFINE l_detail_pk                  BOOLEAN               #資料表PK欄位(排除FK欄位)
   
   INITIALIZE l_node_ref TO NULL
   INITIALIZE l_new_node TO NULL
   INITIALIZE l_sr_node TO NULL
   INITIALIZE l_sr_child TO NULL
   INITIALIZE l_sr_before TO NULL
   
   LET l_dzed004 = ""
   LET l_name = ""
   LET l_posX = 0

   #取得插入在before節點的posX值
   IF NOT cl_null(p_node_before.getAttribute("posX")) THEN
      LET l_posX = p_node_before.getAttribute("posX")
   END IF
   
   #取得資料表所有符合PK的欄位
   FOREACH sadzp168_dzeb_pk_cur USING p_dzea001 INTO l_dzeb002
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  SQLCA.sqlcode
         LET g_errparam.extend = "sadzp168_dzeb_pk_cur FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF

      #預設:欄位為PK,且不是為FK
      LET l_detail_pk = TRUE

      #取得資料表所有符合FK的欄位(FK有可能利用','隔開 如:oobcent,oobc001,oobc002)
      FOREACH sadzp168_dzed_fk_cur USING p_dzea001, g_dzfq_m.dzfq001, p_dzea001,
                                        g_dzfq_m.dzfq003, g_dzaa006
                                  INTO l_dzed004
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  SQLCA.sqlcode
            LET g_errparam.extend = "sadzp168_dzed_fk_cur FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            EXIT FOREACH
         END IF
      
         LET l_dzed004_str = l_dzed004 CLIPPED
         LET l_tok = base.StringTokenizer.createExt(l_dzed004_str CLIPPED, ",", "", TRUE) #指定分隔符號

         WHILE l_tok.hasMoreTokens()  #依序取得子字串
            LET l_tmp = l_tok.nextToken()
            LET l_tmp = l_tmp.trim()

            #排除PK = FK
            IF l_tmp = l_dzeb002 THEN 
               LET l_detail_pk = FALSE
               EXIT WHILE
               END IF
         END WHILE
      END FOREACH

      IF NOT l_detail_pk THEN
         CONTINUE FOREACH
      END IF


      #取得相對應的table(container)名稱
      FOR l_i = 1 TO g_detail_pk.getLength()
          IF g_detail_pk[l_i].table_container_name = p_table_container_name THEN
             #取得table(container)的 SR 節點
             LET l_sr_node = sadzp168_2_get_domNode(g_template_node, "Record", "name", p_node.getAttribute("name"))

             #取得SR插入子節點
             IF p_node_before IS NOT NULL THEN
                LET l_sr_before = sadzp168_2_get_domNode(l_sr_node, "RecordField", "name", p_node_before.getAttribute("name"))
             END IF

             #新增PK欄位(排除FK欄位)
             FOR l_j = 1 TO g_detail_pk[l_i].pk_field.getLength()
                #取得相同欄位
                IF g_detail_pk[l_i].pk_field[l_j].colName <> l_dzeb002 THEN
                   CONTINUE FOR
                END IF
                
                #取得s_detailX的PK欄位為參考點,新增到s_detailX_info中
                LET l_node_ref = sadzp168_2_get_domNode(g_template_node, g_detail_pk[l_i].pk_field[l_j].widget, "name", g_detail_pk[l_i].pk_field[l_j].detailPK)

                LET l_new_node = p_node.createChild(l_node_ref.getTagName())
                
                #PK欄位採用插入方式
                IF p_node_before IS NOT NULL THEN
                   CALL p_node.insertBefore(l_new_node, p_node_before)
                END IF
                    
                #抄寫公版上Grid元件的屬性
                FOR l_k = 1 TO l_node_ref.getAttributesCount()
                    CALL l_new_node.setAttribute(l_node_ref.getAttributeName(l_k), l_node_ref.getAttributeValue(l_k))
                    
                    IF l_node_ref.getAttributeName(l_k) = "name" THEN
                       LET l_name = g_detail_pk[l_i].pk_field[l_j].colName CLIPPED, "_", p_node.getAttribute("name")
                       CALL l_new_node.setAttribute("name", l_name.trim())
                    END IF

                    #fieldId值依續加1
                    IF l_node_ref.getAttributeName(l_k) = "fieldId" THEN
                       CALL sadzp168_2_field_add_index(l_new_node, "fieldId", g_fieldId_max, g_tabIndex_max)
                          RETURNING g_fieldId_max, g_tabIndex_max
                    END IF

                    #tabIndex值依續加1
                    IF l_node_ref.getAttributeName(l_k) = "tabIndex" THEN
                       CALL sadzp168_2_field_add_index(l_new_node, "tabIndex", g_fieldId_max, g_tabIndex_max)
                          RETURNING g_fieldId_max, g_tabIndex_max
                    END IF

                    #fieldType值依續加1
                    IF l_node_ref.getAttributeName(l_k) = "fieldType" THEN
                       CALL l_new_node.setAttribute("fieldType", "COLUMN_LIKE")
                    END IF

                    #posX值依續加1
                    IF l_node_ref.getAttributeName(l_k) = "posX" THEN
                       CALL l_new_node.setAttribute("posX", l_posX)
                    END IF
                END FOR

                #下一個控件的widget posX座標值
                IF NOT cl_null(l_new_node.getAttribute("gridWidth")) THEN
                   LET l_posX = l_posX + l_new_node.getAttribute("gridWidth")
                END IF

                
                ############處理Screen Records##############################
                #新增一個sr子節點
                LET l_sr_child = l_sr_node.createChild("RecordField")
      
                #設置新sr child node的屬性
                CALL sadzp168_2_set_sr_attr(l_sr_child, l_new_node)

                #將新欄位插入在指定的sr 節點前
                IF l_sr_before IS NOT NULL THEN
                   #新增欄位子節點在新的sr node中
                   CALL l_sr_node.insertBefore(l_sr_child, l_sr_before)
                END IF 
                ###########################################################
             END FOR
          END IF
      END FOR
   END FOREACH

   #變更子節點posX座標位置
   LET l_flag = FALSE
   LET l_child_node = p_node.getFirstChild()
   WHILE l_child_node IS NOT NULL
      #posX座標的變更,從插入節點後開始
      IF l_child_node.getTagName() = p_node_before.getTagName() AND l_child_node.getAttribute("name") = p_node_before.getAttribute("name") THEN
         LET l_flag = TRUE
      END IF

      IF l_flag THEN
         #posX值依續加1
         IF NOT cl_null(l_child_node.getAttribute("posX")) THEN
            CALL l_child_node.setAttribute("posX", l_posX)

            #下一個控件的widget posX座標值
            IF NOT cl_null(l_child_node.getAttribute("gridWidth")) THEN
               LET l_posX = l_posX + l_child_node.getAttribute("gridWidth")
            END IF
         END IF
      END IF
      
      LET l_child_node = l_child_node.getNext()
   END WHILE

   #130711:公用欄位已由r.a拉欄位,不需再回寫dzfs_t
   ##將table[container]裡的公用欄位sr和table代碼的對應回寫dzfs_t(程式Table與Screen Record對應檔)
   #LET l_dzfs003 = p_node.getAttribute("name")
   #LET l_dzfs004 = p_dzea001

   #SELECT COUNT(*) INTO l_cnt FROM dzfs_t
   #  WHERE dzfs001 = g_ver_dzag003
   #    AND dzfs002 = g_dzfq_m.dzfq004
   #    AND dzfs003 = l_dzfs003

   #IF l_cnt = 0 THEN
   #   INSERT INTO dzfs_t (dzfs001, dzfs002, dzfs003, dzfs004, dzfs005, 
   #                       dzfsmodid, dzfsmoddt, dzfsownid, dzfsowndp, dzfscrtid, dzfscrtdp,
   #                       dzfscrtdt, dzfsstus)

   #    VALUES(g_ver_dzag003, g_dzfq_m.dzfq004, l_dzfs003, l_dzfs004, g_dzaa006, 
   #            g_dzfq_m.dzfqmodid, g_dzfq_m.dzfqmoddt, g_dzfq_m.dzfqownid, g_dzfq_m.dzfqowndp, g_dzfq_m.dzfqcrtid, g_dzfq_m.dzfqcrtdp, 
   #            g_dzfq_m.dzfqcrtdt, g_dzfq_m.dzfqstus)
   #            
   #   IF SQLCA.sqlcode THEN
   #      CALL cl_err('ins dzfs_t:', SQLCA.sqlcode, 0)  
   #   END IF
   #END IF
   
   #所以重新調整Table和VBox等相關容器的寬度,避免編譯失敗
   #table容器的寬度 = 已用寬度 + 欄位個數 + 1
   LET l_child_count = p_node.getChildCount()
   LET l_table_width = l_posX
   LET l_table_width = l_table_width + l_child_count + 2
   CALL p_node.setAttribute("gridWidth", l_table_width)
   LET l_grid_height = p_node.getAttribute("gridHeight")
   CALL sadzp168_container_resize(p_node, l_table_width, l_grid_height)
END FUNCTION

##+ 取得單身資料表PK欄位(不包含FK欄位)
#PRIVATE FUNCTION sadzp168_set_status_widget(p_parent_node, p_node, p_dzea001)
#   DEFINE p_parent_node      om.DomNode            #status欄位的父節點
#   DEFINE p_node             om.DomNode            #status欄位節點
#   DEFINE p_dzea001          LIKE dzea_t.dzea001   #資料表名稱 
#
#   DEFINE l_cnt              LIKE type_t.num5
#   DEFINE l_new_child        om.DomNode
#   DEFINE l_name             STRING
#   DEFINE l_item_node        om.DomNode            #comboBox的items子項目
#   DEFINE l_items            STRING                #widget下items屬性值
#   DEFINE l_dzft005          LIKE dzft_t.dzft005   #程式
#   DEFINE l_dzft             RECORD
#                dzft004           LIKE dzft_t.dzft004,
#                dzft005           LIKE dzft_t.dzft005 
#             END RECORD
#
#   INITIALIZE l_new_child TO NULL
#
#   #取得畫面代碼的狀態碼個數
#   SELECT COUNT(*) INTO l_cnt FROM dzft_t 
#     WHERE dzftstus = 'Y'
#       AND dzft001 = g_ver_dzag003 AND dzft002 = g_dzfq_m.dzfq004 
#       AND dzft003 = p_dzea001 AND dzft006 = g_dzaa006
#
#   #取得畫面代碼的狀態碼類別
#   SELECT dzft005 INTO l_dzft005 FROM dzft_t 
#     WHERE dzftstus = 'Y'
#       AND dzft001 = g_ver_dzag003 AND dzft002 = g_dzfq_m.dzfq004
#       AND dzft003 = p_dzea001 AND dzft006 = g_dzaa006
#       AND dzft007 = 1
#       
#   IF l_cnt = 0 THEN
#      DISPLAY "status code is null."    #無任何狀態碼設定
#      RETURN TRUE
#   END IF
#   
#   #當狀態欄widget為CheckBox且狀態碼類別為[基礎資料檔狀態碼]時不需做任何的改變
#   IF p_node.getTagName() = "CheckBox" AND l_dzft005 = 17 THEN 
#      RETURN TRUE
#   END IF
#
#   #當status狀態items子項目大於3個(含)項目時
#   #需要stus欄位CheckBox widget型式改成ComboBox型式
#   IF p_node.getTagName() <> "ComboBox" THEN
#      LET l_new_child = p_parent_node.createChild("ComboBox")
#   
#      CALL l_new_child.setAttribute("aggregateColName", "")
#      CALL l_new_child.setAttribute("aggregateName", "")
#      CALL l_new_child.setAttribute("aggregateTableAliasName", "")
#      CALL l_new_child.setAttribute("aggregateTableName", "")
#      CALL l_new_child.setAttribute("columnCount", "")
#      CALL l_new_child.setAttribute("fieldId", p_node.getAttribute("fieldId")) 
#
#      CALL l_new_child.setAttribute("fieldType", p_node.getAttribute("fieldType"))
#      CALL l_new_child.setAttribute("sqlTabName", p_node.getAttribute("sqlTabName"))
#      CALL l_new_child.setAttribute("colName", p_node.getAttribute("colName"))
#      CALL l_new_child.setAttribute("name", p_node.getAttribute("name")) 
#
#      CALL l_new_child.setAttribute("gridHeight", p_node.getAttribute("gridHeight"))  
#      CALL l_new_child.setAttribute("gridWidth", p_node.getAttribute("gridWidth"))
#
#      CALL l_new_child.setAttribute("posX", p_node.getAttribute("posX"))
#      CALL l_new_child.setAttribute("posY", p_node.getAttribute("posY"))
#   
#      CALL l_new_child.setAttribute("noEntry", p_node.getAttribute("noEntry"))
#      CALL l_new_child.setAttribute("notNull", p_node.getAttribute("notNull"))
#      CALL l_new_child.setAttribute("required", p_node.getAttribute("required"))
#
#      CALL l_new_child.setAttribute("rowCount", p_node.getAttribute("rowCount"))
#      CALL l_new_child.setAttribute("stepX", p_node.getAttribute("stepX"))
#      CALL l_new_child.setAttribute("stepY", p_node.getAttribute("stepY"))
#      CALL l_new_child.setAttribute("tabIndex", p_node.getAttribute("tabIndex"))
#
#      
#      #父節點為Table或Tree,需加上title屬性
#      IF p_parent_node.getTagName() = "Table" OR p_parent_node.getTagName() = "Tree" THEN
#         CALL l_new_child.setAttribute("title", p_node.getAttribute("title"))
#      END IF
#      
#      CALL l_new_child.setAttribute("hidden", "")
#      CALL l_new_child.setAttribute("style", "")
#
#      #"ComboBox" widget的特殊屬性
#      CALL l_new_child.setAttribute("scroll", "true")
#      CALL l_new_child.setAttribute("sizePolicy", "dynamic")
#      CALL l_new_child.setAttribute("queryEditable", "true")
#      CALL l_new_child.setAttribute("lstrcomment", "true")
#      CALL l_new_child.setAttribute("lstrtitle", "true")
#      CALL l_new_child.setAttribute("lstrAggregatetext", "true")
#
#      CALL l_new_child.setAttribute("widget", "ComboBox")
#      CALL l_new_child.setAttribute("comment", "cmt_" || p_node.getAttribute("colName"))
#      
#      #將新欄位插入在原本的CheckBox節點前
#      IF p_node IS NOT NULL THEN
#         CALL p_parent_node.insertBefore(l_new_child, p_node)
#      END IF
#
#      #刪除原本的CheckBox節點
#      CALL p_parent_node.removeChild(p_node)
#   ELSE
#      LET l_new_child = p_node
#   END IF
#
#   #設置comboBox下的狀態碼items子項目
#   FOREACH dzft_cs USING g_ver_dzag003, g_dzfq_m.dzfq004, p_dzea001, g_dzaa006
#                   INTO l_dzft.*
#                   
#      IF SQLCA.sqlcode THEN
#         CALL cl_err("dzft_cs FOREACH:", SQLCA.sqlcode, 1)
#         EXIT FOREACH
#      END IF
#      
#      LET l_name = ""
#      
#      #依狀態碼類別有不同命名規則: 
#      #  1.基礎資料檔(17)-cbo_acti.XXX
#      #  2.交易檔   (13)-cbo_conf.XXX
#      CASE l_dzft.dzft005
#         WHEN 17
#            LET l_name = "cbo_acti."
#            
#         WHEN 13
#            LET l_name = "cbo_conf."
#      END CASE
#
#      LET l_name = l_name, l_dzft.dzft004 CLIPPED
#
#      #items子項目命名規則皆為小寫
#      LET l_name = l_name.toLowerCase()
#
#      #建立itmes子項目
#      LET l_item_node = l_new_child.createChild("Item")
#      CALL l_item_node.setAttribute("lstrtext", "true")
#      CALL l_item_node.setAttribute("name", l_dzft.dzft004 CLIPPED)
#      CALL l_item_node.setAttribute("text", l_name)
#
#      IF cl_null(l_items) THEN
#         LET l_items = l_name.trim()
#      ELSE
#         LET l_items = l_items, ", ", l_name.trim()
#      END IF
#            
#   END FOREACH
#
#   #設定comboBox下items屬性值
#   IF NOT cl_null(l_items) THEN
#      CALL l_new_child.setAttribute("items", l_items)
#   END IF
#
#   RETURN TRUE
#END FUNCTION
   
##+ 解析4fd畫面成設計資料
#PRIVATE FUNCTION sadzp168_analyze_4fd(p_gzza001)
#   DEFINE p_gzza001         LIKE gzza_t.gzza001   #4fd畫面檔檔案名稱,xxxx.4fd
#   
#   #DEFINE l_gzza003         LIKE gzza_t.gzza003   #模組名稱
#   DEFINE l_module          STRING                #模組名稱
#
#   #130702:因子作業模組取得方式不同,因此統一抓取r.a前端變數g_gzza003
#   ##取得程式所屬模組
#   #SELECT gzza003 INTO l_gzza003 FROM gzza_t
#   #  WHERE gzza001 = p_gzza001
#
#   IF cl_null(g_gzza003) THEN
#      CALL cl_err("", "adz-00012", 1)
#      DISPLAY "The module name(gzza003) of ", p_gzza001 CLIPPED, " is null."
#      RETURN FALSE
#   END IF 
#
#   #LET l_module = l_gzza003
#   LET l_module = g_gzza003
#   LET l_module = l_module.toLowerCase()
#
#   IF NOT sadzp168_3(l_module, p_gzza001, g_dzfq_m.dzfq003) THEN
#      RETURN FALSE
#   END IF
#
#   RETURN TRUE
#END FUNCTION

#+ 將4fd等資料新增到tsd table中
FUNCTION sadzp168_insert_tsd(p_prog, p_prog_template, p_ui_template)
   DEFINE p_prog              STRING                #程式代號
   DEFINE p_prog_template     STRING                #程式樣板
   DEFINE p_ui_template       STRING                #UI版型
   
   #DEFINE l_dzae              RECORD LIKE dzae_t.*  #設計器程式基本資料表
   DEFINE l_dzaa              RECORD LIKE dzaa_t.*  #規格與內容版本對應表
   DEFINE l_dzab              RECORD LIKE dzab_t.*  #規格整體設計表
   DEFINE l_dzac              RECORD LIKE dzac_t.*  #欄位規格設計表
   DEFINE l_dzad              RECORD LIKE dzad_t.*  #action規格設計表
   DEFINE l_dzag              RECORD LIKE dzag_t.*  #程式主Table設定表
   DEFINE l_cnt               LIKE type_t.num5
   DEFINE l_structure_n       LIKE type_t.num5      #畫面樣版的結構點數量
   DEFINE l_level1            LIKE type_t.num5      #第一階層設計資料順序
   DEFINE l_level2            LIKE type_t.num5      #第二階層設計資料順序
   DEFINE l_level3            LIKE type_t.num5      #第三階層設計資料順序
   
   DEFINE l_msg               STRING
   DEFINE l_str               base.StringBuffer
   DEFINE l_spec_version      LIKE dzfq_t.dzfq003    #規格版本
   DEFINE l_design_version    LIKE dzfq_t.dzfq003    #設計點版本
   DEFINE l_i                 LIKE type_t.num5
   #DEFINE l_dzai005           LIKE dzef_t.dzai005   #目標欄位

   DEFINE l_dzep025           LIKE dzep_t.dzep025   #最大值比較符號
   DEFINE l_dzep026           LIKE dzep_t.dzep026   #最小值比較符號
   DEFINE l_dzaa007           LIKE dzaa_t.dzaa007   #規格引用否
   DEFINE l_dzfr007           LIKE dzfr_t.dzfr007   #4fd tag name
   
   LET l_cnt = 0
   LET l_str = base.StringBuffer.create()
   LET l_spec_version = g_dzfq_m.dzfq003
   LET l_design_version = g_dzfq_m.dzfq003
   LET l_dzaa007 = "N"

   ##15/02/10 版次歸一功能
   ##本版次異動
   #LET g_dzaa011 = "Y"
   
   #BEGIN WORK
   
   ####設計器程式基本資料表###
   #LET l_dzae.dzae001 = p_prog.trim()
   #LET l_dzae.dzae002 = l_spec_version.trim()
   #LET l_dzae.dzae003 = p_prog_template.trim()
   #LET l_dzae.dzae004 = g_dzfq_m.dzfq001 CLIPPED
   #LET l_dzae.dzaemodid = g_dzfq_m.dzfqmodid
   #LET l_dzae.dzaemoddt = g_dzfq_m.dzfqmoddt
   #LET l_dzae.dzaeownid = g_dzfq_m.dzfqownid
   #LET l_dzae.dzaeowndp = g_dzfq_m.dzfqowndp
   #LET l_dzae.dzaecrtid = g_dzfq_m.dzfqcrtid
   #LET l_dzae.dzaecrtdp = g_dzfq_m.dzfqcrtdp
   #LET l_dzae.dzaecrtdt = g_dzfq_m.dzfqcrtdt
   #LET l_dzae.dzaestus = g_dzfq_m.dzfqstus
                       
   ##檢查相符合的程式代號,版本是否已存在
   #SELECT COUNT(*) INTO l_cnt FROM dzae_t 
   #  WHERE dzae001 = l_dzae.dzae001 
   #    AND dzae002 = l_dzae.dzae002

   #IF l_cnt > 0 THEN
   #   LET l_msg = "upd"
   #   UPDATE dzae_t SET dzae003 = l_dzae.dzae003, dzae004 = l_dzae.dzae004
   #      WHERE dzae001 = l_dzae.dzae001 
   #        AND dzae002 = l_dzae.dzae002
   #ELSE
   #   LET l_msg = "ins"
   #   INSERT INTO dzae_t (dzae001, dzae002, dzae003, dzae004, 
   #                       dzaemodid, dzaemoddt, dzaeownid, dzaeowndp, dzaecrtid, dzaecrtdp,
   #                       dzaecrtdt, dzaestus)
   #     VALUES(l_dzae.dzae001, l_dzae.dzae002, l_dzae.dzae003, l_dzae.dzae004, 
   #            l_dzae.dzaemodid, l_dzae.dzaemoddt, l_dzae.dzaeownid, l_dzae.dzaeowndp, l_dzae.dzaecrtid, l_dzae.dzaecrtdp, 
   #            l_dzae.dzaecrtdt, l_dzae.dzaestus)
   #END IF
   #IF SQLCA.sqlcode THEN
   #   CALL cl_err(l_msg.trim() || " dzae_t", SQLCA.sqlcode, 1)
   #   ROLLBACK WORK
   #   RETURN FALSE
   #END IF
   
   ###規格與內容版本對應表###
   LET l_dzaa.dzaa001 = p_prog.trim()
   LET l_dzaa.dzaa002 = l_spec_version
   
   #檢查相符合設計點資料是否已存在
   SELECT COUNT(*) INTO l_cnt FROM dzaa_t 
     WHERE dzaa001 = l_dzaa.dzaa001 
       AND dzaa002 = l_dzaa.dzaa002

   IF l_cnt > 0 THEN
      #刪除相關資料
      DELETE FROM dzaa_t 
        WHERE dzaa001 = l_dzaa.dzaa001 
          AND dzaa002 = l_dzaa.dzaa002
   END IF
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  SQLCA.sqlcode
      LET g_errparam.extend = "del dzaa_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      ROLLBACK WORK
      RETURN FALSE
   END IF

   
   #160531 mail:#####start############ 160624-00005
   #重新恢復寫入一筆資料,且因應空框架,空畫面.調動程式位置至此
   ####設計點類型:3(規格整體設計表)###
   LET l_dzaa.dzaa001 = p_prog              #程式代號
   LET l_dzaa.dzaa002 = l_spec_version      #規格版本
   LET l_dzaa.dzaa003 = "ALL"               #規格設計點("SPEC")
   LET l_dzaa.dzaa004 = l_design_version    #設計點版本
   LET l_dzaa.dzaa005 = "3"                 #設計點類型
   LET l_dzaa.dzaa006 = g_dzaa006           #使用標示
   LET l_dzaa.dzaa007 = l_dzaa007           #規格引用否
   LET l_dzaa.dzaa008 = g_dzaa008           #產品版本
   LET l_dzaa.dzaa009 = g_dzaa009           #識別標示
   LET l_dzaa.dzaa010 = g_dzaa010           #客戶代號
   #LET l_dzaa.dzaa011 = g_dzaa011           #本版次異動
   LET l_dzaa.dzaamodid = g_dzfq_m.dzfqmodid
   LET l_dzaa.dzaamoddt = g_dzfq_m.dzfqmoddt
   LET l_dzaa.dzaaownid = g_dzfq_m.dzfqownid
   LET l_dzaa.dzaaowndp = g_dzfq_m.dzfqowndp
   LET l_dzaa.dzaacrtid = g_dzfq_m.dzfqcrtid
   LET l_dzaa.dzaacrtdp = g_dzfq_m.dzfqcrtdp
   LET l_dzaa.dzaacrtdt = g_dzfq_m.dzfqcrtdt
   LET l_dzaa.dzaastus = g_dzfq_m.dzfqstus
   
   INSERT INTO dzaa_t (dzaa001, dzaa002, dzaa003, dzaa004, dzaa005,
                       dzaa006, dzaa007, dzaa008, dzaa009, dzaa010,           #dzaa011, 
                       dzaamodid, dzaamoddt, dzaaownid, dzaaowndp, dzaacrtid, dzaacrtdp,
                       dzaacrtdt, dzaastus)
     VALUES(l_dzaa.dzaa001, l_dzaa.dzaa002, l_dzaa.dzaa003, l_dzaa.dzaa004, l_dzaa.dzaa005, 
            l_dzaa.dzaa006, l_dzaa.dzaa007, l_dzaa.dzaa008, l_dzaa.dzaa009, l_dzaa.dzaa010,           #l_dzaa.dzaa011, 
            l_dzaa.dzaamodid, l_dzaa.dzaamoddt, l_dzaa.dzaaownid, l_dzaa.dzaaowndp, l_dzaa.dzaacrtid, l_dzaa.dzaacrtdp, 
            l_dzaa.dzaacrtdt, l_dzaa.dzaastus)
            
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "ins3 dzaa_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      ROLLBACK WORK
      RETURN FALSE
   END IF

   LET l_dzab.dzab001 = l_dzaa.dzaa001       #規格編號
   LET l_dzab.dzab002 = l_design_version     #識別碼版次
   LET l_dzab.dzab003 = g_dzaa006            #使用標示
   LET l_dzab.dzab004 = l_dzaa.dzaa003       #識別碼
   LET l_dzab.dzab005 = g_dzaa010            #客戶編號
   LET l_dzab.dzab006 = ""                   #no use
   LET l_dzab.dzabmodid = g_dzfq_m.dzfqmodid
   LET l_dzab.dzabmoddt = g_dzfq_m.dzfqmoddt
   LET l_dzab.dzabownid = g_dzfq_m.dzfqownid
   LET l_dzab.dzabowndp = g_dzfq_m.dzfqowndp
   LET l_dzab.dzabcrtid = g_dzfq_m.dzfqcrtid
   LET l_dzab.dzabcrtdp = g_dzfq_m.dzfqcrtdp
   LET l_dzab.dzabcrtdt = g_dzfq_m.dzfqcrtdt
   LET l_dzab.dzabstus = g_dzfq_m.dzfqstus
   
   INSERT INTO dzab_t (dzab001, dzab002, dzab003, dzab004, dzab005,
                       dzab006, 
                       dzabmodid, dzabmoddt, dzabownid, dzabowndp, dzabcrtid, dzabcrtdp,
                       dzabcrtdt, dzabstus)
     VALUES(l_dzab.dzab001, l_dzab.dzab002, l_dzab.dzab003, l_dzab.dzab004, l_dzab.dzab005, 
            l_dzab.dzab006, 
            l_dzab.dzabmodid, l_dzab.dzabmoddt, l_dzab.dzabownid, l_dzab.dzabowndp, l_dzab.dzabcrtid, l_dzab.dzabcrtdp, 
            l_dzab.dzabcrtdt, l_dzab.dzabstus)
      
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  SQLCA.sqlcode
      LET g_errparam.extend = "ins3 dzab_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      ROLLBACK WORK
      RETURN FALSE
   END IF
   
   #160531#end######################## 160624-00005

   
   #產生空框架畫面檔
   IF g_dzfq_m.dzfq015 = "Y" THEN
      RETURN TRUE
   END IF
   
   ###設計點類型:1(規格與內容版本對應表)###
   LET l_dzaa.dzaa001 = p_prog              #程式代號
   LET l_dzaa.dzaa002 = l_spec_version      #規格版本
   LET l_dzaa.dzaa004 = l_design_version    #設計點版本
   LET l_dzaa.dzaa005 = "1"                 #設計點類型
   LET l_dzaa.dzaa006 = g_dzaa006           #使用標示
   LET l_dzaa.dzaa007 = l_dzaa007           #規格引用否
   LET l_dzaa.dzaa008 = g_dzaa008           #產品版本
   LET l_dzaa.dzaa009 = g_dzaa009           #識別標示
   LET l_dzaa.dzaa010 = g_dzaa010           #客戶代號
   #LET l_dzaa.dzaa011 = g_dzaa011           #本版次異動
   LET l_dzaa.dzaamodid = g_dzfq_m.dzfqmodid
   LET l_dzaa.dzaamoddt = g_dzfq_m.dzfqmoddt
   LET l_dzaa.dzaaownid = g_dzfq_m.dzfqownid
   LET l_dzaa.dzaaowndp = g_dzfq_m.dzfqowndp
   LET l_dzaa.dzaacrtid = g_dzfq_m.dzfqcrtid
   LET l_dzaa.dzaacrtdp = g_dzfq_m.dzfqcrtdp
   LET l_dzaa.dzaacrtdt = g_dzfq_m.dzfqcrtdt
   LET l_dzaa.dzaastus = g_dzfq_m.dzfqstus
   
   FOR l_structure_n = 1 TO g_dzfr.getLength()
       #DISPLAY "structure:", g_dzfa_m.structure[li_dzfb004].structure, ASCII 10
       #12/19取消此規則:browser(瀏覽表)和Tree(樹狀)結構不需做規格設計,不產出tsd檔
       #IF g_dzfa_m.structure[li_dzfb004].structure = g_browse OR g_dzfa_m.structure[li_dzfb004].structure = g_btree THEN
       #   CONTINUE FOR
       #END IF
       
       FOR l_level1 = 1 TO g_dzfr[l_structure_n].sfolder.getLength()
           FOR l_level2 = 1 TO g_dzfr[l_structure_n].sfolder[l_level1].spage.getLength()
               FOR l_level3 = 1 TO g_dzfr[l_structure_n].sfolder[l_level1].spage[l_level2].sfield.getLength()
                   #遇到ghost型態欄位時，表示為空節點.不做任何處理
                   IF g_dzfr[l_structure_n].sfolder[l_level1].spage[l_level2].sfield[l_level3].dzfr006 = "ghost" THEN
                      CONTINUE FOR
                   END IF

                   #20140326:修改取得控件編號方式
                   ###IF g_dzfr[l_structure_n].structure.trim() = g_detail AND 
                   ###   (NOT cl_null(g_dzfr[l_structure_n].sfolder[l_level1].spage[l_level2].sfield[l_level3].detailPK CLIPPED)) THEN

                   ###   #單身多頁籤的PK欄位,需利用4fd上的widget name進tsd設計檔
                   ###   LET l_dzaa.dzaa003 = g_dzfr[l_structure_n].sfolder[l_level1].spage[l_level2].sfield[l_level3].detailPK CLIPPED
                   ###ELSE
                   ###   IF g_dzfr[l_structure_n].structure.trim() = g_browse OR g_dzfr[l_structure_n].structure.trim() = g_btree THEN
                   ###      LET l_dzaa.dzaa003 = "b_", g_dzfr[l_structure_n].sfolder[l_level1].spage[l_level2].sfield[l_level3].colName CLIPPED
                   ###   ELSE
                   ###      LET l_dzaa.dzaa003 = g_dzfr[l_structure_n].sfolder[l_level1].spage[l_level2].sfield[l_level3].attrName CLIPPED
                   ###   END IF
                   ###END IF

                   ####Q, P類版型,g_detail結構欄位為COLUMN_LIKE型態
                   ###IF (g_dzfr[l_structure_n].structure.trim() = g_detail OR g_dzfr[l_structure_n].structure.trim() = g_btree OR g_dzfr[l_structure_n].structure.trim() = g_master) AND 
                   ###   (g_dzfq_m.cbo_progtype = "Q" OR g_dzfq_m.cbo_progtype = "P") AND g_dzfr[l_structure_n].sfolder[l_level1].spage[l_level2].sfield[l_level3].widgetName IS NOT NULL THEN
                      
                   ###   LET l_dzaa.dzaa003 = g_dzfr[l_structure_n].sfolder[l_level1].spage[l_level2].sfield[l_level3].widgetName.toString()
                   ###END IF

                   #控件編號
                   LET l_dzaa.dzaa003 = g_dzfr[l_structure_n].sfolder[l_level1].spage[l_level2].sfield[l_level3].widgetName.toString()
                   
                   INSERT INTO dzaa_t (dzaa001, dzaa002, dzaa003, dzaa004, dzaa005,
                                       dzaa006, dzaa007, dzaa008, dzaa009, dzaa010,           #dzaa011, 
                                       dzaamodid, dzaamoddt, dzaaownid, dzaaowndp, dzaacrtid, dzaacrtdp,
                                       dzaacrtdt, dzaastus)
                     VALUES(l_dzaa.dzaa001, l_dzaa.dzaa002, l_dzaa.dzaa003, l_dzaa.dzaa004, l_dzaa.dzaa005, 
                            l_dzaa.dzaa006, l_dzaa.dzaa007, l_dzaa.dzaa008, l_dzaa.dzaa009, l_dzaa.dzaa010,          #l_dzaa.dzaa011,  
                            l_dzaa.dzaamodid, l_dzaa.dzaamoddt, l_dzaa.dzaaownid, l_dzaa.dzaaowndp, l_dzaa.dzaacrtid, l_dzaa.dzaacrtdp, 
                            l_dzaa.dzaacrtdt, l_dzaa.dzaastus)
                   
                   IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code =  SQLCA.sqlcode
                      LET g_errparam.extend = "ins1 dzaa_t"
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                      ROLLBACK WORK
                      RETURN FALSE
                   END IF

                   #檢查相符合欄位規格設計資料是否已存在
                   SELECT COUNT(*) INTO l_cnt FROM dzac_t 
                     WHERE dzac001 = l_dzaa.dzaa001
                       AND dzac003 = l_dzaa.dzaa003
                       AND dzac004 = l_dzaa.dzaa004
                       AND dzac012 = l_dzaa.dzaa006
                   IF l_cnt > 0 THEN
                      CONTINUE FOR
                   END IF

                   SELECT '', dzeb002, '', '', dzeb001, 
                          #dzeb006, gztd003 || '(' || gztd008 || ')', dzep005, dzep017, dzep018,
                          '', '', dzep005, dzep017, dzep018, #2014/09/01 by Hiko
                          dzep019, '', dzep011, dzep012, dzep025,
                          dzep013, dzep026, dzep014, 'Y', 'Y',
                          dzej003
                     INTO l_dzac.dzac001,
                          l_dzac.dzac002,
                          l_dzac.dzac003,
                          l_dzac.dzac004,
                          l_dzac.dzac005,
                          l_dzac.dzac006,
                          l_dzac.dzac007,
                          l_dzac.dzac008,
                          l_dzac.dzac009,
                          l_dzac.dzac010,
                          l_dzac.dzac011,
                          l_dzac.dzac012,
                          l_dzac.dzac013,
                          l_dzac.dzac014,
                          l_dzac.dzac020,
                          l_dzac.dzac015,
                          l_dzac.dzac021,
                          l_dzac.dzac016,
                          l_dzac.dzac017,
                          l_dzac.dzac018, 
                          l_dzac.dzac019
                     FROM dzeb_t LEFT JOIN gztd_t ON gztd001 = dzeb006 
                                 LEFT JOIN dzep_t ON dzeb001 = dzep001 AND dzeb002 = dzep002 
                                 LEFT JOIN dzej_t ON dzep010 = dzej002 AND dzej001 = 'GENERO_WIDGETS' 
                                 #LEFT JOIN dzef_t ON dzeb001 = dzef001 AND dzeb002 = dzef002
                     WHERE dzeb001 = g_dzfr[l_structure_n].sfolder[l_level1].spage[l_level2].sfield[l_level3].sqlTabName  
                       AND dzeb002 = g_dzfr[l_structure_n].sfolder[l_level1].spage[l_level2].sfield[l_level3].colName

                   LET l_dzac.dzac001 = l_dzaa.dzaa001
                   LET l_dzac.dzac003 = l_dzaa.dzaa003
                   LET l_dzac.dzac004 = l_dzaa.dzaa004
                   LET l_dzac.dzac012 = l_dzaa.dzaa006
                   #LET l_dzac.dzac020 = ""                #no use
                   #LET l_dzac.dzac021 = 0                 #no use

                   #必要欄位
                   IF cl_null(l_dzac.dzac008) THEN
                      LET l_dzac.dzac008 = "N"
                   END IF

                   #130626取消comboBox的Item靜態產生,不再參考資料項目欄位設定
                   #140526改成客戶代號
                   LET l_dzac.dzac013 = l_dzaa.dzaa010
                   
                   #s_browse和tree目前因UI和Genero的限制不開放編輯和修改: dzac017(是否可編輯)="N"; dzac018(是否可查詢)="N"
                   #公用欄位不提供編輯,但可查詢
                   #可否修改
                   IF g_dzfr[l_structure_n].sfolder[l_level1].spage[l_level2].sfield[l_level3].dzek001 = "grpUIBelong" OR
                      g_dzfr[l_structure_n].sfolder[l_level1].spage[l_level2].sfield[l_level3].dzek001 = "grpUIStateinfo" OR 
                      g_dzfr[l_structure_n].structure = g_browse OR g_dzfr[l_structure_n].structure = g_btree THEN
                      
                      LET l_dzac.dzac017 = "N"
                   ELSE
                      LET l_dzac.dzac017 = "Y"
                   END IF

                   #可否查詢
                   IF g_dzfr[l_structure_n].structure = g_browse OR g_dzfr[l_structure_n].structure = g_btree THEN
                      LET l_dzac.dzac018 = "N"
                   ELSE
                      LET l_dzac.dzac018 = "Y"
                   END IF

                   #欄位4fd上顯示控件
                   IF g_dzfr[l_structure_n].sfolder[l_level1].spage[l_level2].sfield[l_level3].widget IS NOT NULL THEN
                      LET l_dzac.dzac019 = g_dzfr[l_structure_n].sfolder[l_level1].spage[l_level2].sfield[l_level3].widget.toString()
                      #DISPLAY l_dzac.dzac003 CLIPPED, ": ", g_dzfr[l_structure_n].sfolder[l_level1].spage[l_level2].sfield[l_level3].widget.toString()
                   END IF

                   IF l_dzac.dzac007[1,4] = "date" OR l_dzac.dzac007[1,4] = "blob" OR 
                      l_dzac.dzac007[1,4] = "clob" OR l_dzac.dzac007 = "()" OR l_dzac.dzac007 = "( )" THEN
                      CALL l_str.clear()
                      CALL l_str.append(l_dzac.dzac007 CLIPPED)
                      CALL l_str.replace("(", "", 1)
                      CALL l_str.replace(")", "", 1)
                      CALL l_str.replace(" ", "", 1)
                      LET l_dzac.dzac007 = l_str.toString()
                   END IF

                   #141205變更規格 by Hiko,最大值,最小值修改,以下mark
                   ##最大值,最小值加入邊界值符號
                   #IF NOT cl_null(l_dzep025) THEN
                   #   LET l_dzac.dzac015 = l_dzep025 CLIPPED, ",", l_dzac.dzac015 CLIPPED
                   #END IF
                   #IF NOT cl_null(l_dzep026) THEN
                   #   LET l_dzac.dzac016 = l_dzep026 CLIPPED, ",", l_dzac.dzac016 CLIPPED
                   #END IF

                   #14/04/16:修改成P,Q,R類的畫面規格,忽略adzi150的[編輯時開窗設定(dzep017)]
                   IF g_dzfq_m.cbo_progtype = "Q" OR g_dzfq_m.cbo_progtype = "P" OR g_dzfq_m.cbo_progtype = "R" THEN
                      LET l_dzac.dzac009 = ""
                   END IF
   
                   INSERT INTO dzac_t(dzac001, dzac002, dzac003, dzac004, dzac005, 
                                      dzac006, dzac007, dzac008, dzac009, dzac010, 
                                      dzac011, dzac012, dzac013, dzac014, dzac015, 
                                      dzac016, dzac017, dzac018, dzac019, dzac020, 
                                      dzac021, 
                                      dzacmodid, dzacmoddt, dzacownid, dzacowndp, dzaccrtid, 
                                      dzaccrtdp, dzaccrtdt, dzacstus)
                     VALUES (l_dzac.dzac001, l_dzac.dzac002, l_dzac.dzac003, l_dzac.dzac004, l_dzac.dzac005, 
                             l_dzac.dzac006, l_dzac.dzac007, l_dzac.dzac008, l_dzac.dzac009, l_dzac.dzac010, 
                             l_dzac.dzac011, l_dzac.dzac012, l_dzac.dzac013, l_dzac.dzac014, l_dzac.dzac015, 
                             l_dzac.dzac016, l_dzac.dzac017, l_dzac.dzac018, l_dzac.dzac019, l_dzac.dzac020, 
                             l_dzac.dzac021, 
                             g_dzfq_m.dzfqmodid, g_dzfq_m.dzfqmoddt, g_dzfq_m.dzfqownid, g_dzfq_m.dzfqowndp, g_dzfq_m.dzfqcrtid, 
                             g_dzfq_m.dzfqcrtdp, g_dzfq_m.dzfqcrtdt, g_dzfq_m.dzfqstus)

                   IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code =  SQLCA.sqlcode
                      LET g_errparam.extend = "ins dzac_t"
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                      ROLLBACK WORK
                      RETURN FALSE
                   END IF

                   #欄位相關的參考欄位, 資料多語言, 助記碼,串查等設定寫入tsd中
                   IF NOT sadzp168_insert_field_spec_tsd(g_dzfr[l_structure_n].structure,
                                                         g_dzfr[l_structure_n].sfolder[l_level1].spage[l_level2].sfield[l_level3].*,
                                                         p_prog, l_spec_version, l_design_version, l_dzac.dzac003) THEN
                      ROLLBACK WORK
                      RETURN FALSE
                   END IF
               END FOR
           END FOR
       END FOR
   END FOR

   ###設計點類型:2(action規格設計表)###
   LET l_dzaa.dzaa001 = p_prog              #程式代號
   LET l_dzaa.dzaa002 = l_spec_version      #規格版本
   LET l_dzaa.dzaa004 = l_design_version    #設計點版本
   LET l_dzaa.dzaa005 = "2"                 #設計點類型
   LET l_dzaa.dzaa006 = g_dzaa006           #使用標示
   LET l_dzaa.dzaa007 = l_dzaa007           #規格引用否
   LET l_dzaa.dzaa008 = g_dzaa008           #產品版本
   LET l_dzaa.dzaa009 = g_dzaa009           #識別標示
   LET l_dzaa.dzaa010 = g_dzaa010           #客戶代號
   #LET l_dzaa.dzaa011 = g_dzaa011           #本版次異動
   LET l_dzaa.dzaamodid = g_dzfq_m.dzfqmodid
   LET l_dzaa.dzaamoddt = g_dzfq_m.dzfqmoddt
   LET l_dzaa.dzaaownid = g_dzfq_m.dzfqownid
   LET l_dzaa.dzaaowndp = g_dzfq_m.dzfqowndp
   LET l_dzaa.dzaacrtid = g_dzfq_m.dzfqcrtid
   LET l_dzaa.dzaacrtdp = g_dzfq_m.dzfqcrtdp
   LET l_dzaa.dzaacrtdt = g_dzfq_m.dzfqcrtdt
   LET l_dzaa.dzaastus = g_dzfq_m.dzfqstus
   
   FOR l_i = 1 TO g_toolbar.getLength()
       IF g_toolbar[l_i].toolbar_chk = "Y" THEN
          LET l_dzaa.dzaa003 = g_toolbar[l_i].tb_act_id.trim()   #規格設計點

          INSERT INTO dzaa_t (dzaa001, dzaa002, dzaa003, dzaa004, dzaa005,
                              dzaa006, dzaa007, dzaa008, dzaa009, dzaa010,           #dzaa011, 
                              dzaamodid, dzaamoddt, dzaaownid, dzaaowndp, dzaacrtid, dzaacrtdp,
                              dzaacrtdt, dzaastus)
            VALUES(l_dzaa.dzaa001, l_dzaa.dzaa002, l_dzaa.dzaa003, l_dzaa.dzaa004, l_dzaa.dzaa005, 
                   l_dzaa.dzaa006, l_dzaa.dzaa007, l_dzaa.dzaa008, l_dzaa.dzaa009, l_dzaa.dzaa010,           #l_dzaa.dzaa011, 
                   l_dzaa.dzaamodid, l_dzaa.dzaamoddt, l_dzaa.dzaaownid, l_dzaa.dzaaowndp, l_dzaa.dzaacrtid, l_dzaa.dzaacrtdp, 
                   l_dzaa.dzaacrtdt, l_dzaa.dzaastus)
                   

          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code =  SQLCA.sqlcode
             LET g_errparam.extend = "ins2 dzaa_t"
             LET g_errparam.popup = TRUE
             CALL cl_err()
             ROLLBACK WORK
             RETURN FALSE
          END IF

          LET l_dzad.dzad001 = l_dzaa.dzaa001
          LET l_dzad.dzad002 = l_dzaa.dzaa003
          LET l_dzad.dzad003 = l_dzaa.dzaa004
          LET l_dzad.dzad005 = l_dzaa.dzaa006     #使用標示

          SELECT COUNT(*) INTO l_cnt FROM dzad_t 
            WHERE dzad001 = l_dzad.dzad001
              AND dzad002 = l_dzad.dzad002
              AND dzad003 = l_dzad.dzad003
              AND dzad005 = l_dzad.dzad005 
          IF l_cnt = 0 THEN
             #LET l_dzad.dzad006 = "N"                  #是否引用標準規格
             LET l_dzad.dzad006 = "all"                 #觸發時機
             LET l_dzad.dzad007 = "Y"                   #產生標準程式
             LET l_dzad.dzad008 = l_dzaa.dzaa010        #客戶代號
             
             INSERT INTO dzad_t(dzad001, dzad002, dzad003, dzad005, dzad006,
                                dzad007, dzad008, 
                                dzadmodid, dzadmoddt, dzadownid, dzadowndp, dzadcrtid,
                                dzadcrtdp, dzadcrtdt, dzadstus)
               VALUES (l_dzad.dzad001, l_dzad.dzad002, l_dzad.dzad003, l_dzad.dzad005, l_dzad.dzad006, 
                       l_dzad.dzad007, l_dzad.dzad008, 
                       g_dzfq_m.dzfqmodid, g_dzfq_m.dzfqmoddt, g_dzfq_m.dzfqownid, g_dzfq_m.dzfqowndp, g_dzfq_m.dzfqcrtid, 
                       g_dzfq_m.dzfqcrtdp, g_dzfq_m.dzfqcrtdt, g_dzfq_m.dzfqstus)
          END IF
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code =  SQLCA.sqlcode
             LET g_errparam.extend = "ins dzad_t "
             LET g_errparam.popup = TRUE
             CALL cl_err()
             ROLLBACK WORK
             RETURN FALSE
          END IF
       END IF       
   END FOR   
   

   ###設計點類型:4(程式資料表設定表)###
   LET l_dzaa.dzaa001 = p_prog              #程式代號
   LET l_dzaa.dzaa002 = l_spec_version      #規格版本
   LET l_dzaa.dzaa003 = "TABLE"             #規格設計點
   LET l_dzaa.dzaa004 = l_design_version    #設計點版本
   LET l_dzaa.dzaa005 = "4"                 #設計點類型
   LET l_dzaa.dzaa006 = g_dzaa006           #使用標示
   LET l_dzaa.dzaa007 = l_dzaa007           #規格引用否
   LET l_dzaa.dzaa008 = g_dzaa008           #產品版本
   LET l_dzaa.dzaa009 = g_dzaa009           #識別標示
   LET l_dzaa.dzaa010 = g_dzaa010           #客戶代號
   #LET l_dzaa.dzaa011 = g_dzaa011           #本版次異動
   LET l_dzaa.dzaamodid = g_dzfq_m.dzfqmodid
   LET l_dzaa.dzaamoddt = g_dzfq_m.dzfqmoddt
   LET l_dzaa.dzaaownid = g_dzfq_m.dzfqownid
   LET l_dzaa.dzaaowndp = g_dzfq_m.dzfqowndp
   LET l_dzaa.dzaacrtid = g_dzfq_m.dzfqcrtid
   LET l_dzaa.dzaacrtdp = g_dzfq_m.dzfqcrtdp
   LET l_dzaa.dzaacrtdt = g_dzfq_m.dzfqcrtdt
   LET l_dzaa.dzaastus = g_dzfq_m.dzfqstus
   
   INSERT INTO dzaa_t (dzaa001, dzaa002, dzaa003, dzaa004, dzaa005,
                       dzaa006, dzaa007, dzaa008, dzaa009, dzaa010,           #dzaa011, 
                       dzaamodid, dzaamoddt, dzaaownid, dzaaowndp, dzaacrtid, dzaacrtdp,
                       dzaacrtdt, dzaastus)
     VALUES(l_dzaa.dzaa001, l_dzaa.dzaa002, l_dzaa.dzaa003, l_dzaa.dzaa004, l_dzaa.dzaa005, 
            l_dzaa.dzaa006, l_dzaa.dzaa007, l_dzaa.dzaa008, l_dzaa.dzaa009, l_dzaa.dzaa010,           #l_dzaa.dzaa011, 
            l_dzaa.dzaamodid, l_dzaa.dzaamoddt, l_dzaa.dzaaownid, l_dzaa.dzaaowndp, l_dzaa.dzaacrtid, l_dzaa.dzaacrtdp, 
            l_dzaa.dzaacrtdt, l_dzaa.dzaastus)
      
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  SQLCA.sqlcode
      LET g_errparam.extend = "ins4 dzaa_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      ROLLBACK WORK
      RETURN FALSE
   END IF
   
   ###todo:INSERT 程式資料表設定表(dzag_t)已由adzp168主作業insert資料###

   ###設計點類型:5(TREE整體設計表)###
   ##取得dzff_t是否有該畫面代碼的tree設定
   #取得畫面上所有的tree container
   FOREACH sadzp168_tree_info_cur INTO l_dzfr007
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  SQLCA.sqlcode
         LET g_errparam.extend = "sadzp168_tree_info_cur FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF

      LET l_dzaa.dzaa001 = p_prog                 #程式代號
      LET l_dzaa.dzaa002 = l_spec_version         #規格版本
      #LET l_dzaa.dzaa003 = "TREE"                 #規格設計點
      LET l_dzaa.dzaa003 = l_dzfr007 CLIPPED      #規格設計點
      LET l_dzaa.dzaa004 = l_design_version       #設計點版本
      LET l_dzaa.dzaa005 = "5"                    #設計點類型
      LET l_dzaa.dzaa006 = g_dzaa006              #使用標示
      LET l_dzaa.dzaa007 = l_dzaa007              #規格引用否
      LET l_dzaa.dzaa008 = g_dzaa008              #產品版本
      LET l_dzaa.dzaa009 = g_dzaa009              #識別標示
      LET l_dzaa.dzaa010 = g_dzaa010              #客戶代號
      #LET l_dzaa.dzaa011 = g_dzaa011              #本版次異動
      LET l_dzaa.dzaamodid = g_dzfq_m.dzfqmodid
      LET l_dzaa.dzaamoddt = g_dzfq_m.dzfqmoddt
      LET l_dzaa.dzaaownid = g_dzfq_m.dzfqownid
      LET l_dzaa.dzaaowndp = g_dzfq_m.dzfqowndp
      LET l_dzaa.dzaacrtid = g_dzfq_m.dzfqcrtid
      LET l_dzaa.dzaacrtdp = g_dzfq_m.dzfqcrtdp
      LET l_dzaa.dzaacrtdt = g_dzfq_m.dzfqcrtdt
      LET l_dzaa.dzaastus = g_dzfq_m.dzfqstus
      
      LET l_cnt = 0

      INSERT INTO dzaa_t (dzaa001, dzaa002, dzaa003, dzaa004, dzaa005,
                          dzaa006, dzaa007, dzaa008, dzaa009, dzaa010,           #dzaa011, 
                          dzaamodid, dzaamoddt, dzaaownid, dzaaowndp, dzaacrtid, dzaacrtdp,
                          dzaacrtdt, dzaastus)
        VALUES(l_dzaa.dzaa001, l_dzaa.dzaa002, l_dzaa.dzaa003, l_dzaa.dzaa004, l_dzaa.dzaa005, 
               l_dzaa.dzaa006, l_dzaa.dzaa007, l_dzaa.dzaa008, l_dzaa.dzaa009, l_dzaa.dzaa010,           #l_dzaa.dzaa011, 
               l_dzaa.dzaamodid, l_dzaa.dzaamoddt, l_dzaa.dzaaownid, l_dzaa.dzaaowndp, l_dzaa.dzaacrtid, l_dzaa.dzaacrtdp, 
               l_dzaa.dzaacrtdt, l_dzaa.dzaastus)
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  SQLCA.sqlcode
         LET g_errparam.extend = "ins5 dzaa_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         ROLLBACK WORK
         RETURN FALSE
      END IF
   END FOREACH
   
   
   ###130626取消STATUS 靜態產生##
   ####設計點類型:a(程式狀態碼檔)###  
   #LET l_dzaa.dzaa001 = p_prog              #程式代號
   #LET l_dzaa.dzaa002 = l_spec_version      #規格版本
   #LET l_dzaa.dzaa003 = "STATUS"            #規格設計點
   #LET l_dzaa.dzaa004 = l_design_version    #設計點版本
   #LET l_dzaa.dzaa005 = "a"                 #設計點類型

   #COMMIT WORK
   RETURN TRUE
END FUNCTION

#+ 欄位相關的參考欄位, 資料多語言, 助記碼等設定寫入tsd中
FUNCTION sadzp168_insert_field_spec_tsd(p_structure, p_field, p_prog, p_spec_version, p_design_version, p_dzac003)
   DEFINE p_structure         STRING                #結構類型
   DEFINE p_field             type_g_field
   DEFINE p_prog              STRING                #程式代號
   DEFINE p_spec_version      LIKE dzfq_t.dzfq003   #規格版本
   DEFINE p_design_version    LIKE dzfq_t.dzfq003   #設計點版本
   DEFINE p_dzac003           LIKE dzac_t.dzac003   #控件編號
   
   DEFINE l_dzaa              RECORD LIKE dzaa_t.*  #規格與內容版本對應表
   DEFINE l_dzai              RECORD LIKE dzai_t.*  #tsd:欄位參考設計表
   DEFINE l_dzaj              RECORD LIKE dzaj_t.*  #tsd:欄位資料多語言設計表
   DEFINE l_dzak              RECORD LIKE dzak_t.*  #tsd:欄位助記碼設計表
   DEFINE l_dzal              RECORD LIKE dzal_t.*  #tsd:程式串查設計表
   DEFINE l_dzef              RECORD LIKE dzef_t.*  #欄位參考設計表
   DEFINE l_dzer              RECORD LIKE dzer_t.*  #欄位資料多語言設計表
   DEFINE l_dzet              RECORD LIKE dzet_t.*  #欄位助記碼設計表
   
   DEFINE l_cnt               LIKE type_t.num5
   DEFINE l_dzaa007           LIKE dzaa_t.dzaa007   #規格引用否

   LET l_dzaa007 = "N"
   
   ###設計點類型:6(欄位參考設計表)###
   IF NOT cl_null(p_field.refField) AND p_field.dzai002 IS NOT NULL THEN
      LET l_dzaa.dzaa001 = p_prog                         #程式代號
      LET l_dzaa.dzaa002 = p_spec_version                 #規格版本
      LET l_dzaa.dzaa003 = p_field.dzai002.toString()     #參考欄位的控件名稱
      LET l_dzaa.dzaa004 = p_design_version               #設計點版本
      LET l_dzaa.dzaa005 = "6"                            #設計點類型
      LET l_dzaa.dzaa006 = g_dzaa006                      #使用標示
      LET l_dzaa.dzaa007 = l_dzaa007                      #規格引用否
      LET l_dzaa.dzaa008 = g_dzaa008                      #產品版本
      LET l_dzaa.dzaa009 = g_dzaa009                      #識別標示
      LET l_dzaa.dzaa010 = g_dzaa010                      #客戶代號
      #LET l_dzaa.dzaa011 = g_dzaa011                      #本版次異動
      LET l_dzaa.dzaamodid = g_dzfq_m.dzfqmodid
      LET l_dzaa.dzaamoddt = g_dzfq_m.dzfqmoddt
      LET l_dzaa.dzaaownid = g_dzfq_m.dzfqownid
      LET l_dzaa.dzaaowndp = g_dzfq_m.dzfqowndp
      LET l_dzaa.dzaacrtid = g_dzfq_m.dzfqcrtid
      LET l_dzaa.dzaacrtdp = g_dzfq_m.dzfqcrtdp
      LET l_dzaa.dzaacrtdt = g_dzfq_m.dzfqcrtdt
      LET l_dzaa.dzaastus = g_dzfq_m.dzfqstus
   
      INSERT INTO dzaa_t (dzaa001, dzaa002, dzaa003, dzaa004, dzaa005,
                          dzaa006, dzaa007, dzaa008, dzaa009, dzaa010,           #dzaa011, 
                          dzaamodid, dzaamoddt, dzaaownid, dzaaowndp, dzaacrtid, dzaacrtdp,
                          dzaacrtdt, dzaastus)
        VALUES(l_dzaa.dzaa001, l_dzaa.dzaa002, l_dzaa.dzaa003, l_dzaa.dzaa004, l_dzaa.dzaa005, 
               l_dzaa.dzaa006, l_dzaa.dzaa007, l_dzaa.dzaa008, l_dzaa.dzaa009, l_dzaa.dzaa010,           #l_dzaa.dzaa011, 
               l_dzaa.dzaamodid, l_dzaa.dzaamoddt, l_dzaa.dzaaownid, l_dzaa.dzaaowndp, l_dzaa.dzaacrtid, l_dzaa.dzaacrtdp, 
               l_dzaa.dzaacrtdt, l_dzaa.dzaastus)

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  SQLCA.sqlcode
         LET g_errparam.extend = "ins6 dzaa_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         ROLLBACK WORK
         RETURN FALSE
      END IF
       
      LET l_dzai.dzai001 = l_dzaa.dzaa001
      LET l_dzai.dzai002 = l_dzaa.dzaa003
      LET l_dzai.dzai003 = l_dzaa.dzaa004
      LET l_dzai.dzai004 = l_dzaa.dzaa006                 #使用標示
      LET l_dzai.dzai005 = p_field.dzai005.toString()     #依附控件名稱

      SELECT COUNT(*) INTO l_cnt FROM dzai_t 
        WHERE dzai001 = l_dzai.dzai001
          AND dzai002 = l_dzai.dzai002
          AND dzai003 = l_dzai.dzai003
          AND dzai004 = l_dzai.dzai004
      IF l_cnt = 0 THEN
         #取得參考欄位相關設定
         SELECT * INTO l_dzef.* FROM dzef_t 
           WHERE dzef001 = p_field.sqlTabName
             AND dzef002 = p_field.colName

         LET l_dzai.dzai007 = l_dzef.dzef003  
         LET l_dzai.dzai008 = l_dzef.dzef006  
         LET l_dzai.dzai009 = l_dzef.dzef007  
         LET l_dzai.dzai010 = l_dzef.dzef009
         LET l_dzai.dzai011 = l_dzef.dzef008
         LET l_dzai.dzai012 = l_dzaa.dzaa010
         
         INSERT INTO dzai_t(dzai001, dzai002, dzai003, dzai004, dzai005,
                            dzai007, dzai008, dzai009, dzai010, dzai011,
                            dzai012, 
                            dzaimodid, dzaimoddt, dzaiownid, dzaiowndp, dzaicrtid,
                            dzaicrtdp, dzaicrtdt, dzaistus)
           VALUES (l_dzai.dzai001, l_dzai.dzai002, l_dzai.dzai003, l_dzai.dzai004, l_dzai.dzai005,
                   l_dzai.dzai007, l_dzai.dzai008, l_dzai.dzai009, l_dzai.dzai010, l_dzai.dzai011, 
                   l_dzai.dzai012, 
                   g_dzfq_m.dzfqmodid, g_dzfq_m.dzfqmoddt, g_dzfq_m.dzfqownid, g_dzfq_m.dzfqowndp, g_dzfq_m.dzfqcrtid, 
                   g_dzfq_m.dzfqcrtdp, g_dzfq_m.dzfqcrtdt, g_dzfq_m.dzfqstus)  
      END IF
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  SQLCA.sqlcode
         LET g_errparam.extend = "ins dzai_t "
         LET g_errparam.popup = TRUE
         CALL cl_err()
         ROLLBACK WORK
         RETURN FALSE
      END IF
   END IF

   ###設計點類型:7(欄位資料多語言設計表)###
   IF NOT cl_null(p_field.langField) AND p_field.dzaj002 IS NOT NULL THEN
      LET l_dzaa.dzaa001 = p_prog                         #程式代號
      LET l_dzaa.dzaa002 = p_spec_version                 #規格版本
      LET l_dzaa.dzaa003 = p_field.dzaj002.toString()     #多語言欄位的控件名稱
      LET l_dzaa.dzaa004 = p_design_version               #設計點版本
      LET l_dzaa.dzaa005 = "7"                            #設計點類型
      LET l_dzaa.dzaa006 = g_dzaa006                      #使用標示
      LET l_dzaa.dzaa007 = l_dzaa007                      #規格引用否
      LET l_dzaa.dzaa008 = g_dzaa008                      #產品版本
      LET l_dzaa.dzaa009 = g_dzaa009                      #識別標示
      LET l_dzaa.dzaa010 = g_dzaa010                      #客戶代號
      #LET l_dzaa.dzaa011 = g_dzaa011                      #本版次異動
      LET l_dzaa.dzaamodid = g_dzfq_m.dzfqmodid
      LET l_dzaa.dzaamoddt = g_dzfq_m.dzfqmoddt
      LET l_dzaa.dzaaownid = g_dzfq_m.dzfqownid
      LET l_dzaa.dzaaowndp = g_dzfq_m.dzfqowndp
      LET l_dzaa.dzaacrtid = g_dzfq_m.dzfqcrtid
      LET l_dzaa.dzaacrtdp = g_dzfq_m.dzfqcrtdp
      LET l_dzaa.dzaacrtdt = g_dzfq_m.dzfqcrtdt
      LET l_dzaa.dzaastus = g_dzfq_m.dzfqstus
      
      INSERT INTO dzaa_t (dzaa001, dzaa002, dzaa003, dzaa004, dzaa005,
                          dzaa006, dzaa007, dzaa008, dzaa009, dzaa010,           #dzaa011, 
                          dzaamodid, dzaamoddt, dzaaownid, dzaaowndp, dzaacrtid, dzaacrtdp,
                          dzaacrtdt, dzaastus)
        VALUES(l_dzaa.dzaa001, l_dzaa.dzaa002, l_dzaa.dzaa003, l_dzaa.dzaa004, l_dzaa.dzaa005, 
               l_dzaa.dzaa006, l_dzaa.dzaa007, l_dzaa.dzaa008, l_dzaa.dzaa009, l_dzaa.dzaa010,            #l_dzaa.dzaa011, 
               l_dzaa.dzaamodid, l_dzaa.dzaamoddt, l_dzaa.dzaaownid, l_dzaa.dzaaowndp, l_dzaa.dzaacrtid, l_dzaa.dzaacrtdp, 
               l_dzaa.dzaacrtdt, l_dzaa.dzaastus)

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  SQLCA.sqlcode
         LET g_errparam.extend = "ins7 dzaa_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         ROLLBACK WORK
         RETURN FALSE
      END IF
       
      LET l_dzaj.dzaj001 = l_dzaa.dzaa001
      LET l_dzaj.dzaj002 = l_dzaa.dzaa003
      LET l_dzaj.dzaj003 = l_dzaa.dzaa004
      LET l_dzaj.dzaj004 = l_dzaa.dzaa006                 #使用標示
      LET l_dzaj.dzaj005 = p_field.dzaj005.toString()     #多語言欄位依附控件名稱

      SELECT COUNT(*) INTO l_cnt FROM dzaj_t 
        WHERE dzaj001 = l_dzaj.dzaj001
          AND dzaj002 = l_dzaj.dzaj002
          AND dzaj003 = l_dzaj.dzaj003
          AND dzaj004 = l_dzaj.dzaj004
      IF l_cnt = 0 THEN
         #取得多語言欄位相關設定
         SELECT * INTO l_dzer.* FROM dzer_t 
           WHERE dzer001 = p_field.sqlTabName
             AND dzer002 = p_field.colName
             AND dzer003 = 1

         LET l_dzaj.dzaj007 = l_dzer.dzer004  
         LET l_dzaj.dzaj008 = l_dzer.dzer005  
         LET l_dzaj.dzaj009 = l_dzer.dzer006  
         LET l_dzaj.dzaj010 = l_dzer.dzer008
         LET l_dzaj.dzaj011 = l_dzer.dzer007 
         LET l_dzaj.dzaj012 = l_dzaa.dzaa010 
         
         INSERT INTO dzaj_t(dzaj001, dzaj002, dzaj003, dzaj004, dzaj005,
                            dzaj007, dzaj008, dzaj009, dzaj010, dzaj011, 
                            dzaj012, 
                            dzajmodid, dzajmoddt, dzajownid, dzajowndp, dzajcrtid,
                            dzajcrtdp, dzajcrtdt, dzajstus)
           VALUES (l_dzaj.dzaj001, l_dzaj.dzaj002, l_dzaj.dzaj003, l_dzaj.dzaj004, l_dzaj.dzaj005,
                   l_dzaj.dzaj007, l_dzaj.dzaj008, l_dzaj.dzaj009, l_dzaj.dzaj010, l_dzaj.dzaj011, 
                   l_dzaj.dzaj012, 
                   g_dzfq_m.dzfqmodid, g_dzfq_m.dzfqmoddt, g_dzfq_m.dzfqownid, g_dzfq_m.dzfqowndp, g_dzfq_m.dzfqcrtid, 
                   g_dzfq_m.dzfqcrtdp, g_dzfq_m.dzfqcrtdt, g_dzfq_m.dzfqstus)  
      END IF
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  SQLCA.sqlcode
         LET g_errparam.extend = "ins dzaj_t "
         LET g_errparam.popup = TRUE
         CALL cl_err()
         ROLLBACK WORK
         RETURN FALSE
      END IF
   END IF
         
   ###設計點類型:8(助記碼設定檔)###
   IF NOT cl_null(p_field.mnemField) THEN       
      LET l_dzak.dzak001 = p_prog                         #程式代號
      LET l_dzak.dzak002 = p_dzac003                      #控件編號
      LET l_dzak.dzak003 = p_design_version               #識別碼版次
      LET l_dzak.dzak004 = g_dzaa006                        #使用標示

      SELECT COUNT(*) INTO l_cnt FROM dzak_t 
        WHERE dzak001 = l_dzak.dzak001
          AND dzak002 = l_dzak.dzak002
          AND dzak003 = l_dzak.dzak003
          AND dzak004 = l_dzak.dzak004
      IF l_cnt = 0 THEN
         #取得助記碼相關設定
         SELECT * INTO l_dzet.* FROM dzet_t 
           WHERE dzet001 = p_field.sqlTabName
             AND dzet002 = p_field.colName

         #140306:助記碼規格變動
         #LET l_dzak.dzak005 = ""                         #No Use
         #LET l_dzak.dzak007 = l_dzet.dzet003
         #LET l_dzak.dzak008 = l_dzet.dzet004  
         #LET l_dzak.dzak009 = l_dzet.dzet005
         #LET l_dzak.dzak010 = l_dzet.dzet007
         #LET l_dzak.dzak011 = l_dzet.dzet006
         LET l_dzak.dzak005 = l_dzet.dzet007              #其他條件
         LET l_dzak.dzak007 = l_dzet.dzet004              #助記碼搜尋欄位
         LET l_dzak.dzak008 = l_dzet.dzet003              #助記碼Table
         LET l_dzak.dzak009 = l_dzet.dzet005              #助記碼欄位
         LET l_dzak.dzak010 = l_dzet.dzet006              #助記碼語系
         LET l_dzak.dzak011 = ""                          #回傳對應控件
         LET l_dzak.dzak012 = g_dzaa010                   #客戶代號
         
         INSERT INTO dzak_t(dzak001, dzak002, dzak003, dzak004, dzak005,
                            dzak007, dzak008, dzak009, dzak010, dzak011, 
                            dzak012, 
                            dzakmodid, dzakmoddt, dzakownid, dzakowndp, dzakcrtid,
                            dzakcrtdp, dzakcrtdt, dzakstus)
           VALUES (l_dzak.dzak001, l_dzak.dzak002, l_dzak.dzak003, l_dzak.dzak004, l_dzak.dzak005,
                   l_dzak.dzak007, l_dzak.dzak008, l_dzak.dzak009, l_dzak.dzak010, l_dzak.dzak011, 
                   l_dzak.dzak012, 
                   g_dzfq_m.dzfqmodid, g_dzfq_m.dzfqmoddt, g_dzfq_m.dzfqownid, g_dzfq_m.dzfqowndp, g_dzfq_m.dzfqcrtid, 
                   g_dzfq_m.dzfqcrtdp, g_dzfq_m.dzfqcrtdt, g_dzfq_m.dzfqstus)   
      END IF
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  SQLCA.sqlcode
         LET g_errparam.extend = "ins dzak_t "
         LET g_errparam.popup = TRUE
         CALL cl_err()
         ROLLBACK WORK
         RETURN FALSE
      END IF
   END IF

   ###設計點類型:9(程式串查設計表)###
   #單身沒有設置串查功能,不用給串查tsd資料
   IF (NOT (g_dzfq_m.dzfq012 = "N" AND p_structure = g_detail)) OR (g_dzfq_m.cbo_progtype = "Q" OR g_dzfq_m.cbo_progtype = "P") THEN
      IF NOT cl_null(p_field.dzep020) AND p_field.dzal002 IS NOT NULL THEN
         LET l_dzal.dzal001 = p_prog                         #程式代號(l_dzaa.dzaa001)
         LET l_dzal.dzal002 = p_field.dzal002.toString()     #串查欄位的控件名稱(l_dzaa.dzaa003)
         LET l_dzal.dzal003 = p_design_version               #設計點版本(l_dzaa.dzaa004)
         LET l_dzal.dzal004 = g_dzaa006                        #使用標示(l_dzaa.dzaa006)
         LET l_dzal.dzal005 = p_field.dzal005.toString()     #依附控件名稱
         LET l_dzal.dzal006 = p_field.dzep020 CLIPPED        #程式參考設定
         LET l_dzal.dzal007 = p_field.dzep022 CLIPPED        #串查型態
         LET l_dzal.dzal008 = 1                              #項次 
         LET l_dzal.dzal009 = g_dzaa010                      #客戶代號
         LET l_dzal.dzalstus = g_dzfq_m.dzfqstus
       
         SELECT COUNT(*) INTO l_cnt FROM dzal_t 
           WHERE dzal001 = l_dzal.dzal001
             AND dzal002 = l_dzal.dzal002
             AND dzal003 = l_dzal.dzal003
             AND dzal004 = l_dzal.dzal004
         IF l_cnt = 0 THEN            
            INSERT INTO dzal_t(dzal001, dzal002, dzal003, dzal004, dzal005,
                               dzal006, dzal007, dzal008, dzal009, 
                               dzalmodid, dzalmoddt, dzalownid, dzalowndp, dzalcrtid,
                               dzalcrtdp, dzalcrtdt, dzalstus)
              VALUES (l_dzal.dzal001, l_dzal.dzal002, l_dzal.dzal003, l_dzal.dzal004, l_dzal.dzal005,
                      l_dzal.dzal006, l_dzal.dzal007, l_dzal.dzal008, l_dzal.dzal009, 
                      g_dzfq_m.dzfqmodid, g_dzfq_m.dzfqmoddt, g_dzfq_m.dzfqownid, g_dzfq_m.dzfqowndp, g_dzfq_m.dzfqcrtid, 
                      g_dzfq_m.dzfqcrtdp, g_dzfq_m.dzfqcrtdt, g_dzfq_m.dzfqstus)  
         END IF
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  SQLCA.sqlcode
            LET g_errparam.extend = "ins dzal_t "
            LET g_errparam.popup = TRUE
            CALL cl_err()
            ROLLBACK WORK
            RETURN FALSE
         END IF
      END IF
   END IF
   
   RETURN TRUE
END FUNCTION

#+ 在Tree domNode中增加欄位節點的前置作業
PRIVATE FUNCTION sadzp168_tree_add_field_pre(p_spage, p_container_node)
   DEFINE p_spage             type_g_page_info
   DEFINE p_container_node    om.DomNode       #要將設計資料新增在那一個結構類型[container]下
   
   DEFINE l_tree_node    om.DomNode            #Tree node
   DEFINE l_tree_before  om.DomNode            #新增的欄位node要增加在那個節點之前
   DEFINE l_sr_node      om.DomNode            #原公版的sr node
   DEFINE l_sr_before    om.DomNode            #要新增的欄位,準備新增在那個sr node子節點之前
   DEFINE l_add_done     LIKE type_t.chr1      #是否已經做過欄位新增
   DEFINE l_posX         LIKE type_t.num10     #目前元件X軸位置
   #DEFINE l_posY         LIKE type_t.num10     #目前元件X軸位置
   DEFINE l_tree_width   LIKE type_t.num10     #Tree用到的總width
   DEFINE l_tree_height  LIKE type_t.num10
   DEFINE l_grid_width   LIKE type_t.num10
   DEFINE l_child_count  LIKE type_t.num10     #table容器子節點總個數
   DEFINE l_table_name   LIKE dzeb_t.dzeb001   #資料表名稱 
   DEFINE l_page_name       STRING                   #Tree結構的上層Page點名稱
   
   LET l_tree_width = 0
   LET l_posX = 0
   LET l_child_count = 0
   LET l_add_done = "N"

   #todo:樣版中browse的Tree結構上層並沒有利用一個Page container框住
   #所以adzp168所傳過來的設計資料,Page點名稱為"No page"
   LET l_page_name = "No page"

   #取得資料表名稱,準備讓共用欄位設置sqlTabName等屬性使用
   #固定取得此record陣列的第一筆紀錄為基礎資料表:p_spage.sfield[1].sqlTabName
   #todo:萬一整個陣列的欄位不來自於同一個table時?
   LET l_table_name = p_spage.sfield[1].sqlTabName CLIPPED

   #取得設計資料要新增在那個結構類型(container)下的node節點位置
   LET l_tree_node = p_container_node

   #因為在4fd上Tree widget會搭配Screen Records出現
   #所以這裡順便找sr node的節點位置
   LET l_sr_node = sadzp168_2_get_domNode(g_template_node, "Record", "name", l_tree_node.getAttribute("name"))
   
   #找出目前新增欄位結構要新增在那個節點前
   LET l_tree_before = l_tree_node.getFirstChild()
   WHILE l_tree_before IS NOT NULL
      IF NOT cl_null(l_tree_before.getAttribute("posX") CLIPPED) THEN
         #目前欄位的X軸位置
         LET l_posX = l_tree_before.getAttribute("posX")
      END IF

      #計算下一個欄位啟始X軸位置和統計Tree已用掉的總寬度,exp:Phantom(widget)沒有高度和寬度的設置
      IF NOT cl_null(l_tree_before.getAttribute("gridWidth")) THEN
         LET l_grid_width = l_tree_before.getAttribute("gridWidth")
      
         #下一個欄位的X軸位置
         LET l_posX = l_posX + l_grid_width
         LET l_tree_width = l_tree_width + l_grid_width
      END IF

      LET l_tree_before = l_tree_before.getNext()
   END WHILE

   #當Tree的欄位採直接新增方式,上面的WHILE迴圈應該就不會採插入方式新增過欄位
   IF l_add_done = "N" THEN
      #直接新增,就不採插入方式,所以將插入點的Node INITIALIZE
      INITIALIZE l_tree_before TO NULL
      INITIALIZE l_sr_before TO NULL
      CALL sadzp168_tree_add_field(p_spage.*, l_tree_node, l_tree_before, l_sr_node, l_sr_before, l_posX, l_tree_width)
         RETURNING l_posX, l_grid_width  
         
      LET l_add_done = "Y"
      LET l_tree_width = l_tree_width + l_grid_width
   END IF
   
   #所以重新調整Table和VBox等相關容器的寬度,避免編譯失敗
   #Tree容器的寬度 = 已用寬度 + 欄位個數 + 1
   LET l_child_count = l_tree_node.getChildCount()
   LET l_tree_width = l_tree_width + l_child_count + 2
   CALL l_tree_node.setAttribute("gridWidth", l_tree_width)

   LET l_tree_height = l_tree_node.getAttribute("gridHeight")
   
   CALL sadzp168_container_resize(l_tree_node, l_tree_width, l_tree_height)
END FUNCTION

#+ 在Tree domNode中增加欄位點資訊
PRIVATE FUNCTION sadzp168_tree_add_field(p_spage, p_tree_node, p_tree_before, p_sr_node, p_sr_before, p_posX, p_tree_width)
   DEFINE p_spage           type_g_page_info
   DEFINE p_tree_node       om.DomNode            #原公版的tree node
   DEFINE p_tree_before     om.DomNode            #要新增的欄位,準備新增在那個子節點之前
   DEFINE p_sr_node         om.DomNode            #原公版的sr node
   DEFINE p_sr_before       om.DomNode            #要新增的欄位,準備新增在那個sr node子節點之前
   DEFINE p_posX            LIKE type_t.num10     #下一個欄位元件X軸位置
   DEFINE p_tree_width      LIKE type_t.num10     #統計table用到的總width

   DEFINE l_new_child       om.DomNode            #新增欄位的子節點
   DEFINE l_level3          LIKE type_t.num5
   DEFINE l_widget          STRING                #新增欄位的控件樣式
   DEFINE l_widget_height   LIKE type_t.num10
   DEFINE l_widget_width    LIKE type_t.num10
   DEFINE l_posY            LIKE type_t.num10     #下一個欄位元件Y軸位置
   DEFINE l_sr_child        om.DomNode            #要新增的欄位
   DEFINE l_field_type      LIKE type_t.chr1      #新欄位的fieldType
   DEFINE l_str             STRING
   DEFINE l_ref_name        STRING                #欄位的widget name
   DEFINE l_node_r          om.DomNode
   DEFINE l_dzek002         LIKE dzek_t.dzek002   #欄位代號
   
   #單頭searchcol items項目先清空
   LET g_searchcol_items = ""

   #Tree內的欄位Y軸都定義為0 
   LET l_posY = 0

   #todo:目前因為Tree都屬於s_browse結構,先假定欄位皆為COLUMN_LIKE型態
   LET l_field_type = g_column_like
   
   IF p_tree_node IS NOT NULL THEN     #樹狀(tree)
      #處理要新增的欄位
      FOR l_level3 = 1 TO p_spage.sfield.getLength()
         #create欄位歸屬widget(dzep010)子節點
         LET l_widget = sadzp168_get_widget(p_spage.sfield[l_level3].dzej003)

         #取得狀態碼widget樣式
         IF p_spage.sfield[l_level3].dzeb022 = "cdfStatus" THEN
            #狀態碼欄位widget型態規則:B + SCC選項Y/N就產生CheckBox，其他都做ComboBox
            LET l_widget = sadzp168_get_stus_widget(p_spage.sfield[l_level3].sqlTabName, p_spage.sfield[l_level3].colName, p_spage.sfield[l_level3].dzej003)
         END IF
         
         LET l_new_child = p_tree_node.createChild(l_widget.trim()) 

         #設置widget屬性
         CALL sadzp168_set_common_attr(p_spage.sfield[l_level3].*, l_new_child, l_field_type, l_widget, p_posX, l_posY)
            RETURNING l_widget_height, l_widget_width

         #記錄欄位真正顯示控件
         LET p_spage.sfield[l_level3].widget = base.StringBuffer.create()
         LET l_str = l_new_child.getAttribute("widget")
         CALL p_spage.sfield[l_level3].widget.append(l_str.trim())
      
         #記錄欄位真正顯示控件代號
         LET p_spage.sfield[l_level3].widgetName = base.StringBuffer.create()
         LET l_str = l_new_child.getAttribute("name")
         CALL p_spage.sfield[l_level3].widgetName.append(l_str.trim())
      
         #計算目前已用到多少寬度
         LET p_tree_width = p_tree_width + l_widget_width
         #下一個欄位點的X軸位置 
         LET p_posX = p_posX + l_widget_width   

         IF p_tree_before IS NOT NULL THEN
            #插入欄位子節點在tree node中
            CALL p_tree_node.insertBefore(l_new_child, p_tree_before)
         END IF

         ############處理Screen Records##############################
         LET l_sr_child = p_sr_node.createChild("RecordField")

         #設置新sr child node的屬性
         CALL sadzp168_set_sr_attr(l_sr_child, l_new_child.getAttribute("sqlTabName") CLIPPED, l_new_child.getAttribute("colName") CLIPPED, l_new_child.getAttribute("name") CLIPPED, l_field_type)

         IF p_sr_before IS NOT NULL THEN
            #把新增欄位的子節點插入在 sr node中
            CALL p_sr_node.insertBefore(l_sr_child, p_sr_before)
         END IF
         ###########################################################

         ############記錄串查欄位控件和依附控件設定########################
         #Q類作業需實際新增一個欄位串查
         IF (NOT cl_null(p_spage.sfield[l_level3].dzep020)) AND g_dzfq_m.cbo_progtype = "Q" THEN
            #記錄串查欄位所依附欄位的控件名稱
            LET p_spage.sfield[l_level3].dzal005 = base.StringBuffer.create()
            LET l_str = l_new_child.getAttribute("name")
            CALL p_spage.sfield[l_level3].dzal005.append(l_str)

            #串查欄位命名,只需欄位前名稱加上'url_', exp:dzea001=> url_dzea001;
            LET l_ref_name = l_new_child.getAttribute("name") CLIPPED

            #加入串查欄位
            CALL sadzp168_table_add_url(p_tree_node, l_new_child, p_sr_node, l_ref_name, p_posX, l_posY)
               RETURNING l_widget_width, l_widget_height, l_str

            LET l_ref_name = l_str.trim()                      #記錄串查欄位控件名稱
            LET p_tree_width = p_tree_width + l_widget_width   #計算目前已用到多少寬度   
            LET p_posX = p_posX + l_widget_width                 #下一個欄位點的X軸位置

            #記錄串查欄位的控件名稱
            LET p_spage.sfield[l_level3].dzal002 = base.StringBuffer.create()
            CALL p_spage.sfield[l_level3].dzal002.append(l_ref_name)
         END IF
         ############################################################
         
         ############處理reference欄位################################
         IF g_dzfq_m.cbo_progtype = "Q" AND (NOT cl_null(p_spage.sfield[l_level3].refField)) THEN
            INITIALIZE l_node_r TO NULL
            
            #記錄參考欄位所依附欄位的控件名稱
            LET p_spage.sfield[l_level3].dzai005 = base.StringBuffer.create()
            LET l_str = l_new_child.getAttribute("name")
            CALL p_spage.sfield[l_level3].dzai005.append(l_str)
            
            #TABLE_COLUMN reference欄位命名,只需欄位名稱加上'_desc', exp:dzea_t.dzea001=> dzea001_desc
            IF l_field_type = g_table_column THEN
               LET l_ref_name = p_spage.sfield[l_level3].colName CLIPPED
            ELSE
               LET l_ref_name = l_new_child.getAttribute("name") CLIPPED
            END IF
            
            #加入reference欄位
            CALL sadzp168_add_reference(p_tree_node, p_tree_before, p_sr_node, p_sr_before, l_ref_name.trim(), p_spage.sfield[l_level3].refField, p_posX, l_posY)
               RETURNING l_widget_width, l_widget_height, l_node_r 
         
            #公用欄位的reference欄位,單身title屬性也可以統一名稱(ex:ownid_desc)
            IF NOT cl_null(l_dzek002) THEN
               CALL l_node_r.setAttribute("title", l_dzek002 CLIPPED || "_desc")
            END IF
            
            #記錄參考欄位的控件名稱
            LET p_spage.sfield[l_level3].dzai002 = base.StringBuffer.create()
            LET l_ref_name = l_node_r.getAttribute("name") CLIPPED
            CALL p_spage.sfield[l_level3].dzai002.append(l_ref_name)
            
            LET p_tree_width = p_tree_width + l_widget_width   #計算目前已用到多少寬度   
            LET p_posX = p_posX + l_widget_width               #下一個欄位點的X軸位置
         END IF
         ###########################################################

         
         #含有s_browse的樣版,需紀錄searchcol comboBox下可以提供查詢的[欄位]Items項目
         IF cl_null(g_searchcol_items.trim()) THEN
            LET g_searchcol_items = p_spage.sfield[l_level3].colName CLIPPED
         ELSE
            LET g_searchcol_items = g_searchcol_items, ",", p_spage.sfield[l_level3].colName CLIPPED
         END IF
      END FOR
   END IF

   IF g_dzfq_m.cbo_progtype <> "Q" THEN
      #樣版有s_browse時,searchcol(comboBox)的元件需新增可以提供查詢的[欄位]子項目有那些
      CALL sadzp168_searchcol_add_items()
   END IF

   RETURN p_posX, p_tree_width 
END FUNCTION

#+ 在s_browse searchcol中增加查詢的Item子項目
PRIVATE FUNCTION sadzp168_searchcol_add_items()
   DEFINE l_searchcol_node    om.DomNode            #樣版上searchcol的comboBox node
   DEFINE l_child_node        om.DomNode
   DEFINE l_tok               base.StringTokenizer
   DEFINE l_tag               LIKE dzfh_t.dzfh004   #要尋找節點的tag名稱
   DEFINE l_name              LIKE dzfh_t.dzfh005   #要尋找tag的name名稱
   DEFINE l_str               STRING
   DEFINE l_items             STRING                #comboBox下items屬性值

   INITIALIZE l_searchcol_node TO NULL
   LET l_items = ""
   
   #增加樣版上cbo_searchcol 的items子項目
   
   #4fd樣版公用欄位的xml tag名稱
   LET l_tag = "ComboBox"
   #4fd樣版公用欄位的xml name名稱
   LET l_name = "cbo_searchcol"
   #取得在樣版中searchcol(comboBox) node
   LET l_searchcol_node = sadzp168_2_get_domNode(g_template_node, l_tag, "name", l_name)

   #樣版上沒有searchcol(comboBox)項目,則不需要做此FUNCTION items子項目的新增
   IF l_searchcol_node IS NULL THEN
      RETURN
   END IF
   
   #取得searchcol(comboBox)裡已有的Items項目屬性值
   LET l_items = l_searchcol_node.getAttribute("items")
   
   #g_searchcol_items字串組合應在browser時已處理過
   #g_searchcol_items值為browser的欄位ID組合,各欄位以逗號隔開.exp:gzza001,gzza002,gzza003
   IF NOT cl_null(g_searchcol_items.trim()) THEN
      #取得searchcol(comboBox)下可以提供查詢的各[欄位]子項目
      LET l_tok = base.StringTokenizer.create(g_searchcol_items.trim(), ",")
      WHILE l_tok.hasMoreTokens()
         LET l_str = l_tok.nextToken()

         #建立Items子項目
         LET l_child_node = l_searchcol_node.createChild("Item")
         CALL l_child_node.setAttribute("lstrtext", "true")
         CALL l_child_node.setAttribute("name", l_str.trim())

         LET l_str = "lbl_", l_str
         CALL l_child_node.setAttribute("text", l_str)

         IF cl_null(l_items) THEN
            LET l_items = l_str.trim()
         ELSE
            LET l_items = l_items, ", ", l_str.trim()
         END IF
      END WHILE

      IF cl_null(l_items) THEN
         DISPLAY "Any fields of s_browse are set." 
         RETURN
      END IF
         
      #設定comboBox下items屬性值
      CALL l_searchcol_node.setAttribute("items", l_items)
   END IF   
END FUNCTION

#+ 多Container時,新增單頭/單身結構類型所需要的公版snippet
PRIVATE FUNCTION sadzp168_add_container_snippet(p_dzfm006, p_level1_node, p_folder, p_level1)
   DEFINE p_dzfm006         LIKE dzfm_t.dzfm006     #結構點類型
   DEFINE p_level1_node     om.DomNode              #在主結構點下的最後一個[第一階層設計結構點(如:Folder)]
   #DEFINE p_structure_node  om.DomNode              #單身結構點(vb_detail)
   DEFINE p_folder          type_g_folder
   DEFINE p_level1          LIKE type_t.num5        #第一階層設計資料順序
   
   DEFINE l_snippet_file    STRING                  #切片檔案名稱
   DEFINE l_sr_node         om.DomNode              #Table的Screen Record節點
   DEFINE l_table_node      om.DomNode              #Table(container)的節點
   DEFINE l_sr_node_list    om.NodeList             #Table(container)的sr節點
   DEFINE l_i               LIKE type_t.num5
   DEFINE l_name            STRING
   DEFINE l_posX            LIKE type_t.num10       #切片X軸位置
   DEFINE l_posY            LIKE type_t.num10       #切片Y軸位置
   #DEFINE l_level1_node     om.DomNode              #第一階層設計結構點(如:Folder)
   DEFINE l_level1_parent   om.DomNode              #第一階層設計結構點的父節點
   
   DEFINE r_node            om.DomNode
   
   INITIALIZE r_node TO NULL
   INITIALIZE l_sr_node TO NULL
   
   #第一階層設計結構點不存在
   IF p_level1_node IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00072"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] =  p_dzfm006 CLIPPED
      CALL cl_err()
      RETURN r_node
   END IF
  
   #依結構代號不同,加入樣版檔公版所需要的snippet檔
   CASE p_dzfm006
      WHEN g_master     #單頭"vb_master" 
         LET l_snippet_file = "master_", g_dzfq_m.dzfq007 CLIPPED, ".snippet"
               
      WHEN g_detail     #單身"vb_detail" 
         #單身可分Table和ScrollGrid二種
         #利用剛運行完新增欄位的container_node來辨識單身目前為何種container型式
         IF p_level1_node.getTagName() = "Group" THEN
            #Q類版型--有Group裡放Table/Tree元件
            IF g_container_node_t.getTagName() = "Tree" THEN
               LET l_snippet_file = "detail_Group_Tree.snippet"
            ELSE
               LET l_snippet_file = "detail_Group_Table.snippet"
            END IF
         ELSE
            ####一般版型Folder/Page結構
            ###IF g_container_node_t.getTagName() = "ScrollGrid" THEN
            ###   LET l_snippet_file = "detail_Folder_ScrollGrid.snippet"
            ###ELSE
            ###   LET l_snippet_file = "detail_Folder_Table.snippet"
            ###END IF
            #一般版型Folder/Page結構
            CASE g_container_node_t.getTagName()
               WHEN "ScrollGrid"
                  LET l_snippet_file = "detail_Folder_ScrollGrid.snippet"
                  
               WHEN "Tree"
                  LET l_snippet_file = "detail_Folder_Tree.snippet"
                  
               OTHERWISE
                  LET l_snippet_file = "detail_Folder_Table.snippet"
            END CASE
         END IF
         
      WHEN g_detailexp  #單身鎖定"vb_detailexp"
         LET l_snippet_file = "detailexp_Folder.snippet"
      
   END CASE

   #取得原level1結構設計點的父節點,方便在這個父節點下加入單身小切片(新的container)
   LET l_level1_parent = p_level1_node.getParent()
   
   #取得單頭/單身小切片檔
   LET r_node = sadzp168_load_snippet_file(l_level1_parent, l_snippet_file)

   IF r_node IS NULL THEN
      INITIALIZE r_node TO NULL
      RETURN r_node
   END IF

   #Q類公版切片--Tree裡的子節點加上tag="tree_clone"(以利複製)
   CALL sadzp168_tree_init(r_node, "", "1")
  
   #調整單身小切片檔在畫面的x, y軸位置
   CASE l_level1_parent.getTagName()
      WHEN "HBox"
         LET l_posX = p_level1_node.getAttribute("posX") + p_level1_node.getAttribute("gridWidth") 
         LET l_posY = p_level1_node.getAttribute("posY") 

      WHEN "VBox"
         LET l_posX = p_level1_node.getAttribute("posX") 
         LET l_posY = p_level1_node.getAttribute("posY") + p_level1_node.getAttribute("gridHeight")
         
   END CASE

   IF (NOT cl_null(l_posX)) AND (NOT cl_null(l_posY)) THEN 
      CALL r_node.setAttribute("posX", l_posX)
      CALL r_node.setAttribute("posY", l_posY)
      CALL r_node.setAttribute("gridWidth", p_level1_node.getAttribute("gridWidth"))
      CALL r_node.setAttribute("gridHeight", p_level1_node.getAttribute("gridHeight"))
   END IF
   
   #依序變更container名稱,避免命名重覆
   CALL sadzp168_container_rename(r_node, p_folder, p_level1)

   #####新增Table的Screen Record節點#####
   #取得樣版切片檔中有多少個Table/ScrollGrid(container)元件
   LET l_sr_node_list = r_node.selectByTagName(g_dzfq_m.dzfq010)

   IF l_sr_node_list.getLength() < 0 THEN
      #檢查該Table相對應的SR節點是否存在
      FOR l_i = 1 to l_sr_node_list.getLength()
         LET l_table_node = l_sr_node_list.item(l_i)
         LET l_name = l_table_node.getAttribute("name")

         #尋找SR節點是否已存在樣版中
         LET l_sr_node = sadzp168_2_get_domNode(g_template_node, "Record", "name", l_name)

         #SR節點不存在時,新增此節點   
         IF l_sr_node IS NULL THEN
            LET l_sr_node = sadzp168_add_sr_structure(g_template_node, l_name)
         END IF

         #處理切片檔中有些widget需要在Screen Record增加一個子節點
         CALL sadzp168_add_template_sr_node(l_table_node)
      END FOR
   ELSE
      #處理單頭切片檔中有些widget需要在Screen Record增加一個子節點
      CALL sadzp168_add_template_sr_node(r_node)
   END IF
   
   RETURN r_node
END FUNCTION

#+ 變更切片檔container命名
PRIVATE FUNCTION sadzp168_container_rename(p_domNode, p_folder, p_level1)
   DEFINE p_domNode         om.DomNode
   DEFINE p_folder          type_g_folder
   DEFINE p_level1          LIKE type_t.num5        #第一階層設計資料順序
   
   DEFINE l_name            STRING   #container/widget name屬性值
   DEFINE l_is_done         LIKE type_t.chr1
   DEFINE l_parent_node     om.DomNode
   DEFINE l_str             STRING

   INITIALIZE l_parent_node TO NULL
   
   LET l_name = ""
   LET l_is_done = FALSE
   
   #取得此節點"l_name"的屬性值
   LET l_name = p_domNode.getAttribute("name")

   #新增加的Container是可以在Spce Designer刪除的
   IF p_domNode.getAttribute("tag") = "CantDel" THEN
      CALL p_domNode.setAttribute("tag", "")
   END IF
   
   #container/widget 在4fd上的命名都只能為一
   #變更切片檔container命名(節點的name屬值)
   IF NOT cl_null(l_name) THEN
      IF NOT l_is_done THEN
         CASE p_domNode.getTagName()   #IF p_domNode.getTagName() = p_folder[1].container
            WHEN "Folder"
               CALL p_domNode.setAttribute("name", p_folder[p_level1].sfolder.trim())
            
            WHEN "Page"
               CALL p_domNode.setAttribute("name", p_folder[p_level1].spage[1].spage CLIPPED)
               #CALL p_domNode.setAttribute("text", p_folder[p_level1].spage[1].spage CLIPPED)
               
               #11/28 決議:避免主程式,子程式,子畫面的多語言在控件同名的前提下,更改Page的text增加程式編號
               IF p_folder[p_level1].spage[1].spage = "page_info_1" THEN
                  CALL p_domNode.setAttribute("text", p_folder[p_level1].spage[1].spage CLIPPED)
               ELSE
                  LET l_str = p_folder[p_level1].spage[1].spage CLIPPED, ".", g_dzfq_m.dzfq004 CLIPPED
                  CALL p_domNode.setAttribute("text", l_str.trim())
               END IF

            WHEN "Table"
               CALL p_domNode.setAttribute("name", p_folder[p_level1].spage[1].stable CLIPPED)

            WHEN "Tree"
               CALL p_domNode.setAttribute("name", p_folder[p_level1].spage[1].stable CLIPPED)

            WHEN "ScrollGrid"
               CALL p_domNode.setAttribute("name", p_folder[p_level1].spage[1].stable CLIPPED)

            WHEN "Phantom"
               LET l_name = p_domNode.getAttribute("name"), "_gen", g_num USING "<<<<<"  
               LET g_num = g_num + 1

               #Tree父/子 ...等:節點關係屬性設置
               LET l_parent_node = p_domNode.getParent()
               IF l_parent_node.getTagName() = "Tree" THEN
                  CASE p_domNode.getAttribute("name")
                     WHEN "exp"
                        CALL l_parent_node.setAttribute("expandedColumn", l_name.trim())
                               
                     WHEN "id"
                        CALL l_parent_node.setAttribute("idColumn", l_name.trim())
                               
                     WHEN "isnode"
                        CALL l_parent_node.setAttribute("isNodeColumn", l_name.trim())
                           
                     WHEN "pid"
                        CALL l_parent_node.setAttribute("parentIdColumn", l_name.trim())
                  END CASE
               END IF

               CALL p_domNode.setAttribute("name", l_name.trim())
               
            OTHERWISE
               LET l_name = p_domNode.getAttribute("name"), "_gen", g_num USING "<<<<<"  
               LET g_num = g_num + 1
               CALL p_domNode.setAttribute("name", l_name.trim())
         END CASE
      END IF
   END IF

   #控制權移到其第一個子節點
   LET p_domNode = p_domNode.getFirstChild()

   #若節點為空則不再進行遞迴
   WHILE p_domNode IS NOT NULL   
      CALL sadzp168_container_rename(p_domNode, p_folder, p_level1)
         
      #控制權移到下一個同層的節點
      LET p_domNode = p_domNode.getNext()   
   END WHILE
END FUNCTION

#+ 在公用欄位頁籤中增加欄位點資訊的前置作業
PRIVATE FUNCTION sadzp168_common_add_field_pre(p_structure, p_spage, p_node)
   DEFINE p_structure         STRING                #樣版所定義的結構類型名稱
   DEFINE p_spage             type_g_page_info
   DEFINE p_node              om.DomNode            #公用欄位切片的domNode

   #DEFINE l_container_node    om.DomNode            #可新增公用欄位節點的domNode
   DEFINE l_sr_node           om.DomNode            #公版所屬的sr node
   DEFINE l_level3            LIKE type_t.num5
   DEFINE l_posX_start        LIKE type_t.num10     #每一排元件X軸啟始位置
   DEFINE l_posY_start        LIKE type_t.num10     #每一排元件Y軸啟始位置
   DEFINE l_widget_width      LIKE type_t.num10
   DEFINE l_widget_height     LIKE type_t.num10
   
   DEFINE l_master_node  RECORD
                uib           om.DomNode,           #單頭[資料歸屬]公用欄位節點的domNode
                uis           om.DomNode            #單頭[資料狀態資訊]新增公用欄位節點的domNode 
             END RECORD
   DEFINE l_posX         RECORD
                uib           LIKE type_t.num10,    #[資料歸屬]下一個欄位元件X軸位置
                uis           LIKE type_t.num10     #[資料狀態資訊]下一個欄位元件X軸位置
             END RECORD
   DEFINE l_posY         RECORD
                uib           LIKE type_t.num10,    #[資料歸屬]下一個欄位元件Y軸位置
                uis           LIKE type_t.num10     #[資料狀態資訊]下一個欄位元件Y軸位置
             END RECORD
   DEFINE l_posX_max     RECORD
                uib           LIKE type_t.num10,    #[資料歸屬]grid元件已用最大寬度
                uis           LIKE type_t.num10     #[資料狀態資訊]grid元件已用最大寬度
             END RECORD
   DEFINE l_posY_max     RECORD
                uib           LIKE type_t.num10,    #[資料歸屬]grid元件已用最大高度
                uis           LIKE type_t.num10     #[資料狀態資訊]grid元件已用最大高度
             END RECORD
   DEFINE l_container_height  RECORD
                uib              LIKE type_t.num10, #[資料歸屬]上層父節點container已用高度
                uis              LIKE type_t.num10  #[資料狀態資訊]上層父節點container已用高度
             END RECORD
   DEFINE l_container_width   RECORD
                uib              LIKE type_t.num10, #[資料歸屬]上層父節點container已用寬度
                uis              LIKE type_t.num10  #[資料狀態資訊]上層父節點container已用寬度
             END RECORD
   
   INITIALIZE l_master_node.uib TO NULL
   INITIALIZE l_master_node.uis TO NULL

   #取得可新增公用欄位container node
   CASE p_structure
      WHEN g_master
         LET l_master_node.uib = sadzp168_get_container_position(p_node, "insUIB")
         LET l_master_node.uis = sadzp168_get_container_position(p_node, "insUIS")
         LET l_sr_node = sadzp168_get_master_sr_domNode()
         
      WHEN g_detail
         #單身可分Table和ScrollGrid二種
         IF p_spage.child_node = "ScrollGrid" THEN
            IF NOT sadzp168_scrollgrid_add_field_pre(p_spage.*, p_node) THEN
               RETURN FALSE
            END IF
         ELSE
            CALL sadzp168_table_add_field_pre(p_spage.*, p_structure, p_node)
         END IF
         RETURN TRUE
   END CASE

   #找不到可新增欄位的結構點
   IF l_master_node.uib IS NULL OR l_master_node.uis IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00134"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF

   #預設單頭欄位的啟始位置
   LET l_posX_start = 1
   LET l_posY_start = 0
   LET l_container_width.uib = 0 
   LET l_container_height.uib = 0
   LET l_container_width.uis = 0 
   LET l_container_height.uis = 0
   
   LET l_posX.uib = l_posX_start 
   LET l_posY.uib = l_posY_start
   LET l_posX.uis = l_posX_start 
   LET l_posY.uis = l_posY_start
   LET l_posX_max.uib = l_posX.uib
   LET l_posY_max.uib = l_posY.uib
   LET l_posX_max.uis = l_posX.uis
   LET l_posY_max.uis = l_posY.uis
   
   #處理要新增的欄位
   FOR l_level3 = 1 TO p_spage.sfield.getLength()
      #決定公用欄位隸屬的群組(Group container)
      CASE p_spage.sfield[l_level3].dzek001
         WHEN "grpUIBelong"
            #處理公用欄位折行(新增一個新的grid),在function get_dzfr_data已處理判斷公用欄位是否需折行
            IF p_spage.sfield[l_level3].dzekWarp THEN
               #計算父節點container目前已用到多少寬度/高度
               LET l_container_width.uib = l_container_width.uib + l_master_node.uib.getAttribute("gridWidth")
               
               IF l_container_height.uib < l_master_node.uib.getAttribute("gridHeight") THEN
                  LET l_container_height.uib = l_master_node.uib.getAttribute("gridHeight")
               END IF
               
               #元件換行時需新增一grid,且接回新grid的節點
               #以利在這個grid節點中,再進行欄位的新增
               CALL sadzp168_add_grid(l_master_node.uib, g_common) RETURNING l_master_node.uib

               LET l_posX.uib = l_posX_start 
               LET l_posY.uib = l_posY_start
               LET l_posX_max.uib = l_posX.uib
               LET l_posY_max.uib = l_posY.uib
            END IF

            #公用欄位新增
            CALL sadzp168_common_add_field(p_structure, p_spage.sfield[l_level3].*, l_master_node.uib, l_sr_node, l_posX.uib, l_posY.uib)
               RETURNING p_spage.sfield[l_level3].*, l_widget_width, l_widget_height

            #記錄grid目前已用到的寬度
            IF l_posX_max.uib < l_widget_width THEN
               LET l_posX_max.uib = l_widget_width
            END IF

            #記錄grid目前已用到的高度
            LET l_posY_max.uib = l_posY_max.uib + l_widget_height

            #同一排下一組控件的posX, posY啟始位置
            LET l_posX.uib = l_posX_start 
            LET l_posY.uib = l_posY_max.uib

            #grid的預設高度 < grid目前已用高度,則resize為使用的高度
            IF l_master_node.uib.getAttribute("gridHeight") < l_posY_max.uib THEN
               CALL l_master_node.uib.setAttribute("gridHeight",  l_posY_max.uib)
            END IF
      
            #grid的預設寬度 < grid目前已用寬度,則resize為使用的寬度
            IF l_master_node.uib.getAttribute("gridWidth") < l_posX_max.uib THEN
               CALL l_master_node.uib.setAttribute("gridWidth", l_posX_max.uib)
            END IF

         WHEN "grpUIStateinfo"
            #處理公用欄位折行(新增一個新的grid),在function get_dzfr_data已處理判斷公用欄位是否需折行
            IF p_spage.sfield[l_level3].dzekWarp THEN
               #計算父節點container目前已用到多少寬度/高度
               LET l_container_width.uis = l_container_width.uis + l_master_node.uis.getAttribute("gridWidth")
               
               IF l_container_height.uis < l_master_node.uib.getAttribute("gridHeight") THEN
                  LET l_container_height.uis = l_master_node.uib.getAttribute("gridHeight")
               END IF
               
               #元件換行時需新增一grid,且接回新grid的節點
               #以利在這個grid節點中,再進行欄位的新增
               CALL sadzp168_add_grid(l_master_node.uis, g_common) RETURNING l_master_node.uis

               LET l_posX.uis = l_posX_start 
               LET l_posY.uis = l_posY_start
               LET l_posX_max.uis = l_posX.uis
               LET l_posY_max.uis = l_posY.uis
            END IF

            #公用欄位新增
            CALL sadzp168_common_add_field(p_structure, p_spage.sfield[l_level3].*, l_master_node.uis, l_sr_node, l_posX.uis, l_posY.uis)
               RETURNING p_spage.sfield[l_level3].*, l_widget_width, l_widget_height

            #記錄grid目前已用到的寬度
            IF l_posX_max.uis < l_widget_width THEN
               LET l_posX_max.uis = l_widget_width
            END IF

            #記錄grid目前已用到的高度
            LET l_posY_max.uis = l_posY_max.uis + l_widget_height

            #同一排下一組控件的posX, posY啟始位置
            LET l_posX.uis = l_posX_start 
            LET l_posY.uis = l_posY_max.uis

            #grid的預設高度 < grid目前已用高度,則resize為使用的高度
            IF l_master_node.uis.getAttribute("gridHeight") < l_posY_max.uis THEN
               CALL l_master_node.uis.setAttribute("gridHeight",  l_posY_max.uis)
            END IF
      
            #grid的預設寬度 < grid目前已用寬度,則resize為使用的寬度
            IF l_master_node.uis.getAttribute("gridWidth") < l_posX_max.uis THEN
               CALL l_master_node.uis.setAttribute("gridWidth", l_posX_max.uis)
            END IF

         OTHERWISE
            CONTINUE FOR
      END CASE
   END FOR

   #計算[資料歸屬]父節點container目前已用到多少寬度/高度
   LET l_container_width.uib = l_container_width.uib + l_master_node.uib.getAttribute("gridWidth")
               
   IF l_container_height.uib < l_master_node.uib.getAttribute("gridHeight") THEN
      LET l_container_height.uib = l_master_node.uib.getAttribute("gridHeight")
   END IF

   #計算[資料狀態資訊]父節點container目前已用到多少寬度/高度
   LET l_container_width.uis = l_container_width.uis + l_master_node.uis.getAttribute("gridWidth")
               
   IF l_container_height.uis < l_master_node.uib.getAttribute("gridHeight") THEN
      LET l_container_height.uis = l_master_node.uib.getAttribute("gridHeight")
   END IF

   #調整[資料歸屬]由內而外所有的container size
   CALL sadzp168_container_resize(l_master_node.uib, l_container_width.uib, l_container_height.uib)

   #調整[資料狀態資訊]由內而外所有的container size
   CALL sadzp168_container_resize(l_master_node.uis, l_container_width.uis, l_container_height.uis)

   RETURN TRUE
END FUNCTION

#+ 在公用欄位頁籤中增加欄位點資訊
PRIVATE FUNCTION sadzp168_common_add_field(p_structure, p_field_info, p_node, p_sr_node, p_posX, p_posY)
   DEFINE p_structure         STRING                #樣版所定義的結構類型名稱
   DEFINE p_field_info        type_g_field          #公用欄位資訊
   DEFINE p_node              om.DomNode            #公用欄位切片的domNode
   DEFINE p_sr_node           om.DomNode            #公用欄位所屬的sr node
   DEFINE p_posX              LIKE type_t.num10     #widget元件X軸位置
   DEFINE p_posY              LIKE type_t.num10     #widget元件Y軸位置

   DEFINE l_field_type        LIKE type_t.chr1      #新欄位的fieldType
   DEFINE l_widget            STRING                #欄位的控件樣式
   DEFINE l_widget_width      LIKE type_t.num10
   DEFINE l_widget_height     LIKE type_t.num10
   DEFINE l_posY_max          LIKE type_t.num10     #此排欄位控件用到的posY最大值(準備下一行欄位控件使用的poxY起始點)
   DEFINE l_new_child         om.DomNode            #新增欄位的子節點
   DEFINE l_sr_child          om.DomNode            #sr要新增的子即點
   DEFINE l_str               STRING
   DEFINE l_ref_name          STRING                #reference欄位的widget name
   DEFINE l_node_r            om.DomNode

   INITIALIZE l_node_r TO NULL
   
   ############新增一組公用欄位相關控件################################
   #todo:預設 單頭的欄位都是TABLE_COLUMN型態
   LET l_field_type = g_table_column
   
   #create欄位歸屬widget(dzep010)子節點
   LET l_widget = sadzp168_get_widget(p_field_info.dzej003)

   #在單頭中的一個欄位控件新增 = [Label(?述)] + [欄位控件] + [FFLabel(參考欄位)]
   #X軸在同一列, Y軸不變

   ############增加Label(敘述)################################
   CALL sadzp168_add_static_label(p_node, p_field_info.*, l_field_type, p_posX, p_posY, "10")
      RETURNING l_widget_width, l_widget_height, l_node_r

   #下一個欄位點的X軸位置
   LET p_posX = p_posX + l_widget_width + 1
      
   #比較一下同一列的每個widget高度最大己用posY值
   IF l_posY_max < l_widget_height THEN
      LET l_posY_max = l_widget_height
   END IF

   ############新增欄位控件(widget)############################
   #新增真正可操作的欄位子節點widget
   LET l_new_child = p_node.createChild(l_widget.trim())

   CALL sadzp168_set_common_attr(p_field_info.*, l_new_child, l_field_type, l_widget, p_posX, p_posY)
      RETURNING l_widget_height, l_widget_width

   #記錄欄位真正顯示控件
   LET p_field_info.widget = base.StringBuffer.create()
   LET l_str = l_new_child.getAttribute("widget")
   CALL p_field_info.widget.append(l_str.trim())

   #記錄欄位真正顯示控件代號
   LET p_field_info.widgetName = base.StringBuffer.create()
   LET l_str = l_new_child.getAttribute("name")
   CALL p_field_info.widgetName.append(l_str.trim())
      
   #比較一下同一列的每個widget高度最大己用posY值
   IF l_posY_max < l_widget_height THEN
      LET l_posY_max = l_widget_height
   END IF

   #下一個欄位點的X軸位置
   LET p_posX = p_posX + l_widget_width + 1

   ############處理Screen Records##############################
   LET l_sr_child = p_sr_node.createChild("RecordField")

   #設置新sr child node的屬性
   CALL sadzp168_set_sr_attr(l_sr_child, l_new_child.getAttribute("sqlTabName") CLIPPED, l_new_child.getAttribute("colName") CLIPPED, l_new_child.getAttribute("name") CLIPPED, l_field_type)

   ############處理reference欄位################################
   #當此欄位有參考欄位時,需要補reference欄位在後面
   IF NOT cl_null(p_field_info.refField) THEN
      INITIALIZE l_node_r TO NULL
      
      #記錄參考欄位所依附欄位的控件名稱
      LET p_field_info.dzai005 = base.StringBuffer.create()
      LET l_str = l_new_child.getAttribute("name")
      CALL p_field_info.dzai005.append(l_str)
         
      #TABLE_COLUMN reference欄位命名,只需欄位名稱加上'_desc', exp:dzea_t.dzea001=> dzea001_desc
      IF l_field_type = g_table_column THEN
         LET l_ref_name = p_field_info.colName CLIPPED
      ELSE
         #exp:gztb002_2=> gztb002_2_desc; b_gztb002=> b_gztb002_desc
         LET l_ref_name = l_new_child.getAttribute("name") CLIPPED
      END IF
         
      #因為節點不需要採插入方式,因此變數傳入NULL
      CALL sadzp168_add_reference(p_node, NULL, p_sr_node, NULL, l_ref_name.trim(), "", p_posX, p_posY)
         RETURNING l_widget_width, l_widget_height, l_node_r

      LET p_field_info.dzai002 = base.StringBuffer.create()
      LET l_ref_name = l_node_r.getAttribute("name") CLIPPED
      CALL p_field_info.dzai002.append(l_ref_name)

      LET p_posX = p_posX + l_widget_width + 1   #下一個欄位點的X軸位置

      #比較一下同一列的每個widget高度最大己用posY值
      IF l_posY_max < l_widget_height THEN
         LET l_posY_max = l_widget_height
      END IF
   END IF

   #RETURN l_widget, p_posX, l_posY_max
   RETURN p_field_info.*, p_posX, l_posY_max
END FUNCTION

#+ 載入本次畫面設計檔單頭status的公版snippet
PRIVATE FUNCTION sadzp168_get_master_status_snippet(p_node, p_field)
   DEFINE p_node            om.DomNode            #單頭目前正在新增欄位的container node(一般都是grid)
   DEFINE p_field           type_g_field          #status欄位資訊
   
   DEFINE l_parent          om.DomNode            #p_node的父節點
   DEFINE l_snippet_file    STRING                #切片檔案名稱
   DEFINE l_node            om.DomNode
   DEFINE l_stus_node       om.DomNode            #status控件 node
   DEFINE l_posX            LIKE type_t.num10     #status切片X軸位置
   DEFINE l_posY            LIKE type_t.num10     #status切片Y軸位置
   DEFINE l_snippet_width   LIKE type_t.num10     #status切片的gridWidth
   DEFINE l_str             STRING

   INITIALIZE l_parent TO NULL
   INITIALIZE l_node TO NULL
   INITIALIZE l_stus_node TO NULL

   LET l_snippet_width = 0
   
   #status切片與grid同層,所以需取得父節點
   LET l_parent = p_node.getParent()
   
   #取得樣單頭status切片檔案名稱
   LET l_snippet_file = "master_status.snippet"

   #取得單頭status切片檔所在完整路徑
   LET l_snippet_file = sadzp168_load_file(l_snippet_file)
   IF cl_null(l_snippet_file) THEN
      DISPLAY "master_status isn't exist."   #無此master_status切片檔案.
      RETURN FALSE, l_snippet_width
   END IF

   #將單頭status檔加入父節點中
   LET l_node = l_parent.loadXml(l_snippet_file) 

   IF l_node IS NULL THEN
      #樣版檔插入master_status切片檔時失敗
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00070"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] =  l_snippet_file.trim()
      CALL cl_err()
      RETURN FALSE, l_snippet_width
   END IF

   #status切片曾經載入,所以需將裡面元件rename
   IF g_load_grid_state THEN
      CALL sadzp168_container_rename(l_node, NULL, NULL)
   END IF
   
   #調整master_status切片在畫面的x, y軸位置
   CASE l_parent.getTagName()
      WHEN "HBox"
         LET l_posX = p_node.getAttribute("posX") + p_node.getAttribute("gridWidth") 
         LET l_posY = p_node.getAttribute("posY") 
         CALL l_node.setAttribute("gridHeight", p_node.getAttribute("gridHeight"))
         
      WHEN "VBox"
         LET l_posX = p_node.getAttribute("posX") 
         LET l_posY = p_node.getAttribute("posY") + p_node.getAttribute("gridHeight")
         CALL l_node.setAttribute("gridWidth", p_node.getAttribute("gridWidth"))
         
   END CASE
   
   CALL l_node.setAttribute("posX", l_posX)
   CALL l_node.setAttribute("posY", l_posY)

   LET l_snippet_width = l_node.getAttribute("gridWidth")

   #取得status控件
   LET l_stus_node = sadzp168_2_get_domNode(l_node, "ComboBox", "tag", "cdfStatus")

   #改變屬性值
   IF l_stus_node IS NOT NULL THEN
      CALL l_stus_node.setAttribute("colName", p_field.colName CLIPPED)
      CALL l_stus_node.setAttribute("fieldType", "TABLE_COLUMN") 
      CALL l_stus_node.setAttribute("name", p_field.attrName)
      CALL l_stus_node.setAttribute("sqlTabName", p_field.sqlTabName CLIPPED)
   END IF

   #記錄欄位真正顯示控件
   ###LET p_field.widget = base.StringBuffer.create()
   LET l_str = l_stus_node.getAttribute("widget")
   CALL p_field.widget.append(l_str.trim())

   #記錄欄位真正顯示控件代號
   ###LET p_field.widgetName = base.StringBuffer.create()
   LET l_str = l_stus_node.getAttribute("name")
   CALL p_field.widgetName.append(l_str.trim())
      
   #處理切片檔中有些widget需要在Screen Record增加一個子節點
   CALL sadzp168_add_template_sr_node(l_node)

   #記錄status切片已載入過第一次
   IF NOT g_load_grid_state THEN
      LET g_load_grid_state = TRUE
   END IF
      
   RETURN TRUE, l_snippet_width
END FUNCTION

#+ 在單頭 domNode中增加欄位節點的前置作業
PRIVATE FUNCTION sadzp168_scrollgrid_add_field_pre(p_spage, p_container_node)
   DEFINE p_spage             type_g_page_info
   DEFINE p_container_node    om.DomNode            #要將設計資料新增在那一個結構類型[container]下
   
   DEFINE l_detail_node       om.DomNode            #樣版單身node
   DEFINE l_sr_node           om.DomNode            #單身所屬sr node

   INITIALIZE l_detail_node TO NULL
   INITIALIZE l_sr_node TO NULL
   
   #取得設計資料要新增在那個結構類型(container)下的node節點位置
   LET l_detail_node = p_container_node

   #取得單身sr node的節點位置
   LET l_sr_node = sadzp168_2_get_domNode(g_template_node, "Record", "name", l_detail_node.getAttribute("name"))
   
   #在單頭中新增欄位節點
   IF NOT sadzp168_scrollgrid_add_field(p_spage.*, l_detail_node, l_sr_node) THEN
      RETURN FALSE
   END IF

   RETURN TRUE
END FUNCTION

#+ 在單頭 domNode中增加欄位點資訊
PRIVATE FUNCTION sadzp168_scrollgrid_add_field(p_spage, p_detail_node, p_sr_node)
   DEFINE p_spage             type_g_page_info
   DEFINE p_detail_node       om.DomNode            #需要新增欄位節點的domNode
   DEFINE p_sr_node           om.DomNode            #單身所屬的sr node

   DEFINE l_new_child         om.DomNode            #新增控件的子節點
   DEFINE l_sr_child          om.DomNode            #sr要新增的子即點
   DEFINE l_level3            LIKE type_t.num5
   DEFINE l_widget            STRING                #新增欄位的控件樣式
   DEFINE l_posX_lbl          LIKE type_t.num10     #下一個Static Label元件X軸位置
   DEFINE l_posY_lbl          LIKE type_t.num10     #下一個Static Label元件Y軸位置
   DEFINE l_posX_widget       LIKE type_t.num10     #下一個widget元件X軸位置
   DEFINE l_posY_widget       LIKE type_t.num10     #下一個widget元件Y軸位置
   DEFINE l_posX_lbl_start    LIKE type_t.num10     #每一排Static LabelX軸啟始位置
   DEFINE l_posY_lbl_start    LIKE type_t.num10     #每一排Static LabelY軸啟始位置
   DEFINE l_posX_start        LIKE type_t.num10     #每一排元件X軸啟始位置
   DEFINE l_posY_start        LIKE type_t.num10     #每一排元件Y軸啟始位置
   DEFINE l_grid_height       LIKE type_t.num10
   DEFINE l_grid_width        LIKE type_t.num10
   DEFINE l_container_height  LIKE type_t.num10     #上層父節點container已用高度
   DEFINE l_container_width   LIKE type_t.num10     #上層父節點container已用總寬度
   DEFINE l_field_type        LIKE type_t.chr1      #新欄位的fieldType
   DEFINE l_ref_name          STRING                #reference欄位的widget name
   DEFINE l_node_r            om.DomNode
   DEFINE l_str               STRING
   DEFINE l_dzep009           INTEGER #LIKE dzep_t.dzep009   #此排控件最大寬度
   DEFINE l_widget_hight      LIKE dzep_t.dzep009   #此排控件最大高度
   DEFINE l_cont_tagname      LIKE dzfr_t.dzfr007
   DEFINE l_row_cnt           LIKE type_t.num5      #共有幾排row
   DEFINE l_row_seq           LIKE type_t.num5
   DEFINE l_row_seq_t         LIKE type_t.num5
   DEFINE l_stepY             LIKE type_t.num5
   DEFINE l_total_hight       LIKE type_t.num5      #ScrollGrid下所有row中的控件要用掉的總高度
   DEFINE l_first_widget      om.DomNode            #ScrollGrid下第一個widget控件
   DEFINE l_node_before       om.DomNode
   DEFINE l_child_node        om.DomNode
   DEFINE l_detail_lbl_child  om.DomNode
   DEFINE l_detail_child      om.DomNode
   DEFINE l_del_sr_child      om.DomNode            #sr 要刪除的子節點
   
   INITIALIZE l_first_widget TO NULL
   INITIALIZE l_node_before TO NULL
   INITIALIZE l_detail_lbl_child TO NULL
   INITIALIZE l_detail_child TO NULL
   INITIALIZE l_del_sr_child TO NULL
   
   #預設Static Label第一個欄位的啟始位置
   IF g_detail_lbl_child IS NOT NULL THEN
      LET l_posX_lbl_start = g_detail_lbl_child.getAttribute("posX")
      LET l_posY_lbl_start = g_detail_lbl_child.getAttribute("posY")
   ELSE
      LET l_posX_lbl_start = 2
      LET l_posY_lbl_start = 1
   END IF
   
   #預設ScrollGrid第一個欄位的啟始位置
   IF g_detail_child IS NOT NULL THEN
      LET l_posX_start = g_detail_child.getAttribute("posX")
      LET l_posY_start = g_detail_child.getAttribute("posY")
   ELSE
      LET l_posX_start = 2
      LET l_posY_start = 3
   END IF
   
   #取得ScrollGrid下共有幾排row(為了定義高度posY)
   LET l_cont_tagname = p_spage.stable
   SELECT COUNT(DISTINCT(row_seq)) INTO l_row_cnt FROM adzp168t2
      WHERE cont_tagname = l_cont_tagname      

   #取不到row的設計資料
   IF l_row_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00141"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] =  l_cont_tagname CLIPPED
      CALL cl_err()
      RETURN FALSE
   END IF

   #取得ScrollGrid下所有row中的控件要用掉的總高度
   SELECT SUM(max_hight) INTO l_total_hight FROM  
     (SELECT row_seq, MAX(widget_hight) AS max_hight FROM adzp168t2
        WHERE cont_tagname = l_cont_tagname
        GROUP BY row_seq)

   #todo:預設 單身的欄位都是TABLE_COLUMN型態
   LET l_field_type = g_table_column
   
   LET l_row_seq = 0
   LET l_row_seq_t = l_row_seq
   LET l_widget_hight = 0
   LET l_container_width = 0
   LET l_container_height = 0

   #預設第一排橫向Static Label posY位置
   LET l_posY_lbl = l_posY_lbl_start
         
   #預設第一排橫向widget posY位置 = [widget啟始位置] + [row總排數] - 1
   LET l_posY_widget = l_posY_start + l_row_cnt - 1
         
   #處理要新增的欄位
   FOR l_level3 = 1 TO p_spage.sfield.getLength()

      #判斷ScrollGrid是否已經橫向換行
      LET l_row_seq = p_spage.sfield[l_level3].srowSeq
      IF l_row_seq <> l_row_seq_t THEN
         #每一排橫向欄位當有產生ref欄位控件(或多語言欄位控件)時,總高度需要再+1
         IF l_node_before IS NOT NULL THEN
             LET l_posY_widget = l_posY_widget + 1
         END IF
         
         INITIALIZE l_node_before TO NULL
         LET l_row_seq_t = l_row_seq
         
         #此排Static Label元件啟始位置
         LET l_posX_lbl = l_posX_lbl_start 

         #第一排row不需要再加1
         IF l_first_widget IS NOT NULL THEN
            #Static Label posY位置 = row排數 - 1 (Label固定高度為1, 所以固定每排加 + 1)
            LET l_posY_lbl = l_posY_lbl + 1
         END IF

         #此排widget元件啟始位置
         LET l_posX_widget = l_posX_start 

         #此排widget posY位置 = [上一排橫向控件已用poxY位置] + [row總排數]
         LET l_posY_widget = l_posY_widget + l_widget_hight
   
         #取得此排橫向控件最大高度
         #EXECUTE sadzp861_widget_hight_pre USING p_spage.sfield[l_level3].dzfr003 INTO l_widget_hight
         EXECUTE sadzp168_widget_hight_pre USING l_cont_tagname, p_spage.sfield[l_level3].srowSeq INTO l_widget_hight
         IF STATUS THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  STATUS
            LET g_errparam.extend = "EXECUTE sadzp168_widget_hight_pre:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            DISPLAY "EXECUTE sadzp168_widget_hight_pre(dzfr003=", p_spage.sfield[l_level3].dzfr003 CLIPPED, "):", STATUS
            RETURN FALSE
         END IF
      END IF

      #取得此排直向控件最大寬度
      EXECUTE sadzp168_widget_width_pre USING p_spage.sfield[l_level3].dzfr003 INTO l_dzep009
      IF STATUS THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  STATUS
         LET g_errparam.extend = "EXECUTE sadzp168_widget_width_pre:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         DISPLAY "EXECUTE sadzp168_widget_width_pre(dzfr003=", p_spage.sfield[l_level3].dzfr003 CLIPPED, "):", STATUS
         RETURN FALSE
      END IF
      
      #r.a設計資料有"ghost"時,代表畫面上要空出一個欄位位置
      IF p_spage.sfield[l_level3].dzfr006 = "ghost" THEN
         #準備下一組控件的posX位置
         LET l_posX_lbl = l_posX_lbl + l_dzep009 + 1
         LET l_posX_widget = l_posX_widget + l_dzep009 + 1

         CONTINUE FOR
      END IF

      #create欄位歸屬widget(dzep010)子節點
      LET l_widget = sadzp168_get_widget(p_spage.sfield[l_level3].dzej003)

      #取得狀態碼widget樣式
      IF p_spage.sfield[l_level3].dzeb022 = "cdfStatus" THEN
         #狀態碼欄位widget型態規則:B + SCC選項Y/N就產生CheckBox，其他都做ComboBox
         LET l_widget = sadzp168_get_stus_widget(p_spage.sfield[l_level3].sqlTabName, p_spage.sfield[l_level3].colName, p_spage.sfield[l_level3].dzej003)
      END IF
      
      #在單頭中的一個欄位控件新增 = [Label(?述)] + [欄位控件] + [FFLabel(參考欄位)]
      #X軸隨wdiget累加: Y軸在同一列不變
   
      ##########增加Label(敘述)##########
      INITIALIZE l_node_r TO NULL
      
      CALL sadzp168_add_static_label(p_detail_node, p_spage.sfield[l_level3].*, l_field_type, l_posX_lbl, l_posY_lbl, l_dzep009 CLIPPED)
         RETURNING l_grid_width, l_grid_height, l_node_r

      #ScrollGrid XML結構範例:
      #<Label gridHeight="1" name="lbl_azi05" posX="1" posY="1"/>
      #<Label gridHeight="1" name="lbl_azi07" posX="7" posY="1"/>
      #<CheckBox gridHeight="1" name="azi_file.aziacti" posX="1" posY="4" />
      #<Edit gridHeight="1" name="azi_file.azi01" posX="7" posY="4"/>
      IF l_first_widget IS NOT NULL THEN
         CALL p_detail_node.insertBefore(l_node_r, l_first_widget)
      END IF

      #單身多頁籤PK欄位widget name不能重覆需rename,因此lable(敘述)也需要跟著rename
      IF NOT cl_null(p_spage.sfield[l_level3].detailPK) THEN
         CALL l_node_r.setAttribute("name", "lbl_" || p_spage.sfield[l_level3].detailPK CLIPPED)
      END IF
      
      ##########新增真正可操作的欄位子節點widget##########
      LET l_new_child = p_detail_node.createChild(l_widget.trim()) 

      #單身多頁籤PK欄位widget name不能重覆需rename,因此fieldType屬性為COLUMN_LIKE型態
      IF NOT cl_null(p_spage.sfield[l_level3].detailPK) THEN
         LET l_field_type = g_column_like
      ELSE
         LET l_field_type = g_table_column
      END IF

      CALL sadzp168_set_common_attr(p_spage.sfield[l_level3].*, l_new_child, l_field_type, l_widget, l_posX_widget, l_posY_widget)
         RETURNING l_grid_height, l_grid_width

      #記錄欄位真正顯示控件
      LET p_spage.sfield[l_level3].widget = base.StringBuffer.create()
      LET l_str = l_new_child.getAttribute("widget")
      CALL p_spage.sfield[l_level3].widget.append(l_str.trim())

      #記錄欄位真正顯示控件代號
      LET p_spage.sfield[l_level3].widgetName = base.StringBuffer.create()
      LET l_str = l_new_child.getAttribute("name")
      CALL p_spage.sfield[l_level3].widgetName.append(l_str.trim())
      
      #ScrollGrid同一直向排列的widget為了美觀,所以統一設成同一此排wdiget最大寬度
      IF NOT cl_null(l_dzep009) AND l_dzep009 <> 0 THEN
         CALL l_new_child.setAttribute("gridWidth", l_dzep009)
      END IF

      #屬於ScrollGrid下的控件需額外設定屬性
      CALL sadzp168_set_scrollgrid_attr(l_new_child, l_row_cnt)

      #控件domNode需插入在[reference欄位]或[多語言欄位]之前
      IF l_node_before IS NOT NULL THEN
         CALL p_detail_node.insertBefore(l_new_child, l_node_before)
      END IF

      #取得第一個widget控件domNode,做為之後Static Label的domNode要insertBefore()用
      IF l_first_widget IS NULL THEN
         LET l_first_widget = l_new_child
      END IF

      ############處理Screen Records##############################
      LET l_sr_child = p_sr_node.createChild("RecordField")

      #設置新sr child node的屬性
      CALL sadzp168_set_sr_attr(l_sr_child, l_new_child.getAttribute("sqlTabName") CLIPPED, l_new_child.getAttribute("colName") CLIPPED, l_new_child.getAttribute("name") CLIPPED, l_field_type)
      ###########################################################
      
      ############處理reference欄位################################
      #當此欄位有參考欄位時,需要補reference欄位在後面
      IF NOT cl_null(p_spage.sfield[l_level3].refField) THEN
         INITIALIZE l_node_r TO NULL
         
         #記錄參考欄位所依附欄位的控件名稱
         LET p_spage.sfield[l_level3].dzai005 = base.StringBuffer.create()
         LET l_str = l_new_child.getAttribute("name")
         CALL p_spage.sfield[l_level3].dzai005.append(l_str)
      
         #TABLE_COLUMN reference欄位命名,只需欄位名稱加上'_desc', exp:dzea_t.dzea001=> dzea001_desc
         IF l_field_type = g_table_column THEN
            LET l_ref_name = p_spage.sfield[l_level3].colName CLIPPED
         ELSE
            #exp:gztb002_2=> gztb002_2_desc; b_gztb002=> b_gztb002_desc
            LET l_ref_name = l_new_child.getAttribute("name") CLIPPED
         END IF
      
         #因為節點不需要採插入方式,因此變數傳入NULL
         #ref控件的posY位置 = 此排控件起始posY值 + 上一排真正顯示控件所使用的最大高度
         #CALL sadzp168_add_reference(p_detail_node, NULL, p_sr_node, NULL, l_ref_name.trim(), "", l_posX_widget, l_posY_widget + l_widget_hight)
         CALL sadzp168_add_reference(p_detail_node, NULL, p_sr_node, NULL, l_ref_name.trim(), "", l_posX_widget, l_posY_widget + l_new_child.getAttribute("gridHeight"))
            RETURNING l_grid_width, l_grid_height, l_node_r

         #設成同樣寬度
         CALL l_node_r.setAttribute("gridWidth", l_new_child.getAttribute("gridWidth"))

         #屬於ScrollGrid下的控件需額外設定以下屬性
         CALL sadzp168_set_scrollgrid_attr(l_node_r, l_row_cnt)
      
         LET p_spage.sfield[l_level3].dzai002 = base.StringBuffer.create()
         LET l_ref_name = l_node_r.getAttribute("name") CLIPPED
         CALL p_spage.sfield[l_level3].dzai002.append(l_ref_name)

         #取得插入控件domNode,做為之後下一個widget的domNode要insertBefore()用
         IF l_node_before IS NULL THEN
            LET l_node_before = l_node_r
            LET l_total_hight = l_total_hight + 1
         END IF
      END IF
      ###########################################################

      ############處理多語言欄位控件################################
      #當此欄位有多語言欄位時,需要補資料多語言欄位在widget下面
      IF (NOT cl_null(p_spage.sfield[l_level3].langField)) AND cl_null(p_spage.sfield[l_level3].detailPK) THEN
         INITIALIZE l_node_r TO NULL
         
         #記錄多語言欄位所依附欄位的控件名稱
         LET p_spage.sfield[l_level3].dzaj005 = base.StringBuffer.create()
         LET l_str = l_new_child.getAttribute("name")
         CALL p_spage.sfield[l_level3].dzaj005.append(l_str)
      
         #因為節點不需要採插入方式,因此變數傳入NULL
         #多語言控件的posY位置 = 此排控件起始posY值 + 上一排真正顯示控件所使用的最大高度
         #CALL sadzp168_add_lang(p_detail_node, NULL, p_sr_node, NULL, p_spage.sfield[l_level3].dzer005, p_spage.sfield[l_level3].langField, l_posX_widget, l_posY_widget + l_widget_hight)
         CALL sadzp168_add_lang(p_detail_node, NULL, p_sr_node, NULL, p_spage.sfield[l_level3].dzer005, p_spage.sfield[l_level3].langField, l_posX_widget, l_posY_widget + l_new_child.getAttribute("gridHeight"))
            RETURNING l_grid_width, l_grid_height, l_node_r

         #設成同樣寬度
         CALL l_node_r.setAttribute("gridWidth", l_new_child.getAttribute("gridWidth"))

         #屬於ScrollGrid下的控件需額外設定以下屬性
         CALL sadzp168_set_scrollgrid_attr(l_node_r, l_row_cnt)
         
         LET p_spage.sfield[l_level3].dzaj002 = base.StringBuffer.create()
         LET l_ref_name = l_node_r.getAttribute("name") CLIPPED
         CALL p_spage.sfield[l_level3].dzaj002.append(l_ref_name)

         #取得插入控件domNode,做為之後下一個widget的domNode要insertBefore()用
         IF l_node_before IS NULL THEN
            LET l_node_before = l_node_r
            LET l_total_hight = l_total_hight + 1
         END IF
      END IF
      ###########################################################
      
      #準備下一組控件的posX位置
      LET l_posX_lbl = l_posX_lbl + l_new_child.getAttribute("gridWidth") + 1
      LET l_posX_widget = l_posX_widget + l_new_child.getAttribute("gridWidth") + 1

      #取得ScrollGrid目前已用最大posX值
      IF l_container_width < l_posX_widget THEN
         LET l_container_width = l_posX_widget
      END IF
   END FOR

   ##ScrollGrid總高度 = 控件啟始位置 + 最後一個控件所要用的位置
   #LET l_container_width = l_posX_start + l_posX_widget
   #ScrollGrid總高度 = 控件啟始位置 + 已用最大posX值
   LET l_container_width = l_posX_start + l_container_width
   
   #ScrollGrid的預設寬度 < ScrollGrid目前已用寬度,則resize為使用的寬度
   IF p_detail_node.getAttribute("gridWidth") < l_container_width THEN
      CALL p_detail_node.setAttribute("gridWidth", l_container_width)
   END IF
   
   #ScrollGrid總高度 = 第一個widget的posY啟始位置 + (row總數 * (所有row用的widget總高度 + 空白間隔距離1))
   LET l_container_height = l_first_widget.getAttribute("posY") + (g_detail_child.getAttribute("rowCount") * (l_total_hight + 1))

   IF p_detail_node.getAttribute("gridHeight") < l_container_height THEN
      CALL p_detail_node.setAttribute("gridHeight", l_container_height)
   END IF
  
   #因為程式邏輯中有可能增加ref欄位(或多語言欄位),可能會造成下一筆record的控件posX,posY值重覆
   #所以需重新調整stepY
   LET l_child_node = p_detail_node.getFirstChild()
   WHILE l_child_node IS NOT NULL
      IF NOT cl_null(l_child_node.getAttribute("stepY")) THEN
         #取得下筆record控件的間隔距離
         IF (NOT cl_null(l_total_hight)) AND (l_total_hight <> 0) THEN 
            #間隔距離 = ([row總高度] - [此控件高度]) + [空白間隔距離(1)]
            LET l_grid_height = l_child_node.getAttribute("gridHeight")
            LET l_stepY = (l_total_hight - l_grid_height) + 1
         ELSE
            LET l_stepY = l_row_cnt
         END IF
      
         CALL l_child_node.setAttribute("stepY", l_stepY)
      END IF

      #將[tag]屬性標記為[Del]的節點刪除
      #IF l_child_node.getAttribute("tag") = "Del" AND g_detail_lbl_child.getAttribute("name") = l_child_node.getAttribute("name") THEN
      LET l_str = l_child_node.getAttribute("name")
      IF l_child_node.getAttribute("tag") = "Del" AND l_str.getIndexOf(g_detail_lbl_child.getAttribute("name"), 1) > 0 THEN
         LET l_detail_lbl_child = l_child_node
      END IF

      #IF l_child_node.getAttribute("tag") = "Del" AND g_detail_child.getAttribute("name") = l_child_node.getAttribute("name") THEN
      LET l_str = l_child_node.getAttribute("name")
      IF l_child_node.getAttribute("tag") = "Del" AND l_str.getIndexOf(g_detail_child.getAttribute("name"), 1) > 0 THEN
         LET l_detail_child = l_child_node
      END IF
      
      LET l_child_node = l_child_node.getNext()
   END WHILE

   
   #將[tag]屬性標記為[Del]的節點刪除
   IF l_detail_lbl_child IS NOT NULL THEN
      CALL p_detail_node.removeChild(l_detail_lbl_child)

      #刪除SR 上的節點
      INITIALIZE l_del_sr_child TO NULL
      LET l_del_sr_child = sadzp168_2_get_domNode(p_sr_node, "RecordField", "name", l_detail_lbl_child.getAttribute("name"))
      IF l_del_sr_child IS NOT NULL THEN
         CALL p_sr_node.removeChild(l_del_sr_child)
      END IF 
   END IF

   IF l_detail_child IS NOT NULL THEN
      CALL p_detail_node.removeChild(l_detail_child)

      #刪除SR 上的節點
      INITIALIZE l_del_sr_child TO NULL
      LET l_del_sr_child = sadzp168_2_get_domNode(p_sr_node, "RecordField", "name", l_detail_child.getAttribute("name"))
      IF l_del_sr_child IS NOT NULL THEN
         CALL p_sr_node.removeChild(l_del_sr_child)
      END IF 
   END IF

   #調整由內而外所有的container size
   CALL sadzp168_container_resize(p_detail_node, l_container_width, l_container_height)

   RETURN TRUE
END FUNCTION

#+ 在QBE domNode中增加欄位點資訊
PRIVATE FUNCTION sadzp168_qbe_add_field(p_spage, p_qbe_node, p_sr_node)
   DEFINE p_spage             type_g_page_info
   DEFINE p_qbe_node          om.DomNode            #需要新增欄位節點的domNode
   DEFINE p_sr_node           om.DomNode            #公版qbe所屬的sr node

   DEFINE l_new_child         om.DomNode            #新增欄位的子節點
   DEFINE l_sr_child          om.DomNode            #sr要新增的子即點
   DEFINE l_level3            LIKE type_t.num5
   DEFINE l_widget            STRING                #新增欄位的控件樣式
   DEFINE l_posX              LIKE type_t.num10     #下一個欄位元件X軸位置
   DEFINE l_posY              LIKE type_t.num10     #下一個欄位元件Y軸位置
   DEFINE l_posX_start        LIKE type_t.num10     #每一排元件X軸啟始位置
   DEFINE l_posY_start        LIKE type_t.num10     #每一排元件Y軸啟始位置
   DEFINE l_grid_height       LIKE type_t.num10
   DEFINE l_grid_width        LIKE type_t.num10
   DEFINE l_posX_max          LIKE type_t.num10     #此grid中欄位控件用到的posX最大值(準備下一排grid使用的posX起始點)
   DEFINE l_posY_max          LIKE type_t.num10     #此grid中欄位控件用到的posY最大值(準備下一行欄位控件使用的poxY起始點)
   DEFINE l_container_height  LIKE type_t.num10     #上層父節點container已用高度
   DEFINE l_container_width   LIKE type_t.num10     #上層父節點container已用總寬度
   DEFINE l_field_type        LIKE type_t.chr1      #新欄位的fieldType
   DEFINE l_ref_name          STRING                #reference欄位的widget name
   DEFINE l_str               STRING
   DEFINE l_flag              LIKE type_t.chr1
   DEFINE l_dzer              RECORD LIKE dzer_t.*  #欄位資料多語言設計表
   DEFINE l_stus_field        type_g_field          #status欄位資訊
   DEFINE l_node_r            om.DomNode

   INITIALIZE l_stus_field.* TO NULL
   INITIALIZE l_node_r TO NULL
   
   #預設qbe欄位的啟始位置
   IF p_qbe_node.getTagName() <> "Group" THEN
      LET l_posX_start = 1
      LET l_posY_start = 0
   ELSE
      #Group widget的posX 和posY 起始位置至少都是1開始
      LET l_posX_start = 1
      LET l_posY_start = 1
   END IF
   
   LET l_posX = l_posX_start 
   LET l_posY = l_posY_start
   LET l_posX_max = 0
   LET l_posY_max = 0
   LET l_container_width = 0
   LET l_container_height = 0

   #todo:預設 qbe的欄位都是TABLE_COLUMN型態
   LET l_field_type = g_table_column
   
   #處理要新增的欄位
   FOR l_level3 = 1 TO p_spage.sfield.getLength()
      #create欄位歸屬widget(dzep010)子節點
      LET l_widget = sadzp168_get_widget(p_spage.sfield[l_level3].dzej003)

      #在qbe中的一個欄位控件新增 = [Label(敘述)] + [欄位控件] (QBE欄位不產生參考欄位、多語言欄位)
      #X軸隨wdiget累加: Y軸在同一列不變

      #增加Label(敘述)
      CALL sadzp168_add_static_label(p_qbe_node, p_spage.sfield[l_level3].*, l_field_type, l_posX, l_posY, "10")
         RETURNING l_grid_width, l_grid_height, l_node_r

      #下一個欄位點的X軸位置
      LET l_posX = l_posX + l_grid_width + 1
      
      #比較一下同一列的每個widget高度最大己用posY值
      IF l_posY_max < l_grid_height THEN
         LET l_posY_max = l_grid_height
      END IF
      
      #新增真正可操作的欄位子節點widget
      LET l_new_child = p_qbe_node.createChild(l_widget.trim()) 

      CALL sadzp168_set_common_attr(p_spage.sfield[l_level3].*, l_new_child, l_field_type, l_widget, l_posX, l_posY)
         RETURNING l_grid_height, l_grid_width

      #記錄欄位真正顯示控件
      LET p_spage.sfield[l_level3].widget = base.StringBuffer.create()
      LET l_str = l_new_child.getAttribute("widget")
      CALL p_spage.sfield[l_level3].widget.append(l_str.trim())

      #記錄欄位真正顯示控件代號
      LET p_spage.sfield[l_level3].widgetName = base.StringBuffer.create()
      LET l_str = l_new_child.getAttribute("name")
      CALL p_spage.sfield[l_level3].widgetName.append(l_str.trim())
      
      #比較一下同一列的每個widget高度最大己用posY值
      IF l_posY_max < l_grid_height THEN
         LET l_posY_max = l_grid_height
      END IF

      #下一個欄位點的X軸位置
      LET l_posX = l_posX + l_grid_width + 1 

      ############處理Screen Records##############################
      LET l_sr_child = p_sr_node.createChild("RecordField")

      #設置新sr child node的屬性
      CALL sadzp168_set_sr_attr(l_sr_child, l_new_child.getAttribute("sqlTabName") CLIPPED, l_new_child.getAttribute("colName") CLIPPED, l_new_child.getAttribute("name") CLIPPED, l_field_type)
      ###########################################################
      
      #比較一下此grid寬度最大己用posX值
      IF l_posX_max < l_posX THEN
         LET l_posX_max = l_posX
      END IF

      #同一排下一組控件的posX, posY啟始位置
      LET l_posX = l_posX_start 
      LET l_posY = l_posY + l_posY_max

      #計算父節點container目前已用到的最高高度
      IF l_container_height < l_posY THEN
         LET l_container_height = l_posY
      END IF

      #todo:l_posY_max:這裡應該要初始化,否則應該會影響下一排最大高度的控制
      LET l_posY_max = 0
      
      #在一排欄位換行時或新增欄位結束時,處理高度和寬度的設定 或者 QBE Structure為直向排列時(Q001_vq)欄位需折行
      IF ((l_level3 = p_spage.sfield.getLength()) OR (l_level3 MOD 3 = 0 AND g_dzfq_m.cbo_setbrowse = "vq")) THEN
         #grid的預設高度 < grid目前已用高度,則resize為使用的高度
         IF p_qbe_node.getAttribute("gridHeight") < l_container_height THEN
            CALL p_qbe_node.setAttribute("gridHeight", l_container_height)
         END IF
      
         #先將目前grid resize為使用的寬度
         IF p_qbe_node.getAttribute("gridWidth") < l_posX_max THEN
            CALL p_qbe_node.setAttribute("gridWidth", l_posX_max)
         END IF

         #Group container內直接換行即可
         IF p_qbe_node.getTagName() <> "Group" THEN
            #計算父節點container目前已用到多少寬度
            LET l_container_width = l_container_width + l_posX_max
               
            #欄位已處理數量小於新增總數量時,才需要新增新的grid
            IF l_level3 < p_spage.sfield.getLength() THEN
               #元件換行時需新增一grid,且接回新grid的節點
               #以利在這個grid節點中,再進行欄位的新增
               CALL sadzp168_add_grid(p_qbe_node, "") RETURNING p_qbe_node
            END IF
            
            LET l_posX = l_posX_start 
            LET l_posY = l_posY_start
         ELSE
            #同一個grid container內的換行,下一排直接引用上一排所用的最大posX值,為下一排的posX啟始值
            #再加1:這樣看起來才有排序的感覺
            LET l_posX = l_posX_max + 1
            #下一排posY預設值為l_posY_start每一排的預設起點
            LET l_posY = l_posY_start

            #計算父節點container目前已用到多少寬度
            LET l_container_width = l_posX_max
         END IF
      END IF
   END FOR

   IF cl_null(l_container_width) OR l_container_width = 0 THEN
      LET l_container_width = p_qbe_node.getAttribute("gridWidth")
   END IF

   IF cl_null(l_container_height) OR l_container_height = 0 THEN
      LET l_container_height = p_qbe_node.getAttribute("gridHeight")
   END IF
   
   #Group widget的高度和寬度必需比已用掉的還要大=>高度+2; 寬度+1
   IF p_qbe_node.getTagName() = "Group" THEN
      LET l_container_height = l_container_height + 2
      LET l_container_width = l_container_width + 1
      CALL p_qbe_node.setAttribute("gridHeight", l_container_height)
      CALL p_qbe_node.setAttribute("gridWidth", l_container_width)
   END IF
   
   #調整由內而外所有的container size
   CALL sadzp168_container_resize(p_qbe_node, l_container_width, l_container_height)
END FUNCTION





















#+ Tree中的子節點加上tag="tree_clone",以利複製Tree時,增加其子節點
PRIVATE FUNCTION sadzp168_tree_init(p_node, p_tree_name, p_type)
   DEFINE p_node            om.DomNode              #切片檔結構
   DEFINE p_tree_name       STRING                  #Tree節點的container name
   DEFINE p_type            LIKE type_t.chr1        #1:表示新增Tag屬性; 2:表示刪除Tag屬性

   DEFINE l_node_list       om.NodeList
   DEFINE l_tree_node       om.DomNode
   DEFINE l_tree_child      om.DomNode
   DEFINE l_name            STRING
   DEFINE l_tag             STRING
   DEFINE l_i               LIKE type_t.num5

   LET l_tag = "tree_clone"

   #IF g_dzfq_m.cbo_progtype <> "Q" THEN
   IF NOT (g_dzfq_m.cbo_progtype = "Q" OR g_dzfq_m.cbo_progtype = "P") THEN
      RETURN
   END IF
   
   
   #取得Tree節點的container name
   IF p_type = "1" OR cl_null(p_tree_name) THEN
      LET l_name = "s_detail1"
   ELSE
      LET l_name = p_tree_name
   END IF
   
   #取得Tree Node
   LET l_node_list = p_node.selectByTagName("Tree")

   FOR l_i = 1 to l_node_list.getLength()
      LET l_tree_node = l_node_list.item(l_i)

      #取得公版Tree Node指定名稱"s_detail1"
      IF l_tree_node.getAttribute("name") = l_name THEN
         #取得公版Tree的子節點內容
         LET l_tree_child = l_tree_node.getFirstChild()

         WHILE l_tree_child IS NOT NULL

            CASE p_type
               WHEN "1"     #子節點加上一個tag="tree_clone"的屬性
                  CALL l_tree_child.setAttribute("tag", l_tag)

               WHEN "2"     #將子節點的tag屬性刪除
                  IF l_tree_child.getAttribute("tag") = l_tag THEN
                     CALL l_tree_child.removeAttribute("tag")
                  END IF
            END CASE
            
            LET l_tree_child = l_tree_child.getNext()
         END WHILE

         RETURN
      END IF
   END FOR
END FUNCTION

#+ 新增Q類作業欄位串查(FFLabel)
PRIVATE FUNCTION sadzp168_table_add_url(p_parent_node, p_node, p_sr_node, p_field_name, p_posX, p_posY)
   DEFINE p_parent_node  om.DomNode            #需要新增欄位節點的parent domNode
   DEFINE p_node         om.DomNode            #原欄位的domNode
   DEFINE p_sr_node      om.DomNode            #原公版的sr node
   DEFINE p_field_name   STRING                #欄位名稱
   DEFINE p_posX         LIKE type_t.num10     #Label元件X軸位置
   DEFINE p_posY         LIKE type_t.num10     #Label元件Y軸位置
   
   DEFINE l_new_child    om.DomNode            #新增欄位的子節點
   DEFINE l_sr_child     om.DomNode            #要新增的欄位
   DEFINE l_grid_height  LIKE type_t.num10
   DEFINE l_grid_width   LIKE type_t.num10
   DEFINE l_name         STRING
   DEFINE l_str          STRING
   
   #FFLabel(串查欄位):預設和高為1,寬為10
   LET l_grid_height = p_node.getAttribute("gridHeight")
   IF cl_null(l_grid_height) THEN
      LET l_grid_height = 1
   END IF

   LET l_grid_width = p_node.getAttribute("gridWidth")
   IF cl_null(l_grid_height) THEN
      LET l_grid_width = 10
   END IF

   #Q類作業欄位串查的命名規則為 "url_"開頭
   LET l_name =  "url_", p_field_name.trim()
   
   #增加欄位FFLabel只會用到fieldId,因此將值加1
   LET g_fieldId_max = g_fieldId_max + 1
   
   #Q類作業,增加串查功能(FFLabel)控件,
   LET l_new_child = p_parent_node.createChild("FFLabel")

   CALL l_new_child.setAttribute("aggregateColName", "")
   CALL l_new_child.setAttribute("aggregateName", "")
   CALL l_new_child.setAttribute("aggregateTableAliasName", "")
   CALL l_new_child.setAttribute("aggregateTableName", "")
   CALL l_new_child.setAttribute("colName", "")
   CALL l_new_child.setAttribute("columnCount", "")
   CALL l_new_child.setAttribute("fieldId", g_fieldId_max) 

   CALL l_new_child.setAttribute("fieldType", "NON_DATABASE")
   CALL l_new_child.setAttribute("name", l_name.trim())

   CALL l_new_child.setAttribute("gridHeight", l_grid_height)  
   CALL l_new_child.setAttribute("gridWidth", l_grid_width)

   CALL l_new_child.setAttribute("posX", p_posX)
   CALL l_new_child.setAttribute("posY", p_posY)
   CALL l_new_child.setAttribute("rowCount", "")
   CALL l_new_child.setAttribute("sqlTabName", "")
   CALL l_new_child.setAttribute("stepX", "")
   CALL l_new_child.setAttribute("stepY", "")
   CALL l_new_child.setAttribute("style", "textFormat_html")
   CALL l_new_child.setAttribute("sizePolicy", "")

   LET l_str = p_node.getAttribute("comment")
   CALL l_new_child.setAttribute("comment", l_str.trim())
   CALL l_new_child.setAttribute("widget", "FFLabel")
   CALL l_new_child.setAttribute("lstrcomment", "true")
   CALL l_new_child.setAttribute("lstrtitle", "true")
   CALL l_new_child.setAttribute("lstrAggregatetext", "true")
   CALL l_new_child.setAttribute("tag", "sync")

   IF p_parent_node.getTagName() = "Table" OR p_parent_node.getTagName() = "Tree" THEN
      LET l_str = p_node.getAttribute("title")
      CALL l_new_child.setAttribute("title", l_str.trim())
   END IF

   ###處理Screen Records###
   LET l_sr_child = p_sr_node.createChild("RecordField")
   CALL l_sr_child.setAttribute("fieldType", "NON_DATABASE")
   CALL l_sr_child.setAttribute("name", l_name.trim())
   CALL l_sr_child.setAttribute("colName", "")
   CALL l_sr_child.setAttribute("sqlTabName", "")
   CALL l_sr_child.setAttribute("fieldIdRef", g_fieldId_max) 
   
   RETURN l_grid_width, l_grid_height, l_name
END FUNCTION




















#+ 在新增欄位時,table container時widget後面增加reference欄位
# 150608 mail:需能有excel複製資料整份貼進Table中,將Table裡面的Label欄位改為Edit,並設為noEntry
PRIVATE FUNCTION sadzp168_table_add_reference(p_node, p_node_before, p_sr_node, p_sr_before, p_field_name, p_title, p_posX, p_posY)
   DEFINE p_node         om.DomNode            #需要新增欄位節點的domNode
   DEFINE p_node_before  om.DomNode            #欄位要新增在node節點之前
   DEFINE p_sr_node      om.DomNode            #原公版的sr node
   DEFINE p_sr_before    om.DomNode            #欄位要新增在sr node節點之前
   DEFINE p_field_name   STRING                #欄位名稱
   DEFINE p_title        STRING                #欄位title屬性
   DEFINE p_posX         LIKE type_t.num10     #Label元件X軸位置
   DEFINE p_posY         LIKE type_t.num10     #Label元件Y軸位置
   
   DEFINE l_new_child    om.DomNode            #新增欄位的子節點
   DEFINE l_sr_child     om.DomNode            #要新增的欄位
   DEFINE l_grid_height  LIKE type_t.num10
   DEFINE l_grid_width   LIKE type_t.num10
   DEFINE l_name         STRING                #FFLabel的name屬性值
   
   #Static Label(敘述):預設高為1,寬為10
   LET l_grid_height = 1 
   LET l_grid_width = 10
   LET l_name = p_field_name CLIPPED, "_desc"
   
   #table裡的reference為"Edit" widget
   CALL sadzp168_field_add_index()
      
   #當主要欄位需要有參考欄位輔助說明時,需增加reference欄位
   #exp:[地區別] [地區別名稱]
   LET l_new_child = p_node.createChild("Edit")

   CALL l_new_child.setAttribute("aggregateColName", "")
   CALL l_new_child.setAttribute("aggregateName", "")
   CALL l_new_child.setAttribute("aggregateTableAliasName", "")
   CALL l_new_child.setAttribute("aggregateTableName", "")
   CALL l_new_child.setAttribute("columnCount", "")
   CALL l_new_child.setAttribute("fieldId", g_fieldId_max) 

   CALL l_new_child.setAttribute("fieldType", "NON_DATABASE")
   CALL l_new_child.setAttribute("sqlTabName", "")
   CALL l_new_child.setAttribute("colName", "")
   CALL l_new_child.setAttribute("name", l_name.trim())

   CALL l_new_child.setAttribute("gridHeight", l_grid_height)  
   CALL l_new_child.setAttribute("gridWidth", l_grid_width)

   CALL l_new_child.setAttribute("posX", p_posX)
   CALL l_new_child.setAttribute("posY", p_posY)

   CALL l_new_child.setAttribute("noEntry", "true")

   CALL l_new_child.setAttribute("notNull", "false")
   CALL l_new_child.setAttribute("required", "false")
   CALL l_new_child.setAttribute("rowCount", "")
   CALL l_new_child.setAttribute("stepX", "")
   CALL l_new_child.setAttribute("stepY", "")
   CALL l_new_child.setAttribute("style", "reference")
   CALL l_new_child.setAttribute("tabIndex", g_tabIndex_max)
   CALL l_new_child.setAttribute("hidden", "")

   #todo:format和case屬性未設???(要問一下規格)

   CALL l_new_child.setAttribute("sizePolicy", "fixed")
   CALL l_new_child.setAttribute("comment", "cmt_" || l_name.trim())
   CALL l_new_child.setAttribute("widget", "Edit")

   CALL l_new_child.setAttribute("scroll", "true")
   CALL l_new_child.setAttribute("lstrcomment", "true")
   CALL l_new_child.setAttribute("lstrtitle", "true")
   CALL l_new_child.setAttribute("lstrAggregatetext", "true")

   CALL l_new_child.setAttribute("aggregate", "")
   CALL l_new_child.setAttribute("aggregateText", "")
   CALL l_new_child.setAttribute("aggregateType", "sum")
            

   IF p_node.getTagName() = "Table" OR p_node.getTagName() = "Tree" THEN
      CALL l_new_child.setAttribute("title", "lbl_" || p_title.trim())
   END IF
   
   #將新欄位插入在指定的節點前
   IF p_node_before IS NOT NULL THEN
      CALL p_node.insertBefore(l_new_child, p_node_before)
   END IF
   
   ###處理Screen Records###
   LET l_sr_child = p_sr_node.createChild("RecordField")
   CALL l_sr_child.setAttribute("colName", "")
   CALL l_sr_child.setAttribute("fieldIdRef", g_fieldId_max) 
   CALL l_sr_child.setAttribute("fieldType", "NON_DATABASE")
   CALL l_sr_child.setAttribute("name", l_name.trim())
   CALL l_sr_child.setAttribute("sqlTabName", "")

   #將新欄位插入在指定的sr 節點前
   IF p_sr_before IS NOT NULL THEN
      CALL p_sr_node.insertBefore(l_sr_child, p_sr_before)
   END IF
   
   RETURN l_grid_width, l_grid_height, l_new_child
END FUNCTION


