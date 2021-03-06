#該程式未解開Section, 採用最新樣板產出!
{<section id="axci003_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0004(2014-01-27 16:44:44), PR版次:0004(2016-12-16 09:24:41)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000248
#+ Filename...: axci003_01
#+ Description: 資源標準費率引入作業
#+ Creator....: 02114(2013-09-27 17:42:11)
#+ Modifier...: 02291 -SD/PR- 08734
 
{</section>}
 
{<section id="axci003_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160318-00005#45  2016/03/26  By pengxin    修正azzi920重复定义之错误讯息
#161124-00048#16  2016/12/16  By 08734      星号整批调整
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
PRIVATE type type_g_xcac_m        RECORD
       xcac001 LIKE xcac_t.xcac001, 
   excel LIKE type_t.chr500, 
   way LIKE type_t.chr500, 
   standard LIKE type_t.chr500, 
   xcac001_1 LIKE type_t.chr500
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_sql   STRING 
#end add-point
 
DEFINE g_xcac_m        type_g_xcac_m
 
   DEFINE g_xcac001_t LIKE xcac_t.xcac001
 
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="axci003_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION axci003_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_xcac001
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
   DEFINE p_xcacsite      LIKE xcac_t.xcacsite
   DEFINE p_xcac001       LIKE xcac_t.xcac001
   DEFINE l_excel         STRING 
   DEFINE ls_str          STRING
   DEFINE l_chr           LIKE type_t.chr1   
   DEFINE l_chr1          LIKE type_t.chr1   
   DEFINE l_num           LIKE type_t.num5
   DEFINE l_success       LIKE type_t.num5
   DEFINE l_n             LIKE type_t.num5
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_axci003_01 WITH FORM cl_ap_formpath("axc","axci003_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   LET g_xcac_m.xcac001  = p_xcac001
   LET g_xcac_m.excel = 'N'
   LET g_xcac_m.standard = 'N'
   LET g_xcac_m.xcac001_1 = ''
   LET g_xcac_m.way = ''
   DISPLAY BY NAME g_xcac_m.xcac001_1,g_xcac_m.way
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_xcac_m.xcac001,g_xcac_m.excel,g_xcac_m.way,g_xcac_m.standard,g_xcac_m.xcac001_1  
          ATTRIBUTE(WITHOUT DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            LET g_xcac_m.excel = ''
            LET g_xcac_m.standard = '1'
            CALL axci003_01_set_entry()
            #end add-point
          
                  #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcac001
            #add-point:BEFORE FIELD xcac001 name="input.b.xcac001"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcac001
            
            #add-point:AFTER FIELD xcac001 name="input.a.xcac001"
            #此段落由子樣板a05產生
            #IF  NOT cl_null(g_xcac_m.xcac001) AND NOT cl_null(g_xcac_m.xcac002) THEN 
            #   IF p_cmd = 'a' OR ( p_cmd = 'u' AND ( p_cmd = 'u' AND (g_xcac_m.xcac001 != g_xcac001_t  OR g_xcac_m.xcac002 != g_xcac002_t ))) THEN 
            #      IF NOT ap_chk_notDup("","SELECT COUNT(*) FROM xcac_t WHERE "||"xcacent = '" ||g_enterprise|| "' AND "||"xcac001 = '"||g_xcac_m.xcac001 ||"' AND "|| "xcac002 = '"||g_xcac_m.xcac002 ||"'",'std-00004',0) THEN 
            #         NEXT FIELD CURRENT
            #      END IF
            #   END IF
            #END IF



            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcac001
            #add-point:ON CHANGE xcac001 name="input.g.xcac001"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD excel
            #add-point:BEFORE FIELD excel name="input.b.excel"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD excel
            
            #add-point:AFTER FIELD excel name="input.a.excel"
            IF g_xcac_m.excel = 1 THEN
               LET g_xcac_m.standard = NULL
            END IF
            CALL axci003_01_set_entry()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE excel
            #add-point:ON CHANGE excel name="input.g.excel"
            IF g_xcac_m.excel = 1 THEN
               LET g_xcac_m.standard = NULL
            END IF
            CALL axci003_01_set_entry()
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD way
            #add-point:BEFORE FIELD way name="input.b.way"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD way
            
            #add-point:AFTER FIELD way name="input.a.way"
            
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE way
            #add-point:ON CHANGE way name="input.g.way"
            
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD standard
            #add-point:BEFORE FIELD standard name="input.b.standard"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD standard
            
            #add-point:AFTER FIELD standard name="input.a.standard"
            IF g_xcac_m.standard = 1 THEN
               LET g_xcac_m.excel = NULL
            END IF
            CALL axci003_01_set_entry()
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE standard
            #add-point:ON CHANGE standard name="input.g.standard"
            IF g_xcac_m.standard = 1 THEN
               LET g_xcac_m.excel = NULL
            END IF
            CALL axci003_01_set_entry()
            #END add-point 
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD xcac001_1
            #add-point:BEFORE FIELD xcac001_1 name="input.b.xcac001_1"
            
            #END add-point
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD xcac001_1
            
            #add-point:AFTER FIELD xcac001_1 name="input.a.xcac001_1"
            IF NOT cl_null(g_xcac_m.xcac001_1) THEN
               LET l_n = 0
               SELECT COUNT(*) INTO l_n FROM xcac_t 
                WHERE xcacent = g_enterprise AND xcac001 = g_xcac_m.xcac001_1
               IF l_n = 0 THEN
                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = 'axc-00045'   #160318-00005#45  mark
                  LET g_errparam.code = 'sub-01308'   #160318-00005#45  add
                  LET g_errparam.extend = ''
                  #160318-00005#45 --s add
                  LET g_errparam.replace[1] = 'axci003'
                  LET g_errparam.replace[2] = cl_get_progname('axci003',g_lang,"2")
                  LET g_errparam.exeprog = 'axci003'
                  #160318-00005#45 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD xcac001_1
               END IF
               LET l_n=0
               SELECT COUNT(*) INTO l_n FROM xcac_t 
                WHERE xcacent = g_enterprise AND xcac001 = g_xcac_m.xcac001_1 AND xcacstus = 'Y'
               IF l_n = 0 THEN
                  INITIALIZE g_errparam TO NULL
#                  LET g_errparam.code = 'axc-00044'   #160318-00005#45  mark
                  LET g_errparam.code = 'sub-01302'   #160318-00005#45  add
                  LET g_errparam.extend = ''
                  #160318-00005#45 --s add
                  LET g_errparam.replace[1] = 'axci003'
                  LET g_errparam.replace[2] = cl_get_progname('axci003',g_lang,"2")
                  LET g_errparam.exeprog = 'axci003'
                  #160318-00005#45 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  NEXT FIELD xcac001_1
               END IF
            END IF
            #END add-point
            
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE xcac001_1
            #add-point:ON CHANGE xcac001_1 name="input.g.xcac001_1"
 
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.xcac001
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcac001
            #add-point:ON ACTION controlp INFIELD xcac001 name="input.c.xcac001"
            
            #END add-point
 
 
         #Ctrlp:input.c.excel
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD excel
            #add-point:ON ACTION controlp INFIELD excel name="input.c.excel"
            
            #END add-point
 
 
         #Ctrlp:input.c.way
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD way
            #add-point:ON ACTION controlp INFIELD way name="input.c.way"
            
            #END add-point
 
 
         #Ctrlp:input.c.standard
#         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD standard
            #add-point:ON ACTION controlp INFIELD standard name="input.c.standard"
            
            #END add-point
 
 
         #Ctrlp:input.c.xcac001_1
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD xcac001_1
            #add-point:ON ACTION controlp INFIELD xcac001_1 name="input.c.xcac001_1"
#此段落由子樣板a07產生            
            #開窗i段
			INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
			LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_xcac_m.xcac001_1             #給予default值
            LET g_qryparam.where = " xcacstus = 'Y'"

            #給予arg

            CALL q_xcac001()                                #呼叫開窗

            LET g_xcac_m.xcac001_1 = g_qryparam.return1              #將開窗取得的值回傳到變數

            DISPLAY g_xcac_m.xcac001_1 TO xcac001_1              #顯示到畫面上
            LET g_qryparam.where = null

            NEXT FIELD xcac001_1                          #返回原欄位


            #END add-point
 
 
 #欄位開窗
 
         AFTER INPUT
            #add-point:單頭輸入後處理 name="input.after_input"
            
            #end add-point
            
      END INPUT
    
      #add-point:自定義input name="input.more_input"
      ON ACTION browser
         CALL cl_client_browse_dir() RETURNING g_xcac_m.way
         LET ls_str = g_xcac_m.way
         #抓取目录斜杆
         LET l_num =ls_str.getIndexOf(':',1)                                    #抓取：后的字符位置
         LET l_chr = ls_str.substring(l_num+1,l_num+1)                        #截取冒号后的字符 
         LET l_chr1 = ls_str.substring(ls_str.getLength(),ls_str.getLength())    #判断是否为根目录
         IF l_chr <> l_chr1  THEN         
            LET g_xcac_m.way = g_xcac_m.way||l_chr||"axci003_01.xlsx"
         ELSE
            LET g_xcac_m.way = g_xcac_m.way||"axci003_01.xlsx"
         END IF 
         DISPLAY BY NAME g_xcac_m.way
         
      ON ACTION download
          IF g_xcac_m.excel = 1 THEN         
             LET g_bgjob = 'Y'                  #add-mpp      
             LET status =  cl_client_download_file("$RES/std/axci003_01.xlsx",g_xcac_m.way) 
             IF status THEN
                ERROR "Download OK!!"
             ELSE
                ERROR "Download fail!!"
             END IF
          ELSE
             INITIALIZE g_errparam TO NULL
             LET g_errparam.code = 'aoo-00192'
             LET g_errparam.extend = ''
             LET g_errparam.popup = FALSE
             CALL cl_err()

             NEXT FIELD way            
          END IF    
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
   CLOSE WINDOW w_axci003_01 
   
   #add-point:input段after input name="input.post_input"
   LET l_success = FALSE  
   IF INT_FLAG THEN
      LET l_success = FALSE
   ELSE
      #确定
      IF g_xcac_m.excel = '1' THEN
         CALL axci003_01_ins_f_excel(g_xcac_m.way) RETURNING l_success
      ELSE
         CALL axci003_01_ins_f_xcac() RETURNING l_success
      END IF
   END IF
   LET INT_FLAG = FALSE
   RETURN l_success   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="axci003_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="axci003_01.other_function" readonly="Y" >}
#+ xcacsite欄位檢查
PRIVATE FUNCTION axci003_01_xcacsite_chk(p_xcacsite)
DEFINE l_n          LIKE type_t.num5 
DEFINE p_xcacsite   LIKE xcac_t.xcacsite

   LET g_errno = ''
   #輸入值須存在[T:组织档]
   LET l_n = 0 
   SELECT count(*) INTO l_n 
     FROM ooef_t
    WHERE ooef001 = p_xcacsite
      AND ooefent = g_enterprise
   IF l_n = 0 THEN 
      LET g_errno = 'axc-00005'
      RETURN                        
   END IF
   #輸入值須在[T:组织档]里有效
   LET l_n = 0 
   SELECT count(*) INTO l_n 
     FROM ooef_t
    WHERE ooef001 = p_xcacsite
      AND ooefent = g_enterprise
      AND ooefstus = 'Y'
   IF l_n = 0 THEN 
      LET g_errno = 'axc-00006'
      RETURN   
   END IF 
   #輸入值須在[T:组织档]里為"法人組織"or"营运組織否"or"核算組織否"
   LET l_n = 0 
   SELECT count(*) INTO l_n 
     FROM ooef_t
    WHERE ooef001 = p_xcacsite
      AND ooefent = g_enterprise
      AND (ooef003 = 'Y' OR ooef201 = 'Y' OR ooef202 = 'Y' )
   IF l_n = 0 THEN 
      LET g_errno = 'axc-00058'
      RETURN   
   END IF
   #輸入值須在版本的營運據點
   LET l_n = 0 
   SELECT count(*) INTO l_n 
     FROM xcac_t
    WHERE xcacsite = p_xcacsite AND xcac001 = g_xcac_m.xcac001_1
      AND xcacent = g_enterprise
   IF l_n = 0 THEN 
#      LET g_errno = 'axc-00079'  #160318-00005#45  mark
      LET g_errno = 'sub-01333'  #160318-00005#45  add
      RETURN   
   END IF
   #輸入值須在已確認的當前版本的營運據點
   LET l_n = 0 
   SELECT count(*) INTO l_n 
     FROM xcac_t
    WHERE xcacsite = p_xcacsite AND xcac001 = g_xcac_m.xcac001_1
      AND xcacent = g_enterprise
      AND xcacstus = 'Y'
   IF l_n = 0 THEN 
      LET g_errno = 'axc-00078'
      RETURN   
   END IF    
END FUNCTION
#+ 從excel匯入
PRIVATE FUNCTION axci003_01_ins_f_excel(p_excelname)
DEFINE p_excelname LIKE type_t.chr1000  #excel档名
DEFINE r_success   LIKE type_t.num5
DEFINE l_excelname STRING               #excel档名
DEFINE l_count     LIKE type_t.num10
DEFINE li_i        LIKE type_t.num10
DEFINE li_j        LIKE type_t.num10
DEFINE xlapp,iRes,iRow    LIKE type_t.num5
#DEFINE l_xcac      RECORD LIKE xcac_t.*  #161124-00048#16  2016/12/16  By 08734 mark
#161124-00048#16  2016/12/16  By 08734 add(S)
DEFINE l_xcac RECORD  #資源標準費率檔
       xcacent LIKE xcac_t.xcacent, #企业编号
       xcacownid LIKE xcac_t.xcacownid, #资料所有者
       xcacowndp LIKE xcac_t.xcacowndp, #资料所有部门
       xcaccrtid LIKE xcac_t.xcaccrtid, #资料录入者
       xcaccrtdp LIKE xcac_t.xcaccrtdp, #资料录入部门
       xcaccrtdt LIKE xcac_t.xcaccrtdt, #资料创建日
       xcacmodid LIKE xcac_t.xcacmodid, #资料更改者
       xcacmoddt LIKE xcac_t.xcacmoddt, #最近更改日
       xcacstus LIKE xcac_t.xcacstus, #状态码
       xcacsite LIKE xcac_t.xcacsite, #营运据点
       xcac001 LIKE xcac_t.xcac001, #版本
       xcac002 LIKE xcac_t.xcac002, #资源编码
       xcac003 LIKE xcac_t.xcac003, #成本主要素
       xcac004 LIKE xcac_t.xcac004, #成本次要素
       xcac005 LIKE xcac_t.xcac005, #币种
       xcac006 LIKE xcac_t.xcac006 #标准费率
END RECORD
#161124-00048#16  2016/12/16  By 08734 add(E)
DEFINE l_xcaccrtdt DATETIME YEAR TO SECOND
DEFINE l_today     LIKE type_t.dat       #zll g_today 没有了
DEFINE l_dzeb003   LIKE dzeb_t.dzeb003
DEFINE l_xcacstus  LIKE xcac_t.xcacstus
DEFINE l_n         LIKE type_t.num5

   WHENEVER ERROR CONTINUE
   LET r_success = TRUE

   LET l_xcacstus = ''
   SELECT unique xcacstus INTO l_xcacstus FROM xcac_t WHERE xcacent = g_enterprise AND xcac001 = g_xcac_m.xcac001
   IF l_xcacstus = 'Y' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axc-00010'
      LET g_errparam.extend = ''
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE
      RETURN r_success
   END IF
   LET l_today= cl_get_current()
   LET l_count = LENGTH(p_excelname CLIPPED)
   #转换路径分隔符
   FOR li_i = 1 TO l_count
       IF p_excelname[li_i,li_i] ="/" THEN
          LET l_excelname = l_excelname CLIPPED,'\\'
       ELSE
          LET l_excelname = l_excelname CLIPPED,p_excelname[li_i,li_i]
       END IF
   END FOR

   CALL ui.interface.frontCall('WinCOM','CreateInstance',
                               ['Excel.Application'],[xlApp])
   IF xlApp <> -1 THEN
      CALL ui.interface.frontCall('WinCOM','CallMethod',
                                  [xlApp,'WorkBooks.Open',l_excelname],[iRes])
      IF iRes <> -1 THEN
         CALL ui.interface.frontCall('WinCOM','GetProperty',
              [xlApp,'ActiveSheet.UsedRange.Rows.Count'],[iRow])
         IF iRow > 1 THEN
            FOR li_i = 2 TO iRow
                INITIALIZE l_xcac.* TO NULL
                select dzeb003 INTO l_dzeb003 from dzeb_t where dzeb001 = 'xcac_t' AND dzeb002 = 'xcacent'
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',1).Value'],[l_xcac.xcac002])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',2).Value'],[l_xcac.xcac003])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',3).Value'],[l_xcac.xcac004])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',4).Value'],[l_xcac.xcac005])
                CALL ui.interface.frontCall('WinCOM','GetProperty',[xlApp,'ActiveSheet.Cells('||li_i||',5).Value'],[l_xcac.xcac006])
  
                LET l_xcac.xcac001 = g_xcac_m.xcac001
                LET l_xcac.xcacent = g_enterprise
                #若營運據點欄位無值，那麼抓資源代號下營運據點
                IF cl_null(l_xcac.xcacsite) THEN
                   SELECT mrbasite INTO l_xcac.xcacsite FROM mrba_t 
                    WHERE mrbaent = g_enterprise AND mrba001 = l_xcac.xcac002
                END IF
#                IF NOT cl_null(l_xcac.xcacent) THEN
#                   #zll 以后需修改成遇到错误整体汇总的方式最后一起显示，失败继续执行 用CONTINUE FOE
#                   #zll 暂时是遇挫就失败跳出 用EXIT FOR
#
#                   #关键字检查
#                   IF cl_null(l_xcac.xcac001) OR cl_null(l_xcac.xcac002) THEN
#                      #数据缺失，请检查excel中是否有漏维护
#                      CALL cl_err('','sub-00059',1)
#                      LET r_success = FALSE
#                      EXIT FOR
#                   END IF                 
#                   
#                  IF NOT cl_null(l_xcac.xcac004) THEN
#                     #檢查成本次要素是否存在
#                     IF NOT ap_chk_isExist(l_xcac.xcac004,"SELECT COUNT(*) FROM xcau_t WHERE xcauent = '"
#                        ||g_enterprise||"' AND xcau001 = ? ","axc-00055",1 ) THEN
#                        LET r_success = FALSE
#                        EXIT FOR
#                     END IF
#                     #檢查成本次要素是否有效
#                     IF NOT ap_chk_isExist(l_xcac.xcac004,"SELECT COUNT(*) FROM xcau_t WHERE xcauent = '"
#                        ||g_enterprise||"' AND xcau001 = ? AND xcaustus = 'Y' ","axc-00056",1 ) THEN
#                        LET r_success = FALSE
#                        EXIT FOR
#                     END IF
#                  ELSE
#                     CALL cl_err('','axc-00215',1)
#                     LET r_success = FALSE
#                     EXIT FOR
#                  END IF
#                  #成本主要素不能为1.直接材料
#                  IF NOT cl_null(l_xcac.xcac003) THEN
#                     IF l_xcac.xcac003 = 1 THEN
#                        CALL cl_err('','axc-00206',1)
#                        LET r_success = FALSE
#                        EXIT FOR
#                     END IF
#                  ELSE
#                     CALL cl_err('','axc-00214',1)
#                     LET r_success = FALSE
#                     EXIT FOR
#                  END IF
#
#
#                   #币别检查
#                   SELECT COUNT(*) INTO l_count FROM ooai_t
#                    WHERE ooaient = g_enterprise
#                      AND ooai001 = l_xcac.xcac005
#                      AND ooaistus='Y'
#                   IF l_count < 1 THEN
#                      #excel中有不合法币别，请检查币别档是否有缺失或excel中是否正确
#                      CALL cl_err('','sub-00062',1)
#                      LET r_success = FALSE
#                      EXIT FOR
#                   END IF
                   
                   LET l_n = 0 
                   SELECT count(*) INTO l_n 
                     FROM xcac_t
                    WHERE xcacent = g_enterprise
                      AND xcac001 = l_xcac.xcac001
                      AND xcac002 = l_xcac.xcac002
                   IF l_n > 0 THEN 
                      CONTINUE FOR
                   END IF

                   #赋默认值
                   LET l_xcac.xcacownid = g_user
                   LET l_xcac.xcacowndp = g_dept
                   LET l_xcac.xcaccrtid = g_user
                   LET l_xcac.xcaccrtdp = g_dept 
                   LET l_xcaccrtdt = cl_get_current()
                   LET l_xcac.xcacstus = 'N'
                   
                  INSERT INTO xcac_t(xcacent,xcacstus,xcacsite,xcac001,xcac002,xcac003,xcac004,xcac005,xcac006,xcacownid,xcacowndp,xcaccrtid,xcaccrtdp,xcaccrtdt)
                  VALUES(g_enterprise,'N',l_xcac.xcacsite,l_xcac.xcac001,l_xcac.xcac002,
                         l_xcac.xcac003,l_xcac.xcac004,l_xcac.xcac005,l_xcac.xcac006,
                         g_user,g_dept,g_user,g_dept,l_xcaccrtdt)
                   IF SQLCA.sqlcode THEN
                      INITIALIZE g_errparam TO NULL
                      LET g_errparam.code = SQLCA.sqlcode
                      LET g_errparam.extend = 'ins xcac'
                      LET g_errparam.popup = FALSE
                      CALL cl_err()

                      LET r_success = FALSE
                      EXIT FOR
                   END IF
#               END IF
            END FOR
         END IF
      ELSE
         INITIALIZE g_errparam TO NULL
         LET g_errparam.code = ''
         LET g_errparam.extend = 'NO FILE'
         LET g_errparam.popup = FALSE
         CALL cl_err()

         LET r_success = FALSE
      END IF
   ELSE
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = ''
      LET g_errparam.extend = 'NO EXCEL'
      LET g_errparam.popup = FALSE
      CALL cl_err()

      LET r_success = FALSE
   END IF

   CALL ui.interface.frontCall('WinCOM','CallMethod',[xlApp,'Quit'],[iRes])
   CALL ui.interface.frontCall('WinCOM','ReleaseInstance',[xlApp],[iRes])

   RETURN r_success
END FUNCTION
#+ 来自于资源标准费率维护作业之已确认数据
PRIVATE FUNCTION axci003_01_ins_f_xcac()
DEFINE r_success   LIKE type_t.num5
DEFINE l_n         LIKE type_t.num5
DEFINE l_xcac      RECORD
          xcac002 LIKE xcac_t.xcac002, 
          xcac003 LIKE xcac_t.xcac003,
          xcac004 LIKE xcac_t.xcac004, 
          xcac005 LIKE xcac_t.xcac005, 
          xcac006 LIKE xcac_t.xcac006,
          xcacsite LIKE xcac_t.xcacsite          
       END RECORD
DEFINE l_xcaccrtdt    DATETIME YEAR TO SECOND
DEFINE l_n2           LIKE type_t.num5
DEFINE l_stus         LIKE xcac_t.xcacstus
       
   WHENEVER ERROR CONTINUE
   LET r_success = TRUE
   SELECT UNIQUE xcacstus INTO l_stus FROM xcac_t
    WHERE xcacent = g_enterprise AND xcac001 = g_xcac_m.xcac001
   IF l_stus = 'Y' THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axc-00082'
      LET g_errparam.extend = g_xcac_m.xcac001
      LET g_errparam.popup = TRUE
      CALL cl_err()

      LET r_success = FALSE 
   END IF
   LET l_n2 = 0 
   LET l_xcaccrtdt = cl_get_current()
   
   LET g_sql = "SELECT xcac002,xcac003,xcac004,xcac005,xcac006,xcacsite ",
               "  FROM xcac_t",
               " WHERE xcacent = '",g_enterprise,"'",
               "   AND xcac001 = '",g_xcac_m.xcac001_1,"'",
               "   AND xcacstus = 'Y' " 
   PREPARE axci003_01_pre FROM g_sql
   DECLARE axci003_01_cur CURSOR FOR axci003_01_pre
   FOREACH axci003_01_cur INTO l_xcac.*
      LET l_n = 0 
      SELECT count(*) INTO l_n 
        FROM xcac_t
       WHERE xcacent = g_enterprise
         AND xcac001 = g_xcac_m.xcac001
         AND xcac002 = l_xcac.xcac002
      IF l_n > 0 THEN 
         CONTINUE FOREACH 
      END IF 
      LET l_n2 = 1   #判斷是否有數據
      INSERT INTO xcac_t(xcacent,xcacstus,xcacsite,xcac001,xcac002,xcac003,xcac004,xcac005,xcac006,xcacownid,xcacowndp,xcaccrtid,xcaccrtdp,xcaccrtdt)
                  VALUES(g_enterprise,'N',l_xcac.xcacsite,g_xcac_m.xcac001,l_xcac.xcac002,
                         l_xcac.xcac003,l_xcac.xcac004,l_xcac.xcac005,l_xcac.xcac006,
                         g_user,g_dept,g_user,g_dept,l_xcaccrtdt)

   END FOREACH 
   IF SQLCA.sqlcode THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = SQLCA.sqlcode
      LET g_errparam.extend = 'ins xcac'
      LET g_errparam.popup = FALSE
      CALL cl_err()

      LET r_success = FALSE
   END IF
   IF l_n2 = 0 THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'axc-00098'
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
 
      LET r_success = FALSE
   END IF
   RETURN r_success
END FUNCTION
#動態設定元件是否可輸入
PRIVATE FUNCTION axci003_01_set_comp_entry(ps_fields,pi_entry)
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
#欄位設置
PRIVATE FUNCTION axci003_01_set_entry()
   CALL axci003_01_set_comp_entry("way,xcac001_1",FALSE)
   CALL cl_set_act_visible("download,browser", FALSE)
   
   IF g_xcac_m.standard = '1' THEN 
      CALL axci003_01_set_comp_entry("xcac001_1",TRUE)
      LET g_xcac_m.way = ''
   ELSE
      CALL axci003_01_set_comp_entry("xcac001_1",FALSE)
   END IF 
   
   IF g_xcac_m.excel = '1' THEN 
      CALL axci003_01_set_comp_entry("way",TRUE)
      CALL cl_set_act_visible("download,browser",TRUE)
      LET g_xcac_m.xcac001_1 = ''
   ELSE
      CALL axci003_01_set_comp_entry("way",FALSE)
      CALL cl_set_act_visible("download,browser", FALSE)
   END IF 
END FUNCTION

 
{</section>}
 
