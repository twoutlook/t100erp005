#+ 程式版本......: T6 Version 1.00.00 Build-0001 at 12/10/12
#
#+ 程式代碼......: adzp210
#+ 設計人員......: Jay
# Prog. Version..: 'T6-12.01.21(00000)'     #
#
# Program name   : adzp210.4gl
# Description    : 開窗4gl程式產生
# Memo           :
# Modify.........: 07/11/12 By Henry 因應兆家要修改表格，mark掉共用欄位的部分
#                  2014/05/21 By madey 串查由cl_cmdrun_openpipe改用cl_cmdrun
#                  2014/06/17 By madey 回傳值不自動再將值去空白
#                  2014/07/10 By madey adzp210_define_table_name()停用,搬到新建立的sadzp210_define_table_name()
#                  2014/07/29 By madey field找不到table name時報錯
#                  2014/08/06 By madey adzp210僅編譯不連結,連結由後續呼叫產生q_total(s_azzi070_gen_qry)一併做
#                  2014/08/08 By madey set g_bgjob=Y並dispaly err於背景
#                  2014/08/22 By madey mark FGL_WINMESSAGE
#                  2014/09/03 by madey 透過g_gen42s_flag決定要不要做42s關聯
#                  2014/10/07 by madey 增加PK:客製否欄位dzca002,dzcb004,dzcc009
#                  2014/11/11 by madey 連資料庫由CONNECT TO改用cl_db_connect
#                  2014/11/18 by madey 調整樣版qry_template.4gl header格式
#                  2015/01/07 by madey 調整qry rebuild時,要能支持不自動編譯及連結(透過rebuild工具比較快)
#                  2015/05/29 by madey 擋下hardcode qry透過adzp260的重產
#                  2015/06/16 by Hiko  資料大小寫:從adzi150(dzep023)預設到r.q(dzcc006),再由開發人員調整.
#                  2015/08/04 by madey 調整樣版:當g_qryparam.state = "c"且多選時,可以回傳多組return變數(原本只有1組,且是固定抓第1個回傳欄位),增加樣版變數let_gs_rets_result
#                  2015/08/17 by madey 開窗停用g_gen42s_flag,重產時一律不產生42s
#                  2015/10/05 by madey 1.顯示格式(dzcc010):從adzi150(dzep021)預設到r.q,再由開發人員調整
#                                      2.分頁及排序:不用RANK()改用ROWNUM,解決sql order by順序被rank破壞掉的問題
#                                      3.調整樣版:sqlwhere():當g_qryparam.state=m時,l要將<inwc>納入sql組成
#                                      4.增加欄位:不共用主程式多語言
#                  2015/12/29 by madey 公用變數TODAY給值改為帶TO_DATE格式，解決DBDATE變更及資料型態為timestamp>時sql出錯
#                  2016/01/11 by madey 組CONSTRUCT段欄位時也要加入別名
#                  20160223 160223-00028 by madey :patch優化專案:微調背景訊息內容
#                  20160517 160517-00007 by madey :訊息補強:當從r.t找不到欄位資訊時，多顯示qry_id


IMPORT os
SCHEMA ds

GLOBALS "../../cfg/top_global.inc"
GLOBALS "../4gl/adzi888_global.inc"   #20140903:用g_gen42s_flag

#定義SQL語法中使用的tag名稱常數 
PUBLIC CONSTANT LI_SPACE = 3

CONSTANT G_FIELD_START = "<field>"              #欄位代碼開始符   
CONSTANT G_FIELD_END   = "</field>"             #欄位代碼結束符
CONSTANT G_TABLE_START = "<table>"              #資料表代碼開始符  
CONSTANT G_TABLE_END   = "</table>"             #資料表代碼結束符
CONSTANT G_WHERE_START = "<wc>"                 #Where條件開始符  
CONSTANT G_WHERE_END   = "</wc>"                #Where條件結束符
CONSTANT G_INWC_START  = "<inwc>"               #input段要加入的條件開始符
CONSTANT G_INWC_END    = "</inwc>"              #input段要加入的條件結束符

CONSTANT G_TEMPLATE_FILE = "qry_template.4gl"   #qry的4gl程式樣版檔
#CONSTANT G_MODULE = "qry"                       #qry開窗程式所在路徑  #20141007:mark
CONSTANT g_std_module = "qry"                   #標準qry開窗程式所在路徑 #20141007
CONSTANT g_cust_module = "cqry"                 #客製qry開窗程式所在路徑 #20141007

GLOBALS
   TYPE type_g_dzca_m RECORD  #開窗資料表
                dzca001   LIKE dzca_t.dzca001,  #開窗識別碼
                dzca002   LIKE dzca_t.dzca002,  #說明
                dzca003   LIKE dzca_t.dzca003,  #SQL指令 
                dzca008   LIKE dzca_t.dzca008   #不共用主程式多語言 #20151005
             END RECORD
             
   TYPE type_g_dzcc_d RECORD #開窗畫面設計表
                dzcc001   LIKE dzcc_t.dzcc001,              #開窗識別碼
                dzcc002   LIKE dzcc_t.dzcc002,              #顯現順序 
                dzcc003   LIKE dzcc_t.dzcc003,              #欄位代號
                dzcc004   LIKE dzcc_t.dzcc004,              #顯示控件
                dzcc005   LIKE dzcc_t.dzcc005,              #是否回傳 
                dzcc006   LIKE dzcc_t.dzcc006,              #是否重查 
                dzcc007   LIKE dzcc_t.dzcc007,              #no use
                dzcc010   LIKE dzcc_t.dzcc010,              #顯示格式 #20151005
                dzcc008   LIKE dzcc_t.dzcc008,
                dzcc009   LIKE dzcc_t.dzcc009               #客製
             END RECORD

   DEFINE g_dzca_m        type_g_dzca_m                     #qry_id開窗基本資料表
   DEFINE g_dzcc_d        DYNAMIC ARRAY OF type_g_dzcc_d    #qry_id開窗畫面顯示設定

   DEFINE g_table_field        DYNAMIC ARRAY OF  RECORD
          gs_table     LIKE dzeb_t.dzeb001,
          gs_field     LIKE dzeb_t.dzeb002,
          g_enterprise LIKE type_t.num5
                          END  RECORD
   DEFINE g_module     LIKE gzde_t.gzde002                  #qry開窗程式所在路徑 #20141007
   DEFINE g_compile_flag LIKE type_t.chr1                   #20150107 是否自動編譯

                          
END GLOBALS

DEFINE g_dzca001       LIKE dzca_t.dzca001               #此次處理之qry_id
DEFINE g_dzca002       LIKE dzca_t.dzca002               #20141007
DEFINE g_properties    om.SaxAttributes
DEFINE g_input_inwc    STRING                            #<inwc>...</inwc>其中的內容

MAIN
   DEFINE l_msg        STRING
   DEFINE l_cnt        LIKE type_t.num5 #20141007
   
   WHENEVER ERROR CALL cl_err_msg_log

   #依模組進行系統初始化設定(系統設定)
   CALL cl_tool_init()


   DISPLAY "ARG_VAL(1)",ARG_VAL(1) #[qry程式代碼],r.r 時第一個參數目前好像是帶session key
   DISPLAY "ARG_VAL(2)",ARG_VAL(2) #qry程式代碼
   DISPLAY "ARG_VAL(3)",ARG_VAL(3) #g_gen42s_flag 是否關聯42s
   DISPLAY "ARG_VAL(4)",ARG_VAL(4) #g_compile_flag 是否自動編譯
   LET g_dzca001 = ARG_VAL(2) CLIPPED
  #LET g_gen42s_flag  = ARG_VAL(3) CLIPPED          #20140903
   LET g_compile_flag = ARG_VAL(4) CLIPPED          #20150107


   IF cl_null(g_dzca001) THEN  #開窗的查詢畫面的id
      DISPLAY "THE qry_id is null."
      GOTO _RTN_MAIN #離開
   END IF

   IF cl_null(g_compile_flag) THEN
      LET g_compile_flag = TRUE #預設為TRUE
   END IF

   #20141007 -Begin-
   LET l_cnt = 0
   SELECT COUNT(1) INTO l_cnt FROM dzca_t 
    WHERE dzca001=g_dzca001 AND dzca002='c'
   IF l_cnt >0 THEN
      LET g_module = g_cust_module
      LET g_dzca002 = 'c'
   ELSE
      LET g_module = g_std_module
      LET g_dzca002 = 's'
   END IF
   #20141007 -End-

   #20150529 -Begin-
   IF sadzp210_check_qry_hardcode(g_dzca001,g_dzca002) THEN
      DISPLAY 'Warning: This qry(',g_dzca001,') is hardcode qry, skip generate'
      GOTO _RTN_MAIN  #離開
   END IF
   #20150529 -End-

   
   LET l_msg = ""
   LET g_bgjob="Y" #20140808:madey
   
   #定義轉換用SaxAttributes
   LET g_properties = om.SaxAttributes.create()
   CALL g_properties.addAttribute("qry_id", g_dzca001)   #app_id 程式代號
   CALL g_properties.addAttribute("qry_module", g_module)#模組代號 20141007

  #CONNECT TO "ds"
   CALL cl_db_connect("ds",TRUE)    #20141111
   
   #取得開窗設計器相關設定資料
  #CALL adzp210_fill()         # 組開窗畫面顯示設定
   IF NOT adzp210_fill() THEN  # 組開窗畫面顯示設定
      GOTO _RTN_MAIN
   END IF
   
   #產生流程=> 讀取樣板檔案 / 同時間寫出(一進一出) / 產生器符號中斷,擺放切片或產生code
   #獲取程式基本資料 (含填寫待轉換的對照表)
  #CALL adzp210_read_basic_data()    #20150529:增加回傳TRUE/FALSE
   IF NOT adzp210_read_basic_data() THEN 
      GOTO _RTN_MAIN
   END IF

   #開始進行產生/轉換動作
  #CALL adzp210_read_and_replace() 
   IF NOT adzp210_read_and_replace() THEN
      GOTO _RTN_MAIN
   END IF

   #開始進行產生4fd畫面檔
   CALL sadzp210_gen_4fd()  #呼叫sadzp210.4gl

   IF g_compile_flag = FALSE THEN #20150107
      #do nothing
   ELSE 
      #進行4gl編譯成42m
      LET l_msg = adzp210_compile_file("1")
      
      #進行4fd編譯成42f
      LET l_msg = l_msg, ASCII 10
      LET l_msg = l_msg, adzp210_compile_file("2")
   END IF

  #20140806:mark
  ##進行qry 打包42x
  #LET l_msg = l_msg, ASCII 10
  #LET l_msg = l_msg, adzp210_compile_file("3")

   #show出最後編譯結果,提供使用者判斷是否整個過程都成功
   #這邊show msg的做法並非標準做法,以後應該要再改進
  #CALL FGL_WINMESSAGE("Info", l_msg, "information") #130201 By benson --MARK--

  LABEL _RTN_MAIN :
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN

#+ 取出程式基本資料 <assembly>
PRIVATE FUNCTION adzp210_read_basic_data()
   DEFINE ls_err        STRING
   DEFINE ls_tmp        STRING
   DEFINE ls_field_list STRING     #開窗欄位有那些
   DEFINE l_dzca005     LIKE dzca_t.dzca005
   DEFINE lb_result     BOOLEAN #20140729
   
  #20141007:mark -Begin-
  ##程式描述說明
  #LET ls_tmp = g_dzca_m.dzca002
  ##IF cl_null(ls_tmp) THEN LET ls_err = ls_err, " Assembly:程式描述說明未敍述" END IF
  #CALL g_properties.addAttribute("qry_exp", ls_tmp)
  #20141007:mark -End-
   
   #開窗record array的顯示欄位變數設定
  #LET ls_tmp = adzp210_var_qry_fields()
  #20140729
   CALL adzp210_var_qry_fields() RETURNING lb_result,ls_tmp
   IF NOT lb_result THEN  #有問題的話,ls_tmp放的是錯誤訊息
      LET ls_err = ls_err,ls_tmp
      LET ls_tmp = NULL
      CALL g_properties.addAttribute("var_qry_fields", ls_tmp)
   ELSE
      IF cl_null(ls_tmp) THEN LET ls_err = ls_err, " var_qry_fields:開窗顯示欄位未設定" END IF
      CALL g_properties.addAttribute("var_qry_fields", ls_tmp)
   END IF

   #設定開窗回傳欄位的default值變數名稱
   LET ls_tmp = adzp210_define_var_name("var_gs_defaults", "gs_default") 
   IF cl_null(ls_tmp) THEN LET ls_err = ls_err, " var_gs_defaults:開窗回傳欄位未設定" END IF
   CALL g_properties.addAttribute("var_gs_defaults", ls_tmp)

  #130219 By benson --MARK-- S
  ##設定開窗回傳欄位的return(回傳)值變數名稱
  #LET ls_tmp = adzp210_define_var_name("var_gs_rets", "gs_ret")  
  #IF cl_null(ls_tmp) THEN LET ls_err = ls_err, " var_gs_rets:開窗回傳欄位未設定" END IF
  #CALL g_properties.addAttribute("var_gs_rets", ls_tmp)

  ##主作業呼叫開窗時,需傳入回傳欄位的default值(傳入參數)
  #LET ls_tmp = adzp210_setting_var_name("ps_default")
  #IF cl_null(ls_tmp) THEN LET ls_err = ls_err, " ps_defaults:開窗回傳欄位未設定" END IF
  #CALL g_properties.addAttribute("ps_defaults", ls_tmp)

  ##主作業呼叫開窗時,需傳入回傳欄位的default值參數宣告
  #LET ls_tmp = adzp210_define_var_name("var_ps_defaults", "ps_default")
  #IF cl_null(ls_tmp) THEN LET ls_err = ls_err, " var_ps_defaults:開窗回傳欄位未設定" END IF
  #CALL g_properties.addAttribute("var_ps_defaults", ls_tmp)
   
  ##主作業呼叫開窗時,需return回傳欄位值(回傳參數)
  #LET ls_tmp = adzp210_setting_var_name("gs_ret")
  #IF cl_null(ls_tmp) THEN LET ls_err = ls_err, " return_gs_rets:開窗回傳欄位未設定" END IF
  #CALL g_properties.addAttribute("return_gs_rets", ls_tmp)
  #130219 By benson --MARK-- E

   #主作業呼叫開窗時,預設回傳欄位的回傳預設值
   LET ls_tmp = adzp210_setting_var_value("let_gs_defaults", "gs_default", "g_qryparam.default")
   IF cl_null(ls_tmp) THEN LET ls_err = ls_err, " let_gs_defaults:開窗回傳欄位未設定" END IF
   CALL g_properties.addAttribute("let_gs_defaults", ls_tmp)

   #將回傳欄位的變數INITIALIZE TO NULL
   LET ls_tmp = adzp210_setting_var_value("init_gs_rets", "g_qryparam.return", "TO NULL")
   #IF cl_null(ls_tmp) THEN LET ls_err = ls_err, " init_gs_rets:開窗回傳欄位未設定" END IF
   CALL g_properties.addAttribute("init_gs_rets", ls_tmp)

   #找出要設定comboBox項目的的欄位
   LET ls_tmp = adzp210_find_col_for_comboBox("set_comboBox")
   CALL g_properties.addAttribute("set_comboBox", ls_tmp)

   #CONSTRUCT欄位
   LET ls_tmp = adzp210_setting_construct("cs_body_fields")
   LET ls_field_list = ls_tmp   #紀錄一下開窗欄位有那些
   IF cl_null(ls_tmp) THEN LET ls_err = ls_err, " cs_body_fields:開窗顯示欄位未設定" END IF
   CALL g_properties.addAttribute("cs_body_fields", ls_tmp)

   #CONSTRUCT輸入條件的畫面欄位
   LET ls_tmp = adzp210_setting_construct("cs_sr_name")
   IF cl_null(ls_tmp) THEN LET ls_err = ls_err, " cs_sr_name:開窗顯示欄位未設定" END IF
   CALL g_properties.addAttribute("cs_sr_name", ls_tmp)

  #130219 By benson --MARK-- S
  ##LET回傳欄位的變數 = 畫面使用者所選取的record
  #LET ls_tmp = adzp210_setting_var_value("let_sel_gs_rets", "gs_ret", "gr_qry[li_ac].")
  #IF cl_null(ls_tmp) THEN LET ls_err = ls_err, " let_sel_gs_rets:開窗回傳欄位未設定" END IF
  #CALL g_properties.addAttribute("let_sel_gs_rets", ls_tmp)

  ##LET回傳欄位的變數 = 呼叫開窗時所傳送的預設值
  #LET ls_tmp = adzp210_setting_var_value("let_def_gs_rets", "gs_ret", "gs_default")
  #IF cl_null(ls_tmp) THEN LET ls_err = ls_err, " let_def_gs_rets:開窗回傳欄位未設定" END IF
  #CALL g_properties.addAttribute("let_def_gs_rets", ls_tmp)
  #130219 By benson --MARK-- E

   #130201 By benson --- S
   #LET回傳欄位的變數 = 畫面使用者所選取的record
   LET ls_tmp = adzp210_setting_var_value("let_sel_gs_returns", "g_qryparam.return", "gr_qry[li_ac].")
   IF cl_null(ls_tmp) THEN LET ls_err = ls_err, " let_sel_gs_returns:開窗回傳欄位未設定" END IF
   CALL g_properties.addAttribute("let_sel_gs_returns", ls_tmp)

   #LET回傳欄位的變數 = 呼叫開窗時所傳送的預設值
   LET ls_tmp = adzp210_setting_var_value("let_def_gs_returns", "g_qryparam.return", "gs_default")
   IF cl_null(ls_tmp) THEN LET ls_err = ls_err, " let_def_gs_returns:開窗回傳欄位未設定" END IF
   CALL g_properties.addAttribute("let_def_gs_returns", ls_tmp)
   #130201 By benson --- E


   #開窗SQL
   LET ls_tmp = adzp210_setting_qry_all_sql("qry_all_sql")
   IF cl_null(ls_tmp) THEN LET ls_err = ls_err, " qry_all_sql:開窗SQL未設定或設定錯誤" END IF
   CALL g_properties.addAttribute("qry_all_sql", ls_tmp)

   #開窗SQL
   LET ls_tmp = adzp210_setting_qry_sql("qry_sql")
   IF cl_null(ls_tmp) THEN LET ls_err = ls_err, " qry_sql:開窗SQL未設定或設定錯誤" END IF
   CALL g_properties.addAttribute("qry_sql", ls_tmp)

   #程式串查功能
   LET l_dzca005=""
   SELECT dzca005 INTO l_dzca005 FROM dzca_t WHERE dzca001=g_dzca001
                                               AND dzca002 = g_dzca002 #20141007
   IF NOT cl_null(l_dzca005) THEN
     #20140521:madey 呼叫cl_cmdrun_openpipe() 改用cl_cmdrun()
     #LET ls_tmp = "      ON ACTION cmd",ASCII 10,
     #             "         CALL cl_cmdrun_openpipe('r.r','r.r ",l_dzca005,"',FALSE) RETURNING l_chk,l_msg"
      LET ls_tmp = "      ON ACTION cmd",ASCII 10,
                   "         CALL cl_cmdrun('",l_dzca005,"')"
      #IF cl_null(ls_tmp) THEN LET ls_err = ls_err, " qry_cmd:開窗程式串查沒有設定" END IF
   ELSE
      LET ls_tmp = "      #開窗程式串查沒有設定"
   END IF
   CALL g_properties.addAttribute("qry_cmd", ls_tmp)

   #開窗input段where條件
   LET ls_tmp = g_input_inwc
   #DISPLAY "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
   #DISPLAY "g_input_inwc = ",g_input_inwc
   #DISPLAY "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
   CALL g_properties.addAttribute("input_where", ls_tmp)

   #翻頁功能時
   #---唯一值判斷需靠字串相加會比較準,以下第一版先mark---start-----
   #LET ls_tmp = adzp210_unique_record_condition()
   #IF cl_null(ls_tmp) THEN LET ls_err = ls_err, " unique_record_condition:開窗顯示欄位未設定" END IF
   #CALL g_properties.addAttribute("unique_record_condition", ls_tmp)
   LET ls_tmp = adzp210_unique_record_condition("gr_qry[li_i].")
   IF cl_null(ls_tmp) THEN LET ls_err = ls_err, " unique_record_gr_qry:開窗顯示欄位未設定" END IF
   CALL g_properties.addAttribute("unique_record_gr_qry", ls_tmp)

   LET ls_tmp = adzp210_unique_record_condition("gr_qry_sel[li_j].")
   IF cl_null(ls_tmp) THEN LET ls_err = ls_err, " unique_record_gr_qry_sel:開窗顯示欄位未設定" END IF
   CALL g_properties.addAttribute("unique_record_gr_qry_sel", ls_tmp)
   #---------------------------------------------end-------

   #開窗input array多選時,需要回傳第一個被勾選"回傳"的欄位
  #LET ls_tmp = adzp210_setting_var_value("gs_rets_result", "", "") #20150804
  #IF cl_null(ls_tmp) THEN LET ls_err = ls_err, " gs_rets_result:開窗回傳欄位未設定" END IF
  #CALL g_properties.addAttribute("gs_rets_result", ls_tmp)
   LET ls_tmp = adzp210_setting_var_value("let_gs_rets_result", "g_qryparam.return", "gr_qry_sel[li_i].")
   IF cl_null(ls_tmp) THEN LET ls_err = ls_err, " let_gs_rets_result:開窗回傳欄位未設定" END IF
   CALL g_properties.addAttribute("let_gs_rets_result", ls_tmp)

   #開窗狀態為'm'多選時,需要回傳所有被勾選"回傳"的欄位
   LET ls_tmp = adzp210_setting_var_value("m_mode_result", "", "")
   IF cl_null(ls_tmp) THEN LET ls_err = ls_err, " m_mode_result:開窗回傳欄位未設定" END IF

   #去掉尾端的,'|',字串
   LET ls_tmp = ls_tmp.subString(1,ls_tmp.getLength()-7)
   CALL g_properties.addAttribute("m_mode_result", ls_tmp)

   ##開窗input array多選時,需要回傳第一個被勾選"回傳"的欄位值累加
   #LET ls_tmp = adzp210_setting_var_value("gs_rets_result_plus", "", "")
   #IF cl_null(ls_tmp) THEN LET ls_err = ls_err, " gs_rets_result_plus:開窗回傳欄位未設定" END IF
   #CALL g_properties.addAttribute("gs_rets_result_plus", ls_tmp)
   
   #顯示訊息
   IF NOT cl_null(ls_err) THEN
     #DISPLAY "Error:", ls_err
      DISPLAY "ERROR:", ls_err #160223-00028
      RETURN FALSE
   ELSE 
      RETURN TRUE
   END IF   

END FUNCTION

#+ 程式樣板讀取/程式寫出(一進一出) / 產生器符號中斷,擺放切片或產生code
PRIVATE FUNCTION adzp210_read_and_replace()
   DEFINE lchannel_read           base.Channel
   DEFINE lchannel_write          base.Channel
   DEFINE ls_readline             STRING
   DEFINE ls_text                 STRING
   DEFINE ls_code_filename        STRING
   DEFINE ls_sample_filename      STRING
   DEFINE lb_err                  BOOLEAN

   LET lb_err = FALSE

   LET lchannel_read = base.Channel.create()
   LET lchannel_write = base.Channel.create()

   CALL lchannel_read.setDelimiter("")
   CALL lchannel_write.setDelimiter("")

   #定義取用樣板檔案
  #LET ls_sample_filename = os.Path.join(FGL_GETENV("COM"), G_MODULE)
   LET ls_sample_filename = os.Path.join(FGL_GETENV("COM"), g_std_module) #20141007
   LET ls_sample_filename = os.Path.join(ls_sample_filename, "mdl")
   LET ls_sample_filename = os.Path.join(ls_sample_filename, G_TEMPLATE_FILE)
   DISPLAY "qry--4gl樣板檔位置:", ls_sample_filename

   IF NOT os.Path.exists(ls_sample_filename) THEN
      DISPLAY "ERROR:qry樣板檔案:",ls_sample_filename.trim()," 不存在!" #160223-00028
      LET lb_err = TRUE
      GOTO _RTN_adzp210_read_and_replace
   END IF
   CALL lchannel_read.openFile(ls_sample_filename CLIPPED, "r" )

   #產出程式路徑
   LET ls_code_filename = os.Path.join(FGL_GETENV("COM"), g_module)
   LET ls_code_filename = os.Path.join(ls_code_filename, "4gl")
   LET ls_code_filename = os.Path.join(ls_code_filename, g_dzca001 CLIPPED || ".4gl")
   DISPLAY "產生檔位置:", ls_code_filename

   #如果開窗4gl先前已經存在,則先將4gl更名
   IF os.Path.exists(ls_code_filename) THEN
      IF NOT os.Path.rename(ls_code_filename, ls_code_filename||".bak") THEN
         DISPLAY "開窗4gl檔先前已經存在,但無法更名！"
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code =  "adz-00174"
         LET g_errparam.extend = ""
         LET g_errparam.popup = TRUE
         LET g_errparam.replace[1] =  "rename"
         LET g_errparam.replace[2] = ls_code_filename
         CALL cl_err()
         LET lb_err = TRUE
         GOTO _RTN_adzp210_read_and_replace
      END IF
   END IF
   
   CALL lchannel_write.openFile( ls_code_filename, "w" )

  #20141118 marked
  ##產生程式版本及說明
  #CALL lchannel_write.write(adzp210_prog_memo())

   #讀取及轉換
   WHILE TRUE
   
      LET ls_text = ""
      LET ls_readline = lchannel_read.readLine()
        
      IF lchannel_read.isEof() THEN
         EXIT WHILE
      END IF

      #henry:利用註解取消產生企業編號的where條件_start
      #產生code部分
      #CASE
         #page段落產生
         #WHEN ls_readline.getIndexOf("#entprise - Start -",1) > 0


            #CALL adzp210_check_enterprise()  
            #CALL adzp210_make_enterprise(lchannel_read,lchannel_write) RETURNING lchannel_read,lchannel_write
            #LET ls_readline = ""
			
      #END CASE
      #henry:利用註解取消產生企業編號的where條件_end
      
      #行代換/ 對 ${} 置換
      IF ls_readline.getIndexOf("${",1) AND 
         (ls_readline.getIndexOf("${",1) < ls_readline.getIndexOf("}",1)) THEN
         LET ls_text = adzp210_line_replace(ls_readline)
      END IF

      #一般未進行任何處理段落產出
      IF ls_text IS NULL THEN
         LET ls_text = ls_readline
      END IF
      CALL lchannel_write.write(ls_text)
   END WHILE

   CALL lchannel_read.close()
   CALL lchannel_write.close()

  #修改產生的開窗4gl檔權限
   IF NOT os.Path.chrwx(ls_code_filename, 511) THEN
      DISPLAY "產生的開窗4gl檔無法修改權限為511"
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "adz-00174"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] =  "chmod"
      LET g_errparam.replace[2] = ls_code_filename
      CALL cl_err()
      LET lb_err = TRUE
      GOTO _RTN_adzp210_read_and_replace
   END IF

  LABEL _RTN_adzp210_read_and_replace:
   IF lb_err THEN
      RETURN FALSE
   ELSE
      RETURN TRUE
   END IF
   
END FUNCTION

#+ 產生程式版本及說明
PRIVATE FUNCTION adzp210_prog_memo()
   DEFINE ls_text  STRING

   LET ls_text = ""
   LET ls_text = ls_text, "#+ 程式版本......: T6 Version 1.00.00 Build-", adzp210_prog_buildtime(), " at ", TODAY, "\n#\n"
   LET ls_text = ls_text, "#+ 程式代碼......: ", g_dzca001 CLIPPED, "\n"
   LET ls_text = ls_text, "#+ 設計人員......: ", FGL_GETENV("LOGNAME")

   RETURN ls_text
END FUNCTION

#+ 取出版本建置次數
PRIVATE FUNCTION adzp210_prog_buildtime()
   DEFINE lc_dzaz001   LIKE dzaz_t.dzaz001
   DEFINE li_dzaz002   LIKE dzaz_t.dzaz002
   DEFINE lc_dzaz003   LIKE dzaz_t.dzaz003
   DEFINE lc_dzaz004   DATETIME YEAR TO SECOND

   LET lc_dzaz001 = g_dzca001 CLIPPED
   LET li_dzaz002 = 0
   
   SELECT MAX(dzaz002) INTO li_dzaz002 FROM dzaz_t WHERE dzaz001 = lc_dzaz001
   
   IF STATUS OR li_dzaz002 IS NULL THEN
      LET li_dzaz002 = 0
   END IF
   
   #取得登入帳號
   LET lc_dzaz003 = FGL_GETENV("LOGNAME")
   LET lc_dzaz004 = CURRENT

   INSERT INTO dzaz_t(dzaz001, dzaz002, dzaz003, dzaz004)
      VALUES(lc_dzaz001, li_dzaz002+1, lc_dzaz003, lc_dzaz004)

   RETURN li_dzaz002 USING "&&&&"
END FUNCTION

#+ 逐行代換
PRIVATE FUNCTION adzp210_line_replace(ls_read)
   DEFINE ls_read     STRING
   DEFINE ls_text     STRING
   DEFINE ls_tag      STRING
   DEFINE li_pos1     LIKE type_t.num10
   DEFINE li_pos2     LIKE type_t.num10
   DEFINE ls_temp     STRING                #暫存properties資料用

   LET li_pos1 = ls_read.getIndexOf("${",1)
   LET li_pos2 = ls_read.getIndexOf("}", li_pos1)

   IF li_pos1 > 0 AND li_pos2 > 0 AND li_pos1 < li_pos2 THEN
      LET ls_text = ""
      LET ls_tag = ls_read.subString(li_pos1 +2, li_pos2 -1 ) #取出要置換的tag

      #由SaxAttribute內取出值進行代換
      #不在行首
      IF li_pos1 > 1 THEN
         LET ls_text = ls_read.subString(1, li_pos1 - 1)
      END IF

      #中間段
      LET ls_temp = g_properties.getValue(ls_tag) CLIPPED
         
      LET ls_text = ls_text, g_properties.getValue(ls_tag) CLIPPED,
                       ls_read.subString(li_pos2+1, ls_read.getLength())

      #遞迴處理同行其他組
      IF ls_text.getIndexOf("${",1) THEN
         LET ls_text = adzp210_line_replace(ls_text)
      END IF
   END IF

   RETURN ls_text
END FUNCTION

PRIVATE FUNCTION cl_null(ps_source)
   DEFINE   ps_source    STRING
   DEFINE   li_is_null   LIKE type_t.num5

   IF (ps_source IS NULL) THEN
      LET li_is_null = TRUE
   ELSE
      LET ps_source = ps_source.trim()
      IF (ps_source.getLength() = 0) THEN
         LET li_is_null = TRUE
      END IF
   END IF

   RETURN li_is_null
END FUNCTION

#+ 取出開窗相關設定基本資料 <assembly>
PRIVATE FUNCTION adzp210_fill()
   DEFINE l_sql     STRING
   DEFINE l_ac      LIKE type_t.num5
   DEFINE lb_err    BOOLEAN

   LET lb_err = FALSE
   
   #若讀取不到相關開窗資料代表qry_id設定不存在
   SELECT dzca001,dzca002,dzca003,dzca008  INTO g_dzca_m.* FROM dzca_t WHERE dzca001 = g_dzca001
                                                                 AND dzca002 = g_dzca002 

   LET g_dzca_m.dzca003 = adzp210_filter(g_dzca_m.dzca003)

   IF SQLCA.sqlcode THEN
      DISPLAY "ERROR:Select dzca_t fail:dzca001=",g_dzca001," ,dzca002=",g_dzca002," SQLCA.sqlcode=",SQLCA.sqlcode #20140808
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  SQLCA.sqlcode
      LET g_errparam.extend = "sel"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      #找不到相關qry_id的開窗設定資料,就認定為錯誤,直接離開
      LET lb_err = TRUE
      GOTO _RTN_adzp210_fill
   END IF
   
   #讀取開窗畫面顯示設定   
   CALL g_dzcc_d.clear()    #ga_dzcc_d 單身清除所有資料
   
   LET l_sql = "SELECT dzcc001,dzcc002,dzcc003,dzcc004 ,dzcc005,dzcc006,dzcc007,dzcc010,dzcc008,dzcc009",
               "  FROM dzcc_t",
               " WHERE dzcc001 = ? AND dzcc009 = ? ORDER BY dzcc002"
   
   PREPARE adzp210_pb FROM l_sql
   DECLARE b_fill_cs CURSOR FOR adzp210_pb
 
   LET l_ac = 1
   
   #取得開窗畫面顯示設定資訊
  #OPEN b_fill_cs USING g_dzca001
   OPEN b_fill_cs USING g_dzca001,g_dzca002 #20141007
      
   FOREACH b_fill_cs INTO g_dzcc_d[l_ac].*
      #DISPLAY "開窗顯示畫面:",g_dzcc_d[l_ac].dzcc001 , " "  ,g_dzcc_d[l_ac].dzcc003
      IF SQLCA.sqlcode THEN
         DISPLAY "ERROR:FOREACH fail:",l_sql," dzcc001=",g_dzca001," SQLCA.sqlcode=",SQLCA.sqlcode #20140808
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()
         LET lb_err = TRUE
         EXIT FOREACH
      END IF
      LET l_ac = l_ac + 1
   END FOREACH
   CALL g_dzcc_d.deleteElement(l_ac) 

  LABEL _RTN_adzp210_fill :
    IF lb_err THEN
       RETURN FALSE
    ELSE
       RETURN TRUE
    END IF

END FUNCTION

#+ 移除dzca003其中<inwc>...</inwc>的範圍,並擷取其中的內容
PRIVATE FUNCTION adzp210_filter(p_dzca003)
   DEFINE p_dzca003         STRING
   DEFINE l_dzca003         base.StringBuffer
   DEFINE l_coun_tag_range  STRING              #'<inwc>...</inwc>,' 的範圍
   DEFINE l_inwc            base.StringBuffer
   


   #找出'<inwc>...</inwc>,'的範圍
   LET l_coun_tag_range = p_dzca003.subString(p_dzca003.getIndexOf(G_INWC_START,1), p_dzca003.getIndexOf(G_INWC_END,1)+6)
   #DISPLAY "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
   #DISPLAY "l_coun_tag_range = ",l_coun_tag_range
   #DISPLAY "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
   
   LET g_input_inwc = p_dzca003.subString(p_dzca003.getIndexOf(G_INWC_START,1)+6, p_dzca003.getIndexOf(G_INWC_END,1)-1)
   LET l_inwc = base.StringBuffer.create() 
   CALL l_inwc.append(g_input_inwc CLIPPED)
   CALL adzp210_replace_arg(l_inwc)
   LET g_input_inwc = l_inwc.toString()
   
   LET l_dzca003 = base.StringBuffer.create() 
   CALL l_dzca003.append(p_dzca003 CLIPPED)

   #移除SQL語句中 '<inwc>...</inwc>,' 的範圍
   CALL l_dzca003.replace(l_coun_tag_range,"", 1)

   LET p_dzca003 = l_dzca003.toString()

   RETURN p_dzca003
   
END FUNCTION

#20140710:madey adzp210_define_table_name()停用,搬到sadzp210_define_table_name()
##+ 判斷該欄位參照的table名稱
#PUBLIC FUNCTION adzp210_define_table_name(ps_field)
#   DEFINE ps_field     LIKE dzeb_t.dzeb002
#   DEFINE ls_table     LIKE dzeb_t.dzeb001
#   
#   #dzeb_t:資料表欄位資料檔,找出這個欄位隸屬的資料表代碼
#   SELECT dzeb001 INTO ls_table FROM dzeb_t
#     WHERE dzeb002 = ps_field
#   #DISPLAY "ls_table:",ls_table
#   RETURN ls_table
#END FUNCTION

#+ 定義開窗顯示欄位變數集合record的data type
PRIVATE FUNCTION adzp210_var_qry_fields()  
   DEFINE l_i                 LIKE type_t.num5
   DEFINE l_i_str             STRING
   DEFINE l_k                 LIKE type_t.num5
   DEFINE l_cnt               LIKE type_t.num5
   DEFINE r_qry_fields        base.StringBuffer
   DEFINE ls_table             STRING
   DEFINE l_str               STRING
   
   DEFINE l_table            LIKE dzeb_t.dzeb001
   

   LET r_qry_fields = base.StringBuffer.create() 
   LET l_k = 3
   LET l_cnt = g_dzcc_d.getLength()
   
   #定義處理變數名稱
   FOR l_i = 1 TO l_cnt
      
      #取得欄位隸屬資料表名稱
     #LET l_table = adzp210_define_table_name(g_dzcc_d[l_i].dzcc003)  #20140710:madey
      LET l_table = sadzp210_define_table_name(g_dzcc_d[l_i].dzcc003) #20140710;madey
      #20140729
      IF cl_null(l_table) THEN
        #LET l_str = "field ",g_dzcc_d[l_i].dzcc003, " can not find it's owner table , please check r.t(dzeb_t) " 
         LET l_str = g_dzca001," field(",g_dzcc_d[l_i].dzcc003, ") not found in dzeb_t. Please check r.t" #160517-00007
         RETURN FALSE,l_str
      END IF

      #12/11/09 --start
      LET ls_table = l_table
      LET g_table_field[l_i].gs_table = l_table
      LET g_table_field[l_i].gs_field = g_dzcc_d[l_i].dzcc003
      DISPLAY "gs_table:",g_table_field[l_i].gs_table
      DISPLAY "gs_field:",g_table_field[l_i].gs_field
      #12/11/09 --end
      LET l_str = (LI_SPACE * l_k) SPACES

      LET l_i_str = l_i
      LET l_i_str = l_i_str.trim()
      #取得需命名的欄位變數名稱
      LET l_str = l_str, g_dzcc_d[l_i].dzcc003 CLIPPED,"_",l_i_str

      #取得欄位資料型態
      LET l_str = l_str, LI_SPACE SPACES, "LIKE "
      LET l_str = l_str, ls_table, ".", g_dzcc_d[l_i].dzcc003 CLIPPED

      IF l_i < l_cnt THEN
         LET l_str = l_str, ", \n"
      END IF
      CALL r_qry_fields.append(l_str)
   END FOR

  #RETURN r_qry_fields.toString()
  #20140729
   RETURN TRUE,r_qry_fields.toString()
END FUNCTION

#+ 設定開窗需用到要define的變數名稱
PRIVATE FUNCTION adzp210_define_var_name(p_type, p_prefix)  
   DEFINE p_type              STRING
   DEFINE p_prefix            STRING
   DEFINE l_i                 LIKE type_t.num5
   DEFINE l_k                 LIKE type_t.num5
   DEFINE l_cnt               LIKE type_t.num5
   DEFINE r_var_define        base.StringBuffer
   DEFINE l_str               STRING
   DEFINE l_num               LIKE type_t.num5   #目前使用到第幾個變數名稱
   
   LET r_var_define = base.StringBuffer.create() 
   LET l_k = 1
   LET l_num = 1
   LET l_cnt = g_dzcc_d.getLength()

   #以下為r_var_define範例
   #DEFINE gs_default1       STRING
   #DEFINE gs_ret1           STRING
   
   FOR l_i = 1 TO l_cnt
      #只有需要回傳的欄位,需要定義回傳變數
      IF g_dzcc_d[l_i].dzcc005 <> "Y" THEN
         CONTINUE FOR
      END IF 

      CASE p_type
         #因為"var_ps_defaults"的變數宣告是屬於FUNCTION內的Local變數
         #所以"DEFINE"關鍵字前要加三個空白,這樣格式才會整齊
         WHEN "var_ps_defaults"
            LET l_str = LI_SPACE SPACES
            CALL r_var_define.append(l_str)
      END CASE
      
      #定義變數前綴名稱
      LET l_str = "DEFINE ", p_prefix.trim()
      CALL r_var_define.append(l_str)
      
      #定義變數是第幾個
      CALL r_var_define.append(l_num)
      LET l_num = l_num + 1
      
      #計算空白個數
      CASE p_type
         WHEN "var_ps_defaults"
            #因為"var_ps_defaults"的變數宣告是屬於FUNCTION內的Local變數
            #依據qry_template裡的格式,STRING的datatype必須與變數隔四個空白
            LET l_str = (LI_SPACE + 1) SPACES
            
         OTHERWISE
            #目前其餘皆是Global變數,依據qry_template裡的格式,STRING的datatype必須在第26個位置
            #以下為r_var_define範例,data type的定義開始於第26的位置
            #DEFINE gs_default1       STRING
            #DEFINE gs_ret1           STRING
            IF (l_str.getLength() + 2) < 25 THEN 
               LET l_str = (25 - l_str.getLength() - 1) SPACES
            ELSE
               LET l_str = (LI_SPACE * l_k) SPACES
            END IF
      END CASE

      CALL r_var_define.append(l_str)
      
      #定義變數的data type
      LET l_str = "STRING \n"
      CALL r_var_define.append(l_str)
   END FOR
   
   RETURN r_var_define.toString()
END FUNCTION

#+ 設定開窗需用到傳入和回傳的變數名稱
PRIVATE FUNCTION adzp210_setting_var_name(p_prefix)  
   DEFINE p_prefix            STRING
   DEFINE l_i                 LIKE type_t.num5
   DEFINE l_cnt               LIKE type_t.num5
   DEFINE l_var_name          base.StringBuffer
   DEFINE r_str               STRING
   DEFINE l_num               LIKE type_t.num5   #目前使用到第幾個變數名稱
   
   LET l_var_name = base.StringBuffer.create() 
   LET l_cnt = g_dzcc_d.getLength()
   LET l_num = 1
   
   #定義處理變數名稱
   #以下為r_var_name範例
   #ps_default1, ps_default2, ps_default3
   #gs_ret1, gs_ret2, gs_ret3

   FOR l_i = 1 TO l_cnt
      #只有需要回傳的欄位,需要定義回傳變數
      IF g_dzcc_d[l_i].dzcc005 <> "Y" THEN
         CONTINUE FOR
      END IF 
      
      #定義變數前綴名稱
      CALL l_var_name.append(p_prefix.trim())
      
      #定義變數是第幾個
      CALL l_var_name.append(l_num || ", ")
      LET l_num = l_num + 1
   END FOR

   #去除最後面的", "(逗點和空白二個字元符)
   LET l_cnt = l_var_name.getLength()
   LET r_str = l_var_name.subString(1, l_cnt - 2)
   
   RETURN r_str
END FUNCTION

#+ 設定變數值的來源(ex:LET gs_ret1 = gs_default1)
PRIVATE FUNCTION adzp210_setting_var_value(p_type, p_var_name, p_var_value)  
   DEFINE p_type              STRING
   DEFINE p_var_name          STRING   #左邊的變數名稱 (ex:LET [gs_default]1 = ps_default1)
   DEFINE p_var_value         STRING   #右邊要給值的變數名稱 (ex:LET gs_default1 = [ps_default]1)
   DEFINE l_i                 LIKE type_t.num5
   DEFINE l_i_str             STRING
   DEFINE l_k                 LIKE type_t.num5
   DEFINE l_cnt               LIKE type_t.num5
   DEFINE l_var_name          base.StringBuffer
   DEFINE l_var_value         base.StringBuffer
   DEFINE l_str               STRING
   DEFINE r_str               base.StringBuffer
   DEFINE l_num               LIKE type_t.num5   #目前使用到第幾個變數名稱
   
   LET l_var_name = base.StringBuffer.create() 
   LET l_var_value = base.StringBuffer.create() 
   LET r_str = base.StringBuffer.create() 
   CALL r_str.clear()
   LET l_cnt = g_dzcc_d.getLength()
   LET l_str = ""
   LET l_k = 0
   LET l_num = 1
   
   DISPLAY "p_type = ",p_type
   DISPLAY "g_dzcc_d.getLength() = ",g_dzcc_d.getLength()
   
   
   FOR l_i = 1 TO l_cnt
      #DISPLAY "g_dzcc_d[",l_i,"].dzcc003 = ",g_dzcc_d[l_i].dzcc003
      LET l_i_str = l_i
      LET l_i_str = l_i_str.trim()
      
      #只有需要回傳的欄位,需要定義回傳變數
      IF g_dzcc_d[l_i].dzcc005 <> "Y" THEN
         CONTINUE FOR
      END IF 
      CALL l_var_name.clear()
      CALL l_var_value.clear()

      #定義變數前綴名稱
      CALL l_var_name.append(p_var_name.trim())
      CALL l_var_value.append(p_var_value.trim())
      #定義變數是第幾個
      CALL l_var_name.append(l_num)
      CALL l_var_value.append(l_num)
      LET l_num = l_num + 1
      
      CASE p_type
         WHEN "init_gs_rets"
            #ex:INITIALIZE gs_ret1 TO NULL
            LET l_k = 1
            LET l_str = "INITIALIZE ", l_var_name.toString(), " TO NULL "
            
         WHEN "let_sel_gs_rets"
            #ex:LET gs_ret1 = gr_qry[li_ac].oea01
            LET l_k = 4
            LET l_str = "LET ", l_var_name.toString(), " = ", p_var_value.trim(), g_dzcc_d[l_i].dzcc003 CLIPPED, " CLIPPED"
            
         WHEN "gs_rets_result" #OR "gs_rets_result_plus"
            LET l_k = 0
           #LET l_str = g_dzcc_d[l_i].dzcc003 CLIPPED,"_",l_i_str, " CLIPPED"
            LET l_str = g_dzcc_d[l_i].dzcc003 CLIPPED,"_",l_i_str             #20140617:madey 不自動去空白

         #針對新的開窗型態m,產生要寫入樣版檔的字串
         WHEN "m_mode_result"
            LET l_k = 0
            LET l_str = "gr_qry_sel[li_i].",g_dzcc_d[l_i].dzcc003,"_",l_i_str,",'|',"

         WHEN "let_def_gs_rets"
            LET l_k = 4
            LET l_str = "LET ", l_var_name.toString(), " = ", l_var_value.toString()

         #130201 By benson --- S
         WHEN "let_sel_gs_returns"
            LET l_k = 4
           #LET l_str = "LET ", l_var_name.toString(), " = ", p_var_value.trim(), g_dzcc_d[l_i].dzcc003 CLIPPED,"_",l_i_str, " CLIPPED"
            LET l_str = "LET ", l_var_name.toString(), " = ", p_var_value.trim(), g_dzcc_d[l_i].dzcc003 CLIPPED,"_",l_i_str             #20140617 madey:不自動去空白

         WHEN "let_def_gs_returns"
            LET l_k = 4
            LET l_str = "LET ", l_var_name.toString(), " = ", l_var_value.toString()
         #130201 By benson --- E

         #20150804 -Begin-
         WHEN "let_gs_rets_result"
            LET l_k = 0
            LET l_str = 11 SPACE ,
                            "IF cl_null(" , l_var_name.toString() , ") THEN ",ASCII 10 , 
                        11 SPACE ,
                            "   LET ", l_var_name.toString(), " = ", p_var_value.trim(), g_dzcc_d[l_i].dzcc003 CLIPPED,"_",l_i_str ,ASCII 10,
                        11 SPACE ,
                            "ELSE", ASCII 10,
                        11 SPACE ,
                            "   LET ", l_var_name.toString(), " = ", l_var_name.toString() ,',"|",', p_var_value.trim(), g_dzcc_d[l_i].dzcc003 CLIPPED,"_",l_i_str ,ASCII 10,
                        11 SPACE ,
                            "END IF",ASCII 10
         #20150804 -End-
            
         OTHERWISE
            #ex:LET gs_default1 = ps_default1
            LET l_k = 1
            LET l_str = "LET ", l_var_name.toString(), " = ", l_var_value.toString()
      END CASE

      #格式對齊:依據qry_template看各段落需要空多少空白
      #在字串最前面加上這些空白
      IF l_k <> 0 THEN
         LET l_str = (LI_SPACE * l_k) SPACES, l_str
      END IF
      
      #將[LET 變數 = 值]的字串加入
      CALL r_str.append(l_str || " \n")
      
      #gs_rets_result和gs_rets_result_plus:因為多選時,只需要回傳第一個被勾選"回傳"的欄位
      #因此l_str不為NULL時,識為已經找到第一個需要回傳的欄位,直接離開FOR迴圈
      #IF (p_type = "gs_rets_result" OR p_type = "gs_rets_result_plus") AND (NOT cl_null(l_str)) THEN
      IF (p_type = "gs_rets_result") AND (NOT cl_null(l_str)) THEN
         EXIT FOR
      END IF
   END FOR
   
   RETURN r_str.toString()
END FUNCTION

#+ 找出要設定comboBox項目的的欄位
PRIVATE FUNCTION adzp210_find_col_for_comboBox(p_type)  
   DEFINE p_type              STRING,
          l_i                 LIKE type_t.num5,
          l_i_str             STRING,
          r_str               STRING
   
   LET r_str = ""
   
   CASE p_type
      WHEN "set_comboBox"
         FOR l_i = 1 TO g_dzcc_d.getLength()
            LET l_i_str = l_i
            LET l_i_str = l_i_str.trim()
            #若遇到是combox的元件03
            IF g_dzcc_d[l_i].dzcc004 = "03" THEN
               LET r_str = r_str,g_dzcc_d[l_i].dzcc003 CLIPPED,"_",l_i_str,"|"
            END IF
         END FOR
   END CASE

   LET r_str = r_str.subString(1,r_str.getLength()-1)

   IF cl_null(r_str) THEN
     LET r_str = "   ### 此開窗無comboBox的欄位 ###"
   ELSE 
     LET r_str = "   CALL ",g_dzca001 CLIPPED,"_setting_comboBox('",r_str,"')",ASCII 10
   END IF

   
   RETURN r_str
END FUNCTION

#+ 設定開窗內construct相關欄位資訊
PRIVATE FUNCTION adzp210_setting_construct(p_type)  
   DEFINE p_type              STRING
   DEFINE l_i                 LIKE type_t.num5
   DEFINE l_i_str             STRING
   DEFINE l_cnt               LIKE type_t.num5
   DEFINE r_str               STRING
   
   LET l_cnt = g_dzcc_d.getLength()
   LET r_str = ""

   #取得construct欄位組合
   FOR l_i = 1 TO l_cnt
      LET l_i_str = l_i
      LET l_i_str = l_i_str.trim()
      CASE p_type
         WHEN "cs_body_fields"
           #20160111 by madey -Modify-
            IF cl_null(g_dzcc_d[l_i].dzcc008) THEN
               LET r_str = r_str, g_dzcc_d[l_i].dzcc003 CLIPPED, ", "
            ELSE
               LET r_str = r_str, g_dzcc_d[l_i].dzcc008,".",g_dzcc_d[l_i].dzcc003 CLIPPED, ", "
            END IF
           #20160111 by madey -Modify-
         WHEN "cs_sr_name"
            LET r_str = r_str, "s_qry[1].", g_dzcc_d[l_i].dzcc003 CLIPPED,"_",l_i_str, ", "
      END CASE
   END FOR

   #去除最後面的", "(逗點和空白二個字元符)
   LET l_cnt = r_str.getLength()
   LET r_str = r_str.subString(1, l_cnt - 2)
   RETURN r_str
END FUNCTION

#+ 開窗時選取資料和資料的SQL(lcurs_qry_all:全部選取的cursor)
PRIVATE FUNCTION adzp210_setting_qry_all_sql(p_type)  
   DEFINE p_type              STRING
   DEFINE l_dzca003           base.StringBuffer
   DEFINE l_index             LIKE type_t.num5

   LET l_index = 0
   
   #取得開窗設計器原始SQL
   LET l_dzca003 = base.StringBuffer.create() 
   CALL l_dzca003.append(g_dzca_m.dzca003 CLIPPED) 
   #DISPLAY "g_dzca_m.dzca003:",g_dzca_m.dzca003
   #因為此處SELECT SQL定義為全部選取的SQL
   #所以SELECT的第一個欄位要加上'Y'
   #加入位置在G_FIELD_START(<field>)字串之後即可
   LET l_index = l_dzca003.getIndexOf(G_FIELD_START.trim(), 1)
   
   IF l_index > 0 THEN
      CALL l_dzca003.insertAt(l_index, " 'Y', ") 
   ELSE
      #尚未處理沒有<field>的tag,因為還想不到怎麼處理較好
      DISPLAY "The <field> is null."
   END IF
   
   #因為開窗時可再接受使用者輸入CONSTRUCT條件,
   #所以需要將開窗程式中ls_where(變數)加入本句SQL中
   #加入位置在G_WHERE_END(</wc>)字串之後即可
   DISPLAY "before length:",l_dzca003.getLength()
   CALL adzp210_add_where(l_dzca003)  
   
   #LET l_index = l_dzca003.getIndexOf(G_WHERE_END.trim(), 1)
   #IF l_index > 0 THEN
   #   #判斷一下開窗SQL是否有WHERE <wc></wc>裡沒有where條件的情況
   #   #如果有條件會像:WHERE <wc>1=1</wc>
   #   #所以當("</wc>"的index位置) - ("<wc>"的index位置) = ("<wc>"的字串長度):表示裡面應該沒有where條件式的輸入
   #   IF (l_index - l_dzca003.getIndexOf(G_WHERE_START.trim(), 1)) = G_WHERE_START.getLength() THEN
   #      #因為ls_where是個變數,所以在q_xxx的4gl程式中,加入字串為:[", ls_where CLIPPED, "]
   #      #這樣產生回開窗程式時字串相加才不會錯,ls_where也才會有作用
   #      CALL l_dzca003.insertAt(l_index + G_WHERE_END.getLength(), "\", ls_where CLIPPED, \"")
   #   ELSE
   #      #如果原有的開窗SQL設定中已經有where條件
   #      #則用 AND 方式將原有條件和開窗後使用者輸入條件(ls_where)串在一起
   #      CALL l_dzca003.insertAt(l_index + G_WHERE_END.getLength(), " AND \", ls_where CLIPPED, \"") 
   #   END IF 
   #ELSE
   #   #尚未處理沒有where條件的SQL,因為還想不到怎麼處理較好
   #   DISPLAY "The </wc> is null."
   #END IF
   
   #SQL需輸出回4gl程式,必須將相關tag的字元符先行剔除,才有辦法執行這句SQL
   CALL adzp210_remove_tag(l_dzca003)
   CALL adzp210_replace_arg(l_dzca003)

   
   #CALL l_dzca003.replace(G_FIELD_START, "", 1)
   #CALL l_dzca003.replace(G_FIELD_END, "", 1) 
   #CALL l_dzca003.replace(G_TABLE_START, "", 1)
   #CALL l_dzca003.replace(G_TABLE_END, "", 1) 
   #CALL l_dzca003.replace(G_WHERE_START, "", 1)
   #CALL l_dzca003.replace(G_WHERE_END, "", 1) 
      
   ##另外怕使用者輸入";"會影響SQL執行,因此也先行剔除
   #CALL l_dzca003.replace(";", "", 1)
   DISPLAY l_dzca003.toString()
   RETURN l_dzca003.toString()
END FUNCTION

#+ 開窗時選取資料和資料的SQL(lcurs_qry:顯示在開窗UI上的SQL,含翻頁功能)
PRIVATE FUNCTION adzp210_setting_qry_sql(p_type)  
   DEFINE p_type              STRING
   DEFINE l_field_list        STRING              #SELECT的欄位
   DEFINE l_dzca003           base.StringBuffer
   DEFINE l_index             LIKE type_t.num5
   DEFINE l_i                 LIKE type_t.num5
   DEFINE l_i_str             STRING
   DEFINE l_cnt               LIKE type_t.num5
  #DEFINE l_rank_field        STRING              #RANK的欄位 #20151005 mark
   DEFINE l_str               STRING
   DEFINE l_field_alias_str   STRING
   DEFINE l_replace_str       STRING
   
   LET l_index = 0
   LET l_field_list = ""
  #LET l_rank_field = "" #20151005 mark
   LET l_str = ""
   LET l_cnt = g_dzcc_d.getLength()
   
   #取得開窗設計器原始SQL
   LET l_dzca003 = base.StringBuffer.create() 
   CALL l_dzca003.append(g_dzca_m.dzca003 CLIPPED)
   

   #處理翻頁功能的RANK Order by欄位
   #先取得要RANK的欄位有那些
   FOR l_i = 1 TO l_cnt
      LET l_i_str =  l_i
      LET l_i_str = l_i_str.trim()
      DISPLAY "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   ########################### "
      DISPLAY "g_dzcc_d[",l_i,"].dzcc008 = ",g_dzcc_d[l_i].dzcc008
      IF cl_null(g_dzcc_d[l_i].dzcc008) THEN
         LET l_field_alias_str = l_field_alias_str,g_dzcc_d[l_i].dzcc003 CLIPPED," ",g_dzcc_d[l_i].dzcc003 CLIPPED,"_",l_i_str, ", "
      ELSE
         LET l_field_alias_str = l_field_alias_str,g_dzcc_d[l_i].dzcc008,".",g_dzcc_d[l_i].dzcc003 CLIPPED," ",g_dzcc_d[l_i].dzcc003 CLIPPED,"_",l_i_str, ", "
      END IF
      
      LET l_field_list = l_field_list, g_dzcc_d[l_i].dzcc003 CLIPPED,"_",l_i_str, ", "

     #20151005 mark -Begin-
     #IF g_dzcc_d[l_i].dzcc007 <> "Y" THEN
     #   CONTINUE FOR
     #END IF 
     #
     #LET l_rank_field = l_rank_field, g_dzcc_d[l_i].dzcc003 CLIPPED,"_",l_i_str, ", "
     #20151005 mark -End-


   END FOR

   LET l_field_alias_str = l_field_alias_str.subString(1, l_field_alias_str.getLength() - 2)
   LET l_replace_str = l_dzca003.toString()
   LET l_replace_str = l_replace_str.subString(l_replace_str.getIndexOf(G_FIELD_START,1),l_replace_str.getIndexOf(G_FIELD_END,1)+7)

   DISPLAY "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
   DISPLAY "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
   DISPLAY "l_field_alias_str = ",l_field_alias_str
   DISPLAY "l_dzca003.toString() = ",l_dzca003.toString()
   DISPLAY "l_replace_str = ",l_replace_str
   DISPLAY "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
   DISPLAY "%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%"
   LET l_field_alias_str = G_FIELD_START,l_field_alias_str,G_FIELD_END
   CALL l_dzca003.replace(l_replace_str,l_field_alias_str,1)

   #去除最後面的", "(逗點和空白二個字元符)
   IF NOT cl_null(l_field_list) THEN
      LET l_field_list = l_field_list.subString(1, l_field_list.getLength() - 2)
   END IF
  #20151005 mark 
  #IF NOT cl_null(l_rank_field) THEN
  #   LET l_rank_field = l_rank_field.subString(1, l_rank_field.getLength() - 2)
  #END IF

   #將RANK() OVER 排序功能的語法加入整句SQL中
   #先檢查一下開窗設計時,有沒有設定要RANK的欄位
   #如果沒有設定就依[開窗畫面顯示設定]單身資料的欄位,將所有欄位依序號(dzcc002)做RANK的依據

   #IF cl_null(l_rank_field) THEN
   #   LET l_str = ", RANK() OVER(ORDER BY ", l_field_list.trim(), ") AS RANK "
   #ELSE
   #   LET l_str = ", RANK() OVER(ORDER BY ", l_rank_field.trim(), ") AS RANK "
   #END IF


   #12/11/28 start
   LET l_str = "(" #組子查詢
   CALL l_dzca003.insertAt(1, l_str)
   #12/11/28 end 
   
   #加入位置在G_FIELD_END(</field>)字串之後即可
   #DISPLAY "l_dzca003 before:",l_dzca003.toString()
   #LET l_index = l_dzca003.getIndexOf(G_FIELD_END.trim(), 1)
   #IF l_index > 0 THEN
   #   CALL l_dzca003.insertAt(l_index, l_str) 
   #ELSE
      #尚未處理沒有</field>的tag,因為還想不到怎麼處理較好
   #   DISPLAY "The </field> is null."
   #END IF
   #DISPLAY "l_dzca003 middle:",l_dzca003.toString()
   #因為開窗時可再接受使用者輸入CONSTRUCT條件,
   #所以需要將開窗程式中ls_where(變數)加入本句SQL中
   #加入位置在G_WHERE_END(</wc>)字串之後即可
   CALL adzp210_add_where(l_dzca003)

   #12/11/28 start
   LET l_str = ")" #組子查詢
   CALL l_dzca003.append(l_str)
   #12/11/28 end 
   
  #20151005 mark -Begin-
  #IF cl_null(l_rank_field) THEN
  #   LET l_str = ", RANK() OVER(ORDER BY ", l_field_list.trim(), ") AS RANK "
  #ELSE
  #   #13/040/03 henry 不使用l_rank_field,使用l_field_list,避免發生要使用捲軸的情況
  #   LET l_str = ", RANK() OVER(ORDER BY ", l_field_list.trim(), ") AS RANK "
  #   #LET l_str = ", RANK() OVER(ORDER BY ", l_rank_field.trim(), ") AS RANK "
  #END IF 
  #20151005 mark -Begin-

   LET l_str = ", ROWNUM AS RANK " #20151005
   
   LET l_str = " SELECT " , l_field_list.trim() , l_str ," FROM "
   CALL l_dzca003.insertAt(1,l_str)
   #LET l_index = l_dzca003.getIndexOf(G_WHERE_END.trim(), 1)
   #IF l_index > 0 THEN
   #   #判斷一下開窗SQL是否有WHERE <wc></wc>裡沒有where條件的情況
   #   #如果有條件會像:WHERE <wc>1=1</wc>
   #   #所以當("</wc>"的index位置) - ("<wc>"的index位置) = ("<wc>"的字串長度):表示裡面應該沒有where條件式的輸入
   #   IF (l_index - l_dzca003.getIndexOf(G_WHERE_START.trim(), 1)) = G_WHERE_START.getLength() THEN
   #      #因為ls_where是個變數,所以在q_xxx的4gl程式中,加入字串為:[", ls_where CLIPPED, "]
   #      #這樣產生回開窗程式時字串相加才不會錯,ls_where也才會有作用
   #      CALL l_dzca003.insertAt(l_index + G_WHERE_END.getLength(), "\", ls_where CLIPPED, \"")
   #   ELSE
   #      #如果原有的開窗SQL設定中已經有where條件
   #      #則用 AND 方式將原有條件和開窗後使用者輸入條件(ls_where)串在一起
   #      CALL l_dzca003.insertAt(l_index + G_WHERE_END.getLength(), " AND \", ls_where CLIPPED, \"") 
   #   END IF 
   #ELSE
   #   #尚未處理沒有where條件的SQL,因為還想不到怎麼處理較好
   #   DISPLAY "The </wc> is null."
   #END IF

   #處理開窗時的SQL(含翻頁功能)
   #原本在開窗設計器所設好之SQL當成子查詢(sub query)
   #而開窗的SQL第一個欄位為check欄位,預設'N', 最後一個欄位為RANK

   
   LET l_str = "SELECT 'N', ", l_field_list.trim(), ", RANK \n  FROM ("
   CALL l_dzca003.insertAt(1, l_str)
   CALL l_dzca003.append(")")   
   
   #SQL需輸出回4gl程式,必須將相關tag的字元符先行剔除,才有辦法執行這句SQL
   CALL adzp210_remove_tag(l_dzca003)
   CALL adzp210_replace_arg(l_dzca003)
   
   RETURN l_dzca003.toString()
END FUNCTION

#+ 開窗執行翻頁功能時,需將使用者之前所勾選過的record,再度於開窗畫面顯示為勾選狀態
#  所以這裡就是開窗畫面的每一筆 record 唯一值的判斷式
#  ex:IF gr_qry_sel[li_j].oea01 = gr_qry[li_i].oea01 THEN
PRIVATE FUNCTION adzp210_unique_record_condition(p_prefix)  
   DEFINE p_prefix            STRING
   DEFINE l_i                 LIKE type_t.num5
   DEFINE l_i_str             STRING
   DEFINE l_cnt               LIKE type_t.num5
   #DEFINE l_left_condition    STRING
   #DEFINE l_right_condition   STRING
   DEFINE l_str               STRING

   LET l_str = ""
   LET l_cnt = g_dzcc_d.getLength()

   #因為目前開窗record唯一值的判斷方式還沒有最佳的解法
   #目前做法是先將所有欄位的值用字串方式串起來
   #gr_qry再和gr_qry_sel(紀錄之前勾選資料)的陣列做比對
   FOR l_i = 1 TO l_cnt
      LET l_i_str = l_i
      LET l_i_str = l_i_str.trim()
      LET l_str = l_str, p_prefix.trim(), g_dzcc_d[l_i].dzcc003 CLIPPED,"_",l_i_str, ", "
   END FOR

   #去除最後面的", "(逗點和空白二個字元符)
   LET l_cnt = l_str.getLength()
   LET l_str = l_str.subString(1, l_cnt - 2)
   RETURN l_str
   
   #LET l_left_condition = ""
   #LET l_right_condition = ""
   #LET l_str = ""
   #LET l_cnt = g_dzcc_d.getLength()

   ##因為目前開窗record唯一值的判斷方式還沒有最佳的解法
   ##暫時先將所有欄位的值相加起來,看看左右二邊的等式,相加後的值是否相等
   #FOR l_i = 1 TO l_cnt
   #   LET l_left_condition = l_left_condition, "gr_qry_sel[li_j].", g_dzcc_d[l_i].dzcc003 CLIPPED, " || "
   #   LET l_right_condition = l_right_condition, "gr_qry[li_i].", g_dzcc_d[l_i].dzcc003 CLIPPED, " || "
   #END FOR

   ##去除最後面的" || "(||和前後二個空白共四個字元符)
   #LET l_left_condition = l_left_condition.subString(1, l_left_condition.getLength() - 4)
   #LET l_right_condition = l_right_condition.subString(1, l_right_condition.getLength() - 4)

   #LET l_str = "(", l_left_condition, ") = (", l_right_condition, ")"
   #RETURN l_str
END FUNCTION

#+ 編譯開窗的4gl和4fd,實際生成q_xxx 42m和42f畫面檔
PRIVATE FUNCTION adzp210_compile_file(p_type)
   DEFINE p_type                  LIKE type_t.chr1  #要編譯的檔案類型--1:開窗的4gl ; 2:開窗的4fd
   DEFINE ls_str                  STRING
   DEFINE l_read                  base.Channel
   DEFINE l_cmd                   STRING            #要執行的指令
   DEFINE l_path                  STRING            #要編譯的路徑
   DEFINE l_msg                   STRING            #編譯後訊息
   DEFINE l_chk                   LIKE type_t.num5  #130201 By benson
   DEFINE l_cnt                   LIKE type_t.num5
   DEFINE l_gzzn001               LIKE gzzn_t.gzzn001
   DEFINE lc_channel base.Channel
   
   LET l_read = base.Channel.create()
   LET l_cmd = ""
   LET l_path = ""
   LET l_msg = ""
   LET l_chk = ""                                   #130201 By benson 

   
   
   #因為要編譯開窗的4gl或4fd檔需先進行切換目錄到該qry相對路徑下
   #才可進行編譯動作
   LET l_path = os.Path.join(FGL_GETENV("COM"), g_module)
   
   #4gl和4fd存放路徑不同,編譯方式也不同
   CASE p_type
      WHEN "1"   #4gl
         LET l_path = os.Path.join(l_path, "4gl")
         LET l_cmd = "r.c ", g_dzca001
         #130201 By benson --- S
         #切換目錄
         LET l_cmd = "cd ", l_path.trim(), "; ", l_cmd
         DISPLAY l_cmd
         CALL cl_cmdrun_openpipe('r.c',l_cmd,TRUE) RETURNING l_chk,l_msg
         #130201 By benson --- E
      WHEN "2"   #4fd
         LET l_path = os.Path.join(l_path, "4fd")
         LET l_cmd = "r.f ", g_dzca001 || " " || g_gen42s_arg2  #20140903 #此處先不關聯42s

         #130201 By benson --- S
         #切換目錄
         LET l_cmd = "cd ", l_path.trim(), "; ", l_cmd
         DISPLAY l_cmd
         CALL cl_cmdrun_openpipe('r.f',l_cmd,TRUE) RETURNING l_chk,l_msg
         #130201 By benson --- E
 
        #IF g_gen42s_flag = FALSE THEN #20140903:視flag決定要不要關聯42s
        #   # do nothing
        #ELSE
        #   LET l_cmd = "r.g42s ", g_dzca001  CLIPPED ," &"
        #   DISPLAY l_cmd
        #   RUN l_cmd WITHOUT WAITING 
        #END IF
      WHEN "3"   #qry 42x打包
         #LET l_cmd = "r.gx ", G_MODULE
         #CALL cl_cmdrun_openpipe('r.gx',l_cmd,TRUE) RETURNING l_chk,l_msg #130201 By benson

         #因應r.l將此隻開窗註冊到azzi950 ### start
         #CALL UPSHIFT( G_MODULE ) RETURNING l_gzzn001
         #
         #SELECT COUNT(*) INTO l_cnt FROM gzzn_t 
            #WHERE gzzn001 = l_gzzn001 AND gzzn002 = g_dzca_m.dzca001
#
         #DISPLAY "+++++++++++++++++++++++++++++++++++++"
         #DISPLAY "gzzn001 = ",l_gzzn001
         #DISPLAY "gzzn002 = ",g_dzca_m.dzca001
         #DISPLAY "+++++++++++++++++++++++++++++++++++++"
#
         #IF l_cnt > 0 THEN 
            #DELETE FROM gzzn_t 
               #WHERE gzzn001 = l_gzzn001 AND gzzn002 = g_dzca_m.dzca001
#
            #INSERT INTO gzzn_t(gzzn001,gzzn002,gzzn003,gzzn004)
               #VALUES(l_gzzn001,g_dzca_m.dzca001,'Y','N')
         #END IF
#
         #IF l_cnt = 0 THEN
            #INSERT INTO gzzn_t(gzzn001,gzzn002,gzzn003,gzzn004)
               #VALUES(l_gzzn001,g_dzca_m.dzca001,'Y','N')
         #END IF
         #因應r.l將此隻開窗註冊到azzi950 ### end

         LET l_cmd = "r.l ", g_module
         DISPLAY l_cmd
         CALL cl_cmdrun_openpipe('r.l',l_cmd,TRUE) RETURNING l_chk,l_msg 
      OTHERWISE
         LET l_msg = "adzp210_compile_file.p_type:", p_type
         RETURN l_msg
   END CASE

  #130201 By benson --MARK-- S
  #LET l_msg = l_msg, "=================================================="
  #LET l_msg = l_msg, "==================================================", ASCII 10
  #LET l_msg = l_msg, l_cmd, ASCII 10
  #
  ##如果p_type="3"是做qry打包42x動作,可以不用管目前路徑在那
  #IF l_path IS NOT NULL THEN
  #   #切換目錄
  #   LET l_cmd = "cd ", l_path.trim(), "; ", l_cmd
  #END IF
  #
  ##執行指令
  #CALL l_read.openPipe(l_cmd, "r")
  #
  #WHILE TRUE
  #   LET ls_str = l_read.readLine()
  #   IF l_read.isEof() THEN 
  #      EXIT WHILE 
  #   END IF
  #   LET l_msg = l_msg, ls_str
  #END WHILE
  #CALL l_read.close()
  #130201 By benson --MARK-- E

   RETURN l_msg
END FUNCTION

#+ 開窗時選取資料的SQL可再接受使用者輸入CONSTRUCT條件,增加開窗的 ls_where 變數
PRIVATE FUNCTION adzp210_add_where(p_dzca003)  
   DEFINE p_dzca003           base.StringBuffer
   DEFINE l_index             LIKE type_t.num5
   DEFINE l_str             STRING 
   
   LET l_index = 0
   
   #這裡用了StringBuffer型態的特性,值是存在buffer中
   #所以這裡不另外重新create, p_dzca003保有原有值可直接操作
   #操作完畢後,原呼叫FUNCTION所傳遞過來的值,也可以有此FUNCTION執行後的結果
   
   #因為開窗時可再接受使用者輸入CONSTRUCT條件,
   #所以需要將開窗程式中ls_where(變數)加入本句SQL中
   #加入位置在G_WHERE_END(</wc>)字串之後即可
   LET l_index = p_dzca003.getIndexOf(G_WHERE_END.trim(), 1)
   IF l_index > 0 THEN
      #判斷一下開窗SQL是否有WHERE <wc></wc>裡沒有where條件的情況
      #如果有條件會像:WHERE <wc>1=1</wc>
      #所以當("</wc>"的index位置) - ("<wc>"的index位置) = ("<wc>"的字串長度):表示裡面應該沒有where條件式的輸入
     IF (l_index - p_dzca003.getIndexOf(G_WHERE_START.trim(), 1)) = G_WHERE_START.getLength() THEN
         #因為ls_where是個變數,所以在q_xxx的4gl程式中,加入字串為:[", ls_where CLIPPED, "]
         #這樣產生回開窗程式時字串相加才不會錯,ls_where也才會有作用
        #LET l_str = "\", ls_where CLIPPED, \""
         LET l_str = "\", ls_where CLIPPED,\" \", \"" #20150701
         #CALL p_dzca003.insertAt(l_index + G_WHERE_END.getLength(), "\", ls_where CLIPPED, \"")
      ELSE
        #LET l_str = " AND \", ls_where CLIPPED,\""                 
         LET l_str = " AND \", ls_where CLIPPED,\" \",\"" #20150701                
         #如果原有的開窗SQL設定中已經有where條件
         #則用 AND 方式將原有條件和開窗後使用者輸入條件(ls_where)串在一起
         #CALL p_dzca003.insertAt(l_index + G_WHERE_END.getLength(), " AND \", ls_where CLIPPED, \"")
      END IF 
      DISPLAY "total length:",l_index+G_WHERE_END.getLength()
      IF (l_index+G_WHERE_END.getLength()) >  p_dzca003.getLength() THEN 
         CALL p_dzca003.append(l_str)
      ELSE 
         CALL p_dzca003.insertAt(l_index+G_WHERE_END.getLength(), l_str)  
      END IF 
   ELSE
      #尚未處理沒有where條件的SQL,因為還想不到怎麼處理較好
      DISPLAY "The </wc> is null."
   END IF
   DISPLAY "add_where p_dzca003:",p_dzca003.toString()
END FUNCTION

#+ 開窗時選取資料的SQL需要去除相關tag,SQL才可正常運作
PRIVATE FUNCTION adzp210_remove_tag(p_dzca003)    
   DEFINE p_dzca003           base.StringBuffer
   
   #SQL需輸出回4gl程式,必須將相關tag的字元符先行剔除,才有辦法執行這句SQL
   CALL p_dzca003.replace(G_FIELD_START, " ", 1)
   CALL p_dzca003.replace(G_FIELD_END,   " ", 1) 
   CALL p_dzca003.replace(G_TABLE_START, " ", 1)
   CALL p_dzca003.replace(G_TABLE_END,   " ", 1) 
   CALL p_dzca003.replace(G_WHERE_START, " ", 1)
   CALL p_dzca003.replace(G_WHERE_END,   " ", 1)
   CALL p_dzca003.replace(G_INWC_START,  " ", 1)
   CALL p_dzca003.replace(G_INWC_END,    " ", 1)
   

      
   #另外怕使用者輸入";"會影響SQL執行,因此也先行剔除
   CALL p_dzca003.replace(";", "", 1)
END FUNCTION

#+ henry:開窗時選取資料的SQL需要用 \",g_qryparam.argx,\" 取代 argx,才能將外部變數載入sql敘述
PRIVATE FUNCTION adzp210_replace_arg(p_dzca003)    
   DEFINE p_dzca003           base.StringBuffer
   
   CALL p_dzca003.replace("arg1", "\",g_qryparam.arg1,\"", 0)
   CALL p_dzca003.replace("arg2", "\",g_qryparam.arg2,\"", 0)
   CALL p_dzca003.replace("arg3", "\",g_qryparam.arg3,\"", 0)
   CALL p_dzca003.replace("arg4", "\",g_qryparam.arg4,\"", 0)
   CALL p_dzca003.replace("arg5", "\",g_qryparam.arg5,\"", 0)
   CALL p_dzca003.replace("arg6", "\",g_qryparam.arg6,\"", 0)
   CALL p_dzca003.replace("arg7", "\",g_qryparam.arg7,\"", 0)
   CALL p_dzca003.replace("arg8", "\",g_qryparam.arg8,\"", 0)
   CALL p_dzca003.replace("arg9", "\",g_qryparam.arg9,\"", 0)

   CALL p_dzca003.replace(":DLANG","'\",g_dlang,\"'", 0)
   CALL p_dzca003.replace(":LANG", "'\",g_lang,\"'", 0) #cch
   CALL p_dzca003.replace(":LEGAL","'\",g_legal,\"'", 0)
   CALL p_dzca003.replace(":SITE", "'\",g_site,\"'", 0)
  #20151229 by madey -modify-
  #CALL p_dzca003.replace(":TODAY", "'\",g_today,\"'", 0)
   CALL p_dzca003.replace(":TODAY", "\",g_today_with_format,\"", 0)
  #20151229 by madey -modify-
   CALL p_dzca003.replace(":USER", "'\",g_user,\"'", 0)
   CALL p_dzca003.replace(":DEPT", "'\",g_dept,\"'", 0)
   CALL p_dzca003.replace(":ENT",  "\",g_enterprise,\"", 0)
      
END FUNCTION  


#+ 根據qry_template 設定之#entprise 產生對應之 entprise段落
PUBLIC FUNCTION adzp210_make_enterprise(l_read,l_write)

   DEFINE l_read        base.Channel
   DEFINE l_write       base.Channel
   DEFINE l_tmp         STRING 
   DEFINE l_where        DYNAMIC ARRAY OF STRING 
   DEFINE li_cnt        LIKE type_t.num10 
   DEFINE l_table STRING 
   DEFINE l_table_index  LIKE type_t.num5 
   CONSTANT LI_SPACE = 3 #空三個空白

   WHILE TRUE 
      LET l_tmp = l_read.readLine()
      IF l_tmp.getIndexOf("#entprise -  End  -",1) THEN
          EXIT WHILE 
      END IF
      LET l_where[1] = l_where[1],l_tmp , "\n"
   END WHILE 

   FOR li_cnt = 1  TO g_table_field.getLength()
      
     IF g_table_field[li_cnt].g_enterprise THEN 
        IF li_cnt = 1 THEN 
           LET l_where[li_cnt] = LI_SPACE SPACES ,"LET ls_where = ls_where  ,\" AND \" , \n" 
        END IF 
        LET l_table = g_table_field[li_cnt].gs_table
        LET l_table_index = l_table.getIndexOf("_t",1)
        LET l_table = l_table.subString(1,l_table_index-1)
        LET l_where[li_cnt] =  l_where[li_cnt], LI_SPACE SPACES," \"", l_table||"ent = ","\"",", g_enterprise \n"
     
        IF li_cnt != g_table_field.getLength() THEN
           LET l_where[li_cnt] = l_where[li_cnt] , LI_SPACE SPACES , " ,\" AND \" , "
     
        END IF
        CALL l_write.write( l_where[li_cnt] )
     END IF 

   END FOR    
   
   RETURN l_read,l_write
   
END FUNCTION


#+檢查企業代碼
PUBLIC FUNCTION adzp210_check_enterprise()

   DEFINE li LIKE type_t.num5
   DEFINE lj LIKE type_t.num5
   DEFINE l_table STRING 
   DEFINE l_table_index  LIKE type_t.num5 
   
   FOR li = 1 TO g_table_field.getlength()
       FOR lj = 1 TO g_table_field.getlength()
           IF g_table_field[lj].gs_field = g_table_field[li].gs_field THEN 
              CONTINUE FOR 
           ELSE 
              IF g_table_field[lj].gs_table = g_table_field[li].gs_table THEN 
                 CALL g_table_field.deleteElement(lj)
                 #DISPLAY "g_table_field:",g_table_field.getlength() #,多display 後面會多一個陣列空間 " ",g_table_field[lj].gs_field  , " ",g_table_field[li].gs_field
                 LET li = 0                
                 EXIT FOR                     
              END IF 
           END IF
       END FOR 
   END FOR  
   #判斷table 是否含有企業代碼 
   FOR li = 1 TO g_table_field.getlength()
       LET l_table = g_table_field[li].gs_table
       LET l_table_index = l_table.getIndexOf("_t",1)
       LET l_table = l_table.subString(1,l_table_index-1)
       LET  g_table_field[li].g_enterprise = 
          cl_getField(g_table_field[li].gs_table, l_table||"ent" )
       DISPLAY g_table_field[li].g_enterprise  
   END FOR 

   #排除沒有企業代碼
    #DISPLAY "11g_table_field:",g_table_field.getlength() 
    FOR li = 1 TO g_table_field.getlength()
       #DISPLAY "g_enterprise:",g_table_field[li].g_enterprise 
       IF NOT g_table_field[li].g_enterprise THEN
         
          CALL  g_table_field.deleteElement(li)
          LET li = 0  
       END IF           
    END FOR    

END FUNCTION 

#{
##############################################################################
#以下為template定義出需要置換的tag和範例
#${qry_id}:q_oea6
#
#${qry_exp}:訂單單號查詢
#
#${var_qry_fields}
#       oea01    LIKE oea_file.oea01,
#       oea00    LIKE oea_file.oea00,
#       oea02    LIKE oea_file.oea02,
#       oea032   LIKE oea_file.oea032,
#       oea14    LIKE oea_file.oea14,
#       oea10    LIKE oea_file.oea10
#
#${var_gs_defaults}
##隨著回傳欄位的個數增加
#DEFINE gs_default1       STRING
#DEFINE gs_default2       STRING
#DEFINE gs_default3       STRING
#       
#${var_gs_rets}
##隨著回傳欄位的個數增加
#DEFINE gs_ret1           STRING
#DEFINE gs_ret2           STRING
#DEFINE gs_ret3           STRING
#
#${ps_defaults}
##隨著回傳欄位的個數增加
#ps_default1, ps_default2, ps_default3
#
#${var_ps_defaults}
#DEFINE ps_default1    STRING
#DEFINE ps_default2    STRING
#DEFINE ps_default3    STRING
#
#${let_gs_defaults}
##隨著回傳欄位的個數增加
#LET gs_default1 = ps_default1
#LET gs_default2 = ps_default2
#LET gs_default3 = ps_default3
#
#${return_gs_rets}
##隨著回傳欄位的個數增加
#RETURN gs_ret1, gs_ret2, gs_ret3...
#
#${init_gs_rets}
##隨著回傳欄位的個數增加
#INITIALIZE gs_ret1 TO NULL
#INITIALIZE gs_ret2 TO NULL
#INITIALIZE gs_ret3 TO NULL
#
#${cs_body_fields} 
##qry畫面欄位的個數
#oea01, oea00, oea02, oea032, oea14, oea10
#
#${cs_sr_name} 
##qry畫面欄位的個數
#s_qry[1].oea01,s_qry[1].oea00,s_qry[1].oea02,s_qry[1].oea032,s_qry[1].oea14,s_qry[1].oea10
#
#${let_sel_gs_rets}
##隨著回傳欄位的個數增加
#LET gs_ret1 = gr_qry[li_ac].oea01
#LET gs_ret2 = gr_qry[li_ac].oea02
#LET gs_ret3 = gr_qry[li_ac].oea03
#
#${let_def_gs_rets}
#LET gs_ret1 = gs_default1
#LET gs_ret2 = gs_default2
#LET gs_ret3 = gs_default3
#
#${qry_all_sql}
#"SELECT 'Y', oea01, oea00, oea02, oea032, oea14, oea10", 
#                " FROM oea_file WHERE ", ls_where CLIPPED,
#                " ORDER BY oea01"
#                
#${qry_sql}
#"SELECT 'N', oea01, oea00, oea02, oea032, oea14, oea10, RANK FROM ",   #@如果不需要複選資料,則不要設定check的預設值(將'N'刪除)
#                "(SELECT oea01, oea00, oea02, oea032, oea14, oea10,",
#                " RANK() OVER(ORDER BY oea01) AS RANK",
#                " FROM oea_file WHERE ", ls_where, ")",
#                
#${unique_record_condition}
##隨著開窗資料的唯一值欄位的個數增加
#gr_qry_sel[li_j].oea01 = gr_qry[li_i].oea01 AND gr_qry_sel[li_j].oea02 = gr_qry[li_i].oea02 ...
#
#${gs_rets_result}
#oea01 CLIPPED
#
##${gs_rets_result_plus}
##oea01 CLIPPED
###############################################################################
#}




