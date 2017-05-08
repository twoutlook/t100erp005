#該程式未解開Section, 採用最新樣板產出!
{<section id="ainr841_x03.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:2(2016-05-11 00:00:30), PR版次:0002(2016-05-11 09:12:27)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000038
#+ Filename...: ainr841_x03
#+ Description: ...
#+ Creator....: 05423(2015-10-13 14:34:15)
#+ Modifier...: 05423 -SD/PR- 05423
 
{</section>}
 
{<section id="ainr841_x03.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#160504-00019#5 2016-05-10 By zhujing 添加参考栏位资料   
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
       pr1 LIKE type_t.chr2,         #包含未盤點 
       pr2 LIKE type_t.chr2          #包含無差異
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="ainr841_x03.main" readonly="Y" >}
PUBLIC FUNCTION ainr841_x03(p_arg1,p_arg2,p_arg3)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr2         #tm.pr1  包含未盤點 
DEFINE  p_arg3 LIKE type_t.chr2         #tm.pr2  包含無差異
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.pr1 = p_arg2
   LET tm.pr2 = p_arg3
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "ainr841_x03"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL ainr841_x03_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL ainr841_x03_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL ainr841_x03_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL ainr841_x03_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL ainr841_x03_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="ainr841_x03.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION ainr841_x03_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "inpd008.inpd_t.inpd008,inpddocno.inpd_t.inpddocno,inpdseq.inpd_t.inpdseq,inpd001.inpd_t.inpd001,imaal003.imaal_t.imaal003,imaal004.imaal_t.imaal004,l_inpd002_desc.type_t.chr50,l_inpd005_desc.inayl_t.inayl003,l_inpd006_desc.inab_t.inab003,inpd007.inpd_t.inpd007,inpd003.inpd_t.inpd003,inpd010.inpd_t.inpd010,inpd011.inpd_t.inpd011,l_first_count.inpd_t.inpd030,l_second_count.inpd_t.inpd030,l_diff_amount.inpd_t.inpd030,l_count_sum.inpd_t.inpd030,inpd012.inpd_t.inpd012,inpd013.inpd_t.inpd013,l_first_count_1.inpd_t.inpd030,l_second_count_1.inpd_t.inpd030,l_diff_amount_1.inpd_t.inpd030,l_count_sum_1.inpd_t.inpd030" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="ainr841_x03.ins_prep" readonly="Y" >}
PRIVATE FUNCTION ainr841_x03_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="ainr841_x03.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION ainr841_x03_sel_prep()
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
   LET g_select = " SELECT DISTINCT inpd008,inpddocno,inpdseq,inpd001,imaal003,imaal004,inpd002,NULL,inpd005,  ",
                  " trim(inpd005)||'.'||trim(inayl003),inpd006,trim(inpd006)||'.'||trim(inab003),inpd007,",
                  " inpd003,inpd010,inpd011,COALESCE(inpd036,inpd030),COALESCE(inpd056,inpd050),NULL,NULL," ,
                  " inpd012,inpd013,COALESCE(inpd037,inpd031),COALESCE(inpd057,inpd051),NULL,NULL" #160504-00019#5
#   #end add-point
#   LET g_select = " SELECT inpd008,inpddocno,inpdseq,inpd001,imaal003,imaal004,inpd002,NULL,inpd005, 
#       NULL,inpd006,NULL,inpd007,inpd003,inpd010,inpd011,NULL,NULL,NULL,NULL,inpd012,inpd013,NULL,NULL, 
#       NULL,NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_from = " FROM inpd_t LEFT OUTER JOIN imaal_t ON inpd001 = imaal001 AND inpdent = imaalent AND imaal002 = '",g_dlang,"' ",
                "             LEFT OUTER JOIN inayl_t ON inpd005 = inayl001 AND inpdent = inaylent AND inayl002 = '",g_dlang,"' ",
                "             LEFT OUTER JOIN inab_t ON inpd005 = inab001 AND inpd006 = inab002 AND inpdent = inabent AND inpdsite = inabsite ",
                "             LEFT OUTER JOIN ooag_t a ON inpd034 = a.ooag001 AND inpdent = a.ooagent ",
                "             LEFT OUTER JOIN ooag_t b ON inpd040 = b.ooag001 AND inpdent = b.ooagent "
#   #end add-point
#    LET g_from = " FROM inpd_t,imaal_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("inpd_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE ainr841_x03_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE ainr841_x03_curs CURSOR FOR ainr841_x03_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="ainr841_x03.ins_data" readonly="Y" >}
PRIVATE FUNCTION ainr841_x03_ins_data()
DEFINE sr RECORD 
   inpd008 LIKE inpd_t.inpd008, 
   inpddocno LIKE inpd_t.inpddocno, 
   inpdseq LIKE inpd_t.inpdseq, 
   inpd001 LIKE inpd_t.inpd001, 
   imaal003 LIKE imaal_t.imaal003, 
   imaal004 LIKE imaal_t.imaal004, 
   inpd002 LIKE inpd_t.inpd002, 
   l_inpd002_desc LIKE type_t.chr50, 
   inpd005 LIKE inpd_t.inpd005, 
   l_inpd005_desc LIKE inayl_t.inayl003, 
   inpd006 LIKE inpd_t.inpd006, 
   l_inpd006_desc LIKE inab_t.inab003, 
   inpd007 LIKE inpd_t.inpd007, 
   inpd003 LIKE inpd_t.inpd003, 
   inpd010 LIKE inpd_t.inpd010, 
   inpd011 LIKE inpd_t.inpd011, 
   l_first_count LIKE inpd_t.inpd030, 
   l_second_count LIKE inpd_t.inpd030, 
   l_diff_amount LIKE inpd_t.inpd030, 
   l_count_sum LIKE inpd_t.inpd030, 
   inpd012 LIKE inpd_t.inpd012, 
   inpd013 LIKE inpd_t.inpd013, 
   l_first_count_1 LIKE inpd_t.inpd030, 
   l_second_count_1 LIKE inpd_t.inpd030, 
   l_diff_amount_1 LIKE inpd_t.inpd030, 
   l_count_sum_1 LIKE inpd_t.inpd030
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_success        LIKE type_t.num5
DEFINE l_1              LIKE inpd_t.inpd036
DEFINE l_2              LIKE inpd_t.inpd036 
DEFINE l_3              LIKE inpd_t.inpd036 #160504-00019#5 add
DEFINE l_4              LIKE inpd_t.inpd036 #160504-00019#5 add
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH ainr841_x03_curs INTO sr.*                               
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
       #产品特征
       IF NOT cl_null(sr.inpd001) AND NOT cl_null(sr.inpd002) THEN
          CALL s_feature_description(sr.inpd001,sr.inpd002) RETURNING l_success,sr.l_inpd002_desc   
       END IF
       #库位
       IF sr.l_inpd005_desc = '.' THEN
          LET sr.l_inpd005_desc = sr.inpd005
       END IF
       #储位
       IF sr.l_inpd006_desc = '.' THEN
          LET sr.l_inpd006_desc = sr.inpd006
       END IF
       #初/复盘差异数量
       LET l_1 = -1
       LET l_2 = -1
       IF NOT cl_null(sr.l_first_count) THEN
          LET l_1 = sr.l_first_count
       END IF
       IF NOT cl_null(sr.l_second_count) THEN
          LET l_2 = sr.l_second_count
       END IF
       IF NOT cl_null(sr.l_first_count) AND NOT cl_null(sr.l_second_count) THEN
          LET sr.l_diff_amount = sr.l_second_count - sr.l_first_count
       END IF
       #盘盈亏数量：
       IF NOT cl_null(sr.l_second_count) THEN      #复盘数量不為空
          LET sr.l_count_sum = sr.l_second_count - sr.inpd011       #盘盈亏数量=复盘数量-库存数量
       ELSE
          IF NOT cl_null(sr.l_first_count) THEN  #初盘数量不為空
             LET sr.l_count_sum = sr.l_first_count - sr.inpd011    #盘盈亏数量=初盘数量-库存数量
          END IF
       END IF
       #160504-00019#5 add-(S)
       #参考单位初/复盘差异数量
       LET l_3 = -1
       LET l_4 = -1
       IF NOT cl_null(sr.l_first_count_1) THEN
          LET l_3 = sr.l_first_count_1
       END IF
       IF NOT cl_null(sr.l_second_count_1) THEN
          LET l_4 = sr.l_second_count_1
       END IF
       IF NOT cl_null(sr.l_first_count_1) AND NOT cl_null(sr.l_second_count_1) THEN
          LET sr.l_diff_amount_1 = sr.l_second_count_1 - sr.l_first_count_1
       END IF
       #参考单位盘盈亏数量：
       IF NOT cl_null(sr.l_second_count_1) THEN      #复盘数量不為空
          LET sr.l_count_sum_1 = sr.l_second_count_1 - sr.inpd013       #参考单位盘盈亏数量=参考单位复盘数量-参考单位库存数量
       ELSE
          IF NOT cl_null(sr.l_first_count_1) THEN  #初盘数量不為空
             LET sr.l_count_sum_1 = sr.l_first_count_1 - sr.inpd013    #参考单位盘盈亏数量=参考单位初盘数量-参考单位库存数量
          END IF
       END IF
       #160504-00019#5 add-(E)
       #判断是否包含无差异数据
#       IF tm.pr2 = 'N' AND (l_1 == l_2) THEN #160504-00019#5 mod
       IF tm.pr2 = 'N' AND (l_1 == l_2) AND (l_3 == l_4) THEN #160504-00019#5 mod       
          CONTINUE FOREACH
       END IF
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.inpd008,sr.inpddocno,sr.inpdseq,sr.inpd001,sr.imaal003,sr.imaal004,sr.l_inpd002_desc,sr.l_inpd005_desc,sr.l_inpd006_desc,sr.inpd007,sr.inpd003,sr.inpd010,sr.inpd011,sr.l_first_count,sr.l_second_count,sr.l_diff_amount,sr.l_count_sum,sr.inpd012,sr.inpd013,sr.l_first_count_1,sr.l_second_count_1,sr.l_diff_amount_1,sr.l_count_sum_1
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "ainr841_x03_execute"
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
 
{<section id="ainr841_x03.rep_data" readonly="Y" >}
PRIVATE FUNCTION ainr841_x03_rep_data()
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
 
{<section id="ainr841_x03.other_function" readonly="Y" >}

 
{</section>}
 
