#該程式未解開Section, 採用最新樣板產出!
{<section id="aisq531_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2016-03-02 10:22:37), PR版次:0003(2016-11-09 19:39:18)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000027
#+ Filename...: aisq531_01
#+ Description: 列印中獎發票
#+ Creator....: 05016(2016-03-02 10:20:17)
#+ Modifier...: 05016 -SD/PR- 08171
 
{</section>}
 
{<section id="aisq531_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160905-00002#4    2016/09/05 By 06821  補入WHERE條件漏掉ENT的部分
#161104-00024#10   2016/11/08 By 08171  程式中DEFINE RECORD LIKE時不可以用*的寫法，要一個一個欄位定義
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
PRIVATE type type_g_isaw_m        RECORD
       isaw014 LIKE isaw_t.isaw014
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
DEFINE g_isaw_m        type_g_isaw_m
 
   
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aisq531_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION aisq531_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_isawcomp,p_isaw002,p_isaw003
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
   DEFINE p_isawcomp LIKE isaw_t.isawcomp
   DEFINE p_isaw002  LIKE isaw_t.isaw002
   DEFINE p_isaw003  LIKE isaw_t.isaw003
   DEFINE l_cnt      LIKE type_t.num5
   DEFINE l_n        LIKE type_t.num5
   DEFINE  l_isaw DYNAMIC ARRAY OF RECORD
          isaw001 LIKE isaw_t.isaw001, #統一編號
          isaw005 LIKE isaw_t.isaw005,
          isaw020 LIKE isaw_t.isaw020,
          isaw021 LIKE isaw_t.isaw021,
          isaw023 LIKE isaw_t.isaw023,
          isaw029 LIKE isaw_t.isaw029
   END RECORD
   DEFINE l_k LIKE type_t.num5   
   DEFINE r_success LIKE type_t.num5
   DEFINE r_errno   LIKE gzze_t.gzze001
  #DEFINE l_isax    RECORD LIKE isax_t.*   #161104-00024#10 mark
   #161104-00024#10 --s add
   DEFINE l_isax RECORD  #電子發票列印異動紀錄檔
          isaxent LIKE isax_t.isaxent, #企業編號
          isaxseq LIKE isax_t.isaxseq, #項次
          isax001 LIKE isax_t.isax001, #總公司統一編號
          isax002 LIKE isax_t.isax002, #發票所屬年度
          isax003 LIKE isax_t.isax003, #發票所屬月份
          isax004 LIKE isax_t.isax004, #發票編號
          isax005 LIKE isax_t.isax005, #發票號碼
          isax006 LIKE isax_t.isax006, #載具顯碼ID
          isax007 LIKE isax_t.isax007, #異動原因
          isax008 LIKE isax_t.isax008, #異動類型
          isax009 LIKE isax_t.isax009, #異動日期
          isax010 LIKE isax_t.isax010, #異動人員
          isax011 LIKE isax_t.isax011, #異動時間
          isaxcomp LIKE isax_t.isaxcomp, #法人
          isaxsite LIKE isax_t.isaxsite, #營運據點
          isaxud001 LIKE isax_t.isaxud001, #自定義欄位(文字)001
          isaxud002 LIKE isax_t.isaxud002, #自定義欄位(文字)002
          isaxud003 LIKE isax_t.isaxud003, #自定義欄位(文字)003
          isaxud004 LIKE isax_t.isaxud004, #自定義欄位(文字)004
          isaxud005 LIKE isax_t.isaxud005, #自定義欄位(文字)005
          isaxud006 LIKE isax_t.isaxud006, #自定義欄位(文字)006
          isaxud007 LIKE isax_t.isaxud007, #自定義欄位(文字)007
          isaxud008 LIKE isax_t.isaxud008, #自定義欄位(文字)008
          isaxud009 LIKE isax_t.isaxud009, #自定義欄位(文字)009
          isaxud010 LIKE isax_t.isaxud010, #自定義欄位(文字)010
          isaxud011 LIKE isax_t.isaxud011, #自定義欄位(數字)011
          isaxud012 LIKE isax_t.isaxud012, #自定義欄位(數字)012
          isaxud013 LIKE isax_t.isaxud013, #自定義欄位(數字)013
          isaxud014 LIKE isax_t.isaxud014, #自定義欄位(數字)014
          isaxud015 LIKE isax_t.isaxud015, #自定義欄位(數字)015
          isaxud016 LIKE isax_t.isaxud016, #自定義欄位(數字)016
          isaxud017 LIKE isax_t.isaxud017, #自定義欄位(數字)017
          isaxud018 LIKE isax_t.isaxud018, #自定義欄位(數字)018
          isaxud019 LIKE isax_t.isaxud019, #自定義欄位(數字)019
          isaxud020 LIKE isax_t.isaxud020, #自定義欄位(數字)020
          isaxud021 LIKE isax_t.isaxud021, #自定義欄位(日期時間)021
          isaxud022 LIKE isax_t.isaxud022, #自定義欄位(日期時間)022
          isaxud023 LIKE isax_t.isaxud023, #自定義欄位(日期時間)023
          isaxud024 LIKE isax_t.isaxud024, #自定義欄位(日期時間)024
          isaxud025 LIKE isax_t.isaxud025, #自定義欄位(日期時間)025
          isaxud026 LIKE isax_t.isaxud026, #自定義欄位(日期時間)026
          isaxud027 LIKE isax_t.isaxud027, #自定義欄位(日期時間)027
          isaxud028 LIKE isax_t.isaxud028, #自定義欄位(日期時間)028
          isaxud029 LIKE isax_t.isaxud029, #自定義欄位(日期時間)029
          isaxud030 LIKE isax_t.isaxud030  #自定義欄位(日期時間)030
   END RECORD
   #161104-00024#10 --e add
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aisq531_01 WITH FORM cl_ap_formpath("ais","aisq531_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   LET g_isaw_m.isaw014 =''
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_isaw_m.isaw014 ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD isaw014
            #add-point:BEFORE FIELD isaw014 name="input.b.isaw014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD isaw014
            
            #add-point:AFTER FIELD isaw014 name="input.a.isaw014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE isaw014
            #add-point:ON CHANGE isaw014 name="input.g.isaw014"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.isaw014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD isaw014
            #add-point:ON ACTION controlp INFIELD isaw014 name="input.c.isaw014"
            
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
   IF INT_FLAG THEN
      LET r_success = TRUE
      LET INT_FLAG = FALSE
      CLOSE WINDOW w_aisq531_01
      RETURN r_success,r_errno
   END IF
   #end add-point
   
   #畫面關閉
   CLOSE WINDOW w_aisq531_01 
   
   #add-point:input段after input name="input.post_input"
   LET r_success = TRUE
   IF NOT cl_null(g_isaw_m.isaw014) THEN
      LET l_cnt = 0
      SELECT COUNT(*) INTO l_cnt
        FROM isaw_t
       WHERE isawent  = g_enterprise
         AND isawcomp = p_isawcomp      #統編
         AND isaw002  = p_isaw002       #年度 
         AND isaw003  = p_isaw003       #月份
         AND isaw014  = g_isaw_m.isaw014
         AND isaw029 = 'N'
      IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
      IF l_cnt = 0  THEN
         LET r_errno = 'ais-00293'
         LET r_success = FALSE
         RETURN r_success,r_errno         
      END IF  
   END IF
   LET l_k = 1
   CALL l_isaw.clear()
   # 將此其同一載具的中獎發票一起列印出來
   # 為避免FOREACH迴圈因為呼叫了aisr520而被中斷，所以先將資料放到ARRAY中
   DECLARE aisq531_curs CURSOR FOR
    SELECT isaw001,isaw005,isaw020,isaw021,isaw023,isaw029 FROM isaw_t
     WHERE isawent  = g_enterprise
       AND isawcomp = p_isawcomp      #統編
       AND isaw002  = p_isaw002       #年度 
       AND isaw003  = p_isaw003       #月份
       AND isaw014  = g_isaw_m.isaw014
       AND isaw029  = 'N'
       
   FOREACH aisq531_curs INTO l_isaw[l_k].*
      # 欄位檢查
      IF cl_null(l_isaw[l_k].isaw020) OR l_isaw[l_k].isaw020 <> 'N' THEN    # 大平台已匯款註記
         LET r_errno = 'ais-00294'
         LET r_success = FALSE
         RETURN r_success,r_errno
      END IF
      IF cl_null(l_isaw[l_k].isaw021) OR l_isaw[l_k].isaw021 <> 'A' THEN       # 資料類別(A:會員廠商)
         LET r_errno = 'ais-00295'
         LET r_success = FALSE
         RETURN r_success,r_errno
      END IF
      IF cl_null(l_isaw[l_k].isaw023) OR l_isaw[l_k].isaw023 NOT MATCHES 'T[123456]' THEN    # 列印格式
         LET r_errno = 'ais-00296'
         LET r_success = FALSE
         RETURN r_success,r_errno
      END IF
      IF cl_null(l_isaw[l_k].isaw029) OR l_isaw[l_k].isaw029 <> 'N' THEN    # 列印否
         LET r_errno = 'ais-00297'
         LET r_success = FALSE
         RETURN r_success,r_errno
      END IF
      LET l_k = l_k + 1   
   END FOREACH   
   LET l_k = l_k - 1
   CALL l_isaw.deleteElement(l_isaw.getLength())
   
   IF r_success AND l_k > 0 THEN
      FOR l_cnt = 1 TO l_k # 列印中獎發票 
         #若為中奬發票列印將 isat021(列印次數) 設定為 1 
         #及更新電子發票中獎清冊的發票列印碼為 Y, 再開始列印.
         LET l_count = 0
         SELECT COUNT(*) INTO l_count FROM isat_t
          WHERE isatent = g_enterprise AND isat004 = l_isaw[l_cnt].isaw005 
            AND isat002 = 'Y' AND isat014 = '11' AND isat206 = g_isaw_m.isaw014
         IF cl_null(l_count) THEN LET l_count = 0 END IF
         IF l_count = 0 THEN
            INITIALIZE g_errparam TO NULL 
            LET g_errparam.code = 'ais-00267'
            LET g_errparam.extend = l_isaw[l_cnt].isaw005  
            LET g_errparam.popup = TRUE
            CALL cl_err()  
            IF l_cnt < l_k THEN
               IF NOT cl_ask_confirm("ais-00298") THEN            
                  EXIT FOR
               ELSE
                  CONTINUE FOR
               END IF             
            END IF    
            IF l_cnt = l_k THEN CONTINUE FOR END IF            
         ELSE
            UPDATE isat_t 
               SET isat021 = 1
             WHERE isatent = g_enterprise AND isat004 = l_isaw[l_cnt].isaw005  
               AND isat014 = '11' AND isat002 = 'Y'            
               AND isat206 = g_isaw_m.isaw014 #載具顯碼ＩＤ
            CALL aisr520_g01(' 1 =1' ,l_isaw[l_cnt].isaw005,'N','3')         
         END IF     
         UPDATE isaw_t 
           SET isaw030 = g_user,isaw029 = 'Y'             
          WHERE isawent  = g_enterprise
            AND isawcomp = p_isawcomp      #統編
            AND isaw002  = p_isaw002       #年度 
            AND isaw003  = p_isaw003       #月份
            AND isaw014  = g_isaw_m.isaw014
         
         # 寫入列印異動清單中
          LET l_n = 0
          SELECT MAX(isaxseq)+1 INTO l_n FROM isax_t
           #WHERE isaxcomp = p_isawcomp                            #160905-00002#4 mark
           WHERE isaxent  = g_enterprise AND isaxcomp = p_isawcomp #160905-00002#4 add
             AND isax002  = p_isaw002
             AND isax003  = p_isaw003
             
          IF cl_null(l_n) THEN
             LET l_n = 1
          END IF
          
          LET l_isax.isax001 = l_isaw[l_cnt].isaw001
          LET l_isax.isax002 = p_isaw002
          LET l_isax.isax003 = p_isaw003
          LET l_isax.isax004 = ' '
          LET l_isax.isax005 = l_isaw[l_cnt].isaw005
          LET l_isax.isax006 = g_isaw_m.isaw014
          LET l_isax.isax007 = ' '
          LET l_isax.isax008 = '1'
          LET l_isax.isax009 = g_today
          LET l_isax.isax010 = g_user
          LET l_isax.isax011 = cl_get_current()
          LET l_isax.isaxseq = l_n
          LET l_isax.isaxent = g_enterprise
          LET l_isax.isaxcomp = p_isawcomp
          LET l_isax.isaxsite = p_isawcomp
          
          INSERT INTO isax_t
          VALUES (l_isax.*)
          IF l_cnt < l_k THEN
             IF NOT cl_ask_confirm("ais-00298") THEN            
                EXIT FOR
             END IF
          END IF                    
      END FOR
   END IF
   RETURN r_success,r_errno
   
   
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aisq531_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aisq531_01.other_function" readonly="Y" >}

 
{</section>}
 
