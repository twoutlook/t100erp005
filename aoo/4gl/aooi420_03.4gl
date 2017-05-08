#該程式未解開Section, 採用最新樣板產出!
{<section id="aooi420_03.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2013-07-23 00:00:00), PR版次:0003(2016-12-14 11:39:58)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000164
#+ Filename...: aooi420_03
#+ Description: 會計年、期、季、週別設定
#+ Creator....: 01258(2013-08-16 10:54:18)
#+ Modifier...: 01996 -SD/PR- 08734
 
{</section>}
 
{<section id="aooi420_03.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"
#160318-00005#32  2016/03/27 By 07900    重复错误信息修改
#161124-00048#13  2016/12/14 By 08734    星号整批调整
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
 
{<section id="aooi420_03.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"
{<Module define>}
#單頭 type 宣告
PRIVATE type type_g_oogc_m        RECORD
       oogc001 LIKE oogc_t.oogc001,
   oogc001_desc LIKE type_t.chr80,
   oogc002 LIKE oogc_t.oogc002,
   oogc015 LIKE oogc_t.oogc015,
   bdate LIKE type_t.chr80,
   edate LIKE type_t.chr80,
   oogc016 LIKE oogc_t.oogc016
       END RECORD
DEFINE g_oogc_m        type_g_oogc_m

DEFINE g_oogc001_t   LIKE oogc_t.oogc001    #Key值備份
DEFINE g_oogc015_t      LIKE oogc_t.oogc015    #Key值備份

DEFINE g_oogc002_t      LIKE oogc_t.oogc002    #Key值備份

DEFINE g_oogc003_t      LIKE oogc_t.oogc003    #Key值備份



DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
{</Module define>}
#end add-point
 
{</section>}
 
{<section id="aooi420_03.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="aooi420_03.other_dialog" >}

 
{</section>}
 
{<section id="aooi420_03.other_function" readonly="Y" >}

PUBLIC FUNCTION aooi420_03(--)
   #add-point:input段變數傳入
p_oogc001,p_oogc002          {#ADP版次:1#}
   #end add-point
   )
   {<Local define>}
   DEFINE l_ac_t          LIKE type_t.num5        #未取消的ARRAY CNT
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否
   DEFINE l_count         LIKE type_t.num5
   DEFINE l_insert        LIKE type_t.num5
   DEFINE p_cmd           LIKE type_t.chr5
   {</Local define>}
   #add-point:input段define
   DEFINE l_n             LIKE type_t.num5
   DEFINE p_oogc001       LIKE oogc_t.oogc001
   DEFINE p_oogc002       LIKE oogc_t.oogc002
   #DEFINE l_oogc          RECORD LIKE oogc_t.*  #161124-00048#13  2016/12/14 By 08734 mark
   #161124-00048#13  2016/12/14 By 08734 add(S)
   DEFINE l_oogc RECORD  #行事曆檔
       oogcent LIKE oogc_t.oogcent, #企业编号
       oogcstus LIKE oogc_t.oogcstus, #状态码
       oogc001 LIKE oogc_t.oogc001, #行事历参照表号
       oogc002 LIKE oogc_t.oogc002, #行事历类别
       oogc003 LIKE oogc_t.oogc003, #日期
       oogc004 LIKE oogc_t.oogc004, #休假类型
       oogc005 LIKE oogc_t.oogc005, #原因说明
       oogc006 LIKE oogc_t.oogc006, #期别
       oogc007 LIKE oogc_t.oogc007, #季别
       oogc008 LIKE oogc_t.oogc008, #周别
       oogc009 LIKE oogc_t.oogc009, #上班时数
       oogc010 LIKE oogc_t.oogc010, #分类一
       oogc011 LIKE oogc_t.oogc011, #分类二
       oogc012 LIKE oogc_t.oogc012, #分类三
       oogc013 LIKE oogc_t.oogc013, #分类四
       oogc014 LIKE oogc_t.oogc014, #分类五
       oogc015 LIKE oogc_t.oogc015, #年度
       oogcownid LIKE oogc_t.oogcownid, #资料所有者
       oogcowndp LIKE oogc_t.oogcowndp, #资料所有部门
       oogccrtid LIKE oogc_t.oogccrtid, #资料录入者
       oogccrtdp LIKE oogc_t.oogccrtdp, #资料录入部门
       oogccrtdt LIKE oogc_t.oogccrtdt, #资料创建日
       oogcmodid LIKE oogc_t.oogcmodid, #资料更改者
       oogcmoddt LIKE oogc_t.oogcmoddt, #最近更改日
       oogc016 LIKE oogc_t.oogc016, #月份
       oogc017 LIKE oogc_t.oogc017 #月周
END RECORD
#161124-00048#13  2016/12/14 By 08734 add(E)
   DEFINE l_sql           STRING
   DEFINE l_yy          LIKE type_t.num5
   DEFINE l_mm         LIKE type_t.num5
   DEFINE l_dd           LIKE type_t.num5
   DEFINE l_i             LIKE type_t.num5
   DEFINE i             LIKE type_t.num5
   DEFINE b_date          LIKE type_t.dat
   DEFINE f_date          LIKE type_t.dat
   DEFINE l_date  ARRAY[12] OF LIKE type_t.dat,
          l_date2 ARRAY[12] OF LIKE type_t.dat
   DEFINE l_ss            LIKE type_t.num5
   DEFINE l_week          LIKE type_t.num5
   DEFINE l_success       LIKE type_t.chr1
   DEFINE l_days          LIKE type_t.num5          {#ADP版次:1#}
   #end add-point

   #畫面開啟 (identifier)
   OPEN WINDOW w_aooi420_03 WITH FORM cl_ap_formpath("aoo","aooi420_03")

   #瀏覽頁簽資料初始化
   CALL cl_ui_init()

   LET g_qryparam.state = "i"
   LET p_cmd = 'a'

   #輸入前處理
   #add-point:單頭前置處理
   CALL cl_set_combo_scc('oogc016','41')
   CALL cl_set_combo_scc("oogc002",25)
   LET g_oogc_m.oogc001 = p_oogc001
   LET g_oogc_m.oogc002 = p_oogc002
   LET g_oogc_m.oogc015 = YEAR(g_today) + 1
   IF NOT cl_null(g_oogc_m.oogc002) THEN
      LET g_oogc_m.oogc016 = '1'
      IF g_oogc_m.oogc002 = '4' THEN
         CALL cl_set_comp_entry('oogc016',TRUE)
         CALL cl_set_comp_entry('bdate',TRUE)
      ELSE
         CALL cl_set_comp_entry('oogc016',FALSE)
         CALL cl_set_comp_entry('bdate',FALSE)
      END IF
   END IF
   IF NOT cl_null(g_oogc_m.oogc015) THEN
      LET g_oogc_m.bdate = MDY(1,1,g_oogc_m.oogc015)
      LET g_oogc_m.edate = MDY(12,31,g_oogc_m.oogc015)
      DISPLAY BY NAME g_oogc_m.bdate,g_oogc_m.edate
   END IF
   DISPLAY BY NAME g_oogc_m.oogc001,g_oogc_m.oogc002,g_oogc_m.oogc015,g_oogc_m.oogc016          {#ADP版次:1#}
   #end add-point

   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)

      #輸入開始
      INPUT BY NAME g_oogc_m.oogc001,g_oogc_m.oogc002,g_oogc_m.oogc015,g_oogc_m.bdate,g_oogc_m.edate,g_oogc_m.oogc016 ATTRIBUTE(WITHOUT DEFAULTS)

         #自訂ACTION
         #add-point:單頭前置處理
         {<point name="input.action"/>}
         #end add-point

         #自訂ACTION(master_input)


         BEFORE INPUT
            #add-point:單頭輸入前處理
            {<point name="input.before_input"/>}
            #end add-point

         #---------------------------<  Master  >---------------------------
         #----<<oogc001>>----
         #此段落由子樣板a02產生
         AFTER FIELD oogc001

            #add-point:AFTER FIELD oogc001
            #此段落由子樣板a05產生
            IF NOT cl_null(g_oogc_m.oogc001) THEN
               LET l_n = 0
               SELECT COUNT(*) INTO l_n FROM ooal_t
                WHERE ooalent = g_enterprise
                  AND ooal002 = g_oogc_m.oogc001
                  AND ooal001 = 4
               IF l_n = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'aoo-00112'
                  LET g_errparam.extend = g_oogc_m.oogc001
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD CURRENT
               END IF

               LET l_n = 0
               SELECT COUNT(*) INTO l_n FROM ooal_t
                WHERE ooalent = g_enterprise
                  AND ooal002 = g_oogc_m.oogc001
                  AND ooal001 = 4
                  AND ooalstus='Y'
               IF l_n = 0 THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = 'sub-01302'  #agl-00004 #160318-00005#32 by 07900 --mod  
                  LET g_errparam.extend = g_oogc_m.oogc001
                   #160318-00005#31  By 07900 --add-str
                   LET g_errparam.replace[1] ='aooi070'
                   LET g_errparam.replace[2] = cl_get_progname("aooi070",g_lang,"2")
                   LET g_errparam.exeprog ='aooi070'
                   #160318-00005#31  By 07900 --add-end
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD CURRENT
               END IF
            END IF

            INITIALIZE g_ref_fields TO NULL
            LET g_ref_fields[1] = g_oogc_m.oogc001
            CALL ap_ref_array2(g_ref_fields,"SELECT ooall004 FROM ooall_t WHERE ooallent='"||g_enterprise||"' AND ooall002=? AND ooall003='"||g_dlang||"'","") RETURNING g_rtn_fields
            LET g_oogc_m.oogc001_desc = g_rtn_fields[1]
            DISPLAY BY NAME g_oogc_m.oogc001_desc
          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a01產生
         BEFORE FIELD oogc001
            #add-point:BEFORE FIELD oogc001
            {<point name="input.b.oogc001" />}
            #END add-point

         #此段落由子樣板a04產生
         ON CHANGE oogc001
            #add-point:ON CHANGE oogc001
            {<point name="input.g.oogc001" />}
            #END add-point

         #----<<oogc002>>----
         #此段落由子樣板a01產生
         BEFORE FIELD oogc002
            #add-point:BEFORE FIELD oogc002
            {<point name="input.b.oogc002" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD oogc002

            #add-point:AFTER FIELD oogc002
            #此段落由子樣板a05產生
            IF NOT cl_null(g_oogc_m.oogc002) THEN
               LET g_oogc_m.oogc016 = '1'
               IF g_oogc_m.oogc002 = '4' THEN
                  CALL cl_set_comp_entry('oogc016',TRUE)
                  CALL cl_set_comp_entry('bdate',TRUE)
               ELSE
                  CALL cl_set_comp_entry('oogc016',FALSE)
                  IF NOT cl_null(g_oogc_m.oogc015) THEN
                     CALL cl_set_comp_entry('bdate',FALSE)
                  ELSE
                     CALL cl_set_comp_entry('bdate',TRUE)
                  END IF
               END IF
            END IF


          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE oogc002
            #add-point:ON CHANGE oogc002
            {<point name="input.g.oogc002" />}
            #END add-point

         #----<<oogc015>>----
         #此段落由子樣板a01產生
         BEFORE FIELD oogc015
            #add-point:BEFORE FIELD oogc015
            {<point name="input.b.oogc015" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD oogc015

            #add-point:AFTER FIELD oogc015
            IF NOT cl_null(g_oogc_m.oogc015) THEN
               IF cl_null (g_oogc_m.bdate) AND cl_null(g_oogc_m.edate) THEN
                  LET g_oogc_m.bdate = MDY(1,1,g_oogc_m.oogc015)
                  LET g_oogc_m.edate = MDY(12,31,g_oogc_m.oogc015)
                  DISPLAY BY NAME g_oogc_m.bdate,g_oogc_m.edate
               END IF
            END IF          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE oogc015
            #add-point:ON CHANGE oogc015
            {<point name="input.g.oogc015" />}
            #END add-point

         #----<<bdate>>----
         #此段落由子樣板a01產生
         BEFORE FIELD bdate
            #add-point:BEFORE FIELD bdate
           {#ADP版次:1#}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD bdate

            #add-point:AFTER FIELD bdate

            IF NOT cl_null(g_oogc_m.bdate) THEN
              LET g_oogc_m.edate = s_date_get_date(g_oogc_m.bdate,12,-1)
              DISPLAY BY NAME g_oogc_m.edate
            END IF
                      {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE bdate
            #add-point:ON CHANGE bdate
            {<point name="input.g.bdate" />}
            #END add-point

         #----<<edate>>----
         #此段落由子樣板a01產生
         BEFORE FIELD edate
            #add-point:BEFORE FIELD edate
            {<point name="input.b.edate" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD edate

            #add-point:AFTER FIELD edate
            IF NOT cl_null(g_oogc_m.bdate) AND NOT cl_null(g_oogc_m.edate) THEN
                IF g_oogc_m.bdate > g_oogc_m.edate THEN
                    INITIALIZE g_errparam TO NULL
                    LET g_errparam.code = 'sub-00095'
                    LET g_errparam.extend = g_oogc_m.edate
                    LET g_errparam.popup = TRUE
                    CALL cl_err()

                    NEXT FIELD edate
                END IF
             END IF          {#ADP版次:1#}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE edate
            #add-point:ON CHANGE edate
            {<point name="input.g.edate" />}
            #END add-point

         #----<<oogc016>>----
         #此段落由子樣板a01產生
         BEFORE FIELD oogc016
            #add-point:BEFORE FIELD oogc016
            {<point name="input.b.oogc016" />}
            #END add-point

         #此段落由子樣板a02產生
         AFTER FIELD oogc016

            #add-point:AFTER FIELD oogc016
            {<point name="input.a.oogc016" />}
            #END add-point


         #此段落由子樣板a04產生
         ON CHANGE oogc016
            #add-point:ON CHANGE oogc016
            {<point name="input.g.oogc016" />}
            #END add-point

 #欄位檢查
         #---------------------------<  Master  >---------------------------
         #----<<oogc001>>----
         #Ctrlp:input.c.oogc001
         ON ACTION controlp INFIELD oogc001
            #add-point:ON ACTION controlp INFIELD oogc001
#此段落由子樣板a07產生
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_oogc_m.oogc001             #給予default值

            #給予arg
            LET g_qryparam.where = " ooal001 = '4'"
            CALL q_ooal002()                                #呼叫開窗
            INITIALIZE g_qryparam.where TO NULL
            LET g_oogc_m.oogc001 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_oogc_m.oogc001 TO oogc001              #顯示到畫面上

            NEXT FIELD oogc001                          #返回原欄位

          {#ADP版次:1#}
            #END add-point

         #----<<oogc002>>----
         #Ctrlp:input.c.oogc002
#         ON ACTION controlp INFIELD oogc002
            #add-point:ON ACTION controlp INFIELD oogc002
            {<point name="input.c.oogc002" />}
            #END add-point

         #----<<oogc015>>----
         #Ctrlp:input.c.oogc015
#         ON ACTION controlp INFIELD oogc015
            #add-point:ON ACTION controlp INFIELD oogc015
            {<point name="input.c.oogc015" />}
            #END add-point

         #----<<bdate>>----
         #Ctrlp:input.c.bdate
#         ON ACTION controlp INFIELD bdate
            #add-point:ON ACTION controlp INFIELD bdate
            {<point name="input.c.bdate" />}
            #END add-point

         #----<<edate>>----
         #Ctrlp:input.c.edate
#         ON ACTION controlp INFIELD edate
            #add-point:ON ACTION controlp INFIELD edate
            {<point name="input.c.edate" />}
            #END add-point

         #----<<oogc016>>----
         #Ctrlp:input.c.oogc016
#         ON ACTION controlp INFIELD oogc016
            #add-point:ON ACTION controlp INFIELD oogc016
            {<point name="input.c.oogc016" />}
            #END add-point

 #欄位開窗

         AFTER INPUT
            #add-point:單頭輸入後處理
            {<point name="input.after_input"/>}
            #end add-point

      END INPUT

      #add-point:自定義input
      {<point name="input.more_input"/>}
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

   #add-point:畫面關閉前
   {<point name="input.before_close"/>}
   #end add-point

   #畫面關閉
   CLOSE WINDOW w_aooi420_03

   #add-point:input段after input
   IF NOT INT_FLAG THEN
      CALL s_transaction_begin()
      #LET l_sql = "SELECT * FROM oogc_t WHERE oogcent = '",g_enterprise,"'",  #161124-00048#13  2016/12/14 By 08734 mark
      LET l_sql = "SELECT oogcent,oogcstus,oogc001,oogc002,oogc003,oogc004,oogc005,oogc006,oogc007,oogc008,oogc009,oogc010,oogc011,oogc012,oogc013,",  #161124-00048#13  2016/12/14 By 08734 add
                  " oogc014,oogc015,oogcownid,oogcowndp,oogccrtid,oogccrtdp,oogccrtdt,oogcmodid,oogcmoddt,oogc016,oogc017 FROM oogc_t WHERE oogcent = '",g_enterprise,"'", 
                  " AND oogc001 = '",g_oogc_m.oogc001,"' AND oogc002 = '",g_oogc_m.oogc002,"'",
                  " AND oogc003 BETWEEN '",g_oogc_m.bdate,"' AND '",g_oogc_m.edate,"'"
      PREPARE aooi420_03_pre1 FROM l_sql
      DECLARE aooi420_03_cur1 CURSOR FOR aooi420_03_pre1
      LET b_date = g_oogc_m.bdate
      LET f_date = g_oogc_m.edate
      LET l_yy = YEAR(b_date)
      FOREACH aooi420_03_cur1 INTO l_oogc.*
         LET l_days = l_oogc.oogc003 - b_date
         LET l_mm = 0
         LET l_week= 0
         #計算週別
         FOR l_i = 1 TO l_days
             IF WEEKDAY(b_date + l_i) = 0 THEN
                LET l_week = l_week +1
             END IF
             IF l_week = 0 THEN
                LET l_week = l_week +1
             END IF
         END FOR
         FOR i= 1 TO 12
            LET l_date[i] = s_date_get_date(b_date,i,0)
            LET l_date2[i] = l_date[i] -1
         END FOR
         #週期種類1.月
         IF g_oogc_m.oogc016 = '1' THEN
            #第一季度
            IF l_oogc.oogc003 <= l_date2[3] THEN
               LET l_ss = 1
               IF l_oogc.oogc003 <= l_date2[1] THEN
                  LET l_mm = 1
               END IF
               IF l_oogc.oogc003 >= l_date[1] AND l_oogc.oogc003 <= l_date2[2] THEN
                  LET l_mm = 2
               END IF
	           IF l_oogc.oogc003 >= l_date[2] AND l_oogc.oogc003 <= l_date2[3] THEN
                  LET l_mm = 3
               END IF
            END IF
            #第二季度
            IF l_oogc.oogc003 <= l_date2[6] AND l_oogc.oogc003 >= l_date[3]THEN
               LET l_ss = 2
      	       IF l_oogc.oogc003 >= l_date[3] AND l_oogc.oogc003 <= l_date2[4] THEN
                  LET l_mm = 4
               END IF
    	       IF l_oogc.oogc003 >= l_date[4] AND l_oogc.oogc003 <= l_date2[5] THEN
                  LET l_mm = 5
               END IF
	           IF l_oogc.oogc003 >= l_date[5] AND l_oogc.oogc003 <= l_date2[6] THEN
                  LET l_mm = 6
               END IF
            END IF
            #第三季度
            IF l_oogc.oogc003 <= l_date2[9] AND l_oogc.oogc003 >= l_date[6]THEN
               LET l_ss = 3
	           IF l_oogc.oogc003 >= l_date[6] AND l_oogc.oogc003 <= l_date2[7] THEN
                  LET l_mm = 7
               END IF
	           IF l_oogc.oogc003 >= l_date[7] AND l_oogc.oogc003 <= l_date2[8] THEN
                  LET l_mm = 8
               END IF
	           IF l_oogc.oogc003 >= l_date[8] AND l_oogc.oogc003 <= l_date2[9] THEN
                  LET l_mm = 9
               END IF
            END IF
            #第四季度
            IF l_oogc.oogc003 <= l_date2[12] AND l_oogc.oogc003 >= l_date[9]THEN
               LET l_ss = 4
	           IF l_oogc.oogc003 >= l_date[9] AND l_oogc.oogc003 <= l_date2[10] THEN
                  LET l_mm = 10
               END IF
	           IF l_oogc.oogc003 >= l_date[10] AND l_oogc.oogc003 <= l_date2[11] THEN
                  LET l_mm = 11
               END IF
	           IF l_oogc.oogc003 >= l_date[11] AND l_oogc.oogc003 <= l_date2[12] THEN
                  LET l_mm = 12
               END IF
            END IF
         END IF
         #周奇種類 2.週
         IF g_oogc_m.oogc016 = '2' THEN
            #第一季度
            IF l_oogc.oogc003 <= b_date +83 THEN
               LET l_ss = 1
               IF l_oogc.oogc003 <= b_date +27 THEN
                  LET l_mm = 1
               END IF
	           IF l_oogc.oogc003 <= b_date +55 AND l_oogc.oogc003 >= b_date +28 THEN
	              LET l_mm = 2
               END IF
	           IF l_oogc.oogc003 <= b_date +83 AND l_oogc.oogc003 >= b_date +56 THEN
	              LET l_mm = 3
               END IF
            END IF
            #第二季度
            IF l_oogc.oogc003 <= b_date +167 AND l_oogc.oogc003 >= b_date+84 THEN
               LET l_ss = 2
               IF l_oogc.oogc003 <= b_date +111 AND l_oogc.oogc003 >= b_date + 84 THEN
	              LET l_mm = 4
               END IF
	           IF l_oogc.oogc003 <= b_date +139 AND l_oogc.oogc003 >= b_date +112 THEN
	              LET l_mm = 5
               END IF
	           IF l_oogc.oogc003 <= b_date +167 AND l_oogc.oogc003 >= b_date +140 THEN
  	              LET l_mm = 6
               END IF
             END IF
             #第三季度
             IF l_oogc.oogc003 <= b_date +251 AND l_oogc.oogc003 >= b_date+168 THEN
                LET l_ss = 3
                IF l_oogc.oogc003 <= b_date + 195 AND l_oogc.oogc003 >= b_date + 168 THEN
	              LET l_mm = 7
                END IF
	            IF l_oogc.oogc003 <= b_date + 223 AND l_oogc.oogc003 >= b_date + 196 THEN
	               LET l_mm = 8
                END IF
	            IF l_oogc.oogc003 <= b_date + 251 AND l_oogc.oogc003 >= b_date + 224 THEN
	               LET l_mm = 9
                END IF
             END IF
             #第四季度
             IF l_oogc.oogc003 <= f_date AND l_oogc.oogc003 >= b_date+252 THEN
                LET l_ss = 4
                IF l_oogc.oogc003 <= b_date + 279 AND l_oogc.oogc003 >= b_date + 252 THEN
	               LET l_mm = 10
                END IF
	            IF l_oogc.oogc003 <= b_date + 307 AND l_oogc.oogc003 >= b_date + 280 THEN
	               LET l_mm = 11
                END IF
	            IF l_oogc.oogc003 <= b_date + 335 AND l_oogc.oogc003 >= b_date + 308 THEN
	               LET l_mm = 12
                END IF
	            IF l_oogc.oogc003 <= f_date   AND l_oogc.oogc003 >= b_date + 336 THEN
	               LET l_mm = 13
                END IF
             END IF
         END IF
         #週期種類 3.445
         IF g_oogc_m.oogc016 = '3' THEN
            #第一季度
            IF l_oogc.oogc003 <= b_date +90 THEN
               LET l_ss = 1
               IF l_oogc.oogc003 <= b_date +27 THEN
                  LET l_mm = 1
               END IF
               IF l_oogc.oogc003 <= b_date +55 AND l_oogc.oogc003 >= b_date +28 THEN
                  LET l_mm = 2
               END IF
               IF l_oogc.oogc003 <= b_date +90 AND l_oogc.oogc003 >= b_date +56 THEN
                  LET l_mm = 3
               END IF
            END IF
            #第二季度
            IF l_oogc.oogc003 <= b_date +181 AND l_oogc.oogc003 >= b_date+91 THEN
               LET l_ss = 2
               IF l_oogc.oogc003 <= b_date +118 AND l_oogc.oogc003 >= b_date + 91 THEN
                  LET l_mm = 4
               END IF
               IF l_oogc.oogc003 <= b_date +146 AND l_oogc.oogc003 >= b_date +119 THEN
                  LET l_mm = 5
               END IF
               IF l_oogc.oogc003 <= b_date +181 AND l_oogc.oogc003 >= b_date +147 THEN
                  LET l_mm = 6
               END IF
            END IF
            #第三季度
            IF l_oogc.oogc003 <= b_date +272 AND l_oogc.oogc003 >= b_date+182 THEN
               LET l_ss = 3
               IF l_oogc.oogc003 <= b_date + 209 AND l_oogc.oogc003 >= b_date + 182 THEN
                  LET l_mm = 7
               END IF
               IF l_oogc.oogc003 <= b_date + 237 AND l_oogc.oogc003 >= b_date + 210 THEN
                  LET l_mm = 8
               END IF
               IF l_oogc.oogc003 <= b_date + 272 AND l_oogc.oogc003 >= b_date + 238 THEN
                  LET l_mm = 9
               END IF
            END IF
            #第四季度
            IF l_oogc.oogc003 <= f_date AND l_oogc.oogc003 >= b_date+273 THEN
               LET l_ss = 4
               IF l_oogc.oogc003 <= b_date + 300 AND l_oogc.oogc003 >= b_date + 273 THEN
                  LET l_mm = 10
               END IF
               IF l_oogc.oogc003 <= b_date + 328 AND l_oogc.oogc003 >= b_date + 301 THEN
                  LET l_mm = 11
               END IF
               IF l_oogc.oogc003 <= f_date   AND l_oogc.oogc003 >= b_date + 329 THEN
                  LET l_mm = 12
               END IF
            END IF
         END IF
         UPDATE oogc_t SET oogc006 = l_mm,
                           oogc007 = l_ss,
                           oogc008 = l_week,
                           oogc015 = l_yy
                     WHERE oogc001 = g_oogc_m.oogc001
                       AND oogc002 = g_oogc_m.oogc002
                       AND oogc003 = l_oogc.oogc003
                       AND oogcent = g_enterprise
          IF SQLCA.SQLCODE THEN
             LET l_success = 'N'
             EXIT FOREACH
          ELSE
             LET l_success = 'Y'
          END IF
      END FOREACH
      CALL s_transaction_end(l_success,'1')
   END IF          {#ADP版次:1#}
   #end add-point

END FUNCTION

 
{</section>}
 
