#該程式未解開Section, 採用最新樣板產出!
{<section id="axmt500_03.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2014-09-11 11:20:40), PR版次:0003(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000222
#+ Filename...: axmt500_03
#+ Description: 維護訂單多交期明細子作業
#+ Creator....: 02040(2014-02-11 10:45:34)
#+ Modifier...: 02040 -SD/PR- 00000
 
{</section>}
 
{<section id="axmt500_03.global" >}
#應用 c02b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#Memos
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

#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_xmdf_d        RECORD
       xmdfsite LIKE xmdf_t.xmdfsite, 
   xmdfdocno LIKE xmdf_t.xmdfdocno, 
   xmdfseq LIKE xmdf_t.xmdfseq, 
   xmdfseq2 LIKE xmdf_t.xmdfseq2, 
   xmdf007 LIKE xmdf_t.xmdf007, 
   xmdf002 LIKE xmdf_t.xmdf002, 
   xmdf003 LIKE xmdf_t.xmdf003, 
   xmdf004 LIKE xmdf_t.xmdf004, 
   xmdf005 LIKE xmdf_t.xmdf005, 
   xmdf005_desc LIKE type_t.chr500, 
   xmdf006 LIKE xmdf_t.xmdf006
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_xmdfdocno     LIKE xmdf_t.xmdfdocno
DEFINE g_xmdfseq       LIKE xmdf_t.xmdfseq 
#end add-point
 
DEFINE g_xmdf_d          DYNAMIC ARRAY OF type_g_xmdf_d
DEFINE g_xmdf_d_t        type_g_xmdf_d
 
 
DEFINE g_xmdfdocno_t   LIKE xmdf_t.xmdfdocno    #Key值備份
DEFINE g_xmdfseq_t      LIKE xmdf_t.xmdfseq    #Key值備份
DEFINE g_xmdfseq2_t      LIKE xmdf_t.xmdfseq2    #Key值備份
 
 
DEFINE l_ac                  LIKE type_t.num10
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_ref_vars            DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rec_b               LIKE type_t.num10 
DEFINE g_detail_idx          LIKE type_t.num10
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
    
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point    
 
{</section>}
 
{<section id="axmt500_03.input" >}
#+ 資料輸入
PUBLIC FUNCTION axmt500_03(--)
   #add-point:input段變數傳入 name="input.get_var"
          p_xmdfdocno,p_xmdfseq,p_xmdc007
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
   DEFINE p_xmdfdocno     LIKE xmdf_t.xmdfdocno
   DEFINE p_xmdfseq       LIKE xmdf_t.xmdfseq
   DEFINE p_xmdc007       LIKE xmdc_t.xmdc007
   DEFINE r_xmdf005       LIKE xmdf_t.xmdf005
   DEFINE l_lock_sw       LIKE type_t.chr1
   DEFINE l_forupd_sql    STRING
   DEFINE l_n             LIKE type_t.num5                #檢查重複用  
   DEFINE l_cnt           LIKE type_t.num5
   DEFINE l_i             LIKE type_t.num5
   DEFINE l_xmdf002       LIKE xmdf_t.xmdf002
   DEFINE l_xmdf003       LIKE xmdf_t.xmdf003
   DEFINE r_xmdf003       LIKE xmdf_t.xmdf003    #約定交貨日期
   DEFINE r_xmdf004       LIKE xmdf_t.xmdf004    #預計簽收日
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_axmt500_03 WITH FORM cl_ap_formpath("axm","axmt500_03")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #輸入前處理
   #add-point:單身前置處理 name="input.pre_input"
   WHENEVER ERROR CONTINUE


   LET r_xmdf003 = ''
   LET r_xmdf004 = ''
   
   #必須包在transaction裡面
   IF NOT s_transaction_chk('Y',1) THEN
      RETURN r_xmdf003,r_xmdf004
   END IF

   IF cl_null(p_xmdfdocno)  THEN
      #傳入單據編號為空;請指定單據編號!
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00228'
      LET g_errparam.extend = p_xmdfdocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_xmdf003,r_xmdf004   
   END IF
   IF cl_null(p_xmdfseq) THEN
      #傳入的項次為空！
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'sub-00279'
      LET g_errparam.extend = p_xmdfdocno
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN r_xmdf003,r_xmdf004    
   END IF
   
   LET g_xmdfdocno = p_xmdfdocno
   LET g_xmdfseq = p_xmdfseq
   
   CALL cl_set_combo_scc_part('xmdf007','2057','1,2')
   
   LET INT_FLAG = FALSE
   
   LET l_forupd_sql = "SELECT xmdfsite,xmdfdocno,xmdfseq,xmdfseq2,xmdf007,",
                      "       xmdf002,xmdf003,xmdf004,xmdf005,'',xmdf006",
                      "  FROM xmdf_t",
                      " WHERE xmdfent = ? AND xmdfdocno = ? AND xmdfseq = ? AND xmdfseq2 = ? FOR UPDATE"
   LET l_forupd_sql = cl_sql_forupd(l_forupd_sql)
   DECLARE axmt500_03_bcl CURSOR FROM l_forupd_sql


   WHILE TRUE 
   CALL axmt500_03_b_fill()
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT ARRAY g_xmdf_d FROM s_detail1.*
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
            LET g_rec_b = g_xmdf_d.getLength()
            
          BEFORE ROW 
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET g_detail_idx = l_ac
            LET l_lock_sw = 'N'            #DEFAULT
            LET l_n = ARR_COUNT()
            DISPLAY l_ac TO FORMONLY.idx
         
  
            LET g_rec_b = g_xmdf_d.getLength()
            
            IF g_rec_b >= l_ac AND NOT cl_null(g_xmdf_d[l_ac].xmdfdocno)
               AND NOT cl_null(g_xmdf_d[l_ac].xmdfseq) 
               AND NOT cl_null(g_xmdf_d[l_ac].xmdfseq2) 
            THEN
               LET l_cmd = 'u'
			      LET g_xmdf_d_t.* = g_xmdf_d[l_ac].*  #BACKUP			   
			      OPEN axmt500_03_bcl USING g_enterprise,g_xmdf_d[l_ac].xmdfdocno,g_xmdf_d[l_ac].xmdfseq,g_xmdf_d[l_ac].xmdfseq2
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "axmt500_03_bcl"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET l_lock_sw='Y'
               ELSE
                  FETCH axmt500_03_bcl INTO g_xmdf_d[l_ac].xmdfsite,g_xmdf_d[l_ac].xmdfdocno,g_xmdf_d[l_ac].xmdfseq,
                                            g_xmdf_d[l_ac].xmdfseq2,g_xmdf_d[l_ac].xmdf007,g_xmdf_d[l_ac].xmdf002,
                                            g_xmdf_d[l_ac].xmdf003,g_xmdf_d[l_ac].xmdf004,g_xmdf_d[l_ac].xmdf005,
                                            g_xmdf_d[l_ac].xmdf005_desc,g_xmdf_d[l_ac].xmdf006
                  
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = g_xmdf_d[l_ac].xmdfdocno
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET l_lock_sw = "Y"
                  END IF
				      CALL s_desc_get_acc_desc('274',g_xmdf_d[l_ac].xmdf005) RETURNING g_xmdf_d[l_ac].xmdf005_desc
                  DISPLAY BY NAME g_xmdf_d[l_ac].xmdf005_desc
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd = 'a'
            END IF
        
         BEFORE INSERT
            LET l_insert = TRUE
            LET l_n = ARR_COUNT()
            INITIALIZE g_xmdf_d[l_ac].* TO NULL          
                     
            SELECT MAX(xmdfseq2)+1 INTO g_xmdf_d[l_ac].xmdfseq2 
              FROM xmdf_t 
             WHERE xmdfent = g_enterprise 
               AND xmdfdocno = g_xmdfdocno 
               AND xmdfseq = g_xmdfseq
            IF cl_null(g_xmdf_d[l_ac].xmdfseq2) OR g_xmdf_d[l_ac].xmdfseq2 = 0 THEN
               LET g_xmdf_d[l_ac].xmdfseq2 = 1
            END IF 
            IF g_xmdf_d[l_ac].xmdfseq2 > 1 THEN
               LET l_xmdf002 = 0
               CALL axmt500_03_get_xmdf002(g_xmdf_d[l_ac].xmdfseq2,p_xmdc007) RETURNING l_xmdf002
               IF l_xmdf002 = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'axm-00415'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CANCEL INSERT
               ELSE
                  LET g_xmdf_d[l_ac].xmdf002 = l_xmdf002
               END IF
            END IF
            LET g_xmdf_d[l_ac].xmdfsite = g_site
            LET g_xmdf_d[l_ac].xmdfdocno = g_xmdfdocno
            LET g_xmdf_d[l_ac].xmdfseq = g_xmdfseq            
            LET g_xmdf_d[l_ac].xmdf006 = 'N'
            LET g_xmdf_d[l_ac].xmdf007 = '1'           
            LET g_xmdf_d_t.* = g_xmdf_d[l_ac].*     #新輸入資料
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
            SELECT COUNT(*) INTO l_count FROM xmdf_t 
             WHERE xmdfent = g_enterprise 
               AND xmdfdocno = g_xmdf_d[l_ac].xmdfdocno
               AND xmdfseq = g_xmdf_d[l_ac].xmdfseq
               AND xmdfseq2 = g_xmdf_d[l_ac].xmdfseq2
      
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               INSERT INTO xmdf_t (xmdfent,xmdfsite,xmdfdocno,xmdfseq,xmdfseq2,xmdf002,xmdf003,xmdf004,xmdf005,xmdf006,xmdf007)
                  VALUES (g_enterprise,g_site,g_xmdf_d[l_ac].xmdfdocno,g_xmdf_d[l_ac].xmdfseq,g_xmdf_d[l_ac].xmdfseq2,
                          g_xmdf_d[l_ac].xmdf002,g_xmdf_d[l_ac].xmdf003,g_xmdf_d[l_ac].xmdf004,g_xmdf_d[l_ac].xmdf005,
                          g_xmdf_d[l_ac].xmdf006,g_xmdf_d[l_ac].xmdf007)
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()
               INITIALIZE g_xmdf_d[l_ac].* TO NULL
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "xmdf_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()                  
               CANCEL INSERT
            ELSE
               ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
            
              
         BEFORE DELETE                            #是否取消單身
            IF NOT cl_null(g_xmdf_d[l_ac].xmdfdocno)
               AND NOT cl_null(g_xmdf_d[l_ac].xmdfseq) 
               AND NOT cl_null(g_xmdf_d[l_ac].xmdfseq2) THEN 
               
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

               DELETE FROM xmdf_t
                WHERE xmdfent = g_enterprise 
                  AND xmdfdocno = g_xmdf_d_t.xmdfdocno
                  AND xmdfseq = g_xmdf_d_t.xmdfseq
                  AND xmdfseq2 = g_xmdf_d_t.xmdfseq2

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "xmdf_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  CANCEL DELETE   
               END IF 
               CLOSE axmt500_03_bcl
               LET l_count = g_xmdf_d.getLength()
            END IF 
            
        ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()
               LET INT_FLAG = 0
               LET g_xmdf_d[l_ac].* = g_xmdf_d_t.*
               CLOSE axmt500_03_bcl
               EXIT DIALOG
            END IF

            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = g_xmdf_d[l_ac].xmdf002
               LET g_errparam.popup = TRUE
               CALL cl_err()
               LET g_xmdf_d[l_ac].* = g_xmdf_d_t.*
            ELSE
               UPDATE xmdf_t 
                  SET (xmdfseq2,xmdf002,xmdf003,xmdf004,xmdf005,xmdf006,xmdf007)
                    = (g_xmdf_d[l_ac].xmdfseq2,g_xmdf_d[l_ac].xmdf002,g_xmdf_d[l_ac].xmdf003,
                       g_xmdf_d[l_ac].xmdf004,g_xmdf_d[l_ac].xmdf005,g_xmdf_d[l_ac].xmdf006,
                       g_xmdf_d[l_ac].xmdf007)
                WHERE xmdfent = g_enterprise 
                  AND xmdfdocno = g_xmdf_d_t.xmdfdocno
                  AND xmdfseq = g_xmdf_d_t.xmdfseq
                  AND xmdfseq2 = g_xmdf_d_t.xmdfseq2

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "xmdf_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_xmdf_d[l_ac].* = g_xmdf_d_t.*
               END IF
            END IF
            

         AFTER ROW
            CLOSE axmt500_03_bcl

            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdfsite
            #add-point:BEFORE FIELD xmdfsite name="input.b.page1.xmdfsite"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdfsite
            
            #add-point:AFTER FIELD xmdfsite name="input.a.page1.xmdfsite"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdfsite
            #add-point:ON CHANGE xmdfsite name="input.g.page1.xmdfsite"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdfdocno
            #add-point:BEFORE FIELD xmdfdocno name="input.b.page1.xmdfdocno"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdfdocno
            
            #add-point:AFTER FIELD xmdfdocno name="input.a.page1.xmdfdocno"
            #此段落由子樣板a05產生
            IF  g_xmdf_d[g_detail_idx].xmdfdocno IS NOT NULL AND g_xmdf_d[g_detail_idx].xmdfseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xmdf_d[g_detail_idx].xmdfdocno != g_xmdf_d_t.xmdfdocno OR g_xmdf_d[g_detail_idx].xmdfseq != g_xmdf_d_t.xmdfseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmdf_t WHERE "||"xmdfent = '" ||g_enterprise|| "' AND "||"xmdfdocno = '"||g_xmdf_d[g_detail_idx].xmdfdocno ||"' AND "|| "xmdfseq = '"||g_xmdf_d[g_detail_idx].xmdfseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdfdocno
            #add-point:ON CHANGE xmdfdocno name="input.g.page1.xmdfdocno"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdfseq
            #add-point:BEFORE FIELD xmdfseq name="input.b.page1.xmdfseq"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdfseq
            
            #add-point:AFTER FIELD xmdfseq name="input.a.page1.xmdfseq"
            #此段落由子樣板a05產生
            IF  g_xmdf_d[g_detail_idx].xmdfdocno IS NOT NULL AND g_xmdf_d[g_detail_idx].xmdfseq IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xmdf_d[g_detail_idx].xmdfdocno != g_xmdf_d_t.xmdfdocno OR g_xmdf_d[g_detail_idx].xmdfseq != g_xmdf_d_t.xmdfseq)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmdf_t WHERE "||"xmdfent = '" ||g_enterprise|| "' AND "||"xmdfdocno = '"||g_xmdf_d[g_detail_idx].xmdfdocno ||"' AND "|| "xmdfseq = '"||g_xmdf_d[g_detail_idx].xmdfseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdfseq
            #add-point:ON CHANGE xmdfseq name="input.g.page1.xmdfseq"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdfseq2
            #add-point:BEFORE FIELD xmdfseq2 name="input.b.page1.xmdfseq2"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdfseq2
            
            #add-point:AFTER FIELD xmdfseq2 name="input.a.page1.xmdfseq2"
            #此段落由子樣板a05產生
            IF  g_xmdf_d[g_detail_idx].xmdfdocno IS NOT NULL AND g_xmdf_d[g_detail_idx].xmdfseq IS NOT NULL AND g_xmdf_d[g_detail_idx].xmdfseq2 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xmdf_d[g_detail_idx].xmdfdocno != g_xmdf_d_t.xmdfdocno OR g_xmdf_d[g_detail_idx].xmdfseq != g_xmdf_d_t.xmdfseq OR g_xmdf_d[g_detail_idx].xmdfseq2 != g_xmdf_d_t.xmdfseq2)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xmdf_t WHERE "||"xmdfent = '" ||g_enterprise|| "' AND "||"xmdfdocno = '"||g_xmdf_d[g_detail_idx].xmdfdocno ||"' AND "|| "xmdfseq = '"||g_xmdf_d[g_detail_idx].xmdfseq ||"' AND "|| "xmdfseq2 = '"||g_xmdf_d[g_detail_idx].xmdfseq2 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdfseq2
            #add-point:ON CHANGE xmdfseq2 name="input.g.page1.xmdfseq2"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdf007
            #add-point:BEFORE FIELD xmdf007 name="input.b.page1.xmdf007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdf007
            
            #add-point:AFTER FIELD xmdf007 name="input.a.page1.xmdf007"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdf007
            #add-point:ON CHANGE xmdf007 name="input.g.page1.xmdf007"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdf002
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_xmdf_d[l_ac].xmdf002,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD xmdf002
            END IF 
 
 
 
            #add-point:AFTER FIELD xmdf002 name="input.a.page1.xmdf002"
            IF NOT cl_null(g_xmdf_d[l_ac].xmdf002) THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xmdf_d[l_ac].xmdf002 != g_xmdf_d_t.xmdf002 OR cl_null(g_xmdf_d_t.xmdf002))) THEN
                  LET l_xmdf002 = 0
                  CALL axmt500_03_get_xmdf002(g_xmdf_d[l_ac].xmdfseq2,p_xmdc007) RETURNING l_xmdf002                  
                  #分批數量總合+本分批數量不可以大於訂購數量
                  IF l_xmdf002 - g_xmdf_d[l_ac].xmdf002 < 0 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'axm-00294'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_xmdf_d[l_ac].xmdf002 = g_xmdf_d_t.xmdf002
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF 

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdf002
            #add-point:BEFORE FIELD xmdf002 name="input.b.page1.xmdf002"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdf002
            #add-point:ON CHANGE xmdf002 name="input.g.page1.xmdf002"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdf003
            #add-point:BEFORE FIELD xmdf003 name="input.b.page1.xmdf003"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdf003
            
            #add-point:AFTER FIELD xmdf003 name="input.a.page1.xmdf003"
            IF NOT cl_null(g_xmdf_d[l_ac].xmdf003) THEN
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xmdf_d[l_ac].xmdf003 != g_xmdf_d_t.xmdf003 OR cl_null(g_xmdf_d_t.xmdf003))) THEN
                  LET g_xmdf_d[l_ac].xmdf004 = g_xmdf_d[l_ac].xmdf003
               END IF
            END IF               
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdf003
            #add-point:ON CHANGE xmdf003 name="input.g.page1.xmdf003"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdf004
            #add-point:BEFORE FIELD xmdf004 name="input.b.page1.xmdf004"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdf004
            
            #add-point:AFTER FIELD xmdf004 name="input.a.page1.xmdf004"
            IF NOT cl_null(g_xmdf_d[l_ac].xmdf004) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xmdf_d[l_ac].xmdf004 != g_xmdf_d_t.xmdf004 OR cl_null(g_xmdf_d_t.xmdf004))) THEN
                  IF g_xmdf_d[l_ac].xmdf004 < g_xmdf_d[l_ac].xmdf003 THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = 'adb-00079'
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = FALSE
                     CALL cl_err()
                     NEXT FIELD CURRENT                  
                  END IF
               END IF
            END IF   
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdf004
            #add-point:ON CHANGE xmdf004 name="input.g.page1.xmdf004"
                        
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdf005
            
            #add-point:AFTER FIELD xmdf005 name="input.a.page1.xmdf005"
            LET g_xmdf_d[l_ac].xmdf005_desc = '' 
            IF NOT cl_null(g_xmdf_d[l_ac].xmdf005) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_xmdf_d[l_ac].xmdf005 != g_xmdf_d_t.xmdf005 OR cl_null(g_xmdf_d_t.xmdf005))) THEN
                  IF NOT s_azzi650_chk_exist('274',g_xmdf_d[l_ac].xmdf005) THEN
                     LET g_xmdf_d[l_ac].xmdf005 = g_xmdf_d_t.xmdf005
                     CALL s_desc_get_acc_desc('274',g_xmdf_d[l_ac].xmdf005) RETURNING g_xmdf_d[l_ac].xmdf005_desc
                     DISPLAY BY NAME g_xmdf_d[l_ac].xmdf005_desc 
                     NEXT FIELD CURRENT
                  END IF
               END IF   
            END IF 
				CALL s_desc_get_acc_desc('274',g_xmdf_d[l_ac].xmdf005) RETURNING g_xmdf_d[l_ac].xmdf005_desc
            DISPLAY BY NAME g_xmdf_d[l_ac].xmdf005_desc             
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdf005
            #add-point:BEFORE FIELD xmdf005 name="input.b.page1.xmdf005"
                        
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdf005
            #add-point:ON CHANGE xmdf005 name="input.g.page1.xmdf005"
                        
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xmdf006
            #add-point:BEFORE FIELD xmdf006 name="input.b.page1.xmdf006"
                        
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xmdf006
            
            #add-point:AFTER FIELD xmdf006 name="input.a.page1.xmdf006"
                        
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xmdf006
            #add-point:ON CHANGE xmdf006 name="input.g.page1.xmdf006"
                        
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.xmdfsite
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdfsite
            #add-point:ON ACTION controlp INFIELD xmdfsite name="input.c.page1.xmdfsite"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdfdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdfdocno
            #add-point:ON ACTION controlp INFIELD xmdfdocno name="input.c.page1.xmdfdocno"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdfseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdfseq
            #add-point:ON ACTION controlp INFIELD xmdfseq name="input.c.page1.xmdfseq"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdfseq2
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdfseq2
            #add-point:ON ACTION controlp INFIELD xmdfseq2 name="input.c.page1.xmdfseq2"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdf007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdf007
            #add-point:ON ACTION controlp INFIELD xmdf007 name="input.c.page1.xmdf007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdf002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdf002
            #add-point:ON ACTION controlp INFIELD xmdf002 name="input.c.page1.xmdf002"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdf003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdf003
            #add-point:ON ACTION controlp INFIELD xmdf003 name="input.c.page1.xmdf003"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdf004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdf004
            #add-point:ON ACTION controlp INFIELD xmdf004 name="input.c.page1.xmdf004"
                        
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdf005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdf005
            #add-point:ON ACTION controlp INFIELD xmdf005 name="input.c.page1.xmdf005"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xmdf_d[l_ac].xmdf005             #給予default值
            LET g_qryparam.arg1 = "274" 
            CALL q_oocq002()                                             #呼叫開窗
            LET g_xmdf_d[l_ac].xmdf005 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_xmdf_d[l_ac].xmdf005 TO xmdf005                    #顯示到畫面上
				CALL s_desc_get_acc_desc('274',g_xmdf_d[l_ac].xmdf005) RETURNING g_xmdf_d[l_ac].xmdf005_desc
            DISPLAY BY NAME g_xmdf_d[l_ac].xmdf005_desc
            NEXT FIELD xmdf005                                           #返回原欄位
            #END add-point
 
 
         #Ctrlp:input.c.page1.xmdf006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xmdf006
            #add-point:ON ACTION controlp INFIELD xmdf006 name="input.c.page1.xmdf006"
                        
            #END add-point
 
 
 
 
         #自訂ACTION
         #add-point:單身其他段落處理(EX:on row change, etc...) name="input.other"
         
         #end add-point
 
         AFTER INPUT
            #add-point:單身輸入後處理 name="input.after_input"
            IF INT_FLAG THEN
               EXIT DIALOG
            END IF                      
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
       LET INT_FLAG = 0  
       LET l_cnt = 0 
       SELECT COUNT(*) INTO l_cnt
         FROM xmdf_t 
        WHERE xmdfent = g_enterprise
          AND xmdfdocno = g_xmdfdocno
          AND xmdfseq = g_xmdfseq          
       IF l_cnt = 0 THEN
          EXIT WHILE
       ELSE       
          #已維護的分批數量
          LET l_xmdf002 = 0
          SELECT SUM(xmdf002) INTO l_xmdf002
            FROM xmdf_t WHERE xmdfent = g_enterprise
             AND xmdfdocno = g_xmdfdocno
             AND xmdfseq = g_xmdfseq
          IF cl_null(l_xmdf002) THEN
             LET l_xmdf002 = 0
          END IF       
          IF l_xmdf002 <> p_xmdc007 THEN
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'axm-00492'
             LET g_errparam.extend = ''
             LET g_errparam.popup = TRUE         
             CALL cl_err()         
             CONTINUE WHILE
          ELSE
             EXIT WHILE          
          END IF     
       END IF   
   END WHILE
    
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_axmt500_03 
   
   #add-point:input段after input name="input.post_input"
   #離開時回傳交貨日期最早的那一分批序的約定交貨日期、預計簽收日期
   LET l_xmdf003 = ''
   LET r_xmdf003 = ''
   LET r_xmdf004 = ''
   SELECT MIN(xmdf003) INTO l_xmdf003 
     FROM xmdf_t WHERE xmdfent = g_enterprise 
      AND xmdfdocno = g_xmdfdocno 
      AND xmdfseq = g_xmdfseq
   IF NOT cl_null(l_xmdf003) THEN
      SELECT xmdf003,xmdf004 
        INTO r_xmdf003,r_xmdf004 
        FROM xmdf_t
       WHERE xmdfent = g_enterprise 
         AND xmdfdocno = g_xmdfdocno 
         AND xmdfseq = g_xmdfseq 
         AND xmdf003 = l_xmdf003 
         AND xmdfseq2 = '1'
   END IF
   RETURN r_xmdf003,r_xmdf004         
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axmt500_03.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="axmt500_03.other_function" readonly="Y" >}

PRIVATE FUNCTION axmt500_03_b_fill()
   DEFINE l_sql       STRING
   DEFINE l_ac1       LIKE type_t.num5
   
   LET l_sql = "SELECT xmdfsite, xmdfdocno,xmdfseq,xmdfseq2, ", 
               "       xmdf007,xmdf002,xmdf003,xmdf004,xmdf005,'', ", 
               "       xmdf006 ", 
               "  FROM xmdf_t ", 
               " WHERE xmdfent = '",g_enterprise,"' ", 
               "   AND xmdfdocno = '",g_xmdfdocno,"' ", 
               "   AND xmdfseq = '",g_xmdfseq,"' "

   PREPARE axmt500_03_pb FROM l_sql
   DECLARE b_fill_curs CURSOR FOR axmt500_03_pb
   
   CALL g_xmdf_d.clear()
   LET l_ac1 = 1
   FOREACH b_fill_curs INTO g_xmdf_d[l_ac1].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      
      CALL s_desc_get_acc_desc('274',g_xmdf_d[l_ac1].xmdf005) RETURNING g_xmdf_d[l_ac1].xmdf005_desc

          
      LET l_ac1 = l_ac1 + 1
      IF l_ac1 > g_max_rec THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.extend =  ''
         LET g_errparam.code   =  9035
         LET g_errparam.popup  = TRUE
         CALL cl_err()
         EXIT FOREACH
      END IF
   
   END FOREACH
   CALL g_xmdf_d.deleteElement(g_xmdf_d.getLength())
   LET g_rec_b = l_ac1 - 1
   DISPLAY g_rec_b TO FORMONLY.cnt
   CLOSE b_fill_curs
   FREE axmt500_03_pb
END FUNCTION

################################################################################
# Descriptions...: 取得剩餘的數量
# Memo...........:
# Usage..........: CALL axmt500_03_get_xmdf002(p_xmdfseq2,p_xmdc007)
#                  RETURNING r_xmdf002
# Input parameter: p_xmdfseq2     期數
#                : p_xmdc007      銷售數量
# Return code....: r_xmdf002      分批數量
#                : 
# Date & Author..: 20141226 By Polly
# Modify.........:
################################################################################
PRIVATE FUNCTION axmt500_03_get_xmdf002(p_xmdfseq2,p_xmdc007)
   DEFINE  p_xmdfseq2   LIKE xmdf_t.xmdfseq2
   DEFINE  p_xmdc007    LIKE xmdc_t.xmdc007
   DEFINE  r_xmdf002    LIKE xmdf_t.xmdf002

   LET r_xmdf002 = 0
   SELECT SUM(xmdf002) INTO r_xmdf002
     FROM xmdf_t
    WHERE xmdfent = g_enterprise
      AND xmdfdocno = g_xmdfdocno
      AND xmdfseq = g_xmdfseq
      AND xmdfseq2 <> p_xmdfseq2

   IF cl_null(r_xmdf002) THEN LET r_xmdf002 = 0 END IF   
   LET r_xmdf002 = p_xmdc007 - r_xmdf002

   
   RETURN r_xmdf002   

END FUNCTION

 
{</section>}
 
