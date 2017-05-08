#該程式未解開Section, 採用最新樣板產出!
{<section id="ainr150_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2017-01-18 09:32:50), PR版次:0003(2017-01-18 11:06:04)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000062
#+ Filename...: ainr150_x01
#+ Description: ...
#+ Creator....: 05423(2014-11-24 16:16:34)
#+ Modifier...: 05423 -SD/PR- 05423
 
{</section>}
 
{<section id="ainr150_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#170109-00055#1   2017/01/10  By zhujing  符合多项的资料会印两遍，调整成仅印一遍即可
#170116-00069#1   2017/01/18  By zhujing  1.库存量改为抓取合计值  
#                                         2.调整栏位的说明(azzi300)：第一個缺少量是安全庫存量-庫存量，欄位名稱改為[安全庫存量缺少量]
#                                                                 ：第二個缺少量是再訂貨點量缺少量-庫存量，欄位名稱改為[再訂貨點量缺少量]
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
       pr1 STRING,                  #l_pr1 
       pr2 STRING,                  #l_pr2 
       pr3 STRING,                  #l_pr3 
       pr4 STRING,                  #l_pr4 
       day STRING                   #l_day
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="ainr150_x01.main" readonly="Y" >}
PUBLIC FUNCTION ainr150_x01(p_arg1,p_arg2,p_arg3,p_arg4,p_arg5,p_arg6)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 STRING                  #tm.pr1  l_pr1 
DEFINE  p_arg3 STRING                  #tm.pr2  l_pr2 
DEFINE  p_arg4 STRING                  #tm.pr3  l_pr3 
DEFINE  p_arg5 STRING                  #tm.pr4  l_pr4 
DEFINE  p_arg6 STRING                  #tm.day  l_day
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.pr1 = p_arg2
   LET tm.pr2 = p_arg3
   LET tm.pr3 = p_arg4
   LET tm.pr4 = p_arg5
   LET tm.day = p_arg6
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "ainr150_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL ainr150_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL ainr150_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL ainr150_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL ainr150_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL ainr150_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="ainr150_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION ainr150_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "inagsite.inag_t.inagsite,l_inagsite_desc.type_t.chr30,imaa009.imaa_t.imaa009,l_imaa009_desc.type_t.chr30,inag001.inag_t.inag001,imaal_t_imaal003.imaal_t.imaal003,imaal_t_imaal004.imaal_t.imaal004,inag007.inag_t.inag007,inag008.inag_t.inag008,imai_t_imai037.imai_t.imai037,l_imai037_desc.type_t.chr30,imaf_t_imaf027.imaf_t.imaf027,l_imaf027_desc.type_t.num10,l_over.type_t.num10,imaf_t_imaf026.imaf_t.imaf026,l_imaf026_desc.type_t.num10,l_lack.type_t.num10,imaf_t_imaf025.imaf_t.imaf025,l_imaf025_desc.type_t.num10,l_lack2.type_t.num10,imaa006.imaa_t.imaa006" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="ainr150_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION ainr150_x01_ins_prep()
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
             ?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)"
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
 
{<section id="ainr150_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION ainr150_x01_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
DEFINE g_group       STRING      #170116-00069#1 add
#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"
   #170116-00069#1 mod-S
#   LET g_select = " SELECT DISTINCT inagsite,ooefl_t.ooefl003,imaa009,rtaxl_t.rtaxl003,inag001,imaal_t.imaal003,imaal_t.imaal004,inag007, 
#       inag008,imai_t.imai037,NULL,COALESCE(imaf_t.imaf027,0),NULL,NULL,COALESCE(imaf_t.imaf026,0),NULL,NULL,COALESCE(imaf_t.imaf025,0), 
#       NULL,NULL,imaa006"
   LET g_select = " SELECT DISTINCT inagsite,ooefl_t.ooefl003,imaa009,rtaxl_t.rtaxl003,inag001,imaal_t.imaal003,imaal_t.imaal004,inag007, 
       SUM(COALESCE(inag008,0)),
       imai_t.imai037,NULL,COALESCE(imaf_t.imaf027,0),NULL,NULL,COALESCE(imaf_t.imaf026,0),NULL,NULL,COALESCE(imaf_t.imaf025,0), 
       NULL,NULL,imaa006"
   #170116-00069#1 mod-E
#   #end add-point
#   LET g_select = " SELECT inagsite,NULL,imaa009,NULL,inag001,imaal_t.imaal003,imaal_t.imaal004,inag007, 
#       inag008,imai_t.imai037,NULL,imaf_t.imaf027,NULL,NULL,imaf_t.imaf026,NULL,NULL,imaf_t.imaf025, 
#       NULL,NULL,imaa006"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_from = " FROM inag_t LEFT OUTER JOIN imaa_t ON inag001 = imaa001 AND inagent = imaaent ",
                "             LEFT OUTER JOIN imaal_t ON inag001 = imaal001 AND inagent = imaalent AND imaal002 = '",g_dlang,"' ",
                "             LEFT OUTER JOIN imai_t ON inag001 = imai001 AND inagent = imaient AND inagsite = imaisite ",
                "             LEFT OUTER JOIN imaf_t ON inag001 = imaf001 AND inagent = imafent AND inagsite = imafsite ",
                "             LEFT OUTER JOIN ooefl_t ON inagsite = ooefl001 AND inagent = ooeflent AND ooefl002 = '",g_dlang,"' ",
                "             LEFT OUTER JOIN rtaxl_t ON imaa009 = rtaxl001 AND imaaent = rtaxlent AND rtaxl002 = '",g_dlang,"' "
#   #end add-point
#    LET g_from = " FROM inag_t,imaa_t,imaal_t,imai_t,imaf_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   LET g_where = " WHERE ",tm.wc CLIPPED, " AND inagent = ",g_enterprise      #170109-00055#1 add
#   #end add-point
#    LET g_where = " WHERE " ,tm.wc CLIPPED
# 
#   #add-point:sel_prep g_order name="sel_prep.g_order"
   #170116-00069#1 add-S
   LET g_group = " GROUP BY inagsite,ooefl003,imaa009,rtaxl003,inag001,imaal003,imaal004,inag007,imai037,imaf027,imaf026,imaf025,imaa006"
   #170116-00069#1 add-E
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
 
#   #end add-point:sel_prep.sql.before
#   LET g_where = g_where ,cl_sql_add_filter("inag_t")   #資料過濾功能
#   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
#   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
# 
#   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   #170116-00069#1 add-S
   LET g_where = g_where ,cl_sql_add_filter("inag_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED," ",g_group CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
   #170116-00069#1 add-E
   #end add-point
   PREPARE ainr150_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE ainr150_x01_curs CURSOR FOR ainr150_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="ainr150_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION ainr150_x01_ins_data()
DEFINE sr RECORD 
   inagsite LIKE inag_t.inagsite, 
   l_inagsite_desc LIKE type_t.chr30, 
   imaa009 LIKE imaa_t.imaa009, 
   l_imaa009_desc LIKE type_t.chr30, 
   inag001 LIKE inag_t.inag001, 
   imaal_t_imaal003 LIKE imaal_t.imaal003, 
   imaal_t_imaal004 LIKE imaal_t.imaal004, 
   inag007 LIKE inag_t.inag007, 
   inag008 LIKE inag_t.inag008, 
   imai_t_imai037 LIKE imai_t.imai037, 
   l_imai037_desc LIKE type_t.chr30, 
   imaf_t_imaf027 LIKE imaf_t.imaf027, 
   l_imaf027_desc LIKE type_t.num10, 
   l_over LIKE type_t.num10, 
   imaf_t_imaf026 LIKE imaf_t.imaf026, 
   l_imaf026_desc LIKE type_t.num10, 
   l_lack LIKE type_t.num10, 
   imaf_t_imaf025 LIKE imaf_t.imaf025, 
   l_imaf025_desc LIKE type_t.num10, 
   l_lack2 LIKE type_t.num10, 
   imaa006 LIKE imaa_t.imaa006
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_rate  LIKE type_t.num20_6
DEFINE l_success  LIKE type_t.chr2
DEFINE l_imaf025  LIKE imaf_t.imaf025
DEFINE l_imaf026  LIKE imaf_t.imaf026
DEFINE l_imaf027  LIKE imaf_t.imaf027
DEFINE l_imai037  LIKE type_t.num5
DEFINE l_flag     LIKE type_t.num5     #170109-00055#1 add
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
 
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH ainr150_x01_curs INTO sr.*                               
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
       LET l_flag = FALSE     #170109-00055#1 add
   
       IF NOT cl_null(sr.imai_t_imai037) THEN
         LET l_imai037 = g_today - sr.imai_t_imai037
         LET sr.l_imai037_desc = l_imai037
       ELSE 
         LET sr.l_imai037_desc = '******'
       END IF
       IF NOT cl_null(sr.inag007) AND NOT cl_null(sr.imaa006) THEN
         CALL s_aimi190_get_convert(sr.inag001,sr.inag007,sr.imaa006) RETURNING l_success,l_rate   
       ELSE 
         LET l_rate = 1
       END IF
       LET sr.l_imaf027_desc = sr.imaf_t_imaf027 * l_rate #警戒庫存量
       LET sr.l_imaf026_desc = sr.imaf_t_imaf026 * l_rate #安全庫存量
       LET sr.l_imaf025_desc = sr.imaf_t_imaf025 * l_rate #再訂貨點量
       LET l_imaf027 = sr.imaf_t_imaf027 * l_rate #警戒庫存量
       LET l_imaf026 = sr.imaf_t_imaf026 * l_rate #安全庫存量
       LET l_imaf025 = sr.imaf_t_imaf025 * l_rate #再訂貨點量
       LET sr.l_over = sr.inag008 - l_imaf027    #超出量=庫存量-警戒庫存量
       LET sr.l_lack = l_imaf026 - sr.inag008    #缺少量=安全庫存量-庫存量
       LET sr.l_lack2 = l_imaf025 - sr.inag008   #缺少量=再訂貨點量-庫存量
       
#   1-2.列印庫存量小於零 = 'Y'，則須篩選庫存量(inag008) < 0 的資料才顯示
#       IF (tm.pr1 = 'Y' AND sr.inag008 < 0) THEN   #170109-00055#1 mark
       IF (tm.pr1 = 'Y' AND sr.inag008 < 0 AND l_flag = FALSE) THEN     #170109-00055#1 add
         LET l_flag = TRUE #170109-00055#1 add
         EXECUTE insert_prep USING sr.inagsite,sr.l_inagsite_desc,sr.imaa009,sr.l_imaa009_desc,sr.inag001,sr.imaal_t_imaal003,sr.imaal_t_imaal004,sr.inag007,sr.inag008,sr.imai_t_imai037,sr.l_imai037_desc,sr.imaf_t_imaf027,sr.l_imaf027_desc,sr.l_over,sr.imaf_t_imaf026,sr.l_imaf026_desc,sr.l_lack,sr.imaf_t_imaf025,sr.l_imaf025_desc,sr.l_lack2,sr.imaa006
       END IF       
       
#   1-3.列印超過警戒庫存量之料件 = 'Y'，則須篩選庫存量(inag008) > 警戒庫存量(imaf027) 的資料才顯示
#       IF (tm.pr2 = 'Y' AND sr.inag008 > l_imaf027) THEN    #170109-00055#1 mark
       IF (tm.pr2 = 'Y' AND sr.inag008 > l_imaf027 AND l_flag = FALSE) THEN    #170109-00055#1 add
         LET l_flag = TRUE #170109-00055#1 add
         EXECUTE insert_prep USING sr.inagsite,sr.l_inagsite_desc,sr.imaa009,sr.l_imaa009_desc,sr.inag001,sr.imaal_t_imaal003,sr.imaal_t_imaal004,sr.inag007,sr.inag008,sr.imai_t_imai037,sr.l_imai037_desc,sr.imaf_t_imaf027,sr.l_imaf027_desc,sr.l_over,sr.imaf_t_imaf026,sr.l_imaf026_desc,sr.l_lack,sr.imaf_t_imaf025,sr.l_imaf025_desc,sr.l_lack2,sr.imaa006
       END IF
#   1-4.列印低於安全存量之料件 = 'Y'，則須篩選庫存量(inag008) < 安全存量(imaf026) 的資料才顯示
#       IF (tm.pr3 = 'Y' AND sr.inag008 < l_imaf026) THEN    #170109-00055#1 mark
       IF (tm.pr3 = 'Y' AND sr.inag008 < l_imaf026 AND l_flag = FALSE) THEN    #170109-00055#1 add
         LET l_flag = TRUE #170109-00055#1 add
         EXECUTE insert_prep USING sr.inagsite,sr.l_inagsite_desc,sr.imaa009,sr.l_imaa009_desc,sr.inag001,sr.imaal_t_imaal003,sr.imaal_t_imaal004,sr.inag007,sr.inag008,sr.imai_t_imai037,sr.l_imai037_desc,sr.imaf_t_imaf027,sr.l_imaf027_desc,sr.l_over,sr.imaf_t_imaf026,sr.l_imaf026_desc,sr.l_lack,sr.imaf_t_imaf025,sr.l_imaf025_desc,sr.l_lack2,sr.imaa006
       END IF
#   1-5.列印低於再訂貨點量之料件 = 'Y'，則須篩選庫存量(inag008) < 再訂貨點量(imaf025) 的資料才顯示
#       IF (tm.pr4 = 'Y' AND sr.inag008 < l_imaf025) THEN    #170109-00055#1 mark
       IF (tm.pr4 = 'Y' AND sr.inag008 < l_imaf025 AND l_flag = FALSE) THEN    #170109-00055#1 add
         LET l_flag = TRUE #170109-00055#1 add
         EXECUTE insert_prep USING sr.inagsite,sr.l_inagsite_desc,sr.imaa009,sr.l_imaa009_desc,sr.inag001,sr.imaal_t_imaal003,sr.imaal_t_imaal004,sr.inag007,sr.inag008,sr.imai_t_imai037,sr.l_imai037_desc,sr.imaf_t_imaf027,sr.l_imaf027_desc,sr.l_over,sr.imaf_t_imaf026,sr.l_imaf026_desc,sr.l_lack,sr.imaf_t_imaf025,sr.l_imaf025_desc,sr.l_lack2,sr.imaa006
       END IF
#   1-6.呆滯料件之天數 ： 需判斷該料件之呆滯天數大於畫面輸入之天數 的資料才顯示
#       IF NOT cl_null(tm.day) AND (sr.l_imai037_desc > tm.day) THEN     #170109-00055#1 mark
       IF NOT cl_null(tm.day) AND (sr.l_imai037_desc > tm.day AND l_flag = FALSE) THEN     #170109-00055#1 add
         LET l_flag = TRUE #170109-00055#1 add
         EXECUTE insert_prep USING sr.inagsite,sr.l_inagsite_desc,sr.imaa009,sr.l_imaa009_desc,sr.inag001,sr.imaal_t_imaal003,sr.imaal_t_imaal004,sr.inag007,sr.inag008,sr.imai_t_imai037,sr.l_imai037_desc,sr.imaf_t_imaf027,sr.l_imaf027_desc,sr.l_over,sr.imaf_t_imaf026,sr.l_imaf026_desc,sr.l_lack,sr.imaf_t_imaf025,sr.l_imaf025_desc,sr.l_lack2,sr.imaa006
       END IF
       
#   1-7.若都未勾選，則列印全部正常值       
       IF (tm.pr1 = 'N' AND sr.inag008 >= 0) AND 
          (tm.pr2 = 'N' AND sr.inag008 <= l_imaf027) AND
          (tm.pr3 = 'N' AND sr.inag008 >= l_imaf026) AND
          (tm.pr4 = 'N' AND sr.inag008 >= l_imaf025) AND
          (cl_null(tm.day)) THEN
          EXECUTE insert_prep USING sr.inagsite,sr.l_inagsite_desc,sr.imaa009,sr.l_imaa009_desc,sr.inag001,sr.imaal_t_imaal003,sr.imaal_t_imaal004,sr.inag007,sr.inag008,sr.imai_t_imai037,sr.l_imai037_desc,sr.imaf_t_imaf027,sr.l_imaf027_desc,sr.l_over,sr.imaf_t_imaf026,sr.l_imaf026_desc,sr.l_lack,sr.imaf_t_imaf025,sr.l_imaf025_desc,sr.l_lack2,sr.imaa006
       END IF          
       
       CONTINUE FOREACH
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.inagsite,sr.l_inagsite_desc,sr.imaa009,sr.l_imaa009_desc,sr.inag001,sr.imaal_t_imaal003,sr.imaal_t_imaal004,sr.inag007,sr.inag008,sr.imai_t_imai037,sr.l_imai037_desc,sr.imaf_t_imaf027,sr.l_imaf027_desc,sr.l_over,sr.imaf_t_imaf026,sr.l_imaf026_desc,sr.l_lack,sr.imaf_t_imaf025,sr.l_imaf025_desc,sr.l_lack2,sr.imaa006
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "ainr150_x01_execute"
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
 
{<section id="ainr150_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION ainr150_x01_rep_data()
#add-point:rep_data.define (客製用) name="rep_data.define_customerization"

#end add-point:rep_data.define
#add-point:rep_data.define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="rep_data.define"
DEFINE l_prog_desc      LIKE type_t.chr500      #170116-00069#1  add
#end add-point:rep_data.define
 
    #add-point:rep_data.before name="rep_data.before"
    #170116-00069#1  add-S
    IF g_argv[01] = '1' THEN
       SELECT gzzal003 INTO l_prog_desc
         FROM gzzal_t
        WHERE gzzal001 = 'ainr151'
          AND gzzal002 = g_dlang
       LET g_rep_code_desc = l_prog_desc     #报表抬头
       LET g_xgrid.title2 = l_prog_desc      #浏览器页签
    END IF
    #170116-00069#1  add-E
    #end add-point:rep_data.before
    
    CALL cl_xg_view()
    #add-point:rep_data.after name="rep_data.after"
    
    #end add-point:rep_data.after
END FUNCTION
 
{</section>}
 
{<section id="ainr150_x01.other_function" readonly="Y" >}

 
{</section>}
 
