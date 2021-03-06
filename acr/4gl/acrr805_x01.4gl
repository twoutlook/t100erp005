#該程式未解開Section, 採用最新樣板產出!
{<section id="acrr805_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2016-03-15 14:46:47), PR版次:0001(2016-03-17 11:15:29)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000026
#+ Filename...: acrr805_x01
#+ Description: ...
#+ Creator....: 02003(2016-03-04 15:25:08)
#+ Modifier...: 02003 -SD/PR- 02003
 
{</section>}
 
{<section id="acrr805_x01.global" readonly="Y" >}
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
       wc STRING,                  #where condition 
       date LIKE type_t.dat,         #销售日期 
       ceng LIKE rtax_t.rtax004          #品类层数
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="acrr805_x01.main" readonly="Y" >}
PUBLIC FUNCTION acrr805_x01(p_arg1,p_arg2,p_arg3)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.dat         #tm.date  销售日期 
DEFINE  p_arg3 LIKE rtax_t.rtax004         #tm.ceng  品类层数
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.date = p_arg2
   LET tm.ceng = p_arg3
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "acrr805_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL acrr805_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL acrr805_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL acrr805_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL acrr805_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL acrr805_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="acrr805_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION acrr805_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "debp002.debp_t.debp002,l_rtab001_desc.type_t.chr100,l_debpsite.type_t.chr100,l_rtax001.type_t.chr100,l_sum_debo010.type_t.num20_6,l_sum_debo014.type_t.num20_6,l_sum_debo005.type_t.num20_6,l_sum_debo016.type_t.num20_6,l_debo005_debo016.type_t.num20_6,l_debo010_debo016.type_t.num20_6,l_sum_debp012.type_t.num20_6,l_debp012_debo010.type_t.num20_6,l_sum_debp013.type_t.num20_6,l_debp013_debo014.type_t.num20_6,l_sum_debp007.type_t.num20_6,l_debp007_debo005.type_t.num20_6,l_sum_debp016.type_t.num20_6,l_debp016_debo016.type_t.num20_6,l_debp012_debp016.type_t.num20_6,l_pro1.type_t.num20_6,l_debp007_debp016.type_t.num20_6,l_pro2.type_t.num20_6" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="acrr805_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION acrr805_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="acrr805_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION acrr805_x01_sel_prep()
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
   LET g_select = " SELECT debp002,debpsite,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL, 
       NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   #140212-00001#60 add by yangxf 20160304 (S)
   LET tm.wc = cl_replace_str(tm.wc,'debs','debw')
   IF tm.ceng = '0' THEN 
      #                       日期,   销售组织 ,店群,品类
      LET g_select = " SELECT debw002,debwsite,rtab001,'',debw005, "
   ELSE
      #                       日期,   销售组织 ,店群,品类
      LET g_select = " SELECT debw002,debwsite,rtab001,'',rtaw001, "
   END IF 
                     #消费金额
   LET g_select = g_select," SUM(coalesce(debw016, 0)) , ",
                     #毛利
                     " SUM(coalesce(debw017, 0)) , ",
                     #销售数量
                     " SUM(coalesce(debw011, 0)) , ",
                     #消费次数
                     " SUM(coalesce(debw019, 0)) , ",
                     #客单价
                     " CASE SUM(coalesce(debw019, 0)) WHEN 0 THEN 0 ELSE SUM(debw016) / SUM(debw019)  END ,",
                     #客单量
                     " CASE SUM(coalesce(debw019, 0)) WHEN 0 THEN 0 ELSE SUM(debw011) / SUM(debw019)  END ,",
                     " '','','','','','' "
   #140212-00001#60 add by yangxf 20160304 (E)
   #end add-point
    LET g_from = " FROM debp_t,rtab_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
    IF tm.ceng = '0' THEN 
       LET g_from = " FROM debw_t LEFT JOIN rtab_t ON rtabent=debwent AND rtab002=debwsite "
    ELSE
       LET g_from = " FROM rtaw_t,debw_t LEFT JOIN rtab_t ON rtabent=debwent AND rtab002=debwsite "
    END IF 
    LET g_from = g_from,"    AND EXISTS (SELECT 1 FROM rtak_t WHERE rtakent = rtabent AND rtak001 = rtab001 AND rtak002 = '1' AND rtak003 = 'Y') "
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
    LET g_where = " WHERE " ,tm.wc CLIPPED,
                  "   AND debwent='",g_enterprise,"'"
    IF NOT cl_null(tm.date) THEN
       LET g_where=g_where CLIPPED," AND debw002='",tm.date,"'"
    END IF
    IF tm.ceng = '0' THEN 
       LET g_where = g_where," AND EXISTS(SELECT 1 FROM rtax_t WHERE rtaxent = debwent AND rtax001 = debw005 AND rtax005 = '0') "
    ELSE
       LET g_where = g_where," AND rtawent = debwent AND rtaw003 = '",tm.ceng,"' AND rtaw002 = debw005 "
    END IF 
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("debp_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = cl_replace_str(g_sql,'debp','debw')
   IF tm.ceng = '0' THEN 
      LET g_sql=g_sql CLIPPED," GROUP BY debw002,rtab001,debwsite,debw005 "
   ELSE
      LET g_sql=g_sql CLIPPED," GROUP BY debw002,rtab001,debwsite,rtaw001 "
   END IF 
   #end add-point
   PREPARE acrr805_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE acrr805_x01_curs CURSOR FOR acrr805_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="acrr805_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION acrr805_x01_ins_data()
DEFINE sr RECORD 
   debp002 LIKE debp_t.debp002, 
   debpsite LIKE debp_t.debpsite, 
   l_rtab001_desc LIKE type_t.chr100, 
   l_debpsite LIKE type_t.chr100, 
   l_rtax001 LIKE type_t.chr100, 
   l_sum_debo010 LIKE type_t.num20_6, 
   l_sum_debo014 LIKE type_t.num20_6, 
   l_sum_debo005 LIKE type_t.num20_6, 
   l_sum_debo016 LIKE type_t.num20_6, 
   l_debo005_debo016 LIKE type_t.num20_6, 
   l_debo010_debo016 LIKE type_t.num20_6, 
   l_sum_debp012 LIKE type_t.num20_6, 
   l_debp012_debo010 LIKE type_t.num20_6, 
   l_sum_debp013 LIKE type_t.num20_6, 
   l_debp013_debo014 LIKE type_t.num20_6, 
   l_sum_debp007 LIKE type_t.num20_6, 
   l_debp007_debo005 LIKE type_t.num20_6, 
   l_sum_debp016 LIKE type_t.num20_6, 
   l_debp016_debo016 LIKE type_t.num20_6, 
   l_debp012_debp016 LIKE type_t.num20_6, 
   l_pro1 LIKE type_t.num20_6, 
   l_debp007_debp016 LIKE type_t.num20_6, 
   l_pro2 LIKE type_t.num20_6
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_rtaal003     LIKE rtaal_t.rtaal003
DEFINE l_ooefl003     LIKE ooefl_t.ooefl003
DEFINE l_rtaxl003     LIKE rtaxl_t.rtaxl003
DEFINE l_sql          STRING 
DEFINE l_from         STRING
DEFINE l_where        STRING 
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"

                #会员消费金额
    LET l_sql = " SELECT SUM(coalesce(debx017,0)) ,",
                #会员毛利额
                " SUM(coalesce(debx018,0)) ,",
                #会员销售数量
                " SUM(coalesce(debx012,0)) ,",
                #会员消费次数
                " SUM(coalesce(debx021,0)) ,",
                #会员客单价
                " CASE SUM(coalesce(debx021,0)) WHEN 0 THEN 0 ELSE SUM(debx017)/SUM(debx021) END, ",
                #会员客单量
                " CASE SUM(coalesce(debx021,0)) WHEN 0 THEN 0 ELSE SUM(debx012)/SUM(debx021) END  "
    LET l_where = " WHERE debxent = ",g_enterprise,
                  "   AND debx010 <> ' ' ",
                  "   AND debx002 =  ? ",
                  "   AND debxsite = ? "
    IF tm.ceng = '0' THEN
       LET l_from = " FROM debx_t "
       LET l_where = l_where," AND debx005 = ? "
    ELSE
       LET l_from = " FROM debx_t,rtaw_t "
       LET l_where = l_where," AND rtawent = debxent AND rtaw002 = debx005 AND rtaw001 = ? "
    END IF 
    LET l_sql = l_sql,l_from,l_where
    PREPARE acrr805_sel FROM l_sql
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH acrr805_x01_curs INTO sr.*                               
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
       EXECUTE acrr805_sel USING sr.debp002,sr.debpsite,sr.l_rtax001 
       INTO sr.l_sum_debp012,sr.l_sum_debp013,sr.l_sum_debp007,sr.l_sum_debp016,sr.l_debp012_debp016,sr.l_debp007_debp016
       #会员消费金额占比
       LET sr.l_debp012_debo010 = sr.l_sum_debp012/sr.l_sum_debo010
       #会员毛利额占比
       LET sr.l_debp013_debo014 = sr.l_sum_debp013/sr.l_sum_debo014
       #会员销售数量占比
       LET sr.l_debp007_debo005 = sr.l_sum_debp007/sr.l_sum_debo005
       #会员消费次数占比
       LET sr.l_debp016_debo016 = sr.l_sum_debp016/sr.l_sum_debo016
       #会员客单价占比
       LET sr.l_pro1 = sr.l_debp012_debp016/sr.l_debo005_debo016
       #会员客单量占比
       LET sr.l_pro2 = sr.l_debp007_debp016/sr.l_debo010_debo016
       
       #店群编号+店群名称
       IF NOT cl_null(sr.l_rtab001_desc) THEN
          LET l_rtaal003=''
          SELECT rtaal003 INTO l_rtaal003
            FROM rtaal_t
           WHERE rtaalent=g_enterprise
             AND rtaal001=sr.l_rtab001_desc
             AND rtaal002=g_dlang
          IF NOT cl_null(l_rtaal003) THEN
             LET sr.l_rtab001_desc=sr.l_rtab001_desc||'.'||l_rtaal003
          END IF
       END IF
       
       #门店编号+门店名称
       IF NOT cl_null(sr.debpsite) THEN
          LET l_ooefl003=''
          SELECT ooefl003 INTO l_ooefl003
            FROM ooefl_t
           WHERE ooeflent=g_enterprise
             AND ooefl001=sr.debpsite
             AND ooefl002=g_dlang
          IF NOT cl_null(l_ooefl003) THEN
             LET sr.l_debpsite=sr.debpsite||'.'||l_ooefl003
          END IF
       END IF
       IF NOT cl_null(sr.l_rtax001) THEN 
          LET l_rtaxl003 = ''
          SELECT rtaxl003 INTO l_rtaxl003
            FROM rtaxl_t
           WHERE rtaxlent = g_enterprise
             AND rtaxl001 = sr.l_rtax001
             AND rtaxl002 = g_dlang
          IF NOT cl_null(l_rtaxl003) THEN 
             LET sr.l_rtax001 = sr.l_rtax001||'.'||l_rtaxl003
          END IF 
       END IF 
       
       
       
       
#140212-00001#60 mark by yangxf 20160304 (S)
#       #门店客单量#门店客单价
#       IF sr.l_sum_debo016<>0 THEN
#          #门店客单量
#          LET sr.l_debo005_debo016=sr.l_sum_debo005/sr.l_sum_debo016
#          
#          #门店客单价
#          LET sr.l_debo010_debo016=sr.l_sum_debo010/sr.l_sum_debo016        
#       END IF
#       IF cl_null(sr.l_debo005_debo016) THEN LET sr.l_debo005_debo016=0 END IF
#       IF cl_null(sr.l_debo010_debo016) THEN LET sr.l_debo010_debo016=0 END IF
#       
#       #会员消费金额 会员毛利额 会员销售数量 会员销售次数      
#       SELECT SUM(NVL(debp012,0)), #会员消费金额
#              SUM(NVL(debp013,0)), #会员毛利额
#              SUM(NVL(debp007,0)), #会员销售数量
#              SUM(NVL(debp016,0))  #会员消费次数   
#         INTO sr.l_sum_debp012,sr.l_sum_debp013,sr.l_sum_debp007,sr.l_sum_debp016  
#         FROM debp_t
#        WHERE debpent=g_enterprise
#          AND debpsite=sr.debpsite
#          AND debp002=sr.debp002
#          
#       #会员客单量#会员客单价
#       IF sr.l_sum_debp016<>0 THEN
#          #会员客单量
#          LET sr.l_debp007_debp016=sr.l_sum_debp007/sr.l_sum_debp016
#          
#          #会员客单价
#          LET sr.l_debp012_debp016=sr.l_sum_debp012/sr.l_sum_debp016       
#       END IF 
#       IF cl_null(sr.l_debp007_debp016) THEN LET sr.l_debp007_debp016=0 END IF
#       IF cl_null(sr.l_debp012_debp016) THEN LET sr.l_debp012_debp016=0 END IF
#       
#       #会员消费金额占比=会员消费金额/消费金额×100%
#       #会员毛利额占比=会员毛利额/毛利额×100%
#       #会员销售数量占比=会员销售数量/销售数量×100%
#       #会员消费次数占比=会员消费次数/消费次数×100%
#       #会员客单价占比=会员客单价/客单价×100%
#       #会员客单量占比=会员客单量/客单量×100% 
#       
#       #会员消费金额占比
#       IF sr.l_sum_debo010<>0 THEN
#          LET sr.l_debp012_debo010=sr.l_sum_debp012/sr.l_sum_debo010*100  
#       END IF
#       #会员毛利额占比
#       IF sr.l_sum_debo014<>0 THEN
#          LET sr.l_debp013_debo014=sr.l_sum_debp013/sr.l_sum_debo014*100  
#       END IF
#       #会员销售数量占比
#       IF sr.l_sum_debo005<>0 THEN
#          LET sr.l_debp007_debo005=sr.l_sum_debp007/sr.l_sum_debo005*100  
#       END IF
#       #会员消费次数占比   
#       IF sr.l_sum_debo016<>0 THEN     
#          LET sr.l_debp016_debo016=sr.l_sum_debp016/sr.l_sum_debo016*100
#       END IF
#       #会员客单价占比
#       IF sr.l_debo010_debo016<>0 THEN
#          LET sr.l_pro1=sr.l_debp012_debp016/sr.l_debo010_debo016*100
#       END IF          
#       #会员客单量占比
#       IF sr.l_debo005_debo016<>0 THEN       
#          LET sr.l_pro2=sr.l_debp007_debp016/sr.l_debo005_debo016*100
#       END IF          
#140212-00001#60 mark by yangxf 20160304 (E)
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.debp002,sr.l_rtab001_desc,sr.l_debpsite,sr.l_rtax001,sr.l_sum_debo010,sr.l_sum_debo014,sr.l_sum_debo005,sr.l_sum_debo016,sr.l_debo005_debo016,sr.l_debo010_debo016,sr.l_sum_debp012,sr.l_debp012_debo010,sr.l_sum_debp013,sr.l_debp013_debo014,sr.l_sum_debp007,sr.l_debp007_debo005,sr.l_sum_debp016,sr.l_debp016_debo016,sr.l_debp012_debp016,sr.l_pro1,sr.l_debp007_debp016,sr.l_pro2
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "acrr805_x01_execute"
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
 
{<section id="acrr805_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION acrr805_x01_rep_data()
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
 
{<section id="acrr805_x01.other_function" readonly="Y" >}

 
{</section>}
 
