#該程式已解開Section, 不再透過樣板產出!
{<section id="azzp110.description" >}
#+ Version..: T100-ERP-1.00.00(SD版次:1,PD版次:1) Build-000020
#+ 
#+ Filename...: azzp110
#+ Description: 補入多語言資料批次作業
#+ Creator....: 01856(2014/06/05)
#+ Modifier...: (1899/12/31)
#+ Buildtype..: 應用 p01 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="azzp110.global" >}
#160818-00012 #1 2016/08/18 By jrg542 修正從字典檔匯入語言表漏掉的問題
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_schedule
#add-point:增加匯入項目
IMPORT security
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_schedule.inc"
GLOBALS
   DEFINE gwin_curr2  ui.Window
   DEFINE gfrm_curr2  ui.Form
   DEFINE gi_hiden_asign       LIKE type_t.num5
   DEFINE gi_hiden_exec        LIKE type_t.num5
   DEFINE gi_hiden_spec        LIKE type_t.num5
   DEFINE gi_hiden_exec_end    LIKE type_t.num5
END GLOBALS
 
PRIVATE TYPE type_parameter RECORD
   #add-point:自定背景執行須傳遞的參數(Module Variable)
        action_type      LIKE type_t.chr10,
        trans_all        LIKE type_t.chr1,
        table_name       STRING,
        log_name         STRING,
        docno            LIKE type_t.chr20,
        seq              LIKE type_t.num5,
        extra_condition  STRING,
   #end add-point
        wc               STRING
                     END RECORD
 
DEFINE g_sql             STRING        #組 sql 用
DEFINE g_forupd_sql      STRING        #SELECT ... FOR UPDATE  SQL
DEFINE g_error_show      LIKE type_t.num5
DEFINE g_jobid           STRING
 
#add-point:自定義模組變數(Module Variable)
GLOBALS
   DEFINE g_gen_ch    base.Channel
   DEFINE g_err_code   RECORD
            code      LIKE gzze_t.gzze001,         #錯誤訊息編碼
            extend    STRING,                      #出現在開頭的延伸訊息字串 (有需要再設定)
            popup     BOOLEAN,                     #開窗否（azzi920強制開窗時無作用）
            type      LIKE gzze_t.gzze007,         #訊息類型0:警告, 1:錯誤, 2:資訊（可不設, 依照azzi920預設值)
            replace   DYNAMIC ARRAY OF STRING,     #替換錯誤訊息及建議處理方式中的%變數 (有需要再設定)
            columns   DYNAMIC ARRAY OF STRING,     #欄位清單(對照欄位值清單) (有需要再設定)
            values    DYNAMIC ARRAY OF STRING,     #欄位值清單(對照欄位清單) (有需要再設定)
            coll_vals DYNAMIC ARRAY OF STRING,     #匯總訊息額外欄位 - 值 (有需要再設定)
            sqlerr    LIKE type_t.num5,            #SQLCA.SQLERRD[2] 或 SQLCA.SQLCODE (有需要再設定，0則不顯示)
            exeprog   LIKE type_t.chr20,           #建議執行作業編號 (有需要再設定)
            param     STRING                       #JSON格式的參數  (有需要再設定)
            END RECORD
   DEFINE g_chk_status  BOOLEAN
   CONSTANT lc_max_rows = 10000     #紀錄每張過單單號+項次最多可以過幾筆資料
END GLOBALS

DEFINE gs_count       LIKE type_t.num10
DEFINE gs_trans_temp  LIKE type_t.chr1
DEFINE ma_gzzy DYNAMIC ARRAY OF RECORD
          gzzy001 LIKE gzzy_t.gzzy001,
          gzozcol LIKE type_t.chr10
               END RECORD
DEFINE mi_enable_cursor LIKE type_t.num5
DEFINE g_param          type_parameter
DEFINE g_arr_table_name DYNAMIC ARRAY OF STRING
DEFINE g_imp_table_name DYNAMIC ARRAY OF STRING
DEFINE g_exp_table_name DYNAMIC ARRAY OF STRING
DEFINE g_set_up_m RECORD 
   dzeal_set_up LIKE type_t.chr1,
   dzebl_set_up LIKE type_t.chr1,
   gzzal_set_up LIKE type_t.chr1,
   gzzd_set_up  LIKE type_t.chr1,
   gzdfl_set_up LIKE type_t.chr1,
   gzzq_set_up  LIKE type_t.chr1,
   gzswl_set_up LIKE type_t.chr1,
   gzsxl_set_up LIKE type_t.chr1,
   gzszl_set_up LIKE type_t.chr1,
   gzwel_set_up LIKE type_t.chr1,
   gzcal_set_up LIKE type_t.chr1,
   gzcbl_set_up LIKE type_t.chr1,
   gzgdl_set_up LIKE type_t.chr1,
   gzge_set_up  LIKE type_t.chr1,
   dzcal_set_up LIKE type_t.chr1,
   dzcbl_set_up LIKE type_t.chr1,
   dzcdl_set_up LIKE type_t.chr1,
   dzcel_set_up LIKE type_t.chr1,
   gzdel_set_up LIKE type_t.chr1,
   gzhal_set_up LIKE type_t.chr1,
   gzial_set_up LIKE type_t.chr1,
   gzidl_set_up LIKE type_t.chr1,
   gzjal_set_up LIKE type_t.chr1,
   gztdl_set_up LIKE type_t.chr1,
   gztel_set_up LIKE type_t.chr1,
   gzzol_set_up LIKE type_t.chr1,
   gzzf_set_up  LIKE type_t.chr1,
   wscal_set_up LIKE type_t.chr1,
   wsebl_set_up LIKE type_t.chr1,
   wsecl_set_up LIKE type_t.chr1,
   gzgjl_set_up LIKE type_t.chr1,
   gzahl_set_up LIKE type_t.chr1,
   gzgp_set_up  LIKE type_t.chr1,
   rpdel_set_up LIKE type_t.chr1,
   rpzzl_set_up LIKE type_t.chr1
END RECORD 
#end add-point
 
#add-point:傳入參數說明

#end add-point
 
{</section>}
 
{<section id="azzp110.main" >}
MAIN
   DEFINE ls_js    STRING
   DEFINE lc_param type_parameter  
   DEFINE ls_target   STRING
   DEFINE ls_temp     STRING
   #add-point:main段define
   DEFINE ls_sql_gzos    STRING
   DEFINE ls_cnt         LIKE type_t.num5
   DEFINE ls_table_cnt   LIKE type_t.num5
   DEFINE lc_action      STRING
   #end add-point 
  
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
   LET g_bgjob = "Y"
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("azz","")
 
   #add-point:定義背景狀態與整理進入需用參數ls_js
   LET mi_enable_cursor = FALSE
   LET g_chk_status = TRUE
   
   #確認多語言暫存檔是否有資料
   LET gs_count = 0
   LET gs_trans_temp = "N"
   SELECT COUNT(1) INTO gs_count FROM gzos_t WHERE gzos001 = "zh_TW"
   IF gs_count > 0 THEN
      LET gs_trans_temp = "Y"
      
      #多語言暫存檔找出該語言別資料
      LET ls_sql_gzos = "SELECT gzos003 FROM gzos_t ",
                        " WHERE gzos001 = 'zh_TW' AND gzos002 = ?"
      
      PREPARE azzp110_get_gzos_cs FROM ls_sql_gzos
   END IF
   
   IF g_bgjob = "Y" THEN
      #排程參數由01開始，若不是1開始，表示有保留參數
   #   LET ls_js = g_argv[01]
   #   CALL util.JSON.parse(ls_js,g_param)
      
      LET g_param.action_type = g_argv[01]      #執行動作 (chk/imp/exp)  *必填*
      LET g_param.trans_all = g_argv[02]        #是否所有多語言table都做 (Y/N)  *必填*
      LET g_param.table_name = g_argv[03]       #要執行的多語言table  *必填*
      LET g_param.log_name = g_argv[04]         #log檔名稱  *必填*
      LET g_param.docno = g_argv[05]            #過單單號  *若是exp則必填*
      LET g_param.seq = g_argv[06]              #過單項次  *若是exp則必填必填*
      LET g_param.extra_condition = g_argv[07]  #額外條件
      
      DISPLAY "g_param.action_type:",g_param.action_type
      DISPLAY "g_param.trans_all:",g_param.trans_all
      DISPLAY "g_param.table_name:",g_param.table_name
      DISPLAY "g_param.log_name:",g_param.log_name
      DISPLAY "g_param.docno:",g_param.docno
      DISPLAY "g_param.seq:",g_param.seq
      DISPLAY "g_param.extra_condition:",g_param.extra_condition
      
      IF g_param.action_type = "exp" AND (cl_null(g_param.docno) OR g_param.seq = 0) THEN
         RETURN
      END IF
      
      #檢查輸入的單號是否存在，並已派工給PR
      #dzlu_t中紀錄的都是已派工且尚未結案的單號
      #只有匯出至多語言表時才會有過單問題
      IF g_param.action_type = "exp" AND (FGL_GETENV("ZONE") = "t10dev" OR FGL_GETENV("ZONE") = "t10dit") THEN
         LET ls_cnt = 0
         SELECT COUNT(1) INTO ls_cnt FROM dzlu_t
          WHERE dzlu001 = "PR"
            AND dzlu003 = g_param.docno
            AND dzlu006 = g_param.seq
      
         IF ls_cnt <= 0 THEN
            RETURN
         ELSE
            #檢查過單號是否已超過筆數
            CALL azzp110_chk_dzld_rows()
            IF NOT g_chk_status THEN
               RETURN
            END IF
         END IF
      END IF
      
      #確認總共有多少多語言table要處理
      CALL azzp110_checkbox(g_param.trans_all)
      CALL azzp110_chk_item()
      LET ls_table_cnt = 0
      CASE
         WHEN g_param.action_type = "imp"
            LET ls_table_cnt = g_imp_table_name.getLength()
         WHEN g_param.action_type = "exp"
            LET ls_table_cnt = g_exp_table_name.getLength()
         WHEN g_param.action_type = "chk"
            LET ls_table_cnt = g_arr_table_name.getLength()
      END CASE
      IF ls_table_cnt = 0 THEN
         RETURN
      END IF
      
      CALL azzp110_channel()   #紀錄log(目前僅匯出至各多語言表的時候會記錄)
      
      FOR ls_cnt = 1 TO ls_table_cnt
         LET lc_action = ""
         CASE
            WHEN g_param.action_type = "imp"
               LET lc_action = g_imp_table_name[ls_cnt]
            WHEN g_param.action_type = "exp"
               LET lc_action = g_exp_table_name[ls_cnt]
            WHEN g_param.action_type = "chk"
               LET lc_action = g_arr_table_name[ls_cnt]
         END CASE
         
         CALL azzp110_ice_langtable(lc_action)
         IF NOT g_chk_status THEN
            RETURN
         END IF
      END FOR
      
   ELSE
      LET lc_action = g_argv[1]
      DISPLAY "lc_action:",lc_action
      
      CALL azzp110_ice_langtable(lc_action)
   END IF
   
   
   #end add-point
    #DISPLAY "azzp110: ",g_argv[1] 
  

 

 

   #CALL cl_ap_exitprogram("0")
END MAIN
{</section>}
 
{<section id="azzp110.init" >}
#+ 初始化作業
PRIVATE FUNCTION azzp110_init()
   #add-point:init段define
   
   #end add-point
 
   LET g_error_show = 1
   LET gwin_curr2 = ui.Window.getCurrent()
   LET gfrm_curr2 = gwin_curr2.getForm()
   CALL cl_schedule_import_4fd()
   CALL cl_set_combo_scc("gzpa003","75")
   IF cl_get_para(g_enterprise,"","E-SYS-0005") = "N" THEN
       CALL cl_set_comp_visible("scheduling_page,history_page",FALSE)
   END IF 
   #add-point:畫面資料初始化
   
   #end add-point
   
END FUNCTION
 
{</section>}
 
{<section id="azzp110.ui_dialog" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION azzp110_ui_dialog()
 

 

 

 

 

 

 

 

END FUNCTION
{</section>}
 
{<section id="azzp110.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
PRIVATE FUNCTION azzp110_transfer_argv(ls_js)
   DEFINE ls_js       STRING
   DEFINE la_cmdrun   RECORD
             prog     STRING,
             param    DYNAMIC ARRAY OF STRING
                  END RECORD
   DEFINE la_param    type_parameter
 
   CALL util.JSON.parse(ls_js,la_param)
 
   LET la_cmdrun.prog = g_prog
   #add-point:transfer.argv段define
   
   #end add-point
 
   RETURN util.JSON.stringify( la_cmdrun )
END FUNCTION
 
{</section>}
 
{<section id="azzp110.process" >}
#+ 資料處理
PRIVATE FUNCTION azzp110_process(ls_js)
   DEFINE ls_js       STRING
   DEFINE lc_param    type_parameter
   DEFINE li_stus     LIKE type_t.num5
   DEFINE li_count    LIKE type_t.num10  #progressbar計量
   DEFINE ls_sql      STRING             #主SQL
   #add-point:process段define
   
   #end add-point
 
   CALL util.JSON.parse(ls_js,lc_param)
 
   #add-point:process段前處理
   
   #end add-point
 
   #預先計算progressbar迴圈次數
   IF g_bgjob <> "Y" THEN
      #add-point:process段count_progress
      
      #end add-point
   END IF
 
   #主SQL及相關FOREACH前置處理
#  DECLARE azzp110_process_cs CURSOR FROM ls_sql
#  FOREACH azzp110_process_cs INTO
   #add-point:process段process
   
   #end add-point
#  END FOREACH
 
   IF g_bgjob = "N" THEN
      #前景作業完成處理
      #add-point:process段foreground完成處理
      
      #end add-point
      CALL cl_ask_confirm("std-00012") RETURNING li_stus
   ELSE
      #背景作業完成處理
      #add-point:process段background完成處理
      
      #end add-point
   END IF
END FUNCTION
 
{</section>}
 
{<section id="azzp110.get_buffer" >}
 
 
{</section>}
 
{<section id="azzp110.other_function" >}
#add-point:自定義元件(Function)

################################################################################
# Descriptions...: 從表格名稱insert到字典檔
# Memo...........:
# Usage..........: CALL azzp110_ins_dzeal_zhtw()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_ins_dzeal_zhtw()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_dzeal001 LIKE dzeal_t.dzeal001   #表格編號
   DEFINE lc_dzeal002 LIKE dzeal_t.dzeal002   #語言別
   DEFINE lc_dzeal003 LIKE dzeal_t.dzeal003   #表格名稱
   DEFINE lc_dzeal004 LIKE dzeal_t.dzeal004   #表格目的
   DEFINE lc_dzeal005 LIKE dzeal_t.dzeal005   #備註
   DEFINE lc_dzeal003_new LIKE dzeal_t.dzeal003   #表格名稱
   DEFINE lc_dzeal004_new LIKE dzeal_t.dzeal004   #表格目的
   DEFINE lc_dzeal005_new LIKE dzeal_t.dzeal005   #備註
   DEFINE li_row      LIKE type_t.num10
   DEFINE li_zhtw     LIKE type_t.num5
   DEFINE lc_gzozcrtdt LIKE gzoz_t.gzozcrtdt
   DEFINE lc_gzoz001  LIKE gzoz_t.gzoz001
   DEFINE lc_dzeal    RECORD LIKE dzeal_t.*  
   DEFINE lc_msg      STRING
   
   
   LET ls_sql = "SELECT UNIQUE dzeal001 FROM dzeal_t ",
                " WHERE (dzeal002 = 'zh_TW' OR dzeal002 = 'zh_CN') ",
                  " AND TRIM(dzeal003) IS NOT NULL ",
                  " AND NOT dzeal001 like 'it%' "  #額外條件

   #如果有外傳參數的處理
   IF g_param.extra_condition IS NOT NULL THEN
      LET ls_sql = ls_sql," ",g_param.extra_condition
   END IF

   #排序
   LET ls_sql = ls_sql, "ORDER BY dzeal001 "

   #組合SQL
   DECLARE azzp110_dzeal_zhtw_cs CURSOR FROM ls_sql
   FOREACH azzp110_dzeal_zhtw_cs INTO lc_dzeal001
       DISPLAY "insert from dzeal_t:",lc_dzeal001
       #先檢查簡繁是否都存在
       SELECT COUNT(*) INTO li_cnt FROM dzeal_t
        WHERE dzeal001 = lc_dzeal001 AND (dzeal002 = 'zh_TW' OR dzeal002 = 'zh_CN')
          AND dzeal003 IS NOT NULL

      #簡繁只有一筆,若為繁體直接取,若為簡體先轉詞轉碼
      IF li_cnt = 1 THEN
         SELECT * INTO lc_dzeal.* FROM dzeal_t
          WHERE dzeal001 = lc_dzeal001 AND (dzeal002 = 'zh_TW' OR dzeal002 = 'zh_CN')
            AND dzeal003 IS NOT NULL

         #若這唯一的一筆是簡體,就要先轉換為繁體寫回
         IF lc_dzeal.dzeal002 = 'zh_CN' AND NOT cl_null(lc_dzeal.dzeal003) THEN
            #轉換該轉的 (此處cl_trans有先寫字典檔)
            LET lc_dzeal.dzeal002 = "zh_TW"         
            LET lc_dzeal003_new = cl_trans_code_tw_cn("zh_TW",lc_dzeal.dzeal003)
            IF g_bgjob= "Y" AND (cl_null(lc_dzeal003_new) AND NOT cl_null(lc_dzeal.dzeal003)) THEN
              LET lc_msg = "<tr hieght=22><td class=xl24>dzeal_t</td>",                      #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_dzeal.dzeal001,"</td>",        #key值欄位1
                                          "<td class=xl24></td>",                             #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_dzeal.dzeal003,"</td>",        #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字    
                            "</tr>"
            
               CALL g_gen_ch.writeLine(lc_msg)
               
               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_dzeal.dzeal003 = lc_dzeal003_new
            
            LET lc_dzeal004_new = cl_trans_code_tw_cn("zh_TW",lc_dzeal.dzeal004)
            IF g_bgjob= "Y" AND (cl_null(lc_dzeal004_new) AND NOT cl_null(lc_dzeal.dzeal004)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>dzeal_t</td>",                      #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_dzeal.dzeal001,"</td>",        #key值欄位1
                                          "<td class=xl24></td>",                             #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_dzeal.dzeal004,"</td>",        #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字    
                            "</tr>"
            
               CALL g_gen_ch.writeLine(lc_msg)
               
               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_dzeal.dzeal004 = lc_dzeal004_new
            
            LET lc_dzeal005_new = cl_trans_code_tw_cn("zh_TW",lc_dzeal.dzeal005)
            IF g_bgjob= "Y" AND (cl_null(lc_dzeal005_new) AND NOT cl_null(lc_dzeal.dzeal005)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>dzeal_t</td>",                      #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_dzeal.dzeal001,"</td>",        #key值欄位1
                                          "<td class=xl24></td>",                             #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_dzeal.dzeal005,"</td>",        #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字    
                            "</tr>"
            
               CALL g_gen_ch.writeLine(lc_msg)
               
               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_dzeal.dzeal005 = lc_dzeal005_new

            #回寫
            INSERT INTO dzeal_t VALUES (lc_dzeal.*)

         END IF
      ELSE
         IF li_cnt = 2 THEN
           #簡繁有2筆時, 重抓資料
            SELECT * INTO lc_dzeal.* FROM dzeal_t
             WHERE dzeal001 = lc_dzeal001 AND dzeal002 = "zh_TW"
         END IF
      END IF
      
      IF li_cnt > 0 THEN
         #再檢查字典檔,遇缺則補入
         IF azzp110_chk_gzoy("dzeal_t",lc_dzeal.dzeal002,lc_dzeal.dzeal001,'','',lc_dzeal.dzeal003) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_dzeal.dzeal003,lc_dzeal.dzeal001,'','')
         END IF
         IF azzp110_chk_gzoy("dzeal_t",lc_dzeal.dzeal002,lc_dzeal.dzeal001,'','',lc_dzeal.dzeal004) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_dzeal.dzeal004,lc_dzeal.dzeal001,'','')
         END IF
         IF azzp110_chk_gzoy("dzeal_t",lc_dzeal.dzeal002,lc_dzeal.dzeal001,'','',lc_dzeal.dzeal005) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_dzeal.dzeal005,lc_dzeal.dzeal001,'','')
         END IF         
      END IF

   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 從欄位名稱insert到字典檔
# Memo...........:
# Usage..........: CALL azzp110_ins_dzebl_zhtw()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_ins_dzebl_zhtw()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_dzebl001 LIKE dzebl_t.dzebl001   #欄位編號
   DEFINE lc_dzebl002 LIKE dzebl_t.dzebl002   #語言別
   DEFINE lc_dzebl003 LIKE dzebl_t.dzebl003   #欄位名稱
   DEFINE lc_dzebl004 LIKE dzebl_t.dzebl004   #欄位說明
   DEFINE lc_dzebl003_new LIKE dzebl_t.dzebl003   #欄位名稱
   DEFINE lc_dzebl004_new LIKE dzebl_t.dzebl004   #欄位說明
   DEFINE li_row      LIKE type_t.num10
   DEFINE li_zhtw     LIKE type_t.num5
   DEFINE lc_gzozcrtdt LIKE gzoz_t.gzozcrtdt
   DEFINE lc_gzoz001  LIKE gzoz_t.gzoz001
   DEFINE lc_dzebl    RECORD LIKE dzebl_t.*  
   DEFINE lc_msg      STRING
   

   LET ls_sql = "SELECT UNIQUE dzebl001 FROM dzebl_t ",
                " WHERE (dzebl002 = 'zh_TW' OR dzebl002 = 'zh_CN') ",
                  " AND TRIM(dzebl003) IS NOT NULL ",
                  " AND NOT dzebl001 like 'it%' "  #額外條件

   #如果有外傳參數的處理
   IF g_param.extra_condition IS NOT NULL THEN
      LET ls_sql = ls_sql," ",g_param.extra_condition
   END IF

   #排序
   LET ls_sql = ls_sql, "ORDER BY dzebl001 "

   #組合SQL
   DECLARE azzp110_dzebl_zhtw_cs CURSOR FROM ls_sql
   FOREACH azzp110_dzebl_zhtw_cs INTO lc_dzebl001
       DISPLAY "insert from dzebl_t:",lc_dzebl001
       #先檢查簡繁是否都存在
       SELECT COUNT(*) INTO li_cnt FROM dzebl_t
        WHERE dzebl001 = lc_dzebl001 AND (dzebl002 = 'zh_TW' OR dzebl002 = 'zh_CN')
          AND dzebl003 IS NOT NULL

      #簡繁只有一筆,若為繁體直接取,若為簡體先轉詞轉碼
      IF li_cnt = 1 THEN
         SELECT * INTO lc_dzebl.* FROM dzebl_t
          WHERE dzebl001 = lc_dzebl001 AND (dzebl002 = 'zh_TW' OR dzebl002 = 'zh_CN')
            AND dzebl003 IS NOT NULL

         #若這唯一的一筆是簡體,就要先轉換為繁體寫回                
         IF lc_dzebl.dzebl002 = 'zh_CN' AND NOT cl_null(lc_dzebl.dzebl003) THEN
            #轉換該轉的 (此處cl_trans有先寫字典檔)
            LET lc_dzebl.dzebl002 = "zh_TW"
            LET lc_dzebl003_new = cl_trans_code_tw_cn("zh_TW",lc_dzebl.dzebl003)
            IF g_bgjob= "Y" AND (cl_null(lc_dzebl003_new) AND NOT cl_null(lc_dzebl.dzebl003)) THEN
              LET lc_msg = "<tr hieght=22><td class=xl24>dzebl_t</td>",                      #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_dzebl.dzebl001,"</td>",        #key值欄位1
                                          "<td class=xl24></td>",                             #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_dzebl.dzebl003,"</td>",        #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字    
                            "</tr>"
            
               CALL g_gen_ch.writeLine(lc_msg)
               
               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            
            LET lc_dzebl004_new = cl_trans_code_tw_cn("zh_TW",lc_dzebl.dzebl004)
            IF g_bgjob= "Y" AND (cl_null(lc_dzebl004_new) AND NOT cl_null(lc_dzebl.dzebl004)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>dzebl_t</td>",                      #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_dzebl.dzebl001,"</td>",        #key值欄位1
                                          "<td class=xl24></td>",                             #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_dzebl.dzebl004,"</td>",        #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字    
                            "</tr>"
            
               CALL g_gen_ch.writeLine(lc_msg)
               
               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_dzebl.dzebl004 = lc_dzebl004_new

            #回寫
            INSERT INTO dzebl_t VALUES (lc_dzebl.*)

         END IF
      ELSE
         IF li_cnt = 2 THEN
           #簡繁有2筆時, 重抓資料
            SELECT * INTO lc_dzebl.* FROM dzebl_t
             WHERE dzebl001 = lc_dzebl001 AND dzebl002 = "zh_TW"
         END IF
      END IF
      
      IF li_cnt > 0 THEN
         #再檢查字典檔,遇缺則補入
         IF azzp110_chk_gzoy("dzebl_t",lc_dzebl.dzebl002,lc_dzebl.dzebl001,'','',lc_dzebl.dzebl003) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_dzebl.dzebl003,lc_dzebl.dzebl001,'','')
         END IF
         IF azzp110_chk_gzoy("dzebl_t",lc_dzebl.dzebl002,lc_dzebl.dzebl001,'','',lc_dzebl.dzebl004) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_dzebl.dzebl004,lc_dzebl.dzebl001,'','')
         END IF
      END IF

   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 程式/作業名稱 insert 到字典檔
# Memo...........:
# Usage..........: CALL azzp110_ins_gzzal_zhtw()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_ins_gzzal_zhtw()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_gzzal001 LIKE gzzal_t.gzzal001   #程式編號
   DEFINE lc_gzzal002 LIKE gzzal_t.gzzal002   #語言別
   DEFINE lc_gzzal003 LIKE gzzal_t.gzzal003   #程式名稱
   DEFINE lc_gzzal005 LIKE gzzal_t.gzzal005   #程式簡稱
   DEFINE lc_gzzal003_new LIKE gzzal_t.gzzal003   #程式名稱
   DEFINE lc_gzzal005_new LIKE gzzal_t.gzzal005   #程式簡稱
   DEFINE li_row      LIKE type_t.num10
   DEFINE li_zhtw     LIKE type_t.num5
   DEFINE lc_gzozcrtdt LIKE gzoz_t.gzozcrtdt
   DEFINE lc_gzoz001  LIKE gzoz_t.gzoz001
   DEFINE lc_gzzal    RECORD LIKE gzzal_t.*    
   DEFINE lc_msg      STRING
   
   
   LET ls_sql = "SELECT UNIQUE gzzal001 FROM gzzal_t ",
                " WHERE (gzzal002 = 'zh_TW' OR gzzal002 = 'zh_CN') ",
                  " AND TRIM(gzzal003) IS NOT NULL ",
                  " AND NOT gzzal001 like 'ait%' "  #額外條件

   #如果有外傳參數的處理
   IF g_param.extra_condition IS NOT NULL THEN
      LET ls_sql = ls_sql," ",g_param.extra_condition
   END IF

   #排序
   LET ls_sql = ls_sql, "ORDER BY gzzal001 "

   #組合SQL
   DECLARE azzp110_gzzal_zhtw_cs CURSOR FROM ls_sql
   FOREACH azzp110_gzzal_zhtw_cs INTO lc_gzzal001
       DISPLAY "insert from gzzal_t:",lc_gzzal001
       #先檢查簡繁是否都存在
       SELECT COUNT(*) INTO li_cnt FROM gzzal_t
        WHERE gzzal001 = lc_gzzal001 AND (gzzal002 = 'zh_TW' OR gzzal002 = 'zh_CN')
          AND gzzal003 IS NOT NULL

      #簡繁只有一筆,若為繁體直接取,若為簡體先轉詞轉碼
      IF li_cnt = 1 THEN
         SELECT * INTO lc_gzzal.* FROM gzzal_t
          WHERE gzzal001 = lc_gzzal001 AND (gzzal002 = 'zh_TW' OR gzzal002 = 'zh_CN')
            AND gzzal003 IS NOT NULL

         #若這唯一的一筆是簡體,就要先轉換為繁體寫回
         IF lc_gzzal.gzzal002 = 'zh_CN' AND NOT cl_null(lc_gzzal.gzzal003) THEN
            #轉換該轉的 (此處cl_trans有先寫字典檔)
            LET lc_gzzal.gzzal002 = "zh_TW"
            LET lc_gzzal003_new = cl_trans_code_tw_cn("zh_TW",lc_gzzal.gzzal003)
            IF g_bgjob= "Y" AND (cl_null(lc_gzzal003_new) AND NOT cl_null(lc_gzzal.gzzal003)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>gzzal_t</td>",                      #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_gzzal.gzzal001,"</td>",        #key值欄位1
                                          "<td class=xl24></td>",                             #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_gzzal.gzzal003,"</td>",        #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字    
                            "</tr>"
            
               CALL g_gen_ch.writeLine(lc_msg)
               
               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_gzzal.gzzal003 = lc_gzzal003_new
            
            LET lc_gzzal005_new = cl_trans_code_tw_cn("zh_TW",lc_gzzal.gzzal005)
            IF g_bgjob= "Y" AND (cl_null(lc_gzzal005_new) AND NOT cl_null(lc_gzzal.gzzal005)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>gzzal_t</td>",                      #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_gzzal.gzzal001,"</td>",        #key值欄位1
                                          "<td class=xl24></td>",                             #key值欄位
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_gzzal.gzzal005,"</td>",        #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字    
                            "</tr>"
            
               CALL g_gen_ch.writeLine(lc_msg)
               
               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_gzzal.gzzal005 = lc_gzzal005_new

            #回寫
            INSERT INTO gzzal_t VALUES (lc_gzzal.*)

         END IF
      ELSE
         IF li_cnt = 2 THEN
           #簡繁有2筆時, 重抓資料
            SELECT * INTO lc_gzzal.* FROM gzzal_t
             WHERE gzzal001 = lc_gzzal001 AND gzzal002 = "zh_TW"
         END IF
      END IF
      
      IF li_cnt > 0 THEN
         #再檢查字典檔,遇缺則補入
         IF azzp110_chk_gzoy("gzzal_t",lc_gzzal.gzzal002,lc_gzzal.gzzal001,'','',lc_gzzal.gzzal003) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_gzzal.gzzal003,lc_gzzal.gzzal001,'','')
         END IF
         IF azzp110_chk_gzoy("gzzal_t",lc_gzzal.gzzal002,lc_gzzal.gzzal001,'','',lc_gzzal.gzzal005) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_gzzal.gzzal005,lc_gzzal.gzzal001,'','')
         END IF
      END IF

   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 畫面元件 insert 到字典檔
# Memo...........:
# Usage..........: CALL azzp110_ins_gzzd_zhtw()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_ins_gzzd_zhtw()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE li_cnt2     LIKE type_t.num10
   DEFINE lc_gzzd001  LIKE gzzd_t.gzzd001 #畫面編號
   DEFINE lc_gzzd002  LIKE gzzd_t.gzzd002 #語言別
   DEFINE lc_gzzd003  LIKE gzzd_t.gzzd003 #待轉標籤
   DEFINE lc_gzzd004  LIKE gzzd_t.gzzd004 #使用標示
   DEFINE lc_gzzd005  LIKE gzzd_t.gzzd005 #待轉標籤文字
   DEFINE lc_gzzd006  LIKE gzzd_t.gzzd006 #轉換註解
   DEFINE lc_gzzd004_new  LIKE gzzd_t.gzzd004 #使用標示
   DEFINE lc_gzzd005_new  LIKE gzzd_t.gzzd005 #待轉標籤文字
   DEFINE lc_gzzd006_new  LIKE gzzd_t.gzzd006 #轉換註解
   DEFINE li_row      LIKE type_t.num10
   DEFINE li_zhtw     LIKE type_t.num5
   DEFINE lc_gzozcrtdt LIKE gzoz_t.gzozcrtdt
   DEFINE lc_gzoz001  LIKE gzoz_t.gzoz001
   DEFINE lc_gzzd     RECORD LIKE gzzd_t.*
   DEFINE lc_msg      STRING
   
   
   LET ls_sql = "SELECT UNIQUE gzzd001,gzzd003,gzzd004 FROM gzzd_t ",
                " WHERE (gzzd002 = 'zh_TW' OR gzzd002 = 'zh_CN') ",
                  " AND TRIM(gzzd005) IS NOT NULL ",
                  " AND NOT gzzd001 like 'ait%' "  #額外條件

   #如果有外傳參數的處理
   IF g_param.extra_condition IS NOT NULL THEN
      LET ls_sql = ls_sql," ",g_param.extra_condition
   END IF
   
   #排序
   LET ls_sql = ls_sql, "ORDER BY gzzd001,gzzd003,gzzd004 "

   #組合SQL
   DECLARE azzp110_gzzd_zhtw_cs CURSOR FROM ls_sql
   FOREACH azzp110_gzzd_zhtw_cs INTO lc_gzzd001,lc_gzzd003,lc_gzzd004
      DISPLAY "insert from gzzd_t:",lc_gzzd001
      #先檢查簡繁是否都存在
      SELECT COUNT(*) INTO li_cnt FROM gzzd_t
       WHERE gzzd001 = lc_gzzd001 AND gzzd003 = lc_gzzd003
         AND gzzd004 = lc_gzzd004 AND (gzzd002 = 'zh_TW' OR gzzd002 = 'zh_CN')

      #簡繁只有一筆,若為繁體直接取,若為簡體先轉詞轉碼
      IF li_cnt = 1 THEN
         SELECT * INTO lc_gzzd.* FROM gzzd_t
          WHERE gzzd001 = lc_gzzd001 AND gzzd003 = lc_gzzd003
            AND gzzd004 = lc_gzzd004 AND (gzzd002 = 'zh_TW' OR gzzd002 = 'zh_CN')

         #若這唯一的一筆是簡體,就要先轉換為繁體寫回
         IF lc_gzzd.gzzd002 = 'zh_CN' AND NOT cl_null(lc_gzzd.gzzd005) THEN
            #轉換該轉的 (此處cl_trans有先寫字典檔)
            LET lc_gzzd.gzzd002 = "zh_TW"
            LET lc_gzzd005_new = cl_trans_code_tw_cn("zh_TW",lc_gzzd.gzzd005)
            IF g_bgjob= "Y" AND (cl_null(lc_gzzd005_new) AND NOT cl_null(lc_gzzd.gzzd005)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>gzzd_t</td>",                       #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_gzzd.gzzd001,"</td>",          #key值欄位1
                                          "<td class=xl24>",lc_gzzd.gzzd003,"</td>",          #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_gzzd.gzzd005,"</td>",          #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字    
                            "</tr>"
            
               CALL g_gen_ch.writeLine(lc_msg)
               
               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_gzzd.gzzd005 = lc_gzzd005_new
            
            LET lc_gzzd006_new = cl_trans_code_tw_cn("zh_TW",lc_gzzd.gzzd006)
            IF g_bgjob= "Y" AND (cl_null(lc_gzzd006_new) AND NOT cl_null(lc_gzzd.gzzd006)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>gzzd_t</td>",                       #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_gzzd.gzzd001,"</td>",          #key值欄位1
                                          "<td class=xl24>",lc_gzzd.gzzd003,"</td>",          #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_gzzd.gzzd006,"</td>",          #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字    
                            "</tr>"
            
               CALL g_gen_ch.writeLine(lc_msg)
               
               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_gzzd.gzzd006 = lc_gzzd006_new

            #回寫
            INSERT INTO gzzd_t VALUES (lc_gzzd.*)

         END IF
      ELSE
         IF li_cnt = 2 THEN
           #簡繁有2筆時, 重抓資料
           SELECT * INTO lc_gzzd.* FROM gzzd_t
            WHERE gzzd001 = lc_gzzd001 AND gzzd003 = lc_gzzd003
              AND gzzd004 = lc_gzzd004 AND gzzd002 = "zh_TW"
         END IF
      END IF
      
      IF li_cnt > 0 THEN
         #再檢查字典檔,遇缺則補入
         IF azzp110_chk_gzoy("gzzd_t",lc_gzzd.gzzd002,lc_gzzd.gzzd001,lc_gzzd.gzzd003,'',lc_gzzd.gzzd005) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_gzzd.gzzd005,lc_gzzd.gzzd001,lc_gzzd.gzzdcrtid,lc_gzzd.gzzdcrtdp)
         END IF
         IF azzp110_chk_gzoy("gzzd_t",lc_gzzd.gzzd002,lc_gzzd.gzzd001,lc_gzzd.gzzd003,'',lc_gzzd.gzzd006) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_gzzd.gzzd006,lc_gzzd.gzzd001,lc_gzzd.gzzdcrtid,lc_gzzd.gzzdcrtdp)
         END IF
      END IF

   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 子畫面名稱 insert 到字典檔
# Memo...........:
# Usage..........: CALL azzp110_ins_gzdfl_zhtw()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_ins_gzdfl_zhtw()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_gzdfl001 LIKE gzdfl_t.gzdfl001   #規格編號
   DEFINE lc_gzdfl002 LIKE gzdfl_t.gzdfl002   #語言別
   DEFINE lc_gzdfl003 LIKE gzdfl_t.gzdfl003   #子畫面檔案名稱
   DEFINE lc_gzdfl003_new LIKE gzdfl_t.gzdfl003   #子畫面檔案名稱
   DEFINE li_row      LIKE type_t.num10
   DEFINE li_zhtw     LIKE type_t.num5
   DEFINE lc_gzozcrtdt LIKE gzoz_t.gzozcrtdt
   DEFINE lc_gzdfl    RECORD LIKE gzdfl_t.*  
   DEFINE lc_msg      STRING
   
   
   LET ls_sql = "SELECT UNIQUE gzdfl001 FROM gzdfl_t ",
                " WHERE (gzdfl002 = 'zh_TW' OR gzdfl002 = 'zh_CN') ",
                  " AND TRIM(gzdfl003) IS NOT NULL ",
                  " AND NOT gzdfl001 like 'ait%' "  #額外條件

   #如果有外傳參數的處理
   IF g_param.extra_condition IS NOT NULL THEN
      LET ls_sql = ls_sql," ",g_param.extra_condition
   END IF

   #排序
   LET ls_sql = ls_sql, "ORDER BY gzdfl001 "

   #組合SQL
   DECLARE azzp110_gzdfl_zhtw_cs CURSOR FROM ls_sql
   FOREACH azzp110_gzdfl_zhtw_cs INTO lc_gzdfl001
       DISPLAY "insert from gzdfl_t:",lc_gzdfl001
       #先檢查簡繁是否都存在
       SELECT COUNT(*) INTO li_cnt FROM gzdfl_t
        WHERE gzdfl001 = lc_gzdfl001 AND (gzdfl002 = 'zh_TW' OR gzdfl002 = 'zh_CN')
          AND gzdfl003 IS NOT NULL

      #簡繁只有一筆,若為繁體直接取,若為簡體先轉詞轉碼
      IF li_cnt = 1 THEN
         SELECT * INTO lc_gzdfl.* FROM gzdfl_t
          WHERE gzdfl001 = lc_gzdfl001 AND (gzdfl002 = 'zh_TW' OR gzdfl002 = 'zh_CN')
            AND gzdfl003 IS NOT NULL
                
         #若這唯一的一筆是簡體,就要先轉換為繁體寫回                
         IF lc_gzdfl.gzdfl002 = 'zh_CN' AND NOT cl_null(lc_gzdfl.gzdfl003) THEN
            #轉換該轉的 (此處cl_trans有先寫字典檔)
            LET lc_gzdfl.gzdfl002 = "zh_TW"         
            LET lc_gzdfl003_new = cl_trans_code_tw_cn("zh_TW",lc_gzdfl.gzdfl003)
            IF g_bgjob= "Y" AND (cl_null(lc_gzdfl003_new) AND NOT cl_null(lc_gzdfl.gzdfl003)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>gzdfl_t</td>",                      #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_gzdfl.gzdfl001,"</td>",        #key值欄位1
                                          "<td class=xl24></td>",                             #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_gzdfl.gzdfl003,"</td>",        #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字    
                            "</tr>"
            
               CALL g_gen_ch.writeLine(lc_msg)
               
               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_gzdfl.gzdfl003 = lc_gzdfl003_new

            #回寫
            INSERT INTO gzdfl_t VALUES (lc_gzdfl.*)

         END IF
      ELSE
         IF li_cnt = 2 THEN
           #簡繁有2筆時, 重抓資料
            SELECT * INTO lc_gzdfl.* FROM gzdfl_t
             WHERE gzdfl001 = lc_gzdfl001 AND gzdfl002 = "zh_TW"
         END IF
      END IF
      
      IF li_cnt > 0 THEN
         #再檢查字典檔,遇缺則補入
         IF azzp110_chk_gzoy("gzdfl_t",lc_gzdfl.gzdfl002,lc_gzdfl.gzdfl001,'','',lc_gzdfl.gzdfl003) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_gzdfl.gzdfl003,lc_gzdfl.gzdfl001,'','')
         END IF
      END IF

   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 功能名稱 insert 到字典檔
# Memo...........:
# Usage..........: CALL azzp110_ins_gzzq_zhtw()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_ins_gzzq_zhtw()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE li_cnt2     LIKE type_t.num10
   DEFINE lc_gzzq001  LIKE gzzq_t.gzzq001 #程式編號
   DEFINE lc_gzzq002  LIKE gzzq_t.gzzq002 #功能編號
   DEFINE lc_gzzq003  LIKE gzzq_t.gzzq003 #語言別
   DEFINE lc_gzzq004  LIKE gzzq_t.gzzq004 #功能名稱
   DEFINE lc_gzzq005  LIKE gzzq_t.gzzq005 #功能說明
   DEFINE lc_gzzq004_new  LIKE gzzq_t.gzzq004 #功能名稱
   DEFINE lc_gzzq005_new  LIKE gzzq_t.gzzq005 #功能說明
   DEFINE li_row      LIKE type_t.num10
   DEFINE li_zhtw     LIKE type_t.num5
   DEFINE lc_gzozcrtdt LIKE gzoz_t.gzozcrtdt
   DEFINE lc_gzzq001_2 LIKE gzzq_t.gzzq001   #程式編號
   DEFINE lc_gzzq    RECORD LIKE gzzq_t.*    
   DEFINE lc_msg      STRING
   
   
   LET ls_sql = "SELECT UNIQUE gzzq001,gzzq002 FROM gzzq_t ",
                " WHERE (gzzq003 = 'zh_TW' OR gzzq003 = 'zh_CN') ",
                  " AND TRIM(gzzq004) IS NOT NULL "

   #如果有外傳參數的處理
   IF g_param.extra_condition IS NOT NULL THEN
      LET ls_sql = ls_sql," ",g_param.extra_condition
   END IF

   #排序
   LET ls_sql = ls_sql, "ORDER BY gzzq001,gzzq002 "

   #組合SQL
   DECLARE azzp110_gzzq_zhtw_cs CURSOR FROM ls_sql
   FOREACH azzp110_gzzq_zhtw_cs INTO lc_gzzq001,lc_gzzq002
     DISPLAY "insert from gzzq_t:",lc_gzzq001
     IF lc_gzzq001 = "standard" THEN 
        LET lc_gzzq001_2 = "azzi903_",lc_gzzq001
     ELSE 
        LET lc_gzzq001_2 = lc_gzzq001  
     END IF 
       #先檢查簡繁是否都存在
       SELECT COUNT(*) INTO li_cnt FROM gzzq_t
        WHERE gzzq001 = lc_gzzq001 AND gzzq002 = lc_gzzq002
          AND (gzzq003 = 'zh_TW' OR gzzq003 = 'zh_CN')

      #簡繁只有一筆,若為繁體直接取,若為簡體先轉詞轉碼
      IF li_cnt = 1 THEN
         SELECT * INTO lc_gzzq.* FROM gzzq_t
          WHERE gzzq001 = lc_gzzq001 AND gzzq002 = lc_gzzq002
            AND (gzzq003 = 'zh_TW' OR gzzq003 = 'zh_CN')
                
         #若這唯一的一筆是簡體,就要先轉換為繁體寫回                
         IF lc_gzzq.gzzq003 = 'zh_CN' AND NOT cl_null(lc_gzzq.gzzq004) THEN
            #轉換該轉的 (此處cl_trans有先寫字典檔)
            LET lc_gzzq.gzzq003 = "zh_TW"         
            LET lc_gzzq004_new = cl_trans_code_tw_cn("zh_TW",lc_gzzq.gzzq004)
            IF g_bgjob= "Y" AND (cl_null(lc_gzzq004_new) AND NOT cl_null(lc_gzzq.gzzq004)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>gzzq_t</td>",                       #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_gzzq.gzzq001,"</td>",          #key值欄位1
                                          "<td class=xl24>",lc_gzzq.gzzq002,"</td>",          #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_gzzq.gzzq004,"</td>",          #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字    
                            "</tr>"
            
               CALL g_gen_ch.writeLine(lc_msg)
               
               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_gzzq.gzzq004 = lc_gzzq004_new
            
            LET lc_gzzq005_new = cl_trans_code_tw_cn("zh_TW",lc_gzzq.gzzq005)
            IF g_bgjob= "Y" AND (cl_null(lc_gzzq005_new) AND NOT cl_null(lc_gzzq.gzzq005)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>gzzq_t</td>",                       #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_gzzq.gzzq001,"</td>",          #key值欄位1
                                          "<td class=xl24>",lc_gzzq.gzzq002,"</td>",          #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_gzzq.gzzq005,"</td>",          #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字    
                            "</tr>"
            
               CALL g_gen_ch.writeLine(lc_msg)
               
               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_gzzq.gzzq005 = lc_gzzq005_new

            #回寫
            INSERT INTO gzzq_t VALUES (lc_gzzq.*)

         END IF
      ELSE
         IF li_cnt = 2 THEN
           #簡繁有2筆時, 重抓資料
            SELECT * INTO lc_gzzq.* FROM gzzq_t
             WHERE gzzq001 = lc_gzzq001 AND gzzq002 = lc_gzzq002 AND gzzq003 = "zh_TW"
         END IF
      END IF
      
      IF li_cnt > 0 THEN
         #再檢查字典檔,遇缺則補入
         IF azzp110_chk_gzoy("gzzq_t",lc_gzzq.gzzq003,lc_gzzq.gzzq001,lc_gzzq.gzzq002,'',lc_gzzq.gzzq004) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_gzzq.gzzq004,lc_gzzq.gzzq001,'','')
         END IF
         IF azzp110_chk_gzoy("gzzq_t",lc_gzzq.gzzq003,lc_gzzq.gzzq001,lc_gzzq.gzzq002,'',lc_gzzq.gzzq005) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_gzzq.gzzq005,lc_gzzq.gzzq001,'','')
         END IF
      END IF

   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 參數分頁 insert 到字典檔
# Memo...........:
# Usage..........: CALL azzp110_ins_gzswl_zhtw()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_ins_gzswl_zhtw()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_gzswl001 LIKE gzswl_t.gzswl001   #設定作業名稱
   DEFINE lc_gzswl002 LIKE gzswl_t.gzswl002   #分頁編號
   DEFINE lc_gzswl003 LIKE gzswl_t.gzswl003   #語言別
   DEFINE lc_gzswl004 LIKE gzswl_t.gzswl004   #說明
   DEFINE lc_gzswl004_new LIKE gzswl_t.gzswl004   #說明
   DEFINE li_row      LIKE type_t.num10
   DEFINE li_zhtw     LIKE type_t.num5
   DEFINE lc_gzozcrtdt LIKE gzoz_t.gzozcrtdt
   DEFINE lc_gzswl    RECORD LIKE gzswl_t.*  
   DEFINE lc_msg      STRING
   
   
   LET ls_sql = "SELECT UNIQUE gzswl001,gzswl002 FROM gzswl_t ",
                " WHERE (gzswl003 = 'zh_TW' OR gzswl003 = 'zh_CN') ",
                  " AND TRIM(gzswl004) IS NOT NULL "

   #如果有外傳參數的處理
   IF g_param.extra_condition IS NOT NULL THEN
      LET ls_sql = ls_sql," ",g_param.extra_condition
   END IF

   #排序
   LET ls_sql = ls_sql, "ORDER BY gzswl001,gzswl002 "

   #組合SQL
   DECLARE azzp110_gzswl_zhtw_cs CURSOR FROM ls_sql
   FOREACH azzp110_gzswl_zhtw_cs INTO lc_gzswl001,lc_gzswl002
       DISPLAY "insert from gzswal_t:",lc_gzswl001
       #先檢查簡繁是否都存在
       SELECT COUNT(*) INTO li_cnt FROM gzswl_t
        WHERE gzswl001 = lc_gzswl001 AND gzswl002 = lc_gzswl002
          AND (gzswl003 = 'zh_TW' OR gzswl003 = 'zh_CN')
          AND gzswl004 IS NOT NULL

      #簡繁只有一筆,若為繁體直接取,若為簡體先轉詞轉碼
      IF li_cnt = 1 THEN
         SELECT * INTO lc_gzswl.* FROM gzswl_t
          WHERE gzswl001 = lc_gzswl001 AND gzswl002 = lc_gzswl002
            AND (gzswl003 = 'zh_TW' OR gzswl003 = 'zh_CN')
            AND gzswl004 IS NOT NULL
                
         #若這唯一的一筆是簡體,就要先轉換為繁體寫回                
         IF lc_gzswl.gzswl003 = 'zh_CN' AND NOT cl_null(lc_gzswl.gzswl004) THEN
            #轉換該轉的 (此處cl_trans有先寫字典檔)
            LET lc_gzswl.gzswl003 = "zh_TW"         
            LET lc_gzswl004_new = cl_trans_code_tw_cn("zh_TW",lc_gzswl.gzswl004)
            IF g_bgjob= "Y" AND (cl_null(lc_gzswl004_new) AND NOT cl_null(lc_gzswl.gzswl004)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>gzswl_t</td>",                      #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_gzswl.gzswl001,"</td>",        #key值欄位1
                                          "<td class=xl24>",lc_gzswl.gzswl002,"</td>",        #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_gzswl.gzswl004,"</td>",        #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字    
                            "</tr>"
            
               CALL g_gen_ch.writeLine(lc_msg)
               
               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_gzswl.gzswl004 = lc_gzswl004_new

            #回寫
            INSERT INTO gzswl_t VALUES (lc_gzswl.*)

         END IF
      ELSE
         IF li_cnt = 2 THEN
           #簡繁有2筆時, 重抓資料
            SELECT * INTO lc_gzswl.* FROM gzswl_t
             WHERE gzswl001 = lc_gzswl001 AND gzswl002 = lc_gzswl002 AND gzswl003 = "zh_TW"
         END IF
      END IF
      
      IF li_cnt > 0 THEN
         #再檢查字典檔,遇缺則補入
         IF azzp110_chk_gzoy("gzswl_t",lc_gzswl.gzswl003,lc_gzswl.gzswl001,lc_gzswl.gzswl002,'',lc_gzswl.gzswl004) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_gzswl.gzswl004,lc_gzswl.gzswl001,'','')
         END IF
      END IF

   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 參數分項 insert 到字典檔
# Memo...........:
# Usage..........: CALL azzp110_ins_gzsxl_zhtw()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_ins_gzsxl_zhtw()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_gzsxl001 LIKE gzsxl_t.gzsxl001   #設定作業名稱
   DEFINE lc_gzsxl002 LIKE gzsxl_t.gzsxl002   #分頁編號
   DEFINE lc_gzsxl003 LIKE gzsxl_t.gzsxl003   #分項編號
   DEFINE lc_gzsxl004 LIKE gzsxl_t.gzsxl004   #語言別
   DEFINE lc_gzsxl005 LIKE gzsxl_t.gzsxl005   #說明
   DEFINE lc_gzsxl005_new LIKE gzsxl_t.gzsxl005   #說明
   DEFINE li_row      LIKE type_t.num10
   DEFINE li_zhtw     LIKE type_t.num5
   DEFINE lc_gzozcrtdt LIKE gzoz_t.gzozcrtdt
   DEFINE lc_gzsxl    RECORD LIKE gzsxl_t.*    
   DEFINE lc_msg      STRING
   
   
   LET ls_sql = "SELECT UNIQUE dzsxl001,dzsxl002,dzsxl003 FROM gzsxl_t ",
                " WHERE (gzsxl004 = 'zh_TW' OR gzsxl004 = 'zh_CN') ",
                  " AND TRIM(gzsxl004) IS NOT NULL "

   #如果有外傳參數的處理
   IF g_param.extra_condition IS NOT NULL THEN
      LET ls_sql = ls_sql," ",g_param.extra_condition
   END IF

   #排序
   LET ls_sql = ls_sql, "ORDER BY gzsxl001,gzsxl002,gzsxl003 "

   #組合SQL
   DECLARE azzp110_gzsxl_zhtw_cs CURSOR FROM ls_sql
   FOREACH azzp110_gzsxl_zhtw_cs INTO lc_gzsxl001,lc_gzsxl002,lc_gzsxl003
       DISPLAY "insert from gzsxl_t:",lc_gzsxl001
       #先檢查簡繁是否都存在
       SELECT COUNT(*) INTO li_cnt FROM gzsxl_t
        WHERE gzsxl001 = lc_gzsxl001 AND gzsxl002 = lc_gzsxl002
          AND gzsxl003 = lc_gzsxl003 AND (gzsxl004 = 'zh_TW' OR gzsxl004 = 'zh_CN')
          AND gzsxl005 IS NOT NULL

      #簡繁只有一筆,若為繁體直接取,若為簡體先轉詞轉碼
      IF li_cnt = 1 THEN
         SELECT * INTO lc_gzsxl.* FROM gzsxl_t
          WHERE gzsxl001 = lc_gzsxl001 AND gzsxk002 = lc_gzsxl002
            AND gzsxl003 = lc_gzsxl003 AND (gzsxl004 = 'zh_TW' OR gzsxl004 = 'zh_CN')
            AND gzsxl005 IS NOT NULL
                
         #若這唯一的一筆是簡體,就要先轉換為繁體寫回                
         IF lc_gzsxl.gzsxl004 = 'zh_CN' AND NOT cl_null(lc_gzsxl.gzsxl005) THEN
            #轉換該轉的 (此處cl_trans有先寫字典檔)
            LET lc_gzsxl.gzsxl004 = "zh_TW"         
            LET lc_gzsxl005_new = cl_trans_code_tw_cn("zh_TW",lc_gzsxl.gzsxl005)
            IF g_bgjob= "Y" AND (cl_null(lc_gzsxl005_new) AND NOT cl_null(lc_gzsxl.gzsxl005)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>gzsxl_t</td>",                      #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_gzsxl.gzsxl001,"</td>",        #key值欄位1
                                          "<td class=xl24>",lc_gzsxl.gzsxl002,"</td>",        #key值欄位2
                                          "<td class=xl24>",lc_gzsxl.gzsxl003,"</td>",        #key值欄位3
                                          "<td class=xl24>",lc_gzsxl.gzsxl005,"</td>",        #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字    
                            "</tr>"
            
               CALL g_gen_ch.writeLine(lc_msg)
               
               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_gzsxl.gzsxl005 = lc_gzsxl005_new

            #回寫
            INSERT INTO gzsxl_t VALUES (lc_gzsxl.*)

         END IF
      ELSE
         IF li_cnt = 2 THEN
           #簡繁有2筆時, 重抓資料
            SELECT * INTO lc_gzsxl.* FROM gzsxl_t
             WHERE gzsxl001 = lc_gzsxl001 AND gzsxl002 = lc_gzsxl002
               AND gzsxl003 = lc_gzsxl003 AND gzsxl004 = "zh_TW"
         END IF
      END IF
      
      IF li_cnt > 0 THEN
         #再檢查字典檔,遇缺則補入
         IF azzp110_chk_gzoy("gzsxl_t",lc_gzsxl.gzsxl004,lc_gzsxl.gzsxl001,lc_gzsxl.gzsxl002,lc_gzsxl.gzsxl003,lc_gzsxl.gzsxl005) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_gzsxl.gzsxl005,lc_gzsxl.gzsxl001,'','')
         END IF
      END IF

   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 參數名稱 insert 到字典檔
# Memo...........:
# Usage..........: CALL azzp110_ins_gzszl_zhtw()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_ins_gzszl_zhtw()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE li_cnt2     LIKE type_t.num10
   DEFINE lc_gzszl001  LIKE gzszl_t.gzszl001 #表格編號
   DEFINE lc_gzszl002  LIKE gzszl_t.gzszl002 #資料序號
   DEFINE lc_gzszl003  LIKE gzszl_t.gzszl003 #語言別
   DEFINE lc_gzszl004  LIKE gzszl_t.gzszl004 #說明
   DEFINE lc_gzszl005  LIKE gzszl_t.gzszl005 #使用說明
   DEFINE lc_gzszl006  LIKE gzszl_t.gzszl006 #應用建議
   DEFINE lc_gzszl007  LIKE gzszl_t.gzszl007 #個案應用說明
   DEFINE lc_gzszl004_new  LIKE gzszl_t.gzszl004 #說明
   DEFINE lc_gzszl005_new  LIKE gzszl_t.gzszl005 #使用說明
   DEFINE lc_gzszl006_new  LIKE gzszl_t.gzszl006 #應用建議
   DEFINE lc_gzszl007_new  LIKE gzszl_t.gzszl007 #個案應用說明
   DEFINE li_row      LIKE type_t.num10
   DEFINE li_zhtw     LIKE type_t.num5
   DEFINE lc_gzozcrtdt LIKE gzoz_t.gzozcrtdt
   DEFINE lc_gzszl    RECORD LIKE gzszl_t.*    
   DEFINE lc_msg      STRING
   
   
   LET ls_sql = "SELECT UNIQUE gzszl001,gzszl002 FROM gzszl_t ",
                " WHERE (gzszl003 = 'zh_TW' OR gzszl003 = 'zh_CN') ",
                  " AND TRIM(gzszl004) IS NOT NULL "

   #如果有外傳參數的處理
   IF g_param.extra_condition IS NOT NULL THEN
      LET ls_sql = ls_sql," ",g_param.extra_condition
   END IF

   #排序
   LET ls_sql = ls_sql, "ORDER BY gzszl001,gzszl002 "

   #組合SQL
   DECLARE azzp110_gzszl_zhtw_cs CURSOR FROM ls_sql
   FOREACH azzp110_gzszl_zhtw_cs INTO lc_gzszl001,lc_gzszl002
       DISPLAY "insert from gzszl_t:",lc_gzszl001
       #先檢查簡繁是否都存在
       SELECT COUNT(*) INTO li_cnt FROM gzszl_t
        WHERE gzszl001 = lc_gzszl001 AND gzszl002 = lc_gzszl002
          AND (gzszl003 = 'zh_TW' OR gzszl003 = 'zh_CN')

      #簡繁只有一筆,若為繁體直接取,若為簡體先轉詞轉碼
      IF li_cnt = 1 THEN
         SELECT * INTO lc_gzszl.* FROM gzszl_t
          WHERE gzszl001 = lc_gzszl001 AND gzszl002 = lc_gzszl002
            AND (gzszl003 = 'zh_TW' OR gzszl003 = 'zh_CN')
                
         #若這唯一的一筆是簡體,就要先轉換為繁體寫回                
         IF lc_gzszl.gzszl003 = 'zh_CN' AND NOT cl_null(lc_gzszl.gzszl004) THEN
            #轉換該轉的 (此處cl_trans有先寫字典檔)
            LET lc_gzszl.gzszl003 = "zh_TW"          
            LET lc_gzszl004_new = cl_trans_code_tw_cn("zh_TW",lc_gzszl.gzszl004)
            IF g_bgjob= "Y" AND (cl_null(lc_gzszl004_new) AND NOT cl_null(lc_gzszl.gzszl004)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>gzszl_t</td>",                      #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_gzszl.gzszl001,"</td>",        #key值欄位1
                                          "<td class=xl24>",lc_gzszl.gzszl002,"</td>",        #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_gzszl.gzszl004,"</td>",        #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字    
                            "</tr>"
            
               CALL g_gen_ch.writeLine(lc_msg)
               
               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_gzszl.gzszl004 = lc_gzszl004_new
            
            LET lc_gzszl005_new = cl_trans_code_tw_cn("zh_TW",lc_gzszl.gzszl005)
            IF g_bgjob= "Y" AND (cl_null(lc_gzszl005_new) AND NOT cl_null(lc_gzszl.gzszl005)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>gzszl_t</td>",                      #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_gzszl.gzszl001,"</td>",        #key值欄位1
                                          "<td class=xl24>",lc_gzszl.gzszl002,"</td>",        #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_gzszl.gzszl005,"</td>",        #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字    
                            "</tr>"
            
               CALL g_gen_ch.writeLine(lc_msg)
               
               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_gzszl.gzszl005 = lc_gzszl005_new
            
            LET lc_gzszl006_new = cl_trans_code_tw_cn("zh_TW",lc_gzszl.gzszl006)
            IF g_bgjob= "Y" AND (cl_null(lc_gzszl006_new) AND NOT cl_null(lc_gzszl.gzszl006)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>gzszl_t</td>",                      #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_gzszl.gzszl001,"</td>",        #key值欄位1
                                          "<td class=xl24>",lc_gzszl.gzszl002,"</td>",        #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_gzszl.gzszl006,"</td>",        #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字    
                            "</tr>"
            
               CALL g_gen_ch.writeLine(lc_msg)
               
               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_gzszl.gzszl006 = lc_gzszl006_new
            
            LET lc_gzszl007_new = cl_trans_code_tw_cn("zh_TW",lc_gzszl.gzszl007)
            IF g_bgjob= "Y" AND (cl_null(lc_gzszl007_new) AND NOT cl_null(lc_gzszl.gzszl007)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>gzszl_t</td>",                      #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_gzszl.gzszl001,"</td>",        #key值欄位1
                                          "<td class=xl24>",lc_gzszl.gzszl002,"</td>",        #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_gzszl.gzszl007,"</td>",        #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字    
                            "</tr>"
            
               CALL g_gen_ch.writeLine(lc_msg)
               
               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_gzszl.gzszl007 = lc_gzszl007_new

            #回寫
            INSERT INTO gzszl_t VALUES (lc_gzszl.*)

         END IF
      ELSE
         IF li_cnt = 2 THEN
           #簡繁有2筆時, 重抓資料
            SELECT * INTO lc_gzszl.* FROM gzszl_t
             WHERE gzszl001 = lc_gzszl001 AND gzszl002 = lc_gzszl002 AND gzszl003 = "zh_TW"
         END IF
      END IF
      
      IF li_cnt > 0 THEN
         #再檢查字典檔,遇缺則補入
         IF azzp110_chk_gzoy("gzszl_t",lc_gzszl.gzszl003,lc_gzszl.gzszl001,lc_gzszl.gzszl002,'',lc_gzszl.gzszl004) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_gzszl.gzszl004,lc_gzszl.gzszl001,'','')
         END IF
         IF azzp110_chk_gzoy("gzszl_t",lc_gzszl.gzszl003,lc_gzszl.gzszl001,lc_gzszl.gzszl002,'',lc_gzszl.gzszl005) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_gzszl.gzszl005,lc_gzszl.gzszl001,'','')
         END IF
         IF azzp110_chk_gzoy("gzszl_t",lc_gzszl.gzszl003,lc_gzszl.gzszl001,lc_gzszl.gzszl002,'',lc_gzszl.gzszl006) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_gzszl.gzszl006,lc_gzszl.gzszl001,'','')
         END IF
         IF azzp110_chk_gzoy("gzszl_t",lc_gzszl.gzszl003,lc_gzszl.gzszl001,lc_gzszl.gzszl002,'',lc_gzszl.gzszl007) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_gzszl.gzszl007,lc_gzszl.gzszl001,'','')
         END IF         
      END IF

   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 選單名稱 insert 到字典檔
# Memo...........:
# Usage..........: CALL azzp110_ins_gzwel_zhtw()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_ins_gzwel_zhtw()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_gzwel001 LIKE gzwel_t.gzwel001   #選單編號
   DEFINE lc_gzwel002 LIKE gzwel_t.gzwel002   #語言別
   DEFINE lc_gzwel003 LIKE gzwel_t.gzwel003   #選單名稱
   DEFINE lc_gzwel003_new LIKE gzwel_t.gzwel003   #選單名稱
   DEFINE lc_gzwelent LIKE gzwel_t.gzwelent   #企業編號
   DEFINE li_row      LIKE type_t.num10
   DEFINE li_zhtw     LIKE type_t.num5
   DEFINE lc_gzozcrtdt LIKE gzoz_t.gzozcrtdt
   DEFINE lc_gzwel    RECORD LIKE gzwel_t.*    
   DEFINE lc_msg      STRING
   
   
   LET ls_sql = "SELECT UNIQUE gzwel001,gzwelent FROM gzwel_t ",
                " WHERE (gzwel002 = 'zh_TW' OR gzwel002 = 'zh_CN') ",
                  " AND TRIM(gzwel003) IS NOT NULL "

   #如果有外傳參數的處理
   IF g_param.extra_condition IS NOT NULL THEN
      LET ls_sql = ls_sql," ",g_param.extra_condition
   END IF

   #排序
   LET ls_sql = ls_sql, "ORDER BY gzwelent,gzwel001 "

   #組合SQL
   DECLARE azzp110_gzwel_zhtw_cs CURSOR FROM ls_sql
   FOREACH azzp110_gzwel_zhtw_cs INTO lc_gzwel001,lc_gzwelent
       DISPLAY "insert from gzwel_t:",lc_gzwel001
       #先檢查簡繁是否都存在
       SELECT COUNT(*) INTO li_cnt FROM gzwel_t
        WHERE gzwelent = lc_gzwelent AND gzwel001 = lc_gzwel001
          AND (gzwel002 = 'zh_TW' OR gzwel002 = 'zh_CN')
          AND gzwel003 IS NOT NULL

      #簡繁只有一筆,若為繁體直接取,若為簡體先轉詞轉碼
      IF li_cnt = 1 THEN
         SELECT * INTO lc_gzwel.* FROM gzwel_t
          WHERE gzwelent = lc_gzwelent AND gzwel001 = lc_gzwel001
            AND (gzwel002 = 'zh_TW' OR gzwel002 = 'zh_CN')
            AND gzwel003 IS NOT NULL
                
         #若這唯一的一筆是簡體,就要先轉換為繁體寫回                
         IF lc_gzwel.gzwel002 = 'zh_CN' AND NOT cl_null(lc_gzwel.gzwel003) THEN
            #轉換該轉的 (此處cl_trans有先寫字典檔)
            LET lc_gzwel.gzwel002 = "zh_TW"          
            LET lc_gzwel003_new = cl_trans_code_tw_cn("zh_TW",lc_gzwel.gzwel003)
            IF g_bgjob= "Y" AND (cl_null(lc_gzwel003_new) AND NOT cl_null(lc_gzwel.gzwel003)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>gzwel_t</td>",                      #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_gzwel.gzwel001,"</td>",        #key值欄位1
                                          "<td class=xl24></td>",                             #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_gzwel.gzwel003,"</td>",        #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字    
                            "</tr>"
            
               CALL g_gen_ch.writeLine(lc_msg)
               
               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_gzwel.gzwel003 = lc_gzwel003_new

            #回寫
            INSERT INTO gzwel_t VALUES (lc_gzwel.*)

         END IF
      ELSE
         IF li_cnt = 2 THEN
           #簡繁有2筆時, 重抓資料
            SELECT * INTO lc_gzwel.* FROM gzwel_t
             WHERE gzwelent = lc_gzwelent AND gzwel001 = lc_gzwel001 AND gzwel002 = "zh_TW"
         END IF
      END IF
      
      IF li_cnt > 0 THEN
         #再檢查字典檔,遇缺則補入
         IF azzp110_chk_gzoy("gzwel_t",lc_gzwel.gzwel002,lc_gzwel.gzwel001,'','',lc_gzwel.gzwel003) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_gzwel.gzwel003,lc_gzwel.gzwel001,'','')
         END IF
      END IF

   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_ins_gzcal_zhtw()
#                  RETURNING 
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_ins_gzcal_zhtw()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_gzcal001 LIKE gzcal_t.gzcal001   #系統分類碼
   DEFINE lc_gzcal002 LIKE gzcal_t.gzcal002   #語言別
   DEFINE lc_gzcal003 LIKE gzcal_t.gzcal003   #說明
   DEFINE lc_gzcal003_new LIKE gzcal_t.gzcal003   #說明
   DEFINE li_row      LIKE type_t.num10
   DEFINE li_zhtw     LIKE type_t.num5
   DEFINE lc_gzozcrtdt LIKE gzoz_t.gzozcrtdt
   DEFINE lc_gzcal    RECORD LIKE gzcal_t.*    
   DEFINE lc_msg      STRING
   
   
   LET ls_sql = "SELECT UNIQUE gzcal001 FROM gzcal_t ",
                " WHERE (gzcal002 = 'zh_TW' OR gzcal002 = 'zh_CN') ",
                  " AND TRIM(gzcal003) IS NOT NULL "

   #如果有外傳參數的處理
   IF g_param.extra_condition IS NOT NULL THEN
      LET ls_sql = ls_sql," ",g_param.extra_condition
   END IF

   #排序
   LET ls_sql = ls_sql, "ORDER BY gzcal001 "

   #組合SQL
   DECLARE azzp110_gzcal_zhtw_cs CURSOR FROM ls_sql
   FOREACH azzp110_gzcal_zhtw_cs INTO lc_gzcal001
       DISPLAY "insert from gzcal_t:",lc_gzcal001
       #先檢查簡繁是否都存在
       SELECT COUNT(*) INTO li_cnt FROM gzcal_t
        WHERE gzcal001 = lc_gzcal001 AND (gzcal002 = 'zh_TW' OR gzcal002 = 'zh_CN')
          AND gzcal003 IS NOT NULL

      #簡繁只有一筆,若為繁體直接取,若為簡體先轉詞轉碼
      IF li_cnt = 1 THEN
         SELECT * INTO lc_gzcal.* FROM gzcal_t
          WHERE gzcal001 = lc_gzcal001 AND (gzcal002 = 'zh_TW' OR gzcal002 = 'zh_CN')
            AND gzcal003 IS NOT NULL
                
         #若這唯一的一筆是簡體,就要先轉換為繁體寫回                
         IF lc_gzcal.gzcal002 = 'zh_CN' AND NOT cl_null(lc_gzcal.gzcal003) THEN
            #轉換該轉的 (此處cl_trans有先寫字典檔)
            LET lc_gzcal.gzcal002 = "zh_TW"          
            LET lc_gzcal003_new = cl_trans_code_tw_cn("zh_TW",lc_gzcal.gzcal003)
            IF g_bgjob= "Y" AND (cl_null(lc_gzcal003_new) AND NOT cl_null(lc_gzcal.gzcal003)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>gzcal_t</td>",                      #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_gzcal.gzcal001,"</td>",        #key值欄位1
                                          "<td class=xl24></td>",                             #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_gzcal.gzcal003,"</td>",        #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字    
                            "</tr>"
            
               CALL g_gen_ch.writeLine(lc_msg)
               
               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_gzcal.gzcal003 = lc_gzcal003_new

            #回寫
            INSERT INTO gzcal_t VALUES (lc_gzcal.*)

         END IF
      ELSE
         IF li_cnt = 2 THEN
           #簡繁有2筆時, 重抓資料
            SELECT * INTO lc_gzcal.* FROM gzcal_t
             WHERE gzcal001 = lc_gzcal001 AND gzcal002 = "zh_TW"
         END IF
      END IF
      
      IF li_cnt > 0 THEN
         #再檢查字典檔,遇缺則補入
         IF azzp110_chk_gzoy("gzcal_t",lc_gzcal.gzcal002,lc_gzcal.gzcal001,'','',lc_gzcal.gzcal003) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_gzcal.gzcal003,lc_gzcal.gzcal001,'','')
         END IF
      END IF

   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_ins_gzcbl_zhtw()
#                  RETURNING 
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_ins_gzcbl_zhtw()
   DEFINE ls_sql       STRING
   DEFINE li_cnt       LIKE type_t.num10
   DEFINE li_cnt2      LIKE type_t.num10
   DEFINE lc_gzcbl001  LIKE gzcbl_t.gzcbl001 #系統分類碼
   DEFINE lc_gzcbl002  LIKE gzcbl_t.gzcbl002 #系統分類值
   DEFINE lc_gzcbl003  LIKE gzcbl_t.gzcbl003 #語言別
   DEFINE lc_gzcbl004  LIKE gzcbl_t.gzcbl004 #說明
   DEFINE lc_gzcbl006  LIKE gzcbl_t.gzcbl006 #應用說明
   DEFINE lc_gzcbl004_new  LIKE gzcbl_t.gzcbl004 #說明
   DEFINE lc_gzcbl006_new  LIKE gzcbl_t.gzcbl006 #應用說明
   DEFINE li_row       LIKE type_t.num10
   DEFINE li_zhtw      LIKE type_t.num5
   DEFINE lc_gzozcrtdt LIKE gzoz_t.gzozcrtdt
   DEFINE lc_gzcbl    RECORD LIKE gzcbl_t.*    
   DEFINE lc_msg      STRING
   
   
   LET ls_sql = "SELECT UNIQUE gzcbl001,gzcbl002 FROM gzcbl_t ",
                " WHERE (gzcbl003 = 'zh_TW' OR gzcbl003 = 'zh_CN') ",
                  " AND TRIM(gzcbl004) IS NOT NULL "

   #如果有外傳參數的處理
   IF g_param.extra_condition IS NOT NULL THEN
      LET ls_sql = ls_sql," ",g_param.extra_condition
   END IF

   #排序
   LET ls_sql = ls_sql, "ORDER BY gzcbl001,gzcbl002 "

   #組合SQL
   DECLARE azzp110_gzcbl_zhtw_cs CURSOR FROM ls_sql
   FOREACH azzp110_gzcbl_zhtw_cs INTO lc_gzcbl001,lc_gzcbl002
       DISPLAY "insert from gzcbl_t:",lc_gzcbl001
       #先檢查簡繁是否都存在
       SELECT COUNT(*) INTO li_cnt FROM gzcbl_t
        WHERE gzcbl001 = lc_gzcbl001 AND gzcbl002 = lc_gzcbl002
          AND (gzcbl003 = 'zh_TW' OR gzcbl003 = 'zh_CN')

      #簡繁只有一筆,若為繁體直接取,若為簡體先轉詞轉碼
      IF li_cnt = 1 THEN
         SELECT * INTO lc_gzcbl.* FROM gzcbl_t
          WHERE gzcbl001 = lc_gzcbl001 AND gzcbl002 = lc_gzcbl002
            AND (gzcbl003 = 'zh_TW' OR gzcbl003 = 'zh_CN')
                
         #若這唯一的一筆是簡體,就要先轉換為繁體寫回                
         IF lc_gzcbl.gzcbl003 = 'zh_CN' AND NOT cl_null(lc_gzcbl.gzcbl004) THEN
            #轉換該轉的 (此處cl_trans有先寫字典檔)
            LET lc_gzcbl.gzcbl003 = "zh_TW"          
            LET lc_gzcbl004_new = cl_trans_code_tw_cn("zh_TW",lc_gzcbl.gzcbl004)
            IF g_bgjob= "Y" AND (cl_null(lc_gzcbl004_new) AND NOT cl_null(lc_gzcbl.gzcbl004)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>gzcbl_t</td>",                      #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_gzcbl.gzcbl001,"</td>",        #key值欄位1
                                          "<td class=xl24>",lc_gzcbl.gzcbl002,"</td>",        #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_gzcbl.gzcbl004,"</td>",        #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字    
                            "</tr>"
            
               CALL g_gen_ch.writeLine(lc_msg)
               
               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_gzcbl.gzcbl004 = lc_gzcbl004_new
            
            LET lc_gzcbl006_new = cl_trans_code_tw_cn("zh_TW",lc_gzcbl.gzcbl006)
            IF g_bgjob= "Y" AND (cl_null(lc_gzcbl006_new) AND NOT cl_null(lc_gzcbl.gzcbl006)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>gzcbl_t</td>",                      #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_gzcbl.gzcbl001,"</td>",        #key值欄位1
                                          "<td class=xl24>",lc_gzcbl.gzcbl002,"</td>",        #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_gzcbl.gzcbl006,"</td>",        #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字    
                            "</tr>"
            
               CALL g_gen_ch.writeLine(lc_msg)
               
               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_gzcbl.gzcbl006 = lc_gzcbl006_new

            #回寫
            INSERT INTO gzcbl_t VALUES (lc_gzcbl.*)

         END IF
      ELSE
         IF li_cnt = 2 THEN
           #簡繁有2筆時, 重抓資料
            SELECT * INTO lc_gzcbl.* FROM gzcbl_t
             WHERE gzcbl001 = lc_gzcbl001 AND gzcbl002 = lc_gzcbl002 AND gzcbl003 = "zh_TW"
         END IF
      END IF
      
      IF li_cnt > 0 THEN
         #再檢查字典檔,遇缺則補入
         IF azzp110_chk_gzoy("gzcbl_t",lc_gzcbl.gzcbl003,lc_gzcbl.gzcbl001,lc_gzcbl.gzcbl002,'',lc_gzcbl.gzcbl004) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_gzcbl.gzcbl004,lc_gzcbl.gzcbl001,'','')
         END IF
         IF azzp110_chk_gzoy("gzcbl_t",lc_gzcbl.gzcbl003,lc_gzcbl.gzcbl001,lc_gzcbl.gzcbl002,'',lc_gzcbl.gzcbl006) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_gzcbl.gzcbl006,lc_gzcbl.gzcbl001,'','')
         END IF
      END IF

   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 報表樣板說明多語言檔(GR+XtraGrid)
# Memo...........:
# Usage..........: CALL azzp110_ins_gzgdl_zhtw()
#                  RETURNING
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_ins_gzgdl_zhtw()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_gzgdl000 LIKE gzgdl_t.gzgdl000   #報表樣板ID
   DEFINE lc_gzgdl001 LIKE gzgdl_t.gzgdl001   #語言別
   DEFINE lc_gzgdl002 LIKE gzgdl_t.gzgdl002   #樣板說明
   DEFINE lc_gzgdl002_new LIKE gzgdl_t.gzgdl002   #樣板說明
   DEFINE li_row      LIKE type_t.num10
   DEFINE li_zhtw     LIKE type_t.num5
   DEFINE lc_gzozcrtdt LIKE gzoz_t.gzozcrtdt
   DEFINE lc_gzgdl    RECORD LIKE gzgdl_t.*    
   DEFINE lc_msg      STRING
   
   
   LET ls_sql = "SELECT UNIQUE gzgdl000 FROM gzgdl_t ",
                " WHERE (gzgdl001 = 'zh_TW' OR gzgdl001 = 'zh_CN') ",
                  " AND TRIM(gzgdl002) IS NOT NULL "

   #如果有外傳參數的處理
   IF g_param.extra_condition IS NOT NULL THEN
      LET ls_sql = ls_sql," ",g_param.extra_condition
   END IF

   #排序
   LET ls_sql = ls_sql, "ORDER BY gzgdl000 "

   #組合SQL
   DECLARE azzp110_gzgdl_zhtw_cs CURSOR FROM ls_sql
   FOREACH azzp110_gzgdl_zhtw_cs INTO lc_gzgdl000
       DISPLAY "insert from gzgdl_t:",lc_gzgdl000
       #先檢查簡繁是否都存在
       SELECT COUNT(*) INTO li_cnt FROM gzgdl_t
        WHERE gzgdl000 = lc_gzgdl000 AND (gzgdl001 = 'zh_TW' OR gzgdl001 = 'zh_CN')
          AND gzgdl002 IS NOT NULL

      #簡繁只有一筆,若為繁體直接取,若為簡體先轉詞轉碼
      IF li_cnt = 1 THEN
         SELECT * INTO lc_gzgdl.* FROM gzgdl_t
          WHERE gzgdl000 = lc_gzgdl000 AND (gzgdl001 = 'zh_TW' OR gzgdl001 = 'zh_CN')
            AND gzgdl002 IS NOT NULL
                
         #若這唯一的一筆是簡體,就要先轉換為繁體寫回                
         IF lc_gzgdl.gzgdl001 = 'zh_CN' AND NOT cl_null(lc_gzgdl.gzgdl002) THEN
            #轉換該轉的 (此處cl_trans有先寫字典檔)
            LET lc_gzgdl.gzgdl001 = "zh_TW"          
            LET lc_gzgdl002_new = cl_trans_code_tw_cn("zh_TW",lc_gzgdl.gzgdl002)
            IF g_bgjob= "Y" AND (cl_null(lc_gzgdl002_new) AND NOT cl_null(lc_gzgdl.gzgdl002)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>gzgdl_t</td>",                      #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_gzgdl.gzgdl000,"</td>",        #key值欄位1
                                          "<td class=xl24></td>",                             #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_gzgdl.gzgdl002,"</td>",        #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字    
                            "</tr>"
            
               CALL g_gen_ch.writeLine(lc_msg)
               
               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_gzgdl.gzgdl002 = lc_gzgdl002_new

            #回寫
            INSERT INTO gzgdl_t VALUES (lc_gzgdl.*)

         END IF
      ELSE
         IF li_cnt = 2 THEN
           #簡繁有2筆時, 重抓資料
            SELECT * INTO lc_gzgdl.* FROM gzgdl_t
             WHERE gzgdl000 = lc_gzgdl000 AND gzgdl001 = "zh_TW"
         END IF
      END IF
      
      IF li_cnt > 0 THEN
         #再檢查字典檔,遇缺則補入
         IF azzp110_chk_gzoy("gzgdl_t",lc_gzgdl.gzgdl001,lc_gzgdl.gzgdl000,'','',lc_gzgdl.gzgdl002) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_gzgdl.gzgdl002,lc_gzgdl.gzgdl000,'','')
         END IF
      END IF

   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 報表樣板多語言紀錄檔(GR+XtraGrid)
# Memo...........:
# Usage..........: CALL azzp110_ins_gzge_zhtw()
#                  RETURNING 
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_ins_gzge_zhtw()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_gzge000  LIKE gzge_t.gzge000     #報表樣板ID
   DEFINE lc_gzge001  LIKE gzge_t.gzge001     #報表欄位代碼
   DEFINE lc_gzge002  LIKE gzge_t.gzge002     #語言別
   DEFINE lc_gzge003  LIKE gzge_t.gzge003     #說明
   DEFINE lc_gzge003_new  LIKE gzge_t.gzge003     #說明
   DEFINE li_row      LIKE type_t.num10
   DEFINE li_zhtw     LIKE type_t.num5
   DEFINE lc_gzozcrtdt LIKE gzoz_t.gzozcrtdt
   DEFINE lc_gzge    RECORD LIKE gzge_t.*    
   DEFINE lc_msg      STRING
   
   
   LET ls_sql = "SELECT UNIQUE gzge000,gzge001 FROM gzge_t ",
                " WHERE (gzge002 = 'zh_TW' OR gzge002 = 'zh_CN') ",
                  " AND TRIM(gzge003) IS NOT NULL ",
                  " AND NOT gzge001 like 'ait%' "  #額外條件

   #如果有外傳參數的處理
   IF g_param.extra_condition IS NOT NULL THEN
      LET ls_sql = ls_sql," ",g_param.extra_condition
   END IF

   #排序
   LET ls_sql = ls_sql, "ORDER BY gzge000,gzge001 "

   #組合SQL
   DECLARE azzp110_gzge_zhtw_cs CURSOR FROM ls_sql
   FOREACH azzp110_gzge_zhtw_cs INTO lc_gzge000,lc_gzge001
       DISPLAY "insert from gzge_t:",lc_gzge001
       #先檢查簡繁是否都存在
       SELECT COUNT(*) INTO li_cnt FROM gzge_t
        WHERE gzge000 = lc_gzge000 AND gzge001 = lc_gzge001
          AND (gzge002 = 'zh_TW' OR gzge002 = 'zh_CN')
          AND gzge003 IS NOT NULL

      #簡繁只有一筆,若為繁體直接取,若為簡體先轉詞轉碼
      IF li_cnt = 1 THEN
         SELECT * INTO lc_gzge.* FROM gzge_t
          WHERE gzge000 = lc_gzge000 AND gzge001 = lc_gzge001
            AND (gzge002 = 'zh_TW' OR gzge002 = 'zh_CN')
            AND gzge003 IS NOT NULL
                
         #若這唯一的一筆是簡體,就要先轉換為繁體寫回                
         IF lc_gzge.gzge002 = 'zh_CN' AND NOT cl_null(lc_gzge.gzge003) THEN
            #轉換該轉的 (此處cl_trans有先寫字典檔)
            LET lc_gzge.gzge002 = "zh_TW"          
            LET lc_gzge003_new = cl_trans_code_tw_cn("zh_TW",lc_gzge.gzge003)
            IF g_bgjob= "Y" AND (cl_null(lc_gzge003_new) AND NOT cl_null(lc_gzge.gzge003)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>gzge_t</td>",                       #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_gzge.gzge000,"</td>",          #key值欄位1
                                          "<td class=xl24>",lc_gzge.gzge001,"</td>",          #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_gzge.gzge003,"</td>",          #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字    
                            "</tr>"
            
               CALL g_gen_ch.writeLine(lc_msg)
               
               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_gzge.gzge003 = lc_gzge003_new

            #回寫
            INSERT INTO gzge_t VALUES (lc_gzge.*)

         END IF
      ELSE
         IF li_cnt = 2 THEN
           #簡繁有2筆時, 重抓資料
            SELECT * INTO lc_gzge.* FROM gzge_t
             WHERE gzge000 = lc_gzge000 AND gzge001 = lc_gzge001 AND gzge002 = "zh_TW"
         END IF
      END IF
      
      IF li_cnt > 0 THEN
         #再檢查字典檔,遇缺則補入
         IF azzp110_chk_gzoy("gzge_t",lc_gzge.gzge002,lc_gzge.gzge000,lc_gzge.gzge001,'',lc_gzge.gzge003) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_gzge.gzge003,lc_gzge.gzge000,lc_gzge.gzgecrtid,lc_gzge.gzgecrtdp)
         END IF
      END IF

   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_ins_dzcal_zhtw()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_ins_dzcal_zhtw()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_dzcal001 LIKE dzcal_t.dzcal001   
   DEFINE li_row      LIKE type_t.num10
   DEFINE li_zhtw     LIKE type_t.num5
   DEFINE lc_dzcal002 LIKE dzcal_t.dzcal002  
   DEFINE lc_dzcal003 LIKE dzcal_t.dzcal003
   DEFINE lc_dzcal003_new LIKE dzcal_t.dzcal003    
   DEFINE lc_gzozcrtdt LIKE gzoz_t.gzozcrtdt
   DEFINE lc_dzcal    RECORD LIKE dzcal_t.*    
   DEFINE lc_msg      STRING
   

   LET ls_sql = "SELECT UNIQUE dzcal001 FROM dzcal_t ",
                " WHERE (dzcal002 = 'zh_TW' OR dzcal002 = 'zh_CN') ",
                  " AND TRIM(dzcal003) IS NOT NULL "

   #如果有外傳參數的處理
   IF g_param.extra_condition IS NOT NULL THEN
      LET ls_sql = ls_sql," ",g_param.extra_condition
   END IF

   #排序
   LET ls_sql = ls_sql, "ORDER BY dzcal001 "

   #組合SQL
   DECLARE azzp110_dzcal_zhtw_cs CURSOR FROM ls_sql
   FOREACH azzp110_dzcal_zhtw_cs INTO lc_dzcal001
       DISPLAY "insert from dzcal_t:",lc_dzcal001
       #先檢查簡繁是否都存在
       SELECT COUNT(*) INTO li_cnt FROM dzcal_t
        WHERE dzcal001 = lc_dzcal001 AND (dzcal002 = 'zh_TW' OR dzcal002 = 'zh_CN')
          AND dzcal003 IS NOT NULL

      #簡繁只有一筆,若為繁體直接取,若為簡體先轉詞轉碼
      IF li_cnt = 1 THEN
         SELECT * INTO lc_dzcal.* FROM dzcal_t
          WHERE dzcal001 = lc_dzcal001 AND (dzcal002 = 'zh_TW' OR dzcal002 = 'zh_CN')
            AND dzcal003 IS NOT NULL

         #若這唯一的一筆是簡體,就要先轉換為繁體寫回
         IF lc_dzcal.dzcal002 = 'zh_CN' AND NOT cl_null(lc_dzcal.dzcal003) THEN
            #轉換該轉的 (此處cl_trans有先寫字典檔)
            LET lc_dzcal.dzcal002 = "zh_TW"          
            LET lc_dzcal003_new = cl_trans_code_tw_cn("zh_TW",lc_dzcal.dzcal003)
            IF g_bgjob= "Y" AND (cl_null(lc_dzcal003_new) AND NOT cl_null(lc_dzcal.dzcal003)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>dzcal_t</td>",                      #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_dzcal.dzcal001,"</td>",        #key值欄位1
                                          "<td class=xl24></td>",                             #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_dzcal.dzcal003,"</td>",        #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字    
                            "</tr>"
            
               CALL g_gen_ch.writeLine(lc_msg)
               
               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_dzcal.dzcal003 = lc_dzcal003_new
                
            #回寫
            INSERT INTO dzcal_t VALUES (lc_dzcal.*)

         END IF
      ELSE
         IF li_cnt = 2 THEN
           #簡繁有2筆時, 重抓資料
            SELECT * INTO lc_dzcal.* FROM dzcal_t
              WHERE dzcal001 = lc_dzcal001 AND dzcal002 = "zh_TW"
         END IF
      END IF
      
      IF li_cnt > 0 THEN
         #再檢查字典檔,遇缺則補入
         IF azzp110_chk_gzoy("dzcal_t",lc_dzcal.dzcal002,lc_dzcal.dzcal001,'','',lc_dzcal.dzcal003) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_dzcal.dzcal003,lc_dzcal.dzcal001,'','')
         END IF
      END IF

   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_ins_dzcdl_zhtw()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_ins_dzcdl_zhtw()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_dzcdl001 LIKE dzcdl_t.dzcdl001   #表格編號
   DEFINE li_row      LIKE type_t.num10
   DEFINE li_zhtw     LIKE type_t.num5
   DEFINE lc_dzcdl002 LIKE dzcdl_t.dzcdl002  
   DEFINE lc_dzcdl003 LIKE dzcdl_t.dzcdl003
   DEFINE lc_dzcdl003_new LIKE dzcdl_t.dzcdl003   
   DEFINE lc_gzozcrtdt LIKE gzoz_t.gzozcrtdt
   DEFINE lc_dzcdl    RECORD LIKE dzcdl_t.*    
   DEFINE lc_msg      STRING
   
   
   LET ls_sql = "SELECT UNIQUE dzcdl001 FROM dzcdl_t ",
                " WHERE (dzcdl002 = 'zh_TW' OR dzcdl002 = 'zh_CN') ",
                  " AND TRIM(dzcdl003) IS NOT NULL "

   #如果有外傳參數的處理
   IF g_param.extra_condition IS NOT NULL THEN
      LET ls_sql = ls_sql," ",g_param.extra_condition
   END IF

   #排序
   LET ls_sql = ls_sql, "ORDER BY dzcdl001 "

   #組合SQL
   DECLARE azzp110_dzcdl_zhtw_cs CURSOR FROM ls_sql
   FOREACH azzp110_dzcdl_zhtw_cs INTO lc_dzcdl001
       DISPLAY "insert from dzcdl_t:",lc_dzcdl001
       #先檢查簡繁是否都存在
       SELECT COUNT(*) INTO li_cnt FROM dzcdl_t
        WHERE dzcdl001 = lc_dzcdl001 AND (dzcdl002 = 'zh_TW' OR dzcdl002 = 'zh_CN')
          AND dzcdl003 IS NOT NULL

      #簡繁只有一筆,若為繁體直接取,若為簡體先轉詞轉碼
      IF li_cnt = 1 THEN
         SELECT * INTO lc_dzcdl.* FROM dzcdl_t
          WHERE dzcdl001 = lc_dzcdl001 AND (dzcdl002 = 'zh_TW' OR dzcdl002 = 'zh_CN')
            AND dzcdl003 IS NOT NULL
          
         #若這唯一的一筆是簡體,就要先轉換為繁體寫回
         IF lc_dzcdl.dzcdl002 = 'zh_CN' AND NOT cl_null(lc_dzcdl.dzcdl003) THEN
            #轉換該轉的 (此處cl_trans有先寫字典檔)
            LET lc_dzcdl.dzcdl002 = "zh_TW"          
            LET lc_dzcdl003_new = cl_trans_code_tw_cn("zh_TW",lc_dzcdl.dzcdl003)
            IF g_bgjob= "Y" AND (cl_null(lc_dzcdl003_new) AND NOT cl_null(lc_dzcdl.dzcdl003)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>dzcdl_t</td>",                      #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_dzcdl.dzcdl001,"</td>",        #key值欄位1
                                          "<td class=xl24></td>",                             #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_dzcdl.dzcdl003,"</td>",        #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字    
                            "</tr>"
            
               CALL g_gen_ch.writeLine(lc_msg)
               
               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_dzcdl.dzcdl003 = lc_dzcdl003_new
                
            #回寫
            INSERT INTO dzcdl_t VALUES (lc_dzcdl.*)

         END IF
      ELSE
         IF li_cnt = 2 THEN
           #簡繁有2筆時, 重抓資料
            SELECT * INTO lc_dzcdl.* FROM dzcdl_t
             WHERE dzcdl001 = lc_dzcdl001 AND dzcdl002 = "zh_TW"
         END IF
      END IF
      
      IF li_cnt > 0 THEN
         #再檢查字典檔,遇缺則補入
         IF azzp110_chk_gzoy("dzcdl_t",lc_dzcdl.dzcdl002,lc_dzcdl.dzcdl001,'','',lc_dzcdl.dzcdl003) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_dzcdl.dzcdl003,lc_dzcdl.dzcdl001,'','')
         END IF
      END IF

   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_ins_dzcbl_zhtw()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 2015/04/27 By jrg542
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_ins_dzcbl_zhtw()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_dzcbl001 LIKE dzcbl_t.dzcbl001   #
   DEFINE lc_dzcbl002 LIKE dzcbl_t.dzcbl002   #
   DEFINE lc_dzcbl003 LIKE dzcbl_t.dzcbl003   #
   DEFINE lc_dzcbl004 LIKE dzcbl_t.dzcbl004   #
   DEFINE lc_dzcbl004_new LIKE dzcbl_t.dzcbl004   #
   DEFINE li_row      LIKE type_t.num10
   DEFINE li_zhtw     LIKE type_t.num5
   DEFINE lc_gzozcrtdt LIKE gzoz_t.gzozcrtdt
   DEFINE lc_dzcbl    RECORD LIKE dzcbl_t.*    
   DEFINE lc_msg      STRING
   
   
   LET ls_sql = "SELECT UNIQUE dzcbl001,dzcbl002 FROM dzcbl_t ",
                " WHERE (dzcbl003 = 'zh_TW' OR dzcbl003 = 'zh_CN') ",
                  " AND TRIM(dzcbl004) IS NOT NULL  "

   #如果有外傳參數的處理
   IF g_param.extra_condition IS NOT NULL THEN
      LET ls_sql = ls_sql," ",g_param.extra_condition
   END IF

   #排序
   LET ls_sql = ls_sql, "ORDER BY dzcbl001 "

   #組合SQL
   DECLARE azzp110_dzcbl_zhtw_cs CURSOR FROM ls_sql
   FOREACH azzp110_dzcbl_zhtw_cs INTO lc_dzcbl001,lc_dzcbl002
       DISPLAY "insert from dzcbl_t:",lc_dzcbl001
       #先檢查簡繁是否都存在
       SELECT COUNT(*) INTO li_cnt FROM dzcbl_t
        WHERE dzcbl001 = lc_dzcbl001 AND dzcbl002 = lc_dzcbl002 AND (dzcbl003 = 'zh_TW' OR dzcbl003 = 'zh_CN')
          AND dzcbl004 IS NOT NULL

      #簡繁只有一筆,若為繁體直接取,若為簡體先轉詞轉碼
      IF li_cnt = 1 THEN
         SELECT * INTO lc_dzcbl.* FROM dzcbl_t
          WHERE dzcbl001 = lc_dzcbl001 AND dzcbl002 = lc_dzcbl002 
            AND (dzcbl003 = 'zh_TW' OR dzcbl003 = 'zh_CN')
            AND dzcbl004 IS NOT NULL
                
         #若這唯一的一筆是簡體,就要先轉換為繁體寫回                
         IF lc_dzcbl.dzcbl003 = 'zh_CN' AND NOT cl_null(lc_dzcbl.dzcbl004) THEN
            #轉換該轉的 (此處cl_trans有先寫字典檔)
            LET lc_dzcbl.dzcbl003 = "zh_TW"          
            LET lc_dzcbl004_new = cl_trans_code_tw_cn("zh_TW",lc_dzcbl.dzcbl004)
            IF g_bgjob= "Y" AND (cl_null(lc_dzcbl004_new) AND NOT cl_null(lc_dzcbl.dzcbl004)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>dzcbl_t</td>",                      #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_dzcbl.dzcbl001,"</td>",        #key值欄位1
                                          "<td class=xl24>",lc_dzcbl.dzcbl002,"</td>",        #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_dzcbl.dzcbl004,"</td>",        #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字    
                            "</tr>"
            
               CALL g_gen_ch.writeLine(lc_msg)
               
               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_dzcbl.dzcbl004 = lc_dzcbl004_new

            #回寫
            INSERT INTO dzcbl_t VALUES (lc_dzcbl.*)

         END IF
      ELSE
         IF li_cnt = 2 THEN
           #簡繁有2筆時, 重抓資料
            SELECT * INTO lc_dzcbl.* FROM dzcbl_t
             WHERE dzcbl001 = lc_dzcbl001 AND dzcbl002 = lc_dzcbl002 AND dzcbl003 = "zh_TW"
         END IF
      END IF
      
      IF li_cnt > 0 THEN
         #再檢查字典檔,遇缺則補入
         IF azzp110_chk_gzoy("dzcbl_t",lc_dzcbl.dzcbl003,lc_dzcbl.dzcbl001,lc_dzcbl.dzcbl002,'',lc_dzcbl.dzcbl004) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_dzcbl.dzcbl004,lc_dzcbl.dzcbl001,'','')
         END IF
      END IF

   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_ins_dzcel_zhtw()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_ins_dzcel_zhtw()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_dzcel001 LIKE dzcel_t.dzcel001   #
   DEFINE lc_dzcel002 LIKE dzcel_t.dzcel002   #
   DEFINE lc_dzcel003 LIKE dzcel_t.dzcel003   #
   DEFINE lc_dzcel004 LIKE dzcel_t.dzcel004   #
   DEFINE lc_dzcel004_new LIKE dzcel_t.dzcel004   #
   DEFINE li_row      LIKE type_t.num10
   DEFINE li_zhtw     LIKE type_t.num5
   DEFINE lc_gzozcrtdt LIKE gzoz_t.gzozcrtdt
   DEFINE lc_dzcel    RECORD LIKE dzcel_t.*    
   DEFINE lc_msg      STRING
   
   
   LET ls_sql = "SELECT UNIQUE dzcel001,dzcel002 FROM dzcel_t ",
                " WHERE (dzcel003 = 'zh_TW' OR dzcel003 = 'zh_CN') ",
                  " AND TRIM(dzcel004) IS NOT NULL  "

   #如果有外傳參數的處理
   IF g_param.extra_condition IS NOT NULL THEN
      LET ls_sql = ls_sql," ",g_param.extra_condition
   END IF

   #排序
   LET ls_sql = ls_sql, "ORDER BY dzcel001 "

   #組合SQL
   DECLARE azzp110_dzcel_zhtw_cs CURSOR FROM ls_sql
   FOREACH azzp110_dzcel_zhtw_cs INTO lc_dzcel001,lc_dzcel002
       DISPLAY "insert from dzcel_t:",lc_dzcel001
       #先檢查簡繁是否都存在
       SELECT COUNT(*) INTO li_cnt FROM dzcel_t
        WHERE dzcel001 = lc_dzcel001 AND dzcel002 = lc_dzcel002 AND (dzcel003 = 'zh_TW' OR dzcel003 = 'zh_CN')
          AND dzcel004 IS NOT NULL

      #簡繁只有一筆,若為繁體直接取,若為簡體先轉詞轉碼
      IF li_cnt = 1 THEN
         SELECT * INTO lc_dzcel.* FROM dzcel_t
          WHERE dzcel001 = lc_dzcel001 AND dzcel002 = lc_dzcel002
            AND (dzcel003 = 'zh_TW' OR dzcel003 = 'zh_CN')
            AND dzcel004 IS NOT NULL
                
         #若這唯一的一筆是簡體,就要先轉換為繁體寫回                
         IF lc_dzcel.dzcel003 = 'zh_CN' AND NOT cl_null(lc_dzcel.dzcel004) THEN
            #轉換該轉的 (此處cl_trans有先寫字典檔)
            LET lc_dzcel.dzcel003 = "zh_TW"          
            LET lc_dzcel004_new = cl_trans_code_tw_cn("zh_TW",lc_dzcel.dzcel004)
            IF g_bgjob= "Y" AND (cl_null(lc_dzcel004_new) AND NOT cl_null(lc_dzcel.dzcel004)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>dzcel_t</td>",                      #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_dzcel.dzcel001,"</td>",        #key值欄位1
                                          "<td class=xl24>",lc_dzcel.dzcel002,"</td>",        #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_dzcel.dzcel004,"</td>",        #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字    
                            "</tr>"
            
               CALL g_gen_ch.writeLine(lc_msg)
               
               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_dzcel.dzcel004 = lc_dzcel004_new

            #回寫
            INSERT INTO dzcel_t VALUES (lc_dzcel.*)

         END IF
      ELSE
         IF li_cnt = 2 THEN
           #簡繁有2筆時, 重抓資料
            SELECT * INTO lc_dzcel.* FROM dzcel_t
             WHERE dzcel001 = lc_dzcel001 AND dzcel002 = lc_dzcel002 AND dzcel003 = "zh_TW"
         END IF
      END IF
      
      IF li_cnt > 0 THEN
         #再檢查字典檔,遇缺則補入
         IF azzp110_chk_gzoy("dzcel_t",lc_dzcel.dzcel003,lc_dzcel.dzcel001,lc_dzcel.dzcel002,'',lc_dzcel.dzcel004) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_dzcel.dzcel004,lc_dzcel.dzcel001,'','')
         END IF
      END IF

   END FOREACH 
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
PRIVATE FUNCTION azzp110_ins_gzac_zhtw()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE li_cnt2     LIKE type_t.num10
   DEFINE lc_gzac001  LIKE gzac_t.gzac001 #ACC編號
   DEFINE lc_gzac002  LIKE gzac_t.gzac002 #語言別
   DEFINE lc_gzac003  LIKE gzac_t.gzac003 #
   DEFINE lc_gzac004  LIKE gzac_t.gzac004 #
   DEFINE lc_gzac005  LIKE gzac_t.gzac005 #
   DEFINE lc_gzac006  LIKE gzac_t.gzac006 #
   DEFINE lc_gzac007  LIKE gzac_t.gzac007 #
   DEFINE lc_gzac008  LIKE gzac_t.gzac008 #
   DEFINE lc_gzac009  LIKE gzac_t.gzac009 #
   DEFINE lc_gzac010  LIKE gzac_t.gzac010 #
   DEFINE lc_gzac011  LIKE gzac_t.gzac011 #
   DEFINE lc_gzac012  LIKE gzac_t.gzac012 #
   DEFINE lc_gzac013  LIKE gzac_t.gzac013 #
   DEFINE lc_gzac014  LIKE gzac_t.gzac014 #
   DEFINE lc_gzac015  LIKE gzac_t.gzac015 #
   DEFINE lc_gzac016  LIKE gzac_t.gzac016 #
   DEFINE lc_gzac017  LIKE gzac_t.gzac017 #
   DEFINE lc_gzac018  LIKE gzac_t.gzac018 #
   DEFINE lc_gzac019  LIKE gzac_t.gzac019 #
   DEFINE lc_gzac020  LIKE gzac_t.gzac020 #
   DEFINE lc_gzac021  LIKE gzac_t.gzac021 #
   DEFINE lc_gzac022  LIKE gzac_t.gzac022 #
   DEFINE lc_gzac023  LIKE gzac_t.gzac023 #
   DEFINE lc_gzac003_new  LIKE gzac_t.gzac003 #
   DEFINE lc_gzac004_new  LIKE gzac_t.gzac004 #
   DEFINE lc_gzac005_new  LIKE gzac_t.gzac005 #
   DEFINE lc_gzac006_new  LIKE gzac_t.gzac006 #
   DEFINE lc_gzac007_new  LIKE gzac_t.gzac007 #
   DEFINE lc_gzac008_new  LIKE gzac_t.gzac008 #
   DEFINE lc_gzac009_new  LIKE gzac_t.gzac009 #
   DEFINE lc_gzac010_new  LIKE gzac_t.gzac010 #
   DEFINE lc_gzac011_new  LIKE gzac_t.gzac011 #
   DEFINE lc_gzac012_new  LIKE gzac_t.gzac012 #
   DEFINE lc_gzac013_new  LIKE gzac_t.gzac013 #
   DEFINE lc_gzac014_new  LIKE gzac_t.gzac014 #
   DEFINE lc_gzac015_new  LIKE gzac_t.gzac015 #
   DEFINE lc_gzac016_new  LIKE gzac_t.gzac016 #
   DEFINE lc_gzac017_new  LIKE gzac_t.gzac017 #
   DEFINE lc_gzac018_new  LIKE gzac_t.gzac018 #
   DEFINE lc_gzac019_new  LIKE gzac_t.gzac019 #
   DEFINE lc_gzac020_new  LIKE gzac_t.gzac020 #
   DEFINE lc_gzac021_new  LIKE gzac_t.gzac021 #
   DEFINE lc_gzac022_new  LIKE gzac_t.gzac022 #
   DEFINE lc_gzac023_new  LIKE gzac_t.gzac023 #    
   DEFINE li_row      LIKE type_t.num10
   DEFINE li_zhtw     LIKE type_t.num5
   DEFINE lc_gzozcrtdt LIKE gzoz_t.gzozcrtdt
   DEFINE lc_gzac001_2 LIKE gzac_t.gzac001   #程式編號
   DEFINE lc_gzac    RECORD LIKE gzac_t.*    
   DEFINE lc_msg      STRING
   
   
   LET ls_sql = "SELECT UNIQUE gzac001 FROM gzac_t ",
                " WHERE (gzac002 = 'zh_TW' OR gzac002 = 'zh_CN') ",
                  " AND TRIM(gzac023) IS NOT NULL "

   #如果有外傳參數的處理
   IF g_param.extra_condition IS NOT NULL THEN
      LET ls_sql = ls_sql," ",g_param.extra_condition
   END IF

   #排序
   LET ls_sql = ls_sql, "ORDER BY gzac001 "

   #組合SQL
   DECLARE azzp110_gzac_zhtw_cs CURSOR FROM ls_sql
   FOREACH azzp110_gzac_zhtw_cs INTO lc_gzac001
       DISPLAY "insert from gzac_t:",lc_gzac001
       #先檢查簡繁是否都存在
       SELECT COUNT(*) INTO li_cnt FROM gzac_t
        WHERE gzac001 = lc_gzac001
          AND (gzac002 = 'zh_TW' OR gzac002 = 'zh_CN')

      #簡繁只有一筆,若為繁體直接取,若為簡體先轉詞轉碼
      IF li_cnt = 1 THEN
         SELECT * INTO lc_gzac.* FROM gzac_t
          WHERE gzac001 = lc_gzac001
            AND (gzac002 = 'zh_TW' OR gzac002 = 'zh_CN')
                
         #若這唯一的一筆是簡體,就要先轉換為繁體寫回                
         IF lc_gzac.gzac002 = 'zh_CN' AND NOT cl_null(lc_gzac.gzac023) THEN
            #轉換該轉的 (此處cl_trans有先寫字典檔)
            LET lc_gzac.gzac002 = "zh_TW"          
            LET lc_gzac003_new = cl_trans_code_tw_cn("zh_TW",lc_gzac.gzac003)
            IF g_bgjob= "Y" AND (cl_null(lc_gzac003_new) AND NOT cl_null(lc_gzac.gzac003)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>gzac_t</td>",                       #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_gzac.gzac001,"</td>",          #key值欄位1
                                          "<td class=xl24></td>",                             #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_gzac.gzac003,"</td>",          #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字    
                            "</tr>"
            
               CALL g_gen_ch.writeLine(lc_msg)
               
               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_gzac.gzac003 = lc_gzac003_new
            
            LET lc_gzac004_new = cl_trans_code_tw_cn("zh_TW",lc_gzac.gzac004)
            IF g_bgjob= "Y" AND (cl_null(lc_gzac004_new) AND NOT cl_null(lc_gzac.gzac004)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>gzac_t</td>",                       #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_gzac.gzac001,"</td>",          #key值欄位1
                                          "<td class=xl24></td>",                             #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_gzac.gzac004,"</td>",          #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字    
                            "</tr>"
            
               CALL g_gen_ch.writeLine(lc_msg)
               
               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_gzac.gzac004 = lc_gzac004_new
            
            LET lc_gzac005_new = cl_trans_code_tw_cn("zh_TW",lc_gzac.gzac005)
            IF g_bgjob= "Y" AND (cl_null(lc_gzac005_new) AND NOT cl_null(lc_gzac.gzac005)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>gzac_t</td>",                       #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_gzac.gzac001,"</td>",          #key值欄位1
                                          "<td class=xl24></td>",                             #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_gzac.gzac005,"</td>",          #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字    
                            "</tr>"
            
               CALL g_gen_ch.writeLine(lc_msg)
               
               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_gzac.gzac005 = lc_gzac005_new
            
            LET lc_gzac006_new = cl_trans_code_tw_cn("zh_TW",lc_gzac.gzac006)
            IF g_bgjob= "Y" AND (cl_null(lc_gzac006_new) AND NOT cl_null(lc_gzac.gzac006)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>gzac_t</td>",                       #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_gzac.gzac001,"</td>",          #key值欄位1
                                          "<td class=xl24></td>",                             #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_gzac.gzac006,"</td>",          #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字    
                            "</tr>"
            
               CALL g_gen_ch.writeLine(lc_msg)
               
               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_gzac.gzac006 = lc_gzac006_new
            
            LET lc_gzac007_new = cl_trans_code_tw_cn("zh_TW",lc_gzac.gzac007)
            IF g_bgjob= "Y" AND (cl_null(lc_gzac007_new) AND NOT cl_null(lc_gzac.gzac007)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>gzac_t</td>",                       #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_gzac.gzac001,"</td>",          #key值欄位1
                                          "<td class=xl24></td>",                             #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_gzac.gzac007,"</td>",          #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字    
                            "</tr>"
            
               CALL g_gen_ch.writeLine(lc_msg)
               
               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_gzac.gzac007 = lc_gzac007_new
            
            LET lc_gzac008_new = cl_trans_code_tw_cn("zh_TW",lc_gzac.gzac008)
            IF g_bgjob= "Y" AND (cl_null(lc_gzac008_new) AND NOT cl_null(lc_gzac.gzac008)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>gzac_t</td>",                       #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_gzac.gzac001,"</td>",          #key值欄位1
                                          "<td class=xl24></td>",                             #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_gzac.gzac008,"</td>",          #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字    
                            "</tr>"
            
               CALL g_gen_ch.writeLine(lc_msg)
               
               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_gzac.gzac008 = lc_gzac008_new
            
            LET lc_gzac009_new = cl_trans_code_tw_cn("zh_TW",lc_gzac.gzac009)
            IF g_bgjob= "Y" AND (cl_null(lc_gzac009_new) AND NOT cl_null(lc_gzac.gzac009)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>gzac_t</td>",                       #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_gzac.gzac001,"</td>",          #key值欄位1
                                          "<td class=xl24></td>",                             #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_gzac.gzac009,"</td>",          #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字    
                            "</tr>"
            
               CALL g_gen_ch.writeLine(lc_msg)
               
               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_gzac.gzac009 = lc_gzac009_new
            
            LET lc_gzac010_new = cl_trans_code_tw_cn("zh_TW",lc_gzac.gzac010)
            IF g_bgjob= "Y" AND (cl_null(lc_gzac010_new) AND NOT cl_null(lc_gzac.gzac010)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>gzac_t</td>",                       #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_gzac.gzac001,"</td>",          #key值欄位1
                                          "<td class=xl24></td>",                             #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_gzac.gzac010,"</td>",          #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字    
                            "</tr>"
            
               CALL g_gen_ch.writeLine(lc_msg)
               
               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_gzac.gzac010 = lc_gzac010_new
            
            LET lc_gzac011_new = cl_trans_code_tw_cn("zh_TW",lc_gzac.gzac011)
            IF g_bgjob= "Y" AND (cl_null(lc_gzac011_new) AND NOT cl_null(lc_gzac.gzac011)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>gzac_t</td>",                       #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_gzac.gzac001,"</td>",          #key值欄位1
                                          "<td class=xl24></td>",                             #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_gzac.gzac011,"</td>",          #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字    
                            "</tr>"
            
               CALL g_gen_ch.writeLine(lc_msg)
               
               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_gzac.gzac011 = lc_gzac011_new
            
            LET lc_gzac012_new = cl_trans_code_tw_cn("zh_TW",lc_gzac.gzac012)
            IF g_bgjob= "Y" AND (cl_null(lc_gzac012_new) AND NOT cl_null(lc_gzac.gzac012)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>gzac_t</td>",                       #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_gzac.gzac001,"</td>",          #key值欄位1
                                          "<td class=xl24></td>",                             #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_gzac.gzac012,"</td>",          #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字    
                            "</tr>"
            
               CALL g_gen_ch.writeLine(lc_msg)
               
               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_gzac.gzac012 = lc_gzac012_new
            
            LET lc_gzac013_new = cl_trans_code_tw_cn("zh_TW",lc_gzac.gzac013)
            IF g_bgjob= "Y" AND (cl_null(lc_gzac013_new) AND NOT cl_null(lc_gzac.gzac013)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>gzac_t</td>",                       #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_gzac.gzac001,"</td>",          #key值欄位1
                                          "<td class=xl24></td>",                             #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_gzac.gzac013,"</td>",          #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字    
                            "</tr>"
            
               CALL g_gen_ch.writeLine(lc_msg)
               
               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_gzac.gzac013 = lc_gzac013_new
            
            LET lc_gzac014_new = cl_trans_code_tw_cn("zh_TW",lc_gzac.gzac014)
            IF g_bgjob= "Y" AND (cl_null(lc_gzac014_new) AND NOT cl_null(lc_gzac.gzac014)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>gzac_t</td>",                       #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_gzac.gzac001,"</td>",          #key值欄位1
                                          "<td class=xl24></td>",                             #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_gzac.gzac014,"</td>",          #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字    
                            "</tr>"
            
               CALL g_gen_ch.writeLine(lc_msg)
               
               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_gzac.gzac014 = lc_gzac014_new
            
            LET lc_gzac015_new = cl_trans_code_tw_cn("zh_TW",lc_gzac.gzac015)
            IF g_bgjob= "Y" AND (cl_null(lc_gzac015_new) AND NOT cl_null(lc_gzac.gzac015)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>gzac_t</td>",                       #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_gzac.gzac001,"</td>",          #key值欄位1
                                          "<td class=xl24></td>",                             #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_gzac.gzac015,"</td>",          #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字    
                            "</tr>"
            
               CALL g_gen_ch.writeLine(lc_msg)
               
               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_gzac.gzac015 = lc_gzac015_new
            
            LET lc_gzac016_new = cl_trans_code_tw_cn("zh_TW",lc_gzac.gzac016)
            IF g_bgjob= "Y" AND (cl_null(lc_gzac016_new) AND NOT cl_null(lc_gzac.gzac016)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>gzac_t</td>",                       #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_gzac.gzac001,"</td>",          #key值欄位1
                                          "<td class=xl24></td>",                             #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_gzac.gzac016,"</td>",          #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字    
                            "</tr>"
            
               CALL g_gen_ch.writeLine(lc_msg)
               
               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_gzac.gzac016 = lc_gzac016_new
            
            LET lc_gzac017_new = cl_trans_code_tw_cn("zh_TW",lc_gzac.gzac017)
            IF g_bgjob= "Y" AND (cl_null(lc_gzac017_new) AND NOT cl_null(lc_gzac.gzac017)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>gzac_t</td>",                       #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_gzac.gzac001,"</td>",          #key值欄位1
                                          "<td class=xl24></td>",                             #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_gzac.gzac017,"</td>",          #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字    
                            "</tr>"
            
               CALL g_gen_ch.writeLine(lc_msg)
               
               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_gzac.gzac017 = lc_gzac017_new
            
            LET lc_gzac018_new = cl_trans_code_tw_cn("zh_TW",lc_gzac.gzac018)
            IF g_bgjob= "Y" AND (cl_null(lc_gzac018_new) AND NOT cl_null(lc_gzac.gzac018)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>gzac_t</td>",                       #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_gzac.gzac001,"</td>",          #key值欄位1
                                          "<td class=xl24></td>",                             #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_gzac.gzac018,"</td>",          #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字    
                            "</tr>"
            
               CALL g_gen_ch.writeLine(lc_msg)
               
               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_gzac.gzac018 = lc_gzac018_new
            
            LET lc_gzac019_new = cl_trans_code_tw_cn("zh_TW",lc_gzac.gzac019)
            IF g_bgjob= "Y" AND (cl_null(lc_gzac019_new) AND NOT cl_null(lc_gzac.gzac019)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>gzac_t</td>",                       #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_gzac.gzac001,"</td>",          #key值欄位1
                                          "<td class=xl24></td>",                             #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_gzac.gzac019,"</td>",          #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字    
                            "</tr>"
            
               CALL g_gen_ch.writeLine(lc_msg)
               
               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_gzac.gzac019 = lc_gzac019_new
            
            LET lc_gzac020_new = cl_trans_code_tw_cn("zh_TW",lc_gzac.gzac020)
            IF g_bgjob= "Y" AND (cl_null(lc_gzac020_new) AND NOT cl_null(lc_gzac.gzac020)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>gzac_t</td>",                       #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_gzac.gzac001,"</td>",          #key值欄位1
                                          "<td class=xl24></td>",                             #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_gzac.gzac020,"</td>",          #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字    
                            "</tr>"
            
               CALL g_gen_ch.writeLine(lc_msg)
               
               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_gzac.gzac020 = lc_gzac020_new
            
            LET lc_gzac021_new = cl_trans_code_tw_cn("zh_TW",lc_gzac.gzac021)
            IF g_bgjob= "Y" AND (cl_null(lc_gzac021_new) AND NOT cl_null(lc_gzac.gzac021)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>gzac_t</td>",                       #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_gzac.gzac001,"</td>",          #key值欄位1
                                          "<td class=xl24></td>",                             #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_gzac.gzac021,"</td>",          #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字    
                            "</tr>"
            
               CALL g_gen_ch.writeLine(lc_msg)
               
               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_gzac.gzac021 = lc_gzac021_new
            
            LET lc_gzac022_new = cl_trans_code_tw_cn("zh_TW",lc_gzac.gzac022)
            IF g_bgjob= "Y" AND (cl_null(lc_gzac022_new) AND NOT cl_null(lc_gzac.gzac022)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>gzac_t</td>",                       #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_gzac.gzac001,"</td>",          #key值欄位1
                                          "<td class=xl24></td>",                             #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_gzac.gzac022,"</td>",          #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字    
                            "</tr>"
            
               CALL g_gen_ch.writeLine(lc_msg)
               
               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_gzac.gzac022 = lc_gzac022_new
            
            LET lc_gzac023_new = cl_trans_code_tw_cn("zh_TW",lc_gzac.gzac023)
            IF g_bgjob= "Y" AND (cl_null(lc_gzac023_new) AND NOT cl_null(lc_gzac.gzac023)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>gzac_t</td>",                       #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_gzac.gzac001,"</td>",          #key值欄位1
                                          "<td class=xl24></td>",                             #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_gzac.gzac023,"</td>",          #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字    
                            "</tr>"
            
               CALL g_gen_ch.writeLine(lc_msg)
               
               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_gzac.gzac023 = lc_gzac023_new

            #回寫
            INSERT INTO gzac_t VALUES (lc_gzac.*)

         END IF
      ELSE
         IF li_cnt = 2 THEN
           #簡繁有2筆時, 重抓資料
            SELECT * INTO lc_gzac.* FROM gzac_t
             WHERE gzac001 = lc_gzca001 AND gzac002 = "zh_TW"
         END IF
      END IF
      
      IF li_cnt > 0 THEN
         #再檢查字典檔,遇缺則補入
         IF azzp110_chk_gzoy("gzac_t",lc_gzac.gzac002,lc_gzac.gzac001,'','',lc_gzac.gzac003) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_gzac.gzac003,lc_gzac.gzac001,'','')
         END IF
         IF azzp110_chk_gzoy("gzac_t",lc_gzac.gzac002,lc_gzac.gzac001,'','',lc_gzac.gzac004) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_gzac.gzac004,lc_gzac.gzac001,'','')
         END IF
         IF azzp110_chk_gzoy("gzac_t",lc_gzac.gzac002,lc_gzac.gzac001,'','',lc_gzac.gzac005) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_gzac.gzac005,lc_gzac.gzac001,'','')
         END IF
         IF azzp110_chk_gzoy("gzac_t",lc_gzac.gzac002,lc_gzac.gzac001,'','',lc_gzac.gzac006) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_gzac.gzac006,lc_gzac.gzac001,'','')
         END IF
         IF azzp110_chk_gzoy("gzac_t",lc_gzac.gzac002,lc_gzac.gzac001,'','',lc_gzac.gzac007) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_gzac.gzac007,lc_gzac.gzac001,'','')
         END IF
         IF azzp110_chk_gzoy("gzac_t",lc_gzac.gzac002,lc_gzac.gzac001,'','',lc_gzac.gzac008) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_gzac.gzac008,lc_gzac.gzac001,'','')
         END IF
         IF azzp110_chk_gzoy("gzac_t",lc_gzac.gzac002,lc_gzac.gzac001,'','',lc_gzac.gzac009) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_gzac.gzac009,lc_gzac.gzac001,'','')
         END IF
         IF azzp110_chk_gzoy("gzac_t",lc_gzac.gzac002,lc_gzac.gzac001,'','',lc_gzac.gzac010) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_gzac.gzac010,lc_gzac.gzac001,'','')
         END IF
         IF azzp110_chk_gzoy("gzac_t",lc_gzac.gzac002,lc_gzac.gzac001,'','',lc_gzac.gzac011) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_gzac.gzac011,lc_gzac.gzac001,'','')
         END IF
         IF azzp110_chk_gzoy("gzac_t",lc_gzac.gzac002,lc_gzac.gzac001,'','',lc_gzac.gzac012) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_gzac.gzac012,lc_gzac.gzac001,'','')
         END IF
         IF azzp110_chk_gzoy("gzac_t",lc_gzac.gzac002,lc_gzac.gzac001,'','',lc_gzac.gzac013) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_gzac.gzac013,lc_gzac.gzac001,'','')
         END IF
         IF azzp110_chk_gzoy("gzac_t",lc_gzac.gzac002,lc_gzac.gzac001,'','',lc_gzac.gzac014) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_gzac.gzac014,lc_gzac.gzac001,'','')
         END IF
         IF azzp110_chk_gzoy("gzac_t",lc_gzac.gzac002,lc_gzac.gzac001,'','',lc_gzac.gzac015) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_gzac.gzac015,lc_gzac.gzac001,'','')
         END IF
         IF azzp110_chk_gzoy("gzac_t",lc_gzac.gzac002,lc_gzac.gzac001,'','',lc_gzac.gzac016) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_gzac.gzac016,lc_gzac.gzac001,'','')
         END IF
         IF azzp110_chk_gzoy("gzac_t",lc_gzac.gzac002,lc_gzac.gzac001,'','',lc_gzac.gzac017) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_gzac.gzac017,lc_gzac.gzac001,'','')
         END IF
         IF azzp110_chk_gzoy("gzac_t",lc_gzac.gzac002,lc_gzac.gzac001,'','',lc_gzac.gzac018) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_gzac.gzac018,lc_gzac.gzac001,'','')
         END IF
         IF azzp110_chk_gzoy("gzac_t",lc_gzac.gzac002,lc_gzac.gzac001,'','',lc_gzac.gzac019) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_gzac.gzac019,lc_gzac.gzac001,'','')
         END IF
         IF azzp110_chk_gzoy("gzac_t",lc_gzac.gzac002,lc_gzac.gzac001,'','',lc_gzac.gzac020) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_gzac.gzac020,lc_gzac.gzac001,'','')
         END IF
         IF azzp110_chk_gzoy("gzac_t",lc_gzac.gzac002,lc_gzac.gzac001,'','',lc_gzac.gzac021) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_gzac.gzac021,lc_gzac.gzac001,'','')
         END IF
         IF azzp110_chk_gzoy("gzac_t",lc_gzac.gzac002,lc_gzac.gzac001,'','',lc_gzac.gzac022) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_gzac.gzac022,lc_gzac.gzac001,'','')
         END IF
         IF azzp110_chk_gzoy("gzac_t",lc_gzac.gzac002,lc_gzac.gzac001,'','',lc_gzac.gzac023) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_gzac.gzac023,lc_gzac.gzac001,'','')
         END IF
      END IF

   END FOREACH
   CLOSE azzp110_gzac_zhtw_cs
   FREE azzp110_gzac_zhtw_cs
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_upd_gzoz_tw2cn()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_upd_gzoz_tw2cn()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_gzoz000  LIKE gzoz_t.gzoz000
   DEFINE lc_gzoz002  LIKE gzoz_t.gzoz002
   DEFINE lc_gzoz302  LIKE gzoz_t.gzoz302
   DEFINE lc_msg      STRING
   
   
   LET ls_sql = "SELECT gzoz000 FROM gzoz_t WHERE TRIM(gzoz002) IS NULL "
   LET li_cnt = 1
   LET lc_gzoz302 = cl_get_current()

   DECLARE azzp110_upd_tw2cn_cs CURSOR FROM ls_sql
   FOREACH azzp110_upd_tw2cn_cs INTO lc_gzoz000

       LET lc_gzoz002 = cl_trans_code_tw_cn("zh_CN",lc_gzoz000)
       LET lc_gzoz002 = lc_gzoz002 CLIPPED
       IF cl_null(lc_gzoz002) THEN
          DISPLAY "無法翻譯:",lc_gzoz000
       ELSE
          UPDATE gzoz_t SET gzoz002=lc_gzoz002,
                            gzoz102='Y',gzoz202="opencc",gzoz302=lc_gzoz302
           WHERE gzoz000 = lc_gzoz000
          IF SQLCA.SQLCODE THEN
             DISPLAY "失敗",SQLCA.SQLCODE,":",lc_gzoz000,'-->',lc_gzoz002
          ELSE
             DISPLAY "更新:",lc_gzoz000,'-->',lc_gzoz002
          END IF
      END IF
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 去掉前後空白
# Memo...........:
# Usage..........: CALL azzp110_trim(ps_str)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_trim(ps_str)
   DEFINE ps_str  STRING 

   LET ps_str = ps_str.trim()
   
   RETURN ps_str
END FUNCTION

################################################################################
# Descriptions...: 取得繁體中文之外的其他語言別
# Memo...........:
# Usage..........: CALL azzp110_get_gzzy()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_get_gzzy()
   DEFINE ls_sql  STRING
   DEFINE la_gzzy DYNAMIC ARRAY OF RECORD
             gzzy001 LIKE gzzy_t.gzzy001,
             gzozcol LIKE type_t.chr10
                  END RECORD
   DEFINE li_cnt  LIKE type_t.num5

   IF ma_gzzy.getLength() = 0 THEN
      LET ls_sql = "SELECT gzzy001 FROM gzzy_t WHERE gzzystus = 'Y' "
      DECLARE get_gzzy_cs CURSOR FROM ls_sql
      LET li_cnt = 1
      FOREACH get_gzzy_cs INTO la_gzzy[li_cnt].gzzy001
         IF SQLCA.SQLCODE THEN
            EXIT FOREACH
         END IF
         #除了繁體中文取其他語言別
         CASE la_gzzy[li_cnt].gzzy001
            WHEN "en_US" LET la_gzzy[li_cnt].gzozcol = "gzoz001"
            WHEN "zh_CN" LET la_gzzy[li_cnt].gzozcol = "gzoz002"
            WHEN "ja_JP" LET la_gzzy[li_cnt].gzozcol = "gzoz003"
            WHEN "vi_VN" LET la_gzzy[li_cnt].gzozcol = "gzoz004"
            WHEN "th_TH" LET la_gzzy[li_cnt].gzozcol = "gzoz005"
            WHEN "ko_KR" LET la_gzzy[li_cnt].gzozcol = "gzoz006"
            OTHERWISE
               CONTINUE FOREACH
         END CASE
         LET li_cnt = li_cnt + 1
      END FOREACH
      CALL la_gzzy.deleteElement(li_cnt)
      LET ma_gzzy = la_gzzy
   END IF
   RETURN ma_gzzy
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_exp_dzeal()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_exp_dzeal()
   DEFINE ls_sql STRING
   DEFINE ls_sql_gzoz STRING
   DEFINE la_gzzy DYNAMIC ARRAY OF RECORD
             gzzy001 LIKE gzzy_t.gzzy001, #語言別
             gzozcol LIKE type_t.chr10    #語言別欄位
                  END RECORD
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE lc_dzeal001      LIKE dzeal_t.dzeal001
   DEFINE lc_dzeal003_tw   LIKE dzeal_t.dzeal003
   DEFINE lc_dzeal003_old  LIKE dzeal_t.dzeal003
   DEFINE lc_dzeal003_new  LIKE dzeal_t.dzeal003
   DEFINE lc_count         LIKE type_t.num5
   DEFINE lc_msg           STRING
   DEFINE lc_update        LIKE type_t.chr1


   #若是多語言暫存檔有資料的話，要先做暫存檔轉換的部分
   #否則後續用已更新後的字典檔再去對應各多語言檔的話，怕會有缺漏
   IF gs_trans_temp = "Y" THEN
      LET ls_sql = "SELECT dzeal001,dzeal003 FROM dzeal_t WHERE dzeal002 = 'zh_TW' ORDER BY dzeal001"

      DECLARE azzp110_trans_temp_to_dzeal_cs CURSOR FROM ls_sql
      FOREACH azzp110_trans_temp_to_dzeal_cs INTO lc_dzeal001,lc_dzeal003_old
         DISPLAY "check gzos_t  lc_dzeal001:",lc_dzeal001
      #   #檢查過單號是否已超過筆數
      #   CALL azzp110_chk_dzld_rows()
      #   IF NOT g_chk_status THEN
      #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
      #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
      #      CALL g_gen_ch.writeLine(lc_msg)
      #      RETURN
      #   END IF
      
         #從多語言暫存檔找出該語言別資料
         LET lc_dzeal003_new = ""
         EXECUTE azzp110_get_gzos_cs USING lc_dzeal003_old INTO lc_dzeal003_new
         
         IF NOT SQLCA.SQLCODE AND NOT cl_null(lc_dzeal003_new) THEN
            #填寫過單資訊，需檢核是否存在主檔中
            LET lc_count = 0
         #   IF NOT azzp110_insert_dzld('dzeal_t','azzp110',lc_dzeal001,' ') THEN
         #      LET g_chk_status = FALSE
         #      RETURN
         #   END IF
            
            UPDATE dzeal_t SET dzeal003 = lc_dzeal003_new
             WHERE dzeal001 = lc_dzeal001 AND dzeal002 = "zh_TW"
            IF SQLCA.SQLCODE THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)dzeal_t失敗...  dzeal001:",lc_dzeal001,"  dzeal002:zh_TW","  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
               CALL g_gen_ch.writeLine(lc_msg)
               RETURN
            END IF
         
            #紀錄log
            LET lc_msg = "<tr hieght=22><td class=xl24>zh_TW</td>",                #更換語系
                                       "<td class=xl24>dzeal_t</td>",              #更換的多語言table
                                       "<td class=xl24>",g_param.docno,"</td>",    #表單單號    
                                       "<td class=xl24>",g_param.seq,"</td>",      #項次
                                       "<td class=xl24>azzp110</td>",              #關聯項目
                                       "<td class=xl24>",lc_dzeal001,"</td>",      #過單條件值
                                       "<td class=xl24>",lc_dzeal003_old,"</td>",  #資料修改前
                                       "<td class=xl24>",lc_dzeal003_new,"</td>",  #資料修改後
                         "</tr>"
            
            CALL g_gen_ch.writeLine(lc_msg)
         END IF
      END FOREACH
   END IF
   
   ########開始進行字典檔匯出至多語言檔的動作##########
   LET ls_sql = "SELECT dzeal001,dzeal003 FROM dzeal_t WHERE dzeal002 = 'zh_TW' ORDER BY dzeal001"

   #取出語言種類與項目
   LET la_gzzy = azzp110_get_gzzy() #除了zh_TW 之外

   DECLARE exp_dzeal_cs CURSOR FROM ls_sql
   FOREACH exp_dzeal_cs INTO lc_dzeal001,lc_dzeal003_tw
      DISPLAY "check gzoz_t  lc_dzeal001:",lc_dzeal001
      #跑單身陣列
      FOR li_cnt = 1 TO la_gzzy.getLength()
         LET lc_update = "N"

         #字典檔找出該語言別資料
         LET lc_dzeal003_new = ""
         LET ls_sql_gzoz = "SELECT ",la_gzzy[li_cnt].gzozcol CLIPPED,
                            " FROM gzoz_t WHERE gzoz000= '",lc_dzeal003_tw CLIPPED,"' "
         PREPARE s2 FROM ls_sql_gzoz
         EXECUTE s2 INTO lc_dzeal003_new
         #如果有資料且該筆資料不是null  
         #然後判斷該語言別是否有資料 沒有資料就insert 有資料確認該筆資料是否是null，是就update 
         #160303 改為以字典檔為主，若在字典檔有找到且非空白，就一律更新
         #160419 以字典檔為主，若是字典檔與外顯表不一致時才更新
         IF NOT SQLCA.SQLCODE AND NOT cl_null(lc_dzeal003_new) THEN
         #   #檢查過單號是否已超過筆數
         #   CALL azzp110_chk_dzld_rows()
         #   IF NOT g_chk_status THEN
         #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
         #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
         #   CALL g_gen_ch.writeLine(lc_msg)
         #      RETURN
         #   END IF
         
            LET lc_dzeal003_old = ""
            SELECT dzeal003 INTO lc_dzeal003_old FROM dzeal_t
             WHERE dzeal001 = lc_dzeal001
               AND dzeal002 = la_gzzy[li_cnt].gzzy001
            IF SQLCA.SQLCODE THEN
            #   #填寫過單資訊，需檢核是否存在主檔中
            #   LET lc_count = 0
            #   IF NOT azzp110_insert_dzld('dzeal_t','azzp110',lc_dzeal001,' ') THEN
            #      LET g_chk_status = FALSE
            #      RETURN
            #   END IF
               INSERT INTO dzeal_t(dzeal001,dzeal002,dzeal003)
                  VALUES(lc_dzeal001,la_gzzy[li_cnt].gzzy001,lc_dzeal003_new)

               IF SQLCA.SQLCODE THEN
                  LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(insert)dzeal_t失敗...  dzeal001:",lc_dzeal001,"  dzeal002:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                  CALL g_gen_ch.writeLine(lc_msg)
                  RETURN
               END IF
               LET lc_update = "Y"
            ELSE
               IF la_gzzy[li_cnt].gzzy001 <> 'zh_TW' AND lc_dzeal003_new <> lc_dzeal003_old THEN
               #   #填寫過單資訊，需檢核是否存在主檔中
               #   LET lc_count = 0
               #   IF NOT azzp110_insert_dzld('dzeal_t','azzp110',lc_dzeal001,' ') THEN
               #      LET g_chk_status = FALSE
               #      RETURN
               #   END IF
                  UPDATE dzeal_t SET dzeal003 = lc_dzeal003_new
                   WHERE dzeal001 = lc_dzeal001 AND dzeal002 = la_gzzy[li_cnt].gzzy001
                  
                  IF SQLCA.SQLCODE THEN
                     LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)dzeal_t失敗...  dzeal001:",lc_dzeal001,"  dzeal002:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                     CALL g_gen_ch.writeLine(lc_msg)
                     RETURN
                  END IF
                  LET lc_update = "Y"
               END IF
            END IF
            
            IF lc_update = "Y" THEN
               #紀錄log
               LET lc_msg = "<tr hieght=22><td class=xl24>",la_gzzy[li_cnt].gzzy001,"</td>",                #更換語系
                                          "<td class=xl24>dzeal_t</td>",              #更換的多語言table
                                          "<td class=xl24>",g_param.docno,"</td>",    #表單單號    
                                          "<td class=xl24>",g_param.seq,"</td>",      #項次
                                          "<td class=xl24>azzp110</td>",              #關聯項目
                                          "<td class=xl24>",lc_dzeal001,"</td>",      #過單條件值
                                          "<td class=xl24>",lc_dzeal003_old,"</td>",  #資料修改前
                                          "<td class=xl24>",lc_dzeal003_new,"</td>",  #資料修改後
                            "</tr>"
           
               CALL g_gen_ch.writeLine(lc_msg)
            END IF
         END IF
         FREE s2
      END FOR
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_exp_dzebl()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_exp_dzebl()
   DEFINE ls_sql STRING
   DEFINE ls_sql_gzoz STRING
   DEFINE la_gzzy DYNAMIC ARRAY OF RECORD
             gzzy001 LIKE gzzy_t.gzzy001, #語言別
             gzozcol LIKE type_t.chr10    #語言別欄位
                  END RECORD
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE lc_dzebl001     LIKE dzebl_t.dzebl001
   DEFINE lc_dzebl003_tw  LIKE dzebl_t.dzebl003
   DEFINE lc_dzebl003_old LIKE dzebl_t.dzebl003
   DEFINE lc_dzebl003_new LIKE dzebl_t.dzebl003
   DEFINE lc_dzebl000     LIKE dzebl_t.dzebl000
   DEFINE lc_count        LIKE type_t.num5
   DEFINE lc_msg          STRING
   DEFINE lc_update       LIKE type_t.chr1
   DEFINE lc_item1        STRING
   DEFINE lc_item2        STRING
   

   #若是多語言暫存檔有資料的話，要先做暫存檔轉換的部分
   #否則後續用已更新後的字典檔再去對應各多語言檔的話，怕會有缺漏
   IF gs_trans_temp = "Y" THEN
      LET ls_sql = "SELECT dzebl001,dzebl003,dzebl000 FROM dzebl_t WHERE dzebl002 = 'zh_TW' ORDER BY dzebl001"

      DECLARE azzp110_trans_temp_to_dzebl_cs CURSOR FROM ls_sql
      FOREACH azzp110_trans_temp_to_dzebl_cs INTO lc_dzebl001,lc_dzebl003_old,lc_dzebl000
         DISPLAY "check gzos_t  lc_dzebl001:",lc_dzebl001
      #   #檢查過單號是否已超過筆數
      #   CALL azzp110_chk_dzld_rows()
      #   IF NOT g_chk_status THEN
      #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
      #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
      #      CALL g_gen_ch.writeLine(lc_msg)
      #      RETURN
      #   END IF
         
         #從多語言暫存檔找出該語言別資料
         LET lc_dzebl003_new = ""
         EXECUTE azzp110_get_gzos_cs USING lc_dzebl003_old INTO lc_dzebl003_new
         
         IF NOT SQLCA.SQLCODE AND NOT cl_null(lc_dzebl003_new) THEN
            #填寫過單資訊，需檢核是否存在主檔中
            LET lc_count = 0
            LET lc_item1 = "NULL"
            LET lc_item2 = "NULL"
            SELECT COUNT(1) INTO lc_count FROM dzep_t 
             WHERE dzep001 = lc_dzebl000 AND dzep002 = lc_dzebl001
            IF lc_count > 0 THEN
            #   IF NOT azzp110_insert_dzld('dzebl_t','adzi150',lc_dzebl000,' ') THEN
            #      LET g_chk_status = FALSE
            #      RETURN
            #   END IF
               LET lc_item1 = "adzi150"
               LET lc_item2 = lc_dzebl000
            END IF
            
            UPDATE dzebl_t SET dzebl003 = lc_dzebl003_new
             WHERE dzebl001 = lc_dzebl001 AND dzebl002 = "zh_TW"
            
            IF SQLCA.SQLCODE THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)dzebl_t失敗...  dzebl001:",lc_dzebl001,"  dzebl002:zh_TW","  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
               CALL g_gen_ch.writeLine(lc_msg)
               RETURN
            END IF
            
            #紀錄log
            LET lc_msg = "<tr hieght=22><td class=xl24>zh_TW</td>",                #更換語系
                                       "<td class=xl24>dzebl_t</td>",              #更換的多語言table
                                       "<td class=xl24>",g_param.docno,"</td>",    #表單單號    
                                       "<td class=xl24>",g_param.seq,"</td>",      #項次
                                       "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                       "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                       "<td class=xl24>",lc_dzebl003_old,"</td>",  #資料修改前
                                       "<td class=xl24>",lc_dzebl003_new,"</td>",  #資料修改後
                         "</tr>"
            
            CALL g_gen_ch.writeLine(lc_msg)
         END IF
      END FOREACH
   END IF

   ########開始進行字典檔匯出至多語言檔的動作##########
   LET ls_sql = "SELECT dzebl001,dzebl003,dzebl000 FROM dzebl_t WHERE dzebl002 = 'zh_TW' ORDER BY dzebl001"

   #取出語言種類與項目 
   LET la_gzzy = azzp110_get_gzzy() #除了zh_TW 之外

   DECLARE exp_dzebl_cs CURSOR FROM ls_sql
   FOREACH exp_dzebl_cs INTO lc_dzebl001,lc_dzebl003_tw,lc_dzebl000
      DISPLAY "check gzoz_t  lc_dzebl001:",lc_dzebl001
      #跑單身陣列
      FOR li_cnt = 1 TO la_gzzy.getLength()
         LET lc_update = "N"
         
         #字典檔找出該語言別資料
         LET lc_dzebl003_new = ""
         LET ls_sql_gzoz = "SELECT ",la_gzzy[li_cnt].gzozcol CLIPPED,
                            " FROM gzoz_t WHERE gzoz000= '",lc_dzebl003_tw CLIPPED,"' "
         PREPARE s1 FROM ls_sql_gzoz
         EXECUTE s1 INTO lc_dzebl003_new
         #如果有資料且該筆資料不是null  
         #然後判斷該語言別是否有資料 沒有資料就insert 有資料確認該筆資料是否是null，是就update
         #160303 改為以字典檔為主，若在字典檔有找到且非空白，就一律更新
         #160419 以字典檔為主，若是字典檔與外顯表不一致時才更新
         IF NOT SQLCA.SQLCODE AND NOT cl_null(lc_dzebl003_new) THEN
            #檢查過單號是否已超過筆數
         #   CALL azzp110_chk_dzld_rows()
         #   IF NOT g_chk_status THEN
         #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
         #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
         #   CALL g_gen_ch.writeLine(lc_msg)
         #      RETURN
         #   END IF

            LET lc_dzebl003_old = ""
            SELECT dzebl003 INTO lc_dzebl003_old FROM dzebl_t
             WHERE dzebl001 = lc_dzebl001
               AND dzebl002 = la_gzzy[li_cnt].gzzy001
            IF SQLCA.SQLCODE THEN
               #填寫過單資訊，需檢核是否存在主檔中
               LET lc_count = 0
               LET lc_item1 = "NULL"
               LET lc_item2 = "NULL"
               SELECT COUNT(1) INTO lc_count FROM dzep_t 
                WHERE dzep001 = lc_dzebl000 AND dzep002 = lc_dzebl001
               IF lc_count > 0 THEN
               #   IF NOT azzp110_insert_dzld('dzebl_t','adzi150',lc_dzebl000,' ') THEN
               #      LET g_chk_status = FALSE
               #      RETURN
               #   END IF
                  LET lc_item1 = "adzi150"
                  LET lc_item2 = lc_dzebl000
               END IF
            
               INSERT INTO dzebl_t(dzebl000,dzebl001,dzebl002,dzebl003)
                 VALUES(lc_dzebl000,lc_dzebl001,la_gzzy[li_cnt].gzzy001,lc_dzebl003_new)
               
               IF SQLCA.SQLCODE THEN
                  LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(insert)dzebl_t失敗...  dzebl001:",lc_dzebl001,"  dzebl002:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                  CALL g_gen_ch.writeLine(lc_msg)
                  RETURN
               END IF
               LET lc_update = "Y"
            ELSE
               IF la_gzzy[li_cnt].gzzy001 <> 'zh_TW' AND lc_dzebl003_new <> lc_dzebl003_old THEN
                  #填寫過單資訊，需檢核是否存在主檔中
                  LET lc_count = 0
                  LET lc_item1 = "NULL"
                  LET lc_item2 = "NULL"
                  SELECT COUNT(1) INTO lc_count FROM dzep_t 
                   WHERE dzep001 = lc_dzebl000 AND dzep002 = lc_dzebl001
                  IF lc_count > 0 THEN
                  #   IF NOT azzp110_insert_dzld('dzebl_t','adzi150',lc_dzebl000,' ') THEN
                  #      LET g_chk_status = FALSE
                  #      RETURN
                  #   END IF
                     LET lc_item1 = "adzi150"
                     LET lc_item2 = lc_dzebl000
                  END IF
               
                  UPDATE dzebl_t SET dzebl003 = lc_dzebl003_new
                   WHERE dzebl001 = lc_dzebl001 AND dzebl002 = la_gzzy[li_cnt].gzzy001
                 
                  IF SQLCA.SQLCODE THEN
                     LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)dzebl_t失敗...  dzebl001:",lc_dzebl001,"  dzebl002:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                     CALL g_gen_ch.writeLine(lc_msg)
                     RETURN
                  END IF
                  LET lc_update = "Y"
               END IF
            END IF
            
            IF lc_update = "Y" THEN
               #紀錄log
               LET lc_msg = "<tr hieght=22><td class=xl24>",la_gzzy[li_cnt].gzzy001,"</td>",   #更換語系
                                          "<td class=xl24>dzebl_t</td>",              #更換的多語言table
                                          "<td class=xl24>",g_param.docno,"</td>",    #表單單號    
                                          "<td class=xl24>",g_param.seq,"</td>",      #項次
                                          "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                          "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                          "<td class=xl24>",lc_dzebl003_old,"</td>",  #資料修改前
                                          "<td class=xl24>",lc_dzebl003_new,"</td>",  #資料修改後
                            "</tr>"
               
               CALL g_gen_ch.writeLine(lc_msg)
            END IF
         END IF
         FREE s1
      END FOR

   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_exp_gzzal()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_exp_gzzal()
   DEFINE ls_sql STRING
   DEFINE ls_sql_gzoz STRING
   DEFINE la_gzzy DYNAMIC ARRAY OF RECORD
             gzzy001 LIKE gzzy_t.gzzy001, #語言別
             gzozcol LIKE type_t.chr10    #語言別欄位
                  END RECORD
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE lc_gzzal001     LIKE gzzal_t.gzzal001
   DEFINE lc_gzzal003_tw  LIKE gzzal_t.gzzal003
   DEFINE lc_gzzal003_old LIKE gzzal_t.gzzal003
   DEFINE lc_gzzal003_new LIKE gzzal_t.gzzal003
   DEFINE lc_count_1      LIKE type_t.num5
   DEFINE lc_count_2      LIKE type_t.num5
   DEFINE lc_msg          STRING
   DEFINE lc_update       LIKE type_t.chr1
   DEFINE lc_item1        STRING
   DEFINE lc_item2        STRING


   #若是多語言暫存檔有資料的話，要先做暫存檔轉換的部分
   #否則後續用已更新後的字典檔再去對應各多語言檔的話，怕會有缺漏
   IF gs_trans_temp = "Y" THEN
      LET ls_sql = "SELECT gzzal001,gzzal003 FROM gzzal_t WHERE gzzal002 = 'zh_TW' ORDER BY gzzal001"

      DECLARE azzp110_trans_temp_to_gzzal_cs CURSOR FROM ls_sql
      #1.先取出gzzal001 程式編號 gzzal003 程式名稱                       
      FOREACH azzp110_trans_temp_to_gzzal_cs INTO lc_gzzal001,lc_gzzal003_old
         DISPLAY "check gzos_t  lc_gzzal001:",lc_gzzal001
         #檢查過單號是否已超過筆數
      #   CALL azzp110_chk_dzld_rows()
      #   IF NOT g_chk_status THEN
      #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
      #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
      #      CALL g_gen_ch.writeLine(lc_msg)
      #      RETURN
      #   END IF
         
         #從多語言暫存檔找出該語言別資料
         LET lc_gzzal003_new = ""
         EXECUTE azzp110_get_gzos_cs USING lc_gzzal003_old INTO lc_gzzal003_new
               
         IF NOT SQLCA.SQLCODE AND NOT cl_null(lc_gzzal003_new) THEN
            #填寫過單資訊，需檢核是否存在主檔中
            #需先判斷此多語言檔案會有幾個過單項(azzi900或azzi910)
            #因為可能多個過單項都有過到這個多語言檔案，
            #鴻傑說，主要是要過多語言檔，所以只要有一筆當代表就可以了，不用每個過單項都過
            LET lc_count_1 = 0
            LET lc_count_2 = 0
            LET lc_item1 = "NULL"
            LET lc_item2 = "NULL"
            #azzi900
            SELECT COUNT(1) INTO lc_count_1 FROM gzza_t 
             WHERE gzza001 = lc_gzzal001
            
            IF lc_count_1 > 0 THEN
            #   IF NOT azzp110_insert_dzld('gzzal_t','azzi900',lc_gzzal001,' ') THEN
            #      LET g_chk_status = FALSE
            #      RETURN
            #   END IF
               LET lc_item1 = "azzi900"
               LET lc_item2 = lc_gzzal001
            ELSE
               #azzi910
               SELECT COUNT(1) INTO lc_count_2 FROM gzzz_t 
                WHERE gzzz001 = lc_gzzal001
               
               IF lc_count_2 > 0 THEN
               #   IF NOT azzp110_insert_dzld('gzzal_t','azzi910',lc_gzzal001,' ') THEN
               #      LET g_chk_status = FALSE
               #      RETURN
               #   END IF
                  LET lc_item1 = "azzi910"
                  LET lc_item2 = lc_gzzal001
               END IF
            END IF
            
            UPDATE gzzal_t SET gzzal003 = lc_gzzal003_new
             WHERE gzzal001 = lc_gzzal001 AND gzzal002 = "zh_TW"
            
            IF SQLCA.SQLCODE THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(insert)gzzal_t失敗...  gzzal001:",lc_gzzal001,"  gzzal002:zh_TW","  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
               CALL g_gen_ch.writeLine(lc_msg)
               RETURN
            END IF
            
            #紀錄log
            LET lc_msg = "<tr hieght=22><td class=xl24>zh_TW</td>",                #更換語系
                                       "<td class=xl24>gzzal_t</td>",              #更換的多語言table
                                       "<td class=xl24>",g_param.docno,"</td>",    #表單單號    
                                       "<td class=xl24>",g_param.seq,"</td>",      #項次
                                       "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                       "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                       "<td class=xl24>",lc_gzzal003_old,"</td>",  #資料修改前
                                       "<td class=xl24>",lc_gzzal003_new,"</td>",  #資料修改後
                         "</tr>"
            CALL g_gen_ch.writeLine(lc_msg)
            
         END IF
      END FOREACH
   END IF

   ########開始進行字典檔匯出至多語言檔的動作##########
   LET ls_sql = "SELECT gzzal001,gzzal003 FROM gzzal_t WHERE gzzal002 = 'zh_TW' ORDER BY gzzal001"

   #取出語言種類與項目
   LET la_gzzy = azzp110_get_gzzy() #除了zh_TW 之外
   DECLARE exp_gzzal_cs CURSOR FROM ls_sql
   #1.先取出gzzal001 程式編號 gzzal003 程式名稱                       
   FOREACH exp_gzzal_cs INTO lc_gzzal001,lc_gzzal003_tw
      DISPLAY "check gzoz_t  lc_gzzal001:",lc_gzzal001
      #跑單身陣列
      FOR li_cnt = 1 TO la_gzzy.getLength()
         LET lc_update = "N"
         
         #以繁體中文為主
         LET lc_gzzal003_new = ""
         LET ls_sql_gzoz = "SELECT ",la_gzzy[li_cnt].gzozcol CLIPPED,
                            " FROM gzoz_t WHERE gzoz000= '",lc_gzzal003_tw CLIPPED,"' "
         PREPARE s3 FROM ls_sql_gzoz
         EXECUTE s3 INTO lc_gzzal003_new
         #2.取出字典檔該語言別資料 
         #如果有資料且該筆資料不是null  
         #然後判斷該語言別是否有資料 沒有資料就insert 有資料確認該筆資料是否是null，是就update
         #160303 改為以字典檔為主，若在字典檔有找到且非空白，就一律更新  
         #160419 以字典檔為主，若是字典檔與外顯表不一致時才更新         
         IF NOT SQLCA.SQLCODE AND NOT cl_null(lc_gzzal003_new) THEN
            #檢查過單號是否已超過筆數
         #   CALL azzp110_chk_dzld_rows()
         #   IF NOT g_chk_status THEN
         #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
         #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
         #      CALL g_gen_ch.writeLine(lc_msg)
         #      RETURN
         #   END IF
 
            LET lc_gzzal003_old = ""
            SELECT gzzal003 INTO lc_gzzal003_old FROM gzzal_t
             WHERE gzzal001 = lc_gzzal001
               AND gzzal002 = la_gzzy[li_cnt].gzzy001
            #3.判斷該語言別及程式編號 是否有資料 否:insert 是:update  
            IF SQLCA.SQLCODE THEN
               #填寫過單資訊，需檢核是否存在主檔中
               #需先判斷此多語言檔案會有幾個過單項(azzi900或azzi910)
               #因為可能多個過單項都有過到這個多語言檔案，
               #鴻傑說，主要是要過多語言檔，所以只要有一筆當代表就可以了，不用每個過單項都過
               LET lc_count_1 = 0
               LET lc_count_2 = 0
               LET lc_item1 = "NULL"
               LET lc_item2 = "NULL"
               #azzi900
               SELECT COUNT(1) INTO lc_count_1 FROM gzza_t 
                WHERE gzza001 = lc_gzzal001
               
               IF lc_count_1 > 0 THEN
               #   IF NOT azzp110_insert_dzld('gzzal_t','azzi900',lc_gzzal001,' ') THEN
               #      LET g_chk_status = FALSE
               #      RETURN
               #   END IF
                  LET lc_item1 = "azzi900"
                  LET lc_item2 = lc_gzzal001
               ELSE
                  #azzi910
                  SELECT COUNT(1) INTO lc_count_2 FROM gzzz_t 
                   WHERE gzzz001 = lc_gzzal001
                  
                  IF lc_count_2 > 0 THEN
                  #   IF NOT azzp110_insert_dzld('gzzal_t','azzi910',lc_gzzal001,' ') THEN
                  #      LET g_chk_status = FALSE
                  #      RETURN
                  #   END IF
                     LET lc_item1 = "azzi910"
                     LET lc_item2 = lc_gzzal001
                  END IF
               END IF
            
               INSERT INTO gzzal_t(gzzal001,gzzal002,gzzal003)
                  VALUES(lc_gzzal001,la_gzzy[li_cnt].gzzy001,lc_gzzal003_new)
               
               IF SQLCA.SQLCODE THEN
                  LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(insert)gzzal_t失敗...  gzzal001:",lc_gzzal001,"  gzzal002:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                  CALL g_gen_ch.writeLine(lc_msg)
                  RETURN
               END IF
               LET lc_update = "Y"
            ELSE
               IF la_gzzy[li_cnt].gzzy001 <> 'zh_TW' AND lc_gzzal003_new <> lc_gzzal003_old THEN
                  #填寫過單資訊，需檢核是否存在主檔中
                  #需先判斷此多語言檔案會有幾個過單項(azzi900或azzi910)
                  #因為可能多個過單項都有過到這個多語言檔案，
                  #鴻傑說，主要是要過多語言檔，所以只要有一筆當代表就可以了，不用每個過單項都過
                  LET lc_count_1 = 0
                  LET lc_count_2 = 0
                  LET lc_item1 = "NULL"
                  LET lc_item2 = "NULL"
                  #azzi900
                  SELECT COUNT(1) INTO lc_count_1 FROM gzza_t 
                   WHERE gzza001 = lc_gzzal001
                  
                  IF lc_count_1 > 0 THEN
                  #   IF NOT azzp110_insert_dzld('gzzal_t','azzi900',lc_gzzal001,' ') THEN
                  #      LET g_chk_status = FALSE
                  #      RETURN
                  #   END IF
                     LET lc_item1 = "azzi900"
                     LET lc_item2 = lc_gzzal001
                  ELSE
                     #azzi910
                     SELECT COUNT(1) INTO lc_count_2 FROM gzzz_t 
                      WHERE gzzz001 = lc_gzzal001
                     
                     IF lc_count_2 > 0 THEN
                     #   IF NOT azzp110_insert_dzld('gzzal_t','azzi910',lc_gzzal001,' ') THEN
                     #      LET g_chk_status = FALSE
                     #      RETURN
                     #   END IF
                        LET lc_item1 = "azzi910"
                        LET lc_item2 = lc_gzzal001
                     END IF
                  END IF
            
                  UPDATE gzzal_t SET gzzal003 = lc_gzzal003_new
                   WHERE gzzal001 = lc_gzzal001 AND gzzal002 = la_gzzy[li_cnt].gzzy001
                  
                  IF SQLCA.SQLCODE THEN
                     LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)gzzal_t失敗...  gzzal001:",lc_gzzal001,"  gzzal002:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                     CALL g_gen_ch.writeLine(lc_msg)
                     RETURN
                  END IF
                  LET lc_update = "Y"
               END IF
            END IF
            
            IF lc_update = "Y" THEN
               #紀錄log
               LET lc_msg = "<tr hieght=22><td class=xl24>",la_gzzy[li_cnt].gzzy001,"</td>",   #更換語系
                                          "<td class=xl24>gzzal_t</td>",              #更換的多語言table
                                          "<td class=xl24>",g_param.docno,"</td>",    #表單單號    
                                          "<td class=xl24>",g_param.seq,"</td>",      #項次
                                          "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                          "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                          "<td class=xl24>",lc_gzzal003_old,"</td>",  #資料修改前
                                          "<td class=xl24>",lc_gzzal003_new,"</td>",  #資料修改後
                            "</tr>"
               
               CALL g_gen_ch.writeLine(lc_msg)
            END IF
         END IF
         FREE s3
      END FOR

   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_exp_gzzd()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_exp_gzzd()
   DEFINE ls_sql STRING
   DEFINE ls_sql_gzoz STRING
   DEFINE la_gzzy DYNAMIC ARRAY OF RECORD
             gzzy001 LIKE gzzy_t.gzzy001, #語言別
             gzozcol LIKE type_t.chr10    #語言別欄位
                  END RECORD
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE lc_gzzd001     LIKE gzzd_t.gzzd001
   DEFINE lc_gzzd003     LIKE gzzd_t.gzzd003  
   DEFINE lc_gzzd005_tw  LIKE gzzd_t.gzzd005  #轉換標籤
   DEFINE lc_gzzd005_old LIKE gzzd_t.gzzd005
   DEFINE lc_gzzd005_new LIKE gzzd_t.gzzd005
   DEFINE lc_gzzd006_tw  LIKE gzzd_t.gzzd006  #轉換註解
   DEFINE lc_gzzd006_old LIKE gzzd_t.gzzd006
   DEFINE lc_gzzd006_new LIKE gzzd_t.gzzd006
   DEFINE lc_std_or_cust LIKE type_t.chr1
   DEFINE li_result      LIKE type_t.num5
   DEFINE li_result2     LIKE type_t.num5
   DEFINE li_count       LIKE type_t.num5
   DEFINE lc_gzzdcrtid   LIKE gzzd_t.gzzdcrtid
   DEFINE lc_gzzdcrtdp   LIKE gzzd_t.gzzdcrtdp
   DEFINE lc_gzzdcrtdt   DATETIME YEAR TO SECOND
   DEFINE lc_gzzdmodid   LIKE gzzd_t.gzzdmodid
   DEFINE lc_gzzdmoddt   DATETIME YEAR TO SECOND
   DEFINE lc_gzzdownid   LIKE gzzd_t.gzzdownid
   DEFINE lc_gzzdowndp   LIKE gzzd_t.gzzdowndp
   DEFINE lc_count       LIKE type_t.num5
   DEFINE lc_msg         STRING
   DEFINE lc_update      LIKE type_t.chr1
   DEFINE lc_item1       STRING
   DEFINE lc_item2       STRING


   LET lc_gzzdownid = g_user
   LET lc_gzzdowndp = g_dept
   LET lc_gzzdcrtid = g_user
   LET lc_gzzdcrtdp = g_dept
   LET lc_gzzdcrtdt = cl_get_current()
   LET lc_gzzdmodid = g_user
   LET lc_gzzdmoddt = cl_get_current()


   #取標準或客製
   LET lc_std_or_cust = FGL_GETENV("DGENV")
   
   #若是多語言暫存檔有資料的話，要先做暫存檔轉換的部分
   #否則後續用已更新後的字典檔再去對應各多語言檔的話，怕會有缺漏
   IF gs_trans_temp = "Y" THEN
      #gzzd 有標準及客製
      LET ls_sql = "SELECT gzzd001,gzzd003,gzzd005,gzzd006 FROM gzzd_t ",
                   " WHERE gzzd002 = 'zh_TW' AND gzzd004 ='",lc_std_or_cust CLIPPED ,"' ORDER BY gzzd001"

      DECLARE azzp110_trans_temp_to_gzzd_cs CURSOR FROM ls_sql
      FOREACH azzp110_trans_temp_to_gzzd_cs INTO lc_gzzd001,lc_gzzd003,lc_gzzd005_old,lc_gzzd006_old
         DISPLAY "check gzos_t  lc_gzzd001:",lc_gzzd001
         #檢查過單號是否已超過筆數
      #   CALL azzp110_chk_dzld_rows()
      #   IF NOT g_chk_status THEN
      #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
      #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
      #      CALL g_gen_ch.writeLine(lc_msg)
      #      RETURN
      #   END IF
         
         #從多語言暫存檔找出該語言別資料
         LET lc_gzzd005_new = ""
         EXECUTE azzp110_get_gzos_cs USING lc_gzzd005_old INTO lc_gzzd005_new
         LET li_result = SQLCA.SQLCODE

         #以繁體中文為主
         LET lc_gzzd006_new = ""
         EXECUTE azzp110_get_gzos_cs USING lc_gzzd006_old INTO lc_gzzd006_new
         LET li_result2 = SQLCA.SQLCODE
         
         #如果有資料且該筆資料不是null  
         #然後判斷該語言別是否有資料 沒有資料就insert 有資料確認該筆資料是否是null，是就update
         #160303 改為以字典檔為主，若在字典檔有找到且非空白，就一律更新
         IF (NOT li_result AND NOT cl_null(lc_gzzd005_new) ) OR (NOT li_result2 AND NOT cl_null(lc_gzzd006_new) ) THEN
            #填寫過單資訊，需檢核是否存在主檔中
            LET lc_count = 0
            LET lc_item1 = "NULL"
            LET lc_item2 = "NULL"
            SELECT COUNT(1) INTO lc_count FROM gzzd_t
                WHERE gzzd001 = lc_gzzd001
            
            IF lc_count > 0 THEN
            #   IF NOT azzp110_insert_dzld('gzzd_t','azzi902',lc_gzzd001,' ') THEN
            #      LET g_chk_status = FALSE
            #      RETURN
            #   END IF
               LET lc_item1 = "azzi902"
               LET lc_item2 = lc_gzzd001
            END IF
         
            IF cl_null(lc_gzzd005_new) THEN
               LET lc_gzzd005_new = lc_gzzd005_old
            END IF
            IF cl_null(lc_gzzd006_new) THEN
               LET lc_gzzd006_new = lc_gzzd006_old  
            END IF  
            UPDATE gzzd_t SET gzzd005 = lc_gzzd005_new,gzzd006 = lc_gzzd006_new,
                              gzzdmodid = lc_gzzdmodid,gzzdmoddt = lc_gzzdmoddt
             WHERE gzzd001 = lc_gzzd001 
               AND gzzd002 = "zh_TW"
               AND gzzd003 = lc_gzzd003
               AND gzzd004 = lc_std_or_cust                      

            IF SQLCA.SQLCODE THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)gzzd_t失敗...  gzzd001:",lc_gzzd001,"  gzzd002:zh_TW",
                                                       "  gzzd003:",lc_gzzd003,"  gzzd004:",lc_std_or_cust,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
               CALL g_gen_ch.writeLine(lc_msg)
               RETURN
            END IF

            #紀錄log
            LET lc_msg = "<tr hieght=22><td class=xl24>zh_TW</td>",                #更換語系
                                       "<td class=xl24>gzzd_t</td>",               #更換的多語言table
                                       "<td class=xl24>",g_param.docno,"</td>",    #表單單號    
                                       "<td class=xl24>",g_param.seq,"</td>",      #項次
                                       "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                       "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                       "<td class=xl24>",lc_gzzd005_old,"</td>",   #資料修改前
                                       "<td class=xl24>",lc_gzzd005_new,"</td>",   #資料修改後
                                       "<td class=xl24>",lc_gzzd006_old,"</td>",   #資料修改前
                                       "<td class=xl24>",lc_gzzd006_new,"</td>",   #資料修改後
                         "</tr>"
            
            CALL g_gen_ch.writeLine(lc_msg)
         END IF 
      END FOREACH
   END IF

   ########開始進行字典檔匯出至多語言檔的動作##########
   #gzzd 有標準及客製
   LET ls_sql = "SELECT gzzd001,gzzd003,gzzd005,gzzd006 FROM gzzd_t ",
                " WHERE gzzd002 = 'zh_TW' AND gzzd004 ='",lc_std_or_cust CLIPPED ,"' ORDER BY gzzd001"

   #取出語言種類與項目
   LET la_gzzy = azzp110_get_gzzy()

   DECLARE exp_gzzd_cs CURSOR FROM ls_sql
   FOREACH exp_gzzd_cs INTO lc_gzzd001,lc_gzzd003,lc_gzzd005_tw,lc_gzzd006_tw
      DISPLAY "check gzoz_t  lc_gzzd001:",lc_gzzd001
      #跑單身陣列
      FOR li_cnt = 1 TO la_gzzy.getLength()
         LET lc_update = "N"
         
         #以繁體中文為主
         LET lc_gzzd005_new = ""
         LET ls_sql_gzoz = "SELECT ",la_gzzy[li_cnt].gzozcol CLIPPED,
                            " FROM gzoz_t WHERE gzoz000= '",lc_gzzd005_tw CLIPPED,"' "
         PREPARE s4 FROM ls_sql_gzoz
         EXECUTE s4 INTO lc_gzzd005_new
         LET li_result = SQLCA.SQLCODE

         #以繁體中文為主
         LET lc_gzzd006_new = ""
         LET ls_sql_gzoz = "SELECT ",la_gzzy[li_cnt].gzozcol CLIPPED,
                            " FROM gzoz_t WHERE gzoz000= '",lc_gzzd006_tw CLIPPED,"' "
         PREPARE s5 FROM ls_sql_gzoz
         EXECUTE s5 INTO lc_gzzd006_new
         
         #如果有資料且該筆資料不是null  
         #然後判斷該語言別是否有資料 沒有資料就insert 有資料確認該筆資料是否是null，是就update
         #160303 改為以字典檔為主，若在字典檔有找到且非空白，就一律更新
         #160419 以字典檔為主，若是字典檔與外顯表不一致時才更新
         IF (NOT li_result AND NOT cl_null(lc_gzzd005_new) ) OR (NOT li_result2 AND NOT cl_null(lc_gzzd006_new) ) THEN
         #   #檢查過單號是否已超過筆數
         #   CALL azzp110_chk_dzld_rows()
         #   IF NOT g_chk_status THEN
         #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
         #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
         #   CALL g_gen_ch.writeLine(lc_msg)
         #      RETURN
         #   END IF
 
            LET lc_gzzd005_old = ""
            LET lc_gzzd006_old = ""
            LET li_count = 0
            
            SELECT COUNT(*)  INTO li_count FROM gzzd_t
             WHERE gzzd001 = lc_gzzd001
               AND gzzd002 = la_gzzy[li_cnt].gzzy001
               AND gzzd003 = lc_gzzd003
               AND gzzd004 = lc_std_or_cust
           
            IF li_count = 0 THEN
               #填寫過單資訊，需檢核是否存在主檔中
               LET lc_count = 0
               LET lc_item1 = "NULL"
               LET lc_item2 = "NULL"
               SELECT COUNT(1) INTO lc_count FROM gzzd_t
                WHERE gzzd001 = lc_gzzd001
               IF lc_count > 0 THEN
               #   IF NOT azzp110_insert_dzld('gzzd_t','azzi902',lc_gzzd001,' ') THEN
               #      LET g_chk_status = FALSE
               #      RETURN
               #   END IF
                  LET lc_item1 = "azzi902"
                  LET lc_item2 = lc_gzzd001
               END IF
            
               INSERT INTO gzzd_t(gzzdstus,gzzd001,gzzd002,gzzd003,gzzd004,gzzd005,gzzd006,
                                  gzzdcrtid,gzzdcrtdp,gzzdcrtdt,gzzdownid,gzzdowndp)
                  VALUES('Y',lc_gzzd001,la_gzzy[li_cnt].gzzy001,lc_gzzd003,lc_std_or_cust,lc_gzzd005_new,lc_gzzd006_new,
                         lc_gzzdcrtid,lc_gzzdcrtdp,lc_gzzdcrtdt,lc_gzzdownid,lc_gzzdowndp)
               
               IF SQLCA.SQLCODE THEN
                  LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(insert)gzzd_t失敗...  gzzd001:",lc_gzzd001,"  gzzd002:",la_gzzy[li_cnt].gzzy001,
                                                          "  gzzd003:",lc_gzzd003,"  gzzd004:",lc_std_or_cust,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                  CALL g_gen_ch.writeLine(lc_msg)
                  RETURN
               END IF
               LET lc_update = "Y"
            ELSE
              SELECT gzzd005,gzzd006 INTO lc_gzzd005_old,lc_gzzd006_old FROM gzzd_t
               WHERE gzzd001 = lc_gzzd001
                 AND gzzd002 = la_gzzy[li_cnt].gzzy001
                 AND gzzd003 = lc_gzzd003
                 AND gzzd004 = lc_std_or_cust

               IF NOT SQLCA.SQLCODE THEN
                  #須以字典檔為主，但為避免字典檔的資料是空白的，卻蓋掉原有已存在的資料，所以要先做判斷
                  IF cl_null(lc_gzzd005_new) THEN
                     LET lc_gzzd005_new = lc_gzzd005_old
                  END IF
                  IF cl_null(lc_gzzd006_new) THEN
                     LET lc_gzzd006_new = lc_gzzd006_old  
                  END IF
                  
                  #IF la_gzzy[li_cnt].gzzy001 <> "zh_TW" AND (lc_gzzd005_new <> lc_gzzd005_old
                  #        OR lc_gzzd006_new <> lc_gzzd006_old) THEN
                  #16/08/15 加入 欄位 null 判斷 否則 舊值是null 的話，比對會是(null)
                  #160818-00012 start
                  IF la_gzzy[li_cnt].gzzy001 <> "zh_TW" AND (lc_gzzd005_new <> lc_gzzd005_old
                          OR lc_gzzd006_new <> lc_gzzd006_old OR lc_gzzd005_old IS NULL 
                          OR lc_gzzd006_old IS NULL ) THEN 
                  #160818-00012 end        
                     #填寫過單資訊，需檢核是否存在主檔中
                     LET lc_count = 0
                     LET lc_item1 = "NULL"
                     LET lc_item2 = "NULL"
                     SELECT COUNT(1) INTO lc_count FROM gzzd_t
                      WHERE gzzd001 = lc_gzzd001
                     IF lc_count > 0 THEN
                     #   IF NOT azzp110_insert_dzld('gzzd_t','azzi902',lc_gzzd001,' ') THEN
                     #      LET g_chk_status = FALSE
                     #      RETURN
                     #   END IF
                        LET lc_item1 = "azzi902"
                        LET lc_item2 = lc_gzzd001
                     END IF
                     
                     UPDATE gzzd_t SET gzzd005 = lc_gzzd005_new,gzzd006 = lc_gzzd006_new,
                                       gzzdmodid = lc_gzzdmodid,gzzdmoddt = lc_gzzdmoddt
                         WHERE gzzd001 = lc_gzzd001 
                           AND gzzd002 = la_gzzy[li_cnt].gzzy001
                           AND gzzd003 = lc_gzzd003
                           AND gzzd004 = lc_std_or_cust
                      
                     IF SQLCA.SQLCODE THEN
                        LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)gzzd_t失敗...  gzzd001:",lc_gzzd001,"  gzzd002:",la_gzzy[li_cnt].gzzy001,
                                                                "  gzzd003:",lc_gzzd003,"  gzzd004:",lc_std_or_cust,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                        CALL g_gen_ch.writeLine(lc_msg)
                        RETURN
                     END IF
                     LET lc_update = "Y"
                  END IF                      
               END IF 
            END IF
            
            IF lc_update = "Y" THEN
               #紀錄log
               LET lc_msg = "<tr hieght=22><td class=xl24>",la_gzzy[li_cnt].gzzy001,"</td>",   #更換語系
                                          "<td class=xl24>gzzd_t</td>",               #更換的多語言table
                                          "<td class=xl24>",g_param.docno,"</td>",    #表單單號    
                                          "<td class=xl24>",g_param.seq,"</td>",      #項次
                                          "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                          "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                          "<td class=xl24>",lc_gzzd005_old,"</td>",   #資料修改前
                                          "<td class=xl24>",lc_gzzd005_new,"</td>",   #資料修改後
                                          "<td class=xl24>",lc_gzzd006_old,"</td>",   #資料修改前
                                          "<td class=xl24>",lc_gzzd006_new,"</td>",   #資料修改後
                           "</tr>"
            
               CALL g_gen_ch.writeLine(lc_msg)
            END IF
         END IF 
         FREE s4
         FREE s5
      END FOR
   END FOREACH

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
PRIVATE FUNCTION azzp110_exp_gzdfl()
   DEFINE ls_sql STRING
   DEFINE ls_sql_gzoz STRING
   DEFINE la_gzzy DYNAMIC ARRAY OF RECORD
             gzzy001 LIKE gzzy_t.gzzy001, #語言別
             gzozcol LIKE type_t.chr10    #語言別欄位
                  END RECORD
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE lc_gzdfl001     LIKE gzdfl_t.gzdfl001
   DEFINE lc_gzdfl003_tw  LIKE gzdfl_t.gzdfl003
   DEFINE lc_gzdfl003_old LIKE gzdfl_t.gzdfl003
   DEFINE lc_gzdfl003_new LIKE gzdfl_t.gzdfl003
   DEFINE lc_count_1      LIKE type_t.num5
   DEFINE lc_count_2      LIKE type_t.num5
   DEFINE lc_gzdf001      LIKE gzdf_t.gzdf001
   DEFINE lc_msg          STRING
   DEFINE lc_update       LIKE type_t.chr1
   DEFINE lc_item1        STRING
   DEFINE lc_item2        STRING


   #若是多語言暫存檔有資料的話，要先做暫存檔轉換的部分
   #否則後續用已更新後的字典檔再去對應各多語言檔的話，怕會有缺漏
   IF gs_trans_temp = "Y" THEN
      LET ls_sql = "SELECT gzdfl001,gzdfl003 FROM gzdfl_t WHERE gzdfl002 = 'zh_TW' ORDER BY gzdfl001"

      DECLARE azzp110_trans_temp_to_gzdfl_cs CURSOR FROM ls_sql
      FOREACH azzp110_trans_temp_to_gzdfl_cs INTO lc_gzdfl001,lc_gzdfl003_old
         DISPLAY "check gzos_t  lc_gzdfl001:",lc_gzdfl001
         #檢查過單號是否已超過筆數
      #   CALL azzp110_chk_dzld_rows()
      #   IF NOT g_chk_status THEN
      #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
      #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
      #      CALL g_gen_ch.writeLine(lc_msg)
      #      RETURN
      #   END IF
         
         #從多語言暫存檔找出該語言別資料
         LET lc_gzdfl003_new = ""
         EXECUTE azzp110_get_gzos_cs USING lc_gzdfl003_old INTO lc_gzdfl003_new
         
         IF NOT SQLCA.SQLCODE AND NOT cl_null(lc_gzdfl003_new) THEN
            #填寫過單資訊，需檢核是否存在主檔中
            #需先判斷此多語言檔案會有幾個過單項(azzi900或azzi901)
            #因為可能多個過單項都有過到這個多語言檔案，
            #鴻傑說，主要是要過多語言檔，所以只要有一筆當代表就可以了，不用每個過單項都過
            LET lc_count_1 = 0
            LET lc_count_2 = 0
            LET lc_item1 = "NULL"
            LET lc_item2 = "NULL"
            SELECT DISTINCT gzdf001 INTO lc_gzdf001 FROM gzdf_t
             WHERE gzdf002 = lc_gzdfl001
                   
            #azzi900
            SELECT COUNT(*) INTO lc_count_1 FROM gzdf_t,gzza_t 
             WHERE gzza001 = gzdf001 AND gzdf002 = lc_gzdfl001
            
            IF lc_count_1 > 0 THEN
            #   IF NOT azzp110_insert_dzld('gzdfl_t','azzi900',lc_gzdf001,' ') THEN
            #      LET g_chk_status = FALSE
            #      RETURN
            #   END IF
               LET lc_item1 = "azzi900"
               LET lc_item2 = lc_gzdf001
            ELSE
               #azzi901
               SELECT COUNT(*) INTO lc_count_2 FROM gzdf_t,gzde_t 
                WHERE gzde001 = gzdf001 AND gzdf002 = lc_gzdfl001
                  
               IF lc_count_2 > 0 THEN
               #   IF azzp110_insert_dzld('gzdfl_t','azzi901',lc_gzdf001,' ') THEN
               #      LET g_chk_status = FALSE
               #      RETURN
               #   END IF
               END IF
               LET lc_item1 = "azzi901"
               LET lc_item2 = lc_gzdf001
            END IF
            
            UPDATE gzdfl_t SET gzdfl003 = lc_gzdfl003_new
             WHERE gzdfl001 = lc_gzdfl001 AND gzdfl002 = "zh_TW"
            IF SQLCA.SQLCODE THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)gzdfl_t失敗...  gzdfl001:",lc_gzdfl001,"  gzdfl002:zh_TW","  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
               CALL g_gen_ch.writeLine(lc_msg)
               RETURN
            END IF
            
            #紀錄log
            LET lc_msg = "<tr hieght=22><td class=xl24>zh_TW</td>",                #更換語系
                                       "<td class=xl24>gzdfl_t</td>",              #更換的多語言table
                                       "<td class=xl24>",g_param.docno,"</td>",    #表單單號    
                                       "<td class=xl24>",g_param.seq,"</td>",      #項次
                                       "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                       "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                       "<td class=xl24>",lc_gzdfl003_old,"</td>",  #資料修改前
                                       "<td class=xl24>",lc_gzdfl003_new,"</td>",  #資料修改後
                         "</tr>"
            
            CALL g_gen_ch.writeLine(lc_msg)
         END IF
      END FOREACH
   END IF

   ########開始進行字典檔匯出至多語言檔的動作##########
   LET ls_sql = "SELECT gzdfl001,gzdfl003 FROM gzdfl_t WHERE gzdfl002 = 'zh_TW' ORDER BY gzdfl001"

   #取出語言種類與項目
   LET la_gzzy = azzp110_get_gzzy() #除了zh_TW 之外

   DECLARE exp_gzdfl_cs CURSOR FROM ls_sql
   FOREACH exp_gzdfl_cs INTO lc_gzdfl001,lc_gzdfl003_tw
      DISPLAY "check gzoz_t  lc_gzdfl001:",lc_gzdfl001
      #跑單身陣列
      FOR li_cnt = 1 TO la_gzzy.getLength()
         LET lc_update = "N"
         
         #以繁體中文為主
         LET lc_gzdfl003_new = ""
         LET ls_sql_gzoz = "SELECT ",la_gzzy[li_cnt].gzozcol CLIPPED,
                            " FROM gzoz_t WHERE gzoz000= '",lc_gzdfl003_tw CLIPPED,"' "
         PREPARE s6 FROM ls_sql_gzoz
         EXECUTE s6 INTO lc_gzdfl003_new
         #如果有資料且該筆資料不是null  
         #然後判斷該語言別是否有資料 沒有資料就insert 有資料確認該筆資料是否是null，是就update 
         #160303 改為以字典檔為主，若在字典檔有找到且非空白，就一律更新
         IF NOT SQLCA.SQLCODE AND NOT cl_null(lc_gzdfl003_new) THEN
            #檢查過單號是否已超過筆數
         #   CALL azzp110_chk_dzld_rows()
         #   IF NOT g_chk_status THEN
         #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
         #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
         #   CALL g_gen_ch.writeLine(lc_msg)
         #      RETURN
         #   END IF

            LET lc_gzdfl003_old = ""
            SELECT gzdfl003 INTO lc_gzdfl003_old FROM gzdfl_t
             WHERE gzdfl001 = lc_gzdfl001
               AND gzdfl002 = la_gzzy[li_cnt].gzzy001
            IF SQLCA.SQLCODE THEN
               #填寫過單資訊，需檢核是否存在主檔中
               #需先判斷此多語言檔案會有幾個過單項(azzi900或azzi901)
               #因為可能多個過單項都有過到這個多語言檔案，
               #鴻傑說，主要是要過多語言檔，所以只要有一筆當代表就可以了，不用每個過單項都過
               LET lc_count_1 = 0
               LET lc_count_2 = 0
               LET lc_item1 = "NULL"
               LET lc_item2 = "NULL"
               SELECT DISTINCT gzdf001 INTO lc_gzdf001 FROM gzdf_t
                WHERE gzdf002 = lc_gzdfl001
                      
               #azzi900
               SELECT COUNT(*) INTO lc_count_1 FROM gzdf_t,gzza_t 
                WHERE gzza001 = gzdf001 AND gzdf002 = lc_gzdfl001
               
               IF lc_count_1 > 0 THEN
               #   IF NOT azzp110_insert_dzld('gzdfl_t','azzi900',lc_gzdf001,' ') THEN
               #      LET g_chk_status = FALSE
               #      RETURN
               #   END IF
                  LET lc_item1 = "azzi900"
                  LET lc_item2 = lc_gzdf001
               ELSE
                  #azzi901
                  SELECT COUNT(*) INTO lc_count_2 FROM gzdf_t,gzde_t 
                   WHERE gzde001 = gzdf001 AND gzdf002 = lc_gzdfl001
                     
                  IF lc_count_2 > 0 THEN
                  #   IF NOT azzp110_insert_dzld('gzdfl_t','azzi901',lc_gzdf001,' ') THEN
                  #      LET g_chk_status = FALSE
                  #      RETURN
                  #   END IF
                     LET lc_item1 = "azzi901"
                     LET lc_item2 = lc_gzdf001
                  END IF
               END IF
            
               INSERT INTO gzdfl_t(gzdfl001,gzdfl002,gzdfl003)
                  VALUES(lc_gzdfl001,la_gzzy[li_cnt].gzzy001,lc_gzdfl003_new)
               
               IF SQLCA.SQLCODE THEN
                  LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(insert)gzdfl_t失敗...  gzdfl001:",lc_gzdfl001,"  gzdfl002:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                  CALL g_gen_ch.writeLine(lc_msg)
                  RETURN
               END IF
               LET lc_update = "Y"
            ELSE
               IF la_gzzy[li_cnt].gzzy001 <> "zh_TW" AND lc_gzdfl003_new <> lc_gzdfl003_old THEN
                  #填寫過單資訊，需檢核是否存在主檔中
                  #需先判斷此多語言檔案會有幾個過單項(azzi900或azzi901)
                  #因為可能多個過單項都有過到這個多語言檔案，
                  #鴻傑說，主要是要過多語言檔，所以只要有一筆當代表就可以了，不用每個過單項都過
                  LET lc_count_1 = 0
                  LET lc_count_2 = 0
                  LET lc_item1 = "NULL"
                  LET lc_item2 = "NULL"
                  SELECT DISTINCT gzdf001 INTO lc_gzdf001 FROM gzdf_t
                   WHERE gzdf002 = lc_gzdfl001
                         
                  #azzi900
                  SELECT COUNT(*) INTO lc_count_1 FROM gzdf_t,gzza_t 
                   WHERE gzza001 = gzdf001 AND gzdf002 = lc_gzdfl001
                  
                  IF lc_count_1 > 0 THEN
                  #   IF NOT azzp110_insert_dzld('gzdfl_t','azzi900',lc_gzdf001,' ') THEN
                  #      LET g_chk_status = FALSE
                  #      RETURN
                  #   END IF
                     LET lc_item1 = "azzi900"
                     LET lc_item2 = lc_gzdf001
                  ELSE
                     #azzi901
                     SELECT COUNT(*) INTO lc_count_2 FROM gzdf_t,gzde_t 
                      WHERE gzde001 = gzdf001 AND gzdf002 = lc_gzdfl001
                        
                     IF lc_count_2 > 0 THEN
                     #   IF NOT azzp110_insert_dzld('gzdfl_t','azzi901',lc_gzdf001,' ') THEN
                     #      LET g_chk_status = FALSE
                     #      RETURN
                     #   END IF
                        LET lc_item1 = "azzi901"
                        LET lc_item2 = lc_gzdf001
                     END IF
                  END IF
            
                  UPDATE gzdfl_t SET gzdfl003 = lc_gzdfl003_new
                   WHERE gzdfl001 = lc_gzdfl001 AND gzdfl002 = la_gzzy[li_cnt].gzzy001
                 
                  IF SQLCA.SQLCODE THEN
                     LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)gzdfl_t失敗...  gzdfl001:",lc_gzdfl001,"  gzdfl002:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                     CALL g_gen_ch.writeLine(lc_msg)
                     RETURN
                  END IF
                  LET lc_update = "Y"
               END IF
            END IF
            
            IF lc_update = "Y" THEN
               #紀錄log
               LET lc_msg = "<tr hieght=22><td class=xl24>",la_gzzy[li_cnt].gzzy001,"</td>",   #更換語系
                                          "<td class=xl24>gzdfl_t</td>",              #更換的多語言table
                                          "<td class=xl24>",g_param.docno,"</td>",    #表單單號    
                                          "<td class=xl24>",g_param.seq,"</td>",      #項次
                                          "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                          "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                          "<td class=xl24>",lc_gzdfl003_old,"</td>",  #資料修改前
                                          "<td class=xl24>",lc_gzdfl003_new,"</td>",  #資料修改後
                            "</tr>"
               
               CALL g_gen_ch.writeLine(lc_msg)
            END IF
         END IF
         FREE s6

      END FOR
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_exp_gzzq()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_exp_gzzq()
   DEFINE ls_sql STRING
   DEFINE ls_sql_gzoz STRING
   DEFINE la_gzzy DYNAMIC ARRAY OF RECORD
             gzzy001 LIKE gzzy_t.gzzy001, #語言別
             gzozcol LIKE type_t.chr10    #語言別欄位
                  END RECORD
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE lc_gzzq001      LIKE gzzq_t.gzzq001
   DEFINE lc_gzzq002      LIKE gzzq_t.gzzq002
   DEFINE lc_gzzq004_tw   LIKE gzzq_t.gzzq004
   DEFINE lc_gzzq004_old  LIKE gzzq_t.gzzq004
   DEFINE lc_gzzq004_new  LIKE gzzq_t.gzzq004
   DEFINE lc_gzzq005_tw   LIKE gzzq_t.gzzq005
   DEFINE lc_gzzq005_old  LIKE gzzq_t.gzzq005
   DEFINE lc_gzzq005_new  LIKE gzzq_t.gzzq005
   DEFINE lc_std_or_cust  LIKE type_t.chr1
   DEFINE li_result       LIKE type_t.num5
   DEFINE li_result2      LIKE type_t.num5
   DEFINE li_count        LIKE type_t.num5
   DEFINE lc_count        LIKE type_t.num5
   DEFINE lc_msg          STRING
   DEFINE lc_update       LIKE type_t.chr1
   DEFINE lc_item1        STRING
   DEFINE lc_item2        STRING
   

   #gzzd 有標準及客製
   LET lc_std_or_cust = FGL_GETENV("DGENV")
   
   #若是多語言暫存檔有資料的話，要先做暫存檔轉換的部分
   #否則後續用已更新後的字典檔再去對應各多語言檔的話，怕會有缺漏
   IF gs_trans_temp = "Y" THEN
      LET ls_sql = "SELECT gzzq001,gzzq002,gzzq004,gzzq005 FROM gzzq_t",
                " WHERE gzzq003 = 'zh_TW' AND gzzq006 ='",lc_std_or_cust CLIPPED,"'",
                " ORDER BY gzzq001"
                
      DECLARE azzp110_trans_temp_to_gzzq_cs CURSOR FROM ls_sql
      FOREACH azzp110_trans_temp_to_gzzq_cs INTO lc_gzzq001,lc_gzzq002,lc_gzzq004_old,lc_gzzq005_old
         DISPLAY "check gzos_t  lc_gzzq001:",lc_gzzq001," lc_gzzq002:",lc_gzzq002 ," lc_gzzq004_old:",lc_gzzq004_old ," lc_gzzq005_old:",lc_gzzq005_old
         #檢查過單號是否已超過筆數
      #   CALL azzp110_chk_dzld_rows()
      #   IF NOT g_chk_status THEN
      #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
      #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
      #      CALL g_gen_ch.writeLine(lc_msg)
      #      RETURN
      #   END IF
         
         #從多語言暫存檔找出該語言別資料
         LET lc_gzzq004_new = ""
         EXECUTE azzp110_get_gzos_cs USING lc_gzzq004_old INTO lc_gzzq004_new
         LET li_result = SQLCA.SQLCODE

         #從多語言暫存檔找出該語言別資料
         LET lc_gzzq005_new = ""
         EXECUTE azzp110_get_gzos_cs USING lc_gzzq005_old INTO lc_gzzq005_new
         LET li_result2 = SQLCA.SQLCODE
         
         #如果有資料且該筆資料不是null  
         #然後判斷該語言別是否有資料 沒有資料就insert 有資料確認該筆資料是否是null，是就update 
         #160303 改為以字典檔為主，若在字典檔有找到且非空白，就一律更新
         IF (NOT li_result AND NOT cl_null(lc_gzzq004_new) ) OR (NOT li_result2 AND NOT cl_null(lc_gzzq005_new) ) THEN
            #填寫過單資訊，需檢核是否存在主檔中
            LET lc_count = 0
            LET lc_item1 = "NULL"
            LET lc_item2 = "NULL"
            SELECT COUNT(1) INTO lc_count FROM gzzp_t 
             WHERE gzzp001 = lc_gzzq001
            
            IF lc_count > 0 THEN
            #   IF NOT azzp110_insert_dzld('gzzq_t','azzi903',lc_gzzq001,' ') THEN
            #      LET g_chk_status = FALSE
            #      RETURN
            #   END IF
               LET lc_item1 = "azzi903"
               LET lc_item2 = lc_gzzq001
            END IF
            
            IF cl_null(lc_gzzq004_new) THEN
               LET lc_gzzq004_new = lc_gzzq004_old
            END IF
            IF cl_null(lc_gzzq005_new) THEN
               LET lc_gzzq005_new = lc_gzzq005_old
            END IF
            UPDATE gzzq_t SET gzzq004 = lc_gzzq004_new,gzzq005 = lc_gzzq005_new
             WHERE gzzq001 = lc_gzzq001 
               AND gzzq002 = lc_gzzq002
               AND gzzq003 = "zh_TW"
               AND gzzq006 = lc_std_or_cust
           
            IF SQLCA.SQLCODE THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)gzzq_t失敗...  gzzq001:",lc_gzzq001,"  gzzq002:",lc_gzzq002,
                                                       "  gzzq003:zh_TW","  gzzq006:",lc_std_or_cust,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
               CALL g_gen_ch.writeLine(lc_msg)
               RETURN
            END IF
            
            #紀錄log
            LET lc_msg = "<tr hieght=22><td class=xl24>zh_TW</td>",                #更換語系
                                       "<td class=xl24>gzzq_t</td>",               #更換的多語言table
                                       "<td class=xl24>",g_param.docno,"</td>",    #表單單號    
                                       "<td class=xl24>",g_param.seq,"</td>",      #項次
                                       "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                       "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                       "<td class=xl24>",lc_gzzq004_old,"</td>",   #資料修改前
                                       "<td class=xl24>",lc_gzzq004_new,"</td>",   #資料修改後
                                       "<td class=xl24>",lc_gzzq005_old,"</td>",   #資料修改前
                                       "<td class=xl24>",lc_gzzq005_new,"</td>",   #資料修改後
                         "</tr>"
            
            CALL g_gen_ch.writeLine(lc_msg)
         END IF 
      END FOREACH
   END IF
   
   ########開始進行字典檔匯出至多語言檔的動作##########
   LET ls_sql = "SELECT gzzq001,gzzq002,gzzq004,gzzq005 FROM gzzq_t",
                " WHERE gzzq003 = 'zh_TW' AND gzzq006 ='",lc_std_or_cust CLIPPED,"'",
                " ORDER BY gzzq001"

   #取出語言種類與項目
   LET la_gzzy = azzp110_get_gzzy()

   DECLARE exp_gzzq_cs CURSOR FROM ls_sql
   FOREACH exp_gzzq_cs INTO lc_gzzq001,lc_gzzq002,lc_gzzq004_tw,lc_gzzq005_tw
      DISPLAY "check gzoz_t  lc_gzzq001:",lc_gzzq001 ," lc_gzzq002:",lc_gzzq002 ," lc_gzzq004_tw:",lc_gzzq004_tw," lc_gzzq005_tw:",lc_gzzq004_tw
      #跑單身陣列
      FOR li_cnt = 1 TO la_gzzy.getLength()
         LET lc_update = "N"

         #以繁體中文為主
         LET lc_gzzq004_new = ""
         LET ls_sql_gzoz = "SELECT ",la_gzzy[li_cnt].gzozcol CLIPPED,
                            " FROM gzoz_t WHERE gzoz000= '",lc_gzzq004_tw CLIPPED,"' "
         PREPARE s7 FROM ls_sql_gzoz
         EXECUTE s7 INTO lc_gzzq004_new
         LET li_result = SQLCA.SQLCODE

         #以繁體中文為主
         LET lc_gzzq005_new = ""
         LET ls_sql_gzoz = "SELECT ",la_gzzy[li_cnt].gzozcol CLIPPED,
                            " FROM gzoz_t WHERE gzoz000= '",lc_gzzq005_tw CLIPPED,"' "
         PREPARE s8 FROM ls_sql_gzoz
         EXECUTE s8 INTO lc_gzzq005_new
         
         #如果有資料且該筆資料不是null  
         #然後判斷該語言別是否有資料 沒有資料就insert 有資料確認該筆資料是否是null，是就update 
         #160303 改為以字典檔為主，若在字典檔有找到且非空白，就一律更新
         IF (NOT li_result AND NOT cl_null(lc_gzzq004_new) ) OR (NOT li_result2 AND NOT cl_null(lc_gzzq005_new) ) THEN
            #檢查過單號是否已超過筆數
         #   CALL azzp110_chk_dzld_rows()
         #   IF NOT g_chk_status THEN
         #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
         #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
         #   CALL g_gen_ch.writeLine(lc_msg)
         #      RETURN
         #   END IF

            LET lc_gzzq004_old = ""
            LET lc_gzzq005_old = ""
            LET li_count = 0
            
            SELECT COUNT(*) INTO li_count FROM gzzq_t
             WHERE gzzq001 = lc_gzzq001
               AND gzzq002 = lc_gzzq002
               AND gzzq003 = la_gzzy[li_cnt].gzzy001
               AND gzzq006 = lc_std_or_cust
             DISPLAY "li_count:",li_count ," la_gzzy[li_cnt].gzzy001:",la_gzzy[li_cnt].gzzy001 ," lc_gzzq001:",lc_gzzq001 ," lc_gzzq002:",lc_gzzq002 ," lc_std_or_cust:",lc_std_or_cust
               
            IF li_count = 0 THEN
               #填寫過單資訊，需檢核是否存在主檔中
               LET lc_count = 0
               LET lc_item1 = "NULL"
               LET lc_item2 = "NULL"
               SELECT COUNT(1) INTO lc_count FROM gzzp_t 
                WHERE gzzp001 = lc_gzzq001
               
               IF lc_count > 0 THEN
               #   IF NOT azzp110_insert_dzld('gzzq_t','azzi903',lc_gzzq001,' ') THEN
               #      LET g_chk_status = FALSE
               #      RETURN
               #   END IF
                  LET lc_item1 = "azzi903"
                  LET lc_item2 = lc_gzzq001
               END IF
            
               INSERT INTO gzzq_t(gzzq001,gzzq002,gzzq003,gzzq004,gzzq005,gzzq006)
                  VALUES(lc_gzzq001,lc_gzzq002,la_gzzy[li_cnt].gzzy001,lc_gzzq004_new,lc_gzzq005_new,lc_std_or_cust)
               
               IF SQLCA.SQLCODE THEN
                  LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(insert)gzzq_t失敗...  gzzq001:",lc_gzzq001,"  gzzq002:",lc_gzzq002,
                                                          "  gzzq003:",la_gzzy[li_cnt].gzzy001,"  gzzq006:",lc_std_or_cust,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                  CALL g_gen_ch.writeLine(lc_msg)
                  RETURN
               END IF
               LET lc_update = "Y"
            ELSE
               SELECT gzzq004,gzzq005 INTO lc_gzzq004_old,lc_gzzq005_old FROM gzzq_t
                WHERE gzzq001 = lc_gzzq001
                  AND gzzq002 = lc_gzzq002
                  AND gzzq003 = la_gzzy[li_cnt].gzzy001
                  AND gzzq006 = lc_std_or_cust
               DISPLAY "lc_gzzq004_old:",lc_gzzq004_old ," lc_gzzq005_old:",lc_gzzq005_old ," lc_gzzq001:",lc_gzzq001 ," lc_gzzq002:",lc_gzzq002 ," lc_std_or_cust:",lc_std_or_cust
               DISPLAY "lc_gzzq004_new:",lc_gzzq004_new ," lc_gzzq005_new:",lc_gzzq005_new ," la_gzzy[li_cnt].gzzy001:",la_gzzy[li_cnt].gzzy001
               DISPLAY "SQLCA.SQLCODE:",SQLCA.SQLCODE

               IF NOT SQLCA.SQLCODE THEN
                  #須以字典檔為主，但為避免字典檔的資料是空白的，卻蓋掉原有已存在的資料，所以要先做判斷
                  IF cl_null(lc_gzzq004_new) THEN
                     LET lc_gzzq004_new = lc_gzzq004_old
                  END IF
                  IF cl_null(lc_gzzq005_new) THEN
                     LET lc_gzzq005_new = lc_gzzq005_old
                  END IF
                  
                  #IF la_gzzy[li_cnt].gzzy001 <> "zh_TW" AND (lc_gzzq004_new <> lc_gzzq004_old
                  #      OR lc_gzzq005_new <> lc_gzzq005_old) THEN
                  #16/08/15 加入 欄位 null 判斷 否則 舊值是null 的話，比對會是(null)  
                  #160818-00012 start
                  IF la_gzzy[li_cnt].gzzy001 <> "zh_TW" AND (lc_gzzq004_new <> lc_gzzq004_old
                        OR lc_gzzq005_new <> lc_gzzq005_old OR lc_gzzq004_old IS NULL 
                        OR lc_gzzq005_old IS NULL) THEN   
                  #160818-00012 end
                  
                      #填寫過單資訊，需檢核是否存在主檔中
                     LET lc_count = 0
                     LET lc_item1 = "NULL"
                     LET lc_item2 = "NULL"
                     SELECT COUNT(1) INTO lc_count FROM gzzp_t 
                      WHERE gzzp001 = lc_gzzq001
                     
                     IF lc_count > 0 THEN
                     #   IF NOT azzp110_insert_dzld('gzzq_t','azzi903',lc_gzzq001,' ') THEN
                     #      LET g_chk_status = FALSE
                     #      RETURN
                     #   END IF
                        LET lc_item1 = "azzi903"
                        LET lc_item2 = lc_gzzq001
                     END IF
            
                     UPDATE gzzq_t SET gzzq004 = lc_gzzq004_new,gzzq005 = lc_gzzq005_new
                      WHERE gzzq001 = lc_gzzq001 
                        AND gzzq002 = lc_gzzq002
                        AND gzzq003 = la_gzzy[li_cnt].gzzy001
                        AND gzzq006 = lc_std_or_cust
                     
                     IF SQLCA.SQLCODE THEN
                        LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)gzzq_t失敗...  gzzq001:",lc_gzzq001,"  gzzq002:",lc_gzzq002,
                                                                "  gzzq003:",la_gzzy[li_cnt].gzzy001,"  gzzq006:",lc_std_or_cust,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                        CALL g_gen_ch.writeLine(lc_msg)
                        RETURN
                     END IF
                     LET lc_update = "Y"
                  END IF
               END IF 
            END IF
            
            IF lc_update = "Y" THEN
               #紀錄log
               LET lc_msg = "<tr hieght=22><td class=xl24>",la_gzzy[li_cnt].gzzy001,"</td>",   #更換語系
                                          "<td class=xl24>gzzq_t</td>",               #更換的多語言table
                                          "<td class=xl24>",g_param.docno,"</td>",    #表單單號    
                                          "<td class=xl24>",g_param.seq,"</td>",      #項次
                                          "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                          "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                          "<td class=xl24>",lc_gzzq004_old,"</td>",   #資料修改前
                                          "<td class=xl24>",lc_gzzq004_new,"</td>",   #資料修改後
                                          "<td class=xl24>",lc_gzzq005_old,"</td>",   #資料修改前
                                          "<td class=xl24>",lc_gzzq005_new,"</td>",   #資料修改後
                            "</tr>"
               
               CALL g_gen_ch.writeLine(lc_msg)
            END IF
         END IF 
         FREE s7
         FREE s8

      END FOR
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_exp_gzswl()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_exp_gzswl()
   DEFINE ls_sql STRING
   DEFINE ls_sql_gzoz STRING
   DEFINE la_gzzy DYNAMIC ARRAY OF RECORD
             gzzy001 LIKE gzzy_t.gzzy001, #語言別
             gzozcol LIKE type_t.chr10    #語言別欄位
                  END RECORD
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE lc_gzswl001     LIKE gzswl_t.gzswl001
   DEFINE lc_gzswl002     LIKE gzswl_t.gzswl002
   DEFINE lc_gzswl004_tw  LIKE gzswl_t.gzswl004
   DEFINE lc_gzswl004_old LIKE gzswl_t.gzswl004
   DEFINE lc_gzswl004_new LIKE gzswl_t.gzswl004
   DEFINE lc_count        LIKE type_t.num5
   DEFINE lc_msg          STRING
   DEFINE lc_update       LIKE type_t.chr1
   DEFINE lc_item1        STRING
   DEFINE lc_item2        STRING
   

   #若是多語言暫存檔有資料的話，要先做暫存檔轉換的部分
   #否則後續用已更新後的字典檔再去對應各多語言檔的話，怕會有缺漏
   IF gs_trans_temp = "Y" THEN
      LET ls_sql = "SELECT gzswl001,gzswl002,gzswl004 FROM gzswl_t ",
                " WHERE gzswl003 = 'zh_TW' ORDER BY gzswl001"

      DECLARE azzp110_trans_temp_to_gzswl_cs CURSOR FROM ls_sql
      FOREACH azzp110_trans_temp_to_gzswl_cs INTO lc_gzswl001,lc_gzswl002,lc_gzswl004_old
         DISPLAY "check gzos_t  lc_gzswl001:",lc_gzswl001
         #檢查過單號是否已超過筆數
      #   CALL azzp110_chk_dzld_rows()
      #   IF NOT g_chk_status THEN
      #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
      #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
      #      CALL g_gen_ch.writeLine(lc_msg)
      #      RETURN
      #   END IF
      
         #從多語言暫存檔找出該語言別資料
         LET lc_gzswl004_new = ""
         EXECUTE azzp110_get_gzos_cs USING lc_gzswl004_old INTO lc_gzswl004_new
         
         IF NOT SQLCA.SQLCODE AND NOT cl_null(lc_gzswl004_new) THEN
            #填寫過單資訊，需檢核是否存在主檔中
            LET lc_count = 0
            LET lc_item1 = "NULL"
            LET lc_item2 = "NULL"
            SELECT COUNT(1) INTO lc_count FROM gzsx_t 
             WHERE gzsx001 = lc_gzswl001
            
            IF lc_count > 0 THEN
            #   IF NOT azzp110_insert_dzld('gzswl_t','azzi993',lc_gzswl001,' ') THEN
            #      LET g_chk_status = FALSE
            #      RETURN
            #   END IF
               LET lc_item1 = "azzi993"
               LET lc_item2 = lc_gzswl001
            END IF
            
            UPDATE gzswl_t SET gzswl004 = lc_gzswl004_new
             WHERE gzswl001 = lc_gzswl001
               AND gzswl002 = lc_gzswl002
               AND gzswl003 = "zh_TW"                  

            IF SQLCA.SQLCODE THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)gzswl_t失敗...  gzswl001:",lc_gzswl001,"  gzswl002:",lc_gzswl002,
                                                         "  gzswl003:zh_TW","  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
               CALL g_gen_ch.writeLine(lc_msg)
               RETURN
            END IF

            #紀錄log
            LET lc_msg = "<tr hieght=22><td class=xl24>zh_TW</td>",                #更換語系
                                       "<td class=xl24>gzswl_t</td>",              #更換的多語言table
                                       "<td class=xl24>",g_param.docno,"</td>",    #表單單號    
                                       "<td class=xl24>",g_param.seq,"</td>",      #項次
                                       "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                       "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                       "<td class=xl24>",lc_gzswl004_old,"</td>",  #資料修改前
                                       "<td class=xl24>",lc_gzswl004_new,"</td>",  #資料修改後
                         "</tr>"
            
            CALL g_gen_ch.writeLine(lc_msg)
         END IF
      END FOREACH
   END IF

   ########開始進行字典檔匯出至多語言檔的動作##########
   LET ls_sql = "SELECT gzswl001,gzswl002,gzswl004 FROM gzswl_t ",
                " WHERE gzswl003 = 'zh_TW' ORDER BY gzswl001"

   #取出語言種類與項目
   LET la_gzzy = azzp110_get_gzzy() #除了zh_TW 之外

   DECLARE exp_gzswl_cs CURSOR FROM ls_sql
   FOREACH exp_gzswl_cs INTO lc_gzswl001,lc_gzswl002,lc_gzswl004_tw
      DISPLAY "check gzoz_t  lc_gzswl001:",lc_gzswl001
      #跑單身陣列
      FOR li_cnt = 1 TO la_gzzy.getLength()
         LET lc_update = "N"
         
         #以繁體中文為主
         LET lc_gzswl004_new = ""
         LET ls_sql_gzoz = "SELECT ",la_gzzy[li_cnt].gzozcol CLIPPED,
                            " FROM gzoz_t WHERE gzoz000= '",lc_gzswl004_tw CLIPPED,"' "
         PREPARE s9 FROM ls_sql_gzoz
         EXECUTE s9 INTO lc_gzswl004_new
         #如果有資料且該筆資料不是null  
         #然後判斷該語言別是否有資料 沒有資料就insert 有資料確認該筆資料是否是null，是就update 
         #160303 改為以字典檔為主，若在字典檔有找到且非空白，就一律更新
         IF NOT SQLCA.SQLCODE AND NOT cl_null(lc_gzswl004_new) THEN
            #檢查過單號是否已超過筆數
         #   CALL azzp110_chk_dzld_rows()
         #   IF NOT g_chk_status THEN
         #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
         #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
         #   CALL g_gen_ch.writeLine(lc_msg)
         #      RETURN
         #   END IF
 
            LET lc_gzswl004_old = ""
            SELECT gzswl004 INTO lc_gzswl004_old FROM gzswl_t
             WHERE gzswl001 = lc_gzswl001
               AND gzswl002 = lc_gzswl002
               AND gzswl003 = la_gzzy[li_cnt].gzzy001
            
            IF SQLCA.SQLCODE THEN
               #填寫過單資訊，需檢核是否存在主檔中
               LET lc_count = 0
               LET lc_item1 = "NULL"
               LET lc_item2 = "NULL"
               SELECT COUNT(1) INTO lc_count FROM gzsx_t 
                WHERE gzsx001 = lc_gzswl001
               
               IF lc_count > 0 THEN
               #   IF NOT azzp110_insert_dzld('gzswl_t','azzi993',lc_gzswl001,' ') THEN
               #      LET g_chk_status = FALSE
               #      RETURN
               #   END IF
                  LET lc_item1 = "azzi993"
                  LET lc_item2 = lc_gzswl001
               END IF
            
               INSERT INTO gzswl_t(gzswl001,gzswl002,gzswl003,gzswl004)
                  VALUES(lc_gzswl001,lc_gzswl002,la_gzzy[li_cnt].gzzy001,lc_gzswl004_new)
               
               IF SQLCA.SQLCODE THEN
                  LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(insert)gzswl_t失敗...  gzswl001:",lc_gzswl001,"  gzswl002:",lc_gzswl002,
                                                          "  gzswl003:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                  CALL g_gen_ch.writeLine(lc_msg)
                  RETURN
               END IF
               LET lc_update = "Y"
            ELSE
               IF la_gzzy[li_cnt].gzzy001 <> "zh_TW" AND lc_gzswl004_new <> lc_gzswl004_old THEN
                  #填寫過單資訊，需檢核是否存在主檔中
                  LET lc_count = 0
                  LET lc_item1 = "NULL"
                  LET lc_item2 = "NULL"
                  SELECT COUNT(1) INTO lc_count FROM gzsx_t 
                   WHERE gzsx001 = lc_gzswl001
                  
                  IF lc_count > 0 THEN
                  #   IF NOT azzp110_insert_dzld('gzswl_t','azzi993',lc_gzswl001,' ') THEN
                  #      LET g_chk_status = FALSE
                  #      RETURN
                  #   END IF
                     LET lc_item1 = "azzi993"
                     LET lc_item2 = lc_gzswl001
                  END IF
            
                  UPDATE gzswl_t SET gzswl004 = lc_gzswl004_new
                   WHERE gzswl001 = lc_gzswl001
                     AND gzswl002 = lc_gzswl002
                     AND gzswl003 = la_gzzy[li_cnt].gzzy001
                  
                  IF SQLCA.SQLCODE THEN
                     LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)gzswl_t失敗...  gzswl001:",lc_gzswl001,"  gzswl002:",lc_gzswl002,
                                                             "  gzswl003:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                     CALL g_gen_ch.writeLine(lc_msg)
                     RETURN
                  END IF
                  LET lc_update = "Y"
               END IF
            END IF
            
            IF lc_update = "Y" THEN
               #紀錄log
               LET lc_msg = "<tr hieght=22><td class=xl24>",la_gzzy[li_cnt].gzzy001,"</td>",  #更換語系
                                          "<td class=xl24>gzswl_t</td>",              #更換的多語言table
                                          "<td class=xl24>",g_param.docno,"</td>",    #表單單號    
                                          "<td class=xl24>",g_param.seq,"</td>",      #項次
                                          "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                          "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                          "<td class=xl24>",lc_gzswl004_old,"</td>",  #資料修改前
                                          "<td class=xl24>",lc_gzswl004_new,"</td>",  #資料修改後
                            "</tr>"
               
               CALL g_gen_ch.writeLine(lc_msg)
            END IF
         END IF
         FREE s9
      END FOR
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_exp_gzsxl()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_exp_gzsxl()
   DEFINE ls_sql STRING
   DEFINE ls_sql_gzoz STRING
   DEFINE la_gzzy DYNAMIC ARRAY OF RECORD
             gzzy001 LIKE gzzy_t.gzzy001, #語言別
             gzozcol LIKE type_t.chr10    #語言別欄位
                  END RECORD
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE lc_gzsxl001     LIKE gzsxl_t.gzsxl001
   DEFINE lc_gzsxl002     LIKE gzsxl_t.gzsxl002
   DEFINE lc_gzsxl003     LIKE gzsxl_t.gzsxl003
   DEFINE lc_gzsxl005_tw  LIKE gzsxl_t.gzsxl005
   DEFINE lc_gzsxl005_old LIKE gzsxl_t.gzsxl005
   DEFINE lc_gzsxl005_new LIKE gzsxl_t.gzsxl005
   DEFINE lc_count        LIKE type_t.num5
   DEFINE lc_msg          STRING
   DEFINE lc_update       LIKE type_t.chr1
   DEFINE lc_item1        STRING
   DEFINE lc_item2        STRING
   

   #若是多語言暫存檔有資料的話，要先做暫存檔轉換的部分
   #否則後續用已更新後的字典檔再去對應各多語言檔的話，怕會有缺漏
   IF gs_trans_temp = "Y" THEN
      LET ls_sql = "SELECT gzsxl001,gzsxl002,gzsxl003,gzsxl005 FROM gzsxl_t WHERE gzsxl004 = 'zh_TW' ORDER BY gzsxl001"

      DECLARE azzp110_trans_temp_to_gzsxl_cs CURSOR FROM ls_sql
      FOREACH azzp110_trans_temp_to_gzsxl_cs INTO lc_gzsxl001,lc_gzsxl002,lc_gzsxl003,lc_gzsxl005_old
         DISPLAY "check gzos_t  lc_gzsxl001:",lc_gzsxl001
         #檢查過單號是否已超過筆數
      #   CALL azzp110_chk_dzld_rows()
      #   IF NOT g_chk_status THEN
      #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
      #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
      #      CALL g_gen_ch.writeLine(lc_msg)
      #      RETURN
      #   END IF
         
         #從多語言暫存檔找出該語言別資料
         LET lc_gzsxl005_new = ""
         EXECUTE azzp110_get_gzos_cs USING lc_gzsxl005_old INTO lc_gzsxl005_new
         
         IF NOT SQLCA.SQLCODE AND NOT cl_null(lc_gzsxl005_new) THEN
            #填寫過單資訊，需檢核是否存在主檔中
            LET lc_count = 0
            LET lc_item1 = "NULL"
            LET lc_item2 = "NULL"
            SELECT COUNT(1) INTO lc_count FROM gzsx_t 
             WHERE gzsx001 = lc_gzsxl001
            
            IF lc_count > 0 THEN
            #   IF NOT azzp110_insert_dzld('gzsxl_t','azzi993',lc_gzsxl001,' ') THEN
            #      LET g_chk_status = FALSE
            #      RETURN
            #   END IF
               LET lc_item1 = "azzi993"
               LET lc_item2 = lc_gzsxl001
            END IF
            
            UPDATE gzsxl_t SET gzsxl005 = lc_gzsxl005_new
             WHERE gzsxl001 = lc_gzsxl001 
               AND gzsxl002 = lc_gzsxl002 
               AND gzsxl003 = lc_gzsxl003 
               AND gzsxl004 = "zh_TW"
            
            IF SQLCA.SQLCODE THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)gzsxl_t失敗...  gzsxl001:",lc_gzsxl001,"  gzsxl002:",lc_gzsxl002,
                                                         "  gzsxl003:",lc_gzsxl003,"  gzsxl004:zh_TW","  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
               CALL g_gen_ch.writeLine(lc_msg)
               RETURN
            END IF

            #紀錄log
            LET lc_msg = "<tr hieght=22><td class=xl24>zh_TW</td>",                #更換語系
                                       "<td class=xl24>gzsxl_t</td>",              #更換的多語言table
                                       "<td class=xl24>",g_param.docno,"</td>",    #表單單號    
                                       "<td class=xl24>",g_param.seq,"</td>",      #項次
                                       "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                       "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                       "<td class=xl24>",lc_gzsxl005_old,"</td>",  #資料修改前
                                       "<td class=xl24>",lc_gzsxl005_new,"</td>",  #資料修改後
                         "</tr>"
            
            CALL g_gen_ch.writeLine(lc_msg)
         END IF
      END FOREACH
   END IF

   ########開始進行字典檔匯出至多語言檔的動作##########
   LET ls_sql = "SELECT gzsxl001,gzsxl002,gzsxl003,gzsxl005 FROM gzsxl_t WHERE gzsxl004 = 'zh_TW' ORDER BY gzsxl001"

   #取出語言種類與項目
   LET la_gzzy = azzp110_get_gzzy() #除了zh_TW 之外

   DECLARE exp_gzsxl_cs CURSOR FROM ls_sql
   FOREACH exp_gzsxl_cs INTO lc_gzsxl001,lc_gzsxl002,lc_gzsxl003,lc_gzsxl005_tw
      DISPLAY "check gzoz_t  lc_gzsxl001:",lc_gzsxl001
      #跑單身陣列
      FOR li_cnt = 1 TO la_gzzy.getLength()
         LET lc_update = "N"
         
         #以繁體中文為主
         LET lc_gzsxl005_new = ""
         LET ls_sql_gzoz = "SELECT ",la_gzzy[li_cnt].gzozcol CLIPPED,
                            " FROM gzoz_t WHERE gzoz000= '",lc_gzsxl005_tw CLIPPED,"' "
         PREPARE s10 FROM ls_sql_gzoz
         EXECUTE s10 INTO lc_gzsxl005_new
         
         #如果有資料且該筆資料不是null  
         #然後判斷該語言別是否有資料 沒有資料就insert 有資料確認該筆資料是否是null，是就update 
         #160303 改為以字典檔為主，若在字典檔有找到且非空白，就一律更新
         IF NOT SQLCA.SQLCODE AND NOT cl_null(lc_gzsxl005_new) THEN
            #檢查過單號是否已超過筆數
         #   CALL azzp110_chk_dzld_rows()
         #   IF NOT g_chk_status THEN
         #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
         #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
         #   CALL g_gen_ch.writeLine(lc_msg)
         #      RETURN
         #   END IF

            LET lc_gzsxl005_old = ""
            SELECT gzsxl005 INTO lc_gzsxl005_old FROM gzsxl_t
             WHERE gzsxl001 = lc_gzsxl001
               AND gzsxl002 = lc_gzsxl002
               AND gzsxl003 = lc_gzsxl003
               AND gzsxl004 = la_gzzy[li_cnt].gzzy001
               
            IF SQLCA.SQLCODE THEN
               #填寫過單資訊，需檢核是否存在主檔中
               LET lc_count = 0
               LET lc_item1 = "NULL"
               LET lc_item2 = "NULL"
               SELECT COUNT(1) INTO lc_count FROM gzsx_t 
                WHERE gzsx001 = lc_gzsxl001
               
               IF lc_count > 0 THEN
               #   IF NOT azzp110_insert_dzld('gzsxl_t','azzi993',lc_gzsxl001,' ') THEN
               #      LET g_chk_status = FALSE
               #      RETURN
               #   END IF
                  LET lc_item1 = "azzi993"
                  LET lc_item2 = lc_gzsxl001
               END IF
            
               INSERT INTO gzsxl_t(gzsxl001,gzsxl002,gzsxl003,gzsxl004,gzsxl005)
                  VALUES(lc_gzsxl001,lc_gzsxl002,lc_gzsxl003,la_gzzy[li_cnt].gzzy001,lc_gzsxl005_new)
               
               IF SQLCA.SQLCODE THEN
                  LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(insert)gzsxl_t失敗...  gzsxl001:",lc_gzsxl001,"  gzsxl002:",lc_gzsxl002,
                                                          "  gzsxl003:",lc_gzsxl003,"  gzsxl004:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                  CALL g_gen_ch.writeLine(lc_msg)
                  RETURN
               END IF
               LET lc_update = "Y"
            ELSE
               IF la_gzzy[li_cnt].gzzy001 <> "zh_TW" AND lc_gzsxl005_new <> lc_gzsxl005_old THEN
                  #填寫過單資訊，需檢核是否存在主檔中
                  LET lc_count = 0
                  LET lc_item1 = "NULL"
                  LET lc_item2 = "NULL"
                  SELECT COUNT(1) INTO lc_count FROM gzsx_t 
                   WHERE gzsx001 = lc_gzsxl001
                  
                  IF lc_count > 0 THEN
                  #   IF NOT azzp110_insert_dzld('gzsxl_t','azzi993',lc_gzsxl001,' ') THEN
                  #      LET g_chk_status = FALSE
                  #      RETURN
                  #   END IF
                     LET lc_item1 = "azzi993"
                     LET lc_item2 = lc_gzsxl001
                  END IF
            
                  UPDATE gzsxl_t SET gzsxl005 = lc_gzsxl005_new
                   WHERE gzsxl001 = lc_gzsxl001 
                     AND gzsxl002 = lc_gzsxl002 
                     AND gzsxl003 = lc_gzsxl003 
                     AND gzsxl004 = la_gzzy[li_cnt].gzzy001
                  
                  IF SQLCA.SQLCODE THEN
                     LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)gzsxl_t失敗...  gzsxl001:",lc_gzsxl001,"  gzsxl002:",lc_gzsxl002,
                                                             "  gzsxl003:",lc_gzsxl003,"  gzsxl004:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                     CALL g_gen_ch.writeLine(lc_msg)
                     RETURN
                  END IF
                  LET lc_update = "Y"
               END IF
            END IF
            
            IF lc_update = "Y" THEN
               #紀錄log
               LET lc_msg = "<tr hieght=22><td class=xl24>",la_gzzy[li_cnt].gzzy001,"</td>",   #更換語系
                                          "<td class=xl24>gzsxl_t</td>",              #更換的多語言table
                                          "<td class=xl24>",g_param.docno,"</td>",    #表單單號    
                                          "<td class=xl24>",g_param.seq,"</td>",      #項次
                                          "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                          "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                          "<td class=xl24>",lc_gzsxl005_old,"</td>",  #資料修改前
                                          "<td class=xl24>",lc_gzsxl005_new,"</td>",  #資料修改後
                            "</tr>"
               
               CALL g_gen_ch.writeLine(lc_msg)
            END IF
         END IF
         FREE s10
      END FOR
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_exp_gzwel()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_exp_gzwel()
    DEFINE ls_sql STRING
   DEFINE ls_sql_gzoz STRING
   DEFINE la_gzzy DYNAMIC ARRAY OF RECORD
             gzzy001 LIKE gzzy_t.gzzy001, #語言別
             gzozcol LIKE type_t.chr10    #語言別欄位
                  END RECORD
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE lc_gzwelent     LIKE gzwel_t.gzwelent
   DEFINE lc_gzwel001     LIKE gzwel_t.gzwel001
   DEFINE lc_gzwel003_tw  LIKE gzwel_t.gzwel003
   DEFINE lc_gzwel003_old LIKE gzwel_t.gzwel003
   DEFINE lc_gzwel003_new LIKE gzwel_t.gzwel003
   DEFINE lc_count        LIKE type_t.num5
   DEFINE lc_msg          STRING
   DEFINE lc_update       LIKE type_t.chr1
   DEFINE lc_item1        STRING
   DEFINE lc_item2        STRING
   

   #若是多語言暫存檔有資料的話，要先做暫存檔轉換的部分
   #否則後續用已更新後的字典檔再去對應各多語言檔的話，怕會有缺漏
   IF gs_trans_temp = "Y" THEN
      LET ls_sql = "SELECT gzwelent,gzwel001,gzwel003 FROM gzwel_t ",
                   " WHERE gzwel002 = 'zh_TW' ORDER BY gzwelent,gzwel001"

      DECLARE azzp110_trans_temp_to_gzwel_cs CURSOR FROM ls_sql
      FOREACH azzp110_trans_temp_to_gzwel_cs INTO lc_gzwelent,lc_gzwel001,lc_gzwel003_old
         DISPLAY "check gzos_t  lc_gzwel001:",lc_gzwel001
         #檢查過單號是否已超過筆數
      #   CALL azzp110_chk_dzld_rows()
      #   IF NOT g_chk_status THEN
      #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
      #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
      #      CALL g_gen_ch.writeLine(lc_msg)
      #      RETURN
      #   END IF
         
         #從多語言暫存檔找出該語言別資料
         LET lc_gzwel003_new = ""
         EXECUTE azzp110_get_gzos_cs USING lc_gzwel003_old INTO lc_gzwel003_new
         
         IF NOT SQLCA.SQLCODE AND NOT cl_null(lc_gzwel003_new) THEN
            #填寫過單資訊，需檢核是否存在主檔中
            LET lc_count = 0
            LET lc_item1 = "NULL"
            LET lc_item2 = "NULL"
            SELECT COUNT(1) INTO lc_count FROM gzwe_t 
             WHERE gzwe001 = lc_gzwel001
            
            IF lc_count > 0 THEN
            #   IF NOT azzp110_insert_dzld('gzwel_t','azzi880',lc_gzwel001,' ') THEN
            #      LET g_chk_status = FALSE
            #      RETURN
            #   END IF
               LET lc_item1 = "azzi880"
               LET lc_item2 = lc_gzwel001
            END IF
            
            UPDATE gzwel_t SET gzwel003 = lc_gzwel003_new
             WHERE gzwelent = lc_gzwelent
               AND gzwel001 = lc_gzwel001
               AND gzwel002 = "zh_TW"
            
            IF SQLCA.SQLCODE THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)gzwel_t失敗...  gzwel001:",lc_gzwel001,"  gzwelent:",lc_gzwelent,
                                                       "  gzwel002:zh_TW","  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
               CALL g_gen_ch.writeLine(lc_msg)
               RETURN
            END IF
 
            #紀錄log
            LET lc_msg = "<tr hieght=22><td class=xl24>zh_TW</td>",                #更換語系
                                       "<td class=xl24>gzwel_t</td>",              #更換的多語言table
                                       "<td class=xl24>",g_param.docno,"</td>",    #表單單號    
                                       "<td class=xl24>",g_param.seq,"</td>",      #項次
                                       "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                       "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                       "<td class=xl24>",lc_gzwel003_old,"</td>",  #資料修改前
                                       "<td class=xl24>",lc_gzwel003_new,"</td>",  #資料修改後
                         "</tr>"
            
            CALL g_gen_ch.writeLine(lc_msg)
         END IF
      END FOREACH
   END IF

   ########開始進行字典檔匯出至多語言檔的動作##########
   LET ls_sql = "SELECT gzwelent,gzwel001,gzwel003 FROM gzwel_t ",
                " WHERE gzwel002 = 'zh_TW' ORDER BY gzwelent,gzwel001"

   #取出語言種類與項目
   LET la_gzzy = azzp110_get_gzzy()  #除了zh_TW 之外

   DECLARE exp_gzwel_cs CURSOR FROM ls_sql
   FOREACH exp_gzwel_cs INTO lc_gzwelent,lc_gzwel001,lc_gzwel003_tw
      DISPLAY "check gzoz_t  lc_gzwel001:",lc_gzwel001
      #跑單身陣列
      FOR li_cnt = 1 TO la_gzzy.getLength()
         LET lc_update = "N"
         
         #以繁體中文為主
         LET lc_gzwel003_new = ""
         LET ls_sql_gzoz = "SELECT ",la_gzzy[li_cnt].gzozcol CLIPPED,
                            " FROM gzoz_t WHERE gzoz000= '",lc_gzwel003_tw CLIPPED,"' "
         PREPARE s13 FROM ls_sql_gzoz
         EXECUTE s13 INTO lc_gzwel003_new
         
         #如果有資料且該筆資料不是null
         #然後判斷該語言別是否有資料 沒有資料就insert 有資料確認該筆資料是否是null，是就update
         #160303 改為以字典檔為主，若在字典檔有找到且非空白，就一律更新
         IF NOT SQLCA.SQLCODE AND NOT cl_null(lc_gzwel003_new) THEN
            #檢查過單號是否已超過筆數
         #   CALL azzp110_chk_dzld_rows()
         #   IF NOT g_chk_status THEN
         #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
         #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
         #   CALL g_gen_ch.writeLine(lc_msg)
         #      RETURN
         #   END IF

            LET lc_gzwel003_old = ""
            SELECT gzwel003 INTO lc_gzwel003_old FROM gzwel_t
             WHERE gzwelent = lc_gzwelent
               AND gzwel001 = lc_gzwel001
               AND gzwel002 = la_gzzy[li_cnt].gzzy001
            IF SQLCA.SQLCODE THEN
               #填寫過單資訊，需檢核是否存在主檔中
               LET lc_count = 0
               LET lc_item1 = "NULL"
               LET lc_item2 = "NULL"
               SELECT COUNT(1) INTO lc_count FROM gzwe_t 
                WHERE gzwe001 = lc_gzwel001
               
               IF lc_count > 0 THEN
               #   IF NOT azzp110_insert_dzld('gzwel_t','azzi880',lc_gzwel001,' ') THEN
               #      LET g_chk_status = FALSE
               #      RETURN
               #   END IF
                  LET lc_item1 = "azzi880"
                  LET lc_item2 = lc_gzwel001
               END IF
            
               INSERT INTO gzwel_t(gzwelent,gzwel001,gzwel002,gzwel003)
                  VALUES(lc_gzwelent,lc_gzwel001,la_gzzy[li_cnt].gzzy001,lc_gzwel003_new)
               
               IF SQLCA.SQLCODE THEN
                  LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(insert)gzwel_t失敗...  gzwel001:",lc_gzwel001,"  gzwelent:",lc_gzwelent,
                                                          "  gzwel002:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                  CALL g_gen_ch.writeLine(lc_msg)
                  RETURN
               END IF
               LET lc_update = "Y"
            ELSE
               IF la_gzzy[li_cnt].gzzy001 <> "zh_TW" AND lc_gzwel003_new <> lc_gzwel003_old THEN
                  #填寫過單資訊，需檢核是否存在主檔中
                  LET lc_count = 0
                  LET lc_item1 = "NULL"
                  LET lc_item2 = "NULL"
                  SELECT COUNT(1) INTO lc_count FROM gzwe_t 
                   WHERE gzwe001 = lc_gzwel001
                  
                  IF lc_count > 0 THEN
                  #   IF NOT azzp110_insert_dzld('gzwel_t','azzi880',lc_gzwel001,' ') THEN
                  #      LET g_chk_status = FALSE
                  #      RETURN
                  #   END IF
                     LET lc_item1 = "azzi880"
                     LET lc_item2 = lc_gzwel001
                  END IF
            
                  UPDATE gzwel_t SET gzwel003 = lc_gzwel003_new
                   WHERE gzwelent = lc_gzwelent
                     AND gzwel001 = lc_gzwel001
                     AND gzwel002 = la_gzzy[li_cnt].gzzy001
                  
                  IF SQLCA.SQLCODE THEN
                     LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)gzwel_t失敗...  gzwel001:",lc_gzwel001,"  gzwelent:",lc_gzwelent,
                                                             "  gzwel002:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                     CALL g_gen_ch.writeLine(lc_msg)
                     RETURN
                  END IF
                  LET lc_update = "Y"
               END IF
            END IF
            
            IF lc_update = "Y" THEN
               #紀錄log
               LET lc_msg = "<tr hieght=22><td class=xl24>",la_gzzy[li_cnt].gzzy001,"</td>",    #更換語系
                                          "<td class=xl24>gzwel_t</td>",              #更換的多語言table
                                          "<td class=xl24>",g_param.docno,"</td>",    #表單單號    
                                          "<td class=xl24>",g_param.seq,"</td>",      #項次
                                          "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                          "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                          "<td class=xl24>",lc_gzwel003_old,"</td>",  #資料修改前
                                          "<td class=xl24>",lc_gzwel003_new,"</td>",  #資料修改後
                            "</tr>"
               
               CALL g_gen_ch.writeLine(lc_msg)
            END IF
         END IF
         FREE s13

      END FOR
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_exp_gzszl()
################################################################################
PRIVATE FUNCTION azzp110_exp_gzszl()
   DEFINE ls_sql STRING
   DEFINE ls_sql_gzoz STRING
   DEFINE la_gzzy DYNAMIC ARRAY OF RECORD
             gzzy001 LIKE gzzy_t.gzzy001, #語言別
             gzozcol LIKE type_t.chr10    #語言別欄位
                  END RECORD
   DEFINE li_cnt             LIKE type_t.num5
   DEFINE lc_gzszl001        LIKE gzszl_t.gzszl001
   DEFINE lc_gzszl002        LIKE gzszl_t.gzszl002
   DEFINE lc_gzszl004_tw     LIKE gzszl_t.gzszl004
   DEFINE lc_gzszl004_old    LIKE gzszl_t.gzszl004
   DEFINE lc_gzszl004_new    LIKE gzszl_t.gzszl004
   DEFINE lc_gzszl005_tw     LIKE gzszl_t.gzszl005
   DEFINE lc_gzszl005_old    LIKE gzszl_t.gzszl005
   DEFINE lc_gzszl005_new    LIKE gzszl_t.gzszl005
   DEFINE lc_gzszl006_tw     LIKE gzszl_t.gzszl006
   DEFINE lc_gzszl006_old    LIKE gzszl_t.gzszl006
   DEFINE lc_gzszl006_new    LIKE gzszl_t.gzszl006
   DEFINE lc_gzszl007_tw     LIKE gzszl_t.gzszl007
   DEFINE lc_gzszl007_old    LIKE gzszl_t.gzszl007
   DEFINE lc_gzszl007_new    LIKE gzszl_t.gzszl007
   DEFINE li_result          LIKE type_t.num5
   DEFINE li_result2         LIKE type_t.num5
   DEFINE li_result3         LIKE type_t.num5
   DEFINE li_result4         LIKE type_t.num5
   DEFINE li_count           LIKE type_t.num5
   DEFINE lc_count_1         LIKE type_t.num5
   DEFINE lc_count_2         LIKE type_t.num5
   DEFINE lc_gzsv001         LIKE gzsv_t.gzsv001
   DEFINE lc_msg             STRING
   DEFINE lc_update          LIKE type_t.chr1
   DEFINE lc_item1           STRING
   DEFINE lc_item2           STRING
   
  
   #若是多語言暫存檔有資料的話，要先做暫存檔轉換的部分
   #否則後續用已更新後的字典檔再去對應各多語言檔的話，怕會有缺漏
   IF gs_trans_temp = "Y" THEN
      LET ls_sql = "SELECT gzszl001,gzszl002,gzszl004,gzszl005,gzszl006,gzszl007 FROM gzszl_t ",
                   " WHERE gzszl003 = 'zh_TW' ORDER BY gzszl001,gzszl002"

      DECLARE azzp110_trans_temp_to_gzszl_cs CURSOR FROM ls_sql
      FOREACH azzp110_trans_temp_to_gzszl_cs INTO lc_gzszl001,lc_gzszl002,lc_gzszl004_old,lc_gzszl005_old,
                                                  lc_gzszl006_old,lc_gzszl007_old
         DISPLAY "check gzos_t  lc_gzszl001:",lc_gzszl001
         #檢查過單號是否已超過筆數
      #   CALL azzp110_chk_dzld_rows()
      #   IF NOT g_chk_status THEN
      #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
      #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
      #      CALL g_gen_ch.writeLine(lc_msg)
      #      RETURN
      #   END IF
         
         #從多語言暫存檔找出該語言別資料
         LET lc_gzszl004_new = ""
         IF NOT cl_null(lc_gzszl004_old) THEN
            EXECUTE azzp110_get_gzos_cs USING lc_gzszl004_old INTO lc_gzszl004_new
            LET li_result = SQLCA.SQLCODE
         END IF

         #從多語言暫存檔找出該語言別資料
         LET lc_gzszl005_new = ""
         IF NOT cl_null(lc_gzszl005_old) THEN
            EXECUTE azzp110_get_gzos_cs USING lc_gzszl005_old INTO lc_gzszl005_new
            LET li_result2 = SQLCA.SQLCODE
         END IF
         
         #從多語言暫存檔找出該語言別資料
         LET lc_gzszl006_new = ""
         IF NOT cl_null(lc_gzszl006_old) THEN
            EXECUTE azzp110_get_gzos_cs USING lc_gzszl006_old INTO lc_gzszl006_new
            LET li_result3 = SQLCA.SQLCODE
         END IF
         
         #從多語言暫存檔找出該語言別資料
         LET lc_gzszl007_new = ""
         IF NOT cl_null(lc_gzszl007_old) THEN
            EXECUTE azzp110_get_gzos_cs USING lc_gzszl007_old INTO lc_gzszl007_new
            LET li_result4 = SQLCA.SQLCODE
         END IF
         

         #如果有資料且該筆資料不是null
         #然後判斷該語言別是否有資料 沒有資料就insert 有資料確認該筆資料是否是null，是就update
         #160303 改為以字典檔為主，若在字典檔有找到且非空白，就一律更新
         IF (NOT li_result AND NOT cl_null(lc_gzszl004_new)) OR (NOT li_result2 AND NOT cl_null(lc_gzszl005_new)) 
            OR (NOT li_result3 AND NOT cl_null(lc_gzszl006_new)) OR (NOT li_result4 AND NOT cl_null(lc_gzszl007_new)) THEN
            
            #填寫過單資訊，需檢核是否存在主檔中
            #需先判斷此多語言檔案會有幾個過單項(azzi991或azzi993)
            #因為可能多個過單項都有過到這個多語言檔案，
            #鴻傑說，主要是要過多語言檔，所以只要有一筆當代表就可以了，不用每個過單項都過
            
            #azzi991
            #雖然gzszl_t的主表是gzsz_t，所以不管是azzi991或是azzi993都會在gzsz_t有一筆資料，
            #只是在azzi991查詢時，會限制只能查詢出'ooac_t'的資料，
            #假設參數設定項(E-SYS-0701)雖然實際有存在於gzsz_t，但此參數項不屬於單據別設定(即非azzi991可查詢到的資料)
            #所以在填過單資訊的時候，應填azzi993才對
            #因此，在搜尋此筆多語言資料是否存在於主表時，在azzi991項中，也應該加上限制只能取'ooac_t'的資料
            LET lc_count_1 = 0
            LET lc_count_2 = 0
            LET lc_item1 = "NULL"
            LET lc_item2 = "NULL"
            SELECT COUNT(1) INTO lc_count_1 FROM gzsz_t 
             WHERE gzsz001 = 'ooac_t' 
               AND gzsz001 = lc_gzsz001 AND gzsz002 = lc_gzszl002
            
            IF lc_count_1 > 0 THEN
            #   IF NOT azzp110_insert_dzld('gzszl_t','azzi991',lc_gzszl002,' ') THEN
            #      LET g_chk_status = FALSE
            #      RETURN
            #   END IF
               LET lc_item1 = "azzi991"
               LET lc_item2 = lc_gzszl002
            ELSE
               #azzi993
               SELECT DISTINCT gzsv001 INTO lc_gzsv001 FROM gzsv_t,gzsz_t
                WHERE gzsv005 = gzsz001 AND gzsv006 = gzsz002
                  AND gzsz001 = lc_gzsz001 AND gzsz002 = lc_gzszl002
             
               SELECT COUNT(1) INTO lc_count_2 FROM gzsx_t
                WHERE gzsx001 = lc_gzsv001
               
               IF lc_count_2 > 0 THEN
               #   IF NOT azzp110_insert_dzld('gzszl_t','azzi993',lc_gzsv001,' ') THEN
               #      LET g_chk_status = FALSE
               #      RETURN
               #   END IF
                  LET lc_item1 = "azzi993"
                  LET lc_item2 = lc_gzsv001
               END IF
            END IF
            
            IF cl_null(lc_gzszl004_new) THEN
               LET lc_gzszl004_new = lc_gzszl004_old 
            END IF  

            IF cl_null(lc_gzszl005_new) THEN
               LET lc_gzszl005_new = lc_gzszl005_old  
            END IF
            
            IF cl_null(lc_gzszl006_new) THEN
               LET lc_gzszl006_new = lc_gzszl006_old  
            END IF

            IF cl_null(lc_gzszl007_new) THEN
               LET lc_gzszl007_new = lc_gzszl007_old  
            END IF                  
            UPDATE gzszl_t SET gzszl004 = lc_gzszl004_new,
                               gzszl005 = lc_gzszl005_new,
                               gzszl006 = lc_gzszl006_new,
                               gzszl007 = lc_gzszl007_new
             WHERE gzszl001 = lc_gzszl001 
               AND gzszl002 = lc_gzszl002
               AND gzszl003 = "zh_TW"                    
            
            IF SQLCA.SQLCODE THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)gzszl_t失敗...  gzszl001:",lc_gzszl001,"  gzszl002:",lc_gzszl002,
                                                       "  gzszl003:zh_TW","  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
               CALL g_gen_ch.writeLine(lc_msg)
               RETURN
            END IF

            #紀錄log
            LET lc_msg = "<tr hieght=22><td class=xl24>zh_TW</td>",                #更換語系
                                       "<td class=xl24>gzszl_t</td>",              #更換的多語言table
                                       "<td class=xl24>",g_param.docno,"</td>",    #表單單號    
                                       "<td class=xl24>",g_param.seq,"</td>",      #項次
                                       "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                       "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                       "<td class=xl24>",lc_gzszl004_old,"</td>",  #資料修改前
                                       "<td class=xl24>",lc_gzszl004_new,"</td>",  #資料修改後
                                       "<td class=xl24>",lc_gzszl005_old,"</td>",  #資料修改前
                                       "<td class=xl24>",lc_gzszl005_new,"</td>",  #資料修改後
                                       "<td class=xl24>",lc_gzszl006_old,"</td>",  #資料修改前
                                       "<td class=xl24>",lc_gzszl006_new,"</td>",  #資料修改後
                                       "<td class=xl24>",lc_gzszl007_old,"</td>",  #資料修改前
                                       "<td class=xl24>",lc_gzszl007_new,"</td>",  #資料修改後
                         "</tr>"
            
            CALL g_gen_ch.writeLine(lc_msg)
         END IF 
      END FOREACH
   END IF

   ########開始進行字典檔匯出至多語言檔的動作##########
   LET ls_sql = "SELECT gzszl001,gzszl002,gzszl004,gzszl005,gzszl006,gzszl007 FROM gzszl_t ",
                " WHERE gzszl003 = 'zh_TW' ORDER BY gzszl001,gzszl002"

   #取出語言種類與項目
   LET la_gzzy = azzp110_get_gzzy()

   DECLARE exp_gzszl_cs CURSOR FROM ls_sql
   FOREACH exp_gzszl_cs INTO lc_gzszl001,lc_gzszl002,lc_gzszl004_tw,lc_gzszl005_tw,
                             lc_gzszl006_tw,lc_gzszl007_tw
      DISPLAY "check gzoz_t  lc_gzszl001:",lc_gzszl001
      #跑單身陣列
      FOR li_cnt = 1 TO la_gzzy.getLength()
         LET lc_update = "N"
         
         LET ls_sql_gzoz = "SELECT ",la_gzzy[li_cnt].gzozcol CLIPPED,
                            " FROM gzoz_t WHERE gzoz000 = ? "
         PREPARE s11 FROM ls_sql_gzoz
         
         #以繁體中文為主
         LET lc_gzszl004_new = ""
         IF NOT cl_null(lc_gzszl004_tw) THEN
            EXECUTE s11 USING lc_gzszl004_tw INTO lc_gzszl004_new
            LET li_result = SQLCA.SQLCODE
         END IF

         #以繁體中文為主
         LET lc_gzszl005_new = ""
         IF NOT cl_null(lc_gzszl005_tw) THEN
            EXECUTE s11 USING lc_gzszl005_tw INTO lc_gzszl005_new
            LET li_result2 = SQLCA.SQLCODE 
         END IF

         #以繁體中文為主
         LET lc_gzszl006_new = ""
         IF NOT cl_null(lc_gzszl006_tw) THEN
            EXECUTE s11 USING lc_gzszl006_tw INTO lc_gzszl006_new
            LET li_result3 = SQLCA.SQLCODE
         END IF         

         #以繁體中文為主
         LET lc_gzszl007_new = ""
         IF NOT cl_null(lc_gzszl007_tw) THEN
            EXECUTE s11 USING lc_gzszl007_tw INTO lc_gzszl007_new
            LET li_result4 = SQLCA.SQLCODE
         END IF         

         #如果有資料且該筆資料不是null
         #然後判斷該語言別是否有資料 沒有資料就insert 有資料確認該筆資料是否是null，是就update
         #160303 改為以字典檔為主，若在字典檔有找到且非空白，就一律更新
         IF (NOT li_result AND NOT cl_null(lc_gzszl004_new)) OR (NOT li_result2 AND NOT cl_null(lc_gzszl005_new))
            OR (NOT li_result3 AND NOT cl_null(lc_gzszl006_new)) OR (NOT li_result4 AND NOT cl_null(lc_gzszl007_new)) THEN
            #檢查過單號是否已超過筆數
         #   CALL azzp110_chk_dzld_rows()
         #   IF NOT g_chk_status THEN
         #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
         #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
         #   CALL g_gen_ch.writeLine(lc_msg)
         #      RETURN
         #   END IF
 
            LET lc_gzszl004_old = ""
            LET lc_gzszl005_old = ""
            LET lc_gzszl006_old = ""
            LET lc_gzszl007_old = ""
            LET li_count = 0
            
            SELECT COUNT(*) INTO li_count FROM gzszl_t
             WHERE gzszl001 = lc_gzszl001
               AND gzszl002 = lc_gzszl002
               AND gzszl003 = la_gzzy[li_cnt].gzzy001

            IF li_count = 0 THEN
               #填寫過單資訊，需檢核是否存在主檔中
               #需先判斷此多語言檔案會有幾個過單項(azzi991或azzi993)
               #因為可能多個過單項都有過到這個多語言檔案，
               #鴻傑說，主要是要過多語言檔，所以只要有一筆當代表就可以了，不用每個過單項都過
               
               #azzi991
               #雖然gzszl_t的主表是gzsz_t，所以不管是azzi991或是azzi993都會在gzsz_t有一筆資料，
               #只是在azzi991查詢時，會限制只能查詢出'ooac_t'的資料，
               #假設參數設定項(E-SYS-0701)雖然實際有存在於gzsz_t，但此參數項不屬於單據別設定(即非azzi991可查詢到的資料)
               #所以在填過單資訊的時候，應填azzi993才對
               #因此，在搜尋此筆多語言資料是否存在於主表時，在azzi991項中，也應該加上限制只能取'ooac_t'的資料
               LET lc_count_1 = 0
               LET lc_count_2 = 0
               LET lc_item1 = "NULL"
               LET lc_item2 = "NULL"
               SELECT COUNT(1) INTO lc_count_1 FROM gzsz_t 
                WHERE gzsz001 = 'ooac_t' 
                  AND gzsz001 = lc_gzsz001 AND gzsz002 = lc_gzszl002
               
               IF lc_count_1 > 0 THEN
               #   IF NOT azzp110_insert_dzld('gzszl_t','azzi991',lc_gzszl002,' ') THEN
               #      LET g_chk_status = FALSE
               #      RETURN
               #   END IF
                  LET lc_item1 = "azzi991"
                  LET lc_item2 = lc_gzszl002
               ELSE
                  #azzi993
                  SELECT DISTINCT gzsv001 INTO lc_gzsv001 FROM gzsv_t,gzsz_t
                   WHERE gzsv005 = gzsz001 AND gzsv006 = gzsz002
                     AND gzsz001 = lc_gzsz001 AND gzsz002 = lc_gzszl002
                
                  SELECT COUNT(1) INTO lc_count_2 FROM gzsx_t
                   WHERE gzsx001 = lc_gzsv001
                  
                  IF lc_count_2 > 0 THEN
                  #   IF NOT azzp110_insert_dzld('gzszl_t','azzi993',lc_gzsv001,' ') THEN
                  #      LET g_chk_status = FALSE
                  #      RETURN
                  #   END IF
                     LET lc_item1 = "azzi993"
                     LET lc_item2 = lc_gzsv001
                  END IF
               END IF
            
               INSERT INTO gzszl_t(gzszl001,gzszl002,gzszl003,gzszl004,gzszl005,
                                   gzszl006,gzszl007)
                  VALUES(lc_gzszl001,lc_gzszl002,la_gzzy[li_cnt].gzzy001,lc_gzszl004_new,
                         lc_gzszl005_new,lc_gzszl006_new,lc_gzszl007_new)
              
               IF SQLCA.SQLCODE THEN
                  LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(insert)gzszl_t失敗...  gzszl001:",lc_gzszl001,"  gzszl002:",lc_gzszl002,
                                                          "  gzszl003:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                  CALL g_gen_ch.writeLine(lc_msg)
                  RETURN
               END IF              
               LET lc_update = "Y"
            ELSE 
               SELECT gzszl004,gzszl005,gzszl006,gzszl007
                 INTO lc_gzszl004_old,lc_gzszl005_old,lc_gzszl006_old,lc_gzszl007_old 
                 FROM gzszl_t
                WHERE gzszl001 = lc_gzszl001
                  AND gzszl002 = lc_gzszl002 
                  AND gzszl003 = la_gzzy[li_cnt].gzzy001

               IF NOT SQLCA.SQLCODE THEN
                  #須以字典檔為主，但為避免字典檔的資料是空白的，卻蓋掉原有已存在的資料，所以要先做判斷
                  IF cl_null(lc_gzszl004_new) THEN
                     LET lc_gzszl004_new = lc_gzszl004_old 
                  END IF  

                  IF cl_null(lc_gzszl005_new) THEN
                     LET lc_gzszl005_new = lc_gzszl005_old  
                  END IF

                  IF cl_null(lc_gzszl006_new) THEN
                     LET lc_gzszl006_new = lc_gzszl006_old  
                  END IF

                  IF cl_null(lc_gzszl007_new) THEN
                     LET lc_gzszl007_new = lc_gzszl007_old  
                  END IF
                  
                  #IF la_gzzy[li_cnt].gzzy001 <> "zh_TW" AND (lc_gzszl004_new <> lc_gzszl004_old
                  #     OR lc_gzszl005_new <> lc_gzszl005_old OR lc_gzszl006_new <> lc_gzszl006_old
                  #     OR lc_gzszl007_new <> lc_gzszl007_old) THEN
                  #16/08/15 加入 欄位 null 判斷 否則 舊值是null 的話，比對會是(null)
                  #160818-00012 start
                  IF la_gzzy[li_cnt].gzzy001 <> "zh_TW" AND (lc_gzszl004_new <> lc_gzszl004_old
                       OR lc_gzszl005_new <> lc_gzszl005_old OR lc_gzszl006_new <> lc_gzszl006_old
                       OR lc_gzszl007_new <> lc_gzszl007_old OR lc_gzszl004_old IS NULL OR 
                       lc_gzszl005_old IS NULL OR lc_gzszl006_old IS NULL OR 
                       lc_gzszl007_old IS NULL ) THEN 
                  ##160818-00012 end     
                     #填寫過單資訊，需檢核是否存在主檔中
                     #需先判斷此多語言檔案會有幾個過單項(azzi991或azzi993)
                     #因為可能多個過單項都有過到這個多語言檔案，
                     #鴻傑說，主要是要過多語言檔，所以只要有一筆當代表就可以了，不用每個過單項都過
                     
                     #azzi991
                     #雖然gzszl_t的主表是gzsz_t，所以不管是azzi991或是azzi993都會在gzsz_t有一筆資料，
                     #只是在azzi991查詢時，會限制只能查詢出'ooac_t'的資料，
                     #假設參數設定項(E-SYS-0701)雖然實際有存在於gzsz_t，但此參數項不屬於單據別設定(即非azzi991可查詢到的資料)
                     #所以在填過單資訊的時候，應填azzi993才對
                     #因此，在搜尋此筆多語言資料是否存在於主表時，在azzi991項中，也應該加上限制只能取'ooac_t'的資料
                     LET lc_count_1 = 0
                     LET lc_count_2 = 0
                     LET lc_item1 = "NULL"
                     LET lc_item2 = "NULL"
                     SELECT COUNT(1) INTO lc_count_1 FROM gzsz_t 
                      WHERE gzsz001 = 'ooac_t' 
                        AND gzsz001 = lc_gzsz001 AND gzsz002 = lc_gzszl002
                     
                     IF lc_count_1 > 0 THEN
                     #   IF NOT azzp110_insert_dzld('gzszl_t','azzi991',lc_gzszl002,' ') THEN
                     #      LET g_chk_status = FALSE
                     #      RETURN
                     #   END IF
                        LET lc_item1 = "azzi991"
                        LET lc_item2 = lc_gzszl002
                     ELSE
                        #azzi993
                        SELECT DISTINCT gzsv001 INTO lc_gzsv001 FROM gzsv_t,gzsz_t
                         WHERE gzsv005 = gzsz001 AND gzsv006 = gzsz002
                           AND gzsz001 = lc_gzsz001 AND gzsz002 = lc_gzszl002
                      
                        SELECT COUNT(1) INTO lc_count_2 FROM gzsx_t
                         WHERE gzsx001 = lc_gzsv001
                        
                        IF lc_count_2 > 0 THEN
                        #   IF NOT azzp110_insert_dzld('gzszl_t','azzi993',lc_gzsv001,' ') THEN
                        #      LET g_chk_status = FALSE
                        #      RETURN
                        #   END IF
                           LET lc_item1 = "azzi993"
                           LET lc_item2 = lc_gzsv001
                        END IF
                     END IF
            
                     UPDATE gzszl_t SET gzszl004 = lc_gzszl004_new,
                                        gzszl005 = lc_gzszl005_new,
                                        gzszl006 = lc_gzszl006_new,
                                        gzszl007 = lc_gzszl007_new
                      WHERE gzszl001 = lc_gzszl001 
                        AND gzszl002 = lc_gzszl002
                        AND gzszl003 = la_gzzy[li_cnt].gzzy001
                     
                     IF SQLCA.SQLCODE THEN
                        LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)gzszl_t失敗...  gzszl001:",lc_gzszl001,"  gzszl002:",lc_gzszl002,
                                                                "  gzszl003:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                        CALL g_gen_ch.writeLine(lc_msg)
                        RETURN
                     END IF
                     LET lc_update = "Y"
                  END IF
               END IF 
            END IF
            
            IF lc_update = "Y" THEN
               #紀錄log
               LET lc_msg = "<tr hieght=22><td class=xl24>",la_gzzy[li_cnt].gzzy001,"</td>",   #更換語系
                                          "<td class=xl24>gzszl_t</td>",              #更換的多語言table
                                          "<td class=xl24>",g_param.docno,"</td>",    #表單單號    
                                          "<td class=xl24>",g_param.seq,"</td>",      #項次
                                          "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                          "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                          "<td class=xl24>",lc_gzszl004_old,"</td>",  #資料修改前
                                          "<td class=xl24>",lc_gzszl004_new,"</td>",  #資料修改後
                                          "<td class=xl24>",lc_gzszl005_old,"</td>",  #資料修改前
                                          "<td class=xl24>",lc_gzszl005_new,"</td>",  #資料修改後
                                          "<td class=xl24>",lc_gzszl006_old,"</td>",  #資料修改前
                                          "<td class=xl24>",lc_gzszl006_new,"</td>",  #資料修改後
                                          "<td class=xl24>",lc_gzszl007_old,"</td>",  #資料修改前
                                          "<td class=xl24>",lc_gzszl007_new,"</td>",  #資料修改後
                            "</tr>"
               
               CALL g_gen_ch.writeLine(lc_msg)
            END IF
         END IF 
         FREE s11
      END FOR
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_exp_gzcal()
#                  RETURNING 
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_exp_gzcal()
   DEFINE ls_sql STRING
   DEFINE ls_sql_gzoz STRING
   DEFINE la_gzzy DYNAMIC ARRAY OF RECORD
             gzzy001 LIKE gzzy_t.gzzy001, #語言別
             gzozcol LIKE type_t.chr10    #語言別欄位
                  END RECORD
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE lc_gzcal001     LIKE gzcal_t.gzcal001
   DEFINE lc_gzcal003_tw  LIKE gzcal_t.gzcal003
   DEFINE lc_gzcal003_old LIKE gzcal_t.gzcal003
   DEFINE lc_gzcal003_new LIKE gzcal_t.gzcal003
   DEFINE lc_count        LIKE type_t.num5
   DEFINE lc_msg          STRING
   DEFINE lc_update       LIKE type_t.chr1
   DEFINE lc_item1        STRING
   DEFINE lc_item2        STRING


   #若是多語言暫存檔有資料的話，要先做暫存檔轉換的部分
   #否則後續用已更新後的字典檔再去對應各多語言檔的話，怕會有缺漏
   IF gs_trans_temp = "Y" THEN
      LET ls_sql = "SELECT gzcal001,gzcal003 FROM gzcal_t WHERE gzcal002 = 'zh_TW' ORDER BY gzcal001"

      DECLARE azzp110_trans_temp_to_gzcal_cs CURSOR FROM ls_sql
      FOREACH azzp110_trans_temp_to_gzcal_cs INTO lc_gzcal001,lc_gzcal003_old
         DISPLAY "check gzos_t  lc_gzcal001:",lc_gzcal001
         #檢查過單號是否已超過筆數
      #   CALL azzp110_chk_dzld_rows()
      #   IF NOT g_chk_status THEN
      #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
      #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
      #      CALL g_gen_ch.writeLine(lc_msg)
      #      RETURN
      #   END IF
         
         #從多語言暫存檔找出該語言別資料
         LET lc_gzcal003_new = ""
         EXECUTE azzp110_get_gzos_cs USING lc_gzcal003_old INTO lc_gzcal003_new
         
         IF NOT SQLCA.SQLCODE AND NOT cl_null(lc_gzcal003_new) THEN
            #填寫過單資訊，需檢核是否存在主檔中
            LET lc_count = 0
            LET lc_item1 = "NULL"
            LET lc_item2 = "NULL"
            SELECT COUNT(1) INTO lc_count FROM gzca_t
             WHERE gzca001 = lc_gzcal001
                          
            IF lc_count > 0 THEN
            #   IF NOT azzp110_insert_dzld('gzcal_t','azzi600',lc_gzcal001,' ') THEN
            #      LET g_chk_status = FALSE
            #      RETURN
            #   END IF
               LET lc_item1 = "azzi600"
               LET lc_item2 = lc_gzcal001
            END IF
            
            UPDATE gzcal_t SET gzcal003 = lc_gzcal003_new
             WHERE gzcal001 = lc_gzcal001 
               AND gzcal002 = "zh_TW"
            
            IF SQLCA.SQLCODE THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)gzcal_t失敗...  gzcal001:",lc_gzcal001,"  gzcal002:zh_TW","  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
               CALL g_gen_ch.writeLine(lc_msg)
               RETURN
            END IF

            #紀錄log
            LET lc_msg = "<tr hieght=22><td class=xl24>zh_TW</td>",                #更換語系
                                       "<td class=xl24>gzcal_t</td>",              #更換的多語言table
                                       "<td class=xl24>",g_param.docno,"</td>",    #表單單號    
                                       "<td class=xl24>",g_param.seq,"</td>",      #項次
                                       "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                       "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                       "<td class=xl24>",lc_gzcal003_old,"</td>",  #資料修改前
                                       "<td class=xl24>",lc_gzcal003_new,"</td>",  #資料修改後
                         "</tr>"
            
            CALL g_gen_ch.writeLine(lc_msg)
         END IF
      END FOREACH
   END IF

   ########開始進行字典檔匯出至多語言檔的動作##########
   LET ls_sql = "SELECT gzcal001,gzcal003 FROM gzcal_t WHERE gzcal002 = 'zh_TW' ORDER BY gzcal001"

   #取出語言種類與項目
   LET la_gzzy = azzp110_get_gzzy()  #除了zh_TW 之外

   DECLARE exp_gzcal_cs CURSOR FROM ls_sql
   FOREACH exp_gzcal_cs INTO lc_gzcal001,lc_gzcal003_tw
      DISPLAY "check gzoz_t  lc_gzcal001:",lc_gzcal001
      #跑單身陣列
      FOR li_cnt = 1 TO la_gzzy.getLength()
         LET lc_update = "N"
         
         #以繁體中文為主
         LET lc_gzcal003_new = ""
         LET ls_sql_gzoz = "SELECT ",la_gzzy[li_cnt].gzozcol CLIPPED,
                            " FROM gzoz_t WHERE gzoz000= '",lc_gzcal003_tw CLIPPED,"' "
         PREPARE s14 FROM ls_sql_gzoz
         EXECUTE s14 INTO lc_gzcal003_new
         
         #如果有資料且該筆資料不是null  
         #然後判斷該語言別是否有資料 沒有資料就insert 有資料確認該筆資料是否是null，是就update 
         #160303 改為以字典檔為主，若在字典檔有找到且非空白，就一律更新
         IF NOT SQLCA.SQLCODE AND NOT cl_null(lc_gzcal003_new) THEN
            #檢查過單號是否已超過筆數
         #   CALL azzp110_chk_dzld_rows()
         #   IF NOT g_chk_status THEN
         #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
         #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
         #   CALL g_gen_ch.writeLine(lc_msg)
         #      RETURN
         #   END IF
 
            LET lc_gzcal003_old = ""
            SELECT gzcal003 INTO lc_gzcal003_old FROM gzcal_t
             WHERE gzcal001 = lc_gzcal001
               AND gzcal002 = la_gzzy[li_cnt].gzzy001
               
            IF SQLCA.SQLCODE THEN
               #填寫過單資訊，需檢核是否存在主檔中
               LET lc_count = 0
               LET lc_item1 = "NULL"
               LET lc_item2 = "NULL"
               SELECT COUNT(1) INTO lc_count FROM gzca_t
                WHERE gzca001 = lc_gzcal001
                             
               IF lc_count > 0 THEN
               #   IF NOT azzp110_insert_dzld('gzcal_t','azzi600',lc_gzcal001,' ') THEN
               #      LET g_chk_status = FALSE
               #      RETURN
               #   END IF
                  LET lc_item1 = "azzi600"
                  LET lc_item2 = lc_gzcal001
               END IF
            
               INSERT INTO gzcal_t(gzcal001,gzcal002,gzcal003)
                  VALUES(lc_gzcal001,la_gzzy[li_cnt].gzzy001,lc_gzcal003_new)
               
               IF SQLCA.SQLCODE THEN
                  LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(insert)gzcal_t失敗...  gzcal001:",lc_gzcal001,"  gzcal002:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                  CALL g_gen_ch.writeLine(lc_msg)
                  RETURN
               END IF
               LET lc_update = "Y"
            ELSE
               IF la_gzzy[li_cnt].gzzy001 <> "zh_TW" AND lc_gzcal003_new <> lc_gzcal003_old THEN
                  #填寫過單資訊，需檢核是否存在主檔中
                  LET lc_count = 0
                  LET lc_item1 = "NULL"
                  LET lc_item2 = "NULL"
                  SELECT COUNT(1) INTO lc_count FROM gzca_t
                   WHERE gzca001 = lc_gzcal001
                                
                  IF lc_count > 0 THEN
                  #   IF NOT azzp110_insert_dzld('gzcal_t','azzi600',lc_gzcal001,' ') THEN
                  #      LET g_chk_status = FALSE
                  #      RETURN
                  #   END IF
                     LET lc_item1 = "azzi600"
                     LET lc_item2 = lc_gzcal001
                  END IF
            
                  UPDATE gzcal_t SET gzcal003 = lc_gzcal003_new
                   WHERE gzcal001 = lc_gzcal001 
                     AND gzcal002 = la_gzzy[li_cnt].gzzy001
                  
                  IF SQLCA.SQLCODE THEN
                     LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)gzcal_t失敗...  gzcal001:",lc_gzcal001,"  gzcal002:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                     CALL g_gen_ch.writeLine(lc_msg)
                     RETURN
                  END IF
                  LET lc_update = "Y"
               END IF
            END IF
            
            IF lc_update = "Y" THEN
               #紀錄log
               LET lc_msg = "<tr hieght=22><td class=xl24>",la_gzzy[li_cnt].gzzy001,"</td>",  #更換語系
                                          "<td class=xl24>gzcal_t</td>",              #更換的多語言table
                                          "<td class=xl24>",g_param.docno,"</td>",    #表單單號    
                                          "<td class=xl24>",g_param.seq,"</td>",      #項次
                                          "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                          "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                          "<td class=xl24>",lc_gzcal003_old,"</td>",  #資料修改前
                                          "<td class=xl24>",lc_gzcal003_new,"</td>",  #資料修改後
                            "</tr>"
               
               CALL g_gen_ch.writeLine(lc_msg)
            END IF
         END IF
         FREE s14
      END FOR
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 匯出 gzgdl 所有語言除了zh_TW
# Memo...........:
# Usage..........: CALL azzp110_exp_gzgdl()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_exp_gzgdl()
   DEFINE ls_sql STRING
   DEFINE ls_sql_gzoz STRING
   DEFINE la_gzzy DYNAMIC ARRAY OF RECORD
             gzzy001 LIKE gzzy_t.gzzy001, #語言別
             gzozcol LIKE type_t.chr10    #語言別欄位
                  END RECORD
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE lc_gzgdl000     LIKE gzgdl_t.gzgdl000
   DEFINE lc_gzgdl002_tw  LIKE gzgdl_t.gzgdl002
   DEFINE lc_gzgdl002_old LIKE gzgdl_t.gzgdl002
   DEFINE lc_gzgdl002_new LIKE gzgdl_t.gzgdl002
   DEFINE lc_count_1      LIKE type_t.num5
   DEFINE lc_count_2      LIKE type_t.num5
   DEFINE lc_gzgf001      LIKE gzgf_t.gzgf001
   DEFINE lc_gzgd001      LIKE gzgd_t.gzgd001
   DEFINE lc_msg          STRING
   DEFINE lc_update       LIKE type_t.chr1
   DEFINE lc_item1        STRING
   DEFINE lc_item2        STRING
   
  
   #若是多語言暫存檔有資料的話，要先做暫存檔轉換的部分
   #否則後續用已更新後的字典檔再去對應各多語言檔的話，怕會有缺漏
   IF gs_trans_temp = "Y" THEN
      LET ls_sql = "SELECT gzgdl000,gzcal002 FROM gzgdl_t WHERE gzgdl001 = 'zh_TW' ORDER BY gzgdl001"

      DECLARE azzp110_trans_temp_to_gzgdl_cs CURSOR FROM ls_sql
      FOREACH azzp110_trans_temp_to_gzgdl_cs INTO lc_gzgdl000,lc_gzgdl002_old
         DISPLAY "check gzos_t  lc_gzgdl000:",lc_gzgdl000
         #檢查過單號是否已超過筆數
      #   CALL azzp110_chk_dzld_rows()
      #   IF NOT g_chk_status THEN
      #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
      #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
      #      CALL g_gen_ch.writeLine(lc_msg)
      #      RETURN
      #   END IF
         
         #從多語言暫存檔找出該語言別資料
         LET lc_gzgdl002_new = ""
         EXECUTE azzp110_get_gzos_cs USING lc_gzgdl002_old INTO lc_gzgdl002_new

         IF NOT SQLCA.SQLCODE AND NOT cl_null(lc_gzgdl002_new) THEN
            #填寫過單資訊，需檢核是否存在主檔中
            #需先判斷此多語言檔案會有幾個過單項(azzi300或azzi301)
            #因為可能多個過單項都有過到這個多語言檔案，
            #鴻傑說，主要是要過多語言檔，所以只要有一筆當代表就可以了，不用每個過單項都過
            #azzi300
            LET lc_count_1 = 0
            LET lc_count_2 = 0
            LET lc_item1 = "NULL"
            LET lc_item2 = "NULL"
            SELECT COUNT(1) INTO lc_count_1 FROM gzgf_t 
             WHERE gzgf000 = lc_gzgdl000
            
            IF lc_count_1 > 0 THEN
               SELECT DISTINCT gzgf001 INTO lc_gzgf001 FROM gzgf_t
                WHERE gzgf000 = lc_gzgdl000
            #   IF NOT azzp110_insert_dzld('gzgdl_t','azzi300',lc_gzgf001,' ') THEN
            #      LET g_chk_status = FALSE
            #      RETURN
            #   END IF
               LET lc_item1 = "azzi300"
               LET lc_item2 = lc_gzgf001
            ELSE
               #azzi301
               SELECT COUNT(1) INTO lc_count_2 FROM gzgd_t 
                WHERE gzgd000 = lc_gzgdl000
              
               IF lc_count_2 > 0 THEN
                  SELECT DISTINCT gzgd001 INTO lc_gzgd001 FROM gzgd_t
                   WHERE gzgd000 = lc_gzgdl000
               #   IF NOT azzp110_insert_dzld('gzgdl_t','azzi301',lc_gzgd001,' ') THEN
               #      LET g_chk_status = FALSE
               #      RETURN
               #   END IF
                  LET lc_item1 = "azzi301"
                  LET lc_item2 = lc_gzgd001
               END IF
            END IF
            
            UPDATE gzgdl_t SET gzgdl002 = lc_gzgdl002_new
             WHERE gzgdl000 = lc_gzgdl000 
               AND gzgdl001 = "zh_TW"
            
            IF SQLCA.SQLCODE THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)gzgdl_t失敗...  gzgdl000:",lc_gzgdl000,"  gzgdl001:zh_TW","  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
               CALL g_gen_ch.writeLine(lc_msg)
               RETURN
            END IF

            #紀錄log
            LET lc_msg = "<tr hieght=22><td class=xl24>zh_TW</td>",                #更換語系
                                       "<td class=xl24>gzgdl_t</td>",              #更換的多語言table
                                       "<td class=xl24>",g_param.docno,"</td>",    #表單單號    
                                       "<td class=xl24>",g_param.seq,"</td>",      #項次
                                       "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                       "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                       "<td class=xl24>",lc_gzgdl002_old,"</td>",  #資料修改前
                                       "<td class=xl24>",lc_gzgdl002_new,"</td>",  #資料修改後
                         "</tr>"
            
            CALL g_gen_ch.writeLine(lc_msg)
         END IF
      END FOREACH
   END IF
  
   ########開始進行字典檔匯出至多語言檔的動作##########
   LET ls_sql = "SELECT gzgdl000,gzcal002 FROM gzgdl_t WHERE gzgdl001 = 'zh_TW' ORDER BY gzgdl001"

   #取出語言種類與項目
   LET la_gzzy = azzp110_get_gzzy()  #除了zh_TW 之外

   DECLARE exp_gzgdl_cs CURSOR FROM ls_sql
   FOREACH exp_gzgdl_cs INTO lc_gzgdl000,lc_gzgdl002_tw
      DISPLAY "check gzoz_t  lc_gzgdl000:",lc_gzgdl000
      #跑單身陣列
      FOR li_cnt = 1 TO la_gzzy.getLength()
         LET lc_update = "N"
         
         #以繁體中文為主
         LET lc_gzgdl002_new = ""
         LET ls_sql_gzoz = "SELECT ",la_gzzy[li_cnt].gzozcol CLIPPED,
                            " FROM gzoz_t WHERE gzoz000= '",lc_gzgdl002_tw CLIPPED,"' "
         PREPARE s17 FROM ls_sql_gzoz
         EXECUTE s17 INTO lc_gzgdl002_new

         #如果有資料且該筆資料不是null  
         #然後判斷該語言別是否有資料 沒有資料就insert 有資料確認該筆資料是否是null，是就update 
         #160303 改為以字典檔為主，若在字典檔有找到且非空白，就一律更新
         IF NOT SQLCA.SQLCODE AND NOT cl_null(lc_gzgdl002_new) THEN
            #檢查過單號是否已超過筆數
         #   CALL azzp110_chk_dzld_rows()
         #   IF NOT g_chk_status THEN
         #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
         #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
         #   CALL g_gen_ch.writeLine(lc_msg)
         #      RETURN
         #   END IF

            LET lc_gzgdl002_old = ""
            SELECT gzgdl002 INTO lc_gzgdl002_old FROM gzgdl_t
             WHERE gzgdl000 = lc_gzgdl000
               AND gzgdl001 = la_gzzy[li_cnt].gzzy001
            IF SQLCA.SQLCODE THEN
               #填寫過單資訊，需檢核是否存在主檔中
               #需先判斷此多語言檔案會有幾個過單項(azzi300或azzi301)
               #因為可能多個過單項都有過到這個多語言檔案，
               #鴻傑說，主要是要過多語言檔，所以只要有一筆當代表就可以了，不用每個過單項都過
               #azzi300
               LET lc_count_1 = 0
               LET lc_count_2 = 0
               LET lc_item1 = "NULL"
               LET lc_item2 = "NULL"
               SELECT COUNT(1) INTO lc_count_1 FROM gzgf_t 
                WHERE gzgf000 = lc_gzgdl000
               
               IF lc_count_1 > 0 THEN
                  SELECT DISTINCT gzgf001 INTO lc_gzgf001 FROM gzgf_t
                   WHERE gzgf000 = lc_gzgdl000
               #   IF NOT azzp110_insert_dzld('gzgdl_t','azzi300',lc_gzgf001,' ') THEN
               #      LET g_chk_status = FALSE
               #      RETURN
               #   END IF
                  LET lc_item1 = "azzi300"
                  LET lc_item2 = lc_gzgf001
               ELSE
                  #azzi301
                  SELECT COUNT(1) INTO lc_count_2 FROM gzgd_t 
                   WHERE gzgd000 = lc_gzgdl000
                 
                  IF lc_count_2 > 0 THEN
                     SELECT DISTINCT gzgd001 INTO lc_gzgd001 FROM gzgd_t
                      WHERE gzgd000 = lc_gzgdl000
                  #   IF NOT azzp110_insert_dzld('gzgdl_t','azzi301',lc_gzgd001,' ') THEN
                  #      LET g_chk_status = FALSE
                  #      RETURN
                  #   END IF
                     LET lc_item1 = "azzi301"
                     LET lc_item2 = lc_gzgd001
                  END IF
               END IF
            
               INSERT INTO gzgdl_t(gzgdl000,gzgdl001,gzgdl002)
                  VALUES(lc_gzgdl000,la_gzzy[li_cnt].gzzy001,lc_gzgdl002_new)
               DISPLAY "INSERT sqlca.sqlcode ",sqlca.sqlcode , " lc_gzgdl000:",lc_gzgdl000
               
               IF SQLCA.SQLCODE THEN
                  LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(insert)gzgdl_t失敗...  gzgdl000:",lc_gzgdl000,"  gzgdl001:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                  CALL g_gen_ch.writeLine(lc_msg)
                  RETURN
               END IF
               LET lc_update = "Y"
            ELSE
               IF la_gzzy[li_cnt].gzzy001 <> "zh_TW" AND lc_gzgdl002_new <> lc_gzgdl002_old THEN
                  #填寫過單資訊，需檢核是否存在主檔中
                  #需先判斷此多語言檔案會有幾個過單項(azzi300或azzi301)
                  #因為可能多個過單項都有過到這個多語言檔案，
                  #鴻傑說，主要是要過多語言檔，所以只要有一筆當代表就可以了，不用每個過單項都過
                  #azzi300
                  LET lc_count_1 = 0
                  LET lc_count_2 = 0
                  LET lc_item1 = "NULL"
                  LET lc_item2 = "NULL"
                  SELECT COUNT(1) INTO lc_count_1 FROM gzgf_t 
                   WHERE gzgf000 = lc_gzgdl000
                  
                  IF lc_count_1 > 0 THEN
                     SELECT DISTINCT gzgf001 INTO lc_gzgf001 FROM gzgf_t
                      WHERE gzgf000 = lc_gzgdl000
                  #   IF NOT azzp110_insert_dzld('gzgdl_t','azzi300',lc_gzgf001,' ') THEN
                  #      LET g_chk_status = FALSE
                  #      RETURN
                  #   END IF
                     LET lc_item1 = "azzi300"
                     LET lc_item2 = lc_gzgf001
                  ELSE
                     #azzi301
                     SELECT COUNT(1) INTO lc_count_2 FROM gzgd_t 
                      WHERE gzgd000 = lc_gzgdl000
                    
                     IF lc_count_2 > 0 THEN
                        SELECT DISTINCT gzgd001 INTO lc_gzgd001 FROM gzgd_t
                         WHERE gzgd000 = lc_gzgdl000
                     #   IF NOT azzp110_insert_dzld('gzgdl_t','azzi301',lc_gzgd001,' ') THEN
                     #      LET g_chk_status = FALSE
                     #      RETURN
                     #   END IF
                        LET lc_item1 = "azzi301"
                        LET lc_item2 = lc_gzgd001
                     END IF
                  END IF
            
                  UPDATE gzgdl_t SET gzgdl002 = lc_gzgdl002_new
                   WHERE gzgdl000 = lc_gzgdl000 
                     AND gzgdl001 = la_gzzy[li_cnt].gzzy001
                  DISPLAY "UPDATE sqlca.sqlcode ",sqlca.sqlcode ," lc_gzgdl000:",lc_gzgdl000
                  
                  IF SQLCA.SQLCODE THEN
                     LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)gzgdl_t失敗...  gzgdl000:",lc_gzgdl000,"  gzgdl001:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                     CALL g_gen_ch.writeLine(lc_msg)
                     RETURN
                  END IF
                  LET lc_update = "Y"
               END IF
            END IF
            
            IF lc_update = "Y" THEN
               #紀錄log
               LET lc_msg = "<tr hieght=22><td class=xl24>",la_gzzy[li_cnt].gzzy001,"</td>",   #更換語系
                                          "<td class=xl24>gzgdl_t</td>",              #更換的多語言table
                                          "<td class=xl24>",g_param.docno,"</td>",    #表單單號    
                                          "<td class=xl24>",g_param.seq,"</td>",      #項次
                                          "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                          "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                          "<td class=xl24>",lc_gzgdl002_old,"</td>",  #資料修改前
                                          "<td class=xl24>",lc_gzgdl002_new,"</td>",  #資料修改後
                            "</tr>"
               
               CALL g_gen_ch.writeLine(lc_msg)
            END IF
         END IF
         FREE s17

      END FOR
   END FOREACH  
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_exp_gzcbl()
#                  RETURNING 
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_exp_gzcbl()
  DEFINE ls_sql STRING
   DEFINE ls_sql_gzoz STRING
   DEFINE la_gzzy DYNAMIC ARRAY OF RECORD
             gzzy001 LIKE gzzy_t.gzzy001, #語言別
             gzozcol LIKE type_t.chr10    #語言別欄位
                  END RECORD
   DEFINE li_cnt             LIKE type_t.num5
   DEFINE lc_gzcbl001        LIKE gzcbl_t.gzcbl001
   DEFINE lc_gzcbl002        LIKE gzcbl_t.gzcbl002
   DEFINE lc_gzcbl004_tw     LIKE gzcbl_t.gzcbl004
   DEFINE lc_gzcbl004_old    LIKE gzcbl_t.gzcbl004
   DEFINE lc_gzcbl004_new    LIKE gzcbl_t.gzcbl004
   DEFINE lc_gzcbl006_tw     LIKE gzcbl_t.gzcbl006 #應用說明
   DEFINE lc_gzcbl006_old    LIKE gzcbl_t.gzcbl006 #應用說明
   DEFINE lc_gzcbl006_new    LIKE gzcbl_t.gzcbl006 #應用說明
   DEFINE li_result          LIKE type_t.num5
   DEFINE li_result2         LIKE type_t.num5
   DEFINE li_count           LIKE type_t.num5
   DEFINE lc_count           LIKE type_t.num5
   DEFINE lc_msg             STRING
   DEFINE lc_update          LIKE type_t.chr1
   DEFINE lc_item1           STRING
   DEFINE lc_item2           STRING
   

   #若是多語言暫存檔有資料的話，要先做暫存檔轉換的部分
   #否則後續用已更新後的字典檔再去對應各多語言檔的話，怕會有缺漏
   IF gs_trans_temp = "Y" THEN
      LET ls_sql = "SELECT gzcbl001,gzcbl002,gzcbl004,gzcbl006 FROM gzcbl_t WHERE gzcbl003 = 'zh_TW' ORDER BY gzcbl001"

      DECLARE azzp110_trans_temp_to_gzcbl_cs CURSOR FROM ls_sql
      FOREACH azzp110_trans_temp_to_gzcbl_cs INTO lc_gzcbl001,lc_gzcbl002,lc_gzcbl004_old,lc_gzcbl006_old
         DISPLAY "check gzos_t  lc_gzcbl001:",lc_gzcbl001
         #檢查過單號是否已超過筆數
      #   CALL azzp110_chk_dzld_rows()
      #   IF NOT g_chk_status THEN
      #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
      #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
      #      CALL g_gen_ch.writeLine(lc_msg)
      #      RETURN
      #   END IF
         
         #從多語言暫存檔找出該語言別資料
         LET lc_gzcbl004_new = ""
         EXECUTE azzp110_get_gzos_cs USING lc_gzcbl004_old INTO lc_gzcbl004_new
         LET li_result = SQLCA.SQLCODE

         #從多語言暫存檔找出該語言別資料
         LET lc_gzcbl006_new = ""
         EXECUTE azzp110_get_gzos_cs USING lc_gzcbl006_old INTO lc_gzcbl006_new
         LET li_result2 = SQLCA.SQLCODE

         #如果有資料且該筆資料不是null  
         #然後判斷該語言別是否有資料 沒有資料就insert 有資料確認該筆資料是否是null，是就update 
         #160303 改為以字典檔為主，若在字典檔有找到且非空白，就一律更新
         IF (NOT li_result AND NOT cl_null(lc_gzcbl004_new) ) OR (NOT li_result2 AND NOT cl_null(lc_gzcbl006_new) ) THEN
            #填寫過單資訊，需檢核是否存在主檔中
            LET lc_count = 0
            LET lc_item1 = "NULL"
            LET lc_item2 = "NULL"
            SELECT COUNT(1) INTO lc_count FROM gzca_t
             WHERE gzca001 = lc_gzcb001
                          
            IF lc_count > 0 THEN
            #   IF NOT azzp110_insert_dzld('gzcbl_t','azzi600',lc_gzcbl001,' ') THEN
            #      LET g_chk_status = FALSE
            #      RETURN
            #   END IF
               LET lc_item1 = "azzi600"
               LET lc_item2 = lc_gzcbl001
            END IF
         
            IF cl_null(lc_gzcbl004_new) THEN
               LET lc_gzcbl004_new = lc_gzcbl004_old
            END IF 
            IF cl_null(lc_gzcbl006_new) THEN
               LET lc_gzcbl006_new = lc_gzcbl006_old   
            END IF  
            UPDATE gzcbl_t SET gzcbl004 = lc_gzcbl004_new ,gzcbl006 = lc_gzcbl006_new 
                WHERE gzcbl001 = lc_gzcbl001 
                  AND gzcbl002 = lc_gzcbl002
                  AND gzcbl003 = "zh_TW"                    
            
            IF SQLCA.SQLCODE THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)gzcbl_t失敗...  gzcbl001:",lc_gzcbl001,"  gzcbl002:",lc_gzcbl002,
                                                       "  gzcbl003:zh_TW","  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
               CALL g_gen_ch.writeLine(lc_msg)
               RETURN
            END IF

            #紀錄log
            LET lc_msg = "<tr hieght=22><td class=xl24>zh_TW</td>",                #更換語系
                                       "<td class=xl24>gzcbl_t</td>",              #更換的多語言table
                                       "<td class=xl24>",g_param.docno,"</td>",    #表單單號    
                                       "<td class=xl24>",g_param.seq,"</td>",      #項次
                                       "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                       "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                       "<td class=xl24>",lc_gzcbl004_old,"</td>",  #資料修改前
                                       "<td class=xl24>",lc_gzcbl004_new,"</td>",  #資料修改後
                                       "<td class=xl24>",lc_gzcbl006_old,"</td>",  #資料修改前
                                       "<td class=xl24>",lc_gzcbl006_new,"</td>",  #資料修改後
                         "</tr>"
            
            CALL g_gen_ch.writeLine(lc_msg)
         END IF
      END FOREACH
   END IF

   ########開始進行字典檔匯出至多語言檔的動作##########  
   LET ls_sql = "SELECT gzcbl001,gzcbl002,gzcbl004,gzcbl006 FROM gzcbl_t WHERE gzcbl003 = 'zh_TW' ORDER BY gzcbl001"

   #取出語言種類與項目
   LET la_gzzy = azzp110_get_gzzy()

   DECLARE exp_gzcbl_cs CURSOR FROM ls_sql
   FOREACH exp_gzcbl_cs INTO lc_gzcbl001,lc_gzcbl002,lc_gzcbl004_tw,lc_gzcbl006_tw
      DISPLAY "check gzoz_t  lc_gzcbl001:",lc_gzcbl001
      #跑單身陣列
      FOR li_cnt = 1 TO la_gzzy.getLength()
         LET lc_update = "N"
         
         #以繁體中文為主
         LET lc_gzcbl004_new = ""
         LET ls_sql_gzoz = "SELECT ",la_gzzy[li_cnt].gzozcol CLIPPED,
                            " FROM gzoz_t WHERE gzoz000= '",lc_gzcbl004_tw CLIPPED,"' "
         PREPARE s15 FROM ls_sql_gzoz
         EXECUTE s15 INTO lc_gzcbl004_new
         LET li_result = SQLCA.SQLCODE

         #以繁體中文為主
         LET lc_gzcbl006_new = ""
         LET ls_sql_gzoz = "SELECT ",la_gzzy[li_cnt].gzozcol CLIPPED,
                            " FROM gzoz_t WHERE gzoz000= '",lc_gzcbl006_tw CLIPPED,"' "
         PREPARE s16 FROM ls_sql_gzoz
         EXECUTE s16 INTO lc_gzcbl006_new
         LET li_result2 = SQLCA.SQLCODE

         #如果有資料且該筆資料不是null  
         #然後判斷該語言別是否有資料 沒有資料就insert 有資料確認該筆資料是否是null，是就update 
         #160303 改為以字典檔為主，若在字典檔有找到且非空白，就一律更新
         IF (NOT li_result AND NOT cl_null(lc_gzcbl004_new) ) OR (NOT li_result2 AND NOT cl_null(lc_gzcbl006_new) ) THEN
            #檢查過單號是否已超過筆數
         #   CALL azzp110_chk_dzld_rows()
         #   IF NOT g_chk_status THEN
         #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
         #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
         #   CALL g_gen_ch.writeLine(lc_msg)
         #      RETURN
         #   END IF
 
            LET lc_gzcbl004_old = ""
            LET lc_gzcbl006_old = ""
            LET li_count = 0
            
            SELECT COUNT(*) INTO li_count FROM gzcbl_t
             WHERE gzcbl001 = lc_gzcbl001
               AND gzcbl002 = lc_gzcbl002
               AND gzcbl003 = la_gzzy[li_cnt].gzzy001

            IF li_count = 0 THEN
               #填寫過單資訊，需檢核是否存在主檔中
               LET lc_count = 0
               LET lc_item1 = "NULL"
               LET lc_item2 = "NULL"
               SELECT COUNT(1) INTO lc_count FROM gzca_t
                WHERE gzca001 = lc_gzcb001
                             
               IF lc_count > 0 THEN
               #   IF NOT azzp110_insert_dzld('gzcbl_t','azzi600',lc_gzcbl001,' ') THEN
               #      LET g_chk_status = FALSE
               #      RETURN
               #   END IF
                  LET lc_item1 = "azzi600"
                  LET lc_item2 = lc_gzcbl001
               END IF
            
               INSERT INTO gzcbl_t(gzcbl001,gzcbl002,gzcbl003,gzcbl004,gzcbl006)
                  VALUES(lc_gzcbl001,lc_gzcbl002,la_gzzy[li_cnt].gzzy001,lc_gzcbl004_new,lc_gzcbl006_new)
               
               IF SQLCA.SQLCODE THEN
                  LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(insert)gzcbl_t失敗...  gzcbl001:",lc_gzcbl001,"  gzcbl002:",lc_gzcbl002,
                                                          "  gzcbl003:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                  CALL g_gen_ch.writeLine(lc_msg)
                  RETURN
               END IF
               LET lc_update = "Y"
            ELSE
               SELECT gzcbl004,gzcbl006 INTO lc_gzcbl004_old,lc_gzcbl006_old FROM gzcbl_t
                WHERE gzcbl001 = lc_gzcbl001
                  AND gzcbl002 = lc_gzcbl002 
                  AND gzcbl003 = la_gzzy[li_cnt].gzzy001

               IF NOT SQLCA.SQLCODE THEN
                  #須以字典檔為主，但為避免字典檔的資料是空白的，卻蓋掉原有已存在的資料，所以要先做判斷

                  IF cl_null(lc_gzcbl004_new) THEN
                     LET lc_gzcbl004_new = lc_gzcbl004_old
                  END IF 

                  IF cl_null(lc_gzcbl006_new) THEN
                     LET lc_gzcbl006_new = lc_gzcbl006_old   
                  END IF
                  
                  #IF la_gzzy[li_cnt].gzzy001 <> "zh_TW" AND (lc_gzcbl004_new <> lc_gzcbl004_old
                  #       OR lc_gzcbl006_new <> lc_gzcbl006_old) THEN
                  #16/08/15 加入 欄位 null 判斷 否則 舊值是null 的話，比對會是(null)
                  #160818-00012 start
                  IF la_gzzy[li_cnt].gzzy001 <> "zh_TW" AND (lc_gzcbl004_new <> lc_gzcbl004_old
                         OR lc_gzcbl006_new <> lc_gzcbl006_old OR lc_gzcbl004_old IS NULL OR 
                         lc_gzcbl006_old IS NULL ) THEN                         
                  #160818-00012 end 
                  
                     #填寫過單資訊，需檢核是否存在主檔中
                     LET lc_count = 0
                     LET lc_item1 = "NULL"
                     LET lc_item2 = "NULL"
                     SELECT COUNT(1) INTO lc_count FROM gzca_t
                      WHERE gzca001 = lc_gzcb001
                                   
                     IF lc_count > 0 THEN
                     #   IF NOT azzp110_insert_dzld('gzcbl_t','azzi600',lc_gzcbl001,' ') THEN
                     #      LET g_chk_status = FALSE
                     #      RETURN
                     #   END IF
                        LET lc_item1 = "azzi600"
                        LET lc_item2 = lc_gzcbl001
                     END IF
            
                     UPDATE gzcbl_t SET gzcbl004 = lc_gzcbl004_new ,gzcbl006 = lc_gzcbl006_new 
                         WHERE gzcbl001 = lc_gzcbl001 
                           AND gzcbl002 = lc_gzcbl002
                           AND gzcbl003 = la_gzzy[li_cnt].gzzy001
                     
                     IF SQLCA.SQLCODE THEN
                        LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)gzcbl_t失敗...  gzcbl001:",lc_gzcbl001,"  gzcbl002:",lc_gzcbl002,
                                                                "  gzcbl003:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                        CALL g_gen_ch.writeLine(lc_msg)
                        RETURN
                     END IF
                     LET lc_update = "Y"
                  END IF
               END IF 
            END IF
            
            IF lc_update = "Y" THEN
               #紀錄log
               LET lc_msg = "<tr hieght=22><td class=xl24>",la_gzzy[li_cnt].gzzy001,"</td>",   #更換語系
                                          "<td class=xl24>gzcbl_t</td>",              #更換的多語言table
                                          "<td class=xl24>",g_param.docno,"</td>",    #表單單號    
                                          "<td class=xl24>",g_param.seq,"</td>",      #項次
                                          "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                          "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                          "<td class=xl24>",lc_gzcbl004_old,"</td>",  #資料修改前
                                          "<td class=xl24>",lc_gzcbl004_new,"</td>",  #資料修改後
                                          "<td class=xl24>",lc_gzcbl006_old,"</td>",  #資料修改前
                                          "<td class=xl24>",lc_gzcbl006_new,"</td>",  #資料修改後
                            "</tr>"
               
               CALL g_gen_ch.writeLine(lc_msg)
            END IF
         END IF 
         FREE s15
         FREE s16
      END FOR
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 匯出 gzge 所有語言除了zh_TW 
# Memo...........:
# Usage..........: CALL azzp110_exp_gzge()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_exp_gzge()
    DEFINE ls_sql STRING
   DEFINE ls_sql_gzoz STRING
   DEFINE la_gzzy DYNAMIC ARRAY OF RECORD
             gzzy001 LIKE gzzy_t.gzzy001, #語言別
             gzozcol LIKE type_t.chr10    #語言別欄位
                  END RECORD
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE lc_gzge000     LIKE gzge_t.gzge000
   DEFINE lc_gzge001     LIKE gzge_t.gzge001
   DEFINE lc_gzge003_tw  LIKE gzge_t.gzge003
   DEFINE lc_gzge003_old LIKE gzge_t.gzge003
   DEFINE lc_gzge003_new LIKE gzge_t.gzge003
   DEFINE lc_gzgecrtid   LIKE gzge_t.gzgecrtid
   DEFINE lc_gzgecrtdp   LIKE gzge_t.gzgecrtdp
   DEFINE lc_gzgecrtdt   DATETIME YEAR TO SECOND
   DEFINE lc_gzgemodid   LIKE gzge_t.gzgemodid
   DEFINE lc_gzgemoddt   DATETIME YEAR TO SECOND
   DEFINE lc_gzgeownid   LIKE gzge_t.gzgeownid
   DEFINE lc_gzgeowndp   LIKE gzge_t.gzgeowndp
   DEFINE lc_count_1     LIKE type_t.num5
   DEFINE lc_count_2     LIKE type_t.num5
   DEFINE lc_gzgf001     LIKE gzgf_t.gzgf001
   DEFINE lc_gzgd001     LIKE gzgd_t.gzgd001
   DEFINE lc_msg         STRING
   DEFINE lc_update      LIKE type_t.chr1
   DEFINE lc_item1       STRING
   DEFINE lc_item2       STRING
   

   LET lc_gzgeownid = g_user
   LET lc_gzgeowndp = g_dept
   LET lc_gzgecrtid = g_user
   LET lc_gzgecrtdp = g_dept
   LET lc_gzgecrtdt = cl_get_current()
   LET lc_gzgemodid = g_user
   LET lc_gzgemoddt = cl_get_current()


   #若是多語言暫存檔有資料的話，要先做暫存檔轉換的部分
   #否則後續用已更新後的字典檔再去對應各多語言檔的話，怕會有缺漏
   IF gs_trans_temp = "Y" THEN
      LET ls_sql = "SELECT gzge000,gzge001,gzge003 FROM gzge_t WHERE gzge002 = 'zh_TW' ORDER BY gzge000,gzge001"

      DECLARE azzp110_trans_temp_to_gzge_cs CURSOR FROM ls_sql
      FOREACH azzp110_trans_temp_to_gzge_cs INTO lc_gzge000,lc_gzge001,lc_gzge003_old
         DISPLAY "check gzos_t  lc_gzge001:",lc_gzge001
         #檢查過單號是否已超過筆數
      #   CALL azzp110_chk_dzld_rows()
      #   IF NOT g_chk_status THEN
      #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
      #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
      #      CALL g_gen_ch.writeLine(lc_msg)
      #      RETURN
      #   END IF
         
         #從多語言暫存檔找出該語言別資料
         LET lc_gzge003_new = ""
         EXECUTE azzp110_get_gzos_cs USING lc_gzge003_old INTO lc_gzge003_new
         
         IF NOT SQLCA.SQLCODE AND NOT cl_null(lc_gzge003_new) THEN
            #填寫過單資訊，需檢核是否存在主檔中
            #需先判斷此多語言檔案會有幾個過單項(azzi300或azzi301)
            #因為可能多個過單項都有過到這個多語言檔案，
            #鴻傑說，主要是要過多語言檔，所以只要有一筆當代表就可以了，不用每個過單項都過
            #azzi300
            LET lc_count_1 = 0
            LET lc_count_2 = 0
            LET lc_item1 = "NULL"
            LET lc_item2 = "NULL"
            SELECT COUNT(1) INTO lc_count_1 FROM gzgf_t
             WHERE gzgf000 = lc_gzge000
                          
            IF lc_count_1 > 0 THEN
               SELECT DISTINCT gzgf001 INTO lc_gzgf001 FROM gzgf_t
                WHERE gzgf000 = lc_gzge000
               IF NOT azzp110_insert_dzld('gzge_t','azzi300',lc_gzgf001,' ') THEN
                  LET g_chk_status = FALSE
                  RETURN
               END IF
               LET lc_item1 = "azzi300"
               LET lc_item2 = lc_gzgf001
            ELSE
               #azzi301
               SELECT COUNT(1) INTO lc_count_2 FROM gzgd_t
                WHERE gzgd000 = lc_gzge000
               
               IF lc_count_2 > 0 THEN
                  SELECT DISTINCT gzgd001 INTO lc_gzgd001 FROM gzgd_t
                   WHERE gzgd000 = lc_gzge000
               #   IF azzp110_insert_dzld('gzge_t','azzi301',lc_gzgd001,' ') THEN
               #      LET g_chk_status = FALSE
               #      RETURN
               #   END IF
                  LET lc_item1 = "azzi301"
                  LET lc_item2 = lc_gzgd001
               END IF
            END IF
         
            UPDATE gzge_t SET gzge003 = lc_gzge003_new,gzgemodid = lc_gzgemodid,gzgemoddt = lc_gzgemoddt
             WHERE gzge000 = lc_gzge000
               AND gzge001 = lc_gzge001
               AND gzge002 = "zh_TW"
            
            IF SQLCA.SQLCODE THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)gzge_t失敗...  gzge000:",lc_gzge000,"  gzge001:",lc_gzge001,
                                                       "  gzge002:zh_TW","  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
               CALL g_gen_ch.writeLine(lc_msg)
               RETURN
            END IF

            #紀錄log
            LET lc_msg = "<tr hieght=22><td class=xl24>zh_TW</td>",                #更換語系
                                       "<td class=xl24>gzge_t</td>",               #更換的多語言table
                                       "<td class=xl24>",g_param.docno,"</td>",    #表單單號    
                                       "<td class=xl24>",g_param.seq,"</td>",      #項次
                                       "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                       "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                       "<td class=xl24>",lc_gzge003_old,"</td>",   #資料修改前
                                       "<td class=xl24>",lc_gzge003_new,"</td>",   #資料修改後
                         "</tr>"
            
            CALL g_gen_ch.writeLine(lc_msg)
         END IF
      END FOREACH
   END IF

   ########開始進行字典檔匯出至多語言檔的動作##########
   LET ls_sql = "SELECT gzge000,gzge001,gzge003 FROM gzge_t WHERE gzge002 = 'zh_TW' ORDER BY gzge000,gzge001"

   #取出語言種類與項目
   LET la_gzzy = azzp110_get_gzzy()  #除了zh_TW 之外

   DECLARE exp_gzge_cs CURSOR FROM ls_sql
   FOREACH exp_gzge_cs INTO lc_gzge000,lc_gzge001,lc_gzge003_tw
      DISPLAY "check gzoz_t  lc_gzge001:",lc_gzge001
      #跑單身陣列
      FOR li_cnt = 1 TO la_gzzy.getLength()
         LET lc_update = "N"
         
         #以繁體中文為主
         LET lc_gzge003_new = ""
         LET ls_sql_gzoz = "SELECT ",la_gzzy[li_cnt].gzozcol CLIPPED,
                            " FROM gzoz_t WHERE gzoz000= '",lc_gzge003_tw CLIPPED,"' "
         PREPARE s18 FROM ls_sql_gzoz
         EXECUTE s18 INTO lc_gzge003_new
         
         #如果有資料且該筆資料不是null  
         #然後判斷該語言別是否有資料 沒有資料就insert 有資料確認該筆資料是否是null，是就update 
         #160303 改為以字典檔為主，若在字典檔有找到且非空白，就一律更新
         IF NOT SQLCA.SQLCODE AND NOT cl_null(lc_gzge003_new) THEN
            #檢查過單號是否已超過筆數
         #   CALL azzp110_chk_dzld_rows()
         #   IF NOT g_chk_status THEN
         #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
         #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
         #   CALL g_gen_ch.writeLine(lc_msg)
         #      RETURN
         #   END IF
 
            LET lc_gzge003_old = ""
            SELECT gzge003 INTO lc_gzge003_old FROM gzge_t
             WHERE gzge000 = lc_gzge000
               AND gzge001 = lc_gzge001
               AND gzge002 = la_gzzy[li_cnt].gzzy001               
            IF SQLCA.SQLCODE THEN
               #填寫過單資訊，需檢核是否存在主檔中
               #需先判斷此多語言檔案會有幾個過單項(azzi300或azzi301)
               #因為可能多個過單項都有過到這個多語言檔案，
               #鴻傑說，主要是要過多語言檔，所以只要有一筆當代表就可以了，不用每個過單項都過
               #azzi300
               LET lc_count_1 = 0
               LET lc_count_2 = 0
               LET lc_item1 = "NULL"
               LET lc_item2 = "NULL"
               SELECT COUNT(1) INTO lc_count_1 FROM gzgf_t
                WHERE gzgf000 = lc_gzge000
                             
               IF lc_count_1 > 0 THEN
                  SELECT DISTINCT gzgf001 INTO lc_gzgf001 FROM gzgf_t
                   WHERE gzgf000 = lc_gzge000
               #   IF NOT azzp110_insert_dzld('gzge_t','azzi300',lc_gzgf001,' ') THEN
               #      LET g_chk_status = FALSE
               #      RETURN
               #   END IF
                  LET lc_item1 = "azzi300"
                  LET lc_item2 = lc_gzgf001
               ELSE
                  #azzi301
                  SELECT COUNT(1) INTO lc_count_2 FROM gzgd_t
                   WHERE gzgd000 = lc_gzge000
                  
                  IF lc_count_2 > 0 THEN
                     SELECT DISTINCT gzgd001 INTO lc_gzgd001 FROM gzgd_t
                      WHERE gzgd000 = lc_gzge000
                  #   IF NOT azzp110_insert_dzld('gzge_t','azzi301',lc_gzgd001,' ') THEN
                  #      LET g_chk_status = FALSE
                  #      RETURN
                  #   END IF
                     LET lc_item1 = "azzi301"
                     LET lc_item2 = lc_gzgd001
                  END IF
               END IF
            
               INSERT INTO gzge_t(gzgestus,gzge000,gzge001,gzge002,gzge003,
                                  gzgecrtid,gzgecrtdp,gzgecrtdt,gzgeownid,gzgeowndp)
                  VALUES('Y',lc_gzge000,lc_gzge001,la_gzzy[li_cnt].gzzy001,lc_gzge003_new,
                         lc_gzgecrtid,lc_gzgecrtdp,lc_gzgecrtdt,lc_gzgeownid,lc_gzgeowndp)
               
               IF SQLCA.SQLCODE THEN
                  LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(insert)gzge_t失敗...  gzge000:",lc_gzge000,"  gzge001:",lc_gzge001,
                                                          "  gzge002:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                  CALL g_gen_ch.writeLine(lc_msg)
                  RETURN
               END IF
               LET lc_update = "Y"
            ELSE
               IF la_gzzy[li_cnt].gzzy001 <> "zh_TW" AND lc_gzge003_new <> lc_gzge003_old THEN
                  #填寫過單資訊，需檢核是否存在主檔中
                  #需先判斷此多語言檔案會有幾個過單項(azzi300或azzi301)
                  #因為可能多個過單項都有過到這個多語言檔案，
                  #鴻傑說，主要是要過多語言檔，所以只要有一筆當代表就可以了，不用每個過單項都過
                  #azzi300
                  LET lc_count_1 = 0
                  LET lc_count_2 = 0
                  LET lc_item1 = "NULL"
                  LET lc_item2 = "NULL"
                  SELECT COUNT(1) INTO lc_count_1 FROM gzgf_t
                   WHERE gzgf000 = lc_gzge000
                                
                  IF lc_count_1 > 0 THEN
                     SELECT DISTINCT gzgf001 INTO lc_gzgf001 FROM gzgf_t
                      WHERE gzgf000 = lc_gzge000
                  #   IF NOT azzp110_insert_dzld('gzge_t','azzi300',lc_gzgf001,' ') THEN
                  #      LET g_chk_status = FALSE
                  #      RETURN
                  #   END IF
                     LET lc_item1 = "azzi300"
                     LET lc_item2 = lc_gzgf001
                  ELSE
                     #azzi301
                     SELECT COUNT(1) INTO lc_count_2 FROM gzgd_t
                      WHERE gzgd000 = lc_gzge000
                     
                     IF lc_count_2 > 0 THEN
                        SELECT DISTINCT gzgd001 INTO lc_gzgd001 FROM gzgd_t
                         WHERE gzgd000 = lc_gzge000
                     #   IF NOT azzp110_insert_dzld('gzge_t','azzi301',lc_gzgd001,' ') THEN
                     #      LET g_chk_status = FALSE
                     #      RETURN
                     #   END IF
                        LET lc_item1 = "azzi301"
                        LET lc_item2 = lc_gzgd001
                     END IF
                  END IF
            
                  UPDATE gzge_t SET gzge003 = lc_gzge003_new,gzgemodid = lc_gzgemodid,gzgemoddt = lc_gzgemoddt
                   WHERE gzge000 = lc_gzge000
                     AND gzge001 = lc_gzge001
                     AND gzge002 = la_gzzy[li_cnt].gzzy001
                  
                  IF SQLCA.SQLCODE THEN
                     LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)gzge_t失敗...  gzge000:",lc_gzge000,"  gzge001:",lc_gzge001,
                                                             "  gzge002:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                     CALL g_gen_ch.writeLine(lc_msg)
                     RETURN
                  END IF
                  LET lc_update = "Y"
               END IF
            END IF
            
            IF lc_update = "Y" THEN
               #紀錄log
               LET lc_msg = "<tr hieght=22><td class=xl24>",la_gzzy[li_cnt].gzzy001,"</td>",  #更換語系
                                          "<td class=xl24>gzge_t</td>",               #更換的多語言table
                                          "<td class=xl24>",g_param.docno,"</td>",    #表單單號    
                                          "<td class=xl24>",g_param.seq,"</td>",      #項次
                                          "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                          "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                          "<td class=xl24>",lc_gzge003_old,"</td>",   #資料修改前
                                          "<td class=xl24>",lc_gzge003_new,"</td>",   #資料修改後
                            "</tr>"
               
               CALL g_gen_ch.writeLine(lc_msg)
            END IF
         END IF
         FREE s18
      END FOR
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_exp_dzcdl()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_exp_dzcdl()
   DEFINE ls_sql STRING
   DEFINE ls_sql_gzoz STRING
   DEFINE la_gzzy DYNAMIC ARRAY OF RECORD
             gzzy001 LIKE gzzy_t.gzzy001, #語言別
             gzozcol LIKE type_t.chr10    #語言別欄位
                  END RECORD
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE lc_dzcdl001      LIKE dzcdl_t.dzcdl001
   DEFINE lc_dzcdl003_tw   LIKE dzcdl_t.dzcdl003
   DEFINE lc_dzcdl003_old  LIKE dzcdl_t.dzcdl003
   DEFINE lc_dzcdl003_new  LIKE dzcdl_t.dzcdl003
   DEFINE lc_count         LIKE type_t.num5
   DEFINE lc_msg           STRING
   DEFINE lc_update        LIKE type_t.chr1
   DEFINE lc_item1         STRING
   DEFINE lc_item2         STRING
   

   #若是多語言暫存檔有資料的話，要先做暫存檔轉換的部分
   #否則後續用已更新後的字典檔再去對應各多語言檔的話，怕會有缺漏
   IF gs_trans_temp = "Y" THEN
      LET ls_sql = "SELECT dzcdl001,dzcdl003 FROM dzcdl_t WHERE dzcdl002 = 'zh_TW' ORDER BY dzcdl001"

      DECLARE azzp110_trans_temp_to_dzcdl_cs CURSOR FROM ls_sql
      FOREACH azzp110_trans_temp_to_dzcdl_cs INTO lc_dzcdl001,lc_dzcdl003_old
         DISPLAY "check gzos_t  lc_dzcdl001:",lc_dzcdl001
         #檢查過單號是否已超過筆數
      #   CALL azzp110_chk_dzld_rows()
      #   IF NOT g_chk_status THEN
      #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
      #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
      #      CALL g_gen_ch.writeLine(lc_msg)
      #      RETURN
      #   END IF
         
         #從多語言暫存檔找出該語言別資料
         LET lc_dzcdl003_new = ""
         EXECUTE azzp110_get_gzos_cs USING lc_dzcdl003_old INTO lc_dzcdl003_new
         
         IF NOT SQLCA.SQLCODE AND NOT cl_null(lc_dzcdl003_new) THEN
            #填寫過單資訊，需檢核是否存在主檔中
            LET lc_count = 0
            LET lc_item1 = "NULL"
            LET lc_item2 = "NULL"
            SELECT COUNT(1) INTO lc_count FROM dzcd_t
             WHERE dzcd001 = lc_dzcdl001
                          
            IF lc_count > 0 THEN
            #   IF NOT azzp110_insert_dzld('dzcdl_t','adzi220',lc_dzcdl001,' ') THEN
            #      LET g_chk_status = FALSE
            #      RETURN
            #   END IF
               LET lc_item1 = "adzi220"
               LET lc_item2 = lc_dzcdl001
            END IF
            
            UPDATE dzcdl_t SET dzcdl003 = lc_dzcdl003_new
             WHERE dzcdl001 = lc_dzcdl001 AND dzcdl002 = "zh_TW"         
            
            IF SQLCA.SQLCODE THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)dzcdl_t失敗...  dzcdl001:",lc_dzcdl001,"  dzcdl002:zh_TW","  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
               CALL g_gen_ch.writeLine(lc_msg)
               RETURN
            END IF

            #紀錄log
            LET lc_msg = "<tr hieght=22><td class=xl24>zh_TW</td>",                #更換語系
                                       "<td class=xl24>dzcdl_t</td>",              #更換的多語言table
                                       "<td class=xl24>",g_param.docno,"</td>",    #表單單號    
                                       "<td class=xl24>",g_param.seq,"</td>",      #項次
                                       "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                       "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                       "<td class=xl24>",lc_dzcdl003_old,"</td>",  #資料修改前
                                       "<td class=xl24>",lc_dzcdl003_new,"</td>",  #資料修改後
                         "</tr>"
            
            CALL g_gen_ch.writeLine(lc_msg)
         END IF
      END FOREACH
   END IF

   ########開始進行字典檔匯出至多語言檔的動作##########
   LET ls_sql = "SELECT dzcdl001,dzcdl003 FROM dzcdl_t WHERE dzcdl002 = 'zh_TW' ORDER BY dzcdl001"

   #取出語言種類與項目
   LET la_gzzy = azzp110_get_gzzy() #除了zh_TW 之外

   DECLARE exp_dzcdl_cs CURSOR FROM ls_sql
   FOREACH exp_dzcdl_cs INTO lc_dzcdl001,lc_dzcdl003_tw
      DISPLAY "check gzoz_t  lc_dzcdl001:",lc_dzcdl001
      #跑單身陣列
      FOR li_cnt = 1 TO la_gzzy.getLength()
         LET lc_update = "N"

         #字典檔找出該語言別資料
         LET lc_dzcdl003_new = ""
         LET ls_sql_gzoz = "SELECT ",la_gzzy[li_cnt].gzozcol CLIPPED,
                            " FROM gzoz_t WHERE gzoz000= '",lc_dzcdl003_tw CLIPPED,"' "
         PREPARE s20 FROM ls_sql_gzoz
         EXECUTE s20 INTO lc_dzcdl003_new
         
         #如果有資料且該筆資料不是null  
         #然後判斷該語言別是否有資料 沒有資料就insert 有資料確認該筆資料是否是null，是就update 
         #160303 改為以字典檔為主，若在字典檔有找到且非空白，就一律更新
         IF NOT SQLCA.SQLCODE AND NOT cl_null(lc_dzcdl003_new) THEN
            #檢查過單號是否已超過筆數
         #   CALL azzp110_chk_dzld_rows()
         #   IF NOT g_chk_status THEN
         #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
         #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
         #   CALL g_gen_ch.writeLine(lc_msg)
         #      RETURN
         #   END IF
 
            LET lc_dzcdl003_old = ""
            SELECT dzcdl003 INTO lc_dzcdl003_old FROM dzcdl_t
             WHERE dzcdl001 = lc_dzcdl001
               AND dzcdl002 = la_gzzy[li_cnt].gzzy001
            IF SQLCA.SQLCODE THEN
               #填寫過單資訊，需檢核是否存在主檔中
               LET lc_count = 0
               LET lc_item1 = "NULL"
               LET lc_item2 = "NULL"
               SELECT COUNT(1) INTO lc_count FROM dzcd_t
                WHERE dzcd001 = lc_dzcdl001
                             
               IF lc_count > 0 THEN
               #   IF NOT azzp110_insert_dzld('dzcdl_t','adzi220',lc_dzcdl001,' ') THEN
               #      LET g_chk_status = FALSE
               #      RETURN
               #   END IF
                  LET lc_item1 = "adzi220"
                  LET lc_item2 = lc_dzcdl001
               END IF
            
               INSERT INTO dzcdl_t(dzcdl001,dzcdl002,dzcdl003)
                  VALUES(lc_dzcdl001,la_gzzy[li_cnt].gzzy001,lc_dzcdl003_new)
               
               IF SQLCA.SQLCODE THEN
                  LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(insert)dzcdl_t失敗...  dzcdl001:",lc_dzcdl001,"  dzcdl002:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                  CALL g_gen_ch.writeLine(lc_msg)
                  RETURN
               END IF
               LET lc_update = "Y"
            ELSE
               IF la_gzzy[li_cnt].gzzy001 <> "zh_TW" AND lc_dzcdl003_new <> lc_dzcdl003_old THEN
                  #填寫過單資訊，需檢核是否存在主檔中
                  LET lc_count = 0
                  LET lc_item1 = "NULL"
                  LET lc_item2 = "NULL"
                  SELECT COUNT(1) INTO lc_count FROM dzcd_t
                   WHERE dzcd001 = lc_dzcdl001
                                
                  IF lc_count > 0 THEN
                  #   IF NOT azzp110_insert_dzld('dzcdl_t','adzi220',lc_dzcdl001,' ') THEN
                  #      LET g_chk_status = FALSE
                  #      RETURN
                  #   END IF
                     LET lc_item1 = "adzi220"
                     LET lc_item2 = lc_dzcdl001
                  END IF
            
                  UPDATE dzcdl_t SET dzcdl003 = lc_dzcdl003_new
                   WHERE dzcdl001 = lc_dzcdl001 AND dzcdl002 = la_gzzy[li_cnt].gzzy001
                  
                  IF SQLCA.SQLCODE THEN
                     LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)dzcdl_t失敗...  dzcdl001:",lc_dzcdl001,"  dzcdl002:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                     CALL g_gen_ch.writeLine(lc_msg)
                     RETURN
                  END IF
                  LET lc_update = "Y"
               END IF
            END IF
            
            IF lc_update = "Y" THEN
               #紀錄log
               LET lc_msg = "<tr hieght=22><td class=xl24>",la_gzzy[li_cnt].gzzy001,"</td>",   #更換語系
                                          "<td class=xl24>dzcdl_t</td>",              #更換的多語言table
                                          "<td class=xl24>",g_param.docno,"</td>",    #表單單號    
                                          "<td class=xl24>",g_param.seq,"</td>",      #項次
                                          "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                          "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                          "<td class=xl24>",lc_dzcdl003_old,"</td>",  #資料修改前
                                          "<td class=xl24>",lc_dzcdl003_new,"</td>",  #資料修改後
                            "</tr>"
               
               CALL g_gen_ch.writeLine(lc_msg)
            END IF
         END IF
         FREE s20
      END FOR
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_exp_dzcal()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_exp_dzcal()
   DEFINE ls_sql STRING
   DEFINE ls_sql_gzoz STRING
   DEFINE la_gzzy DYNAMIC ARRAY OF RECORD
             gzzy001 LIKE gzzy_t.gzzy001, #語言別
             gzozcol LIKE type_t.chr10    #語言別欄位
                  END RECORD
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE lc_dzcal001      LIKE dzcal_t.dzcal001
   DEFINE lc_dzcal003_tw   LIKE dzcal_t.dzcal003
   DEFINE lc_dzcal003_old  LIKE dzcal_t.dzcal003
   DEFINE lc_dzcal003_new  LIKE dzcal_t.dzcal003
   DEFINE lc_count         LIKE type_t.num5
   DEFINE lc_msg           STRING
   DEFINE lc_update        LIKE type_t.chr1
   DEFINE lc_item1         STRING
   DEFINE lc_item2         STRING
   

   #若是多語言暫存檔有資料的話，要先做暫存檔轉換的部分
   #否則後續用已更新後的字典檔再去對應各多語言檔的話，怕會有缺漏
   IF gs_trans_temp = "Y" THEN
      LET ls_sql = "SELECT dzcal001,dzcal003 FROM dzcal_t WHERE dzcal002 = 'zh_TW' ORDER BY dzcal001"
      
      DECLARE azzp110_trans_temp_to_dzcal_cs CURSOR FROM ls_sql
      FOREACH azzp110_trans_temp_to_dzcal_cs INTO lc_dzcal001,lc_dzcal003_old
         DISPLAY "check gzos_t  lc_dzcal001:",lc_dzcal001
         #檢查過單號是否已超過筆數
      #   CALL azzp110_chk_dzld_rows()
      #   IF NOT g_chk_status THEN
      #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
      #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
      #      CALL g_gen_ch.writeLine(lc_msg)
      #      RETURN
      #   END IF
         
         #從多語言暫存檔找出該語言別資料
         LET lc_dzcal003_new = ""
         EXECUTE azzp110_get_gzos_cs USING lc_dzcal003_old INTO lc_dzcal003_new
         
         IF NOT SQLCA.SQLCODE AND NOT cl_null(lc_dzcal003_new) THEN
            #填寫過單資訊，需檢核是否存在主檔中
            LET lc_count = 0
            LET lc_item1 = "NULL"
            LET lc_item2 = "NULL"
            SELECT COUNT(1) INTO lc_count FROM dzca_t
             WHERE dzca001 = lc_dzcal001
                          
            IF lc_count > 0 THEN
            #   IF NOT azzp110_insert_dzld('dzcal_t','adzi210',lc_dzcal001,' ') THEN
            #      LET g_chk_status = FALSE
            #      RETURN
            #   END IF
               LET lc_item1 = "adzi210"
               LET lc_item2 = lc_dzcal001
            END IF
            
            UPDATE dzcal_t SET dzcal003 = lc_dzcal003_new
             WHERE dzcal001 = lc_dzcal001 AND dzcal002 = "zh_TW"      
            
            IF SQLCA.SQLCODE THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)dzcal_t失敗...  dzcal001:",lc_dzcal001,"  dzcal002:zh_TW","  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
               CALL g_gen_ch.writeLine(lc_msg)
               RETURN
            END IF
 
            #紀錄log
            LET lc_msg = "<tr hieght=22><td class=xl24>zh_TW</td>",                #更換語系
                                       "<td class=xl24>dzcal_t</td>",              #更換的多語言table
                                       "<td class=xl24>",g_param.docno,"</td>",    #表單單號    
                                       "<td class=xl24>",g_param.seq,"</td>",      #項次
                                       "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                       "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                       "<td class=xl24>",lc_dzcal003_old,"</td>",  #資料修改前
                                       "<td class=xl24>",lc_dzcal003_new,"</td>",  #資料修改後
                         "</tr>"
            
            CALL g_gen_ch.writeLine(lc_msg)
         END IF
      END FOREACH
   END IF

   ########開始進行字典檔匯出至多語言檔的動作##########
   LET ls_sql = "SELECT dzcal001,dzcal003 FROM dzcal_t WHERE dzcal002 = 'zh_TW' ORDER BY dzcal001"

   #取出語言種類與項目
   LET la_gzzy = azzp110_get_gzzy() #除了zh_TW 之外

   DECLARE exp_dzcal_cs CURSOR FROM ls_sql
   FOREACH exp_dzcal_cs INTO lc_dzcal001,lc_dzcal003_tw
      DISPLAY "check gzoz_t  lc_dzcal001:",lc_dzcal001
      #跑單身陣列
      FOR li_cnt = 1 TO la_gzzy.getLength()
         LET lc_update = "N"
         
         #字典檔找出該語言別資料
         LET lc_dzcal003_new = ""
         LET ls_sql_gzoz = "SELECT ",la_gzzy[li_cnt].gzozcol CLIPPED,
                            " FROM gzoz_t WHERE gzoz000= '",lc_dzcal003_tw CLIPPED,"' "
         PREPARE s19 FROM ls_sql_gzoz
         EXECUTE s19 INTO lc_dzcal003_new
         
         #如果有資料且該筆資料不是null  
         #然後判斷該語言別是否有資料 沒有資料就insert 有資料確認該筆資料是否是null，是就update 
         #160303 改為以字典檔為主，若在字典檔有找到且非空白，就一律更新
         IF NOT SQLCA.SQLCODE AND NOT cl_null(lc_dzcal003_new) THEN
            #檢查過單號是否已超過筆數
         #   CALL azzp110_chk_dzld_rows()
         #   IF NOT g_chk_status THEN
         #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
         #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
         #   CALL g_gen_ch.writeLine(lc_msg)
         #      RETURN
         #   END IF

            LET lc_dzcal003_old = ""
            SELECT dzcal003 INTO lc_dzcal003_old FROM dzcal_t
             WHERE dzcal001 = lc_dzcal001
               AND dzcal002 = la_gzzy[li_cnt].gzzy001
            IF SQLCA.SQLCODE THEN
               #填寫過單資訊，需檢核是否存在主檔中
               LET lc_count = 0
               LET lc_item1 = "NULL"
               LET lc_item2 = "NULL"
               SELECT COUNT(1) INTO lc_count FROM dzca_t
                WHERE dzca001 = lc_dzcal001
                             
               IF lc_count > 0 THEN
               #   IF NOT azzp110_insert_dzld('dzcal_t','adzi210',lc_dzcal001,' ') THEN
               #      LET g_chk_status = FALSE
               #      RETURN
               #   END IF
                  LET lc_item1 = "adzi210"
                  LET lc_item2 = lc_dzcal001
               END IF
            
               INSERT INTO dzcal_t(dzcal001,dzcal002,dzcal003)
                  VALUES(lc_dzcal001,la_gzzy[li_cnt].gzzy001,lc_dzcal003_new)
               
               IF SQLCA.SQLCODE THEN
                  LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(insert)dzcal_t失敗...  dzcal001:",lc_dzcal001,"  dzcal002:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                  CALL g_gen_ch.writeLine(lc_msg)
                  RETURN
               END IF
               LET lc_update = "Y"
            ELSE
               IF la_gzzy[li_cnt].gzzy001 <> "zh_TW" AND lc_dzcal003_new <> lc_dzcal003_old THEN
                  #填寫過單資訊，需檢核是否存在主檔中
                  LET lc_count = 0
                  LET lc_item1 = "NULL"
                  LET lc_item2 = "NULL"
                  SELECT COUNT(1) INTO lc_count FROM dzca_t
                   WHERE dzca001 = lc_dzcal001
                                
                  IF lc_count > 0 THEN
                  #   IF NOT azzp110_insert_dzld('dzcal_t','adzi210',lc_dzcal001,' ') THEN
                  #      LET g_chk_status = FALSE
                  #      RETURN
                  #   END IF
                     LET lc_item1 = "adzi210"
                     LET lc_item2 = lc_dzcal001
                  END IF
            
                  UPDATE dzcal_t SET dzcal003 = lc_dzcal003_new
                   WHERE dzcal001 = lc_dzcal001 AND dzcal002 = la_gzzy[li_cnt].gzzy001
                  
                  IF SQLCA.SQLCODE THEN
                     LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)dzcal_t失敗...  dzcal001:",lc_dzcal001,"  dzcal002:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                     CALL g_gen_ch.writeLine(lc_msg)
                     RETURN
                  END IF
                  LET lc_update = "Y"
               END IF
            END IF
            
            IF lc_update = "Y" THEN
               #紀錄log
               LET lc_msg = "<tr hieght=22><td class=xl24>",la_gzzy[li_cnt].gzzy001,"</td>",   #更換語系
                                          "<td class=xl24>dzcal_t</td>",              #更換的多語言table
                                          "<td class=xl24>",g_param.docno,"</td>",    #表單單號    
                                          "<td class=xl24>",g_param.seq,"</td>",      #項次
                                          "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                          "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                          "<td class=xl24>",lc_dzcal003_old,"</td>",  #資料修改前
                                          "<td class=xl24>",lc_dzcal003_new,"</td>",  #資料修改後
                            "</tr>"
               
               CALL g_gen_ch.writeLine(lc_msg)
            END IF
         END IF
         FREE s19
      END FOR
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_exp_dzcbl()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_exp_dzcbl()
   DEFINE ls_sql STRING
   DEFINE ls_sql_gzoz STRING
   DEFINE la_gzzy DYNAMIC ARRAY OF RECORD
             gzzy001 LIKE gzzy_t.gzzy001, #語言別
             gzozcol LIKE type_t.chr10    #語言別欄位
                  END RECORD
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE lc_dzcbl001      LIKE dzcbl_t.dzcbl001
   DEFINE lc_dzcbl002      LIKE dzcbl_t.dzcbl002
   DEFINE lc_dzcbl004_tw   LIKE dzcbl_t.dzcbl004
   DEFINE lc_dzcbl004_old  LIKE dzcbl_t.dzcbl004
   DEFINE lc_dzcbl004_new  LIKE dzcbl_t.dzcbl004
   DEFINE lc_count         LIKE type_t.num5
   DEFINE lc_msg           STRING
   DEFINE lc_update        LIKE type_t.chr1
   DEFINE lc_item1         STRING
   DEFINE lc_item2         STRING
   

   #若是多語言暫存檔有資料的話，要先做暫存檔轉換的部分
   #否則後續用已更新後的字典檔再去對應各多語言檔的話，怕會有缺漏
   IF gs_trans_temp = "Y" THEN
      LET ls_sql = "SELECT dzcbl001,dzcbl002,dzcbl004 FROM dzcbl_t WHERE dzcbl003 = 'zh_TW' ORDER BY dzcbl001"

      DECLARE azzp110_trans_temp_to_dzcbl_cs CURSOR FROM ls_sql
      FOREACH azzp110_trans_temp_to_dzcbl_cs INTO lc_dzcbl001,lc_dzcbl002,lc_dzcbl004_old
         DISPLAY "check gzos_t  lc_dzcbl001:",lc_dzcbl001
         #檢查過單號是否已超過筆數
      #   CALL azzp110_chk_dzld_rows()
      #   IF NOT g_chk_status THEN
      #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
      #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
      #      CALL g_gen_ch.writeLine(lc_msg)
      #      RETURN
      #   END IF
         
         #從多語言暫存檔找出該語言別資料
         LET lc_dzcbl004_new = ""
         EXECUTE azzp110_get_gzos_cs USING lc_dzcbl004_old INTO lc_dzcbl004_new
         
         IF NOT SQLCA.SQLCODE AND NOT cl_null(lc_dzcbl004_new) THEN
            #填寫過單資訊，需檢核是否存在主檔中
            LET lc_count = 0
            LET lc_item1 = "NULL"
            LET lc_item2 = "NULL"
            SELECT COUNT(1) INTO lc_count FROM dzca_t
              WHERE dzca001 = lc_dzcbl001
                          
            IF lc_count > 0 THEN
            #   IF NOT azzp110_insert_dzld('dzcbl_t','adzi210',lc_dzcbl001,' ') THEN
            #      LET g_chk_status = FALSE
            #      RETURN
            #   END IF
               LET lc_item1 = "adzi210"
               LET lc_item2 = lc_dzcbl001
            END IF
            
            UPDATE dzcbl_t SET dzcbl004 = lc_dzcbl004_new
             WHERE dzcbl001 = lc_dzcbl001 AND dzcbl002 = lc_dzcbl002 AND dzcbl003 = "zh_TW"               
            
            IF SQLCA.SQLCODE THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)dzcbl_t失敗...  dzcbl001:",lc_dzcbl001,"  dzcbl002:",lc_dzcbl002,
                                                       "  dzcbl003:zh_TW","  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
               CALL g_gen_ch.writeLine(lc_msg)
               RETURN
            END IF

            #紀錄log
            LET lc_msg = "<tr hieght=22><td class=xl24>zh_TW</td>",                #更換語系
                                       "<td class=xl24>dzcbl_t</td>",              #更換的多語言table
                                       "<td class=xl24>",g_param.docno,"</td>",    #表單單號    
                                       "<td class=xl24>",g_param.seq,"</td>",      #項次
                                       "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                       "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                       "<td class=xl24>",lc_dzcbl004_old,"</td>",  #資料修改前
                                       "<td class=xl24>",lc_dzcbl004_new,"</td>",  #資料修改後
                         "</tr>"
            
            CALL g_gen_ch.writeLine(lc_msg)
         END IF
      END FOREACH
   END IF

   ########開始進行字典檔匯出至多語言檔的動作##########
   LET ls_sql = "SELECT dzcbl001,dzcbl002,dzcbl004 FROM dzcbl_t WHERE dzcbl003 = 'zh_TW' ORDER BY dzcbl001"

   #取出語言種類與項目
   LET la_gzzy = azzp110_get_gzzy() #除了zh_TW 之外

   DECLARE exp_dzcbl_cs CURSOR FROM ls_sql
   FOREACH exp_dzcbl_cs INTO lc_dzcbl001,lc_dzcbl002,lc_dzcbl004_tw
      DISPLAY "check gzoz_t  lc_dzcbl001:",lc_dzcbl001
      #跑單身陣列
      FOR li_cnt = 1 TO la_gzzy.getLength()
         LET lc_update = "N"

         #字典檔找出該語言別資料
         LET lc_dzcbl004_new = ""
         LET ls_sql_gzoz = "SELECT ",la_gzzy[li_cnt].gzozcol CLIPPED,
                            " FROM gzoz_t WHERE gzoz000= '",lc_dzcbl004_tw CLIPPED,"' "
         PREPARE s21 FROM ls_sql_gzoz
         EXECUTE s21 INTO lc_dzcbl004_new
         #如果有資料且該筆資料不是null  
         #然後判斷該語言別是否有資料 沒有資料就insert 有資料確認該筆資料是否是null，是就update
         #160303 改為以字典檔為主，若在字典檔有找到且非空白，就一律更新         
         IF NOT SQLCA.SQLCODE AND NOT cl_null(lc_dzcbl004_new) THEN
            #檢查過單號是否已超過筆數
         #   CALL azzp110_chk_dzld_rows()
         #   IF NOT g_chk_status THEN
         #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
         #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
         #   CALL g_gen_ch.writeLine(lc_msg)
         #      RETURN
         #   END IF

            LET lc_dzcbl004_old = ""
            SELECT dzcbl004 INTO lc_dzcbl004_old FROM dzcbl_t
             WHERE dzcbl001 = lc_dzcbl001
               AND dzcbl002 = lc_dzcbl002
               AND dzcbl003 = la_gzzy[li_cnt].gzzy001
            IF SQLCA.SQLCODE THEN
               #填寫過單資訊，需檢核是否存在主檔中
               LET lc_count = 0
               LET lc_item1 = "NULL"
               LET lc_item2 = "NULL"
               SELECT COUNT(1) INTO lc_count FROM dzca_t
                 WHERE dzca001 = lc_dzcbl001
                             
               IF lc_count > 0 THEN
               #   IF NOT azzp110_insert_dzld('dzcbl_t','adzi210',lc_dzcbl001,' ') THEN
               #      LET g_chk_status = FALSE
               #      RETURN
               #   END IF
                  LET lc_item1 = "adzi210"
                  LET lc_item2 = lc_dzcbl001
               END IF
            
               INSERT INTO dzcbl_t(dzcbl001,dzcbl002,dzcbl003,dzcbl004)
                  VALUES(lc_dzcbl001,lc_dzcbl002,la_gzzy[li_cnt].gzzy001,lc_dzcbl004_new)
               
               IF SQLCA.SQLCODE THEN
                  LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(insert)dzcbl_t失敗...  dzcbl001:",lc_dzcbl001,"  dzcbl002:",lc_dzcbl002,
                                                          "  dzcbl003:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                  CALL g_gen_ch.writeLine(lc_msg)
                  RETURN
               END IF
               LET lc_update = "Y"
            ELSE
               IF la_gzzy[li_cnt].gzzy001 <> "zh_TW" AND lc_dzcbl004_new <> lc_dzcbl004_old THEN
                  #填寫過單資訊，需檢核是否存在主檔中
                  LET lc_count = 0
                  LET lc_item1 = "NULL"
                  LET lc_item2 = "NULL"
                  SELECT COUNT(1) INTO lc_count FROM dzca_t
                    WHERE dzca001 = lc_dzcbl001
                                
                  IF lc_count > 0 THEN
                  #   IF NOT azzp110_insert_dzld('dzcbl_t','adzi210',lc_dzcbl001,' ') THEN
                  #      LET g_chk_status = FALSE
                  #      RETURN
                  #   END IF
                     LET lc_item1 = "adzi210"
                     LET lc_item2 = lc_dzcbl001
                  END IF
            
                  UPDATE dzcbl_t SET dzcbl004 = lc_dzcbl004_new
                   WHERE dzcbl001 = lc_dzcbl001 AND dzcbl002 = lc_dzcbl002
                     AND dzcbl003 = la_gzzy[li_cnt].gzzy001
                  
                  IF SQLCA.SQLCODE THEN
                     LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)dzcbl_t失敗...  dzcbl001:",lc_dzcbl001,"  dzcbl002:",lc_dzcbl002,
                                                             "  dzcbl003:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                     CALL g_gen_ch.writeLine(lc_msg)
                     RETURN
                  END IF
                  LET lc_update = "Y"
               END IF
            END IF
            
            IF lc_update = "Y" THEN
               #紀錄log
               LET lc_msg = "<tr hieght=22><td class=xl24>",la_gzzy[li_cnt].gzzy001,"</td>",   #更換語系
                                          "<td class=xl24>dzcbl_t</td>",              #更換的多語言table
                                          "<td class=xl24>",g_param.docno,"</td>",    #表單單號    
                                          "<td class=xl24>",g_param.seq,"</td>",      #項次
                                          "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                          "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                          "<td class=xl24>",lc_dzcbl004_old,"</td>",  #資料修改前
                                          "<td class=xl24>",lc_dzcbl004_new,"</td>",  #資料修改後
                            "</tr>"
               
               CALL g_gen_ch.writeLine(lc_msg)
            END IF
         END IF
         FREE s21
      END FOR
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_exp_dzcel()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_exp_dzcel()
   DEFINE ls_sql STRING
   DEFINE ls_sql_gzoz STRING
   DEFINE la_gzzy DYNAMIC ARRAY OF RECORD
             gzzy001 LIKE gzzy_t.gzzy001, #語言別
             gzozcol LIKE type_t.chr10    #語言別欄位
                  END RECORD
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE lc_dzcel001      LIKE dzcel_t.dzcel001
   DEFINE lc_dzcel002      LIKE dzcel_t.dzcel002
   DEFINE lc_dzcel004_tw   LIKE dzcel_t.dzcel004
   DEFINE lc_dzcel004_old  LIKE dzcel_t.dzcel004
   DEFINE lc_dzcel004_new  LIKE dzcel_t.dzcel004
   DEFINE lc_count         LIKE type_t.num5
   DEFINE lc_msg           STRING
   DEFINE lc_update        LIKE type_t.chr1
   DEFINE lc_item1         STRING
   DEFINE lc_item2         STRING
   

   #若是多語言暫存檔有資料的話，要先做暫存檔轉換的部分
   #否則後續用已更新後的字典檔再去對應各多語言檔的話，怕會有缺漏
   IF gs_trans_temp = "Y" THEN
      LET ls_sql = "SELECT dzcel001,dzcel002,dzcel004 FROM dzcel_t WHERE dzcel003 = 'zh_TW' ORDER BY dzcel001"

      DECLARE azzp110_trans_temp_to_dzcel_cs CURSOR FROM ls_sql
      FOREACH azzp110_trans_temp_to_dzcel_cs INTO lc_dzcel001,lc_dzcel002,lc_dzcel004_old
         DISPLAY "check gzos_t  lc_dzcel001:",lc_dzcel001
         #檢查過單號是否已超過筆數
      #   CALL azzp110_chk_dzld_rows()
      #   IF NOT g_chk_status THEN
      #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
      #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
      #      CALL g_gen_ch.writeLine(lc_msg)
      #      RETURN
      #   END IF
         
         #從多語言暫存檔找出該語言別資料
         LET lc_dzcel004_new = ""
         EXECUTE azzp110_get_gzos_cs USING lc_dzcel004_old INTO lc_dzcel004_new
         
         IF NOT SQLCA.SQLCODE AND NOT cl_null(lc_dzcel004_new) THEN
            #填寫過單資訊，需檢核是否存在主檔中
            LET lc_count = 0
            LET lc_item1 = "NULL"
            LET lc_item2 = "NULL"
            SELECT COUNT(1) INTO lc_count FROM dzcd_t
             WHERE dzcd001 = lc_dzcel001
                          
            IF lc_count > 0 THEN
            #   IF NOT azzp110_insert_dzld('dzcel_t','adzi220',lc_dzcel001,' ') THEN
            #      LET g_chk_status = FALSE
            #      RETURN
            #   END IF
               LET lc_item1 = "adzi220"
               LET lc_item2 = lc_dzcel001
            END IF
            
            UPDATE dzcel_t SET dzcel004 = lc_dzcel004_new
             WHERE dzcel001 = lc_dzcel001 AND dzcel002 = lc_dzcel002
               AND dzcel003 = "zh_TW"
            
            IF SQLCA.SQLCODE THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)dzcel_t失敗...  dzcel001:",lc_dzcel001,"  dzcel002:",lc_dzcel002,
                                                       "  dzcel003:zh_TW","  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
               CALL g_gen_ch.writeLine(lc_msg)
               RETURN
            END IF

            #紀錄log
            LET lc_msg = "<tr hieght=22><td class=xl24>zh_TW</td>",                #更換語系
                                       "<td class=xl24>dzcel_t</td>",              #更換的多語言table
                                       "<td class=xl24>",g_param.docno,"</td>",    #表單單號    
                                       "<td class=xl24>",g_param.seq,"</td>",      #項次
                                       "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                       "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                       "<td class=xl24>",lc_dzcel004_old,"</td>",  #資料修改前
                                       "<td class=xl24>",lc_dzcel004_new,"</td>",  #資料修改後
                         "</tr>"
            
            CALL g_gen_ch.writeLine(lc_msg)
         END IF
      END FOREACH
   END IF

   ########開始進行字典檔匯出至多語言檔的動作##########
   LET ls_sql = "SELECT dzcel001,dzcel002,dzcel004 FROM dzcel_t WHERE dzcel003 = 'zh_TW' ORDER BY dzcel001"

   #取出語言種類與項目
   LET la_gzzy = azzp110_get_gzzy() #除了zh_TW 之外

   DECLARE exp_dzcel_cs CURSOR FROM ls_sql
   FOREACH exp_dzcel_cs INTO lc_dzcel001,lc_dzcel002,lc_dzcel004_tw
      DISPLAY "check gzoz_t  lc_dzcel001:",lc_dzcel001
      #跑單身陣列
      FOR li_cnt = 1 TO la_gzzy.getLength()
         LET lc_update = "N"

         #字典檔找出該語言別資料
         LET lc_dzcel004_new = ""
         LET ls_sql_gzoz = "SELECT ",la_gzzy[li_cnt].gzozcol CLIPPED,
                            " FROM gzoz_t WHERE gzoz000= '",lc_dzcel004_tw CLIPPED,"' "
         PREPARE s22 FROM ls_sql_gzoz
         EXECUTE s22 INTO lc_dzcel004_new
         #如果有資料且該筆資料不是null  
         #然後判斷該語言別是否有資料 沒有資料就insert 有資料確認該筆資料是否是null，是就update 
         #160303 改為以字典檔為主，若在字典檔有找到且非空白，就一律更新
         IF NOT SQLCA.SQLCODE AND NOT cl_null(lc_dzcel004_new) THEN
            #檢查過單號是否已超過筆數
         #   CALL azzp110_chk_dzld_rows()
         #   IF NOT g_chk_status THEN
         #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
         #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
         #   CALL g_gen_ch.writeLine(lc_msg)
         #      RETURN
         #   END IF

            LET lc_dzcel004_old = ""
            SELECT dzcel004 INTO lc_dzcel004_old FROM dzcel_t
             WHERE dzcel001 = lc_dzcel001
               AND dzcel002 = lc_dzcel002
               AND dzcel003 = la_gzzy[li_cnt].gzzy001
            IF SQLCA.SQLCODE THEN
               #填寫過單資訊，需檢核是否存在主檔中
               LET lc_count = 0
               LET lc_item1 = "NULL"
               LET lc_item2 = "NULL"
               SELECT COUNT(1) INTO lc_count FROM dzcd_t
                WHERE dzcd001 = lc_dzcel001
                             
               IF lc_count > 0 THEN
               #   IF NOT azzp110_insert_dzld('dzcel_t','adzi220',lc_dzcel001,' ') THEN
               #      LET g_chk_status = FALSE
               #      RETURN
               #   END IF
                  LET lc_item1 = "adzi220"
                  LET lc_item2 = lc_dzcel001
               END IF
            
               INSERT INTO dzcel_t(dzcel001,dzcel002,dzcel003,dzcel004)
                  VALUES(lc_dzcel001,lc_dzcel002,la_gzzy[li_cnt].gzzy001,lc_dzcel004_new)
               
               IF SQLCA.SQLCODE THEN
                  LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(insert)dzcel_t失敗...  dzcel001:",lc_dzcel001,"  dzcel002:",lc_dzcel002,
                                                          "  dzcel003:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                  CALL g_gen_ch.writeLine(lc_msg)
                  RETURN
               END IF
               LET lc_update = "Y"
            ELSE
               IF la_gzzy[li_cnt].gzzy001 <> "zh_TW" AND lc_dzcel004_new <> lc_dzcel004_old THEN
                  #填寫過單資訊，需檢核是否存在主檔中
                  LET lc_count = 0
                  LET lc_item1 = "NULL"
                  LET lc_item2 = "NULL"
                  SELECT COUNT(1) INTO lc_count FROM dzcd_t
                   WHERE dzcd001 = lc_dzcel001
                                
                  IF lc_count > 0 THEN
                  #   IF NOT azzp110_insert_dzld('dzcel_t','adzi220',lc_dzcel001,' ') THEN
                  #      LET g_chk_status = FALSE
                  #      RETURN
                  #   END IF
                     LET lc_item1 = "adzi220"
                     LET lc_item2 = lc_dzcel001
                  END IF
            
                  UPDATE dzcel_t SET dzcel004 = lc_dzcel004_new
                   WHERE dzcel001 = lc_dzcel001 AND dzcel002 = lc_dzcel002
                     AND dzcel003 = la_gzzy[li_cnt].gzzy001
                  
                  IF SQLCA.SQLCODE THEN
                     LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)dzcel_t失敗...  dzcel001:",lc_dzcel001,"  dzcel002:",lc_dzcel002,
                                                             "  dzcel003:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                     CALL g_gen_ch.writeLine(lc_msg)
                     RETURN
                  END IF
                  LET lc_update = "Y"
               END IF
            END IF
            
            IF lc_update = "Y" THEN
               #紀錄log
               LET lc_msg = "<tr hieght=22><td class=xl24>",la_gzzy[li_cnt].gzzy001,"</td>",   #更換語系
                                          "<td class=xl24>dzcel_t</td>",              #更換的多語言table
                                          "<td class=xl24>",g_param.docno,"</td>",    #表單單號    
                                          "<td class=xl24>",g_param.seq,"</td>",      #項次
                                          "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                          "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                          "<td class=xl24>",lc_dzcel004_old,"</td>",  #資料修改前
                                          "<td class=xl24>",lc_dzcel004_new,"</td>",  #資料修改後
                            "</tr>"
               
               CALL g_gen_ch.writeLine(lc_msg)
            END IF
         END IF
         FREE s22
      END FOR
   END FOREACH 
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_chk_dzeal_twcn()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_chk_dzeal_twcn()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_dzeal001 LIKE dzeal_t.dzeal001
   DEFINE lc_dzeal002 LIKE dzeal_t.dzeal002
   DEFINE lc_dzeal003 LIKE dzeal_t.dzeal003
   DEFINE li_row      LIKE type_t.num10
   DEFINE lc_msg      STRING
   

   LET ls_sql = "SELECT dzeal001,dzeal002,dzeal003 FROM dzeal_t ",
                " WHERE dzeal002 = 'zh_TW' OR dzeal002 = 'zh_CN' ",
                " ORDER BY dzeal001,dzeal002"
   LET li_cnt = 1

   DECLARE azzp110_dzeal_twcn_cs CURSOR FROM ls_sql
   FOREACH azzp110_dzeal_twcn_cs INTO lc_dzeal001,lc_dzeal002,lc_dzeal003
      DISPLAY "check tw_cn dzeal_t:",lc_dzeal001
      IF cl_null(lc_dzeal003) THEN
         CONTINUE FOREACH
      END IF
      CALL azzp110_trim(lc_dzeal003) RETURNING lc_dzeal003
      IF NOT cl_chk_tworcn(lc_dzeal002 CLIPPED,lc_dzeal003 CLIPPED,0) THEN
         DISPLAY li_cnt," Error Translate-lc_dzeal001:",lc_dzeal001,"   lc_dzeal002:",lc_dzeal002,
                        "   lc_dzeal003:",lc_dzeal003
         LET li_cnt = li_cnt + 1
         
         LET lc_msg = "<tr hieght=22><td class=xl24>dzeal_t</td>",                          #檢查檔案
                                       "<td class=xl24>",lc_dzeal001,"</td>",              #key欄位1
                                       "<td class=xl24></td>",                             #key欄位2
                                       "<td class=xl24></td>",                             #key欄位3
                                       "<td class=xl24>",lc_dzeal002,"</td>",              #檢查語系
                                       "<td class=xl24>",lc_dzeal003,"</td>",              #原始字串   
                         "</tr>"
            
         CALL g_gen_ch.writeLine(lc_msg)
      END IF
   END FOREACH
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
PRIVATE FUNCTION azzp110_chk_dzebl_twcn()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_dzebl001 LIKE dzebl_t.dzebl001
   DEFINE lc_dzebl002 LIKE dzebl_t.dzebl002
   DEFINE lc_dzebl003 LIKE dzebl_t.dzebl003
   DEFINE li_row      LIKE type_t.num10
   DEFINE lc_msg      STRING
   

   LET ls_sql = "SELECT dzebl001,dzebl002,dzebl003 FROM dzebl_t ",
                " WHERE dzebl002 = 'zh_TW' OR dzebl002 = 'zh_CN' ",
                " ORDER BY dzebl001,dzebl002"
   LET li_cnt = 1

   DECLARE azzp110_dzebl_twcn_cs CURSOR FROM ls_sql
   FOREACH azzp110_dzebl_twcn_cs INTO lc_dzebl001,lc_dzebl002,lc_dzebl003
      DISPLAY "check tw_cn dzebl_t:",lc_dzebl001
      IF cl_null(lc_dzebl003) THEN
         CONTINUE FOREACH
      END IF
      CALL azzp110_trim(lc_dzebl002) RETURNING lc_dzebl002
      IF NOT cl_chk_tworcn(lc_dzebl002 CLIPPED,lc_dzebl003 CLIPPED,0) THEN
         DISPLAY li_cnt," Error Translate-dzebl001:",lc_dzebl001,"   dzebl002:",lc_dzebl002,
                       "   dzebl003:",lc_dzebl003
         LET li_cnt = li_cnt + 1
         
         LET lc_msg = "<tr hieght=22><td class=xl24>dzebl_t</td>",                      #檢查檔案
                                    "<td class=xl24>",lc_dzebl001,"</td>",              #key欄位1
                                    "<td class=xl24></td>",                             #key欄位2
                                    "<td class=xl24></td>",                             #key欄位3
                                    "<td class=xl24>",lc_dzebl002,"</td>",              #檢查語系
                                    "<td class=xl24>",lc_dzebl003,"</td>",              #原始字串  
                         "</tr>"
            
         CALL g_gen_ch.writeLine(lc_msg)
      END IF
   END FOREACH

END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_chk_gzzal_twcn()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_chk_gzzal_twcn()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_gzzal001 LIKE gzzal_t.gzzal001
   DEFINE lc_gzzal002 LIKE gzzal_t.gzzal002
   DEFINE lc_gzzal003 LIKE gzzal_t.gzzal003 
   DEFINE li_row      LIKE type_t.num10
   DEFINE lc_msg      STRING
   

   LET ls_sql = "SELECT gzzal001,gzzal002,gzzal003 FROM gzzal_t ",
                " WHERE gzzal002 = 'zh_TW' OR gzzal002 = 'zh_CN' ",
                " ORDER BY gzzal001,gzzal002"
   LET li_cnt = 1

   DECLARE azzp110_gzzal_twcn_cs CURSOR FROM ls_sql
   FOREACH azzp110_gzzal_twcn_cs INTO lc_gzzal001,lc_gzzal002,lc_gzzal003
      DISPLAY "check tw_cn gzzal_t:",lc_gzzal001
      IF cl_null(lc_gzzal003) THEN
         CONTINUE FOREACH
      END IF
      CALL azzp110_trim(lc_gzzal003) RETURNING lc_gzzal003
      IF NOT cl_chk_tworcn(lc_gzzal002 CLIPPED,lc_gzzal003 CLIPPED,0) THEN
         DISPLAY li_cnt," Error Translate-lc_gzzal001:",lc_gzzal001,"   lc_gzzal002:",lc_gzzal002,"   lc_gzzal003:",lc_gzzal003 
         LET li_cnt = li_cnt + 1
         
         LET lc_msg = "<tr hieght=22><td class=xl24>gzzal_t</td>",                          #檢查檔案
                                       "<td class=xl24>",lc_gzzal001,"</td>",              #key欄位1
                                       "<td class=xl24></td>",                             #key欄位2
                                       "<td class=xl24></td>",                             #key欄位3
                                       "<td class=xl24>",lc_gzzal002,"</td>",              #檢查語系
                                       "<td class=xl24>",lc_gzzal003,"</td>",              #原始字串    
                         "</tr>"
            
         CALL g_gen_ch.writeLine(lc_msg)
      END IF
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_chk_gzzd_twcn()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_chk_gzzd_twcn()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE li_cnt2      LIKE type_t.num10
   DEFINE lc_gzzd001 LIKE gzzd_t.gzzd001
   DEFINE lc_gzzd002 LIKE gzzd_t.gzzd002
   DEFINE lc_gzzd003 LIKE gzzd_t.gzzd003
   DEFINE lc_gzzd005 LIKE gzzd_t.gzzd005
   DEFINE lc_gzzd006 LIKE gzzd_t.gzzd006
   DEFINE li_row      LIKE type_t.num10
   DEFINE lc_msg      STRING
   

   LET ls_sql = "SELECT gzzd001,gzzd002,gzzd003,gzzd005,gzzd006 FROM gzzd_t ",
                " WHERE gzzd002 = 'zh_TW' OR gzzd002 = 'zh_CN' ",
                " ORDER BY gzzd001,gzzd002,gzzd003"
   LET li_cnt = 1
   LET li_cnt2 = 1
   DECLARE azzp110_gzzd_twcn_cs CURSOR FROM ls_sql
   FOREACH azzp110_gzzd_twcn_cs INTO lc_gzzd001,lc_gzzd002,lc_gzzd003,lc_gzzd005,lc_gzzd006
      DISPLAY "check tw_cn gzzd_t:",lc_gzzd001
      IF cl_null(lc_gzzd005) AND cl_null(lc_gzzd006) THEN
         CONTINUE FOREACH
      END IF
      
      CALL azzp110_trim(lc_gzzd005) RETURNING lc_gzzd005
      IF NOT cl_null(lc_gzzd005) THEN 
         IF NOT cl_chk_tworcn(lc_gzzd002 CLIPPED,lc_gzzd005 CLIPPED,0) THEN
            DISPLAY li_cnt," Error Translate-lc_gzzd001:",lc_gzzd001,"   lc_gzzd002:",lc_gzzd002,"   lc_gzzd003:",lc_gzzd003 ,"   lc_gzzd005:",lc_gzzd005
            LET li_cnt = li_cnt + 1
            
            LET lc_msg = "<tr hieght=22><td class=xl24>gzzd_t</td>",                          #檢查檔案
                                       "<td class=xl24>",lc_gzzd001,"</td>",              #key欄位1
                                       "<td class=xl24>",lc_gzzd003,"</td>",              #key欄位2
                                       "<td class=xl24></td>",                            #key欄位3
                                       "<td class=xl24>",lc_gzzd002,"</td>",              #檢查語系
                                       "<td class=xl24>",lc_gzzd005,"</td>",              #原始字串 
                         "</tr>"
            
            CALL g_gen_ch.writeLine(lc_msg)
         END IF  
      END IF 

      CALL azzp110_trim(lc_gzzd006) RETURNING lc_gzzd006
      IF NOT cl_null(lc_gzzd006) THEN 
         IF NOT cl_chk_tworcn(lc_gzzd002 CLIPPED,lc_gzzd006 CLIPPED,0) THEN
            DISPLAY li_cnt2," Error Translate-lc_gzzd001:",lc_gzzd001,"   lc_gzzd002:",lc_gzzd002,"   lc_gzzd003:",lc_gzzd003 ,"   lc_gzzd006:",lc_gzzd006
            LET li_cnt2 = li_cnt2 + 1
            
            LET lc_msg = "<tr hieght=22><td class=xl24>gzzd_t</td>",                          #檢查檔案
                                       "<td class=xl24>",lc_gzzd001,"</td>",              #key欄位1
                                       "<td class=xl24>",lc_gzzd003,"</td>",              #key欄位2
                                       "<td class=xl24></td>",                            #key欄位3
                                       "<td class=xl24>",lc_gzzd002,"</td>",              #檢查語系
                                       "<td class=xl24>",lc_gzzd006,"</td>",              #原始字串  
                         "</tr>"
            
            CALL g_gen_ch.writeLine(lc_msg)
         END IF  
      END IF 
      
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_chk_gzdfl_twcn()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_chk_gzdfl_twcn()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_gzdfl001 LIKE gzdfl_t.gzdfl001
   DEFINE lc_gzdfl002 LIKE gzdfl_t.gzdfl002
   DEFINE lc_gzdfl003 LIKE gzdfl_t.gzdfl003
   DEFINE li_row      LIKE type_t.num10
   DEFINE lc_msg      STRING
   

   LET ls_sql = "SELECT gzdfl001,gzdfl002,gzdfl003 FROM gzdfl_t ",
                " WHERE gzdfl002 = 'zh_TW' OR gzdfl002 = 'zh_CN' ",
                " ORDER BY gzdfl001,gzdfl002 "
   LET li_cnt = 1

   DECLARE azzp110_gzdfl_twcn_cs CURSOR FROM ls_sql
   FOREACH azzp110_gzdfl_twcn_cs INTO lc_gzdfl001,lc_gzdfl002,lc_gzdfl003
      DISPLAY "check tw_cn gzdfl_t:",lc_gzdfl001
      IF cl_null(lc_gzdfl003) THEN
         CONTINUE FOREACH
      END IF
      CALL azzp110_trim(lc_gzdfl003) RETURNING lc_gzdfl003
      IF NOT cl_chk_tworcn(lc_gzdfl002 CLIPPED,lc_gzdfl003 CLIPPED,0) THEN
         DISPLAY li_cnt," Error Translate-lc_gzdfl001:",lc_gzdfl001,"   lc_gzdfl002:",lc_gzdfl002,"   lc_gzdfl003:",lc_gzdfl003 
         LET li_cnt = li_cnt + 1
         
         LET lc_msg = "<tr hieght=22><td class=xl24>gzdfl_t</td>",                          #檢查檔案
                                       "<td class=xl24>",lc_gzdfl001,"</td>",              #key欄位1
                                       "<td class=xl24></td>",                             #key欄位2
                                       "<td class=xl24></td>",                             #key欄位3
                                       "<td class=xl24>",lc_gzdfl002,"</td>",              #檢查語系
                                       "<td class=xl24>",lc_gzdfl003,"</td>",              #原始字串
                         "</tr>"
            
         CALL g_gen_ch.writeLine(lc_msg)
      END IF
   END FOREACH 
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_chk_gzzq_twcn()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_chk_gzzq_twcn()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE li_cnt2      LIKE type_t.num10
   DEFINE lc_gzzq001 LIKE  gzzq_t.gzzq001
   DEFINE lc_gzzq002 LIKE  gzzq_t.gzzq002
   DEFINE lc_gzzq003 LIKE  gzzq_t.gzzq003
   DEFINE lc_gzzq004 LIKE  gzzq_t.gzzq004
   DEFINE lc_gzzq005 LIKE  gzzq_t.gzzq005
   DEFINE li_row      LIKE type_t.num10
   DEFINE lc_msg      STRING
   

   LET ls_sql = "SELECT gzzq001,gzzq002,gzzq003,gzzq004,gzzq005 FROM gzzq_t ",
                " WHERE gzzq003 = 'zh_TW' OR gzzq003 = 'zh_CN' ",
                " ORDER BY gzzq001,gzzq002,gzzq003 "
   LET li_cnt = 1
   LET li_cnt2 = 1
   DECLARE azzp110_gzzq_twcn_cs CURSOR FROM ls_sql
   FOREACH azzp110_gzzq_twcn_cs INTO lc_gzzq001,lc_gzzq002,lc_gzzq003,lc_gzzq004,lc_gzzq005
      DISPLAY "check tw_cn gzzq_t:",lc_gzzq001
      IF cl_null(lc_gzzq004) AND cl_null(lc_gzzq005) THEN
         CONTINUE FOREACH
      END IF

      CALL azzp110_trim(lc_gzzq004) RETURNING lc_gzzq004
      IF NOT cl_null(lc_gzzq004) THEN 
         IF NOT cl_chk_tworcn(lc_gzzq003 CLIPPED, lc_gzzq004 CLIPPED,0) THEN
            DISPLAY li_cnt," Error Translate-lc_gzzq001:",lc_gzzq001,"   lc_gzzq002:",lc_gzzq002,"   lc_gzzq003:",lc_gzzq003 ,"   lc_gzzq004:",lc_gzzq004
            LET li_cnt = li_cnt + 1
            
            LET lc_msg = "<tr hieght=22><td class=xl24>gzzq_t</td>",                          #檢查檔案
                                       "<td class=xl24>",lc_gzzq001,"</td>",              #key欄位1
                                       "<td class=xl24>",lc_gzzq002,"</td>",              #key欄位2
                                       "<td class=xl24></td>",                            #key欄位3
                                       "<td class=xl24>",lc_gzzq003,"</td>",              #檢查語系
                                       "<td class=xl24>",lc_gzzq004,"</td>",              #原始字串    
                         "</tr>"
            
            CALL g_gen_ch.writeLine(lc_msg)
         END IF 
      END IF 

      CALL azzp110_trim(lc_gzzq005) RETURNING lc_gzzq005
      IF NOT cl_null(lc_gzzq005) THEN 
         IF NOT cl_chk_tworcn(lc_gzzq003 CLIPPED, lc_gzzq005 CLIPPED,0) THEN
            DISPLAY li_cnt2," Error Translate-lc_gzzq001:",lc_gzzq001,"   lc_gzzq002:",lc_gzzq002,"   lc_gzzq003:",lc_gzzq003 ,"   lc_gzzq005:",lc_gzzq005
            LET li_cnt2 = li_cnt2 + 1
            
            LET lc_msg = "<tr hieght=22><td class=xl24>gzzq_t</td>",                          #檢查檔案
                                       "<td class=xl24>",lc_gzzq001,"</td>",              #key欄位1
                                       "<td class=xl24>",lc_gzzq002,"</td>",              #key欄位2
                                       "<td class=xl24></td>",                            #key欄位3
                                       "<td class=xl24>",lc_gzzq003,"</td>",              #檢查語系
                                       "<td class=xl24>",lc_gzzq005,"</td>",              #原始字串    
                         "</tr>"
            
            CALL g_gen_ch.writeLine(lc_msg)
         END IF 
      END IF  

   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_chk_gzswl_twcn()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_chk_gzswl_twcn()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_gzswl001 LIKE gzswl_t.gzswl001
   DEFINE lc_gzswl002 LIKE gzswl_t.gzswl002
   DEFINE lc_gzswl003 LIKE gzswl_t.gzswl003
   DEFINE lc_gzswl004 LIKE gzswl_t.gzswl004
   DEFINE li_row      LIKE type_t.num10
   DEFINE lc_msg      STRING
   

   LET ls_sql = "SELECT gzswl001,gzswl002,gzswl003,gzswl004 FROM gzswl_t",
                " WHERE gzswl003 = 'zh_TW' OR gzswl003 = 'zh_CN' ",
                " ORDER BY gzswl001,gzswl002,gzswl003 "
   LET li_cnt = 1

   DECLARE azzp110_gzswl_twcn_cs CURSOR FROM ls_sql
   FOREACH azzp110_gzswl_twcn_cs INTO lc_gzswl001,lc_gzswl002,lc_gzswl003,lc_gzswl004
      DISPLAY "check tw_cn gzswl_t:",lc_gzswl001
      IF cl_null(lc_gzswl004) THEN
         CONTINUE FOREACH
      END IF
      CALL azzp110_trim(lc_gzswl004) RETURNING lc_gzswl004
      IF NOT cl_chk_tworcn(lc_gzswl003 CLIPPED,lc_gzswl004 CLIPPED,0) THEN
         DISPLAY li_cnt," Error Translate-lc_gzswl001:",lc_gzswl001,"   lc_gzswl002:",lc_gzswl002,"   lc_gzswl003:",lc_gzswl003  ,"   lc_gzswl004:",lc_gzswl004
         LET li_cnt = li_cnt + 1
         
         LET lc_msg = "<tr hieght=22><td class=xl24>gzswl_t</td>",                          #檢查檔案
                                       "<td class=xl24>",lc_gzswl001,"</td>",              #key欄位1
                                       "<td class=xl24>",lc_gzswl002,"</td>",              #key欄位2
                                       "<td class=xl24></td>",                             #key欄位3
                                       "<td class=xl24>",lc_gzswl003,"</td>",              #檢查語系
                                       "<td class=xl24>",lc_gzswl004,"</td>",              #原始字串
                         "</tr>"
            
         CALL g_gen_ch.writeLine(lc_msg)
      END IF
   END FOREACH 
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_chk_gzsxl_twcn()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_chk_gzsxl_twcn()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_gzsxl001 LIKE gzsxl_t.gzsxl001
   DEFINE lc_gzsxl002 LIKE gzsxl_t.gzsxl002
   DEFINE lc_gzsxl003 LIKE gzsxl_t.gzsxl003
   DEFINE lc_gzsxl004 LIKE gzsxl_t.gzsxl004 
   DEFINE lc_gzsxl005 LIKE gzsxl_t.gzsxl005 
   DEFINE li_row      LIKE type_t.num10
   DEFINE lc_msg      STRING
   

   LET ls_sql = "SELECT gzsxl001,gzsxl002,gzsxl003,gzsxl004,gzsxl005 FROM gzsxl_t",
                " WHERE gzsxl004 = 'zh_TW' OR gzsxl004 = 'zh_CN' ",
                " ORDER BY gzsxl001,gzsxl002,gzsxl003,gzsxl004  "
   LET li_cnt = 1

   DECLARE azzp110_gzsxl_twcn_cs CURSOR FROM ls_sql
   FOREACH azzp110_gzsxl_twcn_cs INTO lc_gzsxl001,lc_gzsxl002,lc_gzsxl003,lc_gzsxl004,lc_gzsxl005
      DISPLAY "check tw_cn gzsxl_t:",lc_gzsxl001
      IF cl_null(lc_gzsxl005) THEN
         CONTINUE FOREACH
      END IF
      CALL azzp110_trim(lc_gzsxl005) RETURNING lc_gzsxl005
      IF NOT cl_chk_tworcn(lc_gzsxl004 CLIPPED,lc_gzsxl005 CLIPPED,0) THEN
         DISPLAY li_cnt," Error Translate-lc_gzsxl001:",lc_gzsxl001,"   lc_gzsxl002:",lc_gzsxl002,"   lc_gzsxl003:",lc_gzsxl003  ,
            "   lc_gzsxl004:",lc_gzsxl004,"   lc_gzsxl005:",lc_gzsxl005
         LET li_cnt = li_cnt + 1
         
         LET lc_msg = "<tr hieght=22><td class=xl24>gzsxl_t</td>",                          #檢查檔案
                                       "<td class=xl24>",lc_gzsxl001,"</td>",              #key欄位1
                                       "<td class=xl24>",lc_gzsxl002,"</td>",              #key欄位2
                                       "<td class=xl24>",lc_gzsxl003,"</td>",              #key欄位3
                                       "<td class=xl24>",lc_gzsxl004,"</td>",              #檢查語系
                                       "<td class=xl24>",lc_gzsxl005,"</td>",              #原始字串  
                         "</tr>"
            
         CALL g_gen_ch.writeLine(lc_msg)
      END IF
   END FOREACH 
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_chk_gzszl_twcn()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_chk_gzszl_twcn()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE li_cnt2     LIKE type_t.num10
   DEFINE lc_gzszl001 LIKE gzszl_t.gzszl001
   DEFINE lc_gzszl002 LIKE gzszl_t.gzszl002
   DEFINE lc_gzszl003 LIKE gzszl_t.gzszl003
   DEFINE lc_gzszl004 LIKE gzszl_t.gzszl004
   DEFINE lc_gzszl005 LIKE gzszl_t.gzszl005
   DEFINE li_row      LIKE type_t.num10
   DEFINE lc_msg      STRING
   

   LET ls_sql = "SELECT gzszl001,gzszl002,gzszl003,gzszl004,gzszl005 FROM gzszl_t ",
                " WHERE gzszl003 = 'zh_TW' OR gzszl003 = 'zh_CN' ",
                " ORDER BY gzszl001,gzszl002,gzszl003,gzszl004  "
   LET li_cnt = 1

   DECLARE azzp110_gzszl_twcn_cs CURSOR FROM ls_sql
   FOREACH azzp110_gzszl_twcn_cs INTO lc_gzszl001,lc_gzszl002,lc_gzszl003,lc_gzszl004,lc_gzszl005
      DISPLAY "check tw_cn gzszl_t:",lc_gzszl001
      IF cl_null(lc_gzszl004) AND cl_null(lc_gzszl005) THEN
         CONTINUE FOREACH
      END IF

      CALL azzp110_trim(lc_gzszl004) RETURNING lc_gzszl004
      IF NOT cl_null(lc_gzszl004) THEN 
         IF NOT cl_chk_tworcn(lc_gzszl003 CLIPPED, lc_gzszl004 CLIPPED,0) THEN
            DISPLAY li_cnt," Error Translate-lc_gzszl001:",lc_gzszl001,"   lc_gzszl002:",lc_gzszl002,"   lc_gzszl003:",lc_gzszl003 ,"   lc_gzszl004:",lc_gzszl004
            LET li_cnt = li_cnt + 1
            
            LET lc_msg = "<tr hieght=22><td class=xl24>gzszl_t</td>",                          #檢查檔案
                                       "<td class=xl24>",lc_gzszl001,"</td>",              #key欄位1
                                       "<td class=xl24>",lc_gzszl002,"</td>",              #key欄位2
                                       "<td class=xl24></td>",                             #key欄位3
                                       "<td class=xl24>",lc_gzszl003,"</td>",              #檢查語系
                                       "<td class=xl24>",lc_gzszl004,"</td>",              #原始字串   
                         "</tr>"
            
            CALL g_gen_ch.writeLine(lc_msg)
         END IF 
      END IF 

      CALL azzp110_trim(lc_gzszl005) RETURNING lc_gzszl005
      IF NOT cl_null(lc_gzszl005) THEN 
         IF NOT cl_chk_tworcn(lc_gzszl003 CLIPPED, lc_gzszl005 CLIPPED,0) THEN
            DISPLAY li_cnt2," Error Translate-lc_gzzq001:",lc_gzszl001,"   lc_gzszl002:",lc_gzszl002,"   lc_gzszl003:",lc_gzszl003 ,"   lc_gzszl005:",lc_gzszl005
            LET li_cnt2 = li_cnt2 + 1
            
            LET lc_msg = "<tr hieght=22><td class=xl24>gzszl_t</td>",                          #檢查檔案
                                       "<td class=xl24>",lc_gzszl001,"</td>",              #key欄位1
                                       "<td class=xl24>",lc_gzszl002,"</td>",              #key欄位2
                                       "<td class=xl24></td>",                             #key欄位3
                                       "<td class=xl24>",lc_gzszl003,"</td>",              #檢查語系
                                       "<td class=xl24>",lc_gzszl005,"</td>",              #原始字串    
                         "</tr>"
            
            CALL g_gen_ch.writeLine(lc_msg)
         END IF 
      END IF  

   END FOREACH 
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_chk_gzwel_twcn()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_chk_gzwel_twcn()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_gzwel001 LIKE gzwel_t.gzwel001
   DEFINE lc_gzwel002 LIKE gzwel_t.gzwel002
   DEFINE lc_gzwel003 LIKE gzwel_t.gzwel003
   DEFINE li_row      LIKE type_t.num10
   DEFINE lc_msg      STRING
   

   LET ls_sql = "SELECT gzwel001,gzwel002,gzwel003 FROM gzwel_t ",
                " WHERE gzwelent = ",g_enterprise ," AND gzwel002 = 'zh_TW' OR gzwel002 = 'zh_CN' ",
                " ORDER BY gzwel001,gzwel002  "
    LET li_cnt = 1

   DECLARE azzp110_gzwel_twcn_cs CURSOR FROM ls_sql
   FOREACH azzp110_gzwel_twcn_cs INTO lc_gzwel001,lc_gzwel002,lc_gzwel003
      DISPLAY "check tw_cn gzwel_t:",lc_gzwel001
      IF cl_null(lc_gzwel003) THEN
         CONTINUE FOREACH
      END IF
      CALL azzp110_trim(lc_gzwel003) RETURNING lc_gzwel003
      IF NOT cl_chk_tworcn(lc_gzwel002 CLIPPED,lc_gzwel003 CLIPPED,0) THEN
         DISPLAY li_cnt," Error Translate-lc_gzwel001:",lc_gzwel001,"   lc_gzwel002:",lc_gzwel002,"   lc_gzwel003:",lc_gzwel003          
         LET li_cnt = li_cnt + 1
         
         LET lc_msg = "<tr hieght=22><td class=xl24>gzwel_t</td>",                          #檢查檔案
                                    "<td class=xl24>",lc_gzwel001,"</td>",              #key欄位1
                                    "<td class=xl24></td>",                             #key欄位2
                                    "<td class=xl24></td>",                             #key欄位3
                                    "<td class=xl24>",lc_gzwel002,"</td>",              #檢查語系
                                    "<td class=xl24>",lc_gzwel003,"</td>",              #原始字串    
                      "</tr>"
            
         CALL g_gen_ch.writeLine(lc_msg)
      END IF
   END FOREACH  
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_chk_gzcal_twcn()
#                  RETURNING 
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_chk_gzcal_twcn()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_gzcal001 LIKE gzcal_t.gzcal001
   DEFINE lc_gzcal002 LIKE gzcal_t.gzcal002
   DEFINE lc_gzcal003 LIKE gzcal_t.gzcal003
   DEFINE li_row      LIKE type_t.num10
   DEFINE lc_msg      STRING
   

   LET ls_sql = "SELECT gzcal001,gzcal002,gzcal003 FROM gzcal_t ",
                " WHERE gzcal002 = 'zh_TW' OR gzcal002 = 'zh_CN' ",
                " ORDER BY gzcal001,gzcal002  "
   LET li_cnt = 1

   DECLARE azzp110_gzcal_twcn_cs CURSOR FROM ls_sql
   FOREACH azzp110_gzcal_twcn_cs INTO lc_gzcal001,lc_gzcal002,lc_gzcal003
      DISPLAY "check tw_cn gzcal_t:",lc_gzcal001
      IF cl_null(lc_gzcal003) THEN
         CONTINUE FOREACH
      END IF
      CALL azzp110_trim(lc_gzcal003) RETURNING lc_gzcal003
      IF NOT cl_chk_tworcn(lc_gzcal002 CLIPPED,lc_gzcal003 CLIPPED,0) THEN
         DISPLAY li_cnt," Error Translate-lc_gzcal001:",lc_gzcal001,"   lc_gzcal002:",lc_gzcal002,"   lc_gzcal003:",lc_gzcal003  
            
         LET li_cnt = li_cnt + 1
         
         LET lc_msg = "<tr hieght=22><td class=xl24>gzcal_t</td>",                          #檢查檔案
                                    "<td class=xl24>",lc_gzcal001,"</td>",              #key欄位1
                                    "<td class=xl24></td>",                             #key欄位2
                                    "<td class=xl24></td>",                             #ke值欄位3
                                    "<td class=xl24>",lc_gzcal002,"</td>",              #檢查語系
                                    "<td class=xl24>",lc_gzcal003,"</td>",              #原始字串 
                      "</tr>"
            
         CALL g_gen_ch.writeLine(lc_msg)
      END IF
   END FOREACH  
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_chk_gzcbl_twcn()
#                  RETURNING 
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_chk_gzcbl_twcn()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE li_cnt2     LIKE type_t.num10
   DEFINE lc_gzcbl001 LIKE gzcbl_t.gzcbl001
   DEFINE lc_gzcbl002 LIKE gzcbl_t.gzcbl002
   DEFINE lc_gzcbl003 LIKE gzcbl_t.gzcbl003
   DEFINE lc_gzcbl004 LIKE gzcbl_t.gzcbl004
   DEFINE lc_gzcbl006 LIKE gzcbl_t.gzcbl006
   DEFINE li_row      LIKE type_t.num10
   DEFINE lc_msg      STRING
   

   LET ls_sql = "SELECT gzcbl001,gzcbl002,gzcbl003,gzcbl004,gzcbl006 FROM gzcbl_t ",
                " WHERE gzcbl003 = 'zh_TW' OR gzcbl003 = 'zh_CN' ",
                " ORDER BY gzcbl001,gzcbl002,gzcbl003,gzcbl004  "
   LET li_cnt = 1

   DECLARE azzp110_gzcbl_twcn_cs CURSOR FROM ls_sql
   FOREACH azzp110_gzcbl_twcn_cs INTO lc_gzcbl001,lc_gzcbl002,lc_gzcbl003,lc_gzcbl004,lc_gzcbl006
      DISPLAY "check tw_cn gzcbl_t:",lc_gzcbl001
      IF cl_null(lc_gzcbl004) AND cl_null(lc_gzcbl006) THEN
         CONTINUE FOREACH
      END IF

      CALL azzp110_trim(lc_gzcbl004) RETURNING lc_gzcbl004
      IF NOT cl_null(lc_gzcbl004) THEN 
         IF NOT cl_chk_tworcn(lc_gzcbl003 CLIPPED, lc_gzcbl004 CLIPPED,0) THEN
            DISPLAY li_cnt," Error Translate-lc_gzcbl001:",lc_gzcbl001,"   lc_gzcbl002:",lc_gzcbl002,"   lc_gzcbl003:",lc_gzcbl003 ,"   lc_gzcbl004:",lc_gzcbl004
            LET li_cnt = li_cnt + 1
            
            LET lc_msg = "<tr hieght=22><td class=xl24>gzcbl_t</td>",                      #檢查檔案
                                       "<td class=xl24>",lc_gzcbl001,"</td>",              #key欄位1
                                       "<td class=xl24>",lc_gzcbl002,"</td>",              #key欄位2
                                       "<td class=xl24></td>",                             #key欄位3
                                       "<td class=xl24>",lc_gzcbl003,"</td>",              #檢查語系
                                       "<td class=xl24>",lc_gzcbl004,"</td>",              #原始字串 
                         "</tr>"
            
            CALL g_gen_ch.writeLine(lc_msg)
         END IF 
      END IF 

      CALL azzp110_trim(lc_gzcbl006) RETURNING lc_gzcbl006
      IF NOT cl_null(lc_gzcbl006) THEN 
         IF NOT cl_chk_tworcn(lc_gzcbl003 CLIPPED, lc_gzcbl006 CLIPPED,0) THEN
            DISPLAY li_cnt," Error Translate-lc_gzcbl001:",lc_gzcbl001,"   lc_gzcbl002:",lc_gzcbl002,"   lc_gzcbl003:",lc_gzcbl003 ,"   lc_gzcbl006:",lc_gzcbl006
            LET li_cnt2 = li_cnt2 + 1
            
            
            LET lc_msg = "<tr hieght=22><td class=xl24>gzcbl_t</td>",                          #檢查檔案
                                       "<td class=xl24>",lc_gzcbl001,"</td>",              #key欄位1
                                       "<td class=xl24>",lc_gzcbl002,"</td>",              #key欄位2
                                       "<td class=xl24></td>",                             #key欄位3
                                       "<td class=xl24>",lc_gzcbl003,"</td>",              #檢查語系
                                       "<td class=xl24>",lc_gzcbl006,"</td>",              #原始字串  
                         "</tr>"
            
            CALL g_gen_ch.writeLine(lc_msg)
         END IF 
      END IF  
   END FOREACH 
END FUNCTION

################################################################################
# Descriptions...: 檢查 gzgdl 簡繁互用
# Memo...........:
# Usage..........: CALL azzp110_chk_gzgdl_twcn()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_chk_gzgdl_twcn()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_gzgdl000 LIKE gzgdl_t.gzgdl000
   DEFINE lc_gzgdl001 LIKE gzgdl_t.gzgdl001
   DEFINE lc_gzgdl002 LIKE gzgdl_t.gzgdl002
   DEFINE li_row      LIKE type_t.num10
   DEFINE lc_msg      STRING
   

   LET ls_sql = "SELECT gzgdl000,gzgdl001,gzgdl002 FROM gzgdl_t ",
                " WHERE (gzgdl001 = 'zh_TW' OR gzgdl001 = 'zh_CN' )",
                " ORDER BY gzgdl000,gzgdl001  "
   LET li_cnt = 1

   DECLARE azzp110_gzgdl_twcn_cs CURSOR FROM ls_sql
   FOREACH azzp110_gzgdl_twcn_cs INTO lc_gzgdl000,lc_gzgdl001,lc_gzgdl002
      DISPLAY "check tw_cn gzgdl_t:",lc_gzgdl001
      IF cl_null(lc_gzgdl002) THEN
         CONTINUE FOREACH
      END IF
      
      CALL azzp110_trim(lc_gzgdl002) RETURNING lc_gzgdl002
      IF NOT cl_chk_tworcn(lc_gzgdl001 CLIPPED,lc_gzgdl002 CLIPPED,0) THEN
         DISPLAY li_cnt," Error Translate-lc_gzgdl000:",lc_gzgdl000,"   lc_gzgdl001:",lc_gzgdl001,"   lc_gzgdl002:",lc_gzgdl002  
            
         LET li_cnt = li_cnt + 1
         
         
         LET lc_msg = "<tr hieght=22><td class=xl24>gzgdl_t</td>",                          #檢查檔案
                                       "<td class=xl24>",lc_gzgdl000,"</td>",              #key欄位1
                                       "<td class=xl24></td>",                             #key欄位2
                                       "<td class=xl24></td>",                             #key欄位3
                                       "<td class=xl24>",lc_gzgdl001,"</td>",              #檢查語系
                                       "<td class=xl24>",lc_gzgdl002,"</td>",              #原始字串   
                         "</tr>"
            
         CALL g_gen_ch.writeLine(lc_msg)
      END IF
   END FOREACH  
END FUNCTION

################################################################################
# Descriptions...: 檢查 gzge 簡繁互用
# Memo...........:
# Usage..........: CALL azzp110_chk_gzge_twcn()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_chk_gzge_twcn()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_gzgf001 LIKE gzgf_t.gzgf001
   DEFINE lc_gzgd001 LIKE gzgd_t.gzgd001
   DEFINE lc_gzge000 LIKE gzge_t.gzge000
   DEFINE lc_gzge001 LIKE gzge_t.gzge001
   DEFINE lc_gzge002 LIKE gzge_t.gzge002
   DEFINE lc_gzge003 LIKE gzge_t.gzge003
   DEFINE li_row      LIKE type_t.num10
   DEFINE lc_msg      STRING
   

   LET ls_sql = "SELECT gzgf001,gzgd001,gzge000,gzge001,gzge002,gzge003 FROM gzge_t ",
                " LEFT JOIN gzgf_t ON gzgf000 = gzge000 ",
                " LEFT JOIN gzgd_t ON gzgd000 = gzge000 ",
                " WHERE (gzge002 = 'zh_TW' OR gzge002 = 'zh_CN') ",
                " ORDER BY gzge000,gzge001,gzge002  "                
   LET li_cnt = 1

   DECLARE azzp110_gzge_twcn_cs CURSOR FROM ls_sql
   FOREACH azzp110_gzge_twcn_cs INTO lc_gzgf001,lc_gzgd001,lc_gzge000,lc_gzge001,lc_gzge002,lc_gzge003
      DISPLAY "check tw_cn gzge_t:",lc_gzge001
      IF cl_null(lc_gzge003) THEN
         CONTINUE FOREACH
      END IF
      CALL azzp110_trim(lc_gzge003) RETURNING lc_gzge003
      IF NOT cl_chk_tworcn(lc_gzge002 CLIPPED,lc_gzge003 CLIPPED,0) THEN
         IF NOT cl_null(lc_gzgf001) THEN
            DISPLAY li_cnt," Error Translate-lc_gzgf001:",lc_gzgf001,"   lc_gzge000:",lc_gzge000,"   lc_gzge001:",lc_gzge001,"   lc_gzge002:",lc_gzge002 ," lc_gzge003:",lc_gzge003  
         ELSE
            IF NOT cl_null(lc_gzgd001) THEN
               DISPLAY li_cnt," Error Translate-lc_gzgd001:",lc_gzgd001,"   lc_gzge000:",lc_gzge000,"   lc_gzge001:",lc_gzge001,"   lc_gzge002:",lc_gzge002 ," lc_gzge003:",lc_gzge003           
            ELSE
               DISPLAY li_cnt," Error Translate-lc_gzge000:",lc_gzge000,"   lc_gzge001:",lc_gzge001,"   lc_gzge002:",lc_gzge002 ," lc_gzge003:",lc_gzge003                       
            END IF            
         END IF         
         LET li_cnt = li_cnt + 1
         
         LET lc_msg = "<tr hieght=22><td class=xl24>gzge_t</td>",                          #檢查檔案
                                       "<td class=xl24>",lc_gzge000,"</td>",              #key欄位1
                                       "<td class=xl24>",lc_gzge001,"</td>",              #key欄位2
                                       "<td class=xl24></td>",                            #key欄位3
                                       "<td class=xl24>",lc_gzge002,"</td>",              #檢查語系
                                       "<td class=xl24>",lc_gzge003,"</td>",              #原始字串  
                         "</tr>"
            
         CALL g_gen_ch.writeLine(lc_msg)
      END IF
   END FOREACH  
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_chk_dzcal_twcn()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_chk_dzcal_twcn()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_dzcal001 LIKE dzcal_t.dzcal001
   DEFINE lc_dzcal002 LIKE dzcal_t.dzcal002
   DEFINE lc_dzcal003 LIKE dzcal_t.dzcal003
   DEFINE li_row      LIKE type_t.num10
   DEFINE lc_msg      STRING
   

   LET ls_sql = "SELECT dzcal001,dzcal002,dzcal003 FROM dzcal_t ",
                " WHERE dzcal002 = 'zh_TW' OR dzcal002 = 'zh_CN' ",
                " ORDER BY dzcal001,dzcal002 "
   LET li_cnt = 1

   DECLARE azzp110_dzcal_twcn_cs CURSOR FROM ls_sql
   FOREACH azzp110_dzcal_twcn_cs INTO lc_dzcal001,lc_dzcal002,lc_dzcal003
      DISPLAY "check tw_cn dzcal_t:",lc_dzcal001
      IF cl_null(lc_dzcal003) THEN
         CONTINUE FOREACH
      END IF
      CALL azzp110_trim(lc_dzcal003) RETURNING lc_dzcal003
      IF NOT cl_chk_tworcn(lc_dzcal002 CLIPPED,lc_dzcal003 CLIPPED,0) THEN
         DISPLAY li_cnt," Error Translate-lc_dzcal001:",lc_dzcal001,"   lc_dzcal002:",lc_dzcal002,"   lc_dzcal003:",lc_dzcal003
         LET li_cnt = li_cnt + 1
         
         LET lc_msg = "<tr hieght=22><td class=xl24>dzcal_t</td>",                          #檢查檔案
                                       "<td class=xl24>",lc_dzcal001,"</td>",              #key欄位1
                                       "<td class=xl24></td>",                             #key欄位2
                                       "<td class=xl24></td>",                             #key欄位3
                                       "<td class=xl24>",lc_dzcal002,"</td>",              #檢查語系
                                       "<td class=xl24>",lc_dzcal003,"</td>",              #原始字串    
                         "</tr>"
            
         CALL g_gen_ch.writeLine(lc_msg)
      END IF
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_chk_dzcdl_twcn()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_chk_dzcdl_twcn()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_dzcdl001 LIKE dzcdl_t.dzcdl001
   DEFINE lc_dzcdl002 LIKE dzcdl_t.dzcdl002
   DEFINE lc_dzcdl003 LIKE dzcdl_t.dzcdl003
   DEFINE li_row      LIKE type_t.num10
   DEFINE lc_msg      STRING
   

   LET ls_sql = "SELECT dzcdl001,dzcdl002,dzcdl003 FROM dzcdl_t ",
                " WHERE dzcdl002 = 'zh_TW' OR dzcdl002 = 'zh_CN' ",
                " ORDER BY dzcdl001,dzcdl002 "
   LET li_cnt = 1

   DECLARE azzp110_dzcdl_twcn_cs CURSOR FROM ls_sql
   FOREACH azzp110_dzcdl_twcn_cs INTO lc_dzcdl001,lc_dzcdl002,lc_dzcdl003
      DISPLAY "check tw_cn dzcdl_t:",lc_dzcdl001
      IF cl_null(lc_dzcdl003) THEN
         CONTINUE FOREACH
      END IF
      CALL azzp110_trim(lc_dzcdl003) RETURNING lc_dzcdl003
      IF NOT cl_chk_tworcn(lc_dzcdl002 CLIPPED,lc_dzcdl003 CLIPPED,0) THEN
         DISPLAY li_cnt," Error Translate-lc_dzcdl001:",lc_dzcdl001,"   lc_dzcdl002:",lc_dzcdl002,"   lc_dzcdl003:",lc_dzcdl003
         LET li_cnt = li_cnt + 1
         
         LET lc_msg = "<tr hieght=22><td class=xl24>dzcdl_t</td>",                          #檢查檔案
                                       "<td class=xl24>",lc_dzcdl001,"</td>",              #key欄位1
                                       "<td class=xl24></td>",                             #key欄位2
                                       "<td class=xl24></td>",                             #key欄位3
                                       "<td class=xl24>",lc_dzcdl002,"</td>",              #檢查語系
                                       "<td class=xl24>",lc_dzcdl003,"</td>",              #原始字串
                         "</tr>"
            
         CALL g_gen_ch.writeLine(lc_msg)
      END IF
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_chk_dzcbl_twcn()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_chk_dzcbl_twcn()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_dzcbl001 LIKE dzcbl_t.dzcbl001
   DEFINE lc_dzcbl002 LIKE dzcbl_t.dzcbl002
   DEFINE lc_dzcbl003 LIKE dzcbl_t.dzcbl003
   DEFINE lc_dzcbl004 LIKE dzcbl_t.dzcbl004
   DEFINE li_row      LIKE type_t.num10
   DEFINE lc_msg      STRING
   

   LET ls_sql = "SELECT dzcbl001,dzcbl002,dzcbl003,dzcbl004 FROM dzcbl_t ",
                " WHERE dzcbl003 = 'zh_TW' OR dzcbl003 = 'zh_CN' ",
                " ORDER BY dzcbl001,dzcbl002 "
   LET li_cnt = 1

   DECLARE azzp110_dzcbl_twcn_cs CURSOR FROM ls_sql
   FOREACH azzp110_dzcbl_twcn_cs INTO lc_dzcbl001,lc_dzcbl002,lc_dzcbl003,lc_dzcbl004
      DISPLAY "check tw_cn dzcbl_t:",lc_dzcbl001
      IF cl_null(lc_dzcbl004) THEN
         CONTINUE FOREACH
      END IF
      CALL azzp110_trim(lc_dzcbl004) RETURNING lc_dzcbl004
      IF NOT cl_chk_tworcn(lc_dzcbl003 CLIPPED,lc_dzcbl004 CLIPPED,0) THEN
         DISPLAY li_cnt," Error Translate-lc_dzcbl001:",lc_dzcbl001,"   lc_dzcbl002:",lc_dzcbl002,"   lc_dzcbl003:",lc_dzcbl003 ,"   lc_dzcbl004:",lc_dzcbl004
         LET li_cnt = li_cnt + 1
         
         LET lc_msg = "<tr hieght=22><td class=xl24>dzcbl_t</td>",                          #檢查檔案
                                       "<td class=xl24>",lc_dzcbl001,"</td>",              #key欄位1
                                       "<td class=xl24>",lc_dzcbl002,"</td>",              #key欄位2
                                       "<td class=xl24></td>",                             #key欄位3
                                       "<td class=xl24>",lc_dzcbl003,"</td>",              #檢查語系
                                       "<td class=xl24>",lc_dzcbl004,"</td>",              #原始字串
                         "</tr>"
            
         CALL g_gen_ch.writeLine(lc_msg)
      END IF
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_chk_dzcel_twcn()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_chk_dzcel_twcn()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_dzcel001 LIKE dzcel_t.dzcel001
   DEFINE lc_dzcel002 LIKE dzcel_t.dzcel002
   DEFINE lc_dzcel003 LIKE dzcel_t.dzcel003
   DEFINE lc_dzcel004 LIKE dzcel_t.dzcel004
   DEFINE li_row      LIKE type_t.num10
   DEFINE lc_msg      STRING
   

   LET ls_sql = "SELECT dzcel001,dzcel002,dzcel003,dzcel004 FROM dzcel_t ",
                " WHERE dzcel003 = 'zh_TW' OR dzcel003 = 'zh_CN' ",
                " ORDER BY dzcel001,dzcel002 "
   LET li_cnt = 1

   DECLARE azzp110_dzcel_twcn_cs CURSOR FROM ls_sql
   FOREACH azzp110_dzcel_twcn_cs INTO lc_dzcel001,lc_dzcel002,lc_dzcel003,lc_dzcel004
      DISPLAY "check tw_cn dzcel_t:",lc_dzcel001
      IF cl_null(lc_dzcel004) THEN
         CONTINUE FOREACH
      END IF
      CALL azzp110_trim(lc_dzcel004) RETURNING lc_dzcel004
      IF NOT cl_chk_tworcn(lc_dzcel003 CLIPPED,lc_dzcel004 CLIPPED,0) THEN
         DISPLAY li_cnt," Error Translate-lc_dzcel001:",lc_dzcel001,"   lc_dzcel002:",lc_dzcel002,"   lc_dzcel003:",lc_dzcel003 ,"   lc_dzcel004:",lc_dzcel004
         LET li_cnt = li_cnt + 1
         
         LET lc_msg = "<tr hieght=22><td class=xl24>dzcel_t</td>",                          #檢查檔案
                                       "<td class=xl24>",lc_dzcel001,"</td>",              #key欄位1
                                       "<td class=xl24>",lc_dzcel002,"</td>",              #key欄位2
                                       "<td class=xl24></td>",                             #key欄位3
                                       "<td class=xl24>",lc_dzcel003,"</td>",              #檢查語系
                                       "<td class=xl24>",lc_dzcel004,"</td>",              #原始字串   
                         "</tr>"
            
         CALL g_gen_ch.writeLine(lc_msg)
      END IF
   END FOREACH
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
PRIVATE FUNCTION azzp110_chk_gzoz_twcn()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_gzoz000 LIKE gzoz_t.gzoz000
   DEFINE lc_gzoz000_new LIKE gzoz_t.gzoz000
   DEFINE lc_gzoz002 LIKE gzoz_t.gzoz002
   DEFINE li_row      LIKE type_t.num10
   DEFINE lc_msg      STRING
   

   LET ls_sql = "SELECT gzoz000,gzoz002 FROM gzoz_t ",
                " ORDER BY gzoz000,gzoz002"
   DECLARE azzp110_gzoz_tw_cs CURSOR FROM ls_sql
   FOREACH azzp110_gzoz_tw_cs INTO lc_gzoz000,lc_gzoz002
      DISPLAY "check tw_cn gzoz_t:",lc_gzoz000
      IF NOT cl_chk_tworcn("zh_TW",lc_gzoz000 CLIPPED,0) THEN
         LET lc_gzoz000_new = cl_trans_code_tw_cn("zh_TW",lc_gzoz000)
         
         IF g_bgjob = "Y" AND (cl_null(lc_gzoz000_new) AND NOT cl_null(lc_gzoz000)) THEN               
            #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
            CONTINUE FOREACH
         END IF
         
         SELECT COUNT(*) INTO li_row FROM gzoz_t
          WHERE gzoz000 = lc_gzoz000_new
         DISPLAY " 繁體中文填入混用:",lc_gzoz000," 應該是->",lc_gzoz000_new
         IF li_row > 0 THEN
            DISPLAY "     資料已存在",li_row,"筆"
            #DELETE FROM gzoz_t WHERE gzoz000 = lc_gzoz000
         ELSE
            DISPLAY "     資料不存在,執行更新"
            UPDATE gzoz_t SET gzoz000 = lc_gzoz000_new
             WHERE gzoz000 = lc_gzoz000
         END IF
         
         LET lc_msg = "<tr hieght=22><td class=xl24>gzoz_t</td>",                     #檢查檔案
                                       "<td class=xl24>",lc_gzoz000,"</td>",          #key欄位1
                                       "<td class=xl24></td>",                        #key欄位2
                                       "<td class=xl24></td>",                        #key欄位3
                                       "<td class=xl24>zh_TW</td>",                   #檢查語系
                                       "<td class=xl24>",lc_gzoz000,"</td>",          #原始字串  
                         "</tr>"
            
         CALL g_gen_ch.writeLine(lc_msg)
      END IF
   END FOREACH

   LET ls_sql = "SELECT gzoz000,gzoz002 FROM gzoz_t ",
                " WHERE gzoz002 IS NOT NULL ",
                " ORDER BY gzoz000,gzoz002"
   DECLARE azzp110_gzoz_cn_cs CURSOR FROM ls_sql
   FOREACH azzp110_gzoz_cn_cs INTO lc_gzoz000,lc_gzoz002
      IF NOT cl_chk_tworcn("zh_CN",lc_gzoz002 CLIPPED,0) THEN
         DISPLAY " 簡體中文填入混用:",lc_gzoz002," (繁體中文:",lc_gzoz000,")"
         
         LET lc_msg = "<tr hieght=22><td class=xl24>gzoz_t</td>",                     #檢查檔案
                                       "<td class=xl24>",lc_gzoz000,"</td>",          #key欄位1
                                       "<td class=xl24></td>",                        #key欄位2
                                       "<td class=xl24></td>",                        #key欄位3
                                       "<td class=xl24>zh_CN</td>",                   #檢查語系
                                       "<td class=xl24>",lc_gzoz002,"</td>",              #原始字串
                                       "<td class=xl24>原始字串非純繁中或純簡中文字</td>",    #表單單號    
                         "</tr>"
            
         CALL g_gen_ch.writeLine(lc_msg)
      END IF
   END FOREACH
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
PRIVATE FUNCTION azzp110_chk_gzoz_and_insert(lc_gzoz000,lc_gzoz501,lc_gzozmodid,lc_gzozcrtdp)
   DEFINE ls_sql       STRING
   DEFINE lc_gzoz000   LIKE gzoz_t.gzoz000
   DEFINE lc_gzoz501   LIKE gzoz_t.gzoz501  #來源
   DEFINE lc_gzozmoddt LIKE gzoz_t.gzozmoddt
   DEFINE lc_gzozmodid LIKE gzoz_t.gzozmodid
   DEFINE lc_gzozcrtdp LIKE gzoz_t.gzozcrtdp
   DEFINE li_cnt       LIKE type_t.num5
   
   

   IF cl_null(lc_gzoz000) THEN
      RETURN
   END IF

   IF NOT mi_enable_cursor THEN
      LET ls_sql = "SELECT COUNT(1) FROM gzoz_t WHERE gzoz000 = ? "
      PREPARE azzp110_chk_gzoz_cs FROM ls_sql
      LET mi_enable_cursor = TRUE
   END IF
   
   IF cl_null(lc_gzozmodid) THEN
      LET lc_gzozmodid = g_user
   END IF
   IF cl_null(lc_gzozcrtdp) THEN
      LET lc_gzozcrtdp = g_dept
   END IF

   EXECUTE azzp110_chk_gzoz_cs USING lc_gzoz000 INTO li_cnt
   IF li_cnt = 0 THEN
      IF NOT cl_chk_num(lc_gzoz000,"NUL_") THEN   #檢核是否為純英數
         LET lc_gzozmoddt = cl_get_current()
         #                  繁體,   整句否   來源,   簡體,   簡體狀態  員工   日期
         INSERT INTO gzoz_t(gzoz000,gzoz500,gzoz501,gzoz002,gzoz102,
                            gzoz202,gzoz302,gzoz101,gzoz103,gzoz104,
                            gzoz105,gzoz106,gzoz503,
                            gzozstus,gzozownid,gzozowndp,gzozcrtid,gzozcrtdp,
                            gzozcrtdt,gzozmodid,gzozmoddt)
         VALUES (lc_gzoz000,'N',lc_gzoz501,'','N',
                 lc_gzozmodid,lc_gzozmoddt,'N','N','N',
                 'N','N','N',
                 'Y',lc_gzozmodid,lc_gzozcrtdp,lc_gzozmodid,lc_gzozcrtdp,
                 lc_gzozmoddt,lc_gzozmodid,lc_gzozmoddt)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "lib-00401"
            LET g_errparam.replace[1] = lc_gzoz000
            LET g_errparam.popup = TRUE
            CALL cl_err()
         END IF
      END IF
   END IF
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
PRIVATE FUNCTION azzp110_readme()
      
      DISPLAY "r.r azzp110 import_fr_dzeal_tw     #表格名稱"
      DISPLAY "r.r azzp110 import_fr_dzebl_tw     #欄位名稱"
      DISPLAY "r.r azzp110 import_fr_gzzal_tw     #程式/作業名稱"
      DISPLAY "r.r azzp110 import_fr_gzzd_tw      #畫面元件"
      DISPLAY "r.r azzp110 import_fr_gzdfl_tw     #子畫面名稱"
      DISPLAY "r.r azzp110 import_fr_gzzq_tw      #功能名稱"
      DISPLAY "r.r azzp110 import_fr_gzswl_tw     #參數分頁"
      DISPLAY "r.r azzp110 import_fr_gzsxl_tw     #參數分項"
      DISPLAY "r.r azzp110 import_fr_gzszl_tw     #參數名稱"
      DISPLAY "r.r azzp110 import_fr_gzwel_tw     #選單名稱"
      DISPLAY "r.r azzp110 import_fr_gzcal_tw     #系統分類碼SCC"
      DISPLAY "r.r azzp110 import_fr_gzcbl_tw     #系統分類值檔"
      DISPLAY "r.r azzp110 import_fr_gzgdl_tw     #報表樣板說明多語言檔(GR+XtraGrid)"
      DISPLAY "r.r azzp110 import_fr_gzge_tw      #報表樣板多語言紀錄檔(GR+XtraGrid)"
      DISPLAY "r.r azzp110 translate_gzoz_tw2cn   #從正體中文翻成簡體"
      DISPLAY "r.r azzp110 import_fr_dzcal_tw     #開窗資料表多語言檔(dzcal_t)"
      DISPLAY "r.r azzp110 import_fr_dzcdl_tw     #校驗帶值設計表多語言檔(dzcdl_t)"
      DISPLAY "r.r azzp110 import_fr_dzcbl_tw     #開窗設計參數設計表多語言檔(dzcbl_t)"
      DISPLAY "r.r azzp110 import_fr_dzcel_tw     #校驗帶值參數設計表多語言檔(dzcel_t)"
      DISPLAY "r.r azzp110 import_fr_gzdel_tw     #子程式及應用元件基本資料表多語言檔(gzdel_t)"
      DISPLAY "r.r azzp110 import_fr_gzhal_tw     #GWC佈景名稱多語言檔(gzhal_t)"
      DISPLAY "r.r azzp110 import_fr_gzial_tw     #自定義查詢單頭多語言檔(gzial_t)"
      DISPLAY "r.r azzp110 import_fr_gzidl_tw     #自定義查詢-QBE欄位明細檔多語言檔(gzidl_t)"
      DISPLAY "r.r azzp110 import_fr_gzjal_tw     #服務名稱多語言記錄表(gzjal_t)"
      DISPLAY "r.r azzp110 import_fr_gztdl_tw     #欄位屬性定義檔多語言檔(gztdl_t)"
      DISPLAY "r.r azzp110 import_fr_gztel_tw     #模組流程說明多語言檔(gztel_t)"
      DISPLAY "r.r azzp110 import_fr_gzzol_tw     #模組編號多語言記錄表(gzzol_t)"
      DISPLAY "r.r azzp110 import_fr_gzzf_tw      #作業級畫面元件翻譯代換表(gzzf_t)" 
      DISPLAY "r.r azzp110 import_fr_gzac_tw      #應用分類碼ACC"
      DISPLAY "r.r azzp110 import_fr_wscal_tw     #ETL Job設定多語言檔(wscal_t)"
      DISPLAY "r.r azzp110 import_fr_wsebl_tw     #中間庫SQL記錄表多語言檔(wsebl_t)"
      DISPLAY "r.r azzp110 import_fr_wsecl_tw     #整合產品資料表多語言檔(wsecl_t)"
      DISPLAY "r.r azzp110 import_fr_gzgjl_tw     #表頭說明多語言檔(gzgjl_t)"
      DISPLAY "r.r azzp110 import_fr_gzahl_tw     #單據程式列印的報表元件說明檔(gzahl_t)"
      DISPLAY "r.r azzp110 import_fr_gzgp_tw      #報表簽核關卡設定檔(gzgp_t)"
      DISPLAY "r.r azzp110 import_fr_rpdel_tw     #APP功能基本資料檔多語言檔(rpdel_t)"
      DISPLAY "r.r azzp110 import_fr_rpzzl_tw     #APP基本資料檔多語言檔(rpzzl_t)"
      DISPLAY "r.r azzp110 chk_dzeal_twcn         #檢查 dzeal 簡繁互用"
      DISPLAY "r.r azzp110 chk_dzebl_twcn         #檢查 dzebl 簡繁互用"
      DISPLAY "r.r azzp110 chk_gzzal_twcn         #檢查 gzzal 簡繁互用"
      DISPLAY "r.r azzp110 chk_gzzd_twcn          #檢查 gzzd 簡繁互用"
      DISPLAY "r.r azzp110 chk_gzdfl_twcn         #檢查 gzdfl 簡繁互用"
      DISPLAY "r.r azzp110 chk_gzzq_twcn          #檢查 gzzq 簡繁互用"
      DISPLAY "r.r azzp110 chk_gzswl_twcn         #檢查 gzswl 簡繁互用"
      DISPLAY "r.r azzp110 chk_gzsxl_twcn         #檢查 gzsxl 簡繁互用"
      DISPLAY "r.r azzp110 chk_gzszl_twcn         #檢查 gzszl 簡繁互用"
      DISPLAY "r.r azzp110 chk_gzwel_twcn         #檢查 gzszl 簡繁互用"
      DISPLAY "r.r azzp110 chk_gzcal_twcn         #檢查 gzcal 簡繁互用"
      DISPLAY "r.r azzp110 chk_gzcbl_twcn         #檢查 gzcbl 簡繁互用"
      DISPLAY "r.r azzp110 chk_gzgdl_twcn         #檢查 gzgdl 簡繁互用"
      DISPLAY "r.r azzp110 chk_gzge_twcn          #檢查 gzge 簡繁互用"
      DISPLAY "r.r azzp110 chk_dzcal_twcn         #檢查 dzcal 簡繁互用"
      DISPLAY "r.r azzp110 chk_dzcdl_twcn         #檢查 dzcdl 簡繁互用"
      DISPLAY "r.r azzp110 chk_dzcbl_twcn         #檢查 dzcbl 簡繁互用"
      DISPLAY "r.r azzp110 chk_dzcel_twcn         #檢查 dzcel 簡繁互用"
      DISPLAY "r.r azzp110 chk_gzdel_twcn         #檢查 gzdel 簡繁互用"
      DISPLAY "r.r azzp110 chk_gzhal_twcn         #檢查 gzhal 簡繁互用"
      DISPLAY "r.r azzp110 chk_gzial_twcn         #檢查 gzial 簡繁互用"
      DISPLAY "r.r azzp110 chk_gzidl_twcn         #檢查 gzidl 簡繁互用"
      DISPLAY "r.r azzp110 chk_gzjal_twcn         #檢查 gzjal 簡繁互用"
      DISPLAY "r.r azzp110 chk_gztdl_twcn         #檢查 gztdl 簡繁互用"
      DISPLAY "r.r azzp110 chk_gztel_twcn         #檢查 gztel 簡繁互用"
      DISPLAY "r.r azzp110 chk_gzzol_twcn         #檢查 gzzol 簡繁互用"
      DISPLAY "r.r azzp110 chk_gzzf_twcn          #檢查 gzzf 簡繁互用"
      DISPLAY "r.r azzp110 chk_wscal_twcn         #檢查 wscal 簡繁互用"
      DISPLAY "r.r azzp110 chk_wsebl_twcn         #檢查 wsebl 簡繁互用"
      DISPLAY "r.r azzp110 chk_wsecl_twcn         #檢查 wsecl 簡繁互用"
      DISPLAY "r.r azzp110 chk_gzgjl_twcn         #檢查 gzgjl 簡繁互用"
      DISPLAY "r.r azzp110 chk_gzahl_twcn         #檢查 gzahl 簡繁互用"
      DISPLAY "r.r azzp110 chk_gzgp_twcn          #檢查 gzgp 簡繁互用"
      DISPLAY "r.r azzp110 chk_rpdel_twcn         #檢查 rpdel 簡繁互用"
      DISPLAY "r.r azzp110 chk_rpzzl_twcn         #檢查 rpzzl 簡繁互用"
      DISPLAY "r.r azzp110 exp_dzeal              #匯出 dzeal 所有語言除了zh_TW"
      DISPLAY "r.r azzp110 exp_dzebl              #匯出 dzebl 所有語言除了zh_TW"
      DISPLAY "r.r azzp110 exp_gzzal              #匯出 gzzal 所有語言除了zh_TW"
      DISPLAY "r.r azzp110 exp_gzzd               #匯出 gzzd 所有語言除了zh_TW "
      DISPLAY "r.r azzp110 exp_gzdfl              #匯出 gzdfl 所有語言除了zh_TW"
      DISPLAY "r.r azzp110 exp_gzzq               #匯出 gzzq 所有語言除了zh_TW"
      DISPLAY "r.r azzp110 exp_gzswl              #匯出 gzswl 所有語言除了zh_TW"
      DISPLAY "r.r azzp110 exp_gzsxl              #匯出 gzsxl 所有語言除了zh_TW"
      DISPLAY "r.r azzp110 exp_gzszl              #匯出 gzszl 所有語言除了zh_TW"
      DISPLAY "r.r azzp110 exp_gzwel              #匯出 gzwel 所有語言除了zh_TW"
      DISPLAY "r.r azzp110 exp_gzcal              #匯出 gzcal 所有語言除了zh_TW"
      DISPLAY "r.r azzp110 exp_gzcbl              #匯出 gzcbl 所有語言除了zh_TW"
      DISPLAY "r.r azzp110 exp_gzgdl              #匯出 gzgdl 所有語言除了zh_TW"
      DISPLAY "r.r azzp110 exp_gzge               #匯出 gzge 所有語言除了zh_TW"
      DISPLAY "r.r azzp110 exp_dzcal              #匯出 dzcal 所有語言除了zh_TW "
      DISPLAY "r.r azzp110 exp_dzcdl              #匯出 dzcdl 所有語言除了zh_TW "
      DISPLAY "r.r azzp110 exp_dzcbl              #匯出 dzcbl 所有語言除了zh_TW "
      DISPLAY "r.r azzp110 exp_dzcel              #匯出 dzcel 所有語言除了zh_TW "
      DISPLAY "r.r azzp110 exp_gzdel              #匯出 gzdel 所有語言除了zh_TW "
      DISPLAY "r.r azzp110 exp_gzhal              #匯出 gzhal 所有語言除了zh_TW "
      DISPLAY "r.r azzp110 exp_gzial              #匯出 gzial 所有語言除了zh_TW "
      DISPLAY "r.r azzp110 exp_gzidl              #匯出 gzidl 所有語言除了zh_TW "
      DISPLAY "r.r azzp110 exp_gzjal              #匯出 gzjal 所有語言除了zh_TW "
      DISPLAY "r.r azzp110 exp_gztdl              #匯出 gztdl 所有語言除了zh_TW "
      DISPLAY "r.r azzp110 exp_gztel              #匯出 gztel 所有語言除了zh_TW "
      DISPLAY "r.r azzp110 exp_gzzol              #匯出 gzzol 所有語言除了zh_TW "
      DISPLAY "r.r azzp110 exp_gzzf               #匯出 gzzf 所有語言除了zh_TW "
      DISPLAY "r.r azzp110 exp_wscal              #匯出 wscal 所有語言除了zh_TW "
      DISPLAY "r.r azzp110 exp_wsebl              #匯出 wsebl 所有語言除了zh_TW "
      DISPLAY "r.r azzp110 exp_wsecl              #匯出 wsecl 所有語言除了zh_TW "
      DISPLAY "r.r azzp110 exp_gzgjl              #匯出 gzgjl 所有語言除了zh_TW "
      DISPLAY "r.r azzp110 exp_gzahl              #匯出 gzahl 所有語言除了zh_TW "
      DISPLAY "r.r azzp110 exp_gzgp               #匯出 gzgp 所有語言除了zh_TW "
      DISPLAY "r.r azzp110 exp_rpdel              #匯出 rpdel 所有語言除了zh_TW "
      DISPLAY "r.r azzp110 exp_rpzzl              #匯出 rpzzl 所有語言除了zh_TW "
      DISPLAY "r.r azzp110 chk_gzoz_twcn          #檢查 gzoz 簡繁互用"
END FUNCTION

################################################################################
# Descriptions...: 新增過單資訊
# Memo...........:
# Usage..........: CALL azzp110_insert_dzld(p_dzld003,p_dzld005,p_dzld006,p_dzld007)
#                  RETURNING r_success
# Input parameter: p_dzld003      作業代號
#                : p_dzld005      維護作業
#                : p_dzld006      條件式一
#                : p_dzld007      條件式二
# Return code....: r_success      是否成功
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_insert_dzld(p_dzld003,p_dzld005,p_dzld006,p_dzld007)
   DEFINE p_dzld003    LIKE dzld_t.dzld003
   DEFINE p_dzld005    LIKE dzld_t.dzld005
   DEFINE p_dzld006    LIKE dzld_t.dzld006
   DEFINE p_dzld007    LIKE dzld_t.dzld007
   DEFINE r_success    LIKE type_t.num5
   DEFINE l_sql        STRING
   DEFINE l_dzld001    LIKE dzld_t.dzld001   #GUID
   DEFINE l_dzld002    LIKE type_t.num5      #序號
   DEFINE l_dzld003    LIKE dzld_t.dzld003   #作業代號
   DEFINE l_dzld004    LIKE dzld_t.dzld004   #匯入動作
   DEFINE l_dzld005    LIKE dzld_t.dzld005   #維護作業
   DEFINE l_dzld006    LIKE dzld_t.dzld006   #條件式1
   DEFINE l_dzld007    LIKE dzld_t.dzld007   #條件式2
   DEFINE l_dzld008    LIKE dzld_t.dzld008   #匯出狀態
   DEFINE l_dzld009    LIKE dzld_t.dzld009   #匯入狀態
   DEFINE l_dzld010    LIKE dzld_t.dzld010   #清單資料產生方式
   DEFINE l_dzld011    LIKE dzld_t.dzld011   #需求單號
   DEFINE l_dzld012    LIKE dzld_t.dzld012   #產品代號
   DEFINE l_dzld013    LIKE dzld_t.dzld013   #產品版本
   DEFINE l_dzld014    LIKE dzld_t.dzld014   #作業項次
   DEFINE l_dzld015    LIKE dzld_t.dzld015   #過單項目(m:單頭主項; d:單身子項)
   DEFINE l_cnt        LIKE type_t.num10
   DEFINE lc_msg       STRING
   
   
   WHENEVER ERROR CONTINUE

   LET r_success = TRUE
   
   #確認該需求單是否已有GUID
   LET l_dzld001 = ""
   SELECT DISTINCT dzld001 INTO l_dzld001 FROM dzld_t
    WHERE dzld011 = g_param.docno AND dzld014 = g_param.seq
   
   IF cl_null(l_dzld001) THEN
      #若是dzld_t沒找到，再找dzlf_t與dzlt_t是否有資料
      SELECT DISTINCT dzlf001 INTO l_dzld001 FROM dzlf_t
       WHERE dzlf008 = g_param.docno AND dzlf011 = g_param.seq
       
      IF cl_null(l_dzld001) THEN
         SELECT DISTINCT dzlt001 INTO l_dzld001 FROM dzlt_t
          WHERE dzlt011 = g_param.docno AND dzlt014 = g_param.seq
          
         IF cl_null(l_dzld001) THEN
            #若是3個table中都找不到，就產生一組新的GUID
            LET l_dzld001 = security.RandomGenerator.CreateUUIDString()
         END IF
      END IF
   END IF

   #取項次
   LET l_dzld002 = 0
   SELECT MAX(TO_NUMBER(dzld002))+1 INTO l_dzld002 FROM dzld_t
    WHERE dzld011 = g_param.docno AND dzld014 = g_param.seq
   
   IF cl_null(l_dzld002) OR l_dzld002 = 0 THEN
      LET l_dzld002 = 1
   END IF
   
   LET l_dzld003 = p_dzld003
   LET l_dzld004 = '1'
   LET l_dzld005 = p_dzld005
   LET l_dzld006 = p_dzld006
   LET l_dzld007 = p_dzld007
   LET l_dzld008 = '0'   #建立
   LET l_dzld009 = '0'   #建立
   LET l_dzld010 = '0'   #手動
   LET l_dzld011 = g_param.docno
   LET l_dzld012 = FGL_GETENV("ERPID")     #產品代號
   LET l_dzld013 = FGL_GETENV("ERPVER")    #產品版本
   LET l_dzld014 = g_param.seq
   IF cl_null(l_dzld007) THEN
      LET l_dzld015 = 'm'
   ELSE
      LET l_dzld015 = 'd'
   END IF
   
   LET l_cnt = 0
   LET l_sql = "SELECT COUNT(1) FROM dzld_t ",
               " WHERE dzld001 = '",l_dzld001,"'",
                 " AND dzld005 = '",l_dzld005,"'",
                 " AND dzld006 = '",l_dzld006,"'",
                 " AND COALESCE(dzld007,' ') = '",l_dzld007,"'"

   PREPARE azzp110_count_dzld_pre FROM l_sql
   EXECUTE azzp110_count_dzld_pre INTO l_cnt
   IF l_cnt = 0 THEN
      LET l_sql = "INSERT INTO dzld_t(dzld001, dzld002, dzld003, dzld004, dzld005,",
                         " dzld006, dzld007, dzld008, dzld009, dzld010,",
                         " dzld011, dzld012, dzld013, dzld014, dzld015)",
           " VALUES(",l_dzld001,",", l_dzld002,",", l_dzld003,",", l_dzld004,",", l_dzld005,",",
                  l_dzld006,",", l_dzld007,",", l_dzld008,",", l_dzld009,",", l_dzld010,",",
                  l_dzld011,",",l_dzld012,",", l_dzld013,",", l_dzld014,",", l_dzld015,")"
                  
      INSERT INTO dzld_t(dzld001, dzld002, dzld003, dzld004, dzld005,
                         dzld006, dzld007, dzld008, dzld009, dzld010,
                         dzld011, dzld012, dzld013, dzld014, dzld015)
           VALUES(l_dzld001, l_dzld002, l_dzld003, l_dzld004, l_dzld005,
                  l_dzld006, l_dzld007, l_dzld008, l_dzld009, l_dzld010,
                  l_dzld011, l_dzld012, l_dzld013, l_dzld014, l_dzld015)

      IF SQLCA.sqlcode THEN
         LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  填寫過單資訊失敗(",l_dzld003,")... SQCA.SQLCODE:",SQLCA.SQLCODE,
                                                 "  dzld001:",l_dzld001,"  dzld005:",l_dzld005,"  dzld006:",l_dzld006,
                                                 "  INSERT SQL:",l_sql,"</td></tr>"
         DISPLAY lc_msg
         CALL g_gen_ch.writeLine(lc_msg)
         
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  SQLCA.sqlcode
         LET g_errparam.extend = 'dzld_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET r_success = FALSE
         
      END IF
   END IF
   
   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 紀錄log
# Memo...........:
# Usage..........: CALL azzp110_channel()
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_channel()
   DEFINE ls_log_file STRING


   LET g_gen_ch = base.Channel.create()

   LET ls_log_file = os.Path.join(FGL_GETENV("TEMPDIR"),g_param.log_name)

   IF NOT os.Path.exists(ls_log_file) THEN
      CALL g_gen_ch.openFile(ls_log_file, "w")
   ELSE
      CALL g_gen_ch.openFile(ls_log_file, "a")
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 背景作業執行時，確認要執行轉換的table
# Memo...........: 參考azzi110_01作法
# Usage..........: CALL azzp110_checkbox(ps_chk)
#                  RETURNING 回传参数
# Input parameter: ps_chk         Y/N
# Return code....: 
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_checkbox(ps_chk)
   DEFINE ps_chk LIKE type_t.chr1
   

   IF ps_chk = "Y" THEN
      LET g_set_up_m.dzeal_set_up = "Y"
      LET g_set_up_m.dzebl_set_up = "Y"
      LET g_set_up_m.gzzal_set_up = "Y"
      LET g_set_up_m.gzzd_set_up  = "Y"
      LET g_set_up_m.gzdfl_set_up = "Y"
      LET g_set_up_m.gzzq_set_up  = "Y"
      LET g_set_up_m.gzswl_set_up = "Y"
      LET g_set_up_m.gzsxl_set_up = "Y"
      LET g_set_up_m.gzszl_set_up = "Y"
      LET g_set_up_m.gzwel_set_up = "Y"
      LET g_set_up_m.gzcal_set_up = "Y"
      LET g_set_up_m.gzcbl_set_up = "Y"
      LET g_set_up_m.gzgdl_set_up = "Y"
      LET g_set_up_m.gzge_set_up  = "Y"
      LET g_set_up_m.dzcal_set_up = "Y"
      LET g_set_up_m.dzcbl_set_up = "Y"
      LET g_set_up_m.dzcdl_set_up = "Y"
      LET g_set_up_m.dzcel_set_up = "Y"
      LET g_set_up_m.gzdel_set_up = "Y"
      LET g_set_up_m.gzhal_set_up = "Y"
      LET g_set_up_m.gzial_set_up = "Y"
      LET g_set_up_m.gzidl_set_up = "Y"
      LET g_set_up_m.gzjal_set_up = "Y"
      LET g_set_up_m.gztdl_set_up = "Y"
      LET g_set_up_m.gztel_set_up = "Y"
      LET g_set_up_m.gzzol_set_up = "Y"
      LET g_set_up_m.gzzf_set_up  = "Y"
      LET g_set_up_m.wscal_set_up = "Y"
      LET g_set_up_m.wsebl_set_up = "Y"
      LET g_set_up_m.wsecl_set_up = "Y"
      LET g_set_up_m.gzgjl_set_up = "Y"
      LET g_set_up_m.gzahl_set_up = "Y"
      LET g_set_up_m.gzgp_set_up  = "Y"
      LET g_set_up_m.rpdel_set_up = "Y"
      LET g_set_up_m.rpzzl_set_up = "Y"
   ELSE
      IF g_param.table_name.getIndexOf("dzeal",1) > 0 THEN
         LET g_set_up_m.dzeal_set_up = "Y"
      END IF
      IF g_param.table_name.getIndexOf("dzebl",1) > 0 THEN
         LET g_set_up_m.dzebl_set_up = "Y"
      END IF
      IF g_param.table_name.getIndexOf("gzzal",1) > 0 THEN
         LET g_set_up_m.gzzal_set_up = "Y"
      END IF
      IF g_param.table_name.getIndexOf("gzzd",1) > 0 THEN
         LET g_set_up_m.gzzd_set_up  = "Y"
      END IF
      IF g_param.table_name.getIndexOf("gzdfl",1) > 0 THEN
         LET g_set_up_m.gzdfl_set_up = "Y"
      END IF
      IF g_param.table_name.getIndexOf("gzzq",1) > 0 THEN
         LET g_set_up_m.gzzq_set_up  = "Y"
      END IF
      IF g_param.table_name.getIndexOf("gzswl",1) > 0 THEN
         LET g_set_up_m.gzswl_set_up = "Y"
      END IF
      IF g_param.table_name.getIndexOf("gzsxl",1) > 0 THEN
         LET g_set_up_m.gzsxl_set_up = "Y"
      END IF
      IF g_param.table_name.getIndexOf("gzsz",1) > 0 THEN
         LET g_set_up_m.gzszl_set_up = "Y"
      END IF
      IF g_param.table_name.getIndexOf("gzwel",1) > 0 THEN
         LET g_set_up_m.gzwel_set_up = "Y"
      END IF
      IF g_param.table_name.getIndexOf("gzcal",1) > 0 THEN
         LET g_set_up_m.gzcal_set_up = "Y"
      END IF
      IF g_param.table_name.getIndexOf("gzcbl",1) > 0 THEN
         LET g_set_up_m.gzcbl_set_up = "Y"
      END IF
      IF g_param.table_name.getIndexOf("gzgdl",1) > 0 THEN
         LET g_set_up_m.gzgdl_set_up = "Y"
      END IF
      IF g_param.table_name.getIndexOf("gzge",1) > 0 THEN
         LET g_set_up_m.gzge_set_up  = "Y"
      END IF
      IF g_param.table_name.getIndexOf("dzcal",1) > 0 THEN
         LET g_set_up_m.dzcal_set_up = "Y"
      END IF
      IF g_param.table_name.getIndexOf("dzcbl",1) > 0 THEN
         LET g_set_up_m.dzcbl_set_up = "Y"
      END IF
      IF g_param.table_name.getIndexOf("dzcdl",1) > 0 THEN
         LET g_set_up_m.dzcdl_set_up = "Y"
      END IF
      IF g_param.table_name.getIndexOf("dzcel",1) > 0 THEN
         LET g_set_up_m.dzcel_set_up = "Y"
      END IF
      IF g_param.table_name.getIndexOf("gzdel",1) > 0 THEN
         LET g_set_up_m.gzdel_set_up = "Y"
      END IF
      IF g_param.table_name.getIndexOf("gzhal",1) > 0 THEN
         LET g_set_up_m.gzhal_set_up = "Y"
      END IF
      IF g_param.table_name.getIndexOf("gzial",1) > 0 THEN
         LET g_set_up_m.gzial_set_up = "Y"
      END IF
      IF g_param.table_name.getIndexOf("gzidl",1) > 0 THEN
         LET g_set_up_m.gzidl_set_up = "Y"
      END IF
      IF g_param.table_name.getIndexOf("gzjal",1) > 0 THEN
         LET g_set_up_m.gzjal_set_up = "Y"
      END IF
      IF g_param.table_name.getIndexOf("gztdl",1) > 0 THEN
         LET g_set_up_m.gztdl_set_up = "Y"
      END IF
      IF g_param.table_name.getIndexOf("gztel",1) > 0 THEN
         LET g_set_up_m.gztel_set_up = "Y"
      END IF
      IF g_param.table_name.getIndexOf("gzzol",1) > 0 THEN
         LET g_set_up_m.gzzol_set_up = "Y"
      END IF
      IF g_param.table_name.getIndexOf("gzzf",1) > 0 THEN
         LET g_set_up_m.gzzf_set_up = "Y"
      END IF
      IF g_param.table_name.getIndexOf("wscal",1) > 0 THEN
         LET g_set_up_m.wscal_set_up = "Y"
      END IF
      IF g_param.table_name.getIndexOf("wsebl",1) > 0 THEN
         LET g_set_up_m.wsebl_set_up = "Y"
      END IF
      IF g_param.table_name.getIndexOf("wsecl",1) > 0 THEN
         LET g_set_up_m.wsecl_set_up = "Y"
      END IF
      IF g_param.table_name.getIndexOf("gzgjl",1) > 0 THEN
         LET g_set_up_m.gzgjl_set_up = "Y"
      END IF
      IF g_param.table_name.getIndexOf("gzahl",1) > 0 THEN
         LET g_set_up_m.gzahl_set_up = "Y"
      END IF
      IF g_param.table_name.getIndexOf("gzgp",1) > 0 THEN
         LET g_set_up_m.gzgp_set_up = "Y"
      END IF
      IF g_param.table_name.getIndexOf("rpdel",1) > 0 THEN
         LET g_set_up_m.rpdel_set_up = "Y"
      END IF
      IF g_param.table_name.getIndexOf("rpzzl",1) > 0 THEN
         LET g_set_up_m.rpzzl_set_up = "Y"
      END IF
   END IF
END FUNCTION

################################################################################
# Descriptions...: 把要執行的項目組合起來
# Memo...........: 參考azzi110_01 寫法
# Usage..........: CALL azzp110_chk_item()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_chk_item()
   CALL g_imp_table_name.clear()
   CALL g_exp_table_name.clear()
   CALL g_arr_table_name.clear()


   IF g_set_up_m.dzeal_set_up = 'Y' THEN
      IF g_param.action_type = "imp" THEN
         LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_dzeal_tw"
      END IF      
      IF g_param.action_type = "exp" THEN
         LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_dzeal"
      END IF
      IF g_param.action_type = "chk" THEN
         LET g_arr_table_name[g_arr_table_name.getLength()+1] = "chk_dzeal_twcn"
      END IF
   END IF
   
   IF g_set_up_m.dzebl_set_up = 'Y' THEN
      IF g_param.action_type = "imp" THEN
         LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_dzebl_tw"
      END IF      
      IF g_param.action_type = "exp" THEN
         LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_dzebl"
      END IF
      IF g_param.action_type = "chk" THEN
         LET g_arr_table_name[g_arr_table_name.getLength()+1] = "chk_dzebl_twcn"
      END IF
   END IF
   
   IF g_set_up_m.gzzal_set_up = 'Y' THEN
      IF g_param.action_type = "imp" THEN
         LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_gzzal_tw"
      END IF      
      IF g_param.action_type = "exp" THEN
         LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_gzzal"
      END IF
      IF g_param.action_type = "chk" THEN
         LET g_arr_table_name[g_arr_table_name.getLength()+1] = "chk_gzzal_twcn"
      END IF
   END IF
   
   IF g_set_up_m.gzzd_set_up = 'Y' THEN
      IF g_param.action_type = "imp" THEN
         LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_gzzd_tw"
      END IF      
      IF g_param.action_type = "exp" THEN
         LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_gzzd"
      END IF
      IF g_param.action_type = "chk" THEN
         LET g_arr_table_name[g_arr_table_name.getLength()+1] = "chk_gzzd_twcn"
      END IF
   END IF
   
   IF g_set_up_m.gzdfl_set_up = 'Y' THEN
      IF g_param.action_type = "imp" THEN
         LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_gzdfl_tw"
      END IF      
      IF g_param.action_type = "exp" THEN
         LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_gzdfl"
      END IF
      IF g_param.action_type = "chk" THEN
         LET g_arr_table_name[g_arr_table_name.getLength()+1] = "chk_gzdfl_twcn"
      END IF
   END IF
   
   IF g_set_up_m.gzzq_set_up = 'Y' THEN
      IF g_param.action_type = "imp" THEN
         LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_gzzq_tw"
      END IF      
      IF g_param.action_type = "exp" THEN
         LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_gzzq"
      END IF
      IF g_param.action_type = "chk" THEN
         LET g_arr_table_name[g_arr_table_name.getLength()+1] = "chk_gzzq_twcn"
      END IF
   END IF
   
   IF g_set_up_m.gzswl_set_up = 'Y' THEN
      IF g_param.action_type = "imp" THEN
         LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_gzswl_tw"
      END IF      
      IF g_param.action_type = "exp" THEN
         LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_gzswl"
      END IF
      IF g_param.action_type = "chk" THEN
         LET g_arr_table_name[g_arr_table_name.getLength()+1] = "chk_gzswl_twcn"
      END IF
   END IF
   
   IF g_set_up_m.gzsxl_set_up = 'Y' THEN
      IF g_param.action_type = "imp" THEN
         LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_gzsxl_tw"
      END IF      
      IF g_param.action_type = "exp" THEN
         LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_gzsxl"
      END IF
      IF g_param.action_type = "chk" THEN
         LET g_arr_table_name[g_arr_table_name.getLength()+1] = "chk_gzsxl_twcn"
      END IF
   END IF
   
   IF g_set_up_m.gzszl_set_up = 'Y' THEN
      IF g_param.action_type = "imp" THEN
         LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_gzszl_tw"
      END IF      
      IF g_param.action_type = "exp" THEN
         LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_gzszl"
      END IF
      IF g_param.action_type = "chk" THEN
         LET g_arr_table_name[g_arr_table_name.getLength()+1] = "chk_gzszl_twcn"
      END IF
   END IF
   
   IF g_set_up_m.gzwel_set_up = 'Y' THEN
      IF g_param.action_type = "imp" THEN
         LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_gzwel_tw"
      END IF      
      IF g_param.action_type = "exp" THEN
         LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_gzwel"
      END IF
      IF g_param.action_type = "chk" THEN
         LET g_arr_table_name[g_arr_table_name.getLength()+1] = "chk_gzwel_twcn"
      END IF
   END IF
   
   IF g_set_up_m.gzcal_set_up = 'Y' THEN
      IF g_param.action_type = "imp" THEN
         LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_gzcal_tw"
      END IF      
      IF g_param.action_type = "exp" THEN
         LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_gzcal"
      END IF
      IF g_param.action_type = "chk" THEN
         LET g_arr_table_name[g_arr_table_name.getLength()+1] = "chk_gzcal_twcn"
      END IF
   END IF
   
   IF g_set_up_m.gzcbl_set_up = 'Y' THEN
      IF g_param.action_type = "imp" THEN
         LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_gzcbl_tw"
      END IF      
      IF g_param.action_type = "exp" THEN
         LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_gzcbl"
      END IF
      IF g_param.action_type = "chk" THEN
         LET g_arr_table_name[g_arr_table_name.getLength()+1] = "chk_gzcbl_twcn"
      END IF
   END IF
   
   IF g_set_up_m.gzgdl_set_up = 'Y' THEN
      IF g_param.action_type = "imp" THEN
         LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_gzgdl_tw"
      END IF      
      IF g_param.action_type = "exp" THEN
         LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_gzgdl"
      END IF
      IF g_param.action_type = "chk" THEN
         LET g_arr_table_name[g_arr_table_name.getLength()+1] = "chk_gzgdl_twcn"
      END IF
   END IF
   
   IF g_set_up_m.gzge_set_up = 'Y' THEN
      IF g_param.action_type = "imp" THEN
         LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_gzge_tw"
      END IF      
      IF g_param.action_type = "exp" THEN
         LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_gzge"
      END IF
      IF g_param.action_type = "chk" THEN
         LET g_arr_table_name[g_arr_table_name.getLength()+1] = "chk_gzge_twcn"
      END IF
   END IF
   
   IF g_set_up_m.dzcal_set_up = 'Y' THEN
      IF g_param.action_type = "imp" THEN
         LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_dzcal_tw"
      END IF      
      IF g_param.action_type = "exp" THEN
         LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_dzcal"
      END IF
      IF g_param.action_type = "chk" THEN
         LET g_arr_table_name[g_arr_table_name.getLength()+1] = "chk_dzcal_twcn"
      END IF
   END IF
   
   IF g_set_up_m.dzcbl_set_up = 'Y' THEN
      IF g_param.action_type = "imp" THEN
         LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_dzcbl_tw"
      END IF      
      IF g_param.action_type = "exp" THEN
         LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_dzcbl"
      END IF
      IF g_param.action_type = "chk" THEN
         LET g_arr_table_name[g_arr_table_name.getLength()+1] = "chk_dzcbl_twcn"
      END IF
   END IF
   
   IF g_set_up_m.dzcdl_set_up = 'Y' THEN
      IF g_param.action_type = "imp" THEN
         LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_dzcdl_tw"
      END IF      
      IF g_param.action_type = "exp" THEN
         LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_dzcdl"
      END IF
      IF g_param.action_type = "chk" THEN
         LET g_arr_table_name[g_arr_table_name.getLength()+1] = "chk_dzcdl_twcn"
      END IF
   END IF
   
   IF g_set_up_m.dzcel_set_up = 'Y' THEN
      IF g_param.action_type = "imp" THEN
         LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_dzcel_tw"
      END IF      
      IF g_param.action_type = "exp" THEN
         LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_dzcel"
      END IF
      IF g_param.action_type = "chk" THEN
         LET g_arr_table_name[g_arr_table_name.getLength()+1] = "chk_dzcel_twcn"
      END IF
   END IF
   
   IF g_set_up_m.gzdel_set_up = 'Y' THEN
      IF g_param.action_type = "imp" THEN
         LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_gzdel_tw"
      END IF      
      IF g_param.action_type = "exp" THEN
         LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_gzdel"
      END IF
      IF g_param.action_type = "chk" THEN
         LET g_arr_table_name[g_arr_table_name.getLength()+1] = "chk_gzdel_twcn"
      END IF
   END IF
   
   IF g_set_up_m.gzhal_set_up = 'Y' THEN
      IF g_param.action_type = "imp" THEN
         LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_gzhal_tw"
      END IF      
      IF g_param.action_type = "exp" THEN
         LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_gzhal"
      END IF
      IF g_param.action_type = "chk" THEN
         LET g_arr_table_name[g_arr_table_name.getLength()+1] = "chk_gzhal_twcn"
      END IF
   END IF
   
   IF g_set_up_m.gzial_set_up = 'Y' THEN
      IF g_param.action_type = "imp" THEN
         LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_gzial_tw"
      END IF      
      IF g_param.action_type = "exp" THEN
         LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_gzial"
      END IF
      IF g_param.action_type = "chk" THEN
         LET g_arr_table_name[g_arr_table_name.getLength()+1] = "chk_gzial_twcn"
      END IF
   END IF
   
   IF g_set_up_m.gzidl_set_up = 'Y' THEN
      IF g_param.action_type = "imp" THEN
         LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_gzidl_tw"
      END IF      
      IF g_param.action_type = "exp" THEN
         LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_gzidl"
      END IF
      IF g_param.action_type = "chk" THEN
         LET g_arr_table_name[g_arr_table_name.getLength()+1] = "chk_gzidl_twcn"
      END IF
   END IF
   
   IF g_set_up_m.gzjal_set_up = 'Y' THEN
      IF g_param.action_type = "imp" THEN
         LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_gzjal_tw"
      END IF      
      IF g_param.action_type = "exp" THEN
         LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_gzjal"
      END IF
      IF g_param.action_type = "chk" THEN
         LET g_arr_table_name[g_arr_table_name.getLength()+1] = "chk_gzjal_twcn"
      END IF
   END IF
   
   IF g_set_up_m.gztdl_set_up = 'Y' THEN
      IF g_param.action_type = "imp" THEN
         LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_gztdl_tw"
      END IF      
      IF g_param.action_type = "exp" THEN
         LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_gztdl"
      END IF
      IF g_param.action_type = "chk" THEN
         LET g_arr_table_name[g_arr_table_name.getLength()+1] = "chk_gztdl_twcn"
      END IF
   END IF
   
   IF g_set_up_m.gztel_set_up = 'Y' THEN
      IF g_param.action_type = "imp" THEN
         LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_gztel_tw"
      END IF      
      IF g_param.action_type = "exp" THEN
         LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_gztel"
      END IF
      IF g_param.action_type = "chk" THEN
         LET g_arr_table_name[g_arr_table_name.getLength()+1] = "chk_gztel_twcn"
      END IF
   END IF
   
   IF g_set_up_m.gzzol_set_up = 'Y' THEN
      IF g_param.action_type = "imp" THEN
         LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_gzzol_tw"
      END IF      
      IF g_param.action_type = "exp" THEN
         LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_gzzol"
      END IF
      IF g_param.action_type = "chk" THEN
         LET g_arr_table_name[g_arr_table_name.getLength()+1] = "chk_gzzol_twcn"
      END IF
   END IF
   
   IF g_set_up_m.gzzf_set_up = 'Y' THEN
      IF g_param.action_type = "imp" THEN
         LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_gzzf_tw"
      END IF      
      IF g_param.action_type = "exp" THEN
         LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_gzzf"
      END IF
      IF g_param.action_type = "chk" THEN
         LET g_arr_table_name[g_arr_table_name.getLength()+1] = "chk_gzzf_twcn"
      END IF
   END IF
   
   IF g_set_up_m.wscal_set_up = 'Y' THEN
      IF g_param.action_type = "imp" THEN
         LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_wscal_tw"
      END IF      
      IF g_param.action_type = "exp" THEN
         LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_wscal"
      END IF
      IF g_param.action_type = "chk" THEN
         LET g_arr_table_name[g_arr_table_name.getLength()+1] = "chk_wscal_twcn"
      END IF
   END IF
   
   IF g_set_up_m.wsebl_set_up = 'Y' THEN
      IF g_param.action_type = "imp" THEN
         LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_wsebl_tw"
      END IF      
      IF g_param.action_type = "exp" THEN
         LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_wsebl"
      END IF
      IF g_param.action_type = "chk" THEN
         LET g_arr_table_name[g_arr_table_name.getLength()+1] = "chk_wsebl_twcn"
      END IF
   END IF
   
   IF g_set_up_m.wsecl_set_up = 'Y' THEN
      IF g_param.action_type = "imp" THEN
         LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_wsecl_tw"
      END IF      
      IF g_param.action_type = "exp" THEN
         LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_wsecl"
      END IF
      IF g_param.action_type = "chk" THEN
         LET g_arr_table_name[g_arr_table_name.getLength()+1] = "chk_wsecl_twcn"
      END IF
   END IF
   
   IF g_set_up_m.gzgjl_set_up = 'Y' THEN
      IF g_param.action_type = "imp" THEN
         LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_gzgjl_tw"
      END IF      
      IF g_param.action_type = "exp" THEN
         LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_gzgjl"
      END IF
      IF g_param.action_type = "chk" THEN
         LET g_arr_table_name[g_arr_table_name.getLength()+1] = "chk_gzgjl_twcn"
      END IF
   END IF
   
   IF g_set_up_m.gzahl_set_up = 'Y' THEN
      IF g_param.action_type = "imp" THEN
         LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_gzahl_tw"
      END IF      
      IF g_param.action_type = "exp" THEN
         LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_gzahl"
      END IF
      IF g_param.action_type = "chk" THEN
         LET g_arr_table_name[g_arr_table_name.getLength()+1] = "chk_gzahl_twcn"
      END IF
   END IF
   
   IF g_set_up_m.gzgp_set_up = 'Y' THEN
      IF g_param.action_type = "imp" THEN
         LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_gzgp_tw"
      END IF      
      IF g_param.action_type = "exp" THEN
         LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_gzgp"
      END IF
      IF g_param.action_type = "chk" THEN
         LET g_arr_table_name[g_arr_table_name.getLength()+1] = "chk_gzgp_twcn"
      END IF
   END IF
   
   IF g_set_up_m.rpdel_set_up = 'Y' THEN
      IF g_param.action_type = "imp" THEN
         LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_rpdel_tw"
      END IF      
      IF g_param.action_type = "exp" THEN
         LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_rpdel"
      END IF
      IF g_param.action_type = "chk" THEN
         LET g_arr_table_name[g_arr_table_name.getLength()+1] = "chk_rpdel_twcn"
      END IF
   END IF
   
   IF g_set_up_m.rpzzl_set_up = 'Y' THEN
      IF g_param.action_type = "imp" THEN
         LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_rpzzl_tw"
      END IF      
      IF g_param.action_type = "exp" THEN
         LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_rpzzl"
      END IF
      IF g_param.action_type = "chk" THEN
         LET g_arr_table_name[g_arr_table_name.getLength()+1] = "chk_rpzzl_twcn"
      END IF
   END IF
   
   #做繁簡互轉
   IF g_param.action_type = "imp" THEN
      LET g_imp_table_name[g_imp_table_name.getLength()+1] = "translate_gzoz_tw2cn"
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 確認此次要執行的動作及執行的多語言table
# Memo...........:
# Usage..........: CALL azzp110_ice_langtable(lc_action)
#                  RETURNING 回传参数
# Input parameter: lc_action      執行動作及多語言table名稱
# Return code....: 
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_ice_langtable(lc_action)
   DEFINE lc_action     STRING
   

   CASE
      WHEN lc_action = "import_fr_dzeal_tw"    #表格名稱
         CALL azzp110_ins_dzeal_zhtw()
 
      WHEN lc_action = "import_fr_dzebl_tw"    #欄位名稱
         CALL azzp110_ins_dzebl_zhtw()
 
      WHEN lc_action = "import_fr_gzzal_tw"    #程式/作業名稱
         CALL azzp110_ins_gzzal_zhtw()
 
      WHEN lc_action = "import_fr_gzzd_tw"     #畫面元件
         CALL azzp110_ins_gzzd_zhtw()
 
      WHEN lc_action = "import_fr_gzdfl_tw"    #子畫面名稱
         CALL azzp110_ins_gzdfl_zhtw()
 
      WHEN lc_action = "import_fr_gzzq_tw"     #功能名稱
         CALL azzp110_ins_gzzq_zhtw()
 
      WHEN lc_action = "import_fr_gzswl_tw"    #參數分頁
         CALL azzp110_ins_gzswl_zhtw()
 
      WHEN lc_action = "import_fr_gzsxl_tw"    #參數分項
         CALL azzp110_ins_gzsxl_zhtw()
 
      WHEN lc_action = "import_fr_gzszl_tw"    #參數名稱
         CALL azzp110_ins_gzszl_zhtw()
 
      WHEN lc_action = "import_fr_gzwel_tw"    #選單名稱
         CALL azzp110_ins_gzwel_zhtw()

      WHEN lc_action = "import_fr_gzcal_tw"    #系統分類碼
         CALL azzp110_ins_gzcal_zhtw()  

      WHEN lc_action = "import_fr_gzcbl_tw"    #系統分類值檔
         CALL azzp110_ins_gzcbl_zhtw()  
         
      WHEN lc_action = "import_fr_gzgdl_tw"    #報表樣板說明多語言檔(GR+XtraGrid)
         CALL azzp110_ins_gzgdl_zhtw()

      WHEN lc_action = "import_fr_gzge_tw"     #報表樣板多語言紀錄檔(GR+XtraGrid)
         CALL azzp110_ins_gzge_zhtw()
      
      WHEN lc_action = "import_fr_dzcal_tw"    #開窗資料表多語言檔(dzcal_t)
         CALL azzp110_ins_dzcal_zhtw()

      WHEN lc_action = "import_fr_gzac_tw"     #應用分類碼ACC (gzac_t)
         CALL azzp110_ins_gzac_zhtw()
      
      WHEN lc_action = "import_fr_dzcbl_tw"    #dzcbl_t
         CALL azzp110_ins_dzcbl_zhtw()      
         
      WHEN lc_action = "import_fr_dzcdl_tw"    #校驗帶值設計表多語言檔(dzcdl_t)
         CALL azzp110_ins_dzcdl_zhtw()  

      WHEN lc_action = "import_fr_dzcel_tw"    #dzcel_t
         CALL azzp110_ins_dzcel_zhtw() 
         
      WHEN lc_action = "import_fr_gzdel_tw"    #gzdel
         CALL azzp110_ins_gzdel_zhtw()
         
      WHEN lc_action = "import_fr_gzhal_tw"    #gzhal
         CALL azzp110_ins_gzhal_zhtw()
         
      WHEN lc_action = "import_fr_gzial_tw"    #gzial
         CALL azzp110_ins_gzial_zhtw()
         
      WHEN lc_action = "import_fr_gzidl_tw"    #gzidl
         CALL azzp110_ins_gzidl_zhtw()
         
      WHEN lc_action = "import_fr_gzjal_tw"    #gzjal
         CALL azzp110_ins_gzjal_zhtw()
         
      WHEN lc_action = "import_fr_gztdl_tw"    #gztdl
         CALL azzp110_ins_gztdl_zhtw()
         
      WHEN lc_action = "import_fr_gztel_tw"    #gztel
         CALL azzp110_ins_gztel_zhtw()
         
      WHEN lc_action = "import_fr_gzzol_tw"    #gzzol
         CALL azzp110_ins_gzzol_zhtw()
         
      WHEN lc_action = "import_fr_gzzf_tw"     #gzzf
         CALL azzp110_ins_gzzf_zhtw()
      
      WHEN lc_action = "import_fr_wscal_tw"    #wscal
         CALL azzp110_ins_wscal_zhtw()
      
      WHEN lc_action = "import_fr_wsebl_tw"    #wsebl
         CALL azzp110_ins_wsebl_zhtw()
      
      WHEN lc_action = "import_fr_wsecl_tw"    #wsecl
         CALL azzp110_ins_wsecl_zhtw()
      
      WHEN lc_action = "import_fr_gzgjl_tw"    #gzgjl
         CALL azzp110_ins_gzgjl_zhtw()
      
      WHEN lc_action = "import_fr_gzahl_tw"    #gzahl
         CALL azzp110_ins_gzahl_zhtw()
      
      WHEN lc_action = "import_fr_gzgp_tw"     #gzgp
         CALL azzp110_ins_gzgp_zhtw()
      
      WHEN lc_action = "import_fr_rpdel_tw"    #rpdel
         CALL azzp110_ins_rpdel_zhtw()
      
      WHEN lc_action = "import_fr_rpzzl_tw"    #rpzzl
         CALL azzp110_ins_rpzzl_zhtw()
      
      WHEN lc_action = "translate_gzoz_tw2cn"  #從正體中文翻成簡體
         CALL azzp110_upd_gzoz_tw2cn()
 
      WHEN lc_action = "chk_dzeal_twcn"        #檢查 dzeal 簡繁互用
         CALL azzp110_chk_dzeal_twcn()
 
      WHEN lc_action = "chk_dzebl_twcn"        #檢查 dzebl 簡繁互用
         CALL azzp110_chk_dzebl_twcn()
 
      WHEN lc_action = "chk_gzzal_twcn"        #檢查 gzzal 簡繁互用
         CALL azzp110_chk_gzzal_twcn()
 
      WHEN lc_action = "chk_gzzd_twcn"         #檢查 gzzd 簡繁互用
         CALL azzp110_chk_gzzd_twcn()
 
      WHEN lc_action = "chk_gzdfl_twcn"        #檢查 gzdfl 簡繁互用
         CALL azzp110_chk_gzdfl_twcn()   
 
      WHEN lc_action = "chk_gzzq_twcn"         #檢查 gzzq 簡繁互用
         CALL azzp110_chk_gzzq_twcn() 
 
      WHEN lc_action = "chk_gzswl_twcn"        #檢查 gzswl 簡繁互用
         CALL azzp110_chk_gzswl_twcn()
 
      WHEN lc_action = "chk_gzsxl_twcn"        #檢查 gzsxl 簡繁互用
         CALL azzp110_chk_gzsxl_twcn()   
 
      WHEN lc_action = "chk_gzszl_twcn"        #檢查 gzszl 簡繁互用
         CALL azzp110_chk_gzszl_twcn()   
 
      WHEN lc_action = "chk_gzwel_twcn"        #檢查 gzszl 簡繁互用
         CALL azzp110_chk_gzwel_twcn()

      WHEN lc_action = "chk_gzcal_twcn"        #檢查 gzcal 簡繁互用
         CALL azzp110_chk_gzcal_twcn()

      WHEN lc_action = "chk_gzcbl_twcn"        #檢查 gzcbl 簡繁互用
         CALL azzp110_chk_gzcbl_twcn()   
             
      WHEN lc_action = "chk_gzgdl_twcn"        #檢查 gzgdl 簡繁互用
         CALL azzp110_chk_gzgdl_twcn()  

      WHEN lc_action = "chk_gzge_twcn"         #檢查 gzge 簡繁互用
         CALL azzp110_chk_gzge_twcn()    
         
      WHEN lc_action = "chk_dzcal_twcn"        #檢查 dzcal 簡繁互用
         CALL azzp110_chk_dzcal_twcn() 

      WHEN lc_action = "chk_dzcbl_twcn"        #檢查 dzcbl 簡繁互用
         CALL azzp110_chk_dzcbl_twcn() 
  
      WHEN lc_action = "chk_dzcdl_twcn"        #檢查 dzcdl 簡繁互用
         CALL azzp110_chk_dzcdl_twcn()  

      WHEN lc_action = "chk_dzcel_twcn"        #檢查 dzcel 簡繁互用
         CALL azzp110_chk_dzcel_twcn()
         
      WHEN lc_action = "chk_gzdel_twcn"        #檢查 gzdel 簡繁互用
         CALL azzp110_chk_gzdel_twcn()
         
      WHEN lc_action = "chk_gzhal_twcn"        #檢查 gzhal 簡繁互用
         CALL azzp110_chk_gzhal_twcn()
         
      WHEN lc_action = "chk_gzial_twcn"        #檢查 gzial 簡繁互用
         CALL azzp110_chk_gzial_twcn()
         
      WHEN lc_action = "chk_gzidl_twcn"        #檢查 gzidl 簡繁互用
         CALL azzp110_chk_gzidl_twcn()
         
      WHEN lc_action = "chk_gzjal_twcn"        #檢查 gzjal 簡繁互用
         CALL azzp110_chk_gzjal_twcn()
         
      WHEN lc_action = "chk_gztdl_twcn"        #檢查 gztdl 簡繁互用
         CALL azzp110_chk_gztdl_twcn()
         
      WHEN lc_action = "chk_gztel_twcn"        #檢查 gztel 簡繁互用
         CALL azzp110_chk_gztel_twcn()
         
      WHEN lc_action = "chk_gzzol_twcn"        #檢查 gzzol 簡繁互用
         CALL azzp110_chk_gzzol_twcn()
         
      WHEN lc_action = "chk_gzzf_twcn"         #檢查 gzzf 簡繁互用
         CALL azzp110_chk_gzzf_twcn()
      
      WHEN lc_action = "chk_wscal_twcn"        #檢查 wscal 簡繁互用
         CALL azzp110_chk_wscal_twcn()
      
      WHEN lc_action = "chk_wsebl_twcn"        #檢查 wsebl 簡繁互用
         CALL azzp110_chk_wsebl_twcn()
      
      WHEN lc_action = "chk_wsecl_twcn"        #檢查 wsecl 簡繁互用
         CALL azzp110_chk_wsecl_twcn()
      
      WHEN lc_action = "chk_gzgjl_twcn"        #檢查 gzgjl 簡繁互用
         CALL azzp110_chk_gzgjl_twcn()
      
      WHEN lc_action = "chk_gzahl_twcn"        #檢查 gzahl 簡繁互用
         CALL azzp110_chk_gzahl_twcn()
      
      WHEN lc_action = "chk_gzgp_twcn"         #檢查 gzgp 簡繁互用
         CALL azzp110_chk_gzgp_twcn()
      
      WHEN lc_action = "chk_rpdel_twcn"        #檢查 rpdel 簡繁互用
         CALL azzp110_chk_rpdel_twcn()
      
      WHEN lc_action = "chk_rpzzl_twcn"        #檢查 rpzzl 簡繁互用
         CALL azzp110_chk_rpzzl_twcn()
      
      WHEN lc_action = "chk_gzoz_twcn"         #檢查 gzoz 簡繁互用
         CALL azzp110_chk_gzoz_twcn()
      
      WHEN lc_action = "exp_dzeal"             #匯出 dzeal 所有語言除了zh_TW 
         CALL azzp110_exp_dzeal()
 
      WHEN lc_action = "exp_dzebl"             #匯出 dzebl 所有語言除了zh_TW 
         CALL azzp110_exp_dzebl()
         
      WHEN lc_action = "exp_gzzal"             #匯出 gzzal 所有語言除了zh_TW 
         CALL azzp110_exp_gzzal()
 
      WHEN lc_action = "exp_gzzd"              #匯出 gzzd 所有語言除了zh_TW 
         CALL azzp110_exp_gzzd()               #從字典檔匯到gzzd 要注意gzzd_t有標準及客製
 
      WHEN lc_action = "exp_gzdfl"             #匯出 gzdfl 所有語言除了zh_TW 
         CALL azzp110_exp_gzdfl() 
 
      WHEN lc_action = "exp_gzzq"              #匯出 gzzq 所有語言除了zh_TW 
         CALL azzp110_exp_gzzq()               #從字典檔匯到gzzd 要注意gzzd_t有標準及客製
 
      WHEN lc_action = "exp_gzswl"             #匯出 gzswl 所有語言除了zh_TW 
         CALL azzp110_exp_gzswl()
 
      WHEN lc_action = "exp_gzsxl"             #匯出 gzsxl 所有語言除了zh_TW 
         CALL azzp110_exp_gzsxl()  
      
      WHEN lc_action = "exp_gzszl"             #匯出 gzszl 所有語言除了zh_TW 
         CALL azzp110_exp_gzszl() 
 
      WHEN lc_action = "exp_gzwel"             #匯出 gzwel 所有語言除了zh_TW 
         CALL azzp110_exp_gzwel()
         
      WHEN lc_action = "exp_gzcal"             #匯出 gzcal 所有語言除了zh_TW 
         CALL azzp110_exp_gzcal()   

      WHEN lc_action = "exp_gzcbl"             #匯出 gzcbl 所有語言除了zh_TW 
         CALL azzp110_exp_gzcbl()
            
      WHEN lc_action = "exp_gzgdl"             #匯出 gzgdl 所有語言除了zh_TW 
         CALL azzp110_exp_gzgdl() 

      WHEN lc_action = "exp_gzge"              #匯出 gzge 所有語言除了zh_TW 
         CALL azzp110_exp_gzge() 
         
      WHEN lc_action = "exp_dzcal"             #匯出 dzcal 所有語言除了zh_TW 
         CALL azzp110_exp_dzcal() 
         
      WHEN lc_action = "exp_dzcbl"             #匯出 dzcbl 所有語言除了zh_TW 
         CALL azzp110_exp_dzcbl()     

      WHEN lc_action = "exp_dzcdl"             #匯出 dzcdl 所有語言除了zh_TW 
         CALL azzp110_exp_dzcdl()

      WHEN lc_action = "exp_dzcel"             #匯出 dzcel 所有語言除了zh_TW 
         CALL azzp110_exp_dzcel()
         
      WHEN lc_action = "exp_gzdel"             #匯出 gzdel_t 所有語言除了zh_TW 
         CALL azzp110_exp_gzdel()
         
      WHEN lc_action = "exp_gzhal"             #匯出 gzhal_t 所有語言除了zh_TW 
         CALL azzp110_exp_gzhal()
         
      WHEN lc_action = "exp_gzial"             #匯出 gzial_t 所有語言除了zh_TW 
         CALL azzp110_exp_gzial()
         
      WHEN lc_action = "exp_gzidl"             #匯出 gzidl_t 所有語言除了zh_TW 
         CALL azzp110_exp_gzidl()
         
      WHEN lc_action = "exp_gzjal"             #匯出 gzjal_t 所有語言除了zh_TW 
         CALL azzp110_exp_gzjal()
         
      WHEN lc_action = "exp_gztdl"             #匯出 gztdl_t 所有語言除了zh_TW 
         CALL azzp110_exp_gztdl()
         
      WHEN lc_action = "exp_gztel"             #匯出 gztel_t 所有語言除了zh_TW 
         CALL azzp110_exp_gztel()
         
      WHEN lc_action = "exp_gzzol"             #匯出 gzzol_t 所有語言除了zh_TW 
         CALL azzp110_exp_gzzol()
         
      WHEN lc_action = "exp_gzzf"              #匯出 gzzf_t 所有語言除了zh_TW 
         CALL azzp110_exp_gzzf()
      
      WHEN lc_action = "exp_wscal"             #匯出 wscal_t 所有語言除了zh_TW 
         CALL azzp110_exp_wscal()
      
      WHEN lc_action = "exp_wsebl"             #匯出 wsebl_t 所有語言除了zh_TW 
         CALL azzp110_exp_wsebl()
      
      WHEN lc_action = "exp_wsecl"             #匯出 wsecl_t 所有語言除了zh_TW 
         CALL azzp110_exp_wsecl()
      
      WHEN lc_action = "exp_gzgjl"             #匯出 gzgjl_t 所有語言除了zh_TW 
         CALL azzp110_exp_gzgjl()
      
      WHEN lc_action = "exp_gzahl"             #匯出 gzahl_t 所有語言除了zh_TW 
         CALL azzp110_exp_gzahl()
      
      WHEN lc_action = "exp_gzgp"              #匯出 gzgp_t 所有語言除了zh_TW 
         CALL azzp110_exp_gzgp()               #從字典檔匯到gzgp 要注意gzgp_t有標準及客製
      
      WHEN lc_action = "exp_rpdel"             #匯出 rpdel_t 所有語言除了zh_TW 
         CALL azzp110_exp_rpdel()
      
      WHEN lc_action = "exp_rpzzl"             #匯出 rpzzl_t 所有語言除了zh_TW 
         CALL azzp110_exp_rpzzl()
      
   #   OTHERWISE CALL azzp110_readme()
   END CASE
   DISPLAY "azzp110: ",lc_action ," 執行完成"
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_ins_gzdel_zhtw()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_ins_gzdel_zhtw()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_gzdel001 LIKE gzdel_t.gzdel001   #規格編號
   DEFINE lc_gzdel002 LIKE gzdel_t.gzdel002   #語言別
   DEFINE lc_gzdel003 LIKE gzdel_t.gzdel003   #說明
   DEFINE lc_gzdel003_new LIKE gzdel_t.gzdel003   #表格名稱
   DEFINE li_row      LIKE type_t.num10
   DEFINE li_zhtw     LIKE type_t.num5
   DEFINE lc_gzozcrtdt LIKE gzoz_t.gzozcrtdt
   DEFINE lc_gzoz001  LIKE gzoz_t.gzoz001
   DEFINE lc_gzdel    RECORD LIKE gzdel_t.*
   DEFINE lc_msg      STRING
   
   
   LET ls_sql = "SELECT UNIQUE gzdel001 FROM gzdel_t ",
                " WHERE (gzdel002 = 'zh_TW' OR gzdel002 = 'zh_CN') ",
                  " AND TRIM(gzdel003) IS NOT NULL "

   #如果有外傳參數的處理
   IF g_param.extra_condition IS NOT NULL THEN
      LET ls_sql = ls_sql," ",g_param.extra_condition
   END IF

   #排序
   LET ls_sql = ls_sql, "ORDER BY gzdel001 "

   #組合SQL
   DECLARE azzp110_gzdel_zhtw_cs CURSOR FROM ls_sql
   FOREACH azzp110_gzdel_zhtw_cs INTO lc_gzdel001
      DISPLAY "insert from gzdel_t:",lc_gzdel001
      #先檢查簡繁是否都存在
      SELECT COUNT(*) INTO li_cnt FROM gzdel_t
       WHERE gzdel001 = lc_gzdel001 AND (gzdel002 = 'zh_TW' OR gzdel002 = 'zh_CN')
         AND gzdel003 IS NOT NULL
          
      #簡繁只有一筆,若為繁體直接取,若為簡體先轉詞轉碼
      IF li_cnt = 1 THEN
         SELECT * INTO lc_gzdel.* FROM gzdel_t
          WHERE gzdel001 = lc_gzdel001 AND (gzdel002 = 'zh_TW' OR gzdel002 = 'zh_CN')
            AND gzdel003 IS NOT NULL

         #若這唯一的一筆是簡體,就要先轉換為繁體寫回
         IF lc_gzdel.gzdel002 = 'zh_CN' AND NOT cl_null(lc_gzdel.gzdel003) THEN
            #轉換該轉的 (此處cl_trans有先寫字典檔)
            LET lc_gzdel.gzdel002 = "zh_TW"
            LET lc_gzdel003_new = cl_trans_code_tw_cn("zh_TW",lc_gzdel.gzdel003)
            IF g_bgjob= "Y" AND (cl_null(lc_gzdel003_new) AND NOT cl_null(lc_gzdel.gzdel003)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>gzdel_t</td>",                      #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_gzdel.gzdel001,"</td>",        #key值欄位1
                                          "<td class=xl24></td>",                             #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_gzdel.gzdel003,"</td>",        #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字
                            "</tr>"

               CALL g_gen_ch.writeLine(lc_msg)

               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_gzdel.gzdel003 = lc_gzdel003_new

            #回寫
            INSERT INTO gzdel_t VALUES (lc_gzdel.*)

         END IF
      ELSE
         IF li_cnt = 2 THEN
           #簡繁有2筆時, 重抓資料
            SELECT * INTO lc_gzdel.* FROM gzdel_t
             WHERE gzdel001 = lc_gzdel001 AND gzdel002 = "zh_TW"
         END IF
      END IF

      IF li_cnt > 0 THEN
         #再檢查字典檔,遇缺則補入
         IF azzp110_chk_gzoy("gzdel_t",lc_gzdel.gzdel002,lc_gzdel.gzdel001,'','',lc_gzdel.gzdel003) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_gzdel.gzdel003,lc_gzdel.gzdel001,'','')
         END IF
      END IF

   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_ins_gzhal_zhtw()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_ins_gzhal_zhtw()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_gzhal001 LIKE gzhal_t.gzhal001   #布景編號
   DEFINE lc_gzhal002 LIKE gzhal_t.gzhal002   #語言別
   DEFINE lc_gzhal003 LIKE gzhal_t.gzhal003   #布景名稱
   DEFINE lc_gzhal003_new LIKE gzhal_t.gzhal003   #布景名稱
   DEFINE li_row      LIKE type_t.num10
   DEFINE li_zhtw     LIKE type_t.num5
   DEFINE lc_gzozcrtdt LIKE gzoz_t.gzozcrtdt
   DEFINE lc_gzoz001  LIKE gzoz_t.gzoz001
   DEFINE lc_gzhal    RECORD LIKE gzhal_t.*
   DEFINE lc_msg      STRING
   
   
   LET ls_sql = "SELECT UNIQUE gzhal001 FROM gzhal_t ",
                " WHERE (gzhal002 = 'zh_TW' OR gzhal002 = 'zh_CN') ",
                  " AND TRIM(gzhal003) IS NOT NULL "

   #如果有外傳參數的處理
   IF g_param.extra_condition IS NOT NULL THEN
      LET ls_sql = ls_sql," ",g_param.extra_condition
   END IF

   #排序
   LET ls_sql = ls_sql, "ORDER BY gzhal001 "

   #組合SQL
   DECLARE azzp110_gzhal_zhtw_cs CURSOR FROM ls_sql
   FOREACH azzp110_gzhal_zhtw_cs INTO lc_gzhal001
       DISPLAY "insert from gzhal_t:",lc_gzhal001
       #先檢查簡繁是否都存在
       SELECT COUNT(*) INTO li_cnt FROM gzhal_t
        WHERE gzhal001 = lc_gzhal001 AND (gzhal002 = 'zh_TW' OR gzhal002 = 'zh_CN')
          AND gzhal003 IS NOT NULL
       
       #簡繁只有一筆,若為繁體直接取,若為簡體先轉詞轉碼
      IF li_cnt = 1 THEN
         SELECT * INTO lc_gzhal.* FROM gzhal_t
          WHERE gzhal001 = lc_gzhal001 AND (gzhal002 = 'zh_TW' OR gzhal002 = 'zh_CN')
            AND gzhal003 IS NOT NULL

         #若這唯一的一筆是簡體,就要先轉換為繁體寫回
         IF lc_gzhal.gzhal002 = 'zh_CN' AND NOT cl_null(lc_gzhal.gzhal003) THEN
            #轉換該轉的 (此處cl_trans有先寫字典檔)
            LET lc_gzhal.gzhal002 = "zh_TW"
            LET lc_gzhal003_new = cl_trans_code_tw_cn("zh_TW",lc_gzhal.gzhal003)
            IF g_bgjob= "Y" AND (cl_null(lc_gzhal003_new) AND NOT cl_null(lc_gzhal.gzhal003)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>gzhal_t</td>",                      #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_gzhal.gzhal001,"</td>",        #key值欄位1
                                          "<td class=xl24></td>",                             #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_gzhal.gzhal003,"</td>",        #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字
                            "</tr>"

               CALL g_gen_ch.writeLine(lc_msg)

               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_gzhal.gzhal003 = lc_gzhal003_new

            #回寫
            INSERT INTO gzhal_t VALUES (lc_gzhal.*)

         END IF
      ELSE
         IF li_cnt = 2 THEN
           #簡繁有2筆時, 重抓資料
            SELECT * INTO lc_gzhal.* FROM gzhal_t
             WHERE gzhal001 = lc_gzhal001 AND gzhal002 = "zh_TW"
         END IF
      END IF

      IF li_cnt > 0 THEN
         #再檢查字典檔,遇缺則補入
         IF azzp110_chk_gzoy("gzhal_t",lc_gzhal.gzhal002,lc_gzhal.gzhal001,'','',lc_gzhal.gzhal003) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_gzhal.gzhal003,lc_gzhal.gzhal001,'','')
         END IF
      END IF

   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_ins_gzial_zhtw()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_ins_gzial_zhtw()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_gzial001 LIKE gzial_t.gzial001   #程式編號
   DEFINE lc_gzial002 LIKE gzial_t.gzial002   #語言別
   DEFINE lc_gzial003 LIKE gzial_t.gzial003   #多語言檔說明
   DEFINE lc_gzial003_new LIKE gzial_t.gzial003   #多語言檔說明
   DEFINE li_row      LIKE type_t.num10
   DEFINE li_zhtw     LIKE type_t.num5
   DEFINE lc_gzozcrtdt LIKE gzoz_t.gzozcrtdt
   DEFINE lc_gzoz001  LIKE gzoz_t.gzoz001
   DEFINE lc_gzial    RECORD LIKE gzial_t.*
   DEFINE lc_msg      STRING
   
   
   LET ls_sql = "SELECT UNIQUE gzial001 FROM gzial_t ",
                " WHERE (gzial002 = 'zh_TW' OR gzial002 = 'zh_CN') ",
                  " AND TRIM(gzial003) IS NOT NULL "

   #如果有外傳參數的處理
   IF g_param.extra_condition IS NOT NULL THEN
      LET ls_sql = ls_sql," ",g_param.extra_condition
   END IF

   #排序
   LET ls_sql = ls_sql, "ORDER BY gzial001 "

   #組合SQL
   DECLARE azzp110_gzial_zhtw_cs CURSOR FROM ls_sql
   FOREACH azzp110_gzial_zhtw_cs INTO lc_gzial001
       DISPLAY "insert from gzial_t:",lc_gzial001
       #先檢查簡繁是否都存在
       SELECT COUNT(*) INTO li_cnt FROM gzial_t
        WHERE gzial001 = lc_gzial001 AND (gzial002 = 'zh_TW' OR gzial002 = 'zh_CN')
          AND gzial003 IS NOT NULL
       
       #簡繁只有一筆,若為繁體直接取,若為簡體先轉詞轉碼
      IF li_cnt = 1 THEN
         SELECT * INTO lc_gzial.* FROM gzial_t
          WHERE gzial001 = lc_gzial001 AND (gzial002 = 'zh_TW' OR gzial002 = 'zh_CN')
            AND gzial003 IS NOT NULL

         #若這唯一的一筆是簡體,就要先轉換為繁體寫回
         IF lc_gzial.gzial002 = 'zh_CN' AND NOT cl_null(lc_gzial.gzial003) THEN
            #轉換該轉的 (此處cl_trans有先寫字典檔)
            LET lc_gzial.gzial002 = "zh_TW"
            LET lc_gzial003_new = cl_trans_code_tw_cn("zh_TW",lc_gzial.gzial003)
            IF g_bgjob= "Y" AND (cl_null(lc_gzial003_new) AND NOT cl_null(lc_gzial.gzial003)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>gzial_t</td>",                      #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_gzial.gzial001,"</td>",        #key值欄位1
                                          "<td class=xl24></td>",                             #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_gzial.gzial003,"</td>",        #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字
                            "</tr>"

               CALL g_gen_ch.writeLine(lc_msg)

               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_gzial.gzial003 = lc_gzial003_new
            
            #回寫
            INSERT INTO gzial_t VALUES (lc_gzial.*)

         END IF
      ELSE
         IF li_cnt = 2 THEN
           #簡繁有2筆時, 重抓資料
            SELECT * INTO lc_gzial.* FROM gzial_t
             WHERE gzial001 = lc_gzial001 AND gzial002 = "zh_TW"
         END IF
      END IF

      IF li_cnt > 0 THEN
         #再檢查字典檔,遇缺則補入
         IF azzp110_chk_gzoy("gzial_t",lc_gzial.gzial002,lc_gzial.gzial001,'','',lc_gzial.gzial003) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_gzial.gzial003,lc_gzial.gzial001,'','')
         END IF
      END IF

   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_ins_gzidl_zhtw()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_ins_gzidl_zhtw()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_gzidl001 LIKE gzidl_t.gzidl001   #查詢單ID
   DEFINE lc_gzidl002 LIKE gzidl_t.gzidl002   #序號
   DEFINE lc_gzidl003 LIKE gzidl_t.gzidl003   #語言別
   DEFINE lc_gzidl004 LIKE gzidl_t.gzidl004   #說明
   DEFINE lc_gzidl004_new LIKE gzidl_t.gzidl004   #說明
   DEFINE li_row      LIKE type_t.num10
   DEFINE li_zhtw     LIKE type_t.num5
   DEFINE lc_gzozcrtdt LIKE gzoz_t.gzozcrtdt
   DEFINE lc_gzoz001  LIKE gzoz_t.gzoz001
   DEFINE lc_gzidl    RECORD LIKE gzidl_t.*
   DEFINE lc_msg      STRING
   
   
   LET ls_sql = "SELECT UNIQUE gzidl001,gzidl002 FROM gzidl_t ",
                " WHERE (gzidl003 = 'zh_TW' OR gzidl003 = 'zh_CN') ",
                  " AND TRIM(gzidl004) IS NOT NULL "

   #如果有外傳參數的處理
   IF g_param.extra_condition IS NOT NULL THEN
      LET ls_sql = ls_sql," ",g_param.extra_condition
   END IF

   #排序
   LET ls_sql = ls_sql, "ORDER BY gzidl001,gzidl002 "

   #組合SQL
   DECLARE azzp110_gzidl_zhtw_cs CURSOR FROM ls_sql
   FOREACH azzp110_gzidl_zhtw_cs INTO lc_gzidl001,lc_gzidl002
       DISPLAY "insert from gzidl_t:",lc_gzidl001
       #先檢查簡繁是否都存在
       SELECT COUNT(*) INTO li_cnt FROM gzidl_t
        WHERE gzidl001 = lc_gzidl001 AND gzidl002 = lc_gzidl002
          AND (gzidl003 = 'zh_TW' OR gzidl003 = 'zh_CN')
          AND gzidl004 IS NOT NULL
       
       #簡繁只有一筆,若為繁體直接取,若為簡體先轉詞轉碼
      IF li_cnt = 1 THEN
         SELECT * INTO lc_gzidl.* FROM gzidl_t
          WHERE gzidl001 = lc_gzidl001 AND gzidl002 = lc_gzidl002
            AND (gzidl003 = 'zh_TW' OR gzidl003 = 'zh_CN')
            AND gzidl004 IS NOT NULL

         #若這唯一的一筆是簡體,就要先轉換為繁體寫回
         IF lc_gzidl.gzidl003 = 'zh_CN' AND NOT cl_null(lc_gzidl.gzidl004) THEN
            #轉換該轉的 (此處cl_trans有先寫字典檔)
            LET lc_gzidl.gzidl003 = "zh_TW"
            LET lc_gzidl004_new = cl_trans_code_tw_cn("zh_TW",lc_gzidl.gzidl004)
            IF g_bgjob= "Y" AND (cl_null(lc_gzidl004_new) AND NOT cl_null(lc_gzidl.gzidl004)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>gzidl_t</td>",                      #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_gzidl.gzidl001,"</td>",        #key值欄位1
                                          "<td class=xl24>",lc_gzidl.gzidl002,"</td>",        #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_gzidl.gzidl004,"</td>",        #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字
                            "</tr>"

               CALL g_gen_ch.writeLine(lc_msg)
               
               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_gzidl.gzidl004 = lc_gzidl004_new

            #回寫
            INSERT INTO gzidl_t VALUES (lc_gzidl.*)

         END IF
      ELSE
         IF li_cnt = 2 THEN
           #簡繁有2筆時, 重抓資料
            SELECT * INTO lc_gzidl.* FROM gzidl_t
             WHERE gzidl001 = lc_gzidl001 AND gzidl002 = lc_gzidl002
               AND gzidl003 = "zh_TW"
         END IF
      END IF
      
      IF li_cnt > 0 THEN
         #再檢查字典檔,遇缺則補入
         IF azzp110_chk_gzoy("gzidl_t",lc_gzidl.gzidl003,lc_gzidl.gzidl001,lc_gzidl.gzidl002,'',lc_gzidl.gzidl004) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_gzidl.gzidl004,lc_gzidl.gzidl001,'','')
         END IF
      END IF

   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_ins_gzjal_zhtw()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_ins_gzjal_zhtw()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_gzjal001 LIKE gzjal_t.gzjal001   #服務規格編號
   DEFINE lc_gzjal002 LIKE gzjal_t.gzjal002   #語言別
   DEFINE lc_gzjal003 LIKE gzjal_t.gzjal003   #服務名稱
   DEFINE lc_gzjal003_new LIKE gzjal_t.gzjal003   #服務名稱
   DEFINE li_row      LIKE type_t.num10
   DEFINE li_zhtw     LIKE type_t.num5
   DEFINE lc_gzozcrtdt LIKE gzoz_t.gzozcrtdt
   DEFINE lc_gzoz001  LIKE gzoz_t.gzoz001
   DEFINE lc_gzjal    RECORD LIKE gzjal_t.*
   DEFINE lc_msg      STRING
   
   
   LET ls_sql = "SELECT UNIQUE gzjal001 FROM gzjal_t ",
                " WHERE (gzjal002 = 'zh_TW' OR gzjal002 = 'zh_CN') ",
                  " AND TRIM(gzjal003) IS NOT NULL "

   #如果有外傳參數的處理
   IF g_param.extra_condition IS NOT NULL THEN
      LET ls_sql = ls_sql," ",g_param.extra_condition
   END IF

   #排序
   LET ls_sql = ls_sql, "ORDER BY gzjal001 "

   #組合SQL
   DECLARE azzp110_gzjal_zhtw_cs CURSOR FROM ls_sql
   FOREACH azzp110_gzjal_zhtw_cs INTO lc_gzjal001
       DISPLAY "insert from gzjal_t:",lc_gzjal001
       #先檢查簡繁是否都存在
       SELECT COUNT(*) INTO li_cnt FROM gzjal_t
        WHERE gzjal001 = lc_gzjal001
          AND (gzjal002 = 'zh_TW' OR gzjal002 = 'zh_CN')
          AND gzjal003 IS NOT NULL
       
       #簡繁只有一筆,若為繁體直接取,若為簡體先轉詞轉碼
      IF li_cnt = 1 THEN
         SELECT * INTO lc_gzjal.* FROM gzjal_t
          WHERE gzjal001 = lc_gzjal001
            AND (gzjal002 = 'zh_TW' OR gzjal002 = 'zh_CN')
            AND gzjal003 IS NOT NULL

         #若這唯一的一筆是簡體,就要先轉換為繁體寫回
         IF lc_gzjal.gzjal002 = 'zh_CN' AND NOT cl_null(lc_gzjal.gzjal003) THEN
            #轉換該轉的 (此處cl_trans有先寫字典檔)
            LET lc_gzjal.gzjal002 = "zh_TW"
            LET lc_gzjal003_new = cl_trans_code_tw_cn("zh_TW",lc_gzjal.gzjal003)
            IF g_bgjob= "Y" AND (cl_null(lc_gzjal003_new) AND NOT cl_null(lc_gzjal.gzjal003)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>gzjal_t</td>",                      #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_gzjal.gzjal001,"</td>",        #key值欄位1
                                          "<td class=xl24></td>",                             #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_gzjal.gzjal003,"</td>",        #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字
                            "</tr>"

               CALL g_gen_ch.writeLine(lc_msg)
               
               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_gzjal.gzjal003 = lc_gzjal003_new

            #回寫
            INSERT INTO gzjal_t VALUES (lc_gzjal.*)

         END IF
      ELSE
         IF li_cnt = 2 THEN
           #簡繁有2筆時, 重抓資料
            SELECT * INTO lc_gzjal.* FROM gzjal_t
             WHERE gzjal001 = lc_gzjal001
               AND gzjal002 = "zh_TW"
         END IF
      END IF

      IF li_cnt > 0 THEN
         #再檢查字典檔,遇缺則補入
         IF azzp110_chk_gzoy("gzjal_t",lc_gzjal.gzjal002,lc_gzjal.gzjal001,'','',lc_gzjal.gzjal003) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_gzjal.gzjal003,lc_gzjal.gzjal001,'','')
         END IF
      END IF

   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_ins_gztdl_zhtw()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_ins_gztdl_zhtw()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_gztdl001 LIKE gztdl_t.gztdl001   #欄位屬性編號
   DEFINE lc_gztdl002 LIKE gztdl_t.gztdl002   #語言別
   DEFINE lc_gztdl003 LIKE gztdl_t.gztdl003   #欄位簡稱
   DEFINE lc_gztdl004 LIKE gztdl_t.gztdl004   #說明
   DEFINE lc_gztdl003_new LIKE gztdl_t.gztdl003   #欄位簡稱
   DEFINE lc_gztdl004_new LIKE gztdl_t.gztdl004   #說明
   DEFINE li_row      LIKE type_t.num10
   DEFINE li_zhtw     LIKE type_t.num5
   DEFINE lc_gzozcrtdt LIKE gzoz_t.gzozcrtdt
   DEFINE lc_gzoz001  LIKE gzoz_t.gzoz001
   DEFINE lc_gztdl    RECORD LIKE gztdl_t.*
   DEFINE lc_msg      STRING
   
   
   LET ls_sql = "SELECT UNIQUE gztdl001 FROM gztdl_t ",
                " WHERE (gztdl002 = 'zh_TW' OR gztdl002 = 'zh_CN') ",
                  " AND TRIM(gztdl003) IS NOT NULL "

   #如果有外傳參數的處理
   IF g_param.extra_condition IS NOT NULL THEN
      LET ls_sql = ls_sql," ",g_param.extra_condition
   END IF

   #排序
   LET ls_sql = ls_sql, "ORDER BY gztdl001 "

   #組合SQL
   DECLARE azzp110_gztdl_zhtw_cs CURSOR FROM ls_sql
   FOREACH azzp110_gztdl_zhtw_cs INTO lc_gztdl001
       DISPLAY "insert from gztdl_t:",lc_gztdl001
       #先檢查簡繁是否都存在
       SELECT COUNT(*) INTO li_cnt FROM gztdl_t
        WHERE gztdl001 = lc_gztdl001
          AND (gztdl002 = 'zh_TW' OR gztdl002 = 'zh_CN')
          AND gztdl003 IS NOT NULL
       
       #簡繁只有一筆,若為繁體直接取,若為簡體先轉詞轉碼
      IF li_cnt = 1 THEN
         SELECT * INTO lc_gztdl.* FROM gztdl_t
          WHERE gztdl001 = lc_gztdl001
            AND (gztdl002 = 'zh_TW' OR gztdl002 = 'zh_CN')
            AND gztdl003 IS NOT NULL

         #若這唯一的一筆是簡體,就要先轉換為繁體寫回
         IF lc_gztdl.gztdl002 = 'zh_CN' AND NOT cl_null(lc_gztdl.gztdl003) THEN
            #轉換該轉的 (此處cl_trans有先寫字典檔)
            LET lc_gztdl.gztdl002 = "zh_TW"
            LET lc_gztdl003_new = cl_trans_code_tw_cn("zh_TW",lc_gztdl.gztdl003)
            IF g_bgjob= "Y" AND (cl_null(lc_gztdl003_new) AND NOT cl_null(lc_gztdl.gztdl003)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>gztdl_t</td>",                      #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_gztdl.gztdl001,"</td>",        #key值欄位1
                                          "<td class=xl24></td>",                             #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_gztdl.gztdl003,"</td>",        #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字
                            "</tr>"

               CALL g_gen_ch.writeLine(lc_msg)
               
               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_gztdl.gztdl003 = lc_gztdl003_new

            LET lc_gztdl004_new = cl_trans_code_tw_cn("zh_TW",lc_gztdl.gztdl004)
            IF g_bgjob= "Y" AND (cl_null(lc_gztdl004_new) AND NOT cl_null(lc_gztdl.gztdl004)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>gztdl_t</td>",                      #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_gztdl.gztdl001,"</td>",        #key值欄位1
                                          "<td class=xl24></td>",                             #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_gztdl.gztdl004,"</td>",        #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字
                            "</tr>"

               CALL g_gen_ch.writeLine(lc_msg)

               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_gztdl.gztdl004 = lc_gztdl004_new

            #回寫
            INSERT INTO gztdl_t VALUES (lc_gztdl.*)
            
         END IF
      ELSE
         IF li_cnt = 2 THEN
           #簡繁有2筆時, 重抓資料
            SELECT * INTO lc_gztdl.* FROM gztdl_t
             WHERE gztdl001 = lc_gztdl001
               AND gztdl002 = "zh_TW"
         END IF
      END IF

      IF li_cnt > 0 THEN
         #再檢查字典檔,遇缺則補入
         IF azzp110_chk_gzoy("gztdl_t",lc_gztdl.gztdl002,lc_gztdl.gztdl001,'','',lc_gztdl.gztdl003) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_gztdl.gztdl003,lc_gztdl.gztdl001,'','')
         END IF
         IF azzp110_chk_gzoy("gztdl_t",lc_gztdl.gztdl002,lc_gztdl.gztdl001,'','',lc_gztdl.gztdl004) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_gztdl.gztdl004,lc_gztdl.gztdl001,'','')
         END IF
      END IF

   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_ins_gztel_zhtw()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_ins_gztel_zhtw()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_gztel001 LIKE gztel_t.gztel001   #流程編號
   DEFINE lc_gztel002 LIKE gztel_t.gztel002   #語言別
   DEFINE lc_gztel003 LIKE gztel_t.gztel003   #說明
   DEFINE lc_gztel003_new LIKE gztel_t.gztel003   #說明
   DEFINE li_row      LIKE type_t.num10
   DEFINE li_zhtw     LIKE type_t.num5
   DEFINE lc_gzozcrtdt LIKE gzoz_t.gzozcrtdt
   DEFINE lc_gzoz001  LIKE gzoz_t.gzoz001
   DEFINE lc_gztel    RECORD LIKE gztel_t.*
   DEFINE lc_msg      STRING


   LET ls_sql = "SELECT UNIQUE gztel001 FROM gztel_t ",
                " WHERE (gztel002 = 'zh_TW' OR gztel002 = 'zh_CN') ",
                  " AND TRIM(gztel003) IS NOT NULL "

   #如果有外傳參數的處理
   IF g_param.extra_condition IS NOT NULL THEN
      LET ls_sql = ls_sql," ",g_param.extra_condition
   END IF
   
   
   #排序
   LET ls_sql = ls_sql, "ORDER BY gztel001 "

   #組合SQL
   DECLARE azzp110_gztel_zhtw_cs CURSOR FROM ls_sql
   FOREACH azzp110_gztel_zhtw_cs INTO lc_gztel001
       DISPLAY "insert from gztel_t:",lc_gztel001
       #先檢查簡繁是否都存在
       SELECT COUNT(*) INTO li_cnt FROM gztel_t
        WHERE gztel001 = lc_gztel001
          AND (gztel002 = 'zh_TW' OR gztel002 = 'zh_CN')
          AND gztel003 IS NOT NULL

      #簡繁只有一筆,若為繁體直接取,若為簡體先轉詞轉碼
      IF li_cnt = 1 THEN
         SELECT * INTO lc_gztel.* FROM gztel_t
          WHERE gztel001 = lc_gztel001
            AND (gztel002 = 'zh_TW' OR gztel002 = 'zh_CN')
            AND gztel003 IS NOT NULL
         
         #若這唯一的一筆是簡體,就要先轉換為繁體寫回
         IF lc_gztel.gztel002 = 'zh_CN' AND NOT cl_null(lc_gztel.gztel003) THEN
            #轉換該轉的 (此處cl_trans有先寫字典檔)
            LET lc_gztel.gztel002 = "zh_TW"
            LET lc_gztel003_new = cl_trans_code_tw_cn("zh_TW",lc_gztel.gztel003)
            IF g_bgjob= "Y" AND (cl_null(lc_gztel003_new) AND NOT cl_null(lc_gztel.gztel003)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>gztel_t</td>",                      #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_gztel.gztel001,"</td>",        #key值欄位1
                                          "<td class=xl24></td>",                             #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_gztel.gztel003,"</td>",        #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字
                            "</tr>"

               CALL g_gen_ch.writeLine(lc_msg)

               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_gztel.gztel003 = lc_gztel003_new

            #回寫
            INSERT INTO gztel_t VALUES (lc_gztel.*)

         END IF
      ELSE
         IF li_cnt = 2 THEN
           #簡繁有2筆時, 重抓資料
            SELECT * INTO lc_gztel.* FROM gztel_t
             WHERE gztel001 = lc_gztel001
               AND gztel002 = "zh_TW"
         END IF
      END IF

      IF li_cnt > 0 THEN
         #再檢查字典檔,遇缺則補入
         IF azzp110_chk_gzoy("gztel_t",lc_gztel.gztel002,lc_gztel.gztel001,'','',lc_gztel.gztel003) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_gztel.gztel003,lc_gztel.gztel001,'','')
         END IF
      END IF

   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_ins_gzzol_zhtw()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_ins_gzzol_zhtw()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_gzzol001 LIKE gzzol_t.gzzol001   #模組編號
   DEFINE lc_gzzol002 LIKE gzzol_t.gzzol002   #語言別
   DEFINE lc_gzzol003 LIKE gzzol_t.gzzol003   #模組名稱
   DEFINE lc_gzzol003_new LIKE gzzol_t.gzzol003   #模組名稱
   DEFINE li_row      LIKE type_t.num10
   DEFINE li_zhtw     LIKE type_t.num5
   DEFINE lc_gzozcrtdt LIKE gzoz_t.gzozcrtdt
   DEFINE lc_gzoz001  LIKE gzoz_t.gzoz001
   DEFINE lc_gzzol    RECORD LIKE gzzol_t.*
   DEFINE lc_msg      STRING
   
   
   LET ls_sql = "SELECT UNIQUE gzzol001 FROM gzzol_t ",
                " WHERE (gzzol002 = 'zh_TW' OR gzzol002 = 'zh_CN') ",
                  " AND TRIM(gzzol003) IS NOT NULL "

   #如果有外傳參數的處理
   IF g_param.extra_condition IS NOT NULL THEN
      LET ls_sql = ls_sql," ",g_param.extra_condition
   END IF

   #排序
   LET ls_sql = ls_sql, "ORDER BY gzzol001 "

   #組合SQL
   DECLARE azzp110_gzzol_zhtw_cs CURSOR FROM ls_sql
   FOREACH azzp110_gzzol_zhtw_cs INTO lc_gzzol001
       DISPLAY "insert from gzzol_t:",lc_gzzol001
       #先檢查簡繁是否都存在
       SELECT COUNT(*) INTO li_cnt FROM gzzol_t
        WHERE gzzol001 = lc_gzzol001
          AND (gzzol002 = 'zh_TW' OR gzzol002 = 'zh_CN')
          AND gzzol003 IS NOT NULL
       
       #簡繁只有一筆,若為繁體直接取,若為簡體先轉詞轉碼
      IF li_cnt = 1 THEN
         SELECT * INTO lc_gzzol.* FROM gzzol_t
          WHERE gzzol001 = lc_gzzol001
            AND (gzzol002 = 'zh_TW' OR gzzol002 = 'zh_CN')
            AND gzzol003 IS NOT NULL

         #若這唯一的一筆是簡體,就要先轉換為繁體寫回
         IF lc_gzzol.gzzol002 = 'zh_CN' AND NOT cl_null(lc_gzzol.gzzol003) THEN
            #轉換該轉的 (此處cl_trans有先寫字典檔)
            LET lc_gzzol.gzzol002 = "zh_TW"
            LET lc_gzzol003_new = cl_trans_code_tw_cn("zh_TW",lc_gzzol.gzzol003)
            IF g_bgjob= "Y" AND (cl_null(lc_gzzol003_new) AND NOT cl_null(lc_gzzol.gzzol003)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>gzzol_t</td>",                      #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_gzzol.gzzol001,"</td>",        #key值欄位1
                                          "<td class=xl24></td>",                             #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_gzzol.gzzol003,"</td>",        #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字
                            "</tr>"

               CALL g_gen_ch.writeLine(lc_msg)

               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_gzzol.gzzol003 = lc_gzzol003_new

            #回寫
            INSERT INTO gzzol_t VALUES (lc_gzzol.*)

         END IF
      ELSE
         IF li_cnt = 2 THEN
           #簡繁有2筆時, 重抓資料
            SELECT * INTO lc_gzzol.* FROM gzzol_t
             WHERE gzzol001 = lc_gzzol001
               AND gzzol002 = "zh_TW"
         END IF
      END IF

      IF li_cnt > 0 THEN
         #再檢查字典檔,遇缺則補入
         IF azzp110_chk_gzoy("gzzol_t",lc_gzzol.gzzol002,lc_gzzol.gzzol001,'','',lc_gzzol.gzzol003) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_gzzol.gzzol003,lc_gzzol.gzzol001,'','')
         END IF
      END IF

   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_ins_gzzf_zhtw()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_ins_gzzf_zhtw()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_gzzf001 LIKE gzzf_t.gzzf001   #作業編號
   DEFINE lc_gzzf002 LIKE gzzf_t.gzzf002   #語言別
   DEFINE lc_gzzf003 LIKE gzzf_t.gzzf003   #待轉標籤
   DEFINE lc_gzzf005 LIKE gzzf_t.gzzf005   #轉換標籤文字
   DEFINE lc_gzzf006 LIKE gzzf_t.gzzf006   #轉換註解
   DEFINE lc_gzzf005_new LIKE gzzf_t.gzzf005   #轉換標籤文字
   DEFINE lc_gzzf006_new LIKE gzzf_t.gzzf006   #轉換註解
   DEFINE li_row      LIKE type_t.num10
   DEFINE li_zhtw     LIKE type_t.num5
   DEFINE lc_gzozcrtdt LIKE gzoz_t.gzozcrtdt
   DEFINE lc_gzoz001  LIKE gzoz_t.gzoz001
   DEFINE lc_gzzf    RECORD LIKE gzzf_t.*
   DEFINE lc_msg      STRING
   
   
   LET ls_sql = "SELECT UNIQUE gzzf001,gzzf003 FROM gzzf_t ",
                " WHERE (gzzf002 = 'zh_TW' OR gzzf002 = 'zh_CN') ",
                  " AND TRIM(gzzf005) IS NOT NULL "

   #如果有外傳參數的處理
   IF g_param.extra_condition IS NOT NULL THEN
      LET ls_sql = ls_sql," ",g_param.extra_condition
   END IF

   #排序
   LET ls_sql = ls_sql, "ORDER BY gzzf001,gzzf003 "

   #組合SQL
   DECLARE azzp110_gzzf_zhtw_cs CURSOR FROM ls_sql
   FOREACH azzp110_gzzf_zhtw_cs INTO lc_gzzf001,lc_gzzf003
       DISPLAY "insert from gzzf_t:",lc_gzzf001
       #先檢查簡繁是否都存在
       SELECT COUNT(*) INTO li_cnt FROM gzzf_t
        WHERE gzzf001 = lc_gzzf001 AND gzzf003 = lc_gzzf003
          AND (gzzf002 = 'zh_TW' OR gzzf002 = 'zh_CN')
          AND gzzf005 IS NOT NULL
       
       #簡繁只有一筆,若為繁體直接取,若為簡體先轉詞轉碼
      IF li_cnt = 1 THEN
         SELECT * INTO lc_gzzf.* FROM gzzf_t
          WHERE gzzf001 = lc_gzzf001 AND gzzf003 = lc_gzzf003
            AND (gzzf002 = 'zh_TW' OR gzzf002 = 'zh_CN')
            AND gzzf005 IS NOT NULL

         #若這唯一的一筆是簡體,就要先轉換為繁體寫回
         IF lc_gzzf.gzzf002 = 'zh_CN' AND NOT cl_null(lc_gzzf.gzzf005) THEN
            #轉換該轉的 (此處cl_trans有先寫字典檔)
            LET lc_gzzf.gzzf002 = "zh_TW"
            LET lc_gzzf005_new = cl_trans_code_tw_cn("zh_TW",lc_gzzf.gzzf005)
            IF g_bgjob= "Y" AND (cl_null(lc_gzzf005_new) AND NOT cl_null(lc_gzzf.gzzf005)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>gzzf_t</td>",                       #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_gzzf.gzzf001,"</td>",          #key值欄位1
                                          "<td class=xl24>",lc_gzzf.gzzf003,"</td>",          #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_gzzf.gzzf005,"</td>",          #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字
                            "</tr>"

               CALL g_gen_ch.writeLine(lc_msg)

               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_gzzf.gzzf005 = lc_gzzf005_new

            LET lc_gzzf006_new = cl_trans_code_tw_cn("zh_TW",lc_gzzf.gzzf006)
            IF g_bgjob= "Y" AND (cl_null(lc_gzzf006_new) AND NOT cl_null(lc_gzzf.gzzf006)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>gzzf_t</td>",                       #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_gzzf.gzzf001,"</td>",          #key值欄位1
                                          "<td class=xl24>",lc_gzzf.gzzf003,"</td>",          #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_gzzf.gzzf006,"</td>",          #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字
                            "</tr>"

               CALL g_gen_ch.writeLine(lc_msg)

               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_gzzf.gzzf006 = lc_gzzf006_new

            #回寫
            INSERT INTO gzzf_t VALUES (lc_gzzf.*)

         END IF
      ELSE
         IF li_cnt = 2 THEN
           #簡繁有2筆時, 重抓資料
            SELECT * INTO lc_gzzf.* FROM gzzf_t
             WHERE gzzf001 = lc_gzzf001 AND gzzf003 = lc_gzzf003
               AND gzzf002 = "zh_TW"
         END IF
      END IF

      IF li_cnt > 0 THEN
         #再檢查字典檔,遇缺則補入
         IF azzp110_chk_gzoy("gzzf_t",lc_gzzf.gzzf002,lc_gzzf.gzzf001,lc_gzzf.gzzf003,'',lc_gzzf.gzzf005) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_gzzf.gzzf005,lc_gzzf.gzzf001,'','')
         END IF
         IF azzp110_chk_gzoy("gzzf_t",lc_gzzf.gzzf002,lc_gzzf.gzzf001,lc_gzzf.gzzf003,'',lc_gzzf.gzzf006) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_gzzf.gzzf006,lc_gzzf.gzzf001,'','')
         END IF
      END IF

   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_chk_gzdel_twcn()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_chk_gzdel_twcn()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_gzdel001 LIKE gzdel_t.gzdel001
   DEFINE lc_gzdel002 LIKE gzdel_t.gzdel002
   DEFINE lc_gzdel003 LIKE gzdel_t.gzdel003
   DEFINE li_row      LIKE type_t.num10
   DEFINE lc_msg      STRING

   
   LET ls_sql = "SELECT gzdel001,gzdel002,gzdel003 FROM gzdel_t ",
                " WHERE gzdel002 = 'zh_TW' OR gzdel002 = 'zh_CN' ",
                " ORDER BY gzdel001,gzdel002"
   LET li_cnt = 1 
                
   DECLARE azzp110_gzdel_twcn_cs CURSOR FROM ls_sql
   FOREACH azzp110_gzdel_twcn_cs INTO lc_gzdel001,lc_gzdel002,lc_gzdel003
      DISPLAY "check tw_cn gzdel_t:",lc_gzdel001
      IF cl_null(lc_gzdel003) THEN
         CONTINUE FOREACH
      END IF
      CALL azzp110_trim(lc_gzdel003) RETURNING lc_gzdel003
      IF NOT cl_chk_tworcn(lc_gzdel002 CLIPPED,lc_gzdel003 CLIPPED,0) THEN
         DISPLAY li_cnt," Error Translate-lc_gzdel001:",lc_gzdel001,"   lc_gzdel002:",lc_gzdel002,
                        "   lc_gzdel003:",lc_gzdel003
         LET li_cnt = li_cnt + 1
                        
         LET lc_msg = "<tr hieght=22><td class=xl24>gzdel_t</td>",                      #檢查檔案
                                    "<td class=xl24>",lc_gzdel001,"</td>",              #key欄位1
                                    "<td class=xl24></td>",                             #key欄位2
                                    "<td class=xl24></td>",                             #key欄位3
                                    "<td class=xl24>",lc_gzdel002,"</td>",              #檢查語系
                                    "<td class=xl24>",lc_gzdel003,"</td>",              #原始字串
                      "</tr>"

         CALL g_gen_ch.writeLine(lc_msg)
      END IF
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_chk_gzhal_twcn()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_chk_gzhal_twcn()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_gzhal001 LIKE gzhal_t.gzhal001
   DEFINE lc_gzhal002 LIKE gzhal_t.gzhal002
   DEFINE lc_gzhal003 LIKE gzhal_t.gzhal003
   DEFINE li_row      LIKE type_t.num10
   DEFINE lc_msg      STRING

   
   LET ls_sql = "SELECT gzhal001,gzhal002,gzhal003 FROM gzhal_t ",
                " WHERE gzhal002 = 'zh_TW' OR gzhal002 = 'zh_CN' ",
                " ORDER BY gzhal001,gzhal002"
   LET li_cnt = 1 
                
   DECLARE azzp110_gzhal_twcn_cs CURSOR FROM ls_sql
   FOREACH azzp110_gzhal_twcn_cs INTO lc_gzhal001,lc_gzhal002,lc_gzhal003
      DISPLAY "check tw_cn gzhal_t:",lc_gzhal001
      IF cl_null(lc_gzhal003) THEN
         CONTINUE FOREACH
      END IF
      CALL azzp110_trim(lc_gzhal003) RETURNING lc_gzhal003
      IF NOT cl_chk_tworcn(lc_gzhal002 CLIPPED,lc_gzhal003 CLIPPED,0) THEN
         DISPLAY li_cnt," Error Translate-lc_gzhal001:",lc_gzhal001,"   lc_gzhal002:",lc_gzhal002,
                        "   lc_gzhal003:",lc_gzhal003
         LET li_cnt = li_cnt + 1
         
         LET lc_msg = "<tr hieght=22><td class=xl24>gzhal_t</td>",                      #檢查檔案
                                    "<td class=xl24>",lc_gzhal001,"</td>",              #key欄位1 
                                    "<td class=xl24></td>",                             #key欄位2
                                    "<td class=xl24></td>",                             #key欄位3                                    
                                    "<td class=xl24>",lc_gzhal002,"</td>",              #檢查語系
                                    "<td class=xl24>",lc_gzhal003,"</td>",              #原始字串
                      "</tr>"

         CALL g_gen_ch.writeLine(lc_msg)
      END IF
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_chk_gzial_twcn()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_chk_gzial_twcn()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_gzial001 LIKE gzial_t.gzial001
   DEFINE lc_gzial002 LIKE gzial_t.gzial002
   DEFINE lc_gzial003 LIKE gzial_t.gzial003
   DEFINE li_row      LIKE type_t.num10
   DEFINE lc_msg      STRING

   
   LET ls_sql = "SELECT gzial001,gzial002,gzial003 FROM gzial_t ",
                " WHERE gzial002 = 'zh_TW' OR gzial002 = 'zh_CN' ",
                " ORDER BY gzial001,gzial002"
   LET li_cnt = 1 
                
   DECLARE azzp110_gzial_twcn_cs CURSOR FROM ls_sql
   FOREACH azzp110_gzial_twcn_cs INTO lc_gzial001,lc_gzial002,lc_gzial003
      DISPLAY "check tw_cn gzial_t:",lc_gzial001
      IF cl_null(lc_gzial003) THEN
         CONTINUE FOREACH
      END IF
      CALL azzp110_trim(lc_gzial003) RETURNING lc_gzial003
      IF NOT cl_chk_tworcn(lc_gzial002 CLIPPED,lc_gzial003 CLIPPED,0) THEN
         DISPLAY li_cnt," Error Translate-lc_gzial001:",lc_gzial001,"   lc_gzial002:",lc_gzial002,
                        "   lc_gzial003:",lc_gzial003
         LET li_cnt = li_cnt + 1
                        
         LET lc_msg = "<tr hieght=22><td class=xl24>gzial_t</td>",                      #檢查檔案
                                    "<td class=xl24>",lc_gzial001,"</td>",              #key欄位1
                                    "<td class=xl24></td>",                             #key欄位2
                                    "<td class=xl24></td>",                             #key欄位3                                    
                                    "<td class=xl24>",lc_gzial002,"</td>",              #檢查語系
                                    "<td class=xl24>",lc_gzial003,"</td>",              #原始字串
                      "</tr>"

         CALL g_gen_ch.writeLine(lc_msg)
      END IF
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_chk_gzidl_twcn()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_chk_gzidl_twcn()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_gzidl001 LIKE gzidl_t.gzidl001
   DEFINE lc_gzidl002 LIKE gzidl_t.gzidl002
   DEFINE lc_gzidl003 LIKE gzidl_t.gzidl003
   DEFINE lc_gzidl004 LIKE gzidl_t.gzidl004
   DEFINE li_row      LIKE type_t.num10
   DEFINE lc_msg      STRING

   
   LET ls_sql = "SELECT gzidl001,gzidl002,gzidl003,gzidl004 FROM gzidl_t ",
                " WHERE gzidl003 = 'zh_TW' OR gzidl003 = 'zh_CN' ",
                " ORDER BY gzidl001,gzidl002,gzidl003"
   LET li_cnt = 1 
                
   DECLARE azzp110_gzidl_twcn_cs CURSOR FROM ls_sql
   FOREACH azzp110_gzidl_twcn_cs INTO lc_gzidl001,lc_gzidl002,lc_gzidl003,lc_gzidl004
      DISPLAY "check tw_cn gzidl_t:",lc_gzidl001
      IF cl_null(lc_gzidl004) THEN
         CONTINUE FOREACH
      END IF
      CALL azzp110_trim(lc_gzidl004) RETURNING lc_gzidl004
      IF NOT cl_chk_tworcn(lc_gzidl003 CLIPPED,lc_gzidl004 CLIPPED,0) THEN
         DISPLAY li_cnt," Error Translate-lc_gzidl001:",lc_gzidl001,"   lc_gzidl002:",lc_gzidl002,
                        "   lc_gzidl003:",lc_gzidl003,"   lc_gzidl004:",lc_gzidl004
         LET li_cnt = li_cnt + 1
                        
         LET lc_msg = "<tr hieght=22><td class=xl24>gzidl_t</td>",                      #檢查檔案
                                    "<td class=xl24>",lc_gzidl001,"</td>",              #key欄位1
                                    "<td class=xl24>",lc_gzidl002,"</td>",              #key欄位2
                                    "<td class=xl24></td>",                             #key欄位3
                                    "<td class=xl24>",lc_gzidl003,"</td>",              #檢查語系
                                    "<td class=xl24>",lc_gzidl004,"</td>",              #原始字串
                      "</tr>"

         CALL g_gen_ch.writeLine(lc_msg)
      END IF
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_chk_gzjal_twcn()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_chk_gzjal_twcn()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_gzjal001 LIKE gzjal_t.gzjal001
   DEFINE lc_gzjal002 LIKE gzjal_t.gzjal002
   DEFINE lc_gzjal003 LIKE gzjal_t.gzjal003
   DEFINE li_row      LIKE type_t.num10
   DEFINE lc_msg      STRING

   
   LET ls_sql = "SELECT gzjal001,gzjal002,gzjal003 FROM gzjal_t ",
                " WHERE gzjal002 = 'zh_TW' OR gzjal002 = 'zh_CN' ",
                " ORDER BY gzjal001,gzjal002"
   LET li_cnt = 1 
                
   DECLARE azzp110_gzjal_twcn_cs CURSOR FROM ls_sql
   FOREACH azzp110_gzjal_twcn_cs INTO lc_gzjal001,lc_gzjal002,lc_gzjal003
      DISPLAY "check tw_cn gzjal_t:",lc_gzjal001
      IF cl_null(lc_gzjal003) THEN
         CONTINUE FOREACH
      END IF
      CALL azzp110_trim(lc_gzjal003) RETURNING lc_gzjal003
      IF NOT cl_chk_tworcn(lc_gzjal002 CLIPPED,lc_gzjal003 CLIPPED,0) THEN
         DISPLAY li_cnt," Error Translate-lc_gzjal001:",lc_gzjal001,"   lc_gzjal002:",lc_gzjal002,
                        "   lc_gzjal003:",lc_gzjal003
         LET li_cnt = li_cnt + 1
                        
         LET lc_msg = "<tr hieght=22><td class=xl24>gzjal_t</td>",                      #檢查檔案
                                    "<td class=xl24>",lc_gzjal001,"</td>",              #key欄位1
                                    "<td class=xl24></td>",                             #key欄位2
                                    "<td class=xl24></td>",                             #key欄位3
                                    "<td class=xl24>",lc_gzjal002,"</td>",              #檢查語系
                                    "<td class=xl24>",lc_gzjal003,"</td>",              #原始字串
                      "</tr>"

         CALL g_gen_ch.writeLine(lc_msg)
      END IF
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_chk_gztdl_twcn()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_chk_gztdl_twcn()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_gztdl001 LIKE gztdl_t.gztdl001
   DEFINE lc_gztdl002 LIKE gztdl_t.gztdl002
   DEFINE lc_gztdl003 LIKE gztdl_t.gztdl003
   DEFINE lc_gztdl004 LIKE gztdl_t.gztdl004
   DEFINE li_row      LIKE type_t.num10
   DEFINE lc_msg      STRING


   LET ls_sql = "SELECT gztdl001,gztdl002,gztdl003,gztdl004 FROM gztdl_t ",
                " WHERE gztdl002 = 'zh_TW' OR gztdl002 = 'zh_CN' ",
                " ORDER BY gztdl001,gztdl002"
   LET li_cnt = 1

   DECLARE azzp110_gztdl_twcn_cs CURSOR FROM ls_sql
   FOREACH azzp110_gztdl_twcn_cs INTO lc_gztdl001,lc_gztdl002,lc_gztdl003,lc_gztdl004
      DISPLAY "check tw_cn gztdl_t:",lc_gztdl001
      IF cl_null(lc_gztdl003) THEN
         CONTINUE FOREACH
      END IF
      CALL azzp110_trim(lc_gztdl003) RETURNING lc_gztdl003
      IF NOT cl_chk_tworcn(lc_gztdl002 CLIPPED,lc_gztdl003 CLIPPED,0) THEN
         DISPLAY li_cnt," Error Translate-lc_gztdl001:",lc_gztdl001,"   lc_gztdl002:",lc_gztdl002,
                        "   lc_gztdl003:",lc_gztdl003
         LET li_cnt = li_cnt + 1
                        
         LET lc_msg = "<tr hieght=22><td class=xl24>gztdl_t</td>",                      #檢查檔案
                                    "<td class=xl24>",lc_gztdl001,"</td>",              #key欄位1
                                    "<td class=xl24></td>",                             #key欄位2
                                    "<td class=xl24></td>",                             #key欄位3
                                    "<td class=xl24>",lc_gztdl002,"</td>",              #檢查語系
                                    "<td class=xl24>",lc_gztdl003,"</td>",              #原始字串
                      "</tr>"

         CALL g_gen_ch.writeLine(lc_msg)
      END IF
      
      CALL azzp110_trim(lc_gztdl004) RETURNING lc_gztdl004
      IF NOT cl_chk_tworcn(lc_gztdl002 CLIPPED,lc_gztdl004 CLIPPED,0) THEN
         DISPLAY li_cnt," Error Translate-lc_gztdl001:",lc_gztdl001,"   lc_gztdl002:",lc_gztdl002,
                        "   lc_gztdl004:",lc_gztdl004
         LET li_cnt = li_cnt + 1

         LET lc_msg = "<tr hieght=22><td class=xl24>gztdl_t</td>",                      #檢查檔案
                                    "<td class=xl24>",lc_gztdl001,"</td>",              #key欄位1
                                    "<td class=xl24></td>",                             #key欄位2
                                    "<td class=xl24></td>",                             #key欄位3
                                    "<td class=xl24>",lc_gztdl002,"</td>",              #檢查語系
                                    "<td class=xl24>",lc_gztdl004,"</td>",              #原始字串
                      "</tr>"

         CALL g_gen_ch.writeLine(lc_msg)
      END IF
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_chk_gztel_twcn()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_chk_gztel_twcn()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_gztel001 LIKE gztel_t.gztel001
   DEFINE lc_gztel002 LIKE gztel_t.gztel002
   DEFINE lc_gztel003 LIKE gztel_t.gztel003
   DEFINE li_row      LIKE type_t.num10
   DEFINE lc_msg      STRING


   LET ls_sql = "SELECT gztel001,gztel002,gztel003 FROM gztel_t ",
                " WHERE gztel002 = 'zh_TW' OR gztel002 = 'zh_CN' ",
                " ORDER BY gztel001,gztel002"
   LET li_cnt = 1

   DECLARE azzp110_gztel_twcn_cs CURSOR FROM ls_sql
   FOREACH azzp110_gztel_twcn_cs INTO lc_gztel001,lc_gztel002,lc_gztel003
      DISPLAY "check tw_cn gztel_t:",lc_gztel001
      IF cl_null(lc_gztel003) THEN
         CONTINUE FOREACH
      END IF
      CALL azzp110_trim(lc_gztel003) RETURNING lc_gztel003
      IF NOT cl_chk_tworcn(lc_gztel002 CLIPPED,lc_gztel003 CLIPPED,0) THEN
         DISPLAY li_cnt," Error Translate-lc_gztel001:",lc_gztel001,"   lc_gztel002:",lc_gztel002,
                        "   lc_gztel003:",lc_gztel003
         LET li_cnt = li_cnt + 1
                        
         LET lc_msg = "<tr hieght=22><td class=xl24>gztel_t</td>",                      #檢查檔案
                                    "<td class=xl24>",lc_gztel001,"</td>",              #key欄位1
                                    "<td class=xl24></td>",                             #key欄位2
                                    "<td class=xl24></td>",                             #key欄位3
                                    "<td class=xl24>",lc_gztel002,"</td>",              #檢查語系
                                    "<td class=xl24>",lc_gztel003,"</td>",              #原始字串
                      "</tr>"

         CALL g_gen_ch.writeLine(lc_msg)
      END IF
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_chk_gzzol_twcn()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_chk_gzzol_twcn()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_gzzol001 LIKE gzzol_t.gzzol001
   DEFINE lc_gzzol002 LIKE gzzol_t.gzzol002
   DEFINE lc_gzzol003 LIKE gzzol_t.gzzol003
   DEFINE li_row      LIKE type_t.num10
   DEFINE lc_msg      STRING


   LET ls_sql = "SELECT gzzol001,gzzol002,gzzol003 FROM gzzol_t ",
                " WHERE gzzol002 = 'zh_TW' OR gzzol002 = 'zh_CN' ",
                " ORDER BY gzzol001,gzzol002"
   LET li_cnt = 1

   DECLARE azzp110_gzzol_twcn_cs CURSOR FROM ls_sql
   FOREACH azzp110_gzzol_twcn_cs INTO lc_gzzol001,lc_gzzol002,lc_gzzol003
      DISPLAY "check tw_cn gzzol_t:",lc_gzzol001
      IF cl_null(lc_gzzol003) THEN
         CONTINUE FOREACH
      END IF
      CALL azzp110_trim(lc_gzzol003) RETURNING lc_gzzol003
      IF NOT cl_chk_tworcn(lc_gzzol002 CLIPPED,lc_gzzol003 CLIPPED,0) THEN
         DISPLAY li_cnt," Error Translate-lc_gzzol001:",lc_gzzol001,"   lc_gzzol002:",lc_gzzol002,
                        "   lc_gzzol003:",lc_gzzol003
         LET li_cnt = li_cnt + 1
         
         LET lc_msg = "<tr hieght=22><td class=xl24>gzzol_t</td>",                      #檢查檔案
                                    "<td class=xl24>",lc_gzzol001,"</td>",              #key欄位1
                                    "<td class=xl24></td>",                             #key欄位2
                                    "<td class=xl24></td>",                             #key欄位3
                                    "<td class=xl24>",lc_gzzol002,"</td>",              #檢查語系
                                    "<td class=xl24>",lc_gzzol003,"</td>",              #原始字串
                      "</tr>"

         CALL g_gen_ch.writeLine(lc_msg)
      END IF
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_chk_gzzf_twcn()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_chk_gzzf_twcn()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_gzzf001 LIKE gzzf_t.gzzf001
   DEFINE lc_gzzf002 LIKE gzzf_t.gzzf002
   DEFINE lc_gzzf003 LIKE gzzf_t.gzzf003
   DEFINE lc_gzzf005 LIKE gzzf_t.gzzf005
   DEFINE lc_gzzf006 LIKE gzzf_t.gzzf006
   DEFINE li_row      LIKE type_t.num10
   DEFINE lc_msg      STRING


   LET ls_sql = "SELECT gzzf001,gzzf002,gzzf003,gzzf005,gzzf006 FROM gzzf_t ",
                " WHERE gzzf002 = 'zh_TW' OR gzzf002 = 'zh_CN' ",
                " ORDER BY gzzf001,gzzf003"
   LET li_cnt = 1

   DECLARE azzp110_gzzf_twcn_cs CURSOR FROM ls_sql
   FOREACH azzp110_gzzf_twcn_cs INTO lc_gzzf001,lc_gzzf002,lc_gzzf003,lc_gzzf005,lc_gzzf006
      DISPLAY "check tw_cn gzzf_t:",lc_gzzf001
      IF cl_null(lc_gzzf005) THEN
         CONTINUE FOREACH
      END IF
      CALL azzp110_trim(lc_gzzf005) RETURNING lc_gzzf005
      IF NOT cl_chk_tworcn(lc_gzzf002 CLIPPED,lc_gzzf005 CLIPPED,0) THEN
         DISPLAY li_cnt," Error Translate-lc_gzzf001:",lc_gzzf001,"   lc_gzzf002:",lc_gzzf002,
                        "   lc_gzzf003:",lc_gzzf003,"   lc_gzzf005:",lc_gzzf005
         LET li_cnt = li_cnt + 1

         LET lc_msg = "<tr hieght=22><td class=xl24>gzzf_t</td>",                      #檢查檔案
                                    "<td class=xl24>",lc_gzzf001,"</td>",              #key欄位1
                                    "<td class=xl24>",lc_gzzf003,"</td>",              #key欄位2
                                    "<td class=xl24></td>",                            #key欄位3
                                    "<td class=xl24>",lc_gzzf002,"</td>",              #檢查語系
                                    "<td class=xl24>",lc_gzzf005,"</td>",              #原始字串
                      "</tr>"

         CALL g_gen_ch.writeLine(lc_msg)
      END IF
      
      CALL azzp110_trim(lc_gzzf006) RETURNING lc_gzzf006
      IF NOT cl_chk_tworcn(lc_gzzf002 CLIPPED,lc_gzzf006 CLIPPED,0) THEN
         DISPLAY li_cnt," Error Translate-lc_gzzf001:",lc_gzzf001,"   lc_gzzf002:",lc_gzzf002,
                        "   lc_gzzf003:",lc_gzzf003,"   lc_gzzf006:",lc_gzzf006
         LET li_cnt = li_cnt + 1

         LET lc_msg = "<tr hieght=22><td class=xl24>gzzf_t</td>",                      #檢查檔案
                                    "<td class=xl24>",lc_gzzf001,"</td>",              #key欄位1
                                    "<td class=xl24>",lc_gzzf003,"</td>",              #key欄位2
                                    "<td class=xl24></td>",                            #key欄位3
                                    "<td class=xl24>",lc_gzzf002,"</td>",              #檢查語系
                                    "<td class=xl24>",lc_gzzf006,"</td>",              #原始字串
                      "</tr>"

         CALL g_gen_ch.writeLine(lc_msg)
      END IF
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_exp_gzdel()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_exp_gzdel()
   DEFINE ls_sql STRING
   DEFINE ls_sql_gzoz STRING
   DEFINE la_gzzy DYNAMIC ARRAY OF RECORD
             gzzy001 LIKE gzzy_t.gzzy001, #語言別
             gzozcol LIKE type_t.chr10    #語言別欄位
                  END RECORD
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE lc_gzdel001     LIKE gzdel_t.gzdel001
   DEFINE lc_gzdel003_tw  LIKE gzdel_t.gzdel003
   DEFINE lc_gzdel003_old LIKE gzdel_t.gzdel003
   DEFINE lc_gzdel003_new LIKE gzdel_t.gzdel003
   DEFINE lc_count        LIKE type_t.num5
   DEFINE lc_msg          STRING
   DEFINE lc_update       LIKE type_t.chr1
   DEFINE lc_item1        STRING
   DEFINE lc_item2        STRING


   #若是多語言暫存檔有資料的話，要先做暫存檔轉換的部分
   #否則後續用已更新後的字典檔再去對應各多語言檔的話，怕會有缺漏
   IF gs_trans_temp = "Y" THEN
      LET ls_sql = "SELECT gzdel001,gzdel003 FROM gzdel_t WHERE gzdel002 = 'zh_TW' ORDER BY gzdel001"

      DECLARE azzp110_trans_temp_to_gzdel_cs CURSOR FROM ls_sql
      FOREACH azzp110_trans_temp_to_gzdel_cs INTO lc_gzdel001,lc_gzdel003_old
         DISPLAY "check gzos_t  lc_gzdel001:",lc_gzdel001
         #檢查過單號是否已超過筆數
      #   CALL azzp110_chk_dzld_rows()
      #   IF NOT g_chk_status THEN
      #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
      #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
      #      CALL g_gen_ch.writeLine(lc_msg)
      #      RETURN
      #   END IF
         
         #從多語言暫存檔找出該語言別資料
         EXECUTE azzp110_get_gzos_cs USING lc_gzdel003_old INTO lc_gzdel003_new
         
         IF NOT SQLCA.SQLCODE AND NOT cl_null(lc_gzdel003_new) THEN
            #填寫過單資訊，需檢核是否存在主檔中
            LET lc_count = 0
            LET lc_item1 = "NULL"
            LET lc_item2 = "NULL"
            SELECT COUNT(1) INTO lc_count FROM gzde_t
             WHERE gzde001 = lc_gzdel001
            IF lc_count > 0 THEN
            #   IF NOT azzp110_insert_dzld('gzdel_t','azzi901',lc_gzdel001,' ') THEN
            #      LET g_chk_status = FALSE
            #      RETURN
            #   END IF
               LET lc_item1 = "azzi901"
               LET lc_item2 = lc_gzdel001
            END IF
            
            UPDATE gzdel_t SET gzdel003 = lc_gzdel003_new
             WHERE gzdel001 = lc_gzdel001 AND gzdel002 = "zh_TW"

            IF SQLCA.SQLCODE THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)gzdel_t失敗...  gzdel001:",lc_gzdel001,"  gzdel002:zh_TW","  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
               CALL g_gen_ch.writeLine(lc_msg)
               RETURN
            END IF

            #紀錄log
            LET lc_msg = "<tr hieght=22><td class=xl24>zh_TW</td>",                #更換語系
                                       "<td class=xl24>gzdel_t</td>",              #更換的多語言table
                                       "<td class=xl24>",g_param.docno,"</td>",    #表單單號
                                       "<td class=xl24>",g_param.seq,"</td>",      #項次
                                       "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                       "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                       "<td class=xl24>",lc_gzdel003_old,"</td>",  #資料修改前
                                       "<td class=xl24>",lc_gzdel003_new,"</td>",  #資料修改後
                         "</tr>"
            CALL g_gen_ch.writeLine(lc_msg)
         END IF
      END FOREACH
   END IF
   
   ########開始進行字典檔匯出至多語言檔的動作##########
   LET ls_sql = "SELECT gzdel001,gzdel003 FROM gzdel_t WHERE gzdel002 = 'zh_TW' ORDER BY gzdel001"

   #取出語言種類與項目
   LET la_gzzy = azzp110_get_gzzy() #除了zh_TW 之外

   DECLARE exp_gzdel_cs CURSOR FROM ls_sql
   FOREACH exp_gzdel_cs INTO lc_gzdel001,lc_gzdel003_tw
      DISPLAY "check gzoz_t  lc_gzdel001:",lc_gzdel001
      #跑單身陣列
      FOR li_cnt = 1 TO la_gzzy.getLength()
         LET lc_update = "N"
         
         #字典檔找出該語言別資料
         LET ls_sql_gzoz = "SELECT ",la_gzzy[li_cnt].gzozcol CLIPPED,
                            " FROM gzoz_t WHERE gzoz000= '",lc_gzdel003_tw CLIPPED,"' "
         PREPARE azzp110_exp_gzde_pre FROM ls_sql_gzoz
         EXECUTE azzp110_exp_gzde_pre INTO lc_gzdel003_new
         #如果有資料且該筆資料不是null
         #然後判斷該語言別是否有資料 沒有資料就insert 有資料確認該筆資料是否是null，是就update
         #160303 改為以字典檔為主，若在字典檔有找到且非空白，就一律更新
         IF NOT SQLCA.SQLCODE AND NOT cl_null(lc_gzdel003_new) THEN
            #檢查過單號是否已超過筆數
         #   CALL azzp110_chk_dzld_rows()
         #   IF NOT g_chk_status THEN
         #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
         #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
         #   CALL g_gen_ch.writeLine(lc_msg)
         #      RETURN
         #   END IF

            LET lc_gzdel003_old = ""
            SELECT gzdel003 INTO lc_gzdel003_old FROM gzdel_t
             WHERE gzdel001 = lc_gzdel001
               AND gzdel002 = la_gzzy[li_cnt].gzzy001
            IF SQLCA.SQLCODE THEN
               #填寫過單資訊，需檢核是否存在主檔中
               LET lc_count = 0
               LET lc_item1 = "NULL"
               LET lc_item2 = "NULL"
               SELECT COUNT(1) INTO lc_count FROM gzde_t
                WHERE gzde001 = lc_gzdel001
               IF lc_count > 0 THEN
               #   IF NOT azzp110_insert_dzld('gzdel_t','azzi901',lc_gzdel001,' ') THEN
               #      LET g_chk_status = FALSE
               #      RETURN
               #   END IF
                  LET lc_item1 = "azzi901"
                  LET lc_item2 = lc_gzdel001
               END IF
            
               INSERT INTO gzdel_t(gzdel001,gzdel002,gzdel003)
                 VALUES(lc_gzdel001,la_gzzy[li_cnt].gzzy001,lc_gzdel003_new)
               
               IF SQLCA.SQLCODE THEN
                  LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(insert)gzdel_t失敗...  gzdel001:",lc_gzdel001,"  gzdel002:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                  CALL g_gen_ch.writeLine(lc_msg)
                  RETURN
               END IF
               LET lc_update = "Y"
            ELSE
               IF la_gzzy[li_cnt].gzzy001<> 'zh_TW' AND lc_gzdel003_new <> lc_gzdel003_old THEN
                  #填寫過單資訊，需檢核是否存在主檔中
                  LET lc_count = 0
                  LET lc_item1 = "NULL"
                  LET lc_item2 = "NULL"
                  SELECT COUNT(1) INTO lc_count FROM gzde_t
                   WHERE gzde001 = lc_gzdel001
                  IF lc_count > 0 THEN
                  #   IF NOT azzp110_insert_dzld('gzdel_t','azzi901',lc_gzdel001,' ') THEN
                  #      LET g_chk_status = FALSE
                  #      RETURN
                  #   END IF
                     LET lc_item1 = "azzi901"
                     LET lc_item2 = lc_gzdel001
                  END IF
            
                  UPDATE gzdel_t SET gzdel003 = lc_gzdel003_new
                   WHERE gzdel001 = lc_gzdel001 AND gzdel002 = la_gzzy[li_cnt].gzzy001
                  
                  IF SQLCA.SQLCODE THEN
                     LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)gzdel_t失敗...  gzdel001:",lc_gzdel001,"  gzdel002:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                     CALL g_gen_ch.writeLine(lc_msg)
                     RETURN
                  END IF
                  LET lc_update = "Y"
               END IF
            END IF
            
            IF lc_update = "Y" THEN
               #紀錄log
               LET lc_msg = "<tr hieght=22><td class=xl24>",la_gzzy[li_cnt].gzzy001,"</td>",   #更換語系
                                          "<td class=xl24>gzdel_t</td>",              #更換的多語言table
                                          "<td class=xl24>",g_param.docno,"</td>",    #表單單號
                                          "<td class=xl24>",g_param.seq,"</td>",      #項次
                                          "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                          "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                          "<td class=xl24>",lc_gzdel003_old,"</td>",  #資料修改前
                                          "<td class=xl24>",lc_gzdel003_new,"</td>",  #資料修改後
                            "</tr>"
        
               CALL g_gen_ch.writeLine(lc_msg)
            END IF
         END IF
         FREE azzp110_exp_gzde_pre
      END FOR

   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_exp_gzhal()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_exp_gzhal()
   DEFINE ls_sql STRING
   DEFINE ls_sql_gzoz STRING
   DEFINE la_gzzy DYNAMIC ARRAY OF RECORD
             gzzy001 LIKE gzzy_t.gzzy001, #語言別
             gzozcol LIKE type_t.chr10    #語言別欄位
                  END RECORD
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE lc_gzhal001     LIKE gzhal_t.gzhal001
   DEFINE lc_gzhal003_tw  LIKE gzhal_t.gzhal003
   DEFINE lc_gzhal003_old LIKE gzhal_t.gzhal003
   DEFINE lc_gzhal003_new LIKE gzhal_t.gzhal003
   DEFINE lc_count        LIKE type_t.num5
   DEFINE lc_msg          STRING
   DEFINE lc_update       LIKE type_t.chr1
   DEFINE lc_item1        STRING
   DEFINE lc_item2        STRING
   
   
   #若是多語言暫存檔有資料的話，要先做暫存檔轉換的部分
   #否則後續用已更新後的字典檔再去對應各多語言檔的話，怕會有缺漏
   IF gs_trans_temp = "Y" THEN
      LET ls_sql = "SELECT gzhal001,gzhal003 FROM gzhal_t WHERE gzhal002 = 'zh_TW' ORDER BY gzhal001"

      DECLARE azzp110_trans_temp_to_gzhal_cs CURSOR FROM ls_sql
      FOREACH azzp110_trans_temp_to_gzhal_cs INTO lc_gzhal001,lc_gzhal003_old
         DISPLAY "check gzos_t  lc_gzhal001:",lc_gzhal001
         #檢查過單號是否已超過筆數
      #   CALL azzp110_chk_dzld_rows()
      #   IF NOT g_chk_status THEN
      #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
      #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
      #      CALL g_gen_ch.writeLine(lc_msg)
      #      RETURN
      #   END IF
         
         #從多語言暫存檔找出該語言別資料
         LET lc_gzhal003_new = ""
         EXECUTE azzp110_get_gzos_cs USING lc_gzhal003_old INTO lc_gzhal003_new

         IF NOT SQLCA.SQLCODE AND NOT cl_null(lc_gzhal003_new) THEN
            #填寫過單資訊，需檢核是否存在主檔中
            LET lc_count = 0
            LET lc_item1 = "NULL"
            LET lc_item2 = "NULL"
            SELECT COUNT(1) INTO lc_count FROM gzha_t
             WHERE gzha001 = lc_gzhal001
            IF lc_count > 0 THEN
            #   IF NOT azzp110_insert_dzld('gzhal_t','azzi030',lc_gzhal001,' ') THEN
            #      LET g_chk_status = FALSE
            #      RETURN
            #   END IF
               LET lc_item1 = "azzi030"
               LET lc_item2 = lc_gzhal001
            END IF
            
            UPDATE gzhal_t SET gzhal003 = lc_gzhal003_new
             WHERE gzhal001 = lc_gzhal001 AND gzhal002 = "zh_TW"

            IF SQLCA.SQLCODE THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)gzhal_t失敗...  gzhal001:",lc_gzhal001,"  gzhal002:zh_TW","  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
               CALL g_gen_ch.writeLine(lc_msg)
               RETURN
            END IF
 
            #紀錄log
            LET lc_msg = "<tr hieght=22><td class=xl24>zh_TW</td>",                #更換語系
                                       "<td class=xl24>gzhal_t</td>",              #更換的多語言table
                                       "<td class=xl24>",g_param.docno,"</td>",    #表單單號
                                       "<td class=xl24>",g_param.seq,"</td>",      #項次
                                       "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                       "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                       "<td class=xl24>",lc_gzhal003_old,"</td>",  #資料修改前
                                       "<td class=xl24>",lc_gzhal003_new,"</td>",  #資料修改後
                         "</tr>"

            CALL g_gen_ch.writeLine(lc_msg)
         END IF
      END FOREACH
   END IF
   
   ########開始進行字典檔匯出至多語言檔的動作##########
   LET ls_sql = "SELECT gzhal001,gzhal003 FROM gzhal_t WHERE gzhal002 = 'zh_TW' ORDER BY gzhal001"

   #取出語言種類與項目
   LET la_gzzy = azzp110_get_gzzy() #除了zh_TW 之外

   DECLARE exp_gzhal_cs CURSOR FROM ls_sql
   FOREACH exp_gzhal_cs INTO lc_gzhal001,lc_gzhal003_tw
      DISPLAY "check gzoz_t  lc_gzhal001:",lc_gzhal001
      #跑單身陣列
      FOR li_cnt = 1 TO la_gzzy.getLength()
         LET lc_update = "N"
         
         #字典檔找出該語言別資料
         LET lc_gzhal003_new = ""
         LET ls_sql_gzoz = "SELECT ",la_gzzy[li_cnt].gzozcol CLIPPED,
                            " FROM gzoz_t WHERE gzoz000= '",lc_gzhal003_tw CLIPPED,"' "
         PREPARE azzp110_exp_gzhal_pre FROM ls_sql_gzoz
         EXECUTE azzp110_exp_gzhal_pre INTO lc_gzhal003_new
         #如果有資料且該筆資料不是null
         #然後判斷該語言別是否有資料 沒有資料就insert 有資料確認該筆資料是否是null，是就update
         #160303 改為以字典檔為主，若在字典檔有找到且非空白，就一律更新
         IF NOT SQLCA.SQLCODE AND NOT cl_null(lc_gzhal003_new) THEN
            #檢查過單號是否已超過筆數
         #   CALL azzp110_chk_dzld_rows()
         #   IF NOT g_chk_status THEN
         #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
         #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
         #   CALL g_gen_ch.writeLine(lc_msg)
         #      RETURN
         #   END IF

            LET lc_gzhal003_old = ""
            SELECT gzhal003 INTO lc_gzhal003_old FROM gzhal_t
             WHERE gzhal001 = lc_gzhal001
               AND gzhal002 = la_gzzy[li_cnt].gzzy001
            IF SQLCA.SQLCODE THEN
               #填寫過單資訊，需檢核是否存在主檔中
               LET lc_count = 0
               LET lc_item1 = "NULL"
               LET lc_item2 = "NULL"
               SELECT COUNT(1) INTO lc_count FROM gzha_t
                WHERE gzha001 = lc_gzhal001
               IF lc_count > 0 THEN
               #   IF NOT azzp110_insert_dzld('gzhal_t','azzi030',lc_gzhal001,' ') THEN
               #      LET g_chk_status = FALSE
               #      RETURN
               #   END IF
                  LET lc_item1 = "azzi030"
                  LET lc_item2 = lc_gzhal001
               END IF
               
               INSERT INTO gzhal_t(gzhal001,gzhal002,gzhal003)
                 VALUES(lc_gzhal001,la_gzzy[li_cnt].gzzy001,lc_gzhal003_new)
               
               IF SQLCA.SQLCODE THEN
                  LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(insert)gzhal_t失敗...  gzhal001:",lc_gzhal001,"  gzhal002:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                  CALL g_gen_ch.writeLine(lc_msg)
                  RETURN
               END IF
               LET lc_update = "Y"
            ELSE
               IF la_gzzy[li_cnt].gzzy001 <> 'zh_TW' AND lc_gzhal003_new <> lc_gzhal003_old THEN
                  #填寫過單資訊，需檢核是否存在主檔中
                  LET lc_count = 0
                  LET lc_item1 = "NULL"
                  LET lc_item2 = "NULL"
                  SELECT COUNT(1) INTO lc_count FROM gzha_t
                   WHERE gzha001 = lc_gzhal001
                  IF lc_count > 0 THEN
                  #   IF NOT azzp110_insert_dzld('gzhal_t','azzi030',lc_gzhal001,' ') THEN
                  #      LET g_chk_status = FALSE
                  #      RETURN
                  #   END IF
                     LET lc_item1 = "azzi030"
                     LET lc_item2 = lc_gzhal001
                  END IF
            
                  UPDATE gzhal_t SET gzhal003 = lc_gzhal003_new
                   WHERE gzhal001 = lc_gzhal001 AND gzhal002 = la_gzzy[li_cnt].gzzy001
                  
                  IF SQLCA.SQLCODE THEN
                     LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)gzhal_t失敗...  gzhal001:",lc_gzhal001,"  gzhal002:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                     CALL g_gen_ch.writeLine(lc_msg)
                     RETURN
                  END IF
                  LET lc_update = "Y"
               END IF
            END IF
            
            IF lc_update = "Y" THEN
               #紀錄log
               LET lc_msg = "<tr hieght=22><td class=xl24>",la_gzzy[li_cnt].gzzy001,"</td>",   #更換語系
                                          "<td class=xl24>gzhal_t</td>",              #更換的多語言table
                                          "<td class=xl24>",g_param.docno,"</td>",    #表單單號
                                          "<td class=xl24>",g_param.seq,"</td>",      #項次
                                          "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                          "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                          "<td class=xl24>",lc_gzhal003_old,"</td>",  #資料修改前
                                          "<td class=xl24>",lc_gzhal003_new,"</td>",  #資料修改後
                            "</tr>"
        
               CALL g_gen_ch.writeLine(lc_msg)
            END IF
         END IF
         FREE azzp110_exp_gzhal_pre
      END FOR

   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_exp_gzial()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_exp_gzial()
   DEFINE ls_sql STRING
   DEFINE ls_sql_gzoz STRING
   DEFINE la_gzzy DYNAMIC ARRAY OF RECORD
             gzzy001 LIKE gzzy_t.gzzy001, #語言別
             gzozcol LIKE type_t.chr10    #語言別欄位
                  END RECORD
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE lc_gzial001     LIKE gzial_t.gzial001
   DEFINE lc_gzial003_tw  LIKE gzial_t.gzial003
   DEFINE lc_gzial003_old LIKE gzial_t.gzial003
   DEFINE lc_gzial003_new LIKE gzial_t.gzial003
   DEFINE lc_count        LIKE type_t.num5
   DEFINE lc_msg          STRING
   DEFINE lc_update       LIKE type_t.chr1
   DEFINE lc_item1        STRING
   DEFINE lc_item2        STRING
   
   
   #若是多語言暫存檔有資料的話，要先做暫存檔轉換的部分
   #否則後續用已更新後的字典檔再去對應各多語言檔的話，怕會有缺漏
   IF gs_trans_temp = "Y" THEN
      LET ls_sql = "SELECT gzial001,gzial003 FROM gzial_t WHERE gzial002 = 'zh_TW' ORDER BY gzial001"

      DECLARE azzp110_trans_temp_to_gzial_cs CURSOR FROM ls_sql
      FOREACH azzp110_trans_temp_to_gzial_cs INTO lc_gzial001,lc_gzial003_old
         DISPLAY "check gzos_t  lc_gzial001:",lc_gzial001
         #檢查過單號是否已超過筆數
      #   CALL azzp110_chk_dzld_rows()
      #   IF NOT g_chk_status THEN
      #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
      #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
      #      CALL g_gen_ch.writeLine(lc_msg)
      #      RETURN
      #   END IF
         
         #從多語言暫存檔找出該語言別資料
         LET lc_gzial003_new = ""
         EXECUTE azzp110_get_gzos_cs USING lc_gzial003_old INTO lc_gzial003_new

         IF NOT SQLCA.SQLCODE AND NOT cl_null(lc_gzial003_new) THEN
            #填寫過單資訊，需檢核是否存在主檔中
            LET lc_count = 0
            LET lc_item1 = "NULL"
            LET lc_item2 = "NULL"
            SELECT COUNT(1) INTO lc_count FROM gzia_t
             WHERE gzia001 = lc_gzial001
            IF lc_count > 0 THEN
            #   IF NOT azzp110_insert_dzld('gzial_t','azzi310',lc_gzial001,' ') THEN
            #      LET g_chk_status = FALSE
            #      RETURN
            #   END IF
               LET lc_item1 = "azzi310"
               LET lc_item2 = lc_gzial001
            END IF
            
            UPDATE gzial_t SET gzial003 = lc_gzial003_new
             WHERE gzial001 = lc_gzial001 AND gzial002 = "zh_TW"

            IF SQLCA.SQLCODE THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)gzial_t失敗...  gzial001:",lc_gzial001,"  gzial002:zh_TW","  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
               CALL g_gen_ch.writeLine(lc_msg)
               RETURN
            END IF

            #紀錄log
            LET lc_msg = "<tr hieght=22><td class=xl24>zh_TW</td>",                #更換語系
                                       "<td class=xl24>gzial_t</td>",              #更換的多語言table
                                       "<td class=xl24>",g_param.docno,"</td>",    #表單單號
                                       "<td class=xl24>",g_param.seq,"</td>",      #項次
                                       "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                       "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                       "<td class=xl24>",lc_gzial003_old,"</td>",  #資料修改前
                                       "<td class=xl24>",lc_gzial003_new,"</td>",  #資料修改後
                         "</tr>"

            CALL g_gen_ch.writeLine(lc_msg)
         END IF
      END FOREACH
   END IF

   ########開始進行字典檔匯出至多語言檔的動作##########
   LET ls_sql = "SELECT gzial001,gzial003 FROM gzial_t WHERE gzial002 = 'zh_TW' ORDER BY gzial001"
   
   #取出語言種類與項目
   LET la_gzzy = azzp110_get_gzzy() #除了zh_TW 之外

   DECLARE exp_gzial_cs CURSOR FROM ls_sql
   FOREACH exp_gzial_cs INTO lc_gzial001,lc_gzial003_tw
      DISPLAY "check gzoz_t  lc_gzial001:",lc_gzial001
      #跑單身陣列
      FOR li_cnt = 1 TO la_gzzy.getLength()
         LET lc_update = "N"
         
         #字典檔找出該語言別資料
         LET lc_gzial003_new = ""
         LET ls_sql_gzoz = "SELECT ",la_gzzy[li_cnt].gzozcol CLIPPED,
                            " FROM gzoz_t WHERE gzoz000= '",lc_gzial003_tw CLIPPED,"' "
         PREPARE azzp110_exp_gzial_pre FROM ls_sql_gzoz
         EXECUTE azzp110_exp_gzial_pre INTO lc_gzial003_new
         #如果有資料且該筆資料不是null
         #然後判斷該語言別是否有資料 沒有資料就insert 有資料確認該筆資料是否是null，是就update
         #160303 改為以字典檔為主，若在字典檔有找到且非空白，就一律更新
         IF NOT SQLCA.SQLCODE AND NOT cl_null(lc_gzial003_new) THEN
            #檢查過單號是否已超過筆數
         #   CALL azzp110_chk_dzld_rows()
         #   IF NOT g_chk_status THEN
         #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
         #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
         #   CALL g_gen_ch.writeLine(lc_msg)
         #      RETURN
         #   END IF

            LET lc_gzial003_old = ""
            SELECT gzial003 INTO lc_gzial003_old FROM gzial_t
             WHERE gzial001 = lc_gzial001
               AND gzial002 = la_gzzy[li_cnt].gzzy001
            IF SQLCA.SQLCODE THEN
               #填寫過單資訊，需檢核是否存在主檔中
               LET lc_count = 0
               LET lc_item1 = "NULL"
               LET lc_item2 = "NULL"
               SELECT COUNT(1) INTO lc_count FROM gzia_t
                WHERE gzia001 = lc_gzial001
               IF lc_count > 0 THEN
               #   IF NOT azzp110_insert_dzld('gzial_t','azzi310',lc_gzial001,' ') THEN
               #      LET g_chk_status = FALSE
               #      RETURN
               #   END IF
                  LET lc_item1 = "azzi310"
                  LET lc_item2 = lc_gzial001
               END IF
            
               INSERT INTO gzial_t(gzial001,gzial002,gzial003)
                 VALUES(lc_gzial001,la_gzzy[li_cnt].gzzy001,lc_gzial003_new)
               
               IF SQLCA.SQLCODE THEN
                  LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(insert)gzial_t失敗...  gzial001:",lc_gzial001,"  gzial002:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                  CALL g_gen_ch.writeLine(lc_msg)
                  RETURN
               END IF
               LET lc_update = "Y"
            ELSE
               IF la_gzzy[li_cnt].gzzy001 <> 'zh_TW' AND lc_gzial003_new <> lc_gzial003_old THEN
                  #填寫過單資訊，需檢核是否存在主檔中
                  LET lc_count = 0
                  LET lc_item1 = "NULL"
                  LET lc_item2 = "NULL"
                  SELECT COUNT(1) INTO lc_count FROM gzia_t
                   WHERE gzia001 = lc_gzial001
                  IF lc_count > 0 THEN
                  #   IF NOT azzp110_insert_dzld('gzial_t','azzi310',lc_gzial001,' ') THEN
                  #      LET g_chk_status = FALSE
                  #      RETURN
                  #   END IF
                     LET lc_item1 = "azzi310"
                     LET lc_item2 = lc_gzial001
                  END IF
            
                  UPDATE gzial_t SET gzial003 = lc_gzial003_new
                   WHERE gzial001 = lc_gzial001 AND gzial002 = la_gzzy[li_cnt].gzzy001
                 
                  IF SQLCA.SQLCODE THEN
                     LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)gzial_t失敗...  gzial001:",lc_gzial001,"  gzial002:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                     CALL g_gen_ch.writeLine(lc_msg)
                     RETURN
                  END IF
                  LET lc_update = "Y"
               END IF
            END IF
            
            IF lc_update = "Y" THEN
               #紀錄log
               LET lc_msg = "<tr hieght=22><td class=xl24>",la_gzzy[li_cnt].gzzy001,"</td>",   #更換語系
                                          "<td class=xl24>gzial_t</td>",              #更換的多語言table
                                          "<td class=xl24>",g_param.docno,"</td>",    #表單單號
                                          "<td class=xl24>",g_param.seq,"</td>",      #項次
                                          "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                          "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                          "<td class=xl24>",lc_gzial003_old,"</td>",  #資料修改前
                                          "<td class=xl24>",lc_gzial003_new,"</td>",  #資料修改後
                            "</tr>"
       
               CALL g_gen_ch.writeLine(lc_msg)
            END IF
         END IF
         FREE azzp110_exp_gzial_pre
      END FOR

   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_exp_gzidl()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_exp_gzidl()
   DEFINE ls_sql STRING
   DEFINE ls_sql_gzoz STRING
   DEFINE la_gzzy DYNAMIC ARRAY OF RECORD
             gzzy001 LIKE gzzy_t.gzzy001, #語言別
             gzozcol LIKE type_t.chr10    #語言別欄位
                  END RECORD
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE lc_gzidl001     LIKE gzidl_t.gzidl001
   DEFINE lc_gzidl002     LIKE gzidl_t.gzidl002
   DEFINE lc_gzidl004_tw  LIKE gzidl_t.gzidl004
   DEFINE lc_gzidl004_old LIKE gzidl_t.gzidl004
   DEFINE lc_gzidl004_new LIKE gzidl_t.gzidl004
   DEFINE lc_count        LIKE type_t.num5
   DEFINE lc_msg          STRING
   DEFINE lc_update       LIKE type_t.chr1
   DEFINE lc_item1        STRING
   DEFINE lc_item2        STRING
   
   
   #若是多語言暫存檔有資料的話，要先做暫存檔轉換的部分
   #否則後續用已更新後的字典檔再去對應各多語言檔的話，怕會有缺漏
   IF gs_trans_temp = "Y" THEN
      LET ls_sql = "SELECT gzidl001,gzidl002,gzidl004 FROM gzidl_t ",
                   " WHERE gzidl003 = 'zh_TW' ORDER BY gzidl001"

      DECLARE azzp110_trans_temp_to_gzidl_cs CURSOR FROM ls_sql
      FOREACH azzp110_trans_temp_to_gzidl_cs INTO lc_gzidl001,lc_gzidl002,lc_gzidl004_old
         DISPLAY "check gzos_t  lc_gzidl001:",lc_gzidl001
         #檢查過單號是否已超過筆數
      #   CALL azzp110_chk_dzld_rows()
      #   IF NOT g_chk_status THEN
      #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
      #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
      #      CALL g_gen_ch.writeLine(lc_msg)
      #      RETURN
      #   END IF
         
         #從多語言暫存檔找出該語言別資料
         LET lc_gzidl004_new = ""
         EXECUTE azzp110_get_gzos_cs USING lc_gzidl004_old INTO lc_gzidl004_new

         IF NOT SQLCA.SQLCODE AND NOT cl_null(lc_gzidl004_new) THEN
            #填寫過單資訊，需檢核是否存在主檔中
            LET lc_count = 0
            LET lc_item1 = "NULL"
            LET lc_item2 = "NULL"
            SELECT COUNT(1) INTO lc_count FROM gzia_t
             WHERE gzia001 = lc_gzidl001
            IF lc_count > 0 THEN
            #   IF NOT azzp110_insert_dzld('gzidl_t','azzi310',lc_gzidl001,' ') THEN
            #      LET g_chk_status = FALSE
            #      RETURN
            #   END IF
               LET lc_item1 = "azzi310"
               LET lc_item2 = lc_gzidl001
            END IF
            
            UPDATE gzidl_t SET gzidl004 = lc_gzidl004_new
             WHERE gzidl001 = lc_gzidl001 AND gzidl002 = lc_gzidl002
               AND gzidl003 = "zh_TW"

            IF SQLCA.SQLCODE THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)gzidl_t失敗...  gzidl001:",lc_gzidl001,"  gzidl002:",lc_gzidl002,
                                                       "  gzidl003:zh_TW","  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
               CALL g_gen_ch.writeLine(lc_msg)
               RETURN
            END IF

            #紀錄log
            LET lc_msg = "<tr hieght=22><td class=xl24>zh_TW</td>",                #更換語系
                                       "<td class=xl24>gzidl_t</td>",              #更換的多語言table
                                       "<td class=xl24>",g_param.docno,"</td>",    #表單單號
                                       "<td class=xl24>",g_param.seq,"</td>",      #項次
                                       "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                       "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                       "<td class=xl24>",lc_gzidl004_old,"</td>",  #資料修改前
                                       "<td class=xl24>",lc_gzidl004_new,"</td>",  #資料修改後
                         "</tr>"

            CALL g_gen_ch.writeLine(lc_msg)
         END IF
      END FOREACH
   END IF
   
   ########開始進行字典檔匯出至多語言檔的動作##########
   LET ls_sql = "SELECT gzidl001,gzidl002,gzidl004 FROM gzidl_t ",
                " WHERE gzidl003 = 'zh_TW' ORDER BY gzidl001"

   #取出語言種類與項目
   LET la_gzzy = azzp110_get_gzzy() #除了zh_TW 之外

   DECLARE exp_gzidl_cs CURSOR FROM ls_sql
   FOREACH exp_gzidl_cs INTO lc_gzidl001,lc_gzidl004_tw
      DISPLAY "check gzoz_t  lc_gzidl001:",lc_gzidl001
      #跑單身陣列
      FOR li_cnt = 1 TO la_gzzy.getLength()
         LET lc_update = "N"
         
         #字典檔找出該語言別資料
         LET lc_gzidl004_new = ""
         LET ls_sql_gzoz = "SELECT ",la_gzzy[li_cnt].gzozcol CLIPPED,
                            " FROM gzoz_t WHERE gzoz000= '",lc_gzidl004_tw CLIPPED,"' "
         PREPARE azzp110_exp_gzidl_pre FROM ls_sql_gzoz
         EXECUTE azzp110_exp_gzidl_pre INTO lc_gzidl004_new
         #如果有資料且該筆資料不是null
         #然後判斷該語言別是否有資料 沒有資料就insert 有資料確認該筆資料是否是null，是就update
         #160303 改為以字典檔為主，若在字典檔有找到且非空白，就一律更新
         IF NOT SQLCA.SQLCODE AND NOT cl_null(lc_gzidl004_new) THEN
            #檢查過單號是否已超過筆數
         #   CALL azzp110_chk_dzld_rows()
         #   IF NOT g_chk_status THEN
         #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
         #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
         #   CALL g_gen_ch.writeLine(lc_msg)
         #      RETURN
         #   END IF

            LET lc_gzidl004_old = ""
            SELECT gzidl004 INTO lc_gzidl004_old FROM gzidl_t
             WHERE gzidl001 = lc_gzidl001 AND gzidl002 = lc_gzidl002
               AND gzidl003 = la_gzzy[li_cnt].gzzy001
            IF SQLCA.SQLCODE THEN
               #填寫過單資訊，需檢核是否存在主檔中
               LET lc_count = 0
               LET lc_item1 = "NULL"
               LET lc_item2 = "NULL"
               SELECT COUNT(1) INTO lc_count FROM gzia_t
                WHERE gzia001 = lc_gzidl001
               IF lc_count > 0 THEN
               #   IF NOT azzp110_insert_dzld('gzidl_t','azzi310',lc_gzidl001,' ') THEN
               #      LET g_chk_status = FALSE
               #      RETURN
               #   END IF
                  LET lc_item1 = "azzi310"
                  LET lc_item2 = lc_gzidl001
               END IF
            
               INSERT INTO gzidl_t(gzidl001,gzidl002,gzidl003,gzidl004)
                 VALUES(lc_gzidl001,lc_gzidl002,la_gzzy[li_cnt].gzzy001,lc_gzidl004_new)
               
               IF SQLCA.SQLCODE THEN
                  LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(insert)gzidl_t失敗...  gzidl001:",lc_gzidl001,"  gzidl002:",lc_gzidl002,
                                                          "  gzidl003:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                  CALL g_gen_ch.writeLine(lc_msg)
                  RETURN
               END IF
               LET lc_update = "Y"
            ELSE
               IF la_gzzy[li_cnt].gzzy001 <> 'zh_TW' AND lc_gzidl004_new <> lc_gzidl004_old THEN
                  #填寫過單資訊，需檢核是否存在主檔中
                  LET lc_count = 0
                  LET lc_item1 = "NULL"
                  LET lc_item2 = "NULL"
                  SELECT COUNT(1) INTO lc_count FROM gzia_t
                   WHERE gzia001 = lc_gzidl001
                  IF lc_count > 0 THEN
                  #   IF NOT azzp110_insert_dzld('gzidl_t','azzi310',lc_gzidl001,' ') THEN
                  #      LET g_chk_status = FALSE
                  #      RETURN
                  #   END IF
                     LET lc_item1 = "azzi310"
                     LET lc_item2 = lc_gzidl001
                  END IF
            
                  UPDATE gzidl_t SET gzidl004 = lc_gzidl004_new
                   WHERE gzidl001 = lc_gzidl001 AND gzidl002 = lc_gzidl002
                     AND gzidl003 = la_gzzy[li_cnt].gzzy001
                  
                  IF SQLCA.SQLCODE THEN
                     LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)gzidl_t失敗...  gzidl001:",lc_gzidl001,"  gzidl002:",lc_gzidl002,
                                                             "  gzidl003:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                     CALL g_gen_ch.writeLine(lc_msg)
                     RETURN
                  END IF
                  LET lc_update = "Y"
               END IF
            END IF
            
            IF lc_update = "Y" THEN
               #紀錄log
               LET lc_msg = "<tr hieght=22><td class=xl24>",la_gzzy[li_cnt].gzzy001,"</td>",     #更換語系
                                          "<td class=xl24>gzidl_t</td>",              #更換的多語言table
                                          "<td class=xl24>",g_param.docno,"</td>",    #表單單號
                                          "<td class=xl24>",g_param.seq,"</td>",      #項次
                                          "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                          "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                          "<td class=xl24>",lc_gzidl004_old,"</td>",  #資料修改前
                                          "<td class=xl24>",lc_gzidl004_new,"</td>",  #資料修改後
                            "</tr>"
        
               CALL g_gen_ch.writeLine(lc_msg)
            END IF
         END IF
         FREE azzp110_exp_gzidl_pre
      END FOR

   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_exp_gzjal()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_exp_gzjal()
   DEFINE ls_sql STRING
   DEFINE ls_sql_gzoz STRING
   DEFINE la_gzzy DYNAMIC ARRAY OF RECORD
             gzzy001 LIKE gzzy_t.gzzy001, #語言別
             gzozcol LIKE type_t.chr10    #語言別欄位
                  END RECORD
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE lc_gzjal001     LIKE gzjal_t.gzjal001
   DEFINE lc_gzjal003_tw  LIKE gzjal_t.gzjal003
   DEFINE lc_gzjal003_old LIKE gzjal_t.gzjal003
   DEFINE lc_gzjal003_new LIKE gzjal_t.gzjal003
   DEFINE lc_count        LIKE type_t.num5
   DEFINE lc_msg          STRING
   DEFINE lc_update       LIKE type_t.chr1
   DEFINE lc_item1        STRING
   DEFINE lc_item2        STRING
   
   
   #若是多語言暫存檔有資料的話，要先做暫存檔轉換的部分
   #否則後續用已更新後的字典檔再去對應各多語言檔的話，怕會有缺漏
   IF gs_trans_temp = "Y" THEN
      LET ls_sql = "SELECT gzjal001,gzjal003 FROM gzjal_t ",
                   " WHERE gzjal002 = 'zh_TW' ORDER BY gzjal001"

      DECLARE azzp110_trans_temp_to_gzjal_cs CURSOR FROM ls_sql
      FOREACH azzp110_trans_temp_to_gzjal_cs INTO lc_gzjal001,lc_gzjal003_old
         DISPLAY "check gzos_t  lc_gzjal001:",lc_gzjal001
         #檢查過單號是否已超過筆數
      #   CALL azzp110_chk_dzld_rows()
      #   IF NOT g_chk_status THEN
      #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
      #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
      #      CALL g_gen_ch.writeLine(lc_msg)
      #      RETURN
      #   END IF
         
         #從多語言暫存檔找出該語言別資料
         LET lc_gzjal003_new = ""
         EXECUTE azzp110_get_gzos_cs USING lc_gzjal003_old INTO lc_gzjal003_new

         IF NOT SQLCA.SQLCODE AND NOT cl_null(lc_gzjal003_new) THEN
            #填寫過單資訊，需檢核是否存在主檔中
            LET lc_count = 0
            LET lc_item1 = "NULL"
            LET lc_item2 = "NULL"
            SELECT COUNT(1) INTO lc_count FROM gzja_t
             WHERE gzja001 = lc_gzjal001
            IF lc_count > 0 THEN
            #   IF NOT azzp110_insert_dzld('gzjal_t','azzi700',lc_gzjal001,' ') THEN
            #      LET g_chk_status = FALSE
            #      RETURN
            #   END IF
               LET lc_item1 = "azzi700"
               LET lc_item2 = lc_gzjal001
            END IF
            
            UPDATE gzjal_t SET gzjal003 = lc_gzjal003_new
             WHERE gzjal001 = lc_gzjal001 AND gzjal002 = "zh_TW"

            IF SQLCA.SQLCODE THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)gzjal_t失敗...  gzjal001:",lc_gzjal001,"  gzjal002:zh_TW","  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
               CALL g_gen_ch.writeLine(lc_msg)
               RETURN
            END IF

            #紀錄log
            LET lc_msg = "<tr hieght=22><td class=xl24>zh_TW</td>",                #更換語系
                                       "<td class=xl24>gzjal_t</td>",              #更換的多語言table
                                       "<td class=xl24>",g_param.docno,"</td>",    #表單單號
                                       "<td class=xl24>",g_param.seq,"</td>",      #項次
                                       "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                       "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                       "<td class=xl24>",lc_gzjal003_old,"</td>",  #資料修改前
                                       "<td class=xl24>",lc_gzjal003_new,"</td>",  #資料修改後
                         "</tr>"

            CALL g_gen_ch.writeLine(lc_msg)
         END IF
      END FOREACH
   END IF
   
   ########開始進行字典檔匯出至多語言檔的動作##########
   LET ls_sql = "SELECT gzjal001,gzjal003 FROM gzjal_t ",
                " WHERE gzjal002 = 'zh_TW' ORDER BY gzjal001"

   #取出語言種類與項目
   LET la_gzzy = azzp110_get_gzzy() #除了zh_TW 之外

   DECLARE exp_gzjal_cs CURSOR FROM ls_sql
   FOREACH exp_gzjal_cs INTO lc_gzjal001,lc_gzjal003_tw
      DISPLAY "check gzoz_t  lc_gzjal001:",lc_gzjal001
      #跑單身陣列
      FOR li_cnt = 1 TO la_gzzy.getLength()
         LET lc_update = "N"
         
         #字典檔找出該語言別資料
         LET lc_gzjal003_new = ""
         LET ls_sql_gzoz = "SELECT ",la_gzzy[li_cnt].gzozcol CLIPPED,
                            " FROM gzoz_t WHERE gzoz000= '",lc_gzjal003_tw CLIPPED,"' "
         PREPARE azzp110_exp_gzjal_pre FROM ls_sql_gzoz
         EXECUTE azzp110_exp_gzjal_pre INTO lc_gzjal003_new
         #如果有資料且該筆資料不是null
         #然後判斷該語言別是否有資料 沒有資料就insert 有資料確認該筆資料是否是null，是就update
         #160303 改為以字典檔為主，若在字典檔有找到且非空白，就一律更新
         IF NOT SQLCA.SQLCODE AND NOT cl_null(lc_gzjal003_new) THEN
            #檢查過單號是否已超過筆數
         #   CALL azzp110_chk_dzld_rows()
         #   IF NOT g_chk_status THEN
         #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
         #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
         #   CALL g_gen_ch.writeLine(lc_msg)
         #      RETURN
         #   END IF
 
            LET lc_gzjal003_old = ""
            SELECT gzjal003 INTO lc_gzjal003_old FROM gzjal_t
             WHERE gzjal001 = lc_gzjal001 AND gzjal002 = la_gzzy[li_cnt].gzzy001
            IF SQLCA.SQLCODE THEN
               #填寫過單資訊，需檢核是否存在主檔中
               LET lc_count = 0
               LET lc_item1 = "NULL"
               LET lc_item2 = "NULL"
               SELECT COUNT(1) INTO lc_count FROM gzja_t
                WHERE gzja001 = lc_gzjal001
               IF lc_count > 0 THEN
               #   IF NOT azzp110_insert_dzld('gzjal_t','azzi700',lc_gzjal001,' ') THEN
               #      LET g_chk_status = FALSE
               #      RETURN
               #   END IF
                  LET lc_item1 = "azzi700"
                  LET lc_item2 = lc_gzjal001
               END IF
            
               INSERT INTO gzjal_t(gzjal001,gzjal002,gzjal003)
                 VALUES(lc_gzjal001,la_gzzy[li_cnt].gzzy001,lc_gzjal003_new)
               
               IF SQLCA.SQLCODE THEN
                  LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(insert)gzjal_t失敗...  gzjal001:",lc_gzjal001,"  gzjal002:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                  CALL g_gen_ch.writeLine(lc_msg)
                  RETURN
               END IF
               LET lc_update = "Y"
            ELSE
               IF la_gzzy[li_cnt].gzzy001 <> 'zh_TW' AND lc_gzjal003_new <> lc_gzjal003_old THEN
                  #填寫過單資訊，需檢核是否存在主檔中
                  LET lc_count = 0
                  LET lc_item1 = "NULL"
                  LET lc_item2 = "NULL"
                  SELECT COUNT(1) INTO lc_count FROM gzja_t
                   WHERE gzja001 = lc_gzjal001
                  IF lc_count > 0 THEN
                  #   IF NOT azzp110_insert_dzld('gzjal_t','azzi700',lc_gzjal001,' ') THEN
                  #      LET g_chk_status = FALSE
                  #      RETURN
                  #   END IF
                     LET lc_item1 = "azzi700"
                     LET lc_item2 = lc_gzjal001
                  END IF
            
                  UPDATE gzjal_t SET gzjal003 = lc_gzjal003_new
                   WHERE gzjal001 = lc_gzjal001 AND gzjal002 = la_gzzy[li_cnt].gzzy001
                 
                  IF SQLCA.SQLCODE THEN
                     LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)gzjal_t失敗...  gzjal001:",lc_gzjal001,"  gzjal002:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                     CALL g_gen_ch.writeLine(lc_msg)
                     RETURN
                  END IF
                  LET lc_update = "Y"
               END IF
            END IF
            
            IF lc_update = "Y" THEN
               #紀錄log
               LET lc_msg = "<tr hieght=22><td class=xl24>",la_gzzy[li_cnt].gzzy001,"</td>",    #更換語系
                                          "<td class=xl24>gzjal_t</td>",              #更換的多語言table
                                          "<td class=xl24>",g_param.docno,"</td>",    #表單單號
                                          "<td class=xl24>",g_param.seq,"</td>",      #項次
                                          "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                          "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                          "<td class=xl24>",lc_gzjal003_old,"</td>",  #資料修改前
                                          "<td class=xl24>",lc_gzjal003_new,"</td>",  #資料修改後
                            "</tr>"
            
               CALL g_gen_ch.writeLine(lc_msg)
            END IF
         END IF
         FREE azzp110_exp_gzjal_pre
      END FOR

   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_exp_gztdl()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_exp_gztdl()
   DEFINE ls_sql STRING
   DEFINE ls_sql_gzoz STRING
   DEFINE la_gzzy DYNAMIC ARRAY OF RECORD
             gzzy001 LIKE gzzy_t.gzzy001, #語言別
             gzozcol LIKE type_t.chr10    #語言別欄位
                  END RECORD
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE lc_gztdl001     LIKE gztdl_t.gztdl001
   DEFINE lc_gztdl002     LIKE gztdl_t.gztdl002
   DEFINE lc_gztdl003_tw  LIKE gztdl_t.gztdl003
   DEFINE lc_gztdl003_old LIKE gztdl_t.gztdl003
   DEFINE lc_gztdl003_new LIKE gztdl_t.gztdl003
   DEFINE lc_gztdl004_tw  LIKE gztdl_t.gztdl004
   DEFINE lc_gztdl004_old LIKE gztdl_t.gztdl004
   DEFINE lc_gztdl004_new LIKE gztdl_t.gztdl004
   DEFINE li_result       LIKE type_t.num5
   DEFINE li_result2      LIKE type_t.num5
   DEFINE li_count        LIKE type_t.num5
   DEFINE lc_count        LIKE type_t.num5
   DEFINE lc_msg          STRING
   DEFINE lc_update       LIKE type_t.chr1
   DEFINE lc_item1        STRING
   DEFINE lc_item2        STRING
   
   
   #若是多語言暫存檔有資料的話，要先做暫存檔轉換的部分
   #否則後續用已更新後的字典檔再去對應各多語言檔的話，怕會有缺漏
   IF gs_trans_temp = "Y" THEN
      LET ls_sql = "SELECT gztdl001,gztdl003,gztdl004 FROM gztdl_t ",
                   " WHERE gztdl002 = 'zh_TW' ORDER BY gztdl001"

      DECLARE azzp110_trans_temp_to_gztdl_cs CURSOR FROM ls_sql
      FOREACH azzp110_trans_temp_to_gztdl_cs INTO lc_gztdl001,lc_gztdl003_old,lc_gztdl004_old
         DISPLAY "check gzos_t  lc_gztdl001:",lc_gztdl001
         #檢查過單號是否已超過筆數
      #   CALL azzp110_chk_dzld_rows()
      #   IF NOT g_chk_status THEN
      #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
      #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
      #      CALL g_gen_ch.writeLine(lc_msg)
      #      RETURN
      #   END IF
         
         #從多語言暫存檔找出該語言別資料
         LET lc_gztdl003_new = ""
         IF NOT cl_null(lc_gztdl003_old) THEN
            EXECUTE azzp110_get_gzos_cs USING lc_gztdl003_old INTO lc_gztdl003_new
            LET li_result = SQLCA.SQLCODE
         END IF
         
         #從多語言暫存檔找出該語言別資料
         LET lc_gztdl004_new = ""
         IF NOT cl_null(lc_gztdl004_old) THEN
            EXECUTE azzp110_get_gzos_cs USING lc_gztdl004_old INTO lc_gztdl004_new
            LET li_result2 = SQLCA.SQLCODE
         END IF

         #如果有資料且該筆資料不是null
         #然後判斷該語言別是否有資料 沒有資料就insert 有資料確認該筆資料是否是null，是就update
         #160303 改為以字典檔為主，若在字典檔有找到且非空白，就一律更新
         IF (NOT li_result AND NOT cl_null(lc_gztdl003_new)) OR (NOT li_result2 AND NOT cl_null(lc_gztdl004_new)) THEN
            #填寫過單資訊，需檢核是否存在主檔中
            LET lc_count = 0
            LET lc_item1 = "NULL"
            LET lc_item2 = "NULL"
            SELECT COUNT(1) INTO lc_count FROM gztd_t
             WHERE gztd001 = lc_gztdl001
            IF lc_count > 0 THEN
            #   IF NOT azzp110_insert_dzld('gztdl_t','azzi090',lc_gztdl001,' ') THEN
            #      LET g_chk_status = FALSE
            #      RETURN
            #   END IF
               LET lc_item1 = "azzi090"
               LET lc_item2 = lc_gztdl001
            END IF
            
            IF cl_null(lc_gztdl003_new) THEN
               LET lc_gztdl003_new = lc_gztdl003_old
            END IF
            
            IF cl_null(lc_gztdl004_new) THEN
               LET lc_gztdl004_new = lc_gztdl004_old
            END IF

            UPDATE gztdl_t SET gztdl003 = lc_gztdl003_new,
                               gztdl004 = lc_gztdl004_new
             WHERE gztdl001 = lc_gztdl001
               AND gztdl002 = "zh_TW"

            IF SQLCA.SQLCODE THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)gztdl_t失敗...  gztdl001:",lc_gztdl001,"  gztdl002:zh_TW","  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
               CALL g_gen_ch.writeLine(lc_msg)
               RETURN
            END IF

            #紀錄log
            LET lc_msg = "<tr hieght=22><td class=xl24>zh_TW</td>",                #更換語系
                                       "<td class=xl24>gztdl_t</td>",              #更換的多語言table
                                       "<td class=xl24>",g_param.docno,"</td>",    #表單單號
                                       "<td class=xl24>",g_param.seq,"</td>",      #項次
                                       "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                       "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                       "<td class=xl24>",lc_gztdl003_old,"</td>",  #資料修改前
                                       "<td class=xl24>",lc_gztdl003_new,"</td>",  #資料修改後
                                       "<td class=xl24>",lc_gztdl004_old,"</td>",  #資料修改前
                                       "<td class=xl24>",lc_gztdl004_new,"</td>",  #資料修改後
                         "</tr>"

            CALL g_gen_ch.writeLine(lc_msg)
         END IF
      END FOREACH
   END IF
   
   ########開始進行字典檔匯出至多語言檔的動作##########
   LET ls_sql = "SELECT gztdl001,gztdl003,gztdl004 FROM gztdl_t ",
                " WHERE gztdl002 = 'zh_TW' ORDER BY gztdl001"

   #取出語言種類與項目
   LET la_gzzy = azzp110_get_gzzy() #除了zh_TW 之外

   DECLARE exp_gztdl_cs CURSOR FROM ls_sql
   FOREACH exp_gztdl_cs INTO lc_gztdl001,lc_gztdl003_tw,lc_gztdl004_tw
      DISPLAY "check gzoz_t  lc_gztdl001:",lc_gztdl001
      #跑單身陣列
      FOR li_cnt = 1 TO la_gzzy.getLength()
         LET lc_update = "N"
         
         #字典檔找出該語言別資料
         LET ls_sql_gzoz = "SELECT ",la_gzzy[li_cnt].gzozcol CLIPPED,
                            " FROM gzoz_t WHERE gzoz000= ? "
         PREPARE azzp110_exp_gztdl_pre FROM ls_sql_gzoz

         #以繁體中文為主
         LET lc_gztdl003_new = ""
         IF NOT cl_null(lc_gztdl003_tw) THEN
            EXECUTE azzp110_exp_gztdl_pre USING lc_gztdl003_tw INTO lc_gztdl003_new
            LET li_result = SQLCA.SQLCODE
         END IF
         
         #以繁體中文為主
         LET lc_gztdl004_new = ""
         IF NOT cl_null(lc_gztdl004_tw) THEN
            EXECUTE azzp110_exp_gztdl_pre USING lc_gztdl004_tw INTO lc_gztdl004_new
            LET li_result2 = SQLCA.SQLCODE
         END IF

         #如果有資料且該筆資料不是null
         #然後判斷該語言別是否有資料 沒有資料就insert 有資料確認該筆資料是否是null，是就update
         #160303 改為以字典檔為主，若在字典檔有找到且非空白，就一律更新
         IF (NOT li_result AND NOT cl_null(lc_gztdl003_new)) OR (NOT li_result2 AND NOT cl_null(lc_gztdl004_new)) THEN
            #檢查過單號是否已超過筆數
         #   CALL azzp110_chk_dzld_rows()
         #   IF NOT g_chk_status THEN
         #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
         #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
         #   CALL g_gen_ch.writeLine(lc_msg)
         #      RETURN
         #   END IF

            LET lc_gztdl003_old = ""
            LET lc_gztdl004_old = ""
            LET li_count = 0
            
            SELECT COUNT(*) INTO li_count FROM gztdl_t
             WHERE gztdl001 = lc_gztdl001
               AND gztdl002 = la_gzzy[li_cnt].gzzy001
            
            IF li_count = 0 THEN
               #填寫過單資訊，需檢核是否存在主檔中
               LET lc_count = 0
               LET lc_item1 = "NULL"
               LET lc_item2 = "NULL"
               SELECT COUNT(1) INTO lc_count FROM gztd_t
                WHERE gztd001 = lc_gztdl001
               IF lc_count > 0 THEN
               #   IF NOT azzp110_insert_dzld('gztdl_t','azzi090',lc_gztdl001,' ') THEN
               #      LET g_chk_status = FALSE
               #      RETURN
               #   END IF
                  LET lc_item1 = "azzi090"
                  LET lc_item2 = lc_gztdl001
               END IF
            
               INSERT INTO gztdl_t(gztdl001,gztdl002,gztdl003,gztdl004)
                 VALUES(lc_gztdl001,la_gzzy[li_cnt].gzzy001,lc_gztdl003_new,lc_gztdl004_new)
               
               IF SQLCA.SQLCODE THEN
                  LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(insert)gztdl_t失敗...  gztdl001:",lc_gztdl001,"  gztdl002:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                  CALL g_gen_ch.writeLine(lc_msg)
                  RETURN
               END IF
               LET lc_update = "Y"
            ELSE
               SELECT gztdl003,gztdl004 INTO lc_gztdl003_old,lc_gztdl004_old
                 FROM gztdl_t
                WHERE gztdl001 = lc_gztdl001
                  AND gztdl002 = la_gzzy[li_cnt].gzzy001

                IF NOT SQLCA.SQLCODE THEN
                   #須以字典檔為主，但為避免字典檔的資料是空白的，卻蓋掉原有已存在的資料，所以要先做判斷
                   IF cl_null(lc_gztdl003_new) THEN
                      LET lc_gztdl003_new = lc_gztdl003_old
                   END IF

                   IF cl_null(lc_gztdl004_new) THEN
                      LET lc_gztdl004_new = lc_gztdl004_old
                   END IF
                   
                   IF la_gzzy[li_cnt].gzzy001 <> "zh_TW" AND (lc_gztdl003_new <> lc_gztdl003_old
                         OR lc_gztdl004_new <> lc_gztdl004_old) THEN
                      
                      #填寫過單資訊，需檢核是否存在主檔中
                      LET lc_count = 0
                      LET lc_item1 = "NULL"
                      LET lc_item2 = "NULL"
                      SELECT COUNT(1) INTO lc_count FROM gztd_t
                       WHERE gztd001 = lc_gztdl001
                      IF lc_count > 0 THEN
                      #   IF NOT azzp110_insert_dzld('gztdl_t','azzi090',lc_gztdl001,' ') THEN
                      #      LET g_chk_status = FALSE
                      #      RETURN
                      #   END IF
                         LET lc_item1 = "azzi090"
                         LET lc_item2 = lc_gztdl001
                      END IF
            
                      UPDATE gztdl_t SET gztdl003 = lc_gztdl003_new,
                                         gztdl004 = lc_gztdl004_new
                       WHERE gztdl001 = lc_gztdl001
                         AND gztdl002 = la_gzzy[li_cnt].gzzy001
                      
                      IF SQLCA.SQLCODE THEN
                         LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)gztdl_t失敗...  gztdl001:",lc_gztdl001,"  gztdl002:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                         CALL g_gen_ch.writeLine(lc_msg)
                         RETURN
                      END IF
                      LET lc_update = "Y"
                   END IF
                END IF
            END IF
            
            IF lc_update = "Y" THEN
               #紀錄log
               LET lc_msg = "<tr hieght=22><td class=xl24>",la_gzzy[li_cnt].gzzy001,"</td>",    #更換語系
                                          "<td class=xl24>gztdl_t</td>",              #更換的多語言table
                                          "<td class=xl24>",g_param.docno,"</td>",    #表單單號
                                          "<td class=xl24>",g_param.seq,"</td>",      #項次
                                          "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                          "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                          "<td class=xl24>",lc_gztdl003_old,"</td>",  #資料修改前
                                          "<td class=xl24>",lc_gztdl003_new,"</td>",  #資料修改後
                                          "<td class=xl24>",lc_gztdl004_old,"</td>",  #資料修改前
                                          "<td class=xl24>",lc_gztdl004_new,"</td>",  #資料修改後
                            "</tr>"
         
               CALL g_gen_ch.writeLine(lc_msg)
            END IF
         END IF
         FREE azzp110_exp_gztdl_pre
      END FOR

   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_exp_gztel()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_exp_gztel()
   DEFINE ls_sql STRING
   DEFINE ls_sql_gzoz STRING
   DEFINE la_gzzy DYNAMIC ARRAY OF RECORD
             gzzy001 LIKE gzzy_t.gzzy001, #語言別
             gzozcol LIKE type_t.chr10    #語言別欄位
                  END RECORD
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE lc_gztel001     LIKE gztel_t.gztel001
   DEFINE lc_gztel003_tw  LIKE gztel_t.gztel003
   DEFINE lc_gztel003_old LIKE gztel_t.gztel003
   DEFINE lc_gztel003_new LIKE gztel_t.gztel003
   DEFINE lc_count        LIKE type_t.num5
   DEFINE lc_msg          STRING
   DEFINE lc_update       LIKE type_t.chr1
   DEFINE lc_item1        STRING
   DEFINE lc_item2        STRING
   
   
   #若是多語言暫存檔有資料的話，要先做暫存檔轉換的部分
   #否則後續用已更新後的字典檔再去對應各多語言檔的話，怕會有缺漏
   IF gs_trans_temp = "Y" THEN
      LET ls_sql = "SELECT gztel001,gztel003 FROM gztel_t WHERE gztel002 = 'zh_TW' ORDER BY gztel001"

      DECLARE azzp110_trans_temp_to_gztel_cs CURSOR FROM ls_sql
      FOREACH azzp110_trans_temp_to_gztel_cs INTO lc_gztel001,lc_gztel003_old
         DISPLAY "check gzos_t  lc_gztel001:",lc_gztel001
         #檢查過單號是否已超過筆數
      #   CALL azzp110_chk_dzld_rows()
      #   IF NOT g_chk_status THEN
      #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
      #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
      #      CALL g_gen_ch.writeLine(lc_msg)
      #      RETURN
      #   END IF
         
         #從多語言暫存檔找出該語言別資料
         LET lc_gztel003_new = ""
         EXECUTE azzp110_get_gzos_cs USING lc_gztel003_old INTO lc_gztel003_new

         IF NOT SQLCA.SQLCODE AND NOT cl_null(lc_gztel003_new) THEN
            #填寫過單資訊，需檢核是否存在主檔中
            LET lc_count = 0
            LET lc_item1 = "NULL"
            LET lc_item2 = "NULL"
            SELECT COUNT(*) INTO lc_count FROM gzte_t
             WHERE gzte001 = lc_gztel001

            IF lc_count > 0 THEN
            #   IF NOT azzp110_insert_dzld('gztel_t','azzi552',lc_gztel001,' ') THEN
            #      LET g_chk_status = FALSE
            #      RETURN
            #   END IF
               LET lc_item1 = "azzi552"
               LET lc_item2 = lc_gztel001
            END IF
            
            UPDATE gztel_t SET gztel003 = lc_gztel003_new
             WHERE gztel001 = lc_gztel001 AND gztel002 = "zh_TW"

            IF SQLCA.SQLCODE THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)gztel_t失敗...  gztel001:",lc_gztel001,"  gztel002:zh_TW","  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
               CALL g_gen_ch.writeLine(lc_msg)
               RETURN
            END IF

            #紀錄log
            LET lc_msg = "<tr hieght=22><td class=xl24>zh_TW</td>",                #更換語系
                                       "<td class=xl24>gztel_t</td>",              #更換的多語言table
                                       "<td class=xl24>",g_param.docno,"</td>",    #表單單號
                                       "<td class=xl24>",g_param.seq,"</td>",      #項次
                                       "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                       "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                       "<td class=xl24>",lc_gztel003_old,"</td>",  #資料修改前
                                       "<td class=xl24>",lc_gztel003_new,"</td>",  #資料修改後
                         "</tr>"

            CALL g_gen_ch.writeLine(lc_msg)
         END IF
      END FOREACH
   END IF
   
   ########開始進行字典檔匯出至多語言檔的動作##########
   LET ls_sql = "SELECT gztel001,gztel003 FROM gztel_t WHERE gztel002 = 'zh_TW' ORDER BY gztel001"

   #取出語言種類與項目
   LET la_gzzy = azzp110_get_gzzy() #除了zh_TW 之外

   DECLARE exp_gztel_cs CURSOR FROM ls_sql
   FOREACH exp_gztel_cs INTO lc_gztel001,lc_gztel003_tw
      DISPLAY "check gzoz_t  lc_gztel001:",lc_gztel001
      #跑單身陣列
      FOR li_cnt = 1 TO la_gzzy.getLength()
         LET lc_update = "N"
         
         #以繁體中文為主
         LET lc_gztel003_new = ""
         LET ls_sql_gzoz = "SELECT ",la_gzzy[li_cnt].gzozcol CLIPPED,
                            " FROM gzoz_t WHERE gzoz000= '",lc_gztel003_tw CLIPPED,"' "
         PREPARE azzp110_exp_gztel_pre FROM ls_sql_gzoz
         EXECUTE azzp110_exp_gztel_pre INTO lc_gztel003_new

         #如果有資料且該筆資料不是null
         #然後判斷該語言別是否有資料 沒有資料就insert 有資料確認該筆資料是否是null，是就update
         #160303 改為以字典檔為主，若在字典檔有找到且非空白，就一律更新
         IF NOT SQLCA.SQLCODE AND NOT cl_null(lc_gztel003_new) THEN
            #檢查過單號是否已超過筆數
         #   CALL azzp110_chk_dzld_rows()
         #   IF NOT g_chk_status THEN
         #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
         #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
         #   CALL g_gen_ch.writeLine(lc_msg)
         #      RETURN
         #   END IF
 
            LET lc_gztel003_old = ""
            LET lc_count = 0
            
            SELECT COUNT(*) INTO lc_count FROM gztel_t
             WHERE gztel001 = lc_gztel001
               AND gztel002 = la_gzzy[li_cnt].gzzy001
            
            IF lc_count = 0 THEN
               #填寫過單資訊，需檢核是否存在主檔中
               LET lc_count = 0
               LET lc_item1 = "NULL"
               LET lc_item2 = "NULL"
               SELECT COUNT(*) INTO lc_count FROM gzte_t
                WHERE gzte001 = lc_gztel001
                
               IF lc_count > 0 THEN
               #   IF NOT azzp110_insert_dzld('gztel_t','azzi900',lc_gztel001,' ') THEN
               #      LET g_chk_status = FALSE
               #      RETURN
               #   END IF
                  LET lc_item1 = "azzi900"
                  LET lc_item2 = lc_gztel001
               END IF
            
               INSERT INTO gztel_t(gztel001,gztel002,gztel003)
                  VALUES(lc_gztel001,la_gzzy[li_cnt].gzzy001,lc_gztel003_new)
               
               IF SQLCA.SQLCODE THEN
                  LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(insert)gztel_t失敗...  gztel001:",lc_gztel001,"  gztel002:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                  CALL g_gen_ch.writeLine(lc_msg)
                  RETURN
               END IF
               LET lc_update = "Y"
            ELSE
               SELECT gztel003 INTO lc_gztel003_old FROM gztel_t
                WHERE gztel001 = lc_gztel001
                  AND gztel002 = la_gzzy[li_cnt].gzzy001
               IF NOT SQLCA.SQLCODE THEN
                  IF la_gzzy[li_cnt].gzzy001 <> "zh_TW" AND lc_gztel003_new <> lc_gztel003_old THEN
                     #填寫過單資訊，需檢核是否存在主檔中
                     LET lc_count = 0
                     LET lc_item1 = "NULL"
                     LET lc_item2 = "NULL"
                     SELECT COUNT(*) INTO lc_count FROM gzte_t
                      WHERE gzte001 = lc_gztel001
                      
                     IF lc_count > 0 THEN
                     #   IF NOT azzp110_insert_dzld('gztel_t','azzi900',lc_gztel001,' ') THEN
                     #      LET g_chk_status = FALSE
                     #      RETURN
                     #   END IF
                        LET lc_item1 = "azzi900"
                        LET lc_item2 = lc_gztel001
                     END IF
            
                     UPDATE gztel_t SET gztel003 = lc_gztel003_new
                      WHERE gztel001 = lc_gztel001 AND gztel002 = la_gzzy[li_cnt].gzzy001
               
                     IF SQLCA.SQLCODE THEN
                        LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)gztel_t失敗...  gztel001:",lc_gztel001,"  gztel002:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                        CALL g_gen_ch.writeLine(lc_msg)
                        RETURN
                     END IF
                     LET lc_update = "Y"
                  END IF
               END IF
            END IF

            IF lc_update = "Y" THEN
               #紀錄log
               LET lc_msg = "<tr hieght=22><td class=xl24>",la_gzzy[li_cnt].gzzy001,"</td>",    #更換語系
                                          "<td class=xl24>gztel_t</td>",              #更換的多語言table
                                          "<td class=xl24>",g_param.docno,"</td>",    #表單單號
                                          "<td class=xl24>",g_param.seq,"</td>",      #項次
                                          "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                          "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                          "<td class=xl24>",lc_gztel003_old,"</td>",  #資料修改前
                                          "<td class=xl24>",lc_gztel003_new,"</td>",  #資料修改後
                            "</tr>"
         
               CALL g_gen_ch.writeLine(lc_msg)
            END IF
         END IF
         FREE azzp110_exp_gztel_pre
      END FOR
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_exp_gzzol()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_exp_gzzol()
   DEFINE ls_sql STRING
   DEFINE ls_sql_gzoz STRING
   DEFINE la_gzzy DYNAMIC ARRAY OF RECORD
             gzzy001 LIKE gzzy_t.gzzy001, #語言別
             gzozcol LIKE type_t.chr10    #語言別欄位
                  END RECORD
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE lc_gzzol001     LIKE gzzol_t.gzzol001
   DEFINE lc_gzzol003_tw  LIKE gzzol_t.gzzol003
   DEFINE lc_gzzol003_old LIKE gzzol_t.gzzol003
   DEFINE lc_gzzol003_new LIKE gzzol_t.gzzol003
   DEFINE lc_count        LIKE type_t.num5
   DEFINE lc_msg          STRING
   DEFINE lc_update       LIKE type_t.chr1
   DEFINE lc_item1        STRING
   DEFINE lc_item2        STRING
   
   
   #若是多語言暫存檔有資料的話，要先做暫存檔轉換的部分
   #否則後續用已更新後的字典檔再去對應各多語言檔的話，怕會有缺漏
   IF gs_trans_temp = "Y" THEN
      LET ls_sql = "SELECT gzzol001,gzzol003 FROM gzzol_t WHERE gzzol002 = 'zh_TW' ORDER BY gzzol001"

      DECLARE azzp110_trans_temp_to_gzzol_cs CURSOR FROM ls_sql
      FOREACH azzp110_trans_temp_to_gzzol_cs INTO lc_gzzol001,lc_gzzol003_old
         DISPLAY "check gzos_t  lc_gzzol001:",lc_gzzol001
         #檢查過單號是否已超過筆數
      #   CALL azzp110_chk_dzld_rows()
      #   IF NOT g_chk_status THEN
      #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
      #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
      #      CALL g_gen_ch.writeLine(lc_msg)
      #      RETURN
      #   END IF
         
         #從多語言暫存檔找出該語言別資料
         LET lc_gzzol003_new = ""
         EXECUTE azzp110_get_gzos_cs USING lc_gzzol003_old INTO lc_gzzol003_new

         IF NOT SQLCA.SQLCODE AND NOT cl_null(lc_gzzol003_new) THEN
            #填寫過單資訊，需檢核是否存在主檔中
            LET lc_count = 0
            LET lc_item1 = "NULL"
            LET lc_item2 = "NULL"
            SELECT COUNT(*) INTO lc_count FROM gzzo_t
             WHERE gzzo001 = lc_gzzol001

            IF lc_count > 0 THEN
            #   IF NOT azzp110_insert_dzld('gzzol_t','azzi070',lc_gzzol001,' ') THEN
            #      LET g_chk_status = FALSE
            #      RETURN
            #   END IF
               LET lc_item1 = "azzi070"
               LET lc_item2 = lc_gzzol001
            END IF
            
            UPDATE gzzol_t SET gzzol003 = lc_gzzol003_new
             WHERE gzzol001 = lc_gzzol001 AND gzzol002 = "zh_TW"

            IF SQLCA.SQLCODE THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)gzzol_t失敗...  gzzol001:",lc_gzzol001,"  gzzol002:zh_TW","  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
               CALL g_gen_ch.writeLine(lc_msg)
               RETURN
            END IF

            #紀錄log
            LET lc_msg = "<tr hieght=22><td class=xl24>zh_TW</td>",                #更換語系
                                       "<td class=xl24>gzzol_t</td>",              #更換的多語言table
                                       "<td class=xl24>",g_param.docno,"</td>",    #表單單號
                                       "<td class=xl24>",g_param.seq,"</td>",      #項次
                                       "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                       "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                       "<td class=xl24>",lc_gzzol003_old,"</td>",  #資料修改前
                                       "<td class=xl24>",lc_gzzol003_new,"</td>",  #資料修改後
                         "</tr>"

            CALL g_gen_ch.writeLine(lc_msg)
         END IF
      END FOREACH
   END IF
   
   ########開始進行字典檔匯出至多語言檔的動作##########
   LET ls_sql = "SELECT gzzol001,gzzol003 FROM gzzol_t WHERE gzzol002 = 'zh_TW' ORDER BY gzzol001"

   #取出語言種類與項目
   LET la_gzzy = azzp110_get_gzzy() #除了zh_TW 之外

   DECLARE exp_gzzol_cs CURSOR FROM ls_sql
   FOREACH exp_gzzol_cs INTO lc_gzzol001,lc_gzzol003_tw
      DISPLAY "check gzoz_t  lc_gzzol001:",lc_gzzol001
      #跑單身陣列
      FOR li_cnt = 1 TO la_gzzy.getLength()
         LET lc_update = "N"
         
         #以繁體中文為主
         LET lc_gzzol003_new = ""
         LET ls_sql_gzoz = "SELECT ",la_gzzy[li_cnt].gzozcol CLIPPED,
                            " FROM gzoz_t WHERE gzoz000= '",lc_gzzol003_tw CLIPPED,"' "
         PREPARE azzp110_exp_gzzol_pre FROM ls_sql_gzoz
         EXECUTE azzp110_exp_gzzol_pre INTO lc_gzzol003_new

         #如果有資料且該筆資料不是null
         #然後判斷該語言別是否有資料 沒有資料就insert 有資料確認該筆資料是否是null，是就update
         #160303 改為以字典檔為主，若在字典檔有找到且非空白，就一律更新
         IF NOT SQLCA.SQLCODE AND NOT cl_null(lc_gzzol003_new) THEN
            #檢查過單號是否已超過筆數
         #   CALL azzp110_chk_dzld_rows()
         #   IF NOT g_chk_status THEN
         #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
         #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
         #   CALL g_gen_ch.writeLine(lc_msg)
         #      RETURN
         #   END IF
 
            LET lc_gzzol003_old = ""
            LET lc_count = 0
            
            SELECT COUNT(*) INTO lc_count FROM gzzol_t
             WHERE gzzol001 = lc_gzzol001
               AND gzzol002 = la_gzzy[li_cnt].gzzy001
            
            IF lc_count = 0 THEN
               #填寫過單資訊，需檢核是否存在主檔中
               LET lc_count = 0
               LET lc_item1 = "NULL"
               LET lc_item2 = "NULL"
               SELECT COUNT(*) INTO lc_count FROM gzzo_t
                WHERE gzzo001 = lc_gzzol001
                
               IF lc_count > 0 THEN
               #   IF NOT azzp110_insert_dzld('gzzol_t','azzi070',lc_gzzol001,' ') THEN
               #      LET g_chk_status = FALSE
               #      RETURN
               #   END IF
                  LET lc_item1 = "azzi070"
                  LET lc_item2 = lc_gzzol001
               END IF
            
               INSERT INTO gzzol_t(gzzol001,gzzol002,gzzol003)
                  VALUES(lc_gzzol001,la_gzzy[li_cnt].gzzy001,lc_gzzol003_new)
               
               IF SQLCA.SQLCODE THEN
                  LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(insert)gzzol_t失敗...  gzzol001:",lc_gzzol001,"  gzzol002:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                  CALL g_gen_ch.writeLine(lc_msg)
                  RETURN
               END IF
               LET lc_update = "Y"
            ELSE
               SELECT gzzol003 INTO lc_gzzol003_old FROM gzzol_t
                WHERE gzzol001 = lc_gzzol001
                  AND gzzol002 = la_gzzy[li_cnt].gzzy001
               IF NOT SQLCA.SQLCODE THEN
                  IF la_gzzy[li_cnt].gzzy001 <> "zh_TW" AND lc_gzzol003_new <> lc_gzzol003_old THEN
                     #填寫過單資訊，需檢核是否存在主檔中
                     LET lc_count = 0
                     LET lc_item1 = "NULL"
                     LET lc_item2 = "NULL"
                     SELECT COUNT(*) INTO lc_count FROM gzzo_t
                      WHERE gzzo001 = lc_gzzol001
                      
                     IF lc_count > 0 THEN
                     #   IF NOT azzp110_insert_dzld('gzzol_t','azzi070',lc_gzzol001,' ') THEN
                     #      LET g_chk_status = FALSE
                     #      RETURN
                     #   END IF
                        LET lc_item1 = "azzi070"
                        LET lc_item2 = lc_gzzol001
                     END IF
            
                     UPDATE gzzol_t SET gzzol003 = lc_gzzol003_new
                      WHERE gzzol001 = lc_gzzol001 AND gzzol002 = la_gzzy[li_cnt].gzzy001
                  
                     IF SQLCA.SQLCODE THEN
                        LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)gzzol_t失敗...  gzzol001:",lc_gzzol001,"  gzzol002:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                        CALL g_gen_ch.writeLine(lc_msg)
                        RETURN
                     END IF
                     LET lc_update = "Y"
                  END IF
               END IF
            END IF

            IF lc_update = "Y" THEN
               #紀錄log
               LET lc_msg = "<tr hieght=22><td class=xl24>",la_gzzy[li_cnt].gzzy001,"</td>",    #更換語系
                                          "<td class=xl24>gzzol_t</td>",              #更換的多語言table
                                          "<td class=xl24>",g_param.docno,"</td>",    #表單單號
                                          "<td class=xl24>",g_param.seq,"</td>",      #項次
                                          "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                          "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                          "<td class=xl24>",lc_gzzol003_old,"</td>",  #資料修改前
                                          "<td class=xl24>",lc_gzzol003_new,"</td>",  #資料修改後
                            "</tr>"
         
               CALL g_gen_ch.writeLine(lc_msg)
            END IF
         END IF
         FREE azzp110_exp_gzzol_pre
      END FOR
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_exp_gzzf()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_exp_gzzf()
   DEFINE ls_sql STRING
   DEFINE ls_sql_gzoz STRING
   DEFINE la_gzzy DYNAMIC ARRAY OF RECORD
             gzzy001 LIKE gzzy_t.gzzy001, #語言別
             gzozcol LIKE type_t.chr10    #語言別欄位
                  END RECORD
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE lc_gzzf001     LIKE gzzf_t.gzzf001
   DEFINE lc_gzzf003     LIKE gzzf_t.gzzf003
   DEFINE lc_gzzf005_tw  LIKE gzzf_t.gzzf005
   DEFINE lc_gzzf005_old LIKE gzzf_t.gzzf005
   DEFINE lc_gzzf005_new LIKE gzzf_t.gzzf005
   DEFINE lc_gzzf006_tw  LIKE gzzf_t.gzzf006
   DEFINE lc_gzzf006_old LIKE gzzf_t.gzzf006
   DEFINE lc_gzzf006_new LIKE gzzf_t.gzzf006
   DEFINE li_result       LIKE type_t.num5
   DEFINE li_result2      LIKE type_t.num5
   DEFINE li_count        LIKE type_t.num5
   DEFINE lc_count        LIKE type_t.num5
   DEFINE lc_msg          STRING
   DEFINE lc_std_or_cust  LIKE type_t.chr1
   DEFINE lc_update       LIKE type_t.chr1
   
   
   #gzzf 有標準及客製
   LET lc_std_or_cust = FGL_GETENV("DGENV")

   #若是多語言暫存檔有資料的話，要先做暫存檔轉換的部分
   #否則後續用已更新後的字典檔再去對應各多語言檔的話，怕會有缺漏
   IF gs_trans_temp = "Y" THEN
      LET ls_sql = "SELECT gzzf001,gzzf003,gzzf005,gzzf006 FROM gzzf_t ",
                   " WHERE gzzf002 = 'zh_TW' AND gzzf004 ='",lc_std_or_cust CLIPPED,"'",
                   " ORDER BY gzzf001,gzzf003"

      DECLARE azzp110_trans_temp_to_gzzf_cs CURSOR FROM ls_sql
      FOREACH azzp110_trans_temp_to_gzzf_cs INTO lc_gzzf001,lc_gzzf003,lc_gzzf005_old,lc_gzzf006_old
         DISPLAY "check gzos_t  lc_gzzf001:",lc_gzzf001
         #檢查過單號是否已超過筆數
      #   CALL azzp110_chk_dzld_rows()
      #   IF NOT g_chk_status THEN
      #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
      #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
      #      CALL g_gen_ch.writeLine(lc_msg)
      #      RETURN
      #   END IF
         
         #從多語言暫存檔找出該語言別資料
         LET lc_gzzf005_new = ""
         IF NOT cl_null(lc_gzzf005_old) THEN
            EXECUTE azzp110_get_gzos_cs USING lc_gzzf005_old INTO lc_gzzf005_new
            LET li_result = SQLCA.SQLCODE
         END IF
         
         #從多語言暫存檔找出該語言別資料
         LET lc_gzzf006_new = ""
         IF NOT cl_null(lc_gzzf006_old) THEN
            EXECUTE azzp110_get_gzos_cs USING lc_gzzf006_old INTO lc_gzzf006_new
            LET li_result = SQLCA.SQLCODE
         END IF

         #如果有資料且該筆資料不是null
         #然後判斷該語言別是否有資料 沒有資料就insert 有資料確認該筆資料是否是null，是就update
         #160303 改為以字典檔為主，若在字典檔有找到且非空白，就一律更新
         IF (NOT li_result AND NOT cl_null(lc_gzzf005_new)) OR (NOT li_result2 AND NOT cl_null(lc_gzzf006_new)) THEN
            #填寫過單資訊，需檢核是否存在主檔中
         #   IF NOT azzp110_insert_dzld('gzzf_t','azzi912',lc_gzzf001,' ') THEN
         #      LET g_chk_status = FALSE
         #      RETURN
         #   END IF
            
            IF cl_null(lc_gzzf005_new) THEN
               LET lc_gzzf005_new = lc_gzzf005_old
            END IF

            IF cl_null(lc_gzzf006_new) THEN
               LET lc_gzzf006_new = lc_gzzf006_old
            END IF
            
            UPDATE gzzf_t SET gzzf005 = lc_gzzf005_new,
                              gzzf006 = lc_gzzf006_new
             WHERE gzzf001 = lc_gzzf001 AND gzzf003 = lc_gzzf003
               AND gzzf002 = "zh_TW"
               AND gzzf004 = lc_std_or_cust

             IF SQLCA.SQLCODE THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)gzzf_t失敗...  gzzf001:",lc_gzzf001,"  gzzf002:zh_TW",
                                                       "  gzzf003:",lc_gzzf003,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
               CALL g_gen_ch.writeLine(lc_msg)
               RETURN
            END IF

            #紀錄log
            LET lc_msg = "<tr hieght=22><td class=xl24>zh_TW</td>",                #更換語系
                                       "<td class=xl24>gzzf_t</td>",               #更換的多語言table
                                       "<td class=xl24>",g_param.docno,"</td>",    #表單單號
                                       "<td class=xl24>",g_param.seq,"</td>",      #項次
                                       "<td class=xl24>azzi912</td>",              #關聯項目
                                       "<td class=xl24>",lc_gzzf001,"</td>",       #過單條件值
                                       "<td class=xl24>",lc_gzzf005_old,"</td>",   #資料修改前
                                       "<td class=xl24>",lc_gzzf005_new,"</td>",   #資料修改後
                                       "<td class=xl24>",lc_gzzf006_old,"</td>",   #資料修改前
                                       "<td class=xl24>",lc_gzzf006_new,"</td>",   #資料修改後
                         "</tr>"

            CALL g_gen_ch.writeLine(lc_msg)
         END IF
      END FOREACH
   END IF
   
   ########開始進行字典檔匯出至多語言檔的動作##########
   LET ls_sql = "SELECT gzzf001,gzzf003,gzzf005,gzzf006 FROM gzzf_t ",
                " WHERE gzzf002 = 'zh_TW' AND gzzf004 ='",lc_std_or_cust CLIPPED ,"'",
                " ORDER BY gzzf001,gzzf003"

   #取出語言種類與項目
   LET la_gzzy = azzp110_get_gzzy() #除了zh_TW 之外

   DECLARE exp_gzzf_cs CURSOR FROM ls_sql
   FOREACH exp_gzzf_cs INTO lc_gzzf001,lc_gzzf003,lc_gzzf005_tw,lc_gzzf006_tw
      DISPLAY "check gzoz_t  lc_gzzf001:",lc_gzzf001
      #跑單身陣列
      FOR li_cnt = 1 TO la_gzzy.getLength()
         LET lc_update = "N"
         
         #字典檔找出該語言別資料
         LET ls_sql_gzoz = "SELECT ",la_gzzy[li_cnt].gzozcol CLIPPED,
                            " FROM gzoz_t WHERE gzoz000 = ? "
         PREPARE azzp110_exp_gzzf_pre FROM ls_sql_gzoz

         #以繁體中文為主
         LET lc_gzzf005_new = ""
         IF NOT cl_null(lc_gzzf005_tw) THEN
            EXECUTE azzp110_exp_gzzf_pre USING lc_gzzf005_tw INTO lc_gzzf005_new
            LET li_result = SQLCA.SQLCODE
         END IF
         
         #以繁體中文為主
         LET lc_gzzf006_new = ""
         IF NOT cl_null(lc_gzzf006_tw) THEN
            EXECUTE azzp110_exp_gzzf_pre USING lc_gzzf006_tw INTO lc_gzzf006_new
            LET li_result2 = SQLCA.SQLCODE
         END IF

         #如果有資料且該筆資料不是null
         #然後判斷該語言別是否有資料 沒有資料就insert 有資料確認該筆資料是否是null，是就update
         #160303 改為以字典檔為主，若在字典檔有找到且非空白，就一律更新
         IF (NOT li_result AND NOT cl_null(lc_gzzf005_new)) OR (NOT li_result2 AND NOT cl_null(lc_gzzf006_new)) THEN
            #檢查過單號是否已超過筆數
         #   CALL azzp110_chk_dzld_rows()
         #   IF NOT g_chk_status THEN
         #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
         #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
         #   CALL g_gen_ch.writeLine(lc_msg)
         #      RETURN
         #   END IF

            LET lc_gzzf005_old = ""
            LET lc_gzzf006_old = ""
            LET li_count = 0
            
            SELECT COUNT(*) INTO li_count FROM gzzf_t
             WHERE gzzf001 = lc_gzzf001
               AND gzzf003 = lc_gzzf003
               AND gzzf002 = la_gzzy[li_cnt].gzzy001

            IF li_count = 0 THEN
               #填寫過單資訊，需檢核是否存在主檔中
            #   IF NOT azzp110_insert_dzld('gzzf_t','azzi912',lc_gzzf001,' ') THEN
            #      LET g_chk_status = FALSE
            #      RETURN
            #   END IF
            
               INSERT INTO gzzf_t(gzzf001,gzzf002,gzzf003,gzzf004,gzzf005,gzzf006)
                 VALUES(lc_gzzf001,la_gzzy[li_cnt].gzzy001,lc_gzzf003,lc_std_or_cust,lc_gzzf005_new,lc_gzzf006_new)
               
               IF SQLCA.SQLCODE THEN
                  LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(insert)gzzf_t失敗...  gzzf001:",lc_gzzf001,"  gzzf002:",la_gzzy[li_cnt].gzzy001,
                                                          "  gzzf003:",lc_gzzf003,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                  CALL g_gen_ch.writeLine(lc_msg)
                  RETURN
               END IF
               LET lc_update = "Y"
            ELSE
               SELECT gzzf005,gzzf006 INTO lc_gzzf005_old,lc_gzzf006_old
                 FROM gzzf_t
                WHERE gzzf001 = lc_gzzf001
                  AND gzzf003 = lc_gzzf003
                  AND gzzf002 = la_gzzy[li_cnt].gzzy001
                  AND gzzf004 = lc_std_or_cust

                IF NOT SQLCA.SQLCODE THEN
                   #須以字典檔為主，但為避免字典檔的資料是空白的，卻蓋掉原有已存在的資料，所以要先做判斷
                   IF cl_null(lc_gzzf005_new) THEN
                      LET lc_gzzf005_new = lc_gzzf005_old
                   END IF

                   IF cl_null(lc_gzzf006_new) THEN
                      LET lc_gzzf006_new = lc_gzzf006_old
                   END IF

                   IF la_gzzy[li_cnt].gzzy001 <> "zh_TW" AND (lc_gzzf005_new <> lc_gzzf005_old
                          OR lc_gzzf006_new <> lc_gzzf006_old) THEN
                      
                      #填寫過單資訊，需檢核是否存在主檔中
                   #   IF NOT azzp110_insert_dzld('gzzf_t','azzi912',lc_gzzf001,' ') THEN
                   #      LET g_chk_status = FALSE
                   #      RETURN
                   #   END IF
            
                      UPDATE gzzf_t SET gzzf005 = lc_gzzf005_new,
                                        gzzf006 = lc_gzzf006_new
                       WHERE gzzf001 = lc_gzzf001
                         AND gzzf003 = lc_gzzf003
                         AND gzzf002 = la_gzzy[li_cnt].gzzy001
                         AND gzzf004 = lc_std_or_cust
                      
                      IF SQLCA.SQLCODE THEN
                         LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)gzzf_t失敗...  gzzf001:",lc_gzzf001,"  gzzf002:",la_gzzy[li_cnt].gzzy001,
                                                                 "  gzzf003:",lc_gzzf003,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                         CALL g_gen_ch.writeLine(lc_msg)
                         RETURN
                      END IF
                      LET lc_update = "Y"
                   END IF
                END IF
            END IF
            
            IF lc_update = "Y" THEN
               #紀錄log
               LET lc_msg = "<tr hieght=22><td class=xl24>",la_gzzy[li_cnt].gzzy001,"</td>",         #更換語系
                                          "<td class=xl24>gzzf_t</td>",               #更換的多語言table
                                          "<td class=xl24>",g_param.docno,"</td>",    #表單單號
                                          "<td class=xl24>",g_param.seq,"</td>",      #項次
                                          "<td class=xl24>azzi912</td>",              #關聯項目
                                          "<td class=xl24>",lc_gzzf001,"</td>",       #過單條件值
                                          "<td class=xl24>",lc_gzzf005_old,"</td>",   #資料修改前
                                          "<td class=xl24>",lc_gzzf005_new,"</td>",   #資料修改後
                                          "<td class=xl24>",lc_gzzf006_old,"</td>",   #資料修改前
                                          "<td class=xl24>",lc_gzzf006_new,"</td>",   #資料修改後
                            "</tr>"
         
               CALL g_gen_ch.writeLine(lc_msg)
            END IF 
         END IF
         FREE azzp110_exp_gzzf_pre
      END FOR

   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_chk_gzoy(lc_table,lc_lang,lc_key1,lc_key2,lc_key3,lc_str)
#                  RETURNING ls_return,ls_match,ls_cnt
# Input parameter: lc_table       要檢查的多語言table
#                : lc_lang        要檢查的語系
#                : lc_key1        key值欄位1
#                : lc_key2        key值欄位2
#                : lc_key3        key值欄位3
#                : lc_str         要檢查的字串
# Return code....: ls_status      沒有禁用字(TRUE)/有禁用字(FALSE)
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_chk_gzoy(lc_table,lc_lang,lc_key1,lc_key2,lc_key3,lc_str)
   DEFINE lc_table     LIKE type_t.chr20
   DEFINE lc_lang      LIKE type_t.chr10
   DEFINE lc_key1      STRING
   DEFINE lc_key2      STRING
   DEFINE lc_key3      STRING
   DEFINE lc_str       STRING
   DEFINE ls_return    STRING
   DEFINE ls_match     STRING
   DEFINE ls_cnt       LIKE type_t.num5
   DEFINE lc_msg       STRING
   DEFINE ls_status    BOOLEAN
   
   
   #檢核是否有禁用字詞
   LET ls_cnt = 0
   LET ls_status = TRUE
   
   CALL cl_trans_code_gzoy(lc_lang,'',lc_str) RETURNING ls_return,ls_match,ls_cnt
   IF ls_cnt > 0 THEN
      LET ls_status = FALSE
      IF cl_null(lc_key1) THEN
         LET lc_key1 = "NULL"
      END IF
      IF cl_null(lc_key2) THEN
         LET lc_key2 = "NULL"
      END IF
      IF cl_null(lc_key3) THEN
         LET lc_key3 = "NULL"
      END IF
      LET lc_msg = "<tr hieght=22><td class=xl24>",lc_table,"</td>",          #檢查檔案
                                 "<td class=xl24>",lc_lang,"</td>",           #檢查語系
                                 "<td class=xl24>",lc_key1,"</td>",           #key值欄位1
                                 "<td class=xl24>",lc_key2,"</td>",           #key值欄位2
                                 "<td class=xl24>",lc_key3,"</td>",           #key值欄位3
                                 "<td class=xl24>",lc_str,"</td>",            #原始字串
                                 "<td class=xl24>",ls_match,"</td>",          #禁用字    
                   "</tr>"
      
         CALL g_gen_ch.writeLine(lc_msg)
   END IF
   
   RETURN ls_status
END FUNCTION

################################################################################
# Descriptions...: 計算過單號是否已超過限制筆數
# Memo...........:
# Usage..........: CALL azzp110_chk_dzld_rows()
#                  RETURNING 回传参数
# Input parameter: 
# Return code....: 
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_chk_dzld_rows()
   DEFINE ls_sql     STRING
   DEFINE ls_cnt     LIKE type_t.num5


   IF g_param.action_type = "exp" AND (FGL_GETENV("ZONE") = "t10dev" OR FGL_GETENV("ZONE") = "t10dit") THEN
      LET ls_cnt = 0
      LET ls_sql = "SELECT COUNT(1) FROM dzld_t",
                   " WHERE dzld011 = '",g_param.docno,"'",
                     " AND dzld014 = ",g_param.seq
      PREPARE azzp110_chk_dzld_rows_pre FROM ls_sql

      EXECUTE azzp110_chk_dzld_rows_pre INTO ls_cnt

      IF ls_cnt >= lc_max_rows THEN
         LET g_chk_status = FALSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "azz-00390"
         LET g_errparam.code   = "azz-00390"
         LET g_errparam.popup  = TRUE
         LET g_errparam.replace[1] = g_param.docno
         LET g_errparam.replace[2] = g_param.seq
         CALL cl_err()
      ELSE
         LET g_chk_status = TRUE
      END IF
   END IF
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_ins_wscal_zhtw()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_ins_wscal_zhtw()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_wscal001 LIKE wscal_t.wscal001   #作業編號
   DEFINE lc_wscal007 LIKE wscal_t.wscal007   #序號
   DEFINE lc_wscal008 LIKE wscal_t.wscal008   #語言別
   DEFINE lc_wscal009 LIKE wscal_t.wscal009   #說明
   DEFINE lc_wscal009_new LIKE wscal_t.wscal009
   DEFINE li_row      LIKE type_t.num10
   DEFINE li_zhtw     LIKE type_t.num5
   DEFINE lc_gzozcrtdt LIKE gzoz_t.gzozcrtdt
   DEFINE lc_gzoz001  LIKE gzoz_t.gzoz001
   DEFINE lc_wscal    RECORD LIKE wscal_t.*
   DEFINE lc_msg      STRING
   
   
   LET ls_sql = "SELECT UNIQUE wscal001,wscal007 FROM wscal_t ",
                " WHERE (wscal008 = 'zh_TW' OR wscal008 = 'zh_CN') ",
                  " AND TRIM(wscal009) IS NOT NULL "

   #如果有外傳參數的處理
   IF g_param.extra_condition IS NOT NULL THEN
      LET ls_sql = ls_sql," ",g_param.extra_condition
   END IF

   #排序
   LET ls_sql = ls_sql, "ORDER BY wscal001,wscal007 "

   #組合SQL
   DECLARE azzp110_wscal_zhtw_cs CURSOR FROM ls_sql
   FOREACH azzp110_wscal_zhtw_cs INTO lc_wscal001,lc_wscal007
      DISPLAY "insert from wscal_t:",lc_wscal001," ",lc_wscal007
      #先檢查簡繁是否都存在
      SELECT COUNT(*) INTO li_cnt FROM wscal_t
       WHERE wscal001 = lc_wscal001 AND wscal007 = lc_wscal007
         AND (wscal008 = 'zh_TW' OR wscal008 = 'zh_CN')
         AND wscal009 IS NOT NULL
          
      #簡繁只有一筆,若為繁體直接取,若為簡體先轉詞轉碼
      IF li_cnt = 1 THEN
         SELECT * INTO lc_wscal.* FROM wscal_t
          WHERE wscal001 = lc_wscal001 AND wscal007 = lc_wscal007
            AND (wscal008 = 'zh_TW' OR wscal008 = 'zh_CN')
            AND wscal009 IS NOT NULL

         #若這唯一的一筆是簡體,就要先轉換為繁體寫回
         IF lc_wscal.wscal008 = 'zh_CN' AND NOT cl_null(lc_wscal.wscal009) THEN
            #轉換該轉的 (此處cl_trans有先寫字典檔)
            LET lc_wscal.wscal008 = "zh_TW"
            LET lc_wscal009_new = cl_trans_code_tw_cn("zh_TW",lc_wscal.wscal009)
            IF g_bgjob= "Y" AND (cl_null(lc_wscal009_new) AND NOT cl_null(lc_wscal.wscal009)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>wscal_t</td>",                      #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_wscal.wscal001,"</td>",        #key值欄位1
                                          "<td class=xl24>",lc_wscal.wscal007,"</td>",        #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_wscal.wscal009,"</td>",        #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字
                            "</tr>"

               CALL g_gen_ch.writeLine(lc_msg)

               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_wscal.wscal009 = lc_wscal009_new

            #回寫
            INSERT INTO wscal_t VALUES (lc_wscal.*)

         END IF
      ELSE
         IF li_cnt = 2 THEN
           #簡繁有2筆時, 重抓資料
            SELECT * INTO lc_wscal.* FROM wscal_t
             WHERE wscal001 = lc_wscal001 AND wscal007 = lc_wscal007
               AND wscal008 = "zh_TW"
         END IF
      END IF

      IF li_cnt > 0 THEN
         #再檢查字典檔,遇缺則補入
         IF azzp110_chk_gzoy("wscal_t",lc_wscal.wscal008,lc_wscal.wscal001,lc_wscal.wscal007,'',lc_wscal.wscal009) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_wscal.wscal009,'','','')
         END IF
      END IF

   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_ins_wsebl_zhtw()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_ins_wsebl_zhtw()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_wsebl001 LIKE wsebl_t.wsebl001   #產品別
   DEFINE lc_wsebl002 LIKE wsebl_t.wsebl002   #查詢編號
   DEFINE lc_wsebl003 LIKE wsebl_t.wsebl003   #語言別
   DEFINE lc_wsebl004 LIKE wsebl_t.wsebl004   #說明
   DEFINE lc_wsebl004_new LIKE wsebl_t.wsebl004
   DEFINE li_row      LIKE type_t.num10
   DEFINE li_zhtw     LIKE type_t.num5
   DEFINE lc_gzozcrtdt LIKE gzoz_t.gzozcrtdt
   DEFINE lc_gzoz001  LIKE gzoz_t.gzoz001
   DEFINE lc_wsebl    RECORD LIKE wsebl_t.*
   DEFINE lc_msg      STRING
   
   
   LET ls_sql = "SELECT UNIQUE wsebl001,wsebl002 FROM wsebl_t ",
                " WHERE (wsebl003 = 'zh_TW' OR wsebl003 = 'zh_CN') ",
                  " AND TRIM(wsebl004) IS NOT NULL "

   #如果有外傳參數的處理
   IF g_param.extra_condition IS NOT NULL THEN
      LET ls_sql = ls_sql," ",g_param.extra_condition
   END IF

   #排序
   LET ls_sql = ls_sql, "ORDER BY wsebl001,wsebl002 "

   #組合SQL
   DECLARE azzp110_wsebl_zhtw_cs CURSOR FROM ls_sql
   FOREACH azzp110_wsebl_zhtw_cs INTO lc_wsebl001,lc_wsebl002
      DISPLAY "insert from wsebl_t:",lc_wsebl001," ",lc_wsebl002
      #先檢查簡繁是否都存在
      SELECT COUNT(*) INTO li_cnt FROM wsebl_t
       WHERE wsebl001 = lc_wsebl001 AND wsebl002 = lc_wsebl002
         AND (wsebl003 = 'zh_TW' OR wsebl003 = 'zh_CN')
         AND wsebl004 IS NOT NULL
          
      #簡繁只有一筆,若為繁體直接取,若為簡體先轉詞轉碼
      IF li_cnt = 1 THEN
         SELECT * INTO lc_wsebl.* FROM wsebl_t
          WHERE wsebl001 = lc_wsebl001 AND wsebl002 = lc_wsebl002
            AND (wsebl003 = 'zh_TW' OR wsebl003 = 'zh_CN')
            AND wsebl004 IS NOT NULL

         #若這唯一的一筆是簡體,就要先轉換為繁體寫回
         IF lc_wsebl.wsebl003 = 'zh_CN' AND NOT cl_null(lc_wsebl.wsebl004) THEN
            #轉換該轉的 (此處cl_trans有先寫字典檔)
            LET lc_wsebl.wsebl003 = "zh_TW"
            LET lc_wsebl004_new = cl_trans_code_tw_cn("zh_TW",lc_wsebl.wsebl004)
            IF g_bgjob= "Y" AND (cl_null(lc_wsebl004_new) AND NOT cl_null(lc_wsebl.wsebl004)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>wsebl_t</td>",                      #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_wsebl.wsebl001,"</td>",        #key值欄位1
                                          "<td class=xl24>",lc_wsebl.wsebl002,"</td>",        #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_wsebl.wsebl004,"</td>",        #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字
                            "</tr>"

               CALL g_gen_ch.writeLine(lc_msg)

               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_wsebl.wsebl004 = lc_wsebl004_new

            #回寫
            INSERT INTO wsebl_t VALUES (lc_wsebl.*)

         END IF
      ELSE
         IF li_cnt = 2 THEN
           #簡繁有2筆時, 重抓資料
            SELECT * INTO lc_wsebl.* FROM wsebl_t
             WHERE wsebl001 = lc_wsebl001 AND wsebl002 = lc_wsebl002
               AND wsebl003 = "zh_TW"
         END IF
      END IF

      IF li_cnt > 0 THEN
         #再檢查字典檔,遇缺則補入
         IF azzp110_chk_gzoy("wsebl_t",lc_wsebl.wsebl003,lc_wsebl.wsebl001,lc_wsebl.wsebl002,'',lc_wsebl.wsebl004) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_wsebl.wsebl004,'','','')
         END IF
      END IF

   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_ins_wsecl_zhtw()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_ins_wsecl_zhtw()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_wsecl001 LIKE wsecl_t.wsecl001   #產品別
   DEFINE lc_wsecl002 LIKE wsecl_t.wsecl002   #語言別
   DEFINE lc_wsecl003 LIKE wsecl_t.wsecl003   #說明
   DEFINE lc_wsecl003_new LIKE wsecl_t.wsecl003
   DEFINE li_row      LIKE type_t.num10
   DEFINE li_zhtw     LIKE type_t.num5
   DEFINE lc_gzozcrtdt LIKE gzoz_t.gzozcrtdt
   DEFINE lc_gzoz001  LIKE gzoz_t.gzoz001
   DEFINE lc_wsecl    RECORD LIKE wsecl_t.*
   DEFINE lc_msg      STRING
   
   
   LET ls_sql = "SELECT UNIQUE wsecl001 FROM wsecl_t ",
                " WHERE (wsecl002 = 'zh_TW' OR wsecl002 = 'zh_CN') ",
                  " AND TRIM(wsecl003) IS NOT NULL "

   #如果有外傳參數的處理
   IF g_param.extra_condition IS NOT NULL THEN
      LET ls_sql = ls_sql," ",g_param.extra_condition
   END IF

   #排序
   LET ls_sql = ls_sql, "ORDER BY wsecl001 "

   #組合SQL
   DECLARE azzp110_wsecl_zhtw_cs CURSOR FROM ls_sql
   FOREACH azzp110_wsecl_zhtw_cs INTO lc_wsecl001
      DISPLAY "insert from wsecl_t:",lc_wsecl001
      #先檢查簡繁是否都存在
      SELECT COUNT(*) INTO li_cnt FROM wsecl_t
       WHERE wsecl001 = lc_wsecl001
         AND (wsecl002 = 'zh_TW' OR wsecl002 = 'zh_CN')
         AND wsecl003 IS NOT NULL
          
      #簡繁只有一筆,若為繁體直接取,若為簡體先轉詞轉碼
      IF li_cnt = 1 THEN
         SELECT * INTO lc_wsecl.* FROM wsecl_t
          WHERE wsecl001 = lc_wsecl001
            AND (wsecl002 = 'zh_TW' OR wsecl002 = 'zh_CN')
            AND wsecl003 IS NOT NULL

         #若這唯一的一筆是簡體,就要先轉換為繁體寫回
         IF lc_wsecl.wsecl002 = 'zh_CN' AND NOT cl_null(lc_wsecl.wsecl003) THEN
            #轉換該轉的 (此處cl_trans有先寫字典檔)
            LET lc_wsecl.wsecl002 = "zh_TW"
            LET lc_wsecl003_new = cl_trans_code_tw_cn("zh_TW",lc_wsecl.wsecl003)
            IF g_bgjob= "Y" AND (cl_null(lc_wsecl003_new) AND NOT cl_null(lc_wsecl.wsecl003)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>wsecl_t</td>",                      #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_wsecl.wsecl001,"</td>",        #key值欄位1
                                          "<td class=xl24></td>",                             #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_wsecl.wsecl003,"</td>",        #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字
                            "</tr>"

               CALL g_gen_ch.writeLine(lc_msg)

               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_wsecl.wsecl003 = lc_wsecl003_new

            #回寫
            INSERT INTO wsecl_t VALUES (lc_wsecl.*)

         END IF
      ELSE
         IF li_cnt = 2 THEN
           #簡繁有2筆時, 重抓資料
            SELECT * INTO lc_wsecl.* FROM wsecl_t
             WHERE wsecl001 = lc_wsecl001
               AND wsecl002 = "zh_TW"
         END IF
      END IF

      IF li_cnt > 0 THEN
         #再檢查字典檔,遇缺則補入
         IF azzp110_chk_gzoy("wsecl_t",lc_wsecl.wsecl002,lc_wsecl.wsecl001,'','',lc_wsecl.wsecl003) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_wsecl.wsecl003,'','','')
         END IF
      END IF

   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_ins_gzgjl_zhtw()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_ins_gzgjl_zhtw()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_gzgjl001 LIKE gzgjl_t.gzgjl001   #表頭編號
   DEFINE lc_gzgjl002 LIKE gzgjl_t.gzgjl002   #語言別
   DEFINE lc_gzgjl003 LIKE gzgjl_t.gzgjl003   #說明
   DEFINE lc_gzgjl003_new LIKE gzgjl_t.gzgjl003
   DEFINE li_row      LIKE type_t.num10
   DEFINE li_zhtw     LIKE type_t.num5
   DEFINE lc_gzozcrtdt LIKE gzoz_t.gzozcrtdt
   DEFINE lc_gzoz001  LIKE gzoz_t.gzoz001
   DEFINE lc_gzgjl    RECORD LIKE gzgjl_t.*
   DEFINE lc_msg      STRING
   
   
   LET ls_sql = "SELECT UNIQUE gzgjl001 FROM gzgjl_t ",
                " WHERE (gzgjl002 = 'zh_TW' OR gzgjl002 = 'zh_CN') ",
                  " AND TRIM(gzgjl003) IS NOT NULL "

   #如果有外傳參數的處理
   IF g_param.extra_condition IS NOT NULL THEN
      LET ls_sql = ls_sql," ",g_param.extra_condition
   END IF

   #排序
   LET ls_sql = ls_sql, "ORDER BY gzgjl001 "

   #組合SQL
   DECLARE azzp110_gzgjl_zhtw_cs CURSOR FROM ls_sql
   FOREACH azzp110_gzgjl_zhtw_cs INTO lc_gzgjl001
      DISPLAY "insert from gzgjl_t:",lc_gzgjl001
      #先檢查簡繁是否都存在
      SELECT COUNT(*) INTO li_cnt FROM gzgjl_t
       WHERE gzgjl001 = lc_gzgjl001
         AND (gzgjl002 = 'zh_TW' OR gzgjl002 = 'zh_CN')
         AND gzgjl003 IS NOT NULL
          
      #簡繁只有一筆,若為繁體直接取,若為簡體先轉詞轉碼
      IF li_cnt = 1 THEN
         SELECT * INTO lc_gzgjl.* FROM gzgjl_t
          WHERE gzgjl001 = lc_gzgjl001
            AND (gzgjl002 = 'zh_TW' OR gzgjl002 = 'zh_CN')
            AND gzgjl003 IS NOT NULL

         #若這唯一的一筆是簡體,就要先轉換為繁體寫回
         IF lc_gzgjl.gzgjl002 = 'zh_CN' AND NOT cl_null(lc_gzgjl.gzgjl003) THEN
            #轉換該轉的 (此處cl_trans有先寫字典檔)
            LET lc_gzgjl.gzgjl002 = "zh_TW"
            LET lc_gzgjl003_new = cl_trans_code_tw_cn("zh_TW",lc_gzgjl.gzgjl003)
            IF g_bgjob= "Y" AND (cl_null(lc_gzgjl003_new) AND NOT cl_null(lc_gzgjl.gzgjl003)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>gzgjl_t</td>",                      #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_gzgjl.gzgjl001,"</td>",        #key值欄位1
                                          "<td class=xl24></td>",                             #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_gzgjl.gzgjl003,"</td>",        #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字
                            "</tr>"

               CALL g_gen_ch.writeLine(lc_msg)

               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_gzgjl.gzgjl003 = lc_gzgjl003_new

            #回寫
            INSERT INTO gzgjl_t VALUES (lc_gzgjl.*)

         END IF
      ELSE
         IF li_cnt = 2 THEN
           #簡繁有2筆時, 重抓資料
            SELECT * INTO lc_gzgjl.* FROM gzgjl_t
             WHERE gzgjl001 = lc_gzgjl001
               AND gzgjl002 = "zh_TW"
         END IF
      END IF

      IF li_cnt > 0 THEN
         #再檢查字典檔,遇缺則補入
         IF azzp110_chk_gzoy("gzgjl_t",lc_gzgjl.gzgjl002,lc_gzgjl.gzgjl001,'','',lc_gzgjl.gzgjl003) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_gzgjl.gzgjl003,'','','')
         END IF
      END IF

   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_ins_gzahl_zhtw()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_ins_gzahl_zhtw()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_gzahl001 LIKE gzahl_t.gzahl001   #單據程式
   DEFINE lc_gzahl002 LIKE gzahl_t.gzahl002   #序號
   DEFINE lc_gzahl003 LIKE gzahl_t.gzahl003   #語言別
   DEFINE lc_gzahl004 LIKE gzahl_t.gzahl004   #報表說明
   DEFINE lc_gzahl004_new LIKE gzahl_t.gzahl004
   DEFINE li_row      LIKE type_t.num10
   DEFINE li_zhtw     LIKE type_t.num5
   DEFINE lc_gzozcrtdt LIKE gzoz_t.gzozcrtdt
   DEFINE lc_gzoz001  LIKE gzoz_t.gzoz001
   DEFINE lc_gzahl    RECORD LIKE gzahl_t.*
   DEFINE lc_msg      STRING
   
   
   LET ls_sql = "SELECT UNIQUE gzahl001,gzahl002 FROM gzahl_t ",
                " WHERE (gzahl003 = 'zh_TW' OR gzahl003 = 'zh_CN') ",
                  " AND TRIM(gzahl004) IS NOT NULL "

   #如果有外傳參數的處理
   IF g_param.extra_condition IS NOT NULL THEN
      LET ls_sql = ls_sql," ",g_param.extra_condition
   END IF

   #排序
   LET ls_sql = ls_sql, "ORDER BY gzahl001,gzahl002 "

   #組合SQL
   DECLARE azzp110_gzahl_zhtw_cs CURSOR FROM ls_sql
   FOREACH azzp110_gzahl_zhtw_cs INTO lc_gzahl001,lc_gzahl002
      DISPLAY "insert from gzahl_t:",lc_gzahl001," ",lc_gzahl002
      #先檢查簡繁是否都存在
      SELECT COUNT(*) INTO li_cnt FROM gzahl_t
       WHERE gzahl001 = lc_gzahl001 AND gzahl002 = lc_gzahl002
         AND (gzahl003 = 'zh_TW' OR gzahl003 = 'zh_CN')
         AND gzahl004 IS NOT NULL
          
      #簡繁只有一筆,若為繁體直接取,若為簡體先轉詞轉碼
      IF li_cnt = 1 THEN
         SELECT * INTO lc_gzahl.* FROM gzahl_t
          WHERE gzahl001 = lc_gzahl001 AND gzahl002 = lc_gzahl002
            AND (gzahl003 = 'zh_TW' OR gzahl003 = 'zh_CN')
            AND gzahl004 IS NOT NULL

         #若這唯一的一筆是簡體,就要先轉換為繁體寫回
         IF lc_gzahl.gzahl003 = 'zh_CN' AND NOT cl_null(lc_gzahl.gzahl004) THEN
            #轉換該轉的 (此處cl_trans有先寫字典檔)
            LET lc_gzahl.gzahl003 = "zh_TW"
            LET lc_gzahl004_new = cl_trans_code_tw_cn("zh_TW",lc_gzahl.gzahl004)
            IF g_bgjob= "Y" AND (cl_null(lc_gzahl004_new) AND NOT cl_null(lc_gzahl.gzahl004)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>gzahl_t</td>",                      #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_gzahl.gzahl001,"</td>",        #key值欄位1
                                          "<td class=xl24>",lc_gzahl.gzahl002,"</td>",        #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_gzahl.gzahl004,"</td>",        #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字
                            "</tr>"

               CALL g_gen_ch.writeLine(lc_msg)

               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_gzahl.gzahl004 = lc_gzahl004_new

            #回寫
            INSERT INTO gzahl_t VALUES (lc_gzahl.*)

         END IF
      ELSE
         IF li_cnt = 2 THEN
           #簡繁有2筆時, 重抓資料
            SELECT * INTO lc_gzahl.* FROM gzahl_t
             WHERE gzahl001 = lc_gzahl001 AND gzahl002 = lc_gzahl002
               AND gzahl003 = "zh_TW"
         END IF
      END IF

      IF li_cnt > 0 THEN
         #再檢查字典檔,遇缺則補入
         IF azzp110_chk_gzoy("gzahl_t",lc_gzahl.gzahl003,lc_gzahl.gzahl001,lc_gzahl.gzahl002,'',lc_gzahl.gzahl004) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_gzahl.gzahl004,'','','')
         END IF
      END IF

   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_ins_gzgp_zhtw()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_ins_gzgp_zhtw()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_gzgp001  LIKE gzgp_t.gzgp001   #簽核編號
   DEFINE lc_gzgp002  LIKE gzgp_t.gzgp002   #序號
   DEFINE lc_gzgp003  LIKE gzgp_t.gzgp003   #語言別
   DEFINE lc_gzgp004  LIKE gzgp_t.gzgp004   #職稱
   DEFINE lc_gzgp004_new LIKE gzgp_t.gzgp004
   DEFINE li_row      LIKE type_t.num10
   DEFINE li_zhtw     LIKE type_t.num5
   DEFINE lc_gzozcrtdt LIKE gzoz_t.gzozcrtdt
   DEFINE lc_gzoz001  LIKE gzoz_t.gzoz001
   DEFINE lc_gzgp     RECORD LIKE gzgp_t.*
   DEFINE lc_msg      STRING
   
   
   LET ls_sql = "SELECT UNIQUE gzgp001,gzgp002 FROM gzgp_t ",
                " WHERE (gzgp003 = 'zh_TW' OR gzgp003 = 'zh_CN') ",
                  " AND TRIM(gzgp004) IS NOT NULL "

   #如果有外傳參數的處理
   IF g_param.extra_condition IS NOT NULL THEN
      LET ls_sql = ls_sql," ",g_param.extra_condition
   END IF

   #排序
   LET ls_sql = ls_sql, "ORDER BY gzgp001,gzgp002 "

   #組合SQL
   DECLARE azzp110_gzgp_zhtw_cs CURSOR FROM ls_sql
   FOREACH azzp110_gzgp_zhtw_cs INTO lc_gzgp001,lc_gzgp002
      DISPLAY "insert from gzgp_t:",lc_gzgp001," ",lc_gzgp002
      #先檢查簡繁是否都存在
      SELECT COUNT(*) INTO li_cnt FROM gzgp_t
       WHERE gzgp001 = lc_gzgp001 AND gzgp002 = lc_gzgp002
         AND (gzgp003 = 'zh_TW' OR gzgp003 = 'zh_CN')
         AND gzgp004 IS NOT NULL
          
      #簡繁只有一筆,若為繁體直接取,若為簡體先轉詞轉碼
      IF li_cnt = 1 THEN
         SELECT * INTO lc_gzgp.* FROM gzgp_t
          WHERE gzgp001 = lc_gzgp001 AND gzgp002 = lc_gzgp002
            AND (gzgp003 = 'zh_TW' OR gzgp003 = 'zh_CN')
            AND gzgp004 IS NOT NULL

         #若這唯一的一筆是簡體,就要先轉換為繁體寫回
         IF lc_gzgp.gzgp003 = 'zh_CN' AND NOT cl_null(lc_gzgp.gzgp004) THEN
            #轉換該轉的 (此處cl_trans有先寫字典檔)
            LET lc_gzgp.gzgp003 = "zh_TW"
            LET lc_gzgp004_new = cl_trans_code_tw_cn("zh_TW",lc_gzgp.gzgp004)
            IF g_bgjob= "Y" AND (cl_null(lc_gzgp004_new) AND NOT cl_null(lc_gzgp.gzgp004)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>gzgp_t</td>",                       #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_gzgp.gzgp001,"</td>",          #key值欄位1
                                          "<td class=xl24>",lc_gzgp.gzgp002,"</td>",          #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_gzgp.gzgp004,"</td>",          #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字
                            "</tr>"

               CALL g_gen_ch.writeLine(lc_msg)

               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_gzgp.gzgp004 = lc_gzgp004_new

            #回寫
            INSERT INTO gzgp_t VALUES (lc_gzgp.*)

         END IF
      ELSE
         IF li_cnt = 2 THEN
           #簡繁有2筆時, 重抓資料
            SELECT * INTO lc_gzgp.* FROM gzgp_t
             WHERE gzgp001 = lc_gzgp001 AND gzgp002 = lc_gzgp002
               AND gzgp003 = "zh_TW"
         END IF
      END IF

      IF li_cnt > 0 THEN
         #再檢查字典檔,遇缺則補入
         IF azzp110_chk_gzoy("gzgp_t",lc_gzgp.gzgp003,lc_gzgp.gzgp001,lc_gzgp.gzgp002,'',lc_gzgp.gzgp004) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_gzgp.gzgp004,'','','')
         END IF
      END IF

   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_ins_rpdel_zhtw()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_ins_rpdel_zhtw()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_rpdel001 LIKE rpdel_t.rpdel001   #產品別
   DEFINE lc_rpdel002 LIKE rpdel_t.rpdel002   #查詢編號
   DEFINE lc_rpdel003 LIKE rpdel_t.rpdel003   #語言別
   DEFINE lc_rpdel004 LIKE rpdel_t.rpdel004   #說明
   DEFINE lc_rpdel004_new LIKE rpdel_t.rpdel004
   DEFINE li_row      LIKE type_t.num10
   DEFINE li_zhtw     LIKE type_t.num5
   DEFINE lc_gzozcrtdt LIKE gzoz_t.gzozcrtdt
   DEFINE lc_gzoz001  LIKE gzoz_t.gzoz001
   DEFINE lc_rpdel    RECORD LIKE rpdel_t.*
   DEFINE lc_msg      STRING
   
   
   LET ls_sql = "SELECT UNIQUE rpdel001,rpdel002 FROM rpdel_t ",
                " WHERE (rpdel003 = 'zh_TW' OR rpdel003 = 'zh_CN') ",
                  " AND TRIM(rpdel004) IS NOT NULL "

   #如果有外傳參數的處理
   IF g_param.extra_condition IS NOT NULL THEN
      LET ls_sql = ls_sql," ",g_param.extra_condition
   END IF

   #排序
   LET ls_sql = ls_sql, "ORDER BY rpdel001,rpdel002 "

   #組合SQL
   DECLARE azzp110_rpdel_zhtw_cs CURSOR FROM ls_sql
   FOREACH azzp110_rpdel_zhtw_cs INTO lc_rpdel001,lc_rpdel002
      DISPLAY "insert from rpdel_t:",lc_rpdel001," ",lc_rpdel002
      #先檢查簡繁是否都存在
      SELECT COUNT(*) INTO li_cnt FROM rpdel_t
       WHERE rpdel001 = lc_rpdel001 AND rpdel002 = lc_rpdel002
         AND (rpdel003 = 'zh_TW' OR rpdel003 = 'zh_CN')
         AND rpdel004 IS NOT NULL
          
      #簡繁只有一筆,若為繁體直接取,若為簡體先轉詞轉碼
      IF li_cnt = 1 THEN
         SELECT * INTO lc_rpdel.* FROM rpdel_t
          WHERE rpdel001 = lc_rpdel001 AND rpdel002 = lc_rpdel002
            AND (rpdel003 = 'zh_TW' OR rpdel003 = 'zh_CN')
            AND rpdel004 IS NOT NULL

         #若這唯一的一筆是簡體,就要先轉換為繁體寫回
         IF lc_rpdel.rpdel003 = 'zh_CN' AND NOT cl_null(lc_rpdel.rpdel004) THEN
            #轉換該轉的 (此處cl_trans有先寫字典檔)
            LET lc_rpdel.rpdel003 = "zh_TW"
            LET lc_rpdel004_new = cl_trans_code_tw_cn("zh_TW",lc_rpdel.rpdel004)
            IF g_bgjob= "Y" AND (cl_null(lc_rpdel004_new) AND NOT cl_null(lc_rpdel.rpdel004)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>rpdel_t</td>",                      #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_rpdel.rpdel001,"</td>",        #key值欄位1
                                          "<td class=xl24>",lc_rpdel.rpdel002,"</td>",        #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_rpdel.rpdel004,"</td>",        #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字
                            "</tr>"

               CALL g_gen_ch.writeLine(lc_msg)

               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_rpdel.rpdel004 = lc_rpdel004_new

            #回寫
            INSERT INTO rpdel_t VALUES (lc_rpdel.*)

         END IF
      ELSE
         IF li_cnt = 2 THEN
           #簡繁有2筆時, 重抓資料
            SELECT * INTO lc_rpdel.* FROM rpdel_t
             WHERE rpdel001 = lc_rpdel001 AND rpdel002 = lc_rpdel002
               AND rpdel003 = "zh_TW"
         END IF
      END IF

      IF li_cnt > 0 THEN
         #再檢查字典檔,遇缺則補入
         IF azzp110_chk_gzoy("wsebl_t",lc_rpdel.rpdel003,lc_rpdel.rpdel001,lc_rpdel.rpdel002,'',lc_rpdel.rpdel004) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_rpdel.rpdel004,'','','')
         END IF
      END IF

   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_ins_rpzzl_zhtw()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_ins_rpzzl_zhtw()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_rpzzl001 LIKE rpzzl_t.rpzzl001   #APP編號
   DEFINE lc_rpzzl002 LIKE rpzzl_t.rpzzl002   #語言別
   DEFINE lc_rpzzl003 LIKE rpzzl_t.rpzzl003   #說明
   DEFINE lc_rpzzl003_new LIKE rpzzl_t.rpzzl003
   DEFINE li_row      LIKE type_t.num10
   DEFINE li_zhtw     LIKE type_t.num5
   DEFINE lc_gzozcrtdt LIKE gzoz_t.gzozcrtdt
   DEFINE lc_gzoz001  LIKE gzoz_t.gzoz001
   DEFINE lc_rpzzl    RECORD LIKE rpzzl_t.*
   DEFINE lc_msg      STRING
   
   
   LET ls_sql = "SELECT UNIQUE rpzzl001 FROM rpzzl_t ",
                " WHERE (rpzzl002 = 'zh_TW' OR rpzzl002 = 'zh_CN') ",
                  " AND TRIM(rpzzl003) IS NOT NULL "

   #如果有外傳參數的處理
   IF g_param.extra_condition IS NOT NULL THEN
      LET ls_sql = ls_sql," ",g_param.extra_condition
   END IF

   #排序
   LET ls_sql = ls_sql, "ORDER BY rpzzl001 "

   #組合SQL
   DECLARE azzp110_rpzzl_zhtw_cs CURSOR FROM ls_sql
   FOREACH azzp110_rpzzl_zhtw_cs INTO lc_rpzzl001
      DISPLAY "insert from rpzzl_t:",lc_rpzzl001
      #先檢查簡繁是否都存在
      SELECT COUNT(*) INTO li_cnt FROM rpzzl_t
       WHERE rpzzl001 = lc_rpzzl001
         AND (rpzzl002 = 'zh_TW' OR rpzzl002 = 'zh_CN')
         AND rpzzl003 IS NOT NULL
          
      #簡繁只有一筆,若為繁體直接取,若為簡體先轉詞轉碼
      IF li_cnt = 1 THEN
         SELECT * INTO lc_rpzzl.* FROM rpzzl_t
          WHERE rpzzl001 = lc_rpzzl001
            AND (rpzzl002 = 'zh_TW' OR rpzzl002 = 'zh_CN')
            AND rpzzl003 IS NOT NULL

         #若這唯一的一筆是簡體,就要先轉換為繁體寫回
         IF lc_rpzzl.rpzzl002 = 'zh_CN' AND NOT cl_null(lc_rpzzl.rpzzl003) THEN
            #轉換該轉的 (此處cl_trans有先寫字典檔)
            LET lc_rpzzl.rpzzl002 = "zh_TW"
            LET lc_rpzzl003_new = cl_trans_code_tw_cn("zh_TW",lc_rpzzl.rpzzl003)
            IF g_bgjob= "Y" AND (cl_null(lc_rpzzl003_new) AND NOT cl_null(lc_rpzzl.rpzzl003)) THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>rpzzl_t</td>",                      #檢查檔案
                                          "<td class=xl24>zh_CN</td>",                        #檢查語系
                                          "<td class=xl24>",lc_rpzzl.rpzzl001,"</td>",        #key值欄位1
                                          "<td class=xl24></td>",                             #key值欄位2
                                          "<td class=xl24></td>",                             #key值欄位3
                                          "<td class=xl24>",lc_rpzzl.rpzzl003,"</td>",        #原始字串
                                          "<td class=xl24>",g_err_code.replace[1],"</td>",    #禁用字
                            "</tr>"

               CALL g_gen_ch.writeLine(lc_msg)

               #若是繁簡互轉時，轉出來的字串是空的，則不新增到原始檔案
               CONTINUE FOREACH
            END IF
            LET lc_rpzzl.rpzzl003 = lc_rpzzl003_new

            #回寫
            INSERT INTO rpzzl_t VALUES (lc_rpzzl.*)

         END IF
      ELSE
         IF li_cnt = 2 THEN
           #簡繁有2筆時, 重抓資料
            SELECT * INTO lc_rpzzl.* FROM rpzzl_t
             WHERE rpzzl001 = lc_rpzzl001
               AND rpzzl002 = "zh_TW"
         END IF
      END IF

      IF li_cnt > 0 THEN
         #再檢查字典檔,遇缺則補入
         IF azzp110_chk_gzoy("rpzzl_t",lc_rpzzl.rpzzl002,lc_rpzzl.rpzzl001,'','',lc_rpzzl.rpzzl003) THEN
            CALL azzp110_chk_gzoz_and_insert(lc_rpzzl.rpzzl003,'','','')
         END IF
      END IF

   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_chk_wscal_twcn()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_chk_wscal_twcn()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_wscal001 LIKE wscal_t.wscal001
   DEFINE lc_wscal007 LIKE wscal_t.wscal007
   DEFINE lc_wscal008 LIKE wscal_t.wscal008
   DEFINE lc_wscal009 LIKE wscal_t.wscal009
   DEFINE li_row      LIKE type_t.num10
   DEFINE lc_msg      STRING

   
   LET ls_sql = "SELECT wscal001,wscal007,wscal008,wscal009 FROM wscal_t ",
                " WHERE wscal008 = 'zh_TW' OR wscal008 = 'zh_CN' ",
                " ORDER BY wscal001,wscal007,wscal008"
   LET li_cnt = 1 
                
   DECLARE azzp110_wscal_twcn_cs CURSOR FROM ls_sql
   FOREACH azzp110_wscal_twcn_cs INTO lc_wscal001,lc_wscal007,lc_wscal008,lc_wscal009
      DISPLAY "check tw_cn wscal_t:",lc_wscal001," ",lc_wscal007
      IF cl_null(lc_wscal009) THEN
         CONTINUE FOREACH
      END IF
      CALL azzp110_trim(lc_wscal009) RETURNING lc_wscal009
      IF NOT cl_chk_tworcn(lc_wscal008 CLIPPED,lc_wscal009 CLIPPED,0) THEN
         DISPLAY li_cnt," Error Translate-lc_wscal001:",lc_wscal001,"   lc_wscal007:",lc_wscal007,
                        "   lc_wscal008:",lc_wscal008,"  lc_wscal009:",lc_wscal009
         LET li_cnt = li_cnt + 1
                        
         LET lc_msg = "<tr hieght=22><td class=xl24>wscal_t</td>",                      #檢查檔案
                                    "<td class=xl24>",lc_wscal001,"</td>",              #key欄位1
                                    "<td class=xl24>",lc_wscal007,"</td>",              #key欄位2
                                    "<td class=xl24></td>",                             #key欄位3
                                    "<td class=xl24>",lc_wscal008,"</td>",              #檢查語系
                                    "<td class=xl24>",lc_wscal009,"</td>",              #原始字串
                      "</tr>"

         CALL g_gen_ch.writeLine(lc_msg)
      END IF
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_chk_wsebl_twcn()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_chk_wsebl_twcn()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_wsebl001 LIKE wsebl_t.wsebl001
   DEFINE lc_wsebl002 LIKE wsebl_t.wsebl002
   DEFINE lc_wsebl003 LIKE wsebl_t.wsebl003
   DEFINE lc_wsebl004 LIKE wsebl_t.wsebl004
   DEFINE li_row      LIKE type_t.num10
   DEFINE lc_msg      STRING

   
   LET ls_sql = "SELECT wsebl001,wsebl002,wsebl003,wsebl004 FROM wsebl_t ",
                " WHERE wsebl003 = 'zh_TW' OR wsebl003 = 'zh_CN' ",
                " ORDER BY wsebl001,wsebl002,wsebl003"
   LET li_cnt = 1 
                
   DECLARE azzp110_wsebl_twcn_cs CURSOR FROM ls_sql
   FOREACH azzp110_wsebl_twcn_cs INTO lc_wsebl001,lc_wsebl002,lc_wsebl003,lc_wsebl004
      DISPLAY "check tw_cn wsebl_t:",lc_wsebl001," ",lc_wsebl002
      IF cl_null(lc_wsebl004) THEN
         CONTINUE FOREACH
      END IF
      CALL azzp110_trim(lc_wsebl004) RETURNING lc_wsebl004
      IF NOT cl_chk_tworcn(lc_wsebl003 CLIPPED,lc_wsebl004 CLIPPED,0) THEN
         DISPLAY li_cnt," Error Translate-lc_wsebl001:",lc_wsebl001,"   lc_wsebl002:",lc_wsebl002,
                        "   lc_wsebl003:",lc_wsebl003,"  lc_wsebl004:",lc_wsebl004
         LET li_cnt = li_cnt + 1
                        
         LET lc_msg = "<tr hieght=22><td class=xl24>wsebl_t</td>",                      #檢查檔案
                                    "<td class=xl24>",lc_wsebl001,"</td>",              #key欄位1
                                    "<td class=xl24>",lc_wsebl002,"</td>",              #key欄位2
                                    "<td class=xl24></td>",                             #key欄位3
                                    "<td class=xl24>",lc_wsebl003,"</td>",              #檢查語系
                                    "<td class=xl24>",lc_wsebl004,"</td>",              #原始字串
                      "</tr>"

         CALL g_gen_ch.writeLine(lc_msg)
      END IF
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_chk_wsecl_twcn()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_chk_wsecl_twcn()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_wsecl001 LIKE wsecl_t.wsecl001
   DEFINE lc_wsecl002 LIKE wsecl_t.wsecl002
   DEFINE lc_wsecl003 LIKE wsecl_t.wsecl003
   DEFINE li_row      LIKE type_t.num10
   DEFINE lc_msg      STRING

   
   LET ls_sql = "SELECT wsecl001,wsecl002,wsecl003 FROM wsecl_t ",
                " WHERE wsecl002 = 'zh_TW' OR wsecl002 = 'zh_CN' ",
                " ORDER BY wsecl001,wsecl002"
   LET li_cnt = 1 
                
   DECLARE azzp110_wsecl_twcn_cs CURSOR FROM ls_sql
   FOREACH azzp110_wsecl_twcn_cs INTO lc_wsecl001,lc_wsecl002,lc_wsecl003
      DISPLAY "check tw_cn wsecl_t:",lc_wsecl001
      IF cl_null(lc_wsecl003) THEN
         CONTINUE FOREACH
      END IF
      CALL azzp110_trim(lc_wsecl003) RETURNING lc_wsecl003
      IF NOT cl_chk_tworcn(lc_wsecl002 CLIPPED,lc_wsecl003 CLIPPED,0) THEN
         DISPLAY li_cnt," Error Translate-lc_wsecl001:",lc_wsecl001,"   lc_wsecl002:",lc_wsecl002,
                        "   lc_wsecl003:",lc_wsecl003
         LET li_cnt = li_cnt + 1
                        
         LET lc_msg = "<tr hieght=22><td class=xl24>wsecl_t</td>",                      #檢查檔案
                                    "<td class=xl24>",lc_wsecl001,"</td>",              #key欄位1
                                    "<td class=xl24></td>",                             #key欄位2
                                    "<td class=xl24></td>",                             #key欄位3
                                    "<td class=xl24>",lc_wsecl002,"</td>",              #檢查語系
                                    "<td class=xl24>",lc_wsecl003,"</td>",              #原始字串
                      "</tr>"

         CALL g_gen_ch.writeLine(lc_msg)
      END IF
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_chk_gzgjl_twcn()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_chk_gzgjl_twcn()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_gzgjl001 LIKE gzgjl_t.gzgjl001
   DEFINE lc_gzgjl002 LIKE gzgjl_t.gzgjl002
   DEFINE lc_gzgjl003 LIKE gzgjl_t.gzgjl003
   DEFINE li_row      LIKE type_t.num10
   DEFINE lc_msg      STRING

   
   LET ls_sql = "SELECT gzgjl001,gzgjl002,gzgjl003 FROM gzgjl_t ",
                " WHERE gzgjl002 = 'zh_TW' OR gzgjl002 = 'zh_CN' ",
                " ORDER BY gzgjl001,gzgjl002"
   LET li_cnt = 1 
                
   DECLARE azzp110_gzgjl_twcn_cs CURSOR FROM ls_sql
   FOREACH azzp110_gzgjl_twcn_cs INTO lc_gzgjl001,lc_gzgjl002,lc_gzgjl003
      DISPLAY "check tw_cn gzgjl_t:",lc_gzgjl001
      IF cl_null(lc_gzgjl003) THEN
         CONTINUE FOREACH
      END IF
      CALL azzp110_trim(lc_gzgjl003) RETURNING lc_gzgjl003
      IF NOT cl_chk_tworcn(lc_gzgjl002 CLIPPED,lc_gzgjl003 CLIPPED,0) THEN
         DISPLAY li_cnt," Error Translate-lc_gzgjl001:",lc_gzgjl001,"   lc_gzgjl002:",lc_gzgjl002,
                        "   lc_gzgjl003:",lc_gzgjl003
         LET li_cnt = li_cnt + 1
                        
         LET lc_msg = "<tr hieght=22><td class=xl24>gzgjl_t</td>",                      #檢查檔案
                                    "<td class=xl24>",lc_gzgjl001,"</td>",              #key欄位1
                                    "<td class=xl24></td>",                             #key欄位2
                                    "<td class=xl24></td>",                             #key欄位3
                                    "<td class=xl24>",lc_gzgjl002,"</td>",              #檢查語系
                                    "<td class=xl24>",lc_gzgjl003,"</td>",              #原始字串
                      "</tr>"

         CALL g_gen_ch.writeLine(lc_msg)
      END IF
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_chk_gzahl_twcn()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_chk_gzahl_twcn()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_gzahl001 LIKE gzahl_t.gzahl001
   DEFINE lc_gzahl002 LIKE gzahl_t.gzahl002
   DEFINE lc_gzahl003 LIKE gzahl_t.gzahl003
   DEFINE lc_gzahl004 LIKE gzahl_t.gzahl004
   DEFINE li_row      LIKE type_t.num10
   DEFINE lc_msg      STRING

   
   LET ls_sql = "SELECT gzahl001,gzahl002,gzahl003,gzahl004 FROM gzahl_t ",
                " WHERE gzahl003 = 'zh_TW' OR gzahl003 = 'zh_CN' ",
                " ORDER BY gzahl001,gzahl002,gzahl003"
   LET li_cnt = 1 
                
   DECLARE azzp110_gzahl_twcn_cs CURSOR FROM ls_sql
   FOREACH azzp110_gzahl_twcn_cs INTO lc_gzahl001,lc_gzahl002,lc_gzahl003,lc_gzahl004
      DISPLAY "check tw_cn gzahl_t:",lc_gzahl001," ",lc_gzahl002
      IF cl_null(lc_gzahl004) THEN
         CONTINUE FOREACH
      END IF
      CALL azzp110_trim(lc_gzahl004) RETURNING lc_gzahl004
      IF NOT cl_chk_tworcn(lc_gzahl003 CLIPPED,lc_gzahl004 CLIPPED,0) THEN
         DISPLAY li_cnt," Error Translate-lc_gzahl001:",lc_gzahl001,"   lc_gzahl002:",lc_gzahl002,
                        "   lc_gzahl003:",lc_gzahl003,"  lc_gzahl004:",lc_gzahl004
         LET li_cnt = li_cnt + 1
                        
         LET lc_msg = "<tr hieght=22><td class=xl24>gzahl_t</td>",                      #檢查檔案
                                    "<td class=xl24>",lc_gzahl001,"</td>",              #key欄位1
                                    "<td class=xl24>",lc_gzahl002,"</td>",              #key欄位2
                                    "<td class=xl24></td>",                             #key欄位3
                                    "<td class=xl24>",lc_gzahl003,"</td>",              #檢查語系
                                    "<td class=xl24>",lc_gzahl004,"</td>",              #原始字串
                      "</tr>"

         CALL g_gen_ch.writeLine(lc_msg)
      END IF
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_chk_gzgp_twcn()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_chk_gzgp_twcn()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_gzgp001  LIKE gzgp_t.gzgp001
   DEFINE lc_gzgp002  LIKE gzgp_t.gzgp002
   DEFINE lc_gzgp003  LIKE gzgp_t.gzgp003
   DEFINE lc_gzgp004  LIKE gzgp_t.gzgp004
   DEFINE li_row      LIKE type_t.num10
   DEFINE lc_msg      STRING

   
   LET ls_sql = "SELECT gzgp001,gzgp002,gzgp003,gzgp004 FROM gzgp_t ",
                " WHERE gzgp003 = 'zh_TW' OR gzgp003 = 'zh_CN' ",
                " ORDER BY ggzgp001,gzgp002,gzgp003"
   LET li_cnt = 1 
                
   DECLARE azzp110_gzgp_twcn_cs CURSOR FROM ls_sql
   FOREACH azzp110_gzgp_twcn_cs INTO lc_gzgp001,lc_gzgp002,lc_gzgp003,lc_gzgp004
      DISPLAY "check tw_cn gzgp_t:",lc_gzgp001," ",lc_gzgp002
      IF cl_null(lc_gzgp004) THEN
         CONTINUE FOREACH
      END IF
      CALL azzp110_trim(lc_gzgp004) RETURNING lc_gzgp004
      IF NOT cl_chk_tworcn(lc_gzgp003 CLIPPED,lc_gzgp004 CLIPPED,0) THEN
         DISPLAY li_cnt," Error Translate-lc_gzgp001:",lc_gzgp001,"   lc_gzgp002:",lc_gzgp002,
                        "   lc_gzgp003:",lc_gzgp003,"  lc_gzgp004:",lc_gzgp004
         LET li_cnt = li_cnt + 1
                        
         LET lc_msg = "<tr hieght=22><td class=xl24>gzgp_t</td>",                      #檢查檔案
                                    "<td class=xl24>",lc_gzgp001,"</td>",              #key欄位1
                                    "<td class=xl24>",lc_gzgp002,"</td>",              #key欄位2
                                    "<td class=xl24></td>",                            #key欄位3
                                    "<td class=xl24>",lc_gzgp003,"</td>",              #檢查語系
                                    "<td class=xl24>",lc_gzgp004,"</td>",              #原始字串
                      "</tr>"

         CALL g_gen_ch.writeLine(lc_msg)
      END IF
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_chk_rpdel_twcn()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_chk_rpdel_twcn()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_rpdel001 LIKE rpdel_t.rpdel001
   DEFINE lc_rpdel002 LIKE rpdel_t.rpdel002
   DEFINE lc_rpdel003 LIKE rpdel_t.rpdel003
   DEFINE lc_rpdel004 LIKE rpdel_t.rpdel004
   DEFINE li_row      LIKE type_t.num10
   DEFINE lc_msg      STRING

   
   LET ls_sql = "SELECT rpdel001,rpdel002,rpdel003,rpdel004 FROM rpdel_t ",
                " WHERE rpdel003 = 'zh_TW' OR rpdel003 = 'zh_CN' ",
                " ORDER BY rpdel001,rpdel002,rpdel003"
   LET li_cnt = 1 
                
   DECLARE azzp110_rpdel_twcn_cs CURSOR FROM ls_sql
   FOREACH azzp110_rpdel_twcn_cs INTO lc_rpdel001,lc_rpdel002,lc_rpdel003,lc_rpdel004
      DISPLAY "check tw_cn rpdel_t:",lc_rpdel001," ",lc_rpdel002
      IF cl_null(lc_rpdel004) THEN
         CONTINUE FOREACH
      END IF
      CALL azzp110_trim(lc_rpdel004) RETURNING lc_rpdel004
      IF NOT cl_chk_tworcn(lc_rpdel003 CLIPPED,lc_rpdel004 CLIPPED,0) THEN
         DISPLAY li_cnt," Error Translate-lc_rpdel001:",lc_rpdel001,"   lc_rpdel002:",lc_rpdel002,
                        "   lc_rpdel003:",lc_rpdel003,"  lc_rpdel004:",lc_rpdel004
         LET li_cnt = li_cnt + 1
                        
         LET lc_msg = "<tr hieght=22><td class=xl24>rpdel_t</td>",                      #檢查檔案
                                    "<td class=xl24>",lc_rpdel001,"</td>",              #key欄位1
                                    "<td class=xl24>",lc_rpdel002,"</td>",              #key欄位2
                                    "<td class=xl24></td>",                             #key欄位3
                                    "<td class=xl24>",lc_rpdel003,"</td>",              #檢查語系
                                    "<td class=xl24>",lc_rpdel004,"</td>",              #原始字串
                      "</tr>"

         CALL g_gen_ch.writeLine(lc_msg)
      END IF
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_chk_rpzzl_twcn()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_chk_rpzzl_twcn()
   DEFINE ls_sql      STRING
   DEFINE li_cnt      LIKE type_t.num10
   DEFINE lc_rpzzl001 LIKE rpzzl_t.rpzzl001
   DEFINE lc_rpzzl002 LIKE rpzzl_t.rpzzl002
   DEFINE lc_rpzzl003 LIKE rpzzl_t.rpzzl003
   DEFINE li_row      LIKE type_t.num10
   DEFINE lc_msg      STRING

   
   LET ls_sql = "SELECT rpzzl001,rpzzl002,rpzzl003 FROM rpzzl_t ",
                " WHERE rpzzl002 = 'zh_TW' OR rpzzl002 = 'zh_CN' ",
                " ORDER BY rpzzl001,rpzzl002"
   LET li_cnt = 1 
                
   DECLARE azzp110_rpzzl_twcn_cs CURSOR FROM ls_sql
   FOREACH azzp110_rpzzl_twcn_cs INTO lc_rpzzl001,lc_rpzzl002,lc_rpzzl003
      DISPLAY "check tw_cn rpzzl_t:",lc_rpzzl001
      IF cl_null(lc_rpzzl003) THEN
         CONTINUE FOREACH
      END IF
      CALL azzp110_trim(lc_rpzzl003) RETURNING lc_rpzzl003
      IF NOT cl_chk_tworcn(lc_rpzzl002 CLIPPED,lc_rpzzl003 CLIPPED,0) THEN
         DISPLAY li_cnt," Error Translate-lc_rpzzl001:",lc_rpzzl001,"   lc_rpzzl002:",lc_rpzzl002,
                        "   lc_rpzzl003:",lc_rpzzl003
         LET li_cnt = li_cnt + 1
                        
         LET lc_msg = "<tr hieght=22><td class=xl24>rpzzl_t</td>",                      #檢查檔案
                                    "<td class=xl24>",lc_rpzzl001,"</td>",              #key欄位1
                                    "<td class=xl24></td>",                             #key欄位2
                                    "<td class=xl24></td>",                             #key欄位3
                                    "<td class=xl24>",lc_rpzzl002,"</td>",              #檢查語系
                                    "<td class=xl24>",lc_rpzzl003,"</td>",              #原始字串
                      "</tr>"

         CALL g_gen_ch.writeLine(lc_msg)
      END IF
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_exp_wscal()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_exp_wscal()
   DEFINE ls_sql STRING
   DEFINE ls_sql_gzoz STRING
   DEFINE la_gzzy DYNAMIC ARRAY OF RECORD
             gzzy001 LIKE gzzy_t.gzzy001, #語言別
             gzozcol LIKE type_t.chr10    #語言別欄位
                  END RECORD
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE lc_wscal001     LIKE wscal_t.wscal001
   DEFINE lc_wscal007     LIKE wscal_t.wscal007
   DEFINE lc_wscal009_tw  LIKE wscal_t.wscal009
   DEFINE lc_wscal009_old LIKE wscal_t.wscal009
   DEFINE lc_wscal009_new LIKE wscal_t.wscal009
   DEFINE lc_count        LIKE type_t.num5
   DEFINE lc_msg          STRING
   DEFINE lc_update       LIKE type_t.chr1
   DEFINE lc_item1        STRING
   DEFINE lc_item2        STRING


   #若是多語言暫存檔有資料的話，要先做暫存檔轉換的部分
   #否則後續用已更新後的字典檔再去對應各多語言檔的話，怕會有缺漏
   IF gs_trans_temp = "Y" THEN
      LET ls_sql = "SELECT wscal001,wscal007,wscal009 FROM wscal_t WHERE wscal008 = 'zh_TW' ORDER BY wscal001,wscal007"

      DECLARE azzp110_trans_temp_to_wscal_cs CURSOR FROM ls_sql
      FOREACH azzp110_trans_temp_to_wscal_cs INTO lc_wscal001,lc_wscal007,lc_wscal009_old
         DISPLAY "check gzos_t  lc_wscal001:",lc_wscal001,"  lc_wscal007:",lc_wscal007
         #檢查過單號是否已超過筆數
      #   CALL azzp110_chk_dzld_rows()
      #   IF NOT g_chk_status THEN
      #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
      #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
      #      CALL g_gen_ch.writeLine(lc_msg)
      #      RETURN
      #   END IF
         
         #從多語言暫存檔找出該語言別資料
         EXECUTE azzp110_get_gzos_cs USING lc_wscal009_old INTO lc_wscal009_new
         
         IF NOT SQLCA.SQLCODE AND NOT cl_null(lc_wscal009_new) THEN
            #填寫過單資訊，需檢核是否存在主檔中
            LET lc_count = 0
            LET lc_item1 = "NULL"
            LET lc_item2 = "NULL"
            SELECT COUNT(1) INTO lc_count FROM wsca_t
             WHERE wsca001 = lc_wscal001 AND wsca007 = lc_wscal007
            IF lc_count > 0 THEN
            #   IF NOT azzp110_insert_dzld('wscal_t','azzi901',lc_wscal001,' ') THEN
            #      LET g_chk_status = FALSE
            #      RETURN
            #   END IF
               LET lc_item1 = "awsi200"
               LET lc_item2 = lc_wscal001
            END IF
            
            UPDATE wscal_t SET wscal009 = lc_wscal009_new
             WHERE wscal001 = lc_wscal001 AND wscal007 = lc_wscal007
               AND wscal008 = "zh_TW"

            IF SQLCA.SQLCODE THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)wscal_t失敗...  wscal001:",lc_wscal001,"  wscal007:",lc_wscal007,"  wscal008:zh_TW","  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
               CALL g_gen_ch.writeLine(lc_msg)
               RETURN
            END IF

            #紀錄log
            LET lc_msg = "<tr hieght=22><td class=xl24>zh_TW</td>",                #更換語系
                                       "<td class=xl24>wscal_t</td>",              #更換的多語言table
                                       "<td class=xl24>",g_param.docno,"</td>",    #表單單號
                                       "<td class=xl24>",g_param.seq,"</td>",      #項次
                                       "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                       "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                       "<td class=xl24>",lc_wscal009_old,"</td>",  #資料修改前
                                       "<td class=xl24>",lc_wscal009_new,"</td>",  #資料修改後
                         "</tr>"
            CALL g_gen_ch.writeLine(lc_msg)
         END IF
      END FOREACH
   END IF
   
   ########開始進行字典檔匯出至多語言檔的動作##########
   LET ls_sql = "SELECT wscal001,wscal007,wscal009 FROM wscal_t WHERE wscal008 = 'zh_TW' ORDER BY wscal001,wscal007"

   #取出語言種類與項目
   LET la_gzzy = azzp110_get_gzzy() #除了zh_TW 之外

   DECLARE exp_wscal_cs CURSOR FROM ls_sql
   FOREACH exp_wscal_cs INTO lc_wscal001,lc_wscal007,lc_wscal009_tw
      DISPLAY "check gzoz_t  lc_wscal001:",lc_wscal001,"  lc_wscal007:",lc_wscal007
      #跑單身陣列
      FOR li_cnt = 1 TO la_gzzy.getLength()
         LET lc_update = "N"
         
         #字典檔找出該語言別資料
         LET ls_sql_gzoz = "SELECT ",la_gzzy[li_cnt].gzozcol CLIPPED,
                            " FROM gzoz_t WHERE gzoz000= '",lc_wscal009_tw CLIPPED,"' "
         PREPARE azzp110_exp_wscal_pre FROM ls_sql_gzoz
         EXECUTE azzp110_exp_wscal_pre INTO lc_wscal009_new
         #如果有資料且該筆資料不是null
         #然後判斷該語言別是否有資料 沒有資料就insert 有資料確認該筆資料是否是null，是就update
         #160303 改為以字典檔為主，若在字典檔有找到且非空白，就一律更新
         IF NOT SQLCA.SQLCODE AND NOT cl_null(lc_wscal009_new) THEN
            #檢查過單號是否已超過筆數
         #   CALL azzp110_chk_dzld_rows()
         #   IF NOT g_chk_status THEN
         #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
         #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
         #   CALL g_gen_ch.writeLine(lc_msg)
         #      RETURN
         #   END IF

            LET lc_wscal009_old = ""
            SELECT wscal009 INTO lc_wscal009_old FROM wscal_t
             WHERE wscal001 = lc_wscal001 AND wscal007 = lc_wscal007
               AND wscal008 = la_gzzy[li_cnt].gzzy001
            IF SQLCA.SQLCODE THEN
               #填寫過單資訊，需檢核是否存在主檔中
               LET lc_count = 0
               LET lc_item1 = "NULL"
               LET lc_item2 = "NULL"
               SELECT COUNT(1) INTO lc_count FROM wsca_t
                WHERE wsca001 = lc_wscal001 AND wsca007 = lc_wscal007
               IF lc_count > 0 THEN
               #   IF NOT azzp110_insert_dzld('wscal_t','azzi901',lc_wscal001,' ') THEN
               #      LET g_chk_status = FALSE
               #      RETURN
               #   END IF
                  LET lc_item1 = "awsi200"
                  LET lc_item2 = lc_wscal001
               END IF
            
               INSERT INTO wscal_t(wscal001,wscal007,wscal008,wscal009)
                 VALUES(lc_wscal001,lc_wscal007,la_gzzy[li_cnt].gzzy001,lc_wscal009_new)
               
               IF SQLCA.SQLCODE THEN
                  LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(insert)wscal_t失敗...  wscal001:",lc_wscal001,"  wscal007:",lc_wscal007,"  wscal008:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                  CALL g_gen_ch.writeLine(lc_msg)
                  RETURN
               END IF
               LET lc_update = "Y"
            ELSE
               IF la_gzzy[li_cnt].gzzy001<> 'zh_TW' AND lc_wscal009_new <> lc_wscal009_old THEN
                  #填寫過單資訊，需檢核是否存在主檔中
                  LET lc_count = 0
                  LET lc_item1 = "NULL"
                  LET lc_item2 = "NULL"
                  SELECT COUNT(1) INTO lc_count FROM wsca_t
                   WHERE wsca001 = lc_wscal001 AND wsca007 = lc_wscal007
                  IF lc_count > 0 THEN
                  #   IF NOT azzp110_insert_dzld('wscal_t','azzi901',lc_wscal001,' ') THEN
                  #      LET g_chk_status = FALSE
                  #      RETURN
                  #   END IF
                     LET lc_item1 = "awsi200"
                     LET lc_item2 = lc_wscal001
                  END IF
            
                  UPDATE wscal_t SET wscal009 = lc_wscal009_new
                   WHERE wscal001 = lc_wscal001 AND wscal007 = lc_wscal007
                     AND wscal008 = la_gzzy[li_cnt].gzzy001
                  
                  IF SQLCA.SQLCODE THEN
                     LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)wscal_t失敗...  wscal001:",lc_wscal001,"  wscal007:",lc_wscal007,"  wscal008:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                     CALL g_gen_ch.writeLine(lc_msg)
                     RETURN
                  END IF
                  LET lc_update = "Y"
               END IF
            END IF
            
            IF lc_update = "Y" THEN
               #紀錄log
               LET lc_msg = "<tr hieght=22><td class=xl24>",la_gzzy[li_cnt].gzzy001,"</td>",   #更換語系
                                          "<td class=xl24>wscal_t</td>",              #更換的多語言table
                                          "<td class=xl24>",g_param.docno,"</td>",    #表單單號
                                          "<td class=xl24>",g_param.seq,"</td>",      #項次
                                          "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                          "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                          "<td class=xl24>",lc_wscal009_old,"</td>",  #資料修改前
                                          "<td class=xl24>",lc_wscal009_new,"</td>",  #資料修改後
                            "</tr>"
        
               CALL g_gen_ch.writeLine(lc_msg)
            END IF
         END IF
         FREE azzp110_exp_wscal_pre
      END FOR

   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_exp_wsebl()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_exp_wsebl()
   DEFINE ls_sql STRING
   DEFINE ls_sql_gzoz STRING
   DEFINE la_gzzy DYNAMIC ARRAY OF RECORD
             gzzy001 LIKE gzzy_t.gzzy001, #語言別
             gzozcol LIKE type_t.chr10    #語言別欄位
                  END RECORD
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE lc_wsebl001     LIKE wsebl_t.wsebl001
   DEFINE lc_wsebl002     LIKE wsebl_t.wsebl002
   DEFINE lc_wsebl004_tw  LIKE wsebl_t.wsebl004
   DEFINE lc_wsebl004_old LIKE wsebl_t.wsebl004
   DEFINE lc_wsebl004_new LIKE wsebl_t.wsebl004
   DEFINE lc_count        LIKE type_t.num5
   DEFINE lc_msg          STRING
   DEFINE lc_update       LIKE type_t.chr1
   DEFINE lc_item1        STRING
   DEFINE lc_item2        STRING


   #若是多語言暫存檔有資料的話，要先做暫存檔轉換的部分
   #否則後續用已更新後的字典檔再去對應各多語言檔的話，怕會有缺漏
   IF gs_trans_temp = "Y" THEN
      LET ls_sql = "SELECT wsebl001,wsebl002,wsebl004 FROM wsebl_t WHERE wsebl003 = 'zh_TW' ORDER BY wsebl001,wsebl002"

      DECLARE azzp110_trans_temp_to_wsebl_cs CURSOR FROM ls_sql
      FOREACH azzp110_trans_temp_to_wsebl_cs INTO lc_wsebl001,lc_wsebl002,lc_wsebl004_old
         DISPLAY "check gzos_t  lc_wsebl001:",lc_wsebl001,"  lc_wsebl002:",lc_wsebl002
         #檢查過單號是否已超過筆數
      #   CALL azzp110_chk_dzld_rows()
      #   IF NOT g_chk_status THEN
      #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
      #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
      #      CALL g_gen_ch.writeLine(lc_msg)
      #      RETURN
      #   END IF
         
         #從多語言暫存檔找出該語言別資料
         EXECUTE azzp110_get_gzos_cs USING lc_wsebl004_old INTO lc_wsebl004_new
         
         IF NOT SQLCA.SQLCODE AND NOT cl_null(lc_wsebl004_new) THEN
            #填寫過單資訊，需檢核是否存在主檔中
            LET lc_count = 0
            LET lc_item1 = "NULL"
            LET lc_item2 = "NULL"
            SELECT COUNT(1) INTO lc_count FROM wseb_t
             WHERE wseb001 = lc_wsebl001 AND wseb002 = lc_wsebl002
            IF lc_count > 0 THEN
            #   IF NOT azzp110_insert_dzld('wsebl_t','azzi901',lc_wsebl001,' ') THEN
            #      LET g_chk_status = FALSE
            #      RETURN
            #   END IF
               LET lc_item1 = "awsi220"
               LET lc_item2 = lc_wsebl001
            END IF
            
            UPDATE wsebl_t SET wsebl004 = lc_wsebl004_new
             WHERE wsebl001 = lc_wsebl001 AND wsebl002 = lc_wsebl002
               AND wsebl003 = "zh_TW"

            IF SQLCA.SQLCODE THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)wsebl_t失敗...  wsebl001:",lc_wsebl001,"  wsebl002:",lc_wsebl002,"  wsebl003:zh_TW","  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
               CALL g_gen_ch.writeLine(lc_msg)
               RETURN
            END IF

            #紀錄log
            LET lc_msg = "<tr hieght=22><td class=xl24>zh_TW</td>",                #更換語系
                                       "<td class=xl24>wsebl_t</td>",              #更換的多語言table
                                       "<td class=xl24>",g_param.docno,"</td>",    #表單單號
                                       "<td class=xl24>",g_param.seq,"</td>",      #項次
                                       "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                       "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                       "<td class=xl24>",lc_wsebl004_old,"</td>",  #資料修改前
                                       "<td class=xl24>",lc_wsebl004_new,"</td>",  #資料修改後
                         "</tr>"
            CALL g_gen_ch.writeLine(lc_msg)
         END IF
      END FOREACH
   END IF
   
   ########開始進行字典檔匯出至多語言檔的動作##########
   LET ls_sql = "SELECT wsebl001,wsebl002,wsebl004 FROM wsebl_t WHERE wsebl003 = 'zh_TW' ORDER BY wsebl001,wsebl002"

   #取出語言種類與項目
   LET la_gzzy = azzp110_get_gzzy() #除了zh_TW 之外

   DECLARE exp_wsebl_cs CURSOR FROM ls_sql
   FOREACH exp_wsebl_cs INTO lc_wsebl001,lc_wsebl002,lc_wsebl004_tw
      DISPLAY "check gzoz_t  lc_wsebl001:",lc_wsebl001,"  lc_wsebl002:",lc_wsebl002
      #跑單身陣列
      FOR li_cnt = 1 TO la_gzzy.getLength()
         LET lc_update = "N"
         
         #字典檔找出該語言別資料
         LET ls_sql_gzoz = "SELECT ",la_gzzy[li_cnt].gzozcol CLIPPED,
                            " FROM gzoz_t WHERE gzoz000= '",lc_wsebl004_tw CLIPPED,"' "
         PREPARE azzp110_exp_wsebl_pre FROM ls_sql_gzoz
         EXECUTE azzp110_exp_wsebl_pre INTO lc_wsebl004_new
         #如果有資料且該筆資料不是null
         #然後判斷該語言別是否有資料 沒有資料就insert 有資料確認該筆資料是否是null，是就update
         #160303 改為以字典檔為主，若在字典檔有找到且非空白，就一律更新
         IF NOT SQLCA.SQLCODE AND NOT cl_null(lc_wsebl004_new) THEN
            #檢查過單號是否已超過筆數
         #   CALL azzp110_chk_dzld_rows()
         #   IF NOT g_chk_status THEN
         #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
         #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
         #   CALL g_gen_ch.writeLine(lc_msg)
         #      RETURN
         #   END IF

            LET lc_wsebl004_old = ""
            SELECT wsebl004 INTO lc_wsebl004_old FROM wsebl_t
             WHERE wsebl001 = lc_wsebl001 AND wsebl002 = lc_wsebl002
               AND wsebl003 = la_gzzy[li_cnt].gzzy001
            IF SQLCA.SQLCODE THEN
               #填寫過單資訊，需檢核是否存在主檔中
               LET lc_count = 0
               LET lc_item1 = "NULL"
               LET lc_item2 = "NULL"
               SELECT COUNT(1) INTO lc_count FROM wseb_t
                WHERE wseb001 = lc_wsebl001 AND wseb002 = lc_wsebl002
               IF lc_count > 0 THEN
               #   IF NOT azzp110_insert_dzld('wsebl_t','azzi901',lc_wsebl001,' ') THEN
               #      LET g_chk_status = FALSE
               #      RETURN
               #   END IF
                  LET lc_item1 = "awsi220"
                  LET lc_item2 = lc_wsebl001
               END IF
            
               INSERT INTO wsebl_t(wsebl001,wsebl002,wsebl003,wsebl004)
                 VALUES(lc_wsebl001,lc_wsebl002,la_gzzy[li_cnt].gzzy001,lc_wsebl004_new)
               
               IF SQLCA.SQLCODE THEN
                  LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(insert)wsebl_t失敗...  wsebl001:",lc_wsebl001,"  wsebl002:",lc_wsebl002,"  wsebl003:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                  CALL g_gen_ch.writeLine(lc_msg)
                  RETURN
               END IF
               LET lc_update = "Y"
            ELSE
               IF la_gzzy[li_cnt].gzzy001<> 'zh_TW' AND lc_wsebl004_new <> lc_wsebl004_old THEN
                  #填寫過單資訊，需檢核是否存在主檔中
                  LET lc_count = 0
                  LET lc_item1 = "NULL"
                  LET lc_item2 = "NULL"
                  SELECT COUNT(1) INTO lc_count FROM wseb_t
                   WHERE wseb001 = lc_wsebl001 AND wseb002 = lc_wsebl002
                  IF lc_count > 0 THEN
                  #   IF NOT azzp110_insert_dzld('wsebl_t','azzi901',lc_wsebl001,' ') THEN
                  #      LET g_chk_status = FALSE
                  #      RETURN
                  #   END IF
                     LET lc_item1 = "awsi220"
                     LET lc_item2 = lc_wsebl001
                  END IF
            
                  UPDATE wsebl_t SET wsebl004 = lc_wsebl004_new
                   WHERE wsebl001 = lc_wsebl001 AND wsebl002 = lc_wsebl002
                     AND wsebl003 = la_gzzy[li_cnt].gzzy001
                  
                  IF SQLCA.SQLCODE THEN
                     LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)wsebl_t失敗...  wsebl001:",lc_wsebl001,"  wsebl002:",lc_wsebl002,"  wsebl003:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                     CALL g_gen_ch.writeLine(lc_msg)
                     RETURN
                  END IF
                  LET lc_update = "Y"
               END IF
            END IF
            
            IF lc_update = "Y" THEN
               #紀錄log
               LET lc_msg = "<tr hieght=22><td class=xl24>",la_gzzy[li_cnt].gzzy001,"</td>",   #更換語系
                                          "<td class=xl24>wsebl_t</td>",              #更換的多語言table
                                          "<td class=xl24>",g_param.docno,"</td>",    #表單單號
                                          "<td class=xl24>",g_param.seq,"</td>",      #項次
                                          "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                          "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                          "<td class=xl24>",lc_wsebl004_old,"</td>",  #資料修改前
                                          "<td class=xl24>",lc_wsebl004_new,"</td>",  #資料修改後
                            "</tr>"
        
               CALL g_gen_ch.writeLine(lc_msg)
            END IF
         END IF
         FREE azzp110_exp_wsebl_pre
      END FOR

   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_exp_wsecl()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_exp_wsecl()
   DEFINE ls_sql STRING
   DEFINE ls_sql_gzoz STRING
   DEFINE la_gzzy DYNAMIC ARRAY OF RECORD
             gzzy001 LIKE gzzy_t.gzzy001, #語言別
             gzozcol LIKE type_t.chr10    #語言別欄位
                  END RECORD
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE lc_wsecl001     LIKE wsecl_t.wsecl001
   DEFINE lc_wsecl003_tw  LIKE wsecl_t.wsecl003
   DEFINE lc_wsecl003_old LIKE wsecl_t.wsecl003
   DEFINE lc_wsecl003_new LIKE wsecl_t.wsecl003
   DEFINE lc_count        LIKE type_t.num5
   DEFINE lc_msg          STRING
   DEFINE lc_update       LIKE type_t.chr1
   DEFINE lc_item1        STRING
   DEFINE lc_item2        STRING


   #若是多語言暫存檔有資料的話，要先做暫存檔轉換的部分
   #否則後續用已更新後的字典檔再去對應各多語言檔的話，怕會有缺漏
   IF gs_trans_temp = "Y" THEN
      LET ls_sql = "SELECT wsecl001,wsecl003 FROM wsecl_t WHERE wsecl002 = 'zh_TW' ORDER BY wsecl001"

      DECLARE azzp110_trans_temp_to_wsecl_cs CURSOR FROM ls_sql
      FOREACH azzp110_trans_temp_to_wsecl_cs INTO lc_wsecl001,lc_wsecl003_old
         DISPLAY "check gzos_t  lc_wsecl001:",lc_wsecl001
         #檢查過單號是否已超過筆數
      #   CALL azzp110_chk_dzld_rows()
      #   IF NOT g_chk_status THEN
      #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
      #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
      #      CALL g_gen_ch.writeLine(lc_msg)
      #      RETURN
      #   END IF
         
         #從多語言暫存檔找出該語言別資料
         EXECUTE azzp110_get_gzos_cs USING lc_wsecl003_old INTO lc_wsecl003_new
         
         IF NOT SQLCA.SQLCODE AND NOT cl_null(lc_wsecl003_new) THEN
            #填寫過單資訊，需檢核是否存在主檔中
            LET lc_count = 0
            LET lc_item1 = "NULL"
            LET lc_item2 = "NULL"
            SELECT COUNT(1) INTO lc_count FROM wsec_t
             WHERE wsec001 = lc_wsecl001
            IF lc_count > 0 THEN
            #   IF NOT azzp110_insert_dzld('wsecl_t','azzi901',lc_wsecl001,' ') THEN
            #      LET g_chk_status = FALSE
            #      RETURN
            #   END IF
               LET lc_item1 = "awsi001"
               LET lc_item2 = lc_wsecl001
            END IF
            
            UPDATE wsecl_t SET wsecl003 = lc_wsecl003_new
             WHERE wsecl001 = lc_wsecl001 AND wsecl002 = "zh_TW"

            IF SQLCA.SQLCODE THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)wsecl_t失敗...  wsecl001:",lc_wsecl001,"  wsecl002:zh_TW","  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
               CALL g_gen_ch.writeLine(lc_msg)
               RETURN
            END IF

            #紀錄log
            LET lc_msg = "<tr hieght=22><td class=xl24>zh_TW</td>",                #更換語系
                                       "<td class=xl24>wsecl_t</td>",              #更換的多語言table
                                       "<td class=xl24>",g_param.docno,"</td>",    #表單單號
                                       "<td class=xl24>",g_param.seq,"</td>",      #項次
                                       "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                       "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                       "<td class=xl24>",lc_wsecl003_old,"</td>",  #資料修改前
                                       "<td class=xl24>",lc_wsecl003_new,"</td>",  #資料修改後
                         "</tr>"
            CALL g_gen_ch.writeLine(lc_msg)
         END IF
      END FOREACH
   END IF
   
   ########開始進行字典檔匯出至多語言檔的動作##########
   LET ls_sql = "SELECT wsecl001,wsecl003 FROM wsecl_t WHERE wsecl002 = 'zh_TW' ORDER BY wsecl001"

   #取出語言種類與項目
   LET la_gzzy = azzp110_get_gzzy() #除了zh_TW 之外

   DECLARE exp_wsecl_cs CURSOR FROM ls_sql
   FOREACH exp_wsecl_cs INTO lc_wsecl001,lc_wsecl003_tw
      DISPLAY "check gzoz_t  lc_wsecl001:",lc_wsecl001
      #跑單身陣列
      FOR li_cnt = 1 TO la_gzzy.getLength()
         LET lc_update = "N"
         
         #字典檔找出該語言別資料
         LET ls_sql_gzoz = "SELECT ",la_gzzy[li_cnt].gzozcol CLIPPED,
                            " FROM gzoz_t WHERE gzoz000= '",lc_wsecl003_tw CLIPPED,"' "
         PREPARE azzp110_exp_wsecl_pre FROM ls_sql_gzoz
         EXECUTE azzp110_exp_wsecl_pre INTO lc_wsecl003_new
         #如果有資料且該筆資料不是null
         #然後判斷該語言別是否有資料 沒有資料就insert 有資料確認該筆資料是否是null，是就update
         #160303 改為以字典檔為主，若在字典檔有找到且非空白，就一律更新
         IF NOT SQLCA.SQLCODE AND NOT cl_null(lc_wsecl003_new) THEN
            #檢查過單號是否已超過筆數
         #   CALL azzp110_chk_dzld_rows()
         #   IF NOT g_chk_status THEN
         #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
         #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
         #   CALL g_gen_ch.writeLine(lc_msg)
         #      RETURN
         #   END IF

            LET lc_wsecl003_old = ""
            SELECT wsecl003 INTO lc_wsecl003_old FROM wsecl_t
             WHERE wsecl001 = lc_wsecl001
               AND wsecl002 = la_gzzy[li_cnt].gzzy001
            IF SQLCA.SQLCODE THEN
               #填寫過單資訊，需檢核是否存在主檔中
               LET lc_count = 0
               LET lc_item1 = "NULL"
               LET lc_item2 = "NULL"
               SELECT COUNT(1) INTO lc_count FROM wsec_t
                WHERE wsec001 = lc_wsecl001
               IF lc_count > 0 THEN
               #   IF NOT azzp110_insert_dzld('wsecl_t','azzi901',lc_wsecl001,' ') THEN
               #      LET g_chk_status = FALSE
               #      RETURN
               #   END IF
                  LET lc_item1 = "awsi001"
                  LET lc_item2 = lc_wsecl001
               END IF
            
               INSERT INTO wsecl_t(wsecl001,wsecl002,wsecl003)
                 VALUES(lc_wsecl001,la_gzzy[li_cnt].gzzy001,lc_wsecl003_new)
               
               IF SQLCA.SQLCODE THEN
                  LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(insert)wsecl_t失敗...  wsecl001:",lc_wsecl001,"  wsecl002:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                  CALL g_gen_ch.writeLine(lc_msg)
                  RETURN
               END IF
               LET lc_update = "Y"
            ELSE
               IF la_gzzy[li_cnt].gzzy001<> 'zh_TW' AND lc_wsecl003_new <> lc_wsecl003_old THEN
                  #填寫過單資訊，需檢核是否存在主檔中
                  LET lc_count = 0
                  LET lc_item1 = "NULL"
                  LET lc_item2 = "NULL"
                  SELECT COUNT(1) INTO lc_count FROM wsec_t
                   WHERE wsec001 = lc_wsecl001
                  IF lc_count > 0 THEN
                  #   IF NOT azzp110_insert_dzld('wsecl_t','azzi901',lc_wsecl001,' ') THEN
                  #      LET g_chk_status = FALSE
                  #      RETURN
                  #   END IF
                     LET lc_item1 = "awsi001"
                     LET lc_item2 = lc_wsecl001
                  END IF
            
                  UPDATE wsecl_t SET wsecl003 = lc_wsecl003_new
                   WHERE wsecl001 = lc_wsecl001 AND wsecl002 = la_gzzy[li_cnt].gzzy001
                  
                  IF SQLCA.SQLCODE THEN
                     LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)wsecl_t失敗...  wsecl001:",lc_wsecl001,"  wsecl002:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                     CALL g_gen_ch.writeLine(lc_msg)
                     RETURN
                  END IF
                  LET lc_update = "Y"
               END IF
            END IF
            
            IF lc_update = "Y" THEN
               #紀錄log
               LET lc_msg = "<tr hieght=22><td class=xl24>",la_gzzy[li_cnt].gzzy001,"</td>",   #更換語系
                                          "<td class=xl24>wsecl_t</td>",              #更換的多語言table
                                          "<td class=xl24>",g_param.docno,"</td>",    #表單單號
                                          "<td class=xl24>",g_param.seq,"</td>",      #項次
                                          "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                          "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                          "<td class=xl24>",lc_wsecl003_old,"</td>",  #資料修改前
                                          "<td class=xl24>",lc_wsecl003_new,"</td>",  #資料修改後
                            "</tr>"
        
               CALL g_gen_ch.writeLine(lc_msg)
            END IF
         END IF
         FREE azzp110_exp_wsecl_pre
      END FOR

   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_exp_gzgjl()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_exp_gzgjl()
   DEFINE ls_sql STRING
   DEFINE ls_sql_gzoz STRING
   DEFINE la_gzzy DYNAMIC ARRAY OF RECORD
             gzzy001 LIKE gzzy_t.gzzy001, #語言別
             gzozcol LIKE type_t.chr10    #語言別欄位
                  END RECORD
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE lc_gzgjl001     LIKE gzgjl_t.gzgjl001
   DEFINE lc_gzgjl003_tw  LIKE gzgjl_t.gzgjl003
   DEFINE lc_gzgjl003_old LIKE gzgjl_t.gzgjl003
   DEFINE lc_gzgjl003_new LIKE gzgjl_t.gzgjl003
   DEFINE lc_count        LIKE type_t.num5
   DEFINE lc_msg          STRING
   DEFINE lc_update       LIKE type_t.chr1
   DEFINE lc_item1        STRING
   DEFINE lc_item2        STRING


   #若是多語言暫存檔有資料的話，要先做暫存檔轉換的部分
   #否則後續用已更新後的字典檔再去對應各多語言檔的話，怕會有缺漏
   IF gs_trans_temp = "Y" THEN
      LET ls_sql = "SELECT gzgjl001,gzgjl003 FROM gzgjl_t WHERE gzgjl002 = 'zh_TW' ORDER BY gzgjl001"

      DECLARE azzp110_trans_temp_to_gzgjl_cs CURSOR FROM ls_sql
      FOREACH azzp110_trans_temp_to_gzgjl_cs INTO lc_gzgjl001,lc_gzgjl003_old
         DISPLAY "check gzos_t  lc_gzgjl001:",lc_gzgjl001
         #檢查過單號是否已超過筆數
      #   CALL azzp110_chk_dzld_rows()
      #   IF NOT g_chk_status THEN
      #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
      #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
      #      CALL g_gen_ch.writeLine(lc_msg)
      #      RETURN
      #   END IF
         
         #從多語言暫存檔找出該語言別資料
         EXECUTE azzp110_get_gzos_cs USING lc_gzgjl003_old INTO lc_gzgjl003_new
         
         IF NOT SQLCA.SQLCODE AND NOT cl_null(lc_gzgjl003_new) THEN
            #填寫過單資訊，需檢核是否存在主檔中
            LET lc_count = 0
            LET lc_item1 = "NULL"
            LET lc_item2 = "NULL"
            SELECT COUNT(1) INTO lc_count FROM gzgj_t
             WHERE gzgj001 = lc_gzgjl001
            IF lc_count > 0 THEN
            #   IF NOT azzp110_insert_dzld('gzgjl_t','azzi901',lc_gzgjl001,' ') THEN
            #      LET g_chk_status = FALSE
            #      RETURN
            #   END IF
               LET lc_item1 = "azzi330"
               LET lc_item2 = lc_gzgjl001
            END IF
            
            UPDATE gzgjl_t SET gzgjl003 = lc_gzgjl003_new
             WHERE gzgjl001 = lc_gzgjl001 AND gzgjl002 = "zh_TW"

            IF SQLCA.SQLCODE THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)gzgjl_t失敗...  gzgjl001:",lc_gzgjl001,"  gzgjl002:zh_TW","  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
               CALL g_gen_ch.writeLine(lc_msg)
               RETURN
            END IF

            #紀錄log
            LET lc_msg = "<tr hieght=22><td class=xl24>zh_TW</td>",                #更換語系
                                       "<td class=xl24>gzgjl_t</td>",              #更換的多語言table
                                       "<td class=xl24>",g_param.docno,"</td>",    #表單單號
                                       "<td class=xl24>",g_param.seq,"</td>",      #項次
                                       "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                       "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                       "<td class=xl24>",lc_gzgjl003_old,"</td>",  #資料修改前
                                       "<td class=xl24>",lc_gzgjl003_new,"</td>",  #資料修改後
                         "</tr>"
            CALL g_gen_ch.writeLine(lc_msg)
         END IF
      END FOREACH
   END IF
   
   ########開始進行字典檔匯出至多語言檔的動作##########
   LET ls_sql = "SELECT gzgjl001,gzgjl003 FROM gzgjl_t WHERE gzgjl002 = 'zh_TW' ORDER BY gzgjl001"

   #取出語言種類與項目
   LET la_gzzy = azzp110_get_gzzy() #除了zh_TW 之外

   DECLARE exp_gzgjl_cs CURSOR FROM ls_sql
   FOREACH exp_gzgjl_cs INTO lc_gzgjl001,lc_gzgjl003_tw
      DISPLAY "check gzoz_t  lc_gzgjl001:",lc_gzgjl001
      #跑單身陣列
      FOR li_cnt = 1 TO la_gzzy.getLength()
         LET lc_update = "N"
         
         #字典檔找出該語言別資料
         LET ls_sql_gzoz = "SELECT ",la_gzzy[li_cnt].gzozcol CLIPPED,
                            " FROM gzoz_t WHERE gzoz000= '",lc_gzgjl003_tw CLIPPED,"' "
         PREPARE azzp110_exp_gzgjl_pre FROM ls_sql_gzoz
         EXECUTE azzp110_exp_gzgjl_pre INTO lc_gzgjl003_new
         #如果有資料且該筆資料不是null
         #然後判斷該語言別是否有資料 沒有資料就insert 有資料確認該筆資料是否是null，是就update
         #160303 改為以字典檔為主，若在字典檔有找到且非空白，就一律更新
         IF NOT SQLCA.SQLCODE AND NOT cl_null(lc_gzgjl003_new) THEN
            #檢查過單號是否已超過筆數
         #   CALL azzp110_chk_dzld_rows()
         #   IF NOT g_chk_status THEN
         #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
         #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
         #   CALL g_gen_ch.writeLine(lc_msg)
         #      RETURN
         #   END IF

            LET lc_gzgjl003_old = ""
            SELECT gzgjl003 INTO lc_gzgjl003_old FROM gzgjl_t
             WHERE gzgjl001 = lc_gzgjl001
               AND gzgjl002 = la_gzzy[li_cnt].gzzy001
            IF SQLCA.SQLCODE THEN
               #填寫過單資訊，需檢核是否存在主檔中
               LET lc_count = 0
               LET lc_item1 = "NULL"
               LET lc_item2 = "NULL"
               SELECT COUNT(1) INTO lc_count FROM gzgj_t
                WHERE gzgj001 = lc_gzgjl001
               IF lc_count > 0 THEN
               #   IF NOT azzp110_insert_dzld('gzgjl_t','azzi901',lc_gzgjl001,' ') THEN
               #      LET g_chk_status = FALSE
               #      RETURN
               #   END IF
                  LET lc_item1 = "azzi330"
                  LET lc_item2 = lc_gzgjl001
               END IF
            
               INSERT INTO gzgjl_t(gzgjl001,gzgjl002,gzgjl003)
                 VALUES(lc_gzgjl001,la_gzzy[li_cnt].gzzy001,lc_gzgjl003_new)
               
               IF SQLCA.SQLCODE THEN
                  LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(insert)gzgjl_t失敗...  gzgjl001:",lc_gzgjl001,"  gzgjl002:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                  CALL g_gen_ch.writeLine(lc_msg)
                  RETURN
               END IF
               LET lc_update = "Y"
            ELSE
               IF la_gzzy[li_cnt].gzzy001<> 'zh_TW' AND lc_gzgjl003_new <> lc_gzgjl003_old THEN
                  #填寫過單資訊，需檢核是否存在主檔中
                  LET lc_count = 0
                  LET lc_item1 = "NULL"
                  LET lc_item2 = "NULL"
                  SELECT COUNT(1) INTO lc_count FROM gzgj_t
                   WHERE gzgj001 = lc_gzgjl001
                  IF lc_count > 0 THEN
                  #   IF NOT azzp110_insert_dzld('gzgjl_t','azzi901',lc_gzgjl001,' ') THEN
                  #      LET g_chk_status = FALSE
                  #      RETURN
                  #   END IF
                     LET lc_item1 = "azzi330"
                     LET lc_item2 = lc_gzgjl001
                  END IF
            
                  UPDATE gzgjl_t SET gzgjl003 = lc_gzgjl003_new
                   WHERE gzgjl001 = lc_gzgjl001 AND gzgjl002 = la_gzzy[li_cnt].gzzy001
                  
                  IF SQLCA.SQLCODE THEN
                     LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)gzgjl_t失敗...  gzgjl001:",lc_gzgjl001,"  gzgjl002:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                     CALL g_gen_ch.writeLine(lc_msg)
                     RETURN
                  END IF
                  LET lc_update = "Y"
               END IF
            END IF
            
            IF lc_update = "Y" THEN
               #紀錄log
               LET lc_msg = "<tr hieght=22><td class=xl24>",la_gzzy[li_cnt].gzzy001,"</td>",   #更換語系
                                          "<td class=xl24>gzgjl_t</td>",              #更換的多語言table
                                          "<td class=xl24>",g_param.docno,"</td>",    #表單單號
                                          "<td class=xl24>",g_param.seq,"</td>",      #項次
                                          "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                          "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                          "<td class=xl24>",lc_gzgjl003_old,"</td>",  #資料修改前
                                          "<td class=xl24>",lc_gzgjl003_new,"</td>",  #資料修改後
                            "</tr>"
        
               CALL g_gen_ch.writeLine(lc_msg)
            END IF
         END IF
         FREE azzp110_exp_gzgjl_pre
      END FOR

   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_exp_gzahl()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_exp_gzahl()
   DEFINE ls_sql STRING
   DEFINE ls_sql_gzoz STRING
   DEFINE la_gzzy DYNAMIC ARRAY OF RECORD
             gzzy001 LIKE gzzy_t.gzzy001, #語言別
             gzozcol LIKE type_t.chr10    #語言別欄位
                  END RECORD
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE lc_gzahl001     LIKE gzahl_t.gzahl001
   DEFINE lc_gzahl002     LIKE gzahl_t.gzahl002
   DEFINE lc_gzahl004_tw  LIKE gzahl_t.gzahl004
   DEFINE lc_gzahl004_old LIKE gzahl_t.gzahl004
   DEFINE lc_gzahl004_new LIKE gzahl_t.gzahl004
   DEFINE lc_count        LIKE type_t.num5
   DEFINE lc_msg          STRING
   DEFINE lc_update       LIKE type_t.chr1
   DEFINE lc_item1        STRING
   DEFINE lc_item2        STRING


   #若是多語言暫存檔有資料的話，要先做暫存檔轉換的部分
   #否則後續用已更新後的字典檔再去對應各多語言檔的話，怕會有缺漏
   IF gs_trans_temp = "Y" THEN
      LET ls_sql = "SELECT gzahl001,gzahl002,gzahl004 FROM gzahl_t WHERE gzahl003 = 'zh_TW' ORDER BY gzahl001,gzahl002"

      DECLARE azzp110_trans_temp_to_gzahl_cs CURSOR FROM ls_sql
      FOREACH azzp110_trans_temp_to_gzahl_cs INTO lc_gzahl001,lc_gzahl002,lc_gzahl004_old
         DISPLAY "check gzos_t  lc_gzahl001:",lc_gzahl001,"  lc_gzahl002:",lc_gzahl002
         #檢查過單號是否已超過筆數
      #   CALL azzp110_chk_dzld_rows()
      #   IF NOT g_chk_status THEN
      #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
      #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
      #      CALL g_gen_ch.writeLine(lc_msg)
      #      RETURN
      #   END IF
         
         #從多語言暫存檔找出該語言別資料
         EXECUTE azzp110_get_gzos_cs USING lc_gzahl004_old INTO lc_gzahl004_new
         
         IF NOT SQLCA.SQLCODE AND NOT cl_null(lc_gzahl004_new) THEN
            #填寫過單資訊，需檢核是否存在主檔中
            LET lc_count = 0
            LET lc_item1 = "NULL"
            LET lc_item2 = "NULL"
            SELECT COUNT(1) INTO lc_count FROM gzah_t
             WHERE gzah001 = lc_gzahl001 AND gzah005 = lc_gzahl002
            IF lc_count > 0 THEN
            #   IF NOT azzp110_insert_dzld('gzahl_t','azzi901',lc_gzahl001,' ') THEN
            #      LET g_chk_status = FALSE
            #      RETURN
            #   END IF
               LET lc_item1 = "azzi988"
               LET lc_item2 = lc_gzahl001
            END IF
            
            UPDATE gzahl_t SET gzahl004 = lc_gzahl004_new
             WHERE gzahl001 = lc_gzahl001 AND gzahl002 = lc_gzahl002
               AND gzahl003 = "zh_TW"

            IF SQLCA.SQLCODE THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)gzahl_t失敗...  gzahl001:",lc_gzahl001,"  gzahl002:",lc_gzahl002,"  gzahl003:zh_TW","  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
               CALL g_gen_ch.writeLine(lc_msg)
               RETURN
            END IF

            #紀錄log
            LET lc_msg = "<tr hieght=22><td class=xl24>zh_TW</td>",                #更換語系
                                       "<td class=xl24>gzahl_t</td>",              #更換的多語言table
                                       "<td class=xl24>",g_param.docno,"</td>",    #表單單號
                                       "<td class=xl24>",g_param.seq,"</td>",      #項次
                                       "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                       "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                       "<td class=xl24>",lc_gzahl004_old,"</td>",  #資料修改前
                                       "<td class=xl24>",lc_gzahl004_new,"</td>",  #資料修改後
                         "</tr>"
            CALL g_gen_ch.writeLine(lc_msg)
         END IF
      END FOREACH
   END IF
   
   ########開始進行字典檔匯出至多語言檔的動作##########
   LET ls_sql = "SELECT gzahl001,gzahl002,gzahl004 FROM gzahl_t WHERE gzahl003 = 'zh_TW' ORDER BY gzahl001,gzahl002"

   #取出語言種類與項目
   LET la_gzzy = azzp110_get_gzzy() #除了zh_TW 之外

   DECLARE exp_gzahl_cs CURSOR FROM ls_sql
   FOREACH exp_gzahl_cs INTO lc_gzahl001,lc_gzahl002,lc_gzahl004_tw
      DISPLAY "check gzoz_t  lc_gzahl001:",lc_gzahl001,"  lc_gzahl002:",lc_gzahl002
      #跑單身陣列
      FOR li_cnt = 1 TO la_gzzy.getLength()
         LET lc_update = "N"
         
         #字典檔找出該語言別資料
         LET ls_sql_gzoz = "SELECT ",la_gzzy[li_cnt].gzozcol CLIPPED,
                            " FROM gzoz_t WHERE gzoz000= '",lc_gzahl004_tw CLIPPED,"' "
         PREPARE azzp110_exp_gzahl_pre FROM ls_sql_gzoz
         EXECUTE azzp110_exp_gzahl_pre INTO lc_gzahl004_new
         #如果有資料且該筆資料不是null
         #然後判斷該語言別是否有資料 沒有資料就insert 有資料確認該筆資料是否是null，是就update
         #160303 改為以字典檔為主，若在字典檔有找到且非空白，就一律更新
         IF NOT SQLCA.SQLCODE AND NOT cl_null(lc_gzahl004_new) THEN
            #檢查過單號是否已超過筆數
         #   CALL azzp110_chk_dzld_rows()
         #   IF NOT g_chk_status THEN
         #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
         #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
         #   CALL g_gen_ch.writeLine(lc_msg)
         #      RETURN
         #   END IF

            LET lc_gzahl004_old = ""
            SELECT gzahl004 INTO lc_gzahl004_old FROM gzahl_t
             WHERE gzahl001 = lc_gzahl001 AND gzahl002 = lc_gzahl002
               AND gzahl003 = la_gzzy[li_cnt].gzzy001
            IF SQLCA.SQLCODE THEN
               #填寫過單資訊，需檢核是否存在主檔中
               LET lc_count = 0
               LET lc_item1 = "NULL"
               LET lc_item2 = "NULL"
               SELECT COUNT(1) INTO lc_count FROM gzah_t
                WHERE gzah001 = lc_gzahl001 AND gzah005 = lc_gzahl002
               IF lc_count > 0 THEN
               #   IF NOT azzp110_insert_dzld('gzahl_t','azzi901',lc_gzahl001,' ') THEN
               #      LET g_chk_status = FALSE
               #      RETURN
               #   END IF
                  LET lc_item1 = "azzi988"
                  LET lc_item2 = lc_gzahl001
               END IF
            
               INSERT INTO gzahl_t(gzahl001,gzahl002,gzahl003,gzahl004)
                 VALUES(lc_gzahl001,lc_gzahl002,la_gzzy[li_cnt].gzzy001,lc_gzahl004_new)
               
               IF SQLCA.SQLCODE THEN
                  LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(insert)gzahl_t失敗...  gzahl001:",lc_gzahl001,"  gzahl002:",lc_gzahl002,"  gzahl003:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                  CALL g_gen_ch.writeLine(lc_msg)
                  RETURN
               END IF
               LET lc_update = "Y"
            ELSE
               IF la_gzzy[li_cnt].gzzy001<> 'zh_TW' AND lc_gzahl004_new <> lc_gzahl004_old THEN
                  #填寫過單資訊，需檢核是否存在主檔中
                  LET lc_count = 0
                  LET lc_item1 = "NULL"
                  LET lc_item2 = "NULL"
                  SELECT COUNT(1) INTO lc_count FROM gzah_t
                   WHERE gzah001 = lc_gzahl001 AND gzah005 = lc_gzahl002
                  IF lc_count > 0 THEN
                  #   IF NOT azzp110_insert_dzld('gzahl_t','azzi901',lc_gzahl001,' ') THEN
                  #      LET g_chk_status = FALSE
                  #      RETURN
                  #   END IF
                     LET lc_item1 = "azzi988"
                     LET lc_item2 = lc_gzahl001
                  END IF
            
                  UPDATE gzahl_t SET gzahl004 = lc_gzahl004_new
                   WHERE gzahl001 = lc_gzahl001 AND gzahl002 = lc_gzahl002
                     AND gzahl003 = la_gzzy[li_cnt].gzzy001
                  
                  IF SQLCA.SQLCODE THEN
                     LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)gzahl_t失敗...  gzahl001:",lc_gzahl001,"  gzahl002:",lc_gzahl002,"  gzahl003:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                     CALL g_gen_ch.writeLine(lc_msg)
                     RETURN
                  END IF
                  LET lc_update = "Y"
               END IF
            END IF
            
            IF lc_update = "Y" THEN
               #紀錄log
               LET lc_msg = "<tr hieght=22><td class=xl24>",la_gzzy[li_cnt].gzzy001,"</td>",   #更換語系
                                          "<td class=xl24>gzahl_t</td>",              #更換的多語言table
                                          "<td class=xl24>",g_param.docno,"</td>",    #表單單號
                                          "<td class=xl24>",g_param.seq,"</td>",      #項次
                                          "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                          "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                          "<td class=xl24>",lc_gzahl004_old,"</td>",  #資料修改前
                                          "<td class=xl24>",lc_gzahl004_new,"</td>",  #資料修改後
                            "</tr>"
        
               CALL g_gen_ch.writeLine(lc_msg)
            END IF
         END IF
         FREE azzp110_exp_gzahl_pre
      END FOR

   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_exp_gzgp()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_exp_gzgp()
   DEFINE ls_sql STRING
   DEFINE ls_sql_gzoz STRING
   DEFINE la_gzzy DYNAMIC ARRAY OF RECORD
             gzzy001 LIKE gzzy_t.gzzy001, #語言別
             gzozcol LIKE type_t.chr10    #語言別欄位
                  END RECORD
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE lc_gzgp001     LIKE gzgp_t.gzgp001
   DEFINE lc_gzgp002     LIKE gzgp_t.gzgp002
   DEFINE lc_gzgp004_tw  LIKE gzgp_t.gzgp004
   DEFINE lc_gzgp004_old LIKE gzgp_t.gzgp004
   DEFINE lc_gzgp004_new LIKE gzgp_t.gzgp004
   DEFINE lc_std_or_cust LIKE type_t.chr1
   DEFINE li_count       LIKE type_t.num5
   DEFINE lc_gzgpcrtid   LIKE gzgp_t.gzgpcrtid
   DEFINE lc_gzgpcrtdp   LIKE gzgp_t.gzgpcrtdp
   DEFINE lc_gzgpcrtdt   DATETIME YEAR TO SECOND
   DEFINE lc_gzgpmodid   LIKE gzgp_t.gzgpmodid
   DEFINE lc_gzgpmoddt   DATETIME YEAR TO SECOND
   DEFINE lc_gzgpownid   LIKE gzgp_t.gzgpownid
   DEFINE lc_gzgpowndp   LIKE gzgp_t.gzgpowndp
   DEFINE lc_count       LIKE type_t.num5
   DEFINE lc_msg         STRING
   DEFINE lc_update      LIKE type_t.chr1
   DEFINE lc_item1       STRING
   DEFINE lc_item2       STRING


   LET lc_gzgpownid = g_user
   LET lc_gzgpowndp = g_dept
   LET lc_gzgpcrtid = g_user
   LET lc_gzgpcrtdp = g_dept
   LET lc_gzgpcrtdt = cl_get_current()
   LET lc_gzgpmodid = g_user
   LET lc_gzgpmoddt = cl_get_current()


   #取標準或客製
   LET lc_std_or_cust = FGL_GETENV("DGENV")
   
   #若是多語言暫存檔有資料的話，要先做暫存檔轉換的部分
   #否則後續用已更新後的字典檔再去對應各多語言檔的話，怕會有缺漏
   IF gs_trans_temp = "Y" THEN
      #gzgp 有標準及客製
      LET ls_sql = "SELECT gzgp001,gzgp002,gzgp004 FROM gzgp_t ",
                   " WHERE gzgp003 = 'zh_TW' AND gzgp005 ='",lc_std_or_cust CLIPPED ,"' ORDER BY gzgp001,gzgp002"

      DECLARE azzp110_trans_temp_to_gzgp_cs CURSOR FROM ls_sql
      FOREACH azzp110_trans_temp_to_gzgp_cs INTO lc_gzgp001,lc_gzgp002,lc_gzgp004_old
         DISPLAY "check gzos_t  lc_gzgp001:",lc_gzgp001,"  lc_gzgp002:",lc_gzgp002
         #檢查過單號是否已超過筆數
      #   CALL azzp110_chk_dzld_rows()
      #   IF NOT g_chk_status THEN
      #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
      #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
      #      CALL g_gen_ch.writeLine(lc_msg)
      #      RETURN
      #   END IF
         
         #從多語言暫存檔找出該語言別資料
         LET lc_gzgp004_new = ""
         EXECUTE azzp110_get_gzos_cs USING lc_gzgp004_old INTO lc_gzgp004_new

         #如果有資料且該筆資料不是null  
         #然後判斷該語言別是否有資料 沒有資料就insert 有資料確認該筆資料是否是null，是就update
         #160303 改為以字典檔為主，若在字典檔有找到且非空白，就一律更新
         IF NOT SQLCA.SQLCODE AND NOT cl_null(lc_gzgp004_new) THEN
            #填寫過單資訊，需檢核是否存在主檔中
            LET lc_count = 0
            LET lc_item1 = "NULL"
            LET lc_item2 = "NULL"
            SELECT COUNT(1) INTO lc_count FROM gzgp_t
                WHERE gzgp001 = lc_gzgp001 AND gzgp002 = lc_gzgp002
            
            IF lc_count > 0 THEN
            #   IF NOT azzp110_insert_dzld('gzzd_t','azzi902',lc_gzzd001,' ') THEN
            #      LET g_chk_status = FALSE
            #      RETURN
            #   END IF
               LET lc_item1 = "aooi900"
               LET lc_item2 = lc_gzgp001
            END IF
         
            UPDATE gzgp_t SET gzgp004 = lc_gzgp004_new,
                              gzgpmodid = lc_gzgpmodid,gzgpmoddt = lc_gzgpmoddt
             WHERE gzgp001 = lc_gzgp001
               AND gzgp002 = lc_gzgp002
               AND gzgp003 = "zh_TW"
               AND gzgp005 = lc_std_or_cust                      

            IF SQLCA.SQLCODE THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)gzgp_t失敗...  gzgp001:",lc_gzgp001,"  gzgp002:",lc_gzgp002,
                                                       "  gzgp003:zh_TW  gzgp005:",lc_std_or_cust,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
               CALL g_gen_ch.writeLine(lc_msg)
               RETURN
            END IF

            #紀錄log
            LET lc_msg = "<tr hieght=22><td class=xl24>zh_TW</td>",                #更換語系
                                       "<td class=xl24>gzgp_t</td>",               #更換的多語言table
                                       "<td class=xl24>",g_param.docno,"</td>",    #表單單號    
                                       "<td class=xl24>",g_param.seq,"</td>",      #項次
                                       "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                       "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                       "<td class=xl24>",lc_gzgp004_old,"</td>",   #資料修改前
                                       "<td class=xl24>",lc_gzgp004_new,"</td>",   #資料修改後
                         "</tr>"
            
            CALL g_gen_ch.writeLine(lc_msg)
         END IF 
      END FOREACH
   END IF

   ########開始進行字典檔匯出至多語言檔的動作##########
   #gzgp 有標準及客製
   LET ls_sql = "SELECT gzgp001,gzgp002,gzgp004 FROM gzgp_t ",
                " WHERE gzgp003 = 'zh_TW' AND gzgp005 ='",lc_std_or_cust CLIPPED ,"' ORDER BY gzgp001,gzgp002"

   #取出語言種類與項目
   LET la_gzzy = azzp110_get_gzzy()

   DECLARE exp_gzgp_cs CURSOR FROM ls_sql
   FOREACH exp_gzgp_cs INTO lc_gzgp001,lc_gzgp002,lc_gzgp004_tw
      DISPLAY "check gzoz_t  lc_gzgp001:",lc_gzgp001,"  lc_gzgp002:",lc_gzgp002
      #跑單身陣列
      FOR li_cnt = 1 TO la_gzzy.getLength()
         LET lc_update = "N"
         
         #字典檔找出該語言別資料
         LET ls_sql_gzoz = "SELECT ",la_gzzy[li_cnt].gzozcol CLIPPED,
                            " FROM gzoz_t WHERE gzoz000= '",lc_gzgp004_tw CLIPPED,"' "
         PREPARE azzp110_exp_gzgp_pre FROM ls_sql_gzoz
         EXECUTE azzp110_exp_gzgp_pre INTO lc_gzgp004_new
         
         #如果有資料且該筆資料不是null  
         #然後判斷該語言別是否有資料 沒有資料就insert 有資料確認該筆資料是否是null，是就update
         #160303 改為以字典檔為主，若在字典檔有找到且非空白，就一律更新
         #160419 以字典檔為主，若是字典檔與外顯表不一致時才更新
         IF NOT SQLCA.SQLCODE AND NOT cl_null(lc_gzgp004_new) THEN
         #   #檢查過單號是否已超過筆數
         #   CALL azzp110_chk_dzld_rows()
         #   IF NOT g_chk_status THEN
         #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
         #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
         #   CALL g_gen_ch.writeLine(lc_msg)
         #      RETURN
         #   END IF

            LET lc_gzgp004_old = ""
            SELECT gzgp004 INTO lc_gzgp004_old FROM gzgp_t
             WHERE gzgp001 = lc_gzgp001 AND gzgp002 = lc_gzgp002
               AND gzgp003 = la_gzzy[li_cnt].gzzy001
           
            IF SQLCA.SQLCODE THEN
               #填寫過單資訊，需檢核是否存在主檔中
               LET lc_count = 0
               LET lc_item1 = "NULL"
               LET lc_item2 = "NULL"
               SELECT COUNT(1) INTO lc_count FROM gzgp_t
                WHERE gzgp001 = lc_gzgp001 AND gzgp002 = lc_gzgp002
               IF lc_count > 0 THEN
               #   IF NOT azzp110_insert_dzld('gzgp_t','azzi902',lc_gzgp001,' ') THEN
               #      LET g_chk_status = FALSE
               #      RETURN
               #   END IF
                  LET lc_item1 = "aooi900"
                  LET lc_item2 = lc_gzgp001
               END IF
            
               INSERT INTO gzzd_t(gzgpstus,gzgp001,gzgp002,gzgp003,gzgp004,gzgp005,
                                  gzgpcrtid,gzgpcrtdp,gzgpcrtdt,gzgpownid,gzgpowndp)
                  VALUES('Y',lc_gzgp001,lc_gzgp002,la_gzzy[li_cnt].gzzy001,lc_gzgp004_new,lc_std_or_cust,
                         lc_gzgpcrtid,lc_gzgpcrtdp,lc_gzgpcrtdt,lc_gzgpownid,lc_gzgpowndp)
               
               IF SQLCA.SQLCODE THEN
                  LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(insert)gzgp_t失敗...  gzgp001:",lc_gzgp001,"  gzgp002:",lc_gzgp002,
                                                          "  gzgp003:",la_gzzy[li_cnt].gzzy001,"  gzgp004:",lc_std_or_cust,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                  CALL g_gen_ch.writeLine(lc_msg)
                  RETURN
               END IF
               LET lc_update = "Y"
            ELSE
              SELECT gzgp004 INTO lc_gzgp004_old FROM gzgp_t
               WHERE gzgp001 = lc_gzgp001
                 AND gzgp002 = lc_gzgp002
                 AND gzgp003 = la_gzzy[li_cnt].gzzy001
                 AND gzgp005 = lc_std_or_cust

               IF NOT SQLCA.SQLCODE THEN
                  #IF la_gzzy[li_cnt].gzzy001 <> "zh_TW" AND lc_gzgp004_new <> lc_gzgp004_old THEN
                  #16/08/15 加入 欄位 null 判斷 否則 舊值是null 的話，比對會是(null)
                  #160818-00012 start
                  IF la_gzzy[li_cnt].gzzy001 <> "zh_TW" AND (lc_gzgp004_new <> lc_gzgp004_old
                          OR lc_gzgp004_old IS NULL ) THEN 
                  #160818-00012 end        
                     #填寫過單資訊，需檢核是否存在主檔中
                     LET lc_count = 0
                     LET lc_item1 = "NULL"
                     LET lc_item2 = "NULL"
                     SELECT COUNT(1) INTO lc_count FROM gzgp_t
                      WHERE gzgp001 = lc_gzgp001 AND gzgp002 = lc_gzgp002
                     IF lc_count > 0 THEN
                     #   IF NOT azzp110_insert_dzld('gzgp_t','azzi902',lc_gzgp001,' ') THEN
                     #      LET g_chk_status = FALSE
                     #      RETURN
                     #   END IF
                        LET lc_item1 = "aooi900"
                        LET lc_item2 = lc_gzgp001
                     END IF
                     
                     UPDATE gzgp_t SET gzgp004 = lc_gzgp004_new,
                                       gzgpmodid = lc_gzgpmodid,gzgpmoddt = lc_gzgpmoddt
                         WHERE gzgp001 = lc_gzgp001
                           AND gzgp002 = lc_gzgp002
                           AND gzgp003 = la_gzzy[li_cnt].gzzy001
                           AND gzgp005 = lc_std_or_cust
                      
                     IF SQLCA.SQLCODE THEN
                        LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)gzgp_t失敗...  gzgp001:",lc_gzgp001,"  gzgp002:",lc_gzgp002,
                                                                "  gzgp003:",la_gzzy[li_cnt].gzzy001,"  gzgp005:",lc_std_or_cust,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                        CALL g_gen_ch.writeLine(lc_msg)
                        RETURN
                     END IF
                     LET lc_update = "Y"
                  END IF                      
               END IF 
            END IF
            
            IF lc_update = "Y" THEN
               #紀錄log
               LET lc_msg = "<tr hieght=22><td class=xl24>",la_gzzy[li_cnt].gzzy001,"</td>",   #更換語系
                                          "<td class=xl24>gzgp_t</td>",               #更換的多語言table
                                          "<td class=xl24>",g_param.docno,"</td>",    #表單單號    
                                          "<td class=xl24>",g_param.seq,"</td>",      #項次
                                          "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                          "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                          "<td class=xl24>",lc_gzgp004_old,"</td>",   #資料修改前
                                          "<td class=xl24>",lc_gzgp004_new,"</td>",   #資料修改後
                           "</tr>"
            
               CALL g_gen_ch.writeLine(lc_msg)
            END IF
         END IF 
         FREE azzp110_exp_gzgp_pre
      END FOR
   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_exp_rpdel()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_exp_rpdel()
   DEFINE ls_sql STRING
   DEFINE ls_sql_gzoz STRING
   DEFINE la_gzzy DYNAMIC ARRAY OF RECORD
             gzzy001 LIKE gzzy_t.gzzy001, #語言別
             gzozcol LIKE type_t.chr10    #語言別欄位
                  END RECORD
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE lc_rpdel001     LIKE rpdel_t.rpdel001
   DEFINE lc_rpdel002     LIKE rpdel_t.rpdel002
   DEFINE lc_rpdel004_tw  LIKE rpdel_t.rpdel004
   DEFINE lc_rpdel004_old LIKE rpdel_t.rpdel004
   DEFINE lc_rpdel004_new LIKE rpdel_t.rpdel004
   DEFINE lc_count        LIKE type_t.num5
   DEFINE lc_msg          STRING
   DEFINE lc_update       LIKE type_t.chr1
   DEFINE lc_item1        STRING
   DEFINE lc_item2        STRING


   #若是多語言暫存檔有資料的話，要先做暫存檔轉換的部分
   #否則後續用已更新後的字典檔再去對應各多語言檔的話，怕會有缺漏
   IF gs_trans_temp = "Y" THEN
      LET ls_sql = "SELECT rpdel001,rpdel002,rpdel004 FROM rpdel_t WHERE rpdel003 = 'zh_TW' ORDER BY rpdel001,rpdel002"

      DECLARE azzp110_trans_temp_to_rpdel_cs CURSOR FROM ls_sql
      FOREACH azzp110_trans_temp_to_rpdel_cs INTO lc_rpdel001,lc_rpdel002,lc_rpdel004_old
         DISPLAY "check gzos_t  lc_rpdel001:",lc_rpdel001,"  lc_rpdel002:",lc_rpdel002
         #檢查過單號是否已超過筆數
      #   CALL azzp110_chk_dzld_rows()
      #   IF NOT g_chk_status THEN
      #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
      #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
      #      CALL g_gen_ch.writeLine(lc_msg)
      #      RETURN
      #   END IF
         
         #從多語言暫存檔找出該語言別資料
         EXECUTE azzp110_get_gzos_cs USING lc_rpdel004_old INTO lc_rpdel004_new
         
         IF NOT SQLCA.SQLCODE AND NOT cl_null(lc_rpdel004_new) THEN
            #填寫過單資訊，需檢核是否存在主檔中
            LET lc_count = 0
            LET lc_item1 = "NULL"
            LET lc_item2 = "NULL"
            SELECT COUNT(1) INTO lc_count FROM rpde_t
             WHERE rpde001 = lc_rpdel001 AND rpde002 = lc_rpdel002
            IF lc_count > 0 THEN
            #   IF NOT azzp110_insert_dzld('rpdel_t','azzi901',lc_rpdel001,' ') THEN
            #      LET g_chk_status = FALSE
            #      RETURN
            #   END IF
               LET lc_item1 = "arpi900"
               LET lc_item2 = lc_rpdel001
            END IF
            
            UPDATE rpdel_t SET rpdel004 = lc_rpdel004_new
             WHERE rpdel001 = lc_rpdel001 AND rpdel002 = lc_rpdel002
               AND rpdel003 = "zh_TW"

            IF SQLCA.SQLCODE THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)rpdel_t失敗...  rpdel001:",lc_rpdel001,"  rpdel002:",lc_rpdel002,"  rpdel003:zh_TW","  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
               CALL g_gen_ch.writeLine(lc_msg)
               RETURN
            END IF

            #紀錄log
            LET lc_msg = "<tr hieght=22><td class=xl24>zh_TW</td>",                #更換語系
                                       "<td class=xl24>rpdel_t</td>",              #更換的多語言table
                                       "<td class=xl24>",g_param.docno,"</td>",    #表單單號
                                       "<td class=xl24>",g_param.seq,"</td>",      #項次
                                       "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                       "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                       "<td class=xl24>",lc_rpdel004_old,"</td>",  #資料修改前
                                       "<td class=xl24>",lc_rpdel004_new,"</td>",  #資料修改後
                         "</tr>"
            CALL g_gen_ch.writeLine(lc_msg)
         END IF
      END FOREACH
   END IF
   
   ########開始進行字典檔匯出至多語言檔的動作##########
   LET ls_sql = "SELECT rpdel001,rpdel002,rpdel004 FROM rpdel_t WHERE rpdel003 = 'zh_TW' ORDER BY rpdel001,rpdel002"

   #取出語言種類與項目
   LET la_gzzy = azzp110_get_gzzy() #除了zh_TW 之外

   DECLARE exp_rpdel_cs CURSOR FROM ls_sql
   FOREACH exp_rpdel_cs INTO lc_rpdel001,lc_rpdel002,lc_rpdel004_tw
      DISPLAY "check gzoz_t  lc_rpdel001:",lc_rpdel001,"  lc_rpdel002:",lc_rpdel002
      #跑單身陣列
      FOR li_cnt = 1 TO la_gzzy.getLength()
         LET lc_update = "N"
         
         #字典檔找出該語言別資料
         LET ls_sql_gzoz = "SELECT ",la_gzzy[li_cnt].gzozcol CLIPPED,
                            " FROM gzoz_t WHERE gzoz000= '",lc_rpdel004_tw CLIPPED,"' "
         PREPARE azzp110_exp_rpdel_pre FROM ls_sql_gzoz
         EXECUTE azzp110_exp_rpdel_pre INTO lc_rpdel004_new
         #如果有資料且該筆資料不是null
         #然後判斷該語言別是否有資料 沒有資料就insert 有資料確認該筆資料是否是null，是就update
         #160303 改為以字典檔為主，若在字典檔有找到且非空白，就一律更新
         IF NOT SQLCA.SQLCODE AND NOT cl_null(lc_rpdel004_new) THEN
            #檢查過單號是否已超過筆數
         #   CALL azzp110_chk_dzld_rows()
         #   IF NOT g_chk_status THEN
         #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
         #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
         #   CALL g_gen_ch.writeLine(lc_msg)
         #      RETURN
         #   END IF

            LET lc_rpdel004_old = ""
            SELECT rpdel004 INTO lc_rpdel004_old FROM rpdel_t
             WHERE rpdel001 = lc_rpdel001 AND rpdel002 = lc_rpdel002
               AND rpdel003 = la_gzzy[li_cnt].gzzy001
            IF SQLCA.SQLCODE THEN
               #填寫過單資訊，需檢核是否存在主檔中
               LET lc_count = 0
               LET lc_item1 = "NULL"
               LET lc_item2 = "NULL"
               SELECT COUNT(1) INTO lc_count FROM rpde_t
                WHERE rpde001 = lc_rpdel001 AND rpde002 = lc_rpdel002
               IF lc_count > 0 THEN
               #   IF NOT azzp110_insert_dzld('rpdel_t','azzi901',lc_rpdel001,' ') THEN
               #      LET g_chk_status = FALSE
               #      RETURN
               #   END IF
                  LET lc_item1 = "arpi900"
                  LET lc_item2 = lc_rpdel001
               END IF
            
               INSERT INTO rpdel_t(rpdel001,rpdel002,rpdel003,rpdel004)
                 VALUES(lc_rpdel001,lc_rpdel002,la_gzzy[li_cnt].gzzy001,lc_rpdel004_new)
               
               IF SQLCA.SQLCODE THEN
                  LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(insert)rpdel_t失敗...  rpdel001:",lc_rpdel001,"  rpdel002:",lc_rpdel002,"  rpdel003:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                  CALL g_gen_ch.writeLine(lc_msg)
                  RETURN
               END IF
               LET lc_update = "Y"
            ELSE
               IF la_gzzy[li_cnt].gzzy001<> 'zh_TW' AND lc_rpdel004_new <> lc_rpdel004_old THEN
                  #填寫過單資訊，需檢核是否存在主檔中
                  LET lc_count = 0
                  LET lc_item1 = "NULL"
                  LET lc_item2 = "NULL"
                  SELECT COUNT(1) INTO lc_count FROM rpde_t
                   WHERE rpde001 = lc_rpdel001 AND rpde002 = lc_rpdel002
                  IF lc_count > 0 THEN
                  #   IF NOT azzp110_insert_dzld('rpdel_t','azzi901',lc_rpdel001,' ') THEN
                  #      LET g_chk_status = FALSE
                  #      RETURN
                  #   END IF
                     LET lc_item1 = "arpi900"
                     LET lc_item2 = lc_rpdel001
                  END IF
            
                  UPDATE rpdel_t SET rpdel004 = lc_rpdel004_new
                   WHERE rpdel001 = lc_rpdel001 AND rpdel002 = lc_rpdel002
                     AND rpdel003 = la_gzzy[li_cnt].gzzy001
                  
                  IF SQLCA.SQLCODE THEN
                     LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)rpdel_t失敗...  rpdel001:",lc_rpdel001,"  rpdel002:",lc_rpdel002,"  rpdel003:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                     CALL g_gen_ch.writeLine(lc_msg)
                     RETURN
                  END IF
                  LET lc_update = "Y"
               END IF
            END IF
            
            IF lc_update = "Y" THEN
               #紀錄log
               LET lc_msg = "<tr hieght=22><td class=xl24>",la_gzzy[li_cnt].gzzy001,"</td>",   #更換語系
                                          "<td class=xl24>rpdel_t</td>",              #更換的多語言table
                                          "<td class=xl24>",g_param.docno,"</td>",    #表單單號
                                          "<td class=xl24>",g_param.seq,"</td>",      #項次
                                          "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                          "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                          "<td class=xl24>",lc_rpdel004_old,"</td>",  #資料修改前
                                          "<td class=xl24>",lc_rpdel004_new,"</td>",  #資料修改後
                            "</tr>"
        
               CALL g_gen_ch.writeLine(lc_msg)
            END IF
         END IF
         FREE azzp110_exp_rpdel_pre
      END FOR

   END FOREACH
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp110_exp_rpzzl()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp110_exp_rpzzl()
   DEFINE ls_sql STRING
   DEFINE ls_sql_gzoz STRING
   DEFINE la_gzzy DYNAMIC ARRAY OF RECORD
             gzzy001 LIKE gzzy_t.gzzy001, #語言別
             gzozcol LIKE type_t.chr10    #語言別欄位
                  END RECORD
   DEFINE li_cnt  LIKE type_t.num5
   DEFINE lc_rpzzl001     LIKE rpzzl_t.rpzzl001
   DEFINE lc_rpzzl003_tw  LIKE rpzzl_t.rpzzl003
   DEFINE lc_rpzzl003_old LIKE rpzzl_t.rpzzl003
   DEFINE lc_rpzzl003_new LIKE rpzzl_t.rpzzl003
   DEFINE lc_count        LIKE type_t.num5
   DEFINE lc_msg          STRING
   DEFINE lc_update       LIKE type_t.chr1
   DEFINE lc_item1        STRING
   DEFINE lc_item2        STRING


   #若是多語言暫存檔有資料的話，要先做暫存檔轉換的部分
   #否則後續用已更新後的字典檔再去對應各多語言檔的話，怕會有缺漏
   IF gs_trans_temp = "Y" THEN
      LET ls_sql = "SELECT rpzzl001,rpzzl003 FROM rpzzl_t WHERE rpzzl002 = 'zh_TW' ORDER BY rpzzl001"

      DECLARE azzp110_trans_temp_to_rpzzl_cs CURSOR FROM ls_sql
      FOREACH azzp110_trans_temp_to_rpzzl_cs INTO lc_rpzzl001,lc_rpzzl003_old
         DISPLAY "check gzos_t  lc_rpzzl001:",lc_rpzzl001
         #檢查過單號是否已超過筆數
      #   CALL azzp110_chk_dzld_rows()
      #   IF NOT g_chk_status THEN
      #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
      #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
      #      CALL g_gen_ch.writeLine(lc_msg)
      #      RETURN
      #   END IF
         
         #從多語言暫存檔找出該語言別資料
         EXECUTE azzp110_get_gzos_cs USING lc_rpzzl003_old INTO lc_rpzzl003_new
         
         IF NOT SQLCA.SQLCODE AND NOT cl_null(lc_rpzzl003_new) THEN
            #填寫過單資訊，需檢核是否存在主檔中
            LET lc_count = 0
            LET lc_item1 = "NULL"
            LET lc_item2 = "NULL"
            SELECT COUNT(1) INTO lc_count FROM rpzz_t
             WHERE rpzz001 = lc_rpzzl001
            IF lc_count > 0 THEN
            #   IF NOT azzp110_insert_dzld('rpzzl_t','azzi901',lc_rpzzl001,' ') THEN
            #      LET g_chk_status = FALSE
            #      RETURN
            #   END IF
               LET lc_item1 = "arpi900"
               LET lc_item2 = lc_rpzzl001
            END IF
            
            UPDATE rpzzl_t SET rpzzl003 = lc_rpzzl003_new
             WHERE rpzzl001 = lc_rpzzl001 AND rpzzl002 = "zh_TW"

            IF SQLCA.SQLCODE THEN
               LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)rpzzl_t失敗...  rpzzl001:",lc_rpzzl001,"  rpzzl002:zh_TW","  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
               CALL g_gen_ch.writeLine(lc_msg)
               RETURN
            END IF

            #紀錄log
            LET lc_msg = "<tr hieght=22><td class=xl24>zh_TW</td>",                #更換語系
                                       "<td class=xl24>rpzzl_t</td>",              #更換的多語言table
                                       "<td class=xl24>",g_param.docno,"</td>",    #表單單號
                                       "<td class=xl24>",g_param.seq,"</td>",      #項次
                                       "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                       "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                       "<td class=xl24>",lc_rpzzl003_old,"</td>",  #資料修改前
                                       "<td class=xl24>",lc_rpzzl003_new,"</td>",  #資料修改後
                         "</tr>"
            CALL g_gen_ch.writeLine(lc_msg)
         END IF
      END FOREACH
   END IF
   
   ########開始進行字典檔匯出至多語言檔的動作##########
   LET ls_sql = "SELECT rpzzl001,rpzzl003 FROM rpzzl_t WHERE rpzzl002 = 'zh_TW' ORDER BY rpzzl001"

   #取出語言種類與項目
   LET la_gzzy = azzp110_get_gzzy() #除了zh_TW 之外

   DECLARE exp_rpzzl_cs CURSOR FROM ls_sql
   FOREACH exp_rpzzl_cs INTO lc_rpzzl001,lc_rpzzl003_tw
      DISPLAY "check gzoz_t  lc_rpzzl001:",lc_rpzzl001
      #跑單身陣列
      FOR li_cnt = 1 TO la_gzzy.getLength()
         LET lc_update = "N"
         
         #字典檔找出該語言別資料
         LET ls_sql_gzoz = "SELECT ",la_gzzy[li_cnt].gzozcol CLIPPED,
                            " FROM gzoz_t WHERE gzoz000= '",lc_rpzzl003_tw CLIPPED,"' "
         PREPARE azzp110_exp_rpzzl_pre FROM ls_sql_gzoz
         EXECUTE azzp110_exp_rpzzl_pre INTO lc_rpzzl003_new
         #如果有資料且該筆資料不是null
         #然後判斷該語言別是否有資料 沒有資料就insert 有資料確認該筆資料是否是null，是就update
         #160303 改為以字典檔為主，若在字典檔有找到且非空白，就一律更新
         IF NOT SQLCA.SQLCODE AND NOT cl_null(lc_rpzzl003_new) THEN
            #檢查過單號是否已超過筆數
         #   CALL azzp110_chk_dzld_rows()
         #   IF NOT g_chk_status THEN
         #      LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  輸入的單號",g_param.docno,"及項次",g_param.seq USING "<<<<<<",
         #                                               " 單身筆數已超過",lc_max_rows USING "<<<<<","筆，請輸入新單號</td></tr>"
         #   CALL g_gen_ch.writeLine(lc_msg)
         #      RETURN
         #   END IF

            LET lc_rpzzl003_old = ""
            SELECT rpzzl003 INTO lc_rpzzl003_old FROM rpzzl_t
             WHERE rpzzl001 = lc_rpzzl001
               AND rpzzl002 = la_gzzy[li_cnt].gzzy001
            IF SQLCA.SQLCODE THEN
               #填寫過單資訊，需檢核是否存在主檔中
               LET lc_count = 0
               LET lc_item1 = "NULL"
               LET lc_item2 = "NULL"
               SELECT COUNT(1) INTO lc_count FROM rpzz_t
                WHERE rpzz001 = lc_rpzzl001
               IF lc_count > 0 THEN
               #   IF NOT azzp110_insert_dzld('rpzzl_t','azzi901',lc_rpzzl001,' ') THEN
               #      LET g_chk_status = FALSE
               #      RETURN
               #   END IF
                  LET lc_item1 = "arpi900"
                  LET lc_item2 = lc_rpzzl001
               END IF
            
               INSERT INTO rpzzl_t(rpzzl001,rpzzl002,rpzzl003)
                 VALUES(lc_rpzzl001,la_gzzy[li_cnt].gzzy001,lc_rpzzl003_new)
               
               IF SQLCA.SQLCODE THEN
                  LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(insert)rpzzl_t失敗...  rpzzl001:",lc_rpzzl001,"  rpzzl002:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                  CALL g_gen_ch.writeLine(lc_msg)
                  RETURN
               END IF
               LET lc_update = "Y"
            ELSE
               IF la_gzzy[li_cnt].gzzy001<> 'zh_TW' AND lc_rpzzl003_new <> lc_rpzzl003_old THEN
                  #填寫過單資訊，需檢核是否存在主檔中
                  LET lc_count = 0
                  LET lc_item1 = "NULL"
                  LET lc_item2 = "NULL"
                  SELECT COUNT(1) INTO lc_count FROM rpzz_t
                   WHERE rpzz001 = lc_rpzzl001
                  IF lc_count > 0 THEN
                  #   IF NOT azzp110_insert_dzld('rpzzl_t','azzi901',lc_rpzzl001,' ') THEN
                  #      LET g_chk_status = FALSE
                  #      RETURN
                  #   END IF
                     LET lc_item1 = "arpi900"
                     LET lc_item2 = lc_rpzzl001
                  END IF
            
                  UPDATE rpzzl_t SET rpzzl003 = lc_rpzzl003_new
                   WHERE rpzzl001 = lc_rpzzl001 AND rpzzl002 = la_gzzy[li_cnt].gzzy001
                  
                  IF SQLCA.SQLCODE THEN
                     LET lc_msg = "<tr hieght=22><td class=xl24>ERROR  更新(update)rpzzl_t失敗...  rpzzl001:",lc_rpzzl001,"  rpzzl002:",la_gzzy[li_cnt].gzzy001,"  SQLCA.SQLCODE:",SQLCA.SQLCODE,"</td></tr>"
                     CALL g_gen_ch.writeLine(lc_msg)
                     RETURN
                  END IF
                  LET lc_update = "Y"
               END IF
            END IF
            
            IF lc_update = "Y" THEN
               #紀錄log
               LET lc_msg = "<tr hieght=22><td class=xl24>",la_gzzy[li_cnt].gzzy001,"</td>",   #更換語系
                                          "<td class=xl24>rpzzl_t</td>",              #更換的多語言table
                                          "<td class=xl24>",g_param.docno,"</td>",    #表單單號
                                          "<td class=xl24>",g_param.seq,"</td>",      #項次
                                          "<td class=xl24>",lc_item1,"</td>",         #關聯項目
                                          "<td class=xl24>",lc_item2,"</td>",         #過單條件值
                                          "<td class=xl24>",lc_rpzzl003_old,"</td>",  #資料修改前
                                          "<td class=xl24>",lc_rpzzl003_new,"</td>",  #資料修改後
                            "</tr>"
        
               CALL g_gen_ch.writeLine(lc_msg)
            END IF
         END IF
         FREE azzp110_exp_rpzzl_pre
      END FOR

   END FOREACH
END FUNCTION

#end add-point
 
{</section>}
 
