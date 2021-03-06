#該程式未解開Section, 採用最新樣板產出!
{<section id="ainr322_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:5(2016-09-07 16:53:07), PR版次:0005(2016-09-07 17:06:01)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000056
#+ Filename...: ainr322_x01
#+ Description: ...
#+ Creator....: 05423(2015-02-05 15:47:46)
#+ Modifier...: 08172 -SD/PR- 08172
 
{</section>}
 
{<section id="ainr322_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#160905-00007#4   2016/09/05  by 08172       调整系统中无ENT的SQL条件增加ent
#160906-00031#1   2016/09/06  by 08172       调整oocql001
#160907-00047#1   2016/09/07  by 08172       inda108_desc取值逻辑修改
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
 
{<section id="ainr322_x01.main" readonly="Y" >}
PUBLIC FUNCTION ainr322_x01(p_arg1)
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
   LET g_rep_code = "ainr322_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL ainr322_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL ainr322_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL ainr322_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL ainr322_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL ainr322_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="ainr322_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION ainr322_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "indadocno.inda_t.indadocno,indadocdt.inda_t.indadocdt,l_inda109_desc.gzcbl_t.gzcbl004,inda003.inda_t.inda003,l_inda003_desc.ooefl_t.ooefl003,inda001.inda_t.inda001,l_inda001_desc.ooag_t.ooag011,inda101.inda_t.inda101,l_inda101_desc.ooefl_t.ooefl004,l_indastus_desc.gzcbl_t.gzcbl004,indbseq.indb_t.indbseq,indb001.indb_t.indb001,l_imaal003.imaal_t.imaal003,l_imaal004.imaal_t.imaal004,indb003.indb_t.indb003,l_indb003_desc.oocql_t.oocql004,indb005.indb_t.indb005,indb008.indb_t.indb008,indb105.indb_t.indb105,indb106.indb_t.indb106,indb011.indb_t.indb011,indb012.indb_t.indb012,indb151.indb_t.indb151,l_indb151_desc.oocql_t.oocql004,indb107.indb_t.indb107,l_indb107_desc.inayl_t.inayl003,indb108.indb_t.indb108,l_indb108_desc.inab_t.inab003,indb102.indb_t.indb102,l_indb102_desc.inayl_t.inayl003,indb103.indb_t.indb103,l_indb103_desc.inab_t.inab003,indb104.indb_t.indb104,indb101.indb_t.indb101,inda005.inda_t.inda005,inda006.inda_t.inda006,inda007.inda_t.inda007,inda102.inda_t.inda102,inda103.inda_t.inda103,inda104.inda_t.inda104,inda105.inda_t.inda105,inda106.inda_t.inda106,inda107.inda_t.inda107,inda108.inda_t.inda108,inda151.inda_t.inda151,indb013.indb_t.indb013,indb014.indb_t.indb014,indb015.indb_t.indb015,indb016.indb_t.indb016,indb017.indb_t.indb017,l_inda105_desc.type_t.chr30,l_inda106_desc.type_t.chr30,l_inda107_desc.type_t.chr30,l_inda108_desc.type_t.chr30,l_inda151_desc.type_t.chr30,l_address.type_t.chr30,l_indb015_desc.type_t.chr30,l_indb016_desc.type_t.chr30,l_indb017_desc.type_t.chr30,l_inda003desc.type_t.chr50,l_inda105desc.type_t.chr50,l_inda106desc.type_t.chr50,l_inda107desc.type_t.chr50,l_inda108desc.type_t.chr50,l_inda151desc.type_t.chr50,l_indb003desc.type_t.chr50,l_indb015desc.type_t.chr50,l_indb016desc.type_t.chr50,l_indb017desc.type_t.chr50,l_indb102desc.type_t.chr50,l_indb103desc.type_t.chr50,l_indb107desc.type_t.chr50,l_indb108desc.type_t.chr50,l_indb151desc.type_t.chr50,l_imaa127_desc.type_t.chr30,l_imaa127desc.type_t.chr50,l_indadocno_desc.type_t.chr30,l_inda102_desc.type_t.chr30,l_indadocnodesc.type_t.chr50,l_inda001desc.type_t.chr50,l_inda101desc.type_t.chr50,l_indastusdesc.type_t.chr50,l_inda109desc.type_t.chr50,l_inda102desc.type_t.chr50" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="ainr322_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION ainr322_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?, 
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="ainr322_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION ainr322_x01_sel_prep()
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
   #dorislai-20150722-modify----(S)
#   LET g_select = " SELECT DISTINCT indadocno,indadocdt,inda109,NULL,inda003,NULL,inda001,NULL,inda101,NULL,indastus, 
#       NULL,indbseq,indb001,imaal003,imaal004,indb003,NULL,indb005,indb008,indb105,indb106,indb011,indb012,indb151, 
#       NULL,indb107,NULL,indb108,NULL,indb102,NULL,indb103,NULL,indb104,indb101"
   LET g_select = " SELECT DISTINCT indadocno,indadocdt,inda109,NULL,inda003,NULL,inda001,NULL,inda101,NULL,indastus, 
       NULL,indbseq,indb001,imaal003,imaal004,indb003,NULL,indb005,indb008,indb105,indb106,indb011,indb012,indb151, 
       NULL,indb107,NULL,indb108,NULL,indb102,NULL,indb103,NULL,indb104,indb101,inda005,inda006,inda007, 
       inda102,inda103,inda104,inda105,inda106,inda107,inda108,inda151,indb013,indb014,indb015,indb016, 
       indb017,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
       NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL"
    #dorislai-20150722-modify----(E)
#   #end add-point
#   LET g_select = " SELECT indadocno,indadocdt,inda109,NULL,inda003,NULL,inda001,NULL,inda101,NULL,indastus, 
#       NULL,indbseq,indb001,NULL,NULL,indb003,NULL,indb005,indb008,indb105,indb106,indb011,indb012,indb151, 
#       NULL,indb107,NULL,indb108,NULL,indb102,NULL,indb103,NULL,indb104,indb101,inda005,inda006,inda007, 
#       inda102,inda103,inda104,inda105,inda106,inda107,inda108,inda151,indb013,indb014,indb015,indb016, 
#       indb017,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
#       NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
    LET g_from = " FROM inda_t LEFT OUTER JOIN indb_t ON indadocno = indbdocno AND indaent = indbent ",
                 "             LEFT OUTER JOIN imaa_t ON indb001 = imaa001 AND indbent = imaaent ",
                 "             LEFT OUTER JOIN imaal_t ON indb001 = imaal001 AND indbent = imaalent AND imaal002 = '",g_dlang,"' ",
                 "             LEFT OUTER JOIN imaf_t ON indb001 = imaf001 AND indbent = imafent AND indbsite = imafsite "
#   #end add-point
#    LET g_from = " FROM inda_t,indb_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("inda_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE ainr322_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE ainr322_x01_curs CURSOR FOR ainr322_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="ainr322_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION ainr322_x01_ins_data()
DEFINE sr RECORD 
   indadocno LIKE inda_t.indadocno, 
   indadocdt LIKE inda_t.indadocdt, 
   inda109 LIKE inda_t.inda109, 
   l_inda109_desc LIKE gzcbl_t.gzcbl004, 
   inda003 LIKE inda_t.inda003, 
   l_inda003_desc LIKE ooefl_t.ooefl003, 
   inda001 LIKE inda_t.inda001, 
   l_inda001_desc LIKE ooag_t.ooag011, 
   inda101 LIKE inda_t.inda101, 
   l_inda101_desc LIKE ooefl_t.ooefl004, 
   indastus LIKE inda_t.indastus, 
   l_indastus_desc LIKE gzcbl_t.gzcbl004, 
   indbseq LIKE indb_t.indbseq, 
   indb001 LIKE indb_t.indb001, 
   l_imaal003 LIKE imaal_t.imaal003, 
   l_imaal004 LIKE imaal_t.imaal004, 
   indb003 LIKE indb_t.indb003, 
   l_indb003_desc LIKE oocql_t.oocql004, 
   indb005 LIKE indb_t.indb005, 
   indb008 LIKE indb_t.indb008, 
   indb105 LIKE indb_t.indb105, 
   indb106 LIKE indb_t.indb106, 
   indb011 LIKE indb_t.indb011, 
   indb012 LIKE indb_t.indb012, 
   indb151 LIKE indb_t.indb151, 
   l_indb151_desc LIKE oocql_t.oocql004, 
   indb107 LIKE indb_t.indb107, 
   l_indb107_desc LIKE inayl_t.inayl003, 
   indb108 LIKE indb_t.indb108, 
   l_indb108_desc LIKE inab_t.inab003, 
   indb102 LIKE indb_t.indb102, 
   l_indb102_desc LIKE inayl_t.inayl003, 
   indb103 LIKE indb_t.indb103, 
   l_indb103_desc LIKE inab_t.inab003, 
   indb104 LIKE indb_t.indb104, 
   indb101 LIKE indb_t.indb101, 
   inda005 LIKE inda_t.inda005, 
   inda006 LIKE inda_t.inda006, 
   inda007 LIKE inda_t.inda007, 
   inda102 LIKE inda_t.inda102, 
   inda103 LIKE inda_t.inda103, 
   inda104 LIKE inda_t.inda104, 
   inda105 LIKE inda_t.inda105, 
   inda106 LIKE inda_t.inda106, 
   inda107 LIKE inda_t.inda107, 
   inda108 LIKE inda_t.inda108, 
   inda151 LIKE inda_t.inda151, 
   indb013 LIKE indb_t.indb013, 
   indb014 LIKE indb_t.indb014, 
   indb015 LIKE indb_t.indb015, 
   indb016 LIKE indb_t.indb016, 
   indb017 LIKE indb_t.indb017, 
   l_inda105_desc LIKE type_t.chr30, 
   l_inda106_desc LIKE type_t.chr30, 
   l_inda107_desc LIKE type_t.chr30, 
   l_inda108_desc LIKE type_t.chr30, 
   l_inda151_desc LIKE type_t.chr30, 
   l_address LIKE type_t.chr30, 
   l_indb015_desc LIKE type_t.chr30, 
   l_indb016_desc LIKE type_t.chr30, 
   l_indb017_desc LIKE type_t.chr30, 
   l_inda003desc LIKE type_t.chr50, 
   l_inda105desc LIKE type_t.chr50, 
   l_inda106desc LIKE type_t.chr50, 
   l_inda107desc LIKE type_t.chr50, 
   l_inda108desc LIKE type_t.chr50, 
   l_inda151desc LIKE type_t.chr50, 
   l_indb003desc LIKE type_t.chr50, 
   l_indb015desc LIKE type_t.chr50, 
   l_indb016desc LIKE type_t.chr50, 
   l_indb017desc LIKE type_t.chr50, 
   l_indb102desc LIKE type_t.chr50, 
   l_indb103desc LIKE type_t.chr50, 
   l_indb107desc LIKE type_t.chr50, 
   l_indb108desc LIKE type_t.chr50, 
   l_indb151desc LIKE type_t.chr50, 
   l_imaa127_desc LIKE type_t.chr30, 
   l_imaa127desc LIKE type_t.chr50, 
   l_indadocno_desc LIKE type_t.chr30, 
   l_inda102_desc LIKE type_t.chr30, 
   l_indadocnodesc LIKE type_t.chr50, 
   l_inda001desc LIKE type_t.chr50, 
   l_inda101desc LIKE type_t.chr50, 
   l_indastusdesc LIKE type_t.chr50, 
   l_inda109desc LIKE type_t.chr50, 
   l_inda102desc LIKE type_t.chr50
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE  r_success             LIKE type_t.num5

DEFINE  l_oofa001             LIKE oofa_t.oofa001 #營運據點     dorislai-20150722-add----(S)
DEFINE  l_success             LIKE type_t.num5
DEFINE  l_oocq019             LIKE oocq_t.oocq019 #參考欄位16
DEFINE  l_imaa127             LIKE imaa_t.imaa127 #系列         dorislai-20150722-add----(E)

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH ainr322_x01_curs INTO sr.*                               
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
       #資料處理
       #調撥方式inda109
       IF NOT cl_null(sr.inda109) THEN
          CALL ainr322_x01_desc('1','2083',sr.inda109,'') RETURNING sr.l_inda109_desc
          #dorislai-20150804-add----(S)
          LET sr.l_inda109desc = ''
          IF NOT cl_null(sr.l_inda109_desc) THEN
             LET sr.l_inda109desc = sr.inda109,'.',sr.l_inda109_desc
          END IF
          #dorislai-20150804-add----(E)
       END IF
       #撥出營運據點inda003
       IF NOT cl_null(sr.inda003) THEN
          CALL ainr322_x01_desc('6','',sr.inda003,'') RETURNING sr.l_inda003_desc
          #20150724 by dorislai add   (S)
          LET sr.l_inda003desc = ''
          IF NOT cl_null(sr.l_inda003_desc) THEN
             LET sr.l_inda003desc = sr.inda003,'.',sr.l_inda003_desc 
          END IF
          #20150724 by dorislai add   (E)
       END IF
       #申請人員inda001
       IF NOT cl_null(sr.inda001) THEN
          CALL ainr322_x01_desc('5','',sr.inda001,'') RETURNING sr.l_inda001_desc
          #dorislai-20150804-add----(S)
          LET sr.l_inda001desc = ''
          IF NOT cl_null(sr.l_inda001_desc) THEN
             LET sr.l_inda001desc = sr.inda001,'.',sr.l_inda001_desc
          END IF
          #dorislai-20150804-add----(E)
       END IF
       #申請部門inda101
       IF NOT cl_null(sr.inda101) THEN
          CALL ainr322_x01_desc('6','',sr.inda101,'') RETURNING sr.l_inda101_desc
          #dorislai-20150804-add----(S)
          LET sr.l_inda101desc = ''
          IF NOT cl_null(sr.l_inda101_desc) THEN
             LET sr.l_inda101desc = sr.inda101,'.',sr.l_inda101_desc
          END IF
          #dorislai-20150804-add----(E)
       END IF
       #狀態碼indastus
       IF NOT cl_null(sr.indastus) THEN
          CALL ainr322_x01_desc('1','13',sr.indastus,'') RETURNING sr.l_indastus_desc
          #dorislai-20150804-add----(S)
          LET sr.l_indastusdesc = ''
          IF NOT cl_null(sr.l_indastus_desc) THEN
             LET sr.l_indastusdesc = sr.indastus,'.',sr.l_indastus_desc
          END IF
          #dorislai-20150804-add----(E)
       END IF       
       #產品特徴說明indb003
       IF NOT cl_null(sr.indb003) THEN
          CALL s_feature_description(sr.indb001,sr.indb003)
          RETURNING r_success,sr.l_indb003_desc 
          #20150724 by dorislai add----(S)
          LET sr.l_indb003desc = ''
          IF NOT cl_null(sr.l_indb003_desc) THEN
             LET sr.l_indb003desc = sr.indb003,'.',sr.l_indb003_desc    
          END IF 
          #20150724 by dorislai add-----(E)          
       END IF   
       #理由碼indb151
       IF NOT cl_null(sr.indb151) THEN
          CALL ainr322_x01_desc('2','303',sr.indb151,'') RETURNING sr.l_indb151_desc
          #20150724 by dorislai add----(S)
          LET sr.l_indb151desc = ''
          IF NOT cl_null(sr.l_indb151_desc) THEN
             LET sr.l_indb151desc = sr.indb151,'.',sr.l_indb151_desc  
          END IF
          #20150724 by dorislai add----(E)
       END IF
       #撥入庫位indb107
       IF NOT cl_null(sr.indb107) THEN
          CALL ainr322_x01_desc('3','',sr.indb107,'') RETURNING sr.l_indb107_desc
          #20150724 by dorislai add----(S)
          LET sr.l_indb107desc = ''
          IF NOT cl_null(sr.l_indb107_desc) THEN
             LET sr.l_indb107desc = sr.indb107,'.',sr.l_indb107_desc  
          END IF
          #20150724 by dorislai add----(E)
       END IF
       #撥入儲位indb108
       IF NOT cl_null(sr.indb108) THEN
          CALL ainr322_x01_desc('4','',sr.indb107,sr.indb108) RETURNING sr.l_indb108_desc
          #20150724 by dorislai add----(S)
          LET sr.l_indb108desc = ''
          IF NOT cl_null(sr.l_indb108_desc) THEN
             LET sr.l_indb108desc = sr.indb108,'.',sr.l_indb108_desc  
          END IF
          #20150724 by dorislai add----(E)
       END IF
       #限定撥出庫位indb102
       IF NOT cl_null(sr.indb102) THEN
          CALL ainr322_x01_desc('3','',sr.indb102,'') RETURNING sr.l_indb102_desc
          #20150724 by dorislai add----(S)
          LET sr.l_indb102desc = ''
          IF NOT cl_null(sr.l_indb102_desc) THEN
             LET sr.l_indb102desc = sr.indb102,'.',sr.l_indb102_desc  
          END IF
          #20150724 by dorislai add----(E)
       END IF
       #限定撥出儲位indb103
       IF NOT cl_null(sr.indb103) THEN
          CALL ainr322_x01_desc('4','',sr.indb102,sr.indb103) RETURNING sr.l_indb103_desc
          #20150724 by dorislai add----(S)
          LET sr.l_indb103desc = ''
          IF NOT cl_null(sr.l_indb103_desc) THEN
             LET sr.l_indb103desc = sr.indb103,'.',sr.l_indb103_desc  
          END IF
          #20150724 by dorislai add----(E)
       END IF
       
       #dorislai-20150722-add----(S)
       #送貨地址 l_inda105_desc	
           #獲取當前營運據點的聯絡對象識別碼
       LET l_oofa001 = ''
       SELECT oofa001 INTO l_oofa001 FROM oofa_t 
        WHERE oofaent = g_enterprise AND oofa002 = '1' AND oofa003 = g_site
            #送貨地址
       LET sr.l_inda105_desc = ''
       LET sr.l_inda105desc = ''
       SELECT oofb011 INTO sr.l_inda105_desc FROM oofb_t 
        WHERE oofbent = g_enterprise AND oofb002 = l_oofa001  AND oofb019 = sr.inda105
       IF NOT cl_null(sr.l_inda105_desc) THEN
          LET sr.l_inda105desc = sr.inda105,'.',sr.l_inda105_desc
       END IF
       #運輸方式 l_inda106_desc	
       LET sr.l_inda106_desc = ''
       LET sr.l_inda106desc = ''
       SELECT oocql004 INTO sr.l_inda106_desc FROM oocql_t 
        WHERE oocqlent = g_enterprise AND oocql001 = '263' 
          AND oocql002 = sr.inda106 AND oocql003 = g_dlang
       IF NOT cl_null(sr.l_inda106_desc) THEN
          LET sr.l_inda106desc = sr.inda106,'.',sr.l_inda106_desc
       END IF
       #起運地 l_inda107_desc	
       LET sr.l_inda107_desc = ''
       LET sr.l_inda107desc = ''
       #160907-00047#1 -s by 08172 
#       IF NOT cl_null(sr.inda106) THEN
#          SELECT oocq019 INTO l_oocq019
#            FROM oocq_t WHERE oocq001='263' AND oocq002= sr.inda106
#             AND oocqent = g_enterprise   #160905-00007#4 by 08172
#       END IF
#     
#       IF NOT cl_null(l_oocq019) THEN
#          CASE
#             WHEN l_oocq019 ='1' OR l_oocq019 ='4'
#                SELECT oockl005 INTO sr.l_inda107_desc FROM oockl_t 
#                 WHERE oocklent = g_enterprise AND oockl003 = sr.inda107 AND oockl004 = g_dlang
#     
#             WHEN l_oocq019 ='2'
#                SELECT oocql004 INTO sr.l_inda107_desc FROM oocql_t 
#                 WHERE oocqlent = g_enterprise AND oocql002 = sr.inda107
#                   AND oocql001 = '262' AND oocql003 = g_dlang
#     
#             WHEN l_oocq019 ='3'
#                SELECT oocql004 INTO sr.l_inda107_desc FROM oocql_t 
#                 WHERE oocqlent = g_enterprise AND oocql002 = sr.inda107 
#                   AND oocql001 = '276' AND oocql003 = g_dlang
#          END CASE
#       ELSE
#          SELECT oockl005 INTO sr.l_inda107_desc FROM oockl_t 
#           WHERE oocklent = g_enterprise AND oockl003 = sr.inda107 
##             AND oocql001 = '262' AND oockl004 = g_dlang   #160906-00031#1 by 08172
#             AND oockl002 = '262' AND oockl004 = g_dlang    #160906-00031#1 by 08172
#       END IF
       CALL s_apmi011_location_ref(sr.inda106,sr.inda107) RETURNING sr.l_inda107_desc
       #160907-00047#1 -e by 08172 
       IF NOT cl_null(sr.l_inda107_desc) THEN
          LET sr.l_inda107desc = sr.inda107,'.',sr.l_inda107_desc
       END IF
       #目的地 l_inda108_desc	
       LET sr.l_inda108_desc = ''
       LET sr.l_inda108desc = ''
       #160907-00047#1 -s by 08172 
#       IF NOT cl_null(sr.inda106) THEN
#          SELECT oocq019 INTO l_oocq019
#            FROM oocq_t WHERE oocq001='263' AND oocq002= sr.inda106
#             AND oocqent = g_enterprise   #160905-00007#4 by 08172
#       END IF
#     
#       IF NOT cl_null(l_oocq019) THEN
#          CASE
#             WHEN l_oocq019 ='1' OR l_oocq019 ='4'
#                SELECT oockl005 INTO sr.l_inda108_desc FROM oockl_t 
#                 WHERE oocklent = g_enterprise AND oockl003 = sr.inda108 AND oockl004 = g_dlang
#     
#             WHEN l_oocq019 ='2'
#                SELECT oocql004 INTO sr.l_inda108_desc FROM oocql_t 
#                 WHERE oocqlent = g_enterprise AND oocql002 = sr.inda108
#                   AND oocql001 = '262' AND oocql003 = g_dlang
#     
#             WHEN l_oocq019 ='3'
#                SELECT oocql004 INTO sr.l_inda108_desc FROM oocql_t 
#                 WHERE oocqlent = g_enterprise AND oocql002 = sr.inda108 
#                   AND oocql001 = '276' AND oocql003 = g_dlang
#          END CASE
#       ELSE
#          SELECT oockl005 INTO sr.l_inda108_desc FROM oockl_t 
#           WHERE oocklent = g_enterprise AND oockl003 = sr.inda108 
##             AND oocql001 = '262' AND oockl004 = g_dlang   #160906-00031#1 by 08172
#             AND oockl002 = '262' AND oockl004 = g_dlang    #160906-00031#1 by 08172
#       END IF
       CALL s_apmi011_location_ref(sr.inda106,sr.inda108) RETURNING sr.l_inda108_desc
       #160907-00047#1 -e by 08172 
       IF NOT cl_null(sr.l_inda108_desc) THEN
          LET sr.l_inda108desc = sr.inda108,'.',sr.l_inda108_desc
       END IF
       #理由碼 l_inda151_desc	
       LET sr.l_inda151_desc = ''
       LET sr.l_inda151desc = ''
       SELECT oocql004 INTO sr.l_inda151_desc FROM oocql_t 
        WHERE oocqlent = g_enterprise AND oocql001 = '303' AND oocql002 = sr.inda151
       IF NOT cl_null(sr.l_inda151_desc) THEN
          LET sr.l_inda151desc = sr.inda151,'.',sr.l_inda151_desc
       END IF
       #地址 l_address
          #獲取當前營運據點的聯絡對象識別碼
       LET l_oofa001 = ''
       SELECT oofa001 INTO l_oofa001 FROM oofa_t 
        WHERE oofaent = g_enterprise AND oofa002 = '1' AND oofa003 = g_site
        
       LET sr.l_address = ''
       CALL s_aooi350_get_address(l_oofa001,sr.inda105,g_lang) RETURNING l_success,sr.l_address
       #專案編號 l_indb015_desc	
       LET sr.l_indb015_desc = ''
       LET sr.l_indb015desc = ''
       CALL s_desc_get_project_desc(sr.indb015) RETURNING sr.l_indb015_desc
       IF NOT cl_null(sr.l_indb015_desc) THEN
          LET sr.l_indb015desc = sr.indb015,'.',sr.l_indb015_desc
       END IF
       #WBS l_indb016_desc	
       LET sr.l_indb016_desc = ''
       LET sr.l_indb016desc = ''
       CALL s_desc_get_wbs_desc(sr.indb015,sr.indb016) RETURNING sr.l_indb016_desc
       IF NOT cl_null(sr.l_indb016_desc) THEN
          LET sr.l_indb016desc = sr.indb016,'.',sr.l_indb016_desc
       END IF
       #活動編號 l_indb017_desc	
       LET sr.l_indb017_desc = ''
       LET sr.l_indb017desc = ''
       CALL s_desc_get_activity_desc(sr.indb015,sr.indb017) RETURNING sr.l_indb017_desc
       IF NOT cl_null(sr.l_indb017_desc) THEN
          LET sr.l_indb017desc = sr.indb017,'.',sr.l_indb017_desc
       END IF
       #單號全名 l_indadocnodesc 
       LET sr.l_indadocno_desc = ''
       LET sr.l_indadocnodesc = ''
       CALL s_aooi200_get_slip_desc(sr.indadocno) RETURNING sr.l_indadocno_desc
       IF NOT cl_null(sr.l_indadocno_desc) THEN
          LET sr.l_indadocnodesc = sr.indadocno,'.',sr.l_indadocno_desc
       END IF
       #檢驗方式全名 l_inda102desc 
       LET sr.l_inda102_desc = ''
       LET sr.l_inda102desc = ''
       CALL s_desc_gzcbl004_desc('2081',sr.inda102) RETURNING sr.l_inda102_desc
       IF NOT cl_null(sr.l_inda102_desc) THEN
          LET sr.l_inda102desc = sr.inda102,'.',sr.l_inda102_desc
       END IF
       #組合系列&說明
       LET sr.l_imaa127_desc = ''
       LET sr.l_imaa127desc = ''
          #用料號抓取系列
       SELECT imaa127 INTO l_imaa127 FROM imaa_t
        WHERE imaa001 = sr.indb001
          AND imaaent = g_enterprise
         #抓取系列說明
       CALL s_desc_get_acc_desc('2003',l_imaa127)  RETURNING sr.l_imaa127_desc   
       IF NOT cl_null(sr.l_imaa127_desc) THEN
          LET sr.l_imaa127desc = l_imaa127,'.',sr.l_imaa127_desc    
       END IF
       #dorislai-20150722-add----(E)
       
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.indadocno,sr.indadocdt,sr.l_inda109_desc,sr.inda003,sr.l_inda003_desc,sr.inda001,sr.l_inda001_desc,sr.inda101,sr.l_inda101_desc,sr.l_indastus_desc,sr.indbseq,sr.indb001,sr.l_imaal003,sr.l_imaal004,sr.indb003,sr.l_indb003_desc,sr.indb005,sr.indb008,sr.indb105,sr.indb106,sr.indb011,sr.indb012,sr.indb151,sr.l_indb151_desc,sr.indb107,sr.l_indb107_desc,sr.indb108,sr.l_indb108_desc,sr.indb102,sr.l_indb102_desc,sr.indb103,sr.l_indb103_desc,sr.indb104,sr.indb101,sr.inda005,sr.inda006,sr.inda007,sr.inda102,sr.inda103,sr.inda104,sr.inda105,sr.inda106,sr.inda107,sr.inda108,sr.inda151,sr.indb013,sr.indb014,sr.indb015,sr.indb016,sr.indb017,sr.l_inda105_desc,sr.l_inda106_desc,sr.l_inda107_desc,sr.l_inda108_desc,sr.l_inda151_desc,sr.l_address,sr.l_indb015_desc,sr.l_indb016_desc,sr.l_indb017_desc,sr.l_inda003desc,sr.l_inda105desc,sr.l_inda106desc,sr.l_inda107desc,sr.l_inda108desc,sr.l_inda151desc,sr.l_indb003desc,sr.l_indb015desc,sr.l_indb016desc,sr.l_indb017desc,sr.l_indb102desc,sr.l_indb103desc,sr.l_indb107desc,sr.l_indb108desc,sr.l_indb151desc,sr.l_imaa127_desc,sr.l_imaa127desc,sr.l_indadocno_desc,sr.l_inda102_desc,sr.l_indadocnodesc,sr.l_inda001desc,sr.l_inda101desc,sr.l_indastusdesc,sr.l_inda109desc,sr.l_inda102desc
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "ainr322_x01_execute"
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
 
{<section id="ainr322_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION ainr322_x01_rep_data()
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
 
{<section id="ainr322_x01.other_function" readonly="Y" >}

#GET DESC
PRIVATE FUNCTION ainr322_x01_desc(p_class,p_num,p_target,p_target2)
   DEFINE p_class  LIKE type_t.chr2
   DEFINE p_num    LIKE type_t.num5
   DEFINE p_target LIKE type_t.chr20
   DEFINE p_target2 LIKE type_t.chr20
   DEFINE r_desc   LIKE type_t.chr500
   
   CASE p_class
   WHEN '1' #获取SCC码说明
      SELECT gzcbl004 INTO r_desc
        FROM gzcbl_t
       WHERE gzcbl001 = p_num
         AND gzcbl002 = p_target
         AND gzcbl003 = g_dlang
         
   WHEN '2' #获取ACC码说明
      SELECT oocql004 INTO r_desc
        FROM oocql_t
       WHERE oocql001 = p_num
         AND oocql002 = p_target
         AND oocql003 = g_dlang
         AND oocqlent = g_enterprise

   WHEN '3' #获取库位名称
      SELECT inayl003 INTO r_desc
        FROM inayl_t
       WHERE inayl001 = p_target
         AND inayl002 = g_dlang
         AND inaylent = g_enterprise
         
   WHEN '4' #获取储位名称
      SELECT inab003 INTO r_desc
        FROM inab_t
       WHERE inab001 = p_target
         AND inab002 = p_target2
         AND inabsite = g_site
         AND inabent = g_enterprise
         
   WHEN '5' #获取人员名称
      SELECT ooag011 INTO r_desc
        FROM ooag_t
       WHERE ooag001 = p_target
         AND ooagent = g_enterprise
         
   WHEN '6' #获取报工部门名称
      SELECT ooefl003 INTO r_desc
        FROM ooefl_t
       WHERE ooefl001 = p_target
         AND ooefl002 = g_dlang
         AND ooeflent = g_enterprise  

   END CASE
   
   RETURN r_desc 
END FUNCTION

 
{</section>}
 
