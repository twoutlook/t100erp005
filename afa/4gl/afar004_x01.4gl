#該程式未解開Section, 採用最新樣板產出!
{<section id="afar004_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2016-04-12 16:51:17), PR版次:0003(2016-04-13 13:06:18)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000044
#+ Filename...: afar004_x01
#+ Description: ...
#+ Creator....: 01251(2015-03-25 17:41:28)
#+ Modifier...: 07673 -SD/PR- 07673
 
{</section>}
 
{<section id="afar004_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#160329-00016#1  2016/04/12  By 07673   资本化的状态+开始提列日期判断是否当月要计提折旧
#end add-point
#add-point:填寫註解說明 name="global.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="global.import"
 
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_report.inc"                  #報表使用的global
 
#報表 type 宣告
DEFINE tm RECORD
       wc STRING,                  #where condition 
       site LIKE type_t.chr20,         #資產中心 
       ld LIKE type_t.chr20,         #帳套 
       year LIKE type_t.num5,         #年度 
       speri LIKE type_t.num5          #期別
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_para_data      LIKE type_t.chr80  #140122-00001#1 add
#end add-point
 
{</section>}
 
{<section id="afar004_x01.main" readonly="Y" >}
PUBLIC FUNCTION afar004_x01(p_arg1,p_arg2,p_arg3,p_arg4,p_arg5)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr20         #tm.site  資產中心 
DEFINE  p_arg3 LIKE type_t.chr20         #tm.ld  帳套 
DEFINE  p_arg4 LIKE type_t.num5         #tm.year  年度 
DEFINE  p_arg5 LIKE type_t.num5         #tm.speri  期別
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.site = p_arg2
   LET tm.ld = p_arg3
   LET tm.year = p_arg4
   LET tm.speri = p_arg5
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "afar004_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL afar004_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL afar004_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL afar004_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL afar004_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL afar004_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="afar004_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION afar004_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "faah003.faah_t.faah003,faah004.faah_t.faah004,faah001.faah_t.faah001,faah015.faah_t.faah015,faah_desc.type_t.chr30,faajld.faaj_t.faajld,faaj009.faaj_t.faaj009,faaj010.faaj_t.faaj010,faaj005.faaj_t.faaj005,l_reason.type_t.chr200,faah006.faah_t.faah006" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="afar004_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION afar004_x01_ins_prep()
DEFINE i              INTEGER
DEFINE l_prep_str     STRING
#add-point:ins_prep.define (客製用) name="ins_prep.define_customerization"

#end add-point:ins_prep.define
#add-point:ins_prep.define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_prep.define"

#end add-point:ins_prep.define
 
   FOR i = 1 TO g_rep_tmpname.getLength()
      CALL cl_xg_del_data(g_rep_tmpname[i])
      #LET g_sql = g_rep_ins_prep[i]              #透過此lib取得prepare字串 lib精簡
      CASE i
         WHEN 1
         #INSERT INTO PREP
         LET g_sql = " INSERT INTO ",g_rep_db CLIPPED,g_rep_tmpname[1] CLIPPED," VALUES(?,?,?,?,?,?, 
             ?,?,?,?,?)"
         PREPARE insert_prep FROM g_sql
         IF STATUS THEN
            LET l_prep_str ="insert_prep",i
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = l_prep_str
            LET g_errparam.code   = status
            LET g_errparam.popup  = TRUE
            CALL cl_err()
            CALL cl_xg_drop_tmptable()
            LET g_rep_success = 'N'           
         END IF 
         #add-point:insert_prep段 name="insert_prep"
         
         #end add-point                  
 
 
      END CASE
   END FOR
END FUNCTION
 
{</section>}
 
{<section id="afar004_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION afar004_x01_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
 
#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"
   
   #end add-point
   LET g_select = " SELECT faah003,faah004,faah001,faah015,NULL,faajld,faaj009,faaj010,faaj005,NULL, 
       faah006"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   
   #end add-point
    LET g_from = " FROM faah_t,faaj_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_from = " FROM faah_t,faaj_t"
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
    #140122-00001#1----mark---str----
#    LET g_where = " WHERE faahent = faajent ",
#                  "   AND faah003 = faaj001 ",
#                  "   AND faah004 = faaj002 ", 
#                  "   AND faah001 = faaj037 ",
#                  "   AND faahstus = 'Y' ",
#                  "   AND faah015<>'0' ", #取得
#                  "   AND faah015<>'1' ", #資本化
#                  "   AND faah015<>'5' ", #出售
#                  "   AND faah015<>'6' ", #銷賬
#                 #"   AND faah015<>'7' ", #折畢再提    #2015/6/2 yangtt  狀態需包含折畢再提
#                  "   AND faaj003<>'6' ", #折舊方式不為其他                  
#                  "   AND faahent= '",g_enterprise,"'",
#                  "   AND faajld = '",tm.ld,"'",
#                  "   AND ", tm.wc CLIPPED   
   #140122-00001#1----mark---end----

   
        #160329-00016#1 add -str          
         LET g_where = " WHERE faahent = faajent ",
                  "   AND faah003 = faaj001 ",
                  "   AND faah004 = faaj002 ", 
                  "   AND faah001 = faaj037 ",
                  "   AND faahstus = 'Y' ",
                  "   AND faah015 NOT IN( '0','5','6','4') ", #取得，資本化，出售，銷賬，折畢 
                  "   AND faaj003 NOT IN('6','5')", #折舊方式不為其他/不提折旧                  
                  "   AND faahent= '",g_enterprise,"'",
                  "   AND faajld = '",tm.ld,"'",
                  "   AND ", tm.wc CLIPPED 
         #160329-00016#1 add -end
         #160329-00016#1 mark -str
#         #140122-00001#1----add---str----
#         LET g_where = " WHERE faahent = faajent ",
#                  "   AND faah003 = faaj001 ",
#                  "   AND faah004 = faaj002 ", 
#                  "   AND faah001 = faaj037 ",
#                  "   AND faahstus = 'Y' ",
#                  "   AND faah015 NOT IN( '0','1','5','6','4') ", #取得，資本化，出售，銷賬，折畢 
#                  "   AND faaj003 NOT IN('6','5')", #折舊方式不為其他/不提折旧                  
#                  "   AND faahent= '",g_enterprise,"'",
#                  "   AND faajld = '",tm.ld,"'",
#                  "   AND ", tm.wc CLIPPED 
#        #140122-00001#1----add---end----
         #160329-00016#1 mark -end
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("faah_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE afar004_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE afar004_x01_curs CURSOR FOR afar004_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="afar004_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION afar004_x01_ins_data()
DEFINE sr RECORD 
   faah003 LIKE faah_t.faah003, 
   faah004 LIKE faah_t.faah004, 
   faah001 LIKE faah_t.faah001, 
   faah015 LIKE faah_t.faah015, 
   faah_desc LIKE type_t.chr30, 
   faajld LIKE faaj_t.faajld, 
   faaj009 LIKE faaj_t.faaj009, 
   faaj010 LIKE faaj_t.faaj010, 
   faaj005 LIKE faaj_t.faaj005, 
   l_reason LIKE type_t.chr200, 
   faah006 LIKE faah_t.faah006
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_faal002      LIKE faal_t.faal002
DEFINE l_count        LIKE type_t.num5
DEFINE l_faaj021      LIKE faaj_t.faaj021
DEFINE l_faaj027      LIKE faaj_t.faaj027
DEFINE l_faaj028      LIKE faaj_t.faaj028
#140122-00001#1----add---str----
DEFINE l_faaj006      LIKE faaj_t.faaj006
DEFINE l_faaj007      LIKE faaj_t.faaj007
DEFINE l_faaj023      LIKE faaj_t.faaj023
DEFINE l_faaj024      LIKE faaj_t.faaj024
DEFINE l_faaj025      LIKE faaj_t.faaj025
DEFINE l_faaj026      LIKE faaj_t.faaj026
DEFINE l_faae003      LIKE faae_t.faae003
DEFINE l_glaacomp     LIKE glaa_t.glaacomp
DEFINE l_faaj008      LIKE faaj_t.faaj008
DEFINE l_date         STRING
DEFINE l_speri        STRING
DEFINE l_speri2       STRING
DEFINE l_year         STRING
DEFINE l_faal003      LIKE faal_t.faal003
#140122-00001#1----add---end----
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH afar004_x01_curs INTO sr.*                               
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
      IF sr.faah015='8' THEN
         LET sr.faah_desc='Y'
      ELSE
         LET sr.faah_desc='N'
      END IF
     
      #140122-00001#1----mark---str----
#      #停用資產不提折舊
#       LET l_faal002=''
#       SELECT faal002 INTO l_faal002
#         FROM faal_t
#        WHERE faalent=g_enterprise
#          AND faald=sr.faajld
#          AND faal001=sr.faah006
#       IF NOT cl_null(l_faal002) AND l_faal002='N' THEN
#          CONTINUE FOREACH
#       END IF
#140122-00001#1----mark---end----
       #160329-00016#1  add -str
       SELECT faal003 INTO l_faal003 
         FROM faal_t
        WHERE faalent = g_enterprise
          AND faalld  = tm.ld
          AND faal001 = sr.faah006
          
          LET l_speri2 = tm.speri
          LET l_year   = tm.year
          IF tm.speri < 10 THEN
             LET l_speri = '0',l_speri2
          ELSE 
             LET l_speri = tm.speri 
          END IF
          
          LET l_date =  l_year , l_speri
          SELECT faaj008 INTO l_faaj008
            FROM faaj_t
           WHERE faajent = g_enterprise
             AND faajld  = tm.ld
             AND faaj001 = sr.faah003
             AND faaj002 = sr.faah004
          IF sr.faah015 = '1' THEN 
             IF l_faal003  = 'Y'  AND (l_date = l_faaj008) THEN
             ELSE 
                CONTINUE FOREACH          
             END IF
              
          END IF            
          
      
       #160329-00016#1 add -end
       #折舊月份已提列折舊
       #若已存在于折旧档，不需检查 #140122-00001#1 add
       LET l_count=0
       SELECT COUNT(*) INTO l_count
         FROM faam_t
        WHERE faament=g_enterprise
          AND faamld=sr.faajld
          AND faam000=sr.faah001
          AND faam001=sr.faah003
          AND faam002=sr.faah004
          AND faam004=tm.year
          AND faam005=tm.speri
          AND faam006=1
          AND faam007<>3
          
       IF NOT cl_null(l_count) AND l_count>=1 THEN
          CONTINUE FOREACH
       END IF  
       
       #140122-00001#1----add---str----
       
       #筛选停用状态，不存在于折旧档，判断afai021中已停用资产是否计提折旧（Y）
       IF sr.faah015='8' THEN
          SELECT faal002 INTO l_faal002 FROM faal_t
           WHERE faalent = g_enterprise AND faalld = sr.faajld
             AND faal001 = sr.faah006
          IF l_faal002 = 'Y' THEN
             LET sr.l_reason = cl_getmsg('afa-00466',g_dlang)
          END IF
       END IF
       #140122-00001#1----add---end----       
       
       #已全額提列減值準備
       LET l_faaj021=0
       LET l_faaj027=0
       LET l_faaj028=0
       SELECT faaj021,faaj027,faaj028,faaj006,faaj007,faaj023,faaj024,faaj025,faaj026   #140122-00001#1 add faaj006,faaj007,faaj023,faaj024,faaj025,faaj026
         INTO l_faaj021,l_faaj027,l_faaj028,l_faaj006,l_faaj007,l_faaj023,l_faaj024,l_faaj025,l_faaj026 #140122-00001#1 add l_faaj006,l_faaj007,l_faaj023,l_faaj024,l_faaj025,l_faaj026
         FROM faaj_t
        WHERE faajent=g_enterprise
          AND faajld=sr.faajld
          AND faaj001=sr.faah003
          AND faaj002=sr.faah004
          AND faaj037=sr.faah001
       IF cl_null(l_faaj021) THEN LET l_faaj021=0 END IF
       IF cl_null(l_faaj027) THEN LET l_faaj027=0 END IF
       IF cl_null(l_faaj028) THEN LET l_faaj028=0 END IF
       
       #140122-00001#1----mark---str----
#       IF l_faaj028+l_faaj027 <=l_faaj021 THEN
#          CONTINUE FOREACH      
#       END IF
       #140122-00001#1----mark---end----
       #140122-00001#1----add---str----
       IF l_faaj028-(l_faaj027 - l_faaj021) <= 0 THEN
          IF NOT cl_null(sr.l_reason) THEN
             LET sr.l_reason = sr.l_reason,'\n',cl_getmsg('afa-00467',g_dlang)
          ELSE
             LET sr.l_reason = cl_getmsg('afa-00467',g_dlang)
          END IF          
       END IF
       
       IF l_faaj006 = '1' THEN
          SELECT glaacomp INTO l_glaacomp FROM glaa_t
           WHERE glaaent = g_enterprise AND glaald = sr.faajld
          CALL cl_get_para(g_enterprise,l_glaacomp,'S-FIN-9009') RETURNING g_para_data
          IF g_para_data = '1' THEN
             SELECT faae003 INTO l_faae003 FROM faae_t
              WHERE faaeent = g_enterprise AND faaeld = sr.faajld
                AND faae001 = l_faaj007 AND faae002 = sr.faah006
             IF cl_null(l_faae003) THEN
                IF NOT cl_null(sr.l_reason) THEN
                   LET sr.l_reason = sr.l_reason,'\n',cl_getmsg('afa-00469',g_dlang)
                ELSE
                   LET sr.l_reason = cl_getmsg('afa-00469',g_dlang)
                END IF
             END IF
          ELSE
             IF cl_null(l_faaj023) OR cl_null(l_faaj024) OR cl_null(l_faaj025) OR cl_null(l_faaj026) THEN
                IF NOT cl_null(sr.l_reason) THEN
                   LET sr.l_reason = sr.l_reason,'\n',cl_getmsg('afa-00468',g_dlang)
                ELSE
                   LET sr.l_reason = cl_getmsg('afa-00468',g_dlang)
                END IF
             END IF
          END IF
       END IF
       IF NOT cl_null(sr.l_reason) THEN
          LET sr.l_reason = sr.l_reason,'\n',cl_getmsg('afa-00470',g_dlang)
       ELSE
          LET sr.l_reason = cl_getmsg('afa-00470',g_dlang)
       END IF
       #140122-00001#1----add---end----
          
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.faah003,sr.faah004,sr.faah001,sr.faah015,sr.faah_desc,sr.faajld,sr.faaj009,sr.faaj010,sr.faaj005,sr.l_reason,sr.faah006
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "afar004_x01_execute"
          LET g_errparam.code   = SQLCA.sqlcode
          LET g_errparam.popup  = FALSE
          CALL cl_err()       
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
 
       #add-point:ins_data段after_save name="ins_data.after.save"
       
       #end add-point
       
    END FOREACH
    
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="afar004_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION afar004_x01_rep_data()
#add-point:rep_data.define (客製用) name="rep_data.define_customerization"

#end add-point:rep_data.define
#add-point:rep_data.define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="rep_data.define"

#end add-point:rep_data.define
 
    #add-point:rep_data.before name="rep_data.before"
    
    #end add-point:rep_data.before
    
    CALL cl_xg_view()
    #add-point:rep_data.after name="rep_data.after"
    
    #end add-point:rep_data.after
END FUNCTION
 
{</section>}
 
{<section id="afar004_x01.other_function" readonly="Y" >}

 
{</section>}
 
