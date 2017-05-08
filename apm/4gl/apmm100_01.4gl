#該程式未解開Section, 採用最新樣板產出!
{<section id="apmm100_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0007(2014-09-24 16:06:41), PR版次:0007(2016-11-08 14:43:37)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000191
#+ Filename...: apmm100_01
#+ Description: 交易夥伴關係維護作業
#+ Creator....: 02294(2013-09-05 11:34:58)
#+ Modifier...: 02294 -SD/PR- 02294
 
{</section>}
 
{<section id="apmm100_01.global" >}
#應用 c02b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160318-00005#34  16/03/18   By Hans  將重複內容的錯誤訊息置換為公用錯誤訊息 
#161027-00045#1   16/11/08   By lixiang 交易伙伴关系栏位开窗时，给i状态
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
GLOBALS "../../apm/4gl/apmm100_01.inc"
#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_pmac_d        RECORD
       pmacstus LIKE pmac_t.pmacstus, 
   pmac001 LIKE pmac_t.pmac001, 
   pmac003 LIKE pmac_t.pmac003, 
   pmac004 LIKE pmac_t.pmac004, 
   pmac002 LIKE pmac_t.pmac002, 
   pmac002_desc LIKE type_t.chr500
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 
#end add-point
 
DEFINE g_pmac_d          DYNAMIC ARRAY OF type_g_pmac_d
DEFINE g_pmac_d_t        type_g_pmac_d
 
 
DEFINE g_pmac001_t   LIKE pmac_t.pmac001    #Key值備份
DEFINE g_pmac002_t      LIKE pmac_t.pmac002    #Key值備份
DEFINE g_pmac003_t      LIKE pmac_t.pmac003    #Key值備份
 
 
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
   DEFINE g_pmaa_d          DYNAMIC ARRAY OF type_g_pmac_d
END GLOBALS
#end add-point    
 
{</section>}
 
{<section id="apmm100_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION apmm100_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_pmaa001
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
   DEFINE l_lock_sw       LIKE type_t.chr1
   DEFINE p_pmaa001       LIKE pmaa_t.pmaa001
   DEFINE l_forupd_sql    STRING
   DEFINE l_n             LIKE type_t.num5                #檢查重複用  
   DEFINE l_cnt           LIKE type_t.num5
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_apmm100_01 WITH FORM cl_ap_formpath("apm","apmm100_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #輸入前處理
   #add-point:單身前置處理 name="input.pre_input"
   WHENEVER ERROR CONTINUE
   
   CALL cl_set_combo_scc('pmac003','2013')
   
   CALL apmm100_01_b_fill(p_pmaa001)
   
   LET l_ac = 1
   LET l_forupd_sql = "SELECT pmacstus,pmac001,pmac003,pmac004,pmac002,'' FROM pmac_t WHERE pmacent = ? AND pmac001 = ? AND pmac002 = ? AND pmac003 = ? FOR UPDATE"
   LET l_forupd_sql = cl_sql_forupd(l_forupd_sql)
   DECLARE apmm100_01_bcl CURSOR FROM l_forupd_sql
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT ARRAY g_pmac_d FROM s_detail1_apmm100_01.*
          ATTRIBUTE(COUNT = g_rec_b,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = FALSE,
                  DELETE ROW = l_allow_delete,
                  APPEND ROW = l_allow_insert)
         
         #自訂ACTION
         #add-point:單身前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(detail_input)
         
         
         BEFORE INPUT
            #add-point:單身輸入前處理 name="input.before_input"
            CALL apmm100_01_b_fill(p_pmaa001)
            LET g_rec_b = g_pmac_d.getLength()
            
          BEFORE ROW 
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
   
            LET g_rec_b = g_pmac_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND NOT cl_null(g_pmac_d[l_ac].pmac001)
               AND NOT cl_null(g_pmac_d[l_ac].pmac002) 
               AND NOT cl_null(g_pmac_d[l_ac].pmac003) 
 
 
            THEN
               LET l_cmd='u'
			   LET g_pmac_d_t.* = g_pmac_d[l_ac].*  #BACKUP
			   
			   OPEN apmm100_01_bcl USING g_enterprise,p_pmaa001,g_pmac_d[l_ac].pmac002,g_pmac_d[l_ac].pmac003
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "apmm100_01_bcl"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET l_lock_sw='Y'
               ELSE
                  FETCH apmm100_01_bcl INTO g_pmac_d[l_ac].pmacstus,g_pmac_d[l_ac].pmac001,g_pmac_d[l_ac].pmac003,g_pmac_d[l_ac].pmac004,g_pmac_d[l_ac].pmac002,g_pmac_d[l_ac].pmac002_desc
                   
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = p_pmaa001
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_lock_sw = "Y"
                  END IF
				  CALL apmm100_01_pmac002_ref(g_pmac_d[l_ac].pmac002) RETURNING g_pmac_d[l_ac].pmac002_desc
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
        
         BEFORE INSERT
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_pmac_d[l_ac].* TO NULL          
            
            LET g_pmac_d[l_ac].pmac001 = p_pmaa001
            LET g_pmac_d[l_ac].pmacstus = 'Y'
            LET g_pmac_d[l_ac].pmac003 = '1'
            LET g_pmac_d[l_ac].pmac004 = 'N'
            
            LET g_pmac_d_t.* = g_pmac_d[l_ac].*     #新輸入資料

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
            SELECT COUNT(*) INTO l_count FROM pmac_t 
             WHERE pmacent = g_enterprise AND pmac001 = g_pmac_d[l_ac].pmac001
               AND pmac002 = g_pmac_d[l_ac].pmac002
               AND pmac003 = g_pmac_d[l_ac].pmac003
      
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               INSERT INTO pmac_t (pmacent,pmac001,pmac002,pmac003,pmac004,pmacstus)
                  VALUES (g_enterprise,g_pmac_d[l_ac].pmac001,g_pmac_d[l_ac].pmac002,g_pmac_d[l_ac].pmac003,g_pmac_d[l_ac].pmac004,g_pmac_d[l_ac].pmacstus)
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_pmac_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "pmac_t"
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
            IF NOT cl_null(g_pmac_d[l_ac].pmac001)
               AND NOT cl_null(g_pmac_d[l_ac].pmac002) 
               AND NOT cl_null(g_pmac_d[l_ac].pmac003) THEN 
               
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

               DELETE FROM pmac_t
                WHERE pmacent = g_enterprise AND pmac001 = g_pmac_d_t.pmac001
                  AND pmac002 = g_pmac_d_t.pmac002
                  AND pmac003 = g_pmac_d_t.pmac003

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "pmac_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

                  CALL s_transaction_end('N','0')
                  CANCEL DELETE   
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF 
               CLOSE apmm100_01_bcl
               LET l_count = g_pmac_d.getLength()
            END IF 
            
        ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_pmac_d[l_ac].* = g_pmac_d_t.*
               CLOSE apmm100_01_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG
            END IF

            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_pmac_d[l_ac].pmac002
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_pmac_d[l_ac].* = g_pmac_d_t.*
            ELSE
               UPDATE pmac_t SET (pmac002,pmac003,pmac004,pmacstus) = (g_pmac_d[l_ac].pmac002,g_pmac_d[l_ac].pmac003,g_pmac_d[l_ac].pmac004,g_pmac_d[l_ac].pmacstus)
                WHERE pmacent = g_enterprise 
                  AND pmac001 = g_pmac_d_t.pmac001
                  AND pmac002 = g_pmac_d_t.pmac002
                  AND pmac003 = g_pmac_d_t.pmac003

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "pmac_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

                  LET g_pmac_d[l_ac].* = g_pmac_d_t.*
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
            END IF
            
         AFTER ROW
            CLOSE apmm100_01_bcl
            CALL s_transaction_end('Y','0')
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmacstus
            #add-point:BEFORE FIELD pmacstus name="input.b.page1_apmm100_01.pmacstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmacstus
            
            #add-point:AFTER FIELD pmacstus name="input.a.page1_apmm100_01.pmacstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmacstus
            #add-point:ON CHANGE pmacstus name="input.g.page1_apmm100_01.pmacstus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmac001
            #add-point:BEFORE FIELD pmac001 name="input.b.page1_apmm100_01.pmac001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmac001
            
            #add-point:AFTER FIELD pmac001 name="input.a.page1_apmm100_01.pmac001"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_pmac_d[g_detail_idx].pmac001 IS NOT NULL AND g_pmac_d[g_detail_idx].pmac002 IS NOT NULL AND g_pmac_d[g_detail_idx].pmac003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pmac_d[g_detail_idx].pmac001 != g_pmac_d_t.pmac001 OR g_pmac_d[g_detail_idx].pmac002 != g_pmac_d_t.pmac002 OR g_pmac_d[g_detail_idx].pmac003 != g_pmac_d_t.pmac003)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pmac_t WHERE "||"pmacent = '" ||g_enterprise|| "' AND "||"pmac001 = '"||g_pmac_d[g_detail_idx].pmac001 ||"' AND "|| "pmac002 = '"||g_pmac_d[g_detail_idx].pmac002 ||"' AND "|| "pmac003 = '"||g_pmac_d[g_detail_idx].pmac003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmac001
            #add-point:ON CHANGE pmac001 name="input.g.page1_apmm100_01.pmac001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmac003
            #add-point:BEFORE FIELD pmac003 name="input.b.page1_apmm100_01.pmac003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmac003
            
            #add-point:AFTER FIELD pmac003 name="input.a.page1_apmm100_01.pmac003"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_pmac_d[g_detail_idx].pmac001 IS NOT NULL AND g_pmac_d[g_detail_idx].pmac002 IS NOT NULL AND g_pmac_d[g_detail_idx].pmac003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pmac_d[g_detail_idx].pmac001 != g_pmac_d_t.pmac001 OR g_pmac_d[g_detail_idx].pmac002 != g_pmac_d_t.pmac002 OR g_pmac_d[g_detail_idx].pmac003 != g_pmac_d_t.pmac003)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pmac_t WHERE "||"pmacent = '" ||g_enterprise|| "' AND "||"pmac001 = '"||g_pmac_d[g_detail_idx].pmac001 ||"' AND "|| "pmac002 = '"||g_pmac_d[g_detail_idx].pmac002 ||"' AND "|| "pmac003 = '"||g_pmac_d[g_detail_idx].pmac003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmac003
            #add-point:ON CHANGE pmac003 name="input.g.page1_apmm100_01.pmac003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmac004
            #add-point:BEFORE FIELD pmac004 name="input.b.page1_apmm100_01.pmac004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmac004
            
            #add-point:AFTER FIELD pmac004 name="input.a.page1_apmm100_01.pmac004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmac004
            #add-point:ON CHANGE pmac004 name="input.g.page1_apmm100_01.pmac004"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD pmac002
            
            #add-point:AFTER FIELD pmac002 name="input.a.page1_apmm100_01.pmac002"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_pmac_d[g_detail_idx].pmac001 IS NOT NULL AND g_pmac_d[g_detail_idx].pmac002 IS NOT NULL AND g_pmac_d[g_detail_idx].pmac003 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_pmac_d[g_detail_idx].pmac001 != g_pmac_d_t.pmac001 OR g_pmac_d[g_detail_idx].pmac002 != g_pmac_d_t.pmac002 OR g_pmac_d[g_detail_idx].pmac003 != g_pmac_d_t.pmac003)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pmac_t WHERE "||"pmacent = '" ||g_enterprise|| "' AND "||"pmac001 = '"||g_pmac_d[g_detail_idx].pmac001 ||"' AND "|| "pmac002 = '"||g_pmac_d[g_detail_idx].pmac002 ||"' AND "|| "pmac003 = '"||g_pmac_d[g_detail_idx].pmac003 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_pmac_d[l_ac].pmac002
            CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_pmac_d[l_ac].pmac002_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_pmac_d[l_ac].pmac002_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD pmac002
            #add-point:BEFORE FIELD pmac002 name="input.b.page1_apmm100_01.pmac002"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE pmac002
            #add-point:ON CHANGE pmac002 name="input.g.page1_apmm100_01.pmac002"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1_apmm100_01.pmacstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmacstus
            #add-point:ON ACTION controlp INFIELD pmacstus name="input.c.page1_apmm100_01.pmacstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_apmm100_01.pmac001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmac001
            #add-point:ON ACTION controlp INFIELD pmac001 name="input.c.page1_apmm100_01.pmac001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_apmm100_01.pmac003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmac003
            #add-point:ON ACTION controlp INFIELD pmac003 name="input.c.page1_apmm100_01.pmac003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_apmm100_01.pmac004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmac004
            #add-point:ON ACTION controlp INFIELD pmac004 name="input.c.page1_apmm100_01.pmac004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_apmm100_01.pmac002
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD pmac002
            #add-point:ON ACTION controlp INFIELD pmac002 name="input.c.page1_apmm100_01.pmac002"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'  
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmac_d[l_ac].pmac002             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_pmaa001_4()                                #呼叫開窗

            LET g_pmac_d[l_ac].pmac002 = g_qryparam.return1              

            DISPLAY g_pmac_d[l_ac].pmac002 TO pmac002              #

            NEXT FIELD pmac002                          #返回原欄位


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
   CLOSE WINDOW w_apmm100_01 
   
   #add-point:input段after input name="input.post_input"
   CALL s_transaction_begin()
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="apmm100_01.other_dialog" readonly="Y" >}
################################################################################
# Descriptions...: 被主程式嵌入的地址資料顯示模式
# Memo...........: 
# Usage..........: apmm100_01_display()
# Input parameter: None
# Return code....: None
# Date & Author..: 2014/09/23 By lixiang
# Modify.........:
################################################################################
DIALOG apmm100_01_display()
   
   DISPLAY ARRAY g_pmac_d TO s_detail1_apmm100_01.* ATTRIBUTE(COUNT=g_d_cnt_m10001)

      BEFORE DISPLAY
         CALL FGL_SET_ARR_CURR(g_d_idx_m10001)
         #單身不連動, 所以進入單身時, 要重新顯示單身筆數
         DISPLAY g_d_idx_m10001, g_d_cnt_m10001 TO FORMONLY.idx, FORMONLY.cnt

      BEFORE ROW
         LET g_d_idx_m10001 = DIALOG.getCurrentRow("s_detail1_apmm100_01")
         DISPLAY g_d_idx_m10001 TO FORMONLY.idx
         # 點的當筆放入g_appoint_idx中, 可讓雙擊直接進入指定筆
         LET g_appoint_idx = g_d_idx_m10001

   END DISPLAY
   
END DIALOG
################################################################################
# Descriptions...: 被主程式嵌入的交易夥伴輸入模式
# Memo...........: 
# Usage..........: CALL apmm100_01_input()
# Input parameter: None
# Return code....: None
# Date & Author..: 2014/09/24 By lixiang
# Modify.........:
################################################################################
DIALOG apmm100_01_input()
   DEFINE l_ac_t          LIKE type_t.num5        #未取消的ARRAY CNT   
   DEFINE l_count         LIKE type_t.num5
   DEFINE l_insert        LIKE type_t.num5
   DEFINE l_cmd           LIKE type_t.chr5
   DEFINE l_lock_sw       LIKE type_t.chr1
   DEFINE l_forupd_sql    STRING
   DEFINE l_n             LIKE type_t.num5                #檢查重複用  
   DEFINE l_cnt           LIKE type_t.num5
   
   
   
   INPUT ARRAY g_pmac_d FROM s_detail1_apmm100_01.*
          ATTRIBUTE(COUNT = g_d_cnt_m10001,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = FALSE,
                  DELETE ROW = g_detail_delete,
                  APPEND ROW = g_detail_insert)

         BEFORE INPUT
            LET l_forupd_sql = "SELECT pmacstus,pmac001,pmac003,pmac004,pmac002,'' FROM pmac_t ",
                               "  WHERE pmacent = '",g_enterprise,"' AND pmac001 = ? AND pmac002 = ? AND pmac003 = ? FOR UPDATE"
            LET l_forupd_sql = cl_sql_forupd(l_forupd_sql)
            PREPARE apmm100_01_dialog_b FROM l_forupd_sql
            DECLARE apmm100_01_dialog_bcl CURSOR FOR apmm100_01_dialog_b
            IF g_appoint_idx > 0 THEN
               CALL DIALOG.setCurrentRow("s_detail1_apmm100_01",g_appoint_idx)
            END IF
            
          BEFORE ROW 
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
   
            LET g_rec_b = g_pmac_d.getLength()
            
            IF g_rec_b >= l_ac 
               AND NOT cl_null(g_pmac_d[l_ac].pmac001)
               AND NOT cl_null(g_pmac_d[l_ac].pmac002) 
               AND NOT cl_null(g_pmac_d[l_ac].pmac003) 
 
 
            THEN
               LET l_cmd='u'
			      LET g_pmac_d_t.* = g_pmac_d[l_ac].*  #BACKUP
			   
			      OPEN apmm100_01_dialog_bcl USING g_pmac_d[l_ac].pmac001,g_pmac_d[l_ac].pmac002,g_pmac_d[l_ac].pmac003
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "apmm100_01_dialog_bcl"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET l_lock_sw='Y'
               ELSE
                  FETCH apmm100_01_dialog_bcl INTO g_pmac_d[l_ac].pmacstus,g_pmac_d[l_ac].pmac001,g_pmac_d[l_ac].pmac003,g_pmac_d[l_ac].pmac004,g_pmac_d[l_ac].pmac002,g_pmac_d[l_ac].pmac002_desc
                   
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = g_pmaa001_d
                     LET g_errparam.popup = TRUE
                     CALL cl_err()

                     LET l_lock_sw = "Y"
                  END IF
				      CALL apmm100_01_pmac002_ref(g_pmac_d[l_ac].pmac002) RETURNING g_pmac_d[l_ac].pmac002_desc
                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
        
         BEFORE INSERT
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            LET l_cmd = 'a'
            INITIALIZE g_pmac_d[l_ac].* TO NULL          
            
            LET g_pmac_d[l_ac].pmac001 = g_pmaa001_d
            LET g_pmac_d[l_ac].pmacstus = 'Y'
            LET g_pmac_d[l_ac].pmac003 = '1'
            LET g_pmac_d[l_ac].pmac004 = 'N'
            
            LET g_pmac_d_t.* = g_pmac_d[l_ac].*     #新輸入資料

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
            SELECT COUNT(*) INTO l_count FROM pmac_t 
             WHERE pmacent = g_enterprise AND pmac001 = g_pmac_d[l_ac].pmac001
               AND pmac002 = g_pmac_d[l_ac].pmac002
               AND pmac003 = g_pmac_d[l_ac].pmac003
      
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               INSERT INTO pmac_t (pmacent,pmac001,pmac002,pmac003,pmac004,pmacstus)
                  VALUES (g_enterprise,g_pmac_d[l_ac].pmac001,g_pmac_d[l_ac].pmac002,g_pmac_d[l_ac].pmac003,g_pmac_d[l_ac].pmac004,g_pmac_d[l_ac].pmacstus)
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_pmac_d[l_ac].* TO NULL
               CALL s_transaction_end('N','0')
               #CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "pmac_t"
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
            IF NOT cl_null(g_pmac_d[l_ac].pmac001)
               AND NOT cl_null(g_pmac_d[l_ac].pmac002) 
               AND NOT cl_null(g_pmac_d[l_ac].pmac003) THEN 
               
               IF cl_ask_del_detail() THEN
                  
                  IF l_lock_sw = "Y" THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code =  -263
                     LET g_errparam.extend = ""
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  
                     #CANCEL DELETE
                  END IF
                  
                  DELETE FROM pmac_t
                   WHERE pmacent = g_enterprise AND pmac001 = g_pmac_d_t.pmac001
                     AND pmac002 = g_pmac_d_t.pmac002
                     AND pmac003 = g_pmac_d_t.pmac003
                  
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "pmac_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     
                     CALL s_transaction_end('N','0')
                     #CANCEL DELETE   
                  ELSE
                     CALL s_transaction_end('Y','0')
                  END IF 
                  CLOSE apmm100_01_dialog_bcl
                  LET l_count = g_pmac_d.getLength()
               END IF
            END IF 
            
        AFTER DELETE
            CALL apmm100_01_b_fill(g_pmaa001_d)
            
        ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_pmac_d[l_ac].* = g_pmac_d_t.*
               CLOSE apmm100_01_dialog_bcl
               CALL s_transaction_end('N','0')
               EXIT DIALOG
            END IF

            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_pmac_d[l_ac].pmac002
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_pmac_d[l_ac].* = g_pmac_d_t.*
            ELSE
               UPDATE pmac_t SET (pmac002,pmac003,pmac004,pmacstus) = (g_pmac_d[l_ac].pmac002,g_pmac_d[l_ac].pmac003,g_pmac_d[l_ac].pmac004,g_pmac_d[l_ac].pmacstus)
                WHERE pmacent = g_enterprise 
                  AND pmac001 = g_pmac_d_t.pmac001
                  AND pmac002 = g_pmac_d_t.pmac002
                  AND pmac003 = g_pmac_d_t.pmac003

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "pmac_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_pmac_d[l_ac].* = g_pmac_d_t.*
                  CALL s_transaction_end('N','0')
               ELSE
                  CALL s_transaction_end('Y','0')
               END IF
            END IF
            
         AFTER ROW
            CLOSE apmm100_01_dialog_bcl
            
         
         AFTER FIELD pmac003
            
            IF NOT cl_null(g_pmac_d[l_ac].pmac001) AND NOT cl_null(g_pmac_d[l_ac].pmac002) AND NOT cl_null(g_pmac_d[l_ac].pmac003) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_pmac_d[l_ac].pmac001 != g_pmac_d_t.pmac001 OR g_pmac_d[l_ac].pmac002 != g_pmac_d_t.pmac002 OR g_pmac_d[l_ac].pmac003 != g_pmac_d_t.pmac003))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pmac_t WHERE "||"pmacent = '" ||g_enterprise|| "' AND "||"pmac001 = '"||g_pmac_d[l_ac].pmac001 ||"' AND "|| "pmac002 = '"||g_pmac_d[l_ac].pmac002 ||"' AND "|| "pmac003 = '"||g_pmac_d[l_ac].pmac003 ||"'",'std-00004',0) THEN 
                     LET g_pmac_d[l_ac].pmac003 = g_pmac_d_t.pmac003
                     NEXT FIELD CURRENT
                  END IF
                  IF g_pmac_d[l_ac].pmac004 = 'Y' THEN
                     IF NOT apmm100_01_pmac004_chk() THEN
                        LET g_pmac_d[l_ac].pmac003 = g_pmac_d_t.pmac003
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF

            
         AFTER FIELD pmac004
            
            IF NOT cl_null(g_pmac_d[l_ac].pmac001) AND NOT cl_null(g_pmac_d[l_ac].pmac004) AND NOT cl_null(g_pmac_d[l_ac].pmac003) THEN 
               IF l_cmd = 'a' OR (l_cmd = 'u' AND (g_pmac_d[l_ac].pmac004 != g_pmac_d_t.pmac004 OR cl_null(g_pmac_d_t.pmac004))) THEN
                  IF g_pmac_d[l_ac].pmac004 = 'Y' THEN
                     IF NOT apmm100_01_pmac004_chk() THEN
                        LET g_pmac_d[l_ac].pmac004 = g_pmac_d_t.pmac004
                        NEXT FIELD CURRENT
                     END IF
                  END IF
               END IF
            END IF
            
         AFTER FIELD pmac002
            
            CALL apmm100_01_pmac002_ref(g_pmac_d[l_ac].pmac002) RETURNING g_pmac_d[l_ac].pmac002_desc
            DISPLAY BY NAME g_pmac_d[l_ac].pmac002_desc
            
            IF NOT cl_null(g_pmac_d[l_ac].pmac001) AND NOT cl_null(g_pmac_d[l_ac].pmac002) AND NOT cl_null(g_pmac_d[l_ac].pmac003) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_pmac_d[l_ac].pmac001 != g_pmac_d_t.pmac001 OR g_pmac_d[l_ac].pmac002 != g_pmac_d_t.pmac002 OR g_pmac_d[l_ac].pmac003 != g_pmac_d_t.pmac003))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM pmac_t WHERE "||"pmacent = '" ||g_enterprise|| "' AND "||"pmac001 = '"||g_pmac_d[l_ac].pmac001 ||"' AND "|| "pmac002 = '"||g_pmac_d[l_ac].pmac002 ||"' AND "|| "pmac003 = '"||g_pmac_d[l_ac].pmac003 ||"'",'std-00004',0) THEN 
                     LET g_pmac_d[l_ac].pmac002 = g_pmac_d_t.pmac002
                     CALL apmm100_01_pmac002_ref(g_pmac_d[l_ac].pmac002) RETURNING g_pmac_d[l_ac].pmac002_desc
                     DISPLAY BY NAME g_pmac_d[l_ac].pmac002_desc
                     NEXT FIELD CURRENT
                  END IF
                  IF NOT ap_chk_isExist(g_pmac_d[l_ac].pmac002,"SELECT COUNT(*) FROM pmaa_t WHERE pmaaent = '" ||g_enterprise||"' AND pmaa001 = ? ","apm-00028",0 ) THEN
                     LET g_pmac_d[l_ac].pmac002 = g_pmac_d_t.pmac002
                     CALL apmm100_01_pmac002_ref(g_pmac_d[l_ac].pmac002) RETURNING g_pmac_d[l_ac].pmac002_desc
                     DISPLAY BY NAME g_pmac_d[l_ac].pmac002_desc
                     NEXT FIELD CURRENT
                  END IF
                  #IF NOT ap_chk_isExist(g_pmac_d[l_ac].pmac002,"SELECT COUNT(*) FROM pmaa_t WHERE pmaaent = '" ||g_enterprise||"' AND pmaa001 = ? AND pmaastus != 'X' ","apm-00029",0 ) THEN         #160318-00005#34
                  IF NOT ap_chk_isExist(g_pmac_d[l_ac].pmac002,"SELECT COUNT(*) FROM pmaa_t WHERE pmaaent = '" ||g_enterprise||"' AND pmaa001 = ? AND pmaastus != 'X' ","sub-01302",'apmm100' ) THEN  #160318-00005#34
                     LET g_pmac_d[l_ac].pmac002 = g_pmac_d_t.pmac002
                     CALL apmm100_01_pmac002_ref(g_pmac_d[l_ac].pmac002) RETURNING g_pmac_d[l_ac].pmac002_desc
                     DISPLAY BY NAME g_pmac_d[l_ac].pmac002_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL apmm100_01_pmac002_ref(g_pmac_d[l_ac].pmac002) RETURNING g_pmac_d[l_ac].pmac002_desc
            DISPLAY BY NAME g_pmac_d[l_ac].pmac002_desc

            
         ON ACTION controlp INFIELD pmac002            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL  #161027-00020#1 add by tangyi 161027
            LET g_qryparam.state = 'i'       #161027-00045#1
            
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_pmac_d[l_ac].pmac002             #給予default值

            #給予arg

            CALL q_pmaa001_4()                                #呼叫開窗

            LET g_pmac_d[l_ac].pmac002 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_pmac_d[l_ac].pmac002 TO pmac002              #顯示到畫面上
            CALL apmm100_01_pmac002_ref(g_pmac_d[l_ac].pmac002) RETURNING g_pmac_d[l_ac].pmac002_desc
            DISPLAY BY NAME g_pmac_d[l_ac].pmac002_desc

            NEXT FIELD pmac002                          #返回原欄位


         AFTER INPUT
            #add-point:單身輸入後處理
            LET g_pmaa_d.* = g_pmac_d.*
            #end add-point
            
      END INPUT

END DIALOG
################################################################################
# Descriptions...: 被主程式嵌入的交易夥伴查詢模式
# Memo...........: 
# Usage..........: CALL apmm100_01_construct()
# Input parameter: None
# Return code....: None
# Date & Author..: 2014/09/24 By lixiang
# Modify.........:
################################################################################
DIALOG apmm100_01_construct()
  DEFINE ls_result   STRING

   CONSTRUCT g_wc2_m10001 ON pmacstus,pmac001,pmac003,pmac004,pmac002
        FROM s_detail1_apmm100_01[1].pmacstus,s_detail1_apmm100_01[1].pmac001,
             s_detail1_apmm100_01[1].pmac003,s_detail1_apmm100_01[1].pmac004,
             s_detail1_apmm100_01[1].pmac002

         ON ACTION controlp INFIELD pmac002
			   INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			   LET g_qryparam.reqry = FALSE
            CALL q_pmaa001_4()                                #呼叫開窗
            DISPLAY g_qryparam.return1 TO pmac002             #顯示到畫面上
            NEXT FIELD pmac002                        #返回原欄位      
            
   END CONSTRUCT
END DIALOG

 
{</section>}
 
{<section id="apmm100_01.other_function" readonly="Y" >}
#+
PUBLIC FUNCTION apmm100_01_b_fill(p_pmaa001)
   DEFINE p_pmaa001   LIKE pmaa_t.pmaa001
   DEFINE l_sql       STRING

   DEFINE l_ac1       LIKE type_t.num5
   
   LET l_sql = "SELECT pmacstus,pmac001,pmac003,pmac004,pmac002,'' FROM pmac_t WHERE pmacent = '",g_enterprise,"' AND pmac001 = '",p_pmaa001,"' "
   IF NOT cl_null(g_wc2_m10001) THEN
      LET l_sql = l_sql CLIPPED, " AND ",g_wc2_m10001 CLIPPED
   END IF
   
   PREPARE apmm100_01_pb FROM l_sql
   DECLARE b_fill_curs CURSOR FOR apmm100_01_pb

   CALL g_pmac_d.clear()
   LET l_ac1 = 1
   FOREACH b_fill_curs INTO g_pmac_d[l_ac1].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      CALL apmm100_01_pmac002_ref(g_pmac_d[l_ac1].pmac002) RETURNING g_pmac_d[l_ac1].pmac002_desc
          
      LET l_ac1 = l_ac1 + 1
      IF l_ac1 > g_max_rec THEN
         #CALL cl_err( "", 9035, 0 )
         EXIT FOREACH
      END IF

   END FOREACH
   CALL g_pmac_d.deleteElement(g_pmac_d.getLength())
   LET g_rec_b = l_ac1 - 1
   DISPLAY g_rec_b TO FORMONLY.cnt
   LET g_pmaa_d.* = g_pmac_d.*
   #將總筆數, 目前筆數指定到共用變數中
   IF g_rec_b > 0 THEN
      LET g_d_idx_m10001 = 1
   ELSE
      LET g_d_idx_m10001 = 0
   END IF
   LET g_d_cnt_m10001 = g_rec_b
   
   CLOSE b_fill_curs
   FREE apmm100_01_pb
   
END FUNCTION

################################################################################
# Descriptions...: 清除畫面上交易夥伴單身
# Memo...........: 
# Usage..........: CALL apmm100_01_clear_detail()
# Input parameter: None
# Return code....: None
# Date & Author..: 2014/09/23 By lixiang
# Modify.........:
################################################################################
PUBLIC FUNCTION apmm100_01_clear_detail()

    CALL g_pmac_d.clear()
    
END FUNCTION
#+
PRIVATE FUNCTION apmm100_01_pmac002_ref(p_pmac002)
DEFINE p_pmac002      LIKE pmac_t.pmac002
DEFINE r_pmac002_desc LIKE pmaal_t.pmaal004

       INITIALIZE g_ref_fields TO NULL
       LET g_ref_fields[1] = p_pmac002
       CALL ap_ref_array2(g_ref_fields,"SELECT pmaal004 FROM pmaal_t WHERE pmaalent='"||g_enterprise||"' AND pmaal001=? AND pmaal002='"||g_dlang||"'","") RETURNING g_rtn_fields
       LET r_pmac002_desc = '', g_rtn_fields[1] , ''
       RETURN r_pmac002_desc
       
END FUNCTION
#+
PRIVATE FUNCTION apmm100_01_pmac004_chk()
DEFINE l_n            LIKE type_t.num5
DEFINE r_success      LIKE type_t.num5

       LET l_n = 0
       LET r_success = TRUE       
       SELECT COUNT(*) INTO l_n FROM pmac_t WHERE pmacent = g_enterprise AND pmac001 = g_pmac_d[l_ac].pmac001 AND pmac003 = g_pmac_d[l_ac].pmac003 AND pmac004 = 'Y'
       #同一個交易類型已勾選一筆資料為主要的，不可再次勾選
       IF l_n > 0 THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = 'apm-00156'
          LET g_errparam.extend = g_pmac_d[l_ac].pmac003
          LET g_errparam.popup = TRUE
          CALL cl_err()

          LET r_success = FALSE
          RETURN r_success
       END IF
       RETURN r_success
      
END FUNCTION

 
{</section>}
 
