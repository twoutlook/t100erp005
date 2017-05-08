#該程式未解開Section, 採用最新樣板產出!
{<section id="abgt020_01.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0002(2015-11-30 17:38:49), PR版次:0002(2016-03-21 10:29:20)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000149
#+ Filename...: abgt020_01
#+ Description: 自由維度維護
#+ Creator....: 02298()
#+ Modifier...: 01727 -SD/PR- 06821
 
{</section>}
 
{<section id="abgt020_01.global" >}
#應用 c01b 樣板自動產生(Version:10)
#add-point:填寫註解說明 name="global.memo"
#160318-00005#5  160321 By Jessy 修正azzi920重複定義之錯誤訊息
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
PRIVATE type type_g_bgaz_m        RECORD
       bgaz028 LIKE bgaz_t.bgaz028, 
   bgaz028_desc LIKE type_t.chr80, 
   bgaz033 LIKE bgaz_t.bgaz033, 
   bgaz033_desc LIKE type_t.chr80, 
   bgaz029 LIKE bgaz_t.bgaz029, 
   bgaz029_desc LIKE type_t.chr80, 
   bgaz034 LIKE bgaz_t.bgaz034, 
   bgaz034_desc LIKE type_t.chr80, 
   bgaz030 LIKE bgaz_t.bgaz030, 
   bgaz030_desc LIKE type_t.chr80, 
   bgaz035 LIKE bgaz_t.bgaz035, 
   bgaz035_desc LIKE type_t.chr80, 
   bgaz031 LIKE bgaz_t.bgaz031, 
   bgaz031_desc LIKE type_t.chr80, 
   bgaz036 LIKE bgaz_t.bgaz036, 
   bgaz036_desc LIKE type_t.chr80, 
   bgaz032 LIKE bgaz_t.bgaz032, 
   bgaz032_desc LIKE type_t.chr80, 
   bgaz037 LIKE bgaz_t.bgaz037, 
   bgaz037_desc LIKE type_t.chr80
       END RECORD
	   
#add-point:自定義模組變數(Module Variable)(請盡量不要在客製環境修改此段落內容, 否則將後續patch的調整需人工處理) name="global.variable"
DEFINE g_bgaz_m_t       type_g_bgaz_m
#end add-point
 
DEFINE g_bgaz_m        type_g_bgaz_m
 
   
 
DEFINE g_ref_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
DEFINE g_rtn_fields          DYNAMIC ARRAY OF VARCHAR(500) #ap_ref用陣列
 
#add-point:自定義客戶專用模組變數(Module Variable) name="global.variable_customerization"

#end add-point
 
#add-point:傳入參數說明(global.argv) name="global.argv"

#end add-point
 
{</section>}
 
{<section id="abgt020_01.input" >}
#+ 資料輸入
PUBLIC FUNCTION abgt020_01(--)
   #add-point:input段變數傳入 name="input.get_var"
   p_bgaw001,p_bgaz039,p_bgaz001,p_bgaz002,p_bgaz003,p_bgaz004
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
   #傳入參數
   DEFINE p_bgaw001              LIKE bgaw_t.bgaw001    #樣表編號
   DEFINE p_bgaz039              LIKE bgaz_t.bgaz039    #自定義維度控制类型 
   DEFINE p_bgaz001              LIKE bgaz_t.bgaz001    #预算编号
   DEFINE p_bgaz002              LIKE bgaz_t.bgaz002    #版本
   DEFINE p_bgaz003              LIKE bgaz_t.bgaz003    #预算组织
   DEFINE p_bgaz004              LIKE bgaz_t.bgaz004    #预算项目
   #是否启用改自由维度
   DEFINE l_flag1         LIKE type_t.chr5
   DEFINE l_flag2         LIKE type_t.chr5
   DEFINE l_flag3         LIKE type_t.chr5
   DEFINE l_flag4         LIKE type_t.chr5
   DEFINE l_flag5         LIKE type_t.chr5
   DEFINE l_flag6         LIKE type_t.chr5
   DEFINE l_flag7         LIKE type_t.chr5
   DEFINE l_flag8         LIKE type_t.chr5
   DEFINE l_flag9         LIKE type_t.chr5
   DEFINE l_flag10        LIKE type_t.chr5
   #其他定义项
   DEFINE l_bgaw005       LIKE bgaw_t.bgaw005
   DEFINE l_errno         LIKE type_t.chr80
   #end add-point
   
   #畫面開啟 (identifier)
   OPEN WINDOW w_abgt020_01 WITH FORM cl_ap_formpath("abg","abgt020_01")
 
   #瀏覽頁簽資料初始化
   CALL cl_ui_init()
   
   LET g_qryparam.state = "i"
   LET p_cmd = 'a'
   
   #輸入前處理
   #add-point:單頭前置處理 name="input.pre_input"
   #资料检查
   IF cl_null(p_bgaz001) OR cl_null(p_bgaz002) OR cl_null(p_bgaz003) OR cl_null(p_bgaz004)
      OR cl_null(p_bgaz039) OR cl_null(p_bgaw001) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = -400
      LET g_errparam.extend = ''
      LET g_errparam.popup = FALSE
      CALL cl_err()

      RETURN      
   END IF    
   #初值
   INITIALIZE g_bgaz_m_t.*  TO NULL
   LET g_qryparam.where = "glaf001 = '",p_bgaz039,"'" #自由核算項類型
   #從abgi210中抓取自由維度使用否的情況
   LET l_flag1 =''   LET l_flag2 = ''
   LET l_flag3 =''   LET l_flag4 = ''
   LET l_flag5 =''   LET l_flag6 = ''
   LET l_flag7 =''   LET l_flag8 = ''
   LET l_flag9 =''   LET l_flag10 = ''

   FOR l_count = 12 TO 21
       SELECT bgaw005 INTO l_bgaw005 FROM bgaw_t
        WHERE bgawent = g_enterprise
          AND bgaw001 = p_bgaw001    #樣表編號
          AND bgaw002 = l_count
        #自定義維度一  
        IF l_count = 12   THEN
           IF l_bgaw005 = 'Y' THEN
              CALL cl_set_comp_required('bgaz028',TRUE)
           ELSE
              CALL cl_set_comp_entry('bgaw028',FALSE)           
           END IF 
        END IF 
         #自定義維度二
        IF l_count = 13   THEN
           IF l_bgaw005 = 'Y' THEN
              CALL cl_set_comp_required('bgaz029',TRUE)
           ELSE
              CALL cl_set_comp_entry('bgaw029',FALSE)           
           END IF 
        END IF 
         #自定義維度三  
        IF l_count = 14   THEN
           IF l_bgaw005 = 'Y' THEN
              CALL cl_set_comp_required('bgaz030',TRUE)
           ELSE
              CALL cl_set_comp_entry('bgaw030',FALSE)           
           END IF 
        END IF 
         #自定義維度四  
        IF l_count = 15   THEN
           IF l_bgaw005 = 'Y' THEN
              CALL cl_set_comp_required('bgaz031',TRUE)
           ELSE
              CALL cl_set_comp_entry('bgaz031',FALSE)           
           END IF 
        END IF 
         #自定義維度五  
        IF l_count = 16   THEN
           IF l_bgaw005 = 'Y' THEN
              CALL cl_set_comp_required('bgaz032',TRUE)
           ELSE
              CALL cl_set_comp_entry('bgaz032',FALSE)           
           END IF 
        END IF 
         #自定義維度六  
        IF l_count = 17   THEN
           IF l_bgaw005 = 'Y' THEN
              CALL cl_set_comp_required('bgaz033',TRUE)
           ELSE
              CALL cl_set_comp_entry('bgaz033',FALSE)           
           END IF 
        END IF 
         #自定義維度七  
        IF l_count = 18   THEN
           IF l_bgaw005 = 'Y' THEN
              CALL cl_set_comp_required('bgaz034',TRUE)
           ELSE
              CALL cl_set_comp_entry('bgaz034',FALSE)           
           END IF 
        END IF 
         #自定義維度八  
        IF l_count = 19   THEN
           IF l_bgaw005 = 'Y' THEN
              CALL cl_set_comp_required('bgaz035',TRUE)
           ELSE
              CALL cl_set_comp_entry('bgaz035',FALSE)           
           END IF 
        END IF 
         #自定義維度九 
        IF l_count = 20   THEN
           IF l_bgaw005 = 'Y' THEN
              CALL cl_set_comp_required('bgaz036',TRUE)
           ELSE
              CALL cl_set_comp_entry('bgaz036',FALSE)           
           END IF 
        END IF 
         #自定義維度十  
        IF l_count = 21   THEN
           IF l_bgaw005 = 'Y' THEN
              CALL cl_set_comp_required('bgaz037',TRUE)
           ELSE
              CALL cl_set_comp_entry('bgaz037',FALSE)           
           END IF 
        END IF      
   END FOR  
   #抓取
   #end add-point
  
   DIALOG ATTRIBUTES(UNBUFFERED,FIELD ORDER FORM)
   
      #輸入開始
      INPUT BY NAME g_bgaz_m.bgaz028,g_bgaz_m.bgaz033,g_bgaz_m.bgaz029,g_bgaz_m.bgaz034,g_bgaz_m.bgaz030, 
          g_bgaz_m.bgaz035,g_bgaz_m.bgaz031,g_bgaz_m.bgaz036,g_bgaz_m.bgaz032,g_bgaz_m.bgaz037 ATTRIBUTE(WITHOUT  
          DEFAULTS)
         
         #自訂ACTION
         #add-point:單頭前置處理 name="input.action"
         
         #end add-point
         
         #自訂ACTION(master_input)
         
         
         BEFORE INPUT
            #add-point:單頭輸入前處理 name="input.before_input"
            #如果原来存在资料，则先拉出显示
            SELECT bgaz028,bgaz029,bgaz030,bgaz031,bgaz032,
                   bgaz033,bgaz034,bgaz035,bgaz036,bgaz037
              INTO g_bgaz_m.bgaz028,g_bgaz_m.bgaz029,g_bgaz_m.bgaz030,g_bgaz_m.bgaz031,g_bgaz_m.bgaz032,
                   g_bgaz_m.bgaz033,g_bgaz_m.bgaz034,g_bgaz_m.bgaz035,g_bgaz_m.bgaz036,g_bgaz_m.bgaz037              
              FROM bgaz_t
              WHERE bgazent = g_enterprise
                AND bgaz001 = p_bgaz001
                AND bgaz002 = p_bgaz002
                AND bgaz003 = p_bgaz003
                AND bgaz004 = p_bgaz004
            #旧值备份
            LET g_bgaz_m_t.* = g_bgaz_m.*
            CALL abgt020_01_free_desc(p_bgaz039)
            DISPLAY BY NAME g_bgaz_m.*
                        
            #end add-point
          
                  #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaz028
            
            #add-point:AFTER FIELD bgaz028 name="input.a.bgaz028"
            DISPLAY '' TO bgaz028_desc
            IF NOT cl_null(g_bgaz_m.bgaz028) THEN
               CALL abgt020_01_free_chk(p_bgaz039,g_bgaz_m.bgaz028) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_bgaz_m.bgaz028
                  #160318-00005#5 --s add
                  LET g_errparam.replace[1] = 'agli041'
                  LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                  LET g_errparam.exeprog = 'agli041'
                  #160318-00005#5 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_bgaz_m.bgaz028 = g_bgaz_m_t.bgaz028
                  CALL abgt020_01_free_desc(p_bgaz039)
                  DISPLAY BY NAME g_bgaz_m.bgaz028_desc
                  NEXT FIELD bgaz028
               END IF
            END IF
            CALL abgt020_01_free_desc(p_bgaz039)
            DISPLAY BY NAME g_bgaz_m.bgaz028_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaz028
            #add-point:BEFORE FIELD bgaz028 name="input.b.bgaz028"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgaz028
            #add-point:ON CHANGE bgaz028 name="input.g.bgaz028"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaz033
            
            #add-point:AFTER FIELD bgaz033 name="input.a.bgaz033"
             DISPLAY '' TO bgaz033_desc
            IF NOT cl_null(g_bgaz_m.bgaz033) THEN
               CALL abgt020_01_free_chk(p_bgaz039,g_bgaz_m.bgaz033) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_bgaz_m.bgaz033
                  #160318-00005#5 --s add
                  LET g_errparam.replace[1] = 'agli041'
                  LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                  LET g_errparam.exeprog = 'agli041'
                  #160318-00005#5 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_bgaz_m.bgaz033 = g_bgaz_m_t.bgaz033
                  CALL abgt020_01_free_desc(p_bgaz039)
                  DISPLAY BY NAME g_bgaz_m.bgaz033_desc
                  NEXT FIELD bgaz028
               END IF
            END IF
            CALL abgt020_01_free_desc(p_bgaz039)
            DISPLAY BY NAME g_bgaz_m.bgaz033_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaz033
            #add-point:BEFORE FIELD bgaz033 name="input.b.bgaz033"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgaz033
            #add-point:ON CHANGE bgaz033 name="input.g.bgaz033"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaz029
            
            #add-point:AFTER FIELD bgaz029 name="input.a.bgaz029"
            DISPLAY '' TO bgaz029_desc
            IF NOT cl_null(g_bgaz_m.bgaz029) THEN
               CALL abgt020_01_free_chk(p_bgaz039,g_bgaz_m.bgaz029) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_bgaz_m.bgaz029
                  #160318-00005#5 --s add
                  LET g_errparam.replace[1] = 'agli041'
                  LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                  LET g_errparam.exeprog = 'agli041'
                  #160318-00005#5 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_bgaz_m.bgaz029 = g_bgaz_m_t.bgaz029
                  CALL abgt020_01_free_desc(p_bgaz039)
                  DISPLAY BY NAME g_bgaz_m.bgaz029_desc
                  NEXT FIELD bgaz029
               END IF
            END IF
            CALL abgt020_01_free_desc(p_bgaz039)
            DISPLAY BY NAME g_bgaz_m.bgaz029_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaz029
            #add-point:BEFORE FIELD bgaz029 name="input.b.bgaz029"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgaz029
            #add-point:ON CHANGE bgaz029 name="input.g.bgaz029"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaz034
            
            #add-point:AFTER FIELD bgaz034 name="input.a.bgaz034"
             DISPLAY '' TO bgaz034_desc
            IF NOT cl_null(g_bgaz_m.bgaz034) THEN
               CALL abgt020_01_free_chk(p_bgaz039,g_bgaz_m.bgaz034) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_bgaz_m.bgaz034
                  #160318-00005#5 --s add
                  LET g_errparam.replace[1] = 'agli041'
                  LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                  LET g_errparam.exeprog = 'agli041'
                  #160318-00005#5 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_bgaz_m.bgaz034 = g_bgaz_m_t.bgaz034
                  CALL abgt020_01_free_desc(p_bgaz039)
                  DISPLAY BY NAME g_bgaz_m.bgaz034_desc
                  NEXT FIELD bgaz034
               END IF
            END IF
            CALL abgt020_01_free_desc(p_bgaz039)
            DISPLAY BY NAME g_bgaz_m.bgaz034_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaz034
            #add-point:BEFORE FIELD bgaz034 name="input.b.bgaz034"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgaz034
            #add-point:ON CHANGE bgaz034 name="input.g.bgaz034"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaz030
            
            #add-point:AFTER FIELD bgaz030 name="input.a.bgaz030"
             DISPLAY '' TO bgaz030_desc
            IF NOT cl_null(g_bgaz_m.bgaz030) THEN
               CALL abgt020_01_free_chk(p_bgaz039,g_bgaz_m.bgaz030) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_bgaz_m.bgaz030
                  #160318-00005#5 --s add
                  LET g_errparam.replace[1] = 'agli041'
                  LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                  LET g_errparam.exeprog = 'agli041'
                  #160318-00005#5 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_bgaz_m.bgaz030 = g_bgaz_m_t.bgaz030
                  CALL abgt020_01_free_desc(p_bgaz039)
                  DISPLAY BY NAME g_bgaz_m.bgaz030_desc
                  NEXT FIELD bgaz030
               END IF
            END IF
            CALL abgt020_01_free_desc(p_bgaz039)
            DISPLAY BY NAME g_bgaz_m.bgaz030_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaz030
            #add-point:BEFORE FIELD bgaz030 name="input.b.bgaz030"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgaz030
            #add-point:ON CHANGE bgaz030 name="input.g.bgaz030"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaz035
            
            #add-point:AFTER FIELD bgaz035 name="input.a.bgaz035"
            DISPLAY '' TO bgaz035_desc
            IF NOT cl_null(g_bgaz_m.bgaz035) THEN
               CALL abgt020_01_free_chk(p_bgaz039,g_bgaz_m.bgaz035) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_bgaz_m.bgaz035
                  #160318-00005#5 --s add
                  LET g_errparam.replace[1] = 'agli041'
                  LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                  LET g_errparam.exeprog = 'agli041'
                  #160318-00005#5 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_bgaz_m.bgaz035 = g_bgaz_m_t.bgaz035
                  CALL abgt020_01_free_desc(p_bgaz039)
                  DISPLAY BY NAME g_bgaz_m.bgaz035_desc
                  NEXT FIELD bgaz035
               END IF
            END IF
            CALL abgt020_01_free_desc(p_bgaz039)
            DISPLAY BY NAME g_bgaz_m.bgaz035_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaz035
            #add-point:BEFORE FIELD bgaz035 name="input.b.bgaz035"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgaz035
            #add-point:ON CHANGE bgaz035 name="input.g.bgaz035"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaz031
            
            #add-point:AFTER FIELD bgaz031 name="input.a.bgaz031"
             DISPLAY '' TO bgaz031_desc
            IF NOT cl_null(g_bgaz_m.bgaz031) THEN
               CALL abgt020_01_free_chk(p_bgaz039,g_bgaz_m.bgaz031) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_bgaz_m.bgaz031
                  #160318-00005#5 --s add
                  LET g_errparam.replace[1] = 'agli041'
                  LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                  LET g_errparam.exeprog = 'agli041'
                  #160318-00005#5 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_bgaz_m.bgaz031 = g_bgaz_m_t.bgaz031
                  CALL abgt020_01_free_desc(p_bgaz039)
                  DISPLAY BY NAME g_bgaz_m.bgaz031_desc
                  NEXT FIELD bgaz031
               END IF
            END IF
            CALL abgt020_01_free_desc(p_bgaz039)
            DISPLAY BY NAME g_bgaz_m.bgaz031_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaz031
            #add-point:BEFORE FIELD bgaz031 name="input.b.bgaz031"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgaz031
            #add-point:ON CHANGE bgaz031 name="input.g.bgaz031"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaz036
            
            #add-point:AFTER FIELD bgaz036 name="input.a.bgaz036"
             DISPLAY '' TO bgaz036_desc
            IF NOT cl_null(g_bgaz_m.bgaz036) THEN
               CALL abgt020_01_free_chk(p_bgaz039,g_bgaz_m.bgaz036) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_bgaz_m.bgaz036
                  #160318-00005#5 --s add
                  LET g_errparam.replace[1] = 'agli041'
                  LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                  LET g_errparam.exeprog = 'agli041'
                  #160318-00005#5 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_bgaz_m.bgaz036 = g_bgaz_m_t.bgaz036
                  CALL abgt020_01_free_desc(p_bgaz039)
                  DISPLAY BY NAME g_bgaz_m.bgaz036_desc
                  NEXT FIELD bgaz036
               END IF
            END IF
            CALL abgt020_01_free_desc(p_bgaz039)
            DISPLAY BY NAME g_bgaz_m.bgaz036_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaz036
            #add-point:BEFORE FIELD bgaz036 name="input.b.bgaz036"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgaz036
            #add-point:ON CHANGE bgaz036 name="input.g.bgaz036"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaz032
            
            #add-point:AFTER FIELD bgaz032 name="input.a.bgaz032"
             DISPLAY '' TO bgaz032_desc
            IF NOT cl_null(g_bgaz_m.bgaz032) THEN
               CALL abgt020_01_free_chk(p_bgaz039,g_bgaz_m.bgaz032) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_bgaz_m.bgaz032
                  #160318-00005#5 --s add
                  LET g_errparam.replace[1] = 'agli041'
                  LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                  LET g_errparam.exeprog = 'agli041'
                  #160318-00005#5 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_bgaz_m.bgaz032 = g_bgaz_m_t.bgaz032
                  CALL abgt020_01_free_desc(p_bgaz039)
                  DISPLAY BY NAME g_bgaz_m.bgaz032_desc
                  NEXT FIELD bgaz032
               END IF
            END IF
            CALL abgt020_01_free_desc(p_bgaz039)
            DISPLAY BY NAME g_bgaz_m.bgaz032_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaz032
            #add-point:BEFORE FIELD bgaz032 name="input.b.bgaz032"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgaz032
            #add-point:ON CHANGE bgaz032 name="input.g.bgaz032"
            
            #END add-point 
 
 
         #應用 a02 樣板自動產生(Version:2)
         AFTER FIELD bgaz037
            
            #add-point:AFTER FIELD bgaz037 name="input.a.bgaz037"
             DISPLAY '' TO bgaz037_desc
            IF NOT cl_null(g_bgaz_m.bgaz037) THEN
               CALL abgt020_01_free_chk(p_bgaz039,g_bgaz_m.bgaz037) RETURNING l_errno
               IF NOT cl_null(l_errno) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = l_errno
                  LET g_errparam.extend = g_bgaz_m.bgaz037
                  #160318-00005#5 --s add
                  LET g_errparam.replace[1] = 'agli041'
                  LET g_errparam.replace[2] = cl_get_progname('agli041',g_lang,"2")
                  LET g_errparam.exeprog = 'agli041'
                  #160318-00005#5 --e add
                  LET g_errparam.popup = TRUE
                  CALL cl_err()

                  LET g_bgaz_m.bgaz037 = g_bgaz_m_t.bgaz037
                  CALL abgt020_01_free_desc(p_bgaz039)
                  DISPLAY BY NAME g_bgaz_m.bgaz037_desc
                  NEXT FIELD bgaz037
               END IF
            END IF
            CALL abgt020_01_free_desc(p_bgaz039)
            DISPLAY BY NAME g_bgaz_m.bgaz037_desc
            #END add-point
            
 
 
         #應用 a01 樣板自動產生(Version:2)
         BEFORE FIELD bgaz037
            #add-point:BEFORE FIELD bgaz037 name="input.b.bgaz037"
            
            #END add-point
 
 
         #應用 a04 樣板自動產生(Version:3)
         ON CHANGE bgaz037
            #add-point:ON CHANGE bgaz037 name="input.g.bgaz037"
            
            #END add-point 
 
 
 #欄位檢查
                  #Ctrlp:input.c.bgaz028
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaz028
            #add-point:ON ACTION controlp INFIELD bgaz028 name="input.c.bgaz028"
            #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bgaz_m.bgaz028             #給予default值
            LET g_qryparam.default2 = "" #g_bgaz_m.glafl004 #說明

            #給予arg
            CALL q_glaf002()                                #呼叫開窗

            LET g_bgaz_m.bgaz029 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_bgaz_m.bgaz029_desc = g_qryparam.return2 #說明

            DISPLAY g_bgaz_m.bgaz028 TO bgaz028              #顯示到畫面上
            DISPLAY g_bgaz_m.bgaz028_desc TO bgaz028_desc    #說明
            
            NEXT FIELD bgaz028 
            #END add-point
 
 
         #Ctrlp:input.c.bgaz033
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaz033
            #add-point:ON ACTION controlp INFIELD bgaz033 name="input.c.bgaz033"
             #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bgaz_m.bgaz033             #給予default值
            LET g_qryparam.default2 = "" #g_bgaz_m.glafl004 #說明

            #給予arg
            CALL q_glaf002()                                #呼叫開窗

            LET g_bgaz_m.bgaz029 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_bgaz_m.bgaz029_desc = g_qryparam.return2 #說明

            DISPLAY g_bgaz_m.bgaz033 TO bgaz033              #顯示到畫面上
            DISPLAY g_bgaz_m.bgaz033_desc TO bgaz033_desc    #說明
            
            NEXT FIELD bgaz033 
            #END add-point
 
 
         #Ctrlp:input.c.bgaz029
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaz029
            #add-point:ON ACTION controlp INFIELD bgaz029 name="input.c.bgaz029"
             #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bgaz_m.bgaz029             #給予default值
            LET g_qryparam.default2 = "" #g_bgaz_m.glafl004 #說明

            #給予arg
            CALL q_glaf002()                                #呼叫開窗

            LET g_bgaz_m.bgaz029 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_bgaz_m.bgaz029_desc = g_qryparam.return2 #說明

            DISPLAY g_bgaz_m.bgaz029 TO bgaz029              #顯示到畫面上
            DISPLAY g_bgaz_m.bgaz029_desc TO bgaz029_desc    #說明
            
            NEXT FIELD bgaz029 
            #END add-point
 
 
         #Ctrlp:input.c.bgaz034
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaz034
            #add-point:ON ACTION controlp INFIELD bgaz034 name="input.c.bgaz034"
             #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bgaz_m.bgaz034             #給予default值
            LET g_qryparam.default2 = "" #g_bgaz_m.glafl004 #說明

            #給予arg
            CALL q_glaf002()                                #呼叫開窗

            LET g_bgaz_m.bgaz034 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_bgaz_m.bgaz034_desc = g_qryparam.return2 #說明

            DISPLAY g_bgaz_m.bgaz034 TO bgaz034              #顯示到畫面上
            DISPLAY g_bgaz_m.bgaz034_desc TO bgaz034_desc    #說明
            
            NEXT FIELD bgaz034 
            #END add-point
 
 
         #Ctrlp:input.c.bgaz030
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaz030
            #add-point:ON ACTION controlp INFIELD bgaz030 name="input.c.bgaz030"
             #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bgaz_m.bgaz030             #給予default值
            LET g_qryparam.default2 = "" #g_bgaz_m.glafl004 #說明

            #給予arg
            CALL q_glaf002()                                #呼叫開窗

            LET g_bgaz_m.bgaz030 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_bgaz_m.bgaz030_desc = g_qryparam.return2 #說明

            DISPLAY g_bgaz_m.bgaz030 TO bgaz030              #顯示到畫面上
            DISPLAY g_bgaz_m.bgaz030_desc TO bgaz030_desc    #說明
            
            NEXT FIELD bgaz030 
            #END add-point
 
 
         #Ctrlp:input.c.bgaz035
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaz035
            #add-point:ON ACTION controlp INFIELD bgaz035 name="input.c.bgaz035"
             #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bgaz_m.bgaz035             #給予default值
            LET g_qryparam.default2 = "" #g_bgaz_m.glafl004 #說明

            #給予arg
            CALL q_glaf002()                                #呼叫開窗

            LET g_bgaz_m.bgaz035 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_bgaz_m.bgaz035_desc = g_qryparam.return2 #說明

            DISPLAY g_bgaz_m.bgaz035 TO bgaz035              #顯示到畫面上
            DISPLAY g_bgaz_m.bgaz035_desc TO bgaz035_desc    #說明
            
            NEXT FIELD bgaz035 
            #END add-point
 
 
         #Ctrlp:input.c.bgaz031
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaz031
            #add-point:ON ACTION controlp INFIELD bgaz031 name="input.c.bgaz031"
             #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bgaz_m.bgaz031             #給予default值
            LET g_qryparam.default2 = "" #g_bgaz_m.glafl004 #說明

            #給予arg
            CALL q_glaf002()                                #呼叫開窗

            LET g_bgaz_m.bgaz031 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_bgaz_m.bgaz031_desc = g_qryparam.return2 #說明

            DISPLAY g_bgaz_m.bgaz031 TO bgaz031              #顯示到畫面上
            DISPLAY g_bgaz_m.bgaz031_desc TO bgaz031_desc    #說明
            
            NEXT FIELD bgaz031 
            #END add-point
 
 
         #Ctrlp:input.c.bgaz036
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaz036
            #add-point:ON ACTION controlp INFIELD bgaz036 name="input.c.bgaz036"
             #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bgaz_m.bgaz036             #給予default值
            LET g_qryparam.default2 = "" #g_bgaz_m.glafl004 #說明

            #給予arg
            CALL q_glaf002()                                #呼叫開窗

            LET g_bgaz_m.bgaz036 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_bgaz_m.bgaz036_desc = g_qryparam.return2 #說明

            DISPLAY g_bgaz_m.bgaz036 TO bgaz036              #顯示到畫面上
            DISPLAY g_bgaz_m.bgaz036_desc TO bgaz036_desc    #說明
            
            NEXT FIELD bgaz036 
            #END add-point
 
 
         #Ctrlp:input.c.bgaz032
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaz032
            #add-point:ON ACTION controlp INFIELD bgaz032 name="input.c.bgaz032"
             #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bgaz_m.bgaz032             #給予default值
            LET g_qryparam.default2 = "" #g_bgaz_m.glafl004 #說明

            #給予arg
            CALL q_glaf002()                                #呼叫開窗

            LET g_bgaz_m.bgaz032 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_bgaz_m.bgaz032_desc = g_qryparam.return2 #說明

            DISPLAY g_bgaz_m.bgaz032 TO bgaz032              #顯示到畫面上
            DISPLAY g_bgaz_m.bgaz032_desc TO bgaz032_desc    #說明
            
            NEXT FIELD bgaz032 
            #END add-point
 
 
         #Ctrlp:input.c.bgaz037
         #應用 a03 樣板自動產生(Version:3)
         ON ACTION controlp INFIELD bgaz037
            #add-point:ON ACTION controlp INFIELD bgaz037 name="input.c.bgaz037"
             #開窗i段
            LET g_qryparam.reqry = FALSE

            LET g_qryparam.default1 = g_bgaz_m.bgaz037             #給予default值
            LET g_qryparam.default2 = "" #g_bgaz_m.glafl004 #說明

            #給予arg
            CALL q_glaf002()                                #呼叫開窗

            LET g_bgaz_m.bgaz037 = g_qryparam.return1              #將開窗取得的值回傳到變數
            LET g_bgaz_m.bgaz037_desc = g_qryparam.return2 #說明

            DISPLAY g_bgaz_m.bgaz037 TO bgaz037              #顯示到畫面上
            DISPLAY g_bgaz_m.bgaz037_desc TO bgaz037_desc    #說明
            
            NEXT FIELD bgaz037 
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
   CLOSE WINDOW w_abgt020_01 
   
   #add-point:input段after input name="input.post_input"
   IF INT_FLAG THEN
      LET INT_FLAG = FALSE
      RETURN  g_bgaz_m_t.bgaz028,g_bgaz_m_t.bgaz029,g_bgaz_m_t.bgaz030,g_bgaz_m_t.bgaz031,g_bgaz_m_t.bgaz032,
              g_bgaz_m_t.bgaz033,g_bgaz_m_t.bgaz034,g_bgaz_m_t.bgaz035,g_bgaz_m_t.bgaz036,g_bgaz_m_t.bgaz037
   END IF
      RETURN  g_bgaz_m.bgaz028,g_bgaz_m.bgaz029,g_bgaz_m.bgaz030,g_bgaz_m.bgaz031,g_bgaz_m.bgaz032,
              g_bgaz_m.bgaz033,g_bgaz_m.bgaz034,g_bgaz_m.bgaz035,g_bgaz_m.bgaz036,g_bgaz_m.bgaz037   
   #end add-point    
   
END FUNCTION
 
{</section>}
 
{<section id="abgt020_01.other_dialog" readonly="Y" >}

 
{</section>}
 
{<section id="abgt020_01.other_function" readonly="Y" >}
#+自定義維度說明
PRIVATE FUNCTION abgt020_01_free_desc(p_bgaz039)
   DEFINE p_bgaz039     LIKE bgaz_t.bgaz039   
   
   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] =p_bgaz039
   LET g_ref_fields[2] =g_bgaz_m.bgaz028
   CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_bgaz_m.bgaz028_desc= g_rtn_fields[1]

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] =p_bgaz039
   LET g_ref_fields[2] =g_bgaz_m.bgaz029
   CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_bgaz_m.bgaz029_desc= g_rtn_fields[1]

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] =p_bgaz039
   LET g_ref_fields[2] =g_bgaz_m.bgaz030
   CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_bgaz_m.bgaz030_desc= g_rtn_fields[1]

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] =p_bgaz039
   LET g_ref_fields[2] =g_bgaz_m.bgaz031
   CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_bgaz_m.bgaz031_desc= g_rtn_fields[1]

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] =p_bgaz039
   LET g_ref_fields[2] =g_bgaz_m.bgaz032
   CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_bgaz_m.bgaz032_desc= g_rtn_fields[1]

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] =p_bgaz039
   LET g_ref_fields[2] =g_bgaz_m.bgaz033
   CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_bgaz_m.bgaz033_desc= g_rtn_fields[1]

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] =p_bgaz039
   LET g_ref_fields[2] =g_bgaz_m.bgaz034
   CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_bgaz_m.bgaz034_desc= g_rtn_fields[1]

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] =p_bgaz039
   LET g_ref_fields[2] =g_bgaz_m.bgaz035
   CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_bgaz_m.bgaz035_desc= g_rtn_fields[1]

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] =p_bgaz039
   LET g_ref_fields[2] =g_bgaz_m.bgaz036
   CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_bgaz_m.bgaz036_desc= g_rtn_fields[1]

   INITIALIZE g_ref_fields TO NULL
   LET g_ref_fields[1] =p_bgaz039
   LET g_ref_fields[2] =g_bgaz_m.bgaz037
   CALL ap_ref_array2(g_ref_fields,"SELECT glafl004 FROM glafl_t WHERE glaflent='"||g_enterprise||"' AND glafl001=? AND glafl002=? AND glafl003='"||g_dlang||"'","") RETURNING g_rtn_fields
   LET g_bgaz_m.bgaz037_desc= g_rtn_fields[1]
END FUNCTION
#+ 自定义维度检查
PRIVATE FUNCTION abgt020_01_free_chk(p_glaf001,p_glaf002)
   DEFINE p_glaf001      LIKE glaf_t.glaf001
   DEFINE p_glaf002      LIKE glaf_t.glaf002
   DEFINE r_errno        LIKE type_t.chr10      #错误编号
   DEFINE l_glafstus     LIKE glaf_t.glafstus
   DEFINE l_glae002      LIKE glae_t.glae002
   DEFINE l_glae003      LIKE glae_t.glae003
   DEFINE l_glae004      LIKE glae_t.glae004
   DEFINE l_cnt          LIKE type_t.num5

     LET r_errno = ''
      #.抓出改类型对应的资料来源，来源档案，来源编号栏位
      SELECT glae002,glae003,glae004 INTO l_glae002,l_glae003,l_glae004 FROM glae_t
       WHERE glaeent = g_enterprise
         AND glae001 = p_glaf001
      #来源类型为1.‘基本资料’，則檢核來源編號欄位是否存在,檢核核算项值的合理性
      IF l_glae002 = '1' THEN
         SELECT count(*) INTO l_cnt FROM dzeb_t
          WHERE dzeb001 = l_glae003
            AND dzeb002 = l_glae004
         IF l_cnt = 0  THEN
            LET r_errno = 'agl-00073'
            RETURN r_errno
         END IF
         #1.检查资料的有效存在
         SELECT glafstus INTO l_glafstus FROM glaf_t
          WHERE glafent = g_enterprise
            AND glaf001 = p_glaf001
            AND glaf002 = p_glaf002
          IF  SQLCA.SQLCODE = 100  THEN
               LET r_errno = 'agl-00062'
               RETURN r_errno
          END IF
          IF  l_glafstus = 'N'  THEN
              #LET g_errno = 'agl-00063' #160318-00005#5 mark
              LET g_errno = 'sub-01302'  #160318-00005#5 add
              RETURN r_errno
          END IF
      END IF
      #来源类型为2.预设值，則輸入值應檢核是否存在自由核算項資料檔,檢核核算项值的合理性
      IF l_glae002 = '2' THEN
         SELECT glafstus INTO l_glafstus FROM glaf_t
             WHERE glafent = g_enterprise
               AND glaf001 = p_glaf001
               AND glaf002 = p_glaf002
         IF SQLCA.SQLCODE = 100  THEN
            LET r_errno = 'agl-00062'
            RETURN r_errno
          END IF
         IF l_glafstus = 'N'  THEN
            #LET g_errno = 'agl-00063' #160318-00005#5 mark
            LET g_errno = 'sub-01302'  #160318-00005#5 add
            RETURN r_errno
         END IF    
      END IF
      #若来源类型为3.'自行輸入'則user可任意輸入且不需檢核
      RETURN r_errno
END FUNCTION

 
{</section>}
 
