# Prog. Version..: 'T6-12.01.21(00000)'     #
#
# Program name   : s_test_wujie.4gl
# Description    : 測試元件程式wujie专用

IMPORT os


SCHEMA ds

GLOBALS "../../cfg/top_global.inc"
MAIN
DEFINE  l_str     STRING

   OPTIONS                                #改變一些系統預設值
      FORM LINE       FIRST + 2,         #畫面開始的位置
      MESSAGE LINE    LAST,              #訊息顯示的位置
      PROMPT LINE     LAST,              #提示訊息的位置
      INPUT NO WRAP                      #輸入的方式: 不打轉


   WHENEVER ERROR CALL cl_err_msg_log

   #依模組進行系統初始化設定(系統設定)
#  CALL cl_ap_init("adz","N")
   LET g_lang = '2'

  DISCONNECT "dsdemo"
  CONNECT TO "ds"


DISPLAY '======================================================================'
DISPLAY 'test:s_chr_equals'
DISPLAY 'input:0155A01,0155a01,0'
CALL s_chr_equals('0155A01','0155a01',0) RETURNING l_str
DISPLAY 'output:',l_str
DISPLAY 'test:s_chr_equals'
DISPLAY 'input:0155A01,0155a01,1'
CALL s_chr_equals('0155A01','0155a01',0) RETURNING l_str
DISPLAY 'output:r_equal = ',l_str
DISPLAY '======================================================================'

DISPLAY '======================================================================'
DISPLAY 'test:s_chr_get_index_of'
DISPLAY 'input:0155A01,a,1'
CALL s_chr_get_index_of('0155A01','a',1) RETURNING l_str
DISPLAY 'output:r_pos = ',l_str
DISPLAY '======================================================================'

DISPLAY '======================================================================'
DISPLAY 'test:s_chr_trim'
DISPLAY 'input:   0155A01'
CALL s_chr_trim('   0155A01') RETURNING l_str
DISPLAY 'output:r_chr =',l_str
DISPLAY '======================================================================'

DISPLAY '======================================================================'
DISPLAY 'test:s_chr_ltrim'
DISPLAY 'input:   0155A01'
CALL s_chr_ltrim('   0155A01') RETURNING l_str
DISPLAY 'output:r_chr =',l_str
DISPLAY '======================================================================'

DISPLAY '======================================================================'
DISPLAY 'test:s_chr_atrim'
DISPLAY 'input: 0 1 5 5 A 0 1'
CALL s_chr_atrim(' 0 1 5 5 A 0 1') RETURNING l_str
DISPLAY 'output:r_chr =',l_str
DISPLAY '======================================================================'

DISPLAY '======================================================================'
DISPLAY 'test:s_chr_replace'
DISPLAY 'input:0155A01,5,6,1'
CALL s_chr_replace('0155A01','5','6',1) RETURNING l_str
DISPLAY 'output:r_chr =',l_str
DISPLAY '======================================================================'

DISPLAY '======================================================================'
DISPLAY 'test:s_chr_chr_blank'
DISPLAY 'input:0155A0 1'
CALL s_chr_chr_blank('0155A0 1') RETURNING l_str
DISPLAY 'output:r_result =',l_str
DISPLAY '======================================================================'

DISPLAY '======================================================================'
DISPLAY 'test:s_chr_chr_blank'
DISPLAY 'input:0155A01'
CALL s_chr_chr_blank('0155A01') RETURNING l_str
DISPLAY 'output:r_result =',l_str
DISPLAY '======================================================================'

DISPLAY '======================================================================'
DISPLAY 'test:s_chr_chr_alphanumeric'
DISPLAY 'input:0155A01,1纯数字'
CALL s_chr_chr_alphanumeric('0155A01',1) RETURNING l_str
DISPLAY 'output:r_result =',l_str
DISPLAY '======================================================================'

DISPLAY '======================================================================'
DISPLAY 'test:s_chr_chr_alphanumeric'
DISPLAY 'input:0155A01,2纯字母'
CALL s_chr_chr_alphanumeric('0155A01',2) RETURNING l_str
DISPLAY 'output:r_result =',l_str
DISPLAY '======================================================================'

DISPLAY '======================================================================'
DISPLAY 'test:s_chr_chr_alphanumeric'
DISPLAY 'input:0155A01,3混合'
CALL s_chr_chr_alphanumeric('0155A01',3) RETURNING l_str
DISPLAY 'output:r_result =',l_str
DISPLAY '======================================================================'

DISPLAY '======================================================================'
DISPLAY 'test:s_chr_minus'
DISPLAY 'input:0155A01,55'
CALL s_chr_minus('0155A01','55') RETURNING l_str
DISPLAY 'output:r_chr =',l_str
DISPLAY '======================================================================'
END MAIN







