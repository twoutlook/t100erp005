/* 
================================================================================
檔案代號:nmfb_t
檔案名稱:資金模擬主交易帳戶檔
檔案目的: 
上游檔案:
下游檔案:
檔案類型:B
多語系檔案:N
============.========================.==========================================
 */
create table nmfb_t
(
nmfbent       number(5)      ,/* 企業代碼 */
nmfbcomp       varchar2(10)      ,/* 法人 */
nmfb001       varchar2(10)      ,/* 交易帳戶編號 */
nmfb002       varchar2(10)      ,/* 模擬幣別 */
nmfb003       varchar2(1)      ,/* 主交易帳戶否 */
nmfbownid       varchar2(20)      ,/* 資料所有者 */
nmfbowndp       varchar2(10)      ,/* 資料所屬部門 */
nmfbcrtid       varchar2(20)      ,/* 資料建立者 */
nmfbcrtdp       varchar2(10)      ,/* 資料建立部門 */
nmfbcrtdt       timestamp(0)      ,/* 資料創建日 */
nmfbmodid       varchar2(20)      ,/* 資料修改者 */
nmfbmoddt       timestamp(0)      ,/* 最近修改日 */
nmfbstus       varchar2(10)      ,/* 狀態碼 */
nmfbud001       varchar2(40)      ,/* 自定義欄位(文字)001 */
nmfbud002       varchar2(40)      ,/* 自定義欄位(文字)002 */
nmfbud003       varchar2(40)      ,/* 自定義欄位(文字)003 */
nmfbud004       varchar2(40)      ,/* 自定義欄位(文字)004 */
nmfbud005       varchar2(40)      ,/* 自定義欄位(文字)005 */
nmfbud006       varchar2(40)      ,/* 自定義欄位(文字)006 */
nmfbud007       varchar2(40)      ,/* 自定義欄位(文字)007 */
nmfbud008       varchar2(40)      ,/* 自定義欄位(文字)008 */
nmfbud009       varchar2(40)      ,/* 自定義欄位(文字)009 */
nmfbud010       varchar2(40)      ,/* 自定義欄位(文字)010 */
nmfbud011       number(20,6)      ,/* 自定義欄位(數字)011 */
nmfbud012       number(20,6)      ,/* 自定義欄位(數字)012 */
nmfbud013       number(20,6)      ,/* 自定義欄位(數字)013 */
nmfbud014       number(20,6)      ,/* 自定義欄位(數字)014 */
nmfbud015       number(20,6)      ,/* 自定義欄位(數字)015 */
nmfbud016       number(20,6)      ,/* 自定義欄位(數字)016 */
nmfbud017       number(20,6)      ,/* 自定義欄位(數字)017 */
nmfbud018       number(20,6)      ,/* 自定義欄位(數字)018 */
nmfbud019       number(20,6)      ,/* 自定義欄位(數字)019 */
nmfbud020       number(20,6)      ,/* 自定義欄位(數字)020 */
nmfbud021       timestamp(0)      ,/* 自定義欄位(日期時間)021 */
nmfbud022       timestamp(0)      ,/* 自定義欄位(日期時間)022 */
nmfbud023       timestamp(0)      ,/* 自定義欄位(日期時間)023 */
nmfbud024       timestamp(0)      ,/* 自定義欄位(日期時間)024 */
nmfbud025       timestamp(0)      ,/* 自定義欄位(日期時間)025 */
nmfbud026       timestamp(0)      ,/* 自定義欄位(日期時間)026 */
nmfbud027       timestamp(0)      ,/* 自定義欄位(日期時間)027 */
nmfbud028       timestamp(0)      ,/* 自定義欄位(日期時間)028 */
nmfbud029       timestamp(0)      ,/* 自定義欄位(日期時間)029 */
nmfbud030       timestamp(0)      /* 自定義欄位(日期時間)030 */
);
alter table nmfb_t add constraint nmfb_pk primary key (nmfbent,nmfbcomp,nmfb001) enable validate;

create unique index nmfb_pk on nmfb_t (nmfbent,nmfbcomp,nmfb001);

grant select on nmfb_t to tiptop;
grant update on nmfb_t to tiptop;
grant delete on nmfb_t to tiptop;
grant insert on nmfb_t to tiptop;

exit;
