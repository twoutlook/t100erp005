#該程式未解開Section, 採用最新樣板產出!
{<section id="aooi360_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0003(2013-11-12 11:25:22), PR版次:0003(2017-01-11 19:33:16)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000158
#+ Filename...: aooi360_02
#+ Description: 備註維護设置
#+ Creator....: 01258(2013-08-16 10:53:30)
#+ Modifier...: 02482 -SD/PR- 00593
 
{</section>}
 
{<section id="aooi360_02.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#Memos
#161124-00048#13   2016/12/14  By 08734   星号整批调整
#170111-00068#1    2017/01/11  By Sarah   ooffstus預設給值Y
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
PRIVATE type type_g_ooff_m        RECORD
       ooff002 LIKE ooff_t.ooff002, 
   ooff007 LIKE ooff_t.ooff007, 
   ooff003 LIKE ooff_t.ooff003, 
   ooff008 LIKE ooff_t.ooff008, 
   ooff004 LIKE ooff_t.ooff004, 
   ooff009 LIKE ooff_t.ooff009, 
   ooff005 LIKE ooff_t.ooff005, 
   ooff010 LIKE ooff_t.ooff010, 
   ooff006 LIKE ooff_t.ooff006, 
   ooff011 LIKE ooff_t.ooff011, 
   ooff001 LIKE ooff_t.ooff001, 
   ooff012 LIKE ooff_t.ooff012, 
   ooff014 LIKE ooff_t.ooff014, 
   ooff013 LIKE ooff_t.ooff013
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"

#end add-point
 
DEFINE g_ooff_m        type_g_ooff_m
 
   DEFINE g_ooff002_t LIKE ooff_t.ooff002
DEFINE g_ooff007_t LIKE ooff_t.ooff007
DEFINE g_ooff003_t LIKE ooff_t.ooff003
DEFINE g_ooff008_t LIKE ooff_t.ooff008
DEFINE g_ooff004_t LIKE ooff_t.ooff004
DEFINE g_ooff009_t LIKE ooff_t.ooff009
DEFINE g_ooff005_t LIKE ooff_t.ooff005
DEFINE g_ooff010_t LIKE ooff_t.ooff010
DEFINE g_ooff006_t LIKE ooff_t.ooff006
DEFINE g_ooff011_t LIKE ooff_t.ooff011
DEFINE g_ooff001_t LIKE ooff_t.ooff001
DEFINE g_ooff012_t LIKE ooff_t.ooff012
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="aooi360_02.input" >}
#+ 資料輸入
PUBLIC FUNCTION aooi360_02(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_ooff001,p_ooff002,p_ooff003,p_ooff004,p_ooff005,p_ooff006,p_ooff007,p_ooff008,p_ooff009,p_ooff010,p_ooff011,p_ooff012
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
   DEFINE p_ooff012       LIKE ooff_t.ooff012   #控制类型:1.列印在后2.列印在前3.内部咨询传递4.仅记录参考
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
   DEFINE l_n             LIKE type_t.num5
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_aooi360_02 WITH FORM cl_ap_formpath("aoo","aooi360_02")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   WHENEVER ERROR CONTINUE
   CALL cl_set_combo_scc('ooff012','11')  
   LET g_ooff_m.ooff014 = ""
#   IF p_ooff001 = '6' OR p_ooff001 = '7' THEN
#      CALL cl_err(p_ooff001,'aoo-00166',0)
#      CLOSE WINDOW w_aooi360_02 
#      RETURN
#   END IF
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
   IF cl_null(p_ooff012) THEN LET p_ooff012='4' END IF
   LET g_ooff_m.ooff012 = p_ooff012
   LET g_ooff_m.ooff013 = ""
   SELECT ooff013 INTO g_ooff_m.ooff013 
     FROM ooff_t
    WHERE ooff001 = p_ooff001
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
      AND ooff012 = p_ooff012
      AND ooffent = g_enterprise
   DISPLAY g_ooff_m.ooff013  TO ooff013
   LET g_ooff_m.ooff014= ""
   SELECT ooff014 INTO g_ooff_m.ooff014
     FROM ooff_t
    WHERE ooff001 = p_ooff001
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
      AND ooff012 = p_ooff012
      AND ooffent = g_enterprise
   DISPLAY g_ooff_m.ooff014  TO ooff014
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_ooff_m.ooff002,g_ooff_m.ooff007,g_ooff_m.ooff003,g_ooff_m.ooff008,g_ooff_m.ooff004, 
          g_ooff_m.ooff009,g_ooff_m.ooff005,g_ooff_m.ooff010,g_ooff_m.ooff006,g_ooff_m.ooff011,g_ooff_m.ooff001, 
          g_ooff_m.ooff012,g_ooff_m.ooff014,g_ooff_m.ooff013 ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION define
            LET g_action_choice="define"
            IF cl_auth_chk_act("define") THEN
               
               #add-point:ON ACTION define name="input.master_input.define"
               LET g_qryparam.reqry = FALSE

#               LET g_qryparam.default1 = g_ooff_m.ooff013  #給予default值

               #給予arg
               LET g_qryparam.where = "(oofd013 > '",g_today,"' OR oofd013 IS NULL)"
               CALL q_oofd012()                                #呼叫開窗
               IF NOT cl_null(g_qryparam.return1) THEN
                  IF cl_null(g_ooff_m.ooff013) THEN
                     LET g_ooff_m.ooff013  = g_qryparam.return1
                  ELSE
                     LET g_ooff_m.ooff013  = g_ooff_m.ooff013||'\n'||g_qryparam.return1              #將開窗取得的值回傳到變數
                  END IF
               END IF
               DISPLAY g_ooff_m.ooff013  TO ooff013           #顯示到畫面上
               LET g_qryparam.where = ""
               NEXT FIELD ooff013
               #END add-point
            END IF
 
 
 
 
         #應用 a43 樣板自動產生(Version:4)
         ON ACTION comme
            LET g_action_choice="comme"
            IF cl_auth_chk_act("comme") THEN
               
               #add-point:ON ACTION comme name="input.master_input.comme"
               LET g_qryparam.reqry = FALSE

#               LET g_qryparam.default1 = g_ooff_m.ooff013  #給予default值

               #給予arg
               LET g_qryparam.where = "(oofe008 > '",g_today,"' OR oofe008 IS NULL)"
               CALL q_oofe007()                                #呼叫開窗
               IF NOT cl_null(g_qryparam.return1) THEN
                  IF cl_null(g_ooff_m.ooff013) THEN
                     LET g_ooff_m.ooff013  = g_qryparam.return1
                  ELSE
                     LET g_ooff_m.ooff013  = g_ooff_m.ooff013||'\n'||g_qryparam.return1              #將開窗取得的值回傳到變數
                  END IF
               END IF
               DISPLAY g_ooff_m.ooff013  TO ooff013           #顯示到畫面上
               LET g_qryparam.where = ""
               NEXT FIELD ooff013
               #END add-point
            END IF
 
 
 
 
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooff002
            #add-point:BEFORE FIELD ooff002 name="input.b.ooff002"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooff002
            
            #add-point:AFTER FIELD ooff002 name="input.a.ooff002"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_ooff_m.ooff001) AND NOT cl_null(g_ooff_m.ooff002) AND NOT cl_null(g_ooff_m.ooff003) AND NOT cl_null(g_ooff_m.ooff004) AND NOT cl_null(g_ooff_m.ooff005) AND NOT cl_null(g_ooff_m.ooff006) AND NOT cl_null(g_ooff_m.ooff007) AND NOT cl_null(g_ooff_m.ooff008) AND NOT cl_null(g_ooff_m.ooff009) AND NOT cl_null(g_ooff_m.ooff010) AND NOT cl_null(g_ooff_m.ooff011) AND NOT cl_null(g_ooff_m.ooff012) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_ooff_m.ooff001 != g_ooff001_t  OR g_ooff_m.ooff002 != g_ooff002_t  OR g_ooff_m.ooff003 != g_ooff003_t  OR g_ooff_m.ooff004 != g_ooff004_t  OR g_ooff_m.ooff005 != g_ooff005_t  OR g_ooff_m.ooff006 != g_ooff006_t  OR g_ooff_m.ooff007 != g_ooff007_t  OR g_ooff_m.ooff008 != g_ooff008_t  OR g_ooff_m.ooff009 != g_ooff009_t  OR g_ooff_m.ooff010 != g_ooff010_t  OR g_ooff_m.ooff011 != g_ooff011_t  OR g_ooff_m.ooff012 != g_ooff012_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM ooff_t WHERE "||"ooffent = '" ||g_enterprise|| "' AND "||"ooff001 = '"||g_ooff_m.ooff001 ||"' AND "|| "ooff002 = '"||g_ooff_m.ooff002 ||"' AND "|| "ooff003 = '"||g_ooff_m.ooff003 ||"' AND "|| "ooff004 = '"||g_ooff_m.ooff004 ||"' AND "|| "ooff005 = '"||g_ooff_m.ooff005 ||"' AND "|| "ooff006 = '"||g_ooff_m.ooff006 ||"' AND "|| "ooff007 = '"||g_ooff_m.ooff007 ||"' AND "|| "ooff008 = '"||g_ooff_m.ooff008 ||"' AND "|| "ooff009 = '"||g_ooff_m.ooff009 ||"' AND "|| "ooff010 = '"||g_ooff_m.ooff010 ||"' AND "|| "ooff011 = '"||g_ooff_m.ooff011 ||"' AND "|| "ooff012 = '"||g_ooff_m.ooff012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooff002
            #add-point:ON CHANGE ooff002 name="input.g.ooff002"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooff007
            #add-point:BEFORE FIELD ooff007 name="input.b.ooff007"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooff007
            
            #add-point:AFTER FIELD ooff007 name="input.a.ooff007"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_ooff_m.ooff001) AND NOT cl_null(g_ooff_m.ooff002) AND NOT cl_null(g_ooff_m.ooff003) AND NOT cl_null(g_ooff_m.ooff004) AND NOT cl_null(g_ooff_m.ooff005) AND NOT cl_null(g_ooff_m.ooff006) AND NOT cl_null(g_ooff_m.ooff007) AND NOT cl_null(g_ooff_m.ooff008) AND NOT cl_null(g_ooff_m.ooff009) AND NOT cl_null(g_ooff_m.ooff010) AND NOT cl_null(g_ooff_m.ooff011) AND NOT cl_null(g_ooff_m.ooff012) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_ooff_m.ooff001 != g_ooff001_t  OR g_ooff_m.ooff002 != g_ooff002_t  OR g_ooff_m.ooff003 != g_ooff003_t  OR g_ooff_m.ooff004 != g_ooff004_t  OR g_ooff_m.ooff005 != g_ooff005_t  OR g_ooff_m.ooff006 != g_ooff006_t  OR g_ooff_m.ooff007 != g_ooff007_t  OR g_ooff_m.ooff008 != g_ooff008_t  OR g_ooff_m.ooff009 != g_ooff009_t  OR g_ooff_m.ooff010 != g_ooff010_t  OR g_ooff_m.ooff011 != g_ooff011_t  OR g_ooff_m.ooff012 != g_ooff012_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM ooff_t WHERE "||"ooffent = '" ||g_enterprise|| "' AND "||"ooff001 = '"||g_ooff_m.ooff001 ||"' AND "|| "ooff002 = '"||g_ooff_m.ooff002 ||"' AND "|| "ooff003 = '"||g_ooff_m.ooff003 ||"' AND "|| "ooff004 = '"||g_ooff_m.ooff004 ||"' AND "|| "ooff005 = '"||g_ooff_m.ooff005 ||"' AND "|| "ooff006 = '"||g_ooff_m.ooff006 ||"' AND "|| "ooff007 = '"||g_ooff_m.ooff007 ||"' AND "|| "ooff008 = '"||g_ooff_m.ooff008 ||"' AND "|| "ooff009 = '"||g_ooff_m.ooff009 ||"' AND "|| "ooff010 = '"||g_ooff_m.ooff010 ||"' AND "|| "ooff011 = '"||g_ooff_m.ooff011 ||"' AND "|| "ooff012 = '"||g_ooff_m.ooff012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooff007
            #add-point:ON CHANGE ooff007 name="input.g.ooff007"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooff003
            #add-point:BEFORE FIELD ooff003 name="input.b.ooff003"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooff003
            
            #add-point:AFTER FIELD ooff003 name="input.a.ooff003"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_ooff_m.ooff001) AND NOT cl_null(g_ooff_m.ooff002) AND NOT cl_null(g_ooff_m.ooff003) AND NOT cl_null(g_ooff_m.ooff004) AND NOT cl_null(g_ooff_m.ooff005) AND NOT cl_null(g_ooff_m.ooff006) AND NOT cl_null(g_ooff_m.ooff007) AND NOT cl_null(g_ooff_m.ooff008) AND NOT cl_null(g_ooff_m.ooff009) AND NOT cl_null(g_ooff_m.ooff010) AND NOT cl_null(g_ooff_m.ooff011) AND NOT cl_null(g_ooff_m.ooff012) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_ooff_m.ooff001 != g_ooff001_t  OR g_ooff_m.ooff002 != g_ooff002_t  OR g_ooff_m.ooff003 != g_ooff003_t  OR g_ooff_m.ooff004 != g_ooff004_t  OR g_ooff_m.ooff005 != g_ooff005_t  OR g_ooff_m.ooff006 != g_ooff006_t  OR g_ooff_m.ooff007 != g_ooff007_t  OR g_ooff_m.ooff008 != g_ooff008_t  OR g_ooff_m.ooff009 != g_ooff009_t  OR g_ooff_m.ooff010 != g_ooff010_t  OR g_ooff_m.ooff011 != g_ooff011_t  OR g_ooff_m.ooff012 != g_ooff012_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM ooff_t WHERE "||"ooffent = '" ||g_enterprise|| "' AND "||"ooff001 = '"||g_ooff_m.ooff001 ||"' AND "|| "ooff002 = '"||g_ooff_m.ooff002 ||"' AND "|| "ooff003 = '"||g_ooff_m.ooff003 ||"' AND "|| "ooff004 = '"||g_ooff_m.ooff004 ||"' AND "|| "ooff005 = '"||g_ooff_m.ooff005 ||"' AND "|| "ooff006 = '"||g_ooff_m.ooff006 ||"' AND "|| "ooff007 = '"||g_ooff_m.ooff007 ||"' AND "|| "ooff008 = '"||g_ooff_m.ooff008 ||"' AND "|| "ooff009 = '"||g_ooff_m.ooff009 ||"' AND "|| "ooff010 = '"||g_ooff_m.ooff010 ||"' AND "|| "ooff011 = '"||g_ooff_m.ooff011 ||"' AND "|| "ooff012 = '"||g_ooff_m.ooff012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooff003
            #add-point:ON CHANGE ooff003 name="input.g.ooff003"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooff008
            #add-point:BEFORE FIELD ooff008 name="input.b.ooff008"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooff008
            
            #add-point:AFTER FIELD ooff008 name="input.a.ooff008"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_ooff_m.ooff001) AND NOT cl_null(g_ooff_m.ooff002) AND NOT cl_null(g_ooff_m.ooff003) AND NOT cl_null(g_ooff_m.ooff004) AND NOT cl_null(g_ooff_m.ooff005) AND NOT cl_null(g_ooff_m.ooff006) AND NOT cl_null(g_ooff_m.ooff007) AND NOT cl_null(g_ooff_m.ooff008) AND NOT cl_null(g_ooff_m.ooff009) AND NOT cl_null(g_ooff_m.ooff010) AND NOT cl_null(g_ooff_m.ooff011) AND NOT cl_null(g_ooff_m.ooff012) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_ooff_m.ooff001 != g_ooff001_t  OR g_ooff_m.ooff002 != g_ooff002_t  OR g_ooff_m.ooff003 != g_ooff003_t  OR g_ooff_m.ooff004 != g_ooff004_t  OR g_ooff_m.ooff005 != g_ooff005_t  OR g_ooff_m.ooff006 != g_ooff006_t  OR g_ooff_m.ooff007 != g_ooff007_t  OR g_ooff_m.ooff008 != g_ooff008_t  OR g_ooff_m.ooff009 != g_ooff009_t  OR g_ooff_m.ooff010 != g_ooff010_t  OR g_ooff_m.ooff011 != g_ooff011_t  OR g_ooff_m.ooff012 != g_ooff012_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM ooff_t WHERE "||"ooffent = '" ||g_enterprise|| "' AND "||"ooff001 = '"||g_ooff_m.ooff001 ||"' AND "|| "ooff002 = '"||g_ooff_m.ooff002 ||"' AND "|| "ooff003 = '"||g_ooff_m.ooff003 ||"' AND "|| "ooff004 = '"||g_ooff_m.ooff004 ||"' AND "|| "ooff005 = '"||g_ooff_m.ooff005 ||"' AND "|| "ooff006 = '"||g_ooff_m.ooff006 ||"' AND "|| "ooff007 = '"||g_ooff_m.ooff007 ||"' AND "|| "ooff008 = '"||g_ooff_m.ooff008 ||"' AND "|| "ooff009 = '"||g_ooff_m.ooff009 ||"' AND "|| "ooff010 = '"||g_ooff_m.ooff010 ||"' AND "|| "ooff011 = '"||g_ooff_m.ooff011 ||"' AND "|| "ooff012 = '"||g_ooff_m.ooff012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooff008
            #add-point:ON CHANGE ooff008 name="input.g.ooff008"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooff004
            #add-point:BEFORE FIELD ooff004 name="input.b.ooff004"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooff004
            
            #add-point:AFTER FIELD ooff004 name="input.a.ooff004"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_ooff_m.ooff001) AND NOT cl_null(g_ooff_m.ooff002) AND NOT cl_null(g_ooff_m.ooff003) AND NOT cl_null(g_ooff_m.ooff004) AND NOT cl_null(g_ooff_m.ooff005) AND NOT cl_null(g_ooff_m.ooff006) AND NOT cl_null(g_ooff_m.ooff007) AND NOT cl_null(g_ooff_m.ooff008) AND NOT cl_null(g_ooff_m.ooff009) AND NOT cl_null(g_ooff_m.ooff010) AND NOT cl_null(g_ooff_m.ooff011) AND NOT cl_null(g_ooff_m.ooff012) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_ooff_m.ooff001 != g_ooff001_t  OR g_ooff_m.ooff002 != g_ooff002_t  OR g_ooff_m.ooff003 != g_ooff003_t  OR g_ooff_m.ooff004 != g_ooff004_t  OR g_ooff_m.ooff005 != g_ooff005_t  OR g_ooff_m.ooff006 != g_ooff006_t  OR g_ooff_m.ooff007 != g_ooff007_t  OR g_ooff_m.ooff008 != g_ooff008_t  OR g_ooff_m.ooff009 != g_ooff009_t  OR g_ooff_m.ooff010 != g_ooff010_t  OR g_ooff_m.ooff011 != g_ooff011_t  OR g_ooff_m.ooff012 != g_ooff012_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM ooff_t WHERE "||"ooffent = '" ||g_enterprise|| "' AND "||"ooff001 = '"||g_ooff_m.ooff001 ||"' AND "|| "ooff002 = '"||g_ooff_m.ooff002 ||"' AND "|| "ooff003 = '"||g_ooff_m.ooff003 ||"' AND "|| "ooff004 = '"||g_ooff_m.ooff004 ||"' AND "|| "ooff005 = '"||g_ooff_m.ooff005 ||"' AND "|| "ooff006 = '"||g_ooff_m.ooff006 ||"' AND "|| "ooff007 = '"||g_ooff_m.ooff007 ||"' AND "|| "ooff008 = '"||g_ooff_m.ooff008 ||"' AND "|| "ooff009 = '"||g_ooff_m.ooff009 ||"' AND "|| "ooff010 = '"||g_ooff_m.ooff010 ||"' AND "|| "ooff011 = '"||g_ooff_m.ooff011 ||"' AND "|| "ooff012 = '"||g_ooff_m.ooff012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooff004
            #add-point:ON CHANGE ooff004 name="input.g.ooff004"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooff009
            #add-point:BEFORE FIELD ooff009 name="input.b.ooff009"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooff009
            
            #add-point:AFTER FIELD ooff009 name="input.a.ooff009"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_ooff_m.ooff001) AND NOT cl_null(g_ooff_m.ooff002) AND NOT cl_null(g_ooff_m.ooff003) AND NOT cl_null(g_ooff_m.ooff004) AND NOT cl_null(g_ooff_m.ooff005) AND NOT cl_null(g_ooff_m.ooff006) AND NOT cl_null(g_ooff_m.ooff007) AND NOT cl_null(g_ooff_m.ooff008) AND NOT cl_null(g_ooff_m.ooff009) AND NOT cl_null(g_ooff_m.ooff010) AND NOT cl_null(g_ooff_m.ooff011) AND NOT cl_null(g_ooff_m.ooff012) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_ooff_m.ooff001 != g_ooff001_t  OR g_ooff_m.ooff002 != g_ooff002_t  OR g_ooff_m.ooff003 != g_ooff003_t  OR g_ooff_m.ooff004 != g_ooff004_t  OR g_ooff_m.ooff005 != g_ooff005_t  OR g_ooff_m.ooff006 != g_ooff006_t  OR g_ooff_m.ooff007 != g_ooff007_t  OR g_ooff_m.ooff008 != g_ooff008_t  OR g_ooff_m.ooff009 != g_ooff009_t  OR g_ooff_m.ooff010 != g_ooff010_t  OR g_ooff_m.ooff011 != g_ooff011_t  OR g_ooff_m.ooff012 != g_ooff012_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM ooff_t WHERE "||"ooffent = '" ||g_enterprise|| "' AND "||"ooff001 = '"||g_ooff_m.ooff001 ||"' AND "|| "ooff002 = '"||g_ooff_m.ooff002 ||"' AND "|| "ooff003 = '"||g_ooff_m.ooff003 ||"' AND "|| "ooff004 = '"||g_ooff_m.ooff004 ||"' AND "|| "ooff005 = '"||g_ooff_m.ooff005 ||"' AND "|| "ooff006 = '"||g_ooff_m.ooff006 ||"' AND "|| "ooff007 = '"||g_ooff_m.ooff007 ||"' AND "|| "ooff008 = '"||g_ooff_m.ooff008 ||"' AND "|| "ooff009 = '"||g_ooff_m.ooff009 ||"' AND "|| "ooff010 = '"||g_ooff_m.ooff010 ||"' AND "|| "ooff011 = '"||g_ooff_m.ooff011 ||"' AND "|| "ooff012 = '"||g_ooff_m.ooff012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooff009
            #add-point:ON CHANGE ooff009 name="input.g.ooff009"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooff005
            #add-point:BEFORE FIELD ooff005 name="input.b.ooff005"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooff005
            
            #add-point:AFTER FIELD ooff005 name="input.a.ooff005"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_ooff_m.ooff001) AND NOT cl_null(g_ooff_m.ooff002) AND NOT cl_null(g_ooff_m.ooff003) AND NOT cl_null(g_ooff_m.ooff004) AND NOT cl_null(g_ooff_m.ooff005) AND NOT cl_null(g_ooff_m.ooff006) AND NOT cl_null(g_ooff_m.ooff007) AND NOT cl_null(g_ooff_m.ooff008) AND NOT cl_null(g_ooff_m.ooff009) AND NOT cl_null(g_ooff_m.ooff010) AND NOT cl_null(g_ooff_m.ooff011) AND NOT cl_null(g_ooff_m.ooff012) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_ooff_m.ooff001 != g_ooff001_t  OR g_ooff_m.ooff002 != g_ooff002_t  OR g_ooff_m.ooff003 != g_ooff003_t  OR g_ooff_m.ooff004 != g_ooff004_t  OR g_ooff_m.ooff005 != g_ooff005_t  OR g_ooff_m.ooff006 != g_ooff006_t  OR g_ooff_m.ooff007 != g_ooff007_t  OR g_ooff_m.ooff008 != g_ooff008_t  OR g_ooff_m.ooff009 != g_ooff009_t  OR g_ooff_m.ooff010 != g_ooff010_t  OR g_ooff_m.ooff011 != g_ooff011_t  OR g_ooff_m.ooff012 != g_ooff012_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM ooff_t WHERE "||"ooffent = '" ||g_enterprise|| "' AND "||"ooff001 = '"||g_ooff_m.ooff001 ||"' AND "|| "ooff002 = '"||g_ooff_m.ooff002 ||"' AND "|| "ooff003 = '"||g_ooff_m.ooff003 ||"' AND "|| "ooff004 = '"||g_ooff_m.ooff004 ||"' AND "|| "ooff005 = '"||g_ooff_m.ooff005 ||"' AND "|| "ooff006 = '"||g_ooff_m.ooff006 ||"' AND "|| "ooff007 = '"||g_ooff_m.ooff007 ||"' AND "|| "ooff008 = '"||g_ooff_m.ooff008 ||"' AND "|| "ooff009 = '"||g_ooff_m.ooff009 ||"' AND "|| "ooff010 = '"||g_ooff_m.ooff010 ||"' AND "|| "ooff011 = '"||g_ooff_m.ooff011 ||"' AND "|| "ooff012 = '"||g_ooff_m.ooff012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooff005
            #add-point:ON CHANGE ooff005 name="input.g.ooff005"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooff010
            #add-point:BEFORE FIELD ooff010 name="input.b.ooff010"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooff010
            
            #add-point:AFTER FIELD ooff010 name="input.a.ooff010"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_ooff_m.ooff001) AND NOT cl_null(g_ooff_m.ooff002) AND NOT cl_null(g_ooff_m.ooff003) AND NOT cl_null(g_ooff_m.ooff004) AND NOT cl_null(g_ooff_m.ooff005) AND NOT cl_null(g_ooff_m.ooff006) AND NOT cl_null(g_ooff_m.ooff007) AND NOT cl_null(g_ooff_m.ooff008) AND NOT cl_null(g_ooff_m.ooff009) AND NOT cl_null(g_ooff_m.ooff010) AND NOT cl_null(g_ooff_m.ooff011) AND NOT cl_null(g_ooff_m.ooff012) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_ooff_m.ooff001 != g_ooff001_t  OR g_ooff_m.ooff002 != g_ooff002_t  OR g_ooff_m.ooff003 != g_ooff003_t  OR g_ooff_m.ooff004 != g_ooff004_t  OR g_ooff_m.ooff005 != g_ooff005_t  OR g_ooff_m.ooff006 != g_ooff006_t  OR g_ooff_m.ooff007 != g_ooff007_t  OR g_ooff_m.ooff008 != g_ooff008_t  OR g_ooff_m.ooff009 != g_ooff009_t  OR g_ooff_m.ooff010 != g_ooff010_t  OR g_ooff_m.ooff011 != g_ooff011_t  OR g_ooff_m.ooff012 != g_ooff012_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM ooff_t WHERE "||"ooffent = '" ||g_enterprise|| "' AND "||"ooff001 = '"||g_ooff_m.ooff001 ||"' AND "|| "ooff002 = '"||g_ooff_m.ooff002 ||"' AND "|| "ooff003 = '"||g_ooff_m.ooff003 ||"' AND "|| "ooff004 = '"||g_ooff_m.ooff004 ||"' AND "|| "ooff005 = '"||g_ooff_m.ooff005 ||"' AND "|| "ooff006 = '"||g_ooff_m.ooff006 ||"' AND "|| "ooff007 = '"||g_ooff_m.ooff007 ||"' AND "|| "ooff008 = '"||g_ooff_m.ooff008 ||"' AND "|| "ooff009 = '"||g_ooff_m.ooff009 ||"' AND "|| "ooff010 = '"||g_ooff_m.ooff010 ||"' AND "|| "ooff011 = '"||g_ooff_m.ooff011 ||"' AND "|| "ooff012 = '"||g_ooff_m.ooff012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooff010
            #add-point:ON CHANGE ooff010 name="input.g.ooff010"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooff006
            #add-point:BEFORE FIELD ooff006 name="input.b.ooff006"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooff006
            
            #add-point:AFTER FIELD ooff006 name="input.a.ooff006"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_ooff_m.ooff001) AND NOT cl_null(g_ooff_m.ooff002) AND NOT cl_null(g_ooff_m.ooff003) AND NOT cl_null(g_ooff_m.ooff004) AND NOT cl_null(g_ooff_m.ooff005) AND NOT cl_null(g_ooff_m.ooff006) AND NOT cl_null(g_ooff_m.ooff007) AND NOT cl_null(g_ooff_m.ooff008) AND NOT cl_null(g_ooff_m.ooff009) AND NOT cl_null(g_ooff_m.ooff010) AND NOT cl_null(g_ooff_m.ooff011) AND NOT cl_null(g_ooff_m.ooff012) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_ooff_m.ooff001 != g_ooff001_t  OR g_ooff_m.ooff002 != g_ooff002_t  OR g_ooff_m.ooff003 != g_ooff003_t  OR g_ooff_m.ooff004 != g_ooff004_t  OR g_ooff_m.ooff005 != g_ooff005_t  OR g_ooff_m.ooff006 != g_ooff006_t  OR g_ooff_m.ooff007 != g_ooff007_t  OR g_ooff_m.ooff008 != g_ooff008_t  OR g_ooff_m.ooff009 != g_ooff009_t  OR g_ooff_m.ooff010 != g_ooff010_t  OR g_ooff_m.ooff011 != g_ooff011_t  OR g_ooff_m.ooff012 != g_ooff012_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM ooff_t WHERE "||"ooffent = '" ||g_enterprise|| "' AND "||"ooff001 = '"||g_ooff_m.ooff001 ||"' AND "|| "ooff002 = '"||g_ooff_m.ooff002 ||"' AND "|| "ooff003 = '"||g_ooff_m.ooff003 ||"' AND "|| "ooff004 = '"||g_ooff_m.ooff004 ||"' AND "|| "ooff005 = '"||g_ooff_m.ooff005 ||"' AND "|| "ooff006 = '"||g_ooff_m.ooff006 ||"' AND "|| "ooff007 = '"||g_ooff_m.ooff007 ||"' AND "|| "ooff008 = '"||g_ooff_m.ooff008 ||"' AND "|| "ooff009 = '"||g_ooff_m.ooff009 ||"' AND "|| "ooff010 = '"||g_ooff_m.ooff010 ||"' AND "|| "ooff011 = '"||g_ooff_m.ooff011 ||"' AND "|| "ooff012 = '"||g_ooff_m.ooff012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooff006
            #add-point:ON CHANGE ooff006 name="input.g.ooff006"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooff011
            #add-point:BEFORE FIELD ooff011 name="input.b.ooff011"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooff011
            
            #add-point:AFTER FIELD ooff011 name="input.a.ooff011"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_ooff_m.ooff001) AND NOT cl_null(g_ooff_m.ooff002) AND NOT cl_null(g_ooff_m.ooff003) AND NOT cl_null(g_ooff_m.ooff004) AND NOT cl_null(g_ooff_m.ooff005) AND NOT cl_null(g_ooff_m.ooff006) AND NOT cl_null(g_ooff_m.ooff007) AND NOT cl_null(g_ooff_m.ooff008) AND NOT cl_null(g_ooff_m.ooff009) AND NOT cl_null(g_ooff_m.ooff010) AND NOT cl_null(g_ooff_m.ooff011) AND NOT cl_null(g_ooff_m.ooff012) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_ooff_m.ooff001 != g_ooff001_t  OR g_ooff_m.ooff002 != g_ooff002_t  OR g_ooff_m.ooff003 != g_ooff003_t  OR g_ooff_m.ooff004 != g_ooff004_t  OR g_ooff_m.ooff005 != g_ooff005_t  OR g_ooff_m.ooff006 != g_ooff006_t  OR g_ooff_m.ooff007 != g_ooff007_t  OR g_ooff_m.ooff008 != g_ooff008_t  OR g_ooff_m.ooff009 != g_ooff009_t  OR g_ooff_m.ooff010 != g_ooff010_t  OR g_ooff_m.ooff011 != g_ooff011_t  OR g_ooff_m.ooff012 != g_ooff012_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM ooff_t WHERE "||"ooffent = '" ||g_enterprise|| "' AND "||"ooff001 = '"||g_ooff_m.ooff001 ||"' AND "|| "ooff002 = '"||g_ooff_m.ooff002 ||"' AND "|| "ooff003 = '"||g_ooff_m.ooff003 ||"' AND "|| "ooff004 = '"||g_ooff_m.ooff004 ||"' AND "|| "ooff005 = '"||g_ooff_m.ooff005 ||"' AND "|| "ooff006 = '"||g_ooff_m.ooff006 ||"' AND "|| "ooff007 = '"||g_ooff_m.ooff007 ||"' AND "|| "ooff008 = '"||g_ooff_m.ooff008 ||"' AND "|| "ooff009 = '"||g_ooff_m.ooff009 ||"' AND "|| "ooff010 = '"||g_ooff_m.ooff010 ||"' AND "|| "ooff011 = '"||g_ooff_m.ooff011 ||"' AND "|| "ooff012 = '"||g_ooff_m.ooff012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooff011
            #add-point:ON CHANGE ooff011 name="input.g.ooff011"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooff001
            #add-point:BEFORE FIELD ooff001 name="input.b.ooff001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooff001
            
            #add-point:AFTER FIELD ooff001 name="input.a.ooff001"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_ooff_m.ooff001) AND NOT cl_null(g_ooff_m.ooff002) AND NOT cl_null(g_ooff_m.ooff003) AND NOT cl_null(g_ooff_m.ooff004) AND NOT cl_null(g_ooff_m.ooff005) AND NOT cl_null(g_ooff_m.ooff006) AND NOT cl_null(g_ooff_m.ooff007) AND NOT cl_null(g_ooff_m.ooff008) AND NOT cl_null(g_ooff_m.ooff009) AND NOT cl_null(g_ooff_m.ooff010) AND NOT cl_null(g_ooff_m.ooff011) AND NOT cl_null(g_ooff_m.ooff012) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_ooff_m.ooff001 != g_ooff001_t  OR g_ooff_m.ooff002 != g_ooff002_t  OR g_ooff_m.ooff003 != g_ooff003_t  OR g_ooff_m.ooff004 != g_ooff004_t  OR g_ooff_m.ooff005 != g_ooff005_t  OR g_ooff_m.ooff006 != g_ooff006_t  OR g_ooff_m.ooff007 != g_ooff007_t  OR g_ooff_m.ooff008 != g_ooff008_t  OR g_ooff_m.ooff009 != g_ooff009_t  OR g_ooff_m.ooff010 != g_ooff010_t  OR g_ooff_m.ooff011 != g_ooff011_t  OR g_ooff_m.ooff012 != g_ooff012_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM ooff_t WHERE "||"ooffent = '" ||g_enterprise|| "' AND "||"ooff001 = '"||g_ooff_m.ooff001 ||"' AND "|| "ooff002 = '"||g_ooff_m.ooff002 ||"' AND "|| "ooff003 = '"||g_ooff_m.ooff003 ||"' AND "|| "ooff004 = '"||g_ooff_m.ooff004 ||"' AND "|| "ooff005 = '"||g_ooff_m.ooff005 ||"' AND "|| "ooff006 = '"||g_ooff_m.ooff006 ||"' AND "|| "ooff007 = '"||g_ooff_m.ooff007 ||"' AND "|| "ooff008 = '"||g_ooff_m.ooff008 ||"' AND "|| "ooff009 = '"||g_ooff_m.ooff009 ||"' AND "|| "ooff010 = '"||g_ooff_m.ooff010 ||"' AND "|| "ooff011 = '"||g_ooff_m.ooff011 ||"' AND "|| "ooff012 = '"||g_ooff_m.ooff012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooff001
            #add-point:ON CHANGE ooff001 name="input.g.ooff001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooff012
            #add-point:BEFORE FIELD ooff012 name="input.b.ooff012"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooff012
            
            #add-point:AFTER FIELD ooff012 name="input.a.ooff012"
            #此段落由子樣板a05產生
            IF  NOT cl_null(g_ooff_m.ooff001) AND NOT cl_null(g_ooff_m.ooff002) AND NOT cl_null(g_ooff_m.ooff003) AND NOT cl_null(g_ooff_m.ooff004) AND NOT cl_null(g_ooff_m.ooff005) AND NOT cl_null(g_ooff_m.ooff006) AND NOT cl_null(g_ooff_m.ooff007) AND NOT cl_null(g_ooff_m.ooff008) AND NOT cl_null(g_ooff_m.ooff009) AND NOT cl_null(g_ooff_m.ooff010) AND NOT cl_null(g_ooff_m.ooff011) AND NOT cl_null(g_ooff_m.ooff012) THEN 
               IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_ooff_m.ooff001 != g_ooff001_t  OR g_ooff_m.ooff002 != g_ooff002_t  OR g_ooff_m.ooff003 != g_ooff003_t  OR g_ooff_m.ooff004 != g_ooff004_t  OR g_ooff_m.ooff005 != g_ooff005_t  OR g_ooff_m.ooff006 != g_ooff006_t  OR g_ooff_m.ooff007 != g_ooff007_t  OR g_ooff_m.ooff008 != g_ooff008_t  OR g_ooff_m.ooff009 != g_ooff009_t  OR g_ooff_m.ooff010 != g_ooff010_t  OR g_ooff_m.ooff011 != g_ooff011_t  OR g_ooff_m.ooff012 != g_ooff012_t ))) THEN 
                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM ooff_t WHERE "||"ooffent = '" ||g_enterprise|| "' AND "||"ooff001 = '"||g_ooff_m.ooff001 ||"' AND "|| "ooff002 = '"||g_ooff_m.ooff002 ||"' AND "|| "ooff003 = '"||g_ooff_m.ooff003 ||"' AND "|| "ooff004 = '"||g_ooff_m.ooff004 ||"' AND "|| "ooff005 = '"||g_ooff_m.ooff005 ||"' AND "|| "ooff006 = '"||g_ooff_m.ooff006 ||"' AND "|| "ooff007 = '"||g_ooff_m.ooff007 ||"' AND "|| "ooff008 = '"||g_ooff_m.ooff008 ||"' AND "|| "ooff009 = '"||g_ooff_m.ooff009 ||"' AND "|| "ooff010 = '"||g_ooff_m.ooff010 ||"' AND "|| "ooff011 = '"||g_ooff_m.ooff011 ||"' AND "|| "ooff012 = '"||g_ooff_m.ooff012 ||"'",'std-00004',0) THEN 
                     NEXT FIELD CURRENT
                  END IF
               END IF
            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooff012
            #add-point:ON CHANGE ooff012 name="input.g.ooff012"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooff014
            #add-point:BEFORE FIELD ooff014 name="input.b.ooff014"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooff014
            
            #add-point:AFTER FIELD ooff014 name="input.a.ooff014"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooff014
            #add-point:ON CHANGE ooff014 name="input.g.ooff014"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD ooff013
            #add-point:BEFORE FIELD ooff013 name="input.b.ooff013"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD ooff013
            
            #add-point:AFTER FIELD ooff013 name="input.a.ooff013"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE ooff013
            #add-point:ON CHANGE ooff013 name="input.g.ooff013"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.ooff002
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooff002
            #add-point:ON ACTION controlp INFIELD ooff002 name="input.c.ooff002"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooff007
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooff007
            #add-point:ON ACTION controlp INFIELD ooff007 name="input.c.ooff007"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooff003
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooff003
            #add-point:ON ACTION controlp INFIELD ooff003 name="input.c.ooff003"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooff008
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooff008
            #add-point:ON ACTION controlp INFIELD ooff008 name="input.c.ooff008"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooff004
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooff004
            #add-point:ON ACTION controlp INFIELD ooff004 name="input.c.ooff004"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooff009
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooff009
            #add-point:ON ACTION controlp INFIELD ooff009 name="input.c.ooff009"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooff005
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooff005
            #add-point:ON ACTION controlp INFIELD ooff005 name="input.c.ooff005"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooff010
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooff010
            #add-point:ON ACTION controlp INFIELD ooff010 name="input.c.ooff010"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooff006
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooff006
            #add-point:ON ACTION controlp INFIELD ooff006 name="input.c.ooff006"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooff011
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooff011
            #add-point:ON ACTION controlp INFIELD ooff011 name="input.c.ooff011"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooff001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooff001
            #add-point:ON ACTION controlp INFIELD ooff001 name="input.c.ooff001"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooff012
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooff012
            #add-point:ON ACTION controlp INFIELD ooff012 name="input.c.ooff012"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooff014
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooff014
            #add-point:ON ACTION controlp INFIELD ooff014 name="input.c.ooff014"
            
            #END add-point
 
 
         #Ctrlp:input.c.ooff013
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD ooff013
            #add-point:ON ACTION controlp INFIELD ooff013 name="input.c.ooff013"
            
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
   CLOSE WINDOW w_aooi360_02 
   
   #add-point:input段after input name="input.post_input"
   IF NOT INT_FLAG THEN
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
      LET l_ooff.ooff012 = g_ooff_m.ooff012
      LET l_ooff.ooff013 = g_ooff_m.ooff013
      LET l_ooff.ooff014 = g_ooff_m.ooff014
      LET l_ooff.ooffstus = 'Y'   #170111-00068#1 add
      LET l_n = 0
      SELECT COUNT(*) INTO l_n
        FROM ooff_t
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
         AND ooff012 = g_ooff_m.ooff012
      IF l_n = 0 THEN
         #INSERT INTO ooff_t VALUES (l_ooff.*)  #161124-00048#13  2016/12/14 By 08734 mark
         INSERT INTO ooff_t(ooffent,ooffstus,ooff001,ooff002,ooff003,ooff004,ooff005,ooff006,ooff007,ooff008,ooff009,
         ooff010,ooff011,ooff012,ooff013,ooff014,ooff015,ooffownid,ooffowndp,ooffcrtid,ooffcrtdp,ooffcrtdt,ooffmodid,ooffmoddt)  #161124-00048#13  2016/12/14 By 08734 add
            VALUES (l_ooff.ooffent,l_ooff.ooffstus,l_ooff.ooff001,l_ooff.ooff002,l_ooff.ooff003,l_ooff.ooff004,l_ooff.ooff005,l_ooff.ooff006,l_ooff.ooff007,l_ooff.ooff008,l_ooff.ooff009,
         l_ooff.ooff010,l_ooff.ooff011,l_ooff.ooff012,l_ooff.ooff013,l_ooff.ooff014,l_ooff.ooff015,l_ooff.ooffownid,l_ooff.ooffowndp,l_ooff.ooffcrtid,l_ooff.ooffcrtdp,l_ooff.ooffcrtdt,l_ooff.ooffmodid,l_ooff.ooffmoddt)
      ELSE
         UPDATE ooff_t SET ooff013 = g_ooff_m.ooff013,
                           ooff014 = g_ooff_m.ooff014
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
            AND ooff012 = g_ooff_m.ooff012
      END IF
      IF SQLCA.sqlcode THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = SQLCA.sqlcode
         LET g_errparam.extend = "ooff_t"
         LET g_errparam.popup = TRUE
         CALL cl_err()

      END IF
   END IF
   LET INT_FLAG = 0
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="aooi360_02.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="aooi360_02.other_function" readonly="Y" >}

 
{</section>}
 
