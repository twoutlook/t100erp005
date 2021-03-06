#該程式已解開Section, 不再透過樣板產出!
{<section id="azzp953.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0008(1900-01-01 00:00:00), PR版次:0008(2017-01-17 22:33:12)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000036
#+ Filename...: azzp953
#+ Description: 排程接續執行器
#+ Creator....: 00845(2015-10-13 14:56:43)
#+ Modifier...: 00000 -SD/PR- 01856
 
{</section>}
 
{<section id="azzp953.global" >}
#應用 i00 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#+ Modifier...: No.161223-00026 #1   2016/12/23  jrg542    補充背景提示訊息
#+ Modifier...: No.170112-00016 #1   2017/01/12  jrg542    增加程式註解 
#+ Modifier...: No.170117-00074 #1   2017/01/17  jrg542    增加更新增訊
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"
IMPORT util
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
GLOBALS
   DEFINE g_schedule_id   LIKE gzpe_t.gzpe001     #報表背景執行的排程編號
   DEFINE g_schedule_seq  LIKE gzpe_t.gzpe002     #報表背景執行的排程序號

   DEFINE g_gen_ch    base.Channel
   DEFINE gc_ent      LIKE gzpa_t.gzpaent  #enterprise code
   DEFINE gs_temp     STRING
   DEFINE g_gzpcent   LIKE gzpc_t.gzpcent
   DEFINE g_gzpc000   LIKE gzpc_t.gzpc000
   DEFINE g_gzpc003   LIKE gzpc_t.gzpc003
   DEFINE g_gzpc004   LIKE gzpc_t.gzpc004
END GLOBALS
#end add-point
 
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
{</section>}
 
{<section id="azzp953.main" >}
#+ 作業開始
MAIN
   #add-point:main段define
   DEFINE la_param   RECORD
             sessionkey   STRING,
             parent       STRING,
             background   LIKE type_t.chr1,
             prog         STRING,
             account      STRING,
             actionid     STRING,
             param        DYNAMIC ARRAY OF STRING,
             notify       STRING
             END RECORD
   DEFINE ls_param   STRING
   DEFINE li_sleep   LIKE type_t.num10
   DEFINE li_times   LIKE type_t.num10
   #end add-point

   #定義在其他link的程式則無效
   WHENEVER ERROR CALL cl_err_msg_log

   LET g_bgjob = "Y"
   LET g_prog = "azzp953"
   LET g_account = FGL_GETENV("LOGNAME")

   #解析傳入參數
   IF NOT cl_null(ARG_VAL(1)) THEN
      CALL util.JSON.parse(ARG_VAL(1),la_param)
      IF la_param.param[1] = "kill" THEN
         LET ls_param = la_param.param[1]
         LET gc_ent = FGL_GETENV("TOPENT")
         DISPLAY "參數:",ls_param ," 企業編號:",gc_ent
      ELSE
         LET g_gzpcent = la_param.param[1]
         LET g_gzpc000 = la_param.param[2]
         DISPLAY "傳入參數:  企業編號:",g_gzpcent,"  排程執行序號:",g_gzpc000
         IF cl_null(g_gzpcent) OR cl_null(g_gzpc000) THEN
            DISPLAY "傳入參數有誤，企業編號 或 排程執行序號為空"
            EXIT PROGRAM
         END IF
      END IF
   ELSE
      DISPLAY "傳入參數有誤，ARG_VAL(1)為空"
      EXIT PROGRAM
   END IF
   
   IF g_account = "tiptop" AND cl_null(ls_param) THEN
      LET g_bgjob = "Y"       #重新再設定
      LET g_prog = "azzp953"  #重新再設定
      #連結資料庫後執行工作
      CALL cl_db_connect("ds",FALSE)
      CALL azzp953_cycle()
      CALL cl_db_disconnect_current()

   ELSE
      CALL cl_db_connect("ds",FALSE)

      IF cl_get_para(g_enterprise,g_site,"A-SYS-0005") IS NOT NULL AND
         cl_get_para(g_enterprise,g_site,"A-SYS-0005") = "Y" THEN
      ELSE
         DISPLAY "INFO: 系統設置為不允許執行背景作業(azzs010/A-SYS-0005)"
         EXIT PROGRAM
      END IF
      
      IF cl_null(ls_param) THEN
      ELSE
         CASE
            WHEN ls_param = "kill"
               CALL s_azzp950_kill_ps("azzp953")
         #  OTHERWISE
         #     CALL azzp953_only_job_start(ls_param)
         END CASE
      END IF

      CALL cl_db_disconnect_current()
   END IF
 

 

END MAIN
{</section>}
 
{<section id="azzp953.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp953_cycle()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp953_cycle()
   DEFINE ld_now        DATETIME YEAR TO FRACTION(3)
   DEFINE li_times      LIKE type_t.num10

   #檢查參數是否繼續執行背景批次
   IF cl_get_para(g_enterprise,g_site,"A-SYS-0005") IS NOT NULL AND
      cl_get_para(g_enterprise,g_site,"A-SYS-0005") = "Y" THEN
   ELSE
      LET gs_temp = "INFO: 系統設置改為不允許執行背景作業(azzs010/A-SYS-0005)"
      CALL azzp953_output_log(gs_temp)
      RETURN FALSE
   END IF

   CALL azzp953_channel()

   LET ld_now = cl_get_current()
   LET gs_temp = "-------------Start 時間:",ld_now,"------(",li_times,")----------"
   CALL azzp953_output_log(gs_temp)

   CALL azzp953_detail_job()
   CALL azzp953_execute_log()

   LET ld_now = cl_get_current()
   LET gs_temp = "-------------End   時間:",ld_now,"-------GO TO 休眠------------"
   
   CALL azzp953_output_log(gs_temp)
   CALL g_gen_ch.close()
END FUNCTION

################################################################################
# Descriptions...: 排程作業執行
# Memo...........:
# Usage..........: CALL azzp953_detail_job()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp953_detail_job()
   DEFINE lc_gzpd          RECORD
          gzpd001          LIKE gzpd_t.gzpd001,   #序號
          gzpd002          LIKE gzpd_t.gzpd002,   #排程編號
          gzpd003          LIKE gzpd_t.gzpd003,   #序號
          gzpd004          LIKE gzpd_t.gzpd004,   #執行作業
          gzpd005          LIKE gzpd_t.gzpd005,   #傳入參數
          gzpd006          LIKE gzpd_t.gzpd006,   #執行營運據點
          gzpd007          LIKE gzpd_t.gzpd007,   #作業執行狀態
          gzpd009          LIKE gzpd_t.gzpd009,   #執行使用者編號
          gzpd011          LIKE gzpd_t.gzpd011,   #執行順序
          gzpd014          LIKE gzpd_t.gzpd014    #任務執行主機
                           END RECORD
   DEFINE ls_msg           STRING
   DEFINE ls_sql           STRING
   DEFINE ls_gzpd011_old   LIKE gzpd_t.gzpd011
   DEFINE ls_sessionkey    STRING
   DEFINE ls_gzpd011_cnt   LIKE type_t.num5       #紀錄該執行順序總共有幾筆資料
   DEFINE ls_cnt_now       LIKE type_t.num5       #紀錄目前該筆資料是該執行順序的第幾筆
   DEFINE ls_finish_cnt    LIKE type_t.num5       #紀錄該執行順序已完成的筆數共有幾筆
   DEFINE ls_run_wait      LIKE type_t.chr1       #判斷執行該作業時是否需要wait
   DEFINE ls_status        LIKE type_t.num5
   DEFINE ls_single_status LIKE type_t.num5
   DEFINE ld_now           DATETIME YEAR TO SECOND
   DEFINE ls_hostname      LIKE gzdd_t.gzdd002
   
   
   LET ls_hostname = cl_get_ap_hostname()
   
   #看目前時間=排程執行時間 啟動job
   DECLARE gzpd_cs CURSOR FOR
    SELECT gzpd001,gzpd002,gzpd003,gzpd004,gzpd005,
           gzpd006,gzpd007,gzpd009,gzpd011,gzpd014
      FROM gzpd_t,gzdd_t
     WHERE gzpdent = g_gzpcent
       AND gzpd001 = g_gzpc000
       AND gzpd014 = gzdd002
       AND gzpd014 = ls_hostname
       AND gzdd003 = "Y"
     ORDER BY gzpdent ASC,gzpd011 ASC,gzpd003 ASC

   #計算同一執行順序有幾筆
   LET ls_sql = "SELECT COUNT(1) FROM gzpd_t",
                " WHERE gzpdent = ",g_gzpcent,
                  " AND gzpd001 = '",g_gzpc000,"'",
                  " AND gzpd011 = ?",
                  " AND gzpd014 = ?"
   PREPARE azzp953_count_pre FROM ls_sql

   #計算同一執行順序已完成的有幾筆
   LET ls_sql = "SELECT COUNT(1) FROM gzpd_t",
                " WHERE gzpdent = ",g_gzpcent,
                  " AND gzpd001 = '",g_gzpc000,"'",
                  " AND gzpd007 = 'F'",
                  " AND gzpd011 = ?",
                  " AND gzpd014 = ?"
   PREPARE azzp953_finish_count_pre FROM ls_sql
   
   #更新單頭的執行狀態
   CALL azzp953_upd_gzpc("R")

   FOREACH gzpd_cs INTO lc_gzpd.gzpd001,lc_gzpd.gzpd002,lc_gzpd.gzpd003,lc_gzpd.gzpd004,lc_gzpd.gzpd005,
                        lc_gzpd.gzpd006,lc_gzpd.gzpd007,lc_gzpd.gzpd009,lc_gzpd.gzpd011,lc_gzpd.gzpd014
      
      CASE
         WHEN lc_gzpd.gzpd007 = "N" OR lc_gzpd.gzpd007 = "R"

            #計算目前是此執行順序中的第幾筆
            IF lc_gzpd.gzpd011 <> ls_gzpd011_old THEN
               LET ls_cnt_now = 1

               #取得同一執行順序的總筆數 (此執行順序共有幾筆)
               EXECUTE azzp953_count_pre USING lc_gzpd.gzpd011,lc_gzpd.gzpd014 INTO ls_gzpd011_cnt

               LET gs_temp = "*****新執行順序 Start*****: ENT:",g_gzpcent,
                             " 排程執行編號:",lc_gzpd.gzpd001," 執行順序:",lc_gzpd.gzpd011
               CALL azzp953_output_log(gs_temp)
            ELSE
               LET ls_cnt_now = ls_cnt_now + 1
            END IF
            
            #判斷是否需要run wiat
            #預設該執行順序的最後一筆需做wait，若該執行順序只有一筆，那也需要做wait
            IF ls_cnt_now = ls_gzpd011_cnt THEN
               LET ls_run_wait = "Y"
            ELSE
               LET ls_run_wait = "N"
            END IF

            LET gs_temp = "process start: 排程執行編號 ",lc_gzpd.gzpd001," 序號 : ",lc_gzpd.gzpd003,
                          " 執行順序 : ",lc_gzpd.gzpd011," 執行作業 : ",lc_gzpd.gzpd004,
                          " 原始執行狀態 : ",lc_gzpd.gzpd007,"\n",
                          " 執行順序總共有幾筆資料(ls_gzpd011_cnt) :",ls_gzpd011_cnt,  #170112-00016  #170117-00074
                          " 紀錄目前執行順序的第幾筆(ls_cnt_now) :",ls_cnt_now        #170112-00016   #170117-00074
            
            #判斷排程執行狀態
            CASE
               WHEN lc_gzpd.gzpd007 = "N"   #未執行
                  #若排程尚未執行，且目前的執行順序是1，就可直接執行該排程作業
                  #若執行順序非1，則需檢查前一順序是否已執行完畢
                  IF lc_gzpd.gzpd011 <> 1 AND lc_gzpd.gzpd011 <> ls_gzpd011_old THEN
                     #取得前一執行順序已完成的筆數
                     EXECUTE azzp953_finish_count_pre USING ls_gzpd011_old,lc_gzpd.gzpd014 INTO ls_finish_cnt

                     #若前一執行順序已完成筆數小於前一執行順序總筆數，表示還有未執行完成的
                     #需檢核是正在執行中還是程序已經不見了
                     IF ls_finish_cnt < ls_gzpd011_cnt THEN
                        #如果沒有前一執行順序的紀錄(有可能是中斷後重新執行)
                        #則前一執行順序 以目前執行順序-1 去查看
                        #檢查process是否存在時，若有錯誤會立即寄送mail
                        IF ls_gzpd011_old = 0 THEN
                           LET ls_status =  azzp953_chk_process_exists(lc_gzpd.gzpd004,lc_gzpd.gzpd011-1)
                        ELSE
                           LET ls_status =  azzp953_chk_process_exists(lc_gzpd.gzpd004,ls_gzpd011_old)
                        END IF
                        
                        #若有錯誤，則不往下進行
                        IF NOT ls_status THEN
                           LET gs_temp = "檢核前一執行順序的狀況時發現錯誤 : 當下執行順序 : ",lc_gzpd.gzpd011,
                                         " 序號 : ",lc_gzpd.gzpd003
                           CALL azzp953_output_log(gs_temp)
      
                           EXIT FOREACH
                        END IF
                     END IF
                  END IF
                  
               WHEN lc_gzpd.gzpd007 = "R"   #執行中
                  #檢查本次順序的job是還在執行中 或者是已經掛點了
                  #檢查process是否存在時，若有錯誤會立即寄送mail
                  LET ls_status =  azzp953_chk_process_exists(lc_gzpd.gzpd004,lc_gzpd.gzpd011)

                  #若有錯誤，則不往下進行
                  IF NOT ls_status THEN
                      LET gs_temp = "檢核當下執行順序的狀況時發現錯誤 : 當下執行順序 : ",lc_gzpd.gzpd011,
                                    " 序號 : ",lc_gzpd.gzpd003
                      CALL azzp953_output_log(gs_temp)

                     EXIT FOREACH
                  END IF

            END CASE
            
            LET gs_temp = "job Start cmdrun before : ",
                          " 序號:",lc_gzpd.gzpd003," 執行作業:",lc_gzpd.gzpd004,
                          " 傳入參數:",lc_gzpd.gzpd005," 執行使用者編號:",lc_gzpd.gzpd009,
                          " 是否以run wait方式執行:",ls_run_wait
            CALL azzp953_output_log(gs_temp)

            #先把單身的執行狀態更新為 R:執行中，並更新作業開始時間
            CALL azzp953_upd_gzpd(lc_gzpd.gzpd003,"R","Y","N")

            #組參數
            LET g_schedule_id = lc_gzpd.gzpd002     #背景執行的排程編號
            LET g_schedule_seq = lc_gzpd.gzpd003    #背景執行的排程序號
            
            LET ls_sessionkey = azzp953_cmdrun(ls_run_wait,lc_gzpd.gzpd003,lc_gzpd.gzpd004,lc_gzpd.gzpd005,lc_gzpd.gzpd006,lc_gzpd.gzpd009)

            #將sessionkey更新至gzpd_t   #151222 sessionkey改由cl_cmdrun寫入
         #  CALL azzp953_upd_gzpd_by_job(lc_gzpd.gzpd003,ls_sessionkey)

            #不論同一執行順序是否有多筆，當最後一筆執行後，需一併檢查其他筆是否已經執行完畢
            #    須等到同一順序的job都執行完畢後，才可繼續進行下一順序的job
            IF ls_cnt_now = ls_gzpd011_cnt THEN
               #檢查process是否存在時，若有錯誤會立即寄送mail
               LET ls_status = azzp953_chk_process_exists(lc_gzpd.gzpd004,lc_gzpd.gzpd011)

               IF ls_status THEN
                  #每個執行順序完成後需寄送mail
                  LET ld_now = cl_get_current()
                  CALL azzp953_send_mail(lc_gzpd.gzpd002,lc_gzpd.gzpd003,ld_now,"F")
               ELSE
                  #若有錯誤，則不往下進行
                  LET gs_temp = "process end : 有job執行完畢後其狀態碼未更新為 F:已完成，視為執行錯誤！",
                                " 排程執行序號:",lc_gzpd.gzpd001,
                                " 執行順序:",lc_gzpd.gzpd011
                  CALL azzp953_output_log(gs_temp)

                  EXIT FOREACH
               END IF
               
               LET gs_temp = "*****新執行順序 End*****: 排程執行編號:",lc_gzpd.gzpd001,
                             " 執行順序:",lc_gzpd.gzpd011
               CALL azzp953_output_log(gs_temp)
            END IF

            #紀錄此次的執行順序為何
            LET ls_gzpd011_old = lc_gzpd.gzpd011
            
         OTHERWISE
            LET ls_status = FALSE

            LET gs_temp = "process end: 排程執行編號 ",lc_gzpd.gzpd001, " 序號 : ",lc_gzpd.gzpd003,
                          " 原始執行狀態 非 N 或 R，不往下進行！"
            CALL azzp953_output_log(gs_temp)

            #寄發mail
            LET ld_now = cl_get_current()
            CALL azzp953_send_mail(lc_gzpd.gzpd002,lc_gzpd.gzpd003,ld_now,"E")

      END CASE

   END FOREACH
   
   #更新單頭執行狀態
   IF ls_status THEN
      CALL azzp953_upd_gzpc("F")
      CALL azzp953_upd_gzpa(lc_gzpd.gzpd002)
   ELSE
      CALL azzp953_upd_gzpc("E")
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 實際執行程式
# Memo...........:
# Usage..........: CALL azzp953_cmdrun(ps_run_wait,ps_gzpd003,ps_gzpd004,ps_gzpd005,ps_gzpd006,ps_gzpd009)
#                  RETURNING ls_sessionkey
# Input parameter: ps_run_wait    執行時是否需要wait
#                : ps_gzpd003     序號     
#                : ps_gzpd004     執行作業
#                : ps_gzpd005     傳入參數
#                : ps_gzpd006     執行營運據點
#                : ps_gzpd009     執行使用者編號
# Return code....: ls_sessionkey  
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp953_cmdrun(ps_run_wait,ps_gzpd003,ps_gzpd004,ps_gzpd005,ps_gzpd006,ps_gzpd009)
   DEFINE ps_run_wait   LIKE type_t.chr1
   DEFINE lc_ent_bak    LIKE gzpd_t.gzpdent
   DEFINE ps_gzpd003    LIKE gzpd_t.gzpd003
   DEFINE ps_gzpd004    STRING
   DEFINE ps_gzpd005    STRING
   DEFINE ps_gzpd006    LIKE gzpd_t.gzpd006   #指定執行營運據點
   DEFINE ps_gzpd009    LIKE gzpd_t.gzpd009   #指定執行account
   DEFINE ls_cmd        STRING
   DEFINE la_param      RECORD
            prog        STRING,
            actionid    STRING,
            userid      STRING,
            background  LIKE type_t.chr1,
            param       DYNAMIC ARRAY OF STRING,
            gzpdent     LIKE gzpd_t.gzpdent,
            gzpd001     LIKE gzpd_t.gzpd001,
            gzpd003     LIKE gzpd_t.gzpd003
                        END RECORD
   DEFINE ls_js         STRING
   DEFINE ls_sessionkey STRING
   DEFINE obj           util.JSONObject
   DEFINE li_cnt        LIKE type_t.num5
   
   
   LET la_param.prog = ps_gzpd004 CLIPPED
   LET la_param.background = "Y"
   LET la_param.param[1] = ps_gzpd005 CLIPPED
   LET la_param.gzpdent = g_gzpcent CLIPPED
   LET la_param.gzpd001 = g_gzpc000 CLIPPED
   LET la_param.gzpd003 = ps_gzpd003 CLIPPED
   LET ls_js = util.JSON.stringify( la_param )

   #員工編號及營業據點
   CALL FGL_SETENV("BACKGROUND_START","azzp953")
   CALL FGL_SETENV("BACKGROUND_LOGNAME",ps_gzpd009)
   CALL FGL_SETENV("BACKGROUND_SITE",ps_gzpd006)

   #實施企業
   LET lc_ent_bak = FGL_GETENV("TOPENT")
   CALL FGL_SETENV("TOPENT",g_gzpcent)
   LET gs_temp = "設定TOPENT=",g_gzpcent," STATUS=",STATUS," ORIG=",lc_ent_bak
   CALL azzp953_output_log(gs_temp)
   
   IF ps_run_wait = "N" THEN
      LET gs_temp = "cl_cmdrun ps_run_wait=",ps_run_wait," ls_js:",ls_js            #161223-00026 add
      CALL azzp953_output_log(gs_temp)                                              #161223-00026 add
      LET ls_sessionkey = cl_cmdrun(ls_js)
   ELSE
      #執行順序的 前一筆 還沒執行完 要走這一段 run wait
      #預設該執行順序的最後一筆需做wait，若該執行順序只有一筆，那也需要做wait  ex: 順序1、1 第二個要wait
      LET gs_temp = "cl_cmdrun_wait ps_run_wait=",ps_run_wait," ls_js:",ls_js       #161223-00026 add
      CALL azzp953_output_log(gs_temp)                                              #161223-00026 add
      LET ls_sessionkey = cl_cmdrun_wait(ls_js)
   END IF

   #假如程式沒有走到這一段落，表示call cl_cmdrun 或 call cl_cmdrun_wait 過程有問題，使程式結束(掛掉)    #170112-00016 
   LET gs_temp = "cmdrun: 傳入參數 ",ls_js," sessionkey:",ls_sessionkey
   CALL azzp953_output_log(gs_temp)

   CALL FGL_SETENV("TOPENT",lc_ent_bak)
   CALL FGL_SETENV("BACKGROUND_START"," ")
   RETURN ls_sessionkey
   
END FUNCTION

################################################################################
# Descriptions...: 寄送郵件彙總
# Memo...........:
# Usage..........: CALL azzp953_send_mail(pc_gzpe001,pc_gzpe002,pc_gzpd008,ps_status)
# Input parameter: pc_gzpe001     排程編號
#                : pc_gzpe002     序號
#                : pc_gzpd008     收件者名稱
#                : ps_status      狀態
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp953_send_mail(pc_gzpe001,pc_gzpe002,pc_gzpd008,ps_status)
   DEFINE pc_gzpe001    LIKE gzpe_t.gzpe001 #排程編號
   DEFINE pc_gzpe002    LIKE gzpe_t.gzpe002 #序號
   DEFINE pc_gzpd008    LIKE gzpd_t.gzpd008
   DEFINE ps_status     STRING              #信件寄送彙總
   DEFINE lc_gzpe003    LIKE gzpe_t.gzpe003 #執行狀況
   DEFINE lc_gzpe004    LIKE gzpe_t.gzpe004 #收件人員工編號
   DEFINE lc_gzpe005    LIKE gzpe_t.gzpe005 #信件主旨
   DEFINE lc_gzpe006    LIKE gzpe_t.gzpe006 #信件內文
   DEFINE lc_gzpe012    LIKE gzpe_t.gzpe012 #聯絡對象類型
   DEFINE ls_file       STRING
   DEFINE lc_channel    base.Channel
   DEFINE ls_text       STRING
   DEFINE ls_tmp        STRING
   DEFINE li_cnt        LIKE type_t.num5
   DEFINE ls_run_cmd    STRING
   DEFINE lc_gzpe002    LIKE gzpe_t.gzpe002 #排程序號
   DEFINE lb_run_result BOOLEAN
   DEFINE ls_err_msg    STRING
   
   
   #取得單頭資訊
   SELECT gzpc003,gzpc004 INTO g_gzpc003,g_gzpc004 FROM gzpc_t
    WHERE gzpcent = g_gzpcent
      AND gzpc000 = g_gzpc000

   #信件暫存檔案路徑
   #每一筆新的檔案把之前一筆delete 保持最新的一筆
   LET ls_file = "azzp953_mail_",pc_gzpe001,".txt"
   LET ls_file = os.Path.join(FGL_GETENV("TEMPDIR"),ls_file)

   IF ps_status = "TF" THEN
      LET lc_gzpe003 = "F"
   ELSE
      LET lc_gzpe003 = ps_status.trim()
   END IF

   #信件檔案
   LET lc_channel = base.Channel.create()
   CALL lc_channel.openFile( ls_file CLIPPED, "w" )
   CALL lc_channel.setDelimiter("")
   
   LET li_cnt =  1

   DECLARE azzp953_send_mail_cs CURSOR FOR
    SELECT gzpe002,gzpe003,gzpe004,gzpe005,gzpe006,gzpe012
      FROM gzpe_t
     WHERE gzpeent = g_gzpcent
       AND gzpe001 = pc_gzpe001 AND gzpe002 = pc_gzpe002 AND gzpe003 = lc_gzpe003
     ORDER BY gzpe011

   FOREACH azzp953_send_mail_cs INTO lc_gzpe002,lc_gzpe003,lc_gzpe004,lc_gzpe005,lc_gzpe006,lc_gzpe012
      IF os.Path.exists(ls_file) THEN
         IF os.Path.delete(ls_file) THEN END IF
         CALL lc_channel.openFile( ls_file CLIPPED, "w" )
         CALL lc_channel.setDelimiter("")
      END IF

      #信件主旨
      INITIALIZE g_xml.* TO NULL
      
      #信件主旨
      INITIALIZE g_xml.* TO NULL

      IF ps_status = "TF" THEN
         LET g_xml.subject = "[T100排程執行成功通知] 編號:",pc_gzpe001,"(",lc_gzpe005,")"
         LET ls_text = "[T100排程執行成功通知] \n排程編號:",pc_gzpe001
         LET ls_text = ls_text,"\n排程說明:",lc_gzpe005,"\n\n"
         LET ls_text = ls_text,"本次執行細節\n"
         LET ls_text = ls_text,"==================================================\n"
         LET ls_text = ls_text,"執行時間:","由", pc_gzpd008 ,"起\n" #，至 gzpc006 止 \n"
         LET ls_text = ls_text,"執行序號:",g_gzpc000 ,"\n"
         LET ls_text = ls_text,"執行模式:",g_gzpc003  ,"(",azzp953_get_gzpc003_desc(g_gzpc003),")\n"
         LET ls_text = ls_text,"執行狀況:",g_gzpc004  ,"(",azzp953_get_gzpc004_desc(g_gzpc004),")\n"
         LET ls_text = ls_text,"總共執行作業數量:",azzp953_cnt_gzpd(),"\n"
         LET ls_text = ls_text,"備註:","\n"
         LET ls_text = ls_text,"個別項目執行可參考 $LOGDIR/azzp953_",TODAY USING "yyyymmdd",".log\n\n"
         LET ls_text = ls_text,"信件內文:",lc_gzpe006
      ELSE
         LET g_xml.subject = lc_gzpe005
         LET ls_text = ls_text,"執行時間:",pc_gzpd008,"\n"
         LET ls_text = ls_text,"執行狀況:",lc_gzpe003," (R執行中(Running)/F已完成(finish)/P暫停(suspend)/S停止(stop)/E錯誤(error)/W等待(wait))\n"
         LET ls_text = ls_text,"信件內文:",lc_gzpe006
      END IF
      
      CALL azzp953_output_log("信件內容:" || ls_text)
      CALL lc_channel.write(ls_text)

      #信件本文
      LET g_xml.body = ls_file

      #收件者  改用 s_aooi350_get_user_contact() 取email
   #  LET g_xml.recipient = s_aooi350_get_user_contact(lc_gzpe004,"4") CLIPPED
      LET g_xml.recipient = cl_s_aooi350_get_cont_ppl_email(lc_gzpe012,lc_gzpe004)   #161223-00026 #1 add
      LET ls_tmp = "e-mail:",g_xml.recipient
      CALL azzp953_output_log(ls_tmp)

      #寄發mail
      CALL cl_jmail() RETURNING ls_tmp
      LET gs_temp = "send_mail:",ls_tmp
      CALL azzp953_output_log(gs_temp)
      LET gs_temp = "send_mail: 排程編號: ", pc_gzpe001,"  聯絡對象識別碼: ",lc_gzpe012,"  聯絡對象編號: ",lc_gzpe004
      CALL azzp953_output_log(gs_temp)
      
   END FOREACH

   CALL lc_channel.close()
   CLOSE azzp953_send_mail_cs
   FREE azzp953_send_mail_cs
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp953_channel()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp953_channel()
   DEFINE ls_log_file STRING
   DEFINE ls_begin    STRING
   DEFINE lt_time     INTERVAL HOUR TO MINUTE

   LET ls_begin = TODAY USING "yyyymmdd"

   LET g_gen_ch = base.Channel.create()

   LET ls_log_file = "azzp953_",ls_begin CLIPPED ,"_",g_gzpc000,".log"
   LET ls_log_file = os.Path.join(FGL_GETENV("LOGDIR"),ls_log_file)

   IF NOT os.Path.exists(ls_log_file) THEN
      CALL g_gen_ch.openFile(ls_log_file, "w")
   ELSE
      CALL g_gen_ch.openFile(ls_log_file, "a")
   END IF
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp953_output_log(p_msg)
#                  RETURNING 回传参数
# Input parameter: p_msg          要寫入的訊息
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp953_output_log(p_msg)
   DEFINE p_msg   STRING

   CALL g_gen_ch.writeLine(p_msg)
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp953_execute_log()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp953_execute_log()
   DEFINE lc_lopa001 LIKE lopa_t.lopa001
   DEFINE lc_lopa002 DATETIME YEAR TO SECOND

   LET lc_lopa001 = FGL_GETPID()
#   LET lc_lopa002 = CURRENT YEAR TO SECOND
   LET lc_lopa002 = cl_get_current()
   #刪除其他紀錄
   DELETE FROM lopa_t
   #只新增現在最後一筆的執行紀錄
   INSERT INTO lopa_t(lopa001,lopa002) VALUES(lc_lopa001,lc_lopa002)
   
END FUNCTION

################################################################################
# Descriptions...: 更新gzpc_t資訊
# Memo...........:
# Usage..........: CALL azzp953_upd_gzpc(pc_gzpc004)
# Input parameter: pc_gzpc004     排程執行狀況
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp953_upd_gzpc(pc_gzpc004)
   DEFINE pc_gzpc004   LIKE gzpc_t.gzpc004
   DEFINE ld_now       DATETIME YEAR TO SECOND


   IF pc_gzpc004 = "F" THEN
      LET ld_now = cl_get_current()
   ELSE
      LET ld_now = ""
   END IF

   UPDATE gzpc_t SET gzpc004 = pc_gzpc004,gzpc006 = ld_now
    WHERE gzpcent = g_gzpcent
      AND gzpc000 = g_gzpc000
  
   #170117-00074
   LET gs_temp = "upd_gzpc gzpc004: ", pc_gzpc004,"  gzpc006:",ld_now,"  sqlca.sqlcode: ",sqlca.sqlcode   
   CALL azzp953_output_log(gs_temp)  
   #170117-00074   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp953_upd_gzpd(pc_gzpd003,pc_gzpd007,pc_upd_time_b,pc_upd_time_e)
# Input parameter: pc_gzpd003     序號
#                : pc_gzpd007     作業執行狀態
#                : pc_upd_time_b  是否更新作業開始執行時間
#                : pc_upd_time_e  是否更新作業結束時間
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp953_upd_gzpd(pc_gzpd003,pc_gzpd007,pc_upd_time_b,pc_upd_time_e)
   DEFINE pc_gzpd003      LIKE gzpd_t.gzpd003
   DEFINE pc_gzpd007      LIKE gzpd_t.gzpd007
   DEFINE pc_upd_time_b   LIKE type_t.chr1
   DEFINE pc_upd_time_e   LIKE type_t.chr1
   DEFINE ld_now          DATETIME YEAR TO SECOND
   DEFINE ls_error        STRING


   LET ld_now = cl_get_current()

   IF pc_gzpd007 <> "F" THEN     #更新作業執行狀態，因為 F 已完成狀態是由各作業自行寫入，所以此處當不為F時才做update
      UPDATE gzpd_t SET gzpd007 = pc_gzpd007
       WHERE gzpdent = g_gzpcent
         AND gzpd001 = g_gzpc000
         AND gzpd003 = pc_gzpd003
         
      IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN
         LET ls_error = ls_error,'error: sqlca.sqlcod:',sqlca.sqlcode,"\n"
         LET ls_error = ls_error,'error: sqlerrd3:',sqlca.sqlerrd[3],"\n"
         LET ls_error = ls_error,'error: gzpdent=',g_gzpcent,' gzpd001=',g_gzpc000,' gzpd003=',pc_gzpd003,"\n"
         LET ls_error = ls_error,'error: gzpd007=',pc_gzpd007
         CALL azzp953_output_log(ls_error)
         LET ls_error = ""
      END IF
   END IF

   IF pc_upd_time_b = "Y" THEN    #更新作業開始時間
      UPDATE gzpd_t SET gzpd008 = ld_now
       WHERE gzpdent = g_gzpcent
         AND gzpd001 = g_gzpc000
         AND gzpd003 = pc_gzpd003
         
      IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN
         LET ls_error = ls_error,'error: sqlca.sqlcod:',sqlca.sqlcode,"\n"
         LET ls_error = ls_error,'error: sqlerrd3:',sqlca.sqlerrd[3],"\n"
         LET ls_error = ls_error,'error: gzpdent=',g_gzpcent,' gzpd001=',g_gzpc000,' gzpd003=',pc_gzpd003,"\n"
         LET ls_error = ls_error,'error: gzpd008=',ld_now
         CALL azzp953_output_log(ls_error)
         LET ls_error = ""
      END IF
   END IF
   
   IF pc_upd_time_e = "Y" THEN    #更新作業結束時間
      UPDATE gzpd_t SET gzpd010 = ld_now
       WHERE gzpdent = g_gzpcent
         AND gzpd001 = g_gzpc000
         AND gzpd003 = pc_gzpd003
         
      IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN
         LET ls_error = ls_error,'error: sqlca.sqlcod:',sqlca.sqlcode,"\n"
         LET ls_error = ls_error,'error: sqlerrd3:',sqlca.sqlerrd[3],"\n"
         LET ls_error = ls_error,'error: gzpdent=',g_gzpcent,' gzpd001=',g_gzpc000,' gzpd003=',pc_gzpd003,"\n"
         LET ls_error = ls_error,'error: gzpd010=',ld_now
         CALL azzp953_output_log(ls_error)
         LET ls_error = ""
      END IF
   END IF
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp953_upd_gzpa(pc_gzpa001)
# Input parameter: pc_gzpa001     排程編號
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp953_upd_gzpa(pc_gzpa001)
   DEFINE pc_gzpa001   LIKE gzpa_t.gzpa001
   DEFINE lc_gzpa003   LIKE gzpa_t.gzpa003
   DEFINE ld_now       DATETIME YEAR TO SECOND


   SELECT gzpa003 INTO lc_gzpa003 FROM gzpa_t
    WHERE gzpaent = g_gzpcent
      AND gzpa001 = pc_gzpa001

   IF lc_gzpa003 = "2" THEN #指定時間於背景執行
      LET ld_now = cl_get_current()
      UPDATE gzpa_t SET gzpastus = 'N',gzpamoddt = ld_now
       WHERE gzpaent = g_gzpcent
         AND gzpa001 = pc_gzpa001
   END IF
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp953_upd_gzpd_by_job(pc_ent,pc_gzpd001,pc_gzpd003,ls_session)
# Input parameter: pc_gzpd003     序號
#                : ls_session     sessionkey
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp953_upd_gzpd_by_job(pc_gzpd003,ls_session)
   DEFINE pc_gzpd003    LIKE gzpd_t.gzpd003
   DEFINE pc_gzpd012    LIKE gzpd_t.gzpd012
   DEFINE ls_session    STRING
   DEFINE ld_now        DATETIME YEAR TO SECOND
   DEFINE ls_error      STRING
   DEFINE lc_newgzpd007 LIKE gzpd_t.gzpd007


   SELECT gzpd007 INTO lc_newgzpd007 FROM gzpd_t
    WHERE gzpdent = g_gzpcent AND gzpd001 = g_gzpc000
      AND gzpd003 = pc_gzpd003
   IF lc_newgzpd007 = "F" THEN
      LET ls_error = "already Finish! STOP update"
      CALL azzp953_output_log(ls_error)
      RETURN
   END IF
   
   #gzpd007
   #N 未執行(normal)/R 執行中(running)/F 已完成(finish)/P 暫停(suspend)/S 停止(stop)/E 錯誤(error)/W 等待(wait)
   LET ld_now = cl_get_current()
   LET pc_gzpd012 = ls_session

   LET ls_error = "更新前 gzpd012=",pc_gzpd012," 長度=",ls_session.getLength()," 原始=",ls_session
   CALL azzp953_output_log(ls_error)

   UPDATE gzpd_t SET gzpd008 = ld_now #, gzpd012 = pc_gzpd012    #151222 sessionkey改由cl_cmdrun寫入
    WHERE gzpdent = g_gzpcent
      AND gzpd001 = g_gzpc000
      AND gzpd003 = pc_gzpd003
    IF SQLCA.SQLCODE OR SQLCA.SQLERRD[3] = 0 THEN
       LET ls_error = ls_error,'error: sqlca.sqlcod:',sqlca.sqlcode,"\n"
       LET ls_error = ls_error,'error: sqlerrd3:',sqlca.sqlerrd[3],"\n"
       LET ls_error = ls_error,'error: gzpdent=',g_gzpcent,' gzpd001=',g_gzpc000,' gzpd003=',pc_gzpd003,"\n"
       LET ls_error = ls_error,'error: gzpd008=',ld_now,' gzpd012=',pc_gzpd012
       CALL azzp953_output_log(ls_error)
       LET ls_error = ""
    END IF

END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp953_cnt_gzpd()
#                  RETURNING li_cnt
# Input parameter: 
# Return code....: li_cnt         筆數
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp953_cnt_gzpd()
   DEFINE li_cnt     LIKE type_t.num5


   SELECT COUNT(1) INTO li_cnt FROM gzpd_t
    WHERE gzpdent = g_gzpcent
      AND gzpd001 = g_gzpd001

   RETURN li_cnt

END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp953_get_gzpc003_desc(pc_gzpc003)
#                  RETURNING lc_gzcbl004
# Input parameter: pc_gzpc003     排程執行模式
# Return code....: lc_gzcbl004    說明
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp953_get_gzpc003_desc(pc_gzpc003)
   DEFINE pc_gzpc003 LIKE gzpc_t.gzpc003
   DEFINE lc_gzcbl004 LIKE gzcbl_t.gzcbl004

   SELECT gzcbl004 INTO lc_gzcbl004 FROM gzcbl_t
    WHERE gzcbl001 = '66'
      AND gzcbl002 = pc_gzpc003
      AND gzcbl003 = 'zh_TW'
   RETURN lc_gzcbl004

END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING lc_gzcbl004
# Input parameter: pc_gzpc004     排程執行狀況
# Return code....: lc_gzcbl004    說明
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp953_get_gzpc004_desc(pc_gzpc004)
   DEFINE pc_gzpc004 LIKE gzpc_t.gzpc004
   DEFINE lc_gzcbl004 LIKE gzcbl_t.gzcbl004

   SELECT gzcbl004 INTO lc_gzcbl004 FROM gzcbl_t
    WHERE gzcbl001 = '65'
      AND gzcbl002 = pc_gzpc004
      AND gzcbl003 = 'zh_TW'
   RETURN lc_gzcbl004

END FUNCTION

################################################################################
# Descriptions...: 確認process是否存在
# Memo...........:
# Usage..........: CALL azzp953_chk_process_exists(lc_gzpd004,lc_gzpd011)
#                  RETURNING li_status
# Input parameter: lc_gzpd004     執行作業
#                : lc_gzpd011     執行順序
# Return code....: li_status      存在否
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp953_chk_process_exists(lc_gzpd004,lc_gzpd011)
   DEFINE ls_cmd      STRING
   DEFINE lch_pipe    base.Channel
   DEFINE lc_gzpd002  LIKE gzpd_t.gzpd002
   DEFINE lc_gzpd003  LIKE gzpd_t.gzpd003
   DEFINE lc_gzpd004  LIKE gzpd_t.gzpd004
   DEFINE lc_gzpd007  LIKE gzpd_t.gzpd007
   DEFINE lc_gzpd011  LIKE gzpd_t.gzpd011
   DEFINE lc_gzpd012  LIKE gzpd_t.gzpd012
   DEFINE lc_gzpd013  LIKE gzpd_t.gzpd013
   DEFINE ls_tmp      STRING
   DEFINE ls_tmp2     STRING
   DEFINE ls_tmp3     STRING
   DEFINE li_status   LIKE type_t.num5
   DEFINE ls_error    STRING
   DEFINE lc_type     LIKE type_t.num5
   DEFINE ls_sql      STRING
   DEFINE ld_now      DATETIME YEAR TO SECOND
   
   
   LET li_status = TRUE
   LET ls_sql = "SELECT gzpd002,gzpd003,gzpd012,gzpd013 FROM gzpd_t",
                " WHERE gzpdent = ",g_gzpcent,
                  " AND gzpd001 = '",g_gzpc000,"'",
                  " AND gzpd011 = ",lc_gzpd011,
                  " AND gzpd007 <> 'F'"
   PREPARE azzp953_get_sessionkey_pre FROM ls_sql
   DECLARE azzp953_get_sessionkey_cur CURSOR FOR azzp953_get_sessionkey_pre

   FOREACH azzp953_get_sessionkey_cur INTO lc_gzpd002,lc_gzpd003,lc_gzpd012,lc_gzpd013
      WHILE TRUE
         IF lc_gzpd013 IS NULL THEN
            LET lc_type = 1
            #先檢查session key是否為 NULL
            IF lc_gzpd012 IS NULL OR lc_gzpd012 = " " THEN
               IF lc_gzpd004 IS NULL OR lc_gzpd004 = " " THEN
                  LET li_status = FALSE
               #  LET ls_error = "error- process not exist, gzpd004,gzpd012 all null"
               #  CALL azzp953_output_log(ls_error)
               #  RETURN li_status
               ELSE
                  LET ls_cmd = "ps -efwww | grep --line-buffered  ",lc_gzpd004 CLIPPED
               END IF
               
               ELSE
               LET ls_cmd = "ps -efwww | grep --line-buffered  ",lc_gzpd012 CLIPPED
            END IF
            LET ls_cmd = ls_cmd,"|grep --line-buffered '",FGL_GETENV("ZONE") CLIPPED,"'",
                                "|grep --line-buffered 'fglrun-bin'",
                                "|grep -iv --line-buffered 'ps -ef'",
                                "|grep -v 'azzp953'"
         ELSE
            LET lc_type = 2
            LET ls_cmd = "ps -p ",lc_gzpd013 CLIPPED,
                                "|grep -iv --line-buffered 'PID'"
         END IF
         CALL azzp953_output_log(ls_cmd)
         
         LET lch_pipe = base.Channel.create()
         LET ls_tmp = ""
         LET ls_tmp2 = ""

         CALL lch_pipe.openPipe(ls_cmd, "r")
         WHILE TRUE
            LET ls_tmp = lch_pipe.readLine()
            IF lch_pipe.isEof() THEN
               EXIT WHILE
            END IF
            LET ls_tmp2 = ls_tmp2,ls_tmp
         END WHILE

         CALL azzp953_output_log(ls_tmp2)

         IF ls_tmp2.getLength() > 0 THEN
            LET li_status = TRUE
         ELSE
            LET li_status = FALSE
         END IF

         CALL lch_pipe.close()
         
         IF li_status = TRUE THEN
            SLEEP 5
         ELSE
            #若是找不到process，要確定是已經做完了還是掛點了
            SELECT gzpd007 INTO lc_gzpd007 FROM gzpd_t
             WHERE gzpdent = g_gzpcent
               AND gzpd001 = g_gzpc000
               AND gzpd003 = lc_gzpd003
            IF cl_null(lc_gzpd007) OR lc_gzpd007 <> "F" THEN
               LET li_status = FALSE

               #更新執行狀態
               #若是不正常結束，不可視為已完成，因此也不更新作業完成時間
               CALL azzp953_upd_gzpd(lc_gzpd003,"E","N","N")

               #寄送mail
               LET ld_now = cl_get_current()
               CALL azzp953_send_mail(lc_gzpd002,lc_gzpd003,ld_now,"E")
            ELSE
               LET li_status = TRUE
               
               #更新執行狀態
               #如果是正常結束，就更新作業結束時間
               CALL azzp953_upd_gzpd(lc_gzpd003,"F","N","Y")
            END IF
            EXIT FOREACH
         END IF
      END WHILE
   END FOREACH
   
   RETURN li_status
   
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL azzp953_kill_azzp953_ps()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION azzp953_kill_azzp953_ps()
   DEFINE ls_id       STRING
   DEFINE lch_pipe    base.Channel
   DEFINE ls_tmp      STRING
   DEFINE ls_tmp2     STRING
   DEFINE ls_cmd      STRING
   DEFINE li_chk      LIKE type_t.num5
   DEFINE ls_self_pid STRING
   
   
   LET li_chk = FALSE
   LET lch_pipe = base.Channel.create()
   LET ls_self_pid = FGL_GETPID()

  #LET ls_cmd = "ps -ef --sort=start_time | grep azzp953 | grep '",FGL_GETENV("ZONE") CLIPPED,"' | grep -v grep | awk '{print $1 \" \" $2 }' "
   LET ls_cmd = "ps -efwww | grep --line-buffered azzp953 | grep --line-buffered '",FGL_GETENV("ZONE") CLIPPED,
                        "' | grep -v grep | awk '{print $1 \" \" $2 }' "

   CALL lch_pipe.openPipe(ls_cmd, "r")
   WHILE lch_pipe.read(ls_tmp)
       IF ls_tmp.trim() IS NULL THEN CONTINUE WHILE END IF
       LET ls_tmp2 = ls_tmp
       DISPLAY "PID:",ls_tmp2
       LET ls_id = ls_tmp2.subString(ls_tmp2.getIndexOf(" ",1)+1,ls_tmp2.getLength())
       IF ls_id = ls_self_pid THEN
       ELSE
          LET ls_cmd = "kill ",ls_id
          RUN ls_cmd
       END IF
   END WHILE
   CALL lch_pipe.close()

END FUNCTION

#end add-point
 
{</section>}
 
