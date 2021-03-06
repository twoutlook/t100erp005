#該程式未解開Section, 採用最新樣板產出!
{<section id="apmt100_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2014-10-27 11:47:06), PR版次:0006(2017-01-19 09:36:55)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000147
#+ Filename...: apmt100_02
#+ Description: 交易對象往來銀行申請作業
#+ Creator....: 02294(2013-10-21 16:20:04)
#+ Modifier...: 02294 -SD/PR- 06137
 
{</section>}
 
{<section id="apmt100_02.global" >}
#應用 c02b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160318-00005#36    2016/03/28 By 07900         重复错误信息修改
#end add-point
#add-point:填寫註解說明(客製用) name="global.memo_customerization"

#end add-point
 
IMPORT os
IMPORT FGL lib_cl_dlg
#add-point:增加匯入項目 name="global.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
#add-point:增加匯入變數檔 name="global.inc"
GLOBALS "../../apm/4gl/apmt100_02.inc"
#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_pmbf_d        RECORD
       pmbfstus LIKE pmbf_t.pmbfstus, 
   pmbfdocno LIKE pmbf_t.pmbfdocno, 
   pmbf001 LIKE pmbf_t.pmbf001, 
   pmbf002 LIKE pmbf_t.pmbf002, 
   pmbf002_desc LIKE type_t.chr500, 
   pmbf003 LIKE pmbf_t.pmbf003, 
   pmbf004 LIKE pmbf_t.pmbf004, 
   pmbf008 LIKE pmbf_t.pmbf008, 
   pmbf009 LIKE pmbf_t.pmbf009, 
   pmbf005 LIKE pmbf_t.pmbf005, 
   pmbf007 LIKE pmbf_t.pmbf007, 
   pmbf006 LIKE pmbf_t.pmbf006
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 
#end add-point
 
DEFINE g_pmbf_d          DYNAMIC ARRAY OF type_g_pmbf_d
DEFINE g_pmbf_d_t        type_g_pmbf_d
 
 
DEFINE g_pmbfdocno_t   LIKE pmbf_t.pmbfdocno    #Key值備份
DEFINE g_pmbf002_t      LIKE pmbf_t.pmbf002    #Key值備份
DEFINE g_pmbf003_t      LIKE pmbf_t.pmbf003    #Key值備份
 
 
DEFINE l_ac                  LIKE type_t.num10
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rec_b               LIKE type_t.num10 
DEFINE g_detail_idx          LIKE type_t.num10
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
    
#add-point:傳入參數說明(global.argv) name="global.argv"
GLOBALS   
   DEFINE g_pmba4_d          DYNAMIC ARRAY OF type_g_pmbf_d
END GLOBALS   
#end add-point    
 
{</section>}
 
{<section id="apmt100_02.input" >}
#+ 資料輸入
PUBLIC FUNCTION apmt100_02(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_pmbadocno,p_pmba001
   #end add-point
   )
   #add-point:input段define name="input.define_customerization"
   
   #end add-point
   DEFINE l_ac_t          LIKE type_t.num10       #未取消的ARRAY CNT 
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num10
   DEFINE l_insert        LIKE type_t.num5
   DEFINE l_cmd           LIKE type_t.chr5
   #add-point:input段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   DEFINE p_pmbadocno     LIKE pmba_t.pmbadocno
   DEFINE p_pmba001       LIKE pmba_t.pmba001
   DEFINE l_lock_sw       LIKE type_t.chr1
   DEFINE l_forupd_sql    STRING
   DEFINE l_n             LIKE type_t.num5                #檢查重複用  
   DEFINE l_cnt           LIKE type_t.num5
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_apmt100_02 WITH FORM cl_ap_formpath("apm","apmt100_02")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #輸入前處理
   #add-point:單身前置處理 name="input.pre_input"
   WHENEVER ERROR CONTINUE
   #CALL s_transaction_end('N','0')
   
   CALL apmt100_02_b_fill(p_pmbadocno)

   LET l_ac = 1
   LET l_forupd_sql = "SELECT pmbfstus,pmbfdocno,pmbf001,pmbf002,'',pmbf003,pmbf004,pmbf008,pmbf009,pmbf005,pmbf007,pmbf006 FROM pmbf_t WHERE pmbfent = ? AND pmbfdocno = ? AND pmbf002 = ? AND pmbf003 = ? FOR UPDATE"
   LET l_forupd_sql = cl_sql_forupd(l_forupd_sql)
   DECLARE apmt100_02_bcl CURSOR FROM l_forupd_sql
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT ARRAY g_pmbf_d FROM s_detail1_apmt100_02.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = l_allow_insert,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
         
         #自訂ACTION
         #add-point:單身前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(detail_input)
         
         
         BEFORE INPUT
            #add-point:單身輸入前處理 name="input.before_input"
            CALL apmt100_02_b_fill(p_pmbadocno)
            LET g_rec_b = g_pmbf_d.getLength()
            
          BEFORE ROW 
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
   
            LET g_rec_b = g_pmbf_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND NOT cl_null(g_pmbf_d[l_ac].pmbfdocno)
               AND NOT cl_null(g_pmbf_d[l_ac].pmbf002) 
               AND NOT cl_null(g_pmbf_d[l_ac].pmbf003) 
 
 
            THEN
               LET l_cmd='u'
			   LET g_pmbf_d_t.* = g_pmbf_d[l_ac].*  #BACKUP
			   
			   OPEN apmt100_02_bcl USING g_enterprise,p_pmbadocno,g_pmbf_d[l_ac].pmbf002,g_pmbf_d[l_ac].pmbf003
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "apmt100_02_bcl"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET l_lock_sw='Y'
               ELSE
                  FETCH apmt100_02_bcl INTO g_pmbf_d[l_ac].pmbfstus,g_pmbf_d[l_ac].pmbfdocno,g_pmbf_d[l_ac].pmbf001,g_pmbf_d[l_ac].pmbf002,g_pmbf_d[l_ac].pmbf002_desc,g_pmbf_d[l_ac].pmbf003,g_pmbf_d[l_ac].pmbf004,g_pmbf_d[l_ac].pmbf008,g_pmbf_d[l_ac].pmbf009,g_pmbf_d[l_ac].pmbf005,g_pmbf_d[l_ac].pmbf007,g_pmbf_d[l_ac].pmbf006
                 
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = p_pmbadocno
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_lock_sw = "Y"
                  END IF
				  CALL apmt100_02_pmbf002_ref(g_pmbf_d[l_ac].pmbf002) RETURNING g_pmbf_d[l_ac].pmbf002_desc
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
        
         BEFORE INSERT
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_pmbf_d[l_ac].* TO NULL 
            
            LET g_pmbf_d[l_ac].pmbfdocno = p_pmbadocno
            LET g_pmbf_d[l_ac].pmbf001 = p_pmba001
            LET g_pmbf_d[l_ac].pmbfstus = 'Y'
            LET g_pmbf_d[l_ac].pmbf008 = 'N'
            LET g_pmbf_d[l_ac].pmbf009 = 'N'
            
            LET g_pmbf_d_t.* = g_pmbf_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            
            
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM pmbf_t 
             WHERE pmbfent = g_enterprise AND pmbfdocno = g_pmbf_d[l_ac].pmbfdocno
               AND pmbf002 = g_pmbf_d[l_ac].pmbf002
               AND pmbf003 = g_pmbf_d[l_ac].pmbf003
      
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               INSERT INTO pmbf_t (pmbfent,pmbfdocno,pmbf001,pmbf002,pmbf003,pmbf004,pmbf005,pmbf006,pmbf007,pmbf008,pmbf009,pmbfstus)
                  VALUES (g_enterprise,g_pmbf_d[l_ac].pmbfdocno,g_pmbf_d[l_ac].pmbf001,g_pmbf_d[l_ac].pmbf002,g_pmbf_d[l_ac].pmbf003,g_pmbf_d[l_ac].pmbf004,g_pmbf_d[l_ac].pmbf005,g_pmbf_d[l_ac].pmbf006,g_pmbf_d[l_ac].pmbf007,g_pmbf_d[l_ac].pmbf008,g_pmbf_d[l_ac].pmbf009,g_pmbf_d[l_ac].pmbfstus)
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_pmbf_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "pmbf_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')                    
               CANCEL INSERT
            ELSE
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
              
         BEFORE DELETE                            #是否取消單身
            IF NOT cl_null(g_pmbf_d[l_ac].pmbfdocno)
               AND NOT cl_null(g_pmbf_d[l_ac].pmbf002) 
               AND NOT cl_null(g_pmbf_d[l_ac].pmbf003) THEN 
               
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

               DELETE FROM pmbf_t
                WHERE pmbfent = g_enterprise AND pmbfdocno = g_pmbf_d_t.pmbfdocno
                  AND pmbf002 = g_pmbf_d_t.pmbf002
                  AND pmbf003 = g_pmbf_d_t.pmbf003

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "pmbf_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE apmt100_02_bcl
               LET l_count = g_pmbf_d.getLength()
            END IF 
            
        ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_pmbf_d[l_ac].* = g_pmbf_d_t.*
               CLOSE apmt100_02_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG
            END IF

            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_pmbf_d[l_ac].pmbf002
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_pmbf_d[l_ac].* = g_pmbf_d_t.*
            ELSE
               UPDATE pmbf_t SET (pmbf002,pmbf003,pmbf004,pmbf005,pmbf006,pmbf007,pmbf008,pmbf009,pmbfstus) = (g_pmbf_d[l_ac].pmbf002,g_pmbf_d[l_ac].pmbf003,g_pmbf_d[l_ac].pmbf004,g_pmbf_d[l_ac].pmbf005,g_pmbf_d[l_ac].pmbf006,g_pmbf_d[l_ac].pmbf007,g_pmbf_d[l_ac].pmbf008,g_pmbf_d[l_ac].pmbf009,g_pmbf_d[l_ac].pmbfstus)
                WHERE pmbfent = g_enterprise 
                  AND pmbfdocno = g_pmbf_d_t.pmbfdocno
                  AND pmbf002 = g_pmbf_d_t.pmbf002
                  AND pmbf003 = g_pmbf_d_t.pmbf003

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "pmbf_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

                  LET g_pmbf_d[l_ac].* = g_pmbf_d_t.*
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
            END IF
            
         AFTER ROW
            CLOSE apmt100_02_bcl
            CALL s_transaction_end('Y','0')
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbfstus
            #add-point:BEFORE FIELD pmbfstus name="input.b.page1_apmt100_02.pmbfstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbfstus
            
            #add-point:AFTER FIELD pmbfstus name="input.a.page1_apmt100_02.pmbfstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbfstus
            #add-point:ON CHANGE pmbfstus name="input.g.page1_apmt100_02.pmbfstus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbfdocno
            #add-point:BEFORE FIELD pmbfdocno name="input.b.page1_apmt100_02.pmbfdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbfdocno
            
            #add-point:AFTER FIELD pmbfdocno name="input.a.page1_apmt100_02.pmbfdocno"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_pmbf_d[g_detail_idx].pmbfdocno IS NOT NULL AND g_pmbf_d[g_detail_idx].pmbf002 IS NOT NULL AND g_pmbf_d[g_detail_idx].pmbf003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pmbf_d[g_detail_idx].pmbfdocno != g_pmbf_d_t.pmbfdocno OR g_pmbf_d[g_detail_idx].pmbf002 != g_pmbf_d_t.pmbf002 OR g_pmbf_d[g_detail_idx].pmbf003 != g_pmbf_d_t.pmbf003)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pmbf_t WHERE "||"pmbfent = '" ||g_enterprise|| "' AND "||"pmbfdocno = '"||g_pmbf_d[g_detail_idx].pmbfdocno ||"' AND "|| "pmbf002 = '"||g_pmbf_d[g_detail_idx].pmbf002 ||"' AND "|| "pmbf003 = '"||g_pmbf_d[g_detail_idx].pmbf003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbfdocno
            #add-point:ON CHANGE pmbfdocno name="input.g.page1_apmt100_02.pmbfdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbf001
            #add-point:BEFORE FIELD pmbf001 name="input.b.page1_apmt100_02.pmbf001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbf001
            
            #add-point:AFTER FIELD pmbf001 name="input.a.page1_apmt100_02.pmbf001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbf001
            #add-point:ON CHANGE pmbf001 name="input.g.page1_apmt100_02.pmbf001"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbf002
            
            #add-point:AFTER FIELD pmbf002 name="input.a.page1_apmt100_02.pmbf002"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_pmbf_d[g_detail_idx].pmbfdocno IS NOT NULL AND g_pmbf_d[g_detail_idx].pmbf002 IS NOT NULL AND g_pmbf_d[g_detail_idx].pmbf003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pmbf_d[g_detail_idx].pmbfdocno != g_pmbf_d_t.pmbfdocno OR g_pmbf_d[g_detail_idx].pmbf002 != g_pmbf_d_t.pmbf002 OR g_pmbf_d[g_detail_idx].pmbf003 != g_pmbf_d_t.pmbf003)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pmbf_t WHERE "||"pmbfent = '" ||g_enterprise|| "' AND "||"pmbfdocno = '"||g_pmbf_d[g_detail_idx].pmbfdocno ||"' AND "|| "pmbf002 = '"||g_pmbf_d[g_detail_idx].pmbf002 ||"' AND "|| "pmbf003 = '"||g_pmbf_d[g_detail_idx].pmbf003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmbf_d[l_ac].pmbf002
            CALL ap_ref_array2(g_ref_fields,"SELECT nmabl003 FROM nmabl_t WHERE nmablent='"||g_enterprise||"' AND nmabl001=? AND nmabl002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pmbf_d[l_ac].pmbf002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmbf_d[l_ac].pmbf002_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbf002
            #add-point:BEFORE FIELD pmbf002 name="input.b.page1_apmt100_02.pmbf002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbf002
            #add-point:ON CHANGE pmbf002 name="input.g.page1_apmt100_02.pmbf002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbf003
            #add-point:BEFORE FIELD pmbf003 name="input.b.page1_apmt100_02.pmbf003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbf003
            
            #add-point:AFTER FIELD pmbf003 name="input.a.page1_apmt100_02.pmbf003"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_pmbf_d[g_detail_idx].pmbfdocno IS NOT NULL AND g_pmbf_d[g_detail_idx].pmbf002 IS NOT NULL AND g_pmbf_d[g_detail_idx].pmbf003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pmbf_d[g_detail_idx].pmbfdocno != g_pmbf_d_t.pmbfdocno OR g_pmbf_d[g_detail_idx].pmbf002 != g_pmbf_d_t.pmbf002 OR g_pmbf_d[g_detail_idx].pmbf003 != g_pmbf_d_t.pmbf003)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pmbf_t WHERE "||"pmbfent = '" ||g_enterprise|| "' AND "||"pmbfdocno = '"||g_pmbf_d[g_detail_idx].pmbfdocno ||"' AND "|| "pmbf002 = '"||g_pmbf_d[g_detail_idx].pmbf002 ||"' AND "|| "pmbf003 = '"||g_pmbf_d[g_detail_idx].pmbf003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbf003
            #add-point:ON CHANGE pmbf003 name="input.g.page1_apmt100_02.pmbf003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbf004
            #add-point:BEFORE FIELD pmbf004 name="input.b.page1_apmt100_02.pmbf004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbf004
            
            #add-point:AFTER FIELD pmbf004 name="input.a.page1_apmt100_02.pmbf004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbf004
            #add-point:ON CHANGE pmbf004 name="input.g.page1_apmt100_02.pmbf004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbf008
            #add-point:BEFORE FIELD pmbf008 name="input.b.page1_apmt100_02.pmbf008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbf008
            
            #add-point:AFTER FIELD pmbf008 name="input.a.page1_apmt100_02.pmbf008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbf008
            #add-point:ON CHANGE pmbf008 name="input.g.page1_apmt100_02.pmbf008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbf009
            #add-point:BEFORE FIELD pmbf009 name="input.b.page1_apmt100_02.pmbf009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbf009
            
            #add-point:AFTER FIELD pmbf009 name="input.a.page1_apmt100_02.pmbf009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbf009
            #add-point:ON CHANGE pmbf009 name="input.g.page1_apmt100_02.pmbf009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbf005
            #add-point:BEFORE FIELD pmbf005 name="input.b.page1_apmt100_02.pmbf005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbf005
            
            #add-point:AFTER FIELD pmbf005 name="input.a.page1_apmt100_02.pmbf005"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbf005
            #add-point:ON CHANGE pmbf005 name="input.g.page1_apmt100_02.pmbf005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbf007
            #add-point:BEFORE FIELD pmbf007 name="input.b.page1_apmt100_02.pmbf007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbf007
            
            #add-point:AFTER FIELD pmbf007 name="input.a.page1_apmt100_02.pmbf007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbf007
            #add-point:ON CHANGE pmbf007 name="input.g.page1_apmt100_02.pmbf007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmbf006
            #add-point:BEFORE FIELD pmbf006 name="input.b.page1_apmt100_02.pmbf006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmbf006
            
            #add-point:AFTER FIELD pmbf006 name="input.a.page1_apmt100_02.pmbf006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmbf006
            #add-point:ON CHANGE pmbf006 name="input.g.page1_apmt100_02.pmbf006"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1_apmt100_02.pmbfstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbfstus
            #add-point:ON ACTION controlp INFIELD pmbfstus name="input.c.page1_apmt100_02.pmbfstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_apmt100_02.pmbfdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbfdocno
            #add-point:ON ACTION controlp INFIELD pmbfdocno name="input.c.page1_apmt100_02.pmbfdocno"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_apmt100_02.pmbf001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbf001
            #add-point:ON ACTION controlp INFIELD pmbf001 name="input.c.page1_apmt100_02.pmbf001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_apmt100_02.pmbf002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbf002
            #add-point:ON ACTION controlp INFIELD pmbf002 name="input.c.page1_apmt100_02.pmbf002"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmbf_d[l_ac].pmbf002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_nmab001()                                #呼叫開窗

            LET g_pmbf_d[l_ac].pmbf002 = g_qryparam.return1              

            DISPLAY g_pmbf_d[l_ac].pmbf002 TO pmbf002              #

            NEXT FIELD pmbf002                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1_apmt100_02.pmbf003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbf003
            #add-point:ON ACTION controlp INFIELD pmbf003 name="input.c.page1_apmt100_02.pmbf003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_apmt100_02.pmbf004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbf004
            #add-point:ON ACTION controlp INFIELD pmbf004 name="input.c.page1_apmt100_02.pmbf004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_apmt100_02.pmbf008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbf008
            #add-point:ON ACTION controlp INFIELD pmbf008 name="input.c.page1_apmt100_02.pmbf008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_apmt100_02.pmbf009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbf009
            #add-point:ON ACTION controlp INFIELD pmbf009 name="input.c.page1_apmt100_02.pmbf009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_apmt100_02.pmbf005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbf005
            #add-point:ON ACTION controlp INFIELD pmbf005 name="input.c.page1_apmt100_02.pmbf005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_apmt100_02.pmbf007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbf007
            #add-point:ON ACTION controlp INFIELD pmbf007 name="input.c.page1_apmt100_02.pmbf007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_apmt100_02.pmbf006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmbf006
            #add-point:ON ACTION controlp INFIELD pmbf006 name="input.c.page1_apmt100_02.pmbf006"
            
            #END add-point
 
 
 
 
         #自訂ACTION
         #add-point:單身其他段落處理(EX:on row change, etc...) name="input.other"
         
         #end add-point
 
         AFTER INPUT
            #add-point:單身輸入後處理 name="input.after_input"
            
            #end add-point
            
      END INPUT
      
 
      
      #add-point:自定義input name="input.more_input"
      
      #end add-point
    
      #公用action
      ON ACTION accept
         ACCEPT DIALOG
        
      ON ACTION cancel
         #add-point:cancel name="input.cancel"
         
         #end add-point
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
 
   #add-point:畫面關閉前 name="input.before_close"
   LET INT_FLAG = FALSE
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_apmt100_02 
   
   #add-point:input段after input name="input.post_input"
   CALL s_transaction_begin()
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="apmt100_02.other_dialog" readonly="Y" >}
################################################################################
# Descriptions...: 被主程式嵌入的單身顯示模式
# Memo...........: 
# Usage..........: apmt100_02_display()
# Input parameter: None
# Return code....: None
# Date & Author..: 2014/09/23 By lixiang
# Modify.........:
################################################################################
DIALOG apmt100_02_display()
   
   DISPLAY ARRAY g_pmbf_d TO s_detail1_apmt100_02.* ATTRIBUTE(COUNT=g_d_cnt_t10002)

      BEFORE DISPLAY
         CALL FGL_SET_ARR_CURR(g_d_idx_t10002)
         #單身不連動, 所以進入單身時, 要重新顯示單身筆數
         DISPLAY g_d_idx_t10002, g_d_cnt_t10002 TO FORMONLY.idx, FORMONLY.cnt

      BEFORE ROW
         LET g_d_idx_t10002 = DIALOG.getCurrentRow("s_detail1_apmt100_02")
         DISPLAY g_d_idx_t10002 TO FORMONLY.idx
         # 點的當筆放入g_appoint_idx中, 可讓雙擊直接進入指定筆
         LET g_appoint_idx = g_d_idx_t10002

   END DISPLAY
   
END DIALOG
################################################################################
# Descriptions...: 被主程式嵌入的單身查詢模式
# Memo...........: 
# Usage..........: CALL apmt100_02_construct()
# Input parameter: None
# Return code....: None
# Date & Author..: 2014/09/24 By lixiang
# Modify.........:
################################################################################
DIALOG apmt100_02_construct()

   CONSTRUCT g_wc2_t10002 ON pmbfstus,pmbf001,pmbf002,pmbf003,pmbf004,pmbf008,pmbf009,pmbf005,pmbf007,pmbf006
        FROM s_detail1_apmt100_02[1].pmbfstus,s_detail1_apmt100_02[1].pmbf001,
             s_detail1_apmt100_02[1].pmbf002,s_detail1_apmt100_02[1].pmbf003,
             s_detail1_apmt100_02[1].pmbf004,s_detail1_apmt100_02[1].pmbf008,
             s_detail1_apmt100_02[1].pmbf009,s_detail1_apmt100_02[1].pmbf005,
             s_detail1_apmt100_02[1].pmbf007,s_detail1_apmt100_02[1].pmbf006

         ON ACTION controlp INFIELD pmbf002
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_nmab001()                                #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmbf002             #顯示到畫面上
            NEXT FIELD pmbf002                        #返回原欄位      
            
   END CONSTRUCT
   
END DIALOG
################################################################################
# Descriptions...: 被主程式嵌入的單身輸入模式
# Memo...........: 
# Usage..........: CALL apmt100_02_input()
# Input parameter: None
# Return code....: None
# Date & Author..: 2014/09/24 By lixiang
# Modify.........:
#############################################################################################################################################
DIALOG apmt100_02_input()
   DEFINE l_ac_t          LIKE type_t.num5        #未取消的ARRAY CNT   
   DEFINE l_count         LIKE type_t.num5
   DEFINE l_insert        LIKE type_t.num5
   DEFINE l_cmd           LIKE type_t.chr5
   DEFINE l_lock_sw       LIKE type_t.chr1
   DEFINE l_forupd_sql    STRING
   DEFINE l_n             LIKE type_t.num5                #檢查重複用  
   DEFINE l_cnt           LIKE type_t.num5
   
   
   
   INPUT ARRAY g_pmbf_d FROM s_detail1_apmt100_02.*
          ATTRIBUTE(COUNT = g_d_cnt_t10002,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = FALSE,
                  DELETE ROW = g_detail_delete,
                  APPEND ROW = g_detail_insert)

         BEFORE INPUT
            LET l_forupd_sql = "SELECT pmbfstus,pmbfdocno,pmbf001,pmbf002,'',pmbf003,pmbf004,pmbf008,pmbf009,pmbf005,pmbf007,pmbf006 FROM pmbf_t WHERE pmbfent = ? AND pmbfdocno = ? AND pmbf002 = ? AND pmbf003 = ? FOR UPDATE"
            LET l_forupd_sql = cl_sql_forupd(l_forupd_sql)
            PREPARE apmt100_02_dialog_b FROM l_forupd_sql
            DECLARE apmt100_02_dialog_bcl CURSOR FOR apmt100_02_dialog_b
            IF g_appoint_idx > 0 THEN
               CALL DIALOG.setCurrentRow("s_detail1_apmt100_02",g_appoint_idx)
            END IF
            
         BEFORE ROW 
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
   
            LET g_rec_b = g_pmbf_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND NOT cl_null(g_pmbf_d[l_ac].pmbfdocno)
               AND NOT cl_null(g_pmbf_d[l_ac].pmbf002) 
               AND NOT cl_null(g_pmbf_d[l_ac].pmbf003) 
 
 
            THEN
               LET l_cmd='u'
			      LET g_pmbf_d_t.* = g_pmbf_d[l_ac].*  #BACKUP
			   
			      OPEN apmt100_02_dialog_bcl USING g_enterprise,g_pmbadocno_d,g_pmbf_d[l_ac].pmbf002,g_pmbf_d[l_ac].pmbf003
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "apmt100_02_bcl"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET l_lock_sw='Y'
               ELSE
                  FETCH apmt100_02_dialog_bcl INTO g_pmbf_d[l_ac].pmbfstus,g_pmbf_d[l_ac].pmbfdocno,g_pmbf_d[l_ac].pmbf001,g_pmbf_d[l_ac].pmbf002,g_pmbf_d[l_ac].pmbf002_desc,g_pmbf_d[l_ac].pmbf003,g_pmbf_d[l_ac].pmbf004,g_pmbf_d[l_ac].pmbf008,g_pmbf_d[l_ac].pmbf009,g_pmbf_d[l_ac].pmbf005,g_pmbf_d[l_ac].pmbf007,g_pmbf_d[l_ac].pmbf006
                  
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = g_pmbadocno_d
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_lock_sw = "Y"
                  END IF
				      CALL apmt100_02_pmbf002_ref(g_pmbf_d[l_ac].pmbf002) RETURNING g_pmbf_d[l_ac].pmbf002_desc
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
        
         BEFORE INSERT
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_pmbf_d[l_ac].* TO NULL 
            
            LET g_pmbf_d[l_ac].pmbfdocno = g_pmbadocno_d
            LET g_pmbf_d[l_ac].pmbf001 = g_pmba001_d
            LET g_pmbf_d[l_ac].pmbfstus = 'Y'
            LET g_pmbf_d[l_ac].pmbf008 = 'N'
            LET g_pmbf_d[l_ac].pmbf009 = 'N'
            
            LET g_pmbf_d_t.* = g_pmbf_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()
            
            
         AFTER INSERT
            LET l_insert = FALSE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               #CANCEL INSERT
            END IF
               
            LET l_count = 1  
            SELECT COUNT(*) INTO l_count FROM pmbf_t 
             WHERE pmbfent = g_enterprise AND pmbfdocno = g_pmbf_d[l_ac].pmbfdocno
               AND pmbf002 = g_pmbf_d[l_ac].pmbf002
               AND pmbf003 = g_pmbf_d[l_ac].pmbf003
      
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               INSERT INTO pmbf_t (pmbfent,pmbfdocno,pmbf001,pmbf002,pmbf003,pmbf004,pmbf005,pmbf006,pmbf007,pmbf008,pmbf009,pmbfstus)
                  VALUES (g_enterprise,g_pmbf_d[l_ac].pmbfdocno,g_pmbf_d[l_ac].pmbf001,g_pmbf_d[l_ac].pmbf002,g_pmbf_d[l_ac].pmbf003,g_pmbf_d[l_ac].pmbf004,g_pmbf_d[l_ac].pmbf005,g_pmbf_d[l_ac].pmbf006,g_pmbf_d[l_ac].pmbf007,g_pmbf_d[l_ac].pmbf008,g_pmbf_d[l_ac].pmbf009,g_pmbf_d[l_ac].pmbfstus)
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_pmbf_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               #CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "pmbf_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N','0')                    
               #CANCEL INSERT
            ELSE
               CALL s_transaction_end('Y','0')
               ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
              
         BEFORE DELETE                            #是否取消單身
            IF NOT cl_null(g_pmbf_d[l_ac].pmbfdocno)
               AND NOT cl_null(g_pmbf_d[l_ac].pmbf002) 
               AND NOT cl_null(g_pmbf_d[l_ac].pmbf003) THEN 
               
               IF cl_ask_del_detail() THEN
                  IF l_lock_sw = "Y" THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code =  -263
                     LET g_errparam.extend = ""
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  
                     #CANCEL DELETE
                  END IF
                  
                  DELETE FROM pmbf_t
                    WHERE pmbfent = g_enterprise AND pmbfdocno = g_pmbf_d_t.pmbfdocno
                      AND pmbf002 = g_pmbf_d_t.pmbf002
                      AND pmbf003 = g_pmbf_d_t.pmbf003
                  
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "pmbf_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  
                     CALL s_transaction_end('N','0')
                     #CANCEL DELETE   
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF 
                  CLOSE apmt100_02_dialog_bcl
                  LET l_count = g_pmbf_d.getLength()
               END IF
            END IF 
            
        AFTER DELETE
           CALL apmt100_02_b_fill(g_pmbadocno_d)
            
        ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_pmbf_d[l_ac].* = g_pmbf_d_t.*
               CLOSE apmt100_02_dialog_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG
            END IF

            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_pmbf_d[l_ac].pmbf002
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_pmbf_d[l_ac].* = g_pmbf_d_t.*
            ELSE
               UPDATE pmbf_t SET (pmbf002,pmbf003,pmbf004,pmbf005,pmbf006,pmbf007,pmbf008,pmbf009,pmbfstus) = (g_pmbf_d[l_ac].pmbf002,g_pmbf_d[l_ac].pmbf003,g_pmbf_d[l_ac].pmbf004,g_pmbf_d[l_ac].pmbf005,g_pmbf_d[l_ac].pmbf006,g_pmbf_d[l_ac].pmbf007,g_pmbf_d[l_ac].pmbf008,g_pmbf_d[l_ac].pmbf009,g_pmbf_d[l_ac].pmbfstus)
                WHERE pmbfent = g_enterprise 
                  AND pmbfdocno = g_pmbf_d_t.pmbfdocno
                  AND pmbf002 = g_pmbf_d_t.pmbf002
                  AND pmbf003 = g_pmbf_d_t.pmbf003


               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "pmbf_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_pmbf_d[l_ac].* = g_pmbf_d_t.*
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
            END IF
            
         AFTER ROW
            CLOSE apmt100_02_dialog_bcl
            CALL s_transaction_end('Y','0')


         #此段落由子樣板a02產生
         AFTER FIELD pmbf002
            #確認資料無重複
            CALL apmt100_02_pmbf002_ref(g_pmbf_d[l_ac].pmbf002) RETURNING g_pmbf_d[l_ac].pmbf002_desc
            DISPLAY BY NAME g_pmbf_d[l_ac].pmbf002_desc 
            
            IF  NOT cl_null(g_pmbf_d[l_ac].pmbfdocno) AND NOT cl_null(g_pmbf_d[l_ac].pmbf002) AND NOT cl_null(g_pmbf_d[l_ac].pmbf003) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_pmbf_d[l_ac].pmbfdocno != g_pmbf_d_t.pmbfdocno OR g_pmbf_d[l_ac].pmbf002 != g_pmbf_d_t.pmbf002 OR g_pmbf_d[l_ac].pmbf003 != g_pmbf_d_t.pmbf003))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pmbf_t WHERE "||"pmbfent = '" ||g_enterprise|| "' AND "||"pmbfdocno = '"||g_pmbf_d[l_ac].pmbfdocno ||"' AND "|| "pmbf002 = '"||g_pmbf_d[l_ac].pmbf002 ||"' AND "|| "pmbf003 = '"||g_pmbf_d[l_ac].pmbf003 ||"'",'std-00004',0) THEN 
                     LET g_pmbf_d[l_ac].pmbf002 = g_pmbf_d_t.pmbf002
                     CALL apmt100_02_pmbf002_ref(g_pmbf_d[l_ac].pmbf002) RETURNING g_pmbf_d[l_ac].pmbf002_desc
                     DISPLAY BY NAME g_pmbf_d[l_ac].pmbf002_desc
                     NEXT FIELD CURRENT
                  END IF
                END IF
             END IF
             IF NOT cl_null(g_pmbf_d[l_ac].pmbf002) THEN
                IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pmbf_d[l_ac].pmbf002 != g_pmbf_d_t.pmbf002 OR cl_null(g_pmbf_d_t.pmbf002))) THEN 
                   IF NOT ap_chk_isExist(g_pmbf_d[l_ac].pmbf002,"SELECT COUNT(*) FROM nmab_t WHERE nmabent = '" ||g_enterprise||"' AND nmab001 = ? ","anm-00011",0 ) THEN
                      LET g_pmbf_d[l_ac].pmbf002 = g_pmbf_d_t.pmbf002  
                      CALL apmt100_02_pmbf002_ref(g_pmbf_d[l_ac].pmbf002) RETURNING g_pmbf_d[l_ac].pmbf002_desc
                      DISPLAY BY NAME g_pmbf_d[l_ac].pmbf002_desc
                      NEXT FIELD CURRENT
                   END IF
                   IF NOT ap_chk_isExist(g_pmbf_d[l_ac].pmbf002,"SELECT COUNT(*) FROM nmab_t WHERE nmabent = '" ||g_enterprise||"' AND nmab001 = ? AND nmabstus = 'Y' ","sub-01302","anmi100") THEN  #anm-00012 #160318-00005#36  By 07900 --mod
                      LET g_pmbf_d[l_ac].pmbf002 = g_pmbf_d_t.pmbf002                       
                      CALL apmt100_02_pmbf002_ref(g_pmbf_d[l_ac].pmbf002) RETURNING g_pmbf_d[l_ac].pmbf002_desc
                      DISPLAY BY NAME g_pmbf_d[l_ac].pmbf002_desc
                      NEXT FIELD CURRENT
                   END IF
                   SELECT nmab003 INTO g_pmbf_d[l_ac].pmbf005 FROM nmab_t WHERE nmabent = g_enterprise AND nmab001 = g_pmbf_d[l_ac].pmbf002
                   SELECT nmab009 INTO g_pmbf_d[l_ac].pmbf007 FROM nmab_t WHERE nmabent = g_enterprise AND nmab001 = g_pmbf_d[l_ac].pmbf002
                   
                   DISPLAY BY NAME g_pmbf_d[l_ac].pmbf005,g_pmbf_d[l_ac].pmbf007
                END IF
             END IF

 
         #此段落由子樣板a02產生
         AFTER FIELD pmbf003
            IF  NOT cl_null(g_pmbf_d[l_ac].pmbfdocno) AND NOT cl_null(g_pmbf_d[l_ac].pmbf002) AND NOT cl_null(g_pmbf_d[l_ac].pmbf003) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_pmbf_d[l_ac].pmbfdocno != g_pmbf_d_t.pmbfdocno OR g_pmbf_d[l_ac].pmbf002 != g_pmbf_d_t.pmbf002 OR g_pmbf_d[l_ac].pmbf003 != g_pmbf_d_t.pmbf003))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pmbf_t WHERE "||"pmbfent = '" ||g_enterprise|| "' AND "||"pmbfdocno = '"||g_pmbf_d[l_ac].pmbfdocno ||"' AND "|| "pmbf002 = '"||g_pmbf_d[l_ac].pmbf002 ||"' AND "|| "pmbf003 = '"||g_pmbf_d[l_ac].pmbf003 ||"'",'std-00004',0) THEN 
                     LET g_pmbf_d[l_ac].pmbf003 = g_pmbf_d_t.pmbf003
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            
         AFTER FIELD pmbf008
            IF NOT cl_null(g_pmbf_d[l_ac].pmbfdocno) AND NOT cl_null(g_pmbf_d[l_ac].pmbf008) AND NOT cl_null(g_pmbf_d[l_ac].pmbf003) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pmbf_d[l_ac].pmbf008 != g_pmbf_d_t.pmbf008 OR cl_null(g_pmbf_d_t.pmbf008))) THEN
                  IF g_pmbf_d[l_ac].pmbf008 = 'Y' THEN
                     IF NOT apmt100_02_pmbf008_chk() THEN
                        LET g_pmbf_d[l_ac].pmbf008 = g_pmbf_d_t.pmbf008
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF

         AFTER FIELD pmbf009
            IF NOT cl_null(g_pmbf_d[l_ac].pmbfdocno) AND NOT cl_null(g_pmbf_d[l_ac].pmbf009) AND NOT cl_null(g_pmbf_d[l_ac].pmbf003) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pmbf_d[l_ac].pmbf009 != g_pmbf_d_t.pmbf009 OR cl_null(g_pmbf_d_t.pmbf009))) THEN
                  IF g_pmbf_d[l_ac].pmbf009 = 'Y' THEN
                     IF NOT apmt100_02_pmbf009_chk() THEN
                        LET g_pmbf_d[l_ac].pmbf009 = g_pmbf_d_t.pmbf009
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            
         ON ACTION controlp INFIELD pmbf002          
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			   LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmbf_d[l_ac].pmbf002             #給予default值

            #給予arg

            CALL q_nmab001()                                #呼叫開窗

            LET g_pmbf_d[l_ac].pmbf002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmbf_d[l_ac].pmbf002 TO pmbf002              #顯示到畫面上
            CALL apmt100_02_pmbf002_ref(g_pmbf_d[l_ac].pmbf002) RETURNING g_pmbf_d[l_ac].pmbf002_desc
            DISPLAY BY NAME g_pmbf_d[l_ac].pmbf002_desc

            NEXT FIELD pmbf002                          #返回原欄位

 
         AFTER INPUT
            #add-point:單身輸入後處理
            LET g_pmba4_d.* = g_pmbf_d.*
            #end add-point
            
      END INPUT
      
END DIALOG

 
{</section>}
 
{<section id="apmt100_02.other_function" readonly="Y" >}
#+
PUBLIC FUNCTION apmt100_02_b_fill(p_pmbadocno)
   DEFINE p_pmbadocno   LIKE pmba_t.pmbadocno
   DEFINE l_sql       STRING

   DEFINE l_ac1       LIKE type_t.num5
   
   LET l_sql = "SELECT pmbfstus,pmbfdocno,pmbf001,pmbf002,'',pmbf003,pmbf004,pmbf008,pmbf009,pmbf005,pmbf007,pmbf006 FROM pmbf_t WHERE pmbfent = '",g_enterprise,"' AND pmbfdocno = '",p_pmbadocno,"' "
   IF NOT cl_null(g_wc2_t10002) THEN
      LET l_sql = l_sql CLIPPED, " AND ",g_wc2_t10002 CLIPPED
   END IF
   PREPARE apmt100_02_pb FROM l_sql
   DECLARE b_fill_curs CURSOR FOR apmt100_02_pb

   CALL g_pmbf_d.clear()
   LET l_ac1 = 1
   FOREACH b_fill_curs INTO g_pmbf_d[l_ac1].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      CALL apmt100_02_pmbf002_ref(g_pmbf_d[l_ac1].pmbf002) RETURNING g_pmbf_d[l_ac1].pmbf002_desc
          
      LET l_ac1 = l_ac1 + 1
      IF l_ac1 > g_max_rec THEN
         #CALL cl_err( "", 9035, 0 )
         EXIT FOREACH
      END IF

   END FOREACH
   CALL g_pmbf_d.deleteElement(g_pmbf_d.getLength())
   LET g_rec_b = l_ac1 - 1
   DISPLAY g_rec_b TO FORMONLY.cnt
   LET g_pmba4_d.* = g_pmbf_d.*
   #將總筆數, 目前筆數指定到共用變數中
   IF g_rec_b > 0 THEN
      LET g_d_idx_t10002 = 1
   ELSE
      LET g_d_idx_t10002 = 0
   END IF
   LET g_d_cnt_t10002 = g_rec_b
   
   CLOSE b_fill_curs
   FREE apmt100_02_pb
   
END FUNCTION
#+
PRIVATE FUNCTION apmt100_02_pmbf002_ref(p_pmbf002)
DEFINE p_pmbf002      LIKE pmbf_t.pmbf002
DEFINE r_pmbf002_desc LIKE nmabl_t.nmabl003
 
       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmbf002
       CALL ap_ref_array2(g_ref_fields,"SELECT nmabl003 FROM nmabl_t WHERE nmablent='"||g_enterprise||"' AND nmabl001=? AND nmabl002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmbf002_desc = '', g_rtn_fields[1] , ''
       RETURN r_pmbf002_desc
     
END FUNCTION
#+
PRIVATE FUNCTION apmt100_02_pmbf008_chk()
DEFINE l_n            LIKE type_t.num5
DEFINE r_success      LIKE type_t.num5

       LET l_n = 0
       LET r_success = TRUE       
       SELECT COUNT(*) INTO l_n FROM pmbf_t WHERE pmbfent = g_enterprise AND pmbfdocno = g_pmbf_d[l_ac].pmbfdocno AND pmbf008 = 'Y'
       #同一個銀和帳號已勾選了主要收款帳戶，不可再次勾選
       IF l_n > 0 THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = 'apm-00157'
          LET g_errparam.extend = g_pmbf_d[l_ac].pmbfdocno
          LET g_errparam.popup = TRUE
          CALL cl_err()

          LET r_success = FALSE
          RETURN r_success
       END IF
       RETURN r_success
      
END FUNCTION
#+
PRIVATE FUNCTION apmt100_02_pmbf009_chk()
DEFINE l_n            LIKE type_t.num5
DEFINE r_success      LIKE type_t.num5

       LET l_n = 0
       LET r_success = TRUE       
       SELECT COUNT(*) INTO l_n FROM pmbf_t WHERE pmbfent = g_enterprise AND pmbfdocno = g_pmbf_d[l_ac].pmbfdocno AND pmbf009 = 'Y'
       #同一個銀和帳號已勾選了主要付款帳戶，不可再次勾選
       IF l_n > 0 THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = 'apm-00158'
          LET g_errparam.extend = g_pmbf_d[l_ac].pmbfdocno
          LET g_errparam.popup = TRUE
          CALL cl_err()

          LET r_success = FALSE
          RETURN r_success
       END IF
       RETURN r_success
      
END FUNCTION
################################################################################
# Descriptions...: 清除畫面上單身
# Memo...........: 
# Usage..........: CALL apmt100_02_clear_detail()
# Input parameter: None
# Return code....: None
# Date & Author..: 2014/09/23 By lixiang
# Modify.........:
################################################################################
PUBLIC FUNCTION apmt100_02_clear_detail()

    CALL g_pmbf_d.clear()
    
END FUNCTION

 
{</section>}
 
