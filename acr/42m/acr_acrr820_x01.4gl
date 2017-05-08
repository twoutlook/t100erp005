#該程式未解開Section, 採用最新樣板產出!
{<section id="acrr820_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:1(2016-02-24 11:00:39), PR版次:0001(2016-02-25 10:59:52)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000028
#+ Filename...: acrr820_x01
#+ Description: ...
#+ Creator....: 06189(2015-04-02 16:18:27)
#+ Modifier...: 06189 -SD/PR- 06189
 
{</section>}
 
{<section id="acrr820_x01.global" readonly="Y" >}
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
 
{<section id="acrr820_x01.main" readonly="Y" >}
PUBLIC FUNCTION acrr820_x01(p_arg1)
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
   LET g_rep_code = "acrr820_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL acrr820_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL acrr820_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL acrr820_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL acrr820_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL acrr820_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="acrr820_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION acrr820_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "deba_t_deba002.deba_t.deba002,l_rtab001.type_t.chr500,l_debasite.type_t.chr500,l_deba009_count.type_t.num20,l_inag001_count.type_t.num20,l_deba009_desc.type_t.num20_6,l_deca009_count.type_t.num20,l_deca009_desc.type_t.num20_6,l_deba016_count.type_t.num20,l_imaa009_count.type_t.num20,l_deba016_desc.type_t.num20_6,l_deca016_count.type_t.num20,l_deca016_desc.type_t.num20_6" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="acrr820_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION acrr820_x01_ins_prep()
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
             ?,?,?,?,?,?,?)"
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
 
{<section id="acrr820_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION acrr820_x01_sel_prep()
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
   LET g_select = " SELECT deba_t.deba002,NULL,NULL,0,0,0,0,0,0,0,0,0,0"
 
   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_select = " SELECT deba002,rtab001||'.'||rtaal003,debasite,COUNT(DISTINCT deba009),0,NULL,COUNT(DISTINCT deca009),NULL,COUNT(DISTINCT deba016), 
                    0,NULL,COUNT(DISTINCT deca016),NULL"
   #end add-point
    LET g_from = " FROM rtab_t,deca_t,deba_t,inag_t,imaa_t,rtaal_t,ooefl_t"
 
   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_from = " FROM rtab_t",
                " LEFT JOIN rtaal_t ON rtaalent = rtabent AND rtaal001 =rtab001 AND rtaal002 = '",g_lang,"' ,deba_t",  
                " LEFT JOIN deca_t ON decaent = debaent AND decasite =debasite AND deca002 = deba002 AND deca005 = deba005 ",
                "  AND deca009 = deba009 AND deca010 = deba010 AND deca017 = deba017 AND deca018 = deba018 AND deca019 = deba020",
                " LEFT JOIN ooefl_t ON ooeflent = debaent AND ooefl001 =debasite AND ooefl002 = '",g_lang,"' "
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   LET g_where = " WHERE debasite = rtab002 AND debaent = rtabent ", 
                 "   AND EXISTS (SELECT 1 FROM rtaa_t WHERE rtaaent = rtabent AND rtaa001 = rtab001 AND rtaastus = 'Y')", 
                 "   AND debaent = ",g_enterprise,                 
                 "   AND ",tm.wc CLIPPED                
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("rtab_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = g_sql," GROUP BY deba002,rtab001||'.'||rtaal003,debasite "
   #end add-point
   PREPARE acrr820_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE acrr820_x01_curs CURSOR FOR acrr820_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="acrr820_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION acrr820_x01_ins_data()
DEFINE sr RECORD 
   deba_t_deba002 LIKE deba_t.deba002, 
   l_rtab001 LIKE type_t.chr500, 
   l_debasite LIKE type_t.chr500, 
   l_deba009_count LIKE type_t.num20, 
   l_inag001_count LIKE type_t.num20, 
   l_deba009_desc LIKE type_t.num20_6, 
   l_deca009_count LIKE type_t.num20, 
   l_deca009_desc LIKE type_t.num20_6, 
   l_deba016_count LIKE type_t.num20, 
   l_imaa009_count LIKE type_t.num20, 
   l_deba016_desc LIKE type_t.num20_6, 
   l_deca016_count LIKE type_t.num20, 
   l_deca016_desc LIKE type_t.num20_6
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_ooefl003 LIKE ooefl_t.ooefl003
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH acrr820_x01_curs INTO sr.*                               
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
       #仓库品项数 
       SELECT COUNT(DISTINCT inag001)
         INTO sr.l_inag001_count       
         FROM inag_t   #库存明细表
        WHERE inag009 > 0
          AND inagsite = sr.l_debasite
          AND inagent = g_enterprise
       #仓库品类数
       SELECT COUNT(DISTINCT imaa009)
         INTO sr.l_imaa009_count       
         FROM inag_t,imaa_t   #库存明细表
        WHERE inag001=imaa001 
          AND inagent = imaaent
          AND inagent = g_enterprise
          AND inag009 > 0
          AND inagsite = sr.l_debasite 
       #门店商品动销率=门店动销品项数/门店仓库品项数×100%
       LET sr.l_deba009_desc = sr.l_deba009_count/sr.l_inag001_count 
       #LET sr.l_deba009_desc = sr.l_deba009_desc,"%"
       #门店会员商品动销率=门店会员动销品项数/门店仓库品项数×100%
       LET sr.l_deca009_desc = sr.l_deca009_count/sr.l_inag001_count 
       #LET sr.l_deca009_desc = sr.l_deca009_desc,"%"
       #门店品类动销率=门店动销品类数/门店仓库品类数×100%
       LET sr.l_deba016_desc = sr.l_deba016_count/sr.l_imaa009_count 
       #LET sr.l_deba016_desc = sr.l_deba016_desc,"%"
       #门店会员商品动销率=门店会员动销品类数/门店仓库品类数×100%
       LET sr.l_deca016_desc = sr.l_deca016_count/sr.l_imaa009_count 
       #LET sr.l_deca016_desc = sr.l_deca016_desc,"%"
       #add by geza 20160224(S)
       #查出门店名称
       SELECT ooefl003 INTO l_ooefl003
         FROM ooefl_t
        WHERE ooeflent = g_enterprise
          AND ooefl001 = sr.l_debasite 
          AND ooefl002 = g_lang    
       LET sr.l_debasite = sr.l_debasite,'.',l_ooefl003      
       #如果有栏位只显示. ,则清空
       IF sr.l_rtab001 = ' .' THEN
          LET sr.l_rtab001 = ''
       END IF
       IF sr.l_debasite = ' .' THEN
          LET sr.l_debasite = ''
       END IF      
       #add by geza 20160224(E)       
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.deba_t_deba002,sr.l_rtab001,sr.l_debasite,sr.l_deba009_count,sr.l_inag001_count,sr.l_deba009_desc,sr.l_deca009_count,sr.l_deca009_desc,sr.l_deba016_count,sr.l_imaa009_count,sr.l_deba016_desc,sr.l_deca016_count,sr.l_deca016_desc
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "acrr820_x01_execute"
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
 
{<section id="acrr820_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION acrr820_x01_rep_data()
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
 
{<section id="acrr820_x01.other_function" readonly="Y" >}

 
{</section>}
 
