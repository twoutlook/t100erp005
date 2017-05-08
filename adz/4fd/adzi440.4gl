# Prog. Version..: '5.10.06-09.02.11(00009)'     #
# Pattern name...: adzi440.4gl
# Descriptions...: 元资测试作业
# Date & Author..: 12/10/22 By zhangllc
#

SCHEMA ds

GLOBALS "../../cfg/top_global.inc"

GLOBALS
DEFINE  g_dzda       RECORD
          dzda001    LIKE dzda_t.dzda001,  #元件代号
          dzda002    LIKE dzda_t.dzda002,  #版本
          dzda003    LIKE dzda_t.dzda003,  #语言别
          dzda004    LIKE dzda_t.dzda004,  #说明
          pre        LIKE type_t.chr1,     #是否存在前置元件
          work       LIKE type_t.chr1,     #测试条件：添加事务 Y/N
          test       LIKE type_t.chr1      #测试方法: 1.r,r  2.r.d
                       END RECORD
DEFINE  g_dzdb_p     DYNAMIC ARRAY OF RECORD
          dzdb003    LIKE dzdb_t.dzdb003,  #顺序
          dzdb005    LIKE dzdb_t.dzdb005,  #参数
          dzdb006    LIKE dzdb_t.dzdb006,  #说明
          dzdb007    LIKE dzdb_t.dzdb007,  #参数类型
          val_p      LIKE type_t.chr1000   #值
                       END RECORD
DEFINE  g_dzdb_p_t   RECORD
          dzdb003    LIKE dzdb_t.dzdb003,  #顺序
          dzdb005    LIKE dzdb_t.dzdb005,  #参数
          dzdb006    LIKE dzdb_t.dzdb006,  #说明
          dzdb007    LIKE dzdb_t.dzdb007,  #参数类型
          val_p      LIKE type_t.chr1000   #值
                       END RECORD
DEFINE  g_dzdb_r     DYNAMIC ARRAY OF RECORD
          dzdb003    LIKE dzdb_t.dzdb003,  #顺序
          dzdb005    LIKE dzdb_t.dzdb005,  #参数
          dzdb006    LIKE dzdb_t.dzdb006,  #说明
          dzdb007    LIKE dzdb_t.dzdb007,  #参数类型
          val_r      LIKE type_t.chr1000   #值
                       END RECORD
DEFINE  g_dzdb_r_t   RECORD
          dzdb003    LIKE dzdb_t.dzdb003,  #顺序
          dzdb005    LIKE dzdb_t.dzdb005,  #参数
          dzdb006    LIKE dzdb_t.dzdb006,  #说明
          dzdb007    LIKE dzdb_t.dzdb007,  #参数类型
          val_r      LIKE type_t.chr1000   #值
                       END RECORD
DEFINE  g_dzdd       DYNAMIC ARRAY OF RECORD
          dzdd002    LIKE dzdd_t.dzdd002,  #序号
          dzdd004    LIKE dzdd_t.dzdd004,  #前置元件
          dzdd005    LIKE dzdd_t.dzdd005,  #说明
          flag       LIKE dzdb_t.dzdb002,  #传参方向
          seq        LIKE dzdb_t.dzdb003,  #顺序
          para       LIKE dzdb_t.dzdb005,  #参数
          exp        LIKE dzdb_t.dzdb006,  #说明
          type       LIKE dzdb_t.dzdb007,  #类型
          val        LIKE type_t.chr1000   #值
                       END RECORD                       
DEFINE  g_dzdd_t     RECORD
          dzdd002    LIKE dzdd_t.dzdd002,  #序号
          dzdd004    LIKE dzdd_t.dzdd004,  #前置元件
          dzdd005    LIKE dzdd_t.dzdd005,  #说明
          flag       LIKE dzdb_t.dzdb002,  #传参方向
          seq        LIKE dzdb_t.dzdb003,  #顺序
          para       LIKE dzdb_t.dzdb005,  #参数
          exp        LIKE dzdb_t.dzdb006,  #说明
          type       LIKE dzdb_t.dzdb007,  #类型
          val        LIKE type_t.chr1000   #值
                       END RECORD  
DEFINE  g_cnt           LIKE type_t.num5           
DEFINE  g_flag          LIKE type_t.chr1            
DEFINE  g_row_count     LIKE type_t.num10
DEFINE  g_curs_index    LIKE type_t.num10   
DEFINE  g_jump          LIKE type_t.num10
DEFINE  mi_no_ask       LIKE type_t.num5 
DEFINE  g_wc            STRING                        
DEFINE  g_forupd_sql    STRING 
DEFINE  g_sql           STRING        
DEFINE  g_msg           STRING                
DEFINE  g_chr           STRING
DEFINE  g_cmd           STRING
DEFINE  g_4gl_name      LIKE type_t.chr100  #动态4gl名称
DEFINE  g_rec_b_dzdb_p  LIKE type_t.num5     
DEFINE  g_rec_b_dzdb_r  LIKE type_t.num5     
DEFINE  g_rec_b_dzdd    LIKE type_t.num5   
DEFINE  b_dzdb_p        RECORD LIKE dzdb_t.*
DEFINE  b_dzdb_r        RECORD LIKE dzdb_t.*
DEFINE  b_dzdd          RECORD LIKE dzdd_t.*
END GLOBALS


MAIN
   DEFINE p_row,p_col   LIKE type_t.num5    

   OPTIONS                                #改變一些系統預設值
      FORM LINE       FIRST + 2,         #畫面開始的位置
      MESSAGE LINE    LAST,              #訊息顯示的位置
      PROMPT LINE     LAST,              #提示訊息的位置
      INPUT NO WRAP                      #輸入的方式: 不打轉
  #DEFER INTERRUPT                        #擷取中斷鍵, 由程式處理

   WHENEVER ERROR CALL cl_err_msg_log
  
   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("adz","N")


   #畫面開啟 (identifier)
   OPEN WINDOW w_adzi440 WITH FORM cl_ap_formpath("adz",g_prog)
   CALL cl_ui_init()

   
   CALL adzi440_menu()
   CLOSE WINDOW w_adzi440
  #CALL cl_used(g_prog,g_time,2) RETURNING g_time   #計算使用時間 (退出使間)
         
END MAIN

FUNCTION i440_curs()

    CLEAR FORM 
    
    INITIALIZE g_dzda.* TO NULL 
    CALL g_dzdb_p.clear()
    CALL g_dzdb_r.clear()
    CALL g_dzdd.clear()
    LET g_rec_b_dzdb_p= 0
    LET g_rec_b_dzdb_r= 0
    LET g_rec_b_dzdd  = 0
    LET g_wc       = ''
    LET g_sql       = ''
    
    DIALOG ATTRIBUTES(UNBUFFERED)
    
      CONSTRUCT BY NAME g_wc ON 
        dzda001,dzda004,dzda002
        
       #ON ACTION CONTROLP
       #   CASE 
       #       WHEN INFIELD(dzda001)
       #         CALL cl_init_qry_var()
       #         LET g_qryparam.state = 'c'
       #         LET g_qryparam.form  = 'cq_dzda010'
       #         LET g_qryparam.default1 = g_dzda.dzda010
       #         CALL cl_create_qry() RETURNING g_qryparam.multiret
       #         DISPLAY g_qryparam.multiret TO dzda010
       #   END CASE 
          
        ON IDLE g_idle_seconds
           CALL cl_on_idle()
           CONTINUE DIALOG
    
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
         
      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE DIALOG
            
    END DIALOG
    IF INT_FLAG THEN RETURN END IF 
    
    LET g_sql = "SELECT dzda001,dzda002,dzda003,dzda004 FROM dzda_t ",
                " WHERE ",g_wc,
                "   AND dzda003 = '",g_lang,"'"
    PREPARE i440_data_prep FROM g_sql
    IF SQLCA.sqlcode THEN 
       CALL cl_err("i440_data_prep:",SQLCA.sqlcode,1)
       LET INT_FLAG = 1
       RETURN 
    END IF 
    DECLARE i440_data_curs SCROLL CURSOR WITH HOLD FOR i440_data_prep
    IF SQLCA.sqlcode THEN 
       CALL cl_err("i440_data_curs",SQLCA.sqlcode,1)
       LET INT_FLAG = 1
       RETURN 
    END IF 
    
    LET g_sql = "SELECT COUNT(*) FROM dzda_t ",
                " WHERE ",g_wc,
                "   AND dzda003 = '",g_lang,"'"
    PREPARE i440_count_prep FROM g_sql
    IF SQLCA.sqlcode THEN 
       CALL cl_err("i440_count_prep",SQLCA.sqlcode,1)
       LET INT_FLAG = 1
       RETURN 
    END IF 
    DECLARE i440_count_curs CURSOR FOR i440_count_prep
    IF SQLCA.sqlcode THEN 
       CALL cl_err("i440_count_curs",SQLCA.sqlcode,1)
       LET INT_FLAG = 1
       RETURN 
    END IF 
END FUNCTION 

FUNCTION adzi440_menu()
DEFINE li_wc    LIKE type_t.chr200

   WHILE TRUE
      CALL adzi440_bp("G")
      CASE g_action_choice
         WHEN "query" 
            IF cl_chk_act_auth() THEN
               CALL adzi440_query()
            END IF
         WHEN "test" 
            IF cl_chk_act_auth() THEN
               CALL adzi440_test()
            ELSE
               LET g_action_choice = NULL
            END IF
                  
         WHEN "help"
            CALL cl_show_help()
         WHEN "exit"
            EXIT WHILE
         WHEN "controlg"
            CALL cl_cmdask()
      END CASE
   END WHILE

END FUNCTION

FUNCTION adzi440_query()

    LET g_row_count = 0
    LET g_curs_index= 0
    
    CALL cl_navigator_setting( g_curs_index, g_row_count )
   #CALL cl_opmsg('q')
    MESSAGE ""
    DISPLAY '   ' TO FORMONLY.cnt
    DISPLAY '   ' TO FORMONLY.cn
    
    CALL i440_curs()
    IF INT_FLAG THEN 
       LET INT_FLAG = 0 
       INITIALIZE g_dzda.* TO NULL 
       CALL g_dzdb_p.clear()
       CALL g_dzdb_r.clear()
       CALL g_dzdd.clear()
       LET g_rec_b_dzdb_p = 0
       LET g_rec_b_dzdb_r = 0
       LET g_rec_b_dzdd = 0
       CLEAR FORM 
       RETURN 
    END IF
    MESSAGE " SEARCHING ! "
    OPEN i440_data_curs
    IF SQLCA.sqlcode THEN 
       CALL cl_err("open cursor i440_data_curs:",SQLCA.sqlcode,1)
       INITIALIZE g_dzda.* TO NULL 
       CALL g_dzdb_p.clear()
       CALL g_dzdb_r.clear()
       CALL g_dzdd.clear()
       LET g_rec_b_dzdb_p = 0
       LET g_rec_b_dzdb_r = 0
       LET g_rec_b_dzdd = 0
    ELSE 
       OPEN i440_count_curs
       FETCH i440_count_curs INTO g_row_count
       CLOSE i440_count_curs
       DISPLAY g_row_count TO FORMONLY.cnt
       CALL i440_fetch('F')
    END IF 
    MESSAGE ""

END FUNCTION 

FUNCTION i440_fetch(p_flag)
DEFINE p_flag               LIKE type_t.chr1
DEFINE l_cnt                LIKE type_t.num5

    CASE p_flag
      WHEN 'N' FETCH NEXT     i440_data_curs INTO g_dzda.dzda001,g_dzda.dzda002,g_dzda.dzda003,g_dzda.dzda004
      WHEN 'P' FETCH PREVIOUS i440_data_curs INTO g_dzda.dzda001,g_dzda.dzda002,g_dzda.dzda003,g_dzda.dzda004
      WHEN 'F' FETCH FIRST    i440_data_curs INTO g_dzda.dzda001,g_dzda.dzda002,g_dzda.dzda003,g_dzda.dzda004
      WHEN 'L' FETCH LAST     i440_data_curs INTO g_dzda.dzda001,g_dzda.dzda002,g_dzda.dzda003,g_dzda.dzda004
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
        FETCH ABSOLUTE g_jump i440_data_curs INTO g_dzda.dzda001,g_dzda.dzda002,g_dzda.dzda003,g_dzda.dzda004
        LET mi_no_ask = FALSE
    END CASE 
    
    IF SQLCA.sqlcode THEN 
       INITIALIZE g_dzda.* TO NULL 
       CALL g_dzdb_p.clear()
       CALL g_dzdb_r.clear()
       CALL g_dzdd.clear()
       LET g_rec_b_dzdb_p = 0
       LET g_rec_b_dzdb_r = 0
       LET g_rec_b_dzdd = 0
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
    
    SELECT COUNT(*) INTO l_cnt FROM dzdd_file
     WHERE dzdd001=g_dzda.dzda001
       AND dzdd003=g_dzda.dzda003
    IF l_cnt > 0 THEN
       LET g_dzda.pre = 'Y'
    ELSE
       LET g_dzda.pre = 'N'
    END IF
    

    CALL adzi440_show()

END FUNCTION 

FUNCTION adzi440_show()

    DISPLAY BY NAME g_dzda.dzda001,g_dzda.dzda002,g_dzda.dzda004,g_dzda.pre
        
    CALL i440_b_fill()
    
END FUNCTION 

FUNCTION i440_b_fill()

    IF cl_null(g_dzda.dzda001) THEN 
       RETURN
    END IF
    
    CALL i440_get_dzdb_p(g_dzda.dzda001)
    CALL i440_get_dzdb_r(g_dzda.dzda001)
    CALL i440_get_dzdd(g_dzda.dzda001)
    
END FUNCTION 

FUNCTION adzi440_bp(p_ud)
DEFINE   p_ud                  LIKE type_t.chr1
DEFINE   l_ac_dzdb_p           LIKE type_t.num5
DEFINE   l_ac_dzdb_r           LIKE type_t.num5
DEFINE   l_ac_dzdd             LIKE type_t.num5

    IF p_ud <> "G" OR g_action_choice = "test" THEN
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
      
      DISPLAY ARRAY g_dzdd TO s_dzdd.* ATTRIBUTE(COUNT=g_rec_b_dzdd)
         BEFORE DISPLAY 
           CALL cl_navigator_setting( g_curs_index, g_row_count )
         BEFORE ROW 
             LET l_ac_dzdd = ARR_CURR()
      END DISPLAY 
      
      BEFORE DIALOG
         CALL cl_set_act_visible("close", FALSE)
         LET l_ac_dzdb_p = 1
         LET l_ac_dzdb_r = 1
         LET l_ac_dzdd = 1
         
      ON ACTION query
         LET g_action_choice="query"
         EXIT DIALOG

      ON ACTION first
         CALL i440_fetch('F')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   
         ACCEPT DIALOG                

      ON ACTION previous
         CALL i440_fetch('P')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   
         CONTINUE DIALOG    

      ON ACTION jump
         CALL i440_fetch('/')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   
         ACCEPT DIALOG                  

      ON ACTION next
         CALL i440_fetch('N')
         CALL cl_navigator_setting(g_curs_index, g_row_count)  
         CONTINUE DIALOG              

      ON ACTION last
         CALL i440_fetch('L')
         CALL cl_navigator_setting(g_curs_index, g_row_count)   
         ACCEPT DIALOG                  
      ON ACTION test
         LET g_action_choice="test"
         EXIT DIALOG
      
     #ON ACTION output
     #   LET g_action_choice="output"
     #   EXIT DIALOG     
      
      ON ACTION help
         LET g_action_choice="help"
         EXIT DIALOG 

      ON ACTION locale
         CALL cl_dynamic_locale()
          CALL cl_show_fld_cont()                   
          
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

      ON IDLE g_idle_seconds
         CALL cl_on_idle()
         CONTINUE DIALOG
 
      ON ACTION about        
         CALL cl_about()      
      
      ON ACTION accept
         LET g_action_choice="test"
         EXIT DIALOG
         
    END DIALOG

    CALL cl_set_act_visible("accept,cancel,close", TRUE)
END FUNCTION 

FUNCTION adzi440_test()
    IF cl_null(g_dzda.dzda001) THEN RETURN END IF
    #维护测试数据
    CALL adzi440_edit()
    IF INT_FLAG THEN
       LET INT_FLAG = 0
       RETURN 
    END IF 

    #进行debug测试
    CALL adzi440_p()
END FUNCTION

FUNCTION adzi440_edit()
DEFINE   l_cnt                LIKE type_t.num5
DEFINE   l_lock_sw            LIKE type_t.chr1
DEFINE   l_allow_delete       LIKE type_t.num5
DEFINE   l_allow_insert       LIKE type_t.num5
DEFINE   l_ac_dzdb_p          LIKE type_t.num5
DEFINE   l_ac_dzdb_r          LIKE type_t.num5
DEFINE   l_ac_dzdd            LIKE type_t.num5
DEFINE   l_n                  LIKE type_t.num5

    LET g_action_choice = ""
    IF cl_null(g_dzda.dzda001) THEN 
       RETURN 
    END IF 
   
   #CALL cl_opmsg('b')
    
    LET g_forupd_sql = "SELECT * FROM dzdb_t ",
                       " WHERE dzdb001 = ? AND dzdb003 = ? AND dzdb004 = ? AND dzdb002='P' FOR UPDATE NOWAIT"
    DECLARE i440_bcl_dzdb_p CURSOR FROM g_forupd_sql

    LET g_forupd_sql = "SELECT * FROM dzdd_t ",
                       " WHERE dzdd001 = ? AND dzdd002 = ? AND dzdd003 = ? FOR UPDATE NOWAIT"
    DECLARE i440_bcl_dzdd CURSOR FROM g_forupd_sql
    
    LET l_allow_insert = false
    LET l_allow_delete = false
    LET g_dzda.work = 'N'
    LET g_dzda.test = '2'
    DISPLAY g_dzda.work TO FORMONLY.work
    DISPLAY g_dzda.test TO FORMONLY.test

    DIALOG ATTRIBUTES(UNBUFFERED)

       INPUT ARRAY g_dzdb_p FROM s_dzdb_p.*
           ATTRIBUTE(COUNT=g_rec_b_dzdb_p,MAXCOUNT=g_max_rec,WITHOUT DEFAULTS = TRUE,
                     INSERT ROW=l_allow_insert,DELETE ROW=l_allow_delete ,APPEND ROW =l_allow_insert )
           
           BEFORE INPUT             
              IF g_rec_b_dzdb_p != 0 THEN
                 CALL fgl_set_arr_curr(l_ac_dzdb_p)
              END IF
              
           BEFORE ROW 
              LET l_ac_dzdb_p = ARR_CURR()  
              LET g_dzdb_p_t.* = g_dzdb_p[l_ac_dzdb_p].*
           
           ON CHANGE val_p
              LET g_dzdb_p_t.val_p = g_dzdb_p[l_ac_dzdb_p].val_p
           
       END INPUT 
       
       INPUT ARRAY g_dzdd FROM s_dzdd.*
           ATTRIBUTE(COUNT=g_rec_b_dzdd,MAXCOUNT=g_max_rec,WITHOUT DEFAULTS = TRUE,
                     INSERT ROW=l_allow_insert,DELETE ROW=l_allow_delete ,APPEND ROW =l_allow_insert )
           
           BEFORE INPUT             
              IF g_rec_b_dzdd != 0 THEN
                 CALL fgl_set_arr_curr(l_ac_dzdd)
              END IF

           BEFORE ROW 
              LET l_ac_dzdd = ARR_CURR()  
              LET g_dzdd_t.* = g_dzdd[l_ac_dzdd].*

           ON CHANGE val
              LET g_dzdd_t.val = g_dzdd[l_ac_dzdd].val
       END INPUT 
     
      #INPUT BY NAME g_dzda.b 
       INPUT BY NAME g_dzda.work,g_dzda.test ATTRIBUTE (WITHOUT DEFAULTS)
      #INPUT g_dzda.b WITHOUT DEFAULTS FROM b

        #BEFORE INPUT 
        #   LET g_dzda.b = '2'
        #   DISPLAY g_dzda.b TO FORMONLY.b

         ON IDLE g_idle_seconds
            CALL cl_on_idle()
            CONTINUE DIALOG
       END INPUT

       BEFORE DIALOG
          CALL cl_set_act_visible("close,append", FALSE)
          
       ON ACTION accept 
          ACCEPT DIALOG
          
       ON ACTION cancel
          LET INT_FLAG = 1
          EXIT DIALOG 
          
       ON ACTION CONTROLG
          CALL cl_cmdask()
       
       ON ACTION about         
          CALL cl_about()
        
       ON ACTION help         
          CALL cl_show_help()
    
    END DIALOG

END FUNCTION 

FUNCTION adzi440_p()

    LET g_4gl_name = g_user CLIPPED,'.4gl'   #zll命名再定:zhangllc_星期小_时分秒.4gl，避免数据无穷增大
    CALL adzi440_gen_4gl()
    #r.cs
    LET g_cmd = 'r.cs ',g_user CLIPPED
    RUN g_cmd
    #fglrun
    LET g_cmd = 'fglrun ',g_user CLIPPED
    RUN g_cmd
    
    #r.r OR r.d
    CASE
        WHEN g_dzda.test='1'   #r.r
             LET g_cmd = 'r.r'
        WHEN g_dzda.test='2'   #r.d
             LET g_cmd = 'r.d'
        OTHERWISE
             LET g_cmd = 'r.r'
    END CASE
    LET g_cmd = g_cmd CLIPPED,' ',g_user CLIPPED
    RUN g_cmd
END FUNCTION

FUNCTION adzi440_gen_4gl()
DEFINE l_ii        LIKE type_t.num5
DEFINE l_date      LIKE type_t.dat

    #BEGIN
    LET g_cmd =  "echo '#TEST 元件--begin' >$HOME/" ||  g_4gl_name CLIPPED
    RUN g_cmd
    LET g_cmd =  "echo 'SCHEMA ds' >>$HOME/" ||  g_4gl_name CLIPPED
    RUN g_cmd
   #LET g_cmd =  "echo 'GLOBALS \"../../cfg/top_global.inc\"' >>$HOME/" ||  g_4gl_name CLIPPED
   #RUN g_cmd
    #空行
    LET g_cmd =  "echo ' ' >>$HOME/" ||  g_4gl_name CLIPPED
    RUN g_cmd
    LET g_cmd =  "echo 'MAIN' >>$HOME/" ||  g_4gl_name CLIPPED
    RUN g_cmd

    #DEFINE 传入参数
    FOR l_ii = 1 TO  g_rec_b_dzdb_p
        LET g_chr = 'DEFINE ',g_dzdb_p[l_ii].dzdb005 CLIPPED,'   ',g_dzdb_p[l_ii].dzdb007 CLIPPED
        LET g_cmd =  "echo ",g_chr," >>$HOME/" ||  g_4gl_name CLIPPED
        RUN g_cmd
    END FOR
    #DEFINE 回传参数
    FOR l_ii = 1 TO  g_rec_b_dzdb_r
        LET g_chr = 'DEFINE ',g_dzdb_r[l_ii].dzdb005 CLIPPED,'   ',g_dzdb_r[l_ii].dzdb007 CLIPPED
        LET g_cmd =  "echo ",g_chr," >>$HOME/" ||  g_4gl_name CLIPPED
        RUN g_cmd
    END FOR
    #DEFINE --end

    #空行
    LET g_cmd =  "echo ' ' >>$HOME/" ||  g_4gl_name CLIPPED
    RUN g_cmd

    IF g_dzda.work='Y' THEN
       LET g_cmd =  "echo '    BEGIN WORK' >>$HOME/" ||  g_4gl_name CLIPPED
       RUN g_cmd
       LET g_cmd =  "echo '    LET g_inwork = 'Y'' >>$HOME/" ||  g_4gl_name CLIPPED
       RUN g_cmd
       #空行
       LET g_cmd =  "echo ' ' >>$HOME/" ||  g_4gl_name CLIPPED
       RUN g_cmd
    END IF

    #传入参数 赋值
    FOR l_ii = 1 TO  g_rec_b_dzdb_p
        IF g_dzdb_p[l_ii].val_p IS NOT NULL THEN
           LET g_chr = '    LET ',g_dzdb_p[l_ii].dzdb005 CLIPPED,' = ',g_dzdb_p[l_ii].val_p CLIPPED
           LET g_cmd =  "echo '",g_chr,"' >>$HOME/" ||  g_4gl_name CLIPPED
           RUN g_cmd
        END IF
    END FOR
    #空行
    LET g_cmd =  "echo ' ' >>$HOME/" ||  g_4gl_name CLIPPED
    RUN g_cmd

    #CALL 元件(p1,p2,p3...) RETURNING r1,r2,r3...
    LET g_chr = '    CALL ',g_dzda.dzda001 CLIPPED,'('
    #p1,p2,p3...
    FOR l_ii = 1 TO  g_rec_b_dzdb_p
        IF l_ii = 1 THEN
           LET g_chr = g_chr CLIPPED,g_dzdb_p[l_ii].dzdb005 CLIPPED
        ELSE
           LET g_chr = g_chr CLIPPED,',',g_dzdb_p[l_ii].dzdb005 CLIPPED
        END IF
    END FOR
    LET g_chr = g_chr CLIPPED,') RETURNING '
    #r1,r2,r3...
    FOR l_ii = 1 TO  g_rec_b_dzdb_r
        IF l_ii = 1 THEN
           LET g_chr = g_chr CLIPPED,' ',g_dzdb_r[l_ii].dzdb005 CLIPPED
        ELSE
           LET g_chr = g_chr CLIPPED,',',g_dzdb_r[l_ii].dzdb005 CLIPPED
        END IF
    END FOR
    LET g_cmd =  "echo '",g_chr,"' >>$HOME/" ||  g_4gl_name CLIPPED
    RUN g_cmd
    #空行
    LET g_cmd =  "echo ' ' >>$HOME/" ||  g_4gl_name CLIPPED
    RUN g_cmd
    #CALL --end

    IF g_dzda.work='Y' THEN
       LET g_cmd =  "echo '    IF (r_success) IS NULL OR r_success='Y' THEN' >>$HOME/" ||  g_4gl_name CLIPPED
       RUN g_cmd
       LET g_cmd =  "echo '       COMMIT WORK' >>$HOME/" ||  g_4gl_name CLIPPED
       RUN g_cmd
       LET g_cmd =  "echo '       LET g_inwork = 'N'' >>$HOME/" ||  g_4gl_name CLIPPED
       RUN g_cmd
       LET g_cmd =  "echo '    ELSE' >>$HOME/" ||  g_4gl_name CLIPPED
       RUN g_cmd
       LET g_cmd =  "echo '       ROLLBACK WORK' >>$HOME/" ||  g_4gl_name CLIPPED
       RUN g_cmd
       LET g_cmd =  "echo '       LET g_inwork = 'N'' >>$HOME/" ||  g_4gl_name CLIPPED
       RUN g_cmd
       LET g_cmd =  "echo '    END IF' >>$HOME/" ||  g_4gl_name CLIPPED
       RUN g_cmd
    END IF
    LET g_cmd =  "echo 'END MAIN' >>$HOME/" ||  g_4gl_name CLIPPED
    RUN g_cmd

END FUNCTION 

FUNCTION i440_get_dzdb_p(p_dzdb001)
DEFINE   p_dzdb001          LIKE dzdb_t.dzdb001
DEFINE   l_cnt                LIKE type_t.num5

    IF cl_null(p_dzdb001) THEN 
       RETURN
    END IF 
     
    CALL g_dzdb_p.clear()
    
    LET g_sql = "SELECT dzdb003,dzdb005,dzdb006,dzdb007,'' ",
                "  FROM dzdb_t ",
                " WHERE dzdb001 = '",p_dzdb001 CLIPPED,"'",
                "   AND dzdb002 = 'P' ",
                "   AND dzdb004 = '",g_lang,"' ",
                " ORDER BY dzdb003"
    PREPARE i440_dzdb_p_prep FROM g_sql
    DECLARE i440_dzdb_p_curs CURSOR FOR i440_dzdb_p_prep
    LET g_rec_b_dzdb_p = 0
    LET l_cnt = 1
    FOREACH i440_dzdb_p_curs INTO g_dzdb_p[l_cnt].*
       LET g_rec_b_dzdb_p = g_rec_b_dzdb_p + 1
       LET l_cnt = l_cnt + 1 
       IF l_cnt > g_max_rec THEN 
          CALL cl_err('', 9035, 0)
          EXIT FOREACH 
       END IF 
    END FOREACH 
    CALL g_dzdb_p.deleteElement(l_cnt)
    
END FUNCTION 

FUNCTION i440_get_dzdb_r(p_dzdb001)
DEFINE   p_dzdb001          LIKE dzdb_t.dzdb001
DEFINE   l_cnt                LIKE type_t.num5

    IF cl_null(p_dzdb001) THEN
       RETURN
    END IF

    CALL g_dzdb_r.clear()

    LET g_sql = "SELECT dzdb003,dzdb005,dzdb006,dzdb007,'' ",
                "  FROM dzdb_t ",
                " WHERE dzdb001 = '",p_dzdb001 CLIPPED,"'",
                "   AND dzdb002 = 'R' ",
                "   AND dzdb004 = '",g_lang,"' ",
                " ORDER BY dzdb003"
    PREPARE i440_dzdb_r_prep FROM g_sql
    DECLARE i440_dzdb_r_curs CURSOR FOR i440_dzdb_r_prep
    LET g_rec_b_dzdb_r = 0
    LET l_cnt = 1
    FOREACH i440_dzdb_r_curs INTO g_dzdb_r[l_cnt].*
       LET g_rec_b_dzdb_r = g_rec_b_dzdb_r + 1
       LET l_cnt = l_cnt + 1
       IF l_cnt > g_max_rec THEN
          CALL cl_err('', 9035, 0)
          EXIT FOREACH
       END IF
    END FOREACH
    CALL g_dzdb_r.deleteElement(l_cnt)

END FUNCTION

FUNCTION i440_get_dzdd(p_dzdd001)
DEFINE   p_dzdd001            LIKE dzdd_t.dzdd001
DEFINE   l_cnt                LIKE type_t.num5

    IF cl_null(p_dzdd001) THEN 
       RETURN 
    END IF 

    CALL g_dzdd.clear()
    
    LET g_sql = "SELECT dzdd002,dzdd004,dzdd005,dzdb002,dzdb003,dzdb005, ",
                "       dzdb006,dzdb007,'' ",
                "  FROM dzdd_t,dzdb_t ",
                " WHERE dzdd001 = dzda001 ",
                "   AND dzdd003 = dzda003 ",
                "   AND dzdd001 = '",p_dzdd001 CLIPPED,"'",
                "   AND dzdd003 = '",g_lang,"' ",
                " ORDER BY dzdd002"
    PREPARE i440_dzdd_prep FROM g_sql
    DECLARE i440_dzdd_curs CURSOR FOR i440_dzdd_prep
    LET g_rec_b_dzdd = 0
    LET l_cnt = 1
    FOREACH i440_dzdd_curs INTO g_dzdd[l_cnt].*
       LET g_rec_b_dzdd = g_rec_b_dzdd + 1
       LET l_cnt = l_cnt + 1
       IF l_cnt > g_max_rec THEN 
          CALL cl_err('', 9035, 0)
          EXIT FOREACH 
       END IF 
    END FOREACH 
    CALL g_dzdd.deleteElement(l_cnt)
END FUNCTION 
