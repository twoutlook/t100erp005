#該程式未解開Section, 採用最新樣板產出!
{<section id="aapt400_04.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2014-08-26 16:47:10), PR版次:0002(2014-09-19 19:42:46)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000109
#+ Filename...: aapt400_04
#+ Description: 可請款單據查詢
#+ Creator....: 03080(2014-04-07 11:11:50)
#+ Modifier...: 03080 -SD/PR- 03080
 
{</section>}
 
{<section id="aapt400_04.global" >}
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
PRIVATE TYPE type_g_apcc_d        RECORD
       chk LIKE type_t.chr1, 
   apcborga LIKE type_t.chr10, 
   apcb001 LIKE type_t.chr20, 
   apcb002 LIKE type_t.chr20, 
   apcb028 LIKE type_t.chr20, 
   apcc001 LIKE apcc_t.apcc001, 
   apcc004 LIKE type_t.dat, 
   apcc100 LIKE type_t.chr10, 
   apcc108 LIKE type_t.num20_6, 
   apcc118 LIKE type_t.num20_6, 
   apcc128 LIKE type_t.num20_6, 
   apcc138 LIKE type_t.num20_6, 
   apcc109 LIKE type_t.num20_6, 
   apca001 LIKE type_t.chr10, 
   apccdocno LIKE apcc_t.apccdocno, 
   apca005 LIKE type_t.chr10, 
   apccld LIKE apcc_t.apccld, 
   apccseq LIKE apcc_t.apccseq
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE r_array DYNAMIC ARRAY OF RECORD                           
               apccdocno   LIKE apcc_t.apccdocno,   #立帳單號
               apccseq     LIKE apcc_t.apccseq,     #立帳項次
               apcc001     LIKE apcc_t.apcc001      #帳期
               END RECORD
DEFINE g_type  LIKE type_t.chr1                     #1:apcc_t   2:匯總
DEFINE g_wc    STRING
DEFINE g_wc2   STRING
DEFINE g_reqry LIKE type_t.num5                     #重新qbe
#end add-point
 
DEFINE g_apcc_d          DYNAMIC ARRAY OF type_g_apcc_d
DEFINE g_apcc_d_t        type_g_apcc_d
 
 
DEFINE g_apccld_t   LIKE apcc_t.apccld    #Key值備份
DEFINE g_apccdocno_t      LIKE apcc_t.apccdocno    #Key值備份
DEFINE g_apccseq_t      LIKE apcc_t.apccseq    #Key值備份
DEFINE g_apcc001_t      LIKE apcc_t.apcc001    #Key值備份
DEFINE g_apcc009_t      LIKE apcc_t.apcc009    #Key值備份
 
 
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
 
{<section id="aapt400_04.input" >}
#+ 資料輸入
PUBLIC FUNCTION aapt400_04(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_type,
   p_wc2
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
   DEFINE p_type          LIKE type_t.chr1        #1:apcc_t 2:匯總
   DEFINE p_wc2           STRING                  #額外的Sql條件
   
   WHENEVER ERROR CONTINUE
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_aapt400_04 WITH FORM cl_ap_formpath("aap","aapt400_04")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #輸入前處理
   #add-point:單身前置處理 name="input.pre_input"
   LET g_wc = ' 1=1'
   LET g_wc2 = p_wc2
   IF cl_null(g_wc2)THEN LET g_wc2 = ' 1=1' END IF
   LET g_type = p_type
   CALL cl_set_combo_scc('apca001','8502')
   
   WHILE TRUE
      CALL aapt400_04_query()
      IF INT_FLAG THEN
         EXIT WHILE
      END IF
      CALL aapt400_04_b_fill(g_wc)
      LET g_reqry = FALSE
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT ARRAY g_apcc_d FROM s_detail1.*
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
            
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD chk
            #add-point:BEFORE FIELD chk name="input.b.page1.chk"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD chk
            
            #add-point:AFTER FIELD chk name="input.a.page1.chk"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE chk
            #add-point:ON CHANGE chk name="input.g.page1.chk"
            CALL aapt400_04_sum_page_d()
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcborga
            #add-point:BEFORE FIELD apcborga name="input.b.page1.apcborga"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcborga
            
            #add-point:AFTER FIELD apcborga name="input.a.page1.apcborga"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcborga
            #add-point:ON CHANGE apcborga name="input.g.page1.apcborga"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcb001
            #add-point:BEFORE FIELD apcb001 name="input.b.page1.apcb001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcb001
            
            #add-point:AFTER FIELD apcb001 name="input.a.page1.apcb001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcb001
            #add-point:ON CHANGE apcb001 name="input.g.page1.apcb001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcb002
            #add-point:BEFORE FIELD apcb002 name="input.b.page1.apcb002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcb002
            
            #add-point:AFTER FIELD apcb002 name="input.a.page1.apcb002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcb002
            #add-point:ON CHANGE apcb002 name="input.g.page1.apcb002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcb028
            #add-point:BEFORE FIELD apcb028 name="input.b.page1.apcb028"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcb028
            
            #add-point:AFTER FIELD apcb028 name="input.a.page1.apcb028"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcb028
            #add-point:ON CHANGE apcb028 name="input.g.page1.apcb028"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc001
            #add-point:BEFORE FIELD apcc001 name="input.b.page1.apcc001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc001
            
            #add-point:AFTER FIELD apcc001 name="input.a.page1.apcc001"
            #此段落由子樣板a05產生
            IF  g_apcc_d[g_detail_idx].apccld IS NOT NULL AND g_apcc_d[g_detail_idx].apccdocno IS NOT NULL AND g_apcc_d[g_detail_idx].apccseq IS NOT NULL AND g_apcc_d[g_detail_idx].apcc001 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_apcc_d[g_detail_idx].apccld != g_apcc_d_t.apccld OR g_apcc_d[g_detail_idx].apccdocno != g_apcc_d_t.apccdocno OR g_apcc_d[g_detail_idx].apccseq != g_apcc_d_t.apccseq OR g_apcc_d[g_detail_idx].apcc001 != g_apcc_d_t.apcc001)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM apcc_t WHERE "||"apccent = '" ||g_enterprise|| "' AND "||"apccld = '"||g_apcc_d[g_detail_idx].apccld ||"' AND "|| "apccdocno = '"||g_apcc_d[g_detail_idx].apccdocno ||"' AND "|| "apccseq = '"||g_apcc_d[g_detail_idx].apccseq ||"' AND "|| "apcc001 = '"||g_apcc_d[g_detail_idx].apcc001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc001
            #add-point:ON CHANGE apcc001 name="input.g.page1.apcc001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc004
            #add-point:BEFORE FIELD apcc004 name="input.b.page1.apcc004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc004
            
            #add-point:AFTER FIELD apcc004 name="input.a.page1.apcc004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc004
            #add-point:ON CHANGE apcc004 name="input.g.page1.apcc004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc100
            #add-point:BEFORE FIELD apcc100 name="input.b.page1.apcc100"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc100
            
            #add-point:AFTER FIELD apcc100 name="input.a.page1.apcc100"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc100
            #add-point:ON CHANGE apcc100 name="input.g.page1.apcc100"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc108
            #add-point:BEFORE FIELD apcc108 name="input.b.page1.apcc108"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc108
            
            #add-point:AFTER FIELD apcc108 name="input.a.page1.apcc108"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc108
            #add-point:ON CHANGE apcc108 name="input.g.page1.apcc108"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc118
            #add-point:BEFORE FIELD apcc118 name="input.b.page1.apcc118"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc118
            
            #add-point:AFTER FIELD apcc118 name="input.a.page1.apcc118"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc118
            #add-point:ON CHANGE apcc118 name="input.g.page1.apcc118"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc128
            #add-point:BEFORE FIELD apcc128 name="input.b.page1.apcc128"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc128
            
            #add-point:AFTER FIELD apcc128 name="input.a.page1.apcc128"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc128
            #add-point:ON CHANGE apcc128 name="input.g.page1.apcc128"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc138
            #add-point:BEFORE FIELD apcc138 name="input.b.page1.apcc138"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc138
            
            #add-point:AFTER FIELD apcc138 name="input.a.page1.apcc138"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc138
            #add-point:ON CHANGE apcc138 name="input.g.page1.apcc138"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcc109
            #add-point:BEFORE FIELD apcc109 name="input.b.page1.apcc109"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcc109
            
            #add-point:AFTER FIELD apcc109 name="input.a.page1.apcc109"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcc109
            #add-point:ON CHANGE apcc109 name="input.g.page1.apcc109"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca001
            #add-point:BEFORE FIELD apca001 name="input.b.page1.apca001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca001
            
            #add-point:AFTER FIELD apca001 name="input.a.page1.apca001"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca001
            #add-point:ON CHANGE apca001 name="input.g.page1.apca001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apccdocno
            #add-point:BEFORE FIELD apccdocno name="input.b.page1.apccdocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apccdocno
            
            #add-point:AFTER FIELD apccdocno name="input.a.page1.apccdocno"
            #此段落由子樣板a05產生
            IF  g_apcc_d[g_detail_idx].apccld IS NOT NULL AND g_apcc_d[g_detail_idx].apccdocno IS NOT NULL AND g_apcc_d[g_detail_idx].apccseq IS NOT NULL AND g_apcc_d[g_detail_idx].apcc001 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_apcc_d[g_detail_idx].apccld != g_apcc_d_t.apccld OR g_apcc_d[g_detail_idx].apccdocno != g_apcc_d_t.apccdocno OR g_apcc_d[g_detail_idx].apccseq != g_apcc_d_t.apccseq OR g_apcc_d[g_detail_idx].apcc001 != g_apcc_d_t.apcc001)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM apcc_t WHERE "||"apccent = '" ||g_enterprise|| "' AND "||"apccld = '"||g_apcc_d[g_detail_idx].apccld ||"' AND "|| "apccdocno = '"||g_apcc_d[g_detail_idx].apccdocno ||"' AND "|| "apccseq = '"||g_apcc_d[g_detail_idx].apccseq ||"' AND "|| "apcc001 = '"||g_apcc_d[g_detail_idx].apcc001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apccdocno
            #add-point:ON CHANGE apccdocno name="input.g.page1.apccdocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apca005
            #add-point:BEFORE FIELD apca005 name="input.b.page1.apca005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apca005
            
            #add-point:AFTER FIELD apca005 name="input.a.page1.apca005"


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apca005
            #add-point:ON CHANGE apca005 name="input.g.page1.apca005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apccld
            #add-point:BEFORE FIELD apccld name="input.b.page1.apccld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apccld
            
            #add-point:AFTER FIELD apccld name="input.a.page1.apccld"
            #此段落由子樣板a05產生
            IF  g_apcc_d[g_detail_idx].apccld IS NOT NULL AND g_apcc_d[g_detail_idx].apccdocno IS NOT NULL AND g_apcc_d[g_detail_idx].apccseq IS NOT NULL AND g_apcc_d[g_detail_idx].apcc001 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_apcc_d[g_detail_idx].apccld != g_apcc_d_t.apccld OR g_apcc_d[g_detail_idx].apccdocno != g_apcc_d_t.apccdocno OR g_apcc_d[g_detail_idx].apccseq != g_apcc_d_t.apccseq OR g_apcc_d[g_detail_idx].apcc001 != g_apcc_d_t.apcc001)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM apcc_t WHERE "||"apccent = '" ||g_enterprise|| "' AND "||"apccld = '"||g_apcc_d[g_detail_idx].apccld ||"' AND "|| "apccdocno = '"||g_apcc_d[g_detail_idx].apccdocno ||"' AND "|| "apccseq = '"||g_apcc_d[g_detail_idx].apccseq ||"' AND "|| "apcc001 = '"||g_apcc_d[g_detail_idx].apcc001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apccld
            #add-point:ON CHANGE apccld name="input.g.page1.apccld"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apccseq
            #add-point:BEFORE FIELD apccseq name="input.b.page1.apccseq"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apccseq
            
            #add-point:AFTER FIELD apccseq name="input.a.page1.apccseq"
            #此段落由子樣板a05產生
            IF  g_apcc_d[g_detail_idx].apccld IS NOT NULL AND g_apcc_d[g_detail_idx].apccdocno IS NOT NULL AND g_apcc_d[g_detail_idx].apccseq IS NOT NULL AND g_apcc_d[g_detail_idx].apcc001 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_apcc_d[g_detail_idx].apccld != g_apcc_d_t.apccld OR g_apcc_d[g_detail_idx].apccdocno != g_apcc_d_t.apccdocno OR g_apcc_d[g_detail_idx].apccseq != g_apcc_d_t.apccseq OR g_apcc_d[g_detail_idx].apcc001 != g_apcc_d_t.apcc001)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM apcc_t WHERE "||"apccent = '" ||g_enterprise|| "' AND "||"apccld = '"||g_apcc_d[g_detail_idx].apccld ||"' AND "|| "apccdocno = '"||g_apcc_d[g_detail_idx].apccdocno ||"' AND "|| "apccseq = '"||g_apcc_d[g_detail_idx].apccseq ||"' AND "|| "apcc001 = '"||g_apcc_d[g_detail_idx].apcc001 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apccseq
            #add-point:ON CHANGE apccseq name="input.g.page1.apccseq"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1.chk
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD chk
            #add-point:ON ACTION controlp INFIELD chk name="input.c.page1.chk"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcborga
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcborga
            #add-point:ON ACTION controlp INFIELD apcborga name="input.c.page1.apcborga"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_apcc_d[l_ac].apcborga             #給予default值
            LET g_qryparam.default2 = "" #g_apcc_d[l_ac].ooefl003 #說明(簡稱)
            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_ooef001()                                #呼叫開窗

            LET g_apcc_d[l_ac].apcborga = g_qryparam.return1              
            #LET g_apcc_d[l_ac].ooefl003 = g_qryparam.return2 
            DISPLAY g_apcc_d[l_ac].apcborga TO apcborga              #
            #DISPLAY g_apcc_d[l_ac].ooefl003 TO ooefl003 #說明(簡稱)
            NEXT FIELD apcborga                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.apcb001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcb001
            #add-point:ON ACTION controlp INFIELD apcb001 name="input.c.page1.apcb001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcb002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcb002
            #add-point:ON ACTION controlp INFIELD apcb002 name="input.c.page1.apcb002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcb028
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcb028
            #add-point:ON ACTION controlp INFIELD apcb028 name="input.c.page1.apcb028"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcc001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc001
            #add-point:ON ACTION controlp INFIELD apcc001 name="input.c.page1.apcc001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcc004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc004
            #add-point:ON ACTION controlp INFIELD apcc004 name="input.c.page1.apcc004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcc100
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc100
            #add-point:ON ACTION controlp INFIELD apcc100 name="input.c.page1.apcc100"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcc108
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc108
            #add-point:ON ACTION controlp INFIELD apcc108 name="input.c.page1.apcc108"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcc118
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc118
            #add-point:ON ACTION controlp INFIELD apcc118 name="input.c.page1.apcc118"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcc128
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc128
            #add-point:ON ACTION controlp INFIELD apcc128 name="input.c.page1.apcc128"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcc138
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc138
            #add-point:ON ACTION controlp INFIELD apcc138 name="input.c.page1.apcc138"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcc109
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc109
            #add-point:ON ACTION controlp INFIELD apcc109 name="input.c.page1.apcc109"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apca001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca001
            #add-point:ON ACTION controlp INFIELD apca001 name="input.c.page1.apca001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apccdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apccdocno
            #add-point:ON ACTION controlp INFIELD apccdocno name="input.c.page1.apccdocno"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apca005
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apca005
            #add-point:ON ACTION controlp INFIELD apca005 name="input.c.page1.apca005"
            #此段落由子樣板a07產生            
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_apcc_d[l_ac].apca005             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            
            CALL q_pmac002_2()                                #呼叫開窗

            LET g_apcc_d[l_ac].apca005 = g_qryparam.return1              

            DISPLAY g_apcc_d[l_ac].apca005 TO apca005              #

            NEXT FIELD apca005                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.page1.apccld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apccld
            #add-point:ON ACTION controlp INFIELD apccld name="input.c.page1.apccld"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apccseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apccseq
            #add-point:ON ACTION controlp INFIELD apccseq name="input.c.page1.apccseq"
            
            #END add-point
 
 
 
 
         #自訂ACTION
         #add-point:單身其他段落處理(EX:on row change, etc...) name="input.other"
         
         #end add-point
 
         AFTER INPUT
            #add-point:單身輸入後處理 name="input.after_input"
            
            #end add-point
            
      END INPUT
      
 
      
      #add-point:自定義input name="input.more_input"
      ON ACTION query
         LET g_reqry = TRUE
         EXIT DIALOG 
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
      IF g_reqry THEN
         CONTINUE WHILE
      END IF
      EXIT WHILE
   END WHILE  #albireo-s 
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_aapt400_04 
   
   #add-point:input段after input name="input.post_input"

 
   IF INT_FLAG THEN
      LET INT_FLAG = 0
   ELSE
      CALL aapt400_04_to_r_array()
   END IF
   RETURN r_array
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aapt400_04.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aapt400_04.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 查詢單身填充
# Memo...........:
# Usage..........: CALL aapt400_04_b_fill(p_wc2)
# Input parameter: 
# Date & Author..: 140423 By albireo
# Modify.........:
################################################################################
PUBLIC FUNCTION aapt400_04_b_fill(p_wc2)
   DEFINE l_sql   STRING
   DEFINE p_wc2   STRING
   DEFINE l_apcc  RECORD
                  sum_apcc1081   LIKE apcc_t.apcc108,
                  sum_apcc1181   LIKE apcc_t.apcc118
                  END RECORD

   IF cl_null(p_wc2)THEN LET p_wc2 = ' 1=1' END IF
   CASE
      WHEN g_type = '1'
         LET l_sql = "SELECT UNIQUE 'N',apcborga,apcb001,apcb002,apcb028,",
                     "              apcc001,apcc004,apcc100,apcc108,apcc118,",
                     "              apcc128,apcc138,apcc109,apca001,apccdocno,",
                     "              apca005,apccld,apccseq ",
                     "  FROM apca_t,apcb_t,apcc_t ",
                     " WHERE apcbent   = apcaent ",
                     "   AND apcbld    = apcald  ",
                     "   AND apcbdocno = apcadocno ",
                     "   AND apccent   = apcbent ",
                     "   AND apccld    = apcbld ",
                     "   AND apccdocno = apcbdocno ",
                     "   AND apccseq   = apcbseq ",
                     "   AND apccent = ? ",
                     "   AND ",p_wc2 CLIPPED,
                     "   AND ",g_wc2 CLIPPED 
      WHEN g_type = '2'
        #apcc004,
       #LET l_sql = "SELECT UNIQUE 'N',apcborga,apcb001,apcb002,apcb028,",
       #             "              apcc001,'',apcc100,SUM(apcc108),SUM(apcc118),",
       #             "              SUM(apcc128),SUM(apcc138),SUM(apcc109),apca001,apccdocno,",
       #             "              apca005,apccld,0 ",
       #             "  FROM apca_t,apcb_t,apcc_t ",
       #             " WHERE apcbent   = apcaent ",
       #             "   AND apcbld    = apcald  ",
       #             "   AND apcbdocno = apcadocno ",
       #             "   AND apccent   = apcbent ",
       #             "   AND apccld    = apcbld ",
       #             "   AND apccdocno = apcbdocno ",
       #             "   AND apccseq   = apcbseq ",
       #             "   AND apccent = ? ",
       #             "   AND ",p_wc2 CLIPPED,
       #             "   AND ",g_wc2 CLIPPED,
       #             " GROUP BY apccorga,apcb002,apcb028,apcc100,apca001,apccld,",
       #             "          apca005,apccdocno,apcc001"
       LET l_sql = "SELECT UNIQUE 'N',apcborga,apcb001,apcb002,apcb028,",
                     "              apcc001,'',apcc100,SUM(apcc108),SUM(apcc118),",
                     "              SUM(apcc128),SUM(apcc138),SUM(apcc109),apca001,apccdocno,",
                     "              apca005,apccld,0 ",
                     "  FROM apca_t,apcb_t,apcc_t ",
                     " WHERE apcbent   = apcaent ",
                     "   AND apcbld    = apcald  ",
                     "   AND apcbdocno = apcadocno ",
                     "   AND apccent   = apcbent ",
                     "   AND apccld    = apcbld ",
                     "   AND apccdocno = apcbdocno ",
                     "   AND apccseq   = apcbseq ",
                     "   AND apccent = ? ",
                     "   AND ",p_wc2 CLIPPED,
                     "   AND ",g_wc2 CLIPPED,
                     " GROUP BY apcborga,apcb002,apcb028,apcc100,apca001,apccld,",
                     "          apca005,apccdocno,apcc001,apcb001"
   END CASE
   PREPARE b_fill_pre1 FROM l_sql
   DECLARE b_fill_curs1 CURSOR FOR b_fill_pre1

   CALL g_apcc_d.clear()
   LET l_ac = 1
   LET l_apcc.sum_apcc1081 = 0 
   LET l_apcc.sum_apcc1181 = 0
   FOREACH b_fill_curs1 USING g_enterprise INTO g_apcc_d[l_ac].*
      IF SQLCA.SQLCODE THEN EXIT FOREACH END IF
      CALL s_aapt400_apcc_used_chk(g_apcc_d[l_ac].apccld,g_apcc_d[l_ac].apccdocno,g_apcc_d[l_ac].apccseq,
                                   g_apcc_d[l_ac].apcc001,
                                   0,0,0,'1','4')
         RETURNING g_sub_success,g_errno
      IF NOT g_sub_success THEN
         CONTINUE FOREACH
      #ELSE
      #   #CALL s_aapt400_apcc_used_num(g_apcc_d[l_ac].apccld,g_apcc_d[l_ac].apccdocno,g_apcc_d[l_ac].apccseq,
      #   #                             g_apcc_d[l_ac].apcc001,0,0,'1')
      #   #   RETURNING g_sub_success,g_errno,g_apcc_d[l_ac].apcc109,g_apcc_d[l_ac].apcc119,
      #   #             g_apcc_d[l_ac].apcc129,g_apcc_d[l_ac].apcc139                             
      END IF
      LET l_apcc.sum_apcc1081 = l_apcc.sum_apcc1081 + g_apcc_d[l_ac].apcc108
      LET l_apcc.sum_apcc1181 = l_apcc.sum_apcc1181 + g_apcc_d[l_ac].apcc118
      LET l_ac = l_ac + 1 
   END FOREACH
   
   DISPLAY BY NAME l_apcc.sum_apcc1081,l_apcc.sum_apcc1181
   CALL g_apcc_d.deleteElement(g_apcc_d.getLength())   
END FUNCTION

################################################################################
# Descriptions...: 單身查詢
# Memo...........:
# Usage..........: aapt400_04_query()
# Input parameter: 
# Date & Author..: 140423 By albireo
# Modify.........:
################################################################################
PUBLIC FUNCTION aapt400_04_query()
   CALL g_apcc_d.clear()
   CALL r_array.clear()
   CONSTRUCT g_wc ON apcborga,apcb001,apcb002,apcb028,apcc001,
                     apcc004,apcc100,apcc118,apcc128,apcc138,
                     apcc109,apca001,apccdocno,apca005,apccld,
                     apccseq
                  FROM s_detail1[1].apcborga,s_detail1[1].apcb001,s_detail1[1].apcb002,
                       s_detail1[1].apcb028,s_detail1[1].apcc001,s_detail1[1].apcc004,
                       s_detail1[1].apcc100,s_detail1[1].apcc118,s_detail1[1].apcc128,
                       s_detail1[1].apcc138,s_detail1[1].apcc109,s_detail1[1].apca001,
                       s_detail1[1].apccdocno,s_detail1[1].apca005,s_detail1[1].apccld,
                       s_detail1[1].apccseq
      BEFORE CONSTRUCT
      
      ON ACTION accept
         EXIT CONSTRUCT
      ON ACTION cancel
         LET INT_FLAG = 1
         EXIT CONSTRUCT 

   END CONSTRUCT

   IF INT_FLAG THEN
      LET INT_FLAG = 0 
      RETURN
   END IF

   CALL aapt400_04_b_fill(g_wc)
END FUNCTION

################################################################################
# Descriptions...: 把選取的資料拋轉到要傳出的array
# Memo...........:
# Usage..........: CALL aapt400_04_to_r_array()
# Input parameter: 
# Date & Author..: 140423 By albireo
# Modify.........:
################################################################################
PUBLIC FUNCTION aapt400_04_to_r_array()
   DEFINE l_i     LIKE type_t.num5
   DEFINE l_index LIKE type_t.num5

   LET l_index = 1
   CALL r_array.clear()
   FOR l_i = 1 TO g_apcc_d.getLength()
      IF g_apcc_d[l_i].chk = 'Y' THEN
         LET r_array[l_index].apccdocno = g_apcc_d[l_i].apccdocno
         LET r_array[l_index].apccseq   = g_apcc_d[l_i].apccseq
         LET r_array[l_index].apcc001   = g_apcc_d[l_i].apcc001
      END IF
      LET l_index = l_index + 1
   END FOR
END FUNCTION

PUBLIC FUNCTION aapt400_04_sum_page_d()
   DEFINE l_index   LIKE type_t.num5
   DEFINE l_apcc    RECORD
                    sum_apcc1082   LIKE apcc_t.apcc108,
                    sum_apcc1182   LIKE apcc_t.apcc118,
                    sum_apcc128    LIKE apcc_t.apcc108,
                    sum_apcc138    LIKE apcc_t.apcc118
                    END RECORD
   WHENEVER ERROR CONTINUE
   
   LET l_apcc.sum_apcc1082 = 0 
   LET l_apcc.sum_apcc1182 = 0 
   LET l_apcc.sum_apcc128 = 0 
   LET l_apcc.sum_apcc138 = 0
   FOR l_index = 1 TO g_apcc_d.getLength()
      IF g_apcc_d[l_index].chk = 'Y' THEN
         LET l_apcc.sum_apcc1082 = l_apcc.sum_apcc1082 + g_apcc_d[l_index].apcc108
         LET l_apcc.sum_apcc1182 = l_apcc.sum_apcc1182 + g_apcc_d[l_index].apcc118
         LET l_apcc.sum_apcc128 = l_apcc.sum_apcc128 + g_apcc_d[l_index].apcc128
         LET l_apcc.sum_apcc138 = l_apcc.sum_apcc138 + g_apcc_d[l_index].apcc138
      END IF
   END FOR
   DISPLAY BY NAME l_apcc.sum_apcc1082,l_apcc.sum_apcc1182,l_apcc.sum_apcc128,l_apcc.sum_apcc138
   
END FUNCTION

 
{</section>}
 
