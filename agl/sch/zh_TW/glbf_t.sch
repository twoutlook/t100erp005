/* 
================================================================================
檔案代號:glbf_t
檔案名稱:間接法人工輸入金額檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table glbf_t
(
glbfent       number(5)      ,/* 企業編號 */
glbfownid       varchar2(20)      ,/* 資料所有者 */
glbfowndp       varchar2(10)      ,/* 資料所屬部門 */
glbfcrtid       varchar2(20)      ,/* 資料建立者 */
glbfcrtdp       varchar2(10)      ,/* 資料建立部門 */
glbfcrtdt       timestamp(0)      ,/* 資料創建日 */
glbfmodid       varchar2(20)      ,/* 資料修改者 */
glbfmoddt       timestamp(0)      ,/* 最近修改日 */
glbfstus       varchar2(10)      ,/* 狀態碼 */
glbfld       varchar2(5)      ,/* 帳別 */
glbf001       number(5,0)      ,/* 年度 */
glbf002       number(5,0)      ,/* 期別 */
glbf003       varchar2(10)      ,/* 群組編號 */
glbf004       varchar2(24)      ,/* 科目編號 */
glbf005       number(10,0)      ,/* 行序 */
glbf006       varchar2(80)      ,/* 說明 */
glbf007       number(20,6)      ,/* 人工輸入金額 */
glbf008       number(20,10)      ,/* 匯率(本位幣二) */
glbf009       number(20,6)      ,/* 人工輸入金額(本位幣二) */
glbf010       number(20,10)      ,/* 匯率(本位幣三) */
glbf011       number(20,6)      ,/* 人工輸入金額(本位幣三) */
glbfud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
glbfud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
glbfud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
glbfud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
glbfud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
glbfud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
glbfud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
glbfud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
glbfud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
glbfud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
glbfud011       number(20,6)      ,/* 自定義欄位(數字)011 */
glbfud012       number(20,6)      ,/* 自定義欄位(數字)012 */
glbfud013       number(20,6)      ,/* 自定義欄位(數字)013 */
glbfud014       number(20,6)      ,/* 自定義欄位(數字)014 */
glbfud015       number(20,6)      ,/* 自定義欄位(數字)015 */
glbfud016       number(20,6)      ,/* 自定義欄位(數字)016 */
glbfud017       number(20,6)      ,/* 自定義欄位(數字)017 */
glbfud018       number(20,6)      ,/* 自定義欄位(數字)018 */
glbfud019       number(20,6)      ,/* 自定義欄位(數字)019 */
glbfud020       number(20,6)      ,/* 自定義欄位(數字)020 */
glbfud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
glbfud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
glbfud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
glbfud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
glbfud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
glbfud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
glbfud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
glbfud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
glbfud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
glbfud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table glbf_t add constraint glbf_pk primary key (glbfent,glbfld,glbf001,glbf002,glbf003,glbf004,glbf005) enable validate;

create unique index glbf_pk on glbf_t (glbfent,glbfld,glbf001,glbf002,glbf003,glbf004,glbf005);

grant select on glbf_t to tiptop;
grant update on glbf_t to tiptop;
grant delete on glbf_t to tiptop;
grant insert on glbf_t to tiptop;

exit;
