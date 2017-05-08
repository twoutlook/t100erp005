#該程式未解開Section, 採用最新樣板產出!
{<section id="arti701_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2015-01-15 17:13:53), PR版次:0002(2015-01-15 17:20:21)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000126
#+ Filename...: arti701_02
#+ Description: 採購出單週
#+ Creator....: 02749(2014-03-27 15:58:58)
#+ Modifier...: 06137 -SD/PR- 06137
 
{</section>}
 
{<section id="arti701_02.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"

#end add-point
#add-point:填寫註解說明(客製用) name="main.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="main.import"

#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
#add-point:增加匯入變數檔 name="global.inc"

#end add-point
 
{</section>}
 
{<section id="arti701_02.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
   DEFINE g_week RECORD
        week01   LIKE type_t.chr5,
        week02   LIKE type_t.chr5,
        week03   LIKE type_t.chr5,
        week04   LIKE type_t.chr5,
        week05   LIKE type_t.chr5,
        week06   LIKE type_t.chr5,
        week07   LIKE type_t.chr5
              END RECORD 
   DEFINE g_week_t RECORD
        week01   LIKE type_t.chr5,
        week02   LIKE type_t.chr5,
        week03   LIKE type_t.chr5,
        week04   LIKE type_t.chr5,
        week05   LIKE type_t.chr5,
        week06   LIKE type_t.chr5,
        week07   LIKE type_t.chr5
              END RECORD               
   DEFINE g_rtka006 STRING  
#end add-point
 
{</section>}
 
{<section id="arti701_02.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="arti701_02.other_dialog" >}

 
{</section>}
 
{<section id="arti701_02.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 採購出單週
# Memo...........:
# Usage..........: CALL arti701_02(p_rtka006)
#                  RETURNING r_success,r_rtka006
# Input parameter: p_rtka006   採購出單週
# Return code....: r_success   處理狀態
#                : r_rtka006   採購出單週
# Date & Author..: 2014/03/29 By Lori
# Modify.........:
################################################################################
PUBLIC FUNCTION arti701_02(p_rtka006)
   DEFINE p_rtka006   STRING
   DEFINE r_success   LIKE type_t.num5
   DEFINE r_rtka006   STRING
   DEFINE l_success   LIKE type_t.num5
   
   LET r_success = TRUE
   LET r_rtka006 = NULL
   LET g_rtka006 = NULL
   INITIALIZE g_week.* TO NULL
   INITIALIZE g_week_t.* TO NULL
   
   OPEN WINDOW w_arti701_02 WITH FORM cl_ap_formpath("art","arti701_02")   
   CALL cl_ui_init()
   
   LET g_week.week01 = 'N'
   LET g_week.week02 = 'N'
   LET g_week.week03 = 'N'
   LET g_week.week04 = 'N'
   LET g_week.week05 = 'N'
   LET g_week.week06 = 'N'
   LET g_week.week07 = 'N' 

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
      INPUT BY NAME g_week.* ATTRIBUTE(WITHOUT DEFAULTS)
         BEFORE INPUT 
            DISPLAY BY NAME g_week.*
            IF p_rtka006 IS NOT NULL THEN
               CALL arti701_02_show_week('1',p_rtka006) RETURNING l_success
               LET g_week_t.* = g_week.*
            END IF

         AFTER INPUT
            CALL  arti701_02_append_week(g_week.week01)
            CALL  arti701_02_append_week(g_week.week02)
            CALL  arti701_02_append_week(g_week.week03)
            CALL  arti701_02_append_week(g_week.week04)
            CALL  arti701_02_append_week(g_week.week05)
            CALL  arti701_02_append_week(g_week.week06)
            CALL  arti701_02_append_week(g_week.week07)

         ON ACTION accept
            ACCEPT DIALOG
	      
         ON ACTION cancel      #在dialog button (放棄)
            LET INT_FLAG = TRUE
            EXIT DIALOG
	      
         ON ACTION exit
            LET INT_FLAG = TRUE
            EXIT DIALOG
	      
         ON ACTION close
            LET INT_FLAG = TRUE
            EXIT DIALOG
      END INPUT
   END DIALOG

   LET r_rtka006 = g_rtka006
   
   IF INT_FLAG THEN
      LET INT_FLAG = FALSE
      LET r_success = FALSE
      CLOSE WINDOW w_arti701_02
      RETURN r_success,r_rtka006
   END IF
   
   CLOSE WINDOW w_arti701_02   
   RETURN r_success,r_rtka006  
END FUNCTION

################################################################################
# Descriptions...: 將出單週組成字串
# Memo...........:
# Usage..........: CALL arti701_02_append_week(p_week)
# Input parameter: p_week        出單週
# Modify.........:
################################################################################
PRIVATE FUNCTION arti701_02_append_week(p_week)
   DEFINE p_week   STRING
   
   IF p_week <> 'N' THEN 
      IF cl_null(g_rtka006) THEN
         LET g_rtka006 = p_week
      ELSE
         LET g_rtka006 = g_rtka006,',',p_week
      END IF
   END IF  
END FUNCTION

################################################################################
# Descriptions...: 將採購出單週顯示成畫面的FLAG
# Memo...........:
# Usage..........: CALL arti701_02_show_week(p_type,p_rtka006)
#                : RETURN r_success
# Input parameter: p_type      處理情境:1.開窗show資料,2.手動輸入檢查輸入值
#                : p_rtka006   採購出單日
# Return code....: r_success   判斷結果   
# Date & Author..: 2014/03/29 By Lori
# Modify.........:
################################################################################
PUBLIC FUNCTION arti701_02_show_week(p_type,p_rtka006)
   DEFINE p_type      LIKE type_t.chr5
   DEFINE p_rtka006   STRING
   DEFINE r_success   LIKE type_t.num5
   DEFINE l_rtka006   STRING
   DEFINE l_week       STRING
   DEFINE l_i         LIKE type_t.num5
   DEFINE l_comma     LIKE type_t.num5
   
   LET l_rtka006 = p_rtka006
   LET l_comma = 0 
   
   #ken---add---s 需求單號：150107-00019 項次：1
   IF p_type = 2 THEN
      LET g_rtka006 = NULL
      INITIALIZE g_week.* TO NULL
   END IF
   #ken---add---e
   
   LET r_success = TRUE
   FOR l_i = 1 TO p_rtka006.getLength()
      LET l_comma = l_rtka006.getIndexOf(',',1)
      IF l_comma <= 0 THEN
         LET l_week = l_rtka006
      ELSE   
         LET l_week = l_rtka006.subString(1,l_comma-1) 
      END IF      
            
      CASE 
         WHEN l_week='01' OR l_week='1'
            LET g_week.week01 = '01'           
         WHEN l_week='02' OR l_week='2'
            #LET g_week.week02 = l_week='02'  
            LET g_week.week02 = '02'
         WHEN l_week='03' OR l_week='3' 
            LET g_week.week03 = '03'
         WHEN l_week='04' OR l_week='4'
            LET g_week.week04 = '04'
         WHEN l_week='05' OR l_week='5'
            LET g_week.week05 = '05' 
         WHEN l_week='06' OR l_week='6'
            LET g_week.week06 = '06'  
         WHEN l_week='07' OR l_week='7'
            LET g_week.week07 = '07'  
         OTHERWISE
            IF p_type = '2' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 'art-00380'
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET r_success = FALSE
               EXIT FOR
            END IF            
      END CASE 

      IF p_type = '1' THEN
         DISPLAY g_week.week01 TO FORMONLY.week01
         DISPLAY g_week.week02 TO FORMONLY.week02  
         DISPLAY g_week.week03 TO FORMONLY.week03 
         DISPLAY g_week.week04 TO FORMONLY.week04 
         DISPLAY g_week.week05 TO FORMONLY.week05 
         DISPLAY g_week.week06 TO FORMONLY.week06
         DISPLAY g_week.week07 TO FORMONLY.week07 
      END IF 
            
      LET l_i = l_i + l_week.getLength()      
      IF  l_i > p_rtka006.getLength() THEN
         EXIT FOR
      ELSE
         LET l_rtka006 = l_rtka006.subString(l_comma+1,l_rtka006.getLength())      
      END IF
   END FOR  

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 針對手動輸入時  自動去除重複資料，自動轉換成2位標準格式
# Memo...........:
# Usage..........: CALL arti701_02_week_chk()
# Return code....: r_rtka006      採購出單週
# Date & Author..: 2015-01-15 By Ken
# Modify.........:
################################################################################
PUBLIC FUNCTION arti701_02_week_chk()
DEFINE r_rtka006   STRING 

   LET r_rtka006 = NULL

   CALL  arti701_02_append_week(g_week.week01)
   CALL  arti701_02_append_week(g_week.week02)
   CALL  arti701_02_append_week(g_week.week03)
   CALL  arti701_02_append_week(g_week.week04)
   CALL  arti701_02_append_week(g_week.week05)
   CALL  arti701_02_append_week(g_week.week06)
   CALL  arti701_02_append_week(g_week.week07)
  
   LET r_rtka006 = g_rtka006
   RETURN r_rtka006
END FUNCTION

 
{</section>}
 
