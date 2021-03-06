#+ 程式版本......: T6 Version 1.00.00 Build-0001 at 12/12/21
#
#+ 程式代碼......: adzp988
#+ 設計人員......: madey
# Prog. Version..: 'T6-12.01.21(00000)'     #
#
# Program name   : adzp988.4gl 
# Description    : 由設計資料產生程式並編譯連結工具
# Memo           : 若以FGLRUN方式執行時,參數1請給null(dummp),若以r.r或r.d方式執行,參數1給正常值
#                  2014/09/16 by madey :將組合程式及編譯程式拆開
#                  2014/10/16 by madey :bub fix
#                  2014/10/24 by madey :1.增加merge功能
#                                       2.改變程式架構
#                  2014/12/09 by madey :1.增加寫入merge記錄sadzi888_07_ins_dzap_t()
#                                       2.dzyd018 errmsg 長度放到至4000,並改用累積訊息                                      
#                  2014/12/17 by madey :merge後應該要重新取得版次，因為merge過程會自動進版
#                  2015/03/25 by madey :客製程式在gen之前預先編譯，如果失敗了就不往下做
#                  2015/03/26 by madey :g_run_mode=6(需求單解包or小型管解包)時,增加呼叫s_azzi900_upd_gzza011因應標準轉客製的情境
#                  2015/03/30 by madey :預先編譯、merge動作只有在g_run_mode=4(patch解包)才要做
#                  2015/05/12 by madey :調整各階段寫入dzyd_t的時機點(提早)
#                  2015/05/18 by madey :透過g_gen42s_flag控制是否要執行多語言產生
#                  2015/05/20 by madey :1.增加dzye_t,取代dzyd_t
#                                       2.gen階段增加重產tsd,tap檔
#                  2015/06/26 by madey :當g_run_mode=4時,g_patch_mode為TRUE
#                  2015/07/08 by madey :1.merge=N時，仍然要寫入dzap_t,這樣adzp050的手動merge功能才能開啟
#                                       2.merge=Y時，不用重產4fd/tab/4gl,因為在merge功能有做過了
#                                       3.pid應該是每一階段都取得/更新一次才會是準的
#                  2015/07/15 by madey :mark:重產tsd,tap檔 (效能)
#                  2015/07/24 by madey :呼叫s_azzi900_upd_gzza011()的條件調整
#                  2015/10/14 by madey :編譯4gl不用r.c改用gen42m,避開一般程式規則檢查(src_standard)for客製檢查
#                  2015/10/20 by madey :gen42m帶參數tiptop(與rebuild一樣),可跳掉一些非必要項目以加快速度
#                  2015/11/23 by madey :調整畫面多語言產生時機點(解決過單或匯出入時,因為同時在產多語言及作r.c3, 讓多語言產生異常
#                  2015/12/20 by madey :調整設計資料匯入功能,卡控放行以下條件:c to s 及 目標版次>來源版次
#                  20160223 160223-00028 by madey :patch優化專案
#                                        1.將qry產生納入機制
#                                        2.42x的結果要記錄成功與否
#                                        3.將merge行為由gen階段拉出來為一個獨立階段
#                                        4.調整畫面多語言產生時機點(解決過單或匯出入時,因為同時在產多語言及作r.c3,讓多語言產生異常
#                                        5.透過adzi800過單時,處理gzzn_t有2筆的情況
#                  20160510 160510-00003 by madey :修正bug在重產hardcode qry時沒抓到版次
#                  20160517 160517-00008 by madey :訊息補強:qry報錯時,完整錯誤訊息寫入dzye018
#                  20160706 160706-00022 by madey :在gen_prog階段讓F類(子畫面)不須呼叫gen_tab及r.c3
#                  20160707 160620-00020 by madey :為了增加串diff工具,patch模式遇到客製程式仍要copy靜態檔到標準目錄
#                  20160726 160726-00031 by madey :切換目錄由cl_change_dir()改用os.Path.chdir()
#                  20161011 161011-00036 by madey :1.調整link 42x的規則:有客製模組時連同標準模組也做
#                                                  2.客戶過單模式下: 是否強制更新客製註記的規則調整
#                  20161115 161103-00029 by madey :1.merge前的預編譯失敗改成繼續merge
#                  20161201 161130-00069 by madey :patch模式下，標準程式若有被topstd修改過，則要重產,不copy
#                  20170208 170208-00008 by madey :for追單工具:
#                                                  1.patch模式下，copy 4gl增加複製一份.4gl.src檔
#                                                  2.patch模式下，標準程式若有被topstd修改過，則要重產，copy照做(這樣規則比較簡單一致)
#                  20170303 170303-00039 by madey :patch模式下:解小包patch時程式強制重產


IMPORT os
IMPORT security
IMPORT XML

SCHEMA ds

GLOBALS "../../cfg/top_global.inc"
&include "../4gl/sadzp200_type.inc"
&include "../4gl/sadzp000_type.inc"
&include "../4gl/sadzi888_06_type.inc"
&include "../4gl/adzi888_global.inc"

DEFINE lf_prog   CHAR(20),
       lf_module CHAR(5),
       lf_status CHAR(5),
       lf_err    CHAR(50) 

DEFINE lr_dzye_t      type_g_dzye_d,
       lr_redo        T_REDO

DEFINE g_tar_name     STRING,
       g_auto_merge   STRING #是否已啟動auto merge機制

DEFINE lb_dzye_have_data   BOOLEAN
DEFINE lb_main_gen42s_flag BOOLEAN #20151123

MAIN
   
   DEFINE ls_err_msg      STRING,
          lb_result       BOOLEAN
   DEFINE ls_prog         STRING,
          ls_part         STRING
   DEFINE l_time_s        DATETIME YEAR TO SECOND,
          l_time_e        DATETIME YEAR TO SECOND,
          l_time_r        INTERVAL DAY  TO SECOND
        

  ##依模組進行系統初始化設定(系統設定)
   CALL cl_tool_init()   

   #記錄開始時間 #20151020
   LET l_time_s=cl_get_current() 
   DISPLAY "Strat time : ",l_time_s

   #切換至使用者所需要的資料庫 (營運中心)  #todo
  #DISCONNECT CURRENT #todo
  #CONNECT TO "ds" #todo
  #DISPLAY 'connect:ds->', STATUS

   #讀取參數
   LET g_tar_name = ARG_VAL(2)
   DISPLAY 'ARG_VAL(2)=',g_tar_name
   LET ls_prog = ARG_VAL(3) 
   DISPLAY 'ARG_VAL(3)=',ls_prog
   LET ls_part = ARG_VAL(4)
   DISPLAY 'ARG_VAL(4)=',ls_part
   LET g_run_mode = ARG_VAL(5)      
   DISPLAY 'ARG_VAL(5)=',g_run_mode
   LET g_auto_merge = ARG_VAL(6)
   DISPLAY 'ARG_VAL(6)=',g_auto_merge
   LET g_gen42s_flag = ARG_VAL(7)
   IF cl_null(g_gen42s_flag) THEN LET g_gen42s_flag = TRUE END IF
   DISPLAY 'ARG_VAL(7)=',g_gen42s_flag

   LET g_bgjob="Y"
   IF g_run_mode="4" THEN LET g_patch_mode=TRUE ELSE LET g_patch_mode=FALSE END IF #20150626
   LET lb_result = TRUE
   LET lb_dzye_have_data = FALSE

   #20151123 -Begin-
   #統一先關掉,後面再由lb_main_gen42s_flag補作
   IF g_gen42s_flag THEN 
      LET lb_main_gen42s_flag = TRUE
   ELSE
      LET lb_main_gen42s_flag = FALSE
   END IF
   LET g_gen42s_flag = FALSE
   #20151123 -End-

   INITIALIZE lr_redo TO NULL

   #讀取redo_file (for接關) 
   CALL sadzi888_06_dzye_read_by_prog(g_tar_name,ls_prog) RETURNING ls_err_msg,lr_redo.*
   IF NOT cl_null(ls_err_msg) THEN
      LET lb_dzye_have_data = FALSE
   ELSE 
      LET lb_dzye_have_data = TRUE
   END IF

   IF lb_dzye_have_data THEN
      CASE ls_part CLIPPED
         WHEN "init" #取模組代號,版次等資料
            CALL adzp988_init_prog(ls_prog)

         WHEN "merge" #融合程式 #160223-00028
            CALL adzp988_merge_prog(ls_prog) 
      
         WHEN "gen" #組合程式
            CALL adzp988_gen_prog(ls_prog) 
            
         WHEN "compile" #編譯程式
            CALL adzp988_compile_prog(ls_prog)
      
         WHEN "link" #連結程式
            CALL adzp988_link_prog(ls_prog) 
      
         OTHERWISE
            LET lb_result = FALSE
            LET ls_err_msg = 'ERROR: adzp988 input parqmeter no declare'
      END CASE

   ELSE
      LET lb_result = FALSE
      LET ls_err_msg = "ERROR:",ls_prog," no dzye_t data"
   END IF

   IF NOT lb_result THEN
      DISPLAY ls_err_msg
   END IF

   #記錄結束時間 #20151020
   LET l_time_e=cl_get_current() 
   LET l_time_r=l_time_e - l_time_s
   DISPLAY "End   time : ",l_time_e
   DISPLAY "Cost  time : ",l_time_r
   
   #離開作業
   CALL cl_ap_exitprogram("0")
   
END MAIN


##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 取得程式相關資料
# Input parameter : p_tar_name 
#                   p_prog
# Return code     : lr_result    結果(0:正常,1:異常)
#                 : ls_err_msg   錯誤訊息
# Date & Author   : 2014/10/27 by madey
##########################################################################
PRIVATE FUNCTION adzp988_init_prog(ls_prog) 
   DEFINE ls_trigger  STRING,
          ls_sql      STRING
   DEFINE ls_prog STRING,
          ls_type STRING,
          ls_module STRING,
          sbuf_msg01 base.StringBuffer, #收集錯誤訊息,
          lb_result BOOLEAN,
          ls_err_msg STRING,
          ls_str STRING,
          ls_tar_name STRING
   DEFINE ls_doing       STRING,
          ls_done        STRING
   DEFINE lo_DZAF_T T_DZAF_T
   DEFINE li_cnt LIKE type_t.num5
   DEFINE lb_qry_have_cust BOOLEAN
   DEFINE ls_temp        STRING #20151220
   DEFINE l_cust_flag    STRING #20151220
   DEFINE la_dzaf001     LIKE dzaf_t.dzaf001 #161011-00036
   DEFINE li_dzaf_cnt    LIKE type_t.num5    #161011-00036

   TRY
  
     LET sbuf_msg01 = base.StringBuffer.CREATE() 
      
     LET lr_redo.pid = FGL_GETPID()    #抓這次adzp988的pid #20150708
     DISPLAY "pid=",lr_redo.pid #20150923
     CALL sadzi888_06_dzye_write_by_prog(lr_redo.*)

     #判斷程式類型type 
     LET ls_type=lr_redo.type CLIPPED
     LET ls_doing="type"
     LET ls_done = lr_redo.done CLIPPED
     IF ls_done.getIndexOf(ls_doing,1) > 0 OR   # for redo
        lr_redo.status = "2" 
     THEN 
        #do nothing:不做事
     ELSE
        LET ls_trigger = "adzp988_init_prog : check type(",ls_prog,")"
        DISPLAY ls_trigger
        #20151220:此處重取type的原因，是想判斷目的端是否註冊資料有缺漏，有缺的話直接擋掉，避免後續多做事
        LET ls_temp = sadzp060_2_chk_spec_type(ls_prog)
        IF cl_null(ls_temp) OR ls_temp.trim() = "N" THEN
           LET ls_err_msg = "ERROR:程式",ls_prog,"找不到類別,請確認註冊資料","\n"
           DISPLAY ls_err_msg
           CALL sbuf_msg01.append(ls_err_msg)
           LET lr_redo.type = "@"  
           LET lr_redo.module = "???" 
           LET lr_redo.status = "2" 
           LET lr_redo.err = "register data ERROR(type)" 
           IF cl_null(lr_redo.errmsg) THEN
              LET lr_redo.errmsg =  ls_err_msg.trim()
           ELSE
              LET lr_redo.errmsg = lr_redo.errmsg , "========== \n" , ls_err_msg.trim()
           END IF
        END IF
        LET lr_redo.done = lr_redo.done ,"|",ls_doing
        CALL sadzi888_06_dzye_write_by_prog(lr_redo.*)
     END IF
   
     #取得版次,並判斷是否為客製
     LET ls_doing="revision"
     LET ls_done = lr_redo.done CLIPPED
     IF ls_done.getIndexOf(ls_doing,1) > 0 OR   # for redo
        lr_redo.status = "2" 
       #lr_redo.hardcode_qry ="N" #160223-00028  非hard code qry不用取版次 #160510-00003 mark:不用特別過濾
     THEN
        #do nothing:不做事
     ELSE
        IF lr_redo.type <> "Q" THEN
           LET ls_trigger = "adzp988_init_prog : call sadzp060_2_get_curr_ver_info(",ls_prog,", ",ls_type,", NULL)"
           DISPLAY ls_trigger
           CALL sadzp060_2_get_curr_ver_info(ls_prog, ls_type, NULL) RETURNING lo_DZAF_T.*,ls_err_msg
           IF NOT cl_null(ls_err_msg) THEN
              LET ls_err_msg = "ERROR:程式",ls_prog,"取得版次資料錯誤:",ls_err_msg,"\n"
              DISPLAY ls_err_msg
              CALL sbuf_msg01.append(ls_err_msg)
              LET lr_redo.status = "2" 
              LET lr_redo.err = "revision ERROR(dzaf)" 
              IF cl_null(lr_redo.errmsg) THEN
                 LET lr_redo.errmsg =  ls_err_msg.trim()
              ELSE
                 LET lr_redo.errmsg = lr_redo.errmsg , "========== \n" , ls_err_msg.trim()
              END IF
           ELSE
              DISPLAY "revision:(",lo_DZAF_T.dzaf002 USING "<<<",",",lo_DZAF_T.dzaf003 USING "<<<",",",lo_DZAF_T.dzaf004 USING "<<<",",",lo_DZAF_T.dzaf010,")"
              LET lr_redo.ver      = lo_DZAF_T.dzaf002 CLIPPED
              LET lr_redo.spec_ver = lo_DZAF_T.dzaf003 CLIPPED
              LET lr_redo.code_ver = lo_DZAF_T.dzaf004 CLIPPED
              LET lr_redo.identity = lo_DZAF_T.dzaf010 CLIPPED
           END IF
           LET lr_redo.done = lr_redo.done ,"|",ls_doing
           CALL sadzi888_06_dzye_write_by_prog(lr_redo.*)
        ELSE   
           #qry
           #確認有無r.q設計資料,並確認客戶是否已客製
           LET ls_trigger = "adzp988_init_prog : call adzp210_check_qry_have_cust(",ls_prog,")"
           DISPLAY ls_trigger
           CALL sadzp210_check_qry_have_cust(ls_prog) RETURNING li_cnt ,lb_qry_have_cust
           IF li_cnt > 0 THEN
              IF lb_qry_have_cust THEN
                 LET lr_redo.identity = "c"
              ELSE
                 LET lr_redo.identity = "s"
              END IF
        
              #確認是否為hard code qry
              IF sadzp210_check_qry_hardcode(ls_prog,lr_redo.identity) THEN
                 LET lr_redo.hardcode_qry = "Y" #hard code

                 #Begin: 160510-00003
                 #取得版次
                 LET ls_trigger = "adzp988_init_prog : call sadzp060_2_get_curr_ver_info(",ls_prog,", ",ls_type,", NULL)"
                 DISPLAY ls_trigger
                 CALL sadzp060_2_get_curr_ver_info(ls_prog, ls_type, NULL) RETURNING lo_DZAF_T.*,ls_err_msg
                 IF NOT cl_null(ls_err_msg) THEN
                    LET ls_err_msg = "ERROR:程式",ls_prog,"取得版次資料錯誤:",ls_err_msg,"\n"
                    DISPLAY ls_err_msg
                    CALL sbuf_msg01.append(ls_err_msg)
                    LET lr_redo.status = "2" 
                    LET lr_redo.err = "revision ERROR(dzaf)" 
                    IF cl_null(lr_redo.errmsg) THEN
                       LET lr_redo.errmsg =  ls_err_msg.trim()
                    ELSE
                       LET lr_redo.errmsg = lr_redo.errmsg , "========== \n" , ls_err_msg.trim()
                    END IF
                 ELSE
                    DISPLAY "revision:(",lo_DZAF_T.dzaf002 USING "<<<",",",lo_DZAF_T.dzaf003 USING "<<<",",",lo_DZAF_T.dzaf004 USING "<<<",",",lo_DZAF_T.dzaf010,")"
                    LET lr_redo.ver      = lo_DZAF_T.dzaf002 CLIPPED
                    LET lr_redo.spec_ver = lo_DZAF_T.dzaf003 CLIPPED
                    LET lr_redo.code_ver = lo_DZAF_T.dzaf004 CLIPPED
                    LET lr_redo.identity = lo_DZAF_T.dzaf010 CLIPPED
                 END IF
                 #End: 160510-00003
              ELSE
                 LET lr_redo.hardcode_qry = "N" #not hard code
              END IF
           ELSE
              #無r.q設計資料
              LET ls_err_msg = "ERROR:程式",ls_prog,"找不到r.q設計資料錯誤:",ls_err_msg,"\n"
              DISPLAY ls_err_msg
              CALL sbuf_msg01.append(ls_err_msg)
              LET lr_redo.status = "2" 
              LET lr_redo.err = "register data ERROR(r.q)"
              IF cl_null(lr_redo.errmsg) THEN
                 LET lr_redo.errmsg =  ls_err_msg.trim()
              ELSE
                 LET lr_redo.errmsg = lr_redo.errmsg , "========== \n" , ls_err_msg.trim()
              END IF
           END IF
           #Begin: 160510-00003
           LET lr_redo.done = lr_redo.done ,"|",ls_doing
           CALL sadzi888_06_dzye_write_by_prog(lr_redo.*)
           #End: 160510-00003
        END IF
     END IF

     #強制更新客製註記
    #20151220 -Begin-
    #IF g_run_mode = '6' THEN 
     IF (g_run_mode = "6" OR g_run_mode = "b")                #客戶家過單模式 or 設計資料匯出入模式
     THEN
  #Begin: 161011-00036 mark
  #      #取得目的端的客製註記來判斷是否已客製過，不用lr_redo.identity的原因是該值是從來源端帶過來的且當下已經被import入資料庫了，不準!
  #      LET l_cust_flag = sadzp007_util_get_cust_flag(ls_prog,ls_type)
  #      IF  (NOT cl_null(lr_redo.source_identity)) AND        #不為空 
  #          (NOT cl_null(l_cust_flag))             AND        #不為空
  #          (lr_redo.source_identity <> l_cust_flag)          #來源使用標示 與 客製註記 不同
  # #20151220 -End-
  #      THEN
  #End: 161011-00036 mark
  #Begin: 161011-00036 add
  #客戶過單模式下:有可能剛好這次有booking註冊資料,或是多次解包造成註冊資料已經進去了,這樣判斷不準
  #改成直接由dzaf(s,c)筆數判斷是否標準轉客製,是的話就強制更新
         LET la_dzaf001 = ls_prog
         LET li_dzaf_cnt = 0
         SELECT COUNT(*) INTO li_dzaf_cnt FROM (SELECT DISTINCT dzaf010 FROM dzaf_t WHERE dzaf001= la_dzaf001)
         IF li_dzaf_cnt > 1 THEN
  #End: 161011-00036 add
            LET ls_doing="gzza011"
            LET ls_done = lr_redo.done CLIPPED
            IF ls_done.getIndexOf(ls_doing,1) > 0 OR   # for redo
               lr_redo.status = "2" OR
               lr_redo.hardcode_qry ="N" #160223-00028  非hard code qry不用更新
            THEN
               #do nothing:不做事
            ELSE
              #Begin: 160223-00028
               #檢查gzzn_t筆數是否超過1筆,超過1筆(異常) 就先刪除
               #超過1筆的原因可能是: patch後有可能造成1支程式存在2筆gzzn_t資料,1筆s,1筆c
               #刪除的原因是: 若超過1筆,後續呼叫s_azzi900_upd_gzza011會報錯.因此先刪除，s_azzi900_upd_gzza011若遇到筆數=0會自動補上對的資料
               LET ls_trigger = "adzp988_init_prog : call sadzp210_chk_cnt_gzzn_t(",ls_prog,")"
               DISPLAY ls_trigger
               IF sadzp210_chk_cnt_gzzn_t(ls_prog) > 1 THEN
                  #刪除gzzn_t
                  LET ls_trigger = "adzp988_init_prog : call sadzp210_maintain_gzzn_t(",ls_prog,",'',delete)"
                  DISPLAY ls_trigger
                  IF sadzp210_maintain_gzzn_t(ls_prog,"","delete") THEN
                    #do nothing,暫時by pass
                  END IF
               END IF
              #End: 160223-00028
         
               LET ls_trigger = "adzp988_init_prog : call s_azzi900_upd_gzza011(",lr_redo.prog,",",lr_redo.type,",",lr_redo.identity,")"
               DISPLAY ls_trigger
               CALL s_azzi900_upd_gzza011(lr_redo.prog, lr_redo.type, lr_redo.identity) RETURNING lb_result
               IF NOT lb_result THEN 
                  LET ls_err_msg = "ERROR:程式",lr_redo.prog,"更新azzi070單身資料or更新客製註記錯誤","\n"
                  DISPLAY ls_err_msg
                  CALL sbuf_msg01.append(ls_err_msg)
                  LET lr_redo.status = "2" 
                  LET lr_redo.err = "update cust flag ERROR" 
                  IF cl_null(lr_redo.errmsg) THEN
                     LET lr_redo.errmsg =  ls_err_msg.trim()
                  ELSE
                     LET lr_redo.errmsg = lr_redo.errmsg , "========== \n" , ls_err_msg.trim()
                  END IF
               END IF
               LET lr_redo.done = lr_redo.done ,"|",ls_doing
               CALL sadzi888_06_dzye_write_by_prog(lr_redo.*)
            END IF
         END IF
     END IF #20151220
     
     #取得程式模組module
     #此步驟順序本來是在取ls_type之後, 取版次之前.
     #因為增加強制更新客製註記的步驟,所以改成在取ls_type及更新客製註記之後,這樣取到的模組代號才會是準的
     LET ls_doing="module"
     LET ls_done = lr_redo.done CLIPPED
     IF ls_done.getIndexOf(ls_doing,1) > 0 OR   # for redo
        lr_redo.status = "2" 
     THEN
        #do nothing:不做事
        LET ls_module=lr_redo.module CLIPPED
     ELSE
        LET ls_trigger = "adzp988_init_prog : call sadzp062_1_find_module(",ls_prog,", ",ls_type,")"
        DISPLAY ls_trigger 
        LET ls_module = sadzp062_1_find_module(ls_prog, ls_type)
        IF cl_null(ls_module) THEN
           LET ls_err_msg = "ERROR:程式",ls_prog,"找不到模組,請確認註冊資料","\n"
           DISPLAY ls_err_msg
           CALL sbuf_msg01.append(ls_err_msg)
           LET lr_redo.module = "???"
           LET lr_redo.status = "2" 
           LET lr_redo.err = "register data ERROR(module)" 
           IF cl_null(lr_redo.errmsg) THEN
              LET lr_redo.errmsg =  ls_err_msg.trim()
           ELSE
              LET lr_redo.errmsg = lr_redo.errmsg , "========== \n" , ls_err_msg.trim()
           END IF
        ELSE
           LET lr_redo.module = ls_module
        END IF
        LET lr_redo.done = lr_redo.done ,"|",ls_doing
        CALL sadzi888_06_dzye_write_by_prog(lr_redo.*)
     END IF


     #指定順序:for merge,compile用
     #保留前10給特別的狀態, 例如:@代表類別找不到, L代表r.l 42x
     CASE lr_redo.type
        WHEN "F"   LET lr_redo.order = 11
        WHEN "B"   IF lr_redo.module MATCHES "*LIB*" THEN
                      LET lr_redo.order = 12
                   ELSE
                      LET lr_redo.order = 13
                   END IF
        WHEN "Q"   LET lr_redo.order = 14
        WHEN "G"   LET lr_redo.order = 15
        WHEN "X"   LET lr_redo.order = 16
        WHEN "W"   LET lr_redo.order = 17
        WHEN "S"   LET lr_redo.order = 18
        WHEN "Z"   LET lr_redo.order = 19
        WHEN "M"   LET lr_redo.order = 20
        WHEN "L"   LET lr_redo.order = 2  #正常r.l 42x不會跑到init這個function,此處只是統一表列所有情況
        OTHERWISE  LET lr_redo.order = 1  
     END CASE


     #記錄此階段已完成
     LET lr_redo.stage = NULL #此階段結束
     IF lr_redo.status = "2" THEN #錯誤
        #do nothing
     ELSE 
        LET lr_redo.status = "1" #成功
     END IF
     CALL sadzi888_06_dzye_write_by_prog(lr_redo.*)

     #================寫 summary log ==================== 
     LET ls_str = "=====",2 SPACE ,"====================",2 SPACE ,"====", 3 SPACE , "=========================","init prog"
     DISPLAY ls_str
     CASE lr_redo.status
        WHEN "1"   LET lf_status = "ok"
        WHEN "2"   LET lf_status = "ERROR"
        WHEN "3"   LET lf_status = "skip"
        OTHERWISE  LET lf_status = "???"
     END CASE
     LET lf_module = lr_redo.module
     LET lf_prog   = lr_redo.prog 
     LET lf_err    = lr_redo.err
     LET ls_str = lf_module , 2 SPACE ,lf_prog , 2 SPACE , lf_status , 2 SPACE , lf_err
     DISPLAY ls_str
     LET ls_str = "=====",2 SPACE ,"====================",2 SPACE ,"====", 3 SPACE , "=========================","init prog"
     DISPLAY ls_str

   ##IF sbuf_msg01.getLength()>0 THEN #表示有錯誤
   ##   CALL sbuf_msg01.APPEND("\n ERROR") #
   ##   DISPLAY "adzp988_init_prog : ",sbuf_msg01.toString()
   ##   RETURN FALSE,sbuf_msg01.toString()
   ##END IF
   ##
   ##RETURN TRUE,NULL

   CATCH 
      #寫log
      LET ls_str = "-> adzp988_init_prog - Catch exception-",ls_trigger , ASCII 10

      CALL sadzi888_06_err_catch(ls_trigger, ls_sql) 
      LET ls_err_msg = ls_trigger, "\n ERROR"
    ##RETURN FALSE,ls_err_msg
   END TRY
END FUNCTION


#160223-00028 add: merge
##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 單支程式融合
# Input parameter : p_prog
# Return code     : lr_result    結果(0:正常,1:異常)
#                 : ls_err_msg   錯誤訊息
# Date & Author   : 
##########################################################################
PRIVATE FUNCTION adzp988_merge_prog(ls_prog) 
   DEFINE ls_trigger  STRING,
          ls_sql      STRING,
          ls_where    STRING,
          li_idx     SMALLINT
   DEFINE ls_prog STRING,
          ls_module STRING,
          sbuf_msg05 base.StringBuffer, #收集錯誤訊息,
          lb_result BOOLEAN,
          ls_err_msg STRING,
          ls_str STRING,
          ls_tar_name STRING,
          li_i SMALLINT,
          li_cnt SMALLINT,
          li_ins_idx SMALLINT,
          ls_module_dir STRING,
          ls_working_path STRING,
          ls_cmd STRING
   DEFINE lo_DZAF_T T_DZAF_T
   DEFINE ls_doing       STRING,
          ls_done        STRING
 
   DEFINE ls_std_prog STRING #對應的標準程式

   TRY
  
     LET sbuf_msg05 = base.StringBuffer.CREATE() 

     LET lr_redo.pid = FGL_GETPID()    #抓這次adzp988的pid
     DISPLAY "pid=",lr_redo.pid
     CALL sadzi888_06_dzye_write_by_prog(lr_redo.*)

     #寫入merge權限表: 先保有可merge的權利
     LET ls_doing="dzap"
     LET ls_done = lr_redo.done CLIPPED
     IF ls_done.getIndexOf(ls_doing,1) > 0    # for redo
     THEN
        #do nothing:不做事
     ELSE
        LET ls_trigger = "adzp988_merge_prog : call sadzi888_07_ins_dzap_t()"
        DISPLAY ls_trigger
        LET lo_DZAF_T.DZAF001 =  lr_redo.prog
        LET lo_DZAF_T.DZAF002 =  lr_redo.ver
        LET lo_DZAF_T.DZAF003 =  lr_redo.spec_ver
        LET lo_DZAF_T.DZAF004 =  lr_redo.code_ver
        LET lo_DZAF_T.DZAF005 =  lr_redo.type
        LET lo_DZAF_T.DZAF006 =  lr_redo.module 
        LET lo_DZAF_T.DZAF010 =  lr_redo.identity
        CALL sadzi888_07_ins_dzap_t(lo_DZAF_T.*,g_tar_name) RETURNING lb_result,ls_err_msg
        IF NOT lb_result THEN 
           LET ls_err_msg = "ERROR:程式",ls_prog,"寫入merge記錄表(dzap_t)失敗:",ls_err_msg,"\n"
           DISPLAY ls_err_msg
           CALL sbuf_msg05.append(ls_err_msg)
           LET lr_redo.status = "2" 
           LET lr_redo.err = "dzap ERROR"  
        END IF
        #因為有可能呼叫merge但實際上並沒有merge,這邊還是保留訊息
        IF cl_null(lr_redo.errmsg) THEN
           LET lr_redo.errmsg =  ls_err_msg.trim()
        ELSE
           LET lr_redo.errmsg = lr_redo.errmsg , "========== \n" , ls_err_msg.trim()
        END IF
        LET lr_redo.done = lr_redo.done ,"|",ls_doing
        CALL sadzi888_06_dzye_write_by_prog(lr_redo.*)
     END IF

     IF lr_redo.merge= 'Y' THEN  #勾選要merge
        #客製程式要預先編譯4fd及4gl,沒有錯誤才能被merge

        #預先編譯4fd
        LET ls_doing="pre_r.f"
        LET ls_done = lr_redo.done CLIPPED
        IF ls_done.getIndexOf(ls_doing,1) > 0 OR   # for redo
           lr_redo.status = "2" OR
           lr_redo.status = "3" OR
          (lr_redo.type NOT MATCHES "[SMFQ]")     #這幾類才有4fd
        THEN 
           #do nothing:不做事
        ELSE
           LET ls_module_dir = FGL_GETENV(lr_redo.module CLIPPED) 
         
           #編譯
           LET ls_working_path = os.Path.join(ls_module_dir,"4fd")
           LET ls_trigger = "adzp988_merge_prog :pre compile 4fd, change dir to ",ls_working_path
           DISPLAY ls_trigger
          #IF cl_change_dir(ls_working_path) THEN
           IF os.Path.chdir(ls_working_path) THEN #160726-00031
              LET ls_cmd = "r.f ",ls_prog ," tiptop"
              LET ls_trigger = "adzp988_merge_prog :pre compile 4fd : ",ls_cmd
              DISPLAY ls_trigger
              CALL cl_cmdrun_openpipe("r.f", ls_cmd, FALSE) RETURNING lb_result,ls_err_msg
              IF NOT lb_result THEN
                 LET ls_err_msg = "ERROR:程式",ls_prog,"在r.f出現錯誤(預先編譯):",ls_err_msg,"\n"
                 DISPLAY ls_err_msg
                 CALL sbuf_msg05.append(ls_err_msg)
                #LET lr_redo.status =  "3" #161103-00029 mark         
                 LET lr_redo.err =  "pre compile 4fd ERROR" 
                 IF cl_null(lr_redo.errmsg) THEN
                    LET lr_redo.errmsg =  ls_err_msg.trim()
                 ELSE
                    LET lr_redo.errmsg = lr_redo.errmsg , "========== \n" , ls_err_msg.trim()
                 END IF
              END IF
           ELSE
              LET ls_err_msg = "ERROR:程式",ls_prog,"切換路徑",ls_working_path,"出現錯誤,請查看背景執行過程","\n"
              DISPLAY ls_err_msg
              CALL sbuf_msg05.append(ls_err_msg)
              LET lr_redo.status =  "3"             
              LET lr_redo.err =  "change dir ERROR" 
              IF cl_null(lr_redo.errmsg) THEN
                 LET lr_redo.errmsg =  ls_err_msg.trim()
              ELSE
                 LET lr_redo.errmsg = lr_redo.errmsg , "========== \n" , ls_err_msg.trim()
              END IF
           END IF
           LET lr_redo.done = lr_redo.done ,"|",ls_doing
           CALL sadzi888_06_dzye_write_by_prog(lr_redo.*)
        END IF
        
        #預先編譯4gl
        LET ls_doing="pre_r.c"
        LET ls_done = lr_redo.done CLIPPED
        IF ls_done.getIndexOf(ls_doing,1) > 0 OR   # for redo
           lr_redo.status = "2" OR
           lr_redo.status = "3" OR
          (lr_redo.type NOT MATCHES "[SMZBWQ]")  #這幾類才有4gl
        THEN 
           #do nothing:不做事
        ELSE
           LET ls_module_dir = FGL_GETENV(lr_redo.module CLIPPED) 
         
           #編譯
           LET ls_working_path = os.Path.join(ls_module_dir,"4gl")
           LET ls_trigger = "adzp988_merge_prog :pre compile 4gl , change dir to ",ls_working_path
           DISPLAY ls_trigger
          #IF cl_change_dir(ls_working_path) THEN
           IF os.Path.chdir(ls_working_path) THEN #160726-00031
              LET ls_cmd = "$FGLRUN $FBIN/42m/gen42m ",ls_prog," tiptop"
              LET ls_trigger = "adzp988_merge_prog :pre compile 4gl : ",ls_cmd
              DISPLAY ls_trigger
              CALL cl_cmdrun_openpipe("gen42m", ls_cmd, FALSE) RETURNING lb_result,ls_err_msg
              IF NOT lb_result THEN
                 LET ls_err_msg = "ERROR:程式",ls_prog,"在r.c出現錯誤(預先編譯):",ls_err_msg,"\n"
                 DISPLAY ls_err_msg
                 CALL sbuf_msg05.append(ls_err_msg)
                #LET lr_redo.status = "3" #161103-00029 mark        
                 LET lr_redo.err =  "pre compile 4gl ERROR" 
                 IF cl_null(lr_redo.errmsg) THEN
                    LET lr_redo.errmsg =  ls_err_msg.trim()
                 ELSE
                    LET lr_redo.errmsg = lr_redo.errmsg , "========== \n" , ls_err_msg.trim()
                 END IF
              END IF
           ELSE
              LET ls_err_msg = "ERROR:程式",ls_prog,"切換路徑",ls_working_path,"出現錯誤,請查看背景執行過程","\n"
              DISPLAY ls_err_msg
              CALL sbuf_msg05.append(ls_err_msg)
              LET lr_redo.status = "3"             
              LET lr_redo.err =  "change dir ERROR" 
              IF cl_null(lr_redo.errmsg) THEN
                 LET lr_redo.errmsg =  ls_err_msg.trim()
              ELSE
                 LET lr_redo.errmsg = lr_redo.errmsg , "========== \n" , ls_err_msg.trim()
              END IF
           END IF
           LET lr_redo.done = lr_redo.done ,"|",ls_doing
           CALL sadzi888_06_dzye_write_by_prog(lr_redo.*)
        END IF
        
        #merge
        LET ls_doing="merge"
        LET ls_done = lr_redo.done CLIPPED
        IF ls_done.getIndexOf(ls_doing,1) > 0 OR  # for redo
           lr_redo.status = "2" OR
           lr_redo.status = "3"
        THEN 
           #do nothing:不做事
        ELSE
           LET ls_trigger = "adzp988_merge_prog : call sadzi888_07_auto_merge()"
           DISPLAY ls_trigger
           CALL sadzi888_07_auto_merge(lo_DZAF_T.*) RETURNING lb_result,ls_err_msg
           IF NOT lb_result THEN 
              LET ls_err_msg = "ERROR:程式",ls_prog,"在merge出現錯誤:",ls_err_msg,"\n"
              DISPLAY ls_err_msg
              CALL sbuf_msg05.append(ls_err_msg)
              LET lr_redo.status = "2" 
              LET lr_redo.err = "merge ERROR"  
           END IF
           #因為有可能呼叫merge但實際上並沒有做merge,這邊還是保留訊息
           IF cl_null(lr_redo.errmsg) THEN
              LET lr_redo.errmsg =  ls_err_msg.trim()
           ELSE
              LET lr_redo.errmsg = lr_redo.errmsg , "========== \n" , ls_err_msg.trim()
           END IF
        
           #merge後版本會+1,所以要重新取得最新版次並更新dzye
           LET ls_trigger = "adzp988_merge_prog : call sadzp060_2_get_curr_ver_info(",lr_redo.prog,", ",lr_redo.type,", ",lr_redo.module,")"," again"
           DISPLAY ls_trigger
           CALL sadzp060_2_get_curr_ver_info(lr_redo.prog, lr_redo.type, lr_redo.module) RETURNING lo_DZAF_T.*,ls_err_msg
           IF NOT cl_null(ls_err_msg) THEN
              LET ls_err_msg = "ERROR:程式",lr_redo.prog,"取得版次資料錯誤:",ls_err_msg,"\n"
              DISPLAY ls_err_msg
              CALL sbuf_msg05.append(ls_err_msg)
              LET lr_redo.status = "2" 
              LET lr_redo.err = "revision ERROR(dzaf)" 
              IF cl_null(lr_redo.errmsg) THEN
                 LET lr_redo.errmsg =  ls_err_msg.trim()
              ELSE
                 LET lr_redo.errmsg = lr_redo.errmsg , "========== \n" , ls_err_msg.trim()
              END IF
           ELSE
              DISPLAY "revision:(",lo_DZAF_T.dzaf002 USING "<<<",",",lo_DZAF_T.dzaf003 USING "<<<",",",lo_DZAF_T.dzaf004 USING "<<<",",",lo_DZAF_T.dzaf010,")"
              LET lr_redo.ver      = lo_DZAF_T.dzaf002 CLIPPED
              LET lr_redo.spec_ver = lo_DZAF_T.dzaf003 CLIPPED
              LET lr_redo.code_ver = lo_DZAF_T.dzaf004 CLIPPED
              LET lr_redo.identity = lo_DZAF_T.dzaf010 CLIPPED
           END IF
           LET lr_redo.done = lr_redo.done ,"|",ls_doing
           CALL sadzi888_06_dzye_write_by_prog(lr_redo.*)
        END IF
     END IF

     #記錄此階段已完成
     LET lr_redo.stage = NULL ##此階段結束
     IF lr_redo.status = "2" OR lr_redo.status = "3" THEN
        #do nothing
     ELSE
         LET lr_redo.status = "1" 
     END IF
     CALL sadzi888_06_dzye_write_by_prog(lr_redo.*)


     #================寫 summary log ==================== 
    #LET ls_str = "=====",2 SPACE ,"====================",2 SPACE ,"====", 3 SPACE , "=========================","gen prog"
     LET ls_str = "=====",2 SPACE ,"====================",2 SPACE ,"====", 3 SPACE , "=========================","merge prog" #161130-00069
     DISPLAY ls_str
     CASE lr_redo.status
        WHEN "1"   LET lf_status = "ok"
        WHEN "2"   LET lf_status = "ERROR"
        WHEN "3"   LET lf_status = "skip"
        OTHERWISE  LET lf_status = "???"
     END CASE
     LET lf_module = lr_redo.module
     LET lf_prog   = lr_redo.prog 
     LET lf_err    = lr_redo.err
     LET ls_str = lf_module , 2 SPACE ,lf_prog , 2 SPACE , lf_status , 2 SPACE , lf_err
     DISPLAY ls_str
    #LET ls_str = "=====",2 SPACE ,"====================",2 SPACE ,"====", 3 SPACE , "=========================","gen prog"
     LET ls_str = "=====",2 SPACE ,"====================",2 SPACE ,"====", 3 SPACE , "=========================","merge prog" #161130-00069
     DISPLAY ls_str

   ##IF sbuf_msg05.getLength()>0 THEN #表示有錯誤
   ##   CALL sbuf_msg05.APPEND("\n ERROR")
   ##   DISPLAY "adzp988_merge_prog : ",sbuf_msg05.toString()
   ##   RETURN FALSE,sbuf_msg05.toString()
   ##END IF
   ##
   ##RETURN TRUE,NULL

   CATCH 
      #寫log
      LET ls_str = "-> adzp988_merge_prog - Catch exception-",ls_trigger , ASCII 10

      CALL sadzi888_06_err_catch(ls_trigger, ls_sql) 
      LET ls_err_msg = ls_trigger, "\n ERROR"
    ##RETURN FALSE,ls_err_msg
   END TRY
END FUNCTION


##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 單支程式組合
# Input parameter : p_prog
# Return code     : lr_result    結果(0:正常,1:異常)
#                 : ls_err_msg   錯誤訊息
# Date & Author   : 2014/09/09 by madey
##########################################################################
PRIVATE FUNCTION adzp988_gen_prog(ls_prog) 
   DEFINE ls_trigger  STRING,
          ls_sql      STRING,
          ls_where    STRING,
          li_idx     SMALLINT
   DEFINE ls_prog STRING,
          ls_module STRING,
          sbuf_msg02 base.StringBuffer, #收集錯誤訊息,
          lb_result BOOLEAN,
          ls_err_msg STRING,
          ls_str STRING,
          ls_tar_name STRING,
          li_i SMALLINT,
          li_cnt SMALLINT,
          li_ins_idx SMALLINT,
          ls_module_dir STRING,
          ls_working_path STRING,
          ls_cmd STRING
   DEFINE lo_DZAF_T T_DZAF_T
   DEFINE ls_doing       STRING,
          ls_done        STRING
 
   DEFINE ls_std_prog STRING #對應的標準程式
   #Begin: 160223-00028
   DEFINE lb_gen                 BOOLEAN  #是否需要重產
   DEFINE l_pack_dir             STRING
   DEFINE l_source_folder        STRING,
          l_source_folder_path   STRING
   DEFINE l_module_path          STRING
   DEFINE l_source               STRING
   DEFINE l_dest                 STRING
   DEFINE l_cmd                  STRING
   DEFINE ls_err_msg_keep        STRING
   #End: 160223-00028
  
   #Begin: 160620-00020
   DEFINE lb_copy                BOOLEAN  #是否需要copy靜態檔
   DEFINE l_gzza003              LIKE gzza_t.gzza003
   DEFINE l_gzza011              LIKE gzza_t.gzza011
   #End: 160620-00020
   DEFINE lb_topstd              BOOLEAN #是否topstd修改過 #161130-00069

   TRY
  
     LET sbuf_msg02 = base.StringBuffer.CREATE() 

     LET lr_redo.pid = FGL_GETPID()    #抓這次adzp988的pid
     DISPLAY "pid=",lr_redo.pid 
     CALL sadzi888_06_dzye_write_by_prog(lr_redo.*)

     #Begin: 160223-00028
     #預設要重產，但patch模式下:客戶家標準程式不重產只copy靜態檔,其他模式下要重產
     LET lb_gen = TRUE #要重產

    #Begin: 161130-00069 -modify-
    #IF g_run_mode = "4" AND lr_redo.identity = "s" THEN
    #  LET lb_gen = FALSE #不重產
    #END IF
     IF g_run_mode = "4" THEN
       #Begin: 170303-00039
        IF (g_tar_name MATCHES "TSD-1*") OR 
           (g_tar_name MATCHES "A*" AND g_tar_name.getlength()=10 ) 
        THEN
           #do nothing
        ELSE
       #End: 170303-00039
           LET lb_topstd = sadzi888_06_chk_modi_by_topstd(ls_prog) 
           DISPLAY "lb_topstd=",lb_topstd
           IF lr_redo.identity = "s" AND (NOT lb_topstd) THEN
              LET lb_gen = FALSE #不重產
           END IF
        END IF #170303-00039
     END IF
     DISPLAY "lb_gen=",lb_gen
    #End: 161130-00069 -modify-

     #取得舊程式備份版數 (0表示不留備份)
     LET g_backfile = sadzp007_util_get_backfile_cnt()
     DISPLAY "g_backfile=",g_backfile
     #End: 160223-00028

     #Bebin: 160620-00020
     #預設不copy,但patch模式下要copy
     LET lb_copy = FALSE
     IF g_run_mode = "4"  THEN
     #Begin: 170208-00008 -mark-
     ##Begin: 161130-00069 -modify-
     ##LET lb_copy = TRUE
     # IF lr_redo.identity = "s" AND (lb_topstd) THEN
     #    #patch模式下,標準程式有被topstd修改過，不copy走重產
     #    #do nothing
     # ELSE
     #    LET lb_copy = TRUE #要copy
     # END IF
     #End: 170208-00008 -mark-
      #End: 161130-00069 -modify-
       LET lb_copy = TRUE #170208-00008
     END IF
     DISPLAY "lb_copy=",lb_copy  #161130-00069

     IF lb_copy THEN
        LET ls_doing="copy_file"
        LET ls_done = lr_redo.done CLIPPED
        IF ls_done.getIndexOf(ls_doing,1) > 0 OR   # for redo
           lr_redo.status = "2" OR
           lr_redo.status = "3"
        THEN 
           #do nothing:不做事
        ELSE
           #走copy靜態檔
           LET ls_err_msg_keep = NULL
           LET l_source_folder = g_tar_name, "-source"
           LET l_pack_dir = FGL_GETENV(g_pack_dir_env)
           LET l_source_folder_path = os.path.JOIN(os.path.JOIN(l_pack_dir,g_tar_name),l_source_folder)  # /ut/topprd/tmp/xxx/xxx-source
           IF os.path.EXISTS(l_source_folder_path) THEN
              #標準程式的歸屬模組與實際模組一致;客製過的標準程式歸屬模組在標準目錄
              #此處特別取歸屬模組，而不是實際模組，因為遇客製過的標準程式要先copy靜態檔到標準目錄,後續會再透過重產將客製過的內容產到實際目錄
              #LET l_module_path = FGL_GETENV(UPSHIFT(lr_redo.module))       # $AIT= /u1/topprd/erp/ait
              CALL sadzp062_1_find_belong_module(ls_prog, lr_redo.type) RETURNING l_gzza003,l_gzza011
              LET l_module_path = FGL_GETENV(UPSHIFT(l_gzza003))
          
              #4fd
              IF lr_redo.type MATCHES "[SMFQ]" THEN #正向表列有4fd的所有類型
                 LET l_source = os.path.JOIN(l_source_folder_path,ls_prog||".4fd") # /ut/topprd/tmp/xxx/xxx-source/aiti001.4fd
                 LET l_dest = os.path.JOIN(os.path.JOIN(l_module_path,"4fd"),ls_prog||".4fd")  # /u1/topprd/erp/ait/4fd/aiti001.4fd
                 IF os.path.EXISTS(l_source) THEN
                    #1. 備份舊檔
                    CALL sadzp007_util_backfile(l_dest,g_backfile)
                     
                    #2. copy file
                    LET l_cmd = "cp " ,l_source ," ",l_dest
                    DISPLAY "l_cmd=",l_cmd
                    RUN l_cmd
                    IF STATUS THEN
                       LET ls_err_msg_keep =  ls_err_msg_keep , ASCII 10 , cl_getmsg_parm("adz-00338", g_lang, l_cmd)
                    END IF
                 ELSE
                    LET ls_err_msg_keep =  ls_err_msg_keep , ASCII 10 , cl_getmsg_parm("adz-00339", g_lang, l_source)
                 END IF
              END IF
           
              #tab
              IF lr_redo.type MATCHES "[SMZBWQGX]" THEN #正向表列有tab的所有類型
                 IF lr_redo.type = "Q" AND lr_redo.hardcode_qry = "N" THEN
                    #do nothing  #非hard code走adzi210機制,不會有tab
                 ELSE
                    LET l_source = os.path.JOIN(l_source_folder_path,ls_prog||".tab")  # /ut/topprd/tmp/xxx/xxx-source/aiti001.tab
                    LET l_dest = os.path.JOIN(os.path.JOIN(os.path.JOIN(l_module_path,"dzx"),"tab"),ls_prog||".tab")  # /u1/topprd/erp/ait/dzx/tab/aiti001.tab
                    IF os.path.EXISTS(l_source) THEN
                       #1. 備份舊檔
                       CALL sadzp007_util_backfile(l_dest,g_backfile)
                    
                       #2. copy file
                       LET l_cmd = "cp " ,l_source ," ",l_dest
                       DISPLAY "l_cmd=",l_cmd
                       RUN l_cmd
                       IF STATUS THEN
                          LET ls_err_msg_keep =  ls_err_msg_keep , ASCII 10 , cl_getmsg_parm("adz-00338", g_lang, l_cmd)
                       END IF

                       #3. 產生mask程式片段
                       LET l_cmd="r.r adzp155 ",DOWNSHIFT(lr_redo.module)," ",ls_prog," n"," &"
                       DISPLAY "l_cmd=",l_cmd
                       RUN l_cmd WITHOUT WAITING
                    ELSE
                       LET ls_err_msg_keep =  ls_err_msg_keep , ASCII 10 , cl_getmsg_parm("adz-00339", g_lang, l_source)
                    END IF
                 END IF
              END IF
           
              #tgl
              IF lr_redo.type MATCHES "[SMZBWQGX]" THEN #正向表列有tgl的所有類型
                 IF lr_redo.type = "Q" AND lr_redo.hardcode_qry = "N" THEN
                    #do nothing
                    #非hard code走adzi210機制,不會有tgl
                 ELSE
                    LET l_source = os.path.JOIN(l_source_folder_path,ls_prog||".tgl")  # /ut/topprd/tmp/xxx/xxx-source/aiti001.tgl
                    LET l_dest = os.path.JOIN(os.path.JOIN(os.path.JOIN(l_module_path,"dzx"),"tgl"),ls_prog||".tgl")  # /u1/topprd/erp/ait/dzx/tgl/aiti001.tgl
                    IF os.path.EXISTS(l_source) THEN
                       #1. 備份舊檔
                       CALL sadzp007_util_backfile(l_dest,g_backfile)
                    
                       #2. copy file
                       LET l_cmd = "cp " ,l_source ," ",l_dest
                       DISPLAY "l_cmd=",l_cmd
                       RUN l_cmd
                       IF STATUS THEN
                          LET ls_err_msg_keep =  ls_err_msg_keep , ASCII 10 , cl_getmsg_parm("adz-00338", g_lang, l_cmd)
                       END IF
                    ELSE
                       LET ls_err_msg_keep =  ls_err_msg_keep , ASCII 10 , cl_getmsg_parm("adz-00339", g_lang, l_source)
                    END IF
                 END IF
              END IF
           
              #4gl
              IF lr_redo.type MATCHES "[SMZBWQGX]" THEN #正向表列有4gl的所有類型
                 LET l_source = os.path.JOIN(l_source_folder_path,ls_prog||".4gl")  # /ut/topprd/tmp/xxx/xxx-source/aiti001.4gl
                 LET l_dest = os.path.JOIN(os.path.JOIN(l_module_path,"4gl"),ls_prog||".4gl")  # /u1/topprd/erp/ait/4fd/aiti001.4fd
                 IF os.path.EXISTS(l_source) THEN
                    #1. 備份舊檔 
                    CALL sadzp007_util_backfile(l_dest,g_backfile) 
                    
                    #2. copy file
                    LET l_cmd = "cp " ,l_source ," ",l_dest
                    DISPLAY "l_cmd=",l_cmd
                    RUN l_cmd
                    IF STATUS THEN
                       LET ls_err_msg_keep =  ls_err_msg_keep , ASCII 10 , cl_getmsg_parm("adz-00338", g_lang, l_cmd)
                    END IF
                    
                    #Begin: 170208-00008 
                    #2.1 copy file (xxx.4gl.src)
                    LET l_dest = os.path.JOIN(os.path.JOIN(l_module_path,"4gl"),ls_prog||".4gl.src")  # /u1/topprd/erp/ait/4gl/aiti001.4gl.src
                    LET l_cmd = "cp " ,l_source ," ",l_dest
                    DISPLAY "l_cmd=",l_cmd
                    RUN l_cmd
                    IF STATUS THEN
                       LET ls_err_msg_keep =  ls_err_msg_keep , ASCII 10 , cl_getmsg_parm("adz-00338", g_lang, l_cmd)
                    END IF
                    #End: 170208-00008 
           
                    #3. 清空 程式MD5
                    LET ls_sql="UPDATE gzzx_t SET gzzx013 = '' WHERE gzzx001='",ls_prog,"'"
                    PREPARE gzzx_upd_pre1 FROM ls_sql
                    EXECUTE gzzx_upd_pre1
                    FREE gzzx_upd_pre1

                   ##4. qry自動維護gzzn_t
                   #mark掉不需做的原因:已經納入dzyb_t,有booking adzi210時，會連同打包gzzn_t了
                   #IF lr_redo.type = "Q" THEN
                   #   IF sadzp210_maintain_gzzn_t(ls_prog,lr_redo.module,"insert") THEN
                   #     #do nothing,暫時by pass                                                                        
                   #   END IF
                   #END IF
                 ELSE
                    LET ls_err_msg_keep =  ls_err_msg_keep , ASCII 10 , cl_getmsg_parm("adz-00339", g_lang, l_source)
                 END IF
              END IF
           ELSE
              LET ls_err_msg_keep =  ls_err_msg_keep , ASCII 10 ,l_source_folder_path," not exists,skip copy 4fd/4gl"
           END IF

           #以上做完
           IF NOT cl_null(ls_err_msg_keep) THEN
              LET ls_err_msg = "ERROR:",ls_err_msg_keep
              DISPLAY ls_err_msg
              CALL sbuf_msg02.append(ls_err_msg)
              LET lr_redo.status =  "2"             
              LET lr_redo.err =  "copy file ERROR" 
              IF cl_null(lr_redo.errmsg) THEN
                 LET lr_redo.errmsg =  ls_err_msg.trim()
              ELSE
                 LET lr_redo.errmsg = lr_redo.errmsg , "========== \n" , ls_err_msg.trim()
              END IF
           END IF
           LET lr_redo.done = lr_redo.done ,"|",ls_doing                                                          
           CALL sadzi888_06_dzye_write_by_prog(lr_redo.*)
        END IF
     END IF
     #End: 160620-00020

     IF lb_gen THEN
        #160223-00028 memo:
        #非hard code qry走r.q產生4fd/4gl流程
        #hard code qry比照一般程式重產流程
        IF lr_redo.type = "Q" AND lr_redo.hardcode_qry = "N" THEN
           LET ls_doing="gen_qry"
           LET ls_done = lr_redo.done CLIPPED
           IF ls_done.getIndexOf(ls_doing,1) > 0 OR   # for redo
              lr_redo.status = "2" OR
              lr_redo.status = "3"
           THEN 
              #do nothing:不做事
           ELSE
             #Begin: 160223-00028
             ##維護gzzn_t
             #LET ls_trigger = "adzp988_gen_prog : call sadzp210_maintain_gzzn_t(",ls_prog,",",lr_redo.module,",insert)"
             #DISPLAY ls_trigger
             #IF sadzp210_maintain_gzzn_t(ls_prog,lr_redo.module,"insert") THEN
             #  #do nothing,暫時by pass
             #END IF
              LET ls_cmd = "r.r adzp210"," ",ls_prog," ","''"," ","0" #呼叫開窗產生程式,給參數0: 不編譯4gl/4fd
              LET ls_trigger = "adzp988_gen_prog : ",ls_cmd
              DISPLAY ls_trigger
              CALL cl_cmdrun_openpipe("r.r", ls_cmd, FALSE) RETURNING lb_result,ls_err_msg
              IF NOT lb_result THEN 
                #LET ls_err_msg = "ERROR:程式",ls_prog,"透過r.q重產4fd/4gl出現錯誤","\n"
                 LET ls_err_msg = "ERROR:程式",ls_prog,"透過r.q重產4fd/4gl出現錯誤:",ls_err_msg,"\n" #160517-00008
                 CALL sbuf_msg02.append(ls_err_msg)
                 LET lr_redo.status = "2" 
                 LET lr_redo.err = "gen qry ERROR"  
                 IF cl_null(lr_redo.errmsg) THEN
                    LET lr_redo.errmsg =  ls_err_msg.trim()
                 ELSE
                    LET lr_redo.errmsg = lr_redo.errmsg , "========== \n" , ls_err_msg.trim()
                 END IF
              END IF
              LET lr_redo.done = lr_redo.done ,"|",ls_doing
              CALL sadzi888_06_dzye_write_by_prog(lr_redo.*)
             #End: 160223-00028
           END IF
        ELSE
           #一般程式重產流程
     
           #重產4fd
           LET ls_doing="regen_4fd"
           LET ls_done = lr_redo.done CLIPPED
           IF ls_done.getIndexOf(ls_doing,1) > 0 OR   # for redo
              lr_redo.status = "2" OR
              lr_redo.status = "3" OR
             (lr_redo.type NOT MATCHES "[SMFQ]")     #這幾類才有4fd
           THEN 
              #do nothing:不做事
           ELSE
              LET ls_trigger = "adzp988_gen_prog : call sadzp168_5(",ls_prog,",",lr_redo.spec_ver,",",lr_redo.identity,",TRUE)"
              DISPLAY ls_trigger
              CALL sadzp168_5(ls_prog, lr_redo.spec_ver, lr_redo.identity, TRUE) RETURNING lb_result,ls_err_msg
              IF NOT lb_result THEN 
                 LET ls_err_msg = "ERROR:程式",ls_prog,"重產4fd出現錯誤:",ls_err_msg,"\n"
                 CALL sbuf_msg02.append(ls_err_msg)
                 LET lr_redo.status = "2" 
                 LET lr_redo.err = "genrate/compile 4fd ERROR"  
                 IF cl_null(lr_redo.errmsg) THEN
                    LET lr_redo.errmsg =  ls_err_msg.trim()
                 ELSE
                    LET lr_redo.errmsg = lr_redo.errmsg , "========== \n" , ls_err_msg.trim()
                 END IF
              END IF
              LET lr_redo.done = lr_redo.done ,"|",ls_doing
              CALL sadzi888_06_dzye_write_by_prog(lr_redo.*)
           END IF
           
           #重產tab
           LET ls_doing="tab"
           LET ls_done = lr_redo.done CLIPPED
           IF ls_done.getIndexOf(ls_doing,1) > 0 OR   # for redo
              lr_redo.type = "F" OR                   #160706-00022
              lr_redo.status = "2" OR
              lr_redo.status = "3" 
           THEN 
              #do nothing:不做事
           ELSE
              IF lr_redo.type="G" OR lr_redo.type="X" THEN #報表元件設計資料的版次是屬於"程式"
                 LET ls_trigger = "adzp988_gen_prog : call sadzp030_tab_gen(",ls_prog,",",lr_redo.code_ver,",'',",lr_redo.identity,")"
                 DISPLAY ls_trigger
                 CALL sadzp030_tab_gen(ls_prog, lr_redo.code_ver, "", lr_redo.identity) RETURNING lb_result
              ELSE
                 LET ls_trigger = "adzp988_gen_prog : call sadzp030_tab_gen(",ls_prog,",",lr_redo.spec_ver,",'',",lr_redo.identity,")"
                 DISPLAY ls_trigger
                 CALL sadzp030_tab_gen(ls_prog, lr_redo.spec_ver, "", lr_redo.identity) RETURNING lb_result
              END IF
              IF NOT lb_result THEN 
                 LET ls_err_msg = "ERROR:程式",ls_prog,"產生tab檔出現錯誤,請查看背景執行過程","\n"
                 DISPLAY ls_err_msg
                 CALL sbuf_msg02.append(ls_err_msg)
                 LET lr_redo.status = "2" 
                 LET lr_redo.err = "tab gen ERROR" 
              END IF
              LET lr_redo.done = lr_redo.done ,"|",ls_doing
              CALL sadzi888_06_dzye_write_by_prog(lr_redo.*)
           END IF
           
           #r.c3:重產4gl
           LET ls_doing="r.c3"
           LET ls_done = lr_redo.done CLIPPED
           IF ls_done.getIndexOf(ls_doing,1) > 0 OR   # for redo
              lr_redo.type = "F" OR                   #160706-00022
              lr_redo.status = "2" OR
              lr_redo.status = "3" 
           THEN 
              #do nothing:不做事
           ELSE
              LET ls_cmd = "r.c3 ",ls_prog," ","''"," ",lr_redo.code_ver," ","1"," ",lr_redo.identity
              LET ls_trigger = "adzp988_gen_prog : ",ls_cmd
              DISPLAY ls_trigger
              CALL cl_cmdrun_openpipe("r.c3", ls_cmd, FALSE) RETURNING lb_result,ls_err_msg
              IF NOT lb_result THEN
                 LET ls_err_msg = "ERROR:程式",ls_prog,"在r.c3過程出現錯誤:",ls_err_msg,"\n"
                 DISPLAY ls_err_msg
                 CALL sbuf_msg02.append(ls_err_msg)
                 LET lr_redo.status = "2" 
                 LET lr_redo.err = "r.c3 ERROR" 
                 IF cl_null(lr_redo.errmsg) THEN
                    LET lr_redo.errmsg =  ls_err_msg.trim()
                 ELSE
                    LET lr_redo.errmsg = lr_redo.errmsg , "========== \n" , ls_err_msg.trim()
                 END IF
              END IF 
              LET lr_redo.done = lr_redo.done ,"|",ls_doing
              CALL sadzi888_06_dzye_write_by_prog(lr_redo.*)
           END IF
     
        ####取得對應的std_prog for gen tsd,tap
        ###LET ls_std_prog = sadzi888_06_get_std_prog(lr_redo.prog)
        ####gen tsd
        ###LET ls_doing="tsd"
        ###LET ls_done = lr_redo.done CLIPPED
        ###IF ls_done.getIndexOf(ls_doing,1) > 0  # 不管status都做
        ###THEN 
        ###   #do nothing:不做事
        ###ELSE
        ###   IF NOT cl_null(lr_redo.spec_ver) THEN #有版次才做
        ###      CASE 
        ###         WHEN lr_redo.type MATCHES "[MSF]" 
        ###            LET ls_trigger = "adzp988_gen_prog : call sadzp030_tsd_gen_tsd(", 
        ###                                      lr_redo.prog,",",
        ###                                      lr_redo.module,",",
        ###                                      lr_redo.spec_ver,",",
        ###                                      lr_redo.type,",",
        ###                                      ls_std_prog,",",
        ###                                      NULL,",",
        ###                                      lr_redo.identity,")"
        ###            DISPLAY ls_trigger
        ###            CALL sadzp030_tsd_gen_tsd(lr_redo.prog,
        ###                                      lr_redo.module,
        ###                                      lr_redo.spec_ver,
        ###                                      lr_redo.type,
        ###                                      ls_std_prog,#標準的prog id
        ###                                      NULL,         #標準的prog spec ver,給null即可
        ###                                      lr_redo.identity) 
        ###                 RETURNING lb_result 
        ###         WHEN lr_redo.type MATCHES "[GXBWZQ]"
        ###            LET ls_trigger = "adzp988_gen_prog : call sadzp030_tsd_gen_rsd(", 
        ###                                      lr_redo.prog,",",
        ###                                      lr_redo.module,",",
        ###                                      lr_redo.spec_ver,",",
        ###                                      lr_redo.type,",",
        ###                                      lr_redo.identity,")"
        ###            DISPLAY ls_trigger
        ###            CALL sadzp030_tsd_gen_rsd(lr_redo.prog,
        ###                                      lr_redo.module,
        ###                                      lr_redo.spec_ver,
        ###                                      lr_redo.type,
        ###                                      lr_redo.identity) 
        ###                 RETURNING lb_result 
        ###          OTHERWISE  LET lb_result = TRUE
        ###      END CASE
        ###      
        ###      IF NOT lb_result THEN
        ###         LET ls_err_msg = "ERROR:程式",ls_prog,"在產生tsd過程出現錯誤","\n"
        ###         DISPLAY ls_err_msg
        ###         CALL sbuf_msg02.append(ls_err_msg)
        ###        #LET lr_redo.status = "2"  #忽略錯誤,繼續
        ###         IF cl_null(lr_redo.errmsg) THEN
        ###            LET lr_redo.errmsg =  ls_err_msg.trim()
        ###         ELSE
        ###            LET lr_redo.errmsg = lr_redo.errmsg , "========== \n" , ls_err_msg.trim()
        ###         END IF
        ###      END IF 
        ###      LET lr_redo.done = lr_redo.done ,"|",ls_doing
        ###      CALL sadzi888_06_dzye_write_by_prog(lr_redo.*)
        ###   END IF
        ###END IF
        
        ####gen tap
        ###LET ls_doing="tap"
        ###LET ls_done = lr_redo.done CLIPPED
        ###IF ls_done.getIndexOf(ls_doing,1) > 0  # 不管status都做
        ###THEN 
        ###   #do nothing:不做事
        ###ELSE
        ###   IF NOT cl_null(lr_redo.code_ver) THEN #有版次才做
        ###      CASE 
        ###         WHEN lr_redo.type MATCHES "[MSGXBWZQ]" 
        ###            LET ls_cmd = "r.r adzp110"," ",
        ###                              lr_redo.prog," ",
        ###                              DOWNSHIFT(lr_redo.module)," ",
        ###                              lr_redo.code_ver," ",
        ###                              ls_std_prog," ", #標準的prog id
        ###                              "''"," ", #null
        ###                              lr_redo.type," ",
        ###                              lr_redo.identity
        ###            LET ls_trigger = "adzp988_gen_prog :",ls_cmd
        ###            DISPLAY ls_trigger
        ###            CALL cl_cmdrun_openpipe("r.r", ls_cmd, FALSE) RETURNING lb_result,ls_err_msg
        ###      
        ###          OTHERWISE  LET lb_result = TRUE
        ###      END CASE
        ###      
        ###      IF NOT lb_result THEN
        ###         LET ls_err_msg = "ERROR:程式",ls_prog,"在產生tap過程出現錯誤",ls_err_msg,"\n"
        ###         DISPLAY ls_err_msg
        ###         CALL sbuf_msg02.append(ls_err_msg)
        ###        #LET lr_redo.status = "2"  #忽略錯誤,繼續
        ###         IF cl_null(lr_redo.errmsg) THEN
        ###            LET lr_redo.errmsg =  ls_err_msg.trim()
        ###         ELSE
        ###            LET lr_redo.errmsg = lr_redo.errmsg , "========== \n" , ls_err_msg.trim()
        ###         END IF
        ###      END IF 
        ###      LET lr_redo.done = lr_redo.done ,"|",ls_doing
        ###      CALL sadzi888_06_dzye_write_by_prog(lr_redo.*)
        ###   END IF
        ###END IF
        END IF
     ELSE  #lb_gen=FLASE 不重產 #160223-00028

   #Begin :160620-00020 mark,搬到上面了
   ##   LET ls_doing="copy_file"
   ##   LET ls_done = lr_redo.done CLIPPED
   ##   IF ls_done.getIndexOf(ls_doing,1) > 0 OR   # for redo
   ##      lr_redo.status = "2" OR
   ##      lr_redo.status = "3"
   ##   THEN 
   ##      #do nothing:不做事
   ##   ELSE
   ##      #走copy靜態檔
   ##      LET ls_err_msg_keep = NULL
   ##      LET l_source_folder = g_tar_name, "-source"
   ##      LET l_pack_dir = FGL_GETENV(g_pack_dir_env)
   ##      LET l_source_folder_path = os.path.JOIN(os.path.JOIN(l_pack_dir,g_tar_name),l_source_folder)  # /ut/topprd/tmp/xxx/xxx-source
   ##      IF os.path.EXISTS(l_source_folder_path) THEN
   ##         LET l_module_path = FGL_GETENV(UPSHIFT(lr_redo.module))       # $AIT= /u1/topprd/erp/ait
   ##     
   ##         #4fd
   ##         IF lr_redo.type MATCHES "[SMFQ]" THEN #正向表列有4fd的所有類型
   ##            LET l_source = os.path.JOIN(l_source_folder_path,ls_prog||".4fd") # /ut/topprd/tmp/xxx/xxx-source/aiti001.4fd
   ##            LET l_dest = os.path.JOIN(os.path.JOIN(l_module_path,"4fd"),ls_prog||".4fd")  # /u1/topprd/erp/ait/4fd/aiti001.4fd
   ##            IF os.path.EXISTS(l_source) THEN
   ##               #1. 備份舊檔
   ##               CALL sadzp007_util_backfile(l_dest,g_backfile)
   ##                
   ##               #2. copy file
   ##               LET l_cmd = "cp " ,l_source ," ",l_dest
   ##               DISPLAY "l_cmd=",l_cmd
   ##               RUN l_cmd
   ##               IF STATUS THEN
   ##                  LET ls_err_msg_keep =  ls_err_msg_keep , ASCII 10 , cl_getmsg_parm("adz-00338", g_lang, l_cmd)
   ##               END IF
   ##            ELSE
   ##               LET ls_err_msg_keep =  ls_err_msg_keep , ASCII 10 , cl_getmsg_parm("adz-00339", g_lang, l_source)
   ##            END IF
   ##         END IF
   ##      
   ##         #tab
   ##         IF lr_redo.type MATCHES "[SMZBWQGX]" THEN #正向表列有tab的所有類型
   ##            IF lr_redo.type = "Q" AND lr_redo.hardcode_qry = "N" THEN
   ##               #do nothing  #非hard code走adzi210機制,不會有tab
   ##            ELSE
   ##               LET l_source = os.path.JOIN(l_source_folder_path,ls_prog||".tab")  # /ut/topprd/tmp/xxx/xxx-source/aiti001.tab
   ##               LET l_dest = os.path.JOIN(os.path.JOIN(os.path.JOIN(l_module_path,"dzx"),"tab"),ls_prog||".tab")  # /u1/topprd/erp/ait/dzx/tab/aiti001.tab
   ##               IF os.path.EXISTS(l_source) THEN
   ##                  #1. 備份舊檔
   ##                  CALL sadzp007_util_backfile(l_dest,g_backfile)
   ##               
   ##                  #2. copy file
   ##                  LET l_cmd = "cp " ,l_source ," ",l_dest
   ##                  DISPLAY "l_cmd=",l_cmd
   ##                  RUN l_cmd
   ##                  IF STATUS THEN
   ##                     LET ls_err_msg_keep =  ls_err_msg_keep , ASCII 10 , cl_getmsg_parm("adz-00338", g_lang, l_cmd)
   ##                  END IF

   ##                  #3. 產生mask程式片段
   ##                  LET l_cmd="r.r adzp155 ",DOWNSHIFT(lr_redo.module)," ",ls_prog," n"," &"
   ##                  DISPLAY "l_cmd=",l_cmd
   ##                  RUN l_cmd WITHOUT WAITING
   ##               ELSE
   ##                  LET ls_err_msg_keep =  ls_err_msg_keep , ASCII 10 , cl_getmsg_parm("adz-00339", g_lang, l_source)
   ##               END IF
   ##            END IF
   ##         END IF
   ##      
   ##         #tgl
   ##         IF lr_redo.type MATCHES "[SMZBWQGX]" THEN #正向表列有tgl的所有類型
   ##            IF lr_redo.type = "Q" AND lr_redo.hardcode_qry = "N" THEN
   ##               #do nothing
   ##               #非hard code走adzi210機制,不會有tgl
   ##            ELSE
   ##               LET l_source = os.path.JOIN(l_source_folder_path,ls_prog||".tgl")  # /ut/topprd/tmp/xxx/xxx-source/aiti001.tgl
   ##               LET l_dest = os.path.JOIN(os.path.JOIN(os.path.JOIN(l_module_path,"dzx"),"tgl"),ls_prog||".tgl")  # /u1/topprd/erp/ait/dzx/tgl/aiti001.tgl
   ##               IF os.path.EXISTS(l_source) THEN
   ##                  #1. 備份舊檔
   ##                  CALL sadzp007_util_backfile(l_dest,g_backfile)
   ##               
   ##                  #2. copy file
   ##                  LET l_cmd = "cp " ,l_source ," ",l_dest
   ##                  DISPLAY "l_cmd=",l_cmd
   ##                  RUN l_cmd
   ##                  IF STATUS THEN
   ##                     LET ls_err_msg_keep =  ls_err_msg_keep , ASCII 10 , cl_getmsg_parm("adz-00338", g_lang, l_cmd)
   ##                  END IF
   ##               ELSE
   ##                  LET ls_err_msg_keep =  ls_err_msg_keep , ASCII 10 , cl_getmsg_parm("adz-00339", g_lang, l_source)
   ##               END IF
   ##            END IF
   ##         END IF
   ##      
   ##         #4gl
   ##         IF lr_redo.type MATCHES "[SMZBWQGX]" THEN #正向表列有4gl的所有類型
   ##            LET l_source = os.path.JOIN(l_source_folder_path,ls_prog||".4gl")  # /ut/topprd/tmp/xxx/xxx-source/aiti001.4gl
   ##            LET l_dest = os.path.JOIN(os.path.JOIN(l_module_path,"4gl"),ls_prog||".4gl")  # /u1/topprd/erp/ait/4fd/aiti001.4fd
   ##            IF os.path.EXISTS(l_source) THEN
   ##               #1. 備份舊檔 
   ##               CALL sadzp007_util_backfile(l_dest,g_backfile) 

   ##               #2. copy file
   ##               LET l_cmd = "cp " ,l_source ," ",l_dest
   ##               DISPLAY "l_cmd=",l_cmd
   ##               RUN l_cmd
   ##               IF STATUS THEN
   ##                  LET ls_err_msg_keep =  ls_err_msg_keep , ASCII 10 , cl_getmsg_parm("adz-00338", g_lang, l_cmd)
   ##               END IF
   ##      
   ##               #3. 清空 程式MD5
   ##               LET ls_sql="UPDATE gzzx_t SET gzzx013 = '' WHERE gzzx001='",ls_prog,"'"
   ##               PREPARE gzzx_upd_pre1 FROM ls_sql
   ##               EXECUTE gzzx_upd_pre1
   ##               FREE gzzx_upd_pre1

   ##              ##4. qry自動維護gzzn_t
   ##              #IF lr_redo.type = "Q" THEN
   ##              #   IF sadzp210_maintain_gzzn_t(ls_prog,lr_redo.module,"insert") THEN
   ##              #     #do nothing,暫時by pass                                                                        
   ##              #   END IF
   ##              #END IF
   ##            ELSE
   ##               LET ls_err_msg_keep =  ls_err_msg_keep , ASCII 10 , cl_getmsg_parm("adz-00339", g_lang, l_source)
   ##            END IF
   ##         END IF
   ##      ELSE
   ##         LET ls_err_msg_keep =  ls_err_msg_keep , ASCII 10 ,l_source_folder_path," not exists,skip copy 4fd/4gl"
   ##      END IF

   ##      #以上做完
   ##      IF NOT cl_null(ls_err_msg_keep) THEN
   ##         LET ls_err_msg = "ERROR:",ls_err_msg_keep
   ##         DISPLAY ls_err_msg
   ##         CALL sbuf_msg02.append(ls_err_msg)
   ##         LET lr_redo.status =  "2"             
   ##         LET lr_redo.err =  "copy file ERROR" 
   ##         IF cl_null(lr_redo.errmsg) THEN
   ##            LET lr_redo.errmsg =  ls_err_msg.trim()
   ##         ELSE
   ##            LET lr_redo.errmsg = lr_redo.errmsg , "========== \n" , ls_err_msg.trim()
   ##         END IF
   ##      END IF
   ##      LET lr_redo.done = lr_redo.done ,"|",ls_doing                                                          
   ##      CALL sadzi888_06_dzye_write_by_prog(lr_redo.*)
   ##   END IF
   #End :160620-00020 mark,搬到上面了
     END IF

     #記錄此階段已完成
     LET lr_redo.stage = NULL ##此階段結束
     IF lr_redo.status = "2" OR lr_redo.status = "3" THEN
        #do nothing
     ELSE
         LET lr_redo.status = "1" 
     END IF
     CALL sadzi888_06_dzye_write_by_prog(lr_redo.*)


     #================寫 summary log ==================== 
     LET ls_str = "=====",2 SPACE ,"====================",2 SPACE ,"====", 3 SPACE , "=========================","gen prog"
     DISPLAY ls_str
     CASE lr_redo.status
        WHEN "1"   LET lf_status = "ok"
        WHEN "2"   LET lf_status = "ERROR"
        WHEN "3"   LET lf_status = "skip"
        OTHERWISE  LET lf_status = "???"
     END CASE
     LET lf_module = lr_redo.module
     LET lf_prog   = lr_redo.prog 
     LET lf_err    = lr_redo.err
     LET ls_str = lf_module , 2 SPACE ,lf_prog , 2 SPACE , lf_status , 2 SPACE , lf_err
     DISPLAY ls_str
     LET ls_str = "=====",2 SPACE ,"====================",2 SPACE ,"====", 3 SPACE , "=========================","gen prog"
     DISPLAY ls_str

   ##IF sbuf_msg02.getLength()>0 THEN #表示有錯誤
   ##   CALL sbuf_msg02.APPEND("\n ERROR")
   ##   DISPLAY "adzp988_gen_prog : ",sbuf_msg02.toString()
   ##   RETURN FALSE,sbuf_msg02.toString()
   ##END IF
   ##
   ##RETURN TRUE,NULL

   CATCH 
      #寫log
      LET ls_str = "-> adzp988_gen_prog - Catch exception-",ls_trigger , ASCII 10

      CALL sadzi888_06_err_catch(ls_trigger, ls_sql) 
      LET ls_err_msg = ls_trigger, "\n ERROR"
    ##RETURN FALSE,ls_err_msg
   END TRY
END FUNCTION
 

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 單支程式編譯
# Input parameter : p_prog
# Return code     : lr_result    結果(0:正常,1:異常)
#                 : ls_err_msg   錯誤訊息
# Date & Author   : 2014/09/16 by madey
##########################################################################
PRIVATE FUNCTION adzp988_compile_prog(ls_prog) 
   DEFINE ls_trigger  STRING,
          ls_sql      STRING,
          ls_where    STRING,
          li_idx     SMALLINT
   DEFINE ls_prog STRING,
          ls_module STRING,
          sbuf_msg03 base.StringBuffer, #收集錯誤訊息,
          lb_result BOOLEAN,
          ls_err_msg STRING,
          ls_str STRING,
          ls_tar_name STRING,
          li_i SMALLINT,
          li_cnt SMALLINT,
          li_ins_idx SMALLINT,
          ls_module_dir STRING,
          ls_working_path STRING,
          ls_cmd STRING
   DEFINE lo_DZAF_T T_DZAF_T,
          l_spec_revision LIKE dzaf_t.dzaf003,
          l_code_revision LIKE dzaf_t.dzaf004,
          l_identity LIKE dzaf_t.dzaf010
   DEFINE ls_doing       STRING,
          ls_done        STRING
   DEFINE lb_gen         BOOLEAN  #是否需要重產 #160223-00028
 

   TRY
  
     LET sbuf_msg03 = base.StringBuffer.CREATE() 

     LET lr_redo.pid = FGL_GETPID()    #抓這次adzp988的pid #20150708
     DISPLAY "pid=",lr_redo.pid #20150923
     CALL sadzi888_06_dzye_write_by_prog(lr_redo.*)

     #Begin: 160223-00028
     #預設要重產，但patch模式下:客戶家標準程式不重產只copy靜態檔,其他模式下要重產
     #若不重產,就不會重產4fd,就不會呼叫adzp168_5,4fd就不會自動被編譯,就要特別在這個階段處理
     LET lb_gen = TRUE #要重產
     IF g_run_mode = "4" AND lr_redo.identity = "s" THEN
       LET lb_gen = FALSE #不重產
     END IF
     #End: 160223-00028

     IF lb_gen THEN
        #20151123 -Begin-
        #執行主畫面的編譯 (為了42s正確)
        LET ls_doing="compile_4fd(M)"
        LET ls_done = lr_redo.done CLIPPED
        IF ls_done.getIndexOf(ls_doing,1) > 0 OR   # for redo
           lr_redo.status = "2" OR
           lr_redo.status = "3" OR
           lr_redo.type NOT MATCHES "[M]" OR  #只關注主程式
           (NOT lb_main_gen42s_flag)          #不產42s  
        THEN 
           #do nothing:不做事
        ELSE
           LET ls_module_dir = FGL_GETENV(lr_redo.module CLIPPED)
         
           #畫面編譯
           LET ls_working_path = os.Path.join(ls_module_dir,"4fd")
           LET ls_trigger = "adzp988_compile_prog : change dir to ",ls_working_path
           DISPLAY ls_trigger
          #IF cl_change_dir(ls_working_path) THEN
           IF os.Path.chdir(ls_working_path) THEN #160726-00031
              LET ls_cmd = "r.f ",ls_prog
              LET ls_trigger = "adzp988_compile_prog : ",ls_cmd
              DISPLAY ls_trigger
              CALL cl_cmdrun_openpipe("r.f", ls_cmd, FALSE) RETURNING lb_result,ls_err_msg
              IF NOT lb_result THEN
                 LET ls_err_msg = "ERROR:程式",ls_prog,"在r.f出現錯誤:",ls_err_msg,"\n"
                 DISPLAY ls_err_msg
                 CALL sbuf_msg03.append(ls_err_msg)
                 LET lr_redo.status =  "2"          
                 LET lr_redo.err =  "compile 4fd ERROR" 
                 IF cl_null(lr_redo.errmsg) THEN
                    LET lr_redo.errmsg =  ls_err_msg.trim()
                 ELSE
                    LET lr_redo.errmsg = lr_redo.errmsg , "========== \n" , ls_err_msg.trim()
                 END IF
              END IF
           ELSE
              LET ls_err_msg = "ERROR:程式",ls_prog,"切換路徑",ls_working_path,"出現錯誤,請查看背景執行過程","\n"
              DISPLAY ls_err_msg
              CALL sbuf_msg03.append(ls_err_msg)
              LET lr_redo.status =  "2"             
              LET lr_redo.err =  "change dir ERROR" 
              IF cl_null(lr_redo.errmsg) THEN
                 LET lr_redo.errmsg =  ls_err_msg.trim()
              ELSE
                 LET lr_redo.errmsg = lr_redo.errmsg , "========== \n" , ls_err_msg.trim()
              END IF
           END IF
           LET lr_redo.done = lr_redo.done ,"|",ls_doing
           CALL sadzi888_06_dzye_write_by_prog(lr_redo.*) 
        END IF
        #20151123 -End-
        
        #Begin: 160223-00028 
        #執行非hard code qry 的畫面編譯:因為透過adzp210重產時並沒有包含編譯
        LET ls_doing="compile_4fd(Q)"
        LET ls_done = lr_redo.done CLIPPED
        IF ls_done.getIndexOf(ls_doing,1) > 0 OR   # for redo
           lr_redo.status = "2" OR
           lr_redo.status = "3" OR
           lr_redo.type NOT MATCHES "[Q]" OR
           lr_redo.hardcode_qry = "Y"             #hard code qry
        THEN 
           #do nothing:不做事
        ELSE
           LET ls_module_dir = FGL_GETENV(lr_redo.module CLIPPED)
         
           #畫面編譯
           LET ls_working_path = os.Path.join(ls_module_dir,"4fd")
           LET ls_trigger = "adzp988_compile_prog : change dir to ",ls_working_path
           DISPLAY ls_trigger
          #IF cl_change_dir(ls_working_path) THEN
           IF os.Path.chdir(ls_working_path) THEN #160726-00031
              LET ls_cmd = "r.f ",ls_prog," ","tiptop"
              LET ls_trigger = "adzp988_compile_prog : ",ls_cmd
              DISPLAY ls_trigger
              CALL cl_cmdrun_openpipe("r.f", ls_cmd, FALSE) RETURNING lb_result,ls_err_msg
              IF NOT lb_result THEN
                 LET ls_err_msg = "ERROR:程式",ls_prog,"在r.f出現錯誤:",ls_err_msg,"\n"
                 DISPLAY ls_err_msg
                 CALL sbuf_msg03.append(ls_err_msg)
                 LET lr_redo.status =  "2"          
                 LET lr_redo.err =  "compile 4fd ERROR" 
                 IF cl_null(lr_redo.errmsg) THEN
                    LET lr_redo.errmsg =  ls_err_msg.trim()
                 ELSE
                    LET lr_redo.errmsg = lr_redo.errmsg , "========== \n" , ls_err_msg.trim()
                 END IF
              END IF
           ELSE
              LET ls_err_msg = "ERROR:程式",ls_prog,"切換路徑",ls_working_path,"出現錯誤,請查看背景執行過程","\n"
              DISPLAY ls_err_msg
              CALL sbuf_msg03.append(ls_err_msg)
              LET lr_redo.status =  "2"             
              LET lr_redo.err =  "change dir ERROR" 
              IF cl_null(lr_redo.errmsg) THEN
                 LET lr_redo.errmsg =  ls_err_msg.trim()
              ELSE
                 LET lr_redo.errmsg = lr_redo.errmsg , "========== \n" , ls_err_msg.trim()
              END IF
           END IF
           LET lr_redo.done = lr_redo.done ,"|",ls_doing
           CALL sadzi888_06_dzye_write_by_prog(lr_redo.*) 
        END IF
     ELSE #lb_gen = FALSE (不重產,只copy source) #160223-00028
        LET ls_doing="compile_4fd(ALL)"
        LET ls_done = lr_redo.done CLIPPED
        IF ls_done.getIndexOf(ls_doing,1) > 0 OR   # for redo
           lr_redo.status = "2" OR
           lr_redo.status = "3" OR
           (lr_redo.type NOT MATCHES "[SMFQ]")     #這幾類才有4fd
        THEN 
           #do nothing:不做事
        ELSE
           LET ls_module_dir = FGL_GETENV(lr_redo.module CLIPPED)
         
           #畫面編譯
           LET ls_working_path = os.Path.join(ls_module_dir,"4fd")
           LET ls_trigger = "adzp988_compile_prog : change dir to ",ls_working_path
           DISPLAY ls_trigger
          #IF cl_change_dir(ls_working_path) THEN
           IF os.Path.chdir(ls_working_path) THEN #160726-00031
              LET ls_cmd = "r.f ",ls_prog," ","tiptop"
              LET ls_trigger = "adzp988_compile_prog : ",ls_cmd
              DISPLAY ls_trigger
              CALL cl_cmdrun_openpipe("r.f", ls_cmd, FALSE) RETURNING lb_result,ls_err_msg
              IF NOT lb_result THEN
                 LET ls_err_msg = "ERROR:程式",ls_prog,"在r.f出現錯誤:",ls_err_msg,"\n"
                 DISPLAY ls_err_msg
                 CALL sbuf_msg03.append(ls_err_msg)
                 LET lr_redo.status =  "2"          
                 LET lr_redo.err =  "compile 4fd ERROR" 
                 IF cl_null(lr_redo.errmsg) THEN
                    LET lr_redo.errmsg =  ls_err_msg.trim()
                 ELSE
                    LET lr_redo.errmsg = lr_redo.errmsg , "========== \n" , ls_err_msg.trim()
                 END IF
              END IF
           ELSE
              LET ls_err_msg = "ERROR:程式",ls_prog,"切換路徑",ls_working_path,"出現錯誤,請查看背景執行過程","\n"
              DISPLAY ls_err_msg
              CALL sbuf_msg03.append(ls_err_msg)
              LET lr_redo.status =  "2"             
              LET lr_redo.err =  "change dir ERROR" 
              IF cl_null(lr_redo.errmsg) THEN
                 LET lr_redo.errmsg =  ls_err_msg.trim()
              ELSE
                 LET lr_redo.errmsg = lr_redo.errmsg , "========== \n" , ls_err_msg.trim()
              END IF
           END IF
           LET lr_redo.done = lr_redo.done ,"|",ls_doing
           CALL sadzi888_06_dzye_write_by_prog(lr_redo.*) 
        END IF
     END IF
        
     #執行程式的編譯
     LET ls_doing="compile_4gl"
     LET ls_done = lr_redo.done CLIPPED
     IF ls_done.getIndexOf(ls_doing,1) > 0 OR   # for redo
        lr_redo.status = "2" OR
        lr_redo.status = "3" OR
        (lr_redo.type NOT MATCHES "[SMZBWQGX]")   #這幾類才有4gl
     THEN 
        #do nothing:不做事
     ELSE
        LET ls_module_dir = FGL_GETENV(lr_redo.module CLIPPED)
      
        #程式編譯
        LET ls_working_path = os.Path.join(ls_module_dir,"4gl")
        LET ls_trigger = "adzp988_compile_prog : change dir to ",ls_working_path
        DISPLAY ls_trigger
       #IF cl_change_dir(ls_working_path) THEN
        IF os.Path.chdir(ls_working_path) THEN #160726-00031
           IF lr_redo.type="G" THEN
              #GP報表還要重產rdd
              LET ls_cmd = "$FGLRUN $FBIN/42m/gen42m ",ls_prog," rdd"
           ELSE
              LET ls_cmd = "$FGLRUN $FBIN/42m/gen42m ",ls_prog," tiptop"#20151020 
           END IF
           LET ls_trigger = "adzp988_compile_prog : ",ls_cmd
           DISPLAY ls_trigger
           CALL cl_cmdrun_openpipe("gen42m", ls_cmd, FALSE) RETURNING lb_result,ls_err_msg
           IF NOT lb_result THEN
              LET ls_err_msg = "ERROR:程式",ls_prog,"在r.c出現錯誤:",ls_err_msg,"\n"
              DISPLAY ls_err_msg
              CALL sbuf_msg03.append(ls_err_msg)
              LET lr_redo.status =  "2"          
              LET lr_redo.err =  "compile 4gl ERROR" 
              IF cl_null(lr_redo.errmsg) THEN
                 LET lr_redo.errmsg =  ls_err_msg.trim()
              ELSE
                 LET lr_redo.errmsg = lr_redo.errmsg , "========== \n" , ls_err_msg.trim()
              END IF
           END IF
        ELSE
           LET ls_err_msg = "ERROR:程式",ls_prog,"切換路徑",ls_working_path,"出現錯誤,請查看背景執行過程","\n"
           DISPLAY ls_err_msg
           CALL sbuf_msg03.append(ls_err_msg)
           LET lr_redo.status =  "2"             
           LET lr_redo.err =  "change dir ERROR" 
           IF cl_null(lr_redo.errmsg) THEN
              LET lr_redo.errmsg =  ls_err_msg.trim()
           ELSE
              LET lr_redo.errmsg = lr_redo.errmsg , "========== \n" , ls_err_msg.trim()
           END IF
        END IF
        LET lr_redo.done = lr_redo.done ,"|",ls_doing
        CALL sadzi888_06_dzye_write_by_prog(lr_redo.*) 
     END IF


     #記錄此階段已完成
     LET lr_redo.stage = NULL ##此階段結束
     IF lr_redo.status = "2" OR lr_redo.status = "3" THEN
     ELSE
        LET lr_redo.status = "1"
     END IF
     CALL sadzi888_06_dzye_write_by_prog(lr_redo.*)


     #================寫 summary log ==================== 
     LET ls_str = "=====",2 SPACE ,"====================",2 SPACE ,"====", 3 SPACE , "=========================","compile prog"
     DISPLAY ls_str
     CASE lr_redo.status
        WHEN "1"   LET lf_status = "ok"
        WHEN "2"   LET lf_status = "ERROR"
        WHEN "3"   LET lf_status = "skip"
        OTHERWISE  LET lf_status = "???"
     END CASE
     LET lf_module = lr_redo.module
     LET lf_prog   = lr_redo.prog 
     LET lf_err    = lr_redo.err
     LET ls_str = lf_module , 2 SPACE ,lf_prog , 2 SPACE , lf_status , 2 SPACE , lf_err
     DISPLAY ls_str
     LET ls_str = "=====",2 SPACE ,"====================",2 SPACE ,"====", 3 SPACE , "=========================","compile prog"
     DISPLAY ls_str

   ##IF sbuf_msg03.getLength()>0 THEN #表示有錯誤
   ##   CALL sbuf_msg03.APPEND("\n ERROR")
   ##   DISPLAY "adzp988_compile_prog : ",sbuf_msg03.toString()
   ##   RETURN FALSE,sbuf_msg03.toString()
   ##END IF
   ##
   ##RETURN TRUE,NULL

   CATCH 
      #寫log
      LET ls_str = "-> adzp988_compile_prog - Catch exception-",ls_trigger , ASCII 10

      CALL sadzi888_06_err_catch(ls_trigger, ls_sql) 
      LET ls_err_msg = ls_trigger, "\n ERROR"
    ##RETURN FALSE,ls_err_msg
   END TRY
END FUNCTION
 

##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 單支程式連結
# Input parameter : p_prog
# Return code     : lr_result    結果(0:正常,1:異常)
#                 : ls_err_msg   錯誤訊息
# Date & Author   : 2014/09/09 by madey
##########################################################################
PUBLIC FUNCTION adzp988_link_prog(ls_prog) 
   DEFINE ls_trigger  STRING,
          ls_sql      STRING,
          ls_where    STRING,
          li_idx     SMALLINT
   DEFINE ls_prog STRING,
          ls_module STRING,
          sbuf_msg04 base.StringBuffer, #收集錯誤訊息,
          lb_result BOOLEAN,
          ls_err_msg STRING,
          ls_str STRING,
          ls_tar_name STRING,
          li_i SMALLINT,
          li_cnt SMALLINT,
          li_ins_idx SMALLINT,
          ls_module_dir STRING,
          ls_working_path STRING,
          ls_cmd STRING
   DEFINE ls_doing       STRING,
          ls_done        STRING

   TRY

     LET sbuf_msg04 = base.StringBuffer.CREATE() 

     LET lr_redo.pid = FGL_GETPID()    #抓這次adzp988的pid #20150708
     DISPLAY "pid=",lr_redo.pid #20150923
     CALL sadzi888_06_dzye_write_by_prog(lr_redo.*)

     #執行程式的link
     LET ls_doing="link"
     LET ls_done = lr_redo.done CLIPPED
     IF ls_done.getIndexOf(ls_doing,1) > 0 OR   # for redo
        lr_redo.status = "2" OR
        lr_redo.status = "3" OR
       (lr_redo.type NOT MATCHES "[MZ]")  #只有主程式需要真正link
     THEN 
        #do nothing:不做事
     ELSE 
        LET ls_cmd = "r.l ",ls_prog
        LET ls_trigger = "adzp988_link_prog : ",ls_cmd
        DISPLAY ls_trigger
        CALL cl_cmdrun_openpipe("r.l", ls_cmd, FALSE) RETURNING lb_result,ls_err_msg
        IF NOT lb_result THEN
           LET ls_err_msg = "ERROR:程式",ls_prog,"在r.l出現錯誤:",ls_err_msg,"\n"
           CALL sbuf_msg04.append(ls_err_msg)
           LET lr_redo.status =  "2"       
           LET lr_redo.err =  "link 4gl ERROR" 
           IF cl_null(lr_redo.errmsg) THEN
              LET lr_redo.errmsg =  ls_err_msg.trim()
           ELSE
              LET lr_redo.errmsg = lr_redo.errmsg , "========== \n" , ls_err_msg.trim()
           END IF
        END IF
        LET lr_redo.done = lr_redo.done ,"|",ls_doing
        CALL sadzi888_06_dzye_write_by_prog(lr_redo.*)
     END IF 

     #記錄此階段已完成
     LET lr_redo.stage = NULL #此階段結束
     IF lr_redo.status = "2" OR lr_redo.status = "3" THEN
     ELSE
        LET lr_redo.status = "1" 
     END IF
     CALL sadzi888_06_dzye_write_by_prog(lr_redo.*)


     #================寫 summary log ==================== 
     LET ls_str = "=====",2 SPACE ,"====================",2 SPACE ,"====", 3 SPACE , "=========================","link prog"
     DISPLAY ls_str
     CASE lr_redo.status
        WHEN "1"   LET lf_status = "ok"
        WHEN "2"   LET lf_status = "ERROR"
        WHEN "3"   LET lf_status = "skip"
        OTHERWISE  LET lf_status = "???"
     END CASE
     LET lf_module = lr_redo.module
     LET lf_prog   = lr_redo.prog 
     LET lf_err    = lr_redo.err
     LET ls_str = lf_module , 2 SPACE ,lf_prog , 2 SPACE , lf_status , 2 SPACE , lf_err
     DISPLAY ls_str
     LET ls_str = "=====",2 SPACE ,"====================",2 SPACE ,"====", 3 SPACE , "=========================","link prog"
     DISPLAY ls_str

   ##IF sbuf_msg04.getLength()>0 THEN #表示有錯誤
   ##   CALL sbuf_msg04.APPEND("\n ERROR")
   ##   DISPLAY "adzp988_link_prog : ",sbuf_msg04.toString()
   ##   RETURN FALSE,sbuf_msg04.toString()
   ##END IF
   ##
   ##RETURN TRUE,NULL

   CATCH 
      #寫log
      LET ls_str = "-> adzp988_link_prog - Catch exception-",ls_trigger , ASCII 10

      CALL sadzi888_06_err_catch(ls_trigger, ls_sql) 
      LET ls_err_msg = ls_trigger, "\n ERROR" 
    ##RETURN FALSE,ls_err_msg
   END TRY
END FUNCTION

