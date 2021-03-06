#該程式未解開Section, 採用最新樣板產出!
{<section id="aapt400_05.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0001(2014-04-18 15:34:51), PR版次:0001(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000099
#+ Filename...: aapt400_05
#+ Description: 可請款單據明細產生
#+ Creator....: 03080(2014-04-07 14:56:06)
#+ Modifier...: 03080 -SD/PR- 00000
 
{</section>}
 
{<section id="aapt400_05.global" >}
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
   apccseq LIKE apcc_t.apccseq, 
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
   apca004 LIKE type_t.chr10, 
   apccld LIKE apcc_t.apccld
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

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
 
{<section id="aapt400_05.input" >}
#+ 資料輸入
PUBLIC FUNCTION aapt400_05(--)
   #add-point:input段變數傳入 name="input.get_var"
   
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
   
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_aapt400_05 WITH FORM cl_ap_formpath("aap","aapt400_05")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #輸入前處理
   #add-point:單身前置處理 name="input.pre_input"
   
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
 
 
         #Ctrlp:input.c.page1.apccseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apccseq
            #add-point:ON ACTION controlp INFIELD apccseq name="input.c.page1.apccseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apcc001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcc001
            #add-point:ON ACTION controlp INFIELD apcc001 name="input.c.page1.apcc001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apccdocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apccdocno
            #add-point:ON ACTION controlp INFIELD apccdocno name="input.c.page1.apccdocno"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1.apccld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apccld
            #add-point:ON ACTION controlp INFIELD apccld name="input.c.page1.apccld"
            
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
   
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_aapt400_05 
   
   #add-point:input段after input name="input.post_input"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aapt400_05.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aapt400_05.other_function" readonly="Y" >}

 
{</section>}
 
