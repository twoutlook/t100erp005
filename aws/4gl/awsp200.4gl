#該程式已解開Section, 不再透過樣板產出!
{<section id="awsp200.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0005(1900-01-01 00:00:00), PR版次:0005(2016-03-28 11:37:28)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000048
#+ Filename...: awsp200
#+ Description: ETL 工具程式
#+ Creator....: 00544(2015-02-06 18:23:02)
#+ Modifier...: 00000 -SD/PR- 07959
 
{</section>}
 
{<section id="awsp200.global" >}
#應用 p01 樣板自動產生(Version:4)
#160318-00005#45  2016/03/26  By pengxin    修正azzi920重复定义之错误讯息
 
IMPORT os
IMPORT util
IMPORT FGL lib_cl_schedule
#add-point:增加匯入項目
IMPORT xml
IMPORT com
IMPORT util
IMPORT security
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
 
 
 
 

   
 
#add-point:自定義模組變數(Module Variable)
GLOBALS "../../cfg/top_ws.inc"
TYPE type_g_attribute DYNAMIC ARRAY OF RECORD
                name         STRING,      #屬性名稱
                value        STRING       #屬性值
             END RECORD
             
TYPE type_g_param DYNAMIC ARRAY OF RECORD
                name         STRING,      #屬性名稱
                value        STRING,      #屬性值
                text         STRING       #node value
             END RECORD 
             
DEFINE g_ws_Start       STRING           #啟動services時間  
DEFINE g_ws_End         STRING           #結束services時間
DEFINE g_logtime_start  DATETIME HOUR TO FRACTION(5)            

TYPE type_g_logv_t RECORD
          logv001   LIKE logv_t.logv001, 
          logv002   DATETIME YEAR TO SECOND, 
          logv003   LIKE logv_t.logv003, 
          logv004   LIKE logv_t.logv004, 
          logv005   LIKE logv_t.logv005, 
          logv006   LIKE logv_t.logv006,     
          logv007   LIKE logv_t.logv007,
          logv008   LIKE logv_t.logv008,
          logv009   LIKE logv_t.logv009,
          logv010   LIKE logv_t.logv010          
END RECORD
DEFINE g_load_filename  LIKE wscb_t.wscb002
DEFINE g_load_dest      STRING
#end add-point
 
#add-point:自定義客戶專用模組變數(Module Variable)

#end add-point
 
#add-point:傳入參數說明

#end add-point
 
{</section>}
 
{<section id="awsp200.main" >}
MAIN
   DEFINE ls_js    STRING
  
   #add-point:main段define
   
   DEFINE ls_action STRING
   DEFINE ls_prog   STRING

   #end add-point 
   #add-point:main段define

   #end add-point 
  
   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log
 
   #依模組進行系統初始化設定(系統設定)
   #CALL cl_ap_init("aws","")
   
 
   CALL cl_tool_init()   
   #CALL cl_db_connect(g_dbs,FALSE)
   CONNECT TO g_dbs   
   #add-point:定義背景狀態與整理進入需用參數ls_js
   #測試傳入的編號
 
   LET ls_prog = g_argv[1]
   LET ls_action = g_argv[2] 
   LET ls_js = g_argv[3]
   
DISPLAY "ls_prog = ",ls_prog
DISPLAY "ls_action = ",ls_action
DISPLAY "ls_js = ",ls_js
   
   CALL util.JSON.parse(ls_js,g_etlparam)
   
   #設定時區
   DISPLAY "time_zone:" , cl_time_trans_by_tz("system_time") 
   
   CLOSE WINDOW screen
   CALL awsp200_etl_job(ls_prog,ls_action) 
   #end add-point
   
   

     

    

  
   #離開作業
   CALL cl_ap_exitprogram("0")
END MAIN
 
{</section>}
 
{<section id="awsp200.init" >}
#+ 初始化作業
 

 

 


 
   
 
 
{</section>}
 
{<section id="awsp200.other_function" readonly="Y" >}
#add-point:自定義元件(Function) name="other.function"

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
PRIVATE FUNCTION awsp200_select_excel()
   DEFINE l_excel_path   STRING
   DEFINE ls_source      STRING
   
   WHENEVER ERROR CALL cl_err_msg_log
       
   #抓取使用者指定的檔案
   LET ls_source = cl_client_browse_file()
   IF ls_source.getLength() < 1 THEN         
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'lib-00123'                                                           
      LET g_errparam.extend = 'lib-00123'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      RETURN FALSE
   END IF
   
   RETURN awsp200_upload_file(ls_source)
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
PRIVATE FUNCTION awsp200_upload_file(p_excel_path)
   DEFINE p_excel_path      STRING
   DEFINE l_filename        STRING
   DEFINE l_dest            STRING   
            
   LET g_load_filename = os.Path.basename(p_excel_path)       #原始檔名                                     
   LET g_load_dest = os.Path.join(FGL_GETENV("TEMPDIR"),g_load_filename CLIPPED)    #Unix path
   CALL FGL_GETFILE(p_excel_path , g_load_dest)

   IF STATUS THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code = 'lib-00125'     #檔案上傳失敗
      LET g_errparam.extend = 'lib-00125'
      LET g_errparam.popup = TRUE
      CALL cl_err()
      LET g_load_filename = ""
      LET g_load_dest = ""
   END IF
   
   RETURN TRUE
END FUNCTION

################################################################################
# Descriptions...: 描述说明
# Memo...........:
# Usage..........: CALL awsp200_etl_job(p_prog,p_action)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION awsp200_etl_job(p_prog,p_action)
   DEFINE l_job_name             LIKE wsca_t.wsca001
   DEFINE l_open                 LIKE type_t.chr1
   DEFINE p_action               STRING
   DEFINE p_prog                 LIKE wsca_t.wsca001
   DEFINE p_excel_file           STRING
   DEFINE l_req_doc              xml.DomDocument
   DEFINE l_request_root         xml.DomNode
   DEFINE l_file                 STRING
   DEFINE l_attr                 type_g_param     #節點屬性資料
   DEFINE l_req_attr             type_g_attribute
   DEFINE l_job_attr             type_g_attribute
   
   DEFINE l_res_doc              xml.DomDocument
   DEFINE l_response_node        xml.DomNode
   DEFINE l_node                 xml.DomNode
   DEFINE l_child_node           xml.DomNode   
   DEFINE l_node_list            xml.DomNodeList
   
   DEFINE l_response_content_str	 STRING
   DEFINE l_status		          INTEGER    
   DEFINE l_i                     LIKE type_t.num5   
   DEFINE l_value	                STRING
 
   DEFINE ls_messgae              STRING
   DEFINE ls_reqid                STRING
   DEFINE ls_sync                 STRING
   DEFINE l_logv                  type_g_logv_t 
   DEFINE l_sync_type             LIKE wsca_t.wsca004
   DEFINE l_wscb                  RECORD LIKE wscb_t.*
   DEFINe ls_target               STRING
   DEFINE ls_url                  STRING
   DEFINE lb_wscb003              BYTE
   DEFINE l_sb                    base.StringBuffer
   DEFINE l_timestamp	          STRING
   DEFINE l_wscc003               LIKE wscc_t.wscc003
   DEFINE l_wscc004               LIKE wscc_t.wscc004
   DEFINE l_cnt		          INTEGER    
   DEFINE l_attr_cnt	          INTEGER    
   DEFINE l_sql       STRING

   CALL l_req_attr.clear()

DISPLAY "p_action = ",p_action

   CASE p_action 
      WHEN 'excel_load'
         #檢查 [匯入excel檔設定] 的筆數
         SELECT COUNT(1) INTO l_cnt FROM wsca_t
            WHERE wsca001 = p_prog AND wscastus='Y' AND wsca008='2'
   
         DISPLAY "l_cnt = ",l_cnt
            
         IF l_cnt > 1 THEN
         
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = p_prog
            LET g_qryparam.arg2 = '2'
            CALL q_wsca002()                           #呼叫開窗:撈取awsi200的ETL_JOB設定
            LET l_job_name  = g_qryparam.return1
            LET l_sync_type = g_qryparam.return2
         
         ELSE 
         
            SELECT wsca002,wsca004 INTO l_job_name,l_sync_type FROM wsca_t 
               WHERE wsca001 = p_prog AND wscastus='Y' AND wsca008='2'

         END IF
         
         DISPLAY "l_job_name = ",l_job_name
         DISPLAY "l_sync_type = ",l_sync_type

      WHEN 'excel_example'
         #檢查 [產生excel範本] 的筆數
         SELECT COUNT(1) INTO l_cnt FROM wsca_t
            WHERE wsca001 = p_prog AND wscastus='Y' AND wsca008='1'
   
         DISPLAY "l_cnt = ",l_cnt
         
         IF l_cnt > 1 THEN
            
            INITIALIZE g_qryparam.* TO NULL
            LET g_qryparam.state = 'i'
            LET g_qryparam.reqry = FALSE
            LET g_qryparam.arg1 = p_prog
            LET g_qryparam.arg2 = '1'
            LET g_qryparam.default1= ' '
            LET g_qryparam.default2= ' '
            CALL q_wsca002()                           #呼叫開窗:撈取awsi200的ETL_JOB設定 
            LET l_job_name  = g_qryparam.return1
            LET l_sync_type = g_qryparam.return2
           

         
         ELSE 
            SELECT wsca002,wsca004 INTO l_job_name,l_sync_type FROM wsca_t 
               WHERE wsca001 = p_prog AND wscastus='Y' AND wsca008='1'
         END IF
      
         DISPLAY "l_job_name = ",l_job_name
         DISPLAY "l_sync_type = ",l_sync_type
          
          LET l_open = 'Y'
          
      WHEN 'data_export'
         LET l_job_name = g_argv[4]        #ETL工作檔案名稱
         LET l_sync_type = 1
         LET l_wscb.wscb001 = g_argv[5]    #指家產出的檔案名稱
         LET l_open = g_argv[6]            #是否直接開啟產出的檔案    
         
      WHEN 'execute_etljob'
         LET l_job_name = g_argv[4]        #ETL工作檔案名稱
         LET l_sync_type = 1
             
   END CASE
   
   IF cl_null(l_job_name) THEN
         #如果是按x 放棄時 應該回原畫面就好 不要出現錯誤訊息 所以以下註解
         #INITIALIZE g_errparam TO NULL
         #LET g_errparam.code = 'lib-00301'  #無設定 ETL JOB
         #LET g_errparam.extend = ''
         #LET g_errparam.popup = TRUE
         #CALL cl_err()
         RETURN 
   END IF
 
   IF cl_null(l_wscb.wscb001) THEN
      LET l_timestamp = cl_eai_format_time()
      LET l_wscb.wscb001 = p_prog CLIPPED,"_",g_account CLIPPED,"_",l_timestamp
   END IF
   
   IF p_action = "excel_load" THEN
      IF awsp200_select_excel() = FALSE THEN
         RETURN
      ELSE

         LOCATE lb_wscb003 IN FILE
         CALL lb_wscb003.readFile(g_load_dest)
         INSERT INTO wscb_t(wscbent,wscb001,wscb002,wscb003)
                     VALUES(g_enterprise, l_wscb.wscb001,g_load_filename,lb_wscb003)
         IF SQLCA.SQLCODE THEN
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = SQLCA.SQLCODE
            LET g_errparam.extend = "INSERT wscb:"
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN
         ELSE
            IF os.Path.delete(lb_wscb003) THEN
            END IF
         END IF

         FREE lb_wscb003
      END IF
   END IF

   CALL l_job_attr.clear()
   LET l_job_attr[1].name = "name"
   LET l_job_attr[1].value = l_job_name

   IF l_sync_type = "1" THEN   #同步
      LET ls_sync = "sync"
   ELSE
      LET ls_sync = "async"
   END IF
   
   CALL cl_eai_create_job_request(ls_sync,l_job_name,l_job_attr)
      RETURNING l_req_doc, l_request_root     
      
   #建立request真正資料內容(payload)
   CALL l_attr.clear()   

   LET l_attr[1].name = "file_id"
   LET l_attr[1].value = "string"
   LET l_attr[1].text = l_wscb.wscb001 CLIPPED

   LET l_attr[2].name = "g_enterprise"
   LET l_attr[2].value = "number"
   LET l_attr[2].text = g_enterprise
   
   LET l_attr[3].name = "g_site"
   LET l_attr[3].value = "string"
   LET l_attr[3].text = g_site CLIPPED

   LET l_attr[4].name = "g_user"
   LET l_attr[4].value = "string"
   LET l_attr[4].text = g_user CLIPPED
   
   LET l_attr[5].name = "g_lang"
   LET l_attr[5].value = "string"
   LET l_attr[5].text = g_lang CLIPPED
   
   LET l_attr[6].name = "g_dept"
   LET l_attr[6].value = "string"
   LET l_attr[6].text = g_dept CLIPPED
   
   LET l_attr_cnt = l_attr.getLength()
   FOR l_i = 1 TO g_etlparam.getLength()
       LET l_attr[l_attr_cnt+l_i].name = g_etlparam[l_i].para_id
       LET l_attr[l_attr_cnt+l_i].value = g_etlparam[l_i].type
       LET l_attr[l_attr_cnt+l_i].text = g_etlparam[l_i].value
   END FOR 

   CALL awsp900_04_create_payload(l_req_doc, l_request_root,l_attr)
      RETURNING l_req_doc, l_request_root
      
   CALL l_req_doc.setFeature("format-pretty-print", true)
   
   LET l_file = os.Path.join(FGL_GETENV("TEMPDIR"), "etl_ws.xml")   
   CALL l_req_doc.save(l_file)
    
   #設定 ETL server
   IF NOT awsp200_01_chk_etl_server() THEN
      RETURN
   END IF  

   CALL cl_eai_start_log()
   
   LET l_logv.logv001 = p_prog
   LET l_logv.logv002 = CURRENT YEAR TO SECOND #cl_get_current()
   LET l_logv.logv003 = g_user
   LET l_logv.logv004 = p_excel_file
   LET l_logv.logv005 = l_job_name
   LET l_logv.logv006 = l_sync_type
    
   display  l_req_doc.saveToString()
   CALL awsp200_01_invokeEtl(l_req_doc.saveToString())
        RETURNING l_status,l_response_content_str
   
   IF cl_null(l_response_content_str) THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "lib-00027"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
   
      RETURN 
   END IF 
   
   DISPLAY l_response_content_str   
   CALL cl_eai_end_log(l_req_doc.saveToString(),l_response_content_str)
   
   CALL awsp900_04_get_response(l_response_content_str) 
        RETURNING l_res_doc,l_response_node
   
   IF l_response_node IS NULL THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "lib-00027"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      CALL cl_err()
   
      RETURN
   END IF
   
   LET l_logv.logv007 = g_srvcode
   LET l_logv.logv008 = cl_bpm_get_node_value(l_res_doc, "message")
   LET l_logv.logv010 = cl_bpm_get_node_value(l_res_doc, "reqid")
   
   
   LET l_node_list = l_response_node.getElementsByTagName("logurl")   
   #取得 url 資料
   FOR l_i = 1 TO l_node_list.getCount()
      LET l_node = l_node_list.getitem(l_i)
      LET l_child_node = l_node.getFirstChild()
      LET l_value = l_child_node.getNodeValue()
   END FOR
   LET l_logv.logv009 = l_value

   display "URL: ",l_value  
   #寫入 job log
   CALL awsp200_write_job_log(l_logv.*)

   IF g_srvcode != "049" THEN
      INITIALIZE g_errparam TO NULL
      LET g_errparam.code =  "lib-00303"
      LET g_errparam.extend = ""
      LET g_errparam.popup = TRUE
      LET g_errparam.replace[1] = ""
      CALL cl_err()
      RETURN 
   END IF


   CASE  
      WHEN (p_action = 'excel_load')
          
          IF (NOT cl_null(l_value) AND l_sync_type = "2") OR g_srvcode != "049" THEN
             CALL ui.interface.frontCall("standard","launchurl",[l_value],[])
          END IF

          IF g_srvcode = "049" THEN
             SELECT COUNT(*) INTO l_cnt FROM wscc_t 
                WHERE wscc001 =  l_wscb.wscb001 and wsccent = g_enterprise
             IF l_cnt = 0 THEN  
                INITIALIZE g_errparam TO NULL
                LET g_errparam.code =  "lib-00304"  #匯入完成
                LET g_errparam.extend = ""
                LET g_errparam.popup = TRUE
                CALL cl_err()
             ELSE
                CALL cl_err_collect_init()

                LET l_sql = "SELECT wscc003,wscc004 FROM wscc_t ",
                            " WHERE wscc001 =  '",l_wscb.wscb001 CLIPPED,"'",
                            "   and wsccent =  ", g_enterprise 
                
                PREPARE wscc FROM l_sql
                DECLARE wscc_curs CURSOR FOR wscc

                FOREACH wscc_curs INTO l_wscc003,l_wscc004
                    INITIALIZE g_errparam TO NULL
#                    LET g_errparam.code =  "lib-00305"      #160318-00005#45  mark
                    LET g_errparam.code =  "std-00008"      #160318-00005#45  add
                    LET g_errparam.extend = ""
                    LET g_errparam.popup = TRUE
                    LET g_errparam.replace[1] = l_wscc004 CLIPPED 
                    CALL cl_err()

                END FOREACH
                CALL cl_err_collect_show()
                RETURN 
             END IF
          END IF

      WHEN (p_action = 'excel_example' or p_action = 'data_export')

           SELECT wscb002 INTO l_wscb.wscb002 FROM wscb_t
             WHERE wscbent = g_enterprise
               AND wscb001 = l_wscb.wscb001
               
            IF cl_null(l_wscb.wscb002) THEN
              INITIALIZE g_errparam TO NULL
              LET g_errparam.code = "lib-00196"  #無資料或檔案產生！
              LET g_errparam.popup = TRUE
              CALL cl_err()
              RETURN
            END IF  
            
            LET ls_target = os.Path.join(FGL_GETENV("TEMPDIR"),l_wscb.wscb002 CLIPPED)
            display "file_path: ",ls_target

            #從資料庫取得Excel範本檔案，並開啟
            LOCATE lb_wscb003 IN FILE
            SELECT wscb003 INTO lb_wscb003 FROM wscb_t
             WHERE wscbent = g_enterprise
               AND wscb001 = l_wscb.wscb001
            CALL lb_wscb003.writeFile(ls_target)
            FREE lb_wscb003
 
            #刪除資料庫Excel範本檔案的資料
            DELETE FROM wscb_t WHERE wscbent = g_enterprise AND wscb001 = l_wscb.wscb001
              
            IF os.Path.size(ls_target.trim()) = 0 THEN
               INITIALIZE g_errparam TO NULL
               LET g_errparam.code = "lib-00302"            #無法產生Excel範本
               LET g_errparam.popup = TRUE
               CALL cl_err()
               RETURN
            END IF
            
            IF l_open = 'Y' THEN
               LET ls_url = os.Path.join(os.Path.join(FGL_GETENV("FGLASIP"),"out"),l_wscb.wscb002 CLIPPED)
               IF NOT cl_client_open_url(ls_url) THEN
                  INITIALIZE g_errparam TO NULL
                  LET g_errparam.code = "lib-00302"            #無法產生Excel範本
                  LET g_errparam.extend = ls_url
                  LET g_errparam.popup = TRUE
                  CALL cl_err()
               END IF                  
            END IF
            
       OTHERWISE
            INITIALIZE g_errparam TO NULL
            LET g_errparam.code = "adz-00217"  
            LET g_errparam.popup = TRUE
            CALL cl_err()
            RETURN
            
   END CASE
END FUNCTION

################################################################################
# Descriptions...: 寫入 ETL 工作記錄
# Memo...........:
# Usage..........: CALL awsp200_write_job_log(l_logv)
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PRIVATE FUNCTION awsp200_write_job_log(l_logv)
   DEFINE l_logv      type_g_logv_t  
 
   INSERT INTO logv_t (logvent,logv001,logv002,logv003,logv004,logv005,logv006,logv007,logv008,logv009,logv010)
          VALUES (g_enterprise, l_logv.logv001 ,l_logv.logv002,l_logv.logv003,l_logv.logv004,l_logv.logv005,
                  l_logv.logv006,l_logv.logv007,l_logv.logv008,l_logv.logv009,l_logv.logv010)
   
   IF SQLCA.SQLCODE THEN
      DISPLAY "INSERT logv_t error:",SQLCA.SQLCODE
   END IF
END FUNCTION

#end add-point
 
{</section>}
 
{<section id="awsp200.ui_dialog" >}
#+ 選單功能實際執行處
 
{<point name="ui_dialog.define" edit="s"/>}
 
{<point name="ui_dialog.define_customerization" edit="c"/>}
   
{<point name="ui_dialog.before_dialog"/>}
 
{<point name="ui_dialog.before_dialog2"/>}
     
{<point name="ui_dialog.more_construct"/>}
      
{<point name="ui_dialog.more_input"/>}
 
{<point name="ui_dialog.more_displayarray"/>}
       
{<point name="ui_dialog.before_dialog3"/>}
 
 
       
{<point name="ui_dialog.before_qbeclear" mark="Y"/>}
       
{<point name="ui_dialog.qbeclear"/>}
           
{<point name="ui_dialog.more_action"/>}
      
{<point name="process.exit_dialog"/>}
      
{<point name="process.after_schedule"/>}
        
 
{</section>}
 
{<section id="awsp200.transfer_argv" >}
#+ 轉換本地參數至cmdrun參數內,準備進入背景執行
 
 
 
{<point name="transfer.argv.define"/>}
 
 
{</section>}
 
{<section id="awsp200.process" >}
#+ 資料處理
 
{<point name="process.define" edit="s"/>}
 
{<point name="process.define_customerization" edit="c"/>}
 
{<point name="process.pre_process"/>}
   #end add-point
 
{<point name="process.count_progress"/>}
 
{<point name="process.process"/>}
 
{<point name="process.foreground_finish"/>}
 
{<point name="process.background_finish"/>}
 
 
{</section>}
 
{<section id="awsp200.get_buffer" >}
{<point name="get_buffer.others"/>}
 
{</section>}
 
