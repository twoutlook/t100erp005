#該程式未解開Section, 採用最新樣板產出!
{<section id="aslr512_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2017-01-22 10:58:16), PR版次:0003(2017-01-22 10:59:34)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000000
#+ Filename...: aslr512_x01
#+ Description: ...
#+ Creator....: 06840(2016-12-20 20:28:24)
#+ Modifier...: 05423 -SD/PR- 05423
 
{</section>}
 
{<section id="aslr512_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#170120-00054#1   2017/01/20 By zhujing  调整系统中无ENT的SQL条件增加ent
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
 
{<section id="aslr512_x01.main" readonly="Y" >}
PUBLIC FUNCTION aslr512_x01(p_arg1)
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
   LET g_rep_code = "aslr512_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL aslr512_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL aslr512_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL aslr512_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL aslr512_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL aslr512_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="aslr512_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION aslr512_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "l_xmdk000.type_t.chr100,xmdkdocno.xmdk_t.xmdkdocno,xmdkdocdt.xmdk_t.xmdkdocdt,xmdk001.xmdk_t.xmdk001,l_xmdkstus.type_t.chr100,xmdlseq.xmdl_t.xmdlseq,xmdl008.xmdl_t.xmdl008,l_imaal003.type_t.chr30,l_disc.type_t.num15_3,xmdl225.xmdl_t.xmdl225,xmdl224.xmdl_t.xmdl224,xmdksite.xmdk_t.xmdksite,l_ooefl003.type_t.chr30,xmdl014.xmdl_t.xmdl014,l_inayl003.type_t.chr30,xmdk007.xmdk_t.xmdk007,pmaal_t_pmaal003.pmaal_t.pmaal003,xmdl050.xmdl_t.xmdl050,l_xmdl050_desc.type_t.chr1000,l_imaa154.type_t.chr30,rtax_t_rtax006.rtax_t.rtax006,l_rtax006_desc.type_t.chr30,l_imaa133.type_t.chr30,l_imaa133_desc.type_t.chr30,l_imaa132.type_t.chr30,l_imaa132_desc.type_t.chr50,imaa_t_imaa156.imaa_t.imaa156,imaa_t_imaa116.imaa_t.imaa116,l_color.type_t.chr300,l_color_desc.type_t.chr300,l_size.type_t.chr30,l_size_desc.type_t.chr50,xmdl210.xmdl_t.xmdl210,xmdl059.xmdl_t.xmdl059,l_address.type_t.chr1000,xmdk054.xmdk_t.xmdk054,l_xmdl018.xmdl_t.xmdl018,l_xmdl028.xmdl_t.xmdl028,l_price.type_t.num20_6,l_xmdl0181.xmdl_t.xmdl018,l_xmdl0281.xmdl_t.xmdl028,l_price1.type_t.chr30,l_xmdl0182.xmdl_t.xmdl018,l_xmdl0282.xmdl_t.xmdl018,l_price2.type_t.chr30" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="aslr512_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION aslr512_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="aslr512_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aslr512_x01_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
DEFINE g_group       STRING
#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"

   #161219-00010#1 add by cheng 161221 ---s---
#    LET g_select = " SELECT xmdk000,xmdkdocno,xmdkdocdt,xmdk001,xmdkstus,xmdlseq,xmdl008,imaal003,
#       CASE WHEN sum(nvl(xmdl018*imaa116,0))<>0 THEN sum(nvl(xmdl028,0))/sum(nvl(xmdl018*imaa116,0)) ELSE 0 end,xmdl225, 
#       xmdl224,xmdksite,NULL,xmdl014,NULL,xmdk007,pmaal003,xmdl050,NULL,imaa154,rtax006, 
#       NULL,imaa133,NULL,imaa132,NULL,imaa156,imaa116,NULL,NULL,NULL,NULL, 
#       xmdl210,xmdl059,NULL,xmdk054,sum(nvl(xmdl018,0)),sum(nvl(xmdl028,0)),sum(nvl(xmdl018*imaa116,0))"
   #161219-00010#1 add by cheng 161221 ---e---
   #161219-00010#1 mod by sunxh 170109(S)
   LET g_select = " SELECT xmdk000,xmdkdocno,xmdkdocdt,xmdk001,xmdkstus,xmdlseq,xmdl008,imaal003,
                    CASE WHEN sum(nvl(xmdl018*imaa116,0))<>0 THEN sum(nvl(xmdl028,0))/sum(nvl(xmdl018*imaa116,0))
                    ELSE 0 
                    END,
                    xmdl225, xmdl224,xmdksite,NULL,xmdl014,NULL,xmdk007,pmaal003,xmdl050,NULL,imaa154,rtax006, 
                    NULL,imaa133,NULL,imaa132,NULL,imaa156,imaa116,NULL,NULL,NULL,NULL, 
                    xmdl210,xmdl059,NULL,xmdk054,sum(nvl(xmdl018,0)),sum(nvl(xmdl028,0)),sum(nvl(xmdl018*imaa116,0)),
                    sum(CASE WHEN xmdk000='1' OR xmdk000='2' THEN nvl(xmdl018,0)
                        ELSE 0 END),
                    sum(CASE WHEN xmdk000='1' OR xmdk000='2' THEN nvl(xmdl028,0)
                        ELSE 0 END),
                    sum(CASE WHEN xmdk000='1' OR xmdk000='2' THEN nvl(xmdl018*imaa116,0)
                        ELSE 0 END),
                    sum(CASE WHEN xmdk000='6' THEN nvl(xmdl018,0)
                        ELSE 0 END),
                    sum(CASE WHEN xmdk000='6' THEN nvl(xmdl028,0)
                        ELSE 0 END),
                    sum(CASE WHEN xmdk000='6' THEN nvl(xmdl018*imaa116,0)
                        ELSE 0 END) "
   #161219-00010#1 mod by sunxh 170109(E)                 
#   #end add-point
#   LET g_select = " SELECT NULL,xmdkdocno,xmdkdocdt,xmdk001,NULL,xmdlseq,xmdl008,NULL,NULL,xmdl225,xmdl224, 
#       xmdksite,NULL,xmdl014,NULL,xmdk007,pmaal_t.pmaal003,xmdl050,NULL,NULL,rtax_t.rtax006,NULL,NULL, 
#       NULL,NULL,NULL,imaa_t.imaa156,imaa_t.imaa116,NULL,NULL,NULL,NULL,xmdl210,xmdl059,NULL,xmdk054, 
#       NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   #161219-00010#1 add by cheng 161221 ---s---
   LET g_from = " FROM xmdk_t ",
                " LEFT JOIN xmdl_t ON (xmdkent = xmdlent AND xmdkdocno = xmdldocno ) ",
                " LEFT JOIN pmaal_t ON (xmdkent = pmaalent AND xmdk007 = pmaal001 AND pmaal002 = '",g_dlang,"')",
                " LEFT JOIN imaa_t ON (xmdkent = imaaent AND xmdl008 = imaa001 )",
                " LEFT JOIN imaal_t ON (xmdkent = imaalent AND imaa001 = imaal001 AND imaal002 = '",g_dlang,"')",
                " LEFT JOIN rtax_t ON (xmdkent = rtaxent AND imaa009 = rtax001)"
   #161219-00010#1 add by cheng 161221 ---e---
#   #end add-point
#    LET g_from = " FROM xmdk_t,xmdl_t,pmaal_t,imaa_t,rtax_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
 
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   #161219-00010#1 add by cheng 161221 ---s---
   LET g_group = " GROUP BY xmdk000,xmdkdocno,xmdkdocdt,xmdk001,xmdkstus,xmdlseq,xmdl008,imaal003,xmdl225, 
      xmdl224,xmdksite,xmdl014,xmdk007,pmaal003,xmdl050,imaa154,rtax006, imaa133,imaa132,
      imaa156,imaa116, xmdl210,xmdl059,xmdk054 "
   #161219-00010#1 add by cheng 161221 ---e---
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   #161219-00010#1 add by cheng 161221 ---s---
   LET g_where = g_where ,cl_sql_add_filter("xmdk_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_group CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
   #161219-00010#1 add by cheng 161221 ---e---
#   #end add-point:sel_prep.sql.before
#   LET g_where = g_where ,cl_sql_add_filter("xmdk_t")   #資料過濾功能
#   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
#   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
# 
#   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE aslr512_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE aslr512_x01_curs CURSOR FOR aslr512_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="aslr512_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION aslr512_x01_ins_data()
DEFINE sr RECORD 
   l_xmdk000 LIKE type_t.chr100, 
   xmdkdocno LIKE xmdk_t.xmdkdocno, 
   xmdkdocdt LIKE xmdk_t.xmdkdocdt, 
   xmdk001 LIKE xmdk_t.xmdk001, 
   l_xmdkstus LIKE type_t.chr100, 
   xmdlseq LIKE xmdl_t.xmdlseq, 
   xmdl008 LIKE xmdl_t.xmdl008, 
   l_imaal003 LIKE type_t.chr30, 
   l_disc LIKE type_t.num15_3, 
   xmdl225 LIKE xmdl_t.xmdl225, 
   xmdl224 LIKE xmdl_t.xmdl224, 
   xmdksite LIKE xmdk_t.xmdksite, 
   l_ooefl003 LIKE type_t.chr30, 
   xmdl014 LIKE xmdl_t.xmdl014, 
   l_inayl003 LIKE type_t.chr30, 
   xmdk007 LIKE xmdk_t.xmdk007, 
   pmaal_t_pmaal003 LIKE pmaal_t.pmaal003, 
   xmdl050 LIKE xmdl_t.xmdl050, 
   l_xmdl050_desc LIKE type_t.chr1000, 
   l_imaa154 LIKE type_t.chr30, 
   rtax_t_rtax006 LIKE rtax_t.rtax006, 
   l_rtax006_desc LIKE type_t.chr30, 
   l_imaa133 LIKE type_t.chr30, 
   l_imaa133_desc LIKE type_t.chr30, 
   l_imaa132 LIKE type_t.chr30, 
   l_imaa132_desc LIKE type_t.chr50, 
   imaa_t_imaa156 LIKE imaa_t.imaa156, 
   imaa_t_imaa116 LIKE imaa_t.imaa116, 
   l_color LIKE type_t.chr300, 
   l_color_desc LIKE type_t.chr300, 
   l_size LIKE type_t.chr30, 
   l_size_desc LIKE type_t.chr50, 
   xmdl210 LIKE xmdl_t.xmdl210, 
   xmdl059 LIKE xmdl_t.xmdl059, 
   l_address LIKE type_t.chr1000, 
   xmdk054 LIKE xmdk_t.xmdk054, 
   l_xmdl018 LIKE xmdl_t.xmdl018, 
   l_xmdl028 LIKE xmdl_t.xmdl028, 
   l_price LIKE type_t.num20_6, 
   l_xmdl0181 LIKE xmdl_t.xmdl018, 
   l_xmdl0281 LIKE xmdl_t.xmdl028, 
   l_price1 LIKE type_t.chr30, 
   l_xmdl0182 LIKE xmdl_t.xmdl018, 
   l_xmdl0282 LIKE xmdl_t.xmdl018, 
   l_price2 LIKE type_t.chr30
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_xmdl009 LIKE xmdl_t.xmdl009
DEFINE l_num LIKE type_t.num5
DEFINE l_xmdk009 LIKE xmdk_t.xmdk009
DEFINE l_xmdk021 LIKE xmdk_t.xmdk021
DEFINE l_oofb011 LIKE oofb_t.oofb011
DEFINE g_gzcb004 LIKE gzcb_t.gzcb004
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH aslr512_x01_curs INTO sr.*                               
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
       #161219-00010#1 add by cheng 161221 ---s---
       #组织名称
       SELECT ooefl003 INTO sr.l_ooefl003 from ooefl_t WHERE ooefl001=sr.xmdksite AND ooeflent = g_enterprise AND ooefl002 = g_dlang
       #库位名称
       SELECT inayl003 INTO sr.l_inayl003 from inayl_t WHERE inaylent = g_enterprise AND inayl001 = sr.xmdl014 AND inayl002 = g_dlang
       #理由码说明
       LET g_gzcb004 = '280'
       CALL s_desc_get_acc_desc(g_gzcb004,sr.xmdl050) RETURNING sr.l_xmdl050_desc
#       SELECT oocql004 INTO sr.l_xmdl050_desc from oocql_t WHERE oocqlent = g_enterprise AND oocql002 = sr.xmdl050 AND oocql001 = '310' AND oocql003 = g_dlang
       #大类名称
       SELECT rtaxl003 INTO sr.l_rtax006_desc from rtaxl_t WHERE rtaxlent = g_enterprise AND rtaxl001 = sr.rtax_t_rtax006 AND rtaxl002 = g_dlang 
       #季节名称
       SELECT oocql004 INTO sr.l_imaa133_desc from oocql_t WHERE oocqlent = g_enterprise AND oocql002 = sr.l_imaa133 AND oocql001 = '2007' AND oocql003 = g_dlang  
       #产品结构名称
       SELECT oocql004 INTO sr.l_imaa132_desc from oocql_t WHERE oocqlent = g_enterprise AND oocql002 = sr.l_imaa132 AND oocql001 = '2006' AND oocql003 = g_dlang
       #取特征值：颜色和尺码
       LET l_xmdl009 = NULL
       SELECT xmdl009 INTO l_xmdl009 FROM xmdl_t
        WHERE xmdldocno = sr.xmdkdocno
          AND xmdlseq = sr.xmdlseq
          AND xmdlent = g_enterprise   #170120-00054#1 add
       LET l_num = 0
       IF NOT cl_null(l_xmdl009) THEN
          SELECT instr(l_xmdl009,'_',1,1) INTO l_num FROM DUAL
          IF l_num > 0 THEN
             SELECT substr(l_xmdl009 ,1,instr(l_xmdl009 ,'_',1,1)-1) INTO sr.l_color FROM dual  
             SELECT substr(l_xmdl009 ,instr(l_xmdl009 ,'_',1,1)+1) INTO sr.l_size FROM dual
          ELSE
             LET sr.l_color = l_xmdl009
          END IF
          
          SELECT DISTINCT oocql004 INTO sr.l_color_desc FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql003 = g_dlang
             AND oocql002 = sr.l_color AND oocql001 = '2148'     
          SELECT DISTINCT oocql004 INTO sr.l_size_desc  FROM oocql_t 
           WHERE oocqlent = g_enterprise AND oocql003 = g_dlang
             AND oocql002 = sr.l_size  AND oocql001 = '2149' 
       END IF
       #客户地址
       SELECT xmdk009,xmdk021 INTO l_xmdk009,l_xmdk021 from xmdk_t WHERE xmdkdocno = sr.xmdkdocno AND xmdkent = g_enterprise
          CALL s_adb_address_ref('3',l_xmdk021,l_xmdk009)
                RETURNING l_oofb011,sr.l_address
       
       CASE sr.l_xmdk000
          WHEN '1'  LET sr.l_xmdk000= '1.出货单'
          #161219-00010#1 add by sunxh(S)
                    LET sr.xmdl059 = 0
                    LET sr.l_xmdl0182 = 0
                    LET sr.l_xmdl0282 = 0
                    LET sr.l_price2 = 0 
          #161219-00010#1 add by sunxh(E)
          WHEN '2'  LET sr.l_xmdk000= '2.无订单出货'
                    LET sr.l_xmdl0182 = 0
                    LET sr.l_xmdl0282 = 0
                    LET sr.l_price2 = 0 
          WHEN '6'  LET sr.l_xmdk000= '6.销退单'
          #161219-00010#1 add by sunxh(S)
                    LET sr.l_xmdl018 = -1*(sr.l_xmdl018)
                    LET sr.l_xmdl028 = -1*(sr.l_xmdl028)
                    LET sr.xmdl059 = -1*(sr.xmdl059)
                    LET sr.l_price = -1*(sr.l_price)
                    LET sr.l_xmdl0181 = 0
                    LET sr.l_xmdl0281 = 0
                    LET sr.l_price1 = 0 
                    LET sr.l_xmdl0182 = -1*(sr.l_xmdl0182)
                    LET sr.l_xmdl0282 = -1*(sr.l_xmdl0282)
                    LET sr.l_price2 = -1*(sr.l_price2) 
          #161219-00010#1 add by sunxh(E)
       END CASE          
                 
       CASE sr.l_xmdkstus
          WHEN 'Y'  LET sr.l_xmdkstus= 'Y:已审核'
          WHEN 'D'  LET sr.l_xmdkstus= 'D:抽单'
          WHEN 'N'  LET sr.l_xmdkstus= 'N:未审核'
          WHEN 'R'  LET sr.l_xmdkstus= 'R:已拒绝'
          WHEN 'S'  LET sr.l_xmdkstus= 'S:已过账'
          WHEN 'W'  LET sr.l_xmdkstus= 'W:送签中'
          WHEN 'X'  LET sr.l_xmdkstus= 'X:作废'
          WHEN 'A'  LET sr.l_xmdkstus= 'A:已核准'
          WHEN 'H'  LET sr.l_xmdkstus= 'H:留置'
       END CASE     
       #161219-00010#1 add by cheng 161221 ---e---    
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.l_xmdk000,sr.xmdkdocno,sr.xmdkdocdt,sr.xmdk001,sr.l_xmdkstus,sr.xmdlseq,sr.xmdl008,sr.l_imaal003,sr.l_disc,sr.xmdl225,sr.xmdl224,sr.xmdksite,sr.l_ooefl003,sr.xmdl014,sr.l_inayl003,sr.xmdk007,sr.pmaal_t_pmaal003,sr.xmdl050,sr.l_xmdl050_desc,sr.l_imaa154,sr.rtax_t_rtax006,sr.l_rtax006_desc,sr.l_imaa133,sr.l_imaa133_desc,sr.l_imaa132,sr.l_imaa132_desc,sr.imaa_t_imaa156,sr.imaa_t_imaa116,sr.l_color,sr.l_color_desc,sr.l_size,sr.l_size_desc,sr.xmdl210,sr.xmdl059,sr.l_address,sr.xmdk054,sr.l_xmdl018,sr.l_xmdl028,sr.l_price,sr.l_xmdl0181,sr.l_xmdl0281,sr.l_price1,sr.l_xmdl0182,sr.l_xmdl0282,sr.l_price2
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "aslr512_x01_execute"
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
 
{<section id="aslr512_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION aslr512_x01_rep_data()
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
 
{<section id="aslr512_x01.other_function" readonly="Y" >}

 
{</section>}
 
