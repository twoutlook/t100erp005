#該程式未解開Section, 採用最新樣板產出!
{<section id="aoor701_x01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:3(2016-07-28 16:17:11), PR版次:0003(2016-07-28 17:06:24)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000047
#+ Filename...: aoor701_x01
#+ Description: ...
#+ Creator....: 05423(2015-08-31 16:02:40)
#+ Modifier...: 05423 -SD/PR- 05423
 
{</section>}
 
{<section id="aoor701_x01.global" readonly="Y" >}
#報表 x01 樣板自動產生(Version:8)
#add-point:填寫註解說明 name="global.memo"
#160510-00019#1  2016/06/06 By 02295 效能优化
#160606-00032#1  2016/07/28 By zhujing site判断调整,以及单号流水号截取错误修正
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
       bdate LIKE type_t.dat,         #開始日期 
       edate LIKE type_t.dat,         #截止日期 
       bno LIKE type_t.chr20,         #開始單號 
       eno LIKE type_t.chr20,         #截止單號 
       poall LIKE type_t.chr1          #印出所有單號
       END RECORD
 
DEFINE g_str           STRING,                      #列印條件回傳值              
       g_sql           STRING  
 
#add-point:自定義環境變數(Global Variable)(客製用) name="global.variable_customerization"

#end add-point
#add-point:自定義環境變數(Global Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
TYPE type_tn RECORD
   tname LIKE dzfs_t.dzfs004,
   prog  LIKE gzzz_t.gzzz001   #151123 Sarah add
END RECORD      
#end add-point
 
{</section>}
 
{<section id="aoor701_x01.main" readonly="Y" >}
PUBLIC FUNCTION aoor701_x01(p_arg1,p_arg2,p_arg3,p_arg4,p_arg5,p_arg6)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.dat         #tm.bdate  開始日期 
DEFINE  p_arg3 LIKE type_t.dat         #tm.edate  截止日期 
DEFINE  p_arg4 LIKE type_t.chr20         #tm.bno  開始單號 
DEFINE  p_arg5 LIKE type_t.chr20         #tm.eno  截止單號 
DEFINE  p_arg6 LIKE type_t.chr1         #tm.poall  印出所有單號
#add-point:init段define(客製用) name="component.define_customerization"

#end add-point
#add-point:init段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.bdate = p_arg2
   LET tm.edate = p_arg3
   LET tm.bno = p_arg4
   LET tm.eno = p_arg5
   LET tm.poall = p_arg6
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'
   
   #報表元件代號      
   LET g_rep_code = "aoor701_x01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #create 暫存檔
   CALL aoor701_x01_create_tmptable()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #報表select欄位準備
   CALL aoor701_x01_sel_prep()
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #報表insert的prepare
   CALL aoor701_x01_ins_prep()  
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF
   #將資料存入tmptable
   CALL aoor701_x01_ins_data() 
 
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
   #將tmptable資料印出
   CALL aoor701_x01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="aoor701_x01.create_tmptable" readonly="Y" >}
PRIVATE FUNCTION aoor701_x01_create_tmptable()
 
   #清除temptable 陣列
   CALL g_rep_tmpname.clear()
   
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.before name="create_tmp.before"
   
   #end add-point:create_tmp.before
 
   #主報表TEMP TABLE的欄位SQL   
   LET g_sql = "oobx002.oobx_t.oobx002,l_oobx002_desc.gzzol_t.gzzol003,oobx003.oobx_t.oobx003,l_oobx003_desc.gzcbl_t.gzcbl003,oobx001.oobx_t.oobx001,oobxl003.oobxl_t.oobxl003,l_docno.type_t.chr30,oobx004.oobx_t.oobx004,l_bdate.type_t.chr20,l_edate.type_t.chr20" 
   
   #建立TEMP TABLE,主報表序號1 
   IF NOT cl_xg_create_tmptable(g_sql,1) THEN
      LET g_rep_success = 'N'            
   END IF
   #可切換資料庫，避免大量資料佔資源及空間
   #add-point:create_tmp.after name="create_tmp.after"
   
   #end add-point:create_tmp.after
END FUNCTION
 
{</section>}
 
{<section id="aoor701_x01.ins_prep" readonly="Y" >}
PRIVATE FUNCTION aoor701_x01_ins_prep()
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
             ?,?,?,?)"
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
 
{<section id="aoor701_x01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aoor701_x01_sel_prep()
DEFINE g_select      STRING
DEFINE g_from        STRING
DEFINE g_where       STRING
#add-point:sel_prep段define(客製用) name="sel_prep.define_customerization"

#end add-point
#add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
DEFINE g_order       STRING 
#end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
 
   #add-point:sel_prep g_select name="sel_prep.g_select"
   LET g_select = " SELECT oobx002,gzzol003,oobx003,gzcbl004,oobx001,oobxl003,NULL,oobx007,oobx004"
#   #end add-point
#   LET g_select = " SELECT oobx002,NULL,oobx003,NULL,oobx001,oobxl003,NULL,oobx007,oobx004,'',''"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_from = " FROM oobx_t LEFT OUTER JOIN oobxl_t ON oobx001 = oobxl001 AND oobxent = oobxlent AND oobxl002 = '",g_dlang,"' ",
                "             LEFT OUTER JOIN gzzol_t ON oobx002 = gzzol001 AND gzzol002 = '",g_dlang,"' ",
                "             LEFT OUTER JOIN gzcbl_t ON oobx003 = gzcbl002 AND gzcbl001 = '24' AND gzcbl003 = '",g_dlang,"' "
#   #end add-point
#    LET g_from = " FROM oobx_t,oobxl_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   LET g_order = " ORDER BY oobx002,oobx003,oobx001 "
   #end add-point
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
 
#   #end add-point:sel_prep.sql.before
#   LET g_where = g_where ,cl_sql_add_filter("oobx_t")   #資料過濾功能
#   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED
#   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
# 
#   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   LET g_where = g_where ,cl_sql_add_filter("oobx_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段
   #end add-point
   PREPARE aoor701_x01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()
      LET g_rep_success = 'N' 
   END IF
   DECLARE aoor701_x01_curs CURSOR FOR aoor701_x01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="aoor701_x01.ins_data" readonly="Y" >}
PRIVATE FUNCTION aoor701_x01_ins_data()
DEFINE sr RECORD 
   oobx002 LIKE oobx_t.oobx002, 
   l_oobx002_desc LIKE gzzol_t.gzzol003, 
   oobx003 LIKE oobx_t.oobx003, 
   l_oobx003_desc LIKE gzcbl_t.gzcbl003, 
   oobx001 LIKE oobx_t.oobx001, 
   oobxl003 LIKE oobxl_t.oobxl003, 
   l_docno LIKE type_t.chr30, 
   oobx007 LIKE oobx_t.oobx007, 
   oobx004 LIKE oobx_t.oobx004, 
   l_bdate LIKE type_t.chr20, 
   l_edate LIKE type_t.chr20
 END RECORD
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE tn         DYNAMIC ARRAY OF type_tn
DEFINE name       STRING
DEFINE l_pn       LIKE type_t.chr10
DEFINE l_begin    LIKE type_t.num5     #单别截取起点
DEFINE l_end      LIKE type_t.num5     #单别截取终点
DEFINE l_total    LIKE type_t.num5     #总长度

DEFINE l_start    LIKE type_t.num5     #截取单号流水号起点
DEFINE l_length   LIKE type_t.num5     #单号总长度
#ming 20150930 modify -------------(S) 
#DEFINE docno      LIKE type_t.chr20
DEFINE docno      LIKE type_t.chr30
#ming 20150930 modify -------------(E) 
DEFINE docdt      LIKE type_t.dat
#ming 20150930 modify -------------(S) 
#DEFINE l_docno    LIKE type_t.chr20    #非流水号部分
DEFINE l_docno    LIKE type_t.chr30    #非流水号部分
#ming 20150930 modify -------------(E) 
DEFINE l_no       LIKE type_t.num10    #流水号部分
#ming 20150930 modify -------------(S) 
#DEFINE l_docno_t  LIKE type_t.chr20    #非流水号部分（旧）
DEFINE l_docno_t  LIKE type_t.chr30    #非流水号部分（旧）
#ming 20150930 modify -------------(E) 
DEFINE l_no_t     LIKE type_t.num10    #流水号部分（旧）

DEFINE l_cnt      LIKE type_t.num5
DEFINE l_sql1     STRING
DEFINE l_sql2     STRING 
#160510-00019#1---add---s
DEFINE l_sql      STRING
DEFINE nametable  LIKE dzeb_t.dzeb001
DEFINE namesite   LIKE dzeb_t.dzeb002
#160510-00019#1---add---e

#ming 20150930 add -----(S) 
   DEFINE l_no_s  LIKE type_t.chr20
   DEFINE l_i     LIKE type_t.num5
   DEFINE l_style STRING 
   DEFINE l_count LIKE type_t.num5
#ming 20150930 add -----(E)
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    LET l_length = cl_get_para(g_enterprise,'','E-COM-0005')
    INITIALIZE l_docno TO NULL
    INITIALIZE l_no TO NULL
    INITIALIZE l_docno_t TO NULL
    INITIALIZE l_no_t TO NULL 
   #160510-00019#1---add---s
   LET l_sql1 = "SELECT COUNT(*) FROM dzeb_t  WHERE dzeb001 = ? AND dzeb002 = ? "
   PREPARE aoor701_x01_prepare_tn FROM l_sql1
   DECLARE aoor701_x01_curs_tn CURSOR FOR aoor701_x01_prepare_tn
   
   CALL aoor701_x01_get_table_cursor()
   #160510-00019#1---add---e  
    #end add-point
 
    LET g_rep_success = 'Y'
 
    FOREACH aoor701_x01_curs INTO sr.*                               
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
       LET l_start = l_length - sr.oobx007 + 1
       LET l_cnt = 1
       INITIALIZE tn[l_cnt].* TO NULL
       #根据单据别oobx001,单据性质oobx003,对应作业名称oobx004抓取table
       CALL aoor701_x01_get_table_name(sr.oobx001,sr.oobx004) RETURNING tn
       #查看table是否有site栏位
       FOR l_cnt = 1 TO tn.getlength()
          INITIALIZE name TO NULL
          LET name = tn[l_cnt].tname 
          LET name = name.subString(1,4)
          CALL aoor701_x01_get_position() RETURNING l_begin,l_end,l_total
          #160510-00019#1---add---s
          #LET l_sql1 = "SELECT ",name CLIPPED,"site FROM ",name CLIPPED,"_t "
          #PREPARE aoor701_x01_prepare_tn FROM l_sql1
          #DECLARE aoor701_x01_curs_tn CURSOR FOR aoor701_x01_prepare_tn
          #FOREACH aoor701_x01_curs_tn INTO l_pn
          #   EXIT FOREACH
          #END FOREACH
          LET l_pn = 0 
          LET nametable = name CLIPPED,"_t"
          LET namesite = name CLIPPED,"site"
          EXECUTE aoor701_x01_curs_tn USING nametable,namesite INTO l_pn
          #160510-00019#1---add---e
          #根据table，单别抓取单号、单据日期+input筛选条件+order by 单号
#          IF STATUS THEN #160606-00032#1 mod
          IF l_pn=0 OR cl_null(l_pn) THEN #160606-00032#1 
             LET l_sql2 = " SELECT UNIQUE ", name CLIPPED,"docno,",name CLIPPED,"docdt ",
                          " FROM ",name CLIPPED,"_t",
                          " WHERE substr(",name CLIPPED,"docno,",l_begin,",",l_total,") = '",sr.oobx001,"' "
          ELSE
             LET l_sql2 = " SELECT UNIQUE ", name CLIPPED,"docno,",name CLIPPED,"docdt ",
                          " FROM ",name CLIPPED,"_t",
                          " WHERE ",name CLIPPED,"site = '",g_site,"' AND substr(",name CLIPPED,"docno,",l_begin,",",l_total,") = '",sr.oobx001,"' "
          END IF
          IF NOT cl_null(tm.bno) THEN     #起始单号
             LET l_sql2 = l_sql2 CLIPPED," AND ",name CLIPPED,"docno >= '",tm.bno,"' "
          END IF
          IF NOT cl_null(tm.eno) THEN     #截止单号
             LET l_sql2 = l_sql2 CLIPPED," AND ",name CLIPPED,"docno <= '",tm.eno,"' "
          END IF
          IF NOT cl_null(tm.bdate) THEN   #起始日期
             LET l_sql2 = l_sql2 CLIPPED," AND ",name CLIPPED,"docdt >= '",tm.bdate,"' "
          END IF
          IF NOT cl_null(tm.edate) THEN   #截止日期
             LET l_sql2 = l_sql2 CLIPPED," AND ",name CLIPPED,"docdt <= '",tm.edate,"'"
          END IF
          LET l_sql2 = l_sql2 CLIPPED ," ORDER BY ",name CLIPPED,"docno "
          
          PREPARE aoor701_x01_prepare_docno FROM l_sql2
          DECLARE aoor701_x01_curs_docno CURSOR FOR aoor701_x01_prepare_docno
          #ming 20151001 add -----(S) 
          LET l_count = 1
          #ming 20151001 add -----(E)
          FOREACH aoor701_x01_curs_docno INTO docno,docdt                                 
             IF STATUS THEN
                INITIALIZE g_errparam TO NULL
                LET g_errparam.extend = 'foreach:'
                LET g_errparam.code   = STATUS
                LET g_errparam.popup  = TRUE
                CALL cl_err()
                LET g_rep_success = 'N'
                EXIT FOREACH
             END IF
             #ming 20150930 modify ------------------------------------------(S) 
             ##获取单号后，对单号进行截取：非流水号部分l_docno+流水号部分l_no(根据oobx007剩余流水码长度进行截取，总长E-COM-0005)
             #LET l_docno = docno[1,l_start-1]     #非流水号
             #LET l_no = docno[l_start,l_length]   #流水号
             ##若新非流水号部分<>旧非流水号部分-->单据别、期别不一致，则以新的非流水号部分作为新的判断依据
             #IF l_docno <> l_docno_t OR cl_null(l_docno_t) THEN
             #   LET l_docno_t = l_docno
             #   LET l_no_t = l_no
             #ELSE
             #  #若新流水号部分<>旧流水号部分+1-->不连续，输出至报表
             #  IF l_no <> l_no_t + 1 THEN
             #     LET sr.l_docno = docno
             #     #ming 20150924 modify -----(S) 
             #     #EXECUTE insert_prep USING sr.oobx002,sr.l_oobx002_desc,sr.oobx003,sr.l_oobx003_desc,sr.oobx001,sr.oobxl003,sr.l_do
             #     EXECUTE insert_prep USING sr.oobx002,sr.l_oobx002_desc,sr.oobx003,
             #                               sr.l_oobx003_desc,sr.oobx001,sr.oobxl003,
             #                               sr.l_docno,sr.oobx004,tm.bdate,tm.edate 
             #     #ming 20150924 modify -----(E) 
             #     IF SQLCA.sqlcode THEN
             #        INITIALIZE g_errparam TO NULL
             #        LET g_errparam.extend = "aoor701_x01_execute"
             #        LET g_errparam.code   = SQLCA.sqlcode
             #        LET g_errparam.popup  = FALSE
             #        CALL cl_err()       
             #        LET g_rep_success = 'N'
             #        EXIT FOREACH
             #     END IF
             #  END IF
             #  LET l_no_t = l_no
             #END IF 
             
             IF tm.poall = 'N' THEN
                #如果選擇不全部印出的話，就走原本的邏輯  
                #获取单号后，对单号进行截取：非流水号部分l_docno+流水号部分l_no(根据oobx007剩余流水码长度进行截取，总长E-COM-0005)
#                LET l_docno = docno[1,l_start-1]     #非流水号  #160606-00032#1 mod
                LET l_docno = docno[1,l_start]     #非流水号  #160606-00032#1 mod
#                LET l_no = docno[l_start,l_length]   #流水号    #160606-00032#1 mod  
                LET l_no = docno[l_start+1,l_length]   #流水号    #160606-00032#1 mod

                LET l_style = ''
#                FOR l_i = 1 TO l_length - l_start + 1   #160606-00032#1 mod
                FOR l_i = 1 TO l_length - l_start        #160606-00032#1 mod
                   LET l_style = l_style , '&'
                END FOR 
                
                IF NOT cl_null(tm.bno) AND l_count = 1 THEN
                   LET l_docno_t = l_docno
#                   LET l_no_t    = tm.bno[l_start,l_length] - 1  #160606-00032#1 mod
                   LET l_no_t    = tm.bno[l_start+1,l_length] - 1 #160606-00032#1 mod
                   #zj add 2015-10-26------(s)  若单据编号起始为00，则从1开始抓起
                   IF l_no_t = -1 THEN
                      LET l_no_t = 0
                   END IF
                   #zj add 2015-10-26------(e)
                END IF
                LET l_count = l_count + 1

                #若新非流水号部分<>旧非流水号部分-->单据别、期别不一致，则以新的非流水号部分作为新的判断依据
                #新流水号需从01编起，所以以新流水号前缀+流水号01作为新的判断依据----zj mod 2015-10-26
                IF l_docno <> l_docno_t OR cl_null(l_docno_t) THEN
                   LET l_docno_t = l_docno
#                   LET l_no_t = l_no         #zj marked 2015-10-26
                   LET l_no_t = 0
#                ELSE
                END IF                        #zj mod 2015-10-26
                WHILE TRUE
                   #若新流水号部分<>旧流水号部分+1-->不连续，输出至报表
                   LET l_no_t = l_no_t + 1
                   IF l_no <> l_no_t THEN
                      LET l_no_s = l_no_t USING l_style
                      LET sr.l_docno = l_docno CLIPPED,l_no_s CLIPPED
                      EXECUTE insert_prep USING sr.oobx002,sr.l_oobx002_desc,sr.oobx003,
                                                sr.l_oobx003_desc,sr.oobx001,sr.oobxl003,
                                               #sr.l_docno,sr.oobx004,tm.bdate,tm.edate      #151123 Sarah mark
                                                sr.l_docno,tn[l_cnt].prog,tm.bdate,tm.edate  #151123 Sarah mod
                      IF SQLCA.sqlcode THEN
                         INITIALIZE g_errparam TO NULL
                         LET g_errparam.extend = "aoor701_x01_execute"
                         LET g_errparam.code   = SQLCA.sqlcode
                         LET g_errparam.popup  = FALSE 
                         CALL cl_err()
                         LET g_rep_success = 'N'
                         EXIT FOREACH
                      END IF
                   ELSE
                      EXIT WHILE
                   END IF
                END WHILE
                LET l_no_t = l_no
#                END IF                      #zj mod 2015-10-26
             ELSE
                #選擇了全部印出的話，就要對目前的邏輯做點修改 
                #获取单号后，对单号进行截取：非流水号部分l_docno+流水号部分l_no(根据oobx007剩余流水码长度进行截取，总长E-COM-0005)
#                LET l_docno = docno[1,l_start-1]     #非流水号  #160606-00032#1 mod
                LET l_docno = docno[1,l_start]     #非流水号  #160606-00032#1 mod
#                LET l_no = docno[l_start,l_length]   #流水号    #160606-00032#1 mod  
                LET l_no = docno[l_start+1,l_length]   #流水号    #160606-00032#1 mod

                LET l_style = ''
#                FOR l_i = 1 TO l_length - l_start + 1       #160606-00032#1 mod
                FOR l_i = 1 TO l_length - l_start            #160606-00032#1 mod
                   LET l_style = l_style , '&'
                END FOR 
                
                IF NOT cl_null(tm.bno) AND l_count = 1 THEN
                   LET l_docno_t = l_docno
#                   LET l_no_t    = tm.bno[l_start,l_length] - 1   #160606-00032#1 mod
                   LET l_no_t    = tm.bno[l_start+1,l_length] - 1  #160606-00032#1 mod
                   #zj add 2015-10-26------(s)     若单据编号起始为00，则从1开始抓起
                   IF l_no_t = -1 THEN
                      LET l_no_t = 0
                   END IF
                   #zj add 2015-10-26------(e)
                END IF
                LET l_count = l_count + 1

                #若新非流水号部分<>旧非流水号部分-->单据别、期别不一致，则以新的非流水号部分作为新的判断依据
                IF l_docno <> l_docno_t OR cl_null(l_docno_t) THEN
                   LET l_docno_t = l_docno
                   LET l_no_t = 0               #zj mod 2015-10-26
#                   LET l_no_t = l_no           #zj marked 2015-10-26--s
#                   LET sr.l_docno = docno 
#                   EXECUTE insert_prep USING sr.oobx002,sr.l_oobx002_desc,sr.oobx003,
#                                             sr.l_oobx003_desc,sr.oobx001,sr.oobxl003,
#                                             sr.l_docno,sr.oobx004,tm.bdate,tm.edate     
#                ELSE                           #zj marked 2015-10-26--e
                END IF
                #若新流水号部分<>旧流水号部分+1-->不连续，输出至报表
                WHILE TRUE
                   LET l_no_t = l_no_t + 1
                   IF l_no <> l_no_t THEN
                      LET l_no_s = l_no_t USING l_style
                      LET sr.l_docno = l_docno CLIPPED,l_no_s,cl_getmsg("aoo-00658",g_lang) 
                      EXECUTE insert_prep USING sr.oobx002,sr.l_oobx002_desc,sr.oobx003,
                                                sr.l_oobx003_desc,sr.oobx001,sr.oobxl003,
                                               #sr.l_docno,sr.oobx004,tm.bdate,tm.edate      #151123 Sarah mark
                                                sr.l_docno,tn[l_cnt].prog,tm.bdate,tm.edate  #151123 Sarah mod
                      IF SQLCA.sqlcode THEN
                         INITIALIZE g_errparam TO NULL
                         LET g_errparam.extend = "aoor701_x01_execute"
                         LET g_errparam.code   = SQLCA.sqlcode
                         LET g_errparam.popup  = FALSE
                         CALL cl_err()
                         LET g_rep_success = 'N'
                         EXIT FOREACH
                      END IF
                   ELSE
                      LET l_no_s = l_no_t USING l_style
                      LET sr.l_docno = l_docno CLIPPED,l_no_s CLIPPED
                      EXECUTE insert_prep USING sr.oobx002,sr.l_oobx002_desc,sr.oobx003,
                                                sr.l_oobx003_desc,sr.oobx001,sr.oobxl003, 
                                               #sr.l_docno,sr.oobx004,tm.bdate,tm.edate      #151123 Sarah mark
                                                sr.l_docno,tn[l_cnt].prog,tm.bdate,tm.edate  #151123 Sarah mod
                      IF SQLCA.sqlcode THEN
                         INITIALIZE g_errparam TO NULL
                         LET g_errparam.extend = "aoor701_x01_execute"
                         LET g_errparam.code   = SQLCA.sqlcode
                         LET g_errparam.popup  = FALSE
                         CALL cl_err()
                         LET g_rep_success = 'N'
                         EXIT FOREACH
                      END IF
                      EXIT WHILE
                   END IF
                END WHILE
                LET l_no_t = l_no
#                END IF                   #zj marked 2015-10-26
             END IF
             #ming 20150930 modify ------------------------------------------(E) 
          END FOREACH
          LET l_docno_t = ''   #151123 Sarah add
          LET l_no_t = ''      #151123 Sarah add
       END FOR
        
       CONTINUE FOREACH    
       
       #end add-point
 
       #add-point:ins_data段before.save name="ins_data.before.save"
       
       #end add-point
 
       #EXECUTE
       EXECUTE insert_prep USING sr.oobx002,sr.l_oobx002_desc,sr.oobx003,sr.l_oobx003_desc,sr.oobx001,sr.oobxl003,sr.l_docno,sr.oobx004,sr.l_bdate,sr.l_edate
 
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.extend = "aoor701_x01_execute"
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
 
{<section id="aoor701_x01.rep_data" readonly="Y" >}
PRIVATE FUNCTION aoor701_x01_rep_data()
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
 
{<section id="aoor701_x01.other_function" readonly="Y" >}

################################################################################
# Date & Author..: 2016/06/06 By 02295
# Modify.........: #160510-00019#1
################################################################################
PRIVATE FUNCTION aoor701_x01_get_table_cursor()
DEFINE l_sql         STRING
   
   ###p_oobx004 != 'MULTI'
   LET l_sql = "SELECT oobl002 ",
               "  FROM oobl_t LEFT OUTER JOIN oobx_t ON oobx001 = oobl001 AND ooblent = oobxent",
               " WHERE oobl001 = ? AND ooblent = ",g_enterprise,
               " AND oobx004 = ? ",
               " ORDER BY oobl002" 
   PREPARE aoor700_x01_prepare_gettn_1 FROM l_sql
   DECLARE aoor701_x01_curs_gettn_1 CURSOR FOR aoor700_x01_prepare_gettn_1                  
               
   LET l_sql = "SELECT UNIQUE dzfs004 FROM dzfs_t",
               " WHERE dzfs002 IN (SELECT gzzz002 FROM gzzz_t WHERE gzzz001 = ?)",
                " ORDER BY dzfs004"                  
   PREPARE aoor700_x01_prepare_gettn FROM l_sql
   DECLARE aoor701_x01_curs_gettn CURSOR FOR aoor700_x01_prepare_gettn                  
   
   ###p_oobx004 = 'MULTI'
   LET l_sql = "SELECT oobl002",
               "  FROM oobx_t INNER JOIN oobl_t ON oobxent=ooblent AND oobx001=oobl001 AND oobx003=oobl002",
               " WHERE oobl001 = ? AND oobxent = ",g_enterprise,
               "   AND oobx004='MULTI'",
               " UNION ",
               "SELECT first_value(oobl002) over (partition BY oobxent,oobx001,oobx003 ORDER BY oobl002) AS oobl002",
               "  FROM oobx_t INNER JOIN oobl_t ON oobxent=ooblent AND oobx001=oobl001",
               " WHERE oobl001 = ? AND oobxent = ",g_enterprise,
               "   AND oobx004='MULTI'",                  
               "   AND oobx003 NOT IN (SELECT oobl002 FROM oobl_t WHERE oobxent=ooblent AND oobx001=oobl001)",
               " ORDER BY oobl002"
   PREPARE aoor700_x01_prepare_gettn_2 FROM l_sql
   DECLARE aoor701_x01_curs_gettn_2 CURSOR FOR aoor700_x01_prepare_gettn_2 
    
   LET l_sql = "SELECT UNIQUE dzfs004 FROM dzfs_t",
               " WHERE dzfs002 IN (SELECT gzzz002 FROM gzzz_t WHERE gzzz001 = ?)",
                " AND dzfs003 = 's_browse'",
                " ORDER BY dzfs004"                  
   PREPARE aoor700_x01_prepare_gettn_3 FROM l_sql
   DECLARE aoor701_x01_curs_gettn_3 CURSOR FOR aoor700_x01_prepare_gettn_3

END FUNCTION

################################################################################
# Descriptions...: 获取单据表格名称
# Memo...........:
################################################################################
PRIVATE FUNCTION aoor701_x01_get_table_name(p_oobx001,p_oobx004)
DEFINE p_oobx001     LIKE oobx_t.oobx001
DEFINE p_oobx004     LIKE oobx_t.oobx004
DEFINE r_tn          DYNAMIC ARRAY OF type_tn
DEFINE l_sql         STRING
DEFINE l_cnt         LIKE type_t.num5
   
   LET l_cnt = 1
   INITIALIZE r_tn[l_cnt].* TO NULL
   
#151123 Sarah mod -----(S)
#   IF p_oobx004 != 'MULTI' THEN
#      LET l_sql = " SELECT UNIQUE dzfs004 FROM dzfs_t WHERE dzfs_t.dzfs002 IN (SELECT gzzz002 FROM gzzz_t ",
#                  " WHERE gzzz001 = '",p_oobx004 ,"') AND dzfs003 = 's_browse' "
#   ELSE
#      LET l_sql = " SELECT UNIQUE dzfs004 FROM dzfs_t WHERE dzfs002 IN (SELECT gzzz002 FROM gzzz_t WHERE gzzz001 IN ",
#                  " (SELECT oobl002 FROM oobl_t left outer join oobx_t on oobx001 = oobl001 AND ooblent = oobxent ",
#                  " WHERE oobl001 = '",p_oobx001,"' AND ooblent = '",g_enterprise,"' AND oobx004 = 'MULTI')) "
#   END IF
#   PREPARE aoor700_x01_prepare_gettn FROM l_sql
#   DECLARE aoor701_x01_curs_gettn CURSOR FOR aoor700_x01_prepare_gettn
#   FOREACH aoor701_x01_curs_gettn INTO r_tn[l_cnt].tname
#   LET l_sql = "SELECT oobl002 ",
#               "  FROM oobl_t LEFT OUTER JOIN oobx_t ON oobx001 = oobl001 AND ooblent = oobxent",
#               " WHERE oobl001 = '",p_oobx001,"' AND ooblent = ",g_enterprise
#   IF p_oobx004 != 'MULTI' THEN
#      LET l_sql = l_sql CLIPPED," AND oobx004 = '",p_oobx004,"'"
#   ELSE
#      LET l_sql = l_sql CLIPPED," AND oobx004 = 'MULTI'"
#   END IF
   #151224 Sarah mod -----(S) 
#160510-00019#1---mark---s   
#   IF p_oobx004 != 'MULTI' THEN
#      LET l_sql = "SELECT oobl002 ",
#                  "  FROM oobl_t LEFT OUTER JOIN oobx_t ON oobx001 = oobl001 AND ooblent = oobxent",
#                  " WHERE oobl001 = '",p_oobx001,"' AND ooblent = ",g_enterprise,
#                  " AND oobx004 = '",p_oobx004,"'"
#   ELSE
#      LET l_sql = "SELECT oobl002",
#                  "  FROM oobx_t INNER JOIN oobl_t ON oobxent=ooblent AND oobx001=oobl001 AND oobx003=oobl002",
#                  " WHERE oobl001 = '",p_oobx001,"' AND oobxent = ",g_enterprise,
#                  "   AND oobx004='MULTI'",
#                  " UNION ",
#                  "SELECT first_value(oobl002) over (partition BY oobxent,oobx001,oobx003 ORDER BY oobl002) AS oobl002",
#                  "  FROM oobx_t INNER JOIN oobl_t ON oobxent=ooblent AND oobx001=oobl001",
#                  " WHERE oobl001 = '",p_oobx001,"' AND oobxent = ",g_enterprise,
#                  "   AND oobx004='MULTI'",                  
#                  "   AND oobx003 NOT IN (SELECT oobl002 FROM oobl_t WHERE oobxent=ooblent AND oobx001=oobl001)"
#   END IF
#  #151224 Sarah mod -----(E)
#   LET l_sql = l_sql CLIPPED," ORDER BY oobl002"
#   PREPARE aoor700_x01_prepare_gettn_1 FROM l_sql
#   DECLARE aoor701_x01_curs_gettn_1 CURSOR FOR aoor700_x01_prepare_gettn_1
#
#   LET l_sql = "SELECT UNIQUE dzfs004 FROM dzfs_t",
#               " WHERE dzfs002 IN (SELECT gzzz002 FROM gzzz_t WHERE gzzz001 = ?)"
#   IF p_oobx004 != 'MULTI' THEN
#      LET l_sql = l_sql CLIPPED," AND dzfs003 = 's_browse'"
#   END IF
#   LET l_sql = l_sql CLIPPED," ORDER BY dzfs004"
#   PREPARE aoor700_x01_prepare_gettn FROM l_sql
#   DECLARE aoor701_x01_curs_gettn CURSOR FOR aoor700_x01_prepare_gettn
#
#   FOREACH aoor701_x01_curs_gettn_1 INTO r_tn[l_cnt].prog
#      FOREACH aoor701_x01_curs_gettn USING r_tn[l_cnt].prog INTO r_tn[l_cnt].tname
##151123 Sarah mod -----(E)
#         IF STATUS THEN
#            INITIALIZE g_errparam TO NULL
#            LET g_errparam.extend = 'foreach:'
#            LET g_errparam.code   = STATUS
#            LET g_errparam.popup  = TRUE
#            CALL cl_err()
#            LET g_rep_success = 'N'
#            EXIT FOREACH
#         END IF 
#         LET l_cnt = l_cnt + 1
#         LET r_tn[l_cnt].prog = r_tn[l_cnt - 1].prog   #151123 Sarah add
#      END FOREACH
#   END FOREACH   #151123 Sarah add
#160510-00019#1---mark---e
#160510-00019#1---add---s 
   IF p_oobx004 != 'MULTI' THEN
      FOREACH aoor701_x01_curs_gettn_1 USING p_oobx001,p_oobx004 INTO r_tn[l_cnt].prog
         FOREACH aoor701_x01_curs_gettn USING r_tn[l_cnt].prog INTO r_tn[l_cnt].tname
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = 'foreach:'
               LET g_errparam.code   = STATUS
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               LET g_rep_success = 'N'
               EXIT FOREACH
            END IF 
            LET l_cnt = l_cnt + 1
            LET r_tn[l_cnt].prog = r_tn[l_cnt - 1].prog   
         END FOREACH
      END FOREACH   
   ELSE
      FOREACH aoor701_x01_curs_gettn_2 USING p_oobx001,p_oobx001 INTO r_tn[l_cnt].prog
         FOREACH aoor701_x01_curs_gettn_3 USING r_tn[l_cnt].prog INTO r_tn[l_cnt].tname
            IF STATUS THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.extend = 'foreach:'
               LET g_errparam.code   = STATUS
               LET g_errparam.popup  = TRUE
               CALL cl_err()
               LET g_rep_success = 'N'
               EXIT FOREACH
            END IF 
            LET l_cnt = l_cnt + 1
            LET r_tn[l_cnt].prog = r_tn[l_cnt - 1].prog   #151123 Sarah add
         END FOREACH
      END FOREACH    
   END IF
#160510-00019#1---add---e  
   CALL r_tn.deleteElement(l_cnt)
   RETURN r_tn
   
END FUNCTION

################################################################################
# Descriptions...: 获取单据别位置
# Memo...........:
################################################################################
PRIVATE FUNCTION aoor701_x01_get_position()
DEFINE g_form RECORD
   kind LIKE type_t.chr10,  #單據編號格式
   length LIKE type_t.num5,#單別長度
   sign LIKE type_t.chr10, #第一字元分隔符
   ent   LIKE type_t.chr10 #营运据点长度    2015-1-14 zj add
END RECORD
DEFINE l_start LIKE type_t.num5
DEFINE l_end LIKE type_t.num5

   CALL cl_get_para(g_enterprise,g_site,'E-COM-0008') RETURNING g_form.kind
   CALL cl_get_para(g_enterprise,g_site,'E-COM-0001') RETURNING g_form.length
   CALL cl_get_para(g_enterprise,g_site,'E-COM-0002') RETURNING g_form.sign
   CALL cl_get_para(g_enterprise,g_site,'E-COM-0003') RETURNING g_form.ent    #2015-1-14 zj mod

   IF (g_form.kind=='2') THEN
      LET l_start = 1
      LET l_end = g_form.length
   ELSE
      LET l_start = g_form.ent + 1     #2015-1-14 zj mod
      IF (g_form.sign == 'Y') THEN
         LET l_start = l_start + 1
      END IF
      LET l_end = l_start + g_form.length
   END IF
   
RETURN l_start,l_end,g_form.length
END FUNCTION

 
{</section>}
 
