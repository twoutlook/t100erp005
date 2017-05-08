#+ Version..: T6-ERP-1.00.00 Build-00001
#+
#+ Filename.: sadzp030_tab_relation.4gl
#+ Buildtype: p01樣板自動產生
#+ Memo.....: 產生tab用

IMPORT os

DATABASE ds

GLOBALS "../../cfg/top_global.inc"

GLOBALS
   DEFINE g_prog_id         LIKE dzfi_t.dzfi001
   DEFINE g_sd_ver          LIKE dzaa_t.dzaa002  #規格版次/程式版次
   DEFINE g_prog_type       STRING
   DEFINE g_table_main      STRING
END GLOBALS

DEFINE gi_cnt   LIKE type_t.num5
DEFINE ga_table DYNAMIC ARRAY OF RECORD
          table_type      LIKE type_t.num5,   #1:單頭表 2:單身表
          table_id        STRING,             #表編號
          table_pk        STRING,
          table_fk        STRING
#         table_ent       LIKE type_t.num5    #暫時先留白不填入 有 1 沒有 0
   END RECORD

MAIN
   DEFINE ls_sql STRING
   DEFINE lc_gzzx001 LIKE gzzx_t.gzzx001
   DEFINE lc_gzzx002 LIKE gzzx_t.gzzx002
   DEFINE lc_gzzx003 LIKE gzzx_t.gzzx003
   DEFINE lc_gzzx004 LIKE gzzx_t.gzzx004
   DEFINE lc_dzfqcrtid LIKE dzfq_t.dzfqcrtid
   DEFINE lc_dzfqcrtdt LIKE dzfq_t.dzfqcrtdt
   DEFINE ls_type1,ls_type2 STRING

   LET ls_sql = "SELECT gzzx001,gzzx002,gzzx003,gzzx004 FROM gzzx_t ",
                "ORDER BY gzzx001"
   DECLARE test_cs CURSOR FROM ls_sql
   FOREACH test_cs INTO lc_gzzx001,lc_gzzx002,lc_gzzx003,lc_gzzx004

      LET g_prog_id = lc_gzzx001
      LET g_sd_ver = lc_gzzx002 
      CALL sadzp030_tab_relation_prog_type(lc_gzzx003)
         RETURNING ls_type1,lc_dzfqcrtid,lc_dzfqcrtdt

      CALL sadzp030_tab_relation_prog_type_new()
         RETURNING ls_type2,lc_dzfqcrtid,lc_dzfqcrtdt

      IF ls_type1 = ls_type2 AND ls_type2 = lc_gzzx004 THEN
      ELSE
         DISPLAY lc_gzzx001,' r.a=',ls_type1,' last=',lc_gzzx004,' new=',ls_type2
      END IF
   END FOREACH

END MAIN

############################################################
#+ @code
#+ 函式目的  宣告單頭關聯 SCROLL CURSOR
############################################################
PRIVATE FUNCTION sadzp030_tab_relation_query_m()

   DEFINE ls_sql       STRING 

   LET ls_sql = "SELECT dzag002,dzag004 ",
                 " FROM dzaa_t,dzag_t", 
           #--------------------------dzaa---------------------#
                " WHERE dzaa001 = '",g_prog_id CLIPPED,"'",  #規格編號
                  " AND dzaa002 = '",g_sd_ver CLIPPED,"'",   #規格版次
                  " AND dzaa003 = 'TABLE'",                  #識別碼
                  " AND dzaa005 = '4'",                      #識別碼編號
                  " AND dzaastus = 'Y'",             #狀態碼取 Y 有效
           #--------------------------dzag---------------------#
                  " AND dzag001 = dzaa001 ",         #規格編號
                  " AND dzag003 = dzaa004 ",         #識別碼版次
                  " AND dzag004 IS NULL", 
                  " AND dzag005 <> 'Y'",
                  " AND dzagstus = 'Y'"
   PREPARE sadzp030_prepare_m FROM ls_sql
   DECLARE sadzp030_cs_m                             # SCROLL CURSOR

   SCROLL CURSOR WITH HOLD FOR sadzp030_prepare_m
        
   OPEN sadzp030_cs_m     
   CALL sadzp030_tab_relation_fetch_m() 
END FUNCTION 

############################################################
#+ @code
#+ 函式目的 宣告單身關聯 SCROLL CURSOR
#+ @param  p_dzag002  CHAR(15) 程式名稱
############################################################
PRIVATE FUNCTION sadzp030_tab_relation_query_d(p_dzag002)

   DEFINE p_dzag002    LIKE dzag_t.dzag002
   DEFINE ls_sql       STRING 
   
   LET ls_sql = "SELECT dzag002,dzag004 ",
                 " FROM dzaa_t,dzag_t ",
           #--------------------------dzaa---------------------#
                " WHERE dzaa001 = '",g_prog_id CLIPPED,"'",  #規格編號
                  " AND dzaa002 = '",g_sd_ver CLIPPED,"'",   #規格版次
                  " AND dzaa003 = 'TABLE'",                  #識別碼
                  " AND dzaa005 = '4'",                      #識別碼編號
                  " AND dzaastus = 'Y'",             #狀態碼取 Y 有效
           #--------------------------dzag---------------------#
                  " AND dzag001 = dzaa001 ",         #規格編號
                  " AND dzag003 = dzaa004 ",         #識別碼版次
                  " AND dzag004 = '",p_dzag002 CLIPPED,"'" 
                # " AND dzag006 = dzaa006 "          #使用標示
                 
   PREPARE sadzp030_prepare_d FROM ls_sql
   DECLARE sadzp030_cs_d 
   SCROLL CURSOR WITH HOLD FOR sadzp030_prepare_d

   OPEN sadzp030_cs_d
   CALL sadzp030_tab_relation_fetch_d() 
END FUNCTION 

############################################################
#+ @code
#+ 函式目的 取設定表資料(主表)
#+
#+ @return STRING  主表table
#+ @return STRING  主表table primary key 
#+ @return array   主表相關table array
############################################################
PUBLIC FUNCTION sadzp030_tab_relation()

   DEFINE l_dzag002         LIKE dzag_t.dzag002
   DEFINE l_dzag005         LIKE dzag_t.dzag005
   DEFINE l_dzag004         LIKE dzag_t.dzag004
   DEFINE ls_table_main_pk  STRING 
   DEFINE ls_main_table_id  STRING 
   DEFINE ls_sql            STRING 

   #取dzag r.a 應用的資料表 
   LET ls_sql = "SELECT dzag002 ",
                 " FROM dzaa_t,dzag_t", 
           #--------------------------dzaa---------------------#
                " WHERE dzaa001 = '",g_prog_id CLIPPED,"'",  #規格編號
                  " AND dzaa002 = '",g_sd_ver CLIPPED,"'",   #規格版次
                  " AND dzaa003 = 'TABLE'",                  #識別碼
                  " AND dzaa005 = '4'",                      #識別碼編號
                  " AND dzaastus = 'Y'",             #狀態碼取 Y 有效
           #--------------------------dzag---------------------#
                  " AND dzag001 = dzaa001 ",         #規格編號
                  " AND dzag003 = dzaa004 ",         #識別碼版次
                  " AND dzag005 = 'Y'" 
              #   " AND dzag006 = dzaa006 "          #使用標示

   PREPARE sadzp030_tab_pre FROM ls_sql
   EXECUTE sadzp030_tab_pre INTO l_dzag002
   FREE sadzp030_tab_pre

   LET gi_cnt = 1
   CALL ga_table.clear()
   IF NOT cl_null(l_dzag002) THEN 
      LET ls_main_table_id = l_dzag002

      #取主表pk
      LET ls_table_main_pk = sadzp030_tab_relation_pk(l_dzag002)

      #有單頭及單身 取單頭有關單身子節點
      CALL sadzp030_tab_relation_query_d(l_dzag002)

      #單檔多table或單身多table 取關聯資料
      CALL sadzp030_tab_relation_query_m()
   END IF

   CLOSE sadzp030_cs_m   
   CLOSE sadzp030_cs_d

   RETURN l_dzag002,ls_table_main_pk,ga_table
END FUNCTION 

############################################################
#+ @code
#+ 函式目的 取出primary key
#+ @param  p_dzag002 CHAR(15) 表格名稱
#+ @return STRING primary key 
############################################################
PUBLIC FUNCTION sadzp030_tab_relation_pk(p_dzag002)

   DEFINE p_dzag002 LIKE dzag_t.dzag002
   DEFINE l_dzed004 LIKE dzed_t.dzed004
   DEFINE ls_sql    STRING 

   LET ls_sql = "SELECT dzag008 FROM dzaa_t,dzag_t", 
           #--------------------------dzaa---------------------#
                " WHERE dzaa001 = '",g_prog_id CLIPPED,"'",  #規格編號
                  " AND dzaa002 = '",g_sd_ver CLIPPED,"'",   #規格版次
                  " AND dzaa003 = 'TABLE'",                  #識別碼
                  " AND dzaa005 = '4'",                      #識別碼編號
                  " AND dzaastus = 'Y'",             #狀態碼取 Y 有效
           #--------------------------dzag---------------------#
                  " AND dzag001 = dzaa001 ",         #規格編號
                  " AND dzag002 = '",p_dzag002,"' ", 
                  " AND dzag003 = dzaa004 ",         #識別碼版次
                  " AND dzagstus = 'Y' "
          
   PREPARE sadzp030_tab_relation_pk1 FROM ls_sql
   EXECUTE sadzp030_tab_relation_pk1 INTO l_dzed004

   IF SQLCA.SQLCODE THEN
      FREE sadzp030_tab_relation_pk1
      #排除 ent
      RETURN sadzp030_tab_relation_ent(l_dzed004)  
   ELSE
      FREE sadzp030_tab_relation_pk1
   END IF

   LET ls_sql = "SELECT dzed004 FROM dzed_t", 
                " WHERE dzed001 = '",p_dzag002,"'", 
                  " AND dzed003 = 'P'"  #鍵值形式 = p 表示為pk
          
   PREPARE sadzp030_tab_relation_pk2 FROM ls_sql
   EXECUTE sadzp030_tab_relation_pk2 INTO l_dzed004
   FREE sadzp030_tab_relation_pk2

   #排除 ent
   RETURN sadzp030_tab_relation_ent(l_dzed004)  
END FUNCTION 

############################################################
#+ @code
#+ 函式目的 取出單身設定表資料
############################################################
PRIVATE FUNCTION sadzp030_tab_relation_fetch_d()

   DEFINE l_dzag002 LIKE dzag_t.dzag002
   DEFINE l_dzag004 LIKE dzag_t.dzag004
   
   FETCH NEXT sadzp030_cs_d INTO l_dzag002,l_dzag004

   IF SQLCA.sqlcode THEN
      RETURN
   ELSE
      #取單身foreign key
      CALL sadzp030_tab_relation_tab(l_dzag002,l_dzag004)
      #遞迴呼叫
      CALL sadzp030_tab_relation_fetch_d()
   END IF 
END FUNCTION 

############################################################
#+ @code
#+ 函式目的 取出單頭設定表資料
############################################################
PRIVATE FUNCTION sadzp030_tab_relation_fetch_m()

   DEFINE l_dzag002 LIKE dzag_t.dzag002
   DEFINE l_dzag004 LIKE dzag_t.dzag004

   FETCH NEXT sadzp030_cs_m INTO l_dzag002,l_dzag004

   IF SQLCA.sqlcode THEN
      RETURN
   ELSE
      #表示有多個table 區分單頭多table 跟單頭的主表有關聯的FK
      CALL sadzp030_tab_relation_tab(l_dzag002,l_dzag004)
      #遞迴呼叫
      CALL sadzp030_tab_relation_fetch_m()
   END IF 
    
END FUNCTION 

############################################################
#+ @code
#+ 函式目的 取出foreign key
#+ @param  p_dzag002  CHAR(15) 表格名稱
#+ @param  p_dzag004  CHAR(15) 表格名稱
############################################################
PUBLIC FUNCTION sadzp030_tab_relation_fk(p_dzag002,p_dzag004)

   DEFINE p_dzag002   LIKE dzag_t.dzag002
   DEFINE p_dzag004   LIKE dzag_t.dzag002
   DEFINE l_dzed004   LIKE dzed_t.dzed004
   DEFINE l_dzed006   LIKE dzed_t.dzed006
   DEFINE ls_sql      STRING 
   DEFINE ls_next     STRING
   DEFINE l_token4    base.StringTokenizer
   DEFINE l_token6    base.StringTokenizer
   DEFINE l_tokenp    base.StringTokenizer
   DEFINE li_cnt      LIKE type_t.num5
   DEFINE la_dzed     DYNAMIC ARRAY OF RECORD
             dzed004  STRING,
             dzed006  STRING,
             checked  LIKE type_t.chr1
                      END RECORD
   DEFINE ls_pkcol    STRING
   DEFINE ls_dzed004,ls_dzed006 STRING

   #取出table編號
   LET ls_next = p_dzag002
   LET ls_next = ls_next.subString(1,ls_next.getIndexOf("_t",1)-1)

   LET ls_sql = "SELECT dzag009,dzag010 FROM dzaa_t,dzag_t", 
           #--------------------------dzaa---------------------#
                " WHERE dzaa001 = '",g_prog_id CLIPPED,"'",  #規格編號
                  " AND dzaa002 = '",g_sd_ver CLIPPED,"'",   #規格版次
                  " AND dzaa003 = 'TABLE'",                  #識別碼
                  " AND dzaa005 = '4'",                      #識別碼編號
                  " AND dzaastus = 'Y'",             #狀態碼取 Y 有效
           #--------------------------dzag---------------------#
                  " AND dzag001 = dzaa001 ",         #規格編號
                  " AND dzag003 = dzaa004 ",         #識別碼版次
                  " AND dzag002 = '",p_dzag002,"'", 
                  " AND dzag004 = '",p_dzag004,"'",  #外來鍵關聯表格
                  " AND dzagstus = 'Y' "
          
   PREPARE sadzp030_tab_relation_fk1 FROM ls_sql
   EXECUTE sadzp030_tab_relation_fk1 INTO l_dzed004

   IF SQLCA.SQLCODE THEN
      FREE sadzp030_tab_relation_fk1

      LET ls_sql = "SELECT dzed004,dzed006 FROM dzed_t", 
                   " WHERE dzed001 = '",p_dzag002,"'", 
                     " AND dzed002 like '",ls_next.trim(),"_fk%' ", #設定只取名稱含有_PK
                     " AND dzed003 = 'F'",              #鍵值形式=F 表示為FK
                     " AND dzed005 = '",p_dzag004,"'"   #外來鍵關聯表格
              
      PREPARE sadzp030_tab_relation_fk2 FROM ls_sql
      EXECUTE sadzp030_tab_relation_fk2 INTO l_dzed004,l_dzed006

      FREE sadzp030_tab_relation_fk2
   ELSE
      FREE sadzp030_tab_relation_fk1
   END IF

   #把對應建置起來之後,在依照主表(p_uptable)的PK順序重新排序
   LET l_token4 = base.StringTokenizer.create(l_dzed004 CLIPPED, ",")
   LET l_token6 = base.StringTokenizer.create(l_dzed006 CLIPPED, ",")
   LET li_cnt = 1
   WHILE l_token4.hasMoreTokens() AND l_token6.hasMoreTokens()
      LET la_dzed[li_cnt].dzed004 = l_token4.nextToken()
      LET la_dzed[li_cnt].dzed006 = l_token6.nextToken()
      LET la_dzed[li_cnt].checked = "N"

      #遇到ent先拉出
      IF la_dzed[li_cnt].dzed004.subString(la_dzed[li_cnt].dzed004.getLength()-2,
                                           la_dzed[li_cnt].dzed004.getLength()) = "ent" THEN
         LET ls_dzed004 = ls_dzed004,la_dzed[li_cnt].dzed004,","
         LET ls_dzed006 = ls_dzed006,la_dzed[li_cnt].dzed006,","
         LET la_dzed[li_cnt].checked = "Y"
      END IF

      LET li_cnt = li_cnt + 1
   END WHILE

   #取出主表PK
   LET ls_sql = sadzp030_tab_relation_pk(p_dzag004)
   LET l_tokenp = base.StringTokenizer.create(ls_sql, ",")
   WHILE l_tokenp.hasMoreTokens()
      LET ls_pkcol = l_tokenp.nextToken()
      FOR li_cnt = 1 TO la_dzed.getLength()
         IF ls_pkcol = la_dzed[li_cnt].dzed006 AND la_dzed[li_cnt].checked = "N" THEN
            LET ls_dzed004 = ls_dzed004,la_dzed[li_cnt].dzed004,","
            LET ls_dzed006 = ls_dzed006,la_dzed[li_cnt].dzed006,","
            LET la_dzed[li_cnt].checked = "Y"
         END IF
      END FOR
   END WHILE

   #配上剩餘的項目
   FOR li_cnt = 1 TO la_dzed.getLength()
      IF la_dzed[li_cnt].checked = "N" THEN
         LET ls_dzed004 = ls_dzed004,la_dzed[li_cnt].dzed004,","
         LET ls_dzed006 = ls_dzed006,la_dzed[li_cnt].dzed006,","
      END IF
   END FOR

   RETURN ls_dzed004.subString(1,ls_dzed004.getLength()-1),
          ls_dzed006.subString(1,ls_dzed006.getLength()-1)
END FUNCTION

############################################################
#+ @code
#+ 函式目的 將取出foreign key填入table陣列
#+ @param  p_dzag002  CHAR(15) 表格名稱
#+ @param  p_dzag004  CHAR(15) 表格名稱
############################################################
PRIVATE FUNCTION sadzp030_tab_relation_tab(p_dzag002,p_dzag004)

   DEFINE p_dzag002   LIKE dzag_t.dzag002
   DEFINE p_dzag004   LIKE dzag_t.dzag002
   DEFINE l_dzed004   LIKE dzed_t.dzed004
   DEFINE l_dzed006   LIKE dzed_t.dzed006

   CALL sadzp030_tab_relation_fk(p_dzag002,p_dzag004) RETURNING l_dzed004,l_dzed006
   #跟單頭主表關聯  
   IF cl_null(p_dzag004) THEN 
      #DISPLAY "INFO: 單頭:" ,p_dzag002," 使用 FK= ", l_dzed004 ,"=",l_dzed006
      LET ga_table[gi_cnt].table_type = 1
   ELSE 
      #DISPLAY "INFO: 單身:" ,p_dzag002," 使用 FK= ", l_dzed004 ,"=",l_dzed006
      LET ga_table[gi_cnt].table_type = 2 
   END IF   

   LET ga_table[gi_cnt].table_id = p_dzag002 
   LET ga_table[gi_cnt].table_fk = sadzp030_tab_relation_ent(l_dzed004)   
   LET ga_table[gi_cnt].table_pk = sadzp030_tab_relation_pk(p_dzag002)
   LET gi_cnt = gi_cnt + 1

END FUNCTION 

############################################################
#+ @code
#+ 函式目的 濾除ent
#+ @param  ps_temp STRING 欄位字串
#+
#+ @return STRING  去除ent欄位字串
############################################################
PUBLIC FUNCTION sadzp030_tab_relation_ent(ps_temp)

   DEFINE ps_temp    STRING
   DEFINE ls_token   STRING
   DEFINE ls_return  STRING
   DEFINE tok        base.StringTokenizer

   LET tok = base.StringTokenizer.create(ps_temp,",")
   WHILE tok.hasMoreTokens()
      LET ls_token = tok.nextToken()
      IF ls_token.subString(ls_token.getLength()-2,ls_token.getLength()) = "ent" THEN
         CONTINUE WHILE
      ELSE
         LET ls_return = ls_return,",",ls_token
      END IF
   END WHILE
   RETURN ls_return.subString(2,ls_return.getLength())
END FUNCTION

############################################################
#+ @code
#+ 函式目的 濾除site
#+ @param  ps_temp STRING 欄位字串
#+
#+ @return STRING  去除site欄位字串
############################################################
PUBLIC FUNCTION sadzp030_tab_relation_site(ps_temp)

   DEFINE ps_temp    STRING
   DEFINE ls_token   STRING
   DEFINE ls_return  STRING
   DEFINE tok        base.StringTokenizer

   LET tok = base.StringTokenizer.create(ps_temp,",")
   WHILE tok.hasMoreTokens()
      LET ls_token = tok.nextToken()
      IF ls_token.subString(ls_token.getLength()-3,ls_token.getLength()) = "site" THEN
         CONTINUE WHILE
      ELSE
         LET ls_return = ls_return,",",ls_token
      END IF
   END WHILE
   RETURN ls_return.subString(2,ls_return.getLength())
END FUNCTION

############################################################
#+ @code
#+ 函式目的 取得4gl程式樣板
#+ @param  ls_type STRING 作業型態
#+
#+ @return STRING  4gl程式樣板
############################################################
PUBLIC FUNCTION sadzp030_tab_relation_prog_type(ls_type)

   DEFINE ls_type    STRING 
   DEFINE lb_stus    LIKE type_t.num5
   DEFINE lc_dzfq005 LIKE dzfq_t.dzfq005   #主程式M/子程式S
   DEFINE lc_dzfq010 LIKE dzfq_t.dzfq010   #單身框架
   DEFINE lc_dzfq013 LIKE dzfq_t.dzfq013   #m:全功能/ i:INPUT / c:CONSTRUCT
   DEFINE lc_gzde003 LIKE gzde_t.gzde003   #azzi901設定
   DEFINE ls_sys     STRING
   DEFINE ls_path    STRING
   DEFINE lc_gzza007 LIKE gzza_t.gzza007
   DEFINE li_cnt     LIKE type_t.num5
   DEFINE lc_dzfqcrtid LIKE dzfq_t.dzfqcrtid  #創建人id
   DEFINE lc_dzfqcrtdt LIKE dzfq_t.dzfqcrtdt  #創建作業日期

   IF g_t100debug = "9" THEN
#     DISPLAY '傳入的畫面型態為=',ls_type
   END IF

   #測試流程優化
#   IF ls_type = "test" THEN 
#      CALL sadzp030_tab_relation_prog_type_new() 
#      RETURNING ls_type,lc_dzfqcrtid,lc_dzfqcrtdt
#      RETURN ls_type,lc_dzfqcrtid,lc_dzfqcrtdt
#   END IF

   #作業型態先決 (取出程式識別/單身框架tab or tree/進入模式i or c or a)
   SELECT dzfq005,dzfq010,dzfq013,dzfqcrtid,dzfqcrtdt
     INTO lc_dzfq005,lc_dzfq010,lc_dzfq013,lc_dzfqcrtid,lc_dzfqcrtdt
     FROM dzfq_t
    WHERE dzfq003 = "1"  #g_sd_ver  #識別碼版號,因為dzfq只有r.a會寫入,所以咬死1
      AND dzfq004 = g_prog_id #畫面代號

   IF SQLCA.SQLCODE THEN
      #dzfq不存在意思是沒有透過 r.a 產生,此時研究一下是否在子程式註冊處有
      #如果有就當作子程式
      SELECT gzde003,gzdecrtid,gzdecrtdt
        INTO lc_gzde003,lc_dzfqcrtid,lc_dzfqcrtdt 
        FROM gzde_t
       WHERE gzde001 = g_prog_id  #規格/畫面編號
      IF SQLCA.SQLCODE THEN
         LET lc_dzfq005 = "M"    #預設為主程式
         DISPLAY "Error:規格(",g_prog_id,")不存在dzfq_t,且非子程式"
      ELSE
         LET lc_dzfq005 = "S"    #查到資料為子程式
         #登記為 "B"應用元件/"L" Library的使用 p00
         IF lc_gzde003 <> "S" THEN
            #跳成P00樣板
            LET ls_type = "p00"
            RETURN ls_type,lc_dzfqcrtid,lc_dzfqcrtdt
         END IF
      END IF
   END IF

   #查看是否為FreeStyle(gzza007=N),若是,且目錄下有同名的4gl檔案存在,則跳入i00樣板
   IF lc_dzfq005 = "M" THEN
      SELECT gzza007 INTO lc_gzza007 
        FROM gzza_t
       WHERE gzza001 = g_prog_id
      IF SQLCA.SQLCODE THEN
         LET lc_gzza007 = "Y"
      END IF
   ELSE
      #子程式,看 azzi901
      SELECT gzde004 INTO lc_gzza007 
        FROM gzde_t
       WHERE gzde001 = g_prog_id
      IF SQLCA.SQLCODE THEN
         LET lc_gzza007 = "Y"
      END IF
   END IF

   #若已經註記為FreeStyle,檢查目錄下是否有4gl檔
   IF lc_gzza007 IS NOT NULL AND lc_gzza007 = "N" THEN
#      LET ls_sys = UPSHIFT(g_prog_id[1,3])
#      LET ls_path = os.Path.join(os.Path.join(FGL_GETENV(ls_sys),"4gl"),g_prog_id),".4gl"
#
#   #  配合型管,由於設計器已經用azzi908防呆,試驗此處不做檢查
#   #  IF os.Path.exists(ls_path) THEN
#
#         IF lc_dzfq005 = "M" THEN
#            DISPLAY "INFO:目錄下存在檔案,轉為i00樣板,Path=",ls_path
#            LET ls_type = "i00"
#         ELSE
#            DISPLAY "INFO:目錄下存在檔案,轉為p00樣板,Path=",ls_path
#            LET ls_type = "p00"
#         END IF
#
#         #在此處檢查一下i00所需要的add-point是否已經存在
#         SELECT COUNT(*) INTO li_cnt FROM dzbb_t
#          WHERE dzbb001 = g_prog_id         #規格/程式編號
#            AND dzbb002 = "free_style.variable"   #程式設計點/add-point id
#            AND dzbb003 = g_sd_ver          #規格版次/程式版次
#         #如果沒有就呼叫自動塞入的工具
#         IF li_cnt = 0 THEN
#            IF NOT sadzp180_free(g_sd_ver,g_prog_id,lc_dzfq005) THEN
#               DISPLAY "WARNING: 將程式",g_prog_id,"轉換為add-point程序失敗"
#            END IF
#         ELSE
#            DISPLAY "INFO:系統有存在",g_prog_id,"轉換後的元件,不進行覆蓋"
#         END IF 

         RETURN ls_type,lc_dzfqcrtid,lc_dzfqcrtdt
   #  END IF
   END IF

   IF lc_dzfq013 = "" OR lc_dzfq013 IS NULL THEN
      LET lc_dzfq013 = "i"
   END IF

   #進行分類
   IF lc_dzfq005 = "M" THEN   #主程式的類型
      CASE
     #---I/T/M類----------------------------------------------------------------#
         WHEN ls_type = "F001_sc"  LET ls_type = "i01"        #有查詢計畫的單檔

         WHEN ls_type = "F001_ht"  OR ls_type = "F001_vt"
            IF sadzp030_tab_relation_is_i13() THEN
               LET ls_type = "i13"        #六階樹狀單檔
            ELSE
               LET ls_type = "i05"        #左右排/上下排的樹狀單檔
            END IF

         WHEN ls_type = "F001_00"  LET ls_type = "i10"        #純單檔

         WHEN ls_type = "F002_00"
            IF sadzp030_tab_relation_is_i07() THEN
               LET ls_type = "i02"        #單檔多欄
            ELSE
               LET ls_type = "t02"        #雙檔多欄
            END IF

         WHEN ls_type = "F003_sc"                             #有查詢計畫的雙檔或假雙檔
            IF sadzp030_tab_relation_is_i07() THEN
               LET ls_type = "i07"                            #假雙檔
            ELSE
               LET ls_type = "t01"                            #雙檔
            END IF

         WHEN ls_type = "F003_ht" OR ls_type = "F003_vt"      #左右排的樹狀 (雙檔)
                                                              #上下排的樹狀 (雙檔)
            IF sadzp030_tab_relation_is_i04() THEN
               LET ls_type = "i04"                            #i04 樹狀雙檔(主從表)
            ELSE
               LET ls_type = "i08"                            #i08 樹狀單檔+單身
            END IF

         WHEN ls_type = "F003_00"                             #沒有查詢計畫的雙檔或假雙檔
            IF sadzp030_tab_relation_is_i07() THEN
               LET ls_type = "i12"                            #假雙檔
            ELSE
               LET ls_type = "i09"                            #雙檔
            END IF

         WHEN ls_type = "F004_00"  LET ls_type = "i09"        #純雙檔
         WHEN ls_type = "F004_sc"  LET ls_type = "t01"        #有查詢計畫的凍結

     #---Q類---------------------------------------------------------------------#
         WHEN ls_type = "Q001_hq" OR ls_type = "Q001_vq"
            IF lc_dzfq010 = "Table" THEN LET ls_type = "q01" END IF
            IF lc_dzfq010 = "Tree"  THEN LET ls_type = "q03" END IF
            IF ls_type IS NULL THEN
               DISPLAY "WARNING:目前未支持此類Q型態,以q01試著取代"
               LET ls_type = "q01"
            END IF

         WHEN ls_type = "Q001_00"  LET ls_type = "q02" 

         OTHERWISE
            DISPLAY "WARNING:傳入的型態",ls_type,"目前未支持,以雙檔試著取代"
            LET ls_type = "t01"
      END CASE
   ELSE        #子程式的類型  lc_dzfq005="S"
      CASE
         #符合單檔型態的全功能子程式
         WHEN ls_type = "F001_00" AND lc_dzfq013 = "m" LET ls_type = "c01a"
         #符合單檔型態 只有INPUT功能的子程式
         WHEN ls_type = "F001_00" AND lc_dzfq013 = "i" LET ls_type = "c01b"
         #符合單檔型態 只有CONSTRUCT功能的子程式
         WHEN ls_type = "F001_00" AND lc_dzfq013 = "c" LET ls_type = "c01c"
         #符合單/雙檔多欄型態的全功能子程式
         WHEN ls_type = "F002_00" AND lc_dzfq013 = "m"
            IF sadzp030_tab_relation_is_i07() THEN
               LET ls_type = "c02a"   #單檔多欄子程式
            ELSE
               LET ls_type = "c04a"   #雙檔多欄子程式
            END IF
         #符合單檔多欄型態 只有INPUT功能的子程式
         WHEN ls_type = "F002_00" AND lc_dzfq013 = "i" LET ls_type = "c02b"
         #符合單檔多欄型態 只有CONSTRUCT功能的子程式
         WHEN ls_type = "F002_00" AND lc_dzfq013 = "c" LET ls_type = "c02c"
         #符合雙檔型態的全功能子程式
         WHEN ls_type = "F003_00" AND lc_dzfq013 = "m" LET ls_type = "c03a"
         #符合雙檔型態 只有INPUT功能的子程式
         WHEN ls_type = "F003_00" AND lc_dzfq013 = "i" LET ls_type = "c03b"
         #符合雙檔型態 只有CONSTRUCT功能的子程式
         WHEN ls_type = "F003_00" AND lc_dzfq013 = "c" LET ls_type = "c03c"
         OTHERWISE
            DISPLAY "WARNING:傳入的型態",ls_type,"及類型:",lc_dzfq013,"目前未支持,以c01a試著取代"
            LET ls_type = "c01a"
      END CASE
   END IF

   RETURN ls_type,lc_dzfqcrtid,lc_dzfqcrtdt
END FUNCTION 

#+ 檢查程式類別(M:主程式/子程式/lib/sub)與是否為FreeStyle
PRIVATE FUNCTION sadzp030_tab_relation_chk_mainsub() 

   DEFINE li_cnt     LIKE type_t.num5
   DEFINE lc_gzza002 LIKE gzza_t.gzza002  
   DEFINE lc_gzza007 LIKE gzza_t.gzza007  #FreeStyle指標
   DEFINE lc_gzde003 LIKE gzde_t.gzde003
   DEFINE lc_gzde006 LIKE gzde_t.gzde006

   #查主程式註冊資料
   SELECT gzza002,gzza007 INTO lc_gzza002,lc_gzza007 FROM gzza_t
    WHERE gzza001 = g_prog_id
   CASE
      WHEN SQLCA.SQLCODE = 100 #找不到--子程式
         #查子程式註冊資料
         SELECT gzde003,gzde004,gzde005,gzde006
           INTO lc_gzde003,lc_gzza007,lc_gzza002,lc_gzde006
           FROM gzde_t
          WHERE gzde001 = g_prog_id #規格/畫面編號

         #規格類別="B" 就應該是要FreeStyle
         IF lc_gzde003 = "B" THEN
            IF NOT lc_gzza007 = "N" THEN
               DISPLAY "Error:設定錯誤,SUB/LIB應該為FreeStyle,本程式設定有誤"
            END IF
         END IF

      WHEN SQLCA.SQLCODE > 0   #發生其他錯誤
         LET lc_gzde003 = ""

      OTHERWISE                #未發生錯誤--主程式
         LET lc_gzde003 = "M"
   END CASE

   RETURN lc_gzde003,lc_gzza007,lc_gzza002,lc_gzde006

END FUNCTION 

#+ 新的檢查流程

PUBLIC FUNCTION sadzp030_tab_relation_prog_type_new() 
   DEFINE ls_type    STRING 
   DEFINE li_cnt       LIKE type_t.num5
   DEFINE lc_dzfqcrtid LIKE dzfq_t.dzfqcrtid  #創建人id
   DEFINE lc_dzfqcrtdt LIKE dzfq_t.dzfqcrtdt  #創建作業日期
   DEFINE lc_ms_type   LIKE type_t.chr1
   DEFINE lc_op_type   LIKE type_t.chr1
   DEFINE lc_freestyle LIKE type_t.chr1
   DEFINE li_grid_cnt, li_sr_cnt LIKE type_t.num5
   DEFINE lc_gzde006   LIKE gzde_t.gzde006

   #取創建人資料
   SELECT dzfqcrtid,dzfqcrtdt
     INTO lc_dzfqcrtid,lc_dzfqcrtdt
     FROM dzfq_t
    WHERE dzfq003 = "1"  #g_sd_ver  #識別碼版號,因為dzfq只有r.a會寫入,所以咬死1
      AND dzfq004 = g_prog_id #畫面代號
   IF SQLCA.SQLCODE THEN
   END IF

   #確認是主程式還是子程式
   CALL sadzp030_tab_relation_chk_mainsub()
      RETURNING lc_ms_type,lc_freestyle,lc_op_type,lc_gzde006

   #先把free style請出去
   IF lc_freestyle = "N" THEN  #FreeStyle時此指標為N
      IF lc_ms_type = "M" THEN
         LET ls_type = "i00"
      ELSE
         LET ls_type = "p00"
      END IF
      RETURN ls_type,lc_dzfqcrtid,lc_dzfqcrtdt
   END IF

   CASE 
      WHEN lc_ms_type = "M"  #主程式類別
         #程式類別區分
         IF lc_op_type = "Q" THEN  #Q類
            LET ls_type = "q01"
            RETURN ls_type,lc_dzfqcrtid,lc_dzfqcrtdt
         END IF

         IF lc_op_type = "P" THEN  #P類
            LET ls_type = "p01"
            RETURN ls_type,lc_dzfqcrtid,lc_dzfqcrtdt
         END IF

         IF lc_op_type = "M" OR lc_op_type = "I" OR lc_op_type = "T" THEN  #F類
            #查看table形式,查看是否有Grid存在
            SELECT COUNT(*) INTO li_grid_cnt FROM dzaa_t,dzag_t
             WHERE dzaa001 = g_prog_id  #程式編號
               AND dzaa002 = g_sd_ver   #規格版次
               AND dzaa003 = "TABLE"    #識別碼
               AND dzaa005 = "4"        #識別碼編號
               AND dzaastus = "Y"       #狀態碼 (取有效)
           #-----------------------dzag---------------------#
               AND dzag001 = dzaa001
               AND dzag003 = dzaa004
               AND dzag005 = "Y"        #是否為主表
               AND dzag007 = "Y"        #是否被放在單頭-如果存在任何一筆,表示有單頭

            IF li_grid_cnt > 0 THEN #可能是單檔/雙檔/假雙檔/(單身凍結)
               SELECT COUNT(*) INTO li_sr_cnt FROM dzaa_t,dzfs_t
                WHERE dzaa001 = g_prog_id
                  AND dzaa002 = g_sd_ver          #規格版次
                  AND dzaa003 = "TABLE"           #串dzag_t 的識別碼
                  AND dzaa005 = "4"               #串dzag_t 的識別碼編號
                  AND dzaastus = "Y"              #只取有效的
             #-----------------------dzfs------------------------------#
                  AND dzfs001 = dzaa004           #串識別碼版號
                  AND dzfs002 = dzaa001           #串規格編號
                  AND dzfs003 <> "s_browse"       #不要s_browse的
                  AND dzfs003 NOT IN (
                      SELECT dzam003 FROM dzaa_t,dzam_t
                       WHERE dzaa001 = g_prog_id   #規格編號
                         AND dzaa002 = g_sd_ver    #規格版次
                         AND dzaa003 = "EXCLUDE"   #識別代碼
                      #------------------------------------------------------#
                         AND dzam001 = dzaa001     #規格編號
                         AND dzam004 = dzaa004     #識別碼版次
                         AND dzamstus = "Y" )      #有效碼 

               IF li_sr_cnt = 0 THEN
                  CASE sadzp030_relation_has_browse() 
                     WHEN "Table"
                        LET ls_type = "i01"  #有查詢計畫的單檔
                     WHEN "Tree"
                        IF sadzp030_tab_relation_is_i13() THEN
                           LET ls_type = "i13"   #六階樹狀單檔
                        ELSE
                           LET ls_type = "i05"   #左右排/上下排的樹狀單檔
                        END IF
                     OTHERWISE 
                        LET ls_type = "i10"  #純單檔
                  END CASE
               ELSE
                  CASE sadzp030_relation_has_browse() 
                     WHEN "Table"
                        IF sadzp030_tab_relation_is_i07() THEN
                           LET ls_type = "i07"   #假雙檔
                        ELSE
                           LET ls_type = "t01"   #雙檔
                        END IF
                     WHEN "Tree"
                        IF sadzp030_tab_relation_is_i04() THEN
                           LET ls_type = "i04"   #i04 樹狀雙檔(主從表)
                        ELSE
                           LET ls_type = "i08"   #i08 樹狀單檔+單身
                        END IF
                     OTHERWISE
                        IF sadzp030_tab_relation_is_i07() THEN
                           LET ls_type = "i12"   #沒有查詢計畫的假雙檔
                        ELSE
                           LET ls_type = "i09"   #沒有查詢計畫的雙檔
                        END IF
                  END CASE
               END IF            

            ELSE #可能是單檔多欄/雙檔多欄
               IF sadzp030_tab_relation_is_i07() THEN
                  LET ls_type = "i02"        #單檔多欄
               ELSE
                  LET ls_type = "t02"        #雙檔多欄
               END IF
            END IF

            RETURN ls_type,lc_dzfqcrtid,lc_dzfqcrtdt
         END IF
         display '型態有問題:',g_prog_type

      WHEN lc_ms_type = "S"  #子程式類別
         #查看table形式,查看是否有Grid存在
         SELECT COUNT(*) INTO li_grid_cnt FROM dzaa_t,dzag_t
          WHERE dzaa001 = g_prog_id  #程式編號
            AND dzaa002 = g_sd_ver   #規格版次
            AND dzaa003 = "TABLE"    #識別碼
            AND dzaa005 = "4"        #識別碼編號
            AND dzaastus = "Y"       #狀態碼 (取有效)
         #-----------------------dzag---------------------#
            AND dzag001 = dzaa001
            AND dzag003 = dzaa004
            AND dzag005 = "Y"        #是否為主表
            AND dzag007 = "Y"        #是否被放在單頭-如果存在任何一筆,表示有單頭

         IF li_grid_cnt > 0 THEN #可能是單檔/雙檔/假雙檔/(單身凍結)
            SELECT COUNT(*) INTO li_sr_cnt FROM dzaa_t,dzfs_t
             WHERE dzaa001 = g_prog_id
               AND dzaa002 = g_sd_ver          #規格版次
               AND dzaa003 = "TABLE"           #串dzag_t 的識別碼
               AND dzaa005 = "4"               #串dzag_t 的識別碼編號
               AND dzaastus = "Y"              #只取有效的
          #-----------------------dzfs------------------------------#
               AND dzfs001 = dzaa004           #串識別碼版號
               AND dzfs002 = dzaa001           #串規格編號
               AND dzfs003 <> "s_browse"       #不要s_browse的
               AND dzfs003 NOT IN (
                   SELECT dzam003 FROM dzaa_t,dzam_t
                    WHERE dzaa001 = g_prog_id   #規格編號
                      AND dzaa002 = g_sd_ver    #規格版次
                      AND dzaa003 = "EXCLUDE"   #識別代碼
                   #------------------------------------------------------#
                      AND dzam001 = dzaa001     #規格編號
                      AND dzam004 = dzaa004     #識別碼版次
                      AND dzamstus = "Y" )      #有效碼 

            IF li_sr_cnt = 0 THEN
               LET ls_type = "c01"   #單檔子程式
            ELSE
               LET ls_type = "c03"   #雙檔子程式
            END IF
         ELSE
            IF sadzp030_tab_relation_is_i07() THEN
               LET ls_type = "c02"   #單檔多欄子程式
            ELSE
               LET ls_type = "c04"   #雙檔多欄子程式
            END IF
         END IF
            LET ls_type = ls_type,lc_gzde006

      WHEN lc_ms_type = "G"  #GR報表程式
         LET ls_type = "g01"

      WHEN lc_ms_type = "X"  #Xgrid報表程式
         LET ls_type = "x01"
   END CASE

   RETURN ls_type,lc_dzfqcrtid,lc_dzfqcrtdt

END FUNCTION 

#+
PRIVATE FUNCTION sadzp030_relation_has_browse() 
   DEFINE lc_dzfs010 LIKE dzfs_t.dzfs010

   SELECT dzfs010 INTO lc_dzfs010 FROM dzaa_t,dzfs_t
    WHERE dzaa001 = g_prog_id
      AND dzaa002 = g_sd_ver          #規格版次
      AND dzaa003 = "TABLE"           #串dzag_t 的識別碼
      AND dzaa005 = "4"               #串dzag_t 的識別碼編號
      AND dzaastus = "Y"              #只取有效的
   #----------------------dzfs------------------------------#
      AND dzfs001 = dzaa004           #串識別碼版號
      AND dzfs002 = dzaa001           #串規格編號
      AND dzfs003 = "s_browse"        #s_browse
   IF SQLCA.SQLCODE = 100 THEN
      LET lc_dzfs010 = "N"
   END IF

   RETURN lc_dzfs010
END FUNCTION 
############################################################
#+ @code
#+ 函式目的 F003_sc
#  i07假雙檔 所有的 dzag004 IS NULL, t01一定存在dzag004 IS NOT NULL
#  dzag004 單頭主表資料
#+ @param  
#+ @return BOOLEAN  TRUE/FALSE
############################################################
PRIVATE FUNCTION sadzp030_tab_relation_is_i13() 

   DEFINE ls_sql        STRING 
   DEFINE l_dzff006     LIKE dzff_t.dzff006
   DEFINE l_dzag004     LIKE dzag_t.dzag004
   DEFINE l_dzff005     LIKE dzff_t.dzff005
   DEFINE li_cnt        LIKE type_t.num5 
   DEFINE li_rtn        LIKE type_t.num5 

   LET ls_sql = "SELECT dzff005,dzff006 ",
                 " FROM dzaa_t,dzff_t", 
             #-----------------------------dzaa-------------#
                " WHERE dzaa001 = '",g_prog_id CLIPPED,"'",  #規格編號
                  " AND dzaa002 = '",g_sd_ver CLIPPED,"'",   #規格版次
                  " AND dzaa003 = 'TREE' ",                  #設計點/識別碼
                  " AND dzaa005 = '5'",                      #識別碼類型
                  " AND dzaastus = 'Y'",
             #-----------------------------dzff-------------#
                  " AND dzff001 = dzaa001 ",        #規格編號
                  " AND dzff002 = dzaa004 "         #識別碼版次
             #    " AND dzff008 = dzaa006 "         #使用標示  #hiko說不需綁定
   PREPARE sadzp030_i13_pre FROM ls_sql
   DECLARE sadzp030_i13_pre_curs CURSOR FOR sadzp030_i13_pre

   LET li_rtn = FALSE
   FOREACH sadzp030_i13_pre_curs INTO l_dzff005,l_dzff006
      IF l_dzff005 = "type2" THEN
         LET li_rtn = TRUE
      END IF
   END FOREACH 

   FREE sadzp030_i13_pre_curs
   RETURN li_rtn

END FUNCTION


############################################################
#+ @code
#+ 函式目的 F003_sc
#  i07假雙檔 所有的 dzag004 IS NULL, t01一定存在dzag004 IS NOT NULL
#  dzag004 單頭主表資料
#+ @param  
#+ @return BOOLEAN  TRUE/FALSE
############################################################
PRIVATE FUNCTION sadzp030_tab_relation_is_i07()

   DEFINE li_cnt         LIKE type_t.num5
   DEFINE li_rtn         LIKE type_t.num5
   DEFINE ls_sql         STRING 

   #i07假雙檔 所有的 dzag004 IS NULL, t01一定存在dzag004 IS NOT NULL
   LET ls_sql = "SELECT COUNT(*) ",
                 " FROM dzaa_t,dzag_t", 
           #--------------------------dzaa---------------------#
                " WHERE dzaa001 = '",g_prog_id CLIPPED,"'",  #規格編號
                  " AND dzaa002 = '",g_sd_ver CLIPPED,"'",   #規格版次
                  " AND dzaa003 = 'TABLE'",                  #識別碼
                  " AND dzaa005 = '4'",                      #識別碼編號
                  " AND dzaastus = 'Y'",             #狀態碼取 Y 有效
           #--------------------------dzag---------------------#
                  " AND dzag001 = dzaa001 ",         #規格編號
                  " AND dzag003 = dzaa004 ",         #識別碼版次
                  " AND dzag004 IS NOT NULL "

   PREPARE sadzp030_prog_type_pre FROM ls_sql
   EXECUTE sadzp030_prog_type_pre INTO li_cnt
   FREE sadzp030_prog_type_pre

   IF li_cnt > 0 THEN 
      LET li_rtn = FALSE  #找到有上階單頭資料,非假雙檔-> t01
   ELSE
      LET li_rtn = TRUE   #找不到上階單頭資料,假雙檔-> i07
   END IF 

   RETURN li_rtn 
END FUNCTION

############################################################
#+ @code
#+ 函式目的 判斷i04主從表
#+ @param   
#+
#+ @return BOOLEAN TRUE/FALSE
############################################################
PRIVATE FUNCTION sadzp030_tab_relation_is_i04()

   DEFINE ps_pid_table  STRING 
   DEFINE ps_id_table   STRING 
   DEFINE ls_sql        STRING 
   DEFINE l_dzff006     LIKE dzff_t.dzff006
   DEFINE l_dzag004     LIKE dzag_t.dzag004
   DEFINE l_dzff005     LIKE dzff_t.dzff005
   DEFINE li_cnt        LIKE type_t.num5 
   DEFINE li_rtn        LIKE type_t.num5 

   LET ls_sql = "SELECT dzff005,dzff006 ",
                 " FROM dzaa_t,dzff_t", 
             #-----------------------------dzaa-------------#
                " WHERE dzaa001 = '",g_prog_id CLIPPED,"'",  #規格編號
                  " AND dzaa002 = '",g_sd_ver CLIPPED,"'",   #規格版次
                  " AND dzaa003 = 'TREE' ",                  #設計點/識別碼
                  " AND dzaa005 = '5'",                      #識別碼類型
                  " AND dzaastus = 'Y'",
             #-----------------------------dzff-------------#
                  " AND dzff001 = dzaa001 ",        #規格編號
                  " AND dzff002 = dzaa004 "         #識別碼版次
             #    " AND dzff008 = dzaa006 "         #使用標示  #hiko說不需綁定
   PREPARE sadzp030_i04_pre FROM ls_sql
   DECLARE sadzp030_i04_pre_curs CURSOR FOR sadzp030_i04_pre

   FOREACH sadzp030_i04_pre_curs INTO l_dzff005,l_dzff006
      CASE 
         WHEN l_dzff005 = "id"
            LET ps_id_table = l_dzff006

         WHEN l_dzff005 = "pid" 
            LET ps_pid_table = l_dzff006
      END CASE    
   END FOREACH 

   # id / pid 是否屬於同一個 table 不同table i04/同一個 table i08  
   IF ps_id_table <> ps_pid_table THEN 
      LET li_rtn = TRUE     
   ELSE 
      LET li_rtn = FALSE 
   END IF 

   FREE sadzp030_i04_pre_curs
   RETURN li_rtn
END FUNCTION 
 
############################################################
#+ @code
#+ 函式目的 取得樹狀資料
#+ @param  ps_type STRING i05/i04/i08樣板 
#+
#+ @return 
############################################################
PUBLIC FUNCTION sadzp030_tab_relation_tree_data(ps_type) 
   DEFINE ls_sql          STRING 
   DEFINE ps_type         STRING 
   DEFINE l_dzff005       LIKE dzff_t.dzff005 
   DEFINE l_dzff006       LIKE dzff_t.dzff006
   DEFINE l_dzff007       LIKE dzff_t.dzff007
   DEFINE lr_dzff         RECORD
             id           STRING,
             pid          STRING,
             type         STRING,
             desc         STRING,
             speed        STRING,
             slid         STRING,
             spid         STRING, 
             stype        STRING,
             type2        STRING,
             type3        STRING,
             type4        STRING,
             type5        STRING,
             type6        STRING
                      END RECORD 
   DEFINE lb_stus LIKE type_t.num5
   
   LET ls_sql = "SELECT dzff005,dzff006,dzff007 ",
                 " FROM dzaa_t,dzff_t", 
             #-----------------------------dzaa-------------#
                " WHERE dzaa001 = '",g_prog_id CLIPPED,"'",  #規格編號
                  " AND dzaa002 = '",g_sd_ver CLIPPED,"'",   #規格版次
                  " AND dzaa003 = 'TREE' ",                  #設計點/識別碼
                  " AND dzaa005 = '5' ",                     #識別碼類型
                  " AND dzaastus = 'Y' ",
             #-----------------------------dzff-------------#
                  " AND dzff001 = dzaa001 ",        #規格編號
                  " AND dzff002 = dzaa004 "         #識別碼版次
                # " AND dzff008 = dzaa006 "         #使用標示  #hiko說不需綁定

   PREPARE sadzp030_tree_data_pre FROM ls_sql
   DECLARE sadzp030_tree_data_pre_curs CURSOR FOR sadzp030_tree_data_pre
   
   FOREACH sadzp030_tree_data_pre_curs INTO l_dzff005,l_dzff006,l_dzff007
      CASE 
         WHEN l_dzff005 = "type"   
            LET lr_dzff.type = l_dzff007  
            LET lb_stus = TRUE 
         WHEN l_dzff005 = "type2"  LET lr_dzff.type2 = l_dzff007  
         WHEN l_dzff005 = "type3"  LET lr_dzff.type3 = l_dzff007  
         WHEN l_dzff005 = "type4"  LET lr_dzff.type4 = l_dzff007  
         WHEN l_dzff005 = "type5"  LET lr_dzff.type5 = l_dzff007  
         WHEN l_dzff005 = "type6"  LET lr_dzff.type6 = l_dzff007  

         WHEN l_dzff005 = "desc"   
            LET lr_dzff.desc = l_dzff007
            LET lb_stus = TRUE 
         WHEN l_dzff005 = "pid"   
            LET lr_dzff.pid = l_dzff007
            LET lb_stus = TRUE 
         WHEN l_dzff005 = "id"     
            LET lr_dzff.id = l_dzff007  
            LET lb_stus = TRUE
               
         #i05 樣板 table id 及field id 不可以null    
         WHEN l_dzff005 = "speed" 
            LET lr_dzff.speed = l_dzff006
            
            IF ps_type = "i05" THEN
               IF cl_null(lr_dzff.speed) THEN
                  DISPLAY "ERROR:i05樣板:提速檔設定不可以為null"
                  INITIALIZE lr_dzff TO  NULL 
                  LET lb_stus = FALSE 
                  RETURN lr_dzff.*,lb_stus
               ELSE 
                  LET lb_stus = TRUE   
               END IF 
            ELSE 
               LET lb_stus = TRUE  
            END IF 

         WHEN l_dzff005 = "spid"
            LET lr_dzff.spid = l_dzff007
            IF ps_type = "i05" THEN
               IF cl_null(lr_dzff.spid) THEN 
                  DISPLAY "ERROR:i05樣板:欄位spid設定不可以為null"
                  INITIALIZE lr_dzff TO  NULL 
                  LET lb_stus = FALSE 
                  RETURN lr_dzff.*,lb_stus
               ELSE 
                  LET lb_stus = TRUE   
               END IF 
            ELSE 
               LET lb_stus = TRUE  
            END IF  
         WHEN l_dzff005 = "sid" LET 
            lr_dzff.slid = l_dzff007
            IF ps_type = "i05" THEN
               IF cl_null(lr_dzff.slid) THEN 
                  DISPLAY "ERROR:i05樣板:欄位slid設定不可以為null"
                  INITIALIZE lr_dzff TO  NULL 
                  LET lb_stus = FALSE 
                  RETURN lr_dzff.*,lb_stus
               ELSE 
                  LET lb_stus = TRUE   
               END IF 
            ELSE 
               LET lb_stus = TRUE  
            END IF   
         WHEN l_dzff005 = "stype"
            LET lr_dzff.stype = l_dzff007
            LET lb_stus = TRUE  
       END CASE   
   END FOREACH
   FREE sadzp030_tree_data_pre_curs

   RETURN lr_dzff.*,lb_stus
END FUNCTION 

############################################################
#+ @code
#+ 函式目的 取得pid 及type
#+ @param  ps_table STRING table id
#+ @param  pr_dzff RECORD 樹狀record
#+ @return RECORD
############################################################
PUBLIC FUNCTION sadzp030_tab_relation_i04_body_pid_type(ps_table,pr_dzff)
   DEFINE l_token      base.StringTokenizer
   DEFINE l_token2     base.StringTokenizer
   DEFINE l_dzed004    LIKE dzed_t.dzed004  #PK
   DEFINE l_dzed006    LIKE dzed_t.dzed006  #FK
   DEFINE lst_fk       STRING 
   DEFINE lst_fk2      STRING 
   DEFINE l_sql        STRING
   DEFINE ps_table     STRING 
   DEFINE pr_dzff      RECORD
            id         STRING,
            pid        STRING,
            type       STRING,
            desc       STRING,
            speed      STRING,
            slid       STRING,
            spid       STRING, 
            stype      STRING,       
            type2      STRING,
            type3      STRING,
            type4      STRING,
            type5      STRING,
            type6      STRING
                   END RECORD 
   DEFINE ls_pid       STRING
   DEFINE ls_type      STRING  

   #取得fk
   CALL sadzp030_tab_relation_fk(ps_table,g_table_main) RETURNING l_dzed004,l_dzed006

   #分析取得的左右兩側欄位
   LET l_token = base.StringTokenizer.create(l_dzed004 CLIPPED, ",")
   LET l_token2 = base.StringTokenizer.create(l_dzed006 CLIPPED, ",")

   WHILE l_token.hasMoreTokens() AND l_token2.hasMoreTokens()
      LET lst_fk = l_token.nextToken()
      LET lst_fk2 = l_token2.nextToken() 
      IF lst_fk.getIndexOf("ent",1) AND lst_fk2.getIndexOf("ent",1) THEN #排除 ent 
         CONTINUE WHILE   
      END IF
      IF lst_fk2 = pr_dzff.pid THEN 
         LET ls_pid = lst_fk
      END IF 
    
   END WHILE 
   LET pr_dzff.pid = ls_pid
   LET pr_dzff.type = l_token.nextToken()
   RETURN pr_dzff.*
END FUNCTION    






