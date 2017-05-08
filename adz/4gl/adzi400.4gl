# Prog. Version..: '5.10.06-09.02.11(00009)'     #
# Pattern name...: adzi400.4gl
# Descriptions...: 元资料维护作业
# Date & Author..: 12/10/09 By zhangllc
#

SCHEMA ds

#GLOBALS "../../../tiptop/config/top.global"
GLOBALS "../../cfg/top_global.inc"

GLOBALS
DEFINE  g_dzda       RECORD LIKE dzda_t.*      
DEFINE  g_dzda_t     RECORD LIKE dzda_t.* 
DEFINE  g_dzda001_desc    LIKE dzdi_t.dzdi005
DEFINE  g_dzda001_desc_t  LIKE dzdi_t.dzdi005
DEFINE  g_dzdb005_desc_t  LIKE dzdi_t.dzdi005
DEFINE  g_dzdc002_desc_t  LIKE dzdi_t.dzdi005
DEFINE  g_dzdd004_desc_t  LIKE dzdi_t.dzdi005
#DEFINE  g_dzdh001_desc_t  LIKE dzdi_t.dzdi005  #只读  在adzi490 dzdg_t中维护
#DEFINE  g_dzdh002_desc_t  LIKE dzdi_t.dzdi005  #只读  在adzi490 dzdg_t中维护
END GLOBALS

PRIVATE type type_g_dzdb_d        RECORD
             dzdb003       LIKE dzdb_t.dzdb003,
             dzdb005       LIKE dzdb_t.dzdb005,
             dzdb005_desc  LIKE dzdi_t.dzdi005,
             dzdb007       LIKE dzdb_t.dzdb007
             END RECORD
DEFINE g_dzdb_p          DYNAMIC ARRAY OF type_g_dzdb_d
DEFINE g_dzdb_p_t        type_g_dzdb_d
DEFINE g_dzdb_p_o        type_g_dzdb_d
DEFINE g_dzdb_r          DYNAMIC ARRAY OF type_g_dzdb_d
DEFINE g_dzdb_r_t        type_g_dzdb_d
DEFINE g_dzdb_r_o        type_g_dzdb_d

PRIVATE type type_g_dzdc_d        RECORD
             dzdc002       LIKE dzdc_t.dzdc002,
             dzdc002_desc  LIKE dzdi_t.dzdi005
             END RECORD
DEFINE g_dzdc            DYNAMIC ARRAY OF type_g_dzdc_d
DEFINE g_dzdc_t          type_g_dzdc_d
DEFINE g_dzdc_o          type_g_dzdc_d

PRIVATE type type_g_dzdd_d        RECORD
             dzdd002       LIKE dzdd_t.dzdd002,
             dzdd004       LIKE dzdd_t.dzdd004,
             dzdd004_desc  LIKE dzdi_t.dzdi005
             END RECORD
DEFINE g_dzdd_b          DYNAMIC ARRAY OF type_g_dzdd_d
DEFINE g_dzdd_b_t        type_g_dzdd_d
DEFINE g_dzdd_b_o        type_g_dzdd_d
DEFINE g_dzdd_a          DYNAMIC ARRAY OF type_g_dzdd_d
DEFINE g_dzdd_a_t        type_g_dzdd_d
DEFINE g_dzdd_a_o        type_g_dzdd_d

PRIVATE type type_g_dzdh_d        RECORD
             dzdh001       LIKE dzdh_t.dzdh001,
             dzdh001_desc  LIKE dzdi_t.dzdi005,
             dzdh002       LIKE dzdh_t.dzdh002,
             dzdh002_desc  LIKE dzdi_t.dzdi005
             END RECORD
DEFINE g_dzdh            DYNAMIC ARRAY OF type_g_dzdh_d
DEFINE g_dzdh_t          type_g_dzdh_d
DEFINE g_dzdh_o          type_g_dzdh_d

DEFINE  g_cnt           LIKE type_t.num5           
DEFINE  g_dzda_rowid    LIKE type_t.chr18         
DEFINE  g_flag          LIKE type_t.chr1            
DEFINE  l_ac_dzdb_p     LIKE type_t.num5 
DEFINE  l_ac_dzdb_r     LIKE type_t.num5 
DEFINE  l_ac_dzdc       LIKE type_t.num5  
DEFINE  l_ac_dzdd_b     LIKE type_t.num5
DEFINE  l_ac_dzdd_a     LIKE type_t.num5
DEFINE  l_ac_dzdh       LIKE type_t.num5  
DEFINE  g_row_count     LIKE type_t.num10
DEFINE  g_curs_index    LIKE type_t.num10   
DEFINE  g_jump          LIKE type_t.num10
DEFINE  mi_no_ask       LIKE type_t.num5 
DEFINE  g_wc_dzda       STRING                        
DEFINE  g_wc_dzdb_p     STRING                       
DEFINE  g_wc_dzdb_r     STRING                       
DEFINE  g_wc_dzdc       STRING                      
DEFINE  g_wc_dzdd_b     STRING
DEFINE  g_wc_dzdd_a     STRING
DEFINE  g_wc_dzdh       STRING                     
DEFINE  g_forupd_sql    STRING 
DEFINE  g_sql           STRING        
DEFINE  g_msg           STRING                
DEFINE  g_rec_b_dzdb_p  LIKE type_t.num5     
DEFINE  g_rec_b_dzdb_r  LIKE type_t.num5     
DEFINE  g_rec_b_dzdc    LIKE type_t.num5    
DEFINE  g_rec_b_dzdd_b  LIKE type_t.num5
DEFINE  g_rec_b_dzdd_a  LIKE type_t.num5
DEFINE  g_rec_b_dzdh    LIKE type_t.num5   
DEFINE  b_dzdb_p        RECORD LIKE dzdb_t.*
DEFINE  b_dzdb_r        RECORD LIKE dzdb_t.*
DEFINE  b_dzdc          RECORD LIKE dzdc_t.*
DEFINE  b_dzdd_b        RECORD LIKE dzdd_t.*
DEFINE  b_dzdd_a        RECORD LIKE dzdd_t.*
DEFINE  b_dzdh          RECORD LIKE dzdh_t.*
DEFINE  g_wc            STRING
DEFINE  g_dzdi003       LIKE dzdi_t.dzdi003  #多语言说明


MAIN
  #DEFINE p_row,p_col   LIKE type_t.num5    

  #OPTIONS                                #改變一些系統預設值
  #   FORM LINE       FIRST + 2,         #畫面開始的位置
  #   MESSAGE LINE    LAST,              #訊息顯示的位置
  #   PROMPT LINE     LAST,              #提示訊息的位置
  #   INPUT NO WRAP                      #輸入的方式: 不打轉
  #DEFER INTERRUPT                        #擷取中斷鍵, 由程式處理

  #IF (NOT cl_user()) THEN
  #   EXIT PROGRAM
  #END IF
  
   WHENEVER ERROR CALL cl_err_msg_log
  
  #IF (NOT cl_setup("ADZ")) THEN
  #   EXIT PROGRAM
  #END IF
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("adz","")

  DISCONNECT "dsdemo"
  CONNECT TO "ds"


  #CALL  cl_used(g_prog,g_time,1)       #計算使用時間 (進入時間) 
  #   RETURNING g_time    #No.FUN-6A0081

   LET g_forupd_sql = " SELECT * FROM dzda_t WHERE ROWID = ? FOR UPDATE"
   LET g_forupd_sql = cl_forupd_sql(g_forupd_sql)
   DECLARE i400_cl CURSOR FROM g_forupd_sql
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_adzi400 WITH FORM cl_ap_formpath("adz",g_prog)

   CALL adzi400_init()
   CALL cl_ui_init()

   CALL adzi400_menu()
   CLOSE WINDOW w_adzi400
  #CALL cl_used(g_prog,g_time,2) RETURNING g_time   #計算使用時間 (退出使間)
         
END MAIN

FUNCTION i400_curs()
DEFINE   l_sql_dzda            STRING
DEFINE   l_sql_dzdb_p          STRING
DEFINE   l_sql_dzdb_r          STRING
DEFINE   l_sql_dzdc            STRING
DEFINE   l_sql_dzdd_b          STRING
DEFINE   l_sql_dzdd_a          STRING
DEFINE   l_sql_dzdh            STRING

    CLEAR FORM 
    
    INITIALIZE g_dzda.* TO NULL 
    CALL g_dzdb_p.clear()
    CALL g_dzdb_r.clear()
    CALL g_dzdc.clear()
    CALL g_dzdd_b.clear()
    CALL g_dzdd_a.clear()
    CALL g_dzdh.clear()
    LET g_rec_b_dzdb_p= 0
    LET g_rec_b_dzdb_r= 0
    LET g_rec_b_dzdc  = 0
    LET g_rec_b_dzdd_b= 0
    LET g_rec_b_dzdd_a= 0
    LET g_rec_b_dzdh  = 0
    LET g_wc_dzda  = ''
    LET g_wc_dzdb_p= ''
    LET g_wc_dzdb_r= ''
    LET g_wc_dzdc  = ''
    LET g_wc_dzdd_b= ''
    LET g_wc_dzdd_a= ''
    LET g_wc_dzdh  = ''
    LET g_sql       = ''
    LET l_sql_dzda  = ''
    LET l_sql_dzdb_p= ''
    LET l_sql_dzdb_r= ''
    LET l_sql_dzdc  = ''
    LET l_sql_dzdd_b= ''
    LET l_sql_dzdd_a= ''
    LET l_sql_dzdh  = ''
    
    DIALOG ATTRIBUTES(UNBUFFERED)
    
      CONSTRUCT BY NAME g_wc_dzda ON 
        dzda001,dzda001_desc,dzda002,dzda005,
        dzda006,dzda009,dzda010,dzda011,
        dzdastus,
        dzdacrtid,dzdacrtdp,dzdaownid,dzdaowndp,
        dzdamodid,dzdamoddt,dzdacrtdt
        
       #ON ACTION CONTROLP
       #   CASE 
       #       WHEN INFIELD(dzda010)
       #         CALL cl_init_qry_var()
       #         LET g_qryparam.state = 'c'
       #         LET g_qryparam.form  = 'cq_dzda010'
       #         LET g_qryparam.default1 = g_dzda.dzda010
       #         CALL cl_create_qry() RETURNING g_qryparam.multiret
       #         DISPLAY g_qryparam.multiret TO dzda010
       #   END CASE 
          
       #ON IDLE g_idle_seconds
       #   CALL cl_on_idle()
       #   CONTINUE DIALOG
    
      END CONSTRUCT 

      CONSTRUCT g_wc_dzdb_p ON dzdb003,dzdb005,dzdb005_desc,dzdb007
           FROM s_dzdb_p[1].dzdb003_p,s_dzdb_p[1].dzdb005_p,
                s_dzdb_p[1].dzdb005_p_desc,s_dzdb_p[1].dzdb007_p
      END CONSTRUCT 

      CONSTRUCT g_wc_dzdb_r ON dzdb003,dzdb005,dzdb005_desc,dzdb007
           FROM s_dzdb_r[1].dzdb003_r,s_dzdb_r[1].dzdb005_r,
                s_dzdb_r[1].dzdb005_r_desc,s_dzdb_r[1].dzdb007_r
      END CONSTRUCT 

      CONSTRUCT g_wc_dzdc ON dzdc002,dzdc002_desc
           FROM s_dzdc[1].dzdc002,s_dzdc[1].dzdc002_desc
      END CONSTRUCT

      CONSTRUCT g_wc_dzdd_b ON dzdd002,dzdd004,dzdd004_desc
           FROM s_dzdd_b[1].dzdd002_b,s_dzdd_b[1].dzdd004_b,s_dzdd_b[1].dzdd004_b_desc
      END CONSTRUCT

      CONSTRUCT g_wc_dzdd_a ON dzdd002,dzdd004,dzdd004_desc
           FROM s_dzdd_a[1].dzdd002_a,s_dzdd_a[1].dzdd004_a,s_dzdd_a[1].dzdd004_a_desc
      END CONSTRUCT

      CONSTRUCT g_wc_dzdh ON dzdh001,dzdh001_desc,dzdh002,dzdh002_desc
           FROM s_dzdh[1].dzdh001,s_dzdh[1].dzdh001_desc,
                s_dzdh[1].dzdh002,s_dzdh[1].dzdh002_desc
      END CONSTRUCT 

    
      BEFORE DIALOG
        CALL cl_set_act_visible("close,accpet", FALSE)
      
      
      ON ACTION accept
         EXIT DIALOG
      
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT DIALOG
      
      ON ACTION close
         LET INT_FLAG = 1
         EXIT DIALOG
         
     #ON IDLE g_idle_seconds
     #   CALL cl_on_idle()
     #   CONTINUE DIALOG
            
    END DIALOG
    IF INT_FLAG THEN RETURN END IF 
    #替换dzda001_desc -> dzdi005
    LET g_wc_dzda = cl_replace_str(g_wc_dzda,'dzda001_desc','a.dzdi005')
    #zll替换dzdb005_desc -> dzdi005
    LET g_wc_dzdb_p = cl_replace_str(g_wc_dzdb_p,'dzdb005_desc','bp.dzdi005')
    #zll替换dzdb005_desc -> dzdi005
    LET g_wc_dzdb_r = cl_replace_str(g_wc_dzdb_r,'dzdb005_desc','br.dzdi005')
    #zll替换dzdc002_desc -> dzdi005
    LET g_wc_dzdc = cl_replace_str(g_wc_dzdc,'dzdc002_desc','c.dzdi005')
    #zll替换dzdd004_desc -> dzdi005
    LET g_wc_dzdd_b = cl_replace_str(g_wc_dzdd_b,'dzdd004_desc','db.dzdi005')
    #zll替换dzdd004_desc -> dzdi005
    LET g_wc_dzdd_a = cl_replace_str(g_wc_dzdd_a,'dzdd004_desc','da.dzdi005')
    #zll替换dzdh001_desc -> dzdi005
    LET g_wc_dzdh = cl_replace_str(g_wc_dzdh,'dzdh001_desc','h1.dzdi005')
    #zll替换dzdh002_desc -> dzdi005
    LET g_wc_dzdh = cl_replace_str(g_wc_dzdh,'dzdh002_desc','h2.dzdi005')
    
    IF g_wc_dzdh != ' 1=1' THEN 
       LET l_sql_dzdh = "SELECT DISTINCT dzdh003 FROM dzdh_t LEFT OUTER JOIN dzdi_t h1 ",
                                                                "    ON h1.dzdi001 = 'dzdg_t' ",
                                                                "   AND h1.dzdi002 = 'dzdg001' ",
                                                                "   AND h1.dzdi003 = dzdh001 ",
                        "                                    LEFT OUTER JOIN dzdi_t h2",
                                                                "    ON h2.dzdi001 = 'dzdg_t' ",
                                                                "   AND h2.dzdi002 = 'dzdg002' ",
                                                                "   AND h2.dzdi003 = dzdh001||','||dzdh002 ",
                        " WHERE ",g_wc_dzdh
    END IF 
    IF g_wc_dzdd_a != ' 1=1' THEN
       LET l_sql_dzdd_a = "SELECT DISTINCT dzdd001 FROM dzdd_t LEFT OUTER JOIN dzdi_t da ",
                                                                     "    ON da.dzdi001 = 'dzdd_t' ",
                                                                     "   AND da.dzdi002 = 'dzdd004' ",
                                                                     "   AND da.dzdi003 = dzdd001||','||dzdd007||','||dzdd002||','||dzdd004 ",
                        " WHERE ",g_wc_dzdd_a,
                        "   AND dzdd007 = 'A' "
    END IF
    IF g_wc_dzdd_b != ' 1=1' THEN
       LET l_sql_dzdd_b = "SELECT DISTINCT dzdd001 FROM dzdd_t LEFT OUTER JOIN dzdi_t db ",
                                                                     "    ON db.dzdi001 = 'dzdd_t' ",
                                                                     "   AND db.dzdi002 = 'dzdd004' ",
                                                                     "   AND db.dzdi003 = dzdd001||','||dzdd007||','||dzdd002||','||dzdd004 ",
                        " WHERE ",g_wc_dzdd_b,
                        "   AND dzdd007 = 'B' "
    END IF
    IF g_wc_dzdc != ' 1=1' THEN 
       LET l_sql_dzdc = "SELECT DISTINCT dzdc001 FROM dzdc_t LEFT OUTER JOIN dzdi_t c ",
                                                                     "    ON c.dzdi001 = 'dzdc_t' ",
                                                                     "   AND c.dzdi002 = 'dzdc002' ",
                                                                     "   AND c.dzdi003 = dzdc001||','||dzdc002 ",
                        " WHERE ",g_wc_dzdc
    END IF 
    IF g_wc_dzdb_r != ' 1=1' THEN 
       LET l_sql_dzdb_r = "SELECT DISTINCT dzdb001 FROM dzdb_t LEFT OUTER JOIN dzdi_t br ",
                                                                       "    ON br.dzdi001 = 'dzdb_t' ",
                                                                       "   AND br.dzdi002 = 'dzdb005' ",
                                                                       "   AND br.dzdi003 = dzdb001||','||dzdb002||','||dzdb003||','||dzdb005 ",
                          " WHERE ",g_wc_dzdb_r,
                          "   AND dzdb002 = 'R' "
    END IF 
    IF g_wc_dzdb_p != ' 1=1' THEN 
       LET l_sql_dzdb_p = "SELECT DISTINCT dzdb001 FROM dzdb_t LEFT OUTER JOIN dzdi_t bp ",
                                                                       "    ON bp.dzdi001 = 'dzdb_t' ",
                                                                       "   AND bp.dzdi002 = 'dzdb005' ",
                                                                       "   AND bp.dzdi003 = dzdb001||','||dzdb002||','||dzdb003||','||dzdb005 ",
                          " WHERE ",g_wc_dzdb_p,
                          "   AND dzdb002 = 'P' "
    END IF 
    IF g_wc_dzda != ' 1=1' THEN 
       LET l_sql_dzda = "SELECT DISTINCT dzda001 FROM dzda_t LEFT OUTER JOIN dzdi_t a ",
                        "    ON a.dzdi001 = 'dzda_t' ",
                        "   AND a.dzdi002 = 'dzda001' ",
                        "   AND a.dzdi003 = dzda001 ",
                        " WHERE ",g_wc_dzda
    END IF 
    LET g_wc = ''
    IF NOT cl_null(l_sql_dzda) THEN 
       IF cl_null(g_wc) THEN 
          LET g_wc = l_sql_dzda
       ELSE 
          LET g_wc = g_wc," union ",l_sql_dzda
       END IF 
    END IF 
    IF NOT cl_null(l_sql_dzdb_p) THEN 
       IF cl_null(g_wc) THEN 
          LET g_wc = l_sql_dzdb_p
       ELSE 
          LET g_wc = g_wc," union ",l_sql_dzdb_p
       END IF 
    END IF 
    IF NOT cl_null(l_sql_dzdb_r) THEN 
       IF cl_null(g_wc) THEN 
          LET g_wc = l_sql_dzdb_r
       ELSE 
          LET g_wc = g_wc," union ",l_sql_dzdb_r
       END IF 
    END IF 
    IF NOT cl_null(l_sql_dzdc) THEN 
       IF cl_null(g_wc) THEN 
          LET g_wc = l_sql_dzdc
       ELSE 
          LET g_wc = g_wc," union ",l_sql_dzdc
       END IF 
    END IF 
    IF NOT cl_null(l_sql_dzdd_b) THEN
       IF cl_null(g_wc) THEN
          LET g_wc = l_sql_dzdd_b
       ELSE
          LET g_wc = g_wc," union ",l_sql_dzdd_b
       END IF
    END IF
    IF NOT cl_null(l_sql_dzdd_a) THEN
       IF cl_null(g_wc) THEN
          LET g_wc = l_sql_dzdd_a
       ELSE
          LET g_wc = g_wc," union ",l_sql_dzdd_a
       END IF
    END IF
    IF NOT cl_null(l_sql_dzdh) THEN
       IF cl_null(g_wc) THEN
          LET g_wc = l_sql_dzdh
       ELSE
          LET g_wc = g_wc," union ",l_sql_dzdh
       END IF
    END IF
    IF cl_null(g_wc) THEN 
       LET g_wc = " SELECT DISTINCT dzda001 FROM dzda_t"
    END IF 
    LET g_sql = "SELECT ROWID,dzda001 FROM dzda_t ",
                " WHERE dzda001 IN (",g_wc,")"
    PREPARE i400_data_prep FROM g_sql
    IF SQLCA.sqlcode THEN 
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = SQLCA.sqlcode
       LET g_errparam.extend = 'i400_data_prep:'
       LET g_errparam.popup = TRUE
       CALL cl_err()
       LET INT_FLAG = 1
       RETURN 
    END IF 
    DECLARE i400_data_curs SCROLL CURSOR WITH HOLD FOR i400_data_prep
    IF SQLCA.sqlcode THEN 
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = SQLCA.sqlcode
       LET g_errparam.extend = 'i400_data_curs'
       LET g_errparam.popup = TRUE
       CALL cl_err()
       LET INT_FLAG = 1
       RETURN 
    END IF 
    
    LET g_sql = "SELECT COUNT(*) FROM dzda_t ",
                " WHERE dzda001 IN (",g_wc,")"
    PREPARE i400_count_prep FROM g_sql
    IF SQLCA.sqlcode THEN 
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = SQLCA.sqlcode
       LET g_errparam.extend = 'i400_count_prep'
       LET g_errparam.popup = TRUE
       CALL cl_err()
       LET INT_FLAG = 1
       RETURN 
    END IF 
    DECLARE i400_count_curs CURSOR FOR i400_count_prep
    IF SQLCA.sqlcode THEN 
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = SQLCA.sqlcode
       LET g_errparam.extend = 'i400_count_curs'
       LET g_errparam.popup = TRUE
       CALL cl_err()
       LET INT_FLAG = 1
       RETURN 
    END IF 
END FUNCTION 

FUNCTION adzi400_menu()

   WHILE TRUE
      CALL adzi400_bp("G")
      CASE g_action_choice
         WHEN "insert"
            IF cl_chk_act_auth() THEN
               CALL adzi400_insert()
            END IF
          WHEN "delete"
             IF cl_chk_act_auth() THEN
                CALL adzi400_delete()
             END IF
         WHEN "reproduce"
            IF cl_chk_act_auth() THEN
               CALL adzi400_reproduce()
               CALL adzi400_show() 
            END IF
         WHEN "modify"
            IF cl_chk_act_auth() THEN
               CALL adzi400_modify()
            END IF
         WHEN "query" 
            IF cl_chk_act_auth() THEN
               CALL adzi400_query()
            END IF
         WHEN "detail" 
            IF cl_chk_act_auth() THEN
               CALL adzi400_b('u')
            ELSE
               LET g_action_choice = NULL
            END IF
                  
         WHEN "confirm"
            IF cl_chk_act_auth() THEN
               CALL adzi400_confirm()
            END IF

         WHEN "unconfirm"
            IF cl_chk_act_auth() THEN
               CALL adzi400_unconfirm()
            END IF
         
         #20150624--dujuan---add---str
         #WHEN "output"
         #   IF cl_chk_act_auth() THEN
         #      CALL adzi400_output()
         #   END IF
         #20150624--dujuan---add---end

         #WHEN "help"
         #   CALL cl_show_help()
         WHEN "exit"
            EXIT WHILE
         WHEN "controlg"
            CALL cl_cmdask()
      END CASE
   END WHILE

END FUNCTION

FUNCTION adzi400_query()

    MESSAGE ''

    LET g_row_count = 0
    LET g_curs_index= 0
    
    CALL cl_navigator_setting( g_curs_index, g_row_count )
   #CALL cl_opmsg('q')
    MESSAGE ""
    DISPLAY '   ' TO FORMONLY.cnt
    DISPLAY '   ' TO FORMONLY.cn
    
    CALL i400_curs()
    IF INT_FLAG THEN 
       LET INT_FLAG = 0 
       INITIALIZE g_dzda.* TO NULL 
       CALL g_dzdb_p.clear()
       CALL g_dzdb_r.clear()
       CALL g_dzdc.clear()
       CALL g_dzdd_b.clear()
       CALL g_dzdd_a.clear()
       CALL g_dzdh.clear()
       LET g_rec_b_dzdb_p = 0
       LET g_rec_b_dzdb_r = 0
       LET g_rec_b_dzdc = 0
       LET g_rec_b_dzdd_b = 0
       LET g_rec_b_dzdd_a = 0
       LET g_rec_b_dzdh = 0
       CLEAR FORM 
       RETURN 
    END IF
    MESSAGE " SEARCHING ! "
    OPEN i400_data_curs
    IF SQLCA.sqlcode THEN 
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = SQLCA.sqlcode
       LET g_errparam.extend = 'open cursor i400_data_curs:'
       LET g_errparam.popup = TRUE
       CALL cl_err()
       LET INT_FLAG = 1
       INITIALIZE g_dzda.* TO NULL 
       CALL g_dzdb_p.clear()
       CALL g_dzdb_r.clear()
       CALL g_dzdc.clear()
       CALL g_dzdd_b.clear()
       CALL g_dzdd_a.clear()
       CALL g_dzdh.clear()
       LET g_rec_b_dzdb_p = 0
       LET g_rec_b_dzdb_r = 0
       LET g_rec_b_dzdc = 0
       LET g_rec_b_dzdd_b = 0
       LET g_rec_b_dzdd_a = 0
       LET g_rec_b_dzdh = 0
    ELSE 
       OPEN i400_count_curs
       FETCH i400_count_curs INTO g_row_count
       CLOSE i400_count_curs
       DISPLAY g_row_count TO FORMONLY.cnt
       CALL i400_fetch('F')
    END IF 
    MESSAGE ""

END FUNCTION 

FUNCTION i400_fetch(p_flag)
DEFINE   p_flag               LIKE type_t.chr1

    CASE p_flag
      WHEN 'N' FETCH NEXT     i400_data_curs INTO g_dzda_rowid,g_dzda.dzda001
      WHEN 'P' FETCH PREVIOUS i400_data_curs INTO g_dzda_rowid,g_dzda.dzda001
      WHEN 'F' FETCH FIRST    i400_data_curs INTO g_dzda_rowid,g_dzda.dzda001
      WHEN 'L' FETCH LAST     i400_data_curs INTO g_dzda_rowid,g_dzda.dzda001
      WHEN '/' 
        IF (NOT mi_no_ask) THEN
           CALL cl_getmsg('fetch',g_lang) RETURNING g_msg
           LET INT_FLAG = 0 
           CALL cl_set_act_visible("accept,cancel", TRUE)
           PROMPT g_msg CLIPPED || ': ' FOR g_jump   
              ON IDLE g_idle_seconds
              CALL cl_on_idle()
           END PROMPT
           CALL cl_set_act_visible("accept,cancel", FALSE)
           IF INT_FLAG THEN
               LET INT_FLAG = 0
               EXIT CASE
           END IF
        END IF
        FETCH ABSOLUTE g_jump i400_data_curs INTO g_dzda_rowid,g_dzda.dzda001
        LET mi_no_ask = FALSE
    END CASE 
    
    IF SQLCA.sqlcode THEN 
       INITIALIZE g_dzda.* TO NULL 
       CALL g_dzdb_p.clear()
       CALL g_dzdb_r.clear()
       CALL g_dzdc.clear()
       CALL g_dzdd_b.clear()
       CALL g_dzdd_a.clear()
       CALL g_dzdh.clear()
       LET g_rec_b_dzdb_p = 0
       LET g_rec_b_dzdb_r = 0
       LET g_rec_b_dzdc = 0
       LET g_rec_b_dzdd_b = 0
       LET g_rec_b_dzdd_a = 0
       LET g_rec_b_dzdh = 0
       RETURN 
    ELSE 
       CASE p_flag
          WHEN 'F' LET g_curs_index = 1
          WHEN 'P' LET g_curs_index = g_curs_index - 1
          WHEN 'N' LET g_curs_index = g_curs_index + 1
          WHEN 'L' LET g_curs_index = g_row_count
          WHEN '/' LET g_curs_index = g_jump
       END CASE
 
       DISPLAY g_curs_index TO FORMONLY.cn
       CALL cl_navigator_setting( g_curs_index, g_row_count )
    END IF 
    
    SELECT * INTO g_dzda.* FROM dzda_t WHERE ROWID = g_dzda_rowid
    IF SQLCA.sqlcode THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = SQLCA.sqlcode
       LET g_errparam.extend = g_dzda.dzda001
       LET g_errparam.popup = FALSE
       CALL cl_err()
       INITIALIZE g_dzda.* TO NULL
    ELSE
       CALL adzi400_show()
    END IF   
END FUNCTION 

FUNCTION adzi400_show()

    DISPLAY BY NAME 
        g_dzda.dzda001,g_dzda.dzda002,
        g_dzda.dzda005,g_dzda.dzda006,
        g_dzda.dzda009,g_dzda.dzda010,g_dzda.dzda011,
        g_dzda.dzdacrtid,g_dzda.dzdacrtdp,
        g_dzda.dzdaownid,g_dzda.dzdaowndp,g_dzda.dzdamodid,
        g_dzda.dzdamoddt,g_dzda.dzdacrtdt,g_dzda.dzdastus

    LET g_dzdi003 = s_chr_trim(g_dzda.dzda001)

    LET g_dzda001_desc = ''
    CALL sadz_get_name("dzda_t","dzda001",g_dzdi003) RETURNING g_dzda001_desc
    DISPLAY g_dzda001_desc TO FORMONLY.dzda001_desc
        
    CALL i400_b_fill()
    
END FUNCTION 

FUNCTION i400_b_fill()

    IF cl_null(g_dzda.dzda001) THEN 
       RETURN
    END IF
    
    CALL i400_get_dzdb_p(g_dzda.dzda001)
    CALL i400_get_dzdb_r(g_dzda.dzda001)
    CALL i400_get_dzdc(g_dzda.dzda001)
    CALL i400_get_dzdd_b(g_dzda.dzda001)
    CALL i400_get_dzdd_a(g_dzda.dzda001)
    CALL i400_get_dzdh(g_dzda.dzda001)
    
END FUNCTION 

FUNCTION adzi400_insert()
DEFINE     li_result        LIKE type_t.num5
DEFINE     l_str            STRING
DEFINE     l_len            LIKE type_t.num10
DEFINE     l_num            LIKE type_t.num10

   #IF s_shut(0) THEN RETURN END IF
    MESSAGE ""
    CLEAR FORM
    INITIALIZE g_dzda.* TO NULL 
    CALL g_dzdb_p.clear()
    CALL g_dzdb_r.clear()
    CALL g_dzdc.clear()
    CALL g_dzdd_b.clear()
    CALL g_dzdd_a.clear()
    CALL g_dzdh.clear()
    LET g_rec_b_dzdb_p = 0
    LET g_rec_b_dzdb_r = 0
    LET g_rec_b_dzdc = 0
    LET g_rec_b_dzdd_b = 0
    LET g_rec_b_dzdd_a = 0
    LET g_rec_b_dzdh = 0
   #CALL cl_opmsg('a')
    LET g_dzda_t.* = g_dzda.*
    WHILE TRUE 
        CALL s_transaction_begin()
        CALL i400_init_dzda()
        CALL adzi400_show()
        
        CALL i400_input('a')
        IF INT_FLAG THEN 
           LET INT_FLAG = 0
           INITIALIZE g_dzda.* TO NULL 
           CALL g_dzdb_p.clear()
           CALL g_dzdb_r.clear()
           CALL g_dzdc.clear()
           CALL g_dzdd_b.clear()
           CALL g_dzdd_a.clear()
           CALL g_dzdh.clear()
           LET g_rec_b_dzdb_p = 0
           LET g_rec_b_dzdb_r = 0
           LET g_rec_b_dzdc = 0
           LET g_rec_b_dzdd_b = 0
           LET g_rec_b_dzdd_a = 0
           LET g_rec_b_dzdh = 0
           CLEAR FORM 
           CALL s_transaction_end('N',0)
           EXIT WHILE 
        END IF 

        IF cl_null(g_dzda.dzda001) THEN CONTINUE WHILE END IF 
        DISPLAY BY NAME g_dzda.dzda001

        INSERT INTO dzda_t VALUES(g_dzda.*)
        IF SQLCA.sqlcode THEN
           INITIALIZE g_errparam TO NULL
           LET g_errparam.code = SQLCA.sqlcode
           LET g_errparam.extend = g_dzda.dzda001
           LET g_errparam.popup = FALSE
           CALL cl_err()
           CALL s_transaction_end('N',0)
           CONTINUE WHILE
        ELSE 
           SELECT ROWID INTO g_dzda_rowid FROM dzda_t 
            WHERE dzda001 = g_dzda.dzda001
           LET g_dzda_t.* = g_dzda.*
        END IF 
        CALL s_transaction_end('Y',0)
        CALL adzi400_b('a')   
        CALL adzi400_show()   
        EXIT WHILE 
    END WHILE 

END FUNCTION 

FUNCTION adzi400_modify()

   #IF s_shut(0) THEN RETURN END IF
    MESSAGE ''

    IF cl_null(g_dzda.dzda001) THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = -400
       LET g_errparam.extend = ""
       LET g_errparam.popup = FALSE
       CALL cl_err()
       RETURN
     END IF
    IF g_dzda.dzdastus='Y' THEN
       ERROR "已审核,不可修改"
       RETURN
    END IF
    
    CALL s_transaction_begin()
    
    OPEN i400_cl USING g_dzda_rowid
    IF SQLCA.sqlcode THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = SQLCA.sqlcode
       LET g_errparam.extend = "OPEN i400_cl:"
       LET g_errparam.popup = TRUE
       CALL cl_err()
       CLOSE i400_cl
       CALL s_transaction_end('N',0)
       RETURN
    END IF
    FETCH i400_cl INTO g_dzda.*               # 
    IF SQLCA.sqlcode THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = SQLCA.sqlcode
       LET g_errparam.extend = g_dzda.dzda001
       LET g_errparam.popup = TRUE
       CALL cl_err()
       CALL s_transaction_end('N',0)
       RETURN
    END IF
    CALL adzi400_show()
    WHILE TRUE 
       INITIALIZE g_dzda_t.* TO  NULL 
       LET g_dzda_t.* = g_dzda.*
       CALL i400_input('u')
       IF INT_FLAG THEN 
          LET g_dzda.* = g_dzda_t.*
          CALL adzi400_show()
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = '9001'
          LET g_errparam.extend = ''
          LET g_errparam.popup = FALSE
          CALL cl_err()
          LET INT_FLAG = 0 
          CALL s_transaction_end('N',0)
          EXIT WHILE 
       END IF 

       LET g_dzda.dzdamodid= g_user
       LET g_dzda.dzdamoddt= g_today
       UPDATE dzda_t SET dzda_t.* = g_dzda.*
        WHERE ROWID = g_dzda_rowid 
       IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = g_dzda.dzda001
          LET g_errparam.popup = FALSE
          CALL cl_err()
          CONTINUE WHILE
       ELSE 
          CALL s_transaction_end('Y',0)
       END IF
       EXIT WHILE 
    END WHILE 
    CLOSE i400_cl

END FUNCTION 

FUNCTION i400_input(p_cmd)
DEFINE   p_cmd                LIKE type_t.chr1
DEFINE   l_cnt                LIKE type_t.num5
DEFINE   l_dzda010          LIKE dzda_t.dzda010
DEFINE   l_n                  LIKE type_t.num5
DEFINE   li_result            LIKE type_t.num5
DEFINE   l_success   LIKE type_t.num5

    INPUT 
        g_dzda.dzda001,g_dzda001_desc,g_dzda.dzda002,
        g_dzda.dzda005,g_dzda.dzda006,
        g_dzda.dzda009,g_dzda.dzda010,g_dzda.dzda011
    WITHOUT DEFAULTS FROM
        dzda001,dzda001_desc,dzda002,
        dzda005,dzda006,
        dzda009,dzda010,dzda011
        
        
        BEFORE INPUT 
           CALL i400_set_entry(p_cmd)
           CALL i400_set_no_entry(p_cmd)
          
        BEFORE FIELD dzda001_desc
           LET g_dzda001_desc_t = GET_FLDBUF(dzda001_desc)

        AFTER FIELD dzda001_desc
           IF g_dzda001_desc_t != g_dzda001_desc 
           OR (g_dzda001_desc_t IS NOT NULL AND g_dzda001_desc IS NULL)
           OR (g_dzda001_desc_t IS NULL AND g_dzda001_desc IS NOT NULL)
           THEN
              LET g_dzdi003 = s_chr_trim(g_dzda.dzda001)
              CALL sadz_edit_name("dzda_t","dzda001",g_dzdi003) RETURNING l_success
              CALL sadz_get_name("dzda_t","dzda001",g_dzdi003) RETURNING g_dzda001_desc
              DISPLAY g_dzda001_desc TO FORMONLY.dzda001_desc
              CALL cl_show_fld_cont()
           END IF

        ON ACTION upmoddt_item
           CASE
              WHEN INFIELD(dzda001_desc)
                 LET g_dzdi003 = s_chr_trim(g_dzda.dzda001)
                 CALL sadz_edit_name("dzda_t","dzda001",g_dzdi003) RETURNING l_success
                 CALL sadz_get_name("dzda_t","dzda001",g_dzdi003) RETURNING g_dzda001_desc
                 DISPLAY g_dzda001_desc TO FORMONLY.dzda001_desc
                 CALL cl_show_fld_cont()
           END CASE

        AFTER INPUT
           #检查key值重复
           IF NOT cl_null(g_dzda.dzda001) THEN
              IF p_cmd = "a" OR             
                 (p_cmd = "u" AND g_dzda.dzda001 != g_dzda_t.dzda001) THEN
                 SELECT count(*) INTO l_n FROM dzda_t
                  WHERE dzda001 = g_dzda.dzda001
                 IF l_n > 0 THEN              
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = '-239'
                    LET g_errparam.extend = g_dzda.dzda001
                    LET g_errparam.popup = TRUE
                    CALL cl_err()
                    LET g_dzda.dzda001 = g_dzda_t.dzda001
                    DISPLAY BY NAME g_dzda.dzda001
                    NEXT FIELD dzda001
                 END IF
              END IF
           END IF
           
       #ON ACTION CONTROLP
       #   CASE 
       #     WHEN INFIELD(dzda001)
       #       CALL cl_init_qry_var()
       #       LET g_qryparam.form  = 'cq_dzda010'
       #       LET g_qryparam.default1 = g_dzda.dzda010
       #       CALL cl_create_qry() RETURNING g_dzda.dzda010
       #       DISPLAY BY NAME g_dzda.dzda010
       #   END CASE 
           
        ON ACTION CONTROLG
           CALL cl_cmdask()
        
       #ON IDLE g_idle_seconds
       #   CALL cl_on_idle()
       #   CONTINUE INPUT
 
        ON ACTION about        
           CALL cl_about()     
 
        #ON ACTION help          
        #   CALL cl_show_help() 
           
    END INPUT     

END FUNCTION 
#20150624--dujuan----add----str
#FUNCTION adzi400_output()
#    CALL adzi400_g01(g_wc_dzda,g_wc_dzdb_p,g_wc_dzdb_r,g_wc_dzdd_b,g_wc_dzdd_a)
#END FUNCTION
#20150624---dujuan---add----end
FUNCTION adzi400_bp(p_ud)
DEFINE   p_ud                  LIKE type_t.chr1
DEFINE   l_ac_dzdb_p           LIKE type_t.num5
DEFINE   l_ac_dzdb_r           LIKE type_t.num5
DEFINE   l_ac_dzdc             LIKE type_t.num5
DEFINE   l_ac_dzdd_b           LIKE type_t.num5
DEFINE   l_ac_dzdd_a           LIKE type_t.num5
DEFINE   l_ac_dzdh             LIKE type_t.num5


    IF p_ud <> "G" OR g_action_choice = "detail" THEN
       RETURN
    END IF

    LET g_action_choice = " "
    CALL cl_set_act_visible("accept,cancel,close", FALSE)
    DIALOG ATTRIBUTES(UNBUFFERED)
      DISPLAY ARRAY g_dzdb_p TO s_dzdb_p.* ATTRIBUTE(COUNT=g_rec_b_dzdb_p)
         BEFORE DISPLAY 
           CALL cl_navigator_setting( g_curs_index, g_row_count )
         BEFORE ROW 
             LET l_ac_dzdb_p = ARR_CURR()
      END DISPLAY 
       
      DISPLAY ARRAY g_dzdb_r TO s_dzdb_r.* ATTRIBUTE(COUNT=g_rec_b_dzdb_r)
         BEFORE DISPLAY 
           CALL cl_navigator_setting( g_curs_index, g_row_count )
         BEFORE ROW 
             LET l_ac_dzdb_r = ARR_CURR()
      END DISPLAY 
      
      DISPLAY ARRAY g_dzdc TO s_dzdc.* ATTRIBUTE(COUNT=g_rec_b_dzdc)
         BEFORE DISPLAY 
           CALL cl_navigator_setting( g_curs_index, g_row_count )
         BEFORE ROW 
             LET l_ac_dzdc = ARR_CURR()
      END DISPLAY 
      
      DISPLAY ARRAY g_dzdd_b TO s_dzdd_b.* ATTRIBUTE(COUNT=g_rec_b_dzdd_b)
         BEFORE DISPLAY
           CALL cl_navigator_setting( g_curs_index, g_row_count )
         BEFORE ROW
             LET l_ac_dzdd_b = ARR_CURR()
      END DISPLAY

      DISPLAY ARRAY g_dzdd_a TO s_dzdd_a.* ATTRIBUTE(COUNT=g_rec_b_dzdd_a)
         BEFORE DISPLAY
           CALL cl_navigator_setting( g_curs_index, g_row_count )
         BEFORE ROW
             LET l_ac_dzdd_a = ARR_CURR()
      END DISPLAY

      DISPLAY ARRAY g_dzdh TO s_dzdh.* ATTRIBUTE(COUNT=g_rec_b_dzdh)
         BEFORE DISPLAY
           CALL cl_navigator_setting( g_curs_index, g_row_count )
         BEFORE ROW
             LET l_ac_dzdh = ARR_CURR()
      END DISPLAY

      BEFORE DIALOG
         CALL cl_set_act_visible("close", FALSE)
         LET l_ac_dzdb_p = 1
         LET l_ac_dzdb_r = 1
         LET l_ac_dzdc = 1
         LET l_ac_dzdd_b = 1
         LET l_ac_dzdd_a = 1
         LET l_ac_dzdh = 1
         
      ON ACTION insert
         LET g_action_choice="insert"
         CALL cl_set_act_visible("accept,cancel,close", TRUE)
         EXIT DIALOG
      ON ACTION query
         LET g_action_choice="query"
         EXIT DIALOG
      ON ACTION delete
         LET g_action_choice="delete"
         EXIT DIALOG
      ON ACTION reproduce
         LET g_action_choice="reproduce"
         EXIT DIALOG
      ON ACTION modify
         LET g_action_choice="modify"
         EXIT DIALOG

      ON ACTION first
         CALL i400_fetch('F')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   
         ACCEPT DIALOG                

      ON ACTION previous
         CALL i400_fetch('P')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   
         CONTINUE DIALOG    

      ON ACTION jump
         CALL i400_fetch('/')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   
         ACCEPT DIALOG                  

      ON ACTION next
         CALL i400_fetch('N')
         CALL cl_navigator_setting(g_curs_index, g_row_count)  
         CONTINUE DIALOG              

      ON ACTION last
         CALL i400_fetch('L')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   
         ACCEPT DIALOG                  
      ON ACTION detail
         LET g_action_choice="detail"
         EXIT DIALOG
      
      ON ACTION output
         LET g_action_choice="output"
         EXIT DIALOG     
      
      ON ACTION confirm
         LET g_action_choice="confirm"
         EXIT DIALOG     
         
      ON ACTION unconfirm
         LET g_action_choice="unconfirm"
         EXIT DIALOG     
         
      ON ACTION help
         LET g_action_choice="help"
         EXIT DIALOG 

      #ON ACTION locale
      #   CALL cl_dynamic_locale()
      #    CALL cl_show_fld_cont()                   
          
         LET g_action_choice = 'locale'
         EXIT DIALOG 
      ON ACTION exit
         LET g_action_choice="exit"
         LET INT_FLAG = FALSE
         EXIT DIALOG 
         
      ON ACTION close
         EXIT DIALOG
      ##########################################################################
      # Special 4ad ACTION
      ##########################################################################
      
      ON ACTION controlg
         LET g_action_choice="controlg"
         EXIT DIALOG
         
      ON ACTION cancel
         LET INT_FLAG=FALSE 		
         LET g_action_choice="exit"
         EXIT DIALOG

     #ON IDLE g_idle_seconds
     #   CALL cl_on_idle()
     #   CONTINUE DIALOG
 
      ON ACTION about        
         CALL cl_about()      
      
      ON ACTION accept
         LET g_action_choice="detail"
         EXIT DIALOG
         
    END DIALOG

    CALL cl_set_act_visible("accept,cancel,close", TRUE)
END FUNCTION 

FUNCTION adzi400_b(p_cmd)
DEFINE   p_cmd                LIKE type_t.chr1
DEFINE   l_cnt                LIKE type_t.num5
DEFINE   l_lock_sw            LIKE type_t.chr1
DEFINE   l_allow_delete       LIKE type_t.num5
DEFINE   l_allow_insert       LIKE type_t.num5
DEFINE   l_n                  LIKE type_t.num5
DEFINE   l_success            LIKE type_t.num5

    MESSAGE ''

    LET g_action_choice = ""
   #IF s_shut(0) THEN RETURN END IF
    IF cl_null(g_dzda.dzda001) THEN 
       RETURN 
    END IF 
    IF g_dzda.dzdastus='Y' THEN
       ERROR "已审核,不可修改"
       RETURN
    END IF
   
    SELECT ROWID INTO g_dzda_rowid FROM dzda_t 
     WHERE dzda001 = g_dzda.dzda001
    
   #CALL cl_opmsg('b')
    
    LET g_forupd_sql = "SELECT * FROM dzdb_t ",
                       " WHERE dzdb001 = ? AND dzdb003 = ? AND dzdb002='P' FOR UPDATE NOWAIT"
    DECLARE i400_bcl_dzdb_p CURSOR FROM g_forupd_sql

    LET g_forupd_sql = "SELECT * FROM dzdb_t ",
                       " WHERE dzdb001 = ? AND dzdb003 = ? AND dzdb002='R' FOR UPDATE NOWAIT"
    DECLARE i400_bcl_dzdb_r CURSOR FROM g_forupd_sql
    
    LET g_forupd_sql = "SELECT * FROM dzdc_t ",
                       " WHERE dzdc001 = ? AND dzdc002 = ? FOR UPDATE NOWAIT"
    DECLARE i400_bcl_dzdc CURSOR FROM g_forupd_sql
    
    LET g_forupd_sql = "SELECT * FROM dzdd_t ",
                       " WHERE dzdd001 = ? AND dzdd002 = ? AND dzdd007='B' FOR UPDATE NOWAIT"
    DECLARE i400_bcl_dzdd_b CURSOR FROM g_forupd_sql

    LET g_forupd_sql = "SELECT * FROM dzdd_t ",
                       " WHERE dzdd001 = ? AND dzdd002 = ? AND dzdd007='A' FOR UPDATE NOWAIT"
    DECLARE i400_bcl_dzdd_a CURSOR FROM g_forupd_sql

    LET g_forupd_sql = "SELECT * FROM dzdh_t ",
                       " WHERE dzdh003 = ? AND dzdh001 = ? AND dzdh002 = ? FOR UPDATE NOWAIT"
    DECLARE i400_bcl_dzdh CURSOR FROM g_forupd_sql
    
    LET l_allow_insert = cl_detail_input_auth("insert")
    LET l_allow_delete = cl_detail_input_auth("delete")

    DIALOG ATTRIBUTES(UNBUFFERED)
    
       INPUT ARRAY g_dzdb_p FROM s_dzdb_p.*
           ATTRIBUTE(COUNT=g_rec_b_dzdb_p,MAXCOUNT=g_max_rec,WITHOUT DEFAULTS = TRUE,
                     INSERT ROW=l_allow_insert,DELETE ROW=l_allow_delete ,APPEND ROW =l_allow_insert )
           
           BEFORE INPUT             
              IF g_rec_b_dzdb_p != 0 THEN
                 CALL fgl_set_arr_curr(l_ac_dzdb_p)
              END IF
              
           BEFORE ROW 
              LET p_cmd = ''
              LET l_ac_dzdb_p = ARR_CURR()  
              LET l_cnt = ARR_COUNT()
              LET l_lock_sw = 'N'
              OPEN i400_cl USING g_dzda_rowid 
              IF SQLCA.sqlcode THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = SQLCA.sqlcode
                 LET g_errparam.extend = "OPEN i400_cl:"
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 LET INT_FLAG = 1
                 EXIT DIALOG
              END IF
              FETCH i400_cl INTO g_dzda.*  
              IF SQLCA.sqlcode THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = SQLCA.sqlcode
                 LET g_errparam.extend = "fetch i400_cl"
                 LET g_errparam.popup = FALSE
                 CALL cl_err()
                 LET INT_FLAG = 1
                 EXIT DIALOG
              END IF
              IF g_rec_b_dzdb_p >= l_ac_dzdb_p THEN
                 LET p_cmd = 'u'
                 LET g_dzdb_p_t.* = g_dzdb_p[l_ac_dzdb_p].*
                 OPEN i400_bcl_dzdb_p USING g_dzda.dzda001,g_dzdb_p_t.dzdb003
                 IF SQLCA.sqlcode THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = SQLCA.sqlcode
                    LET g_errparam.extend = "OPEN i400_bcl_dzdb_p:"
                    LET g_errparam.popup = TRUE
                    CALL cl_err()
                    LET l_lock_sw = "Y"
                 ELSE
                    FETCH i400_bcl_dzdb_p INTO b_dzdb_p.*
                    IF SQLCA.sqlcode THEN
                       INITIALIZE g_errparam TO NULL
                       LET g_errparam.code = SQLCA.sqlcode
                       LET g_errparam.extend = g_dzdb_p_t.dzdb003
                       LET g_errparam.popup = TRUE
                       CALL cl_err()
                       LET l_lock_sw = "Y"
                    ELSE
                      CALL i400_b_dzdb_p_to()
                    END IF
                 END IF
              END IF 
           
           AFTER FIELD dzdb003
              #检查key值重复
              IF NOT cl_null(g_dzdb_p[l_ac_dzdb_p].dzdb003) THEN
                 IF p_cmd = "a" OR
                    (p_cmd = "u" AND g_dzdb_p[l_ac_dzdb_p].dzdb003 != g_dzdb_p_t.dzdb003) THEN
                    SELECT count(*) INTO l_n FROM dzdb_t
                     WHERE dzdb001 = g_dzda.dzda001
                       AND dzdb002 = 'P'
                       AND dzdb003 = g_dzdb_p[l_ac_dzdb_p].dzdb003
                    IF l_n > 0 THEN
                       INITIALIZE g_errparam TO NULL
                       LET g_errparam.code = '-239'
                       LET g_errparam.extend = g_dzdb_p[l_ac_dzdb_p].dzdb003
                       LET g_errparam.popup = FALSE
                       CALL cl_err()
                       NEXT FIELD dzdb003
                    END IF
                 END IF
              END IF

           BEFORE INSERT 
              LET l_n = ARR_COUNT()
              LET p_cmd='a'
              INITIALIZE g_dzdb_p[l_ac_dzdb_p].* TO NULL 
              LET g_dzdb_p_t.* = g_dzdb_p[l_ac_dzdb_p].*
              NEXT FIELD dzdb003
           
           AFTER INSERT 
              CALL i400_b_dzdb_p_back()
              LET b_dzdb_p.dzdbstus= 'Y'
              LET b_dzdb_p.dzdbcrtid= g_user
              LET b_dzdb_p.dzdbcrtdp= g_dept
              LET b_dzdb_p.dzdbownid= g_user
              LET b_dzdb_p.dzdbowndp= g_dept
              LET b_dzdb_p.dzdbmodid= ''
              LET b_dzdb_p.dzdbmoddt= ''
              LET b_dzdb_p.dzdbcrtdt= g_today
              INSERT INTO dzdb_t VALUES(b_dzdb_p.*)
              IF SQLCA.sqlcode THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = SQLCA.sqlcode
                 LET g_errparam.extend = b_dzdb_p.dzdb003
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 CANCEL INSERT
              ELSE
                #CALL cl_msg('INSERT O.K')
                 MESSAGE 'INSERT O.K'
                 LET g_rec_b_dzdb_p=g_rec_b_dzdb_p+1
              END IF 
           
           ON ROW CHANGE 
              IF l_lock_sw = 'Y' THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = '-263'
                 LET g_errparam.extend = g_dzdb_p[l_ac_dzdb_p].dzdb003
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 LET g_dzdb_p[l_ac_dzdb_p].* = g_dzdb_p_t.*
              ELSE
                 CALL i400_b_dzdb_p_back()
                 LET b_dzdb_p.dzdbmodid= g_user
                 LET b_dzdb_p.dzdbmoddt= g_today
                 UPDATE dzdb_t SET * = b_dzdb_p.*
                  WHERE dzdb001 = g_dzda.dzda001
                    AND dzdb002 = 'P'
                    AND dzdb003 = g_dzdb_p_t.dzdb003
                 IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = SQLCA.sqlcode
                    LET g_errparam.extend = b_dzdb_p.dzdb003
                    LET g_errparam.popup = TRUE
                    CALL cl_err()
                    LET g_dzdb_p[l_ac_dzdb_p].* = g_dzdb_p_t.*
                 ELSE 
                   #CALL cl_msg('UPDATE O.K')
                    MESSAGE 'UPDATE O.K'
                 END IF 
              END IF 
           
           BEFORE FIELD dzdb005_p_desc
              LET g_dzdb005_desc_t = g_dzdb_p[l_ac_dzdb_p].dzdb005_desc
   
           AFTER FIELD dzdb005_p_desc
              IF g_dzdb005_desc_t != g_dzdb_p[l_ac_dzdb_p].dzdb005_desc
              OR (g_dzdb005_desc_t IS NOT NULL AND g_dzdb_p[l_ac_dzdb_p].dzdb005_desc IS NULL)
              OR (g_dzdb005_desc_t IS NULL AND g_dzdb_p[l_ac_dzdb_p].dzdb005_desc IS NOT NULL)
              THEN
                 LET g_dzdi003 = s_chr_trim(g_dzda.dzda001),',','P',',',s_chr_trim(g_dzdb_p[l_ac_dzdb_p].dzdb003),',',
                                 s_chr_trim(g_dzdb_p[l_ac_dzdb_p].dzdb005)
                 CALL sadz_edit_name("dzdb_t","dzdb005",g_dzdi003) RETURNING l_success
                 LET g_dzdb_p[l_ac_dzdb_p].dzdb005_desc = sadz_get_name("dzdb_t","dzdb005",g_dzdi003)
                 CALL cl_show_fld_cont()
              END IF

           ON ACTION upmoddt_item
              CASE
                 WHEN INFIELD(dzdb005_p_desc)
                    LET g_dzdi003 = s_chr_trim(g_dzda.dzda001),',','P',',',s_chr_trim(g_dzdb_p[l_ac_dzdb_p].dzdb003),',',
                                    s_chr_trim(g_dzdb_p[l_ac_dzdb_p].dzdb005)
                    CALL sadz_edit_name("dzdb_t","dzdb005",g_dzdi003) RETURNING l_success
                    LET g_dzdb_p[l_ac_dzdb_p].dzdb005_desc = sadz_get_name("dzdb_t","dzdb005",g_dzdi003)
                    CALL cl_show_fld_cont()
              END CASE

           BEFORE DELETE 
              IF NOT cl_null(g_dzdb_p_t.dzdb003) THEN 
                 IF NOT cl_ask_delete() THEN
                    CANCEL DELETE
                 END IF
                 IF l_lock_sw = "Y" THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = '-263'
                    LET g_errparam.extend = ""
                    LET g_errparam.popup = TRUE
                    CALL cl_err()
                    CANCEL DELETE
                 END IF
                 DELETE FROM dzdb_t 
                  WHERE dzdb001 = g_dzda.dzda001
                    AND dzdb002 = 'P'
                    AND dzdb003 = g_dzdb_p_t.dzdb003
                 IF SQLCA.sqlcode THEN 
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = SQLCA.sqlcode
                    LET g_errparam.extend = b_dzdb_p.dzdb003
                    LET g_errparam.popup = TRUE
                    CALL cl_err()
                    CANCEL DELETE
                 END IF 
                 LET g_rec_b_dzdb_p=g_rec_b_dzdb_p-1
              END IF 
              
           AFTER ROW 
              LET l_ac_dzdb_p = ARR_CURR()
              IF p_cmd = 'u' THEN 
                 CLOSE i400_bcl_dzdb_p
              END IF 
           
       END INPUT 
       
       INPUT ARRAY g_dzdb_r FROM s_dzdb_r.*
           ATTRIBUTE(COUNT=g_rec_b_dzdb_r,MAXCOUNT=g_max_rec,WITHOUT DEFAULTS = TRUE,
                     INSERT ROW=l_allow_insert,DELETE ROW=l_allow_delete ,APPEND ROW =l_allow_insert )
           
           BEFORE INPUT             
              IF g_rec_b_dzdb_r != 0 THEN
                 CALL fgl_set_arr_curr(l_ac_dzdb_r)
              END IF
              
           BEFORE ROW 
              LET p_cmd = ''
              LET l_ac_dzdb_r = ARR_CURR()  
              LET l_cnt = ARR_COUNT()
              LET l_lock_sw = 'N'
              OPEN i400_cl USING g_dzda_rowid 
              IF SQLCA.sqlcode THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = SQLCA.sqlcode
                 LET g_errparam.extend = "OPEN i400_cl:"
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 LET INT_FLAG = 1
                 EXIT DIALOG
              END IF
              FETCH i400_cl INTO g_dzda.*  
              IF SQLCA.sqlcode THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = SQLCA.sqlcode
                 LET g_errparam.extend = "fetch i400_cl"
                 LET g_errparam.popup = FALSE
                 CALL cl_err()
                 LET INT_FLAG = 1
                 EXIT DIALOG
              END IF
              IF g_rec_b_dzdb_r >= l_ac_dzdb_r THEN
                 LET p_cmd = 'u'
                 LET g_dzdb_r_t.* = g_dzdb_r[l_ac_dzdb_r].*
                 OPEN i400_bcl_dzdb_r USING g_dzda.dzda001,g_dzdb_r_t.dzdb003
                 IF SQLCA.sqlcode THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = SQLCA.sqlcode
                    LET g_errparam.extend = "OPEN i400_bcl_dzdb_r:"
                    LET g_errparam.popup = TRUE
                    CALL cl_err()
                    LET l_lock_sw = "Y"
                 ELSE
                    FETCH i400_bcl_dzdb_r INTO b_dzdb_r.*
                    IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = SQLCA.sqlcode
                      LET g_errparam.extend = g_dzdb_r_t.dzdb003
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                    ELSE
                      CALL i400_b_dzdb_r_to()
                    END IF
                 END IF
              END IF 
           
           AFTER FIELD dzdb003
              #检查key值重复
              IF NOT cl_null(g_dzdb_r[l_ac_dzdb_r].dzdb003) THEN
                 IF p_cmd = "a" OR
                    (p_cmd = "u" AND g_dzdb_r[l_ac_dzdb_r].dzdb003 != g_dzdb_r_t.dzdb003) THEN
                    SELECT count(*) INTO l_n FROM dzdb_t
                     WHERE dzdb001 = g_dzda.dzda001
                       AND dzdb002 = 'R'
                       AND dzdb003 = g_dzdb_r[l_ac_dzdb_r].dzdb003
                    IF l_n > 0 THEN
                       INITIALIZE g_errparam TO NULL
                       LET g_errparam.code = '-239'
                       LET g_errparam.extend = g_dzdb_r[l_ac_dzdb_r].dzdb003
                       LET g_errparam.popup = FALSE
                       CALL cl_err()
                       NEXT FIELD dzdb003
                    END IF
                 END IF
              END IF
               
           BEFORE INSERT 
              LET l_n = ARR_COUNT()
              LET p_cmd='a'
              INITIALIZE g_dzdb_r[l_ac_dzdb_r].* TO NULL 
              LET g_dzdb_r_t.* = g_dzdb_r[l_ac_dzdb_r].*
              NEXT FIELD dzdb003
           
           AFTER INSERT 
              CALL i400_b_dzdb_r_back()
              LET b_dzdb_r.dzdbstus= 'Y'
              LET b_dzdb_r.dzdbcrtid= g_user
              LET b_dzdb_r.dzdbcrtdp= g_dept
              LET b_dzdb_r.dzdbownid= g_user
              LET b_dzdb_r.dzdbowndp= g_dept
              LET b_dzdb_r.dzdbmodid= ''
              LET b_dzdb_r.dzdbmoddt= ''
              LET b_dzdb_r.dzdbcrtdt= g_today
              INSERT INTO dzdb_t VALUES(b_dzdb_r.*)
              IF SQLCA.sqlcode THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = SQLCA.sqlcode
                 LET g_errparam.extend = b_dzdb_r.dzdb003
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 CANCEL INSERT
              ELSE
                #CALL cl_msg('INSERT O.K')
                 MESSAGE 'INSERT O.K'
                 LET g_rec_b_dzdb_r=g_rec_b_dzdb_r+1
              END IF 
           
           ON ROW CHANGE 
              IF l_lock_sw = 'Y' THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = '-263'
                 LET g_errparam.extend = g_dzdb_r[l_ac_dzdb_r].dzdb003
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 LET g_dzdb_r[l_ac_dzdb_r].* = g_dzdb_r_t.*
              ELSE
                 CALL i400_b_dzdb_r_back()
                 LET b_dzdb_r.dzdbmodid= g_user
                 LET b_dzdb_r.dzdbmoddt= g_today
                 UPDATE dzdb_t SET * = b_dzdb_r.*
                  WHERE dzdb001 = g_dzda.dzda001
                    AND dzdb002 = 'R'
                    AND dzdb003 = g_dzdb_r_t.dzdb003
                 IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = SQLCA.sqlcode
                    LET g_errparam.extend = b_dzdb_r.dzdb003
                    LET g_errparam.popup = TRUE
                    CALL cl_err()
                    LET g_dzdb_r[l_ac_dzdb_r].* = g_dzdb_r_t.*
                 ELSE 
                   #CALL cl_msg('UPDATE O.K')
                    MESSAGE 'UPDATE O.K'
                 END IF 
              END IF 
           

           BEFORE FIELD dzdb005_r_desc
              LET g_dzdb005_desc_t = g_dzdb_r[l_ac_dzdb_r].dzdb005_desc

           AFTER FIELD dzdb005_r_desc
              IF g_dzdb005_desc_t != g_dzdb_r[l_ac_dzdb_r].dzdb005_desc
              OR (g_dzdb005_desc_t IS NOT NULL AND g_dzdb_r[l_ac_dzdb_r].dzdb005_desc IS NULL)
              OR (g_dzdb005_desc_t IS NULL AND g_dzdb_r[l_ac_dzdb_r].dzdb005_desc IS NOT NULL)
              THEN
                 LET g_dzdi003 = s_chr_trim(g_dzda.dzda001),',','R',',',s_chr_trim(g_dzdb_r[l_ac_dzdb_r].dzdb003),',',
                                 s_chr_trim(g_dzdb_r[l_ac_dzdb_r].dzdb005)
                 CALL sadz_edit_name("dzdb_t","dzdb005",g_dzdi003) RETURNING l_success
                 LET g_dzdb_r[l_ac_dzdb_r].dzdb005_desc = sadz_get_name("dzdb_t","dzdb005",g_dzdi003)
                 CALL cl_show_fld_cont()
              END IF

           ON ACTION upmoddt_item
              CASE
                 WHEN INFIELD(dzdb005_r_desc)
                    LET g_dzdi003 = s_chr_trim(g_dzda.dzda001),',','R',',',s_chr_trim(g_dzdb_r[l_ac_dzdb_r].dzdb003),',',
                                    s_chr_trim(g_dzdb_r[l_ac_dzdb_r].dzdb005)
                    CALL sadz_edit_name("dzdb_t","dzdb005",g_dzdi003) RETURNING l_success
                    LET g_dzdb_r[l_ac_dzdb_r].dzdb005_desc = sadz_get_name("dzdb_t","dzdb005",g_dzdi003)
                    CALL cl_show_fld_cont()
              END CASE

           BEFORE DELETE 
              IF NOT cl_null(g_dzdb_r_t.dzdb003) THEN 
                 IF NOT cl_ask_delete() THEN
                    CANCEL DELETE
                 END IF
                 IF l_lock_sw = "Y" THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = '-263'
                    LET g_errparam.extend = ""
                    LET g_errparam.popup = TRUE
                    CALL cl_err()
                    CANCEL DELETE
                 END IF
                 DELETE FROM dzdb_t 
                  WHERE dzdb001 = g_dzda.dzda001
                    AND dzdb002 = 'R'
                    AND dzdb003 = g_dzdb_r_t.dzdb003
                 IF SQLCA.sqlcode THEN 
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = SQLCA.sqlcode
                    LET g_errparam.extend = b_dzdb_r.dzdb003
                    LET g_errparam.popup = TRUE
                    CALL cl_err()
                    CANCEL DELETE
                 END IF 
                 LET g_rec_b_dzdb_r=g_rec_b_dzdb_r-1
              END IF 
              
           AFTER ROW 
           LET l_ac_dzdb_r = ARR_CURR()
           IF p_cmd = 'u' THEN 
              CLOSE i400_bcl_dzdb_r
           END IF 
           
       END INPUT 
       
       INPUT ARRAY g_dzdc FROM s_dzdc.*
           ATTRIBUTE(COUNT=g_rec_b_dzdc,MAXCOUNT=g_max_rec,WITHOUT DEFAULTS = TRUE,
                     INSERT ROW=l_allow_insert,DELETE ROW=l_allow_delete ,APPEND ROW =l_allow_insert )
           
           BEFORE INPUT             
              IF g_rec_b_dzdc != 0 THEN
                 CALL fgl_set_arr_curr(l_ac_dzdc)
              END IF
           
           BEFORE ROW 
              LET p_cmd = ''
              LET l_ac_dzdc = ARR_CURR()  
              LET l_cnt = ARR_COUNT()
              LET l_lock_sw = 'N'
              OPEN i400_cl USING g_dzda_rowid 
              IF SQLCA.sqlcode THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = SQLCA.sqlcode
                 LET g_errparam.extend = "OPEN i400_cl:"
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 LET INT_FLAG = 1
                 EXIT DIALOG
              END IF
              FETCH i400_cl INTO g_dzda.*  
              IF SQLCA.sqlcode THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = SQLCA.sqlcode
                 LET g_errparam.extend = "fetch i400_cl"
                 LET g_errparam.popup = FALSE
                 CALL cl_err()
                 LET INT_FLAG = 1
                 EXIT DIALOG
              END IF
              IF g_rec_b_dzdc >= l_ac_dzdc THEN
                 LET p_cmd = 'u'
                 LET g_dzdc_t.* = g_dzdc[l_ac_dzdc].*
                 OPEN i400_bcl_dzdc USING g_dzda.dzda001,g_dzdc_t.dzdc002
                 IF SQLCA.sqlcode THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = SQLCA.sqlcode
                    LET g_errparam.extend = "OPEN i400_bcl_dzdc:"
                    LET g_errparam.popup = TRUE
                    CALL cl_err()
                    LET l_lock_sw = "Y"
                 ELSE
                    FETCH i400_bcl_dzdc INTO b_dzdc.*
                    IF SQLCA.sqlcode THEN
                       INITIALIZE g_errparam TO NULL
                       LET g_errparam.code = SQLCA.sqlcode
                       LET g_errparam.extend = g_dzdc_t.dzdc002
                       LET g_errparam.popup = TRUE
                       CALL cl_err()
                       LET l_lock_sw = "Y"
                    ELSE
                       CALL i400_b_dzdc_to()
                    END IF
                 END IF
              END IF 
           
           BEFORE FIELD dzdc002 #序号
              IF cl_null(g_dzdc[l_ac_dzdc].dzdc002) THEN 
                 SELECT MAX(dzdc002) + 1 INTO g_dzdc[l_ac_dzdc].dzdc002 FROM dzdc_t 
                  WHERE dzdc001 = g_dzda.dzda001
                 IF cl_null(g_dzdc[l_ac_dzdc].dzdc002) THEN 
                    LET g_dzdc[l_ac_dzdc].dzdc002 = 1
                 END IF 
              END IF 

           AFTER FIELD dzdc002 
              #检查key值重复
              IF NOT cl_null(g_dzdc[l_ac_dzdc].dzdc002) THEN
                 IF p_cmd = 'a' OR
                    (p_cmd = 'u' AND g_dzdc[l_ac_dzdc].dzdc002 != g_dzdc_t.dzdc002) THEN 
                    SELECT COUNT(*) INTO l_cnt FROM dzdc_t 
                     WHERE dzdc001 = g_dzda.dzda001
                       AND dzdc002 = g_dzdc[l_ac_dzdc].dzdc002
                    IF l_cnt > 0 THEN 
                       INITIALIZE g_errparam TO NULL
                       LET g_errparam.code = '-239'
                       LET g_errparam.extend = g_dzdc[l_ac_dzdc].dzdc002
                       LET g_errparam.popup = FALSE
                       CALL cl_err()
                       NEXT FIELD dzdc002
                    END IF 
                 END IF 
              END IF

           BEFORE INSERT 
              LET l_n = ARR_COUNT()
              LET p_cmd='a'
              INITIALIZE g_dzdc[l_ac_dzdc].* TO NULL 
              LET g_dzdc_t.* = g_dzdc[l_ac_dzdc].*
              NEXT FIELD dzdc002
           
           AFTER INSERT 
              CALL i400_b_dzdc_back()
              LET b_dzdc.dzdcstus= 'Y'
              LET b_dzdc.dzdccrtid= g_user
              LET b_dzdc.dzdccrtdp= g_dept
              LET b_dzdc.dzdcownid= g_user
              LET b_dzdc.dzdcowndp= g_dept
              LET b_dzdc.dzdcmodid= ''
              LET b_dzdc.dzdcmoddt= ''
              LET b_dzdc.dzdccrtdt= g_today
              INSERT INTO dzdc_t VALUES(b_dzdc.*)
              IF SQLCA.sqlcode THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = SQLCA.sqlcode
                 LET g_errparam.extend = b_dzdc.dzdc002
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 CANCEL INSERT
              ELSE
                #CALL cl_msg('INSERT O.K')
                 MESSAGE 'INSERT O.K'
                 LET g_rec_b_dzdc=g_rec_b_dzdc+1
              END IF 
           
           ON ROW CHANGE 
              IF l_lock_sw = 'Y' THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = '-263'
                 LET g_errparam.extend = g_dzdc[l_ac_dzdc].dzdc002
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 LET g_dzdc[l_ac_dzdc].* = g_dzdc_t.*
              ELSE
                 CALL i400_b_dzdc_back()
                 LET b_dzdc.dzdcmodid= g_user
                 LET b_dzdc.dzdcmoddt= g_today
                 UPDATE dzdc_t SET * = b_dzdc.*
                  WHERE dzdc001 = g_dzda.dzda001
                    AND dzdc002 = g_dzdc_t.dzdc002
                 IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = SQLCA.sqlcode
                    LET g_errparam.extend = b_dzdc.dzdc002
                    LET g_errparam.popup = TRUE
                    CALL cl_err()
                    LET g_dzdc[l_ac_dzdc].* = g_dzdc_t.*
                 ELSE 
                   #CALL cl_msg('UPDATE O.K')
                    MESSAGE 'UPDATE O.K'
                 END IF 
              END IF 

           BEFORE FIELD dzdc002_desc
              LET g_dzdb005_desc_t = g_dzdc[l_ac_dzdc].dzdc002_desc

           AFTER FIELD dzdc002_desc
              IF g_dzdc002_desc_t != g_dzdc[l_ac_dzdc].dzdc002_desc
              OR (g_dzdc002_desc_t IS NOT NULL AND g_dzdc[l_ac_dzdc].dzdc002_desc IS NULL)
              OR (g_dzdc002_desc_t IS NULL AND g_dzdc[l_ac_dzdc].dzdc002_desc IS NOT NULL)
              THEN
                 LET g_dzdi003 = s_chr_trim(g_dzda.dzda001),',',s_chr_trim(g_dzdc[l_ac_dzdc].dzdc002)
                 CALL sadz_edit_name("dzdc_t","dzdc002",g_dzdi003) RETURNING l_success
                 LET g_dzdc[l_ac_dzdc].dzdc002_desc = sadz_get_name("dzdc_t","dzdc002",g_dzdi003)
                 CALL cl_show_fld_cont()
              END IF

           ON ACTION upmoddt_item
              CASE
                 WHEN INFIELD(dzdc002_desc)
                    LET g_dzdi003 = s_chr_trim(g_dzda.dzda001),',',s_chr_trim(g_dzdc[l_ac_dzdc].dzdc002)
                    CALL sadz_edit_name("dzdc_t","dzdc002",g_dzdi003) RETURNING l_success
                    LET g_dzdc[l_ac_dzdc].dzdc002_desc = sadz_get_name("dzdc_t","dzdc002",g_dzdi003)
                    CALL cl_show_fld_cont()
              END CASE
           
           BEFORE DELETE 
              IF g_dzdc_t.dzdc002 > 0 AND NOT cl_null(g_dzdc_t.dzdc002) THEN 
                 IF NOT cl_ask_delete() THEN
                    CANCEL DELETE
                 END IF
                 IF l_lock_sw = "Y" THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = '-263'
                    LET g_errparam.extend = ""
                    LET g_errparam.popup = TRUE
                    CALL cl_err()
                    CANCEL DELETE
                 END IF
                 DELETE FROM dzdc_t 
                  WHERE dzdc001 = g_dzda.dzda001
                    AND dzdc002 = g_dzdc_t.dzdc002
                 IF SQLCA.sqlcode THEN 
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = SQLCA.sqlcode
                    LET g_errparam.extend = b_dzdc.dzdc002
                    LET g_errparam.popup = TRUE
                    CALL cl_err()
                    CANCEL DELETE
                 END IF 
                 LET g_rec_b_dzdc=g_rec_b_dzdc-1
              END IF 
              
           AFTER ROW 
           LET l_ac_dzdc = ARR_CURR()
           IF p_cmd = 'u' THEN 
              CLOSE i400_bcl_dzdc 
           END IF 
       END INPUT 
       
       INPUT ARRAY g_dzdd_b FROM s_dzdd_b.*
           ATTRIBUTE(COUNT=g_rec_b_dzdd_b,MAXCOUNT=g_max_rec,WITHOUT DEFAULTS = TRUE,
                     INSERT ROW=l_allow_insert,DELETE ROW=l_allow_delete ,APPEND ROW =l_allow_insert )
           
           BEFORE INPUT             
              IF g_rec_b_dzdd_b != 0 THEN
                 CALL fgl_set_arr_curr(l_ac_dzdd_b)
              END IF

           BEFORE ROW 
              LET p_cmd = ''
              LET l_ac_dzdd_b = ARR_CURR()  
              LET l_cnt = ARR_COUNT()
              LET l_lock_sw = 'N'
              OPEN i400_cl USING g_dzda_rowid 
              IF SQLCA.sqlcode THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = SQLCA.sqlcode
                 LET g_errparam.extend = "OPEN i400_cl:"
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 LET INT_FLAG = 1
                 EXIT DIALOG
              END IF
              FETCH i400_cl INTO g_dzda.*  
              IF SQLCA.sqlcode THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = SQLCA.sqlcode
                 LET g_errparam.extend = "fetch i400_cl"
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 LET INT_FLAG = 1
                 EXIT DIALOG
              END IF
              IF g_rec_b_dzdd_b >= l_ac_dzdd_b THEN
                 LET p_cmd = 'u'
                 LET g_dzdd_b_t.* = g_dzdd_b[l_ac_dzdd_b].*
                 OPEN i400_bcl_dzdd_b USING g_dzda.dzda001,g_dzdd_b_t.dzdd002
                 IF SQLCA.sqlcode THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = SQLCA.sqlcode
                    LET g_errparam.extend = "OPEN i400_bcl_dzdd_b:"
                    LET g_errparam.popup = TRUE
                    CALL cl_err()
                    LET l_lock_sw = "Y"
                 ELSE
                    FETCH i400_bcl_dzdd_b INTO b_dzdd_b.*
                    IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = SQLCA.sqlcode
                      LET g_errparam.extend = g_dzdd_b_t.dzdd002
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                    ELSE
                      CALL i400_b_dzdd_b_to()
                    END IF
                 END IF
                 #CALL cl_set_comp_entry("dzdd002",FALSE)  
              END IF 
           
           BEFORE FIELD dzdd002
              IF cl_null(g_dzdd_b[l_ac_dzdd_b].dzdd002) THEN 
                 SELECT MAX(dzdd002) + 1 INTO g_dzdd_b[l_ac_dzdd_b].dzdd002 FROM dzdd_t 
                  WHERE dzdd001 = g_dzda.dzda001
                 IF cl_null(g_dzdd_b[l_ac_dzdd_b].dzdd002) THEN 
                    LET g_dzdd_b[l_ac_dzdd_b].dzdd002 = 1
                 END IF 
              END IF 
              
           AFTER FIELD dzdd002
              #检查key值重复
              IF NOT cl_null(g_dzdd_b[l_ac_dzdd_b].dzdd002) THEN
                 IF p_cmd = 'a' OR
                    (p_cmd = 'u' AND g_dzdd_b[l_ac_dzdd_b].dzdd002 != g_dzdd_b_t.dzdd002) THEN
                    SELECT COUNT(*) INTO l_cnt FROM dzdd_t
                     WHERE dzdd001 = g_dzda.dzda001
                       AND dzdd002 = g_dzdd_b[l_ac_dzdd_b].dzdd002
                       AND dzdd007 = 'B'
                    IF l_cnt > 0 THEN
                       INITIALIZE g_errparam TO NULL
                       LET g_errparam.code = '-239'
                       LET g_errparam.extend = g_dzdd_b[l_ac_dzdd_b].dzdd002
                       LET g_errparam.popup = FALSE
                       CALL cl_err()
                       NEXT FIELD dzdd002
                    END IF
                 END IF
              END IF

           BEFORE INSERT 
              LET l_n = ARR_COUNT()
              LET p_cmd='a'
              INITIALIZE g_dzdd_b[l_ac_dzdd_b].* TO NULL
              LET g_dzdd_b_t.* = g_dzdd_b[l_ac_dzdd_b].*
              NEXT FIELD dzdd002
           
           AFTER INSERT 
              CALL i400_b_dzdd_b_back()
              LET b_dzdd_b.dzddstus= 'Y'
              LET b_dzdd_b.dzddcrtid= g_user
              LET b_dzdd_b.dzddcrtdp= g_dept
              LET b_dzdd_b.dzddownid= g_user
              LET b_dzdd_b.dzddowndp= g_dept
              LET b_dzdd_b.dzddmodid= ''
              LET b_dzdd_b.dzddmoddt= ''
              LET b_dzdd_b.dzddcrtdt= g_today
              INSERT INTO dzdd_t VALUES(b_dzdd_b.*)
              IF SQLCA.sqlcode THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = SQLCA.sqlcode
                 LET g_errparam.extend = b_dzdd_b.dzdd002
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 CANCEL INSERT
              ELSE
                #CALL cl_msg('INSERT O.K')
                 MESSAGE 'INSERT O.K'
                 LET g_rec_b_dzdd_b=g_rec_b_dzdd_b+1
              END IF 
           
           ON ROW CHANGE 
              IF l_lock_sw = 'Y' THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = '-263'
                 LET g_errparam.extend = g_dzdd_b[l_ac_dzdd_b].dzdd002
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 LET g_dzdd_b[l_ac_dzdd_b].* = g_dzdd_b_t.*
              ELSE
                 CALL i400_b_dzdd_b_back()
                 LET b_dzdd_b.dzddmodid= g_user
                 LET b_dzdd_b.dzddmoddt= g_today
                 UPDATE dzdd_t SET * = b_dzdd_b.*
                  WHERE dzdd001 = g_dzda.dzda001
                    AND dzdd002 = g_dzdd_b_t.dzdd002
                    AND dzdd007 = 'B'
                 IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = SQLCA.sqlcode
                    LET g_errparam.extend = b_dzdd_b.dzdd002
                    LET g_errparam.popup = TRUE
                    CALL cl_err()
                    LET g_dzdd_b[l_ac_dzdd_b].* = g_dzdd_b_t.*
                 ELSE 
                   #CALL cl_msg('UPDATE O.K')
                    MESSAGE 'UPDATE O.K'
                 END IF 
              END IF 

           BEFORE FIELD dzdd004_desc
              LET g_dzdd004_desc_t = g_dzdd_b[l_ac_dzdd_b].dzdd004_desc

           AFTER FIELD dzdd004_desc
              IF g_dzdd004_desc_t != g_dzdd_b[l_ac_dzdd_b].dzdd004_desc
              OR (g_dzdd004_desc_t IS NOT NULL AND g_dzdd_b[l_ac_dzdd_b].dzdd004_desc IS NULL)
              OR (g_dzdd004_desc_t IS NULL AND g_dzdd_b[l_ac_dzdd_b].dzdd004_desc IS NOT NULL)
              THEN
                 LET g_dzdi003 = s_chr_trim(g_dzda.dzda001),',',s_chr_trim(g_dzdd_b[l_ac_dzdd_b].dzdd002),',',s_chr_trim(g_dzdd_b[l_ac_dzdd_b].dzdd004)
                 CALL sadz_edit_name("dzdd_t","dzdd004",g_dzdi003) RETURNING l_success
                 LET g_dzdd_b[l_ac_dzdd_b].dzdd004_desc = sadz_get_name("dzdd_t","dzdd004",g_dzdi003)
                 CALL cl_show_fld_cont()
              END IF

           ON ACTION upmoddt_item
              CASE
                 WHEN INFIELD(dzdd004_desc)
                    LET g_dzdi003 = s_chr_trim(g_dzda.dzda001),',',s_chr_trim(g_dzdd_b[l_ac_dzdd_b].dzdd002),',',s_chr_trim(g_dzdd_b[l_ac_dzdd_b].dzdd004)
                    CALL sadz_edit_name("dzdd_t","dzdd004",g_dzdi003) RETURNING l_success
                    LET g_dzdd_b[l_ac_dzdd_b].dzdd004_desc = sadz_get_name("dzdd_t","dzdd004",g_dzdi003)
                    CALL cl_show_fld_cont()
              END CASE

           BEFORE DELETE 
              IF g_dzdd_b_t.dzdd002 > 0 AND NOT cl_null(g_dzdd_b_t.dzdd002) THEN 
                 IF NOT cl_ask_delete() THEN
                    CANCEL DELETE
                 END IF
                 IF l_lock_sw = "Y" THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = '-263'
                    LET g_errparam.extend = ''
                    LET g_errparam.popup = TRUE
                    CALL cl_err()
                    CANCEL DELETE
                 END IF
                 DELETE FROM dzdd_t 
                  WHERE dzdd001 = g_dzda.dzda001
                    AND dzdd002 = g_dzdd_b_t.dzdd002
                    AND dzdd007 = 'B'
                 IF SQLCA.sqlcode THEN 
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = SQLCA.sqlcode
                    LET g_errparam.extend = b_dzdd_b.dzdd002
                    LET g_errparam.popup = TRUE
                    CALL cl_err()
                    CANCEL DELETE
                 END IF 
                 LET g_rec_b_dzdd_b=g_rec_b_dzdd_b-1
              END IF 
              
           AFTER ROW 
           LET l_ac_dzdd_b = ARR_CURR()   
           IF p_cmd = 'u' THEN 
              CLOSE i400_bcl_dzdd_b
           END IF 
       END INPUT 

       INPUT ARRAY g_dzdd_a FROM s_dzdd_a.*
           ATTRIBUTE(COUNT=g_rec_b_dzdd_a,MAXCOUNT=g_max_rec,WITHOUT DEFAULTS = TRUE,
                     INSERT ROW=l_allow_insert,DELETE ROW=l_allow_delete ,APPEND ROW =l_allow_insert )
           
           BEFORE INPUT             
              IF g_rec_b_dzdd_a != 0 THEN
                 CALL fgl_set_arr_curr(l_ac_dzdd_a)
              END IF

           BEFORE ROW 
              LET p_cmd = ''
              LET l_ac_dzdd_a = ARR_CURR()  
              LET l_cnt = ARR_COUNT()
              LET l_lock_sw = 'N'
              OPEN i400_cl USING g_dzda_rowid 
              IF SQLCA.sqlcode THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = SQLCA.sqlcode
                 LET g_errparam.extend = "OPEN i400_cl:"
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 LET INT_FLAG = 1
                 EXIT DIALOG
              END IF
              FETCH i400_cl INTO g_dzda.*  
              IF SQLCA.sqlcode THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = SQLCA.sqlcode
                 LET g_errparam.extend = "fetch i400_cl"
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 LET INT_FLAG = 1
                 EXIT DIALOG
              END IF
              IF g_rec_b_dzdd_a >= l_ac_dzdd_a THEN
                 LET p_cmd = 'u'
                 LET g_dzdd_a_t.* = g_dzdd_a[l_ac_dzdd_a].*
                 OPEN i400_bcl_dzdd_a USING g_dzda.dzda001,g_dzdd_a_t.dzdd002
                 IF SQLCA.sqlcode THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = SQLCA.sqlcode
                    LET g_errparam.extend = "OPEN i400_bcl_dzdd_a:"
                    LET g_errparam.popup = TRUE
                    CALL cl_err()
                    LET l_lock_sw = "Y"
                 ELSE
                    FETCH i400_bcl_dzdd_a INTO b_dzdd_a.*
                    IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = SQLCA.sqlcode
                      LET g_errparam.extend = g_dzdd_a_t.dzdd002
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                    ELSE
                      CALL i400_b_dzdd_a_to()
                    END IF
                 END IF
                 #CALL cl_set_comp_entry("dzdd002",FALSE)  
              END IF 
           
           BEFORE FIELD dzdd002
              IF cl_null(g_dzdd_a[l_ac_dzdd_a].dzdd002) THEN 
                 SELECT MAX(dzdd002) + 1 INTO g_dzdd_a[l_ac_dzdd_a].dzdd002 FROM dzdd_t 
                  WHERE dzdd001 = g_dzda.dzda001
                 IF cl_null(g_dzdd_a[l_ac_dzdd_a].dzdd002) THEN 
                    LET g_dzdd_a[l_ac_dzdd_a].dzdd002 = 1
                 END IF 
              END IF 
              
           AFTER FIELD dzdd002
              #检查key值重复
              IF NOT cl_null(g_dzdd_a[l_ac_dzdd_a].dzdd002) THEN
                 IF p_cmd = 'a' OR
                    (p_cmd = 'u' AND g_dzdd_a[l_ac_dzdd_a].dzdd002 != g_dzdd_a_t.dzdd002) THEN
                    SELECT COUNT(*) INTO l_cnt FROM dzdd_t
                     WHERE dzdd001 = g_dzda.dzda001
                       AND dzdd002 = g_dzdd_a[l_ac_dzdd_a].dzdd002
                       AND dzdd007 = 'A'
                    IF l_cnt > 0 THEN
                       INITIALIZE g_errparam TO NULL
                       LET g_errparam.code = '-239'
                       LET g_errparam.extend = g_dzdd_a[l_ac_dzdd_a].dzdd002
                       LET g_errparam.popup = FALSE
                       CALL cl_err()
                       NEXT FIELD dzdd002
                    END IF
                 END IF
              END IF

           BEFORE INSERT 
              LET l_n = ARR_COUNT()
              LET p_cmd='a'
              INITIALIZE g_dzdd_a[l_ac_dzdd_a].* TO NULL
              LET g_dzdd_a_t.* = g_dzdd_a[l_ac_dzdd_a].*
              NEXT FIELD dzdd002
           
           AFTER INSERT 
              CALL i400_b_dzdd_a_back()
              LET b_dzdd_a.dzddstus= 'Y'
              LET b_dzdd_a.dzddcrtid= g_user
              LET b_dzdd_a.dzddcrtdp= g_dept
              LET b_dzdd_a.dzddownid= g_user
              LET b_dzdd_a.dzddowndp= g_dept
              LET b_dzdd_a.dzddmodid= ''
              LET b_dzdd_a.dzddmoddt= ''
              LET b_dzdd_a.dzddcrtdt= g_today
              INSERT INTO dzdd_t VALUES(b_dzdd_a.*)
              IF SQLCA.sqlcode THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = SQLCA.sqlcode
                 LET g_errparam.extend = b_dzdd_a.dzdd002
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 CANCEL INSERT
              ELSE
                #CALL cl_msg('INSERT O.K')
                 MESSAGE 'INSERT O.K'
                 LET g_rec_b_dzdd_a=g_rec_b_dzdd_a+1
              END IF 
           
           ON ROW CHANGE 
              IF l_lock_sw = 'Y' THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = '-263'
                 LET g_errparam.extend = g_dzdd_a[l_ac_dzdd_a].dzdd002
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 LET g_dzdd_a[l_ac_dzdd_a].* = g_dzdd_a_t.*
              ELSE
                 CALL i400_b_dzdd_a_back()
                 LET b_dzdd_a.dzddmodid= g_user
                 LET b_dzdd_a.dzddmoddt= g_today
                 UPDATE dzdd_t SET * = b_dzdd_a.*
                  WHERE dzdd001 = g_dzda.dzda001
                    AND dzdd002 = g_dzdd_a_t.dzdd002
                    AND dzdd007 = 'A'
                 IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = SQLCA.sqlcode
                    LET g_errparam.extend = b_dzdd_a.dzdd002
                    LET g_errparam.popup = TRUE
                    CALL cl_err()
                    LET g_dzdd_a[l_ac_dzdd_a].* = g_dzdd_a_t.*
                 ELSE 
                   #CALL cl_msg('UPDATE O.K')
                    MESSAGE 'UPDATE O.K'
                 END IF 
              END IF 

           BEFORE FIELD dzdd004_desc
              LET g_dzdd004_desc_t = g_dzdd_a[l_ac_dzdd_a].dzdd004_desc

           AFTER FIELD dzdd004_desc
              IF g_dzdd004_desc_t != g_dzdd_a[l_ac_dzdd_a].dzdd004_desc
              OR (g_dzdd004_desc_t IS NOT NULL AND g_dzdd_a[l_ac_dzdd_a].dzdd004_desc IS NULL)
              OR (g_dzdd004_desc_t IS NULL AND g_dzdd_a[l_ac_dzdd_a].dzdd004_desc IS NOT NULL)
              THEN
                 LET g_dzdi003 = s_chr_trim(g_dzda.dzda001),',',s_chr_trim(g_dzdd_a[l_ac_dzdd_a].dzdd002),',',s_chr_trim(g_dzdd_a[l_ac_dzdd_a].dzdd004)
                 CALL sadz_edit_name("dzdd_t","dzdd004",g_dzdi003) RETURNING l_success
                 LET g_dzdd_a[l_ac_dzdd_a].dzdd004_desc = sadz_get_name("dzdd_t","dzdd004",g_dzdi003)
                 CALL cl_show_fld_cont()
              END IF

           ON ACTION upmoddt_item
              CASE
                 WHEN INFIELD(dzdd004_desc)
                    LET g_dzdi003 = s_chr_trim(g_dzda.dzda001),',',s_chr_trim(g_dzdd_a[l_ac_dzdd_a].dzdd002),',',s_chr_trim(g_dzdd_a[l_ac_dzdd_a].dzdd004)
                    CALL sadz_edit_name("dzdd_t","dzdd004",g_dzdi003) RETURNING l_success
                    LET g_dzdd_a[l_ac_dzdd_a].dzdd004_desc = sadz_get_name("dzdd_t","dzdd004",g_dzdi003)
                    CALL cl_show_fld_cont()
              END CASE

           BEFORE DELETE 
              IF g_dzdd_a_t.dzdd002 > 0 AND NOT cl_null(g_dzdd_a_t.dzdd002) THEN 
                 IF NOT cl_ask_delete() THEN
                    CANCEL DELETE
                 END IF
                 IF l_lock_sw = "Y" THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = '-263'
                    LET g_errparam.extend = ''
                    LET g_errparam.popup = TRUE
                    CALL cl_err()
                    CANCEL DELETE
                 END IF
                 DELETE FROM dzdd_t 
                  WHERE dzdd001 = g_dzda.dzda001
                    AND dzdd002 = g_dzdd_a_t.dzdd002
                    AND dzdd007 = 'A'
                 IF SQLCA.sqlcode THEN 
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = SQLCA.sqlcode
                    LET g_errparam.extend = b_dzdd_a.dzdd002
                    LET g_errparam.popup = TRUE
                    CALL cl_err()
                    CANCEL DELETE
                 END IF 
                 LET g_rec_b_dzdd_a=g_rec_b_dzdd_a-1
              END IF 
              
           AFTER ROW 
           LET l_ac_dzdd_a = ARR_CURR()   
           IF p_cmd = 'u' THEN 
              CLOSE i400_bcl_dzdd_a
           END IF 
       END INPUT 

       INPUT ARRAY g_dzdh FROM s_dzdh.*
           ATTRIBUTE(COUNT=g_rec_b_dzdh,MAXCOUNT=g_max_rec,WITHOUT DEFAULTS = TRUE,
                     INSERT ROW=l_allow_insert,DELETE ROW=l_allow_delete ,APPEND ROW =l_allow_insert )
           
           BEFORE INPUT             
              IF g_rec_b_dzdh != 0 THEN
                 CALL fgl_set_arr_curr(l_ac_dzdh)
              END IF
           BEFORE ROW 
              LET p_cmd = ''
              LET l_ac_dzdh = ARR_CURR()  
              LET l_cnt = ARR_COUNT()
              LET l_lock_sw = 'N'
              OPEN i400_cl USING g_dzda_rowid 
              IF SQLCA.sqlcode THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = SQLCA.sqlcode
                 LET g_errparam.extend = "OPEN i400_cl:"
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 LET INT_FLAG = 1
                 EXIT DIALOG
              END IF
              FETCH i400_cl INTO g_dzda.*  
              IF SQLCA.sqlcode THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = SQLCA.sqlcode
                 LET g_errparam.extend = "fetch i400_cl"
                 LET g_errparam.popup = FALSE
                 CALL cl_err()
                 LET INT_FLAG = 1
                 EXIT DIALOG
              END IF
              IF g_rec_b_dzdh >= l_ac_dzdh THEN
                 LET p_cmd = 'u'
                 LET g_dzdh_t.* = g_dzdh[l_ac_dzdh].*
                 OPEN i400_bcl_dzdh USING g_dzda.dzda001,g_dzdh_t.dzdh001,g_dzdh_t.dzdh002
                 IF SQLCA.sqlcode THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = SQLCA.sqlcode
                    LET g_errparam.extend = "OPEN i400_bcl_dzdh:"
                    LET g_errparam.popup = TRUE
                    CALL cl_err()
                    LET l_lock_sw = "Y"
                 ELSE
                    FETCH i400_bcl_dzdh INTO b_dzdh.*
                    IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = SQLCA.sqlcode
                      LET g_errparam.extend = g_dzdh_t.dzdh002
                      LET g_errparam.popup = TRUE
                      CALL cl_err()
                      LET l_lock_sw = "Y"
                    ELSE
                      CALL i400_b_dzdh_to()
                    END IF
                 END IF
                 #CALL cl_set_comp_entry("dzdh001",FALSE)  
              END IF 
           
           AFTER FIELD dzdh001
              IF NOT cl_null(g_dzdh[l_ac_dzdh].dzdh001) THEN
                 #检查是否存在此维度资料
                 SELECT COUNT(*) INTO l_cnt FROM dzdg_t
                  WHERE dzdg001 = g_dzdh[l_ac_dzdh].dzdh001
                    AND dzdgstus='Y'
                 IF l_cnt = 0 THEN
                    #zll 不存在维度资料
                    MESSAGE "不存在维度资料"
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = ''
                    LET g_errparam.extend = g_dzdh[l_ac_dzdh].dzdh001
                    LET g_errparam.popup = FALSE
                    CALL cl_err()
                    NEXT FIELD dzdh001
                 END IF

                 #显示名称说明
                 LET g_dzdi003 = s_chr_trim(g_dzdh[l_ac_dzdh].dzdh001)
                 LET g_dzdh[l_ac_dzdh].dzdh001_desc = sadz_get_name("dzdg_t","dzdg001",g_dzdi003)
                 DISPLAY BY NAME g_dzdh[l_ac_dzdh].dzdh001_desc

                 IF NOT cl_null(g_dzdh[l_ac_dzdh].dzdh002) THEN
                    #检查是否存在此维度分类资料
                    SELECT COUNT(*) INTO l_cnt FROM dzdg_t
                     WHERE dzdg001 = g_dzdh[l_ac_dzdh].dzdh001
                       AND dzdg002 = g_dzdh[l_ac_dzdh].dzdh002
                       AND dzdgstus='Y'
                    IF l_cnt = 0 THEN
                       #zll 不存在维度分类资料
                       MESSAGE "不存在维度分类资料"
                       INITIALIZE g_errparam TO NULL
                       LET g_errparam.code = ''
                       LET g_errparam.extend = g_dzdh[l_ac_dzdh].dzdh002
                       LET g_errparam.popup = FALSE
                       CALL cl_err()
                       NEXT FIELD dzdh002
                    END IF
                    #检查key值重复
                    IF p_cmd = 'a' OR
                       (p_cmd = 'u' AND g_dzdh[l_ac_dzdh].dzdh001 != g_dzdh_t.dzdh001) THEN
                       SELECT COUNT(*) INTO l_cnt FROM dzdh_t
                        WHERE dzdh003 = g_dzda.dzda001
                          AND dzdh001 = g_dzdh[l_ac_dzdh].dzdh001
                          AND dzdh002 = g_dzdh[l_ac_dzdh].dzdh002
                       IF l_cnt > 0 THEN
                          INITIALIZE g_errparam TO NULL
                          LET g_errparam.code = '-239'
                          LET g_errparam.extend = g_dzdh[l_ac_dzdh].dzdh001
                          LET g_errparam.popup = TRUE
                          CALL cl_err()
                          NEXT FIELD dzdh001
                       END IF
                    END IF
                 END IF
              END IF

           AFTER FIELD dzdh002
              IF NOT cl_null(g_dzdh[l_ac_dzdh].dzdh002) THEN
                 #检查是否存在此维度分类资料
                 IF NOT cl_null(g_dzdh[l_ac_dzdh].dzdh001) THEN
                    SELECT COUNT(*) INTO l_cnt FROM dzdg_t
                     WHERE dzdg001 = g_dzdh[l_ac_dzdh].dzdh001
                       AND dzdg002 = g_dzdh[l_ac_dzdh].dzdh002
                       AND dzdgstus='Y'
                    IF l_cnt = 0 THEN
                       #zll 不存在维度分类资料
                       MESSAGE "不存在维度分类资料"
                       INITIALIZE g_errparam TO NULL
                       LET g_errparam.code = ''
                       LET g_errparam.extend = g_dzdh[l_ac_dzdh].dzdh002
                       LET g_errparam.popup = FALSE
                       CALL cl_err()
                       NEXT FIELD dzdh002
                    END IF

                    #显示名称说明
                    LET g_dzdi003 = s_chr_trim(g_dzdh[l_ac_dzdh].dzdh001),',',s_chr_trim(g_dzdh[l_ac_dzdh].dzdh002)
                    LET g_dzdh[l_ac_dzdh].dzdh002_desc = sadz_get_name("dzdg_t","dzdg002",g_dzdi003)
                    DISPLAY BY NAME g_dzdh[l_ac_dzdh].dzdh002_desc
                 END IF
                 #检查key值重复
                 IF p_cmd = 'a' OR
                    (p_cmd = 'u' AND g_dzdh[l_ac_dzdh].dzdh002 != g_dzdh_t.dzdh002) THEN
                    SELECT COUNT(*) INTO l_cnt FROM dzdh_t
                     WHERE dzdh003 = g_dzda.dzda001
                       AND dzdh001 = g_dzdh[l_ac_dzdh].dzdh001
                       AND dzdh002 = g_dzdh[l_ac_dzdh].dzdh002
                    IF l_cnt > 0 THEN
                       INITIALIZE g_errparam TO NULL
                       LET g_errparam.code = '-239'
                       LET g_errparam.extend = g_dzdh[l_ac_dzdh].dzdh002
                       LET g_errparam.popup = TRUE
                       CALL cl_err()
                       NEXT FIELD dzdh002
                    END IF
                 END IF
              END IF

           BEFORE INSERT 
              LET l_n = ARR_COUNT()
              LET p_cmd='a'
              INITIALIZE g_dzdh[l_ac_dzdh].* TO NULL 
              LET g_dzdh_t.* = g_dzdh[l_ac_dzdh].*
              NEXT FIELD dzdh001
           
           AFTER INSERT 
              CALL i400_b_dzdh_back()
              LET b_dzdh.dzdhcrtid= g_user
              LET b_dzdh.dzdhcrtdp= g_dept
              LET b_dzdh.dzdhownid= g_user
              LET b_dzdh.dzdhowndp= g_dept
              LET b_dzdh.dzdhmodid= ''
              LET b_dzdh.dzdhmoddt= ''
              LET b_dzdh.dzdhcrtdt= g_today
              INSERT INTO dzdh_t VALUES(b_dzdh.*)
              IF SQLCA.sqlcode THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = SQLCA.sqlcode
                 LET g_errparam.extend = b_dzdh.dzdh002
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 CANCEL INSERT
              ELSE
                #CALL cl_msg('INSERT O.K')
                 MESSAGE 'INSERT O.K'
                 LET g_rec_b_dzdh=g_rec_b_dzdh+1
              END IF 
           
           ON ROW CHANGE 
              IF l_lock_sw = 'Y' THEN
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = '-263'
                 LET g_errparam.extend = g_dzdh[l_ac_dzdh].dzdh002
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
                 LET g_dzdh[l_ac_dzdh].* = g_dzdh_t.*
              ELSE
                 CALL i400_b_dzdh_back()
                 LET b_dzdh.dzdhmodid= g_user
                 LET b_dzdh.dzdhmoddt= g_today
                 UPDATE dzdh_t SET * = b_dzdh.*
                  WHERE dzdh003 = g_dzda.dzda001
                    AND dzdh001 = g_dzdh_t.dzdh001
                    AND dzdh002 = g_dzdh_t.dzdh002
                 IF SQLCA.sqlcode OR SQLCA.sqlerrd[3] = 0 THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = SQLCA.sqlcode
                    LET g_errparam.extend = b_dzdh.dzdh002
                    LET g_errparam.popup = TRUE
                    CALL cl_err()
                    LET g_dzdh[l_ac_dzdh].* = g_dzdh_t.*
                 ELSE 
                   #CALL cl_msg('UPDATE O.K')
                    MESSAGE 'UPDATE O.K'
                 END IF 
              END IF 

           BEFORE DELETE 
              IF NOT cl_null(g_dzdh_t.dzdh001) THEN 
                 IF NOT cl_ask_delete() THEN
                    CANCEL DELETE
                 END IF
                 IF l_lock_sw = "Y" THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = '-263'
                    LET g_errparam.extend = ''
                    LET g_errparam.popup = TRUE
                    CALL cl_err()
                    CANCEL DELETE
                 END IF
                 DELETE FROM dzdh_t 
                  WHERE dzdh003 = g_dzda.dzda001
                    AND dzdh001 = g_dzdh_t.dzdh001
                    AND dzdh002 = g_dzdh_t.dzdh002
                 IF SQLCA.sqlcode THEN 
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = SQLCA.sqlcode
                    LET g_errparam.extend = b_dzdh.dzdh002
                    LET g_errparam.popup = TRUE
                    CALL cl_err()
                    CANCEL DELETE
                 END IF 
                 LET g_rec_b_dzdh=g_rec_b_dzdh-1
              END IF 
              
           AFTER ROW 
           LET l_ac_dzdh = ARR_CURR()   
           IF p_cmd = 'u' THEN 
              CLOSE i400_bcl_dzdh
           END IF 
       END INPUT 
     
       BEFORE DIALOG
          CALL cl_set_act_visible("close,append", FALSE)
          CALL s_transaction_begin()
          
       ON ACTION accept 
          ACCEPT DIALOG
          
       ON ACTION cancel
          LET INT_FLAG = 1
          EXIT DIALOG 
          
       ON ACTION CONTROLG
          CALL cl_cmdask()
       
       ON ACTION about         
          CALL cl_about()
        
       #ON ACTION help         
       #   CALL cl_show_help()
    
    END DIALOG
    IF INT_FLAG THEN
       LET INT_FLAG = 0
       CLOSE i400_cl
       CALL s_transaction_end('N',0)
       RETURN 
    END IF 
    CLOSE i400_cl
    CALL s_transaction_end('Y',0)

END FUNCTION 

FUNCTION i400_b_dzdb_p_to()
    LET g_dzdb_p[l_ac_dzdb_p].dzdb003 = b_dzdb_p.dzdb003
    LET g_dzdb_p[l_ac_dzdb_p].dzdb005 = b_dzdb_p.dzdb005
    LET g_dzdb_p[l_ac_dzdb_p].dzdb007 = b_dzdb_p.dzdb007

    LET g_dzdi003 = s_chr_trim(g_dzda.dzda001),',','P',',',s_chr_trim(g_dzdb_p[l_ac_dzdb_p].dzdb003),',',s_chr_trim(g_dzdb_p[l_ac_dzdb_p].dzdb005)
    LET g_dzdb_p[l_ac_dzdb_p].dzdb005_desc = sadz_get_name("dzdb_t","dzdb005",g_dzdi003)
END FUNCTION 

FUNCTION i400_b_dzdb_p_back()
    LET b_dzdb_p.dzdb001 = g_dzda.dzda001
    LET b_dzdb_p.dzdb002 = 'P'
    LET b_dzdb_p.dzdb003 = g_dzdb_p[l_ac_dzdb_p].dzdb003
    LET b_dzdb_p.dzdb005 = g_dzdb_p[l_ac_dzdb_p].dzdb005
    LET b_dzdb_p.dzdb007 = g_dzdb_p[l_ac_dzdb_p].dzdb007
END FUNCTION 

FUNCTION i400_b_dzdb_r_to()
    LET g_dzdb_r[l_ac_dzdb_r].dzdb003 = b_dzdb_r.dzdb003
    LET g_dzdb_r[l_ac_dzdb_r].dzdb005 = b_dzdb_r.dzdb005
    LET g_dzdb_r[l_ac_dzdb_r].dzdb007 = b_dzdb_r.dzdb007

    LET g_dzdi003 = s_chr_trim(g_dzda.dzda001),',','R',',',s_chr_trim(g_dzdb_r[l_ac_dzdb_r].dzdb003),',',s_chr_trim(g_dzdb_r[l_ac_dzdb_r].dzdb005)
    LET g_dzdb_r[l_ac_dzdb_r].dzdb005_desc = sadz_get_name("dzdb_t","dzdb005",g_dzdi003)
END FUNCTION

FUNCTION i400_b_dzdb_r_back()
    LET b_dzdb_r.dzdb001 = g_dzda.dzda001
    LET b_dzdb_r.dzdb002 = 'R'
    LET b_dzdb_r.dzdb003 = g_dzdb_r[l_ac_dzdb_r].dzdb003
    LET b_dzdb_r.dzdb005 = g_dzdb_r[l_ac_dzdb_r].dzdb005
    LET b_dzdb_r.dzdb007 = g_dzdb_r[l_ac_dzdb_r].dzdb007
END FUNCTION

FUNCTION i400_b_dzdc_to()
    LET g_dzdc[l_ac_dzdc].dzdc002 = b_dzdc.dzdc002

    LET g_dzdi003 = s_chr_trim(g_dzda.dzda001),',',s_chr_trim(g_dzdc[l_ac_dzdc].dzdc002)
    LET g_dzdc[l_ac_dzdc].dzdc002_desc = sadz_get_name("dzdc_t","dzdc002",g_dzdi003)
END FUNCTION 

FUNCTION i400_b_dzdc_back()
    LET b_dzdc.dzdc001 = g_dzda.dzda001
    LET b_dzdc.dzdc002 = g_dzdc[l_ac_dzdc].dzdc002
END FUNCTION 

PRIVATE FUNCTION i400_b_dzdd_b_to()
    LET g_dzdd_b[l_ac_dzdd_b].dzdd002 = b_dzdd_b.dzdd002
    LET g_dzdd_b[l_ac_dzdd_b].dzdd004 = b_dzdd_b.dzdd004

    LET g_dzdi003 = s_chr_trim(g_dzda.dzda001),',',s_chr_trim(g_dzdd_b[l_ac_dzdd_b].dzdd002),',',s_chr_trim(g_dzdd_b[l_ac_dzdd_b].dzdd004)
    LET g_dzdd_b[l_ac_dzdd_b].dzdd004_desc = sadz_get_name("dzdd_t","dzdd004",g_dzdi003)

END FUNCTION

PRIVATE FUNCTION i400_b_dzdd_b_back()
    LET b_dzdd_b.dzdd001 = g_dzda.dzda001
    LET b_dzdd_b.dzdd007 = 'B'
    LET b_dzdd_b.dzdd002 = g_dzdd_b[l_ac_dzdd_b].dzdd002
    LET b_dzdd_b.dzdd004 = g_dzdd_b[l_ac_dzdd_b].dzdd004
END FUNCTION

PRIVATE FUNCTION i400_b_dzdd_a_to()
    LET g_dzdd_a[l_ac_dzdd_a].dzdd002 = b_dzdd_a.dzdd002
    LET g_dzdd_a[l_ac_dzdd_a].dzdd004 = b_dzdd_a.dzdd004

    LET g_dzdi003 = s_chr_trim(g_dzda.dzda001),',',s_chr_trim(g_dzdd_a[l_ac_dzdd_a].dzdd002),',',s_chr_trim(g_dzdd_a[l_ac_dzdd_a].dzdd004)
    LET g_dzdd_a[l_ac_dzdd_a].dzdd004_desc = sadz_get_name("dzdd_t","dzdd004",g_dzdi003)
END FUNCTION

PRIVATE FUNCTION i400_b_dzdd_a_back()
    LET b_dzdd_a.dzdd001 = g_dzda.dzda001
    LET b_dzdd_b.dzdd007 = 'A'
    LET b_dzdd_a.dzdd002 = g_dzdd_a[l_ac_dzdd_a].dzdd002
    LET b_dzdd_a.dzdd004 = g_dzdd_a[l_ac_dzdd_a].dzdd004
END FUNCTION

FUNCTION i400_b_dzdh_to()
    LET g_dzdh[l_ac_dzdh].dzdh001 = b_dzdh.dzdh001
    LET g_dzdh[l_ac_dzdh].dzdh002 = b_dzdh.dzdh002

    LET g_dzdi003 = s_chr_trim(g_dzdh[l_ac_dzdh].dzdh001)
    LET g_dzdh[l_ac_dzdh].dzdh001_desc = sadz_get_name("dzdg_t","dzdg001",g_dzdi003)

    LET g_dzdi003 = s_chr_trim(g_dzdh[l_ac_dzdh].dzdh001),',',s_chr_trim(g_dzdh[l_ac_dzdh].dzdh002)
    LET g_dzdh[l_ac_dzdh].dzdh002_desc = sadz_get_name("dzdg_t","dzdg002",g_dzdi003)
END FUNCTION

FUNCTION i400_b_dzdh_back()
    LET b_dzdh.dzdh001 = g_dzdh[l_ac_dzdh].dzdh001
    LET b_dzdh.dzdh002 = g_dzdh[l_ac_dzdh].dzdh002
    LET b_dzdh.dzdh003 = g_dzda.dzda001
END FUNCTION

FUNCTION i400_init_dzda()
    LET g_dzda.dzda005 = '0'
    LET g_dzda.dzda010 = 'N'
    LET g_dzda.dzda011 = 'N'
    LET g_dzda.dzdacrtid= g_user
    LET g_dzda.dzdacrtdp= g_dept
    LET g_dzda.dzdaownid= g_user
    LET g_dzda.dzdaowndp= g_dept
    LET g_dzda.dzdacrtdt= g_today
    LET g_dzda.dzdastus= 'N'
END FUNCTION 

FUNCTION i400_get_dzdb_p(p_dzdb001)
DEFINE   p_dzdb001          LIKE dzdb_t.dzdb001
DEFINE   l_cnt                LIKE type_t.num5

    IF cl_null(p_dzdb001) THEN 
       RETURN
    END IF 
     
    CALL g_dzdb_p.clear()
    
    LET g_sql = "SELECT dzdb003,dzdb005,'',dzdb007 ",
                "  FROM dzdb_t ",
                " WHERE dzdb001 = '",p_dzdb001 CLIPPED,"'",
                "   AND dzdb002 = 'P' ",
               #"   AND ",g_wc_dzdb_p CLIPPED,
                " ORDER BY dzdb003"
    PREPARE i400_dzdb_p_prep FROM g_sql
    DECLARE i400_dzdb_p_curs CURSOR FOR i400_dzdb_p_prep
    LET g_rec_b_dzdb_p = 0
    LET l_cnt = 1
    FOREACH i400_dzdb_p_curs INTO g_dzdb_p[l_cnt].*
       LET g_dzdi003 = s_chr_trim(p_dzdb001),',','P',',',s_chr_trim(g_dzdb_p[l_cnt].dzdb003),',',s_chr_trim(g_dzdb_p[l_cnt].dzdb005)
       LET g_dzdb_p[l_cnt].dzdb005_desc = sadz_get_name("dzdb_t","dzdb005",g_dzdi003)

       LET g_rec_b_dzdb_p = g_rec_b_dzdb_p + 1
       LET l_cnt = l_cnt + 1 
       IF l_cnt > g_max_rec THEN 
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = '9035'
          LET g_errparam.extend = ''
          LET g_errparam.popup = FALSE
          CALL cl_err()
          EXIT FOREACH 
       END IF 
    END FOREACH 
    CALL g_dzdb_p.deleteElement(l_cnt)
    
END FUNCTION 

FUNCTION i400_get_dzdb_r(p_dzdb001)
DEFINE   p_dzdb001          LIKE dzdb_t.dzdb001
DEFINE   l_cnt                LIKE type_t.num5

    IF cl_null(p_dzdb001) THEN
       RETURN
    END IF

    CALL g_dzdb_r.clear()

    LET g_sql = "SELECT dzdb003,dzdb005,'',dzdb007 ",
                "  FROM dzdb_t ",
                " WHERE dzdb001 = '",p_dzdb001 CLIPPED,"'",
                "   AND dzdb002 = 'R' ",
               #"   AND ",g_wc_dzdb_r CLIPPED,
                " ORDER BY dzdb003"
    PREPARE i400_dzdb_r_prep FROM g_sql
    DECLARE i400_dzdb_r_curs CURSOR FOR i400_dzdb_r_prep
    LET g_rec_b_dzdb_r = 0
    LET l_cnt = 1
    FOREACH i400_dzdb_r_curs INTO g_dzdb_r[l_cnt].*
       LET g_dzdi003 = s_chr_trim(p_dzdb001),',','R',',',s_chr_trim(g_dzdb_r[l_cnt].dzdb003),',',s_chr_trim(g_dzdb_r[l_cnt].dzdb005)
       LET g_dzdb_r[l_cnt].dzdb005_desc = sadz_get_name("dzdb_t","dzdb005",g_dzdi003)

       LET g_rec_b_dzdb_r = g_rec_b_dzdb_r + 1
       LET l_cnt = l_cnt + 1
       IF l_cnt > g_max_rec THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = '9035'
          LET g_errparam.extend = ''
          LET g_errparam.popup = FALSE
          CALL cl_err()
          EXIT FOREACH
       END IF
    END FOREACH
    CALL g_dzdb_r.deleteElement(l_cnt)

END FUNCTION

FUNCTION i400_get_dzdc(p_dzdc001)
DEFINE   p_dzdc001          LIKE dzdc_t.dzdc001
DEFINE   l_cnt                LIKE type_t.num5

    IF cl_null(p_dzdc001) THEN 
       RETURN 
    END IF 

    CALL g_dzdc.clear()
    
    LET g_sql = "SELECT dzdc002,'' ",
                "  FROM dzdc_t ",
                " WHERE dzdc001 = '",p_dzdc001 CLIPPED,"'",
               #"   AND ",g_wc_dzdc CLIPPED,
                " ORDER BY dzdc002"
    PREPARE i400_dzdc_prep FROM g_sql
    DECLARE i400_dzdc_curs CURSOR FOR i400_dzdc_prep
    LET g_rec_b_dzdc = 0
    LET l_cnt = 1
    FOREACH i400_dzdc_curs INTO g_dzdc[l_cnt].*
       LET g_dzdi003 = s_chr_trim(p_dzdc001),',',s_chr_trim(g_dzdc[l_cnt].dzdc002)
       LET g_dzdc[l_cnt].dzdc002_desc = sadz_get_name("dzdc_t","dzdc002",g_dzdi003)

       LET g_rec_b_dzdc = g_rec_b_dzdc + 1
       LET l_cnt = l_cnt + 1
       IF l_cnt > g_max_rec THEN 
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = '9035'
          LET g_errparam.extend = ''
          LET g_errparam.popup = FALSE
          CALL cl_err()
          EXIT FOREACH 
       END IF 
    END FOREACH 
    CALL g_dzdc.deleteElement(l_cnt)
END FUNCTION 

PRIVATE FUNCTION i400_get_dzdd_b(p_dzdd001)
DEFINE   p_dzdd001            LIKE dzdd_t.dzdd001
DEFINE   l_cnt                LIKE type_t.num5

    IF cl_null(p_dzdd001) THEN
       RETURN
    END IF

    CALL g_dzdd_b.clear()

    LET g_sql = "SELECT dzdd002,dzdd004,'' ",
                "  FROM dzdd_t ",
                " WHERE dzdd001 = '",p_dzdd001 CLIPPED,"'",
                "   AND dzdd007 = 'B' ",
               #"   AND ",g_wc_dzdd_b CLIPPED,
                " ORDER BY dzdd002"
    PREPARE i400_dzdd_b_prep FROM g_sql
    DECLARE i400_dzdd_b_curs CURSOR FOR i400_dzdd_b_prep
    LET g_rec_b_dzdd_b = 0
    LET l_cnt = 1
    FOREACH i400_dzdd_b_curs INTO g_dzdd_b[l_cnt].*
       LET g_dzdi003 = s_chr_trim(p_dzdd001),',',s_chr_trim(g_dzdd_b[l_cnt].dzdd002),',',s_chr_trim(g_dzdd_b[l_cnt].dzdd004)
       LET g_dzdd_b[l_cnt].dzdd004_desc = sadz_get_name("dzdd_t","dzdd004",g_dzdi003)

       LET g_rec_b_dzdd_b = g_rec_b_dzdd_b + 1
       LET l_cnt = l_cnt + 1
       IF l_cnt > g_max_rec THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = '9035'
          LET g_errparam.extend = ''
          LET g_errparam.popup = FALSE
          CALL cl_err()
          EXIT FOREACH
       END IF
    END FOREACH
    CALL g_dzdd_b.deleteElement(l_cnt)
END FUNCTION

PRIVATE FUNCTION i400_get_dzdd_a(p_dzdd001)
DEFINE   p_dzdd001            LIKE dzdd_t.dzdd001
DEFINE   l_cnt                LIKE type_t.num5

    IF cl_null(p_dzdd001) THEN
       RETURN
    END IF

    CALL g_dzdd_a.clear()

    LET g_sql = "SELECT dzdd002,dzdd004,'' ",
                "  FROM dzdd_t ",
                " WHERE dzdd001 = '",p_dzdd001 CLIPPED,"'",
                "   AND dzdd007 = 'A' ",
               #"   AND ",g_wc_dzdd_a CLIPPED,
                " ORDER BY dzdd002"
    PREPARE i400_dzdd_a_prep FROM g_sql
    DECLARE i400_dzdd_a_curs CURSOR FOR i400_dzdd_a_prep
    LET g_rec_b_dzdd_a = 0
    LET l_cnt = 1
    FOREACH i400_dzdd_a_curs INTO g_dzdd_a[l_cnt].*
       LET g_dzdi003 = s_chr_trim(p_dzdd001),',',s_chr_trim(g_dzdd_a[l_cnt].dzdd002),',',s_chr_trim(g_dzdd_a[l_cnt].dzdd004)
       LET g_dzdd_a[l_cnt].dzdd004_desc = sadz_get_name("dzdd_t","dzdd004",g_dzdi003)

       LET g_rec_b_dzdd_a = g_rec_b_dzdd_a + 1
       LET l_cnt = l_cnt + 1
       IF l_cnt > g_max_rec THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = '9035'
          LET g_errparam.extend = ''
          LET g_errparam.popup = FALSE
          CALL cl_err()
          EXIT FOREACH
       END IF
    END FOREACH
    CALL g_dzdd_a.deleteElement(l_cnt)
END FUNCTION

FUNCTION i400_get_dzdh(p_dzdh003)
DEFINE   p_dzdh003            LIKE dzdh_t.dzdh003
DEFINE   l_cnt                LIKE type_t.num5

    IF cl_null(p_dzdh003) THEN
       RETURN
    END IF

    CALL g_dzdh.clear()

    LET g_sql = "SELECT dzdh001,'',dzdh002,'' ",
                "  FROM dzdh_t ",
                " WHERE dzdh003 = '",p_dzdh003 CLIPPED,"'",
               #"   AND ",g_wc_dzdh CLIPPED,
                " ORDER BY dzdh001,dzdh002"
    PREPARE i400_dzdh_prep FROM g_sql
    DECLARE i400_dzdh_curs CURSOR FOR i400_dzdh_prep
    LET g_rec_b_dzdh = 0
    LET l_cnt = 1
    FOREACH i400_dzdh_curs INTO g_dzdh[l_cnt].*
       LET g_dzdi003 = s_chr_trim(g_dzdh[l_cnt].dzdh001)
       LET g_dzdh[l_cnt].dzdh001_desc = sadz_get_name("dzdg_t","dzdg001",g_dzdi003)
   
       LET g_dzdi003 = s_chr_trim(g_dzdh[l_cnt].dzdh001),',',s_chr_trim(g_dzdh[l_cnt].dzdh002)
       LET g_dzdh[l_cnt].dzdh002_desc = sadz_get_name("dzdg_t","dzdg002",g_dzdi003)
   
       LET g_rec_b_dzdh = g_rec_b_dzdh + 1
       LET l_cnt = l_cnt + 1
       IF l_cnt > g_max_rec THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = '9035'
          LET g_errparam.extend = ''
          LET g_errparam.popup = FALSE
          CALL cl_err()
          EXIT FOREACH
       END IF
    END FOREACH
    CALL g_dzdh.deleteElement(l_cnt)
END FUNCTION

FUNCTION i400_set_entry(p_cmd)                                                  
  DEFINE p_cmd   LIKE type_t.chr1  
                                     
   IF p_cmd = 'a' THEN                          
     CALL cl_set_comp_entry("dzda001,dzda002",TRUE)    
   END IF                 
END FUNCTION
                  
FUNCTION i400_set_no_entry(p_cmd)  
DEFINE p_cmd   LIKE type_t.chr1      
DEFINE l_cnt   LIKE type_t.num5
                              
   IF p_cmd = 'u' AND g_chkey='N' THEN     
     CALL cl_set_comp_entry("dzda001,dzda002",FALSE)  
   END IF 
END FUNCTION                                                                    

FUNCTION adzi400_delete()

    MESSAGE ''

    IF cl_null(g_dzda.dzda001) THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = '-400'
       LET g_errparam.extend = ''
       LET g_errparam.popup = FALSE
       CALL cl_err()
       RETURN
    END IF
    IF g_dzda.dzdastus='Y' THEN
       ERROR "已审核,不可删除"
       RETURN
    END IF

    CALL s_transaction_begin()

    OPEN i400_cl USING g_dzda_rowid
    IF SQLCA.sqlcode THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = SQLCA.sqlcode
       LET g_errparam.extend = "OPEN i400_cl:"
       LET g_errparam.popup = TRUE
       CALL cl_err()
       CLOSE i400_cl
       CALL s_transaction_end('N',0)
       RETURN
    END IF

    FETCH i400_cl INTO g_dzda.*               # 對DB鎖定
    IF SQLCA.sqlcode THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = SQLCA.sqlcode
       LET g_errparam.extend = 'lock dzda:'
       LET g_errparam.popup = FALSE
       CALL cl_err()
       CLOSE i400_cl
       CALL s_transaction_end('N',0)
       RETURN
    END IF

    CALL adzi400_show()

    IF cl_ask_delete() THEN
       DELETE FROM dzda_t WHERE ROWID=g_dzda_rowid
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "del dzda:"
          LET g_errparam.popup = TRUE
          CALL cl_err()
          CALL s_transaction_end('N',0)
          RETURN 
       END IF

       DELETE FROM dzdb_t WHERE dzdb001 = g_dzda.dzda001
       IF SQLCA.sqlcode THEN 
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "del dzdb:"
          LET g_errparam.popup = TRUE
          CALL cl_err()
          CALL s_transaction_end('N',0)
          RETURN
       END IF 

       DELETE FROM dzdc_t WHERE dzdc001 = g_dzda.dzda001
       IF SQLCA.sqlcode THEN 
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "del dzdc:"
          LET g_errparam.popup = TRUE
          CALL cl_err()
          CALL s_transaction_end('N',0)
          RETURN
       END IF 

       DELETE FROM dzdd_t WHERE dzdd001 = g_dzda.dzda001 
       IF SQLCA.sqlcode THEN 
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "del dzdd:"
          LET g_errparam.popup = TRUE
          CALL cl_err()
          CALL s_transaction_end('N',0)
          RETURN
       END IF 

       DELETE FROM dzdh_t WHERE dzdh003 = g_dzda.dzda001
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "del dzdh:"
          LET g_errparam.popup = TRUE
          CALL cl_err()
          CALL s_transaction_end('N',0)
          RETURN
       END IF

       INITIALIZE g_dzda.* TO NULL
       CLEAR FORM
       CALL g_dzdb_p.clear()
       CALL g_dzdb_r.clear()
       CALL g_dzdc.clear()
       CALL g_dzdd_b.clear()
       CALL g_dzdd_a.clear()
       CALL g_dzdh.clear()
       OPEN i400_count_curs
       FETCH i400_count_curs INTO g_row_count
       CLOSE i400_count_curs
       DISPLAY g_row_count TO FORMONLY.cnt
       OPEN i400_data_curs
        IF g_curs_index = g_row_count + 1 THEN
           LET g_jump = g_row_count
           CALL i400_fetch('L')
        ELSE
           LET g_jump = g_curs_index
           LET mi_no_ask = TRUE
           CALL i400_fetch('/')
        END IF

    END IF
    CLOSE i400_cl
    CALL s_transaction_end('Y',0)

END FUNCTION

FUNCTION adzi400_reproduce()
DEFINE l_dzda001       LIKE dzda_t.dzda001

    MESSAGE ''

   #IF s_shut(0) THEN RETURN END IF
    IF cl_null(g_dzda.dzda001) THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = '-400'
       LET g_errparam.extend = ''
       LET g_errparam.popup = TRUE
       CALL cl_err()
       RETURN
    END IF

    CALL s_transaction_begin()

WHILE TRUE
    CALL cl_set_head_visible("","YES")
    CALL cl_set_comp_entry('dzda001',TRUE)
    INPUT l_dzda001 WITHOUT DEFAULTS FROM dzda001
       #BEFORE INPUT
       #ON IDLE g_idle_seconds
       #   CALL cl_on_idle()
       #   CONTINUE INPUT

        ON ACTION about         #MOD-4C0121
           CALL cl_about()      #MOD-4C0121
  
        #ON ACTION help          #MOD-4C0121
        #   CALL cl_show_help()  #MOD-4C0121
  
        ON ACTION controlg      #MOD-4C0121
           CALL cl_cmdask()     #MOD-4C0121

    END INPUT
    IF INT_FLAG THEN
       DISPLAY g_dzda.dzda001 TO dzda001
       RETURN
    END IF

    EXIT WHILE
END WHILE
    IF INT_FLAG THEN
       LET INT_FLAG=0
       CALL s_transaction_end('N',0)
       RETURN
    END IF

   #IF NOT cl_sure(0,0) THEN
   #   CALL s_transaction_end('N',0)
   #   RETURN
   #END IF

    DROP TABLE x
    SELECT * FROM dzda_t
        WHERE ROWID=g_dzda_rowid
        INTO TEMP x
    UPDATE x
       SET dzda001 = l_dzda001,   #資料鍵值
           dzda010 = 'N',
           dzda011 = 'N',
           dzdastus= 'N',
           dzdacrtid= g_user,
           dzdacrtdp= g_dept,
           dzdaownid= g_user,
           dzdaowndp= g_dept,
           dzdamodid= '',
           dzdamoddt= '',
           dzdacrtdt= g_today

    INSERT INTO dzda_t
        SELECT * FROM x
    IF SQLCA.SQLCODE THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = SQLCA.sqlcode
       LET g_errparam.extend = "ins dzda:"
       LET g_errparam.popup = TRUE
       CALL cl_err()
       CALL s_transaction_end('N',0)
       RETURN
    END IF

    DROP TABLE x
    SELECT * FROM dzdb_t
     WHERE dzdb001=g_dzda.dzda001
      INTO TEMP x
    UPDATE x
       SET dzdb001=l_dzda001,   #資料鍵值
           dzdbstus= 'Y',
           dzdbcrtid= g_user,
           dzdbcrtdp= g_dept,
           dzdbownid= g_user,
           dzdbowndp= g_dept,
           dzdbmodid= '',
           dzdbmoddt= '',
           dzdbcrtdt= g_today
    INSERT INTO dzdb_t SELECT * FROM x
    IF SQLCA.SQLCODE THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = SQLCA.sqlcode
       LET g_errparam.extend = "ins dzdb:"
       LET g_errparam.popup = TRUE
       CALL cl_err()
       CALL s_transaction_end('N',0)
       RETURN
    END IF

    DROP TABLE x
    SELECT * FROM dzdc_t
     WHERE dzdc001=g_dzda.dzda001
      INTO TEMP x
    UPDATE x
       SET dzdc001=l_dzda001,    #資料鍵值
           dzdcstus= 'Y',
           dzdccrtid= g_user,
           dzdccrtdp= g_dept,
           dzdcownid= g_user,
           dzdcowndp= g_dept,
           dzdcmodid= '',
           dzdcmoddt= '',
           dzdccrtdt= g_today
    INSERT INTO dzdc_t SELECT * FROM x
    IF SQLCA.SQLCODE THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = SQLCA.sqlcode
       LET g_errparam.extend = "ins dzdc:"
       LET g_errparam.popup = TRUE
       CALL cl_err()
       CALL s_transaction_end('N',0)
       RETURN
    END IF

    DROP TABLE x
    SELECT * FROM dzdd_t
     WHERE dzdd001=g_dzda.dzda001
      INTO TEMP x
    UPDATE x
       SET dzdd001=l_dzda001,    #資料鍵值
           dzddstus= 'Y',
           dzddcrtid= g_user,
           dzddcrtdp= g_dept,
           dzddownid= g_user,
           dzddowndp= g_dept,
           dzddmodid= '',
           dzddmoddt= '',
           dzddcrtdt= g_today
    INSERT INTO dzdd_t SELECT * FROM x
    IF SQLCA.SQLCODE THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = SQLCA.sqlcode
       LET g_errparam.extend = "ins dzdd:"
       LET g_errparam.popup = TRUE
       CALL cl_err()
       CALL s_transaction_end('N',0)
       RETURN
    END IF

    DROP TABLE x
    SELECT * FROM dzdh_t
     WHERE dzdh003=g_dzda.dzda001
      INTO TEMP x
    UPDATE x
       SET dzdh003=l_dzda001,    #資料鍵值
           dzdhcrtid= g_user,
           dzdhcrtdp= g_dept,
           dzdhownid= g_user,
           dzdhowndp= g_dept,
           dzdhmodid= '',
           dzdhmoddt= '',
           dzdhcrtdt= g_today
    INSERT INTO dzdh_t SELECT * FROM x
    IF SQLCA.SQLCODE THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = SQLCA.sqlcode
       LET g_errparam.extend = "ins dzdh:"
       LET g_errparam.popup = TRUE
       CALL cl_err()
       CALL s_transaction_end('N',0)
       RETURN
    END IF

    CALL s_transaction_end('Y',0)

   #CALL cl_msg("Copy Ok!")
    MESSAGE 'Copy Ok!'
    SELECT ROWID,dzda_t.* INTO g_dzda_rowid,g_dzda.* FROM dzda_t WHERE dzda001=l_dzda001
    CALL adzi400_show() 
    CALL adzi400_modify()

END FUNCTION

FUNCTION adzi400_confirm()
DEFINE l_cnt1      LIKE type_t.num5
DEFINE l_cnt2      LIKE type_t.num5
DEFINE l_cnt3      LIKE type_t.num5
DEFINE l_cnt4      LIKE type_t.num5

    MESSAGE ''

    IF cl_null(g_dzda.dzda001) THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = ''
       LET g_errparam.extend = '-400'
       LET g_errparam.popup = TRUE
       CALL cl_err()
       RETURN
    END IF

    IF g_dzda.dzdastus = 'Y' THEN
       MESSAGE "已审核，无需重复审核"
      #CALL cl_err(g_dzda.dzdastus,-400,0)
       RETURN
    END IF

    CALL s_transaction_begin()

    OPEN i400_cl USING g_dzda_rowid
    IF SQLCA.sqlcode THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = SQLCA.sqlcode
       LET g_errparam.extend = "OPEN i400_cl:"
       LET g_errparam.popup = TRUE
       CALL cl_err()
       CLOSE i400_cl
       CALL s_transaction_end('N',0)
       RETURN
    END IF

    FETCH i400_cl INTO g_dzda.*               # 對DB鎖定
    IF SQLCA.sqlcode THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = SQLCA.sqlcode
       LET g_errparam.extend = "lock dzda:"
       LET g_errparam.popup = FALSE
       CALL cl_err()
       CLOSE i400_cl
       CALL s_transaction_end('N',0)
       RETURN
    END IF

    #标准产品的元件，如果维度1~4有一项没有资料，则审核失败
    IF g_dzda.dzda001[LENGTH(g_dzda.dzda001)-1,LENGTH(g_dzda.dzda001)] != 'uc' THEN
       SELECT COUNT(*) INTO l_cnt1 FROM dzdh_t
        WHERE dzdh003 = g_dzda.dzda001
          AND dzdh001 = 1
       SELECT COUNT(*) INTO l_cnt2 FROM dzdh_t
        WHERE dzdh003 = g_dzda.dzda001
          AND dzdh001 = 2
       SELECT COUNT(*) INTO l_cnt3 FROM dzdh_t
        WHERE dzdh003 = g_dzda.dzda001
          AND dzdh001 = 3
       SELECT COUNT(*) INTO l_cnt4 FROM dzdh_t
        WHERE dzdh003 = g_dzda.dzda001
          AND dzdh001 = 4
       IF l_cnt1=0 OR l_cnt2=0 OR l_cnt3=0 OR l_cnt4=0 THEN
          MESSAGE "需维护维度资料"
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = ""
          LET g_errparam.extend = ""
          LET g_errparam.popup = FALSE
          CALL cl_err()
          CLOSE i400_cl
          CALL s_transaction_end('N',0)
          RETURN
       END IF
    END IF

    IF NOT cl_ask_confirm('lib-014') THEN
       CLOSE i400_cl
       CALL s_transaction_end('N',0)
       RETURN
    END IF

    #更新状态
    UPDATE dzda_t SET dzdastus = 'Y'
     WHERE dzda001 = g_dzda.dzda001
    IF SQLCA.sqlcode OR sqlca.sqlerrd[3]=0 THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = SQLCA.sqlcode
       LET g_errparam.extend = 'upmoddt dzdastus'
       LET g_errparam.popup = FALSE
       CALL cl_err()
       CLOSE i400_cl
       CALL s_transaction_end('N',0)
       RETURN
    END IF

    CLOSE i400_cl
    CALL s_transaction_end('Y',0)

    LET g_dzda.dzdastus = 'Y'
    DISPLAY BY NAME g_dzda.dzdastus
END FUNCTION

FUNCTION adzi400_unconfirm()

    MESSAGE ''

    IF cl_null(g_dzda.dzda001) THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = '-400'
       LET g_errparam.extend = ''
       LET g_errparam.popup = FALSE
       CALL cl_err()
       RETURN
    END IF

    IF g_dzda.dzdastus = 'N' THEN
       MESSAGE "未审核，无需取消审核"
       RETURN
    END IF

    CALL s_transaction_begin()

    OPEN i400_cl USING g_dzda_rowid
    IF SQLCA.sqlcode THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = SQLCA.sqlcode
       LET g_errparam.extend = "OPEN i400_cl:"
       LET g_errparam.popup = TRUE
       CALL cl_err()
       CLOSE i400_cl
       CALL s_transaction_end('N',0)
       RETURN
    END IF

    FETCH i400_cl INTO g_dzda.*               # 對DB鎖定
    IF SQLCA.sqlcode THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = SQLCA.sqlcode
       LET g_errparam.extend = 'lock dzda:'
       LET g_errparam.popup = FALSE
       CALL cl_err()
       CLOSE i400_cl
       CALL s_transaction_end('N',0)
       RETURN
    END IF

    IF NOT cl_ask_confirm('lib-015') THEN
       CLOSE i400_cl
       CALL s_transaction_end('N',0)
       RETURN
    END IF

    #更新状态
    UPDATE dzda_t SET dzdastus = 'N'
     WHERE dzda001 = g_dzda.dzda001
    IF SQLCA.sqlcode OR sqlca.sqlerrd[3]=0 THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = SQLCA.sqlcode
       LET g_errparam.extend = 'upmoddt dzdastus'
       LET g_errparam.popup = FALSE
       CALL cl_err()
       CLOSE i400_cl
       CALL s_transaction_end('N',0)
       RETURN
    END IF

    CLOSE i400_cl
    CALL s_transaction_end('Y',0)

    LET g_dzda.dzdastus = 'N'
    DISPLAY BY NAME g_dzda.dzdastus

END FUNCTION

FUNCTION adzi400_init()

   CALL cl_set_combo_scc_part('dzdastus','13','N,X,Y')
END FUNCTION
