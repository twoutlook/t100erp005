#該程式未解開Section, 採用最新樣板產出!
{<section id="asfr003_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:4(2016-11-09 15:06:28), PR版次:0004(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000075
#+ Filename...: asfr003_g01
#+ Description: ...
#+ Creator....: 04226(2014-09-02 17:02:38)
#+ Modifier...: 08992 -SD/PR- 00000
 
{</section>}
 
{<section id="asfr003_g01.global" readonly="Y" >}
#報表 g01 樣板自動產生(Version:13)
#add-point:填寫註解說明 name="global.memo"
#160503-00030#10 16/05/12  By ming    效能調整
#160425-00019    16/05/20  By Whitney 齊料套數不及時計算改抓sfaa071
#end add-point
#add-point:填寫註解說明 name="global.memo_customerization"

 
IMPORT os
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_report.inc"                  #報表使用的global
 
#報表 type 宣告
PRIVATE TYPE sr1_r RECORD
   sfaaent LIKE sfaa_t.sfaaent, 
   sfaadocno LIKE sfaa_t.sfaadocno, 
   sfaa020 LIKE sfaa_t.sfaa020, 
   sfaa010 LIKE sfaa_t.sfaa010, 
   sfaa012 LIKE sfaa_t.sfaa012, 
   sfaa013 LIKE sfaa_t.sfaa013, 
   sfaa050 LIKE sfaa_t.sfaa050, 
   sfaa051 LIKE sfaa_t.sfaa051, 
   sfaastus LIKE sfaa_t.sfaastus, 
   sfaa049 LIKE sfaa_t.sfaa049, 
   l_stus LIKE type_t.chr30, 
   l_imaal003 LIKE type_t.chr300, 
   l_imaal004 LIKE type_t.chr300, 
   l_pass LIKE type_t.num20_6, 
   l_sets LIKE type_t.num20_6, 
   l_allcomplet LIKE type_t.num20_6, 
   l_setcomplet LIKE type_t.num20_6
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING,                  #條件 
       a LIKE type_t.chr1,         #列印在製明細 
       b LIKE type_t.chr1,         #有在製製程站 
       c LIKE type_t.chr1          #列印報工時間
       END RECORD
DEFINE sr DYNAMIC ARRAY OF sr1_r                   #宣告sr為sr1_t資料結構的動態陣列
DEFINE g_select        STRING
DEFINE g_from          STRING
DEFINE g_where         STRING
DEFINE g_order         STRING
DEFINE g_sql           STRING                         #report_select_prep,REPORT段使用
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
TYPE sr3_r               RECORD  #製程 子報表
     sfcb001             LIKE sfcb_t.sfcb001,    #Run Card
     sfcb002             LIKE sfcb_t.sfcb002,    #項次
     sfcb003             LIKE sfcb_t.sfcb003,    #本站作業
     sfcb050             LIKE sfcb_t.sfcb050,    #在製量
     sfcb028             LIKE sfcb_t.sfcb028,    #良品轉入
     sfcb029             LIKE sfcb_t.sfcb029,    #重工轉入
     sfcb030             LIKE sfcb_t.sfcb030,    #工單轉入
     sfcb031             LIKE sfcb_t.sfcb031,    #分割轉入
     sfcb032             LIKE sfcb_t.sfcb032,    #合併轉入
     sfcb033             LIKE sfcb_t.sfcb033,    #良品轉出
     sfcb034             LIKE sfcb_t.sfcb034,    #重工轉出
     sfcb035             LIKE sfcb_t.sfcb035,    #工單轉出
     sfcb038             LIKE sfcb_t.sfcb038,    #分割轉出
     sfcb039             LIKE sfcb_t.sfcb039,    #合併轉出
     sfcb036             LIKE sfcb_t.sfcb036,    #當站報廢
     sfcb037             LIKE sfcb_t.sfcb037,    #當站下線
     sfcb014             LIKE sfcb_t.sfcb014,    #Move in
     sfcb015             LIKE sfcb_t.sfcb015,    #Check in
     sfcb016             LIKE sfcb_t.sfcb016,    #報工
     sfcb018             LIKE sfcb_t.sfcb018,    #Check out
     sfcb019             LIKE sfcb_t.sfcb019,    #Move out
     l_sfcb003_oocql004  LIKE type_t.chr1000,    #作業編號+說明
     l_scrap             LIKE type_t.num20_6,    #報廢率
     l_offline           LIKE type_t.num20_6,    #下線率
     l_complet           LIKE type_t.num20_6,    #當站完成率
     l_fmovein           LIKE type_t.chr20,      #首次Move in時間
     l_fcheckin          LIKE type_t.chr20,      #首次Check in 時間
     l_lwork             LIKE type_t.chr20,      #最近報工時間
     l_lcheckout         LIKE type_t.chr20,      #最近Check out時間
     l_lmoveout          LIKE type_t.chr20,      #最近Move out時間
     l_fmovein_show      LIKE type_t.chr1,       #首次Move in時間是否顯示
     l_fcheckin_show     LIKE type_t.chr1,       #首次Check in 時間是否顯示
     l_lwork_show        LIKE type_t.chr1,       #最近報工時間是否顯示
     l_lcheckout_show    LIKE type_t.chr1,       #最近Check out時間是否顯示
     l_lmoveout_show     LIKE type_t.chr1        #最近Move out時間是否顯示
END RECORD
#end add-point
 
{</section>}
 
{<section id="asfr003_g01.main" readonly="Y" >}
PUBLIC FUNCTION asfr003_g01(p_arg1,p_arg2,p_arg3,p_arg4)
DEFINE  p_arg1 STRING                  #tm.wc  條件 
DEFINE  p_arg2 LIKE type_t.chr1         #tm.a  列印在製明細 
DEFINE  p_arg3 LIKE type_t.chr1         #tm.b  有在製製程站 
DEFINE  p_arg4 LIKE type_t.chr1         #tm.c  列印報工時間
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.a = p_arg2
   LET tm.b = p_arg3
   LET tm.c = p_arg4
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "asfr003_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL asfr003_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL asfr003_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL asfr003_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="asfr003_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION asfr003_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   #準備抓日期時間的sql
   #報工類型(sffb001) 工單單號(sffb005) 作業編號(sffb007)
   LET g_sql = "SELECT sffb012,sffb013",
               "  FROM sffb_t",
               " WHERE sffbent = ",g_enterprise,
               "   AND sffb001 = ?",
               "   AND sffb005 = ?",
               "   AND sffb007 = ?",
               "   AND sffbstus = 'Y'",
               " ORDER BY sffb012,sffb013"
   PREPARE asfr003_g01_sffb FROM g_sql
   DECLARE asfr003_g01_sffb_cs SCROLL CURSOR FOR asfr003_g01_sffb
   #end add-point
   LET g_select = " SELECT sfaaent,sfaadocno,sfaa020,sfaa010,sfaa012,sfaa013,sfaa050,sfaa051,sfaastus, 
       sfaa049,NULL,NULL,NULL,NULL,NULL,NULL,NULL"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   
   #end add-point
    LET g_from = " FROM sfaa_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
    LET g_order = " ORDER BY sfaadocno"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("sfaa_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   #160503-00030#10 20160512 add by ming -----(S) 
   LET g_sql = "SELECT sfaaent,sfaadocno,sfaa020,sfaa010 ,sfaa012, ", 
               "       sfaa013,sfaa050  ,sfaa051,sfaastus,sfaa049, ", 
               "       NULL, ", 
               "       (SELECT imaal003 FROM imaal_t ", 
               "         WHERE imaalent = '",g_enterprise,"' ", 
               "           AND imaal001 = sfaa010 ", 
               "           AND imaal002 = '",g_dlang,"'), ", 
               "       (SELECT imaal004 FROM imaal_t ", 
               "         WHERE imaalent = '",g_enterprise,"' ", 
               "           AND imaal001 = sfaa010 ", 
               "           AND imaal002 = '",g_dlang,"'), ", 
              #160425-00019 by whitney modift start
              #"       NULL    ,NULL   , ", 
               "       NULL    ,sfaa071, ", 
              #160425-00019 by whitney modift end
               "       NULL   ,NULL ", 
               "  FROM sfaa_t ",g_where,                 
               " ORDER BY sfaadocno "
   LET g_sql = cl_sql_add_mask(g_sql)    
   
   #160503-00030#10 20160512 add by ming -----(E) 
   #end add-point
   PREPARE asfr003_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE asfr003_g01_curs CURSOR FOR asfr003_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="asfr003_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION asfr003_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   sfaaent LIKE sfaa_t.sfaaent, 
   sfaadocno LIKE sfaa_t.sfaadocno, 
   sfaa020 LIKE sfaa_t.sfaa020, 
   sfaa010 LIKE sfaa_t.sfaa010, 
   sfaa012 LIKE sfaa_t.sfaa012, 
   sfaa013 LIKE sfaa_t.sfaa013, 
   sfaa050 LIKE sfaa_t.sfaa050, 
   sfaa051 LIKE sfaa_t.sfaa051, 
   sfaastus LIKE sfaa_t.sfaastus, 
   sfaa049 LIKE sfaa_t.sfaa049, 
   l_stus LIKE type_t.chr30, 
   l_imaal003 LIKE type_t.chr300, 
   l_imaal004 LIKE type_t.chr300, 
   l_pass LIKE type_t.num20_6, 
   l_sets LIKE type_t.num20_6, 
   l_allcomplet LIKE type_t.num20_6, 
   l_setcomplet LIKE type_t.num20_6
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_sfaastus      LIKE sfaa_t.sfaastus
   DEFINE l_sfdc_cnt      LIKE type_t.num5
   DEFINE l_sfec_cnt      LIKE type_t.num5
   DEFINE l_num           LIKE type_t.num20_6
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    #發料單
    LET g_sql = "SELECT COUNT(*)",
                "  FROM sfdc_t",
                " WHERE sfdcent = ",g_enterprise,
                "   AND sfdc001 = ?"
    PREPARE asfr003_g01_sfdc FROM g_sql
    
    #入庫單
    LET g_sql = "SELECT COUNT(*)",
                "  FROM sfec_t",
                " WHERE sfecent = ",g_enterprise,
                "   AND sfec001 = ?"
    PREPARE asfr003_g01_sfec FROM g_sql
    
    #欠料
    LET g_sql = "SELECT SUM(CASE",
                "   WHEN COALESCE(sfba013,0) - COALESCE(sfba015,0) - COALESCE(sfba016,0) < 0",
                "     THEN 0",
                "   ELSE",
                "     COALESCE(sfba013,0) - COALESCE(sfba015,0) - COALESCE(sfba016,0)",
                "   END)",
                "  FROM sfba_t",
                " WHERE sfbaent = ",g_enterprise,
                "   AND sfbadocno = ?"
    PREPARE asfr003_g01_pre FROM g_sql
    
    #取狀態說明
    LET g_sql = "SELECT gzcbl004",
                "  FROM gzcbl_t",
                " WHERE gzcbl001 = '4035'",
                "   AND gzcbl002 = ?",
                "   AND gzcbl003 = '",g_dlang,"'"
    PREPARE asfr003_g01_gzcbl004 FROM g_sql
    
    #品名規格
    #160503-00030#10 20160512 mark by ming -----(S) 
    #已組進主SQL
    #LET g_sql = "SELECT imaal003,imaal004",
    #            "  FROM imaal_t",
    #            " WHERE imaalent = ",g_enterprise,
    #            "   AND imaal001 = ?",
    #            "   AND imaal002 = '",g_dlang,"'"
    #PREPARE asfr003_g01_imaal FROM g_sql
    #160503-00030#10 20160512 mark by ming -----(E) 
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH asfr003_g01_curs INTO sr_s.*
       IF STATUS THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = 'foreach:'
          LET g_errparam.code   = STATUS
          LET g_errparam.popup  = TRUE
          CALL cl_err()       
          LET g_rep_success = 'N'    
          EXIT FOREACH
       END IF
 
       #add-point:ins_data段foreach name="ins_data.foreach"
       #狀態
       IF sr_s.sfaastus = 'F' THEN
          LET l_sfdc_cnt = 0
		    #發料單
          EXECUTE asfr003_g01_sfdc USING sr_s.sfaadocno INTO l_sfdc_cnt
       
          LET l_sfec_cnt = 0
		    #入庫單
          EXECUTE asfr003_g01_sfec USING sr_s.sfaadocno INTO l_sfec_cnt
       
          LET l_num = 0
          #欠料
          EXECUTE asfr003_g01_pre USING sr_s.sfaadocno INTO l_num
          
          CASE
             #發放：無發料單、入庫單
             WHEN l_sfdc_cnt = 0 AND l_sfec_cnt = 0
                LET l_sfaastus = 'F'
       
             #部分發料：有發料單 AND 備料有欠料
             WHEN l_sfdc_cnt >= 1 AND l_num >= 1
                LET l_sfaastus = 'PF'
       
             #全部發料：有發料單 AND 備料無欠料
             WHEN l_sfdc_cnt >= 1 AND l_num = 0
                LET l_sfaastus = 'AF'
       
             #部分入庫：有入庫單 AND 入庫數量 < 生產數量
             WHEN l_sfec_cnt >= 1 AND
                  (sr_s.sfaa050 + sr_s.sfaa051) < sr_s.sfaa012
                LET l_sfaastus = 'PS'
                
             #全部入庫：有入庫單 AND 入庫數量 >= 生產數量
             WHEN l_sfec_cnt >= 1 AND
                  (sr_s.sfaa050 + sr_s.sfaa051) >= sr_s.sfaa012
                LET l_sfaastus = 'AS'
          END CASE
       ELSE
          LET l_sfaastus = sr_s.sfaastus
       END IF
       
       #品名規格
       #160503-00030#10 20160512 mark by ming -----(S) 
       #已組進主SQL 
       #EXECUTE asfr003_g01_imaal USING sr_s.sfaa010
       #   INTO sr_s.l_imaal003,sr_s.l_imaal004
       #160503-00030#10 20160512 mark by ming -----(E) 
       
       #取出狀態的說明
       EXECUTE asfr003_g01_gzcbl004 USING l_sfaastus INTO sr_s.l_stus

#160425-00019 by whitney mark start
#       #發料套數
#       LET l_success = ''
#       CALL s_asft340_full_sets(sr_s.sfaadocno,'','','')
#         RETURNING l_success,sr_s.l_sets
#160425-00019 by whitney mark end
       
       #合格率
       IF sr_s.sfaa050 = 0 AND sr_s.sfaa051 = 0 THEN
          LET sr_s.l_pass = 0
       ELSE
          LET sr_s.l_pass = sr_s.sfaa050 / (sr_s.sfaa050 + sr_s.sfaa051) * 100
       END IF
       
       #總完工率
       IF sr_s.sfaa012 = 0 OR cl_null(sr_s.sfaa012) THEN
          LET sr_s.l_allcomplet = 0
       ELSE
          LET sr_s.l_allcomplet = (sr_s.sfaa050 + sr_s.sfaa051) / sr_s.sfaa012 * 100
       END IF
       
       #齊套完工率
       IF sr_s.l_sets = 0 OR cl_null(sr_s.l_sets) THEN
          LET sr_s.l_setcomplet = 0
       ELSE
          LET sr_s.l_setcomplet = (sr_s.sfaa050 + sr_s.sfaa051) / sr_s.l_setcomplet * 100
       END IF
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].sfaaent = sr_s.sfaaent
       LET sr[l_cnt].sfaadocno = sr_s.sfaadocno
       LET sr[l_cnt].sfaa020 = sr_s.sfaa020
       LET sr[l_cnt].sfaa010 = sr_s.sfaa010
       LET sr[l_cnt].sfaa012 = sr_s.sfaa012
       LET sr[l_cnt].sfaa013 = sr_s.sfaa013
       LET sr[l_cnt].sfaa050 = sr_s.sfaa050
       LET sr[l_cnt].sfaa051 = sr_s.sfaa051
       LET sr[l_cnt].sfaastus = sr_s.sfaastus
       LET sr[l_cnt].sfaa049 = sr_s.sfaa049
       LET sr[l_cnt].l_stus = sr_s.l_stus
       LET sr[l_cnt].l_imaal003 = sr_s.l_imaal003
       LET sr[l_cnt].l_imaal004 = sr_s.l_imaal004
       LET sr[l_cnt].l_pass = sr_s.l_pass
       LET sr[l_cnt].l_sets = sr_s.l_sets
       LET sr[l_cnt].l_allcomplet = sr_s.l_allcomplet
       LET sr[l_cnt].l_setcomplet = sr_s.l_setcomplet
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="asfr003_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION asfr003_g01_rep_data()
   DEFINE HANDLER         om.SaxDocumentHandler
   DEFINE l_i             INTEGER
 
    #判斷是否有報表資料，若回彈出訊息視窗
    IF sr.getLength() = 0 THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = "adz-00285"
       LET g_errparam.extend = NULL
       LET g_errparam.popup  = FALSE
       LET g_errparam.replace[1] = ''
       CALL cl_err()  
       RETURN 
    END IF
    WHILE TRUE   
       #add-point:rep_data段印前 name="rep_data.before"
       
       #end add-point     
       LET handler = cl_gr_handler()
       IF handler IS NOT NULL THEN
          START REPORT asfr003_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT asfr003_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT asfr003_g01_rep
       END IF
       #add-point:rep_data段印完 name="rep_data.after"
       
       #end add-point       
       IF g_rep_flag = TRUE THEN
          LET g_rep_flag = FALSE
          EXIT WHILE
       END IF
    END WHILE
    #add-point:rep_data段離開while印完前 name="rep_data.end.before"
    
    #end add-point
    CALL cl_gr_close_report()
    #add-point:rep_data段離開while印完後 name="rep_data.end.after"
    
    #end add-point    
END FUNCTION
 
{</section>}
 
{<section id="asfr003_g01.rep" readonly="Y" >}
PRIVATE REPORT asfr003_g01_rep(sr1)
DEFINE sr1 sr1_r
DEFINE sr2 sr2_r
DEFINE l_subrep01_show  LIKE type_t.chr1,
       l_subrep02_show  LIKE type_t.chr1,
       l_subrep03_show  LIKE type_t.chr1,
       l_subrep04_show  LIKE type_t.chr1
DEFINE l_cnt           LIKE type_t.num10
DEFINE l_sub_sql       STRING
#add-point:rep段define  (客製用) name="rep.define_customerization"

#end add-point
#add-point:rep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="rep.define"
DEFINE sr3              sr3_r
DEFINE l_turn_into      LIKE type_t.num20_6  #轉入合計
DEFINE l_turn_out       LIKE type_t.num20_6  #轉出合計
DEFINE l_sffb012        LIKE sffb_t.sffb012  #完成日期
DEFINE l_sffb013        LIKE sffb_t.sffb013  #完成時間
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER  BY sr1.sfaadocno
    #add-point:rep段ORDER_after name="rep.order.after"
    
    #end add-point
    
    FORMAT
       FIRST PAGE HEADER          
          PRINTX g_user,g_pdate,g_rep_code,g_company,g_ptime,g_user_name,g_date_fmt
          PRINTX tm.*
          PRINTX g_grNumFmt.*
          PRINTX g_rep_wcchp
 
          #讀取beforeGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.sfaadocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.sfaadocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'sfaaent=' ,sr1.sfaaent,'{+}sfaadocno=' ,sr1.sfaadocno         
            CALL cl_gr_init_apr(sr1.sfaadocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.sfaadocno.before name="rep.b_group.sfaadocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.sfaaent CLIPPED ,"'", " AND  ooff003 = '", sr1.sfaadocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE asfr003_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE asfr003_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT asfr003_g01_subrep01
           DECLARE asfr003_g01_repcur01 CURSOR FROM g_sql
           FOREACH asfr003_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "asfr003_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT asfr003_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT asfr003_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.sfaadocno.after name="rep.b_group.sfaadocno.after"
           
           #end add-point:
 
 
 
 
       ON EVERY ROW
          #add-point:rep.everyrow.before name="rep.everyrow.before"
          
          #end add-point:rep.everyrow.before
 
          #單身前備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub02.before name="rep.sub02.before"
           
           #end add-point:rep.sub02.before
 
           #add-point:rep.sub02.sql name="rep.sub02.sql"
           
           #end add-point:rep.sub02.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='2' AND ooffent = '", 
                sr1.sfaaent CLIPPED ,"'", " AND  ooff003 = '", sr1.sfaadocno CLIPPED ,"'"
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE asfr003_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE asfr003_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT asfr003_g01_subrep02
           DECLARE asfr003_g01_repcur02 CURSOR FROM g_sql
           FOREACH asfr003_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "asfr003_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT asfr003_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT asfr003_g01_subrep02
           #add-point:rep.sub02.after name="rep.sub02.after"
           
           #end add-point:rep.sub02.after
 
 
 
          #add-point:rep.everyrow.beforerow name="rep.everyrow.beforerow"
          
          #end add-point:rep.everyrow.beforerow
            
          PRINTX sr1.*
 
          #add-point:rep.everyrow.afterrow name="rep.everyrow.afterrow"
          
          START REPORT asfr003_g01_subrep05
             #工單在製明細
             IF tm.a = 'Y' THEN
                LET g_sql = "SELECT sfcb001,sfcb002,sfcb003,sfcb050,sfcb028,",
                            "       sfcb029,sfcb030,sfcb031,sfcb032,sfcb033,",
                            "       sfcb034,sfcb035,sfcb038,sfcb039,sfcb036,",
                            "       sfcb037,sfcb014,sfcb015,sfcb016,sfcb018,",
                            "       sfcb019,trim(sfcb003)||'.'||trim(oocql004),'','','',",
                            "       '','','','','',''",
                            "  FROM sfcb_t",
                            "  LEFT OUTER JOIN oocql_t ON oocqlent = sfcbent",
                            "                         AND oocql001 = '221'",
                            "                         AND oocql002 = sfcb003",
                            "                         AND oocql003 = '", g_dlang,"'",
                            " WHERE sfcbent = ",sr1.sfaaent,
                            "   AND sfcbdocno = '",sr1.sfaadocno ,"'"
                                
                DECLARE asfr003_g01_subrep05 CURSOR FROM g_sql
                FOREACH asfr003_g01_subrep05 INTO sr3.*
                   #僅列印有在製的製程站 = 'Y' and (在製量(sfcb050) > 0)的制程站才列印
                   IF tm.b = 'Y' AND sr3.sfcb050 <= 0 THEN
                      CONTINUE FOREACH
                   END IF
                
                   #轉入合計 = 良品轉入 + 重工轉入 + 工單轉入 + 分割轉入 + 合併轉入
                   LET l_turn_into = sr3.sfcb028 + sr3.sfcb029 + sr3.sfcb030 + sr3.sfcb031 + sr3.sfcb032
                   
                   #轉出合計 = 良品轉出 + 重工轉出 + 工單轉出 + 分割轉出 + 合併轉出
                   LET l_turn_out = sr3.sfcb033 + sr3.sfcb034 + sr3.sfcb035 + sr3.sfcb038 + sr3.sfcb039
                   
                   #報廢率 = 當站報廢數量 / 轉入合計
                   IF l_turn_into = 0 THEN
                      LET sr3.l_scrap = 0
                   ELSE
                      LET sr3.l_scrap = (sr3.sfcb036 / l_turn_into) * 100
                   END IF
                   
                   #下線率 = 當站下線數量 / 轉入合計
                   IF l_turn_into = 0 THEN
                      LET sr3.l_offline = 0
                   ELSE
                      LET sr3.l_offline = (sr3.sfcb037 / l_turn_into) * 100
                   END IF
                   
                   #當站完成率 = 轉出合計 / 轉入合計
                   IF l_turn_into = 0 THEN
                      LET sr3.l_complet = 0
                   ELSE
                      LET sr3.l_complet = (l_turn_out / l_turn_into) * 100
                   END IF
                   
                   #列印報工時間
                   IF tm.c = 'Y' THEN
                      LET sr3.l_fmovein_show   = 'Y'    #首次Move in時間是否顯示
                      LET sr3.l_fcheckin_show  = 'Y'    #首次Check in 時間是否顯示
                      LET sr3.l_lwork_show     = 'Y'    #最近報工時間是否顯示
                      LET sr3.l_lcheckout_show = 'Y'    #最近Check out時間是否顯示
                      LET sr3.l_lmoveout_show  = 'Y'    #最近Move out時間是否顯示
                   ELSE
                      LET sr3.l_fmovein_show   = 'N'    #首次Move in時間是否顯示
                      LET sr3.l_fcheckin_show  = 'N'    #首次Check in 時間是否顯示
                      LET sr3.l_lwork_show     = 'N'    #最近報工時間是否顯示
                      LET sr3.l_lcheckout_show = 'N'    #最近Check out時間是否顯示
                      LET sr3.l_lmoveout_show  = 'N'    #最近Move out時間是否顯示
                   END IF
                   
                   #首次Move in時間 sffb001 = 1 抓第一筆
                   IF sr3.sfcb014 = 'Y' THEN
                      LET l_sffb012 = ''
                      LET l_sffb013 = ''
                      OPEN asfr003_g01_sffb_cs USING '1',sr1.sfaadocno,sr3.sfcb003
                      FETCH FIRST asfr003_g01_sffb_cs INTO l_sffb012,l_sffb013
                      LET sr3.l_fmovein = l_sffb012,' ',l_sffb013
                   ELSE
                      LET sr3.l_fmovein_show = 'N'
                   END IF
                   
                   #首次Check in時間 sffb001 = 2 抓第一筆
                   IF sr3.sfcb015 = 'Y' THEN
                      LET l_sffb012 = ''
                      LET l_sffb013 = ''
                      OPEN asfr003_g01_sffb_cs USING '2',sr1.sfaadocno,sr3.sfcb003
                      FETCH FIRST asfr003_g01_sffb_cs INTO l_sffb012,l_sffb013
                      LET sr3.l_fcheckin = l_sffb012,' ',l_sffb013
                   ELSE
                      LET sr3.l_fcheckin_show = 'N'
                   END IF
                   
                   #最近報工時間 sffb001 = 3 抓最後一筆
                   IF sr3.sfcb016 = 'Y' THEN
                      LET l_sffb012 = ''
                      LET l_sffb013 = ''
                      OPEN asfr003_g01_sffb_cs USING '3',sr1.sfaadocno,sr3.sfcb003
                      FETCH LAST asfr003_g01_sffb_cs INTO l_sffb012,l_sffb013
                      LET sr3.l_lwork = l_sffb012,' ',l_sffb013
                   ELSE
                      LET sr3.l_lwork_show = 'N'
                   END IF
                   
                   #最近Check out時間 sffb001 = 4 抓最後一筆
                   IF sr3.sfcb018 = 'Y' THEN
                      LET l_sffb012 = ''
                      LET l_sffb013 = ''
                      OPEN asfr003_g01_sffb_cs USING '4',sr1.sfaadocno,sr3.sfcb003
                      FETCH LAST asfr003_g01_sffb_cs INTO l_sffb012,l_sffb013
                      LET sr3.l_lcheckout = l_sffb012,' ',l_sffb013
                   ELSE
                      LET sr3.l_lcheckout_show = 'N'
                   END IF
                   
                   #最近Move out時間 sffb001 = 5 抓最後一筆
                   IF sr3.sfcb019 = 'Y' THEN
                      LET l_sffb012 = ''
                      LET l_sffb013 = ''
                      OPEN asfr003_g01_sffb_cs USING '5',sr1.sfaadocno,sr3.sfcb003
                      FETCH LAST asfr003_g01_sffb_cs INTO l_sffb012,l_sffb013
                      LET sr3.l_lmoveout = l_sffb012,' ',l_sffb013
                   ELSE
                      LET sr3.l_lmoveout_show = 'N'
                   END IF
                   
                   OUTPUT TO REPORT asfr003_g01_subrep05(sr3.*)
                END FOREACH
             END IF
          FINISH REPORT asfr003_g01_subrep05
          #end add-point:rep.everyrow.afterrow
 
          #單身後備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub03.before name="rep.sub03.before"
           
           #end add-point:rep.sub03.before
 
           #add-point:rep.sub03.sql name="rep.sub03.sql"
           
           #end add-point:rep.sub03.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooff003 = '", 
                sr1.sfaaent CLIPPED ,"'"
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE asfr003_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE asfr003_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT asfr003_g01_subrep03
           DECLARE asfr003_g01_repcur03 CURSOR FROM g_sql
           FOREACH asfr003_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "asfr003_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT asfr003_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT asfr003_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.sfaadocno
 
           #add-point:rep.a_group.sfaadocno.before name="rep.a_group.sfaadocno.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.sfaaent CLIPPED ,"'", " AND  ooff003 = '", sr1.sfaadocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE asfr003_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE asfr003_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT asfr003_g01_subrep04
           DECLARE asfr003_g01_repcur04 CURSOR FROM g_sql
           FOREACH asfr003_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "asfr003_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT asfr003_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT asfr003_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.sfaadocno.after name="rep.a_group.sfaadocno.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="asfr003_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT asfr003_g01_subrep01(sr2)
DEFINE  sr2  sr2_r
#add-point:query段define(客製用) name="sub01.define_customerization" 

#end add-point
#add-point:sub01.define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sub01.define" 

#end add-point:sub01.define
 
    #add-point:sub01.order.before name="sub01.order.before" 
    
    #end add-point:sub01.order.before
 
 
 
    FORMAT
 
 
 
       ON EVERY ROW
            #add-point:sub01.everyrow.before name="sub01.everyrow.before" 
                          
            #end add-point:sub01.everyrow.before
 
            PRINTX sr2.*
 
            #add-point:sub01.everyrow.after name="sub01.everyrow.after" 
            
            #end add-point:sub01.everyrow.after
 
 
END REPORT
 
 
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT asfr003_g01_subrep02(sr2)
DEFINE  sr2  sr2_r
#add-point:query段define(客製用) name="sub02.define_customerization" 

#end add-point
#add-point:sub02.define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sub02.define" 

#end add-point:sub02.define
 
    #add-point:sub02.order.before name="sub02.order.before" 
    
    #end add-point:sub02.order.before
 
 
 
    FORMAT
 
 
 
       ON EVERY ROW
            #add-point:sub02.everyrow.before name="sub02.everyrow.before" 
                          
            #end add-point:sub02.everyrow.before
 
            PRINTX sr2.*
 
            #add-point:sub02.everyrow.after name="sub02.everyrow.after" 
            
            #end add-point:sub02.everyrow.after
 
 
END REPORT
 
 
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT asfr003_g01_subrep03(sr2)
DEFINE  sr2  sr2_r
#add-point:query段define(客製用) name="sub03.define_customerization" 

#end add-point
#add-point:sub03.define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sub03.define" 

#end add-point:sub03.define
 
    #add-point:sub03.order.before name="sub03.order.before" 
    
    #end add-point:sub03.order.before
 
 
 
    FORMAT
 
 
 
       ON EVERY ROW
            #add-point:sub03.everyrow.before name="sub03.everyrow.before" 
                          
            #end add-point:sub03.everyrow.before
 
            PRINTX sr2.*
 
            #add-point:sub03.everyrow.after name="sub03.everyrow.after" 
            
            #end add-point:sub03.everyrow.after
 
 
END REPORT
 
 
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT asfr003_g01_subrep04(sr2)
DEFINE  sr2  sr2_r
#add-point:query段define(客製用) name="sub04.define_customerization" 

#end add-point
#add-point:sub04.define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sub04.define" 

#end add-point:sub04.define
 
    #add-point:sub04.order.before name="sub04.order.before" 
    
    #end add-point:sub04.order.before
 
 
 
    FORMAT
 
 
 
       ON EVERY ROW
            #add-point:sub04.everyrow.before name="sub04.everyrow.before" 
                          
            #end add-point:sub04.everyrow.before
 
            PRINTX sr2.*
 
            #add-point:sub04.everyrow.after name="sub04.everyrow.after" 
            
            #end add-point:sub04.everyrow.after
 
 
END REPORT
 
 
 
 
{</section>}
 
{<section id="asfr003_g01.other_function" readonly="Y" >}

 
{</section>}
 
{<section id="asfr003_g01.other_report" readonly="Y" >}

################################################################################
# Descriptions...: 製程明細 子報表
# Memo...........:
# Usage..........: CALL asfr003_g01_subrep05(sr3)
# Input parameter: sr3        資料RECORD
# Return code....: 無
# Date & Author..: 2014/09/04 By pomelo
# Modify.........:
################################################################################
REPORT asfr003_g01_subrep05(sr3)
DEFINE sr3             sr3_r

   ORDER EXTERNAL BY sr3.sfcb002
      FORMAT
         ON EVERY ROW
            PRINTX g_grNumFmt.*
            PRINTX sr3.*
END REPORT

 
{</section>}
 
