#該程式未解開Section, 採用最新樣板產出!
{<section id="axci004_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0007(2014-03-31 16:50:25), PR版次:0007(2016-12-22 15:44:23)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000378
#+ Filename...: axci004_01
#+ Description: 成本BOM引入作業
#+ Creator....: 02291(2013-11-28 10:29:13)
#+ Modifier...: 02291 -SD/PR- 05599
 
{</section>}
 
{<section id="axci004_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
# mod 141223 add by zhangllc 项次key
#160318-00005#45  2016/03/26  By pengxin     修正azzi920重复定义之错误讯息
#160727-00019#20  2016/08/4   By 08742       系统中定义的临时表名称超过15码在执行时会出错,将系统中定义的临时表长度超过15码的改掉
#                                            Mod  axci004_01_ins_tmp--> axci004_tmp01
#160902-00048#2   2016/09/06  By 02097       針對SQL的WHERE條件中缺少ent的清單做補強
#161124-00048#16  2016/12/16  By 08734       星号整批调整
#161130-00004#1   2016/12/22  By Charles4m   調整計算項次的方式
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
PRIVATE type type_g_xcad_m        RECORD
       xcad001 LIKE xcad_t.xcad001, 
   single LIKE type_t.chr500
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_sql           STRING   
DEFINE g_wc            STRING  
#單頭 type 宣告
 type type_g_xcad1_m        RECORD
   pbom LIKE type_t.chr80, 
   xcadsite1 LIKE type_t.chr80, 
   xcadsite1_desc LIKE type_t.chr80, 
   bmaa002 LIKE type_t.chr80, 
   standard LIKE type_t.chr80, 
   xcad001_1 LIKE type_t.chr80
       END RECORD
DEFINE g_xcad1_m        type_g_xcad1_m

#end add-point
 
DEFINE g_xcad_m        type_g_xcad_m
 
   DEFINE g_xcad001_t LIKE xcad_t.xcad001
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axci004_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION axci004_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_xcad001
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
   DEFINE p_xcad001       LIKE xcad_t.xcad001
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_n             LIKE type_t.num5
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_axci004_01 WITH FORM cl_ap_formpath("axc","axci004_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   WHENEVER ERROR CONTINUE
   LET g_xcad_m.xcad001  = p_xcad001
   LET g_xcad1_m.xcad001_1 = ''
   LET g_xcad1_m.xcadsite1  = ''
   LET g_xcad1_m.xcadsite1_desc = ''
   LET g_xcad_m.single='N'
   DISPLAY BY NAME g_xcad_m.xcad001,g_xcad_m.single,g_xcad1_m.xcad001_1,g_xcad1_m.xcadsite1,g_xcad1_m.xcadsite1_desc 
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_xcad_m.xcad001,g_xcad_m.single ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            LET g_xcad1_m.pbom = '1'
            LET g_xcad1_m.standard = ''
            CALL axci004_01_set_entry()
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcad001
            #add-point:BEFORE FIELD xcad001 name="input.b.xcad001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcad001
            
            #add-point:AFTER FIELD xcad001 name="input.a.xcad001"
            #此段落由子樣板a05產生
#           IF  NOT cl_null(g_xcad_m.xcad001) THEN 
#               IF p_cmd = 'a' OR ( p_cmd = 'u' AND (g_xcad_m.xcad001 != g_xcad001_t )) THEN 
#                  IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcad_t WHERE "||"xcadent = '" ||g_enterprise|| "' AND "||"xcad001 = '"||g_xcad_m.xcad001 ||"'",'std-00004',0) THEN 
#                     NEXT FIELD CURRENT
#                  END IF
#               END IF
#            END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcad001
            #add-point:ON CHANGE xcad001 name="input.g.xcad001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD single
            #add-point:BEFORE FIELD single name="input.b.single"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD single
            
            #add-point:AFTER FIELD single name="input.a.single"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE single
            #add-point:ON CHANGE single name="input.g.single"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.xcad001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcad001
            #add-point:ON ACTION controlp INFIELD xcad001 name="input.c.xcad001"
            
            #END add-point
 
 
         #Ctrlp:input.c.single
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD single
            #add-point:ON ACTION controlp INFIELD single name="input.c.single"
            
            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            
            #end add-point
            
      END INPUT
    
      #add-point:自定義input name="input.more_input"
      CONSTRUCT BY NAME g_wc ON xcad002_1
         BEFORE CONSTRUCT
            CALL cl_qbe_init()
         
         ON ACTION controlp INFIELD xcad002_1
            #add-point:ON ACTION controlp INFIELD xrad002
            #此段落由子樣板a08產生
            #開窗c段
                        INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'c'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.where = " imaa004 = 'A'"
            CALL q_imaf001_3()                           #呼叫開窗
            DISPLAY g_qryparam.return1 TO xcad002_1      #顯示到畫面上
            LET g_qryparam.where = NULL

            NEXT FIELD xcad002_1                        #返回原欄位
      END CONSTRUCT
      
      #輸入開始
      INPUT BY NAME g_xcad1_m.pbom,g_xcad1_m.xcadsite1,g_xcad1_m.bmaa002, 
          g_xcad1_m.standard,g_xcad1_m.xcad001_1 ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION

         #自訂ACTION(master_input)
         
         BEFORE INPUT
            LET g_xcad1_m.pbom = '1'
            LET g_xcad1_m.standard = ''
            CALL axci004_01_set_entry()

         AFTER FIELD pbom
            IF g_xcad1_m.pbom = 1 THEN
               LET g_xcad1_m.standard = NULL
            END IF
            CALL axci004_01_set_entry()

         ON CHANGE pbom
            IF g_xcad1_m.pbom = 1 THEN
               LET g_xcad1_m.standard = NULL
            END IF
            CALL axci004_01_set_entry()

         AFTER FIELD xcadsite1
            IF NOT cl_null(g_xcad1_m.xcadsite1) THEN 
               CALL axci004_01_xcadsite_chk(g_xcad1_m.xcadsite1)
               IF NOT cl_null(g_errno) THEN 
                  LET g_xcad1_m.xcadsite1_desc = ''
                  DISPLAY g_xcad1_m.xcadsite1_desc TO xcadsite1_desc
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = g_errno
                  LET g_errparam.extend = g_xcad1_m.xcadsite1
                  #160318-00005#45 --s add
                  CASE g_errno
                     WHEN 'sub-01333'
                        LET g_errparam.replace[1] = 'axci004'
                        LET g_errparam.replace[2] = cl_get_progname('axci004',g_lang,"2")
                        LET g_errparam.exeprog = 'axci004'
                  END CASE
                  #160318-00005#45 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
                  LET g_xcad1_m.xcadsite1 = ''
                  NEXT FIELD xcadsite1
               END IF
            END IF
            
            CALL s_desc_get_department_desc(g_xcad1_m.xcadsite1) RETURNING g_xcad1_m.xcadsite1_desc
            DISPLAY BY NAME g_xcad1_m.xcadsite1_desc

         AFTER FIELD bmaa002
#            IF g_xcad1_m.bmaa002 IS NOT NULL THEN
#              LET l_n = 0 
#              SELECT COUNT(*) INTO l_n
#                FROM bmaa_t
#               WHERE bmaaent = g_enterprise AND bmaa002 = g_xcad1_m.bmaa002
#              IF l_n = 0 THEN
#                 CALL cl_err('','aim-00126',0)
#                 NEXT FIELD bmaa002
#              END IF
#            END IF

         AFTER FIELD standard
            IF g_xcad1_m.standard = 1 THEN
               LET g_xcad1_m.pbom = NULL
            END IF
            CALL axci004_01_set_entry()

         ON CHANGE standard
            IF g_xcad1_m.standard = 1 THEN
               LET g_xcad1_m.pbom = NULL
            END IF
            CALL axci004_01_set_entry()

         AFTER FIELD xcad001_1
            IF NOT cl_null(g_xcad1_m.xcad001_1) THEN
               LET l_n = 0
               SELECT COUNT(*) INTO l_n FROM xcad_t 
                WHERE xcadent = g_enterprise AND xcad001 = g_xcad1_m.xcad001_1
               IF l_n = 0 THEN
                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = 'axc-00047'   #160318-00005#45  mark
                  LET g_errparam.code = 'sub-01302'   #160318-00005#45  add
                  LET g_errparam.extend = ''
                  #160318-00005#45 --s add
                  LET g_errparam.replace[1] = 'axci004'
                  LET g_errparam.replace[2] = cl_get_progname('axci004',g_lang,"2")
                  LET g_errparam.exeprog = 'axci004'
                  #160318-00005#45 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD xcad001_1
               END IF
               LET l_n=0
               SELECT COUNT(*) INTO l_n FROM xcad_t 
                WHERE xcadent = g_enterprise AND xcad001 = g_xcad1_m.xcad001_1 AND xcadstus = 'Y'
               IF l_n = 0 THEN
                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = 'axc-00048'   #160318-00005#45  mark
                  LET g_errparam.code = 'sub-01308'   #160318-00005#45  add
                  LET g_errparam.extend = ''
                  #160318-00005#45 --s add
                  LET g_errparam.replace[1] = 'axci004'
                  LET g_errparam.replace[2] = cl_get_progname('axci004',g_lang,"2")
                  LET g_errparam.exeprog = 'axci004'
                  #160318-00005#45 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD xcad001_1
               END IF
            END IF


         ON ACTION controlp INFIELD xcad001


         ON ACTION controlp INFIELD xcadsite1
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xcad1_m.xcadsite1             #給予default值
            #最加AFTER FIELD的限制
            #須存在[T:组织档] 且 有效 且為"法人組織"or"营运組織否"or"核算組織否"
            LET g_qryparam.where = " bmaasite in (SELECT UNIQUE ooef001 FROM ooef_t ",
                                   "               WHERE ooefent=",g_enterprise," AND ooefstus = 'Y' ",
                                   "                 AND (ooef003 = 'Y' OR ooef201 = 'Y' OR ooef204 = 'Y') )"
            #給予arg
            CALL q_bmaasite()                                #呼叫開窗
            LET g_xcad1_m.xcadsite1 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_xcad1_m.xcadsite1 TO xcadsite1              #顯示到畫面上

            CALL s_desc_get_department_desc(g_xcad1_m.xcadsite1) RETURNING g_xcad1_m.xcadsite1_desc
            DISPLAY BY NAME g_xcad1_m.xcadsite1_desc

            NEXT FIELD xcadsite1                          #返回原欄位

         ON ACTION controlp INFIELD bmaa002
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xcad1_m.bmaa002             #給予default值
            CALL q_bmaa002_1()                                #呼叫開窗
            LET g_xcad1_m.bmaa002 = g_qryparam.return1              
            DISPLAY g_xcad1_m.bmaa002 TO bmaa002              #
            NEXT FIELD bmaa002                          #返回原欄位

         ON ACTION controlp INFIELD xcad001_1
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.default1 = g_xcad1_m.xcad001_1             #給予default值
            LET g_qryparam.where = " xcadstus = 'Y' "
            #給予arg
            CALL q_xcad001()                                #呼叫開窗
            LET g_xcad1_m.xcad001_1 = g_qryparam.return1              #將開窗取得的值回傳到變數
            DISPLAY g_xcad1_m.xcad001_1 TO xcad001_1              #顯示到畫面上
            NEXT FIELD xcad001_1                          #返回原欄位

         AFTER INPUT

            
      END INPUT
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
   CLOSE WINDOW w_axci004_01 
   
   #add-point:input段after input name="input.post_input"
   LET l_success = FALSE
   IF INT_FLAG THEN
      LET l_success = FALSE
   ELSE
      CALL axci004_01_ins_xcad() RETURNING l_success
   END IF
   LET INT_FLAG = FALSE
   RETURN l_success
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axci004_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="axci004_01.other_function" readonly="Y" >}
#營運據點欄位檢查
PRIVATE FUNCTION axci004_01_xcadsite_chk(p_xcadsite)
DEFINE l_n          LIKE type_t.num5 
DEFINE p_xcadsite   LIKE xcad_t.xcadsite

   LET g_errno = ''
   #輸入值須存在[T:组织档]
   LET l_n = 0 
   SELECT count(*) INTO l_n 
     FROM ooef_t
    WHERE ooef001 = p_xcadsite
      AND ooefent = g_enterprise
   IF l_n = 0 THEN 
      LET g_errno = 'axc-00005'
      RETURN                        
   END IF
   #輸入值須在[T:组织档]里有效
   LET l_n = 0 
   SELECT count(*) INTO l_n 
     FROM ooef_t
    WHERE ooef001 = p_xcadsite
      AND ooefent = g_enterprise
      AND ooefstus = 'Y'
   IF l_n = 0 THEN 
      LET g_errno = 'axc-00006'
      RETURN   
   END IF 
   #輸入值須存在[T:组织档]里為"法人組織"or"营运組織否"or"核算組織否"
   LET l_n = 0 
   SELECT count(*) INTO l_n 
     FROM ooef_t
    WHERE ooef001 = p_xcadsite
      AND ooefent = g_enterprise
      AND (ooef003 = 'Y' OR ooef201 = 'Y' OR ooef204 = 'Y')
   IF l_n = 0 THEN 
      LET g_errno = 'axc-00058'
      RETURN                        
   END IF
   
   #输入的据点需存在于bom中
   LET l_n = 0 
   SELECT count(*) INTO l_n 
     FROM bmaa_t
    WHERE bmaaent  = g_enterprise
      AND bmaasite = p_xcadsite
   IF l_n = 0 THEN 
      #此据点无BOM资料
      LET g_errno = 'axc-00608'
      RETURN                        
   END IF
   
   
   #輸入的營運據點不存在于該版本下
   LET l_n = 0 
   IF g_xcad1_m.standard = '1' THEN
      SELECT COUNT(*) INTO l_n 
        FROM xcad_t
       WHERE xcadsite = p_xcadsite AND xcad001 = g_xcad1_m.xcad001_1
         AND xcadent = g_enterprise
         AND xcadstus = 'Y'
      IF l_n = 0 THEN 
#         LET g_errno = 'axc-00080'  #160318-00005#45  mark
         LET g_errno = 'sub-01333'  #160318-00005#45  add
         RETURN     
      END IF         
   END IF
END FUNCTION
#料件欄位檢查
PRIVATE FUNCTION axci004_01_xcad002_chk(p_xcad002)
DEFINE l_n          LIKE type_t.num5 
DEFINE p_xcad002    LIKE xcad_t.xcad002
DEFINE l_status     LIKE imaa_t.imaastus
   
   #輸入值需存在于[T:物料主档]中
   LET l_n = 0 
   SELECT count(*) INTO l_n
     FROM imaf_t
    WHERE imaaf01 = p_xcad002
      AND imafent = g_enterprise
   IF l_n = 0 THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axc-00007'
      LET g_errparam.extend = p_xcad002
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF 
                  
   #輸入值需在[T:物料主档]中已確認
   LET l_status = ''
   SELECT imaastus INTO l_status
     FROM imaa_t
    WHERE imaa001 = p_xcad002
      AND imaaent = g_enterprise                 
   IF l_status <> 'Y' THEN 
      IF l_status = 'N' THEN
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'axc-00040'
         LET g_errparam.extend = p_xcad002
         LET g_errparam.popup = TRUE
         CALL cl_err()
      ELSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = 'axc-00008'
         LET g_errparam.extend = p_xcad002
         LET g_errparam.popup = TRUE
         CALL cl_err()
      END IF
      RETURN FALSE
   END IF  
   
   #輸入值需在[T:物料主档]中採購件
   LET l_n = 0 
   SELECT count(*) INTO l_n
     FROM imaa_t
    WHERE imaa001 = p_xcad002
      AND imaa004 = 'A'
      AND imaastus = 'Y'
      AND imaaent = g_enterprise    #160902-00048#2
   IF l_n = 0 THEN 
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axc-00054'
      LET g_errparam.extend = p_xcad002
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF 
   RETURN TRUE
END FUNCTION
#批量插入數據
PRIVATE FUNCTION axci004_01_ins_xcad()
#DEFINE l_xcad         RECORD LIKE xcad_t.*  #161124-00048#16  2016/12/16  By 08734 mark
#161124-00048#16  2016/12/16  By 08734 add(S)
DEFINE l_xcad RECORD  #成本BOM主檔
       xcadent LIKE xcad_t.xcadent, #企业编号
       xcadownid LIKE xcad_t.xcadownid, #资料所有者
       xcadowndp LIKE xcad_t.xcadowndp, #资料所有部门
       xcadcrtid LIKE xcad_t.xcadcrtid, #资料录入者
       xcadcrtdp LIKE xcad_t.xcadcrtdp, #资料录入部门
       xcadcrtdt LIKE xcad_t.xcadcrtdt, #资料创建日
       xcadmodid LIKE xcad_t.xcadmodid, #资料更改者
       xcadmoddt LIKE xcad_t.xcadmoddt, #最近更改日
       xcadstus LIKE xcad_t.xcadstus, #状态码
       xcadsite LIKE xcad_t.xcadsite, #营运据点
       xcad001 LIKE xcad_t.xcad001, #版本
       xcad002 LIKE xcad_t.xcad002, #主件料号
       xcadseq LIKE xcad_t.xcadseq, #项次
       xcad003 LIKE xcad_t.xcad003, #元件料号
       xcad004 LIKE xcad_t.xcad004, #组成用量
       xcad005 LIKE xcad_t.xcad005, #主件底数
       xcad006 LIKE xcad_t.xcad006, #变动损耗率
       xcad007 LIKE xcad_t.xcad007, #固定损耗量
       xcad008 LIKE xcad_t.xcad008, #损耗批量
       xcad009 LIKE xcad_t.xcad009, #作业编号
       xcad010 LIKE xcad_t.xcad010, #作业序
       xcad011 LIKE xcad_t.xcad011, #部位编号
       xcad012 LIKE xcad_t.xcad012, #生效日期
       xcad013 LIKE xcad_t.xcad013 #失效日期
END RECORD
#161124-00048#16  2016/12/16  By 08734 add(E)
DEFINE l_xcadcrtdt    DATETIME YEAR TO SECOND
DEFINE l_n            LIKE type_t.num5
DEFINE l_n1           LIKE type_t.num5
DEFINE r_success      LIKE type_t.num5
DEFINE l_stus         LIKE xcad_t.xcadstus
DEFINE l_bmba002      LIKE bmba_t.bmba002
DEFINE l_sql1         STRING
DEFINE l_bmba001_t    LIKE bmba_t.bmba001 #主件料号 用于记录旧值
DEFINE l_xcadseq      LIKE xcad_t.xcadseq   #add 141223
DEFINE l_xcadseq_1    LIKE xcad_t.xcadseq   #161130-00004#1 add
DEFINE l_xcadseq_2    LIKE xcad_t.xcadseq   #161130-00004#1 add

   DELETE FROM axci004_tmp01           #160727-00019#20 Mod  axci004_01_ins_tmp--> axci004_tmp01
   LET r_success = TRUE
   SELECT UNIQUE xcadstus INTO l_stus FROM xcad_t
    WHERE xcadent = g_enterprise AND xcad001 = g_xcad_m.xcad001
   IF l_stus = 'Y' THEN
      #输入的版本已审核，不可引入资料！
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axc-00082'
      LET g_errparam.extend = g_xcad_m.xcad001
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE 
   END IF
   IF cl_null(g_wc)  THEN
      LET g_wc = " 1=1 "
   ELSE
      IF g_xcad1_m.pbom = '1' THEN
         LET g_wc = cl_replace_str(g_wc,'xcad002_1','bmba001')
      ELSE
         LET g_wc = cl_replace_str(g_wc,'xcad002_1','xcad002')
      END IF
   END IF
   
   IF cl_null(g_xcad1_m.bmaa002) THEN LET g_xcad1_m.bmaa002 = ' ' END IF  #add 141223
   
   #用于foreach中抓取料件bom的特性l_bmba002
   LET l_sql1 = " SELECT COUNT(*),bmba002 ",
                   #161130-00004#1 ---mark (s)---
                   #"   FROM bmba_t,imaa_t",
                   #"  WHERE bmbaent = imaaent AND bmba001 = imaa001 ",
                   #161130-00004#1 ---mark (e)---
                   #161130-00004#1 ---add (s)---
                   "    FROM bmba_t,bmaa_t,imaa_t",
                   "   WHERE bmbaent = bmaaent AND bmba001 = bmaa001 and bmbaent = imaaent AND bmba001 = imaa001 AND bmbasite = bmaasite ",
                   "     AND bmaastus = 'Y' ",
                   "     AND (bmba006 IS NULL OR to_char(bmba006,'YY/MM/DD hh24:mi:ss')>'",g_today,"')",
                   #161130-00004#1 ---add (e)---
                    "    AND bmbaent = '",g_enterprise,"'",
                    "    AND bmbasite = '",g_xcad1_m.xcadsite1,"'",
                    "    AND imaa004 = 'A' AND ",g_wc CLIPPED

   #LET g_sql = '' #mark for meaningless
   #获取要导入的资料明细信息
   #mod 141223 add bmba009&xcadseq
   IF g_xcad1_m.pbom = '1' THEN
      LET g_sql = " SELECT bmba001,bmba009,bmba003,bmba011,bmba012,0,0,0,bmba007,bmba008,bmba004,bmba005,bmba006,bmbasite ",
                 #"   FROM bmba_t,imaa_t", #161130-00004#1 mark
                 #"  WHERE bmbaent = imaaent AND bmba001 = imaa001 ", #161130-00004#1 mark
                 #161130-00004#1 ---add (s)---
                  "   FROM bmba_t,bmaa_t,imaa_t",
                  "  WHERE bmbaent = bmaaent AND bmba001 = bmaa001 and bmbaent = imaaent AND bmba001 = imaa001 AND bmbasite = bmaasite ", 
                  "   AND (bmba006 IS NULL OR to_char(bmba006,'YY/MM/DD hh24:mi:ss')>'",g_today,"')",
                  "    AND bmaastus = 'Y' ",
                 #161130-00004#1 ---add (e)---
                  "    AND bmbaent = '",g_enterprise,"'",
                  "    AND bmbasite = '",g_xcad1_m.xcadsite1,"'",
                  "    AND imaa004 = 'A' AND ",g_wc CLIPPED,
                  "  ORDER BY bmba001 "
   ELSE
      LET g_sql = " SELECT xcad002,xcadseq,xcad003,xcad004,xcad005,xcad006,xcad007,xcad008,xcad009,xcad010,xcad011,xcad012,xcad013,xcadsite ",
                  "   FROM xcad_t,imaa_t ",
                  "  WHERE xcadent = imaaent AND xcad002 = imaa001 ",
                  "    AND xcadent = '",g_enterprise,"'",
                  "    AND xcad001 = '",g_xcad1_m.xcad001_1,"'"
   END IF
   PREPARE xcad001_prep FROM g_sql
   DECLARE xcad001_curs CURSOR FOR xcad001_prep
   LET l_xcadcrtdt = cl_get_current()
   LET l_bmba001_t = ''
   FOREACH xcad001_curs INTO  l_xcad.xcad002,l_xcad.xcadseq,l_xcad.xcad003,l_xcad.xcad004,
                              l_xcad.xcad005,l_xcad.xcad006,l_xcad.xcad007,l_xcad.xcad008,
                              l_xcad.xcad009,l_xcad.xcad010,l_xcad.xcad011,l_xcad.xcad012,l_xcad.xcad013,
                              l_xcad.xcadsite
      
      #引入来源为P-BOM的，先指定需抓取料件bom的哪个特性l_bmba002
      IF g_xcad1_m.pbom = '1' THEN
         LET l_n = 0 
         
         LET g_sql = l_sql1 CLIPPED," AND bmba002 = '",g_xcad1_m.bmaa002,"'", #特性
                                    " AND bmba001 = '",l_xcad.xcad002,"'", #主件
                                    " GROUP BY bmba002"
         PREPARE bmba002_prep2 FROM g_sql
         EXECUTE bmba002_prep2 INTO l_n,l_bmba002
         #料件特性有输入，但抓不到资料
         IF l_n = 0 THEN
            LET l_n = 0
            #料件特性有输入，但抓不到资料，抓特性为空的资料
            LET g_sql = l_sql1 CLIPPED," AND bmba002 = ' ' ",
                                       " AND bmba001 = '",l_xcad.xcad002,"'",
                                       " GROUP BY bmba002"
            PREPARE bmba002_prep FROM g_sql
            EXECUTE bmba002_prep INTO l_n,l_bmba002
            IF l_n <> 0 THEN
               LET l_bmba002 = ' '
            ELSE
               #若特性为空无资料，抓改料号的第一笔特性
               LET g_sql = l_sql1 CLIPPED, 
                          " AND bmba001 = '",l_xcad.xcad002,"'",
                          " GROUP BY bmba002"
               PREPARE bmba002_prep1 FROM g_sql
               DECLARE bmba002_curs1 SCROLL CURSOR FOR bmba002_prep1
               OPEN bmba002_curs1
               FETCH FIRST bmba002_curs1 INTO l_n,l_bmba002
               CLOSE bmba002_curs1
            END IF
         ELSE
            LET l_bmba002 = g_xcad1_m.bmaa002  
         END IF
      END IF
      
      #檢查xcad_t裏面是否已存在需插入料件，已存在过就不不重复插入
      LET l_n1 = 0
      SELECT COUNT(*) INTO l_n1 FROM axci004_tmp01             #160727-00019#20 Mod  axci004_01_ins_tmp--> axci004_tmp01
       WHERE xcadent = g_enterprise
         AND xcad001 = g_xcad_m.xcad001 AND xcad002 = l_xcad.xcad002
         AND xcad003 = l_xcad.xcad003
         #161130-00004#1 ---add (s)---
         AND xcad009 = l_xcad.xcad009 AND xcad010 = l_xcad.xcad010
         AND xcad011 = l_xcad.xcad011 AND xcad012 = l_xcad.xcad012
         AND xcad013 = l_xcad.xcad013
         #161130-00004#1 ---add (e)---
      IF l_n1 > 0 THEN
         CONTINUE FOREACH
      END IF
      
      LET l_n1 = 0
      SELECT COUNT(*) INTO l_n1 FROM xcad_t
       WHERE xcadent = g_enterprise
         AND xcad001 = g_xcad_m.xcad001 AND xcad002 = l_xcad.xcad002
         AND xcad003 = l_xcad.xcad003
         #161130-00004#1 ---add (s)---
         AND xcad009 = l_xcad.xcad009 AND xcad010 = l_xcad.xcad010
         AND xcad011 = l_xcad.xcad011 AND xcad012 = l_xcad.xcad012
         AND xcad013 = l_xcad.xcad013
         #161130-00004#1 ---add (e)---
      IF l_n1 > 0 THEN
         CONTINUE FOREACH
      END IF

      #add 141223
      IF g_xcad1_m.pbom = '1' THEN
        #161130-00004#1 ---mark (s)---
        #IF cl_null(l_bmba001_t) OR l_bmba001_t!=l_xcad.xcad002 THEN
        #   LET l_xcadseq = 0
        #END IF
        #161130-00004#1 ---mark (e)---
        #161130-00004#1 ---add (s)---
         SELECT MAX(xcadseq) INTO l_xcadseq_1 FROM xcad_t 
          WHERE xcadent = g_enterprise
            AND xcad001 = g_xcad_m.xcad001 AND xcad002 = l_xcad.xcad002 
         IF cl_null(l_xcadseq_1) THEN LET l_xcadseq_1 = 0 END IF

         SELECT MAX(xcadseq) INTO l_xcadseq_2 FROM axci004_tmp01
          WHERE xcadent = g_enterprise
            AND xcad001 = g_xcad_m.xcad001 AND xcad002 = l_xcad.xcad002
         IF cl_null(l_xcadseq_2) THEN LET l_xcadseq_2 = 0 END IF
         IF l_xcadseq_1 >= l_xcadseq_2 THEN
            LET l_xcadseq = l_xcadseq_1
         ELSE
            LET l_xcadseq = l_xcadseq_2
         END IF
        #161130-00004#1 ---add (e)---
         LET l_xcadseq = l_xcadseq + 1
         LET l_bmba001_t = l_xcad.xcad002
         LET l_xcad.xcadseq = l_xcadseq
      END IF
      #add 141223 end
      
      #mod 141223 add xcadseq
      INSERT INTO axci004_tmp01(x_level,xcadent,xcad001,xcadsite,xcad002,xcadseq,           #160727-00019#20 Mod  axci004_01_ins_tmp--> axci004_tmp01
                                     xcad003,xcad004,xcad005,xcad006,xcad007,xcad008,
                                     xcad009,xcad010,xcad011,xcad012,xcad013,
                                     xcadstus,xcadownid,xcadowndp,xcadcrtid,xcadcrtdp,xcadcrtdt)
                   VALUES(0,g_enterprise,g_xcad_m.xcad001,l_xcad.xcadsite,l_xcad.xcad002,l_xcad.xcadseq,
                          l_xcad.xcad003,l_xcad.xcad004,l_xcad.xcad005,l_xcad.xcad006,l_xcad.xcad007,l_xcad.xcad008,
                          l_xcad.xcad009,l_xcad.xcad010,l_xcad.xcad011,l_xcad.xcad012,l_xcad.xcad013,
                          'N',g_user,g_dept,g_user,g_dept,l_xcadcrtdt)
                      
     #單階BOM为N就是要往下展
     IF g_xcad_m.single = 'N' THEN 
        CALL axci004_01_bom(0,l_xcad.xcad003,l_bmba002)
     END IF
   END FOREACH
   
   LET l_n1 = 0 
   SELECT COUNT(*) INTO l_n1 FROM axci004_tmp01 WHERE x_level = 0           #160727-00019#20 Mod  axci004_01_ins_tmp--> axci004_tmp01
   IF l_n1 = 0 THEN
      #没有可插入资料，请重新输入！
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axc-00098'
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
   END IF
   
   #mark 产生临时表时已经分好了，如果临时表部分，效率会慢
   ##單階BOM
   #mod 141223 add xcadseq
   #IF g_xcad_m.single = 'Y' THEN 
   #   INSERT INTO xcad_t (xcadent,xcad001,xcadsite,xcad002,xcadseq,
   #                       xcad003,xcad004,xcad005,xcad006,xcad007,xcad008,
   #                       xcad009,xcad010,xcad011,xcad012,xcad013,
   #                       xcadstus,xcadownid,xcadowndp,xcadcrtid,xcadcrtdp,xcadcrtdt) 
   #       SELECT xcadent,xcad001,xcadsite,xcad002,xcadseq,
   #              xcad003,xcad004,xcad005,xcad006,xcad007,xcad008,
   #              xcad009,xcad010,xcad011,xcad012,xcad013,
   #              'N',xcadownid,xcadowndp,xcadcrtid,xcadcrtdp,xcadcrtdt
   #         FROM axci004_01_ins_tmp  
   #        WHERE x_level = 0  
   #ELSE
      INSERT INTO xcad_t (xcadent,xcad001,xcadsite,xcad002,xcadseq,
                          xcad003,xcad004,xcad005,xcad006,xcad007,xcad008,
                          xcad009,xcad010,xcad011,xcad012,xcad013,
                          xcadstus,xcadownid,xcadowndp,xcadcrtid,xcadcrtdp,xcadcrtdt) 
          SELECT xcadent,xcad001,xcadsite,xcad002,xcadseq,
                 xcad003,xcad004,xcad005,xcad006,xcad007,xcad008,
                 xcad009,xcad010,xcad011,xcad012,xcad013,
                 'N',xcadownid,xcadowndp,xcadcrtid,xcadcrtdp,xcadcrtdt
            FROM axci004_tmp01      #160727-00019#20 Mod  axci004_01_ins_tmp--> axci004_tmp01          
   #END IF
   IF SQLCA.SQLCODE THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = "xcad_t"
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE                   
   END IF
   RETURN r_success
END FUNCTION
#
PRIVATE FUNCTION axci004_01_set_entry()
   IF g_xcad1_m.pbom= '1' THEN 
      CALL axci004_01_set_comp_entry("xcadsite1,bmaa002",TRUE)
      LET g_xcad1_m.xcad001_1 = ''
      LET g_xcad1_m.bmaa002 = ''
   ELSE
      CALL axci004_01_set_comp_entry("xcadsite1,bmaa002",FALSE)
   END IF 
   
   IF g_xcad1_m.standard = '1' THEN 
      CALL axci004_01_set_comp_entry("xcad001_1",TRUE)
      LET g_xcad1_m.xcadsite1 = ''
      LET g_xcad1_m.xcadsite1_desc = ''
   ELSE
      CALL axci004_01_set_comp_entry("xcad001_1",FALSE)
   END IF 
   DISPLAY BY NAME g_xcad1_m.xcadsite1_desc
END FUNCTION
#動態設定元件是否可輸入
PRIVATE FUNCTION axci004_01_set_comp_entry(ps_fields,pi_entry)
  DEFINE ps_fields STRING,
         pi_entry  LIKE type_t.num5           
  DEFINE lst_fields base.StringTokenizer,
         ls_field_name STRING
  DEFINE lwin_curr     ui.Window
  DEFINE lnode_win     om.DomNode,
         llst_items    om.NodeList,
         li_i          LIKE type_t.num5,        
         lnode_item    om.DomNode,
         ls_item_name  STRING

  IF g_bgjob = 'Y' AND g_gui_type NOT MATCHES "[13]"  THEN  
     RETURN
  END IF

  IF (ps_fields IS NULL) THEN
     RETURN
  END IF

  LET ps_fields = ps_fields.toLowerCase()

  LET lst_fields = base.StringTokenizer.create(ps_fields, ",")

  LET lwin_curr = ui.Window.getCurrent()
  LET lnode_win = lwin_curr.getNode()

  LET llst_items = lnode_win.selectByPath("//Form//*")

  WHILE lst_fields.hasMoreTokens()
    LET ls_field_name = lst_fields.nextToken()
    LET ls_field_name = ls_field_name.trim()

    IF (ls_field_name.getLength() > 0) THEN
       FOR li_i = 1 TO llst_items.getLength()
           LET lnode_item = llst_items.item(li_i)
           LET ls_item_name = lnode_item.getAttribute("colName")

           IF (ls_item_name IS NULL) THEN
              LET ls_item_name = lnode_item.getAttribute("name")

              IF (ls_item_name IS NULL) THEN
                 CONTINUE FOR
              END IF
           END IF

           LET ls_item_name = ls_item_name.trim()

           IF (ls_item_name.equals(ls_field_name)) THEN
              IF (pi_entry) THEN
                 CALL lnode_item.setAttribute("noEntry", "0")
                 CALL lnode_item.setAttribute("active", "1")
              ELSE
                 CALL lnode_item.setAttribute("noEntry", "1")
                 CALL lnode_item.setAttribute("active", "0")
              END IF

              EXIT FOR
           END IF
       END FOR
    END IF
  END WHILE
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
PRIVATE FUNCTION axci004_01_bom(p_level,p_xcad002,p_bmba002)
DEFINE p_level  LIKE type_t.num5
DEFINE p_xcad002 LIKE xcad_t.xcad003
DEFINE p_bmba002 LIKE bmba_t.bmba002
DEFINE i        LIKE type_t.num5
DEFINE l_cnt    LIKE type_t.num5
DEFINE l_n1     LIKE type_t.num5
DEFINE l_xcadcrtdt    LIKE xcad_t.xcadcrtdt
DEFINE l_bmba001_t    LIKE bmba_t.bmba001 #主件料号 用于记录旧值
DEFINE l_xcadseq      LIKE xcad_t.xcadseq  #add 141223
DEFINE l_xcadseq_1    LIKE xcad_t.xcadseq  #161130-00004#1 add
DEFINE l_xcadseq_2    LIKE xcad_t.xcadseq  #161130-00004#1 add

DEFINE sr DYNAMIC ARRAY OF RECORD
          x_level       LIKE type_t.num5,         #階數
          xcad002   LIKE xcad_t.xcad002,      #主件料號（本階主件）  
          xcadseq   LIKE xcad_t.xcadseq,      #add 141223      
          xcad003   LIKE xcad_t.xcad003,      #元件料號 
          xcad004   LIKE xcad_t.xcad004,      #組成用量
          xcad005   LIKE xcad_t.xcad005,
          xcad006   LIKE xcad_t.xcad006,
          xcad007   LIKE xcad_t.xcad007,
          xcad008   LIKE xcad_t.xcad008,
          xcad009   LIKE xcad_t.xcad009,
          xcad010   LIKE xcad_t.xcad010,
          xcad011   LIKE xcad_t.xcad011,
          xcad012   LIKE xcad_t.xcad012,
          xcad013   LIKE xcad_t.xcad013,
          xcadsite  LIKE xcad_t.xcadsite
          END RECORD

   LET p_level = p_level + 1
   LET l_xcadcrtdt = cl_get_current()

    IF g_xcad1_m.pbom = '1' THEN
       LET g_sql = " SELECT 0,bmba001,bmba009,bmba003,bmba011,bmba012,0,0,0,bmba007,bmba008,bmba004,bmba005,bmba006,bmbasite ",
                  #161130-00004#1 ---mark (s)---
                  #"   FROM bmba_t",
                  #"  WHERE bmbaent = '",g_enterprise,"'",
                  #161130-00004#1 ---mark (e)---
                  #161130-00004#1 ---add (s)---
                   "   FROM bmba_t,bmaa_t",
                   "  WHERE bmbaent = bmaaent AND bmba001 = bmaa001 AND bmbasite = bmaasite ",
                   "    AND bmaastus = 'Y' ",
                   "    AND (bmba006 IS NULL OR to_char(bmba006,'YY/MM/DD hh24:mi:ss')>'",g_today,"')",
                  #161130-00004#1 ---add (e)---
                   "    AND bmba002 = '",p_bmba002,"'",
                   "    AND bmba001 = '",p_xcad002,"'",
                   "    AND bmbasite = '",g_xcad1_m.xcadsite1,"'",
                  "  ORDER BY bmba001 "
    ELSE
       LET g_sql = " SELECT 0,xcad002,xcadseq,xcad003,xcad004,xcad005,xcad006,xcad007,xcad008,xcad009,xcad010,xcad011,xcad012,xcad013,xcadsite ",
                   "   FROM xcad_t",
                   "  WHERE xcadent = '",g_enterprise,"'",
                   "    AND xcad001 = '",g_xcad1_m.xcad001_1,"'",
                   "    AND xcad002 = '",p_xcad002,"'"
    END IF  #mod 141223 add xcadseq
    LET l_cnt = 1
    PREPARE axci004_pre3 FROM g_sql
    DECLARE axci004_cur3 CURSOR FOR axci004_pre3
    LET l_bmba001_t = ''
    LET l_xcadseq = 0  #add 141223
    FOREACH axci004_cur3 INTO sr[l_cnt].*
       IF SQLCA.sqlcode THEN
          INITIALIZE g_errparam TO NULL
          LET g_errparam.code = SQLCA.sqlcode
          LET g_errparam.extend = "foreach1:"
          LET g_errparam.popup = TRUE
          CALL cl_err()
          EXIT FOREACH
       END IF
       
       #檢查xcad_t裏面是否已存在需插入料件
       LET l_n1 = 0
       SELECT COUNT(*) INTO l_n1 FROM axci004_tmp01            #160727-00019#20 Mod  axci004_01_ins_tmp--> axci004_tmp01 
        WHERE xcadent = g_enterprise
          AND xcad001 = g_xcad_m.xcad001 AND xcad002 = sr[l_cnt].xcad002
          AND xcad003 = sr[l_cnt].xcad003
         #161130-00004#1 ---add (s)---
          AND xcad009 = sr[l_cnt].xcad009 AND xcad010 = sr[l_cnt].xcad010
          AND xcad011 = sr[l_cnt].xcad011 AND xcad012 = sr[l_cnt].xcad012
          AND xcad013 = sr[l_cnt].xcad013
         #161130-00004#1 ---add (e)---
       IF l_n1 > 0 THEN
          CONTINUE FOREACH
       END IF
       
       #檢查xcad_t裏面是否已存在需插入料件
       LET l_n1 = 0
       SELECT COUNT(*) INTO l_n1 FROM xcad_t
        WHERE xcadent = g_enterprise
          AND xcad001 = g_xcad_m.xcad001 AND xcad002 = sr[l_cnt].xcad002
          AND xcad003 = sr[l_cnt].xcad003
         #161130-00004#1 ---add (s)---
          AND xcad009 = sr[l_cnt].xcad009 AND xcad010 = sr[l_cnt].xcad010
          AND xcad011 = sr[l_cnt].xcad011 AND xcad012 = sr[l_cnt].xcad012
          AND xcad013 = sr[l_cnt].xcad013
         #161130-00004#1 ---add (e)---
       IF l_n1 > 0 THEN
          CONTINUE FOREACH
       END IF
       
       #add 141223
       IF g_xcad1_m.pbom = '1' THEN
          #IF cl_null(l_bmba001_t) OR l_bmba001_t!=sr[l_cnt].xcad002 THEN
          #   #LET l_xcadseq = 0
          #END IF
          LET l_xcadseq = l_xcadseq + 1
          #LET l_bmba001_t = sr[l_cnt].xcad002
          LET sr[l_cnt].xcadseq = l_xcadseq
       END IF
       #add 141223 end

       LET l_cnt = l_cnt + 1
    END FOREACH

    LET l_bmba001_t = ''    #161130-00004#1 add
    LET l_cnt = l_cnt - 1   #161130-00004#1 add
    IF l_cnt > 0 THEN       #161130-00004#1 add
      #FOR i = 1 TO l_cnt-1 #161130-00004#1 mark
       FOR i = 1 TO l_cnt   #161130-00004#1 add
           LET sr[i].x_level = p_level
           ##檢查xcad_t裏面是否已存在需插入料件
           #LET l_n1 = 0
           #SELECT COUNT(*) INTO l_n1 FROM axci004_01_ins_tmp 
           # WHERE xcadent = g_enterprise
           #   AND xcad001 = g_xcad_m.xcad001 AND xcad002 = sr[i].xcad002
           #   AND xcad003 = sr[i].xcad003
           #IF l_n1 > 0 THEN
           #   CONTINUE FOR
           #END IF
           #
           ##檢查xcad_t裏面是否已存在需插入料件
           #LET l_n1 = 0
           #SELECT COUNT(*) INTO l_n1 FROM xcad_t
           # WHERE xcadent = g_enterprise
           #   AND xcad001 = g_xcad_m.xcad001 AND xcad002 = sr[i].xcad002
           #   AND xcad003 = sr[i].xcad003
           #IF l_n1 > 0 THEN
           #   CONTINUE FOR
           #END IF
           
          #161130-00004#1 ---add (s)---
           IF g_xcad1_m.pbom = '1' THEN
              SELECT MAX(xcadseq) INTO l_xcadseq_1 FROM xcad_t
               WHERE xcadent = g_enterprise
                 AND xcad001 = g_xcad_m.xcad001 AND xcad002 = sr[i].xcad002
              IF cl_null(l_xcadseq_1) THEN LET l_xcadseq_1 = 0 END IF 
             
              SELECT MAX(xcadseq) INTO l_xcadseq_2 FROM axci004_tmp01
               WHERE xcadent = g_enterprise
                 AND xcad001 = g_xcad_m.xcad001 AND xcad002 = sr[i].xcad002 
              IF cl_null(l_xcadseq_2) THEN LET l_xcadseq_2 = 0 END IF
             
              IF l_xcadseq_1 >= l_xcadseq_2 THEN
                 LET l_xcadseq = l_xcadseq_1
              ELSE
                 LET l_xcadseq = l_xcadseq_2
              END IF
               
              LET l_xcadseq = l_xcadseq + 1
              LET sr[i].xcadseq = l_xcadseq
           END IF
           LET l_bmba001_t = sr[i].xcad002 
           LET sr[i].xcadseq = l_xcadseq
          #161130-00004#1 ---add (e)---
           
           #mod 141223 add xcadseq
           INSERT INTO axci004_tmp01(x_level,xcadent,xcad001,xcadsite,xcad002,xcadseq,             #160727-00019#20 Mod  axci004_01_ins_tmp--> axci004_tmp01
                                          xcad003,xcad004,xcad005,xcad006,xcad007,xcad008,
                                          xcad009,xcad010,xcad011,xcad012,xcad013,
                                          xcadstus,xcadownid,xcadowndp,xcadcrtid,xcadcrtdp,xcadcrtdt)
                      VALUES(p_level,g_enterprise,g_xcad_m.xcad001,sr[i].xcadsite,sr[i].xcad002,sr[i].xcadseq,
                             sr[i].xcad003,sr[i].xcad004,sr[i].xcad005,sr[i].xcad006,sr[i].xcad007,sr[i].xcad008,
                             sr[i].xcad009,sr[i].xcad010,sr[i].xcad011,sr[i].xcad012,sr[i].xcad013,
                             'N',g_user,g_dept,g_user,g_dept,l_xcadcrtdt)
           IF SQLCA.sqlcode THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = SQLCA.sqlcode
              LET g_errparam.extend = "ins xcad_t"
              LET g_errparam.popup = TRUE
              CALL cl_err()
       
           END IF
           IF NOT cl_null(sr[i].xcad003) THEN #若為主件料號
              CALL axci004_01_bom(p_level,sr[i].xcad003,p_bmba002)
           END IF
       END FOR
    END IF #161130-00004#1 add
END FUNCTION

################################################################################
# Descriptions...: 创建临时表
# Memo...........:
# Usage..........: CALL axci004_01_create()
# Input parameter: 
# Return code....: r_success
# Date & Author..: 日期 By 作者
# Modify.........: 
################################################################################
PUBLIC FUNCTION axci004_01_create()
   DEFINE r_success    LIKE type_t.num5
   DEFINE l_success    LIKE type_t.num5

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   
   #检查事务中
   IF NOT s_transaction_chk('N',1) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   CALL axci004_01_drop() RETURNING l_success
   IF NOT l_success THEN
      LET r_success = FALSE
      RETURN r_success
   END IF
   CREATE TEMP TABLE axci004_tmp01         
         (x_level   LIKE type_t.num10, 
          xcadent   LIKE xcad_t.xcadent,
          xcad001   LIKE xcad_t.xcad001,
          xcadsite  LIKE xcad_t.xcadsite,             
          xcad002   LIKE xcad_t.xcad002,
          xcadseq   LIKE xcad_t.xcadseq, #add 141223
          xcad003   LIKE xcad_t.xcad003,
          xcad004   LIKE xcad_t.xcad004,
          xcad005   LIKE xcad_t.xcad005,
          xcad006   LIKE xcad_t.xcad006,
          xcad007   LIKE xcad_t.xcad007,
          xcad008   LIKE xcad_t.xcad008,
          xcad009   LIKE xcad_t.xcad009,
          xcad010   LIKE xcad_t.xcad010,
          xcad011   LIKE xcad_t.xcad011,
          xcad012   LIKE xcad_t.xcad012,
          xcad013   LIKE xcad_t.xcad013,
          xcadstus  LIKE xcad_t.xcadstus,
          xcadownid LIKE xcad_t.xcadownid,
          xcadowndp LIKE xcad_t.xcadowndp,
          xcadcrtid LIKE xcad_t.xcadcrtid,
          xcadcrtdp LIKE xcad_t.xcadcrtdp,
          xcadcrtdt LIKE xcad_t.xcadcrtdt   
          );
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'create axci004_tmp01'          #160727-00019#20 Mod  axci004_01_ins_tmp--> axci004_tmp01
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET r_success = FALSE
      RETURN r_success
   END IF
   create index idx_axci004_tmp_01 on axci004_tmp01(xcadent, xcad001, xcad002) #161130-00004#1 add
   IF cl_db_generate_analyze("axci004_tmp01") THEN END IF                      #161130-00004#1 add

   RETURN r_success
END FUNCTION

################################################################################
# Descriptions...: 删除临时表
# Memo...........:
# Usage..........: CALL axci004_01_drop()
# Input parameter: 
# Return code....: 
# Date & Author..: 14/12/17 By zhanglllc
# Modify.........:
################################################################################
PUBLIC FUNCTION axci004_01_drop()
   DEFINE r_success    LIKE type_t.num5

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   
   #检查事务中
   IF NOT s_transaction_chk('N',1) THEN
      LET r_success = FALSE
      RETURN r_success
   END IF

   DROP TABLE axci004_tmp01;         #160727-00019#20 Mod  axci004_01_ins_tmp--> axci004_tmp01
   RETURN r_success
END FUNCTION

 
{</section>}
 
