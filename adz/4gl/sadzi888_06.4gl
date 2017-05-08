#+ 程式版本......: T6 Version 1.00.00 Build-0001 at 14/07/11
#
#+ 程式代碼......: sadzi888_06
#+ 設計人員......: Hiko
# Prog. Version..: 'T6-12.01.21(00000)'     #
#
# Program name   : sadzi888.4gl
# Description    : 匯入設計資料之後該做的事情
# Memo           : 2014/07/21 by madey : 修正bug
#                  2014/07/24 by madey :1重大錯誤時DISPLAY ERROR固定為BREAK_ERROR
#                                       2修正bug
#                  2014/07/28 by madey :sadzi888_06_after_imp()增加參數:p_kind
#                  2014/07/29 by madey :1.調整未註冊時的錯誤訊息
#                                       2.BREAK_ERROR改放到字串最後
#                  2014/07/30 by madey :1.記錄log 
#                                       2.過濾簽出中的程式不允許往下執行 (just for patch)
#                  2014/07/31 by madey :1.記錄log
#                  2014/08/08 by madey :r.c及r.l錯誤訊息導出
#                  2014/08/11 by madey :booking檢核先off
#                  2014/08/19 by madey :summary匯整為一份
#                  2014/08/21 by madey :依程式清單自動簽出,但只做帳號toptsd簽出的(just for patch)
#                  2014/08/26 by madey :1.將sadzi444_01_chk_spec_type換成sadzp060_2_chk_spec_type 
#                                       2.4rp搬移拉到編譯/連結後再執行,且增加summary結果
#                  2014/08/29 by madey :1.增加呼叫sadzi888_05_4rpupd
#                                       2.顯示執行中的筆數
#                  2014/09/03 by madey :redo版
#                  2014/09/09 by madey :多執行緒版
#                  2014/09/12 by madey :增加頭尾時間統計
#                  2014/09/16 by madey :將組合程式及編譯程式拆開
#                  2014/09/26 by madey :增加單獨導出log
#                  2014/10/13 by madey :summary改放string buffer,並由呼叫端將summary DISPLAY及寫到log
#                  2014/10/24 by madey :1.增加merge功能
#                                       2.改變程式架構
#                  2014/12/08 by madey :調整強制簽出dzlm_t規則sadzi888_06_check_in()
#                  2014/12/09 by madey :read dzyd_t時也要讀取dzyd018
#                  2014/12/25 by madey :X類增加呼叫sadzp188_1()
#                  2015/03/18 by madey :p_kind不使用了,改抓global變數g_run_mode
#                  2015/03/26 by madey :1.更改adzp988 run log檔名
#                                       2.強制簽入dzlm_t，由環境變數TOPCHKOUT(g_top_checkout)決定
#                                       3.g_run_mode=4(patch)時,併發數參考cpu core數，其餘解包模式的併發數為1
#                                       4.g_run_mode=6(需求單解包or小型管解包)時,增加呼叫s_azzi900_upd_gzza011因應標準轉客製的情境
#                  2015/04/07 by madey :1.有錯誤時回傳BREAK_ERROR
#                                       2.若status=N就不觸發gen_prog
#                  2015/04/24 by madey :compile階段遇到一些lib時不走併發,否則adzp988本身可能會因為用到而crash
#                  2015/05/12 by madey :調整各階段寫入dzyd_t的時機點(提早)
#                  2015/05/18 by madey :透過g_gen42s_flag控制是否要執行多語言產生
#                  2015/05/20 by madey :1.程式清單取得:原本抓temp table(adzi888_ddata),g_run_mode=4改抓(tmp_dzye_t)
#                                       2.增加dzye_t,取代dzyd_t
#                                       3 支持hardcode Q類
#                  2015/06/15 by madey :設計資料匯出入增加控卡規則 
#                  2015/06/22 by madey :客戶環境下，將sa規格資料清除
#                  2015/07/08 by madey :merge=N時，仍然要寫入dzap_t,這樣adzp050的手動merge功能才能開啟
#                  2015/08/06 by madey :1.調整簽入規則,標準環境簽入時，刪除版次>來源版次的資料
#                                       2.若為adzp990匯入時,有錯誤時回傳false,讓前端可以顯示錯誤窗
#                  2015/08/17 by madey :1.sadzi888_06_before_imp強制將g_bgjob設成Y,避免一些彈窗無法出來,例如cl_ask
#                                       2.sadzi888_06_before_imp的free style提示改成只有M,S類才提示
#                  2015/09/23 by madey :1.設計資料匯出入功能:匯入前，自動備份舊資料
#                                       2.調整cpu core規則:g_run_mode=2(產中過單)時,固定core=3
#                                       3.編譯4gl時,遇到azzp188不走併發
#                  2015/10/20 by madey :調整topstd處理dzlm_t規則
#                  2015/12/20 by madey :調整設計資料匯入功能,卡控放行以下條件:c to s 及 目標版次>來源版次
#                  20160223 160223-00028 by madey :patch優化專案
#                                        0.此版本很多既有functoin內容都大改，這些沒有特別註解修改處
#                                        1.將qry產生納入機制
#                                        2.將merge行為獨立為一階段
#                                        3.S類改到第一階段處理(比照元件),這樣r.l模組就不用做2次
#                                        4.add function sadzi888_06_get_tool_ver()
#                  20160412 160407-00009 by madey :設計器匯出入:在行業平台下若匯入標準程式時,當已被簽出不能卡住,且匯入後不能強制簽入(因為dzlm共用)
#                  20160510 160510-00003 by madey :修正bug:Q類只有hardcode qry才可以跑進merge
#                  20160513 160513-00047 by madey :修正bug:在adzi888設定qry且選刪除時，解包應該避開
#                  20160620 160620-00020 by madey :設計資料匯出入模式:匯入時，增加串diff工具
#                  20160816 160816-00047 by madey :patch模式下支持快速更新:程式不組合、不編譯、不連結
#                  20161011 161011-00036 by madey :1.調整link 42x的規則:有客製模組時連同標準模組也做
#                                                  2.客戶過單模式下: 是否強制更新客製註記的規則調整
#                  20161117 161117-00029 by madey :設計器匯出入:匯入前檢查若沒有註冊資料則擋下來
#                  20161128 161128-00074 by madey :工作目錄不寫死TEMPDIR而改吃g_pack_dir_env
#                  20161130 161103-00029#6 by madey :patch模式下，標準程式維持強制簽入,客製非元件不強制簽入
#                  20161201 161130-00069 by madey :patch模式下，標準程式若有被topstd修改過，則要重產
#                  20170208 170208-00008 by madey :patch模式下，標準平台要ins dzbj_t資料(行業也要,但先預留)
#                  20170208 170208-00011 by madey :設計器匯出入模式:匯入時,g_tar_name調整規則


IMPORT util
IMPORT os
IMPORT xml

SCHEMA ds

GLOBALS "../../cfg/top_global.inc"

DEFINE g_auto_merge STRING #是否啟動自動merge (Y/N)
DEFINE g_total_wait SMALLINT  #已等待時間
DEFINE gi_processor LIKE type_t.num5
DEFINE g_tar_name   STRING
DEFINE g_kind       STRING
DEFINE gb_break_error BOOLEAN          #是否有發生錯誤
DEFINE gsbuf_break_error base.StringBuffer  #錯誤summary


&include "../4gl/sadzp000_type.inc"
&include "../4gl/sadzp200_cnst.inc"
&include "../4gl/sadzi888_06_type.inc"
&include "../4gl/adzi888_global.inc"


PUBLIC FUNCTION sadzi888_06_after_imp(p_kind)
   DEFINE p_kind LIKE type_t.chr1  #種類 2:一般過單  4:patch過單  (對照adzp999解包參數2/4) 
   DEFINE l_ddata_d type_g_ddata_d  #程式註冊資料匯出單身-設計資料
   DEFINE l_tmp_dzye type_g_dzye_d  #程式清單
   DEFINE ls_trigger STRING,
          ls_sql     STRING,
          ls_where   STRING
   DEFINE la_ddata         DYNAMIC ARRAY OF T_REDO,
          la_part1_prog    DYNAMIC ARRAY OF T_REDO,
          la_part2_prog    DYNAMIC ARRAY OF T_REDO,
          la_4rp_list      DYNAMIC ARRAY OF T_REDO,#報表清單(G)
          la_xg_list       DYNAMIC ARRAY OF T_REDO #報表清單(X)
   DEFINE ls_prog STRING,
          lb_result BOOLEAN,
          ls_result STRING,
          ls_check_in_result   STRING,
          ls_upd_sa_spec_data_result   STRING,
          ls_part1_prog_result STRING,
          ls_part2_prog_result STRING,
          ls_4rp_result        STRING,
          ls_xg_result         STRING,
          ls_err_msg           STRING,
          ls_str STRING,
          li_i SMALLINT,
          li_cnt SMALLINT, 
          ls_cmd STRING
   DEFINE l_booking_flag LIKE type_t.chr1   #是否已簽出
   DEFINE sbuf_summary01 base.StringBuffer  #收集summary
   DEFINE l_merge_flag LIKE type_t.chr1   
   DEFINE l_chr        LIKE type_t.chr1 
   DEFINE lr_time      RECORD
              total_s          DATETIME YEAR TO SECOND,#start #只定義到SECOND而不是FRACTION的原因是:cl_get_current回傳值只到SECOND
              total_e          DATETIME YEAR TO SECOND,#end
              total_r          INTERVAL DAY  TO SECOND,#remainder
              init_s           DATETIME YEAR TO SECOND,
              init_e           DATETIME YEAR TO SECOND,
              init_r           INTERVAL DAY  TO SECOND,
              merge_s          DATETIME YEAR TO SECOND,
              merge_e          DATETIME YEAR TO SECOND,
              merge_r          INTERVAL DAY  TO SECOND,
              gen_s            DATETIME YEAR TO SECOND,
              gen_e            DATETIME YEAR TO SECOND,
              gen_r            INTERVAL DAY  TO SECOND,
              compile_part1_s  DATETIME YEAR TO SECOND,
              compile_part1_e  DATETIME YEAR TO SECOND,
              compile_part1_r  INTERVAL DAY  TO SECOND,
              compile_part2_s  DATETIME YEAR TO SECOND,
              compile_part2_e  DATETIME YEAR TO SECOND,
              compile_part2_r  INTERVAL DAY  TO SECOND,
              l42x_s           DATETIME YEAR TO SECOND,
              l42x_e           DATETIME YEAR TO SECOND,
              l42x_r           INTERVAL DAY  TO SECOND,
              link_s           DATETIME YEAR TO SECOND,
              link_e           DATETIME YEAR TO SECOND,
              link_r           INTERVAL DAY  TO SECOND,
              others_r         INTERVAL DAY  TO SECOND #其他
                      END RECORD
   DEFINE l_master_m        type_g_master_m  #程式註冊資料匯出主檔
   DEFINE ls_ins_dzbj_result   BOOLEAN #170208-00008


   TRY
      LET gb_break_error = FALSE

      LET g_kind = p_kind CLIPPED
   
      IF cl_null(g_sys_dgenv) THEN
         LET g_sys_dgenv=FGL_GETENV("DGENV")                                                                              
         IF cl_null(g_sys_dgenv) THEN LET g_sys_dgenv= g_dgenv_c END IF
      END IF


      LET ls_trigger = "sadzi888_06_after_imp : 取得tar name:from temp table(adzi888_master)"
      DISPLAY ls_trigger
      SELECT COUNT(*) INTO li_cnt FROM adzi888_master
      IF li_cnt <> 1 THEN
         LET ls_err_msg = "BREAK_ERROR-SELECT adzi888_master cnt:", cl_getmsg("adz-00335", g_lang)
         RETURN FALSE, ls_err_msg
      END IF
     #SELECT master002 INTO l_master_m.master002 FROM adzi888_master
      SELECT master002,master003 INTO l_master_m.master002,l_master_m.master003 FROM adzi888_master #170208-00011
      IF cl_null(l_master_m.master002) THEN
         LET ls_err_msg = "BREAK_ERROR-SELECT adzi888_master fail ,master002 IS NULL!!"
         RETURN FALSE, ls_err_msg
      ELSE
         LET g_tar_name = l_master_m.master002 CLIPPED
         #Begin: 170208-00011
         IF g_run_mode = "b" THEN
            LET g_tar_name = sadzi888_01_get_folder_name(l_master_m.master002, l_master_m.master003)
         END IF
         #End: 170208-00011
      END IF
  
      #寫log
      LET lr_time.total_s = cl_get_current()

      LET sbuf_summary01    = base.StringBuffer.create()
      LET gsbuf_break_error = base.StringBuffer.create()

      #init
      CALL la_ddata.CLEAR() 

      #暫時用來判斷要不要接關 
      LET ls_str = ARG_VAL(4)  
      IF ls_str.trim() = "after_imp_redo" THEN
         #不清除redo記錄:取回之前執行結果
         CALL sadzi888_06_dzye_read(g_tar_name) RETURNING ls_err_msg,la_ddata
      ELSE
         #清除redo記錄
         CALL sadzi888_06_dzye_clear(g_tar_name)

        #Begin: 160223-00028
         #先取開窗adzi210清單
         LET ls_trigger = "sadzi888_06_after_imp : 取得開窗(adzi210)清單:from temp table(adzi888_ddata)"
         DISPLAY ls_trigger
         CALL sadzi888_01_log_file_write(ls_trigger)
         LET ls_sql = "SELECT DISTINCT ddata006",
                       " FROM adzi888_ddata",
                      " WHERE ddata005 = 'adzi210'",
                      "   AND (ddata004 = '1' OR ddata004 = '2')" #排除刪除的 160513-00047 add
         PREPARE ddata_prep FROM ls_sql
         DECLARE ddata_curs CURSOR FOR ddata_prep
         LET li_i = 0 
         FOREACH ddata_curs INTO l_ddata_d.ddata006
            LET li_i = la_ddata.getLength() + 1
            LET la_ddata[li_i].tar_name        = g_tar_name
            LET la_ddata[li_i].prog            = l_ddata_d.ddata006 CLIPPED
            LET la_ddata[li_i].type            = "Q"
         END FOREACH 
        #End: 160223-00028

         #取得程式清單
         LET ls_trigger = "sadzi888_06_after_imp : 取得程式清單:from temp table(tmp_dzye_t)"
         DISPLAY ls_trigger
         CALL sadzi888_01_log_file_write(ls_trigger)
         LET ls_sql = "SELECT * ",
                       " FROM tmp_dzye_t "
         PREPARE tmp_dzye_t_prep FROM ls_sql
         DECLARE tmp_dzye_t_curs CURSOR FOR tmp_dzye_t_prep
         LET li_i = 0 
         FOREACH tmp_dzye_t_curs INTO l_tmp_dzye.*
            LET li_i = la_ddata.getLength() + 1
            LET la_ddata[li_i].tar_name        = g_tar_name
            LET la_ddata[li_i].prog            = l_tmp_dzye.dzye002 CLIPPED
            LET la_ddata[li_i].type            = l_tmp_dzye.dzye003 CLIPPED
          ##LET la_ddata[li_i].module          = l_tmp_dzye.dzye005 CLIPPED
          ##LET la_ddata[li_i].ver             = l_tmp_dzye.dzye009 CLIPPED
          ##LET la_ddata[li_i].spec_ver        = l_tmp_dzye.dzye010 CLIPPED
          ##LET la_ddata[li_i].code_ver        = l_tmp_dzye.dzye011 CLIPPED
          ##LET la_ddata[li_i].identity        = l_tmp_dzye.dzye012 CLIPPED
            LET la_ddata[li_i].source_ver      = l_tmp_dzye.dzye014 CLIPPED
            LET la_ddata[li_i].merge           = l_tmp_dzye.dzye015 CLIPPED
            LET la_ddata[li_i].source_identity = l_tmp_dzye.dzye019 CLIPPED
            LET la_ddata[li_i].source_spec_ver = l_tmp_dzye.dzye020 CLIPPED
            LET la_ddata[li_i].source_code_ver = l_tmp_dzye.dzye021 CLIPPED
            LET la_ddata[li_i].checkout        = l_tmp_dzye.dzye022 CLIPPED
            LET la_ddata[li_i].status          = l_tmp_dzye.dzye023 CLIPPED
         END FOREACH
         
      END IF

      LET g_auto_merge = 'N' #先給固定 暫時用來判斷要不要啟動自動merge機制
      LET g_auto_merge = g_auto_merge.toUpperCase()
      IF cl_null(g_auto_merge) OR g_auto_merge NOT MATCHES "[YN]" THEN
         LET g_auto_merge = "N"
      END IF


      #r.f時是否啟動多語言產生機制,由前端給值,null時給TRUE
      IF cl_null(g_gen42s_flag) THEN LET g_gen42s_flag = TRUE END IF

      #Begin: 160816-00047
      #是否啟動快速更新,預設N,由前端給值
      IF cl_null(g_quick_patch) THEN 
         LET g_quick_patch = "N" 
      END IF
      DISPLAY "g_quick_patch=",g_quick_patch
      #End: 160816-00047

      #取得cpu core數，for多執行緒使用
      LET gi_processor = sadzi888_06_get_core_of_cpu()

      IF la_ddata.getLength() > 0 THEN
         #init prog
         LET lr_time.init_s = cl_get_current() 
         CALL sadzi888_06_init_prog(la_ddata) RETURNING la_ddata
         LET lr_time.init_e = cl_get_current() 

         #強制簽入dzlm
         #因為這個function需要判斷目標程式的identity,所以必須放在sadzi888_06_init_prog()取完版本資訊後才做.
         CALL sadzi888_06_check_in(la_ddata) RETURNING ls_check_in_result
         
         #Begin: 160223-00028
         #merge prog
         LET lr_time.merge_s = cl_get_current() 
         CALL sadzi888_06_merge_prog(la_ddata) RETURNING la_ddata
         LET lr_time.merge_e = cl_get_current() 
         #End: 160223-00028

         #gen prog
         LET lr_time.gen_s = cl_get_current() 
         CALL sadzi888_06_gen_prog(la_ddata) RETURNING la_ddata
         LET lr_time.gen_e = cl_get_current() 

        #第1階段part1
         #compile prog:針對以下類別
         LET lr_time.compile_part1_s = cl_get_current() 
         LET gb_part1 = TRUE #160223-00028
        #CALL sadzi888_06_compile_prog(la_ddata,"SBGXWQ") RETURNING la_ddata
         CALL sadzi888_06_compile_prog(la_ddata,"SFBGXWQ") RETURNING la_ddata #160223-00028 此階段邏輯有增加在重產模式下編譯4fd,所以F類要納入，不然沒機會做到
         LET lr_time.compile_part1_e = cl_get_current() 

         #gen 42x:針對非主程式
         LET lr_time.l42x_s = cl_get_current() 
         CALL sadzi888_06_42x(la_ddata) RETURNING la_ddata
         LET lr_time.l42x_e = cl_get_current() 
        
         #統計結果:寫 summary log:針對以下類別
         CALL la_part1_prog.CLEAR()
         CALL sadzi888_06_filter(la_ddata,"SFBGXWQL@") RETURNING la_part1_prog
         CALL sadzi888_06_summary(la_part1_prog) RETURNING ls_part1_prog_result
         IF NOT cl_null(ls_part1_prog_result) THEN
            LET ls_str = "summary-part1:", ASCII 10,
                         "=====",2 SPACE ,"====================",2 SPACE ,"====",2 SPACE ,"====", 2 SPACE ,"====", 3 SPACE , "=========================",ASCII 10,
                         "module",1 SPACE ,"prog                ",2 SPACE ,"cust",2 SPACE ,"merge", 1 SPACE ,"stat", 3 SPACE , "fail                     "
            CALL sadzi888_01_log_file_write(ls_str)
            DISPLAY ls_str,ASCII 10 , ls_part1_prog_result
            CALL sadzi888_01_log_file_write(ls_part1_prog_result)
          ###PROMPT 訊息
          ##WHILE TRUE
          ##   PROMPT ls_part1_prog_result CLIPPED FOR CHAR l_chr
          ##       ON IDLE  0
          ##          DISPLAY 'aaa'
          ##   
          ##   END PROMPT
          ##
          ##   IF INT_FLAG THEN  
          ##      LET INT_FLAG = 0
          ##      LET l_chr = "N"
          ##   END IF
          ##   IF l_chr MATCHES "[Yy]" THEN EXIT WHILE  END IF
          ##END WHILE
         END IF
        #第1階段part1

        #第2階段part2
         #compile prog:針對以下類別
         LET lr_time.compile_part2_s = cl_get_current() 
         LET gb_part1 = FALSE #160223-00028
         CALL sadzi888_06_compile_prog(la_ddata,"MZ") RETURNING la_ddata
         LET lr_time.compile_part2_e = cl_get_current() 

         #link prog:針對主程式
         LET lr_time.link_s = cl_get_current() 
         CALL sadzi888_06_link_prog(la_ddata) RETURNING la_ddata
         LET lr_time.link_e = cl_get_current() 

         #統計結果:寫 summary log:針對主程式
         CALL la_part2_prog.CLEAR()
         CALL sadzi888_06_filter(la_ddata,"MZ") RETURNING la_part2_prog
         CALL sadzi888_06_summary(la_part2_prog) RETURNING ls_part2_prog_result
        #第2階段part2
        
         #報表特殊事項:(for G類)
         #收集G類for後續 4rp相關特殊處理
         CALL la_4rp_list.CLEAR()
         CALL sadzi888_06_filter(la_ddata,"G") RETURNING la_4rp_list
         CALL sadzi888_06_4rp(la_4rp_list) RETURNING ls_4rp_result

         #報表特殊事項:(for X類)
         #收集X類for後續相關特殊處理
         CALL la_xg_list.CLEAR()
         CALL sadzi888_06_filter(la_ddata,"X") RETURNING la_xg_list
         CALL sadzi888_06_xg(la_xg_list) RETURNING ls_xg_result

         #客戶環境下,強制將標準的sa規格描述清除
         IF g_sys_dgenv = g_dgenv_s THEN
            #標準環境不做
         ELSE
           CALL sadzi888_06_upd_sa_spec_data(la_ddata) RETURNING lb_result,ls_upd_sa_spec_data_result
           IF NOT lb_result THEN
              DISPLAY ls_upd_sa_spec_data_result
           END IF
         END IF

         #Begin: 170208-00008
         #patch模式下要寫dzbj_t資料
         IF g_run_mode = "4" THEN
            CALL sadzi888_06_ins_dzbj() RETURNING lb_result,ls_ins_dzbj_result 
            IF NOT lb_result THEN
               DISPLAY "ERROR:",ls_ins_dzbj_result
            END IF
         END IF
         #End: 170208-00008
         

         #統計起迄時間
         LET lr_time.total_e = cl_get_current()  

         LET ls_str = "-> sadzi888_06_after_imp -time:"
         DISPLAY ls_str
         CALL sadzi888_01_log_file_write(ls_str)

         #total
         LET lr_time.total_r = lr_time.total_e - lr_time.total_s
         LET ls_str = "total   time:",lr_time.total_r , 1 SPACE ,lr_time.total_s , 1 SPACE ,lr_time.total_e
         DISPLAY ls_str
         CALL sadzi888_01_log_file_write(ls_str)

         #init
         LET lr_time.init_r = lr_time.init_e - lr_time.init_s 
         LET ls_str = "init    time:",lr_time.init_r , 1 SPACE ,lr_time.init_s , 1 SPACE ,lr_time.init_e
         DISPLAY ls_str
         CALL sadzi888_01_log_file_write(ls_str)

         #merge
         LET lr_time.merge_r = lr_time.merge_e - lr_time.merge_s
         LET ls_str = "merge   time:",lr_time.merge_r , 1 SPACE ,lr_time.merge_s , 1 SPACE ,lr_time.merge_e
         DISPLAY ls_str
         CALL sadzi888_01_log_file_write(ls_str)

         #gen
         LET lr_time.gen_r = lr_time.gen_e - lr_time.gen_s
         LET ls_str = "gen     time:",lr_time.gen_r , 1 SPACE ,lr_time.gen_s , 1 SPACE ,lr_time.gen_e
         DISPLAY ls_str
         CALL sadzi888_01_log_file_write(ls_str)

         #compile
         LET lr_time.compile_part1_r = lr_time.compile_part1_e - lr_time.compile_part1_s 
         LET lr_time.compile_part2_r = lr_time.compile_part2_e - lr_time.compile_part2_s 
         LET ls_str = "compile time:", lr_time.compile_part1_r + lr_time.compile_part2_r,
                                      1 SPACE ,lr_time.compile_part1_s , 1 SPACE ,lr_time.compile_part1_e ,
                                      1 SPACE ,lr_time.compile_part2_s , 1 SPACE ,lr_time.compile_part2_e
         DISPLAY ls_str
         CALL sadzi888_01_log_file_write(ls_str)

         #42x
         LET lr_time.l42x_r = lr_time.l42x_e - lr_time.l42x_s
         LET ls_str = "42x     time:",lr_time.l42x_r , 1 SPACE ,lr_time.l42x_s , 1 SPACE ,lr_time.l42x_e
         DISPLAY ls_str
         CALL sadzi888_01_log_file_write(ls_str)

         #link
         LET lr_time.link_r = lr_time.link_e - lr_time.link_s 
         LET ls_str = "link    time:",lr_time.link_r , 1 SPACE ,lr_time.link_s , 1 SPACE ,lr_time.link_e
         DISPLAY ls_str
         CALL sadzi888_01_log_file_write(ls_str)

         #others
         LET lr_time.others_r =  lr_time.total_r           - 
                                 lr_time.init_r            - 
                                 lr_time.merge_r           - 
                                 lr_time.gen_r             - 
                                 lr_time.compile_part1_r   -
                                 lr_time.compile_part2_r   -
                                 lr_time.l42x_r      -
                                 lr_time.link_r
         LET ls_str = "others  time:", lr_time.others_r
         DISPLAY ls_str
         CALL sadzi888_01_log_file_write(ls_str)

         #彙總所有summary並replay給前端
         IF ls_part1_prog_result.getLength() > 0 THEN CALL sbuf_summary01.APPEND(ls_part1_prog_result) END IF
         IF ls_part2_prog_result.getLength() > 0 THEN CALL sbuf_summary01.APPEND(ls_part2_prog_result) END IF
         IF ls_check_in_result.getLength() > 0   THEN CALL sbuf_summary01.APPEND(ls_check_in_result)   END IF
         IF ls_4rp_result.getLength() > 0        THEN CALL sbuf_summary01.APPEND(ls_4rp_result) END IF
         IF ls_xg_result.getLength() > 0         THEN CALL sbuf_summary01.APPEND(ls_xg_result) END IF

         #PROMPT 訊息
         LET ls_str = ASCII 10,
                      "summary-all:", ASCII 10,
                      "=====",2 SPACE ,"====================",2 SPACE ,"====",2 SPACE ,"====", 2 SPACE ,"====", 3 SPACE , "=========================",ASCII 10,
                      "module",1 SPACE ,"prog                ",2 SPACE ,"cust",2 SPACE ,"merge", 1 SPACE ,"stat", 3 SPACE , "fail                     ",ASCII 10
         IF sbuf_summary01.getLength() > 0 THEN
            CALL sbuf_summary01.insertat(1,ls_str)
         ELSE
            CALL sbuf_summary01.APPEND(ls_str)
         END IF
       ##DISPLAY ls_str
       ##CALL sadzi888_01_log_file_write(ls_str)

       ##DISPLAY sbuf_summary01.toString()
       ##CALL sadzi888_01_log_file_write(sbuf_summary01.toString())
       ##CALL sbuf_summary01.insertAt(1,"請確認後按Y繼續\n")
       ##WHILE TRUE
       ##   PROMPT sbuf_summary01.toString() CLIPPED FOR CHAR l_chr
       ##       ON IDLE  0
       ##          DISPLAY 'aaa'
       ##   
       ##   END PROMPT
       ##
       ##   IF INT_FLAG THEN  
       ##      LET INT_FLAG = 0
       ##      LET l_chr = "N"
       ##   END IF
       ##   IF l_chr MATCHES "[Yy]" THEN EXIT WHILE  END IF
       ##END WHILE
         
         IF gb_break_error THEN  
            FOR li_i = 1 TO la_ddata.getLength()
              IF la_ddata[li_i].status = '2' OR la_ddata[li_i].status = '3'  THEN #有錯or被skip, 顯示錯誤訊息
                CALL gsbuf_break_error.APPEND(la_ddata[li_i].errmsg)
              END IF
            END FOR
            LET ls_str=ASCII 10, "summary-ERROR:",ASCII 10
            CALL gsbuf_break_error.INSERTAT(1,ls_str)
            LET ls_str="BREAK_ERROR",ASCII 10
            CALL gsbuf_break_error.APPEND(ls_str)
            CALL sbuf_summary01.APPEND(gsbuf_break_error.toString())
         END IF

         #20150806 -Modify-
         #RETURN TRUE,sbuf_summary01.toString()
        #DISPLAY sbuf_summary01.toString()         #for新版過單調整,不影響現行
         IF g_run_mode="b" AND gb_break_error THEN #設計資料匯出入
            RETURN FALSE,sbuf_summary01.toString()
         ELSE
            RETURN TRUE,sbuf_summary01.toString()
         END IF
         #20150806 -Modify-

      ELSE
         RETURN TRUE,"nothing to do!"
      END IF

   CATCH 
      #寫log
      LET ls_str = "-> sadzi888_06_after_imp - Catch exception-",ls_trigger , ASCII 10
      CALL sadzi888_01_log_file_write(ls_str)

      CALL sadzi888_06_err_catch(ls_trigger, ls_sql) 
      LET ls_err_msg = ls_trigger, "\n BREAK_ERROR"
      RETURN FALSE,ls_err_msg
   END TRY
END FUNCTION



##########################################################################
# Access Modifier : PUBLIC
# Descriptions    : 擷取錯誤訊息.
# Input parameter : p_trigger 執行的顯現資訊
#                   p_sql 執行的SQL
# Return code     : void
# Date & Author   : 2014/07/11 by Hiko
##########################################################################
PUBLIC FUNCTION sadzi888_06_err_catch(p_trigger, p_sql)
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
# Date & Author   : 2014/07/30 by madey
##########################################################################
PUBLIC FUNCTION sadzi888_06_alm_check_item_if_exist(p_prog,p_type,p_module)
   DEFINE p_prog   STRING,
          p_type   STRING,
          p_module STRING

   DEFINE r_err_msg STRING

   DEFINE l_prog_info T_PROGRAM_INFO,
          lb_result BOOLEAN
  
 
   #p_type為null時自動判斷
   IF cl_null(p_type) THEN 
      LET p_type = sadzp060_2_chk_spec_type(p_prog)
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



##########################################################################
# Access Modifier : PUBLIC
# Descriptions    : 清除redo記錄
# Input parameter : 
# Return code     : 
# Date & Author   : 2014/09/03 by madey
##########################################################################
PUBLIC FUNCTION sadzi888_06_dzye_clear(p_tar_name)
  DEFINE p_tar_name STRING
  DEFINE ls_sql     STRING,
         ls_where   STRING,
         ls_trigger STRING
     
  TRY
     LET ls_trigger = "sadzi888_06_dzye_clear : delete dzye_t data"
     LET ls_sql = "DELETE  FROM dzye_t "
     LET ls_where=" WHERE dzye001 ='",p_tar_name,"'" 
     LET ls_sql = ls_sql , ls_where
     PREPARE dzye_delete_prep FROM ls_sql
     EXECUTE dzye_delete_prep 
     FREE dzye_delete_prep 
     

  CATCH
    DISPLAY "ERROR : ls_trigger=",ls_trigger
    DISPLAY "SQLCA.SQLCODE=",SQLCA.SQLCODE
    DISPLAY "ls_sql=",ls_sql,"<<"
  END TRY

END FUNCTION



##########################################################################
# Access Modifier : PUBLIC
# Descriptions    : 記錄redo資料
# Input parameter : pr_redo
# Return code     : none
# Date & Author   : 2014/09/03 by madey
##########################################################################
PUBLIC FUNCTION sadzi888_06_dzye_write_by_prog(pr_redo)
  DEFINE pr_redo    T_REDO,
         lr_dzye    type_g_dzye_d
 
  DEFINE ls_sql     STRING,
         ls_where   STRING,
         ls_trigger STRING,
         li_cnt     SMALLINT
     

  TRY
     INITIALIZE lr_dzye TO NULL
     LET lr_dzye.dzye001  = pr_redo.tar_name
     LET lr_dzye.dzye002  = pr_redo.prog
     LET lr_dzye.dzye003  = pr_redo.type
     LET lr_dzye.dzye004  = pr_redo.done
     LET lr_dzye.dzye005  = pr_redo.module
     LET lr_dzye.dzye006  = pr_redo.hardcode_qry
     LET lr_dzye.dzye007  = pr_redo.err
     LET lr_dzye.dzye008  = pr_redo.pid
     LET lr_dzye.dzye009  = pr_redo.ver
     LET lr_dzye.dzye010  = pr_redo.spec_ver
     LET lr_dzye.dzye011  = pr_redo.code_ver
     LET lr_dzye.dzye012  = pr_redo.identity
     LET lr_dzye.dzye013  = pr_redo.order
     LET lr_dzye.dzye014  = pr_redo.source_ver
     LET lr_dzye.dzye015  = pr_redo.merge
     LET lr_dzye.dzye016  = pr_redo.stage
     LET lr_dzye.dzye017  = pr_redo.crtdt
     LET lr_dzye.dzye018  = pr_redo.errmsg
     LET lr_dzye.dzye019  = pr_redo.source_identity
     LET lr_dzye.dzye020  = pr_redo.source_spec_ver
     LET lr_dzye.dzye021  = pr_redo.source_code_ver
     LET lr_dzye.dzye022  = pr_redo.checkout
     LET lr_dzye.dzye023  = pr_redo.status
     LET lr_dzye.dzye024  = pr_redo.crtid

     LET ls_trigger = "sadzi888_06_dzye_write_by_prog : check dzye_t count"
     LET ls_sql = "SELECT COUNT(*)",
                  "  FROM dzye_t "
     LET ls_where=" WHERE dzye001 ='",lr_dzye.dzye001 CLIPPED,"'",
                  "   AND dzye002 ='",lr_dzye.dzye002 CLIPPED,"'"
     LET ls_sql = ls_sql , ls_where
     PREPARE dzye_cnt_prep FROM ls_sql
     EXECUTE dzye_cnt_prep INTO li_cnt
     FREE dzye_cnt_prep 
     
     IF li_cnt > 0 THEN
        LET ls_trigger = "sadzi888_06_dzye_write_by_prog : update dzye_t data"
        LET ls_sql = "UPDATE dzye_t",
                      " SET dzye003 =? ,",
                      "     dzye004 =? ,",
                      "     dzye005 =? ,",
                      "     dzye006 =? ,",
                      "     dzye007 =? ,",
                      "     dzye008 =? ,",
                      "     dzye009 =? ,",
                      "     dzye010 =? ,",
                      "     dzye011 =? ,",
                      "     dzye012 =? ,",
                      "     dzye013 =? ,",
                      "     dzye014 =? ,",
                      "     dzye015 =? ,",
                      "     dzye016 =? ,",
                      "     dzye017 =? ,",
                      "     dzye018 =? ,",
                      "     dzye019 =? ,",
                      "     dzye020 =? ,",
                      "     dzye021 =? ,",
                      "     dzye022 =? ,",
                      "     dzye023 =? ,",
                      "     dzye024 =? "
        LET ls_sql = ls_sql , ls_where
        PREPARE dzye_upd_prep FROM ls_sql
        EXECUTE dzye_upd_prep USING  lr_dzye.dzye003 ,
                                     lr_dzye.dzye004 ,
                                     lr_dzye.dzye005 ,
                                     lr_dzye.dzye006 ,
                                     lr_dzye.dzye007 ,
                                     lr_dzye.dzye008 ,
                                     lr_dzye.dzye009 ,
                                     lr_dzye.dzye010 ,
                                     lr_dzye.dzye011 ,
                                     lr_dzye.dzye012 ,
                                     lr_dzye.dzye013 ,
                                     lr_dzye.dzye014 ,
                                     lr_dzye.dzye015 ,
                                     lr_dzye.dzye016 ,
                                     lr_dzye.dzye017 ,
                                     lr_dzye.dzye018 ,
                                     lr_dzye.dzye019 ,
                                     lr_dzye.dzye020 ,
                                     lr_dzye.dzye021 ,
                                     lr_dzye.dzye022 ,
                                     lr_dzye.dzye023 ,
                                     lr_dzye.dzye024 
        FREE dzye_upd_prep 
     ELSE
        LET ls_trigger = "sadzi888_06_dzye_write_by_prog : insert dzye_t data"
        LET ls_sql = "INSERT INTO dzye_t(dzye001,dzye002,dzye003,dzye004,dzye005,",
                     "                   dzye006,dzye007,dzye008,dzye009,dzye010,",
                     "                   dzye011,dzye012,dzye013,dzye014,dzye015,",
                     "                   dzye016,dzye017,dzye018,dzye019,dzye020,",
                     "                   dzye021,dzye022,dzye023,dzye024)",
                     " VALUES(?,?,?,?,?,",
                     "        ?,?,?,?,?,",
                     "        ?,?,?,?,?,",
                     "        ?,?,?,?,?,",
                     "        ?,?,?,?)"
        PREPARE dzye_ins_prep FROM ls_sql
        EXECUTE dzye_ins_prep USING  lr_dzye.dzye001 ,
                                     lr_dzye.dzye002 ,
                                     lr_dzye.dzye003 ,
                                     lr_dzye.dzye004 ,
                                     lr_dzye.dzye005 ,
                                     lr_dzye.dzye006 ,
                                     lr_dzye.dzye007 ,
                                     lr_dzye.dzye008 ,
                                     lr_dzye.dzye009 ,
                                     lr_dzye.dzye010 ,
                                     lr_dzye.dzye011 ,
                                     lr_dzye.dzye012 ,
                                     lr_dzye.dzye013 ,
                                     lr_dzye.dzye014 ,
                                     lr_dzye.dzye015 ,
                                     lr_dzye.dzye016 ,
                                     lr_dzye.dzye017 , 
                                     lr_dzye.dzye018 , 
                                     lr_dzye.dzye019 , 
                                     lr_dzye.dzye020 , 
                                     lr_dzye.dzye021 , 
                                     lr_dzye.dzye022 , 
                                     lr_dzye.dzye023 , 
                                     lr_dzye.dzye024 
        FREE dzye_ins_prep 
     END IF

  CATCH
    DISPLAY "ERROR : ls_trigger=",ls_trigger
    DISPLAY "SQLCA.SQLCODE=",SQLCA.SQLCODE
    DISPLAY "ls_sql=",ls_sql,"<<"
  END TRY

END FUNCTION



##########################################################################
# Access Modifier : PUBLIC
# Descriptions    : 讀取redo資料(單筆)
# Input parameter : p_prog 
# Return code     : ls_errmsg
#                   lr_dzye_t
# Date & Author   : 2014/09/03 by madey
##########################################################################
PUBLIC FUNCTION sadzi888_06_dzye_read_by_prog(p_tar_name,p_prog)
  DEFINE p_prog     STRING,
         p_tar_name STRING 
 
  DEFINE ls_sql     STRING,
         ls_where   STRING,
         ls_order   STRING,
         ls_trigger STRING 

  DEFINE ls_err_msg STRING

  DEFINE lr_dzye    type_g_dzye_d,
         lr_redo    T_REDO
     
  TRY
     INITIALIZE lr_dzye TO NULL
     INITIALIZE lr_redo TO NULL

     LET ls_trigger = "sadzi888_06_dzye_read_by_prog : read dzye_t data" 
     LET ls_sql = "SELECT dzye001,dzye002,dzye003,dzye004,dzye005,dzye006,dzye007,dzye008,",
                  "       dzye009,dzye010,dzye011,dzye012,dzye013,dzye014,dzye015,dzye016,",
                  "       dzye017,dzye018,dzye019,dzye020,dzye021,dzye022,dzye023,dzye024",
                  "  FROM dzye_t "
     LET ls_where=" WHERE dzye001 ='",p_tar_name,"'",
                  "   AND dzye002 ='",p_prog,"'"
     LET ls_order=" ORDER BY dzye013,dzye002" #類別order,程式代碼
     LET ls_sql = ls_sql , ls_where, ls_order
     PREPARE dzye_read_prep FROM ls_sql
     EXECUTE dzye_read_prep INTO lr_dzye.*
     IF SQLCA.sqlcode THEN
        LET ls_err_msg = p_prog,'無記錄'
     ELSE
        LET lr_redo.tar_name        = lr_dzye.dzye001 CLIPPED
        LET lr_redo.prog            = lr_dzye.dzye002 CLIPPED
        LET lr_redo.type            = lr_dzye.dzye003 CLIPPED
        LET lr_redo.done            = lr_dzye.dzye004 CLIPPED
        LET lr_redo.module          = lr_dzye.dzye005 CLIPPED
        LET lr_redo.hardcode_qry    = lr_dzye.dzye006 CLIPPED
        LET lr_redo.err             = lr_dzye.dzye007 CLIPPED
        LET lr_redo.pid             = lr_dzye.dzye008 CLIPPED
        LET lr_redo.ver             = lr_dzye.dzye009 CLIPPED
        LET lr_redo.spec_ver        = lr_dzye.dzye010 CLIPPED
        LET lr_redo.code_ver        = lr_dzye.dzye011 CLIPPED
        LET lr_redo.identity        = lr_dzye.dzye012 CLIPPED
        LET lr_redo.order           = lr_dzye.dzye013 CLIPPED
        LET lr_redo.source_ver      = lr_dzye.dzye014 CLIPPED
        LET lr_redo.merge           = lr_dzye.dzye015 CLIPPED
        LET lr_redo.stage           = lr_dzye.dzye016 CLIPPED
        LET lr_redo.crtdt           = lr_dzye.dzye017 CLIPPED
        LET lr_redo.errmsg          = lr_dzye.dzye018 CLIPPED
        LET lr_redo.source_identity = lr_dzye.dzye019 CLIPPED
        LET lr_redo.source_spec_ver = lr_dzye.dzye020 CLIPPED
        LET lr_redo.source_code_ver = lr_dzye.dzye021 CLIPPED
        LET lr_redo.checkout        = lr_dzye.dzye022 CLIPPED
        LET lr_redo.status          = lr_dzye.dzye023 CLIPPED
        LET lr_redo.crtid           = lr_dzye.dzye024 CLIPPED
        LET ls_err_msg = NULL
     END IF
     FREE dzye_read_prep 
     

     RETURN ls_err_msg,lr_redo.*

  CATCH
    DISPLAY "ERROR : ls_trigger=",ls_trigger
    DISPLAY "SQLCA.SQLCODE=",SQLCA.SQLCODE
    DISPLAY "ls_sql=",ls_sql,"<<"
    RETURN ls_trigger,NULL
  END TRY

END FUNCTION



##########################################################################
# Access Modifier : PUBLIC
# Descriptions    : 讀取redo資料(all)
# Input parameter : 
# Return code     : ls_errmsg
#                   la_redo
# Date & Author   : 2014/09/03 by madey
##########################################################################
PUBLIC FUNCTION sadzi888_06_dzye_read(p_tar_name) 
  DEFINE p_tar_name STRING 
  DEFINE ls_sql     STRING,
         ls_where   STRING,
         ls_order   STRING,
         ls_trigger STRING,
         li_i       SMALLINT 

  DEFINE ls_err_msg STRING

  DEFINE lr_dzye    type_g_dzye_d,
         ra_redo    DYNAMIC ARRAY OF T_REDO
     
  TRY
     LET ls_trigger = "sadzi888_06_dzye_read : read dzye_t data" 
     LET ls_sql = "SELECT dzye001,dzye002,dzye003,dzye004,dzye005,dzye006,dzye007,dzye008,",
                  "       dzye009,dzye010,dzye011,dzye012,dzye013,dzye014,dzye015,dzye016,",
                  "       dzye017,dzye018,dzye019,dzye020,dzye021,dzye022,dzye023,dzye024",
                  "  FROM dzye_t "
     LET ls_where=" WHERE dzye001 ='",p_tar_name,"'" 
     LET ls_order=" ORDER BY dzye013,dzye002" #類別order,程式代碼
     LET ls_sql = ls_sql , ls_where ,ls_order
     PREPARE dzye_read_prep2 FROM ls_sql
     DECLARE dzye_read_curs2 CURSOR FOR dzye_read_prep2

     #init
     INITIALIZE lr_dzye TO NULL
     CALL ra_redo.CLEAR() 
     LET li_i = 0 
     FOREACH dzye_read_curs2 INTO lr_dzye.*
        LET li_i = ra_redo.getLength() + 1
        LET ra_redo[li_i].tar_name        = lr_dzye.dzye001 CLIPPED
        LET ra_redo[li_i].prog            = lr_dzye.dzye002 CLIPPED
        LET ra_redo[li_i].type            = lr_dzye.dzye003 CLIPPED
        LET ra_redo[li_i].done            = lr_dzye.dzye004 CLIPPED
        LET ra_redo[li_i].module          = lr_dzye.dzye005 CLIPPED
        LET ra_redo[li_i].hardcode_qry    = lr_dzye.dzye006 CLIPPED
        LET ra_redo[li_i].err             = lr_dzye.dzye007 CLIPPED
        LET ra_redo[li_i].pid             = lr_dzye.dzye008 CLIPPED
        LET ra_redo[li_i].ver             = lr_dzye.dzye009 CLIPPED
        LET ra_redo[li_i].spec_ver        = lr_dzye.dzye010 CLIPPED
        LET ra_redo[li_i].code_ver        = lr_dzye.dzye011 CLIPPED
        LET ra_redo[li_i].identity        = lr_dzye.dzye012 CLIPPED
        LET ra_redo[li_i].order           = lr_dzye.dzye013 CLIPPED
        LET ra_redo[li_i].source_ver      = lr_dzye.dzye014 CLIPPED
        LET ra_redo[li_i].merge           = lr_dzye.dzye015 CLIPPED
        LET ra_redo[li_i].stage           = lr_dzye.dzye016 CLIPPED
        LET ra_redo[li_i].crtdt           = lr_dzye.dzye017 CLIPPED
        LET ra_redo[li_i].errmsg          = lr_dzye.dzye018 CLIPPED 
        LET ra_redo[li_i].source_identity = lr_dzye.dzye019 CLIPPED 
        LET ra_redo[li_i].source_spec_ver = lr_dzye.dzye020 CLIPPED 
        LET ra_redo[li_i].source_code_ver = lr_dzye.dzye021 CLIPPED 
        LET ra_redo[li_i].checkout        = lr_dzye.dzye022 CLIPPED 
        LET ra_redo[li_i].status          = lr_dzye.dzye023 CLIPPED
        LET ra_redo[li_i].crtid           = lr_dzye.dzye024 CLIPPED 
     END FOREACH
     FREE dzye_read_curs2

     RETURN ls_err_msg,ra_redo

  CATCH
    DISPLAY "ERROR : ls_trigger=",ls_trigger
    DISPLAY "SQLCA.SQLCODE=",SQLCA.SQLCODE
    DISPLAY "ls_sql=",ls_sql,"<<"
    RETURN ls_trigger,NULL
  END TRY

END FUNCTION



##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 取cpu core數
# Input parameter : 
# Return code     : cpu core數
# Date & Author   : 2014/09/03 by madey
##########################################################################
PRIVATE FUNCTION sadzi888_06_get_core_of_cpu()
   DEFINE lch_cmd      base.Channel   
   DEFINE lr_processor  LIKE type_t.num5 
   DEFINE l_str        STRING
 

   LET lr_processor = 0

   CASE g_run_mode
      WHEN "2" #20150923
        #LET lr_processor = 3 
         LET lr_processor = 1 

      WHEN "4"
         LET lch_cmd = base.Channel.CREATE()
         CALL lch_cmd.openPipe("fglWrt -a cpu", "r") #CPU數
         IF lch_cmd.READ(l_str) THEN
            LET lr_processor = l_str
         END IF
         CALL lch_cmd.CLOSE()
         
         IF lr_processor <= 0 THEN LET lr_processor = 2 END IF
         IF lr_processor > 16 THEN LET lr_processor = 16 END IF

      OTHERWISE 
         LET lr_processor = 1  

   END CASE
  
   DISPLAY 'sadzi888_06_get_core_of_cpu:',lr_processor 

   RETURN lr_processor
END FUNCTION



##########################################################################
# Access Modifier : PRIVATE
# Descriptions    : 等待所有執行緒都做完事了
# Input parameter : 
# Return code     : 
# Date & Author   : 2014/09/11 by madey
##########################################################################
PRIVATE FUNCTION sadzi888_06_waiting_process(p_tar_name,p_part)
  DEFINE p_tar_name STRING
  DEFINE p_part     STRING,
         ls_trigger STRING

    #讀取資料庫,針對status查看是否執行完畢，未完畢則繼續等待
    #仍在執行或crash,等一段時間後，全部更新為timeout
   #IF sadzi888_06_dzye_check_status(p_part) THEN
   #   LET ls_trigger= "sadzi888_06_waiting_process : waiting 30 sec: ",p_part
   #   DISPLAY ls_trigger
   #   CALL sadzi888_01_log_file_write(ls_trigger)
   #   SLEEP 30  
   #   IF sadzi888_06_dzye_check_status(p_tar_name,p_part) THEN 
   #      LET ls_trigger= "sadzi888_06_waiting_process : waiting 30 sec (again): ",p_part
   #      DISPLAY ls_trigger
   #      CALL sadzi888_01_log_file_write(ls_trigger)
   #      SLEEP 30  
   #      CALL sadzi888_06_dzye_update_status_for_timeout(p_tar_name,p_part)
   #   END IF
   #END IF

    LET ls_trigger = "sadzi888_06_waiting_process :",p_tar_name," ",p_part," ",cl_get_current() 
    DISPLAY ls_trigger
    LET g_total_wait=0
   #CALL sadzi888_06_dzye_check_status(p_tar_name,p_part)
    CALL sadzi888_06_dzye_check_stage(p_tar_name,p_part)


END FUNCTION


##########################################################################
# Access Modifier : PUBLIC
# Descriptions    : 讀取redo資料,確認是否有仍在該階段的資料
#                   若有的話，超過時間後將stage設為null
# Input parameter : p_part   不同階段的檢查條件不同
# Return code     : BOOLEAN :TRUE:有 FALSE:無
# Date & Author   : 2014/09/03 by madey
##########################################################################
PUBLIC FUNCTION sadzi888_06_dzye_check_stage(p_tar_name,p_part)
  DEFINE p_tar_name STRING 
  DEFINE p_part     STRING
  DEFINE ls_sql     STRING,
         ls_where   STRING,
         ls_trigger STRING,
         li_i       SMALLINT

  DEFINE ls_err_msg STRING,
         lb_result  BOOLEAN

  DEFINE lr_dzye    type_g_dzye_d,
         la_dzye    DYNAMIC ARRAY OF type_g_dzye_d

  DEFINE ls_cmd     STRING,
         li_result  INTEGER,
         li_pid     INTEGER
         
     
  TRY

     LET lb_result = FALSE

     #wait超過5分鐘則強制往下一階段 
     IF g_total_wait > 300 THEN 
        CALL sadzi888_06_dzye_update_stage_for_timeout(p_tar_name,p_part)
        RETURN 
     END IF

     LET ls_trigger = "sadzi888_06_dzye_check_stage : ",p_tar_name," ",p_part 
     DISPLAY ls_trigger
     LET ls_sql = "SELECT dzye001,dzye002,dzye003,dzye004,dzye005,dzye006,dzye007,dzye008,",
                  "       dzye009,dzye010,dzye011,dzye012,dzye013,dzye014,dzye015,dzye016,",
                  "       dzye017,dzye018,dzye019,dzye020,dzye021,dzye022,dzye023,dzye024",
                  "  FROM dzye_t "
     LET ls_where=" WHERE dzye001 ='",p_tar_name,"'", 
                  "   AND dzye016 ='",p_part,"'"
     LET ls_sql = ls_sql , ls_where
     PREPARE dzye_read_prep3 FROM ls_sql
     DECLARE dzye_read_curs3 CURSOR FOR dzye_read_prep3

     #init
     INITIALIZE lr_dzye TO NULL
     CALL la_dzye.CLEAR() 
     LET li_i = 0 
     FOREACH dzye_read_curs3 INTO lr_dzye.*
        LET li_i = la_dzye.getLength() + 1
        LET la_dzye[li_i].dzye002 = lr_dzye.dzye002 CLIPPED
     END FOREACH
     FREE dzye_read_curs3

     IF la_dzye.getLength() > 0 THEN
      ###逐筆check pid ,如果該pid已不存在，認定為crash,並update status,errmsg=crash
      ##LET ls_trigger = "sadzi888_06_dzye_check_status : update dzye_t data" 
      ##DISPLAY ls_trigger
      ##LET ls_sql = "UPDATE dzye_t ",
      ##             "   SET dzye006=?,",
      ##             "       dzye007=?" 
      ##LET ls_where = " WHERE dzye001='adzp999_redo'",
      ##               "   AND dzye002=?"
      ##LET ls_sql = ls_sql , ls_where
      ##PREPARE dzye_update_prep2 FROM ls_sql
      ##FOR li_i = 1 TO la_dzye.getLength()
      ##   LET li_pid = la_dzye[li_i].dzye008  CLIPPED
      ##  #LET ls_cmd =  'ps -p ',li_pid , " >/dev/null 2>&1"
      ##   LET ls_cmd =  'ps -p ',li_pid 
      ##   DISPLAY 'ls_cmd'
      ##   RUN ls_cmd RETURNING li_result
      ##   IF li_result =0 THEN
      ##      #有找到,表示仍在執行中
      ##   ELSE
      ##      #沒有到，表示crash了，強制將status設為2 ,err設為crash
      ##      LET lr_dzye.dzye002 = la_dzye[li_i].dzye002 CLIPPED
      ##      LET lr_dzye.dzye006 = "2"
      ##      LET lr_dzye.dzye007 = "crash"
      ##      EXECUTE dzye_update_prep2 USING lr_dzye.dzye006, lr_dzye.dzye007, lr_dzye.dzye002
      ##   END IF
      ##END FOR
      ##FREE dzye_update_prep2
           
        LET lb_result = TRUE
     ELSE 
        LET lb_result = FALSE
     END IF

    #遞迴 -begin-
    IF lb_result THEN
       DISPLAY ls_trigger
       CALL sadzi888_01_log_file_write(ls_trigger)
       SLEEP 6
       LET g_total_wait = g_total_wait + 6
       CALL sadzi888_06_dzye_check_stage(p_tar_name,p_part) 
    ELSE
       RETURN
    END IF
    #-end-


  CATCH
    DISPLAY "ERROR : ls_trigger=",ls_trigger
    DISPLAY "SQLCA.SQLCODE=",SQLCA.SQLCODE
    DISPLAY "ls_sql=",ls_sql,"<<"
    RETURN 
  END TRY

END FUNCTION
 


##########################################################################
# Access Modifier : PUBLIC
# Descriptions    : 讀取redo資料,若有仍在該階段的資料,則強制將stage設為null(已結束)
# Input parameter : p_part   不同階段的檢查條件不同
# Return code     : 
# Date & Author   : 2014/09/03 by madey
##########################################################################
PUBLIC FUNCTION sadzi888_06_dzye_update_stage_for_timeout(p_tar_name,p_part)
  DEFINE p_tar_name STRING
  DEFINE p_part     STRING
  DEFINE ls_sql     STRING,
         ls_where   STRING,
         ls_trigger STRING,
         li_i       SMALLINT

  DEFINE ls_err_msg STRING,
         lb_result  BOOLEAN

  DEFINE lr_dzye    type_g_dzye_d,
         la_dzye    DYNAMIC ARRAY OF type_g_dzye_d
     
  TRY
     LET lb_result = FALSE


     LET ls_trigger = "sadzi888_06_dzye_update_stage_for_timeout : update dzye_t data:",p_tar_name," ",p_part 
     DISPLAY ls_trigger
     LET ls_sql = "UPDATE dzye_t ",
                 #"   SET dzye006='2' ,", #160223-00028 mark
                  "   SET dzye023='2' ,", #160223-00028 modify
                  "       dzye007='time out ERROR' ,", 
                  "       dzye016=NULL" 
     LET ls_where = " WHERE dzye001 ='",p_tar_name,"'",
                    "   AND dzye016 ='",p_part,"'"
     LET ls_sql = ls_sql , ls_where
     PREPARE dzye_update_prep3 FROM ls_sql
     EXECUTE dzye_update_prep3
     FREE dzye_update_prep3


  CATCH
    DISPLAY "ERROR : ls_trigger=",ls_trigger
    DISPLAY "SQLCA.SQLCODE=",SQLCA.SQLCODE
    DISPLAY "ls_sql=",ls_sql,"<<"
  END TRY

END FUNCTION



#+過濾程式清單(依類別)
FUNCTION sadzi888_06_filter(pa_ddata,p_type_list)
  DEFINE p_type_list   STRING
  DEFINE pa_ddata      DYNAMIC ARRAY OF T_REDO,
         ra_ddata      DYNAMIC ARRAY OF T_REDO
  DEFINE li_i          SMALLINT,
         li_cnt        SMALLINT,
         ls_prog       STRING,
         ls_trigger    STRING,
         ls_cmd        STRING,
         ls_err_msg    STRING
  DEFINE ls_matches_cond STRING

  #init
  CALL ra_ddata.CLEAR()

  LET p_type_list = p_type_list.trim()
  IF cl_null(p_type_list) THEN
     #沒有要過濾則回傳原值
     RETURN pa_ddata
  ELSE
  LET ls_matches_cond = "[",p_type_list.TRIM(),"]"
     FOR li_i=1 TO pa_ddata.getLength()
        IF pa_ddata[li_i].type CLIPPED MATCHES ls_matches_cond THEN
           LET ra_ddata[ra_ddata.getLength()+1].* = pa_ddata[li_i].*
        END IF
     END FOR
     
     RETURN ra_ddata
  END IF

END FUNCTION



#+依程式清單取type,module 
PRIVATE FUNCTION sadzi888_06_init_prog(pa_ddata)
  DEFINE pa_ddata      DYNAMIC ARRAY OF T_REDO,
         ra_ddata      DYNAMIC ARRAY OF T_REDO
  DEFINE li_i          SMALLINT,
         li_cnt        SMALLINT,
         ls_prog       STRING,
         ls_trigger    STRING,
         ls_cmd        STRING,
         ls_err_msg    STRING
                       
  DEFINE lf_prog       CHAR(20)
  DEFINE lr_redo       T_REDO 
  DEFINE l_pack_dir    STRING #161128-00074


  LET l_pack_dir = FGL_GETENV(g_pack_dir_env) #161128-00074

  CALL ra_ddata.CLEAR()

  #進度列控制-第一階
  IF g_adzp999_01_s01 IS NOT NULL AND g_adzp999_01_s01 THEN
     CALL adzp999_01_refresh_tasks_progressbar(gc_gen_06_prog_init, "adz-00613")                                 
  END IF

  FOR li_i=1 TO pa_ddata.getLength() 
     IF pa_ddata[li_i].type = "L" THEN
       #do nothing # skip 42x
     ELSE
        #先寫一筆到記錄表
        INITIALIZE lr_redo TO NULL
        LET lr_redo.* = pa_ddata[li_i].* 
        LET lr_redo.stage = "init"
        LET lr_redo.crtdt = cl_get_current()
        LET lr_redo.crtid = g_user
        CALL sadzi888_06_dzye_write_by_prog(lr_redo.*)
     END IF
  END FOR
  #取回執行結果
  CALL sadzi888_06_dzye_read(g_tar_name) RETURNING ls_err_msg,pa_ddata

  LET li_cnt = pa_ddata.getLength()
  FOR li_i=1 TO li_cnt
     #進度列控制-第二階
     IF g_adzp999_01_s01 IS NOT NULL AND g_adzp999_01_s01 THEN
        CALL adzp999_01_refresh_sub_tasks_progressbar(li_i, li_cnt)
     END IF

     LET ls_prog = pa_ddata[li_i].prog CLIPPED
     LET lf_prog = ls_prog
     #顯示執行筆數
     LET ls_trigger = "sadzi888_06_after_imp : (init prog) ==> ",lf_prog," (",li_i,"/",li_cnt,")"
     DISPLAY ls_trigger
     CALL sadzi888_01_log_file_write(ls_trigger)

     IF pa_ddata[li_i].type = "L" THEN
       #do nothing # skip 42x
     ELSE
        #以multi-process執行                            
        LET ls_cmd = "$FGLRUN $ADZ/42r/adzp988.42r"," ",
                     "''"," ",                         #參數1
                     g_tar_name," ",                   #參數2
                     ls_prog," ",                      #參數3
                     "init"," ",                       #參數4
                     g_run_mode," ",                   #參數5
                     g_auto_merge," ",                 #參數6
                     g_gen42s_flag," ",                #參數7 
                    #"2>&1 |tee $TEMPDIR/adzp988_",g_tar_name,"_init_",ls_prog,".log "
                     "2>&1 |tee ",l_pack_dir,"/adzp988_",g_tar_name,"_init_",ls_prog,".log " #161128-00074
        DISPLAY ls_cmd
        CALL sadzi888_01_log_file_write(ls_cmd)
        IF li_i MOD gi_processor = 0  OR li_i=li_cnt THEN    
           RUN ls_cmd
        ELSE
           RUN ls_cmd WITHOUT WAITING
        END IF
     END IF
  END FOR

  #等待所有執行緒都做完
  CALL sadzi888_06_waiting_process(g_tar_name,"init")

  #取回執行結果
  CALL sadzi888_06_dzye_read(g_tar_name) RETURNING ls_err_msg,ra_ddata

  RETURN ra_ddata
    
END FUNCTION


#160223-00028 add:merge
#+依程式清單merge程式
PRIVATE FUNCTION sadzi888_06_merge_prog(pa_ddata) 
  DEFINE pa_ddata      DYNAMIC ARRAY OF T_REDO,
         ra_ddata      DYNAMIC ARRAY OF T_REDO
  DEFINE la_merge_prog_list DYNAMIC ARRAY OF T_REDO #merge清單
  DEFINE li_i          SMALLINT,
         li_cnt        SMALLINT,
         ls_prog       STRING,
         ls_trigger    STRING,
         ls_cmd        STRING,
         ls_err_msg    STRING
                       
  DEFINE lf_prog       CHAR(20)
  DEFINE lr_redo       T_REDO
  DEFINE l_pack_dir    STRING #161128-00074

 
  LET l_pack_dir = FGL_GETENV(g_pack_dir_env)  #161128-00074

  IF g_run_mode ="4" THEN #patch模式下才有merge功能
     #融合程式 (merge)
     #init
     CALL ra_ddata.CLEAR()
     CALL la_merge_prog_list.CLEAR()
     
     FOR li_i=1 TO pa_ddata.getLength()
        #keep可以merge的程式清單
        IF pa_ddata[li_i].status = "1"             AND #成功 
           pa_ddata[li_i].source_identity = "s"    AND #來源是標準
           pa_ddata[li_i].identity = "c"           AND #目的是客製
          #pa_ddata[li_i].type MATCHES "[SMZFBWQ]"     #這幾類才能被merge
          (pa_ddata[li_i].type MATCHES "[SMZFBW]"  OR (pa_ddata[li_i].type MATCHES "[Q]" AND pa_ddata[li_i].hardcode_qry = "Y")) #160510-00003
        THEN
           LET la_merge_prog_list[la_merge_prog_list.getLength() + 1].* = pa_ddata[li_i].*
        END IF
     END FOR
     
     #進度列控制-第一階
     IF g_adzp999_01_s01 IS NOT NULL AND g_adzp999_01_s01 THEN
        CALL adzp999_01_refresh_tasks_progressbar(gc_gen_06_prog_merge, "adz-00725")                                 
     END IF
     
     LET li_cnt = la_merge_prog_list.getLength()
     FOR li_i=1 TO li_cnt
        #進度列控制-第二階
        IF g_adzp999_01_s01 IS NOT NULL AND g_adzp999_01_s01 THEN
            CALL adzp999_01_refresh_sub_tasks_progressbar(li_i, li_cnt)
        END IF
     
        LET ls_prog = la_merge_prog_list[li_i].prog CLIPPED
        LET lf_prog = ls_prog
        #顯示執行筆數
        LET ls_trigger = "sadzi888_06_after_imp : (merge prog) ==> ",lf_prog," (",li_i,"/",li_cnt,")"
        DISPLAY ls_trigger
        CALL sadzi888_01_log_file_write(ls_trigger)
     
        #先寫一筆到記錄表
        INITIALIZE lr_redo TO NULL
        LET lr_redo.* = la_merge_prog_list[li_i].* 
        LET lr_redo.stage = "merge"
        CALL sadzi888_06_dzye_write_by_prog(lr_redo.*)
     
        #以multi-process執行
        LET ls_cmd = "$FGLRUN $ADZ/42r/adzp988.42r"," ",
                     "''"," ",                         #參數1
                     g_tar_name," ",                   #參數2
                     ls_prog," ",                      #參數3
                     "merge"," ",                      #參數4
                     g_run_mode," ",                   #參數5
                     g_auto_merge," ",                 #參數6
                     g_gen42s_flag," ",                #參數7
                    #"2>&1 |tee $TEMPDIR/adzp988_",g_tar_name,"_merge_",ls_prog,".log "
                     "2>&1 |tee ",l_pack_dir,"/adzp988_",g_tar_name,"_merge_",ls_prog,".log " #161128-00074
        DISPLAY ls_cmd
        CALL sadzi888_01_log_file_write(ls_cmd)
        IF li_i MOD gi_processor = 0  OR li_i=li_cnt THEN    
           RUN ls_cmd
        ELSE
           RUN ls_cmd WITHOUT WAITING
        END IF
     END FOR
     #等待所有process做完
     CALL sadzi888_06_waiting_process(g_tar_name,"merge")
     
     #取回執行結果
     CALL sadzi888_06_dzye_read(g_tar_name) RETURNING ls_err_msg,ra_ddata 
     
     RETURN ra_ddata

  ELSE
     #do nothing #回傳原本傳入的資料即可
     RETURN pa_ddata 

  END IF

END FUNCTION


#+依程式清單gen程式
PRIVATE FUNCTION sadzi888_06_gen_prog(pa_ddata) 
  DEFINE pa_ddata      DYNAMIC ARRAY OF T_REDO,
         ra_ddata      DYNAMIC ARRAY OF T_REDO
  DEFINE la_gen_prog_list DYNAMIC ARRAY OF T_REDO #gen清單
  DEFINE li_i          SMALLINT,
         li_cnt        SMALLINT,
         ls_prog       STRING,
         ls_trigger    STRING,
         ls_cmd        STRING,
         ls_err_msg    STRING
                       
  DEFINE lf_prog       CHAR(20)
  DEFINE lr_redo       T_REDO
  DEFINE l_pack_dir    STRING #161128-00074


  LET l_pack_dir = FGL_GETENV(g_pack_dir_env)  #161128-00074

  #Begin: 160816-00064
  #進度列控制-第一階
  IF g_adzp999_01_s01 IS NOT NULL AND g_adzp999_01_s01 THEN
     CALL adzp999_01_refresh_tasks_progressbar(gc_gen_06_prog_gen, "adz-00621")                                 
  END IF

  IF g_quick_patch = "Y" THEN
     #進度列控制-第二階
     IF g_adzp999_01_s01 IS NOT NULL AND g_adzp999_01_s01 THEN
        CALL adzp999_01_refresh_sub_tasks_progressbar(1, 1)
     END IF
     DISPLAY "g_quck_patch is ON, skip sadzi888_06_gen_prog()"
     RETURN pa_ddata
  END IF 
  #End: 160816-00047

  #組合程式
  #init
  CALL ra_ddata.CLEAR()
  CALL la_gen_prog_list.CLEAR()

 #Begin :160223-00028 modify
 ##patch模式下:客戶家標準程式不重產,其他模式下要重產
 #IF g_run_mode = "4" THEN
 #   FOR li_i=1 TO pa_ddata.getLength()
 #      IF pa_ddata[li_i].TYPE = "L" THEN
 #        #do nothing # skip 42x
 #      ELSE
 #         #keep可以gen的程式清單
 #         IF pa_ddata[li_i].status = "1" AND  #成功
 #            pa_ddata[li_i].identity = "c"    #客製程式
 #         THEN
 #            LET la_gen_prog_list[la_gen_prog_list.getLength() + 1].* = pa_ddata[li_i].*
 #         END IF
 #      END IF
 #   END FOR
 #ELSE
 #   FOR li_i=1 TO pa_ddata.getLength()
 #      IF pa_ddata[li_i].TYPE = "L" THEN
 #        #do nothing # skip 42x
 #      ELSE
 #         #keep可以gen的程式清單
 #         IF pa_ddata[li_i].status = "1"  #成功
 #         THEN
 #            LET la_gen_prog_list[la_gen_prog_list.getLength() + 1].* = pa_ddata[li_i].*
 #         END IF
 #      END IF
 #   END FOR
 #END IF

  FOR li_i=1 TO pa_ddata.getLength()
     IF pa_ddata[li_i].TYPE = "L" THEN
       #do nothing # skip 42x
     ELSE
        #keep可以gen的程式清單
        IF pa_ddata[li_i].status = "1"  #成功
        THEN
           LET la_gen_prog_list[la_gen_prog_list.getLength() + 1].* = pa_ddata[li_i].*
        END IF
     END IF
  END FOR
 #End :160223-00028 modify


  LET li_cnt = la_gen_prog_list.getLength()
  FOR li_i=1 TO li_cnt
     #進度列控制-第二階
     IF g_adzp999_01_s01 IS NOT NULL AND g_adzp999_01_s01 THEN
         CALL adzp999_01_refresh_sub_tasks_progressbar(li_i, li_cnt)
     END IF

     LET ls_prog = la_gen_prog_list[li_i].prog CLIPPED
     LET lf_prog = ls_prog
     #顯示執行筆數
     LET ls_trigger = "sadzi888_06_after_imp : (gen prog) ==> ",lf_prog," (",li_i,"/",li_cnt,")"
     DISPLAY ls_trigger
     CALL sadzi888_01_log_file_write(ls_trigger)

     #先寫一筆到記錄表
     INITIALIZE lr_redo TO NULL
     LET lr_redo.* = la_gen_prog_list[li_i].* 
     LET lr_redo.stage = "gen"
     CALL sadzi888_06_dzye_write_by_prog(lr_redo.*)
  
     #以multi-process執行
     LET ls_cmd = "$FGLRUN $ADZ/42r/adzp988.42r"," ",
                  "''"," ",                         #參數1
                  g_tar_name," ",                   #參數2
                  ls_prog," ",                      #參數3
                  "gen"," ",                        #參數4
                  g_run_mode," ",                   #參數5
                  g_auto_merge," ",                 #參數6
                  g_gen42s_flag," ",                #參數7
                 #"2>&1 |tee $TEMPDIR/adzp988_",g_tar_name,"_gen_",ls_prog,".log "
                  "2>&1 |tee ",l_pack_dir,"/adzp988_",g_tar_name,"_gen_",ls_prog,".log " #161128-00074
     DISPLAY ls_cmd
     CALL sadzi888_01_log_file_write(ls_cmd)
     IF li_i MOD gi_processor = 0  OR li_i=li_cnt THEN    
        RUN ls_cmd
     ELSE
        RUN ls_cmd WITHOUT WAITING
     END IF
  END FOR
  #等待所有process做完
  CALL sadzi888_06_waiting_process(g_tar_name,"gen")

  #取回執行結果
  CALL sadzi888_06_dzye_read(g_tar_name) RETURNING ls_err_msg,ra_ddata 

  RETURN ra_ddata

END FUNCTION


#+依程式清單compile程式
PRIVATE FUNCTION sadzi888_06_compile_prog(pa_ddata,p_type_list) 
  DEFINE pa_ddata      DYNAMIC ARRAY OF T_REDO,
         p_type_list   STRING,
         ra_ddata      DYNAMIC ARRAY OF T_REDO
  DEFINE li_i          SMALLINT,
         li_cnt        SMALLINT,
         ls_prog       STRING,
         ls_trigger    STRING,
         ls_cmd        STRING,
         ls_err_msg    STRING
  DEFINE la_compile_prog_list DYNAMIC ARRAY OF T_REDO #編譯清單
  DEFINE lf_prog       CHAR(20)
  DEFINE lr_redo       T_REDO 
  DEFINE l_pack_dir    STRING #161128-00074


  LET l_pack_dir = FGL_GETENV(g_pack_dir_env)  #161128-00074

  #Begin: 160816-00047
  #進度列控制-第一階
  IF g_adzp999_01_s01 IS NOT NULL AND g_adzp999_01_s01 THEN
     IF gb_part1 THEN
        CALL adzp999_01_refresh_tasks_progressbar(gc_gen_06_sub_compile, "adz-00617")                                 
     ELSE
        CALL adzp999_01_refresh_tasks_progressbar(gc_gen_06_prog_compile, "adz-00619")                                 
     END IF
  END IF

  IF g_quick_patch = "Y" THEN
     #進度列控制-第二階
     IF g_adzp999_01_s01 IS NOT NULL AND g_adzp999_01_s01 THEN
        CALL adzp999_01_refresh_sub_tasks_progressbar(1, 1)
     END IF
     DISPLAY "g_quck_patch is ON, skip sadzi888_06_compile_prog()"
     RETURN pa_ddata
  END IF 
  #End: 160816-00047

  #統計哪些程式組合成功，將成功的記錄下來，並做編譯的動作
  #init
  CALL ra_ddata.CLEAR()
  CALL la_compile_prog_list.CLEAR()

  #看需不需要過濾類別
  CALL sadzi888_06_filter(pa_ddata,p_type_list) RETURNING pa_ddata

  FOR li_i=1 TO pa_ddata.getLength()
     #keep可以compile的程式清單
     IF pa_ddata[li_i].status = "1" #成功
     THEN
        LET la_compile_prog_list[la_compile_prog_list.getLength() + 1].* = pa_ddata[li_i].*
     END IF
  END FOR

  LET li_cnt = la_compile_prog_list.getLength()
  FOR li_i=1 TO li_cnt
     #進度列控制-第二階
     IF g_adzp999_01_s01 IS NOT NULL AND g_adzp999_01_s01 THEN
        CALL adzp999_01_refresh_sub_tasks_progressbar(li_i, li_cnt)
     END IF

     LET ls_prog = la_compile_prog_list[li_i].prog CLIPPED
     LET lf_prog = ls_prog
     #顯示執行筆數
     LET ls_trigger = "sadzi888_06_after_imp : (compile prog) ==> ",lf_prog," (",li_i,"/",li_cnt,")"
     DISPLAY ls_trigger
     CALL sadzi888_01_log_file_write(ls_trigger)

     #先寫一筆到記錄表
     INITIALIZE lr_redo TO NULL
     LET lr_redo.* = la_compile_prog_list[li_i].* 
     LET lr_redo.stage = "compile"
     CALL sadzi888_06_dzye_write_by_prog(lr_redo.*)
  
     #以multi-process執行 
     LET ls_cmd = "$FGLRUN $ADZ/42r/adzp988.42r"," ",
                  "''"," ",                         #參數1
                  g_tar_name," ",                   #參數2
                  ls_prog," ",                      #參數3
                  "compile"," ",                    #參數4
                  g_run_mode," ",                   #參數5
                  g_auto_merge," ",                 #參數6
                  g_gen42s_flag," ",                #參數7
                 #"2>&1 |tee $TEMPDIR/adzp988_",g_tar_name,"_compile_",ls_prog,".log "
                  "2>&1 |tee ",l_pack_dir,"/adzp988_",g_tar_name,"_compile_",ls_prog,".log " #161128-00074
     DISPLAY ls_cmd
     CALL sadzi888_01_log_file_write(ls_cmd)
     IF li_i MOD gi_processor = 0 OR li_i=li_cnt OR 
       (ls_prog MATCHES "cl_*" ) OR #cl開頭的不走併發,一支支循序執行
       (ls_prog MATCHES "ccl_*") OR
       (ls_prog = "azzp188" ) 
     THEN
        RUN ls_cmd
     ELSE
        RUN ls_cmd WITHOUT WAITING
     END IF
  END FOR

  #等待所有process做完
  CALL sadzi888_06_waiting_process(g_tar_name,"compile")

  #取回執行結果(all)
  CALL sadzi888_06_dzye_read(g_tar_name) RETURNING ls_err_msg,ra_ddata

  RETURN ra_ddata

END FUNCTION


#160223-00028 add
#+依程式清單link 42x
PRIVATE FUNCTION sadzi888_06_42x(pa_ddata)
  DEFINE pa_ddata      DYNAMIC ARRAY OF T_REDO,
         ra_ddata      DYNAMIC ARRAY OF T_REDO
  DEFINE li_i          SMALLINT,
         li_cnt        SMALLINT,
         ls_prog       STRING,
         ls_trigger    STRING,
         ls_cmd        STRING,
         ls_err_msg    STRING,
         ls_sql        STRING,
         lb_result     BOOLEAN
  DEFINE la_link_module_list  DYNAMIC ARRAY OF T_REDO #模組清單
  DEFINE l_dzye003     LIKE dzye_t.dzye003, #類別
         l_dzye005     LIKE dzye_t.dzye005 #模組
  DEFINE lr_redo       T_REDO   


  #Begin: 160816-00047
  #進度列控制-第一階
  IF g_adzp999_01_s01 IS NOT NULL AND g_adzp999_01_s01 THEN
     CALL adzp999_01_refresh_tasks_progressbar(gc_gen_06_sub_link, "adz-00618")                                 
  END IF

  IF g_quick_patch = "Y" THEN
     #進度列控制-第二階
     IF g_adzp999_01_s01 IS NOT NULL AND g_adzp999_01_s01 THEN
        CALL adzp999_01_refresh_sub_tasks_progressbar(1, 1)
     END IF
     DISPLAY "g_quck_patch is ON, skip sadzi888_06_42x()"
     RETURN pa_ddata
  END IF 
  #End: 160816-00047

  #統計哪些程式編譯成功，將成功的依模組別記錄下來，並做連結模組的動作
  #init
  CALL ra_ddata.CLEAR()
  CALL la_link_module_list.CLEAR()

 #Begin:161011-00036 mark
 ##找類別B,Q
 #LET ls_sql = "SELECT COUNT(*)",
 #             "  FROM dzye_t",
 #             " WHERE dzye001='",g_tar_name,"'",
 #             "   AND dzye003=?",
 #             "   AND dzye005=?",
 #             "   AND dzye023='1'" #狀態為成功
 #PREPARE module_list_prep1 FROM ls_sql
 #
 ##找其他類別
 #LET ls_sql = "SELECT DISTINCT dzye005",
 #             "  FROM dzye_t",
 #             " WHERE dzye001='",g_tar_name,"'",
 #             "   AND dzye003 IN ('S','G','X','W')",
 #             "   AND dzye023='1'",#狀態為成功
 #             " ORDER BY dzye005"  
 #PREPARE module_list_prep2 FROM ls_sql
 #DECLARE module_list_curs CURSOR FOR module_list_prep2
 #
 ##找LIB
 #LET l_dzye003='B'
 #LET l_dzye005='LIB'
 #EXECUTE module_list_prep1 INTO li_cnt  USING l_dzye003,l_dzye005
 #IF li_cnt > 0 THEN
 #   LET li_i = la_link_module_list.getlength() + 1
 #   LET la_link_module_list[li_i].module = l_dzye005
 #   LET la_link_module_list[li_i].order = 1
 #END IF
 ##找CLIB
 #LET l_dzye003='B'
 #LET l_dzye005='CLIB'
 #EXECUTE module_list_prep1 INTO li_cnt  USING l_dzye003,l_dzye005
 #IF li_cnt > 0 THEN
 #   LET li_i = la_link_module_list.getlength() + 1
 #   LET la_link_module_list[li_i].module = l_dzye005
 #   LET la_link_module_list[li_i].order = 2
 #END IF
 ##找SUB
 #LET l_dzye003='B'
 #LET l_dzye005='SUB'
 #EXECUTE module_list_prep1 INTO li_cnt  USING l_dzye003,l_dzye005
 #IF li_cnt > 0 THEN
 #   LET li_i = la_link_module_list.getlength() + 1
 #   LET la_link_module_list[li_i].module = l_dzye005
 #   LET la_link_module_list[li_i].order = 3
 #END IF
 ##找CSUB
 #LET l_dzye003='B'
 #LET l_dzye005='CSUB'
 #EXECUTE module_list_prep1 INTO li_cnt  USING l_dzye003,l_dzye005
 #IF li_cnt > 0 THEN
 #   LET li_i = la_link_module_list.getlength() + 1
 #   LET la_link_module_list[li_i].module = l_dzye005
 #   LET la_link_module_list[li_i].order = 4
 #END IF
 ##找QRY
 #LET l_dzye003='Q'
 #LET l_dzye005='QRY'
 #EXECUTE module_list_prep1 INTO li_cnt  USING l_dzye003,l_dzye005
 #IF li_cnt > 0 THEN
 #   LET li_i = la_link_module_list.getlength() + 1
 #   LET la_link_module_list[li_i].module = l_dzye005
 #   LET la_link_module_list[li_i].order = 5
 #END IF
 ##找CQRY
 #LET l_dzye003='Q'
 #LET l_dzye005='CQRY'
 #EXECUTE module_list_prep1 INTO li_cnt  USING l_dzye003,l_dzye005
 #IF li_cnt > 0 THEN
 #   LET li_i = la_link_module_list.getlength() + 1
 #   LET la_link_module_list[li_i].module = l_dzye005
 #   LET la_link_module_list[li_i].order = 6
 #END IF
 #
 ##找其他類別
 #FOREACH module_list_curs INTO l_dzye005
 #   LET li_i = la_link_module_list.getlength() + 1
 #   LET la_link_module_list[li_i].module = l_dzye005
 #   LET la_link_module_list[li_i].order = 7
 #END FOREACH
 #FREE module_list_prep1
 #FREE module_list_prep2
 #FREE module_list_curs
 #End:161011-00036 mark

 #Begin:161011-00036 add
 #找出需要r.l 42x的模組(若是客製模組的話,要連同標準模組也一起link,這樣才完整)
  LET ls_sql = "SELECT dzye005                                              ",
               "  FROM (SELECT dzye005                                      ",
               "          FROM dzye_t                                       ",
               "         WHERE dzye001 ='",g_tar_name,                    "'",                  
               "           AND dzye003 IN ('B','Q','S','G','X','W')         ",
               "        UNION                                               ",
               "        SELECT gzzj003                                      ",
               "          FROM (SELECT dzye005                              ",
               "                  FROM dzye_t                               ",
               "                 WHERE dzye001 ='",g_tar_name,            "'",
               "                   AND dzye003 IN ('B','Q','S','G','X','W'))",
               "         INNER JOIN gzzj_t                                  ",
               "            ON gzzj001 = dzye005)                           ",
               " WHERE dzye005 IS NOT NULL                                  ",
               "   AND dzye005 <> '???'                                     ",
               " ORDER BY dzye005                                           "
  PREPARE module_list_prep3 FROM ls_sql
  DECLARE module_list_curs CURSOR FOR module_list_prep3
  FOREACH module_list_curs INTO l_dzye005
     LET li_i = la_link_module_list.getlength() + 1
     LET la_link_module_list[li_i].module = l_dzye005
     LET la_link_module_list[li_i].order = 1
  END FOREACH
  FREE module_list_prep3
  FREE module_list_curs
 #End: 161011-00036 add

  LET li_cnt = la_link_module_list.getLength()
  FOR li_i = 1 TO li_cnt
     #進度列控制-第二階
     IF g_adzp999_01_s01 IS NOT NULL AND g_adzp999_01_s01 THEN
        CALL adzp999_01_refresh_sub_tasks_progressbar(li_i, li_cnt)
     END IF

     LET ls_cmd = "r.l ",DOWNSHIFT(la_link_module_list[li_i].module)

     #寫一筆到記錄表
     INITIALIZE lr_redo TO NULL                                                                                
     LET lr_redo.tar_name  = g_tar_name
     LET lr_redo.prog = DOWNSHIFT(la_link_module_list[li_i].module),".42x"
     LET lr_redo.type = "L" #類別給L,特殊類別
     LET lr_redo.order = la_link_module_list[li_i].order #順序
     LET lr_redo.done = "42x"
     LET lr_redo.module = la_link_module_list[li_i].module
     LET lr_redo.status = "1" #預設成功
     LET lr_redo.crtdt = cl_get_current()
     LET lr_redo.crtid = g_user
     CALL sadzi888_06_dzye_write_by_prog(lr_redo.*)

     #執行r.l xxx產生42x
     #顯示執行筆數
     LET ls_trigger = "sadzi888_06_after_imp : == (link module):",ls_cmd," (",li_i,"/",li_cnt,")"
     DISPLAY ls_trigger
     CALL cl_cmdrun_openpipe("r.l", ls_cmd, FALSE) RETURNING lb_result,ls_err_msg
     IF NOT lb_result THEN
        LET lr_redo.status = "2"
        LET lr_redo.err = ls_cmd || " " || "ERROR"
        LET lr_redo.errmsg = ls_err_msg
     END IF
     CALL sadzi888_06_dzye_write_by_prog(lr_redo.*)
  END FOR 
  
  #取回執行結果
  CALL sadzi888_06_dzye_read(g_tar_name) RETURNING ls_err_msg,ra_ddata

  RETURN ra_ddata

END FUNCTION


#+依程式清單link程式
PRIVATE FUNCTION sadzi888_06_link_prog(pa_ddata)
  DEFINE pa_ddata      DYNAMIC ARRAY OF T_REDO,
         ra_ddata      DYNAMIC ARRAY OF T_REDO
  DEFINE li_i          SMALLINT,
         li_cnt        SMALLINT,
         ls_prog       STRING,
         ls_trigger    STRING,
         ls_cmd        STRING,
         ls_err_msg    STRING

  DEFINE la_link_prog_list    DYNAMIC ARRAY OF T_REDO #主程式清單

  DEFINE lb_result       BOOLEAN,
         lf_prog         CHAR(20)

  DEFINE lr_redo       T_REDO 
  DEFINE l_pack_dir    STRING #161128-00074


  LET l_pack_dir = FGL_GETENV(g_pack_dir_env)  #161128-00074

  #Begin: 160816-00047
  #進度列控制-第一階
  IF g_adzp999_01_s01 IS NOT NULL AND g_adzp999_01_s01 THEN
     CALL adzp999_01_refresh_tasks_progressbar(gc_gen_06_prog_link, "adz-00620")                                 
  END IF

  IF g_quick_patch = "Y" THEN
     #進度列控制-第二階
     IF g_adzp999_01_s01 IS NOT NULL AND g_adzp999_01_s01 THEN
        CALL adzp999_01_refresh_sub_tasks_progressbar(1, 1)
     END IF
     DISPLAY "g_quck_patch is ON, skip sadzi888_06_link_prog()"
     RETURN pa_ddata
  END IF 
  #End: 160816-00047

  #init
  CALL ra_ddata.CLEAR()
  CALL la_link_prog_list.CLEAR()

  FOR li_i=1 TO pa_ddata.getLength()
     IF pa_ddata[li_i].status = "1"  AND  #成功
        pa_ddata[li_i].type MATCHES  "[MZ]"
     THEN
        LET la_link_prog_list[la_link_prog_list.getLength() + 1].* = pa_ddata[li_i].* 
     END IF
  END FOR
  
  #執行所有程式的link
  LET li_cnt = la_link_prog_list.getLength()
  FOR li_i=1 TO li_cnt
     #進度列控制-第二階
     IF g_adzp999_01_s01 IS NOT NULL AND g_adzp999_01_s01 THEN
        CALL adzp999_01_refresh_sub_tasks_progressbar(li_i, li_cnt)
     END IF

     LET ls_prog = la_link_prog_list[li_i].prog CLIPPED
     LET lf_prog = ls_prog
     #顯示執行筆數
     LET ls_trigger = "sadzi888_06_after_imp : (link prog) ==> ",lf_prog," (",li_i,"/",li_cnt,")"
     DISPLAY ls_trigger
     CALL sadzi888_01_log_file_write(ls_trigger)

     #先寫一筆到記錄表
     INITIALIZE lr_redo TO NULL
     LET lr_redo.* = la_link_prog_list[li_i].* 
     LET lr_redo.stage = "link"
     CALL sadzi888_06_dzye_write_by_prog(lr_redo.*)
  
     #以multi-process執行
     LET ls_cmd = "$FGLRUN $ADZ/42r/adzp988.42r"," ",
                  "''"," ",                         #參數1
                  g_tar_name," ",                   #參數2
                  ls_prog," ",                      #參數3
                  "link"," ",                       #參數4
                  g_run_mode," ",                   #參數5
                  g_auto_merge," ",                 #參數6
                  g_gen42s_flag," ",                #參數7
                 #"2>&1 |tee $TEMPDIR/adzp988_",g_tar_name,"_link_",ls_prog,".log"
                  "2>&1 |tee ",l_pack_dir,"/adzp988_",g_tar_name,"_link_",ls_prog,".log" #161128-00074
     DISPLAY ls_cmd
     CALL sadzi888_01_log_file_write(ls_cmd)
     IF li_i MOD gi_processor = 0 OR li_i=li_cnt THEN                                                                   
        RUN ls_cmd
     ELSE
        RUN ls_cmd WITHOUT WAITING
     END IF
  END FOR
  #等待所有process做完
  CALL sadzi888_06_waiting_process(g_tar_name,"link")

  #取回執行結果
  CALL sadzi888_06_dzye_read(g_tar_name) RETURNING ls_err_msg,ra_ddata

  RETURN ra_ddata

END FUNCTION


#+依清單強制簽入程式:dzlm_t
PRIVATE FUNCTION sadzi888_06_check_in(pa_ddata)
  DEFINE pa_ddata      DYNAMIC ARRAY OF T_REDO,
         la_check_in_list  DYNAMIC ARRAY OF T_REDO
  DEFINE li_i          SMALLINT,
         li_cnt        SMALLINT,
         li_idx        SMALLINT,
         ls_prog       STRING,
         ls_trigger    STRING,
         ls_cmd        STRING,
         ls_err_msg    STRING,
         ls_str        STRING,
         ls_sql        STRING

  DEFINE l_dzlm002     LIKE dzlm_t.dzlm002, #建構項目
         l_dzlm005     LIKE dzlm_t.dzlm005, #建構版次
         l_dzlm012     LIKE dzlm_t.dzlm012,
         l_dzlm015     LIKE dzlm_t.dzlm015,
         l_dzlm008     LIKE dzlm_t.dzlm008,
         l_dzlm011     LIKE dzlm_t.dzlm011,
         l_dzlm017     LIKE dzlm_t.dzlm017,
         l_dzlm008_new LIKE dzlm_t.dzlm008,
         l_dzlm011_new LIKE dzlm_t.dzlm011,
         l_dzlm017_new DATETIME YEAR TO SECOND

  DEFINE ld_local_time DATETIME YEAR TO SECOND
  DEFINE sbuf_msg01    base.StringBuffer,
         ls_result     STRING
  DEFINE ls_dzlm_del_001_trigger STRING
  DEFINE ls_dzlm_del_002_trigger STRING
  DEFINE ls_dzlm_del_003_trigger STRING
  DEFINE ls_dzlm_upd_trigger     STRING
  DEFINE ls_topind               STRING #160407-00009
  DEFINE ls_prog_ind             STRING #160407-00009



  TRY

     LET sbuf_msg01 = base.StringBuffer.create()

     #Begin: 160407-00009 取TOPIND (暫時取,正確應該前端一開始就準備好了)
     LET ls_topind = FGL_GETENV("TOPIND")
     LET ls_topind = ls_topind.trim()
     IF cl_null(ls_topind) THEN
        LET ls_topind = 'sd'
     END IF
     #End: 160407-00009
     
     IF g_top_checkout = "Y" AND pa_ddata.getLength() > 0 THEN #開發環境才需要關注dzlm_t
        LET ls_trigger= "sadzi888_06_after_imp : call sadzi888_06_check_in()"
        DISPLAY ls_trigger
        CALL sadzi888_01_log_file_write(ls_trigger)
     
        LET ld_local_time = cl_get_current() 
        CALL la_check_in_list.CLEAR()
     
        LET ls_sql = "SELECT COUNT(*) FROM dzlm_t",
                     " WHERE dzlm002 = ?",
                     "   AND (dzlm008 ='",cs_check_out,"' OR dzlm011='",cs_check_out,"')"
        PREPARE dzlm_prep_cnt FROM ls_sql
     
        LET ls_sql = "SELECT dzlm008,dzlm011,dzlm012,dzlm015,dzlm017 FROM dzlm_t",
                     " WHERE dzlm002 = ?",
                     "   AND (dzlm008 ='",cs_check_out,"' OR dzlm011='",cs_check_out,"')"
        PREPARE dzlm_prep FROM ls_sql
     
        LET ls_sql = " DELETE FROM dzlm_t",
                     " WHERE dzlm002 = ?"
     #               "   AND (dzlm008 ='",cs_check_out,"' OR dzlm011='",cs_check_out,"')",
     #               "   AND dzlm012 ='",cs_topstd_request_no,"' AND dzlm015 = '",cs_topstd_sequence_no,"'"
        PREPARE dzlm_del_001 FROM ls_sql
        LET ls_dzlm_del_001_trigger = ls_sql

        LET ls_sql = " DELETE FROM dzlm_t",
                     " WHERE dzlm002 = ?",
                    #"   AND dzlm005>= ?"  #20150806
                     "   AND dzlm005> ?"
        PREPARE dzlm_del_002 FROM ls_sql
        LET ls_dzlm_del_002_trigger = ls_sql

        #20151020
        LET ls_sql = " DELETE FROM dzlm_t",
                     " WHERE dzlm002 = ?",
                     "   AND dzlm012= ?", 
                     "   AND dzlm015= ?"
        PREPARE dzlm_del_003 FROM ls_sql
        LET ls_dzlm_del_003_trigger = ls_sql
     
        LET ls_sql = " UPDATE dzlm_t",
                     "    SET dzlm008=? ,",
                     "        dzlm011=? ,",
                     "        dzlm017=?  ",
                     " WHERE dzlm002 = ?",
                     "   AND (dzlm008 ='",cs_check_out,"' OR dzlm011='",cs_check_out,"')",
                     "   AND dzlm012 = ?",
                     "   AND dzlm015 = ?"
        PREPARE dzlm_upd FROM ls_sql
        LET ls_dzlm_upd_trigger = ls_sql
     
        LET li_idx = 0
        FOR li_i=1 TO pa_ddata.getLength()
           IF pa_ddata[li_i].TYPE = "L" THEN
              #do nothing # skip 42x
              DISPLAY "skip check_in prog:",pa_ddata[li_i].prog
           ELSE
              #Begin: 160407-00009
              #標準環境下，dzlm可能多平台共用，所以要卡到每支程式是否為行業別
              IF g_sys_dgenv = g_dgenv_s THEN
                 LET ls_prog_ind = sadzp060_ind_return_industry(pa_ddata[li_i].prog,"1")
                 IF cl_null(ls_prog_ind) THEN LET ls_prog_ind = "sd" END IF
                 IF ls_prog_ind <> ls_topind THEN
                     DISPLAY "skip check_in prog:",pa_ddata[li_i].prog
                     CONTINUE FOR 
                 END IF
              END IF
              #End: 160407-00009

              LET l_dzlm002 = pa_ddata[li_i].prog CLIPPED
              LET l_dzlm005 = pa_ddata[li_i].source_ver #來源建構版次
              
              LET li_cnt=0
              EXECUTE dzlm_prep_cnt INTO li_cnt USING l_dzlm002
              IF li_cnt >0 THEN 
                 #Begin: 161103-00029#6 -modify-  #patch模式下&客製&非元件 不要強制簽入
                 IF (g_run_mode = "4" AND pa_ddata[li_i].identity = "c" AND pa_ddata[li_i].type MATCHES "[MSFWZ]")  THEN
                    #do nothing # skip 42x
                    DISPLAY "skip check_in prog:",pa_ddata[li_i].prog
                    CONTINUE FOR 
                 END IF
                 #End: 161103-00029#6 -modify-

                 LET li_idx =la_check_in_list.getLength() + 1
                 LET la_check_in_list[li_idx].prog =  pa_ddata[li_i].prog
                 LET la_check_in_list[li_idx].type =  pa_ddata[li_i].type
                 LET la_check_in_list[li_idx].module =  pa_ddata[li_i].module
                 LET la_check_in_list[li_idx].status = "1" #default 成功
                 LET la_check_in_list[li_idx].identity =  pa_ddata[li_i].identity
                 LET la_check_in_list[li_idx].merge =  pa_ddata[li_i].merge
              
                 IF li_cnt > 1 THEN
                    LET ls_err_msg = 'ERROR:簽出資訊筆數有問題，請查明:',l_dzlm002,ASCII 10
                    CALL sbuf_msg01.APPEND(ls_err_msg)
                    DISPLAY ls_err_msg
                    CALL sadzi888_01_log_file_write(ls_trigger)
                    LET la_check_in_list[li_idx].status = "2" #失敗
                    LET la_check_in_list[li_idx].err = "check in ERROR"
                 ELSE
                    CASE 
                       WHEN (pa_ddata[li_i].identity <> g_dgenv_c) #若程式尚未被客製過
                          IF g_sys_dgenv = g_dgenv_c THEN  #客戶環境下
                             DISPLAY ls_dzlm_del_001_trigger," ,condition=",l_dzlm002
                             EXECUTE dzlm_del_001 USING l_dzlm002  #強制刪除
                          ELSE
                            #EXECUTE dzlm_del_002 USING l_dzlm002,l_dzlm005  #刪除建構版次>= 來源建構版次的資料
                             DISPLAY ls_dzlm_del_002_trigger," ,condition=",l_dzlm002,",",l_dzlm005
                             EXECUTE dzlm_del_002 USING l_dzlm002,l_dzlm005  #刪除建構版次>  來源建構版次的資料
                          END IF
              
                       OTHERWISE #客製程式
                          EXECUTE dzlm_prep INTO l_dzlm008,l_dzlm011,l_dzlm012,l_dzlm015,l_dzlm017 USING l_dzlm002
                          #若是其他帳號簽出的，表示是標準轉客製:
                          #   1.如果已啟動auto merge: 將dzlm記錄維護為簽入狀態
                          #   2.如果未啟動auto merge: 再判斷該支程式是否必須merge,是的話再將dzlm記錄維護為簽入狀態 
                          IF g_auto_merge = "Y" OR
                            (g_auto_merge <> "Y" AND pa_ddata[li_i].merge="Y") OR
                            ( NOT cl_null(g_run_mode) AND g_run_mode <> "4" ) #非patch模式 
                          THEN
                             IF l_dzlm012=cs_topstd_request_no AND l_dzlm015=cs_topstd_sequence_no THEN #20151020
                                DISPLAY ls_dzlm_del_003_trigger," ,condition=",l_dzlm002,",",l_dzlm012,",",l_dzlm015
                                EXECUTE dzlm_del_003 USING l_dzlm002,l_dzlm012,l_dzlm015  #刪除topstd簽出的資料
                             ELSE
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
                                DISPLAY ls_dzlm_upd_trigger," ,condition=",l_dzlm008_new,",",l_dzlm011_new,",",l_dzlm017_new,",",
                                                                           l_dzlm002,",",l_dzlm012,",",l_dzlm015
                                EXECUTE dzlm_upd USING l_dzlm008_new,l_dzlm011_new,l_dzlm017_new,
                                                       l_dzlm002,l_dzlm012,l_dzlm015
                             END IF
                          ELSE
                             #不做事
                          END IF
                    END CASE
                    IF SQLCA.sqlcode THEN
                       LET la_check_in_list[li_idx].status = "2" #失敗
                       LET la_check_in_list[li_idx].err = "check in ERROR"
                       LET ls_err_msg = 'ERROR:簽入失敗,SQLCA.sqlcoder=',l_dzlm002, " ",SQLCA.sqlcode,ASCII 10
                       CALL sbuf_msg01.APPEND(ls_err_msg)
                       CALL sadzi888_01_log_file_write(ls_trigger)
                    END IF
              
                  #20141208 mark 此段
                  ##EXECUTE dzlm_prep INTO l_dzlm008,l_dzlm011,l_dzlm012,l_dzlm015,l_dzlm017 USING l_dzlm002
                  ##IF l_dzlm012 = cs_topstd_request_no AND l_dzlm015 = cs_topstd_sequence_no THEN
                  ##   #若是帳號topstd簽出的(需求單號及項次應該都是常數9xxx): 將dzlm記錄刪除即可
                  ##   EXECUTE dzlm_del USING l_dzlm002
                  ##   IF SQLCA.sqlcode THEN
                  ##      LET la_check_in_list[li_idx].status = "2"
                  ##      LET la_check_in_list[li_idx].err = "check in fail"
                  ##      LET ls_err_msg = 'ERROR:簽入失敗,SQLCA.sqlcoder=',l_dzlm002, " ",SQLCA.sqlcode, ASCII 10
                  ##      CALL sbuf_msg01.APPEND(ls_err_msg)
                  ##      DISPLAY ls_err_msg
                  ##      CALL sadzi888_01_log_file_write(ls_trigger)
                  ##   END IF
                  ##ELSE
                  ##   #若是其他帳號簽出的，表示是標準轉客製:
                  ##   #   1.如果已啟動auto merge: 將dzlm記錄維護為簽入狀態
                  ##   #   2.如果未啟動auto merge: 再判斷該支程式是否必須merge,是的話再將dzlm記錄維護為簽入狀態 
                  ##   IF g_auto_merge = "Y" OR (g_auto_merge <> "Y" AND pa_ddata[li_i].merge="Y") THEN
                  ##      LET l_dzlm008_new = IIF(l_dzlm008 = cs_check_out,cs_check_in,l_dzlm008)
                  ##      LET l_dzlm011_new = IIF(l_dzlm011 = cs_check_out,cs_check_in,l_dzlm011) 
                  ##      IF (l_dzlm008_new =  cs_check_in AND l_dzlm011_new =  cs_check_in ) OR
                  ##         (l_dzlm008_new =  cs_check_in AND cl_null(l_dzlm011_new))        OR
                  ##         (cl_null(l_dzlm008_new)       AND l_dzlm011_new =  cs_check_in )
                  ##      THEN
                  ##         LET l_dzlm017_new =  ld_local_time
                  ##      ELSE
                  ##         LET l_dzlm017_new =  l_dzlm017
                  ##      END IF
                  ##      EXECUTE dzlm_upd USING l_dzlm008_new,l_dzlm011_new,l_dzlm017_new,
                  ##                             l_dzlm002,l_dzlm012,l_dzlm015
                  ##      IF SQLCA.sqlcode THEN
                  ##         LET la_check_in_list[li_idx].status = "2"
                  ##         LET la_check_in_list[li_idx].err = "check in fail"
                  ##         LET ls_err_msg = 'ERROR:簽入失敗,SQLCA.sqlcoder=',l_dzlm002, " ",SQLCA.sqlcode,ASCII 10
                  ##         CALL sbuf_msg01.APPEND(ls_err_msg)
                  ##         DISPLAY ls_err_msg
                  ##         CALL sadzi888_01_log_file_write(ls_trigger)
                  ##      END IF
                  ##   END IF
                  ##END IF
                 END IF
              END IF
           END IF
        END FOR
     
        IF la_check_in_list.getLength() > 0 THEN
           CALL sadzi888_06_summary(la_check_in_list) RETURNING ls_result
           IF sbuf_msg01.getLength() > 0 THEN
              CALL sbuf_msg01.insertAt(1,ls_result)  
           ELSE
              CALL sbuf_msg01.APPEND(ls_result)  
           END IF
     
           LET ls_str = ASCII 10,"將已簽出程式強制簽入:",ASCII 10,
                         "=====",2 SPACE ,"====================",2 SPACE ,"====",2 SPACE ,"====", 2 SPACE ,"====", 3 SPACE , "=========================",ASCII 10,
                         "module",1 SPACE ,"prog                ",2 SPACE ,"cust",2 SPACE ,"merge", 1 SPACE ,"stat", 3 SPACE , "fail                     ",ASCII 10
           IF sbuf_msg01.getLength() > 0 THEN
              CALL sbuf_msg01.insertAt(1,ls_str)  
           ELSE
              CALL sbuf_msg01.APPEND(ls_str)  
           END IF
        END IF
     END IF
     
     DISPLAY sbuf_msg01.toString()
     RETURN sbuf_msg01.toString()

  CATCH
      #寫log
      LET ls_str = "-> call sadzi888_06_check_in() - Catch exception-",ls_trigger , ASCII 10
      CALL sadzi888_01_log_file_write(ls_str)

      CALL sadzi888_06_err_catch(ls_trigger, ls_sql) 
      RETURN ls_str

  END TRY

END FUNCTION


#+依清單處理4rp相關事項
PRIVATE FUNCTION sadzi888_06_4rp(pa_ddata)
  DEFINE pa_ddata      DYNAMIC ARRAY OF T_REDO
  DEFINE li_i          SMALLINT,
         li_cnt        SMALLINT,
         ls_prog       STRING,
         ls_trigger    STRING,
         ls_cmd        STRING,
         ls_err_msg    STRING,
         ls_str        STRING,
         ls_sql        STRING
  DEFINE sbuf_msg02    base.StringBuffer, #收集錯誤訊息
         lb_result     BOOLEAN,
         ls_result     STRING,
         l_dfile_d     type_g_dfile_d, #程式註冊資料匯出單身-檔案資料
         ls_dfile005   STRING,
         ls_tar_name   STRING


  LET sbuf_msg02 = base.StringBuffer.create()

  #G類要解包GR報表的4rp
  #取得報表4rp tar檔所在路徑 ,檔名目前為 prog-日期.tar
  #注意:temp table 用like + USING似乎有問題,改用for each先讀再過濾	 
  IF pa_ddata.getLength() > 0 THEN
     FOR li_i = 1 TO pa_ddata.getLength() 
         LET pa_ddata[li_i].status = "1" #先預設為成功
         LET pa_ddata[li_i].err = NULL
     END FOR

     FOR li_i = 1 TO pa_ddata.getLength() 
        LET ls_prog = pa_ddata[li_i].prog CLIPPED
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
              LET ls_trigger= "sadzi888_06_after_imp : call sadzp188_rep_unpack(",ls_prog,",",ls_tar_name,")"
              DISPLAY ls_trigger
              CALL sadzi888_01_log_file_write(ls_trigger)
              CALL sadzp188_rep_unpack(ls_prog, ls_tar_name) RETURNING lb_result,ls_err_msg
              IF NOT lb_result THEN 
                 LET pa_ddata[li_i].status = "2" #失敗
                 LET pa_ddata[li_i].err = "rep unpack ERROR"
                 LET ls_err_msg = "ERROR:程式",ls_prog,"的4rp解包過程出現錯誤:",ls_err_msg,ASCII 10
                 CALL sadzi888_01_log_file_write(ls_err_msg)
                 CALL sbuf_msg02.append(ls_err_msg)
              END IF
              EXIT FOREACH #找到一個就離開
           END IF
        END FOREACH 
        FREE dfile_prep
           
        #增加呼叫sadzi888_05_4rpupd (若客製紙張大小,則同步異動4rp)
        LET ls_trigger= "sadzi888_06_after_imp : call sadzi888_05_4rpupd(",ls_prog,")"
        DISPLAY ls_trigger
        CALL sadzi888_01_log_file_write(ls_trigger) 
        CALL sadzi888_05_4rpupd(ls_prog) RETURNING lb_result,ls_err_msg
        IF NOT lb_result THEN 
           LET pa_ddata[li_i].status = "2" #失敗
           IF cl_null( pa_ddata[li_i].err) THEN
              LET pa_ddata[li_i].err = "4rp update ERROR"
           ELSE
              LET pa_ddata[li_i].err = pa_ddata[li_i].err , "|", "4rp update ERROR"
           END IF
           LET ls_err_msg = "ERROR:程式",ls_prog,"的4rp更新過程出現錯誤:",ls_err_msg,ASCII 10
           CALL sadzi888_01_log_file_write(ls_err_msg)
           CALL sbuf_msg02.append(ls_err_msg)
        END IF
     END FOR

     CALL sadzi888_06_summary(pa_ddata) RETURNING ls_result
     IF sbuf_msg02.getLength() > 0 THEN
        CALL sbuf_msg02.insertAt(1,ls_result)  
     ELSE
        CALL sbuf_msg02.APPEND(ls_result)  
     END IF

     LET ls_str = ASCII 10,"4rp處理結果:",ASCII 10,
         "=====",2 SPACE ,"====================",2 SPACE ,"====",2 SPACE ,"====", 2 SPACE ,"====", 3 SPACE , "=========================",ASCII 10,
         "module",1 SPACE ,"prog                ",2 SPACE ,"cust",2 SPACE ,"merge", 1 SPACE ,"stat", 3 SPACE , "fail                     ",ASCII 10
     IF sbuf_msg02.getLength() > 0 THEN
        CALL sbuf_msg02.insertAt(1,ls_str)  
     ELSE
        CALL sbuf_msg02.APPEND(ls_str)  
     END IF
  END IF
  
  DISPLAY sbuf_msg02.toString()
  RETURN sbuf_msg02.toString()

END FUNCTION


#+依清單處理XtraGrid相關事項
PRIVATE FUNCTION sadzi888_06_xg(pa_ddata)
  DEFINE pa_ddata      DYNAMIC ARRAY OF T_REDO
  DEFINE li_i          SMALLINT,
         li_cnt        SMALLINT,
         ls_prog       STRING,
         ls_trigger    STRING,
         ls_cmd        STRING,
         ls_err_msg    STRING,
         ls_str        STRING,
         ls_sql        STRING
  DEFINE sbuf_msg03    base.StringBuffer, #收集錯誤訊息
         lb_result     BOOLEAN,
         ls_result     STRING


  LET sbuf_msg03 = base.StringBuffer.create()

  #X類要比對新/舊版報表元件設計資料
  IF pa_ddata.getLength() > 0 THEN
     FOR li_i = 1 TO pa_ddata.getLength() 
        LET pa_ddata[li_i].status = "1" #先預設成功
        LET pa_ddata[li_i].err = NULL
     END FOR

     FOR li_i = 1 TO pa_ddata.getLength() 
        LET ls_prog = pa_ddata[li_i].prog CLIPPED
        LET ls_trigger= "sadzi888_06_after_imp : call sadzp188_1(",ls_prog,")"
        DISPLAY ls_trigger
        CALL sadzi888_01_log_file_write(ls_trigger)
        CALL sadzp188_1(ls_prog) RETURNING lb_result,ls_err_msg
        IF NOT lb_result THEN 
           LET pa_ddata[li_i].status = "2" #失敗
           LET pa_ddata[li_i].err = "xg ERROR"
           LET ls_err_msg = "ERROR:程式",ls_prog,"呼叫sadzp188_1過程出現錯誤:",ls_err_msg,ASCII 10
           CALL sadzi888_01_log_file_write(ls_err_msg)
           CALL sbuf_msg03.append(ls_err_msg)
        END IF
     END FOR

     CALL sadzi888_06_summary(pa_ddata) RETURNING ls_result
     IF sbuf_msg03.getLength() > 0 THEN
        CALL sbuf_msg03.insertAt(1,ls_result)  
     ELSE
        CALL sbuf_msg03.APPEND(ls_result)  
     END IF

     LET ls_str = ASCII 10,"XtraGrid處理結果:",ASCII 10,
         "=====",2 SPACE ,"====================",2 SPACE ,"====",2 SPACE ,"====", 2 SPACE ,"====", 3 SPACE , "=========================",ASCII 10,
         "module",1 SPACE ,"prog                ",2 SPACE ,"cust",2 SPACE ,"merge", 1 SPACE ,"stat", 3 SPACE , "fail                     ",ASCII 10
     IF sbuf_msg03.getLength() > 0 THEN
        CALL sbuf_msg03.insertAt(1,ls_str)  
     ELSE
        CALL sbuf_msg03.APPEND(ls_str)  
     END IF
  END IF
  
  DISPLAY sbuf_msg03.toString()
  RETURN sbuf_msg03.toString()

END FUNCTION


#+依清單summary結果
PRIVATE FUNCTION sadzi888_06_summary(pa_ddata)
  DEFINE pa_ddata        DYNAMIC ARRAY OF T_REDO
  DEFINE li_i            SMALLINT,
         li_cnt          SMALLINT,
         ls_prog         STRING,
         ls_trigger      STRING,
         ls_cmd          STRING,
         ls_err_msg      STRING

  DEFINE sbuf_summary02  base.StringBuffer  #收集summary
  DEFINE ls_str          STRING
  DEFINE lf_prog         CHAR(20),
         lf_module       CHAR(5),
         lf_status       CHAR(5),
         lf_identity     CHAR(1),
         lf_merge        CHAR(1),
         lf_err          CHAR(50) 


  LET sbuf_summary02 = base.StringBuffer.create()

  IF pa_ddata.getLength() > 0 THEN #有資料才寫
     LET ls_str = "=====",2 SPACE ,"====================",2 SPACE ,"====",2 SPACE ,"====", 2 SPACE ,"====", 3 SPACE , "=========================",ASCII 10
     CALL sbuf_summary02.APPEND(ls_str)
  
     #程式清單
     FOR li_i = 1 TO pa_ddata.getLength()
        CASE pa_ddata[li_i].status
           WHEN "1"   LET lf_status = "ok"
           WHEN "2"   LET lf_status = "ERROR"
                      LET gb_break_error = TRUE
           WHEN "3"   LET lf_status = "skip"
                      LET gb_break_error = TRUE 
           OTHERWISE  LET lf_status = "???"
                      LET gb_break_error = TRUE
        END CASE
        LET lf_module = pa_ddata[li_i].module
        LET lf_prog   = pa_ddata[li_i].prog
        LET lf_err    = pa_ddata[li_i].err
        IF pa_ddata[li_i].identity  = "c" THEN LET lf_identity  = pa_ddata[li_i].identity  ELSE LET lf_identity  = " " END IF
        IF pa_ddata[li_i].merge = "Y" THEN LET lf_merge = pa_ddata[li_i].merge ELSE LET lf_merge = " " END IF
        LET ls_str = lf_module , 2 SPACE ,lf_prog , 3 SPACE , lf_identity ,5 SPACE , lf_merge, 4 SPACE, lf_status , 2 SPACE ,lf_err,ASCII 10
        CALL sbuf_summary02.APPEND(ls_str)
     END FOR
   END IF

   RETURN sbuf_summary02.toString()

END FUNCTION


###+取得程式對應的標準程式是哪一支
PUBLIC FUNCTION sadzi888_06_get_std_prog(p_prog_id)
   DEFINE p_prog_id      STRING,
          r_std_prog_id  STRING
   DEFINE l_gzzb001      LIKE gzzb_t.gzzb001,
          l_gzzb003      LIKE gzzb_t.gzzb003 
   DEFINE ls_trigger     STRING,
          ls_sql         STRING,
          ls_where       STRING
     
  TRY
     LET ls_trigger="sadzi888_06_get_std_prog(",p_prog_id,")"

     LET p_prog_id = p_prog_id.trim()
     IF cl_null(p_prog_id) THEN
        DISPLAY 'ERROR: input value is null'
        RETURN NULL
     END IF

     LET l_gzzb003 = NULL
     LET r_std_prog_id = p_prog_id  #預設先與傳入值一致
     
     LET ls_sql = "SELECT  gzzb003  FROM gzzb_t "
     LET ls_where=" WHERE gzzb001 =?"
     LET ls_sql = ls_sql , ls_where
     PREPARE gzzb_get_prep FROM ls_sql
     LET l_gzzb001 = p_prog_id
     EXECUTE gzzb_get_prep INTO l_gzzb003 USING l_gzzb001
     #有抓到資料& gzzb003不為null時,給gzzb003
     IF NOT SQLCA.sqlcode AND NOT cl_null(l_gzzb003) THEN
        LET r_std_prog_id = l_gzzb003 CLIPPED
     END IF
     FREE gzzb_get_prep 
     
     
     RETURN r_std_prog_id

  CATCH
    DISPLAY "ls_trigger=",ls_trigger
    DISPLAY "SQLCA.SQLCODE=",SQLCA.SQLCODE
    DISPLAY "ls_sql=",ls_sql,"<<"
    RETURN NULL
  END TRY

END FUNCTION

#+設計資料匯入(from adzp990)時要特別卡控:資料來源是tmp_dzye_t
PUBLIC FUNCTION sadzi888_06_before_imp()
   DEFINE l_dzye_d    type_g_dzye_d 
   DEFINE li_cnt      LIKE  type_t.num5
   DEFINE ls_SQL      STRING
   DEFINE ls_err_msg  STRING
   DEFINE ls_alert_msg  STRING
   DEFINE lb_result   BOOLEAN   #20151220
   DEFINE lb_alert    BOOLEAN   #20151220
  #DEFINE ls_g_bgjob_tmp STRING #20150817
   DEFINE ls_topind               STRING #160407-00009
   DEFINE ls_prog_ind             STRING #160407-00009

   #init
   LET ls_err_msg = NULL
   LET lb_result = TRUE         #20151220
   LET lb_alert = FALSE         #20151220
  #LET ls_g_bgjob_tmp = g_bgjob #20150817
  #LET g_bgjob='N'              #強制先切換g_bgjob,離開再還原  20150817
   #Begin: 160407-00009 取TOPIND (暫時取,正確應該前端一開始就準備好了)
   LET ls_topind = FGL_GETENV("TOPIND")
   LET ls_topind = ls_topind.trim()
   IF cl_null(ls_topind) THEN
      LET ls_topind = 'sd'
   END IF
   #End: 160407-00009


   LET ls_sql = "SELECT COUNT(*)",
                "  FROM tmp_dzye_t "
   PREPARE chk_tmp_dzye FROM ls_sql
   EXECUTE chk_tmp_dzye INTO li_cnt
   IF li_cnt = 1 THEN
      #取dzye_t資料
      LET ls_sql = "SELECT dzye001, dzye002, dzye003, dzye004, dzye005, ",
                  "       dzye006, dzye007, dzye008, dzye009, dzye010, ", 
                  "       dzye011, dzye012, dzye013, dzye014, dzye015, ", 
                  "       dzye016, dzye017, dzye018, dzye019, dzye020, ", 
                  "       dzye021, dzye022, dzye023, dzye024 ", 
                  "  FROM tmp_dzye_t " 
      
      PREPARE get_tmp_dzye FROM ls_sql
      EXECUTE get_tmp_dzye INTO l_dzye_d.dzye001, l_dzye_d.dzye002, l_dzye_d.dzye003, l_dzye_d.dzye004, l_dzye_d.dzye005,
                                l_dzye_d.dzye006, l_dzye_d.dzye007, l_dzye_d.dzye008, l_dzye_d.dzye009, l_dzye_d.dzye010,
                                l_dzye_d.dzye011, l_dzye_d.dzye012, l_dzye_d.dzye013, l_dzye_d.dzye014, l_dzye_d.dzye015,
                                l_dzye_d.dzye016, l_dzye_d.dzye017, l_dzye_d.dzye018, l_dzye_d.dzye019, l_dzye_d.dzye020,
                                l_dzye_d.dzye021, l_dzye_d.dzye022, l_dzye_d.dzye023, l_dzye_d.dzye024 

      LET g_imp_progid = l_dzye_d.dzye002 #20150923 
      LET g_imp_progtype = l_dzye_d.dzye003 #160620-00020
 
      ##############################################################################  
      #提醒:
      #要匯入的程式代號為xxx
      LET ls_alert_msg = ls_alert_msg.trim() , cl_getmsg('adz-00628',g_lang),l_dzye_d.dzye002
      
      #提醒:
      #來源或目標若freestyle(dzax003='Y')或改section(m/c)提醒 : 可能樣版會不同, 請先查看樣版(adzi100)後再決定是否匯入
      IF l_dzye_d.dzye003 = "M" OR  l_dzye_d.dzye003 = "S" THEN #20150817
         LET ls_alert_msg = ls_alert_msg.trim() ,"\n", cl_getmsg('adz-00627',g_lang)
      END IF

      #提醒:
      #請問是否確定執行
      LET ls_alert_msg = ls_alert_msg.trim() ,"\n", cl_getmsg('lib-012',g_lang)
      ##############################################################################  

      #顯示必要資訊
      LET ls_err_msg=NULL
      #匯入端環境為標準/客製
      IF g_sys_dgenv = g_dgenv_s THEN 
         LET ls_err_msg = cl_getmsg('adz-00629',g_lang)
      ELSE
         LET ls_err_msg = cl_getmsg('adz-00630',g_lang)
      END IF
      #要匯入的程式代號為xxx 
      LET ls_err_msg = ls_err_msg.trim() ,"\n", cl_getmsg('adz-00628',g_lang),l_dzye_d.dzye002
      #來源版次資訊(建構版次，規格版次，程式版次，識別標示)為
      LET ls_err_msg = ls_err_msg.trim() ,"\n", cl_getmsg('adz-00631',g_lang),"(",l_dzye_d.dzye014 USING "<<<<<" ,",",l_dzye_d.dzye020 USING "<<<<<" ,",",l_dzye_d.dzye021 USING "<<<<<" ,",",l_dzye_d.dzye019,")"
      #匯入端目前版次資訊(建構版次，規格版次，程式版次，識別標示)為 
      LET ls_err_msg = ls_err_msg.trim() ,"\n", cl_getmsg('adz-00632',g_lang),"(",l_dzye_d.dzye009 USING "<<<<<" ,",",l_dzye_d.dzye010 USING "<<<<<" ,",",l_dzye_d.dzye011 USING "<<<<<" ,",",l_dzye_d.dzye012,")" 
      #
      LET ls_err_msg = ls_err_msg.trim() ,"\n", "##########################################################","\n"
      #無法執行匯入，原因如下:
      LET ls_err_msg = ls_err_msg.trim() ,"\n", cl_getmsg('adz-00625',g_lang)

      IF cl_ask_type1(ls_alert_msg, "Info") THEN #詢問一下
         #Begin: 161117-00029
         IF sadzp060_2_chk_spec_type(g_imp_progid) = "N" THEN
            LET lb_result = FALSE
            LET ls_err_msg = ls_err_msg.trim() ,"\n",cl_replace_err_msg(cl_getmsg("adz-00378", g_lang),g_imp_progid) #請確認是否已經註冊
            GOTO _RTN_ERR
         END IF
         #End: 161117-00029

 #20151220 modify -Begin-
       #必要卡控 -Begin-
         #匯入端目前為簽出中

         #Begin: 160407-00009
         #標準環境下，可能多平台共用dzlm，某程式可能top18簽出,但在top38匯入時，會被當作已簽出無法匯入，此情境要放行!
         IF g_sys_dgenv = g_dgenv_s THEN
            LET ls_prog_ind = sadzp060_ind_return_industry(l_dzye_d.dzye002,"1")
            IF cl_null(ls_prog_ind) THEN LET ls_prog_ind = "sd" END IF
            IF ls_prog_ind <> ls_topind THEN
                DISPLAY "skip check_in prog:",l_dzye_d.dzye002
                LET l_dzye_d.dzye022 = "N" #強制設為未簽出，放行
            END IF
         END IF
         #End: 160407-00009

         IF NOT cl_null(l_dzye_d.dzye022) AND l_dzye_d.dzye022 = "Y" THEN #若目標程式為簽出中,擋下來
            IF gb_god_mode THEN
               #do nothing (skip)
            ELSE
              LET lb_result = FALSE
              LET ls_err_msg = ls_err_msg.trim() ,"\n",cl_getmsg('adz-00633',g_lang)
            END IF
         END IF 

         #########################################################
         IF g_sys_dgenv = g_dgenv_s THEN #標準環境
         #########################################################
            #來源包含客製內容
            IF l_dzye_d.dzye019 = g_dgenv_c THEN 
               LET lb_result = FALSE
               LET ls_err_msg = ls_err_msg.trim() ,"\n",cl_getmsg('adz-00634',g_lang)
            END IF
         #########################################################
         ELSE  #客戶環境
         #########################################################
            IF NOT cl_null(l_dzye_d.dzye012) THEN #目標有版次才檢查 (如果是全新的,就不用怕蓋掉目標)
               IF (l_dzye_d.dzye019 = l_dzye_d.dzye012) THEN #來源=目標: s=s , c=c)
                  #do nothing
               ELSE
                  #來源是標準，匯入端已客製
                  IF (l_dzye_d.dzye019=g_dgenv_s) AND (l_dzye_d.dzye012=g_dgenv_c) THEN 
                     LET lb_result = FALSE
                     LET ls_err_msg = ls_err_msg.trim() ,"\n",cl_getmsg('adz-00636',g_lang)
                  END IF
               END IF
            END IF
         END IF
         IF NOT lb_result THEN
            GOTO _RTN_ERR
         END IF
       #必要卡控 -End-


      
       #彈性卡控(詢問) -Begin-
         #########################################################
         IF g_sys_dgenv = g_dgenv_s THEN #標準環境
         #########################################################
            IF NOT cl_null(l_dzye_d.dzye012) THEN #目標有版次才檢查 (如果是全新的,就不用怕蓋掉目標)
               IF (l_dzye_d.dzye019 = l_dzye_d.dzye012) AND  #識別標示
                  (NVL(l_dzye_d.dzye014,0)>= NVL(l_dzye_d.dzye009,0)) AND  #建構版次
                  (NVL(l_dzye_d.dzye020,0)>= NVL(l_dzye_d.dzye010,0)) AND  #規格版次
                  (NVL(l_dzye_d.dzye021,0)>= NVL(l_dzye_d.dzye011,0))      #程式版次
               THEN
                  #do nothing
               ELSE
                  LET lb_alert = TRUE
                  LET ls_err_msg = ls_err_msg.trim() ,"\n",cl_getmsg('adz-00635',g_lang)
               END IF
            END IF
         #########################################################
         ELSE  #客戶環境
         #########################################################
            IF NOT cl_null(l_dzye_d.dzye012) THEN #目標有版次才檢查 (如果是全新的,就不用怕蓋掉目標)
               IF (l_dzye_d.dzye019 = l_dzye_d.dzye012) THEN #來源=目標: s=s , c=c)
                  #do nothing
               ELSE
                  IF (l_dzye_d.dzye019=g_dgenv_c) AND (l_dzye_d.dzye012=g_dgenv_s) THEN
                     #來源包含客製內容，匯入端為標準。
                     LET lb_alert = TRUE
                     LET ls_err_msg = ls_err_msg.trim() ,"\n",cl_getmsg('adz-00637',g_lang) #20151220 修改訊息內容
                  END IF
               END IF
               
               IF (l_dzye_d.dzye019 = l_dzye_d.dzye012) AND  #識別標示
                  (NVL(l_dzye_d.dzye014,0) >= NVL(l_dzye_d.dzye009,0)) AND  #建構版次
                  (NVL(l_dzye_d.dzye020,0) >= NVL(l_dzye_d.dzye010,0)) AND  #規格版次
                  (NVL(l_dzye_d.dzye021,0) >= NVL(l_dzye_d.dzye011,0))      #程式版次
               THEN
                  #do nothing
               ELSE
                  #匯入端目前的版次>來源版次
                  LET lb_alert = TRUE
                  LET ls_err_msg = ls_err_msg.trim() ,"\n",cl_getmsg('adz-00638',g_lang)
               END IF
            END IF
         END IF
       #彈性卡控(詢問) -End-

      ELSE
         LET lb_result = FALSE
         LET ls_err_msg = ls_err_msg.trim() ,"\n", cl_getmsg('adz-00641',g_lang)
      END IF
   END IF

 LABEL _RTN_ERR:
   IF (NOT lb_result) OR #有錯
      (lb_alert)         #有詢問
   THEN
      #do nothing ,保留msg
   ELSE
       LET ls_err_msg = NULL
   END IF

   RETURN lb_result,ls_err_msg
 #20151220 modify -End-

END FUNCTION


#+ 將SA的規格描述資料update
PRIVATE FUNCTION sadzi888_06_upd_sa_spec_data(pa_ddata)
   DEFINE pa_ddata         DYNAMIC ARRAY OF T_REDO
   DEFINE l_spec_desc_tab  DYNAMIC ARRAY OF RECORD    #規格描述資料所屬資料表和欄位
             table         LIKE dzeb_t.dzeb001,  
             pk1           LIKE dzeb_t.dzeb002,  
             pk2           LIKE dzeb_t.dzeb002,  
             col           LIKE dzeb_t.dzeb002
                           END RECORD     
   DEFINE l_i,l_k          LIKE type_t.num5
   DEFINE l_sql            STRING
   DEFINE l_errcode        STRING
   DEFINE sbuf_msg04       base.StringBuffer,
          lb_result        BOOLEAN,
          ls_err_msg       STRING

   
   TRY
   
      LET sbuf_msg04 = base.StringBuffer.create()
      LET lb_result=TRUE
      
      LET l_spec_desc_tab[1].table = "dzab_t"
      LET l_spec_desc_tab[2].table = "dzac_t"
      LET l_spec_desc_tab[3].table = "dzad_t"
      LET l_spec_desc_tab[4].table = "dzaj_t"
      
      LET l_spec_desc_tab[1].col = "dzab099"
      LET l_spec_desc_tab[2].col = "dzac099"
      LET l_spec_desc_tab[3].col = "dzad099"
      LET l_spec_desc_tab[4].col = "dzaj099"
      
      LET l_spec_desc_tab[1].pk1 = "dzab001"
      LET l_spec_desc_tab[2].pk1 = "dzac001"
      LET l_spec_desc_tab[3].pk1 = "dzad001"
      LET l_spec_desc_tab[4].pk1 = "dzaj001"
      
      LET l_spec_desc_tab[1].pk2 = "dzab003"
      LET l_spec_desc_tab[2].pk2 = "dzac012"
      LET l_spec_desc_tab[3].pk2 = "dzad005"
      LET l_spec_desc_tab[4].pk2 = "dzaj004"
      
      FOR l_k = 1 TO pa_ddata.getLength()
         FOR l_i = 1 TO l_spec_desc_tab.getLength()
            LET l_sql = "UPDATE ", l_spec_desc_tab[l_i].table CLIPPED,
                        " SET ", l_spec_desc_tab[l_i].col, " = '' ",
                        "WHERE ",l_spec_desc_tab[l_i].pk1, " = ","'",pa_ddata[l_k].prog CLIPPED ,"'",
                        " AND ",l_spec_desc_tab[l_i].pk2, " = ","'",g_dgenv_s , "'",
                        " AND ",l_spec_desc_tab[l_i].col, " IS NOT NULL"
         
           #DISPLAY "upd sa spec:", l_sql.trim()
            PREPARE sadzi888_06_upd_sa_spec_data_pre FROM l_sql
            IF SQLCA.sqlcode THEN
               LET l_errcode = SQLCA.sqlcode
               LET ls_err_msg = "ERROR-PREPARE sadzi888_06_upd_sa_spec_data_pre.", l_spec_desc_tab[l_i].table CLIPPED, ":", cl_getmsg(l_errcode, g_lang)
               CALL sbuf_msg04.APPEND(ls_err_msg)
            ELSE
               EXECUTE sadzi888_06_upd_sa_spec_data_pre
               IF SQLCA.sqlcode THEN
                  LET l_errcode = SQLCA.sqlcode
                  LET ls_err_msg = "ERROR-exc sadzi888_06_upd_sa_spec_data_pre.", l_sql.trim(), ":", cl_getmsg(l_errcode, g_lang)
                  CALL sbuf_msg04.APPEND(ls_err_msg)
               END IF
            END IF
         END FOR
      END FOR

      #回傳結果
      IF sbuf_msg04.getLength() > 0 THEN
         RETURN FALSE,sbuf_msg04.toSTRING()
      ELSE
         RETURN TRUE,NULL
      END IF
 
   CATCH
     #LET ls_err_msg = l_sql  ,', SQLCA.sqlcode=',cl_getmsg(SQLCA.sqlcode, g_lang)
      LET ls_err_msg = 'ERROR:',l_sql  ,', SQLCA.sqlcode=',cl_getmsg(SQLCA.sqlcode, g_lang)
      CALL sbuf_msg04.APPEND(ls_err_msg)
      RETURN FALSE,sbuf_msg04.toSTRING()

   END TRY
      

END FUNCTION


################################################################################
# Descriptions...: 檢查有沒有dzaf_t資料,有回傳True,沒有回傳False
# Memo...........: 20150923 add
# Usage..........: CALL sadzi888_06_chk_dzaf_count()
################################################################################
PUBLIC FUNCTION sadzi888_06_chk_dzaf_count(p_progid)
   DEFINE p_progid      STRING  
   DEFINE l_dzaf001     LIKE dzaf_t.dzaf001
   DEFINE lb_result     BOOLEAN                   
   DEFINE ls_sql        STRING
   DEFINE li_i          LIKE type_t.num5
   DEFINE li_cnt        LIKE type_t.num5


  LET lb_result=TRUE

  TRY 
     LET ls_sql= "SELECT COUNT(*) FROM dzaf_t WHERE dzaf001=?"
     PREPARE pre_chk_dzaf FROM ls_sql
     
     LET l_dzaf001 = p_progid
     EXECUTE pre_chk_dzaf INTO li_cnt USING l_dzaf001
     IF li_cnt = 0 THEN
        LET lb_result = FALSE
     END IF
     FREE pre_chk_dzaf

     RETURN lb_result  
   
   CATCH
     DISPLAY "ERROR:select dzaf_t fail:",cl_getmsg(SQLCA.sqlcode,g_lang)
     RETURN FALSE
   END TRY

   
END FUNCTION

################################################################################
# Descriptions...: 自動備份(透過設計資料匯出功能)
# Memo...........: 20150923 add
# Usage..........: CALL sadzi888_06_auto_bak()
################################################################################
PUBLIC FUNCTION sadzi888_06_auto_bak()
   DEFINE ls_cmd       STRING
   DEFINE ls_msg       STRING
   DEFINE lb_result    BOOLEAN
   DEFINE l_chk        BOOLEAN        #是否執行成功
   DEFINE l_ch         base.Channel
   DEFINE l_buf        STRING
   DEFINE l_str        STRING
   DEFINE li_pos       LIKE TYPE_t.num5
 

   LET ls_msg = NULL
   LET l_chk  = TRUE

   IF gb_bak_mode THEN
     #自動備份的exp不需要再備份了, ex. 前端是下r.r adzp990 exp aiti001 bak
     #do nothing
   ELSE
      IF sadzi888_06_chk_dzaf_count(g_imp_progid) THEN #有版次資料才做
         LET g_bak_tar_path= NULL
         LET ls_cmd = "r.r adzp990 exp ",g_imp_progid CLIPPED," ","bak"

         #透過Channel.openPipe執行指令
         LET l_ch = base.Channel.create()
         CALL l_ch.setDelimiter("")
         LET ls_cmd = ls_cmd CLIPPED," 2>&1"
         CALL l_ch.openPipe(ls_cmd,"r")   #執行指令
         IF STATUS THEN
            LET ls_msg = "ERROR:",ls_cmd," with error.",cl_getmsg(STATUS,g_lang)
            LET l_chk = FALSE
         ELSE
            WHILE TRUE
               CALL l_ch.readLine() RETURNING l_buf
               IF l_ch.isEof() THEN
                  EXIT WHILE
               END IF
         
               DISPLAY l_buf   #顯示背景訊息

               #取備份檔路徑
               #若備份成功,會吐出備份檔路徑,例如Info:bak file path=/ut/t10dit/tmp/auto_bak-aiti041#17554.tgz
               LET li_pos = l_buf.getIndexOf("Info:bak file path=" ,1)
               IF li_pos > 0 THEN
                  LET g_bak_tar_path = l_buf.subString(li_pos+19,l_buf.getLength())
               END IF

               #有錯誤訊息
               LET l_str = l_buf.toUpperCase()
               IF l_str.getIndexOf("ERROR" ,1) OR l_str.getIndexOf("CP: CANNOT" ,1) THEN
                  LET l_chk = FALSE
                  LET ls_msg = ls_msg CLIPPED," ",ASCII 10,l_buf CLIPPED
               END IF
            END WHILE
         END IF
         CALL l_ch.close()

      ELSE
         LET ls_msg= "Info: no dzaf data , skip auto_bak"
      END IF
   END IF

   RETURN l_chk,ls_msg

END FUNCTION 


#160223-00028 add
################################################################################
# Descriptions...: 取得exp/imp工具版本
# Memo...........: 
# Usage..........: CALL sadzi888_06_get_tool_ver()
# Input parameter :工具名 #exp/imp
# Return code     :執行結果
#                 :版本
################################################################################
PUBLIC FUNCTION sadzi888_06_get_tool_ver(p_tool_id)
   DEFINE p_tool_id     STRING
   DEFINE ls_ver        STRING
   DEFINE ls_cmd        STRING
   DEFINE ls_msg        STRING
   DEFINE lb_result     BOOLEAN
   DEFINE l_channel     base.Channel

   LET lb_result =FALSE
   LET p_tool_id = p_tool_id.toLowerCase()
  
   CASE 
      WHEN p_tool_id ="imp" OR p_tool_id = "exp"
         LET ls_cmd = p_tool_id , " help=y 2>&1 | grep -i release | awk '{print $3}'" 
         DISPLAY "ls_cmd=",ls_cmd
         LET l_channel = base.Channel.create()
         CALL l_channel.setDelimiter("")
         CALL l_channel.openPipe(ls_cmd, "r")
         WHILE l_channel.read(ls_msg)
            #只取第一行資訊，為了取版本號
            EXIT WHILE
         END WHILE
         CALL l_channel.close()
         IF NOT cl_null(ls_msg) THEN
            LET lb_result= TRUE
            LET ls_ver=ls_msg
         END IF
        
      OTHERWISE 
         DISPLAY "Error: tag(",p_tool_id,") not defind!"

   END CASE
   
   RETURN lb_result,ls_ver

END FUNCTION 


#Begin: 161130-00069
FUNCTION sadzi888_06_chk_modi_by_topstd(p_prog)
   DEFINE p_prog      STRING
   DEFINE l_dzbb001   LIKE dzbb_t.dzbb001
   DEFINE li_cnt      LIKE type_t.num5
   DEFINE ls_sql      STRING
   DEFINE rb_result   BOOLEAN

   LET l_dzbb001 = p_prog.trim()
   LET rb_result = FALSE
   LET li_cnt = 0
   LET ls_sql = " SELECT COUNT(1) FROM dzbb_t ",
                "   WHERE dzbb001 =?",
                "     AND dzbb004='s'" ,
                "     AND (LOWER(dzbbcrtid) in ('topstd','topdev') OR LOWER(dzbbmodid) in ('topstd','topdev'))"
  #DISPLAY 'test sql=',ls_sql
   PREPARE dzbb_prep1 FROM ls_sql
   EXECUTE dzbb_prep1 INTO li_cnt USING l_dzbb001
   FREE dzbb_prep1

   IF li_cnt > 0 THEN 
      LET rb_result = TRUE
   ELSE
      LET rb_result = FALSE
   END IF

   RETURN rb_result
END FUNCTION
#End: 161130-00069

#Begin: 170208-00008
#+ 新增資料到dzbj_t (Patch紀錄有異動的標準add point/section清單for追單工具使用)
PRIVATE FUNCTION sadzi888_06_ins_dzbj()
   DEFINE ls_topind        STRING
   DEFINE lr_diff_list  RECORD 
           prog            LIKE dzba_t.dzba001,
           id              LIKE dzba_t.dzba003, #add point id / section id
           std_ver         LIKE dzba_t.dzba004,
           last_ver        LIKE dzba_t.dzba004,
           use_flag        LIKE dzba_t.dzba005, #使用標示s/m
           ind_to_std_prog LIKE dzba_t.dzba001  #行業程式對應的標準程式
          END RECORD
   DEFINE l_sql            STRING
   DEFINE ls_trigger       STRING
   DEFINE l_cnt            LIKE type_t.num10
   DEFINE sbuf_msg05       base.StringBuffer,
          lb_result        BOOLEAN,
          ls_err_msg       STRING
   DEFINE ld_date          DATETIME YEAR TO SECOND
   DEFINE l_dzbj005        LIKE dzbj_t.dzbj005

   
   TRY
      LET ls_trigger= "sadzi888_06_after_imp : call sadzi888_06_ins_dzbj()"
      DISPLAY ls_trigger
      CALL sadzi888_01_log_file_write(ls_trigger)

      LET ld_date = cl_get_current()
      LET ls_topind = FGL_GETENV("TOPIND")
      LET ls_topind = ls_topind.trim()
      IF cl_null(ls_topind) THEN
         LET ls_topind = 'sd'
      END IF
   
      LET sbuf_msg05 = base.StringBuffer.create()
      LET lb_result=TRUE

      #init :
      #不管存在否，先刪除同一patch號的資料
      LET l_dzbj005 = g_tar_name
      DELETE FROM dzbj_t WHERE dzbj005 = l_dzbj005
      #先刪除追單工具的過濾條件設定(reset)
      DELETE FROM dzbk_t 

      CASE ls_topind
        WHEN 'sd' #標準平台
           LET l_sql = 
                    "select final_result.*,'s',final_result.diff_prog_id", 
                    "  from (", 
                    "        select ba_all.dzye002 diff_prog_id,", 
                    "                case", 
                    "                  when ba_all.last_021 is null then", 
                    "                   CASE", 
                    "                     WHEN NVL(ba_all.bas_dzba004,0) <>", 
                    "                          NVL(ba_all.ba1c_dzba004,0) THEN", 
                    "                      ba_all.cust_dzba003", 
                    "                   end", 
                    "                  when ba_all.last_021 is not null then", 
                    "                   case", 
                    "                     when ((ba_all.bas_dzba003 is null) and", 
                    "                          (ba_all.bal_dzba003 is null) and", 
                    "                          (ba_all.ba1c_dzba003 is null)) then", 
                    "                      null", 
                    "                     when NVL(ba_all.bas_dzba004,0) <> NVL(ba_all.bal_dzba004,0) then", 
                    "                      ba_all.cust_dzba003", 
                    "                     else", 
                    "                      NULL", 
                    "                   end", 
                    "                end diff_add_point_id,", 
                    "                ba_all.bas_dzba004 diff_std_ver,",
                    "                case", 
                    "                  when ba_all.last_021 is null then", 
                    "                   case", 
                    "                     when NVL(ba_all.bas_dzba004,0) <>", 
                    "                          nvl(ba_all.ba1c_dzba004,0) then", 
                    "                      ba_all.ba1c_dzba004", 
                    "                   end", 
                    "                  when ba_all.last_021 is not null then", 
                    "                   case", 
                    "                     when ((ba_all.bas_dzba003 is null) and", 
                    "                          (ba_all.bal_dzba003 is null) and", 
                    "                          (ba_all.ba1c_dzba003 is null)) then", 
                    "                      null", 
                    "                     when NVL(ba_all.bas_dzba004,0) <> NVL(ba_all.bal_dzba004,0) then", 
                    "                      ba_all.bal_dzba004", 
                    "                     else", 
                    "                      NULL", 
                    "                   end", 
                    "                end diff_last_ver ",
                    "          from (SELECT ye_orig.dzye002,", 
                    "                        ye_orig.curr_021,", 
                    "                        ye_orig.last_021,", 
                    "                        custp.dzba003    cust_dzba003,", 
                    "                        custp.dzba002    cust_dzba002,", 
                    "                        custp.dzba004    cust_dzba004,", 
                    "                        bas.dzba003      bas_dzba003,", 
                    "                        bas.dzba002      bas_dzba002,", 
                    "                        bas.dzba004      bas_dzba004,", 
                    "                        bal.dzba003      bal_dzba003,", 
                    "                        bal.dzba002      bal_dzba002,", 
                    "                        bal.dzba004      bal_dzba004,", 
                    "                        ba1c.dzba003     ba1c_dzba003,", 
                    "                        ba1c.dzba002     ba1c_dzba002,", 
                    "                        ba1c.dzba004     ba1c_dzba004", 
                    "                   FROM (select yex.dzye002,", 
                    "                                yex.dzye021 curr_021,", 
                    "                                yel.dzye021 last_021", 
                    "                           from dzye_t yex", 
                    "                           left outer join (select ye.dzye002,", 
                    "                                                  max(ye.dzye021) dzye021", 
                    "                                             from dzye_t ye", 
                    "                                            where 1 = 1", 
                    "                                              and ye.dzye001 <> '",g_tar_name,"'", 
                    "                                              and (ye.dzye001 LIKE 'A%' OR", 
                    "                                                  ye.dzye001 LIKE 'B%' OR", 
                    "                                                  ye.dzye001 LIKE 'T%')", 
                    "                                              and ye.dzye021 <=", 
                    "                                                  (select yeo.dzye021", 
                    "                                                     from dzye_t yeo", 
                    "                                                    where yeo.dzye001 ='",g_tar_name,"'",
                    "                                                      and yeo.dzye002 =", 
                    "                                                          ye.dzye002)", 
                    "                                            group by ye.dzye002) yel", 
                    "                             on yel.dzye002 = yex.dzye002", 
                    "                          where yex.dzye001 = '",g_tar_name,"'", 
                    "                            and yex.dzye021 is not null", 
                    "                            and (yex.dzye001 LIKE 'A00%' OR yex.dzye001 LIKE 'B00%' OR", 
                    "                                yex.dzye001 LIKE 'TSD%')) ye_orig", 
                    "                  INNER JOIN (SELECT ba.dzba001,", 
                    "                                    ba.dzba003,", 
                    "                                    ba.dzba002,", 
                    "                                    ba.dzba004", 
                    "                               FROM dzba_t ba", 
                    "                              INNER JOIN dzbb_t bb", 
                    "                                 ON bb.dzbb001 = ba.dzba001", 
                    "                                AND bb.dzbb002 = ba.dzba003", 
                    "                                AND bb.dzbb003 = ba.dzba004", 
                    "                                AND bb.dzbb004 = ba.dzba005", 
                    "                              WHERE 1 = 1", 
                    "                                AND ba.dzba010 = 'c' ",
                    "                                AND ba.dzba002 =", 
                    "                                    (select max(af.dzaf004) dzaf004", 
                    "                                       from dzaf_t af", 
                    "                                      where 1 = 1", 
                    "                                        and af.dzaf001 = ba.dzba001", 
                    "                                        and af.dzaf010 = ba.dzba010", 
                    "                                        and af.dzaf005 not in", 
                    "                                            ('T', 'MT', 'MG', 'MV')) ",
                    "                                AND ba.dzba005 = 'c' ",
                    "                                AND ba.dzbastus = 'Y') custp", 
                    "                     on custp.dzba001 = ye_orig.dzye002", 
                    "                   left outer join (SELECT ba.dzba001,", 
                    "                                          ba.dzba003,", 
                    "                                          ba.dzba002,", 
                    "                                          ba.dzba004", 
                    "                                     FROM dzba_t ba", 
                    "                                    INNER JOIN dzbb_t bb", 
                    "                                       ON bb.dzbb001 = ba.dzba001", 
                    "                                      AND bb.dzbb002 = ba.dzba003", 
                    "                                      AND bb.dzbb003 = ba.dzba004", 
                    "                                      AND bb.dzbb004 = ba.dzba005", 
                    "                                    WHERE 1 = 1", 
                    "                                      AND ba.dzba010 = 's'", 
                    "                                      AND ba.dzba005 = 's'",
                    "                                   ) bas", 
                    "                     on bas.dzba001 = ye_orig.dzye002", 
                    "                    and bas.dzba002 = ye_orig.curr_021", 
                    "                    and bas.dzba003 = custp.dzba003", 
                    "                   left outer join (SELECT ba.dzba001,", 
                    "                                          ba.dzba003,", 
                    "                                          ba.dzba002,", 
                    "                                          ba.dzba004", 
                    "                                     FROM dzba_t ba", 
                    "                                    INNER JOIN dzbb_t bb", 
                    "                                       ON bb.dzbb001 = ba.dzba001", 
                    "                                      AND bb.dzbb002 = ba.dzba003", 
                    "                                      AND bb.dzbb003 = ba.dzba004", 
                    "                                      AND bb.dzbb004 = ba.dzba005", 
                    "                                    WHERE 1 = 1", 
                    "                                      AND ba.dzba010 = 's'", 
                    "                                      AND ba.dzba005 = 's'",
                    "                                   ) bal", 
                    "                     on bal.dzba001 = ye_orig.dzye002", 
                    "                    and bal.dzba002 = ye_orig.last_021", 
                    "                    and bal.dzba003 = custp.dzba003", 
                    "                   left outer join (SELECT ba.dzba001,", 
                    "                                          ba.dzba003,", 
                    "                                          ba.dzba002,", 
                    "                                          ba.dzba004", 
                    "                                     FROM dzba_t ba", 
                    "                                    INNER JOIN dzbb_t bb", 
                    "                                       ON bb.dzbb001 = ba.dzba001", 
                    "                                      AND bb.dzbb002 = ba.dzba003", 
                    "                                      AND bb.dzbb003 = ba.dzba004", 
                    "                                      AND bb.dzbb004 = ba.dzba005", 
                    "                                    WHERE 1 = 1", 
                    "                                      AND ba.dzba010 = 'c'", 
                    "                                      AND ba.dzba002 = 1",
                    "                                      AND ba.dzba005 = 's'",
                    "                                      AND ba.dzbastus = 'Y') ba1c", 
                    "                     on ba1c.dzba001 = ye_orig.dzye002", 
                    "                    and ba1c.dzba003 = custp.dzba003) ba_all", 
                    "        ) final_result", 
                    " where final_result.diff_add_point_id is not null", 
                    "   and final_result.diff_std_ver is not null",
                    " order by final_result.diff_add_point_id"
        OTHERWISE #行業平台
           #todo:保留行業用
           GOTO _RTN_OUT 
      END CASE
      LET ls_trigger= "diff sql=",l_sql
      DISPLAY ls_trigger
      CALL sadzi888_01_log_file_write(ls_trigger)

      PREPARE diff_list_prep1 FROM l_sql
      DECLARE diff_list_curs1 CURSOR FOR diff_list_prep1

 
      LET l_sql="INSERT INTO dzbj_t(dzbj001,dzbj002,dzbj003,dzbj004,dzbj005,dzbj006,dzbj007,dzbj008,",
                                   "dzbjstus,dzbjownid,dzbjowndp,dzbjcrtid,dzbjcrtdp,dzbjcrtdt)",    
                " VALUES(?,?,?,?,'",g_tar_name,"','1',?,?,",
                "'Y','",g_user,"','",g_dept,"','",g_user,"','",g_dept,"',?)"
      PREPARE ins_dzbj_pre FROM l_sql

      LET l_cnt=0
      LET l_dzbj005 = g_tar_name
      FOREACH diff_list_curs1 INTO lr_diff_list.*
        IF cl_null(lr_diff_list.prog) THEN EXIT FOREACH END IF
        EXECUTE ins_dzbj_pre USING lr_diff_list.prog, lr_diff_list.std_ver, lr_diff_list.id, lr_diff_list.last_ver, lr_diff_list.ind_to_std_prog, lr_diff_list.use_flag, ld_date
        INITIALIZE lr_diff_list TO NULL 
        LET l_cnt = l_cnt +1
      END FOREACH
      FREE ins_dzbj_pre
      LET ls_trigger= "ins dzbj_t count=",l_cnt
      DISPLAY ls_trigger
      CALL sadzi888_01_log_file_write(ls_trigger)
 


   LABEL _RTN_OUT:
      #回傳結果
      IF sbuf_msg05.getLength() > 0 THEN
         RETURN FALSE,sbuf_msg05.toSTRING()
      ELSE
         RETURN TRUE,NULL
      END IF
 
   CATCH
     #LET ls_err_msg = l_sql  ,', SQLCA.sqlcode=',cl_getmsg(SQLCA.sqlcode, g_lang)
      LET ls_err_msg = 'ERROR:',l_sql  ,', SQLCA.sqlcode=',cl_getmsg(SQLCA.sqlcode, g_lang)
      CALL sbuf_msg05.APPEND(ls_err_msg)
      RETURN FALSE,sbuf_msg05.toSTRING()

   END TRY
      

END FUNCTION
#End: 170208-00008
