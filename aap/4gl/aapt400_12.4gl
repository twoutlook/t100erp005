#該程式未解開Section, 採用最新樣板產出!
{<section id="aapt400_12.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2014-07-24 15:33:33), PR版次:0002(1900-01-01 00:00:00)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000101
#+ Filename...: aapt400_12
#+ Description: 單身受款人資訊
#+ Creator....: 03080(2014-04-07 17:37:01)
#+ Modifier...: 03080 -SD/PR- 00000
 
{</section>}
 
{<section id="aapt400_12.global" >}
#應用 c01b 樣板自動產生(Version:10)
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
 
#add-point:增加匯入變數檔 name="global.inc" name="global.inc"

#end add-point
 
#單頭 type 宣告
PRIVATE type type_g_apce_m        RECORD
       apce002 LIKE apce_t.apce002, 
   apceseq LIKE apce_t.apceseq, 
   apceld LIKE apce_t.apceld, 
   apcedocno LIKE apce_t.apcedocno, 
   apce015 LIKE apce_t.apce015, 
   apce009 LIKE apce_t.apce009, 
   apce038 LIKE apce_t.apce038, 
   apce038_desc LIKE type_t.chr80, 
   apce041 LIKE apce_t.apce041, 
   apce039 LIKE apce_t.apce039, 
   apce039_desc LIKE type_t.chr80, 
   apce040 LIKE apce_t.apce040, 
   apce042 LIKE apce_t.apce042, 
   apce006 LIKE apce_t.apce006, 
   apce008 LIKE apce_t.apce008, 
   apce003 LIKE apce_t.apce003, 
   apce004 LIKE apce_t.apce004, 
   apce024 LIKE apce_t.apce024, 
   apce025 LIKE apce_t.apce025
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
DEFINE g_apce_m        type_g_apce_m
 
   DEFINE g_apceseq_t LIKE apce_t.apceseq
DEFINE g_apceld_t LIKE apce_t.apceld
DEFINE g_apcedocno_t LIKE apce_t.apcedocno
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aapt400_12.input" >}
#+ 資料輸入
PUBLIC FUNCTION aapt400_12(--)
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
   DEFINE p_cmd           LIKE type_t.chr5
   #add-point:input段define(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="input.define"
   
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aapt400_12 WITH FORM cl_ap_formpath("aap","aapt400_12")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_apce_m.apce002,g_apce_m.apceseq,g_apce_m.apceld,g_apce_m.apcedocno,g_apce_m.apce015, 
          g_apce_m.apce009,g_apce_m.apce038,g_apce_m.apce041,g_apce_m.apce039,g_apce_m.apce040,g_apce_m.apce042, 
          g_apce_m.apce006,g_apce_m.apce008,g_apce_m.apce003,g_apce_m.apce004,g_apce_m.apce024,g_apce_m.apce025  
          ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce002
            #add-point:BEFORE FIELD apce002 name="input.b.apce002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce002
            
            #add-point:AFTER FIELD apce002 name="input.a.apce002"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce002
            #add-point:ON CHANGE apce002 name="input.g.apce002"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apceseq
            #應用 a15 樣板自動產生(Version:3)
            #確認欄位值在特定區間內
            IF NOT cl_ap_chk_range(g_apce_m.apceseq,"0.000","0","","","azz-00079",1) THEN
               NEXT FIELD apceseq
            END IF 
 
 
 
            #add-point:AFTER FIELD apceseq name="input.a.apceseq"
            IF NOT cl_null(g_apce_m.apceseq) THEN 
            END IF 

            #此段落由子樣板a05產生
            IF  NOT cl_null(g_apce_m.apceld) AND NOT cl_null(g_apce_m.apcedocno) AND NOT cl_null(g_apce_m.apceseq) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_apce_m.apceld != g_apceld_t  OR g_apce_m.apcedocno != g_apcedocno_t  OR g_apce_m.apceseq != g_apceseq_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM apce_t WHERE "||"apceent = '" ||g_enterprise|| "' AND "||"apceld = '"||g_apce_m.apceld ||"' AND "|| "apcedocno = '"||g_apce_m.apcedocno ||"' AND "|| "apceseq = '"||g_apce_m.apceseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apceseq
            #add-point:BEFORE FIELD apceseq name="input.b.apceseq"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apceseq
            #add-point:ON CHANGE apceseq name="input.g.apceseq"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apceld
            #add-point:BEFORE FIELD apceld name="input.b.apceld"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apceld
            
            #add-point:AFTER FIELD apceld name="input.a.apceld"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_apce_m.apceld) AND NOT cl_null(g_apce_m.apcedocno) AND NOT cl_null(g_apce_m.apceseq) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_apce_m.apceld != g_apceld_t  OR g_apce_m.apcedocno != g_apcedocno_t  OR g_apce_m.apceseq != g_apceseq_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM apce_t WHERE "||"apceent = '" ||g_enterprise|| "' AND "||"apceld = '"||g_apce_m.apceld ||"' AND "|| "apcedocno = '"||g_apce_m.apcedocno ||"' AND "|| "apceseq = '"||g_apce_m.apceseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apceld
            #add-point:ON CHANGE apceld name="input.g.apceld"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apcedocno
            #add-point:BEFORE FIELD apcedocno name="input.b.apcedocno"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apcedocno
            
            #add-point:AFTER FIELD apcedocno name="input.a.apcedocno"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_apce_m.apceld) AND NOT cl_null(g_apce_m.apcedocno) AND NOT cl_null(g_apce_m.apceseq) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_apce_m.apceld != g_apceld_t  OR g_apce_m.apcedocno != g_apcedocno_t  OR g_apce_m.apceseq != g_apceseq_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM apce_t WHERE "||"apceent = '" ||g_enterprise|| "' AND "||"apceld = '"||g_apce_m.apceld ||"' AND "|| "apcedocno = '"||g_apce_m.apcedocno ||"' AND "|| "apceseq = '"||g_apce_m.apceseq ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apcedocno
            #add-point:ON CHANGE apcedocno name="input.g.apcedocno"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce015
            #add-point:BEFORE FIELD apce015 name="input.b.apce015"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce015
            
            #add-point:AFTER FIELD apce015 name="input.a.apce015"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce015
            #add-point:ON CHANGE apce015 name="input.g.apce015"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce009
            #add-point:BEFORE FIELD apce009 name="input.b.apce009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce009
            
            #add-point:AFTER FIELD apce009 name="input.a.apce009"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce009
            #add-point:ON CHANGE apce009 name="input.g.apce009"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce038
            
            #add-point:AFTER FIELD apce038 name="input.a.apce038"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce038
            #add-point:BEFORE FIELD apce038 name="input.b.apce038"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce038
            #add-point:ON CHANGE apce038 name="input.g.apce038"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce041
            #add-point:BEFORE FIELD apce041 name="input.b.apce041"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce041
            
            #add-point:AFTER FIELD apce041 name="input.a.apce041"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce041
            #add-point:ON CHANGE apce041 name="input.g.apce041"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce039
            
            #add-point:AFTER FIELD apce039 name="input.a.apce039"


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce039
            #add-point:BEFORE FIELD apce039 name="input.b.apce039"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce039
            #add-point:ON CHANGE apce039 name="input.g.apce039"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce040
            #add-point:BEFORE FIELD apce040 name="input.b.apce040"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce040
            
            #add-point:AFTER FIELD apce040 name="input.a.apce040"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce040
            #add-point:ON CHANGE apce040 name="input.g.apce040"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce042
            #add-point:BEFORE FIELD apce042 name="input.b.apce042"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce042
            
            #add-point:AFTER FIELD apce042 name="input.a.apce042"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce042
            #add-point:ON CHANGE apce042 name="input.g.apce042"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce006
            #add-point:BEFORE FIELD apce006 name="input.b.apce006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce006
            
            #add-point:AFTER FIELD apce006 name="input.a.apce006"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce006
            #add-point:ON CHANGE apce006 name="input.g.apce006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce008
            #add-point:BEFORE FIELD apce008 name="input.b.apce008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce008
            
            #add-point:AFTER FIELD apce008 name="input.a.apce008"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce008
            #add-point:ON CHANGE apce008 name="input.g.apce008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce003
            #add-point:BEFORE FIELD apce003 name="input.b.apce003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce003
            
            #add-point:AFTER FIELD apce003 name="input.a.apce003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce003
            #add-point:ON CHANGE apce003 name="input.g.apce003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce004
            #add-point:BEFORE FIELD apce004 name="input.b.apce004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce004
            
            #add-point:AFTER FIELD apce004 name="input.a.apce004"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce004
            #add-point:ON CHANGE apce004 name="input.g.apce004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce024
            #add-point:BEFORE FIELD apce024 name="input.b.apce024"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce024
            
            #add-point:AFTER FIELD apce024 name="input.a.apce024"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce024
            #add-point:ON CHANGE apce024 name="input.g.apce024"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD apce025
            #add-point:BEFORE FIELD apce025 name="input.b.apce025"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD apce025
            
            #add-point:AFTER FIELD apce025 name="input.a.apce025"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE apce025
            #add-point:ON CHANGE apce025 name="input.g.apce025"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.apce002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce002
            #add-point:ON ACTION controlp INFIELD apce002 name="input.c.apce002"
            
            #END add-point
 
 
         #Ctrlp:input.c.apceseq
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apceseq
            #add-point:ON ACTION controlp INFIELD apceseq name="input.c.apceseq"
            
            #END add-point
 
 
         #Ctrlp:input.c.apceld
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apceld
            #add-point:ON ACTION controlp INFIELD apceld name="input.c.apceld"
            
            #END add-point
 
 
         #Ctrlp:input.c.apcedocno
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apcedocno
            #add-point:ON ACTION controlp INFIELD apcedocno name="input.c.apcedocno"
            
            #END add-point
 
 
         #Ctrlp:input.c.apce015
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce015
            #add-point:ON ACTION controlp INFIELD apce015 name="input.c.apce015"
            
            #END add-point
 
 
         #Ctrlp:input.c.apce009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce009
            #add-point:ON ACTION controlp INFIELD apce009 name="input.c.apce009"
            
            #END add-point
 
 
         #Ctrlp:input.c.apce038
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce038
            #add-point:ON ACTION controlp INFIELD apce038 name="input.c.apce038"
            
            #END add-point
 
 
         #Ctrlp:input.c.apce041
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce041
            #add-point:ON ACTION controlp INFIELD apce041 name="input.c.apce041"
            
            #END add-point
 
 
         #Ctrlp:input.c.apce039
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce039
            #add-point:ON ACTION controlp INFIELD apce039 name="input.c.apce039"
            
            #END add-point
 
 
         #Ctrlp:input.c.apce040
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce040
            #add-point:ON ACTION controlp INFIELD apce040 name="input.c.apce040"
            
            #END add-point
 
 
         #Ctrlp:input.c.apce042
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce042
            #add-point:ON ACTION controlp INFIELD apce042 name="input.c.apce042"
            
            #END add-point
 
 
         #Ctrlp:input.c.apce006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce006
            #add-point:ON ACTION controlp INFIELD apce006 name="input.c.apce006"
            
            #END add-point
 
 
         #Ctrlp:input.c.apce008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce008
            #add-point:ON ACTION controlp INFIELD apce008 name="input.c.apce008"
            
            #END add-point
 
 
         #Ctrlp:input.c.apce003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce003
            #add-point:ON ACTION controlp INFIELD apce003 name="input.c.apce003"
            
            #END add-point
 
 
         #Ctrlp:input.c.apce004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce004
            #add-point:ON ACTION controlp INFIELD apce004 name="input.c.apce004"
            
            #END add-point
 
 
         #Ctrlp:input.c.apce024
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce024
            #add-point:ON ACTION controlp INFIELD apce024 name="input.c.apce024"
            
            #END add-point
 
 
         #Ctrlp:input.c.apce025
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD apce025
            #add-point:ON ACTION controlp INFIELD apce025 name="input.c.apce025"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            
            #end add-point
            
      END INPUT
    
      #add-point:自定義input name="input.more_input"
      
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
 
   #add-point:畫面關閉前 name="input.before_close"
   
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_aapt400_12 
   
   #add-point:input段after input name="input.post_input"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aapt400_12.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aapt400_12.other_function" readonly="Y" >}

 
{</section>}
 
