#該程式未解開Section, 採用最新樣板產出!
{<section id="azzi110_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0007(2016-09-10 16:05:20), PR版次:0007(2016-09-19 17:04:32)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000100
#+ Filename...: azzi110_01
#+ Description: 指定表格選擇畫面
#+ Creator....: 01856(2014-06-03 17:32:39)
#+ Modifier...: 00824 -SD/PR- 00824
 
{</section>}
 
{<section id="azzi110_01.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"

#end add-point
#add-point:填寫註解說明(客製用) name="main.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="main.import"
IMPORT util
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
{</section>}
 
{<section id="azzi110_01.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
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
DEFINE g_arr_table_name DYNAMIC ARRAY OF STRING
DEFINE g_imp_table_name DYNAMIC ARRAY OF STRING
DEFINE g_exp_table_name DYNAMIC ARRAY OF STRING
DEFINE g_fill_zhcn      DYNAMIC ARRAY OF STRING
DEFINE gs_type  STRING 
#end add-point
 
{</section>}
 
{<section id="azzi110_01.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"
GLOBALS
   DEFINE g_docno              LIKE type_t.chr20
   DEFINE g_seq                LIKE type_t.num5
   CONSTANT lc_max_rows = 10000     #紀錄每張過單單號+項次最多可以過幾筆資料
   CONSTANT lc_langtable_num = 27   #紀錄目前需要處理的多語言檔案個數
END GLOBALS
#end add-point
 
{</section>}
 
{<section id="azzi110_01.other_dialog" >}

 
{</section>}
 
{<section id="azzi110_01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzi110_01(ps_type)
#                  RETURNING 
# Input parameter: ps_type 項目 STRING
#                : 
# Return code....: 
#                : 
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION azzi110_01(ps_type)
   DEFINE ps_type            STRING
   DEFINE lc_count           LIKE type_t.num10
   DEFINE ls_sure            LIKE type_t.num5
   

   WHENEVER ERROR CALL cl_err_msg_log 

  #畫面開啟 (identifier)
   OPEN WINDOW w_azzi110_01 WITH FORM cl_ap_formpath("azz","azzi110_01")
  
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   LET gs_type = ps_type
   #程式起始資料初始化
   CALL azzi110_01_init()

   INPUT BY NAME  g_set_up_m.dzeal_set_up,g_set_up_m.dzebl_set_up,g_set_up_m.gzzal_set_up,g_set_up_m.gzzd_set_up,
                  g_set_up_m.gzdfl_set_up,g_set_up_m.gzzq_set_up, g_set_up_m.gzswl_set_up,g_set_up_m.gzsxl_set_up,
                  g_set_up_m.gzszl_set_up,g_set_up_m.gzwel_set_up,g_set_up_m.gzcal_set_up,g_set_up_m.gzcbl_set_up,
                  g_set_up_m.gzgdl_set_up,g_set_up_m.gzge_set_up, g_set_up_m.dzcal_set_up,g_set_up_m.dzcdl_set_up,
                  g_set_up_m.dzcbl_set_up,g_set_up_m.dzcel_set_up,g_set_up_m.gzdel_set_up,g_set_up_m.gzhal_set_up,
                  g_set_up_m.gzial_set_up,g_set_up_m.gzidl_set_up,g_set_up_m.gzjal_set_up,g_set_up_m.gztdl_set_up,
                  g_set_up_m.gztel_set_up,g_set_up_m.gzzol_set_up,g_set_up_m.gzzf_set_up, g_set_up_m.wscal_set_up,
                  g_set_up_m.wsebl_set_up,g_set_up_m.wsecl_set_up,g_set_up_m.gzgjl_set_up,g_set_up_m.gzahl_set_up,
                  g_set_up_m.gzgp_set_up, g_set_up_m.rpdel_set_up,g_set_up_m.rpzzl_set_up
                     ATTRIBUTE(WITHOUT DEFAULTS,UNBUFFERED,FIELD ORDER FORM)
                
      BEFORE INPUT
    
      AFTER FIELD dzeal_set_up
    
    
      AFTER INPUT
         #在匯到各個多語言表前，需先檢查禁用字詞暫存表(gzos_t)中是否有還未更新到各多語言表的資料
         #若有，需先做完暫存表中的資料，再做字典檔的轉換，
         #以避免各多語言檔在做轉換的時候，無法對應到字典檔中正確的字詞
         LET lc_count = 0
         SELECT COUNT(1) INTO lc_count FROM gzos_t
         WHERE gzos001 = "zh_TW"
         IF gs_type = "exp" AND lc_count > 0 THEN
            IF g_exp_table_name.getLength() < lc_langtable_num THEN
               IF g_bgjob = "N" THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "azz-00382"
                  LET g_errparam.extend = 'azz-00382'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               END IF
               CALL azzi110_01_checkbox('Y')
            END IF
         END IF
         CALL azzi110_01_chk_item()
    
      ON ACTION select_all
         CALL azzi110_01_checkbox('Y')
         CALL azzi110_01_chk_item()
    
      ON ACTION disselect_all
         CALL azzi110_01_checkbox('N')
         CALL azzi110_01_chk_item()
    
      ON ACTION CANCEL   # (放棄)
         LET INT_FLAG = TRUE
         EXIT INPUT 
         
      ON ACTION CLOSE    #右上角 (X)
         LET INT_FLAG = TRUE
         EXIT INPUT 
    
      ON ACTION EXIT     #toolbar 離開
         LET INT_FLAG = TRUE   
         EXIT INPUT 
      #交談指令共用ACTION
      &include "common_action.4gl"         
    
   END INPUT 

   IF INT_FLAG THEN 
      LET INT_FLAG = FALSE   
   ELSE
      LET ls_sure = FALSE
      CASE
         WHEN gs_type = "imp"
            IF cl_ask_confirm('azz-00384') THEN
               LET ls_sure = TRUE
            END IF

         WHEN gs_type = "exp"
            IF cl_ask_confirm('azz-00385') THEN
               #因為匯出到各多語言檔時需要自動補入過單資料，所以須詢問過單單號與項次
               IF azzi110_01_new_bugno() THEN
                  LET ls_sure = TRUE
               END IF
            END IF
            
         WHEN gs_type = "chk"
            LET ls_sure = TRUE
            
      END CASE
      
      IF ls_sure THEN
         CALL azzi110_01_item_process()
      END IF
   END IF 
   #畫面關閉
   CLOSE WINDOW w_azzi110_01
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzi110_01_init()
#                  RETURNING 
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi110_01_init()
  
   CALL azzi110_01_checkbox('N') 
END FUNCTION

################################################################################
# Descriptions...: 畫面check box 設定
# Memo...........:
# Usage..........: CALL azzi110_01_checkbox(ps_chk)
#                  RETURNING 回传参数
# Input parameter: ps_chk N/Y CHAR(1) 
#                : 
# Return code....: 
#                : 
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi110_01_checkbox(ps_chk)
   DEFINE ps_chk LIKE type_t.chr1

   LET g_set_up_m.dzeal_set_up = ps_chk
   LET g_set_up_m.dzebl_set_up = ps_chk
   LET g_set_up_m.gzzal_set_up = ps_chk
   LET g_set_up_m.gzzd_set_up  = ps_chk
   LET g_set_up_m.gzdfl_set_up = ps_chk
   LET g_set_up_m.gzzq_set_up  = ps_chk
   LET g_set_up_m.gzswl_set_up = ps_chk
   LET g_set_up_m.gzsxl_set_up = ps_chk
   LET g_set_up_m.gzszl_set_up = ps_chk
   LET g_set_up_m.gzwel_set_up = ps_chk
   LET g_set_up_m.gzcal_set_up = ps_chk
   LET g_set_up_m.gzcbl_set_up = ps_chk
   LET g_set_up_m.gzgdl_set_up = ps_chk
   LET g_set_up_m.gzge_set_up  = ps_chk
   LET g_set_up_m.dzcal_set_up = ps_chk
   LET g_set_up_m.dzcbl_set_up = ps_chk
   LET g_set_up_m.dzcdl_set_up = ps_chk
   LET g_set_up_m.dzcel_set_up = ps_chk
   LET g_set_up_m.gzdel_set_up = ps_chk
   LET g_set_up_m.gzhal_set_up = ps_chk
   LET g_set_up_m.gzial_set_up = ps_chk
   LET g_set_up_m.gzidl_set_up = ps_chk
   LET g_set_up_m.gzjal_set_up = ps_chk
   LET g_set_up_m.gztdl_set_up = ps_chk
   LET g_set_up_m.gztel_set_up = ps_chk
   LET g_set_up_m.gzzol_set_up = ps_chk
   LET g_set_up_m.gzzf_set_up  = ps_chk
   LET g_set_up_m.wscal_set_up = ps_chk
   LET g_set_up_m.wsebl_set_up = ps_chk
   LET g_set_up_m.wsecl_set_up = ps_chk
   LET g_set_up_m.gzgjl_set_up = ps_chk
   LET g_set_up_m.gzahl_set_up = ps_chk
   LET g_set_up_m.gzgp_set_up  = ps_chk
   LET g_set_up_m.rpdel_set_up = ps_chk
   LET g_set_up_m.rpzzl_set_up = ps_chk
   
END FUNCTION

################################################################################
# Descriptions...: 執行所選定的項目
# Memo...........:
# Usage..........: CALL azzi110_01_item_process()
#                  RETURNING 
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi110_01_item_process()
   DEFINE li_cnt  LIKE type_t.num5 
   DEFINE la_param      RECORD
             prog       STRING,
             actionid   STRING,
             param      DYNAMIC ARRAY OF STRING
             END RECORD
   DEFINE ls_js         STRING
   DEFINE li_count      LIKE type_t.num5
   DEFINE lc_count      LIKE type_t.num10
   DEFINE ls_file_name  STRING
   DEFINE ls_file_path  STRING
   DEFINE ls_begin      STRING
   DEFINE l_channel     base.Channel
   DEFINE ls_url        STRING
   DEFINE l_urlfile     STRING
   DEFINE li_stat       LIKE type_t.num5
   
   
   CASE
      WHEN gs_type = "chk"
         CALL cl_progress_bar(g_arr_table_name.getLength())

         LET ls_begin = TODAY USING "yyyymmdd"
         LET ls_file_name = "azzi110_chk_langtable_twcn_",ls_begin CLIPPED ,".xls"
         CALL azzi110_01_excel_head(ls_file_name)
         
         FOR li_cnt = 1 TO g_arr_table_name.getLength()
             CALL cl_progress_ing("azzp110 "||g_arr_table_name[li_cnt])
             LET la_param.prog = "azzp110"
             LET la_param.param[1] = gs_type                     #執行動作 (chk/imp/exp)  *必填*
             LET la_param.param[2] = 'N'                         #是否所有多語言table都做 (Y/N)  *必填*
             LET la_param.param[3] = g_arr_table_name[li_cnt]    #要執行的多語言table  *必填*
             LET la_param.param[4] = ls_file_name                #log檔名稱  *必填*
             LET la_param.param[5] = g_docno                     #過單單號   *若是exp則必填*
             LET la_param.param[6] = g_seq                       #過單項次   *若是exp則必填*
             LET la_param.param[7] = ""                          #額外條件
             LET ls_js = util.JSON.stringify(la_param)
             CALL cl_cmdrun_wait(ls_js)
         END FOR
      
      WHEN gs_type = "imp"
         CALL cl_progress_bar(g_imp_table_name.getLength()+1)
         
         LET ls_begin = TODAY USING "yyyymmdd"
         LET ls_file_name = "azzi110_imp_gzoz_",ls_begin CLIPPED ,".xls"
         CALL azzi110_01_excel_head(ls_file_name)
         
         #先處理 import
         FOR li_cnt = 1 TO g_imp_table_name.getLength()
             CALL cl_progress_ing("azzp110 "||g_imp_table_name[li_cnt])
             LET la_param.prog = "azzp110"
             LET la_param.param[1] = gs_type                     #執行動作 (chk/imp/exp)  *必填*
             LET la_param.param[2] = 'N'                         #是否所有多語言table都做 (Y/N)  *必填*
             LET la_param.param[3] = g_imp_table_name[li_cnt]    #要執行的多語言table  *必填*
             LET la_param.param[4] = ls_file_name                #log檔名稱  *必填*
             LET la_param.param[5] = g_docno                     #過單單號   *若是exp則必填*
             LET la_param.param[6] = g_seq                       #過單項次   *若是exp則必填*
             LET la_param.param[7] = ""                          #額外條件
             LET ls_js = util.JSON.stringify(la_param)
             CALL cl_cmdrun_wait(ls_js)
         END FOR
         
         #再處理 填滿簡體中文(zh_CN)
         CALL azzi110_01_fill_zhcn_lang() 
         DISPLAY "填滿 zh_CN 完成"
         CALL cl_progress_ing("fill zh_CN ")
      
      WHEN gs_type = "exp" 
         #最後處理 export
         CALL cl_progress_bar(g_exp_table_name.getLength())
         
         LET ls_begin = TODAY USING "yyyymmdd"
         LET ls_file_name = "azzi110_exp_langtable_",ls_begin CLIPPED ,
                            "_",g_docno CLIPPED,"_",g_seq USING "<<<<<<",".xls"
         CALL azzi110_01_excel_head(ls_file_name)
         
         FOR li_cnt = 1 TO g_exp_table_name.getLength()
             CALL cl_progress_ing("azzp110 "||g_exp_table_name[li_cnt])
             LET la_param.prog = "azzp110"
             LET la_param.param[1] = gs_type                       #執行動作 (chk/imp/exp)  *必填*
             LET la_param.param[2] = 'N'                           #是否所有多語言table都做 (Y/N)  *必填*
             LET la_param.param[3] = g_exp_table_name[li_cnt]      #要執行的多語言table  *必填*
             LET la_param.param[4] = ls_file_name                  #log檔名稱  *必填*
             LET la_param.param[5] = g_docno                       #過單單號  *若是exp則必填*
             LET la_param.param[6] = g_seq                         #過單項次  *若是exp則必填*
             LET la_param.param[7] = ""                            #額外條件
             LET ls_js = util.JSON.stringify(la_param)
             CALL cl_cmdrun_wait(ls_js)
         END FOR 
   END CASE
   
   LET ls_file_path = os.Path.join(FGL_GETENV("TEMPDIR"),ls_file_name)
   IF os.Path.size(ls_file_path) > 0 THEN
      LET l_channel = base.Channel.create()
      CALL l_channel.openFile(ls_file_path, "a")
      CALL l_channel.setDelimiter("")

      #組xml檔案(表尾)
      CALL l_channel.write("</table></body></html>")
      CALL l_channel.close()

      #開啟檔案
      LET l_urlfile = ''
      LET l_urlfile = ls_file_name
      LET l_urlfile = l_urlfile.trim()
      LET l_urlfile = cl_trans_url_encode(l_urlfile)
      LET ls_url = os.Path.join(os.Path.join(FGL_GETENV("FGLASIP"),"out"),l_urlfile CLIPPED)
      LET li_stat = cl_client_open_url(ls_url)
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 項目檢核是否有被勾選
# Memo...........: 把要執行的項目組合起來
# Usage..........: CALL azzi110_01_chk_item()
#                  RETURNING 
# Input parameter: 
#                : 
# Return code....: 
#                : 
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi110_01_chk_item()
   DEFINE ls_cmd STRING 
   DEFINE ls_str STRING 

   CALL g_imp_table_name.clear()
   CALL g_exp_table_name.clear()
   CALL g_arr_table_name.clear()
   
   CASE 
     WHEN gs_type = "imp" #匯入指定表到字典檔中文資料 並做把中文轉成簡體中文填入字典檔 最後匯出指定表
        LET ls_cmd = "import_fr_"  
        
        IF g_set_up_m.dzeal_set_up = 'Y' THEN 
           LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_dzeal_tw"
        END IF 
        IF g_set_up_m.dzebl_set_up = 'Y' THEN 
           LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_dzebl_tw"
        END IF
        IF g_set_up_m.gzzal_set_up = 'Y' THEN 
           LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_gzzal_tw"
        END IF
        IF g_set_up_m.gzzd_set_up = 'Y' THEN 
           LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_gzzd_tw"
        END IF
        IF g_set_up_m.gzdfl_set_up = 'Y' THEN 
           LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_gzdfl_tw"
        END IF
        IF g_set_up_m.gzzq_set_up = 'Y' THEN 
           LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_gzzq_tw"
        END IF
        IF g_set_up_m.gzswl_set_up = 'Y' THEN     
           LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_gzswl_tw"
        END IF
        IF g_set_up_m.gzsxl_set_up = 'Y' THEN 
           LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_gzsxl_tw"
        END IF
        IF g_set_up_m.gzszl_set_up = 'Y' THEN 
           LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_gzszl_tw"
        END IF
        IF g_set_up_m.gzwel_set_up = 'Y' THEN 
           LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_gzwel_tw"
        END IF
        IF g_set_up_m.gzcal_set_up = 'Y' THEN 
           LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_gzcal_tw"
        END IF
        IF g_set_up_m.gzcbl_set_up = 'Y' THEN 
           LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_gzcbl_tw"
        END IF
        IF g_set_up_m.gzgdl_set_up = 'Y' THEN 
           LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_gzgdl_tw"
        END IF
         IF g_set_up_m.gzge_set_up = 'Y' THEN 
           LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_gzge_tw"
        END IF
        IF g_set_up_m.dzcal_set_up = 'Y' THEN 
           LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_dzcal_tw"
        END IF
        IF g_set_up_m.dzcbl_set_up = 'Y' THEN 
           LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_dzcbl_tw"
        END IF
        IF g_set_up_m.dzcdl_set_up = 'Y' THEN 
           LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_dzcdl_tw"
        END IF
        IF g_set_up_m.dzcel_set_up = 'Y' THEN 
           LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_dzcel_tw"
        END IF
        IF g_set_up_m.gzdel_set_up = 'Y' THEN 
           LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_gzdel_tw"
        END IF
        IF g_set_up_m.gzhal_set_up = 'Y' THEN 
           LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_gzhal_tw"
        END IF
        IF g_set_up_m.gzial_set_up = 'Y' THEN 
           LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_gzial_tw"
        END IF
        IF g_set_up_m.gzidl_set_up = 'Y' THEN 
           LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_gzidl_tw"
        END IF
        IF g_set_up_m.gzjal_set_up = 'Y' THEN 
           LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_gzjal_tw"
        END IF
        IF g_set_up_m.gztdl_set_up = 'Y' THEN 
           LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_gztdl_tw"
        END IF
        IF g_set_up_m.gztel_set_up = 'Y' THEN 
           LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_gztel_tw"
        END IF
        IF g_set_up_m.gzzol_set_up = 'Y' THEN 
           LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_gzzol_tw"
        END IF
        IF g_set_up_m.gzzf_set_up = 'Y' THEN 
           LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_gzzf_tw"
        END IF
        IF g_set_up_m.wscal_set_up = 'Y' THEN 
           LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_wscal_tw"
        END IF
        IF g_set_up_m.wsebl_set_up = 'Y' THEN 
           LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_wsebl_tw"
        END IF
        IF g_set_up_m.wsecl_set_up = 'Y' THEN 
           LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_wsecl_tw"
        END IF
        IF g_set_up_m.gzgjl_set_up = 'Y' THEN 
           LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_gzgjl_tw"
        END IF
        IF g_set_up_m.gzahl_set_up = 'Y' THEN 
           LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_gzahl_tw"
        END IF
        IF g_set_up_m.gzgp_set_up = 'Y' THEN 
           LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_gzgp_tw"
        END IF
        IF g_set_up_m.rpdel_set_up = 'Y' THEN 
           LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_rpdel_tw"
        END IF
        IF g_set_up_m.rpzzl_set_up = 'Y' THEN 
           LET g_imp_table_name[g_imp_table_name.getLength()+1] = "import_fr_rpzzl_tw"
        END IF
   
     WHEN gs_type = "exp"  #匯出指定表所有語言資料 
        LET ls_cmd = "exp_"
        
        IF g_set_up_m.dzeal_set_up = 'Y' THEN
           LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_dzeal"
        END IF 
        IF g_set_up_m.dzebl_set_up = 'Y' THEN
           LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_dzebl"
        END IF
        IF g_set_up_m.gzzal_set_up = 'Y' THEN
           LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_gzzal"
        END IF
        IF g_set_up_m.gzzd_set_up = 'Y' THEN
           LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_gzzd"
        END IF
        IF g_set_up_m.gzdfl_set_up = 'Y' THEN
           LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_gzdfl"
        END IF
        IF g_set_up_m.gzzq_set_up = 'Y' THEN
           LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_gzzq"
        END IF
        IF g_set_up_m.gzswl_set_up = 'Y' THEN
           LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_gzswl"
        END IF
        IF g_set_up_m.gzsxl_set_up = 'Y' THEN
           LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_gzsxl"
        END IF
        IF g_set_up_m.gzszl_set_up = 'Y' THEN
           LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_gzszl"
        END IF
        IF g_set_up_m.gzwel_set_up = 'Y' THEN
           LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_gzwel"
        END IF
        IF g_set_up_m.gzcal_set_up = 'Y' THEN
           LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_gzcal"
        END IF
        IF g_set_up_m.gzcbl_set_up = 'Y' THEN
           LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_gzcbl"
        END IF
        IF g_set_up_m.gzgdl_set_up = 'Y' THEN
           LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_gzgdl"
        END IF
         IF g_set_up_m.gzge_set_up = 'Y' THEN
           LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_gzge"
        END IF
        IF g_set_up_m.dzcal_set_up = 'Y' THEN
           LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_dzcal"
        END IF
        IF g_set_up_m.dzcbl_set_up = 'Y' THEN
           LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_dzcbl"
        END IF
        IF g_set_up_m.dzcdl_set_up = 'Y' THEN
           LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_dzcdl"
        END IF
        IF g_set_up_m.dzcel_set_up = 'Y' THEN
           LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_dzcel"
        END IF
        IF g_set_up_m.gzdel_set_up = 'Y' THEN
           LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_gzdel"
        END IF
        IF g_set_up_m.gzhal_set_up = 'Y' THEN
           LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_gzhal"
        END IF
        IF g_set_up_m.gzial_set_up = 'Y' THEN
           LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_gzial"
        END IF
        IF g_set_up_m.gzidl_set_up = 'Y' THEN
           LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_gzidl"
        END IF
        IF g_set_up_m.gzjal_set_up = 'Y' THEN
           LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_gzjal"
        END IF
        IF g_set_up_m.gztdl_set_up = 'Y' THEN
           LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_gztdl"
        END IF
        IF g_set_up_m.gztel_set_up = 'Y' THEN
           LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_gztel"
        END IF
        IF g_set_up_m.gzzol_set_up = 'Y' THEN
           LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_gzzol"
        END IF
        IF g_set_up_m.gzzf_set_up = 'Y' THEN
           LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_gzzf"
        END IF
        IF g_set_up_m.wscal_set_up = 'Y' THEN
           LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_wscal"
        END IF
        IF g_set_up_m.wsebl_set_up = 'Y' THEN
           LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_wsebl"
        END IF
        IF g_set_up_m.wsecl_set_up = 'Y' THEN
           LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_wsecl"
        END IF
        IF g_set_up_m.gzgjl_set_up = 'Y' THEN
           LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_gzgjl"
        END IF
        IF g_set_up_m.gzahl_set_up = 'Y' THEN
           LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_gzahl"
        END IF
        IF g_set_up_m.gzgp_set_up = 'Y' THEN
           LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_gzgp"
        END IF
        IF g_set_up_m.rpdel_set_up = 'Y' THEN
           LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_rpdel"
        END IF
        IF g_set_up_m.rpzzl_set_up = 'Y' THEN
           LET g_exp_table_name[g_exp_table_name.getLength()+1] = "exp_rpzzl"
        END IF
        
     WHEN gs_type = "chk"  #檢查指定表內簡繁正確性
          LET ls_cmd = "chk_"
          LET ls_str = "_twcn"
   
          IF g_set_up_m.dzeal_set_up = 'Y' THEN 
             LET g_arr_table_name[g_arr_table_name.getLength()+1] = ls_cmd,"dzeal",ls_str
          END IF 
          IF g_set_up_m.dzebl_set_up = 'Y' THEN 
             LET g_arr_table_name[g_arr_table_name.getLength()+1] = ls_cmd,"dzebl",ls_str
          END IF
          IF g_set_up_m.gzzal_set_up = 'Y' THEN 
             LET g_arr_table_name[g_arr_table_name.getLength()+1] = ls_cmd,"gzzal",ls_str
          END IF
          IF g_set_up_m.gzzd_set_up = 'Y' THEN 
             LET g_arr_table_name[g_arr_table_name.getLength()+1] = ls_cmd,"gzzd",ls_str
          END IF
          IF g_set_up_m.gzdfl_set_up = 'Y' THEN 
             LET g_arr_table_name[g_arr_table_name.getLength()+1] = ls_cmd,"gzdfl",ls_str
          END IF
          IF g_set_up_m.gzzq_set_up = 'Y' THEN 
             LET g_arr_table_name[g_arr_table_name.getLength()+1] = ls_cmd,"gzzq",ls_str
          END IF
          IF g_set_up_m.gzswl_set_up = 'Y' THEN 
             LET g_arr_table_name[g_arr_table_name.getLength()+1] = ls_cmd,"gzswl",ls_str
          END IF
          IF g_set_up_m.gzsxl_set_up = 'Y' THEN 
             LET g_arr_table_name[g_arr_table_name.getLength()+1] = ls_cmd,"gzsxl",ls_str
          END IF
          IF g_set_up_m.gzszl_set_up = 'Y' THEN 
             LET g_arr_table_name[g_arr_table_name.getLength()+1] = ls_cmd,"gzszl",ls_str
          END IF
          IF g_set_up_m.gzwel_set_up = 'Y' THEN 
             LET g_arr_table_name[g_arr_table_name.getLength()+1] = ls_cmd,"gzwel",ls_str
          END IF
          IF g_set_up_m.gzcal_set_up = 'Y' THEN 
             LET g_arr_table_name[g_arr_table_name.getLength()+1] = ls_cmd,"gzcal",ls_str
          END IF
          IF g_set_up_m.gzcbl_set_up = 'Y' THEN 
             LET g_arr_table_name[g_arr_table_name.getLength()+1] = ls_cmd,"gzcbl",ls_str
          END IF
          IF g_set_up_m.gzgdl_set_up = 'Y' THEN 
             LET g_arr_table_name[g_arr_table_name.getLength()+1] = ls_cmd,"gzgdl",ls_str
          END IF
           IF g_set_up_m.gzge_set_up = 'Y' THEN 
             LET g_arr_table_name[g_arr_table_name.getLength()+1] = ls_cmd,"gzge",ls_str
          END IF
          IF g_set_up_m.dzcal_set_up = 'Y' THEN 
             LET g_arr_table_name[g_arr_table_name.getLength()+1] = ls_cmd,"dzcal",ls_str
          END IF
          IF g_set_up_m.dzcbl_set_up = 'Y' THEN 
             LET g_arr_table_name[g_arr_table_name.getLength()+1] = ls_cmd,"dzcbl",ls_str
          END IF
          IF g_set_up_m.dzcdl_set_up = 'Y' THEN 
             LET g_arr_table_name[g_arr_table_name.getLength()+1] = ls_cmd,"dzcdl",ls_str
          END IF
          IF g_set_up_m.dzcel_set_up = 'Y' THEN 
             LET g_arr_table_name[g_arr_table_name.getLength()+1] = ls_cmd,"dzcel",ls_str
          END IF
          IF g_set_up_m.gzdel_set_up = 'Y' THEN
             LET g_arr_table_name[g_arr_table_name.getLength()+1] = ls_cmd,"gzdel",ls_str
          END IF
          IF g_set_up_m.gzhal_set_up = 'Y' THEN
             LET g_arr_table_name[g_arr_table_name.getLength()+1] = ls_cmd,"gzhal",ls_str
          END IF
          IF g_set_up_m.gzial_set_up = 'Y' THEN
             LET g_arr_table_name[g_arr_table_name.getLength()+1] = ls_cmd,"gzial",ls_str
          END IF
          IF g_set_up_m.gzidl_set_up = 'Y' THEN
             LET g_arr_table_name[g_arr_table_name.getLength()+1] = ls_cmd,"gzidl",ls_str
          END IF
          IF g_set_up_m.gzjal_set_up = 'Y' THEN
             LET g_arr_table_name[g_arr_table_name.getLength()+1] = ls_cmd,"gzjal",ls_str
          END IF
          IF g_set_up_m.gztdl_set_up = 'Y' THEN
             LET g_arr_table_name[g_arr_table_name.getLength()+1] = ls_cmd,"gztdl",ls_str
          END IF
          IF g_set_up_m.gztel_set_up = 'Y' THEN
             LET g_arr_table_name[g_arr_table_name.getLength()+1] = ls_cmd,"gztel",ls_str
          END IF
          IF g_set_up_m.gzzol_set_up = 'Y' THEN
             LET g_arr_table_name[g_arr_table_name.getLength()+1] = ls_cmd,"gzzol",ls_str
          END IF
          IF g_set_up_m.gzzf_set_up = 'Y' THEN
             LET g_arr_table_name[g_arr_table_name.getLength()+1] = ls_cmd,"gzzf",ls_str
          END IF
          IF g_set_up_m.wscal_set_up = 'Y' THEN
             LET g_arr_table_name[g_arr_table_name.getLength()+1] = ls_cmd,"wscal",ls_str
          END IF
          IF g_set_up_m.wsebl_set_up = 'Y' THEN
             LET g_arr_table_name[g_arr_table_name.getLength()+1] = ls_cmd,"wsebl",ls_str
          END IF
          IF g_set_up_m.wsecl_set_up = 'Y' THEN
             LET g_arr_table_name[g_arr_table_name.getLength()+1] = ls_cmd,"wsecl",ls_str
          END IF
          IF g_set_up_m.gzgjl_set_up = 'Y' THEN
             LET g_arr_table_name[g_arr_table_name.getLength()+1] = ls_cmd,"gzgjl",ls_str
          END IF
          IF g_set_up_m.gzahl_set_up = 'Y' THEN
             LET g_arr_table_name[g_arr_table_name.getLength()+1] = ls_cmd,"gzahl",ls_str
          END IF
          IF g_set_up_m.gzgp_set_up = 'Y' THEN
             LET g_arr_table_name[g_arr_table_name.getLength()+1] = ls_cmd,"gzgp",ls_str
          END IF
          IF g_set_up_m.rpdel_set_up = 'Y' THEN
             LET g_arr_table_name[g_arr_table_name.getLength()+1] = ls_cmd,"rpdel",ls_str
          END IF
          IF g_set_up_m.rpzzl_set_up = 'Y' THEN
             LET g_arr_table_name[g_arr_table_name.getLength()+1] = ls_cmd,"rpzzl",ls_str
          END IF
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 輸入過單單號及項次
# Memo...........:
# Usage..........: CALL azzi110_01_new_bugno()
#                  RETURNING 回传参数
# Input parameter: 
# Return code....: 
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi110_01_new_bugno()
   DEFINE li_status  LIKE type_t.num5
   DEFINE lc_count   LIKE type_t.num5


   LET li_status = TRUE
   LET g_docno = ""
   LET g_seq = ""

   #輸入需求單號
   LET g_docno = cl_ask_prtmsg("azz-00929",g_lang)

   #輸入需求單項次
   LET g_seq = cl_ask_prtmsg("azz-00930",g_lang)
   
   IF cl_null(g_docno) OR cl_null(g_seq) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "adz-00347"
      LET g_errparam.code   = "adz-00347"
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      
      LET li_status = FALSE
      RETURN li_status
   END IF

   #檢查輸入的單號是否存在，並已派工給PR
   #dzlu_t中紀錄的都是已派工且尚未結案的單號
   IF gs_type = "exp" AND (FGL_GETENV("ZONE") = "t10dev" OR FGL_GETENV("ZONE") = "t10dit") THEN
      LET lc_count = 0
      SELECT COUNT(1) INTO lc_count FROM dzlu_t
       WHERE dzlu001 = "PR"
         AND dzlu003 = g_docno AND dzlu006 = g_seq
      
      IF lc_count <= 0 THEN
         LET li_status = FALSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend = "azz-00388"
         LET g_errparam.code   = "azz-00388"
         LET g_errparam.popup  = TRUE
         LET g_errparam.replace[1] = g_docno
         LET g_errparam.replace[2] = g_seq
         CALL cl_err()
      ELSE
         #為了過單效能，每個單號及項次不可超過1萬筆
         LET lc_count = 0
         SELECT COUNT(1) INTO lc_count FROM dzld_t
          WHERE dzld011 = g_docno
            AND dzld014 = g_seq

         IF lc_count >= lc_max_rows THEN
            LET li_status = FALSE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = "azz-00390"
            LET g_errparam.code   = "azz-00390"
            LET g_errparam.popup  = TRUE
            LET g_errparam.replace[1] = g_docno
            LET g_errparam.replace[2] = g_seq
            CALL cl_err()
         END IF
      END IF
   END IF
   
   RETURN li_status
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzi110_01_fill_zhcn_lang()
#                  RETURNING 回传参数
# Input parameter: 
# Return code....: 
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi110_01_fill_zhcn_lang()
   DEFINE r_success         LIKE type_t.num5
   DEFINE lc_gzozmodid      LIKE gzoz_t.gzozmodid
   DEFINE ld_gzozmoddt      DATETIME YEAR TO SECOND
   DEFINE lc_gzoz000        LIKE gzoz_t.gzoz000
   DEFINE lc_gzoz002        LIKE gzoz_t.gzoz002
   DEFINE lc_gzoz002_old    LIKE gzoz_t.gzoz002


   LET lc_gzozmodid = g_user
   LET ld_gzozmoddt = cl_get_current()
   DECLARE azzi110_01_trans_zh_cn_cs CURSOR FOR 
      SELECT gzoz000,gzoz002 FROM  gzoz_t 

   FOREACH azzi110_01_trans_zh_cn_cs INTO lc_gzoz000,lc_gzoz002_old
      IF cl_null(lc_gzoz002_old)  THEN 
         LET lc_gzoz002 = cl_trans_code_tw_cn("zh_CN",lc_gzoz000)
 
         UPDATE gzoz_t SET (gzoz102,gzoz002,gzozmodid,gzozmoddt)=('Y',lc_gzoz002,lc_gzozmodid,ld_gzozmoddt)
            WHERE gzoz000 = lc_gzoz000 #項次
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = ''
            LET g_errparam.popup = FALSE
            CALL cl_err()
 
            EXIT FOREACH
         END IF
      END IF 
   END FOREACH
   
   CLOSE azzi110_01_trans_zh_cn_cs
  
END FUNCTION

################################################################################
# Descriptions...: 組合匯出的excel檔表頭
# Memo...........:
# Usage..........: CALL azzi110_01_excel_head(li_file)
#                  RETURNING 回传参数
# Input parameter: 
# Return code....: 
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzi110_01_excel_head(li_file)
   DEFINE li_file       STRING
   DEFINE lc_cnt        LIKE type_t.num10
   DEFINE l_channel     base.Channel
   DEFINE l_str         STRING
   DEFINE l_quote       LIKE type_t.chr10
   
   
   #此次匯出的檔案
   LET l_channel = base.Channel.create()
   LET li_file = os.Path.join(FGL_GETENV("TEMPDIR"),li_file)
   IF os.Path.exists(li_file) THEN
      IF os.Path.delete(li_file) THEN
      END IF
   END IF
   IF NOT os.Path.exists(li_file) THEN
      CALL l_channel.openFile(li_file, "w")
   ELSE
      CALL l_channel.openFile(li_file, "a")
   END IF
   CALL l_channel.setDelimiter("")
   
   #組xml檔(表頭資訊)
   LET l_str = "<html xmlns:o=",l_quote,"urn:schemas-microsoft-com:office:office",l_quote
   CALL l_channel.write(l_str CLIPPED)
   LET l_str = "xmlns:x=",l_quote,"urn:schemas-microsoft-com:office:excel",l_quote
   CALL l_channel.write(l_str CLIPPED)
   LET l_str = "xmlns=",l_quote,"http://www.w3.org/TR/REC-html40",l_quote,">"
   CALL l_channel.write(l_str CLIPPED)

   CALL l_channel.write("<head>")
   LET l_str = "<meta http-equiv=Content-Type content=",l_quote,"text/html; charset=UTF-8",l_quote,">"
   CALL l_channel.write(l_str CLIPPED)
   CALL l_channel.write("<style><!--")
   CALL l_channel.write("td  {font-family:Courier New, serif;}")
   
   LET l_str = ".xl24  {mso-number-format:",l_quote,"\@",l_quote,";}",
               ".xl30 {mso-style-parent:style0; mso-number-format:\"0_ \";} ",
               ".xl31 {mso-style-parent:style0; mso-number-format:\"0\.0_ \";} ",
               ".xl32 {mso-style-parent:style0; mso-number-format:\"0\.00_ \";} ",
               ".xl33 {mso-style-parent:style0; mso-number-format:\"0\.000_ \";} ",
               ".xl34 {mso-style-parent:style0; mso-number-format:\"0\.0000_ \";} ",
               ".xl35 {mso-style-parent:style0; mso-number-format:\"0\.00000_ \";} ",
               ".xl36 {mso-style-parent:style0; mso-number-format:\"0\.000000_ \";} ",
               ".xl37 {mso-style-parent:style0; mso-number-format:\"0\.0000000_ \";} ",
               ".xl38 {mso-style-parent:style0; mso-number-format:\"0\.00000000_ \";} ",
               ".xl39 {mso-style-parent:style0; mso-number-format:\"0\.000000000_ \";} ",
               ".xl40 {mso-style-parent:style0; mso-number-format:\"0\.0000000000_ \";} "

   CALL l_channel.write(l_str CLIPPED)
   CALL l_channel.write("--></style>")
   
   CALL l_channel.write("<!--[if gte mso 9]><xml>")
   CALL l_channel.write("<x:ExcelWorkbook>")
   CALL l_channel.write("<x:DefaultRowHeight>330</x:DefaultRowHeight>")
   CALL l_channel.write("</x:ExcelWorkbook>")
   CALL l_channel.write("</xml><![endif]--></head>")
   CALL l_channel.write("<body><table border=1 cellpadding=0 cellspacing=0 width=432 style='border-collapse: collapse;table-layout:fixed;width:324pt'>")
   
   CASE
      WHEN gs_type = "chk"
         LET l_str = "<tr hieght=22><td class=xl24>檢查的多語言table</td>",
                                   "<td class=xl24>key值欄位1</td>",
                                   "<td class=xl24>key值欄位2</td>",
                                   "<td class=xl24>key值欄位3</td>",
                                   "<td class=xl24>檢查語系</td>",
                                   "<td class=xl24>原始字詞</td>",
                     "</tr>"
         CALL l_channel.write(l_str CLIPPED)
      WHEN gs_type = "imp"
         LET l_str = "<tr hieght=22><td class=xl24>檢查的多語言table</td>",
                                   "<td class=xl24>檢查語系</td>",
                                   "<td class=xl24>key值1</td>",
                                   "<td class=xl24>key值2</td>",
                                   "<td class=xl24>key值3</td>",
                                   "<td class=xl24>原始字詞</td>",
                                   "<td class=xl24>使用到的禁用字</td>",
                     "</tr>"
         CALL l_channel.write(l_str CLIPPED)
         
      WHEN gs_type = "exp"
         LET l_str = "<tr hieght=22><td class=xl24>更換語系</td>",
                                   "<td class=xl24>更換的多語言table</td>",
                                   "<td class=xl24>表單單號</td>",
                                   "<td class=xl24>項次</td>",
                                   "<td class=xl24>關聯項目</td>",
                                   "<td class=xl24>過單條件值</td>",
                                   "<td class=xl24>資料修改前1</td>",
                                   "<td class=xl24>資料修改後1</td>",
                                   "<td class=xl24>資料修改前2</td>",
                                   "<td class=xl24>資料修改後2</td>",
                                   "<td class=xl24>資料修改前3</td>",
                                   "<td class=xl24>資料修改後3</td>",
                                   "<td class=xl24>資料修改前4</td>",
                                   "<td class=xl24>資料修改後4</td>",
                      "</tr>"
         CALL l_channel.write(l_str CLIPPED)
   END CASE

   CALL l_channel.close()
END FUNCTION

 
{</section>}
 
