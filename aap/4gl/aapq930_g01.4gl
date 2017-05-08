#該程式未解開Section, 採用最新樣板產出!
{<section id="aapq930_g01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:4(2016-11-09 17:15:30), PR版次:0004(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:(), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000073
#+ Filename...: aapq930_g01
#+ Description: 供應商應付帳齡分析報表
#+ Creator....: 05016(2014-12-17 17:04:26)
#+ Modifier...: 08992 -SD/PR- 00000
 
{</section>}
 
{<section id="aapq930_g01.global" readonly="Y" >}
#報表 g01 樣板自動產生(Version:11)
#add-point:填寫註解說明

#end add-point
#add-point:填寫註解說明

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
GLOBALS "../../cfg/top_report.inc"                  #報表使用的global
 
#報表 type 宣告
PRIVATE TYPE sr1_r RECORD
   l_sel2 LIKE type_t.chr100, 
   l_xreb100 LIKE xreb_t.xreb100, 
   l_xred1031 LIKE xred_t.xred103, 
   l_xred1032 LIKE xred_t.xred103, 
   l_xred1033 LIKE xred_t.xred103, 
   l_xred103 LIKE xred_t.xred103, 
   l_xred1131 LIKE xred_t.xred113, 
   l_xred1132 LIKE xred_t.xred113, 
   l_xred1133 LIKE xred_t.xred113, 
   l_xred113 LIKE xred_t.xred113, 
   l_xred113_401 LIKE xred_t.xred133, 
   l_xred113_402 LIKE xred_t.xred113, 
   l_xred113_403 LIKE xred_t.xred103, 
   l_xred113_404 LIKE xred_t.xred113, 
   l_xred113_405 LIKE xred_t.xred103, 
   l_xred113_406 LIKE xred_t.xred113, 
   l_xred113_407 LIKE xred_t.xred113, 
   l_xred113_408 LIKE xred_t.xred113, 
   l_xred113_409 LIKE xred_t.xred113, 
   l_xred113_410 LIKE xred_t.xred113, 
   l_xred113_411 LIKE xred_t.xred113, 
   l_xred113_412 LIKE xred_t.xred113, 
   l_xred113_413 LIKE xred_t.xred113, 
   l_xred113_414 LIKE xred_t.xred113, 
   l_xred113_415 LIKE xred_t.xred113, 
   l_xred113_416 LIKE xred_t.xred113, 
   l_xred113_417 LIKE xred_t.xred113, 
   l_xred113_418 LIKE xred_t.xred113, 
   l_xred113_419 LIKE xred_t.xred113, 
   l_xred113_420 LIKE xred_t.xred113, 
   l_xred113_421 LIKE xred_t.xred113, 
   apcaent LIKE apca_t.apcaent, 
   apcadocno LIKE apca_t.apcadocno, 
   apcald LIKE apca_t.apcald
END RECORD
 
PRIVATE TYPE sr2_r RECORD
   ooff013 LIKE ooff_t.ooff013
END RECORD
 
 
DEFINE tm RECORD
       wc STRING,                  #where condotion 
       a1 STRING,                  #temp_tble 
       a2 LIKE type_t.chr100,         #xrad001 
       a3 LIKE type_t.chr100          #end_day
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
DEFINE g_tmptable      STRING
DEFINE g_xrad001       LIKE xrad_t.xrad001
DEFINE g_endday        LIKE type_t.chr100
#end add-point
 
{</section>}
 
{<section id="aapq930_g01.main" readonly="Y" >}
PUBLIC FUNCTION aapq930_g01(p_arg1,p_arg2,p_arg3,p_arg4)
DEFINE  p_arg1 STRING                  #tm.wc  where condotion 
DEFINE  p_arg2 STRING                  #tm.a1  temp_tble 
DEFINE  p_arg3 LIKE type_t.chr100         #tm.a2  xrad001 
DEFINE  p_arg4 LIKE type_t.chr100         #tm.a3  end_day
#add-point:init段define (客製用) name="component_name.define_customerization"

#end add-point
#add-point:init段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="component_name.define"

#end add-point
 
   LET tm.wc = p_arg1
   LET tm.a1 = p_arg2
   LET tm.a2 = p_arg3
   LET tm.a3 = p_arg4
 
   #add-point:報表元件參數準備 name="component.arg.prep"
   LET g_tmptable = tm.a1
   LET g_xrad001  = tm.a2
   LET g_endday   = tm.a3
   #end add-point
   #報表元件代號
   
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   ##報表元件執行期間是否有錯誤代碼
   LET g_rep_success = 'Y'   
   
   LET g_rep_code = "aapq930_g01"
   IF cl_null(tm.wc) THEN LET tm.wc = " 1=1" END IF
 
   #主報表select子句準備
   CALL aapq930_g01_sel_prep()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料存入array
   CALL aapq930_g01_ins_data()
   
   IF g_rep_success = 'N' THEN
      RETURN
   END IF   
 
   #將資料印出
   CALL aapq930_g01_rep_data()
 
END FUNCTION
 
{</section>}
 
{<section id="aapq930_g01.sel_prep" readonly="Y" >}
#+ 選單功能實際執行處
PRIVATE FUNCTION aapq930_g01_sel_prep()
   #add-point:sel_prep段define (客製用) name="sel_prep.define_customerization"
   
   #end add-point
   #add-point:sel_prep段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="sel_prep.define"
   
   #end add-point
 
   #add-point:sel_prep before name="sel_prep.before"
   
   #end add-point
   
   #add-point:sel_prep g_select name="sel_prep.g_select"
   LET g_select = " SELECT sel2,xreb100,                                    ",
                  "        xred1031,xred1032,xred1033,xred103,              ",
                  "        xred1131,xred1132,xred1133,xred113,              ",
                  "        xred113_401,xred113_402,xred113_403,xred113_404, ",
                  "        xred113_405,xred113_406,xred113_407,xred113_408, ",
                  "        xred113_409,xred113_410,xred113_411,xred113_412, ",
                  "        xred113_413,xred113_414,xred113_415,xred113_416, ",
                  "        xred113_417,xred113_418,xred113_419,xred113_420, ",
                  "        xred113_421                                      "

#   #end add-point
#   LET g_select = " SELECT '','','','','','','','','','','','','','','','','','','','','','','','','', 
#       '','','','','','',apcaent,apcadocno,apcald"
# 
#   #add-point:sel_prep g_from name="sel_prep.g_from"
   LET g_from = " FROM ",g_tmptable
#   #end add-point
#    LET g_from = " FROM apca_t"
# 
#   #add-point:sel_prep g_where name="sel_prep.g_where"
 
   #end add-point
    LET g_where = " WHERE " ,tm.wc CLIPPED 
 
   #add-point:sel_prep g_order name="sel_prep.g_order"
   LET g_order = " ORDER BY sel2 "
#   #end add-point
#    LET g_order = " ORDER BY apcadocno"
# 
#   #add-point:sel_prep.sql.before name="sel_prep.sql.before"
   
   #end add-point:sel_prep.sql.before
   LET g_where = g_where ,cl_sql_add_filter("apca_t")   #資料過濾功能
   LET g_sql = g_select CLIPPED ," ",g_from CLIPPED ," ",g_where CLIPPED ," ",g_order CLIPPED
   LET g_sql = cl_sql_add_mask(g_sql)    #遮蔽特定資料, 若寫至add-point也需複製此段 
 
   #add-point:sel_prep.sql.after name="sel_prep.sql.after"
   
   #end add-point
   PREPARE aapq930_g01_prepare FROM g_sql
   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.extend = 'prepare:'
      LET g_errparam.code   = STATUS
      LET g_errparam.popup  = TRUE
      CALL cl_err()   
      LET g_rep_success = 'N'    
   END IF
   DECLARE aapq930_g01_curs CURSOR FOR aapq930_g01_prepare
 
END FUNCTION
 
{</section>}
 
{<section id="aapq930_g01.ins_data" readonly="Y" >}
PRIVATE FUNCTION aapq930_g01_ins_data()
#主報表record(用於select子句)
   DEFINE sr_s RECORD 
   l_sel2 LIKE type_t.chr100, 
   l_xreb100 LIKE xreb_t.xreb100, 
   l_xred1031 LIKE xred_t.xred103, 
   l_xred1032 LIKE xred_t.xred103, 
   l_xred1033 LIKE xred_t.xred103, 
   l_xred103 LIKE xred_t.xred103, 
   l_xred1131 LIKE xred_t.xred113, 
   l_xred1132 LIKE xred_t.xred113, 
   l_xred1133 LIKE xred_t.xred113, 
   l_xred113 LIKE xred_t.xred113, 
   l_xred113_401 LIKE xred_t.xred133, 
   l_xred113_402 LIKE xred_t.xred113, 
   l_xred113_403 LIKE xred_t.xred103, 
   l_xred113_404 LIKE xred_t.xred113, 
   l_xred113_405 LIKE xred_t.xred103, 
   l_xred113_406 LIKE xred_t.xred113, 
   l_xred113_407 LIKE xred_t.xred113, 
   l_xred113_408 LIKE xred_t.xred113, 
   l_xred113_409 LIKE xred_t.xred113, 
   l_xred113_410 LIKE xred_t.xred113, 
   l_xred113_411 LIKE xred_t.xred113, 
   l_xred113_412 LIKE xred_t.xred113, 
   l_xred113_413 LIKE xred_t.xred113, 
   l_xred113_414 LIKE xred_t.xred113, 
   l_xred113_415 LIKE xred_t.xred113, 
   l_xred113_416 LIKE xred_t.xred113, 
   l_xred113_417 LIKE xred_t.xred113, 
   l_xred113_418 LIKE xred_t.xred113, 
   l_xred113_419 LIKE xred_t.xred113, 
   l_xred113_420 LIKE xred_t.xred113, 
   l_xred113_421 LIKE xred_t.xred113, 
   apcaent LIKE apca_t.apcaent, 
   apcadocno LIKE apca_t.apcadocno, 
   apcald LIKE apca_t.apcald
 END RECORD
   DEFINE l_cnt           LIKE type_t.num10
#add-point:ins_data段define (客製用) name="ins_data.define_customerization"

#end add-point   
#add-point:ins_data段define (請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="ins_data.define"

#end add-point
 
    #add-point:ins_data段before name="ins_data.before"
    
    #end add-point
 
    CALL sr.clear()                                  #rep sr
    LET l_cnt = 1
    FOREACH aapq930_g01_curs INTO sr_s.*
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
 
       #add-point:ins_data段before_arr name="ins_data.before.save"
       
       #end add-point
 
       #set rep array value
       LET sr[l_cnt].l_sel2 = sr_s.l_sel2
       LET sr[l_cnt].l_xreb100 = sr_s.l_xreb100
       LET sr[l_cnt].l_xred1031 = sr_s.l_xred1031
       LET sr[l_cnt].l_xred1032 = sr_s.l_xred1032
       LET sr[l_cnt].l_xred1033 = sr_s.l_xred1033
       LET sr[l_cnt].l_xred103 = sr_s.l_xred103
       LET sr[l_cnt].l_xred1131 = sr_s.l_xred1131
       LET sr[l_cnt].l_xred1132 = sr_s.l_xred1132
       LET sr[l_cnt].l_xred1133 = sr_s.l_xred1133
       LET sr[l_cnt].l_xred113 = sr_s.l_xred113
       LET sr[l_cnt].l_xred113_401 = sr_s.l_xred113_401
       LET sr[l_cnt].l_xred113_402 = sr_s.l_xred113_402
       LET sr[l_cnt].l_xred113_403 = sr_s.l_xred113_403
       LET sr[l_cnt].l_xred113_404 = sr_s.l_xred113_404
       LET sr[l_cnt].l_xred113_405 = sr_s.l_xred113_405
       LET sr[l_cnt].l_xred113_406 = sr_s.l_xred113_406
       LET sr[l_cnt].l_xred113_407 = sr_s.l_xred113_407
       LET sr[l_cnt].l_xred113_408 = sr_s.l_xred113_408
       LET sr[l_cnt].l_xred113_409 = sr_s.l_xred113_409
       LET sr[l_cnt].l_xred113_410 = sr_s.l_xred113_410
       LET sr[l_cnt].l_xred113_411 = sr_s.l_xred113_411
       LET sr[l_cnt].l_xred113_412 = sr_s.l_xred113_412
       LET sr[l_cnt].l_xred113_413 = sr_s.l_xred113_413
       LET sr[l_cnt].l_xred113_414 = sr_s.l_xred113_414
       LET sr[l_cnt].l_xred113_415 = sr_s.l_xred113_415
       LET sr[l_cnt].l_xred113_416 = sr_s.l_xred113_416
       LET sr[l_cnt].l_xred113_417 = sr_s.l_xred113_417
       LET sr[l_cnt].l_xred113_418 = sr_s.l_xred113_418
       LET sr[l_cnt].l_xred113_419 = sr_s.l_xred113_419
       LET sr[l_cnt].l_xred113_420 = sr_s.l_xred113_420
       LET sr[l_cnt].l_xred113_421 = sr_s.l_xred113_421
       LET sr[l_cnt].apcaent = sr_s.apcaent
       LET sr[l_cnt].apcadocno = sr_s.apcadocno
       LET sr[l_cnt].apcald = sr_s.apcald
 
 
       #add-point:ins_data段after_arr name="ins_data.after.save"
       
       #end add-point
       LET l_cnt = l_cnt + 1
    END FOREACH
    CALL sr.deleteElement(l_cnt)
 
    #add-point:ins_data段after name="ins_data.after"
    
    #end add-point
END FUNCTION
 
{</section>}
 
{<section id="aapq930_g01.rep_data" readonly="Y" >}
PRIVATE FUNCTION aapq930_g01_rep_data()
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
          START REPORT aapq930_g01_rep TO XML HANDLER handler
          FOR l_i = 1 TO sr.getLength()
             OUTPUT TO REPORT aapq930_g01_rep(sr[l_i].*)
          END FOR
          FINISH REPORT aapq930_g01_rep
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
 
{<section id="aapq930_g01.rep" readonly="Y" >}
PRIVATE REPORT aapq930_g01_rep(sr1)
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
 DEFINE l_xrae      DYNAMIC ARRAY OF RECORD 
          str      LIKE xrae_t.xrae003,
          end      LIKE xrae_t.xrae004 
          END RECORD

DEFINE l_title1     LIKE gzzd_t.gzzd005
DEFINE l_title2     LIKE gzzd_t.gzzd005

   DEFINE l_title DYNAMIC ARRAY OF RECORD
          title1   LIKE type_t.chr500
          END RECORD

DEFINE l_i      LIKE type_t.num5

 TYPE type_l_xred113_40 RECORD 
         title1   LIKE type_t.chr100,
         title2   LIKE type_t.chr100,
         title3   LIKE type_t.chr100,
         title4   LIKE type_t.chr100,
         title5   LIKE type_t.chr100,
         title6   LIKE type_t.chr100,
         title7   LIKE type_t.chr100,
         title8   LIKE type_t.chr100,
         title9   LIKE type_t.chr100,
         title10  LIKE type_t.chr100,
         title11  LIKE type_t.chr100,
         title12  LIKE type_t.chr100,
         title13  LIKE type_t.chr100,
         title14  LIKE type_t.chr100,
         title15  LIKE type_t.chr100,
         title16  LIKE type_t.chr100,
         title17  LIKE type_t.chr100,
         title18  LIKE type_t.chr100,
         title19  LIKE type_t.chr100,
         title20  LIKE type_t.chr100,
         title21  LIKE type_t.chr100
          END RECORD
DEFINE l_xred113_40               type_l_xred113_40
DEFINE l_xred113_40_show          type_l_xred113_40
#end add-point
 
    #add-point:rep段ORDER_before name="rep.order.before"
    
    #end add-point
    ORDER  BY sr1.apcadocno
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
        BEFORE GROUP OF sr1.apcadocno
            #報表 d05 樣板自動產生(Version:6)
            CALL cl_gr_title_clear()  #清除title變數值 
            #add-point:rep.header  #公司資訊(不在公用變數內) name="rep.header"
            
            #end add-point:rep.header 
            LET g_rep_docno = sr1.apcadocno
            CALL cl_gr_init_pageheader() #表頭資訊
            PRINTX g_grPageHeader.*
            PRINTX g_grPageFooter.*
            #add-point:rep.apr.signstr.before name="rep.apr.signstr.before"
                          
            #end add-point:rep.apr.signstr.before   
            LET g_doc_key = 'apcaent=' ,sr1.apcaent,'{+}apcald=' ,sr1.apcald,'{+}apcadocno=' ,sr1.apcadocno         
            CALL cl_gr_init_apr(sr1.apcadocno)
            #add-point:rep.apr.signstr name="rep.apr.signstr"
                          
            #end add-point:rep.apr.signstr
            PRINTX g_grSign.*
 
 
 
           #add-point:rep.b_group.apcadocno.before name="rep.b_group.apcadocno.before"
           LET l_i = 1 
           INITIALIZE l_xred113_40.* TO NULL
           INITIALIZE l_xred113_40_show.* TO NULL
           CALL l_xrae.clear()
           
           LET g_sql = " SELECT xrae003,xrae004                 ",     
                       "   FROM xrae_t                          ",
                       "  WHERE xraeent = ",g_enterprise,"      ",
                       "    AND xrae001 = '",g_xrad001,"' "  
           PREPARE aapq930_pb2_prep2 FROM g_sql
           DECLARE aapq930_pb2_curs2 CURSOR FOR  aapq930_pb2_prep2
           FOREACH aapq930_pb2_curs2 INTO l_xrae[l_i].str,l_xrae[l_i].end            
              LET l_i = l_i + 1      
           END FOREACH  
           CALL l_xrae.deleteElement(l_xrae.getLength())
           
           FOR l_i = 1 TO 10
              LET l_title1 = ''
              SELECT gzzd005 INTO l_title[l_i].title1  FROM gzzd_t WHERE gzzd003 = 'title1' AND gzzd002 = g_dlang AND gzzd001 = 'aapq930'   
              LET l_title[l_i].title1 = l_xrae[l_i].str||'-'||l_xrae[l_i].end,l_title[l_i].title1 #組出來的字串"XX-XX天未沖本幣"                                         
           END FOR
           FOR l_i = 11 TO 20
              LET l_title1 = ''
              SELECT gzzd005 INTO l_title[l_i].title1  FROM gzzd_t WHERE gzzd003 = 'title1' AND gzzd002 = g_dlang AND gzzd001 = 'aapq930'   
              LET l_title[l_i].title1 = l_xrae[l_i].str||'-'||l_xrae[l_i].end,l_title[l_i].title1 #組出來的字串"XX-XX天未沖本幣"                                      
           END FOR     
           #置換Title
           LET l_xred113_40.title1  = l_title[1].title1
           LET l_xred113_40.title2  = l_title[2].title1 
           LET l_xred113_40.title3  = l_title[3].title1 
           LET l_xred113_40.title4  = l_title[4].title1 
           LET l_xred113_40.title5  = l_title[5].title1 
           LET l_xred113_40.title6  = l_title[6].title1 
           LET l_xred113_40.title7  = l_title[7].title1 
           LET l_xred113_40.title8  = l_title[8].title1 
           LET l_xred113_40.title9  = l_title[9].title1 
           LET l_xred113_40.title10 = l_title[10].title1 
           LET l_xred113_40.title11 = l_title[11].title1 
           LET l_xred113_40.title12 = l_title[12].title1 
           LET l_xred113_40.title13 = l_title[13].title1 
           LET l_xred113_40.title14 = l_title[14].title1 
           LET l_xred113_40.title15 = l_title[15].title1 
           LET l_xred113_40.title16 = l_title[16].title1 
           LET l_xred113_40.title17 = l_title[17].title1 
           LET l_xred113_40.title18 = l_title[18].title1 
           LET l_xred113_40.title19 = l_title[19].title1 
           LET l_xred113_40.title20 = l_title[20].title1            
           LET l_xred113_40.title21 = g_endday #最後一欄   
           
           CALL aapq930_g01_show(l_xrae[1].str) RETURNING l_xred113_40_show.title1
           CALL aapq930_g01_show(l_xrae[2].str) RETURNING l_xred113_40_show.title2  
           CALL aapq930_g01_show(l_xrae[3].str) RETURNING l_xred113_40_show.title3  
           CALL aapq930_g01_show(l_xrae[4].str) RETURNING l_xred113_40_show.title4  
           CALL aapq930_g01_show(l_xrae[5].str) RETURNING l_xred113_40_show.title5  
           CALL aapq930_g01_show(l_xrae[6].str) RETURNING l_xred113_40_show.title6  
           CALL aapq930_g01_show(l_xrae[7].str) RETURNING l_xred113_40_show.title7  
           CALL aapq930_g01_show(l_xrae[8].str) RETURNING l_xred113_40_show.title8  
           CALL aapq930_g01_show(l_xrae[9].str) RETURNING l_xred113_40_show.title9  
           CALL aapq930_g01_show(l_xrae[10].str) RETURNING l_xred113_40_show.title10  
           CALL aapq930_g01_show(l_xrae[11].str) RETURNING l_xred113_40_show.title11  
           CALL aapq930_g01_show(l_xrae[12].str) RETURNING l_xred113_40_show.title12  
           CALL aapq930_g01_show(l_xrae[13].str) RETURNING l_xred113_40_show.title13  
           CALL aapq930_g01_show(l_xrae[14].str) RETURNING l_xred113_40_show.title14 
           CALL aapq930_g01_show(l_xrae[15].str) RETURNING l_xred113_40_show.title15  
           CALL aapq930_g01_show(l_xrae[16].str) RETURNING l_xred113_40_show.title16  
           CALL aapq930_g01_show(l_xrae[17].str) RETURNING l_xred113_40_show.title17  
           CALL aapq930_g01_show(l_xrae[18].str) RETURNING l_xred113_40_show.title18  
           CALL aapq930_g01_show(l_xrae[19].str) RETURNING l_xred113_40_show.title19 
           CALL aapq930_g01_show(l_xrae[20].str) RETURNING l_xred113_40_show.title20             
           


           PRINTX l_xred113_40.*
           PRINTX l_xred113_40_show.*
      
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub01.before name="rep.sub01.before"
           
           #end add-point:rep.sub01.before
 
           #add-point:rep.sub01.sql name="rep.sub01.sql"
           
           #end add-point:rep.sub01.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='2' AND ooffent = '", 
                sr1.apcaent CLIPPED ,"'", " AND  ooff002 = '", sr1.apcadocno CLIPPED ,"'"
 
           #add-point:rep.sub01.afsql name="rep.sub01.afsql"
           
           #end add-point:rep.sub01.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep01_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aapq930_g01_repcur01_cnt_pre FROM l_sub_sql
           EXECUTE aapq930_g01_repcur01_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep01_show ="Y"
           END IF
           PRINTX l_subrep01_show
           START REPORT aapq930_g01_subrep01
           DECLARE aapq930_g01_repcur01 CURSOR FROM g_sql
           FOREACH aapq930_g01_repcur01 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aapq930_g01_repcur01:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub01.foreach name="rep.sub01.foreach"
              
              #end add-point:rep.sub01.foreach
              OUTPUT TO REPORT aapq930_g01_subrep01(sr2.*)
           END FOREACH
           FINISH REPORT aapq930_g01_subrep01
           #add-point:rep.sub01.after name="rep.sub01.after"
           
           #end add-point:rep.sub01.after
 
 
 
           #add-point:rep.b_group.apcadocno.after name="rep.b_group.apcadocno.after"
           
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
                sr1.apcaent CLIPPED ,"'", " AND  ooff002 = '", sr1.apcadocno CLIPPED ,"'"
 
           #add-point:rep.sub02.afsql name="rep.sub02.afsql"
           
           #end add-point:rep.sub02.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep02_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aapq930_g01_repcur02_cnt_pre FROM l_sub_sql
           EXECUTE aapq930_g01_repcur02_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep02_show ="Y"
           END IF
           PRINTX l_subrep02_show
           START REPORT aapq930_g01_subrep02
           DECLARE aapq930_g01_repcur02 CURSOR FROM g_sql
           FOREACH aapq930_g01_repcur02 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aapq930_g01_repcur02:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub02.foreach name="rep.sub02.foreach"
              
              #end add-point:rep.sub02.foreach
              OUTPUT TO REPORT aapq930_g01_subrep02(sr2.*)
           END FOREACH
           FINISH REPORT aapq930_g01_subrep02
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
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='7' AND ooff012='1' AND ooff002 = '", 
                sr1.apcaent CLIPPED ,"'"
 
           #add-point:rep.sub03.afsql name="rep.sub03.afsql"
           
           #end add-point:rep.sub03.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep03_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aapq930_g01_repcur03_cnt_pre FROM l_sub_sql
           EXECUTE aapq930_g01_repcur03_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep03_show ="Y"
           END IF
           PRINTX l_subrep03_show
           START REPORT aapq930_g01_subrep03
           DECLARE aapq930_g01_repcur03 CURSOR FROM g_sql
           FOREACH aapq930_g01_repcur03 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aapq930_g01_repcur03:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub03.foreach name="rep.sub03.foreach"
              
              #end add-point:rep.sub03.foreach
              OUTPUT TO REPORT aapq930_g01_subrep03(sr2.*)
           END FOREACH
           FINISH REPORT aapq930_g01_subrep03
           #add-point:rep.sub03.after name="rep.sub03.after"
           
           #end add-point:rep.sub03.after
 
 
 
          #add-point:rep.everyrow.after name="rep.everyrow.after"
          
          #end add-point:rep.everyrow.after        
 
          #讀取afterGrup子樣板+子報表樣板
        #報表 d01 樣板自動產生(Version:2)
        AFTER GROUP OF sr1.apcadocno
 
           #add-point:rep.a_group.apcadocno.before name="rep.a_group.apcadocno.before"
          
           #end add-point:
 
           #報表 d03 樣板自動產生(Version:3)
           #add-point:rep.sub04.before name="rep.sub04.before"
           
           #end add-point:rep.sub04.before
 
           #add-point:rep.sub04.sql name="rep.sub04.sql"
           
           #end add-point:rep.sub04.sql
 
           LET g_sql = " SELECT ooff013 FROM ooff_t WHERE ooffstus='Y' and ooff001='6' AND ooff012='1' AND ooffent = '", 
                sr1.apcaent CLIPPED ,"'", " AND  ooff002 = '", sr1.apcadocno CLIPPED ,"'"
 
           #add-point:rep.sub04.afsql name="rep.sub04.afsql"
           
           #end add-point:rep.sub04.afsql           
           LET l_cnt = 0
           LET l_sub_sql = ""
           LET l_subrep04_show ="N"
           LET l_sub_sql = "SELECT COUNT(1) FROM (",g_sql,")"
           PREPARE aapq930_g01_repcur04_cnt_pre FROM l_sub_sql
           EXECUTE aapq930_g01_repcur04_cnt_pre INTO l_cnt
           IF l_cnt > 0 THEN 
              LET l_subrep04_show ="Y"
           END IF
           PRINTX l_subrep04_show
           START REPORT aapq930_g01_subrep04
           DECLARE aapq930_g01_repcur04 CURSOR FROM g_sql
           FOREACH aapq930_g01_repcur04 INTO sr2.*
              IF STATUS THEN 
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.extend = "aapq930_g01_repcur04:"
                 LET g_errparam.code   = SQLCA.sqlcode
                 LET g_errparam.popup  = FALSE
                 CALL cl_err()                  
                 EXIT FOREACH 
              END IF
              #add-point:rep.sub04.foreach name="rep.sub04.foreach"
              
              #end add-point:rep.sub04.foreach
              OUTPUT TO REPORT aapq930_g01_subrep04(sr2.*)
           END FOREACH
           FINISH REPORT aapq930_g01_subrep04
           #add-point:rep.sub04.after name="rep.sub04.after"
           
           #end add-point:rep.sub04.after
 
 
 
           #add-point:rep.a_group.apcadocno.after name="rep.a_group.apcadocno.after"
           
           #end add-point:
 
 
 
       ON LAST ROW
            #add-point:rep.lastrow.before name="rep.lastrow.before"  
                    
            #end add-point :rep.lastrow.before
 
            #add-point:rep.lastrow.after name="rep.lastrow.after"
            
            #end add-point :rep.lastrow.after
END REPORT
 
{</section>}
 
{<section id="aapq930_g01.subrep_str" readonly="Y" >}
#讀取子報表樣板
#報表 d02 樣板自動產生(Version:3)
PRIVATE REPORT aapq930_g01_subrep01(sr2)
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
PRIVATE REPORT aapq930_g01_subrep02(sr2)
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
PRIVATE REPORT aapq930_g01_subrep03(sr2)
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
PRIVATE REPORT aapq930_g01_subrep04(sr2)
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
 
{<section id="aapq930_g01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 欄位隱藏
# Memo...........:
# Usage..........: CALL aapq930_g01_show(p_arg1)
# Date & Author..: 2014/12/18 By Hans
# Modify.........:
################################################################################
PUBLIC FUNCTION aapq930_g01_show(p_arg1)
   DEFINE p_arg1 LIKE type_t.chr1000
   DEFINE r_show LIKE type_t.chr1

      IF cl_null(p_arg1)  THEN
         LET r_show = "N"
      ELSE
         LET r_show = "Y"
      END IF
      RETURN r_show
END FUNCTION

 
{</section>}
 
{<section id="aapq930_g01.other_report" readonly="Y" >}
{<point name="other.report"/>}
 
{</section>}
 
