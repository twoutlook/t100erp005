#+ 程式版本......: T6 Version 1.00.00 Build-0001 at 14/07/11
#
#+ 程式代碼......: sadzi888_03
#+ 設計人員......: Hiko
# Prog. Version..: 'T6-12.01.21(00000)'     #
#
# Program name   : sadzi888.4gl
# Description    : 匯入設計資料之後該做的事情
# Memo           : 2014/07/21 by madey : 修正bug
#                : 2014/07/24 by madey :1重大錯誤時DISPLAY ERROR固定為BREAK_ERROR
#                :                      2修正bug
#                : 2014/07/28 by madey :sadzi888_03_after_imp()增加參數:p_kind
#                : 2014/07/29 by madey :1.調整未註冊時的錯誤訊息
#                                       2.BREAK_ERROR改放到字串最後
#                : 2014/07/30 by madey :1.記錄log 
#                                       2.過濾簽出中的程式不允許往下執行 (just for patch)
#                : 2014/07/31 by madey :1.記錄log
#                : 2014/08/08 by madey :r.c及r.l錯誤訊息導出
#                : 2014/08/11 by madey :booking檢核先off
#                : 2014/08/19 by madey :summary匯整為一份
#                : 2014/08/21 by madey :依程式清單自動簽出,但只做帳號toptsd簽出的(just for patch)
#                : 2014/08/26 by madey :1.將sadzi444_01_chk_spec_type換成sadzp060_2_chk_spec_type 
#                                       2.4rp搬移拉到編譯/連結後再執行,且增加summary結果
#                : 2014/08/29 by madey :1.增加呼叫sadzi888_05_4rpupd
#                                       2.顯示執行中的筆數
#                : 2014/09/12 by madey :增加頭尾時間統計
#                : 2014/10/13 by madey :summary改放string buffer,並由呼叫端將summary DISPLAY及寫到log
#                : 2015/03/02 by madey :1.當p_kind=6(需求單解包or小型管解包)時,增加呼叫s_azzi900_upd_gzza011因應標準轉客製的情境
#                                       2.X類增加呼叫sadzp188_1()
#                                       3.G類,X類額外要呼叫function,本來是r.c3正確才做,改成不管正確與否都要執行
#                : 2015/03/18 by madey :p_kind不使用了,改抓global變數g_run_mode
#                : 2015/03/25 by madey :增加強制簽入dzlm_t功能，由環境變數TOPCHKOUT決定


import os
import xml

SCHEMA ds

GLOBALS "../../cfg/top_global.inc"
&include "../4gl/adzi888_global.inc"
&include "../4gl/sadzp200_type.inc"
&include "../4gl/sadzp000_type.inc"
&include "../4gl/sadzp200_cnst.inc"

#模組變數
DEFINE g_auto_merge STRING #是否啟動自動merge (Y/N)


#PUBLIC FUNCTION sadzi888_03_after_imp()
PUBLIC FUNCTION sadzi888_03_after_imp(p_kind) #20140728:madey
   DEFINE p_kind LIKE type_t.chr1   #種類 2:一般過單  4:patch過單  (對照adzp999解包參數2/4) 
   DEFINE l_ddata_d type_g_ddata_d, #程式註冊資料匯出單身-設計資料
          l_dfile_d type_g_dfile_d, #程式註冊資料匯出單身-檔案資料
          ls_dfile005 STRING,
          ls_trigger STRING,
          ls_sql STRING,
          lr_ddata RECORD
                   prog CHAR(20),
                   status LIKE type_t.chr1, #執行結果
                   err LIKE type_t.chr50    #錯誤訊息
                   END RECORD,
          li_idx SMALLINT

   DEFINE la_ddata DYNAMIC ARRAY OF RECORD
                   prog CHAR(20),
                   type CHAR(1),
                   module CHAR(5),
                   status LIKE type_t.chr1, #執行結果
                   err LIKE type_t.chr50,   #錯誤訊息
                   cust CHAR(1),            #是否客製    #20150325
                   merge CHAR(1)            #是否要merge #20150325
                   END RECORD

   DEFINE la_rep_list DYNAMIC ARRAY OF RECORD #報表元件清單
                   prog CHAR(20),
                   status LIKE type_t.chr1, #執行結果
                   err LIKE type_t.chr50    #錯誤訊息
                   END RECORD

   DEFINE la_xg_list DYNAMIC ARRAY OF RECORD #Xtragrid元件清單 #20150302
                   prog CHAR(20),
                   status LIKE type_t.chr1, #執行結果
                   err LIKE type_t.chr50    #錯誤訊息
                   END RECORD

   DEFINE ls_prog STRING,
          ls_type STRING,
          ls_module STRING,
          ls_module_uppercase STRING,
          sbuf_msg base.StringBuffer, #收集錯誤訊息,
          lb_result BOOLEAN,
          ls_err_msg STRING,
          ls_str STRING,
          ls_status STRING, #執行結果
          ls_tar_name STRING,
          li_i SMALLINT,
          li_cnt SMALLINT,     #20140821
          li_ins_idx SMALLINT,
          ls_module_dir STRING,
          ls_working_path STRING,
          ls_cmd STRING

   DEFINE lo_DZAF_T T_DZAF_T,
          l_spec_revision LIKE dzaf_t.dzaf003,
          l_code_revision LIKE dzaf_t.dzaf004,
          l_identity LIKE dzaf_t.dzaf010
      
   DEFINE l_booking_flag LIKE type_t.chr1 #是否已簽出
   DEFINE l_dzlm001 LIKE dzlm_t.dzlm001, #20140821
          l_dzlm002 LIKE dzlm_t.dzlm002,
          l_dzlm012 LIKE dzlm_t.dzlm012,
          l_dzlm015 LIKE dzlm_t.dzlm015,
          l_dzlm008 LIKE dzlm_t.dzlm008,
          l_dzlm011 LIKE dzlm_t.dzlm011 
   DEFINE l_dzlm017     LIKE dzlm_t.dzlm017,                                                                    
          l_dzlm008_new LIKE dzlm_t.dzlm008,
          l_dzlm011_new LIKE dzlm_t.dzlm011,
          l_dzlm017_new DATETIME YEAR TO SECOND

  DEFINE ld_local_time DATETIME YEAR TO SECOND
   DEFINE g_properties    om.SaxAttributes, #20140821:用來存放要link哪些模組
          ls_dummy_module         STRING, #模組
          ls_dummy_value          STRING  #是否link
   DEFINE l_time_s                DATETIME YEAR TO SECOND #FRACTION(4)
   DEFINE l_time_e                DATETIME YEAR TO SECOND #FRACTION(4)
   DEFINE sbuf_summary base.StringBuffer  #收集summary #20141013
   DEFINE ls_enable_checkout STRING #是否可簽出 20150325

   TRY
      LET g_auto_merge="Y" #暫時先固定 #20150325

      #寫log
      LET l_time_s = cl_get_current()     #CURRENT YEAR TO FRACTION(4)

      LET sbuf_msg = base.StringBuffer.create()
      LET sbuf_summary = base.StringBuffer.create() #20141013

      
      #取得設計prog清單清單
      LET ls_trigger = "sadzi888_03_after_imp : 取得過單的程式清單"
      LET ls_sql = "SELECT ddata006",
                    " FROM adzi888_ddata",
                   " WHERE ddata003 = 'DesignData'"  #20140717
      PREPARE ddata_prep FROM ls_sql
      DECLARE ddata_curs CURSOR FOR ddata_prep

      
      CALL la_ddata.CLEAR() #init
      CALL la_rep_list.CLEAR() #init
      CALL la_xg_list.CLEAR() #init #20150302
      LET li_idx = 0 
      LET g_properties = om.SaxAttributes.CREATE() #20140821
      CALL g_properties.addAttribute("sub","N")  #確保sub/lib在最前面跑,先給N,如果後面有找到再update為Y
      CALL g_properties.addAttribute("lib","N")
      FOREACH ddata_curs INTO lr_ddata.*
         LET ls_prog = lr_ddata.prog CLIPPED

         LET li_idx = la_ddata.getLength() + 1
         LET la_ddata[li_idx].prog = ls_prog
         LET la_ddata[li_idx].status = "Y"
         LET la_ddata[li_idx].err = NULL
         LET la_ddata[li_idx].cust = "N" #是否客製,預設為N    #20150325
         LET la_ddata[li_idx].merge= "N" #是否要merge,預設為N #20150325
        
         #顯示執行筆數 20140829
         LET ls_trigger = "sadzi888_03_after_imp : ====== part1(gen-prog) =======> count:",li_idx
         DISPLAY ls_trigger
         CALL sadzi888_01_log_file_write(ls_trigger)

         #取得程式類型type
         LET ls_trigger = "sadzi888_03_after_imp : call sadzp060_2_chk_spec_type(",ls_prog,")"
         DISPLAY ls_trigger
         CALL sadzi888_01_log_file_write(ls_trigger) #20140801
        #LET ls_type = sadzi444_01_chk_spec_type(ls_prog)
         LET ls_type = sadzp060_2_chk_spec_type(ls_prog) #20140826
         IF ls_type="N" THEN
            LET ls_err_msg = "ERROR:程式",ls_prog,"找不到類別,請確認是否已經註冊，新程式過單前需先在adzi888輸入(azzi900/azzi901/azzi910)等設定資料",",中斷此程式的匯入過程","\n" #20140729
            CALL sadzi888_01_log_file_write(ls_err_msg) #20140801
            CALL sbuf_msg.append(ls_err_msg)
            LET la_ddata[li_idx].type = "???" 
            LET la_ddata[li_idx].module = "???" 
            LET la_ddata[li_idx].status = "N" 
            LET la_ddata[li_idx].err = "register data error(no type)" 
            CONTINUE FOREACH
         ELSE
            LET la_ddata[li_idx].type = ls_type
         END IF


        ##過濾簽出中的程式不允許往下執行 (just for patch過單) 
        #IF p_kind = "4" THEN 
        #   LET ls_trigger = "sadzi888_03_after_imp : call sadzi888_03_alm_check_data_exist(",ls_prog,",",ls_type,",",ls_module,")"
        #   CALL sadzi888_01_log_file_write(ls_trigger) #20140801
        #   DISPLAY ls_trigger
        #  #IF sadzi888_03_alm_check_item_if_exist(ls_prog,ls_type,ls_module) THEN
        #   CALL sadzi888_03_alm_check_item_if_exist(ls_prog,ls_type,ls_module) RETURNING l_booking_flag ,ls_err_msg
        #   IF l_booking_flag = "Y" THEN
        #      LET ls_err_msg = "ERROR:程式",ls_prog,"目前狀態為簽出中,不允許patch過單:",ls_err_msg,",中斷此程式的匯入過程","\n"
        #      CALL sadzi888_01_log_file_write(ls_err_msg) #20140801
        #      CALL sbuf_msg.append(ls_err_msg)
        #      LET la_ddata[li_idx].status = "S" 
        #      LET la_ddata[li_idx].err = "booking" 
        #      LET li_idx = li_idx + 1 #      CONTINUE FOREACH
        #   END IF
        #END IF
      
         #取得版次相關資料
         LET ls_trigger = "sadzi888_03_after_imp : call sadzp060_2_get_curr_ver_info(",ls_prog,", ",ls_type,", ",ls_module,")"
         DISPLAY ls_trigger
         CALL sadzi888_01_log_file_write(ls_trigger) #20140801
        #CALL sadzp060_2_get_curr_ver_info(ls_prog, ls_type, ls_module) RETURNING lo_DZAF_T.*,ls_err_msg
        #20150302 : ls_module改成傳null就好,因為取版次functoin不會拿這個當作where條件
         CALL sadzp060_2_get_curr_ver_info(ls_prog, ls_type,'') RETURNING lo_DZAF_T.*,ls_err_msg
         IF NOT cl_null(ls_err_msg) THEN
            LET ls_err_msg = "ERROR:程式",ls_prog,"取得版次資料錯誤:",ls_err_msg,",中斷此程式的匯入過程","\n"
            CALL sadzi888_01_log_file_write(ls_err_msg) #20140808
            CALL sbuf_msg.append(ls_err_msg)
            LET la_ddata[li_idx].status = "N" 
            LET la_ddata[li_idx].err = "revision error(dzaf)" 
            CONTINUE FOREACH
         END IF
         DISPLAY "revision:(",lo_DZAF_T.dzaf002,",",lo_DZAF_T.dzaf003,",",lo_DZAF_T.dzaf004,",",lo_DZAF_T.dzaf010,")"
         LET l_spec_revision = lo_DZAF_T.dzaf003 CLIPPED
         LET l_code_revision = lo_DZAF_T.dzaf004 CLIPPED
         LET l_identity = lo_DZAF_T.dzaf010 CLIPPED
 
         #是否已被客製
         IF l_identity="c" THEN
            LET la_ddata[li_idx].cust = "Y" 
         ELSE
            LET la_ddata[li_idx].cust = "N" 
         END IF #20150325

         #是否需要merge
         IF la_ddata[li_idx].cust = "Y"  #已客製
         THEN
            CASE 
               WHEN la_ddata[li_idx].type MATCHES "[BW]" 
                  LET la_ddata[li_idx].merge = "Y"
               WHEN la_ddata[li_idx].type MATCHES "[GX]"
                  LET la_ddata[li_idx].merge = "N"
               WHEN la_ddata[li_idx].type MATCHES "[MZSF]"
                  IF g_auto_merge = "Y" THEN LET la_ddata[li_idx].merge = "Y" ELSE LET la_ddata[li_idx].merge = "N" END IF
               OTHERWISE 
                  LET la_ddata[li_idx].merge = "N"
            END CASE
         ELSE
            LET la_ddata[li_idx].merge = "N"
         END IF

         #20150302 -Begin-
         #強制更新客製註記的狀態
         IF g_run_mode = '6' THEN
            LET ls_trigger = "sadzi888_03_after_imp : call s_azzi900_upd_gzza011(",ls_prog,",",ls_type,",",l_identity,")"
            DISPLAY ls_trigger
            CALL s_azzi900_upd_gzza011(ls_prog, ls_type, l_identity) RETURNING lb_result
            IF NOT lb_result THEN 
               LET ls_err_msg = "ERROR:程式",ls_prog,"更新客製註記錯誤:",",中斷此程式的匯入過程","\n"
               CALL sadzi888_01_log_file_write(ls_err_msg)
               CALL sbuf_msg.append(ls_err_msg)
               LET la_ddata[li_idx].status = "N" 
               LET la_ddata[li_idx].err = "update gzza011 error" 
               CONTINUE FOREACH
            END IF
         END IF
         #20150302 -End-
         
         #取得程式模組module
         #20150302 此步驟順序本來是在取ls_type之後, 取版次之前.
         #         因為增加強制更新客製註記的步驟,所以改成在取ls_type及更新客製註記之後,這樣取到的模組代號才會是準的
         LET ls_trigger = "sadzi888_03_after_imp : call sadzp062_1_find_module(",ls_prog,", ",ls_type,")"
         DISPLAY ls_trigger 
         CALL sadzi888_01_log_file_write(ls_trigger) #20140801
         LET ls_module = sadzp062_1_find_module(ls_prog, ls_type)
         LET ls_module = ls_module.toLowerCase()
         IF cl_null(ls_module) THEN
            LET ls_err_msg = "ERROR:程式",ls_prog,"找不到模組,請確認是否已經註冊，新程式過單前需先在adzi888輸入(azzi900/azzi901/azzi910)等設定資料",",中斷此程式的匯入過程","\n" #20140729
            CALL sadzi888_01_log_file_write(ls_err_msg) #20140801
            CALL sbuf_msg.append(ls_err_msg)
            LET la_ddata[li_idx].module = "???"
            LET la_ddata[li_idx].status = "N" 
            LET la_ddata[li_idx].err = "register data error(module)" 
            CONTINUE FOREACH
         ELSE
            LET la_ddata[li_idx].module = ls_module
         END IF

         #G類要解包GR報表的4rp,先keep清單,後面再處理
         IF ls_type="G" THEN 
            LET li_i = la_rep_list.getLength() + 1
            LET la_rep_list[li_i].prog = ls_prog 
            LET la_rep_list[li_i].status = "Y"
            LET la_rep_list[li_i].err = NULL
         END IF

         #X類要多做事,先keep清單,後面再處理
         IF ls_type="X" THEN 
            LET li_i = la_xg_list.getLength() + 1
            LET la_xg_list[li_i].prog = ls_prog 
            LET la_xg_list[li_i].status = "Y"
            LET la_xg_list[li_i].err = NULL
         END IF
      
         #M,S,F要重產4fd,先不編譯,最後才一起做
         IF ls_type="M" OR ls_type="S" OR ls_type="F" THEN 
            LET ls_trigger = "sadzi888_03_after_imp : call sadzp168_5(",ls_prog,",",l_spec_revision,",",l_identity,",TRUE)"
            DISPLAY ls_trigger
            CALL sadzi888_01_log_file_write(ls_trigger) #20140801
            CALL sadzp168_5(ls_prog, l_spec_revision, l_identity, TRUE) RETURNING lb_result,ls_err_msg
            IF NOT lb_result THEN 
               LET ls_err_msg = "ERROR:程式",ls_prog,"重產4fd失敗",ls_err_msg,",中斷此程式的匯入過程","\n"
               CALL sadzi888_01_log_file_write(ls_err_msg) #20140801
               CALL sbuf_msg.append(ls_err_msg)
               LET la_ddata[li_idx].status = "N" 
               LET la_ddata[li_idx].err = "genrate/compile 4fd error"  
               CONTINUE FOREACH
            END IF
         END IF

      
         #程式重產
         IF ls_type="G" OR ls_type="X" THEN #報表元件設計資料的版次是屬於"程式"
            LET ls_trigger = "sadzi888_03_after_imp : call sadzp030_tab_gen(",ls_prog,",",l_code_revision,",'',",l_identity,")"
            DISPLAY ls_trigger
            CALL sadzi888_01_log_file_write(ls_trigger) #20140801
            CALL sadzp030_tab_gen(ls_prog, l_code_revision, "", l_identity) RETURNING lb_result
         ELSE
            LET ls_trigger = "sadzi888_03_after_imp : call sadzp030_tab_gen(",ls_prog,",",l_spec_revision,",'',",l_identity,")"
            DISPLAY ls_trigger
            CALL sadzi888_01_log_file_write(ls_trigger) #20140801
            CALL sadzp030_tab_gen(ls_prog, l_spec_revision, "", l_identity) RETURNING lb_result
         END IF
         IF NOT lb_result THEN 
            LET ls_err_msg = "ERROR:程式",ls_prog,"產生tab檔出現錯誤,請查看背景執行過程",",中斷此程式的匯入過程","\n"
            CALL sadzi888_01_log_file_write(ls_err_msg) #20140801
            CALL sbuf_msg.append(ls_err_msg)
            LET la_ddata[li_idx].status = "N" 
            LET la_ddata[li_idx].err = "tab gen error" 
            CONTINUE FOREACH
         END IF
         
         #第四個參數為 1 表示不做編譯以下的事情
         LET ls_cmd = "r.c3 ",ls_prog," ","''"," ",l_code_revision," ","1"," ",l_identity
         LET ls_trigger = "sadzi888_03_after_imp : ",ls_cmd
         DISPLAY ls_trigger
         CALL sadzi888_01_log_file_write(ls_trigger) #20140801
         CALL cl_cmdrun_openpipe("r.c3", ls_cmd, FALSE) RETURNING lb_result,ls_err_msg
         IF NOT lb_result THEN
            LET ls_err_msg = "ERROR:程式",ls_prog,"在r.c3過程出現錯誤:",ls_err_msg,",中斷此程式的匯入過程","\n"
            CALL sadzi888_01_log_file_write(ls_err_msg) #20140801 
            CALL sbuf_msg.append(ls_err_msg)
            LET la_ddata[li_idx].status = "N" 
            LET la_ddata[li_idx].err = "r.c3 error" 
            CONTINUE FOREACH
         END IF 


      END FOREACH #程式代號


      #執行所有程式的編譯
      FOR li_i=1 TO la_ddata.getLength()
         #顯示執行筆數 20140829
         LET ls_trigger = "sadzi888_03_after_imp : ====== part2(compile-prog) =======> count:",li_i
         DISPLAY ls_trigger
         CALL sadzi888_01_log_file_write(ls_trigger)

         IF  la_ddata[li_i].status <> "Y" THEN CONTINUE FOR END IF  #匯入過程沒有錯誤的程式才會繼續編譯

         LET ls_prog = la_ddata[li_i].prog CLIPPED
         LET ls_module = la_ddata[li_i].module
         LET ls_module_uppercase = ls_module.toUpperCase()
         LET ls_module_dir = FGL_GETENV(ls_module_uppercase CLIPPED)
         LET ls_type =la_ddata[li_i].type CLIPPED  

      
        ##M,S,F要做4fd編譯
        #IF ls_type="M" OR ls_type="S" OR ls_type="F" THEN 
        #   LET ls_working_path = os.Path.join(ls_module_dir,"4fd")
        #   LET ls_trigger = "sadzi888_03_after_imp : change dir to ",ls_working_path
        #   DISPLAY ls_trigger
        #   IF cl_change_dir(ls_working_path) THEN
        #      LET ls_cmd = "r.f ",ls_prog
        #      LET ls_trigger = "sadzi888_03_after_imp : ",ls_cmd
        #      DISPLAY ls_trigger
        #      CALL cl_cmdrun_openpipe("r.f", ls_cmd, FALSE) RETURNING lb_result,ls_err_msg
        #      IF NOT lb_result THEN
        #         LET ls_err_msg = ls_err_msg,"\n","中斷此程式的編譯過程","\n"
        #         CALL sbuf_msg.append(ls_err_msg)
        #         CONTINUE FOR
        #      END IF
        #   ELSE
        #      LET ls_err_msg = "ERROR:程式",ls_prog,"切換路徑",ls_working_path,"出現錯誤,請查看背景執行過程","\n","中斷此程式的編譯過程","\n"
        #      CALL sbuf_msg.append(ls_err_msg)
        #      CONTINUE FOR
        #   END IF
        #END IF
      
         IF ls_type = "F" THEN  #20140724:madey :子畫面不用編譯及連結
         ELSE
            #程式編譯
            LET ls_working_path = os.Path.join(ls_module_dir,"4gl")
            LET ls_trigger = "sadzi888_03_after_imp : change dir to ",ls_working_path
            DISPLAY ls_trigger
            IF cl_change_dir(ls_working_path) THEN
               IF ls_type="G" THEN
                  #GP報表還要重產rdd
                  LET ls_cmd = "r.c ",ls_prog," rdd"
               ELSE
                  LET ls_cmd = "r.c ",ls_prog
               END IF
               LET ls_trigger = "sadzi888_03_after_imp : ",ls_cmd
               DISPLAY ls_trigger
               CALL sadzi888_01_log_file_write(ls_trigger) 
               CALL cl_cmdrun_openpipe("r.c", ls_cmd, FALSE) RETURNING lb_result,ls_err_msg
               IF NOT lb_result THEN
                  LET ls_err_msg = "ERROR:程式",ls_prog,"在r.c出現錯誤",ls_err_msg,",中斷此程式的編譯過程","\n"
                  CALL sadzi888_01_log_file_write(ls_err_msg) 
                  CALL sbuf_msg.append(ls_err_msg)
                  LET la_ddata[li_i].status =  "N"          
                  LET la_ddata[li_i].err =  "compile error" 
                  CONTINUE FOR
               ELSE
                  #20140821:編譯成功
                  IF ls_type MATCHES "[SGXWB]" THEN #子程式/報表元件/應用元件/服務元件時,須要r.l該模組
                     LET ls_dummy_value = NULL
                     LET ls_dummy_value = g_properties.getValue(la_ddata[li_i].module CLIPPED) CLIPPED
                     IF cl_null(ls_dummy_value) OR ls_dummy_value = "N"  THEN
                        CALL g_properties.addAttribute(la_ddata[li_i].module CLIPPED,"Y")
                     END IF
                  END IF
               END IF
            ELSE
               LET ls_err_msg = "ERROR:程式",ls_prog,"切換路徑",ls_working_path,"出現錯誤,請查看背景執行過程","\n","中斷此程式的編譯過程","\n"
               CALL sadzi888_01_log_file_write(ls_err_msg) 
               CALL sbuf_msg.append(ls_err_msg)
               LET la_ddata[li_i].status =  "N"             
               LET la_ddata[li_i].err =  "change dir error" 
               CONTINUE FOR
            END IF
         END IF 
      END FOR
     
      #20140821 子程式/報表元件/應用元件/服務元件時,須要r.l該模組
      FOR li_i=1 TO g_properties.getLength()
         #看有哪些模組
         LET ls_dummy_value = NULL
         LET ls_dummy_module = NULL
         LET ls_dummy_value = g_properties.getValue(li_i) CLIPPED 
         LET ls_dummy_module = g_properties.getName(li_i) CLIPPED 
         IF NOT cl_null(ls_dummy_module) AND ls_dummy_value = "Y" THEN
            LET ls_cmd = "r.l ",ls_dummy_module
            LET ls_trigger = "sadzi888_03_after_imp : ",ls_cmd
            DISPLAY ls_trigger
            CALL sadzi888_01_log_file_write(ls_trigger) 
            CALL la_ddata.insertElement(1)
            LET la_ddata[1].prog = ls_cmd
            LET la_ddata[1].type = " "
            LET la_ddata[1].module = ls_dummy_module
            LET la_ddata[1].status = "Y"
            CALL cl_cmdrun_openpipe("r.l", ls_cmd, FALSE) RETURNING lb_result,ls_err_msg
            IF NOT lb_result THEN
               LET la_ddata[1].status = "N"
               LET la_ddata[1].err = ls_cmd || " " || "error"
               LET ls_err_msg = "ERROR:在",ls_cmd,"出現錯誤",ls_err_msg,"\n"
               CALL sadzi888_01_log_file_write(ls_err_msg) 
               CALL sbuf_msg.append(ls_err_msg)
               #要改成強制離開
            END IF
         END IF
      END FOR
      

      #執行所有程式的link
      FOR li_i=1 TO la_ddata.getLength()
         #顯示執行筆數 20140829
         LET ls_trigger = "sadzi888_03_after_imp : ====== part3(link-prog) =======> count:",li_i
         DISPLAY ls_trigger
         CALL sadzi888_01_log_file_write(ls_trigger)

         IF  la_ddata[li_i].status <> "Y" THEN CONTINUE FOR END IF  #編譯失敗不需要link

         LET ls_prog = la_ddata[li_i].prog CLIPPED
         LET ls_type =la_ddata[li_i].type CLIPPED  
         IF ls_type MATCHES "[MZ]" THEN  #只有主程式需要真正link #20140821
            #程式Link
            LET ls_cmd = "r.l ",ls_prog
            LET ls_trigger = "sadzi888_03_after_imp : ",ls_cmd
            DISPLAY ls_trigger
            CALL sadzi888_01_log_file_write(ls_trigger) 
            CALL cl_cmdrun_openpipe("r.l", ls_cmd, FALSE) RETURNING lb_result,ls_err_msg
            IF NOT lb_result THEN
               LET ls_err_msg = "ERROR:程式",ls_prog,"在r.l出現錯誤",ls_err_msg,",中斷此程式的link過程","\n"
               CALL sadzi888_01_log_file_write(ls_err_msg) 
               CALL sbuf_msg.append(ls_err_msg)
               LET la_ddata[li_i].status =  "N"       
               LET la_ddata[li_i].err =  "link error" 
               CONTINUE FOR
            END IF
         END IF 
      END FOR

      #================寫 summary log ==================== 
      IF la_ddata.getLength() > 0 THEN #有資料才寫
         LET ls_str = ASCII 10 ,"summary:",ASCII 10
 #       DISPLAY ls_str
 #       CALL sadzi888_01_log_file_write(ls_str)
         CALL sbuf_summary.APPEND(ls_str) #20141013
         LET ls_str = "=====",2 SPACE ,"====================",2 SPACE ,"====", 2 SPACE , "=========================" ,ASCII 10 
 #       DISPLAY ls_str
 #       CALL sadzi888_01_log_file_write(ls_str)
         CALL sbuf_summary.APPEND(ls_str) #20141013
         FOR li_i = 1 TO la_ddata.getLength()
            CASE la_ddata[li_i].status
               WHEN "Y"   LET ls_status = "ok  "
               WHEN "N"   LET ls_status = "fail"
               WHEN "S"   LET ls_status = "skip"
               OTHERWISE  LET ls_status = "????"
            END CASE
            LET ls_str = la_ddata[li_i].module , 2 SPACE ,la_ddata[li_i].prog , 2 SPACE , ls_status , 2 SPACE , la_ddata[li_i].err ,ASCII 10 
 #          DISPLAY ls_str
 #          CALL sadzi888_01_log_file_write(ls_str)
            CALL sbuf_summary.APPEND(ls_str) #20141013
         END FOR
         LET ls_str = "=====",2 SPACE ,"====================",2 SPACE ,"====", 2 SPACE , "=========================",ASCII 10 
 #       DISPLAY ls_str
 #       CALL sadzi888_01_log_file_write(ls_str)
         CALL sbuf_summary.APPEND(ls_str) #20141013
       END IF


      #20140821 強制簽入  -begin-
      #抓系統參數
      CALL FGL_GETENV("TOPCHKOUT") RETURNING ls_enable_checkout
      IF cl_null(ls_enable_checkout) THEN 
         LET ls_enable_checkout = "N"
      END IF
      IF ls_enable_checkout = "Y" AND la_ddata.getLength() > 0 THEN 
     #IF g_run_mode = "4" AND la_ddata.getLength() > 0 THEN 
         LET ls_trigger = ASCII 10,"將已簽出程式強制簽入:",ASCII 10 
         DISPLAY ls_trigger
         CALL sbuf_summary.APPEND(ls_trigger) #20141013
         LET ls_str = "=====",2 SPACE ,"====================",2 SPACE ,"====", 2 SPACE , "=========================",ASCII 10 
         DISPLAY ls_str
         CALL sbuf_summary.APPEND(ls_str) #20141013

         LET ls_sql = "SELECT COUNT(1) FROM dzlm_t",
                      " WHERE dzlm002 = ?",
                      "   AND (dzlm008 ='",cs_check_out,"' OR dzlm011='",cs_check_out,"')"
         PREPARE dzlm_prep_cnt FROM ls_sql
         
         LET ls_sql = "SELECT dzlm008,dzlm011,dzlm012,dzlm015,dzlm017 FROM dzlm_t",
                      " WHERE dzlm002 = ?",
                      "   AND (dzlm008 ='",cs_check_out,"' OR dzlm011='",cs_check_out,"')"
         PREPARE dzlm_prep FROM ls_sql
         
         LET ls_sql = " DELETE FROM dzlm_t",
                      " WHERE dzlm002 = ?"
         PREPARE dzlm_del FROM ls_sql
         
         LET ls_sql = " UPDATE dzlm_t",
                      "    SET dzlm008=? ,",
                      "        dzlm011=? ,",
                      "        dzlm017=?  ",
                      " WHERE dzlm002 = ?",
                      "   AND (dzlm008 ='",cs_check_out,"' OR dzlm011='",cs_check_out,"')",
                      "   AND dzlm012 = ?",
                      "   AND dzlm015 = ?"
         PREPARE dzlm_upd FROM ls_sql
         
         LET li_idx = 0
         FOR li_i=1 TO la_ddata.getLength()
            LET l_dzlm002 = la_ddata[li_i].prog CLIPPED
            LET li_cnt=0
            EXECUTE dzlm_prep_cnt INTO li_cnt USING l_dzlm002
            IF li_cnt >0 THEN 
               LET ls_err_msg = NULL
               LET ls_status="ok  "
               IF li_cnt > 1 THEN
                  LET ls_err_msg = 'ERROR:簽出資訊筆數有問題，請查明:',l_dzlm002,ASCII 10
                  LET ls_status="fail"
               ELSE
                  CASE 
                     WHEN (la_ddata[li_i].cust <> 'Y')  #20141208 add
                        #優先:若程式尚未被客製過,此時簽出的只會是topstd, dzlm強制清空最乾淨
                        EXECUTE dzlm_del USING l_dzlm002
         
                     OTHERWISE
                        EXECUTE dzlm_prep INTO l_dzlm008,l_dzlm011,l_dzlm012,l_dzlm015,l_dzlm017 USING l_dzlm002
                        #若是其他帳號簽出的，表示是標準轉客製:
                        #   1.如果已啟動auto merge: 將dzlm記錄維護為簽入狀態
                        #   2.如果未啟動auto merge: 再判斷該支程式是否必須merge,是的話再將dzlm記錄維護為簽入狀態 
                        IF g_auto_merge = "Y" OR (g_auto_merge <> "Y" AND la_ddata[li_i].merge="Y") THEN
                           LET l_dzlm008_new = IIF(l_dzlm008 = cs_check_out,cs_check_in,l_dzlm008)
                           LET l_dzlm011_new = IIF(l_dzlm011 = cs_check_out,cs_check_in,l_dzlm011) 
                           IF (l_dzlm008_new =  cs_check_in AND l_dzlm011_new =  cs_check_in ) OR
                              (l_dzlm008_new =  cs_check_in AND cl_null(l_dzlm011_new))        OR
                              (cl_null(l_dzlm008_new)       AND l_dzlm011_new =  cs_check_in )
                           THEN
                              LET l_dzlm017_new =  ld_local_time
                           ELSE
                              LET l_dzlm017_new =  l_dzlm017
                           END IF
                           EXECUTE dzlm_upd USING l_dzlm008_new,l_dzlm011_new,l_dzlm017_new,
                                                  l_dzlm002,l_dzlm012,l_dzlm015
                        ELSE
                           #不做事
                        END IF
                  END CASE
                  IF SQLCA.sqlcode THEN
                     LET ls_err_msg = 'ERROR:簽入失敗,SQLCA.sqlcoder=',l_dzlm002, " ",SQLCA.sqlcode,ASCII 10
                     LET ls_status="fail"
                  END IF
               END IF
               LET ls_str = la_ddata[li_i].module , 2 SPACE ,la_ddata[li_i].prog , 2 SPACE , ls_status , 2 SPACE , ls_err_msg,ASCII 10 
               DISPLAY ls_str 
               CALL sbuf_summary.APPEND(ls_str) #20141013
            END IF
         END FOR
         LET ls_str = "=====",2 SPACE ,"====================",2 SPACE ,"====", 2 SPACE , "=========================",ASCII 10
         CALL sbuf_summary.APPEND(ls_str) #20141013
      END IF
      #20140821 強制簽入  -end-

      #G類要解包GR報表的4rp
      #取得報表4rp tar檔所在路徑 ,檔名目前為 prog-日期.tar
      #注意:temp table 用like + USING似乎有問題,改用for each先讀再過濾
      FOR li_i = 1 TO la_rep_list.getLength() 
         LET ls_prog = la_rep_list[li_i].prog CLIPPED
         LET ls_sql = "SELECT dfile003, dfile005",
                       " FROM adzi888_dfile",
                      " WHERE dfile004 = 'f'",
                      "   AND dfile005 LIKE '",ls_prog,"%.tar'"
         PREPARE dfile_prep FROM ls_sql
         DECLARE dfile_curs CURSOR FOR dfile_prep
         #由TEMP TABLE(dfile)取得tar檔路徑及名稱
         FOREACH dfile_curs INTO l_dfile_d.dfile003 ,l_dfile_d.dfile005
            LET ls_dfile005 = l_dfile_d.dfile005
            IF ls_dfile005.getIndexOf(ls_prog,1) > 0 AND 
               (ls_dfile005.getIndexOf(".tar",1) >0  OR ls_dfile005.getIndexOf(".TAR",1) > 0)
            THEN
              #解包GR報表的4rp
               LET ls_tar_name = os.path.JOIN(l_dfile_d.dfile003,l_dfile_d.dfile005)
               LET ls_trigger= "sadzi888_03_after_imp : call sadzp188_rep_unpack(",ls_prog,",",ls_tar_name,")"
               DISPLAY ls_trigger
               CALL sadzi888_01_log_file_write(ls_trigger) #20140801
               CALL sadzp188_rep_unpack(ls_prog, ls_tar_name) RETURNING lb_result,ls_err_msg
               IF NOT lb_result THEN 
                  LET la_rep_list[li_i].status = "N"
                  LET la_rep_list[li_i].err = "rep unpack error"
                  LET ls_err_msg = "ERROR:程式",ls_prog,"的4rp解包過程出現錯誤:",ls_err_msg,ASCII 10
                  CALL sadzi888_01_log_file_write(ls_err_msg) #20140801
                  CALL sbuf_msg.append(ls_err_msg)
               END IF
               EXIT FOREACH #找到一個就離開
            END IF
         END FOREACH 
         FREE dfile_prep
           
         #20140829:增加呼叫sadzi888_05_4rpupd (若客製紙張大小,則同步異動4rp)
         IF la_rep_list[li_i].status = "Y" THEN
            LET ls_trigger= "sadzi888_03_after_imp : call sadzi888_05_4rpupd(",ls_prog,")"
            DISPLAY ls_trigger
            CALL sadzi888_01_log_file_write(ls_trigger) 
            CALL sadzi888_05_4rpupd(ls_prog) RETURNING lb_result,ls_err_msg
            IF NOT lb_result THEN 
               LET la_rep_list[li_i].status = "N"
               LET la_rep_list[li_i].err = "4rp update errror"
               LET ls_err_msg = "ERROR:程式",ls_prog,"的4rp更新過程出現錯誤:",ls_err_msg,ASCII 10 
               CALL sadzi888_01_log_file_write(ls_err_msg)
               CALL sbuf_msg.append(ls_err_msg)
            END IF
          END IF

      END FOR

      #================寫 4rp log ==================== 
      IF la_rep_list.getLength() > 0 THEN #有資料才寫
         LET ls_str = ASCII 10 ,"4rp:",ASCII 10 
 #       DISPLAY ls_str
 #       CALL sadzi888_01_log_file_write(ls_str)
         CALL sbuf_summary.APPEND(ls_str) #20141013
         LET ls_str = "====================",2 SPACE ,"====", 2 SPACE , "=========================",ASCII 10 
 #       DISPLAY ls_str
 #       CALL sadzi888_01_log_file_write(ls_str)
         CALL sbuf_summary.APPEND(ls_str) #20141013
         FOR li_i = 1 TO la_rep_list.getLength()
            CASE la_rep_list[li_i].status
               WHEN "Y"   LET ls_status = "ok  "
               WHEN "N"   LET ls_status = "fail"
               WHEN "S"   LET ls_status = "skip"
               OTHERWISE  LET ls_status = "????"
            END CASE
            LET ls_str = la_rep_list[li_i].prog , 2 SPACE , ls_status , 2 SPACE , la_rep_list[li_i].err ,ASCII 10 
 #          DISPLAY ls_str
 #          CALL sadzi888_01_log_file_write(ls_str)
            CALL sbuf_summary.APPEND(ls_str) #20141013
         END FOR
         LET ls_str = "====================",2 SPACE ,"====", 2 SPACE , "=========================",ASCII 10
 #       DISPLAY ls_str
 #       CALL sadzi888_01_log_file_write(ls_str)
         CALL sbuf_summary.APPEND(ls_str) #20141013
      END IF

      #20150302 -Begin-
      #X類:Xtragrid
      FOR li_i = 1 TO la_xg_list.getLength() 
         LET ls_prog = la_xg_list[li_i].prog CLIPPED
         LET ls_trigger= "sadzi888_03_after_imp : call sadzp188_1(",ls_prog,")"
         DISPLAY ls_trigger
         CALL sadzi888_01_log_file_write(ls_trigger)
         CALL sadzp188_1(ls_prog) RETURNING lb_result,ls_err_msg  	
         IF NOT lb_result THEN 
            LET la_xg_list[li_i].status = "N"
            LET la_xg_list[li_i].err = "xg error"
            LET ls_err_msg = "ERROR:程式",ls_prog,"呼叫sadzp188_1過程出現錯誤:",ls_err_msg,ASCII 10
            CALL sadzi888_01_log_file_write(ls_err_msg)
            CALL sbuf_msg.append(ls_err_msg)
         END IF
      END FOR

      #================寫 xg log ==================== 
      IF la_xg_list.getLength() > 0 THEN #有資料才寫
         LET ls_str = ASCII 10 ,"XtraGrid處理結果:",ASCII 10 
         CALL sbuf_summary.APPEND(ls_str) 
         LET ls_str = "====================",2 SPACE ,"====", 2 SPACE , "=========================",ASCII 10 
         CALL sbuf_summary.APPEND(ls_str)
         FOR li_i = 1 TO la_xg_list.getLength()
            CASE la_xg_list[li_i].status
               WHEN "Y"   LET ls_status = "ok  "
               WHEN "N"   LET ls_status = "fail"
               WHEN "S"   LET ls_status = "skip"
               OTHERWISE  LET ls_status = "????"
            END CASE
            LET ls_str = la_xg_list[li_i].prog , 2 SPACE , ls_status , 2 SPACE , la_xg_list[li_i].err ,ASCII 10 
            CALL sbuf_summary.APPEND(ls_str) 
         END FOR
         LET ls_str = "====================",2 SPACE ,"====", 2 SPACE , "=========================",ASCII 10
         CALL sbuf_summary.APPEND(ls_str) 
      END IF
      #20150302 -End-

      LET ls_str = "-> sadzi888_03_after_imp -Begin-",l_time_s #20140912
      DISPLAY ls_str
      CALL sadzi888_01_log_file_write(ls_str)

      LET l_time_e = cl_get_current()     #CURRENT YEAR TO FRACTION(4)
      LET ls_str = "-> sadzi888_03_after_imp -End  -",l_time_e,
                   ASCII 10 , "-> sadzi888_03_after_imp -Total time used:",l_time_e - l_time_s
      DISPLAY ls_str
      CALL sadzi888_01_log_file_write(ls_str)
          
      IF sbuf_msg.getLength()>0 THEN #表示有錯誤
        #CALL sbuf_msg.insertAt(1, "BREAK_ERROR:") #20140724:madey
         CALL sbuf_msg.APPEND("\n BREAK_ERROR") #20140724:madey
 #       DISPLAY "sadzi888_03_after_imp : ",sbuf_msg.toString()
 #       RETURN FALSE,sbuf_msg.toString()
         RETURN FALSE,sbuf_summary.toString() || "\n"  || sbuf_msg.toString() #20141013
      END IF

     #RETURN TRUE,NULL
      RETURN TRUE,sbuf_summary.toString() #20141013
   CATCH 
      #寫log
      LET ls_str = "-> sadzi888_03_after_imp - Catch exception-",ls_trigger , ASCII 10
      CALL sadzi888_01_log_file_write(ls_str)

      CALL sadzi888_03_err_catch(ls_trigger, ls_sql) 
     #LET ls_err_msg = "ERROR:",ls_trigger
     #LET ls_err_msg = "BREAK_ERROR:",ls_trigger #20140724:madey
      LET ls_err_msg = ls_trigger, "\n BREAK_ERROR"  #20140729:madey
      RETURN FALSE,ls_err_msg
   END TRY
END FUNCTION

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 擷取錯誤訊息.
# Input parameter : p_trigger 執行的顯現資訊
#                   p_sql 執行的SQL
# Return code     : void
# Date & Author   : 2014/07/11 by Hiko
##########################################################################
PRIVATE FUNCTION sadzi888_03_err_catch(p_trigger, p_sql)
   DEFINE p_trigger STRING,
          p_sql STRING

   DISPLAY "ERROR : ls_trigger=",p_trigger
   DISPLAY "STATUS=",STATUS
   DISPLAY "SQLCA.SQLCODE=",SQLCA.SQLCODE
   DISPLAY "ls_sql=",p_sql,"<<"
END FUNCTION


##########################################################################
# Access Modifier : PPBLIC
# Descriptions    : 檢查程式是否目前為簽出中
# Input parameter : p_prog 
#                   p_type   (給NULL時自動判斷)
#                   p_module (給NULL時自斷判斷)
# Return code     : flag     :Y 存在已簽出資料
#                             N 不存在已簽出資料
#                             E 檢查過程中出錯
#                   msg      :當參數1為E時有值
# Date & Author   : 2014/07/30 by mdey
##########################################################################
PUBLIC FUNCTION sadzi888_03_alm_check_item_if_exist(p_prog,p_type,p_module)
   DEFINE p_prog   STRING,
          p_type   STRING,
          p_module STRING

   DEFINE r_err_msg STRING

   DEFINE l_prog_info T_PROGRAM_INFO,
          lb_result BOOLEAN
  
 
   #p_type為null時自動判斷
   IF cl_null(p_type) THEN 
     #LET p_type = sadzi444_01_chk_spec_type(p_prog)
      LET p_type = sadzp060_2_chk_spec_type(p_prog) #20140826
      IF p_type="N" THEN
         LET r_err_msg = "ERROR:程式",p_prog,"找不到類別,請確認是否已經註冊"
         RETURN "E",r_err_msg
      END IF
   END IF

   #p_module為null時自動判斷
   IF cl_null(p_module) THEN 
      LET p_module = sadzp062_1_find_module(p_prog, p_type)
      IF cl_null(p_module) THEN
         LET r_err_msg = "ERROR:程式",p_prog,"找不到模組,請確認是否已經註冊"
         RETURN "E",r_err_msg
      END IF
   END IF

   #呼叫function判斷是否已簽出
   LET l_prog_info.pi_NAME   = p_prog
   LET l_prog_info.pi_MODULE = p_module
   LET l_prog_info.pi_TYPE   = p_type
   IF sadzp200_alm_check_item_if_exist(l_prog_info.* ,"ALL") THEN
      RETURN "Y",NULL
   ELSE
      RETURN "N",NULL
   END IF
   

   RETURN lb_result
END FUNCTION

