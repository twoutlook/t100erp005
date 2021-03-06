#該程式未解開Section, 採用最新樣板產出!
{<section id="azzi911_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2015-11-09 15:01:08), PR版次:0002(2016-08-26 10:37:42)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000030
#+ Filename...: azzi911_01
#+ Description: 匯出42m
#+ Creator....: 02667(2015-11-09 13:43:32)
#+ Modifier...: 02667 -SD/PR- 01856
 
{</section>}
 
{<section id="azzi911_01.global" >}
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
PRIVATE type type_g_gzzi_m        RECORD
       gzzi001 LIKE gzzi_t.gzzi001, 
   gzzi002 LIKE gzzi_t.gzzi002, 
   gzzi003 LIKE gzzi_t.gzzi003, 
   gzzistus LIKE gzzi_t.gzzistus
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
DEFINE g_gzzi_m        type_g_gzzi_m
 
   DEFINE g_gzzi001_t LIKE gzzi_t.gzzi001
DEFINE g_gzzi002_t LIKE gzzi_t.gzzi002
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="azzi911_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION azzi911_01(--)
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
   OPEN WINDOW w_azzi911_01 WITH FORM cl_ap_formpath("azz","azzi911_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_gzzi_m.gzzi001,g_gzzi_m.gzzi002,g_gzzi_m.gzzi003,g_gzzi_m.gzzistus ATTRIBUTE(WITHOUT  
          DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzzi001
            #add-point:BEFORE FIELD gzzi001 name="input.b.gzzi001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzzi001
            
            #add-point:AFTER FIELD gzzi001 name="input.a.gzzi001"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_gzzi_m.gzzi001) AND NOT cl_null(g_gzzi_m.gzzi002) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_gzzi_m.gzzi001 != g_gzzi001_t  OR g_gzzi_m.gzzi002 != g_gzzi002_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gzzi_t WHERE "||"gzzi001 = '"||g_gzzi_m.gzzi001 ||"' AND "|| "gzzi002 = '"||g_gzzi_m.gzzi002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzzi001
            #add-point:ON CHANGE gzzi001 name="input.g.gzzi001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzzi002
            #add-point:BEFORE FIELD gzzi002 name="input.b.gzzi002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzzi002
            
            #add-point:AFTER FIELD gzzi002 name="input.a.gzzi002"
            #應用 a05 樣板自動產生(Version:2)
            #確認資料無重複
            IF  NOT cl_null(g_gzzi_m.gzzi001) AND NOT cl_null(g_gzzi_m.gzzi002) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_gzzi_m.gzzi001 != g_gzzi001_t  OR g_gzzi_m.gzzi002 != g_gzzi002_t )) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM gzzi_t WHERE "||"gzzi001 = '"||g_gzzi_m.gzzi001 ||"' AND "|| "gzzi002 = '"||g_gzzi_m.gzzi002 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzzi002
            #add-point:ON CHANGE gzzi002 name="input.g.gzzi002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzzi003
            #add-point:BEFORE FIELD gzzi003 name="input.b.gzzi003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzzi003
            
            #add-point:AFTER FIELD gzzi003 name="input.a.gzzi003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzzi003
            #add-point:ON CHANGE gzzi003 name="input.g.gzzi003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD gzzistus
            #add-point:BEFORE FIELD gzzistus name="input.b.gzzistus"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD gzzistus
            
            #add-point:AFTER FIELD gzzistus name="input.a.gzzistus"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE gzzistus
            #add-point:ON CHANGE gzzistus name="input.g.gzzistus"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.gzzi001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzzi001
            #add-point:ON ACTION controlp INFIELD gzzi001 name="input.c.gzzi001"
            
            #END add-point
 
 
         #Ctrlp:input.c.gzzi002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzzi002
            #add-point:ON ACTION controlp INFIELD gzzi002 name="input.c.gzzi002"
            
            #END add-point
 
 
         #Ctrlp:input.c.gzzi003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzzi003
            #add-point:ON ACTION controlp INFIELD gzzi003 name="input.c.gzzi003"
            
            #END add-point
 
 
         #Ctrlp:input.c.gzzistus
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD gzzistus
            #add-point:ON ACTION controlp INFIELD gzzistus name="input.c.gzzistus"
            
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
   CLOSE WINDOW w_azzi911_01 
   
   #add-point:input段after input name="input.post_input"
   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="azzi911_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="azzi911_01.other_function" readonly="Y" >}

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
PUBLIC FUNCTION azzi911_01_export_42m(ps_gzzi001,ps_gzzi002,ps_type)
   DEFINE ps_gzzi001      LIKE gzzi_t.gzzi001 #程式編號
   DEFINE ps_gzzi002      LIKE gzzi_t.gzzi002 #模組別
   DEFINE ps_type         CHAR(1)             #1-前景/2-背景
   DEFINE ls_gzzi003      LIKE gzzi_t.gzzi003 #MD5
   DEFINE ls_gzzi003_chk  LIKE gzzi_t.gzzi003 #MD5
   DEFINE ls_gzzi004      LIKE gzzi_t.gzzi004 #42m
   DEFINE ls_gzzi004_chk  LIKE gzzi_t.gzzi004 #42m
   DEFINE ls_tmp          STRING              #路徑
   DEFINE ls_42m          STRING              #路徑
   DEFINE ls_42m_bak      STRING              #路徑
   DEFINE ls_msg          STRING              
   DEFINE ls_title        STRING              
   
   LOCATE ls_gzzi004     IN FILE
   LOCATE ls_gzzi004_chk IN FILE
   
   #先撈出MD5,42m
   SELECT gzzi003,gzzi004 INTO ls_gzzi003,ls_gzzi004
     FROM gzzi_t 
    WHERE gzzi001 = ps_gzzi001
      AND gzzi002 = ps_gzzi002
   
   CALL azzi911_01_read_42m(ps_gzzi001) 
      RETURNING ls_gzzi003_chk, #新MD5
                ls_gzzi004_chk  #42m

   IF ls_gzzi003 = ls_gzzi003_chk THEN
      #提示完成
      IF ps_type = '1' THEN
         ERROR '42m無異動不需匯出!'
      END IF
      FREE ls_gzzi004    
      FREE ls_gzzi004_chk
	   RETURN
   ELSE
      DISPLAY '檢查完畢,進行匯出!'
   END IF

   #先詢問是否確認匯出
   IF ps_type = 1 THEN
      LET ls_msg = cl_getmsg("adz-00717",g_lang)
      LET ls_title = cl_getmsg("adz-00718",g_lang)
      
      #執行開窗詢問
      IF NOT cl_ask_type1(ls_msg,ls_title) THEN
         #取消匯出
         RETURN
         FREE ls_gzzi004    
         FREE ls_gzzi004_chk
      END IF
   END IF
   
   #組合原檔路徑&名稱
   LET ls_tmp = DOWNSHIFT(ps_gzzi002),'_',ps_gzzi001,".42m"
   LET ls_42m = os.Path.join(FGL_GETENV(UPSHIFT(ps_gzzi002)),"42m")
   LET ls_42m = os.Path.join(ls_42m,ls_tmp)
   DISPLAY "42m位置:",ls_42m

   #組合備份檔路徑&名稱
   LET ls_tmp     = DOWNSHIFT(ps_gzzi002),'_',ps_gzzi001,".bak"
   LET ls_42m_bak = os.Path.join(FGL_GETENV(UPSHIFT(ps_gzzi002)),"42m")
   LET ls_42m_bak = os.Path.join(ls_42m_bak,ls_tmp)
   DISPLAY "42m(bak)位置:",ls_42m_bak
   
   #先檢查原檔是否存在
   IF NOT os.Path.exists(ls_42m) THEN
      #複製原檔為備份檔(.bck)
      IF os.Path.copy(ls_42m,ls_42m_bak) THEN
         DISPLAY "INFO:複製原42m檔案為:",ls_42m_bak
      ELSE
         DISPLAY "WARNING:42m備份失敗!"
         #FREE ls_gzzi004    
         #FREE ls_gzzi004_chk
         #RETURN
      END IF
   END IF

   #寫入到對應路徑下
   #LET ls_42m = ls_42m,'.test'
   CALL ls_gzzi004.writeFile(ls_42m)
   
   #提示完成
   IF ps_type = '1' THEN
      ERROR "匯出完成!"
   END IF
   
   FREE ls_gzzi004    
   FREE ls_gzzi004_chk
   
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
PUBLIC FUNCTION azzi911_01_read_42m(ps_gzza001)
   DEFINE ps_gzza001        LIKE gzza_t.gzza001 #程式名稱
   DEFINE ls_gzza003        LIKE gzza_t.gzza003 #模組名稱
   DEFINE ls_gzzi003        LIKE gzzi_t.gzzi003 #MD5
   DEFINE ls_gzzi004        LIKE gzzi_t.gzzi004
   DEFINE ls_filename       STRING
   DEFINE ls_42m            STRING
   DEFINE lb_chk            BOOLEAN
  
   LOCATE ls_gzzi004 IN FILE 
  
   #讀取42m md5
   LET ls_gzza003 = ""
   
   #先抓模組
   SELECT gzza003 INTO ls_gzza003
     FROM gzza_t 
    WHERE gzza001 = ps_gzza001
    
   #如果azzi900找不到換找azzi901
   IF cl_null(ls_gzza003) THEN
      SELECT gzde002 INTO ls_gzza003
        FROM gzde_t 
       WHERE gzde001 = ps_gzza001
   END IF
   
   IF cl_null(ls_gzza003) THEN
      DISPLAY '找不到該程式(',ps_gzza001,')資料!'
   ELSE
      LET ls_42m = DOWNSHIFT(ls_gzza003),'_',ps_gzza001,".42m"
      LET ls_filename = os.Path.join(FGL_GETENV(UPSHIFT(ls_gzza003)),"42m")
      LET ls_filename = os.Path.join(ls_filename,ls_42m)
      DISPLAY "42m位置:",ls_filename
      
      IF NOT os.Path.exists(ls_filename) THEN
         DISPLAY "ERROR:檔案:",ls_filename.trim()," 不存在!"
         RETURN ls_gzzi003, #新MD5
         ls_gzzi004  #42m
      END IF
      
      CALL ls_gzzi004.readFile(ls_filename)
      
      #計算MD5
      LET ls_gzzi003 = sadzi100_counting_md5(ls_filename) #新MD5
   END IF
   
   RETURN ls_gzzi003, #新MD5
          ls_gzzi004  #42m
      
END FUNCTION

 
{</section>}
 
