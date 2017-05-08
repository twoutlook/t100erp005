#+ 程式版本......: T6 Version 1.00.00 Build-0001 at 12/12/21
#
#+ 程式代碼......: sadzp169_01
#+ 設計人員......: Jay
# Prog. Version..: 'T6-12.01.21(00000)'     #
#
# Program name   : sadzp169_01.4gl 
# Description    : 比對新/舊版畫面設計資料的Patch工具
# Memo           :

IMPORT os
SCHEMA ds

GLOBALS "../../cfg/top_global.inc"
GLOBALS "../4gl/adzp168_global.inc"

CONSTANT g_widget_group = "widget_group"                 #元件組合群組代碼前綴字元
CONSTANT g_patch_grid = "patch_grid"                     #單頭類型patch區塊

DEFINE g_dzfi001             LIKE dzfi_t.dzfi001         #結構代號
DEFINE g_dzfi002             LIKE dzfi_t.dzfi002         #客製畫面最大版次
DEFINE g_dzfi009             LIKE dzfi_t.dzfi009         #客製標示='c'

DEFINE g_field_info          type_g_field                #欄位設計資料
DEFINE g_dzfi017             LIKE dzfi_t.dzfi017         #客戶代號
DEFINE g_error_message       STRING                      #錯誤訊息
DEFINE g_new_container       LIKE type_t.chr1            #是否為本次新增之container

PUBLIC FUNCTION sadzp169_01()   
   DEFINE l_time_s          DATETIME YEAR TO SECOND 
   DEFINE l_time_e          DATETIME YEAR TO SECOND 
   
   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log

   LET l_time_s = cl_get_current()
   DISPLAY "   Strat time : ", l_time_s, ASCII 10

   #配置自定義欄位
   IF NOT sadzp169_01_set_ud_field(g_udset.rel_position, g_udset.dzfj005_rel, g_udset.udtable, g_udset.udcol, g_udset.dzfj006) THEN
      RETURN FALSE
   END IF

   LET l_time_e = cl_get_current()
   DISPLAY ASCII 10, ASCII 10, "    End  time : ", l_time_e
   DISPLAY "    Cost time : ", l_time_e - l_time_s

   LET g_error_message = ""
   RETURN TRUE
END FUNCTION

PUBLIC FUNCTION sadzp169_01_set_ud_field(p_config_mode, p_dzfj005_ref, p_dzeb001, p_dzeb002, p_dzfj006)
   DEFINE p_config_mode     LIKE dzfi_t.dzfi001     #配置模式(1:在...欄位之上; 2:在...欄位之下)
   DEFINE p_dzfj005_ref     LIKE dzfj_t.dzfj005     #配置模式參考的widget控件代碼
   DEFINE p_dzeb001         LIKE dzeb_t.dzeb001     #自定義欄位資料表代碼
   DEFINE p_dzeb002         LIKE dzeb_t.dzeb002     #自定義欄位代碼
   DEFINE p_dzfj006         LIKE dzfj_t.dzfj006     #控件樣式
   
   DEFINE l_dzfj_ref        type_g_dzfj             #參考控件(widget)設計資料
   DEFINE l_dzfi_ref        type_g_dzfi             #參考控件(widget)設計資料
   
   IF cl_null(p_dzfj005_ref) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "adz-00394"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF
   
   IF cl_null(p_dzeb001) OR cl_null(p_dzeb002) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "adz-00393"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF
   
   IF NOT sadzp169_01_init() THEN
      DISPLAY "Cannot initialize API."         #程式初始化失敗
      RETURN FALSE
   END IF

   #取得參考控件widget設計資料
   CALL sadzp169_01_get_ref_dzfj(p_dzfj005_ref)
      RETURNING l_dzfj_ref.*

   IF cl_null(l_dzfj_ref.dzfj003) THEN
      DISPLAY "dzfj003 is null."
      RETURN FALSE
   END IF

   #取得自定義欄位應所屬Container代碼設計資料
   CALL sadzp169_01_get_ref_dzfi(l_dzfj_ref.dzfj003)
      RETURNING l_dzfi_ref.*

   IF cl_null(l_dzfi_ref.dzfi004) THEN
      DISPLAY "dzfi004 is null."
      RETURN FALSE
   END IF

   #取得客戶代號
   LET g_dzfi017 = l_dzfi_ref.dzfi017

   #取得欄位設計資料
   IF NOT sadzp169_01_get_field_info(p_dzeb001, p_dzeb002, p_dzfj006) THEN
      RETURN FALSE
   END IF

   #BEGIN WORK
   
   #配置自定義欄位
   IF NOT sadzp169_01_add_widget_pre(p_config_mode, g_field_info.*, l_dzfj_ref.*, l_dzfi_ref.*) THEN
      #ROLLBACK WORK
      RETURN FALSE
   END IF

   #COMMIT WORK
   
   RETURN TRUE
END FUNCTION

#+ 程式相關資料初始化
PRIVATE FUNCTION sadzp169_01_init()
   DEFINE l_sql             STRING

   LET g_dzfi001 = g_udset.dzfi001     #需配置自定義欄位的UI畫面代號
   LET g_dzfi002 = g_dzaf003           #規格版次
   LET g_dzfi009 = g_dzaf010           #識別標示(自定義的配置都識為客製,應該都為'c')

   #取得欄位相關設計資訊
   LET l_sql = "SELECT DISTINCT dzeb005, gztd003, gztd008, dzep009, dzep010, ",
               "                dzep020, dzej003, dzef006, dzef008, dzer005, ",
               "                dzer007, dzet006, dzep021, dzep022, dzep023 ",
               "  FROM dzeb_t LEFT JOIN gztd_t ON dzeb006 = gztd001 ",
               "              LEFT JOIN dzep_t ON dzeb001 = dzep001 AND dzeb002 = dzep002 ",
               "              LEFT JOIN dzej_t ON dzep010 = dzej002 AND dzej001 = 'GENERO_WIDGETS' ",
               "              LEFT JOIN dzef_t ON dzeb001 = dzef001 AND dzeb002 = dzef002 ",
               "              LEFT JOIN dzer_t ON dzeb001 = dzer001 AND dzeb002 = dzer002 ",
               "              LEFT JOIN dzet_t ON dzeb001 = dzet001 AND dzeb002 = dzet002 ",
               "  WHERE dzeb001 = ? AND dzeb002 = ? "
   PREPARE sadzp169_01_field_info_pre FROM l_sql
   
   RETURN TRUE
END FUNCTION

#+ 取得參考控件dzfj_t(widget)設計資料
PRIVATE FUNCTION sadzp169_01_get_ref_dzfj(p_dzfj005_ref)
   DEFINE p_dzfj005_ref     LIKE dzfj_t.dzfj005     #參考控件的控件代碼(widget name)
   
   DEFINE l_dzfj            type_g_dzfj             #參考控件(widget)設計資料

   INITIALIZE l_dzfj TO NULL
   
   #取得參考控件所屬的元件組代碼
   SELECT dzfj001, dzfj002, dzfj003, dzfj004, dzfj005, 
          dzfj006, dzfj007, dzfj008, dzfj009, dzfj010, 
          dzfj011, dzfj012, dzfj013, dzfj014, dzfj015, 
          dzfj016, dzfj017, dzfj018, dzfjstus 
     INTO l_dzfj.dzfj001, l_dzfj.dzfj002, l_dzfj.dzfj003, l_dzfj.dzfj004, l_dzfj.dzfj005, 
          l_dzfj.dzfj006, l_dzfj.dzfj007, l_dzfj.dzfj008, l_dzfj.dzfj009, l_dzfj.dzfj010, 
          l_dzfj.dzfj011, l_dzfj.dzfj012, l_dzfj.dzfj013, l_dzfj.dzfj014, l_dzfj.dzfj015, 
          l_dzfj.dzfj016, l_dzfj.dzfj017, l_dzfj.dzfj018, l_dzfj.dzfjstus
     FROM dzfj_t
     WHERE dzfj001 = g_dzfi001 
       AND dzfj002 = g_dzfi002
       AND dzfj017 = g_dzfi009
       AND dzfj005 =  p_dzfj005_ref

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "sel ref dzfj_t:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN l_dzfj.*
   END IF

   RETURN l_dzfj.*
END FUNCTION

#+ 取得自定義欄位的參考控件所屬Container代碼設計資料
PRIVATE FUNCTION sadzp169_01_get_ref_dzfi(p_dzfj003_ref)
   DEFINE p_dzfj003_ref     LIKE dzfj_t.dzfj003     #參考控件所屬的元件組代碼
   
   DEFINE l_dzfi            type_g_dzfi             #參考控件所屬的Container代碼

   INITIALIZE l_dzfi TO NULL

   #取得參考控件所屬的Container代碼
   SELECT dzfi001, dzfi002, dzfi003, dzfi004, dzfi005, 
          dzfi006, dzfi007, dzfi008, dzfi009, dzfi010, 
          dzfi011, dzfi012, dzfi013, dzfi014, dzfi015, 
          dzfi016, dzfi017,
          dzfiownid, dzfiowndp, dzficrtid, dzficrtdp, dzficrtdt,
          dzfimodid, dzfimoddt, dzfistus 
     INTO l_dzfi.dzfi001, l_dzfi.dzfi002, l_dzfi.dzfi003, l_dzfi.dzfi004, l_dzfi.dzfi005, 
          l_dzfi.dzfi006, l_dzfi.dzfi007, l_dzfi.dzfi008, l_dzfi.dzfi009, l_dzfi.dzfi010, 
          l_dzfi.dzfi011, l_dzfi.dzfi012, l_dzfi.dzfi013, l_dzfi.dzfi014, l_dzfi.dzfi015, 
          l_dzfi.dzfi016, l_dzfi.dzfi017,
          l_dzfi.dzfiownid, l_dzfi.dzfiowndp, l_dzfi.dzficrtid, l_dzfi.dzficrtdp, l_dzfi.dzficrtdt,
          l_dzfi.dzfimodid, l_dzfi.dzfimoddt, l_dzfi.dzfistus 
     FROM dzfi_t 
     WHERE dzfi001 = g_dzfi001 
       AND dzfi002 = g_dzfi002
       AND dzfi009 = g_dzfi009
       AND dzfi006 = p_dzfj003_ref
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "sel ref dzfi_t:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN l_dzfi.*
   END IF
  
   RETURN l_dzfi.*
END FUNCTION


#+ 取得欄位設計資料
PRIVATE FUNCTION sadzp169_01_get_field_info(p_dzeb001, p_dzeb002, p_dzfj006) 
   DEFINE p_dzeb001            LIKE dzeb_t.dzeb001    #自定義欄位資料表代碼
   DEFINE p_dzeb002            LIKE dzeb_t.dzeb002    #自定義欄位代碼
   DEFINE p_dzfj006            LIKE dzfj_t.dzfj006    #控件樣式
   
   DEFINE l_widget_info        type_g_widget_info

   IF cl_null(p_dzeb001) OR cl_null(p_dzeb002) THEN
      DISPLAY "p_dzeb001(or p_dzeb002) is null."
      RETURN FALSE
   END IF
   
   #採用於r.a的add field的原理,因此這裡利用r.a相關邏輯配置自定義欄位
   #取得欄位相關設計資訊
   EXECUTE sadzp169_01_field_info_pre USING p_dzeb001, p_dzeb002
     INTO l_widget_info.*

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  SQLCA.sqlcode
      LET g_errparam.extend = 'sel: sadzp169_01_field_info_pre'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF

   LET g_field_info.dzfr003 = 1
   LET g_field_info.sort = 1
   LET g_field_info.sqlTabName = p_dzeb001 CLIPPED
   LET g_field_info.colName = p_dzeb002 CLIPPED
   LET g_field_info.attrName = p_dzeb001 CLIPPED, ".", p_dzeb002 CLIPPED
   LET g_field_info.attrRequired = "N"
   LET g_field_info.notNull = l_widget_info.dzeb005
   LET g_field_info.datatype = l_widget_info.gztd003
   LET g_field_info.length = l_widget_info.gztd008

   #因為控件類型以配置過程為主,變更dzep010的類型代碼
   #LET g_field_info.dzep010 = l_widget_info.dzep010
   SELECT dzej002 INTO g_field_info.dzep010 FROM dzej_t
     WHERE dzej001 = 'GENERO_WIDGETS'
       AND dzej003 = p_dzfj006
   
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "sel dzej_t:"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF

   IF cl_null(g_field_info.dzep010) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "adz-00392"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF
   
   LET g_field_info.dzej003 = p_dzfj006
   LET g_field_info.widgetWidth = l_widget_info.dzep009
   LET g_field_info.reftable = l_widget_info.dzef006
   LET g_field_info.refField = l_widget_info.dzef008
   LET g_field_info.detailPK = ""

   LET g_field_info.langField = l_widget_info.dzer007
   LET g_field_info.dzer005 = l_widget_info.dzer005
   LET g_field_info.mnemField = l_widget_info.dzet006
   LET g_field_info.dzet002 = ""
   LET g_field_info.dzep020 = l_widget_info.dzep020
   LET g_field_info.dzek001 = ""
   LET g_field_info.dzeb022 = ""
   LET g_field_info.dzep021 = l_widget_info.dzep021
   LET g_field_info.dzep022 = l_widget_info.dzep022
   LET g_field_info.dzep023 = l_widget_info.dzep023
   
   LET g_field_info.srowSeq = 1
   LET g_field_info.srow = ""
   LET g_field_info.dzfr006 = p_dzfj006

   RETURN TRUE
END FUNCTION

#+ 新增自定義欄位設計資料前置作業
PRIVATE FUNCTION sadzp169_01_add_widget_pre(p_config_mode, p_field_info, p_dzfj_relative, p_dzfi_relative)
   DEFINE p_config_mode        LIKE dzfi_t.dzfi001    #配置模式(1:在...欄位之上; 2:在...欄位之下)
   DEFINE p_field_info         type_g_field           #欄位設計資料
   DEFINE p_dzfj_relative      type_g_dzfj            #參考控件(widget)設計資料
   DEFINE p_dzfi_relative      type_g_dzfi            #參考控件所屬的畫面結構元件組合檔(dzfi_t)

   DEFINE l_add_mode           LIKE type_t.chr10      #新節點加入模式(DG_P:上一個群組參考點; DG_N:下一個群組參考點)   
   DEFINE l_dzfi_ins           type_g_dzfi            #畫面結構檔
   DEFINE l_dzfj_ins           type_g_dzfj            #新增至DB的widget設計資料
   
   DEFINE l_dzfj003            LIKE dzfj_t.dzfj003    #widget所屬群組
   DEFINE l_dzfj004            LIKE dzfj_t.dzfj004    #widget在群組下的順序位置
   DEFINE l_dzfj005            LIKE dzfj_t.dzfj005    #自定義欄位畫面widget代碼
   DEFINE l_dzfj013            LIKE dzfj_t.dzfj013
   DEFINE l_dzfj014            LIKE dzfj_t.dzfj014
   DEFINE l_dzfj015            LIKE dzfj_t.dzfj015
   DEFINE l_dzfj016            LIKE dzfj_t.dzfj016
   DEFINE l_dzfi005            LIKE dzfi_t.dzfi005    #畫面結構群組所取代的序號
   DEFINE l_success            LIKE type_t.chr1
   DEFINE l_posX               LIKE dzfj_t.dzfj013
   DEFINE l_grid_width         LIKE dzfj_t.dzfj015
   DEFINE l_grid_height        LIKE dzfj_t.dzfj016
   DEFINE l_ref_width          LIKE type_t.num5
   DEFINE l_ref_height         LIKE type_t.num5
   DEFINE l_lang_width         LIKE type_t.num5
   DEFINE l_lang_height        LIKE type_t.num5
   DEFINE l_dzfi007            LIKE dzfi_t.dzfi007    #Container類型
   DEFINE l_num                LIKE type_t.num5
   DEFINE l_ref_name           STRING

   INITIALIZE l_dzfi_ins TO NULL

   #預設自定義欄位widget的高度
   LET l_dzfj016 = 1
   LET l_grid_width = 0
   LET l_grid_height = 0   
   LET l_ref_height = 0 
   LET l_ref_width = 0
   LET l_lang_height = 0 
   LET l_lang_width = 0
   
   #取得自定義欄位所加入的container類型
   SELECT dzfi007 INTO l_dzfi007 FROM dzfi_t
     WHERE dzfi001 = g_dzfi001 
       AND dzfi002 = g_dzfi002
       AND dzfi009 = g_dzfi009
       AND dzfi006 = p_dzfi_relative.dzfi004

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  STATUS
      LET g_errparam.extend = "sel dzfi007:", p_dzfi_relative.dzfi004 CLIPPED
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF

   CASE p_config_mode
      WHEN "1"
         IF l_dzfi007 = "Table" OR l_dzfi007 = "Tree" THEN
            LET l_add_mode = "SG_N"
         ELSE
            LET l_add_mode = "DG_N"
         END IF
         
      WHEN "2"
         IF l_dzfi007 = "Table" OR l_dzfi007 = "Tree" THEN
            LET l_add_mode = "SG_P"
         ELSE
            LET l_add_mode = "DG_P"
         END IF
         
      OTHERWISE
         DISPLAY "p_config_mode:", p_config_mode CLIPPED, " is error."
         RETURN FALSE
   END CASE

   #取得是否需要新增[參考欄位]/[多語言欄位]控件,需要將順序位置先保留下來,以防ins_dzfj時失敗(PK問題)
   LET l_num = 1
       
   IF NOT cl_null(p_field_info.refField) THEN
      LET l_num = l_num + 1

      #預設ref欄位控件高為1,寬為10
      LET l_ref_height = 1 
      LET l_ref_width = 10
   END IF

   IF NOT cl_null(p_field_info.langField) THEN
      LET l_num = l_num + 1

      #預設多語言欄位控件高為1,寬為10
      LET l_lang_height = 1 
      LET l_lang_width = 30
   END IF

   #add MODE:(1)SG_P:參考控件在同一群組左方位置
   #         (2)SG_N:參考控件在同一群組右方位置
   #         (3)DG_P:參考控件在上方群組位置
   #         (4)DG_N:參考控件在下方群組位置 
   #         (5)其他
   CASE
      #SG_P:同一群組前面參考點:往上取得參考節點方式(採下一節點插入方式)
      #SG_N:同一群組前面參考點:往下取得參考節點方式(採取代此參考點節點插入方式)
      WHEN l_add_mode = "SG_P" OR l_add_mode = "SG_N"
         #元件群組設計資料可直接插入舊版的元件組合檔
         IF l_add_mode = "SG_P" THEN
            #將要插入的節點序號往後加1
            UPDATE dzfj_t SET dzfj004 = (dzfj004 + l_num)
              WHERE dzfj001 = g_dzfi001 
                AND dzfj002 = g_dzfi002
                AND dzfj017 = g_dzfi009
                AND dzfj003 = p_dzfj_relative.dzfj003 
                AND dzfj004 > p_dzfj_relative.dzfj004
         
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  SQLCA.sqlcode
               LET g_errparam.extend = "add_widget()-upd dzfj004 SG_P:", p_dzfj_relative.dzfj003 CLIPPED
               LET g_errparam.popup = TRUE
               CALL cl_err()
               RETURN FALSE
            END IF
            
            LET l_dzfj003 = p_dzfj_relative.dzfj003
            
            #此筆設計資料加入在參考點下一個順序位置
            LET l_dzfj004 = p_dzfj_relative.dzfj004 + 1
         ELSE
            #將要插入的節點序號往後加1
            UPDATE dzfj_t SET dzfj004 = (dzfj004 + l_num)
              WHERE dzfj001 = g_dzfi001 
                AND dzfj002 = g_dzfi002
                AND dzfj017 = g_dzfi009
                AND dzfj003 = p_dzfj_relative.dzfj003 
                AND dzfj004 >= p_dzfj_relative.dzfj004
         
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  SQLCA.sqlcode
               LET g_errparam.extend = "add_widget()-upd dzfj004 SG_N:", p_dzfj_relative.dzfj003 CLIPPED
               LET g_errparam.popup = TRUE
               CALL cl_err()
               RETURN FALSE
            END IF
            
            LET l_dzfj003 = p_dzfj_relative.dzfj003
            
            #此筆設計資料加入在參考點下一個順序位置
            LET l_dzfj004 = p_dzfj_relative.dzfj004
         END IF

         #新增[自定義欄位控件]
         CALL sadzp169_01_add_widget(l_dzfi007, p_field_info.*, l_dzfj003, l_dzfj004, l_dzfj013, l_dzfj014)
            RETURNING l_success, l_dzfj005, l_dzfj016, l_dzfj015
      
         IF NOT l_success THEN
            RETURN FALSE
         END IF

         #預設其他widget的X軸位置往右移[自定義欄位控件]的寬度
         LET l_grid_width = l_dzfj015
         
         #當有增加[ref欄位]/[多語言欄位]時,需再將其他widget的X軸位置往右移[ref欄位]/[多語言欄位]的寬度距離         
         IF NOT cl_null(p_field_info.refField) THEN
            LET l_grid_width = l_grid_width + l_ref_width
         END IF
         
         IF NOT cl_null(p_field_info.langField) THEN
            LET l_grid_width = l_grid_width + l_lang_width
         END IF
         
         #變更其他元件組合檔的X, Y軸位置,並取得自定義欄位widget的X, Y軸位置
         CALL sadzp169_01_set_widget_pos(l_add_mode, p_dzfi_relative.dzfi004, p_dzfj_relative.*, l_grid_width, l_dzfj016)
            RETURNING l_success, l_dzfj013, l_dzfj014
         
         IF NOT l_success THEN
            RETURN FALSE
         END IF
         
         UPDATE dzfj_t SET dzfj013 = l_dzfj013, dzfj014 = l_dzfj014
           WHERE dzfj001 = g_dzfi001 
             AND dzfj002 = g_dzfi002
             AND dzfj017 = g_dzfi009
             AND dzfj003 = p_dzfj_relative.dzfj003
             AND dzfj005 = l_dzfj005

         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  SQLCA.sqlcode
            LET g_errparam.extend = "set_widget_pos(dzfj013,dzfj014)-upd SG:dzfj_t.", l_dzfj005 CLIPPED
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN FALSE
         END IF

         ############處理reference欄位################################
         #當此欄位有參考欄位時,需要補reference欄位在後面
         IF NOT cl_null(p_field_info.refField) THEN
            #ref欄位所依附控件代碼
            LET p_field_info.dzai005 = base.StringBuffer.create()
            CALL p_field_info.dzai005.append(l_dzfj005)
            
            #ref欄位控件順序在主要控件之後
            LET l_dzfj004 = l_dzfj004 + 1
            
            #TABLE_COLUMN reference欄位命名,只需欄位名稱加上'_desc', exp:dzea_t.dzea001=> dzea001_desc
            LET l_ref_name = p_field_info.colName CLIPPED

            #計算ref欄位 posX 位置(=自定義欄位控件的posX + 寬度)
            LET l_dzfj013 = l_dzfj013 + l_dzfj015

            #新增[ref欄位控件]
            CALL sadzp169_01_add_reference(l_dzfi007, l_dzfj003, l_dzfj004, l_ref_name, p_field_info.refField, l_dzfj013, l_dzfj014, l_ref_width, l_ref_height)
              RETURNING l_success, l_ref_name

            IF NOT l_success THEN
               RETURN FALSE
            END IF

            LET p_field_info.dzai002 = base.StringBuffer.create()
            CALL p_field_info.dzai002.append(l_ref_name)
         END IF
         ###########################################################

         ############處理多語言欄位控件################################
         #記錄多語言欄位所依附欄位的控件名稱
         IF NOT cl_null(p_field_info.langField) THEN
            LET p_field_info.dzaj005 = base.StringBuffer.create()
            CALL p_field_info.dzaj005.append(l_dzfj005)

            #多語言欄位控件順序在主要控件之後
            LET l_dzfj004 = l_dzfj004 + 1
            
            #計算多語言欄位 posX 位置(=自定義欄位控件的posX + 寬度 (+ 參考欄位寬度))
            #todo:l_ref_width(參考欄位寬度)如果沒有時應該會被預設為0,但如果中間邏輯被改變過這樣直接加就會不準了
            LET l_dzfj013 = l_dzfj013 + l_dzfj015 + l_ref_width

            #新增[多語言欄位控件]
            CALL sadzp169_01_add_lang(l_dzfi007, l_dzfj003, l_dzfj004, p_field_info.dzer005, p_field_info.langField, l_dzfj013, l_dzfj014, l_lang_width, l_lang_height)
              RETURNING l_success, l_ref_name

            IF NOT l_success THEN
               RETURN FALSE
            END IF

            LET p_field_info.dzaj002 = base.StringBuffer.create()
            CALL p_field_info.dzaj002.append(l_ref_name)
         END IF
         ###########################################################

      #WHEN "SG_N"   #同一群組前面參考點:往下取得參考節點方式(採取代此參考點節點插入方式)
      #   #元件群組設計資料可直接插入舊版的元件組合檔
      #   #將要插入的節點序號往後加1
      #   UPDATE dzfj_t SET dzfj004 = (dzfj004 + 1)
      #     WHERE dzfj001 = g_dzfi001 
      #       AND dzfj002 = g_dzfi002
      #       AND dzfj017 = g_dzfi009
      #       AND dzfj003 = p_dzfj_relative.dzfj003 
      #       AND dzfj004 >= p_dzfj_relative.dzfj004

      #   IF SQLCA.sqlcode THEN
      #      INITIALIZE g_errparam TO NULL
      #      LET g_errparam.code =  SQLCA.sqlcode
      #      LET g_errparam.extend = "add_widget()-upd dzfj004 SG_N:", p_dzfj_relative.dzfj003 CLIPPED
      #      LET g_errparam.popup = TRUE
      #      CALL cl_err()
      #      RETURN FALSE
      #   END IF
         
      #   LET l_dzfj003 = p_dzfj_relative.dzfj003
         
      #   #此筆設計資料加入在參考點下一個順序位置
      #   LET l_dzfj004 = p_dzfj_relative.dzfj004

      #DG_P:往上已取得群組的參考點:在參考群組下一個序號加入一組全新的元件群組設計資料
      #DG_N:往下已取得群組的參考點:在參考群組上一個序號加入一組全新的元件群組設計資料
      WHEN l_add_mode = "DG_P" OR l_add_mode = "DG_N"
         #有加入資料多語言欄位控件時,需再將dzfi(元件組合)順序多加1
         LET l_num = 1
         IF NOT cl_null(p_field_info.langField) THEN
            LET l_num = l_num + 1
         END IF
         
         #將要插入的元件群組序號往後加1
         IF l_add_mode = "DG_P" THEN
            UPDATE dzfi_t SET dzfi005 = (dzfi005 + l_num)
              WHERE dzfi001 = g_dzfi001 
                AND dzfi002 = g_dzfi002
                AND dzfi009 = g_dzfi009
                AND dzfi004 = p_dzfi_relative.dzfi004
                AND dzfi005 > p_dzfi_relative.dzfi005
         
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  SQLCA.sqlcode
               LET g_errparam.extend = "add_widget()-upd DG_P:", p_dzfi_relative.dzfi004 CLIPPED
               LET g_errparam.popup = TRUE
               CALL cl_err()
               RETURN FALSE
            END IF
         
            LET l_dzfi005 = p_dzfi_relative.dzfi005 + 1
         ELSE
            UPDATE dzfi_t SET dzfi005 = (dzfi005 + l_num)
              WHERE dzfi001 = g_dzfi001 
                AND dzfi002 = g_dzfi002
                AND dzfi009 = g_dzfi009
                AND dzfi004 = p_dzfi_relative.dzfi004
                AND dzfi005 >= p_dzfi_relative.dzfi005
         
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code =  SQLCA.sqlcode
               LET g_errparam.extend = "add_widget()-upd DG_N:", p_dzfi_relative.dzfi004 CLIPPED
               LET g_errparam.popup = TRUE
               CALL cl_err()
               RETURN FALSE
            END IF

            LET l_dzfi005 = p_dzfi_relative.dzfi005
         END IF

         #####insert 畫面結構檔資枓表#####         
         CALL sadzp169_01_ins_dzfi(p_dzfi_relative.dzfi004, l_dzfi005)
            RETURNING l_success, l_dzfi_ins.*

         IF NOT l_success THEN
            RETURN FALSE
         END IF

         #取得widget所屬元件組合群組代碼
         LET l_dzfj003 = l_dzfi_ins.dzfi006

         #預設其他widget的X軸位置往右移[自定義欄位控件]的寬度
         LET l_grid_height = l_dzfj016

         #有資料多語言控件需要新增時,需再將其他widget的Y軸位置往下多移[多語言欄位]的高度距離
         IF NOT cl_null(p_field_info.langField) THEN
            LET l_grid_height = l_grid_height + l_lang_height
         END IF
         
         #變更其他元件組合檔的X, Y軸位置,並取得自定義欄位widget的X, Y軸位置
         CALL sadzp169_01_set_widget_pos(l_add_mode, p_dzfi_relative.dzfi004, p_dzfj_relative.*, l_dzfj015, l_grid_height)
            RETURNING l_success, l_dzfj013, l_dzfj014
         
         IF NOT l_success THEN
            RETURN FALSE
         END IF

         #不同群組的元件組合,代表是類似單頭的加入方式:
         #在單頭中的一個欄位控件新增 = [Label(敘述)] + [欄位控件]

         #[Label(敘述)] widget順序為1
         LET l_dzfj004 = 1

         #指定[Label(敘述)]的X軸位置
         #sadzp169_01_set_widget_pos計算X軸時,已保留了label的寬度,這裡只需要利用相同公式減回來
         LET l_posX = l_dzfj013 - 10 - 1
         LET l_grid_width = 10

         #新增[Label(敘述)]相關設計資料
         CALL sadzp169_01_add_static_label(l_dzfi007, p_field_info.colName, p_field_info.dzej003, l_dzfj003, l_dzfj004, l_posX, l_dzfj014, l_grid_width)
            RETURNING l_success, l_dzfj004
            
         IF NOT l_success THEN
            RETURN FALSE
         END IF

         #新增[自定義欄位控件]
         CALL sadzp169_01_add_widget(l_dzfi007, p_field_info.*, l_dzfj003, l_dzfj004, l_dzfj013, l_dzfj014)
            RETURNING l_success, l_dzfj005, l_dzfj016, l_dzfj015

         IF NOT l_success THEN
            RETURN FALSE
         END IF

         ############處理reference欄位################################
         #當此欄位有參考欄位時,需要補reference欄位在後面
         IF NOT cl_null(p_field_info.refField) THEN
            #ref欄位所依附控件代碼
            LET p_field_info.dzai005 = base.StringBuffer.create()
            CALL p_field_info.dzai005.append(l_dzfj005)

            #ref欄位控件順序在主要控件之後
            LET l_dzfj004 = l_dzfj004 + 1
            
            #TABLE_COLUMN reference欄位命名,只需欄位名稱加上'_desc', exp:dzea_t.dzea001=> dzea001_desc
            LET l_ref_name = p_field_info.colName CLIPPED

            #計算ref欄位 posX 位置(=自定義欄位控件的posX + 寬度 + 1)
            LET l_dzfj013 = l_dzfj013 + l_dzfj015 + 1

            #新增[ref控件]
            CALL sadzp169_01_add_reference(l_dzfi007, l_dzfj003, l_dzfj004, l_ref_name, "", l_dzfj013, l_dzfj014, l_ref_width, l_ref_height)
              RETURNING l_success, l_ref_name

            IF NOT l_success THEN
               RETURN FALSE
            END IF

            LET p_field_info.dzai002 = base.StringBuffer.create()
            CALL p_field_info.dzai002.append(l_ref_name)
         END IF
         ###########################################################

         ############處理多語言欄位控件################################
         #記錄多語言欄位所依附欄位的控件名稱
         IF NOT cl_null(p_field_info.langField) THEN
            LET p_field_info.dzaj005 = base.StringBuffer.create()
            CALL p_field_info.dzaj005.append(l_dzfj005)
            
            #資料多語言欄位widget在單頭樣式來說,在依附欄位的下面一排(posY 要向下移動)
            #因此要多一組dzfi的元件組合資料
            LET l_dzfi005 = l_dzfi005 + 1
            
            CALL sadzp169_01_ins_dzfi(p_dzfi_relative.dzfi004, l_dzfi005)
               RETURNING l_success, l_dzfi_ins.*

            IF NOT l_success THEN
               RETURN FALSE
            END IF

            #取得資料多語言控件所屬元件組合群組代碼
            LET l_dzfj003 = l_dzfi_ins.dzfi006

            #此元件組合只有一個資料多語言控件,所以順序為1
            LET l_dzfj004 = 1

            #tood:posX軸與[自定義欄位控件]相同, posY軸則在[自定義欄位控件] posY + 1的地方
            LET l_dzfj013 = l_dzfj013
            LET l_dzfj014 = l_dzfj014 + 1
            
            #新增[多語言欄位控件]
            CALL sadzp169_01_add_lang(l_dzfi007, l_dzfj003, l_dzfj004, p_field_info.dzer005, p_field_info.langField, l_dzfj013, l_dzfj014, l_lang_width, l_lang_height)
              RETURNING l_success, l_ref_name

            IF NOT l_success THEN
               RETURN FALSE
            END IF

            LET p_field_info.dzaj002 = base.StringBuffer.create()
            CALL p_field_info.dzaj002.append(l_ref_name)
         END IF
         ###########################################################
         
      #WHEN "DG_N"   #往下已取得群組的參考點:在參考群組上一個序號加入一組全新的元件群組設計資料
      #   #將要插入的元件群組序號往後加1
      #   UPDATE dzfi_t SET dzfi005 = (dzfi005 + 1)
      #     WHERE dzfi001 = g_dzfi001 
      #       AND dzfi002 = g_dzfi002
      #       AND dzfi009 = g_dzfi009
      #       AND dzfi004 = p_dzfi_relative.dzfi004
      #       AND dzfi005 >= p_dzfi_relative.dzfi005

      #   IF SQLCA.sqlcode THEN
      #      INITIALIZE g_errparam TO NULL
      #      LET g_errparam.code =  SQLCA.sqlcode
      #      LET g_errparam.extend = "add_widget()-upd DG_N:", p_dzfi_relative.dzfi004 CLIPPED
      #      LET g_errparam.popup = TRUE
      #      CALL cl_err()
      #      RETURN FALSE
      #   END IF

      #   #####insert 畫面結構檔資枓表#####
      #   LET l_dzfi005 = p_dzfi_relative.dzfi005

      #   CALL sadzp169_01_ins_dzfi(p_dzfi_relative.dzfi004, l_dzfi005)
      #      RETURNING l_success, l_dzfi_ins.*

      #   IF NOT l_success THEN
      #      RETURN FALSE
      #   END IF

      #   #取得widget所屬元件組合群組代碼
      #   LET l_dzfj003 = l_dzfi_ins.dzfi006
         
      #   #變更其他元件組合檔的X, Y軸位置,並取得自定義欄位widget的X, Y軸位置
      #   CALL sadzp169_01_set_widget_pos(l_add_mode, p_dzfi_relative.dzfi004, p_dzfj_relative.*, l_dzfj015, l_dzfj016)
      #      RETURNING l_success, l_dzfj013, l_dzfj014
         
      #   IF NOT l_success THEN
      #      RETURN FALSE
      #   END IF

      #   #不同群組的元件組合,代表是類似單頭的加入方式:
      #   #在單頭中的一個欄位控件新增 = [Label(敘述)] + [欄位控件]

      #   #[Label(敘述)] widget順序為1
      #   LET l_dzfj004 = 1

      #   #指定[Label(敘述)]的X軸位置
      #   #sadzp169_01_set_widget_pos計算X軸時,已保留了label的寬度,這裡只需要利用相同公式減回來
      #   LET l_posX = l_dzfj013 - 10 - 1
      #   LET l_grid_width = 10

      #   #新增[Label(敘述)]相關設計資料
      #   CALL sadzp169_01_add_static_label(l_dzfi007, p_field_info.colName, p_field_info.dzej003, l_dzfj003, l_dzfj004, l_posX, l_dzfj014, l_grid_width)
      #      RETURNING l_success, l_dzfj004
            
      #   IF NOT l_success THEN
      #      RETURN FALSE
      #   END IF

      #   #新增[自定義欄位控件]
      #   CALL sadzp169_01_add_widget(l_dzfi007, p_field_info.*, l_dzfj003, l_dzfj004, l_dzfj013, l_dzfj014)
      #      RETURNING l_success, l_dzfj005, l_dzfj016, l_dzfj015

      #   IF NOT l_success THEN
      #      RETURN FALSE
      #   END IF

      OTHERWISE
      
   END CASE

   #將自定義欄位資料相關規格資料新增到tsd table中
   IF NOT sadzp169_01_insert_tsd(p_dzfi_relative.dzfi004, l_dzfi007, l_dzfj005, p_field_info.*) THEN
      RETURN FALSE
   END IF
   
   RETURN TRUE
END FUNCTION

#+ 新增一筆畫面結構檔(元件組合Group設計資料)
PRIVATE FUNCTION sadzp169_01_ins_dzfi(p_dzfi004, p_dzfi005)
   #DEFINE p_dzfi               type_g_dzfi
   DEFINE p_dzfi004            LIKE dzfi_t.dzfi004    #所屬Container代碼
   DEFINE p_dzfi005            LIKE dzfi_t.dzfi005    #畫面結構群組所取代的序號
   
   DEFINE l_dzfi003            LIKE dzfi_t.dzfi003    #畫面結構設計資料ID 
   DEFINE l_dzfi               type_g_dzfi            #畫面結構檔
   
   #取得最大ID序號值
   SELECT MAX(dzfi003) INTO l_dzfi003 FROM dzfi_t
     WHERE dzfi001 = g_dzfi001 
       AND dzfi002 = g_dzfi002
       AND dzfi009 = g_dzfi009
   
   LET l_dzfi.dzfi001 = g_dzfi001 CLIPPED
   LET l_dzfi.dzfi002 = g_dzfi002
   LET l_dzfi.dzfi003 = l_dzfi003 + 1
   LET l_dzfi.dzfi004 = p_dzfi004             #群組代碼
   LET l_dzfi.dzfi005 = p_dzfi005             #順序
   LET l_dzfi.dzfi006 = g_widget_group, l_dzfi.dzfi003 USING "<<<<<"    #元件(組)代碼
   LET l_dzfi.dzfi007 = ""                    #節點類型
   LET l_dzfi.dzfi008 = "Y"                   #畫面結構中是否顯示
   LET l_dzfi.dzfi009 = g_dzfi009 CLIPPED     #識別標示:c-客製
   LET l_dzfi.dzfi010 = "3"                   #包含元素類型3.Widget 
   LET l_dzfi.dzfi011 = ""                    #直橫排列V/H
   LET l_dzfi.dzfi012 = 99
   LET l_dzfi.dzfi013 = 0
   LET l_dzfi.dzfi014 = 0
   LET l_dzfi.dzfi015 = 0
   LET l_dzfi.dzfi016 = 0
   LET l_dzfi.dzfi017 = g_dzfi017
   LET l_dzfi.dzfistus = "Y"

   LET l_dzfi.dzfiownid = g_user
   LET l_dzfi.dzfiowndp = g_dept
   LET l_dzfi.dzficrtid = g_user
   LET l_dzfi.dzficrtdp = g_dept
   LET l_dzfi.dzficrtdt = cl_get_current()
   LET l_dzfi.dzfimodid = g_user
   LET l_dzfi.dzfimoddt = cl_get_current()

   INSERT INTO dzfi_t (dzfi001, dzfi002, dzfi003, dzfi004, dzfi005, 
                       dzfi006, dzfi007, dzfi008, dzfi009, dzfi010, 
                       dzfi011, dzfi012, dzfi013, dzfi014, dzfi015, 
                       dzfi016, dzfi017,
                       dzfiownid, dzfiowndp, dzficrtid, dzficrtdp, dzficrtdt,
                       dzfimodid, dzfimoddt, dzfistus)
     VALUES (l_dzfi.dzfi001, l_dzfi.dzfi002, l_dzfi.dzfi003, l_dzfi.dzfi004, l_dzfi.dzfi005, 
             l_dzfi.dzfi006, l_dzfi.dzfi007, l_dzfi.dzfi008, l_dzfi.dzfi009, l_dzfi.dzfi010, 
             l_dzfi.dzfi011, l_dzfi.dzfi012, l_dzfi.dzfi013, l_dzfi.dzfi014, l_dzfi.dzfi015, 
             l_dzfi.dzfi016, l_dzfi.dzfi017,
             l_dzfi.dzfiownid, l_dzfi.dzfiowndp, l_dzfi.dzficrtid, l_dzfi.dzficrtdp, l_dzfi.dzficrtdt,
             l_dzfi.dzfimodid, l_dzfi.dzfimoddt, l_dzfi.dzfistus) 

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  SQLCA.sqlcode
      LET g_errparam.extend = "ins dzfi_t:", l_dzfi.dzfi006 CLIPPED
      LET g_errparam.popup = TRUE
      CALL cl_err()
      INITIALIZE l_dzfi TO NULL
      RETURN FALSE, l_dzfi.*
   END IF

   RETURN TRUE, l_dzfi.*
END FUNCTION

#+ 新增一筆畫面結構檔(元件組合Group設計資料)
PRIVATE FUNCTION sadzp169_01_ins_dzfj(p_dzfj003, p_dzfj004, p_dzfj005, p_dzfj006, p_dzfj013, p_dzfj014, p_dzfj015, p_dzfj016)
   DEFINE p_dzfj003            LIKE dzfj_t.dzfj003    #所屬元件群組代碼
   DEFINE p_dzfj004            LIKE dzfj_t.dzfj004    #widget屬於元件群組的順序
   DEFINE p_dzfj005            LIKE dzfj_t.dzfj005    #widget代碼
   DEFINE p_dzfj006            LIKE dzfj_t.dzfj006    #widget類型
   DEFINE p_dzfj013            LIKE dzfj_t.dzfj013    #元件X軸位置
   DEFINE p_dzfj014            LIKE dzfj_t.dzfj014    #元件Y軸位置
   DEFINE p_dzfj015            LIKE dzfj_t.dzfj015    #元件寬度
   DEFINE p_dzfj016            LIKE dzfj_t.dzfj016    #元件高度
   
   DEFINE l_dzfj               type_g_dzfj            #畫面結構檔
    
   #新增此筆新版畫面元件組合(widget)設計資料
   LET l_dzfj.dzfj001 = g_dzfi001 CLIPPED
   LET l_dzfj.dzfj002 = g_dzfi002
   LET l_dzfj.dzfj003 = p_dzfj003 CLIPPED
   LET l_dzfj.dzfj004 = p_dzfj004
   LET l_dzfj.dzfj005 = p_dzfj005 CLIPPED
   LET l_dzfj.dzfj006 = p_dzfj006 CLIPPED
   LET l_dzfj.dzfj007 = ""
   LET l_dzfj.dzfj008 = ""
   LET l_dzfj.dzfj009 = ""
   LET l_dzfj.dzfj010 = ""
   LET l_dzfj.dzfj011 = ""
   LET l_dzfj.dzfj012 = ""
   LET l_dzfj.dzfj013 = p_dzfj013
   LET l_dzfj.dzfj014 = p_dzfj014
   LET l_dzfj.dzfj015 = p_dzfj015
   LET l_dzfj.dzfj016 = p_dzfj016
   LET l_dzfj.dzfj017 = g_dzfi009 CLIPPED
   LET l_dzfj.dzfj018 = g_dzfi017 CLIPPED
   LET l_dzfj.dzfjstus = "Y"
   
   INSERT INTO dzfj_t (dzfj001, dzfj002, dzfj003, dzfj004, dzfj005, 
                       dzfj006, dzfj007, dzfj008, dzfj009, dzfj010, 
                       dzfj011, dzfj012, dzfj013, dzfj014, dzfj015, 
                       dzfj016, dzfj017, dzfj018, dzfjstus)
     VALUES (l_dzfj.dzfj001, l_dzfj.dzfj002, l_dzfj.dzfj003, l_dzfj.dzfj004, l_dzfj.dzfj005, 
             l_dzfj.dzfj006, l_dzfj.dzfj007, l_dzfj.dzfj008, l_dzfj.dzfj009, l_dzfj.dzfj010, 
             l_dzfj.dzfj011, l_dzfj.dzfj012, l_dzfj.dzfj013, l_dzfj.dzfj014, l_dzfj.dzfj015, 
             l_dzfj.dzfj016, l_dzfj.dzfj017, l_dzfj.dzfj018, l_dzfj.dzfjstus) 

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  SQLCA.sqlcode
      LET g_errparam.extend = "ins dzfj_t:", l_dzfj.dzfj005 CLIPPED
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF

   RETURN TRUE
END FUNCTION

#+ insert 畫面元件屬性檔
PRIVATE FUNCTION sadzp169_01_ins_dzfk(p_node)
   DEFINE p_node            om.DomNode          #widget Node
   
   DEFINE l_dzfk            type_g_dzfk
   DEFINE l_i               LIKE type_t.num5
   DEFINE l_domDoc          om.DomDocument
   DEFINE l_root_node       om.DomNode
   
   IF p_node IS NULL THEN
      RETURN FALSE
   END IF

   #####insert 畫面元件屬性檔資枓表#####
   LET l_dzfk.dzfk001 = g_dzfi001 CLIPPED
   LET l_dzfk.dzfk002 = g_dzfi002
   LET l_dzfk.dzfk003 = p_node.getAttribute("name") CLIPPED     #元件代碼
   LET l_dzfk.dzfk004 = ""
   LET l_dzfk.dzfk005 = ""
   LET l_dzfk.dzfk006 = "" 
   LET l_dzfk.dzfk007 = g_dzfi009 CLIPPED   #客製標示:s-標準產品, c-客製
   LET l_dzfk.dzfk008 = g_dzfi017 CLIPPED   #客戶代號

   #取得節點所有屬性資料
   LOCATE l_dzfk.dzfk009 IN FILE
   LET l_domDoc = om.DomDocument.createFromString(p_node.toString())
   LET l_root_node = l_domDoc.copy(p_node, FALSE)
   LET l_dzfk.dzfk009 = l_root_node.toString()

   INSERT INTO dzfk_t(dzfk001, dzfk002, dzfk003, dzfk004, dzfk005, 
                      dzfk006, dzfk007, dzfk008, dzfk009)
     VALUES (l_dzfk.dzfk001, l_dzfk.dzfk002, l_dzfk.dzfk003, l_dzfk.dzfk004, l_dzfk.dzfk005, 
             l_dzfk.dzfk006, l_dzfk.dzfk007, l_dzfk.dzfk008, l_dzfk.dzfk009)

   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  SQLCA.sqlcode
      LET g_errparam.extend = "ins dzfk_t:", l_dzfk.dzfk003 CLIPPED
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF
   
   FREE l_dzfk.dzfk009
   
   RETURN TRUE
END FUNCTION

#+ 重新計算新插入的widget X, Y軸位置
PRIVATE FUNCTION sadzp169_01_set_widget_pos(p_add_mode, p_dzfi004, p_dzfj_relative, p_dzfj015_ud, p_dzfj016_ud)
   DEFINE p_add_mode           LIKE type_t.chr10      #新節點加入模式
   DEFINE p_dzfi004            LIKE dzfi_t.dzfi004    #自定義欄位所屬Container代碼
   DEFINE p_dzfj015_ud         LIKE dzfj_t.dzfj016    #自定義欄位widget寬度
   DEFINE p_dzfj016_ud         LIKE dzfj_t.dzfj016    #自定義欄位widget高度
   DEFINE p_dzfj_relative      type_g_dzfj            #新widget設計資料需加入在舊版參考點[畫面元件組合檔]中的相對位置節點
   #DEFINE p_dzfi006_relative   LIKE dzfi_t.dzfi006    #參考控件所屬的元件組合代碼
   #DEFINE p_dzfj_new           type_g_dzfj            #新增的畫面元件組合檔(新widget設計資料)

   DEFINE l_dzfj013_ud         LIKE dzfj_t.dzfj013
   DEFINE l_dzfj014_ud         LIKE dzfj_t.dzfj014
   
   DEFINE l_posX               LIKE dzfj_t.dzfj013    #參考控件群組的X軸
   DEFINE l_posY               LIKE dzfj_t.dzfj014    #參考控件群組的Y軸

   IF cl_null(p_dzfj016_ud) OR p_dzfj016_ud = 0 THEN
      LET p_dzfj016_ud = 1
   END IF
   
   CASE 
      #SG_P:同一群組前面參考點:往上取得參考節點方式(採下一節點插入方式)
      #SG_N:同一群組前面參考點:往下取得參考節點方式(採上一節點插入方式)
      WHEN p_add_mode = "SG_P" OR p_add_mode = "SG_N"
         #取得自定義欄位X軸位置:[Table]和[Tree]container 同一群組(同一排Y軸)插入:所以X軸位置直接加在參考點後面,預設[Y軸座標]和參考點一樣
         IF p_add_mode = "SG_P" THEN
            #新控件X軸 = 參考點控件X軸 + 參考點控件寬度
            LET l_dzfj013_ud = p_dzfj_relative.dzfj013 + p_dzfj_relative.dzfj015
            LET l_dzfj014_ud = p_dzfj_relative.dzfj014
         ELSE
            #新控件X軸 = 參考點控件X軸
            LET l_dzfj013_ud = p_dzfj_relative.dzfj013
            LET l_dzfj014_ud = p_dzfj_relative.dzfj014
         END IF

         #重新計算在同一個container下,因為插入新的widget位置,而其它控件的X軸位移關係
         #Container下的群組元件X軸 > 新控件的X軸, 往右位移(位移量為新控件的寬度)
         UPDATE dzfj_t SET dzfj013 = (dzfj013 + p_dzfj015_ud)
           WHERE dzfj001 = g_dzfi001 
             AND dzfj002 = g_dzfi002
             AND dzfj017 = g_dzfi009
             AND dzfj003 = p_dzfj_relative.dzfj003
             AND dzfj013 >= l_dzfj013_ud
             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  SQLCA.sqlcode
            LET g_errparam.extend = "set_widget_pos(dzfj013+dzfj015)-upd SG:dzfj_t.", p_dzfi004 CLIPPED
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN FALSE, l_dzfj013_ud, l_dzfj014_ud
         END IF

      #WHEN "SG_N"   #同一群組前面參考點:往下取得參考節點方式(採上一節點插入方式)
      #   #[Table]和[Tree]container 同一群組(同一排Y軸)插入:所以X軸位置直接加在參考點前面,預設[Y軸座標]和參考點一樣
      #   #新控件X軸 = 參考點控件X軸
      #   LET l_dzfj013_ud = p_dzfj_relative.dzfj013
      #   LET l_dzfj014_ud = p_dzfj_relative.dzfj014

      #   #重新計算在同一個container下,因為插入新的widget位置,而其它控件的X軸位移關係
      #   #Container下的群組元件X軸 > 新控件的X軸, 往右位移(位移量為新控件的寬度)
      #   UPDATE dzfj_t SET dzfj013 = (dzfj013 + p_dzfj015_ud)
      #     WHERE dzfj001 = g_dzfi001 
      #       AND dzfj002 = g_dzfi002
      #       AND dzfj017 = g_dzfi009
      #       AND dzfj003 = p_dzfj_relative.dzfj003
      #       AND dzfj013 >= l_dzfj013_ud

      #   IF SQLCA.sqlcode THEN
      #      INITIALIZE g_errparam TO NULL
      #      LET g_errparam.code =  SQLCA.sqlcode
      #      LET g_errparam.extend = "set_widget_pos(dzfj013+dzfj015)-upd SG_N:dzfj_t.", p_dzfi004 CLIPPED
      #      LET g_errparam.popup = TRUE
      #      CALL cl_err()
      #      RETURN FALSE, l_dzfj013_ud, l_dzfj014_ud
      #   END IF



      #DG_P:往上已取得群組的參考點:在參考群組下一個序號加入一組全新的元件群組設計資料
      #DG_N:往下已取得群組的參考點:在參考群組上一個序號加入一組全新的元件群組設計資料
      WHEN p_add_mode = "DG_P" OR p_add_mode = "DG_N"
         #取得Container下,上一個參考點群組的最小X軸數值(為新控件的X軸參考依據)
         SELECT MIN(dzfj013) INTO l_posX FROM dzfj_t
           WHERE dzfj001 = g_dzfi001 
             AND dzfj002 = g_dzfi002
             AND dzfj017 = g_dzfi009
             AND dzfj003 = p_dzfj_relative.dzfj003   #IN (SELECT dzfi006 FROM dzfi_t
                                                     #      WHERE dzfi001 = g_dzfi001 
                                                     #        AND dzfi002 = g_dzfi002
                                                     #        AND dzfi009 = g_dzfi009
                                                     #        AND dzfi004 = p_dzfi004)

         #取得自定義欄位Y軸位置
         IF p_add_mode = "DG_P" THEN
            #取得上一個參考點群組所用完的Y軸高度
            SELECT MAX(dzfj014+dzfj016) INTO l_posY FROM dzfj_t
              WHERE dzfj001 = g_dzfi001 
                AND dzfj002 = g_dzfi002
                AND dzfj017 = g_dzfi009
                AND dzfj003 = p_dzfj_relative.dzfj003
         ELSE
            #取得此參考點群組的Y軸高度
            SELECT DISTINCT dzfj014 INTO l_posY FROM dzfj_t
              WHERE dzfj001 = g_dzfi001 
                AND dzfj002 = g_dzfi002
                AND dzfj017 = g_dzfi009
                AND dzfj003 = p_dzfj_relative.dzfj003
         END IF

         #因為需保留label文字說明widget的距離,因此先計算參考點widget的posX是否足夠
         #label posX所用掉空間 = 上一個參考點最小posX + label 寬度 10 + 空白 1
         IF p_dzfj_relative.dzfj013 < (l_posX + 10 + 1) THEN
            LET l_dzfj013_ud = l_posX + 10 + 1
         ELSE
            LET l_dzfj013_ud = p_dzfj_relative.dzfj013
         END IF

         LET l_dzfj014_ud = l_posY

         #Container下的群組元件Y軸 > 新控件的Y軸, 往下位移(位移量為新控件的高度)
         UPDATE dzfj_t SET dzfj014 = (dzfj014 + p_dzfj016_ud)
           WHERE dzfj001 = g_dzfi001 
             AND dzfj002 = g_dzfi002
             AND dzfj017 = g_dzfi009
             AND dzfj003 IN (SELECT dzfi006 FROM dzfi_t
                               WHERE dzfi001 = g_dzfi001 
                                 AND dzfi002 = g_dzfi002
                                 AND dzfi009 = g_dzfi009
                                 AND dzfi004 = p_dzfi004)
             AND dzfj014 >= l_dzfj014_ud
             
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  SQLCA.sqlcode
            LET g_errparam.extend = "set_widget_pos(dzfj014+dzfj016)-upd DG:dzfj_t.", p_dzfi004 CLIPPED
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN FALSE, l_dzfj013_ud, l_dzfj014_ud
         END IF

      #WHEN "DG_N"   #往下已取得群組的參考點:在參考群組上一個序號加入一組全新的元件群組設計資料
      #   #取得Container下,上一個參考點群組的最小X軸數值(為新控件的X軸參考依據)
      #   SELECT MIN(dzfj013) INTO l_posX FROM dzfj_t
      #     WHERE dzfj001 = g_dzfi001 
      #       AND dzfj002 = g_dzfi002
      #       AND dzfj017 = g_dzfi009
      #       AND dzfj003 = p_dzfj_relative.dzfj003

      #   #取得上一個參考點群組的Y軸高度(理論上同一排widget的Y軸應該相同)
      #   SELECT DISTINCT dzfj014 INTO l_posY FROM dzfj_t
      #     WHERE dzfj001 = g_dzfi001 
      #       AND dzfj002 = g_dzfi002
      #       AND dzfj017 = g_dzfi009
      #       AND dzfj003 = p_dzfj_relative.dzfj003
             
      #   #因為需保留label文字說明widget的距離,因此先計算參考點widget的posX是否足夠
      #   #label posX所用掉空間 = 上一個參考點最小posX + label 寬度 10 + 空白 1
      #   IF p_dzfj_relative.dzfj013 < (l_posX + 10 + 1) THEN
      #      LET l_dzfj013_ud = l_posX + 10 + 1
      #   ELSE
      #      LET l_dzfj013_ud = p_dzfj_relative.dzfj013
      #   END IF

      #   LET l_dzfj014_ud = l_posY

      #   #Container下的群組元件Y軸 > 新控件的Y軸, 往下位移(位移量為新控件的高度)
      #   UPDATE dzfj_t SET dzfj014 = (dzfj014 + p_dzfj016_ud)
      #     WHERE dzfj001 = g_dzfi001 
      #       AND dzfj002 = g_dzfi002
      #       AND dzfj017 = g_dzfi009
      #       AND dzfj003 IN (SELECT dzfi006 FROM dzfi_t
      #                         WHERE dzfi001 = g_dzfi001 
      #                           AND dzfi002 = g_dzfi002
      #                           AND dzfi009 = g_dzfi009
      #                           AND dzfi004 = p_dzfi004)
      #       AND dzfj014 >= l_dzfj014_ud

      #   IF SQLCA.sqlcode THEN
      #      INITIALIZE g_errparam TO NULL
      #      LET g_errparam.code =  SQLCA.sqlcode
      #      LET g_errparam.extend = "set_widget_pos(dzfj014+dzfj016)-upd DG_N:dzfj_t.", p_dzfi004 CLIPPED
      #      LET g_errparam.popup = TRUE
      #      CALL cl_err()
      #      RETURN FALSE, l_dzfj013_ud, l_dzfj014_ud
      #   END IF

      OTHERWISE
      
   END CASE

   RETURN TRUE, l_dzfj013_ud, l_dzfj014_ud
END FUNCTION

#+ 在新增欄位時,widget前面需增加Static Label(敘述)
PRIVATE FUNCTION sadzp169_01_add_static_label(p_dzfi007, p_dzeb002, p_dzfj006, p_dzfj003, p_dzfj004, p_posX, p_posY, p_grid_width)
   DEFINE p_dzfi007      LIKE dzfi_t.dzfi007   #Container類型
   DEFINE p_dzeb002      LIKE dzeb_t.dzeb002   #自定義欄位代碼
   DEFINE p_dzfj006      LIKE dzfj_t.dzfj006   #控件樣式
   DEFINE p_dzfj003      LIKE dzfj_t.dzfj003   #Label元件所屬元件群組代碼
   DEFINE p_dzfj004      LIKE dzfj_t.dzfj004   #Label元件屬於元件群組的順序
   DEFINE p_posX         LIKE type_t.num10     #Label元件X軸位置
   DEFINE p_posY         LIKE type_t.num10     #Label元件Y軸位置
   DEFINE p_grid_width   LIKE type_t.num5

   DEFINE l_doc          om.DomDocument
   DEFINE l_node         om.DomNode            #新增欄位的子節點
   DEFINE l_grid_height  LIKE type_t.num5
   DEFINE l_name         STRING
   DEFINE l_widget       STRING
   
   INITIALIZE l_node TO NULL
   
   #如果widge是CheckBox, 則不在前面新增Label
   IF p_dzfj006 = "CheckBox" AND p_dzfi007 <> "ScrollGrid" THEN
      DISPLAY "p_dzfj006=CheckBox AND dzfj007=", p_dzfi007 CLIPPED
      RETURN TRUE, p_dzfj004
   END IF

   #Static Label(敘述):預設高為1,寬為10(除了ScrollGrid外,預設寬為10)
   LET l_grid_height = 1 
   IF cl_null(p_grid_width) OR p_grid_width = 0 THEN
      LET p_grid_width = 10
   END IF

   #在單頭裡新增欄位,需在這個欄位前方增加一個Label(敘述)控件,
   #目的為這個欄位的用途說明敘述
   LET l_widget = "Label"
   LET l_doc = om.DomDocument.create(l_widget)
   LET l_node = l_doc.getDocumentElement()
   
   #畫面多語言說明label代碼
   LET l_name = "lbl_", p_dzeb002 CLIPPED
   CALL l_node.setAttribute("name", l_name)
   CALL l_node.setAttribute("text", l_name)
   
   CALL l_node.setAttribute("gridHeight", l_grid_height)  
   CALL l_node.setAttribute("gridWidth", p_grid_width)

   CALL l_node.setAttribute("posX", p_posX)
   CALL l_node.setAttribute("posY", p_posY)
   
   CALL l_node.setAttribute("lstrcomment", "true")
   CALL l_node.setAttribute("lstrtext", "true")

   IF p_dzfi007 = "ScrollGrid" THEN
      CALL l_node.setAttribute("style", "scrollgridtype")
   END IF

   #新增widget設計資料
   IF NOT sadzp169_01_ins_dzfj(p_dzfj003, p_dzfj004, l_name, l_widget, p_posX, p_posY, p_grid_width, l_grid_height) THEN
      RETURN FALSE, p_dzfj004
   END IF

   #新增widget屬性資料
   IF NOT sadzp169_01_ins_dzfk(l_node) THEN
      RETURN FALSE, p_dzfj004
   END IF

   LET p_dzfj004 = p_dzfj004 + 1
   
   RETURN TRUE, p_dzfj004
END FUNCTION

#+ 新增自定義欄位widget
PRIVATE FUNCTION sadzp169_01_add_widget(p_dzfi007, p_field_info, p_dzfj003, p_dzfj004, p_posX, p_posY)
   DEFINE p_dzfi007            LIKE dzfi_t.dzfi007    #Container類型
   DEFINE p_field_info         type_g_field           #欄位設計資料
   DEFINE p_dzfj003            LIKE dzfj_t.dzfj003    #所屬元件群組代碼
   DEFINE p_dzfj004            LIKE dzfj_t.dzfj004    #widget屬於元件群組的順序
   #DEFINE p_dzfj_relative      type_g_dzfj            #參考控件(widget)設計資料
   #DEFINE p_dzfi_relative      type_g_dzfi            #參考控件所屬的畫面結構元件組合檔(dzfi_t)
   DEFINE p_posX               LIKE type_t.num10      #自定義控件X軸位置
   DEFINE p_posY               LIKE type_t.num10      #自定義控件Y軸位置
   
   
   DEFINE l_doc                om.DomDocument
   DEFINE l_node               om.DomNode            #container節點
   DEFINE l_new_child          om.DomNode            #新增欄位的子節點
   DEFINE l_grid_height        LIKE type_t.num5
   DEFINE l_grid_width         LIKE type_t.num5
   DEFINE l_name               STRING

   LET l_grid_height = 0
   LET l_grid_width = 0
   LET l_name = ""
   
   LET l_doc = om.DomDocument.create(p_dzfi007)
   LET l_node = l_doc.getDocumentElement()

   #新增自定義欄位子節點widget
   LET l_new_child = l_node.createChild(p_field_info.dzej003 CLIPPED) 
         
   #取得fieldId 和tabIndex 最大值
   CALL sadzp169_01_get_fieldId_tabIndex_max()

   IF cl_null(g_fieldId_max) OR g_fieldId_max = 0 OR cl_null(g_tabIndex_max) OR g_tabIndex_max = 0 THEN
      DISPLAY "g_fieldId_max(or g_tabIndex_max) is null."
   END IF
   
   #設定widget屬性資料
   CALL sadzp168_set_common_attr(p_field_info.*, l_new_child, g_table_column, p_field_info.dzej003, p_posX, p_posY)
      RETURNING l_grid_height, l_grid_width

   LET l_name = l_new_child.getAttribute("name") CLIPPED
   
   #新增widget設計資料
   IF NOT sadzp169_01_ins_dzfj(p_dzfj003, p_dzfj004, l_name, p_field_info.dzej003, p_posX, p_posY, l_grid_width, l_grid_height) THEN
      RETURN FALSE, l_name, l_grid_height, l_grid_width
   END IF

   #新增widget屬性資料
   IF NOT sadzp169_01_ins_dzfk(l_new_child) THEN
      RETURN FALSE, l_name, l_grid_height, l_grid_width
   END IF
   
   RETURN TRUE, l_name, l_grid_height, l_grid_width
END FUNCTION

#+ todo:取得DB設計資料裡目前所使用的 fieldid 和 tabIndex 最大值
PRIVATE FUNCTION sadzp169_01_get_fieldId_tabIndex_max()
   SELECT COUNT(*) INTO g_fieldId_max FROM dzfk_t
     WHERE dzfk001 = g_dzfi001 
       AND dzfk002 = g_dzfi002
       AND dzfk007 = g_dzfi009
       AND dzfk009 LIKE '% fieldId="%'
  
   SELECT COUNT(*) INTO g_tabIndex_max FROM dzfk_t
     WHERE dzfk001 = g_dzfi001 
       AND dzfk002 = g_dzfi002
       AND dzfk007 = g_dzfi009
       AND dzfk009 LIKE '% tabIndex="%'
END FUNCTION

#+ 在新增欄位時,widget後面增加reference欄位
PRIVATE FUNCTION sadzp169_01_add_reference(p_dzfi007, p_dzfj003, p_dzfj004, p_field_name, p_title, p_posX, p_posY, p_ref_width, p_ref_height)
   DEFINE p_dzfi007            LIKE dzfi_t.dzfi007   #Container類型
   DEFINE p_dzfj003            LIKE dzfj_t.dzfj003   #所屬元件群組代碼
   DEFINE p_dzfj004            LIKE dzfj_t.dzfj004   #widget屬於元件群組的順序
   DEFINE p_field_name         STRING                #欄位名稱
   DEFINE p_title              STRING                #欄位title屬性
   DEFINE p_posX               LIKE type_t.num10     #Label元件X軸位置
   DEFINE p_posY               LIKE type_t.num10     #Label元件Y軸位置
   DEFINE p_ref_width          LIKE type_t.num5
   DEFINE p_ref_height         LIKE type_t.num5

   DEFINE l_doc                om.DomDocument
   DEFINE l_node               om.DomNode            #container節點
   DEFINE l_new_child          om.DomNode            #新增欄位的子節點
   DEFINE l_dzfj006            LIKE dzfj_t.dzfj006
   DEFINE l_name               STRING                #FFLabel的name屬性值
   
   LET l_name = p_field_name CLIPPED, "_desc"
   
   #增加欄位FFLabel只會用到fieldId,因此將值加1
   LET g_fieldId_max = g_fieldId_max + 1

   LET l_doc = om.DomDocument.create(p_dzfi007)
   LET l_node = l_doc.getDocumentElement()

   #當主要欄位需要有參考欄位輔助說明時,需增加FFLabel
   #exp:[地區別] [地區別名稱]
   LET l_dzfj006 = "FFLabel"
   LET l_new_child = l_node.createChild(l_dzfj006)

   CALL l_new_child.setAttribute("aggregateColName", "")
   CALL l_new_child.setAttribute("aggregateName", "")
   CALL l_new_child.setAttribute("aggregateTableAliasName", "")
   CALL l_new_child.setAttribute("aggregateTableName", "")
   CALL l_new_child.setAttribute("colName", "")
   CALL l_new_child.setAttribute("columnCount", "")
   CALL l_new_child.setAttribute("fieldId", g_fieldId_max) 

   CALL l_new_child.setAttribute("fieldType", "NON_DATABASE")
   CALL l_new_child.setAttribute("name", l_name.trim())

   CALL l_new_child.setAttribute("gridHeight", p_ref_height)  
   CALL l_new_child.setAttribute("gridWidth", p_ref_width)

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

   IF p_dzfi007 = "Table" OR p_dzfi007 = "Tree" THEN
      CALL l_new_child.setAttribute("title", "lbl_" || p_title.trim())
   END IF

   #新增widget設計資料
   IF NOT sadzp169_01_ins_dzfj(p_dzfj003, p_dzfj004, l_name, l_dzfj006, p_posX, p_posY, p_ref_width, p_ref_height) THEN
      RETURN FALSE, l_name
   END IF

   #新增widget屬性資料
   IF NOT sadzp169_01_ins_dzfk(l_new_child) THEN
      RETURN FALSE, l_name
   END IF
   
   RETURN TRUE, l_name
END FUNCTION

#+ 在新增欄位時,widget增加多語言欄位
PRIVATE FUNCTION sadzp169_01_add_lang(p_dzfi007, p_dzfj003, p_dzfj004, p_table_name, p_field_name, p_posX, p_posY, p_lang_width, p_lang_height)
   DEFINE p_dzfi007            LIKE dzfi_t.dzfi007   #Container類型
   DEFINE p_dzfj003            LIKE dzfj_t.dzfj003   #所屬元件群組代碼
   DEFINE p_dzfj004            LIKE dzfj_t.dzfj004   #widget屬於元件群組的順序
   DEFINE p_table_name         STRING                #資料表名稱
   DEFINE p_field_name         STRING                #欄位名稱
   DEFINE p_posX               LIKE type_t.num10     #Label元件X軸位置
   DEFINE p_posY               LIKE type_t.num10     #Label元件Y軸位置
   DEFINE p_lang_width         LIKE type_t.num5
   DEFINE p_lang_height        LIKE type_t.num5

   DEFINE l_doc                om.DomDocument
   DEFINE l_node               om.DomNode            #container節點
   DEFINE l_dzfj006            LIKE dzfj_t.dzfj006
   DEFINE l_new_child          om.DomNode            #新增欄位的子節點
   DEFINE l_name               STRING                #FFLabel的name屬性值
   
   LET l_name = p_table_name.trim(), ".", p_field_name.trim()
   
   #增加多語言欄位(ButtonEdit) fieldId和tabIndex都要依續加1
   LET g_fieldId_max = g_fieldId_max + 1
   LET g_tabIndex_max = g_tabIndex_max + 1
   
   LET l_doc = om.DomDocument.create(p_dzfi007)
   LET l_node = l_doc.getDocumentElement()

   #當主要欄位需要有多語言欄位資料編輯時,需增加ButtonEdit
   #exp:[料件編號] [品名]
   LET l_dzfj006 = "ButtonEdit"
   LET l_new_child = l_node.createChild(l_dzfj006)

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

   CALL l_new_child.setAttribute("gridHeight", p_lang_height)  
   CALL l_new_child.setAttribute("gridWidth", p_lang_width)

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
   IF p_dzfi007 = "Table" OR p_dzfi007 = "Tree" THEN
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
   
   #新增widget設計資料
   IF NOT sadzp169_01_ins_dzfj(p_dzfj003, p_dzfj004, l_name, l_dzfj006, p_posX, p_posY, p_lang_width, p_lang_height) THEN
      RETURN FALSE, l_name
   END IF

   #新增widget屬性資料
   IF NOT sadzp169_01_ins_dzfk(l_new_child) THEN
      RETURN FALSE, l_name
   END IF
   
   RETURN TRUE, l_name
END FUNCTION










#+ 將自定義欄位資料新增到tsd table中
PRIVATE FUNCTION sadzp169_01_insert_tsd(p_dzfi004, p_dzfi007, p_dzaa003, p_field)
   DEFINE p_dzfi004           LIKE dzfi_t.dzfi004     #自定義欄位所屬container代碼
   DEFINE p_dzfi007           LIKE dzfi_t.dzfi007     #自定義欄位所屬container類型
   DEFINE p_dzaa003           LIKE dzaa_t.dzaa003     #識別碼(widget name)
   DEFINE p_field             type_g_field            #欄位設計資料
   
   DEFINE l_cnt               LIKE type_t.num10
   DEFINE l_dzaa              RECORD LIKE dzaa_t.*    #規格與內容版本對應表
   DEFINE l_dzac              RECORD LIKE dzac_t.*    #欄位規格設計表
   DEFINE l_str               base.StringBuffer
   DEFINE l_dzep025           LIKE dzep_t.dzep025     #最大值比較符號
   DEFINE l_dzep026           LIKE dzep_t.dzep026     #最小值比較符號
   
   #檢查相符合設計點資料是否存在
   SELECT COUNT(*) INTO l_cnt FROM dzaa_t 
     WHERE dzaa001 = g_dzfi001
       AND dzaa002 = g_dzfi002
       AND dzaa009 = g_dzfi009

   IF l_cnt = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = "adz-00417"
      LET g_errparam.extend = NULL
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = g_dzfi001 CLIPPED 
      LET g_errparam.replace[2] = g_dzfi002 USING "<<<<<" 
      CALL cl_err()
      RETURN FALSE
   END IF

   #LET l_dzaa006 = g_dzfi009
   #LET l_dzaa007 = "N"
   #LET l_dzaa008 = FGL_GETENV("ERPVER")       #產品版本
   #LET l_dzaa009 = g_dzfi009                  #識別標示
   #LET l_dzaa010 = g_dzfi017                  #客戶代號

   ###設計點類型:1(規格與內容版本對應表)###
   LET l_dzaa.dzaa001 = g_dzfi001             #規格代號
   LET l_dzaa.dzaa002 = g_dzfi002             #規格版次
   LET l_dzaa.dzaa003 = p_dzaa003             #控件編號
   LET l_dzaa.dzaa004 = g_dzfi002             #識別碼版次
   LET l_dzaa.dzaa005 = "1"                   #設計點類型
   LET l_dzaa.dzaa006 = g_dzfi009             #使用標示
   LET l_dzaa.dzaa007 = "N"                   #規格引用否
   LET l_dzaa.dzaa008 = FGL_GETENV("ERPVER")  #產品版本
   LET l_dzaa.dzaa009 = g_dzfi009             #識別標示
   LET l_dzaa.dzaa010 = g_dzfi017             #客戶代號
   LET l_dzaa.dzaamodid = g_user
   LET l_dzaa.dzaamoddt = cl_get_current()
   LET l_dzaa.dzaaownid = g_user
   LET l_dzaa.dzaaowndp = g_dept
   LET l_dzaa.dzaacrtid = g_user
   LET l_dzaa.dzaacrtdp = g_dept
   LET l_dzaa.dzaacrtdt = cl_get_current()
   LET l_dzaa.dzaastus = "Y"

   #相關規格已存在時,不再insert資源池規格資料
   IF sadzp169_01_chk_dzaa(l_dzaa.dzaa003) THEN
      INSERT INTO dzaa_t (dzaa001, dzaa002, dzaa003, dzaa004, dzaa005,
                          dzaa006, dzaa007, dzaa008, dzaa009, dzaa010, 
                          dzaamodid, dzaamoddt, dzaaownid, dzaaowndp, dzaacrtid, dzaacrtdp,
                          dzaacrtdt, dzaastus)
        VALUES(l_dzaa.dzaa001, l_dzaa.dzaa002, l_dzaa.dzaa003, l_dzaa.dzaa004, l_dzaa.dzaa005, 
               l_dzaa.dzaa006, l_dzaa.dzaa007, l_dzaa.dzaa008, l_dzaa.dzaa009, l_dzaa.dzaa010, 
               l_dzaa.dzaamodid, l_dzaa.dzaamoddt, l_dzaa.dzaaownid, l_dzaa.dzaaowndp, l_dzaa.dzaacrtid, l_dzaa.dzaacrtdp, 
               l_dzaa.dzaacrtdt, l_dzaa.dzaastus)
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ins1 dzaa_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN FALSE
      END IF
      
      #檢查相符合欄位規格設計資料是否已存在
      SELECT COUNT(*) INTO l_cnt FROM dzac_t 
        WHERE dzac001 = l_dzaa.dzaa001
          AND dzac003 = l_dzaa.dzaa003
          AND dzac004 = l_dzaa.dzaa004
          AND dzac012 = l_dzaa.dzaa006
      
      IF l_cnt > 0 THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = "adz-00418"
         LET g_errparam.extend = NULL
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] = l_dzaa.dzaa003 CLIPPED 
         LET g_errparam.replace[2] = l_dzaa.dzaa004 USING "<<<<<" 
         CALL cl_err()
         RETURN FALSE
      END IF
      
      #取得自定義欄位相關規格設定
      SELECT '', dzeb002, '', '', dzeb001, 
             '', '', dzeb005, dzep017, dzep018, 
             dzep019, '', '', dzep012, dzep025,
             dzep013, dzep026, dzep014, '', '',
             '', ''
        INTO l_dzac.dzac001, l_dzac.dzac002, l_dzac.dzac003, l_dzac.dzac004, l_dzac.dzac005,
             l_dzac.dzac006, l_dzac.dzac007, l_dzac.dzac008, l_dzac.dzac009, l_dzac.dzac010,
             l_dzac.dzac011, l_dzac.dzac012, l_dzac.dzac013, l_dzac.dzac014, l_dzep025,
             l_dzac.dzac015, l_dzep026, l_dzac.dzac016, l_dzac.dzac017, l_dzac.dzac018, 
             l_dzac.dzac019, l_dzac.dzac020
        FROM dzeb_t LEFT JOIN dzep_t ON dzeb001 = dzep001 AND dzeb002 = dzep002  
        WHERE dzeb001 = p_field.sqlTabName
          AND dzeb002 = p_field.colName
      
      LET l_dzac.dzac001 = l_dzaa.dzaa001
      LET l_dzac.dzac003 = l_dzaa.dzaa003
      LET l_dzac.dzac004 = l_dzaa.dzaa004
      LET l_dzac.dzac012 = l_dzaa.dzaa006
      LET l_dzac.dzac020 = ""                #no use
      LET l_dzac.dzac021 = ""                #no use

      #編輯時開窗
      IF NOT cl_null(g_udset.dzca001_i) THEN
         LET l_dzac.dzac009 = g_udset.dzca001_i CLIPPED
      END IF
      
      #查詢時開窗
      IF NOT cl_null(g_udset.dzca001_c) THEN
         LET l_dzac.dzac010 = g_udset.dzca001_c CLIPPED
      END IF
      
      #校驗帶值設定
      IF NOT cl_null(g_udset.dzcd001) THEN
         LET l_dzac.dzac011 = g_udset.dzcd001 CLIPPED
      END IF
      
      #必要欄位
      IF cl_null(l_dzac.dzac008) THEN
         LET l_dzac.dzac008 = "N"
      END IF
      
      #客戶代號 
      LET l_dzac.dzac013 = l_dzaa.dzaa010
      
      #是否可編輯,是否可查詢
      LET l_dzac.dzac017 = "Y"
      LET l_dzac.dzac018 = "Y"

      #可否編輯和查詢,需視同一container下的規格中其他欄位是否也有不可編輯的情況(產生4gl時會只產生display array)
      CASE p_dzfi007
         WHEN "Table"
            SELECT COUNT(*) INTO l_cnt
              FROM dzac_t INNER JOIN dzaa_t ON dzac001 = dzaa001 AND dzac004 = dzaa004 AND dzac012 = dzaa006 AND dzac003 = dzaa003 
                          INNER JOIN dzfj_t ON dzaa001 = dzfj001 AND dzaa002 = dzfj002 AND dzaa009 = dzfj017 AND dzaa005 = '1' AND dzaa003 = dzfj005
                          INNER JOIN dzfi_t ON dzfj001 = dzfi001 AND dzfj002 = dzfi002 AND dzfj017 = dzfi009 AND dzfj003 = dzfi006
              WHERE dzfi001 = g_dzfi001 AND dzfi002 = g_dzfi002 AND dzfi009 = g_dzfi009 AND dzfi004 = p_dzfi004 AND dzac017 = 'Y'
              
            IF l_cnt = 0 THEN
               LET l_dzac.dzac017 = "N" 
            END IF

            SELECT COUNT(*) INTO l_cnt
              FROM dzac_t INNER JOIN dzaa_t ON dzac001 = dzaa001 AND dzac004 = dzaa004 AND dzac012 = dzaa006 AND dzac003 = dzaa003 
                          INNER JOIN dzfj_t ON dzaa001 = dzfj001 AND dzaa002 = dzfj002 AND dzaa009 = dzfj017 AND dzaa005 = '1' AND dzaa003 = dzfj005
                          INNER JOIN dzfi_t ON dzfj001 = dzfi001 AND dzfj002 = dzfi002 AND dzfj017 = dzfi009 AND dzfj003 = dzfi006
              WHERE dzfi001 = g_dzfi001 AND dzfi002 = g_dzfi002 AND dzfi009 = g_dzfi009 AND dzfi004 = p_dzfi004 AND dzac018 = 'Y'
              
            IF l_cnt = 0 THEN
               LET l_dzac.dzac018 = "N" 
            END IF

         WHEN "Tree"
            LET l_dzac.dzac017 = "N" 
            LET l_dzac.dzac018 = "N" 

      END CASE
      
      #欄位4fd上顯示控件
      LET l_dzac.dzac019 = p_field.dzej003 CLIPPED
      
      IF l_dzac.dzac007[1,4] = "date" OR l_dzac.dzac007[1,4] = "blob" OR 
         l_dzac.dzac007[1,4] = "clob" OR l_dzac.dzac007 = "()" OR l_dzac.dzac007 = "( )" THEN
         CALL l_str.clear()
         CALL l_str.append(l_dzac.dzac007 CLIPPED)
         CALL l_str.replace("(", "", 1)
         CALL l_str.replace(")", "", 1)
         CALL l_str.replace(" ", "", 1)
         LET l_dzac.dzac007 = l_str.toString()
      END IF
      
      #最大值,最小值加入邊界值符號
      IF NOT cl_null(l_dzep025) THEN
         LET l_dzac.dzac015 = l_dzep025 CLIPPED, ",", l_dzac.dzac015 CLIPPED
      END IF
      IF NOT cl_null(l_dzep026) THEN
         LET l_dzac.dzac016 = l_dzep026 CLIPPED, ",", l_dzac.dzac016 CLIPPED
      END IF
      
      LET l_dzac.dzacmodid = g_user
      LET l_dzac.dzacmoddt = cl_get_current()
      LET l_dzac.dzacownid = g_user
      LET l_dzac.dzacowndp = g_dept
      LET l_dzac.dzaccrtid = g_user
      LET l_dzac.dzaccrtdp = g_dept
      LET l_dzac.dzaccrtdt = cl_get_current()
      LET l_dzac.dzacstus = "Y"
      
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
                l_dzac.dzacmodid, l_dzac.dzacmoddt, l_dzac.dzacownid, l_dzac.dzacowndp, l_dzac.dzaccrtid, 
                l_dzac.dzaccrtdp, l_dzac.dzaccrtdt, l_dzac.dzacstus)
      
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  SQLCA.sqlcode
         LET g_errparam.extend = "ins dzac_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF
   
   #欄位相關的參考欄位, 資料多語言, 助記碼,串查等設定寫入tsd中
   IF NOT sadzp169_01_insert_field_spec_tsd(p_field.*, l_dzac.dzac003) THEN
      RETURN FALSE
   END IF
                   
   RETURN TRUE
END FUNCTION

#+ 檢查相關規格內容是否已存在
PRIVATE FUNCTION sadzp169_01_chk_dzaa(p_dzaa003)
   DEFINE p_dzaa003           LIKE dzaa_t.dzaa003   #規格識別碼
   DEFINE l_cnt               LIKE type_t.num5
   
   #檢查相符合設計點資料是否存在
   SELECT COUNT(*) INTO l_cnt FROM dzaa_t 
     WHERE dzaa001 = g_dzfi001
       AND dzaa002 = g_dzfi002
       AND dzaa009 = g_dzfi009
       AND dzaa003 = p_dzaa003

   IF l_cnt > 0 THEN
      DISPLAY p_dzaa003 CLIPPED, " already exists." 
      RETURN FALSE
   END IF
           
   RETURN TRUE
END FUNCTION

#+ 欄位相關的參考欄位, 資料多語言, 助記碼等設定寫入tsd中
PRIVATE FUNCTION sadzp169_01_insert_field_spec_tsd(p_field, p_dzac003)
   DEFINE p_field             type_g_field          #欄位設計資料
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
   
   ###設計點類型:6(欄位參考設計表)###
   IF NOT cl_null(p_field.refField) AND p_field.dzai002 IS NOT NULL THEN
      LET l_dzaa.dzaa001 = g_dzfi001                      #規格代號
      LET l_dzaa.dzaa002 = g_dzfi002                      #規格版次
      LET l_dzaa.dzaa003 = p_field.dzai002.toString()     #參考欄位的控件名稱
      LET l_dzaa.dzaa004 = g_dzfi002                      #識別碼版次
      LET l_dzaa.dzaa005 = "6"                            #設計點類型
      LET l_dzaa.dzaa006 = g_dzfi009                      #使用標示
      LET l_dzaa.dzaa007 = "N"                            #規格引用否
      LET l_dzaa.dzaa008 = FGL_GETENV("ERPVER")           #產品版本
      LET l_dzaa.dzaa009 = g_dzfi009                      #識別標示
      LET l_dzaa.dzaa010 = g_dzfi017                      #客戶代號
      LET l_dzaa.dzaamodid = g_user
      LET l_dzaa.dzaamoddt = cl_get_current()
      LET l_dzaa.dzaaownid = g_user
      LET l_dzaa.dzaaowndp = g_dept
      LET l_dzaa.dzaacrtid = g_user
      LET l_dzaa.dzaacrtdp = g_dept
      LET l_dzaa.dzaacrtdt = cl_get_current()
      LET l_dzaa.dzaastus = "Y"
   
      #相關規格已存在時,不再insert資源池規格資料
      IF sadzp169_01_chk_dzaa(l_dzaa.dzaa003) THEN
         INSERT INTO dzaa_t (dzaa001, dzaa002, dzaa003, dzaa004, dzaa005,
                             dzaa006, dzaa007, dzaa008, dzaa009, dzaa010, 
                             dzaamodid, dzaamoddt, dzaaownid, dzaaowndp, dzaacrtid, dzaacrtdp,
                             dzaacrtdt, dzaastus)
           VALUES(l_dzaa.dzaa001, l_dzaa.dzaa002, l_dzaa.dzaa003, l_dzaa.dzaa004, l_dzaa.dzaa005, 
                  l_dzaa.dzaa006, l_dzaa.dzaa007, l_dzaa.dzaa008, l_dzaa.dzaa009, l_dzaa.dzaa010, 
                  l_dzaa.dzaamodid, l_dzaa.dzaamoddt, l_dzaa.dzaaownid, l_dzaa.dzaaowndp, l_dzaa.dzaacrtid, l_dzaa.dzaacrtdp, 
                  l_dzaa.dzaacrtdt, l_dzaa.dzaastus)
         
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  SQLCA.sqlcode
            LET g_errparam.extend = "ins6 dzaa_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
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

            LET l_dzai.dzaimodid = g_user
            LET l_dzai.dzaimoddt = cl_get_current()
            LET l_dzai.dzaiownid = g_user
            LET l_dzai.dzaiowndp = g_dept
            LET l_dzai.dzaicrtid = g_user
            LET l_dzai.dzaicrtdp = g_dept
            LET l_dzai.dzaicrtdt = cl_get_current()
            LET l_dzai.dzaistus = "Y"

            INSERT INTO dzai_t(dzai001, dzai002, dzai003, dzai004, dzai005,
                               dzai007, dzai008, dzai009, dzai010, dzai011,
                               dzai012, 
                               dzaimodid, dzaimoddt, dzaiownid, dzaiowndp, dzaicrtid,
                               dzaicrtdp, dzaicrtdt, dzaistus)
              VALUES (l_dzai.dzai001, l_dzai.dzai002, l_dzai.dzai003, l_dzai.dzai004, l_dzai.dzai005,
                      l_dzai.dzai007, l_dzai.dzai008, l_dzai.dzai009, l_dzai.dzai010, l_dzai.dzai011, 
                      l_dzai.dzai012, 
                      l_dzai.dzaimodid, l_dzai.dzaimoddt, l_dzai.dzaiownid, l_dzai.dzaiowndp, l_dzai.dzaicrtid, 
                      l_dzai.dzaicrtdp, l_dzai.dzaicrtdt, l_dzai.dzaistus)
         END IF
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  SQLCA.sqlcode
            LET g_errparam.extend = "ins dzai_t "
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN FALSE
         END IF
      END IF
   END IF

   ###設計點類型:7(欄位資料多語言設計表)###
   IF NOT cl_null(p_field.langField) AND p_field.dzaj002 IS NOT NULL THEN
      LET l_dzaa.dzaa001 = g_dzfi001                      #規格代號
      LET l_dzaa.dzaa002 = g_dzfi002                      #規格版次
      LET l_dzaa.dzaa003 = p_field.dzaj002.toString()     #多語言欄位的控件名稱
      LET l_dzaa.dzaa004 = g_dzfi002                      #識別碼版次
      LET l_dzaa.dzaa005 = "7"                            #設計點類型
      LET l_dzaa.dzaa006 = g_dzfi009                      #使用標示
      LET l_dzaa.dzaa007 = "N"                            #規格引用否
      LET l_dzaa.dzaa008 = FGL_GETENV("ERPVER")           #產品版本
      LET l_dzaa.dzaa009 = g_dzfi009                      #識別標示
      LET l_dzaa.dzaa010 = g_dzfi017                      #客戶代號
      LET l_dzaa.dzaamodid = g_user
      LET l_dzaa.dzaamoddt = cl_get_current()
      LET l_dzaa.dzaaownid = g_user
      LET l_dzaa.dzaaowndp = g_dept
      LET l_dzaa.dzaacrtid = g_user
      LET l_dzaa.dzaacrtdp = g_dept
      LET l_dzaa.dzaacrtdt = cl_get_current()
      LET l_dzaa.dzaastus = "Y"
      
      #相關規格已存在時,不再insert資源池規格資料
      IF sadzp169_01_chk_dzaa(l_dzaa.dzaa003) THEN
         INSERT INTO dzaa_t (dzaa001, dzaa002, dzaa003, dzaa004, dzaa005,
                             dzaa006, dzaa007, dzaa008, dzaa009, dzaa010, 
                             dzaamodid, dzaamoddt, dzaaownid, dzaaowndp, dzaacrtid, dzaacrtdp,
                             dzaacrtdt, dzaastus)
           VALUES(l_dzaa.dzaa001, l_dzaa.dzaa002, l_dzaa.dzaa003, l_dzaa.dzaa004, l_dzaa.dzaa005, 
                  l_dzaa.dzaa006, l_dzaa.dzaa007, l_dzaa.dzaa008, l_dzaa.dzaa009, l_dzaa.dzaa010, 
                  l_dzaa.dzaamodid, l_dzaa.dzaamoddt, l_dzaa.dzaaownid, l_dzaa.dzaaowndp, l_dzaa.dzaacrtid, l_dzaa.dzaacrtdp, 
                  l_dzaa.dzaacrtdt, l_dzaa.dzaastus)
         
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  SQLCA.sqlcode
            LET g_errparam.extend = "ins7 dzaa_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
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
            
            LET l_dzaj.dzajmodid = g_user
            LET l_dzaj.dzajmoddt = cl_get_current()
            LET l_dzaj.dzajownid = g_user
            LET l_dzaj.dzajowndp = g_dept
            LET l_dzaj.dzajcrtid = g_user
            LET l_dzaj.dzajcrtdp = g_dept
            LET l_dzaj.dzajcrtdt = cl_get_current()
            LET l_dzaj.dzajstus = "Y"

            INSERT INTO dzaj_t(dzaj001, dzaj002, dzaj003, dzaj004, dzaj005,
                               dzaj007, dzaj008, dzaj009, dzaj010, dzaj011, 
                               dzaj012, 
                               dzajmodid, dzajmoddt, dzajownid, dzajowndp, dzajcrtid,
                               dzajcrtdp, dzajcrtdt, dzajstus)
              VALUES (l_dzaj.dzaj001, l_dzaj.dzaj002, l_dzaj.dzaj003, l_dzaj.dzaj004, l_dzaj.dzaj005,
                      l_dzaj.dzaj007, l_dzaj.dzaj008, l_dzaj.dzaj009, l_dzaj.dzaj010, l_dzaj.dzaj011, 
                      l_dzaj.dzaj012, 
                      l_dzaj.dzajmodid, l_dzaj.dzajmoddt, l_dzaj.dzajownid, l_dzaj.dzajowndp, l_dzaj.dzajcrtid, 
                      l_dzaj.dzajcrtdp, l_dzaj.dzajcrtdt, l_dzaj.dzajstus) 
         END IF
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  SQLCA.sqlcode
            LET g_errparam.extend = "ins dzaj_t "
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN FALSE
         END IF
      END IF
   END IF
         
   ###設計點類型:8(助記碼設定檔)###
   IF NOT cl_null(p_field.mnemField) THEN       
      LET l_dzak.dzak001 = g_dzfi001               #規格代號
      LET l_dzak.dzak002 = p_dzac003               #控件編號
      LET l_dzak.dzak003 = g_dzfi002               #識別碼版次
      LET l_dzak.dzak004 = g_dzfi009               #使用標示

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

         LET l_dzak.dzak005 = l_dzet.dzet007              #其他條件
         LET l_dzak.dzak007 = l_dzet.dzet004              #助記碼搜尋欄位
         LET l_dzak.dzak008 = l_dzet.dzet003              #助記碼Table
         LET l_dzak.dzak009 = l_dzet.dzet005              #助記碼欄位
         LET l_dzak.dzak010 = l_dzet.dzet006              #助記碼語系
         LET l_dzak.dzak011 = ""                          #回傳對應控件
         LET l_dzak.dzak012 = g_dzfi017                   #客戶代號
         
         LET l_dzak.dzakmodid = g_user
         LET l_dzak.dzakmoddt = cl_get_current()
         LET l_dzak.dzakownid = g_user
         LET l_dzak.dzakowndp = g_dept
         LET l_dzak.dzakcrtid = g_user
         LET l_dzak.dzakcrtdp = g_dept
         LET l_dzak.dzakcrtdt = cl_get_current()
         LET l_dzak.dzakstus = "Y"

         INSERT INTO dzak_t(dzak001, dzak002, dzak003, dzak004, dzak005,
                            dzak007, dzak008, dzak009, dzak010, dzak011, 
                            dzak012, 
                            dzakmodid, dzakmoddt, dzakownid, dzakowndp, dzakcrtid,
                            dzakcrtdp, dzakcrtdt, dzakstus)
           VALUES (l_dzak.dzak001, l_dzak.dzak002, l_dzak.dzak003, l_dzak.dzak004, l_dzak.dzak005,
                   l_dzak.dzak007, l_dzak.dzak008, l_dzak.dzak009, l_dzak.dzak010, l_dzak.dzak011, 
                   l_dzak.dzak012, 
                   l_dzak.dzakmodid, l_dzak.dzakmoddt, l_dzak.dzakownid, l_dzak.dzakowndp, l_dzak.dzakcrtid, 
                   l_dzak.dzakcrtdp, l_dzak.dzakcrtdt, l_dzak.dzakstus)  
      END IF
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  SQLCA.sqlcode
         LET g_errparam.extend = "ins dzak_t "
         LET g_errparam.popup = TRUE
         CALL cl_err()
         RETURN FALSE
      END IF
   END IF

   RETURN TRUE
END FUNCTION

