#該程式未解開Section, 採用最新樣板產出!
{<section id="awsp900_02.description" >}
#應用 a00 樣板自動產生(Version:3)
#+ Standard Version.....: SD版次:0014(2014-05-23 00:00:00), PR版次:0014(2017-02-22 09:39:58)
#+ Customerized Version.: SD版次:0000(1900-01-01 00:00:00), PR版次:0000(1900-01-01 00:00:00)
#+ Build......: 000118
#+ Filename...: awsp900_02
#+ Description: 
#+ Creator....: 00544(2014-02-20 17:39:21)
#+ Modifier...: 00544 -SD/PR- 04182
 
{</section>}
 
{<section id="awsp900_02.global" >}
#應用 p00 樣板自動產生(Version:5)
#add-point:填寫註解說明 name="main.memo"
#160223-00006#1  2016/2/23  By ycchao       新增webservice連線時確認目前DB連線是否正常
#161116-00019#1  2016/11/16 By ycchao       新增DB連線失敗重新連線等待時間
#161128-00022#1  2016/11/28 By Hank Wu      修改sqlcode判斷回傳內容
#161129-00007#1  2016/11/29 by Hank Wu      取消註解
#161208-00039    2016/12/08 By yc.chao  新增中台restful接口處理
#161228-00023  2016/12/28 By yc.chao  新增中台檔案傳輸處理
#170222-00002  2017/02/22 By yc.chao  減少非必要的DISPLAY訊息
#end add-point
#add-point:填寫註解說明(客製用) name="main.memo_customerization"

#end add-point
 
IMPORT os
#add-point:增加匯入項目 name="main.import"
IMPORT xml
IMPORT com
IMPORT util
#end add-point
 
SCHEMA ds
 
GLOBALS "../../cfg/top_global.inc"
#add-point:增加匯入變數檔 name="global.inc"
GLOBALS "../../cfg/top_ws.inc"            #TIPTOP Service Gateway 使用的全域變數檔
GLOBALS "../../cfg/top_json.inc"
#end add-point
 
{</section>}
 
{<section id="awsp900_02.free_style_variable" >}
#add-point:free_style模組變數(Module Variable) name="free_style.variable"

#end add-point
 
{</section>}
 
{<section id="awsp900_02.global_variable" >}
#add-point:自定義模組變數(Module Variable) name="global.variable"

#end add-point
 
{</section>}
 
{<section id="awsp900_02.other_dialog" >}

 
{</section>}
 
{<section id="awsp900_02.other_function" readonly="Y" >}

################################################################################
# Descriptions...: 提供 invokeSrv 服務呼叫
# Memo...........:
# Usage..........: CALL awsp900_02_invokeSrv()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION awsp900_02_invokeSrv()
DEFINE l_cmd         STRING
DEFINE la_param      RECORD
          prog       STRING,
          param      DYNAMIC ARRAY OF STRING
                     END RECORD
DEFINE l_prog        LIKE gzja_t.gzja001
DEFINE l_service     LIKE gzja_t.gzja004
DEFINE l_cnt         INTEGER      #160223-00006#1 by ycchao add
DEFINE channel_l     base.Channel       #檢查link狀況 
DEFINE channel_r     base.Channel       #檢查wssp999.42r是否存在
DEFINE l_file        STRING             #wssp999.42r檔案位址
DEFINE l_link        STRING             #執行r.l背景訊息
DEFINE li_idx        LIKE type_t.num5
DEFINE l_trans_type  LIKE gzja_t.gzja012   #161228-00023 
 
    WHENEVER ERROR CONTINUE
 
    #服務變數初始化
    CALL awsp900_01_init()

    #取出輸入檔案路徑內的輸入字串
    LET g_request.request = awsp900_01_read_file(g_request_file_path)
    IF cl_null(g_request.request) THEN
       LET g_srvcode = "100"
       RETURN
    END IF
    #DISPLAY "g_request.request = ", g_request.request #170222-00002 mark

    #取得服務名稱
    LET g_service = awsp900_02_req_process() 
    display "service:",g_service 
    IF cl_null(g_service) THEN
       LET g_srvcode = "100"
       RETURN
    END IF
    
    IF g_service = "ProcessStatusUpdate" THEN
       LET l_file = os.Path.join(os.Path.join(FGL_GETENV("WSS"),"42r"),"wssp999.42r")
       IF NOT os.Path.exists(l_file) THEN
          LET l_cmd = "r.l wssp999 2>&1"
          #RUN l_cmd
          #利用openPipe方式 擷取系統背景執行訊息
          LET channel_l = base.Channel.create()
          CALL channel_l.setDelimiter("")
          CALL channel_l.openPipe( l_cmd, "r" )
       
          WHILE channel_l.read(l_link)
             IF l_link.trim() IS NULL THEN CONTINUE WHILE END IF
          
             DISPLAY l_link #顯示背景訊息
          
             LET li_idx = l_link.getIndexOf("ERROR", 1) #若r.l出現錯誤訊息 顯示出error
             IF li_idx > 0 THEN
                LET l_link = l_link.subString(li_idx + 13, l_link.getLength())
                LET g_srvcode = "100"
                LET g_response.response  = "[wssp999 link error]", l_link
               
                EXIT WHILE
             END IF
          END WHILE
       
          CALL channel_l.close()
       END IF
    END IF

    #紀錄 Request XML
    CALL awsp900_01_writeRequestLog()  
    LET g_request.request = cl_trust_coding_de(g_request.request)    

    #檢查服務名稱是否正確, 若正確則呼叫服務 Function 處理
    IF g_srvcode ="000" THEN
       LET l_service = g_service
       #參考azzi700的設定
       #160223-00006#1 by ycchao add start
       LET l_cnt = 1

       FOR l_cnt = 1 to 3
         #SELECT gzja001 INTO l_prog FROM gzja_t WHERE gzja004 = l_service   #161228-00023 mark     
         SELECT gzja001,gzja012 INTO l_prog,l_trans_type FROM gzja_t WHERE gzja004 = l_service    #161228-00023 add 
         LET g_trans_type = l_trans_type
         #DISPLAY 'g_trans_type:',l_trans_type #170222-00002 mark
         #161128-00022 by Hank Wu start
         CASE 
            WHEN SQLCA.SQLCODE = 100
               #服務不存在
               DISPLAY "Service ","[", g_service CLIPPED, "]", "is not found"
            OTHERWISE
               IF SQLCA.SQLCODE THEN #161129-00007 by Hank Wu
                  DISPLAY "DB CONNECT ERROR! SQLCOCE:[", SQLCA.sqlcode,"],SQLERRD[2]:",SQLCA.SQLERRD[2]
                  #CALL cl_db_connect("ds", FALSE)  #161116-00019 mark
                  CALL cl_db_connect("ds", TRUE)    #161116-00019 add
                  IF l_cnt = 3 THEN
                     LET g_srvcode = "100" 
                     LET g_response.response  = "[", g_service CLIPPED, "]", "Service not executed successfully,","DB CONNECT ERROR:",SQLCA.SQLERRD[2] 
                     #161116-00019 start
                  ELSE
                     SLEEP 1
                     CONTINUE FOR   
                  #161116-00019 end
                  END IF   
               END IF     #161129-00007 by Hank Wu
         END CASE
         #161128-00022 by Hank wu end
         
#          IF SQLCA.sqlcode THEN
#             DISPLAY "DB CONNECT ERROR! SQLCOCE:[", SQLCA.sqlcode,"],SQLERRD[2]:",SQLCA.SQLERRD[2]
#             #CALL cl_db_connect("ds", FALSE)  #161116-00019 mark
#             CALL cl_db_connect("ds", TRUE)    #161116-00019 add
#             #SELECT gzja001 INTO l_prog FROM gzja_t WHERE gzja004 = l_service
#             IF l_cnt = 3 THEN
#                LET g_srvcode = "100" 
#                LET g_response.response  = "[", g_service CLIPPED, "]", "Service not executed successfully,","DB CONNECT ERROR:",SQLCA.SQLERRD[2] 
#             #161116-00019 start
#             ELSE
#                SLEEP 1
#             #161116-00019 end
#             END IF   
#          ELSE
#             EXIT FOR          
#          END IF
          EXIT FOR  #161128-00022 by Hank Wu
       END FOR
       
       IF g_srvcode ="000" THEN
          IF cl_null(l_prog) THEN
             LET g_srvcode = "100"       #服務未按照正常流程執行
             LET g_response.response  = "[", g_service CLIPPED, "]", "Service not found"  
          ELSE
             LET la_param.prog = l_prog
          END IF
       END IF   
       #160223-00006#1 by ycchao add end
    END IF

    IF g_srvcode = "000" THEN
       LET la_param.param[1] = g_request_file_path CLIPPED
       LET la_param.param[2] = g_response_file_path CLIPPED
       LET l_cmd = util.JSON.stringify(la_param)

       DISPLAY "run service: ", l_cmd
       DISPLAY "(debug cmdrun)  r.dg ", l_prog CLIPPED," '",g_request_file_path CLIPPED,"' '",g_response_file_path CLIPPED,"'"
       CALL cl_cmdrun_wait(l_cmd)
    END IF

    #檢查服務處理狀況
    CALL awsp900_02_response_process()
    #display g_response.response #170222-00002 mark
END FUNCTION

################################################################################
# Descriptions...: 取得服務名稱
# Memo...........:
# Usage..........: CALL awsp900_02_req_process()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION awsp900_02_req_process()
DEFINE lx_reqdoc         xml.DomDocument
DEFINE lx_node_list      xml.DomNodeList
DEFINE lx_tnode          xml.DomNode
DEFINE lx_pnode          xml.DomNode
DEFINE l_service         STRING
DEFINE l_status          STRING
DEFINE l_i               INTEGER
DEFINE l_ent             STRING
DEFINE l_buf             base.StringBuffer
DEFINE l_count           INTEGER


    IF cl_null(g_request.request) THEN
       LET g_srvcode = "100"       #服務未按照正常流程執行
       LET g_status.code= "-1"
       LET g_status.description = "Request isn't valid XML document."
       LET g_response.response = "Request isn't valid XML document."
       RETURN ""
    END IF
   
    LET l_buf = base.StringBuffer.create()
    #display g_request.request
    CALL l_buf.append(g_request.request)
    #request為XML檔案
    IF l_buf.getIndexOf("<",1) != 0 THEN
       #將 XML 檔案轉為 XML DomNode
       CALL awsp900_01_filetoxml(g_request_file_path) 
          RETURNING l_status,lx_reqdoc,g_response.response
       IF NOT l_status THEN
          LET g_srvcode = "100"       #服務未按照正常流程執行
          RETURN ""
       END IF

       LET l_service = cl_bpm_get_node_attribute(lx_reqdoc,"service","name")
       display "service :", l_service
       IF cl_null(l_service) THEN
          LET g_srvcode = "100"       #服務未按照正常流程執行
          LET g_status.code= "-1"
          LET g_status.description = "Request isn't valid XML document."
          LET g_response.response = "Request isn't valid XML document: not found service name" 
       END IF

       LET g_account = cl_bpm_get_node_attribute(lx_reqdoc,"host","acct")
    
       LET l_ent = awsp900_01_getNodeValue(lx_reqdoc,"key","EntId")
       IF NOT cl_null(l_ent) THEN
          LET g_enterprise = l_ent
       END IF

    ELSE 
       LET g_json_req = util.JSONObject.parse(g_request.request)
       #display 'g_json_req:',g_json_req.toString()  #170222-00002 mark
       IF NOT STATUS THEN
          CALL cl_aws_json_getver()         #161208-00039
          #DISPLAY 'g_json_ver:',g_json_ver  #170222-00002 mark
          LET l_service = cl_aws_json_getValue("service","name")
          display "service :", l_service
          IF cl_null(l_service) THEN
             LET g_srvcode = "100"       #服務未按照正常流程執行
             LET g_status.code= "-1"
             LET g_status.description = "Request isn't valid JSON document."
             LET g_response.response = "Request isn't valid JSON document: not found service name" 
          END IF
          LET g_account = cl_aws_json_getValue("host","acct")
          LET l_ent = cl_aws_json_getValue("datakey","EntId")
          IF NOT cl_null(l_ent) THEN
             LET g_enterprise = l_ent
          END IF 
       END IF
    END IF

    display "02_account:",g_account
    display "02_topent:",g_enterprise
    CALL FGL_SETENV("WEBUSER",g_account)
    CALL FGL_SETENV("LOGNAME",g_account)
    CALL FGL_SETENV("TOPENT",g_enterprise)

    RETURN l_service
END FUNCTION

################################################################################
# Descriptions...: 檢查服務處理狀況
# Memo...........:
# Usage..........: CALL awsp900_02_response_process()
#                  RETURNING 回传参数
# Input parameter: 传入参数变量1   传入参数变量说明1
#                : 传入参数变量2   传入参数变量说明2
# Return code....: 回传参数变量1   回传参数变量说明1
#                : 回传参数变量2   回传参数变量说明2
# Date & Author..: 日期 By 作者
# Modify.........:
################################################################################
PUBLIC FUNCTION awsp900_02_response_process()
DEFINE l_channel         base.Channel
DEFINE l_str             STRING
    
    #檢查服務處理是否正常狀況
    IF g_srvcode = "000" THEN
       display "size:", os.Path.size(g_response_file_path)
       IF os.Path.size(g_response_file_path) > 0  THEN
          LET g_response.response = awsp900_01_read_file(g_response_file_path)
       ELSE

          display "open error"
          LET l_str = ""
          LET g_srvcode = "100"       #服務未按照正常流程執行
          LET g_response.response  = "Service not executed successfully. path:", g_response_file_path
       END IF
    END IF
    
    #display "res:",g_response.response #170222-00002 mark
    #若有錯誤，則必須回傳錯誤原因
    IF g_srvcode = "100" THEN
       #產生 response 資料
       CALL awsp900_01_create_response(g_response.response)
    END IF

    LET g_response.response =cl_str_replace(g_response.response,"<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\"?>","")
    LET g_response.response = cl_trust_coding_en(g_response.response)
    #紀錄 Request XML
    CALL awsp900_01_writeResponseLog()
END FUNCTION

 
{</section>}
 
