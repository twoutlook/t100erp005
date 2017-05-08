#+ Version..: T100-ERP-1.00.00(版次:1) Build-000026
#+ 
#+ Filename...: cl_jmail
#+ Description: ...
#+ Creator....: (1899/12/31)
#+ Modifier...: (1899/12/31)
#+ Buildtype..: 應用 p00 樣板自動產生
#+ 以上段落由子樣板a00產生

{</section>}

{<section id="cl_jmail.global" >}
#add-point:註解編寫項目
{<point name="main.memo" />}
#end add-point

IMPORT os
#add-point:增加匯入項目
IMPORT JAVA com.dsc.commons.mail.MailParser          {#ADP版次:1#}
#end add-point

SCHEMA ds

GLOBALS "../../cfg/top_global.inc"

MAIN

   DEFINE lc_channel  base.Channel
   DEFINE ls_file    STRING
   DEFINE ls_tmp     STRING
   DEFINE ls_subject STRING
   DEFINE ls_date    STRING
   DEFINE ls_from    STRING
   DEFINE ls_text    STRING

   OPTIONS
   INPUT NO WRAP
   DEFER INTERRUPT

   #設定SQL錯誤記錄方式 (模組內定義有效)
   WHENEVER ERROR CALL cl_err_msg_log

   #依模組進行系統初始化設定(系統設定)
   CALL cl_ap_init("azz","")

   INITIALIZE g_xml.* TO NULL

   LET ls_subject = g_argv[1]  #信件標題
   LET ls_from = g_argv[2]     #收信人
   LET ls_text = g_argv[3]     #信件內容
   LET g_xml.attach = g_argv[4] #附件檔路徑
   LET g_xml.cc     = g_argv[5] #CC
   LET g_xml.bcc    = g_argv[6] #BCC
   LET g_xml.sender  = g_argv[7] #寄信人
   LET g_xml.replyto = g_argv[8] #指定回信位置

   LET ls_file = os.Path.join(FGL_GETENV("TEMPDIR"),FGL_GETPID()||".msg")

   #信件檔案
   LET lc_channel = base.Channel.create()
   CALL lc_channel.openFile( ls_file CLIPPED, "a" )
   CALL lc_channel.setDelimiter("")
   CALL lc_channel.write(ls_text)
   CALL lc_channel.close()
   #信件主旨
   LET g_xml.subject = ls_subject
   #信件本文
   LET g_xml.body = ls_file
   #寄信人
   LET g_xml.sender = "t100@digiwin.biz:T100產品中心"
   #收件者
   LET g_xml.recipient = ls_from

   #寄發mail
   CALL cl_jmail() RETURNING ls_tmp
END MAIN

