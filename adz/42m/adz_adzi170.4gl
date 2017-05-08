{<section id="adzi170.description" >}
#+ Version..: T100-ERP-1.00.00(SD版次:2,PR版次:2) Build-000438
#+
#+ Filename...: adzi170
#+ Description: SQL Querizer（Mini Toad）
#+ Creator....: 04682(2014/08/25)
#+ Modifier...: 04613(2014/09/24) -SD/PR- 04682(2014/09/24)
{
#+ Buildtype..: 應用 t01 樣板自動產生
#+ 以上段落由子樣板a00產生
}

{</section>}

{<section id="adzi170.global" >}
#add-point:註解編寫項目
#160707-00022#1 无法执行有两个及以上SELECT关键字的sql
#end add-point
#add-point:增加匯入項目
IMPORT os
IMPORT util
IMPORT xml
#IMPORT FGL lib_cl_dlg
#IMPORT security
#end add-point

SCHEMA ds

#add-point:增加匯入變數檔
GLOBALS "../../cfg/top_global.inc"
#end add-point

#單身 type 宣告
PRIVATE TYPE type_ga_table_data RECORD
            field001, field002, field003, field004, field005,
            field006, field007, field008, field009, field010,
            field011, field012, field013, field014, field015,
            field016, field017, field018, field019, field020,
            field021, field022, field023, field024, field025,
            field026, field027, field028, field029, field030,
            field031, field032, field033, field034, field035,
            field036, field037, field038, field039, field040,
            field041, field042, field043, field044, field045,
            field046, field047, field048, field049, field050,
            field051, field052, field053, field054, field055,
            field056, field057, field058, field059, field060,
            field061, field062, field063, field064, field065,
            field066, field067, field068, field069, field070,
            field071, field072, field073, field074, field075,
            field076, field077, field078, field079, field080,
            field081, field082, field083, field084, field085,
            field086, field087, field088, field089, field090,
            field091, field092, field093, field094, field095,
            field096, field097, field098, field099, field100,
            field101, field102, field103, field104, field105,
            field106, field107, field108, field109, field110,
            field111, field112, field113, field114, field115,
            field116, field117, field118, field119, field120,
            field121, field122, field123, field124, field125,
            field126, field127, field128, field129, field130,
            field131, field132, field133, field134, field135,
            field136, field137, field138, field139, field140,
            field141, field142, field143, field144, field145,
            field146, field147, field148, field149, field150,
            field151, field152, field153, field154, field155,
            field156, field157, field158, field159, field160,
            field161, field162, field163, field164, field165,
            field166, field167, field168, field169, field170,
            field171, field172, field173, field174, field175,
            field176, field177, field178, field179, field180,
            field181, field182, field183, field184, field185,
            field186, field187, field188, field189, field190,
            field191, field192, field193, field194, field195,
            field196, field197, field198, field199, field200,
            field201, field202, field203, field204, field205,
            field206, field207, field208, field209, field210,
            field211, field212, field213, field214, field215,
            field216, field217, field218, field219, field220,
            field221, field222, field223, field224, field225,
            field226, field227, field228, field229, field230,
            field231, field232, field233, field234, field235,
            field236, field237, field238, field239, field240,
            field241, field242, field243, field244, field245,
            field246, field247, field248, field249, field250
       #150906-00007#1mark(s)
          #  field251, field252, field253, field254, field255
          #  field256, field257, field258, field259, field260,
          #  field261, field262, field263, field264, field265,
          #  field266, field267, field268, field269, field270,
          #  field271, field272, field273, field274, field275,
          #  field276, field277, field278, field279, field280,
          #  field281, field282, field283, field284, field285,
          #  field286, field287, field288, field289, field290,
          #  field291, field292, field293, field294, field295,
          #  field296, field297, field298, field299, field300,
          #  field301, field302, field303, field304, field305,
          #  field306, field307, field308, field309, field310,
          #  field311, field312, field313, field314, field315,
          #  field316, field317, field318, field319, field320,
          #  field321, field322, field323, field324, field325,
          #  field326, field327, field328, field329, field330,
          #  field331, field332, field333, field334, field335,
          #  field336, field337, field338, field339, field340,
          #  field341, field342, field343, field344, field345,
          #  field346, field347, field348, field349, field350,
          #  field351, field352, field353, field354, field355,
          #  field356, field357, field358, field359, field360,
          #  field361, field362, field363, field364, field365,
          #  field366, field367, field368, field369, field370,
          #  field371, field372, field373, field374, field375,
          #  field376, field377, field378, field379, field380,
          #  field381, field382, field383, field384, field385,
          #  field386, field387, field388, field389, field390,
          #  field391, field392, field393, field394, field395,
          #  field396, field397, field398, field399, field400
            LIKE type_t.chr1000
        END RECORD
       #150906-00007#1mark(s)

#模組變數(Module Variables)
DEFINE g_erp                 STRING                        #TIPTOP起始目錄
DEFINE g_env                 LIKE dzaa_t.dzaa006           #辨識目前所在的環境:s.標準,c.客製
DEFINE g_date                DATETIME YEAR TO SECOND

DEFINE l_ac                  LIKE type_t.num5              #当前光标所在位置
DEFINE g_display_diag        ui.Dialog                     #包含Display Array的Dialog

DEFINE gwin_curr             ui.Window                     #当前Window
DEFINE gfrm_curr             ui.Form                       #当前Form

DEFINE g_detail_cnt          LIKE type_t.num5              #單身總筆數
DEFINE g_detail_idx          LIKE type_t.num5              #單身目前所在筆數
DEFINE g_tmp_idx             LIKE type_t.num5              #Table目前所在筆數(暫存用)


#add-point:自定義模組變數(Module Variable)
DEFINE g_flag                LIKE type_t.num5


###################################################################################
#DEFINE FOR adzi170
###################################################################################
CONSTANT
#   GI_MAX_COLUMN_COUNT          INTEGER = 400,                         #支持的最大列数  #150906-00007#1mark
   GI_MAX_COLUMN_COUNT          INTEGER = 250,                         #支持的最大列数   #150906-00007#1add
   GI_COLUMN_DEFAULT_WIDTH      INTEGER = 10,                          #栏位默认长度
   GI_MAX_ROW_COUNT             INTEGER = 50,                          #页面上最多单身笔数
   GS_DATE_FMT                  STRING = "'YYYY-MM-dd'"                #默认显示日期格式

DEFINE ga_table_data            DYNAMIC ARRAY OF type_ga_table_data    #单身数据数组
DEFINE ga_table_data_t          type_ga_table_data                     #单身数据备份

DEFINE g_nohidden_cnt           LIKE type_t.num5                       #顯示欄位數
DEFINE g_dbqry_rec_b            LIKE type_t.num5                       #SMALLINT:dbqry單身筆數

DEFINE gi_curr_page             INTEGER                                #当前页数
DEFINE gi_total_page_cnt        INTEGER                                #总共页数
DEFINE gi_total_record_cnt      INTEGER                                #总笔数

                                        
DEFINE ga_feld_id               DYNAMIC ARRAY OF LIKE type_t.chr100    #栏位ID(也可以理解为英文说明)
DEFINE ga_feld_alias            DYNAMIC ARRAY OF LIKE type_t.chr100
DEFINE ga_feld                  DYNAMIC ARRAY OF LIKE type_t.chr100    #栏位名称数组（先是保存用户输入的字段名，然后变成字段在表中的中文名称）
DEFINE gi_feld_cnt              LIKE type_t.num5                       #栏位数量
DEFINE ga_feld_type             DYNAMIC ARRAY OF LIKE type_t.chr30     #栏位数据类型数组
DEFINE ga_feld_length           DYNAMIC ARRAY OF LIKE type_t.chr10     #栏位数据长度数组
DEFINE ga_feld_precision        DYNAMIC ARRAY OF LIKE type_t.chr10     #栏位数据长度数组

DEFINE ga_tab                   DYNAMIC ARRAY OF STRING                #表名数组

DEFINE g_sel                    LIKE type_t.chr1                       #栏位标题显示选项（for Radiobutton）

DEFINE gs_user_input_sql        STRING                                 #用户在TextEdit控件中输入的SQL语句
DEFINE gs_user_input_sql_t      STRING                                 #用户在TextEdit控件中输入的SQL语句
DEFINE gs_analyzed_sql          STRING                                 #解析gs_user_input_sql之后的SQL语句
DEFINE gs_analyzed_feld         STRING                                 #gs_analyzed_sql中SELECT的字段
DEFINE gi_start_row             INTEGER                                #数据的开始笔数
DEFINE gi_end_row               INTEGER                                #数据的结束笔数

DEFINE gs_forupd_sql            STRING                                 #FOR UPDATE的SQL语句
DEFINE gs_forupd_where_con      STRING                                 #gs_forupd_sql中的WHERE条件部分

DEFINE gs_tmptbl_feld_toselect  STRING                                 #在临时表中需要SELECT的字段

DEFINE ga_pk_feld_id            DYNAMIC ARRAY OF  LIKE type_t.chr80   #主键栏位ID数组
                                        

DEFINE gs_tmptbl                STRING                                #临时表的名字

DEFINE gb_trans_opened          BOOLEAN                               #表示当前是否有事务开始
DEFINE g_insert                 LIKE type_t.chr5                      #表示是否是新增动作
DEFINE g_execmd                 STRING
DEFINE g_from_start_idx         LIKE type_t.num5
DEFINE g_select_end_idx         LIKE type_t.num5

DEFINE g_sqlstmt                DYNAMIC ARRAY OF RECORD
       select                   LIKE type_t.num5,
       from                     LIKE type_t.num5
       END RECORD

DEFINE g_quote                  DYNAMIC ARRAY OF RECORD
       start                    LIKE type_t.num5,
       end                      LIKE type_t.num5
       END RECORD

DEFINE gs_table_data            DYNAMIC ARRAY OF type_ga_table_data    #匯出excel數組               #150906-00007#1 add
#end add-point

#add-point:傳入參數說明(global.argv)

#end add-point

{</section>}

{<section id="adzi170.main" >}
#+ 此段落由子樣板a26產生
#OPTIONS SHORT CIRCUIT
#+ 作業開始

MAIN
   #add-point:main段define

   #end add-point

   OPTIONS
      INPUT NO WRAP
   DEFER INTERRUPT

   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log

   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("adz","")

   LET g_flag = FALSE

   IF g_bgjob = 'Y' THEN
      #add-point:Service Call

      #end add-point
   ELSE

      #畫面開啟 (identifier)
      OPEN WINDOW w_adzi170 WITH FORM cl_ap_formpath("adz",g_code)

      LET g_nohidden_cnt = 1

      #瀏覽頁簽資料初始化
      CALL cl_ui_init()

      #程式初始化
      CALL adzi170_init()



      #進入選單 Menu (="N")
      CALL adzi170_ui_dialog()

      #add-point:畫面關閉前
      CALL adzi170_rollback()
      #end add-point

      #畫面關閉
      CLOSE WINDOW w_adzi170

   END IF

    #add-point:作業離開前
    IF NOT cl_null(gs_tmptbl) THEN
        IF adzi170_invalid_tmptbl("drop") THEN
            DISPLAY "Temp table dropped..."
        END IF
    END IF

   #end add-point

   #離開作業
   CALL cl_ap_exitprogram("0")

END MAIN

{</section>}

{<section id="adzi170.init" >}
#+ 加载工具栏，动态创建Table控件并对按钮进行设置
PRIVATE FUNCTION adzi170_init()
   DEFINE l_sql        STRING
   DEFINE ln_win,
          ln_form,
          ln_vbox      om.DomNode
   DEFINE ls_vbox      om.NodeList

   LET g_erp = FGL_GETENV("ERP")
   LET g_gui_type = "1"
   LET g_env = FGL_GETENV("DGENV") #客製或標準 環境
   LET g_date = cl_get_current()
   LET g_user = FGL_GETENV("LOGNAME") #todo
   LET gwin_curr = ui.Window.getCurrent()
   LET gfrm_curr = gwin_curr.getForm()
   CALL gfrm_curr.loadToolBar(os.Path.join(g_erp,os.Path.join("cfg",os.Path.join("4tb","toolbar_adzi170.4tb"))))
   #CALL ui.Interface.loadStyles(os.Path.join(g_erp,os.Path.join("cfg",os.Path.join("4st","adzi170.4st"))))
   LET ln_form = gfrm_curr.getNode()
   LET ls_vbox = ln_form.selectByPath("//Form//VBox")
   LET ln_vbox = ls_vbox.item(1)
   #创建Table控件
   CALL adzi170_builtdTable(ln_vbox)



END FUNCTION
{</section>}

{<section id="adzi170.builtdTable" >}
#+ 动态创建Table控件
PRIVATE FUNCTION adzi170_builtdTable(pn_vbox)
   DEFINE pn_vbox            om.DomNode
   DEFINE ln_table,
          ln_table_column,
          ln_edit            om.DomNode
   DEFINE ln_grid,
          ln_formfield,
          ln_radiogroup,
          ln_item            om.DomNode
   DEFINE li_i               LIKE type_t.num10
   DEFINE ls_colname         STRING

   DEFINE ln_text            LIKE gzzd_t.gzzd005  #160317-00002#2 add 

   #在根节点下创建Table控件
   LET ln_table = pn_vbox.createChild("Table")
   #设置创建的Table控件的属性
   CALL ln_table.setAttribute("name", "s_resultset")
   CALL ln_table.setAttribute("tabName", "s_resultset")
   CALL ln_table.setAttribute("pageSize", 50)
   #CALL ln_table.setAttribute("size", 10)
   CALL ln_table.setAttribute("style", "resultset")
   CALL ln_table.setAttribute("unhidableColumns", 1)
   #在Table控件下循环创建TableColumn控件
   FOR li_i = 1 TO GI_MAX_COLUMN_COUNT
       IF li_i != GI_MAX_COLUMN_COUNT THEN
         LET ln_table_column = ln_table.createChild("TableColumn")
         LET ls_colname = "field", li_i USING "&&&"
         CALL ln_table_column.setAttribute("colName", ls_colname)
         CALL ln_table_column.setAttribute("name", "formonly." || ls_colname)
         CALL ln_table_column.setAttribute("text", ls_colname)
         CALL ln_table_column.setAttribute("noEntry", FALSE)
         #设置显示或不显示TableColumn控件
         IF li_i <= g_nohidden_cnt THEN
             CALL ln_table_column.setAttribute("hidden", FALSE)
         ELSE
             CALL ln_table_column.setAttribute("hidden", TRUE)
         END IF
         CALL ln_table_column.setAttribute("tabIndex", li_i)
         #在TableColumn控件下创建Edit文本编辑控件，并设置默认width属性
         LET ln_edit = ln_table_column.createChild("Edit")
         CALL ln_edit.setAttribute("width", GI_COLUMN_DEFAULT_WIDTH)
       ELSE
         LET ln_table_column = ln_table.createChild("TableColumn")
         LET ls_colname = "rownum"
         CALL ln_table_column.setAttribute("colName", ls_colname)
         CALL ln_table_column.setAttribute("name", "formonly." || ls_colname)
         CALL ln_table_column.setAttribute("text", ls_colname)
         CALL ln_table_column.setAttribute("noEntry", TRUE)
         #设置显示或不显示TableColumn控件
         IF li_i <= g_nohidden_cnt THEN
             CALL ln_table_column.setAttribute("hidden", FALSE)
         ELSE
             CALL ln_table_column.setAttribute("hidden", TRUE)
         END IF
         CALL ln_table_column.setAttribute("tabIndex", li_i)
         #在TableColumn控件下创建Edit文本编辑控件，并设置默认width属性
         LET ln_edit = ln_table_column.createChild("Edit")
         CALL ln_edit.setAttribute("width", GI_COLUMN_DEFAULT_WIDTH)
       END IF
   END FOR
   #创建RadioGroup控件
   LET ln_grid = pn_vbox.createChild("Grid")
   LET ln_formfield = ln_grid.createChild("FormField")
   CALL ln_formfield.setAttribute("colName","selmethod")
   CALL ln_formfield.setAttribute("name","formonly.selmethod")
   CALL ln_formfield.setAttribute("active", TRUE)
   LET ln_radiogroup = ln_formfield.createChild("RadioGroup")
   CALL ln_radiogroup.setAttribute("orientation","horizontal")
   LET ln_item = ln_radiogroup.createChild("Item")
   CALL ln_item.setAttribute("name","I")
   #160317-00002#2 mod(s)
   SELECT gzzd005 INTO ln_text FROM gzzd_t WHERE gzzd001="adzi170" AND gzzd002=g_lang AND gzzd003="Item1" 
  # DISPLAY "ln_test:",ln_text
   IF NOT cl_null(ln_text) THEN
      CALL ln_item.setAttribute("text",ln_text)
   ELSE
      CALL ln_item.setAttribute("text","显示字段ID")
   END IF

   LET ln_item = ln_radiogroup.createChild("Item")
   CALL ln_item.setAttribute("name","N")
   SELECT gzzd005 INTO ln_text FROM gzzd_t WHERE gzzd001="adzi170" AND gzzd002=g_lang AND gzzd003="Item2" 
   #DISPLAY "ln_test:",ln_text
   IF NOT cl_null(ln_text) THEN
      CALL ln_item.setAttribute("text",ln_text)
   ELSE
     CALL ln_item.setAttribute("text","显示字段名称")
   END IF
   LET ln_item = ln_radiogroup.createChild("Item")
   CALL ln_item.setAttribute("name","A")

   SELECT gzzd005 INTO ln_text FROM gzzd_t WHERE gzzd001="adzi170" AND gzzd002=g_lang AND gzzd003="Item3" 
   #DISPLAY "ln_test:",ln_text
   IF NOT cl_null(ln_text) THEN
      CALL ln_item.setAttribute("text",ln_text)
   ELSE
      CALL ln_item.setAttribute("text","显示字段ID+名称")
   END IF
   #160317-00002#2 mod(e)
END FUNCTION
{</section>}

{<section id="adzi170.ui_dialog" >}
#+ 功能選單
PRIVATE FUNCTION adzi170_ui_dialog()
    DEFINE li_result LIKE type_t.num5
    DEFINE ls_file   STRING
    DEFINE l_str     STRING
    DEFINE l_ch      base.Channel

    LET l_ac = 1
    LET g_detail_idx = l_ac

    DIALOG ATTRIBUTES(UNBUFFERED, FIELD ORDER FORM)
        INPUT gs_user_input_sql,g_sel FROM text,selmethod HELP 1
            BEFORE INPUT

            BEFORE FIELD text
                CALL adzi170_sqlinput_ui_check()

            ON CHANGE text
                CALL adzi170_sqlinput_ui_check()

            AFTER FIELD text
                CALL adzi170_sqlinput_ui_check()
                DISPLAY gs_user_input_sql

            BEFORE FIELD selmethod

            ON CHANGE selmethod
                CALL adzi170_set_table_title()

            AFTER FIELD selmethod

            AFTER INPUT

        END INPUT

        DISPLAY ARRAY ga_table_data TO s_resultset.* ATTRIBUTE (COUNT = g_dbqry_rec_b)
            BEFORE DISPLAY
                #设定Table的光标为鼠标指向的行
                CALL FGL_SET_ARR_CURR(ARR_CURR())
                #CALL DIALOG.setCurrentRow("s_resultset", DIALOG.getCurrentRow("s_resultset"))
                CALL adzi170_set_resultset_ui("initial")

            BEFORE ROW
                CALL adzi170_set_resultset_ui("aquery")
                #使用g_tmp_idx暂存当前行的行号
                LET g_detail_idx = DIALOG.getCurrentRow("s_resultset")
                LET l_ac = g_detail_idx
                LET g_tmp_idx = l_ac

        END DISPLAY

        BEFORE DIALOG
        #本程序段在整个运行期间内只会执行一次
            #初始化UI
            CALL adzi170_set_ui("initial")
            #选中第一个RadioButton
            LET g_sel = 'A'

            IF g_tmp_idx > 0 THEN
                LET l_ac = g_tmp_idx
                CALL DIALOG.setCurrentRow("s_resultset", l_ac)
                NEXT FIELD CURRENT
                LET g_tmp_idx = 1
            END IF
            LET g_display_diag = ui.DIALOG.getCurrent()

        ON ACTION connect
        #切换数据库

        ON ACTION open
            TRY
                CALL adzi170_openfile()
                    RETURNING li_result,ls_file
            CATCH
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = "Error occurred when opening file '", ls_file, "'"
                LET g_errparam.code   = '!'
                LET g_errparam.popup  = TRUE
                CALL cl_err()
            END TRY
            TRY
                IF li_result THEN
                    LET l_ch = base.Channel.create()
                    CALL l_ch.openFile(ls_file,"r")
                    WHILE TRUE
                        LET l_str = l_ch.readLine()
                        LET gs_user_input_sql = gs_user_input_sql,"\n",l_str
                        IF l_ch.isEof() THEN
                            EXIT WHILE
                      END IF
                    END WHILE
                END IF
            CATCH
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = "Error occurred when reading file '", ls_file, "'!"
                LET g_errparam.code   = '!'
                LET g_errparam.popup  = TRUE
                CALL cl_err()
            END TRY
            CALL l_ch.close()

        ON ACTION save
            TRY
                CALL adzi170_savefile()
            CATCH
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = "Error occurred when saving SQL script to local!"
                LET g_errparam.code   = '!'
                LET g_errparam.popup  = TRUE
                CALL cl_err()
            END TRY

        ON ACTION execute
           CALL adzi170_execute_sql()

        ON ACTION stop

        ON ACTION commit
            CALL adzi170_commit()

        ON ACTION rollback
            CALL adzi170_rollback()

        ON ACTION btn_first
            CALL adzi170_page_query(1)

        ON ACTION btn_previous
            LET gi_curr_page = gi_curr_page - 1
            CALL adzi170_page_query(gi_curr_page)

        ON ACTION btn_next
            LET gi_curr_page = gi_curr_page + 1
            CALL adzi170_page_query(gi_curr_page)

        ON ACTION btn_last
            CALL adzi170_page_query(gi_total_page_cnt)

        ON ACTION btn_insert
           LET g_action_choice = "insert"
           IF cl_null(gs_tmptbl) THEN
              IF adzi170_create_tmptbl() THEN
                 CALL adzi170_insert()
              END IF
           ELSE
              CALL adzi170_insert()
           END IF

        ON ACTION btn_modify
           LET g_action_choice = "modify"
           IF cl_null(gs_tmptbl) THEN
              IF adzi170_create_tmptbl() THEN
                 CALL adzi170_modify()
              END IF
           ELSE
              CALL adzi170_modify()
           END IF

        ON ACTION btn_delete
           LET g_action_choice = "delete"
           IF cl_null(gs_tmptbl) THEN
              IF adzi170_create_tmptbl() THEN
                 CALL adzi170_delete()
              END IF
           ELSE
              CALL adzi170_delete()
           END IF

        ON ACTION btn_refresh
            CALL adzi170_refresh()

        ON ACTION btn_export

   # DISPLAY "汇出excel start:",TIME(CURRENT)
           CALL adzi170_export_to_excel()  #150906-00007#1 add 
   # DISPLAY "汇出excel end:",TIME(CURRENT)
           #150906-00007#1 mark(s)
          #  CALL g_export_node.clear()
          #  LET g_export_node[1] = base.typeInfo.create(ga_table_data)
          #  CALL cl_export_to_excel()
          #150906-00007#1 mark(e) 

        ON ACTION exit
            LET INT_FLAG = TRUE
            EXIT DIALOG

        ON ACTION cancel
            LET INT_FLAG = TRUE
            EXIT DIALOG

        ON ACTION close
            LET INT_FLAG = TRUE
            EXIT DIALOG

        #主選單用ACTION
        &include "main_menu.4gl"
        &include "relating_action.4gl"
        #交談指令共用ACTION
        &include "common_action.4gl"
        CONTINUE DIALOG

    END DIALOG
END FUNCTION
{</section>}

{<section id="adzi17.openfile" >}
#+ 打开文件
PRIVATE FUNCTION adzi170_openfile()
    DEFINE ls_source_file   STRING
    DEFINE ls_target_file   STRING
    DEFINE ls_file_name     STRING

    CALL ui.Interface.frontCall("standard",
                                "openfile",
                                ["C:", "All Files", "*.*", "Open File"],
                                [ls_source_file])
    IF STATUS THEN
        RETURN FALSE,NULL
    END IF

    CALL os.Path.basename(ls_source_file)
        RETURNING ls_file_name

    LET ls_target_file = os.Path.join(FGL_GETENV("TEMPDIR"), ls_file_name)
    #从用户终端下载文件到临时目录
    CALL FGL_GETFILE(ls_source_file, ls_target_file)
    IF STATUS THEN
        RETURN FALSE,NULL
    ELSE
        RETURN TRUE,ls_target_file
    END IF

END FUNCTION
{</section>}

{<section id="adzi170.savefile" >}
#+ 保存文件
PRIVATE FUNCTION adzi170_savefile()
    DEFINE ls_source_file     STRING
    DEFINE ls_target_file     STRING
    DEFINE ls_directory       STRING
    DEFINE lc_ch              base.Channel
    DEFINE ls_str             STRING

    CALL ui.Interface.frontCall("standard",
                                "savefile",
                                ["C:", "SQL Script File", "*.sql", "Save File"],
                                [ls_target_file])
    LET ls_source_file = os.Path.basename(ls_target_file)

    LET lc_ch = base.Channel.create()
    #在临时目录创建新文件并上传到用户终端
    CALL lc_ch.openFile(os.Path.join(FGL_GETENV("TEMPDIR"),ls_source_file), 'w')
    CALL lc_ch.writeLine(gs_user_input_sql)
    CALL FGL_PUTFILE(ls_source_file,ls_target_file)
    CALL lc_ch.close()

END FUNCTION
{</section>}

{<section id="adzi170.execute_sql" >}
#+ 执行SQL并显示结果
PRIVATE FUNCTION adzi170_execute_sql()
    DEFINE l_text            STRING
    DEFINE l_str             STRING

    DEFINE l_tmp             STRING
    DEFINE l_tok             base.StringTokenizer
    DEFINE l_start           LIKE type_t.num5          #No.FUN-680135 SMALLINT
    DEFINE l_end             LIKE type_t.num5          #No.FUN-680135 SMALLINT

    DEFINE l_tab_name        LIKE type_t.chr20         #表名（暂存）
    DEFINE l_feld            LIKE type_t.chr20         #用户输入的字段名（暂存）

    DEFINE l_str_len         INTEGER                   #用户输入的SQL语句的长度
    DEFINE l_index           STRING                    #某个字符串的位置
    DEFINE l_where           STRING                    #用户输入的SQL语句中where的部分，需要预存起来

    LET g_nohidden_cnt = 1

    #需要执行的操作
    #1.格式化SQL语句
    #2.判断是否为SELECT语句(因为该作业有设定只能执行SELECT语句)
    #3.确定SQL语句的正确性
    #4.获取列的详细信息(通过建立临时表,若字段有别名,则将别名写入ga_feld_alias中;若字段没有别名,则将真实名称写入ga_feld_alias中)
    #5.格式化SELECT子句中的字段
    #  (由于Genero无法动态定义RECORD变量,所以只能使用400个VARCHAR类型的变量存储SELECT子句的结果,
    #   所以如果直接SELECT会导致数值或者日期类型的字段值赋值给VARCHAR类型的变量时,导致格式错乱,
    #   因此,需要对SELECT子句中的字段做相关处理)
    #  备注:在实现该步骤时遇到了如下问题:
    #  (1)如果在SELECT子句中出现函数处理且没有采用别名进行命名,那么建立临时表时,列名直接为对应的函数,比如COUNT(*),
    #     此时如果直接采用嵌套SQL的方式进行处理,得到的结果集是错误的.
    #     例如:原SQL为:SELECT COUNT(*) FROM xmda_t,处理后变成SELECT TO_CHAR(COUNT(*)) FROM (SELECT COUNT(*) FROM xmda_t))
    #     所以不能简单的采用嵌套SQL的方式进行处理;
    #     如果在SELECT子句中的某些列使用了别名,如果在当前的SELECT子句处理,就必须区分出列的原名及列的别名,否则直接对列的别名进行TO_CHAR处理,肯定会出现问题
    #     例如:原SQL为:SELECT COUNT(*) cnt FROM xmda_t,处理后变成SELECT COUNT(*) TO_CHAR(cnt) FROM xmda_t
    #     所以,为了同时考虑到上述2种情形,应该是不能采用嵌套SQL的方式处理,所以必须在当前的SELECT子句中区分出列的原名称及列的别名
    #  (2)在区分当前SELECT子句的原名与别名时遇到了如下的情形
    #     (A)若SELECT子句中的字段为"tab.*"格式,那么临时表中的字段在原SELECT子句中是查找不到的
    #     (B)若SELECT子句中的字段为"COUNT (*) ",在临时表的字段则会变为"count(*)"
    #     (C)若SELECT子句中的字段为"'XA-'||xmda001",在临时表中的字段则会变为"'xa-'||xmda001"
    #  (3)之前考虑的解析方式是这样的(下述的论述基于若采用了别名,则肯定能在SELECT子句中找到):
    #     (A)若在SELECT子句中能找到临时表中所指的字段名,则需要判断在上一个字段的截止位置到该字段的起始位置前是否为空,
    #          若为空,说明该字段也是列的原名;若不为空,则说明该字段还有另外的原名
    #     (B)若在SELECT子句中找不到临时表中所指的字段名,则说明该名称肯定为原名
    #  (4)采用上述的解析方式遇到的问题是:
    #     (A)若在SELECT子句中找不到临时表所指的字段名,此时该名称未必完全等同于SELECT子句中列的原名(比如出现"XA-'||xmda001的形式)
    #     (B)上一个字段的截止位置计算有误
    #  结束语:上述的2个问题可以解决,但是在想是否仍有没有考虑到的情形,所以暂时先不对结果解的格式进行控管
    #6.判断执行的SQL语句是否为简单SELECT语句(只涉及到单表且SELECT的列没有函数处理或者连接处理)
    #7.若为简单SELECT,获取对应表的主键,为后续的画面及结果集操做准备
    #8.若为简单SELECT,为编辑结果集做准备
    #  (由于在编辑结果集时,需要执行UPDATE/INSERT语句,但是UPDATE/INSERT结果集的列是无法写成固定的,所以需要借助临时表来实现)
    #9.执行格式化后的SQL语句,并进行分页处理
    #10.按照用户设定显示结果集

    IF INT_FLAG = 0 THEN

       IF cl_null(gs_user_input_sql_t) OR gs_user_input_sql <> gs_user_input_sql_t THEN
          IF gb_trans_opened THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = 'adz-00415'
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN
          END IF

          #初始化需要用到的全局变量
          LET ga_table_data = NULL
          LET ga_feld = NULL
          LET ga_tab = NULL
          LET gi_feld_cnt = NULL
          LET ga_feld_id = NULL
          LET ga_feld_alias = NULL
          LET ga_feld_type = NULL
          LET ga_feld_length = NULL
          LET ga_pk_feld_id = NULL
    

          #1.格式化SQL语句
          CALL adzi170_handle_sql_format()
          
          #2.判断是否为SELECT语句
          LET l_str = g_execmd
          LET l_str = l_str.subString(1,6)
          LET l_str=l_str.toLowerCase() #160707-00022#1 add .toLowerCase()
          IF l_str <> "select" THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code   = 'adz-00419'
             LET g_errparam.popup  = TRUE
             CALL cl_err()
             RETURN
          END IF    
          
          #3.判断SQL语句是否存在语法问题
          IF NOT adzi170_judge_sql_syntax() THEN
             RETURN
          END IF
          
          #4.获取列的详细信息
          IF NOT adzi170_get_columns_info() THEN
             RETURN
          END IF
          
          #5.格式化SELECT子句中的字段(暂不考虑)
          #CALL adzi170_get_select_pos()
          #CALL adzi170_get_quote_pos()
          #CALL adzi170_handle_field_format()
          LET gs_analyzed_sql = g_execmd
          
          #6.判断执行的SQL语句简单的SELECT语句
          CALL adzi170_judge_simple_sql()
          
          #7.若为简单SQL语句,获取对应表的主键
          IF NOT cl_null(ga_tab[1]) THEN
             CALL adzi170_get_pk_feld_id()
          END IF

          #8.得到在临时表中需要SELECT的字段
          IF NOT cl_null(ga_tab[1]) THEN
             CALL adzi170_get_tmptbl_feld_toselect() RETURNING gs_tmptbl_feld_toselect
          END IF
       END IF

       #9.执行格式化后的SQL语句,并进行分页处理
       CALL adzi170_page_query(1)

       #10.按照用户设定显示结果
       CALL g_display_diag.setCurrentRow("s_resultset",1)

       LET gs_user_input_sql_t = gs_user_input_sql

    END IF

END FUNCTION
{</section>}

{<section id="adzi170.get_tmptbl_feld_toselect" >}
#+ 返回在临时表中需要SELECT字段的SQL
PRIVATE FUNCTION adzi170_get_tmptbl_feld_toselect()
   DEFINE li_i              INTEGER
   DEFINE ls_feld_id        STRING
   DEFINE ls_number_fmt     STRING

   DEFINE ls_result         STRING

   FOR li_i = 1 TO gi_feld_cnt
      LET ls_feld_id = "field", li_i USING "&&&"

      #对目标表的不同数据类型做转换
      CASE ga_feld_type[li_i]
         WHEN "varchar2"

         WHEN "date"
             LET ls_feld_id = "TO_DATE(", ls_feld_id, ", ", GS_DATE_FMT , ")"

         WHEN "number"
             CALL adzi170_get_number_format(ga_feld_length[li_i]) RETURNING ls_number_fmt
             LET ls_feld_id = "TO_NUMBER(", ls_feld_id, ",'", ls_number_fmt, "')"

         WHEN "blob"
             #LET ls_feld_id = "'<BLOB>' ", ga_feld_id[li_i]

         WHEN "clob"
             #LET ls_feld_id = "'<CLOB>' ", ga_feld_id[li_i]

         WHEN "timestamp"
             LET ls_feld_id = " TO_TIMESTAMP(", ls_feld_id, ", '", adzi170_get_timestamp_format(ga_feld_length[li_i]), "') "

         OTHERWISE

      END CASE

      LET ls_result = ls_result, ls_feld_id

      IF li_i != gi_feld_cnt THEN
          LET ls_result = ls_result, ", "
      ELSE
          LET ls_result = ls_result, " "
      END IF
   END FOR

   RETURN ls_result
END FUNCTION
{</section>}

{<section id="adzi170.get_pk_feld_id" >}
#+ 获取所有主键栏位ID
PRIVATE FUNCTION adzi170_get_pk_feld_id()
    DEFINE li_i             INTEGER
    DEFINE l_tab_name       LIKE type_t.chr20

    LET l_tab_name = ga_tab[1]
    DECLARE pk_feld_c CURSOR FOR
        SELECT dzeb002
        FROM dzeb_t
        WHERE dzeb001 = l_tab_name
        AND dzeb004 = 'Y'
        ORDER BY dzeb021, dzeb002
    IF SQLCA.SQLCODE THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.extend = SQLCA.SQLERRD[2]
        LET g_errparam.code   = SQLCA.SQLCODE
        LET g_errparam.popup  = FALSE
        CALL cl_err()
        RETURN
    END IF

    LET li_i = 1
    FOREACH pk_feld_c INTO ga_pk_feld_id[li_i]
        LET li_i = li_i + 1
    END FOREACH
    IF SQLCA.SQLCODE THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.extend = SQLCA.SQLERRD[2]
        LET g_errparam.code   = SQLCA.SQLCODE
        LET g_errparam.popup  = FALSE
        CALL cl_err()
        RETURN
    END IF
    FREE pk_feld_c
    CALL ga_pk_feld_id.deleteElement(li_i)

END FUNCTION
{</section>}

{<section id="adzi170.handle_field_with_tochar" >}
#+ 使用TO_CHAR函数在SQL中处理字段显示在画面上的精度问题
PRIVATE FUNCTION adzi170_handle_field_format()
    DEFINE ls_analyzed_feld     STRING
    DEFINE ls_sql               STRING
    DEFINE li_i                 INTEGER
    DEFINE ls_tmp               STRING
    DEFINE ls_from_sql          STRING
    DEFINE ls_select_sql        STRING

    CALL adzi170_get_field_alias()

    #遍历每个字段的数据类型，如果不是VARCHAR2类型，则使用数据库的to_char函数进行格式化
    FOR li_i = 1 TO gi_feld_cnt
        CASE ga_feld_type[li_i]
            WHEN "varchar2"
                #LET ls_analyzed_feld = ls_analyzed_feld, ga_feld_id[li_i]
                LET ls_analyzed_feld = ls_analyzed_feld, ga_feld_id[li_i]," ",ga_feld_alias[li_i]

            WHEN "date"
                #LET ls_analyzed_feld = ls_analyzed_feld, "TO_CHAR(", ga_feld_id[li_i], ", ", GS_DATE_FMT , ") ", ga_feld_id[li_i]  #mark by wangxy 20141020
                LET ls_analyzed_feld = ls_analyzed_feld, "TO_CHAR(", ga_feld_id[li_i], ", ", GS_DATE_FMT , ") ", ga_feld_alias[li_i]  #modify by wangxy 20141020

            WHEN "timestamp"
                CALL adzi170_get_timestamp_format(ga_feld_length[li_i]) RETURNING ls_tmp
                #LET ls_analyzed_feld = ls_analyzed_feld, "TO_CHAR(", ga_feld_id[li_i], ", '", ls_tmp , "') ", ga_feld_id[li_i]   #mark by wangxy 20141020
                LET ls_analyzed_feld = ls_analyzed_feld, "TO_CHAR(", ga_feld_id[li_i], ", '", ls_tmp , "') ", ga_feld_alias[li_i]   #modify by wangxy 20141020

            WHEN "number"
                #LET ls_analyzed_feld = ls_analyzed_feld, "TO_CHAR(", ga_feld_id[li_i], ") ", ga_feld_id[li_i]   #mark by wangxy 201401020
                LET ls_analyzed_feld = ls_analyzed_feld, "TO_CHAR(", ga_feld_id[li_i], ") ", ga_feld_alias[li_i]   #modify by wangxy 201401020

            WHEN "blob"
                LET ls_analyzed_feld = ls_analyzed_feld, "'<BLOB>' ", ga_feld_id[li_i]

            WHEN "clob"
                #LET ls_analyzed_feld = ls_analyzed_feld, "TO_CHAR(", ga_feld_id[li_i], ") ", ga_feld_id[li_i]  #mark by wangxy 20141020
                LET ls_analyzed_feld = ls_analyzed_feld, "TO_CHAR(", ga_feld_id[li_i], ") ", ga_feld_alias[li_i]  #modify by wangxy 20141020

            OTHERWISE
                LET ga_feld_type[li_i] = "varchar2"
                LET ls_analyzed_feld = ls_analyzed_feld, "TO_CHAR(", ga_feld[li_i], ")"
                LET ga_feld_id[li_i] = ga_feld[li_i]

        END CASE
        IF li_i != gi_feld_cnt THEN
            LET ls_analyzed_feld = ls_analyzed_feld, ", "
        END IF
    END FOR

    LET gs_analyzed_feld = ls_analyzed_feld
    #LET ls_sql = ls_sql, ls_analyzed_feld, " ", ls_from_start
    #LET ls_sql = " SELECT ",gs_analyzed_feld," ",
    #             "   FROM (",g_execmd,") "
    
    LET ls_select_sql = g_execmd.subString(1,g_select_end_idx)
    LET ls_from_sql = g_execmd.subString(g_sqlstmt[1].from,g_execmd.getLength())
    LET ls_sql = ls_select_sql," ",ls_analyzed_feld," ",ls_from_sql

    #解析完毕，存到全局变量
    LET gs_analyzed_sql = ls_sql

END FUNCTION
{</section>}

{<section id="adzi170.check_selected_field" >}
#+ 检查用户输入的SELECT语句中的字段
PRIVATE FUNCTION adzi170_check_selected_field()
    DEFINE li_i                INTEGER
    DEFINE li_input_pk_cnt     INTEGER #用户输入的SQL语句中主键的数量

    IF cl_null(ga_tab[1]) THEN
       #超过1张表，无法增删改
       RETURN FALSE
    END IF

    FOR li_i = 1 TO gi_feld_cnt
       IF adzi170_feld_type(ga_feld_id[li_i], "pk") THEN
           LET li_input_pk_cnt = li_input_pk_cnt + 1
       END IF
    END FOR
    IF li_input_pk_cnt != ga_pk_feld_id.getLength() THEN
       #主键数量太少，无法增删改
       RETURN FALSE
    END IF

    RETURN TRUE
END FUNCTION
{</section>}

{<section id="adzi170.set_table_title" >}
#+ 当画面下方的RadioButton有变化时，调用此函数改变Table控件中显示的列名
PRIVATE FUNCTION adzi170_set_table_title()
   DEFINE lw_w             ui.window
   DEFINE ln_w,
          ln_table_column  om.DomNode
   DEFINE ls_items         om.NodeList
   DEFINE li_i             INTEGER

   #设置栏位属性
   LET lw_w = ui.window.getcurrent()
   LET ln_w = lw_w.getNode()
   LET ls_items = ln_w.selectByTagName("TableColumn")
   FOR li_i = 1 TO gi_feld_cnt
      LET ln_table_column = ls_items.item(li_i)
      #设置画面上的表格列显示的文本
      CASE g_sel
          WHEN 'I'
             IF cl_null(ga_feld_alias[li_i]) THEN
                CALL ln_table_column.setAttribute("text", ga_feld_id[li_i])
             ELSE
                CALL ln_table_column.setAttribute("text", ga_feld_alias[li_i])
             END IF

          WHEN 'N'
              CALL ln_table_column.setAttribute("text", ga_feld[li_i])

          WHEN 'A'
             IF cl_null(ga_feld_alias[li_i]) THEN
                CALL ln_table_column.setAttribute("text", ga_feld_id[li_i] || "(" || ga_feld[li_i] || ")")
             ELSE
                CALL ln_table_column.setAttribute("text", ga_feld_alias[li_i] || "(" || ga_feld[li_i] || ")")
             END IF

          OTHERWISE
             IF cl_null(ga_feld_alias[li_i]) THEN
                CALL ln_table_column.setAttribute("text", ga_feld_id[li_i])
             ELSE
                CALL ln_table_column.setAttribute("text", ga_feld_alias[li_i])
             END IF

      END CASE
   END FOR
END FUNCTION
{</section>}

{<section id="adzi170.set_ui_after_analyze" >}
#+ 解析完SQL后的设置UI上Table的栏位属性
PRIVATE FUNCTION adzi170_set_table_ui_after_analyze()
   DEFINE lw_w             ui.window
   DEFINE ln_table_column  om.DomNode
   DEFINE ln_edit          om.DomNode
   DEFINE ln_btnedit       om.DomNode
   DEFINE ln_w             om.DomNode
   DEFINE ls_items         om.NodeList
   DEFINE ls_colname       STRING
   DEFINE li_i             INTEGER

   #设置栏位属性
   LET lw_w = ui.window.getcurrent()
   LET ln_w = lw_w.getNode()
   LET ls_items = ln_w.selectByTagName("TableColumn")
   FOR li_i = 1 TO gi_feld_cnt
       LET ln_table_column = ls_items.item(li_i)
       CALL ln_table_column.setAttribute("colName", ls_colname)
       CALL ln_table_column.setAttribute("name", "formonly." || ga_feld_id[li_i])
       #设置画面上的表格列显示的文本
       CASE g_sel
           WHEN 'I'
              IF cl_null(ga_feld_alias[li_i]) THEN
                 CALL ln_table_column.setAttribute("text", ga_feld_id[li_i])
              ELSE
                 CALL ln_table_column.setAttribute("text", ga_feld_alias[li_i])
              END IF

           WHEN 'N'
              CALL ln_table_column.setAttribute("text", ga_feld[li_i])

           WHEN 'A'
              IF cl_null(ga_feld_alias[li_i]) THEN
                 CALL ln_table_column.setAttribute("text", ga_feld_id[li_i] || "(" || ga_feld[li_i] || ")")
              ELSE
                 CALL ln_table_column.setAttribute("text", ga_feld_alias[li_i] || "(" || ga_feld[li_i] || ")")
              END IF

           OTHERWISE
              IF cl_null(ga_feld_alias[li_i]) THEN
                 CALL ln_table_column.setAttribute("text", ga_feld_id[li_i])
              ELSE
                 CALL ln_table_column.setAttribute("text", ga_feld_alias[li_i])
              END IF
       END CASE

       CALL ln_table_column.setAttribute("noEntry", 0)
       CALL ln_table_column.setAttribute("hidden", 0)

       CASE ga_feld_type[li_i]
           WHEN "varchar2"
               CALL ln_table_column.setAttribute("sqlType", "VARCHAR")
               #在TableColumn控件下找到Edit文本编辑控件，并设置相应属性
               LET ln_edit = ln_table_column.getChildByIndex(1)
               CALL ln_edit.setAttribute("width", ga_feld_length[li_i])
               IF adzi170_feld_type(ga_feld_id[li_i], "pk") THEN
                   CALL ln_table_column.setAttribute("required", TRUE)
                   CALL ln_table_column.setAttribute("notNull", TRUE)
                   CALL ln_edit.setAttribute("style", "required")
               ELSE
                   CALL ln_table_column.setAttribute("required", FALSE)
                   CALL ln_table_column.setAttribute("notNull", FALSE)
                   CALL ln_edit.setAttribute("style", "0")
               END IF
               CALL ln_edit.setAttribute("justify", "left")
               #CALL ln_edit.setAttribute("width", adzi170_get_col_width_for_tbl(ga_feld_length[li_i]))   #mark by wangxy 20141023

           WHEN "date"
               CALL ln_table_column.setAttribute("sqlType", "DATE")
               #在TableColumn控件下找到Edit文本编辑控件，并设置相应属性
               LET ln_edit = ln_table_column.getChildByIndex(1)
               CALL ln_edit.setAttribute("width", ga_feld_length[li_i])
               #CALL ln_edit.setAttribute("width", 10)
               #CALL ln_edit.setAttribute("maxLength", 10)
               IF adzi170_feld_type(ga_feld_id[li_i], "pk") THEN
                   CALL ln_table_column.setAttribute("required", TRUE)
                   CALL ln_table_column.setAttribute("notNull", TRUE)
                   CALL ln_edit.setAttribute("style", "required")
               ELSE
                   CALL ln_table_column.setAttribute("required", FALSE)
                   CALL ln_table_column.setAttribute("notNull", FALSE)
                   CALL ln_edit.setAttribute("style", "0")
               END IF
               CALL ln_edit.setAttribute("justify", "left")
               #CALL ln_edit.setAttribute("width", adzi170_get_col_width_for_tbl(ga_feld_length[li_i]))   #mark by wangxy 20141023

           WHEN "timestamp"
               CALL ln_table_column.setAttribute("sqlType", "DATETIME")
               #在TableColumn控件下找到Edit文本编辑控件，并设置相应属性
               LET ln_edit = ln_table_column.getChildByIndex(1)
               CALL ln_edit.setAttribute("width", ga_feld_length[li_i])
               IF adzi170_feld_type(ga_feld_id[li_i], "pk") THEN
                   CALL ln_table_column.setAttribute("required", TRUE)
                   CALL ln_table_column.setAttribute("notNull", TRUE)
                   CALL ln_edit.setAttribute("style", "required")
               ELSE
                   CALL ln_table_column.setAttribute("required", FALSE)
                   CALL ln_table_column.setAttribute("notNull", FALSE)
                   CALL ln_edit.setAttribute("style", "0")
               END IF
               CALL ln_edit.setAttribute("justify", "left")
               #CALL ln_edit.setAttribute("width", adzi170_get_col_width_for_tbl(ga_feld_length[li_i]))   #mark by wangxy 20141023

           WHEN "number"
               CALL ln_table_column.setAttribute("sqlType", "NUMBER")
               #在TableColumn控件下找到Edit文本编辑控件，并设置相应属性
               LET ln_edit = ln_table_column.getChildByIndex(1)
               CALL ln_edit.setAttribute("width", ga_feld_length[li_i])
               IF adzi170_feld_type(ga_feld_id[li_i], "pk") THEN
                   CALL ln_table_column.setAttribute("required", TRUE)
                   CALL ln_table_column.setAttribute("notNull", TRUE)
                   CALL ln_edit.setAttribute("style", "required")
               ELSE
                   CALL ln_table_column.setAttribute("required", FALSE)
                   CALL ln_table_column.setAttribute("notNull", FALSE)
                   CALL ln_edit.setAttribute("style", "0")
               END IF
               CALL ln_edit.setAttribute("justify", "right")
               #CALL ln_edit.setAttribute("width", adzi170_get_col_width_for_tbl(ga_feld_length[li_i]))   #mark by wangxy 20141023

           WHEN "blob"
               CALL ln_table_column.setAttribute("sqlType", "BYTE")
               #在TableColumn控件下移除Edit文本编辑控件
               LET ln_edit = ln_table_column.getChildByIndex(1)
               CALL ln_table_column.removeChild(ln_edit)
               #创建ButtonEdit编辑控件，并设置相应属性
               LET ln_btnedit = ln_table_column.createChild("ButtonEdit")
               CALL ln_btnedit.setAttribute("width", ga_feld_length[li_i])
               CALL ln_btnedit.setAttribute("name", "blob" || li_i USING "&&&")
               CALL ln_btnedit.setAttribute("text", "<BLOB>")

               IF adzi170_feld_type(ga_feld_id[li_i], "pk") THEN
                   CALL ln_table_column.setAttribute("required", TRUE)
                   CALL ln_table_column.setAttribute("notNull", TRUE)
                   CALL ln_btnedit.setAttribute("style", "required")
               ELSE
                   CALL ln_table_column.setAttribute("required", FALSE)
                   CALL ln_table_column.setAttribute("notNull", FALSE)
                   CALL ln_btnedit.setAttribute("style", "0")
               END IF
               CALL ln_btnedit.setAttribute("justify", "left")
               #CALL ln_edit.setAttribute("width", adzi170_get_col_width_for_tbl(ga_feld_length[li_i]))   #mark by wangxy 20141023

           WHEN "clob"
               CALL ln_table_column.setAttribute("sqlType", "TEXT")
               #在TableColumn控件下移除Edit文本编辑控件
               LET ln_edit = ln_table_column.getChildByIndex(1)
               CALL ln_table_column.removeChild(ln_edit)
               #创建ButtonEdit编辑控件，并设置相应属性
               LET ln_btnedit = ln_table_column.createChild("ButtonEdit")
               CALL ln_btnedit.setAttribute("width", ga_feld_length[li_i])
               CALL ln_btnedit.setAttribute("name", "clob" || li_i USING "&&&")
               CALL ln_btnedit.setAttribute("text", "<CLOB>")

               IF adzi170_feld_type(ga_feld_id[li_i], "pk") THEN
                   CALL ln_table_column.setAttribute("required", TRUE)
                   CALL ln_table_column.setAttribute("notNull", TRUE)
                   CALL ln_btnedit.setAttribute("style", "required")
               ELSE
                   CALL ln_table_column.setAttribute("required", FALSE)
                   CALL ln_table_column.setAttribute("notNull", FALSE)
                   CALL ln_btnedit.setAttribute("style", "0")
               END IF
               CALL ln_btnedit.setAttribute("justify", "left")
               #CALL ln_edit.setAttribute("width", adzi170_get_col_width_for_tbl(ga_feld_length[li_i]))   #mark by wangxy 20141023

           OTHERWISE
               CALL ln_table_column.setAttribute("sqlType", "CHAR")
               #在TableColumn控件下创建Edit文本编辑控件，并设置相应属性
               LET ln_edit = ln_table_column.createChild("Edit")
               CALL ln_edit.setAttribute("width", ga_feld_length[li_i])
               IF adzi170_feld_type(ga_feld_id[li_i], "pk") THEN
                   CALL ln_table_column.setAttribute("required", TRUE)
                   CALL ln_table_column.setAttribute("notNull", TRUE)
                   CALL ln_edit.setAttribute("style", "required")
               ELSE
                   CALL ln_table_column.setAttribute("required", FALSE)
                   CALL ln_table_column.setAttribute("notNull", FALSE)
                   CALL ln_edit.setAttribute("style", "0")
               END IF
               CALL ln_edit.setAttribute("justify", "right")
               #CALL ln_edit.setAttribute("width", adzi170_get_col_width_for_tbl(ga_feld_length[li_i]))   #mark by wangxy 20141023
       END CASE
   END FOR

   FOR li_i = gi_feld_cnt + 1 TO GI_MAX_COLUMN_COUNT
       LET ln_table_column = ls_items.item(li_i)
       LET ls_colname = "field", li_i USING "&&&"
       CALL ln_table_column.setAttribute("colName", ls_colname)
       CALL ln_table_column.setAttribute("name", "formonly." || ls_colname)
       CALL ln_table_column.setAttribute("text", ls_colname)
       CALL ln_table_column.setAttribute("noEntry", 1)
       CALL ln_table_column.setAttribute("required", FALSE)
       CALL ln_table_column.setAttribute("notNull", FALSE)
       LET ln_edit = ln_table_column.getChildByIndex(1)
       CALL ln_edit.setAttribute("style", "0")
      #FUN-9C0036 -- start --
       IF gi_feld_cnt = 0 AND li_i <= g_nohidden_cnt THEN
           CALL ln_table_column.setAttribute("hidden", 0)
       ELSE
           CALL ln_table_column.setAttribute("hidden", 1)
       END IF
       #FUN-9C0036 -- end --
   END FOR

END FUNCTION
{</section>}

{<section id="adzi170.sqlinput_ui_set">}
#+ 在文本框内输入SQL时的UI检查
PRIVATE FUNCTION adzi170_sqlinput_ui_check()
    IF NOT cl_null(gs_user_input_sql) THEN
        #CALL cl_set_act_visible("execute", TRUE)
        CALL cl_set_act_visible("save", TRUE)
    ELSE
        #CALL cl_set_act_visible("execute", FALSE)
        CALL cl_set_act_visible("save", FALSE)
    END IF
END FUNCTION
{</section>}

{<section id="adzi170.modify" >}
#+ 資料修改
PRIVATE FUNCTION adzi170_modify()
    DEFINE  l_cmd                  LIKE type_t.chr1
    DEFINE  l_ac_t                 LIKE type_t.num5                #未取消的ARRAY CNT
    DEFINE  l_n                    LIKE type_t.num5                #檢查重複用
    DEFINE  l_cnt                  LIKE type_t.num5                #檢查重複用
    DEFINE  l_lock_sw              LIKE type_t.chr1                #單身鎖住否
    DEFINE  l_allow_insert         LIKE type_t.num5                #可新增否
    DEFINE  l_allow_delete         LIKE type_t.num5                #可刪除否
    DEFINE  l_count                LIKE type_t.num5
    DEFINE  l_i                    LIKE type_t.num5
    DEFINE  ls_return              STRING

    DEFINE  ls_tmptbl              STRING
    DEFINE  ls_sql                 STRING
    #add-point:modify段define

    #add-point:modify開始前

    #end add-point

    LET INT_FLAG = FALSE

    LET l_allow_insert = cl_auth_detail_input('insert')
    LET l_allow_delete = cl_auth_detail_input('delete')

    DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

        INPUT ARRAY ga_table_data FROM s_resultset.*
            ATTRIBUTE(COUNT = g_detail_cnt,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS,
                     INSERT ROW = l_allow_insert,
                     DELETE ROW = l_allow_delete,
                     APPEND ROW = l_allow_insert)

        BEFORE INPUT
            IF g_insert = 'Y' AND NOT cl_null(g_insert) THEN
               LET g_insert = 'N'
            END IF
            LET g_detail_cnt = ga_table_data.getLength()

        BEFORE ROW
            #如果临时表已经存在，则先将临时表数据清空
            IF NOT cl_null(gs_tmptbl) THEN
                IF adzi170_invalid_tmptbl("delete") THEN
                    LET g_detail_idx = DIALOG.getCurrentRow("s_resultset")
                    LET l_cmd = ''
                    LET l_ac = g_detail_idx
                    LET l_lock_sw = 'N'
                    LET l_n = ARR_COUNT()

                    #在修改状态时，光标定位在表格的最下行，表示新增
                    #此时会走BEFORE INSERT段
                    IF  NOT cl_null(g_action_choice)
                        AND g_action_choice == "modify"
                        AND l_ac > l_n
                    THEN
                        LET g_action_choice = "insert"
                    END IF

                    IF  NOT cl_null(g_action_choice)
                        AND g_action_choice == "modify"
                    THEN
                        LET l_cmd = 'u'
                        LET ga_table_data_t.* = ga_table_data[l_ac].*

                        CALL s_transaction_begin()
                        LET gb_trans_opened = TRUE
                        LET g_detail_cnt = ga_table_data.getLength()
                        CALL adzi170_set_ui("bmodify")

                        CALL adzi170_get_upd_sql(gs_tmptbl)
                        PREPARE adzi170_s FROM gs_forupd_sql
                        DECLARE adzi170_bcl CURSOR FOR adzi170_s

                        IF NOT adzi170_lock_b() THEN
                            LET l_lock_sw='Y'
                            RETURN
                        ELSE
                            FETCH adzi170_bcl INTO ga_table_data[l_ac].*
                            IF SQLCA.SQLCODE THEN
                                INITIALIZE g_errparam TO NULL
                                LET g_errparam.extend = SQLCA.SQLERRD[2]
                                LET g_errparam.code   = SQLCA.SQLCODE
                                LET g_errparam.popup  = TRUE
                                CALL cl_err()

                                LET l_lock_sw = 'Y'
                            END IF
                            #CALL cl_show_fld_cont()
                        END IF
                    ELSE
                        LET l_cmd = 'a'
                        #LET g_action_choice = "insert"
                        #光标在表格数据的某一行上
                        IF g_detail_cnt >= l_ac THEN
                            CALL ga_table_data.insertElement(l_ac)
                            CALL FGL_SET_ARR_CURR(l_ac)
                            LET l_n = ARR_COUNT()

                            CALL s_transaction_begin()
                            LET gb_trans_opened = TRUE

                            CALL adzi170_set_ui("binsert")
                            INITIALIZE ga_table_data_t.* TO NULL
                            INITIALIZE ga_table_data[l_ac].* TO NULL

                            #GOTO _before_insert
                        END IF
                    END IF
                END IF
            END IF

        BEFORE INSERT
            LET l_cmd = 'a'
            LET l_n = ARR_COUNT()
            CALL s_transaction_begin()
            LET gb_trans_opened = TRUE

            CALL adzi170_set_ui("binsert")
            INITIALIZE ga_table_data_t.* TO NULL
            INITIALIZE ga_table_data[l_ac].* TO NULL

        ON ROW CHANGE
            IF g_action_choice == "insert" {AND adzi170_check_form_cols()} THEN
                IF adzi170_insert_current_data_to_tmptbl() #将输入的数据插入临时表
                AND adzi170_insert_to_target_table() #将临时表中的数据插入目标表
                THEN
                    ERROR 'INSERT O.K'
                    LET g_detail_cnt = g_detail_cnt + 1
                    LET g_action_choice = "modify"
                    #LET g_detail_idx = g_detail_idx + 1
                    #CALL DIALOG.setCurrentRow("s_resultset", g_detail_idx)
                    #EXIT DIALOG
                ELSE
                    NEXT FIELD CURRENT
                END IF
                #GOTO _after_insert
            ELSE
                IF l_lock_sw == 'Y' THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.extend = ""
                    LET g_errparam.code   = -263
                    LET g_errparam.popup  = TRUE
                    CALL cl_err()

                    LET ga_table_data[l_ac].* = ga_table_data_t.*
                ELSE
                    #add-point:單身修改前

                    #end add-point

                    IF adzi170_update() THEN
                        ERROR "UPDATE O.K"
                    ELSE
                        LET ga_table_data[l_ac].* = ga_table_data_t.*
                        IF adzi170_invalid_tmptbl("delete") THEN
                            NEXT FIELD CURRENT
                        END IF
                    END IF
                    #add-point:單身修改后

                    #end add-point
                END IF
            END IF

        AFTER ROW
            IF g_action_choice == "insert" {AND adzi170_check_form_cols()} THEN
                IF adzi170_insert_current_data_to_tmptbl() #将输入的数据插入临时表
                AND adzi170_insert_to_target_table() #将临时表中的数据插入目标表
                THEN
                    ERROR 'INSERT O.K'
                    LET g_detail_cnt = g_detail_cnt + 1
                    LET g_action_choice = "modify"
                    #LET g_detail_idx = g_detail_idx + 1
                    #CALL DIALOG.setCurrentRow("s_resultset", g_detail_idx)
                    #EXIT DIALOG
                ELSE
                    NEXT FIELD CURRENT
                END IF
                #GOTO _after_insert
            END IF

        AFTER INPUT
            LET g_action_choice = ""

        END INPUT

        BEFORE DIALOG
            #初始化UI
            CALL adzi170_set_resultset_ui("initial")
            IF g_tmp_idx > 0 THEN
                LET l_ac = g_tmp_idx
                CALL DIALOG.setCurrentRow("s_resultset", l_ac)
                NEXT FIELD CURRENT
                #LET g_tmp_idx = 1
            END IF
            #add-point:ui_dialog段before

            #end add-point

        AFTER DIALOG

        ON ACTION btn_accept
            IF g_action_choice == "insert" THEN
                #GOTO _after_insert
                IF adzi170_insert_current_data_to_tmptbl() #将输入的数据插入临时表
                AND adzi170_insert_to_target_table() #将临时表中的数据插入目标表
                THEN
                    ERROR 'INSERT O.K'
                    LET g_detail_cnt = g_detail_cnt + 1
                    LET g_action_choice = "modify"
                    #LET g_detail_idx = g_detail_idx + 1
                    #CALL DIALOG.setCurrentRow("s_resultset", g_detail_idx)
                    EXIT DIALOG
                ELSE
                    NEXT FIELD CURRENT
                END IF
            ELSE
                ACCEPT DIALOG
            END IF

        ON ACTION btn_cancel
            LET INT_FLAG = TRUE
            CALL adzi170_cancel(l_cmd)
            EXIT DIALOG

        ON ACTION cancel
            LET INT_FLAG = TRUE
            CALL adzi170_cancel(l_cmd)
            EXIT DIALOG

        ON ACTION close
            LET INT_FLAG = TRUE
            CALL adzi170_cancel(l_cmd)
            EXIT DIALOG

        ON ACTION exit
            LET INT_FLAG = TRUE
            CALL adzi170_cancel(l_cmd)
            EXIT DIALOG

        #CONTINUE DIALOG
    END DIALOG

    CLOSE adzi170_bcl
    CASE l_cmd
        WHEN 'a'
            CALL adzi170_set_ui("ainsert")

        WHEN 'u'
            CALL adzi170_set_ui("amodify")

        OTHERWISE
            CALL adzi170_set_ui("aquery")
    END CASE
    LET INT_FLAG = FALSE

END FUNCTION

{<section id="adzi170.insert" >}
#+ 資料新增
PRIVATE FUNCTION adzi170_insert()
   #add-point:delete段define

   #end add-point

   #add-point:單身新增前

   #end add-point

   LET g_insert = 'Y'
   CALL adzi170_modify()

   #add-point:單身新增後

   #end add-point

END FUNCTION
{</section>}

{<section id="adzi170.update" >}
#+ 更新当前选中的行
PRIVATE FUNCTION adzi170_update()
    DEFINE ls_upd_sql      STRING
    DEFINE li_i            INTEGER
    DEFINE ls_col_data     STRING
    DEFINE ls_col_handled  STRING

    IF adzi170_insert_current_data_to_tmptbl() THEN
        LET ls_upd_sql = "UPDATE ", ga_tab[1], " SET "
        FOR li_i = 1 TO gi_feld_cnt
            #LET ls_col_data = adzi170_get_col_data_from_tmptbl(li_i) CLIPPED  #151019-00006#1 #mark
            LET ls_col_data = adzi170_get_col_data_from_tmptbl(li_i)           #151019-00006#1 #add
            CASE ga_feld_type[li_i]
                WHEN "varchar2"
                    LET ls_col_handled = "'", ls_col_data, "'"

                WHEN "date"
                    LET ls_col_handled = " TO_DATE('", ls_col_data, "', 'YYYY-MM-DD HH24:MI:SS') "
                    #LET ls_col_handled = " TO_DATE('", ls_col_data, "', 'YYYY-MM-DD') "
                    #LET ls_col_handled = " TO_DATE('", ls_col_data.subString(1, 10), "', 'YYYY-MM-dd') "

                WHEN "number"
                    LET ls_col_handled = " TO_NUMBER('", ls_col_data, "') "

                WHEN "blob"

                WHEN "clob"

                WHEN "timestamp"
                    #LET ls_col_handled = " TO_TIMESTAMP('", ls_col_data.subString(1, 20), "', '", adzi170_get_timestamp_format(ga_feld_length[li_i]), "') "
                    LET ls_col_handled = " TO_TIMESTAMP('", ls_col_data, "', '", adzi170_get_timestamp_format(ga_feld_length[li_i]), "') "

                OTHERWISE

            END CASE

            LET ls_upd_sql = ls_upd_sql, ga_feld_id[li_i], "=", ls_col_handled, " "
            IF li_i != gi_feld_cnt THEN
                LET ls_upd_sql = ls_upd_sql, ", "
            END IF
        END FOR
        LET ls_upd_sql = ls_upd_sql, " WHERE ", gs_forupd_where_con
    END IF

    EXECUTE IMMEDIATE ls_upd_sql
    IF SQLCA.SQLCODE THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.extend = SQLCA.SQLERRD[2]
        LET g_errparam.code   = SQLCA.SQLCODE
        LET g_errparam.popup  = TRUE
        CALL cl_err()

        #CALL adzi170_rollback()
        RETURN FALSE
    END IF

    RETURN TRUE
END FUNCTION
{</section>}

{<section id="adzi170.delete" >}
#+ 資料刪除
PRIVATE FUNCTION adzi170_delete()
    #add-point:delete段define
    DEFINE li_detail_tmp    LIKE type_t.num5
    DEFINE ls_del_sql      STRING
    #end add-point

    #add-point:單身刪除询问
    #詢問是否確定刪除所選資料
    IF NOT cl_ask_del_detail() THEN
        #CALL adzi170_rollback()
        RETURN
    END IF

    CALL adzi170_get_upd_sql(gs_tmptbl)
    IF NOT adzi170_invalid_tmptbl("delete") THEN
        RETURN
    END IF
    PREPARE adzi170_del_s FROM gs_forupd_sql
    DECLARE adzi170_del_bcl CURSOR FOR adzi170_del_s
    #end add-point

    CALL s_transaction_begin()
    LET gb_trans_opened = TRUE

    #LET li_detail_tmp = g_detail_idx  #mark by wangxy  20141020
    #lock所選資料
    #確定是否有被鎖定
    IF NOT adzi170_lock_b_del() THEN
        #已被他人鎖定
        #CALL adzi170_rollback()
        RETURN
    ELSE
        #add-point:單身刪除前
        CALL adzi170_set_ui("bdelete")
        LET ls_del_sql = "DELETE FROM ", ga_tab[1], " WHERE ", gs_forupd_where_con
        #end add-point

        #add-point:單身刪除中
        EXECUTE IMMEDIATE ls_del_sql
        IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = SQLCA.SQLERRD[2]
            LET g_errparam.code   = SQLCA.SQLCODE
            LET g_errparam.popup  = FALSE
            CALL cl_err()

            #CALL adzi170_rollback()
            RETURN
        END IF
        #end add-point

        #add-point:單身刪除後
        #LET g_detail_idx = li_detail_tmp   #mark by wangxy 20141020
        ERROR "DELETE O.K."
        CALL ga_table_data.deleteElement(l_ac)
        IF l_ac = (ga_table_data.getLength() + 1) THEN
            CALL FGL_SET_ARR_CURR(l_ac - 1) 
        END IF
        CALL adzi170_set_ui("adelete")
        #end add-point
    END IF

END FUNCTION
{</section>}

{<section id="adzi170.cancel" >}
#+ 取消单身操作
PRIVATE FUNCTION adzi170_cancel(ps_cmd)
    DEFINE ps_cmd        STRING #单身操作：'a','u','d'

    CASE ps_cmd
        WHEN 'a'
            IF INT_FLAG THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = ""
                LET g_errparam.code   = 9001
                LET g_errparam.popup  = FALSE
                CALL cl_err()

                LET INT_FLAG = FALSE
                INITIALIZE ga_table_data_t.* TO NULL
                INITIALIZE ga_table_data[l_ac].* TO NULL
                CALL ga_table_data.deleteElement(l_ac)

            END IF

        WHEN 'u'
            IF INT_FLAG THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = ''
                LET g_errparam.code   = 9001
                LET g_errparam.popup  = FALSE
                CALL cl_err()

                LET INT_FLAG = FALSE
                LET ga_table_data[l_ac].* = ga_table_data_t.*
                CLOSE adzi170_bcl

            END IF

        WHEN 'd'

        OTHERWISE

    END CASE


END FUNCTION
{</section>}

{<section id="adzi170.refresh" >}
#+ 重新载入当前页面数据
PRIVATE FUNCTION adzi170_refresh()
    CALL adzi170_page_query(gi_curr_page)
END FUNCTION
{</section>}

{<section id="adzi170.page_query" >}
#+ 进行分页查询
PRIVATE FUNCTION adzi170_page_query(pi_page_no)
   DEFINE pi_page_no      INTEGER
   DEFINE l_sql           STRING

   #获取总笔数
   IF NOT adzi170_get_total_record_cnt() THEN
       RETURN
   END IF
   #设置总页数
   CALL adzi170_set_total_page()

   LET gi_curr_page = pi_page_no
   #根据计算得到的页码组成带分页功能的SQL
   CALL adzi170_build_paged_sql(pi_page_no) RETURNING l_sql

   #判断主键数量

   CALL adzi170_set_ui("bquery")
   #单身填充
   CALL adzi170_b_fill(l_sql)
   CALL adzi170_set_ui("aquery")

END FUNCTION
{</section>}

{<section id="adzi170.b_fill" >}
#+ 单身填充到数组
PRIVATE FUNCTION adzi170_b_fill(ps_sql)
    DEFINE ps_sql        STRING
    DEFINE l_sql         STRING
    DEFINE l_i           INTEGER

    LET l_sql = ps_sql
    #准备做查询并填充数据
    PREPARE table_pre FROM l_sql
    DECLARE table_cur CURSOR FOR table_pre
    IF SQLCA.SQLCODE THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.extend = SQLCA.SQLERRD[2]
        LET g_errparam.code   = SQLCA.SQLCODE
        LET g_errparam.popup  = TRUE
        CALL cl_err()
    END IF

    LET l_i = 1
    CALL ga_table_data.clear()
    #填充数据到ga_table_data全局变量数组
    FOREACH table_cur INTO ga_table_data[l_i].*
        #IF SQLCA.SQLCODE THEN
            #INITIALIZE g_errparam TO NULL
            #LET g_errparam.extend = SQLCA.SQLERRD[2]
            #LET g_errparam.code   = SQLCA.SQLCODE
            #LET g_errparam.popup  = TRUE
            #CALL cl_err()
        #END IF
        LET l_i=l_i+1
        IF l_i > g_max_rec THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 9035
            LET g_errparam.code   = 0
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            EXIT FOREACH
        END IF
    END FOREACH
    IF SQLCA.SQLCODE THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.extend = SQLCA.SQLERRD[2]
        LET g_errparam.code   = SQLCA.SQLCODE
        LET g_errparam.popup  = TRUE
        CALL cl_err()
    END IF

    FREE table_cur
    CALL ga_table_data.deleteElement(l_i)
    LET g_dbqry_rec_b = l_i - 1

END FUNCTION
{</section>}

{<section id="adzi170.lock_b" >}
#+ lock table資料
PRIVATE FUNCTION adzi170_lock_b()
    OPEN adzi170_bcl
    IF SQLCA.SQLCODE THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.extend = SQLCA.SQLERRD[2],"\nadzi170_bcl"
        LET g_errparam.code   = SQLCA.SQLCODE
        LET g_errparam.popup  = TRUE
        CALL cl_err()
        RETURN FALSE
    END IF

   RETURN TRUE
END FUNCTION
{</section>}

{<section id="adzi170.lock_b_del" >}
#+ lock table資料（FOR btn_delete Action）
PRIVATE FUNCTION adzi170_lock_b_del()

    OPEN adzi170_del_bcl
    IF SQLCA.SQLCODE THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.extend = SQLCA.SQLERRD[2],"\nadzi170_del_bcl"
        LET g_errparam.code   = SQLCA.SQLCODE
        LET g_errparam.popup  = TRUE
        CALL cl_err()
        RETURN FALSE
    END IF

   RETURN TRUE
END FUNCTION
{</section>}

{<section id="adzi170.commit" >}
#+ 提交当前事务
PRIVATE FUNCTION adzi170_commit()
    IF gb_trans_opened THEN
        CALL s_transaction_end('Y','0')
        LET gb_trans_opened = FALSE
        ERROR "Transaction committed!"
        CALL adzi170_set_ui("ainsert")
    END IF

END FUNCTION
{</section>}

{<section id="adzi170.rollback" >}
#+ 回退事务
PRIVATE FUNCTION adzi170_rollback()
   IF gb_trans_opened THEN
      CALL s_transaction_end('N','0')
      LET gb_trans_opened = FALSE
      ERROR "Transaction rolled back!"
      CALL adzi170_set_ui("ainsert")
      CALL adzi170_refresh()
   END IF
END FUNCTION
{</section>}
########################################adzi170-end########################################


########################################Util-start########################################
{<section id="adzi170.set_ui" >}
#+ 根据传入的不同状态设定画面上按钮的显隐和RadioButton的选项
PRIVATE FUNCTION adzi170_set_ui(ps_act_flag)
    DEFINE ps_act_flag          STRING #操作类型

    CALL adzi170_set_edit_ui(ps_act_flag)
    CALL adzi170_set_resultset_ui(ps_act_flag)

END FUNCTION
{</section>}

{<section id="adzi170.set_edit_ui" >}
#+ 根据传入的不同状态设定编辑区的UI
PRIVATE FUNCTION adzi170_set_edit_ui(ps_act_flag)
    DEFINE ps_act_flag               STRING
    CASE ps_act_flag
        WHEN "initial"
            CALL cl_set_act_visible("connect,open,execute,exit", TRUE)
            CALL cl_set_act_visible("save,stop,commit,rollback", FALSE)

        WHEN "bquery" #查询之前
            CALL cl_set_act_visible("connect,open,save,execute,stop,commit,rollback", FALSE)

        WHEN "aquery" #查询之后
            CALL adzi170_set_edit_ui("ainsert")
            CALL cl_set_act_visible("connect,open,save,execute,exit", TRUE)
            CALL cl_set_act_visible("stop", FALSE)

        WHEN "binsert" #新增之前

        WHEN "ainsert" #新增之后
            IF gb_trans_opened THEN
                CALL cl_set_act_visible("commit,rollback", TRUE)
            ELSE
                CALL cl_set_act_visible("commit,rollback", FALSE)
            END IF

        WHEN "bmodify" #修改之前

        WHEN "amodify" #修改之后
            CALL adzi170_set_edit_ui("aquery")

        WHEN "bdelete" #删除之前

        WHEN "adelete" #删除之后
            CALL adzi170_set_edit_ui("aquery")

        OTHERWISE

    END CASE

END FUNCTION
{</section>}

{<section id="adzi170.set_resultset_ui" >}
#+ 根据传入的不同状态设定结果集区的UI，并显示页码和总页数
PRIVATE FUNCTION adzi170_set_resultset_ui(ps_act_flag)
    DEFINE ps_act_flag               STRING
    CASE ps_act_flag
        WHEN "initial"
            CALL cl_set_act_visible("btn_first,btn_previous,btn_next,btn_last", FALSE)
            IF cl_null(gs_analyzed_sql) THEN
                CALL cl_set_act_visible("btn_insert", FALSE)
                CALL cl_set_act_visible("btn_refresh", FALSE)
            ELSE
                CALL cl_set_act_visible("btn_insert", TRUE)
                CALL cl_set_act_visible("btn_refresh", TRUE)
            END IF
            IF ga_table_data.getLength() <= 0 THEN
                CALL cl_set_act_visible("btn_modify,btn_delete", FALSE)
                CALL cl_set_act_visible("btn_export", FALSE)
            ELSE
                CALL cl_set_act_visible("btn_modify,btn_delete", TRUE)
                CALL cl_set_act_visible("btn_export", TRUE)
            END IF
            CALL cl_set_act_visible("btn_accept,btn_cancel", FALSE)

        WHEN "bquery" #查询之前
            #设定Table的UI
            CALL adzi170_set_table_ui_after_analyze()

        WHEN "aquery" #查询之后
            #结果区的按钮设置
            #(1)翻页按钮控制
            IF gi_total_page_cnt <= 1 THEN
                CALL cl_set_act_visible("btn_first,btn_previous,btn_next,btn_last", FALSE)
            ELSE
                IF gi_curr_page == 1 THEN
                    CALL cl_set_act_visible("btn_first,btn_previous", FALSE)
                    CALL cl_set_act_visible("btn_next,btn_last", TRUE)
                END IF
                IF gi_curr_page > 1 AND gi_curr_page < gi_total_page_cnt THEN
                    CALL cl_set_act_visible("btn_first,btn_previous,btn_next,btn_last", TRUE)
                END IF
                IF gi_curr_page == gi_total_page_cnt THEN
                    CALL cl_set_act_visible("btn_first,btn_previous", TRUE)
                    CALL cl_set_act_visible("btn_next,btn_last", FALSE)
                END IF
            END IF
            #(2)增删改按钮控制
            IF NOT cl_null(gs_analyzed_sql) THEN
               IF ga_table_data.getLength() <= 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = -100
                  LET g_errparam.popup  = FALSE
                  CALL cl_err()
                  CALL cl_set_act_visible("btn_insert", TRUE)
                  CALL cl_set_act_visible("btn_modify,btn_delete", FALSE)
                  Call cl_set_act_visible("btn_refresh", TRUE)
                  CALL cl_set_act_visible("btn_export", FALSE)
               ELSE
                  #判断用户输入的SELECT语句。能进行增、删、改操作的条件如下：
                  #1.只能有一张表
                  #2.SELECT中的任意字段没有使用函数（TO_CHAR、TO_NUMBER等等）
                  #3.全部的PK被SELECT
                  #PS:第1,2个条件在可通过g_tab有没有赋值即可判断,所以在adzi170_check_selected_field中最主要判断第3个条件
                  IF NOT adzi170_check_selected_field() THEN
                      CALL cl_set_act_visible("btn_insert,btn_modify,btn_delete", FALSE)
                  ELSE
                      CALL cl_set_act_visible("btn_insert,btn_modify,btn_delete", TRUE)
                  END IF
                  CALL cl_set_act_visible("btn_accept,btn_cancel", FALSE)
                  Call cl_set_act_visible("btn_refresh", TRUE)
                  CALL cl_set_act_visible("btn_export", TRUE)
               END IF
            END IF
            ###页码设置
            #当前页码
            DISPLAY gi_curr_page TO FORMONLY.h_pageidx
            #总共页数
            DISPLAY gi_total_page_cnt TO FORMONLY.h_pagecnt

        WHEN "binsert" #新增之前
            CALL cl_set_act_visible("btn_first,btn_previous,btn_next,btn_last", FALSE)
            CALL cl_set_act_visible("btn_insert,btn_modify,btn_delete", FALSE)
            CALL cl_set_act_visible("btn_accept,btn_cancel", TRUE)
            CALL cl_set_act_visible("btn_refresh,btn_export", FALSE)

        WHEN "ainsert" #新增之后
            CALL adzi170_set_resultset_ui("aquery")

        WHEN "bmodify" #修改之前
            CALL adzi170_set_resultset_ui("binsert")

        WHEN "amodify" #修改之后
            CALL adzi170_set_resultset_ui("aquery")

        WHEN "bdelete" #删除之前

        WHEN "adelete" #删除之后
            CALL adzi170_set_resultset_ui("aquery")

        OTHERWISE

    END CASE

END FUNCTION
{</section>}

{<section id="adzi170.get_total_record_cnt" >}
#+ 获取数据库中符合条件的记录笔数（不是分页后的笔数），保存到gi_total_record_cnt
PRIVATE FUNCTION adzi170_get_total_record_cnt()
   DEFINE ls_sql              STRING

   LET ls_sql = "SELECT COUNT(*) FROM (", gs_analyzed_sql , ")"

   PREPARE cnt_cur FROM ls_sql
   EXECUTE cnt_cur INTO gi_total_record_cnt
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = SQLCA.SQLERRD[2]
      LET g_errparam.code   = SQLCA.SQLCODE
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF
   FREE cnt_cur

   RETURN TRUE
END FUNCTION
{</section>}

{<section id="adzi170.set_total_page" >}
#+ 设置总页数
PRIVATE FUNCTION adzi170_set_total_page()
    DEFINE li_mod_res    INTEGER #余数

    IF gi_total_record_cnt == 0 THEN
        LET gi_total_page_cnt = 1
        RETURN
    END IF

    LET li_mod_res = gi_total_record_cnt MOD GI_MAX_ROW_COUNT
    IF li_mod_res == 0 THEN
        LET gi_total_page_cnt = gi_total_record_cnt / GI_MAX_ROW_COUNT
    ELSE
        LET gi_total_page_cnt = gi_total_record_cnt / GI_MAX_ROW_COUNT + 1
    END IF

END FUNCTION
{</section>}

{<section id="adzi170.build_paged_sql" >}
#+ 生成并返回过滤ROWNUM功能的SQL语句
PRIVATE FUNCTION adzi170_build_paged_sql(pi_page_no)
   DEFINE pi_page_no         INTEGER
   DEFINE ls_sql             STRING

   IF pi_page_no < 1 THEN
      CALL cl_err()
   END IF

   IF pi_page_no < gi_total_page_cnt THEN
      LET gi_start_row = (pi_page_no - 1) * GI_MAX_ROW_COUNT + 1
      LET gi_end_row = pi_page_no * GI_MAX_ROW_COUNT
   END IF

   IF pi_page_no == gi_total_page_cnt THEN
      LET gi_start_row = (gi_total_page_cnt - 1) * GI_MAX_ROW_COUNT + 1
      LET gi_end_row = gi_total_record_cnt
   END IF

   IF pi_page_no > gi_total_page_cnt THEN
      CALL cl_err()
   END IF

   LET ls_sql = gs_analyzed_sql
   LET ls_sql = "SELECT * ",
                "  FROM (SELECT A.*, ROWNUM RN ",
                "           FROM (", ls_sql, ") A ",
                "          WHERE ROWNUM <= ", gi_end_row , ") ",
                "  WHERE RN >= ", gi_start_row

   RETURN ls_sql
END FUNCTION
{</section>}

{<section id="adzi170.get_number_format" >}
#+ 获取NUMBER类型的格式化字符串
PRIVATE FUNCTION adzi170_get_number_format(p_length)
   DEFINE p_length             LIKE type_t.chr10
   DEFINE ls_tmp               STRING
   DEFINE li_precision         SMALLINT #数字字符个数
   DEFINE li_scale             SMALLINT #小数点后的位数
   DEFINE li_i                 SMALLINT #循环变量
   DEFINE li_dotpos            SMALLINT #传入参数中是否有逗号（如：5,2）
   DEFINE ls_result            STRING   #最终结果

   #保存变量
   LET ls_tmp = p_length
   LET li_dotpos = ls_tmp.getIndexOf(",", 1)
   IF li_dotpos THEN
      LET li_precision = ls_tmp.subString(1, li_dotpos - 1)
      LET li_scale = ls_tmp.subString(li_dotpos + 1, ls_tmp.getLength())
   ELSE
      LET li_precision = ls_tmp
      LET li_scale = 0
   END IF

   LET ls_result = "FM"
   #组小数点之前的格式
   FOR li_i = 1 TO li_precision - li_scale
      LET ls_result = ls_result, "9"
   END FOR
   IF li_scale > 0 THEN
      LET ls_result = ls_result, "."
      #组小数点之后的格式
      FOR li_i = 1 TO li_scale
      LET ls_result = ls_result, "9"
      END FOR
   ELSE
      RETURN ls_result
   END IF

   RETURN ls_result
END FUNCTION
{</section>}

{<section id="adzi170.get_timestamp_format" >}
#+ 获取TIMESTAMP类型的格式化字符串
PRIVATE FUNCTION adzi170_get_timestamp_format(p_length)
   DEFINE p_length            LIKE type_t.chr10
   DEFINE ls_result           STRING

    IF p_length == '0' THEN
        LET ls_result = "YYYY-MM-DD HH24:MI:SS."
    ELSE
        LET ls_result = "YYYY-MM-DD HH24:MI:SS.ff", p_length USING "&"
    END IF

   RETURN ls_result
END FUNCTION
{</section>}


{<section id="adzi170.get_col_width_for_tbl" >}
#+ 从表中存储的栏位长度值获得画面上列的宽度
PRIVATE FUNCTION adzi170_get_col_width_for_tbl(ps_feld_length)
    DEFINE ps_feld_length        LIKE type_t.chr10
    DEFINE ls_feld_length        STRING
    DEFINE li_dot_idx            INTEGER

    LET ls_feld_length = ps_feld_length
    LET li_dot_idx = ls_feld_length.getIndexOf(",", 1)
    IF li_dot_idx THEN
        RETURN ls_feld_length.subString(1, li_dot_idx)
    ELSE
        RETURN ls_feld_length
    END IF

END FUNCTION
{</section>}


{<section id="adzi170_feld_type" >}
#+ 判断传入的栏位是否是ps_type
#+ ps_type有：pk(主键)
PRIVATE FUNCTION adzi170_feld_type(ps_feld_id,ps_type)
    DEFINE ps_feld_id         STRING
    DEFINE ps_type            STRING
    DEFINE ls_type            STRING
    DEFINE li_i               INTEGER

    LET ls_type = ps_type.toLowerCase()
    CASE ls_type
        WHEN "pk"
           FOR li_i = 1 TO ga_pk_feld_id.getLength()
              IF ps_feld_id == ga_pk_feld_id[li_i] THEN
                 RETURN TRUE
              END IF
           END FOR

        OTHERWISE
           RETURN FALSE

    END CASE

    RETURN FALSE
END FUNCTION
{</section>}

{<section id="adzi170.judge_sql_syntax" >}
#+ 向数据库下SQL来测试语法
PRIVATE FUNCTION adzi170_judge_sql_syntax()

    EXECUTE IMMEDIATE "SELECT COUNT(*) FROM ( " || g_execmd || " )"
    IF SQLCA.SQLCODE THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.extend = SQLCA.SQLERRD[2]
        #LET g_errparam.code   = SQLCA.SQLCODE #161114-00026#1 mark
        LET g_errparam.code   ='-809' #161114-00026# add
        LET g_errparam.popup  = TRUE
        CALL cl_err()
        RETURN FALSE
    END IF

    RETURN TRUE
END FUNCTION
{</section>}

########################################Util-end########################################


########################################临时表操作-start########################################
{<section id="adzi170.create_tmptbl" >}
#+ 创建临时表用于插入新数据（单表only，当输入的SQL中有两个及以上的表时，应对的插入按钮应当变为disabled状态）。
#+      如果创建成功，返回true；
#+      否则返回false
PRIVATE FUNCTION adzi170_create_tmptbl()
    DEFINE l_sql     STRING #创建临时表的SQL语句
    DEFINE li_i           INTEGER
    DEFINE ls_i           STRING
    DEFINE ls_tmptbl      STRING #临时表的名字
    DEFINE ls_serial      STRING
    DEFINE ls_id          STRING
    DEFINE ls_feld_no     STRING #临时表中字段的编号，如"field001"中的"001"

    #创建唯一标识符，防止作业被同时打开时出错
    LET ls_serial = adzi170_get_tmptbl_id()
    LET ls_tmptbl = "adzi170_", ls_serial,"_tmp2"

    #保存在全局变量中，以保证程序运行期间可以使用它
    LET gs_tmptbl = ls_tmptbl

    LET l_sql = " DROP TABLE ",ls_tmptbl
    EXECUTE IMMEDIATE l_sql

    LET l_sql = " CREATE TABLE ",ls_tmptbl,
                " ( "
    FOR li_i = 1 TO GI_MAX_COLUMN_COUNT
        LET l_sql = l_sql, "field", li_i USING "&&&", " varchar2(1000)"
        IF li_i != GI_MAX_COLUMN_COUNT THEN
           LET l_sql = l_sql, ", "
        ELSE
           LET l_sql = l_sql
        END IF
     END FOR
     LET l_sql = l_sql, ")",
                 " TABLESPACE TEMPTABS "

     IF NOT adzi170_tmptbl_exists() THEN
        #在数据库中创建临时表
        EXECUTE IMMEDIATE l_sql
        IF SQLCA.SQLCODE THEN
           LET gs_tmptbl = NULL
           INITIALIZE g_errparam TO NULL
           LET g_errparam.extend = 'Temp table has already been existed in db!'
           LET g_errparam.code   = SQLCA.SQLCODE
           LET g_errparam.popup  = TRUE 
           CALL cl_err()
           RETURN FALSE
        END IF
     END IF
     RETURN TRUE
END FUNCTION
{</section>}

{<section id="adzi170.invalid_tmptbl" >}
#+ 无效化创建的临时表。
#+ 当传入参数为"drop"时，删除表；传入参数为"truncate"或"delete"时，删除表内数据。
#+ 如果存在这个表，则执行，并返回true；
#+ 否则返回false。
PRIVATE FUNCTION adzi170_invalid_tmptbl(ps_invalid_cmd)
	DEFINE ps_invalid_cmd            STRING
	DEFINE ls_invalid_cmd			 STRING
	DEFINE ls_sql                    STRING

	IF adzi170_tmptbl_exists() THEN
        LET ls_invalid_cmd = ps_invalid_cmd.toLowerCase()
        CASE ls_invalid_cmd
            WHEN "drop"
                LET ls_sql = "DROP TABLE ", gs_tmptbl
            WHEN "truncate"
                LET ls_sql = "TRUNCATE TABLE ", gs_tmptbl
            WHEN "delete"
                LET ls_sql = "DELETE FROM ", gs_tmptbl
            #传入参数不对，提示错误，并返回false
            OTHERWISE
                #INITIALIZE g_errparam TO NULL
                #LET g_errparam.extend = "Error occurred in invaliding temp table ", gs_tmptbl, "..."
                #LET g_errparam.code   = -263
                #LET g_errparam.popup  = TRUE
                #CALL cl_err()
                RETURN FALSE
        END CASE

        EXECUTE IMMEDIATE ls_sql
        IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "Error occurred in ", ls_invalid_cmd, " temp table ", gs_tmptbl, "..."
            LET g_errparam.code   = SQLCA.SQLCODE
            LET g_errparam.popup  = FALSE
            CALL cl_err()
            RETURN FALSE
        END IF
    ELSE
        RETURN FALSE
	END IF

	RETURN TRUE
END FUNCTION
{</section>}

{<section id="adzi170.insert_current_data_to_tmptbl" >}
#+ 将当前光标所指行的数据插入创建的临时表
PRIVATE FUNCTION adzi170_insert_current_data_to_tmptbl()
    DEFINE ls_sql           STRING
    DEFINE ls_tmptbl        STRING

    IF adzi170_tmptbl_exists() THEN
        IF adzi170_get_tmptbl_data_cnt() > 0 THEN
            IF NOT adzi170_invalid_tmptbl("delete") THEN
                RETURN FALSE
            END IF
        END IF

        LET ls_tmptbl = gs_tmptbl
        #151019-00006#1 add(s)
        LET ls_sql =
        "INSERT INTO ", ls_tmptbl,
        " VALUES (",
        "'",adzi170_null(ga_table_data[l_ac].field001),"',",
        "'",adzi170_null(ga_table_data[l_ac].field002),"',",
        "'",adzi170_null(ga_table_data[l_ac].field003),"',",
        "'",adzi170_null(ga_table_data[l_ac].field004),"',",
        "'",adzi170_null(ga_table_data[l_ac].field005),"',",
        "'",adzi170_null(ga_table_data[l_ac].field006),"',",
        "'",adzi170_null(ga_table_data[l_ac].field007),"',",
        "'",adzi170_null(ga_table_data[l_ac].field008),"',",
        "'",adzi170_null(ga_table_data[l_ac].field009),"',",
        "'",adzi170_null(ga_table_data[l_ac].field010),"',",
        "'",adzi170_null(ga_table_data[l_ac].field011),"',",
        "'",adzi170_null(ga_table_data[l_ac].field012),"',",
        "'",adzi170_null(ga_table_data[l_ac].field013),"',",
        "'",adzi170_null(ga_table_data[l_ac].field014),"',",
        "'",adzi170_null(ga_table_data[l_ac].field015),"',",
        "'",adzi170_null(ga_table_data[l_ac].field016),"',",
        "'",adzi170_null(ga_table_data[l_ac].field017),"',",
        "'",adzi170_null(ga_table_data[l_ac].field018),"',",
        "'",adzi170_null(ga_table_data[l_ac].field019),"',",
        "'",adzi170_null(ga_table_data[l_ac].field020),"',",
        "'",adzi170_null(ga_table_data[l_ac].field021),"',",
        "'",adzi170_null(ga_table_data[l_ac].field022),"',",
        "'",adzi170_null(ga_table_data[l_ac].field023),"',",
        "'",adzi170_null(ga_table_data[l_ac].field024),"',",
        "'",adzi170_null(ga_table_data[l_ac].field025),"',",
        "'",adzi170_null(ga_table_data[l_ac].field026),"',",
        "'",adzi170_null(ga_table_data[l_ac].field027),"',",
        "'",adzi170_null(ga_table_data[l_ac].field028),"',",
        "'",adzi170_null(ga_table_data[l_ac].field029),"',",
        "'",adzi170_null(ga_table_data[l_ac].field030),"',",
        "'",adzi170_null(ga_table_data[l_ac].field031),"',",
        "'",adzi170_null(ga_table_data[l_ac].field032),"',",
        "'",adzi170_null(ga_table_data[l_ac].field033),"',",
        "'",adzi170_null(ga_table_data[l_ac].field034),"',",
        "'",adzi170_null(ga_table_data[l_ac].field035),"',",
        "'",adzi170_null(ga_table_data[l_ac].field036),"',",
        "'",adzi170_null(ga_table_data[l_ac].field037),"',",
        "'",adzi170_null(ga_table_data[l_ac].field038),"',",
        "'",adzi170_null(ga_table_data[l_ac].field039),"',",
        "'",adzi170_null(ga_table_data[l_ac].field040),"',",
        "'",adzi170_null(ga_table_data[l_ac].field041),"',",
        "'",adzi170_null(ga_table_data[l_ac].field042),"',",
        "'",adzi170_null(ga_table_data[l_ac].field043),"',",
        "'",adzi170_null(ga_table_data[l_ac].field044),"',",
        "'",adzi170_null(ga_table_data[l_ac].field045),"',",
        "'",adzi170_null(ga_table_data[l_ac].field046),"',",
        "'",adzi170_null(ga_table_data[l_ac].field047),"',",
        "'",adzi170_null(ga_table_data[l_ac].field048),"',",
        "'",adzi170_null(ga_table_data[l_ac].field049),"',",
        "'",adzi170_null(ga_table_data[l_ac].field050),"',",
        "'",adzi170_null(ga_table_data[l_ac].field051),"',",
        "'",adzi170_null(ga_table_data[l_ac].field052),"',",
        "'",adzi170_null(ga_table_data[l_ac].field053),"',",
        "'",adzi170_null(ga_table_data[l_ac].field054),"',",
        "'",adzi170_null(ga_table_data[l_ac].field055),"',",
        "'",adzi170_null(ga_table_data[l_ac].field056),"',",
        "'",adzi170_null(ga_table_data[l_ac].field057),"',",
        "'",adzi170_null(ga_table_data[l_ac].field058),"',",
        "'",adzi170_null(ga_table_data[l_ac].field059),"',",
        "'",adzi170_null(ga_table_data[l_ac].field060),"',",
        "'",adzi170_null(ga_table_data[l_ac].field061),"',",
        "'",adzi170_null(ga_table_data[l_ac].field062),"',",
        "'",adzi170_null(ga_table_data[l_ac].field063),"',",
        "'",adzi170_null(ga_table_data[l_ac].field064),"',",
        "'",adzi170_null(ga_table_data[l_ac].field065),"',",
        "'",adzi170_null(ga_table_data[l_ac].field066),"',",
        "'",adzi170_null(ga_table_data[l_ac].field067),"',",
        "'",adzi170_null(ga_table_data[l_ac].field068),"',",
        "'",adzi170_null(ga_table_data[l_ac].field069),"',",
        "'",adzi170_null(ga_table_data[l_ac].field070),"',",
        "'",adzi170_null(ga_table_data[l_ac].field071),"',",
        "'",adzi170_null(ga_table_data[l_ac].field072),"',",
        "'",adzi170_null(ga_table_data[l_ac].field073),"',",
        "'",adzi170_null(ga_table_data[l_ac].field074),"',",
        "'",adzi170_null(ga_table_data[l_ac].field075),"',",
        "'",adzi170_null(ga_table_data[l_ac].field076),"',",
        "'",adzi170_null(ga_table_data[l_ac].field077),"',",
        "'",adzi170_null(ga_table_data[l_ac].field078),"',",
        "'",adzi170_null(ga_table_data[l_ac].field079),"',",
        "'",adzi170_null(ga_table_data[l_ac].field080),"',",
        "'",adzi170_null(ga_table_data[l_ac].field081),"',",
        "'",adzi170_null(ga_table_data[l_ac].field082),"',",
        "'",adzi170_null(ga_table_data[l_ac].field083),"',",
        "'",adzi170_null(ga_table_data[l_ac].field084),"',",
        "'",adzi170_null(ga_table_data[l_ac].field085),"',",
        "'",adzi170_null(ga_table_data[l_ac].field086),"',",
        "'",adzi170_null(ga_table_data[l_ac].field087),"',",
        "'",adzi170_null(ga_table_data[l_ac].field088),"',",
        "'",adzi170_null(ga_table_data[l_ac].field089),"',",
        "'",adzi170_null(ga_table_data[l_ac].field090),"',",
        "'",adzi170_null(ga_table_data[l_ac].field091),"',",
        "'",adzi170_null(ga_table_data[l_ac].field092),"',",
        "'",adzi170_null(ga_table_data[l_ac].field093),"',",
        "'",adzi170_null(ga_table_data[l_ac].field094),"',",
        "'",adzi170_null(ga_table_data[l_ac].field095),"',",
        "'",adzi170_null(ga_table_data[l_ac].field096),"',",
        "'",adzi170_null(ga_table_data[l_ac].field097),"',",
        "'",adzi170_null(ga_table_data[l_ac].field098),"',",
        "'",adzi170_null(ga_table_data[l_ac].field099),"',",
        "'",adzi170_null(ga_table_data[l_ac].field100),"',",
        "'",adzi170_null(ga_table_data[l_ac].field101),"',",
        "'",adzi170_null(ga_table_data[l_ac].field102),"',",
        "'",adzi170_null(ga_table_data[l_ac].field103),"',",
        "'",adzi170_null(ga_table_data[l_ac].field104),"',",
        "'",adzi170_null(ga_table_data[l_ac].field105),"',",
        "'",adzi170_null(ga_table_data[l_ac].field106),"',",
        "'",adzi170_null(ga_table_data[l_ac].field107),"',",
        "'",adzi170_null(ga_table_data[l_ac].field108),"',",
        "'",adzi170_null(ga_table_data[l_ac].field109),"',",
        "'",adzi170_null(ga_table_data[l_ac].field110),"',",
        "'",adzi170_null(ga_table_data[l_ac].field111),"',",
        "'",adzi170_null(ga_table_data[l_ac].field112),"',",
        "'",adzi170_null(ga_table_data[l_ac].field113),"',",
        "'",adzi170_null(ga_table_data[l_ac].field114),"',",
        "'",adzi170_null(ga_table_data[l_ac].field115),"',",
        "'",adzi170_null(ga_table_data[l_ac].field116),"',",
        "'",adzi170_null(ga_table_data[l_ac].field117),"',",
        "'",adzi170_null(ga_table_data[l_ac].field118),"',",
        "'",adzi170_null(ga_table_data[l_ac].field119),"',",
        "'",adzi170_null(ga_table_data[l_ac].field120),"',",
        "'",adzi170_null(ga_table_data[l_ac].field121),"',",
        "'",adzi170_null(ga_table_data[l_ac].field122),"',",
        "'",adzi170_null(ga_table_data[l_ac].field123),"',",
        "'",adzi170_null(ga_table_data[l_ac].field124),"',",
        "'",adzi170_null(ga_table_data[l_ac].field125),"',",
        "'",adzi170_null(ga_table_data[l_ac].field126),"',",
        "'",adzi170_null(ga_table_data[l_ac].field127),"',",
        "'",adzi170_null(ga_table_data[l_ac].field128),"',",
        "'",adzi170_null(ga_table_data[l_ac].field129),"',",
        "'",adzi170_null(ga_table_data[l_ac].field130),"',",
        "'",adzi170_null(ga_table_data[l_ac].field131),"',",
        "'",adzi170_null(ga_table_data[l_ac].field132),"',",
        "'",adzi170_null(ga_table_data[l_ac].field133),"',",
        "'",adzi170_null(ga_table_data[l_ac].field134),"',",
        "'",adzi170_null(ga_table_data[l_ac].field135),"',",
        "'",adzi170_null(ga_table_data[l_ac].field136),"',",
        "'",adzi170_null(ga_table_data[l_ac].field137),"',",
        "'",adzi170_null(ga_table_data[l_ac].field138),"',",
        "'",adzi170_null(ga_table_data[l_ac].field139),"',",
        "'",adzi170_null(ga_table_data[l_ac].field140),"',",
        "'",adzi170_null(ga_table_data[l_ac].field141),"',",
        "'",adzi170_null(ga_table_data[l_ac].field142),"',",
        "'",adzi170_null(ga_table_data[l_ac].field143),"',",
        "'",adzi170_null(ga_table_data[l_ac].field144),"',",
        "'",adzi170_null(ga_table_data[l_ac].field145),"',",
        "'",adzi170_null(ga_table_data[l_ac].field146),"',",
        "'",adzi170_null(ga_table_data[l_ac].field147),"',",
        "'",adzi170_null(ga_table_data[l_ac].field148),"',",
        "'",adzi170_null(ga_table_data[l_ac].field149),"',",
        "'",adzi170_null(ga_table_data[l_ac].field150),"',",
        "'",adzi170_null(ga_table_data[l_ac].field151),"',",
        "'",adzi170_null(ga_table_data[l_ac].field152),"',",
        "'",adzi170_null(ga_table_data[l_ac].field153),"',",
        "'",adzi170_null(ga_table_data[l_ac].field154),"',",
        "'",adzi170_null(ga_table_data[l_ac].field155),"',",
        "'",adzi170_null(ga_table_data[l_ac].field156),"',",
        "'",adzi170_null(ga_table_data[l_ac].field157),"',",
        "'",adzi170_null(ga_table_data[l_ac].field158),"',",
        "'",adzi170_null(ga_table_data[l_ac].field159),"',",
        "'",adzi170_null(ga_table_data[l_ac].field160),"',",
        "'",adzi170_null(ga_table_data[l_ac].field161),"',",
        "'",adzi170_null(ga_table_data[l_ac].field162),"',",
        "'",adzi170_null(ga_table_data[l_ac].field163),"',",
        "'",adzi170_null(ga_table_data[l_ac].field164),"',",
        "'",adzi170_null(ga_table_data[l_ac].field165),"',",
        "'",adzi170_null(ga_table_data[l_ac].field166),"',",
        "'",adzi170_null(ga_table_data[l_ac].field167),"',",
        "'",adzi170_null(ga_table_data[l_ac].field168),"',",
        "'",adzi170_null(ga_table_data[l_ac].field169),"',",
        "'",adzi170_null(ga_table_data[l_ac].field170),"',",
        "'",adzi170_null(ga_table_data[l_ac].field171),"',",
        "'",adzi170_null(ga_table_data[l_ac].field172),"',",
        "'",adzi170_null(ga_table_data[l_ac].field173),"',",
        "'",adzi170_null(ga_table_data[l_ac].field174),"',",
        "'",adzi170_null(ga_table_data[l_ac].field175),"',",
        "'",adzi170_null(ga_table_data[l_ac].field176),"',",
        "'",adzi170_null(ga_table_data[l_ac].field177),"',",
        "'",adzi170_null(ga_table_data[l_ac].field178),"',",
        "'",adzi170_null(ga_table_data[l_ac].field179),"',",
        "'",adzi170_null(ga_table_data[l_ac].field180),"',",
        "'",adzi170_null(ga_table_data[l_ac].field181),"',",
        "'",adzi170_null(ga_table_data[l_ac].field182),"',",
        "'",adzi170_null(ga_table_data[l_ac].field183),"',",
        "'",adzi170_null(ga_table_data[l_ac].field184),"',",
        "'",adzi170_null(ga_table_data[l_ac].field185),"',",
        "'",adzi170_null(ga_table_data[l_ac].field186),"',",
        "'",adzi170_null(ga_table_data[l_ac].field187),"',",
        "'",adzi170_null(ga_table_data[l_ac].field188),"',",
        "'",adzi170_null(ga_table_data[l_ac].field189),"',",
        "'",adzi170_null(ga_table_data[l_ac].field190),"',",
        "'",adzi170_null(ga_table_data[l_ac].field191),"',",
        "'",adzi170_null(ga_table_data[l_ac].field192),"',",
        "'",adzi170_null(ga_table_data[l_ac].field193),"',",
        "'",adzi170_null(ga_table_data[l_ac].field194),"',",
        "'",adzi170_null(ga_table_data[l_ac].field195),"',",
        "'",adzi170_null(ga_table_data[l_ac].field196),"',",
        "'",adzi170_null(ga_table_data[l_ac].field197),"',",
        "'",adzi170_null(ga_table_data[l_ac].field198),"',",
        "'",adzi170_null(ga_table_data[l_ac].field199),"',",
        "'",adzi170_null(ga_table_data[l_ac].field200),"',",
        "'",adzi170_null(ga_table_data[l_ac].field201),"',",
        "'",adzi170_null(ga_table_data[l_ac].field202),"',",
        "'",adzi170_null(ga_table_data[l_ac].field203),"',",
        "'",adzi170_null(ga_table_data[l_ac].field204),"',",
        "'",adzi170_null(ga_table_data[l_ac].field205),"',",
        "'",adzi170_null(ga_table_data[l_ac].field206),"',",
        "'",adzi170_null(ga_table_data[l_ac].field207),"',",
        "'",adzi170_null(ga_table_data[l_ac].field208),"',",
        "'",adzi170_null(ga_table_data[l_ac].field209),"',",
        "'",adzi170_null(ga_table_data[l_ac].field210),"',",
        "'",adzi170_null(ga_table_data[l_ac].field211),"',",
        "'",adzi170_null(ga_table_data[l_ac].field212),"',",
        "'",adzi170_null(ga_table_data[l_ac].field213),"',",
        "'",adzi170_null(ga_table_data[l_ac].field214),"',",
        "'",adzi170_null(ga_table_data[l_ac].field215),"',",
        "'",adzi170_null(ga_table_data[l_ac].field216),"',",
        "'",adzi170_null(ga_table_data[l_ac].field217),"',",
        "'",adzi170_null(ga_table_data[l_ac].field218),"',",
        "'",adzi170_null(ga_table_data[l_ac].field219),"',",
        "'",adzi170_null(ga_table_data[l_ac].field220),"',",
        "'",adzi170_null(ga_table_data[l_ac].field221),"',",
        "'",adzi170_null(ga_table_data[l_ac].field222),"',",
        "'",adzi170_null(ga_table_data[l_ac].field223),"',",
        "'",adzi170_null(ga_table_data[l_ac].field224),"',",
        "'",adzi170_null(ga_table_data[l_ac].field225),"',",
        "'",adzi170_null(ga_table_data[l_ac].field226),"',",
        "'",adzi170_null(ga_table_data[l_ac].field227),"',",
        "'",adzi170_null(ga_table_data[l_ac].field228),"',",
        "'",adzi170_null(ga_table_data[l_ac].field229),"',",
        "'",adzi170_null(ga_table_data[l_ac].field230),"',",
        "'",adzi170_null(ga_table_data[l_ac].field231),"',",
        "'",adzi170_null(ga_table_data[l_ac].field232),"',",
        "'",adzi170_null(ga_table_data[l_ac].field233),"',",
        "'",adzi170_null(ga_table_data[l_ac].field234),"',",
        "'",adzi170_null(ga_table_data[l_ac].field235),"',",
        "'",adzi170_null(ga_table_data[l_ac].field236),"',",
        "'",adzi170_null(ga_table_data[l_ac].field237),"',",
        "'",adzi170_null(ga_table_data[l_ac].field238),"',",
        "'",adzi170_null(ga_table_data[l_ac].field239),"',",
        "'",adzi170_null(ga_table_data[l_ac].field240),"',",
        "'",adzi170_null(ga_table_data[l_ac].field241),"',",
        "'",adzi170_null(ga_table_data[l_ac].field242),"',",
        "'",adzi170_null(ga_table_data[l_ac].field243),"',",
        "'",adzi170_null(ga_table_data[l_ac].field244),"',",
        "'",adzi170_null(ga_table_data[l_ac].field245),"',",
        "'",adzi170_null(ga_table_data[l_ac].field246),"',",
        "'",adzi170_null(ga_table_data[l_ac].field247),"',",
        "'",adzi170_null(ga_table_data[l_ac].field248),"',",
        "'",adzi170_null(ga_table_data[l_ac].field249),"',",
        "'",adzi170_null(ga_table_data[l_ac].field250),"'" ,
        ")"
       #151019-00006#1 add(e)
        #151019-00006#1 mark(s)
#        LET ls_sql =
#        "INSERT INTO ", ls_tmptbl,
#        " VALUES (",
#        #如果没有输入值，则record里的每个栏位的值为一个空格字符，
#        #所以需要使用CLIPPED
#        "'", ga_table_data[l_ac].field001 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field002 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field003 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field004 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field002 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field003 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field004 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field005 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field006 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field007 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field008 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field009 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field010 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field011 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field012 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field013 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field014 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field015 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field016 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field017 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field018 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field019 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field020 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field021 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field022 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field023 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field024 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field025 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field026 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field027 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field028 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field029 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field030 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field031 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field032 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field033 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field034 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field035 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field036 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field037 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field038 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field039 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field040 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field041 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field042 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field043 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field044 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field045 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field046 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field047 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field048 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field049 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field050 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field051 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field052 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field053 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field054 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field055 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field056 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field057 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field058 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field059 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field060 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field061 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field062 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field063 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field064 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field065 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field066 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field067 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field068 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field069 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field070 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field071 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field072 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field073 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field074 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field075 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field076 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field077 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field078 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field079 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field080 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field081 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field082 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field083 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field084 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field085 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field086 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field087 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field088 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field089 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field090 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field091 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field092 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field093 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field094 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field095 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field096 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field097 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field098 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field099 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field100 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field101 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field102 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field103 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field104 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field105 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field106 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field107 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field108 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field109 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field110 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field111 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field112 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field113 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field114 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field115 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field116 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field117 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field118 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field119 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field120 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field121 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field122 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field123 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field124 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field125 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field126 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field127 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field128 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field129 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field130 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field131 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field132 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field133 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field134 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field135 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field136 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field137 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field138 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field139 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field140 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field141 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field142 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field143 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field144 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field145 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field146 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field147 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field148 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field149 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field150 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field151 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field152 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field153 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field154 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field155 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field156 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field157 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field158 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field159 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field160 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field161 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field162 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field163 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field164 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field165 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field166 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field167 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field168 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field169 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field170 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field171 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field172 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field173 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field174 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field175 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field176 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field177 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field178 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field179 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field180 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field181 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field182 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field183 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field184 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field185 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field186 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field187 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field188 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field189 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field190 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field191 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field192 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field193 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field194 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field195 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field196 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field197 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field198 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field199 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field200 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field201 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field202 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field203 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field204 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field205 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field206 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field207 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field208 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field209 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field210 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field211 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field212 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field213 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field214 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field215 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field216 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field217 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field218 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field219 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field220 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field221 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field222 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field223 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field224 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field225 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field226 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field227 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field228 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field229 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field230 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field231 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field232 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field233 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field234 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field235 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field236 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field237 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field238 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field239 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field240 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field241 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field242 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field243 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field244 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field245 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field246 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field247 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field248 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field249 CLIPPED, "', ",
#        "'", ga_table_data[l_ac].field250 CLIPPED, "' ",
#       #150906-00007#1mark(s)
#      #  "'", ga_table_data[l_ac].field251 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field252 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field253 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field254 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field255 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field256 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field257 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field258 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field259 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field260 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field261 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field262 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field263 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field264 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field265 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field266 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field267 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field268 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field269 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field270 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field271 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field272 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field273 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field274 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field275 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field276 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field277 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field278 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field279 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field280 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field281 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field282 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field283 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field284 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field285 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field286 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field287 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field288 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field289 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field290 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field291 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field292 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field293 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field294 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field295 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field296 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field297 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field298 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field299 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field300 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field301 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field302 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field303 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field304 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field305 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field306 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field307 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field308 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field309 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field310 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field311 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field312 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field313 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field314 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field315 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field316 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field317 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field318 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field319 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field320 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field321 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field322 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field323 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field324 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field325 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field326 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field327 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field328 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field329 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field330 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field331 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field332 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field333 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field334 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field335 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field336 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field337 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field338 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field339 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field340 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field341 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field342 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field343 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field344 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field345 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field346 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field347 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field348 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field349 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field350 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field351 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field352 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field353 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field354 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field355 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field356 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field357 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field358 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field359 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field360 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field361 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field362 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field363 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field364 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field365 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field366 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field367 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field368 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field369 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field370 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field371 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field372 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field373 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field374 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field375 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field376 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field377 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field378 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field379 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field380 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field381 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field382 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field383 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field384 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field385 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field386 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field387 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field388 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field389 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field390 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field391 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field392 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field393 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field394 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field395 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field396 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field397 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field398 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field399 CLIPPED, "', ",
#      #  "'", ga_table_data[l_ac].field400 CLIPPED, "'  ",
#
#       #150906-00007#1mark(e)
#        ")"
#151019-00006#1 mark(e)

        EXECUTE IMMEDIATE ls_sql
        IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = SQLCA.SQLERRD[2], "\nFailed to insert current data to temp table ", gs_tmptbl, "..."
            LET g_errparam.code   = SQLCA.SQLCODE
            LET g_errparam.popup  = FALSE
            CALL cl_err()
            RETURN FALSE
        END IF

    END IF

    RETURN TRUE
END FUNCTION
{</section>}

{<section id="adzi170.insert_to_target_table" >}
#+ (使用Insert into Table2(field1,field2,...) select value1,value2,... from Table1的形式新增数据）
#+ 将临时表中的数据有选择性地插入到目标表中。
PRIVATE FUNCTION adzi170_insert_to_target_table()
    DEFINE ls_sql        STRING
    DEFINE ls_tmptbl     STRING
    DEFINE li_i          INTEGER

    LET ls_tmptbl = gs_tmptbl
    #指定插入的字段id
    #因为从dezb_t表取得的表栏位信息的顺序与表字段的真实顺序不同，会导致插入错误
    LET ls_sql = "INSERT INTO ", ga_tab[1], " ( "
    FOR li_i = 1 TO gi_feld_cnt
        LET ls_sql = ls_sql, ga_feld_id[li_i]
        IF li_i != gi_feld_cnt THEN
            LET ls_sql = ls_sql, ", "
        END IF
    END FOR
    LET ls_sql = ls_sql, " ) "
    LET ls_sql = ls_sql, adzi170_get_sql_of_select_tmptbl_data()

    EXECUTE IMMEDIATE ls_sql
    IF SQLCA.SQLCODE THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.extend = SQLCA.SQLERRD[2],"\nFailed to insert data to target table..."
        LET g_errparam.code   = SQLCA.SQLCODE
        LET g_errparam.popup  = TRUE
        CALL cl_err()
        RETURN FALSE
    END IF

    RETURN TRUE
END FUNCTION
{</section>}

{<section id="adzi170.get_sql_of_select_tmptbl_data" >}
#+ (使用Insert into Table2(field1,field2,...) select value1,value2,... from Table1的形式新增数据）
#+ 生成从临时表获取所需字段的SQL（后半部分的select语句）
PRIVATE FUNCTION adzi170_get_sql_of_select_tmptbl_data()
    DEFINE li_i                       INTEGER
    DEFINE ls_i                       STRING
    DEFINE ls_feld_no                 STRING
    DEFINE ls_feld_id                 STRING
    DEFINE ls_tmptbl                  STRING
    DEFINE ls_tmptbl_feld_toselect    STRING
    DEFINE ls_sql                     STRING

    LET ls_tmptbl = gs_tmptbl
    LET ls_tmptbl_feld_toselect = gs_tmptbl_feld_toselect
    LET ls_sql = "SELECT ", ls_tmptbl_feld_toselect
    LET ls_sql = ls_sql, " FROM ", ls_tmptbl

    RETURN ls_sql
END FUNCTION
{</section>}

{<section id="adzi170.tmptbl_exists" >}
#+ 查找临时表是否存在
PRIVATE FUNCTION adzi170_tmptbl_exists()
    DEFINE ls_cnt_sql           STRING
    DEFINE li_tmptbl_cnt     INTEGER
    LET ls_cnt_sql = "SELECT COUNT(*) FROM user_objects WHERE object_name = '", gs_tmptbl.toUpperCase() , "'"

    PREPARE tmp_cnt_cur FROM ls_cnt_sql
    EXECUTE tmp_cnt_cur INTO li_tmptbl_cnt
    IF SQLCA.SQLCODE THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.extend = SQLCA.SQLERRD[2],"\nTemp table to be used doesn't exist any longer..."
        LET g_errparam.code   = SQLCA.SQLCODE
        LET g_errparam.popup  = TRUE
        CALL cl_err()
    END IF
    FREE tmp_cnt_cur

    IF li_tmptbl_cnt != 1 THEN
        RETURN FALSE
    ELSE
        RETURN TRUE
    END IF

END FUNCTION
{</section>}

{<section id="adzi170.get_tmptbl_data_cnt" >}
#+ 返回临时表当前数据行数
PRIVATE FUNCTION adzi170_get_tmptbl_data_cnt()
    DEFINE ls_cnt_sql                STRING
    DEFINE li_tmptbl_data_cnt     INTEGER
    LET ls_cnt_sql = "SELECT COUNT(*) FROM ", gs_tmptbl

    PREPARE tmptbl_data_cnt_cur FROM ls_cnt_sql
    EXECUTE tmptbl_data_cnt_cur INTO li_tmptbl_data_cnt
    IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = SQLCA.SQLERRD[2],"\nError occurred in getting data count from temp table ", gs_tmptbl, "..."
      LET g_errparam.code   = SQLCA.SQLCODE
      LET g_errparam.popup  = FALSE
      CALL cl_err()
    END IF
    FREE tmptbl_data_cnt_cur

    RETURN li_tmptbl_data_cnt
END FUNCTION
{</section>}

{<section id="adzi170.get_tmptbl_id" >}
#+ 生成临时表的唯一ID
PRIVATE FUNCTION adzi170_get_tmptbl_id()
   DEFINE li_serial LIKE type_t.num10
   DEFINE ls_serial STRING

   SELECT USERENV('SESSIONID') INTO li_serial FROM DUAL
   LET ls_serial = li_serial

   RETURN ls_serial
END FUNCTION
{</section>}

{<section id="adzi170.get_upd_sql" >}
#+ 返回for update的SQL语句
PRIVATE FUNCTION adzi170_get_upd_sql(ps_table)
   #add-point:lock_b段define
   DEFINE ps_table                 STRING
   DEFINE li_i                     INTEGER
   DEFINE li_cnt                   INTEGER #WHERE中主键数量计数
   DEFINE ls_forupd_where_con      STRING
   DEFINE ls_analyzed_feld         STRING
   DEFINE ls_sql                   STRING
   #end add-point

   IF NOT adzi170_insert_current_data_to_tmptbl() THEN
       RETURN
   END IF

   LET ls_analyzed_feld = gs_analyzed_feld

   #LET ls_sql = "SELECT ", ls_analyzed_feld   #mark by wangxy 20141022
   #modify by wangxy 20141022 - begin
   LET ls_sql = " SELECT "
   FOR li_i = 1 TO gi_feld_cnt
       IF li_i <> gi_feld_cnt THEN
          LET ls_sql = ls_sql," ",ga_feld_id[li_i],","
       ELSE
          LET ls_sql = ls_sql," ",ga_feld_id[li_i]," "
       END IF
   END FOR
   #modify by wangxy 20141022 - end 

   LET ls_sql = ls_sql, " FROM ", ga_tab[1], " WHERE "

   FOR li_i = 1 TO gi_feld_cnt
       IF adzi170_feld_type(ga_feld_id[li_i], "pk") THEN
           LET ls_forupd_where_con = ls_forupd_where_con, ga_feld_id[li_i], "='", adzi170_get_col_data_from_tmptbl(li_i) CLIPPED ,"' "
           LET li_cnt = li_cnt + 1
           IF li_cnt != ga_pk_feld_id.getLength() THEN
               LET ls_forupd_where_con = ls_forupd_where_con, " AND "
           END IF
       END IF
   END FOR
   #保存到全局变量中方便之后使用
   LET gs_forupd_where_con = ls_forupd_where_con

   LET ls_sql = ls_sql, ls_forupd_where_con
   #最后加上for update nowait
   LET ls_sql = ls_sql, " FOR UPDATE NOWAIT"

   LET gs_forupd_sql = ls_sql

END FUNCTION
{</section>}

{<section id="adzi170.get_current_col_data" >}
#+ 从临时表中获取当前光标所指行的某一字段的值（之前已经将当前光标所指行的数据插入到了临时表中）
PRIVATE FUNCTION adzi170_get_col_data_from_tmptbl(pi_col_index)
    DEFINE pi_col_index     INTEGER
    DEFINE ls_tmptbl        STRING

    DEFINE li_i             INTEGER
    DEFINE ls_sql           STRING
    DEFINE ls_col_value     LIKE type_t.chr1000

    LET li_i = pi_col_index
    LET ls_tmptbl = gs_tmptbl

    LET ls_sql = "SELECT field", li_i USING "&&&"
    LET ls_sql = ls_sql, " FROM ", ls_tmptbl

    DECLARE col_data_c CURSOR FROM ls_sql
    FOREACH col_data_c INTO ls_col_value
    END FOREACH
    FREE col_data_c

    RETURN ls_col_value
END FUNCTION
{</section>}

{<section id="adzi170.check_col_required" >}
#+ 新增之后检查画面上必输栏位是否有值，都有的话返回true，否则返回false
{
PRIVATE FUNCTION adzi170_check_form_cols()
    DEFINE lw_w              ui.window
    DEFINE ln_w              om.DomNode
    DEFINE ls_w              STRING
    DEFINE lxd_w             xml.DomDocument
    DEFINE lxn_w,
           lxn_table_column,
           lxn_edit,
           lxn_btnedit       xml.DomNode
    DEFINE lxnl_items        xml.NodeList
    DEFINE l_i               INTEGER

    LET lw_w = ui.window.getcurrent()
    LET ln_w = lw_w.getNode()
    LET ls_w = ln_w.toString() # DOM序列化，将om.DomNode转化为xml.DomNode
    LET lxd_w = xml.DomDocument.createDocument(ls_w)
    LET lxnl_items = lxd_w.getElementsByTagName("TableColumn")
    FOR l_i = 1 TO gi_feld_cnt
        LET lxn_table_column = lxnl_items.getItem(l_i)
        IF lxn_table_column.getAttribute("sqlType") == "BYTE"
        OR lxn_table_column.getAttribute("sqlType") == "TEXT"
        THEN
            LET lxn_btnedit = lxn_table_column.getChildNodeItem(1)

        ELSE
            LET lxn_edit = lxn_table_column.getChildNodeItem(1)

        END IF

    END FOR
END FUNCTION
}
{</section>}

FUNCTION adzi170_get_columns_info()
   DEFINE l_serial                  INTEGER
   DEFINE ls_serial                 STRING
   DEFINE ls_tmptbl                 STRING 
   DEFINE l_sql                     STRING
   DEFINE l_i                       INTEGER
   DEFINE ls_feld_alias             STRING
   DEFINE ls_feld_type              STRING
   
   
   LET ls_serial = adzi170_get_tmptbl_id() 
   LET ls_tmptbl = "adzi170_",ls_serial,"_tmp1"
   
   LET l_sql = " CREATE TABLE ",ls_tmptbl,
               " TABLESPACE temptabs ",
               " AS ",
               "    (SELECT * ",
               "       FROM (",g_execmd,") ",
               "      WHERE 1 = 2) "
   PREPARE get_cols_crt FROM l_sql
   EXECUTE get_cols_crt
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code   = 'adz-00414' 
      LET g_errparam.popup  = TRUE 
      CALL cl_err()
      RETURN FALSE
   END IF
   
   LET l_i = 1
   LET l_sql = "   SELECT column_name,data_type,data_length,data_precision ",
               "     FROM user_tab_columns ",
               "    WHERE table_name = '",ls_tmptbl.toUpperCase(),"' ",
               " ORDER BY column_id "
   DECLARE get_cols_c CURSOR FROM l_sql
   FOREACH get_cols_c INTO ga_feld_alias[l_i],ga_feld_type[l_i],ga_feld_length[l_i],ga_feld_precision[l_i]
       #获取字段名称
       LET ls_feld_alias = ga_feld_alias[l_i]
       LET ga_feld_alias[l_i] = ls_feld_alias.toLowerCase()

       #获取字段类型
       LET ls_feld_type = ga_feld_type[l_i]
       LET ga_feld_type[l_i] = ls_feld_type.toLowerCase()
       IF ga_feld_type[l_i] MATCHES "timestamp*" THEN
          LET ga_feld_type[l_i] = "timestamp"
       END IF
       LET ga_feld_id[l_i] = ga_feld_alias[l_i]

       #获取字段长度(根据不同的字段类型对ga_feld_length重新赋值)
       IF NOT cl_null(ga_feld_precision[l_i]) THEN
          LET ga_feld_length[l_i] = ga_feld_precision[l_i]
       END IF
       IF ga_feld_type[l_i] MATCHES "date" THEN
          LET ga_feld_length[l_i] = 10
       END IF
       IF ga_feld_type[l_i] MATCHES "timestamp*" THEN
          LET ga_feld_length[l_i] = 20 
       END IF 

       LET l_i = l_i + 1
   END FOREACH
   CALL ga_feld_alias.deleteElement(l_i)
   CALL ga_feld_id.deleteElement(l_i)
   CALL ga_feld.deleteElement(l_i)
   CALL ga_feld_type.deleteElement(l_i)
   CALL ga_feld_length.deleteElement(l_i)
   CALL ga_feld_precision.deleteElement(l_i)
   LET gi_feld_cnt = ga_feld_alias.getLength()

   LET l_sql = " DROP TABLE ",ls_tmptbl
   PREPARE get_cols_drop FROM l_sql
   EXECUTE get_cols_drop

   #获取栏位的说明信息
   FOR l_i = 1 TO gi_feld_cnt
       #SELECT dzeb003 INTO ga_feld[l_i] FROM dzeb_t WHERE dzeb002 = ga_feld_alias[l_i]   #160317-00002#2 mark 多语言    
       SELECT dzebl003 INTO ga_feld[l_i] FROM dzebl_t WHERE dzebl001 = ga_feld_alias[l_i] AND dzebl002=g_dlang #160317-00002#2 add
       IF cl_null(ga_feld[l_i]) THEN
          LET ga_feld[l_i] = ga_feld_alias[l_i]
       END IF
   END FOR

   RETURN TRUE 

END FUNCTION

FUNCTION adzi170_get_field_alias()
   DEFINE l_i                  LIKE type_t.num5
   DEFINE l_j                  LIKE type_t.num5
   DEFINE l_str                STRING
   DEFINE l_str_t              STRING
   DEFINE l_keyword_idx        LIKE type_t.num5
   DEFINE l_feld_idx_src       LIKE type_t.num5     #每个字段查找的起始位置
   DEFINE l_feld_str           STRING
   DEFINE l_feld_idx           LIKE type_t.num5
   DEFINE l_eof_idx            LIKE type_t.num5
   DEFINE l_inter_str          STRING
   DEFINE l_inter_sub_str1     STRING   #"select"关键字与"distinct "/"unique "/"all "关键字之间的字符串
   DEFINE l_inter_sub_str2     STRING
   DEFINE l_feld_idx_sub_src   LIKE type_t.num5
   DEFINE l_include_keyword    LIKE type_t.chr1
   DEFINE l_include_feld       LIKE type_t.chr1
   DEFINE l_comma_idx          LIKE type_t.num5
   DEFINE l_comma_idx_pre      LIKE type_t.num5
   DEFINE l_comma_idx_pre_acd  LIKE type_t.num5

   LET l_str = g_execmd.subString(g_sqlstmt[1].select,g_sqlstmt[1].from-1)
   LET l_str_t = l_str
   LET l_str = l_str.toLowerCase()
   
   FOR l_i = 1 TO gi_feld_cnt
      IF l_i = 1 THEN
         #由于SQL语句的起始位置除去空格的情况,肯定为"select"关键字,所以下述的语句读到的肯定为第1个"select"关键字,因此不需要考虑是否包含在单引号中
         LET l_feld_idx_src = l_str.getIndexOf("select",1)
         LET l_feld_idx_src  = l_feld_idx_src + 6
          
         #判断"select"关键字后面是否有"distinct "/"unique "/"all "关键字位置
         LET l_include_keyword = 'N'
         LET l_keyword_idx = l_str.getIndexOf("distinct ",1)
         IF l_keyword_idx <> 0 THEN         
            LET l_inter_sub_str1 = l_str.subString(l_feld_idx_src,l_keyword_idx-1)
            LET l_inter_sub_str1 = l_inter_sub_str1.trim()
            IF cl_null(l_inter_sub_str1) THEN
               LET l_include_keyword = 'Y'
               LET l_feld_idx_src = l_keyword_idx + 8 
            END IF
         END IF
         
         IF l_include_keyword = 'N' THEN
            LET l_keyword_idx = l_str.getIndexOf("unique ",1)
            IF l_keyword_idx <>0 THEN
               LET l_inter_sub_str1 = l_str.subString(l_feld_idx_src,l_keyword_idx-1)           
               LET l_inter_sub_str1 = l_inter_sub_str1.trim()
               IF cl_null(l_inter_sub_str1) THEN
                  LET l_include_keyword = 'Y'
                  LET l_feld_idx_src = l_keyword_idx + 6
               END IF
            END IF
         END IF
         
         IF l_include_keyword = 'N' THEN              
            LET l_keyword_idx = l_str.getIndexOf("all ",1)
            IF l_keyword_idx <> 0 THEN
               LET l_inter_sub_str1 = l_str.subString(l_feld_idx_src,l_keyword_idx-1)
               LET l_inter_sub_str1 = l_inter_sub_str1.trim()
               IF cl_null(l_inter_sub_str1) THEN
                  LET l_include_keyword = 'Y'
                  LET l_feld_idx_src = l_keyword_idx + 3
               END IF
            END IF   
         END IF

         LET g_select_end_idx = l_feld_idx_src - 1
      END IF
   
      #字段别名位置的确定
      LET l_feld_str = ga_feld_alias[l_i]   #每个字段的别名或者正式名称

      LET l_feld_idx_sub_src = l_feld_idx_src
      
      LET l_include_feld = 'Y'
      
      WHILE TRUE
         #关于ga_feld_alis[l_i]的字符串找不到
         #1.说明:
         #  若l_feld_idx = 0,说明此时ga_feld_alias[l_i]中存放的肯定为字段的本来的名称,且对应的字段没有使用别名.
         #  因为别名的命名中不允许出现空格、||、(、)等符号
         
         #2.导致l_feld_idx = 0的如下情况
         #  (1)SELECT tab_name.* 类型
         #  (2)SELECT column_name1 || column_name2,针对这种情况,ga_feld_alias[l_i]中存放的是去掉空格的字段名称
         #  (3)SELECT FUNCTION( column_name ),针对这种情况,ga_feld_alias[l_i]中存放的是去掉空格的字段名称
         
         #3.出现上述情况,需要做的处理
         #  (1)ga_feld_id[l_i] = ga_feld_alias[l_i]
         #  (2)ga_feld_alias[l_i]=NULL
         
         #4.下次查找位置的影响
         #(1)下次查找位置的影响:
         #   在SELECT子句中,若该字段后的字段采用的别名的方式,需要查找对应字段的真实字段名称,
         #   若查找位置不动会影响到获取的真实字段名称
         #(2)解决办法:
         #   截取真实的字段名称时,若出现",",且不是包含在单引号中,则需要截取单引号后的字符串
         
         #该WHILE循环,目的找到不包含在单引号中且匹配ga_feld_alias[l_i]的值
         WHILE TRUE
            LET l_feld_idx = l_str.getIndexOf(l_feld_str,l_feld_idx_sub_src)
            IF l_feld_idx = 0 THEN
               EXIT WHILE
            END IF
            IF NOT adzi170_judge_quote_include(l_feld_idx) THEN
               EXIT WHILE
            END IF
            LET l_feld_idx_sub_src = l_feld_idx + l_feld_str.getLength()
         END WHILE      
         
         IF l_feld_idx = 0 THEN
            LET l_include_feld = 'N'
            EXIT WHILE
         END IF
                 
         IF l_i <> gi_feld_cnt THEN
            LET l_eof_idx = l_str.getIndexOf(",",l_feld_idx+1)
         ELSE
            LET l_eof_idx = l_str.getIndexOf(" ",l_feld_idx+1)
         END IF
         LET l_inter_sub_str2 = l_str.subString(l_feld_idx+l_feld_str.getLength(),l_eof_idx-1)
         LET  l_inter_sub_str2 = l_inter_sub_str2.trim()
         IF cl_null(l_inter_sub_str2) THEN  #说明找到了[列名 ,]OR[列名 ]的组合
            EXIT WHILE
         END IF
         LET l_feld_idx_sub_src = l_feld_idx + 1
      END WHILE

      IF l_include_feld = 'Y' THEN
         #LET l_inter_str = l_str.subString(l_feld_idx_src,l_feld_idx-1)
         LET l_inter_str = l_str_t.subString(l_feld_idx_src,l_feld_idx-1)
         LET l_j = 1
         LET l_comma_idx_pre_acd = 0
         WHILE TRUE
           IF l_j = 1 THEN
              LET l_comma_idx_pre = 0
           END IF
           LET l_comma_idx = l_inter_str.getIndexOf(",",l_comma_idx_pre+1)
           IF l_comma_idx = 0 THEN
              EXIT WHILE
           END IF
           IF NOT adzi170_judge_quote_include(l_comma_idx+l_feld_idx_src-1) THEN
              LET l_comma_idx_pre_acd = l_comma_idx
           END IF
           LET l_comma_idx_pre = l_comma_idx
           LET l_j = l_j + 1
         END WHILE

         IF l_comma_idx_pre_acd <> 0 THEN
            LET l_feld_idx_src = l_comma_idx_pre_acd + 1
            LET l_inter_str = l_inter_str.subString(l_feld_idx_src,l_inter_str.getLength())
         END IF
         
         LET l_inter_str = l_inter_str.trim()
         
         IF cl_null(l_inter_str) THEN
            LET ga_feld_id[l_i] = ga_feld_alias[l_i]
            LET ga_feld_alias[l_i] = NULL
         ELSE
            LET ga_feld_id[l_i] = l_inter_str
         END IF        
         LET l_feld_idx_src = l_eof_idx + 1      
      ELSE
         LET ga_feld_id[l_i] = ga_feld_alias[l_i]
         LET ga_feld_alias[l_i] = NULL
      END IF
        
   END FOR
      
END FUNCTION
{<section id="adzi170.handle_sql_format" >}
#+ 格式化SQL语句
FUNCTION adzi170_handle_sql_format()
   DEFINE l_sub_str            STRING
   DEFINE l_tok                base.StringTokenizer
   DEFINE l_str                STRING              #临时存储STRING类型的字符串
   DEFINE l_str_t              STRING
   DEFINE l_str_len            LIKE type_t.num5    #上述字符串的长度
   DEFINE l_where_idx          LIKE type_t.num5    #where子句的开始位置
   DEFINE l_where_str          STRING              #where子句的内容(不包括"where"关键字)
   DEFINE l_where_start_src    LIKE type_t.num5    #"where"关键字从哪个位置开始查找
   DEFINE l_end_symbol         LIKE type_t.chr1    #结尾字符
   DEFINE l_i                  LIKE type_t.num5
   DEFINE l_select_idx         LIKE type_t.num5
   DEFINE l_select_idx_pre     LIKE type_t.num5
   DEFINE l_from_idx           LIKE type_t.num5
   DEFINE l_from_idx_pre       LIKE type_t.num5
   DEFINE l_sqlstmt            STRING
   
   #1.将输入的换行符使用空格拼接
   LET l_tok = base.StringTokenizer.createExt(gs_user_input_sql CLIPPED, "\n", "", TRUE)
   LET l_str = NULL
   WHILE l_tok.hasMoreTokens()
       LET l_sub_str = l_tok.nextToken()
       IF cl_null(l_str) THEN
           LET l_str = l_sub_str.trim()
       ELSE
           LET l_str = l_str CLIPPED, ' ', l_sub_str.trim()
       END IF
   END WHILE
 
 #160707-00022#1 mark(s)  #不直接转成小写是怕where条件内容被转化
 #  #2.将输入的SQL语句中的"SELECT"关键字与"FROM"关键字全部转换为小写
 #  LET l_str_t = l_str
 #  LET l_str = l_str.toLowerCase()
 #  LET l_i = 1
 #  WHILE TRUE
 #     IF l_i = 1 THEN
 #        LET l_select_idx_pre = 0
 #     END IF
 #     LET l_select_idx = l_str.getIndexOf("select",l_select_idx_pre+1)
 #     IF l_select_idx = 0 THEN
 #        EXIT WHILE
 #     END IF
 #     LET l_sqlstmt = l_str_t.subString(1,l_select_idx-1),"select",l_str_t.subString(l_select_idx+6,l_str_t.getLength())
 #     LET l_select_idx_pre = l_select_idx
 #     LET l_i = l_i + 1 
 #  END WHILE
 #  IF cl_null(l_sqlstmt) THEN    #说明无"select"关键字
 #     LET l_sqlstmt = l_str_t
 #  END IF
 #  LET l_str_t = l_sqlstmt

 #  LET l_i = 1
 #  WHILE TRUE
 #     IF l_i = 1 THEN
 #        LET l_from_idx_pre = 0
 #     END IF
 #     LET l_from_idx = l_str.getIndexOf("from",l_from_idx_pre+1)
 #     IF l_from_idx = 0 THEN
 #        EXIT WHILE
 #     END IF
 #     LET l_sqlstmt = l_str_t.subString(1,l_from_idx-1),"from",l_str_t.subString(l_from_idx+4,l_str_t.getLength())
 #     LET l_from_idx_pre = l_from_idx
 #     LET l_i = l_i + 1
 #  END WHILE
 #  IF cl_null(l_sqlstmt) THEN    #说明字符串中无"from"关键字
 #     LET l_sqlstmt = l_str_t
 #  END IF
 #  LET l_str = l_sqlstmt.trim()
# 160707-00022#1  mark(e) 
   #3.去掉结尾处的分号
   LET l_str_len = l_str.getLength()
   LET l_end_symbol = l_str.subString(l_str_len,l_str_len)
   IF l_end_symbol = ";" THEN
      LET l_str = l_str.subString(1,l_str_len - 1)
   END IF

   #得到没有分号的完整SQL
   LET g_execmd = l_str.trim()
   
END FUNCTION


FUNCTION adzi170_judge_simple_sql()
   DEFINE l_str                STRING
   DEFINE l_select_cnt         LIKE type_t.num5     #"select"关键字的个数
   DEFINE l_select_idx         LIKE type_t.num5
   DEFINE l_select_idx_p       LIKE type_t.num5     #上个"select"关键字的位置
   DEFINE l_select_start_idx   LIKE type_t.num5     #"select"子句的起始位置
   DEFINE l_select_end_idx     LIKE type_t.num5     #"select"子句的结束位置
   DEFINE l_from_start_idx     LIKE type_t.num5     #"from"子句的起始位置
   DEFINE l_where_idx          LIKE type_t.num5     #"where"关键字的位置
   DEFINE l_order_idx          LIKE type_t.num5     #"order by"关键字的位置
   DEFINE l_group_idx          LIKE type_t.num5     #"group by"关键字的位置
   DEFINE l_from_end_idx       LIKE type_t.num5     #from子句的结束位置
     
   DEFINE l_select_substr      STRING               #select子句
   DEFINE l_from_substr        STRING               #from子句
   DEFINE l_bracket_idx        LIKE type_t.num5     #"("的位置
   DEFINE l_connector_idx      LIKE type_t.num5     #"||"的位置
   DEFINE l_comma_idx          LIKE type_t.num5     #","的位置
   DEFINE l_join_idx           LIKE type_t.num5     #"join"的位置

   
   LET l_str = g_execmd
   
   #由于SELECT与FROM总是成对出现,所以判断了SELECT关键字的个数,相当于也判断了FROM关键字的个数
   LET l_select_cnt = 1
   WHILE TRUE
      IF l_select_cnt = 1 THEN
         LET l_select_idx_p = 0
      END IF
      LET l_select_idx = l_str.getIndexOf("select", l_select_idx_p + 1)
      IF l_select_idx = 0 THEN
         EXIT WHILE
      END IF
      LET l_select_idx_p = l_select_idx
      LET l_select_cnt = l_select_cnt + 1
   END WHILE
   LET l_select_cnt = l_select_cnt - 1
   
   IF l_select_cnt = 1 THEN
      #判断SELECT子句中是否有"("或者"||"出现
      LET l_from_start_idx = l_str.getIndexOf("from",1)
      LET l_select_start_idx = l_select_idx_p
      LET l_select_end_idx = l_from_start_idx - 1
      LET l_select_substr = l_str.subString(l_select_start_idx+6,l_select_end_idx)
      LET l_bracket_idx = l_select_substr.getIndexOf("(",1)
      LET l_connector_idx = l_select_substr.getIndexOf("||",1)
      
      IF l_bracket_idx = 0 AND l_connector_idx = 0 THEN   
         #判断FROM子句的结束位置
         LET l_where_idx = l_str.getIndexOf("where", 1)
         IF l_where_idx <> 0 THEN
            LET l_from_end_idx = l_where_idx - 1
            LET l_str = l_str.subString(1, l_where_idx - 1)
         ELSE
            LET l_order_idx = l_str.getIndexOf("order by",1)
            IF l_order_idx <> 0 THEN
               LET l_from_end_idx = l_order_idx - 1
               LET l_str = l_str.subString(1, l_order_idx - 1)
            ELSE
               LET l_group_idx = l_str.getIndexOf("group by",1)
               IF l_group_idx <> 0 THEN
                  LET l_from_end_idx = l_group_idx - 1
                  LET l_str = l_str.subString(1, l_group_idx - 1) 
               ELSE
                  LET l_from_end_idx = l_str.getLength()
               END IF
            END IF
         END IF
      
         LET l_from_substr = l_str.subString(l_from_start_idx+4,l_from_end_idx)
         LET l_bracket_idx = l_from_substr.getIndexOf("(",1)
         LET l_join_idx = l_from_substr.getIndexOf("join",1)
         LET l_comma_idx = l_from_substr.getIndexOf(",",1)
         IF l_bracket_idx = 0 AND l_join_idx = 0 AND l_comma_idx = 0 THEN
            LET ga_tab[1] = l_from_substr.Trim()
         END IF           
      END IF
   END IF    
   
END FUNCTION


FUNCTION adzi170_get_select_pos()
   DEFINE l_str        STRING
   DEFINE p_pos        INTEGER
   DEFINE l_des        DYNAMIC ARRAY OF RECORD
          pos          INTEGER,
          sign         LIKE type_t.chr10 
          END RECORD
   DEFINE l_des_tmp    RECORD
          pos          INTEGER,
          sign         LIKE type_t.chr10 
          END RECORD
   DEFINE l_pos        INTEGER
   DEFINE l_i          INTEGER
   DEFINE l_j          INTEGER
   DEFINE l_k          INTEGER
   DEFINE l_m          INTEGER
   DEFINE l_n          INTEGER
   DEFINE l_o          INTEGER
   DEFINE l_from_tmp   INTEGER
   DEFINE l_stack      DYNAMIC ARRAY OF INTEGER
   DEFINE l_status     CHAR(1)
   DEFINE l_status_des STRING

   LET l_str = g_execmd
   LET l_status = 'Y'

   #分别读取"select"与"from"关键字
   LET l_i = 1
   WHILE TRUE
      IF l_i = 1 THEN
         LET l_pos = 0
      ELSE
         LET l_pos = l_des[l_i-1].pos
      END IF
      
      #判断"select"关键字是否包含在单引号中
      WHILE TRUE
         LET l_des[l_i].pos = l_str.getIndexOf("select",l_pos+1)
         IF l_des[l_i].pos = 0 THEN   #说明已经找不到"select"关键字
            EXIT WHILE
         ELSE
            IF NOT adzi170_judge_quote_include(l_des[l_i].pos) THEN   #说明找到对应的关键字,且未包含在单引号中
               EXIT WHILE
            END IF
         END IF
      END WHILE
      
      IF l_des[l_i].pos = 0 THEN
         EXIT WHILE
      END IF
      LET l_des[l_i].sign = "select"
      LET l_i = l_i + 1
   END WHILE
   
   LET l_from_tmp = l_i
   WHILE TRUE
      IF l_i = l_from_tmp THEN
         LET l_pos = 0
      ELSE
         LET l_pos = l_des[l_i-1].pos
      END IF
      
      WHILE TRUE
         LET l_des[l_i].pos = l_str.getIndexOf("from",l_pos+1)
         IF l_des[l_i].pos = 0 THEN   #说明已经找不到"from"关键字
            EXIT WHILE
         ELSE
            IF NOT adzi170_judge_quote_include(l_des[l_i].pos) THEN    #说明找到"from"关键字,且未包含在单引号中
               EXIT WHILE
            END IF
         END IF
      END WHILE
      IF l_des[l_i].pos = 0 THEN
         EXIT WHILE
      END IF
      LET l_des[l_i].sign = "from"
      LET l_i = l_i + 1
   END WHILE
   CALL l_des.deleteElement(l_i)
   LET l_i = l_i - 1

   #对l_des中的内容,按照位置排序
   FOR l_m = l_from_tmp  TO l_des.getLength()
       FOR l_n = 1 TO l_m -1
           #l_m说明需要调整的")"的当前位置;l_n说明需要调整到的位置
           IF l_des[l_m].pos < l_des[l_n].pos THEN
              LET l_des_tmp.pos = l_des[l_m].pos
              LET l_des_tmp.sign = l_des[l_m].sign
              FOR l_o = l_m TO l_n STEP - 1
                 LET l_des[l_o].* = l_des[l_o-1].*
              END FOR
              LET l_des[l_n].* = l_des_tmp.*
              EXIT FOR
           END IF
       END FOR
   END FOR

   #将上述的数据采用堆栈的方式,说明配对结果
   LET l_j = 0
   LET l_k = 0
   FOR l_i = 1 TO l_des.getLength()
       IF l_des[l_i].sign = "select" THEN
          LET l_j = l_j + 1
          LET l_stack[l_j] = l_des[l_i].pos
       END IF
       IF l_des[l_i].sign = "from" THEN
          LET l_k = l_k + 1
          LET g_sqlstmt[l_k].from = l_des[l_i].pos
          IF l_j <> 0 THEN
             LET g_sqlstmt[l_k].select = l_stack[l_j]
             CALL l_stack.deleteElement(l_j)
             LET l_j = l_j - 1
          END IF
       END IF
   END FOR
END FUNCTION

FUNCTION adzi170_get_quote_pos()
   DEFINE l_str             STRING
   DEFINE l_i               LIKE type_t.num5
   DEFINE l_quote_idx       LIKE type_t.num5
   DEFINE l_quote_idx_pre   LIKE type_t.num5
   
   LET l_str = g_execmd
   LET l_i = 1
   WHILE TRUE
      IF l_i = 1 THEN
         LET l_quote_idx_pre = 0
      END IF
      
      LET l_quote_idx = l_str.getIndexOf("'",l_quote_idx_pre + 1)
      IF l_quote_idx = 0 THEN
         EXIT WHILE
      END IF
      LET g_quote[l_i].start = l_quote_idx
      LET l_quote_idx_pre = l_quote_idx
      
      LET l_quote_idx = l_str.getIndexOf("'",l_quote_idx_pre + 1)
      IF l_quote_idx = 0 THEN
         EXIT WHILE
      END IF
      LET g_quote[l_i].end = l_quote_idx
      LET l_quote_idx_pre = l_quote_idx
      LET l_i = l_i + 1   
   END WHILE
   CALL g_quote.deleteElement(l_i)
END FUNCTION


FUNCTION adzi170_judge_quote_include(p_idx)
   DEFINE p_idx              LIKE type_t.num5
   DEFINE l_i                LIKE type_t.num5
   FOR l_i = 1 TO g_quote.getLength()
      IF p_idx > g_quote[l_i].start AND p_idx < g_quote[l_i].end THEN
         RETURN TRUE
         EXIT FOR
      END IF
   END FOR
   RETURN FALSE
END FUNCTION

#150906-00007#1 add(s)
FUNCTION adzi170_export_to_excel()
   DEFINE ls_msg    STRING
   DEFINE li_result STRING
   DEFINE ls_sql     STRING  
   DEFINE l_i       LIKE type_t.num10

   LET ls_sql = gs_analyzed_sql
   #IF gi_total_record_cnt>100 THEN
   IF gi_total_record_cnt>10000 THEN
      CALL cl_getmsg('adz-00688',g_dlang) RETURNING ls_msg
      IF NOT cl_ask_promp(ls_msg) THEN 
      LET gi_end_row=10000
      #LET gi_end_row=100
      LET ls_sql = "SELECT * ",
                  # "  FROM (SELECT A.*, ROWNUM RN ",
                   "  FROM (SELECT A.* ",
                   "           FROM (", ls_sql, ") A ",
                   "          WHERE ROWNUM <= ", gi_end_row , ") "
                 #  "  WHERE RN >= ", gi_start_row         
      END IF
    END IF

    #DISPLAY "sql:",ls_sql
    PREPARE to_excel_pre FROM ls_sql
    DECLARE to_excel_cur CURSOR FOR to_excel_pre
    IF SQLCA.SQLCODE THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.extend = SQLCA.SQLERRD[2]
        LET g_errparam.code   = SQLCA.SQLCODE
        LET g_errparam.popup  = TRUE
        CALL cl_err()
    END IF

    LET l_i = 1
   
    CALL gs_table_data.clear()
    #填充数据到ga_table_data全局变量数组
    #DISPLAY "FOREACH star:",TIME(CURRENT)
    FOREACH to_excel_cur INTO gs_table_data[l_i].*
        #IF SQLCA.SQLCODE THEN
            #INITIALIZE g_errparam TO NULL
            #LET g_errparam.extend = SQLCA.SQLERRD[2]
            #LET g_errparam.code   = SQLCA.SQLCODE
            #LET g_errparam.popup  = TRUE
            #CALL cl_err()
        #END IF
        LET l_i=l_i+1
      #  IF l_i > g_max_rec THEN
      #      INITIALIZE g_errparam TO NULL
      #      LET g_errparam.extend = 9035
      #      LET g_errparam.code   = 0
      #      LET g_errparam.popup  = TRUE
      #      CALL cl_err()
      #      EXIT FOREACH
      #  END IF
    END FOREACH
    #DISPLAY "FOREACH end:",TIME(CURRENT)
    IF SQLCA.SQLCODE THEN
        INITIALIZE g_errparam TO NULL
        LET g_errparam.extend = SQLCA.SQLERRD[2]
        LET g_errparam.code   = SQLCA.SQLCODE
        LET g_errparam.popup  = TRUE
        CALL cl_err()
    END IF

    #DISPLAY "Free to_excel_cur start:",TIME(CURRENT)
    FREE to_excel_cur
    #DISPLAY "Free to_excel_cur end:",TIME(CURRENT)

    CALL gs_table_data.deleteElement(l_i)

    CALL g_export_node.clear()
    #DISPLAY "g_export_node 赋值 start:",TIME(CURRENT)
    LET g_export_node[1] = base.typeInfo.create(gs_table_data)
    #DISPLAY "g_export_node 赋值 end:",TIME(CURRENT)
   #CALL g_export_node[1].writeXml( "sjb.xml" )

    #DISPLAY "调用cl_export_to_excel函数 start:",TIME(CURRENT)
    CALL cl_export_to_excel()
    #DISPLAY "调用cl_export_to_excel函数 end:",TIME(CURRENT)
END FUNCTION
#150906-00007#1 add(e)

#151019-00006#1 add(s)
#如果没有输入值,则record里的每个栏位的值为一个空格字符，
#所以需要使用CLIPPED
 PUBLIC FUNCTION adzi170_null(ps_source)
   DEFINE   ps_source    STRING
   DEFINE   li_is_null   LIKE type_t.num5

   IF (ps_source IS NULL) THEN
      LET ps_source=ps_source CLIPPED 
   END IF

   RETURN ps_source 
END FUNCTION

#151019-00006#1 add(e)

