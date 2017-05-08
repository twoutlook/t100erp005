#該程式已解開Section, 不再透過樣板產出!
{<section id="asrt339_02.description" >}
#+ Version..: T100-ERP-1.00.00(SD版次:1,PR版次:1) Build-000008
#+ 
#+ Filename...: asrt339_02
#+ Description: ...
#+ Creator....: 00537(2014/07/04)
#+ Modifier...: 00537(2014/07/07)
#+ Buildtype..: 應用 c02b 樣板自動產生
#+ 以上段落由子樣板a00產生
 
{</section>}
 
{<section id="asrt339_02.global" >}
#add-point:填寫註解說明 name="global.memo"
#160318-00025#41  2016/04/25  By pengxin  將重複內容的錯誤訊息置換為公用錯誤訊息(r.v)
#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_sfjb_d        RECORD
       sfjbdocno LIKE sfjb_t.sfjbdocno, 
   sfjbseq LIKE sfjb_t.sfjbseq, 
#   sfjb001 LIKE sfjb_t.sfjb001, 
#   sfjb002 LIKE sfjb_t.sfjb002, 
   sfjb019 LIKE sfjb_t.sfjb019, 
   sfjb016 LIKE sfjb_t.sfjb016, 
   sfjb017 LIKE sfjb_t.sfjb017, 
   sfjb018 LIKE sfjb_t.sfjb018, 
   sfjb003 LIKE sfjb_t.sfjb003, 
   sfjb003_desc LIKE type_t.chr500, 
   sfjb003_desc_1 LIKE type_t.chr500,
   sfjb004 LIKE sfjb_t.sfjb004, 
   sfjb005 LIKE sfjb_t.sfjb005, 
   sfjb005_desc LIKE type_t.chr500, 
   sfba013 LIKE type_t.num20_6, 
   sfba016 LIKE type_t.num20_6, 
   sfba025 LIKE type_t.num20_6, 
   sfba017 LIKE type_t.num20_6, 
   sfjb006 LIKE sfjb_t.sfjb006, 
   sfjb007 LIKE sfjb_t.sfjb007, 
   sfjb007_desc LIKE type_t.chr500, 
   sfjb008 LIKE sfjb_t.sfjb008, 
   sfjb009 LIKE sfjb_t.sfjb009, 
   sfjb009_desc LIKE type_t.chr500, 
   sfjb010 LIKE sfjb_t.sfjb010, 
   sfjb011 LIKE sfjb_t.sfjb011, 
   sfjb011_desc LIKE type_t.chr500, 
   sfjb012 LIKE sfjb_t.sfjb012, 
   sfjb012_desc LIKE type_t.chr500, 
   sfjb013 LIKE sfjb_t.sfjb013, 
   sfjb014 LIKE sfjb_t.sfjb014
       END RECORD
PRIVATE TYPE type_g_sfjb2_d RECORD
       sfjcseq1 LIKE sfjc_t.sfjcseq1, 
   sfjc010 LIKE sfjc_t.sfjc010, 
   sfjc006 LIKE sfjc_t.sfjc006, 
   sfjc008 LIKE sfjc_t.sfjc008, 
   sfjc009 LIKE sfjc_t.sfjc009, 
   sfjc009_desc LIKE type_t.chr500, 
   sfjc011 LIKE sfjc_t.sfjc011, 
   sfjc011_desc LIKE type_t.chr500, 
   sfjc012 LIKE sfjc_t.sfjc012, 
   sfjc012_desc LIKE type_t.chr500, 
   sfjc013 LIKE sfjc_t.sfjc013, 
   sfjc014 LIKE sfjc_t.sfjc014
       END RECORD
 
 
DEFINE g_sfjb_d          DYNAMIC ARRAY OF type_g_sfjb_d
DEFINE g_sfjb_d_t        type_g_sfjb_d
DEFINE g_sfjb2_d   DYNAMIC ARRAY OF type_g_sfjb2_d
DEFINE g_sfjb2_d_t type_g_sfjb2_d
 
 
DEFINE g_sfjbdocno_t   LIKE sfjb_t.sfjbdocno    #Key值備份
DEFINE g_sfjbseq_t      LIKE sfjb_t.sfjbseq    #Key值備份
 
 
DEFINE l_ac                  LIKE type_t.num5
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rec_b               LIKE type_t.num5  
DEFINE g_detail_idx          LIKE type_t.num5  
 
 
#add-point:自定義模組變數(Module Variable)
DEFINE g_sfjadocno           LIKE sfja_t.sfjadocno
DEFINE g_forupd_sql          STRING
DEFINE g_detail_cnt          LIKE type_t.num5              #單身總筆數
DEFINE l_ac1                 LIKE type_t.num5
DEFINE g_cnt                 LIKE type_t.num5
DEFINE g_detail_idx2         LIKE type_t.num5 
DEFINE g_sql                 STRING
DEFINE g_error_show          LIKE type_t.num5 
#end add-point
    
#add-point:傳入參數說明(global.argv)

#end add-point	
 
{</section>}
 
{<section id="asrt339_02.input" >}
#+ 資料輸入
PUBLIC FUNCTION asrt339_02(--)
   #add-point:input段變數傳入
   p_sfjadocno
   #end add-point
   )
   DEFINE l_ac_t          LIKE type_t.num5        #未取消的ARRAY CNT 
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num5
   DEFINE l_insert        LIKE type_t.num5
   DEFINE l_cmd           LIKE type_t.chr5
   #add-point:input段define
   DEFINE p_sfjadocno     LIKE sfja_t.sfjadocno
   DEFINE l_sfjastus      LIKE sfja_t.sfjastus
   DEFINE p_cmd           LIKE type_t.chr1
   DEFINE l_n             LIKE type_t.num5                #檢查重複用  
   DEFINE l_cnt           LIKE type_t.num5                #檢查重複用  
   DEFINE l_lock_sw       LIKE type_t.chr1                #單身鎖住否
   DEFINE l_sfjc006       LIKE sfjc_t.sfjc006
   DEFINE l_sfjc006_t     LIKE sfjc_t.sfjc006
   DEFINE l_sfjc006_sum   LIKE sfjc_t.sfjc006
   DEFINE l_sfjc008       LIKE sfjc_t.sfjc008
   DEFINE l_sfjc008_t     LIKE sfjc_t.sfjc008
   DEFINE l_sfjc008_sum   LIKE sfjc_t.sfjc008
   DEFINE l_inaa007       LIKE inaa_t.inaa007
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_asrt339_02 WITH FORM cl_ap_formpath("asr","asrt339_02")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #輸入前處理
   #add-point:單身前置處理
   WHENEVER ERROR CONTINUE
   
   LET g_argv[1] = p_sfjadocno 
   LET g_sfjadocno = p_sfjadocno
   SELECT sfjastus INTO l_sfjastus
     FROM sfja_t
    WHERE sfjaent   = g_enterprise
      AND sfjasite  = g_site
      AND sfjadocno = p_sfjadocno
      
   IF l_sfjastus NOT MATCHES '[YN]' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'asf-00291'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()
      CLOSE WINDOW w_asrt339_02
      RETURN
   END IF

   CALL cl_set_combo_scc('sfjb010','5444') 
   CALL cl_set_combo_scc('sfjc010','5444') 
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0028')  = 'N' THEN  
      CALL cl_set_comp_visible("sfjb007,sfjb007_desc,sfjb008,sfjc007,sfjc007_desc,sfjc008",FALSE)
   END IF
   CALL asrt339_02_b1_fill()

#还要锁定第一单身的资料，离开才释放
   LET g_forupd_sql = "SELECT  sfjbseq,sfjb019,sfjb016,sfjb017,sfjb018,sfjb003,sfjb004,sfjb005,sfjb006,sfjb007, ", 
                      "        sfjb008,sfjb009,sfjb010,sfjb011,sfjb012,sfjb013,sfjb014 FROM sfjb_t",  
                      " WHERE sfjbent=? ",
                      "   AND sfjbdocno= ? ", 
                      "   AND sfjbseq=? FOR UPDATE"

   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE asrt339_02_bcl CURSOR FROM g_forupd_sql

#第二单身锁
   LET g_forupd_sql = " SELECT sfjcseq1,sfjc010,sfjc006,sfjc008,sfjc009,sfjc011,sfjc012,sfjc013,sfjc014 FROM sfjc_t ",  
                      "  WHERE sfjcent=? AND sfjcdocno=? AND sfjcseq=? AND sfjcseq1=? FOR UPDATE "
   LET g_forupd_sql = cl_sql_forupd(g_forupd_sql)
   LET g_forupd_sql = cl_sql_add_mask(g_forupd_sql)              #遮蔽特定資料
   DECLARE asrt339_02_bcl2 CURSOR FROM g_forupd_sql
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
#第一个单身pattern不支持全部去掉可编辑，自己改
         DISPLAY ARRAY g_sfjb_d TO s_detail1.* ATTRIBUTE(COUNT=g_detail_cnt) 
      
            BEFORE DISPLAY 
               #如果一直都在單頭則控制筆數位置
               CALL FGL_SET_ARR_CURR(g_detail_idx)
	  
            BEFORE ROW
               LET g_detail_idx = DIALOG.getCurrentRow("s_detail1")
               LET l_ac1 = g_detail_idx
               CALL cl_show_fld_cont()
               CALL asrt339_02_b2_fill()
               
            #自訂ACTION(detail_show,page_1)
            
               
         END DISPLAY   
#      #輸入開始
#      INPUT ARRAY g_sfjb_d FROM s_detail1.*
#          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
#                  INSERT ROW = l_allow_insert,
#                  DELETE ROW = l_allow_delete,
#                  APPEND ROW = l_allow_insert)
         
         #自訂ACTION
         #add-point:單身前置處理

#         #end add-point
#         
#         #自訂ACTION(detail_input)
#         
#         
#         BEFORE INPUT
#            #add-point:單身輸入前處理

#            #end add-point
#          
#          
#         
# 
#         #自訂ACTION
#         #add-point:單身其他段落處理(EX:on row change, etc...)

#         #end add-point
# 
#         AFTER INPUT
#            #add-point:單身輸入後處理

#            #end add-point
#            
#      END INPUT
#      
      INPUT ARRAY g_sfjb2_d FROM s_detail2.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
         
         #自訂ACTION
         #add-point:單身前置處理

         #end add-point
         
         #自訂ACTION(detail_input)
         
         
         BEFORE INPUT
            #add-point:單身輸入前處理
#pattern缺失单身结构，自己加
            LET g_detail_cnt = g_sfjb2_d.getLength()
            
         BEFORE ROW
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx2 = l_ac
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            CALL s_transaction_begin()
            LET g_detail_cnt = g_sfjb2_d.getLength()

#锁第一单身
            OPEN asrt339_02_bcl USING g_enterprise,g_sfjb_d[g_detail_idx].sfjbdocno,g_sfjb_d[g_detail_idx].sfjbseq     
            IF SQLCA.sqlcode THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "asrt339_02_bcl"
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET l_lock_sw='Y'
               CALL s_transaction_end('N','0')
               RETURN 
            END IF
            
            IF g_detail_cnt >= l_ac 
               AND g_sfjb2_d[l_ac].sfjcseq1 IS NOT NULL
            THEN 
               LET l_cmd='u'
               LET g_sfjb2_d_t.* = g_sfjb2_d[l_ac].*  #BACKUP
               OPEN asrt339_02_bcl2 USING g_enterprise,g_sfjb_d[g_detail_idx].sfjbdocno,g_sfjb_d[g_detail_idx].sfjbseq,g_sfjb2_d[g_detail_idx].sfjcseq1                
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "asrt339_02_bcl2"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET l_lock_sw='Y'
                  CALL s_transaction_end('N','0')
                  RETURN 
               ELSE
                  FETCH asrt339_02_bcl2 INTO g_sfjb2_d[l_ac].sfjcseq1,g_sfjb2_d[l_ac].sfjc010,g_sfjb2_d[l_ac].sfjc006,
                                             g_sfjb2_d[l_ac].sfjc008,g_sfjb2_d[l_ac].sfjc009,g_sfjb2_d[l_ac].sfjc011,g_sfjb2_d[l_ac].sfjc012, 
                                             g_sfjb2_d[l_ac].sfjc013,g_sfjb2_d[l_ac].sfjc014
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_lock_sw = "Y"
                     CALL s_transaction_end('N','0')
                  END IF
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            CALL asrt339_02_set_entry_b(l_cmd)
            CALL asrt339_02_set_no_entry_b(l_cmd)
            #add-point:input段before row
            CALL asrt339_02_set_no_required_b()
            CALL asrt339_02_set_required_b()
            
            CALL s_desc_get_stock_desc(g_site,g_sfjb2_d[l_ac].sfjc011)
            RETURNING g_sfjb2_d[l_ac].sfjc011_desc
                              
            CALL s_desc_get_locator_desc(g_site,g_sfjb2_d[l_ac].sfjc011,g_sfjb2_d[l_ac].sfjc012)
            RETURNING g_sfjb2_d[l_ac].sfjc012_desc
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_sfjb2_d[l_ac].sfjc009
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='227' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_sfjb2_d[l_ac].sfjc009_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_sfjb2_d[l_ac].sfjc009_desc


         BEFORE INSERT
            IF g_sfjb_d.getLength() = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'std-00013'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               NEXT FIELD sfjbdocno
            END IF 
            #判斷能否在此頁面進行資料新增            
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_sfjb2_d[l_ac].* TO NULL 
            
            LET g_sfjb2_d_t.* = g_sfjb2_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            CALL asrt339_02_set_entry_b("a")
            CALL asrt339_02_set_no_entry_b("a")
            #add-point:input段before insert
            LET g_sfjb2_d[l_ac].sfjc006 = 0
            LET g_sfjb2_d[l_ac].sfjc008 = 0
            LET g_sfjb2_d[l_ac].sfjc009 = g_sfjb_d[g_detail_idx].sfjb009
            LET g_sfjb2_d[l_ac].sfjc010 = g_sfjb_d[g_detail_idx].sfjb010
            LET g_sfjb2_d[l_ac].sfjc011 = g_sfjb_d[g_detail_idx].sfjb011
            LET g_sfjb2_d[l_ac].sfjc012 = g_sfjb_d[g_detail_idx].sfjb012
            LET g_sfjb2_d[l_ac].sfjc013 = g_sfjb_d[g_detail_idx].sfjb013
            LET g_sfjb2_d[l_ac].sfjc014 = g_sfjb_d[g_detail_idx].sfjb014
              
            IF g_sfjb2_d[l_ac].sfjcseq1 IS NULL OR g_sfjb2_d[l_ac].sfjcseq1 = 0 THEN
               SELECT MAX(sfjcseq1)+1 INTO g_sfjb2_d[l_ac].sfjcseq1
                 FROM sfjc_t
                WHERE sfjcent   = g_enterprise 
                  AND sfjcdocno = g_sfjb_d[g_detail_idx].sfjbdocno
                  AND sfjcseq   = g_sfjb_d[g_detail_idx].sfjbseq

            END IF
            IF g_sfjb2_d[l_ac].sfjcseq1 IS NULL THEN
               LET g_sfjb2_d[l_ac].sfjcseq1 = 1
            END IF 
            CALL s_desc_get_stock_desc(g_site,g_sfjb2_d[l_ac].sfjc011)
            RETURNING g_sfjb2_d[l_ac].sfjc011_desc
            CALL s_desc_get_locator_desc(g_site,g_sfjb2_d[l_ac].sfjc011,g_sfjb2_d[l_ac].sfjc012)
            RETURNING g_sfjb2_d[l_ac].sfjc012_desc 
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_sfjb2_d[l_ac].sfjc009
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='227' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_sfjb2_d[l_ac].sfjc009_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_sfjb2_d[l_ac].sfjc009_desc


         AFTER INSERT 
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
            
            IF (g_sfjb2_d[l_ac].sfjc010 = '2' OR g_sfjb2_d[l_ac].sfjc010 = '3') AND g_sfjb2_d[l_ac].sfjc011 IS NULL THEN
               INITIALIZE g_errparam TO NULL 
               LET g_errparam.extend = ''
               LET g_errparam.code   = 'asf-00455' 
               LET g_errparam.popup  = TRUE 
               CALL cl_err()
            END IF   
            
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM sfjc_t 
             WHERE sfjcent   = g_enterprise 
               AND sfjcsite  = g_site
               AND sfjcdocno = g_sfjb_d[g_detail_idx].sfjbdocno
               AND sfjcseq   = g_sfjb_d[g_detail_idx].sfjbseq
               AND sfjcseq1  = g_sfjb2_d[g_detail_idx2].sfjcseq1
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               IF g_sfjb_d[g_detail_idx].sfjb004 IS NULL THEN LET g_sfjb_d[g_detail_idx].sfjb004 = ' ' END IF
               INSERT INTO sfjc_t
                           (sfjcent,sfjcsite,sfjcdocno,sfjcseq,sfjcseq1,sfjc001,sfjc002,sfjc003,sfjc004,sfjc005,sfjc006,
                            sfjc007,sfjc008,sfjc009,sfjc010,sfjc011,sfjc012,sfjc013,sfjc014 ) 
                     VALUES(g_enterprise,g_site,g_sfjb_d[g_detail_idx].sfjbdocno,g_sfjb_d[g_detail_idx].sfjbseq,g_sfjb2_d[g_detail_idx2].sfjcseq1,
                            g_sfjb_d[g_detail_idx].sfjb003,
                            g_sfjb_d[g_detail_idx].sfjb004,g_sfjb_d[g_detail_idx].sfjb005,g_sfjb2_d[g_detail_idx2].sfjc006,
                            g_sfjb_d[g_detail_idx].sfjb007,g_sfjb2_d[g_detail_idx2].sfjc008,g_sfjb2_d[g_detail_idx2].sfjc009,
                            g_sfjb2_d[g_detail_idx2].sfjc010,g_sfjb2_d[g_detail_idx2].sfjc011,g_sfjb2_d[g_detail_idx2].sfjc012,
                            g_sfjb2_d[g_detail_idx2].sfjc013,g_sfjb2_d[g_detail_idx2].sfjc014 )
               #end add-point
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = 'INSERT'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CALL s_transaction_end('N','0')
                  CANCEL INSERT
               END IF
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_sfjb_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "sfjc_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_detail_cnt = g_detail_cnt + 1
            END IF


         BEFORE DELETE
            IF l_cmd = 'a' AND g_sfjb2_d.getLength() < l_ac THEN
               CALL FGL_SET_ARR_CURR(l_ac-1)
               CALL g_sfjb2_d.deleteElement(l_ac)
               NEXT FIELD sfjcseq1
            END IF
            IF g_sfjb2_d[l_ac].sfjcseq1 IS NOT NULL
            THEN
               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  -263
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CANCEL DELETE
               END IF
               
               DELETE FROM sfjc_t
                WHERE sfjcent   = g_enterprise 
                  AND sfjcsite  = g_site
                  AND sfjcdocno = g_sfjb_d[g_detail_idx].sfjbdocno
                  AND sfjcseq   = g_sfjb_d[g_detail_idx].sfjbseq
                  AND sfjcseq1  = g_sfjb2_d_t.sfjcseq1
                    
                   
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "sfjb_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  LET g_detail_cnt = g_detail_cnt-1
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE asrt339_02_bcl2
            END IF 
            
         ON ROW CHANGE 
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_sfjb2_d[l_ac].* = g_sfjb2_d_t.*
               CLOSE asrt339_02_bcl2
               CALL s_transaction_end('N','0')
               EXIT DIALOG 
            END IF
            
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_sfjb2_d[l_ac].* = g_sfjb2_d_t.*
            ELSE
               IF (g_sfjb2_d[l_ac].sfjc010 = '2' OR g_sfjb2_d[l_ac].sfjc010 = '3') AND g_sfjb2_d[l_ac].sfjc011 IS NULL THEN
                  INITIALIZE g_errparam TO NULL 
                  LET g_errparam.extend = ''
                  LET g_errparam.code   = 'asf-00455' 
                  LET g_errparam.popup  = TRUE 
                  CALL cl_err()
               END IF 

               UPDATE sfjc_t SET (sfjcseq1,sfjc006,sfjc008,sfjc009,sfjc010,sfjc011,sfjc012,sfjc013,sfjc014) 
                               = (g_sfjb2_d[l_ac].sfjcseq1,g_sfjb2_d[l_ac].sfjc006,g_sfjb2_d[l_ac].sfjc008,
                                  g_sfjb2_d[l_ac].sfjc009,g_sfjb2_d[l_ac].sfjc010,g_sfjb2_d[l_ac].sfjc011,
                                  g_sfjb2_d[l_ac].sfjc012,g_sfjb2_d[l_ac].sfjc013,g_sfjb2_d[l_ac].sfjc014)
                WHERE sfjcent   = g_enterprise
                  AND sfjcsite  = g_site
                  AND sfjcdocno = g_sfjb_d[g_detail_idx].sfjbdocno
                  AND sfjcseq   = g_sfjb_d[g_detail_idx].sfjbseq
                  AND sfjcseq1  = g_sfjb2_d_t.sfjcseq1
                   
                   
               CASE
                  WHEN SQLCA.sqlerrd[3] = 0  #更新不到的處理
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = "std-00009"
                     LET g_errparam.extend = "sfjc_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     CALL s_transaction_end('N','0')
                     LET g_sfjb2_d[l_ac].* = g_sfjb2_d_t.*
                  WHEN SQLCA.sqlcode #其他錯誤
                     INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "sfjc_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
                     CALL s_transaction_end('N','0')
                     LET g_sfjb2_d[l_ac].* = g_sfjb2_d_t.*
                  OTHERWISE                     
               END CASE

            END IF
          
         
            #end add-point
          
                  #此段落由子樣板a01產生
         BEFORE FIELD sfjcseq1
            #add-point:BEFORE FIELD sfjcseq1

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD sfjcseq1
            
            #add-point:AFTER FIELD sfjcseq1
            IF  g_sfjb_d[g_detail_idx].sfjbdocno IS NOT NULL AND g_sfjb_d[g_detail_idx].sfjbseq IS NOT NULL AND g_sfjb2_d[l_ac].sfjcseq1 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_sfjb2_d_t.sfjcseq1 IS NULL OR g_sfjb2_d[l_ac].sfjcseq1 != g_sfjb2_d_t.sfjcseq1)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM sfjc_t WHERE "||"sfjcent = '" ||g_enterprise|| "' AND "||"sfjcdocno = '"||g_sfjb_d[g_detail_idx].sfjbdocno ||"' AND "|| "sfjcseq = '"||g_sfjb_d[g_detail_idx].sfjbseq ||"' AND "||"sfjcseq1 ='"||g_sfjb2_d[l_ac].sfjcseq1||"'",'std-00004',0) THEN 
                     LET g_sfjb2_d[l_ac].sfjcseq1 = g_sfjb2_d_t.sfjcseq1      
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

            IF g_sfjb2_d[l_ac].sfjcseq1 IS NULL OR g_sfjb2_d[l_ac].sfjcseq1 = 0 THEN
               SELECT MAX(sfjcseq1)+1 INTO g_sfjb2_d[l_ac].sfjcseq1
                 FROM sfjc_t
                WHERE sfjcent   = g_enterprise 
                  AND sfjcdocno = g_sfjb_d[g_detail_idx].sfjbdocno
                  AND sfjcseq   = g_sfjb_d[g_detail_idx].sfjbseq

            END IF
            IF g_sfjb2_d[l_ac].sfjcseq1 IS NULL THEN
               LET g_sfjb2_d[l_ac].sfjcseq1 = 1
            END IF
            
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE sfjcseq1
            #add-point:ON CHANGE sfjcseq1
 
            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD sfjc010
            #add-point:BEFORE FIELD sfjc010
            CALL asrt339_02_set_entry_b(l_cmd)
            CALL asrt339_02_set_no_required_b() 
            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD sfjc010
            
            #add-point:AFTER FIELD sfjc010
            CALL asrt339_02_set_no_entry_b(l_cmd)
            CALL asrt339_02_set_required_b() 
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE sfjc010
            #add-point:ON CHANGE sfjc010

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD sfjc006
            #此段落由子樣板a15產生
            IF NOT cl_ap_chk_Range(g_sfjb2_d[l_ac].sfjc006,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD sfjc006
            END IF
 
 
            #add-point:AFTER FIELD sfjc006
            IF NOT cl_null(g_sfjb2_d[l_ac].sfjc006) THEN 
               IF l_cmd = 'a' OR (l_cmd ='u' AND (g_sfjb2_d_t.sfjc006 IS NULL OR g_sfjb2_d[l_ac].sfjc006 != g_sfjb2_d_t.sfjc006)) THEN
                  SELECT SUM(sfjc006) INTO l_sfjc006_sum FROM sfjc_t
                   WHERE sfjcent  = g_enterprise
                     AND sfjcdocno = g_sfjb_d[g_detail_idx].sfjbdocno
                     AND sfjcseq   = g_sfjb_d[g_detail_idx].sfjbseq

                  LET l_sfjc006_t = g_sfjb2_d_t.sfjc006
                  IF l_sfjc006_t IS NULL THEN LET l_sfjc006_t = 0 END IF
                  IF l_sfjc006_sum IS NULL THEN LET l_sfjc006_sum = 0 END IF 
                  IF l_sfjc006_sum - l_sfjc006_t + g_sfjb2_d[l_ac].sfjc006 > g_sfjb_d[g_detail_idx].sfjb006 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'asf-00358'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_sfjb2_d[l_ac].sfjc006 = g_sfjb2_d_t.sfjc006
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 


            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD sfjc006
            #add-point:BEFORE FIELD sfjc006

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE sfjc006
            #add-point:ON CHANGE sfjc006

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD sfjc008
            #add-point:BEFORE FIELD sfjc008

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD sfjc008
            
            #add-point:AFTER FIELD sfjc008
            IF NOT cl_null(g_sfjb2_d[l_ac].sfjc008) THEN 
               IF l_cmd = 'a' OR (l_cmd ='u' AND (g_sfjb2_d_t.sfjc008 IS NULL OR g_sfjb2_d[l_ac].sfjc008 != g_sfjb2_d_t.sfjc008)) THEN
                  SELECT SUM(sfjc008) INTO l_sfjc008_sum FROM sfjc_t
                   WHERE sfjcent  = g_enterprise
                     AND sfjcdocno = g_sfjb_d[g_detail_idx].sfjbdocno
                     AND sfjcseq   = g_sfjb_d[g_detail_idx].sfjbseq

                  LET l_sfjc008_t = g_sfjb2_d_t.sfjc008
                  IF l_sfjc008_t IS NULL THEN LET l_sfjc008_t = 0 END IF
                  IF l_sfjc008_sum IS NULL THEN LET l_sfjc008_sum = 0 END IF 
                  IF l_sfjc008_sum - l_sfjc008_t + g_sfjb2_d[l_ac].sfjc008 > g_sfjb_d[g_detail_idx].sfjb008 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'asf-00358'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET g_sfjb2_d[l_ac].sfjc008 = g_sfjb2_d_t.sfjc008
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE sfjc008
            #add-point:ON CHANGE sfjc008

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD sfjc009
            
            #add-point:AFTER FIELD sfjc009
            IF l_cmd ='a' OR (l_cmd = 'u' AND (g_sfjb2_d_t.sfjc009 IS NULL OR g_sfjb2_d[l_ac].sfjc009 <> g_sfjb2_d_t.sfjc009)) THEN
               INITIALIZE g_chkparam.* TO NULL
               #設定g_chkparam.*的參數
               LET g_chkparam.arg1 = '227'
               LET g_chkparam.arg2 = g_sfjb2_d[l_ac].sfjc009
               
               #160318-00025#41  2016/04/25  by pengxin  add(S)
               LET g_errshow = TRUE #是否開窗 
               LET g_chkparam.err_str[1] = "aqc-00032:sub-01302|aqci030|",cl_get_progname("aqci030",g_lang,"2"),"|:EXEPROGaqci030"
               #160318-00025#41  2016/04/25  by pengxin  add(E)
               #呼叫檢查存在並帶值的library
               IF cl_chk_exist("v_oocq002_1") THEN
               #檢查成功時後續處理
               #LET  = g_chkparam.return1
               #DISPLAY BY NAME 
               
               ELSE
               #檢查失敗時後續處理
                  LET g_sfjb2_d[l_ac].sfjc009 = g_sfjb2_d_t.sfjc009
                  NEXT FIELD sfjc009
               END IF
            END IF

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_sfjb2_d[l_ac].sfjc009
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='227' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_sfjb2_d[l_ac].sfjc009_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_sfjb2_d[l_ac].sfjc009_desc
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD sfjc009
            #add-point:BEFORE FIELD sfjc009

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE sfjc009
            #add-point:ON CHANGE sfjc009

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD sfjc011
            
            #add-point:AFTER FIELD sfjc011
            IF NOT cl_null(g_sfjb2_d[l_ac].sfjc011) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_sfjb2_d_t.sfjc011 IS NULL OR g_sfjb2_d[l_ac].sfjc011 <> g_sfjb2_d_t.sfjc011)) THEN
                  IF NOT s_asft337_warehouse_chk(g_sfjb_d[g_detail_idx].sfjbdocno,g_sfjb2_d[l_ac].sfjc011,g_sfjb2_d[l_ac].sfjc012) THEN
                     LET g_sfjb2_d[l_ac].sfjc011 = g_sfjb2_d_t.sfjc011
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_stock_desc(g_site,g_sfjb2_d[l_ac].sfjc011)
            RETURNING g_sfjb2_d[l_ac].sfjc011_desc
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD sfjc011
            #add-point:BEFORE FIELD sfjc011

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE sfjc011
            #add-point:ON CHANGE sfjc011

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD sfjc012
            
            #add-point:AFTER FIELD sfjc012
            IF NOT cl_null(g_sfjb2_d[l_ac].sfjc012) THEN
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_sfjb2_d_t.sfjc012 IS NULL OR g_sfjb2_d[l_ac].sfjc012 <> g_sfjb2_d_t.sfjc012)) THEN
                  IF NOT s_asft337_warehouse_chk(g_sfjb_d[g_detail_idx].sfjbdocno,g_sfjb2_d[l_ac].sfjc011,g_sfjb2_d[l_ac].sfjc012) THEN
                     LET g_sfjb2_d[l_ac].sfjc012 = g_sfjb2_d_t.sfjc012
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_get_locator_desc(g_site,g_sfjb_d[l_ac].sfjb011,g_sfjb_d[l_ac].sfjb012)
            RETURNING g_sfjb_d[l_ac].sfjb012_desc
            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD sfjc012
            #add-point:BEFORE FIELD sfjc012

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE sfjc012
            #add-point:ON CHANGE sfjc012

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD sfjc013
            #add-point:BEFORE FIELD sfjc013

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD sfjc013
            
            #add-point:AFTER FIELD sfjc013

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE sfjc013
            #add-point:ON CHANGE sfjc013

            #END add-point
 
         #此段落由子樣板a01產生
         BEFORE FIELD sfjc014
            #add-point:BEFORE FIELD sfjc014

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD sfjc014
            
            #add-point:AFTER FIELD sfjc014

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE sfjc014
            #add-point:ON CHANGE sfjc014

            #END add-point
 
 
                  #Ctrlp:input.c.page2.sfjcseq1
         ON ACTION controlp INFIELD sfjcseq1
            #add-point:ON ACTION controlp INFIELD sfjcseq1

            #END add-point
 
         #Ctrlp:input.c.page2.sfjc010
         ON ACTION controlp INFIELD sfjc010
            #add-point:ON ACTION controlp INFIELD sfjc010

            #END add-point
 
         #Ctrlp:input.c.page2.sfjc006
         ON ACTION controlp INFIELD sfjc006
            #add-point:ON ACTION controlp INFIELD sfjc006

            #END add-point
 
         #Ctrlp:input.c.page2.sfjc008
         ON ACTION controlp INFIELD sfjc008
            #add-point:ON ACTION controlp INFIELD sfjc008

            #END add-point
 
         #Ctrlp:input.c.page2.sfjc009
         ON ACTION controlp INFIELD sfjc009
            #add-point:ON ACTION controlp INFIELD sfjc009
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_sfjb2_d[l_ac].sfjc009             #給予default值

            #給予arg
            LET g_qryparam.arg1 = '227'
            CALL q_oocq002()

            LET g_sfjb2_d[l_ac].sfjc009 = g_qryparam.return1              #將開窗取得的值回傳到變數

            NEXT FIELD sfjc009                                           #返回原欄位
            #END add-point
 
         #Ctrlp:input.c.page2.sfjc011
         ON ACTION controlp INFIELD sfjc011
            #add-point:ON ACTION controlp INFIELD sfjc011
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_sfjb2_d[l_ac].sfjc011       #給予default值

            #給予arg

            CALL q_inaa001_2()

            LET g_sfjb2_d[l_ac].sfjc011 = g_qryparam.return1        #將開窗取得的值回傳到變數

            DISPLAY g_sfjb2_d[l_ac].sfjc011 TO sfjc011              #顯示到畫面上

            NEXT FIELD sfjc011                                     #返回原欄位
            #END add-point
 
         #Ctrlp:input.c.page2.sfjc012
         ON ACTION controlp INFIELD sfjc012
            #add-point:ON ACTION controlp INFIELD sfjc012
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_sfjb2_d[l_ac].sfjc012                #給予default值
            
            SELECT inaa007 INTO l_inaa007 FROM inaa_t WHERE inaaent = g_enterprise AND inaasite = g_site AND inaa001 = g_sfjb2_d[l_ac].sfjc011
       
            #輸入的庫位在[T:庫位基本資料檔].[C:儲位管理]='1',則輸入的庫位+儲位必須存在[T:儲位基本資料檔]中 
            IF l_inaa007 = '1' THEN
               LET g_qryparam.where = " inab001 = '",g_sfjb2_d[l_ac].sfjc011,"' "
               CALL q_inab002()
               LET g_sfjb2_d[l_ac].sfjc012 = g_qryparam.return1              #將開窗取得的值回傳到變數
            END IF
            
            #輸入的庫位在[T:庫位基本資料檔].[C:儲位管理]='3'(依供應商編號)
            #則輸入的儲位編號必須存在[T:交易對象主檔]中，且[T:交易對象主檔].[C:交易對象類型]='1' or '3' 
            IF l_inaa007 = '3' THEN
               LET g_qryparam.where = " (pmaa002 = '1' OR pmaa002 ='3') "
               CALL q_pmaa001()
               LET g_sfjb2_d[l_ac].sfjc012 = g_qryparam.return1              #將開窗取得的值回傳到變數
            END IF
            
            #輸入的庫位在[T:庫位基本資料檔].[C:儲位管理]='4'(依客戶編號)
            #則輸入的儲位編號必須存在[T:交易對象主檔]中，且[T:交易對象主檔].[C:交易對象類型]='2' or '3'
            IF l_inaa007 = '4' THEN
               LET g_qryparam.where = " (pmaa002 = '2' OR pmaa002 ='3') "
               CALL q_pmaa001()
               LET g_sfjb2_d[l_ac].sfjc012 = g_qryparam.return1              #將開窗取得的值回傳到變數
            END IF 
            #END add-point
 
         #Ctrlp:input.c.page2.sfjc013
         ON ACTION controlp INFIELD sfjc013
            #add-point:ON ACTION controlp INFIELD sfjc013

            #END add-point
 
         #Ctrlp:input.c.page2.sfjc014
         ON ACTION controlp INFIELD sfjc014
            #add-point:ON ACTION controlp INFIELD sfjc014

            #END add-point
 
 
 
         #自訂ACTION
         #add-point:單身其他段落處理(EX:on row change, etc...)
         AFTER ROW 
            CLOSE asrt339_02_bcl
            CLOSE asrt339_02_bcl2
            CALL s_transaction_end('Y','0')
         #end add-point
 
         AFTER INPUT
            #add-point:單身輸入後處理
#单身总数量要和第一单身匹配
            SELECT SUM(sfjc006) INTO l_sfjc006_sum FROM sfjc_t
             WHERE sfjcent  = g_enterprise
               AND sfjcdocno = g_sfjb_d[g_detail_idx].sfjbdocno
               AND sfjcseq   = g_sfjb_d[g_detail_idx].sfjbseq
            
            IF l_sfjc006_sum IS NULL THEN LET l_sfjc006_sum = 0 END IF 
            IF l_sfjc006_sum  <> g_sfjb_d[g_detail_idx].sfjb006 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'asf-00359'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               NEXT FIELD sfjc006
            END IF
            
            SELECT SUM(sfjc008) INTO l_sfjc008_sum FROM sfjc_t
             WHERE sfjcent  = g_enterprise
               AND sfjcdocno = g_sfjb_d[g_detail_idx].sfjbdocno
               AND sfjcseq   = g_sfjb_d[g_detail_idx].sfjbseq
            
            IF l_sfjc008_sum IS NULL THEN LET l_sfjc008_sum = 0 END IF 
            IF l_sfjc008_sum  <> g_sfjb_d[g_detail_idx].sfjb008 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'asf-00359'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               NEXT FIELD sfjc008
            END IF
            
            #end add-point
            
      END INPUT
 
      
      #add-point:自定義input

      #end add-point
    
      #公用action
      ON ACTION accept
         ACCEPT DIALOG
        
      ON ACTION cancel
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION close
         LET INT_FLAG = TRUE 
         EXIT DIALOG
 
      ON ACTION exit
         LET INT_FLAG = TRUE 
         EXIT DIALOG
   
      #交談指令共用ACTION
      &include "common_action.4gl" 
         CONTINUE DIALOG 
   END DIALOG
 
   #add-point:畫面關閉前

   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_asrt339_02 
   
   #add-point:input段after input 

   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="asrt339_02.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="asrt339_02.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 第一单身填充
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION asrt339_02_b1_fill()
   DEFINE g_cnt     LIKE type_t.num5
   DEFINE l_sfjb002 LIKE sfjb_t.sfjb002
   DEFINE l_sfjb003 LIKE sfjb_t.sfjb003
   DEFINE l_sfjb004 LIKE sfjb_t.sfjb004
   DEFINE l_sfjb005 LIKE sfjb_t.sfjb005
   DEFINE l_sfjb007 LIKE sfjb_t.sfjb007
   DEFINE l_sfjb015 LIKE sfjb_t.sfjb015
   
   CALL g_sfjb_d.clear()

   LET g_sql = "SELECT  UNIQUE sfjbdocno,sfjbseq,sfjb019,sfjb016,sfjb017,sfjb018,sfjb003,sfjb004,sfjb005,sfjb006,sfjb007, ", 
               "               sfjb008,sfjb009,sfjb010,sfjb011,sfjb012,sfjb013,sfjb014 FROM sfjb_t",              
               " INNER JOIN sfja_t ON sfjadocno = sfjbdocno ",
               " WHERE sfjbent=? AND sfjbdocno=? ",
               " ORDER BY sfjb_t.sfjbseq"
   LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料

   PREPARE asrt339_02_pb1 FROM g_sql
   DECLARE asrt339_02_cs1 CURSOR FOR asrt339_02_pb1

   LET g_cnt = 1
   
   OPEN asrt339_02_cs1 USING g_enterprise,g_sfjadocno
                                            
   FOREACH asrt339_02_cs1 INTO g_sfjb_d[g_cnt].sfjbdocno,g_sfjb_d[g_cnt].sfjbseq,g_sfjb_d[g_cnt].sfjb019,g_sfjb_d[g_cnt].sfjb016,g_sfjb_d[g_cnt].sfjb017,g_sfjb_d[g_cnt].sfjb018, 
       g_sfjb_d[g_cnt].sfjb003,g_sfjb_d[g_cnt].sfjb004,g_sfjb_d[g_cnt].sfjb005,g_sfjb_d[g_cnt].sfjb006, 
       g_sfjb_d[g_cnt].sfjb007,g_sfjb_d[g_cnt].sfjb008,g_sfjb_d[g_cnt].sfjb009,g_sfjb_d[g_cnt].sfjb010, 
       g_sfjb_d[g_cnt].sfjb011,g_sfjb_d[g_cnt].sfjb012,g_sfjb_d[g_cnt].sfjb013,g_sfjb_d[g_cnt].sfjb014
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
     
#      CALL s_asft339_default_sfjb001(g_sfjb_d[g_cnt].sfjb001,g_sfjb_d[g_cnt].sfjb002,g_sfjb_d[g_cnt].sfjb015)
#      RETURNING l_sfjb002,l_sfjb015,l_sfjb003,l_sfjb004,l_sfjb005,
#                g_sfjb_d[g_cnt].sfba013,g_sfjb_d[g_cnt].sfba016,g_sfjb_d[g_cnt].sfba025,g_sfjb_d[g_cnt].sfba017,l_sfjb007
      CALL s_desc_get_item_desc(g_sfjb_d[g_cnt].sfjb003)
      RETURNING g_sfjb_d[g_cnt].sfjb003_desc,g_sfjb_d[g_cnt].sfjb003_desc_1
      CALL s_desc_get_unit_desc(g_sfjb_d[g_cnt].sfjb005)
      RETURNING g_sfjb_d[g_cnt].sfjb005_desc  
      CALL s_desc_get_unit_desc(g_sfjb_d[g_cnt].sfjb007)
      RETURNING g_sfjb_d[g_cnt].sfjb007_desc

      CALL s_desc_get_stock_desc(g_site,g_sfjb_d[g_cnt].sfjb011)
      RETURNING g_sfjb_d[g_cnt].sfjb011_desc
                        
      CALL s_desc_get_locator_desc(g_site,g_sfjb_d[g_cnt].sfjb011,g_sfjb_d[g_cnt].sfjb012)
      RETURNING g_sfjb_d[g_cnt].sfjb012_desc
      
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_sfjb_d[g_cnt].sfjb009
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='227' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_sfjb_d[g_cnt].sfjb009_desc = '', g_rtn_fields[1] , ''
      DISPLAY BY NAME g_sfjb_d[g_cnt].sfjb009_desc
   
      LET g_cnt = g_cnt + 1
      IF g_cnt > g_max_rec THEN
         IF g_error_show = 1 THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ''
            LET g_errparam.popup = TRUE
            CALL cl_err()

         END IF
         EXIT FOREACH
      END IF
      
   END FOREACH
   
   CALL g_sfjb_d.deleteElement(g_sfjb_d.getLength())
   CLOSE asrt339_02_cs1
   FREE asrt339_02_cs1
END FUNCTION

################################################################################
# Descriptions...: 第二单身填充
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION asrt339_02_b2_fill()
   DEFINE g_cnt     LIKE type_t.num5

   
   CALL g_sfjb2_d.clear()
   
      LET g_sql = "SELECT  UNIQUE sfjcseq1,sfjc010,sfjc006,sfjc008,sfjc009,sfjc011,sfjc012,sfjc013,sfjc014 FROM sfjc_t ",   
                  " INNER JOIN sfja_t ON sfjadocno = sfjcdocno ",
                  " WHERE sfjcent=? AND sfjcdocno=? AND sfjcseq = ?",
                  " ORDER BY sfjc_t.sfjcseq1"  
      LET g_sql = cl_sql_add_mask(g_sql)              #遮蔽特定資料

      PREPARE asrt339_02_pb2 FROM g_sql
      DECLARE asrt339_02_cs2 CURSOR FOR asrt339_02_pb2
      
      LET g_cnt = 1
      
      OPEN asrt339_02_cs2 USING g_enterprise,g_sfjadocno,g_sfjb_d[g_detail_idx].sfjbseq
                                               
      FOREACH asrt339_02_cs2 INTO g_sfjb2_d[g_cnt].sfjcseq1,g_sfjb2_d[g_cnt].sfjc010,g_sfjb2_d[g_cnt].sfjc006,
          g_sfjb2_d[g_cnt].sfjc008,g_sfjb2_d[g_cnt].sfjc009,g_sfjb2_d[g_cnt].sfjc011,g_sfjb2_d[g_cnt].sfjc012, 
          g_sfjb2_d[g_cnt].sfjc013,g_sfjb2_d[g_cnt].sfjc014
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "FOREACH:"
            LET g_errparam.popup = TRUE
            CALL cl_err()

            EXIT FOREACH
         END IF
        
            CALL s_desc_get_stock_desc(g_site,g_sfjb2_d[g_cnt].sfjc011)
            RETURNING g_sfjb2_d[g_cnt].sfjc011_desc
                              
            CALL s_desc_get_locator_desc(g_site,g_sfjb2_d[g_cnt].sfjc011,g_sfjb2_d[g_cnt].sfjc012)
            RETURNING g_sfjb2_d[g_cnt].sfjc012_desc
            
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_sfjb2_d[g_cnt].sfjc009
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='227' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_sfjb2_d[g_cnt].sfjc009_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_sfjb2_d[g_cnt].sfjc009_desc
      
         LET g_cnt = g_cnt + 1
         IF g_cnt > g_max_rec THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code =  9035
            LET g_errparam.extend =  ''
            LET g_errparam.popup = FALSE
            CALL cl_err()

            EXIT FOREACH
         END IF
         
      END FOREACH
      
   CALL g_sfjb2_d.deleteElement(g_sfjb2_d.getLength())
   CLOSE asrt339_02_cs2
   FREE asrt339_02_cs2
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION asrt339_02_set_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   

   CALL cl_set_comp_entry("sfjc007,sfjc008,sfjc011,sfjc012,sfjc013,sfjc014",TRUE) 
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION asrt339_02_set_no_entry_b(p_cmd)
   DEFINE p_cmd   LIKE type_t.chr1   

   IF cl_get_para(g_enterprise,g_site,'S-BAS-0028')  = 'N' THEN
      CALL cl_set_comp_entry("sfjc007,sfjc008",FALSE)   
   END IF
   IF g_sfjb2_d[l_ac].sfjc010 MATCHES '[14]' THEN
      CALL cl_set_comp_entry("sfjc011,sfjc012,sfjc013,sfjc014",FALSE)
   END IF
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION asrt339_02_set_required_b()
   IF cl_get_para(g_enterprise,g_site,'S-BAS-0028')  = 'Y' THEN
      CALL cl_set_comp_required("sfjc007,sfjc008",TRUE)   
   END IF
   IF l_ac > 0 THEN
      IF g_sfjb2_d[l_ac].sfjc010 = '2' OR g_sfjb2_d[l_ac].sfjc010 = '3' THEN
         CALL cl_set_comp_required("sfjc011",TRUE)
      END IF
   END IF
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL s_aooi150_ins (传入参数)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION asrt339_02_set_no_required_b()
   CALL cl_set_comp_required("sfjc007,sfjc008,sfjc011",FALSE) 
END FUNCTION

 
{</section>}
 
