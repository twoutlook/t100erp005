#該程式未解開Section, 採用最新樣板產出!
{<section id="ainr230_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:6(2016-12-09 09:33:56), PR版次:0006(2016-12-09 14:31:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000076
#+ Filename...: ainr230_x01
#+ Description: ...
#+ Creator....: 01996(2014-12-29 15:55:34)
#+ Modifier...: 08734 -SD/PR- 08734
 
{</section>}
 
{<section id="ainr230_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#160401-00007#1   2016/04/06  By Ann_Huang  調整呆滯日期與呆滯天數條件,取消呆滯日期條件,並且利用計算基準日期+呆滯天數，來決定計算呆滯日的區間
#160415-00007#2   2016/06/03  By 02097      成本單價的單位是成本單位及採購單價的單位是基礎單位，要換算成庫存單位
#161124-00048#4   2016/12/09  By 08734      星号整批调整
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
       wc STRING,                  #条件 
       typea STRING,                  #采购性料件成 
       typeb STRING,                  #库存成本 
       b LIKE type_t.num5,         #呆滞天起始 
       e LIKE type_t.num5,         #呆滞天截至 
       typec STRING,                  #库存为0 
       ldate LIKE type_t.dat          #基準日
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_begin         LIKE imai_t.imai037
DEFINE g_end           LIKE imai_t.imai037
#end add-point
 
{</section>}
 
{<section id="ainr230_x01.main" readonly="Y" >}
PUBLIC FUNCTION ainr230_x01(p_arg1,p_arg2,p_arg3,p_arg4,p_arg5,p_arg6,p_arg7)
DEFINE  p_arg1 STRING                  #tm.wc  条件 
DEFINE  p_arg2 STRING                  #tm.typea  采购性料件成 
DEFINE  p_arg3 STRING                  #tm.typeb  库存成本 
DEFINE  p_arg4 LIKE type_t.num5         #tm.b  呆滞天起始 
DEFINE  p_arg5 LIKE type_t.num5         #tm.e  呆滞天截至 
DEFINE  p_arg6 STRING                  #tm.typec  库存为0 
DEFINE  p_arg7 LIKE type_t.dat         #tm.ldate  基準日
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.typea = p_arg2
   LET tm.typeb = p_arg3
   LET tm.b = p_arg4
   LET tm.e = p_arg5
   LET tm.typec = p_arg6
   LET tm.ldate = p_arg7
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "ainr230_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL ainr230_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL ainr230_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL ainr230_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL ainr230_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL ainr230_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="ainr230_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION ainr230_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "l_imaa009.imaa_t.imaa009,l_rtaxl003.rtaxl_t.rtaxl003,inag001.inag_t.inag001,l_imaal003.imaal_t.imaal003,l_imaal004.imaal_t.imaal004,l_imaf057.imaf_t.imaf057,l_imaf052.imaf_t.imaf052,l_ooag011.ooag_t.ooag011,inag004.inag_t.inag004,l_inayl003.inayl_t.inayl003,inag005.inag_t.inag005,l_inab003.inab_t.inab003,inag006.inag_t.inag006,inag002.inag_t.inag002,l_inag002_desc.type_t.chr1000,inag003.inag_t.inag003,inag007.inag_t.inag007,inag008.inag_t.inag008,l_cost.type_t.num20_6,l_mount.type_t.num20_6,inag016.inag_t.inag016,l_days.type_t.chr80" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="ainr230_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION ainr230_x01_ins_prep()
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
 
{<section id="ainr230_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION ainr230_x01_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"

#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   #160401-00007#1  --- mark Start ---
  #LET g_begin = g_today - tm.e
  #LET g_end   = g_today - tm.b
   #160401-00007#1  --- mark Start ---
   #160401-00007#1  --- add Start ---
   LET g_begin = tm.ldate - tm.e
   LET g_end   = tm.ldate - tm.b
   #160401-00007#1  --- add Start ---
   
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"
#160510-00019#7-s mark
#   LET g_sql = " SELECT imaa009,rtaxl003,inag001,imaal003,imaal004,imaf057,imaf052,ooag011,inag004,inayl003,inag005,inab003,inag006,inag002,'',inag003,inag007,inag008,'','',inag016,''",
#               "  FROM inag_t ",
#               "          LEFT OUTER JOIN imaal_t ON imaalent = inagent AND imaal001 = inag001 AND imaal002 = '",g_dlang,"'",
#               "          LEFT OUTER JOIN inayl_t ON inaylent = inagent AND inayl001 = inag004 AND inayl002 = '",g_dlang,"'",
#               "          LEFT OUTER JOIN inab_t ON inabent = inagent AND inabsite = inagsite AND inab001 = inag004 AND inab002 = inag005 ",
#               "          LEFT OUTER JOIN imaf_t ON imafent = inagent AND imafsite = inagsite AND imaf001 = inag001 ",                     
#               "          LEFT OUTER JOIN ooag_t ON ooagent = imafent AND ooag001 = imaf052 ",
##              ",         imai_t",
#               ",         imaa_t ",
#               "          LEFT OUTER JOIN rtaxl_t ON rtaxlent = imaaent AND rtaxl001 = imaa009 AND rtaxl002 = '",g_dlang,"'",                              
#               "          WHERE imaaent = inagent AND imaa001 = inag001 ",
##              "            AND imaient = inagent AND imaisite = inagsite AND imai001 = inag001 ",
#               "            AND inagent = '",g_enterprise,"' AND inagsite = '",g_site,"'",
##              "            AND (imai037 BETWEEN '",g_begin,"' AND '",g_end,"' OR imai037 IS NULL)"
#               "            AND (inag016 BETWEEN '",g_begin,"' AND '",g_end,"' OR inag016 IS NULL)"
#160510-00019#7-e mark  

#160510-00019#7-s add
   LET g_sql = " SELECT imaa009, ",
               "        (SELECT rtaxl003 FROM rtaxl_t WHERE rtaxlent = imaaent AND rtaxl001 = imaa009 AND rtaxl002 = '",g_dlang,"') rtaxl003,",
               "        inag001, ",
               "        (SELECT imaal003 FROM imaal_t WHERE imaalent = inagent AND imaal001 = inag001 AND imaal002 = '",g_dlang,"') imaal003,",
               "        (SELECT imaal004 FROM imaal_t WHERE imaalent = inagent AND imaal001 = inag001 AND imaal002 = '",g_dlang,"') imaal004,",
               "        imaf057,imaf052, ",
               "        (SELECT ooag011 FROM ooag_t WHERE ooagent = imafent AND ooag001 = imaf052 ) ooag011,",
               "        inag004,",
               "        (SELECT inayl003 FROM inayl_t WHERE inaylent = inagent AND inayl001 = inag004 AND inayl002 = '",g_dlang,"') inayl003,",
               "        inag005,",
               "        (SELECT inab003 FROM inab_t WHERE inabent = inagent AND inabsite = inagsite AND inab001 = inag004 AND inab002 = inag005) inab003,",
               "        inag006,inag002,",
               "        (SELECT inaml004 FROM inaml_t WHERE inamlent = inagent AND inaml001 = inag001 AND inaml002 = inag002 AND inaml003 = '",g_lang,"') inaml004,",
               "        inag003,inag007,inag008,",
               "        (SELECT imai021 FROM imai_t WHERE imaient = inagent AND imaisite = inagsite AND imai001 = inag001 ) imai021,",
               "        '',inag016,'',",
               "        imaa006,",
               "        (SELECT imai023 FROM imai_t WHERE imaient = inagent AND imaisite = inagsite AND imai001 = inag001 ) imai023",
               "        FROM inag_t LEFT OUTER JOIN imaf_t ON imafent = inagent AND imafsite = inagsite AND imaf001 = inag001, ",     
               "          imaa_t ",                          
               "          WHERE imaaent = inagent AND imaa001 = inag001 ",    
               "            AND inagent = '",g_enterprise,"' AND inagsite = '",g_site,"'",
               "            AND (inag016 BETWEEN '",g_begin,"' AND '",g_end,"' OR inag016 IS NULL)"               
               
#160510-00019#7-e add               
               
               
   IF tm.typec = 'N' THEN 
      LET g_sql = g_sql," AND inag008 > 0 "
   END IF
   
   LET g_sql = g_sql," AND ",tm.wc CLIPPED
   
   LET g_sql = g_sql," ORDER BY inag001,inag002,inag003,inag004,inag005,inag006,inag007"
#   #end add-point
#   LET g_select = " SELECT '','',inag001,'','','','','',inag004,'',inag005,'',inag006,inag002,'',inag003, 
#       inag007,inag008,'','',inag016,''"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
 
#   #end add-point
#    LET g_from = " FROM inag_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
 
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
 
#   #end add-point
# 
#   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
 
#   #end add-point:sel_prep.sql.before
#   LET g_where = g_where ,cl_sql_add_filter("inag_t")   #資料過濾功能
#   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
#   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
# 
#   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_sql = cl_sql_add_mask(g_sql)
   #end add-point
   PREPARE ainr230_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE ainr230_x01_curs CURSOR FOR ainr230_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="ainr230_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION ainr230_x01_ins_data()
DEFINE sr RECORD 
   l_imaa009 LIKE imaa_t.imaa009, 
   l_rtaxl003 LIKE rtaxl_t.rtaxl003, 
   inag001 LIKE inag_t.inag001, 
   l_imaal003 LIKE imaal_t.imaal003, 
   l_imaal004 LIKE imaal_t.imaal004, 
   l_imaf057 LIKE imaf_t.imaf057, 
   l_imaf052 LIKE imaf_t.imaf052, 
   l_ooag011 LIKE ooag_t.ooag011, 
   inag004 LIKE inag_t.inag004, 
   l_inayl003 LIKE inayl_t.inayl003, 
   inag005 LIKE inag_t.inag005, 
   l_inab003 LIKE inab_t.inab003, 
   inag006 LIKE inag_t.inag006, 
   inag002 LIKE inag_t.inag002, 
   l_inag002_desc LIKE type_t.chr1000, 
   inag003 LIKE inag_t.inag003, 
   inag007 LIKE inag_t.inag007, 
   inag008 LIKE inag_t.inag008, 
   l_cost LIKE type_t.num20_6, 
   l_mount LIKE type_t.num20_6, 
   inag016 LIKE inag_t.inag016, 
   l_days LIKE type_t.chr80
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
#DEFINE l_imai  RECORD LIKE imai_t.*  #161124-00048#4  2016/12/09 By 08734 mark  
#161124-00048#4  2016/12/09 By 08734 add(S)
DEFINE l_imai RECORD  #料件據點資訊檔
       imaient LIKE imai_t.imaient, #企业编号
       imaisite LIKE imai_t.imaisite, #营运据点
       imai001 LIKE imai_t.imai001, #料件编号
       imai021 LIKE imai_t.imai021, #最近采购单价
       imai022 LIKE imai_t.imai022, #平均采购单价
       imai023 LIKE imai_t.imai023, #采购市价
       imai024 LIKE imai_t.imai024, #最近采购市价异动日
       imai025 LIKE imai_t.imai025, #期间采购最近采购日
       imai026 LIKE imai_t.imai026, #最近询价单价
       imai031 LIKE imai_t.imai031, #首次出库日
       imai032 LIKE imai_t.imai032, #首次入库日
       imai033 LIKE imai_t.imai033, #最近出库日
       imai034 LIKE imai_t.imai034, #最近入库日
       imai035 LIKE imai_t.imai035, #最近采购日
       imai036 LIKE imai_t.imai036, #最近异动日
       imai037 LIKE imai_t.imai037, #最近呆滞日
       imai051 LIKE imai_t.imai051, #产品检核状态
       imai052 LIKE imai_t.imai052, #产品最后更改者
       imai053 LIKE imai_t.imai053, #产品最后更改日期
       imai054 LIKE imai_t.imai054, #库存检核状态
       imai055 LIKE imai_t.imai055, #库存最后更改者
       imai056 LIKE imai_t.imai056, #库存最后更改日期
       imai057 LIKE imai_t.imai057, #销售检核状态
       imai058 LIKE imai_t.imai058, #销售最后更改者
       imai059 LIKE imai_t.imai059, #销售最后更改日期
       imai060 LIKE imai_t.imai060, #采购检核状态
       imai061 LIKE imai_t.imai061, #采购最后更改者
       imai062 LIKE imai_t.imai062, #采购最后更改日期
       imai063 LIKE imai_t.imai063, #生管检核状态
       imai064 LIKE imai_t.imai064, #生管最后更改者
       imai065 LIKE imai_t.imai065, #生管最后更改日期
       imai066 LIKE imai_t.imai066, #品管检核状态
       imai067 LIKE imai_t.imai067, #品管最后更改者
       imai068 LIKE imai_t.imai068, #品管最后更改日期
       imai069 LIKE imai_t.imai069, #成本检核状态
       imai070 LIKE imai_t.imai070, #成本最后更改者
       imai071 LIKE imai_t.imai071, #成本最后更改日期
       imaiownid LIKE imai_t.imaiownid, #资料所有者
       imaiowndp LIKE imai_t.imaiowndp, #资料所有部门
       imaicrtid LIKE imai_t.imaicrtid, #资料录入者
       imaicrtdp LIKE imai_t.imaicrtdp, #资料录入部门
       imaicrtdt LIKE imai_t.imaicrtdt, #资料创建日
       imaimodid LIKE imai_t.imaimodid, #资料更改者
       imaimoddt LIKE imai_t.imaimoddt, #最近更改日
       imaicnfid LIKE imai_t.imaicnfid, #资料审核者
       imaicnfdt LIKE imai_t.imaicnfdt, #数据审核日
       imaistus LIKE imai_t.imaistus, #状态码
       imai038 LIKE imai_t.imai038, #最近周期盘点日
       imai039 LIKE imai_t.imai039, #最近会计盘点日
       imai101 LIKE imai_t.imai101, #最近采购单价更新日期
       imai102 LIKE imai_t.imai102, #最近采购单价来源单号
       imai106 LIKE imai_t.imai106, #平均采购单价上次计算时间
       imai112 LIKE imai_t.imai112, #采购市价来源单号
       imai116 LIKE imai_t.imai116, #最近询价单价更新日期
       imai117 LIKE imai_t.imai117, #最近询价单价来源单号
       imai131 LIKE imai_t.imai131, #最近核价更新日期
       imai132 LIKE imai_t.imai132, #最近核价来源单号
       imai201 LIKE imai_t.imai201, #最近销售单价更新日期
       imai202 LIKE imai_t.imai202, #最近销售单价来源单号
       imai212 LIKE imai_t.imai212, #销售市价来源单号
       imai216 LIKE imai_t.imai216, #最近报价更新日期
       imai217 LIKE imai_t.imai217, #最近报价来源单号
       imai221 LIKE imai_t.imai221, #最近销售单价
       imai222 LIKE imai_t.imai222, #平均销售单价
       imai223 LIKE imai_t.imai223, #销售市价
       imai224 LIKE imai_t.imai224, #销售市价更新日期
       imai231 LIKE imai_t.imai231, #最近出货更新日期
       imai232 LIKE imai_t.imai232, #最近出货来源单号
       imai251 LIKE imai_t.imai251, #首次量产日
       imai252 LIKE imai_t.imai252, #工单单号
       imai256 LIKE imai_t.imai256, #首批检验日
       imai257 LIKE imai_t.imai257, #FQC单号
       imai261 LIKE imai_t.imai261, #首次入库日
       imai262 LIKE imai_t.imai262, #入库单号
       imai266 LIKE imai_t.imai266, #累积生产量
       imai267 LIKE imai_t.imai267, #累积产出量
       imai268 LIKE imai_t.imai268, #累积良率
       imai072 LIKE imai_t.imai072, #关务检核状态
       imai073 LIKE imai_t.imai073, #关务最后更改者
       imai074 LIKE imai_t.imai074 #关务最后更改日期
END RECORD
#161124-00048#4  2016/12/09 By 08734 add(E)
DEFINE l_imaa006 LIKE imaa_t.imaa006
DEFINE l_imai023 LIKE imai_t.imai023   #160510-00019#7 add
DEFINE l_imag014 LIKE imag_t.imag014   #160415-00007#2
DEFINE l_xccc003   LIKE xccc_t.xccc003 #160415-00007#2
DEFINE l_success   LIKE type_t.num5    #160415-00007#2
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    #160510-00019#7-s add
    CALL cl_err_collect_init()      #160415-00007#2
    LET g_rep_success = 'Y'
 
    FOREACH ainr230_x01_curs INTO sr.*,l_imaa006,l_imai023                               
       IF STATUS THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = 'foreach:'
          LET g_errparam.code   = STATUS
          LET g_errparam.popup  = TRUE
          CALL cl_err()
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
 
       IF NOT cl_null(sr.inag016) THEN 
          LET sr.l_days = g_today - sr.inag016
       ELSE
          LET sr.l_days = '******'
       END IF
             
       CASE tm.typea 
          #160415-00007#2--(S)
          WHEN 'a'
            IF tm.typeb = '1' THEN
               #料件的成本单价
               SELECT DISTINCT xcat001 INTO l_xccc003 FROM xcat_t
                WHERE xcatent = g_enterprise 
                  AND xcat005 = '1'
                  AND rownum = 1
               CALL s_cost_price_get_item_cost(g_site,'','',l_xccc003,'','',sr.inag001,sr.inag002,sr.inag004,sr.inag006,sr.inag003,'')
                    RETURNING l_success,sr.l_cost
            ELSE
               SELECT DISTINCT xcat001 INTO l_xccc003 FROM xcat_t
                WHERE xcatent = g_enterprise
                  AND xcat005 = '5'
                  AND rownum = 1
               CALL s_cost_price_get_item_cost(g_site,'','',l_xccc003,'','',sr.inag001,sr.inag002,sr.inag004,sr.inag006,sr.inag003,'')
                    RETURNING l_success,sr.l_cost
            END IF
            #成本单价 要换算成库存单位的单价
            SELECT imag014 INTO l_imag014    #成本单位
              FROM imag_t
             WHERE imagent = g_enterprise AND imagsite = g_site AND imag001 = sr.inag001
            IF NOT cl_null(l_imag014) AND NOT cl_null(sr.inag007) AND NOT cl_null(sr.l_cost) THEN
               CALL s_aooi250_convert_qty(sr.inag001,l_imag014,sr.inag007,sr.l_cost)  RETURNING g_success,sr.l_cost
            END IF
          WHEN 'b'
             #基础单位的单价 要换算成库存单位的单价 
             SELECT imaa006 INTO l_imaa006 FROM imaa_t 
              WHERE imaaent = g_enterprise AND imaa001 = sr.inag001
             IF NOT cl_null(l_imaa006) AND NOT cl_null(sr.inag007) AND NOT cl_null(sr.l_cost) THEN
                CALL s_aooi250_convert_qty(sr.inag001,l_imaa006,sr.inag007,sr.l_cost) RETURNING g_success,sr.l_cost
             END IF
          #160415-00007#2--(E)
          WHEN 'c'
             LET sr.l_cost = l_imai.imai023
             #基础单位的单价 要换算成库存单位的单价 
             #160415-00007#2--(S)
             SELECT imaa006 INTO l_imaa006 FROM imaa_t 
              WHERE imaaent = g_enterprise AND imaa001 = sr.inag001
             IF NOT cl_null(l_imaa006) AND NOT cl_null(sr.inag007) AND NOT cl_null(sr.l_cost) THEN
               CALL s_aooi250_convert_qty(sr.inag001,l_imaa006,sr.inag007,sr.l_cost) RETURNING g_success,sr.l_cost
             END IF
             #160415-00007#2--(E)
       END CASE
       IF cl_null(sr.l_cost) THEN LET sr.l_cost = 0 END IF
       
       IF cl_null(sr.inag008) THEN LET sr.inag008 = 0 END IF
       LET sr.l_mount = sr.l_cost * sr.inag008
       #160415-00007#2--(S)
       #IF NOT cl_null(l_imaa006) AND NOT cl_null(sr.inag007) AND NOT cl_null(sr.l_mount) THEN
       #   CALL s_aooi250_convert_qty(sr.inag001,sr.inag007,l_imaa006,sr.l_mount) 
       #      RETURNING g_success,sr.l_mount
       #END IF
       #160415-00007#2--(E)
       #160415-00007#2--(S)
       #IF NOT cl_null(sr.l_rtaxl003) THEN
       #   LET sr.l_rtaxl003 = sr.l_imaa009,".",sr.l_rtaxl003
       #END IF
       #IF NOT cl_null(sr.l_inayl003) THEN
       #   LET sr.l_inayl003 = sr.inag004,".",sr.l_inayl003
       #END IF
       #IF NOT cl_null(sr.l_inab003) THEN
       #   LET sr.l_inab003 = sr.l_inab003,".",sr.l_inab003
       #END IF
       #IF NOT cl_null(sr.l_ooag011) THEN
       #   LET sr.l_ooag011 = sr.l_imaf052,".",sr.l_ooag011
       #END IF
       #160415-00007#2--(E)

       EXECUTE insert_prep USING sr.l_imaa009,sr.l_rtaxl003,sr.inag001,sr.l_imaal003,sr.l_imaal004,sr.l_imaf057,sr.l_imaf052,sr.l_ooag011,sr.inag004,sr.l_inayl003,sr.inag005,sr.l_inab003,sr.inag006,sr.inag002,sr.l_inag002_desc,sr.inag003,sr.inag007,sr.inag008,sr.l_cost,sr.l_mount,sr.inag016,sr.l_days
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "ainr230_x01_execute"
          LET g_errparam.code   = SQLCA.sqlcode
          LET g_errparam.popup  = FALSE
          CALL cl_err()       
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF       
    END FOREACH
    CALL cl_err_collect_show()         #160415-00007#2
    RETURN 
    #160510-00019#7-e  add
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH ainr230_x01_curs INTO sr.*                               
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
       
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       IF NOT cl_null(sr.inag016) THEN 
          LET sr.l_days = g_today - sr.inag016
       ELSE
          LET sr.l_days = '******'
       END IF
       #SELECT * INTO l_imai.* FROM imai_t WHERE imaient = g_enterprise AND imaisite = g_site AND imai001 = sr.inag001  #161124-00048#4  2016/12/09 By 08734 mark
       SELECT imaient,imaisite,imai001,imai021,imai022,imai023,imai024,imai025,imai026,imai031,imai032,imai033,imai034,imai035,imai036,imai037,imai051,imai052,imai053,imai054,imai055,imai056,imai057,imai058,imai059,imai060,imai061,imai062,imai063,imai064,imai065,imai066,imai067,imai068,imai069,imai070,imai071,  #161124-00048#4 2016/12/09 By 08734 add
         imaiownid,imaiowndp,imaicrtid,imaicrtdp,imaicrtdt,imaimodid,imaimoddt,imaicnfid,imaicnfdt,imaistus,imai038,imai039,imai101,imai102,imai106,imai112,imai116,imai117,imai131,imai132,imai201,imai202,imai212,imai216,imai217,imai221,imai222,imai223,imai224,imai231,imai232,imai251,imai252,imai256,imai257,imai261,imai262,imai266,imai267,imai268,imai072,imai073,imai074 
          INTO l_imai.* FROM imai_t WHERE imaient = g_enterprise AND imaisite = g_site AND imai001 = sr.inag001
       IF cl_null(l_imai.imai021) THEN LET l_imai.imai021 = 0 END IF
       IF cl_null(l_imai.imai023) THEN LET l_imai.imai023 = 0 END IF
       CASE tm.typea 
          WHEN 'a'
            IF tm.typeb = '1' THEN
               LET sr.l_cost = l_imai.imai021
            ELSE
               LET sr.l_cost = l_imai.imai021
            END IF
            
          WHEN 'b'
             LET sr.l_cost = l_imai.imai021
             
          WHEN 'c'
             LET sr.l_cost = l_imai.imai023
             
       END CASE
       IF cl_null(sr.inag008) THEN LET sr.inag008 = 0 END IF
       LET sr.l_mount = sr.l_cost * sr.inag008
              
       SELECT imaa006 INTO l_imaa006 FROM imaa_t 
        WHERE imaaent = g_enterprise AND imaa001 = sr.inag001
       IF NOT cl_null(l_imaa006) AND NOT cl_null(sr.inag007) AND NOT cl_null(sr.l_mount) THEN
          CALL s_aooi250_convert_qty(sr.inag001,sr.inag007,l_imaa006,sr.l_mount) 
             RETURNING g_success,sr.l_mount
       END IF
       
       CALL s_feature_description(sr.inag001,sr.inag002) RETURNING g_success,sr.l_inag002_desc
       IF NOT cl_null(sr.l_rtaxl003) THEN
          LET sr.l_rtaxl003 = sr.l_imaa009,".",sr.l_rtaxl003
       END IF
       IF NOT cl_null(sr.l_inayl003) THEN
          LET sr.l_inayl003 = sr.inag004,".",sr.l_inayl003
       END IF
       IF NOT cl_null(sr.l_inab003) THEN
          LET sr.l_inab003 = sr.l_inab003,".",sr.l_inab003
       END IF
       IF NOT cl_null(sr.l_ooag011) THEN
          LET sr.l_ooag011 = sr.l_imaf052,".",sr.l_ooag011
       END IF
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.l_imaa009,sr.l_rtaxl003,sr.inag001,sr.l_imaal003,sr.l_imaal004,sr.l_imaf057,sr.l_imaf052,sr.l_ooag011,sr.inag004,sr.l_inayl003,sr.inag005,sr.l_inab003,sr.inag006,sr.inag002,sr.l_inag002_desc,sr.inag003,sr.inag007,sr.inag008,sr.l_cost,sr.l_mount,sr.inag016,sr.l_days
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "ainr230_x01_execute"
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
 
{<section id="ainr230_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION ainr230_x01_rep_data()
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
 
{<section id="ainr230_x01.other_function" readonly="Y" >}

 
{</section>}
 
