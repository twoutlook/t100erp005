#該程式未解開Section, 採用最新樣板產出!
{<section id="ainr830_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:5(2016-11-01 18:14:14), PR版次:0005(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000074
#+ Filename...: ainr830_g01
#+ Description: ...
#+ Creator....: 05423(2015-03-25 11:16:39)
#+ Modifier...: 08734 -SD/PR- 00000
 
{</section>}
 
{<section id="ainr830_g01.global" readonly="Y" >}
#報表 g01 樣板自動產生(Version:13)
#add-point:填寫註解說明 name="global.memo"
#160320-00003#1 2016-3-21  zhujing mod  控制子报表制造批序号个数与现有库存量一致
#160518-00054#1 2016-5-18  zhujing mod  添加回写aint820处理进度
#end add-point
#add-point:填寫註解說明 name="global.memo_customerization"

 
IMPORT os
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_report.inc"                  #報表使用的global
 
#報表 type 宣告
PRIVATE TYPE sr1_r RECORD
   inpddocno LIKE inpd_t.inpddocno, 
   inpd008 LIKE inpd_t.inpd008, 
   inpdseq LIKE inpd_t.inpdseq, 
   inpd015 LIKE inpd_t.inpd015, 
   inpd001 LIKE inpd_t.inpd001, 
   inpd002 LIKE inpd_t.inpd002, 
   l_inpd002_desc LIKE oocql_t.oocql004, 
   inpd005 LIKE inpd_t.inpd005, 
   l_inpd005_desc LIKE inayl_t.inayl003, 
   inpd006 LIKE inpd_t.inpd006, 
   l_inpd006_desc LIKE inab_t.inab003, 
   inpd007 LIKE inpd_t.inpd007, 
   inpd003 LIKE inpd_t.inpd003, 
   inpd010 LIKE inpd_t.inpd010, 
   inpd011 LIKE inpd_t.inpd011, 
   l_inpd011_show LIKE type_t.chr2, 
   inpdsite LIKE inpd_t.inpdsite, 
   inpdent LIKE inpd_t.inpdent, 
   l_inpd015_show LIKE type_t.chr2, 
   l_imaal003 LIKE imaal_t.imaal003, 
   l_imaal004 LIKE imaal_t.imaal004, 
   inpa024 LIKE inpa_t.inpa024, 
   inpa025 LIKE inpa_t.inpa025, 
   inpa026 LIKE inpa_t.inpa026, 
   inpa027 LIKE inpa_t.inpa027, 
   inpa028 LIKE inpa_t.inpa028, 
   inpa029 LIKE inpa_t.inpa029, 
   inpa030 LIKE inpa_t.inpa030, 
   inpa031 LIKE inpa_t.inpa031, 
   l_order LIKE type_t.chr300, 
   l_imaf052 LIKE imaf_t.imaf052, 
   l_imaf011 LIKE imaf_t.imaf011, 
   l_imaf051 LIKE imaf_t.imaf051, 
   l_imaf057 LIKE imaf_t.imaf057, 
   l_order1 LIKE type_t.chr100, 
   inpd012 LIKE inpd_t.inpd012, 
   inpd013 LIKE inpd_t.inpd013, 
   l_inpd012_show LIKE type_t.chr2
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING,                  #where condition 
       l_pr LIKE type_t.chr2,         #l_pr 
       l_pr2 LIKE type_t.chr2,         #l_pr2 
       l_pr3 LIKE type_t.chr2          #l_pr3
       END RECORD
DEFINE sr DYNAMIC ARRAY OF sr1_r                   #宣告sr為sr1_t資料結構的動態陣列
DEFINE g_select        STRING
DEFINE g_from          STRING
DEFINE g_where         STRING
DEFINE g_order         STRING
DEFINE g_sql           STRING                         #report_select_prep,REPORT段使用
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable) (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
TYPE sr3_r RECORD
   inpedocno LIKE inpe_t.inpedocno,
   inpe008_1 LIKE inpe_t.inpe008,            #製造批號
   inpe009_1 LIKE inpe_t.inpe009,            #製造序號
   inpe008_2 LIKE inpe_t.inpe008,            #製造批號
   inpe009_2 LIKE inpe_t.inpe009,            #製造序號
   inpe008_3 LIKE inpe_t.inpe008,            #製造批號
   inpe009_3 LIKE inpe_t.inpe009,            #製造序號 
   l_inpe008_1_inpe009_1 LIKE type_t.chr100, #批號/序號 1
   l_inpe008_2_inpe009_2 LIKE type_t.chr100, #批號/序號 2 
   l_inpe008_3_inpe009_3 LIKE type_t.chr100  #批號/序號 3     
END RECORD
TYPE sr4_r RECORD
   inpedocno LIKE inpe_t.inpedocno,
   inpe008_1 LIKE inpe_t.inpe008,            #製造批號
   inpe012_1 LIKE inpe_t.inpe012,            #數量
   inpe008_2 LIKE inpe_t.inpe008,            #製造批號
   inpe012_2 LIKE inpe_t.inpe012,            #數量
   inpe008_3 LIKE inpe_t.inpe008,            #製造批號
   inpe012_3 LIKE inpe_t.inpe012,            #數量 
   l_inpe008_1_inpe012_1 LIKE type_t.chr100, #批號/數量 1
   l_inpe008_2_inpe012_2 LIKE type_t.chr100, #批號/數量 2 
   l_inpe008_3_inpe012_3 LIKE type_t.chr100  #批號/數量 3       
END RECORD 
TYPE sr5_r RECORD
   inpedocno LIKE inpe_t.inpedocno,
   inpe008 LIKE inpe_t.inpe008,          #製造批號
   inpe009 LIKE inpe_t.inpe009           #製造序號
   END RECORD
TYPE sr6_r RECORD
   inpedocno LIKE inpe_t.inpedocno,
   inpe008 LIKE inpe_t.inpe008,          #製造批號
   inpe012 LIKE inpe_t.inpe012           #數量
END RECORD
DEFINE sr5 DYNAMIC ARRAY OF sr5_r
DEFINE sr6 DYNAMIC ARRAY OF sr6_r
DEFINE l_field_order     STRING
#end add-point
 
{</section>}
 
{<section id="ainr830_g01.main" readonly="Y" >}
PUBLIC FUNCTION ainr830_g01(p_arg1,p_arg2,p_arg3,p_arg4)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr2         #tm.l_pr  l_pr 
DEFINE  p_arg3 LIKE type_t.chr2         #tm.l_pr2  l_pr2 
DEFINE  p_arg4 LIKE type_t.chr2         #tm.l_pr3  l_pr3
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.l_pr = p_arg2
   LET tm.l_pr2 = p_arg3
   LET tm.l_pr3 = p_arg4
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "ainr830_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL ainr830_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL ainr830_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL ainr830_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="ainr830_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION ainr830_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
 
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
#   LET g_select = " SELECT DISTINCT inpddocno,inpd008,inpdseq,inpd015,inpd001,inpd002,NULL,inpd005,NULL,inpd006,",
#                  " NULL,inpd007,inpd003,inpd010,inpd011,'N',inpdsite,inpdent,'N',imaal003,imaal004,inpa024,inpa025,inpa026,", 
#                  " inpa027,inpa028,inpa029,inpa030,inpa031,NULL,imaf052,imaf011,imaf051,imaf057 "
#  僅抓取盤點計畫單號及列印順序:inpa024-inpa031;並按照盤點計畫單號進行排序
   LET g_select = " SELECT DISTINCT NULL,inpd008,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,",
                  " NULL,NULL,NULL,NULL,NULL,'N',inpdsite,inpdent,'N',NULL,NULL,inpa024,inpa025,inpa026,", 
                  " inpa027,inpa028,inpa029,inpa030,inpa031,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL "                  
#   #end add-point
#   LET g_select = " SELECT inpddocno,inpd008,inpdseq,inpd015,inpd001,inpd002,NULL,inpd005,NULL,inpd006, 
#       NULL,inpd007,inpd003,inpd010,inpd011,NULL,inpdsite,inpdent,NULL,NULL,NULL,inpa024,inpa025,inpa026, 
#       inpa027,inpa028,inpa029,inpa030,inpa031,NULL,NULL,NULL,NULL,NULL,NULL,inpd012,inpd013,NULL"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
#    LET g_from = " FROM inpd_t LEFT OUTER JOIN inpa_t ON inpadocno = inpd008 AND inpaent = inpdent AND inpasite = inpdsite ",
#                 "             LEFT OUTER JOIN imaf_t ON imaf001 = inpd001 AND imafent = inpdent AND imafsite = inpdsite ",
#                 "             LEFT OUTER JOIN imaal_t ON imaal001 = inpd001 AND imaalent = inpdent AND imaal002 = '",g_dlang,"' "
    LET g_from = " FROM inpd_t LEFT OUTER JOIN inpa_t ON inpadocno = inpd008 AND inpaent = inpdent AND inpasite = inpdsite "
#   #end add-point
#    LET g_from = " FROM inpd_t,inpa_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
    
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
    
   #end add-point
    LET g_order = " ORDER BY inpd008"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("inpd_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE ainr830_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE ainr830_g01_curs CURSOR FOR ainr830_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="ainr830_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION ainr830_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   inpddocno LIKE inpd_t.inpddocno, 
   inpd008 LIKE inpd_t.inpd008, 
   inpdseq LIKE inpd_t.inpdseq, 
   inpd015 LIKE inpd_t.inpd015, 
   inpd001 LIKE inpd_t.inpd001, 
   inpd002 LIKE inpd_t.inpd002, 
   l_inpd002_desc LIKE oocql_t.oocql004, 
   inpd005 LIKE inpd_t.inpd005, 
   l_inpd005_desc LIKE inayl_t.inayl003, 
   inpd006 LIKE inpd_t.inpd006, 
   l_inpd006_desc LIKE inab_t.inab003, 
   inpd007 LIKE inpd_t.inpd007, 
   inpd003 LIKE inpd_t.inpd003, 
   inpd010 LIKE inpd_t.inpd010, 
   inpd011 LIKE inpd_t.inpd011, 
   l_inpd011_show LIKE type_t.chr2, 
   inpdsite LIKE inpd_t.inpdsite, 
   inpdent LIKE inpd_t.inpdent, 
   l_inpd015_show LIKE type_t.chr2, 
   l_imaal003 LIKE imaal_t.imaal003, 
   l_imaal004 LIKE imaal_t.imaal004, 
   inpa024 LIKE inpa_t.inpa024, 
   inpa025 LIKE inpa_t.inpa025, 
   inpa026 LIKE inpa_t.inpa026, 
   inpa027 LIKE inpa_t.inpa027, 
   inpa028 LIKE inpa_t.inpa028, 
   inpa029 LIKE inpa_t.inpa029, 
   inpa030 LIKE inpa_t.inpa030, 
   inpa031 LIKE inpa_t.inpa031, 
   l_order LIKE type_t.chr300, 
   l_imaf052 LIKE imaf_t.imaf052, 
   l_imaf011 LIKE imaf_t.imaf011, 
   l_imaf051 LIKE imaf_t.imaf051, 
   l_imaf057 LIKE imaf_t.imaf057, 
   l_order1 LIKE type_t.chr100, 
   inpd012 LIKE inpd_t.inpd012, 
   inpd013 LIKE inpd_t.inpd013, 
   l_inpd012_show LIKE type_t.chr2
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_success  LIKE type_t.chr2
DEFINE l_cnt2     LIKE type_t.num5     #存放按照列印排序順序後的序號
DEFINE l_tmp      LIKE type_t.chr100   #存放按照列印排序順序後的序號
DEFINE l_sql              STRING       #抓取正式信息
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    INITIALIZE l_tmp TO NULL
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH ainr830_g01_curs INTO sr_s.*
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
       LET l_field_order = NULL
       #計算順序 l_field_order
       #第一位為排序順序欄位
       #第二位TRUE為排序第一個
       #第三位為分群碼
       CALL ainr830_g01_inpd_order(sr_s.inpa025,TRUE,sr_s.inpa031) 
       CALL ainr830_g01_inpd_order(sr_s.inpa026,FALSE,sr_s.inpa031) 
       CALL ainr830_g01_inpd_order(sr_s.inpa027,FALSE,sr_s.inpa031) 
       CALL ainr830_g01_inpd_order(sr_s.inpa028,FALSE,sr_s.inpa031) 
       CALL ainr830_g01_inpd_order(sr_s.inpa029,FALSE,sr_s.inpa031) 
       CALL ainr830_g01_inpd_order(sr_s.inpa030,FALSE,sr_s.inpa031) 
       IF cl_null(l_field_order) THEN
          LET l_field_order = " 1=1 ORDER BY inpddocno"
       ELSE
          LET l_field_order = l_field_order,",inpddocno"  
       END IF
       LET l_cnt2 = 1
       #獲取所有資料
       LET l_sql = " SELECT DISTINCT inpddocno,inpd008,inpdseq,inpd015,inpd001,inpd002,NULL,inpd005,NULL,inpd006,",
                   " NULL,inpd007,inpd003,inpd010,inpd011,'N',inpdsite,inpdent,'N',imaal003,imaal004,inpa024,inpa025,inpa026,", 
                   " inpa027,inpa028,inpa029,inpa030,inpa031,NULL,imaf052,imaf011,imaf051,imaf057,NULL,inpd012,inpd013,'N' ",
                   " FROM inpd_t LEFT OUTER JOIN inpa_t ON inpadocno = inpd008 AND inpaent = inpdent AND inpasite = inpdsite ",
                   "             LEFT OUTER JOIN imaf_t ON imaf001 = inpd001 AND imafent = inpdent AND imafsite = inpdsite ",
                   "             LEFT OUTER JOIN imaal_t ON imaal001 = inpd001 AND imaalent = inpdent AND imaal002 = '",g_dlang,"' ",
                   " WHERE ",tm.wc CLIPPED, " AND inpd008 = '",sr_s.inpd008 CLIPPED,"' AND ",l_field_order CLIPPED
       PREPARE ainr830_g01_pre01 FROM l_sql
       DECLARE ainr830_g01_cur01 CURSOR FOR ainr830_g01_pre01
       FOREACH ainr830_g01_cur01 INTO sr_s.*
         IF STATUS THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'foreach:'
            LET g_errparam.code   = STATUS
            LET g_errparam.popup  = TRUE
            CALL cl_err()       
            LET g_rep_success = 'N'    
            EXIT FOREACH
         END IF
         
         #參考欄位顯示否
         LET sr_s.l_inpd012_show = tm.l_pr2         
         #獲取說明
         #產品特征inpd002
         IF NOT cl_null(sr_s.inpd002) THEN
            CALL s_feature_description(sr_s.inpd001,sr_s.inpd002) RETURNING l_success,sr_s.l_inpd002_desc
            LET sr_s.l_inpd002_desc = sr_s.inpd002 CLIPPED,".",sr_s.l_inpd002_desc CLIPPED
         ELSE 
            LET sr_s.l_inpd002_desc = NULL
         END IF
         #庫位    inpd005
         IF NOT cl_null(sr_s.inpd005) THEN
            CALL ainr830_g01_desc('1',sr_s.inpd005,'') RETURNING sr_s.l_inpd005_desc
            LET sr_s.l_inpd005_desc = sr_s.inpd005,'.',sr_s.l_inpd005_desc
         END IF
         #儲位    inpd006
         IF NOT cl_null(sr_s.inpd006) THEN
            CALL ainr830_g01_desc('2',sr_s.inpd005,sr_s.inpd006) RETURNING sr_s.l_inpd006_desc
            LET sr_s.l_inpd006_desc = sr_s.inpd006,'.',sr_s.l_inpd006_desc
         END IF
       
         IF sr_s.inpa024 != 'N' THEN
            LET sr_s.l_inpd011_show = sr_s.inpa024
         END IF
         IF NOT cl_null(sr_s.inpd015) THEN 
            LET sr_s.l_inpd015_show = 'Y'
         END IF
         
         LET l_tmp = l_cnt2 USING '&&&&&&&&&&'
         LET sr_s.l_order = sr_s.inpd008 CLIPPED,'-',l_cnt2 CLIPPED     #l_order=盤點計畫單號+同一單號下標籤排序序號
         LET l_cnt2 = l_cnt2 + 1
#         LET l_tmp = sr_s.inpdseq USING '&&&&&&&&&&&&'
#         LET sr_s.l_order1 = sr_s.inpddocno CLIPPED,'-',l_tmp CLIPPED
       
#       #計算順序 l_order
#       CALL ainr830_g01_inpd_order(sr_s.inpa025,TRUE,sr_s.inpa031,sr_s.*) RETURNING sr_s.l_order
#       CALL ainr830_g01_inpd_order(sr_s.inpa026,FALSE,sr_s.inpa031,sr_s.*) RETURNING sr_s.l_order
#       CALL ainr830_g01_inpd_order(sr_s.inpa027,FALSE,sr_s.inpa031,sr_s.*) RETURNING sr_s.l_order
#       CALL ainr830_g01_inpd_order(sr_s.inpa028,FALSE,sr_s.inpa031,sr_s.*) RETURNING sr_s.l_order
#       CALL ainr830_g01_inpd_order(sr_s.inpa029,FALSE,sr_s.inpa031,sr_s.*) RETURNING sr_s.l_order
#       CALL ainr830_g01_inpd_order(sr_s.inpa030,FALSE,sr_s.inpa031,sr_s.*) RETURNING sr_s.l_order

       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].inpddocno = sr_s.inpddocno
       LET sr[l_cnt].inpd008 = sr_s.inpd008
       LET sr[l_cnt].inpdseq = sr_s.inpdseq
       LET sr[l_cnt].inpd015 = sr_s.inpd015
       LET sr[l_cnt].inpd001 = sr_s.inpd001
       LET sr[l_cnt].inpd002 = sr_s.inpd002
       LET sr[l_cnt].l_inpd002_desc = sr_s.l_inpd002_desc
       LET sr[l_cnt].inpd005 = sr_s.inpd005
       LET sr[l_cnt].l_inpd005_desc = sr_s.l_inpd005_desc
       LET sr[l_cnt].inpd006 = sr_s.inpd006
       LET sr[l_cnt].l_inpd006_desc = sr_s.l_inpd006_desc
       LET sr[l_cnt].inpd007 = sr_s.inpd007
       LET sr[l_cnt].inpd003 = sr_s.inpd003
       LET sr[l_cnt].inpd010 = sr_s.inpd010
       LET sr[l_cnt].inpd011 = sr_s.inpd011
       LET sr[l_cnt].l_inpd011_show = sr_s.l_inpd011_show
       LET sr[l_cnt].inpdsite = sr_s.inpdsite
       LET sr[l_cnt].inpdent = sr_s.inpdent
       LET sr[l_cnt].l_inpd015_show = sr_s.l_inpd015_show
       LET sr[l_cnt].l_imaal003 = sr_s.l_imaal003
       LET sr[l_cnt].l_imaal004 = sr_s.l_imaal004
       LET sr[l_cnt].inpa024 = sr_s.inpa024
       LET sr[l_cnt].inpa025 = sr_s.inpa025
       LET sr[l_cnt].inpa026 = sr_s.inpa026
       LET sr[l_cnt].inpa027 = sr_s.inpa027
       LET sr[l_cnt].inpa028 = sr_s.inpa028
       LET sr[l_cnt].inpa029 = sr_s.inpa029
       LET sr[l_cnt].inpa030 = sr_s.inpa030
       LET sr[l_cnt].inpa031 = sr_s.inpa031
       LET sr[l_cnt].l_order = sr_s.l_order
       LET sr[l_cnt].l_imaf052 = sr_s.l_imaf052
       LET sr[l_cnt].l_imaf011 = sr_s.l_imaf011
       LET sr[l_cnt].l_imaf051 = sr_s.l_imaf051
       LET sr[l_cnt].l_imaf057 = sr_s.l_imaf057
       LET sr[l_cnt].l_order1 = sr_s.l_order1
       LET sr[l_cnt].inpd012 = sr_s.inpd012
       LET sr[l_cnt].inpd013 = sr_s.inpd013
       LET sr[l_cnt].l_inpd012_show = sr_s.l_inpd012_show
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    END FOREACH
    CALL sr.deleteElement(l_cnt)
    
    CALL cl_err_collect_init()   #错误信息收集
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="ainr830_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION ainr830_g01_rep_data()
   DEFINE HANDLER         om.SaxDocumentHandler
   DEFINE l_i             INTEGER
 
    #判斷是否有報表資料，若回彈出訊息視窗
    IF sr.getLength() = 0 THEN
       INITIALIZE g_errparam TO NULL
       LET g_errparam.code = "adz-00285"
       LET g_errparam.extend = NULL
       LET g_errparam.popup  = FALSE
       LET g_errparam.replace[1] = ''
       CALL cl_err()  
       RETURN 
    END IF
    WHILE TRUE   
       #add-point:rep_data段印前 name="rep_data.before"
       
       #end add-point     
       LET handler = cl_gr_handler()
       IF handler IS NOT NULL THEN
          START REPORT ainr830_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT ainr830_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT ainr830_g01_rep
       END IF
       #add-point:rep_data段印完 name="rep_data.after"
       
       #end add-point       
       IF g_rep_flag = TRUE THEN
          LET g_rep_flag = FALSE
          EXIT WHILE
       END IF
    END WHILE
    #add-point:rep_data段離開while印完前 name="rep_data.end.before"
    
    #end add-point
    CALL cl_gr_close_report()
    #add-point:rep_data段離開while印完後 name="rep_data.end.after"
    
    #end add-point    
END FUNCTION
 
{</section>}
 
{<section id="ainr830_g01.rep" readonly="Y" >}
PRIVATE REPORT ainr830_g01_rep(sr1)
DEFINE sr1 sr1_r
DEFINE sr2 sr2_r
DEFINE l_subrep01_show  LIKE type_t.chr1,
       l_subrep02_show  LIKE type_t.chr1,
       l_subrep03_show  LIKE type_t.chr1,
       l_subrep04_show  LIKE type_t.chr1
DEFINE l_cnt           LIKE type_t.num10
DEFINE l_sub_sql       STRING
#add-point:rep段define  (客製用) name="rep.define_customerization"

#end add-point
#add-point:rep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="rep.define"
DEFINE sr3       sr3_r
DEFINE sr4       sr4_r
DEFINE l_ac              INTEGER
DEFINE l_i               INTEGER
DEFINE l_count           INTEGER
DEFINE l_subrep05_show   LIKE type_t.chr1
DEFINE l_subrep06_show   LIKE type_t.chr1
DEFINE l_show1    LIKE type_t.chr2
DEFINE l_show2    LIKE type_t.chr2
DEFINE l_inpd008         LIKE inpd_t.inpd008
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER  BY sr1.l_order,sr1.inpd008
    #add-point:rep段ORDER_after name="rep.order.after"
    ASC
    #end add-point
    
    FORMAT
       FIRST PAGE HEADER          
          PRINTX g_user,g_pdate,g_rep_code,g_company,g_ptime,g_user_name,g_date_fmt
          PRINTX tm.*
          PRINTX g_grNumFmt.*
          PRINTX g_rep_wcchp
 
          #讀取beforeGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.l_order
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            IF cl_null(l_inpd008) OR l_inpd008 <> sr1.inpd008 THEN      #若有新盘点计划单号，则进行回写
               LET l_inpd008 = sr1.inpd008
               #呼叫回写function
               CALL ainr830_g01_update_inpb002(l_inpd008,sr1.inpdent,sr1.inpdsite)
            END IF
            #end add-point:rep.header 
            LET g_rep_docno = sr1.l_order
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'inpdent=' ,sr1.inpdent,'{+}inpdsite=' ,sr1.inpdsite,'{+}inpddocno=' ,sr1.inpddocno,'{+}inpdseq=' ,sr1.inpdseq         
            CALL cl_gr_init_apr(sr1.l_order)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.l_order.before name="rep.b_group.l_order.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooff004=0 AND ooffent = '", 
                sr1.inpdent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_order CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE ainr830_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE ainr830_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT ainr830_g01_subrep01
           DECLARE ainr830_g01_repcur01 CURSOR FROM g_sql
           FOREACH ainr830_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "ainr830_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT ainr830_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT ainr830_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.l_order.after name="rep.b_group.l_order.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.inpd008
 
           #add-point:rep.b_group.inpd008.before name="rep.b_group.inpd008.before"
           LET l_show1 = sr1.l_inpd015_show
           LET l_show2 = sr1.l_inpd011_show
           PRINTX l_show1
           PRINTX l_show2
           
           #end add-point:
 
 
           #add-point:rep.b_group.inpd008.after name="rep.b_group.inpd008.after"
           
           #end add-point:
 
 
 
 
       ON EVERY ROW
          #add-point:rep.everyrow.before name="rep.everyrow.before"
          
          #end add-point:rep.everyrow.before
 
          #單身前備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub02.before name="rep.sub02.before"
           
           #end add-point:rep.sub02.before
 
           #add-point:rep.sub02.sql name="rep.sub02.sql"
           
           #end add-point:rep.sub02.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='2' AND ooffent = '", 
                sr1.inpdent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_order CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.inpd008 CLIPPED ,""
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE ainr830_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE ainr830_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT ainr830_g01_subrep02
           DECLARE ainr830_g01_repcur02 CURSOR FROM g_sql
           FOREACH ainr830_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "ainr830_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT ainr830_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT ainr830_g01_subrep02
           #add-point:rep.sub02.after name="rep.sub02.after"
           
           #end add-point:rep.sub02.after
 
 
 
          #add-point:rep.everyrow.beforerow name="rep.everyrow.beforerow"
          
          #end add-point:rep.everyrow.beforerow
            
          PRINTX sr1.*
 
          #add-point:rep.everyrow.afterrow name="rep.everyrow.afterrow"
          
          #end add-point:rep.everyrow.afterrow
 
          #單身後備註
             #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub03.before name="rep.sub03.before"
           
           #end add-point:rep.sub03.before
 
           #add-point:rep.sub03.sql name="rep.sub03.sql"
           
           #end add-point:rep.sub03.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooffent = '", 
                sr1.inpdent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_order CLIPPED ,"'", " AND  ooff004 = ", 
                sr1.inpd008 CLIPPED ,""
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE ainr830_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE ainr830_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT ainr830_g01_subrep03
           DECLARE ainr830_g01_repcur03 CURSOR FROM g_sql
           FOREACH ainr830_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "ainr830_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT ainr830_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT ainr830_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           LET g_sql = "SELECT inpedocno,inpe008,inpe009",
                        "  FROM inpe_t ",
                        " WHERE inpeent     = '",sr1.inpdent      CLIPPED,"'",                                               
                        "   AND inpesite    = '",sr1.inpdsite     CLIPPED,"'",
                        "   AND inpedocno   = '",sr1.inpddocno        CLIPPED,"'",                    
                        "   AND inpeseq     = '",sr1.inpdseq      CLIPPED,"'",
                        "   AND inpe008 IS NOT NULL AND inpe008 <> ' ' ",
                        "   AND inpe009 IS NOT NULL AND inpe009 <> ' ' ",
                        "   AND inpe012 > 0 "        #160320-00003#1 2016-3-21 zhujing add
                        
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE ainr830_g01_repcur05_cnt_pre FROM l_sub_sql
           EXECUTE ainr830_g01_repcur05_cnt_pre INTO l_cnt
           IF l_cnt > 0 AND tm.l_pr = 'Y' AND l_subrep06_show = 'N' THEN 
              LET l_subrep05_show ="Y"
           ELSE 
              LET l_subrep05_show ="N"
           END IF                       
           PRINTX l_subrep05_show 
           START REPORT ainr830_g01_subrep05           
           IF tm.l_pr ="Y" THEN                     

              LET l_ac = 1                              
              CALL sr5.clear()                 
              DECLARE ainr830_g01_repcur05 CURSOR FROM g_sql
              FOREACH ainr830_g01_repcur05 INTO sr5[l_ac].*  
                 LET l_ac = l_ac+1      
              END FOREACH   
          
               
              LET l_ac = l_ac-1               
              LET l_i = 1                       
              IF l_ac > 0 THEN      
                 WHILE TRUE                         
                    INITIALIZE sr3.* TO NULL
                    LET sr3.inpedocno = sr5[l_i].inpedocno
                    LET sr3.inpe008_1 = sr5[l_i].inpe008
                    LET sr3.inpe009_1 = sr5[l_i].inpe009
                    LET sr3.l_inpe008_1_inpe009_1  = sr3.inpe008_1  , "/" , sr3.inpe009_1                                                                                         
                    IF l_i+1 <= l_ac THEN    
                       LET sr3.inpedocno = sr5[l_i+1].inpedocno
                       LET sr3.inpe008_2 = sr5[l_i+1].inpe008
                       LET sr3.inpe009_2 = sr5[l_i+1].inpe009
                       LET sr3.l_inpe008_2_inpe009_2 =  sr3.inpe008_2 , "/" , sr3.inpe009_2
                    END IF
                    
                    IF l_i+2 <= l_ac THEN    
                       LET sr3.inpedocno = sr5[l_i+2].inpedocno
                       LET sr3.inpe008_3 = sr5[l_i+2].inpe008
                       LET sr3.inpe009_3 = sr5[l_i+2].inpe009                  
                       LET sr3.l_inpe008_3_inpe009_3 = sr3.inpe008_3 , "/" , sr3.inpe009_3
                    END IF              
                           
                    OUTPUT TO REPORT ainr830_g01_subrep05(sr3.*)              
                    LET l_i = l_i + 3
                    IF l_i > l_ac THEN  
                       EXIT WHILE
                    END IF                     
                 END  WHILE                                                
              END IF                    
           END IF                      
           FINISH REPORT ainr830_g01_subrep05
 
           LET g_sql = "SELECT inpedocno,inpe008,inpe012",
                       "  FROM inpe_t ",
                       " WHERE inpeent     = '",sr1.inpdent      CLIPPED,"'",                                               
                       "   AND inpesite    = '",sr1.inpdsite     CLIPPED,"'",
                       "   AND inpedocno   = '",sr1.inpddocno        CLIPPED,"'",                    
                       "   AND inpeseq     = '",sr1.inpdseq      CLIPPED,"'",
                       "   AND inpe008 IS NOT NULL AND inpe008 <> ' ' ",
                       "   AND inpe012 > 0 "        #160320-00003#1 2016-3-21 zhujing add
                                              
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE ainr830_g01_repcur06_cnt_pre FROM l_sub_sql
           EXECUTE ainr830_g01_repcur06_cnt_pre INTO l_cnt
           IF l_cnt > 0 AND tm.l_pr = 'Y' AND l_subrep05_show = 'N' THEN 
              LET l_subrep06_show ="Y"
           ELSE 
              LET l_subrep06_show ="N"
           END IF                       
           PRINTX l_subrep06_show      
           START REPORT ainr830_g01_subrep06          
           IF tm.l_pr ="Y" THEN          
            
              LET l_ac = 1                              
              CALL sr6.clear()                 
              DECLARE ainr830_g01_repcur06 CURSOR FROM g_sql
              FOREACH ainr830_g01_repcur06 INTO sr6[l_ac].*
                  LET l_ac = l_ac+1                                
              END FOREACH  
              
              LET l_ac = l_ac-1               
              LET l_i = 1                           
              IF l_ac > 0 THEN
                 WHILE TRUE                         
                    INITIALIZE sr4.* TO NULL
                    LET sr4.inpedocno = sr6[l_i].inpedocno
                    LET sr4.inpe008_1 = sr6[l_i].inpe008
                    LET sr4.inpe012_1 = sr6[l_i].inpe012
                    LET sr4.l_inpe008_1_inpe012_1  = sr4.inpe008_1  , "/" , sr4.inpe012_1                                                                                         
                    IF l_i+1 <= l_ac THEN    
                       LET sr4.inpedocno = sr6[l_i].inpedocno
                       LET sr4.inpe008_2 = sr6[l_i+1].inpe008
                       LET sr4.inpe012_2 = sr6[l_i+1].inpe012
                       LET sr4.l_inpe008_2_inpe012_2 =  sr4.inpe008_2 , "/" , sr4.inpe012_2                              
                    END IF
                    
                    IF l_i+2 <= l_ac THEN    
                       LET sr4.inpedocno = sr6[l_i].inpedocno
                       LET sr4.inpe008_3 = sr6[l_i+2].inpe008
                       LET sr4.inpe012_3 = sr6[l_i+2].inpe012                  
                       LET sr4.l_inpe008_3_inpe012_3 = sr4.inpe008_3 , "/" , sr4.inpe012_3
                    END IF              
                           
                    OUTPUT TO REPORT ainr830_g01_subrep06(sr4.*)              
                    LET l_i = l_i + 3
                    IF l_i > l_ac THEN  
                       EXIT WHILE
                    END IF                     
                 END  WHILE 
              END IF                    
           END IF
                       
           FINISH REPORT ainr830_g01_subrep06  
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.l_order
 
           #add-point:rep.a_group.l_order.before name="rep.a_group.l_order.before"
           
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooff004=0 AND ooffent = '", 
                sr1.inpdent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_order CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE ainr830_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE ainr830_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT ainr830_g01_subrep04
           DECLARE ainr830_g01_repcur04 CURSOR FROM g_sql
           FOREACH ainr830_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "ainr830_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT ainr830_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT ainr830_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.l_order.after name="rep.a_group.l_order.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.inpd008
 
           #add-point:rep.a_group.inpd008.before name="rep.a_group.inpd008.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.inpd008.after name="rep.a_group.inpd008.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
            CALL cl_err_collect_show()       #错误信息显示
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="ainr830_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT ainr830_g01_subrep01(sr2)
DEFINE  sr2  sr2_r
#add-point:query段define(客製用) name="sub01.define_customerization" 

#end add-point
#add-point:sub01.define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sub01.define" 

#end add-point:sub01.define
 
    #add-point:sub01.order.before name="sub01.order.before" 
    
    #end add-point:sub01.order.before
 
 
 
    FORMAT
 
 
 
       ON EVERY ROW
            #add-point:sub01.everyrow.before name="sub01.everyrow.before" 
                          
            #end add-point:sub01.everyrow.before
 
            PRINTX sr2.*
 
            #add-point:sub01.everyrow.after name="sub01.everyrow.after" 
            
            #end add-point:sub01.everyrow.after
 
 
END REPORT
 
 
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT ainr830_g01_subrep02(sr2)
DEFINE  sr2  sr2_r
#add-point:query段define(客製用) name="sub02.define_customerization" 

#end add-point
#add-point:sub02.define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sub02.define" 

#end add-point:sub02.define
 
    #add-point:sub02.order.before name="sub02.order.before" 
    
    #end add-point:sub02.order.before
 
 
 
    FORMAT
 
 
 
       ON EVERY ROW
            #add-point:sub02.everyrow.before name="sub02.everyrow.before" 
                          
            #end add-point:sub02.everyrow.before
 
            PRINTX sr2.*
 
            #add-point:sub02.everyrow.after name="sub02.everyrow.after" 
            
            #end add-point:sub02.everyrow.after
 
 
END REPORT
 
 
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT ainr830_g01_subrep03(sr2)
DEFINE  sr2  sr2_r
#add-point:query段define(客製用) name="sub03.define_customerization" 

#end add-point
#add-point:sub03.define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sub03.define" 

#end add-point:sub03.define
 
    #add-point:sub03.order.before name="sub03.order.before" 
    
    #end add-point:sub03.order.before
 
 
 
    FORMAT
 
 
 
       ON EVERY ROW
            #add-point:sub03.everyrow.before name="sub03.everyrow.before" 
                          
            #end add-point:sub03.everyrow.before
 
            PRINTX sr2.*
 
            #add-point:sub03.everyrow.after name="sub03.everyrow.after" 
            
            #end add-point:sub03.everyrow.after
 
 
END REPORT
 
 
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT ainr830_g01_subrep04(sr2)
DEFINE  sr2  sr2_r
#add-point:query段define(客製用) name="sub04.define_customerization" 

#end add-point
#add-point:sub04.define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sub04.define" 

#end add-point:sub04.define
 
    #add-point:sub04.order.before name="sub04.order.before" 
    
    #end add-point:sub04.order.before
 
 
 
    FORMAT
 
 
 
       ON EVERY ROW
            #add-point:sub04.everyrow.before name="sub04.everyrow.before" 
                          
            #end add-point:sub04.everyrow.before
 
            PRINTX sr2.*
 
            #add-point:sub04.everyrow.after name="sub04.everyrow.after" 
            
            #end add-point:sub04.everyrow.after
 
 
END REPORT
 
 
 
 
{</section>}
 
{<section id="ainr830_g01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 獲取排序
# Memo...........:
# Usage..........: CALL ainr830_g01_inpd_order(p_order,p_flag,p_inpa031,sr_tmp)
#                  RETURNING 回传参数
# Input parameter: p_order        傳入欄位順序一~六
#                : p_flag         是否是第一個順序
#                : p_inpa031      分群碼選項
#                : sr_tmp         數組
# Return code....: g_sql    
################################################################################
PRIVATE FUNCTION ainr830_g01_inpd_order(p_order,p_flag,p_inpa031)
DEFINE p_order   LIKE type_t.chr1
DEFINE p_flag    LIKE type_t.num5
DEFINE p_inpa031 LIKE inpa_t.inpa031
#DEFINE sr_tmp    sr1_r

   IF cl_null(p_order) OR p_order = '7' THEN
      RETURN #NULL
   END IF    
   IF cl_null(l_field_order) THEN LET l_field_order = " 1=1 " END IF
   IF p_flag THEN
      LET l_field_order = l_field_order ," ORDER BY "
   END IF
   IF p_order = '1' THEN
      IF p_flag THEN 
         LET l_field_order = l_field_order," imaf052"
#         LET sr_tmp.l_order = sr_tmp.l_imaf052 USING '&&&&&&&&'
      ELSE
         LET l_field_order = l_field_order,",imaf052"  
#         LET sr_tmp.l_order = sr_tmp.l_order CLIPPED,'-',sr_tmp.l_imaf052 USING '&&&&&&&&&&&&'
      END IF         
   END IF
   IF p_order = '2' THEN
      IF p_flag THEN   
         LET l_field_order = l_field_order," inpd005"
#         LET sr_tmp.l_order = sr_tmp.inpd005 USING '&&&&&&&&&&&&'
      ELSE
         LET l_field_order = l_field_order,",inpd005"
#         LET sr_tmp.l_order = sr_tmp.l_order CLIPPED,'-',sr_tmp.inpd005 USING '&&&&&&&&&&&&'
      END IF   
   END IF  
   IF p_order = '3' THEN
      IF p_flag THEN   
         LET l_field_order = l_field_order," inpd006"
#         LET sr_tmp.l_order = sr_tmp.inpd006 USING '&&&&&&&&&&&&'
      ELSE
         LET l_field_order = l_field_order,",inpd006"
#         LET sr_tmp.l_order = sr_tmp.l_order CLIPPED,'-',sr_tmp.inpd006 USING '&&&&&&&&&&&&'
      END IF
   END IF    
   IF p_order = '4' THEN
      IF p_flag THEN   
         LET l_field_order = l_field_order," inpd007"
#         LET sr_tmp.l_order = sr_tmp.inpd007 USING '&&&&&&&&&&&&'
      ELSE
         LET l_field_order = l_field_order,",inpd007"
#         LET sr_tmp.l_order = sr_tmp.l_order CLIPPED,'-',sr_tmp.inpd007 USING '&&&&&&&&&&&&'
      END IF
   END IF
   IF p_order = '5' THEN
      IF p_flag THEN   
         LET l_field_order = l_field_order," inpd001"
#         LET sr_tmp.l_order = sr_tmp.inpd001 USING '&&&&&&&&&&&&'
      ELSE
         LET l_field_order = l_field_order,",inpd001"
#         LET sr_tmp.l_order = sr_tmp.l_order CLIPPED,'-',sr_tmp.inpd001 USING '&&&&&&&&&&&&'
      END IF
   END IF 
   IF p_order = '6' THEN
      IF p_inpa031 = '1' THEN    #產品分群
         IF p_flag THEN 
            LET l_field_order = l_field_order," imaf011"
#            LET sr_tmp.l_order = sr_tmp.l_imaf011 USING '&&&&&&&&&&&&'
         ELSE
            LET l_field_order = l_field_order,",imaf011"  
#            LET sr_tmp.l_order = sr_tmp.l_order CLIPPED,'-',sr_tmp.l_imaf011 USING '&&&&&&&&&&&&'
         END IF 
      END IF
      IF p_inpa031 = '2' THEN    #庫存分群
         IF p_flag THEN 
            LET l_field_order = l_field_order," imaf051"
#            LET sr_tmp.l_order = sr_tmp.l_imaf051 USING '&&&&&&&&&&&&'
         ELSE
            LET l_field_order = l_field_order,",imaf051"  
#            LET sr_tmp.l_order = sr_tmp.l_order CLIPPED,'-',sr_tmp.l_imaf051 USING '&&&&&&&&&&&&'
         END IF
      END IF
   END IF   
   IF p_order = '8' THEN
      IF p_flag THEN 
         LET l_field_order = l_field_order," imaf057"
#         LET sr_tmp.l_order = sr_tmp.l_imaf057 USING '&&&&&&&&&&&&'
      ELSE
         LET l_field_order = l_field_order,",imaf057"  
#         LET sr_tmp.l_order = sr_tmp.l_order CLIPPED,'-',sr_tmp.l_imaf057 USING '&&&&&&&&&&&&'
      END IF
   END IF
   
#   RETURN sr_tmp.l_order
END FUNCTION

#GET DESC
PRIVATE FUNCTION ainr830_g01_desc(p_class,p_target,p_target2)
   DEFINE p_class  LIKE type_t.chr2
   DEFINE p_target LIKE type_t.chr10
   DEFINE p_target2 LIKE type_t.chr10
   DEFINE r_desc   LIKE type_t.chr500
   
   CASE p_class
   WHEN '1' #获取庫位說明
      SELECT inayl003 INTO r_desc
        FROM inayl_t
       WHERE inayl001 = p_target
         AND inayl002 = g_dlang
         AND inaylent = g_enterprise
         
   WHEN '2' #获取儲位說明
      SELECT inab003 INTO r_desc
        FROM inab_t
       WHERE inab001 = p_target
         AND inab002 = p_target2
         AND inabsite = g_site
         AND inabent = g_enterprise

   END CASE
   
   RETURN r_desc 
END FUNCTION

################################################################################
# Descriptions...: 列印后回写至aint820
# Memo...........:
# Usage..........: CALL ainr830_g01_update_inpb002(p_inpd008,p_ent,p_site)
# Date & Author..: 2015-9-9 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION ainr830_g01_update_inpb002(p_inpd008,p_ent,p_site)
DEFINE p_inpd008     LIKE inpd_t.inpd008
DEFINE p_ent         LIKE inpf_t.inpfent
DEFINE p_site        LIKE inpf_t.inpfsite
DEFINE l_inpa023     LIKE inpa_t.inpa023

   SELECT inpa023 INTO l_inpa023       #判断是否需要回写
     FROM inpa_t  
     LEFT OUTER JOIN inpb_t ON inpadocno = inpbdocno AND inpaent = inpbent
    WHERE inpaent = p_ent
      AND inpasite = p_site 
      AND inpadocno = p_inpd008
      AND inpb001 = '3'
      AND inpa023 IN ('1','3')
   IF cl_null(l_inpa023) THEN
      RETURN
   END IF
   
   UPDATE inpb_t SET inpb002 = 'Y',     #进行回写
                     inpb003 = 100      #160518-00054#1 2016-5-18 add    
   WHERE inpbdocno = p_inpd008 AND inpbent = p_ent AND inpbsite = p_site AND inpb001 = '3'
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = "inpb_t" 
      LET g_errparam.code   = SQLCA.sqlcode
      LET g_errparam.popup  = FALSE
      CALL cl_err()
      RETURN
   END IF
   
   RETURN
END FUNCTION

 
{</section>}
 
{<section id="ainr830_g01.other_report" readonly="Y" >}

#subrep05
PRIVATE REPORT ainr830_g01_subrep05(sr3)
   DEFINE sr3 sr3_r
   ORDER EXTERNAL BY sr3.inpedocno
   FORMAT        
      ON EVERY ROW
         PRINTX g_grNumFmt.*
         PRINTX sr3.*
END REPORT

#subrep06
PRIVATE REPORT ainr830_g01_subrep06(sr4)
   DEFINE sr4 sr4_r
   ORDER EXTERNAL BY sr4.inpedocno
   FORMAT        
      ON EVERY ROW
         PRINTX g_grNumFmt.*
         PRINTX sr4.*
END REPORT

 
{</section>}
 
