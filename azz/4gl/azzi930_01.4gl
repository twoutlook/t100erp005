#該程式未解開Section, 採用最新樣板產出!
{<section id="azzi930_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2016-05-19 16:10:33), PR版次:0001(2016-05-20 14:03:04)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000024
#+ Filename...: azzi930_01
#+ Description: 通訊方式
#+ Creator....: 01101(2016-05-19 16:05:55)
#+ Modifier...: 01101 -SD/PR- 01101
 
{</section>}
 
{<section id="azzi930_01.global" >}
#應用 c02b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#+ Modifier...: No.160509-00001#1 2016/05/19 By tsai_yen Help使用aoo的程式,自備到lib和azz,從aooi350_02複製過來
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
#GLOBALS "../../aoo/4gl/azzi930_01.inc"
GLOBALS   #160509-00001#1
   DEFINE g_detail_insert   LIKE type_t.num5   #單身的新增權限
   DEFINE g_detail_delete   LIKE type_t.num5   #單身的刪除權限
   DEFINE g_wc2_i35002      STRING             #單身QBE條件
   DEFINE g_d_idx_i35002    LIKE type_t.num5   #單身所在筆數
   DEFINE g_d_cnt_i35002    LIKE type_t.num5   #單身總筆數
   DEFINE g_pmaa027_d       LIKE pmaa_t.pmaa027
   DEFINE g_appoint_idx     LIKE type_t.num5   #指定進入單身行數
END GLOBALS
#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_oofc_d        RECORD
       oofcstus LIKE oofc_t.oofcstus, 
   oofc001 LIKE oofc_t.oofc001, 
   oofc008 LIKE oofc_t.oofc008, 
   oofc009 LIKE oofc_t.oofc009, 
   oofc009_desc LIKE type_t.chr500, 
   oofc012 LIKE oofc_t.oofc012, 
   oofc010 LIKE oofc_t.oofc010, 
   oofc014 LIKE oofc_t.oofc014, 
   oofc011 LIKE oofc_t.oofc011, 
   oofc015 LIKE oofc_t.oofc015, 
   oofc013 LIKE oofc_t.oofc013
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
#GLOBALS
#   DEFINE g_detail_insert   LIKE type_t.num5   #單身的新增權限
#   DEFINE g_detail_delete   LIKE type_t.num5   #單身的刪除權限
#   DEFINE g_wc2_i35002      STRING             #單身QBE條件
#   DEFINE g_d_idx_i35002    LIKE type_t.num5   #單身所在筆數
#   DEFINE g_d_cnt_i35002    LIKE type_t.num5   #單身總筆數
#   DEFINE g_pmaa027_d       LIKE pmaa_t.pmaa027
#   DEFINE g_appoint_idx     LIKE type_t.num5   #指定進入單身行數
#END GLOBALS
#end add-point
 
DEFINE g_oofc_d          DYNAMIC ARRAY OF type_g_oofc_d
DEFINE g_oofc_d_t        type_g_oofc_d
 
 
DEFINE g_oofc001_t   LIKE oofc_t.oofc001    #Key值備份
 
 
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
   DEFINE g_pmba2_d          DYNAMIC ARRAY OF type_g_oofc_d
   DEFINE g_oofc_d2          DYNAMIC ARRAY OF type_g_oofc_d
END GLOBALS
#end add-point    
 
{</section>}
 
{<section id="azzi930_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION azzi930_01(--)
   #add-point:input段變數傳入 name="input.get_var"
    p_oofc002
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
   DEFINE p_oofc002      LIKE oofc_t.oofc002
   DEFINE l_oofc         RECORD LIKE oofc_t.*
   DEFINE l_forupd_sql   STRING
   DEFINE l_lock_sw      LIKE type_t.chr1 
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_n            LIKE type_t.num5
   DEFINE l_wc           STRING
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_azzi930_01 WITH FORM cl_ap_formpath("azz","azzi930_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #輸入前處理
   #add-point:單身前置處理 name="input.pre_input"
   WHENEVER ERROR CALL cl_err_msg_log
   CALL cl_set_combo_scc('oofc008','6')
   CALL azzi930_01_b_fill(p_oofc002)
   LET l_forupd_sql = " SELECT oofcstus,oofc001,oofc008,oofc009,'',oofc012,oofc010,oofc014,oofc011,oofc015,oofc013 ",
                      "   FROM oofc_t WHERE oofcent = '",g_enterprise,"' AND oofc002 = '",p_oofc002,"'AND oofc001 = ? FOR UPDATE"
   LET l_forupd_sql = cl_sql_forupd(l_forupd_sql)  
   PREPARE azzi930_01_b FROM l_forupd_sql
   DECLARE azzi930_01_bcl CURSOR FOR azzi930_01_b 
   LET INT_FLAG = FALSE    

   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT ARRAY g_oofc_d FROM s_detail1_azzi930_01.*
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
         BEFORE ROW
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            LET g_rec_b = g_oofc_d.getLength()
            
            IF g_rec_b >= l_ac THEN  
               LET l_cmd='u'
               LET g_oofc_d_t.* = g_oofc_d[l_ac].*  #BACKUP
               CALL azzi930_01_set_entry_b()
               CALL azzi930_01_set_no_entry_b()
               
               IF NOT azzi930_01_lock_b(l_ac) THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH azzi930_01_bcl INTO g_oofc_d[l_ac].oofcstus,g_oofc_d[l_ac].oofc001,g_oofc_d[l_ac].oofc008,g_oofc_d[l_ac].oofc009,g_oofc_d[l_ac].oofc009_desc,
                                            g_oofc_d[l_ac].oofc012,g_oofc_d[l_ac].oofc010,g_oofc_d[l_ac].oofc014,g_oofc_d[l_ac].oofc011,g_oofc_d[l_ac].oofc015,g_oofc_d[l_ac].oofc013
                  IF SQLCA.sqlcode THEN
                     LET l_lock_sw = "Y"
                  END IF
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_oofc_d[l_ac].oofc009
                  CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='3' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_oofc_d[l_ac].oofc009_desc = g_rtn_fields[1]
                 DISPLAY BY NAME g_oofc_d[l_ac].oofc009_desc                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            
         BEFORE INSERT
            CALL s_transaction_begin()
            LET l_cmd = 'a'
            INITIALIZE g_oofc_d_t.* TO NULL
            INITIALIZE g_oofc_d[l_ac].* TO NULL 
            
            LET g_oofc_d_t.* = g_oofc_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()   
            CALL azzi930_01_set_entry_b()
            CALL azzi930_01_set_no_entry_b()
               
            LET g_oofc_d[l_ac].oofcstus = 'Y'
            LET g_oofc_d[l_ac].oofc010 = 'N'
            LET g_oofc_d[l_ac].oofc015 = 'N'  #150904-00004 by whitney modify 'Y'->'N'
            
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
            LET l_oofc.oofcent = g_enterprise
            LET l_oofc.oofcstus =g_oofc_d[l_ac].oofcstus
            LET l_success = NULL
            LET l_wc = " oofcent = '",g_enterprise,"' "
            CALL cl_s_aooi350_get_idno('oofc001','oofc_t',l_wc) RETURNING l_success,l_oofc.oofc001   #160509-00001#1
            LET l_oofc.oofc002 = p_oofc002
            LET l_oofc.oofc008 = g_oofc_d[l_ac].oofc008
            LET l_oofc.oofc009 = g_oofc_d[l_ac].oofc009
            LET l_oofc.oofc010 = g_oofc_d[l_ac].oofc010 
            LET l_oofc.oofc011 = g_oofc_d[l_ac].oofc011
            LET l_oofc.oofc012 = g_oofc_d[l_ac].oofc012
            LET l_oofc.oofc013 = g_oofc_d[l_ac].oofc013
            LET l_oofc.oofc014 = g_oofc_d[l_ac].oofc014
            LET l_oofc.oofc015 = g_oofc_d[l_ac].oofc015
            LET l_oofc.oofcownid = g_user
            LET l_oofc.oofcowndp = g_dept
            LET l_oofc.oofccrtid = g_user
            LET l_oofc.oofccrtdp = g_dept 
            LET l_oofc.oofccrtdt = cl_get_current()
            LET l_oofc.oofcmodid = g_user
            LET l_oofc.oofcmoddt = cl_get_current()
            SELECT COUNT(*) INTO l_count FROM oofc_t 
             WHERE oofcent = g_enterprise AND oofc001 = l_oofc.oofc001  AND oofc002 = p_oofc002
                        
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #INSERT INTO oofc_t VALUES(l_oofc.*)
               INSERT INTO oofc_t(oofcstus,oofcent,oofc001,oofc002,oofc003,oofc004,oofc005,oofc006,oofc007,oofc008,oofc009,oofc010,oofc011,oofc012,oofc013,oofc014,
                                  oofc015,
                                  oofcownid,oofcowndp,oofccrtid,oofccrtdp,oofccrtdt,oofcmodid,oofcmoddt) 
                VALUES(l_oofc.oofcstus,l_oofc.oofcent,l_oofc.oofc001,l_oofc.oofc002,l_oofc.oofc003,l_oofc.oofc004,l_oofc.oofc005,l_oofc.oofc006,l_oofc.oofc007,
                       l_oofc.oofc008, l_oofc.oofc009,l_oofc.oofc010,l_oofc.oofc011,l_oofc.oofc012,l_oofc.oofc013,l_oofc.oofc014,
                       l_oofc.oofc015,
                       l_oofc.oofcownid,l_oofc.oofcowndp,l_oofc.oofccrtid,l_oofc.oofccrtdp,l_oofc.oofccrtdt,l_oofc.oofcmodid,l_oofc.oofcmoddt)
                        
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "oofc_t"
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

               END IF
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_oofc_d[l_ac].* TO NULL
               CALL s_transaction_end('N',0)
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "oofc_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N',0)                   
               CANCEL INSERT
            ELSE
              
               CALL s_transaction_end('Y',0)
               
               ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
 
        BEFORE DELETE                            #是否取消單身
            IF NOT cl_null(g_oofc_d[l_ac].oofc001) THEN

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
               DELETE FROM oofc_t
                WHERE oofcent = g_enterprise AND oofc001 = g_oofc_d[l_ac].oofc001 AND oofc002 = p_oofc002
 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "oofc_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()

                  CALL s_transaction_end('N',0)
                  CANCEL DELETE   
               ELSE
                  LET g_rec_b = g_rec_b-1
                  
                  CALL s_transaction_end('Y',0)
               END IF 
               CLOSE azzi930_01_bcl
               LET l_count = g_oofc_d.getLength()
            END IF 
            
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_oofc_d[l_ac].* = g_oofc_d_t.*
               CLOSE azzi930_01_bcl
               CALL s_transaction_end('N',0)
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = l_oofc.oofc001
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_oofc_d[l_ac].* = g_oofc_d_t.*
            ELSE
               UPDATE oofc_t SET (oofcstus,oofc008,oofc009,oofc014,oofc010,oofc011,oofc012,oofc013,oofc015)= (g_oofc_d[l_ac].oofcstus,g_oofc_d[l_ac].oofc008,g_oofc_d[l_ac].oofc009,g_oofc_d[l_ac].oofc014,g_oofc_d[l_ac].oofc010,g_oofc_d[l_ac].oofc011,g_oofc_d[l_ac].oofc012,g_oofc_d[l_ac].oofc013,g_oofc_d[l_ac].oofc015)
                WHERE oofcent = g_enterprise AND oofc001 = g_oofc_d[l_ac].oofc001 AND oofc002 = p_oofc002 
 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "oofc_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
   
                  LET g_oofc_d[l_ac].* = g_oofc_d_t.*
                  CALL s_transaction_end('N',0)
               ELSE
                  CALL s_transaction_end('Y',0)               
               END IF

            END IF
            
         AFTER ROW
            CALL azzi930_01_unlock_b()
              
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofcstus
            #add-point:BEFORE FIELD oofcstus name="input.b.page1_azzi930_01.oofcstus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofcstus
            
            #add-point:AFTER FIELD oofcstus name="input.a.page1_azzi930_01.oofcstus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oofcstus
            #add-point:ON CHANGE oofcstus name="input.g.page1_azzi930_01.oofcstus"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofc001
            #add-point:BEFORE FIELD oofc001 name="input.b.page1_azzi930_01.oofc001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofc001
            
            #add-point:AFTER FIELD oofc001 name="input.a.page1_azzi930_01.oofc001"
            #此段落由子樣板a05產生
            IF  g_oofc_d[g_detail_idx].oofc001 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_oofc_d[g_detail_idx].oofc001 != g_oofc_d_t.oofc001)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM oofc_t WHERE "||"oofcent = '" ||g_enterprise|| "' AND "||"oofc001 = '"||g_oofc_d[g_detail_idx].oofc001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oofc001
            #add-point:ON CHANGE oofc001 name="input.g.page1_azzi930_01.oofc001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofc008
            #add-point:BEFORE FIELD oofc008 name="input.b.page1_azzi930_01.oofc008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofc008
            
            #add-point:AFTER FIELD oofc008 name="input.a.page1_azzi930_01.oofc008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oofc008
            #add-point:ON CHANGE oofc008 name="input.g.page1_azzi930_01.oofc008"
            CALL azzi930_01_set_entry_b()
            CALL azzi930_01_set_no_entry_b()
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofc009
            
            #add-point:AFTER FIELD oofc009 name="input.a.page1_azzi930_01.oofc009"
            IF NOT cl_null(g_oofc_d[l_ac].oofc009) THEN
               CALL azzi930_01_s_azzi650_chk_exist('3',g_oofc_d[l_ac].oofc009) RETURNING l_success #160509-00001#1
               IF NOT l_success THEN
                  LET g_oofc_d[l_ac].oofc009 = g_oofc_d_t.oofc009
                  LET g_oofc_d[l_ac].oofc009_desc = g_oofc_d_t.oofc009_desc
                  NEXT FIELD oofc009
               END IF   
            END IF   
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_oofc_d[l_ac].oofc009
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='3' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_oofc_d[l_ac].oofc009_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_oofc_d[l_ac].oofc009_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofc009
            #add-point:BEFORE FIELD oofc009 name="input.b.page1_azzi930_01.oofc009"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oofc009
            #add-point:ON CHANGE oofc009 name="input.g.page1_azzi930_01.oofc009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofc012
            #add-point:BEFORE FIELD oofc012 name="input.b.page1_azzi930_01.oofc012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofc012
            
            #add-point:AFTER FIELD oofc012 name="input.a.page1_azzi930_01.oofc012"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oofc012
            #add-point:ON CHANGE oofc012 name="input.g.page1_azzi930_01.oofc012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofc010
            #add-point:BEFORE FIELD oofc010 name="input.b.page1_azzi930_01.oofc010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofc010
            
            #add-point:AFTER FIELD oofc010 name="input.a.page1_azzi930_01.oofc010"
            IF NOT cl_null(g_oofc_d[l_ac].oofc008) AND g_oofc_d[l_ac].oofc010 = 'Y' THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_oofc_d[l_ac].oofc010 != g_oofc_d_t.oofc010))) THEN
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n FROM oofc_t
                  WHERE oofcent = g_enterprise
                    AND oofc002 = p_oofc002
                    AND oofc008 = g_oofc_d[l_ac].oofc008
                    AND oofc010 = 'Y'
                   IF l_n > 0 THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = 'aoo-00153'
                      LET g_errparam.extend = g_oofc_d[l_ac].oofc010
                      LET g_errparam.popup = TRUE
                      CALL cl_err()

                      LET g_oofc_d[l_ac].oofc010 = 'N'
                      NEXT FIELD oofc010
                   END IF
                END IF
             END IF             
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oofc010
            #add-point:ON CHANGE oofc010 name="input.g.page1_azzi930_01.oofc010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofc014
            #add-point:BEFORE FIELD oofc014 name="input.b.page1_azzi930_01.oofc014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofc014
            
            #add-point:AFTER FIELD oofc014 name="input.a.page1_azzi930_01.oofc014"
            IF  NOT cl_null(g_oofc_d[l_ac].oofc014) THEN
                IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_oofc_d[l_ac].oofc014 != g_oofc_d_t.oofc014) OR g_oofc_d_t.oofc014 IS NULL)) THEN
                   IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM oofc_t WHERE "||"oofcent = '" ||g_enterprise|| "' AND "||"oofc002 = '"|| p_oofc002 || "' AND "||"oofc014 = '"||g_oofc_d[l_ac].oofc014 ||"'",'std-00004',1) THEN 
                       LET g_oofc_d[l_ac].oofc014 = g_oofc_d_t.oofc014
                       NEXT FIELD oofc014
                   END IF
                END IF
            END IF    
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oofc014
            #add-point:ON CHANGE oofc014 name="input.g.page1_azzi930_01.oofc014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofc011
            #add-point:BEFORE FIELD oofc011 name="input.b.page1_azzi930_01.oofc011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofc011
            
            #add-point:AFTER FIELD oofc011 name="input.a.page1_azzi930_01.oofc011"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oofc011
            #add-point:ON CHANGE oofc011 name="input.g.page1_azzi930_01.oofc011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofc015
            #add-point:BEFORE FIELD oofc015 name="input.b.page1_azzi930_01.oofc015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofc015
            
            #add-point:AFTER FIELD oofc015 name="input.a.page1_azzi930_01.oofc015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oofc015
            #add-point:ON CHANGE oofc015 name="input.g.page1_azzi930_01.oofc015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD oofc013
            #add-point:BEFORE FIELD oofc013 name="input.b.page1_azzi930_01.oofc013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD oofc013
            
            #add-point:AFTER FIELD oofc013 name="input.a.page1_azzi930_01.oofc013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE oofc013
            #add-point:ON CHANGE oofc013 name="input.g.page1_azzi930_01.oofc013"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1_azzi930_01.oofcstus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofcstus
            #add-point:ON ACTION controlp INFIELD oofcstus name="input.c.page1_azzi930_01.oofcstus"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_azzi930_01.oofc001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofc001
            #add-point:ON ACTION controlp INFIELD oofc001 name="input.c.page1_azzi930_01.oofc001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_azzi930_01.oofc008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofc008
            #add-point:ON ACTION controlp INFIELD oofc008 name="input.c.page1_azzi930_01.oofc008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_azzi930_01.oofc009
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofc009
            #add-point:ON ACTION controlp INFIELD oofc009 name="input.c.page1_azzi930_01.oofc009"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_oofc_d[l_ac].oofc009             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "3" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_oofc_d[l_ac].oofc009 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_oofc_d[l_ac].oofc009 TO oofc009              #顯示到畫面上

            NEXT FIELD oofc009                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1_azzi930_01.oofc012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofc012
            #add-point:ON ACTION controlp INFIELD oofc012 name="input.c.page1_azzi930_01.oofc012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_azzi930_01.oofc010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofc010
            #add-point:ON ACTION controlp INFIELD oofc010 name="input.c.page1_azzi930_01.oofc010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_azzi930_01.oofc014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofc014
            #add-point:ON ACTION controlp INFIELD oofc014 name="input.c.page1_azzi930_01.oofc014"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_azzi930_01.oofc011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofc011
            #add-point:ON ACTION controlp INFIELD oofc011 name="input.c.page1_azzi930_01.oofc011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_azzi930_01.oofc015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofc015
            #add-point:ON ACTION controlp INFIELD oofc015 name="input.c.page1_azzi930_01.oofc015"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_azzi930_01.oofc013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD oofc013
            #add-point:ON ACTION controlp INFIELD oofc013 name="input.c.page1_azzi930_01.oofc013"
            
            #END add-point
 
 
 
 
         #自訂ACTION
         #add-point:單身其他段落處理(EX:on row change, etc...) name="input.other"
         
         #end add-point
 
         AFTER INPUT
            #add-point:單身輸入後處理 name="input.after_input"
            LET g_oofc_d2.* = g_oofc_d.*
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
   
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_azzi930_01 
   
   #add-point:input段after input name="input.post_input"
   CLOSE azzi930_01_bcl
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="azzi930_01.other_dialog" readonly="Y" >}
################################################################################
# Descriptions...: 被主程式嵌入的通訊資料顯示模式
# Memo...........: 
# Usage..........: CALL azzi930_01_display()
# Input parameter: None
# Return code....: None
# Date & Author..: 2014/02/24 By Saki
# Modify.........:
################################################################################
DIALOG azzi930_01_display()
   DISPLAY ARRAY g_oofc_d TO s_detail1_azzi930_01.* ATTRIBUTE(COUNT=g_d_cnt_i35002)
      BEFORE DISPLAY
         CALL FGL_SET_ARR_CURR(g_d_idx_i35002)
         #單身不連動, 所以進入單身時, 要重新顯示單身筆數
         DISPLAY g_d_idx_i35002, g_d_cnt_i35002 TO FORMONLY.idx, FORMONLY.cnt
      BEFORE ROW
         LET g_d_idx_i35002 = DIALOG.getCurrentRow("s_detail1_azzi930_01")
         DISPLAY g_d_idx_i35002 TO FORMONLY.idx
         # 點的當筆放入g_appoint_idx中, 可讓雙擊直接進入指定筆
         LET g_appoint_idx = g_d_idx_i35002
      AFTER DISPLAY
         LET g_oofc_d2.* = g_oofc_d.*
   END DISPLAY
END DIALOG
################################################################################
# Descriptions...: 被主程式嵌入的通訊方式查詢模式
# Memo...........: 
# Usage..........: CALL azzi930_01_construct()
# Input parameter: None
# Return code....: None
# Date & Author..: 2014/02/24 By Saki
# Modify.........:
################################################################################
DIALOG azzi930_01_construct()
   DEFINE ls_result   STRING

   CONSTRUCT g_wc2_i35002 ON oofcstus,oofc001,oofc008,oofc009,oofc010,
                             oofc014,oofc011,oofc012,oofc013,oofc015
        FROM s_detail1_azzi930_01[1].oofcstus,s_detail1_azzi930_01[1].oofc001,
             s_detail1_azzi930_01[1].oofc008,s_detail1_azzi930_01[1].oofc009,
             s_detail1_azzi930_01[1].oofc010,s_detail1_azzi930_01[1].oofc014,
             s_detail1_azzi930_01[1].oofc011,s_detail1_azzi930_01[1].oofc012,
             s_detail1_azzi930_01[1].oofc013,s_detail1_azzi930_01[1].oofc015

      AFTER FIELD oofccrtdt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)

      AFTER FIELD oofcmoddt
            CALL FGL_DIALOG_GETBUFFER() RETURNING ls_result
            IF NOT cl_null(ls_result) THEN
               IF NOT cl_chk_date_symbol(ls_result) THEN
                  LET ls_result = cl_add_date_extra_cond(ls_result)
               END IF
            END IF
            CALL FGL_DIALOG_SETBUFFER(ls_result)

      ON ACTION controlp INFIELD oofc009
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
			LET g_qryparam.reqry = FALSE
            #給予arg
            LET g_qryparam.arg1 = "3" #
            CALL q_oocq002()    
            DISPLAY g_qryparam.return1 TO oofc009  #顯示到畫面上

            NEXT FIELD oofc009
   END CONSTRUCT
END DIALOG
################################################################################
# Descriptions...: 被主程式嵌入的通訊方式輸入模式
# Memo...........: 
# Usage..........: CALL azzi930_01_input()
# Input parameter: None
# Return code....: None
# Date & Author..: 2014/02/24 By Saki
# Modify.........:
################################################################################
DIALOG azzi930_01_input()
   {<Local define>}
   DEFINE l_ac_t          LIKE type_t.num5        #未取消的ARRAY CNT 
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num5
   DEFINE l_insert        LIKE type_t.num5
   DEFINE l_cmd           LIKE type_t.chr5
   {</Local define>}
   #add-point:input段define
   DEFINE l_oofc         RECORD LIKE oofc_t.*
   DEFINE l_forupd_sql   STRING
   DEFINE l_lock_sw      LIKE type_t.chr1 
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_n            LIKE type_t.num5
   DEFINE l_wc           STRING
   #end add-point  

      INPUT ARRAY g_oofc_d FROM s_detail1_azzi930_01.*
          ATTRIBUTE(COUNT = g_d_cnt_i35002,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                  INSERT ROW = g_detail_insert,
                  DELETE ROW = g_detail_delete,
                  APPEND ROW = g_detail_insert)
         
         #自訂ACTION
         #add-point:單身前置處理

         #end add-point
         
         #自訂ACTION(detail_input)
         
         
         BEFORE INPUT
            #add-point:單身輸入前處理
            LET l_forupd_sql = " SELECT oofcstus,oofc001,oofc008,oofc009,'',oofc012,oofc010,oofc014,oofc011,oofc015,oofc013 ",
                      "   FROM oofc_t WHERE oofcent = '",g_enterprise,"' AND oofc002 = '",g_pmaa027_d,"'AND oofc001 = ? FOR UPDATE"
            LET l_forupd_sql = cl_sql_forupd(l_forupd_sql)  
            PREPARE azzi930_01_dialog_b FROM l_forupd_sql
            DECLARE azzi930_01_dialog_bcl CURSOR FOR azzi930_01_dialog_b 
            IF g_appoint_idx > 0 THEN
               CALL DIALOG.setCurrentRow("s_detail1_azzi930_01",g_appoint_idx)
            END IF
         BEFORE ROW
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            LET g_rec_b = g_oofc_d.getLength()
            
            IF g_rec_b >= l_ac THEN  
               LET l_cmd='u'
               LET g_oofc_d_t.* = g_oofc_d[l_ac].*  #BACKUP
               CALL azzi930_01_set_entry_b()
               CALL azzi930_01_set_no_entry_b()
               
               OPEN azzi930_01_dialog_bcl USING g_oofc_d[l_ac].oofc001
               IF SQLCA.sqlcode THEN
                  LET l_lock_sw='Y'
               ELSE
                  FETCH azzi930_01_dialog_bcl INTO g_oofc_d[l_ac].oofcstus,g_oofc_d[l_ac].oofc001,g_oofc_d[l_ac].oofc008,g_oofc_d[l_ac].oofc009,g_oofc_d[l_ac].oofc009_desc,
                                                   g_oofc_d[l_ac].oofc012,g_oofc_d[l_ac].oofc010,g_oofc_d[l_ac].oofc014,g_oofc_d[l_ac].oofc011,g_oofc_d[l_ac].oofc015,g_oofc_d[l_ac].oofc013
                  IF SQLCA.sqlcode THEN
                     LET l_lock_sw = "Y"
                  END IF
                  INITIALIZE g_ref_fields TO NULL
                  LET g_ref_fields[1] = g_oofc_d[l_ac].oofc009
                  CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='3' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
                  LET g_oofc_d[l_ac].oofc009_desc = g_rtn_fields[1]
                 DISPLAY BY NAME g_oofc_d[l_ac].oofc009_desc                  
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            
         BEFORE INSERT
            CALL s_transaction_begin()
            LET l_cmd = 'a'
            INITIALIZE g_oofc_d_t.* TO NULL
            INITIALIZE g_oofc_d[l_ac].* TO NULL 
            
            LET g_oofc_d_t.* = g_oofc_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()   
            CALL azzi930_01_set_entry_b()
            CALL azzi930_01_set_no_entry_b()
               
            LET g_oofc_d[l_ac].oofcstus = 'Y'
            LET g_oofc_d[l_ac].oofc010 = 'N'
            LET g_oofc_d[l_ac].oofc015 = 'N'  #150904-00004 by whitney modify 'Y'->'N'
            
         AFTER INSERT
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
#               CANCEL INSERT
            END IF
            LET l_oofc.oofcent = g_enterprise
            LET l_oofc.oofcstus =g_oofc_d[l_ac].oofcstus
            LET l_success = NULL
            LET l_wc = " oofcent = '",g_enterprise,"' "
            CALL cl_s_aooi350_get_idno('oofc001','oofc_t',l_wc) RETURNING l_success,l_oofc.oofc001   #160509-00001#1
            LET l_oofc.oofc002 = g_pmaa027_d
            LET l_oofc.oofc008 = g_oofc_d[l_ac].oofc008
            LET l_oofc.oofc009 = g_oofc_d[l_ac].oofc009
            LET l_oofc.oofc010 = g_oofc_d[l_ac].oofc010 
            LET l_oofc.oofc011 = g_oofc_d[l_ac].oofc011
            LET l_oofc.oofc012 = g_oofc_d[l_ac].oofc012
            LET l_oofc.oofc013 = g_oofc_d[l_ac].oofc013
            LET l_oofc.oofc014 = g_oofc_d[l_ac].oofc014
            LET l_oofc.oofc015 = g_oofc_d[l_ac].oofc015
            LET l_oofc.oofcownid = g_user
            LET l_oofc.oofcowndp = g_dept
            LET l_oofc.oofccrtid = g_user
            LET l_oofc.oofccrtdp = g_dept 
            LET l_oofc.oofccrtdt = cl_get_current()
            LET l_oofc.oofcmodid = g_user
            LET l_oofc.oofcmoddt = cl_get_current()
            SELECT COUNT(*) INTO l_count FROM oofc_t 
             WHERE oofcent = g_enterprise AND oofc001 = l_oofc.oofc001  AND oofc002 = g_pmaa027_d
                        
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #INSERT INTO oofc_t VALUES(l_oofc.*)
               INSERT INTO oofc_t(oofcstus,oofcent,oofc001,oofc002,oofc003,oofc004,oofc005,oofc006,oofc007,oofc008,oofc009,oofc010,oofc011,oofc012,oofc013,oofc014,
                                  oofc015,
                                  oofcownid,oofcowndp,oofccrtid,oofccrtdp,oofccrtdt,oofcmodid,oofcmoddt) 
                VALUES(l_oofc.oofcstus,l_oofc.oofcent,l_oofc.oofc001,l_oofc.oofc002,l_oofc.oofc003,l_oofc.oofc004,l_oofc.oofc005,l_oofc.oofc006,l_oofc.oofc007,
                       l_oofc.oofc008, l_oofc.oofc009,l_oofc.oofc010,l_oofc.oofc011,l_oofc.oofc012,l_oofc.oofc013,l_oofc.oofc014,
                       l_oofc.oofc015,
                       l_oofc.oofcownid,l_oofc.oofcowndp,l_oofc.oofccrtid,l_oofc.oofccrtdp,l_oofc.oofccrtdt,l_oofc.oofcmodid,l_oofc.oofcmoddt)
                        
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "oofc_t"
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

               END IF
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_oofc_d[l_ac].* TO NULL
               CALL s_transaction_end('N',0)
#               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "oofc_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N',0)                   
#               CANCEL INSERT
            ELSE
              
               CALL s_transaction_end('Y',0)
               
               ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
 
        BEFORE DELETE                            #是否取消單身
            IF NOT cl_null(g_oofc_d[l_ac].oofc001) THEN

               #IF NOT cl_ask_del_detail() THEN
#              #    CANCEL DELETE
               #END IF
               IF cl_ask_del_detail() THEN
                  IF l_lock_sw = "Y" THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code =  -263
                     LET g_errparam.extend = ""
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  
#                     CANCEL DELETE
                  END IF
                  DELETE FROM oofc_t
                   WHERE oofcent = g_enterprise AND oofc001 = g_oofc_d[l_ac].oofc001 AND oofc002 = g_pmaa027_d
                  
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "oofc_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  
                     CALL s_transaction_end('N',0)
#                     CANCEL DELETE   
                  ELSE
                     LET g_rec_b = g_rec_b-1
                     
                     CALL s_transaction_end('Y',0)
                  END IF 
                  CLOSE azzi930_01_dialog_bcl
                  LET l_count = g_oofc_d.getLength()
               END IF
            END IF 
            
         AFTER DELETE
            CALL azzi930_01_b_fill(g_pmaa027_d)
            
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_oofc_d[l_ac].* = g_oofc_d_t.*
               CLOSE azzi930_01_dialog_bcl
               CALL s_transaction_end('N',0)
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = l_oofc.oofc001
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_oofc_d[l_ac].* = g_oofc_d_t.*
            ELSE
               UPDATE oofc_t SET (oofcstus,oofc008,oofc009,oofc014,oofc010,oofc011,oofc012,oofc013,oofc015)= (g_oofc_d[l_ac].oofcstus,g_oofc_d[l_ac].oofc008,g_oofc_d[l_ac].oofc009,g_oofc_d[l_ac].oofc014,g_oofc_d[l_ac].oofc010,g_oofc_d[l_ac].oofc011,g_oofc_d[l_ac].oofc012,g_oofc_d[l_ac].oofc013,g_oofc_d[l_ac].oofc015)
                WHERE oofcent = g_enterprise AND oofc001 = g_oofc_d[l_ac].oofc001 AND oofc002 = g_pmaa027_d 
 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "oofc_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
   
                  LET g_oofc_d[l_ac].* = g_oofc_d_t.*
                  CALL s_transaction_end('N',0)
               ELSE
                  CALL s_transaction_end('Y',0)               
               END IF

            END IF
            
         AFTER ROW
            CLOSE azzi930_01_dialog_bcl
              
            #end add-point
          
         #---------------------<  Detail: page1  >---------------------
         #----<<oofcstus>>----
         #此段落由子樣板a01產生
         BEFORE FIELD oofcstus
            #add-point:BEFORE FIELD oofcstus

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD oofcstus
            
            #add-point:AFTER FIELD oofcstus

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE oofcstus
            #add-point:ON CHANGE oofcstus

            #END add-point
 
         #----<<oofc001>>----
         #此段落由子樣板a01產生
         BEFORE FIELD oofc001
            #add-point:BEFORE FIELD oofc001

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD oofc001
            
            #add-point:AFTER FIELD oofc001
            #此段落由子樣板a05產生
            IF  g_oofc_d[g_detail_idx].oofc001 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_oofc_d[g_detail_idx].oofc001 != g_oofc_d_t.oofc001)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM oofc_t WHERE "||"oofcent = '" ||g_enterprise|| "' AND "||"oofc001 = '"||g_oofc_d[g_detail_idx].oofc001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE oofc001
            #add-point:ON CHANGE oofc001

            #END add-point
 
         #----<<oofc008>>----
         #此段落由子樣板a01產生
         BEFORE FIELD oofc008
            #add-point:BEFORE FIELD oofc008

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD oofc008
            
            #add-point:AFTER FIELD oofc008

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE oofc008
            #add-point:ON CHANGE oofc008
            CALL azzi930_01_set_entry_b()
            CALL azzi930_01_set_no_entry_b()
            #END add-point
 
         #----<<oofc009>>----
         #此段落由子樣板a02產生
         AFTER FIELD oofc009
            
            #add-point:AFTER FIELD oofc009
            IF NOT cl_null(g_oofc_d[l_ac].oofc009) THEN
               CALL azzi930_01_s_azzi650_chk_exist('3',g_oofc_d[l_ac].oofc009) RETURNING l_success #160509-00001#1
               IF NOT l_success THEN
                  LET g_oofc_d[l_ac].oofc009 = g_oofc_d_t.oofc009
                  LET g_oofc_d[l_ac].oofc009_desc = g_oofc_d_t.oofc009_desc
                  NEXT FIELD oofc009
               END IF   
            END IF   
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_oofc_d[l_ac].oofc009
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='3' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_oofc_d[l_ac].oofc009_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_oofc_d[l_ac].oofc009_desc

            #END add-point
            
 
         #此段落由子樣板a01產生
         BEFORE FIELD oofc009
            #add-point:BEFORE FIELD oofc009

            #END add-point
 
         #此段落由子樣板a04產生
         ON CHANGE oofc009
            #add-point:ON CHANGE oofc009

            #END add-point
 
         #----<<oofc010>>----
         #此段落由子樣板a01產生
         BEFORE FIELD oofc010
            #add-point:BEFORE FIELD oofc010

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD oofc010
            
            #add-point:AFTER FIELD oofc010
            IF NOT cl_null(g_oofc_d[l_ac].oofc008) AND g_oofc_d[l_ac].oofc010 = 'Y' THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_oofc_d[l_ac].oofc010 != g_oofc_d_t.oofc010))) THEN
                  LET l_n = 0
                  SELECT COUNT(*) INTO l_n FROM oofc_t
                  WHERE oofcent = g_enterprise
                    AND oofc002 = g_pmaa027_d
                    AND oofc008 = g_oofc_d[l_ac].oofc008
                    AND oofc010 = 'Y'
                   IF l_n > 0 THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = 'aoo-00153'
                      LET g_errparam.extend = g_oofc_d[l_ac].oofc010
                      LET g_errparam.popup = TRUE
                      CALL cl_err()

                      LET g_oofc_d[l_ac].oofc010 = 'N'
                      NEXT FIELD oofc010
                   END IF
                END IF
             END IF 
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE oofc010
            #add-point:ON CHANGE oofc010

            #END add-point
 
         #----<<oofc014>>----
         #此段落由子樣板a01產生
         BEFORE FIELD oofc014
            #add-point:BEFORE FIELD oofc014

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD oofc014
            
            #add-point:AFTER FIELD oofc014
            IF  NOT cl_null(g_oofc_d[l_ac].oofc014) THEN
                IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_oofc_d[l_ac].oofc014 != g_oofc_d_t.oofc014) OR g_oofc_d_t.oofc014 IS NULL)) THEN
                   IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM oofc_t WHERE "||"oofcent = '" ||g_enterprise|| "' AND "||"oofc002 = '"|| g_pmaa027_d || "' AND "||"oofc014 = '"||g_oofc_d[l_ac].oofc014 ||"'",'std-00004',1) THEN 
                       LET g_oofc_d[l_ac].oofc014 = g_oofc_d_t.oofc014
                       NEXT FIELD oofc014
                   END IF
                END IF
            END IF  
            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE oofc014
            #add-point:ON CHANGE oofc014

            #END add-point
 
         #----<<oofc011>>----
         #此段落由子樣板a01產生
         BEFORE FIELD oofc011
            #add-point:BEFORE FIELD oofc011

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD oofc011
            
            #add-point:AFTER FIELD oofc011

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE oofc011
            #add-point:ON CHANGE oofc011

            #END add-point
 
         #----<<oofc012>>----
         #此段落由子樣板a01產生
         BEFORE FIELD oofc012
            #add-point:BEFORE FIELD oofc012

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD oofc012
            
            #add-point:AFTER FIELD oofc012

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE oofc012
            #add-point:ON CHANGE oofc012

            #END add-point
 
         #----<<oofc013>>----
         #此段落由子樣板a01產生
         BEFORE FIELD oofc013
            #add-point:BEFORE FIELD oofc013

            #END add-point
 
         #此段落由子樣板a02產生
         AFTER FIELD oofc013
            
            #add-point:AFTER FIELD oofc013

            #END add-point
            
 
         #此段落由子樣板a04產生
         ON CHANGE oofc013
            #add-point:ON CHANGE oofc013

            #END add-point
 
 
         #---------------------<  Detail: page1  >---------------------
         #----<<oofcstus>>----
         #Ctrlp:input.c.page1_azzi930_01.oofcstus
         ON ACTION controlp INFIELD oofcstus
            #add-point:ON ACTION controlp INFIELD oofcstus

            #END add-point
 
         #----<<oofc001>>----
         #Ctrlp:input.c.page1_azzi930_01.oofc001
         ON ACTION controlp INFIELD oofc001
            #add-point:ON ACTION controlp INFIELD oofc001

            #END add-point
 
         #----<<oofc008>>----
         #Ctrlp:input.c.page1_azzi930_01.oofc008
         ON ACTION controlp INFIELD oofc008
            #add-point:ON ACTION controlp INFIELD oofc008

            #END add-point
 
         #----<<oofc009>>----
         #Ctrlp:input.c.page1_azzi930_01.oofc009
         ON ACTION controlp INFIELD oofc009
            #add-point:ON ACTION controlp INFIELD oofc009
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_oofc_d[l_ac].oofc009             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "3" #

            CALL q_oocq002()                                #呼叫開窗

            LET g_oofc_d[l_ac].oofc009 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_oofc_d[l_ac].oofc009 TO oofc009              #顯示到畫面上

            NEXT FIELD oofc009                          #返回原欄位


            #END add-point
 
         #----<<oofc010>>----
         #Ctrlp:input.c.page1_azzi930_01.oofc010
         ON ACTION controlp INFIELD oofc010
            #add-point:ON ACTION controlp INFIELD oofc010

            #END add-point
 
         #----<<oofc014>>----
         #Ctrlp:input.c.page1_azzi930_01.oofc014
         ON ACTION controlp INFIELD oofc014
            #add-point:ON ACTION controlp INFIELD oofc014

            #END add-point
 
         #----<<oofc011>>----
         #Ctrlp:input.c.page1_azzi930_01.oofc011
         ON ACTION controlp INFIELD oofc011
            #add-point:ON ACTION controlp INFIELD oofc011

            #END add-point
 
         #----<<oofc012>>----
         #Ctrlp:input.c.page1_azzi930_01.oofc012
         ON ACTION controlp INFIELD oofc012
            #add-point:ON ACTION controlp INFIELD oofc012

            #END add-point
 
         #----<<oofc013>>----
         #Ctrlp:input.c.page1_azzi930_01.oofc013
         ON ACTION controlp INFIELD oofc013
            #add-point:ON ACTION controlp INFIELD oofc013

            #END add-point
 
 
 
         AFTER INPUT
            #add-point:單身輸入後處理
            LET g_pmba2_d.* = g_oofc_d.*
            LET g_oofc_d2.* = g_oofc_d.*
            #end add-point
            
      END INPUT  

END DIALOG

 
{</section>}
 
{<section id="azzi930_01.other_function" readonly="Y" >}
#  連動lock其他單身table資料
PRIVATE FUNCTION azzi930_01_lock_b(p_ac)
   DEFINE p_ac  LIKE type_t.num5

      OPEN azzi930_01_bcl USING g_oofc_d[p_ac].oofc001

      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "azzi930_01_bcl"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         RETURN FALSE
      END IF
   RETURN TRUE
END FUNCTION
#+ 連動unlock其他單身table資料
PRIVATE FUNCTION azzi930_01_unlock_b()
   CLOSE azzi930_01_bcl
END FUNCTION
# 單身陣列填充
PUBLIC FUNCTION azzi930_01_b_fill(p_oofc002)
  DEFINE l_sql      STRING
   DEFINE p_oofc002   LIKE oofc_t.oofc002
   DEFINE l_ac1      LIKE type_t.num5
   LET l_sql = " SELECT oofcstus,oofc001,oofc008,oofc009,'',oofc012,oofc010,oofc014,oofc011,oofc015,oofc013 FROM oofc_t ",
               "  WHERE oofcent = '",g_enterprise,"' AND oofc002 = '",p_oofc002,"'" 
   IF NOT cl_null(g_wc2_i35002) THEN
      LET l_sql = l_sql CLIPPED, " AND ", g_wc2_i35002 CLIPPED
   END IF
   LET l_sql = l_sql, " ORDER BY oofc008,oofc009 " 
   PREPARE azzi930_01_pb FROM l_sql
   DECLARE b_fill_curs CURSOR FOR azzi930_01_pb 
   
   CALL g_oofc_d.clear()
   LET l_ac1 = 1
   FOREACH b_fill_curs INTO g_oofc_d[l_ac1].oofcstus,g_oofc_d[l_ac1].oofc001,g_oofc_d[l_ac1].oofc008,g_oofc_d[l_ac1].oofc009,g_oofc_d[l_ac1].oofc009_desc,
                            g_oofc_d[l_ac1].oofc012, g_oofc_d[l_ac1].oofc010,g_oofc_d[l_ac1].oofc014,g_oofc_d[l_ac1].oofc011,g_oofc_d[l_ac1].oofc015,g_oofc_d[l_ac1].oofc013
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      INITIALIZE g_ref_fields TO NULL
      LET g_ref_fields[1] = g_oofc_d[l_ac1].oofc009
      CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='3' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
      LET g_oofc_d[l_ac1].oofc009_desc = g_rtn_fields[1]
      DISPLAY BY NAME g_oofc_d[l_ac1].oofc009_desc
      LET l_ac1 = l_ac1 + 1
      IF l_ac1 > g_max_rec THEN
         #CALL cl_err( "", 9035, 0 )
         EXIT FOREACH
      END IF
      
   END FOREACH 
   CALL g_oofc_d.deleteElement(g_oofc_d.getLength())   
   LET g_rec_b = l_ac1 - 1
   DISPLAY g_rec_b TO FORMONLY.cnt
   LET g_pmba2_d.* = g_oofc_d.*
   #將總筆數, 目前筆數指定到共用變數中
   IF g_rec_b > 0 THEN
      LET g_d_idx_i35002 = 1
   ELSE
      LET g_d_idx_i35002 = 0
   END IF
   LET g_d_cnt_i35002 = g_rec_b
   LET g_oofc_d2.* = g_oofc_d.*
   CLOSE b_fill_curs
   FREE azzi930_01_pb
END FUNCTION
################################################################################
# Descriptions...: 清除畫面上通訊方式單身
# Memo...........: 
# Usage..........: CALL azzi930_01_clear_detail()
# Input parameter: None
# Return code....: None
# Date & Author..: 2014/02/24 By Saki
# Modify.........:
################################################################################
PUBLIC FUNCTION azzi930_01_clear_detail()
   CALL g_oofc_d.clear()
END FUNCTION

PRIVATE FUNCTION azzi930_01_set_entry_b()

    CALL cl_set_comp_entry("oofc015",TRUE)

END FUNCTION

PRIVATE FUNCTION azzi930_01_set_no_entry_b()

    #通訊類型="電子郵件"時，"寄發郵件"可輸
    IF g_oofc_d[l_ac].oofc008 <> '4' THEN
       CALL cl_set_comp_entry("oofc015",FALSE)
    END IF
    
END FUNCTION

################################################################################
# Descriptions...: 獲取程式編號
# Memo...........:
# Usage..........: CALL s_azzi650_chk_exit_get_program(p_gzzz004)
#                  RETURNING r_msg
# Input parameter: p_gzzz004   應用分類
# Return code....: r_msg       程式編號
# Date & Author..: 2013/12/03 By zhangllc
# Modify.........: No.160509-00001#1 2016/05/19 By tsai_yen copy
################################################################################
PRIVATE FUNCTION azzi930_01_s_azzi650_chk_exit_get_program(p_gzzz004)
DEFINE p_gzzz004   LIKE gzzz_t.gzzz004
DEFINE l_gzzz001   LIKE gzzz_t.gzzz001   #作业编号
DEFINE l_gzzal003  LIKE gzzal_t.gzzal003 #作业名称
DEFINE r_msg       STRING
DEFINE l_sql       STRING

   #160310-00019#8 Add By Ken 160412(S) 使用實體4gl搭配ACC碼時，需自行到這裡新增對應的作業名稱回稱
   CASE
      WHEN p_gzzz004 = '2002'
         SELECT gzzal003 INTO l_gzzal003
           FROM gzzal_t
          WHERE gzzal001 = 'arti003'
            AND gzzal002 = g_lang
          LET r_msg = l_gzzal003,'[arti003]' CLIPPED
          RETURN r_msg
   END CASE
   #160310-00019#8 Add By Ken 160412(E)

   CALL azzi930_01_s_chr_add_quotes(p_gzzz004) RETURNING p_gzzz004   #160509-00001#1

   LET l_sql = "SELECT gzzz001 FROM gzzz_t ",
               " WHERE (gzzz002 = 'aooi300' OR gzzz002 = 'aooi310' OR gzzz002 = 'aooi301' ) ",
               "   AND gzzz004 = '",p_gzzz004,"' "
   DECLARE azzi930_01_s_azzi650_chk_exit_get_program_c SCROLL CURSOR FROM l_sql
   OPEN azzi930_01_s_azzi650_chk_exit_get_program_c
   FETCH FIRST azzi930_01_s_azzi650_chk_exit_get_program_c INTO l_gzzz001
   CLOSE azzi930_01_s_azzi650_chk_exit_get_program_c

   IF cl_null(l_gzzz001) THEN
      LET r_msg = '[aooi301]'
      RETURN r_msg
   END IF

   LET r_msg = '[',l_gzzz001,']'
   SELECT gzzal003 INTO l_gzzal003
     FROM gzzal_t
    WHERE gzzal001=l_gzzz001
      AND gzzal002=g_lang


   IF cl_null(l_gzzal003) THEN RETURN r_msg END IF
   LET r_msg = l_gzzal003,r_msg CLIPPED
   RETURN r_msg
END FUNCTION

################################################################################
# Descriptions...: 檢查是否存在此應用分類碼(ACC)資料
# Memo...........:
# Usage..........: CALL s_azzi650_chk_exist(p_oocq001,p_oocq002)
#                  RETURNING r_success
# Input parameter: p_oocq001   應用分類
#                : p_oocq002   應用分類碼
# Return code....: r_success   處理狀態TRUE/FALSE
# Date & Author..: 2013/12/03 By zhangllc
# Modify.........: No.160509-00001#1 2016/05/19 By tsai_yen copy
################################################################################
PRIVATE FUNCTION azzi930_01_s_azzi650_chk_exist(p_oocq001,p_oocq002)
DEFINE p_oocq001   LIKE oocq_t.oocq001
DEFINE p_oocq002   LIKE oocq_t.oocq002
DEFINE r_success   LIKE type_t.num5
DEFINE l_oocqstus  LIKE oocq_t.oocqstus
DEFINE l_msg       STRING

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE

   IF cl_null(p_oocq001) OR cl_null(p_oocq002) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00001'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF

   SELECT oocqstus INTO l_oocqstus FROM oocq_t
    WHERE oocqent = g_enterprise
      AND oocq001 = p_oocq001
      AND oocq002 = p_oocq002
   CASE WHEN l_oocqstus = 'N'
             CALL azzi930_01_s_azzi650_chk_exit_get_program(p_oocq001) RETURNING l_msg   #160509-00001#1
             #资料在作业%1中无效,请检查！  请维护后,重新输入！
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'sub-00295'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             LET g_errparam.replace[1] = l_msg
             #dorislai-20150630-add----(S)
             LET g_errparam.exeprog = l_msg.subString(l_msg.getIndexOf("[",1)+1,l_msg.getIndexOf("[",1)+7)
             #dorislai-20150630-add----(E)
             CALL cl_err()

             LET r_success = FALSE
        WHEN SQLCA.sqlcode = 100
             CALL azzi930_01_s_azzi650_chk_exit_get_program(p_oocq001) RETURNING l_msg   #160509-00001#1
             #资料不存在于作业%1中,请检查！  请维护后,重新输入！
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'sub-00294'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             LET g_errparam.replace[1] = l_msg
             #dorislai-20150630-add----(S)
             LET g_errparam.exeprog = l_msg.subString(l_msg.getIndexOf("[",1)+1,l_msg.getIndexOf("[",1)+7)
             #dorislai-20150630-add----(E)
             CALL cl_err()

             LET r_success = FALSE
        WHEN SQLCA.SQLCODE != 0
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = SQLCA.SQLCODE
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE
             CALL cl_err()

             LET r_success = FALSE
   END CASE

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 將傳入的變數值前後加上雙引號(")
# Memo...........:
# Usage..........: CALL s_chr_add_quotes(p_param)
#                  RETURNING r_str
# Input parameter: p_param     傳入參數
# Return code....: r_str       處理後的參數值
# Date & Author..: 14/04/17 By zhangllc
# Modify.........: No.160509-00001#1 2016/05/19 By tsai_yen copy from s_chr_add_quotes
################################################################################
PRIVATE FUNCTION azzi930_01_s_chr_add_quotes(p_param)
   DEFINE p_param        STRING
   DEFINE r_str          STRING

   LET r_str = p_param
   LET r_str = r_str.trim()
   IF cl_null(r_str) THEN
      RETURN r_str
   END IF
   IF NOT r_str.getIndexOf("\"",1) THEN
      LET r_str = "\"",r_str,"\""
   END IF
   RETURN r_str
END FUNCTION

 
{</section>}
 
