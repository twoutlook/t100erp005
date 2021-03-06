#該程式未解開Section, 採用最新樣板產出!
{<section id="ainr835_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:5(2016-11-01 18:23:45), PR版次:0005(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000064
#+ Filename...: ainr835_g01
#+ Description: ...
#+ Creator....: 05423(2015-03-30 17:05:55)
#+ Modifier...: 08734 -SD/PR- 00000
 
{</section>}
 
{<section id="ainr835_g01.global" readonly="Y" >}
#報表 g01 樣板自動產生(Version:13)
#add-point:填寫註解說明 name="global.memo"
#160518-00054#1 2016-5-18  zhujing mod  添加回写aint820处理进度
#160616-00023#1 2016/10/31 By lixh      在製盤點單列印順排序方式改為計畫單號+盤點標籤號+盤點標籤項次
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
   inpfdocno LIKE inpf_t.inpfdocno, 
   inpfseq LIKE inpf_t.inpfseq, 
   inpf001 LIKE inpf_t.inpf001, 
   inpf003 LIKE inpf_t.inpf003, 
   l_imaal003_1 LIKE imaal_t.imaal003, 
   l_imaal004_1 LIKE imaal_t.imaal004, 
   inpf004 LIKE inpf_t.inpf004, 
   inpa_t_inpa024 LIKE inpa_t.inpa024, 
   inpa_t_inpa032 LIKE inpa_t.inpa032, 
   inpa_t_inpa033 LIKE inpa_t.inpa033, 
   inpa_t_inpa034 LIKE inpa_t.inpa034, 
   inpa_t_inpa035 LIKE inpa_t.inpa035, 
   inpa_t_inpa036 LIKE inpa_t.inpa036, 
   inpa_t_inpa037 LIKE inpa_t.inpa037, 
   l_order LIKE type_t.chr200, 
   inpfent LIKE inpf_t.inpfent, 
   inpfsite LIKE inpf_t.inpfsite, 
   inpgseq1 LIKE inpg_t.inpgseq1, 
   inpgseq2 LIKE inpg_t.inpgseq2, 
   inpg001 LIKE inpg_t.inpg001, 
   l_imaal003_2 LIKE imaal_t.imaal003, 
   l_imaal004_2 LIKE imaal_t.imaal004, 
   inpg012 LIKE inpg_t.inpg012, 
   inpg007 LIKE inpg_t.inpg007, 
   inpg030 LIKE inpg_t.inpg030, 
   inpg050 LIKE inpg_t.inpg050
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING,                  #where condition 
       pr LIKE type_t.chr2,         #l_pr 
       pr2 LIKE type_t.chr2          #l_pr2
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
DEFINE l_field_order     STRING
#end add-point
 
{</section>}
 
{<section id="ainr835_g01.main" readonly="Y" >}
PUBLIC FUNCTION ainr835_g01(p_arg1,p_arg2,p_arg3)
DEFINE  p_arg1 STRING                  #tm.wc  where condition 
DEFINE  p_arg2 LIKE type_t.chr2         #tm.pr  l_pr 
DEFINE  p_arg3 LIKE type_t.chr2         #tm.pr2  l_pr2
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.pr = p_arg2
   LET tm.pr2 = p_arg3
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "ainr835_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL ainr835_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL ainr835_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL ainr835_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="ainr835_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION ainr835_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   #  僅抓取盤點計畫單號及列印順序:inpa032-inpa037;並按照盤點計畫單號進行排序
   LET g_select = " SELECT DISTINCT NULL,NULL,NULL,NULL,NULL,NULL,inpf004,inpa_t.inpa024,inpa_t.inpa032,  
       inpa_t.inpa033,inpa_t.inpa034,inpa_t.inpa035,inpa_t.inpa036,inpa_t.inpa037,NULL,inpfent,inpfsite, 
       NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL"   
#   #end add-point
#   LET g_select = " SELECT inpfdocno,inpfseq,inpf001,inpf003,NULL,NULL,inpf004,inpa_t.inpa024,inpa_t.inpa032, 
#       inpa_t.inpa033,inpa_t.inpa034,inpa_t.inpa035,inpa_t.inpa036,inpa_t.inpa037,NULL,inpfent,inpfsite, 
#       inpgseq1,inpgseq2,inpg001,NULL,NULL,inpg012,inpg007,inpg030,inpg050"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
    LET g_from = " FROM inpf_t LEFT OUTER JOIN inpa_t ON inpadocno = inpf004 AND inpaent = inpfent AND inpasite = inpfsite "
#   #end add-point
#    LET g_from = " FROM inpf_t,inpg_t,inpa_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
   
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   
   #end add-point
    LET g_order = " ORDER BY inpf004"
 
   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("inpf_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE ainr835_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE ainr835_g01_curs CURSOR FOR ainr835_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="ainr835_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION ainr835_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   inpfdocno LIKE inpf_t.inpfdocno, 
   inpfseq LIKE inpf_t.inpfseq, 
   inpf001 LIKE inpf_t.inpf001, 
   inpf003 LIKE inpf_t.inpf003, 
   l_imaal003_1 LIKE imaal_t.imaal003, 
   l_imaal004_1 LIKE imaal_t.imaal004, 
   inpf004 LIKE inpf_t.inpf004, 
   inpa_t_inpa024 LIKE inpa_t.inpa024, 
   inpa_t_inpa032 LIKE inpa_t.inpa032, 
   inpa_t_inpa033 LIKE inpa_t.inpa033, 
   inpa_t_inpa034 LIKE inpa_t.inpa034, 
   inpa_t_inpa035 LIKE inpa_t.inpa035, 
   inpa_t_inpa036 LIKE inpa_t.inpa036, 
   inpa_t_inpa037 LIKE inpa_t.inpa037, 
   l_order LIKE type_t.chr200, 
   inpfent LIKE inpf_t.inpfent, 
   inpfsite LIKE inpf_t.inpfsite, 
   inpgseq1 LIKE inpg_t.inpgseq1, 
   inpgseq2 LIKE inpg_t.inpgseq2, 
   inpg001 LIKE inpg_t.inpg001, 
   l_imaal003_2 LIKE imaal_t.imaal003, 
   l_imaal004_2 LIKE imaal_t.imaal004, 
   inpg012 LIKE inpg_t.inpg012, 
   inpg007 LIKE inpg_t.inpg007, 
   inpg030 LIKE inpg_t.inpg030, 
   inpg050 LIKE inpg_t.inpg050
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"
DEFINE l_cnt2     LIKE type_t.num5     #记录工单
DEFINE l_tmp      LIKE type_t.chr100   #存放按照列印排序順序後的序號
DEFINE l_sql              STRING       #抓取正式信息
DEFINE sr_tmp     RECORD
   sfaa010     LIKE sfaa_t.sfaa010,
   sfaa020     LIKE sfaa_t.sfaa020,
   sfaastus    LIKE sfaa_t.sfaastus,
   sfaa003     LIKE sfaa_t.sfaa003,
   sfaadocno   LIKE sfaa_t.sfaadocno,
   sfaa017     LIKE sfaa_t.sfaa017
END RECORD
#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH ainr835_g01_curs INTO sr_s.*
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
       #160616-00023#1-s mark       
#       CALL ainr835_g01_inpf_order(sr_s.inpa_t_inpa032,TRUE)  
#       CALL ainr835_g01_inpf_order(sr_s.inpa_t_inpa033,FALSE) 
#       CALL ainr835_g01_inpf_order(sr_s.inpa_t_inpa034,FALSE) 
#       CALL ainr835_g01_inpf_order(sr_s.inpa_t_inpa035,FALSE) 
#       CALL ainr835_g01_inpf_order(sr_s.inpa_t_inpa036,FALSE) 
#       CALL ainr835_g01_inpf_order(sr_s.inpa_t_inpa037,FALSE) 
#       IF cl_null(l_field_order) THEN
#          LET l_field_order = " 1=1 "
#       ELSE
#          LET l_field_order = l_field_order,",inpfdocno "
#       END IF
       #160616-00023#1-e mark
       LET l_cnt2 = 1
       #獲取所有資料
       LET l_sql = " SELECT DISTINCT inpfdocno,inpfseq,inpf001,inpf003,t1.imaal003,t1.imaal004,inpf004,inpa_t.inpa024,inpa_t.inpa032,",
                   " inpa_t.inpa033,inpa_t.inpa034,inpa_t.inpa035,inpa_t.inpa036,inpa_t.inpa037,NULL,inpfent,inpfsite,",
                   " inpgseq1,inpgseq2,inpg001,t2.imaal003,t2.imaal004,inpg012,inpg007,inpg030,inpg050,sfaa010,sfaa020,sfaastus,sfaa003,sfaadocno,sfaa017",
                   " FROM inpf_t LEFT OUTER JOIN inpg_t ON inpfdocno = inpgdocno AND inpfseq = inpgseq AND inpfsite = inpgsite AND inpfent = inpgent ",
                   "             LEFT OUTER JOIN inpa_t ON inpf004 = inpadocno AND inpfsite = inpasite AND inpfent = inpaent ",
                   "             LEFT OUTER JOIN sfaa_t ON inpf001 = sfaadocno AND sfaaent = inpfent ",
                   "             LEFT OUTER JOIN imaal_t t1 ON inpf003 = t1.imaal001 AND inpfent = t1.imaalent AND t1.imaal002 = '",g_dlang,"' ",
                   "             LEFT OUTER JOIN imaal_t t2 ON inpg001 = t2.imaal001 AND inpgent = t2.imaalent AND t2.imaal002 = '",g_dlang,"' ",
      # " WHERE ",tm.wc CLIPPED, " AND inpf004 = '",sr_s.inpf004 CLIPPED,"' AND ",l_field_order CLIPPED             #160616-00023#1 mark
       " WHERE ",tm.wc CLIPPED, " AND inpf004 = '",sr_s.inpf004 CLIPPED,"' "," ORDER BY inpf004,inpfdocno,inpfseq " #160616-00023#1 add
       PREPARE ainr835_g01_pre01 FROM l_sql
       DECLARE ainr835_g01_cur01 CURSOR FOR ainr835_g01_pre01
       FOREACH ainr835_g01_cur01 INTO sr_s.*,sr_tmp.*
         IF STATUS THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.extend = 'foreach:'
            LET g_errparam.code   = STATUS
            LET g_errparam.popup  = TRUE
            CALL cl_err()       
            LET g_rep_success = 'N'    
            EXIT FOREACH
         END IF
         IF cl_null(l_tmp) THEN
            LET l_tmp = sr_s.inpf001
         END IF
         
         IF sr_s.inpf001 <> l_tmp THEN
            LET l_cnt2 = l_cnt2 + 1
            LET l_tmp = sr_s.inpf001
         END IF
         IF tm.pr = 'Y' THEN  #一张工单一张盘点卡
            LET sr_s.l_order = sr_s.inpf004 CLIPPED,'-',l_cnt2 USING "&&&&&&&&",'-',sr_s.inpfdocno CLIPPED ,'-',sr_s.inpfseq CLIPPED    #l_order=盤點計畫單號+同一單號下標籤排序序號
         ELSE 
            LET sr_s.l_order = sr_s.inpf004 CLIPPED,'-',l_cnt2 USING "&&&&&&&&",'-',sr_s.inpfdocno CLIPPED,'-',sr_s.inpfseq CLIPPED,'-',sr_s.inpgseq1 USING "&&&&" ,'-',sr_s.inpgseq2 USING "&&&&" 
         END IF
         
       #end add-point
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].inpfdocno = sr_s.inpfdocno
       LET sr[l_cnt].inpfseq = sr_s.inpfseq
       LET sr[l_cnt].inpf001 = sr_s.inpf001
       LET sr[l_cnt].inpf003 = sr_s.inpf003
       LET sr[l_cnt].l_imaal003_1 = sr_s.l_imaal003_1
       LET sr[l_cnt].l_imaal004_1 = sr_s.l_imaal004_1
       LET sr[l_cnt].inpf004 = sr_s.inpf004
       LET sr[l_cnt].inpa_t_inpa024 = sr_s.inpa_t_inpa024
       LET sr[l_cnt].inpa_t_inpa032 = sr_s.inpa_t_inpa032
       LET sr[l_cnt].inpa_t_inpa033 = sr_s.inpa_t_inpa033
       LET sr[l_cnt].inpa_t_inpa034 = sr_s.inpa_t_inpa034
       LET sr[l_cnt].inpa_t_inpa035 = sr_s.inpa_t_inpa035
       LET sr[l_cnt].inpa_t_inpa036 = sr_s.inpa_t_inpa036
       LET sr[l_cnt].inpa_t_inpa037 = sr_s.inpa_t_inpa037
       LET sr[l_cnt].l_order = sr_s.l_order
       LET sr[l_cnt].inpfent = sr_s.inpfent
       LET sr[l_cnt].inpfsite = sr_s.inpfsite
       LET sr[l_cnt].inpgseq1 = sr_s.inpgseq1
       LET sr[l_cnt].inpgseq2 = sr_s.inpgseq2
       LET sr[l_cnt].inpg001 = sr_s.inpg001
       LET sr[l_cnt].l_imaal003_2 = sr_s.l_imaal003_2
       LET sr[l_cnt].l_imaal004_2 = sr_s.l_imaal004_2
       LET sr[l_cnt].inpg012 = sr_s.inpg012
       LET sr[l_cnt].inpg007 = sr_s.inpg007
       LET sr[l_cnt].inpg030 = sr_s.inpg030
       LET sr[l_cnt].inpg050 = sr_s.inpg050
 
 
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
 
{<section id="ainr835_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION ainr835_g01_rep_data()
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
          START REPORT ainr835_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT ainr835_g01_rep(sr[l_i].*)
             #報表中斷列印時，顯示錯誤訊息
             IF fgl_report_getErrorStatus() THEN
                DISPLAY "FGL: STOPPING REPORT msg=\"",fgl_report_getErrorString(),"\""
                EXIT FOR
             END IF                  
          END FOR
          FINISH REPORT ainr835_g01_rep
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
 
{<section id="ainr835_g01.rep" readonly="Y" >}
PRIVATE REPORT ainr835_g01_rep(sr1)
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
DEFINE l_inpf004        LIKE inpf_t.inpf004
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER  BY sr1.l_order,sr1.inpgseq1,sr1.inpgseq2
    #add-point:rep段ORDER_after name="rep.order.after"
    
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
            IF cl_null(l_inpf004) OR l_inpf004 <> sr1.inpf004 THEN   #若有新盘点计划单号，则进行回写
               LET l_inpf004 = sr1.inpf004
               #呼叫回写function
               CALL ainr835_g01_update_inpb002(l_inpf004,sr1.inpfent,sr1.inpfsite)   
            END IF
            #end add-point:rep.header 
            LET g_rep_docno = sr1.l_order
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'inpfent=' ,sr1.inpfent,'{+}inpfsite=' ,sr1.inpfsite,'{+}inpfdocno=' ,sr1.inpfdocno,'{+}inpfseq=' ,sr1.inpfseq         
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
                sr1.inpfent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_order CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE ainr835_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE ainr835_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT ainr835_g01_subrep01
           DECLARE ainr835_g01_repcur01 CURSOR FROM g_sql
           FOREACH ainr835_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "ainr835_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT ainr835_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT ainr835_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.l_order.after name="rep.b_group.l_order.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.inpgseq1
 
           #add-point:rep.b_group.inpgseq1.before name="rep.b_group.inpgseq1.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.inpgseq1.after name="rep.b_group.inpgseq1.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        BEFORE GROUP OF sr1.inpgseq2
 
           #add-point:rep.b_group.inpgseq2.before name="rep.b_group.inpgseq2.before"
           
           #end add-point:
 
 
           #add-point:rep.b_group.inpgseq2.after name="rep.b_group.inpgseq2.after"
           
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
                sr1.inpfent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_order CLIPPED ,"'"
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE ainr835_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE ainr835_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT ainr835_g01_subrep02
           DECLARE ainr835_g01_repcur02 CURSOR FROM g_sql
           FOREACH ainr835_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "ainr835_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT ainr835_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT ainr835_g01_subrep02
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
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooff003 = '", 
                sr1.inpfent CLIPPED ,"'"
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE ainr835_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE ainr835_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT ainr835_g01_subrep03
           DECLARE ainr835_g01_repcur03 CURSOR FROM g_sql
           FOREACH ainr835_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "ainr835_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT ainr835_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT ainr835_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
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
                sr1.inpfent CLIPPED ,"'", " AND  ooff003 = '", sr1.l_order CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE ainr835_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE ainr835_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT ainr835_g01_subrep04
           DECLARE ainr835_g01_repcur04 CURSOR FROM g_sql
           FOREACH ainr835_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "ainr835_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT ainr835_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT ainr835_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.l_order.after name="rep.a_group.l_order.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.inpgseq1
 
           #add-point:rep.a_group.inpgseq1.before name="rep.a_group.inpgseq1.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.inpgseq1.after name="rep.a_group.inpgseq1.after"
           
           #end add-point:
 
 
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.inpgseq2
 
           #add-point:rep.a_group.inpgseq2.before name="rep.a_group.inpgseq2.before"
           
           #end add-point:
 
 
           #add-point:rep.a_group.inpgseq2.after name="rep.a_group.inpgseq2.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
            CALL cl_err_collect_show()       #错误信息显示
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="ainr835_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT ainr835_g01_subrep01(sr2)
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
PRIVATE REPORT ainr835_g01_subrep02(sr2)
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
PRIVATE REPORT ainr835_g01_subrep03(sr2)
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
PRIVATE REPORT ainr835_g01_subrep04(sr2)
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
 
{<section id="ainr835_g01.other_function" readonly="Y" >}

#获取根据inpa032-inpa037得到的排序
PRIVATE FUNCTION ainr835_g01_inpf_order(p_order,p_flag)
DEFINE p_order   LIKE type_t.chr1
DEFINE p_flag    LIKE type_t.num5

   IF cl_null(p_order) OR p_order = '7' THEN
      RETURN
   END IF    
   IF cl_null(l_field_order) THEN LET l_field_order = " 1=1 " END IF
   IF p_flag THEN
      LET l_field_order = l_field_order ," ORDER BY "
   END IF
   IF p_order = '1' THEN   #生产料件编号 sfaa010
      IF p_flag THEN 
         LET l_field_order = l_field_order," sfaa010"
      ELSE
         LET l_field_order = l_field_order,",sfaa010"  
      END IF         
   END IF
   IF p_order = '2' THEN   #预计完工日 sfaa020
      IF p_flag THEN   
         LET l_field_order = l_field_order," sfaa020"
      ELSE
         LET l_field_order = l_field_order,",sfaa020"
      END IF   
   END IF  
   IF p_order = '3' THEN   #状态 sfaastus
      IF p_flag THEN   
         LET l_field_order = l_field_order," sfaastus"
      ELSE
         LET l_field_order = l_field_order,",sfaastus"
      END IF
   END IF    
   IF p_order = '4' THEN   #工单形态 sfaa003
      IF p_flag THEN   
         LET l_field_order = l_field_order," sfaa003"
      ELSE
         LET l_field_order = l_field_order,",sfaa003"
      END IF
   END IF
   IF p_order = '5' THEN   #工单号码 sfaadocno
      IF p_flag THEN   
         LET l_field_order = l_field_order," sfaadocno"
      ELSE
         LET l_field_order = l_field_order,",sfaadocno"
      END IF
   END IF 
   IF p_order = '6' THEN   #制造部门 sfaa017
      IF p_flag THEN   
         LET l_field_order = l_field_order," sfaa017"
      ELSE
         LET l_field_order = l_field_order,",sfaa017"
      END IF
   END IF   
   
END FUNCTION

################################################################################
# Descriptions...: 列印后回写至aint820
# Memo...........:
# Usage..........: CALL ainr835_g01_update_inpb002(p_inpf004,p_ent,p_site)
# Date & Author..: 2015-9-10 By zhujing
# Modify.........:
################################################################################
PRIVATE FUNCTION ainr835_g01_update_inpb002(p_inpf004,p_ent,p_site)
DEFINE p_inpf004     LIKE inpf_t.inpf004
DEFINE p_ent         LIKE inpf_t.inpfent
DEFINE p_site        LIKE inpf_t.inpfsite
DEFINE l_inpa023     LIKE inpa_t.inpa023

   SELECT inpa023 INTO l_inpa023    #判断是否需要回写
     FROM inpa_t 
     LEFT OUTER JOIN inpb_t ON inpadocno = inpbdocno AND inpaent = inpbent
    WHERE inpaent = p_ent
      AND inpasite = p_site 
      AND inpadocno = p_inpf004
      AND inpb001 = '3'
      AND inpa023 IN ('1','3')
   IF cl_null(l_inpa023) THEN
      RETURN
   END IF
   
   UPDATE inpb_t SET inpb002 = 'Y',        #进行回写
                     inpb003 = 100      #160518-00054#1 2016-5-18 add    
   WHERE inpbdocno = p_inpf004 AND inpbent = p_ent AND inpbsite = p_site AND inpb001 = '3'
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
 
{<section id="ainr835_g01.other_report" readonly="Y" >}
{<point name="other.report"/>}
 
{</section>}
 
