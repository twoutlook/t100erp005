#該程式未解開Section, 採用最新樣板產出!
{<section id="axmr070_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2016-06-30 02:30:56), PR版次:0002(2016-06-30 02:32:59)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000028
#+ Filename...: axmr070_x01
#+ Description: ...
#+ Creator....: 06137(2016-05-04 11:02:12)
#+ Modifier...: 02749 -SD/PR- 02749
 
{</section>}
 
{<section id="axmr070_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"

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
       wc STRING                   #where condition
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="axmr070_x01.main" readonly="Y" >}
PUBLIC FUNCTION axmr070_x01(p_arg1)
DEFINE  p_arg1 STRING                  #tm.wc  where condition
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "axmr070_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL axmr070_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL axmr070_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL axmr070_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL axmr070_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL axmr070_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="axmr070_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION axmr070_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "xmfjent.xmfj_t.xmfjent,xmfjsite.xmfj_t.xmfjsite,xmfjdocno.xmfj_t.xmfjdocno,xmfjdocdt.xmfj_t.xmfjdocdt,xmfjstus.xmfj_t.xmfjstus,l_xmfjstus_desc.type_t.chr100,xmfj001.xmfj_t.xmfj001,l_xmfj001_ooag011.type_t.chr300,xmfj002.xmfj_t.xmfj002,l_xmfj002_ooefl003.type_t.chr1000,xmfj003.xmfj_t.xmfj003,l_xmfj003_pmaal004.type_t.chr100,xmfj004.xmfj_t.xmfj004,ooail_t_ooail003.ooail_t.ooail003,xmfj005.xmfj_t.xmfj005,l_xmfj005_desc.oodbl_t.oodbl004,xmfj006.xmfj_t.xmfj006,xmfj007.xmfj_t.xmfj007,xmfj008.xmfj_t.xmfj008,ooibl_t_ooibl004.ooibl_t.ooibl004,xmfj009.xmfj_t.xmfj009,t2_oocql004.oocql_t.oocql004,xmfj010.xmfj_t.xmfj010,oocql_t_oocql004.oocql_t.oocql004,xmfj011.xmfj_t.xmfj011,xmfj012.xmfj_t.xmfj012,xmflseq.xmfl_t.xmflseq,l_xmfl001_desc.type_t.chr100,xmfl002.xmfl_t.xmfl002,l_xmfl002_desc.type_t.chr100,l_xmfl002_desc1.type_t.chr100,xmfl003.xmfl_t.xmfl003,l_xmfl003_desc.type_t.chr100,l_xmfl005_desc.type_t.chr100,xmfl007.xmfl_t.xmfl007,xmfl006.xmfl_t.xmfl006,x_oocal_t_oocal003.oocal_t.oocal003,xmfl008.xmfl_t.xmfl008" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #有子報表時先Create子報表用tmp table
   LET g_sql =" xmfment.xmfm_t.xmfment, ",
              " xmfmdocno.xmfm_t.xmfmdocno,",
              " xmfmseq.xmfm_t.xmfmseq, ",
              " xmfm001.xmfm_t.xmfm001, ",
              " xmfm002.xmfm_t.xmfm002, ",
              " xmfm003.xmfm_t.xmfm003, ",
              " xmfm004.xmfm_t.xmfm004  "
   IF NOT cl_xg_create_tmptable(g_sql,2) THEN
      LET g_rep_success = 'N'
   END IF    
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="axmr070_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION axmr070_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
         
         #有子報表時，需先組Insert into的prepare語法
         WHEN 2
            LET g_sql = " INSERT INTO ",g_rep_db CLIPPED,g_rep_tmpname[2] CLIPPED,
                        " VALUES(?,?,?,?,?,?,?)"
            PREPARE insert_prep1 FROM g_sql
            IF STATUS THEN
               LET l_prep_str = "insert_prep1",i
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = l_prep_str
               LET g_errparam.code   = STATUS
               LET g_errparam.popup  = TRUE
               CALL cl_err()
            
               CALL cl_xg_drop_tmptable()
               LET g_rep_success = 'N'
            END IF
            
         #end add-point                  
 
 
      END CASE
   END FOR
END FUNCTION
 
{</section>}
 
{<section id="axmr070_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axmr070_x01_sel_prep()
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
   LET g_select =  " SELECT xmfjent,xmfjsite,xmfjdocno,xmfjdocdt,xmfjstus,  ",
                   " (SELECT xmfjstus||'.'||gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '13' AND gzcbl002 = xmfjstus AND gzcbl003= '",g_dlang,"' ),    ",
                   "  xmfj001,(SELECT ooag011  FROM ooag_t WHERE ooagent = xmfjent AND ooag001 = xmfj001),                                        ",
                   "  xmfj002,(SELECT ooefl003 FROM ooefl_t WHERE ooeflent = xmfjent AND ooefl001 = xmfj002 AND ooefl002 = '",g_dlang,"' ),       ",
                   "  xmfj003,(SELECT pmaal003 FROM pmaal_t WHERE pmaalent = xmfjent AND pmaal001 = xmfj003 AND pmaal002 = '",g_dlang,"' ),       ",
                   "  xmfj004,(SELECT ooail003 FROM ooail_t WHERE ooailent = xmfjent AND ooail001 = xmfj004 AND ooail002 = '",g_dlang,"' ),       ",
                   "  xmfj005,(SELECT oodbl004 FROM oodbl_t,ooef_t WHERE oodblent = xmfjent AND oodblent = ooefent AND ooef001 = xmfjsite         ", 
                   "                                                AND ooef019 = oodbl001 AND oodbl002 = xmfj005 AND oodbl003 = '",g_dlang,"'),  ",
                   "  xmfj006/100,xmfj007,                                                                                                            ",
                   "  xmfj008,(SELECT ooibl004 FROM ooibl_t WHERE ooiblent = xmfjent AND ooibl002 = xmfj008 AND ooibl003 = '",g_dlang,"' ) ,      ",
                   "  xmfj009,(SELECT oocql004 FROM oocql_t WHERE oocqlent = xmfjent AND oocql001 = '238' AND oocql002 = xmfj009 AND oocql003= '",g_dlang,"' ), ",
                  #160621-00003#6 160629 by lori mark and add---(E)
                  #"  xmfj010,(SELECT oocql004 FROM oocql_t WHERE oocqlent = xmfjent AND oocql001 = '275' AND oocql002 = xmfj010 AND oocql003= '",g_dlang,"' ), ",
                   "  xmfj010,(SELECT oojdl003 FROM oojdl_t WHERE oojdlent = xmfjent AND oojdl001 = xmfj010 AND oojdl002 = '",g_dlang,"' ), ",
                  #160621-00003#6 160629 by lori mark and add---(E)
                   "  xmfj011,xmfj012,xmflseq,  ",
                   "          (SELECT xmfl001||'.'||gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '2104' AND gzcbl002 = xmfl001 AND gzcbl003= '",g_dlang,"' ),  ",
                   "  xmfl002,(CASE WHEN xmfl001 = '1' THEN (SELECT imaal003 FROM imaal_t WHERE imaalent = xmflent AND imaal001 = xmfl002 AND imaal002 = '",g_dlang,"' )                            ",
                   "                WHEN xmfl001 = '2' THEN (SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent = xmflent AND rtaxl001 = xmfl002 AND rtaxl002 = '",g_dlang,"' )                            ",
                   "                WHEN xmfl001 = '3' THEN (SELECT oocql004 FROM oocql_t WHERE oocqlent = xmflent AND oocql001 = '2003' AND oocql002 = xmfl002 AND oocql003='",g_dlang,"'  ) END), ",
                   "          (CASE WHEN xmfl001 = '1' THEN (SELECT imaal004 FROM imaal_t WHERE imaalent = xmflent AND imaal001 = xmfl002 AND imaal002 = '",g_dlang,"') END),                       ",
                   "  xmfl003,'',  ",
                   " (SELECT xmfl005||'.'||gzcbl004 FROM gzcbl_t WHERE gzcbl001 = '2105' AND gzcbl002 = xmfl005 AND gzcbl003= '",g_dlang,"' ), ",
                   "  xmfl007, ",
                   "  xmfl006,(SELECT oocal003 FROM oocal_t WHERE oocalent = xmfjent AND oocal001 = xmfl006 AND oocal002 = '",g_dlang,"'),     ",
                   "  xmfl008/100 "
#   #end add-point
#   LET g_select = " SELECT xmfjent,xmfjsite,xmfjdocno,xmfjdocdt,xmfjstus,'',xmfj001,trim(xmfj001)||'.'||trim((SELECT ooag011 FROM ooag_t WHERE ooag_t.ooag001 = xmfj_t.xmfj001 AND ooag_t.ooagent = xmfj_t.xmfjent)), 
#       xmfj002,trim(xmfj002)||'.'||trim((SELECT ooefl003 FROM ooefl_t WHERE ooefl_t.ooefl001 = xmfj_t.xmfj002 AND ooefl_t.ooeflent = xmfj_t.xmfjent AND ooefl_t.ooefl002 = '" , 
#       g_dlang,"'" ,")),xmfj003,trim(xmfj003)||'.'||trim((SELECT pmaal004 FROM pmaal_t WHERE pmaal_t.pmaal001 = xmfj_t.xmfj003 AND pmaal_t.pmaalent = xmfj_t.xmfjent AND pmaal_t.pmaal002 = '" , 
#       g_dlang,"'" ,")),xmfj004,( SELECT ooail003 FROM ooail_t WHERE ooail_t.ooail001 = xmfj_t.xmfj004 AND ooail_t.ooailent = xmfj_t.xmfjent AND ooail_t.ooail002 = '" , 
#       g_dlang,"'" ,"),xmfj005,'',xmfj006,xmfj007,xmfj008,( SELECT ooibl004 FROM ooibl_t WHERE ooibl_t.ooibl002 = xmfj_t.xmfj008 AND ooibl_t.ooiblent = xmfj_t.xmfjent AND ooibl_t.ooibl003 = '" , 
#       g_dlang,"'" ,"),xmfj009,( SELECT oocql004 FROM oocql_t t2 WHERE t2.oocql001 = '238' AND t2.oocql002 = xmfj_t.xmfj009 AND t2.oocqlent = xmfj_t.xmfjent AND t2.oocql003 = '" , 
#       g_dlang,"'" ,"),xmfj010,( SELECT oocql004 FROM oocql_t WHERE oocql_t.oocql001 = '275' AND oocql_t.oocql002 = xmfj_t.xmfj010 AND oocql_t.oocqlent = xmfj_t.xmfjent AND oocql_t.oocql003 = '" , 
#       g_dlang,"'" ,"),xmfj011,xmfj012,xmflseq,NULL,xmfl002,'','',xmfl003,'','',xmfl007,xmfl006,x.oocal_t_oocal003, 
#       xmfl008"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_from  = " FROM xmfj_t                                                       ",
                 "      LEFT JOIN pmaa_t ON pmaa001 = xmfj003 AND pmaaent = xmfjent  ",
                 "      ,xmfl_t                                                      ",
                 "      LEFT JOIN imaa_t ON imaaent = xmflent AND imaa001 = xmfl002  ",
                 "      LEFT JOIN imaf_t ON imafent = xmflent AND imafsite = xmflsite AND imaf001 = xmfl002 "                

#   #end add-point
#    LET g_from = " FROM xmfj_t LEFT OUTER JOIN ( SELECT xmfl_t.*,( SELECT oocal003 FROM oocal_t WHERE oocal_t.oocal001 = xmfl_t.xmfl006 AND oocal_t.oocalent = xmfl_t.xmflent AND oocal_t.oocal002 = '" , 
#        g_dlang,"'" ,") oocal_t_oocal003 FROM xmfl_t ) x  ON xmfj_t.xmfjent = x.xmflent AND xmfj_t.xmfjdocno  
#        = x.xmfldocno"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_where = "  WHERE xmfjent = xmflent AND xmfjdocno = xmfldocno AND ",tm.wc CLIPPED
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("xmfj_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE axmr070_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE axmr070_x01_curs CURSOR FOR axmr070_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="axmr070_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION axmr070_x01_ins_data()
DEFINE sr RECORD 
   xmfjent LIKE xmfj_t.xmfjent, 
   xmfjsite LIKE xmfj_t.xmfjsite, 
   xmfjdocno LIKE xmfj_t.xmfjdocno, 
   xmfjdocdt LIKE xmfj_t.xmfjdocdt, 
   xmfjstus LIKE xmfj_t.xmfjstus, 
   l_xmfjstus_desc LIKE type_t.chr100, 
   xmfj001 LIKE xmfj_t.xmfj001, 
   l_xmfj001_ooag011 LIKE type_t.chr300, 
   xmfj002 LIKE xmfj_t.xmfj002, 
   l_xmfj002_ooefl003 LIKE type_t.chr1000, 
   xmfj003 LIKE xmfj_t.xmfj003, 
   l_xmfj003_pmaal004 LIKE type_t.chr100, 
   xmfj004 LIKE xmfj_t.xmfj004, 
   ooail_t_ooail003 LIKE ooail_t.ooail003, 
   xmfj005 LIKE xmfj_t.xmfj005, 
   l_xmfj005_desc LIKE oodbl_t.oodbl004, 
   xmfj006 LIKE xmfj_t.xmfj006, 
   xmfj007 LIKE xmfj_t.xmfj007, 
   xmfj008 LIKE xmfj_t.xmfj008, 
   ooibl_t_ooibl004 LIKE ooibl_t.ooibl004, 
   xmfj009 LIKE xmfj_t.xmfj009, 
   t2_oocql004 LIKE oocql_t.oocql004, 
   xmfj010 LIKE xmfj_t.xmfj010, 
   oocql_t_oocql004 LIKE oocql_t.oocql004, 
   xmfj011 LIKE xmfj_t.xmfj011, 
   xmfj012 LIKE xmfj_t.xmfj012, 
   xmflseq LIKE xmfl_t.xmflseq, 
   l_xmfl001_desc LIKE type_t.chr100, 
   xmfl002 LIKE xmfl_t.xmfl002, 
   l_xmfl002_desc LIKE type_t.chr100, 
   l_xmfl002_desc1 LIKE type_t.chr100, 
   xmfl003 LIKE xmfl_t.xmfl003, 
   l_xmfl003_desc LIKE type_t.chr100, 
   l_xmfl005_desc LIKE type_t.chr100, 
   xmfl007 LIKE xmfl_t.xmfl007, 
   xmfl006 LIKE xmfl_t.xmfl006, 
   x_oocal_t_oocal003 LIKE oocal_t.oocal003, 
   xmfl008 LIKE xmfl_t.xmfl008
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE sr1 RECORD
   xmfment       LIKE xmfm_t.xmfment, 
   xmfmdocno     LIKE xmfm_t.xmfmdocno,
   xmfmseq       LIKE xmfm_t.xmfmseq,
   xmfm001       LIKE xmfm_t.xmfm001,
   xmfm002       LIKE xmfm_t.xmfm002,
   xmfm003       LIKE xmfm_t.xmfm003,
   xmfm004       LIKE xmfm_t.xmfm004 
END RECORD
DEFINE l_sql     STRING

    LET l_sql = "SELECT xmfment,xmfmdocno,xmfmseq,xmfm001,xmfm002,xmfm003,xmfm004 ",
                "  FROM xmfm_t                                                    ",
                " WHERE xmfment = ",g_enterprise,"     ",
                "   AND xmfmdocno = ?  AND xmfmseq = ? "
    PREPARE axmr070_x01_subprep FROM l_sql
    DECLARE axmr070_x01_subcurs CURSOR FOR axmr070_x01_subprep
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH axmr070_x01_curs INTO sr.*                               
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
       IF NOT cl_null(sr.xmfl002) AND NOT cl_null(sr.xmfl003) THEN
          CALL s_feature_description(sr.xmfl002,sr.xmfl003)
                          RETURNING g_sub_success,sr.l_xmfl003_desc
       END IF
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.xmfjent,sr.xmfjsite,sr.xmfjdocno,sr.xmfjdocdt,sr.xmfjstus,sr.l_xmfjstus_desc,sr.xmfj001,sr.l_xmfj001_ooag011,sr.xmfj002,sr.l_xmfj002_ooefl003,sr.xmfj003,sr.l_xmfj003_pmaal004,sr.xmfj004,sr.ooail_t_ooail003,sr.xmfj005,sr.l_xmfj005_desc,sr.xmfj006,sr.xmfj007,sr.xmfj008,sr.ooibl_t_ooibl004,sr.xmfj009,sr.t2_oocql004,sr.xmfj010,sr.oocql_t_oocql004,sr.xmfj011,sr.xmfj012,sr.xmflseq,sr.l_xmfl001_desc,sr.xmfl002,sr.l_xmfl002_desc,sr.l_xmfl002_desc1,sr.xmfl003,sr.l_xmfl003_desc,sr.l_xmfl005_desc,sr.xmfl007,sr.xmfl006,sr.x_oocal_t_oocal003,sr.xmfl008
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "axmr070_x01_execute"
          LET g_errparam.code   = SQLCA.sqlcode
          LET g_errparam.popup  = FALSE
          CALL cl_err()       
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
 
       #add-point:ins_data段after_save name="ins_data.after.save"
       OPEN axmr070_x01_subcurs USING sr.xmfjdocno,sr.xmflseq
       FOREACH axmr070_x01_subcurs INTO sr1.*        
          EXECUTE insert_prep1 USING sr1.xmfment,sr1.xmfmdocno,sr1.xmfmseq,
                                     sr1.xmfm001,sr1.xmfm002,sr1.xmfm003,sr1.xmfm004
          IF SQLCA.sqlcode THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.extend = "axmr070_x01_subcurs"
             LET g_errparam.code   = SQLCA.sqlcode 
             LET g_errparam.popup  = FALSE
             CALL cl_err()        
             LET g_rep_success = 'N'
             EXIT FOREACH
          END IF
       END FOREACH
       CLOSE axmr070_x01_subcurs
       #end add-point
       
    END FOREACH
    
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axmr070_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION axmr070_x01_rep_data()
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
 
{<section id="axmr070_x01.other_function" readonly="Y" >}

 
{</section>}
 
