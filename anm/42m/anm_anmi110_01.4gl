#該程式未解開Section, 採用最新樣板產出!
{<section id="anmi110_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0006(2016-08-10 15:04:59), PR版次:0006(2016-08-10 18:17:35)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000213
#+ Filename...: anmi110_01
#+ Description: 例假日產生
#+ Creator....: 01258(2013-08-16 10:41:29)
#+ Modifier...: 02599 -SD/PR- 02599
 
{</section>}
 
{<section id="anmi110_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#141106-00011#22  2015/04/28  By Belle 調整例假日 日期檢核點
#160318-00005#25  2016/03/30  by 07675 將重複內容的錯誤訊息置換為公用錯誤訊息
#160326-00001#35  2016/08/10  By 02599 批次产生时，加入休假类型的选项
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
PRIVATE type type_g_nmac_m        RECORD
       nmac001 LIKE nmac_t.nmac001, 
   nmac001_desc LIKE type_t.chr80, 
   bdate LIKE type_t.dat, 
   edate LIKE type_t.dat, 
   mon LIKE type_t.chr10, 
   tue LIKE type_t.chr10, 
   wed LIKE type_t.chr10, 
   thu LIKE type_t.chr10, 
   fri LIKE type_t.chr10, 
   sat LIKE type_t.chr10, 
   sun LIKE type_t.chr10, 
   nmac003 LIKE nmac_t.nmac003, 
   nmac003_desc LIKE type_t.chr80
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
 DEFINE l_sql    STRING 
 DEFINE l_week   STRING 
 DEFINE l_year   LIKE type_t.num5
#end add-point
 
DEFINE g_nmac_m        type_g_nmac_m
 
   DEFINE g_nmac001_t LIKE nmac_t.nmac001
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="anmi110_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION anmi110_01(--)
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
   DEFINE r_success       LIKE type_t.num5
   DEFINE l_year          LIKE type_t.num5
   DEFINE l_month         LIKE type_t.num5
   DEFINE l_day           LIKE type_t.num5
   DEFINE l_result        LIKE type_t.num5
   DEFINE l_nmac005       LIKE nmac_t.nmac005
   DEFINE l_nmacent       LIKE nmac_t.nmacent
   DEFINE l_nmac001       LIKE nmac_t.nmac001
   DEFINE l_nmac002       LIKE nmac_t.nmac002
   DEFINE l_nmac003       LIKE nmac_t.nmac003
   DEFINE l_nmacstus      LIKE nmac_t.nmacstus
   DEFINE l_nmaccrtdt     LIKE nmac_t.nmaccrtdt 
   DEFINE l_date          LIKE type_t.chr30
   DEFINE l_oocqstus      LIKE oocq_t.oocqstus    #160326-00001#35 add
   DEFINE l_crtdt         DATETIME YEAR TO SECOND #160326-00001#35 add
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_anmi110_01 WITH FORM cl_ap_formpath("anm","anmi110_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_nmac_m.nmac001,g_nmac_m.bdate,g_nmac_m.edate,g_nmac_m.mon,g_nmac_m.tue,g_nmac_m.wed, 
          g_nmac_m.thu,g_nmac_m.fri,g_nmac_m.sat,g_nmac_m.sun,g_nmac_m.nmac003 ATTRIBUTE(WITHOUT DEFAULTS) 
 
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
 
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
          #LET g_nmac_m.nmac001 = p_nmac001
           LET g_nmac_m.mon = 'N'
           LET g_nmac_m.tue = 'N'
           LET g_nmac_m.wed = 'N'
           LET g_nmac_m.thu = 'N'
           LET g_nmac_m.fri = 'N'
           LET g_nmac_m.sat = 'Y'
           LET g_nmac_m.sun = 'Y'
           LET l_date = YEAR(g_today) USING "&&&&",'/',1 USING "&&",'/',1 USING "&&"
           LET g_nmac_m.bdate = l_date 
           LET l_date = YEAR(g_today) USING "&&&&",'/',12 USING "&&",'/',31 USING "&&"
           LET g_nmac_m.edate = l_date
           LET g_nmac_m.nmac003='' #160326-00001#35 add
           DISPLAY BY NAME g_nmac_m.bdate,g_nmac_m.edate,g_nmac_m.mon,g_nmac_m.tue,
                                          g_nmac_m.wed,g_nmac_m.thu,g_nmac_m.fri,g_nmac_m.sat,
                                          g_nmac_m.sun


            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmac001
            
            #add-point:AFTER FIELD nmac001 name="input.a.nmac001"
             IF NOT cl_null(g_nmac_m.nmac001) THEN
                #检查行事历参照表是否在参照表维护作业-行事历中是否存在切有效
                CALL anmi110_01_nmac001_chk(g_nmac_m.nmac001)  RETURNING g_errno
                IF NOT cl_null(g_errno) THEN
                   INITIALIZE g_errparam TO NULL
                   LET g_errparam.code = g_errno
                   LET g_errparam.extend = g_nmac_m.nmac001
                   #160318-00005#25  --add--str
                   LET g_errparam.replace[1] ='aooi074'
                   LET g_errparam.replace[2] = cl_get_progname('aooi074',g_lang,"2")
                   LET g_errparam.exeprog    ='aooi074'
                   #160318-00005#25 --add--end
                   LET g_errparam.popup = TRUE
                   CALL cl_err()
 
                   LET g_nmac_m.nmac001 = ''
                   LET g_nmac_m.nmac001_desc = ''
                   DISPLAY BY NAME g_nmac_m.nmac001_desc 
                   NEXT FIELD CURRENT
                END IF
            END IF

            CALL anmi110_01_nmac001_desc(g_nmac_m.nmac001) RETURNING g_nmac_m.nmac001_desc
            DISPLAY BY NAME g_nmac_m.nmac001_desc

            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmac001
            #add-point:BEFORE FIELD nmac001 name="input.b.nmac001"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmac001
            #add-point:ON CHANGE nmac001 name="input.g.nmac001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bdate
            #add-point:BEFORE FIELD bdate name="input.b.bdate"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bdate
            
            #add-point:AFTER FIELD bdate name="input.a.bdate"
            IF NOT cl_null(g_nmac_m.bdate) THEN
               IF NOT cl_null(g_nmac_m.edate) THEN 
                 #141106-00011--(S)--
                 #IF g_nmac_m.bdate> g_nmac_m.edate THEN
                 #   INITIALIZE g_errparam TO NULL
                 #   LET g_errparam.code = 'sub-00095'
                 #   LET g_errparam.extend = g_nmac_m.edate
                 #   LET g_errparam.popup = TRUE
                 #   CALL cl_err()
                 #
                 #   NEXT FIELD bdate  
                 #END IF
                 #141106-00011--(E)--
               ELSE
                  LET l_year = YEAR(g_nmac_m.bdate)+1
                  LET l_month= MONTH(g_nmac_m.bdate)
                  LET l_day  = DAY(g_nmac_m.bdate)
                  LET g_nmac_m.edate = MDY(l_month,l_day-1,l_year)
                  #如果是一月一号的话
                  IF l_month = 1 AND l_day =1 THEN 
                     LET g_nmac_m.edate = MDY(12,31,l_year-1)                                   
                  END IF 
                  #如果是其他月份的一号
                  IF l_month<>1 AND l_day = 1 THEN
                     #31天的月份
                     IF l_month=5 OR l_month=7 OR l_month=8 OR l_month=10 OR l_month=12 THEN
                        LET g_nmac_m.edate = MDY(l_month-1,30,l_year) 
                     END IF
                     #30天的及2月
                     IF l_month=2 OR l_month=4 OR l_month=6 OR l_month=9 OR l_month=11 THEN
                        LET g_nmac_m.edate = MDY(l_month-1,31,l_year) 
                     END IF 
                     #若果是3月1号，则要判断是否为闰年，闰年2月29天，否则28天                     
                     IF l_month= 3 THEN 
                        CALL s_date_chk_leap_year(l_year) RETURNING l_result
                        IF l_result = 1 THEN 
                           LET g_nmac_m.edate = MDY(l_month-1,29,l_year)
                        ELSE
                           LET g_nmac_m.edate = MDY(l_month-1,28,l_year)
                        END IF 
                     END IF 
                  END IF                      
               END IF                
            END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bdate
            #add-point:ON CHANGE bdate name="input.g.bdate"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD edate
            #add-point:BEFORE FIELD edate name="input.b.edate"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD edate
            
            #add-point:AFTER FIELD edate name="input.a.edate"
            IF NOT cl_null(g_nmac_m.bdate) AND NOT cl_null(g_nmac_m.edate) THEN
              IF g_nmac_m.bdate> g_nmac_m.edate THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'sub-00095'
                  LET g_errparam.extend = g_nmac_m.edate
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD edate
              END IF
           END IF

            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE edate
            #add-point:ON CHANGE edate name="input.g.edate"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD mon
            #add-point:BEFORE FIELD mon name="input.b.mon"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD mon
            
            #add-point:AFTER FIELD mon name="input.a.mon"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE mon
            #add-point:ON CHANGE mon name="input.g.mon"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD tue
            #add-point:BEFORE FIELD tue name="input.b.tue"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD tue
            
            #add-point:AFTER FIELD tue name="input.a.tue"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE tue
            #add-point:ON CHANGE tue name="input.g.tue"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD wed
            #add-point:BEFORE FIELD wed name="input.b.wed"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD wed
            
            #add-point:AFTER FIELD wed name="input.a.wed"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE wed
            #add-point:ON CHANGE wed name="input.g.wed"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD thu
            #add-point:BEFORE FIELD thu name="input.b.thu"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD thu
            
            #add-point:AFTER FIELD thu name="input.a.thu"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE thu
            #add-point:ON CHANGE thu name="input.g.thu"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD fri
            #add-point:BEFORE FIELD fri name="input.b.fri"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD fri
            
            #add-point:AFTER FIELD fri name="input.a.fri"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE fri
            #add-point:ON CHANGE fri name="input.g.fri"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sat
            #add-point:BEFORE FIELD sat name="input.b.sat"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sat
            
            #add-point:AFTER FIELD sat name="input.a.sat"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sat
            #add-point:ON CHANGE sat name="input.g.sat"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD sun
            #add-point:BEFORE FIELD sun name="input.b.sun"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD sun
            
            #add-point:AFTER FIELD sun name="input.a.sun"
 
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE sun
            #add-point:ON CHANGE sun name="input.g.sun"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD nmac003
            
            #add-point:AFTER FIELD nmac003 name="input.a.nmac003"
            #160326-00001#35--add--str--
            IF NOT cl_null(g_nmac_m.nmac003) THEN
               SELECT oocqstus INTO l_oocqstus FROM oocq_t
                WHERE oocqent =  g_enterprise
                  AND oocq001 = '6'
                  AND oocq002 = g_nmac_m.nmac003
               IF sqlca.sqlcode=100 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'anm-00405'
                  LET g_errparam.extend = g_nmac_m.nmac003
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_nmac_m.nmac003=''
                  LET g_nmac_m.nmac003_desc=''
                  DISPLAY BY NAME g_nmac_m.nmac003_desc
                  NEXT FIELD nmac003
               END IF 
               
               IF l_oocqstus <> 'Y' THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'sub-01302' 
                  LET g_errparam.extend = g_nmac_m.nmac003
                  LET g_errparam.replace[1] ='aooi706'
                  LET g_errparam.replace[2] = cl_get_progname("aooi706",g_lang,"2")
                  LET g_errparam.exeprog ='aooi706'
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_nmac_m.nmac003=''
                  LET g_nmac_m.nmac003_desc=''
                  DISPLAY BY NAME g_nmac_m.nmac003_desc
                  NEXT FIELD nmac003
               END IF 
            END IF
            #160326-00001#35--add--end
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_nmac_m.nmac003
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='6' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_nmac_m.nmac003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_nmac_m.nmac003_desc


            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD nmac003
            #add-point:BEFORE FIELD nmac003 name="input.b.nmac003"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE nmac003
            #add-point:ON CHANGE nmac003 name="input.g.nmac003"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.nmac001
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmac001
            #add-point:ON ACTION controlp INFIELD nmac001 name="input.c.nmac001"
#此段落由子樣板a07產生            
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_nmac_m.nmac001             #給予default值

            #給予arg
            LET g_qryparam.where = 'ooal001 = 4'
            CALL q_ooal002()                                #呼叫開窗

            LET g_nmac_m.nmac001 = g_qryparam.return1              #將開窗取得的值回傳到變數
            CALL anmi110_01_nmac001_desc(g_nmac_m.nmac001) RETURNING g_nmac_m.nmac001_desc
            DISPLAY BY NAME g_nmac_m.nmac001_desc
            DISPLAY g_nmac_m.nmac001 TO nmac001              #顯示到畫面上
            LET g_qryparam.where = ''
            NEXT FIELD nmac001                          #返回原欄位


            #END add-point
 
 
         #Ctrlp:input.c.bdate
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bdate
            #add-point:ON ACTION controlp INFIELD bdate name="input.c.bdate"
            
            #END add-point
 
 
         #Ctrlp:input.c.edate
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD edate
            #add-point:ON ACTION controlp INFIELD edate name="input.c.edate"
            
            #END add-point
 
 
         #Ctrlp:input.c.mon
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD mon
            #add-point:ON ACTION controlp INFIELD mon name="input.c.mon"
 
            #END add-point
 
 
         #Ctrlp:input.c.tue
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD tue
            #add-point:ON ACTION controlp INFIELD tue name="input.c.tue"
 
            #END add-point
 
 
         #Ctrlp:input.c.wed
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD wed
            #add-point:ON ACTION controlp INFIELD wed name="input.c.wed"
            

            #END add-point
 
 
         #Ctrlp:input.c.thu
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD thu
            #add-point:ON ACTION controlp INFIELD thu name="input.c.thu"
            
            #END add-point
 
 
         #Ctrlp:input.c.fri
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD fri
            #add-point:ON ACTION controlp INFIELD fri name="input.c.fri"
            
            #END add-point
 
 
         #Ctrlp:input.c.sat
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sat
            #add-point:ON ACTION controlp INFIELD sat name="input.c.sat"
            
            #END add-point
 
 
         #Ctrlp:input.c.sun
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD sun
            #add-point:ON ACTION controlp INFIELD sun name="input.c.sun"
            
            #END add-point
 
 
         #Ctrlp:input.c.nmac003
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD nmac003
            #add-point:ON ACTION controlp INFIELD nmac003 name="input.c.nmac003"
            #應用 a07 樣板自動產生(Version:3)   
            #開窗i段
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
 
            LET g_qryparam.default1 = g_nmac_m.nmac003             #給予default值
            LET g_qryparam.default2 = "" #g_nmac_m.oocq002 #應用分類碼
            #給予arg
            LET g_qryparam.arg1 = "6" #s #160326-00001#35 add

 
            CALL q_oocq002()                                #呼叫開窗
 
            LET g_nmac_m.nmac003 = g_qryparam.return1              
            #LET g_nmac_m.oocq002 = g_qryparam.return2 
            DISPLAY g_nmac_m.nmac003 TO nmac003              #
            #DISPLAY g_nmac_m.oocq002 TO oocq002 #應用分類碼
            #160326-00001#35--add--str--
            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_nmac_m.nmac003
            CALL ap_ref_array2(g_ref_fields,"SELECT oocql004 FROM oocql_t WHERE oocqlent='"||g_enterprise||"' AND oocql001='6' AND oocql002=? AND oocql003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_nmac_m.nmac003_desc = '', g_rtn_fields[1] , ''
            DISPLAY BY NAME g_nmac_m.nmac003_desc
            #160326-00001#35--add--end
            NEXT FIELD nmac003                          #返回原欄位



            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            #141106-00011--(S)--
            IF NOT cl_null(g_nmac_m.bdate) AND NOT cl_null(g_nmac_m.edate) THEN
               IF g_nmac_m.bdate> g_nmac_m.edate THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'sub-00095'
                  LET g_errparam.extend = g_nmac_m.edate
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  NEXT FIELD bdate
               END IF
            END IF
            #141106-00011--(E)--
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
   CLOSE WINDOW w_anmi110_01 
   
   #add-point:input段after input name="input.post_input"
   LET r_success = TRUE
   LET l_week= ''
    #点了取消
   IF INT_FLAG THEN 
      LET INT_FLAG = FALSE
      RETURN ''      
   END IF      
    
   #如果星期全部不勾选则返回false
   IF g_nmac_m.mon = 'N' AND g_nmac_m.tue = 'N'  AND g_nmac_m.wed = 'N' AND g_nmac_m.thu = 'N'
      AND g_nmac_m.fri = 'N' AND g_nmac_m.sat = 'N' AND g_nmac_m.sun = 'N' THEN
      LET r_success = FALSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'anm-00014'
      LET g_errparam.extend = 'ALL N'
      LET g_errparam.popup = TRUE
      CALL cl_err()
 #星期未勾选，不执行例假日产生
      RETURN r_success     
   END IF 
   
   #160326-00001#35--add--str--
   #判断是否已存在休假资料，如果存在询问是否删除重新产生
   LET l_count = 0
   SELECT COUNT(*) INTO l_count FROM nmac_t 
   WHERE nmacent = g_enterprise
     AND nmac001 = g_nmac_m.nmac001
     AND nmac002 BETWEEN g_nmac_m.bdate AND g_nmac_m.edate
   IF cl_null(l_count) THEN LET l_count = 0 END IF
   IF l_count > 0  THEN
      IF NOT cl_ask_confirm('afm-00111') THEN
         RETURN r_success 
      ELSE
         #删除已存在的资料
         DELETE FROM nmac_t
          WHERE nmacent = g_enterprise
            AND nmac001 = g_nmac_m.nmac001
            AND nmac002 BETWEEN g_nmac_m.bdate AND g_nmac_m.edate
         IF SQLCA.sqlcode THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.sqlcode
            LET g_errparam.extend = "delete nmac_t"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            LET r_success = FALSE
            RETURN r_success 
         END IF
      END IF
   END IF
   #160326-00001#35--add--end
   
   #周一至周日勾选
    IF g_nmac_m.mon='Y' THEN
       IF NOt cl_null(l_week) THEN 
           LET l_week = l_week,',','1'          
       ELSE
          LET l_week ='1'
       END IF 
    ELSE
      LET l_week = l_week
    END IF 
    
    IF g_nmac_m.tue='Y' THEN
      IF NOt cl_null(l_week) THEN 
         LET l_week = l_week,',','2'         
       ELSE
          LET l_week = '2'
       END IF 
    ELSE
      LET l_week = l_week
    END IF 
    
    IF g_nmac_m.wed='Y' THEN
      IF NOt cl_null(l_week) THEN 
         LET l_week = l_week,',','3'         
       ELSE
          LET l_week ='3'
       END IF 
    ELSE
      LET l_week = l_week
    END IF 
    
    IF g_nmac_m.thu='Y' THEN
       IF NOt cl_null(l_week) THEN 
          LET l_week = l_week,',','4'    
       ELSE
          LET l_week = '4'
       END IF 
    ELSE
      LET l_week = l_week
    END IF 
    
    IF g_nmac_m.fri='Y' THEN
      IF NOt cl_null(l_week) THEN 
         LET l_week = l_week,',','5'    
       ELSE
          LET l_week = '5'
       END IF 
    ELSE
      LET l_week = l_week
    END IF 
    
    IF g_nmac_m.sat='Y' THEN
       IF NOt cl_null(l_week) THEN 
          LET l_week = l_week,',','6'    
       ELSE
          LET l_week ='6'
       END IF 
    ELSE
      LET l_week = l_week
    END IF 
    
    IF g_nmac_m.sun='Y' THEN
      IF NOt cl_null(l_week) THEN  
         LET l_week = l_week,',','0'
       ELSE
          LET l_week ='0'
       END IF 
    ELSE
      LET l_week = l_week
    END IF 
    
    LET l_week = cl_replace_str(l_week,",","','")
    
   #160326-00001#35--add--str--
   #产生休假资料
   LET l_crtdt = cl_get_current() 
   LET l_sql = "INSERT INTO nmac_t(nmacent,nmac001,nmac002,nmac003,nmac005,nmacstus,",
               "                   nmacownid,nmacowndp,nmaccrtid,nmaccrtdp,nmaccrtdt) ",
               " SELECT '",g_enterprise,"','",g_nmac_m.nmac001,"',ooga001,'",g_nmac_m.nmac003,"',",
               "        substr((to_char(ooga001,'YYYY-MM-DD')),1,4),'Y',",
               "        '",g_user CLIPPED,"',",
               "        '",g_dept CLIPPED,"',",   
               "        '",g_user CLIPPED,"',",
               "        '",g_dept CLIPPED,"',",
               "        to_date('",l_crtdt,"','yyyy-mm-dd hh24:mi:ss')", 
               "   FROM ooga_t ",
               " WHERE ooga001 BETWEEN '",g_nmac_m.bdate,"' AND '",g_nmac_m.edate,"' " ,
               "   AND ooga002 IN ('",l_week,"') ",
               "   AND oogaent = '",g_enterprise,"'"
   PREPARE anmi110_01_ins_pr FROM l_sql
   EXECUTE anmi110_01_ins_pr
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "insert nmac_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
   END IF
   #160326-00001#35--add--end
#160326-00001#35--mark--str--   
#   #insert 操作
#   LET l_sql = " SELECT '",g_enterprise,"','",g_nmac_m.nmac001,"',ooga001,'1',substr((to_char(ooga001,'YYYY-MM-DD')),1,4),'Y'",
#               "   FROM ooga_t ",
#               " WHERE ooga001 between '",g_nmac_m.bdate,"' AND '",g_nmac_m.edate,"' " ,
#               "   AND ooga002 IN ('",l_week,"') ",
#               "   AND oogaent = '",g_enterprise,"'"
#    PREPARE anmi110_01_ins_nmac  FROM l_sql  
#    DECLARE anmi110_01_ins_cs CURSOR FOR  anmi110_01_ins_nmac 
#    FOREACH anmi110_01_ins_cs INTO l_nmacent,l_nmac001,l_nmac002,l_nmac003,l_nmac005,l_nmacstus
#       IF SQLCA.sqlcode THEN
#         INITIALIZE g_errparam TO NULL
#         LET g_errparam.code = SQLCA.sqlcode
#         LET g_errparam.extend = "FOREACH:"
#         LET g_errparam.popup = TRUE
#         CALL cl_err()
#
#         LET r_success = FALSE
#         EXIT FOREACH
#      END IF
#    
#       LET l_count = 0
#       SELECT count(*) INTO l_count FROM nmac_t 
#       WHERE nmacent = g_enterprise
#         AND nmac001 = l_nmac001
#         AND nmac002 = l_nmac002
#       IF l_count > 0  THEN
#          INITIALIZE g_errparam TO NULL
#          LET g_errparam.code = 'std-00004'
#          LET g_errparam.extend = l_nmac002
#          LET g_errparam.popup = TRUE
#          CALL cl_err()
#
#          LET r_success = FALSE
#          RETURN r_success
#       END IF
#       
#       LET l_nmaccrtdt =  cl_get_current()  #建立日期    
#       INSERT INTO nmac_t(nmacent,nmac001,nmac002,nmac003,nmac005,nmacstus,nmacownid,nmacowndp,nmaccrtid,nmaccrtdp,nmaccrtdt)
#        VALUES (l_nmacent,l_nmac001,l_nmac002,l_nmac003,l_nmac005,l_nmacstus,g_user,g_dept,g_user,g_dept,l_nmaccrtdt)
#       IF SQLCA.sqlcode THEN
#          INITIALIZE g_errparam TO NULL
#          LET g_errparam.code = SQLCA.sqlcode
#          LET g_errparam.extend = 'Insert nmac_t error!'
#          LET g_errparam.popup = TRUE
#          CALL cl_err()
#
#          LET r_success = FALSE
#          RETURN r_success
#      END IF 
#    
#    END FOREACH
#160326-00001#35--mark--end
    RETURN r_success
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="anmi110_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="anmi110_01.other_function" readonly="Y" >}
#检查资料的存在及有效性
PRIVATE FUNCTION anmi110_01_nmac001_chk(p_nmac001)
   DEFINE p_nmac001     LIKE nmac_t.nmac001
   DEFINE r_errno       LIKE type_t.chr20
   DEFINE l_ooalstus    LIKE ooal_t.ooalstus
   DEFINE l_ooal002     LIKE ooal_t.ooal002


   LET r_errno = ''

   SELECT ooal002,ooalstus INTO l_ooal002,l_ooalstus
     FROM ooal_t
    WHERE ooalent = g_enterprise
      AND ooal001 = 4
      AND ooal002 = p_nmac001

    CASE
       WHEN sqlca.sqlcode = 100   LET r_errno = 'sub-01305' #160318-00005#25 mod  'aoo-00125'
       WHEN l_ooalstus ='N'       LET r_errno = 'sub-01302'  #160318-00005#25 mod 'aoo-00124'
     END CASE
     RETURN r_errno
END FUNCTION
#+ 參照表編號說明
PRIVATE FUNCTION anmi110_01_nmac001_desc(p_nmac001)
   DEFINE p_nmac001     LIKE nmac_t.nmac001
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] =p_nmac001
   CALL ap_ref_array2(g_ref_fields,"SELECT ooall004 FROM ooall_t WHERE ooallent='"||g_enterprise||"' AND ooall001='4' AND ooall002=? AND ooall003='"||g_dlang||"'","") RETURNING g_rtn_fields
   RETURN  g_rtn_fields[1]
   
END FUNCTION

 
{</section>}
 
