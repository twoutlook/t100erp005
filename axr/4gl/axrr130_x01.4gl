#該程式未解開Section, 採用最新樣板產出!
{<section id="axrr130_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2016-11-08 10:35:11), PR版次:0003(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000052
#+ Filename...: axrr130_x01
#+ Description: ...
#+ Creator....: 01531(2014-09-10 13:34:03)
#+ Modifier...: 01727 -SD/PR- 00000
 
{</section>}
 
{<section id="axrr130_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#160518-00075#8   2016/07/20  By 01531   (依單別參數作權限管理)aooi200的控制組設定, 取7/8 設定的部門及人員
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
       site STRING,                  #帳務中心 
       type STRING,                  #匯總列印條件 
       iv STRING,                  #已開發票選項 
       s4 STRING,                  #含銷退單否 
       s5 STRING,                  #含驗退單否 
       s6 STRING,                  #關係人列印 
       wc STRING                   #SQL條件字串
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_ref_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields         DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
#end add-point
 
{</section>}
 
{<section id="axrr130_x01.main" readonly="Y" >}
PUBLIC FUNCTION axrr130_x01(p_arg1,p_arg2,p_arg3,p_arg4,p_arg5,p_arg6,p_arg7)
DEFINE  p_arg1 STRING                  #tm.site  帳務中心 
DEFINE  p_arg2 STRING                  #tm.type  匯總列印條件 
DEFINE  p_arg3 STRING                  #tm.iv  已開發票選項 
DEFINE  p_arg4 STRING                  #tm.s4  含銷退單否 
DEFINE  p_arg5 STRING                  #tm.s5  含驗退單否 
DEFINE  p_arg6 STRING                  #tm.s6  關係人列印 
DEFINE  p_arg7 STRING                  #tm.wc  SQL條件字串
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"
 
#end add-point
 
   LET tm.site = p_arg1
   LET tm.type = p_arg2
   LET tm.iv = p_arg3
   LET tm.s4 = p_arg4
   LET tm.s5 = p_arg5
   LET tm.s6 = p_arg6
   LET tm.wc = p_arg7
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "axrr130_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL axrr130_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL axrr130_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL axrr130_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL axrr130_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL axrr130_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="axrr130_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION axrr130_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "xmdk007.xmdk_t.xmdk007,xmdk003.xmdk_t.xmdk003,xmdk004.xmdk_t.xmdk004,xmdl003.xmdl_t.xmdl003,xmdl004.xmdl_t.xmdl004,xmdk016.xmdk_t.xmdk016,xmdldocno.xmdl_t.xmdldocno,xmdkdocdt.xmdk_t.xmdkdocdt,xmdl008.xmdl_t.xmdl008,imaal_t_imaal003.imaal_t.imaal003,imaal_t_imaal004.imaal_t.imaal004,xmdl021.xmdl_t.xmdl021,xmdl022.xmdl_t.xmdl022,xmdl024.xmdl_t.xmdl024,xmdl025.xmdl_t.xmdl025,xmdl026.xmdl_t.xmdl026,xmdl027.xmdl_t.xmdl027,xmdl028.xmdl_t.xmdl028,xmdl029.xmdl_t.xmdl029,xmdk037.xmdk_t.xmdk037,xmdl048.xmdl_t.xmdl048,xmdl049.xmdl_t.xmdl049,xmdk032.xmdk_t.xmdk032,xmdk010.xmdk_t.xmdk010,oofa_t_oofa011.oofa_t.oofa011,oofc_t_oofc012.oofc_t.oofc012,isaf_t_isaf014.isaf_t.isaf014,l_group.type_t.chr50,l_xmdk007_pmaal003.type_t.chr500,l_xmdk003_oofa011.type_t.chr500,l_xmdk004_ooefl003.type_t.chr500,l_xmdl003_xmdl004.type_t.chr500,l_xmdk010_ooibl004.type_t.chr500" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="axrr130_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION axrr130_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="axrr130_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION axrr130_x01_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
DEFINE ls_wc2        STRING
DEFINE ls_wc3        STRING
DEFINE l_origin_str  STRING
DEFINE g_sql_ctr2    STRING                #160518-00075#8
DEFINE g_sql_ctr3    STRING                #160518-00075#8
DEFINE l_ooef004     LIKE ooef_t.ooef004   #160518-00075#8
DEFINE l_site_len    LIKE type_t.num5      #SITE段长度 #160518-00075#8
DEFINE l_slip_len    LIKE type_t.num5      #单别段长度 #160518-00075#8
DEFINE l_i           LIKE type_t.num5      #160518-00075#8
DEFINE l_j           LIKE type_t.num5      #160518-00075#8
DEFINE l_site        LIKE ooef_t.ooef001   #160518-00075#8
#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
   
   IF tm.s4 = 'Y' THEN   #銷退單顯示
      LET ls_wc2 = " (xmdk000 <> '6' OR (xmdk000 = '6' AND xmdk082 IN (SELECT gzcb002 FROM gzcb_t WHERE gzcb001='2088' AND gzcb003='Y')))"
   ELSE
      LET ls_wc2 = " xmdk000 <> '6'"
   END IF

   IF tm.s5 = 'Y' THEN   #驗退單顯示
      LET ls_wc3 = " (xmdk000 <> '5' OR (xmdk000 = '5' AND xmdk082 IN (SELECT gzcb002 FROM gzcb_t WHERE gzcb001='2088' AND gzcb003='Y')))"
   ELSE
      LET ls_wc3 = " xmdk000 <> '5'"
   END IF   
   
   CALL s_fin_account_center_sons_query('3',tm.site,g_today,'')
   CALL s_fin_account_center_sons_str()RETURNING l_origin_str
   IF cl_null(l_origin_str) THEN LET l_origin_str = tm.site END IF
   CALL axrr130_x01_change_to_sql(l_origin_str)RETURNING l_origin_str   
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"
#   LET g_select = "SELECT  xmdk007,xmdk003,xmdk004,xmdl003,xmdl004,xmdk016,xmdldocno,xmdkdocdt,xmdl008,imaal003,imaal004,xmdl021, ",
#                  "        xmdl022,xmdl024,xmdl025,xmdl026,xmdl027,xmdl028,xmdl029,xmdk037,xmdl048,xmdl049,xmdk032,xmdk010,oofa011, ",
#                  "        '',isaf014,'','','','','',''  "
                  
   LET g_select = "SELECT  xmdk007,xmdk003,xmdk004,xmdl003,xmdl004,xmdk016,xmdldocno,xmdkdocdt,xmdl008,imaal003,imaal004,xmdl021, ",
                  "        xmdl022,xmdl024,xmdl025,xmdl026,xmdl027,xmdl028,xmdl029,xmdk037,xmdl048,xmdl049,xmdk032,xmdk010,'', ",
                  "        '','','','','','','',''  "    
   IF tm.iv = '2' THEN 
   LET g_select = "SELECT  xmdk007,xmdk003,xmdk004,xmdl003,xmdl004,xmdk016,xmdldocno,xmdkdocdt,xmdl008,imaal003,imaal004,xmdl021, ",
                  "        xmdl022,xmdl024,xmdl025,xmdl026,xmdl027,xmdl028,xmdl029,xmdk037,isaf010,isaf011,xmdk032,xmdk010,'', ",
                  "        '',isaf014,'','','','','',''  "       
   END IF   
#   #end add-point
#   LET g_select = " SELECT xmdk007,xmdk003,xmdk004,xmdl003,xmdl004,xmdk016,xmdldocno,xmdkdocdt,xmdl008, 
#       imaal_t.imaal003,imaal_t.imaal004,xmdl021,xmdl022,xmdl024,xmdl025,xmdl026,xmdl027,xmdl028,xmdl029, 
#       xmdk037,xmdl048,xmdl049,xmdk032,xmdk010,oofa_t.oofa011,oofc_t.oofc012,isaf_t.isaf014,NULL,NULL, 
#       NULL,NULL,NULL,NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
#   LET g_from = "  FROM (SELECT xmdk007,xmdk003,xmdk004,xmdl003,xmdl004,xmdk016,xmdldocno,xmdkdocdt,xmdl008,imaal003,imaal004,xmdl021,       ",
#                "               CASE WHEN xmdl022 IS NULL THEN 0 ELSE xmdl022 END,xmdl024,xmdl025,xmdl026,xmdl027,xmdl028,xmdl029,xmdk037,xmdl048,xmdl049,xmdk032,xmdk010,oofa011,     ",  
#                "               '',isaf014,'','','','','',''                                                                           ",
#                "          FROM xmdk_t, isaf_t,ooef_t, oodb_t, xmdl_t                                                                               ",
#                "            LEFT JOIN imaal_t ON imaal001= xmdl008 AND imaal002 = '",g_lang,"'  AND imaalent= xmdlent                       ",
#                "            LEFT JOIN oofa_t ON oofaent = xmdkent AND oofa003 = xmdk007 AND oofa002 = '4'                                   "
#   LET g_from = "  FROM xmdk_t LEFT JOIN oofa_t ON oofaent = xmdkent AND oofa003 = xmdk007 AND oofa002 = '4', isaf_t,ooef_t, oodb_t, xmdl_t  ",
#                "  LEFT JOIN imaal_t ON imaal001= xmdl008 AND imaal002 = '",g_lang,"'  AND imaalent= xmdlent "   
   LET g_from = "  FROM xmdk_t,ooef_t,oodb_t,xmdl_t  ",
                "  LEFT JOIN imaal_t ON imaal001= xmdl008 AND imaal002 = '",g_lang,"'  AND imaalent= xmdlent "   
   IF tm.iv = '2' THEN 
   LET g_from = "  FROM xmdk_t,isaf_t,isag_t,xmdl_t ",
                "  LEFT JOIN imaal_t ON imaal001= xmdl008 AND imaal002 = '",g_lang,"'  AND imaalent= xmdlent "   
   END IF   

#   #end add-point
#    LET g_from = " FROM xmdk_t,xmdl_t,oofa_t,oofc_t,isaf_t,imaal_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_where = "         WHERE xmdkdocno = xmdldocno              AND xmdkent = xmdlent                 ",
                 "               AND xmdl087 = 'Y'                  AND xmdkent = '",g_enterprise,"'      ",
                 "               AND ooefent = xmdkent              AND xmdkstus = 'S'                    ",
                 "               AND ooef001 = xmdlsite             AND ooef019 = oodb001                 ",
                 "               AND oodb002 = xmdl025              AND oodbent = xmdkent                 ",
                 "               AND ", tm.wc  CLIPPED,
                 "               AND ((xmdk002 NOT IN ('2', '4')                                          ",
                 "               AND ((xmdk002 <> '3' AND xmdk000 IN ('1', '2', '3'))                    ",
                 "                    OR (xmdk002 = '3' AND xmdk000 = '4')) AND xmdk000 <> 6)             ",
                 "                    OR xmdk000 = 6)                                                     ",
                 "               AND xmdlsite IN (",l_origin_str,")                                       ",
                 "   AND  ",ls_wc2 CLIPPED,
                 "   AND  ",ls_wc3 CLIPPED
                 
   IF tm.iv = '2' THEN
   LET g_where = "         WHERE isafent = isagent AND isafdocno = isagdocno AND isafcomp = isagcomp ",
                 "               AND xmdkdocno = xmdldocno              AND xmdkent = xmdlent             ",
                 "               AND xmdldocno = isag002 AND xmdlseq = isag003                            ",
                 "               AND xmdldocno = xmdkdocno AND xmdlent = xmdkent                          ",
                 "               AND xmdlent = isafent              AND isafent = '",g_enterprise,"'      ",
                 "               AND isafstus = 'Y'                 AND isag105 - isag116 <> 0   ",
                 "               AND ooef001 = xmdlsite             AND ooef019 = oodb001                 ",
                 "               AND oodb002 = xmdl025              AND oodbent = xmdkent                 ",
                 "               AND isafent = xmdkent              AND isaf010 = xmdl048                 ",
                 "               AND isaf011 = xmdl049                                                    ",
                 "               AND xmdlsite IN (",l_origin_str,")                                       ",
                 "   AND isafdocno IN (SELECT DISTINCT isagdocno FROM isag_t,xmdl_t ",
                 "                      WHERE xmdldocno = isag002 AND xmdlseq = isag003 ",
                 "                        AND xmdlent = isagent )"
 
   END IF 
   #160518-00075#8 add s---
   #SITE 长度
   LET l_site_len = cl_get_para(g_enterprise,g_site,'E-COM-0003')
   
   #单别长度
   LET l_slip_len = cl_get_para(g_enterprise,g_site,'E-COM-0001')
   
   #第一个分隔符
   IF cl_get_para(g_enterprise,g_site,'E-COM-0008') = '1' THEN    #据点+单别
      LET l_i = l_site_len + 2
      LET l_j = l_slip_len
   ELSE
      LET l_i = 1
      LET l_j = l_slip_len
   END IF   
   LET l_site = tm.site 
   SELECT ooef004 INTO l_ooef004 FROM ooef_t WHERE ooefent = g_enterprise AND ooef001 = l_site
   #出货单限定单别
   CALL s_control_get_docno_sql_q(g_user,g_dept,l_ooef004) RETURNING g_sub_success,g_sql_ctr2,g_sql_ctr3 

   LET g_where = g_where ,"  AND (substr(xmdkdocno,",l_i,",",l_j,") ",g_sql_ctr2," OR substr(xmdkdocno,",l_i,",",l_j,") ",g_sql_ctr3,")"
   #160518-00075#8 add e---
   
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("xmdk_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE axrr130_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE axrr130_x01_curs CURSOR FOR axrr130_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="axrr130_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION axrr130_x01_ins_data()
DEFINE sr RECORD 
   xmdk007 LIKE xmdk_t.xmdk007, 
   xmdk003 LIKE xmdk_t.xmdk003, 
   xmdk004 LIKE xmdk_t.xmdk004, 
   xmdl003 LIKE xmdl_t.xmdl003, 
   xmdl004 LIKE xmdl_t.xmdl004, 
   xmdk016 LIKE xmdk_t.xmdk016, 
   xmdldocno LIKE xmdl_t.xmdldocno, 
   xmdkdocdt LIKE xmdk_t.xmdkdocdt, 
   xmdl008 LIKE xmdl_t.xmdl008, 
   imaal_t_imaal003 LIKE imaal_t.imaal003, 
   imaal_t_imaal004 LIKE imaal_t.imaal004, 
   xmdl021 LIKE xmdl_t.xmdl021, 
   xmdl022 LIKE xmdl_t.xmdl022, 
   xmdl024 LIKE xmdl_t.xmdl024, 
   xmdl025 LIKE xmdl_t.xmdl025, 
   xmdl026 LIKE xmdl_t.xmdl026, 
   xmdl027 LIKE xmdl_t.xmdl027, 
   xmdl028 LIKE xmdl_t.xmdl028, 
   xmdl029 LIKE xmdl_t.xmdl029, 
   xmdk037 LIKE xmdk_t.xmdk037, 
   xmdl048 LIKE xmdl_t.xmdl048, 
   xmdl049 LIKE xmdl_t.xmdl049, 
   xmdk032 LIKE xmdk_t.xmdk032, 
   xmdk010 LIKE xmdk_t.xmdk010, 
   oofa_t_oofa011 LIKE oofa_t.oofa011, 
   oofc_t_oofc012 LIKE oofc_t.oofc012, 
   isaf_t_isaf014 LIKE isaf_t.isaf014, 
   l_group LIKE type_t.chr50, 
   l_xmdk007_pmaal003 LIKE type_t.chr500, 
   l_xmdk003_oofa011 LIKE type_t.chr500, 
   l_xmdk004_ooefl003 LIKE type_t.chr500, 
   l_xmdl003_xmdl004 LIKE type_t.chr500, 
   l_xmdk010_ooibl004 LIKE type_t.chr500
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
 
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH axrr130_x01_curs INTO sr.*                               
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
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.xmdk007,sr.xmdk003,sr.xmdk004,sr.xmdl003,sr.xmdl004,sr.xmdk016,sr.xmdldocno,sr.xmdkdocdt,sr.xmdl008,sr.imaal_t_imaal003,sr.imaal_t_imaal004,sr.xmdl021,sr.xmdl022,sr.xmdl024,sr.xmdl025,sr.xmdl026,sr.xmdl027,sr.xmdl028,sr.xmdl029,sr.xmdk037,sr.xmdl048,sr.xmdl049,sr.xmdk032,sr.xmdk010,sr.oofa_t_oofa011,sr.oofc_t_oofc012,sr.isaf_t_isaf014,sr.l_group,sr.l_xmdk007_pmaal003,sr.l_xmdk003_oofa011,sr.l_xmdk004_ooefl003,sr.l_xmdl003_xmdl004,sr.l_xmdk010_ooibl004
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "axrr130_x01_execute"
          LET g_errparam.code   = SQLCA.sqlcode
          LET g_errparam.popup  = FALSE
          CALL cl_err()       
          LET g_rep_success = 'N'
          EXIT FOREACH
       END IF
 
       #add-point:ins_data段after_save name="ins_data.after.save"
     
       SELECT oofc012 INTO sr.oofc_t_oofc012 FROM oofc_t WHERE oofcent = g_enterprise AND oofc002 = (SELECT oofa001 FROM oofa_t WHERE oofa011 = sr.oofa_t_oofa011 AND oofa002 = '4' AND oofaent = g_enterprise)
 
       #客戶編號
       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = sr.xmdk007        
       CALL ap_ref_array2(g_ref_fields,"SELECT pmaal003 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET sr.l_xmdk007_pmaal003 = sr.xmdk003,' ', g_rtn_fields[1]
       
       #業務人員
       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = sr.xmdk003         
       CALL ap_ref_array2(g_ref_fields,"SELECT ooag011 FROM ooag_t WHERE ooagent='"||g_enterprise||"' AND ooag001=? ","") RETURNING g_rtn_fields
       LET sr.l_xmdk003_oofa011 = sr.xmdk003,' ', g_rtn_fields[1]

       #業務部門
       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = sr.xmdk004         
       CALL ap_ref_array2(g_ref_fields,"SELECT ooefl003 FROM ooefl_t WHERE ooeflent='"||g_enterprise||"' AND ooefl001=? AND ooefl002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET sr.l_xmdk004_ooefl003 = sr.xmdk004,' ', g_rtn_fields[1]
       
       #收款條件
       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = sr.xmdk010
       CALL ap_ref_array2(g_ref_fields,"SELECT ooibl004 FROM ooibl_t WHERE ooiblent='"||g_enterprise||"' AND ooibl002=? AND ooibl003='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET sr.l_xmdk010_ooibl004 = sr.xmdk010,' ', g_rtn_fields[1]    

       #訂單+項次
       LET sr.l_xmdl003_xmdl004 = sr.xmdl003,'.',sr.xmdl004
       
       #發票號碼
       LET sr.xmdk037 = sr.xmdl048,"-",sr.xmdl049
       
       CASE tm.type 
         WHEN '0' LET sr.l_group = sr.xmdldocno 
         WHEN '1' LET sr.l_group = sr.xmdl003
         WHEN '2' LET sr.l_group = sr.xmdk003
         WHEN '3' LET sr.l_group = sr.xmdk004   
         WHEN '4' LET sr.l_group = sr.xmdk037  
         WHEN '5' LET sr.l_group = sr.xmdl008
       END CASE         
       #end add-point
       
    END FOREACH
    
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
 
END FUNCTION
 
{</section>}
 
{<section id="axrr130_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION axrr130_x01_rep_data()
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
 
{<section id="axrr130_x01.other_function" readonly="Y" >}

################################################################################
# Descriptions...:  
# Memo...........:
# Usage..........: CALL axrr130_x01_change_to_sql(p_wc)
# Input parameter:  
# Date & Author..: 2014/9/24 By 01531
# Modify.........:
################################################################################
PRIVATE FUNCTION axrr130_x01_change_to_sql(p_wc)
   DEFINE p_wc       STRING
   DEFINE r_wc       STRING
   DEFINE tok        base.StringTokenizer
   DEFINE l_str      STRING

   LET tok = base.StringTokenizer.create(p_wc,",")
   WHILE tok.hasMoreTokens()
      IF cl_null(l_str) THEN
         LET l_str = tok.nextToken()
      ELSE
         LET l_str = l_str,"','",tok.nextToken()
      END IF
   END WHILE
   LET r_wc = "'",l_str,"'"

   RETURN r_wc
END FUNCTION

 
{</section>}
 
