#該程式未解開Section, 採用最新樣板產出!
{<section id="aooi360_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0008(2014-10-30 16:16:45), PR版次:0008(2017-02-24 16:53:36)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000187
#+ Filename...: aooi360_01
#+ Description: 備註維護子程式
#+ Creator....: 01258(2013-08-16 10:53:15)
#+ Modifier...: 02294 -SD/PR- 02294
 
{</section>}
 
{<section id="aooi360_01.global" >}
#應用 c02b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#Memos
#161124-00048#13   2016/12/14  By 08734   星号整批调整
#161031-00025#1    2017/01/17  By lixiang 根据传入参数的备注类型，开窗只能开出对应的备注类型资料
#161031-00025#4    2017/01/17  By lixiang 1.備註欄位開窗增加二個action"預設備註"、"個人常用備註"，點選開窗後帶回資料
#161031-00025#35   2017/02/20  By xujing  如果是变更单(apmt510,apmt490,apmt410)等...修改单头备注关闭ooff012控制类型
#161031-00025#37   2017/02/24  By lixiang 判断单身状态是否是修改时，需加上key不可为空
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
GLOBALS "../../aoo/4gl/aooi360_01.inc"
#end add-point
 
#單身 type 宣告
PRIVATE TYPE type_g_ooff_d        RECORD
       ooff001 LIKE ooff_t.ooff001, 
   ooff002 LIKE ooff_t.ooff002, 
   ooff004 LIKE ooff_t.ooff004, 
   ooff005 LIKE ooff_t.ooff005, 
   ooff006 LIKE ooff_t.ooff006, 
   ooff007 LIKE ooff_t.ooff007, 
   ooff008 LIKE ooff_t.ooff008, 
   ooff009 LIKE ooff_t.ooff009, 
   ooff010 LIKE ooff_t.ooff010, 
   ooff011 LIKE ooff_t.ooff011, 
   ooff003 LIKE ooff_t.ooff003, 
   ooff012 LIKE ooff_t.ooff012, 
   ooff013 LIKE ooff_t.ooff013, 
   ooff014 LIKE ooff_t.ooff014
       END RECORD
 
 
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
----2015-1-9 zj mod------
GLOBALS
   DEFINE g_ooff_d4              DYNAMIC ARRAY OF type_g_ooff_d 
   #161031-00025#35 add(s)
   DEFINE g_ooff_d4_color   DYNAMIC ARRAY OF  RECORD
       ooff001 STRING, 
       ooff002 STRING, 
       ooff004 STRING, 
       ooff005 STRING, 
       ooff006 STRING, 
       ooff007 STRING, 
       ooff008 STRING, 
       ooff009 STRING, 
       ooff010 STRING, 
       ooff011 STRING, 
       ooff003 STRING, 
       ooff012 STRING, 
       ooff013 STRING, 
       ooff014 STRING
                       END RECORD  
   #161031-00025#35 add(e)
END GLOBALS
#end add-point
 
DEFINE g_ooff_d          DYNAMIC ARRAY OF type_g_ooff_d
DEFINE g_ooff_d_t        type_g_ooff_d
 
 
DEFINE g_ooff001_t   LIKE ooff_t.ooff001    #Key值備份
DEFINE g_ooff002_t      LIKE ooff_t.ooff002    #Key值備份
DEFINE g_ooff003_t      LIKE ooff_t.ooff003    #Key值備份
DEFINE g_ooff004_t      LIKE ooff_t.ooff004    #Key值備份
DEFINE g_ooff005_t      LIKE ooff_t.ooff005    #Key值備份
DEFINE g_ooff006_t      LIKE ooff_t.ooff006    #Key值備份
DEFINE g_ooff007_t      LIKE ooff_t.ooff007    #Key值備份
DEFINE g_ooff008_t      LIKE ooff_t.ooff008    #Key值備份
DEFINE g_ooff009_t      LIKE ooff_t.ooff009    #Key值備份
DEFINE g_ooff010_t      LIKE ooff_t.ooff010    #Key值備份
DEFINE g_ooff011_t      LIKE ooff_t.ooff011    #Key值備份
DEFINE g_ooff012_t      LIKE ooff_t.ooff012    #Key值備份
 
 
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
 
{<section id="aooi360_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION aooi360_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_ooff001,p_ooff002,p_ooff003,p_ooff004,p_ooff005,p_ooff006,p_ooff007,p_ooff008,p_ooff009,p_ooff010,p_ooff011
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
   DEFINE p_ooff001       LIKE ooff_t.ooff001   #備註類型:1.人員備註2.客商備註3.料號備註4.BOM單頭備註5.BO單身備註6.單據單頭備註7.單據單身備註8.製程料號單頭備註9.製程料號單身備註
   DEFINE p_ooff002       LIKE ooff_t.ooff002   #第一Key值
   DEFINE p_ooff003       LIKE ooff_t.ooff003   #第二Key值
   DEFINE p_ooff004       LIKE ooff_t.ooff004   #第三Key值
   DEFINE p_ooff005       LIKE ooff_t.ooff005   #第四Key值
   DEFINE p_ooff006       LIKE ooff_t.ooff006   #第五Key值
   DEFINE p_ooff007       LIKE ooff_t.ooff007   #第六Key值
   DEFINE p_ooff008       LIKE ooff_t.ooff008   #第七Key值
   DEFINE p_ooff009       LIKE ooff_t.ooff009   #第八Key值
   DEFINE p_ooff010       LIKE ooff_t.ooff010   #第九Key值
   DEFINE p_ooff011       LIKE ooff_t.ooff011   #第十Key值
   #DEFINE l_ooff          RECORD LIKE ooff_t.*  #161124-00048#13  2016/12/14 By 08734 mark
   #161124-00048#13  2016/12/14 By 08734 add(S)
   DEFINE l_ooff RECORD  #備註檔
       ooffent LIKE ooff_t.ooffent, #企业编号
       ooffstus LIKE ooff_t.ooffstus, #状态码
       ooff001 LIKE ooff_t.ooff001, #备注类型
       ooff002 LIKE ooff_t.ooff002, #第一KEY值
       ooff003 LIKE ooff_t.ooff003, #第二KEY值
       ooff004 LIKE ooff_t.ooff004, #第三KEY值
       ooff005 LIKE ooff_t.ooff005, #第四KEY值
       ooff006 LIKE ooff_t.ooff006, #第五KEY值
       ooff007 LIKE ooff_t.ooff007, #第六KEY值
       ooff008 LIKE ooff_t.ooff008, #第七KEY值
       ooff009 LIKE ooff_t.ooff009, #第八KEY值
       ooff010 LIKE ooff_t.ooff010, #第九KEY值
       ooff011 LIKE ooff_t.ooff011, #第十KEY值
       ooff012 LIKE ooff_t.ooff012, #控制类型
       ooff013 LIKE ooff_t.ooff013, #备注说明
       ooff014 LIKE ooff_t.ooff014, #失效日期
       ooff015 LIKE ooff_t.ooff015, #内部信息传递
       ooffownid LIKE ooff_t.ooffownid, #资料所有者
       ooffowndp LIKE ooff_t.ooffowndp, #资料所有部门
       ooffcrtid LIKE ooff_t.ooffcrtid, #资料录入者
       ooffcrtdp LIKE ooff_t.ooffcrtdp, #资料录入部门
       ooffcrtdt LIKE ooff_t.ooffcrtdt, #资料创建日
       ooffmodid LIKE ooff_t.ooffmodid, #资料更改者
       ooffmoddt LIKE ooff_t.ooffmoddt #最近更改日
END RECORD
#161124-00048#13  2016/12/14 By 08734 add(E)
   DEFINE l_forupd_sql    STRING
   DEFINE l_lock_sw       LIKE type_t.chr1 
   #end add-point
 
   #畫面開啟 (identifier)
   OPEN WINDOW w_aooi360_01 WITH FORM cl_ap_formpath("aoo","aooi360_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   
   LET l_allow_insert = cl_auth_detail_input("insert")
   LET l_allow_delete = cl_auth_detail_input("delete")
   
   #輸入前處理
   #add-point:單身前置處理 name="input.pre_input"
   WHENEVER ERROR CONTINUE
   CALL cl_set_combo_scc('ooff012','11')
   CALL cl_set_comp_entry("ooff003",FALSE)
   IF NOT(p_ooff001 = '6' OR p_ooff001 = '7') THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'aoo-00167'
      LET g_errparam.extend = p_ooff001
      LET g_errparam.popup = FALSE
      CALL cl_err()

      CLOSE WINDOW w_aooi360_01 
      RETURN
   END IF
   IF p_ooff001 = '6' THEN
      CALL cl_set_comp_visible("ooff003",FALSE)
   ELSE
      CALL cl_set_comp_visible("ooff003",TRUE)
   END IF
   IF cl_null(p_ooff002) THEN LET p_ooff002=' ' END IF
   IF cl_null(p_ooff003) THEN LET p_ooff003=' ' END IF
   IF cl_null(p_ooff004) THEN LET p_ooff004=' ' END IF
   IF cl_null(p_ooff005) THEN LET p_ooff005=' ' END IF
   IF cl_null(p_ooff006) THEN LET p_ooff006=' ' END IF
   IF cl_null(p_ooff007) THEN LET p_ooff007=' ' END IF
   IF cl_null(p_ooff008) THEN LET p_ooff008=' ' END IF
   IF cl_null(p_ooff009) THEN LET p_ooff009=' ' END IF
   IF cl_null(p_ooff010) THEN LET p_ooff010=' ' END IF
   IF cl_null(p_ooff011) THEN LET p_ooff011=' ' END IF
   CALL aooi360_01_b_fill(p_ooff001,p_ooff002,p_ooff003,p_ooff004,p_ooff005,p_ooff006,p_ooff007,p_ooff008,p_ooff009,p_ooff010,p_ooff011)
   LET l_forupd_sql = " SELECT ooff001,ooff002,ooff004,ooff005,ooff006,ooff007,ooff008,ooff009,ooff010,ooff011,ooff003,ooff012,ooff013,ooff014 ",
                      "   FROM ooff_t WHERE ooffent = '",g_enterprise,"' ",
                      "    AND ooff001 = ? AND ooff002 = ? AND ooff003 = ? ",
                      "    AND ooff004 = ? AND ooff005 = ? AND ooff006 = ? ",
                      "    AND ooff007 = ? AND ooff008 = ? AND ooff009 = ? ",
                      "    AND ooff010 = ? AND ooff011 = ? AND ooff012 = ? FOR UPDATE"
   LET l_forupd_sql = cl_sql_forupd(l_forupd_sql)  
   PREPARE aooi360_01_b FROM l_forupd_sql
   DECLARE aooi360_01_cs CURSOR FOR aooi360_01_b 
   LET INT_FLAG = FALSE
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT ARRAY g_ooff_d FROM s_detail1_aooi360_01.*
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
         
         BEFORE ROW
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()
            LET g_rec_b = g_ooff_d.getLength()
            
            IF g_rec_b >= l_ac THEN  
               LET l_cmd='u'
               LET g_ooff_d_t.* = g_ooff_d[l_ac].*  #BACKUP
               OPEN aooi360_01_cs USING p_ooff001,p_ooff002,p_ooff003,p_ooff004,p_ooff005,p_ooff006,p_ooff007,p_ooff008,p_ooff009,p_ooff010,p_ooff011,g_ooff_d[l_ac].ooff012

               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "aooi360_01_cs"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET l_lock_sw='Y'
               ELSE
                  FETCH aooi360_01_cs INTO g_ooff_d[l_ac].*
                  IF SQLCA.sqlcode THEN
                     LET l_lock_sw = "Y"
                  END IF            
                  CALL cl_show_fld_cont()
               END IF
            ELSE
               LET l_cmd='a'
            END IF
            
         BEFORE INSERT
            CALL s_transaction_begin()
            LET l_cmd = 'a'
            INITIALIZE g_ooff_d_t.* TO NULL
            INITIALIZE g_ooff_d[l_ac].* TO NULL 
            
            LET g_ooff_d_t.* = g_ooff_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()  
            
         AFTER INSERT
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               CANCEL INSERT
            END IF
            LET l_ooff.ooffent = g_enterprise
            LET l_ooff.ooff001 = p_ooff001
            LET l_ooff.ooff002 = p_ooff002
            LET l_ooff.ooff003 = p_ooff003
            LET l_ooff.ooff004 = p_ooff004
            LET l_ooff.ooff005 = p_ooff005
            LET l_ooff.ooff006 = p_ooff006
            LET l_ooff.ooff007 = p_ooff007
            LET l_ooff.ooff008 = p_ooff008
            LET l_ooff.ooff009 = p_ooff009
            LET l_ooff.ooff010 = p_ooff010
            LET l_ooff.ooff011 = p_ooff011
            LET l_ooff.ooff012 = g_ooff_d[l_ac].ooff012
            LET l_ooff.ooff013 = g_ooff_d[l_ac].ooff013
            LET l_ooff.ooff014 = g_ooff_d[l_ac].ooff014
            LET l_ooff.ooffstus = 'Y'
            LET l_ooff.ooffownid = g_user
            LET l_ooff.ooffowndp = g_dept
            LET l_ooff.ooffcrtid = g_user
            LET l_ooff.ooffcrtdp = g_dept 
            LET l_ooff.ooffcrtdt = cl_get_current()
            LET l_ooff.ooffmodid = g_user
            LET l_ooff.ooffmoddt = cl_get_current()
         
            SELECT COUNT(*) INTO l_count FROM ooff_t 
             WHERE ooffent = g_enterprise
               AND ooff001 = p_ooff001 
               AND ooff002 = p_ooff002
               AND ooff003 = p_ooff003
               AND ooff004 = p_ooff004
               AND ooff005 = p_ooff005
               AND ooff006 = p_ooff006
               AND ooff007 = p_ooff007
               AND ooff008 = p_ooff008
               AND ooff009 = p_ooff009
               AND ooff010 = p_ooff010
               AND ooff011 = p_ooff011
               AND ooff012 = g_ooff_d[l_ac].ooff012
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #INSERT INTO ooff_t VALUES (l_ooff.*)  #161124-00048#13  2016/12/14 By 08734 mark
               INSERT INTO ooff_t(ooffent,ooffstus,ooff001,ooff002,ooff003,ooff004,ooff005,ooff006,ooff007,ooff008,ooff009,
               ooff010,ooff011,ooff012,ooff013,ooff014,ooff015,ooffownid,ooffowndp,ooffcrtid,ooffcrtdp,ooffcrtdt,ooffmodid,ooffmoddt)  #161124-00048#13  2016/12/14 By 08734 add
                  VALUES (l_ooff.ooffent,l_ooff.ooffstus,l_ooff.ooff001,l_ooff.ooff002,l_ooff.ooff003,l_ooff.ooff004,l_ooff.ooff005,l_ooff.ooff006,l_ooff.ooff007,l_ooff.ooff008,l_ooff.ooff009,
               l_ooff.ooff010,l_ooff.ooff011,l_ooff.ooff012,l_ooff.ooff013,l_ooff.ooff014,l_ooff.ooff015,l_ooff.ooffownid,l_ooff.ooffowndp,l_ooff.ooffcrtid,l_ooff.ooffcrtdp,l_ooff.ooffcrtdt,l_ooff.ooffmodid,l_ooff.ooffmoddt)
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "ooff_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CONTINUE DIALOG
               END IF
            ELSE    
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "std-00006"
               LET g_errparam.extend = 'INSERT'
               LET g_errparam.popup = TRUE
               CALL cl_err()

               INITIALIZE g_ooff_d[l_ac].* TO NULL
               CALL s_transaction_end('N',0)
               CANCEL INSERT
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "ooff_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
  
               CALL s_transaction_end('N',0)                   
               CANCEL INSERT
            ELSE
              
               CALL s_transaction_end('Y',0)
               
               ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
 
        BEFORE DELETE                            #是否取消單身
            IF NOT cl_null(g_ooff_d[l_ac].ooff001) AND NOT cl_null(g_ooff_d[l_ac].ooff012)THEN

               IF NOT cl_ask_del_detail() THEN
                  CANCEL DELETE
               END IF
               IF l_lock_sw = "Y" THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code =  -263
                  LET g_errparam.extend = ""
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CANCEL DELETE
               END IF
               DELETE FROM ooff_t
                WHERE ooffent = g_enterprise 
                  AND ooff001 = p_ooff001 
                  AND ooff002 = p_ooff002
                  AND ooff003 = p_ooff003
                  AND ooff004 = p_ooff004
                  AND ooff005 = p_ooff005
                  AND ooff006 = p_ooff006
                  AND ooff007 = p_ooff007
                  AND ooff008 = p_ooff008
                  AND ooff009 = p_ooff009
                  AND ooff010 = p_ooff010
                  AND ooff011 = p_ooff011
                  AND ooff012 = g_ooff_d[l_ac].ooff012
 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "oofc_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  CALL s_transaction_end('N',0)
                  CANCEL DELETE   
               ELSE
                  LET g_rec_b = g_rec_b-1
                  
                  CALL s_transaction_end('Y',0)
               END IF 
               CLOSE aooi360_01_cs
               LET l_count = g_ooff_d.getLength()
            END IF 
            
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = FALSE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_ooff_d[l_ac].* = g_ooff_d_t.*
               CLOSE aooi360_01_cs
               CALL s_transaction_end('N',0)
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = l_ooff.ooff001
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_ooff_d[l_ac].* = g_ooff_d_t.*
            ELSE
               UPDATE ooff_t SET (ooff013,ooff014)= (g_ooff_d[l_ac].ooff013,g_ooff_d[l_ac].ooff014)
                WHERE ooffent = g_enterprise
                  AND ooff001 = p_ooff001 
                  AND ooff002 = p_ooff002
                  AND ooff003 = g_ooff_d[l_ac].ooff003
                  AND ooff004 = p_ooff004
                  AND ooff005 = p_ooff005
                  AND ooff006 = p_ooff006
                  AND ooff007 = p_ooff007
                  AND ooff008 = p_ooff008
                  AND ooff009 = p_ooff009
                  AND ooff010 = p_ooff010
                  AND ooff011 = p_ooff011
                  AND ooff012 = g_ooff_d[l_ac].ooff012
 
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "ooff_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
   
                  LET g_ooff_d[l_ac].* = g_ooff_d_t.*
                  CALL s_transaction_end('N',0)
               ELSE
                  CALL s_transaction_end('Y',0)               
               END IF

            END IF
            
         AFTER ROW
            CLOSE aooi360_01_cs
              
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooff001
            #add-point:BEFORE FIELD ooff001 name="input.b.page1_aooi360_01.ooff001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooff001
            
            #add-point:AFTER FIELD ooff001 name="input.a.page1_aooi360_01.ooff001"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_ooff_d[l_ac].ooff001 IS NOT NULL AND g_ooff_d[l_ac].ooff002 IS NOT NULL AND g_ooff_d[l_ac].ooff003 IS NOT NULL AND g_ooff_d[l_ac].ooff004 IS NOT NULL AND g_ooff_d[l_ac].ooff005 IS NOT NULL AND g_ooff_d[l_ac].ooff006 IS NOT NULL AND g_ooff_d[l_ac].ooff007 IS NOT NULL AND g_ooff_d[l_ac].ooff008 IS NOT NULL AND g_ooff_d[l_ac].ooff009 IS NOT NULL AND g_ooff_d[l_ac].ooff010 IS NOT NULL AND g_ooff_d[l_ac].ooff011 IS NOT NULL AND g_ooff_d[l_ac].ooff012 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_ooff_d[l_ac].ooff001 != g_ooff_d_t.ooff001 OR g_ooff_d[l_ac].ooff002 != g_ooff_d_t.ooff002 OR g_ooff_d[l_ac].ooff003 != g_ooff_d_t.ooff003 OR g_ooff_d[l_ac].ooff004 != g_ooff_d_t.ooff004 OR g_ooff_d[l_ac].ooff005 != g_ooff_d_t.ooff005 OR g_ooff_d[l_ac].ooff006 != g_ooff_d_t.ooff006 OR g_ooff_d[l_ac].ooff007 != g_ooff_d_t.ooff007 OR g_ooff_d[l_ac].ooff008 != g_ooff_d_t.ooff008 OR g_ooff_d[l_ac].ooff009 != g_ooff_d_t.ooff009 OR g_ooff_d[l_ac].ooff010 != g_ooff_d_t.ooff010 OR g_ooff_d[l_ac].ooff011 != g_ooff_d_t.ooff011 OR g_ooff_d[l_ac].ooff012 != g_ooff_d_t.ooff012)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM ooff_t WHERE "||"ooffent = '" ||g_enterprise|| "' AND "||"ooff001 = '"||g_ooff_d[l_ac].ooff001 ||"' AND "|| "ooff002 = '"||g_ooff_d[l_ac].ooff002 ||"' AND "|| "ooff003 = '"||g_ooff_d[l_ac].ooff003 ||"' AND "|| "ooff004 = '"||g_ooff_d[l_ac].ooff004 ||"' AND "|| "ooff005 = '"||g_ooff_d[l_ac].ooff005 ||"' AND "|| "ooff006 = '"||g_ooff_d[l_ac].ooff006 ||"' AND "|| "ooff007 = '"||g_ooff_d[l_ac].ooff007 ||"' AND "|| "ooff008 = '"||g_ooff_d[l_ac].ooff008 ||"' AND "|| "ooff009 = '"||g_ooff_d[l_ac].ooff009 ||"' AND "|| "ooff010 = '"||g_ooff_d[l_ac].ooff010 ||"' AND "|| "ooff011 = '"||g_ooff_d[l_ac].ooff011 ||"' AND "|| "ooff012 = '"||g_ooff_d[l_ac].ooff012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooff001
            #add-point:ON CHANGE ooff001 name="input.g.page1_aooi360_01.ooff001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooff002
            #add-point:BEFORE FIELD ooff002 name="input.b.page1_aooi360_01.ooff002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooff002
            
            #add-point:AFTER FIELD ooff002 name="input.a.page1_aooi360_01.ooff002"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_ooff_d[l_ac].ooff001 IS NOT NULL AND g_ooff_d[l_ac].ooff002 IS NOT NULL AND g_ooff_d[l_ac].ooff003 IS NOT NULL AND g_ooff_d[l_ac].ooff004 IS NOT NULL AND g_ooff_d[l_ac].ooff005 IS NOT NULL AND g_ooff_d[l_ac].ooff006 IS NOT NULL AND g_ooff_d[l_ac].ooff007 IS NOT NULL AND g_ooff_d[l_ac].ooff008 IS NOT NULL AND g_ooff_d[l_ac].ooff009 IS NOT NULL AND g_ooff_d[l_ac].ooff010 IS NOT NULL AND g_ooff_d[l_ac].ooff011 IS NOT NULL AND g_ooff_d[l_ac].ooff012 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_ooff_d[l_ac].ooff001 != g_ooff_d_t.ooff001 OR g_ooff_d[l_ac].ooff002 != g_ooff_d_t.ooff002 OR g_ooff_d[l_ac].ooff003 != g_ooff_d_t.ooff003 OR g_ooff_d[l_ac].ooff004 != g_ooff_d_t.ooff004 OR g_ooff_d[l_ac].ooff005 != g_ooff_d_t.ooff005 OR g_ooff_d[l_ac].ooff006 != g_ooff_d_t.ooff006 OR g_ooff_d[l_ac].ooff007 != g_ooff_d_t.ooff007 OR g_ooff_d[l_ac].ooff008 != g_ooff_d_t.ooff008 OR g_ooff_d[l_ac].ooff009 != g_ooff_d_t.ooff009 OR g_ooff_d[l_ac].ooff010 != g_ooff_d_t.ooff010 OR g_ooff_d[l_ac].ooff011 != g_ooff_d_t.ooff011 OR g_ooff_d[l_ac].ooff012 != g_ooff_d_t.ooff012)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM ooff_t WHERE "||"ooffent = '" ||g_enterprise|| "' AND "||"ooff001 = '"||g_ooff_d[l_ac].ooff001 ||"' AND "|| "ooff002 = '"||g_ooff_d[l_ac].ooff002 ||"' AND "|| "ooff003 = '"||g_ooff_d[l_ac].ooff003 ||"' AND "|| "ooff004 = '"||g_ooff_d[l_ac].ooff004 ||"' AND "|| "ooff005 = '"||g_ooff_d[l_ac].ooff005 ||"' AND "|| "ooff006 = '"||g_ooff_d[l_ac].ooff006 ||"' AND "|| "ooff007 = '"||g_ooff_d[l_ac].ooff007 ||"' AND "|| "ooff008 = '"||g_ooff_d[l_ac].ooff008 ||"' AND "|| "ooff009 = '"||g_ooff_d[l_ac].ooff009 ||"' AND "|| "ooff010 = '"||g_ooff_d[l_ac].ooff010 ||"' AND "|| "ooff011 = '"||g_ooff_d[l_ac].ooff011 ||"' AND "|| "ooff012 = '"||g_ooff_d[l_ac].ooff012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooff002
            #add-point:ON CHANGE ooff002 name="input.g.page1_aooi360_01.ooff002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooff004
            #add-point:BEFORE FIELD ooff004 name="input.b.page1_aooi360_01.ooff004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooff004
            
            #add-point:AFTER FIELD ooff004 name="input.a.page1_aooi360_01.ooff004"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_ooff_d[l_ac].ooff001 IS NOT NULL AND g_ooff_d[l_ac].ooff002 IS NOT NULL AND g_ooff_d[l_ac].ooff003 IS NOT NULL AND g_ooff_d[l_ac].ooff004 IS NOT NULL AND g_ooff_d[l_ac].ooff005 IS NOT NULL AND g_ooff_d[l_ac].ooff006 IS NOT NULL AND g_ooff_d[l_ac].ooff007 IS NOT NULL AND g_ooff_d[l_ac].ooff008 IS NOT NULL AND g_ooff_d[l_ac].ooff009 IS NOT NULL AND g_ooff_d[l_ac].ooff010 IS NOT NULL AND g_ooff_d[l_ac].ooff011 IS NOT NULL AND g_ooff_d[l_ac].ooff012 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_ooff_d[l_ac].ooff001 != g_ooff_d_t.ooff001 OR g_ooff_d[l_ac].ooff002 != g_ooff_d_t.ooff002 OR g_ooff_d[l_ac].ooff003 != g_ooff_d_t.ooff003 OR g_ooff_d[l_ac].ooff004 != g_ooff_d_t.ooff004 OR g_ooff_d[l_ac].ooff005 != g_ooff_d_t.ooff005 OR g_ooff_d[l_ac].ooff006 != g_ooff_d_t.ooff006 OR g_ooff_d[l_ac].ooff007 != g_ooff_d_t.ooff007 OR g_ooff_d[l_ac].ooff008 != g_ooff_d_t.ooff008 OR g_ooff_d[l_ac].ooff009 != g_ooff_d_t.ooff009 OR g_ooff_d[l_ac].ooff010 != g_ooff_d_t.ooff010 OR g_ooff_d[l_ac].ooff011 != g_ooff_d_t.ooff011 OR g_ooff_d[l_ac].ooff012 != g_ooff_d_t.ooff012)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM ooff_t WHERE "||"ooffent = '" ||g_enterprise|| "' AND "||"ooff001 = '"||g_ooff_d[l_ac].ooff001 ||"' AND "|| "ooff002 = '"||g_ooff_d[l_ac].ooff002 ||"' AND "|| "ooff003 = '"||g_ooff_d[l_ac].ooff003 ||"' AND "|| "ooff004 = '"||g_ooff_d[l_ac].ooff004 ||"' AND "|| "ooff005 = '"||g_ooff_d[l_ac].ooff005 ||"' AND "|| "ooff006 = '"||g_ooff_d[l_ac].ooff006 ||"' AND "|| "ooff007 = '"||g_ooff_d[l_ac].ooff007 ||"' AND "|| "ooff008 = '"||g_ooff_d[l_ac].ooff008 ||"' AND "|| "ooff009 = '"||g_ooff_d[l_ac].ooff009 ||"' AND "|| "ooff010 = '"||g_ooff_d[l_ac].ooff010 ||"' AND "|| "ooff011 = '"||g_ooff_d[l_ac].ooff011 ||"' AND "|| "ooff012 = '"||g_ooff_d[l_ac].ooff012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooff004
            #add-point:ON CHANGE ooff004 name="input.g.page1_aooi360_01.ooff004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooff005
            #add-point:BEFORE FIELD ooff005 name="input.b.page1_aooi360_01.ooff005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooff005
            
            #add-point:AFTER FIELD ooff005 name="input.a.page1_aooi360_01.ooff005"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_ooff_d[l_ac].ooff001 IS NOT NULL AND g_ooff_d[l_ac].ooff002 IS NOT NULL AND g_ooff_d[l_ac].ooff003 IS NOT NULL AND g_ooff_d[l_ac].ooff004 IS NOT NULL AND g_ooff_d[l_ac].ooff005 IS NOT NULL AND g_ooff_d[l_ac].ooff006 IS NOT NULL AND g_ooff_d[l_ac].ooff007 IS NOT NULL AND g_ooff_d[l_ac].ooff008 IS NOT NULL AND g_ooff_d[l_ac].ooff009 IS NOT NULL AND g_ooff_d[l_ac].ooff010 IS NOT NULL AND g_ooff_d[l_ac].ooff011 IS NOT NULL AND g_ooff_d[l_ac].ooff012 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_ooff_d[l_ac].ooff001 != g_ooff_d_t.ooff001 OR g_ooff_d[l_ac].ooff002 != g_ooff_d_t.ooff002 OR g_ooff_d[l_ac].ooff003 != g_ooff_d_t.ooff003 OR g_ooff_d[l_ac].ooff004 != g_ooff_d_t.ooff004 OR g_ooff_d[l_ac].ooff005 != g_ooff_d_t.ooff005 OR g_ooff_d[l_ac].ooff006 != g_ooff_d_t.ooff006 OR g_ooff_d[l_ac].ooff007 != g_ooff_d_t.ooff007 OR g_ooff_d[l_ac].ooff008 != g_ooff_d_t.ooff008 OR g_ooff_d[l_ac].ooff009 != g_ooff_d_t.ooff009 OR g_ooff_d[l_ac].ooff010 != g_ooff_d_t.ooff010 OR g_ooff_d[l_ac].ooff011 != g_ooff_d_t.ooff011 OR g_ooff_d[l_ac].ooff012 != g_ooff_d_t.ooff012)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM ooff_t WHERE "||"ooffent = '" ||g_enterprise|| "' AND "||"ooff001 = '"||g_ooff_d[l_ac].ooff001 ||"' AND "|| "ooff002 = '"||g_ooff_d[l_ac].ooff002 ||"' AND "|| "ooff003 = '"||g_ooff_d[l_ac].ooff003 ||"' AND "|| "ooff004 = '"||g_ooff_d[l_ac].ooff004 ||"' AND "|| "ooff005 = '"||g_ooff_d[l_ac].ooff005 ||"' AND "|| "ooff006 = '"||g_ooff_d[l_ac].ooff006 ||"' AND "|| "ooff007 = '"||g_ooff_d[l_ac].ooff007 ||"' AND "|| "ooff008 = '"||g_ooff_d[l_ac].ooff008 ||"' AND "|| "ooff009 = '"||g_ooff_d[l_ac].ooff009 ||"' AND "|| "ooff010 = '"||g_ooff_d[l_ac].ooff010 ||"' AND "|| "ooff011 = '"||g_ooff_d[l_ac].ooff011 ||"' AND "|| "ooff012 = '"||g_ooff_d[l_ac].ooff012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooff005
            #add-point:ON CHANGE ooff005 name="input.g.page1_aooi360_01.ooff005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooff006
            #add-point:BEFORE FIELD ooff006 name="input.b.page1_aooi360_01.ooff006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooff006
            
            #add-point:AFTER FIELD ooff006 name="input.a.page1_aooi360_01.ooff006"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_ooff_d[l_ac].ooff001 IS NOT NULL AND g_ooff_d[l_ac].ooff002 IS NOT NULL AND g_ooff_d[l_ac].ooff003 IS NOT NULL AND g_ooff_d[l_ac].ooff004 IS NOT NULL AND g_ooff_d[l_ac].ooff005 IS NOT NULL AND g_ooff_d[l_ac].ooff006 IS NOT NULL AND g_ooff_d[l_ac].ooff007 IS NOT NULL AND g_ooff_d[l_ac].ooff008 IS NOT NULL AND g_ooff_d[l_ac].ooff009 IS NOT NULL AND g_ooff_d[l_ac].ooff010 IS NOT NULL AND g_ooff_d[l_ac].ooff011 IS NOT NULL AND g_ooff_d[l_ac].ooff012 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_ooff_d[l_ac].ooff001 != g_ooff_d_t.ooff001 OR g_ooff_d[l_ac].ooff002 != g_ooff_d_t.ooff002 OR g_ooff_d[l_ac].ooff003 != g_ooff_d_t.ooff003 OR g_ooff_d[l_ac].ooff004 != g_ooff_d_t.ooff004 OR g_ooff_d[l_ac].ooff005 != g_ooff_d_t.ooff005 OR g_ooff_d[l_ac].ooff006 != g_ooff_d_t.ooff006 OR g_ooff_d[l_ac].ooff007 != g_ooff_d_t.ooff007 OR g_ooff_d[l_ac].ooff008 != g_ooff_d_t.ooff008 OR g_ooff_d[l_ac].ooff009 != g_ooff_d_t.ooff009 OR g_ooff_d[l_ac].ooff010 != g_ooff_d_t.ooff010 OR g_ooff_d[l_ac].ooff011 != g_ooff_d_t.ooff011 OR g_ooff_d[l_ac].ooff012 != g_ooff_d_t.ooff012)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM ooff_t WHERE "||"ooffent = '" ||g_enterprise|| "' AND "||"ooff001 = '"||g_ooff_d[l_ac].ooff001 ||"' AND "|| "ooff002 = '"||g_ooff_d[l_ac].ooff002 ||"' AND "|| "ooff003 = '"||g_ooff_d[l_ac].ooff003 ||"' AND "|| "ooff004 = '"||g_ooff_d[l_ac].ooff004 ||"' AND "|| "ooff005 = '"||g_ooff_d[l_ac].ooff005 ||"' AND "|| "ooff006 = '"||g_ooff_d[l_ac].ooff006 ||"' AND "|| "ooff007 = '"||g_ooff_d[l_ac].ooff007 ||"' AND "|| "ooff008 = '"||g_ooff_d[l_ac].ooff008 ||"' AND "|| "ooff009 = '"||g_ooff_d[l_ac].ooff009 ||"' AND "|| "ooff010 = '"||g_ooff_d[l_ac].ooff010 ||"' AND "|| "ooff011 = '"||g_ooff_d[l_ac].ooff011 ||"' AND "|| "ooff012 = '"||g_ooff_d[l_ac].ooff012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooff006
            #add-point:ON CHANGE ooff006 name="input.g.page1_aooi360_01.ooff006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooff007
            #add-point:BEFORE FIELD ooff007 name="input.b.page1_aooi360_01.ooff007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooff007
            
            #add-point:AFTER FIELD ooff007 name="input.a.page1_aooi360_01.ooff007"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_ooff_d[l_ac].ooff001 IS NOT NULL AND g_ooff_d[l_ac].ooff002 IS NOT NULL AND g_ooff_d[l_ac].ooff003 IS NOT NULL AND g_ooff_d[l_ac].ooff004 IS NOT NULL AND g_ooff_d[l_ac].ooff005 IS NOT NULL AND g_ooff_d[l_ac].ooff006 IS NOT NULL AND g_ooff_d[l_ac].ooff007 IS NOT NULL AND g_ooff_d[l_ac].ooff008 IS NOT NULL AND g_ooff_d[l_ac].ooff009 IS NOT NULL AND g_ooff_d[l_ac].ooff010 IS NOT NULL AND g_ooff_d[l_ac].ooff011 IS NOT NULL AND g_ooff_d[l_ac].ooff012 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_ooff_d[l_ac].ooff001 != g_ooff_d_t.ooff001 OR g_ooff_d[l_ac].ooff002 != g_ooff_d_t.ooff002 OR g_ooff_d[l_ac].ooff003 != g_ooff_d_t.ooff003 OR g_ooff_d[l_ac].ooff004 != g_ooff_d_t.ooff004 OR g_ooff_d[l_ac].ooff005 != g_ooff_d_t.ooff005 OR g_ooff_d[l_ac].ooff006 != g_ooff_d_t.ooff006 OR g_ooff_d[l_ac].ooff007 != g_ooff_d_t.ooff007 OR g_ooff_d[l_ac].ooff008 != g_ooff_d_t.ooff008 OR g_ooff_d[l_ac].ooff009 != g_ooff_d_t.ooff009 OR g_ooff_d[l_ac].ooff010 != g_ooff_d_t.ooff010 OR g_ooff_d[l_ac].ooff011 != g_ooff_d_t.ooff011 OR g_ooff_d[l_ac].ooff012 != g_ooff_d_t.ooff012)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM ooff_t WHERE "||"ooffent = '" ||g_enterprise|| "' AND "||"ooff001 = '"||g_ooff_d[l_ac].ooff001 ||"' AND "|| "ooff002 = '"||g_ooff_d[l_ac].ooff002 ||"' AND "|| "ooff003 = '"||g_ooff_d[l_ac].ooff003 ||"' AND "|| "ooff004 = '"||g_ooff_d[l_ac].ooff004 ||"' AND "|| "ooff005 = '"||g_ooff_d[l_ac].ooff005 ||"' AND "|| "ooff006 = '"||g_ooff_d[l_ac].ooff006 ||"' AND "|| "ooff007 = '"||g_ooff_d[l_ac].ooff007 ||"' AND "|| "ooff008 = '"||g_ooff_d[l_ac].ooff008 ||"' AND "|| "ooff009 = '"||g_ooff_d[l_ac].ooff009 ||"' AND "|| "ooff010 = '"||g_ooff_d[l_ac].ooff010 ||"' AND "|| "ooff011 = '"||g_ooff_d[l_ac].ooff011 ||"' AND "|| "ooff012 = '"||g_ooff_d[l_ac].ooff012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooff007
            #add-point:ON CHANGE ooff007 name="input.g.page1_aooi360_01.ooff007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooff008
            #add-point:BEFORE FIELD ooff008 name="input.b.page1_aooi360_01.ooff008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooff008
            
            #add-point:AFTER FIELD ooff008 name="input.a.page1_aooi360_01.ooff008"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_ooff_d[l_ac].ooff001 IS NOT NULL AND g_ooff_d[l_ac].ooff002 IS NOT NULL AND g_ooff_d[l_ac].ooff003 IS NOT NULL AND g_ooff_d[l_ac].ooff004 IS NOT NULL AND g_ooff_d[l_ac].ooff005 IS NOT NULL AND g_ooff_d[l_ac].ooff006 IS NOT NULL AND g_ooff_d[l_ac].ooff007 IS NOT NULL AND g_ooff_d[l_ac].ooff008 IS NOT NULL AND g_ooff_d[l_ac].ooff009 IS NOT NULL AND g_ooff_d[l_ac].ooff010 IS NOT NULL AND g_ooff_d[l_ac].ooff011 IS NOT NULL AND g_ooff_d[l_ac].ooff012 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_ooff_d[l_ac].ooff001 != g_ooff_d_t.ooff001 OR g_ooff_d[l_ac].ooff002 != g_ooff_d_t.ooff002 OR g_ooff_d[l_ac].ooff003 != g_ooff_d_t.ooff003 OR g_ooff_d[l_ac].ooff004 != g_ooff_d_t.ooff004 OR g_ooff_d[l_ac].ooff005 != g_ooff_d_t.ooff005 OR g_ooff_d[l_ac].ooff006 != g_ooff_d_t.ooff006 OR g_ooff_d[l_ac].ooff007 != g_ooff_d_t.ooff007 OR g_ooff_d[l_ac].ooff008 != g_ooff_d_t.ooff008 OR g_ooff_d[l_ac].ooff009 != g_ooff_d_t.ooff009 OR g_ooff_d[l_ac].ooff010 != g_ooff_d_t.ooff010 OR g_ooff_d[l_ac].ooff011 != g_ooff_d_t.ooff011 OR g_ooff_d[l_ac].ooff012 != g_ooff_d_t.ooff012)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM ooff_t WHERE "||"ooffent = '" ||g_enterprise|| "' AND "||"ooff001 = '"||g_ooff_d[l_ac].ooff001 ||"' AND "|| "ooff002 = '"||g_ooff_d[l_ac].ooff002 ||"' AND "|| "ooff003 = '"||g_ooff_d[l_ac].ooff003 ||"' AND "|| "ooff004 = '"||g_ooff_d[l_ac].ooff004 ||"' AND "|| "ooff005 = '"||g_ooff_d[l_ac].ooff005 ||"' AND "|| "ooff006 = '"||g_ooff_d[l_ac].ooff006 ||"' AND "|| "ooff007 = '"||g_ooff_d[l_ac].ooff007 ||"' AND "|| "ooff008 = '"||g_ooff_d[l_ac].ooff008 ||"' AND "|| "ooff009 = '"||g_ooff_d[l_ac].ooff009 ||"' AND "|| "ooff010 = '"||g_ooff_d[l_ac].ooff010 ||"' AND "|| "ooff011 = '"||g_ooff_d[l_ac].ooff011 ||"' AND "|| "ooff012 = '"||g_ooff_d[l_ac].ooff012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooff008
            #add-point:ON CHANGE ooff008 name="input.g.page1_aooi360_01.ooff008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooff009
            #add-point:BEFORE FIELD ooff009 name="input.b.page1_aooi360_01.ooff009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooff009
            
            #add-point:AFTER FIELD ooff009 name="input.a.page1_aooi360_01.ooff009"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_ooff_d[l_ac].ooff001 IS NOT NULL AND g_ooff_d[l_ac].ooff002 IS NOT NULL AND g_ooff_d[l_ac].ooff003 IS NOT NULL AND g_ooff_d[l_ac].ooff004 IS NOT NULL AND g_ooff_d[l_ac].ooff005 IS NOT NULL AND g_ooff_d[l_ac].ooff006 IS NOT NULL AND g_ooff_d[l_ac].ooff007 IS NOT NULL AND g_ooff_d[l_ac].ooff008 IS NOT NULL AND g_ooff_d[l_ac].ooff009 IS NOT NULL AND g_ooff_d[l_ac].ooff010 IS NOT NULL AND g_ooff_d[l_ac].ooff011 IS NOT NULL AND g_ooff_d[l_ac].ooff012 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_ooff_d[l_ac].ooff001 != g_ooff_d_t.ooff001 OR g_ooff_d[l_ac].ooff002 != g_ooff_d_t.ooff002 OR g_ooff_d[l_ac].ooff003 != g_ooff_d_t.ooff003 OR g_ooff_d[l_ac].ooff004 != g_ooff_d_t.ooff004 OR g_ooff_d[l_ac].ooff005 != g_ooff_d_t.ooff005 OR g_ooff_d[l_ac].ooff006 != g_ooff_d_t.ooff006 OR g_ooff_d[l_ac].ooff007 != g_ooff_d_t.ooff007 OR g_ooff_d[l_ac].ooff008 != g_ooff_d_t.ooff008 OR g_ooff_d[l_ac].ooff009 != g_ooff_d_t.ooff009 OR g_ooff_d[l_ac].ooff010 != g_ooff_d_t.ooff010 OR g_ooff_d[l_ac].ooff011 != g_ooff_d_t.ooff011 OR g_ooff_d[l_ac].ooff012 != g_ooff_d_t.ooff012)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM ooff_t WHERE "||"ooffent = '" ||g_enterprise|| "' AND "||"ooff001 = '"||g_ooff_d[l_ac].ooff001 ||"' AND "|| "ooff002 = '"||g_ooff_d[l_ac].ooff002 ||"' AND "|| "ooff003 = '"||g_ooff_d[l_ac].ooff003 ||"' AND "|| "ooff004 = '"||g_ooff_d[l_ac].ooff004 ||"' AND "|| "ooff005 = '"||g_ooff_d[l_ac].ooff005 ||"' AND "|| "ooff006 = '"||g_ooff_d[l_ac].ooff006 ||"' AND "|| "ooff007 = '"||g_ooff_d[l_ac].ooff007 ||"' AND "|| "ooff008 = '"||g_ooff_d[l_ac].ooff008 ||"' AND "|| "ooff009 = '"||g_ooff_d[l_ac].ooff009 ||"' AND "|| "ooff010 = '"||g_ooff_d[l_ac].ooff010 ||"' AND "|| "ooff011 = '"||g_ooff_d[l_ac].ooff011 ||"' AND "|| "ooff012 = '"||g_ooff_d[l_ac].ooff012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooff009
            #add-point:ON CHANGE ooff009 name="input.g.page1_aooi360_01.ooff009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooff010
            #add-point:BEFORE FIELD ooff010 name="input.b.page1_aooi360_01.ooff010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooff010
            
            #add-point:AFTER FIELD ooff010 name="input.a.page1_aooi360_01.ooff010"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_ooff_d[l_ac].ooff001 IS NOT NULL AND g_ooff_d[l_ac].ooff002 IS NOT NULL AND g_ooff_d[l_ac].ooff003 IS NOT NULL AND g_ooff_d[l_ac].ooff004 IS NOT NULL AND g_ooff_d[l_ac].ooff005 IS NOT NULL AND g_ooff_d[l_ac].ooff006 IS NOT NULL AND g_ooff_d[l_ac].ooff007 IS NOT NULL AND g_ooff_d[l_ac].ooff008 IS NOT NULL AND g_ooff_d[l_ac].ooff009 IS NOT NULL AND g_ooff_d[l_ac].ooff010 IS NOT NULL AND g_ooff_d[l_ac].ooff011 IS NOT NULL AND g_ooff_d[l_ac].ooff012 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_ooff_d[l_ac].ooff001 != g_ooff_d_t.ooff001 OR g_ooff_d[l_ac].ooff002 != g_ooff_d_t.ooff002 OR g_ooff_d[l_ac].ooff003 != g_ooff_d_t.ooff003 OR g_ooff_d[l_ac].ooff004 != g_ooff_d_t.ooff004 OR g_ooff_d[l_ac].ooff005 != g_ooff_d_t.ooff005 OR g_ooff_d[l_ac].ooff006 != g_ooff_d_t.ooff006 OR g_ooff_d[l_ac].ooff007 != g_ooff_d_t.ooff007 OR g_ooff_d[l_ac].ooff008 != g_ooff_d_t.ooff008 OR g_ooff_d[l_ac].ooff009 != g_ooff_d_t.ooff009 OR g_ooff_d[l_ac].ooff010 != g_ooff_d_t.ooff010 OR g_ooff_d[l_ac].ooff011 != g_ooff_d_t.ooff011 OR g_ooff_d[l_ac].ooff012 != g_ooff_d_t.ooff012)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM ooff_t WHERE "||"ooffent = '" ||g_enterprise|| "' AND "||"ooff001 = '"||g_ooff_d[l_ac].ooff001 ||"' AND "|| "ooff002 = '"||g_ooff_d[l_ac].ooff002 ||"' AND "|| "ooff003 = '"||g_ooff_d[l_ac].ooff003 ||"' AND "|| "ooff004 = '"||g_ooff_d[l_ac].ooff004 ||"' AND "|| "ooff005 = '"||g_ooff_d[l_ac].ooff005 ||"' AND "|| "ooff006 = '"||g_ooff_d[l_ac].ooff006 ||"' AND "|| "ooff007 = '"||g_ooff_d[l_ac].ooff007 ||"' AND "|| "ooff008 = '"||g_ooff_d[l_ac].ooff008 ||"' AND "|| "ooff009 = '"||g_ooff_d[l_ac].ooff009 ||"' AND "|| "ooff010 = '"||g_ooff_d[l_ac].ooff010 ||"' AND "|| "ooff011 = '"||g_ooff_d[l_ac].ooff011 ||"' AND "|| "ooff012 = '"||g_ooff_d[l_ac].ooff012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooff010
            #add-point:ON CHANGE ooff010 name="input.g.page1_aooi360_01.ooff010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooff011
            #add-point:BEFORE FIELD ooff011 name="input.b.page1_aooi360_01.ooff011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooff011
            
            #add-point:AFTER FIELD ooff011 name="input.a.page1_aooi360_01.ooff011"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_ooff_d[l_ac].ooff001 IS NOT NULL AND g_ooff_d[l_ac].ooff002 IS NOT NULL AND g_ooff_d[l_ac].ooff003 IS NOT NULL AND g_ooff_d[l_ac].ooff004 IS NOT NULL AND g_ooff_d[l_ac].ooff005 IS NOT NULL AND g_ooff_d[l_ac].ooff006 IS NOT NULL AND g_ooff_d[l_ac].ooff007 IS NOT NULL AND g_ooff_d[l_ac].ooff008 IS NOT NULL AND g_ooff_d[l_ac].ooff009 IS NOT NULL AND g_ooff_d[l_ac].ooff010 IS NOT NULL AND g_ooff_d[l_ac].ooff011 IS NOT NULL AND g_ooff_d[l_ac].ooff012 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_ooff_d[l_ac].ooff001 != g_ooff_d_t.ooff001 OR g_ooff_d[l_ac].ooff002 != g_ooff_d_t.ooff002 OR g_ooff_d[l_ac].ooff003 != g_ooff_d_t.ooff003 OR g_ooff_d[l_ac].ooff004 != g_ooff_d_t.ooff004 OR g_ooff_d[l_ac].ooff005 != g_ooff_d_t.ooff005 OR g_ooff_d[l_ac].ooff006 != g_ooff_d_t.ooff006 OR g_ooff_d[l_ac].ooff007 != g_ooff_d_t.ooff007 OR g_ooff_d[l_ac].ooff008 != g_ooff_d_t.ooff008 OR g_ooff_d[l_ac].ooff009 != g_ooff_d_t.ooff009 OR g_ooff_d[l_ac].ooff010 != g_ooff_d_t.ooff010 OR g_ooff_d[l_ac].ooff011 != g_ooff_d_t.ooff011 OR g_ooff_d[l_ac].ooff012 != g_ooff_d_t.ooff012)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM ooff_t WHERE "||"ooffent = '" ||g_enterprise|| "' AND "||"ooff001 = '"||g_ooff_d[l_ac].ooff001 ||"' AND "|| "ooff002 = '"||g_ooff_d[l_ac].ooff002 ||"' AND "|| "ooff003 = '"||g_ooff_d[l_ac].ooff003 ||"' AND "|| "ooff004 = '"||g_ooff_d[l_ac].ooff004 ||"' AND "|| "ooff005 = '"||g_ooff_d[l_ac].ooff005 ||"' AND "|| "ooff006 = '"||g_ooff_d[l_ac].ooff006 ||"' AND "|| "ooff007 = '"||g_ooff_d[l_ac].ooff007 ||"' AND "|| "ooff008 = '"||g_ooff_d[l_ac].ooff008 ||"' AND "|| "ooff009 = '"||g_ooff_d[l_ac].ooff009 ||"' AND "|| "ooff010 = '"||g_ooff_d[l_ac].ooff010 ||"' AND "|| "ooff011 = '"||g_ooff_d[l_ac].ooff011 ||"' AND "|| "ooff012 = '"||g_ooff_d[l_ac].ooff012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooff011
            #add-point:ON CHANGE ooff011 name="input.g.page1_aooi360_01.ooff011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooff003
            #add-point:BEFORE FIELD ooff003 name="input.b.page1_aooi360_01.ooff003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooff003
            
            #add-point:AFTER FIELD ooff003 name="input.a.page1_aooi360_01.ooff003"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_ooff_d[l_ac].ooff001 IS NOT NULL AND g_ooff_d[l_ac].ooff002 IS NOT NULL AND g_ooff_d[l_ac].ooff003 IS NOT NULL AND g_ooff_d[l_ac].ooff004 IS NOT NULL AND g_ooff_d[l_ac].ooff005 IS NOT NULL AND g_ooff_d[l_ac].ooff006 IS NOT NULL AND g_ooff_d[l_ac].ooff007 IS NOT NULL AND g_ooff_d[l_ac].ooff008 IS NOT NULL AND g_ooff_d[l_ac].ooff009 IS NOT NULL AND g_ooff_d[l_ac].ooff010 IS NOT NULL AND g_ooff_d[l_ac].ooff011 IS NOT NULL AND g_ooff_d[l_ac].ooff012 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_ooff_d[l_ac].ooff001 != g_ooff_d_t.ooff001 OR g_ooff_d[l_ac].ooff002 != g_ooff_d_t.ooff002 OR g_ooff_d[l_ac].ooff003 != g_ooff_d_t.ooff003 OR g_ooff_d[l_ac].ooff004 != g_ooff_d_t.ooff004 OR g_ooff_d[l_ac].ooff005 != g_ooff_d_t.ooff005 OR g_ooff_d[l_ac].ooff006 != g_ooff_d_t.ooff006 OR g_ooff_d[l_ac].ooff007 != g_ooff_d_t.ooff007 OR g_ooff_d[l_ac].ooff008 != g_ooff_d_t.ooff008 OR g_ooff_d[l_ac].ooff009 != g_ooff_d_t.ooff009 OR g_ooff_d[l_ac].ooff010 != g_ooff_d_t.ooff010 OR g_ooff_d[l_ac].ooff011 != g_ooff_d_t.ooff011 OR g_ooff_d[l_ac].ooff012 != g_ooff_d_t.ooff012)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM ooff_t WHERE "||"ooffent = '" ||g_enterprise|| "' AND "||"ooff001 = '"||g_ooff_d[l_ac].ooff001 ||"' AND "|| "ooff002 = '"||g_ooff_d[l_ac].ooff002 ||"' AND "|| "ooff003 = '"||g_ooff_d[l_ac].ooff003 ||"' AND "|| "ooff004 = '"||g_ooff_d[l_ac].ooff004 ||"' AND "|| "ooff005 = '"||g_ooff_d[l_ac].ooff005 ||"' AND "|| "ooff006 = '"||g_ooff_d[l_ac].ooff006 ||"' AND "|| "ooff007 = '"||g_ooff_d[l_ac].ooff007 ||"' AND "|| "ooff008 = '"||g_ooff_d[l_ac].ooff008 ||"' AND "|| "ooff009 = '"||g_ooff_d[l_ac].ooff009 ||"' AND "|| "ooff010 = '"||g_ooff_d[l_ac].ooff010 ||"' AND "|| "ooff011 = '"||g_ooff_d[l_ac].ooff011 ||"' AND "|| "ooff012 = '"||g_ooff_d[l_ac].ooff012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooff003
            #add-point:ON CHANGE ooff003 name="input.g.page1_aooi360_01.ooff003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooff012
            #add-point:BEFORE FIELD ooff012 name="input.b.page1_aooi360_01.ooff012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooff012
            
            #add-point:AFTER FIELD ooff012 name="input.a.page1_aooi360_01.ooff012"
            #此段落由子樣板a05產生
            #確認資料無重複
            IF  g_ooff_d[l_ac].ooff001 IS NOT NULL AND g_ooff_d[l_ac].ooff002 IS NOT NULL AND g_ooff_d[l_ac].ooff003 IS NOT NULL AND g_ooff_d[l_ac].ooff004 IS NOT NULL AND g_ooff_d[l_ac].ooff005 IS NOT NULL AND g_ooff_d[l_ac].ooff006 IS NOT NULL AND g_ooff_d[l_ac].ooff007 IS NOT NULL AND g_ooff_d[l_ac].ooff008 IS NOT NULL AND g_ooff_d[l_ac].ooff009 IS NOT NULL AND g_ooff_d[l_ac].ooff010 IS NOT NULL AND g_ooff_d[l_ac].ooff011 IS NOT NULL AND g_ooff_d[l_ac].ooff012 IS NOT NULL THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND (g_ooff_d[l_ac].ooff001 != g_ooff_d_t.ooff001 OR g_ooff_d[l_ac].ooff002 != g_ooff_d_t.ooff002 OR g_ooff_d[l_ac].ooff003 != g_ooff_d_t.ooff003 OR g_ooff_d[l_ac].ooff004 != g_ooff_d_t.ooff004 OR g_ooff_d[l_ac].ooff005 != g_ooff_d_t.ooff005 OR g_ooff_d[l_ac].ooff006 != g_ooff_d_t.ooff006 OR g_ooff_d[l_ac].ooff007 != g_ooff_d_t.ooff007 OR g_ooff_d[l_ac].ooff008 != g_ooff_d_t.ooff008 OR g_ooff_d[l_ac].ooff009 != g_ooff_d_t.ooff009 OR g_ooff_d[l_ac].ooff010 != g_ooff_d_t.ooff010 OR g_ooff_d[l_ac].ooff011 != g_ooff_d_t.ooff011 OR g_ooff_d[l_ac].ooff012 != g_ooff_d_t.ooff012)) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM ooff_t WHERE "||"ooffent = '" ||g_enterprise|| "' AND "||"ooff001 = '"||g_ooff_d[l_ac].ooff001 ||"' AND "|| "ooff002 = '"||g_ooff_d[l_ac].ooff002 ||"' AND "|| "ooff003 = '"||g_ooff_d[l_ac].ooff003 ||"' AND "|| "ooff004 = '"||g_ooff_d[l_ac].ooff004 ||"' AND "|| "ooff005 = '"||g_ooff_d[l_ac].ooff005 ||"' AND "|| "ooff006 = '"||g_ooff_d[l_ac].ooff006 ||"' AND "|| "ooff007 = '"||g_ooff_d[l_ac].ooff007 ||"' AND "|| "ooff008 = '"||g_ooff_d[l_ac].ooff008 ||"' AND "|| "ooff009 = '"||g_ooff_d[l_ac].ooff009 ||"' AND "|| "ooff010 = '"||g_ooff_d[l_ac].ooff010 ||"' AND "|| "ooff011 = '"||g_ooff_d[l_ac].ooff011 ||"' AND "|| "ooff012 = '"||g_ooff_d[l_ac].ooff012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF


            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooff012
            #add-point:ON CHANGE ooff012 name="input.g.page1_aooi360_01.ooff012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooff013
            #add-point:BEFORE FIELD ooff013 name="input.b.page1_aooi360_01.ooff013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooff013
            
            #add-point:AFTER FIELD ooff013 name="input.a.page1_aooi360_01.ooff013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooff013
            #add-point:ON CHANGE ooff013 name="input.g.page1_aooi360_01.ooff013"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooff014
            #add-point:BEFORE FIELD ooff014 name="input.b.page1_aooi360_01.ooff014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooff014
            
            #add-point:AFTER FIELD ooff014 name="input.a.page1_aooi360_01.ooff014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooff014
            #add-point:ON CHANGE ooff014 name="input.g.page1_aooi360_01.ooff014"
            
            #END add-point 
 
 
 
                  #Ctrlp:input.c.page1_aooi360_01.ooff001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooff001
            #add-point:ON ACTION controlp INFIELD ooff001 name="input.c.page1_aooi360_01.ooff001"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aooi360_01.ooff002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooff002
            #add-point:ON ACTION controlp INFIELD ooff002 name="input.c.page1_aooi360_01.ooff002"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aooi360_01.ooff004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooff004
            #add-point:ON ACTION controlp INFIELD ooff004 name="input.c.page1_aooi360_01.ooff004"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aooi360_01.ooff005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooff005
            #add-point:ON ACTION controlp INFIELD ooff005 name="input.c.page1_aooi360_01.ooff005"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aooi360_01.ooff006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooff006
            #add-point:ON ACTION controlp INFIELD ooff006 name="input.c.page1_aooi360_01.ooff006"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aooi360_01.ooff007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooff007
            #add-point:ON ACTION controlp INFIELD ooff007 name="input.c.page1_aooi360_01.ooff007"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aooi360_01.ooff008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooff008
            #add-point:ON ACTION controlp INFIELD ooff008 name="input.c.page1_aooi360_01.ooff008"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aooi360_01.ooff009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooff009
            #add-point:ON ACTION controlp INFIELD ooff009 name="input.c.page1_aooi360_01.ooff009"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aooi360_01.ooff010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooff010
            #add-point:ON ACTION controlp INFIELD ooff010 name="input.c.page1_aooi360_01.ooff010"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aooi360_01.ooff011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooff011
            #add-point:ON ACTION controlp INFIELD ooff011 name="input.c.page1_aooi360_01.ooff011"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aooi360_01.ooff003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooff003
            #add-point:ON ACTION controlp INFIELD ooff003 name="input.c.page1_aooi360_01.ooff003"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aooi360_01.ooff012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooff012
            #add-point:ON ACTION controlp INFIELD ooff012 name="input.c.page1_aooi360_01.ooff012"
            
            #END add-point
 
 
         #Ctrlp:input.c.page1_aooi360_01.ooff013
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooff013
            #add-point:ON ACTION controlp INFIELD ooff013 name="input.c.page1_aooi360_01.ooff013"
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            #給予arg
            LET g_qryparam.where = "(oofd013 > '",g_today,"' OR oofd013 IS NULL)"
            #161031-00025#1---s
            IF NOT cl_null(p_ooff001) THEN
               LET g_qryparam.where = g_qryparam.where , " AND oofd001 = '",p_ooff001,"' "
            END IF
            #161031-00025#1---e
            CALL q_oofd012()                                #呼叫開窗
            IF NOT cl_null(g_qryparam.return1) THEN
               IF cl_null(g_ooff_d[l_ac].ooff013 ) THEN
                  LET g_ooff_d[l_ac].ooff013  = g_qryparam.return1
               ELSE
                  LET g_ooff_d[l_ac].ooff013  = g_ooff_d[l_ac].ooff013||'\n'||g_qryparam.return1              #將開窗取得的值回傳到變數
               END IF
            END IF
            DISPLAY g_ooff_d[l_ac].ooff013  TO s_detail1_aooi360_01[l_ac].ooff013           #顯示到畫面上
            LET g_qryparam.where = ""
            
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            #給予arg
            LET g_qryparam.where = "(oofe008 > '",g_today,"' OR oofe008 IS NULL)"
            #161031-00025#1---s
            IF NOT cl_null(p_ooff001) THEN
               LET g_qryparam.where = g_qryparam.where , " AND oofe001 = '",p_ooff001,"' "
            END IF
            #161031-00025#1---e
            CALL q_oofe007()               #呼叫開窗
            IF NOT cl_null(g_qryparam.return1) THEN
               IF cl_null(g_ooff_d[l_ac].ooff013 ) THEN
                  LET g_ooff_d[l_ac].ooff013  = g_qryparam.return1
               ELSE
                  LET g_ooff_d[l_ac].ooff013  = g_ooff_d[l_ac].ooff013||'\n'||g_qryparam.return1              #將開窗取得的值回傳到變數
               END IF
            END IF
            DISPLAY g_ooff_d[l_ac].ooff013   TO s_detail1_aooi360_01[l_ac].ooff013           #顯示到畫面上
            LET g_qryparam.where = ""
            
            CALL aooi360_01_s01(g_ooff_d[l_ac].ooff013) RETURNING g_ooff_d[l_ac].ooff013
            DISPLAY g_ooff_d[l_ac].ooff013 TO s_detail1_aooi360_01[l_ac].ooff013
            NEXT FIELD ooff013
            #END add-point
 
 
         #Ctrlp:input.c.page1_aooi360_01.ooff014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooff014
            #add-point:ON ACTION controlp INFIELD ooff014 name="input.c.page1_aooi360_01.ooff014"
            
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
   CLOSE WINDOW w_aooi360_01 
   
   #add-point:input段after input name="input.post_input"
   CLOSE aooi360_01_cs
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aooi360_01.other_dialog" readonly="Y" >}
################################################################################
# Descriptions...: 被主程式嵌入的單身資料顯示模式
# Memo...........: 
# Usage..........: CALL aooi360_01_display()
# Input parameter: None
# Return code....: None
# Date & Author..: 2014/10/30 By lixiang
# Modify.........:
################################################################################
DIALOG aooi360_01_display()
   DISPLAY ARRAY g_ooff_d TO s_detail1_aooi360_01.* ATTRIBUTE(COUNT=g_d_cnt_i36001)

      BEFORE DISPLAY
         CALL FGL_SET_ARR_CURR(g_d_idx_i36001)
         #單身不連動, 所以進入單身時, 要重新顯示單身筆數
         DISPLAY g_d_idx_i36001, g_d_cnt_i36001 TO FORMONLY.idx, FORMONLY.cnt

      BEFORE ROW
         LET g_d_idx_i36001 = DIALOG.getCurrentRow("s_detail1_aooi360_01")
         DISPLAY g_d_idx_i36001 TO FORMONLY.idx
         # 點的當筆放入g_appoint_idx中, 可讓雙擊直接進入指定筆
         LET g_appoint_idx = g_d_idx_i36001
         
      AFTER DISPLAY
         LET g_ooff_d4.* = g_ooff_d.*
#
   END DISPLAY
END DIALOG
################################################################################
# Descriptions...: 被主程式嵌入的單身查詢模式
# Memo...........: 
# Usage..........: CALL aooi360_01_construct()
# Input parameter: None
# Return code....: None
# Date & Author..: 2014/10/30 By lixiang
# Modify.........:
################################################################################
DIALOG aooi360_01_construct()
   CONSTRUCT g_wc2_i36001 ON ooff001,ooff002,ooff004,ooff005,ooff006,ooff007,ooff008,ooff009,
                             ooff010,ooff011,ooff003,ooff012,ooff013,ooff014
        FROM s_detail1_aooi360_01[1].ooff001,s_detail1_aooi360_01[1].ooff002,
             s_detail1_aooi360_01[1].ooff004,s_detail1_aooi360_01[1].ooff005,
             s_detail1_aooi360_01[1].ooff006,s_detail1_aooi360_01[1].ooff007,
             s_detail1_aooi360_01[1].ooff008,s_detail1_aooi360_01[1].ooff009,
             s_detail1_aooi360_01[1].ooff010,s_detail1_aooi360_01[1].ooff011,
             s_detail1_aooi360_01[1].ooff003,s_detail1_aooi360_01[1].ooff012,
             s_detail1_aooi360_01[1].ooff013,s_detail1_aooi360_01[1].ooff014

          
   END CONSTRUCT
   
END DIALOG

################################################################################
# Descriptions...: 被主程式嵌入的單身輸入模式
# Memo...........: 
# Usage..........: CALL aooi360_01_input()
# Input parameter: None
# Return code....: None
# Date & Author..: 2014/10/30 By lixiang
# Modify.........:
################################################################################
DIALOG aooi360_01_input()
   DEFINE l_ac_t          LIKE type_t.num5        #未取消的ARRAY CNT 
   DEFINE l_allow_insert  LIKE type_t.num5        #可新增否 
   DEFINE l_allow_delete  LIKE type_t.num5        #可刪除否  
   DEFINE l_count         LIKE type_t.num5
   DEFINE l_insert        LIKE type_t.num5
   DEFINE l_cmd           LIKE type_t.chr5
   #DEFINE l_ooff         RECORD LIKE ooff_t.*  #161124-00048#13  2016/12/14 By 08734 mark
   #161124-00048#13  2016/12/14 By 08734 add(S)
   DEFINE l_ooff RECORD  #備註檔
       ooffent LIKE ooff_t.ooffent, #企业编号
       ooffstus LIKE ooff_t.ooffstus, #状态码
       ooff001 LIKE ooff_t.ooff001, #备注类型
       ooff002 LIKE ooff_t.ooff002, #第一KEY值
       ooff003 LIKE ooff_t.ooff003, #第二KEY值
       ooff004 LIKE ooff_t.ooff004, #第三KEY值
       ooff005 LIKE ooff_t.ooff005, #第四KEY值
       ooff006 LIKE ooff_t.ooff006, #第五KEY值
       ooff007 LIKE ooff_t.ooff007, #第六KEY值
       ooff008 LIKE ooff_t.ooff008, #第七KEY值
       ooff009 LIKE ooff_t.ooff009, #第八KEY值
       ooff010 LIKE ooff_t.ooff010, #第九KEY值
       ooff011 LIKE ooff_t.ooff011, #第十KEY值
       ooff012 LIKE ooff_t.ooff012, #控制类型
       ooff013 LIKE ooff_t.ooff013, #备注说明
       ooff014 LIKE ooff_t.ooff014, #失效日期
       ooff015 LIKE ooff_t.ooff015, #内部信息传递
       ooffownid LIKE ooff_t.ooffownid, #资料所有者
       ooffowndp LIKE ooff_t.ooffowndp, #资料所有部门
       ooffcrtid LIKE ooff_t.ooffcrtid, #资料录入者
       ooffcrtdp LIKE ooff_t.ooffcrtdp, #资料录入部门
       ooffcrtdt LIKE ooff_t.ooffcrtdt, #资料创建日
       ooffmodid LIKE ooff_t.ooffmodid, #资料更改者
       ooffmoddt LIKE ooff_t.ooffmoddt #最近更改日
END RECORD
#161124-00048#13  2016/12/14 By 08734 add(E)
   DEFINE l_forupd_sql   STRING
   DEFINE l_lock_sw      LIKE type_t.chr1 
   DEFINE l_success      LIKE type_t.num5
   DEFINE l_wc           STRING
   DEFINE l_n            LIKE type_t.num5

   
   INPUT ARRAY g_ooff_d FROM s_detail1_aooi360_01.*
      ATTRIBUTE(COUNT = g_d_cnt_i36001,MAXCOUNT = g_max_rec,WITHOUT DEFAULTS, 
                INSERT ROW = FALSE,
                DELETE ROW = g_detail_delete,
                APPEND ROW = g_detail_insert)
         
         
         BEFORE INPUT
            #add-point:單身輸入前處理
            
            CALL cl_set_comp_entry("ooff003",FALSE)

            IF cl_null(g_ooff002_d) THEN LET g_ooff002_d=' ' END IF
            IF cl_null(g_ooff003_d) THEN LET g_ooff003_d=' ' END IF
            IF cl_null(g_ooff004_d) THEN LET g_ooff004_d=' ' END IF
            IF cl_null(g_ooff005_d) THEN LET g_ooff005_d=' ' END IF
            IF cl_null(g_ooff006_d) THEN LET g_ooff006_d=' ' END IF
            IF cl_null(g_ooff007_d) THEN LET g_ooff007_d=' ' END IF
            IF cl_null(g_ooff008_d) THEN LET g_ooff008_d=' ' END IF
            IF cl_null(g_ooff009_d) THEN LET g_ooff009_d=' ' END IF
            IF cl_null(g_ooff010_d) THEN LET g_ooff010_d=' ' END IF
            IF cl_null(g_ooff011_d) THEN LET g_ooff011_d=' ' END IF
            LET l_forupd_sql = " SELECT ooff001,ooff002,ooff004,ooff005,ooff006,ooff007,ooff008,ooff009,ooff010,ooff011,ooff003,ooff012,ooff013,ooff014 ",
                      "   FROM ooff_t WHERE ooffent = '",g_enterprise,"' ",
                      "    AND ooff001 = ? AND ooff002 = ? AND ooff003 = ? ",
                      "    AND ooff004 = ? AND ooff005 = ? AND ooff006 = ? ",
                      "    AND ooff007 = ? AND ooff008 = ? AND ooff009 = ? ",
                      "    AND ooff010 = ? AND ooff011 = ? AND ooff012 = ? FOR UPDATE"
            LET l_forupd_sql = cl_sql_forupd(l_forupd_sql)  
            PREPARE aooi360_01_dialog_b FROM l_forupd_sql
            DECLARE aooi360_01_dialog_bcl CURSOR FOR aooi360_01_dialog_b
            IF g_appoint_idx > 0 THEN
               CALL DIALOG.setCurrentRow("s_detail1_aooi360_01",g_appoint_idx)
            END IF
            
         BEFORE ROW
            LET l_cmd = ''
            LET l_ac = ARR_CURR()
            LET l_lock_sw = 'N'            #DEFAULT
            DISPLAY l_ac TO FORMONLY.idx
         
            CALL s_transaction_begin()

            LET g_rec_b = g_ooff_d.getLength()
            #161031-00025#35 add(s)
            CALL cl_set_comp_entry("ooff012",TRUE)
            #161031-00025#35 add(e)
            #IF g_rec_b >= l_ac THEN   #161031-00025#37
            IF g_rec_b >= l_ac AND NOT cl_null(g_ooff_d[l_ac].ooff001) THEN  #161031-00025#37
               LET l_cmd='u'
               LET g_ooff_d_t.* = g_ooff_d[l_ac].*  #BACKUP
               OPEN aooi360_01_dialog_bcl USING g_ooff001_d,g_ooff002_d,g_ooff003_d,g_ooff004_d,g_ooff005_d,g_ooff006_d,g_ooff007_d,g_ooff008_d,g_ooff009_d,g_ooff010_d,g_ooff011_d,g_ooff_d[l_ac].ooff012
                      
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "aooi360_01_dialog_bcl"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

               ELSE                                       
                  FETCH aooi360_01_dialog_bcl INTO g_ooff_d[l_ac].*
                  IF SQLCA.sqlcode THEN
                     LET l_lock_sw = "Y"
                  END IF
                  CALL cl_show_fld_cont()
               END IF
               #161031-00025#35 add(s)
               IF g_prog = "apmt510" OR g_prog = "apmt490" OR g_prog = "apmt410" THEN
                  CALL cl_set_comp_entry("ooff012",FALSE)
               END IF
               #161031-00025#35 add(e)
            ELSE
               LET l_cmd='a'
            END IF

         BEFORE INSERT
            CALL s_transaction_begin()
            LET l_cmd = 'a'
            INITIALIZE g_ooff_d_t.* TO NULL
            INITIALIZE g_ooff_d[l_ac].* TO NULL 
            
            LET g_ooff_d_t.* = g_ooff_d[l_ac].*     #新輸入資料
            CALL cl_show_fld_cont()   
            
         AFTER INSERT
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET INT_FLAG = 0
#               CANCEL INSERT
            END IF
            LET l_ooff.ooffent = g_enterprise
            LET l_ooff.ooff001 = g_ooff001_d
            LET l_ooff.ooff002 = g_ooff002_d
            LET l_ooff.ooff003 = g_ooff003_d
            LET l_ooff.ooff004 = g_ooff004_d
            LET l_ooff.ooff005 = g_ooff005_d
            LET l_ooff.ooff006 = g_ooff006_d
            LET l_ooff.ooff007 = g_ooff007_d
            LET l_ooff.ooff008 = g_ooff008_d
            LET l_ooff.ooff009 = g_ooff009_d
            LET l_ooff.ooff010 = g_ooff010_d
            LET l_ooff.ooff011 = g_ooff011_d
            LET l_ooff.ooff012 = g_ooff_d[l_ac].ooff012
            LET l_ooff.ooff013 = g_ooff_d[l_ac].ooff013
            LET l_ooff.ooff014 = g_ooff_d[l_ac].ooff014
            LET l_ooff.ooffstus = 'Y'
            LET l_ooff.ooffownid = g_user
            LET l_ooff.ooffowndp = g_dept
            LET l_ooff.ooffcrtid = g_user
            LET l_ooff.ooffcrtdp = g_dept 
            LET l_ooff.ooffcrtdt = cl_get_current()
            LET l_ooff.ooffmodid = g_user
            LET l_ooff.ooffmoddt = cl_get_current()
         
           SELECT COUNT(*) INTO l_count FROM ooff_t 
             WHERE ooffent = g_enterprise
               AND ooff001 = g_ooff001_d 
               AND ooff002 = g_ooff002_d
               AND ooff003 = g_ooff003_d
               AND ooff004 = g_ooff004_d
               AND ooff005 = g_ooff005_d
               AND ooff006 = g_ooff006_d
               AND ooff007 = g_ooff007_d
               AND ooff008 = g_ooff008_d
               AND ooff009 = g_ooff009_d
               AND ooff010 = g_ooff010_d
               AND ooff011 = g_ooff011_d
               AND ooff012 = g_ooff_d[l_ac].ooff012
                        
                
            #資料未重複, 插入新增資料
            IF l_count = 0 THEN 
               #INSERT INTO ooff_t VALUES(l_ooff.*)  #161124-00048#13  2016/12/14 By 08734 mark
               INSERT INTO ooff_t(ooffent,ooffstus,ooff001,ooff002,ooff003,ooff004,ooff005,ooff006,ooff007,ooff008,ooff009,
               ooff010,ooff011,ooff012,ooff013,ooff014,ooff015,ooffownid,ooffowndp,ooffcrtid,ooffcrtdp,ooffcrtdt,ooffmodid,ooffmoddt)  #161124-00048#13  2016/12/14 By 08734 add
                  VALUES (l_ooff.ooffent,l_ooff.ooffstus,l_ooff.ooff001,l_ooff.ooff002,l_ooff.ooff003,l_ooff.ooff004,l_ooff.ooff005,l_ooff.ooff006,l_ooff.ooff007,l_ooff.ooff008,l_ooff.ooff009,
               l_ooff.ooff010,l_ooff.ooff011,l_ooff.ooff012,l_ooff.ooff013,l_ooff.ooff014,l_ooff.ooff015,l_ooff.ooffownid,l_ooff.ooffowndp,l_ooff.ooffcrtid,l_ooff.ooffcrtdp,l_ooff.ooffcrtdt,l_ooff.ooffmodid,l_ooff.ooffmoddt)
                    
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "ooff_t"
                  LET g_errparam.popup = FALSE
                  CALL cl_err()

               END IF
            
            ELSE    
               #透过开窗已经新增到ooff中了，此处不应再报错  
               IF l_cmd <> 'u' THEN  #161031-00025#4
                 INITIALIZE g_errparam TO NULL
                 LET g_errparam.code = "std-00006"
                 LET g_errparam.extend = 'INSERT'
                 LET g_errparam.popup = TRUE
                 CALL cl_err()
              
                 INITIALIZE g_ooff_d[l_ac].* TO NULL
                 CALL s_transaction_end('N',0)
#                 CANCEL INSERT
               END IF   #161031-00025#4
            END IF
 
            IF SQLCA.SQLcode  THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = SQLCA.sqlcode
               LET g_errparam.extend = "ooff_t"
               LET g_errparam.popup = TRUE
               CALL cl_err()
  
               CALL s_transaction_end('N',0)                   
#               CANCEL INSERT
            ELSE
              
               CALL s_transaction_end('Y',0)
               
               ERROR 'INSERT O.K'
               LET g_rec_b = g_rec_b + 1
            END IF
 
        BEFORE DELETE                            #是否取消單身
            IF NOT cl_null(g_ooff_d[l_ac].ooff001) AND NOT cl_null(g_ooff_d[l_ac].ooff012)THEN

               IF cl_ask_del_detail() THEN
                  IF l_lock_sw = "Y" THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code =  -263
                     LET g_errparam.extend = ""
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  
#                     CANCEL DELETE
                  END IF
                  DELETE FROM ooff_t
                    WHERE ooffent = g_enterprise 
                      AND ooff001 = g_ooff001_d 
                      AND ooff002 = g_ooff002_d
                      AND ooff003 = g_ooff003_d
                      AND ooff004 = g_ooff004_d
                      AND ooff005 = g_ooff005_d
                      AND ooff006 = g_ooff006_d
                      AND ooff007 = g_ooff007_d
                      AND ooff008 = g_ooff008_d
                      AND ooff009 = g_ooff009_d
                      AND ooff010 = g_ooff010_d
                      AND ooff011 = g_ooff011_d
                      AND ooff012 = g_ooff_d[l_ac].ooff012
                  
                  IF SQLCA.sqlcode THEN
                     INITIALIZE g_errparam TO NULL
                     LET g_errparam.code = SQLCA.sqlcode
                     LET g_errparam.extend = "ooff_t"
                     LET g_errparam.popup = TRUE
                     CALL cl_err()
                  
                     CALL s_transaction_end('N',0)
#                    CANCEL DELETE   
                  ELSE
                     LET g_rec_b = g_rec_b-1
                     
                     CALL s_transaction_end('Y',0)
                  END IF 
                  CLOSE aooi360_01_dialog_bcl
                  LET l_count = g_ooff_d.getLength()
               END IF
            END IF

         AFTER DELETE
            CALL aooi360_01_b_fill(g_ooff001_d,g_ooff002_d,g_ooff003_d,g_ooff004_d,g_ooff005_d,g_ooff006_d,g_ooff007_d,g_ooff008_d,g_ooff009_d,g_ooff010_d,g_ooff011_d)
            
         ON ROW CHANGE
            IF INT_FLAG THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = 9001
               LET g_errparam.extend = ''
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET INT_FLAG = 0
               LET g_ooff_d[l_ac].* = g_ooff_d_t.*
               CLOSE aooi360_01_dialog_bcl
               CALL s_transaction_end('N',0)
               EXIT DIALOG 
            END IF
              
            IF l_lock_sw = 'Y' THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = -263
               LET g_errparam.extend = l_ooff.ooff001
               LET g_errparam.popup = TRUE
               CALL cl_err()

               LET g_ooff_d[l_ac].* = g_ooff_d_t.*
            ELSE
               UPDATE ooff_t SET (ooff013,ooff014)= (g_ooff_d[l_ac].ooff013,g_ooff_d[l_ac].ooff014)
                WHERE ooffent = g_enterprise
                  AND ooff001 = g_ooff001_d 
                  AND ooff002 = g_ooff002_d
                  AND ooff003 = g_ooff_d[l_ac].ooff003
                  AND ooff004 = g_ooff004_d
                  AND ooff005 = g_ooff005_d
                  AND ooff006 = g_ooff006_d
                  AND ooff007 = g_ooff007_d
                  AND ooff008 = g_ooff008_d
                  AND ooff009 = g_ooff009_d
                  AND ooff010 = g_ooff010_d
                  AND ooff011 = g_ooff011_d
                  AND ooff012 = g_ooff_d[l_ac].ooff012
               IF SQLCA.sqlcode THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = SQLCA.sqlcode
                  LET g_errparam.extend = "ooff_t"
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
   
                  LET g_ooff_d[l_ac].* = g_ooff_d_t.*
                  CALL s_transaction_end('N',0) 
               ELSE
                  CALL s_transaction_end('Y',0)                
               END IF

            END IF
            
         AFTER ROW
            CLOSE aooi360_01_dialog_bcl
            
            
         AFTER FIELD ooff001
            IF  NOT cl_null(g_ooff_d[l_ac].ooff001) AND NOT cl_null(g_ooff_d[l_ac].ooff002) AND NOT cl_null(g_ooff_d[l_ac].ooff003) AND NOT cl_null(g_ooff_d[l_ac].ooff004) AND NOT cl_null(g_ooff_d[l_ac].ooff005) AND NOT cl_null(g_ooff_d[l_ac].ooff006) AND NOT cl_null(g_ooff_d[l_ac].ooff007) AND NOT cl_null(g_ooff_d[l_ac].ooff008) AND NOT cl_null(g_ooff_d[l_ac].ooff009) AND NOT cl_null(g_ooff_d[l_ac].ooff010) AND NOT cl_null(g_ooff_d[l_ac].ooff011) AND NOT cl_null(g_ooff_d[l_ac].ooff012) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_ooff_d[l_ac].ooff001 != g_ooff_d_t.ooff001 OR g_ooff_d[l_ac].ooff002 != g_ooff_d_t.ooff002 OR g_ooff_d[l_ac].ooff003 != g_ooff_d_t.ooff003 OR g_ooff_d[l_ac].ooff004 != g_ooff_d_t.ooff004 OR g_ooff_d[l_ac].ooff005 != g_ooff_d_t.ooff005 OR g_ooff_d[l_ac].ooff006 != g_ooff_d_t.ooff006 OR g_ooff_d[l_ac].ooff007 != g_ooff_d_t.ooff007 OR g_ooff_d[l_ac].ooff008 != g_ooff_d_t.ooff008 OR g_ooff_d[l_ac].ooff009 != g_ooff_d_t.ooff009 OR g_ooff_d[l_ac].ooff010 != g_ooff_d_t.ooff010 OR g_ooff_d[l_ac].ooff011 != g_ooff_d_t.ooff011 OR g_ooff_d[l_ac].ooff012 != g_ooff_d_t.ooff012))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM ooff_t WHERE "||"ooffent = '" ||g_enterprise|| "' AND "||"ooff001 = '"||g_ooff_d[l_ac].ooff001 ||"' AND "|| "ooff002 = '"||g_ooff_d[l_ac].ooff002 ||"' AND "|| "ooff003 = '"||g_ooff_d[l_ac].ooff003 ||"' AND "|| "ooff004 = '"||g_ooff_d[l_ac].ooff004 ||"' AND "|| "ooff005 = '"||g_ooff_d[l_ac].ooff005 ||"' AND "|| "ooff006 = '"||g_ooff_d[l_ac].ooff006 ||"' AND "|| "ooff007 = '"||g_ooff_d[l_ac].ooff007 ||"' AND "|| "ooff008 = '"||g_ooff_d[l_ac].ooff008 ||"' AND "|| "ooff009 = '"||g_ooff_d[l_ac].ooff009 ||"' AND "|| "ooff010 = '"||g_ooff_d[l_ac].ooff010 ||"' AND "|| "ooff011 = '"||g_ooff_d[l_ac].ooff011 ||"' AND "|| "ooff012 = '"||g_ooff_d[l_ac].ooff012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

         AFTER FIELD ooff002
            IF  NOT cl_null(g_ooff_d[l_ac].ooff001) AND NOT cl_null(g_ooff_d[l_ac].ooff002) AND NOT cl_null(g_ooff_d[l_ac].ooff003) AND NOT cl_null(g_ooff_d[l_ac].ooff004) AND NOT cl_null(g_ooff_d[l_ac].ooff005) AND NOT cl_null(g_ooff_d[l_ac].ooff006) AND NOT cl_null(g_ooff_d[l_ac].ooff007) AND NOT cl_null(g_ooff_d[l_ac].ooff008) AND NOT cl_null(g_ooff_d[l_ac].ooff009) AND NOT cl_null(g_ooff_d[l_ac].ooff010) AND NOT cl_null(g_ooff_d[l_ac].ooff011) AND NOT cl_null(g_ooff_d[l_ac].ooff012) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_ooff_d[l_ac].ooff001 != g_ooff_d_t.ooff001 OR g_ooff_d[l_ac].ooff002 != g_ooff_d_t.ooff002 OR g_ooff_d[l_ac].ooff003 != g_ooff_d_t.ooff003 OR g_ooff_d[l_ac].ooff004 != g_ooff_d_t.ooff004 OR g_ooff_d[l_ac].ooff005 != g_ooff_d_t.ooff005 OR g_ooff_d[l_ac].ooff006 != g_ooff_d_t.ooff006 OR g_ooff_d[l_ac].ooff007 != g_ooff_d_t.ooff007 OR g_ooff_d[l_ac].ooff008 != g_ooff_d_t.ooff008 OR g_ooff_d[l_ac].ooff009 != g_ooff_d_t.ooff009 OR g_ooff_d[l_ac].ooff010 != g_ooff_d_t.ooff010 OR g_ooff_d[l_ac].ooff011 != g_ooff_d_t.ooff011 OR g_ooff_d[l_ac].ooff012 != g_ooff_d_t.ooff012))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM ooff_t WHERE "||"ooffent = '" ||g_enterprise|| "' AND "||"ooff001 = '"||g_ooff_d[l_ac].ooff001 ||"' AND "|| "ooff002 = '"||g_ooff_d[l_ac].ooff002 ||"' AND "|| "ooff003 = '"||g_ooff_d[l_ac].ooff003 ||"' AND "|| "ooff004 = '"||g_ooff_d[l_ac].ooff004 ||"' AND "|| "ooff005 = '"||g_ooff_d[l_ac].ooff005 ||"' AND "|| "ooff006 = '"||g_ooff_d[l_ac].ooff006 ||"' AND "|| "ooff007 = '"||g_ooff_d[l_ac].ooff007 ||"' AND "|| "ooff008 = '"||g_ooff_d[l_ac].ooff008 ||"' AND "|| "ooff009 = '"||g_ooff_d[l_ac].ooff009 ||"' AND "|| "ooff010 = '"||g_ooff_d[l_ac].ooff010 ||"' AND "|| "ooff011 = '"||g_ooff_d[l_ac].ooff011 ||"' AND "|| "ooff012 = '"||g_ooff_d[l_ac].ooff012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

         AFTER FIELD ooff004
            IF  NOT cl_null(g_ooff_d[l_ac].ooff001) AND NOT cl_null(g_ooff_d[l_ac].ooff002) AND NOT cl_null(g_ooff_d[l_ac].ooff003) AND NOT cl_null(g_ooff_d[l_ac].ooff004) AND NOT cl_null(g_ooff_d[l_ac].ooff005) AND NOT cl_null(g_ooff_d[l_ac].ooff006) AND NOT cl_null(g_ooff_d[l_ac].ooff007) AND NOT cl_null(g_ooff_d[l_ac].ooff008) AND NOT cl_null(g_ooff_d[l_ac].ooff009) AND NOT cl_null(g_ooff_d[l_ac].ooff010) AND NOT cl_null(g_ooff_d[l_ac].ooff011) AND NOT cl_null(g_ooff_d[l_ac].ooff012) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_ooff_d[l_ac].ooff001 != g_ooff_d_t.ooff001 OR g_ooff_d[l_ac].ooff002 != g_ooff_d_t.ooff002 OR g_ooff_d[l_ac].ooff003 != g_ooff_d_t.ooff003 OR g_ooff_d[l_ac].ooff004 != g_ooff_d_t.ooff004 OR g_ooff_d[l_ac].ooff005 != g_ooff_d_t.ooff005 OR g_ooff_d[l_ac].ooff006 != g_ooff_d_t.ooff006 OR g_ooff_d[l_ac].ooff007 != g_ooff_d_t.ooff007 OR g_ooff_d[l_ac].ooff008 != g_ooff_d_t.ooff008 OR g_ooff_d[l_ac].ooff009 != g_ooff_d_t.ooff009 OR g_ooff_d[l_ac].ooff010 != g_ooff_d_t.ooff010 OR g_ooff_d[l_ac].ooff011 != g_ooff_d_t.ooff011 OR g_ooff_d[l_ac].ooff012 != g_ooff_d_t.ooff012))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM ooff_t WHERE "||"ooffent = '" ||g_enterprise|| "' AND "||"ooff001 = '"||g_ooff_d[l_ac].ooff001 ||"' AND "|| "ooff002 = '"||g_ooff_d[l_ac].ooff002 ||"' AND "|| "ooff003 = '"||g_ooff_d[l_ac].ooff003 ||"' AND "|| "ooff004 = '"||g_ooff_d[l_ac].ooff004 ||"' AND "|| "ooff005 = '"||g_ooff_d[l_ac].ooff005 ||"' AND "|| "ooff006 = '"||g_ooff_d[l_ac].ooff006 ||"' AND "|| "ooff007 = '"||g_ooff_d[l_ac].ooff007 ||"' AND "|| "ooff008 = '"||g_ooff_d[l_ac].ooff008 ||"' AND "|| "ooff009 = '"||g_ooff_d[l_ac].ooff009 ||"' AND "|| "ooff010 = '"||g_ooff_d[l_ac].ooff010 ||"' AND "|| "ooff011 = '"||g_ooff_d[l_ac].ooff011 ||"' AND "|| "ooff012 = '"||g_ooff_d[l_ac].ooff012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

         AFTER FIELD ooff005
            IF  NOT cl_null(g_ooff_d[l_ac].ooff001) AND NOT cl_null(g_ooff_d[l_ac].ooff002) AND NOT cl_null(g_ooff_d[l_ac].ooff003) AND NOT cl_null(g_ooff_d[l_ac].ooff004) AND NOT cl_null(g_ooff_d[l_ac].ooff005) AND NOT cl_null(g_ooff_d[l_ac].ooff006) AND NOT cl_null(g_ooff_d[l_ac].ooff007) AND NOT cl_null(g_ooff_d[l_ac].ooff008) AND NOT cl_null(g_ooff_d[l_ac].ooff009) AND NOT cl_null(g_ooff_d[l_ac].ooff010) AND NOT cl_null(g_ooff_d[l_ac].ooff011) AND NOT cl_null(g_ooff_d[l_ac].ooff012) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_ooff_d[l_ac].ooff001 != g_ooff_d_t.ooff001 OR g_ooff_d[l_ac].ooff002 != g_ooff_d_t.ooff002 OR g_ooff_d[l_ac].ooff003 != g_ooff_d_t.ooff003 OR g_ooff_d[l_ac].ooff004 != g_ooff_d_t.ooff004 OR g_ooff_d[l_ac].ooff005 != g_ooff_d_t.ooff005 OR g_ooff_d[l_ac].ooff006 != g_ooff_d_t.ooff006 OR g_ooff_d[l_ac].ooff007 != g_ooff_d_t.ooff007 OR g_ooff_d[l_ac].ooff008 != g_ooff_d_t.ooff008 OR g_ooff_d[l_ac].ooff009 != g_ooff_d_t.ooff009 OR g_ooff_d[l_ac].ooff010 != g_ooff_d_t.ooff010 OR g_ooff_d[l_ac].ooff011 != g_ooff_d_t.ooff011 OR g_ooff_d[l_ac].ooff012 != g_ooff_d_t.ooff012))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM ooff_t WHERE "||"ooffent = '" ||g_enterprise|| "' AND "||"ooff001 = '"||g_ooff_d[l_ac].ooff001 ||"' AND "|| "ooff002 = '"||g_ooff_d[l_ac].ooff002 ||"' AND "|| "ooff003 = '"||g_ooff_d[l_ac].ooff003 ||"' AND "|| "ooff004 = '"||g_ooff_d[l_ac].ooff004 ||"' AND "|| "ooff005 = '"||g_ooff_d[l_ac].ooff005 ||"' AND "|| "ooff006 = '"||g_ooff_d[l_ac].ooff006 ||"' AND "|| "ooff007 = '"||g_ooff_d[l_ac].ooff007 ||"' AND "|| "ooff008 = '"||g_ooff_d[l_ac].ooff008 ||"' AND "|| "ooff009 = '"||g_ooff_d[l_ac].ooff009 ||"' AND "|| "ooff010 = '"||g_ooff_d[l_ac].ooff010 ||"' AND "|| "ooff011 = '"||g_ooff_d[l_ac].ooff011 ||"' AND "|| "ooff012 = '"||g_ooff_d[l_ac].ooff012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

         AFTER FIELD ooff006
            IF  NOT cl_null(g_ooff_d[l_ac].ooff001) AND NOT cl_null(g_ooff_d[l_ac].ooff002) AND NOT cl_null(g_ooff_d[l_ac].ooff003) AND NOT cl_null(g_ooff_d[l_ac].ooff004) AND NOT cl_null(g_ooff_d[l_ac].ooff005) AND NOT cl_null(g_ooff_d[l_ac].ooff006) AND NOT cl_null(g_ooff_d[l_ac].ooff007) AND NOT cl_null(g_ooff_d[l_ac].ooff008) AND NOT cl_null(g_ooff_d[l_ac].ooff009) AND NOT cl_null(g_ooff_d[l_ac].ooff010) AND NOT cl_null(g_ooff_d[l_ac].ooff011) AND NOT cl_null(g_ooff_d[l_ac].ooff012) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_ooff_d[l_ac].ooff001 != g_ooff_d_t.ooff001 OR g_ooff_d[l_ac].ooff002 != g_ooff_d_t.ooff002 OR g_ooff_d[l_ac].ooff003 != g_ooff_d_t.ooff003 OR g_ooff_d[l_ac].ooff004 != g_ooff_d_t.ooff004 OR g_ooff_d[l_ac].ooff005 != g_ooff_d_t.ooff005 OR g_ooff_d[l_ac].ooff006 != g_ooff_d_t.ooff006 OR g_ooff_d[l_ac].ooff007 != g_ooff_d_t.ooff007 OR g_ooff_d[l_ac].ooff008 != g_ooff_d_t.ooff008 OR g_ooff_d[l_ac].ooff009 != g_ooff_d_t.ooff009 OR g_ooff_d[l_ac].ooff010 != g_ooff_d_t.ooff010 OR g_ooff_d[l_ac].ooff011 != g_ooff_d_t.ooff011 OR g_ooff_d[l_ac].ooff012 != g_ooff_d_t.ooff012))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM ooff_t WHERE "||"ooffent = '" ||g_enterprise|| "' AND "||"ooff001 = '"||g_ooff_d[l_ac].ooff001 ||"' AND "|| "ooff002 = '"||g_ooff_d[l_ac].ooff002 ||"' AND "|| "ooff003 = '"||g_ooff_d[l_ac].ooff003 ||"' AND "|| "ooff004 = '"||g_ooff_d[l_ac].ooff004 ||"' AND "|| "ooff005 = '"||g_ooff_d[l_ac].ooff005 ||"' AND "|| "ooff006 = '"||g_ooff_d[l_ac].ooff006 ||"' AND "|| "ooff007 = '"||g_ooff_d[l_ac].ooff007 ||"' AND "|| "ooff008 = '"||g_ooff_d[l_ac].ooff008 ||"' AND "|| "ooff009 = '"||g_ooff_d[l_ac].ooff009 ||"' AND "|| "ooff010 = '"||g_ooff_d[l_ac].ooff010 ||"' AND "|| "ooff011 = '"||g_ooff_d[l_ac].ooff011 ||"' AND "|| "ooff012 = '"||g_ooff_d[l_ac].ooff012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

         AFTER FIELD ooff007
            IF  NOT cl_null(g_ooff_d[l_ac].ooff001) AND NOT cl_null(g_ooff_d[l_ac].ooff002) AND NOT cl_null(g_ooff_d[l_ac].ooff003) AND NOT cl_null(g_ooff_d[l_ac].ooff004) AND NOT cl_null(g_ooff_d[l_ac].ooff005) AND NOT cl_null(g_ooff_d[l_ac].ooff006) AND NOT cl_null(g_ooff_d[l_ac].ooff007) AND NOT cl_null(g_ooff_d[l_ac].ooff008) AND NOT cl_null(g_ooff_d[l_ac].ooff009) AND NOT cl_null(g_ooff_d[l_ac].ooff010) AND NOT cl_null(g_ooff_d[l_ac].ooff011) AND NOT cl_null(g_ooff_d[l_ac].ooff012) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_ooff_d[l_ac].ooff001 != g_ooff_d_t.ooff001 OR g_ooff_d[l_ac].ooff002 != g_ooff_d_t.ooff002 OR g_ooff_d[l_ac].ooff003 != g_ooff_d_t.ooff003 OR g_ooff_d[l_ac].ooff004 != g_ooff_d_t.ooff004 OR g_ooff_d[l_ac].ooff005 != g_ooff_d_t.ooff005 OR g_ooff_d[l_ac].ooff006 != g_ooff_d_t.ooff006 OR g_ooff_d[l_ac].ooff007 != g_ooff_d_t.ooff007 OR g_ooff_d[l_ac].ooff008 != g_ooff_d_t.ooff008 OR g_ooff_d[l_ac].ooff009 != g_ooff_d_t.ooff009 OR g_ooff_d[l_ac].ooff010 != g_ooff_d_t.ooff010 OR g_ooff_d[l_ac].ooff011 != g_ooff_d_t.ooff011 OR g_ooff_d[l_ac].ooff012 != g_ooff_d_t.ooff012))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM ooff_t WHERE "||"ooffent = '" ||g_enterprise|| "' AND "||"ooff001 = '"||g_ooff_d[l_ac].ooff001 ||"' AND "|| "ooff002 = '"||g_ooff_d[l_ac].ooff002 ||"' AND "|| "ooff003 = '"||g_ooff_d[l_ac].ooff003 ||"' AND "|| "ooff004 = '"||g_ooff_d[l_ac].ooff004 ||"' AND "|| "ooff005 = '"||g_ooff_d[l_ac].ooff005 ||"' AND "|| "ooff006 = '"||g_ooff_d[l_ac].ooff006 ||"' AND "|| "ooff007 = '"||g_ooff_d[l_ac].ooff007 ||"' AND "|| "ooff008 = '"||g_ooff_d[l_ac].ooff008 ||"' AND "|| "ooff009 = '"||g_ooff_d[l_ac].ooff009 ||"' AND "|| "ooff010 = '"||g_ooff_d[l_ac].ooff010 ||"' AND "|| "ooff011 = '"||g_ooff_d[l_ac].ooff011 ||"' AND "|| "ooff012 = '"||g_ooff_d[l_ac].ooff012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

         AFTER FIELD ooff008
            IF  NOT cl_null(g_ooff_d[l_ac].ooff001) AND NOT cl_null(g_ooff_d[l_ac].ooff002) AND NOT cl_null(g_ooff_d[l_ac].ooff003) AND NOT cl_null(g_ooff_d[l_ac].ooff004) AND NOT cl_null(g_ooff_d[l_ac].ooff005) AND NOT cl_null(g_ooff_d[l_ac].ooff006) AND NOT cl_null(g_ooff_d[l_ac].ooff007) AND NOT cl_null(g_ooff_d[l_ac].ooff008) AND NOT cl_null(g_ooff_d[l_ac].ooff009) AND NOT cl_null(g_ooff_d[l_ac].ooff010) AND NOT cl_null(g_ooff_d[l_ac].ooff011) AND NOT cl_null(g_ooff_d[l_ac].ooff012) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_ooff_d[l_ac].ooff001 != g_ooff_d_t.ooff001 OR g_ooff_d[l_ac].ooff002 != g_ooff_d_t.ooff002 OR g_ooff_d[l_ac].ooff003 != g_ooff_d_t.ooff003 OR g_ooff_d[l_ac].ooff004 != g_ooff_d_t.ooff004 OR g_ooff_d[l_ac].ooff005 != g_ooff_d_t.ooff005 OR g_ooff_d[l_ac].ooff006 != g_ooff_d_t.ooff006 OR g_ooff_d[l_ac].ooff007 != g_ooff_d_t.ooff007 OR g_ooff_d[l_ac].ooff008 != g_ooff_d_t.ooff008 OR g_ooff_d[l_ac].ooff009 != g_ooff_d_t.ooff009 OR g_ooff_d[l_ac].ooff010 != g_ooff_d_t.ooff010 OR g_ooff_d[l_ac].ooff011 != g_ooff_d_t.ooff011 OR g_ooff_d[l_ac].ooff012 != g_ooff_d_t.ooff012))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM ooff_t WHERE "||"ooffent = '" ||g_enterprise|| "' AND "||"ooff001 = '"||g_ooff_d[l_ac].ooff001 ||"' AND "|| "ooff002 = '"||g_ooff_d[l_ac].ooff002 ||"' AND "|| "ooff003 = '"||g_ooff_d[l_ac].ooff003 ||"' AND "|| "ooff004 = '"||g_ooff_d[l_ac].ooff004 ||"' AND "|| "ooff005 = '"||g_ooff_d[l_ac].ooff005 ||"' AND "|| "ooff006 = '"||g_ooff_d[l_ac].ooff006 ||"' AND "|| "ooff007 = '"||g_ooff_d[l_ac].ooff007 ||"' AND "|| "ooff008 = '"||g_ooff_d[l_ac].ooff008 ||"' AND "|| "ooff009 = '"||g_ooff_d[l_ac].ooff009 ||"' AND "|| "ooff010 = '"||g_ooff_d[l_ac].ooff010 ||"' AND "|| "ooff011 = '"||g_ooff_d[l_ac].ooff011 ||"' AND "|| "ooff012 = '"||g_ooff_d[l_ac].ooff012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

         AFTER FIELD ooff009
            IF  NOT cl_null(g_ooff_d[l_ac].ooff001) AND NOT cl_null(g_ooff_d[l_ac].ooff002) AND NOT cl_null(g_ooff_d[l_ac].ooff003) AND NOT cl_null(g_ooff_d[l_ac].ooff004) AND NOT cl_null(g_ooff_d[l_ac].ooff005) AND NOT cl_null(g_ooff_d[l_ac].ooff006) AND NOT cl_null(g_ooff_d[l_ac].ooff007) AND NOT cl_null(g_ooff_d[l_ac].ooff008) AND NOT cl_null(g_ooff_d[l_ac].ooff009) AND NOT cl_null(g_ooff_d[l_ac].ooff010) AND NOT cl_null(g_ooff_d[l_ac].ooff011) AND NOT cl_null(g_ooff_d[l_ac].ooff012) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_ooff_d[l_ac].ooff001 != g_ooff_d_t.ooff001 OR g_ooff_d[l_ac].ooff002 != g_ooff_d_t.ooff002 OR g_ooff_d[l_ac].ooff003 != g_ooff_d_t.ooff003 OR g_ooff_d[l_ac].ooff004 != g_ooff_d_t.ooff004 OR g_ooff_d[l_ac].ooff005 != g_ooff_d_t.ooff005 OR g_ooff_d[l_ac].ooff006 != g_ooff_d_t.ooff006 OR g_ooff_d[l_ac].ooff007 != g_ooff_d_t.ooff007 OR g_ooff_d[l_ac].ooff008 != g_ooff_d_t.ooff008 OR g_ooff_d[l_ac].ooff009 != g_ooff_d_t.ooff009 OR g_ooff_d[l_ac].ooff010 != g_ooff_d_t.ooff010 OR g_ooff_d[l_ac].ooff011 != g_ooff_d_t.ooff011 OR g_ooff_d[l_ac].ooff012 != g_ooff_d_t.ooff012))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM ooff_t WHERE "||"ooffent = '" ||g_enterprise|| "' AND "||"ooff001 = '"||g_ooff_d[l_ac].ooff001 ||"' AND "|| "ooff002 = '"||g_ooff_d[l_ac].ooff002 ||"' AND "|| "ooff003 = '"||g_ooff_d[l_ac].ooff003 ||"' AND "|| "ooff004 = '"||g_ooff_d[l_ac].ooff004 ||"' AND "|| "ooff005 = '"||g_ooff_d[l_ac].ooff005 ||"' AND "|| "ooff006 = '"||g_ooff_d[l_ac].ooff006 ||"' AND "|| "ooff007 = '"||g_ooff_d[l_ac].ooff007 ||"' AND "|| "ooff008 = '"||g_ooff_d[l_ac].ooff008 ||"' AND "|| "ooff009 = '"||g_ooff_d[l_ac].ooff009 ||"' AND "|| "ooff010 = '"||g_ooff_d[l_ac].ooff010 ||"' AND "|| "ooff011 = '"||g_ooff_d[l_ac].ooff011 ||"' AND "|| "ooff012 = '"||g_ooff_d[l_ac].ooff012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

         AFTER FIELD ooff010
            IF  NOT cl_null(g_ooff_d[l_ac].ooff001) AND NOT cl_null(g_ooff_d[l_ac].ooff002) AND NOT cl_null(g_ooff_d[l_ac].ooff003) AND NOT cl_null(g_ooff_d[l_ac].ooff004) AND NOT cl_null(g_ooff_d[l_ac].ooff005) AND NOT cl_null(g_ooff_d[l_ac].ooff006) AND NOT cl_null(g_ooff_d[l_ac].ooff007) AND NOT cl_null(g_ooff_d[l_ac].ooff008) AND NOT cl_null(g_ooff_d[l_ac].ooff009) AND NOT cl_null(g_ooff_d[l_ac].ooff010) AND NOT cl_null(g_ooff_d[l_ac].ooff011) AND NOT cl_null(g_ooff_d[l_ac].ooff012) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_ooff_d[l_ac].ooff001 != g_ooff_d_t.ooff001 OR g_ooff_d[l_ac].ooff002 != g_ooff_d_t.ooff002 OR g_ooff_d[l_ac].ooff003 != g_ooff_d_t.ooff003 OR g_ooff_d[l_ac].ooff004 != g_ooff_d_t.ooff004 OR g_ooff_d[l_ac].ooff005 != g_ooff_d_t.ooff005 OR g_ooff_d[l_ac].ooff006 != g_ooff_d_t.ooff006 OR g_ooff_d[l_ac].ooff007 != g_ooff_d_t.ooff007 OR g_ooff_d[l_ac].ooff008 != g_ooff_d_t.ooff008 OR g_ooff_d[l_ac].ooff009 != g_ooff_d_t.ooff009 OR g_ooff_d[l_ac].ooff010 != g_ooff_d_t.ooff010 OR g_ooff_d[l_ac].ooff011 != g_ooff_d_t.ooff011 OR g_ooff_d[l_ac].ooff012 != g_ooff_d_t.ooff012))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM ooff_t WHERE "||"ooffent = '" ||g_enterprise|| "' AND "||"ooff001 = '"||g_ooff_d[l_ac].ooff001 ||"' AND "|| "ooff002 = '"||g_ooff_d[l_ac].ooff002 ||"' AND "|| "ooff003 = '"||g_ooff_d[l_ac].ooff003 ||"' AND "|| "ooff004 = '"||g_ooff_d[l_ac].ooff004 ||"' AND "|| "ooff005 = '"||g_ooff_d[l_ac].ooff005 ||"' AND "|| "ooff006 = '"||g_ooff_d[l_ac].ooff006 ||"' AND "|| "ooff007 = '"||g_ooff_d[l_ac].ooff007 ||"' AND "|| "ooff008 = '"||g_ooff_d[l_ac].ooff008 ||"' AND "|| "ooff009 = '"||g_ooff_d[l_ac].ooff009 ||"' AND "|| "ooff010 = '"||g_ooff_d[l_ac].ooff010 ||"' AND "|| "ooff011 = '"||g_ooff_d[l_ac].ooff011 ||"' AND "|| "ooff012 = '"||g_ooff_d[l_ac].ooff012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

         AFTER FIELD ooff011
            IF  NOT cl_null(g_ooff_d[l_ac].ooff001) AND NOT cl_null(g_ooff_d[l_ac].ooff002) AND NOT cl_null(g_ooff_d[l_ac].ooff003) AND NOT cl_null(g_ooff_d[l_ac].ooff004) AND NOT cl_null(g_ooff_d[l_ac].ooff005) AND NOT cl_null(g_ooff_d[l_ac].ooff006) AND NOT cl_null(g_ooff_d[l_ac].ooff007) AND NOT cl_null(g_ooff_d[l_ac].ooff008) AND NOT cl_null(g_ooff_d[l_ac].ooff009) AND NOT cl_null(g_ooff_d[l_ac].ooff010) AND NOT cl_null(g_ooff_d[l_ac].ooff011) AND NOT cl_null(g_ooff_d[l_ac].ooff012) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_ooff_d[l_ac].ooff001 != g_ooff_d_t.ooff001 OR g_ooff_d[l_ac].ooff002 != g_ooff_d_t.ooff002 OR g_ooff_d[l_ac].ooff003 != g_ooff_d_t.ooff003 OR g_ooff_d[l_ac].ooff004 != g_ooff_d_t.ooff004 OR g_ooff_d[l_ac].ooff005 != g_ooff_d_t.ooff005 OR g_ooff_d[l_ac].ooff006 != g_ooff_d_t.ooff006 OR g_ooff_d[l_ac].ooff007 != g_ooff_d_t.ooff007 OR g_ooff_d[l_ac].ooff008 != g_ooff_d_t.ooff008 OR g_ooff_d[l_ac].ooff009 != g_ooff_d_t.ooff009 OR g_ooff_d[l_ac].ooff010 != g_ooff_d_t.ooff010 OR g_ooff_d[l_ac].ooff011 != g_ooff_d_t.ooff011 OR g_ooff_d[l_ac].ooff012 != g_ooff_d_t.ooff012))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM ooff_t WHERE "||"ooffent = '" ||g_enterprise|| "' AND "||"ooff001 = '"||g_ooff_d[l_ac].ooff001 ||"' AND "|| "ooff002 = '"||g_ooff_d[l_ac].ooff002 ||"' AND "|| "ooff003 = '"||g_ooff_d[l_ac].ooff003 ||"' AND "|| "ooff004 = '"||g_ooff_d[l_ac].ooff004 ||"' AND "|| "ooff005 = '"||g_ooff_d[l_ac].ooff005 ||"' AND "|| "ooff006 = '"||g_ooff_d[l_ac].ooff006 ||"' AND "|| "ooff007 = '"||g_ooff_d[l_ac].ooff007 ||"' AND "|| "ooff008 = '"||g_ooff_d[l_ac].ooff008 ||"' AND "|| "ooff009 = '"||g_ooff_d[l_ac].ooff009 ||"' AND "|| "ooff010 = '"||g_ooff_d[l_ac].ooff010 ||"' AND "|| "ooff011 = '"||g_ooff_d[l_ac].ooff011 ||"' AND "|| "ooff012 = '"||g_ooff_d[l_ac].ooff012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

         AFTER FIELD ooff003
            IF  NOT cl_null(g_ooff_d[l_ac].ooff001) AND NOT cl_null(g_ooff_d[l_ac].ooff002) AND NOT cl_null(g_ooff_d[l_ac].ooff003) AND NOT cl_null(g_ooff_d[l_ac].ooff004) AND NOT cl_null(g_ooff_d[l_ac].ooff005) AND NOT cl_null(g_ooff_d[l_ac].ooff006) AND NOT cl_null(g_ooff_d[l_ac].ooff007) AND NOT cl_null(g_ooff_d[l_ac].ooff008) AND NOT cl_null(g_ooff_d[l_ac].ooff009) AND NOT cl_null(g_ooff_d[l_ac].ooff010) AND NOT cl_null(g_ooff_d[l_ac].ooff011) AND NOT cl_null(g_ooff_d[l_ac].ooff012) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_ooff_d[l_ac].ooff001 != g_ooff_d_t.ooff001 OR g_ooff_d[l_ac].ooff002 != g_ooff_d_t.ooff002 OR g_ooff_d[l_ac].ooff003 != g_ooff_d_t.ooff003 OR g_ooff_d[l_ac].ooff004 != g_ooff_d_t.ooff004 OR g_ooff_d[l_ac].ooff005 != g_ooff_d_t.ooff005 OR g_ooff_d[l_ac].ooff006 != g_ooff_d_t.ooff006 OR g_ooff_d[l_ac].ooff007 != g_ooff_d_t.ooff007 OR g_ooff_d[l_ac].ooff008 != g_ooff_d_t.ooff008 OR g_ooff_d[l_ac].ooff009 != g_ooff_d_t.ooff009 OR g_ooff_d[l_ac].ooff010 != g_ooff_d_t.ooff010 OR g_ooff_d[l_ac].ooff011 != g_ooff_d_t.ooff011 OR g_ooff_d[l_ac].ooff012 != g_ooff_d_t.ooff012))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM ooff_t WHERE "||"ooffent = '" ||g_enterprise|| "' AND "||"ooff001 = '"||g_ooff_d[l_ac].ooff001 ||"' AND "|| "ooff002 = '"||g_ooff_d[l_ac].ooff002 ||"' AND "|| "ooff003 = '"||g_ooff_d[l_ac].ooff003 ||"' AND "|| "ooff004 = '"||g_ooff_d[l_ac].ooff004 ||"' AND "|| "ooff005 = '"||g_ooff_d[l_ac].ooff005 ||"' AND "|| "ooff006 = '"||g_ooff_d[l_ac].ooff006 ||"' AND "|| "ooff007 = '"||g_ooff_d[l_ac].ooff007 ||"' AND "|| "ooff008 = '"||g_ooff_d[l_ac].ooff008 ||"' AND "|| "ooff009 = '"||g_ooff_d[l_ac].ooff009 ||"' AND "|| "ooff010 = '"||g_ooff_d[l_ac].ooff010 ||"' AND "|| "ooff011 = '"||g_ooff_d[l_ac].ooff011 ||"' AND "|| "ooff012 = '"||g_ooff_d[l_ac].ooff012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

         AFTER FIELD ooff012
            IF  NOT cl_null(g_ooff_d[l_ac].ooff001) AND NOT cl_null(g_ooff_d[l_ac].ooff002) AND NOT cl_null(g_ooff_d[l_ac].ooff003) AND NOT cl_null(g_ooff_d[l_ac].ooff004) AND NOT cl_null(g_ooff_d[l_ac].ooff005) AND NOT cl_null(g_ooff_d[l_ac].ooff006) AND NOT cl_null(g_ooff_d[l_ac].ooff007) AND NOT cl_null(g_ooff_d[l_ac].ooff008) AND NOT cl_null(g_ooff_d[l_ac].ooff009) AND NOT cl_null(g_ooff_d[l_ac].ooff010) AND NOT cl_null(g_ooff_d[l_ac].ooff011) AND NOT cl_null(g_ooff_d[l_ac].ooff012) THEN 
               IF l_cmd = 'a' OR ( l_cmd = 'u' AND ( l_cmd = 'u' AND (g_ooff_d[l_ac].ooff001 != g_ooff_d_t.ooff001 OR g_ooff_d[l_ac].ooff002 != g_ooff_d_t.ooff002 OR g_ooff_d[l_ac].ooff003 != g_ooff_d_t.ooff003 OR g_ooff_d[l_ac].ooff004 != g_ooff_d_t.ooff004 OR g_ooff_d[l_ac].ooff005 != g_ooff_d_t.ooff005 OR g_ooff_d[l_ac].ooff006 != g_ooff_d_t.ooff006 OR g_ooff_d[l_ac].ooff007 != g_ooff_d_t.ooff007 OR g_ooff_d[l_ac].ooff008 != g_ooff_d_t.ooff008 OR g_ooff_d[l_ac].ooff009 != g_ooff_d_t.ooff009 OR g_ooff_d[l_ac].ooff010 != g_ooff_d_t.ooff010 OR g_ooff_d[l_ac].ooff011 != g_ooff_d_t.ooff011 OR g_ooff_d[l_ac].ooff012 != g_ooff_d_t.ooff012))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM ooff_t WHERE "||"ooffent = '" ||g_enterprise|| "' AND "||"ooff001 = '"||g_ooff_d[l_ac].ooff001 ||"' AND "|| "ooff002 = '"||g_ooff_d[l_ac].ooff002 ||"' AND "|| "ooff003 = '"||g_ooff_d[l_ac].ooff003 ||"' AND "|| "ooff004 = '"||g_ooff_d[l_ac].ooff004 ||"' AND "|| "ooff005 = '"||g_ooff_d[l_ac].ooff005 ||"' AND "|| "ooff006 = '"||g_ooff_d[l_ac].ooff006 ||"' AND "|| "ooff007 = '"||g_ooff_d[l_ac].ooff007 ||"' AND "|| "ooff008 = '"||g_ooff_d[l_ac].ooff008 ||"' AND "|| "ooff009 = '"||g_ooff_d[l_ac].ooff009 ||"' AND "|| "ooff010 = '"||g_ooff_d[l_ac].ooff010 ||"' AND "|| "ooff011 = '"||g_ooff_d[l_ac].ooff011 ||"' AND "|| "ooff012 = '"||g_ooff_d[l_ac].ooff012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF

         ON ACTION controlp INFIELD ooff013
            #add-point:ON ACTION controlp INFIELD ooff013
            #161031-00025#4---s
            #先不开窗，直接让user输入，目前开窗输入方式比较怪，等SA确定之后，再调整，暂时先将开窗功能关掉
            #INITIALIZE g_qryparam.* TO NULL
            #LET g_qryparam.state = 'i'
            #LET g_qryparam.reqry = FALSE
            ##給予arg
            #LET g_qryparam.where = "(oofd013 > '",g_today,"' OR oofd013 IS NULL)"
            #CALL q_oofd012()                                #呼叫開窗
            #IF NOT cl_null(g_qryparam.return1) THEN
            #   IF cl_null(g_ooff_d[l_ac].ooff013 ) THEN
            #      LET g_ooff_d[l_ac].ooff013  = g_qryparam.return1
            #   ELSE
            #      LET g_ooff_d[l_ac].ooff013  = g_ooff_d[l_ac].ooff013||'\n'||g_qryparam.return1              #將開窗取得的值回傳到變數
            #   END IF
            #END IF
            #DISPLAY g_ooff_d[l_ac].ooff013  TO s_detail1_aooi360_01[l_ac].ooff013           #顯示到畫面上
            #LET g_qryparam.where = ""
            #
            #INITIALIZE g_qryparam.* TO NULL
            #LET g_qryparam.state = 'i'
            #LET g_qryparam.reqry = FALSE
            ##給予arg
            #LET g_qryparam.where = "(oofe008 > '",g_today,"' OR oofe008 IS NULL)"
            #CALL q_oofe007()               #呼叫開窗
            #IF NOT cl_null(g_qryparam.return1) THEN
            #   IF cl_null(g_ooff_d[l_ac].ooff013 ) THEN
            #      LET g_ooff_d[l_ac].ooff013  = g_qryparam.return1
            #   ELSE
            #      LET g_ooff_d[l_ac].ooff013  = g_ooff_d[l_ac].ooff013||'\n'||g_qryparam.return1              #將開窗取得的值回傳到變數
            #   END IF
            #END IF
            #DISPLAY g_ooff_d[l_ac].ooff013   TO s_detail1_aooi360_01[l_ac].ooff013           #顯示到畫面上
            #LET g_qryparam.where = ""
            CALL aooi360_02(g_ooff001_d,g_ooff002_d,g_ooff003_d,g_ooff004_d,g_ooff005_d,g_ooff006_d,g_ooff007_d,g_ooff008_d,g_ooff009_d,g_ooff010_d,g_ooff011_d,g_ooff_d[l_ac].ooff012)
            CALL s_aooi360_sel(g_ooff001_d,g_ooff002_d,g_ooff003_d,g_ooff004_d,g_ooff005_d,g_ooff006_d,g_ooff007_d,g_ooff008_d,g_ooff009_d,g_ooff010_d,g_ooff011_d,g_ooff_d[l_ac].ooff012) RETURNING l_success,g_ooff_d[l_ac].ooff013
            LET l_cmd = 'u' 
            LET g_ooff_d_t.* = g_ooff_d[l_ac].*
            #161031-00025#4---e
            DISPLAY g_ooff_d[l_ac].ooff013 TO s_detail1_aooi360_01[l_ac].ooff013
            NEXT FIELD ooff013
    
         AFTER INPUT
            #add-point:單身輸入後處理
            LET g_ooff_d4.* = g_ooff_d.*
            ##end add-point
            
      END INPUT
      
END DIALOG

 
{</section>}
 
{<section id="aooi360_01.other_function" readonly="Y" >}
# 單身陣列填充
PUBLIC FUNCTION aooi360_01_b_fill(p_ooff001,p_ooff002,p_ooff003,p_ooff004,p_ooff005,p_ooff006,p_ooff007,p_ooff008,p_ooff009,p_ooff010,p_ooff011)
   DEFINE p_ooff001       LIKE ooff_t.ooff001   #備註類型:1.人員備註2.客商備註3.料號備註4.BOM單頭備註5.BO單身備註6.單據單頭備註7.單據單身備註
   DEFINE p_ooff002       LIKE ooff_t.ooff002   #第一Key值
   DEFINE p_ooff003       LIKE ooff_t.ooff003   #第二Key值
   DEFINE p_ooff004       LIKE ooff_t.ooff004   #第三Key值
   DEFINE p_ooff005       LIKE ooff_t.ooff005   #第四Key值
   DEFINE p_ooff006       LIKE ooff_t.ooff006   #第五Key值
   DEFINE p_ooff007       LIKE ooff_t.ooff007   #第六Key值
   DEFINE p_ooff008       LIKE ooff_t.ooff008   #第七Key值
   DEFINE p_ooff009       LIKE ooff_t.ooff009   #第八Key值
   DEFINE p_ooff010       LIKE ooff_t.ooff010   #第九Key值
   DEFINE p_ooff011       LIKE ooff_t.ooff011   #第十Key值
   DEFINE l_sql           STRING
   DEFINE l_ac1           LIKE type_t.num5  

   IF cl_null(p_ooff002) THEN LET p_ooff002=' ' END IF
   IF cl_null(p_ooff003) THEN LET p_ooff003=' ' END IF
   IF cl_null(p_ooff004) THEN LET p_ooff004=' ' END IF
   IF cl_null(p_ooff005) THEN LET p_ooff005=' ' END IF
   IF cl_null(p_ooff006) THEN LET p_ooff006=' ' END IF
   IF cl_null(p_ooff007) THEN LET p_ooff007=' ' END IF
   IF cl_null(p_ooff008) THEN LET p_ooff008=' ' END IF
   IF cl_null(p_ooff009) THEN LET p_ooff009=' ' END IF
   IF cl_null(p_ooff010) THEN LET p_ooff010=' ' END IF
   IF cl_null(p_ooff011) THEN LET p_ooff011=' ' END IF
   
   LET l_sql = " SELECT ooff001,ooff002,ooff004,ooff005,ooff006,ooff007,ooff008,ooff009,ooff010,ooff011,ooff003,ooff012,ooff013,ooff014 ",
                      "   FROM ooff_t WHERE ooffent = '",g_enterprise,"' ",
                      "    AND ooff001 = '",p_ooff001,"' AND ooff002 = '",p_ooff002,"' AND ooff003 = '",p_ooff003,"' ",
                      "    AND ooff004 = '",p_ooff004,"' AND ooff005 = '",p_ooff005,"' AND ooff006 = '",p_ooff006,"' ",
                      "    AND ooff007 = '",p_ooff007,"' AND ooff008 = '",p_ooff008,"' AND ooff009 = '",p_ooff009,"' ",
                      "    AND ooff010 = '",p_ooff010,"' AND ooff011 = '",p_ooff011,"' "
   IF NOT cl_null(g_wc2_i36001) THEN
      LET l_sql = l_sql CLIPPED, " AND ",g_wc2_i36001 CLIPPED
   END IF
   LET l_sql = l_sql CLIPPED, " ORDER BY ooff001,ooff002,ooff003,ooff004,ooff005,ooff006,ooff007,ooff008,ooff009,ooff010,ooff011 " 
   
   PREPARE aooi360_01_pb FROM l_sql
   DECLARE b_fill_curs CURSOR FOR aooi360_01_pb 
   
   CALL g_ooff_d.clear()
   LET l_ac1 = 1
   FOREACH b_fill_curs INTO g_ooff_d[l_ac1].*
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "FOREACH:"
         LET g_errparam.popup = TRUE
         CALL cl_err()

         EXIT FOREACH
      END IF
      LET l_ac1 = l_ac1 + 1
      IF l_ac1 > g_max_rec THEN
         EXIT FOREACH
      END IF
      
   END FOREACH 
   CALL g_ooff_d.deleteElement(g_ooff_d.getLength())   
   LET g_rec_b = l_ac1 - 1
   DISPLAY g_rec_b TO FORMONLY.cnt
   
   #將總筆數, 目前筆數指定到共用變數中
   IF g_rec_b > 0 THEN
      LET g_d_idx_i36001 = 1
   ELSE
      LET g_d_idx_i36001 = 0
   END IF
   LET g_d_cnt_i36001 = g_rec_b
 
   LET g_ooff_d4.* = g_ooff_d.*
   
   CLOSE b_fill_curs
   FREE aooi360_01_pb
END FUNCTION
#備註錄入
PRIVATE FUNCTION aooi360_01_s01(p_ooff013)
DEFINE p_ooff013          LIKE ooff_t.ooff013
DEFINE r_ooff013          LIKE ooff_t.ooff013
DEFINE lwin_curr          ui.Window   #161031-00025#1
DEFINE lfrm_curr          ui.Form     #161031-00025#1
DEFINE ls_path            STRING      #161031-00025#1

   OPEN WINDOW aooi360_01_s01_w WITH FORM cl_ap_formpath("aoo","aooi360_01_s01")
       ATTRIBUTE (STYLE="functionwin")
  
   CALL cl_ui_init()
   #161031-00025#1---s
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   LET lwin_curr = ui.Window.getCurrent()
   LET lfrm_curr = lwin_curr.getForm()
   LET ls_path = os.Path.join(os.Path.join(FGL_GETENV("ERP"),"cfg"),"4tb")
   LET ls_path = os.Path.join(ls_path,"toolbar_lib.4tb")
   CALL lfrm_curr.loadToolBar(ls_path)
   #161031-00025#1---e
   
   INPUT r_ooff013  FROM formonly.s01
   
        BEFORE INPUT
           LET r_ooff013 = p_ooff013
           DISPLAY r_ooff013 TO formonly.s01 
           
        AFTER INPUT
        
      ON ACTION accept
         LET INT_FLAG = FALSE
         ACCEPT INPUT

      ON ACTION cancel
         LET INT_FLAG = TRUE
         EXIT INPUT
   END INPUT
   IF INT_FLAG THEN
      LET r_ooff013 = p_ooff013
   END IF
   LET INT_FLAG = FALSE  
   CLOSE WINDOW aooi360_01_s01_w 
   RETURN r_ooff013 
END FUNCTION
#清除畫面上單身
PUBLIC FUNCTION aooi360_01_clear_detail()

   CALL g_ooff_d.clear()
   
END FUNCTION

 
{</section>}
 
