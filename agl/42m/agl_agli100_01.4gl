#該程式未解開Section, 採用最新樣板產出!
{<section id="agli100_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2016-06-06 14:29:21), PR版次:0002(2017-01-09 15:39:31)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000022
#+ Filename...: agli100_01
#+ Description: 會計週期產生
#+ Creator....: 02599(2016-06-06 14:25:16)
#+ Modifier...: 02599 -SD/PR- 02599
 
{</section>}
 
{<section id="agli100_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#Memos
#170109-00033#1   2017/01/09  By 02599     修改跨年设置会计周期时，自动产生期别、季别的逻辑
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
PRIVATE type type_g_glav_m        RECORD
       glav001 LIKE glav_t.glav001, 
   glav001_desc LIKE type_t.chr80, 
   glav002 LIKE glav_t.glav002, 
   glav003 LIKE glav_t.glav003, 
   glav004_s LIKE type_t.dat, 
   glav004_e LIKE type_t.dat
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_glav004_t LIKE glav_t.glav004
#end add-point
 
DEFINE g_glav_m        type_g_glav_m
 
   DEFINE g_glav001_t LIKE glav_t.glav001
DEFINE g_glav002_t LIKE glav_t.glav002
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="agli100_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION agli100_01(--)
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
   DEFINE l_ooal001       LIKE ooal_t.ooal001
   DEFINE l_ooalstus      LIKE ooal_t.ooalstus
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_agli100_01 WITH FORM cl_ap_formpath("agl","agli100_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   CALL cl_set_combo_scc('glav003','9416') 
   INITIALIZE g_glav_m.* TO NULL
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_glav_m.glav001,g_glav_m.glav002,g_glav_m.glav003,g_glav_m.glav004_s,g_glav_m.glav004_e  
          ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            IF cl_null(g_glav_m.glav002) OR g_glav_m.glav002 = 0 THEN
               LET g_glav_m.glav002=YEAR(g_today) + 1
            END IF
            LET g_glav_m.glav003='1'
            LET g_glav_m.glav004_s=MDY(1,1,g_glav_m.glav002)
            LET g_glav_m.glav004_e=MDY(12,31,g_glav_m.glav002)
            DISPLAY BY NAME g_glav_m.glav002,g_glav_m.glav003,g_glav_m.glav004_s,g_glav_m.glav004_e
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glav001
            
            #add-point:AFTER FIELD glav001 name="input.a.glav001"
            

            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF NOT cl_null(g_glav_m.glav001) THEN
               SELECT ooal001,ooalstus INTO l_ooal001,l_ooalstus FROM ooal_t
                WHERE ooalent = g_enterprise AND ooal001 = '13'
                  AND ooal002 = g_glav_m.glav001
               IF SQLCA.SQLCODE = 100 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'agl-00113'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_glav_m.glav001 = g_glav001_t
                  CALL s_desc_ooal002_desc('5',g_glav_m.glav001) RETURNING g_glav_m.glav001_desc
                  DISPLAY BY NAME g_glav_m.glav001_desc
                  NEXT FIELD CURRENT
               END IF
               IF l_ooalstus = 'N' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'sub-01302'
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_glav_m.glav001 = g_glav001_t
                  CALL s_desc_ooal002_desc('5',g_glav_m.glav001) RETURNING g_glav_m.glav001_desc
                  DISPLAY BY NAME g_glav_m.glav001_desc
                  NEXT FIELD CURRENT
               END IF
               IF NOT cl_null(g_glav_m.glav002) THEN 
                  #重複性檢查
                  CALL agli100_01_glav_chk()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     LET g_glav_m.glav001 = g_glav001_t
                     CALL s_desc_ooal002_desc('5',g_glav_m.glav001) RETURNING g_glav_m.glav001_desc
                     DISPLAY BY NAME g_glav_m.glav001_desc
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            CALL s_desc_ooal002_desc('5',g_glav_m.glav001) RETURNING g_glav_m.glav001_desc
            DISPLAY BY NAME g_glav_m.glav001_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glav001
            #add-point:BEFORE FIELD glav001 name="input.b.glav001"
            LET g_glav001_t = g_glav_m.glav001
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glav001
            #add-point:ON CHANGE glav001 name="input.g.glav001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glav002
            #add-point:BEFORE FIELD glav002 name="input.b.glav002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glav002
            
            #add-point:AFTER FIELD glav002 name="input.a.glav002"
            #應用 a05 樣板自動產生(Version:3)
            #確認資料無重複
            IF NOT cl_null(g_glav_m.glav001) AND NOT cl_null(g_glav_m.glav002) THEN 
               #重複性檢查
               CALL agli100_01_glav_chk()
               IF NOT cl_null(g_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = ''
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD CURRENT
               END IF
               LET g_glav_m.glav004_s=MDY(1,1,g_glav_m.glav002)
               LET g_glav_m.glav004_e=MDY(12,31,g_glav_m.glav002)
               DISPLAY BY NAME g_glav_m.glav004_s,g_glav_m.glav004_e 
            END IF




            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glav002
            #add-point:ON CHANGE glav002 name="input.g.glav002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glav003
            #add-point:BEFORE FIELD glav003 name="input.b.glav003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glav003
            
            #add-point:AFTER FIELD glav003 name="input.a.glav003"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glav003
            #add-point:ON CHANGE glav003 name="input.g.glav003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glav004_s
            #add-point:BEFORE FIELD glav004_s name="input.b.glav004_s"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glav004_s
            
            #add-point:AFTER FIELD glav004_s name="input.a.glav004_s"
            IF NOT cl_null(g_glav_m.glav004_s) THEN
               LET g_glav_m.glav004_e = s_date_get_date(g_glav_m.glav004_s,12,-1)
               LET g_glav_m.glav002=YEAR(g_glav_m.glav004_s)
               DISPLAY BY NAME g_glav_m.glav002,g_glav_m.glav004_e
               IF NOT cl_null(g_glav_m.glav001) AND NOT cl_null(g_glav_m.glav002) THEN
                  #重複性檢查
                  CALL agli100_01_glav_chk()
                  IF NOT cl_null(g_errno) THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = g_errno
                     LET g_errparam.extend = ''
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glav004_s
            #add-point:ON CHANGE glav004_s name="input.g.glav004_s"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD glav004_e
            #add-point:BEFORE FIELD glav004_e name="input.b.glav004_e"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD glav004_e
            
            #add-point:AFTER FIELD glav004_e name="input.a.glav004_e"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE glav004_e
            #add-point:ON CHANGE glav004_e name="input.g.glav004_e"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.glav001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glav001
            #add-point:ON ACTION controlp INFIELD glav001 name="input.c.glav001"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_glav_m.glav001             #給予default值

            #給予arg
            LET g_qryparam.arg1 = "" #

            LET g_qryparam.where = " ooal001 = '13'"
            CALL q_ooal001()                                #呼叫開窗
 
            LET g_glav_m.glav001 = g_qryparam.return1              

            DISPLAY g_glav_m.glav001 TO glav001              #

            NEXT FIELD glav001                          #返回原欄位



            #END add-point
 
 
         #Ctrlp:input.c.glav002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glav002
            #add-point:ON ACTION controlp INFIELD glav002 name="input.c.glav002"
            
            #END add-point
 
 
         #Ctrlp:input.c.glav003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glav003
            #add-point:ON ACTION controlp INFIELD glav003 name="input.c.glav003"
            
            #END add-point
 
 
         #Ctrlp:input.c.glav004_s
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glav004_s
            #add-point:ON ACTION controlp INFIELD glav004_s name="input.c.glav004_s"
            
            #END add-point
 
 
         #Ctrlp:input.c.glav004_e
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD glav004_e
            #add-point:ON ACTION controlp INFIELD glav004_e name="input.c.glav004_e"
            
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
   CLOSE WINDOW w_agli100_01 
   
   #add-point:input段after input name="input.post_input"
   IF NOT INT_FLAG THEN
      CALL agli100_01_ins_glav()
   END IF
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="agli100_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="agli100_01.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 資料重複性檢查
# Memo...........:
# Usage..........: CALL agli100_01_glav_chk()
# Input parameter: 
# Return code....: 
# Date & Author..: 2016/6/6 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION agli100_01_glav_chk()
   DEFINE  l_cnt     LIKE type_t.num5
   
   LET g_errno=''
   LET l_cnt = 0
   SELECT COUNT(*) INTO l_cnt FROM glav_t
    WHERE glavent = g_enterprise AND glav001 = g_glav_m.glav001 
      AND glav002 = g_glav_m.glav002  
   IF cl_null(l_cnt) THEN LET l_cnt = 0 END IF
   
   IF l_cnt > 0 THEN
      LET g_errno='std-00004'
   END IF
END FUNCTION

################################################################################
# Descriptions...: 產生會計週期資料 insert glav_t
# Memo...........:
# Usage..........: CALL agli100_01_ins_glav()
# Input parameter: 
# Return code....: 
# Date & Author..: 2015/6/6 By 02599
# Modify.........:
################################################################################
PRIVATE FUNCTION agli100_01_ins_glav()
   DEFINE l_date     LIKE type_t.dat    #計算日期
   DEFINE l_date_s   LIKE type_t.dat    #實際開始日期
   DEFINE l_date_e   LIKE type_t.dat    #實際結束日期
   DEFINE l_week     LIKE type_t.num5   #周别
   DEFINE l_ww       LIKE type_t.num5   #星期
   DEFINE l_quarter  DYNAMIC ARRAY OF LIKE type_t.dat  #季度
   DEFINE l_month    DYNAMIC ARRAY OF LIKE type_t.dat  #期別
   DEFINE l_year_3   LIKE type_t.num5     #實際開始年度
   DEFINE l_month_3  LIKE type_t.num5     #實際開始月份
   DEFINE l_day_3    LIKE type_t.num5     #實際開始日期
   DEFINE l_i        LIKE type_t.num5     #期別
   DEFINE l_m        LIKE type_t.num5     #季别
   DEFINE l_flag     LIKE type_t.chr1

   IF cl_null(g_glav_m.glav001) OR cl_null(g_glav_m.glav002) OR cl_null(g_glav_m.glav003) OR 
      cl_null(g_glav_m.glav004_s) OR cl_null(g_glav_m.glav004_e) THEN
      RETURN
   END IF
   
   #起始日期、截止日期
   LET l_date_s = g_glav_m.glav004_s
   LET l_year_3 = g_glav_m.glav002
   LET l_month_3= MONTH(g_glav_m.glav004_s)
   LET l_day_3  = DAY(g_glav_m.glav004_s)
   LET l_date_e = g_glav_m.glav004_e
   
   #計算季度、期別
   CASE
      WHEN g_glav_m.glav003 = '1'
         #170109-00033#1--mod--str--
#         IF l_month_3 + 1 > 12 THEN LET l_year_3 = l_year_3 + 1 LET l_month_3 = 1 END IF
#         LET l_month[1] = MDY(l_month_3 + 1,l_day_3,l_year_3) - 1   #第一期結束日期
#         IF l_month_3 + 2 > 12 THEN LET l_year_3 = l_year_3 + 1 LET l_month_3 = l_month_3 + 2 - 12 END IF
#         LET l_month[2] = MDY(l_month_3 + 2,l_day_3,l_year_3) - 1   #第二期結束日期
#         IF l_month_3 + 3 > 12 THEN LET l_year_3 = l_year_3 + 1 LET l_month_3 = l_month_3 + 3 - 12 END IF
#         LET l_month[3] = MDY(l_month_3 + 3,l_day_3,l_year_3) - 1   #第三期結束日期
#         IF l_month_3 + 4 > 12 THEN LET l_year_3 = l_year_3 + 1 LET l_month_3 = l_month_3 + 4 - 12 END IF
#         LET l_month[4] = MDY(l_month_3 + 4,l_day_3,l_year_3) - 1   #第四期結束日期
#         IF l_month_3 + 5 > 12 THEN LET l_year_3 = l_year_3 + 1 LET l_month_3 = l_month_3 + 5 - 12 END IF
#         LET l_month[5] = MDY(l_month_3 + 5,l_day_3,l_year_3) - 1   #第五期結束日期
#         IF l_month_3 + 6 > 12 THEN LET l_year_3 = l_year_3 + 1 LET l_month_3 = l_month_3 + 6 - 12 END IF
#         LET l_month[6] = MDY(l_month_3 + 6,l_day_3,l_year_3) - 1   #第六期結束日期
#         IF l_month_3 + 7 > 12 THEN LET l_year_3 = l_year_3 + 1 LET l_month_3 = l_month_3 + 7 - 12 END IF
#         LET l_month[7] = MDY(l_month_3 + 7,l_day_3,l_year_3) - 1   #第七期結束日期
#         IF l_month_3 + 8 > 12 THEN LET l_year_3 = l_year_3 + 1 LET l_month_3 = l_month_3 + 8 - 12 END IF
#         LET l_month[8] = MDY(l_month_3 + 8,l_day_3,l_year_3) - 1   #第八期結束日期
#         IF l_month_3 + 9 > 12 THEN LET l_year_3 = l_year_3 + 1 LET l_month_3 = l_month_3 + 9 - 12 END IF
#         LET l_month[9] = MDY(l_month_3 + 9,l_day_3,l_year_3) - 1   #第九期結束日期
#         IF l_month_3 +10 > 12 THEN LET l_year_3 = l_year_3 + 1 LET l_month_3 = l_month_3 +10 - 12 END IF
#         LET l_month[10]= MDY(l_month_3 +10,l_day_3,l_year_3) - 1   #第十期結束日期
#         IF l_month_3 +11 > 12 THEN LET l_year_3 = l_year_3 + 1 LET l_month_3 = l_month_3 +11 - 12 END IF
#         LET l_month[11]= MDY(l_month_3 +11,l_day_3,l_year_3) - 1   #第十一期結束日期
#         LET l_month[12]= MDY(l_month_3,l_day_3,l_year_3 + 1) - 1   #第十二期結束日期
#         
#         IF l_month_3 + 3 > 12 THEN LET l_year_3 = l_year_3 + 1 LET l_month_3 = l_month_3 + 3 - 12 END IF
#         LET l_quarter[1] = MDY(l_month_3 + 3,l_day_3,l_year_3) - 1 #第一季結束日期
#         IF l_month_3 + 6 > 12 THEN LET l_year_3 = l_year_3 + 1 LET l_month_3 = l_month_3 + 6 - 12 END IF
#         LET l_quarter[2] = MDY(l_month_3 + 6,l_day_3,l_year_3) - 1 #第二季結束日期
#         IF l_month_3 + 9 > 12 THEN LET l_year_3 = l_year_3 + 1 LET l_month_3 = l_month_3 + 9 - 12 END IF
#         LET l_quarter[3] = MDY(l_month_3 + 9,l_day_3,l_year_3) - 1 #第三季結束日期
#         LET l_quarter[4] = MDY(l_month_3,l_day_3,l_year_3 + 1) - 1 #第四季結束日期
         FOR l_i = 1 TO 12
            IF l_month_3 + l_i > 12 THEN 
               LET l_year_3 = l_year_3 + 1
               LET l_month[l_i] = MDY(1,l_day_3,l_year_3) - 1   #每期結束日期
               LET l_month_3 = 1 - l_i
            ELSE
               LET l_month[l_i] = MDY(l_month_3 + l_i,l_day_3,l_year_3) - 1   #每期結束日期
            END IF
            IF l_i = 3 THEN
               LET l_quarter[1] = MDY(l_month_3 + 3,l_day_3,l_year_3) - 1 #第一季結束日期
            END IF
            IF l_i = 6 THEN
               LET l_quarter[2] = MDY(l_month_3 + 6,l_day_3,l_year_3) - 1 #第二季結束日期
            END IF
            IF l_i = 9 THEN
               LET l_quarter[3] = MDY(l_month_3 + 9,l_day_3,l_year_3) - 1 #第三季結束日期
            END IF
            IF l_i = 12 THEN
               LET l_quarter[4] = MDY(l_month_3,l_day_3,l_year_3 + 1) - 1 #第四季結束日期
            END IF
         END FOR
         #170109-00033#1--mod--end
      WHEN g_glav_m.glav003 = '2'
         LET l_month[1] = l_date_s + 28 - 1   #第一期結束日期
         LET l_month[2] = l_date_s + 56 - 1   #第二期結束日期
         LET l_month[3] = l_date_s + 84 - 1   #第三期結束日期
         LET l_month[4] = l_date_s +112 - 1   #第四期結束日期
         LET l_month[5] = l_date_s +140 - 1   #第五期結束日期
         LET l_month[6] = l_date_s +168 - 1   #第六期結束日期
         LET l_month[7] = l_date_s +196 - 1   #第七期結束日期
         LET l_month[8] = l_date_s +224 - 1   #第八期結束日期
         LET l_month[9] = l_date_s +252 - 1   #第九期結束日期
         LET l_month[10]= l_date_s +280 - 1   #第十期結束日期
         LET l_month[11]= l_date_s +308 - 1   #第十一期結束日期
         LET l_month[12]= l_date_s +336 - 1   #第十二期結束日期
         LET l_month[13]= MDY(l_month_3,l_day_3,l_year_3 + 1) - 1          #第十三期結束日期
         LET l_quarter[1] = l_date_s + 84 - 1 #第一季結束日期
         LET l_quarter[2] = l_date_s +168 - 1 #第二季結束日期
         LET l_quarter[3] = l_date_s +252 - 1 #第三季結束日期
         LET l_quarter[4] = MDY(l_month_3,l_day_3,l_year_3 + 1) - 1        #第四季結束日期
      WHEN g_glav_m.glav003 = '3'
         LET l_month[1] = l_date_s + 28 - 1   #第一期結束日期
         LET l_month[2] = l_date_s + 56 - 1   #第二期結束日期
         LET l_month[3] = l_date_s + 91 - 1   #第三期結束日期
         LET l_month[4] = l_date_s +119 - 1   #第四期結束日期
         LET l_month[5] = l_date_s +147 - 1   #第五期結束日期
         LET l_month[6] = l_date_s +182 - 1   #第六期結束日期
         LET l_month[7] = l_date_s +210 - 1   #第七期結束日期
         LET l_month[8] = l_date_s +238 - 1   #第八期結束日期
         LET l_month[9] = l_date_s +273 - 1   #第九期結束日期
         LET l_month[10]= l_date_s +301 - 1   #第十期結束日期
         LET l_month[11]= l_date_s +329 - 1   #第十一期結束日期
         LET l_month[12]= MDY(l_month_3,l_day_3,l_year_3 + 1) - 1         #第十二期結束日期
         LET l_quarter[1] = l_date_s + 91 - 1 #第一季結束日期
         LET l_quarter[2] = l_date_s +182 - 1 #第二季結束日期
         LET l_quarter[3] = l_date_s +273 - 1 #第三季結束日期
         LET l_quarter[4] = MDY(l_month_3,l_day_3,l_year_3 + 1) - 1        #第四季結束日期
   END CASE

   LET l_week = 0
   LET l_date = l_date_s
   LET l_flag = 'Y'
   CALL cl_err_collect_init()
   CALL s_transaction_begin()
   
   DELETE FROM glav_t 
    WHERE glavent = g_enterprise
      AND glav001 = g_glav_m.glav001
      AND glav002 = g_glav_m.glav002
      AND glav004 BETWEEN g_glav_m.glav004_s AND g_glav_m.glav004_e
      
   WHILE l_date <= l_date_e
      #計算周別
      #計算當前是星期几
      LET l_ww = WEEKDAY(l_date)
      #第一週、星期一時 周別加一
      IF l_ww = 0 OR l_week = 0 THEN LET l_week = l_week + 1 END IF
      #計算日期所屬月份
      FOR l_i = 1 TO 13
         IF l_date <= l_month[l_i] THEN
            EXIT FOR
         END IF
      END FOR
      LET l_m = 1
      IF l_i >= 4  THEN LET l_m = 2 END IF
      IF l_i >= 7  THEN LET l_m = 3 END IF
      IF l_i >= 10 THEN LET l_m = 4 END IF
      
      INSERT INTO glav_t (glavent,glav001,glav002,glav003,
                          glav004,glav005,glav006,glav007,
                          glavstus,glavownid,glavowndp,glavcrtid,glavcrtdp,glavcrtdt,glavmodid,glavmoddt) 
                     VALUES(g_enterprise,g_glav_m.glav001,g_glav_m.glav002,g_glav_m.glav003,
                            l_date,l_m,l_i,l_week,
                            'Y',g_user,g_dept,g_user,g_dept,TODAY,g_user,TODAY)
      
      IF SQLCA.SQLcode THEN
         LET l_flag = 'N'
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.SQLcode
         LET g_errparam.extend = 'insert glav_t'
         LET g_errparam.popup = TRUE
         CALL cl_err()
         EXIT WHILE
      END IF
      #計算日期大於等於結束日期，跳出循環
      IF l_date >= l_date_e THEN
         EXIT WHILE
      ELSE
         LET l_date = l_date + 1
      END IF
   END WHILE
   
   IF l_flag = 'Y' THEN
      CALL s_transaction_end('Y','0')
   ELSE
      CALL s_transaction_end('N','0')
   END IF
   CALL cl_err_collect_show()
END FUNCTION

 
{</section>}
 
