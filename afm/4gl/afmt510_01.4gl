#該程式未解開Section, 採用最新樣板產出!
{<section id="afmt510_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2015-05-05 15:28:52), PR版次:0002(2016-11-09 18:41:53)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000037
#+ Filename...: afmt510_01
#+ Description: 延長平倉期限
#+ Creator....: 03080(2015-05-05 15:27:27)
#+ Modifier...: 03080 -SD/PR- 08171
 
{</section>}
 
{<section id="afmt510_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#Memos
#161104-00024#11 161108 By 08171  程式中DEFINE RECORD LIKE時不可以用*的寫法，要一個一個欄位定義(包含INSERT)
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
PRIVATE type type_g_fmmh_m        RECORD
       fmmh001 LIKE fmmh_t.fmmh001, 
   fmmh002 LIKE fmmh_t.fmmh002, 
   fmmh003 LIKE fmmh_t.fmmh003
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
DEFINE g_fmmh_m        type_g_fmmh_m
 
   DEFINE g_fmmh001_t LIKE fmmh_t.fmmh001
DEFINE g_fmmh002_t LIKE fmmh_t.fmmh002
DEFINE g_fmmh003_t LIKE fmmh_t.fmmh003
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="afmt510_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION afmt510_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_fmmgdocno
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
   DEFINE p_fmmgdocno     LIKE fmmg_t.fmmgdocno
  #DEFINE l_fmmh          RECORD LIKE fmmh_t.*   #161104-00024#11 mark
   #161104-00024#11 --s add
   DEFINE l_fmmh RECORD  #延長平倉期限記錄檔
          fmmhent LIKE fmmh_t.fmmhent, #企業編號
          fmmh001 LIKE fmmh_t.fmmh001, #投資確認單號
          fmmh002 LIKE fmmh_t.fmmh002, #原始平倉日期
          fmmh003 LIKE fmmh_t.fmmh003, #更新平倉日期
          fmmhud001 LIKE fmmh_t.fmmhud001, #自定義欄位(文字)001
          fmmhud002 LIKE fmmh_t.fmmhud002, #自定義欄位(文字)002
          fmmhud003 LIKE fmmh_t.fmmhud003, #自定義欄位(文字)003
          fmmhud004 LIKE fmmh_t.fmmhud004, #自定義欄位(文字)004
          fmmhud005 LIKE fmmh_t.fmmhud005, #自定義欄位(文字)005
          fmmhud006 LIKE fmmh_t.fmmhud006, #自定義欄位(文字)006
          fmmhud007 LIKE fmmh_t.fmmhud007, #自定義欄位(文字)007
          fmmhud008 LIKE fmmh_t.fmmhud008, #自定義欄位(文字)008
          fmmhud009 LIKE fmmh_t.fmmhud009, #自定義欄位(文字)009
          fmmhud010 LIKE fmmh_t.fmmhud010, #自定義欄位(文字)010
          fmmhud011 LIKE fmmh_t.fmmhud011, #自定義欄位(數字)011
          fmmhud012 LIKE fmmh_t.fmmhud012, #自定義欄位(數字)012
          fmmhud013 LIKE fmmh_t.fmmhud013, #自定義欄位(數字)013
          fmmhud014 LIKE fmmh_t.fmmhud014, #自定義欄位(數字)014
          fmmhud015 LIKE fmmh_t.fmmhud015, #自定義欄位(數字)015
          fmmhud016 LIKE fmmh_t.fmmhud016, #自定義欄位(數字)016
          fmmhud017 LIKE fmmh_t.fmmhud017, #自定義欄位(數字)017
          fmmhud018 LIKE fmmh_t.fmmhud018, #自定義欄位(數字)018
          fmmhud019 LIKE fmmh_t.fmmhud019, #自定義欄位(數字)019
          fmmhud020 LIKE fmmh_t.fmmhud020, #自定義欄位(數字)020
          fmmhud021 LIKE fmmh_t.fmmhud021, #自定義欄位(日期時間)021
          fmmhud022 LIKE fmmh_t.fmmhud022, #自定義欄位(日期時間)022
          fmmhud023 LIKE fmmh_t.fmmhud023, #自定義欄位(日期時間)023
          fmmhud024 LIKE fmmh_t.fmmhud024, #自定義欄位(日期時間)024
          fmmhud025 LIKE fmmh_t.fmmhud025, #自定義欄位(日期時間)025
          fmmhud026 LIKE fmmh_t.fmmhud026, #自定義欄位(日期時間)026
          fmmhud027 LIKE fmmh_t.fmmhud027, #自定義欄位(日期時間)027
          fmmhud028 LIKE fmmh_t.fmmhud028, #自定義欄位(日期時間)028
          fmmhud029 LIKE fmmh_t.fmmhud029, #自定義欄位(日期時間)029
          fmmhud030 LIKE fmmh_t.fmmhud030, #自定義欄位(日期時間)030
          fmmh004 LIKE fmmh_t.fmmh004  #異動日期
   END RECORD
   #161104-00024#11 --e add
   DEFINE l_date          DATETIME YEAR TO SECOND
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_afmt510_01 WITH FORM cl_ap_formpath("afm","afmt510_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   WHENEVER ERROR CONTINUE
   INITIALIZE g_fmmh_m.* TO NULL
   SELECT fmmgdocno,fmmg001 INTO g_fmmh_m.fmmh001,g_fmmh_m.fmmh002
     FROM fmmg_t
    WHERE fmmgent = g_enterprise
      AND fmmgdocno = p_fmmgdocno
      
   LET l_date = cl_get_current()   
   LET g_fmmh_m.fmmh003 = l_date
   IF  g_fmmh_m.fmmh003 <= g_fmmh_m.fmmh002 THEN
      LET g_fmmh_m.fmmh003 =  g_fmmh_m.fmmh002 + 1
   END IF
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_fmmh_m.fmmh001,g_fmmh_m.fmmh002,g_fmmh_m.fmmh003 ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmh001
            #add-point:BEFORE FIELD fmmh001 name="input.b.fmmh001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmh001
            
            #add-point:AFTER FIELD fmmh001 name="input.a.fmmh001"
            #應用 a05 樣板自動產生(Version:2)

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmh001
            #add-point:ON CHANGE fmmh001 name="input.g.fmmh001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmh002
            #add-point:BEFORE FIELD fmmh002 name="input.b.fmmh002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmh002
            
            #add-point:AFTER FIELD fmmh002 name="input.a.fmmh002"
            #應用 a05 樣板自動產生(Version:2)

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmh002
            #add-point:ON CHANGE fmmh002 name="input.g.fmmh002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fmmh003
            #add-point:BEFORE FIELD fmmh003 name="input.b.fmmh003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fmmh003
            
            #add-point:AFTER FIELD fmmh003 name="input.a.fmmh003"
            IF NOT cl_null(g_fmmh_m.fmmh003)THEN
            
               IF g_fmmh_m.fmmh003 <= g_fmmh_m.fmmh002 THEN
                  LET g_fmmh_m.fmmh003 =  g_fmmh_m.fmmh002 + 1
                  INITIALIZE g_errparam.* TO NULL
                  LET g_errparam.code = 'afm-00113'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD fmmh003
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fmmh003
            #add-point:ON CHANGE fmmh003 name="input.g.fmmh003"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.fmmh001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmh001
            #add-point:ON ACTION controlp INFIELD fmmh001 name="input.c.fmmh001"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmmh002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmh002
            #add-point:ON ACTION controlp INFIELD fmmh002 name="input.c.fmmh002"
            
            #END add-point
 
 
         #Ctrlp:input.c.fmmh003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fmmh003
            #add-point:ON ACTION controlp INFIELD fmmh003 name="input.c.fmmh003"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            IF NOT cl_null(g_fmmh_m.fmmh003)THEN
            
               IF g_fmmh_m.fmmh003 <= g_fmmh_m.fmmh002 THEN
                  LET g_fmmh_m.fmmh003 =  g_fmmh_m.fmmh002 + 1 
                  INITIALIZE g_errparam.* TO NULL
                  LET g_errparam.code = 'afm-00113'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD fmmh003
               END IF
            END IF
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
   CLOSE WINDOW w_afmt510_01 
   
   #add-point:input段after input name="input.post_input"
   IF INT_FLAG THEN
      LET INT_FLAG = 0 
      RETURN
   ELSE
   END IF
   
   #開transaction
   #LOCK
   #INSERT fmmh_t
   INITIALIZE l_fmmh.* TO NULL
   LET l_fmmh.fmmhent = g_enterprise
   LET l_fmmh.fmmh001 = g_fmmh_m.fmmh001
   LET l_fmmh.fmmh002 = g_fmmh_m.fmmh002
   LET l_fmmh.fmmh003 = g_fmmh_m.fmmh003
   LET l_fmmh.fmmh004 = l_date
  #INSERT INTO fmmh_t VALUES(l_fmmh.*) #161104-00024#11  mark
   #161104-00024#11 --s add
   INSERT INTO fmmh_t(fmmhent,fmmh001,fmmh002,fmmh003,fmmhud001,
                      fmmhud002,fmmhud003,fmmhud004,fmmhud005,fmmhud006,
                      fmmhud007,fmmhud008,fmmhud009,fmmhud010,fmmhud011,
                      fmmhud012,fmmhud013,fmmhud014,fmmhud015,fmmhud016,
                      fmmhud017,fmmhud018,fmmhud019,fmmhud020,fmmhud021,
                      fmmhud022,fmmhud023,fmmhud024,fmmhud025,fmmhud026,
                      fmmhud027,fmmhud028,fmmhud029,fmmhud030,fmmh004)
   VALUES(l_fmmh.fmmhent,l_fmmh.fmmh001,l_fmmh.fmmh002,l_fmmh.fmmh003,l_fmmh.fmmhud001,
          l_fmmh.fmmhud002,l_fmmh.fmmhud003,l_fmmh.fmmhud004,l_fmmh.fmmhud005,l_fmmh.fmmhud006,
          l_fmmh.fmmhud007,l_fmmh.fmmhud008,l_fmmh.fmmhud009,l_fmmh.fmmhud010,l_fmmh.fmmhud011,
          l_fmmh.fmmhud012,l_fmmh.fmmhud013,l_fmmh.fmmhud014,l_fmmh.fmmhud015,l_fmmh.fmmhud016,
          l_fmmh.fmmhud017,l_fmmh.fmmhud018,l_fmmh.fmmhud019,l_fmmh.fmmhud020,l_fmmh.fmmhud021,
          l_fmmh.fmmhud022,l_fmmh.fmmhud023,l_fmmh.fmmhud024,l_fmmh.fmmhud025,l_fmmh.fmmhud026,
          l_fmmh.fmmhud027,l_fmmh.fmmhud028,l_fmmh.fmmhud029,l_fmmh.fmmhud030,l_fmmh.fmmh004)
   #161104-00024#11 --e add
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam.* TO NULL
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.extend = 'ins_fmmh'
      CALL cl_err()
   END IF
   #UPDATE fmmg_t
   UPDATE fmmg_t SET fmmg001 = l_fmmh.fmmh003
    WHERE fmmgent = g_enterprise
      AND fmmgdocno = l_fmmh.fmmh001
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam.* TO NULL
      LET g_errparam.code = SQLCA.SQLCODE
      LET g_errparam.extend = 'upd_fmmg'
      CALL cl_err()
   END IF
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="afmt510_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="afmt510_01.other_function" readonly="Y" >}

 
{</section>}
 
